! TMAKAS.COM
!
! Make the C-style assembler on RT-11
!
! Prepared by:
!		Bob Denny
!		 3-Jul-80
!
! Note that the library OU:TCOMLB.OBJ must have already been built
! by executing the compiler build procedure.
!
! You must make the following logical device assignments:
!
!	SR:	Compiler and command file sources.
!	OB:	Temporary object file workspace.
!	LS:	Listing output.
!	MP:	Load map output.
!	OU:	Compiler .SAV file output, TCOMLB.OBJ location.
!
ASSIGN RK1: SR:
ASSIGN RK1: OB:
ASSIGN RK1: LS:
ASSIGN RK1: MP:
ASSIGN RK1: OU:
!
! Bail out here if you haven't saved any old copies of the following
! files you want to keep.
!
SET ERROR NONE
DEL OU:AS.SAV
DEL MP:AS.MAP
!
DATE
TIME
!
! Abort if assembly errors occur.
!
SET ERROR ERROR
!
R MACRO
OB:AS0,LS:AS0/C=SR:RT11,SR:AS0
OB:AS1,LS:AS1/C=SR:RT11,SR:AS1
OB:AS2,LS:AS2/C=SR:RT11,SR:AS2
OB:AS3A,LS:AS3A/C=SR:RT11,SR:AS3A
OB:AS3B,LS:AS3B/C=SR:RT11,SR:AS3B
OB:AS3C,LS:AS3C/C=SR:RT11,SR:AS3C
OB:AS3D,LS:AS3D/C=SR:RT11,SR:AS3D
OB:AS3E,LS:AS3E/C=SR:RT11,SR:AS3E
OB:AS3F,LS:AS3F/C=SR:RT11,SR:AS3F
OB:AS3G,LS:AS3G/C=SR:RT11,SR:AS3G
OB:AS3H,LS:AS3H/C=SR:RT11,SR:AS3H
^C
!
DATE
TIME
!
! Link the assembler
!
@TASBLD
!
! Delete object files
!
DELETE/NOQUERY AS0.OBJ,AS1.OBJ,AS2.OBJ,AS3A.OBJ,AS3B.OBJ,AS3C.OBJ
DELETE/NOQUERY AS3D.OBJ,AS3E.OBJ,AS3F.OBJ,AS3G.OBJ,AS3H.OBJ
!
DATE
TIME
!
! Assembler build complete
!
