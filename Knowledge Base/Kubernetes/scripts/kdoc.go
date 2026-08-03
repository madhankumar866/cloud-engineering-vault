// Package main implements kdoc, a high-performance concurrent command-line utility
// designed for offline searching of official Kubernetes documentation and canonical
// YAML manifests. Engineered for Kubestronaut study workflows and air-gapped simulation.
package main

import (
	"bufio"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strings"
	"sync"
)

const (
	colorReset = "\033[0m"
	colorGreen = "\033[32m"
	colorBlue  = "\033[34m"
	colorYellow = "\033[33m"
	colorCyan  = "\033[36m"
)

type SearchResult struct {
	FilePath   string
	LineNumber int
	Content    string
}

func getDocsRoot() string {
	if env := os.Getenv("K8S_DOCS_DIR"); env != "" {
		return env
	}
	home, err := os.UserHomeDir()
	if err != nil {
		return "."
	}
	return filepath.Join(home, ".local", "share", "k8s-offline-docs")
}

func main() {
	docsDir := flag.String("dir", getDocsRoot(), "Root directory of offline Kubernetes docs repository")
	dump := flag.Bool("dump", false, "Dump full content of matched YAML examples")
	maxResults := flag.Int("n", 30, "Maximum search results to display")
	flag.Parse()

	args := flag.Args()
	if len(args) < 2 {
		printUsage()
		os.Exit(1)
	}

	command := args[0]
	query := args[1]

	switch command {
	case "search", "s":
		runSearch(*docsDir, query, *maxResults)
	case "yaml", "y":
		runYamlSearch(*docsDir, query, *dump)
	case "list", "l":
		runYamlList(*docsDir, query)
	default:
		fmt.Printf("Unknown command: %s\n", command)
		printUsage()
		os.Exit(1)
	}
}

func printUsage() {
	fmt.Println("🚀 kdoc - Fast Offline Kubernetes Documentation & Manifest Tool")
	fmt.Println("Usage:")
	fmt.Println("  kdoc search <regex>     - Concurrently search docs and examples for regex pattern")
	fmt.Println("  kdoc yaml <keyword>     - Find and display matching canonical YAML manifest files")
	fmt.Println("  kdoc yaml <keyword> -dump - Dump complete contents of matching YAML files")
	fmt.Println("  kdoc list <kind>        - List all example manifests matching a specific Resource Kind (e.g. Pod, NetworkPolicy)")
	fmt.Println("\nEnvironment:")
	fmt.Printf("  K8S_DOCS_DIR: %s\n", getDocsRoot())
}

func runSearch(root, query string, max int) {
	re, err := regexp.Compile("(?i)" + query)
	if err != nil {
		fmt.Printf("Invalid regex query: %v\n", err)
		os.Exit(1)
	}

	results := make(chan SearchResult, 100)
	var wg sync.WaitGroup
	fileChan := make(chan string, 100)

	// Start worker pool (8 workers for concurrent file IO)
	for i := 0; i < 8; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for path := range fileChan {
				searchFile(path, re, results)
			}
		}()
	}

	// Result printer goroutine
	done := make(chan bool)
	count := 0
	go func() {
		for res := range results {
			count++
			if count <= max {
				rel, _ := filepath.Rel(root, res.FilePath)
				fmt.Printf("%s%s%s:%s%d%s: %s\n", colorBlue, rel, colorReset, colorGreen, res.LineNumber, colorReset, strings.TrimSpace(res.Content))
			}
		}
		done <- true
	}()

	// Walk directory
	searchRoot := filepath.Join(root, "content", "en")
	filepath.Walk(searchRoot, func(path string, info os.FileInfo, err error) error {
		if err != nil || info.IsDir() {
			return nil
		}
		ext := filepath.Ext(path)
		if ext == ".md" || ext == ".yaml" || ext == ".yml" {
			fileChan <- path
		}
		return nil
	})
	close(fileChan)

	wg.Wait()
	close(results)
	<-done

	if count > max {
		fmt.Printf("\n%sShowing first %d results (found %d total matching lines). Be more specific to narrow search.%s\n", colorYellow, max, count, colorReset)
	} else if count == 0 {
		fmt.Println("No matches found.")
	}
}

func searchFile(path string, re *regexp.Regexp, results chan<- SearchResult) {
	file, err := os.Open(path)
	if err != nil {
		return
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	lineNum := 1
	for scanner.Scan() {
		line := scanner.Text()
		if re.MatchString(line) {
			results <- SearchResult{
				FilePath:   path,
				LineNumber: lineNum,
				Content:    line,
			}
		}
		lineNum++
	}
}

var k8sAliases = map[string][]string{
	"netpol": {"networkpolicy", "network-policy"},
	"deploy": {"deployment"},
	"svc":    {"service"},
	"sa":     {"serviceaccount", "service-account"},
	"pvc":    {"persistentvolumeclaim", "claim"},
	"pv":     {"persistentvolume", "volume"},
	"ing":    {"ingress"},
	"cm":     {"configmap", "config-map"},
	"ds":     {"daemonset", "daemon-set"},
	"sts":    {"statefulset", "stateful-set"},
}

func runYamlSearch(root, keyword string, dump bool) {
	examplesRoot := filepath.Join(root, "content", "en", "examples")
	kw := strings.ToLower(keyword)
	searchTerms := []string{kw}
	if expanded, ok := k8sAliases[kw]; ok {
		searchTerms = append(searchTerms, expanded...)
	}

	matches := []string{}
	filepath.Walk(examplesRoot, func(path string, info os.FileInfo, err error) error {
		if err != nil || info.IsDir() {
			return nil
		}
		if strings.HasSuffix(path, ".yaml") || strings.HasSuffix(path, ".yml") {
			base := strings.ToLower(info.Name())
			matched := false
			for _, term := range searchTerms {
				if strings.Contains(base, term) {
					matched = true
					break
				}
			}
			if !matched {
				if content, err := os.ReadFile(path); err == nil {
					lowerContent := strings.ToLower(string(content))
					for _, term := range searchTerms {
						if strings.Contains(lowerContent, "kind: "+term) || strings.Contains(lowerContent, "kind: "+strings.ReplaceAll(term, "-", "")) {
							matched = true
							break
						}
					}
				}
			}
			if matched {
				matches = append(matches, path)
			}
		}
		return nil
	})

	if len(matches) == 0 {
		fmt.Printf("No YAML examples found matching keyword: %s\n", keyword)
		return
	}

	fmt.Printf("%s🎯 Found %d canonical YAML manifests matching '%s':%s\n\n", colorGreen, len(matches), keyword, colorReset)
	for i, match := range matches {
		rel, _ := filepath.Rel(root, match)
		fmt.Printf(" [%d] %s%s%s\n", i+1, colorCyan, rel, colorReset)
		if dump || len(matches) == 1 {
			printFileContents(match)
		}
	}
	if !dump && len(matches) > 1 {
		fmt.Printf("\n💡 Tip: Run 'kdoc yaml %s --dump' to view full file contents, or specify a more exact keyword.\n", keyword)
	}
}

func runYamlList(root, kind string) {
	examplesRoot := filepath.Join(root, "content", "en", "examples")
	re, err := regexp.Compile(`(?m)^kind:\s*` + kind + `\s*$`)
	if err != nil {
		fmt.Printf("Invalid resource kind syntax: %v\n", err)
		return
	}

	fmt.Printf("🔍 Scanning for manifests of Kind: %s%s%s...\n\n", colorCyan, kind, colorReset)
	found := 0
	filepath.Walk(examplesRoot, func(path string, info os.FileInfo, err error) error {
		if err != nil || info.IsDir() {
			return nil
		}
		if strings.HasSuffix(path, ".yaml") || strings.HasSuffix(path, ".yml") {
			content, err := os.ReadFile(path)
			if err == nil && re.Match(content) {
				rel, _ := filepath.Rel(root, path)
				fmt.Printf("  📦 %s\n", rel)
				found++
			}
		}
		return nil
	})

	if found == 0 {
		fmt.Printf("No examples found with kind: %s\n", kind)
	} else {
		fmt.Printf("\n%sTotal %d canonical examples found.%s\n", colorGreen, found, colorReset)
	}
}

func printFileContents(path string) {
	content, err := os.ReadFile(path)
	if err != nil {
		return
	}
	fmt.Printf("%s--- START MANIFEST (%s) ---%s\n", colorYellow, filepath.Base(path), colorReset)
	fmt.Println(strings.TrimSpace(string(content)))
	fmt.Printf("%s--- END MANIFEST ---%s\n\n", colorYellow, colorReset)
}
