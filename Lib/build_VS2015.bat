@echo off
setlocal
set cl_exe="C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\cl.exe" /nologo
set cl_opt=/MT /LD /O2 /Ox /DNDEBUG -GS- -Gs9999999 /EHa- /Oi /Gz
:: /arch:IA32 
set cl_files=sqlite3win32stubs.cpp sqlite3win32helper.c
set link_opt=/def:sqlite3win32.def
set bin_dir=%~dp0..\bin
set bin_file=sqlite3win32.dll

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\vcvars32.bat"

if [%1]==[XP] (
    set "include=C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\include;%include%"
    set "lib=C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\lib;%lib%"
)
if [%1]==[debug] (
    set cl_opt=/MDd /LDd /Zi /Gz
    set link_opt=%link_opt% /debug /incremental:no
    shift /1
)

pushd %~dp0

%cl_exe% %cl_opt% %cl_files% /Fe%bin_file% /link %link_opt% || pause
copy %bin_file% %bin_dir% > nul
copy *.obj %bin_dir%\*.cobj > nul

:cleanup
del /q *.exp *.lib *.obj *.dll ~$*

popd
