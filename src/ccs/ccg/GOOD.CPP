typedef struct IOV {
int _cnt;
} FILE;
typedef struct node {
	char n_type;
	char n_flags;
	union {
		struct xsym {
			struct node *xsy_plist;
			struct node *xsy_value;
		} n_xsym;
		struct xsubr {
			struct node *(*xsu_subr)();
		} n_xsubr;
		struct xlist {
			struct node *xl_car;
			struct node *xl_cdr;
		} n_xlist;
		struct xint {
			int xi_int;
		} n_xint;
		struct xstr {
			int xst_type;
			char *xst_str;
		} n_xstr;
		struct xobj {
			struct node *xo_obclass;
			struct node *xo_obdata;
		} n_xobj;
		struct xfptr {
			FILE *xf_fp;
			int xf_savech;
		} n_xfptr;
	} n_info;
} NODE;

extern struct node *newnode();
NODE *bquote1(expr)
NODE *expr;
{
	NODE list,*new;

	    ((new)->n_info.n_xlist.xl_car
		= (((list.n_info.n_xlist.xl_car)->n_info.n_xlist.xl_car)));
}
