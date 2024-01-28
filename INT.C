#ifdef	  __TURBOC__
#include <stdio.h>
#include <string.h>
#include <dos.h>
/*
*    Force the error for non Borland compilers.
*    NOTE:  This may or may not work for you.
*/
#endif





/*
*    8-bit Internationalization Strings.
*/
char*     msg_switchars       = "+/-";
char*     msg_cant_open_file  = "Unable to open %s\n";
char*     msg_usage      = /* No separator until the end. */
     "Use int(1) check the return values of any interrupt.\n\n"
     "%s usage:\n"
     "int [h] int=0x10 [{abcd}{xhl}=0xFFFF]\n"
     "where:\n"
     "h\tdisplays this usage.\n"
     "int       \tis the interrupt function to specify.\n"
     "ax, ah, al\tis set to the specified word or byte value in hex.\n"
     "bx, bh, bl\tis set to the specified word or byte value in hex.\n"
     "cx, ch, cl\tis set to the specified word or byte value in hex.\n"
     "dx, dh, dl\tis set to the specified word or byte value in hex.\n";

char msg_off_switchar= '-';
char*     msg_help  = "h";

char*     msg_int        = "int=";
char*     msg_ax         = "ax=";
char*     msg_ah         = "ah=";
char*     msg_al         = "al=";

char*     msg_bx         = "bx=";
char*     msg_bh         = "bh=";
char*     msg_bl         = "bl=";

char*     msg_cx         = "cx=";
char*     msg_ch         = "ch=";
char*     msg_cl         = "cl=";

char*     msg_dx         = "dx=";
char*     msg_dh         = "dh=";
char*     msg_dl         = "dl=";

char*     msg_cs         = "cs=";
char*     msg_ds         = "ds=";
char*     msg_es         = "es=";
char*     msg_ss         = "ss=";

char*     msg_si         = "si=";
char*     msg_di         = "di=";

char*     msg_bp         = "bp=";
char*     msg_sp         = "sp=";

char*     msg_flags[]    =
{
     "Carry Flag Set\t", /* 0x0001 */
     "Parity Flag Set\t",     /* 0x0002 */
     "Auxilliary Flag Set\t",/* 0x0004 */
     "Zero Flag Set\t",  /* 0x0008 */
     "Sign Flag Set\t",  /* 0x0010 */
     "Trap Flag Set\t",  /* 0x0020 */
     "Interrupt Flag Set\t",  /* 0x0040 */
     "Direction Flag Set\t",  /* 0x0080 */
     "Overflow Flag Set\t"    /* 0x0100 */
};




/*
*    Global Variables
*/
char*     me;
char intrrupt  = 0;
union     REGS regs = {0};
struct    SREGS     sregs     = {0};


/*----------------------------------------------------------------------
*    usage()   -- Display our usage.
*
*/
void usage( void )
{
     printf( msg_usage, me );
     exit( 1 );
}




/*----------------------------------------------------------------------
*    display_registers() -- display the current contents of regs & sregs.
*
*/
void display_registers( void )
{
     unsigned i;
     unsigned j;

     printf( "\n" );
     printf( msg_ax );   printf( "0x%04X\t", regs.x.ax );
     printf( msg_bx );   printf( "0x%04X\t", regs.x.bx );
     printf( msg_cx );   printf( "0x%04X\t", regs.x.cx );
     printf( msg_dx );   printf( "0x%04X\t", regs.x.dx );
     printf( msg_si );   printf( "0x%04X\t", regs.x.si );
     printf( msg_di );   printf( "0x%04X\t", regs.x.di );
     printf( msg_sp );   printf( "0x%04X\t", _SP );
     printf( msg_bp );   printf( "0x%04X\t", _BP );
     printf( msg_cs );   printf( "0x%04X\t", sregs.cs );    
     printf( msg_ds );   printf( "0x%04X\t", sregs.ds );    
     printf( msg_es );   printf( "0x%04X\t", sregs.es );    
     printf( msg_ss );   printf( "0x%04X\t", sregs.ss );    
     printf( "\n" );

     for( i=0x100, j=0; i; i>>=1, j++ )
     {
          if  (i & regs.x.flags)
               printf( msg_flags[j] );
     }
     printf( "\n" );
}




/*----------------------------------------------------------------------
*    gen_int() -- Generate a generic Interrupt call.
*
*/
void gen_int( void )
{
     if  (intrrupt)
     {
          sregs.cs = _CS;
          sregs.ds = _DS;
          sregs.es = _ES;
          sregs.ss = _SS;
          display_registers();
          printf( "INTERRUPT: 0x%02X\n", intrrupt );
          int86x( intrrupt, &regs, &regs, &sregs );
          display_registers();
     }
}




/*----------------------------------------------------------------------
*    setregw() -- set the word to be the value of the string 
*                 after the "=" sign.
*
*/
void setregw( regw, str )
unsigned* regw;
char*     str;
{
     char*     p    = strchr( str, '=' ) + 1;
     long scratch   = 0L;

     if  (p)
     {
          scratch = strtol( p, &p, 0x10 );
          *regw     = (unsigned)(scratch & 0xFFFF);
     }
}




/*----------------------------------------------------------------------
*    setregb() -- set the byte to be the value of the string 
*                 after the "=" sign.
*
*/
void setregb( regb, str )
char*     regb;
char*     str;
{
     char*     p    = (char*)strchr( str, '=' ) + 1;
     long scratch   = 0L;

     if  (p)
     {
          scratch = strtol( p, &p, 0x10 );
          *regb     = (unsigned)(scratch & 0xFFFF);
     }
}




/*----------------------------------------------------------------------
*    cmp()          -- handle all partial comparisons for parse_args().
*
*/
char cmp( arg, constant )
char*     arg;
char*     constant;
{
     unsigned  arglen    = strlen( arg );
     unsigned  equals    = strlen( strchr( arg, '=' ) );
     unsigned  cmplen    = arglen - equals;

     return( (!strncmpi( arg, constant, cmplen )) ? 1 : 0 );
}




/*----------------------------------------------------------------------
*    parse_args()   -- simple argument parsing.
*
*    Argument parsing is GNUish.
*         '-' is off
*         '+' is on
*         '/' is DOSishly on.
*
*    First character of arg is expected to be a switchar.
*/
void parse_args( arg )
char*     arg;
{
     char j  = ((strchr( msg_switchars, arg[0] ) == NULL) ? 0 : 1);
     char on = ((*arg == msg_off_switchar) ? 0 : 1);

     if  (cmp( arg+j, msg_help )) usage();
     if  (cmp( arg+j, msg_int  )) setregw( &intrrupt,  arg );
     if  (cmp( arg+j, msg_ax   )) setregw( &regs.x.ax, arg );
     if  (cmp( arg+j, msg_ah   )) setregb( &regs.h.ah, arg );
     if  (cmp( arg+j, msg_al   )) setregb( &regs.h.al, arg );
     if  (cmp( arg+j, msg_bx   )) setregw( &regs.x.bx, arg );
     if  (cmp( arg+j, msg_bh   )) setregb( &regs.h.bh, arg );
     if  (cmp( arg+j, msg_bl   )) setregb( &regs.h.bl, arg );
     if  (cmp( arg+j, msg_cx   )) setregw( &regs.x.cx, arg );
     if  (cmp( arg+j, msg_ch   )) setregb( &regs.h.ch, arg );
     if  (cmp( arg+j, msg_cl   )) setregb( &regs.h.cl, arg );
     if  (cmp( arg+j, msg_dx   )) setregw( &regs.x.dx, arg );
     if  (cmp( arg+j, msg_dh   )) setregb( &regs.h.dh, arg );
     if  (cmp( arg+j, msg_dl   )) setregb( &regs.h.dl, arg );
}




/*----------------------------------------------------------------------
*    main()    -- Handle switches, do the work.
*
*/
unsigned  main( argc, argv )
char argc;
char*     argv[];
{
     char i;

     me = argv[0];
     for( i=1; i<argc; i++ )
     {
          parse_args( argv[i] );
     }

     if  (!intrrupt)
          usage();

     gen_int();
     return( 0 );
}
