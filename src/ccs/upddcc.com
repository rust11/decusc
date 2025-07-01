!	UPDDCC.COM - Build and update RUST DECUS C compiler.
!
!	o Renamed source files (see CCS:UPDREN.COM to restore)
!	o Conditionally exclude compiler preprocessor
!
@ops:up ccs ccb cc.sav 'P1' 'P2'
tem$ mac$ ccs ccb custom
cus$ := macro ccs:rust+ccs:^1/object:ccb:^1
!
!	Setup
!
mac$	c0$hdr	!CC0HD	pass 0 header
mac$	c0$gbl	!CC0GB	pass 0 globals
mac$	c0$roo	!CC0RT	root - compiler start
mac$	c00cmd	!CC000	parse command line
!
!	Preprocessor
!
mac$	c01pre	!CC001	preprocessor
mac$	c02cnd	!CC002	preprocessor conditionals
!
!	Parser - Pass 1
!
mac$	c1$gbl	!CC1GB	pass 1 globals
mac$	c10ext	!CC100	externals
mac$	c11lex	!CC101	lexical 
mac$	c12stm	!CC102	statements
mac$	c13exp	!CC103	expression to tree
mac$	c14msc	!CC104	miscellaneous
mac$	c15fil	!CC105	file i/o
!!!$ 	CC106!		unused
mac$	c17end	!CC107	end-of-parser label
!
!	Generator - Pass 2
!
mac$	c2$gbl	!CC2GB	pass 2 globals
mac$	c20mai	!CC200	code generator mainline
mac$	c21exp	!CC201	expression tree
mac$	c22cg1	!CC202	code generator part 1
mac$	c22reg	!CC202a	register allocation
mac$	c23cg2	!CC203	code generator part 2
mac$	c24cst	!CC204	compute costs
mac$	c25msc	!CC205	data/branches/file i/o
mac$	c26tab	!CC206	code tables
mac$	c27dbg	!CC207	debug
!
mac$	c30wrp	!CC300	wrapup
done$
!
link:
log$ CC.SAV
r link
ccb:cc,ccb:cc=ccb:c0$hdr,c0$roo/b:4000/n//!	! root
ccb:c0$gbl,c1$gbl,c2$gbl,ccb:tcomlb!		!
ccb:c00cmd,c01pre,c02cnd,ccb:tcomlb/o:1!	! include preprocessor
!cb:c00cmd,ccb:tcomlb/o:1!			! omit preprocessor
ccb:c10ext,c11lex,c12stm,c13exp/o:1!		! parser
ccb:c14msc,c15fil,ccb:tcomlb,c17end!		!
ccb:c20mai,c21exp,c22cg1,c22reg,c23cg2/o:1!	! generator
ccb:c24cst,c25msc,c26tab,c27dbg,ccb:tcomlb!	!
ccb:c30wrp,ccb:tcomlb/o:1!			! wrap-up
//
^C
end$:
