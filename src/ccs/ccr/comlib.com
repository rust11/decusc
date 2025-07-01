!	comlib.com - build rt-11 library
!
goto 'p1'
macro ccs:rust+ccs:lalloc/object:ccb:lalloc
macro ccs:rust+ccs:lascr5/object:ccb:lascr5
macro ccs:rust+ccs:lc5toa/object:ccb:lc5toa
macro ccs:rust+ccs:ldate/object:ccb:ldate
macro ccs:rust+ccs:leisbx/object:ccb:leisbx
macro ccs:rust+ccs:lfdbta/object:ccb:lfdbta
macro ccs:rust+ccs:lflush/object:ccb:lflush
macro ccs:rust+ccs:lgetc0/object:ccb:lgetc0
macro ccs:rust+ccs:litoc/object:ccb:litoc
macro ccs:rust+ccs:lmemdp/object:ccb:lmemdp
macro ccs:rust+ccs:lputbn/object:ccb:lputbn
macro ccs:rust+ccs:lputc0/object:ccb:lputc0
macro ccs:rust+ccs:lputxt/object:ccb:lputxt
macro ccs:rust+ccs:lrdlin/object:ccb:lrdlin
macro ccs:rust+ccs:lrewnd/object:ccb:lrewnd
macro ccs:rust+ccs:lsavrg/object:ccb:lsavrg
!
! make the compiler's runtime support library.
!
lib:
r libr
ccb:comlib.obj=//
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
