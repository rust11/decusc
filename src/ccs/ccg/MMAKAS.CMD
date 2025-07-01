.ENABLE SUBSTITUTION
.; DECUS C AS assembler V02.13 build command file for native RSX-11M.
.; By
.;	Bob Denny
.;	17-Oct-82
.;
.SETS DIR <DIRECT>
.SETS UIC <UIC>
.IF DIR <> "[]" .SETS UIC <LOGUIC>
.SETS CLI <CLI>
.IF CLI NE "MCR" MCR SET /CLI=TI:MCR
SET /NONAMED
SET /UIC=[5,4]
; MMAKAS.CMD
;
; Make the AS assembler, RSX-style.
;
.SETS TPR ""
.IFNDF $V32 .ASK $V32 Are you running on RSX-11M V3.2
.IFT $V32 .SETS TPR "BIG"
;
; Note that the Library OB:XCOMLB.OLB must have already been built
; by executing the compiler build procedure. RSX.MAC must have already
; been edited for your system, per the compiler build procedure.
;
.IFDF $ASNOK .GOTO 100
.ASK OK Have you completed the compiler build yet?
.IFF OK .EXIT
;
; You must override the assignments in this file if you want the following
; logical devices to be assigned to other than SY:
;
;	SR:	Source and command files must be on this device.
;	LS:	Listings go to this device.
;	OB:	Objects go to this device.
;	MP:	Maps go to this device.
;	OU:	Task images go to this device.
;
ASN SY:=SR:
ASN NL:=LS:
ASN SY:=OB:
ASN SY:=MP:
ASN SY:=OU:
;
.ASK OK Are the above assignments OK?
.IFT OK .GOTO 100
;
; We will now pause so that you may change assignment(s)...
.PAUSE
.100:
;
; You may alter the default p-section maximum and/or branch table
; size. The default values represent a good compromise between task
; size and capability. They allow for 10 p-sections and 250 branch
; table entries. To choose the default, answer with a carriage return.
;
.IFNDF $PSIZE .ASKN [::10.] $PSIZE Maximum number of p-sections
.IFNDF $FSIZE .ASKN [::250.] $FSIZE Branch table size
.OPEN SR:ASMPAR.MAC
.ENABLE DATA
;    This assembly created from MMAKAS.CMD.
;
;    *** SET ASSEMBLER TABLE SIZES ***
;	'<DATE>'	'<TIME>'
;    *********************************
;
	PSIZE = '$PSIZE'.
	FSIZE = '$FSIZE'.
;
;
.DISABLE DATA
.CLOSE
;
.IFNDF $UMAP .ASK $UMAP Will the compiler be running on an unmapped system
.IFF $UMAP .GOTO 120
;
.IFNDF $PAR .ASKS $PAR Enter partition parameters TKB style [name:base:size]
.120:
.IFNDF $PAR .SETS $PAR "GEN"
;
.IFNDF $FCSRE .ASK $FCSRE Task build with FCSRES shared library
.IFNDF $FCSFS .ASK $FCSFS Task build with FCSFSL supervisor mode library
;
;Take a break.
;
TIM
; Assemble the assembler
;
.IFNINS ...MAC INS $'TPR'MAC
MAC OB:AS0,LS:AS0/-SP=SR:RSX,SR:AS0
.IF <EXSTAT> NE 1 .GOTO 700
MAC OB:AS1,LS:AS1/-SP=SR:RSX,SR:AS1
.IF <EXSTAT> NE 1 .GOTO 700
MAC OB:AS2,LS:AS2/-SP=SR:RSX,SR:AS2
.IF <EXSTAT> NE 1 .GOTO 700
MAC OB:AS3A,LS:AS3A/-SP=SR:RSX,SR:AS3A
.IF <EXSTAT> NE 1 .GOTO 700
MAC OB:AS3B,LS:AS3B/-SP=SR:RSX,SR:AS3B
.IF <EXSTAT> NE 1 .GOTO 700
MAC OB:AS3C,LS:AS3C/-SP=SR:RSX,SR:AS3C
.IF <EXSTAT> NE 1 .GOTO 700
MAC OB:AS3D,LS:AS3D/-SP=SR:RSX,SR:AS3D
.IF <EXSTAT> NE 1 .GOTO 700
MAC OB:AS3E,LS:AS3E/-SP=SR:RSX,SR:AS3E
.IF <EXSTAT> NE 1 .GOTO 700
MAC OB:AS3F,LS:AS3F/-SP=SR:RSX,SR:ASMPAR,SR:AS3F
.IF <EXSTAT> NE 1 .GOTO 700
MAC OB:AS3G,LS:AS3G/-SP=SR:RSX,SR:AS3G
.IF <EXSTAT> NE 1 .GOTO 700
MAC OB:AS3H,LS:AS3H/-SP=SR:RSX,SR:AS3H
.IF <EXSTAT> NE 1 .GOTO 700
;
TIM
; Task Build the assembler
;
.OPEN SR:MASBLD.TKB
.IFF $UMAP .DATA OU:AS/CP/MM,MP:AS/NOSP=SR:XASBLD/MP
.IFT $UMAP .DATA OU:AS/CP/-MM,MP:AS/NOSP=SR:XASBLD/MP
.ENABLE DATA
ASG=TI:1,SY:2:3:4
UNITS=4
TASK=...XAS
.DISABLE DATA
.IFT $FCSRE .DATA LIBR=FCSRES:RO
.IFT $FCSFS .DATA SUPLIB=FCSFSL:SV
.IFT $UMAP .DATA PAR='$PAR'
.CLOSE
;
.IFNINS ...TKB INS $'TPR'TKB
TKB @SR:MASBLD.TKB
.IF <EXSTAT> NE 1 .GOTO 700
PIP SR:MASBLD.TKB;*/DE,ASMPAR.MAC;*
;
TIM
; Assembler build complete
;
.SETT OK
.GOTO 1000
.700:
; There has been an error. Please re-read the AS manual. This assembler has
; been successfully built on an unmapped 11/05 and a mapped 11/34.
;
.SETF OK
.1000:
.IF DIR = "[]" .GOTO 1010
SET /NAMED
SET /DEF='DIR'
.1010:
SET /UIC='UIC'
SET /CLI=TI:'CLI'
.IFF OK .EXIT 2
.EXIT 1
