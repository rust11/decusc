!	CC.COM - Build and update RUST DECUS C compiler.
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
@ops:up ccs ccb cc.sav 'P1' 'P2'
tem$ mac$ ccs ccb custom
cus$ := macro ccs:rust+ccs:^1/object:ccb:^1
!
!	Setup
!
mac$ CC0HD!	c0hdr	Pass 0 header
mac$ CC0RT!	c0roo	Root - compiler start
mac$ CC0GB!	c0gbl	Pass 0 globals
mac$ CC000!	c0cmd	parse command line
mac$ CC001!	c0pre	preprocessor
mac$ CC002!	c0cnd	preprocessor conditionals
!
!	Parser
!
mac$ CC1GB!	c1gbl	Pass 1 globals
mac$ CC100!	c1ext	externals
mac$ CC101!	c1lex	lexical 
mac$ CC102!	c1stm	statements
mac$ CC103!	c1exp	expression to tree
mac$ CC104!	c1msc	miscellaneous
mac$ CC105!	c1fil	file i/o
!!!$ CC106!		unused
mac$ CC107!	c1end	end-of-parser label
!
!	Generator
!
mac$ CC2GB!	c2gbl	Pass 2 globals
mac$ CC200!	c2mai	code generator mainline
mac$ CC201!	c2exp	expression tree
mac$ CC202!	c2cg1	code generator part 1
mac$ CC202a!	c2reg	register allocation
mac$ CC203!	c2cg2	code generator part 2
mac$ CC204!	c2cst	compute costs
mac$ CC205!	c2msc	data/branches/file i/o
mac$ CC206!	c2tab	code tables
mac$ CC207!	c2dbg	debug
!
mac$ CC300!	c3wrp	wrapup
done$
!
link:
log$ CC.SAV
r link
ccb:cc,ccb:cc=ccb:cc0hd,cc0rt/b:4000/n//
ccb:cc0gb,cc1gb,cc2gb,ccb:tcomlb
ccb:cc000,cc001,cc002,ccb:tcomlb/o:1
ccb:cc100,cc101,cc102,cc103/o:1
ccb:cc104,cc105,ccb:tcomlb,cc107
ccb:cc200,cc201,cc202,cc202a,cc203/o:1
ccb:cc204,cc205,cc206,cc207,ccb:tcomlb
ccb:cc300,ccb:tcomlb/o:1
//
^C
end$:
