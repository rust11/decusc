$!
$! Generate compiler listings.  Execute by
$!	@VLIST 0 1 2 3
$! To list all passes, execute
$!	@VLIST ALL
$	set noverify
$	pass0 = 0
$	pass1 = 0
$	pass2 = 0
$	pass3 = 0
$loop:	if p1 .eqs. "" then goto doit
$	if p1 .eqs. "0" .or. p1 .eqs. "ALL" then pass0 = 1
$	if p1 .eqs. "1" .or. p1 .eqs. "ALL" then pass1 = 1
$	if p1 .eqs. "2" .or. p1 .eqs. "ALL" then pass2 = 1
$	if p1 .eqs. "3" .or. p1 .eqs. "ALL" then pass3 = 1
$	p1 := "''p2'"
$	p2 := "''p3'"
$	p3 := "''p4'"
$	p4 := "''p5'"
$	p5 := "''p6'"
$	p6 := "''p7'"
$	p7 := "''p8'"
$	p8 := "''p9'"
$	p9 := ""
$	goto loop
$!
$ doit:
$!
$ SET VERIFY
$ ASSIGN [-.COMP]		SR:
$ ASSIGN [-.COMP]		LS:
$ ASSIGN [-]			OB:
$ ASSIGN [-]			OU:
$!
$ DEL LS:*.LST;*
$ ON ERROR THEN EXIT
$!
$! Assemble the Compiler
$!
$		if pass0 .eq. 0 then goto dopass1
$ MCR MAC ,LS:CC0HD/-SP=SR:RSX,SR:CC0HD
$ MCR MAC ,LS:CC0RT/-SP=SR:RSX,SR:CC0RT
$ MCR MAC ,LS:CC0GB/-SP=SR:RSX,SR:CC0GB
$ MCR MAC ,LS:CC000/-SP=SR:RSX,SR:CC000
$ MCR MAC ,LS:CC001/-SP=SR:RSX,SR:CC001
$ MCR MAC ,LS:CC002/-SP=SR:RSX,SR:CC002
$ dopass1:	if pass1 .eq. 0 then goto dopass2
$ MCR MAC ,LS:CC1GB/-SP=SR:RSX,SR:CC1GB
$ MCR MAC ,LS:CC100/-SP=SR:RSX,SR:CC100
$ MCR MAC ,LS:CC101/-SP=SR:RSX,SR:CC101
$ MCR MAC ,LS:CC102/-SP=SR:RSX,SR:CC102
$ MCR MAC ,LS:CC103/-SP=SR:RSX,SR:CC103
$ MCR MAC ,LS:CC104/-SP=SR:RSX,SR:CC104
$ MCR MAC ,LS:CC105/-SP=SR:RSX,SR:CC105
$ dopass2:	if pass2 .eq. 0 then goto dopass3
$ MCR MAC ,LS:CC2GB/-SP=SR:RSX,SR:CC2GB
$ MCR MAC ,LS:CC200/-SP=SR:RSX,SR:CC200
$ MCR MAC ,LS:CC201/-SP=SR:RSX,SR:CC201
$ MCR MAC ,LS:CC202/-SP=SR:RSX,SR:CC202
$ MCR MAC ,LS:CC202A/-SP=SR:RSX,SR:CC202A
$ MCR MAC ,LS:CC203/-SP=SR:RSX,SR:CC203
$ MCR MAC ,LS:CC204/-SP=SR:RSX,SR:CC204
$ MCR MAC ,LS:CC205/-SP=SR:RSX,SR:CC205
$ MCR MAC ,LS:CC206/-SP=SR:RSX,SR:CC206
$ MCR MAC ,LS:CC207/-SP=SR:RSX,SR:CC207
$ dopass3:	if pass3 .eq. 0 then goto finis
$ MCR MAC ,LS:CC300/-SP=SR:RSX,SR:CC300
$ finis:
$ print/DEV=LPA0: LS:*.LST
$!
$! Compiler listings complete
$!
$SET NOVERIFY
