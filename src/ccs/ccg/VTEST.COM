$!
$! Build Conroy's C compiler -- Vax compatibility mode -- for testing
$!
$!
$! File assignments:
$!	The following are used here:
$!	[default]	(temp files)
$!	SR:		Compiler and command file sources
$!	LS:		Compiler listing output
$!	OB:		Compiler library
$!	OU:		Task image output
$!
$! Warning: the assignment of NL: is a VMS hack to supress printing listings
$! This command file does not generate listings.
$!
$ SET VERIFY
$ ASSIGN 'f$logical("SYS$DISK")''f$directory()'		SR:
$ ASSIGN 'f$logical("SYS$DISK")''f$directory()'		LS:
$ ASSIGN [-]			OB:
$ ASSIGN [-]			OU:
$!
$ DEL LS:*.LST;*
$ ASSIGN NL:			LS:	!Gotta be after delete for VMS V1.5
$ ON ERROR THEN EXIT
$!
$! Assemble the Compiler
$!
$ MCR MAC @SR:XASMCC.CMD
$!
$! Task build the compiler
$!
$ MCR TKB @SR:XCCBLD.TKB
$ COPY CC.EXE OU:CC.TMP
$ DELETE CC.EXE;*
$ RENAME OU:CC.TMP OU:CC.EXE
$ PURGE OU:CC.EXE
$!
$! Compiler build complete
$!
$SET NOVERIFY
