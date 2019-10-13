rem Donkey Kong Junior (Japan) - dkongjrj.zip required

@echo off

set zip=dkongjrj.zip
set ifiles=c_5ba.bin+c_5ca.bin+c_5ea.bin+v_3pa.bin+v_3na.bin+c_5ba.bin+v_7c.bin+v_7c.bin+v_7d.bin+v_7d.bin+v_7e.bin+v_7e.bin+v_7f.bin+v_7f.bin+c_3h.bin+c-2e.bpr+c-2f.bpr+v-2n.bpr+..\empty.bin+..\dkj_wave.bin
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
