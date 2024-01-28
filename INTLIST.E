/****************************************************************/
/*	EEL code file for editing the Interrupt List		*/
/*								*/
/*	Written by Ralf Brown					*/
/*	LastEdit:  6 Feb 92					*/
/*								*/
/*  This EEL file adds the following keybindings:		*/
/*	Alt-N	add a new note to current entry or data struct  */
/*	Alt-S	insert SeeAlso: at start of line		*/
/*	Alt-R	insert Return: at start of line			*/
/*	F11	insert a blank separator line			*/
/*	^F11	create Format of: header			*/
/*	+F11	create Values for: header			*/
/*	Alt-F11 create Call with: header			*/
/*	F12	add the interrupt number to the separator line	*/
/*		preceding the current entry			*/
/*	^F12	jump to a specified entry			*/
/*								*/
/*  Other:							*/
/*	adds intlist-mode for .LST and .1ST files		*/
/*	switches current buffer into intlist-mode on loading	*/
/****************************************************************/

#include "eel.h"

keytable intlist_tab ;			/* key table for IntList mode */

/*=============================================================*/
/*=============================================================*/

int empty_line()
{
   return (character(point-1) == '\n' && character(point) == '\n') ;
}

/*=============================================================*/
/* Add "SeeAlso: " to the beginning of the current line unless */
/* it is already present				       */
/*=============================================================*/

command see_also() on intlist_tab[ALT('s')]
{
   int start = point ;
   
   to_begin_line() ;
   if (parse_string(1,"SeeAlso: ",NULL) == 0)
      stuff("SeeAlso: ") ;
   else
      point = start ;
}

/*=============================================================*/
/*=============================================================*/

int is_separator_line()
{
   if (empty_line() || parse_string(1,"--------",NULL))
      return 1 ;
   else 
      return 0 ;
}

/*=============================================================*/
/* Add "Note: " section to the current entry; change an	       */
/* existing Note: to Notes: and position at end of Note:       */
/* section.						       */
/*=============================================================*/

command note() on intlist_tab[ALT('n')]
{
   int len ;
   int done = 0 ;
   
   to_begin_line() ;
   while (!empty_line() && !parse_string(1,"\n--------",NULL))
      if (!nl_reverse())
	 break ;
   point++ ;				/* skip the newline */
   nl_forward() ;			/* advance a line */
   while (!is_separator_line() && !parse_string(1,"Notes*:\t",NULL) &&
          !parse_string(1,"SeeAlso:",NULL))
      if (!nl_forward())
	 break ;
   len = parse_string(1,"Notes*:\t",NULL) ;
   if (len == 0) /* no notes section */
      stuff("Note:") ;
   else
      {
      if (len == 6)  /* Note: */
	 {
	 point += 4 ;
	 stuff("s") ;	/* change it to Notes: */
	 }
      while (!is_separator_line() && !parse_string(1,"SeeAlso:",NULL))
	 nl_forward() ;
      }
   stuff("\t\n") ;
   point-- ;
}

/*=============================================================*/
/* Insert "Return: " at the beginning of the current line, if  */
/* not already present					       */
/*=============================================================*/

command returns() on intlist_tab[ALT('r')]
{
   int len ;
   int start = point ;
   
   to_begin_line() ;
   if (parse_string(1,"Return: ",NULL) == 0)
      stuff("Return: ") ;
   else
      point = start ;
}

/*=============================================================*/
/* insert a line of dashes prior to the current cursor line    */
/*=============================================================*/

command separator_line() on intlist_tab[FKEY(11)]
{
   int i ;

   to_begin_line() ;
   for (i = 0 ; i < 45 ; i++)
      insert('-') ;
   insert('\n') ;
}

/*=============================================================*/
/* type the name of a structure, then invoke this function     */
/* to create the "Format of X:" and "Offset Size Descr" lines  */
/*=============================================================*/

command structure_header() on intlist_tab[FCTRL(11)]
{
   to_begin_line() ;
   stuff("Format of ") ;
   to_end_line() ;
   stuff(":\nOffset\tSize\tDescription\n 00h\t") ;
}

/*=============================================================*/
/* Turn the current line into the header for a "Values of"     */
/* section						       */
/*=============================================================*/

command value_header() on intlist_tab[FSHIFT(11)]
{
   int start = point ;
   
   to_begin_line() ;
   if (parse_string(1,"Values for ",NULL) == 0)
      {
      stuff("Values for ") ;
      to_end_line() ;
      stuff(":\n ") ;
      }
   else
      point = start ;
}

/*=============================================================*/
/* Turn the current line into the header of a "Call with"      */
/* section						       */
/*=============================================================*/

command call_with_header() on intlist_tab[FALT(11)]
{
   int start = point ;
   
   to_begin_line() ;
   if (parse_string(1,"Call ",NULL) == 0)
      {
      stuff("Call ") ;
      to_end_line() ;
      stuff("with:\n") ;
      }
   else
      point = start ;
}

/*=============================================================*/
/*=============================================================*/

char grab_entry_number(func_num)
char *func_num ;
{
   char c ;
   
   strcpy(func_num,"------------") ;	/* 12 dashes */
   point++ ;				/* go to first char of separator line */
   nl_forward() ;			/* go to first line of entry */
   if (parse_string(1,"INT ",NULL) == 0)
      return 0 ;			/* not an interrupt entry, so return */
   point += 4 ;				/* skip the "INT " */
   func_num[0] = curchar() ;		/* grab the interrupt number */
   point++ ;
   func_num[1] = curchar() ;
   nl_forward() ;			/* skip to second line of entry */
   if (parse_string(1,"[ \t]*A[LHX][ \t]=[ \t][0-9A-F][0-9A-F]+h",NULL))
      {
      re_search(1,"[ \t]*A") ;
      c = curchar() ;
      point += 4 ;			/* skip ch and " = " */
      if (c != 'L')
	 {
	 grab(point,point+((c=='X')?4:2),func_num+2) ;
	 func_num[(c=='H')?4:6] = '-' ;	/* grab() stuck a NUL into the string */
	 nl_forward() ;			/* skip to third line of entry */
	 }
      else /* c == 'L' */
	 {
	 func_num[6] = 'A' ;
	 func_num[7] = 'L' ;
	 grab(point,point+2,func_num+8) ;
	 func_num[10] = '-' ;		/* grab() stuck a NUL into the string */
	 return 1 ;
	 }
      }
   if (parse_string(1,"[ \t]*[BCDES][HILPSX] = [0-9A-F][0-9A-F]+h",NULL))
      {
      re_search(1,"[ \t]*") ;
      func_num[6] = curchar() ;
      point++ ;
      func_num[7] = c = curchar() ;
      point += 4 ;			/* skip curchar and " = " */
      if (c == 'H' || c == 'L')
	 {
	 grab(point,point+2,func_num+8) ;
	 func_num[10] = '-' ;		/* grab() stuck a NUL into the string */
	 }
      else /* c == 'X' || c == 'I' || c == 'P' || c == 'S' */
	 grab(point,point+4,func_num+8) ;
      }
   return 1 ;				/* successful and have func number */
}

/*=============================================================*/
/* Put the interrupt and function number into the separator    */
/* line just above the intlist entry preceding the cursor pos  */
/*=============================================================*/

int number_one_int()
{
   char func_num[13] ;			/* 2->int, 4->AX, 6->extra reg, NUL */
   int oldpoint ;
   
   while (search(-1,"\n--------"))	/* find previous separator line */
      {
      oldpoint = point ;
      if (grab_entry_number(func_num))	/* does it belong to an intlist entry? */
	 {				/*   if yes, success, else try again */
	 point = oldpoint + 11 ;	/* skip NL and first ten dashes */
	 delete(point,point+12) ;	/* replace 12 dashes by the function */
	 stuff(func_num) ;		/*   number and extra register */
	 point = oldpoint ;		/* back to start of line, allowing repeat */
	 return 1 ;
	 }
      point = oldpoint ;
      }
   return 0 ;				/* if we get here, we failed */
}

/*=============================================================*/
/* Put the interrupt and function number into the separator    */
/* line just above one or more intlist entries preceding the   */
/* current cursor position, letting user know of progress      */
/*=============================================================*/

command number_int() on intlist_tab[FKEY(12)]
{
   int i, hit_top = 0 ;
   
   for (i = 0 ; i < iter ; i++)
      {
      if (!number_one_int())
	 {
	 hit_top = 1 ;
	 say("No prior entry.") ;
	 break ;
	 }
      if (((i+1) % 100) == 0)
	 say("%d...",i+1) ;
      }
   if (iter > 1 && !hit_top)
      say("Done.") ;
   iter = 1 ;
}

/*=============================================================*/
/*=============================================================*/

int line_has_see_also()
{
   int start = point ;
   int len ;
   
   to_begin_line() ;
   if ((len = parse_string(1,".*%([sS]ee ",NULL)) != 0)
      {
      point += len ;		/* go to start of cross-reference */
      point += parse_string(1,"also ",NULL) ;
      if (parse_string(1,"INT [0-9A-F]",NULL) ||
	  parse_string(1,"A[XHL] =",NULL)
	 )
	 {
	 point++ ;		/* move into reference */
	 return 1 ;
	 }
      }
   return 0 ;
}

/*=============================================================*/
/*=============================================================*/

int grab_int_reference(ref)
char *ref ;
{
   int begin, start = point ;
   
   re_search(-1,"[, \t\n]") ;	/* backup to start of reference */
   if (curchar() == '\n')	/* start of line? */
      re_search(1,":[ \t]") ;	/* skip the SeeAlso: */
   else if (character(point-1) == 'T' && character(point-2) == 'N')
      point -= 3 ;
   else
      point++ ;			/* back to start of reference */
   begin = point ;
   re_search(1,"[,\n\"]") ;	/* find end of INT-spec */
   point-- ;
   if (curchar() == '\"')	/* extra string at end of INT-spec? */
      {
      point++ ;
      re_search(1,"[\"\n]") ;	/* if yes, run to end of line or string */
      }
   grab(begin,point,ref) ;
   point = start ;
   return 0 ;
}

/*=============================================================*/
/*=============================================================*/

int parse_int_name(entry_name,id,extra_string)
char *entry_name, *id, *extra_string ;
{
   int start = point ;
   int i ;
   char def_int[3] ;
   char c, *last ;

   for (i = strlen(entry_name)-1 ; i >= 0 ; i--)
      entry_name[i] = toupper(entry_name[i]) ;
   strcpy(id,"------------") ;
   if (strncmp(entry_name,"INT ",4) == 0)
      {
      id[0] = entry_name[4] ;
      id[1] = entry_name[5] ;
      entry_name += 6 ;
      if (entry_name[0] == '/')
	 entry_name++ ;
      }
   else if (search(-1,"\n----------"))
      {
      id[0] = character(point+11) ;
      id[1] = character(point+12) ;
      }
   point = start ;
   if (entry_name[0] == 'A' && (entry_name[1] == 'X' || entry_name[1] == 'H'))
      {
      c = entry_name[1] ;
      entry_name += 2 ;
      while (entry_name[0] == ' ' || entry_name[0] == '\t')
	 entry_name++ ;
      if (entry_name[0] == '=')
	 entry_name++ ;
      while (entry_name[0] == ' ' || entry_name[0] == '\t')
	 entry_name++ ;
      id[2] = entry_name[0] ;
      id[3] = entry_name[1] ;
      if (c == 'X')
	 {
	 id[4] = entry_name[2] ;
	 id[5] = entry_name[3] ;
	 entry_name += 4 ;
	 }
      else
	 entry_name += 2 ;
      if (entry_name[0] == 'H')
	 entry_name++ ;
      if (entry_name[0] == '/')
	 entry_name++ ;
      }
   if (index("ABCDES",entry_name[0]) && index("HILPSX",entry_name[1]))
      {
      id[6] = entry_name[0] ;
      c = id[7] = entry_name[1] ;
      entry_name += 2 ;
      while (entry_name[0] == ' ' || entry_name[0] == '\t')
	 entry_name++ ;
      if (entry_name[0] == '=')
	 entry_name++ ;
      while (entry_name[0] == ' ' || entry_name[0] == '\t')
	 entry_name++ ;
      id[8] = entry_name[0] ;
      id[9] = entry_name[1] ;
      if (c != 'H' && c != 'L')
	 {
	 id[10] = entry_name[2] ;
	 id[11] = entry_name[3] ;
	 entry_name += 4 ;
	 }
      else
	 entry_name += 2 ;
      if (entry_name[0] == 'H')
	 entry_name++ ;
      if (entry_name[0] == '/')
	 entry_name++ ;
      }
   if (entry_name[0] == '\"')
      {
      entry_name++ ;
      strcpy(extra_string,entry_name) ;
      last = index(extra_string,'\"') ;
      if (last)
	 *last = '\0' ;
      }
   else
      extra_string[0] = '\0' ;
   return 0 ;
}

/*=============================================================*/
/*=============================================================*/

int hex2_to_int(c1,c2)
char c1, c2 ;
{
   if (c1 >= '0' && c1 <= '9')
      c1 -= '0' ;
   else if (c1 >= 'A' && c1 <= 'F')
      c1 = c1 - 'A' + 10 ;
   else if (c1 >= 'a' && c1 <= 'f')
      c1 = c1 - 'a' + 10 ;
   else
      return -1 ;
   if (c2 >= '0' && c2 <= '9')
      c2 -= '0' ;
   else if (c2 >= 'A' && c2 <= 'F')
      c2 = c2 - 'A' + 10 ;
   else if (c2 >= 'a' && c2 <= 'f')
      c2 = c2 - 'a' + 10 ;
   else
      return -1 ;
   return 16*c1 + c2 ;
}

/*=============================================================*/
/*=============================================================*/

char hex_digit(val)
int val ;
{
   if (val < 0)
      return '-' ;
   else if (val > 9)
      return 'A' + val - 10 ;
   else
      return '0' + val ;
}

/*=============================================================*/
/*=============================================================*/

int scan_for_entry(entry,extra_str,first_entry)
char *entry, *extra_str ;
int *first_entry ;
{
   int ah, al, t1, t2, match, found ;
   char buf[7] ;
   
   *first_entry = 0 ;
   ah = hex2_to_int(entry[2],entry[3]) ;
   while (1)
      {
      if (!search(1,"\n---------"))
	 return 0 ;	/* failed if hit end of file */
      if (character(point+1) != entry[0] || character(point+2) != entry[1])
	 return 0 ;	/* failed if no longer on same interrupt */
      t1 = hex2_to_int(character(point+3),character(point+4)) ;
      if (t1 == ah)
	 break ;
      else if (t1 > ah)
	 {
	 to_begin_line() ;
	 *first_entry = point ;
	 return 0 ;	/* no such entry */
	 }
      }
   nl_reverse() ;
   *first_entry = point ;
   found = 0 ;
   al = hex2_to_int(entry[4],entry[5]) ;
   while (1)
      {
      if (!search(1,"\n---------"))
	 return 0 ;	/* failed if hit end of file */
      if (character(point+1) != entry[0] || character(point+2) != entry[1])
	 return 0 ;	/* failed if no longer on same interrupt */
      t1 = hex2_to_int(character(point+3),character(point+4)) ;
      if (t1 != ah)
	 return 0 ;	/* failed if no longer on same INT/AH combo */
      t2 = hex2_to_int(character(point+5),character(point+6)) ;
      if (t2 == al)
	 {
	 if (!found)
	    {
	    found = 1 ;
	    *first_entry = point ;
	    }
	 if (entry[6] != '-')
	    {
	    grab(point+7,point+12,buf) ;
	    match = strncmp(buf,entry+6,6) ;
	    if (match == 0)
	       {
	       *first_entry = point ;
	       break ;
	       }
	    else if (match > 0)
	       return 0 ;	/* no exact match, but return a partial match */
	    }
	 else
	    break ;
	 }
      else if (t2 > al)
	 {
	 if (found)
	    break ;
	 else
	    {
	    to_begin_line() ;
	    *first_entry = point ;
	    return 0 ;	/* no such entry */
	    }
	 }
      }
   point = *first_entry ;	/* back to first matching entry */
   
   
   return 1 ;			/* we were successful */
}

/*=============================================================*/
/*=============================================================*/

int goto_entry(entry_name)
char *entry_name ;
{
   char int_id[13], extra_string[60] ;
   int start = point, first_entry ;
   int int_num, curr_int ;
   char search_str[22] ;
   char line_buf[90] ;
   
   parse_int_name(entry_name,int_id,extra_string) ;
   int_num = hex2_to_int(int_id[0],int_id[1]) ;
   if (search(-1,"\n----------"))
      {
      if (character(point+11) == '-')
	 curr_int = -1 ;
      else
	 curr_int = hex2_to_int(character(point+11),character(point+12)) ;
      if (int_num <= 0)
	 point = 0 ;		/* go to top of file */
      else
	 {
	 if (curr_int < 0)
	    point = 0 ;		/* go to top of file */
	 strcpy(search_str,"----------") ;
	 search_str[10] = hex_digit((int_num-1) / 16) ;
	 search_str[11] = hex_digit((int_num-1) % 16) ;
	 search_str[12] = '\0' ;
	 search( (int_num<=curr_int)?-1:1, search_str) ;
	 to_begin_line() ;
	 }
      }
   else
      point = 0 ;
   if (!scan_for_entry(int_id,extra_string,&first_entry))
      {
      say("%s not found.",entry_name) ;
      if (first_entry)
	 {
	 mark = start ;
	 point = first_entry ;
	 }
      else
	 point = start ;
      }
   if (has_arg)
     iter = 1 ;				/* don't search repeatedly */
   return 0 ;
}

/*=============================================================*/
/*=============================================================*/

command goto_int() on intlist_tab[FCTRL(12)]
{
   char entry_name[60], def_entry[60] ;
   int start = point ;

   to_begin_line() ;
   if (parse_string(1,"SeeAlso: ",NULL) != 0)
      {
      point += 9 ;		/* skip the SeeAlso: */
      if (point < start)	/* if we were originally to the right of     */
	 point = start ;	/* current position, go back to original pos */
      grab_int_reference(def_entry) ;
      get_strdef(entry_name,"Goto Interrupt",def_entry) ;
      }
   else if (line_has_see_also())
      {
      grab_int_reference(def_entry) ;
      get_strdef(entry_name,"Goto Interrupt",def_entry) ;
      }
   else
      get_string(entry_name,"Goto Interrupt: ") ;
   point = start ;
   goto_entry(entry_name) ;
   if (has_arg)
      iter = 1 ;
}

/*=============================================================*/
/* Put the current buffer into IntList major mode	       */
/*=============================================================*/

command intlist_mode()
{
   mode_keys = intlist_tab ;
   intlist_tab[')'] = intlist_tab[']'] = (short) show_matching_delimiter;
   delete_hacking_tabs = 0 ;
   major_mode = strsave("IntList") ;
   make_mode() ;
   auto_indent = 0 ;
   margin_right = 79 ;
   want_backups = 1 ;
}

when_loading()
{
   char *curbuf ;

   want_backups = want_backups.default = 1 ;
   strcpy(backup_name,"%pbak/%b%e") ;
   one_window() ;
   intlist_mode() ;
   if (exist("interrup.1st"))
      {
      curbuf = bufname ;
      bufname = "interrup.1st" ;
      intlist_mode() ;
      bufname = curbuf ;
      }
}

/*=============================================================*/
/* automagically switch into interrupt list mode on .LST and .1ST files */

suffix_lst()   { intlist_mode(); }
suffix_1st()   { intlist_mode(); }
