!	CAS:UPDATE.COM - Build and update AS.SAV
!
@ops:up cas cab as.sav 'P1' 'P2'
tem$ mac$ cas cab custom
cus$ := macro ccs:rust+cas:^1/object:cab:^1
!
mac$ asroo
mac$ ascmd
mac$ asfil
mac$ asasm
mac$ asexp
mac$ aslex
mac$ asobj
mac$ aslst
mac$ assym
mac$ ashsh
mac$ asisd
!
mrg$
log$ AS.SAV
link:
r link
cab:as,cab:as=cab:asroo,ccb:tcomlb/n//
cab:ascmd,asfil,ccb:tcomlb/o:1/c
cab:asasm,asexp,aslex/o:1/c
cab:asobj,aslst,assym,ashsh,asisd,ccb:tcomlb
//
^C
end$:
