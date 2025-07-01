/*
 *				C S Y N . C
 */

/*)BUILD		$(PROGRAM) = CSYN
			$(RSXLIB) = C:CX.OLB
			$(RT11LIB) = C:CX.OBJ
			$TKBOPTIONS = {
				TASK = ...SYN
				LBR = FCSRES:RO
			}
*/

#ifdef	DOCUMENTATION

title	csyn	C Source Syntax Checker
index		C source syntax checker

synopsis

	csyn [-p] file

description

	Csyn does some quick -- and effective -- syntax checks on
	a source file.   The -p switch specifies that routines
	do not cross page boundaries.  I.e., '()', '{}', and '[]'
	and comments must balance at the end of each page.

	If an error is found, one line is printed showing the first
	error found and csyn then exits (with RSX exit status 0).
	If no error is found, csyn exits (with RSX exit status 1).

Implementation

	csyn must be linked with the CX (extensions) library.

Author

	Clifford Geschke

#endif

/* CSYN.C	C Source syntax checker.

   Clifford C. Geschke	31-Mar-82

   C source program syntax checker.... something that the compiler
   itself should do instead of getting lost.

   Command:	SYN  [-p] <file>

   where <file> is the C source file, default extension '.C'
	 -p	specifies that routines do not cross page boundaries
		(forces (), {}, [], and comments to balance at end of page).

   If failure, types one line showing the first error found
	and exits with exit status = 0.

   If success, types nothing and exits with exit status = 1.

TASK BUILD PROCEEDURE FOR RSX:

CSYN=CSYN
LB:[1,1]CX/LB,C/LB
/
TASK=...SYN
LIBR=FCSRES:RO
//


*/

#include <stdio2.h>

#define EOP	(-2)		/* End of page mark */

extern int $$ferr;		/* C file system error code */
extern FILE *fopen();		/* Open file */
$$narg = { 1 };			/* No command line prompting */

FILE *file;			/* Pointer to input file */
int page = { 1 };		/* Current page number */
int line = { 0 };		/* Current line number */
int pflag = { 0 };		/* Page break flag */
int incomment = { FALSE };	/* Flag TRUE when in comment */

getnc()			/* Get the next character */

{
    FAST int c;		/* Current character */
    FAST int cnew;	/* New character for inner loop */

    FOREVER {

    nextc:

	c = getc( file );	/* Get next char */    

    switchc:

	switch( c ) {

	case EOF: return;		/* Just return EOF */

	case '\n': {			/* Count newlines */
	    line++;
	    goto nextc;
	}

	case 014: {			/* Form feed = new page */
	    page++;			/* inc page number */
	    line = 0;			/* Set to line zero */

	    if ( pflag ) {
		return( EOP );		/* Return end of page */
	    }

	    goto nextc;
	}
#if 0
	case '#': {			/* Line number */ 

	    cpystr( oldhead, header );	/* Save old header */
	    fscanf( file, "%d %[^\n]", &line, header );
	    line--;			/* Adjust number */
	    sscanf( header, "10s", header );	/* Truncate to 10 chars */

	    if ( pflag && !streq( header, oldhead ) ) {
		return( EOP );		/* Return end of page */
	    }

	    goto nextc;
	}
#endif
	case 047:			/* Single quote */
	case 042: {			/* Double quote */

	    if ( incomment ) goto nextc; /* Ignore if in comment */

	    FOREVER {
		cnew = getc( file );
		if ( cnew == EOF ) break;
		if ( cnew == '\n' ) {
		    break;
	 	}

		if ( cnew == c ) goto nextc;	/* Get next char */
	    }

	    unmatch( c );		/* Char is unmatched */
	}

	case ' ': goto nextc;		/* Skip blanks */

	default: return( c );		/* Return everything else */

	} /* End of switch */
    } /* End of forever */
}

unmatch( c )		/* Report unmatched character */
int c;			/* The character */

{

    printf( "%c on line %d page %d unmatched\n",
		c, line, page );
 
    exst( 0 );		/* Exit with failure */
}

look4()			/* Look a character pair */

{
    FAST int cnew;	/* A new character */
    FAST int newright;	/* New right */
    FAST int newleft;	/* New left */
    int oldline;	/* Old line number */
    int oldpage;	/* Old page number */


    FOREVER {

	cnew = getnc();		/* Get next character */

	switch( cnew ) {	/* Let's see what we have */

	case '{': {
		newleft = '{';
		newright = '}';
		goto nested;		/* Nested pair */
	}

	case '(': {
		newleft = '(';
		newright = ')';
		goto nested;		/* Nested pair */
	}

	case '[': {
		newleft = '[';
		newright = ']';
		goto nested;		/* Nested pair */
	}

	case EOF:			/* A match ! */
	case EOP:
	case '}':
	case ')':
	case ']': {

		return( cnew );		/* Return */
	}

	case '/': {			/* Possible comment */

	    cnew = getc( file );	/* Get next character */
	    if ( cnew != '*' ) {	/* If not '*' */
		ungetc( cnew, file );	/* Put it back */
		continue;		/* and keep looking */
	    }

	    oldline = line;		/* Save line and page */
	    oldpage = page;
	    incomment = TRUE;		/* Set flag */

	    FOREVER {
		if ( ( cnew = getnc() ) < 0 ) {	/* Get next char */
		    printf(	/* If end of file or end of page */
			"Unterminated comment beginning on line %d, page %d\n",
			oldline, oldpage );
		    exst( 0 );		/* Exit with fail */
		}
		if ( cnew == '*' ) {	/* Possible end of comment */
		    cnew = getc( file );	/* Get next char */
		    if ( cnew == '/' ) break;	/* Exit loop if end comment */
		    ungetc( cnew, file );	/* Put back char */
		}
	    } /* end of comment FOREVER */

	    incomment = FALSE;

	    continue;				/* Keep looking */
	}

	case '*': {			/* Possible comment end */

	    cnew = getc( file );	/* Get next character */
	    if ( cnew != '/' ) {	/* If not '/' */
		ungetc( cnew, file );	/* Put it back */
		continue;		/* and keep looking */
	    }

	    printf( "Spurious comment terminator on line %d page %d\n",
		    line, page );
	    exst( 0 );		/* Exit with failure */
	}

	} /* End of switch */

	continue;

	/* Nested expression seen */

    nested:

	oldline = line;			/* Save old line */
	oldpage = page;			/* Save old page */

	cnew = look4();			/* Look for match */
	if ( cnew != newright ) break;	/* Break if mismatch */

    } /* End of FOREVER */


    /* Nested expression failed */

    printf( "%c on line %d page %d ", newleft, oldline, oldpage );

    if ( cnew == EOF ) {		/* If end of file */
	printf( "unmatched at end of file\n" );
    }
    else if ( cnew == EOP ) {		/* If end of page */
	printf( "unmatched at end of page\n" );
    }
    else {				/* Bad match */
	printf( "matched %c on line %d page %d\n", cnew, line, page );
    }

    exst( 0 );				/* Exit with failure */

}

main(argc, argv)		/* MAIN program */
  int   argc;			/* Argument count */
  char  **argv;			/* Argmuments */

{
    FAST int c;			/* Return code from look4() */
    FAST int arg;		/* File arg index */
    FAST char *f;		/* File name pointer */
    char filename[40];		/* File name buffer */

    /* Parse arguments */

    if ( argc < 2 ) exst(0);	/* Exit with failure */

    arg = 1;			/* File is arg 1 */

    if ( argc == 3 ) {		/* If extra parameter */
	if ( ! streq( argv[1], "-P" ) ) {
	    printf( "Illegal switch %s\n", argv[1] );
	    exst( 0 );		/* Exit with failure */
	}

	pflag++;		/* Set page flag */
	arg++;			/* Inc file arg index */
    }

    /* Set default extension to .C */

    f = strcpy( filename, argv[arg] );

    while (*f != '.' && *f != NULL ) f++;

    if (*f == NULL) strcpy( f, ".C" );


    /* Open file */

    file = fopen( filename, "r" );	 /* Open file for read */
    if ( file == NULL ) {
	printf( "Cannot open %s. Error code: %d.\n",
		filename,
		$$ferr );
	exst(0);		/* Exit with failure */
    }

    /* File is open, let's process it!!! */

    do {
	c = look4();		/* Scan text */
    } while ( c == EOP );	/* Continue through pages */

    if ( c != EOF ) {		/* Not end of file... what is wrong */
	unmatch( c );		/* Report no match */
    }

    exst( 1 );			/* Else exit with success */
}
