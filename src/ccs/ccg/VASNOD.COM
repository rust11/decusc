$! VMAKAS.COM
$!
$! Make the C-style assembler, RSX-style.
$!
$! Note that the library OB:XCOMLB.OLB must have already been built
$! by executing the compiler build procedure.
$!
$! Assignments:
$!	[this]			Objects (temp)
$!	OB:	[-]		Location of XCOMLB.OLB
$!	OU:	[-]		Output files
$!	SR:	[-.COMP]	Source files
$!	LS:	NL:		Listing file temp.
$!
$ SET VERIFY
$ ASSIGN [-.COMP]		SR:
$ ASSIGN [-.COMP]		LS:
$ ASSIGN [-]			OB:
$ ASSIGN [-]			OU:
$!
$! Assemble the assembler
$!
$ DEL LS:*.LST;*
$ ASSIGN NL:			LS:
$ MCR MAC @SR:XASMAS.CMD
$!
$! Task-build the assembler
$! 
$ MCR TKB @SR:XASBLD.TKB
$! DELETE AS*.OBJ;*
$ COPY AS.EXE OU:
$ PURGE OU:AS.EXE
$ DELETE AS.EXE;
$!
$ SET NOVERIFY
$!
$! Assembler build complete
$!
