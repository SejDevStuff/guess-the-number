@Echo Off
mode con cols=100 lines=35
title Guess the number : Choosing digits
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)
cls
echo Welcome to guess the number!
echo The program will now generate a 5 digit number.
echo.
echo Warning! This process may take several minutes. Press any key to start generating numbers.
pause>nul
echo [%date%, %time%] Choosing Digits >> NUMBERS.history
goto choosenumd1
:choosenumd1
cls
echo %d1%
set /a d1=%RANDOM%
if %d1% GTR 9 goto choosenumd1
if %d1% LSS 0 goto choosenumd1
goto choosenumd2
:choosenumd2
cls
echo %d2%
set /a d2=%RANDOM%
if %d2% GTR 9 goto choosenumd2
if %d2% LSS 0 goto choosenumd2
goto choosenumd3
:choosenumd3
cls
echo %d3%
set /a d3=%RANDOM%
if %d3% GTR 9 goto choosenumd3
if %d3% LSS 0 goto choosenumd3
goto choosenumd4
:choosenumd4
cls
echo %d4%
set /a d4=%RANDOM%
if %d4% GTR 9 goto choosenumd4
if %d4% LSS 0 goto choosenumd4
goto choosenumd5
:choosenumd5
cls
echo %d5%
set /a d5=%RANDOM%
if %d5% GTR 9 goto choosenumd5
if %d5% LSS 0 goto choosenumd5
title Guess the number
goto choosenum
:choosenum
echo [%date%, %time%] Digits Chosen >> NUMBERS.history
cls
echo Implementing...
set /A randomNumber=%d1%%d2%%d3%%d4%%d5%
set /A minNumber=%randomNumber%-%RANDOM%
set /A maxNumber=%randomNumber%+%RANDOM%
set /a attemptsLeft=3
if %d5%==0 set numberIs=even
if %d5%==2 set numberIs=even
if %d5%==4 set numberIs=even
if %d5%==6 set numberIs=even
if %d5%==8 set numberIs=even
if %d5%==1 set numberIs=odd
if %d5%==3 set numberIs=odd
if %d5%==5 set numberIs=odd
if %d5%==7 set numberIs=odd
if %d5%==9 set numberIs=odd
goto guessit

:guessit
if %attemptsLeft%==0 goto atLeft
cls
call :colorEcho a0 "A number was chosen"
call :colorEcho 0c " [Attempts Left] %attemptsLeft%"
echo.
echo.
call :colorEcho 9f "Clue 1"
echo  The number is between %minNumber% and %maxNumber%
call :colorEcho 9f "Clue 2"
echo  The number is a 5 digit number
call :colorEcho 9f "Clue 3"
echo  The digit layout is: __ %d2% __ %d4% __
call :colorEcho 9f "Clue 4"
echo  The number is %numberIs%
echo.
echo What is the number? You have %attemptsLeft% attempt(s) left.
echo.
set /p "thenum=The number is: "
for /f "tokens=* delims= " %%a in ("%thenum%") do set thenum=%%a
for /l %%a in (1,1,100) do if "!thenum:~-1!"==" " set thenum=!ttc:~0,-1!
if "%thenum%"=="" goto guessit
if "%thenum%"=="%randomNumber%" goto Correct
goto Wrong

:Correct
cls
echo WELL DONE! You correctly guessed the random number. Press any key to generate another.
echo [%Date%, %time%] Correctly guessed %randomNumber% >> NUMBERS.history
pause>nul
goto choosenumd1

:Wrong
set /a attemptsLeft=%attemptsLeft%-1
echo Wrong! You have %attemptsLeft% attempt(s) left. Press any key to retry.
pause>nul
goto guessit

:atLeft
echo [%date%, %time%] Failed to guess the random number, which was %randomNumber% >> NUMBERS.history
cls
echo                          === MISSION FAILED! ===
echo You have run out of attempts. Press any key to retry and generate another number.
echo The number was: %randomNumber%
pause>nul
goto choosenumd1
:colorEcho
:: Echo different coloured texts
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i