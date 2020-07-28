$current_time = Get-Date -Format "yyyy_MM_dd HHmm"
$Process_end = 0
[string]$mc_dung = "$Home\Saved Games\Minecraft Dungeons Backups"
[string]$backup_loc = "$Home\Saved Games\Minecraft Dungeons Backups\$current_time"
[string]$save_file_loc = "$Home\Saved Games\Mojang Studios\Dungeons"

# Check if the directory exist and if not, create one.
function Create_Directory {
    param($Location)
    if (-not (Test-Path -LiteralPath $Location)) {
        try {
              New-Item -Path $Location -ItemType Directory -ErrorAction Stop | Out-Null
        }
        catch {
             Write-Error -Message "Unable to create directory '$Location'. Error was: $_" -ErrorAction Stop
        }
    }
}

# Creates a new folder and copies the files that require a back up
function Create_backup {
    $current_time = Get-Date -Format "yyyy_MM_dd HHmm"
    [string]$backup_loc = "$Home\Saved Games\Minecraft Dungeons Backups\$current_time"
    if ($process_end -eq 1) {
       [string]$backup_loc = $backup_loc + " game-close"
    }
    Create_Directory -Location $backup_loc
    Get-ChildItem -Path $save_file_loc | Copy-Item -Destination $backup_loc -Recurse
}

# Limit the amount of backups to 30
function Limit_backups {
    $backups = Get-ChildItem -path $mc_dung -Force
    while($backups.count -gt 30){
        Remove-Item -Recurse -Force $backups[0].fullname
        $backups = Get-ChildItem -path $mc_dung -Force
    }
}    

# Create the Directories and create a first backup.
Create_Directory -Location $mc_dung
Create_Directory -Location $backup_loc
Create_Backup

# Start the game.
explorer.exe shell:appsFolder\Microsoft.Lovika_8wekyb3d8bbwe!Game

# Wait for the process to start and get the value, then wait 10 minutes.
Start-Sleep -s 10
$dungeons = Get-Process Dungeons -ErrorAction SilentlyContinue

# Backup every 1 minute while Minecraft dungeons is active.
$sleep_timer = 0
While($dungeons) {
    while($sleep_timer -lt 60){
        $sleep_timer = $sleep_timer + 1
        Start-Sleep -s 1
        $dungeons = Get-Process Dungeons -ErrorAction SilentlyContinue
        if(-not $dungeons){
            "Application closed"
            $process_end = 1
            break
        }
    }
    Create_backup
    Limit_backups
    $sleep_timer = 0
}
