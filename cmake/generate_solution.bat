@ECHO OFF
REM IF EXIST "%~dp0\build" rmdir "%~dp0\build" /S /Q
REM md build
IF NOT EXIST "%~dp0\build" md build
cd build
cmake .. -G "Visual Studio 14" -DANTEXE="C:\XBMC\blueray_stuff\apache-ant-1.9.0\bin\ant"
cd ..
