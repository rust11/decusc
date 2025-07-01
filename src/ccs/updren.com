!	CCS:UPDREN.COM - Rename CCS: RUST/RSX source modules
!
!	@CCS:UPDREN RUST	! Change to RUST filenames
!	@CCS:UPDREN RSX		! Restore RSX filenames
!
!	Note: Aborting this command file will leave some of
!	      the files with RT-11 names and others with RSX names.
!	      Making a backup before executing solves the problem.
!
if "'P2'" goto error
if "'P1'" eq "RUST" goto RUST
if "'P1'" eq "RSX"  goto RSX
error: display "?UPDREN-E-Invalid command (@CCS:UPDREN RUST|RSX)"
goto end
!
RUST:
ren$ := rename ccs:^1.mac ccs:^2.mac
if/file=ccs:cc0hd.mac goto rename
display "?UPDREN-E-CCS: already has RUST file names"
goto end
!
RSX:
ren$ := rename ccs:^2.mac ccs:^1.mac
if/file=ccs:c0$hdr.mac goto rename
display "?UPDREN-E-CCS: already has RSX file names"
goto end

RENAME:
!
!	Command
!
!    RSX	RUST
!    ---	----
ren$ CC0HD	c0$hdr	! pass 0 header
ren$ CC0GB	c0$gbl	! pass 0 globals
ren$ CC0RT	c0$roo	! root - compiler start
ren$ CC000	c00cmd	! parse command line
ren$ CC001	c01pre	! preprocessor
ren$ CC002	c02cnd	! preprocessor conditionals
!
!	Parser
!
ren$ CC1GB	c1$gbl	! Pass 1 globals
ren$ CC100	c10ext	! externals
ren$ CC101	c11lex	! lexical 
ren$ CC102	c12stm	! statements
ren$ CC103	c13exp	! expression to tree
ren$ CC104	c14msc	! miscellaneous
ren$ CC105	c15fil	! file i/o
ren$ CC107	c17end	! end-of-parser label
!
!	Generator
!
ren$ CC2GB	c2$gbl	! Pass 2 globals
ren$ CC200	c20mai	! code generator mainline
ren$ CC201	c21exp	! expression tree
ren$ CC202	c22cg1	! code generator part 1
ren$ CC202a	c22reg	! register allocation
ren$ CC203	c23cg2	! code generator part 2
ren$ CC204	c24cst	! compute costs
ren$ CC205	c25msc	! data/branches/file i/o
ren$ CC206	c26tab	! code tables
ren$ CC207	c27dbg	! debug
!
!	Wrapup
!
ren$ CC300	c30wrp	! wrapup
!
END:
ren$ :=
