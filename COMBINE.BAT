@ECHO off
REM ---------------------------------------------------------------------------
REM COMBINE.BAT v1.01 by Ralf Brown, enhanced 17.09.95 by Matthias Paul
REM
REM If you're running out of free disk space for a complete copy of the whole
REM interrupt list, try running COMBINE.BAT with optional parameter 'L'. This
REM will combine the files into INTERRUP.LST while destroying the original
REM files, thus needing only a very small swapping area (of the same amount as
REM the biggest seperate file to be combined).
REM
REM Optional parameters:
REM  'L'  = Low space combination (destructive)
REM  'CL' = Continue after error when combining with 'Low space' option
REM ---------------------------------------------------------------------------
IF "_recurs_"=="%1" GOTO concat
IF "_break_"=="%1" GOTO break
IF "CL"=="%1" GOTO skip
IF "cl"=="%1" GOTO skip
IF "cL"=="%1" GOTO skip
IF "Cl"=="%1" GOTO skip
FOR %%a IN (a b c d e f g h i j k l m n) DO IF NOT EXIST interrup.%%a GOTO missing
IF "L"=="%1" GOTO lowspace
IF "l"=="%1" GOTO lowspace
ECHO Combining the pieces of the interrupt list...
ECHO.
REM Needs a minimum free disk space of the same size as the seperated files (ca. 4MB).
COPY interrup.a interrup.lst >nul
FOR %%a IN (b c d e f g h i j k l m n) DO COPY /b interrup.lst+interrup.%%a interrup.lst >nul
GOTO end

:skip
ECHO Resuming destructive interrupt list concatenation....
ECHO.
IF EXIST interrup.lst GOTO continue
ECHO INTERRUP.LST file does not exist. Cannot continue.
ECHO (If you have tried option 'L' before, concatenate the files manually.)
GOTO exit

:lowspace
REM Still needs a minimum of ca. 360KB free disk space for swapping.
ECHO Combining the pieces of the interrupt list (destructive)...
ECHO.
IF EXIST interrup.lst DEL interrup.lst >nul
:continue
IF EXIST interrup.a REN interrup.a interrup.lst >nul
FOR %%a IN (b c d e f g h i j k l m n) DO IF EXIST interrup.%%a CALL %0 _recurs_ interrup.%%a
ECHO Original separated files are now deleted.
GOTO end

:concat
IF NOT EXIST %2 GOTO end
COPY /b interrup.lst+%2 interrup.lst >nul
REM If some DOS version may set ErrorLevel > 0 without an error occuring,
REM then comment out the following line.
IF ERRORLEVEL 1 GOTO error
DEL %2 >nul
REM Returning to caller...
GOTO exit

:error
ECHO Error occured during file combination. (Less space available?)
REM Don't continue, so stop recursion...
combine.bat _break_
:break
ECHO Processing aborted.
ECHO (If INTERRUP.LST is valid so far, try parameter 'CL' to continue after
ECHO  solving error condition.)
GOTO exit

:missing
ECHO Some sections of the interrupt list are missing.
GOTO exit

:end
ECHO The interrupt list has now been combined into INTERRUP.LST.

:exit
REM These dummies in the last two lines avoid a parser-bug occuring
REM in an older MS-DOS COMMAND.COM release.
