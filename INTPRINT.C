/***********************************************/
/* Copyright (c) 1989  Ralf Brown              */
/* May be freely redistributed provided no fee */
/* is charged, this notice remains intact,     */
/* and any changes are clearly marked as such  */
/***********************************************/
/* Program History:                            */
/*   v1.00  4/23/89  initial public release    */
/*                   with 4/30/89 list         */
/***********************************************/

#include <stdio.h>
#include <string.h>

#define VERSION "1.00"

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
void _setenvp(void) {} /* don't need the environment, so don't include it */
int isspace(char c) { return (c == ' ' || c == '\t') ; }
#else
/*#define PROTOTYPES  /* uncomment if compiler supports ANSI-style prototypes */
#  include <ctype.h>
char *itoa(num,buf,radix)   /* not everybody has the same itoa() as TurboC */
int num ;                   /* minimal implementation */
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
#endif __TURBOC__

#ifdef PROTOTYPES
void usage(void) ;
void fill_buffer(int lines, int lines_per_page) ;
int find_page_break(int lines) ;
void summarize(FILE *summary, int line, int pages_printed) ;
void print_buffer(int first, int last, int lines_per_page, int total_lines, int use_FF) ;
void main(int argc, char **argv) ;
#endif PROTOTYPES

char buffer[MAXPAGE][MAXLINE] ;
char num[6] ;
int pages_printed = 0 ;
int indent = 0 ;
int page_numbers = FALSE ;
int do_summary = FALSE ;
FILE *summary ;

void usage()
{
   fputs( "INTPRINT v", stderr ) ;
   fputs( VERSION, stderr ) ;
   fputs( " Copyright (c) 1989  Ralf Brown.  Free for non-commercial use.\n\n", stderr ) ;
   fputs( "Usage: intprint [options] [lines [page_size]] <intlist >output\n", stderr );
   fputs( "\t'lines' defaults to 60\n", stderr ) ;
   fputs( "\tif page_size is given, only linefeeds will be used to advance\n", stderr ) ;
   fputs( "Options:\n", stderr ) ;
   fputs( "\t-p\tcauses pages to be numbered\n", stderr ) ;
   fputs( "\t-nN\tassume N pages have been printed from previous parts\n", stderr ) ;
   fputs( "\t-e\tassume 'elite' mode (96 characters per line)\n", stderr ) ;
   fputs( "\t-iN\tindent output N spaces\n", stderr ) ;
   fputs( "\t-E\tspecifies that the printer is an Epson FX80 or compatible\n", stderr ) ;
   fputs( "\t\t-E overrides -e and forces -i8\n", stderr ) ;
   fputs( "\t-sfile\twrite a one-line-per-function summary to 'file'\n", stderr ) ;
   exit(1) ;
}

void fill_buffer(lines,lines_per_page)
int lines, lines_per_page ;
{
   int i ;

   if (lines)
      for (i = lines ; i < lines_per_page ; i++)
         strcpy( buffer[i-lines], buffer[i] ) ;
   else
      lines = lines_per_page ;
   for (i = lines_per_page - lines ; i < lines_per_page ; i++)
      {
      buffer[i][0] = '\0' ;  /* force empty line in case of EOF */
      fgets( buffer[i], sizeof(buffer[i]), stdin ) ;
      }
}

int find_page_break(lines)
int lines ;
{
   int i ;

   for (i = 0 ; i < 10 ; i++)
      {
      if (strcmp(buffer[lines-i-1],"\n") == 0 ||
          strlen(buffer[lines-i-1]) == 0 ||
          strncmp(buffer[lines-i-1],"--------",8) == 0)
         return lines - i ;
      }
   return lines ;
}

void summarize(summary, line, pages_printed)
FILE *summary ;
int line, pages_printed ;
{
   char *s ;
   int i ;
   int max_descrip ;

   max_descrip = (page_numbers ? 65 : 69) ;
   s = buffer[line] ;
   if (strncmp(s, "INT ", 4 ) == 0)   /* start of an entry? */
      {
      fputc(' ', summary) ;
      fputc(s[4], summary) ;  /* output interrupt number */
      fputc(s[5], summary) ;
      fputc(' ', summary) ;
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
         while (*s && *s != '=' )
            s++ ;
         s++ ;  /* skip the equal sign */
         while (*s && isspace(*s))
            s++ ;
         if (strchr("0123456789ABCDEFabcdef",*s) != NULL)
            {
            fputc(*s++, summary) ;
            fputc(*s++, summary) ;
            fputc(' ', summary) ;
            if (i == 4)
               {
               fputc(*s++, summary) ;
               fputc(*s, summary) ;
               fputc(' ', summary) ;
               }
            else
               fputs( "-- ", summary) ;
            }
         else
            fputs( "-- -- ", summary) ;  /* wasn't legal digit, so no numbers */
         }
      else
         fputs("-- -- ", summary) ;
      if (page_numbers)
         {
         itoa(pages_printed+1,num,10) ; /* pages_printed not incremented until later */
         for (i = strlen(num) ; i < 3 ; i++)
            fputc(' ', summary) ;
         fputs(num, summary) ;
         fputc(' ', summary) ;
         }
      s = buffer[line] + 7 ;  /* find function description */
      while (*s && !isspace(*s))
         s++ ;
      while (*s && isspace(*s))
         s++ ;
      for (i = 0 ; (i < max_descrip) && *s && (*s != '\n') ; i++)
         fputc(*s++, summary) ;
      fputc('\n',summary) ;
      }
}

void print_buffer(first,last,lines_per_page,total_lines,use_FF)
int first, last, lines_per_page, total_lines ;
int use_FF ;
{
   int i, ind ;

   for (i = first ; i < last ; i++)
      {
      for (ind = 0 ; ind < indent ; ind++)
         fputc( ' ', stdout ) ;
      if (buffer[i][0])
         {
         fputs( buffer[i], stdout ) ;
         if (do_summary)
            summarize(summary,i,pages_printed) ;
         }
      else
         fputs( "\n", stdout ) ;
      }
   pages_printed++ ;
   if (page_numbers)
      {
      for (i = last - first ; i < lines_per_page - 1 ; i++)
         fputc( '\n', stdout ) ;
      for (ind = 0 ; ind < indent ; ind++)
         fputc( ' ', stdout ) ;
      fputs( "                                      - ", stdout ) ;
      itoa( pages_printed, num, 10 ) ;
      fputs( num, stdout ) ;
      fputs( " -\n", stdout ) ;
      }
   if (use_FF)
      fputc( '\f', stdout ) ;
   else
      for (i = page_numbers?lines_per_page:(last-first) ; i<total_lines ; i++)
         fputc( '\n', stdout ) ;
}

void main(argc,argv)
int argc ;
char *argv[] ;
{
   int lines_per_page = 60 ;
   int total_lines = 66 ;
   int use_FF = TRUE ;
   int Epson_mode = FALSE ;
   int last_line ;
   int body_lines ;
   int i ;
   char *summary_file = NULL ;

   while (argc >= 2 && argv[1][0] == '-')
      {
      switch (argv[1][1])
         {
         case 'e':
            indent = 8 ;
            break ;
         case 'E':
            Epson_mode = TRUE ;
            break ;
         case 'p':
            page_numbers = TRUE ;
            break ;
         case 'n':
            pages_printed = atoi( argv[1]+2 ) ;
            break ;
         case 'i':
            indent = atoi( argv[1]+2 ) ;
            break ;
         case 's':
            summary_file = argv[1]+2 ;
            break ;
         default:
            usage() ;
         }
      argv++ ;
      argc-- ;
      }
   if (summary_file)
      {
      if ((summary = fopen( summary_file, pages_printed ? "a":"w" )) != NULL)
         do_summary = TRUE ;
      else
         fputs( "unable to open summary file\n", stderr ) ;
      }
   if (argc >= 2)
      lines_per_page = atoi(argv[1]) ;
   if (argc == 3)
      {
      total_lines = atoi(argv[2]) ;
      use_FF = FALSE ;
      }
   if (total_lines < lines_per_page)
      {
      total_lines = lines_per_page ;
      use_FF = TRUE ;
      }
   if (argc > 3 || lines_per_page == 0) /* too many or non-numeric first param */
      usage() ;
   if (lines_per_page < 20 || lines_per_page > MAXPAGE)
      {
      fputs( "Surely you jest!  At least 20 and at most 200 lines per page.\n\n", stderr ) ;
      usage() ;
      }
#ifdef __TURBOC__
   setvbuf(stdin,NULL,_IOFBF,12288) ;  /* use larger disk buffers */
   setvbuf(stdout,NULL,_IOFBF,12288) ; /* for better performance */
   if (do_summary)
      setvbuf(summary,NULL,_IOFBF,4096) ;
#endif __TURBOC__
   if (do_summary && pages_printed == 0)
      {           /* create header, but only on first part */
      fputs("\t\t\t\tInterrupt Summary\n", summary) ;
      fputs("\t\t\t\t-----------------\n\n", summary) ;
      fputs("INT AH AL", summary) ;
      if (page_numbers)
         fputs(" Page", summary) ;
      fputs("\t\t\tDescription\n", summary) ;
      for (i = 0 ; i < 79 ; i++)
         fputc('-', summary) ;
      fputc('\n', summary) ;
      }
   if (Epson_mode)
      {
      indent = 0 ;  /* -E overrides -e and -i */
      fputs( "\033M\033l\007", stdout ) ;
      }
   last_line = 0 ;
   if (page_numbers)
      body_lines = lines_per_page - 2 ;
   else
      body_lines = lines_per_page ;
   while (!feof(stdin))
      {
      fill_buffer(last_line,body_lines) ;
      last_line = find_page_break(body_lines) ;
      print_buffer(0,last_line,lines_per_page,total_lines,use_FF) ;
      }
   if (last_line < body_lines)
      print_buffer(last_line,body_lines,lines_per_page,total_lines,use_FF) ;
   if (Epson_mode)
      {
      fputs( "\033M\033l", stdout ) ;  /* cancel Elite mode and indent */
      fputc( '\0', stdout ) ;
      }
   fflush(stdout) ;
   itoa( pages_printed, num, 10 ) ;
   fputs( num, stderr ) ;
   fputs( " pages\n", stderr) ;
   if (do_summary)
      fclose(summary) ;
   exit(0) ;
}
