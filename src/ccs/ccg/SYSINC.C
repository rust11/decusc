/*
 * This hack is used to prepare the SYSINC global patch
 * for RSX-based operating systems.  You enter the new
 * sysinc value (as a text string), it prints the patch
 * values.
 */
#include	<stdio.h>

int	$$narg = 1;

char	line[133];

main() {
	register char	*tp;

	while (!feof(stdin)) {
	    printf("Enter sysinc line: ");
	    fflush(stdout);
	    if (gets(line) == NULL)
		break;
	    for (tp = line;; tp += 2) {
		if (*tp == EOS) {
		    printf(" %0");
		    break;
		}
		printf(" %06o", *tp + (tp[1] << 8));
		if (tp[1] == EOS)
		    break;
	    }
	    printf("\n");
	}
}
