$ SET VERIFY
$ ASSIGN [-.COMP]		SR:
$ ASSIGN [-.COMP]		LS:
$ ASSIGN [-]			OB:
$ ASSIGN [-]			OU:
$ ASSIGN NL:			LS:
$!
$! Task-build the assembler
$! 
$ MCR TKB @SR:XASBLD.TKB
$ COPY AS.EXE OU:
$ PURGE OU:AS.EXE
$ DELETE AS.EXE;
$!
$ SET NOVERIFY
$!
$! Assembler build complete
$!
