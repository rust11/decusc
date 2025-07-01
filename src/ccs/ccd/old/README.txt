1.0  LAST MINUTE NOTES 

There  are  a  few  files  on  the distribution with filetype .LEO which
contain updated (later) command files.  They have not been fully tested,
however.  

Of  special  interest  is  a build file for RTEM, the RT11 emulator that
runs on VMS.  

Some  last minute changes have been noted in CHANGE.TXT in this account.
Some of these changes have been made, others haven't.  

One  last-minute compiler bug has been fixed, but not adequately tested.
The changed code affects only sequences such as:  

        long    var;
        long    *laddr;
        long    func()

        var ^= func();
        *laddr++ ^= func();

Also,  the  following  has  been  added  after  preparation of hard-copy
documentation:  

     1.  The  setcc()  function  now  runs  on RSX-type systems.  It was
         restricted to RSTS/E RT11 only.  (This has only been tested  on
         Vax-compatibility and RSTS/E).  

     2.  Decus  C  runs on the PRO-350 with minor restrictions regarding
         named directories.  We hope to submit a PRO native  toolkit  in
         the  near  future.  Several routines have been added to the RSX
         interface library for the PRO.  

     3.  The  archive program in the tools directory is augmented by two
         simpler programs, archc and archx,  which  respectively  create
         and extract files from archives.  

         While  these  have  had  minimal  testing,  their  testing  has
         included Unix (4.2 BSD).  They were written  to  simplify  file
         transfer between "Dec-native" and Unix systems.  



2.0  GETTING ORIENTED 

To  build  Decus  C, first read NEW.DOC, KIT.DOC, all README.* files and
the command files needed to build Decus C on your operating system.  The
command files will probably require editing before use on some operating
systems, especially RSTS/E and RT11.  

You  should  also  read CC.DOC and WIZARD.DOC to learn about Decus C and
its run-time library.  





3.0  GETTING ON THE AIR WITH DECUS C 

If  you currently have a Decus C distribution, be sure you make a backup
of your current system, then initialize (zero) the accounts used for the
new  system  --  some  files that were on the previous distribution have
been deleted from this one.  

There  are  a  few  incompatibilities  which  will  require  editing and
recompiling your C programs;  the edited software will then  be  simpler
to  transport  to  other  C  compilers and operating systems.  These are
discussed in NEW.DOC, CC.DOC, and the run-time library documentation.  


4.0  INSTALLATION TIME ESTIMATES 

Assuming  all  goes  well,  installation  on  RSTS/E  will require about
one-half hour to create accounts and  read  the  distribution  tape  and
about   two   hours   to   build   all   programs  (using  command  file
[5,1]RBUILD.CMD).  This assumes an unloaded 11/70 system.  

Installation  on  VMS  will require about two and one-half hours to read
the distribution tape (because the tape is written in FLX format and FLX
will  scan  the  entire  tape  for each account).  Building all programs
using command file  [.COMMAND]VBUILD.COM  will  require  about  two  and
one-half hours on a reasonably-loaded VAX-11/780.  

Installation time on other systems should be comparable and, in general,
proportional to the disk access time.  

