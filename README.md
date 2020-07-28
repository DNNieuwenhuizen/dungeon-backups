# dungeon-backups

## Description
Since Minecraft Dungeons can randomly crash which sometimes causes your character to dissappear (like it happened to me), I created a script that starts Minecraft Dungeons and makes a rolling back up of the safe files. It makes a backup every minute and keeps the last 30 minutes. It copies the files from "%HOMEPATH%\Saved Games\Mojang Studios\Dungeons" and places them in a newly created folder at "%HOMEPATH%\Saved Games\Minecraft Dungeons Backups". So for this to work all that needs to be done is use this script as the launcher of the game and in case of a crash, replace the broken save files with the back up files.

## Running the script
1. Download the file and place it wherever you want.
2. Whenever you want to play Minecraft Dungeons. Right click the file and select "Run with Powershell", which launches the game and makes backups. (**_Don't close the powershell application if you want it to work_**)

## Restoring a character
1. Press windows key + r  
2.  Insert the following: "%HOMEPATH%\Saved Games\Minecraft Dungeons Backups"
3. Press enter
4. Pick a backup you want to use.
5. Copy the folder inside the backup folder
5. Replace the folder at "%HOMEPATH%\Saved Games\Mojang Studios\Dungeons" with the identically named folder inside the backup folder.
