/***********************************************/
/* Copyright (c) 1989  Ralf Brown              */
/* May be freely redistributed provided no fee */
/* is charged, this notice remains intact,     */
/* and any changes are clearly marked as such  */
/***********************************************/
/* Program History:                            */
/*   v1.00  4/23/89  initial public release    */
/*                   with 4/30/89 list         */
/*   v1.10  5/21/89  added -I and -f           */
/***********************************************/

#include <stdio.h>
#include <string.h>

#define VERSION "1.10"

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

/***********************************************/

#ifdef PROTOTYPES
void usage(void) ;
void indent_line(FILE *fp) ;
void put_line(FILE *fp, int len) ;
int divider_line(char *line) ;
void fill_buffer(int lines, int lines_per_page) ;
int find_page_break(int lines) ;
void summarize(FILE *summary, int line, int pages_printed) ;
void start_format(char *line) ;
void print_line(char *line) ;
void print_buffer(int first, int last, int lines_per_page, int total_lines, int use_FF) ;
void main(int argc, char **argv) ;
#endif PROTOTYPES

/***********************************************/

char buffer[MAXPAGE][MAXLINE] ;
char num[6] ;
char summary_line[MAXLINE] ;

int pages_printed = 0 ;
int indent = 0 ;
int page_numbers = FALSE ;
int do_summary = FALSE ;
int do_formats = FALSE ;
int IBM_chars = FALSE ;
int echo_format = FALSE ;
FILE *summary ;
FILE *formats ;

/***********************************************/

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
   fputs( "\t-I\tprinter supports IBM graphics characters\n", stderr ) ;
   fputs( "\t-sfile\twrite a one-line-per-function summary to 'file'\n", stderr ) ;
   exit(1) ;
}

/***********************************************/

void indent_line(fp)
FILE *fp ;
{
   int ind ;

   for (ind = 0 ; ind < indent ; ind++)
      fputc( ' ', fp ) ;
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

int divider_line(line)
char *line ;
{
   return strncmp(line,"--------",8) == 0 ;
}

/***********************************************/

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

/***********************************************/

int find_page_break(lines)
int lines ;
{
   int i ;

   for (i = 0 ; i < 10 ; i++)
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
   if (strncmp(s, "INT ", 4 ) == 0)   /* start of an entry? */
      {
      summary_line[3] = summary_line[0] = ' ' ;
      summary_line[1] = s[4] ;   /* output interrupt number */
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
         while (*s && *s != '=' )
            s++ ;
         s++ ;  /* skip the equal sign */
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
         itoa(pages_printed+1,num,10) ; /* pages_printed not incremented until later */
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
      for (i = 0 ; i < max_descrip && *s && *s != '\n' ; i++)
         summary_line[len++] = *s++ ;
      summary_line[len++] = '\n' ;
      summary_line[len] = '\0' ;
      if (do_summary)
         {
         indent_line(summary) ;
         fputs(summary_line,summary) ;
         }
      }
}

/***********************************************/

void start_format(line)
char *line ;
{
   indent_line(formats) ;
   put_line(formats,79) ;
   fputc('\n',formats) ;
   indent_line(formats) ;
   fputs(summary_line,formats) ;
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
   if (*line == '\0' || *line == '\n' || divider_line(line))
      echo_format = FALSE ;
   if (*line && *line != '\n')
      {
      indent_line(stdout) ;
      if (divider_line(line))
         {
         put_line(stdout,79) ;
         fputc('\n', stdout) ;
         echo_format = FALSE ;
         }
      else
         {
         fputs(line, stdout) ;
         if (echo_format)
            {
            indent_line(formats) ;
            fputs(line,formats) ;
            }
         }
      }
   else
      {
      fputc('\n', stdout) ;
      echo_format = FALSE ;
      }
}

/***********************************************/

void print_buffer(first,last,lines_per_page,total_lines,use_FF)
int first, last, lines_per_page, total_lines ;
int use_FF ;
{
   int i, ind ;

   for (i = first ; i < last ; i++)
      {
      print_line(buffer[i]) ;
      if (do_summary || do_formats)  /* need summary lines if doing formats */
         summarize(summary,i,pages_printed) ;
      if (do_formats && strncmp(buffer[i],"Format of ",10) == 0)
         start_format(buffer[i]) ;
      }
   pages_printed++ ;
   if (page_numbers)
      {
      for (i = last - first ; i < lines_per_page - 1 ; i++)
         fputc( '\n', stdout ) ;
      indent_line(stdout) ;
      for (ind = 0 ; ind < 38 ; ind++) /* normal indent + 38 spaces */
         fputc( ' ', stdout ) ;
      fputs( "- ", stdout ) ;
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

/***********************************************/

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
   char *summary_file = NULL ;
   char *formats_file = NULL ;

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
         case 'I':
            IBM_chars = TRUE ;
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
         case 'f':
            formats_file = argv[1]+2 ;
            break ;
         default:
            usage() ;
         }
      argv++ ;
      argc-- ;
      }
   if (summary_file && *summary_file)
      if ((summary = fopen( summary_file, pages_printed ? "a":"w" )) != NULL)
         do_summary = TRUE ;
      else
         fputs( "unable to open summary file\n", stderr ) ;
   if (formats_file && *formats_file)
      if ((formats = fopen( formats_file, pages_printed ? "a":"w" )) != NULL)
         do_formats = TRUE ;
      else
         fputs( "unable to open formats file\n", stderr ) ;
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
   setvbuf(stdin,NULL,_IOFBF,10240) ;  /* use larger disk buffers */
   setvbuf(stdout,NULL,_IOFBF,10240) ; /* for better performance */
   if (do_summary)
      setvbuf(summary,NULL,_IOFBF,4096) ;
   if (do_formats)
      setvbuf(formats,NULL,_IOFBF,4096) ;
#endif __TURBOC__
   if (do_summary && pages_printed == 0)
      {           /* create header, but only on first part */
      indent_line(summary) ;
      fputs("\t\t\t\tInterrupt Summary\n",summary) ;
      indent_line(summary) ;
      fputs("\t\t\t\t", summary) ;
      put_line(summary,17) ;
      fputs("\n\n",summary) ;
      indent_line(summary) ;
      fputs("INT AH AL", summary) ;
      if (page_numbers)
         fputs(" Page", summary) ;
      fputs("\t\t\tDescription\n", summary) ;
      indent_line(summary) ;
      put_line(summary,79) ;
      fputc('\n', summary) ;
      }
   if (do_formats && pages_printed == 0)
      {           /* create header, but only on first part */
      indent_line(formats) ;
      fputs("\t\t\tData Structure Formats\n", formats) ;
      indent_line(formats) ;
      fputs("\t\t\t", formats) ;
      put_line(formats,22) ;
      fputs("\n\n", formats) ;
      indent_line(formats) ;
      fputs("INT AH AL", formats) ;
      if (page_numbers)
         fputs(" Page", formats) ;
      fputs("\t\tData Structure\n", formats) ;
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
   if (do_formats)
      fclose(formats) ;
   exit(0) ;
}
