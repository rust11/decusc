!	CCS:UPDATE.COM - Build and update CRB:CLIB.OBJ/FLIB.OBJ
!
!	CLIB	FLIB
!	----	----
!	ATOD	ATOD	! ATODD is unused
!	ATOFD	ATOF
!	DTOAD	DTOA
!
!	FTIME is excluded
!	SCANF was excluded
!
!	Compiles all files from CRS: and CLS: to CRB:
!
!	Builds CRB:CLIB.OBJ library with ATOFD, DTOAD
!	Builds CRB:FLIB.OBJ library with ATOF, DTOA 
!
!	NOTE: RUST RIDER/C does not use CLIB
!	(CTB:CRT.OBJ includes a smaller runtime)
!
!	CLS:RT11.EIS	C$AUTO = -10 (was -6). See CLS:CSV.MAC
!			RMSIO = 0
!	CRS:RT11.EIS	Update to CLS:RT11.EIS
!
!	IJH Changes:
!
!	CRS:ATOF.MAC	;??	Now in FLIB.OBJ
!	CRS:DTOA.MAC	;??	Now in FLIB.OBJ
!	CRS:FCLOSE.MAC	;18	ARB flush fix
!	CRS:INIT.MAC	;43	.even typo
!	CRS:INIT.MAC	;44	.settop
!	CRS:INIT.MAC	;45	Add CCL command
!	CRS:IOFOPT.MAC	;05	Add "b" to fopen() mode
!	CRS:IOPUTC.MAC	;15	;vf$bzy - typo
!	CRS:SUPORT.MAC	;14	Now in CLIB.OBJ
!	CRS:FSEEK.MAC	;15	Permit seek to output file under RUST
!
@ops:up crs crb clib.obj 'P1' 'P2'
tem$ mac$ crs crb custom
cus$ := macro crs:rt11.eis+crs:^1/object:crb:^1
!
! CRS: modules
!
mac$ ABORT
mac$ ATOD
mac$ ATOF
mac$ ATOFD
mac$ CLEARE
mac$ DELETE
mac$ DOPRNT
mac$ DOSCAN
mac$ DOUTAB
mac$ DTOA
mac$ DTOAD
mac$ ERROR
mac$ EXIT
mac$ FCLEAR
mac$ FCLOSE
mac$ FEOF
mac$ FERR
mac$ FERROR
mac$ FFLUSH
mac$ FGET
mac$ FGETNA
mac$ FGETS
mac$ FILENO
mac$ FLUN
mac$ FMKDL
mac$ FOPEN
mac$ FPRINT
mac$ FPUT
mac$ FREAD
mac$ FREC
mac$ FSCANF
mac$ FSEEK
mac$ FSPOOL
mac$ FTELL
mac$ FTIME
mac$ FTTY
mac$ FWILD
mac$ FWRITE
mac$ GETCHA
mac$ GETCMD
mac$ GETS
mac$ GETTTY
mac$ GETW
mac$ INIT
mac$ IOABUF
mac$ IOCL16
mac$ IOCLFU
mac$ IOCSI
mac$ IOFALO
mac$ IOFLSH
mac$ IOFLUN
mac$ IOFOPA
mac$ IOFOPT
mac$ IOGET
mac$ IOGETC
mac$ IOPUT
mac$ IOPUTC
mac$ IOQIOW
mac$ IOV
mac$ ISATTY
mac$ KBIN
mac$ KBINR
mac$ MEMDMP
mac$ MSG
mac$ PEEK
mac$ PERROR
mac$ PRINTF
mac$ PRMT
mac$ PROFIL
mac$ PUTCHA
mac$ PUTS
mac$ PUTW
mac$ QSET
mac$ REWIND
mac$ RSTSYS
mac$ RTEMT
mac$ RTIME
mac$ SBRK
mac$ SCANF
mac$ SCREEN
mac$ SETCC
mac$ SLEEP
mac$ SPRINT
mac$ SSCANF
mac$ SUPORT
mac$ TIME
mac$ TOD
mac$ TRAPS
mac$ UNGETC
mac$ UTIME
!
! CLS: modules
!
tem$ mac$ cls crb custom
cus$ := macro cls:rt11.eis+cls:^1/object:crb:^1
!
mac$ ABS
mac$ ALLOC
mac$ ASCR50
mac$ ASLL
mac$ ASLLI
mac$ ASRU
mac$ ATOI
mac$ ATOL
mac$ BRK
mac$ C5TA
mac$ CALL
mac$ CALLC
mac$ CALLER
mac$ CALLOC
mac$ CALLTR
mac$ CONCAT
mac$ COPY
mac$ CPYSTR
mac$ CSV
mac$ CTIME
mac$ CTYPE
mac$ DIV2
mac$ DIVL
mac$ EIS
mac$ ENVSET
mac$ FABS
mac$ FADD
mac$ FILL
mac$ FIS
mac$ FMUL
mac$ FPS
mac$ INCHR
mac$ INDEX
mac$ IRAND
mac$ ISALLO
mac$ ISALNU
mac$ ISALPH
mac$ ISASCI
mac$ ISCTRL
mac$ ISDIGI
mac$ ISGRAP
mac$ ISLOWE
mac$ ISPRIN
mac$ ISPUNC
mac$ ISSPAC
mac$ ISUPPE
mac$ ISXDIG
mac$ ITOA
mac$ ITOA8
mac$ ITOAX
mac$ LOCALT
mac$ LTOA
mac$ MALINK
mac$ MALLOC
mac$ MAMCHK
mac$ MAXMIN
mac$ MSIZE
mac$ MULL
mac$ MUTE
mac$ NARG
mac$ PCSV
mac$ R50TOA
mac$ RAND
mac$ RCTIME
mac$ REALLO
mac$ RINDEX
mac$ SALLOC
mac$ SAVR1
mac$ SETJMP
mac$ STRCAT
mac$ STRCHR
mac$ STRCMP
mac$ STRCPY
mac$ STREQ
mac$ STRLEN
mac$ STRNCA
mac$ STRNCM
mac$ STRNCP
mac$ STRNEQ
mac$ STRRCH
mac$ SWABB
mac$ SWABI
mac$ TOASCI
mac$ TOLOWE
mac$ TOUPPE
mac$ UNWIND
mac$ WDLENG
mac$ WRAPUP
mac$ ZERO
!
mrg$
lib:
log$ CLIB.OBJ
R LIBR
CRB:CLIB=CRB:ABORT//
crb:ATOD
!!!:ATOF
!!!:ATOFD
crb:CLEARE
crb:DELETE
crb:DOPRNT
crb:DOSCAN
crb:DOUTAB
!!!:DTOA
!!!:DTOAD
crb:ERROR
crb:EXIT
crb:FCLEAR
crb:FCLOSE
crb:FEOF
crb:FERR
crb:FERROR
crb:FFLUSH
crb:FGET
crb:FGETNA
crb:FGETS
crb:FILENO
crb:FLUN
crb:FMKDL
crb:FOPEN
crb:FPRINT
crb:FPUT
crb:FREAD
crb:FREC
crb:FSCANF
crb:FSEEK
crb:FSPOOL
crb:FTELL
crb:FTIME
crb:FTTY
crb:FWILD
crb:FWRITE
crb:GETCHA
crb:GETCMD
crb:GETS
crb:GETTTY
crb:GETW
crb:INIT
crb:IOABUF
crb:IOCL16
crb:IOCLFU
crb:IOCSI
crb:IOFALO
crb:IOFLSH
crb:IOFLUN
crb:IOFOPA
crb:IOFOPT
crb:IOGET
crb:IOGETC
crb:IOPUT
crb:IOPUTC
crb:IOQIOW
crb:IOV
crb:ISATTY
crb:KBIN
crb:KBINR
crb:MEMDMP
crb:MSG
crb:PEEK
crb:PERROR
crb:PRINTF
crb:PRMT
crb:PROFIL
crb:PUTCHA
crb:PUTS
crb:PUTW
crb:QSET
crb:REWIND
crb:RSTSYS
crb:RTEMT
crb:RTIME
crb:SBRK
crb:SCANF
crb:SCREEN
crb:SETCC
crb:SLEEP
crb:SPRINT
crb:SSCANF
crb:SUPORT
crb:TIME
crb:TOD
crb:TRAPS
crb:UNGETC
crb:UTIME
!
! CLS: modules
!
crb:ABS
crb:ALLOC
crb:ASCR50
crb:ASLL
crb:ASLLI
crb:ASRU
crb:ATOI
crb:ATOL
crb:BRK
crb:C5TA
crb:CALL
crb:CALLC
crb:CALLER
crb:CALLOC
crb:CALLTR
crb:CONCAT
crb:COPY
crb:CPYSTR
crb:CSV
crb:CTIME
crb:CTYPE
crb:DIV2
crb:DIVL
crb:EIS
crb:ENVSET
crb:FABS
crb:FADD
crb:FILL
crb:FIS
crb:FMUL
crb:FPS
!!!:FTIME
crb:INCHR
crb:INDEX
crb:IRAND
crb:ISALLO
crb:ISALNU
crb:ISALPH
crb:ISASCI
crb:ISCTRL
crb:ISDIGI
crb:ISGRAP
crb:ISLOWE
crb:ISPRIN
crb:ISPUNC
crb:ISSPAC
crb:ISUPPE
crb:ISXDIG
crb:ITOA
crb:ITOA8
crb:ITOAX
crb:LOCALT
crb:LTOA
crb:MALINK
crb:MALLOC
crb:MAMCHK
crb:MAXMIN
crb:MSIZE
crb:MULL
crb:MUTE
crb:NARG
crb:PCSV
crb:R50TOA
crb:RAND
crb:RCTIME
crb:REALLO
crb:RINDEX
crb:SALLOC
crb:SAVR1
!!!:SCANF
crb:SETJMP
crb:STRCAT
crb:STRCHR
crb:STRCMP
crb:STRCPY
crb:STREQ
crb:STRLEN
crb:STRNCA
crb:STRNCM
crb:STRNCP
crb:STRNEQ
crb:STRRCH
crb:SWABB
crb:SWABI
crb:TOASCI
crb:TOLOWE
crb:TOUPPE
crb:UNWIND
crb:WDLENG
crb:WRAPUP
crb:ZERO
//
^C
copy crb:clib.obj crb:flib.obj
library crb:clib crb:atofd,crb:dtoad
library crb:flib crb:atof,crb:dtoa
end$:
