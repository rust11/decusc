$! ASLIST.COM for debugging AS
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
$ goto here
$ MCR MAC AS0,LS:AS0/-SP=SR:RSX,SR:AS0
$ MCR MAC AS1,LS:AS1/-SP=SR:RSX,SR:AS1
$ MCR MAC AS2,LS:AS2/-SP=SR:RSX,SR:AS2
$ here:
$ MCR MAC AS3A,LS:AS3A/-SP=SR:RSX,SR:AS3A
$ MCR MAC AS3B,LS:AS3B/-SP=SR:RSX,SR:AS3B
$ MCR MAC AS3C,LS:AS3C/-SP=SR:RSX,SR:AS3C
$ MCR MAC AS3D,LS:AS3D/-SP=SR:RSX,SR:AS3D
$ MCR MAC AS3E,LS:AS3E/-SP=SR:RSX,SR:AS3E
$ MCR MAC AS3F,LS:AS3F/-SP=SR:RSX,SR:AS3F
$ MCR MAC AS3G,LS:AS3G/-SP=SR:RSX,SR:AS3G
$ MCR MAC AS3H,LS:AS3H/-SP=SR:RSX,SR:AS3H
$ DEL AS*.OBJ;*
$ PRINT/DEV=LPA0: LS:AS*.LST
$!
$ SET NOVERIFY
$!
$! Assembler build complete
$!
