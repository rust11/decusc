SWITCH BASIC
! XMAKAS.CMD	Run by ATPK
!
! Make the C-style assembler, RSX-style.
!
! You must be logged in under a privileged account in order to
! do cross-account creates.
!
! Note that the library OB:XCOMLB.OLB must have already been built
! by executing the compiler build procedure.
!
! Assignments:
!	[this]	Objects, and listings
! OB:	SY:	XCOMLB found here
! OU:	C:	AS.TSK written here
! SR:	[5,3]	Source files
! LS:	NL:	Listing file temp.
!
ASSIGN SY:[5,3]	SR
ASSIGN NL:	LS
!
PRINT DATE$(0), TIME$(0)
!
$ALLOW FATAL ERRORS
PIP LS:*.LST<0>/RE
PIP LS:*.LST/DE
!
$ALLOW WARNING ERRORS
MAC @SR:XASMAS.CMD
!
PRINT DATE$(0), TIME$(0)
!
DEASSIGN	LS
ASSIGN SY:	OB
ASSIGN C:	OU
!
TKB @SR:XASBLD.TKB
!
$ALLOW FATAL ERRORS
PIP AS.TMP/DE
$ALLOW WARNING ERRORS
!
PIP AS.TMP=AS.TSK/RE
PIP OU:AS.TSK<104>=AS.TMP
PIP AS.TMP/DE
PIP AS0.OBJ,AS1.OBJ,AS2.OBJ,AS3A.OBJ,AS3B.OBJ/DE
PIP AS3C.OBJ,AS3D.OBJ,AS3E.OBJ,AS3F.OBJ,AS3G.OBJ/DE
PIP AS3H.OBJ/DE
!
PRINT DATE$(0), TIME$(0)
!
! Assembler build complete
!
