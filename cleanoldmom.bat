@echo off
setlocal enabledelayedexpansion

set "input_file=uuids.txt"
set "count=0"

echo Processing UUIDs from bottom first...
REM Clean up deleted hard disks from VirtualBox
REM If error 1 child... manual delete VMs folder on Disk then run listoldmom agains
REM Read uuids.txt in reverse order and skip empty lines
for /f "delims=" %%A in ('powershell -Command "& { $lines = Get-Content '%input_file%'; $lines = $lines | Where-Object {$_ -ne ''}; [array]::Reverse($lines); $lines | ForEach-Object {$_} }"') do (
    echo Closing medium disk %%A...
    "C:\Program Files\Vektor T13\VirtualBox\vboxmanage" closemedium disk %%A --delete
	set /a count+=1
)

echo Total UUIDs processed: %count%
