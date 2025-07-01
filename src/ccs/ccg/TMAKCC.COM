! TMAKCC.COM
!
! Build Conroy's C compiler for RT-11
!
! Prepared by:
!		Bob Denny
!		 3-Jul-80
!
! Edit History
! 10-Feb-82	Added CC202A
! 26-Feb-82	Don't delete objects before.  Delete them after.
! 25-Nov-82	Added CC002
!
! You must make the following logical device assignments:
!
!	SR:	Compiler and command file sources.
!	OB:	Temporary object file workspace.
!	LS:	Listing output.
!	MP:	Load map output.
!	OU:	Compiler .SAV file output.
!
! This command string, as distributed, makes a non-EIS compiler
! but with the SXT instruction.  If you wish to have inline EIS
! by default, or cannot use the SXT instruction, edit RT11.MAC.
!
! The following must be reassigned as needed
!
ASSIGN RK1: SR:
ASSIGN RK1: OB:
ASSIGN RK1: LS:
ASSIGN RK1: MP:
ASSIGN RK1: OU:
!
SET ERROR NONE
!
DATE
TIME
!
! Bail out here if you haven't saved any old copies of the following
! files you want to keep.
!
DEL OU:TCOMLB.OBJ,OU:CC.SAV,MP:CC.MAP
!
! Abort if assembly errors occur.
!
SET ERROR ERROR
!
! Assemble the Compiler.  Note:  this must follow the model in RMAKCC.CMD
!
R MACRO
OB:CC0HD,LS:CC0HD/C=SR:RT11,SR:CC0HD
OB:CC0RT,LS:CC0RT/C=SR:RT11,SR:CC0RT
OB:CC0GB,LS:CC0GB/C=SR:RT11,SR:CC0GB
OB:CC000,LS:CC000/C=SR:RT11,SR:CC000
OB:CC001,LS:CC001/C=SR:RT11,SR:CC001
OB:CC002,LS:CC002/C=SR:RT11,SR:CC002
OB:CC1GB,LS:CC1GB/C=SR:RT11,SR:CC1GB
OB:CC100,LS:CC100/C=SR:RT11,SR:CC100
OB:CC101,LS:CC101/C=SR:RT11,SR:CC101
OB:CC102,LS:CC102/C=SR:RT11,SR:CC102
OB:CC103,LS:CC103/C=SR:RT11,SR:CC103
OB:CC104,LS:CC104/C=SR:RT11,SR:CC104
OB:CC105,LS:CC105/C=SR:RT11,SR:CC105
OB:CC2GB,LS:CC2GB/C=SR:RT11,SR:CC2GB
OB:CC200,LS:CC200/C=SR:RT11,SR:CC200
OB:CC201,LS:CC201/C=SR:RT11,SR:CC201
OB:CC202,LS:CC202/C=SR:RT11,SR:CC202
OB:CC202A,LS:CC202A/C=SR:RT11,SR:CC202A
OB:CC203,LS:CC203/C=SR:RT11,SR:CC203
OB:CC204,LS:CC204/C=SR:RT11,SR:CC204
OB:CC205,LS:CC205/C=SR:RT11,SR:CC205
OB:CC206,LS:CC206/C=SR:RT11,SR:CC206
OB:CC207,LS:CC207/C=SR:RT11,SR:CC207
OB:CC300,LS:CC300/C=SR:RT11,SR:CC300
^C
!
DATE
TIME
!
! Assemble the library
!
@SR:TCOMLB
!
DATE
TIME
!
! Link the compiler
!
@SR:TCCBLD
!
! Delete compiler objects
!
DELETE/NOQUERY OB:CC0HD.OBJ,CC0RT.OBJ,CC0GB.OBJ,CC000.OBJ,CC001.OBJ
DELETE/NOQUERY OB:CC002.OBJ
DELETE/NOQUERY OB:CC1GB.OBJ,CC100.OBJ,CC101.OBJ,CC102.OBJ,CC103.OBJ
DELETE/NOQUERY OB:CC104.OBJ,CC105.OBJ
DELETE/NOQUERY OB:CC2GB.OBJ,CC200.OBJ,CC201.OBJ,CC202.OBJ,CC202A.OBJ
DELETE/NOQUERY OB:CC203.OBJ,CC204.OBJ,CC205.OBJ,CC206.OBJ,CC207.OBJ
DELETE/NOQUERY OB:CC300.OBJ
!
DATE
TIME
!
! Compiler build complete
!
