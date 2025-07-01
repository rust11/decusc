/*
 *	***********************
 *	*  R M S T D I O . H  *
 *	***********************
 *
 * Stdio header file for RMS-11 V2 I/O.  Version of 12-Dec-83
 *
 */

#ifdef	DOCUMENTATION

title	rmstdio	Definitions for standard i/o library (RMS-11)
index		Definitions for standard i/o library (RMS-11)

Synopsis

	#include <rmstdio.h>

Description

	<rmstdio.h> should be included in the assembly of C programs on
	RSX-11M, RSX-11M Plus and P/OS
	that use the standard i/o functions (fopen(), getc(), printf(), etc.)
	and are linked to the RMS-11 version of the runtime library.
	.s
	It defines the following:
	.s
	  FILE	The  i/o  routines  use  and  return pointers to
		objects of this type.
	.s
	  NULL	I/O routines signal "rejection" by  returning  a
		null pointer.
	.s
	  EOF	The get character routine returns this value  to
		signal end of file.
	.s
	  TRUE	The value 1.
	.s
	  FALSE	The value 0.
	.s
	  EOS	The "end of string" marker: '\0'.
	.s
	.br;##IO__SUCCESS#Normal exit to operating system.
	.s
	.br;##IO__WARNING#"Warning error" exit to operating system.
	.s
	.br;##IO__ERROR###"Error" exit to operating system.
	.s
	.br;##IO__FATAL###"Severe error" exit to operating system.
	.s
	stdin	The "standard" input file.  Normally the  user's
		terminal; it may be redirected.
	.s
	stdout	The "standard" output file.  Normally the user's
		terminal; it may be redirected.
	.s
	stderr	The "error" output file.  It will  always  write
		to the user's terminal.

Differences from Unix

	FILE is defined as a "typedef struc", rather than a #define.
	The i/o structure is considerably different from Unix.
	It is, however, arranged so that reasonable compatibility
	may be attained.  Specifically, things which have the same
	name are used for the same purpose, and located in the same
	place within the I/O structure.

Bugs

	TRUE, FALSE, and EOS are not transportable to other
	C systems.
	.s
	There are no explicit checks for the special flavor of
	IOV used for RMS.

#endif

#ifndef	IO_OPN
/*
 * Note: _... is identical to Unix usage, while io_... is for Decus C
 */

typedef struct IOV {
	int	_cnt;		/* Bytes left in buffer	*/
	char	*_ptr;		/* Free spot in buffer	*/
	char	*_base;		/* Base of buffer	*/
	int	_flag;		/* Flag word 		*/
	int	_wflag;		/* Wild card flags	*/
	char	*io_wild;	/* Wild card buffer	*/
	int	io_rbsz;	/* Record buffer size	*/
	char	*io_bbuf;	/* Block buffer start	*/
	int	io_uic;		/* File's UIC in binary	*/
	char	*io_dnam;	/* Directory name ptr.	*/
	int	rms_stuff[0];	/* Rest is RMS junk */
} FILE;

#define	MAXLUN	15
extern	FILE	*$$luns[];	/* Lun table		*/

/*
 * Bits in ((FILE *)fd)->_flag:
 *	_NAME		Compatible with Unix usage
 *	IO_NAME		Decus C specific.
 */

#define	_IOREAD		0000001	/* Open for reading	*/
#define	_IOWRT		0000002	/* Open for writing	*/
#define	_IONBF		0000004	/* Unbuffered "u" mode	*/
#define	_IOMYBUF	0000010	/* io stuff got buffer	*/
#define	_IOEOF		0000020	/* Eof seen if set	*/
#define	_IOERR		0000040	/* Error seen if set	*/
#define	_IOSTRG		0000100	/* for sprintf, sscanf	*/
#define _IORW		0000200	/* Open for read/write	*/

/*
 * Bits in fd->_flag (all in high byte of that word)
 * These are needed for Dec-style i/o.
 */

#define	IO_BZY		0000400	/* Buffer busy (RT11)	*/
#define	IO_APN		0001000	/* Append mode open	*/
#define	IO_NOS		0002000	/* No newlines needed	*/
#define IO_NEWL		0004000 /* RSX TTY newline hack	*/
#define	IO_FIL		0010000	/* Disk file		*/
#define	IO_TTY		0020000	/* Console terminal	*/
#define	IO_REC		0040000	/* Record device	*/
#define	IO_OPN		0100000	/* Open file		*/

/*
 * The following bits are set in fd->io_wflag. They are needed for wild-card
 * processing.  Note: IO_WLD must be in the low byte.
 */

#define IO_WLD	0000001		/* fwild: wildcard file	*/
#define IO_VM1	0000002		/* fwild: version ;-1	*/
#define IO_VER	0000004		/* fwild: ;0 or ;-1	*/
#define IO_WF1	0000010		/* fwild first flag	*/
#define	IO_NLH	0000020		/* fopen 'n' hack bit	*/

/*
 * Common definitions
 */

#define EOF	(-1)		/* End of file by getc	*/
#define NULL	(0)		/* Impossible pointer	*/
/*
 * Warning -- the following definitions are not transportable
 */
#define TRUE	1		/* if (TRUE)		*/
#define FALSE	0		/* if (!TRUE)		*/
#define EOS	0		/* End of string	*/
#define	IO_SUCCESS	1	/* Normal exit		*/
#define	IO_WARNING	0	/* Warning error	*/
#define	IO_ERROR	2	/* Error		*/
#define	IO_FATAL	4	/* Severe error		*/

extern	FILE	*stdin;		/* Standard input file	*/
extern	FILE	*stdout;	/* Standard output file	*/
extern 	FILE	*stderr;	/* Standard error file	*/
extern	char	*fgets();	/* Defined by unix	*/
extern	int	$$ferr;		/* Error codes set here	*/
extern	int	$$exst;		/* Exit status set here	*/

#endif
