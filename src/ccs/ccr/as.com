!	as.com - build assembler
!
goto 'p1'
!macro ccs:rust+ccs:asroo/object:ccb:
!macro ccs:rust+ccs:ascmd/object:ccb:
!macro ccs:rust+ccs:asfil/object:ccb:
macro ccs:rust+ccs:asasm/object:ccb:
macro ccs:rust+ccs:asexp/object:ccb:
!macro ccs:rust+ccs:aslex/object:ccb:
!macro ccs:rust+ccs:asobj/object:ccb:
!macro ccs:rust+ccs:aslst/object:ccb:
!macro ccs:rust+ccs:assym/object:ccb:
macro ccs:rust+ccs:ashsh/object:ccb:
!macro ccs:rust+ccs:asisd/object:ccb:
!
!	/k:34
link:
r link
ccb:as,ccb:as=ccb:asroo,tcomlb/a/n//
ccb:ascmd,asfil,tcomlb/o:1/c
ccb:asasm,asexp,aslex/o:1/c
ccb:asobj,aslst,assym,ashsh,asisd,tcomlb
//
^C
