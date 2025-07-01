SWITCH BASIC
! XMAKCC.CMD	Run using ATPK or Batch
!
! Build Dave Conroy's C compiler -- RSTS/E RSX flavor
!
! You must be logged in under a privileged account in order to
! do cross-account creates.
!
! File assignments:
!	The following are used here:
!	[this]		Task image map (also temp stuff)
! SR:	SY:[5,3]	Compiler and command file sources
! LS:	NL:		Compiler listing output
! OU:	C:		Task image output
! OB:	SY:		Compiler library
!
$ALLOW WARNING ERRORS
DEASSIGN
ASSIGN SY:[5,3]	SR
ASSIGN NL:	LS
!
PRINT DATE$(0), TIME$(0)
!
$ALLOW WARNING ERRORS
!
! Assemble the Compiler
!
MAC @SR:XASMCC.CMD
!
PRINT DATE$(0), TIME$(0)
!
! Assemble the library
!
MAC @SR:XASMLB.CMD
!
! Create the library
!
DEASSIGN	LS
ASSIGN SY:	OB
ASSIGN C:	OU
!
LBR XCOMLB.TMP/CR=LITOC,LALLOC,LASCR5,LC5TOA,LDATE,LEISBX
LBR XCOMLB.TMP=LFDBTA,LFLUSH,LMEMDP,LPUTBN
LBR XCOMLB.TMP=LPUTXT,LRDLIN,LREWND,LSAVRG
PIP OB:XCOMLB.OLB<40>=XCOMLB.TMP
PIP XCOMLB.TMP/DE
!
PRINT DATE$(0), TIME$(0)
!
! Task build the compiler
!
$@SY:[5,3]XCCBLD.CMD
!
PRINT DATE$(0), TIME$(0)
!
! Compiler build complete
!
DEASSIGN
