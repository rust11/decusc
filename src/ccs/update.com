!	CCS:UPDATE.COM - Update DECUS-C compiler
!
@ccs:updlib 'P1' 'P2' 'P3'!	comlib must come first
@ccs:upddcc 'P1' 'P2' 'P3'!	compiler second


