tell application "Pages"
	set docxFile to POSIX file "/Users/mk/Documents/01_Active_Work/obsidian/Cloud-Engineering-Vault/Trackers/Terraform_Habit_Tracker_Landscape.docx"
	set newDoc to open docxFile
	delay 3
	set pagesFile to POSIX file "/Users/mk/Documents/01_Active_Work/obsidian/Cloud-Engineering-Vault/Trackers/Terraform_Habit_Tracker_Landscape.pages"
	save newDoc in pagesFile
	close newDoc
end tell
