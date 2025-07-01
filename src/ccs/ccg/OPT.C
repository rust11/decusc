/* OPT.C	Decus C compiler branch optimizer.  Use on *.S file
		after compiling but before assembling.
		Eliminates unnecessary branches.

		Clifford C. Geschke	02-Aug-82

		Usage:	OPT <input >output

RSX TASK BUILDER COMMANDS:

OPT=OPT
LB:[1,1]CU/LB,CX/LB,C/LB
/
ACTFIL=4
UNITS=4
LIBR=FCSRES:RO
//

*/

#include <stdio2.h>

/* Assembly switches */

#define VSPLEN 50	/* Number of successive labels possible */
#define PNDMAX 50	/* Number of pending defines possible */
#define LABMAX 500	/* Maximum number of labels possible */

/* Codes returned by getline() */

#define ORD 0		/* Ordinary statement */
#define LAB 1		/* Label */
#define BR 2		/* Unconditional branch */

char *lpt;		/* Pointer into line buffer */
char linbuf[82];	/* Line buffer */
int value;		/* Value save */
int *vsp;		/* Value stack pointer */
int vsptop[VSPLEN];	/* Value stack */
int brpend;		/* Pending branch save */
int pndr[PNDMAX];	/* Pending equate, right side */
int pndl[PNDMAX];	/* Pending equate, left side */
int deflst[LABMAX];	/* Defined label list */
int *defpt;		/* Pointer into defined label list */
int *pndmax;		/* Pointer past maximum pending equate */

$$narg = 1;

getch()		/* Get a single character, buffer it */

{
    FAST int c;

    if ( ( ( c = getchar() ) < 0 ) 	/* If end of file */
    ||   ( c == '\n' ) ) {		/* or end of line */
	*lpt = NULL;			/* Mark end of line */
    }
    else {
	*lpt++ = c;			/* Else store character */
    }
    return( c );			/* Return character */
}

skipws()		/* Skip white space */
{
    FAST int c;

    do ; while ( ( ( c = getch() ) == ' ' )
	 ||	 ( c == '\t' ) );

    return( c );
}

getlin()		/* Get a line from stdin */

/*

	Returns  EOF if end of file
		 ORD if ordinary statement
		 LAB if label
		 BR  if branch 

		 If LAB or BR return, "value" contains the label value
		 (in binary).

	Upon return, lunbuf contains the new line, lpt points to the end
	of the line+1.  The line is terminated by a null.

	Ignores blank lines.
*/

{
    FAST int c;		/* Current character */
    FAST int v;		/* Value save */

    do {
	lpt = linbuf;				/* Reset line pointer */
    } while ( ( c = skipws() ) == '\n' );	/* Ignore blank lines */

    switch( c ) {

    case EOF: return( c );		/* Return if EOF */

    case '.': {				/* Possible label */
	v = 0;				/* Scan for label */
	while ( ( ( c = getch() - '0' ) >= 0 )
	&&      ( c < 8 ) ) {
		v = v * 8 + c;
	}
	if ( ( c == ':' - '0' )		/* If : followed by \n */
	&&   ( getch() == '\n' ) ) {	/* Its a label */
	    value = v;			/* Save value */
	    return( LAB );		/* Its a label */
	}
	break;
    }

    case 'b': {				/* Possible BR */
	if ( getch() != 'r' ) break;	/* not br */
	if ( skipws() != '.' ) break;	/* Not br to .ddddd */
	v = 0;				/* Scan for label */

	while ( ( ( c = getch() - '0' ) >= 0 )
	&&      ( c < 8 ) ) {
		v = v * 8 + c;
	}

	if ( c == '\n' - '0' ) {	/* If end of line, branch */
	    value = v;			/* Save value */
	    return( BR );		/* Its a branch */
	}
	break;
    }

    } /* End of switch */

    /* Ordinary label */

    do ; while ( ( ( c = skipws() ) > 0 )	/* Copy to EOL */
	 &&	 ( c != '\n' ) );

    return( ORD );			/* Ordinary line */
}

vpush()			/* Push value on stack */
{
    if ( vsp == vsptop ) {
	fprint( stderr, "Value stack overflow.\n" );
	exitt();
    }
    *--vsp = value;	/* Push value */
}

    
vpop()			/* Pop value from stack */
{
    if ( vsp == &vsptop[VSPLEN] ) return( NULL );	/* Empty stack */
    return( *vsp++ );		/* Return top of stack */
}

isdef( v )		/* TRUE if the value is defined */
FAST int v;		/* The value to be checked */
{
    FAST int *d;	/* Pointer to the definition list */

    d = defpt;		/* Get current pointer */

    while ( d > deflst ) {	/* If non-empty list */
	if ( *--d == v ) return( TRUE );
    }

    return( FALSE );
}

outpnd( v )	/* Output any label depending on v, and define v */
FAST int v;	/* Value on right of equate */
{
    FAST int *p;	/* Index into pending label array */
    FAST int l;		/* Value on left of equate */

    if ( defpt == &deflst[LABMAX] ) {
	fprintf( stderr, "Too many labels. Exiting.\n" );
	exitt();
    }

    *defpt++ = v;	/* Define the label */

    p = pndr;		/* Point to pending label array, right */

    while ( p < pndmax ) {	/* Search the list */
	if ( *p++ == v ) {	/* If a match */	
	    if ( p == pndmax ) pndmax--;	/* Reset max */
	    l = pndl[p-pndr-1];	/* Get left */
	    printf( ".%o = .%o\n", l, v );	/* output equate */
	    *(p-1) = NULL;	/* Reset pending */
	    outpnd(l);		/* Recursion */
	}
    }
}

putpnd( l, r )	/* Define a pending equate */
int r;	/* Value on right of equate */
int l;	/* Value on left of equate */
{
    FAST int *p;	/* Index into pending label array */
    FAST int num;	/* Scratch */

    p = pndr;		/* Point to pending label array, right */

    while ( p < pndmax ) {
	if ( *p++ == NULL ) {
	    p--;
	    goto insert;
	}
    }

    pndmax++;		/* Set new max */

    if ( p == &pndr[PNDMAX] ) {
	fprintf( stderr, "Too many pending definitions. Exiting.\n" );
	exitt();
    }

insert:
    num = p-pndr;	/* Get index */

    pndr[num] = r;	/* Set right */
    pndl[num] = l;	/* Set left */
}

main()

{
    FAST int code;		/* Code from getline() */
    FAST int v;			/* Value from value stack */

    lpt = linbuf;		/* Init line buffer */
    vsp = &vsptop[VSPLEN];	/* Init stack pointer */
    brpend = NULL;		/* Init branch pending save */
    defpt = deflst;		/* Init defined label pointer */
    pndmax = pndr;		/* Init pending label array */

    FOREVER {

	while ( ( code = getline() ) == LAB ) {	/* If label */
	    if ( brpend == value ) brpend = NULL; /* Delete spurious branch */
	    vpush();				/* Save label */
	}

	if ( code == BR ) {		/* Label followed by branch */
	    if ( isdef(value) )	{	/* If branch label defined */
		while( ( v = vpop() ) != NULL ) {	/* Output equate */
		    printf( ".%o = .%o\n", v, value );
		    outpnd( v );	/* Output dependent label */
		}
	    }
	    else {
		while( ( v = vpop() ) != NULL ) {	/* Pending equate */
		    putpnd( v, value );
		}
	    }
	    if ( brpend == NULL ) {	/* If no branch pending */
		brpend = value;		/* There is one now */
	    }
	    continue;
	}

 	/* Ordinary statement */

	if ( brpend != NULL ) {		/* If branch pending */
	    printf( "\tbr\t.%o\n", brpend );	/* Output it */
	    brpend = NULL;		/* Not pending now */
	}

	while( ( v = vpop() ) != NULL ) {
	    printf( ".%o:\n", v );	/* Define label */
	    outpnd( v );		/* Output any dependent label */
	}
	puts( linbuf );			/* Output current line */
	brpend = FALSE;			/* Set no branch seen */

	if ( code == EOF ) break;	/* Exit if EOF */

    } /* End of forever */

    if ( pndmax != pndr ) {
	fprint( stderr, "Optimization error: pending equates at EOF.\n" );
    }
}
