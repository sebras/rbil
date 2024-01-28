/***********************************************************************/
/* INTPRINT.C by Ralf Brown.  Donated to the Public Domain.	       */
/* Please do not remove my name from any copies or derivatives.        */
/***********************************************************************/
/* Program History:						       */
/*   v1.00  4/23/89  initial public release			       */
/*		     with 4/30/89 list				       */
/*   v1.10  5/21/89  added -I and -f				       */
/*   v1.11  1/6/90   fixed #endif's for compilers which don't handle   */
/*		     labels					       */
/*   v1.20  6/8/90   added -r					       */
/*   v1.30  7/14/90  added -b, tables now stay aligned on odd indents  */
/*   v1.40  10/6/90  added -B based on changes by Naoto Kimura, -w     */
/*   v1.40a 5/6/91   HP LaserJet II support by Russ Herman	       */
/*   v1.41  7/9/91   HP PCL support by P.J.Farley III		       */
/*   v2.00  9/1/91   modular printer definitions		       */
/*		     printing multipart interrupt list		       */
/***********************************************************************/
/* Recompiling: 						       */
/*   Turbo C / Borland C++					       */
/*	tcc -mt -lt -Z -p intprint				       */
/***********************************************************************/

#include <stdio.h>
#include <string.h>

#define VERSION "2.00"

#define MAXLINE 81   /* at most 80 chars per line (plus newline) */
#define MAXPAGE 200  /* at most 200 lines per page */

#ifndef FALSE
#define FALSE 0
#endif
#ifndef TRUE
#define TRUE !FALSE
#endif

#ifdef __TURBOC__
#  define PROTOTYPES
#  include <stdlib.h>
int _Cdecl isatty(int handle) ;
void _setenvp(void) {} /* don't need the environment, so don't include it */
int isspace(char c) { return (c == ' ' || c == '\t') ; }
#else
/*#define PROTOTYPES  /* uncomment if compiler supports ANSI-style prototypes */
#define NEED_STRNICMP /* comment out if library contains strnicmp() */
#define _Cdecl
#  include <ctype.h>

char *itoa(num,buf,radix)   /* not everybody has the same itoa() as TurboC */
int num ;		    /* minimal implementation */
char *buf ;
int radix ;
{
   int count = 0 ;
   int i ; 
   char tmp ;

   do {
      buf[count++] = '0' + num % radix ;
      num = num / radix ;
   } while (num) ;
   buf[count] = '\0' ;
   if (count > 1)
      for (i = 0 ; i < count / 2 ; i++)
	 {
	 tmp = buf[i] ;
	 buf[i] = buf[count-i-1] ;
	 buf[count-i-1] = tmp ;
	 }
   return buf ;
}
#endif /* __TURBOC__ */

/***********************************************/

typedef struct _cstr		 /* a counted string */
   {
   int len ;			 /* the string's length */
   char *str ;			 /* the actual contents of the string */
   } cstr ;

#define CSTR(s) { sizeof(s)-1, (s) }  /* for defining a counted string literal */
#define cstrlen(s) ((s)->len)	 /* how long is the counted string? */
#define cstrchar(s,i) ((s)->str[i])  /* retrieve a character from a counted string */

typedef struct _printer_def
   {
   char *name ; 		/* for selecting the appropriate printer */
   cstr init1, init2 ;		/* initialization strings */
   cstr marginl, marginc, marginr ; /* margins: duplex even, non-duplex, duplex odd */
   cstr duplex_on ;		/* turn on duplex mode */
   cstr term1, term2 ;		/* cleanup strings */
   cstr bold_on, bold_off ;	/* boldface on/off */
   int indent ; 		/* how many extra spaces to indent */
   int lines_per_page ; 	/* how many lines to print on each page */
   int page_length ;		/* how many lines on each page */
   int page_width ;		/* how many printable columns per line? */
#ifdef PROTOTYPES
   void (*put_line)(FILE *,int) ;/* function to call to print out divider line */
#else
   void (*put_line)() ; 	/* function to call to print out divider line */
#endif /* PROTOTYPES */
   int *flag ;			/* flag to set when using this printer definition */
   } PRINTER_DEF ;

/***********************************************/

#ifdef PROTOTYPES
void usage(void) ;
void fatal(char *msg) ;
void get_line(char *buf,int size) ;
void indent_line(FILE *fp) ;
void put_line(FILE *fp, int len) ;
void HPPCL_put_line(FILE *fp, int len) ;
void fputcstr(cstr *s, FILE *fp) ;
int divider_line(char *line) ;
void output_line(char *line,FILE *fp) ;
void fill_buffer(int lines, int lines_per_page) ;
int find_page_break(int lines) ;
void summarize(FILE *summary, int line, int pages_printed) ;
void start_format(char *line) ;
void print_line(char *line) ;
void print_buffer(int first, int last, int lines_per_page, int total_lines, int use_FF) ;
void select_printer(char *name) ;
void display_printers(void) ;
int _Cdecl main(int argc, char **argv) ;
#else
void put_line() ;
void HPPCL_put_line() ;
#endif /* PROTOTYPES */

/***********************************************/

FILE *infile, *outfile ;
char *input_file ;

char buffer[MAXPAGE][MAXLINE] ;
char num[6] ;
char summary_line[MAXLINE] ;

int pages_printed = 0 ;
int page_width = 0 ;		/* page width in characters, 0 = use prtdef */
int indent = 0 ;		/* number of blanks to add at start of each line */
int widow_length = 10 ; 	/* number of lines to scan for good place to break */
int page_numbers = FALSE ;	/* add page numbers to bottom of page? */
int multi_file = FALSE ;	/* printing multipart interrupt list? */
int out_of_files = FALSE ;	/* hit end of last file for multipart printing? */
int do_summary = FALSE ;	/* create a one-line-per-call summary? */
int do_formats = FALSE ;	/* create a separate file with data structures? */
int IBM_chars = FALSE ; 	/* printer can handle IBM graphics characters */
int boldface = FALSE ;		/* boldface titles and Return:/Notes: ? */
int printer_bold = FALSE ;	/* boldface using printer control sequences? */
int echo_format = FALSE ;
int duplex = FALSE ;
int HPPCL_mode = FALSE ;
FILE *summary ;
FILE *formats ;
PRINTER_DEF *printer = NULL ;

int first_page = 0 ;
int last_page = 9999 ;

/***********************************************/

PRINTER_DEF printers[] =
   {
     { "default",
       CSTR(""), CSTR(""),
       CSTR(""), CSTR(""), CSTR(""),
       CSTR(""),
       CSTR(""), CSTR(""),
       CSTR(""), CSTR(""),
       -1,
       60,
       0,
       79,
       put_line,
       NULL,
     },
     { "Epson FX80",
       CSTR("\033M"), CSTR(""),
       CSTR("\033l\004"), CSTR("\033l\007"), CSTR("\033l\014"),
       CSTR(""),
       CSTR("\033P"), CSTR("\033l\000"),
       CSTR("\033E"), CSTR("\033F"),
       0,
       60,
       0,
       87,	/* 96 - left margin - 1 right margin */
       put_line,
       NULL,
     },
     { "HP PCL",
       CSTR("\033(8U"), CSTR(""),
       CSTR("\033&a4c4L"), CSTR("\033&a8c8L"), CSTR("\033&a12c12L"),
       CSTR("\033&l1S"),
       CSTR("\033E"), CSTR(""),
       CSTR("\033(s3B"), CSTR("\033(s0B"),
       0,
       69,
       0,
       87,	/* 96 - left margin - 1 right margin */
       HPPCL_put_line,
       &HPPCL_mode,
     },
#define HPPCL_FONT_ON_A "\033(s0p12h10v0s0b"
/* HP PCL4/5 Font select: Roman-8;Upright12Pitch10PointMediumWeight */
#define HPPCL_FONT_ON_B "T\033&l6.8571C"
/* HP PCL4/5 Font select: End typeface select;VMI=7LPI: (48/7)-48th's inches*/
#define HPPCL_IBM_LN_A	"\033&f0S\033*p-15Y\033*c"
/* HP PCL4/5 IBM Line:	Push Pos;Up 15/720";Hor.Rule ???/300ths" long */
#define HPPCL_IBM_LN_B	"a3b0P\033&f1S"
/* HP PCL4/5 IBM Line:	 3/300ths" high,Print rule;Pop Position */
     { "LaserJet II",
       CSTR("\033(10U"),CSTR(""),
       CSTR("\033&a4c4L"), CSTR("\033&a8c8L"), CSTR("\033&a12c12L"),
       CSTR(""),
       CSTR("\033E"),CSTR(""),
       CSTR("\033(S3B"),CSTR("\033(S0B"),
       0,
       54,
       60,
       79,
       put_line,
       &IBM_chars,
     },
   } ;
#define NUM_PRINTERS (sizeof(printers)/sizeof(printers[0]))

/***********************************************/

#ifdef NEED_STRNICMP
#ifdef PROTOTYPES
int strnicmp(char *s1,char *s2,int len)
#else
int strnicmp(s1,s2,len)
char *s1,*s2 ;
unsigned int len ;
#endif PROTOTYPES
{
   char c1, c2 ;

   while (*s1 && *s2 && len > 0)
      {
      len-- ;
      c1 = (islower(*s1) ? toupper(*s1) : *s1) ;
      c2 = (islower(*s2) ? toupper(*s2) : *s2) ;
      if (c1 != c2 && len == 0)  /* mismatch or substrings exhausted? */
	 return (c1 - c2) ;
      }
   return 0 ;  /* strings match exactly on first 'len' characters */
}
#endif /* NEED_STRNICMP */

/***********************************************/

void usage()
{
   fputs("INTPRINT v", stderr) ;
   fputs(VERSION, stderr) ;
   fputs(" by Ralf Brown.  Donated to the Public Domain.\n\n",stderr) ;
   fputs("Usage: intprint [options] intlist [>|>>]output\n",stderr) ;
   fputs("Options:\n",stderr) ;
   fputs("\t-Pname\tassume printer 'name' (-P? lists supported printers)\n",stderr) ;
   fputs("\t-lN\tprint N lines per page (default depends on printer)\n",stderr) ;
   fputs("\t-LN\tassume N lines on a page, use linefeeds if > #lines printed\n",stderr) ;
   fputs("\t-m\tlist is in multiple parts starting with the named file\n",stderr) ;
   fputs("\t-d\t(duplex) print even/odd pages with different indents\n",stderr) ;
   fputs("\t-p\tadd page numbers\n",stderr) ;
/*   fputs("\t-h\tadd page headers\n",stderr) ; */
   fputs("\t-nN\tassume N pages have been printed from previous parts\n",stderr) ;
   fputs("\t-rN:M\tprint only pages N through M\n",stderr) ;
   fputs("\t-wN\tscan N lines from bottom of page for good place to break\n",stderr) ;
   fputs("\t-e\tassume 'elite' mode (96 chars per line) for default printer\n",stderr) ;
   fputs("\t-iN\tindent output N spaces (overridden by some printers)\n",stderr) ;
   fputs("\t-b\tboldface title lines and Return:/Note:\n",stderr) ;
   fputs("\t-B\tboldface using printer control codes instead of overprinting\n",stderr) ;
   fputs("\t-tN\tselect typeface N for the chosen printer\n",stderr) ;
   fputs("\t-I\tprinter supports IBM graphics characters\n",stderr) ;
   fputs("\t-sfile\twrite a one-line-per-function summary to 'file'\n",stderr) ;
   fputs("\t-ffile\twrite all data structures to 'file'\n",stderr) ;
   exit(1) ;
}

/***********************************************/

void fatal(msg)
char *msg ;
{
   fputs(msg,stderr) ;
   fputs("\n",stderr) ;
   exit(1) ;
}

/***********************************************/

void indent_line(fp)
FILE *fp ;
{
   int ind = indent ;

   while (ind >= 8)
      {
      fputc('\t',fp) ;
      ind -= 8 ;
      }
   while (ind-- > 0)
      fputc(' ', fp) ;
}

/***********************************************/

void put_line(fp,len)
FILE *fp ;
int len ;
{
   int i ;

   if (IBM_chars)
      for (i = 0 ; i < len ; i++)
	 fputc(196,fp) ;  /* single horizontal line */
   else
      for (i = 0 ; i < len ; i++)
	 fputc('-',fp) ;
}

/***********************************************/

void HPPCL_put_line(fp,len)
FILE *fp ;
int len ;
{
   fputs(HPPCL_IBM_LN_A,fp) ;
   itoa((len * 25), num, 10) ;
   fputs(num,fp) ;
   fputs(HPPCL_IBM_LN_B,fp) ;
}

/***********************************************/

void fputcstr(s,fp)		/* output the counted string to the given file */
FILE *fp ;
cstr *s ;
{
   int i ;

   for (i = 0 ; i < cstrlen(s) ; i++)
      fputc(cstrchar(s,i),fp) ;
}

/***********************************************/

int divider_line(line)
char *line ;
{
   return strncmp(line,"--------",8) == 0 ;
}

/***********************************************/

void output_line(line,fp)
char *line ;
FILE *fp ;
{
   int pos = 0 ;
   char bold[10] ;

   if (boldface)
      {
      if (strncmp(line,"INT ",4) == 0 || strncmp(line,"Format of ",10) == 0 ||
	  strncmp(line,"Values ",7) == 0)
	 {
	 indent_line(fp) ;
	 if (printer_bold)
	    {
	    fputcstr(&printer->bold_on,fp) ;
	    fputs(line,fp) ;
	    fputcstr(&printer->bold_off,fp) ;
	    line = NULL ;
	    }
	 else
	    {
	    fputs(line,fp) ;
	    fputc('\r',fp) ;
	    }
	 }
      else if (strncmp(line,"Return:",7) == 0 || strncmp(line,"Note:",5) == 0 ||
	       strncmp(line,"Notes:",6) == 0 || strncmp(line,"BUG:",4) == 0 ||
	       strncmp(line,"SeeAlso:",8) == 0)
	 {
	 strncpy(bold,line,sizeof bold) ;
	 *strchr(bold,':') = '\0' ;
	 indent_line(fp) ;
	 if (printer_bold)
	    {
	    fputcstr(&printer->bold_on,fp) ;
	    fputs(bold,fp) ;
	    fputcstr(&printer->bold_off,fp) ;
	    pos = strlen(bold) ;     /* we're no longer at the left edge of the */
	    line += pos ;	     /* line, so figure out where we are */
	    }
	 else
	    {
	    fputs(bold,fp) ;
	    fputc('\r',fp) ;
	    }
	 }
      }
   if (line && *line)
      {
      if (pos == 0)	    /* are we currently at the left edge of the line? */
	 indent_line(fp) ;  /* if yes, indent the desired amount */
      if (indent % 8)
	 {
	 while (*line)
	    {
	    if (*line == '\t')
	       do {
		  fputc(' ',fp) ;
		  } while (++pos % 8) ;
	    else
	       {
	       fputc(*line,fp) ;
	       pos++ ;
	       }
	    line++ ;
	    }
	 }
      else
	 fputs(line,fp) ;
      }
   fputc('\n',fp) ;
}

/***********************************************/

void get_line(buf,size)
char *buf ;
int size ;
{
   int last ;

   buf[0] = '\0' ;
   if (out_of_files)
      return ;
   fgets(buf,size,infile) ;
   if ((feof(infile) || buf[0] == '\0'))
      if (multi_file)
	 {
	 FILE *tempfile ;

	 last = strlen(input_file) - 1 ;
	 input_file[last]++ ;
	 if ((tempfile = fopen(input_file,"r")) != NULL)
	    {
	    fclose(infile) ;
	    infile = tempfile ;
	    fgets(buf,size,infile) ;
	    }
	 else
	    {
	    out_of_files = TRUE ;
	    return ;
	    }
	 }
      else
	 out_of_files = TRUE ;
   last = strlen(buf) - 1 ;
   if (last < 0)
      last = 0 ;
   if (buf[last] == '\n')
      buf[last] = '\0' ;  /* strip the newline */
}

/***********************************************/

void fill_buffer(lines,lines_per_page)
int lines, lines_per_page ;
{
   int i ;

   if (lines)
      for (i = lines ; i < lines_per_page ; i++)
	 strcpy(buffer[i-lines], buffer[i]) ;
   else
      lines = lines_per_page ;
   for (i = lines_per_page - lines ; i < lines_per_page ; i++)
      get_line(buffer[i], sizeof(buffer[i])) ;
}

/***********************************************/

int find_page_break(lines)
int lines ;
{
   int i ;

   for (i = 0 ; i < widow_length ; i++)
      {
      if (strcmp(buffer[lines-i-1],"\n") == 0 ||
	  strlen(buffer[lines-i-1]) == 0 ||
	  divider_line(buffer[lines-i-1]))
	 return lines - i ;
      }
   return lines ;
}

/***********************************************/

void summarize(summary, line, pages_printed)
FILE *summary ;
int line, pages_printed ;
{
   char *s ;
   int i ;
   int max_descrip ;
   int len ;

   s = buffer[line] ;
   if (strncmp(s, "INT ", 4) == 0)   /* start of an entry? */
      {
      summary_line[3] = summary_line[0] = ' ' ;
      summary_line[1] = s[4] ;	 /* output interrupt number */
      summary_line[2] = s[5] ;
      summary_line[4] = '\0' ;
      len = 4 ;
      s = buffer[line+1] ;
      while (*s && isspace(*s))
	 s++ ;
      if (strncmp(s,"AX",2) == 0)
	 i = 4 ;
      else if (strncmp(s,"AH",2) == 0)
	 i = 2 ;
      else
	 i = 0 ;
      if (i)
	 {
	 while (*s && *s != '=')
	    s++ ;
	 s++ ;	/* skip the equal sign */
	 while (*s && isspace(*s))
	    s++ ;
	 if (strchr("0123456789ABCDEFabcdef",*s) != NULL)
	    {
	    summary_line[len++] = *s++ ;
	    summary_line[len++] = *s++ ;
	    summary_line[len++] = ' ' ;
	    if (i == 4)
	       {
	       summary_line[len++] = *s++ ;
	       summary_line[len++] = *s ;
	       }
	    else
	       {
	       summary_line[len++] = '-' ;
	       summary_line[len++] = '-' ;
	       }
	    summary_line[len++] = ' ' ;
	    }
	 else
	    {
	    /* wasn't legal digit, so no numbers */
	    strcpy(summary_line+len,"-- -- ") ;
	    len += 6 ;
	    }
	 }
      else
	 {
	 strcpy(summary_line+len,"-- -- ") ;
	 len += 6 ;
	 }
      if (page_numbers)
	 {
	 itoa(pages_printed,num,10) ;
	 for (i = strlen(num) ; i < 3 ; i++)
	    summary_line[len++] = ' ' ;
	 strcpy(summary_line+len,num) ;
	 len += strlen(num) ;
	 summary_line[len++] = ' ' ;
	 }
      s = buffer[line] + 7 ;  /* find function description */
      while (*s && !isspace(*s))
	 s++ ;
      while (*s && isspace(*s))
	 s++ ;
      max_descrip = (page_numbers ? MAXLINE-16 : MAXLINE-12) ;
      for (i = 0 ; i < max_descrip && *s ; i++)
	 summary_line[len++] = *s++ ;
      summary_line[len] = '\0' ;
      if (do_summary)
	 output_line(summary_line,summary) ;
      }
}

/***********************************************/

void start_format(line)
char *line ;
{
   indent_line(formats) ;
   (*printer->put_line)(formats,79) ;
   fputc('\n',formats) ;
   indent_line(formats) ;
   fputs(summary_line,formats) ;
   fputc('\n',formats) ;
   indent_line(formats) ;
   fputc('\t',formats) ;
   fputs(line+10,formats) ;
   fputc('\n',formats) ;
   echo_format = TRUE ;
}

/***********************************************/

void print_line(line)
char *line ;
{
   if (*line)
      {
      if (divider_line(line))
	 {
	 indent_line(outfile) ;
	 (*printer->put_line)(outfile,79) ;
	 fputc('\n', outfile) ;
	 echo_format = FALSE ;
	 }
      else
	 {
	 output_line(line, outfile) ;
	 if (echo_format)
	    output_line(line,formats) ;
	 }
      }
   else
      {
      fputc('\n', outfile) ;
      echo_format = FALSE ;
      }
}

/***********************************************/

void print_buffer(first,last,lines_per_page,total_lines,use_FF)
int first, last, lines_per_page, total_lines ;
int use_FF ;
{
   int i, ind ;

   pages_printed++ ;
   for (i = first ; i < last ; i++)
      {
      if (pages_printed >= first_page && pages_printed <= last_page)
	 print_line(buffer[i]) ;
      if (do_summary || do_formats)  /* need summary lines if doing formats */
	 summarize(summary,i,pages_printed) ;
      if (do_formats && strncmp(buffer[i],"Format of ",10) == 0)
	 start_format(buffer[i]) ;
      }
   if (pages_printed >= first_page && pages_printed <= last_page)
      {
      if (page_numbers)
	 {
	 for (i = last - first ; i < lines_per_page - 1 ; i++)
	    fputc('\n', outfile) ;
	 indent_line(outfile) ;
	 for (ind = 0 ; ind < 38 ; ind++) /* normal indent + 38 spaces */
	    fputc(' ', outfile) ;
	 fputs("- ", outfile) ;
	 itoa(pages_printed, num, 10) ;
	 fputs(num, outfile) ;
	 fputs(" -\n", outfile) ;
	 }
      if (use_FF)
	 fputc('\f', outfile) ;
      else
	 for (i = page_numbers?lines_per_page:(last-first) ; i<total_lines ; i++)
	    fputc('\n', outfile) ;
      if (duplex)
	 {
	 if ((pages_printed % 2) == 1)	/* next page even or odd? */
	    fputcstr(&printer->marginl, outfile) ;	/* even page */
	 else
	    fputcstr(&printer->marginr, outfile) ;	/* odd page */
	 }
      }
}

/***********************************************/

void display_printers()
{
   int i ;
   
   fputs("Valid printer names are:\n",stderr) ;
   for (i = 0 ; i < NUM_PRINTERS ; i++)
      {
      fputc('\t',stderr) ;
      fputs(printers[i].name,stderr) ;
      fputc('\n',stderr) ;
      }
   fputs("When entering the printer name, use either a dash or an underscore\n",stderr) ;
   fputs("in place of blanks.  Case is ignored, and the name may be abbreviated\n",stderr) ;
   fputs("to the shortest unique prefix.\n",stderr) ;
   exit(1) ;
}

/***********************************************/

void select_printer(name)
char *name ;
{
   int i, len, prt = -1 ;
   
   len = strlen(name) ;
   for (i = 0 ; i < len ; i++)		/* convert dashes and underscores to blanks */
      if (name[i] == '-' || name[i] == '_')
	 name[i] = ' ' ;
   for (i = 0 ; i < NUM_PRINTERS ; i++)
      if (strnicmp(name,printers[i].name,strlen(name)) == 0)
	 if (prt == -1)
	    prt = i ;
	 else
	    fatal("Ambiguous printer name!  Use -P? to list printers.") ;
   if (prt == -1)
      fatal("Unknown printer name!  Use -P? to list printers.") ;
   else
      printer = &printers[prt] ;
}

/***********************************************/

int _Cdecl main(argc,argv)
int argc ;
char *argv[] ;
{
   int lines_per_page = -1 ;
   int total_lines = -1 ;
   int use_FF = TRUE ;
   int last_line ;
   int body_lines ;
   char *typeface = NULL ;
   char *summary_file = NULL ;
   char *formats_file = NULL ;
   char *last_page_num ;
   
   if (argc == 1 && isatty(0))
      usage() ;   /* give help if invoked with no args and keybd input */
   while (argc >= 2 && argv[1][0] == '-')
      {
      switch (argv[1][1])
	 {
	 case 'e':
	    indent = 8 ;
	    page_width = 87 ;  /* 96 - indent - 1 right margin */
	    break ;
	 case 'P':
	    if (argv[1][2] == '?')
	       display_printers() ;
	    else
	       select_printer(argv[1]+2) ;
	    break ;
	 case 'I':
	    IBM_chars = TRUE ;
	    break ;
	 case 'p':
	    page_numbers = TRUE ;
	    break ;
	 case 'h':   /* page headers */
	    /* nothing yet */
	    break ;
	 case 'B':
	    printer_bold = TRUE ;
	    /* fall through to -b */
	 case 'b':
	    boldface = TRUE ;
	    break ;
	 case 'd':
	    duplex = TRUE ;
	    break ;
	 case 'm':
	    multi_file = TRUE ;
	    break ;
	 case 'n':
	    pages_printed = atoi(argv[1]+2) ;
	    break ;
	 case 'r':
	    first_page = atoi(argv[1]+2) ;
	    last_page_num = strchr(argv[1]+2, ':') ;
	    last_page = last_page_num ? atoi(last_page_num+1) : 0 ;
	    if (last_page == 0)
	       last_page = 9999 ;
	    break ;
	 case 'i':
	    indent = atoi(argv[1]+2) ;
	    break ;
	 case 's':
	    summary_file = argv[1]+2 ;
	    break ;
	 case 'f':
	    formats_file = argv[1]+2 ;
	    break ;
	 case 'w':
	    widow_length = atoi(argv[1]+2) ;
	    break ;
	 case 'l':
	    lines_per_page = atoi(argv[1]+2) ;
	    break ;
	 case 'L':
	    total_lines = atoi(argv[1]+2) ;
	    break ;
	 case 't':
	    typeface = argv[1]+2 ;
	    break ;
	 default:
	    usage() ;
	 }
      argv++ ;
      argc-- ;
      }
   if (printer == NULL)
      select_printer("default") ;
   /* apply any necessary overrides to parameters */
   if (printer->indent != -1)
      indent = printer->indent ;
   if (lines_per_page <= 0)
      lines_per_page = printer->lines_per_page ;
   if (total_lines <= 0)
      total_lines = printer->page_length ;
   if (page_width <= 0)
      page_width = printer->page_width ;
   if (printer->flag)
      *(printer->flag) = TRUE ;
   if (cstrlen(&printer->bold_on) == 0)  /* control sequences for bold? */
      printer_bold = FALSE ;		/* if not, don't try to use them */

   /* open the summary file, if any */
   if (summary_file && *summary_file)
      if ((summary = fopen(summary_file, pages_printed ? "a":"w")) != NULL)
	 do_summary = TRUE ;
      else
	 fputs("unable to open summary file\n", stderr) ;
   /* open the data formats file, if any */
   if (formats_file && *formats_file)
      if ((formats = fopen(formats_file, pages_printed ? "a":"w")) != NULL)
	 do_formats = TRUE ;
      else
	 fputs("unable to open formats file\n", stderr) ;
   if (total_lines <= lines_per_page)
      {
      total_lines = lines_per_page ;
      use_FF = TRUE ;
      }
   else
      use_FF = FALSE ;
   if (argc == 2 || argc == 3)
      {
      input_file = argv[1] ;
      infile = fopen(input_file,"r") ;
      if (infile == NULL)
	 fatal("unable to open input file") ;
      if (argc == 3)
	 {
	 outfile = fopen(argv[2],(pages_printed?"a":"w")) ;
	 if (outfile == NULL)
	    fatal("unable to open output file") ;
	 }
      else
	 outfile = stdout ;
      }
   else
      usage() ;
   if (lines_per_page < 20 || lines_per_page > MAXPAGE)
      {
      fputs("Surely you jest!  At least 20 and at most 200 lines per page.\n\n", stderr) ;
      usage() ;
      }
   if (widow_length < 3 || widow_length > lines_per_page / 2)
      {
      fputs("Widow lines (-w) must be set to at least 3 and at most one-half of the\n",stderr) ;
      fputs("page length.  Using default of 10 lines.\n",stderr) ;
      widow_length = 10 ;
      }
#ifdef __TURBOC__
   setvbuf(infile,NULL,_IOFBF,10240) ;	/* use larger disk buffers */
   setvbuf(outfile,NULL,_IOFBF,10240) ; /* for better performance */
   if (do_summary)
      setvbuf(summary,NULL,_IOFBF,4096) ;
   if (do_formats)
      setvbuf(formats,NULL,_IOFBF,4096) ;
#endif /* __TURBOC__ */
   /* set up the printer */
   fputcstr(&printer->init1,outfile) ;
   fputcstr(&printer->init2,outfile) ;
   if (HPPCL_mode)
      {
      fputs(HPPCL_FONT_ON_A,outfile) ;
      if (typeface)
	 fputs(typeface,outfile) ;
      else
	 fputs("8",outfile) ;
      fputs(HPPCL_FONT_ON_B,outfile) ;
      }
   if (duplex)
      {
      fputcstr(&printer->duplex_on,outfile) ;
      if ((pages_printed % 2) == 1)	/* next page odd or even? */
	 fputcstr(&printer->marginl,outfile) ;	/* even */
      else
	 fputcstr(&printer->marginr,outfile) ;	/* odd */
      }
   else
      fputcstr(&printer->marginc,outfile) ;	/* non-duplex, so center */
   /* start the summary file */
   if (do_summary && pages_printed == 0)
      { 	  /* create header, but only on first part */
      /* set up the printer */
      fputcstr(&printer->init1,summary) ;
      fputcstr(&printer->init2,summary) ;
      fputcstr(&printer->marginc,summary) ;
      indent_line(summary) ;
      fputs("\t\t\t\tInterrupt Summary\n",summary) ;
      indent_line(summary) ;
      fputs("\t\t\t\t", summary) ;
      (*printer->put_line)(summary,17) ;
      fputs("\n\n",summary) ;
      indent_line(summary) ;
      fputs("INT AH AL", summary) ;
      if (page_numbers)
	 fputs(" Page", summary) ;
      fputs("\t\t\tDescription\n", summary) ;
      indent_line(summary) ;
      (*printer->put_line)(summary,page_width) ;
      fputc('\n', summary) ;
      }
   /* start the data formats file */
   if (do_formats && pages_printed == 0)
      { 	  /* create header, but only on first part */
      /* set up the printer */
      fputcstr(&printer->init1,formats) ;
      fputcstr(&printer->init2,formats) ;
      fputcstr(&printer->marginc,formats) ;
      indent_line(formats) ;
      fputs("\t\t\tData Structure Formats\n", formats) ;
      indent_line(formats) ;
      fputs("\t\t\t", formats) ;
      (*printer->put_line)(formats,22) ;
      fputs("\n\n", formats) ;
      indent_line(formats) ;
      fputs("INT AH AL", formats) ;
      if (page_numbers)
	 fputs(" Page", formats) ;
      fputs("\t\tData Structure\n", formats) ;
      }
   if (page_numbers)
      body_lines = lines_per_page - 2 ;
   else
      body_lines = lines_per_page ;
   last_line = 0 ;
   while (!feof(infile) && !out_of_files)
      {
      fill_buffer(last_line,body_lines) ;
      last_line = find_page_break(body_lines) ;
      print_buffer(0,last_line,lines_per_page,total_lines,use_FF) ;
      }
   if (last_line < body_lines)
      print_buffer(last_line,body_lines,lines_per_page,total_lines,use_FF) ;
   /* reset the printer */
   fputcstr(&printer->term1,outfile) ;
   fputcstr(&printer->term2,outfile) ;
   fflush(outfile) ;
   itoa(pages_printed, num, 10) ;
   fputs(num, stderr) ;
   fputs(" pages\n", stderr) ;
   if (do_summary)
      {
      /* reset the printer */
      fputcstr(&printer->term1,summary) ;
      fputcstr(&printer->term2,summary) ;
      fclose(summary) ;
      }
   if (do_formats)
      {
      /* reset the printer */
      fputcstr(&printer->term1,formats) ;
      fputcstr(&printer->term2,formats) ;
      fclose(formats) ;
      }
   fclose(infile) ;
   return 0 ;
}
