rem Donkey Kong Junior (USA Set F-2) - dkongjr.zip required

@echo off

set zip=dkongjr.zip
set ifiles=djr1-c_5b_f-2.5b+djr1-c_5c_f-2.5c+djr1-c_5e_f-2.5e+djr1-v.3p+djr1-v.3n+djr1-c_5b_f-2.5b+djr1-v_7c.7c+djr1-v_7c.7c+djr1-v_7d.7d+djr1-v_7d.7d+djr1-v_7e.7e+djr1-v_7e.7e+djr1-v_7f.7f+djr1-v_7f.7f+djr1-c_3h.3h+djr1-c-2e.2e+djr1-c-2f.2f+djr1-v-2n.2n+..\empty.bin+..\dkj_wave.bin
set ofile=a.dkongj.rom

rem =====================================
setlocal ENABLEDELAYEDEXPANSION

set pwd=%~dp0
echo.
echo.

if EXIST %zip% (

	!pwd!7za x -otmp %zip%
	if !ERRORLEVEL! EQU 0 ( 
		cd tmp

		copy /b/y %ifiles% !pwd!%ofile%
		if !ERRORLEVEL! EQU 0 ( 
			echo.
			echo ** done **
			echo.
			echo Copy "%ofile%" into root of SD card
		)
		cd !pwd!
		rmdir /s /q tmp
	)

) else (

	echo Error: Cannot find "%zip%" file
	echo.
	echo Put "%zip%", "7za.exe" and "%~nx0" into the same directory
)

echo.
echo.
pause
