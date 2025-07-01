!	COMLIB.COM - Build and update RUST DECUS C compiler library.
!
@ops:up ccs ccb cc.sav 'P1' 'P2'
tem$ mac$ ccs ccb custom
cus$ := macro ccs:rust+ccs:^1/object:ccb:^1
!
mac$ lalloc
mac$ lascr5
mac$ lc5toa
mac$ ldate
mac$ leisbx
mac$ lfdbta
mac$ lflush
mac$ lgetc0
mac$ litoc
mac$ lmemdp
mac$ lputbn
mac$ lputc0
mac$ lputxt
mac$ lrdlin
mac$ lrewnd
mac$ lsavrg
done$
!
lib:
log$ TCOMLB.OBJ
r libr
ccb:tcomlb.obj=//
ccb:lalloc
ccb:lascr5
ccb:lc5toa
ccb:ldate
ccb:leisbx
ccb:lfdbta
ccb:lflush
ccb:lgetc0
ccb:litoc
ccb:lmemdp
ccb:lputbn
ccb:lputc0
ccb:lputxt
ccb:lrdlin
ccb:lrewnd
ccb:lsavrg
//
^C
end$:
