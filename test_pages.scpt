tell application "Pages"
	set doc to open POSIX file "/Users/mk/Documents/01_Active_Work/obsidian/Cloud-Engineering-Vault/Trackers/VPC_Habit_Tracker_Landscape.pages"
	delay 2
	tell doc
		set allTables to every table of every item
		return count of allTables
	end tell
end tell
