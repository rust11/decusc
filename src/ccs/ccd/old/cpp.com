!	cpp
!set default cps
goto 'p1'
!cc cps:cpp1 /obj:cpb: /decus
!cc cps:cpp2 /obj:cpb: /decus
!cc cps:cpp3 /obj:cpb: /decus
!cc cps:cpp4 /obj:cpb: /decus
!cc cps:cpp5 /obj:cpb: /decus
cc cps:cpp6 /obj:cpb: /decus
link:
!link ckd:suport,crb:clib/exe=cpb:cpp/map=cpb:cpp/bot=4000/cross/prompt
link dcc:clib/exe=cpb:cpp/map=cpb:cpp/bot=4000/cross/prompt
cpb:cpp1,cpp2,cpp3,cpp4,cpp5,cpp6
//

