# selfUpdate
 15/FEB/2020 - Add this to any AutoHoyKey program and you'll be able to self update when a new version is detected!


reg file

	[HKEY_CURRENT_USER\SOFTWARE\selfUpdate]
	"location"="C:\\selfUpdate\\\\newversion"

current.ver file

	0.2

Sample log output

	[19/01/22 21:10:52] Checking for updates
	[19/01/22 21:10:52] New version 0.2 available - replacing version 0.1
	[19/01/22 21:10:52] Renamed updater.ahk to old_updater.ahk successfully
	[19/01/22 21:10:52] Copied file from server successfully
	[19/01/22 21:10:52] Removed .old file
	[19/01/22 21:10:52] Checking for updates
	[19/01/22 21:10:52] Latest version already installed