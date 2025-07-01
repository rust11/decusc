set tt noquiet
!
!	CLIB.COM
!
!	CLS:RT11.EIS	C$AUTO = -10 (was -6). See CLS:CSV.MAC
!			RMSIO = 0
!	CRS:RT11.EIS	Update to CLS:RT11.EIS
!
!	CRS:DTOA.MAC	;??	Now in CLIB.OBJ
!	CRS:FCLOSE.MAC	;18	ARB flush fix
!	CRS:INIT.MAC	;43	.even typo
!	CRS:INIT.MAC	;44	.settop
!	CRS:INIT.MAC	;45	Add CCL command
!	CRS:IOFOPT.MAC	;05	Add "b" to fopen() mode
!	CRS:IOPUTC.MAC	;15	;vf$bzy - typo
!	CRS:SUPORT.MAC	;14	Now in CLIB.OBJ
!	CRS:FSEEK.MAC	;15	Permit seek to output file under RUST
!
goto 'p1'
!
!macro crs:rt11.eis+crs:ABORT/object:crb:ABORT
!macro crs:rt11.eis+crs:ATOD/object:crb:ATOD
!macro crs:rt11.eis+crs:ATOF/object:crb:ATOF
!macro crs:rt11.eis+crs:ATOFD/object:crb:ATOFD
!macro crs:rt11.eis+crs:CLEARE/object:crb:CLEARE
!macro crs:rt11.eis+crs:DELETE/object:crb:DELETE
!macro crs:rt11.eis+crs:DOPRNT/object:crb:DOPRNT
!macro crs:rt11.eis+crs:DOSCAN/object:crb:DOSCAN
!macro crs:rt11.eis+crs:DOUTAB/object:crb:DOUTAB
!macro crs:rt11.eis+crs:DTOA/object:crb:DTOA
!macro crs:rt11.eis+crs:DTOAD/object:crb:DTOAD
!macro crs:rt11.eis+crs:ERROR/object:crb:ERROR
!macro crs:rt11.eis+crs:EXIT/object:crb:EXIT
!macro crs:rt11.eis+crs:FCLEAR/object:crb:FCLEAR
!macro crs:rt11.eis+crs:FCLOSE/object:crb:FCLOSE
!macro crs:rt11.eis+crs:FEOF/object:crb:FEOF
!macro crs:rt11.eis+crs:FERR/object:crb:FERR
!macro crs:rt11.eis+crs:FERROR/object:crb:FERROR
!macro crs:rt11.eis+crs:FFLUSH/object:crb:FFLUSH
!macro crs:rt11.eis+crs:FGET/object:crb:FGET
!macro crs:rt11.eis+crs:FGETNA/object:crb:FGETNA
!macro crs:rt11.eis+crs:FGETS/object:crb:FGETS
!macro crs:rt11.eis+crs:FILENO/object:crb:FILENO
!macro crs:rt11.eis+crs:FLUN/object:crb:FLUN
!macro crs:rt11.eis+crs:FMKDL/object:crb:FMKDL
!macro crs:rt11.eis+crs:FOPEN/object:crb:FOPEN
!macro crs:rt11.eis+crs:FPRINT/object:crb:FPRINT
!macro crs:rt11.eis+crs:FPUT/object:crb:FPUT
!macro crs:rt11.eis+crs:FREAD/object:crb:FREAD
!macro crs:rt11.eis+crs:FREC/object:crb:FREC
!macro crs:rt11.eis+crs:FSCANF/object:crb:FSCANF
!macro crs:rt11.eis+crs:FSEEK/object:crb:FSEEK
!macro crs:rt11.eis+crs:FSPOOL/object:crb:FSPOOL
!macro crs:rt11.eis+crs:FTELL/object:crb:FTELL
!macro crs:rt11.eis+crs:FTIME/object:crb:FTIME
!macro crs:rt11.eis+crs:FTTY/object:crb:FTTY
!macro crs:rt11.eis+crs:FWILD/object:crb:FWILD
!macro crs:rt11.eis+crs:FWRITE/object:crb:FWRITE
!macro crs:rt11.eis+crs:GETCHA/object:crb:GETCHA
!macro crs:rt11.eis+crs:GETCMD/object:crb:GETCMD
!macro crs:rt11.eis+crs:GETS/object:crb:GETS
!macro crs:rt11.eis+crs:GETTTY/object:crb:GETTTY
!macro crs:rt11.eis+crs:GETW/object:crb:GETW
!macro crs:rt11.eis+crs:INIT/object:crb:INIT
!macro crs:rt11.eis+crs:IOABUF/object:crb:IOABUF
!macro crs:rt11.eis+crs:IOCL16/object:crb:IOCL16
!macro crs:rt11.eis+crs:IOCLFU/object:crb:IOCLFU
!macro crs:rt11.eis+crs:IOCSI/object:crb:IOCSI
!macro crs:rt11.eis+crs:IOFALO/object:crb:IOFALO
!macro crs:rt11.eis+crs:IOFLSH/object:crb:IOFLSH
!macro crs:rt11.eis+crs:IOFLUN/object:crb:IOFLUN
!macro crs:rt11.eis+crs:IOFOPA/object:crb:IOFOPA
!macro crs:rt11.eis+crs:IOFOPT/object:crb:IOFOPT
!macro crs:rt11.eis+crs:IOGET/object:crb:IOGET
!macro crs:rt11.eis+crs:IOGETC/object:crb:IOGETC
!macro crs:rt11.eis+crs:IOPUT/object:crb:IOPUT
!macro crs:rt11.eis+crs:IOPUTC/object:crb:IOPUTC
!macro crs:rt11.eis+crs:IOQIOW/object:crb:IOQIOW
!macro crs:rt11.eis+crs:IOV/object:crb:IOV
!macro crs:rt11.eis+crs:ISATTY/object:crb:ISATTY
!macro crs:rt11.eis+crs:KBIN/object:crb:KBIN
!macro crs:rt11.eis+crs:KBINR/object:crb:KBINR
!macro crs:rt11.eis+crs:MEMDMP/object:crb:MEMDMP
!macro crs:rt11.eis+crs:MSG/object:crb:MSG
!macro crs:rt11.eis+crs:PEEK/object:crb:PEEK
!macro crs:rt11.eis+crs:PERROR/object:crb:PERROR
!macro crs:rt11.eis+crs:PRINTF/object:crb:PRINTF
!macro crs:rt11.eis+crs:PRMT/object:crb:PRMT
!macro crs:rt11.eis+crs:PROFIL/object:crb:PROFIL
!macro crs:rt11.eis+crs:PUTCHA/object:crb:PUTCHA
!macro crs:rt11.eis+crs:PUTS/object:crb:PUTS
!macro crs:rt11.eis+crs:PUTW/object:crb:PUTW
!macro crs:rt11.eis+crs:QSET/object:crb:QSET
!macro crs:rt11.eis+crs:REWIND/object:crb:REWIND
!macro crs:rt11.eis+crs:RSTSYS/object:crb:RSTSYS
!macro crs:rt11.eis+crs:RTEMT/object:crb:RTEMT
!macro crs:rt11.eis+crs:RTIME/object:crb:RTIME
!macro crs:rt11.eis+crs:SBRK/object:crb:SBRK
macro crs:rt11.eis+crs:SCANF/object:crb:SCANF
!macro crs:rt11.eis+crs:SCREEN/object:crb:SCREEN
!macro crs:rt11.eis+crs:SETCC/object:crb:SETCC
!macro crs:rt11.eis+crs:SLEEP/object:crb:SLEEP
!macro crs:rt11.eis+crs:SPRINT/object:crb:SPRINT
!macro crs:rt11.eis+crs:SSCANF/object:crb:SSCANF
!macro crs:rt11.eis+crs:SUPORT/object:crb:SUPORT
!macro crs:rt11.eis+crs:TIME/object:crb:TIME
!macro crs:rt11.eis+crs:TOD/object:crb:TOD
!macro crs:rt11.eis+crs:TRAPS/object:crb:TRAPS
!macro crs:rt11.eis+crs:UNGETC/object:crb:UNGETC
!macro crs:rt11.eis+crs:UTIME/object:crb:UTIME
!
! CLS: modules
!
!macro cls:rt11.eis+cls:ABS/object:crb:ABS
!macro cls:rt11.eis+cls:ALLOC/object:crb:ALLOC
!macro cls:rt11.eis+cls:ASCR50/object:crb:ASCR50
!macro cls:rt11.eis+cls:ASLL/object:crb:ASLL
!macro cls:rt11.eis+cls:ASLLI/object:crb:ASLLI
!macro cls:rt11.eis+cls:ASRU/object:crb:ASRU
!macro cls:rt11.eis+cls:ATOI/object:crb:ATOI
!macro cls:rt11.eis+cls:ATOL/object:crb:ATOL
!macro cls:rt11.eis+cls:BRK/object:crb:BRK
!macro cls:rt11.eis+cls:C5TA/object:crb:C5TA
!macro cls:rt11.eis+cls:CALL/object:crb:CALL
!macro cls:rt11.eis+cls:CALLC/object:crb:CALLC
!macro cls:rt11.eis+cls:CALLER/object:crb:CALLER
!macro cls:rt11.eis+cls:CALLOC/object:crb:CALLOC
!macro cls:rt11.eis+cls:CALLTR/object:crb:CALLTR
!macro cls:rt11.eis+cls:CONCAT/object:crb:CONCAT
!macro cls:rt11.eis+cls:COPY/object:crb:COPY
!macro cls:rt11.eis+cls:CPYSTR/object:crb:CPYSTR
!macro cls:rt11.eis+cls:CSV/object:crb:CSV
!macro cls:rt11.eis+cls:CTIME/object:crb:CTIME
!macro cls:rt11.eis+cls:CTYPE/object:crb:CTYPE
!macro cls:rt11.eis+cls:DIV2/object:crb:DIV2
!macro cls:rt11.eis+cls:DIVL/object:crb:DIVL
!macro cls:rt11.eis+cls:EIS/object:crb:EIS
!macro cls:rt11.eis+cls:ENVSET/object:crb:ENVSET
!macro cls:rt11.eis+cls:FABS/object:crb:FABS
!macro cls:rt11.eis+cls:FADD/object:crb:FADD
!macro cls:rt11.eis+cls:FILL/object:crb:FILL
!macro cls:rt11.eis+cls:FIS/object:crb:FIS
!macro cls:rt11.eis+cls:FMUL/object:crb:FMUL
!macro cls:rt11.eis+cls:FPS/object:crb:FPS
!!!!!! cls:rt11.eis+cls:FTIME/object:crb:FTIME
!macro cls:rt11.eis+cls:INCHR/object:crb:INCHR
!macro cls:rt11.eis+cls:INDEX/object:crb:INDEX
!macro cls:rt11.eis+cls:IRAND/object:crb:IRAND
!macro cls:rt11.eis+cls:ISALLO/object:crb:ISALLO
!macro cls:rt11.eis+cls:ISALNU/object:crb:ISALNU
!macro cls:rt11.eis+cls:ISALPH/object:crb:ISALPH
!macro cls:rt11.eis+cls:ISASCI/object:crb:ISASCI
!macro cls:rt11.eis+cls:ISCTRL/object:crb:ISCTRL
!macro cls:rt11.eis+cls:ISDIGI/object:crb:ISDIGI
!macro cls:rt11.eis+cls:ISGRAP/object:crb:ISGRAP
!macro cls:rt11.eis+cls:ISLOWE/object:crb:ISLOWE
!macro cls:rt11.eis+cls:ISPRIN/object:crb:ISPRIN
!macro cls:rt11.eis+cls:ISPUNC/object:crb:ISPUNC
!macro cls:rt11.eis+cls:ISSPAC/object:crb:ISSPAC
!macro cls:rt11.eis+cls:ISUPPE/object:crb:ISUPPE
!macro cls:rt11.eis+cls:ISXDIG/object:crb:ISXDIG
!macro cls:rt11.eis+cls:ITOA/object:crb:ITOA
!macro cls:rt11.eis+cls:ITOA8/object:crb:ITOA8
!macro cls:rt11.eis+cls:ITOAX/object:crb:ITOAX
!macro cls:rt11.eis+cls:LOCALT/object:crb:LOCALT
!macro cls:rt11.eis+cls:LTOA/object:crb:LTOA
!macro cls:rt11.eis+cls:MALINK/object:crb:MALINK
!macro cls:rt11.eis+cls:MALLOC/object:crb:MALLOC
!macro cls:rt11.eis+cls:MAMCHK/object:crb:MAMCHK
!macro cls:rt11.eis+cls:MAXMIN/object:crb:MAXMIN
!macro cls:rt11.eis+cls:MSIZE/object:crb:MSIZE
!macro cls:rt11.eis+cls:MULL/object:crb:MULL
!macro cls:rt11.eis+cls:NARG/object:crb:NARG
!macro cls:rt11.eis+cls:PCSV/object:crb:PCSV
!macro cls:rt11.eis+cls:R50TOA/object:crb:R50TOA
!macro cls:rt11.eis+cls:RAND/object:crb:RAND
!macro cls:rt11.eis+cls:RCTIME/object:crb:RCTIME
!macro cls:rt11.eis+cls:REALLO/object:crb:REALLO
!macro cls:rt11.eis+cls:RINDEX/object:crb:RINDEX
!macro cls:rt11.eis+cls:SALLOC/object:crb:SALLOC
!macro cls:rt11.eis+cls:SAVR1/object:crb:SAVR1
!!macro cls:rt11.eis+cls:SCANF/object:crb:SCANF
!macro cls:rt11.eis+cls:SETJMP/object:crb:SETJMP
!macro cls:rt11.eis+cls:STRCAT/object:crb:STRCAT
!macro cls:rt11.eis+cls:STRCHR/object:crb:STRCHR
!macro cls:rt11.eis+cls:STRCMP/object:crb:STRCMP
!macro cls:rt11.eis+cls:STRCPY/object:crb:STRCPY
!macro cls:rt11.eis+cls:STREQ/object:crb:STREQ
!macro cls:rt11.eis+cls:STRLEN/object:crb:STRLEN
!macro cls:rt11.eis+cls:STRNCA/object:crb:STRNCA
!macro cls:rt11.eis+cls:STRNCM/object:crb:STRNCM
!macro cls:rt11.eis+cls:STRNCP/object:crb:STRNCP
!macro cls:rt11.eis+cls:STRNEQ/object:crb:STRNEQ
!macro cls:rt11.eis+cls:STRRCH/object:crb:STRRCH
!macro cls:rt11.eis+cls:SWABB/object:crb:SWABB
!macro cls:rt11.eis+cls:SWABI/object:crb:SWABI
!macro cls:rt11.eis+cls:TOASCI/object:crb:TOASCI
!macro cls:rt11.eis+cls:TOLOWE/object:crb:TOLOWE
!macro cls:rt11.eis+cls:TOUPPE/object:crb:TOUPPE
!macro cls:rt11.eis+cls:UNWIND/object:crb:UNWIND
!macro cls:rt11.eis+cls:WDLENG/object:crb:WDLENG
!macro cls:rt11.eis+cls:WRAPUP/object:crb:WRAPUP
!macro cls:rt11.eis+cls:ZERO/object:crb:ZERO
!
!crb:SUPORT
!crb:ATOF
!crb:DTOA
!
lib:
R LIBR
CRB:CLIB=CRB:ABORT//
crb:ATOD
!!!:ATOF
crb:ATOFD
crb:CLEARE
crb:DELETE
crb:DOPRNT
crb:DOSCAN
crb:DOUTAB
!!!:DTOA
crb:DTOAD
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
crb:NARG
crb:PCSV
crb:R50TOA
crb:RAND
crb:RCTIME
crb:REALLO
crb:RINDEX
crb:SALLOC
crb:SAVR1
!crb:SCANF
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
