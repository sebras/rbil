@ECHO off > \dev\nul
ECHO off > \dev\nul
IF NOT ""=="%batdbg%" ECHO %batdbg%
IF "%@Eval[2+2]"=="4" LOADBTM on > \dev\nul
REM ###########################################################################
REM COMBINE.BAT v1.05 by Ralf Brown & Matthias Paul (09/95, 01/96, 02/96)
REM
REM This job will combine the pieces of the interrupt list to the file
REM INTERRUP.LST.
REM If you're running out of free disk space for a complete copy of the whole
REM interrupt list, try running COMBINE.BAT with optional parameter 'L'. This
REM will combine the files into INTERRUP.LST while destroying the original
REM files, thus needing only a very small swapping area. The space needed is
REM generally of the same amount as the biggest seperate file to be combined,
REM but depending on the implementation of the COPY command and the memory &
REM disk space available, the exact amount may vary from zero up to the full
REM interrupt list's size!
REM If you're having trouble resulting in corrupted files, but have enough
REM swap space, try optional parameter 'T', explicitly using a temporary swap
REM file. This will double the maximum amount of swap space needed by each
REM method.
REM
REM Syntax: COMBINE [L or C] [T]
REM
REM  not 'L' or 'C' = Combine (non destructive).
REM  'L'            = Low space combination (destructive).
REM  'C'            = Continue after error when combining with 'L' option.
REM
REM  not 'T'        = Use standard COPY management (generally no problems).
REM  'T'            = Explicit usage of a temporary swap file (saver).
REM                   Doubles the swap space needed.
REM
REM Needs DOS v3.0+. Takes advantage of NWDOS/DRDOS & 4DOS/NDOS, if installed.
REM Lines like "ECHO  " do contain an invisible ASCII 255 character. Variable
REM %Temp% generally may not end with "\", if necessary use "\." instead!
REM A variable %SwitChar% can be used to indicate a changed SwitChar.
REM
REM "!!!" indicating necessary changes with count of files or max. file size!
REM ###########################################################################

BREAK off
REM Scanning for tokens:
IF "_Std_"=="%1" GOTO combine
IF "_Del_"=="%1" GOTO combine
IF "_Brk_"=="%1" GOTO break

REM Checking system:
IF NOT "DRDOS"=="%Os%" IF NOT "NWDOS"=="%Os%" IF "%@Eval[2+2]%"=="4" IF %_DosVer% LT 3.0 GOTO olddos > \dev\nul
IF "%@Eval[2+2]%"=="4" IF %_Env% LT 9 GOTO lowenv > \dev\nul
SET Tmp_=123456789 > \dev\nul
IF NOT "%Tmp_%"=="123456789" GOTO lowenv
SET Tmp_=
IF NOT ""=="%Temp%" GOTO tmp_ok
SET Temp=%Tmp%
IF NOT "%Temp%"=="%Tmp%" SET Temp=
:tmp_ok

IF NOT "4"=="%@Eval[2+2]%" GOTO no4dos
ECHOS SET %=s> %Temp%\swc.btm
SETDOS | @FIND "SWITCH=" >> %Temp%\swc.btm
@CALL %Temp%\swc.btm > \dev\nul
DEL %Temp%\swc.btm > \dev\nul
:no4dos
IF ""=="%switch%" SET switch=%switchar%
IF "4"=="%@Eval[2+2]%" IF %_Env% LT 9 GOTO lowenv
SET Tmp_=123456789 > \dev\nul
IF NOT "%Tmp_%"=="123456789" GOTO lowenv
SET Tmp_=
IF ""=="%switch%" SET switch=/

REM Scanning for parameters and setting up variables:
SET Met_=
FOR %%x IN (t T %switch%t %switch%T) DO FOR %%y IN (%1 %2 %3) DO IF "%%x"=="%%y" SET Met_=tmp
IF ""=="%Met_%" SET Met_=mem
IF NOT "tmp"=="%Met_%" IF NOT "mem"=="%Met_%" GOTO lowenv
SET Dir_=
IF NOT "tmp"=="%Met_%" IF NOT "%@Eval[2+2]%"=="4" GOTO no_tmp
IF "%@InStr[%@Len[%Temp%]%,1,%Temp%]%"=="\" IF %_Env% LT 7 GOTO lowenv
IF NOT "%@InStr[%@Len[%Temp%]%,1,%Temp%]%"=="\" GOTO no_tmp
SET Dir_=.
IF NOT "%Dir_%"=="." GOTO lowenv > \dev\nul
:no_tmp
FOR %%x IN (c C %switch%c %switch%C) DO FOR %%y IN (%1 %2 %3) DO IF "%%x"=="%%y" GOTO skip

REM Checking interrupt list pieces:
REM !!! [Changes necessary, if count of interrupt list files changes:]
FOR %%a IN (a b c d e f g h i j k l m n) DO IF NOT EXIST interrup.%%a GOTO missing

REM Scanning for parameters, again:
FOR %%x IN (l L %switch%l %switch%L) DO FOR %%y IN (%1 %2 %3) DO IF "%%x"=="%%y" GOTO lowspace

ECHO Combining the pieces of the interrupt list...
ECHO ÿ
IF NOT "%@Eval[2+2]%"=="4" GOTO ok_mem
REM Continueing with less space indicated may still work on compressed drives.
IF %@FileSize[interrup.?,b]% LE %@DiskFree[%_Disk%:,b]% GOTO ok_%Met_% > \dev\nul
ECHO Warning: Obviously less space on drive for INTERRUP.LST! [Ctrl-C aborts.]
GOTO pause

:ok_tmp
ECHO _> %Temp%%Dir_%\interrup.tmp
IF %@FileSize[interrup.?,b]% GT %@DiskFree[%@InStr[1,2,%@TrueName[%Temp%%Dir_%\interrup.tmp]%]%,b]% GOTO notok_tmp > \dev\nul
IF NOT "%@InStr[1,2,%@TrueName[%Temp%%Dir_%\interrup.tmp]%]%"=="%_Disk%:" GOTO ok_mem > \dev\nul
IF %@Eval[2*%@FileSize[interrup.?,b]%]% LE %@DiskFree[%_Disk%:,b]% GOTO ok_mem > \dev\nul
:notok_tmp
IF EXIST %Temp%%Dir_%\interrup.tmp DEL %Temp%%Dir_%\interrup.tmp > \dev\nul
ECHO Warning: Possibly less swapping space! [Ctrl-C aborts.]
:pause
PAUSE

:ok_mem
IF EXIST %Temp%%Dir_%\interrup.tmp DEL %Temp%%Dir_%\interrup.tmp > \dev\nul

REM Needs a minimum free disk space of the same size as the seperated files.
IF EXIST interrup.lst DEL interrup.lst > \dev\nul
COPY interrup.a interrup.lst
REM !!! [Changes necessary, if count of interrupt list files changes:]
FOR %%a IN (b c d e f g h i j k l m n) DO %ComSpec% %switch%c %0 _Std_ interrup.%%a %Met_%
GOTO end

:skip
ECHO Resuming destructive interrupt list concatenation....
ECHO ÿ
IF EXIST interrup.lst GOTO continue
ECHO INTERRUP.LST file does not exist. Cannot continue.
ECHO [If you have tried option 'L' before, concatenate the files manually.]
GOTO exit

:lowspace
ECHO Combining the pieces of the interrupt list (destructive)...
ECHO ÿ
IF EXIST interrup.lst DEL interrup.lst > \dev\nul

:continue
IF NOT "%@Eval[2+2]%"=="4" GOTO lsok
ECHO _> %Temp%%Dir_%\interrup.tmp
GOTO lsok_%Met_%
:lsok_tmp
IF %@DiskFree[%@InStr[1,2,%@TrueName[%Temp%%Dir_%\interrup.tmp]%]%,b]% GT %@FileSize[interrup.?;interrup.ls?[t],b]% GOTO lsok > \dev\nul
ECHO Warning: Possibly less swapping space! [Ctrl-C aborts.]
GOTO lspause
:lsok_mem
REM !!! [Changes necessary in next two lines, if maximum seperate file length exceeds 360KB:]
IF %@DiskFree[%_Disk%:,K]% GE 360 GOTO lsok > \dev\nul
IF %@DiskFree[%@InStr[1,2,%@TrueName[%Temp%%Dir_%\interrup.tmp]%]%,K]% GE 360 GOTO lsok > \dev\nul
ECHO Warning: Possibly less swapping space! [Ctrl-C aborts.]
:lspause
IF EXIST %Temp%Dir_%%\interrup.tmp DEL %Temp%%Dir_%\interrup.tmp > \dev\nul
PAUSE
:lsok
IF EXIST %Temp%%Dir_%\interrup.tmp DEL %Temp%%Dir_%\interrup.tmp > \dev\nul

IF EXIST interrup.a REN interrup.a interrup.lst > \dev\nul
REM !!! [Changes necessary, if count of interrupt list files changes:]
FOR %%a IN (b c d e f g h i j k l m n) DO %ComSpec% %switch%c %0 _Del_ interrup.%%a %Met_%
ECHO Original separated files are now deleted.
GOTO end

REM ### Combine management (recursive level 1) ################################

:combine
IF NOT EXIST %2 GOTO exit
IF NOT "tmp"=="%3" IF NOT "mem"=="%3" GOTO overflow
GOTO copy_%3


REM ### COPY subroutines ######################################################

:copy_mem
REM General COPY command:
REM Some implementations have problems combining files to itself.
REM In such cases use parameter 'T' to select alternative copy routine.
COPY %switch%b %switch%v interrup.lst+%2 interrup.lst
REM If some (external) COPY implementation may set a non-zero ErrorLevel
REM without an error occuring, then comment out the following line.
IF ERRORLEVEL 1 GOTO error
GOTO copy_end

:copy_tmp
REM COPY command with explicit usage of a temporary file:
REM Some COPY-implementations have problems combining files to itself.
REM Explicit usage of a temporary file generally needs twice as much swap
REM space as of the standard routine.
IF EXIST %Temp%%Dir_%\interrup.tmp DEL %Temp%%Dir_%\interrup.tmp > \dev\nul
COPY %switch%b %switch%v interrup.lst+%2 %Temp%%Dir_%\interrup.tmp
REM If some (external) COPY implementation may set a non-zero ErrorLevel
REM without an error occuring, then comment out the following line.
IF ERRORLEVEL 1 GOTO error
IF EXIST %Temp%%Dir_%\interrup.tmp IF EXIST interrup.lst DEL interrup.lst > \dev\nul
IF EXIST %Temp%%Dir_%\interrup.tmp IF NOT EXIST interrup.lst COPY %switch%b %Temp%%Dir_%\interrup.tmp interrup.lst
IF EXIST %Temp%%Dir_%\interrup.tmp IF EXIST interrup.lst DEL %Temp%%Dir_%\interrup.tmp > \dev\nul
:copy_end
IF "_Del_"=="%1" DEL %2 > \dev\nul
GOTO exit


REM ### Error & Exit management ###############################################

:overflow
ECHO Environment full or path to file too long!
IF NOT EXIST interrup.a IF EXIST interrup.b IF EXIST interrup.lst REN interrup.lst interrup.a > \dev\nul
GOTO stop

:error
ECHO Error occured during file combination! (Less space available?)
:stop
REM Don't continue, so stop recursion...
%0 _Brk_ %1

:break
ECHO Processing aborted.
IF "_Std_"=="%2" GOTO exit
ECHO [If INTERRUP.LST is valid so far, try parameter 'C' to continue after
ECHO solving error condition.]
GOTO reset

:missing
ECHO Some sections of the interrupt list are missing!
GOTO reset

:olddos
ECHO This old DOS version cannot run this job without modifications!
ECHO Consider to update your system or concatenate manually.
GOTO exit

:lowenv
SET Tmp_=
ECHO Not enough environment space available! (Running in a shell?)
ECHO Check files: CONFIG.SYS SHELL=.. /E:bytes and 4DOS.INI ENVIRONMENT=, ENVFREE=.
GOTO reset

:end
ECHO The interrupt list has now been combined into INTERRUP.LST.

:reset
SET Met_=
SET Dir_=
SET Switch=

:exit
REM These dummies in the last two lines avoid a parser-bug occuring
REM in an older MS-DOS COMMAND.COM release.
