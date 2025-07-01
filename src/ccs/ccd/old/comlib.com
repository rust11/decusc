set tt noquiet
!	comlib.com - build rt-11 library
!
goto 'p1'
macro ccs:share+ccs:lalloc/object:ccb:lalloc
macro ccs:share+ccs:lascr5/object:ccb:lascr5
macro ccs:share+ccs:lc5toa/object:ccb:lc5toa
macro ccs:share+ccs:ldate/object:ccb:ldate
macro ccs:share+ccs:leisbx/object:ccb:leisbx
macro ccs:share+ccs:lfdbta/object:ccb:lfdbta
macro ccs:share+ccs:lflush/object:ccb:lflush
macro ccs:share+ccs:lgetc0/object:ccb:lgetc0
macro ccs:share+ccs:litoc/object:ccb:litoc
macro ccs:share+ccs:lmemdp/object:ccb:lmemdp
macro ccs:share+ccs:lputbn/object:ccb:lputbn
macro ccs:share+ccs:lputc0/object:ccb:lputc0
macro ccs:share+ccs:lputxt/object:ccb:lputxt
macro ccs:share+ccs:lrdlin/object:ccb:lrdlin
macro ccs:share+ccs:lrewnd/object:ccb:lrewnd
macro ccs:share+ccs:lsavrg/object:ccb:lsavrg
!
! make the compiler's runtime support library.
!
lib:
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
