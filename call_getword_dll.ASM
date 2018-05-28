;; ASM call to load dll test
;; tool : FASM 1.73.04, download, https://flatassembler.net/download.php
;; getword.dll, download from http://www.textcapture.com/en/download.htm
;; copy getword.dll to the same folder of this ASM file
;; load asm with FASM1.73.04, hit F9 to run/compile, the demo message as 30 days will showup
;; test done, ASM to call &load dll is successful
;; 2018-05-28 08:37:17
;; by xiaolaba
;; REF : https://programmer209.wordpress.com/2015/05/31/fasm-using-the-c-file-functions/



format PE GUI 4.0
entry start

include 'win32a.inc'
;include 'GetWord_V4_API.inc' ;not working



section '.text' code readable executable

  start:
        ;;;;;original FASM DLL example code
        ;invoke  SetLastError,0
        ;invoke  ShowLastError,HWND_DESKTOP
        ;invoke  MessageBox,NULL,_error,NULL,MB_ICONERROR+MB_OK
        ;;;;;original FASM DLL example code

        ;; my getword.dll load and test code
        ;; Reminder windows pops up, it means getword.dll loaded
        invoke  SetLicenseID,_dummyID   ;;To do, how to test if this function call is working ?
        invoke  MessageBox,NULL,_dummyID,_loaddll,MB_OK

        invoke  ExitProcess,0


section '.data' data readable writeable

  _class TCHAR 'FASMWIN32',0
  _title TCHAR 'Win32 program template',0
  _error TCHAR 'Win32 program template',0
  _loaddll TCHAR 'Win32 program template, load getword.dll done',0


   ;; my test code for getword.dll load
  _dummyID    TCHAR 'test program to load DLL, _dummyID {068AB1E7-CDEF-46f2-8357-105793BC7C92}',0


section '.idata' import data readable writeable

  library kernel,'KERNEL32.DLL',\
          user32,'USER32.DLL',\
          errormsg,'ERRORMSG.DLL',\
          getword,'GETWORD.DLL'  ;; my getword.dll load and test code

  import kernel,\
         SetLastError,'SetLastError',\
         ExitProcess,'ExitProcess'

  import errormsg,\
         ShowLastError,'ShowLastError'

  ;; my getword.dll load and test code
  import getword,\
         SetLicenseID,'SetLicenseID'


  include 'api\kernel32.inc'
  include 'api\user32.inc'