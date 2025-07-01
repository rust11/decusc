/*
 *      *******************
 *      *  R M S 1 1 . H  *
 *      *******************
 * 
 * This file contains the definitions of the RMS-11 (V2.0) data
 * structures.  Requires the usual CX definitions (word, address, etc.).
 *
 * Bob Denny 11-Dec-83
 *
 * Edits:
 *
 */

/*
 *      ***************
 *      *  ALL BLOCK  *
 *      ***************
 */
struct  all_blk
   {
   byte         o$cod;
   byte         o$bln;
   address      o$nxt;
   byte         o$aid;
   byte         o$bkz;
   word         o$vol;
   byte         o$aln;
   byte         o$aop;
   word         o$alq0;                 /* Lo & hi words reversed */
   word         o$alq1;
   byte         o$deq;
   byte         o$xx1;
   word         o$loc0;
   word         o$loc1;
   };
#define XB$CYL  1
#define XB$LBN  2
#define XB$VBN  4
#define XB$HRD  1
#define XB$CTG  2
   
/*
 *      ***************
 *      *  DAT BLOCK  *
 *      ***************
 */
struct  dat_blk
   {
   byte         o$cod;
   byte         o$bln;
   address      o$nxt;
   word         o$rvn;          /* P/OS documentation unclear on this field */
   char         o$rdt[8];
   char         o$cdt[8];
   char         o$bdt[8];       /* A.K.A. o$edt (expiration/backup date) */
   };
#define XB$DAT  3
#define XB$DTL  046

/*
 *      *****************************
 *      *  FAB - FILE ACCESS BLOCK  *
 *      *****************************
 */
struct rms_fab
   {
   byte         o$bid;
   byte         o$bln;
   word         o$ctx;
   word         o$ifi;
   word         o$sts;
   word         o$stv;
   long         o$alq;
   word         o$deq;
   byte         o$fac;
   byte         o$shr;
   word         o$fop;
   byte         o$rtv;
   byte         o$org;
   byte         o$rat;
   byte         o$rfm;
   address      o$xab;
   address      o$bpa;
   word         o$bps;
   word         o$mrs;
   long         o$mrn;
   word         o$lrl;
   struct nam_blk *o$nam;
   char         *o$fna;
   char         *o$dna;
   byte         o$fns;
   byte         o$dns;
   word         o$bls;
   byte         o$fsz;
   byte         o$bks;
   byte         o$dev;
   byte         o$lch;
   };
#define FB$BID  3
#define FB$BLN  0120
#define FB$PUT  1
#define FB$GET  2
#define FB$DEL  4
#define FB$UPD  010
#define FB$TRN  020
#define FB$WRT  041
#define FB$REA  042
#define FB$WRI  015
#define FB$UPI  040
#define FB$NIL  0100
#define FB$DLK  020
#define FB$CTG  0200
#define FB$SUP  0400
#define FB$TMP  02000
#define FB$MKD  04000
#define FB$TMD  06000
#define FB$FID  010000
#define FB$DFW  020000
#define FB$SEQ  0
#define FB$REL  010
#define FB$IDX  040
#define FB$FTN  1
#define FB$CR   2
#define FB$PRN  4
#define FB$BLK  010
#define FB$UDF  0
#define FB$FIX  1
#define FB$VAR  2
#define FB$VFC  3
#define FB$STM  4
#define FB$REC  1
#define FB$CCL  2
#define FB$TRM  4
#define FB$MDI  010
#define FB$SDI  020
#define FB$SQD  040

/*
 *      ***************
 *      *  KEY BLOCK  *
 *      ***************
 * (later)
 */


/*
 *      ***************
 *      *  NAM BLOCK  *
 *      ***************
 */
struct  nam_blk
   {
   word         o$rlf;
   char         *o$rsa;
   byte         o$rss;
   byte         o$rsl;
   char         o$dvi[4];
   word         o$wdi;
   word         o$fid[3];
   word         o$did[3];
   word         o$fnb;
   char         *o$esa;
   byte         o$ess;
   byte         o$esl;
   word         o$wcc;
   };
#define NB$VER  1
#define NB$TYP  2
#define NB$NAM  4
#define NB$WVE  010
#define NB$WTY  020
#define NB$WNA  040
#define NB$DIR  0100
#define NB$DEV  0200
#define NB$NOD  0400
#define NB$WDI  01000
#define NB$QUO  02000
#define NB$WCH  04000

/*
 *      ***************
 *      *  PRO BLOCK  *
 *      ***************
 */
struct pro_blk
   {
   byte         o$cod;
   byte         o$bln;
   address      o$nxt;
   word         o$prg;
   word         o$prj;
   word         o$pro;
   };
   
/*
 *      *******************************
 *      *  RAB - RECORD ACCESS BLOCK  *
 *      *******************************
 */
struct rms_rab
   {
   byte         o$bid;
   byte         o$bln;
   word         o$ctx;
   word         o$isi;
   word         o$sts;
   word         o$stv;
   word         o$rfa[3];
   byte         o$rac;
   byte         o$ksz;
   word         o$rop;
   word         o$usz;
   address      o$ubf;
   word         o$rsz;
   address      o$rbf;
   byte         o$krf;
   byte         o$mbf;
   byte         o$mbc;
   byte         o$rt1a;
   word         o$rhb;
   struct fab  *o$fab;
   long         o$bkt;
   };
#define RB$SEQ  0
#define RB$KEY  1
#define RB$RFA  2
#define RB$EOF  1
#define RB$MAS  2
#define RB$LOA  020
#define RB$LOC  0100
#define RB$KGE  02000
#define RB$KGT  04000
#define RB$FDL  010000
#define RB$UIF  020000

/*
 *      ***************
 *      *  SUM BLOCK  *
 *      ***************
 *
 * (later)
 */
