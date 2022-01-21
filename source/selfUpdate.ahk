;Written by KramWell - 15/FEB/2020
;Add this to any AutoHoyKey program and you'll be able to self update when a new version is detected!

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

FormatTime, TimeString, A_Now, dd/MM/yy HH:mm:ss

oldPath := A_ScriptFullPath ".old"
outputFile := A_ScriptDir "\updater-out.log"

VersionNo := "0.1"

	RegRead, pathToUpdater, HKEY_CURRENT_USER, SOFTWARE\selfUpdate, location
	if (pathToUpdater){

		;FileDelete, %oldPath%
		FileRead, NewVerToCheck, %pathToUpdater%\current.ver

		if (NewVerToCheck){
		


			FileAppend, [%TimeString%] Checking for updates`n, %outputFile%
			
			if (NewVerToCheck > VersionNo){

				FileAppend, [%TimeString%] New version %NewVerToCheck% available - replacing version %VersionNo%`n, %outputFile%		
				FileMove, %A_ScriptFullPath%, %oldPath%, 1
				if (ErrorLevel = 0){
					FileAppend, [%TimeString%] Renamed %A_ScriptName% to old_%A_ScriptName% successfully`n, %outputFile%	
					FileCopy, %pathToUpdater%\%A_ScriptName%, %A_ScriptDir%\%A_ScriptName%, 1
					if (ErrorLevel = 0){
						FileAppend,[%TimeString%] Copied file from server successfully`n, %outputFile%
						Reload
					}else{
						FileAppend, [%TimeString%] ERROR copying file from server`n, %outputFile%
						FileMove, %oldPath%, %A_ScriptFullPath%, 1
						ExitApp
						;could not copy file; move file back.
					}
				}else{
					;could not rename file
					FileAppend, [%TimeString%] ERROR moving file to old_`n, %outputFile%
					ExitApp
				}			
			}else{
			FileAppend, [%TimeString%] Latest version already installed`n, %outputFile%	
			}
		}else{
			FileAppend, [%TimeString%] Could not check for updates`n, %outputFile%
		}
	}else{
		FileAppend, [%TimeString%] Could not find regkey to update path`n, %outputFile%	
	}
;############################################

if FileExist(oldPath)
	{
		FileDelete, %oldPath% ;delete old app if exists
		FileAppend, [%TimeString%] Removed .old file`n, %outputFile%	
		Sleep, 5000	
	}