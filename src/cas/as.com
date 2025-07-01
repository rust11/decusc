!	ASS:UPDATE.COM - Build and update AS.SAV
!
@ops:up ass asb as.sav 'P1' 'P2'
tem$ mac$ ass asb custom
cus$ := macro ass:rust+ass:^1/object:asb:^1
!
mac$ asroo/object:ccb:
mac$ ascmd/object:ccb:
mac$ asfil/object:ccb:
mac$ asasm/object:ccb:
mac$ asexp/object:ccb:
mac$ aslex/object:ccb:
mac$ asobj/object:ccb:
mac$ aslst/object:ccb:
mac$ assym/object:ccb:
mac$ ashsh/object:ccb:
mac$ asisd/object:ccb:
!
!	/k:34
link:
r link
ccb:as,ccb:as=ccb:asroo,tcomlb/n//
ccb:ascmd,asfil,tcomlb/o:1/c
ccb:asasm,asexp,aslex/o:1/c
ccb:asobj,aslst,assym,ashsh,asisd,tcomlb
//
^C
