!	cpp.com - build C preprocessor
!
goto 'p1'
cc cps:cpp1 /obj:cpb:
cc cps:cpp2 /obj:cpb:
cc cps:cpp3 /obj:cpb:
cc cps:cpp4 /obj:cpb:
cc cps:cpp5 /obj:cpb:
cc cps:cpp6 /obj:cpb:
link:
link dcc:clib/exe=cpb:cpp/map=cpb:cpp/bot=4000/cross/prompt
cpb:cpp1,cpp2,cpp3,cpp4,cpp5,cpp6
//

