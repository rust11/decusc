!	cc.com - build rt-11 compiler
!
!	static x ();			cc100?
!	,} in data initializers		cc100
!	"b" in fopen mode specifiers	iofopt
!	8kw more pool for parser
!	"." and "=>" operand pointers	CC103
!
!	cc103	not located
!	cc202a	not located
!	cc300	.serr/.herr
!
goto 'p1'
!macro ccs:rust+ccs:CC0HD/object:ccb:CC0HD
!macro ccs:rust+ccs:CC0RT/object:ccb:CC0RT
!macro ccs:rust+ccs:CC0GB/object:ccb:CC0GB
!macro ccs:rust+ccs:CC000/object:ccb:CC000
!macro ccs:rust+ccs:CC001/object:ccb:CC001
!macro ccs:rust+ccs:CC002/object:ccb:CC002
!macro ccs:rust+ccs:CC1GB/object:ccb:CC1GB
macro ccs:rust+ccs:CC100/object:ccb:CC100
!macro ccs:rust+ccs:CC101/object:ccb:CC101
!macro ccs:rust+ccs:CC102/object:ccb:CC102
!macro ccs:rust+ccs:CC103/object:ccb:CC103
!macro ccs:rust+ccs:CC104/object:ccb:CC104
!macro ccs:rust+ccs:CC105/object:ccb:CC105
!macro ccs:rust+ccs:CC106/object:ccb:CC106!	unused
!macro ccs:rust+ccs:CC107/object:ccb:CC107!
!macro ccs:rust+ccs:CC2GB/object:ccb:CC2GB
!macro ccs:rust+ccs:CC200/object:ccb:CC200
!macro ccs:rust+ccs:CC201/object:ccb:CC201
!macro ccs:rust+ccs:CC202/object:ccb:CC202
!macro ccs:rust+ccs:CC202A/object:ccb:CC202A
!macro ccs:rust+ccs:CC203/object:ccb:CC203
!macro ccs:rust+ccs:CC204/object:ccb:CC204
!macro ccs:rust+ccs:CC205/object:ccb:CC205
!macro ccs:rust+ccs:CC206/object:ccb:CC206
!macro ccs:rust+ccs:CC207/object:ccb:CC207
!macro ccs:rust+ccs:CC300/object:ccb:CC300
!
link:
r link
ccb:cc,ccb:cc=ccb:cc0hd,cc0rt/b:4000/n//
ccb:cc0gb,cc1gb,cc2gb,comlib
ccb:cc000,cc001,cc002,comlib/o:1
ccb:cc100,cc101,cc102,cc103/o:1
ccb:cc104,cc105,comlib,cc107
ccb:cc200,cc201,cc202,cc202a,cc203/o:1
ccb:cc204,cc205,cc206,cc207,comlib
ccb:cc300,ccb:comlib/o:1
//
^C
