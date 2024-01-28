Interrupt List, part 4 of 16
Copyright (c) 1989,1990,1991,1992,1993,1994,1995,1996,1997 Ralf Brown
--------K-16FF-------------------------------
INT 16 - KEYBOARD - KBUF extensions - ADD KEY TO TAIL OF KEYBOARD BUFFER
	AH = FFh
	DX = scan code
Return: AL = status
	    00h success
	    01h failure
Program: KBUF is a keyboard buffer expander by Mark Adler
SeeAlso: AH=05h
--------V-16FF-------------------------------
INT 16 - OPTIMA 1024 VGA-Sync,ET-3000 chipset - QUERY ZOOM INTERRUPT
	AH = FFh
Return: AL = interrupt number to which BIOS keyboard handler has been relocated
	AL+1 = Zoom interrupt number
	BX = hotkey
Notes:	the default interrupts are 60h for keyboard and 61h for Zoom interrupt;
	  the default hot key is F10
	not all vendors include the Tseng TSR which supports these functions
SeeAlso: INT 61/AX=0000h"OPTIMA",INT 61/AX=0005h"OPTIMA"
Index:	hotkeys;OPTIMA 1024 VGA
----------16FF--BH00-------------------------
INT 16 - FREEZE.COM - INSTALLATION CHECK
	AH = FFh
	BH = 00h
Return: BH = FFh if installed
Program: FREEZE is a PC Magazine utility
--------d-16FF70BX0000-----------------------
INT 16 U - PC Tools v8+ DRIVEMAP - INSTALLATION CHECK
	AX = FF70h
	BX = 0000h
	CX = 4C69h ('Li')
	DX = 6E6Bh ('nk')
Return: AX = 0000h
	CX = 4350h ('CP')
	DH = major version
	DL = minor version
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
SeeAlso: AX=FF70h/BX=0001h,AX=FF70h/BX=0002h
--------d-16FF70BX0001-----------------------
INT 16 U - PC Tools v8+ DRIVEMAP - ???
	AX = FF70h
	BX = 0001h
	DL = ???
Return: AX = ???
	DH = ???
SeeAlso: AX=FF70h/BX=0000h,AX=FF70h/BX=0002h
--------d-16FF70BX0002-----------------------
INT 16 U - PC Tools v8+ DRIVEMAP - ???
	AX = FF70h
	BX = 0002h
	CX = ???
	DX = ???
Return: AX = ??? or FFFEh/FFFFh on error
	DL = ???
BUG:	DRIVEMAP will branch to random locations for BX values other than
	  those listed above for v8.0-9.0 because a) the incorrect register is
	  range-tested, resulting in BX=0003h-5CD6h being accepted as valid
	  function numbers, and b) the conditional which branches on invalid
	  function numbers jumps to the following instruction, becoming a NOP
SeeAlso: INT 2F/AX=9203h"DRIVEMAP"
Index:	installation check;DRIVEMAP
--------T-16FF80BX0000-----------------------
INT 16 U - PC Tools v8+ CPTASK - INSTALLATION CHECK
	AX = FF80h
	BX = 0000h
	CX = 0000h
	DX = 0000h
Return: CX = 5555h if installed
Program: CPTASK is a task switcher by Central Point Software
--------T-16FF80BX0001-----------------------
INT 16 U - PC Tools v8+ CPTASK - GET ???
	AX = FF80h
	BX = 0001h
	???
Return: DX:SI -> task list??? (ten entries of 70h bytes in v9.0)
	BX = ??? (PSP segment of resident code???)
--------T-16FF80BX0002-----------------------
INT 16 U - PC Tools v8+ CPTASK - GET ???
	AX = FF80h
	BX = 0002h
Return: DX:SI -> ???
--------T-16FF80BX0003-----------------------
INT 16 U - PC Tools v8+ CPTASK - GET ??? FLAGS
	AX = FF80h
	BX = 0003h
Return: AX = flags (see #0514)
SeeAlso: AX=FF80h/BX=0004h,AX=FF80h/BX=0006h

Bitfields for CPTASK flags:
Bit(s)	Description	(Table 0514)
 10	???
 13	???
 14	???
 15	???
--------T-16FF80BX0004-----------------------
INT 16 U - PC Tools v8+ CPTASK - SET ???
	AX = FF80h
	BX = 0004h
	CX = new value of ???
Return: ???
Note:	this function also sets bit 14 of the flags word returned by
	  AX=FF80h/BX=0003h
--------T-16FF80BX0005-----------------------
INT 16 U - PC Tools v8+ CPTASK - GET NUMBER OF ACTIVE TASKS???
	AX = FF80h
	BX = 0005h
Return: AX = number of active tasks???
--------T-16FF80BX0006-----------------------
INT 16 U - PC Tools v8+ CPTASK - GET AND CLEAR ??? FLAG
	AX = FF80h
	BX = 0006h
Return: AX = old state (0000h clear, 0001h set)
Note:	the tested flag is bit 13 of the flags returned by AX=FF80h/BX=0003h
--------T-16FF80BX0007-----------------------
INT 16 U - PC Tools v8+ CPTASK - ???
	AX = FF80h
	BX = 0007h
	ES:DI -> ???
	???
Return: ???
--------T-16FF80BX0008-----------------------
INT 16 U - PC Tools v8+ CPTASK - ???
	AX = FF80h
	BX = 0008h
	???
Return: ???
--------T-16FF80BX0009-----------------------
INT 16 U - PC Tools v8+ CPTASK - GET ???
	AX = FF80h
	BX = 0009h
Return: CL = ???
	CH = ??? (01h or 02h)
--------T-16FF80BX000A-----------------------
INT 16 U - PC Tools v9+ CPTASK - SET ???
	AX = FF80h
	BX = 000Ah
	DS:SI -> 128-byte buffer containing ???
--------T-16FF80BX000B-----------------------
INT 16 U - PC Tools v9+ CPTASK - SET ???
	AX = FF80h
	BX = 000Bh
	DX = index of ??? task (1-10)
--------T-16FF80BX000C-----------------------
INT 16 U - PC Tools v9+ CPTASK - SET IDLE??? DELAY
	AX = FF80h
	BX = 000Ch
	CX = new delay time in minutes
--------T-16FF80BX4350-----------------------
INT 16 U - PC Tools v8+ CPTASK - UNINSTALL
	AX = FF80h
	BX = 4350h ('CP')
	CX = 5354h ('ST')
Return: never returns; terminates all tasks and exits to program originally
	  calling CPTASK
--------U-16FF90-----------------------------
INT 16 U - PC Tools v8+ DESKTOP - ???
	AX = FF90h
	???
Return: ???
Note:	available only when popped up
--------U-16FF91-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FF91h
	???
Return: AX = 0000h
Note:	calls AX=FFFDh after ???
SeeAlso: AX=FF92h,AX=FFFDh
--------U-16FF92-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FF92h
	???
Return: AX = 0000h
Note:	like AX=FF91h, but temporarily sets ??? to 3
SeeAlso: AX=FF91h,AX=FFFDh
--------U-16FF93-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - SET ??? FLAG
	AX = FF93h
--------U-16FF94-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - SET ???
	AX = FF94h
	CX = ??? (default 0017h)
--------U-16FF95-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - SET ???
	AX = FF95h
	BX = ???
--------U-16FF96-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FF96h
	CL = ???
Return: AX = ???
--------U-16FF97-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FF97h
	DS:DX -> buffer for ??? (see #0515)
Return: ???

Format of PC Tools DESKTOP buffer:
Offset	Size	Description	(Table 0515)
 00h 48 BYTEs	???
 30h 128 BYTEs	???
--------U-16FF98-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - OPEN \DESK.OVL FILE AND SEEK TO OVERLAY
	AX = FF98h
	DX = byte offset in file of overlay header (see #0516)
Return: BX = file handle for DESK.OVL file
Desc:	open the DESK.OVL file, seek to the specified offset, read in the
	  overlay header, and seek to the offset specified by the header

Format of PC Tools DESKTOP overlay header:
Offset	Size	Description	(Table 0516)
 00h 12 BYTEs	NUL-padded ASCII overlay filename
 0Ch	DWORD	offset within DESK.OVL file of actual overlay
--------U-16FF99-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FF99h
	???
Return: ???
--------U-16FF9A-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - GET NAME OF COLOR SCHEME
	AX = FF9Ah
Return: ES:BX -> name of current color scheme
Note:	available even if not popped up
--------U-16FF9B-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - UNUSED
	AX = FF9Bh
Return: ???
Note:	sounds triple-length beep
--------T-16FF9C-----------------------------
INT 16 U - PC Tools v8+ CPTASK - SET/CLEAR ??? POINTER
	AX = FF9Ch
	BL = function
	    00h set ??? pointer
		DS:SI -> ???
	    01h clear pointer to 0000h:0000h
----------16FF9D-----------------------------
INT 16 U - PC Tools v8+ CPTASK, VSAFE - ???
	AX = FF9Dh
	ES:BX -> ??? word
Return: ???
Note:	if ES is non-zero, the word pointed at by ES:BX determines whether the
	  ??? flag is cleared (word = 0000h) or set (word is nonzero).	The
	  flag is always cleared if ES=0000h.
--------U-16FF9E-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FF9Eh
	DL = ???
	    bit 7: ???
	    bits 6-0: function number??? (00h,01h,other)
	???
Return: ???
--------U-16FFA1-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FFA1h
	???
Return: ???
Note:	same as AX=FFA2h, except ??? set to FFh
SeeAlso: AX=FFA2h
--------U-16FFA2-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FFA2h
	???
Return: ???
Note:	calls AX=FFC7h (remove window) and AX=FFFDh
SeeAlso: AX=FFA1h,AX=FFC7h,AX=FFFDh
--------y-16FFA3BX0000-----------------------
INT 16 U - PC Tools v7-8 DATAMON, v9+ DPROTECT - INSTALLATION CHECK
	AX = FFA3h
	BX = 0000h
	CX = 0000h
Return: AX = segment of resident code
	BX = 5555h
	CX = 5555h
Note:	also supported by DOS 6 UNDELETE which is licensed from PC Tools
SeeAlso: INT 21/AH=3Fh"NB.SYS",INT 21/AX=4101h,INT 2F/AX=6284h
--------y-16FFA3BX0001-----------------------
INT 16 U - PC Tools v7-8 DATAMON, v9+ DPROTECT - GET ???
	AX = FFA3h
	BX = 0001h
	CX = 0001h
Return: AX:BX -> ???
	CX = BX
--------y-16FFA3BX0002-----------------------
INT 16 U - PC Tools v7-8 DATAMON, v9+ DPROTECT - GET ???
	AX = FFA3h
	BX = 0002h
	CX = 0002h
Return: AX = ??? (0 or 1)
	CX = BX = AX
--------y-16FFA3BX0003-----------------------
INT 16 U - PC Tools v7-8 DATAMON, v9+ DPROTECT - GET ???
	AX = FFA3h
	BX = 0003h
	CX = 0003h
Return: AX = ??? (0 or 1)
	CX = BX = AX
--------y-16FFA3BX0004-----------------------
INT 16 U - PC Tools v7+ DATAMON - SET ??? FLAG
	AX = FFA3h
	BX = 0004h
	CX = 0004h
SeeAlso: AX=FFA3h/BX=0005h
--------y-16FFA3BX0005-----------------------
INT 16 U - PC Tools v7+ DATAMON - CLEAR ??? FLAG
	AX = FFA3h
	BX = 0005h
	CX = 0005h
SeeAlso: AX=FFA3h/BX=0004h
--------y-16FFA3BX0006-----------------------
INT 16 U - PC Tools v7+ DATAMON - SET PSP SEGMENT ???
	AX = FFA3h
	BX = 0006h
	CX = 0006h
	DX = current PSP segment as known to DOS??? or 0000h
--------d-16FFA3BXFFA3-----------------------
INT 16 U - PC Tools v9 DSKLIGHT - INSTALLATION CHECK
	AX = FFA3h
	BX = FFA3h
	CX = FFA3h
Return: BX = CX = 5555h if installed
	    AX = resident code segment
Program: DSKLIGHT is a TSR included with PC Tools v9+ which displays a disk-
	  access indicator on the screen; in v7 and v8, this function was
	  provided by DATAMON
Note:	DSKLIGHT chains to the previous handler if BX or CX is not FFA3h
--------U-16FFA4-----------------------------
INT 16 U - PC Tools v7-8 DESKTOP - ???
	AX = FFA4h
Return: ???
Notes:	available even when not popped up
	sets unknown flag if ??? conditions met
SeeAlso: AX=FEA4h
--------c-16FFA5CX1111-----------------------
INT 16 - PC-Cache v6+ - INSTALLATION CHECK
	AX = FFA5h
	CX = 1111h
Return: CH = 00h if installed
	    ES:DI -> internal data (see #0517)
	    CL = cache state
		01h enabled
		02h disabled
SeeAlso: INT 13/AH=27h,INT 13/AH=A0h,INT 21/AH=2Bh/CX=4358h

Format of PC-Cache internal data:
Offset	Size	Description	(Table 0517)
-1Ch 20 BYTEs	cached drive list, one byte per drive A: to T:
		each byte is either blank (20h) or drive letter (41h-54h)
 -8	BYTE	???
 -7	WORD	number of physical transfers (scaled down to 0000h-7FFFh)
 -5	WORD	number of saved transfers (scaled down to 0000h-7FFFh)
 -3   3 BYTEs	???
--------c-16FFA5CXAAAA-----------------------
INT 16 - PC-Cache v6+ - ENABLE DELAYED WRITES
	AX = FFA5h
	CX = AAAAh
Return: AX = ??? (apparently either 0000h or sectors_in_cache - 5)
SeeAlso: AX=FFA5h/CX=CCCCh
--------c-16FFA5CXCCCC-----------------------
INT 16 - PC-Cache v6+ - FLUSH CACHE AND DISABLE DELAYED WRITES
	AX = FFA5h
	CX = CCCCh
Return: AX = ??? (apparently either 0000h or sectors_in_cache - 5)
Note:	delayed writes are automatically disabled on EXECing
	  (see INT 21/AH=4Bh) a program named either WIN.CO? or DV.E??;
	  however, delayed writes are not automatically reenabled upon the
	  program's termination in v6.
SeeAlso: AX=FFA5h/CX=AAAAh,AX=FFA5h/CX=FFFFh
--------c-16FFA5CXDDDD-----------------------
INT 16 - PC-Cache v6+ - FLUSH AND DISABLE CACHE
	AX = FFA5h
	CX = DDDDh
SeeAlso: AX=FFA5h/CX=EEEEh,AX=FFA5h/CX=FFFFh
--------c-16FFA5CXEEEE-----------------------
INT 16 - PC-Cache v6+ - ENABLE CACHE
	AX = FFA5h
	CX = EEEEh
SeeAlso: AX=FFA5h/CX=DDDDh
--------c-16FFA5CXFFFF-----------------------
INT 16 - PC-Cache v6+ - FLUSH CACHE
	AX = FFA5h
	CX = FFFFh
SeeAlso: AX=FFA5h/CX=CCCCh,AX=FFA5h/CX=DDDDh,INT 13/AH=A1h
--------U-16FFA6-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - GET ???
	AX = FFA6h
Return: DS:SI -> ???
Note:	available only when popped up
--------U-16FFA7-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - GET ??? PATH
	AX = FFA7h
Return: DS:SI -> ASCIZ path (directory from which PCTools was run???)
--------U-16FFA8-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - ???
	AX = FFA8h
	DS:SI -> three consecutive ASCIZ strings for ??? (max 256 bytes total)
	???
Return: ???
Notes:	available only when popped up
	strings copied into internal buffer, among other actions
--------U-16FFA9-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - GET VERSION STRING
	AX = FFA9h
Return: DS:SI -> version string
--------U-16FFAA-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - ???
	AX = FFAAh
	???
Return: ???
Note:	available only when popped up
--------U-16FFAB-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - GET EDITOR SETTINGS???
	AX = FFABh
Return: DS:SI -> editor setting strings???
--------U-16FFAC-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - SET ???
	AX = FFACh
	DL = ???
Note:	available only when popped up
--------U-16FFAD-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - SET ???
	AX = FFADh
	DL = ???
--------U-16FFAE-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - GET ???
	AX = FFAEh
Return: AL = ???
--------U-16FFAF-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - SET ???
	AX = FFAFh
	DL = ???
--------U-16FFB0-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - SET ???
	AX = FFB0h
	BL = ???
--------U-16FFB1-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - ???
	AX = FFB1h
	???
Return: ???
--------U-16FFB2-----------------------------
INT 16 U - PC Tools v5.5-8.0 DESKTOP - GET ???
	AX = FFB2h
Return: DS:SI -> ???
--------U-16FFB3-----------------------------
INT 16 U - PC Tools v5.5-8.0 DESKTOP - ???
	AX = FFB3h
	???
Return: ???
Note:	available only when popped up
--------U-16FFB4-----------------------------
INT 16 U - PC Tools v5.5-8.0 DESKTOP - SET ??? FLAG
	AX = FFB4h
Note:	available only when popped up
SeeAlso: AX=FFBBh
--------U-16FFB5-----------------------------
INT 16 U - PC Tools v5.5-8.0 DESKTOP - GET/SET WINDOW PARAMETERS
	AX = FFB5h
	BX = window specifier (000Fh to 0019h) (see #0518)
	DX = 0000h get, nonzero = set
	ES:DI -> window parameter buffer (see #0519)
SeeAlso: AX=FFCBh

(Table 0518)
Values for PC Tools DESKTOP window specifier:
 000Fh	comm/FAX
 0014h	hotkey selection
 0015h	ASCII table
 0016h	system colors menu

Format of PC Tools DESKTOP window parameters:
Offset	Size	Description	(Table 0519)
 00h	BYTE	rows in window, not counting frame
 01h	BYTE	columns in window, not counting frame
 02h	BYTE	row number of top of window
 03h	BYTE	2*column number of left of window
 04h	BYTE	character attribute for ???
 05h	BYTE	character attribute for background/border
 06h	BYTE	character attribute for ???
 07h	DWORD	pointer to ??? on screen
 0Bh  4 BYTEs	???
 0Fh	BYTE	nonzero if window may be resized
Note:	if running in monochrome mode, character attributes at offsets 04h to
	  06h are stored unchanged, but attributes other than 07h, 0Fh, or 70h
	  are changed to 07h on reading
--------U-16FFB6-----------------------------
INT 16 U - PC Tools v5.5-8.0 DESKTOP - GET ???
	AX = FFB6h
Return: AH = ???
	AL = ???
--------U-16FFB7-----------------------------
INT 16 U - PC Tools v5.5-8.0 DESKTOP - GET/SET ???
	AX = FFB7h
	BX = direction
	    0000h copy to buffer
	    else  copy from buffer
	DS:SI -> 70-byte buffer with ???
Return: data copied
Note:	available only when popped up under v6.0+
--------U-16FFB8-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET/SET???
	AX = FFB8h
	BH = subfunction
	    00h get
		Return: BL = old value of ???
			CL = old value of ??? (v6.0+)
			CH = old value of ??? (v6.0+)
	    nonzero set
		BL = new value for ???
		CL = new value for ??? (v6.0+)
		CH = new value for ??? (v6.0+)
		DH = ???
		Return: AL = old value replaced by CL (v6.0+)
			AH = old value replaced by CH (v6.0+)
--------U-16FFB9-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFB9h
	???
Return: AX = ???
	CX = ???
	DS:SI -> ???
	ES:DI -> ???
--------U-16FFBA-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFBAh
	???
Return: AX = ???
Note:	available only when popped up
--------U-16FFBB-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - CLEAR ??? FLAG
	AX = FFBBh
Note:	available only when popped up
SeeAlso: AX=FFB4h
--------U-16FFBC-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - RESTORE ORIGINAL SCREEN???
	AX = FFBCh
--------U-16FFBD-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ??? DATABASE INDEXING MESSAGES
	AX = FFBDh
	???
Return: ???
--------U-16FFBE-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFBEh
	???
Return: ???
Note:	available only when popped up
--------U-16FFBF-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFBFh
	BX = DOS file handle to write on
	???
Return: ???
Note:	available only when popped up
--------U-16FFC0-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFC0h
	???
Return: AX = 0000h if successful
	AX = FFFFh on error
Note:	available only when popped up
--------U-16FFC1-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFC1h
	BL = ???
	ES:DI -> data structure (see #0520)
	???
Return: AX = ???
Note:	available only when popped up
SeeAlso: AX=FFC2h,AX=FFC3h

Format of PC Tools DESKTOP data structure:
Offset	Size	Description	(Table 0520)
 00h	WORD	???
 02h	WORD	???
 04h	WORD	???
 06h	WORD	???
 08h	WORD	???
 0Ah	BYTE	???
 0Bh	BYTE	??? (zero/nonzero)
---v7.1---
 0Ch	WORD	???
 0Eh	BYTE	???
 0Fh	WORD	???
 11h	WORD	???
	???
--------U-16FFC2-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFC2h
	BL = ???
	ES:DI -> data structure (see #0520)
	???
Return: AH = ???
	CX = ???
	DH = ???
	DL = ???
Note:	available only when popped up
SeeAlso: AX=FFC1h,AX=FFC3h
--------U-16FFC3-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFC3h
	BL = ???
	ES:DI -> data structure (see #0520)
	???
Return: AH = ???
	CX = ???
	DH = ???
	DL = ???
Note:	available only when popped up
SeeAlso: AX=FFC1h,AX=FFC2h
--------U-16FFC4-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET ???
	AX = FFC4h
Return: AL = ???
	BX = segment of scratch space???
	CX = segment of stored screen data (section covered by window???)
	DX = segment of window parameters for ???
	ES:BP -> ???
Note:	available only when popped up in versions prior to 6.0
--------U-16FFC5-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - CHECK WHETHER DESKTOP LOADED RESIDENT
	AX = FFC5h
Return: BL = Desktop state
	    00h if nonresident
	    nonzero if loaded resident
Note:	available only when popped up; should call AX=FFEFh first to ensure
	  that DESKTOP is active
SeeAlso: AX=FFEFh,AX=FFF3h
--------U-16FFC6-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SET ???
	AX = FFC6h
	BL = new value for ???
--------U-16FFC7-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - REMOVE WINDOW
	AX = FFC7h
	???
Return: ???
--------U-16FFC8-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET ???
	AX = FFC8h
Return: DS:SI -> ???
Note:	valid only while popped up
--------U-16FFC9-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - COPY DATA TO CLIPBOARD
	AX = FFC9h
	DS:SI -> characters to store in clipboard
	CX = size in bytes
Return: CF set on error
Notes:	available only when popped up
	while copying, bytes of 00h and 0Ah are skipped
--------U-16FFCA-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SET ???
	AX = FFCAh
	DX = ???
Return: AX destroyed
Note:	available only when popped up
--------U-16FFCB-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SELECT WINDOW PARAMETERS???
	AX = FFCBh
	DX = window specifier???
Return: AX destroyed
Note:	available only when popped up
SeeAlso: AX=FFB5h
--------U-16FFCC-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DISPLAY ASCIZ STRING CENTERED IN WINDOW
	AX = FFCCh
	DS:SI -> ASCIZ string
Return: AX = ???
	CX = ???
	ES:DI -> address past last character displayed (v5.1/5.5)
	      -> ??? on menu bar (v6.0)
--------U-16FFCD-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFCDh
	DS:DX -> ???
Return: ???
Note:	available only when popped up
--------U-16FFCE-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SET ??? DELAYS
	AX = FFCEh
	CX = ???
Return: nothing???
--------U-16FFCF-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - CLOSE PRINTER/PRINT FILE
	AX = FFCFh
Note:	available only when popped up
--------U-16FFD0-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - PREPARE TO PRINT???
	AX = FFD0h
	???
Return: ???
Note:	available only when popped up
--------U-16FFD1-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DISPLAY PRINT OPTIONS MENU
	AX = FFD1h
Return: BX = number of copies
	DX = destination
	    00h cancel
	    01h LPT1
	    02h LPT2
	    03h LPT3
	    04h COM1
	    05h COM2
	    06h disk file
Note:	available only when popped up
--------U-16FFD2-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFD2h
	BX = ???
Return: BL = ???
Note:	available only when popped up
--------U-16FFD3-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFD3h
	DS:SI -> 92-byte data record for ???
Return: ???
SeeAlso: AX=FED3h
--------U-16FFD4BH3C-------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - CREATE/OPEN/DELETE FILE
	AX = FFD4h
	BH = 3Ch create file (with no attributes)
	     3Dh open file
	     41h delete file
	BL = access mode
	     00h read only
	     01h write only
	     02h read/write
	DS:SI -> ASCIZ filename
Return: BX = file handle
	    0000h on error
Note:	operation is attempted in (in order) the directory from which the
	  desktop was started/run???, the directory specified with the
	  filename, X:\PCTOOLS\, and X:\
--------U-16FFD5-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFD5h
	???
Return: ???
Note:	available only when popped up
--------U-16FFD6-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFD6h
	BX = ???
	CX = ???
	DX = offset in ???
	???
Return: ???
Note:	available only when popped up
--------U-16FFD7-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFD7h
	???
Return: BL = ???
Note:	available only when popped up
--------U-16FFD8-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SAFE CREATE FILE
	AX = FFD8h
	DS:BX -> ASCIZ filename
Return: BX = file handle
	    0000h on error
Note:	pops up confirmation menu if file already exists
	only available when popped up???
--------U-16FFD9-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET ???
	AX = FFD9h
Return: AX = ???
Note:	available only when popped up
--------U-16FFDA-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET NAME OF LAST FILE OPENED
	AX = FFDAh
	DS:SI -> ??? (v5.1/5.5 only)
Return: DS:SI -> filename
--------U-16FFDB-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SET ???
	AX = FFDBh
	BL = ???
Note:	available only when popped up
--------U-16FFDC-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - UNHOOK
	AX = FFDCh
Return: interrupt vectors 09h, 10h (v6.0+), 16h, 1Ch, and 21h restored to
	  original values
Index:	uninstall;PC Tools DESKTOP
--------U-16FFDDBX0000-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - INSTALLATION CHECK
	AX = FFDDh
	BX = 0000h
Return: CX = 5555h
	DX = 5555h if PCShell installed in resident mode
--------U-16FFDDBX0001-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - REQUEST POP-UP
	AX = FFDDh
	BX = 0001h
Return: CF clear if request successful (PCShell will pop up)
	CF set on error
SeeAlso: AX=FFDDh/BX=0003h
--------U-16FFDDBX0002-----------------------
INT 16 U - PC Tools v5.1-5.5 PCShell API - GET ???
	AX = FFDDh
	BX = 0002h
Return: AL =
	    00h ???
	    01h ???
Note:	PCShell v6.0+ displays the error message "Incorrect PCRUN version",
	  awaits a keystroke, and aborts the current process
--------U-16FFDDBX0003-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - REQUEST POP-UP
	AX = FFDDh
	BX = 0003h
SeeAlso: AX=FFDDh/BX=0001h
--------U-16FFDDBX0004-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - GET ???
	AX = FFDDh
	BX = 0004h
Return: CF clear if successful
	    DS:SI -> ???
--------U-16FFDDBX0005-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - ???
	AX = FFDDh
	BX = 0005h
	???
Return: ???
Note:	resets various variables if certain conditions are met
--------U-16FFDDBX0006-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - ???
	AX = FFDDh
	BX = 0006h
	???
Return: ???
Note:	resets various variables if certain conditions are met
--------U-16FFDDBX0007-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - SET ??? FLAG
	AX = FFDDh
	BX = 0007h
Return: CF clear if successful
SeeAlso: AX=FFDDh/BX=0008h
--------U-16FFDDBX0008-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - CLEAR ??? FLAG
	AX = FFDDh
	BX = 0008h
Return: CF undefined
SeeAlso: AX=FFDDh/BX=0007h
--------U-16FFDDBX0009-----------------------
INT 16 U - PC Tools v6.0+ PCShell API - GET PCRUN PARAMETERS
	AX = FFDDh
	BX = 0009h
Return: CF clear if successful
	    DS:SI -> list of pointers (see #0521)

Format of PC Tools PCShell returned pointer list:
Offset	Size	Description	(Table 0521)
 00h	WORD	offset of WORD containing ???
 02h	WORD	offset of name of program to execute
 04h	WORD	offset of 80-byte buffer for ???
 06h	WORD	offset of buffer for ??? (length in WORD preceding buffer)
 08h	WORD	offset of buffer for ??? (length in WORD preceding buffer)
--------U-16FFDDBX000A-----------------------
INT 16 U - PC Tools v6.0+ PCRUN API - INSTALLATION CHECK
	AX = FFDDh
	BX = 000Ah
Return: CX = 5555h if running
	DX = 5555h
Note:	also sets a flag
--------U-16FFDDBX000B-----------------------
INT 16 U - PC Tools v6.0+ PCRUN API - ???
	AX = FFDDh
	BX = 000Bh
	???
Return: CX = 5555h if PCRUN active
	DX = 5555h
Note:	also clears flag set by AX=FFDDh/BX=000Ah
--------U-16FFDE-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DISPLAY POPUP MENU
	AX = FFDEh
	DS:DX -> menu description (must be on a paragraph boundary)
Return: AX = ???
	    AL seems to be the number of the selected button
Note:	available only when popped up
SeeAlso: AX=FFEEh
--------U-16FFDF-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFDFh
	???
Return: ???
--------U-16FFE0-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFE0h
	CX = ???
	DX = ???
Note:	available only when popped up
--------U-16FFE1-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - BEEP
	AX = FFE1h
--------U-16FFE2-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFE2h
	DX = ???
Return: ???
Note:	available only when popped up
--------U-16FFE3-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - PRINT CHARACTER
	AX = FFE3h
	BL = character to print to currently open printer or print file
Return: CF set on error
Note:	available only when popped up
SeeAlso: INT 17/AH=00h
--------U-16FFE4-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFE4h
	DX = segment of ???
Return: ???
Note:	available only when popped up
--------U-16FFE5-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - POP UP FILE SELECTION MENU
	AX = FFE5h
	DS:SI -> ASCIZ wildcard filespec followed by ASCIZ menu title
	DX = segment of window parameters???
Return: AX = DOS file handle for file
		DS:DX -> filename???
	    FFFFh if function cancelled by user
Note:	available only when popped up
SeeAlso: AX=FFDAh
--------U-16FFE6-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - CHECK FOR AND GET KEYSTROKE
	AX = FFE6h
Return: AX = 0000h if no key available
	     else  BIOS keycode
Notes:	available only when popped up
	invokes INT 28 idle interrupt before checking for key
--------U-16FFE7-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFE7h
	BX = segment of ???
Return: ???
Note:	available only when popped up
--------U-16FFE8-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DISPLAY NUMBER
	AX = FFE8h
	CX = number
	DH = attribute
	DS:SI -> destination for ASCII number
Return: DS:SI buffer filled in with alternating characters and attributes
--------U-16FFE9-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET FILE LIST???
	AX = FFE9h
Return: BX = segment of file/directory list (14 bytes per file, NUL-padded)
Note:	available only when popped up
--------U-16FFEA-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DISPLAY COUNTED STRING
	AX = FFEAh
	DS:SI -> counted string (count byte followed by string)
Return: ???
Note:	available only when popped up
--------U-16FFEB-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFEBh
	???
Return: ???
--------U-16FFEC-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET KEY
	AX = FFECh
	DS:SI -> FAR routine to ???
	BX = ???
	???
Return: AX = keystroke
	    FFFFh if F10 pressed to go to menu
Notes:	available only when popped up
	invokes INT 28 while waiting for keystroke
	F10 is hotkey to Desktop menu
Index:	hotkeys;PC Tools DESKTOP
--------U-16FFED-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET ???
	AX = FFEDh
Return: AX = ???
Note:	available only when popped up
--------U-16FFEE-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DEFINE PULLDOWN MENUS
	AX = FFEEh
	DS:SI -> pulldown menu system description (see #0522)
Return: AX destroyed
Notes:	available only when popped up
	if the accessory does not need any menu items of its own, it should
	  call AX=FFFAh instead
SeeAlso: AX=FFF7h,AX=FFFAh

Format of PC Tools DESKTOP pulldown menu system description:
Offset	Size	Description	(Table 0522)
 00h	WORD	offset of menu bar contents (counted string)
 02h	WORD	number of items on menu bar
 04h 10 BYTEs	scan codes for hotkeying to each of up to ten menu items
 0Eh 10 BYTEs	which character to highlight in each menu item (01h=first)
 18h	WORD	offset of first menu definition (see #0523)
 1Ah	WORD	offset of second menu definition
	...

Format of PC Tools DESKTOP menu definition:
Offset	Size	Description	(Table 0523)
 00h	WORD	offset of menu contents (see #0524)
 02h	WORD	number of entries in menu
 04h	for each entry:
		Offset	Size	Description
		 00h	BYTE	scancode of Alt-key to invoke entry
		 01h	BYTE	character to highlight (01h=first, etc)
		 02h	WORD	offset of FAR routine to handle selection

Format of PC Tools DESKTOP menu contents:
Offset	Size	Description	(Table 0524)
 00h	BYTE	number of lines in menu
 01h	BYTE	width of menu
 02h  N BYTEs	counted strings, one for each line in menu
--------U-16FFEFCX0000-----------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - INSTALLATION CHECK
	AX = FFEFh
	CX = 0000h
Return: CX = ABCDh if PC Tools DESKTOP.EXE installed
	    BX = segment of resident portion
	    AX = ??? (v5.1/5.5 only)
SeeAlso: AX=FEEFh,AX=FFC5h,AX=FFF3h
--------U-16FFF0-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SET ???
	AX = FFF0h
	DX = ???
Return: AX destroyed
Note:	available only when popped up
--------U-16FFF1BX0000-----------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ALTERNATE INSTALLATION CHECK
	AX = FFF1h
	BX = 0000h  leave ??? flag as is
	    nonzero set ??? flag
Return: CX = 5555h if installed
	DX = 5555h
--------U-16FFF2-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DISPLAY HELP LINE
	AX = FFF2h
	DS:SI -> ASCIZ function key label string (each label preceded by '[')
		or help text
Return: AX destroyed
Notes:	available only when popped up
	if the specified string does not start with '[', it is displayed
	  centered on the bottom line, else the function key labels are shown
--------U-16FFF3-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - PREPARE TO UNLOAD RESIDENT DESKTOP
	AX = FFF3h
Note:	releases any EMS being used; restores video mode, page, and cursor
	  shape; and restores interrupt vectors
SeeAlso: AX=FFC5h,AX=FFEFh
Index:	uninstall;PC Tools DESKTOP
--------U-16FFF4-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFF4h
	???
Return: ???
Note:	available only when popped up
SeeAlso: AX=FFF6h
--------U-16FFF5-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET SCREEN ATTRIBUTE ARRAY
	AX = FFF5h
Return: ES:BX -> screen attributes data structure (see #0525)
	AL = ??? (v6.0+)

Format of PC Tools DESKTOP attribute data structure:
Offset	Size	Description	(Table 0525)
 -1	BYTE	attribute for desktop background
 00h	BYTE	attribute for normal characters on desktop menu
 01h	BYTE	attribute for highlighted characters on desktop menu
 02h  5 BYTEs	???
 07h	BYTE	attribute for dialog boxes
 08h 15 BYTEs	???
 17h	BYTE	attribute for message boxes
--------U-16FFF6-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - INVOKE NOTEPAD EDITOR
	AX = FFF6h
	DS = segment of editor buffer structure (see #0526)
	BX = ???
	DX = segment of window parameters structure (see #0519)
Return: ???
Note:	available only when popped up
SeeAlso: AX=FFF4h

Format of PC Tools DESKTOP editor buffer structure:
Offset	Size	Description	(Table 0526)
 00h	WORD	offset of current cursor position in buffer segment
 02h  2 BYTEs	???
 04h	WORD	offset of beginning of file data in buffer segment
 06h 10 BYTEs	???
 10h  N BYTEs	ASCIZ name of file being edited
--------U-16FFF7-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - PROCESS MENU BAR ENTRY???
	AX = FFF7h
	DS:SI -> ???
	???
Return: ???
Notes:	available only when popped up
	performs input processing on the menu bar set up with AX=FFEEh
SeeAlso: AX=FFEEh,AX=FFFBh
--------U-16FFF8-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DRAW EMPTY WINDOW
	AX = FFF8h
	DS:0000h -> window parameters structure (see #0519)
	DS:BX -> DWORD to store address of ??? on screen
Return: ???
--------U-16FFF9-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DEFINE SCREEN REFRESH ROUTINE
	AX = FFF9h
	ES:BX -> FAR routine to redisplay the utility's window
Note:	available only when popped up
--------U-16FFFA-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DEFINE STANDARD PULLDOWN MENUS
	AX = FFFAh
Notes:	available only when popped up
	adds the "Window" option to the "Desktop" option which is the only one
	  available when no accessories are active.  Unlike AX=FFEEh, no
	  additional menu items are added between "Desktop" and "Window"
SeeAlso: AX=FFEEh,AX=FFFBh
--------U-16FFFB-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - PROCESS STANDARD MENU BAR
	AX = FFFBh
Return: ???
Notes:	available only when popped up
	performs input processing on the standard menu bar set up with AX=FFFAh
SeeAlso: AX=FFF7h
--------U-16FFFC-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET HOTKEYS AND KEYBOARD VECTOR
	AX = FFFCh
Return: ES:BX -> hotkey table (see #0527)
	DS:DX = original INT 09 vector

Format of PC Tools DESKTOP hotkey table:
Offset	Size	Description	(Table 0527)
 00h  2 BYTEs	scancode/shift state for desktop hotkey
 02h  2 BYTEs	scancode/shift state for clipboard paste key
 04h  2 BYTEs	scancode/shift state for clipboard copy key
 06h  2 BYTEs	scancode/shift state for screen autodial key
--------U-16FFFD-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - COPY ???
	AX = FFFDh
Return: AX destroyed
Note:	copies 4000 bytes from ??? to ??? under certain circumstances
SeeAlso: AX=FF91h,AX=FF92h
--------M-16FFFE-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SHOW MOUSE CURSOR
	AX = FFFEh
SeeAlso: AX=FFFFh,INT 33/AX=0001h
--------M-16FFFF-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - HIDE MOUSE CURSOR
	AX = FFFFh
SeeAlso: AX=FFFEh,INT 33/AX=0002h
--------P-17----DX0ABC-----------------------
INT 17 - PRINTER - LPTx v5.x INSTALLATION CHECK
	DX = 0ABCh
Return: AX = AAAAh
	DX = BAAAh
	ES = code segment of resident portion
--------P-17----DX0B90-----------------------
INT 17 - PRINTER - LPTx v6.x INSTALLATION CHECK
	DX = 0B90h
Return: DX = ABBBh
	ES = code segment of resident portion
--------P-17----DX0B91-----------------------
INT 17 - PRINTER - LPTx v7.x INSTALLATION CHECK
	DX = 0B91h
Return: DX = ABCBh
	ES = code segment of resident portion
--------P-17----DX0F5F-----------------------
INT 17 - PRINTER - LPTx v4.x INSTALLATION CHECK
	DX = 0F5Fh
Return: AX = AAAAh
	DX = F555h
	ES = code segment of resident portion
--------B-1700-------------------------------
INT 17 - PRINTER - WRITE CHARACTER
	AH = 00h
	AL = character to write
	DX = printer number (00h-02h)
Return: AH = printer status (see #0528)
SeeAlso: AH=02h,AH=84h"AX",AX=6F02h,AH=F1h,INT 16/AX=FFE3h,INT 1A/AH=11h"NEC"
SeeAlso: INT 4B/AH=00h

Bitfields for printer status:
Bit(s)	Description	(Table 0528)
 7	not busy
 6	acknowledge
 5	out of paper
 4	selected
 3	I/O error
 2-1	unused
 0	timeout
Note:	for Tandy 2000, bit 7 indicates printer-busy when set rather than clear
--------B-1701-------------------------------
INT 17 - PRINTER - INITIALIZE PORT
	AH = 01h
	DX = printer number (00h-02h)
Return: AH = printer status (see #0528)
Note:	some printers report that they are ready immediately after
	  initialization when they actually are not; a more reliable result may
	  be obtained by calling AH=02h after a brief delay
SeeAlso: AH=02h,AH=FFh"PC-MOS",INT 1A/AH=10h"NEC",INT 4B/AH=01h
--------B-1702-------------------------------
INT 17 - PRINTER - GET STATUS
	AH = 02h
	DX = printer number (00h-02h)
Return: AH = printer status (see #0528)
Note:	PRINTFIX from MS-DOS 5.0 hooks this function and always returns AH=90h
SeeAlso: AH=01h,AH=F2h,INT 1A/AH=12h"NEC",INT 4B/AH=02h
--------P-1702--DX0000-----------------------
INT 17 - INSET - INSTALLATION CHECK
	AH = 02h
	DX = 0000h
	CX = 07C3h (1987d)
Return: CX = 07C2h (1986d) if installed
Program: INSET is a text/graphics integration program
--------b-170200BX5050-----------------------
INT 17 - Enhanced Parallel Port (EPP) BIOS - INSTALLATION CHECK
	AX = 0200h
	BX = 5050h ('PP')
	CH = 45h   ('E')
	DX = printer port number (00h-02h)
Return: AH = status
	    00h if installed and port is an enhanced parallel port
		CX:AL = installed BIOS type
		    5050h:45h ('PPE') if EPP v3.0+ BIOS installed
		    4550h:50h ('EPP') if EPP v1.0 BIOS installed
		---EPP 1.0, 3.0---
		DX:BX -> far entry point to Advanced BIOS (see #0529)
		---EPP Revision 7---
		DX = EPP I/O base address
		ES:BX -> far entry point to EPP BIOS (see #0529,#0530)
	    03h if installed but specified port not supported
		CF set
Program: The Enhanced Parallel Port BIOS provides support for parallel
	  port peripherals using the enhanced modes of the IEEE 1284.
SeeAlso: AH=E0h,MEM 0040h:0008h,MEM 0040h:00DCh

(Table 0529)
Call EPP BIOS entry point with:
	DL = port number (v1.0)
	DX = (Revision 7) EPP port I/O base address
	AH = function
	    00h Query Configuration
		Return: AH = 00h if successful
			    AL = IRQ number used by port or FFh if no IRQ
			    BH = EPP BIOS revision (major in high nybble,
				  minor in low nybble)
			    BL = I/O capabilities (see #0532)
			    ES:DI -> ASCIZ driver information/version text
			    ---v1.0,v3.0---
			    CX = I/O port base address for parallel port
			    ---Revision 7---
			    CL = EPP chipset code (see #0533)
			    CH = hardware manufacturer's product code
	    01h Set Mode
		AL = mode bits (see #0534)
		Return: AX,BX destroyed
	    02h Get Mode
		Return: AL = mode bits (see also #0534)
				bit 7: EPP port interrupts enabled
			AH = 00h
			CF clear
			BX destroyed
	    03h Interrupt Control
		AL = subfunction
		    00h enable parallel port interrupts
		    01h disable parallel port interrupts
		Return: AH = status (00h,05h,06h) (see also #0531)
	    04h EPP Reset
		Return: AH = 00h if successful
			AL destroyed
	    05h perform Address-Write/Device-Select I/O cycle
		AL = device address
		Return: AH = status
			AL destroyed
	    06h perform Address-Read I/O cycle
		Return: AL = returned address/device data
			AH = status
	    07h write byte
		AL = data byte to write
		Return: AH = status
	    08h output block of data
		DS:SI -> block of data to be sent to parallel port
		CX = number of bytes to output
		Return: AH = status (see #0531)
			CX = number of unsent bytes
	    09h read byte of data
		Return: AH = status (see #0531)
			AL = byte read from parallel port
	    0Ah read block of data
		ES:DI -> buffer for received data
		CX = number of bytes to read from paralle port
		Return: AH = status (see #0531)
			ES:DI buffer filled if successful
			CX = number of bytes not transferred
	    0Bh Address/Byte-Read
		AL = device address
		Return: AH = status (see #0531)
			AL = byte read if successful
	    0Ch Address/Byte-Write
		AL = device address
		DH = data byte (v1.0,v3.0)
		CL = data byte (Revision 7)
		Return: AH = status (see #0531)
	    0Dh Address/Block-Read
		AL = device address
		ES:DI -> buffer for received data
		CX = number of bytes to read
		Return: AH = status (see #0531)
			CX = number of bytes NOT transferred
	    0Eh Address/Block-Write
		AL = device address
		ES:DI -> data to be sent (v1.0,v3.0)
		DS:SI -> data to be send (Revision 7)
		CX = number of bytes to write
		Return: AH = status (see #0531)
			CX = number of bytes NOT transferred
	    0Fh Lock Port
		AL = multiplexor port number
			bits 7-4: daisy chain port number (1-8)
			bits 3-0: mux device port number (1-8)
		Return: AH = status (00h,03h,05h) (see #0531)
	    10h Unlock Port
		AL = multiplexor port number
			bits 7-4: daisy chain port number (1-8)
			bits 3-0: mux device port number (1-8)
		Return: AH = status (00h,03h,05h) (see #0531)
	    11h Device Interrupt
		AL = multiplexor port number
			00h if no multiplexor, else mux device port (01h-08h)
		CH = subfunction
		    00h disable device interrupts
		    01h enable device interrupt
			ES:DI -> interrupt event handler
		Return: AH = status (00h,03h,05h,06h) (see #0531)
		Note:	AMI BIOS v1.00.12.AX1T uses AL to specify en/disabled
			  and ignores multiplexor port number; it also always
			  sets INT 0F to the address specified in ES:DI
	    12h Real-Time Mode
		AL = subfunction
		    00h check whether any real-time devices present
		    01h add (advertise) real-time device
		    02h remove real-time device
		Return: AH = status (00h,05h,06h,07h) (see #0531)
			AL = real-time devices present? (00h no, 01h yes)
		Note:	unlike all other functions, this one does not use DL/DX
Return: AH = status (see #0531)
	CF clear if successful
	CF set on error
	BX destroyed
SeeAlso: #0530

(Table 0530)
Call EPP BIOS (Revision 7) entry point multiplexor functions with:
	DX = EPP port base I/O address
	AH = function
	    40h Query Mux
		Return: AH = status (see #0531)
			AL = currently-selected port
			CH = status flags
				bit 0: channel locked
				bit 1: interrupt pending
			BX destroyed
	    41h Query Device Port
		AL = EPP multiplex device port (1-8)
		Return: AH = status (see #0531)
			CH = status flags (see #0535)
			BX = EPP product/device ID (0000h if undefined)
	    42h Set Product ID
		AL = EPP multiplex device port (1-8)
		CX = EPP product ID
		Return: AH = status (see #0531)
			BX destroyed
	    50h Query Daisy Chain
		AL = EPP multiplexor device port (1-8)
		Return: AH = status (see #0531)
			CH = status flags
				bit 0: channel locked
				bit 1: interrupt pending
			BL = currently-selected device
			BH = EPP daisy chain revision (high nybble = major)
			CL = daisy-chain depth (00h if no daisy chain)
			ES:DI -> ASCIZ driver vendor identification string
	    51h Rescan Daisy Chain (dynamically reassign port numbers)
		AL = EPP multiplexor device port (1-8)
		Return: AH = status (see #0531)
			BX destroyed
Note:	these functions are only valid if a port multiplexor or daisy chain
	  is present
SeeAlso: #0529,INT 2D/AL=DCh

(Table 0531)
Values for EPP BIOS function status:
 00h	successful
 02h	unsupported command/feature
 03h	unsupported parallel port
 05h	unsupported in current mode
 06h	invalid subfunction
 07h	already ???
 20h	(AMI) multiplexor not present
 40h	multiplexor not present
 41h	multiplexor currently locked
 80h	I/O timeout
 FFh	invalid/unsupported function
SeeAlso: #0529,#0530

Bitfields for EPP (v3.0, Revision 7) I/O capabilities:
Bit(s)	Description	(Table 0532)
 0	multiplexor present
 1	PS/2 bi-directional capable
 2	daisy chain present
 3	ECP capable
 4	EPP software emulation supported
 5	EPP capable
 6	fast Centronics supported
 7	standard EPP I/O map
SeeAlso: #0529

(Table 0533)
Values for EPP (Revision 7) chipset code:
 00h	Intel SL
 01h	FarPoint Communications
 02h	SMC
 03h	Chips&Technologies
 04h	Western Digital
 05h	National Semiconductor
SeeAlso: #0529

Bitfields for EPP BIOS mode bits:
Bit(s)	Description	(Table 0534)
 0	set compatibility mode
 1	set bi-directional mode
 2	set EPP mode
---Revision 7---
 3	set ECP mode
 4	set EPP software emulation
 5	set fast Centronics mode
 6-7 reserved (0)
SeeAlso: #0529,#M051

Bitfields for EPP BIOS multiplex status flags:
Bit(s)	Description	(Table 0535)
 0	port is selected
 1	port is locked
 2	interrupts are enabled
 3	interrupt pending
SeeAlso: #0530
--------P-1703-------------------------------
INT 17 U - Emulaser ELTSR - INSTALL INTERRUPT HANDLERS
	AH = 03h
Return: BX = ???
	CX = ???
Program: ELTSR is the resident portion of the Emulaser PostScript emulator by
	  Vertisoft Systems, Inc.
SeeAlso: AH=04h"Emulaser",AH=0Eh,INT 1A/AH=E5h
--------c-1703-------------------------------
INT 17 - PC-MOS/386 v5.01 - PRINT SPOOLER - PRINT STRING
	AH = 03h
	DX = printer port number
	CX = number of characters to print
	DS:SI -> string
Return: AH = printer status (see #0528)
	CX = number of characters actually printed
Desc:	send an entire string of chars to the print spooler with a single call
Program: PC-MOS/386 v5.01 is a multitasking, multiuser MS-DOS 5.0-compatible
	  operating system by The Software Link, Inc.
SeeAlso: AH=00h,AH=01h,AH=02h,AH=FFh"PC-MOS"
--------c-1703--BX5A00-----------------------
INT 17 - DMP Print Spooler v2.03 - INSTALLATION CHECK
	AH = 03h
	BX = 5A00h
Return: AX = 5ACBh
	DI = 0000h
	ES = DMP code segment (also data segment)
Program: DMP is a Printer driver/spooler, by DMP (USA), available on the
	  PCTODAY disk, volume 10, March 1991
--------N-170300-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "socket"
	AX = 0300h
	CX = type of socket from  socket( domain, type, protocol )
	DX = local identifier of socket (0 - 31)
Return: AX = 0000h success
	    CX = segment of 4500 byte transfer buffer
	    DX = offset of 4500 byte transfer buffer
	   = FFFFH failure
	    CX = error code
		ENFILE	    23
Program: DOSISODE is the ISO developers environment which has been ported to
	  DOS and will run with the Waterloo TCP turned into a resident TSR.
	  Currently it allows a maximum of 6 open sockets.
Note:	this function will initialize the interface the first time it is
	  called
SeeAlso: AX=0400h"DOSISODE",AX=0600h"DOSISODE",AX=0800h"DOSISODE"
SeeAlso: AX=0A00h"DOSISODE",AX=0C00h"DOSISODE",AX=0E00h"DOSISODE"
--------P-1704-------------------------------
INT 17 U - Emulaser ELTSR - BEGIN CAPTURING OUTPUT
	AH = 04h
Note:	has no effect unless ELTSR is deactivated (see AX=0503h)
SeeAlso: AH=03h"Emulaser",AX=0503h,INT 1A/AH=E5h
--------N-170400-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "bind"
	AX = 0400h
Note:	this function just returns
SeeAlso: AX=0300h"DOSISODE",AX=0500h"DOSISODE",AX=0C00h"DOSISODE"
--------P-170500-----------------------------
INT 17 U - Emulaser ELTSR - ???
	AX = 0500h
	???
Return: AX = unload status (0001h safe to unload, 0002h not safe)
	BX = ???
	CX = PSP segment of ELTSR
	DX = activity flag (0000h disabled, 0001h capturing, 0002h ???printing)
	SI = ???
	DI = ???
SeeAlso: AH=04h,INT 1A/AH=E5h
--------N-170500-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "connect"
	AX = 0500h
SeeAlso: AX=0400h"DOSISODE",AX=0700h"DOSISODE",AX=0C00h"DOSISODE"
--------P-170501-----------------------------
INT 17 U - Emulaser ELTSR - UNHOOK INTERRUPTS
	AX = 0501h
Return: (see AX=0500h)
Note:	restores interrupt vectors without checking whether they have been
	  hooked by later programs; should only be called if ELTSR reports
	  that it is safe to unload
SeeAlso: AH=04h,AX=0500h,AX=0503h,INT 1A/AH=E5h
Index:	uninstall;Emulaser ELTSR
--------P-170502-----------------------------
INT 17 U - Emulaser ELTSR - SET ???
	AX = 0502h
	BL = Emulaser port (31h = LPT1, 32h = LPT2, 33h = LPT3)
	CL = ???
	DL = ???
Return: (see AX=0500h)
SeeAlso: AH=04h,AX=0500h,INT 1A/AH=E5h
--------P-170503-----------------------------
INT 17 U - Emulaser ELTSR - DEACTIVATE???
	AX = 0503h
Return: (see AX=0500h)
SeeAlso: AH=04h,AX=0500h,AX=0501h,INT 1A/AH=E5h
--------P-1706-------------------------------
INT 17 U - Emulaser ELTSR - ???
	AH = 06h
	???
Return: ???
SeeAlso: AX=0500h,AX=0503h,AH=07h"ELTSR",INT 1A/AH=E5h
--------N-170600-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "listen"
	AX = 0600h
Note:	this function just returns
SeeAlso: AX=0300h"DOSISODE",AX=0700h"DOSISODE",AX=0C00h"DOSISODE"
SeeAlso: AX=0E00h"DOSISODE"
--------P-1707-------------------------------
INT 17 U - Emulaser ELTSR - OPEN CAPTURE FILE
	AH = 07h
	ES:DX -> ASCIZ filename to be opened
Return: ???
Note:	new output will be appended to the specified file
SeeAlso: AH=08h,INT 1A/AH=E5h
--------N-170700-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "accept"
	AX = 0700h
Note:	this function just returns
SeeAlso: AX=0600h"DOSISODE",AX=0800h"DOSISODE",AX=0C00h"DOSISODE"
--------P-1708-------------------------------
INT 17 U - Emulaser ELTSR - CLOSE CAPTURE FILE
	AH = 08h
	???
Return: ???
Desc:	close the file previously opened by function 07h
SeeAlso: AH=07h,INT 1A/AH=E5h
--------N-170800-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "recvfrom"
	AX = 0800h
SeeAlso: AX=0500h"DOSISODE",AX=0900h"DOSISODE",AX=0A00h"DOSISODE"
--------P-1709-------------------------------
INT 17 U - Emulaser ELTSR - PRINT CAPTURE FILE???
	AH = 09h
	BX = ???
	CX = ???
	DX = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AX = status
	    00h successful
	    FFh failed
Program: ELTSR is the resident portion of the Emulaser PostScript emulator by
	  Vertisoft Systems, Inc.
Note:	this function calls through to INT 1A/AX=E401h, and thus requires
	  that either ELSPL or Disk Spool II be installed
SeeAlso: AH=0Ah,INT 1A/AX=E401h,INT 1A/AH=E5h
--------N-170900-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "sendto"
	AX = 0900h
SeeAlso: AX=0700h"DOSISODE",AX=0800h"DOSISODE",AX=0A00h"DOSISODE"
--------P-170A-------------------------------
INT 17 U - Emulaser ELTSR - SET ??? FILENAME
	AH = 0Ah
	ES:BX -> ??? buffer
	CX = length of ??? buffer
Return: ???
Note:	copies the specified name into the buffer passed to ELSPL as the
	  filename by AH=09h
SeeAlso: AH=09h,INT 1A/AH=E5h
--------N-170A00-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "select"
	AX = 0A00h
SeeAlso: AX=0800h"DOSISODE",AX=0B00h"DOSISODE",AX=0E00h"DOSISODE"
--------P-170B-------------------------------
INT 17 U - Emulaser ELTSR - GET ???
	AH = 0Bh
Return: AX:BX -> ???
SeeAlso: AH=0Ah,INT 1A/AH=E5h
--------N-170B00-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "ioctl"
	AX = 0B00h
	DX = local identifier of socket (0 - 31)
Note:	this function sets the socket into non_block mode
SeeAlso: AX=0A00h"DOSISODE",AX=0C00h"DOSISODE",AX=0E00h"DOSISODE"
--------P-170C-------------------------------
INT 17 U - Emulaser ELTSR - SET ??? FLAG
	AH = 0Ch
	???
Return: ???
SeeAlso: AH=0Bh,INT 1A/AH=E5h
--------N-170C00-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "close"
	AX = 0C00h
SeeAlso: AX=0300h"DOSISODE",AX=0500h"DOSISODE",AX=0D00h"DOSISODE"
--------P-170D-------------------------------
INT 17 U - Emulaser ELTSR - GET TRUE ScrlLk STATE
	AH = 0Dh
Return: AX = state (0000h off, 0010h on)
Desc:	determine the actual state of ScrlLk even when Emulaser is controlling
	  the ScrlLk light as its activity indicator
SeeAlso: AH=0Ch,INT 16/AH=02h,INT 1A/AH=E5h
--------N-170D00-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "shutdown" - SHUTDOWN INTERFACE
	AX = 0D00h
Note:	this function is used to shutdown the interface
SeeAlso: AX=0C00h"DOSISODE",AX=0E00h"DOSISODE"
--------P-170E-------------------------------
INT 17 U - Emulaser ELTSR - BACKGROUND PROCESSING
	AH = 0Eh
Program: ELTSR is the resident portion of the Emulaser PostScript emulator by
	  Vertisoft Systems, Inc.
Note:	this function is called by ELTSR on every INT 08 to allow data to be
	  processed in the background, but may also be called by applications
	  to give Emulaser additional CPU time
SeeAlso: AH=0Dh,INT 1A/AH=E5h
--------N-170E00-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - INSTALLATION CHECK
	AX = 0E00h
Return: CX = 1234h if installed
Program: DOSISODE is the ISO developers environment which has been ported to
	  DOS and will run with the Waterloo TCP turned into a resident TSR.
	  Currently it allows a maximum of 6 open sockets.
Note:	this function is used to check if the interface is loaded
SeeAlso: AX=0300h"DOSISODE",AX=0A00h"DOSISODE"
--------P-172000-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - INSTALLATION CHECK
	AX = 2000h
	BL = printer number???
Return: AX = status (see #0536)
	BX = driver version number (BH=major,BL=minor)
	CH = ??? (00h)
	CL = ???
	DX = ??? (0100h)
Note:	also enables the remaining printer driver functions (2001h-2007h)
SeeAlso: AX=2001h,AX=2002h,AX=2003h,AX=2004h,AX=2005h,AX=2006h,AX=2007h

(Table 0536)
Values for PC Paint function status:
 0000h	successful
 0001h	invalid printer???
 0002h	???
 0003h	invalid subfunction
 0005h	driver disabled, must call function 00h first
 0009h	unknown printer error
 000Bh	printer not selected
 000Ch	printer out of paper
 000Eh	error while writing to serial printer
 000Fh	???
 0010h	invalid function number
 0011h	value out of range
--------P-172001-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - SET ??? FLAG
	AX = 2001h
	BL = printer number???
Return: AX = status (see #0536)
--------P-172002-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - GET INFORMATION
	AX = 2002h
	BL = printer number???
	CL = desired information
	    00h printer type
		Return: ES:DI -> ASCIZ printer name
	    01h paper size
		DX = size index
		Return: ES:DI -> ASCIZ paper size description
	    02h ???
		Return: BX = ???
	    03h printer information???
		DX = ???
		ES:BX -> buffer for ??? (min 134 bytes)
Return: AX = status (see #0536)
SeeAlso: AX=2000h,AX=2004h
--------P-172003-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - ???
	AX = 2003h
	ES:BX -> ???
Return: AX = status (see #0536)
SeeAlso: AX=2000h,AX=2004h
--------P-172004-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - GET ???
	AX = 2004h
	BL = printer number???
Return: AX = status (see #0536)
	ES:DI -> ???
SeeAlso: AX=2000h,AX=2003h
--------P-172005-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - ADVANCE PRINTER TO NEXT PAGE
	AX = 2005h
	BL = printer number???
Return: AX = status (see #0536)
Note:	this function also clears the flag set by AX=2001h
SeeAlso: AX=2000h,AX=2001h,AX=2006h
--------P-172006-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - ADVANCE TO NEXT PAGE & SHUT DOWN
	AX = 2006h
	BL = printer number???
Return: AX = status (see #0536)
Note:	this function also clears the flag set by AX=2001h and disables
	  functions other than AX=2000h
SeeAlso: AX=2000h,AX=2001h,AX=2005h
--------P-172007-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - UNIMPLEMENTED
	AX = 2007h
Return: AX unchanged
SeeAlso: AX=2000h
--------N-172400-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - ENABLE/DISABLE API FUNCTIONS
	AX = 2400h
	DL = new state
	    00h disabled
	    01h enabled
Return: DL = 24h if installed
	DH = minor version number
	CX = network address of this machine
	AL = status (see #0537)
SeeAlso: AX=2403h,INT 16/AX=4500h

(Table 0537)
Values for NET.24 function status:
 00h	successful
 01h	timeout
 02h	header error
 03h	data error
 04h	busy
 05h	invalid parameters
--------N-172401-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - RECEIVE BLOCK, NO HANDSHAKE
	AX = 2401h
	BL = timeout in clock ticks
Return: AL = status (see #0537)
	DX:BX -> receive buffer
SeeAlso: AX=2402h,AX=2404h,AX=2408h
--------N-172402-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - TRANSMIT BLOCK, NO HANDSHAKE
	AX = 2402h
	transmit buffer filled (see AX=2403h)
Return: AL = status (see #0537)
SeeAlso: AX=2401h,AX=2403h,AX=2404h,AX=2409h
--------N-172403-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - GET STATUS AND TRANSMISSION BUFFER
	AX = 2403h
Return: AL = status (see #0537)
	CX = number of characters in receive ring buffer
	DX:BX -> transmit buffer
SeeAlso: AX=2400h,AX=2402h
--------N-172404-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - SEND ACK BLOCK
	AX = 2404h
	BX = target address
Return: AL = status (see #0537)
SeeAlso: AX=2402h,AX=2405h
--------N-172405-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - SEND NAK BLOCK
	AX = 2405h
	BX = target address
Return: AL = status (see #0537)
SeeAlso: AX=2402h,AX=2404h
--------N-172406-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - PREPARE CHARACTER-ORIENTED RECEIVE
	AX = 2406h
Return: AL = status (see #0537)
SeeAlso: AX=2407h,AX=240Ah
--------N-172407-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - RECEIVE CHARACTER FROM REMOTE
	AX = 2407h
Return: AL = status (see also #0537)
	    06h end of data
	DL = received character
SeeAlso: AX=2406h
--------N-172408-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - RECEIVE BLOCK, WITH HANDSHAKE
	AX = 2408h
Return: AL = status (see also #0537)
	    06h end of data
	CX = number of bytes in receive buffer
	DX:SI -> receive buffer
SeeAlso: AX=2401h,AX=2405h,AX=2409h
--------N-172409-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - TRANSMIT COMMAND, WITH HANDSHAKE
	AX = 2409h
	BX = target address
	CX = number of data bytes
	DL = command code to send
	DS:SI -> data bytes for command
Return: AL = status (see also #0537)
	    03h no response
	    06h remote currently unable to perform command
SeeAlso: AX=2405h,AX=2408h
--------N-17240A-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - PREPARE CHARACTER-ORIENTED TRANSMIT
	AX = 240Ah
Return: AL = status (see #0537)
SeeAlso: AX=2406h,AX=240Bh,AX=240Ch
--------N-17240B-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - TRANSMIT SINGLE CHARACTER TO REMOTE
	AX = 240Bh
	DL = character to send
Return: AL = status (see also AX=2400h)
	    03h transmission error
	    06h write error
SeeAlso: AX=2407h,AX=240Ah,AX=240Ch
--------N-17240C-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - END CHARACTER-ORIENTED TRANSMIT
	AX = 240Ch
Return: AL = status (see also AX=2400h)
	    03h transmission error
	    06h remote breaks connection
SeeAlso: AX=240Ah,AX=240Bh
--------J-175000-----------------------------
INT 17 - AX (Japanese AT) PRINTER - SET PRINTER COUNTRY CODE
	AX = 5000h
	BX = country code
	    0001h USA (English), 0051h Japan
Return: AL = status
	    00h successful
	    01h bad country code
	    02h other error
SeeAlso: AX=5001h,AH=51h,INT 10/AX=5000h,INT 16/AX=5000h
--------J-175001-----------------------------
INT 17 - AX (Japanese AT) PRINTER - GET PRINTER COUNTRY CODE
	AX = 5001h
Return: AL = status
	    00h successful
		BX = country code
	    02h error
SeeAlso: AX=5000h,AH=51h,INT 10/AX=5001h,INT 16/AX=5001h
--------J-1751-------------------------------
INT 17 - AX (Japanese AT) PRINTER - JIS to Shift-JIS CONVERSION
	AH = 51h
	DX = 2-byte JIS code
Return: DX = shift-JIS value or 0000h on error
Note:	one of AH=51h and AH=52h converts from JIS (Japanese Industry Standard)
	  characters to Shift-JIS characters, and the other performs the
	  opposite conversion
SeeAlso: AX=5000h,AH=52h
--------J-1752-------------------------------
INT 17 - AX (Japanese AT) PRINTER - Shift-JIS to JIS CONVERSION
	AH = 52h
	DX = 2-byte shift-JIS code
Return: DX = JIS code or 0000h on error
Note:	one of AH=51h and AH=52h converts from JIS (Japanese Industry Standard)
	  characters to Shift-JIS characters, and the other performs the
	  opposite conversion
SeeAlso: AH=51h
--------V-1760-------------------------------
INT 17 - FLASHUP.COM - INSTALLATION CHECK
	AH = 60h
Return: AL = 60h
	DX = CS of resident code
Notes:	FLASHUP.COM is part of Flash-Up Windows by The Software Bottling Co.
	FLASHUP also hooks INT 10 and receives commands via INT 10/AH=09h,0Ah
	  consisting of an 80h followed by the actual command
SeeAlso: INT 10/AH=09h,INT 10/AH=0Ah
--------V-1761-------------------------------
INT 17 - SPEEDSCR.COM - INSTALLATION CHECK
	AH = 61h
Return: AL = 61h
	DX = CS of resident code
Note:	SPEEDSCR.COM is by The Software Bottling Co.
--------P-1762-------------------------------
INT 17 U - T2PS v1.0 - UNINSTALL
	AH = 62h
Return: nothing
SeeAlso: AH=63h,AH=64h,INT 05/AX=554Eh
--------P-1763-------------------------------
INT 17 U - T2PS v1.0 - SET PARAMETERS
	AH = 63h
	ES:SI -> settings (see #0538)
Program: T2PS is a shareware ASCII-to-PostScript converter by A.N.D.
	  Technologies
SeeAlso: AH=62h,AH=64h,INT 05/AX=4E57h

Format of T2PS settings:
Offset	Size	Description	(Table 0538)
 00h	WORD	LPT port number (0=LPT1, etc.)
 02h	WORD	page heigh in points
 04h	WORD	page width in points
 06h	WORD	top margin in points
 08h	WORD	bottom margin in points
 0Ah	WORD	left margin in points
 0Ch	WORD	right margin in points
 0Eh	WORD	font size in points
 10h	WORD	tab size
 12h	WORD	timeout in clock ticks
--------P-1764-------------------------------
INT 17 U - T2PS v1.0 - GET PARAMETERS
	AH = 64h
	ES:SI -> buffer for settings (see #0538)
Return: ES:SI buffer filled
SeeAlso: AH=62h,AH=63h,INT 05/AX=5053h
--------b-176F00BX0000-----------------------
INT 17 - HP Vectra - EXTENDED BIOS - "F17_INQUIRE" - INSTALLATION CHECK
	AX = 6F00h
	BX = 0000h
Return: BX = 4850h ("HP") if HP Extended BIOS printer extensions available
SeeAlso: AX=6F02h,INT 14/AX=6F00h,INT 10/AX=6F00h,INT 14/AX=6F00h
SeeAlso: INT 33/AX=6F00h,INT 6F/AH=00h"HP Vectra"
--------b-176F02-----------------------------
INT 17 - HP Vectra - EXTENDED BIOS - "F17_PUT_BUFFER" - PRINT BUFFER
	AX = 6F02h
	CX = size of buffer in bytes
	DX = port number (0-3)
	ES:DI -> buffer containing characters to be printed
Return: AH = printer status (see #0528)
	CX = number of bytes successfully printed
	---on error (AH bit 0 set)---
	    ES:DI -> next byte to be sent
	---if successful---
	    ES:DI unchanged
SeeAlso: AH=00h,AX=6F00h,INT 14/AX=6F02h
--------N-1781-------------------------------
INT 17 - Alloy NTNX, MW386 - CANCEL JOBS FOR CURRENT USER
	AH = 81h
	AL = 00h (NTNX compatibility mode)
	CL = number of jobs to cancel
Return: AL = status (see #0539)
Note:	this function cancels the last CL printouts for the current task
SeeAlso: AH=82h

(Table 0539)
Values for Alloy status:
 00h	success
 01h-7Fh warning
 80h	general failure
 81h	host overloaded (NTNX only)
 82h	module busy (NTNX only)
 83h	host busy (NTNX only)
 84h	re-entry flag set
 85h	invalid request
 86h	invalid printer
 87h	invalid process ID
 89h	access denied
 8Ah	option not available for given port type
 8Bh	option not available for given task type
 91h	printer busy
 C2h	file not found
 C3h	path not found
 C4h	file access failure
--------N-1782-------------------------------
INT 17 - Alloy NTNX, MW386 - CANCEL ALL JOBS FOR CURRENT USER
	AH = 82h
	AL = 00h (NTNX compatibility mode)
Return: AL = status (see #0539)
SeeAlso: AH=81h
--------N-1783-------------------------------
INT 17 - Alloy NTNX, MW386 - SET NUMBER OF COPIES
	AH = 83h
	AL = mode
	    00h NTNX compatibility
		CL = number of copies (max 99, default 1)
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
		CX = number of copies
Return: AL = status (see #0539)
Note:	in NTNX compatibility mode, this function only affects LPT1
--------N-1784-------------------------------
INT 17 - Alloy NTNX, MW386 - GENERATE PRINT BREAK
	AH = 84h
	AL = mode
	    00h NTNX compatibility
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
Note:	closes spool file and tells spooler to queue the print job (LPT1 only
	  under MW386 in NTNX compatibility mode)
--------J-1784-------------------------------
INT 17 - AX (Japanese AT) PRINTER - OUTPUT CHARACTER WITHOUT CONVERSION
	AH = 84h
	AL = character
	DX = printer number
Return: AH = printer status (see #0528)
SeeAlso: AH=00h,AH=85h
--------J-1785-------------------------------
INT 17 - AX (Japanese AT) PRINTER - ENABLE/DISABLE CHARACTER CONVERSION
	AH = 85h
	AL = new state (00h enabled, 01h disabled)
SeeAlso: AH=84h"AX"
--------N-1787-------------------------------
INT 17 - Alloy NTNX - SET INDOS POINTER
	AH = 87h
	AL = 00h
	CX:BX -> buffer for user-written printer drivers
Return: BX,CX destroyed
Note:	must be executed before the printer is enabled
SeeAlso: AH=8Ah
--------N-1788-------------------------------
INT 17 - Alloy NTNX, MW386 - REMOVE PRINTER FROM SPOOLER
	AH = 88h
	AL = mode
	    00h NTNX compatibility
		DX = NTNX printer number (see #0540)
	    01h MW386
		DX = MW386 printer number
Return: AH = status (see #0539)
Note:	removes specified printer from the spooler's list of printers
SeeAlso: AH=89h,AH=8Bh

(Table 0540)
Values for Alloy NTNX printer number:
 00h	host LPT1
 01h	host LPT2
 02h	host LPT3
 03h	host LPT4
 04h	host COM1
 05h	host COM2
 06h	user's logical COM2
 07h	user's terminal AUX port
 08h	user's logical COM1 (MW386 only)
--------N-1789-------------------------------
INT 17 - Alloy NTNX, MW386 - ADD PRINTER TO SPOOLER
	AH = 89h
	AL = mode
	    00h NTNX compatibility
		DX = NTNX printer number (see #0540)
	    01h MW386
		DX = MW386 printer number
Return: AL = status (see #0539)
Note:	the specified printer is added to the spooler's list of available
	  printers
SeeAlso: AH=88h,AH=8Bh
--------N-178A-------------------------------
INT 17 - Alloy NTNX - ACTIVATE USER-WRITTEN PRINTER DRIVER
	AH = 8Ah
	???
SeeAlso: AH=92h
--------N-178B-------------------------------
INT 17 - Alloy MW386 - GET PHYSICAL DEVICE NUMBER FROM NAME
	AH = 8Bh
	DS:DX -> ASCIZ printer name
Return: AL = status (see also AH=81h)
	    00h successful
		DX = physical device number
SeeAlso: AH=89h,AH=8Ch,INT 14/AH=20h"Alloy"
--------N-178C-------------------------------
INT 17 - Alloy MW386 - GET DEVICE NAME FROM PHYSICAL DEVICE NUMBER
	AH = 8Ch
	DX = physical device number
	ES:DI -> 17-byte buffer for ASCIZ device name
Return: AL = status (see also AH=81h)
	    00h successful
		ES:DI buffer filled
SeeAlso: AH=88h,AH=8Bh
--------N-178D-------------------------------
INT 17 - Alloy NTNX,MW386 - RESET SPOOLER
	AH = 8Dh
	AL = 00h
Return: AL = status (see #0539)
Notes:	clears all buffers and resets spooler to boot-up values
	MW386 supports this function for compatibility only; it is a NOP
--------N-178E-------------------------------
INT 17 - Alloy NTNX - GET INT 28 ENTRY POINT
	AH = 8Eh
	AL = 00h
Return: CX:BX -> INT 28 entry point
SeeAlso: AH=8Fh
--------N-178F-------------------------------
INT 17 - Alloy NTNX - GET DOS INTERCEPT ENTRY POINT
	AH = 8Fh
	AL = 00h
Return: CX:BX -> DOS intercept routine
SeeAlso: AH=8Eh
--------N-1790-------------------------------
INT 17 - Alloy NTNX, MW386 - SPOOL FILE BY NAME
	AH = 90h
	AL = mode
	    00h NTNX compatibility
		DL = printer code (FFh=current) (NTNX, MW386 v1.x only)
		DH = number of copies (FFh=current) (NTNX, MW386 v1.x only)
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
	CX:SI -> ASCIZ pathname
Return: AL = status (see #0539)
Note:	in mode 00h, the file is always sent to logical LPT1
SeeAlso: AH=A0h
--------N-1791-------------------------------
INT 17 - Alloy NTNX, MW386 - GET USER NUMBER AND CURRENT PRINTER
	AH = 91h
	AL = mode
	    00h NTNX compatibility
		Return: CX = user number (00h = host)
			DX = currently selected printer number (00h-08h)
	    01h MW386
		Return: CX = user number
			DX = physical dev number of currently selected printer
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
		Return: CX = user number
			DX = physical device number
Return: AL = status (see #0539)
SeeAlso: AH=8Ch
--------N-1792-------------------------------
INT 17 - Alloy NTNX - CHECK PRINTER DRIVER
	AH = 92h
	AL = 00h
	CL = 00h
Return: CL = driver state
	    01h initialized
	    80h not initialized
	AX = status (see #0539)
SeeAlso: AH=8Ah
--------N-1794-------------------------------
INT 17 - Alloy NTNX, MW386 - SELECT PRINTER
	AH = 94h
	AL = mode
	    00h NTNX compatibility
		DX = NTNX printer number (see #0540)
	    01h MW386
		DX = MW386 printer number
	    02h MW386 v2+
		BX = logical printer number
		DX = MW386 printer number
Return: AL = status (see #0539)
Note:	modes 00h and 01h affect only logical LPT1
SeeAlso: AH=8Bh,AH=95h
--------N-1795-------------------------------
INT 17 - Alloy NTNX, MW386 - GET CURRENT PRINTER
	AH = 95h
	AL = mode
	    00h NTNX compatibility
		Return: DX = NTNX printer number (see #0540)
			    (FFFFh if current printer not compatible with NTNX)
	    01h MW386
		Return: DX = MW386 printer number
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
		Return: DX = MW386 printer number (FFFFh = none)
Return: AL = status (see #0539)
Note:	modes 00h and 01h return the printer number of logical LPT1 only
SeeAlso: AH=94h
--------N-1796-------------------------------
INT 17 - Alloy NTNX - SET SERIAL PORT PARAMETERS
	AH = 96h
	AL = 00h
Note:	documentation states that this is a NOP, doing only XOR AX,AX before
	  returning
SeeAlso: INT 14/AH=24h
--------N-1797-------------------------------
INT 17 - Alloy NTNX, MW386 - SET DATA DRIVEN PRINT BREAK
	AH = 97h
	AL = mode
	    00h NTNX compatibility
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
	CH,CL,DH = three character break sequence
	DL = subfunction
	    00h set break string
	    else reset break
Return: AL = status (see #0539)
Notes:	mode 00h affects only logical LPT1
	when the break string is encountered, the spool file will be closed and
	  queued for printing automatically
	the break string is not permanently saved, and will be reset each time
	  MW386 or the user is rebooted
SeeAlso: AH=9Bh
--------N-1798-------------------------------
INT 17 - Alloy NTNX,MW386 - RESTART PRINTER
	AH = 98h
	AL = 00h
	DL = printer number (FFh=current)
Return: AL = status
	    00h successful
	    01h incorrect printer
	    02h task not found
Note:	MW386 supports this function for compatibility only; it is a NOP
--------N-1799-------------------------------
INT 17 - Alloy NTNX, MW386 - GET/SET PRINTER MODE
	AH = 99h
	AL = mode
	    00h NTNX compatibility
		DL = NTNX printer number (see #0540)
			(FFh = task's current logical LPT1)
		DH = mode (see #0541)
	    01h MW386
		DX = MW386 printer number
		CL = mode (as for DH above)
Return: AL = status (see #0539)
	DH = mode (bits 1 and 2 set as above)
	DL = printer owner's user number if not spooled

Bitfields for Alloy printer mode:
 0	get mode if 1, set mode if 0	(Table 0541)
 1	private ("attached")
 2	direct instead of spooled
 3-7	reserved (0)
--------N-179A-------------------------------
INT 17 - Alloy NTNX,MW386 - SET TAB EXPANSION
	AH = 9Ah
	AL = mode
	    00h NTNX compatibility
		DX = NTNX printer number (see #0540)
			(FFFFh = current logical LPT1)
	    01h MW386
		DX = MW386 printer number
	CL = tab length (00h = no expansion, 01h-63h = spaces per tab)
Return: AL = status (see #0539)
Note:	beginning with MW386 v2.0, tab expansion is set on a per-printer basis
	  rather than a per-user basis; NTNX and MW386 v1.x ignore DX
SeeAlso: AH=A4h
--------N-179B-------------------------------
INT 17 - Alloy NTNX,MW386 - SET PRINT BREAK TIMEOUT
	AH = 9Bh
	AL = mode
	    00h NTNX compatibility
		CX = timeout value in clock ticks (1/18 sec) (00h = never)
	    01h MW386
		CX = timeout value in seconds (00h = never)
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
		CX = timeout value in seconds (00h = never)
Return: AL = status (see #0539)
Notes:	modes 00h and 01h affect only the current logical LPT1
	if no data is sent to a printer for the specified amount of time, the
	  spool file will be closed and queued for printing automatically
SeeAlso: AH=97h
--------N-17A0-------------------------------
INT 17 - Alloy MW386 - SPOOL COPY OF FILE
	AH = A0h
	AL = mode
	    00h NTNX compatibility
		DX = ??? (NTNX, MW386 v1.x only)
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
	CX:SI -> ASCIZ pathname
Return: AL = status (see #0539)
Notes:	makes a copy of the specified file in the spooler's directory, allowing
	  the original file to be modified or deleted while the copy is printed
	in mode 00h, the file is printed on logical LPT1
SeeAlso: AH=90h
--------N-17A4-------------------------------
INT 17 - Alloy MW386 - ENABLE/DISABLE FORM FEED
	AH = A4h
	AL = new state
	    00h form feed after end of print job disabled
	    01h form feed enabled
Return: AL = status (see #0539)
Note:	only affects the current logical LPT1
SeeAlso: AH=9Ah,AH=A6h,INT 7F/AH=05h"NTNX (Host)"
--------N-17A6-------------------------------
INT 17 - Alloy MW386 - ENABLE/DISABLE BANNER PAGE
	AH = A6h
	AL = new state
	    00h banner page before print job disabled
	    01h banner page enabled
Return: AL = status (see #0539)
Note:	only affects the current logical LPT1
SeeAlso: AH=A4h
--------N-17A7-------------------------------
INT 17 - Alloy MW386 v2+ - GET/SET SPOOL FLAGS
	AH = A7h
	AL = spool flags (see #0542)
	BX = logical device number
	    00h-03h = LPT1-LPT4
	    04h-07h = COM1-COM4
Return: AL = status (see #0539)
Note:	the documentation does not state which register contains the result of
	  a GET
SeeAlso: AH=A4h,AH=A6h

Bitfields for Alloy spool flags:
Bit(s)	Description	(Table 0542)
 0	banner page enabled (see AH=A6h)
 1	form feed enabled (see AH=A4h)
 2-6	reserved (0)
 7	set flags if 1, get flags if 0
--------N-17A8-------------------------------
INT 17 - Alloy MW386 - DEFINE TEMPORARY FILENAME
	AH = A8h
	CX:SI -> ASCIZ filename without extension (max 8 chars)
Return: AL = status (see #0539)
Note:	allows application to specify banner page filename for spool files
	  collected from the application's printer output
SeeAlso: AH=A9h
--------N-17A9-------------------------------
INT 17 - Alloy MW386 - CHANGE TEMPORARY SPOOL DRIVE
	AH = A9h
	AL = new spool drive (2=C:,3=D:,etc)
Return: AL = status (see #0539)
Note:	does not remove previous spooling directory since jobs may be pending
SeeAlso: AH=A8h
--------N-17AA-------------------------------
INT 17 - Alloy MW386 v2+ - GET REAL-TIME PRINTER STATUS
	AH = AAh
	AL = mode
	    00h NTNX
		DX = NTNX printer number (see #0540)
	    01h MW386
		DX = MW386 printer number
Return: AH = instantaneous printer status
	    00h printer ready
	    01h not ready
	    12h off line
	    13h out of paper
	    14h general device failure
	    15h device timeout
	    16h bad device number
--------N-17AF-------------------------------
INT 17 - Alloy MW386 - CHECK SPOOLER
	AH = AFh
Return: AX = 55AAh if spooler available
--------c-17C0-------------------------------
INT 17 - PC Magazine PCSpool - GET CONTROL BLOCK ADDRESS
	AH = C0h
	DX = printer port (0-3)
Return: ES:BX -> control block (see #0543)
SeeAlso: AH=C1h

Format of PCSpool control block:
Offset	Size	Description	(Table 0543)
 00h	WORD	printer number
 02h	WORD	address of printer status port
 04h	WORD	number of first record in queue
 06h	WORD	number of last record in queue
 08h	DWORD	characters already printed
 0Ch	DWORD	number of characters remaining
 10h	DWORD	pointer to dequeue buffer
 14h	DWORD	previous count of characters printed
 18h	DWORD	number of clock ticks taken to print them
 1Ch	WORD	offset of next character to output
 1Eh	WORD	offset of next character to print
 20h	WORD	pointer to spooling queue record
 22h	BYTE	current spooling status
 23h	BYTE	current printer status:
		00h OK
		01h not ready
		02h paused with message
		03h paused
		04h initializing
		FEh non-existent port
		FFh not spooled
 24h	BYTE	current control record type
 25h	WORD	observed printer speed
 27h	WORD	characters to print per service
 29h	BYTE	01h if disk write needed
 2Ah	BYTE	01h if queued data should be flushed
 2Bh	BYTE	01h to update cps status
--------c-17C1--------------------------------
INT 17 - PC Magazine PCSpool - BUILD PAUSE CONTROL RECORD
	AH = C1h
	DX = printer port (0-3)
	DS:SI -> ASCIZ string to save for display
Note:	flushes pending writes
SeeAlso: AH=C0h,AH=C2h
--------c-17C2-------------------------------
INT 17 - PC Magazine PCSpool - FLUSH PENDING WRITES
	AH = C2h
	DX = printer port (0-3)
SeeAlso: AH=C3h
--------c-17C3-------------------------------
INT 17 - PC Magazine PCSpool - CANCEL PRINTER QUEUE (FLUSH ALL QUEUED OUTPUT)
	AH = C3h
	DX = printer port (0-3)
SeeAlso: AH=C2h,AH=C7h
--------c-17C4-------------------------------
INT 17 - PC Magazine PCSpool - QUERY SPOOLER ACTIVE
	AH = C4h
Return: DI = B0BFh
	SI = segment
--------c-17C5-------------------------------
INT 17 - PC Magazine PCSpool - JOB SKIP PRINTER QUEUE
	AH = C5h
	DX = printer port (0-3)
Note:	cancels up to the pause record
--------c-17C6-------------------------------
INT 17 - PC Magazine PCSpool - CHECK PRINTER QUEUE STATUS
	AH = C6h
	DX = printer port (0-3)
Return: AX = queue status
	   0000h printer not active or at pause
	   0001h printer busy
--------c-17C7-------------------------------
INT 17 - PC Magazine PCSpool - CLOSE QUEUE
	AH = C7h
	DX = printer port (0-3)
SeeAlso: AH=C3h
--------P-17CD00-----------------------------
INT 17 - INSET - EXECUTE COMMAND STRING
	AX = CD00h
	DS:DX -> ASCIZ command string (max 80 bytes)
Return: CX = 07C2h (1986d)
Note:	user interface menus pop up after last command, unless that command
	exits INSET
--------P-17CD01-----------------------------
INT 17 - INSET - GET IMAGE SIZE
	AX = CD01h
	DS:DX -> ASCIZ name of image file
Return: AX = height in 1/720th inch
	BX = width in 1/720th inch
	CX = 07C2h (1986d)
--------P-17CD02-----------------------------
INT 17 - INSET - INITIALIZE
	AX = CD02h
Return: CX = 07C2h (1986d)
Note:	all open files are closed and the printer is reset
SeeAlso: AX=CD04h
--------P-17CD03-----------------------------
INT 17 - INSET - EXECUTE INSET MENU WITHIN OVERRIDE MODE
	AX = CD03h
Return: CX = 07C2h (1986d)
--------P-17CD04-----------------------------
INT 17 - INSET - INITIALIZE LINKED MODE
	AX = CD04h
	ES:SI -> FAR routine for linked mode (see #0544)
Return: CX = 07C2h
SeeAlso: AX=CD02h,AX=CD08h

(Table 0544)
Values INSET linked-mode routine is called with:
	AL = function
	    00h send character to printer
		BL = character to send
	    01h send string to printer
		CX = number of bytes to send
		DS:DX -> buffer containing data
	    02h move print head to horizontal starting position of image
Return: AX = status
	    0000h success
	    0001h failure
--------P-17CD05-----------------------------
INT 17 - INSET - START MERGING IMAGE INTO TEXT
	AX = CD05h
	DS:DX -> ASCIZ name of PIX file
	CX = left margin of text in 1/720th inch
Return: AH = printer type
	    00h page-oriented (multiple images may be placed side-by-side)
	    01h line-oriented (use AX=CD06h for vertical paper movement)
	CX = 07C2h (1986d)
SeeAlso: AX=CD07h
--------P-17CD06-----------------------------
INT 17 - INSET - GRAPHICS LINE FEED
	AX = CD06h
Return: AH = completion status
	    00h image complete
	    01h image incomplete
	CX = 07C2h (1986d)
SeeAlso: AX=CD09h
--------P-17CD07-----------------------------
INT 17 - INSET - FLUSH GRAPHICS FROM MERGE BUFFER
	AX = CD07h
Return: CX = 07C2h
SeeAlso: AX=CD05h
--------P-17CD08-----------------------------
INT 17 - INSET - CANCEL LINK MODE
	AX = CD08h
Return: CX = 07C2h
SeeAlso: AX=CD04h
--------P-17CD09-----------------------------
INT 17 - INSET - ALTER TEXT LINE SPACING
	AX = CD09h
	CX = line spacing in 1/720th inch
Return: CX = 07C2h
Note:	not yet implemented, line spacing is currently fixed at 1/6 inch
SeeAlso: AX=CD06h
--------P-17CD0A-----------------------------
INT 17 - INSET - GET SETUP
	AX = CD0Ah
	DS:DX -> buffer for IN.SET data
Return: CX = 07C2h
--------P-17CD0B-----------------------------
INT 17 - INSET - START GETTING SCALED IMAGE
	AX = CD0Bh
	DS:SI -> ASCIZ pathname of .PIX file
	BX = number of bitplanes
	CX = number of rows in output bitmap
	DX = number of columns in output bitmap
Return: AX = status
	    0000h OK
	    FFFFh error
Note:	image is returned in strips by repeated calls to AX=CD0Ch
--------P-17CD0C-----------------------------
INT 17 - INSET - GET NEXT IMAGE STRIP
	AX = CD0Ch
Return: AX = status
	    0000h OK but not complete
	    0001h OK and image complete
	    FFFFh error
	DS:SI -> buffer (max 4K) for bit map strip
	CX = start row
	DX = number of rows
	BX = offset in bytes between bit planes
Note:	buffer may be overwritten by subsequent calls
SeeAlso: AX=CD0Bh
--------P-17E0-------------------------------
INT 17 - EPP BIOS - INSTALLATION CHECK
	AH = E0h
Return: ??? (AH <> E0h if installed ???)
SeeAlso: AX=0200h"EPP",AH=E1h,AH=E2h
--------P-17E1-------------------------------
INT 17 - EPP BIOS - DISABLE EPP
	AH = E1h
	???
Return: ???
SeeAlso: AX=0200h"EPP",AH=E0h,AH=E2h
--------P-17E2-------------------------------
INT 17 - EPP BIOS - ENABLE EPP
	AH = E2h
	???
Return: ???
SeeAlso: AX=0200h"EPP",AH=E0h,AH=E1h
--------P-17F0-------------------------------
INT 17 - NorthNet Jetstream API - INSTALLATION CHECK
	AH = F0h
	DX = printer port (0-3)
Return: AX = 0001h Jetstream present
	     else  non-Jetstream port
Note:	NorthNet Jetstream is a high-performance DMA-driven parallel card able
	  to drive printers at up to 80000 characters per second
--------P-17F1-------------------------------
INT 17 - NorthNet Jetstream API - PRINT DATA BUFFER
	AH = F1h
	CX = data buffer length
	DX = printer port (0-3)
	DS:SI -> data buffer
Return: AX = status
	    0000h printer not ready (see also AH=02h)
	    other printing started
SeeAlso: AH=00h,AH=F2h,AH=F3h,AH=F5h
--------P-17F2-------------------------------
INT 17 - NorthNet Jetstream API - GET PRINT PROGRESS STATUS
	AH = F2h
	DX = printer port (0-3)
Return: AX = status
	    0000h prior print request finished
	    other number of characters left to print
SeeAlso: AH=02h,AH=F1h,AH=F3h
--------P-17F3-------------------------------
INT 17 - NorthNet Jetstream API - ABORT PRINT OPERATION
	AH = F3h
	DX = printer port (0-3)
Return: AX = number of unprinted characters due to abort
SeeAlso: AH=F1h,AH=F4h
--------P-17F4-------------------------------
INT 17 - NorthNet Jetstream API - SET COMPLETION (POST) ADDRESS
	AH = F4h
	DX = printer port (0-3)
	DS:DS -> FAR post address (called with interrupts on)
SeeAlso: AH=F1h,AH=F3h
--------P-17F5-------------------------------
INT 17 - NorthNet Jetstream API - PRINT DATA BUFFER FROM EXTENDED MEMORY
	AH = F5h
	CX = data buffer length
	DX = printer port (0-3)
	DS:SI -> data buffer (32-bit physical address)
Return: AX = status
	    0000h printer not ready (see also AH=02h)
	    other printing started
SeeAlso: AH=F1h
--------c-17FF--BX0000-----------------------
INT 17 U - PC-MOS/386 v5.01 - PRINT SPOOLER - CLOSE SPOOL FILE
	AH = FFh
	BX = 0000h
	CX = 0000h
	DX = printer port number
Return: AH = printer status (see #0528 at AH=00h)
Program: PC-MOS/386 v5.01 is a multitasking, multiuser MS-DOS 5.0-compatible
	  operating system by The Software Link, Inc.
Desc:	close the spool file immediately instead of waiting for the close time
	  to elapse
SeeAlso: AH=01h,AH=03h"PC-MOS"
--------B-18---------------------------------
INT 18 - DISKLESS BOOT HOOK (START CASSETTE BASIC)
Desc:	called when there is no bootable disk available to the system
Notes:	only PCs produced by IBM contain BASIC in ROM, so the action is
	  unpredictable on compatibles; this interrupt often reboots the
	  system, and often has no effect at all
	network cards with their own BIOS can hook this interrupt to allow
	  a diskless boot off the network (even when a hard disk is present
	  if none of the partitions is marked as the boot partition)
SeeAlso: INT 2F/AX=4A06h,INT 86"NetBIOS"
--------J-1800-------------------------------
INT 18 - NEC PC-9800 series - KEYBOARD - GET KEYSTROKE
	AH = 00h
Return: AX = keystroke
SeeAlso: AH=01h,AH=02h,INT 16/AH=00h
--------J-1801-------------------------------
INT 18 - NEC PC-9800 series - KEYBOARD - CHECK FOR KEYSTROKE
	AH = 01h
Return: BH = status
	    00h no keystrokes available
	    01h keystroke available
		AX = keystroke
SeeAlso: AH=00h,AH=02h,INT 16/AH=01h
--------J-1802-------------------------------
INT 18 - NEC PC-9800 series - KEYBOARD - GET SHIFT STATUS
	AH = 02h
Return: AL = shift flags
SeeAlso: AH=00h,AH=02h,AH=03h,AH=04h,INT 16/AH=02h
--------J-1803-------------------------------
INT 18 - NEC PC-9800 series - KEYBOARD - INITIALIZE
	AH = 03h
	???
Return: ???
SeeAlso: AH=00h,AH=04h
--------J-1804-------------------------------
INT 18 - NEC PC-9800 series - KEYBOARD - KEY PRESSED
	AH = 04h
	???
Return: ???
Note:	details are not available at this time
SeeAlso: AH=00h,AH=02h,INT 16/AH=00h,INT 16/AH=01h,INT 16/AH=02h
--------J-18---------------------------------
INT 18 - NEC PC-9800 series - VIDEO
	AH = function
	    0Ah set video mode
	    0Bh get video mode
	    0Ch start text screen display
	    0Dh end text screen display
	    0Eh set single display area
	    0Fh set multiple display area
	    10h set cursor shape
	    11h display cursor
	    12h terminate cursor
	    13h set cursor position
	    14h read font patter
	    16h initialize text video RAM
	    1Ah define user character
	    others
	???
Return: ???
Notes:	details are not available at this time
	text video RAM is located at segments A000h (characters) and A200h
	  (attributes), graphics video RAM at segment C000h

Bitfields for NEC PC-9800 series video attributes:
Bit(s)	Description	(Table 0545)
 0	disable drawing character
 1	blinking
 2	reverse video
 3	underline
 4	vertical line
 7-5	color
	(0=black, 1=blue, 2=red, 3=purple, 4=green, 5=cyan, 6=yellow, 7=white)
--------J-180E-------------------------------
INT 18 - NEC PC-9800 series - SET SINGLE DISPLAY AREA
	AH = 0Eh
	DX = offset of first byte to display???
Return: ???
SeeAlso: AH=1Bh,MEM 0050h:0001h
--------J-181B-------------------------------
INT 18 - NEC PC-9800 series - SET DISPLAY MODE
	AH = 1Bh
	AL = ??? (00h for text mode)
Return: ???
--------r-185350BX4849-----------------------
INT 18 - SPHINX C-- - WB.COM - API
	AX = 5350h ('SP')
	BX = 4849h ('HI')
	CX = 4E58h ('NX')
	DH = function
	    01h set ???
		DL = ???
	    02h get ???
		Return: DL = ???
	    03h get ???
		Return: ES:DI -> ??? data buffer
	    06h ???
Return: AX = 7370h ('sp') if installed
	BX = 6869h ('hi') if installed
	CX = 6E78h ('nx') if installed
Program: SPHINX C-- is a shareware compiler by Peter Cellik for a language
	  which is a cross between C and assembler; WB.COM is the driver which
	  launches the WorkBench
--------s-186900-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - GET STATUS
	AX = 6900h
Return: AX = amount of DRAM on card or 0000h if GUS not available
Program: YEA_GUS is a driver for the Graphics Ultra Sound which hooks INT 18h
	  and then shells out the the program requiring its services
SeeAlso: AX=6901h,AX=690Ah,AX=690Bh
--------s-186901-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - RESET
	AX = 6901h
	BX = number of active voices (14-32)
Return: nothing
SeeAlso: AX=6900h
--------s-186902-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - SET VOLUME FOR SPECIFIC VOICE
	AX = 6902h
	BX = voice number (00h-1Fh)
	CX = linear volume (0000h-01FFh)
Return: nothing
SeeAlso: AX=6900h,AX=6903h,AX=6904h,AX=6909h,AX=690Ah
--------s-186903-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - SET FREQUENCY FOR VOICE
	AX = 6903h
	BX = voice number (00h-1Fh)
	CX = frequency in Hz (0-44100)
Return: nothing
SeeAlso: AX=6902h,AX=6904h
--------s-186904-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - SET LEFT/RIGHT BALANCE
	AX = 6904h
	BX = voice number (00h-1Fh)
	CX = balance (0 = left, 7 = even, 15 = right)
Return: nothing
SeeAlso: AX=6902h,AX=6903h
--------s-186905-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - PLAY MUSIC
	AX = 6905h
	BL = voice number
	BH = sample type (0 = 8-bit, 1 = 16-bit)
	CL = looping type (0 = none, 1 = forward, 2 = back and forth)
	CH:DI = 20-bit starting address for voice data
	DL:SI = 20-bit address for loop start
	DH:BP = 20-bit address for loop end
SeeAlso: AX=6903h,AX=6906h,AX=690Bh
--------s-186906-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - LOAD SOUND DATA
	AX = 6906h
	BL = data format (1 = twos-complement, 0 = not)
	BH = sample type (0 = 8-bit, 1 = 16-bit)
	CX = number of bytes to send
	ES:SI -> buffer containing data
	DL:DI = 20-bit address of GUS DRAM at which to load sound data
SeeAlso: AX=6900h,AX=6905h,AX=690Ch
--------s-186907-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - STOP VOICE
	AX = 6907h
	BX = voice number (00h-1Fh)
Return: nothing
SeeAlso: AX=6908h,AX=690Dh
--------s-186908-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - SET VOICE END
	AX = 6908h
	BX = voice number (00h-1Fh)
	CL:DX = 20-bit ending address
Return: nothing
SeeAlso: AX=690Bh
--------s-186909-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - RAMP VOLUME
	AX = 6909h
	BL = voice number (00h-1Fh)
	BH = looping type (0 = none, 1 = forward, 2 = back and forth)
	CX = starting volume
	DX = ending volume
	DI:SI = time
Return: nothing
SeeAlso: AX=6902h,AX=690Ah
--------s-18690A-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - GET VOLUME
	AX = 690Ah
	BX = voice number (00h-1Fh)
Return: AX = current non-linear volume for voice
SeeAlso: AX=6902h,AX=6909h
--------s-18690B-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - GET POSITION
	AX = 690Bh
	BX = voice number
Return: BX:AX = 20-bit address at which voice is playing
SeeAlso: AX=6900h,AX=6905h,AX=6908h
--------s-18690C-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - SAVE SOUND DATA
	AX = 690Ch
	BL = data format (1 = twos-complement, 0 = not)
	BH = sample type (0 = 8-bit, 1 = 16-bit)
	CX = number of bytes to get
	ES:SI -> buffer for retrieved data
	DL:DI = 20-bit address in GUS DRAM from which to read voice data
Return: nothing
SeeAlso: AX=6906h
--------s-18690D-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - RESTART VOICE
	AX = 690Dh
	BX = voice
	CX = sample type (0 = 8-bit, 1 = 16-bit)
	DX = looping type (0 = none, 1 = forward, 2 = back and forth)
Return: CX = balance value
SeeAlso: AX=6907h,AX=6908h
--------s-188000-----------------------------
INT 18 - Gravis Ultra Sound EURO_MOD.EXE - INITIALIZE
	AX = 8000h
Program: EURO_MOD is a .MOD file player for the Gravis Ultra Sound which hooks
	  INT 18h and then shells out to the program requiring its services
SeeAlso: AX=8001h,AX=8004h
--------s-188001-----------------------------
INT 18 - Gravis Ultra Sound EURO_MOD.EXE - LOAD .MOD FILE
	AX = 8001h
	BX:CX -> ASCIZ filename
SeeAlso: AX=8000h,AX=8002h
--------s-188002-----------------------------
INT 18 - Gravis Ultra Sound EURO_MOD.EXE - PLAY .MOD FILE
	AX = 8002h
SeeAlso: AX=8002h,AX=8003h
--------s-188003-----------------------------
INT 18 - Gravis Ultra Sound EURO_MOD.EXE - STOP PLAYING
	AX = 8003h
--------s-188004-----------------------------
INT 18 - Gravis Ultra Sound EURO_MOD.EXE - SHUTDOWN
	AX = 8004h
SeeAlso: AX=8000h,AX=8003h
--------B-19---------------------------------
INT 19 - SYSTEM - BOOTSTRAP LOADER
Desc:	This interrupt reboots the system without clearing memory or restoring
	  interrupt vectors.  Because interrupt vectors are preserved, this
	  interrupt usually causes a system hang if any TSRs have hooked
	  vectors from 00h through 1Ch, particularly INT 08.
Notes:	Usually, the BIOS will try to read sector 1, head 0, track 0 from drive
	  A: to 0000h:7C00h.  If this fails, and a hard disk is installed, the
	  BIOS will read sector 1, head 0, track 0 of the first hard disk.
	  This sector should contain a master bootstrap loader and a partition
	  table (see #0547).  After loading the master boot sector at
	  0000h:7C00h, the master bootstrap loader is given control.  It will
	  scan the partition table for an active partition, and will then load
	  the operating system's bootstrap loader (contained in the first
	  sector of the active partition) and give it control.
	true IBM PCs and most clones issue an INT 18 if neither floppy nor hard
	  disk have a valid boot sector
	to accomplish a warm boot equivalent to Ctrl-Alt-Del, store 1234h in
	  0040h:0072h and jump to FFFFh:0000h.	For a cold boot equivalent to
	  a reset, store 0000h at 0040h:0072h before jumping.
	VDISK.SYS hooks this interrupt to allow applications to find out how
	  much extended memory has been used by VDISKs (see #0546).  DOS 3.3+
	  PRINT hooks INT 19 but does not set up a correct VDISK header block
	  at the beginning of its INT 19 handler segment, thus causing some
	  programs to overwrite extended memory which is already in use.
	the default handler is at F000h:E6F2h for 100% compatible BIOSes
	MS-DOS 3.2+ hangs on booting (even from floppy) if the hard disk
	  contains extended partitions which point at each other in a loop,
	  since it will never find the end of the linked list of extended
	  partitions
	under Windows Real and Enhanced modes, calling INT 19 will hang the
	  system in the same was as under bare DOS; under Windows Standard
	  mode, INT 19 will successfully perform a cold reboot as it appears
	  to have been redirected to a MOV AL,0FEh/OUT 64h,AL sequence
BUG:	when loading the remainder of the DOS system files fails, various
	  versions of IBMBIO.COM/IO.SYS incorrectly restore INT 1E before
	  calling INT 19, assuming that the boot sector had stored the
	  contents of INT 1E at DS:SI instead of on the stack as it actually
	  does
SeeAlso: INT 14/AH=17h,INT 18"BOOT HOOK",INT 49"Tandy 2000",INT 5B"PC Cluster"

Format of VDISK header block (at beginning of INT 19 handler's segment):
Offset	Size	Description	(Table 0546)
 00h 18 BYTEs	n/a (for VDISK.SYS, the device driver header)
 12h 11 BYTEs	signature string "VDISK	 Vn.m" for VDISK.SYS version n.m
 1Dh 15 BYTEs	n/a
 2Ch  3 BYTEs	linear address of first byte of available extended memory

Format of hard disk master boot sector:
Offset	Size	Description	(Table 0547)
 00h 446 BYTEs	Master bootstrap loader code
1BEh 16 BYTEs	partition record for partition 1 (see #0548)
1CEh 16 BYTEs	partition record for partition 2
1DEh 16 BYTEs	partition record for partition 3
1EEh 16 BYTEs	partition record for partition 4
1FEh	WORD	signature, AA55h indicates valid boot block

Format of partition record:
Offset	Size	Description	(Table 0548)
 00h	BYTE	boot indicator (80h = active partition)
 01h	BYTE	partition start head
 02h	BYTE	partition start sector (bits 0-5)
 03h	BYTE	partition start track (bits 8,9 in bits 6,7 of sector)
 04h	BYTE	operating system indicator (see #0549)
 05h	BYTE	partition end head
 06h	BYTE	partition end sector (bits 0-5)
 07h	BYTE	partition end track (bits 8,9 in bits 6,7 of sector)
 08h	DWORD	sectors preceding partition
 0Ch	DWORD	length of partition in sectors
SeeAlso: #0547

(Table 0549)
Values for operating system indicator:
 00h	empty
 01h	DOS 12-bit FAT
 02h	XENIX root file system
 03h	XENIX /usr file system (obsolete)
 04h	DOS 16-bit FAT (up to 32M)
 05h	DOS 3.3+ extended partition
 06h	DOS 3.31+ Large File System (16-bit FAT, over 32M)
 07h	QNX
 07h	OS/2 HPFS
 07h	Windows NT NTFS
 07h	Advanced Unix
 08h	OS/2 (v1.0-1.3 only)
 08h	AIX bootable partition, SplitDrive
 08h	Commodore DOS
 08h	DELL partition spanning multiple drives
 09h	AIX data partition
 09h	Coherent filesystem
 0Ah	OS/2 Boot Manager
 0Ah	OPUS
 0Ah	Coherent swap partition
 0Bh	Windows 95 with 32-bit FAT
 0Ch	Windows 95 with 32-bit FAT (using LBA-mode INT 13 extensions)
 0Eh	logical-block-addressable VFAT (same as 06h but using LBA-mode INT 13)
 0Fh	logical-block-addressable VFAT (same as 05h but using LBA-mode INT 13)
 10h	OPUS
 11h	OS/2 Boot Manager hidden 12-bit FAT partition
 12h	Compaq Diagnostics partition
 14h	(resulted from using Novell DOS 7.0 FDISK to delete Linux Native part)
 14h	OS/2 Boot Manager hidden sub-32M 16-bit FAT partition
 16h	OS/2 Boot Manager hidden over-32M 16-bit FAT partition
 17h	OS/2 Boot Manager hidden HPFS partition
 18h	AST special Windows swap file
 21h	officially listed as reserved
 23h	officially listed as reserved
 24h	NEC MS-DOS 3.x
 26h	officially listed as reserved
 31h	officially listed as reserved
 33h	officially listed as reserved
 34h	officially listed as reserved
 36h	officially listed as reserved
 38h	Theos
 3Ch	PowerQuest PartitionMagic recovery partition
 40h	VENIX 80286
 41h	Personal RISC Boot
 42h	SFS (Secure File System) by Peter Gutmann
 50h	OnTrack Disk Manager, read-only partition
 51h	OnTrack Disk Manager, read/write partition
 51h	NOVEL
 52h	CP/M
 52h	Microport System V/386
 53h	OnTrack Disk Manager, write-only partition???
 54h	OnTrack Disk Manager (DDO)
 56h	GoldenBow VFeature
 61h	SpeedStor
 63h	Unix SysV/386, 386/ix
 63h	Mach, MtXinu BSD 4.3 on Mach
 63h	GNU HURD
 64h	Novell NetWare 286
 65h	Novell NetWare (3.11)
 67h	Novell
 68h	Novell
 69h	Novell
 70h	DiskSecure Multi-Boot
 71h	officially listed as reserved
 73h	officially listed as reserved
 74h	officially listed as reserved
 75h	PC/IX
 76h	officially listed as reserved
 80h	Minix v1.1 - 1.4a
 81h	Minix v1.4b+
 81h	Linux
 81h	Mitac Advanced Disk Manager
 82h	Linux Swap partition
 82h	Prime
 83h	Linux native file system (ext2fs/xiafs)
 84h	OS/2-renumbered type 04h partition (related to hiding DOS C: drive)
 86h	officially listed as reserved
 87h	HPFS Fault-Tolerant mirrored partition
 93h	Amoeba file system
 94h	Amoeba bad block table
 A1h	officially listed as reserved
 A3h	officially listed as reserved
 A4h	officially listed as reserved
 A5h	FreeBSD, BSD/386
 A6h	officially listed as reserved
 B1h	officially listed as reserved
 B3h	officially listed as reserved
 B4h	officially listed as reserved
 B6h	officially listed as reserved
 B7h	BSDI file system (secondarily swap)
 B8h	BSDI swap partition (secondarily file system)
 C1h	DR DOS 6.0 LOGIN.EXE-secured 12-bit FAT partition
 C4h	DR DOS 6.0 LOGIN.EXE-secured 16-bit FAT partition
 C6h	DR DOS 6.0 LOGIN.EXE-secured Huge partition
 C7h	Syrinx Boot
 D8h	CP/M-86
 DBh	CP/M, Concurrent CP/M, Concurrent DOS
 DBh	CTOS (Convergent Technologies OS)
 E1h	SpeedStor 12-bit FAT extended partition
 E3h	DOS read-only
 E3h	Storage Dimensions
 E4h	SpeedStor 16-bit FAT extended partition
 E5h	officially listed as reserved
 E6h	officially listed as reserved
 F1h	Storage Dimensions
 F2h	DOS 3.3+ secondary partition
 F3h	officially listed as reserved
 F4h	SpeedStor
 F4h	Storage Dimensions
 F6h	officially listed as reserved
 FEh	LANstep
 FEh	IBM PS/2 IML
 FFh	Xenix bad block table
Note:	for partition type 07h, one should inspect the partition boot record
	  for the actual file system type
SeeAlso: #0548
--------B-1A00-------------------------------
INT 1A - TIME - GET SYSTEM TIME
	AH = 00h
Return: CX:DX = number of clock ticks since midnight
	AL = midnight flag, nonzero if midnight passed since time last read
Notes:	there are approximately 18.2 clock ticks per second, 1800B0h per 24 hrs
	  (except on Tandy 2000, where the clock runs at 20 ticks per second)
	IBM and many clone BIOSes set the flag for AL rather than incrementing
	  it, leading to loss of a day if two consecutive midnights pass
	  without a request for the time (e.g. if the system is on but idle)
	since the midnight flag is cleared, if an application calls this
	  function after midnight before DOS does, DOS will not receive the
	  midnight flag and will fail to advance the date
SeeAlso: AH=01h,AH=02h,INT 21/AH=2Ch,INT 55"Tandy 2000",INT 4E/AH=02h"TI"
SeeAlso: INT 62/AX=0099h,MEM 0040h:006Ch
--------B-1A01-------------------------------
INT 1A - TIME - SET SYSTEM TIME
	AH = 01h
	CX:DX = number of clock ticks since midnight
Return: nothing
Notes:	there are approximately 18.2 clock ticks per second, 1800B0h per 24 hrs
	  (except on Tandy 2000, where the clock runs at 20 ticks per second)
	this call resets the midnight-passed flag
SeeAlso: AH=00h,AH=03h,INT 21/AH=2Dh
--------B-1A02-------------------------------
INT 1A - TIME - GET REAL-TIME CLOCK TIME (AT,XT286,PS)
	AH = 02h
Return: CF clear if successful
	    CH = hour (BCD)
	    CL = minutes (BCD)
	    DH = seconds (BCD)
	    DL = daylight savings flag (00h standard time, 01h daylight time)
	CF set on error (i.e. clock not running or in middle of update)
Note:	this function is also supported by the Sperry PC, which predates the
	  IBM AT; the data is returned in binary rather than BCD on the Sperry,
	  and DL is always 00h
SeeAlso: AH=00h,AH=03h,AH=04h,INT 21/AH=2Ch
--------b-1A02-------------------------------
INT 1A - Tandy 2000 - TIME - GET DATE AND TIME
	AH = 02h
Return: BX = number of days since January 1, 1980
	CH = hours
	CL = minutes
	DH = seconds
	DL = hundredths
SeeAlso: AH=03h"Tandy 2000",INT 55"Tandy 2000"
--------B-1A03-------------------------------
INT 1A - TIME - SET REAL-TIME CLOCK TIME (AT,XT286,PS)
	AH = 03h
	CH = hour (BCD)
	CL = minutes (BCD)
	DH = seconds (BCD)
	DL = daylight savings flag (00h standard time, 01h daylight time)
Return: nothing
Note:	this function is also supported by the Sperry PC, which predates the
	  IBM AT; the data is specified in binary rather than BCD on the
	  Sperry, and the value of DL is ignored
SeeAlso: AH=01h,AH=03h,AH=05h,INT 21/AH=2Dh,INT 4B/AH=01h
--------b-1A03-------------------------------
INT 1A - Tandy 2000 - TIME - SET DATE AND TIME
	AH = 03h
	BX = number of days since January 1, 1980
	CH = hours
	CL = minutes
	DH = seconds
	DL = hundredths
Return: nothing
SeeAlso: AH=02h"Tandy 2000",INT 55"Tandy 2000"
--------B-1A04-------------------------------
INT 1A - TIME - GET REAL-TIME CLOCK DATE (AT,XT286,PS)
	AH = 04h
Return: CF clear if successful
	    CH = century (BCD)
	    CL = year (BCD)
	    DH = month (BCD)
	    DL = day (BCD)
	CF set on error
SeeAlso: AH=02h,AH=04h"Sperry",AH=05h,INT 21/AH=2Ah,INT 4B/AH=02h"TI"
--------b-1A04-------------------------------
INT 1A - Sperry PC - GET REAL-TIME CLOCK DATE
	AH = 04h
Return: CF clear if successful
	    CL = year-1980
	    DH = month (binary) (01h-0Ch)
	    DL = day (binary) (01h-1Fh)
	CF set on error
SeeAlso: AH=02h,AH=04h,AH=05h"Sperry",INT 21/AH=2Ah,INT 4B/AH=02h"TI"
--------B-1A05-------------------------------
INT 1A - TIME - SET REAL-TIME CLOCK DATE (AT,XT286,PS)
	AH = 05h
	CH = century (BCD)
	CL = year (BCD)
	DH = month (BCD)
	DL = day (BCD)
Return: nothing
SeeAlso: AH=04h,INT 21/AH=2Bh"DATE",INT 4B/AH=00h"TI"
--------b-1A05-------------------------------
INT 1A - Sperry PC - SET REAL-TIME CLOCK DATE
	AH = 05h
	CL = year-1980
	CH = 00h (???)
	DH = month (binary) (01h-0Ch)
	DL = day (binary) (01h-1Fh)
Return: nothing
SeeAlso: AH=02h,AH=04h"Sperry",AH=05h,INT 21/AH=2Bh"DATE"
--------B-1A06-------------------------------
INT 1A - TIME - SET ALARM (AT,XT286,PS)
	AH = 06h
	CH = hour (BCD)
	CL = minutes (BCD)
	DH = seconds (BCD)
Return: CF set on error (alarm already set or clock stopped for update)
	CF clear if successful
Notes:	the alarm occurs every 24 hours until turned off, invoking INT 4A each
	  time
	the BIOS does not check for invalid values for the time, so the CMOS
	  clock chip's "don't care" setting (any values between C0h and FFh)
	  may be used for any or all three parts.  For example, to create an
	  alarm once a minute, every minute, call with CH=FFh, CL=FFh, and
	  DH=00h.
SeeAlso: AH=07h,INT 4A"SYSTEM"
--------B-1A07-------------------------------
INT 1A - TIME - CANCEL ALARM (AT,XT286,PS)
	AH = 07h
Return: alarm disabled
Note:	does not disable the real-time clock's IRQ
SeeAlso: AH=06h,INT 70
--------B-1A08-------------------------------
INT 1A - TIME - SET RTC ACTIVATED POWER ON MODE (CONVERTIBLE)
	AH = 08h
	CH = hours in BCD
	CL = minutes in BCD
	DH = seconds in BCD
SeeAlso: AH=09h
--------B-1A09-------------------------------
INT 1A - TIME - READ RTC ALARM TIME AND STATUS (CONV,PS30)
	AH = 09h
Return: CH = hours in BCD
	CL = minutes in BCD
	DH = seconds in BCD
	DL = alarm status
	    00h alarm not enabled
	    01h alarm enabled but will not power up system
	    02h alarm will power up system
SeeAlso: AH=08h
--------B-1A0A-------------------------------
INT 1A - TIME - READ SYSTEM-TIMER DAY COUNTER (XT2,PS)
	AH = 0Ah
Return: CF set on error
	CF clear if successful
	    CX = count of days since Jan 1,1980
SeeAlso: AH=04h,AH=0Bh
--------B-1A0B-------------------------------
INT 1A - TIME - SET SYSTEM-TIMER DAY COUNTER (XT2,PS)
	AH = 0Bh
	CX = count of days since Jan 1,1980
Return: CF set on error
	CF clear if successful
SeeAlso: AH=05h,AH=0Ah
--------J-1A10-------------------------------
INT 1A - NEC PC-9800 series - PRINTER - INITIALIZE
	AH = 10h
	???
Return: ???
SeeAlso: AH=11h,AH=12h,INT 17/AH=01h
--------J-1A1000-----------------------------
INT 1A - NEC PC-9800 series - INSTALLATION CHECK
	AX = 1000h
Return: AX <> 1000h if NEC
--------J-1A11-------------------------------
INT 1A - NEC PC-9800 series - PRINTER - OUTPUT CHARACTER
	AH = 11h
	???
Return: ???
SeeAlso: AH=10h,AH=12h,INT 17/AH=00h
--------J-1A12-------------------------------
INT 1A - NEC PC-9800 series - PRINTER - SENSE STATUS
	AH = 12h
	???
Return: ???
SeeAlso: AH=10h,AH=11h,INT 17/AH=02h
--------A-1A3601-----------------------------
INT 1A - WORD PERFECT v5.0 Third Party Interface - INSTALLATION CHECK
	AX = 3601h
Return: DS:SI = routine to monitor keyboard input, immediately preceded by the
		ASCIZ string "WPCORP\0"
Notes:	WordPerfect 5.0 will call this interrupt at start up to determine if a
	  third party product wants to interface with it.  The third party
	  product must intercept this interrupt and return the address of a
	  keyboard monitor routine.
	Before checking for keyboard input, and after every key entered by the
	  user, Word Perfect will call the routine whose address was provided
	  in DS:SI with the following parameters:
		Entry:	AX = key code or 0
			BX = WordPerfect state flag
		Exit:	AX = 0 or key code
			BX = 0 or segment address of buffer with key codes
	See the "WordPerfect 5.0 Developer's Toolkit" for further information.
SeeAlso: INT 16/AX=5500h
--------N-1A6108-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SENDWITHREPLY" - SEND MSG AND GET REPLY
	AX = 6108h
	STACK:	WORD	conversation ID (0000h-0009h)
		DWORD	pointer to message buffer
		WORD	length of message
		DWORD	pointer to reply buffer
		WORD	length of reply buffer
		WORD	0000h (use default "Cparams" structure)
Return: AX = status (see #0550)
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=6205h

(Table 0550)
Values for SNAP.EXE status:
 0000h	successful
 F830h	"SNAP_ABORTED"
 FC04h	"SNAP_SERVERDIED"
 FC05h	"SNAP_RESEND"
 FC06h	"SNAP_SELECTFAILED"
 FC07h	"SNAP_WRONGVERSION"
 FC08h	"SNAP_INVALIDACK"
 FC09h	"SNAP_TIMEOUT"
 FC0Ah	"SNAP_SERVERREJECT"
 FC0Bh	"SNAP_NOREPLYDUE"
 FC0Ch	"SNAP_NOAUTHENTICATE"/"SNAP_GUARDIAN_ERROR"
 FC0Dh	"SNAP_NOINIT"
 FC0Eh	"SNAP_SOCKETERROR"
 FC0Fh	"SNAP_BUFFERLIMIT"
 FC10h	"SNAP_INVALIDCID"
 FC11h	"SNAP_INVALIDOP"
 FC12h	"SNAP_XMITFAIL"
 FC13h	"SNAP_NOMORERETRIES"
 FC14h	"SNAP_BADPARMS"
 FC15h	"SNAP_NOMEMORY"
 FC16h	"SNAP_NOMORECONVS"
 FFFFh	failed (invalid function/parameter)
--------N-1A6205-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SENDNOREPLY" - SEND MSG, DON'T AWAIT REPLY
	AX = 6205h
	STACK:	WORD	conversation ID (0000h-0009h)
		DWORD	pointer to message
		WORD	length of message
		WORD	0000h (use default "Cparms" structure)
Return: AX = status (see #0550)
	STACK unchanged
SeeAlso: AX=6108h
--------N-1A6308-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_BEGINCONV" - BEGIN CONVERSATION
	AX = 6308h
	STACK:	WORD	offset of ASCIZ "guardian"
		WORD	offset of ASCIZ hostname
		WORD	offset of ASCIZ server name
		WORD	offset of ASCIZ userid
		WORD	offset of ASCIZ password
		WORD	offset of password length
		WORD	offset of password type
		WORD	offset of "Cparms" structure (see #0551)
Return: ???
	STACK unchanged
Note:	all stacked offsets are within the SNAP data segment (use AX=6A01h
	  to allocate a buffer)
SeeAlso: AX=6405h,AX=7202h

Format of SNAP.EXE Cparms structure:
Offset	Size	Description	(Table 0551)
 00h	WORD	retry delay in seconds
 02h	WORD	timeout delay in seconds
 04h	WORD	maximum buffer size
 06h	WORD	encryption level
--------N-1A6405-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_ENDCONV" - END CONVERSATION
	AX = 6405h
	STACK:	WORD	conversation ID (0000h-0009h)
		DWORD	pointer to message buffer
		WORD	length of message
		WORD	0000h (use default "Cparms" structure)
Return: AX = status (see #0550)
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=6308h
--------N-1A6900-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_DATASEG" - GET RESIDENT DATA SEGMENT
	AX = 6900h
Return: AX = value used for DS by resident code
SeeAlso: AX=6A01h,AX=6F01h
--------N-1A6A01-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_ALLOC" - ALLOCATE BUFFER IN SNAP DATA SEGMENT
	AX = 6A01h
	STACK:	WORD	number of bytes to allocate
Return: AX = offset of allocated buffer or 0000h if out of memory
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=6B01h
--------N-1A6B01-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_FREE" - DEALLOCATE BUFFER IN SNAP DATA SEGMENT
	AX = 6B01h
	STACK:	WORD	offset within SNAP data segment of previously allocated
			buffer
Return: STACK unchanged
Note:	this call is a NOP if the specified offset is 0000h
SeeAlso: AX=6A01h
--------N-1A6C04-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_COPYTO" - COPY DATA TO RESIDENT SNAP PACKAGE
	AX = 6C04h
	STACK:	WORD	offset within SNAP data segment of dest (nonzero)
		WORD	segment of source buffer
		WORD	offset of source buffer
		WORD	number of bytes to copy
Return: AX = offset of byte after last one copied to destination
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=6D04h
--------N-1A6D04-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_COPYFROM" - COPY DATA FROM RESIDENT SNAP PACKAGE
	AX = 6D04h
	STACK:	WORD	offset within SNAP data segment of source buffer
		WORD	segment of destination buffer
		WORD	offset of destination buffer
		WORD	number of bytes to copy
Return: AX = offset of byte after last one copied from source
	buffer filled
	STACK unchanged
SeeAlso: AX=6C04h
--------N-1A6E01-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SETDEBUG" - SET ???
	AX = 6E01h
	STACK:	WORD	new value for ???
Return: AX = old value of ???
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
--------N-1A6F01-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_CHKINSTALL" - INSTALLATION CHECK
	AX = 6F01h
	STACK: WORD 0000h
Return: AX = status
	    0000h SNAP is resident
	    other SNAP not present
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol, and is
	  required by PCVENUS (a network shell).  The combination of SNAP and
	  PCVENUS allows the use of the Andrew File System as one or more
	  networked drives.
SeeAlso: AX=6900h,AX=7400h
--------N-1A7002-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SETANCHOR"
	AX = 7002h
	STACK:	WORD	anchor number (0000h-0009h)
		WORD	new value for the anchor
Return: AX = status
	    0000h successful
	    FFFFh failed (top word on stack not in range 00h-09h)
	STACK unchanged
SeeAlso: AX=7101h
--------N-1A7101-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_GETANCHOR"
	AX = 7101h
	STACK:	WORD	anchor number (0000h-0009h)
Return: AX = anchor's value
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=7002h
--------N-1A7202-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SETCONVPARMS" - SET CONVERSATION PARAMETERS
	AX = 7202h
	STACK:	WORD	conversation ID (0000h-0009h)
		WORD	offset within resident data segment of "Cparms"
			  structure (see #0551)
Return: AX = status???
	STACK unchanged
SeeAlso: AX=6308h
--------N-1A7302-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_CLIENTVERSION" - ???
	AX = 7302h
	STACK:	WORD	conversation ID (0000h-0009h)
		WORD	offset within resident data segment of ???
Return: AX = ???
	???
	STACK unchanged
SeeAlso: AX=7400h
--------N-1A7400-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_VERSION" - GET VERSION
	AX = 7400h
Return: AX = version (AH=major, AL=minor)
Note:	this call is only valid if SNAP is installed
SeeAlso: AX=7302h,INT 1A/AX=6F01h
--------N-1A75-------------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_NOP" - ???
	AH = 75h
	AL = ???
Return: AX = ??? (0000h)
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
--------N-1A76-------------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_802_5" - ???
	AH = 76h
	AL = ???
Return: AX = ???
--------N-1A77-------------------------------
INT 1A - SNAP.EXE 3.4 - ???
	AH = 77h
	AL = ??? (at least 01h)
	STACK:	WORD	???
		???
Return: ???
	STACK unchanged
--------N-1A7802-----------------------------
INT 1A - SNAP.EXE 3.4 - ???
	AX = 7802h
	STACK:	WORD	???
		WORD	???
Return: ???
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
--------s-1A7F-------------------------------
INT 1A - Tandy 2500, Tandy 1000L series - DIGITAL SOUND???
	AH = 7Fh
	???
Return: ???
Note:	this function is not supported by the Tandy 1000SL/TL BIOS
SeeAlso: AH=80h,AH=83h,AH=85h
--------s-1A80-------------------------------
INT 1A - PCjr, Tandy 2500???, Tandy 1000SL/TL - SET UP SOUND MULTIPLEXOR
	AH = 80h
	AL = 00h source is 8253 channel 2
	     01h source is cassette input
	     02h source is I/O channel "Audio IN"
	     03h source is sound generator chip
Note:	although documented in the 1000TL Technical Reference, the 1000TL
	  BIOS has just an IRET for this call
SeeAlso: AH=7Fh,AH=83h
--------X-1A80-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET NUMBER OF ADAPTERS
	AH = 80h
Return: CF clear if successful
	    CX = 5353h ('SS') if Socket Services installed
		AL = number of adapters present (0-16)
	    AH destroyed
	CF set on error
	    AH = error code (see #0552)
SeeAlso: AH=83h"PCMCIA"

(Table 0552)
Values for PCMCIA error codes:
 01h	"BAD_ADAPTER" nonexistent adapter
 02h	"BAD_ATTRIBUTE" invalid attribute specified
 03h	"BAD_BASE" invalid system memory base address
 04h	"BAD_EDC" invalid EDC generator specified
 05h	"BAD_INDICATOR" invalid indicator specified
 06h	"BAD_IRQ" invalid IRQ channel specified
 07h	"BAD_OFFSET" invalid PCMCIA card offset specified
 08h	"BAD_PAGE" invalid page specified
 09h	"BAD_READ" unable to complete request
 0Ah	"BAD_SIZE" invalid window size specified
 0Bh	"BAD_SOCKET" nonexistent socket specified
 0Ch	"BAD_TECHNOLOGY" unsupported Card Technology for writes
 0Dh	"BAD_TYPE" unavailable window type specified
 0Eh	"BAD_VCC" invalid Vcc power level index specified
 0Fh	"BAD_VPP" invalid Vpp1 or Vpp2 power level index specified
 10h	"BAD_WAIT" invalid number of wait states specified
 11h	"BAD_WINDOW" nonexistent window specified
 12h	"BAD_WRITE" unable to complete request
 13h	"NO_ADAPTERS" no adapters installed, but Socket Services is present
 14h	"NO_CARD" no card in socket
 15h	function not supported
 16h	invalid mode
 17h	invalid speed
 18h	busy
--------X-1A81-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - REGISTER STATUS CHANGE CALLBACK
	AH = 81h
	DS:DX -> callback routine (see #0553) or 0000h:0000h to disable
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (see #0552)
Note:	the callback will be invoked on any socket changes whose notification
	  has not been disabled with the status change enable mask; it may be
	  invoked either while processing a hardware interrupt from the adapter
	  or while processing the following Socket Services request
SeeAlso: AH=80h"PCMCIA",AH=82h"PCMCIA"

(Table 0553)
Values PCMCIA callback routine is invoked with:
	AL = adapter number
	BH = status change interrupt enable mask (see #0554)
	BL = socket number
	DH = current socket status (see #0555)
	DL = current card status (see #0556)
Return: all registers preserved
Notes:	the callback may be invoked during a hardware interrupt, and may not
	  call on Socket Services
	the callback will be invoked once for each socket with a status change

Bitfields for PCMCIA status change interrupt enable mask:
Bit(s)	Description	(Table 0554)
 7	card detect change
 6	ready change
 5	battery warning change
 4	battery dead change
 3	insertion request
 2	ejection request
 1-0	reserved (0)

Bitfields for PCMCIA current socket status:
Bit(s)	Description	(Table 0555)
 7	card changed
 6	reserved (0)
 5	card insertion complete
 4	card ejection complete
 3	card insertion request pending
 2	card ejection request pending
 1	card locked
 0	reserved (0)

Bitfields for PCMCIA current card status:
Bit(s)	Description	(Table 0556)
 7	card detect
 6	ready
 5	battery voltage detect 2 (battery warning)
 4	battery voltage detect 1 (battery dead)
 3-1	reserved (0)
 0	write protected
--------s-1A8100-----------------------------
INT 1A - Tandy 2500, Tandy 1000L series - DIGITAL SOUND - INSTALLATION CHECK
	AX = 8100h
Return: AL > 80h if supported
	AX = 00C4h if supported (1000SL/TL)
	    CF set if sound chip is busy
	    CF clear  if sound chip is free
Note:	the value of CF is not definitive; call this function until CF is
	  clear on return, then call AH=84h"Tandy"
--------s-1A82-------------------------------
INT 1A - Tandy 2500???, Tandy 1000SL/TL - DIGITAL SOUND - RECORD SOUND
	AH = 82h
	ES:BX -> buffer for sound samples
	CX = length of buffer
	DX = transfer rate (1-4095, 1 is fastest)
Return: AH = 00h
	CF set if sound busy
	CF clear if sound chip free
Note:	the value in DX should be 1/10 the corresponding value for
	  INT 1A/AH=83h on the 1000TL, 1/11.5 on the 1000SL.  Call
	  INT 1A/AX=8100h and INT 1A/AH=84h before invoking this function.
	The BIOS issues an INT 15/AX=91FBh when the input is complete
	DMA across a 64K boundary is masked by the BIOS
--------X-1A82-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - REGISTER CARD TECHNOLOGY CALLBACK
	AH = 82h
	DS:DX -> callback routine (see #0557) or 0000h:0000h
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (see #0552)
Note:	the callback is invoked on a Write Multiple request with an unsupported
	  card technology type
SeeAlso: AH=81h"PCMCIA",AH=94h

(Table 0557)
Values PCMCIA callback routine is invoked with:
	ES:AX -> Low-Level Socket Services Routines (see #0559)
	BH = socket attributes (see #0558)
	CX = number of bytes or words to write
	DS:SI -> data buffer to be written
	DX:DI -> 26-bit linear card address
	BP = card technology type
Return: CF clear if successful
	CF set on error
	    AH = error code (07h,0Ch,12h,14h) (see #0552)

Bitfields for PCMCIA socket attributes:
Bit(s)	Description	(Table 0558)
 7-4	reserved (0)
 3	packed buffer
 2	even bytes only (only valid if 1 set)
 1	data width (clear = byte, set = word)
 0	memory type (clear = common, set = attribute)

Format of PCMCIA Low-Level Socket Services Routines:
Offset	Size	Description	(Table 0559)
 00h	WORD	offset of Write Many routine (see #0560)
 02h	WORD	offset of Write One routine (see #0561)
 04h	WORD	offset of Read One routine (see #0562)
 06h	WORD	offset of Increment Offset routine (see #0563)
 08h	WORD	offset of Set Offset routine (see #0564)
 0Ah	WORD	offset of Get Status routine (see #0565)

(Table 0560)
Call Write Many routine with:
	BH = socket attributes (see #0558)
	CX = number of bytes or words to write
	DS:SI -> data to be written
Return: CF clear if successful
	CF set on error

(Table 0561)
Call Write One routine with:
	AL/AX = data to be written
	BH = socket attributes (see #0558)
Return: CF clear if successful
	CF set on error

(Table 0562)
Call Read One routine with:
	BH = socket attributes (see #0558)
Return: CF clear if successful
	    AL/AX = data read
	CF set on error

(Table 0563)
Call Increment Offset routine with:
	BH = socket attributes (see #0558)
Return: CF clear if successful
	CF set on error

(Table 0564)
Call Set Offset routine with:
	DX:DI = new offset address
Return: CF clear if successful
	CF set on error

(Table 0565)
Call Get Status routine with:
	nothing
Return: AL = current card status (see #0556)
--------s-1A83-------------------------------
INT 1A - Tandy 2500, Tandy 1000L series - START PLAYING DIGITAL SOUND
	AH = 83h
	AL = volume (0=silence, 7=highest)
	CX = number of bytes to play
	DX = time between sound samples (multiples of 273 nanoseconds)
	    only bits 11-0 used
	ES:BX -> sound data (array of 8-bit unsigned PCM samples)
Return: AH = 00h
	CF set if sound is busy
	CF clear if sound chip is free
Notes:	this call returns immediately while the sound plays in the
	  background; the sound chip is clocked at 3.57 MHz, with the low 12
	  bits of DX specifying the clock divisor
	The BIOS appears to call INT 15/AX=91FBh when the sound device
	  underflows to allow another INT 1A/AH=83h for seamless playing of
	  long sounds.
SeeAlso: AH=84h"Tandy",INT 15/AH=91h
--------X-1A83-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET SOCKET SERVICES VERSION NUMBER
	AH = 83h
	AL = adapter number
Return: CF clear if successful
	    AX = Socket Services version (BCD)
	    BX = implementation version (BCD)
	    CX = 5353h ("SS")
	    DS:SI -> ASCIZ implementor description
	CF set on error
	    AH = error code (01h) (see #0552)
Note:	the current version (from the Revision A.00 documentation) of Socket
	  Services is 1.00 (AX=0100h)
SeeAlso: AH=80h"PCMCIA"
--------s-1A84-------------------------------
INT 1A - Tandy 2500, Tandy 1000L series - STOP PLAYING DIGITAL SOUND
	AH = 84h
Return: ???
Note:	the BIOS will call INT 15/AX=91FBh when the sound has stopped playing
SeeAlso: AH=83h"Tandy",AH=85h"Tandy"
--------X-1A84-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - INQUIRE ADAPTER
	AH = 84h
	AL = adapter number
Return: CF clear if successful
	    AH destroyed
	    BH = number of windows
	    BL = number of sockets (1-16)
	    CX = number of EDCs
	    DH = capabilities (see #0566)
	    DL = status change interrupt used (only if DH bit 3 set)(see #0567)
	CF set on error
	    AH = error code (01h) (see #0552)
SeeAlso: AH=80h"PCMCIA",AH=85h"PCMCIA",AH=87h

Bitfields for PCMCIA capabilities:
Bit(s)	Description	(Table 0566)
 7-6	reserved (0)
 5	status change interrupt is hardware shareable
 4	status change interrupt is software shareable
 3	status change interrupt
 2	data bus width is per-socket rather than per-window
 1	power management is per-adapter rather than per-socket
 0	indicators are per-adapter rather than per-socket

(Table 0567)
Values for PCMCIA status change interrupt usage:
 00h-0Fh IRQ level
 10h	NMI
 11h	I/O check
 12h	bus error
 13h	vendor specific
 14h-FFh reserved
--------s-1A85-------------------------------
INT 1A - Tandy 2500, Tandy 1000L series - DIGITAL SOUND???
	AH = 85h
	???
Return: ???
Note:	this function is not supported by the Tandy 1000SL/TL BIOS
SeeAlso: AH=7Fh,AH=83h"Tandy"
--------X-1A85-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET ADAPTER
	AH = 85h
	AL = adapter number
Return: CF clear if successful
	    AH destroyed
	    DH = adapter attributes (see #0568)
	CF set on error
	    AH = error code (01h) (see #0552)
SeeAlso: AH=84h"PCMCIA",AH=86h

Bitfields for PCMCIA adapter attributes:
Bit(s)	Description	(Table 0568)
 7-5	reserved (0)
 4	hardware share status change
 3	software share status change
 2	enable status change interrupts
 1	adapter preserves state information during reduced power consumption
 0	attempting to reduce power consumption
--------X-1A86-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET ADAPTER
	AH = 86h
	AL = adapter number
	DH = new adapter attributes (see #0568)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h) (see #0552)
SeeAlso: AH=84h"PCMCIA",AH=85h"PCMCIA"
--------X-1A87-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - INQUIRE WINDOW
	AH = 87h
	AL = adapter number
	BH = window number
Return: CF clear if successful
	    AH destroyed
	    BL = capabilities (see #0569)
	    CX = bitmap of assignable sockets
	    DH = EISA A15-A12 address lines (in bits 7-4, bits 3-0 = 0)
	    DL = supported access speeds (see #0570)
	    DS:SI -> Memory Window Characteristics table (see #0571)
	    DS:DI -> I/O Window Characteristics table (see #0572)
	CF set on error
	    AH = error code (01h,11h) (see #0552)
SeeAlso: AH=84h"PCMCIA",AH=88h,AH=89h,AH=8Ch

Bitfields for PCMCIA window capabilities:
Bit(s)	Description	(Table 0569)
 7-5	reserved (0)
 4	separate enable for EISA comon space
 3	EISA I/O mappable
 2	I/O space
 1	attribute memory
 0	common memory

Bitfields for PCMCIA supported access speeds:
Bit(s)	Description	(Table 0570)
 7	reserved (0)
 6	600 ns
 5	300 ns
 4	250 ns
 3	200 ns
 2	150 ns
 1	100 ns
 0	WAIT line monitoring

Format of PCMCIA Memory Window Characteristics table:
Offset	Size	Description	(Table 0571)
 00h	WORD	window capabilities (see #0573)
 02h	WORD	minimum base address in 4K pages
 04h	WORD	maximum base address in 4K pages
 06h	WORD	minimum window size in 4K pages
 08h	WORD	maximum window size in 4K pages
 0Ah	WORD	window size granularity (4K units)
 0Ch	WORD	required base address alignment (4K units)
 0Eh	WORD	required card offset alignment (4K units)

Format of PCMCIA I/O Window Characteristics table:
Offset	Size	Description	(Table 0572)
 00h	WORD	window capabilities (see #0573)
 02h	WORD	minimum base address in bytes
 04h	WORD	maximum base address in bytes
 06h	WORD	minimum window size in bytes
 08h	WORD	maximum window size in bytes
 0Ah	WORD	window size granularity (bytes)

Bitfields for PCMCIA window capabilities:
Bit(s)	Description	(Table 0573)
 0	programmable base address
 1	programmable window size
 2	window disable/enable supported
 3	8-data bus
 4	16-data bus
 5	base address alignment on size boundary required
 6	power-of-two size granularity
---memory windows---
 7	card offset must be aligned on size boundary
 8	paging hardware available
 9	paging hardware shared
 10	page disable/enable supported
 11-15	reserved (0)
---I/O windows---
 7-15	reserved (0)
--------X-1A88-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET WINDOW
	AH = 88h
	AL = adapter number
	BH = window number
Return: CF clear if successful
	    AH destroyed
	    BL = socket number (0-16) (0 = not assigned)
	    CX = window size (bytes for I/O window, 4K units for memory window)
	    DH = window attributes (see #0574)
	    DL = access speed (only one bit set) (see #0570)
	    SI = window base address (bytes if I/O, 4K units if memory)
	    DI = card offset address (memory only, 4K units)
	CF set on error
	    AH = error code (01h,11h) (see #0552)
SeeAlso: AH=87h,AH=89h,AH=8Ah

Bitfields for PCMCIA window attributes:
Bit(s)	Description	(Table 0574)
 0	memory-mapped rather than I/O-mapped
 1	attribute memory rather than common (memory-mapped)
	EISA mapped (I/O)
 2	enabled
 3	16-data path
 4	subdivided into pages (memory-mapped only)
 5	non-specific access slot enable (EISA-mapped only)
 6-7	reserved (0)
--------X-1A89-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET WINDOW
	AH = 89h
	AL = adapter number
	BH = window number
	BL = socket number
	CX = window size (bytes if I/O window, 4K units if memory window)
	DH = window attributes (see #0574)
	DL = access speed (only one bit set) (see #0570)
	SI = window base address (bytes if I/O, 4K units if memory window)
	DI = card offset addrress (memory only, 4K units)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,03h,07h,08h,0Ah,0Bh,0Dh,10h,11h) (see #0552)
SeeAlso: AH=87h,AH=88h,AH=8Bh
--------X-1A8A-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET PAGE
	AH = 8Ah
	AL = adapter number
	BH = window number
	BL = page number
Return: CF clear if successful
	    AH destroyed
	    DX = page attributes (see #0575)
	    DI = memory card offset (4K units)
	CF set on error
	    AH = error code (01h,08h,11h) (see #0552)
Notes:	this function is only valid for memory-mapped windows
	the socket being operated on is implied by the previous AH=89h call
SeeAlso: AH=88h,AH=8Bh

Bitfields for PCMCIA page attributes:
Bit(s)	Description	(Table 0575)
 0	page enabled
 15-1	reserved (0)
--------X-1A8B-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET PAGE
	AH = 8Bh
	AL = adapter number
	BH = window number
	BL = page number
	DX = page attributes (see #0575)
	DI = memory card offset (4K units)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,02h,07h,08h,11h) (see #0552)
Notes:	this function is only valid for memory-mapped windows
	the socket being operated on is implied by the previous AH=89h call
SeeAlso: AH=89h,AH=8Ah
--------X-1A8C-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - INQUIRE SOCKET
	AH = 8Ch
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
Return: CF clear if successful
	    AH destroyed
	    DH = capabilities (see #0576)
	    DL = hardware indicators (see #0577)
	    DS:SI -> Socket Characteristics table (see #0578)
	    DS:DI -> Power Management table (see #0580)
	CF set on error
	    AH = error code (01h,0Bh) (see #0552)
SeeAlso: AH=87h,AH=8Dh,AH=8Eh

Bitfields for PCMCIA socket capabilities:
Bit(s)	Description	(Table 0576)
 0	card change
 1	card lock
 2	insert card (motor control)
 3	eject card (motor control)
 4-7	reserved (0)

Bitfields for PCMCIA socket hardware indicators:
Bit(s)	Description	(Table 0577)
 0	busy status
 1	write-protected
 2	battery status
 3	card lock status
 4	XIP status (eXecute-In-Place)
 5-7	reserved (0)

Format of PCMCIA Socket Characteristics table:
Offset	Size	Description	(Table 0578)
 00h	WORD	supported card types (see #0579)
 02h	WORD	steerable IRQ levels (bit 0 = IRQ0 to bit 15 = IRQ15)
 04h	WORD	additional steerable IRQ levels
		bit 0: NMI
		bit 1: I/O check
		bit 2: bus error
		bit 3: vendor-unique
		bits 4-7 reserved (0)

Bitfields for supported card types:
Bit(s)	Description	(Table 0579)
 0	memory card
 1	I/O card
 2-7	reserved (0)

Format of PCMCIA Power Management table:
Offset	Size	Description	(Table 0580)
 00h	WORD	number of entries in table (0 if power management not avail)
 02h 2N BYTEs	power levels
		byte 0: voltage in 0.1V units
		byte 1: power supply
			bit 7: Vcc
			bit 6: Vpp1
			bit 5: Vpp2
--------X-1A8D-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET SOCKET
	AH = 8Dh
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
Return: CF clear if successful
	    AH destroyed
	    BH = status change interrupt enable mask (see #0554)
	    CH = Vcc level (lower nybble) (see #0580)
	    CL = Vpp1 level (upper nybble) and Vpp2 level (lower nybble)
	    DH = current socket status (see #0555)
	    DL = indicators (see #0577)
	    SI = card type (see #0581)
	    DI = IRQ level steering (I/O only) (see #0582)
	CF set on error
	    AH = error code (01h,0Bh) (see #0552)
SeeAlso: AH=8Ch,AH=8Eh

Bitfields for PCMCIA card type:
Bit(s)	Description	(Table 0581)
 0	memory
 1	I/O
 2-15	reserved (0)

Bitfields for PCMCIA I/O level steering:
Bit(s)	Description	(Table 0582)
 15	interrupt steering enabled
 14-5	reserved (0)
 4-0	IRQ level (0-15=IRQ,16=NMI,17=I/O check,18=bus error,19=vendor)
--------X-1A8E-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET SOCKET
	AH = 8Eh
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = status change interrupt enable mask (see #0554)
	CL = Vpp1 level (upper nybble) and Vpp2 level (lower nybble)
	DH = current socket status (see #0555)
	DL = indicators (see #0577)
	SI = card type (see #0581)
	DI = IRQ level steering (I/O only) (see #0582)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,02h,05h,06h,0Bh,0Eh,0Fh) (see #0552)
SeeAlso: AH=8Ch,AH=8Dh
--------X-1A8F-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET CARD
	AH = 8Fh
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
Return: CF clear if successful
	    AH destroyed
	    DL = current card status (see #0556)
	CF set on error
	    AH = error code (01h,0Bh) (see #0552)
SeeAlso: AH=8Dh,AH=90h
--------X-1A90-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - RESET CARD
	AH = 90h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,0Bh,14h) (see #0552)
Note:	toggles RESET pin of the specified card, but does not wait after
	  toggling the pin; it is the caller's responsibility to avoid
	  accessing the card before it is ready again
--------X-1A91-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - READ ONE
	AH = 91h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = attributes (see #0583)
	DX:SI = card address
Return: CF clear if successful
	    AH destroyed
	    CL/CX = value read
	CF set on error
	    AH = error code (01h,07h,09h,0Bh,14h) (see #0552)
	    CX may be destroyed
Note:	this function is only valid for I/O-mapped sockets
SeeAlso: AH=92h,AH=93h,INT 21/AX=440Dh"DOS 3.2+"

Bitfields for PCMCIA attributes:
Bit(s)	Description	(Table 0583)
 2	even bytes only
 1	word rather than byte
 0	attribute memory instead of common memory
--------X-1A92-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - WRITE ONE
	AH = 92h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = attributes (see #0583)
	CL/CX = value to write
	DX:SI = card address
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,07h,0Bh,12h,14h) (see #0552)
Note:	this function is only valid for I/O-mapped sockets; it also does not
	  implement Card Technology handling--use AH=94h when writing to
	  non-RAM technologies
SeeAlso: AH=91h,AH=94h,INT 21/AX=440Dh"DOS 3.2+"
--------X-1A93-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - READ MULTIPLE
	AH = 93h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = attributes (see #0583)
	CX = number of bytes or words to read
	DX:SI = card address
	DS:DI -> data buffer to be filled
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,07h,09h,0Bh,14h) (see #0552)
Note:	this function is only available on I/O-mapped sockets
SeeAlso: AH=91h,AH=94h,INT 21/AX=440Dh"DOS 3.2+"
--------X-1A94-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - WRITE MULTIPLE
	AH = 94h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = attributes (see #0583)
	CX = number of bytes or words to read
	DX:DI = card address
	DS:SI -> buffer containing data
	BP = Card Technology type (0000h = RAM)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,07h,0Bh,0Ch,12h,14h) (see #0552)
Notes:	this function is only available on I/O-mapped sockets
	Socket Services calls the Card Technology callback (see #0557) for
	  any card technology it does not directly support
SeeAlso: AH=82h"PCMCIA",AH=92h,AH=93h,INT 21/AX=440Dh"DOS 3.2+"
--------X-1A95-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - INQUIRE ERROR DETECTION CODE
	AH = 95h
	AL = adapter number
	BH = EDC generator number
Return: CF clear if successful
	    AH destroyed
	    CX = bitmap of assignable sockets
	    DH = EDC capabilities (see #0584)
	    DL = supported EDC types (see #0585)
	CF set on error
	    AH = error code (01h,04h) (see #0552)
SeeAlso: AH=96h,AH=9Ch

Bitfields for EDC capabilities:
Bit(s)	Description	(Table 0584)
 0	unidirectional only generation
 1	bidirectional only generation
 2	register-based (I/O-mapped) support
 3	memory-mapped support
 4	pausable
 5-7	reserved (0)

Bitfields for supported EDC types:
Bit(s)	Description	(Table 0585)
 0	8-checksum
 1	16-CRC-SDLC
 2-7	reserved (0)
--------X-1A96-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET ERROR DETECTION CODE
	AH = 96h
	AL = adapter number
	BH = EDC generator number
Return: CF clear if successful
	    AH destroyed
	    BL = socket number
	    DH = EDC attributes (see #0586)
	    DL = EDC type (see #0585) (only one bit set)
	CF set on error
	    AH = error code (01h,04h) (see #0552)
SeeAlso: AH=95h,AH=97h,AH=9Ch

Bitfields for EDC attributes:
Bit(s)	Description	(Table 0586)
 0	unidirectional only
 1	(if 0 set) clear=read, set=write
 2-7	reserved (0)
--------X-1A97-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET ERROR DETECTION CODE
	AH = 97h
	AL = adapter number
	BH = EDC generator
	BL = socket number
	DH = EDC attributes (see #0586)
	DL = EDC type (see #0585) (only one bit may be set)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,02h,04h,0Bh) (see #0552)
SeeAlso: AH=96h,AH=9Ch
--------X-1A98-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - START ERROR DETECTION CODE
	AH = 98h
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,04h) (see #0552)
SeeAlso: AH=96h,AH=99h,AH=9Bh,AH=9Ch
--------X-1A99-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - PAUSE ERROR DETECTION CODE
	AH = 99h
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,04h) (see #0552)
SeeAlso: AH=9Ah
--------X-1A9A-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - RESUME ERROR DETECTION CODE
	AH = 9Ah
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,04h) (see #0552)
SeeAlso: AH=99h,AH=98h
--------X-1A9B-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - STOP ERROR DETECTION CODE
	AH = 9Bh
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (see #0552)
SeeAlso: AH=98h,AH=99h,AH=9Ch
--------X-1A9C-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - READ ERROR DETECTION CODE
	AH = 9Ch
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	    DL/DX = computed checksum or CRC
	CF set on error
	    AH = error code (01h,04h) (see #0552)
SeeAlso: AH=95h,AH=96h,AH=98h,AH=99h,AH=9Bh
--------X-1A9D-------------------------------
INT 1A - PCMCIA Socket Services v2.1??? - GET VENDOR INFO
	AH = 9Dh
	AL = adapter number
	BH = EDC generator
	ES:EDI -> vendor information structure (see #0587)
Return: CF clear if successful
	    AH destroyed
	    DX = vendor release number in BCD
	    ES:EDI unchanged
	CF set on error
	    AH = error code (01h,15h) (see #0552)
Notes:	this API is supported by recent versions of the AMI BIOS
	the low-level API described here is hidden by the higher-level
	  ExCA API once Card Services has been installed
SeeAlso: AH=9Dh"ExCA"

Format of Vendor Information structure:
Offset	Size	Description	(Table 0587)
 00h	WORD	buffer length (set to size of buffer below)
 04h	WORD	(ret) data length
 08h  x BYTEs	implementor name (ASCIIZ string)
--------X-1A9D-------------------------------
INT 1A - Intel PCMCIA ExCA Card Services - API
	AH = 9Dh
	AL = subfunction (see #0588)
	???
Return: ???
SeeAlso: AH=9Dh"ExCA",#3310

(Table 0588)
Values for PCMCIA ExCA Card Services subfunction number:
 00h	Client Services: Get Number of Sockets
 01h	Advanced Client Utilities: Initialize
 02h	Client Services: Register Client
 03h	Client Services: Deregister Client
 04h	Advanced Client Utilities: Enumerate Clients
 05h	Client Services: Register SCB
 06h	Client Services: Deregister SCB
 07h	Advanced Client Utilities: Register MTD
 08h	Advanced Client Utilities: Deregister MTD
 09h	Advanced Client Utilities: Enumerate MTD
 0Ah	Client Services: Get Status
 0Bh	Client Services: Reset Card
 0Ch	Client Utilities: Get First Tuple
 0Dh	Client Utilities: Get Next Tuple
 0Eh	Client Utilities: Determine First Region
 0Fh	Client Utilities: Determine Next Region
 10h	Client Utilities: Get First Region
 11h	Client Utilities: Get Next Region
 12h	Client Utilities: Get First Partition
 13h	Client Utilities: Get Next Partition
 14h	Bulk Memory Services: Open Region
 15h	Bulk Memory Services: Read Memory
 16h	Bulk Memory Services: Write Memory
 17h	Bulk Memory Services: Copy Memory
 18h	Bulk Memory Services: Erase Memory
 19h	Resource Management: Request I/O
 1Ah	Resource Management: Release I/O
 1Bh	Resource Management: Request Memory
 1Ch	Client Services: Modify Window
 1Dh	Resource Management: Release Memory
 1Eh	Client Services: Map Mem Page
 1Fh	Advanced Client Utilities: Return SS Entry
 20h	Advanced Client Utilities: Map Log to Phy
 21h	Advanced Client Utilities: Map Log Phy to Log
 22h	Resource Management: Request IRQ
 23h	Resource Management: Release IRQ
 24h	Bulk Memory Services: Close Region
--------X-1A9E-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - ACKNOWLEDGE INTERRUPT
	AH = 9Eh
	AL = adapter number
Return: CF clear if successful
	    AH destroyed
	    CX = bitmap representing sockets which have changed status
	CF set on error
	    AH = error code (01h) (see #0552)
Note:	this API is supported by recent versions of the AMI BIOS
--------X-1A9F-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - GET/SET PRIOR INT 1A HANDLER
	AH = 9Fh
	AL = adapter number
	BL = mode
	    00h get prior INT 1Ah handler
	    01h set prior INT 1Ah handler
		CX:DX -> new prior handler
Return: CF clear if successful
	    AH destroyed
	    CX:DX -> old prior handler
	CF set on error
	    AH = error code (01h,15h,18h) (see #0552)
Desc:	allows hooking of INT 16h "behind" the Socket Services hook
Note:	this API is supported by recent versions of the AMI BIOS
SeeAlso: AH=9Eh,AH=A0h"PCMCIA",AH=AEh"PCMCIA"
--------c-1AA0-------------------------------
INT 1A U - Disk Spool II v2.07+ - INSTALLATION CHECK
	AH = A0h
Return: AH = B0h if installed
	    AL = pending INT 1A/AH=D0h subfunction if nonzero???
	    ES = code segment
	    ES:BX -> name of current spool file
	    ES:SI -> current despool file
	    CL = despooler state (00h disabled, 41h enabled)
	    CH = spooler state (00h disabled, 41h enabled)
	    DL = despooler activity
		00h currently active printing a file
		41h standing by
	    DH = 00h ???
	       = 41h ???
	    DI = 0000h ???
		 0001h ???
Program: Disk Spool II is a shareware disk-based print spooler by Budget
	  Software Company
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=ABh,AH=C0h,AH=D0h,AH=E1h
--------X-1AA0-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - GET/SET SOCKET SERVICES ADDRESS
	AH = A0h
	AL = adapter number
	BH = mode
	    00h real mode
	    01h 16:16 protected mode
	    02h 16:32 protected mode
	    03h 00:32 (Flat) protected mode
	BL = subfunction
	    00h return number of additional data areas (see #0589)
	    01h return description of additional data areas (see #0590)
	    02h accept mode-specific pointers to data areas (see #0591)
	ES:EDI -> buffer supplied by caller
Return: CF clear if successful
	    AH destroyed
	    CX = number of additional data areas
	    ES:EDI unchanged
	CF set on error
	    AH = error code (01h,02h,15h,16h,18h) (see #0552)
SeeAlso: AH=9Fh,AH=AEh

Format of PCMCIA Subfunction 00h Buffer Table Entry structure:
Offset	Size	Description	(Table 0589)
 00h	DWORD	32-bit linear base address of the code segment
 04h	DWORD	segment limit of the code segment
 08h	DWORD	entry point offset
 0Ch	DWORD	32-bit linear base address of the data segment
		(ignored in 00:32 flat mode)
 10h	DWORD	segment limit of the data segment
 14h	DWORD	data area offset.  Only used in 32-bit protected mode.
SeeAlso: #0590,#0591

Format of PCMCIA Additional Data Area Description structure [array]:
Offset	Size	Description	(Table 0590)
 00h	DWORD	32-bit linear base address of the additional data segment
		(ignored in 00:32 flat mode)
 04h	DWORD	segment limit of the code segment
 08h	DWORD	data area offset (only used in 32-bit protected mode)
SeeAlso: #0589,#0591

Format of PCMCIA Subfunction 02h Buffer Table Entry structure:
Offset	Size	Description	(Table 0591)
 00h	DWORD	32-bit offset(ignored in 16:16 protected mode)
 04h	DWORD	selector (only used in 00:32 flat mode)
 08h	DWORD	reserved
SeeAlso: #0589,#0590
--------X-1AA1-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - GET ACCESS OFFSETS
	AH = A1h
	AL = adapter number
	BH = Mode
	     00h = Real Mode
	     01h = 16:16 Protected Mode
	     02h = 16:32 Protected Mode
	     03h = 00:32 Protected Mode
	CX = Number of access offsets
	ES:EDI -> buffer supplied by caller, CX words long (see #0592)
Return: CF clear if successful
	    AH destroyed
	    DX = number of access offsets supported
	    ES:EDI unchanged
	CF set on error
	    AH = error code (01h,15h,16h) (see #0552)
Desc:	Returns an array of low-level adapter-specific optimized
	PC Card access routines for adapters that use registers
	or I/O ports to access PC Card memory.	Adapters that access
	PC Card memory through windows mapped to host system memory
	do not support this function.
Note:	offsets returned are 16-bit offsets into the
	Socket Services code segment.  They must be called
	appropriately for the processor mode selected.
	(Real, 16:16 and 16:32 modes use FAR CALL,
	Flat 00:32 mode uses a 32-bit NEAR CALL).
SeeAlso: AH=AEh

Format of Offset Table structure:
Offset	Size	Description	(Table 0592)
 00h	WORD	Set Address
 02h	WORD	Set Auto Increment
 04h	WORD	Read Byte
 06h	WORD	Read Word
 08h	WORD	Read Byte with Auto Increment
 0Ah	WORD	Read Word with Auto Increment
 0Ch	WORD	Read Words
 0Eh	WORD	Read Words with Auto Increment
 10h	WORD	Write Byte
 12h	WORD	Write Word
 14h	WORD	Write Byte with Auto Increment
 16h	WORD	Write Word with Auto Increment
 18h	WORD	Write Words
 1Ah	WORD	Write Words with Auto Increment
 1Ch	WORD	Compare Byte
 1Eh	WORD	Compare Byte with Auto Increment
 20h	WORD	Compare Words
 22h	WORD	Compare Words with Auto Increment
--------X-1AA2-------------------------------
INT 1A - CardBus Socket Services - ACCESS CONFIGURATION SPACE
	AH = A2h
	??? details not available
Return: ???
--------X-1AA4-------------------------------
INT 1A - CardBus Socket Services - GET BRIDGE WINDOW / WINDOW CAPABILITIES
	AH = A4h
	??? details not available
Return: ???
SeeAlso: AH=A5h"CardBus"
--------X-1AA5-------------------------------
INT 1A - CardBus Socket Services - SET BRIDGE WINDOW
	AH = A5h
	??? details not available
Return: ???
SeeAlso: AH=A4h"CardBus"
--------c-1AAB-------------------------------
INT 1A U - Disk Spool II v1.83 - INSTALLATION CHECK
	AH = ABh
Return: AH = BAh if installed
	    AL = pending INT 1A/AH=ADh subfunction if nonzero???
	    ES = code segment
	    ES:BX -> name of current spool file
	    ES:SI -> current despool file
	    CL = despooler state (00h disabled, 41h enabled)
	    CH = spooler state (00h disabled, 41h enabled)
	    DL = despooler activity
		00h currently active printing a file
		41h standing by
	    DH = 00h ???
	       = 41h ???
	    DI = 0000h ???
		 0001h ???
Program: Disk Spool II is a shareware disk-based print spooler by Budget
	  Software Company
SeeAlso: AH=A0h,AH=ACh,AH=ADh,AH=E1h
--------c-1AAC-------------------------------
INT 1A U - Disk Spool II v1.83 - INSTALLATION CHECK
	AH = ACh
Return: (see AH=ABh)
Note:	this function is identical to AH=ABh
SeeAlso: AH=A0h,AH=ABh,AH=ADh
--------c-1AAD-------------------------------
INT 1A U - Disk Spool II v1.83 - FUNCTION CALLS
	AH = ADh
	AL = function code (see #0593)
Return: AH = 00h if successful
SeeAlso: AH=ABh

(Table 0593)
Values for Disk Spool function code:
 02h	enable spooler only
 03h	enable the despooler
 04h	disable the despooler
 08h	inhibit popup menu
 09h	enable popup menu
 0Ah	???
 0Bh	disable the spooler
 0Ch	start despooler after last successfully printed document???
 0Dh	start despooler at the exact point where it last left off???
 0Eh	pop up the menu
 0Fh	???
 11h	???
 14h	???
 15h	???
 16h	???
 17h	???
 18h	???
 19h	???
 20h	clear file pointed to by the despooler???
 21h	???
 22h	???
 23h	???
 30h	???
--------X-1AAE-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - VENDOR SPECIFIC
	AH = AEh
	AL = adapter number
	all other registers are vendor-specific
Return: vendor specific
SeeAlso: AH=A1h,AH=AFh
--------X-1AAE-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - API
	AH = AEh
	SI = function
	    0002h ???
	    0100h ???
	    0101h ???
	    8000h ???
	    8001h ???
	details not yet available
Return: CF clear if successful
	CF set on error
	    AH = error code (02h,0Bh,11h,15h,17h) (see #0552)
SeeAlso: AH=9Eh
--------X-1AAF-------------------------------
INT 1A - PCMCIA v2 Card Services - API
	AH = AFh
	AL = function
	    00h close memory
	    01h copy memory
	    02h deregister client
	    03h get client information (see #0598)
	    04h get configuration information (see #0600)
	    05h get first partition
	    06h get first region
	    07h get first tuple (see #0607)
	    08h get next partition
	    09h get next region
	    0Ah get next tuple
	    0Bh	get Card Services information (see #0596)
	    0Ch get status
	    0Dh	get tuple data (see #0608)
	    0Eh	get first client (see #0597)
	    0Fh get/register Erase Queue
	    10h	register client (see #0609)
	    11h reset function
	    12h map logical socket
	    13h map logical window
	    14h map memory page
	    15h map physical socket
	    16h map physical window
	    17h modify window
	    18h open memory
	    19h read memory
	    1Ah register MTD
	    1Bh release I/O
	    1Ch release IRQ (see #0611)
	    1Dh release window
	    1Eh release configuration (see #0612)
	    1Fh request I/O (see #0613)
	    20h request IRQ (see #0614)
	    21h reqeust window (see #0616)
	    22h request socket mask
	    23h return SS entry
	    24h write memory
	    25h deregister Erase Queue
	    26h check Erase Queue
	    27h modify configuration
	    28h register timer
	    29h set region
	    2Ah get next client
	    2Bh validate CIS
	    2Ch request exclusive access (see #0619)
	    2Dh release exclusive access (see #0619)
	    2Eh get event mask
	    2Fh release socket mask
	    30h request configuration (see #0620)
	    31h set event mask
	    32h add Socket Service
	    33h replace Socket Service
	    34h vendor-specific
	    35h adjust resource information
	    36h access configuration register
	    37h get first window
	    38h get next window
	    39h get memory page
	    3Ah request DMA
	    3Bh release DMA
	further details not yet available
Return: ??? = result code (see #0594)
SeeAlso: AH=AEh

(Table 0594)
Values for PCMCIA Card Services result codes:
 00h	successful
 01h	invalid adapter number
 02h	bad value for attribute field
 03h	bad value for base system memory address
 04h	invalid EDC generator specified
 05h	(reserved for historical reasons)
 06h	invalid IRQ level specified
 07h	invalid PC Card memory array offset
 08h	invalid page number specified
 09h	unable to complete read request
 0Ah	invalid size specified
 0Bh	invalid socket number
 0Ch	(reserved for historical reasons)
 0Dh	invalid window or interface type
 0Eh	invalid Vcc power level specified
 0Fh	invalid Vpp1 or Vpp2 power level specified
 10h	(reserved for historical reasons)
 11h	invalid window number
 12h	unable to complete write request
 13h	(reserved for historical reasons)
 14h	no PC Card in socket
 15h	service not supported by implementation
 16h	unsupported processor mode
 17h	specified speed not available
 18h	busy -- retry later
 19h	undefined error (general failure)
 1Ah	storage medium write protected
 1Bh	argument length in (E)CX is invalid
 1Ch	bad value(s) in argument packet
 1Dh	configuration has already been locked
 1Eh	requested resource already in use
 1Fh	no more items of requested type available
 20h	out of resources
 21h	invalid client handle
 22h	unsupported client version

(Table 0595)
Values for Card Services Callback Event codes:
 01h	battery dead
 02h	battery low
 03h	card locked
 04h	card has become ready
 05h	card removed
 06h	card unlocked
 07h	motorized ejection complete
 08h	ejection requested
 09h	insertion complete
 0Ah	insertion requested
 0Bh	power management: resume
 0Ch	power management: suspend
 0Dh	exclusive access granted
 0Eh	exclusive access requested
 0Fh	perform physical reset
 10h	physical reset requested
 11h	card has been reset
 12h	MTD request (read/write/etc)
 14h	request for client info
 15h	timer has expired
 16h	Socket Service was modified
 17h	write-protected
 18h	attention requested
 40h	card insertion
 80h	reset complete
 81h	erase complete
 82h	registration complete

Format of Card Services Information:
Offset	Size	Description	(Table 0596)
 00h	WORD	length of information record in bytes
 02h	WORD	signature
 04h	WORD	number of sockets
 06h	WORD	revision level
 08h	WORD	Card Services level
 0Ah	WORD	offset of vendor string
 0Ch	WORD	length of vendor string
 0Eh	WORD	number of functions
 10h 255 BYTEs	vendor string
SeeAlso: #0598

Format of Card Services Client structure:
Offset	Size	Description	(Table 0597)
 00h	WORD	PCMCIA socket number
 02h	WORD	client attributes

Format of Cards Services Client Information:
Offset	Size	Description	(Table 0598)
 00h	WORD	maximum length of data in bytes (180)
 02h	WORD	(ret) length of returned data
 04h	WORD	attributes (see #0599)
 06h	WORD	revision level (BCD)
 08h	WORD	Card Services level (BCD)
 0Ah	WORD	revision date (DOS packed date format) (see #1006)
 0Ch	WORD	offset to name
 0Eh	WORD	length of name
 10h	WORD	offset to vendor string
 12h	WORD	length of vendor string
 14h 80 BYTEs	buffer for name
 64h 80 BYTEs	buffer for vendor string
SeeAlso: #0596,#0600

Bitfields for Card Services client attributes:
Bit(s)	Description	(Table 0599)
 0	memory client
 1	MTD client
 2	I/O client
 3	all clients can share this card
 4	only one client can use this card at a time
SeeAlso: #0598

Format of Card Services configuration information:
Offset	Size	Description	(Table 0600)
 00h	WORD	socket (usually 0000h)
 02h	WORD	attributes (see #0601)
 04h	BYTE	Vcc value
 05h	BYTE	Vpp1 value
 06h	BYTE	Vpp2 value
 07h	BYTE	interface type (see #0602)
 08h	DWORD	base address of configuration registers
 0Ch	BYTE	card's Status register setting (if present)
 0Dh	BYTE	card's Pin register setting (if present)
 0Eh	BYTE	card's Socket/Copy register setting (if present)
 0Fh	BYTE	card's Option register setting (if present)
 10h	BYTE	bitmap of present card configuration registers
 11h	BYTE	first device type
 12h	BYTE	function code
 13h	BYTE	SysInit mask
 14h	WORD	manufacturer code
 16h	WORD	manufacturer information
 18h	BYTE	valie card register values
 19h	BYTE	IRQ number assigned to PC Card
 1Ah	WORD	IRQ attributes (see #0604)
 1Ch	WORD	base port address (for I/O range 1)
 1Eh	BYTE	number of contiguous ports (for I/O range 1)
 1Fh	BYTE	bitmap of port attributes (for I/O range 1) (see #0605)
 20h	WORD	base port address (for I/O range 2)
 22h	BYTE	number of contiguous ports (for I/O range 2)
 23h	BYTE	bitmap of port attributes (for I/O range 2) (see #0605)
 24h	BYTE	number of I/O address lines decoded (16-bit PC Card only)
 25h	BYTE	extended status register setting (if present)
 26h	BYTE	bitmap of DMA attributes (see #0606)
		(note: value at call is used to set!)
 27h	BYTE	assigned DMA channel
 28h	BYTE	number of I/O windows in use on logical socket
 29h	BYTE	number of memory windows in use on logical socket
SeeAlso: #0599,#0620

Bitfields for Card Services Configuration attributes:
Bit(s)	Description	(Table 0601)
 0	exclusive
 1	IRQ active
 2	CardBus card
 3-5	reserved (0)
 6	DMA channel is active
 7	reserved (0)
 8	valid client
 9	overwrite voltage value
 10-15	reserved (0)
SeeAlso: #0600

Bitfields for Card Services Configuration interface type:
Bit(s)	Description	(Table 0602)
 0	memory interface
 1	I/O and memory interface
 2	CardBus interface
 3-7	reserved (0)
SeeAlso: #0600

Bitfields for Card Services Configuration registers:
Bit(s)	Description	(Table 0603)
 0	option value is value
 1	status value
 2	pin-replacement value
 3	copy value
 4	extended status value
 5-7	reserved (0)
SeeAlso: #0600

Bitfields for Card Services Configuration IRQ attributes:
Bit(s)	Description	(Table 0604)
 1-0	sharing
	00 no sharing
	01 time-multiplex sharing
	10 dynamic sharing
	11 reserved
 2	force pulse mode
 3	first used together
 4-7	reserved
 8	pulse IRQ has been assigned
 9-15	reserved
SeeAlso: #0600,#0605,#0606,#0611,#0614

Bitfields for Card Services Configuration Port attributes:
Bit(s)	Description	(Table 0605)
 0	shared I/O ports
 1	"CS_FirstCommonUsedCard"
 2	force alias access
 3	=1 sixteen-bit I/O
	=0 eight-bit I/O
 7-4	reserved (0)
SeeAlso: #0600,#0604,#0606,#0613

Bitfields for Card Services Configuration DMA attributes:
Bit(s)	Description	(Table 0606)
 1-0	sharing mode
	00 no sharing
	01 time-multiplex sharing
	10 dynamic sharing
	11 reserved
 3-2	DMA request signal
	00 reserved
	01 DMARQ uses pin SPKR#
	10 DMARQ uses pin IOIS16#
	11 DMARQ uses pin INPACK#
 4	DMA size
	0 eight bits
	1 sixteen bits
 7-5	reserved (0)
SeeAlso: #0600,#0604,#0605

Format of Card Services Tuple information:
Offset	Size	Description	(Table 0607)
 00h	WORD	logical socket number
 02h	WORD	attributes
		bit 0: return Link tuples
 04h	BYTE	code value of desired tuple
 05h	BYTE	reserved (0)
 06h	WORD	(ret) TupleFlags
 08h	DWORD	(ret) -> Card Services Link State Information
 0Ch	DWORD	(ret) -> Card Services CIS State Information
 10h	BYTE	(ret) code for tuple
 11h	BYTE	(ret) link value for tuple
SeeAlso: #0608

Format of Card Services GetTupleData record:
Offset	Size	Description	(Table 0608)
 00h	WORD	logical socket
 02h	WORD	attributes
 04h	BYTE	code value of desired tuple
 05h	BYTE	offset into tuple from link byte
 06h	WORD	flags
 08h	DWORD	-> Link
 0Ch	DWORD	-> CIS
 10h	WORD	(call) maximum amount of data to return (0004h)
 12h	WORD	(ret) amount of data returned
 14h	DWORD	(ret) tuple data
SeeAlso: #0607

Format of Card Services Client Registration record:
Offset	Size	Description	(Table 0609)
 00h	WORD	attributes
 02h	WORD	event mask
 04h	WORD	client data (passed to client event handler in DI)
--- 16-bit code ---
 06h	WORD	client data selector (passed to event handler in DS)
 08h	WORD	client data offset (passed to event handler in SI)
 0Ah	WORD	reserved
--- 32-bit code ---
 06h	WORD	reserved
 08h	DWORD	client data offset (passed to event handler in ESI)
------
 0Ch	WORD	expected Card Services version (0210h for v2.10)

Bitfields for Card Services client event codes:
Bit(s)	Description	(Table 0610)
 0	change in write-protect status
 1	change in card lock
 2	ejection request
 3	insertion request
 4	battery is dead
 5	battery low
 6	change in Ready
 7	change in Card Detect
 8	power management change
 9	reset
 10	Socket Services updated
 11	extended status change
SeeAlso: #0609

Format of Card Services ReleaseIRQ record:
Offset	Size	Description	(Table 0611)
 00h	WORD	logical socket number
 02h	WORD	attributes (see #0604)
 04h	BYTE	assigned IRQ number to be released

Format of Card Services Release Configuration record:
Offset	Size	Description	(Table 0612)
 00h	WORD	logical socket number

Format of Card Services Request I/O record:
Offset	Size	Description	(Table 0613)
 00h	WORD	logical socket number
 02h	WORD	base port 1
 04h	BYTE	size of port range 1
 05h	BYTE	attributes for port range 1 (see #0605)
 06h	WORD	base port 2
 08h	BYTE	size of port range 2
 09h	BYTE	attributes for port range 2 (see #0605)
 0Ah	BYTE	number of address lines (typically 16)
SeeAlso: #0614,#0612

Format of Card Services Request IRQ record:
Offset	Size	Description	(Table 0614)
 00h	WORD	logical socket number
 02h	WORD	attributes (see #0604)
 04h	BYTE	(ret) assigned IRQ number, if successful
 05h	BYTE	IRQ info (see #0615)
 06h	WORD	bitmap of available IRQs (bit 0 = IRQ0, etc.)
		(only if bit 4 of IRQ info set)
SeeAlso: #0613,#0612

Bitfields for Card Services Request IRQ info flags:
Bit(s)	Description	(Table 0615)
 7	IRQ is shared
 6	pulse (edge-triggered) interrupt
 5	level interrupt
 4	use IRQ bitmap
--- bit 4 set ---
 3	vendor-specific interrupt
 2	bus error
 1	I/O check interrupt
 0	NMI
--- bit 4 clear ---
 3-0	IRQ number
SeeAlso: #0614

Format of Card Services Request Window record:
Offset	Size	Description	(Table 0616)
 00h	WORD	logical socket number
 02h	WORD	attributes (see #0617)
 04h	DWORD	system base adress
 08h	DWORD	size of memory window
 0Ch	BYTE	additional info
		if attributes bit ??? is set, this is the address-lines field
		otherwise, this is the access-speed field (see #0618)

Bitfields for Card Services Request Window attributes:
Bit(s)	Description	(Table 0617)
 0	I/O window instead of memory window
 1	attribute memory instead of normal memory (16-bit PC Cards only)
 2	window enabled
 3	16-bit data path instead of 8-bit path (16-bit PC Cards only, v2.10+)
	(ignored if bit 9 set)
 4	size is given in 16K pages (invalid for CardBus PC Cards)
 5	shared (invalid for CardBus)
 6	first shared (invalid for CardBus)
 7	"CS_BindingSpecific" (memory window only)
 8	card offsets are window-size granular (16-bit PC Card memory window)
 9	32-bit data path (CardBus only)
 10	reserved (0)
 12-11	prefetch/cache
	00 neither prefetchable nor cacheable
	01 prefetchable but not cacheable
	10 prefetchable and cachable
	11 reserved
 15-13	decoded base address register number (CardBus only)
SeeAlso: #0616,#0618

Bitfields for Card Services Request Window access-speed:
Bit(s)	Description	(Table 0618)
 6-3	mantissa
	0000 use device speed code
	0001  1.0
	0010  1.2
	0011  1.2 ???
	0100  1.5
	0101  2.0
	0110  2.5
	0111  3.0
	1000  3.5
	1001  4.0
	1010  4.5
	1011  5.0
	1100  5.5
	1101  6.0
	1110  7.0
	1111  8.0
--- if mantissa==0 ---
 2-0	device speed code
	000 reserved
	001 250 ns
	010 200 ns
	011 150 ns
	100 100 ns
	101-111 reserved
--- if mantissa<>0 ---
 2-0	speed exponent
	000	1 ns
	001    10 ns
	010   100 ns
	011	1 us
	100    10 us
	101   100 us
	110	1 ms
	111    10 ms
SeeAlso: #0616,#0617

Format of Card Services Request/Release Exclusive Access record:
Offset	Size	Description	(Table 0619)
 00h	WORD	logical socket number
 02h	WORD	attributes (currently all reserved, must be 0000h)

Format of Card Services Request Configuration record:
Offset	Size	Description	(Table 0620)
 00h	WORD	socket (usually 0000h)
 02h	WORD	attributes (see #0601)
 04h	BYTE	Vcc value
 05h	BYTE	Vpp1 value
 06h	BYTE	Vpp2 value
 07h	BYTE	interface type (see #0602)
 08h	DWORD	base address of configuration registers
 0Ch	BYTE	card's Status register setting (if present)
 0Dh	BYTE	card's Pin register setting (if present)
 0Eh	BYTE	card's Socket/Copy register setting (if present)
 0Fh	BYTE	card's Option register setting (if present)
 10h	BYTE	bitmap of present card configuration registers
 11h	BYTE	extended status register setting (if present)
SeeAlso: #0600
--------X-1AB000-----------------------------
INT 1A U - HP 100LX/200LX - PCMCIA - ???
	AX = B000h
	ES:BX -> parameter block ???
Return: CF clear if ???
	CF set if ???
Note:	called by HP 100LX/200LX PCMCIA client CIC100.EXE
--------d-1AB001CX4D52-----------------------
INT 1A - Microsoft Real-Time Compression Interface (MRCI) - ROM-BASED SERVER
	AX = B001h
	CX = 4D52h ("MR")
	DX = 4349h ("CI")
Return: CX = 4943h ("IC") if installed
	DX = 524Dh ("RM") if installed
	    ES:DI -> MRCINFO structure (see #0621)
Note:	this call is functionally identical to INT 2F/AX=4A12h, which should
	  be called first, as this call is used for the first, ROM-based
	  MRCI server, while the other call is used for RAM-based servers
	  which may be partially or entirely replacing a prior server
SeeAlso: INT 2F/AX=4A12h

Format of MRCINFO structure:
Offset	Size	Description	(Table 0621)
 00h  4 BYTEs	vendor signature
		"MSFT" Microsoft
 04h	WORD	server version (high=major)
 06h	WORD	MRCI specification version
 08h	DWORD	address of server entry point (see #0623)
 0Ch	WORD	bit flags: server capabilities (see #0622)
 0Eh	WORD	bit flags: hardware assisted capabilities (see #0622)
 10h	WORD	maximum block size supported by server (at least 8192 bytes)

Bitfields for MRCI capabilities:
Bit(s)	Description	(Table 0622)
 0	standard compress
 1	standard decompress
 2	update compress
 3	MaxCompress (not present in initial public release)
 4	reserved
 5	incremental decompress
 6	MRCI 2.0 standard compress
 7	MRCI 2.0 standard decompress
 8-14	reserved
 15	this structure is in ROM and can't be modified
	(server capabilities only)

(Table 0623)
Call MRCI entry point with:
	DS:SI -> MRCREQUEST structure (see #0624)
	CX = type of client (0000h application, 0001h file system)
	AX = operation
	    0001h perform standard compression
	    0002h perform standard decompression
	    0004h perform update compression
	    0008h perform MaxCompress
	    0020h perform incremental decompression
	    0040h perform MRCI 2.0 standard compression
	    0080h perform MRCI 2.0 standard decompression
	AX = FFFFh clear flags
	    BX = bitmask of flags to clear (set bits in BX are flags to clear)
Return: AX = status
	    0000h successful
	    0001h invalid function
	    0002h server busy, try again
	    0003h destination buffer too small
	    0004h incompressible data
	    0005h bad compressed data format
	BP destroyed (MS-DOS 6.2)
Note:	MRCI driver may chain to a previous driver

Format of MRCREQUEST structure:
Offset	Size	Description	(Table 0624)
 00h	DWORD	pointer to source buffer
 04h	WORD	size of source buffer (0000h = 64K)
 06h	WORD	(UpdateCompress only)
		(call) offset in source buffer of beginning of changed data
		(ret) offset in destination buffer of beginning of changed
			  compressed data
 08h	DWORD	pointer to destination buffer
		must contain original compressed data for UpdateCompress
 0Ch	WORD	size of destination buffer (0000h = 64K)
		any compression: size of buffer for compressed data
		standard decompression: number of bytes to be decompressed
		incremental decompression: number of byte to decompress now
		(ret) actual size of resulting data
 0Eh	WORD	client compressed data storage allocation size
 10h	DWORD	incremental decompression state data
		set to 00000000h before first incremental decompression call
Notes:	the source and destination buffers may not overlap
	the source and destination buffer sizes should normally be the same
	application should not update the contents of the MRCREQUEST structure
	  between incremental decompression calls
--------X-1AB101-----------------------------
INT 1A - Intel PCI BIOS v2.0c - INSTALLATION CHECK
	AX = B101h
Return: AH = 00h if installed
	    CF clear
	    EDX = 20494350h (' ICP')
	    EDI = physical address of protected-mode entry point (see #0627)
	    AL = PCI hardware characteristics (see #0626)
	    BH = PCI interface level major version (BCD)
	    BL = PCI interface level minor version (BCD)
	    CL = number of last PCI bus in system
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Note:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
SeeAlso: AX=B181h

(Table 0625)
Values for PCI BIOS v2.0c status codes:
 00h	successful
 81h	unsupported function
 83h	bad vendor ID
 86h	device not found
 87h	bad PCI register number

Bitfields for PCI hardware characteristics:
Bit(s)	Description	(Table 0626)
 0	configuration space access mechanism 1 supported
 1	configuration space access mechanism 2 supported
 2-3	reserved
 4	Special Cycle generation mechanism 1 supported
 5	Special Cycle generation mechanism 2 supported
 6-7	reserved

(Table 0627)
Call protected-mode entry point with:
	registers as for real/V86-mode INT call
	CS = ring 0 descriptor with access to full address space
Return: as for real/V86-mode call
--------X-1AB102-----------------------------
INT 1A - Intel PCI BIOS v2.0c - FIND PCI DEVICE
	AX = B102h
	CX = device ID
	DX = vendor ID
	SI = device index (0-n)
Return: CF clear if successful
	CF set on error
	AH = status (00h,83h,86h) (see #0625)
	    00h successful
		BH = bus number
		BL = device/function number (bits 7-3 device, bits 2-0 func)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	device ID FFFFh may be reserved as a wildcard in future implementations
	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
	all devices sharing a single vendor ID and device ID may be enumerated
	  by incrementing SI from 0 until error 86h is returned
SeeAlso: AX=B182h
--------X-1AB103-----------------------------
INT 1A - Intel PCI BIOS v2.0c - FIND PCI CLASS CODE
	AX = B103h
	ECX = class code (see also #F057,#0628)
	    bits 31-24 unused
	    bits 23-16 class
	    bits 15-8  subclass
	    bits 7-0   programming interface
	SI = device index (0-n)
Return: CF clear if successful
	CF set on error
	AH = status (00h,86h) (see #0625)
	    00h successful
		BH = bus number
		BL = device/function number (bits 7-3 device, bits 2-0 func)
	    86h device not found
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
	all devices sharing the same Class Code may be enumerated by
	  incrementing SI from 0 until error 86h is returned
SeeAlso: AX=B183h
--------X-1AB106-----------------------------
INT 1A - Intel PCI BIOS v2.0c - PCI BUS-SPECIFIC OPERATIONS
	AX = B106h
	BL = bus number
	EDX = Special Cycle data
Return: CF clear if successful
	CF set on error
	AH = status (00h,81h) (see #0625)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Note:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
SeeAlso: AX=B186h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB108-----------------------------
INT 1A - Intel PCI BIOS v2.0c - READ CONFIGURATION BYTE
	AX = B108h
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	BH = bus number
	DI = register number (0000h-00FFh) (see #0628)
Return: CF clear if successful
	    CL = byte read
	CF set on error
	AH = status (00h,87h) (see #0625)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B109h,AX=B10Ah,AX=B188h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB109-----------------------------
INT 1A - Intel PCI BIOS v2.0c - READ CONFIGURATION WORD
	AX = B109h
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	BH = bus number
	DI = register number (0000h-00FFh) (see #0628)
Return: CF clear if successful
	    CX = word read
	CF set on error
	AH = status (00h,87h) (see #0625)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B108h,AX=B10Ah,AX=B189h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10A-----------------------------
INT 1A - Intel PCI BIOS v2.0c - READ CONFIGURATION DWORD
	AX = B10Ah
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #0628)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #0625)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B108h,AX=B109h,AX=B18Ah,INT 2F/AX=1684h/BX=304Ch

Format of PCI Configuration Data:
Offset	Size	Description	(Table 0628)
 00h	WORD	vendor ID (read-only) (see #0629)
		FFFFh returned if requested device non-existent
 02h	WORD	device ID (read-only)
 04h	WORD	command register (see #0630)
 06h	WORD	status register (see #0631)
 08h	BYTE	revision ID
 09h  3 BYTEs	class code
		bits 7-0: programming interface
		bits 15-8: sub-class
		bits 23-16: class code (see also #F057)
 0Ch	BYTE	cache line size
 0Dh	BYTE	latency timer
 0Eh	BYTE	header type
		bits 6-0: header format
			00h other
			01h PCI-to-PCI bridge
			02h PCI-to-CardBus bridge
		bit 7: multi-function device
 0Fh	BYTE	Built-In Self-Test result (see #0632)
---header type 00h---
 10h	DWORD	base address 0 (see #0633)
		(OpenHCI) base address of host controller registers (see #3330)
 14h	DWORD	base address 1
 18h	DWORD	base address 2
 1Ch	DWORD	base address 3
 20h	DWORD	base address 4
 24h	DWORD	base address 5
 28h	DWORD	CardBus CIS pointer (read-only) (see #0635)
 2Ch	WORD	subsystem vendor ID or 0000h
 2Eh	WORD	subsystem ID or 0000h
 30h	DWORD	expansion ROM base address (see #0634)
 34h	BYTE	offset of capabilities list within configuration space (R/O)
		(only valid if status register bit 4 set) (see #3325)
 35h  3 BYTEs	reserved
 38h	DWORD	reserved
 3Ch	BYTE	interrupt line
		00h = none, 01h = IRQ1 to 0Fh = IRQ15
 3Dh	BYTE	interrupt pin (read-only)
		(00h = none, else indicates INTA# to INTD#)
 3Eh	BYTE	minimum time bus master needs PCI bus ownership, in 250ns units
		(read-only)
 3Fh	BYTE	maximum latency, in 250ns units (bus masters only) (read-only)
 40h 48 DWORDs	varies by device (see #0638,#0639,#0640,#0643)
---header type 01h---
 10h	DWORD	base address 0 (see #0633)
 14h	DWORD	base address 1
 18h	BYTE	primary bus number (for bus closer to host processor)
 19h	BYTE	secondary bus number (for bus further from host processor)
 1Ah	BYTE	subordinate bus number
 1Bh	BYTE	secondary latency timer
 1Ch	BYTE	I/O base (see #0636)
 1Dh	BYTE	I/O limit (see #0636)
 1Eh	WORD	secondary status
 20h	WORD	memory base (see #0637)
 22h	WORD	memory limit
 24h	WORD	prefetchable memory base
 26h	WORD	prefetchable memory limit
 28h	DWORD	prefetchable base, upper 32 bits
 2Ch	DWORD	prefetchable limit, upper 32 bits
 30h	WORD	I/O base, upper 16 bits
 32h	WORD	I/O limit, upper 16 bits
 34h	DWORD	reserved
 38h	DWORD	expansion ROM base address
 3Ch	BYTE	interrupt line
 3Dh	BYTE	interrupt pin (read-only)
 3Eh	WORD	bridge control
 40h 48 DWORDs	varies by device (see #0638,#0639,#0640,#0643)
---header type 02h---
 10h	DWORD	CardBus Socket/ExCa base address (see #3309)
		bits 31-12: start address of socket interface register block
			  in 4K blocks
		bits 11-0: reserved (0)
 14h	BYTE	offset of capabilities list within configuration space (R/O)
		(only valid if status register bit 4 set) (see #3325)
 15h	BYTE	reserved
 16h	WORD	secondary status
 18h	BYTE	PCI bus number
 19h	BYTE	CardBus bus number
 1Ah	BYTE	subordinate bus number
 1Bh	BYTE	CardBus latency timer
 1Ch	DWORD	memory base address 0
 20h	DWORD	memory limit 0
 24h	DWORD	memory base address 1
 28h	DWORD	memory limit 1
 2Ch	WORD	I/O base address 0
 2Eh	WORD	I/O base address 0 high word (optional)
 30h	WORD	I/O limit 0
 32h	WORD	I/O limit 0 high word (optional)
 34h	WORD	I/O base address 1
 36h	WORD	I/O base address 1 high word (optional)
 38h	WORD	I/O limit 1
 3Ah	WORD	I/O limit 1 high word (optional)
 3Ch	BYTE	interrupt line
 3Dh	BYTE	interrupt pin (read-only) (no interrupt used if 00h)
 3Eh	WORD	bridge control
 40h	WORD	subsystem vendor ID
 42h	WORD	subsystem device ID
 44h	DWORD	16-bit PC Card legacy mode base address (for accessing ExCa
		  registers)
 48h 14 DWORDs	reserved
 80h 32 DWORDs	varies by device (see #0638,#0639,#0640,#0643)

(Table 0629)
Values for PCI vendor ID:
 003Dh	Martin-Marietta Corporation
 0E11h	Compaq
 1000h	Symbios Logic Inc (formerly NCR)
 1002h	ATI (see #3444)
 1003h	ULSI Systems
 1004h	VLSI Technologies
 1005h	Avance Logics (ADL)
 1006h	Reply Group
 1007h	Netframe Systems Inc.
 1008h	Epson
 100Ah	Phoenix Technologies
 100Bh	National Semiconductor
 100Ch	Tseng Labs (see #3443) (also ID 10BEh)
 100Dh	AST Research
 100Eh	Weitek
 1010h	Video Logic Ltd
 1011h	DEC (see #3442)
 1012h	Micronics Computers
 1013h	Cirrus Logic (see #3440,#0028)
 1014h	IBM
 1015h	LSI Logic Corp. of Canada
 1016h	ICL Personal Systems
 1017h	SPEA Software AG
 1018h	Unisys
 1019h	EliteGroup Computer Sys
 101Ah	NCR/AT&T GIS
 101Bh	Vitesse Semiconductor
 101Ch	Western Digital
 101Eh	AMI
 101Fh	Picturetel
 1020h	Hitachi Computer Electronics
 1021h	Oki Electric Industry
 1022h	Advanced Micro Devices (see #3439)
 1023h	Trident Microsystems (see #3441)
 1024h	Zenith Data Systems
 1025h	Acer
 1028h	Dell Computer Corporation
 1029h	Siemens Nixdorf
 102Ah	LSI Logic, Headland Division
 102Bh	Matrox
 102Ch	Chips & Technologies
 102Dh	Wyse Technologies
 102Eh	Olivetti Advanced Technology
 102Fh	Toshiba America
 1030h	TMC Research
 1031h	Miro / Micro Computer Products AG
 1032h	Compaq
 1033h	NEC Corporation
 1034h	Burndy Corporation
 1035h	Computers and Communications Research Lab
 1036h	Future Domain
 1037h	Hitachi Micro Systems
 1038h	AMP Incorporated
 1039h	Silicon Integrated System (SIS)
 103Ah	Seiko Epson Corporation
 103Bh	Tatung Corp. of America
 103Ch	Hewlett-Packard
 103Eh	Solliday
 103Fh	Logic Modeling
 1040h	Kubota Pacific
 1041h	Computrend
 1042h	PC Technology (see also PORT 03F0h"PCTech")
 1043h	Asustek
 1044h	Distributed Processing Technology (DPT)
 1045h	OPTi (see #3445)
 1046h	IPC Corporation, Ltd.
 1047h	Genoa Systems Corp.
 1048h	Elsa GmbH
 1049h	Fountain Technology
 104Ah	SGS Thomson Microelectric
 104Bh	BusLogic
 104Ch	Texas Instruments
 104Dh	Sony Corporation
 104Eh	Oak Technology
 104Fh	Co-Time Computer Ltd.
 1050h	Winbond
 1051h	Anigma Corp.
 1052h	Young Micro Systems
 1054h	Hitachi, Ltd.
 1055h	EFAR Microsystems
 1056h	ICL
 1057h	Motorola
 1058h	Electronics and Telecommunications Research
 1059h	Teknor Microsystems
 105Ah	Promise Technology
 105Bh	Foxconn International
 105Ch	Wipro Infotech Ltd.
 105Dh	Number 9 Computer Company
 105Eh	VTech Engineering Canada, Ltd.
 105Fh	Infotronic America, Inc.
 1060h	United Microelectronics (UMC)
 1061h	8x8 (X Tech)
 1062h	Maspar Computer Copr.
 1063h	Ocean Office Automation
 1064h	Alcatel Cit
 1065h	Texas Microsystems
 1066h	PicoPower Technology
 1067h	Mitsubishi Electronics
 1068h	Diversified Technology
 1069h	Mylex Corporation
 106Ah	Aten Research
 106Bh	Apple Computer
 106Ch	Hyundai Electronics America
 106Dh	Sequent
 106Eh	DFI Inc.
 106Fh	City Gate Development, Ltd.
 1070h	Daewoo Telecom Ltd.
 1071h	Mitac
 1072h	GIT Co., Ltd.
 1073h	Yamaha Corporation
 1074h	NexGen Microsystems
 1075h	Advanced Integration Research
 1076h	Chaintech Computer Co. Ltd.
 1077h	Q Logic
 1078h	Cyrix Corporation
 1079h	I-Bus
 107Ah	Networth
 107Bh	Gateway 2000
 107Ch	Goldstar Co. Ltd.
 107Dh	Leadtek Research
 107Eh	Interphase Corporation
 107Fh	Data Technology Corporation (DTC)
 1080h	Contaq Microsystems
 1081h	Supermac Technology
 1082h	EFA Corporation of America
 1083h	Forex Computer Corporation
 1084h	Parador
 1085h	Tulip Computers Int'l BV
 1086h	J. Bond Computer Systems
 1087h	Cache Computer
 1088h	Microcomputer Systems (M) Son
 1089h	Data General Corporation
 108Ah	Bit3 Computer
 108Ch	Elonex PLC (Oakleigh Systems, Inc)
 108Dh	Olicom
 108Eh	Sun Microsystems
 108Fh	Systemsoft Corporation
 1090h	Encore Computer Corporation
 1091h	Intergraph Corporation
 1092h	Diamond Computer Systems
 1093h	National Instruments
 1094h	First International Computers (FIC)
 1095h	CMD Technology, Inc.
 1096h	Alacron
 1097h	Appian Technology
 1098h	Vision / Quantum Designs Ltd
 1099h	Samsung Electronics Co. Ltd.
 109Ah	Packard Bell
 109Bh	Gemlight Computer Ltd.
 109Ch	Megachips Corporation
 109Dh	Zida Technologies
 109Eh	Brooktree Corporation
 109Fh	Trigem Computer Inc.
 10A0h	Meidensha Corporation
 10A1h	Juko Electronics Inc. Ltd.
 10A2h	Quantum Corporation
 10A3h	Everex Systems Inc.
 10A4h	Globe Manufacturing Sales
 10A5h	Racal Interlan
 10A6h	Informtech Industrial Ltd.
 10A7h	Benchmarq Microelectronics
 10A8h	Sierra Semiconductor
 10A9h	Silicon Graphics
 10AAh	ACC Microelectronics
 10ABh	Digicom
 10ACh	Honeywell IASD
 10ADh	Symphony Labs
 10AEh	Cornerstone Technology
 10AFh	Microcomputer Systems
 10B0h	CardExpert Technology
 10B1h	Cabletron Systems, Inc.
 10B2h	Raytheon Company
 10B3h	Databook Inc
 10B4h	STB Systems
 10B5h	PLX Technology
 10B7h	3com Corporation
 10B8h	Standard Microsystems Corporation (SMC)
 10B9h	Acer Labs Inc.
 10BAh	Mitsubishi Electronics Corp.
 10BBh	Dapha Electronics Corporation
 10BCh	Advanced Logic Research Inc. (ALR)
 10BDh	Surecom Technology
 10BEh	Tseng Labs International Corp. (see #3443)
 10BFh	Most Inc.
 10C0h	Boca Research Inc.
 10C1h	ICM Corp. Ltd.
 10C2h	Auspex Systems Inc.
 10C3h	Samsung Semiconductors
 10C4h	Award Software International Inc.
 10C5h	Xerox Corporation
 10C6h	Rambus Inc.
 10C7h	Media Vision
 10C8h	Neomagic Corporation
 10C9h	DataExpert Corporation
 10CAh	Fujitsu
 10CBh	Omron Corporation
 10CCh	Mentor Arc Inc.
 10CDh	Advanced System Products
 10CEh	Radius Inc.
 10CFh	Citicorp TTI
 10D0h	Fujitsu Limited
 10D1h	Future+ Systems
 10D2h	Molex Incorporated
 10D3h	Jabil Circuit Inc.
 10D4h	Hualon Microelectronics
 10D5h	Autologic Inc.
 10D6h	Cetia
 10D7h	BCM Advanced Research
 10D8h	Advanced Peripherals Labs
 10D9h	Macronix International Co. Ltd
 10DAh	Thomas-Conrad Corporation
 10DBh	Rohm Research
 10DCh	CERN/ECP/EDU
 10DDh	Evans & Sutherland
 10DEh	NVidia Corporation
 10DFh	Emulex Corporation
 10E0h	Integrated Micro Solutions (IMS)
 10E1h	TekRAM Technology Corporation Ltd.
 10E2h	Aptix Corporation
 10E3h	Newbridge Microsystems
 10E4h	Tandem Computers
 10E5h	Micro Industries
 10E6h	Gainbery Computer Products Inc.
 10E7h	Vadem
 10E8h	Applied Micro Circuits Corp.
 10E9h	Alps Electronic Corp. Ltd.
 10EAh	Integraphics Systems
 10EBh	Artist Graphics
 10ECh	Realtek Semiconductor
 10EDh	ASCII Corporation
 10EEh	Xilinx Corporation
 10EFh	Racore Computer Products
 10F0h	Peritek Corporation
 10F1h	Tyan Computer
 10F2h	Achme Computer Inc.
 10F3h	Alaris Inc.
 10F4h	S-MOS Systems
 10F5h	NKK Corporation
 10F6h	Creative Electronic Systems SA
 10F7h	Matsushita Electric Industrial Corp. Ltd.
 10F8h	Altos India Ltd.
 10F9h	PC Direct
 10FAh	Truevision
 10FBh	Thesys Microelectronics
 10FCh	I/O Data Device Inc.
 10FDh	Soyo Technology Corp. Ltd.
 10FEh	Fast Electronic GmbH
 10FFh	N-Cube
 1100h	Jazz Multimedia
 1101h	Initio Corporation
 1102h	Creative Labs
 1103h	Triones Technologies Inc.
 1104h	Rasterops
 1105h	Sigma Designs, Inc.
 1106h	VIA Technologies
 1107h	Stratus Computer
 1108h	Proteon Inc.
 1109h	Cogent Data Technologies
 110Ah	Siemens AG / Siemens Nixdorf AG
 110Bh	Xenon Microsystems
 110Ch	Mini-Max Technology Inc.
 110Dh	ZNyX Corporation
 110Eh	CPU Technology
 110Fh	Ross Technology
 1110h	Powerhouse Systems
 1111h	Santa Cruz Operation (SCO)
 1112h	Rockwell / RNS division of Meret Communications Inc.
 1113h	Accton Technology Corporation
 1114h	Atmel Corporation
 1115h	DuPont Pixel Systems
 1116h	Data Translation
 1117h	Datacube Inc.
 1118h	Berg Electronics
 1119h	Vortex Computersysteme GmbH
 111Ah	Efficient Networks, Inc.
 111Bh	Teledyne Electronic Systems
 111Ch	Tricord Systems, Inc.
 111Dh	Integrated Device Technology
 111Eh	Eldec Corporation
 111Fh	Precision Digital Images
 1120h	EMC Corporation
 1121h	Zilog
 1122h	Multi-tech Systems, Inc.
 1124h	Leutron Vision AG
 1125h	Eurocore
 1126h	Vigra
 1127h	FORE Systems
 1128h	???
 1129h	Firmworks
 112Ah	Hermes Electronics Co.
 112Bh	Linotype - Hell AG
 112Dh	Ravicad
 112Eh	Infomedia MicroElectronics Inc
 112Fh	Imaging Technology
 1130h	Computervision
 1131h	Philips Semiconductors
 1132h	Mitel Corp
 1133h	Eicon Technology Corporation
 1134h	Mercury Computer Systems Inc
 1135h	Fuji Xerox Co Ltd
 1136h	Momentum Data Systems
 1137h	Cisco Systems Inc
 1138h	Ziatech Corporation
 1139h	Dynamic Pictures Inc
 113Ah	FWB Inc
 113Ch	Cyclone Microsystems
 113Dh	Leading Edge Products Inc
 113Eh	Sanyo Electric Co
 113Fh	Equinox Systems
 1140h	Intervoice Inc
 1141h	Crest Microsystem Inc
 1142h	Alliance Semiconductor Corp
 1143h	Netpower, Inc.
 1144h	Cincinnati Milacron
 1145h	Workbit Corp
 1146h	Force Computers
 1147h	Interface Corp.
 1148h	Schneider & Koch Co.
 1149h	Win System Corporation
 114Ah	VMIC
 114Bh	Canopus Co.
 114Ch	Annabooks
 114Dh	IC Corporation
 114Eh	Nikon Systems Inc
 114Fh	Digi International / Stargate
 1150h	Thinking Machines Corp.
 1151h	JAE Electronics Inc.
 1152h	Megatek
 1153h	Land Win Electronic Corp.
 1154h	Melco Inc.
 1155h	Pine Technology Ltd.
 1156h	Periscope Engineering
 1157h	Avsys Corporation
 1158h	Voarx R&D Inc.
 1159h	MuTech
 115Ah	Harleguin Ltd.
 115Bh	Parallax Graphics
 115Ch	???
 115Dh	Xircom
 115Eh	Peer Protocols Inc.
 115Fh	???
 1160h	Megasoft Inc.
 1161h	PFU Ltd.
 1162h	OA Laboratory Co Ltd.
 1163h	???
 1164h	Advanced Peripherals Tech
 1165h	Imagraph Corporation
 1166h	Pequr Technology Inc.
 1167h	Mutoh Industries, Inc.
 1168h	Thine Electronics Inc
 1169h	???
 116Ah	Polaris Communications
 116Bh	Connectware Inc
 116Ch	???
 116Dh	???
 116Eh	???
 116Fh	Workstation Technology
 1170h	Inventec Corporation
 1171h	Loughborough Sound Images
 1172h	Altera Corporation
 1173h	Adobe Systems
 1174h	Bridgeport Machines
 1175h	Mitron Computer Inc.
 1176h	SBE
 1177h	Silicon Engineering
 1178h	Alfa Inc
 1179h	Toshiba America Info Systems
 117Ah	A-Trend Technology
 117Bh	???
 117Ch	Atto Technology
 117Dh	???
 117Eh	T/R Systems
 117Fh	???
 1180h	Ricoh Co Ltd
 1181h	Telmatics International
 1182h	???
 1183h	Fujikura Ltd
 1184h	Forks Inc
 1185h	Dataworld
 1186h	D-Link System Inc
 1187h	Advanced Technology Laboratories
 1188h	Shima Seiki Manufacturing Ltd.
 1189h	Matsushita Electronics
 118Ah	Hilevel Technology
 118Bh	???
 118Ch	Corollary Inc
 118Dh	BitFlow Inc
 118Eh	Hermstedt GmbH
 118Fh	???
 1190h	???
 1191h	Artop Electric
 1192h	Densan Co. Ltd
 1193h	Zeitnet Inc.
 1194h	Toucan Technology
 1195h	Ratoc System Inc
 1196h	Hytec Electronics Ltd
 1197h	Gage Applied Sciences Inc.
 1198h	Lambda Systems Inc
 1199h	Digital Communications Associates Inc,
 119Ah	Mind Share Inc.
 119Bh	Omega Micro Inc.
 119Ch	Information Technology Inst.
 119Dh	Bug Sapporo Japan
 119Eh	Fujitsu
 119Fh	Bull Hn Information Systems
 11A0h	Convex Computer Corporation
 11A1h	Hamamatsu Photonics K.K.
 11A2h	Sierra Research and Technology
 11A4h	Barco
 11A5h	MicroUnity Systems Engineering, Inc.
 11A6h	Pure Data
 11A7h	Power Computing Corp.
 11A9h	InnoSys Inc.
 11AAh	Actel
 11ABh	Galileo Technology Ltd.
 11ACh	Canon Information Systems
 11ADh	Lite-On Communications Inc
 11AEh	Scitex Corporation Ltd
 11AFh	Pro-Log Corporation
 11B0h	V3 Semiconductor Inc.
 11B1h	Apricot Computers
 11B2h	Eastman Kodak
 11B3h	Barr Systems Inc.
 11B4h	Leitch Technology International
 11B5h	Radstone Technology Plc
 11B6h	United Video Corp
 11B7h	Motorola
 11B8h	Xpoint Technologies Inc
 11B9h	Pathlight Technology Inc.
 11BAh	Videotron Corp
 11BBh	Pyramid Technology
 11BCh	Network Peripherals Inc
 11BDh	Pinnacle Systems Inc.
 11BEh	International Microcircuits Inc
 11C3h	NEC Corporation
 11C4h	Document Technologies Ind.
 11C5h	Shiva Corporatin
 11C7h	D.C.M. Data Systems
 11C8h	Dolphin Interconnect Solutions
 11C9h	MAGMA
 11CAh	LSI Systems Inc
 11CBh	Specialix Research Ltd.
 11CCh	Michels & Kleberhoff Computer GmbH
 11CDh	HAL Computer Systems Inc.
 11DEh	Zoran Corporation
 11F8h	PMC-Sierra Inc.
 120Eh	Cyclades
 1220h	Ariel Corporation
 122Dh	Aztech Systems Ltd
 1239h	The 3DO Company
 124Dh	Stallion Technologies
 1254h	Linear Systems Ltd.
 125Ch	Aurora Technologies, Inc.
 1275h	Network Appliance
 127Ah	Rockwell Semiconductor Systems
 1296h	Kofax Image Products
 12C5h	Picture Elements, Inc.
 1C1Ch	Symphony
 1DE1h	TekRAM
 3D3Dh	3DLabs
 4005h	Avance Logic, Inc.
 4B10h	Buslogic Inc.
 5333h	S3 (see also #3307)
 5700h	Netpower
 6374h	c't Magazin fuer Computertechnik
 8008h	Quanc?m Electronic GmbH
 8086h	Intel (see also #3308)
 8800h	Trigem Computer
 8E0Eh	Computone Corporation
 9004h	Adaptec (see #3446)
 907Fh	Atronics
 EDD8h	Ark Logic Inc
SeeAlso: #0628

(Table 3444)
Values for ATI PCI device code:
 4158h	68800AX (Mach32)
 4354h	215CT222
 4358h	210888CX
 4758h	210888GX (Mach64)
SeeAlso: #0629

(Table 3442)
Values for DEC PCI device code:
 0001h	DEC BRD
 0002h	Tulip
 0009h	Tulip Fast
 000Fh	FDDI
 0014h	Tulip Plus
SeeAlso: #0629

(Table 3440)
Values for Cirrus Logic PCI device code:
 00A0h	Cirrus 5430
 00A4h	Cirrus 5434-4
 00A8h	Cirrus 5434-8
 1100h	Cirrus 6729
 1200h	Cirrus 7542
SeeAlso: #0629

(Table 3439)
Values for Advanced Micro Devices PCI device code:
 2000h	Am79C970 (Lance), Am79C971 (PCnet-FAST, PCI revision ID is 2xh)
 2020h	Am53c974 SCSI
SeeAlso: #0629

(Table 3441)
Values for Trident PCI device code:
 9420h	Trident 9420
 9440h	Trident 9440
SeeAlso: #0629

(Table 3445)
Values for OPTi PCI device code:
 C557h	82C557
 C558h	82C558
 C621h	82C621
 C822h	82C822
SeeAlso: #0629

(Table 3443)
Values for Tseng Labs PCI device code:
 3202h	ET4000/W32p-2
 3205h	ET4000/W32p-B
 3206h	ET4000/W32p-C
 3207h	ET4000/W32p-D
SeeAlso: #0629

(Table 3307)
Values for S3 PCI device code:
 8811h	Trio64V+
 8880h	S3 868
 88B0h	S3 928
 88C0h	S3 864-1
 88C1h	S3 864-2
 88D0h	S3 964-1
 88D1h	S3 964-2
 88F0h	S3 968
SeeAlso: #0629,#3308

(Table 3308)
Values for Intel PCI device code:
 0122h	82437FX (typo in docs??? 122?h instead?)
 0482h	82375 EISA
 0483h	82424 Cache Controller
 0484h	82378/82379 Bus Interface (Mercury/Saturn/Neptune chipsets) (see #0642)
 0486h	82425EX/82430
 04A3h	82434 (Neptune) (see #0640)
 1223h	Intel 7116
 1227h	82865
 122Dh	82437 (Triton)
 122Eh	82371FB ISA Bridge (Triton)
 1230h	82338 IDE controller / 82371FB IDE function (Triton)
 1234h	82371MX
 1235h	82437MX
 1237h	82441FX (see #3424)
 1250h	82439HX (430HX chipset) (see #3407)
 7000h	82371SB ISA Bridge (see #3410)
 7010h	82371SB IDE controller (see #3411)
 7020h	82371SB (see #3414)
 7030h	82437VX (430VX chipset) (see #3392)
 84C4h	Pentium Pro CPU
SeeAlso: #0629,#3307

(Table 3446)
Values for Adaptec PCI device code:
 5078h	Adaptec 7850
 7078h	Adaptec 294x
 7178h	Adaptec 2940
 7278h	Adaptec 7872
SeeAlso: #0629

Bitfields for PCI Configuration Command Register:
Bit(s)	Description	(Table 0630)
 0	I/O access enabled
 1	memory access enabled
 2	bus master enable
 3	special cycle recognition enabled
 4	memory write and invalidate enabled
 5	VGA palette snoop enabled
 6	parity error response enabled
 7	wait cycles enabled
 8	system error (SERR# line) enabled
 9	fast back-to-back transactions enabled
 15-10	reserved
SeeAlso: #0628,#0631

Format of PCI Configuration Status Register:
Bit(s)	Description	(Table 0631)
 3-0	reserved (0)
 4	new capabilities list is present (first entry pointed at by byte at
	  34h or 14h)
 5	capable of running at 66 MHz
 6	UDF supported
 7	capable of fast back-to-back transactions
 8	data parity error reported
 10-9	device select timing
	00 fast
	01 medium
	10 slow
	11 reserved
 11	signaled target abort
 12	received target abort
 13	received master abort
 14	signaled system error (device is asserting SERR# line)
 15	detected parity error (set even if parity error reporting is disabled)
Note:	bits 12 and 13 are cleared by writing a 1 into the corresponding bit
SeeAlso: #0628,#0630

Bitfields for PCI Configuration Built-In Self-Test register:
Bit(s)	Description	(Table 0632)
 3-0	completion code (0000 = successful)
 5-4	reserved
 6	start BIST (set to one to start, cleared automatically on completion)
 7	BIST-capable
Notes:	this register is hardwired to 00h if no BIST capability
	software should timeout the BIST after two seconds
SeeAlso: #0628

Bitfields for PCI Configuration Base Address:
Bit(s)	Description	(Table 0633)
 0	address type (0 = memory space, 1 = I/O space)
---memory address---
 2-1	address type
	00 anywhere in first 4GB
	01 below 1MB
	10 anywhere in 64-bit address space
	11 reserved
 3	prefetchable
 31-4	bits 31-4 of base memory address if addressable in first 1MB or 4GB
 63-4	bits 63-4 of base memory address if addressable in 64-bit memory
	(bits 63-32 are stored in the following base address DWORD)
---I/O address---
 1	reserved
 31-2	bits 31-2 of base I/O port
SeeAlso: #0628,#3330

Bitfields for PCI Configuration Expansion ROM Address:
Bit(s)	Description	(Table 0634)
 0	address decode enable (ROM address is valid)
 10-1	reserved
 31-11	bits 31-11 of ROM's starting physical address
SeeAlso: #0628

Format of PCI Capabilities List:
Offset	Size	Description	(Table 3325)
 00h	BYTE	capability identifier
		01h PCI Power Managment
 01h	BYTE	offset of next item (within configuration space) or 00h
      N	BYTEs	varies by capability type
---PCI Power Management---
 02h	WORD	power managment capabilities (see #3326) (read-only)
 04h	WORD	power managment capabilities status register (see #3327)
 06h	BYTE	PMCSR bridge support extensions (see #3328)
 07h	BYTE	(optional) read-only data register (see #3329)
Note:	this information is from the v0.93 draft of the specification and is
	  subject to change
SeeAlso: #0628,#0631

Bitfields for PCI Power Management Capabilities:
Bit(s)	Description	(Table 3326)
 15	reserved (0)
 14-12	PME# support
	bit 12: PME# can be asserted from power state D0
	bit 13: PME# can be asserted from power state D1
	bit 14: PME# can be asserted from power state D2
 11	reserved (0)
 10	D2 power state supported
 9	D1 power state supported
 8	full-speed clock is required in state D0 for proper operation
	(if clear, device may be run at reduced clock except when actually
	  being accessed)
 7-6	dynamic clock control support
	00 not bridge, no dynamic clock control, or secondary bus' clock is
	      is tied to primary bus' clock
	01 bridge is capable of dynamic clock control
	10 reserved
	11 secondary bus has independent clock, but dynamic clock not supported
 5	device-specific initialization is required
 4-3	reserved (0)
 2-0	specification version
	001 = v1.0; four bytes of power management registers
Note:	this information is from the v0.93 draft of the specification and is
	  subject to change
SeeAlso: #3325,#3327,#3328

Bitfields for PCI Power Management Capabilities Status Register:
Bit(s)	Description	(Table 3327)
 15	PME status: if set, PME# is (or would be) asserted
	writing a 1 to this bit clears it
 14-13	(read-only) scale factor to apply to contents of Data register
	00 unknown (or unimplemented data)
	01 x0.1
	10 x0.01
	11 x0.001
 12-9	(read-write) data select (see #3329)
 8	(read-write) enable PME# assertion
 7-5	reserved (0)
 4	(read-write) enable dynamic data reporting
	when set, PME# is asserted whenever the value in the Data register
	  changes significantly
 3-2	reserved (0)
 1-0	(read-write) current power state
	00 = D0
	...
	11 = D3
Note:	this information is from the v0.93 draft of the specification and is
	  subject to change
SeeAlso: #3325,#3326,#3328

Bitfields for PCI Power Management PMCSR bridge support extension:
Bit(s)	Description	(Table 3328)
 7	(read-only) Bus Power Control Enable
 6	(read-only) Bus Power State B3 supported
 5	(read-only) Bus Power State B2 supported
 4	dynamic clock control enable
 3-0	reserved (0)
Note:	this information is from the v0.93 draft of the specification and is
	  subject to change
SeeAlso: #3325,#3326,#3327

(Table 3329)
Values for PCI Power Management Data Select:
 00h	D0-state power consumed in watts (+20%/-10%)
 01h	D1-state power consumed in watts (+20%/-10%)
 02h	D2-state power consumed in watts (+20%/-10%)
 03h	D3-state power consumed in watts (+20%/-10%)
 04h	D0-state power dissipated into chassis in watts
 05h	D1-state power dissipated into chassis in watts
 06h	D2-state power dissipated into chassis in watts
 07h	D3-state power dissipated into chassis in watts
 08h-0Fh reserved
SeeAlso: #3327

Bitfields for PCI Configuration CardBus CIS Pointer:
Bit(s)	Description	(Table 0635)
 2-0	address space
	000 in device's device-specific configuration space
	001 in memory pointed to by base address register 0
	...
	110 in memory pointed to by base address register 5
	111 in device's expansion ROM
 27-3	offset within address space defined by bits 2-0
 31-28	ROM image number
SeeAlso: #0628

Format of CardBus Socket/ExCA socket interface register space:
Offset	Size	Description	(Table 3309)
 00h	DWORD	Socket Event Register (see #3311)
 04h	DWORD	Socket Mask Register (see #3312)
 08h	DWORD	Socket Present State Register (see #3313)
 0Ch	DWORD	Socket Force Event Register (see #3314)
 10h	DWORD	Socket Control Register (see #3315)
 14h  3 DWORDs	reserved
 20h	DWORD	Socket Power Management Register
 90h	BYTE	(TI PCI1130) Retry Status Register
 91h	BYTE	(TI PCI1130) Card Control Register (see #3316)
 92h	BYTE	(TI PCI1130) Device Control Register (see #3317)
 93h	BYTE	(TI PCI1130) Buffer Control Register
800h 64+ BYTEs	ExCa Socket Interface Registers (see #3310)

Format of ExCa memory-mapped registers:
Offset	Size	Description	(Table 3310)
 00h	BYTE	identification and revision register
 01h	BYTE	interface status register
 02h	BYTE	power control register
 03h	BYTE	interrupt and general control
 04h	BYTE	card status change
 05h	BYTE	card status change interrupt configuration
 06h	BYTE	address window enable
 07h	BYTE	I/O window control register
 08h	WORD	I/O window 0 start address
 0Ah	WORD	I/O window 0 end address
 0Ch	WORD	I/O window 1 start address
 0Eh	WORD	I/O window 1 end address
 10h	WORD	memory window 0 start address
 12h	WORD	memory window 0 end address
 14h	WORD	memory window 0 offset address
 16h  2 BYTEs	user-defined
 18h	WORD	memory window 1 start address
 1Ah	WORD	memory window 1 end address
 1Ch	WORD	memory window 1 offset address
 1Eh	BYTE	user-defined
 1Fh	BYTE	reserved
 20h	WORD	memory window 2 start address
 22h	WORD	memory window 2 end address
 24h	WORD	memory window 2 offset address
 26h  2 BYTEs	user-defined
 28h	WORD	memory window 3 start address
 2Ah	WORD	memory window 3 end address
 2Ch	WORD	memory window 3 offset address
 2Eh  2 BYTEs	user-defined
 30h	WORD	memory window 4 start address
 32h	WORD	memory window 4 end address
 34h	WORD	memory window 4 offset address
 36h 10 BYTEs	user-defined
---optional---
 40h	BYTE	memory window 0 start address high byte
 41h	BYTE	memory window 1 start address high byte
 42h	BYTE	memory window 2 start address high byte
 43h	BYTE	memory window 3 start address high byte
 44h	BYTE	memory window 4 start address high byte
 45h-7FFh	user-defined
SeeAlso: #3309

Bitfields for CardBus Socket Event Register:
Bit(s)	Description	(Table 3311)
 0	CSTSCHG pin asserted (status change)
 1	CCD1# (card detect 1) changed state
 2	CCD2# (card detect 2) changed state
 3	interface power cycle completed
31-4	reserved (0)
Note:	the bits in this register are set by the bridge, and cleared by writing
	  a one into the bits one wishes to clear
SeeAlso: #3309,#3312,#3314

Bitfields for CardBus Socket Event Mask Register:
Bit(s)	Description	(Table 3312)
 0	write-protect (enable status-change interrupt on WriteProtect switch)
 1	ready mask (allow status-change interrupt on Ready line change)
 3-2	battery condition (allow status-change int on battery-condition change)
 4	general wakeup enabled
 5	binary audio mode enabled on CAUDIO pin
 6	Pulse Width Modulation enabled on CAUDIO pin
	(CAUDIO state undefined if both bits 5 and 6 set)
 13-7	reserved (0)
 14	Wakeup mask (enable wakeup events via status-change pin)
 15	enable card interrupts via CINT# pin and wakeup events
 31-16	reserved
SeeAlso: #3309,#3311,#3313

Bitfields for CardBus Socket Present State Register:
Bit(s)	Description	(Table 3313)
 0	CSTSCHG pin asserted (status change)
 1	CCD1# (card detect 1) changed state
 2	CCD2# (card detect 2) changed state
 3	interface power cycle completed
 4	16-bit PC card inserted
 5	CardBus card inserted
 6	card's interrupt pin asserted
 7	card inserted but type can not be determined
 8	data may have been lost due to abrupt card removal
 9	attempted to apply Vcc voltage not supported by the card
 10	card can accept Vcc = 5.0 volts
 11	card can accept Vcc = 3.3 volts
 12	card can accept Vcc = X.X volts
 13	card can accept Vcc = Y.Y volts
 27-14	reserved (0)
 28	socket can accept Vcc = 5.0 volts
 29	socket can accept Vcc = 3.3 volts
 30	socket can accept Vcc = X.X volts
 31	socket can accept Vcc = Y.Y volts
Note:	bits 0-3 may be cleared by writing a 1 into the respective bits
SeeAlso: #3309,#3311,#3312,#3315

Bitfields for CardBus Socket Force Event Register:
Bit(s)	Description	(Table 3314)
 0	write-protect
 1	ready
 2	battery voltage detect 2
 3	battery voltage detect 1
 4	general wakeup
 14-5	reserved (0)
 15	enable card interrupts via CINT# pin
 31-16	reserved
Note:	this register can simulate events by forcing the values of some of the
	  bits in the Event Mask Register; any bit of this register which is
	  set to 1 forces the corresponding bit in the Mask Register to 1,
	  while bits set to 0 leave the corresponding bit unchanged
SeeAlso: #3309,#3311,#3315

Bitfields for CardBus Socket Control Register:
Bit(s)	Description	(Table 3315)
 2-0	Vpp control
	000 power off
	001 12.0 Volts
	010 5.0 Volts
	011 3.3 Volts
	100 reserved (X.X Volts)
	101 reserved (Y.Y Volts)
	110 reserved
	111 reserved
 3	reserved (0)
 6-4	Vcc control (as for Vpp, but 12.0V not supported)
 31-7	reserved (0)
SeeAlso: #3309,#3312,#3314

Bitfields for TI PCI1130 Card Control Register:
Bit(s)	Description	(Table 3316)
 0	interrupt pending
 1	speaker output enabled
 2	reserved
 3	enable status-change interrupt routing (to INTA# for socket A, INTB#
	  for socket B)
 4	function interrupt routed to corresponding PCI interrupt pin
 5	PCI interrupts enabled
 6	ZOOM video mode enabled
 7	Ring Indicator enabled on IRQ15/RI_OUT pin
SeeAlso: #3309,#3317

Bitfields for TI PCI1130 Device Control Register:
Bit(s)	Description	(Table 3317)
 0	reserved (0)
 2-1	interrupt mode enable
	00 no interrupt
	01 ISA mode (direct IRQ routing)
	10 serialized interrupt mode
	11 reserved
 4-3	reserved
 5	3volt Socket Capable force bit
 6	5volt Socket Capable force bit
 7	reserved
SeeAlso: #3309,#3316

Bitfields for PCI Configuration I/O base and limit:
Bit(s)	Description	(Table 0636)
 3-0	(read-only) address decoding type
	0000 16-bit
	0001 32-bit
	other reserved
 7-4	bits 15-12 of I/O address range
SeeAlso: #0628,#0637

Bitfields for PCI Configuration memory base and limit:
Bit(s)	Description	(Table 0637)
 3-0	address decode type
	0000 32-bit address decoder
	0001 64-bit address decoder
	other reserved
 15-4	bits 31-20 of memory address range
SeeAlso: #0628,#0636

Format of PCI Configuration Data for VLSI VL82C591 Host/PCI bridge:
Offset	Size	Description	(Table 0638)
 00h 64 BYTEs	header (see #0628)
		(device ID 0005h)
 40h	BYTE	bus number
 41h	BYTE	subordinate bus number
 42h	WORD	reserved
 44h  4 DWORDs	reserved
 54h  2 BYTEs	device-specific configuration registers
 56h	WORD	reserved
 58h  2 BYTEs	device-specific configuration registers
 5Ah	WORD	reserved
 5Ch  5 BYTEs	device-specific configuration registers
	...
 FFh	BYTE	device-specific configuration register
SeeAlso: #0628,#0629,#0639

Format of PCI Configuration data for VLSI VL82C593 PCI/ISA bridge:
Offset	Size	Description	(Table 0639)
 00h 64 BYTEs	header (see #0628)
		(device ID 0006h)
 40h  4 DWORDs	reserved
 50h 11 BYTEs	device-specific configuration registers
 5Bh	BYTE	reserved
 5Ch 25 BYTEs	device-specific configuration registers
 75h 138 BYTEs	reserved
 FFh	BYTE	device-specific configuration register
SeeAlso: #0628,#0638

Format of PCI Configuration data for Intel 82434 Cache/DRAM Controller:
Offset	Size	Description	(Table 0640)
 00h 64 BYTEs	header (see #0628)
		(vendor ID 8086h, device ID 04A3h)
 40h 16 BYTEs	unused (hard-wired to 00h)
 50h	BYTE	secondary (L2) cache control???
		bit 0: ???
		bit 1: ???
		bit 2: enable L2 cache
 51h	BYTE	deturbo frequency control register
		when deturbo mode is selected (see PORT 0CF9h), the chipset
		  places a hold on the memory bus for a fraction of the
		  time inversely proportional to the value in this register
		  (i.e. C0h = 1/4, 80h = 1/2, 40h = 3/4, 20h = 7/8, etc.)
		  (only bits 7-6 writable, bits 5-0 hardwired to 0)
 52h	BYTE	???
		bits 6-7: ???
		bit 1: ???
		bit 0: ???
 53h	BYTE	???
 54h	BYTE	???
		bit 2: ???
 55h  2 BYTEs	???
 57h	BYTE	DRAM Control???
		bit 3: ???
 58h	BYTE	DRAM Timing???
		bit 0:
 59h  7	BYTEs	Programmable Attribute Map registers 0-6 (see #3401)
 60h  6	BYTEs	DRAM Row Boundary registers 0-5
		each register N indicates the amount of cumulative amount of
		  memory in SIMM banks 0-N, in multiples of 1M; offset 65h
		  contains the total amount of memory installed in the system
 66h  2 BYTEs	??? (set to same value as 65h)
 68h	BYTE	DRAM Row Type???
 69h  3 BYTEs	???
 6Ch	DWORD	unused??? (apparently hardwired to 00000000h)
 70h	BYTE	???
		bits 1-0: ???
 71h	BYTE	???
		bit 3: ???
 72h	BYTE	System Management RAM control (see also #3404)
		bits 2-0: ???
		bit 5:	map SMM-mode memory (64K) into address space when bits
			2-0 = 010 (default 3000h:0000h; can be changed by
			first SMM event)
 73h  5 BYTEs	???
 78h	WORD	???
 7Ah  2 BYTEs	???
 7Ch	DWORD	???
		bit 13: byte merging enabled
 80h 128 BYTEs	unused???
Note:	the 82434 is part of the Intel Neptune chipset
SeeAlso: #0642,#0643

Format of PCI Configuration data for Intel 82424 Cache Controller:
Offset	Size	Description	(Table 0641)
 00h 64 BYTEs	header (see #0628)
		(vendor ID 8086h, device ID 0483h)
 40h	BYTE	bus number
 41h	BYTE	subordinate bus number
 42h	BYTE	disconnect timer
 50h	BYTE	host CPU selection
 51h	BYTE	deturbo frequency control
		when deturbo mode is selected (see PORT 0CF9h), the chipset
		  places a hold on the memory bus for a fraction of the
		  time inversely proportional to the value in this register
		  (i.e. C0h = 1/4, 80h = 1/2, 40h = 3/4, 20h = 7/8, etc.)
 52h	BYTE	secondary cache control
 53h	BYTE	write buffer control
 54h	BYTE	PCI features control
 55h	BYTE	DRAM Operation Mode Select
 56h	BYTE	System Exception Handling
 57h	BYTE	SMM Control Register
 58h	BYTE	reserved
 59h  7	BYTEs	Programmable Attribute Map registers 0-6 (see also #3401)
 60h  4 BYTEs	DRAM Row Boundary registers 0-3
		each register N indicates amount of memory in rows 0-N (each
		  row is 64 bits wide)
		boundary register 3 (offset 63h) contains the total system
		  memory, which may not exceed 128M
 64h  4 BYTEs	unused???
 68h	WORD	Memory Hole-0
 6Ah	WORD	Memory Hole-1
Note:	the above field names are those given by EduWARE's PCI Configuration
	  Manager v1.2
SeeAlso: #0640,#0643,#3392

Format of PCI Configuration data for Intel 82378 and 82379 ISA Bridges:
Offset	Size	Description	(Table 0642)
 00h 64 BYTEs	header (see #0628)
		(vendor ID 8086h, device ID 0484h)
		(revision ID:
		    bits 7-4: reserved
		    bits 3-0: revision
			0011 82378ZB A0-step
			1000 82379AB A0-step)
 40h	BYTE	PCI Control (see #3331)
 41h	BYTE	PCI Arbiter Control (see #3332)
 42h	BYTE	PCI Arbiter Priority Control (see #3333)
 43h	BYTE	(82378ZB) PCI Arbiter Priority Control Extension Register
		bit 0: bank 3 fixed priority mode select (see also #3333)
		    =0 REQ2# has higher priority
		    =1 REQ3# has higher priority
 44h	BYTE	MEMCS# Control (see #3334)
 45h	BYTE	MEMCS# Bottom of Hole (address bits 23-16)
 46h	BYTE	MEMCS# Top of Hole (address bits 23-16)
 47h	BYTE	MEMCS# Top of Memory (address bits 28-21 == size in 2M incr.)
 48h	BYTE	ISA Address Decoder Control (see #3335)
 49h	BYTE	ISA Address Decoder ROM Block Enable (see #3336)
 4Ah	BYTE	ISA Address Decoder Bottom of Hole (address bits 23-16)
 4Bh	BYTE	ISA Address Decoder Top of Hole (address bits 23-16)
 4Ch	BYTE	ISA Controller Recovery Time (see #0647)
 4Dh	BYTE	ISA Clock Divisor (see #3337)
 4Eh	BYTE	Utility Bus Chip Select Enable A (see #3338)
 4Fh	BYTE	Utility Bus Chip Select Enable B (see #3339)
 50h  4 BYTEs	reserved
 54h	BYTE	MEMCS# Attribute Register #1 (see #3340)
		attributes for 16K blocks from C0000h-CFFFFh
 55h	BYTE	MEMCS# Attribute Register #2 (see #3340)
		attributes for 16K blocks from D0000h-DFFFFh
 56h	BYTE	MEMCS# Attribute Register #3 (see #3340)
		attributes for 16K blocks from E0000h-EFFFFh
 57h	BYTE	(82378) Scatter/Gather Relocation Base Adress (see #3341)
		(82379AB) reserved
 58h  8 BYTEs	reserved
 60h	BYTE	(82378ZB) IRQ0# Route Control (see #3342)
 61h	BYTE	(82378ZB) IRQ1# Route Control (see #3342)
 62h	BYTE	(82378ZB) IRQ2# Route Control (see #3342)
 63h	BYTE	(82378ZB) IRQ3# Route Control (see #3342)
 64h 12 BYTEs	reserved
 70h	BYTE	(82378) reserved
		(82379AB, write-only) PIC/APIC Configuration Control
			  (see #3343)
 71h	BYTE	(82378) reserved
		(82379AB, write-only) APIC Base Address Relocation
		  (see #3344,MEM FEC00000h)
 72h 14 BYTEs	reserved
 80h	WORD	BIOS timer base address (see PORT 0078h)
		bits 15-2 are bits 15-2 of BIOS timer port address
		bit 1: reserved (0)
		bit 0: timer enabled (if disabled, other bits ignored)
 82h 30 BYTEs	unused???
 A0h	BYTE	SMI Control (see #3345)
 A1h	BYTE	reserved
 A2h	WORD	SMI Enable (see #3346)
 A4h	DWORD	System Event Enable (SEE) (see #3347)
 A8h	BYTE	Fast-Off Timer (in minutes)
 A9h	BYTE	reserved
 AAh	WORD	SMI Request (see #3348)
 ACh	BYTE	(82378ZB) Clock Throttle STPCLK# Low Timer
		duration of STPCLK# low period in 32 microsecond units
 ADh	BYTE	reserved
 AEh	BYTE	(82378ZB) Clock Throttle STPCLK# High Timer
		duration of STPCLK# high period in 32 microsecond units
 AFh 81 BYTEs	reserved
SeeAlso: #0640,#3410,PORT 040Ah"82378ZB"

Bitfields for Intel 82378/82379 PCI Control:
Bit(s)	Description	(Table 3331)
 7	reserved (0)
 6	DMA Reserved Page Register Aliasing Control
	=0 alias PORT 80h-8Fh to PORT 90h-9Fh
 5	Interrupt Acknowledge Enable
	=0 ignore INTA cycles on the PCI bus, but still allow 8259 register
	  access and poll-mode functions
 4-3	Subtractive Decoding Sample Point
	00 slow sample point
	01 typical
	10 fast sample point
	11 reserved
 2	PCI Posted Write Buffer Enable
 1	ISA Master Line Buffer Configuration
	=0 single-transaction mode
	=1 eight-byte mode for ISA bus master transfers
 0	DMA Line Buffer Configuration
	=0 single-transaction mode
	=1 eight-byte mode
SeeAlso: #0642,#3332

Bitfields for Intel 82378/82379 PCI Arbiter Control:
Bit(s)	Description	(Table 3332)
 7-5	reserveed (0)
 4-3	Master Retry Timer
	00 disabled (retries never masked)
	01 retries unmasked after 16 PCICLKs
	10 retries unmasked after 32 PCICLKs
	11 retries unmasked after 64 PCICLKs
 2	Bus Park
	=1 park CPUREQ# on PCI bus when 82378 detects PCI bus idle
 1	Bus Lock
	=0 resource lock
	=1 Bus lock
 0	Guaranteed Access Time
	=1 ISA bus masters are guaranteed 2.5 microsecond CHRDY time-out
SeeAlso: #0642,#3331

Bitfields for Intel 82378/82379 PCI Arbiter Priority Control:
Bit(s)	Description	(Table 3333)
 7	bank 3 rotate control
 6	bank 2 rotate control
 5	bank 1 rotate control
 4	bank 0 rotate control
 3	bank 2 fixed priority mode select B
 2	bank 2 fixed priority mode select A
 1	bank 1 fixed priority mode select
 0	bank 0 fixed priority mode select
Note:	if both 'rotate' and 'fixed' bits are set for a given bank,
	  that bank will be in rotating-priority mode
SeeAlso: #0642,#3332

Bitfields for Intel 82378/82379 MEMCS# Control Register:
Bit(s)	Description	(Table 3334)
 7-5	reserved (0)
 4	MEMCS# Master Enable
 3	write enable for 0F0000h-0FFFFFh
 2	read enable for 0F0000h-0FFFFFh
 1	write enable for 080000h-09FFFFh
 0	read enable for 080000h-09FFFFh
SeeAlso: #0642

Bitfields for Intel 82378/82379 ISA Address Decoder Control Register:
Bit(s)	Description	(Table 3335)
 7-4	ISA memory cycle forwarding to PCI
	0000-1111 = 1M-16M top of ISA memory; any accesses above programmed
		  limit are forwarded to PCI bus
 3-0	ISA/DMA memory cycle to PCI bus enables
	bit 3: 896K-960K (E000h-EFFFh)
	bit 2: 640K-768K (A000h-BFFFh)
	bit 1: 512K-640K (8000h-9FFFh)
	bit 0: 0K-512K	 (0000h-7FFFh)
SeeAlso: #0642,#3336

Bitfields for Intel 82378/82379 ISA Address Decoder ROM Block Enable:
Bit(s)	Description	(Table 3336)
 7	enable 880K-896K (EC00h-EFFFh)
 6	enable 864K-880K (E800h-EBFFh)
 5	enable 848K-864K (E400h-E7FFh)
 4	enable 832K-848K (E000h-E3FFh)
 3	enable 816K-832K (DC00h-DFFFh)
 2	enabel 800K-816K (D800h-DBFFh)
 1	enable 784K-800K (D400h-D7FFh)
 0	enable 768K-784K (D000h-D3FFh)
Note:	ISA accesses within any enabled ranges are forwarded to the PCI bus
SeeAlso: #0642,#3335

Bitfields for Intel 82378/82379 ISA Clock Divisor Register:
Bit(s)	Description	(Table 3337)
 7	reserved (0)
 6	enable positive decode of upper 64K BIOS at 000F0000h-000FFFFFh,
	  FFEF0000h-FFEFFFFFh, and FFFF0000h-FFFFFFFFh
 5	coprocessor error enable
	=1 FERR# is driven onto IRQ13
 4	IRQ12/Mouse Function Enable
	=0 standard IRQ12
	=1 mouse
 3	RSTDRV enable
	=1 assert RSTDRV until this bit cleared (for use in changing ISA bus
	  speed)
 2-0	PCICLK-to-ISA SYSCLK divisor
	000	4
	001	3
	other	reserved
SeeAlso: #0642,#3335

Bitfields for Intel 82378/82379 Utility Bus Chip Select A Register:
Bit(s)	Description	(Table 3338)
 7	extended BIOS enable (decode accesses to FFF80000h-FFFDFFFFh)
 6	lower BIOS enable (decode accesses to E0000h-EFFFFh,
	  FFEE0000h-FFEEFFFFh, and FFFE0000h-FFFEFFFFh)
 5	(82378ZB) floppy disk primary/secondary address select
	=1 use secondary address range
 4	(82378ZB) IDE Decode enable
 3,2	floppy disk address locations enable
 1	keyboard controller address location enable
	enables I/O addresses 60h,62h,64h,66h (82378ZB) or 60h/64h (82379AB)
 0	RTC address location enabled
	=1 enable decode of I/O ports 70h-77h
SeeAlso: #0642,#0649,#3339

Bitfields for Intel 82378ZB/82379 Utility Bus Chip Select B Register:
Bit(s)	Description	(Table 3339)
 7	configuration RAM decode enable
	=1 permit write accesses to I/O port 0C00h and r/w to ports 08xxh
 6	enable PORT 0092h
 5-4	parallel port enable
	00 LPT1 (ports 03BCh-03BFh)
	01 LPT2 (ports 0378h-037Fh)
	10 LPT3 (ports 0278h-027Fh)
	11 disabled
 3-2	serial port B enable
	00 COM1 (03F8h-03FFh)
	01 COM2 (02F8h-02FFh)
	10 reserved
	11 port B disabled
 1-0	serial port A enable
	00 COM1 (03F8h-03FFh)
	01 COM2 (02F8h-02FFh)
	10 reserved
	11 port A disabled
Note:	if both serial ports are set to the same address, port B is disabled
SeeAlso: #0642,#3338,PORT 0092h

Bitfields for Intel 82378/82379 MEMCS# Attribute Register 1/2/3:
Bit(s)	Description	(Table 3340)
 7	write-enable xC000h-xFFFFh expansion ROM
 6	read-enable xC000h-xFFFFh expansion ROM
 5	write-enable x8000h-xBFFFh expansion ROM
 4	read-enable x8000h-xBFFFh expansion ROM
 3	write-enable x4000h-x7FFFh expansion ROM
 2	read-enable x4000h-x7FFFh expansion ROM
 1	write-enable x0000h-x3FFFh expansion ROM
 0	read-enable x0000h-x3FFFh expansion ROM
Note:	x = C/D/E depending on the attribute register
SeeAlso: #0642

Bitfields for Intel 82378ZB Scatter Gather Relocation Base Address:
Bit(s)	Description	(Table 3341)
 (no details in Intel documentation)
SeeAlso: #0642,#3340,#3342,PORT 040Ah"82378ZB"

Bitfields for Intel 82378/82379 PCI IRQ Route Control Register:
Bit(s)	Description	(Table 3342)
 7	disable IRQ routing
 6-4	reserved (0)
 3-0	ISA IRQ number to which to route the PCI IRQ
Note:	IRQs 0-2, 8, and 13 are reserved
SeeAlso: #0642,#3410

Bitfields for Intel 82379AB PIC/APIC Configuration Control Register:
Bit(s)	Description	(Table 3343)
 7-2	reserved
 1	SMI Routing Control
	=1 SMI via APIC
	=0 SMI via SMI# signal
 0	INT Routing Control
	=1 INT disabled (requires that APIC be enabled)
	=0 INT enabled
SeeAlso: #0642,#3344

Bitfields for Intel 82379AB/82371 APIC Base Address Relocation:
Bit(s)	Description	(Table 3344)
 7	reserved
 6	(82379AB) reserved
 6	(82371) A12 mask
	=1 ignore address bit 12 in APIC address
 5-0	bits 15-10 of APIC memory address (ORed with FEC00000h to form base
	  address)
SeeAlso: #0642,#3410,#3343,MEM FEC00000h

Bitfields for Intel 82378/82379 SMI Control Register:
Bit(s)	Description	(Table 3345)
 7	reserved
 6	(82378) reserved
	(82379) require Stop Grant bus cycle before asserting STPCLK#
 5-4	reserved
 3	Fast-Off Timer freeze
 2	STPCLK# scaling enable
	=1 enable Clock Throttle bytes in PCI configuration space
 1	STPCLK# signal enable
	=1 assert STPCLK# on read from PORT 00B2h
 0	SMI# Gate
	=1 enable SMI# on system management interrupt
Notes:	bit 1 is cleared either with an explicit write of 0 here, or by any
	  write to PORT 00B2h
	bit 0 does not affect the recording of SMI events, so a pending SMI
	  will cause an immediate SMI# when the bit is set
SeeAlso: #0642,#3346,#3347,#3421,PORT 00B2h

Bitfields for Intel 82371/82378/82379 SMI Enable Register:
Bit(s)	Description	(Table 3346)
 15-9	reserved
 8	(82371SB only) Legacy USB SMI enable
 7	APMC Write SMI enable
	=1 generate SMI on write to PORT 00B2h
 6	EXTSMI# SMI enable
 5	Fast-Off Timer SMI enable
 4	IRQ12 (PS/2 mouse) SMI enable
 3	IRQ8 (RTC alarm) SMI enable
 2	IRQ4 (COM1/COM3) SMI enable
 1	IRQ3 (COM2/COM4) SMI enable
 0	IRQ1 (keyboard) SMI enable
SeeAlso: #0642,#3345,#3347,#3410,PORT 00B2h

Bitfields for Intel 82371/82378/82379 System Event Enable Register:
Bit(s)	Description	(Table 3347)
 31	Fast-Off SMI enable (system and break events)
 30	(82379 only) Fast-Off Interrupt Enable (break events only)
 30	(82371 only) INTR enable (break events only)
 29	Fast-Off NMI enable (system and break events)
 28	(82371SB only) Fast-Off APIC enable (break events only)
 27	(82379 only) Fast-Off COM enable (system events only)
 26	(82379 only) Fast-Off LPT enable (system events only)
 25	(82379 only) Fast-Off Drive enable (system events only)
 24	(82379 only) Fast-Off DMA enable (system events only)
 23-16	reserved
 15-3	Fast-Off IRQ (15-3) enable (system and break events)
 2	reserved
 1-0	Fast-Off IRQ (1-0) enable (system and break events)
Note:	any enabled system event restarts the Fast-Off Timer, thus preventing
	  a Fast-Off powerdown; any enabled break event awakens the system from
	  powerdown
SeeAlso: #0642,#3345,#3346,#3348,#3410

Bitfields for Intel 82371/82378/82379 SMI Request Register:
Bit(s)	Description	(Table 3348)
 15-9	reserved
 8	(82371SB only) Legacy USB SMI status
 7	APM SMI Status (write to PORT 00B2h triggered SMI)
 6	EXTSMI# SMI Status (EXTSMI# line triggered SMI)
 5	Fast-Off Timer expired
 4	IRQ12 triggered SMI
 3	IRQ8 triggered SMI
 2	IRQ4 triggered SMI
 1	IRQ3 triggered SMI
 0	IRQ1 triggered SMI
Note:	software must explicitly reset the appropriate bits
SeeAlso: #0642,#3347,#3410

Format of PCI Configuration data for Intel 82425EX PSC:
Offset	Size	Description	(Table 0643)
 00h 64 BYTEs	header (see #0628)
		(vendor ID 8086h, device ID 0486h)
 40h	BYTE	PCI control register (see #0644)
 41h  3 BYTEs	???
 44h	BYTE	host device control register (see #0645)
 45h  3 BYTEs	???
 48h	WORD	PCI local-bus IDE control register (see #0646)
 4Ah  2 BYTEs	???
 4Ch	BYTE	ISA I/O recovery timer register (see #0647)
 4Dh	BYTE	part revision register (see #0648)
 4Eh	BYTE	X-bus Chip Select A register (see #0649)
 4Fh	BYTE	X-bus Chip Select B register???
 50h	BYTE	host select register
 51h	BYTE	deturbo frequency control register
		when deturbo mode is selected (see PORT 0CF9h), the chipset
		  places a hold on the memory bus for a fraction of the
		  time inversely proportional to the value in this register
		  (i.e. C0h = 1/4, 80h = 1/2, 40h = 3/4, 20h = 7/8, etc.)
 52h	WORD	secondary (L2) cache control register
 54h  2 BYTEs	???
 56h	WORD	DRAM control register
 58h	BYTE	???
 59h  7 BYTEs	Programmable Attribute Map (PAM) registers 0-6 (see also #3401)
 60h  5 BYTEs	DRAM row boundary registers 0-4
		each register N indicates amount of memory in rows 0-N (each
		  row is 64 bits wide); the fifth row of memory (if
		  implemented) must contain either 8M or 16M, depending on
		  system configuration
		boundary register 4 (offset 64h) contains the total system
		  memory, which may not exceed 128M
 65h	BYTE	???
 66h	BYTE	PIRQ route control register 0
 67h	BYTE	PIRQ route control register 1
 68h	BYTE	DRAM memory hole register
 69h	BYTE	top of memory
 6Ah  6 BYTEs	???
 70h	BYTE	SMRAM control register
 71h 47 BYTEs	unused???
 A0h	BYTE	SMI control register
 A1h	BYTE	???
 A2h	WORD	SMI enable register
 A4h	DWORD	system event enable
 A8h	BYTE	fast off timer register
 A9h	BYTE	???
 AAh	WORD	SMI request register
 ACh	BYTE	clock throttle STPCLK# low timer
 ADh	BYTE	unused???
 AEh	BYTE	clock throttle STPCLK# high timer
 AFh	BYTE	???
 B0h 80 BYTEs	unused???
SeeAlso: #0628,#0641,#0640,#3392,#3410

Bitfields for Intel 82425EX PCI control register:
Bit(s)	Description	(Table 0644)
 0	CPU-to-PCI byte merging
 1	CPU-to-PCI bursting enable
 2	PCI posted-write buffer enable
 4-3	subtractive decode sampling point
	00 slow
	01 typical
	10 fast
	11 reserved
 5	DRAM parity error enable
 6	target abort error enable
 7	reserved
SeeAlso: #0643,#0645,#0646,#0647

Bitfields for Intel 82425EX host device control register:
Bit(s)	Description	(Table 0645)
 0	HRDY# maximum signal sampling point
	0 slow timing
	1 fast timing
 1	HDEV# signal sampling point
	0 slow timing
	1 fast timing
 2	host device present
 7-3	reserved
SeeAlso: #0643,#0644

Bitfields for Intel 82425EX local-bus IDE control register:
Bit(s)	Description	(Table 0646)
 1-0	primary/secondary PCI IDE enable
	00 IDE disabled
	01 primary (ports 01F0h-01F7h,03F6,03F7h)
	10 secondary (ports 0170h-017Fh,0376h,0377h)
	11 reserved
 3-2	fast timing bank drive select 1
	bit 2 = drive 0 enabled
	bit 3 = drive 1 enabled
 5-4	IORDY sample point Enable Drive Select
	bit 4 = drive 0 enabled
	bit 5 = drive 1 enabled
 7-6	reserved
 9-8	IORDY sample point
	00 6 clocks
	01 5 clocks
	10 4 clocks
	11 3 clocks
 12-10	recover time (000 = 8 PCI clocks, 001 = 7, ..., 101 = 3, 110/111 = 3)
 15-13	reserved
SeeAlso: #0643,#0644

Bitfields for Intel chipset ISA I/O recovery timer register:
Bit(s)	Description	(Table 0647)
 1-0	16-bit I/O recovery time
	00 = 4 SYSCLKs
	01-11 = 1-3 SYSCLKs
 2	16-bit I/O recovery enable
 5-3	8-bit I/O recovery time
	000 = 8 SYSCLKs
	001-110 = 1-7 SYSCLKs
 6	8-bit I/O recovery enable
 7	(82425EX/82371) DMA reserved page register aliasing disable
	=0 ports 0090h-009Fh alias ports 0080h-008Fh
	=1 ports 0090h-009Fh forwarded to ISA bus
SeeAlso: #0642,#0643,#0644,#3410

Bitfields for Intel 82425EX part revision register:
Bit(s)	Description	(Table 0648)
 7-5	fabrication house identifier (read-only)
 4	E0000h-EFFFFh ISA-to-main-memory forwarding enabled
 3-0	revision ID (read-only)
SeeAlso: #0643,#0649

Bitfields for Intel 82425EX/82371 X-bus Chip Select A register:
Bit(s)	Description	(Table 0649)
 7	extended BIOS enabled at FFF80000h-FFFDFFFFh
 6	lower (E000h) BIOS enabled
 5	trigger IRQ13 on FERR#
 4	IRQ12 mouse function enabled
 3	reserved (0)
 2	BIOS memory write protect
 1	keyboard controller addresses (60h,62h,64h,66h) enabled
 0	RTC addresses (70h-77h) enabled
SeeAlso: #0643,#3410,#0648

Format of PCI Configuration Data for Intel 82439HX:
Offset	Size	Description	(Table 3407)
 00h 64 BYTEs	header (see #0628)
		(vender ID 8086h, device ID 1250h)
		(revision ID 00h = A0 stepping)
 40h 16 BYTEs	reserved
 50h	BYTE	PCI Control (see #3394)
 51h	BYTE	reserved
 52h	BYTE	cache control (see #3395)
 53h  3 BYTEs	reserved
 56h	BYTE	DRAM extended control (see #3398)
 57h	BYTE	DRAM control (see #3399)
 58h	BYTE	DRAM timing (see #3400)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #3401)
 60h  8 BYTEs	DRAM Row Boundary registers 0-7
		each register N indicates cumulative amount of memory in rows
		  0-N (each 64 bits wide), in 4M units
 68h	BYTE	DRAM Row Type (see #3402)
		bits 0-7 indicate whether each row 0-7 contains EDO DRAM
		  instead of page-mode DRAM
 69h	BYTE	???
 6Ah  8 BYTEs	reserved
 72h	BYTE	System Management RAM control (see #3404)
 73h 29 BYTEs	reserved
 90h	BYTE	Error Command (see #3408)
 91h	BYTE	Error Status (see #3409) (read-only)
 92h	BYTE	Error Syndrome (read-only)
		latest non-zero ECC error syndrome
 93h 109 BYTEs	reserved
SeeAlso: #3392,#3424

Format of PCI Configuration Data for Intel 82437MX:
Offset	Size	Description	(Table 3435)
 00h 64 BYTEs	header (see #0628)
		(vendor ID 8086h, device ID 1235h)
 40h 16 BYTEs	reserved
 50h	BYTE	PCI Control (see #3436)
 51h	BYTE	reserved
 52h	BYTE	cache control (see #3395)
 53h  4 BYTEs	reserved
 57h	BYTE	DRAM Control (see #3399)
 58h	BYTE	DRAM timing (see #3400)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #3401)
 60h  4 BYTEs	DRAM Row Boundary Registers 0-3
		each register N indicates cumulative amount of memory in rows
		  0-N, in 4M units (each row is 64 bits wide)
 64h  4 BYTEs	reserved
 68h	BYTE	DRAM Row Type (see #3437)
 69h  9 BYTEs	reserved
 72h	BYTE	System Management RAM control (see #3404)
 73h 141 BYTEs	reserved
SeeAlso: #3392,#3438

Format of PCI Configuration Data for Intel 82437FX:
Offset	Size	Description	(Table 3438)
 00h 64 BYTEs	header (see #0628)
		(vendor ID 8086h, device ID 0122h) (see #3308)
 40h 16 BYTEs	reserved
 50h	BYTE	PCI Control (see #3436)
 51h	BYTE	reserved
 52h	BYTE	cache control (see #3395)
 53h  4 BYTEs	reserved
 57h	BYTE	DRAM Control (see #3399)
 58h	BYTE	DRAM timing (see #3400)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #3401)
 60h  5 BYTEs	DRAM Row Boundary Registers 0-4
		each register N indicates cumulative amount of memory in rows
		  0-N, in 4M units (each row is 64 bits wide)
 65h  3 BYTEs	reserved
 68h	BYTE	DRAM Row Type (see #3437)
 69h  9 BYTEs	reserved
 72h	BYTE	System Management RAM control (see #3404)
 73h 141 BYTEs	reserved
SeeAlso: #3435,#3392

Format of PCI Configuration Data for Intel 82437VX:
Offset	Size	Description	(Table 3392)
 00h 64 BYTEs	header (see #0628)
		(vendor ID 8086h, device ID 7030h)
		(revision ID 00h = A0 stepping)
 40h 15 BYTEs	reserved
 4Fh	BYTE	arbitration control (see #3393)
 50h	BYTE	PCI Control (see #3394)
 51h	BYTE	reserved
 52h	BYTE	cache control (see #3395)
 53h	BYTE	cache control extensions (see #3396)
 54h	WORD	SDRAM control (see #3397)
 55h	BYTE	reserved
 56h	BYTE	DRAM extended control (see #3398)
 57h	BYTE	DRAM control (see #3399)
 58h	BYTE	DRAM timing (see #3400)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #3401)
 60h  5 BYTEs	DRAM Row Boundary registers 0-4
		each register N indicates amount of memory in rows 0-N in 4M
		  units (each row is 64 bits wide); the fifth row of memory (if
		  implemented) must contain either 8M or 16M, depending on
		  system configuration
		boundary register 4 (offset 64h) contains the total system
		  memory, which may not exceed 128M
 65h  2 BYTEs	reserved
 67h	BYTE	DRAM Row Type (high)
		defines memory type in DRAM row 4 in bits 4,0 (see #3402)
 68h	BYTE	DRAM Row Type (low) (see #3402)
 69h	BYTE	PCI TRDY timer (see #3403)
 6Ah  6 BYTEs	reserved
 70h	BYTE	Multi-Transaction Timer
		number of PCLKs guaranteed to the current agent before the
		  82437 will grant the bus to another PCI agent on request
 71h	BYTE	reserved
 72h	BYTE	System Management RAM control (see #3404)
 73h	BYTE	shared memory buffer control (see #3405)
 74h	BYTE	shared memory buffer start address, in 0.5MB units
		end address is top-of-memory at offset 64h or start of an
		  enabled PCI memory hole when top-of-memory is 16M
 76h  2 BYTEs	reserved
 78h	BYTE	graphics controller latency timers (see #3406)
 79h 135 BYTEs	reserved
SeeAlso: #3308,#0641,#0643,#3407,#3435

Bitfields for Intel 82437VX arbitration control:
Bit(s)	Description	(Table 3393)
 7	extended CPU-to-PIIX PHLDA# signalling enabled
 6-4	reserved
 3	CPU priority enable
	=1 CPU gets PCI bus after two PCI slots
	=0 CPU gets PCI bus after three PCI slots
 2-0	reserved
SeeAlso: #3392,#3394

Bitfields for Intel 82437VX/82439HX PCI Control register:
Bit(s)	Description	(Table 3394)
 7-4	reserved (82437VX)
 7	DRAM ECC/Parity Select (82439HX)
	=1 ECC
	=0 parity
 6	ECC TEST enable (82439HX)
 5	shutdown to port 92h (82439HX)
	=1 send 01h to PORT 0092h on Shutdown special cycle on host bus
 4	dual-processor NA# enable (82439HX)
 3	PCI Concurrency Enable
	=1 CPU can access DRAM/L2 during non-PIIX PCI master cycles
	=0 CPU kept off PCI bus during all PCI bus-master cycles
 2	SERR# Output Type (82439HX only)
	=1 SERR# is actively driven high when negated
	=0 SERR# is PCI-compatible open-drain output
 1	reserved
 0	Global TXC Enable (82439HX only)
	=1 enable new 82439HX features
SeeAlso: #3392,#3407,#3395,#3436

Bitfields for Intel 82437FX/82437MX PCI Control register:
Bit(s)	Description	(Table 3436)
 7-5	CPU inactivity timer (in PCI Clocks less 1)
 4	reserved
 3	enable PCI Peer Concurrency
	=1 CPU can access DRAM/L2 during non-PIIX PCI master cycles
	=0 CPU kept off PCI bus during all PCI bus-master cycles
 2	disable PCI Bursting
 1	disable PCI Streaming
 0	disable Bus Concurrency
SeeAlso: #3435,#3438,#3394

Bitfields for Intel 82437/82439HX cache control register:
Bit(s)	Description	(Table 3395)
 7-6	secondary cache size
	00 none
	01 256K
	10 512K
	11 reserved
 5-4	L2 RAM type
	00 pipelined burst SRAM/DRAM
	01 reserved
	10 asynchronous SRAM (82437FX/MX/VX only)
	11 two banks of pipelined burst cache
 3	NA disable
	=1 never assert NA# pin
 2	reserved (82437FX/82437MX/82437VX)
 2	Extended Cacheability Enable (82439HX)
	=1 cache up to 512M
	=0 cache only first 64M
 1	Secondary Cache Force Miss or Invalidate
	=1 force all memory accesses to bypass L2 cache
 0	First Level Cache Enable
	=1 all memory accesses made non-cacheable by CPU L1 cache
SeeAlso: #3392,#3407,#3394,#3396,#3397,#3435

Bitfields for Intel 82437VX cache control extensions register:
Bit(s)	Description	(Table 3396)
 7-6	reserved
 5	DRAM cache detected (read-only)
 4-0	DRAM cache refresh timer
	number of HCLKs 82437VX remains idle during DRAM cache refresh
SeeAlso: #3392,#3395

Bitfields for Intel 82437VX SDRAM control register:
Bit(s)	Description	(Table 3397)
 15-9	reserved
 8-6	Special SDRAM Mode Select
	000 normal mode (default)
	001 enable NOP command
	010 enable All Banks Precharge command
	011 enable Mode Register Command
	100 enable CBR Cycle
	101 reserved
	11x reserved
 5	reserved
 4	CAS# latency
	=1 latency is 2 for all SDRAM cycles
	=0 latency is 3
 3	RAS# precharge and refresh timing
	=0 slower
	=1 faster
 2-0	reserved
SeeAlso: #3392,#3395

Bitfields for Intel 82437VX/82439HX DRAM extended control register:
Bit(s)	Description	(Table 3398)
 7	reserved
 6	(82437VX) refresh RAS# assertion length (0=4 clocks, 1=5 clocks)
 5	(82437VX) Fast EDO Path Select
 4	Speculative Leadoff Disable
 3	(82439HX) Turn-Around Insertion Enable
	=1 insert one extra clock of turnaround time after asserting MWE#
 2-1	Memory Address Drive Strength
	82437VX:		82439HX:
	    00 reserved		    00 8mA
	    01 10mA (default)	    01 8mA/12mA (MAA/MWE#)
	    10 16mA		    10 12mA/8mA (MAA/MWE#)
	    11 reserved		    11 12mA
 0	(82437VX) DRAM Symmetry Detect Mode
	(used to force some memory address lines to fixed value for detecting
	  DRAM symmetry row-by-row)
 0	(82439HX) 64MBit Mode Enable
	=1 enable support for 64M SIMMs
SeeAlso: #3392,#3407,#3399

Bitfields for Intel 82437/82439HX DRAM control register:
Bit(s)	Description	(Table 3399)
 7-6	DRAM Hole Enable
	00 none
	01 512K-640K
	10 15M-16M (82437FX/MX/VX only)
	11 14M-16M (82437VX only)
 5	reserved
 4	(82437MX only) refresh type during Suspend
	=1 self-refreshing DRAMs in system
	=0 CAS-before-RAS refresh
 3	EDO Detect Mode enable
	(used to detect whether memory is EDO bank-by-bank)
 2-0	DRAM refresh rate
	     FX/VX/HX	MX
	000 disabled	15.6 us
	001 50 MHz	31.2 us
	010 60 MHz	62.4 us
	011 66 MHz	125 us
	100 reserved	250 us
	1xx reserved	reserved
SeeAlso: #3392,#3407,#3398,#3435

Bitfields for Intel 82437FX/82437MX/82437VX/82439HX DRAM timing register:
Bit(s)	Description	(Table 3400)
 7	(82437FX) reserved
 7	(82437MX) MA[11:2] buffer strength
	=0 8mA
	=1 12mA
 7	(82437VX) MA-to-RAS# Delay
	=1 one clock
	=0 two clocks
 7	(82439HX) Turbo Read Leadoff
	=1 bypass first register in DRAM data pipeline, saving one clock
	(may only be set in a cacheless configuration)
 6-5	DRAM Read Burst Timing
	00 x444 (EDO and Standard Page Mode)
	01 x333 (EDO), x444 (SPM)
	10 x222 (EDO), x333 (SPM)
	11 x322 (EDO), x333 (SPM) (82437VX only)
	11 reserved (other)
 4-3	DRAM Write Burst Timing
	00 x444
	01 x333
	10 x222
	11 reserved
 2	RAS-to-CAS Delay
	=1 two clocks
	=0 three clocks
 1-0	DRAM Leadoff Timing
	82437VX Read Leadoff  Write Leadoff  RAS# Precharge
	    00		11	7		3
	    01		10	6		3
	    10		11	7		4
	    11		10	6		4
	82437FX/MX Read Lead  Write Leadoff  RAS# Precharge
	    00		8	6		3
	    01		7	5		3
	    10		8	6		4
	    11		7	5		4
	82437VX Read Leadoff  Write Leadoff  RAS# Precharge
	    00		7	6		3
	    01		6	5		3
	    10		7	6		4
	    11		6	5		4
SeeAlso: #3392,#3399,#3435,#3438

Bitfields for Intel 82437/82439HX Programmable Attribute Register:
Bit(s)	Description	(Table 3401)
 7	reserved
 6	cache enable (region 1)
 5	write enable (region 1)
 4	read enable (region 1)
 3	reserved
 2	cache enable (region 0)
 1	write enable (region 0)
 0	read enable (region 0)
Notes:	each programmable attribute map register controls two memory
	  regions at the top of the first megabyte of memory
	for the Intel 82441FX, bits 6 and 2 are reserved, as cacheability is
	  set using the Pentium Pro's MTRR registers (see MSR 000000FEh)
	Intel 82437FX/82437MX/82437VX/82439HX/82441FX PAM registers/regions:
		PAM0 low: reserved
		PAM0 hi:  segment F000-FFFF
		PAM1 low: segment C000-C3FF
		PAM1 hi:  segment C400-C7FF
		PAM2 low: segment C800-CBFF
		PAM2 hi:  segment CC00-CFFF
		PAM3 low: segment D000-D3FF
		PAM3 hi:  segment D400-D7FF
		PAM4 low: segment D800-DBFF
		PAM4 hi:  segment DC00-DFFF
		PAM5 low: segment E000-E3FF
		PAM5 hi:  segment E400-E7FF
		PAM6 low: segment E800-EBFF
		PAM6 hi:  segment EC00-EFFF
SeeAlso: #3392,#3407,#3424,#3435,#3438

Bitfields for Intel 82437VX DRAM Row Type register:
Bit(s)	Description	(Table 3402)
 7,3	row 3 type
 6,2	row 2 type
 5,1	row 1 type
 4,0	row 0 type
	00 SPM DRAM
	01 EDO DRAM
	10 SDRAM
	11 reserved
SeeAlso: #3392,#3401

Bitfields for Intel 82437FX/82437MX DRAM Row Type register:
Bit(s)	Description	(Table 3437)
 7-4	reserved
 3-0	DRAM Row N is EDO instead of page-mode DRAM
SeeAlso: #3435,#3438

Bitfields for Intel 82437VX PCI TRDY timer:
Bit(s)	Description	(Table 3403)
 7-3	reserved
 2-0	TRDY timeout value
	000 2 PCICLKs
	001 4 PCICLKs
	010 6 PCICLKs
	011 8 PCICLKs
	1xx reserved
SeeAlso: #3392,#3404

Bitfields for Intel 82437/82439HX System Management RAM control register:
Bit(s)	Description	(Table 3404)
 7	reserved
 6	SMM Space Open
	=1 make SMM DRAM visible even when not in SMM if bit 4 =0
 5	SMM Space Closed
	=1 no data references permitted to SMM DRAM even in SMM
 4	SMM Space Locked
	=1 force bits 4 and 6 to become read-only; and clear bit 6
 3	SMRAM Enable
	=1 128K DRAM are accessible for use at A000 while in SMM
 2-0	SMM Space Base Segment
	010 segment A000-BFFF
	100 segment C000-CFFF (82437MX only)
	other reserved
Note:	bits 5 and 6 must never both be set at the same time
SeeAlso: #3392,#3407,#3405,#3435,#3438

Bitfields for Intel 82437VX Shared Memory Buffer control register:
Bit(s)	Description	(Table 3405)
 7-2	reserved
 1	enable shared memory buffer
 0	redirect shared memory buffer access
	=0 treat SMB area as a hole in system DRAM
SeeAlso: #3392,#3404,#3406

Bitfields for Intel 82437VX Graphics Controller Latency Timer:
Bit(s)	Description	(Table 3406)
 7-6	reserved
 5-3	GC latency for PCI reads (in 4 HCLK multiples) (default=100)
 2-0	GC latency for CPU and PCI writes (in 4 HCLK multiples) (default=011)
SeeAlso: #3392,#3405

Bitfields for Intel 82439HX Error Command register:
Bit(s)	Description	(Table 3408)
 7	SERR# duration
	=0 one PCI clock
	=1 until error flags are cleared
 6-3	reserved
 2	force bad parity on multiple-bit uncorrectable error
 1	assert SERR# on multiple-bit uncorrectable error
 0	assert SERR# on single-bit correctable error
SeeAlso: #3407,#3409

Bitfields for Intel 82439HX Error Status register:
Bit(s)	Description	(Table 3409)
 7-5	DRAM row associated with multi-bit error
 4	multi-bit uncorrectable error occurred (write 1 bit to clear)
 3-1	DRAM row associated with single-bit correctable error
 0	single-bit correctable error occurred (write 1 bit to clear)
SeeAlso: #3407,#3408

Format of PCI Configuration for Intel 82371FB/82371SB Function 0 (ISA Bridge):
Offset	Size	Description	(Table 3410)
 00h 64 BYTEs	header (see #0628)
		(vendor ID 8086h, device ID 122Eh/7000h)
		(revision ID 00h = 82371SB step A-1)
		(revision ID 01h = 82371SB step B-0)
 40h 12 BYTEs	reserved
 4Ch	BYTE	ISA I/O Controller Recovery Timer (see #0647)
 4Dh	BYTE	reserved
 4Eh	BYTE	X-Bus Chip Select Enable (see #0649)
 4Fh	BYTE	(82371SB) X-Bus Chip Select Enable High
		bit 0: I/O APIC enabled
 4Fh	BYTE	(82371FB) reserved
 50h 16 BYTEs	reserved
 60h  4 BYTEs	PCI IRQ Route Control (see #3342)
 64h  5 BYTEs	reserved
 69h	BYTE	top of memory (see #3415)
 6Ah	WORD	miscellaneous status (see #3416)
 6Ch  4 BYTEs	reserved
 70h	BYTE	motherboard IRQ Route Control 0 (see #3417)
 71h	BYTE	(82371FB) motherboard IRQ Route Control 1 (see #3417)
 72h  4 BYTEs	reserved
 76h  2 BYTEs	motherboard DMA control (see #3418)
 78h	WORD	programmable chip select control (see #3419)
 7Ah  6 BYTEs	reserved
 80h	BYTE	(82371SB) APIC Base Address Relocation (see #3344)
 81h	BYTE	reserved
 82h	BYTE	(82371SB) Deterministic Latency Control (see #3420)
 83h 29 BYTEs	reserved
 A0h	BYTE	SMI Control (see #3421)
 A1h	BYTE	reserved
 A2h	WORD	SMI Enable (see #3346)
 A4h	DWORD	System Event Enable (SEE) (see #3347)
 A8h	BYTE	Fast-Off Timer (in minutes, PCICLKs, or milliseconds)
		value is count less one; timer must be stopped before
		  changing its value
 A9h	BYTE	reserved
 AAh	WORD	SMI Request (see #3348)
 ACh	BYTE	Clock Scale STPCLK# Low Timer
		STPCLK# stays low for 1+1056*(value+1) PCICLKs
 ADh	BYTE	reserved
 AEh	BYTE	Clock Scale STPCLK# High Timer
		STPCLK# stays high for 1+1056*(value+1) PCICLKs
 AFh 81 BYTEs	reserved
SeeAlso: #3411,#3414,#0642,#0643,#3392,#3407

Format of PCI Configuration for Intel 82371FB/82371SB Function 1 (IDE):
Offset	Size	Description	(Table 3411)
 00h 64 BYTEs	header (see #0628)
		(vender ID 8086h, device ID 1230h/7010h)
 20h	DWORD	Bus Master Interface Base Address
		(see PORT xxxxh"Intel 82371SB")
 40h	WORD	IDE timing modes, primary channel (see #3412)
 42h	WORD	IDE timing modes, secondary channel (see #3412)
 44h	BYTE	(82371SB) slave IDE timing register (see #3413)
 45h 187 BYTEs	reserved
SeeAlso: #3410,#3414,PORT xxxxh"Intel 82371SB"

Format of PCI Configuration for Intel 82371SB Function 2 (USB):
Offset	Size	Description	(Table 3414)
 00h 64 BYTEs	header (see #0628)
		(vendor ID 8086h, device ID 7020h)
 20h	DWORD	I/O space base address
		(see PORT xxxxh"Intel 82371SB")
 40h 32 BYTEs	reserved
 60h	BYTE	Serial Bus Specification release number
		00h pre-release 1.0
		10h Release 1.0
 61h  9 BYTEs	reserved
 6Ah	WORD	miscellaneous status (see #3422)
 6Ch 84 BYTEs	reserved
 C0h	WORD	legacy support (see #3423)
 C2h 62 BYTEs	reserved
SeeAlso: #3410,#3411,PORT xxxxh"Intel 82371SB"

Bitfields for Intel 82371FB/82371SB top of memory register:
Bit(s)	Description	(Table 3415)
 7-4	top of ISA memory (in megabytes, less 1; i.e. 0001 = 2M)
 3	ISA/DMA lower BIOS forwarding enable
 2	(82371SB) enable A000/B000 segment forwarding to PCI bus
 1	enable forwarding ISA/DMA 512K-640K region to PCI bus
 0	reserved
SeeAlso: #3410,#3416

Bitfields for Intel 82371FB/82371SB miscellaneous status register:
Bit(s)	Description	(Table 3416)
 15	(82371SB) enable SERR# on delayed transaction
	write 1 to clear this bit
 14-8	reserved
 7	(82371SB) NB Retry Enable
 6	(82371SB) EXTSMI# Mode Enable
	allow special SERR# protocol between PCI bridge and 82371
 5	reserved
 4	(82371SB) enable USB
	disable USB's master enable and I/O decode enable prior to
	 clearing this bit!
 3	reserved
 2	(82371FB) PCI Header Type Bit enable
	=1 report multifunction device in PCI configuration header
 1	(82371FB) internal ISA DMA/external DMA Mode status (read-only)
	=0 normal DMA operation
 0	(82371FB) ISA Clock Divisor status (read-only)
	(82371SB) ISA Clock Divisor (read-write)
	=1 SYSCLK clock divisor is 3
	=0 SYSCLK clock divisor is 4
SeeAlso: #3410,#3415

Bitfields for Intel 82371FB/82371SB motherboard IRQ Route Control:
Bit(s)	Description	(Table 3417)
 7	disable IRQ routing
 6	enable MIRQx/IRQx sharing
 5	(82371SB) enable IRQ0 output
 4	reserved (0)
 3-0	ISA IRQ number to which to route the PCI IRQ
Note:	IRQs 0-2, 8, and 13 are reserved
SeeAlso: #3410,#3415,#3418

Bitfields for Intel 82371FB/82371SB motherboard DMA control:
Bit(s)	Description	(Table 3418)
 7	type F and DMA buffer enable
 6-4	reserved
 3	(82371FB) disable motherboadr DMA channel
 2-0	DMA channel number
	(82371FB) Type F and Motherboard DMA
	(82371SB) Type F DMA
SeeAlso: #3410,#3417

Bitfields for Intel 82371FB/83271SB programmable chip select control register:
Bit(s)	Description	(Table 3419)
 15-2	I/O address which will assert PCS# signal
 1-0	PCS address mask
	00 four bytes
	01 eight contiguous bytes
	10 disabled
	11 sixteen contiguous bytes
SeeAlso: #3410,#3418,#3420

Bitfields for Intel 82371SB Deterministic Latency Control register:
Bit(s)	Description	(Table 3420)
 7-4	reserved
 3	enable SERR# on delayed transaction timeout
 2	enable USB passive release
 1	enable passive release
 0	enable delayed transactions
SeeAlso: #3410,#3419

Bitfields for Intel 82371FB/82371SB SMI Control Register:
Bit(s)	Description	(Table 3421)
 7-5	reserved
 4-3	Fast-Off Timer freeze/granularity selection
	00 one minute granularity (assuming 33 MHz PCICLK)
	01 disabled (frozen)
	10 one PCICLK
	11 one millisecond
 2	STPCLK# scaling enable
	=1 enable Clock Scale bytes in PCI configuration space
 1	STPCLK# signal enable
	=1 assert STPCLK# on read from PORT 00B2h
 0	SMI# Gate
	=1 enable SMI# on system management interrupt
Notes:	bit 1 is cleared either with an explicit write of 0 here, or by any
	  write to PORT 00B2h
	bit 0 does not affect the recording of SMI events, so a pending SMI
	  will cause an immediate SMI# when the bit is set
SeeAlso: #3410,#3345

Bitfields for Intel 82371FB/82371SB IDE timing modes:
Bit(s)	Description	(Table 3412)
 15	IDE decode enable
 14	(82371SB) slave IDE timing register enable (see #3413)
 13-12	IORDY# sample point
	00 five clocks after DIOx# assertion
	01 four clocks
	10 three clocks
	11 two clocks
 11-10	reserved
 9-8	recovery time between IORDY# sample point and DIOx#
	00 four clocks
	01 three clocks
	10 two clocks
	11 one clock
 7	DMA timing enable only, drive 1
 6	prefetch and posting enable, drive 1
 5	IORDY# sample point enable drive select 1
 4	fast timing bank drive select 1
 3	DMA timing enable only, drive 0
 2	prefetch and posting enable, drive 0
 1	IORDY# sample point enable drive select 0
 0	fast timing bank drive select 0
SeeAlso: #3411

Bitfields for Intel 82371SB slave IDE timing register:
Bit(s)	Description	(Table 3413)
 7-6	secondary drive 1 IORDY# sample point
	00 five clocks after DIOx# assertion
	01 four clocks
	10 three clocks
	11 two clocks
 5-4	secondary drive 1 recovery time
	00 four clocks
	01 three clocks
	10 two clocks
	11 one clock
 3-2	primary drive 1 IORDY# sample point
 1-0	primary drive 1 recovery time
SeeAlso: #3412

Bitfields for Intel 82371SB miscellaneous status:
Bit(s)	Description	(Table 3422)
 15-1	reserved
 0	USB clock selection
	=1 48 MHz
	=0 24 MHz
SeeAlso: #3414,#3423

Bitfields for Intel 82371SB legacy support register:
Bit(s)	Description	(Table 3423)
 15	A20GATE pass-through sequence ended
	write 1 to clear this bit
 14	reserved
 13	USB PIRQ enabled
 12	USR IRQ status (read-only)
 11	trap caused by write to PORT 0064h
	write 1 to clear this bit
 10	trap caused by read from PORT 0064h
	write 1 to clear this bit
 9	trap caused by write to PORT 0060h
	write 1 to clear this bit
 8	trap caused by read from PORT 0060h
	write 1 to clear this bit
 7	enable SMI at end of A20GATE Pass-Through
 6	A20GATE pass-through sequence in progress (read-only)
 5	enable A20GATE pass-through sequence
	(write PORT 64h,D1h; write 60h,xxh; read 64h; write 64h,FFh)
 4	enable trap/SMI on USB IRQ
 3	enable trap/SMI on PORT 0064h write
 2	enable trap/SMI on PORT 0064h read
 1	enable trap/SMI on PORT 0060h write
 0	enable trap/SMI on PORT 0060h read
SeeAlso: #3414,#3422

Format of PCI Configuration Data for Intel 82441FX:
Offset	Size	Description	(Table 3424)
 00h 64 BYTEs	header (see #0628)
		(vendor ID 8086h, device ID 1237h) (see #3308)
 40h 16 BYTEs	reserved
 50h	WORD	PMC Configuration (see #3425)
 52h	BYTE	deturbo counter control
		when deturbo mode is selected (see PORT 0CF9h), the chipset
		  places a hold on the memory bus for a fraction of the
		  time inversely proportional to the value in this register
		  (i.e. C0h = 1/4, 80h = 1/2, 40h = 3/4, 20h = 7/8, etc.)
 53h	BYTE	DBX buffer control (see #3426)
 54h	BYTE	auxiliary control (see #3427)
 55h	WORD	DRAM Row Type (see #3428)
 57h	BYTE	DRAM Control (see #3429)
 58h	BYTE	DRAM Timing (see #3430)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #3401)
 60h  8 BYTEs	DRAM Row Buondary registers 0-7
		each register N indicates cumulative amount of memory in rows
		  0-N (each 64 bits wide), in 8M units
 68h	BYTE	Fixed DRAM Hole Control
 69h  7 BYTEs	reserved
 70h	BYTE	Multi-Transaction Timer
		number of PCLKs guaranteed to the current agent before the
		  82441 will grant the bus to another PCI agent on request
 71h	BYTE	CPU Latency Timer (see #3431)
 72h	BYTE	System Management RAM control (see #3404)
 73h 29 BYTEs	reserved
 90h	BYTE	Error Command (see #3432)
 91h	BYTE	Error Status (see #3433)
 92h	BYTE	reserved
 93h	BYTE	Turbo Reset Control (see #3434)
 94h 108 BYTEs	reserved
SeeAlso: #3407,#3392

Bitfields for Intel 82441FX PMC Configuration Register:
Bit(s)	Description	(Table 3425)
 15	WSC Protocol Enable
 14	Row Select/Extra Copy select (read-only)
	=1 pins on PMC configured as two additional row selects (6/7)
	=0 extra copy of two lowest memory address bits enabled
 13-10	reserved
 9-8	host frequence select
	00 reserved
	01 60 MHz
	10 66 MHz
	11 reserved
 7	reserved
 6	ECC/Parity TEST enable
 5-4	DRAM Data Integrity Mode
	00 no parity/ECC
	01 parity generated and checked
	10 ECC generated and checked, correction disabled
	10 ECC generated and checked, correction enabled
 3	reserved
 2	In-Order Queue size (0=one, 1=four)
 1-0	reserved
SeeAlso: #3424,#3426

Bitfields for Intel 82441FX DBX buffer control register:
Bit(s)	Description	(Table 3426)
 7	enable delayed transactions
 6	enable CPU-to-PCI IDE posting
 5	enable USWC Write Post during I/O Bridge access
 4	disable PCI Delayed Transaction timer
 3	enable CPU-to-PCI Write Post
 2	enable PCI-to-DRAM pipeline
 1	enable PCI Burst Write Combining
 0	enable Read-Around-Write
SeeAlso: #3424,#3425

Bitfields for Intel 82441FX auxiliary control register:
Bit(s)	Description	(Table 3427)
 7	enable RAS precharge
 6-2	reserved
 1	Lower Memory Address Buffer Set A
	=0 8mA
	=1 12mA
 0	reserved
SeeAlso: #3424

Bitfields for Intel 82441FX DRAM Row Type register:
Bit(s)	Description	(Table 3428)
 15-14	row 7 DRAM type
 13-12	row 6 DRAM type
 11-10	row 5 DRAM type
 9-8	row 4 DRAM type
 7-6	row 3 DRAM type
 5-4	row 2 DRAM type
 3-2	row 1 DRAM type
 1-0	row 0 DRAM type
	00 fast page-mode DRAM
	01 EDO DRAM
	10 BEDO DRAM
	11 empty row
SeeAlso: #3424,#3429

Bitfields for Intel 82441FX DRAM Control register:
Bit(s)	Description	(Table 3429)
 7	reserved
 6	enable DRAM Refresh Queue
 5	enable DRAM EDO Auto-Detect Mode
 4	DRAM Refresh Type
	=0 CAS before RAS
	=1 RAS only
 3	reserved
 2-0	DRAM refresh rate
	000 disabled
	001 normal (as set by PMCCFG register)
	01x reserved
	1xx reserved
	111 fast refresh (every 32 host clocks)
SeeAlso: #3424,#3428,#3430

Bitfields for Intel 82441FX DRAM Timing register:
Bit(s)	Description	(Table 3430)
 7	reserved
 6	enable WCBR Mode
 5-4	DRAM Read Burst Timing
		BEDO	EDO	FPM
	00	x333	x444	x444
	01	x222	x333	x444
	10	x222	x222	x333
	11	res.	res.	res.
 3-2	DRAM Write Burst Timing
		(B)EDO	FPM
	00	x444	x444
	01	x333	x444
	10	x333	x333
	11	x222	x333
 1	RAS-to-CAS delay
	=1 one clock
	=0 zero clocks
 0	insert one MA Wait State
SeeAlso: #3424,#3429

Bitfields for Intel 82441FX CPU Latency Timer register:
Bit(s)	Description	(Table 3431)
 7-5	reserved
 4-0	snoop stall count value
SeeAlso: #3424

Bitfields for Intel 82441FX Error Command register:
Bit(s)	Description	(Table 3432)
 7-5	reserved
 4	enable SERR# on receiving Target Abort
 3	enable SERR# on PCI Parity Error (PERR#)
 2	reserved
 1	enable SERR# on receiving multiple-bit ECC/Parity error
 0	enable SERR# on receiving single-bit ECC error
SeeAlso: #3424,#3433

Bitfields for Intel 82441FX Error Status register:
Bit(s)	Description	(Table 3433)
 7-5	DRAM row causing first multi-bit error (read-only)
 4	multiple-bit uncorrectable error detected
	write 1 to this bit to clear it
 3-1	DRAM row causing first single-bit error (read-only)
 0	single-bit correctable ECC error detected
	write 1 to this bit to clear it
SeeAlso: #3424,#3432

Bitfields for Intel 82441FX Turbo Reset Control register:
Bit(s)	Description	(Table 3434)
 7-4	reserved
 3	enable BIST on hard reset
 2	reset CPU
 1	reset mode
	0 soft reset
	1 hard reset
 0	deturbo mode
SeeAlso: #3424,PORT 0CF9h

Format of OpenHCI Host Controller memory-mapped registers:
Offset	Size	Description	(Table 3330)
 00h	DWORD	"HcRevision"		OpenHCI revision (see #3455)
 04h	DWORD	"HcControl"		HC operating modes (see #3456)
 08h	DWORD	"HcCommandStatus"	command/status (see #3457)
 0Ch	DWORD	"HcInterruptStatus"	interrupt status (see #3458)
 10h	DWORD	"HcInterruptEnable"	enable interrupts (see #3459)
 14h	DWORD	"HcInterruptDisable"	disable interrupts (see #3459)
 18h	DWORD	"HcHCCA"		HC Communications Area (see #3462)
 1Ch	DWORD	"HcPeriodCurrentED"	Endpoint Descriptor addr (see #3463)
 20h	DWORD	"HcControlHeadED"	Control Endpoint Descriptor (see #3464)
 24h	DWORD	"HcControlCurrentED"	Control Endpoint Descriptor (see #3464)
 28h	DWORD	"HcBulkHeadED"		Bulk Endpoint Descriptor (see #3465)
 2Ch	DWORD	"HcBulkCurrentED"	Bulk Endpoint Descriptor (see #3465)
 30h	DWORD	"HcDoneHead"		last completed Xfer Descr. (see #3466)
 34h	DWORD	"HcFmInterval"		Frame bit-time interval (see #3516)
 38h	DWORD	"HcFmRemaining"		bit time remaining in Frame (see #3517)
 3Ch	DWORD	"HcFmNumber"		Frame Number (bits 15-0)
 40h	DWORD	"HcPeriodicStart"	earliest time to start periodic list
					(bits 13-0)
 44h	DWORD	"HcLSThreshold"		threshold for Low Speed transaction
					(bits 11-0)
 48h	DWORD	"HcRhDescriptorA"	Root Hub Descriptor A (see #3518)
 4Ch	DWORD	"HcRhDescriptorB"	Root Hub Descriptor B (see #3519)
 50h	DWORD	"HcRhStatus"		Root Hub status (see #3520)
 54h  N DWORDs	"HCRhPortStatus[1-N]"	Root Hub port status N (see #3521)
Note:	OpenHCI reserves a full 4K page of the systems address space for its
	  memory-mapped registers
SeeAlso: #0628,#0633,#F057

Bitfields for OpenHCI "HcRevision" register:
Bit(s)	Description	(Table 3455)
 31-8	reserved
 7-0	BCD OpenHCI specification number (10h = 1.0, 11h = 1.1)
Note:	this register is read-only
SeeAlso: #3330,#3456

Bitfields for OpenHCI "HcControl" register:
Bit(s)	Description	(Table 3456)
 31-11	reserved
 10	RWE	enable Remote Wakeup feature
 9	RWC	controller supports Remote Wakeup signalling
 8	IR	Interrupt Routing
		0 normal host bus interrupt
		1 System Managment Interrupt
 7-6	HCFS	USB Host Controller Functional State
		00 USBReset
		01 USBResume
		10 USBOperational
		11 USBSuspend
 5	BLE	enable Bulk List processing in next frame
 4	CLE	enable Control List processing in next frame
 3	IE	enable Isochronous ED processing
 2	PLE	enable processing of Periodic List in next frame
 1-0	CBSR	Control Bulk Service Ratio
		00  1:1 Control EDs:Bulk EDs served
		01  2:1
		10  3:1
		11  4:1
SeeAlso: #3330,#3455,#3457

Bitfields for OpenHCI "HcCommandStatus" register:
Bit(s)	Description	(Table 3457)
 31-18	reserved
 17-16	SOC	scheduling-overrun count
 15-4	reserved
 3	OCR	ownership change request is pending
 2	BLF	bulk list contains TDs
 1	CLF	control list contains TDs
 0	HCR	host controller software reset
Note:	writing a 1 bit sets the corresponding bit, while a 0 bit leaves the
	  corresponding bit unchanged
SeeAlso: #3330,#3455,#3458

Bitfields for OpenHCI "HcInterruptStatus" register:
Bit(s)	Description	(Table 3458)
 31	reserved (0)
 30	OC	ownership change
 29-7	reserved
 6	RHSC	Root Hub status changed
 5	FNO	frame number overflowed
 4	UE	unrecoverable error
 3	RD	resume detected
 2	SF	start of frame
 1	WDH	writeback done
 0	SO	scheduling overrun
Note:	writing a 1 bit clears the corresponding bit of the register
SeeAlso: #3330,#3455,#3457,#3459

Bitfields for OpenHCI "HcInterruptEnable" and "HcInterruptDisable" registers:
Bit(s)	Description	(Table 3459)
 31	MIE	master interrupt enable
 30	OC	ownership change
 29-7	reserved
 6	RHSC	Root Hub status change
 5	FNO	frame number overflow
 4	UE	unrecoverable error
 3	RD	Resume Detect
 2	SF	start of frame
 1	WDH	HcDoneHead writeback
 0	SO	scheduling overrun
Note:	writing a 1 bit to HcInterruptEnable enables the corresponding
	  interrupt, while writing a 1 bit to HcInterruptDisable disables it;
	  zero bits are ignored.  On reading, both registers return the
	  same value, which reflects the currently enabled interrupts
SeeAlso: #3330

Bitfields for OpenHCI "HcHCCA" register:
Bit(s)	Description	(Table 3462)
 31-8	physical address of Host Controller Communications Area (bits 31-8)
 7-0	reserved (0)
Note:	the required alignment for the HCCA may be determined by writing
	  FFFFFFFFh to this register and determining the number of low-order
	  zero bits
SeeAlso: #3330,#3463,#3464

Bitfields for OpenHCI "HcPeriodCurrentED" register:
Bit(s)	Description	(Table 3463)
 31-4	physical address of current Isochronous/Interrupt Endpoint Descriptor
	  (bits 31-4)
 3-0	reserved (0)
SeeAlso: #3330,#3462,#3464

Bitfields for OpenHCI "HcControlHeadED"/"HcControlCurrentED" register:
Bit(s)	Description	(Table 3464)
 31-4	physical address of first/current Endpoint Descriptor (bits 31-4)
 3-0	reserved (0)
Note:	HcControlCurrentED is set to 0000000h to indicate the end of the
	  Control list
SeeAlso: #3330,#3462,#3463

Bitfields for OpenHCI "HcBulkHeadED"/"HcBulkCurrentED" register:
Bit(s)	Description	(Table 3465)
 31-4	physical address of first/current Endpoint Descriptor in the Bulk
	  list (bits 31-4)
 3-0	reserved (0)
Note:	HcBulkCurrentED is set to 0000000h to indicate the end of the Bulk
	  list
SeeAlso: #3330,#3462,#3464

Bitfields for OpenHCI "HcDoneHead" register:
Bit(s)	Description	(Table 3466)
 31-4	physical address of most-recently completed Transfer Descriptor added
	  to the Done queue (bits 31-4)
 3-0	reserved (0)
SeeAlso: #3330,#3463,#3465

Bitfields for OpenHCI "HcFmInterval" register:
Bit(s)	Description	(Table 3516)
 31	"FIT"	toggled each time a new value is loaded into bits 13-0
 30-16	"FSMPS"	largest data packet in bits
 15-14	reserved
 13-0	"FI"	Frame Interval (between to consecutive SOFs)
SeeAlso: #3330,#3517

Bitfields for OpenHCI "HcFmRemaining" register:
Bit(s)	Description	(Table 3517)
 31	"FRT"	loaded from bit 31 of HcFmInterval whenever FR reaches 0
 30-14	reserved
 13-0	"FR"	FrameRemaining -- bits times left in current frame
SeeAlso: #3330,#3516

Bitfields for OpenHCI "HcRhDescriptorA" register:
Bit(s)	Description	(Table 3518)
 31-24	"POTPGT" power-on to power-good time in 2ms units
 23-13	reserved
 12	"NOCP"	no over-current protection supported
 11	"OCPM"	over-current status reported per-port
 10	"DT"	device type - is root hub compound device?
 9	"NPS"	NoPowerSwitching -- ports are always powered up
 8	"PSM"	power-switching mode -- if set, each port powered individually
 7-0	"NDP"	number of downstream ports
SeeAlso: #3330,#3519,#3520

Bitfields for OpenHCI "HcRhDescriptorB" register:
Bit(s)	Description	(Table 3519)
 31-16	"PPCM"	PortPowerControlMask -- bitmask of ports NOT affected by global
		  power control (bit 16 [port #0] is reserved)
 15-0	"DR"	DeviceRemovable -- bitmap of removable devices
SeeAlso: #3330,#3518,#3520

Bitfields for OpenHCI "HcRhStatus" register:
Bit(s)	Description	(Table 3520)
 31	"CRWE"	Clear Remote Wakeup Enable
		write 1 to disable remote wakeup (writes of 0 ignored)
 30-18	reserved
 17	"OCIC"	OverCurrent Indicator Change
		write 1 to clear
 16   R	"LPSC"	Local Power Status Change
      W		Set Global Power mode (write 1; writes of 0 ignored)
 15	"DRWE"	Device Remote Wakeup Enable
		write 1 to enable (writes of 0 ignored)
		read to get current status
 14-2	reserved
 1	"OCI"	OverCurrent Indicator
 0    R "LPS"	LocalPowerStatus (always 0 for Root Hub)
      W		write 1 to turn off power to all ports/ports with clear
		  PortPowerControlMask bits
SeeAlso: #3330,#3518,#3519,#3521

Bitfields for OpenHCI "HcRhPortStatusN" register:
Bit(s)	Description	(Table 3521)
 31-21	reserved
 20	"PRSC"	Port Reset Status Change (write '1' to clear)
 19	"OCIC"	Port OverCurrent Indiactor Change (write '1' to clear)
 18	"PSSC"	Port Suspend Status Change (write '1' to clear)
 17	"PESC"	Port Enable Status Change (write '1' to clear)
 16	"CSC"	Connect Status Change (write '1' to clear)
 15-10	reserved
 9    R	"LSDA"	Low Speed Device Attached
      W		clear port power by writing '1'
 8    R	"PPS"	Port Power Status
      W		set port power by writing '1'
 7-5	reserved
 4    R	"PRS"	Port Reset Status
      W		set port reset by writing '1'
 3    R	"POCI"	Port OverCurrent Indicator
      W		clear suspend status by writing '1'
 2    R	"PSS"	Port Suspend Status
      W		set port suspend by writing '1'
 1    R "PES"	Port Enable Status
      W		set port enable by writing '1'
 0    R "CCS"	current connect status
      W		clear port enable by writing '1'
SeeAlso: #3330,#3518,#3519,#3520
--------X-1AB10B-----------------------------
INT 1A - Intel PCI BIOS v2.0c - WRITE CONFIGURATION BYTE
	AX = B10Bh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
	CL = byte to write
Return: CF clear if successful
	CF set on error
	AH = status (00h,87h) (see #0625)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B108h,AX=B10Ch,AX=B10Dh,AX=B18Bh,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10C-----------------------------
INT 1A - Intel PCI BIOS v2.0c - WRITE CONFIGURATION WORD
	AX = B10Ch
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 2 less than 0100h)
	CX = word to write
Return: CF clear if successful
	CF set on error
	AH = status (00h,87h) (see #0625)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B109h,AX=B10Bh,AX=B10Dh,AX=B18Ch,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10D-----------------------------
INT 1A - Intel PCI BIOS v2.0c - WRITE CONFIGURATION DWORD
	AX = B10Dh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 4 less than 0100h)
	ECX = dword to write
Return: CF clear if successful
	CF set on error
	AH = status (00h,87h) (see #0625)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Bh,AX=B10Ch,AX=B18Dh,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10EBX0000-----------------------
INT 1A - Intel PCI BIOS v2.1+ - GET IRQ ROUTING INFORMATION
	AX = B10Eh
	BX = 0000h
	DS = segment/selector for PCI BIOS data
	    (real mode: F000h; 16-bit PM: physical 000F0000h; 32-bit PM: as
	    specified by BIOS32 services directory)
	ES:(E)DI -> IRQ routing table header (see #0666 at AX=B406h)
Return: CF clear if successful
	    AH = 00h
	    BX = bit map of IRQ channels permanently dedicated to PCI
	    WORD ES:[DI] = size of returned data
	CF set on error
	    AH = error code (59h) (see #0650)
	    WORD ES:[DI] = required size of buffer
SeeAlso: AX=B10Fh,AX=B406h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10F-----------------------------
INT 1A - Intel PCI BIOS v2.1+ - SET PCI IRQ
	AX = B10Fh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	CH = number of IRQ to connect
	CL = number of interrupt pin (0Ah=INTA# to 0Dh=INTD#) to reprogram
	DS = segment/selector for PCI BIOS data
	    (real mode: F000h; 16-bit PM: physical 000F0000h; 32-bit PM: as
	    specified by BIOS32 services directory)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (59h) (see #0650)
Note:	assumes that the calling application has determined the IRQ routing
	  topology (see AX=B10Eh), has ensured that the selected IRQ will not
	  cause a conflict, and will update the interrupt line configuration
	  register on all devices which currently use the IRQ line
SeeAlso: AX=B10Eh
--------X-1AB181-----------------------------
INT 1A - Intel PCI BIOS v2.0c - INSTALLATION CHECK (32-bit)
	AX = B181h
Return: as for AX=B101h
SeeAlso: AX=B101h
--------X-1AB182-----------------------------
INT 1A - Intel PCI BIOS v2.0c - FIND PCI DEVICE (32-bit)
	AX = B182h
	CX = device ID
	DX = vendor ID
	SI = device index (0-n)
Return: as for AX=B102h
SeeAlso: AX=B102h
--------X-1AB183-----------------------------
INT 1A - Intel PCI BIOS v2.0c - FIND PCI CLASS CODE (32-bit)
	AX = B183h
	ECX = class code (bits 23-0)
	SI = device index (0-n)
Return: as for AX=B103h
SeeAlso: AX=B103h
--------X-1AB186-----------------------------
INT 1A - Intel PCI BIOS v2.0c - PCI BUS-SPECIFIC OPERATIONS (32-bit)
	AX = B186h
	BH = bus number
	EDX = Special Cycle data
Return: as for AX=B106h
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B106h
--------X-1AB188-----------------------------
INT 1A - Intel PCI BIOS v2.0c - READ CONFIGURATION BYTE (32-bit)
	AX = B188h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
Return: as for AX=B108h
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B108h
--------X-1AB189-----------------------------
INT 1A - Intel PCI BIOS v2.0c - READ CONFIGURATION WORD (32-bit)
	AX = B189h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
Return: as for AX=B109h
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B109h
--------X-1AB18A-----------------------------
INT 1A - Intel PCI BIOS v2.0c - READ CONFIGURATION DWORD (32-bit)
	AX = B18Ah
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
Return: as for AX=B10Ah
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah
--------X-1AB18B-----------------------------
INT 1A - Intel PCI BIOS v2.0c - WRITE CONFIGURATION BYTE (32-bit)
	AX = B18Bh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
	CL = byte to write
Return: as for AX=B10Bh
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Bh
--------X-1AB18C-----------------------------
INT 1A - Intel PCI BIOS v2.0c - WRITE CONFIGURATION WORD (32-bit)
	AX = B18Ch
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 2 less than 0100h)
	CX = word to write
Return: as for AX=B10Ch
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ch
--------X-1AB18D-----------------------------
INT 1A - Intel PCI BIOS v2.0c - WRITE CONFIGURATION DWORD (32-bit)
	AX = B18Dh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 4 less than 0100h)
	ECX = dword to write
Return: as for AX=B10Dh
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Dh
--------X-1AB400-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - INSTALLATION CHECK
	AX = B400h
Return: CF clear if installed
	AX = 0000h if installed
	    BH = ACFG major version (02h)
	    BL = ACFG minor version (08h)
	    CX = ??? (0002h)
	    EDX = 47464341h ('GFCA', which is byte-swapped 'ACFG')
	    SI = ??? (001Fh)
SeeAlso: AX=B401h,AX=B402h,AX=B403h,AX=B404h,AX=B405h,AX=B406h,AX=B407h
SeeAlso: @xxxxh:xxxxh"Plug-and-Play"

(Table 0650)
Values for Intel Plug-and-Play AUTO-CONFIGURATION error codes:
 0000h	successful
 0001h	specified action could not be completed
 0051h	???
 0055h	unable to read/write configuration table from/to nonvolatile storage
 0056h	not a valid configuration table or wrong table version
 0059h	buffer too small
 0081h	unsupported function
 FFFFh	???
SeeAlso: #F053
--------X-1AB401-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET DEFAULT CONFIG TABLE
	AX = B401h
Return: CF clear if successful
	    AX = 0000h
	    BX = maximum size of configuration table in bytes
	    CX = required configuration buffer size
		(includes scratch space used by ACFG code)
	    EDI = linear/physical address of ESCD table (see #0651)
	CF set on error
	    AX = error code (see #0650)
SeeAlso: AX=B400h,AX=B402h,@xxxxh:xxxxh"Plug-and-Play"

Format of Intel Plug-and-Play Extended System Configuration Data table:
Offset	Size	Description	(Table 0651)
 00h	WORD	total length of this table
 02h  4 BYTEs	signature "ACFG"
 06h	BYTE	minor version number
 07h	BYTE	major version number (currently 02h)
 08h	BYTE	number of boards listed in the configuration data
 09h  3 BYTEs	reserved (00h)
 0Ch	var	board data
	WORD	checksum
Notes:	this table contains information about the standard devices in the
	  system, such as serial ports, parallel ports, etc.  For each device,
	  it includes at least the I/O port address (03F8h,02F8h,0378h,etc).
	the sum of all words in the table, including the checksum field (with
	  implied zero padding if the length is odd), must equal 0000h
SeeAlso: #0652

Format of Extended System Configuration Data Board Header:
Offset	Size	Description	(Table 0652)
 00h	WORD	length of this header in bytes
 02h	BYTE	slot number
		00h motherboard
		01h-0Fh ISA/EISA
		10h-40h	PCI
 03h	BYTE	reserved (00h)
SeeAlso: #0651,#0653

Format of Extended System Configuration Data Freeform Board Header:
Offset	Size	Description	(Table 0653)
 00h  4 BYTEs	signature "ACFG"
 04h	BYTE	minor version number
 05h	BYTE	major version number (currently 02h)
 06h	BYTE	board type
		01h ISA
		02h EISA
		04h PCI
		08h PCMCIA
		10h PnPISA
		20h MCA
 07h	BYTE	reserved (00h)
 08h	WORD	disabled functions (bit N set = function N disabled)
 0Ah	WORD	configuration error functions
 0Ch	WORD	reconfigurable functions (bit N set = function N reconfig'able)
 0Eh  2 BYTEs	reserved (00h)
SeeAlso: #0656,#0657

Format of Extended System Configuration Data Freeform PCI Device Data:
Offset	Size	Description	(Table 0654)
 00h	BYTE	PCI bus number
 01h	BYTE	PCI device and function number
 02h	WORD	PCI device identifier
 04h	WORD	PCI vendor ID (see #0629)
 06h  2 BYTEs	reserved (00h)
SeeAlso: #0654,#0657

Format of Extended System Configuration Data Freeform PnP ISA Board ID:
Offset	Size	Description	(Table 0655)
 00h	DWORD	vendor ID (EISA device identifier)
 04h	DWORD	serial number
SeeAlso: #0655,#0656

Format of Extended System Configuration Data PnP ISA ECD Extension Function:
Offset	Size	Description	(Table 0656)
 00h	WORD	001Eh (length of this structure)
 02h	BYTE	01h (selection size)
 03h	BYTE	00h (selection data)
 04h	BYTE	C0h (function information byte) (see #0659)
 05h	BYTE	18h (size of following free-format data)
 06h 16 BYTEs	freeform board header (see #0653)
 16h  8 BYTEs	Plug-and-Play board ID (see #0655)
Note:	ECD = Extended Configuration Data; this structure must be the last
	  "function" for a particular ISA Plug-and-Play board
SeeAlso: #0657

Format of Extended System Configuration Data PCI ECD Extension Function:
Offset	Size	Description	(Table 0657)
 00h	WORD	length of this structure (at least 001Eh, up to 0056h)
 02h	BYTE	01h (selection size)
 03h	BYTE	00h (selection data)
 04h	BYTE	C0h (function information byte) (see #0659)
 05h	BYTE	size of following free-format data (at least 18h, max 50h)
 06h 16 BYTEs	freeform board header (see #0653)
 16h 8N BYTEs	PCI board ID (see #0654) for one to eight boards
Notes:	ECD = Extended Configuration Data; this structure must be the last
	  "function" for a particular PCI board
	AMI BIOS v1.00.05.AX1 sets the length field to 001Ch for entries with
	  a single board ID, apparently treating the field as the length of
	  the remainder of the structure instead of the full structure's length
SeeAlso: #0656

Bitfields for EISA ID and Slot Information:
Bit(s)	Description	(Table 0658)
 3-0	selector among duplicate configuration file names (0000 if no dups)
 5-4	slot type
	00 expansion slot
	01 embedded
	10 virtual slot
	11 reserved
 6	ID is readable
 7	duplicate IDs present
 8	board can be disabled
 9	IOCHKERR supported
 10	board or entries locked
 13-11	reserved
 14	board does not have or need configuration file
 15	configuration not complete
SeeAlso: #0659

Bitfields for EISA Function Information:
Bit(s)	Description	(Table 0659)
 0	subtype data
 1	memory information (see #0660)
 2	IRQ information (see #0662)
 3	DMA information (see #0663)
 4	port range information (see #0664)
 5	port initialization data (see #0665)
 6	free form data
 7	function disabled
SeeAlso: #0656,#0657,#0658

Format of EISA Memory Information:
Offset	Size	Description	(Table 0660)
 00h	WORD	memory information flags (see #0661)
 02h  3 BYTEs	high 24 bits of memory start address (LSB first)
 05h	WORD	memory size in K (0000h = 65536K)
SeeAlso: #0659

Bitfields for EISA Memory Information Flags:
Bit(s)	Description	(Table 0661)
 0	writable (RAM rather than ROM)
 1	cached
 2	write-back cache rather than write-through
 4-3	memory type
	00 system
	01 expantion
	10 virtual
	11 other
 5	shared
 6	reserved (0)
 7	more entries follow
 9-8	memory width
	00 byte
	01 word
	10 dword
	11 reserved
 11-10	decoded address lines
	00 = 20
	01 = 24
	10 = 32
	11 reserved
 15-12	reserved (0)
SeeAlso: #0660

Bitfields for EISA IRQ Information:
Bit(s)	Description	(Table 0662)
 3-0	IRQ number
 4	reserved (0)
 5	IRQ triggering (0 = edge, 1 = level)
 6	IRQ is shareable
 7	more entries follow
 15-8	reserved (0)
SeeAlso: #0659

Bitfields for EISA DMA Information:
Bit(s)	Description	(Table 0663)
 2-0	DMA channel number
 5-3	reserved (0)
 6	shareable
 7	more entries follow
 9-8	reserved
 11-10	DMA transfer size
	00 byte
	01 word
	10 dword
	11 word, but count in bytes
 13-12	DMA timing
	00 ISA-compatible
	01 EISA type "A"
	10 EISA type "B"
	11 EISA type "C"/"F" (burst)
 15-14	reserved (0)
SeeAlso: #0659

Format of EISA Port Range Information:
Offset	Size	Description	(Table 0664)
 00h	BYTE	port description
		bits 4-0: number of sequential ports
		bit 5 reserved (0)
		bit 6: shareable
		bit 7: more entries follow
 01h	WORD	I/O port address
SeeAlso: #0659,#0665

Format of EISA Port Initialization Data:
Offset	Size	Description	(Table 0665)
 00h	BYTE	flags
		bits 1-0: port size
			00 byte
			01 word
			10 dword
			11 reserved
		bit 2: masked write
		bits 6-3 reserved (0)
		bit 7: more entries follow
 01h	???
SeeAlso: #0659,#0664
--------X-1AB402-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - COPY AND VERIFY CONFIG TABLE
	AX = B402h
	DS:SI -> configuration table (see #0651)
	ES:DI -> buffer for copy of configuration table
Return: CF clear if successful
	    AX = 0000h
	CF set on error
	    AX = error code (0055h,0056h) (see #0650)
Note:	the buffer pointed at by ES:DI must be at least as large as the
	  maximum configuration table size reported by AX=B401h
SeeAlso: AX=B400h,AX=B401h,AX=B403h
--------X-1AB403-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - STORE ESCD TABLE IN NVRAM
	AX = B403h
	DS:SI -> configuration table (see #0651)
Return: CF clear if successful
	    AX = 0000h
	CF set on error
	    AX = error code (0055h) (see #0650)
Note:	sets the configuration table's checksum field, then copies the table
	  into nonvolatile storage (i.e. FlashROM)
SeeAlso: AX=B400h,AX=B402h
--------X-1AB404-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET AVAILABLE IRQs???
	AX = B404h
	BX = bitmap of IRQs being used???
Return: CF clear if successful
	    AX = 0000h
	    BX = available for ISA??? (not(BXin) & A127h)
	    CX = available for on-board I/O??? (not(BXin) & 40D8h)
	    DX = available for PCI??? (either not(BXin) & 0E00h or 0000h)
	CF set on error
	    AX = error code (0051h) (see #0650)
Note:	the various vector types have also been called "shareable",
	  "unshareable", and "avoidable"
SeeAlso: AX=B400h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB405-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET ???
	AX = B405h
Return: AX = ??? (0008h)
SeeAlso: AX=B400h
--------X-1AB406-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET PCI IRQ ROUTING TABLE
	AX = B406h
	ES:DI -> IRQ routing table header (see #0666)
Return: CF clear if successful
	    AX = 0000h
	    WORD ES:[DI] = size of returned data
	CF set on error
	    AX = error code (0059h) (see #0650)
	    WORD ES:[DI] = required size of buffer
SeeAlso: AX=B400h,AX=B404h,AX=B10Eh,INT 2F/AX=1684h/BX=304Ch

Format of Intel Plug-and-Play AUTO-CONFIGURATION PCI IRQ routing header:
Offset	Size	Description	(Table 0666)
 00h	WORD	length of IRQ routing table buffer
 02h	DWORD	-> IRQ routing table array buffer (see #0667)

Format of Intel Plug-and-Play ACFG PCI IRQ routing table entry [array]:
Offset	Size	Description	(Table 0667)
 00h	BYTE	PCI bus number
 01h	BYTE	PCI device number (bits 7-3)
 02h	BYTE	link value for INTA#
		(if non-zero, wire-ORed together with any other PCI interrupts
		  with same link value)
 03h	WORD	IRQ connectivity bit map for INTA#
		(standard AT IRQs to which PCI interrupt can be routed)
 05h	BYTE	link value for INTB#
 06h	WORD	IRQ connectivity bit map for INTB#
 08h	BYTE	link value for INTC#
 09h	WORD	IRQ connectivity bit map for INTC#
 0Bh	BYTE	link value for INTD#
 0Ch	WORD	IRQ connectivity bit map for INTD#
 0Eh	BYTE	(PCI BIOS v2.1+) device slot number (00h = motherboard)
 0Fh	BYTE	reserved
Note:	each item in the routing table corresponds to a motherboard PCI
	  device or PCI slot
SeeAlso: #0666
--------X-1AB407-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - ???
	AX = B407h
	EDX = length of ???
	EDI = physical address of ???
Return: CF clear if successful
	    AX = 0000h
	    EDX = ???
	    EDI = ???
	CF set on error
	    AX = error code (FFFFh) (see #0650)
Notes:	returns error if EDI < 000C0000h or EDI+EDX > 00100000h
	seems to force EDI and EDX to align to 16K boundaries
SeeAlso: AX=B400h
--------X-1AB4-------------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - 32-BIT API
	AH = B4h
	AL = function (80h-87h)
	further details not yet available
Note:	these functions are 32-bit versions of functions 00h-07h
--------c-1AC0-------------------------------
INT 1A U - Disk Spool II v2.07+ - ALTERNATE INSTALLATION CHECK
	AH = C0h
Return: (see AH=A0h)
Notes:	this call is identical to AH=A0h
	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=ABh,AH=D0h
--------U-1ACCCCBXCCCC-----------------------
INT 1A U - DATEFIX - INSTALLATION CHECK
	AX = CCCCh
	BX = CCCCh
	CX = 0000h
Return: CX = CCCCh if installed
	    ES:BX -> original interrupt handler
Program: DATEFIX is a public-domain TSR to correct the date on AT&T 6300
	  machines, where the realtime clock's calendar wraps after 1991
SeeAlso: AH=FEh,AH=FFh"AT&T"
--------c-1AD0-------------------------------
INT 1A U - Disk Spool II v2.07+ - FUNCTION CALLS
	AH = D0h
	AL = function code
	    01h enable spooler and despooler
	    02h enable spooler only
	    03h enable despooler at beginning of file
	    04h disable the despooler
	    05h disable the despooler and spooler
	    06h clear the spool file
	    08h inhibit the popup menu
	    09h enable the popup menu
	    0Ah ??? (called by Disk Spool's INT 21 handler)
	    0Bh disable the spooler
	    0Ch start despooler after last successfully printed document
	    0Dh start despooler at the exact point where it last left off
	    0Eh pop up the menu
	    0Fh ???
	    11h start new spool file??? (called by Disk Spool's INT 21 handler
			when a program terminates)
	    14h ???
	    15h delete despool file and reset ???
	    16h ??? (writes something to unknown file)
	    17h ??? (writes something to despool file, then reads something
			else and ???)
	    18h ??? (reads something from despool file, and then ???)
	    19h ??? (creates/truncates spool file)
	    20h clear file pointed to by the despooler
	    21h ??? (writes something to unknown file)
	    22h ??? (writes something to spool file if spooler/despooler using
			same file)
	    23h ??? (opens/creates unknown file, then ???)
	    30h ???
	    31h ???
	    32h beep
	    33h append CRLF to spool file???
	    34h ???
	    35h ???
	    36h ???
	    37h append CRLF to spool file and start a new spool file???
	    38h ???
	    40h ??? (v4.05)
	    41h ??? (v4.05)
	    51h ??? (called by Disk Spool's INT 21 handler)
	    52h ??? (called by Disk Spool's INT 21 handler)
	    57h ???
	    5Ah ??? (v4.05)
	    5Bh ??? (v4.05)
	    5Ch ??? (v4.05)
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=ADh
--------c-1AE0-------------------------------
INT 1A - Disk Spool II v4.0x - ENABLE/DISABLE
	AH = E0h
	AL = subfunction
	    01h enable spooler
	    02h disable spooler
	    03h enable despooler
	    04h disable despooler
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
	    F0h printer port not managed by Disk Spool II
	    FFH failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=E1h,AX=E301h,AX=E401h
--------c-1AE1-------------------------------
INT 1A - Disk Spool II v4.0x - GET STATUS
	AH = E1h
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
		CL = despooler state (00h disabled, 41h enabled)
		CH = spooler state (00h disabled, 41h enabled)
		DL = despooler activity (00h standing by, 41h printing)
		ES:BX -> ASCIZ name of current spool file (or next if AutoSpool
			or AutoDespool enabled)
		ES:SI -> ASCIZ name of current despool file
		ES:DI -> 3-byte file extension used by Disk Spool II
	    F0h printer port not managed by Disk Spool II
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=E0h,AH=E2h
--------U-1AE11B-----------------------------
INT 1A - TheGrab v4.60 - ???
	AX = E11Bh
	???
Return: ??? (may destroy all registers)
SeeAlso: AX=E11Dh
--------U-1AE11D-----------------------------
INT 1A - TheGrab v4.60 - INSTALLATION CHECK
	AX = E11Dh
Return: ES:DI -> signature block (see #0668) if installed
	    CX = length of signature block (000Fh)
Program: TheGrab is a resident ANSI screen grabber bundled with TheDraw
SeeAlso: AX=E11Bh

Format of TheGrab signature block:
Offset	Size	Description	(Table 0668)
 00h	BYTE	08h
 01h  8 BYTEs	ASCIZ "THEGRAB"
 09h  6 BYTEs	??? (zeros)
--------c-1AE2-------------------------------
INT 1A - Disk Spool II v4.0x - GET SPOOL FILES
	AH = E2h
	AL = which
	    01h first
	    02h next (can only call after "first")
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
		ES:BX -> ASCIZ filename
	    F0h no (more) spool files
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E0h,AH=E1h
--------c-1AE301-----------------------------
INT 1A - Disk Spool II v4.0x - GET SPOOL FILE STATUS
	AX = E301h
	ES:BX -> ASCIZ filename (max 32 chars)
Return: AH = status
	    00h successful
		ES:SI -> spool file status record (see #0669)
	    F0h not a spool file
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E0h,AX=E302h,AX=E401h

Format of Disk Spool II spool file status record:
Offset	Size	Description	(Table 0669)
 00h	BYTE	hour of creation or last update
 01h	BYTE	minute of creation or last update
 02h	BYTE	year-1980 of creation or last update
 03h	BYTE	month of creation or last update
 04h	BYTE	day of creation or last update
 05h	BYTE	total number of copies to print
 06h	BYTE	number of copies already printed
 07h	BYTE	printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
 08h	BYTE	save status (00h delete after printing, 01h save)
 09h	BYTE	file status
		01h done printing, but being saved
		02h on hold
		03h queued for printing
		04h being spooled
		05h being despooled (i.e. printed)
 0Ah 16 BYTEs	ASCIZ description
 1Ah  2 WORDs	file size in bytes (high,low)
 1Eh  2 WORDs	bytes left to print (high,low)
--------c-1AE302-----------------------------
INT 1A - Disk Spool II v4.0x - UPDATE SPOOL FILE
	AX = E302h
	ES:BX -> ASCIZ filename (max 32 chars)
	ES:SI -> spool file status record (see #0669)
Return: AH = status
	    00h successful
	    F0h not a spool file
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E0h,AX=E301h,AX=E401h
--------c-1AE401-----------------------------
INT 1A - Disk Spool II v4.0x - SPOOL EXISTING FILE
	AX = E401h
	ES:BX -> ASCIZ filename (max 32 chars)
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E1h,AX=E302h,AX=E402h
--------c-1AE402-----------------------------
INT 1A U - Disk Spool II v4.0x - SPOOL EXISTING FILE???
	AX = E402h
	ES:BX -> ASCIZ filename (max 32 chars)
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E1h,AX=E302h,AX=E401h
--------c-1AE5-------------------------------
INT 1A U - Emulaser ELSPL.COM - ???
	AH = E5h
	???
Return: ???
Program: ELSPL.COM is a licensed version of Disk Spool II which is distributed
	  as part of Vertisoft's Emulaser PostScript emulator
SeeAlso: AH=A0h,INT 17/AH=03h
--------c-1AEE-------------------------------
INT 1A U - Disk Spool II v4.05 - ???
	AH = EEh
	AL = printer port???
	???
Return: ???
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E1h
--------U-1AF7-------------------------------
INT 1A - RighTime v1.1 - TEMPORARILY DISABLE
	AH = F7h
Program: RighTime is a TSR by G.T. Becker which continuously adjusts the
	  system time to correct for clock drift
Note:	any AH value from F0h-F7h or F9h-FEh will perform this function in
	  version 1.1, but F7h is the function called by transient portion
SeeAlso: AH=F8h,AH=FFh"RighTime"
--------U-1AF8-------------------------------
INT 1A - RighTime v1.1 - ENABLE
	AH = F8h
Program: RighTime is a TSR by G.T. Becker which continuously adjusts the
	  system time to correct for clock drift
Note:	RighTime is TeSseRact-compatible (see INT 2F/AX=5453h) and modifies its
	  TeSseRact program identifier based on its current state: "RighTime"
	  when enabled, "RighTim"F7h when disabled.
SeeAlso: AH=F7h,AH=FFh"RighTime"
--------b-1AFE-------------------------------
INT 1A - AT&T 6300 - READ TIME AND DATE
	AH = FEh
Return: BX = day count (0 = Jan 1, 1984)
	CH = hour
	CL = minute
	DH = second
	DL = hundredths
SeeAlso: AX=CCCCh/BX=CCCCh,AH=FFh"AT&T",INT 21/AH=2Ah,INT 21/AH=2Ch
--------b-1AFF-------------------------------
INT 1A - AT&T 6300 - SET TIME AND DATE
	AH = FFh
	BX = day count (0 = Jan 1, 1984)
	CH = hour
	CL = minute
	DH = second
	DL = hundredths
Return: ???
SeeAlso: AX=CCCCh/BX=CCCCh,AH=FEh,INT 21/AH=2Bh"DATE",INT 21/AH=2Dh
--------U-1AFF-------------------------------
INT 1A - RighTime v1.1 - PERMANENTLY DISABLE
	AH = FFh
Program: RighTime is a TSR by G.T. Becker which continuously adjusts the
	  system time to correct for clock drift
Note:	upon being permanently disabled, RighTime closes the file handle
	  referencing its executable (which is updated with time correction
	  information every two minutes while RighTime is enabled).
--------s-1AFF00-----------------------------
INT 1A - SND - INSTALLATION CHECK???
	AX = FF00h
Return: AL = version??? (02h)
	AH = busy flag (00h if not in a SND call, 01h if SND currently active)
Note:	the SND API is also supported by IC (Internal Commands) v2.0, a
	  shareware TSR by Geoff Friesen which extends COMMAND.COM's internal
	  command set
SeeAlso: AX=FF01h,AX=FF02h,AX=FF04h,AX=FF05h
--------s-1AFF01-----------------------------
INT 1A - SND - PAUSE
	AX = FF01h
	DX = number of clock ticks to delay
Return: AH = status
	    00h successful
	    01h SND busy
Notes:	if successful, execution returns to the caller after the delay expires;
	  if SND is busy, execution returns immediately
	the IC v2.0 implementation of this API makes no special allowance for
	  time rollover at midnight, which can cause the delay to be over one
	  hour if this function is called just before the BIOS time count
	  rolls over and the delay extends into the next day
SeeAlso: AX=FF00h,INT 15/AH=86h,INT 62/AX=0096h,INT 7F/AH=E8h,INT 80/BX=0009h
SeeAlso: INT E0/CL=BDh
--------s-1AFF02-----------------------------
INT 1A - SND - START SOUND
	AX = FF02h
	DX = frequency in Hertz (14h-FFFFh)
Return: AH = status
	    00h successful
	    01h SND busy
SeeAlso: AX=FF00h,AX=FF01h,AX=FF03h
--------s-1AFF03-----------------------------
INT 1A - SND - STOP SOUND
	AX = FF03h
Return: AH = status
	    00h successful
	    01h busy
Note:	turns off any sound currently being emitted by the PC's speaker unless
	  SND is currently busy processing an API call (this includes
	  background music).  Use AX=FF05h to stop the sound even if an API
	  call is in progress.
SeeAlso: AX=FF00h,AX=FF02h,AX=FF05h
--------s-1AFF04-----------------------------
INT 1A - SND - PLAY MUSIC STRING IN BACKGROUND
	AX = FF04h
	DS:DX -> ASCIZ music string
Return: AH = status
	    00h successful (music begins playing in background)
	    01h busy
Note:	the music string accepted by SND is not the same as that accepted by
	  BASIC and other programs which process music strings
SeeAlso: AX=FF00h,AX=FF05h,INT 80/BX=0006h
--------s-1AFF05-----------------------------
INT 1A - SND - UNCONDITIONALLY STOP SOUND
	AX = FF05h
Return: AH = 00h (successful)
Note:	this function is the same as AX=FF03h, but will stop the sound even if
	  SND is currently busy, such as playing background music
SeeAlso: AX=FF00h,AX=FF03h,INT 80/BX=0007h
--------B-1B---------------------------------
INT 1B C - KEYBOARD - CONTROL-BREAK HANDLER
Desc:	this interrupt is automatically called when INT 09 determines that
	  Control-Break has been pressed
Note:	normally points to a short routine in DOS which sets the Ctrl-C flag,
	  thus invoking INT 23h the next time DOS checks for Ctrl-C.
SeeAlso: INT 23
--------B-1C---------------------------------
INT 1C - TIME - SYSTEM TIMER TICK
Desc:	this interrupt is automatically called on each clock tick by the INT 08
	  handler
Notes:	this is the preferred interrupt to chain when a program needs to be
	  invoked regularly
	not available on NEC 9800-series PCs
SeeAlso: INT 08,INT E2"PC Cluster"
--------B-1D---------------------------------
INT 1D - SYSTEM DATA - VIDEO PARAMETER TABLES
Note:	the default parameter table (see #0670) is located at F000h:F0A4h for
	  100% compatible BIOSes
SeeAlso: INT 10/AH=00h

Format of video parameters:
Offset	Size	Description	(Table 0670)
 00h 16 BYTEs	6845 register values for modes 00h and 01h
 10h 16 BYTEs	6845 register values for modes 02h and 03h
 20h 16 BYTEs	6845 register values for modes 04h and 05h
 30h 16 BYTEs	6845 register values for modes 06h and 07h
 40h	WORD	bytes in video buffer for modes 00h and 01h (0800h)
 42h	WORD	bytes in video buffer for modes 02h and 03h (1000h)
 44h	WORD	bytes in video buffer for modes 04h and 05h (4000h)
 46h	WORD	bytes in video buffer for mode 06h (4000h)
 48h  8 BYTEs	columns on screen for each of modes 00h through 07h
 50h  8 BYTEs	CRT controller mode bytes for each of modes 00h through 07h
Note:	QEMM v7.5 Stealth appears to copy only the first 40h bytes of this
	  table into always-accessible memory
--------B-1E---------------------------------
INT 1E - SYSTEM DATA - DISKETTE PARAMETERS
Notes:	the default parameter table (see #0671) is located at F000h:EFC7h for
	  100% compatible BIOSes
	if the table is changed, INT 13/AH=00h should be called to ensure that
	  the floppy-disk controller is appropriately reprogrammed
SeeAlso: INT 13/AH=0Fh,INT 41"HARD DISK 0",INT 4D/AH=0Ah

Format of diskette parameter table:
Offset	Size	Description	(Table 0671)
 00h	BYTE	first specify byte
		bits 7-4: step rate
		bits 3-0: head unload time (0Fh = 240 ms)
 01h	BYTE	second specify byte
		bits 7-1: head load time (01h = 4 ms)
		bit    0: non-DMA mode (always 0)
 02h	BYTE	delay until motor turned off (in clock ticks)
 03h	BYTE	bytes per sector (00h = 128, 01h = 256, 02h = 512, 03h = 1024)
 04h	BYTE	sectors per track
 05h	BYTE	length of gap between sectors (2Ah for 5.25", 1Bh for 3.5")
 06h	BYTE	data length (ignored if bytes-per-sector field nonzero)
 07h	BYTE	gap length when formatting (50h for 5.25", 6Ch for 3.5")
 08h	BYTE	format filler byte (default F6h)
 09h	BYTE	head settle time in milliseconds
 0Ah	BYTE	motor start time in 1/8 seconds
SeeAlso: #2481 at INT 4D/AH=09h
--------B-1F---------------------------------
INT 1F - SYSTEM DATA - 8x8 GRAPHICS FONT
Desc:	this vector points at 1024 bytes of graphics data, 8 bytes for each
	  character 80h-FFh
Note:	graphics data for characters 00h-7Fh stored at F000h:FA6Eh in 100%
	  compatible BIOSes
SeeAlso: INT 10/AX=5000h,INT 43
--------b-1F12-------------------------------
INT 1F U - C&T "SuperState" BIOS - POWER OFF
	AH = 12h
Return: none
Note:	POWER OFF
--------b-1F17-------------------------------
INT 1F U - C&T "SuperState" BIOS - EXECUTE FAR PROC ROUTINE ON SuperState
	AH = 17h
	ES:DI -> far procedure
Return: all registers except AH,ES,DI
Note:	You can change the BIOS area (F000h:0000h - F000h:FFFFh) only through
	  this function
--------b-1F19-------------------------------
INT 1F U - C&T "SuperState" BIOS - ENABLE AUTO WAKEUP AND SET TIME AND DATE
	AH = 19h
	AL = hour in BCD
	BH = minutes in BCD
	BL = seconds in BCD
	CH = year century in BCD (must be 19h)
	CL = year low in BCD
	DH = month in BCD
	DL = date in BCD
Return: CF clear
--------b-1F1C-------------------------------
INT 1F U - C&T "SuperState" BIOS - SET SUSPEND TIMEOUT
	AH = 1Ch
	BX = sec until suspend starts
Return: None
--------b-1F1D-------------------------------
INT 1F U - C&T "SuperState" BIOS - SET SLEEP TIMEOUT
	AH = 1Dh
	BX = sec until sleep starts
Return: None
--------J-1F90-------------------------------
INT 1F - NEC PC-9801 - COPY EXTENDED MEMORY
	AH = 90h
	ES:BX -> global descriptor table (see #0403 at INT 15/AH=87h)
	CX = number of bytes to copy
	SI = 0000h
	DI = 0000h
Return: CF clear if successful
	CF set on error
	???
SeeAlso: INT 15/AH=87h
--------b-1FF5--BLFA-------------------------
INT 1F U - C&T "SuperState" BIOS - REQUEST PASSWORD INPUT
	AH = F5h
	BL = FAh
Return: none
Note:	this function will not return until the correct password is entered
SeeAlso: AH=F5h/BL=FDh,AH=F5h/BL=FEh
--------b-1FF5--BLFD-------------------------
INT 1F U - C&T "SuperState" BIOS - ENCRYPT PASSWORD
	AH = F5h
	BL = FDh
	CX:SI = input string
	DX:DI = encrypted string
	BH = length of input string
Return: CF set on error
SeeAlso: AH=F5h/BL=FAh,AH=F5h/BL=FEh
--------b-1FF5--BLFE-------------------------
INT 1F U - C&T "SuperState" BIOS - SET PASSWORD
	AH = F5h
	BL = FEh
	CX:SI -> input string
	BH = length of input string (if BH = 00h, clear password)
Return: CF set on error
Note:	the input string must be encrypted by INT 1Fh/AH=F5h/BL=FDh
SeeAlso: AH=F5h/BL=FDh,AH=F5h/BL=FFh
--------b-1FF5--BLFF-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ENCRYPTED PASSWORD
	AH = F5h
	BL = FFh
	DX:DI = string buffer
Return: CF set on error
	CF clear if successful
	    BH = length of input string (if BH = 00h, password is not valid)
	    DX:DI -> encrypted password string
SeeAlso: AH=F5h/BL=FDh,AH=F5h/BL=FEh
--------b-1FFB-------------------------------
INT 1F U - C&T "SuperState" BIOS - GET/SET CPU SPEED
	AH = FBh
	BL = function
	    00h get CPU speed
		Return: AL = current CPU speed (00h = fast, 01h = slow)
	    01h set CPU speed
		AL = new CPU speed (00h = fast, 01h = slow)
SeeAlso: AH=FCh/BL=00h
--------b-1FFC--BL00-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ALARM STATUS
	AH = FCh
	BL = 00h
Return: AL = current alarm state (00h = disabled, 01h = enabled)
SeeAlso: AH=FCh/BL=01h,AH=FCh/BL=02h
--------b-1FFC--BL01-------------------------
INT 1F U - C&T "SuperState" BIOS - SET ALARM STATUS
	AH = FCh
	BL = 01h
	AL = new alarm state (00h = disabled, 01h = enabled)
SeeAlso: AH=FCh/BL=00h,AH=FCh/BL=03h
--------b-1FFC--BL02-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ALARM TIME
	AH = FCh
	BL = 02h
Return: CH = hour by BCD
	CL = min by BCD
	DH = sec by BCD
SeeAlso: AH=FCh/BL=00h,AH=FCh/BL=03h,AH=FCh/BL=04h
--------b-1FFC--BL03-------------------------
INT 1F U - C&T "SuperState" BIOS - SET ALARM TIME
	AH = FCh
	BL = 03h
	CH = hour by BCD
	CL = min by BCD
	DH = sec by BCD
Return: CF set on error (incorrect time format or Alarm is not enable)
SeeAlso: AH=FCh/BL=01h,AH=FCh/BL=02h,AH=FCh/BL=05h
--------b-1FFC--BL04-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ALARM DATE
	AH = FCh
	BL = 04h
Return: CH = year century by BCD
	CL = year low by BCD
	DH = month by BCD
	DL = date by BCD
SeeAlso: AH=FCh/BL=02h,AH=FCh/BL=05h
--------b-1FFC--BL05-------------------------
INT 1F U - C&T "SuperState" BIOS - SET ALARM DATE
	AH = FCh
	BL = 05h
	CH = year century by BCD
	CL = year low by BCD
	DH = month by BCD
	DL = date by BCD
Return: CF set on error (incorrect date format or Alarm is not enable)
SeeAlso: AH=FCh/BL=03h,AH=FCh/BL=04h
--------b-1FFD--BL00-------------------------
INT 1F U - C&T "SuperState" BIOS - GET AUTO WAKE UP STATUS
	AH = FDh
	BL = 00h
Return: AL = current wake-up state (00h = disabled, 01h = enabled)
SeeAlso: AH=FDh/BL=01h,AH=FDh/BL=02h
--------b-1FFD--BL01-------------------------
INT 1F U - C&T "SuperState" BIOS - SET AUTO WAKE UP STATUS
	AH = FDh
	BL = 01h
	AL = new wake-up state (00h = disabled, 01h = enabled)
SeeAlso: AH=FDh/BL=00h,AH=FDh/BL=03h
--------b-1FFD--BL02-------------------------
INT 1F U - C&T "SuperState" BIOS - GET AUTO WAKE UP TIME
	AH = FDh
	BL = 02h
Return: CH = hour by BCD
	CL = min by BCD
	DH = sec by BCD
SeeAlso: AH=FDh/BL=00h,AH=FDh/BL=03h
--------b-1FFD--BL03-------------------------
INT 1F U - C&T "SuperState" BIOS - SET AUTO WAKE UP TIME
       AH = FDh
       BL = 03h
       CH = hour by BCD
       CL = min by BCD
       DH = sec by BCD
Return: CF set on error (incorrect Time format or Auto Wake up is not enable)
SeeAlso: AH=FDh/BL=01h,AH=FDh/BL=02h
--------b-1FFD--BL04-------------------------
INT 1F U - C&T "SuperState" BIOS - GET AUTO WAKE UP DATE
	AH = FDh
	BL = 04h
Return: CH = year century in BCD
	CL = year low in BCD
	DH = month in BCD
	DL = date in BCD
SeeAlso: AH=FDh/BL=02h,AH=FDh/BL=05h
--------b-1FFD--BL05-------------------------
INT 1F U - C&T "SuperState" BIOS - SET AUTO WAKE UP DATE
	AH = FDh
	BL = 05h
	CH = year century in BCD
	CL = year low in BCD
	DH = month in BCD
	DL = date in BCD
Return: CF set on error (incorrect date format or Auto Wake up is not enable)
SeeAlso: AH=FDh/BL=03h"C&T",AH=FDh/BL=04h"C&T"
--------O-20---------------------------------
INT 20 - Minix - SEND/RECEIVE MESSAGE
	AX = process ID of other process
	BX -> message
	CX = operation (1 send, 2 receive, 3 send&receive)
Program: Minix is a Version 7 Unix-compatible operating system by Andrew
	  Tanenbaum
Note:	the message contains the system call number (numbered as in V7
	  Unix(tm)) and the call parameters
--------D-20---------------------------------
INT 20 - DOS 1+ - TERMINATE PROGRAM
	CS = PSP segment
Return: never
Notes:	(see INT 21/AH=00h)
	this function sets the program's return code (ERRORLEVEL) to 00h
SeeAlso: INT 21/AH=00h,INT 21/AH=4Ch
--------G-20---------------------------------
INT 20 - COMTROL HOSTESS i/ISA DEBUGGER - INVOKE FIRMWARE DEBUGGER
	???
Return: ???
SeeAlso: INT 21"COMTROL"
--------W-20---------------------------------
INT 20 P - Microsoft Windows - VxD SERVICES
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0672,#3382

(Table 0672)
Values for VMM (VxD ID 0001h) service number:
 0000h	get version
 0001h	get current VM handle
 0002h	test current VM handle
 0003h	get system VM handle
 0004h	test system VM handle
 0005h	validate VM handle
 0006h	get VMM reenter count
 0007h	begin reentrant execution
 0008h	end reentrant execution
 0009h	install V86 breakpoint
 000Ah	remove V86 breakpoint
 000Bh	allocate V86 callback
 000Ch	allocation PM callback
 000Dh	call when VM returns
 000Eh	schedule global event
 000Fh	schedule VM event
 0010h	call global event
 0011h	call VM event
 0012h	cancel global event
 0013h	cancel VM event
 0014h	call priority VM event
 0015h	cancel priority VM event
 0016h	get NMI handler address
 0017h	set NMI handler address
 0018h	hook NMI event
 0019h	call when VM interrupts enabled
 001Ah	enable VM interrupts
 001Bh	disable VM interrupts
 001Ch	map flat
 001Dh	map linear to VM address
 001Eh	adjust execution priority
 001Fh	begin critical section
 0020h	end critical section
 0021h	end critical section and suspend
 0022h	claim critical section
 0023h	release critical section
 0024h	call when not critical
 0025h	create semaphore
 0026h	destroy semaphore
 0027h	wait on semaphore
 0028h	signal semaphore
 0029h	get critical section status
 002Ah	call when task switched
 002Bh	suspend VM
 002Ch	resume VM
 002Dh	no-fail resume VM
 002Eh	nuke VM
 002Fh	crash current VM
 0030h	get execution focus
 0031h	set execution focus
 0032h	get time slice priority
 0033h	set time slice priority
 0034h	get time slice granularity
 0035h	set time slice granularity
 0036h	get time slice information
 0037h	adjust execution time
 0038h	release time slice
 0039h	wake up VM
 003Ah	call when idle
 003Bh	get next VM handle
 003Ch	set global timeout
 003Dh	set VM timeout
 003Eh	cancel timeout
 003Fh	get system time
	Return: EAX = time in milliseconds that Windows has been running
 0040h	get VM execution time
 0041h	hook V86 interrupt chain
 0042h	get V86 interrupt vector
 0043h	set V86 interrupt vector
 0044h	get PM interrupt vector
 0045h	set PM interrupt vector
 0046h	simulate interrupt
 0047h	simulate IRET
 0048h	simulate far call
 0049h	simulate far jump
 004Ah	simulate far RET
 004Bh	simulate far RET N
 004Ch	build interrupt stack frame
 004Dh	simulate push
 004Eh	simulate pop
 004Fh	_HeapAllocate
 0050h	_HeapReAllocate
 0051h	_HeapFree
 0052h	_HeapGetSize
 0053h	_PageAllocate
 0054h	_PageReAllocate
 0055h	_PageFree
 0056h	_PageLock
 0057h	_PageUnLock
 0058h	_PageGetSizeAddr
 0059h	_PageGetAllocInfo
 005Ah	_GetFreePageCount
 005Bh	_GetSysPageCount
 005Ch	_GetVMPgCount
 005Dh	_MapIntoV86
 005Eh	_PhysIntoV86
 005Fh	_TestGlobalV86Mem
 0060h	_ModifyPageBits
 0061h	copy page table
 0062h	map linear into V86
 0063h	linear page lock
 0064h	linear page unlock
 0065h	_SetResetV86Pageabl
 0066h	_GetV86PageableArray
 0067h	_PageCheckLinRange
 0068h	page out dirty pages
 0069h	discard pages
 006Ah	_GetNulPageHandle
 006Bh	get first V86 page
 006Ch	map physical address to linear address
 006Dh	_GetAppFlatDSAlias
 006Eh	_SelectorMapFlat
 006Fh	_GetDemandPageInfo
 0070h	_GetSetPageOutCount
 0071h	hook V86 page
 0072h	assign device V86 pages
 0073h	deassign device V86 pages
 0074h	get array of V86 pages for device
 0075h	_SetNULPageAddr
 0076h	allocate GDT selector
 0077h	free GDT selector
 0078h	allocate LDT selector
 0079h	free LDT selector
 007Ah	_BuildDescriptorDWORDs
 007Bh	get descriptor
 007Ch	set descriptor
 007Dh	toggle HMA
 007Eh	get fault hook addresses
 007Fh	hook V86 fault
 0080h	hook PM fault
 0081h	hook VMM fault
 0082h	begin nested V86 execution
 0083h	begin nested execution
 0084h	execute V86-mode interrupt
 0085h	resume execution
 0086h	end nested execution
 0087h	allocate PM application callback area
 0088h	get current PM application callback area
 0089h	set V86 execution mode
 008Ah	set PM execution mode
 008Bh	begin using locked PM stack
 008Ch	end using locked PM stack
 008Dh	save client state
 008Eh	restore client state
 008Fh	execute VxD interrupt
 0090h	hook device service
	EAX = service ID (high word = VxD ID, low = service number)
	ESI -> new handler
 0091h	hook device V86 API
 0092h	hook device PM API
 0093h	system control (see also #1972)
 0094h	simulate I/O
 0095h	install multiple I/O handlers
 0096h	install I/O handler
 0097h	enable global trapping
 0098h	enable local trapping
 0099h	disable global trapping
 009Ah	disable local trapping
 009Bh	create list
 009Ch	destroy list
 009Dh	allocate list
 009Eh	attach list
 009Fh	attach list tail
 00A0h	insert into list
 00A1h	remove from list
 00A2h	deallocate list
 00A3h	get first item in list
 00A4h	get next item in list
 00A5h	remove first item in list
 00A6h	add instance item
 00A7h	allocate device callback area
 00A8h	allocate global V86 data area
 00A9h	allocate temporary V86 data area
 00AAh	free temporary V86 data area
 00ABh	get decimal integer from profile
 00ACh	convert decimal string to integer
 00ADh	get fixed-point number from profile
 00AEh	convert fixed-point string
 00AFh	get hex integer from profile
 00B0h	convert hex string to integer
 00B1h	get boolean value from profile
 00B2h	convert boolean string
 00B3h	get string from profile
 00B4h	get next string from profile
 00B5h	get environment string
 00B6h	get exec path
 00B7h	get configuration directory
 00B8h	open file
 00B9h	get PSP segment
 00BAh	get DOS vectors
 00BBh	get machine information
 00BCh	get/set HMA information
 00BDh	set system exit code
 00BEh	fatal error handler
 00BFh	fatal memory error
 00C0h	update system clock
 00C1h	test if debugger installed
 00C2h	output debugger string
 00C3h	output debugger character
 00C4h	input debugger character
 00C5h	debugger convert hex to binary
 00C6h	debugger convert hex to decimal
 00C7h	debugger test if valid handle
 00C8h	validate client pointer
 00C9h	test reentry
 00CAh	queue debugger string
 00CBh	log procedure call
 00CCh	debugger test current VM
 00CDh	get PM interrupt type
 00CEh	set PM interrupt type
 00CFh	get last updated system time
 00D0h	get last updated VM execution time
 00D1h	test if double-byte character-set lead byte
 00D2h	_AddFreePhysPage
 00D3h	_PageResetHandlePAddr
 00D4h	_SetLastV86Page
 00D5h	_GetLastV86Page
 00D6h	_MapFreePhysReg
 00D7h	_UnmapFreePhysReg
 00D8h	_XchgFreePhysReg
 00D9h	_SetFreePhysRegCalBk
 00DAh	get next arena (MCB)
 00DBh	get name of ugly TSR
 00DCh	get debug options
 00DDh	set physical HMA alias
 00DEh	_GetGlblRng0V86IntBase
 00DFh	add global V86 data area
 00E0h	get/set detailed VM error
 00E1h	Is_Debug_Chr
 00E2h	clear monochrome screen
 00E3h	output character to mono screen
 00E4h	output string to mono screen
 00E5h	set current position on mono screen
 00E6h	get current position on mono screen
 00E7h	get character from mono screen
 00E8h	locate byte in ROM
 00E9h	hook invalid page fault
 00EAh	unhook invalid page fault
 00EBh	set delete on exit file
 0129h	"_Register_Win32_Services"
 013Fh	get start of VxD chain (see also #1972 at INT 2F/AX=1684h/BX=0017h)
 0146h	"Get_DDB"
 0148h	"_RegOpenKey"
 0149h	"_RegCloseKey"
 0151h	"_RegQueryValueEx"
 0191h	...last service for Windows95 SP1
 811Ch	??? (called by KEYREMAP.VXD)
	EAX = service ID (high word = VxD ID, low = service number)
	ESI -> handler
SeeAlso: #0673,INT 2F/AX=1684h/BX=0001h

(Table 0673)
Values for VPICD (VxD ID 0003h) service number:
 00h	get version
 01h	virtualize IRQ
 02h	set interrupt request
 03h	clear interrupt request
 04h	physical EOI
 05h	get complete status
 06h	get status
 07h	test physical request
 08h	physically mask
 09h	physically unmask
 0Ah	set automatic masking
 0Bh	get IRQ complete status
 0Ch	convert handle to IRQ
 0Dh	convert IRQ to interrupt
 0Eh	convert interrupt to IRQ
 0Fh	call on hardware interrupt
 10h	force default owner
 11h	force default behavior
 18h	...last service for Windows95 SP1
SeeAlso: #0672,#0674,INT 2F/AX=1684h/BX=0003h

(Table 0674)
Values for VDMAD (VxD ID 0004h) service number:
 00h	get version
 01h	virtualize channel
 02h	get region information
 03h	set region information
 04h	get virtual state
 05h	set virtual state
 06h	set physical state
 07h	mask channel
 08h	unmask channel
 09h	lock DMA region
 0Ah	unlock DMA region
 0Bh	scatter lock
 0Ch	scatter unlock
 0Dh	reserve buffer space
 0Eh	request buffer
 0Fh	release buffer
 10h	copy to buffer
 11h	copy from buffer
 12h	default handler
 13h	disable translation
 14h	enable translation
 15h	get EISA address mode
 16h	set EISA address mode
 17h	unlock DMA region (ND)
 ...
 21h	...last service for Windows95 SP1
SeeAlso: #0673,#1969,#1981 at INT 2F/AX=1684h/BX=0444h

(Table 0675)
Values for VTD (VxD ID 0005h) service number:
 0000h	get version
 0001h	update system clock
 0002h	get interrupt period
 0003h	begin minimum interrupt period
 0004h	end minimum interrupt period
 0005h	disable trapping
 0006h	enable trapping
 0007h	get real time
	Return: EDX:EAX = time in 840ns units since Windows was started
 0008h	"VTD_Get_Date_And_Time"
 0009h	???
 000Ah	...last service for Windows95 SP1
SeeAlso: #1969 at INT 2F/AX=1684h/BX=0005h

(Table 0676)
Values for V86MMGR (VxD ID 0006h) service number:
 00h	get version
 01h	allocate V86 pages
 02h	set EMS and XMS limits
 03h	get EMS and XMS limits
 04h	set mapping information
 05h	get mapping information
 06h	Xlat API
 07h	load client pointer
 08h	allocate buffer
 09h	free buffer
 0Ah	get Xlat buffer state
 0Bh	set Xlat buffer state
 0Ch	get VM flat selector
 0Dh	map pages
 0Eh	free page map region
 0Fh	_LocalGlobalReg
 10h	get page status
 11h	set local A20
 12h	reset base pages
 13h	set available mapped pages
 14h	"V86MMGR_NoUMBInitCalls"
 15h	"V86MMGR_Get_EMS_XMS_Avail"
 16h	"V86MMGR_Toggle_HMA"
 17h	"V86MMGR_Dev_Init"
 18h	"V86MMGR_Alloc_UM_Page"
SeeAlso: #1969,#0677,INT 2F/AX=1684h"DEVICE API"

(Table 0677)
Values for PageSwap (VxD ID 0007h) service number:
 00h	get version
 01h	test create
 02h	create swap file
 03h	destroy swap file
 04h	in
 05h	out
 06h	test if I/O valid
 07h	"Read_Or_Write"
 08h	"Grow_File"
 09h	"Init_File"
SeeAlso: #0676,#3349,#0678,#1970

(Table 3349)
Values for REBOOT (VxD ID 0009h) service number:
 00h	???
 03h	...last service for Windows95 SP1
SeeAlso: #0677,#0678,#1968

(Table 0678)
Values for VDD (VxD ID 000Ah) service number:
 00h	get version
 01h	PIF state
 02h	get GrabRtn
 03h	hide cursor
 04h	set VM type
 05h	get ModTime
 06h	set HCurTrk
 07h	message clear screen
 08h	message foreground color
 09h	message background color
 0Ah	message output text
 0Bh	message set cursor position
 0Ch	query access
 0Dh	"VDD_Check_Update_Soon"
 ...
 16h	...last service for Windows95 SP1
SeeAlso: #3349,#0679,#1970

(Table 0679)
Values for VSD (VxD ID 000Bh) service number:
 00h	get version
 01h	bell
 02h	sound on
 03h	"VSD_TakeSoundPort"
SeeAlso: #0678,#0680

(Table 0680)
Values for VMD / VMOUSE (VxD ID 000Ch) service number:
 00h	get version
 01h	set mouse type
 02h	get mouse owner
 03h	"VMOUSE_Post_Pointer_Message"
 04h	"VMOUSE_Set_Cursor_Proc"
 05h	"VMOUSE_Call_Cursor_Proc"
 06h	"VMOUSE_Set_Mouse_Data~Get_Mouse_Data"
 07h	"VMOUSE_Manipulate_Pointer_Message"
 08h	"VMOUSE_Set_Middle_Button"
 ...
 0Bh	...last service for Windows95 SP1
SeeAlso: #0679,#0681,INT 2F/AX=1684h/BX=000Ch

(Table 0681)
Values for VKD (VxD ID 000Dh) service number:
 00h	get version
 01h	define hotkey
 02h	remove hotkey
 03h	locally enable hotkey
 04h	locally disable hotkey
 05h	reflect hotkey
 06h	cancel hotkey state
 07h	force keys
 08h	get keyboard owner
 09h	define paste mode
 0Ah	start pasting
 0Bh	cancel paste
 0Ch	get message key
 0Dh	peek message key
 0Eh	flush message key queue
 14h	...last service for Windows95 SP1
SeeAlso: #0680,#0682

(Table 0682)
Values for VCD (VxD ID 000Eh) service number:
 00h	get version
 01h	set port global
 02h	get focus
 03h	virtualize port
 ...
 0Ch	...last service for Windows95 SP1
SeeAlso: #0681,#0683

(Table 0683)
Values for BlockDev/IOS (VxD ID 0010h) service number:
 00h	get version
 01h	register device
 02h	find INT 13 drive
 03h	get device list
 04h	send command
 05h	command complete
 06h	synchronous command
 07h	"IOS_Register"
 08h	"IOS_Requestor_Service"
 09h	"IOS_Exclusive_Access"
 0Ah	"IOS_Send_Next_Command"
 0Bh	"IOS_Set_Async_Time_Out"
 0Ch	"IOS_Signal_Semaphore_No_Switch"
 0Dh	"IOSIdleStatus"
 0Eh	"IOSMapIORSToI24"
 0Fh	"IOSMapIORSToI21"
 10h	...last service for Windows95 SP1
SeeAlso: #0682,#3350

(Table 3350)
Values for VMCPD (VxD ID 0011h) service number:
 00h	"VMCPD_Get_Version"
 01h	"VMCPD_Get_Virt_State"
 02h	"VMCPD_Set_Virt_State"
 ...
 08h	...last service for Windows95 SP1
SeeAlso: #0683,#0684,#1968

(Table 0684)
Values for EBIOS (VxD ID 0012h) service number:
 00h	get version
 01h	get unused memory
SeeAlso: #3350,#0685

(Table 0685)
Values for VNETBIOS (VxD ID 0014h) service number:
 00h	get version
 01h	register
 02h	submit
 03h	enum
 04h	deregister
 05h	register2
 06h	map
 07h	enum2
SeeAlso: #0684,#0686

(Table 0686)
Values for DOSMGR (VxD ID 0015h) service number:
 00h	get version
 01h	set exec VM data
 02h	coyp VM drive state
 03h	execute VM
 04h	get InDOS pointer
 05h	add device
 06h	remove device
 07h	instance device
 08h	get DOS critical status
 09h	enable InDOS polling
 0Ah	backfill allowed
 0Bh	"LocalGlobalReg"
 0Ch	"Init_UMB_Area"
 0Dh	"Begin_V86_App"
 0Eh	"End_V86_App"
 0Fh	"Alloc_Local_Sys_VM_Mem"
 10h	???
 11h	???
 12h	...last service for Windows95 SP1
SeeAlso: #0685,#1971 at INT 2F/AX=1684h/BX=0015h

(Table 0687)
Values for SHELL (VxD ID 0017h) service number:
 00h	get version
 01h	resolve contention
 02h	event
 03h	SYSMODAL message
 04h	message
 05h	get VM information
 06h	"_SHELL_PostMessage"
 07h	"_SHELL_WinExec"
 08h	"_SHELL_CallDll"
 09h	"SHELL_OpenClipboard"
 0Ah	"SHELL_SetClipboardData"
 0Bh	"SHELL_GetClipboardData"
 0Ch	"SHELL_CloseClipboard"
 0Dh	"_SHELL_Install_Taskman_Hooks"
 0Eh	"SHELL_Hook_Properties"
 0Fh	"SHELL_Unhook_Properties"
 10h	"SHELL_OEMKeyScan"
 11h	"SHELL_Update_User_Activity"
 ...
 1Bh	...last service for Windows95 SP1
SeeAlso: #0686,#0688,#1972 at INT 2F/AX=1684h/BX=0017h

(Table 0688)
Values for VMPoll (VxD ID 0018h) service number:
 00h	get version
 01h	enable/disable
 02h	reset detection
 03h	check idle
SeeAlso: #0675,#1972 at INT 2F/AX=1684h/BX=0017h

(Table 0689)
Values for DOSNET (VxD ID 001Ah) service number:
 00h	get version
 01h	send FILESYSCHANGE
 02h	do PSP adjust
SeeAlso: #0688,#3351

(Table 3351)
Values for LoadHi (VxD ID 001Ch) service number:
 00h	get version
	Return:	CF clear
		EAX = version (AH = major, AL = minor)
		ESI -> ASCIZ signature "LoadHi"
SeeAlso: #0689,#0690

(Table 0690)
Values for Int13 (VxD ID 0020h) service number:
 00h	get version
 01h	device registered
 02h	translate VM interrupt
 03h	hooking BIOS interrupt
 04h	unhooking BIOS interrupt
SeeAlso: #3351,#0691

(Table 0691)
Values for PAGEFILE (VxD ID 0021h) service number:
 00h	get version
 01h	init file
 02h	clean up
 03h	grow file
 04h	read or write
 05h	cancel
 06h	test I/O valid
 07h	"Get_Size_Info"
 08h	"Set_Async_Manager"
 09h	"Call_Async_Manager"
SeeAlso: #0690,#1976 at INT 2F/AX=1684h/BX=0021h

(Table 3505)
Values for VPOWERD (VxD ID 0026h) service number:
 00h	get version
	Return:	CF clear
		EAX = version (AH = major, AL = minor)
 01h	get APM BIOS version
	Return: CF clear
		EAX = APM BIOS version
 02h	get current power management level
	Return: CF clear
		EAX = power management level
 03h	enable/disable power management (see INT 15/AX=5308h)
	Return: EAX = error code (see #3506) or 00000000h if successful
 04h	set power state (see INT 15/AX=5307h)
	???
	Return: EAX = error code (see #3506) or 00000000h if successful
 05h	set system power status
	Return: EAX = error code (see #3506) or 00000000h if successful
 06h	restore APM power-on defaults (see INT 15/AX=5309h)
	Return: EAX = error code (see #3506) or 00000000h if successful
 07h	get power status (see INT 15/AX=530Ah)
	Return: ???
 08h	get APM 1.1 power state (see INT 15/AX=530Ch)
	Return: ???
 09h	invoke OEM APM function
	??? -> bufer containing parameters for INT 15/AX=5380h
	Return: EAX = error code (see #3506) or 00000000h if successful
		buffer updated if successful
 0Ah	register power handler
	???
	Return: EAX = error code (see #3506) or 00000000h if successful
 0Bh	deregister power handler
	???
	Return: EAX = error code (see #3506) or 00000000h if successful
 0Ch	Win32 get system power status
 0Dh	Win32 set system power status
SeeAlso: #0691,#3352,INT 2F/AX=1684h/BX=0026h

(Table 3352)
Values for VXDLDR (VxD ID 0027h) service number:
 00h	"VXDLDR_Get_Version"
 01h	"VXDLDR_LoadDevice"
 02h	"VXDLDR_UnloadDevice"
 03h	"VXDLDR_DevInitSucceeded"
 04h	"VXDLDR_DevInitFailed"
 05h	"VXDLDR_GetDeviceList"
 06h	"VXDLDR_UnloadMe"
 07h	"PELDR_LoadModule"
 08h	"PELDR_GetModuleHandle"
 09h	"PELDR_GetModuleUsage"
 0Ah	"PELDR_GetEntryPoint"
 0Bh	"PELDR_GetProcAddress"
 0Ch	"PELDR_AddExportTable"
 0Dh	"PELDR_RemoveExportTable"
 0Eh	"PELDR_FreeModule"
 ...
 11h	...last service for Windows95 SP1
SeeAlso: #0691,#3353

(Table 3353)
Values for NDIS (VxD ID 0028h) service number:
 00h	"NdisGetVersion"
 01h	"NdisAllocateSpinLock"
 02h	"NdisFreeSpinLock"
 03h	"NdisAcquireSpinLock"
 04h	"NdisReleaseSpinLock"
 05h	"NdisOpenConfiguration"
 06h	"NdisReadConfiguration"
 07h	"NdisCloseConfiguration"
 08h	"NdisReadEisaSlotInformation"
 09h	"NdisReadMcaPosInformation"
 0Ah	"NdisAllocateMemory"
 0Bh	"NdisFreeMemory"
 0Ch	"NdisSetTimer"
 0Dh	"NdisCancelTimer"
 0Eh	"NdisStallExecution"
 0Fh	"NdisInitializeInterrupt"
 10h	"NdisRemoveInterrupt"
 11h	"NdisSynchronizeWithInterrupt"
 12h	"NdisOpenFile"
 13h	"NdisMapFile"
 14h	"NdisUnmapFile"
 15h	"NdisCloseFile"
 16h	"NdisAllocatePacketPool"
 17h	"NdisFreePacketPool"
 18h	"NdisAllocatePacket"
 19h	"NdisReinitializePacket"
 1Ah	"NdisFreePacket"
 1Bh	"NdisQueryPacket"
 1Ch	"NdisAllocateBufferPool"
 1Dh	"NdisFreeBufferPool"
 1Eh	"NdisAllocateBuffer"
 1Fh	"NdisCopyBuffer"
 20h	"NdisFreeBuffer"
 21h	"NdisQueryBuffer"
 22h	"NdisGetBufferPhysicalAddress"
 23h	"NdisChainBufferAtFront"
 24h	"NdisChainBufferAtBack"
 25h	"NdisUnchainBufferAtFront"
 26h	"NdisUnchainBufferAtBack"
 27h	"NdisGetNextBuffer"
 28h	"NdisCopyFromPacketToPacket"
 29h	"NdisRegisterProtocol"
 2Ah	"NdisDeregisterProtocol"
 2Bh	"NdisOpenAdapter"
 2Ch	"NdisCloseAdapter"
 2Dh	"NdisSend"
 2Eh	"NdisTransferData"
 2Fh	"NdisReset"
 30h	"NdisRequest"
 31h	"NdisInitializeWrapper"
 32h	"NdisTerminateWrapper"
 33h	"NdisRegisterMac"
 34h	"NdisDeregisterMac"
 35h	"NdisRegisterAdapter"
 36h	"NdisDeregisterAdapter"
 37h	"NdisCompleteOpenAdapter"
 38h	"NdisCompleteCloseAdapter"
 39h	"NdisCompleteSend"
 3Ah	"NdisCompleteTransferData"
 3Bh	"NdisCompleteReset"
 3Ch	"NdisCompleteRequest"
 3Dh	"NdisIndicateReceive"
 3Eh	"NdisIndicateReceiveComplete"
 3Fh	"NdisIndicateStatus"
 40h	"NdisIndicateStatusComplete"
 41h	"NdisCompleteQueryStatistics"
 42h	"NdisEqualString"
 43h	"NdisNetAddressStringToBinary"
 44h	"NdisReadNetworkAddress"
 45h	"NdisWriteErrorLogEntry"
 46h	"C_MapPhysToLinear"
 47h	"C_HeapFree"
 48h	"NdisAllocateSharedMemory"
 49h	"NdisFreeSharedMemory"
 ...
 5Fh	...last service for Windows95 SP1
SeeAlso: #3352,#3354

(Table 3354)
Values for VWIN32 (VxD ID 002Ah) service number:
 00h	"VWin32_Get_Version"
 01h	"VWin32_Wake_For_Event"
 02h	"_VWIN32_QueueUserApc"
 03h	"_VWIN32_Get_Thread_Context"
 04h	"_VWIN32_Set_Thread_Context"
 05h	"_VWIN32_CopyMem"
 06h	"_VWIN32_BlockForTermination"
 ...
 1Ch	...last service for Windows95 SP1
SeeAlso: #3353,#3355

(Table 3355)
Values for VCOMM (VxD ID 002Bh) service number:
 00h	"VCOMM_Get_Version"
 01h	"_VCOMM_Register_Port_Driver"
 02h	"_VCOMM_Acquire_Port"
 03h	"_VCOMM_Release_Port"
 04h	"_VCOMM_OpenComm"
 05h	"_VCOMM_SetCommState"
 06h	"_VCOMM_GetCommState"
 07h	"_VCOMM_SetupComm"
 08h	"_VCOMM_TransmitCommChar"
 09h	"_VCOMM_CloseComm"
 0Ah	"_VCOMM_GetCommQueueStatus"
 0Bh	"_VCOMM_ClearCommError"
 0Ch	"_VCOMM_GetModemStatus"
 0Dh	"_VCOMM_GetCommProperties"
 0Eh	"_VCOMM_EscapeCommFunction"
 0Fh	"_VCOMM_PurgeComm"
 10h	"_VCOMM_SetCommEventMask"
 11h	"_VCOMM_GetCommEventMask"
 12h	"_VCOMM_WriteComm"
 13h	"_VCOMM_ReadComm"
 14h	"_VCOMM_EnableCommNotification"
 15h	"_VCOMM_GetLastError"
 16h	"_VCOMM_Steal_Port"
 17h	"_VCOMM_SetReadCallBack"
 18h	"_VCOMM_SetWriteCallBack"
 19h	"_VCOMM_GetSetCommTimeouts"
 1Ah	"_VCOMM_SetWriteRequest"
 1Bh	"_VCOMM_SetReadRequest"
 1Ch	"_VCOMM_Dequeue_Request"
 ...
 22h	...last service for Windows95 SP1
SeeAlso: #3354,#3356

(Table 3356)
Values for SPOOLER (VxD ID 002Ch) service number:
 00h	???
 10h	...last service for Windows95 SP1
SeeAlso: #3355,#3389

(Table 3389)
Values for VSERVER (VxD ID 0032h) service number:
 00h	get VSERVER version
	Return: CF clear
		EAX = version (AH = major, AL = minor)
		EBX = ??? (00000000h)
 01h	allocate ???
	AX = ???
	ESI = ???
	Return: CF clear if successful
		CF set on error (table full)
 02h	NOP???
	Return: EBX = 00000000h
 03h	???
	Return: ZF clear
SeeAlso: #3356,#3357,INT 2F/AX=1684h/BX=0032h

(Table 3357)
Values for CONFIGMG (VxD ID 0033h) service number:
 00h	???
 5Ah	...last service for Windows95 SP1
Note:	the VxD services appear to be identical to the PM/V86 APIs on
	  INT 2F/AX=1684h
SeeAlso: #3389,#3358,INT 2F/AX=1684h/BX=0033h

(Table 3461)
Values for DWCFGMG.SYS (VxD ID 0034h) service number:
 00h	"CM_GetVersion" get supported DDI version
	Return: EAX = 00000000h if not installed
		else
		    AH = major version number
		    AL = minor version number
		    EBX = number of devices controlled by DWCFGMG.SYS
 01h	"CM_GetConfig" get device configuration
	EBX = device index
	EDI -> buffer for configuration information (see #1980)
	Return: EAX = status (0000h successful, 0001h index out of range)
 02h	"CM_LockConfig" lock device configuration
	EDI -> configuration information (see #1980)
	Return: EAX = status
		    0000h successful
		    0001h resource conflict
		    0002h invalid request
 03h	"CM_UnlockConfig" unlock device configuration
	EDI -> configuration information (see #1980)
	Return: EAX = status (0000h successful, 0001h invalid request)
 04h	"CME_QueryResources"
 05h	"CME_AllocResources"
 06h	"CME_DeallocResources"
SeeAlso: INT 2F/AX=1684h/BX=0034h

(Table 3358)
Values for VFBACKUP (VxD ID 0036h) service number:
 00h	get version
	Return: CF clear
		EAX = version (AH = major, AL = minor)
 05h	...last service for Windows95 SP1
SeeAlso: #3357,#3509

(Table 3509)
Values for ENABLE (VxD ID 0037h) service number:
 00h	get version
	Return: CF clear
		EAX = version (AH = major, AL = minor)
 01h	??? (performs VMMCall 1800Eh, then falls through to service 04h)
	Return: EAX = system time???
 02h	get current ???
	Return: EAX = ???
 03h	??? (schedules a global event via VMMCall 1800Eh)
	Return: ???
 04h	get system time??? (performs VMMCall 100CFh)
	Return: EAX = system time???
 05h	call ??? priority event
	Return: nothing
 06h	set ??? / get ???
	EDI -> buffer containing data to copy into VxD and space for results
	Return: EDI buffer updated
 07h	???
	EBX = ??? flags (bits 2,15,17,18 checked)
	EDI -> ???
	???
	Return: ???
 08h	??? (schedules a global event via VMMCall 1800Eh)
	Return: ???
 09h	get ??? data
	EDI -> buffer for data (see #3510)
	Return:	EDI buffer updated if large enough
SeeAlso: #3358,#3359,#3508 at INT 2F/AX=1684h/BX=0037h

Format of ENABLE.VXD ??? data:
Offset	Size	Description	(Table 3510)
 00h	DWORD	(ret) length of data, including this word
		(call) length of buffer
 04h	DWORD	-> 24-byte (or larger) buffer
 08h	DWORD	-> 20-byte buffer
 0Ch	DWORD	-> 260-byte buffer
 10h	DWORD	-> 260-byte buffer
SeeAlso: #3509

(Table 3359)
Values for VCOND (VxD ID 0038h) service number:
 00h	get VCOND version
	Return: CF clear
		EAX = version (AH = major, AL = minor)
 01h	???
SeeAlso: #3511,#3509,#3360

(Table 3511)
Values for Windows95 VCOND (Vxd ID 0038h) Win32 service number:
 00h	get VCOND version
	Return: EAX = version (AH = major, AL = minor)
 ...
 34h	...last Win32 service for Windows95 SP1
SeeAlso: #3359

(Table 3360)
Values for BIOS (VxD ID 003Dh) service number:
 00h	get version???
 01h	???
 02h	???
 03h	???
SeeAlso: #3359,#3390

(Table 3390)
Values for WSOCK (VxD ID 003Eh) service number:
 00h	get WSOCK version
	Return: CF clear
		AH = major version
		AL = minor version
		EAX high word = 0000h
 01h	???
	EAX = ??? or 00000000h
	Return: CF clear if successful
		    EAX = 00000000h
		CF set on error
		    EAX = ???
 02h	???
	EAX = ??? or 00000000h
	Return: ???
 03h	???
 04h	...last service for Windows95 SP1
SeeAlso: #3360,#3361

(Table 3361)
Values for IFSMGR (VxD ID 0040h) service number:
 00h	get version
 01h	"RegisterMount"
 02h	"RegisterNet"
 03h	"RegisterMailSlot"
 04h	"Attach"
 05h	"Detach"
 06h	"Get_NetTime"
 07h	"Get_DOSTime"
 08h	"SetupConnection"
 09h	"DerefConnection"
 0Ah	"ServerDOSCall"
 0Bh	"CompleteAsync"
 0Ch	"RegisterHeap"
 0Dh	"GetHeap"
 0Eh	"RetHeap"
 0Fh	"CheckHeap"
 10h	"CheckHeapItem"
 11h	"FillHeapSpare"
 12h	"Block"
 13h	"Wakeup"
 14h	"Yield"
 15h	"SchedEvent"
 16h	"QueueEvent"
 17h	"KillEvent"
 18h	"FreeIOReg"
 19h	"MakeMailSlot"
 1Ah	"DeleteMailSlot"
 1Bh	"WriteMailSlot"
 1Ch	"PopUp"
 1Dh	"printf"
 1Eh	"AssertFailed"
 1Fh	"LogEntry"
 20h	"DebugMenu"
 21h	"DebugVars"
 22h	"GetDebugString"
 23h	"GetDebugHexNum"
 24h	"NetFunction"
 25h	"DoDelAllUses"
 26h	"SetErrString"
 27h	"GetErrString"
 28h	"SetReqHook"
 29h	"SetPathHook"
 2Ah	"UseAdd"
 2Bh	"UseDel"
 2Ch	"InitUseAdd"
 2Dh	"ChangeDir"
 2Eh	"DelAllUses"
 2Fh	"CDROM_Attach"
 30h	"CDROM_Detach"
 31h	"Win32DupHandle"
 32h	"Ring0_FileIO"
 33h	"Toggle_Extended_File_Handle"
 34h	"IFSMgr_GetDrive_Info"
 35h	"IFSMgr_Ring0GetDriveInfo"
 36h	"IFSMgr_BlockNoEvents"
 37h	"IFSMgr_NetToDosTime"
 38h	"IFSMgr_DosToNetTime"
 39h	"IFSMgr_DosToWin32Time"
 3Ah	"IFSMgr_Win32ToDosTime"
 3Bh	"IFSMgr_NetToWin32Time"
 3Ch	"IFSMgr_Win32ToNetTime"
 3Dh	"IFSMgr_MetaMatch"
 3Eh	"IFSMgr_TransMatch"
 3Fh	"IFSMgr_CallProvider"
 40h	"UniToBCS"
 41h	"UniToBCSPath"
 42h	"BCSToUni"
 43h	"UniToUpper"
 44h	"UniCharToOEM"
 45h	"CreateBasis"
 46h	"MatchBasisName"
 47h	"AppendBasisTail"
 48h	"FcbToShort"
 49h	"ShortToFcb"
 4Ah	"IFSMgr_ParsePath"
 4Bh	"Query_PhysLock"
 4Ch	"_VolFlush"
 4Dh	"NotifyVolumeArrival"
 4Eh	"NotifyVolumeRemoval"
 4Fh	"QueryVolumeRemoval"
 50h	"IFSMgr_FSDUnmountCFSD"
 51h	"IFSMgr_GetConversionTablePtrs"
 52h	"IFSMgr_CheckAccessConflict"
 53h	"IFSMgr_LockFile"
 54h	"IFSMgr_UnlockFile"
 55h	"IFSMgr_RemoveLocks"
 56h	"IFSMgr_CheckLocks"
 57h	"IFSMgr_CountLocks"
 58h	"IFSMgr_ReassignLockFileInst"
 59h	"IFSMgr_UnassignLockList"
 5Ah	"IFSMgr_MountChildVolume"
 5Bh	"IFSMgr_UnmountChildVolume"
 5Ch	"IFSMgr_SwapDrives"
 5Dh	"IFSMgr_FSDMapFHtoIOREQ"
 5Eh	"IFSMgr_FSDParsePath"
 5Fh	"IFSMgr_FSDAttachSFT"
 60h	"IFSMgr_GetTimeZoneBias"
 61h	"IFSMgr_PNPEvent"
 62h	"IFSMgr_RegisterCFSD"
 63h	"IFSMgr_Win32MapExtendedHandleToSFT"
 64h	"IFSMgr_DbgSetFileHandleLimit"
 65h	"IFSMgr_Win32MapSFTToExtendedHandle"
 66h	"IFSMgr_FSDGetCurrentDrive"
 ...
 74h	...last service for Windows95 SP1
SeeAlso: #3390,#3362

(Table 3362)
Values for VCDFSD (VxD ID 0041h) service number:
 00h	get VCDFSD version???
 01h	???
 02h	???
 03h	???
SeeAlso: #3361,#3363

(Table 3363)
Values for PERF (VxD ID 0048h) service number:
 00h	get version
	Return: CF clear
		EAX = version (AH = major, AL = minor)
 01h	start performance monitoring??? (creates/sets a registry key)
 02h	end performance monitoring??? (deletes registry key)
 03h	start performance monitoring??? (creates/sets a registry key)
 04h	end performance monitoring??? (deletes registry key)
SeeAlso: #3362,#3364

(Table 3364)
Values for VFLATD (VxD ID 011Fh) service number:
 00h	get VFLATD version???
 01h	???
SeeAlso: #3363,#3365

(Table 3365)
Values for vjoyd (VxD ID 0449h) service number:
 00h	get vjoyd version???
 01h	???
SeeAlso: #3364,#3366

(Table 3366)
Values for mmdevldr (VxD ID 044Ah) service number:
 00h	get mmdevldr version???
 01h	???
 02h	???
 03h	???
 04h	???
 05h	???
SeeAlso: #3365,#3367

(Table 3367)
Values for VNetSup (VxD ID 0480h) service number:
 00h	get VNetSup version???
 01h	???
 02h	???
 03h	???
 04h	???
 05h	???
 06h	???
SeeAlso: #3366,#3368

(Table 3368)
Values for VREDIR (VxD ID 0481h) service number:
 00h	???
 10h	...last service for Windows95 SP1
SeeAlso: #3367,#3369

(Table 3369)
Values for VSHARE (VxD ID 0483h) service number:
 00h	get VSHARE version???
SeeAlso: #3368,#3370

(Table 3370)
Values for NWLINK (VxD ID 0487h) service number:
 00h	???
 06h	...last service for Windows95 SP1
SeeAlso: #3369,#3371,#1968

(Table 3371)
Values for VTDI (VxD ID 0488h) service number:
 00h	???
 0Dh	...last service for Windows95 SP1
SeeAlso: #3370,#3372

(Table 3372)
Values for VIP (VxD ID 0489h) service number:
 00h	???
 08h	...last service for Windows95 SP1
SeeAlso: #3371,#3373

(Table 3373)
Values for MSTCP (VxD ID 048Ah) service number:
 00h	get MSTCP version???
SeeAlso: #3372,#3374

(Table 3374)
Values for VCACHE (VxD ID 048Bh) service number:
 00h	"VCACHE_Get_Version"
 01h	"VCACHE_Register"
 02h	"VCACHE_GetSize"
 03h	"VCACHE_CheckAvail"
 04h	"VCACHE_FindBlock"
 05h	"VCACHE_FreeBlock"
 06h	"VCACHE_MakeMRU"
 07h	"VCACHE_Hold"
 08h	"VCACHE_Unhold"
 09h	"VCACHE_Enum"
 0Ah	"VCACHE_TestHandle"
 0Bh	"VCACHE_VerifySums"
 0Ch	"VCACHE_RecalcSums"
 0Dh	"VCACHE_TestHold"
 0Eh	"VCACHE_GetStats"
 ...
 18h	...last service for Windows95 SP1
SeeAlso: #3373,#3375

(Table 3375)
Values for NWREDIR (VxD ID 048Eh) service number:
 00h	get NWREDIR version???
 01h	???
SeeAlso: #3374,#3383

(Table 3383)
Values for FILESEC (VxD ID 0491h) service number:
 00h	???
 10h	...last service for Windows95 SP1
SeeAlso: #3375,#3387

(Table 3387)
Values for NWSERVER (VxD ID 0492h) service number:
 00h	get NWSERVER version???
 01h	???
 02h	???
 03h	???
SeeAlso: #3383,#3385

(Table 3385)
Values for MSSP/NWSP (VxD ID 0493h) service number:
 00h	???
 06h	...last service for Windows95 SP1
SeeAlso: #3387,#3376

(Table 3376)
Values for NSCL (VxD ID 0494h)	service number:
 00h	get NSCL version???
 01h	???
 02h	???
SeeAlso: #3385,#3503

(Table 3503)
Values for AFVXD (VxD ID 0495h) service number:
 00h	get version
	Return: CF clear
		AX = version (AH = high, AL = low)
 01h	???
	EAX -> ???
	EBX -> ???
	ECX = ???
	Return:	???
 02h	???
	EAX -> ???
	Return: ???
SeeAlso: #3376,#3386

(Table 3386)
Values for NDIS2SUP (VxD ID 0496h) service number:
 00h	get NDIS2SUP version???
 01h	???
SeeAlso: #3503,#3388

(Table 3388)
Values for Splitter (VxD ID 0498h) service number:
 00h	get Splitter version
	Return:	CF clear
		EAX = version (00000001h)
 01h	???
 02h	???
 03h	hook/unhook VMM "hook device service" service
	EAX = request (0 = unhook, nonzero = hook)
	Return: if EAX nonzero on entry, Splitter's service 04h replaces VMM
		  service 0090h; otherwise, default handler is restored
 04h	Splitter "hook device service" handler
SeeAlso: #3386,#3377

(Table 3377)
Values for PPPMAC (VxD ID 0499h) service number:
 00h	???
 09h	...last service for Windows95 SP1
SeeAlso: #3388,#3378,#1968

(Table 3378)
Values for VDHCP (VxD ID 049Ah) service number:
 00h	get VDHCP version???
 01h	???
 02h	???
 03h	???
SeeAlso: #3377,#3379

(Table 3379)
Values for VNBT (VxD ID 049Bh) service number:
 00h	get VNBT version???
SeeAlso: #3378,#3384

(Table 3384)
Values for LOGGER (VxD ID 049Dh) service number:
 00h	get LOGGER version???
 01h	???
 02h	???
 03h	???
 04h	???
SeeAlso: #3379,#3380

(Table 3380)
Values for VStlthD (VxD ID 3098h) service number:
 00h	get version
	Return:	CF clear
		EAX = version (AH = major, AL = BCD minor)
 01h	???
 02h	get current ???
	Return: CF clear
		EDX = current value of ???
 03h	???
SeeAlso: #3384,#3391

(Table 3391)
Values for WSVV (VxD ID 30F6h) service number:
 00h	get WSVV version???
SeeAlso: #3380,#3381

(Table 3381)
Values for ASPIENUM (VxD ID 33FCh) service number:
 00h	get ASPIENUM version???
 01h	???
 02h	???
 03h	???
SeeAlso: #3391,#3382

(Table 3382)
Values for DSOUND (VxD ID 357Eh) service number:
 00h	get DSOUND version???
 01h	???
 02h	???
SeeAlso: #3381,#1968
--------G-21---------------------------------
INT 21 - COMTROL HOSTESS i/ISA DEBUGGER - GET SEGMENT FOR CONTROL PROGRAM USE
	???
Return: AX = first segment available for control program use
SeeAlso: INT 20"COMTROL",INT 22"COMTROL"
--------D-2100-------------------------------
INT 21 - DOS 1+ - TERMINATE PROGRAM
	AH = 00h
	CS = PSP segment
Notes:	Microsoft recommends using INT 21/AH=4Ch for DOS 2+
	this function sets the program's return code (ERRORLEVEL) to 00h
	execution continues at the address stored in INT 22 after DOS performs
	  whatever cleanup it needs to do (restoring the INT 22,INT 23,INT 24
	  vectors from the PSP assumed to be located at offset 0000h in the
	  segment indicated by the stack copy of CS, etc.)
	if the PSP is its own parent, the process's memory is not freed; if
	  INT 22 additionally points into the terminating program, the
	  process is effectively NOT terminated
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=26h,AH=31h,AH=4Ch,INT 20,INT 22
--------D-2101-------------------------------
INT 21 - DOS 1+ - READ CHARACTER FROM STANDARD INPUT, WITH ECHO
	AH = 01h
Return: AL = character read
Notes:	^C/^Break are checked, and INT 23 executed if read
	^P toggles the DOS-internal echo-to-printer flag
	^Z is not interpreted, thus not causing an EOF if input is redirected
	character is echoed to standard output
	standard input is always the keyboard and standard output the screen
	  under DOS 1.x, but they may be redirected under DOS 2+
SeeAlso: AH=06h,AH=07h,AH=08h,AH=0Ah
--------v-21010F-----------------------------
INT 21 - VIRUS - "Susan" - INSTALLATION CHECK
	AX = 010Fh
Return: AX = 7553h ("Su") if resident
SeeAlso: INT 16/AH=DDh"VIRUS",INT 21/AX=0B56h
--------D-2102-------------------------------
INT 21 - DOS 1+ - WRITE CHARACTER TO STANDARD OUTPUT
	AH = 02h
	DL = character to write
Return: AL = last character output (despite the official docs which state
		nothing is returned) (at least DOS 2.1-5.0)
Notes:	^C/^Break are checked, and INT 23 executed if pressed
	standard output is always the screen under DOS 1.x, but may be
	  redirected under DOS 2+
	the last character output will be the character in DL unless DL=09h
	  on entry, in which case AL=20h as tabs are expanded to blanks
	if standard output is redirected to a file, no error checks (write-
	  protected, full media, etc.) are performed
SeeAlso: AH=06h,AH=09h
--------D-2103-------------------------------
INT 21 - DOS 1+ - READ CHARACTER FROM STDAUX
	AH = 03h
Return: AL = character read
Notes:	keyboard checked for ^C/^Break, and INT 23 executed if detected
	STDAUX is usually the first serial port
SeeAlso: AH=04h,INT 14/AH=02h,INT E0/CL=03h
--------D-2104-------------------------------
INT 21 - DOS 1+ - WRITE CHARACTER TO STDAUX
	AH = 04h
	DL = character to write
Notes:	keyboard checked for ^C/^Break, and INT 23 executed if detected
	STDAUX is usually the first serial port
	if STDAUX is busy, this function will wait until it becomes free
SeeAlso: AH=03h,INT 14/AH=01h,INT E0/CL=04h
--------D-2105-------------------------------
INT 21 - DOS 1+ - WRITE CHARACTER TO PRINTER
	AH = 05h
	DL = character to print
Notes:	keyboard checked for ^C/^Break, and INT 23 executed if detected
	STDPRN is usually the first parallel port, but may be redirected under
	  DOS 2+
	if the printer is busy, this function will wait
SeeAlso: INT 17/AH=00h
--------D-2106-------------------------------
INT 21 - DOS 1+ - DIRECT CONSOLE OUTPUT
	AH = 06h
	DL = character (except FFh)
Return: AL = character output (despite official docs which state nothing is
		returned) (at least DOS 2.1-5.0)
Notes:	does not check ^C/^Break
	writes to standard output, which is always the screen under DOS 1.x,
	  but may be redirected under DOS 2+
SeeAlso: AH=02h,AH=09h
--------D-2106--DLFF-------------------------
INT 21 - DOS 1+ - DIRECT CONSOLE INPUT
	AH = 06h
	DL = FFh
Return: ZF set if no character available
	    AL = 00h
	ZF clear if character available
	    AL = character read
Notes:	^C/^Break are NOT checked
	if the returned character is 00h, the user pressed a key with an
	  extended keycode, which will be returned by the next call of this
	  function
	this function reads from standard input, which is always the keyboard
	  under DOS 1.x, but may be redirected under DOS 2+
	although the return of AL=00h when no characters are available is not
	  documented, some programs rely on this behavior
SeeAlso: AH=0Bh
--------D-2107-------------------------------
INT 21 - DOS 1+ - DIRECT CHARACTER INPUT, WITHOUT ECHO
	AH = 07h
Return: AL = character read from standard input
Notes:	does not check ^C/^Break
	standard input is always the keyboard under DOS 1.x, but may be
	  redirected under DOS 2+
	if the interim console flag is set (see AX=6301h), partially-formed
	  double-byte characters may be returned
SeeAlso: AH=01h,AH=06h,AH=08h,AH=0Ah
--------D-2108-------------------------------
INT 21 - DOS 1+ - CHARACTER INPUT WITHOUT ECHO
	AH = 08h
Return: AL = character read from standard input
Notes:	^C/^Break are checked, and INT 23 executed if detected
	standard input is always the keyboard under DOS 1.x, but may be
	  redirected under DOS 2+
	if the interim console flag is set (see AX=6301h), partially-formed
	  double-byte characters may be returned
SeeAlso: AH=01h,AH=06h,AH=07h,AH=0Ah,AH=64h"DOS 3.2+"
--------D-2109-------------------------------
INT 21 - DOS 1+ - WRITE STRING TO STANDARD OUTPUT
	AH = 09h
	DS:DX -> '$'-terminated string
Return: AL = 24h (the '$' terminating the string, despite official docs which
		state that nothing is returned) (at least DOS 2.1-5.0 and
		NWDOS)
Notes:	^C/^Break are checked, and INT 23 is called if either pressed
	standard output is always the screen under DOS 1.x, but may be
	  redirected under DOS 2+
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
SeeAlso: AH=02h,AH=06h"OUTPUT"
--------D-210A-------------------------------
INT 21 - DOS 1+ - BUFFERED INPUT
	AH = 0Ah
	DS:DX -> buffer (see #0692)
Return: buffer filled with user input
Notes:	^C/^Break are checked, and INT 23 is called if either detected
	reads from standard input, which may be redirected under DOS 2+
	if the maximum buffer size (see #0692) is set to 00h, this call returns
	  immediately without reading any input
SeeAlso: AH=0Ch,INT 2F/AX=4810h

Format of DOS input buffer:
Offset	Size	Description	(Table 0692)
 00h	BYTE	maximum characters buffer can hold
 01h	BYTE	(call) number of chars from last input which may be recalled
		(ret) number of characters actually read, excluding CR
 02h  N BYTEs	actual characters read, including the final carriage return
--------K-210A00-----------------------------
INT 21 - WCED v1.6+ - INSTALLATION CHECK
	AX = 0A00h
	DS:DX -> 6-byte buffer whose first two bytes must be 00h
Return: buffer offset 02h-05h filled with "Wced" if installed
Program: WCED is a free command-line editor and history utility by Stuart
	  Russell
SeeAlso: AH=FFh"CED"
--------D-210B-------------------------------
INT 21 - DOS 1+ - GET STDIN STATUS
	AH = 0Bh
Return: AL = status
	    00h if no character available
	    FFh if character is available
Notes:	^C/^Break are checked, and INT 23 is called if either pressed
	standard input is always the keyboard under DOS 1.x, but may be
	  redirected under DOS 2+
	if the interim console flag is set (see AX=6301h), this function
	  returns AL=FFh if a partially-formed double-byte character is
	  available
SeeAlso: AH=06h"INPUT",AX=4406h
--------v-210B56-----------------------------
INT 21 - VIRUS - "Perfume" - INSTALLATION CHECK
	AX = 0B56h
Return: AX = 4952h if resident
SeeAlso: AX=0D20h,INT 12/AX=4350h/BX=4920h,INT 13/AH=F2h,INT 21/AX=010Fh
--------D-210C-------------------------------
INT 21 - DOS 1+ - FLUSH BUFFER AND READ STANDARD INPUT
	AH = 0Ch
	AL = STDIN input function to execute after flushing buffer
	other registers as appropriate for the input function
Return: as appropriate for the specified input function
Note:	if AL is not one of 01h,06h,07h,08h, or 0Ah, the buffer is flushed but
	  no input is attempted
SeeAlso: AH=01h,AH=06h"INPUT",AH=07h,AH=08h,AH=0Ah
--------D-210D-------------------------------
INT 21 - DOS 1+ - DISK RESET
	AH = 0Dh
Return: (DOS 6 only) CF clear (earlier versions preserve CF)
Notes:	This function writes all modified disk buffers to disk, but does not
	  update the directory information (that is only done when files are
	  closed or a SYNC call is issued)
SeeAlso: AX=5D01h,INT 13/AH=00h,INT 2F/AX=1120h
--------v-210D20-----------------------------
INT 21 - VIRUS - "Crazy Imp" - INSTALLATION CHECK
	AX = 0D20h
Return: AX = 1971h if resident
SeeAlso: AX=0B56h,AX=1812h,AX=2C2Ch,AX=710Dh,AH=30h/DX=ABCDh
--------D-210E-------------------------------
INT 21 - DOS 1+ - SELECT DEFAULT DRIVE
	AH = 0Eh
	DL = new default drive (00h = A:, 01h = B:, etc)
Return: AL = number of potentially valid drive letters
Notes:	under Novell NetWare, the return value is always 32, the number of
	  drives that NetWare supports
	under DOS 3.0+, the return value is the greatest of 5, the value of
	  LASTDRIVE= in CONFIG.SYS, and the number of drives actually present
	on a DOS 1.x/2.x single-floppy system, AL returns 2 since the floppy
	  may be accessed as either A: or B:
	otherwise, the return value is the highest drive actually present
	DOS 1.x supports a maximum of 16 drives, 2.x a maximum of 63 drives,
	  and 3+ a maximum of 26 drives
	under Novell DOS 7, this function returns the correct LASTDRIVE value
	  even when the undocumented LASTDRIVE=27..32 directive was used in
	  CONFIG.SYS
SeeAlso: AH=19h,AH=3Bh,AH=DBh
--------v-210E--DLAD-------------------------
INT 21 U - Novell DOS 7 - SDRes v27.03 - INSTALLATION CHECK
	AH = 0Eh
	DL = ADh
Return: AL = BAh if installed
Program: SDRes is the resident portion of the Search&Destroy antiviral by
	  Fifth Generation Systems, as bundled with Novell DOS 7
Note:	SDRes will terminate programs which test for the presence of viruses
	  using interrupt-based installation calls, saying that the program
	  may be infected
SeeAlso: AH=0Eh/DL=AEh,AH=0Eh/DL=AFh,AH=4Ah/BX=00B6h,INT 13/AX=A759h
--------v-210E--DLAE-------------------------
INT 21 U - Novell DOS 7 - SDRes v27.03 - CLEAR ??? FLAG
	AH = 0Eh
	DL = AEh
SeeAlso: AH=0Eh/DL=ADh,AH=0Eh/DL=AFh,INT 13/AX=A759h
--------v-210E--DLAF-------------------------
INT 21 U - Novell DOS 7 - SDRes v27.03 - SET ??? FLAG
	AH = 0Eh
	DL = AFh
SeeAlso: AH=0Eh/DL=ADh,AH=0Eh/DL=AEh,INT 13/AX=A759h
--------D-210F-------------------------------
INT 21 - DOS 1+ - OPEN FILE USING FCB
	AH = 0Fh
	DS:DX -> unopened File Control Block (see #0693,#0694)
Return: AL = status
	    00h successful
	    FFh file not found or access denied
Notes:	(DOS 3.1+) file opened for read/write in compatibility mode
	an unopened FCB has the drive, filename, and extension fields filled
	  in and all other bytes cleared
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
	DR DOS checks password attached with AX=4303h
	(FAT32 drive) this function will only succeed for creating a volume
	  label; FAT32 does not support FCBs for file I/O
BUG:	APPEND for DOS 3.3+ corrupts DX if the file is not found
SeeAlso: AH=10h,AH=16h,AH=3Dh,AX=4303h

Format of File Control Block:
Offset	Size	Description	(Table 0693)
 00h	BYTE	drive number (0 = default, 1 = A, etc)
		FFh is not allowed (signals extended FCB, see #0694)
 01h  8 BYTEs	blank-padded file name
 09h  3 BYTEs	blank-padded file extension
 0Ch	WORD	current block number
 0Eh	WORD	logical record size
 10h	DWORD	file size
 14h	WORD	date of last write (see #1006 at AX=5700h)
 16h	WORD	time of last write (see #1005 at AX=5700h) (DOS 1.1+)
 18h  8 BYTEs	reserved (see #0695,#0696,#0697,#0698,#0699)
 20h	BYTE	record within current block
 21h	DWORD	random access record number (if record size is > 64 bytes, high
		  byte is omitted)
SeeAlso: #0694

Format of Extended File Control Block (XFCB):
Offset	Size	Description	(Table 0694)
 00h	BYTE	FFh signature for extended FCB
 01h  5 BYTEs	reserved
 06h	BYTE	file attribute if extended FCB
 07h 36 BYTEs	standard FCB (all offsets are shifted by seven bytes)
SeeAlso: #0653

Format of FCB reserved field for DOS 1.0:
Offset	Size	Description	(Table 0695)
 16h	WORD	location in directory (if high byte = FFh, low byte is device
		  ID)
 18h	WORD	number of first cluster in file
 1Ah	WORD	current absolute cluster number on disk
 1Ch	WORD	current relative cluster number within file
		(0 = first cluster of file, 1 = second cluster, etc.)
 1Eh	BYTE	dirty flag (00h = not dirty)
 1Fh	BYTE	unused

Format of FCB reserved field for DOS 1.10-1.25:
Offset	Size	Description	(Table 0696)
 18h	BYTE	bit 7: set if logical device
		bit 6: not dirty
		bits 5-0: disk number or logical device ID
 19h	WORD	starting cluster number on disk
 1Bh	WORD	current absolute cluster number on disk
 1Dh	WORD	current relative cluster number within file
 1Fh	BYTE	unused

Format of FCB reserved field for DOS 2.x:
Offset	Size	Description	(Table 0697)
 18h	BYTE	bit 7: set if logical device
		bit 6: set if open???
		bits 5-0: ???
 19h	WORD	starting cluster number on disk
 1Bh	WORD	???
 1Dh	BYTE	???
 1Eh	BYTE	???
 1Fh	BYTE	???

Format of FCB reserved field for DOS 3.x:
Offset	Size	Description	(Table 0698)
 18h	BYTE	number of system file table entry for file
 19h	BYTE	attributes
		bits 7,6: 00 = SHARE.EXE not loaded, disk file
			  01 = SHARE.EXE not loaded, character device
			  10 = SHARE.EXE loaded, remote file
			  11 = SHARE.EXE loaded, local file or device
		bits 5-0: low six bits of device attribute word
---SHARE.EXE loaded, local file---
 1Ah	WORD	starting cluster of file on disk
 1Ch	WORD	(DOS 3.x) offset within SHARE of sharing record
		  (see #0978 at AH=52h)
 1Eh	BYTE	file attribute
 1Fh	BYTE	???
---SHARE.EXE loaded, remote file---
 1Ah	WORD	number of sector containing directory entry (see #0700)
 1Ch	WORD	relative cluster within file of last cluster accessed
 1Eh	BYTE	absolute cluster number of last cluster accessed
 1Fh	BYTE	???
---SHARE.EXE not loaded---
 1Ah	BYTE	(low byte of device attribute word AND 0Ch) OR open mode
 1Bh	WORD	starting cluster of file
 1Dh	WORD	number of sector containing directory entry (see #0700)
 1Fh	BYTE	number of directory entry within sector
Note:	if FCB opened on character device, DWORD at 1Ah is set to the address
	  of the device driver header, then the BYTE at 1Ah is overwritten.
SeeAlso: #0987

Format of FCB reserved field for DOS 5.0:
Offset	Size	Description	(Table 0699)
 18h	BYTE	number of system file table entry for file
 19h	BYTE	attributes
		bits 7,6: 00 = SHARE.EXE not loaded, disk file
			  01 = SHARE.EXE not loaded, character device
			  10 = SHARE.EXE loaded, remote file
			  11 = SHARE.EXE loaded, local file or device
		bits 5-0: low six bits of device attribute word
---SHARE.EXE loaded, local file---
 1Ah	WORD	starting cluster of file on disk
 1Ch	WORD	unique sequence number of sharing record
 1Eh	BYTE	file attributes
 1Fh	BYTE	unused???
---SHARE.EXE loaded, remote file---
 1Ah	WORD	network handle
 1Ch	DWORD	network ID
---SHARE not loaded, local device---
 1Ah	DWORD	pointer to device driver header (see #0987)
 1Eh  2 BYTEs	unused???
---SHARE not loaded, local file---
 1Ah	BYTE	extra info
		bit 7: read-only attribute from SFT
		bit 6: archive attribute from SFT
		bits 5-0: high bits of sector number
 1Bh	WORD	starting cluster of file
 1Dh	WORD	low word of sector number containing directory entry
		(see #0700)
 1Fh	BYTE	number of directory entry within sector
--------!---Section--------------------------
