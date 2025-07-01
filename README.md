# DECUS-C
DECUS-C is a PDP-11 C compiler and an early example of open-source software.

I have been fixing bugs and adding minor functionality to the compiler since around 2004.

A quick and tentative summary the state of the RT-11 compiler and runtime along with additions follows.

I don't usually run the compiler under RT-11 so there may be teething problems.

Let me know in [Issues] above if you have problems with the software.


## FILES

```
/SRC	 Compiler, assembler, library sources
DCC.DSK	 The RT-11 DECUS-C runtime
*.TXT	 Original DECUS-C documentation	
```

## INSTALLATION
Copy the DECUS-C kit to a system disk or as a sub-disk. The instructions below assume DCC.SYS has been copied to the system disk.

Unmapped system support is usually only feasible for RT-11/SB (or RT-11/SJ).

	.mount ld: dcc c
	.run c:cc c:hello/a
 	.link hello/exe:hello,c:clib
  	.run hello

For mapped systems (RT-11/XM etc):

	.mount ld: dcc c
	.vrun c:cc c:hello/a
 	.link hello/exe:hello,c:clib
  	.run hello

## EIS SUPPORT
The runtime is currently linked for EIS hardware. 

The EI.SYS driver provides an emulation for machines lacking EIS support.

Installation for unmapped RT-11 systems (RT-11/SB, RT-11/FB):

	.copy dcc:ei.sys sy:/sys
	.install ei	
	.load ei

After rebooting only the LOAD command is required.

The EIS emulator is only supplied for unmapped systems (RT-11/SB, RT-11/FB).

EI.SYS is a driver I wrote back in the 1980s.


## FPU SUPPORT
The DECUS-C compiler does not include NOHARDWARE support for floating point. 

The FP.SYS driver provides an emulation for systems lacking FPU support.

Installation for unmapped RT-11 systems (RT-11/SB, RT-11/FB):

 	.copy dcc:fp.sys sy:/sys
	.set fp sysgen
	.install fp
 	.load fp

Installation for mapped systems (RT-11/XM, etc):

 	.copy dcc:fpx.sys sy:/sys
	.set fp sysgen
	.install fp
 	.load fp

After rebooting only the LOAD command is required.

FP.SYS is a DECUS driver written by Paul Lustgraaf.

## DECUS-C LIMITATIONS

```
o Basically V7 Ritchie C  
o Structure tag names are local to structure (Ritchie/Whitesmith not)  
o Few K&R standard libraries header files  
o No K&R function prototypes--only the result type is stored  
o Long and floating-point initializors must be constants  
o No unsigned char or unsigned long  
o No enum
o Character literals limited to two characters  
o Autos can't be initialized in-line with declaration   
o Pointers to functions must be explicit during application
```

## ADDITIONS
This list summarizes the more recent additions by 

```
void	void type supported (Johnny Bilquist)
i/d	I/D space supported (Johnny Bilquist)

//	"//" comments supported.
size_t	"size_t" supported--a synonym for unsigned.

fopen	fopen now supports "b", e.g. fopen ("myfile", "rb")
seek	Seek now allowed to files open for write.

scanf	"%x" hex mode error fixed.
main	Applications do not prompt for arguments if main has no parameters.
Y2K	Y2K support for listings etc.
LINK	The LINK command no longer needs to include SUPPORT.OBJ.
```

## COMPILER SPACE
One main limitation of DECUS-C has always been the limited amount of pool space available for the parser. In fact, the parser overlay is about 6kb shorter than the code generator, so I have made the 6kb available to the parser pool.


## CHANGE REPORT
A more detailed list of the changes I've made to DECUS-C.

```
CCS:CC000.MAC
29  4-Feb-04 IJH	Extend pool space for RT-11 (OVRJOB)

CCS:CC001.MAC
27 17-Jun-11 IJH	Increase macro buffer size. See RUST.MAC.

CCS:CC0RT.MAC
22  4-Feb-04 IJH	Increase parser pool space for RT-11.

CCS:CC100.MAC
29 04-Feb-04 IJH	"static int ();" was treated as function definition.
			Now parsed correctly as declaration (like "extern").
			Sticky on subsequent function definition, indeed
			anything else would be type/class conflict.
30 15-Feb-04 IJH	Permit redundant comma before closing brace in data
			initializers. Standard C behaviour.
31 28-Feb-04 IJH	One of three loops to skip "bad input" was calling
			SCAN rather than ESCAN and got stuck on OP.CST which
			is what ESCAN was explicitly designed to handle.
CCS:CC101
13 22-Jan-04 IJH	Disable psect/dsect/ident statements in RUST build. 
			These symbols clash with existing applications. Use
			"pragma psect" etc instead...

14 11-Jun-09 IJH	Add // comments
15 03-Apr-15 IJH	Add Standard C "size_t" type (synonym for "unsigned")
			Remove redundant forced lower case in KWS: ???

CCS:CC107		New two line module to return end address of parser.
			Required because of RT-11 LINKER treatment of overlay labels.

CCS:CC300
20 04-Feb-04 IJH	Add ARB .SERR/.HERR code 

CLS:CSV.MAC
08 IJH			Fudged exit code at DIVL.MAC exit: did not match C$RET.
			Note on dependency added at C$SAV. Comment only.
09 IJH			Use .END to invoke $$MAIN. RUST/RT-11 only.


CLS:RT11.EIS		C$AUTO = -10 (was -6). See CLS:CSV.MAC
			RMSIO = 0
CRS:RT11.EIS		Update to CLS:RT11.EIS

CRS:DTOA.MAC		Now in FLIB.OBJ

CRS:FCLOSE.MAC	;18	ARB flush fix		-- label
CRS:FSEEK.MAC	;18	Allow seek on files opened for write.

CRS:INIT.MAC
43 11-Dec-03 IJH	Even up PC before definition of $$ngmc:
44  1-Feb-04 IJH	Use .SETTOP to determine $$mend for RT-11
45 25-Feb-04 IJH	Support RT-11 V5.x CCL interface to get command without
;			CSI mangling.

CRS:IOFOPT.MAC	;05	Add "b" to fopen() mode
CRS:IOPUTC.MAC	;15	;vf$bzy - typo
CRS:SUPORT.MAC	;14	Now in CLIB.OBJ

CCS:C1EXT.MAC	mut$c	Auto-detect main() without arguments and suppress
CCS:C2MAI.MAC	mut$c	"Argv" prompt. Alternative to "$$narg = 1"
CLS:MUTE.MAC	mut$c
CRS:INIT.MAC	mut$c		

CRS:DOSCAN.MAC	;11	00007b dispatched hex to octal decode--had BPL/BEQ,
			-changed to BEQ/BPL
11 27-Jul-24 IJH	00007b dispatched hex to octal decode because branch
			order BPL/BEQ was wrong. BEQ/BPL was right.

CCS:LDATE.MAC
 3 01-Mar-25 IJH	RT-11 Y2K update and correct month mask

CRS:RT11.MAC
CLS:RT11.MAC
 1 12-Mar-25 IJH	Add C$$CRA conditional and change CRASH from 
			<BPT> to <CALL C$RASH>. See CSV.MAC.
CLS:CSAV.MAC
10 IJH			Add C$$CRA replacing CRASH <BPT> with a message.
```
