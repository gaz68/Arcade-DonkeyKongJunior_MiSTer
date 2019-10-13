---------------------------------------------------------------------------------
-- 
-- Arcade: Donkey Kong Junior port to MiSTer by gaz68 (https://github.com/gaz68)
-- 12 October 2019
-- 
-- Original Donkey Kong port to MiSTer by Sorgelig
-- 18 April 2018
-- 
---------------------------------------------------------------------------------
-- 
-- dkong Copyright (c) 2003 - 2004 Katsumi Degawa
-- T80   Copyright (c) 2001-2002 Daniel Wallner (jesus@opencores.org) All rights reserved
-- T48   Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org) All rights reserved
-- 
---------------------------------------------------------------------------------
-- 
-- Support screen and controls rotation on HDMI output.
-- Only controls are rotated on VGA output.
-- 
--
-- Keyboard inputs :
--
--   F2          : Coin + Start 2 players
--   F1          : Coin + Start 1 player
--   SPACE       : Jump
--   UP,DOWN,LEFT,RIGHT arrows : Movements
--
-- MAME/IPAC/JPAC Style Keyboard inputs:
--   5           : Coin 1
--   6           : Coin 2
--   1           : Start 1 Player
--   2           : Start 2 Players
--   R,F,D,G     : Player 2 Movements (Cocktail mode only)
--   A           : Player 2 Fire (Cocktail mode only)
--
--
-- Joystick support.
--  
---------------------------------------------------------------------------------

                                *** Attention ***

ROM is not included. In order to use this arcade, you need to provide a correct ROM file.

---------------------------------------------------------------------------------
NOTE: 3 versions of this game are supported - USA, Japan and Japan Set F-1.
      Build your favourite version. The screens for the USA version play in 
      a different order to the Japanese versions.
      Build all 3 versions, name them differently and they can be loaded
      manually using the Load *.ROM option (press F12).
---------------------------------------------------------------------------------

Find this zip file somewhere. You need to find the file exactly as required.
Do not rename other zip files even if they also represent the same game - they are not compatible!
The name of zip is taken from M.A.M.E. project, so you can get more info about
hashes and contained files there.

To generate the ROM using Windows:
1) Copy the zip into "releases" directory
2) Execute bat file - it will show the name of zip file containing required files.
3) Put required zip into the same directory and execute the bat again.
4) If everything will go without errors or warnings, then you will get the a.*.rom file.
5) Copy generated a.*.rom into root of SD card along with the Arcade-*.rbf file

To generate the ROM using Linux/MacOS:
1) Copy the zip into "releases" directory
2) Execute build_rom.sh
3) Copy generated a.*.rom into root of SD card along with the Arcade-*.rbf file

To generate the ROM using MiSTer:
1) scp "releases" directory along with the zip file onto MiSTer:/media/fat/
2) Using OSD execute build_rom.sh
3) Copy generated a.*.rom into root of SD card along with the Arcade-*.rbf file
