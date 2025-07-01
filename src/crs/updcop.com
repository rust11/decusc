!	CRS:UPDCOP - Copy libraries to DCC:
!
copy crb:clib.obj dcc:/nolog
copy crb:flib.obj dcc:/nolog
