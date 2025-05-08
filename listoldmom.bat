@echo off
setlocal enabledelayedexpansion

set "output_file=uuids.txt"
echo. > "%output_file%"

REM Clean up deleted hard disks from VirtualBox
REM C:\Program Files\Vektor T13\VirtualBox>vboxmanage list hdds >> %userprofile%\Desktop\hdds.txt

for /f "tokens=1,2 delims=: " %%A in ('""C:\Program Files\Vektor T13\VirtualBox\vboxmanage" list hdds"') do (
    if /i "%%A"=="UUID" set "uuid=%%B"
    if /i "%%A"=="State" if /i "%%B"=="inaccessible" set "flag_state=1"

    if defined flag_state (
        for /f "delims=" %%X in ("!uuid!") do echo %%X >> "%output_file%"
        set "flag_state="
    )
)

echo UUIDs extracted and trimmed successfully. Check %output_file%.