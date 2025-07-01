$!
$! Build Dave Conroy's Decus C compiler -- Vax compatibility mode
$!
$! Edited for development:
$!	support library isn't built (it doesn't need to be).
$!	object modules aren't deleted (so they can be relinked for the PRO)
$!
$! File assignments:
$!	The following are used here:
$!	[default]	(temp files)
$!	SR:		Compiler and command file sources
$!	LS:		Compiler listing output
$!	OB:		Compiler library
$!	OU:		Task image output
$!	PRO:		PRO-350 task image output (see note below)
$!
$! Warning: the assignment of NL: is a VMS hack to supress printing listings
$! This command file does not generate listings.
$!
$ was_verify = 'f$verify(1)'
$ on error then goto finis
$ ASSIGN [-.COMP]		SR:
$ ASSIGN [-.COMP]		LS:
$ ASSIGN [-]			OB:
$ ASSIGN [-]			OU:
$!
$! Currently, the PRO-350 Decus C is built by assembling all modules
$! on VMS and transferring them (using PFT) to the PRO for subsequent
$! linking using the native toolkit.  The link command is
$!	"link @pccbld.tkb"
$! The commented-out sequences are for the VMS-based toolkit.
$!
$!! ASSIGN [-.POS]		PRO:
$!
$ DEL *.OBJ;*
$ DEL LS:*.LST;*
$ ASSIGN NL:			LS:	!Gotta be after delete for VMS V1.5
$ ON ERROR THEN EXIT
$!
$! Assemble the Compiler
$!
$ MCR MAC @SR:XASMCC.CMD
$!
$! Assemble the library
$!
$ goto library_built
$ MCR MAC @SR:XASMLB.CMD
$!
$! Create the library
$!
$ DEL OU:XCOMLB.OLB;*
$ MCR LBR OU:XCOMLB/CR=LALLOC,LASCR5,LC5TOA,LDATE,LEISBX,LFDBTA
$ MCR LBR OU:XCOMLB=LFLUSH,LITOC,LMEMDP,LPUTBN
$ MCR LBR OU:XCOMLB=LPUTXT,LRDLIN,LREWND,LSAVRG
$!
$ DELETE LALLOC.OBJ;,LASCR5.OBJ;,LC5TOA.OBJ;,LDATE.OBJ;,LEISBX.OBJ;,LFDBTA.OBJ;
$ DELETE LFLUSH.OBJ;,LITOC.OBJ;,LMEMDP.OBJ;,LPUTBN.OBJ;
$ DELETE LPUTXT.OBJ;,LRDLIN.OBJ;,LREWND.OBJ;,LSAVRG.OBJ;
$!
$ library_built:
$!
$! Task build the compiler
$!
$ MCR TKB @SR:XCCBLD.TKB
$ COPY CC.EXE OU:CC.TMP
$ DELETE CC.EXE;*
$ RENAME OU:CC.TMP OU:CC.EXE
$ PURGE OU:CC.EXE
$!
$! Build the PRO-350 compiler (with patched SYSINC)
$!
$!! MCR PAB @SR:PCCBLD.TKB
$!! COPY CC.TSK PRO:CC.TMP
$!! DELETE CC.TSK;*
$!! RENAME PRO:CC.TMP PRO:CC.TSK
$!
$! Exit without deleting objects so they can be transferred to the PRO
$! for building using the native toolkit.
$!
$ goto finis
$!
$ DELETE CC0HD.OBJ;,CC0RT.OBJ;,CC0GB.OBJ;,CC000.OBJ;,CC001.OBJ;,CC002.OBJ;
$ DELETE CC1GB.OBJ;,CC100.OBJ;,CC101.OBJ;,CC102.OBJ;,CC103.OBJ;
$ DELETE CC104.OBJ;,CC105.OBJ;
$ DELETE CC2GB.OBJ;,CC200.OBJ;,CC201.OBJ;,CC202.OBJ;,CC202A.OBJ;
$ DELETE CC203.OBJ;,CC204.OBJ;,CC205.OBJ;,CC206.OBJ;,CC207.OBJ;
$ DELETE CC300.OBJ;
$!
$! Compiler build complete
$!
$ finis: if .not. 'was_verify' then set noverify
