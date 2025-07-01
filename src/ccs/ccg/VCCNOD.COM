$!
$! Build CC for debugging -- don't delete object files.
$!
$ SET VERIFY
$ ASSIGN [-.COMP]		SR:
$ ASSIGN [-.COMP]		LS:
$ ASSIGN [-]			OB:
$ ASSIGN [-]			OU:
$ ASSIGN NL:			LS:	!Gotta be after delete for VMS V1.5
$ ON ERROR THEN EXIT
$ MCR MAC @SR:XASMCC.CMD
$ MCR TKB @SR:XCCBLD.TKB
$ COPY CC.EXE OU:CC.TMP
$ DELETE CC.EXE;*
$ RENAME OU:CC.TMP OU:CC.EXE
$ PURGE OU:CC.EXE
$! Compiler build complete
$SET NOVERIFY
