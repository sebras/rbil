---------------------------------------------
Interrupt List, part 4 of 7
This compilation is Copyright (c) 1989,1990,1991,1992 Ralf Brown
----------2180-------------------------------
INT 21 U - European MSDOS 4.0 - EXECUTE PROGRAM IN BACKGROUND
	AH = 80h
	DS:DX -> ASCIZ full program name
	ES:BX -> parameter block (as for AX=4B00h)
Return: CF clear if successful
	    AX = CSID
	CF set on error
	    AX = error code (see AH=59h)
Note:	this function is called by the DETACH command
SeeAlso: AX=8700h
----------218080-----------------------------
INT 21 - PCW Weather Card interface - UNINSTALL PCW.COM AND FREE MEMORY
	AX = 8080h
Return: ???
SeeAlso: AX=7070h/BX=7070h
----------2181-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 81h
	???
Return: ???
----------2182-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 82h
	???
Return: ???
----------2183-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 83h
	???
Return: ???
----------2183-------------------------------
INT 21 - VIRUS - "SVC" - INSTALLATION CHECK
	AH = 83h
Return: DX = 1990h if resident
SeeAlso: AH=76h,AH=84h"VIRUS"
----------2184-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 84h
	???
Return: ???
----------2184-------------------------------
INT 21 - VIRUS - "SVC 5.0" or "SVC 6.0" - INSTALLATION CHECK
	AH = 84h
Return: DX = 1990h if resident
	    BH = version number (major in high nybble, minor in low)
SeeAlso: AH=83h"VIRUS",AH=89h"VIRUS"
----------2185-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 85h
	???
Return: ???
----------2186-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 86h
	???
Return: ???
----------218700-----------------------------
INT 21 U - European DOS 4.0 - GET PID???
	AX = 8700h
Return: AX = PID if AL nonzero
	BX = ???
	CX = ???
Notes:	called by MS C v5.1 getpid() function
	this function apparently must return AX=0001h for INT 21/AH=80h to
	  succeed
SeeAlso: AH=62h,AH=80h
----------2188-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 88h
	???
Return: ???
----------2189-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 89h
	???
Return: ???
Note:	reportedly called by Microsoft C 4.0 startup code
----------2189-------------------------------
INT 21 - VIRUS - "Vriest" - INSTALLATION CHECK
	AH = 89h
Return: AX = 0123h if resident
SeeAlso: AH=84h"VIRUS",AH=90h"VIRUS"
----------218A-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 8Ah
	???
Return: ???
----------218B-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 8Bh
	???
Return: ???
----------218C-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 8Ch
	???
Return: ???
----------218D-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 8Dh
	???
Return: ???
----------218E-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 8Eh
	???
Return: ???
----------218F-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 8Fh
	???
Return: ???
----------2190-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 90h
	???
Return: ???
----------2190-------------------------------
INT 21 - VIRUS - "Carioca" - INSTALLATION CHECK
	AH = 90h
Return: AH = 01h if resident
SeeAlso: AH=89h"VIRUS",AX=9753h"VIRUS"
----------2191-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 91h
	???
Return: ???
----------2192-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 92h
	???
Return: ???
----------2193-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 93h
	???
Return: ???
----------2194-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 94h
	???
Return: ???
----------2195-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 95h
	???
Return: ???
----------2196-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 96h
	???
Return: ???
----------2197-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 97h
	???
Return: ???
----------219753-----------------------------
INT 21 - VIRUS - "Nina" - INSTALLATION CHECK
	AX = 9753h
Return: never (executes original program) if virus resident
SeeAlso: AH=90h"VIRUS",AX=A1D5h"VIRUS"
----------2198-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 98h
	???
Return: ???
----------2199-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 99h
	???
Return: ???
----------219A-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 9Ah
	???
Return: ???
----------21A0-------------------------------
INT 21 - Attachmate Extra - GET 3270 DISPLAY STATE
	AH = A0h
Return: AL = display status
	    bit	 7  : 0=windowed, 1=enlarged
	    bits 6-3: current screen profile number 0-9
	    bits 2-0: active window number
			0=PC, 1-4=host B-E, 5-6=notepad F-G
	BX = host window status
	    bit 15:  reserved
	    bit 14:  0=host E window installed, 1=not
	    bit 13:  0=host E terminal on, 1=off
	    bit 12:  0=host E window displayed, 1=not
	    bit 11:  reserved
	    bit 10:  0=host D window installed, 1=not
	    bit	 9:  0=host D terminal on, 1=off
	    bit	 8:  0=host D window displayed, 1=not
	    bit	 7:  reserved
	    bit	 6:  0=host C window installed, 1=not
	    bit	 5:  0=host C terminal on, 1=off
	    bit	 4:  0=host C window displayed, 1=not
	    bit	 3:  reserved
	    bit	 2:  0=host B window installed, 1=not
	    bit	 1:  0=host B terminal on, 1=off
	    bit	 0:  0=host B window displayed, 1=not
Note:	Attachmate Extra is a 3270 emulator by Attachmate Corporation
SeeAlso: AH=A1h
----------21A1-------------------------------
INT 21 - Attachmate Extra - SET 3270 DISPLAY STATE
	AH = A1h
	AL = set status byte
	    bit	 7  : 0=windowed, 1=enlarged
	    bits 6-3: current screen profile number 0-9
	    bits 2-0: active window number
			0=PC, 1-4=host B-E, 5-6=notepad F-G
SeeAlso: AH=A0h,AH=A2h
----------21A1D5-----------------------------
INT 21 - VIRUS - "789"/"Filehider" - INSTALLATION CHECK
	AX = A1D5h
Return: AX = 900Dh if resident
SeeAlso: AX=9753h,AX=A55Ah
----------21A2-------------------------------
INT 21 - Attachmate Extra - SET HOST WINDOW STATE
	AH = A2h
	AL = set status byte
	    bit	 7  : 0=power off, 1=power on
	    bit	 6  : 0=not installed, 1=installed
	    bits 5-3: reserved
	    bits 2-0: window number 1-4=host B-E
SeeAlso: AH=A1h
----------21A3-------------------------------
INT 21 - Attachmate Extra - SEND KEYSTROKES TO HOST WINDOW
	AH = A3h
	AL = window number (1-4=host B-E)
	CX = 0001h
	DS:BX -> keystroke buffer
	DL = zero if keystroke buffer contains host function code,
	     non-zero if keystroke buffer contains ASCII character
Return: CX = zero if character sent, non-zero if not
	BX incremented if CX=0

Values for host function code:
	00h=reserved	10h=PF16	20h=Clear	30h=SysRq
	01h=PF1		11h=PF17	21h=Print	31h=ErInp
	02h=PF2		12h=PF18	22h=Left	32h=ErEof
	03h=PF3		13h=PF19	23h=Right	33h=Ident
	04h=PF4		14h=PF20	24h=Up		34h=Test
	05h=PF5		15h=PF21	25h=Down	35h=Reset
	06h=PF6		16h=PF22	26h=Home	36h=DevCncl
	07h=PF7		17h=PF23	27h=Fast Left	37h=Dup
	08h=PF8		18h=PF24	28h=Fast Right	38h=FldMark
	09h=PF9		19h=Alt on	29h=Bksp	39h=Enter
	0Ah=PF10	1Ah=Alt off	2Ah=Insert	3Ah=CrSel
	0Bh=PF11	1Bh=Shift on	2Bh=Delete
	0Ch=PF12	1Ch=Shift off	2Ch=Backtab
	0Dh=PF13	1Dh=PA1		2Dh=Tab
	0Eh=PF14	1Eh=PA2		2Eh=Newline
	0Fh=PF15	1Fh=PA3		2Fh=Attn
----------21A4-------------------------------
INT 21 - Attachmate Extra - GET HOST WINDOW BUFFER ADDRESS
	AH = A4h
	AL = window number (1-4=host B-E)
Return: DS:BX -> 3270 display buffer
SeeAlso: AH=A5h,AH=B8h
----------21A5-------------------------------
INT 21 - Attachmate Extra - GET HOST WINDOW CURSOR POSITION
	AH = A5h
	AL = window number (1-4=host B-E)
Return: BX = cursor position (80 * row + column, where 0:0 is upper left)
Note:	if the host window is configured with the Extended Attribute (EAB)
	  feature, multiply the cursor position by 2 to obtain the byte offset
	  into the display buffer
SeeAlso: AH=A4h
----------21A55A-----------------------------
INT 21 - VIRUS - "Eddie-2" - INSTALLATION CHECK
	AX = A55Ah
Return: AX = 5AA5h if resident
SeeAlso: AX=A1D5h,AX=AA00h
----------21AA00-----------------------------
INT 21 - VIRUS - "Blinker" - INSTALLATION CHECK
	AX = AA00h
Return: AX = 00AAh if resident
SeeAlso: AX=A55Ah,AX=AA03h
----------21AA03-----------------------------
INT 21 - VIRUS - "Backtime" - INSTALLATION CHECK
	AX = AA03h
Return: AX = 03AAh if resident
SeeAlso: AX=AA00h,AH=ABh
----------21AB-------------------------------
INT 21 - VIRUS - "600" or "Voronezh"-family - INSTALLATION CHECK
	AH = ABh
Return: AX = 5555h if resident
SeeAlso: AX=AA03h,AX=BBBBh"VIRUS"
----------21AF-------------------------------
INT 21 - Attachmate Extra - GET TRANSLATE TABLE ADDRESS
	AH = AFh
Return: DS:BX -> translate tables (see below)

Format of translate tables:
Offset	Size	Description
 00h 256 BYTEs	ASCII to 3270 buffer code translate table
100h 256 BYTEs	3270 buffer code to ASCII translate table
200h 256 BYTEs	3270 buffer code to EBCDIC translate table
300h 256 BYTEs	EBCDIC to 3270 buffer code translate table
----------21B5-------------------------------
INT 21 - Novell NetWare shell 3.01 - TASK MODE CONTROL
	AH = B5h
	AL = subfunction
	    03h get task mode
		Return: AH = 00h
			AL = current task mode byte
	    04h get task mode pointer
		Return: ES:BX -> task mode byte
Notes:	the task mode byte specifies how task cleanup should be performed, but
	  is declared to be version-dependent
	allows a program to disable the automatic cleanup for programs managing
	  task swapping, etc.

Values for task mode byte in version 3.01:
 00h-03h reserved
 04h	 no task cleanup
----------21B6-------------------------------
INT 21 - Novell NetWare SFT Level II - EXTENDED FILE ATTRIBUTES
	AH = B6h
	AL = subfunction
	    00h get extended file attributes
	    01h set extended file attributes
	CL = attributes
	    bits 2-0: search mode (executables only)
			000 none (use shell's default search)
			001 search on all opens without path
			010 do not search
			011 search on read-only opens without path
			100 reserved
			101 search on all opens
			110 reserved
			111 search on all read-only opens
		3: reserved
		4: transaction tracking file
		5: indexing file
		6: read audit (to be implemented)
		7: write audit (to be implemented)
	DS:DX -> ASCIZ pathname
Return: CF set on error
	    AL = error code
		8Ch caller lacks privileges
		FFh file not found
	CL = current extended file attributes
SeeAlso: AX=4300h
----------21B8-------------------------------
INT 21 - Novell Advanced NetWare 2.0+ - PRINT JOBS
	AH = B8h
	AL = subfunction
	    00h get default print job flags
	    01h set default capture flags (see below)
	    02h get specific capture flags
	    03h set specific print job flags
	    04h get default local printer
	    05h set default local printer
	    06h set capture print queue
	    07h set capture print job
	    08h get banner user name
	    09h set banner user name
	CX = buffer size
	ES:BX -> buffer
Return: none

Format of capture flags table:
Offset	Size	Description
 00h	BYTE	status (used internally, should be set to 00h)
 01h	BYTE	print flags
		bit 2: print capture file if interrupted by loss of connection
		    3: no automatic form feed after print job
		    6: printing control sequences interpreted by print service
		    7: print banner page before capture file
 02h	BYTE	printer number on server
 03h	BYTE	number of copies to print
 04h	BYTE	form type required in printer (default 00h)
 05h 13 BYTEs	text to be placed on banner page
 12h	BYTE	reserved
 13h	BYTE	default local printer (00h = LPT1)
 14h	BYTE	flush capture file on LPT close if nonzero
 15h	WORD	timeout in clock ticks for flushing capture file on inactivity
		(high byte first)
		0000h = never timeout
 17h	WORD	maximum lines per page (high byte first)
 19h	WORD	maximum characters per line (high byte first)
 1Bh 13 BYTEs	name of form required in printer
 28h	BYTE	LPT capture flag
		00h inactive, FFh LPT device is being captured
 29h	BYTE	file capture flag
		00h if no file specified, FFh if capturing to file
 2Ah	BYTE	timing out (00h if no timeout in effect, FFh if timeout counter
		running)
 2Bh	WORD	offset of printer setup string (high byte first)
 2Dh	WORD	offset of printer reset string (high byte first)
 2Fh	BYTE	target connection ID
 30h	BYTE	capture in progress if FFh
 31h	BYTE	print job number assigned to capture if FFh
 32h	WORD	bindery object ID of print queue if previous byte FFh
 34h	WORD	print job number (high byte first)
----------21B8-------------------------------
INT 21 - Attachmate Extra - DISABLE HOST BUFFER UPDATES
	AH = B8h
	AL = window number (1-4=host B-E)
	DL = 01h
Notes:	only valid in CUT mode
	next AID keystroke (eg Enter) enables host buffer updates
SeeAlso: AH=A4h
----------21BB-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - SET END OF JOB STATUS
	AH = BBh
	AL = new EOJ flag
	    00h disable EOJs
	    otherwise enable EOJs
Return: AL = old EOJ flag
SeeAlso: AH=D6h
----------21BBBB-----------------------------
INT 21 - VIRUS - "Hey You" - INSTALLATION CHECK
	AX = BBBBh
Return: AX = 6969h
SeeAlso: AH=ABh"VIRUS",AH=BEh"VIRUS"
----------21BC-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - LOG/LOCK PHYSICAL RECORD
	AH = BCh
	AL = flags
	    bit 0: lock as well as log record
		1: non-exclusive lock
	BX = file handle
	CX:DX = offset
	BP = timeout in timer ticks (1/18 sec)
	SI:DI = length of region to lock
Return: AL = error code
	    00h successful
	    96h no dynamic memory for file
	    FEh timed out
	    FFh failed
SeeAlso: AH=BDh,AH=BFh
----------21BD-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - RELEASE PHYSICAL RECORD
	AH = BDh
	BX = file handle
	CX:DX = offset
Return: AL = error code (see AH=BCh)
Note:	unlocks record but does not remove it from log table
SeeAlso: AH=BCh,AH=BEh"Novell",AH=C0h
----------21BE-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - CLEAR PHYSICAL RECORD
	AH = BEh
	BX = file handle
	CX:DX = offset
Return: AL = error code (see AH=BCh)
Note:	unlocks record and removes it from log table
SeeAlso: AH=BCh,AH=BDh,AH=C1h
----------21BE-------------------------------
INT 21 - VIRUS - "Datalock" - INSTALLATION CHECK
	AH = BEh
Return: AX = 1234h if resident
SeeAlso: AX=BBBBh,AX=BE00h
----------21BE00-----------------------------
INT 21 - VIRUS - "USSR-1049" - INSTALLATION CHECK
	AX = BE00h
	CF set
Return: CF clear if resident
SeeAlso: AH=BEh"VIRUS",AH=C0h"VIRUS"
----------21BF-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - LOG/LOCK RECORD (FCB)
	AH = BFh
	AL = flags
	    bit 0: lock as well as log record
		1: non-exclusive lock
	DS:DX -> opened FCB (see AH=0Fh)
	BX:CX = offset
	BP = lock timeout in timer ticks (1/18 sec)
	SI:DI = length
Return: AL = error code (see AH=BCh)
SeeAlso: AH=BCh,AH=C0h"Novell",AH=C2h"Novell"
----------21C0-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - RELEASE RECORD (FCB)
	AH = C0h
	DS:DX -> FCB (see AH=0Fh)
	BX:CX = offset
Return: AL = error code (see AH=BCh)
Note:	unlocks record but does not remove it from log table
SeeAlso: AH=BDh,AH=BFh,AH=C1h"Novell",AH=C3h
----------21C0-------------------------------
INT 21 - VIRUS - "Slow"/"Zerotime", "Solano" - INSTALLATION CHECK
	AH = C0h
Return: AX = 0300h if "Slow"/"Zerotime" resident
	AX = 1234h if "Solano" resident
SeeAlso: AX=BE00h,AH=C1h"VIRUS",AX=C301h"VIRUS"
----------21C1-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - CLEAR RECORD (FCB)
	AH = C1h
	DS:DX -> opened FCB (see AH=0Fh)
	BX:CX = offset
Return: AL = error code (see AH=BCh)
Note:	unlocks record and removes it from log table
SeeAlso: AH=BEh,AH=C0h"Novell",AH=C4h
----------21C1-------------------------------
INT 21 - VIRUS - "Solano" - ???
	AH = C1h
	???
Return: ???
SeeAlso: AH=C0h"VIRUS"
----------21C2-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - LOCK PHYSICAL RECORD SET
	AH = C2h
	AL = flags
	    bit 1: non-exclusive lock
	BP = lock timeout in timer ticks (1/18 sec)
Return: AL = error code
	    00h successful
	    FEh timed out
	    FFh failed
SeeAlso: AH=BFh,AH=C3h
----------21C2-------------------------------
INT 21 - VIRUS - "Scott's Valley" - ???
	AH = C2h
	???
Return: ???
SeeAlso: AH=C0h"VIRUS"
----------21C3-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - RELEASE PHYSICAL RECORD SET
	AH = C3h
Return: AL = error code
Note:	unlocks but does not remove from log table
SeeAlso: AH=C0h,AH=C2h"Novell",AH=C4h
----------21C301DXF1F1-----------------------
INT 21 - VIRUS - "905"/"Backfont" - INSTALLATION CHECK
	AX = C301h
	DX = F1F1h
Return: DX = 0E0Eh if resident
SeeAlso: AH=C0h"VIRUS",AX=C500h"VIRUS"
----------21C4-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - CLEAR PHYSICAL RECORD SET
	AH = C4h
Return: AL = error code
Note:	unlocks and removes from log table
SeeAlso: AH=C1h
----------21C5-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - SEMAPHORES
	AH = C5h
	AL = subfunction
	    00h open semaphore
		DS:DX -> semaphore name (counted string)
		CL = initial value
		Return: CX:DX = semaphore handle
			BL = open count
	    01h examine semaphore
		Return: CX = semaphore value (sign extended)
			DL = open count
	    02h wait on semaphore
		BP = timeout in timer ticks (1/18 sec) (0000h = no wait)
	    03h signal semaphore
	    04h close semaphore
	CX:DX = semaphore handle (except function 00h)
Return: AL = error code
	    00h successful
	    01h semaphore value overflow
	    96h out of string space on server
	    FEh invalid string length (AL=00h) or timeout
	    FFh invalid initial value (AL=00h) or invalid handle
----------21C500-----------------------------
INT 21 - VIRUS - "Sverdlov" - INSTALLATION CHECK
	AX = C500h
Return: AX = 6731h if resident
SeeAlso: AX=C301h"VIRUS",AH=C6h"VIRUS"
----------21C6-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - GET OR SET LOCK MODE
	AH = C6h
	AL = subfunction
	    00h set old "compatibility" mode
	    01h set new extended locks mode 
	    02h get lock mode
Return: AL = current lock mode
----------21C6-------------------------------
INT 21 - VIRUS - "Socha" - INSTALLATION CHECK
	AH = C6h
Return: AL = 55h if resident
SeeAlso: AX=C500h"VIRUS",AX=C603h
----------21C603-----------------------------
INT 21 - VIRUS - "Yankee" or "MLTI" - INSTALLATION CHECK
	AX = C603h
	CF set
Return: CF clear if resident
SeeAlso: AX=C500h"VIRUS",AX=C700h"VIRUS"
----------21C7-------------------------------
INT 21 - Novell NetWare 4.0 - TRANSACTION TRACKING SYSTEM
	AH = C7h
	AL = subfunction
	    00h begin transaction (NetWare SFT level II)
		Return: AL = error code
	    01h end transaction (NetWare SFT level II)
		Return: AL = error code
			CX:DX = transaction reference number
	    02h TTS available (NetWare SFT level II)
		Return: AL = completion code
			    00h TTS not available
			    01h TTS available
			    FDh TTS available but disabled
	    03h abort transaction (NetWare SFT level II)
		Return: AL = error code
	    04h transaction status
	    05h get application thresholds
	    06h set application thresholds
	    07h get workstation thresholds
	    08h set workstation thresholds
Return: ???
----------21C700-----------------------------
INT 21 - VIRUS - "MH-757" - INSTALLATION CHECK
	AX = C700h
Return: AL = 07h if resident
SeeAlso: AX=C603h"VIRUS",AH=CBh"VIRUS"
----------21C8-------------------------------
INT 21 - Novell NetWare 4.0 - BEGIN LOGICAL FILE LOCKING
	AH = C8h
	if function C6h lock mode 00h:
	    DL = mode
		00h no wait
		01h wait
	if function C6h lock mode 01h:
	    BP = timeout in timer ticks (1/18 sec)
Return: AL = error code
SeeAlso: AH=C9h
----------21C9-------------------------------
INT 21 - Novell NetWare 4.0 - END LOGICAL FILE LOCKING
	AH = C9h
Return: AL = error code
SeeAlso: AH=C8h
----------21CA-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - LOG/LOCK PERSONAL FILE (FCB)
	AH = CAh
	DS:DX -> FCB (see AH=0Fh)
	if function C6h lock mode 01h:
	    AL = log and lock flag
		00h log file only
		01h lock as well as log file
	    BP = lock timeout in timer ticks (1/18 sec)
Return: AL = error code
	    00h successful
	    96h no dynamic memory for file
	    FEh timeout
	    FFh failed
SeeAlso: AH=CBh
----------21CA15-----------------------------
INT 21 - VIRUS - "Piter" - ???
	AX = CA15h
	???
Return: ???
SeeAlso: AH=CCh"VIRUS"
----------21CB-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - LOCK FILE SET
	AH = CBh
	if function C6h lock mode 00h:
	    DL = mode
		00h no wait
		01h wait
	if function C6h lock mode 01h:
	    BP = lock timeout in timer ticks (1/18 sec)
Return: AL = error code
	    00h successful
	    FEh timed out
	    FFh failed
Note:	attempts to lock all logged personal files
SeeAlso: AH=CAh
----------21CB-------------------------------
INT 21 - VIRUS - "Milous" - INSTALLATION CHECK
	AH = CBh
Return: AL = 07h if resident
SeeAlso: AX=C700h"VIRUS",AX=CB02h
----------21CB02-----------------------------
INT 21 - VIRUS - "Witcode" - INSTALLATION CHECK
	AX = CB02h
Return: AX = 02CBh if resident
SeeAlso: AX=CBh"VIRUS",AH=CCh"VIRUS"
----------21CC-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - RELEASE FILE (FCB)
	AH = CCh
	DS:DX -> FCB (see AH=0Fh)
Return: none
Note:	unlocks file, but does not remove it from the log table or close it
SeeAlso: AH=CAh,AH=CDh
----------21CC-------------------------------
INT 21 - VIRUS - "Westwood" - INSTALLATION CHECK
	AH = CCh
Return: AX = 0700h if resident
SeeAlso: AX=CB02h,AH=CDh"VIRUS",AX=D000h"VIRUS"
----------21CD-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - RELEASE FILE SET
	AH = CDh
Return: none
Note:	unlocks all personal files, but does not remove them from log table
SeeAlso: AH=CAh,AH=CCh
----------21CD-------------------------------
INT 21 - VIRUS - "Westwood" - ???
	AH = CDh
	???
Return: ???
SeeAlso: AH=CCh"VIRUS"
----------21CE-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - CLEAR FILE (FCB)
	AH = CEh
	DS:DX -> FCB (see AH=0Fh)
Return: AL = error code
Note:	unlocks file and removes it from log table, then closes all opened and
	  logged occurrences
SeeAlso: AH=CAh,AH=CFh,AH=EDh"Novell"
----------21CF-------------------------------
INT 21 - LANstep - ???
	AH = CFh
	???
Return: ???
Note:	LANstep is a redesign of the Waterloo Microsystems PORT network
----------21CF-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - CLEAR FILE SET
	AH = CFh
Return: AL = 00h
Note:	clears all entries in personal file log table
SeeAlso: AH=CAh,AH=CEh
----------21D0-------------------------------
INT 21 - Novell NetWare 4.6, Banyan VINES, Alloy NTNX - LOCK LOGICAL RECORD
	AH = D0h
	DS:DX -> record string (counted string, max 100 data bytes)
	if function C6h lock mode 01h: (Novell, NTNX only)
	    AL = flags
		bit 0: lock as well as log the record
		bit 1: non-exclusive lock
	    BP = lock timeout in timer ticks (1/18 sec)
Return: AL = error code
	    00h successful
	    96h no dynamic memory for file
	    FEh timed out
	    FFh unsuccessful
SeeAlso: AH=D1h,AH=D2h
----------21D000-----------------------------
INT 21 - VIRUS - "Fellowship" - INSTALLATION CHECK
	AX = D000h
Return: BX = 1234h if resident
SeeAlso: AH=CCh"VIRUS",AH=D5h"VIRUS",AX=D5AAh
----------21D1-------------------------------
INT 21 - Novell NetWare 4.6, Banyan VINES, Alloy NTNX - LOCK LOGICAL RECORD SET
	AH = D1h
	if function C6h lock mode 00h:
	    DL = mode
		00h no wait
		01h wait
	if function C6h lock mode 01h: (Novell only)
	   BP = lock timeout in timer ticks (1/18 sec)
		0000h no wait
Return: AL = error code (see AH=D0h)
SeeAlso: AH=D0h,AH=D3h
----------21D2-------------------------------
INT 21 - Novell NetWare 4.0, Banyan VINES, Alloy NTNX - UNLOCK LOGICAL RECORD
	AH = D2h
	DS:DX -> semaphore identifier (counted string up to 100 chars long)
Return: AL = error code (see AH=D0h)
Note:	unlocks record but does not remove it from log table
SeeAlso: AH=D0h,AH=D3h
----------21D3-------------------------------
INT 21 - Novell NetWare 4.0,Banyan VINES,Alloy NTNX - UNLOCK LOGICAL RECORD SET
	AH = D3h
Return: AL = error code (see AH=D0h)
Note:	unlocks all semaphores logged in the semaphore set of the requesting PC
SeeAlso: AH=D1h,AH=D2h
----------21D4-------------------------------
INT 21 - Novell NetWare 4.0, Banyan VINES, Alloy NTNX - CLEAR LOGICAL RECORD
	AH = D4h
	DS:DX -> semaphore identifier (counted string up to 100 chars long)
Return: AL = error code
	    00h successful
	    FFh not successful
Note:	unlocks record and removes it from log table
SeeAlso: AH=D5h
----------21D5-------------------------------
INT 21 - Novell NetWare 4.0,Banyan VINES,Alloy NTNX - CLEAR LOGICAL RECORD SET
	AH = D5h
Return: AL = error code (see AH=D4h)
Note:	unlocks and clears all semaphores associated with the semaphore set
	  of the requesting PC
SeeAlso: AH=D4h
----------21D5-------------------------------
INT 21 - VIRUS - "Carfield" - ???
	AH = D5h
	???
Return: ???
SeeAlso: AX=D5AAh,AH=F3h"Carfield"
----------21D5AA-----------------------------
INT 21 - VIRUS - "Diamond-A", "Diamond-B" - INSTALLATION CHECK
	AX = D5AAh
Return: AX = 2A55h if "Diamond-A" resident
	AX = 2A03h if "Diamond-B"-family virus resident
SeeAlso: AX=D000h,AH=D5h"VIRUS",AX=D5AAh/BP=DEAAh
----------21D5AABPDEAA-----------------------
INT 21 - VIRUS - "Dir" - INSTALLATION CHECK
	AX = D5AAh
	BP = DEAAh
Return: SI = 4321h if resident
SeeAlso: AX=D5AAh,AX=DADAh"VIRUS"
----------21D6-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - END OF JOB
	AH = D6h
Return: AL = error code
Note:	unlocks and clears all locked or logged files and records held by
	  process, closes all files, resets error and lock modes, and releases
	  all network resources
SeeAlso: AH=BBh
----------21D7-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - SYSTEM LOGOUT
	AH = D7h
Return: AL = error code
----------21D8-------------------------------
INT 21 - Novell NetWare, Banyan VINES - ALLOCATE RESOURCE
	AH = D8h
	DL = resource number
Return: AL = status
	    00h successful
	    FFh unsucessful
SeeAlso: AH=D9h
----------21D9-------------------------------
INT 21 - Novell NetWare, Banyan VINES - DEALLOCATE RESOURCE
	AH = D9h
	DL = resource number
Return:	AL = status (see AH=D8h)
SeeAlso: AH=D8h
----------21DA-------------------------------
INT 21 - Novell NetWare 4.0 - GET VOLUME STATISTICS
	AH = DAh
	DL = volume number
	ES:DI -> reply buffer (see below)
Return: AL = 00h
SeeAlso: AH=36h

Format of reply buffer:
Offset	Size	Description
 00h	WORD	sectors/block
 02h	WORD	total blocks
 04h	WORD	unused blocks
 06h	WORD	total directory entries
 08h	WORD	unused directory entries
 0Ah 16 BYTEs	volume name, null padded
 1Ah	WORD	removable flag, 0000h = not removable
Note:	all words are big-endian (high byte first)
----------21DADA-----------------------------
INT 21 - VIRUS - "Gotcha" - INSTALLATION CHECK
	AX = DADAh
Return: AH = A5h
SeeAlso: AX=D5AAh,AH=DAFEh"VIRUS"
----------21DAFE-----------------------------
INT 21 - VIRUS - "Plovdiv 1.3" - INSTALLATION CHECK
	AX = DAFEh
Return: AX = 1234h if resident
SeeAlso: AX=DADAh,AH=DDh"VIRUS",AH=DEh"VIRUS"
----------21DB-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - GET NUMBER OF LOCAL DRIVES
	AH = DBh
Return: AL = number of local disks as set by LASTDRIVE in CONFIG.SYS
SeeAlso: AH=0Eh
----------21DC-------------------------------
INT 21 - Novell NetWare 4.0, Banyan VINES, Alloy NTNX - GET STATION NUMBER
	AH = DCh
Return: AL = station number
	    00h if NetWare not loaded or this machine is a non-dedicated server
	CX = station number in ASCII
Note:	station number only unique for those PCs connected to same semaphore
	  service
----------21DC-------------------------------
INT 21 - PCMag PCMANAGE/DCOMPRES - TURN ON/OFF
	AH = DCh
	DX = state
	    0000h turn on
	    0001h turn off
SeeAlso: AX=FEDCh
----------21DD-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - SET ERROR MODE
	AH = DDh
	DL = error mode
	    00h invoke INT 24 on critical I/O errors
	    01h return NetWare extended error code in AL
	    02h return error code in AL, mapped to standard DOS error codes
Return: AL = previous error mode
----------21DD-------------------------------
INT 21 - VIRUS - "Jerusalem"-family - RELOCATE VIRUS???
	AH = DDh
	CX = number of bytes to copy
	DS:SI -> source of copy
	ES:DI -> destination of copy
Return: does not return normally; return address is caller's CS:0100h with
	  AX = ???
SeeAlso: AH=E0h"VIRUS",AH=EEh"VIRUS"
----------21DE-------------------------------
INT 21 - Novell NetWare 4.0 - SET BROADCAST MODE
	AH = DEh
	AL = broadcast mode
	    00h receive console and workstation broadcasts
	    01h receive console broadcasts only
	    02h receive no broadcasts
	    03h store all broadcasts for retrieval
	    04h get broadcast mode
	    05h disable shell timer interrupt checks
	    06h enable shell timer interrupt checks
Return: AL = old broadcast mode
----------21DE-------------------------------
INT 21 - VIRUS - "Durban" - INSTALLATION CHECK
	AH = DEh
Return: AH = DFh if resident
SeeAlso: AX=DAFEh,AX=DEDEh"VIRUS"
----------21DE-------------------------------
INT 21 - VIRUS - "April 1st EXE" - ???
	AH = DEh
	???
Return: ???
----------21DEDE-----------------------------
INT 21 - VIRUS - "Brothers" - INSTALLATION CHECK
	AX = DEDEh
Return: AH = 41h if resident
SeeAlso: AH=DEh"VIRUS",AH=E0h"VIRUS"
----------21DF-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - CAPTURE
	AH = DFh
	AL = subfunction
	    00h start LPT capture
	    01h end LPT capture
	    02h cancel LPT capture
	    03h flush LPT capture
	    04h start specific capture
	    05h end specific capture
	    06h cancel specific capture
	    07h flush specific capture
Return: AL = error code
Note:	under NTNX, only AL=00h-03h are supported, and all four send a print
	  break (see INT 17/AH=84h)
----------21E0-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - PRINT SPOOLING
	AH = E0h
	DS:SI -> request buffer
	ES:DI -> reply buffer
	subfunction in third byte of request buffer
	    00h spool data to a capture file
	    01h close and queue capture file
	    02h set spool flags
	    03h spool existing file
	    04h get spool queue entry
	    05h remove entry from spool queue
	    06h get printer status
	    09h create a disk capture file
Return: AL = error code
----------21E0-------------------------------
INT 21 - OS/286, OS/386 - INITIALIZE REAL PROCEDURE
	AH = E0h
	???
Return: ???
SeeAlso: AH=E1h"OS/286"
----------21E0-------------------------------
INT 21 - DoubleDOS - MENU CONTROL
	AH = E0h
	AL = subfunction
	    01h exchange tasks
	    73h resume invisible job if suspended
	    74h kill other job
	    75h suspend invisible job
Note:	identical to AH=F0h
SeeAlso: AH=F0h"DoubleDOS"
----------21E0-------------------------------
INT 21 - VIRUS - "Jerusalem", "Armagedon" - INSTALLATION CHECK
	AH = E0h
Return: AX = 0300h if "Jerusalem" resident
	AX = DADAh if "Armagedon" resident
SeeAlso: AH=DEh"VIRUS",AX=DEDEh"VIRUS",AX=E00Fh
----------21E00F-----------------------------
INT 21 - VIRUS - "8-tunes" - INSTALLATION CHECK
	AX = E00Fh
Return: AX = 4C31h if resident
SeeAlso: AH=E0h"VIRUS",AH=E1h"VIRUS"
----------21E1-------------------------------
INT 21 - Novell NetWare 4.0 - BROADCAST MESSAGES
	AH = E1h
	DS:SI -> request buffer
	ES:DI -> reply buffer
	subfunction in third byte of request buffer
	    00h send broadcast message
	    01h get broadcast message
	    02h disable station broadcasts
	    03h enable station broadcasts
	    04h send personal message
	    05h get personal message
	    06h open message pipe
	    07h close message pipe
	    08h check pipe status
	    09h broadcast to console
Return: AL = error code
----------21E1-------------------------------
INT 21 - OS/286, OS/386 - ISSUE REAL PROCEDURE CALL
	AH = E1h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AH=E0h"OS/286",AH=E2h"OS/286",AH=E3h"OS/286",AX=250Eh,INT 31/AX=0301h
----------21E1-------------------------------
INT 21 - DoubleDOS - CLEAR KEYBOARD BUFFER FOR CURRENT JOB
	AH = E1h
SeeAlso: AH=E2h"DoubleDOS",AH=E3h"DoubleDOS",AH=E8h"DoubleDOS"
SeeAlso: AH=F1h"DoubleDOS"
----------21E1-------------------------------
INT 21 - VIRUS - "Mendoza", "Fu Manchu" - INSTALLATION CHECK
	AH = E1h
Return: AX = 0300h if "Mendoza" resident
	AX = 0400h if "Fu Manchu" resident
SeeAlso: AX=E00Fh,AH=E4h"VIRUS"
----------21E2-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - DIRECTORY FUNCTIONS
	AH = E2h
	DS:SI -> request buffer
	ES:DI -> reply buffer
	subfunction in third byte of request buffer
	    00h set directory handle
	    01h get directory path
	    02h scan directory information
	    03h get effective directory rights
	    04h modify maximum rights mask
	    05h get volume number
	    06h get volume name
	    0Ah create directory
	    0Bh delete directory
	    0Ch scan directory for trustees
	    0Dh add trustee to directory
	    0Eh delete trustee from directory
	    0Fh rename directory
	    10h purge erased files
	    11h restore erased file
	    12h allocate permanent directory handle
	    13h allocate temporary directory handle
	    14h deallocate directory handle
	    15h get volume info with handle
	    16h allocate special temporary directory handle
	    17h retrieve a short base handle (Advanced NetWare 2.0)
	    18h restore a short base handle (Advanced NetWare 2.0)
	    19h set directory information
Return: AL = error code
----------21E2-------------------------------
INT 21 - OS/286, OS/386 - SET REAL PROCEDURE SIGNAL HANDLER
	AH = E2h
	???
Return: ???
SeeAlso: AH=E0h"OS/286",AH=E1h"OS/286",AH=E6h"OS/286"
----------21E2-------------------------------
INT 21 - DoubleDOS - SEND CHARACTER TO KEYBOARD BUFFER OF OTHER JOB
	AH = E2h
	AL = character
Return: AL = 00h successful
	     01h buffer full (128 characters)
SeeAlso: AH=E1h"DoubleDOS",AH=E3h"DoubleDOS",AH=E8h"DoubleDOS"
SeeAlso: AH=F2h"DoubleDOS"
----------21E3-------------------------------
INT 21 - Novell NetWare 4.0, Alloy NTNX - CONNECTION CONTROL
	AH = E3h
	DS:SI -> request buffer
	ES:DI -> reply buffer
	subfunction in third byte of request buffer
	    00h login
	    01h change password
	    02h map user to station set
	    03h map object to number
	    04h map number to object
	    05h get station's logged information
	    06h get station's root mask (obsolete)
	    07h map group name to number
	    08h map number to group name
	    09h get memberset M of group G
	    0Ah enter login area
	    0Bh ???
	    0Ch ???
	    0Dh log network message
	    0Eh get disk utilization (Advanced NetWare 1.0)
	    0Fh scan file information (Advanced NetWare 1.0)
	    10h set file information (Advanced NetWare 1.0)
	    11h get file server information (Advanced NetWare 1.0)
	    12h ???
	    13h get internet address (Advanced NetWare 1.02)
	    14h login to file server (Advanced NetWare 2.0)
	    15h get object connection numbers (Advanced NetWare 2.0)
	    16h get connection information (Advanced NetWare 1.0)
	    32h create object (Advanced NetWare 1.0)
	    33h delete object (Advanced NetWare 1.0)
	    34h rename object (Advanced NetWare 1.0)
	    35h get object ID (Advanced NetWare 1.0)
	    36h get object name (Advanced NetWare 1.0)
	    37h scan object (Advanced NetWare 1.0)
	    38h change object security (Advanced NetWare 1.0)
	    39h create property (Advanced NetWare 1.0)
	    3Ah delete property (Advanced NetWare 1.0)
	    3Bh change property security (Advanced NetWare 1.0)
	    3Ch scan property (Advanced NetWare 1.0)
	    3Dh read property value (Advanced NetWare 1.0)
		request buffer contains the property name in all caps
		property "IDENTIFICATION" returns the user's name
	    3Eh write property value (Advanced NetWare 1.0)
	    3Fh verify object password (Advanced NetWare 1.0)
	    40h change object password (Advanced NetWare 1.0)
	    41h add object to set (Advanced NetWare 1.0)
	    42h delete object from set (Advanced NetWare 1.0)
	    43h is object in set? (Advanced NetWare 1.0)
	    44h close bindery (Advanced NetWare 1.0)
	    45h open bindery (Advanced NetWare 1.0)
	    46h get bindery access level (Advanced NetWare 1.0)
	    47h scan object trustee paths (Advanced NetWare 1.0)
	    C8h check console priviledges
	    C9h get file server description strings
	    CAh set file server date and time
	    CBh disable file server login
	    CCh enable file server login
	    CDh get file server login status
	    CEh purge all erased files
	    CFh disable transaction tracking
	    D0h enable transaction tracking
	    D1h send console broadcast
	    D2h clear connection number
	    D3h down file server
	    D4h get file system statistics
	    D5h get transaction tracking statistics
	    D6h read disk cache statistics
	    D7h get drive mapping table
	    D8h read physical disk statistics
	    D9h get disk channel statistics
	    DAh get connection's task information
	    DBh get list of a connection's open files
	    DCh get list of connections using a file
	    DDh get physical record locks by connection and file
	    DEh get physical record locks by file
	    DFh get logical records by connection
	    E0h get logical record information
	    E1h get connection's semaphores
	    E2h get semaphore information
	    E3h get LAN driver's configuration information
	    E5h get connection's usage statistics
	    E6h get object's remaining disk space
	    E7h get server LAN I/O statistics
	    E8h get server miscellaneous information
	    E9h get volume information
Return: AL = error code

Format of object property:
Offset	Size	Description
 00h 1-16 BYTEs	property name
  N	BYTE	flags
		bit 0: property is dynamic
		    4: property belongs to set rather than item
 N+1	BYTE	security levels (see below)
	???

Values for security levels:
 00h	everyone may access
 01h	only logged-in clients may access
 02h	only clients logged-in with object's name, type, and password
 03h	only clients logged-in with supervisor privileges
 04h	only NetWare may access
Note:	the above values are stored in a nybble; the high half-byte is write
	  access and the low half-byte is read access

Values for object type:
 00h	unknown
 01h	user
 02h	user group
 03h	print queue
 04h	file server
 05h	job server
 06h	gateway
 07h	print server
 08h	archive queue
 09h	archive server
 0Ah	job queue
 0Bh	administration
 24h	remote bridge server
 47h	advertising print server
 FFh	wild (used only for finding objects)
----------21E3-------------------------------
INT 21 - OS/286, OS/386 - ISSUE REAL INTERRUPT
	AH = E3h
	AL = interrupt number
	???
Return: ???
Note:	protected mode only???
SeeAlso: AH=E1h"OS/286",INT 31/AX=0300h
----------21E3-------------------------------
INT 21 - DoubleDOS - ADD CHARACTER TO KEYBOARD BUFFER OF CURRENT JOB
	AH = E3h
	AL = character
Return: AL = 00h successful
	     01h buffer full (128 characters)
SeeAlso: AH=E1h"DoubleDOS",AH=E2h"DoubleDOS",AH=E8h"DoubleDOS"
SeeAlso: AH=F3h"DoubleDOS"
----------21E4-------------------------------
INT 21 - Novell NetWare 4.0 - SET FILE ATTRIBUTES (FCB)
	AH = E4h
	CL = file attributes
	    bit 0: read only
		1: hidden
		2: system
		7: shareable
	DX:DX -> FCB (see AH=0Fh)
Return: AL = error code
SeeAlso: AX=4301h
----------21E4-------------------------------
INT 21 - VIRUS - "Anarkia" - INSTALLATION CHECK
	AH = E4h
Return: AH = 04h if resident
SeeAlso: AH=E1h"VIRUS",AH=E7h"VIRUS"
----------21E400-----------------------------
INT 21 - DoubleDOS - INSTALLATION CHECK/PROGRAM STATUS
	AX = E400h
Return: AL = 00h if DoubleDOS not present
	   = 01h if running in visible DoubleDOS partition
	   = 02h if running in the invisible DoubleDOS partition
SeeAlso: AH=E5h"DoubleDOS",AX=F400h
----------21E400-----------------------------
INT 21 - OS/286, OS/386 - CHAIN TO REAL-MODE HANDLER
	AX = E400h
	???
Return: ???
Note:	protected mode only???
----------21E402-----------------------------
INT 21 - OS/286, OS/386 - SET PROTECTED-MODE TASK GATE
	AX = E402h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=E403h
----------21E403-----------------------------
INT 21 - OS/286, OS/386 - REMOVE PROTECTED-MODE TASK GATE
	AX = E403h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=E402h
----------21E5-------------------------------
INT 21 - Novell NetWare 4.0 - UPDATE FILE SIZE (FCB)
	AH = E5h
	DS:DX -> FCB (see AH=0Fh)
Return: AL = error code
----------21E5-------------------------------
INT 21 - DoubleDOS - OTHER PROGRAM STATUS
	AH = E5h
Return: AL = 00h no program in other partition
	   = 01h program in other partition is running
	   = 02h program in other partition is suspended
SeeAlso: AX=E400h"DoubleDOS",AH=F5h"DoubleDOS"
----------21E500-----------------------------
INT 21 - OS/286, OS/386 - HEAP MANAGEMENT STRATEGY
	AX = E500h
	???
Return: ???
SeeAlso: AX=E501h
----------21E501-----------------------------
INT 21 - OS/286, OS/386 - FORCE HEAP COMPACTION
	AX = E501h
	???
Return: ???
SeeAlso: AX=E500h
----------21E6-------------------------------
INT 21 - Novell NetWare 4.0 - COPY FILE TO FILE (FCB)
	AH = E6h
	CX:DX = number of bytes to copy
	DS:SI -> source FCB
	ES:DI -> destination FCB
Return: AL = error code
----------21E6-------------------------------
INT 21 P - OS/286, OS/386 - ISSUE REAL PROCEDURE SIGNAL FROM PROTECTED MODE
	AH = E6h
	???
Return: ???
SeeAlso: AX=E2h"OS/286"
----------21E7-------------------------------
INT 21 - Novell NetWare 4.0, Banyan VINES - GET FILE SERVER DATE AND TIME
	AH = E7h
	DS:DX -> date/time buffer (see below)
Return: AL = error code
	    00h successful
	    FFh unsuccessful
Note:	also supported by Alloy NTNX
SeeAlso: AH=2Ah,AH=2Ch

Format of date/time buffer:
Offset	Size	Description
 00h	BYTE	year - 1900
 01h	BYTE	month (1=Jan)
 02h	BYTE	day
 03h	BYTE	hours
 04h	BYTE	minutes
 05h	BYTE	seconds
 06h	BYTE	day of week (0 = Sunday) (Novell and NTNX only)
----------21E7-------------------------------
INT 21 - OS/286, OS/386 - CREATE CODE SEGMENT
	AH = E7h
	???
Return: ???
SeeAlso: AH=E8h"OS/286",AH=E9h"OS/286",AH=EAh"OS/286"
----------21E7-------------------------------
INT 21 - VIRUS - "Spyer"/"Kiev" - INSTALLATION CHECK
	AH = E7h
Return: AH = 78h if resident
SeeAlso: AH=E4h"VIRUS",AX=EC59h
----------21E8-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - SET FCB RE-OPEN MODE
	AH = E8h
	DL = mode
	    00h no automatic re-open
	    01h auto re-open
Return: AL = error code
----------21E8-------------------------------
INT 21 - OS/286, OS/386 - SEGMENT CREATION
	AH = E8h
	AL = type
	    00h data segment
	    01h data window/alias
	    02h real segment
	    03h real window/alias
	    06h shareable segment
	???
Return: ???
SeeAlso: AH=E7h"OS/286",AH=E9h"OS/286"
----------21E8-------------------------------
INT 21 - DoubleDOS - SET/RESET KEYBOARD CONTROL FLAGS
	AH = E8h
	AL = 00h set flags for this program
	   = 01h set flags for other program
	DX = keyboard control flags (bit set enables, cleared disables
	    bit 0: menu
	    bit 1: exchange
	    bit 2: entire keyboard enable/disable
	    bit 3: Ctrl-C
	    bit 4: Ctrl-PrtSc
	    bit 5: Alt/Erase
	    bit 6: Ctrl-Break
	    bit 7: Ctrl-NumLock
	    bit 8: shift-PrtSc
	    bit 9-13: undefined
	    bit 14: cancel key (clear keyboard buffer)
	    bit 15: suspend key
Return: DX = previous flags
Notes:	disabling Ctrl-PrtSc will allow the program to intercept the keystroke;
	  disabling any of the other keystrokes disables them completely
	identical to AH=F8h
SeeAlso: AH=E1h"DoubleDOS",AH=E2h"DoubleDOS",AH=E3h"DoubleDOS"
SeeAlso: AH=F8h"DoubleDOS"
----------21E9-------------------------------
INT 21 P - OS/286, OS/386 - CHANGE SEGMENTS
	AH = E9h
	AL = function
	    01h change code segment parameters
	    02h	change data segment parameters
	    05h adjust segment limit
	    06h change segment base address
	???
Return: ???
SeeAlso: AH=E7h"OS/286",AH=E8h"OS/286",AH=EAh"OS/286",AH=EDh"OS/286"
SeeAlso: INT 31/AX=0007h,INT 31/AX=0008h
----------21E9-------------------------------
INT 21 - DoubleDOS - SET TIMESHARING PRIORITY
	AH = E9h
	AL = 00h visible program gets 70%, invisible gets 30% (default)
	   = 01h visible program gets 50%, invisible gets 50%
	   = 02h visible program gets 30%, invisible gets 70%
	   = 03h Top program gets 70%, bottom program gets 30%
	   = 04h Top program gets 30%, bottom program gets 70%
	   = 05h get current priority
		Return: AL = priority setting
Note:	identical to AH=F9h
SeeAlso: AH=EAh"DoubleDOS",AH=EBh"DoubleDOS",AH=F9h"DoubleDOS"
----------21E900-----------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - SHELL'S "GET BASE STATUS"
	AX = E900h
	DX = drive number to check (0 = A:)
Return: AL = network pathbase
	AH = base flags
	    00h drive not currently mapped to a base
	    01h drive is mapped to a permanent base
	    02h drive is mapped to a temporary base
	    03h drive exists locally
----------21E905-----------------------------
INT 21 - Novell NetWare shell 3.01 - MAP A FAKE ROOT DIRECTORY
	AX = E905h
	BL = drive number (0=default, 1=A:, ...)
	DS:DX -> ASCIZ path for fake root (may include server name or be empty)
Return: CF set on error
	    AL = error code (03h,0Fh,11h) (see AH=59h)
	CF clear if successful
Note:	if drive is not currently mapped, a drive mapping will be created
SeeAlso: AX=E906h
----------21E906-----------------------------
INT 21 - Novell NetWare shell 3.01 - DELETE FAKE ROOT DIRECTORY
	AX = E906h
	BL = drive number (0=default, 1=A:, ...)
Note:	drive remains mapped
SeeAlso: AX=E905h
----------21E907-----------------------------
INT 21 - Novell NetWare shell 3.01 - GET RELATIVE DRIVE DEPTH
	AX = E907h
	BL = drive number (0=default, 1=A:, ...)
Return: AL = number of directories below the fake root
	    FFh if no fake root assigned
SeeAlso: AX=E905h
----------21E908BL00-------------------------
INT 21 - Novell NetWare shell 3.01 - SET SHOW DOTS
	AX = E908h
	BL = 00h	don't return '.' or '..' during directory scans
	   = nonzero	directory scans will return '.' or '..' entries
Return: BL = previous show-dots setting
----------21EA-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - RETURN SHELL VERSION
	AH = EAh
	AL = return version environment string
	    00h		don't return string
	    nonzero	return string in 40-byte buffer pointed to by ES:DI
		Return: buffer filled with three null-terminated entries:
			major operating system
			version
			hardware type
Return: AH = operating system (00h = MSDOS)
	AL = hardware type
	    00h IBM PC
	    01h Victor 9000
	BH = major shell version
	BL = minor shell version
	CH = (v3.01+) shell type
	    00h conventional memory
	    01h expanded memory
	    02h extended memory
	CL = shell revision number
----------21EA-------------------------------
INT 21 - DoubleDOS - TURN OFF TASK SWITCHING
	AH = EAh
Return: task switching turned off
SeeAlso: AH=E9h"DoubleDOS",AH=EBh"DoubleDOS",AH=FAh"DoubleDOS"
SeeAlso: INT FA"DoubleDOS"
----------21EA-------------------------------
INT 21 - OS/286, OS/386 - ALLOCATE HUGE SEGMENT
	AH = EAh
	???
Return: ???
Note:	protected mode only???
SeeAlso: AH=E7h"OS/286",AH=E8h"OS/286",AH=E9h"OS/286"
----------21EB-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - LOG FILE
	AH = EBh
	DS:DX -> ASCIZ filename
	if function C6h lock mode 01h:
	    AL = flags
		00h log file only
		01h lock as well as log file
	    BP = lock timeout in timer ticks (1/18 second)
Return: AL = error code
	    00h successful
	    96h no dynamic memory for file
	    FEh timed out
	    FFh failed
SeeAlso: AH=CAh,AH=ECh"Novell"
----------21EB-------------------------------
INT 21 - DoubleDOS - TURN ON TASK SWITCHING
	AH = EBh
Return: task switching turned on
SeeAlso: AH=E9h"DoubleDOS",AH=EAh"DoubleDOS",AH=FBh"DoubleDOS"
SeeAlso: INT FB"DoubleDOS"
----------21EB00-----------------------------
INT 21 - OS/386 VMM - GET A PAGE TABLE ENTRY BY LINEAR ADDRESS
	AX = EB00h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB02h,AX=EB04h,INT 31/AX=0506h
----------21EB02-----------------------------
INT 21 - OS/386 VMM - GET A PAGE TABLE ENTRY BY 16-BIT SEGMENT:OFFSET
	AX = EB02h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB00h,AX=EB04h
----------21EB03-----------------------------
INT 21 - OS/386 VMM - FREE MAPPED PAGES
	AX = EB03h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB05h,INT 31/AX=0801h
----------21EB04-----------------------------
INT 21 - OS/386 VMM - GET A PAGE TABLE ENTRY BY 32-BIT SEGMENT:OFFSET
	AX = EB04h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB00h,AX=EB02h
----------21EB05-----------------------------
INT 21 - OS/386 VMM - MAP PAGES
	AX = EB05h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB03h,INT 31/AX=0800h
----------21EB06-----------------------------
INT 21 - OS/386 VMM - LOCK PAGES IN MEMORY
	AX = EB06h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB07h,INT 31/AX=0600h
----------21EB07-----------------------------
INT 21 - OS/386 VMM - UNLOCK MEMORY PAGES
	AX = EB07h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB06h,INT 31/AX=0601h
----------21EC-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - RELEASE FILE
	AH = ECh
	DS:DX -> ASCIZ filename
Return: none
SeeAlso: AH=EBh"Novell"
----------21EC-------------------------------
INT 21 - DoubleDOS - GET VIRTUAL SCREEN ADDRESS
	AH = ECh
Return: ES = segment of virtual screen
Notes:	screen address can change if task-switching is on!!
	identical to AH=FCh
SeeAlso: AH=FCh"DoubleDOS",INT FC"DoubleDOS"
----------21EC-------------------------------
INT 21 - OS/286, OS/386 - BLOCK TRANSFER
	AH = ECh
	???
Return: ???
----------21EC59-----------------------------
INT 21 - VIRUS - "Terror" - INSTALLATION CHECK
	AX = EC59h
Return: BP = EC59h if resident
SeeAlso: AH=E7h"VIRUS",AH=EEh"VIRUS"
----------21ED-------------------------------
INT 21 - Novell NetWare, Alloy NTNX - CLEAR FILE
	AH = EDh
	DS:DX -> ASCIZ filename
Return: AL = error code
SeeAlso: AH=CEh,AH=EBh"Novell"
----------21ED-------------------------------
INT 21 - OS/286, OS/386 - GET SEGMENT OR WINDOW DESCRIPTOR
	AH = EDh
	???
Return: ???
Note:	protected mode only???
SeeAlso: AH=E9h"OS/286"
----------21EE-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - GET PHYSICAL STATION NUMBER
	AH = EEh
Return: CX:BX:AX = six-byte address
----------21EE-------------------------------
INT 21 - DoubleDOS - GIVE AWAY TIME TO OTHER TASKS
	AH = EEh
	AL = number of 55ms time slices to give away
Return: returns after giving away time slices
SeeAlso: AH=FEh"DoubleDOS",INT FE"DoubleDOS"
----------21EE-------------------------------
INT 21 - VIRUS - "Jerusalem-G", "Pregnant" - INSTALLATION CHECK
	AH = EEh
Return: AX = 0300h if "Jerusalem-G" resident
	AL = 05h if "Pregnant" resident
SeeAlso: AH=DDh"VIRUS",AX=EC59h,AH=F0h"VIRUS"
----------21EF-------------------------------
INT 21 - Novell Advanced NetWare 1.0+ - GET DRIVE INFO
	AH = EFh
	AL = subfunction
	    00h get drive handle table
	    01h get drive flag table
	    02h get drive connection ID table
	    03h get connection ID table (see below)
	    04h get file server name table
Return: ES:DI -> shell status table
Note:	drive handle, flag, and connection ID tables each contain 32 entries

Format of connection ID table:
Offset	Size	Description
 00h	BYTE	in use flag
		E0h AES temporary
		F8h IPX in critical section
		FAh processing
		FBh holding
		FCh AES waiting
		FDh waiting
		FEh receiving
		FFh sending
 01h	BYTE	order number
 02h	DWORD	file server's network address (high byte first)
 06h  6 BYTEs	file server's node address (high byte first)
 0Ch	WORD	socket number (high byte first)
 0Eh	WORD	base receive timeout in clock ticks (high byte first)
 10h  6 BYTEs	preferred routing node (high byte first)
 16h	BYTE	packet sequence number
 17h	BYTE	connection number
 18h	BYTE	connection status (FFh if active)
 19h	WORD	maximum receive timeout in clock ticks (high byte first)
 1Bh  5 BYTEs	reserved

Values in drive flag table:
 00h	drive is not mapped
 01h	permanent network drive
 02h	temporary network drive
 80h	mapped to local drive
 81h	local drive used as permanent network drive
 82h	local drive used as temporary network drive
----------21F0-------------------------------
INT 21 - Novell Advanced NetWare 1.0+ - CONNECTION ID
	AH = F0h
	AL = subfunction
	    00h set preferred connection ID
	    01h get preferred connection ID
	    02h get default connection ID
	    03h LPT capture active
	    04h set primary connection ID
	    05h get primary connection ID
	DL = preferred file server
Return: AL = selected file server
----------21F0-------------------------------
INT 21 - DoubleDOS - MENU CONTROL
	AH = F0h
	AL = subfunction
	    01h exchange tasks
	    73h resume invisible job if suspended
	    74h kill other job
	    75h suspend invisible job
Note:	identical to AH=E0h
SeeAlso: AH=E0h"DoubleDOS"
----------21F0-------------------------------
INT 21 - VIRUS - "Frere Jacques" - INSTALLATION CHECK
	AH = F0h
Return: AX = 0300h if resident
SeeAlso: AH=EEh"VIRUS",AH=F1h"VIRUS"
----------21F1-------------------------------
INT 21 - Novell Advanced NetWare 1.0+ - FILE SERVER CONNECTION
	AH = F1h
	AL = subfunction
	    00h attach to file server
		DL = preferred file server
	    01h detach from file server
		DL = connection ID
	    02h logout from file server
		DL = connection ID
Return: AL = completion code
----------21F1-------------------------------
INT 21 - DoubleDOS - CLEAR KEYBOARD BUFFER FOR CURRENT JOB
	AH = F1h
SeeAlso: AH=E1h"DoubleDOS",AH=F2h"DoubleDOS",AH=F3h"DoubleDOS"
SeeAlso: AH=F8h"DoubleDOS"
----------21F1-------------------------------
INT 21 - VIRUS - "F1-337" - ???
	AH = F1h
	???
Return: ???
SeeAlso: AH=F0h"VIRUS",AX=F2AAh
----------21F2-------------------------------
INT 21 - Novell NetWare v3.01+ shell interface - MULTIPLEXOR
	AH = F2h
	AL = function
	    15h broadcast services (see AH=E1h)
	    17h connection control (see AH=E3h)
	DS:SI -> request buffer
	ES:DI -> reply buffer
Return: ???
Notes:	this is a multiplexor to access other net interface functions which
	  were accessed via a separate AH function in older versions
	the function number in AL is added to CCh to get the old function
	  number which is desired
----------21F2-------------------------------
INT 21 - DoubleDOS - SEND CHARACTER TO KEYBOARD BUFFER OF OTHER JOB
	AH = F2h
	AL = character
Return: AL = 00h successful
	     01h buffer full (128 characters)
SeeAlso: AH=E2h"DoubleDOS",AH=F1h"DoubleDOS",AH=F3h"DoubleDOS"
SeeAlso: AH=F8h"DoubleDOS"
----------21F2AA-----------------------------
INT 21 - VIRUS - "PcVrsDs" - INSTALLATION CHECK
	AX = F2AAh
Return: AH = AAh if resident
SeeAlso: AH=F1h"VIRUS",AH=F3h"VIRUS"
----------21F3-------------------------------
INT 21 - Novell Advanced NetWare 2.0+ - FILE SERVER FILE COPY
	AH = F3h
	ES:DI -> request string (see below)
Return: AL = status/error code
	CX:DX = number of bytes copied

Format of request string:
Offset	Size	Description
 00h	WORD	source file handle
 02h	WORD	destination file handle
 04h	DWORD	starting offset in source
 08h	DWORD	starting offset in destination
 0Ch	DWORD	number of bytes to copy
----------21F3-------------------------------
INT 21 - DoubleDOS - ADD CHARACTER TO KEYBOARD BUFFER OF CURRENT JOB
	AH = F3h
	AL = character
Return: AL = 00h successful
	     01h buffer full (128 characters)
SeeAlso: AH=E3h"DoubleDOS",AH=F1h"DoubleDOS",AH=F2h"DoubleDOS"
SeeAlso: AH=F8h"DoubleDOS"
----------21F3-------------------------------
INT 21 - VIRUS - "Carfield" - INSTALLATION CHECK
	AH = F3h
Return: AX = 0400h if resident
SeeAlso: AH=D5h"Carfield",AX=F2AAh,AH=F7h"VIRUS"
----------21F400-----------------------------
INT 21 - DoubleDOS - INSTALLATION CHECK/PROGRAM STATUS
	AX = F400h
Return: AL = 00h if DoubleDOS not present
	   = 01h if running in visible DoubleDOS partition
	   = 02h if running in the invisible DoubleDOS partition
SeeAlso: AX=E400h,AH=F5h"DoubleDOS"
----------21F5-------------------------------
INT 21 - DoubleDOS - OTHER PROGRAM STATUS
	AH = F5h
Return: AL = 00h no program in other partition
	   = 01h program in other partition is running
	   = 02h program in other partition is suspended
SeeAlso: AH=E5h"DoubleDOS",AX=F400h"DoubleDOS"
----------21F7-------------------------------
INT 21 - VIRUS - "GP1" - INSTALLATION CHECK
	AH = F7h
Return: AX = 0300h if resident
SeeAlso: AH=F0h"VIRUS",AH=FBh"VIRUS"
----------21F8-------------------------------
INT 21 - DOS v??? - SET OEM INT 21 HANDLER
	AH = F8h
	DS:DX -> OEM INT 21 handler for functions F9h to FFh
		 FFFFh:FFFFh resets to original handlers

Notes:	calls to AH=F9h through AH=FFH will return CF set and AX=1 (invalid
	  function) if no handler set
	handler is called with all registers exactly as set by caller, and
	  should exit with IRET
SeeAlso: AH=F9h"OEM"
----------21F8-------------------------------
INT 21 - DoubleDOS - SET/RESET KEYBOARD CONTROL FLAGS
	AH = F8h
	AL = 00h set flags for this program
	   = 01h set flags for other program
	DX = keyboard control flags (bit set enables, cleared disables)
	    bit 0: menu
	    bit 1: exchange
	    bit 2: entire keyboard enable/disable
	    bit 3: Ctrl-C
	    bit 4: Ctrl-PrtSc
	    bit 5: Alt/Erase
	    bit 6: Ctrl-Break
	    bit 7: Ctrl-NumLock
	    bit 8: shift-PrtSc
	    bit 9-13: undefined
	    bit 14: cancel key (clear keyboard buffer)
	    bit 15: suspend key
Return: DX = previous flags
Notes:	disabling Ctrl-PrtSc will allow the program to intercept the keystroke;
	  disabling any of the other keystrokes disables them completely
	identical to AH=E8h
SeeAlso: AH=E8h"DoubleDOS",AH=F1h"DoubleDOS",AH=F2h"DoubleDOS"
SeeAlso: AH=F3h"DoubleDOS"
----------21F9-------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = F9h
SeeAlso: AH=F8h"OEM",AH=FAh"OEM"
----------21F9-------------------------------
INT 21 - DoubleDOS - SET TIMESHARING PRIORITY
	AH = F9h
	AL = 00h visible program gets 70%, invisible gets 30% (default)
	   = 01h visible program gets 50%, invisible gets 50%
	   = 02h visible program gets 30%, invisible gets 70%
	   = 03h Top program gets 70%, bottom program gets 30%
	   = 04h Top program gets 30%, bottom program gets 70%
	   = 05h get current priority
		Return: AL = priority setting
Note:	identical to AH=E9h
SeeAlso: AH=E9h"DoubleDOS",AH=FAh"DoubleDOS",AH=FBh"DoubleDOS"
----------21FA-------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = FAh
SeeAlso: AH=F9h"OEM",AH=FBh"OEM"
----------21FA-------------------------------
INT 21 - DoubleDOS - TURN OFF TASK SWITCHING
	AH = FAh
Return: task switching turned off
SeeAlso: AH=EAh"DoubleDOS",AH=F9h"DoubleDOS",AH=FBh"DoubleDOS"
SeeAlso: INT FA"DoubleDOS"
----------21FA--DX5945-----------------------
INT 21 - PC Tools 7 VDEFEND - API
	AH = FAh
	DX = 5945h
	AL = function
	    00h NOP
	    01h uninstall
		Return: CF clear if successful
			DI = 4559h
	    02h ???
		BL = ???
		Return: CF clear
			CL = old value of ???
SeeAlso: INT 2F/AX=6282h
----------21FB-------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = FBh
SeeAlso: AH=FAh"OEM",AH=FCh"OEM"
----------21FB-------------------------------
INT 21 - DoubleDOS - TURN ON TASK SWITCHING
	AH = FBh
Return: task switching turned on
SeeAlso: AH=EBh"DoubleDOS",AH=F9h"DoubleDOS",AH=FAh"DoubleDOS"
SeeAlso: INT FB"DoubleDOS"
----------21FB-------------------------------
INT 21 - VIRUS - "Cinderella" - INSTALLATION CHECK
	AH = FBh
Return: AH = 00h if resident
SeeAlso: AH=F7h"VIRUS",AX=FB0Ah
----------21FB0A-----------------------------
INT 21 - VIRUS - "dBASE" - INSTALLATION CHECK
	AX = FB0Ah
Return: AX = 0AFBh if resident
SeeAlso: AH=FBh"VIRUS",AH=FCh"VIRUS"
----------21FC-------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = FCh
SeeAlso: AH=FBh"OEM",AH=FDh"OEM"
----------21FC-------------------------------
INT 21 - DoubleDOS - GET VIRTUAL SCREEN ADDRESS
	AH = FCh
Return: ES = segment of virtual screen
Notes:	screen address can change if task-switching is on!!
	identical to AH=ECh
SeeAlso: AH=ECh"DoubleDOS",INT FC"DoubleDOS"
----------21FC-------------------------------
INT 21 - VIRUS - "Troi" - INSTALLATION CHECK
	AH = FCh
Return: AL = A5h if resident
SeeAlso: AH=FB0Ah"VIRUS",AH=FDh"VIRUS"
----------21FD-------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = FDh
SeeAlso: AH=FCh"OEM",AH=FEh"DOS"
----------21FD-------------------------------
INT 21 - VIRUS - "Border" - INSTALLATION CHECK
	AH = FDh
Return: AH = 13h if resident
SeeAlso: AH=FCh"VIRUS",AH=FEh"VIRUS"
----------21FE-------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = FEh
SeeAlso: AH=FDh"OEM",AH=FFh"OEM"
----------21FE-------------------------------
INT 21 - DoubleDOS - GIVE AWAY TIME TO OTHER TASKS
	AH = FEh
	AL = number of 55ms time slices to give away
Return: returns after giving away time slices
SeeAlso: AH=EEh"DoubleDOS",INT FE"DoubleDOS"
----------21FE-------------------------------
INT 21 - VIRUS - "483" - INSTALLATION CHECK
	AH = FEh
Return: AH = 00h if resident
SeeAlso: AH=FDh"VIRUS",AX=FE01h
----------21FE01-----------------------------
INT 21 - VIRUS - "Flip" - INSTALLATION CHECK
	AX = FE01h
Return: AX = 01FEh if resident
SeeAlso: AH=FEh"VIRUS",AX=FE02h
----------21FE02-----------------------------
INT 21 - VIRUS - "2468"/"Tequila" - INSTALLATION CHECK
	AX = FE02h
Return: AX = 01FDh if resident
SeeAlso: AX=FE01h,AX=FEDCh"VIRUS"
----------21FEDC-----------------------------
INT 21 - PCMag PCMANAGE/DCOMPRES - INSTALLATION CHECK
	AX = FEDCh
Return: AX = CDEFh if installed
SeeAlso: AH=DCh
----------21FEDC-----------------------------
INT 21 - VIRUS - "Black Monday" - INSTALLATION CHECK
	AX = FEDCh
Return: AL = DCh if resident
SeeAlso: AX=FE02h,AH=FFh"VIRUS"
----------21FF-------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = FFh
SeeAlso: AH=FEh"OEM"
----------21FF-------------------------------
INT 21 - CED (Command EDitor) - INSTALLABLE COMMANDS
	AH = FFH
	AL = subfunction
	    00h add installable command
	       BL = mode - bit 0 = 1 callable from DOS prompt
			   bit 1 = 1 callable from application
	       DS:SI -> CR-terminated command name
	       ES:DI -> FAR routine entry point
	    01h remove installable command
	       DS:SI -> CR-terminated command name
	    02h reserved, may be used to test for CED installation
Return: CF clear if successful
	CF set on error
	    AX = 01h invalid function
		 02h command not found (subfunction 01h only)
		 08h insufficient memory (subfunction 00h only)
		 0Eh bad data (subfunction 00h only)
	AH = FFh if CED not installed
Note:	CED is a shareware DOS command-line enhancer by Christopher J. Dunford
SeeAlso: AX=0A00h
----------21FF-------------------------------
INT 21 - DJ GO32.EXE 80386+ DOS extender - DOS EXTENSIONS
	AH = FFh
	AL = function
	    01h create file
	    02h open file
	    03h get file statistics
	    04h get time of day
	    05h set time of day
	    06h stat
	    07h system
SeeAlso: INT 10/AH=FFh"GO32"
----------21FF-------------------------------
INT 21 - DOSED.COM - INSTALLATION CHECK
	AH = FFh
	DS:SI -> "DOSED"
	ES = 0000h
Return: ES:DI -> "DOSED" if installed
Note:	DOSED is a free DOS commandline editor/history buffer by Sverre H.
	  Huseby
----------21FF-------------------------------
INT 21 - Topware Network Operating System - ???
	AH = FFh
	???
Return: ???
SeeAlso: INT 2F/AX=FF00h
----------21FF-------------------------------
INT 21 - VIRUS - "Sunday", "Tumen 0.5", "Hero" - INSTALLATION CHECK
	AH = FFh
Return: AH = 00h if "Tumen 0.5" or "Hero" resident
	AX = 0400h if "Sunday" resident
SeeAlso: AX=FEDCh"VIRUS",AX=FF0Fh
----------21FF00DX0078-----------------------
INT 21 - Rational Systems DOS/4G - INSTALLATION CHECK
	AX = FF00h
	DX = 0078h
Return: AL <> 00h if installed
	    GS = segment of kernel if nonzero
SeeAlso: INT 15/AX=BF02h
----------21FF0F-----------------------------
INT 21 - FLU_SHOT+ v1.83 - INSTALLATION CHECK
	AX = FF0Fh
Return: AX = 0101h if resident
Notes:	FLU_SHOT+ is an antivirus/antitrojan program by Ross M. Greenberg and
	  Software Concepts Design
	the "PSQR/1720" virus calls this function to determine whether
	  FLU_SHOT+ is present
SeeAlso: AH=FFh"VIRUS",AX=FF10h
----------21FF10-----------------------------
INT 21 - VIRUS - "Twins" - INSTALLATION CHECK
	AX = FF10h
Return: AL = 07h if resident
SeeAlso: AX=FF0Fh,AX=FFFEh
----------21FFFE-----------------------------
INT 21 - VIRUS - "08/15"/"Many Fingers" - INSTALLATION CHECK
	AX = FFFEh
Return: AX = 0815h if resident
SeeAlso: AX=FF10h,AX=FFFFh
----------21FFFF-----------------------------
INT 21 - VIRUS - "Ontario", "Year 1992"/"B1M92" - INSTALLATION CHECK
	AX = FFFFh
Return: AX = 0000h if "Ontario" resident
	AX = 07C2h (1992) if "Year 1992"/"B1M92" resident
SeeAlso: AX=FF0Fh,AX=FFFFh/CX=0000h,INT 6B"VIRUS"
----------21FFFFCX0000-----------------------
INT 21 - VIRUS - "Revenge" - INSTALLATION CHECK
	AX = FFFFh
	CX = 0000h
Return: CX = 0006h if resident
SeeAlso: AX=FFFFh,INT 6B"VIRUS"
----------22---------------------------------
INT 22 - DOS 1+ - PROGRAM TERMINATION ADDRESS
   specifies the address of the routine which is to be given control after
   a program is terminated; should never be called directly, since it does not
   point at an interrupt handler
Notes:	this vector is restored from the DWORD at offset 0Ah in the PSP during
	  termination, and then a FAR JMP is performed to the address in INT 22
	normally points at the instruction immediately following INT 21/AH=4Bh
	  call which loaded the current program
SeeAlso: INT 20,INT 21/AH=00h,INT 21/AH=31h,INT 21/AH=4Ch
----------23---------------------------------
INT 23 - DOS 1+ - CONTROL-C/CONTROL-BREAK HANDLER
   invoked whenever DOS detects a ^C or ^Break; should never be called directly
---DOS 1.x---
Return: AH = 00h abort program
	if all registers preserved, restart DOS call
---DOS 2+---
Return: all registers preserved
	return via RETF or RETF 2 with CF set
	    DOS will abort program with errorlevel 0
	else (RETF/RETF 2 with CF clear or IRET)
	    interrupted DOS call is restarted
Notes:	MSDOS 1.25 also invokes INT 23 on a divide overflow (INT 00)
	any DOS call may safely be made within the INT 23 handler, although
	  the handler must to check for a recursive invocation if it does
	  call DOS
SeeAlso: INT 1B
----------24---------------------------------
INT 24 - DOS 1+ - CRITICAL ERROR HANDLER
   invoked when a critical (usually hardware) error is encountered; should
   never be called directly

Critical error handler is invoked with:
	AH = type and processing flags
	    bit 7 clear = disk I/O error
		  set	= -- if block device, bad FAT image in memory
			  -- if char device, error code in DI
	    bit 6  unused
	    bit 5 = 1 if Ignore allowed, 0 if not (DOS 3+)
	    bit 4 = 1 if Retry allowed, 0 if not (DOS 3+)
	    bit 3 = 1 if Fail allowed, 0 if not (DOS 3+)
	    bit 2 \ disk area of error	00 = DOS area  01 = FAT
	    bit 1 /			10 = root dir  11 = data area
	    bit 0 = 1 if write, 0 if read
	AL = drive number if AH bit 7 clear
	BP:SI -> device driver header (BP:[SI+4] bit 15 set if char device)
	DI low byte contains error code if AH bit 7 set
	   00h write-protection violation attempted
	   01h unknown unit for driver
	   02h drive not ready
	   03h unknown command given to driver
	   04h data error (bad CRC)
	   05h bad device driver request structure length
	   06h seek error
	   07h unknown media type
	   08h sector not found
	   09h printer out of paper
	   0Ah write fault
	   0Bh read fault
	   0Ch general failure
	   0Dh (DOS 3+) sharing violation
	   0Eh (DOS 3+) lock violation
	   0Fh invalid disk change
	   10h (DOS 3+) FCB unavailable
	   11h (DOS 3+) sharing buffer overflow
	   12h (DOS 4+) code page mismatch
	   13h (DOS 4+) out of input
	   14h (DOS 4+) insufficient disk space
	STACK:	DWORD	return address for INT 24 call
		WORD	flags pushed by INT 24
		WORD	original AX on entry to INT 21
		WORD	BX
		WORD	CX
		WORD	DX
		WORD	SI
		WORD	DI
		WORD	BP
		WORD	DS
		WORD	ES
		DWORD	return address for INT 21 call
		WORD	flags pushed by INT 21
Handler must return:
	AL = action code
	    00h ignore error and continue processing request
	    01h retry operation
	    02h terminate program through the equivalent of INT 21/AH=4Ch
			(INT 20h for DOS 1.x)
	    03h fail system call in progress
	SS,SP,DS,ES,BX,CX,DX preserved
Notes:	the only DOS calls the handler may make are INT 21/AH=01h-0Ch,30h,59h
	if the handler returns to the application by popping the stack, DOS
	  will be in an unstable state until the first call with AH > 0Ch
	for DOS 3.1+, IGNORE (AL=00h) is turned into FAIL (AL=03h) on network
	  critical errors
	if IGNORE specified but not allowed, it is turned into FAIL
	if RETRY specified but not allowed, it is turned into FAIL
	if FAIL specified but not allowed, it is turned into ABORT
	(DOS 3+) if a critical error occurs inside the critical error handler,
	  the DOS call is automatically failed
----------25---------------------------------
INT 25 - DOS 1+ - ABSOLUTE DISK READ (except partitions > 32M)
	AL = drive number (00h = A:, 01h = B:, etc)
	CX = number of sectors to read
	DX = starting logical sector number (0000h - highest sector on drive) 
	DS:BX -> buffer for data
Return: CF clear if successful
	CF set on error
	    AH = status
		 80h device failed to respond (timeout)
		 40h seek operation failed
		 20h controller failed
		 10h data error (bad CRC)
		 08h DMA failure
		 04h requested sector not found
		 03h write-protected disk (INT 26 only)
		 02h bad address mark
		 01h bad command
	    AL = error code (same as passed to INT 24 in DI)
	may destroy all other registers except segment registers
Notes:	original flags are left on stack, and must be popped by caller
	this call bypasses the DOS filesystem
BUG:	DOS 3.1 through 3.3 set the word at ES:[BP+1Eh] to FFFFh if AL is an
	invalid drive number
SeeAlso: INT 13/AH=02h,INT 26
----------25---------------------------------
INT 25 - DOS 3.31+ - ABSOLUTE DISK READ (>32M hard-disk partition)
	AL = drive number (0=A, 1=B, etc)
	CX = FFFFh
	DS:BX -> disk read packet (see below)
Return: same as above
Notes:	partition is potentially >32M (and requires this form of the call) if
	  bit 1 of device attribute word in device driver is set
	original flags are left on stack, and must be removed by caller
	this call bypasses the DOS filesystem
SeeAlso: INT 13/AH=02h,INT 26

Format of disk read packet:
Offset	Size	Description
 00h	DWORD	sector number
 04h	WORD	number of sectors to read
 06h	DWORD	transfer address
----------25CDCD-----------------------------
INT 25 - Stacker - GET DEVICE DRIVER ADDRESS
	AX = CDCDh
	DS:BX -> buffer for address (see below)
	CX = 0001h
	DX = 0000h
Return: AX = CDCDh if Stacker installed
	    DS:BX buffer filled

Format of driver address buffer:
Offset	Size	Description
 00h	WORD	signature CDCDh
 02h	WORD	??? 0001h
 04h	DWORD	pointer to start of Stacker device driver

Format of device driver:
Offset	Size	Description
 00h	WORD	signature A55Ah
 02h	WORD	Stacker version * 64h
 04h	WORD	offset of volume-specific information offset table
		(list of WORDs, one per drive, containing offsets to various
		information)
 06h 56 BYTEs	n/a
 3Eh	BYTE	volume number, set after INT 21/AX=4404h
		(use to index into volume-specific info offset table)
 3Fh 19 BYTEs	n/a
 52h  4 BYTEs	ASCII string "SWAP"
 56h 26 BYTEs	drive mapping table (one byte for each drive A: through Z:)

Format of Stacker boot record:
Offset	Size	Description
1F0h  8 BYTEs	Stacker signature (first byte is CDh)
1F8h	DWORD	pointer to start of Stacker device driver
1FCh	WORD	Stacker volume number
1FEh	WORD	???
----------25----ALFF-------------------------
INT 25 - PC-CACHE.SYS - INSTALLATION CHECK
	AL = FFh
	SI = 4358h
Return: SI = 6378h if installed
	    CX = segment of device driver PC-CACHE.SYS
	    DX = version (major in DH, minor in DL)
Note:	PC-CACHE.SYS is a small device driver used by PC-Cache v5.x to obtain
	  access to certain disk drivers for devices such as Bernoulli drives
SeeAlso: INT 13/AH=A0h
----------26---------------------------------
INT 26 - DOS 1+ - ABSOLUTE DISK WRITE (except partitions > 32M)
	AL = drive number (00h = A:, 01h = B:, etc)
	CX = number of sectors to write
	DX = starting logical sector number (0000h - highest sector on drive) 
	DS:BX -> data to write
Return: CF clear if successful
	CF set on error
	    AH = status
		 80h device failed to respond (timeout)
		 40h seek operation failed
		 20h controller failed
		 10h data error (bad CRC)
		 08h DMA failure
		 04h requested sector not found
		 03h write-protected disk (INT 26 only)
		 02h bad address mark
		 01h bad command
	    AL = error code (same as passed to INT 24 in DI)
	may destroy all other registers except segment registers
Notes:	original flags are left on stack, and must be popped by caller
	this call bypasses the DOS filesystem
BUG:	DOS 3.1 through 3.3 set the word at ES:[BP+1Eh] to FFFFh if AL is an
	invalid drive number
SeeAlso: INT 13/AH=03h,INT 25
----------26---------------------------------
INT 26 - DOS 3.31+ - ABSOLUTE DISK WRITE (>32M hard-disk partition)
	AL = drive number (0=A, 1=B, etc)
	CX = FFFFh
	DS:BX -> disk write packet (see below)
Return: same as above
Notes:	partition is potentially >32M (and requires this form of the call) if
	  bit 1 of device attribute word in device driver is set
	original flags are left on stack, and must be removed by caller
	this call bypasses the DOS filesystem
SeeAlso: INT 13/AH=03h,INT 25

Format of disk write packet:
Offset	Size	Description
 00h	DWORD	sector number
 04h	WORD	number of sectors to read
 06h	DWORD	transfer address
----------27---------------------------------
INT 27 - DOS 1+ - TERMINATE AND STAY RESIDENT
	DX = number of bytes to keep resident (max FFF0h)
	CS = segment of PSP
Return: never
Notes:	this is an obsolete call
	INT 22, INT 23, and INT 24 are restored from the PSP
	does not close any open files
	the minimum number of bytes which will remain resident is 110h for
	  DOS 2.x and 60h for DOS 3+; there is no minimum for DOS 1.x, which
	  implements this service in COMMAND.COM rather than the DOS kernel
SeeAlso: INT 21/AH=31h
----------28---------------------------------
INT 28 - DOS 2+ - DOS IDLE INTERRUPT
   Invoked each time one of the DOS character input functions loops while
   waiting for input.  Since a DOS call is in progress even though DOS is
   actually idle during such input waits, hooking this function is necessary
   to allow a TSR to perform DOS calls while the foreground program is
   waiting for user input.  The INT 28h handler may invoke any INT 21 function
   except functions 00h through 0Ch.  Under DOS 2.x, the critical error flag
   (the byte immediately after the InDOS flag) must be set in order to call
   DOS functions 50h/51h without destroying the DOS stacks.

Notes:	calls to INT 21/AH=3Fh,40h may not use a handle which refers to CON
	at the time of the call, the InDOS flag (see INT 21/AH=34h) is normally
	  set to 01h; if larger, DOS is truly busy and should not be reentered
	the default handler is an IRET instruction
	supported in OS/2 compatibility box
SeeAlso: INT 21/AH=34h,INT 2A/AH=84h
----------29---------------------------------
INT 29 - DOS 2+ - FAST CONSOLE OUTPUT
	AL = character to display
Return: nothing
Notes:	automatically called when writing to a device with bit 4 of its device
	  driver header set (see also INT 21/AH=52h)
	COMMAND.COM v3.2 and v3.3 compare the INT 29 vector against the INT 20
	  vector and assume that ANSI.SYS is installed if the segment is larger
	the default handler under DOS 2.x and 3.x simply calls INT 10/AH=0Eh
	the default handler under DESQview 2.2 understands the <Esc>[2J
	  screen-clearing sequence, calls INT 10/AH=0Eh for all others
SeeAlso: INT 79
----------2A00-------------------------------
INT 2A - NETWORK (Microsoft, LANtastic) - INSTALLATION CHECK
	AH = 00h
Return: AH <> 00h if installed
SeeAlso: INT 5C
----------2A0000-----------------------------
INT 2A - AT&T Starlan Extended NetBIOS (var length names) - INSTALLATION CHECK
	AX = 0000h
Return: AH = DDh
SeeAlso: INT 5B
----------2A01-------------------------------
INT 2A - NETWORK (Microsoft,LANtastic) - EXECUTE NETBIOS REQUEST,NO ERROR RETRY
	AH = 01h
	ES:BX -> NCB (see INT 5C)
Return: AL = NetBIOS error code
	AH = 00h if no error
	   = 01h on error
SeeAlso: AH=04h,AX=0500h,INT 5B,INT 5C"NetBIOS"
----------2A02-------------------------------
INT 2A - NETWORK (Microsoft) - SET NET PRINTER MODE
	AH = 02h
	???
Return: ???
----------2A0300-----------------------------
INT 2A - NETWORK (Microsoft,LANtastic) - CHECK DIRECT I/O
	AX = 0300h
	DS:SI -> ASCIZ device name (may be full path or only drive specifier--
		must include the colon)
Return: CF clear if direct physical addressing (INT 13,INT 25) permissible
	CF set if access via files only
Notes:	do not use direct disk accesses if this function returns CF set or the
	  device is redirected (INT 21/AX=5F02h)
	may take some time to execute
	called by DOS kernel on INT 25 and INT 26
SeeAlso: INT 13,INT 25,INT 26,INT 21/AX=5F02h
----------2A04-------------------------------
INT 2A - NETWORK (Microsoft,LANtastic) - EXECUTE NetBIOS REQUEST
	AH = 04h
	AL = error retry
	    00h automatically retry request on errors 09h, 12h, and 21h
	    01h no retry
	ES:BX -> Network Control Block (see INT 5C"NetBIOS")
Return: AX = 0000h if successful
	AH = 01h on error
	    AL = error code
Note:	invokes either INT 5B or INT 5C as appropriate
SeeAlso: AH=01h,AX=0500h,INT 5B,INT 5C"NetBIOS"
----------2A0500-----------------------------
INT 2A - NETWORK (Microsoft,LANtastic) - GET NETWORK RESOURCE AVAILABILITY
	AX = 0500h
Return: AX reserved
	BX = number of network names available
	CX = number of network control blocks available
	DX = number of network sessions available
SeeAlso: AH=01h,AH=04h,INT 5C"NetBIOS"
----------2A06-------------------------------
INT 2A - NETBIOS, LANtastic - NETWORK PRINT-STREAM CONTROL
	AH = 06h
	AL = 01h set concatenation mode (all printer output put in one job)
	     02h set truncation mode (default)
		 printer open/close starts new print job
	     03h flush printer output and start new print job
Return: CF set on error
	    AX = error code
	CF clear if successful
Notes:	subfunction 03h is equivalent to Ctrl/Alt/keypad-*
	LANtastic v4.x no longer supports this call
SeeAlso: INT 21/AX=5D08h,INT 21/AX=5D09h,INT 2F/AX=1125h
----------2A2001-----------------------------
INT 2A - MS Networks or NETBIOS - ???
	AX = 2001h
	???
Return: ???
Note:	intercepted by DESQview 2.x
----------2A2002-----------------------------
INT 2A - NETWORK - ???
	AX = 2002h
	???
Return: ???
Note:	called by MSDOS 3.30-5.00 APPEND
----------2A2003-----------------------------
INT 2A - NETWORK - ???
	AX = 2003h
	???
Return: ???
Note:	called by MSDOS 3.30-5.00 APPEND
----------2A7802-----------------------------
INT 2A - NETWORK - PC LAN PROG v1.31+ - GET LOGGED ON USER NAME
	AX = 7802h
	ES:DI -> 8-byte buffer to be filled
Return: AL = 00h if no user logged on to Extended Services
	AL <> 00h if user logged on to Extended Services
	    buffer at ES:DI filled with name, padded to 8 chars with blanks.
----------2A80-------------------------------
INT 2A - NETWORK - BEGIN DOS CRITICAL SECTION
	AH = 80h
	AL = critical section number (00h-0Fh)
	    01h DOS kernel, SHARE.EXE
		apparently for maintaining the integrity of DOS/SHARE/NET
		  data structures
	    02h DOS kernel
		ensures that no multitasking occurs while DOS is calling an
		  installable device driver
	    05h DOS 4.x only IFSFUNC
	    06h DOS 4.x only IFSFUNC
	    08h ASSIGN.COM
	    0Ah MSCDEX
Notes:	normally hooked to avoid interrupting a critical section, rather than
	  called
	the handler should ensure that none of the critical sections are
	  reentered, usually by suspending a task which attempts to reenter
	  an active critical section
	the DOS kernel does not invoke critical sections 01h and 02h unless it
	  is patched.  DOS 3.1 through 3.31 contain a zero-terminated list of
	  words beginning at offset 02C3h in the IBMDOS segment; each word
	  contains the offset within the IBMDOS segment of a byte which must
	  be changed from C3h to 50h to enable use of critical sections.
SeeAlso: AH=81h,AH=82h,AH=87h,INT 21/AX=5D06h,INT 21/AX=5D0Bh
----------2A81-------------------------------
INT 2A - NETWORK - END DOS CRITICAL SECTION
	AH = 81h
	AL = critical section number (00h-0Fh) (see AH=80h)
Notes:	normally hooked rather than called
	the handler should reawaken any tasks which were suspended due to an
	  attempt to enter the specified critical section
SeeAlso: AH=80h,AH=82h,AH=87h
----------2A82-------------------------------
INT 2A - NETWORK - END DOS CRITICAL SECTIONS 0 THROUGH 7
	AH = 82h
Notes:	called by the INT 21h function dispatcher for function 0 and functions
	  greater than 0Ch except 59h, and on process termination
	the handler should reawaken any tasks which were suspended due to an
	  attempt to enter one of the critical sections 0 through 7
SeeAlso: AH=81h
----------2A84-------------------------------
INT 2A - Microsoft Networks - KEYBOARD BUSY LOOP
	AH = 84h
Note:	similar to DOS's INT 28h, called from inside the DOS keyboard input
	  loop to allow network to process requests
SeeAlso: INT 28
----------2A87-------------------------------
INT 2A - PRINT??? - CRITICAL SECTION
	AH = 87h
	AL = start/end
	    00h start
	    01h end
Note:	called by PRINT.COM
SeeAlso: AH=80h,AH=81h
----------2A89-------------------------------
INT 2A - Network - ???
	AH = 89h
	AL = ???  (ASSIGN uses 08h)
	???
Return: ???
----------2A90-------------------------------
INT 2A - IBM PC 3270 EMULATION PROGRAM - ???
	AH = 90h
	???
Return: ???
Note:	the LANtastic redirector and SERVER.EXE use this function with AL=01h,
	  03h-07h,0Ch-11h
----------2AC2-------------------------------
INT 2A - Network - ???
	AH = C2h
	AL = subfunction
	    07h ???
	    08h ???
	BX = 0001h
	???
Return: ???
Note:	called by DOS 3.30-5.00 APPEND
----------2AFF90-----------------------------
INT 2A - PC/TCP PREDIR.EXE - ???
	AX = FF90h
Return: AX = ???
Note:	PREDIR.EXE is the network printer redirector included as part of the
	  PC/TCP system by FTP Software, Inc.
----------2AFF91-----------------------------
INT 2A - PC/TCP PREDIR.EXE - ???
	AX = FF91h
	BX = ???
Return: AX = status???
----------2AFF92-----------------------------
INT 2A - PC/TCP PREDIR.EXE - INSTALLATION CHECK
	AX = FF92h
Return: AX = 0000h if installed
	   BX = redirected printer port (FFFFh if no printers redirected)
	   CX = version (CH = major, CL = minor)
Note:	PREDIR.EXE is the network printer redirector included as part of the
	  PC/TCP system by FTP Software, Inc.
----------2AFF93-----------------------------
INT 2A - PC/TCP PREDIR.EXE - ???
	AX = FF93h
Return: AX = ???
----------2AFF94-----------------------------
INT 2A - PC/TCP PREDIR.EXE - ???
	AX = FF94h
	BX = ???
	CX = ???
	DX = ???
Return: AX = ???
Note:	PREDIR.EXE is the network printer redirector included as part of the
	  PC/TCP system by FTP Software, Inc.
----------2AFF95-----------------------------
INT 2A - PC/TCP PREDIR.EXE - GET CONFIGURATION STRINGS
	AX = FF95h
	CX = what to get
	    0000h ??? (returned pointer to "C:\COMMAND.COM")
	    0001h spooling program
	    0002h ???
	    0003h spool file name
	    0004h swap file name
Return: AX = status
	    0000h successful
	BX:DX -> ASCIZ configuration string
----------2AFF96-----------------------------
INT 2A - PC/TCP PREDIR.EXE - SET PRINT JOB TERMINATION CONFIGURATION
	AX = FF96h
	CX = what to set
	    0000h ???
	    0001h print-on-hotkey state
	    0002h print-on-exit state
	    0003h print job timeout in clock ticks
	    0004h print-on-EOF state
	BX = new value (0000h disabled, 0001h enabled except for timeout)
Return: AX = ???
SeeAlso: AX=FF97h
Note:	PREDIR.EXE is the network printer redirector included as part of the
	  PC/TCP system by FTP Software, Inc.
----------2AFF97-----------------------------
INT 2A - PC/TCP PREDIR.EXE - GET PRINT JOB TERMINATION CONFIGURATION
	AX = FF97h
	CX = what to get
	    0000h ???
	    0001h print-on-hotkey state
	    0002h print-on-exit state
	    0003h print job timeout in clock ticks
	    0004h print-on-EOF state
Return: AX = status
	    0000h successful
	BX = old value (0000h disabled, 0001 enabled except for timeout)
SeeAlso: AX=FF96h
----------2B---------------------------------
INT 2B - DOS 2+ - RESERVED
Note:	this vector is not used in DOS versions <= 5.00, and points at an IRET
----------2C---------------------------------
INT 2C - DOS 2+ - RESERVED
Note:	this vector is not used in DOS versions <= 5.00, and points at an IRET
----------2C---------------------------------
INT 2C - STARLITE architecture - KERNEL API
Note:	STARLITE is an architecture by General Software for a series of MS-DOS
	  compatible operating systems (OEM DOS, NETWORK DOS, and SMP DOS) to
	  be released in 1991.	The interrupt number is subject to change
	  before the actual release.
----------2D---------------------------------
INT 2D - DOS 2+ - RESERVED
Note:	this vector is not used in DOS versions <= 5.00, and points at an IRET
----------2D---------------------------------
INT 2D - ALTERNATE MULTIPLEX INTERRUPT SPECIFICATION (AMIS) [proposal v3.4]
	AH = multiplex number
	AL = function
	    00h installation check
		Return: AL = FFh if multiplex number in use
			    CX = version number (CH = major, CL = minor)
			    DX:DI -> signature string (see below) identifying
				    the program using the multiplex number
			AL = 00h if free
	    01h get entry point
		Return: AL = FFh if entry point supported
			    DX:BX -> entry point for bypassing interrupt chain
			AL = 00h if all API calls via INT 2D
	    02h uninstall
	    	DX:BX = return address for successful uninstall (may be
			ignored by TSR)
		Return: AL = status
			    00h not implemented
			    01h unsuccessful
			    02h can not uninstall yet, will do so when able
			    03h safe to remove, but no resident uninstaller
			    	(TSR still enabled)
			    	BX = segment of memory block with resident code
			    04h safe to remove, but no resident uninstaller
			    	(TSR now disabled)
			    	BX = segment of memory block with resident code
			    05h not safe to remove now, try again later
			    FFh successful
			return at DX:BX with AX destroyed if successful and
			  TSR honors specific return address
	    03h request pop-up
		Return: AL = status
			    00h not implemented or TSR is not a pop-up
			    01h can not pop up at this time, try again later
			    02h can not pop up yet, will do so when able
			    03h already popped up
			    04h unable to pop up, user intervention required
			    	BX = standard reason code
				    0000h unknown failure 
				    0001h interrupt chain passes through memory
				    	  which must be swapped out to pop up
				    0002h swap-in failed
				CX = application's reason code if nonzero
			    FFh TSR popped up and was exited by user
				BX = return value
				    0000h no return value
				    0001h TSR unloaded
				    0002h-00FFh reserved
				    0100h-FFFFh application-dependent
	    04h determine chained interrupts
	    	BL = interrupt number (except 2Dh)
		Return: AL = status
			    00h not implemented
			    01h unable to determine
			    02h interrupt hooked
			    03h interrupt hooked, address returned
			    	DX:BX -> TSR's interrupt BL handler
			    04h list of hooked interrupts returned
			    	DX:BX -> interrupt hook list (see below)
			    FFh interrupt not hooked
		Notes:	since INT 2D is known to be hooked, the resident code
			  need not test for BL=2Dh (to minimize its size), and
			  the return value is therefore undefined in that case.
			BL is ignored if the TSR returns AL=04h; in that case,
			  the caller needs to scan the return list rather than
			  making additional calls to this function.  If the
			  return is not 00h or 04h, then the caller must cycle
			  through the remaining interrupt numbers it wishes to
			  check.
			return values 01h thru 03h are disparaged and may be
			  removed from future versions of the specification;
			  they are included for compatibility with version 3.3
	    05h-0Fh reserved for future enhancements
		Return: AL = 00h (not implemented)
	    other  application-dependent
Notes:	programs should not use fixed multiplex numbers; rather, a program
	  should scan all multiplex numbers from 00h to FFh, remembering the
	  first unused multiplex in case the program is not yet installed.
	  For multiplex numbers which are in use, the program should compare
	  the first 16 bytes of the signature string to determine whether it
	  is already installed on that multiplex number.  If not previously
	  installed, it should use the first free multiplex number.
	functions other than 00h are not valid unless a program is installed
	  on the selected multiplex number
	to be considered fully compliant with version 3.4 of the specification,
	  programs must implement at least functions 00h, 02h (no resident
	  uninstall code required), and 04h (return value 04h).  The absolute
	  minimum implementation has an overhead of 64 bytes plus 22 bytes per
	  hooked interrupt (for the interrupt sharing protocol header and hook
	  list entry).
	the signature string and description may be used by memory mappers
	  to display the installed programs
	users of this proposal should adhere to the IBM interrupt sharing
	  protocol (see below), which will permit removal of TSRs in
	  arbitrary order and interrupt handler reordering.  All TSRs
	  following this proposal should be removable, though they need not
	  keep the code for removing themselves resident; it is acceptable
	  for a separate program to perform the removal.
	A sample implementation including example TSRs and utility programs
	  may be found in a separate package distributed as AMISLnnn.ZIP
	  (AMISL081.ZIP as of this writing).
	Please let me know if you choose to follow this proposal.  A list of
	  the private API calls you use would be appreciated, as well.
SeeAlso: INT 2F

Format of signature string:
Offset	Size	Description
 00h  8 BYTEs	blank-padded manufacturer's name (possibly abbreviated)
 08h  8 BYTEs	blank-padded product name
 10h 64 BYTEs	ASCIZ product description (optional, may be a single 00h)
Note:	it is not necessary to reserve a full 64 bytes for the description,
	  just enough to store the actual ASCIZ string

Format of interrupt hook list [array]:
Offset	Size	Description
 00h	BYTE	interrupt number (last entry in array is 2Dh)
 01h	WORD	offset within hook list's segment of the interrupt handler
 		this will point at the initial short jump of the interrupt
		sharing protocol header (see below)

Format of interrupt sharing protocol interrupt handler entry point:
Offset	Size	Description
 00h  2 BYTEs	short jump to actual start of interrupt handler, immediately
		following this data block (EBh 10h)
 02h	DWORD	address of next handler in chain
 06h	WORD	signature 424Bh
 08h	BYTE	EOI flag
		00h software interrupt or secondary hardware interrupt handler
		80h primary hardware interrupt handler (will issue EOI)
 09h  2 BYTEs	short jump to hardware reset routine
		must point at a valid FAR procedure (may be just RETF)
 0Bh  7 BYTEs	reserved (0)

Signatures known to be in use:
 'Crynwr  ' 'SPELLER '  TSR spelling-checker
 'heathh  ' 'Monitor '
 'Ralf B  ' 'FASTMOUS'  example TSR included with sample AMIS library code
 'Ralf B  ' 'NOLPT n '  example TSR -- turn LPTn into bit-bucket
 'Ralf B  ' 'NOTE    '  example TSR -- popup note-taker
 'Ralf B  ' 'SWITCHAR'  example TSR -- add switchar() support removed from DOS5
 'Ralf B  ' 'VGABLANK'  example TSR -- VGA-only screen blanker
 'TifaWARE' 'EATMEM  '	George A. Theall's public domain memory restrictor for
 			testing programs (v1.1+)
	    'RECALL  '	public domain commandline editor and history (v1.2+)
----------2E---------------------------------
INT 2E - DOS 2+ - PASS COMMAND TO COMMAND INTERPRETER FOR EXECUTION
	DS:SI -> commandline to execute (see below)
Return: all registers except CS:IP destroyed
	AX = status (4DOS v4.0)
	   0000h successful
	   FFFFh error before processing command (not enough memory, etc)
	   other error number returned by command
Notes:	this call allows execution of arbitrary commands (including COMMAND.COM
	  internal commands) without loading another copy of COMMAND.COM
	if COMMAND.COM is the user's command interpreter, the primary copy
	  executes the command; this allows the master environment to be
	  modified by issuing a "SET" command, but changes in the master
	  environment will not become effective until all programs descended
	  from the primary COMMAND.COM terminate
	since COMMAND.COM processes the string as if typed from the keyboard,
	  the transient portion needs to be present, and the calling program
	  must ensure that sufficient memory to load the transient portion can
	  be allocated by DOS if necessary
	results are unpredictable if invoked by a program run from a batch file
	  because this call is not reentrant and COMMAND.COM uses the same
	  internal variables when processing a batch file
	hooked but ignored by 4DOS v3.0 COMMAND.COM replacement unless SHELL2E
	  has been loaded

Format of commandline:
Offset	Size	Description
 00h	BYTE	length of command string, not counting trailing CR
 01h	var	command string
  N	BYTE	0Dh (CR)
----------2E----BXE22E-----------------------
INT 2E - 4DOS v2.x-3.03 SHELL2E.COM - UNINSTALL
	BX = E22Eh
	DS:SI -> zero byte
Return: if successful, SHELL2E terminates itself with INT 21/AH=4Ch
----------2F---------------------------------
INT 2F - Multiplex - NOTES
	AH = identifier of program which is to handle the interrupt
	   00h-7Fh reserved for DOS
	   C0h-FFh reserved for applications
	AL is the function code
   This is a general mechanism for verifying the presence of a TSR and 
   communicating with it.  When searching for a free identifier code for AH
   using the installation check (AL=00h), the calling program should set
   BX/CX/DX to 0000h and must not depend on any registers other than CS:IP
   and SS:SP to be valid on return, since numerous programs now use additional
   registers on input and/or output for the installation check.
Note:	Since the multiplex chain is growing so long, and beginning to
	  experience multiplex number collisions, I am proposing an alternate
	  multiplex interrupt on INT 2D.  If you decide to use the alternate
	  multiplex, please let me know.
SeeAlso: INT 2D
----------2F---------------------------------
INT 2F - BMB Compuscience Canada Utilities Interface
	AH = xx (dynamically assigned based upon a search for a multiplex
		 number which doesn't answer installed)
	AL = 00h installation check
	ES:DI = EBEBh:BEBEh
Return: AL = 00h not installed
	     01h not installed, not OK to install
	     FFh installed; if ES:DI was EBEBh:BEBEh on entry, ES:DI will point
		 to a string of the form 'MMMMPPPPPPPPvNNNN' where MMMM is a
		 short form of the manufacturer's name, PPPPPPPP is a product
		 name and NNNN is the product's version number
----------2F---------------------------------
INT 2F - Ross Wentworth's Turbo Pascal POPUP LIBRARY
	AH = programmer-selected multiplex number
	AL = function
	    00h installation check
		Return: AL = FFh if installed
	    01h get TSR interrupt vectors
		Return: DX:AX -> vector table (see below)
	    02h get TSR code segment
		Return: AX = code segment for all interrupt handlers
	    03h call user exit routine and release TSR's memory
	    04h get signature string
		Return: DX:AX -> counted string containing signature
	    05h get TSR's INT 2F handler
		Return: DX:AX -> INT 2F handler
	    06h enable/disable TSR
		BL = new state (00h disabled, 01h enabled)
	    07h activate TSR (popup if not disabled)
	    08h get hotkeys
		BL = which hotkey (00h = hotkey 1, 01h = hotkey 2)
		Return: AX = hotkey (AH = keyflags, AL = scancode)
	    09h set hotkey
		BL = which hotkey (00h = hotkey 1, 01h = hotkey 2)
		CX = new hotkey (CH = keyflags, CL = scancode)
	    0Ah-1Fh reserved

Format of vector table entry:
Offset	Size	Description
 00h	BYTE	vector number (00h = end of table)
 01h	DWORD	original vector
 05h	WORD	offset of interrupt handler in TSR's code segment
----------2F---------------------------------
INT 2F - CiriSOFT Spanish University of Valladolid TSR's Interface
	AH = xx (dynamically assigned based upon a search for a multiplex
		 number from C0h to FFh which doesn't answer installed)
	AL = 00h installation check
	ES:DI = 1492h:1992h
Return: AL = 00h not installed
	     01h not installed, not OK to install
	     FFh installed; and if ES:DI was 1492h:1992h on entry, ES:DI will
		 point to author_name_ver table (see below)
	AH = FFh
Note:	this interface permits advanced communication with TSRs: it is possible
	  to make a generic unistall utility, advanced TSR relocator programs
	  in order to fit fragmented memory areas, etc.
See also: INT 2D"AMIS",INT 2F"Compuscience"

Format of author_name_ver table:
Offset	Size	Description
 -16	WORD	segment in which really begins the TSR code (CS in programs
		with PSP, XMS upper memory segment if installed as UMB...)
 -14	WORD	offset in which really begins the TSR code (frecuently 100h
		in *.COM programs and 0 in upper memory TSR's).
 -12	WORD	memory used by TSR (in paragraphs). Knowing the memory area
		used by TSR is possible to determine if hooked vectors are
		still pointing it (and if it is safe the unistall process).
 -10	BYTE	characteristics byte
		bits 0-2: 000 normal program (with PSP)
			  001 upper XMS memory block (needed HIMEM.SYS function
			      to free memory when unistalling)
			  010 device driver (*.SYS)
			  011 device driver in EXE format
			  1xx others (reserved)
		bits 3-6 reserved
		bit 7 set if extra_table defined and supported
 -9	BYTE	number of multiplex entry used (redefinition available). Note
		that the TSR must be use THIS variable in it's INT 2Fh handler.
 -8	WORD	offset to vector_area table (see bellow)
 -6	WORD	offset to extra_area table (see bit 7 in offset -10 and bellow)
 -4   4 BYTEs	"*##*"	(to insure that the TSR verify this agreement)
 00h	var	"AUTHOR:PROGRAM_NAME:VERSION",0	 (variable length, this area
		is used in order to determine if the TSR is already resident
		and it's version code; the ':' char is used as delimiter)

Format of vector_area table:
Offset	Size	Description
 -1	BYTE	number of vectors intercepted by TSR
 00h	BYTE	first vector number
 01h	DWORD	first vector pointer before installing the TSR
 05h	BYTE	second vector number
 06h	DWORD	second vector pointer before installing the TSR
  .	  .	(and so on) Note that the TSR must be use THIS variables to
		invoke previous interrupt handler routines.

Format of extra_area table (needed only to improve relocation feature):
Offset	Size	Description
 00h	WORD	offset to external_ctrl table (0 if not supported)
 02h	WORD	reserved for future use (0)

Format of external_ctrl table:
Offset	Size	Description
 00h	BYTE	bit 0: TSR is relocatable (no absolute segment references)
 01h	WORD	offset to a variable which can activate/inhibit the TSR
 ---And if bit 0 in offset 00h is off:
 03h	DWORD	pointer to ASCIIZ with pathname to executable file which
		supports /SR parameter (silent installation & inhibit)
 07h	DWORD	pointer to first variable to initialize on the copy reloaded
		from the previous TSR still resident
 0Bh	DWORD	pointer to last variable (all variables packed in one block)
----------2F00-------------------------------
INT 2F U - DOS 2.x PRINT.COM - ???
	AH = 00h
	???
Return: ???
Notes:	DOS 2.x PRINT.COM does not chain to previous INT 2F handler
	values in AH other than 00h or 01h cause PRINT to return the number of
	  files in the queue in AH
SeeAlso: AH=01h
----------2F0080-----------------------------
INT 2F - DOS 3.1+ PRINT.COM - GIVE PRINT A TIME SLICE
	AX = 0080h
Return: after PRINT executes
----------2F01-------------------------------
INT 2F U - DOS 2.x PRINT.COM - ???
	AH = 01h
	???
Return: ???
Notes:	DOS 2.x PRINT.COM does not chain to previous INT 2F handler
	values in AH other than 00h or 01h cause PRINT to return the number of
	  files in the queue in AH
SeeAlso: AH=00h
----------2F0100-----------------------------
INT 2F - DOS 3+ PRINT.COM - INSTALLATION CHECK
	AX = 0100h
Return: AL = status
	    00h not installed
	    01h not installed, but not OK to install
	    FFh installed
SeeAlso: AX=0101h
----------2F0101-----------------------------
INT 2F - DOS 3+ PRINT.COM - SUBMIT FILE FOR PRINTING
	AX = 0101h
	DS:DX -> submit packet (see below)
Return: CF clear if successful
	    AL = 01h added to queue
		 9Eh now printing
	CF set on error
	    AX = error code (see also INT 21/AH=59h)
		01h invalid function
		02h file not found
		03h path not found
		04h out of file handles
		05h access denied
		08h print queue full
		09h spooler busy
		0Ch name too long
		0Fh invalid drive
SeeAlso: AX=0102h

Format of submit packet:
Offset	Size	Description
 00h	BYTE	level (must be 00h)
 01h	DWORD	pointer to ASCIZ filename (no wildcards)
----------2F0102-----------------------------
INT 2F - DOS 3+ PRINT.COM - REMOVE FILE FROM PRINT QUEUE
	AX = 0102h
	DS:DX -> ASCIZ filename (wildcards allowed)
Return: CF clear if successful
	CF set on error
	    AX = error code (see AX=0101h)
SeeAlso: AX=0101h,AX=0103h
----------2F0103-----------------------------
INT 2F - DOS 3+ PRINT.COM - CANCEL ALL FILES IN PRINT QUEUE
	AX = 0103h
Return: CF clear if successful
	CF set on error
	    AX = error code (see AX=0101h)
SeeAlso: AX=0102h
----------2F0104-----------------------------
INT 2F - DOS 3+ PRINT.COM - FREEZE PRINT QUEUE TO READ JOB STATUS
	AX = 0104h
Return: CF clear if successful
	    DX = error count
	    DS:SI -> print queue
	CF set on error
	    AX = error code (see AX=0101h)
Notes:	the print queue is an array of 64-byte ASCIZ filenames terminated by
	  an empty filename; the first name is the file currently being printed
	printing is stopped until AX=0105h is called to prevent the queue
	  from changing while the filenames are being read
SeeAlso: AX=0101h,AX=0105h
----------2F0105-----------------------------
INT 2F - DOS 3+ PRINT.COM - RESTART PRINT QUEUE AFTER STATUS READ
	AX = 0105h
Return: CF clear if successful
	CF set on error
	    AX = error code (see AX=0101h)
SeeAlso: AX=0104h
----------2F0106-----------------------------
INT 2F - DOS 3.3+ PRINT.COM - GET PRINTER DEVICE
	AX = 0106h
Return: CF set if files in print queue
	    AX = error code 0008h (queue full)
	    DS:SI -> device driver header
	CF clear if print queue empty
	    AX = 0000h
Note:	documented for DOS 5+, but not documented for prior versions
SeeAlso: AX=0104h
----------2F0200-----------------------------
INT 2F U - PC LAN PROGRAM REDIR/REDIRIFS internal - INSTALLATION CHECK
	AX = 0200h
Return: AL = FFh if installed
----------2F0201-----------------------------
INT 2F U - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0201h
Return: nothing???
Notes:	called by DOS 3.3+ PRINT.COM
	AX=0202h appears to be the opposite function
SeeAlso: AX=0202h
----------2F0202-----------------------------
INT 2F U - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0202h
	???
Return: nothing???
Note:	called by DOS 3.3+ PRINT.COM
SeeAlso: AX=0201h
----------2F0203-----------------------------
INT 2F U - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0203h
Return: nothing???
Notes:	called by DOS 3.3+ PRINT.COM
	AX=0204h appears to be the opposite function
SeeAlso: AX=0204h
----------2F0204-----------------------------
INT 2F U - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0204h
	???
Return: nothing???
Note:	called by DOS 3.3 PRINT.COM
----------2F---------------------------------
INT 2F U - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 02xxh
	???
Return: ???
----------2F0500-----------------------------
INT 2F U - DOS 3+ CRITICAL ERROR HANDLER - INSTALLATION CHECK
	AX = 0500h
Return: AL = 00h not installed, OK to install
	     01h not installed, can't install
	     FFh installed
Note:	this set of functions allows a user program to partially or completely
	  override the default critical error handler's message in COMMAND.COM
SeeAlso: AH=05h,INT 24
----------2F05-------------------------------
INT 2F U - DOS 3+ CRITICAL ERROR HANDLER - EXPAND ERROR INTO STRING
	AH = 05h
---DOS 3.x---
	AL = extended error code (not zero)
---DOS 4+ ---
	AL = error type
	    01h DOS extended error code
	    02h parameter error
	BX = error code
Return: CF clear if successful
	    ES:DI -> ASCIZ error message (read-only)
	    AL = ???
	CF set if error code can't be converted to string
Notes:	called at start of COMMAND.COM's default critical error handler if 
	  installed by a user program, allowing partial or complete overriding
	  of the default error message
	subfunction 02h called by many DOS 4 external programs
SeeAlso: AX=122Eh,INT 24
----------2F0600-----------------------------
INT 2F - DOS v3.0+ ASSIGN - INSTALLATION CHECK
	AX = 0600h
Return: AL = status
	    00h not installed
	    01h not installed, but not OK to install
	    FFh installed
Note:	ASSIGN is not a TSR in DR-DOS 5.0; it is internally replaced by SUBST
	  (see INT 21/AX=2152h)
SeeAlso: AX=0601h,INT 21/AX=2152h
----------2F0601-----------------------------
INT 2F U - DOS v3.0+ ASSIGN - GET DRIVE ASSIGNMENT TABLE
	AX = 0601h
Return: ES = segment of ASSIGN work area and assignment table
Note:	under DOS 3+, the 26 bytes starting at ES:0103h specify which drive
	  each of A: to Z: is mapped to.  Initially set to 01h 02h 03h....
SeeAlso: AX=0600h
----------2F0800-----------------------------
INT 2F U - DRIVER.SYS support - INSTALLATION CHECK
	AX = 0800h
Return:	AL = 00h not installed, OK to install
	     01h not installed, not OK to install
	     FFh installed
Note:	supported by DR-DOS 5.0
----------2F0801-----------------------------
INT 2F U - DRIVER.SYS support - ADD NEW BLOCK DEVICE
	AX = 0801h
	DS:DI -> drive data table (see AX=0803h)
Notes:	moves down internal list of drive data tables, copying and modifying
	  the drive description flags word for tables referencing same physical
	  drive
	data table appended to chain of tables
	supported by DR-DOS 5.0
SeeAlso: AX=0803h
----------2F0802-----------------------------
INT 2F U - DRIVER.SYS support - EXECUTE DEVICE DRIVER REQUEST
	AX = 0802h
	ES:BX -> device driver request header (see below)
Return: request header updated as per requested operation
Notes:	supported by DR-DOS 5.0
	DOS 3.2 executes this function on any AL value from 02h through F7h

Format of device driver request header:
Offset	Size	Description
 00h	BYTE	length of request header
 01h	BYTE	subunit within device driver
 02h	BYTE	command code (see below)
 03h	WORD	status (filled in by device driver)
		bit 15: error
		bits 14-11: reserved
		bit 10: ??? set by DOS kernel on entry to some driver calls
		bit 9: busy
		bit 8: done
		bits 7-0: error code if bit 15 set (see below)
---DOS---
 05h  8 BYTEs	reserved (unused in DOS 2.x and 3.x)
---STARLITE architecture---
 05h	DWORD	pointer to next request header
 09h  4 BYTEs	reserved
---command code 00h---
 0Dh	BYTE	number of units (set by driver)
 0Eh	DWORD	address of first free byte following driver (set by driver)
 12h	DWORD	pointer to BPB array (set by block drivers only)
 16h	BYTE	(DOS 3+) drive number for first unit of block driver (0=A)
---command code 01h---
 0Dh	BYTE	media descriptor
 0Eh	BYTE	returned status
		00h don't know
		01h media has not changed
		FFh media has been changed
 0Fh	DWORD	(DOS 3+) pointer to previous volume ID if OPEN/CLOSE/RM bit in
		  device header set and disk changed (set by driver)
---command code 02h---
 0Dh	BYTE	media descriptor
 0Eh	DWORD	transfer address
		-> scratch sector if NON-IBM FORMAT bit in device header set
		-> first FAT sector otherwise
 12h	DWORD	pointer to BPB (set by driver)
---command codes 03h,0Ch--- (see also INT 21/AX=4402h,INT 21/AX=4403h)
 0Dh	BYTE	media descriptor (block devices only)
 0Eh	DWORD	transfer address
 12h	WORD	byte count (character devices) or sector count (block devices)
 14h	WORD	starting sector number (block devices only)
 16h	DWORD	(DOS 3+) pointer to volume label if error 0Fh (set by driver)
---command codes 04h,08h,09h---
 0Dh	BYTE	media descriptor (block devices only)
 0Eh	DWORD	transfer address
 12h	WORD	byte count (character devices) or sector count (block devices)
 14h	WORD	starting sector number (block devices only)
 16h	DWORD	(DOS 3+) pointer to volume ID if error 0Fh returned
 1Ah	DWORD	(DOS 4+) 32-bit starting sector number (block devices with
		device attribute word bit 1 set only) (see INT 21/AH=52h)
---command code 05h---
 0Dh	BYTE	byte read from device if BUSY bit clear on return
---command codes 06h,07h,0Ah,0Bh,0Dh,0Eh,0Fh,85h,88h---
 no further fields
---command code 10h---
 0Dh	BYTE	unused
 0Eh	DWORD	transfer address
 12h	WORD	byte count
---command codes 13h,19h---
 0Dh	BYTE	category code
		00h unknown
		01h COMn:
		03h CON
		05h LPTn:
		08h disk
		9Eh (STARLITE) Media Access Control driver
 0Eh	BYTE	function code
		00h (STARLITE) MAC Bind request
 0Fh	WORD	copy of DS at time of IOCTL call (apparently unused in DOS 3.3)
 11h	WORD	offset of device driver header
 13h	DWORD	pointer to parameter block from INT 21/AX=440Ch or AX=440Dh
---command codes 80h,82h---
 0Dh	BYTE	addressing mode
		00h HSG (default)
		01h Phillips/Sony Red Book
 0Eh	DWORD	transfer address (ignored for command 82h)
 12h	WORD	number of sectors to read
		(if 0 for command 82h, request is an advisory seek)
 14h	DWORD	starting sector number
		logical sector number in HSG mode
		frame/second/minute/unused in Red Book mode
		(HSG sector = minute * 4500 + second * 75 + frame - 150)
 18h	BYTE	data read mode
		00h cooked (2048 bytes per frame)
		01h raw (2352 bytes per frame, including EDC/ECC)
 19h	BYTE	interleave size (number of sectors stored consecutively)
 1Ah	BYTE	interleave skip factor (# sectors between consec portions)
---command code 83h---
 0Dh	BYTE	addressing mode (see above)
 0Eh	DWORD	transfer address (ignored)
 12h	WORD	number of sectors to read (ignored)
 14h	DWORD	starting sector number (see also above)
---command code 84h---
 0Dh	BYTE	addressing mode (see above)
 0Eh	DWORD	starting sector number (see also above)
 12h	DWORD	number of sectors to play
---command codes 86h,87h---
 0Dh	BYTE	addressing mode (see above)
 0Eh	DWORD	transfer address (ignored in write mode 0)
 12h	WORD	number of sectors to write
 14h	DWORD	starting sector number (see also above)
 18h	BYTE	write mode
		00h mode 0 (write all zeros)
		01h mode 1 (default) (2048 bytes per sector)
		02h mode 2 form 1 (2048 bytes per sector)
		03h mode 2 form 2 (2336 bytes per sector)
 19h	BYTE	interleave size (number of sectors stored consecutively)
 1Ah	BYTE	interleave skip factor (# sectors between consec portions)

Values for command code:
	00h INIT
	01h MEDIA CHECK (block devices)
	02h BUILD BPB (block devices)
	03h IOCTL INPUT
	04h INPUT
	05h NONDESTRUCTIVE INPUT, NO WAIT (character devices)
	06h INPUT STATUS (character devices)
	07h INPUT FLUSH (character devices)
	08h OUTPUT
	09h OUTPUT WITH VERIFY
	0Ah OUTPUT STATUS (character devices)
	0Bh OUTPUT FLUSH (character devices)
	0Ch IOCTL OUTPUT
	0Dh (DOS 3+) DEVICE OPEN
	0Eh (DOS 3+) DEVICE CLOSE
	0Fh (DOS 3+) REMOVABLE MEDIA (block devices)
	10h (DOS 3+) OUTPUT UNTIL BUSY (character devices)
	11h unused
	12h unused
	13h (DOS 3.2+) GENERIC IOCTL
	14h unused
	15h unused
	16h unused
	17h (DOS 3.2+) GET LOGICAL DEVICE
	18h (DOS 3.2+) SET LOGICAL DEVICE
	19h (DOS 5.0+) CHECK GENERIC IOCTL SUPPORT
	80h (CD-ROM) READ LONG
	81h (CD-ROM) reserved
	82h (CD-ROM) READ LONG PREFETCH
	83h (CD-ROM) SEEK
	84h (CD-ROM) PLAY AUDIO
	85h (CD-ROM) STOP AUDIO
	86h (CD-ROM) WRITE LONG
	87h (CD-ROM) WRITE LONG VERIFY
	88h (CD-ROM) RESUME AUDIO

Values for error code:
	00h write-protect violation
	01h unknown unit
	02h drive not ready
	03h unknown command
	04h CRC error
	05h bad drive request structure length
	06h seek error
	07h unknown media
	08h sector not found
	09h printer out of paper
	0Ah write fault
	0Bh read fault
	0Ch general failure
	0Dh reserved
	0Eh (CD-ROM) media unavailable
	0Fh invalid disk change
----------2F0803-----------------------------
INT 2F U - DOS 4+ DRIVER.SYS support - GET DRIVE DATA TABLE LIST
	AX = 0803h
Return: DS:DI -> first drive data table in list
Note:	not available under DR-DOS 5.0
SeeAlso: AX=0801h

Format of DOS 3.30 drive data table:
Offset	Size	Description
 00h	DWORD	pointer to next table
 04h	BYTE	physical unit number (for INT 13)
 05h	BYTE	logical drive number
 06h 19 BYTEs	BIOS Parameter Block (see also INT 21/AH=53h)
		Offset	Size	Description
		 00h	WORD	bytes per sector
		 02h	BYTE	sectors per cluster, FFh if unknown
		 03h	WORD	number of reserved sectors
		 05h	BYTE	number of FATs
		 06h	WORD	number of root dir entries
		 08h	WORD	total sectors
		 0Ah	BYTE	media descriptor, 00h if unknown
		 0Bh	WORD	sectors per FAT
		 0Dh	WORD	sectors per track
		 0Fh	WORD	number of heads
		 11h	WORD	number of hidden sectors
 19h	BYTE	flags
		bit 6: 16-bit FAT instead of 12-bit FAT
 1Ah	WORD	number of DEVICE OPEN calls without corresponding DEVICE CLOSE
 1Ch 11 BYTEs	volume label or "NO NAME    " if none (always "NO NAME" for
		fixed media)
 27h	BYTE	terminating null for volume label???
 28h	BYTE	device type (see INT 21/AX=440Dh)
 29h	WORD	bit flags describing drive
		bit 0: fixed media
		bit 1: door lock supported
		bit 2: ??? (used in determining BPB to set for INT 21/AX=440Dh)
		bit 3: all sectors in a track are the same size
		bit 4: physical drive has multiple logical units
		bit 5: current logical drive for physical drive
		bit 6: ???
		bit 7: ???
		bit 8: ??? (related to disk change detection)
 2Bh	WORD	number of cylinders
 2Dh 19 BYTEs	BIOS Parameter Block for highest capacity supported
 40h  3 BYTEs	???
 43h  9 BYTEs	filesystem type???, default = "NO NAME	"
		(apparently only MSDOS 3.30 fixed media, nulls for removable
		media and PCDOS 3.30)
 4Ch	BYTE	least-significant byte of last-accessed cylinder number
---removable media---
 4Dh	DWORD	time of last access in clock ticks (FFFFFFFFh if never)
---fixed media---
 4Dh	WORD	partition (FFFFh = primary, 0001h = extended)
 4Fh	WORD	absolute cylinder number of partition's start on physical
		drive (always FFFFh if primary partition)

Format of COMPAQ DOS 3.31 drive data table:
Offset	Size	Description
 00h	DWORD	pointer to next table
 04h	BYTE	physical unit number (for INT 13)
 05h	BYTE	logical drive number
 06h 25 BYTEs	BIOS Parameter Block (see DOS 4.01 drive data table below)
 1Fh  6 BYTEs	??? apparently always zeros
 25h	BYTE	flags
		bit 6: 16-bit FAT instead of 12-bit FAT
		    5: large volume???
 26h	WORD	device-open count???
 28h 11 BYTEs	volume label or "NO NAME    " if none (always "NO NAME" for
		fixed media)
 33h	BYTE	terminating null for volume label
 34h	BYTE	device type (see INT 21/AX=440Dh)
 35h	WORD	bit flags describing drive
 37h	WORD	number of cylinders
 39h 25 BYTEs	BIOS parameter block for highest capacity drive supports
 52h  6 BYTEs	??? apparently always zeros
 58h	BYTE	least-significant byte of last-accessed cylinder number
---removable media---
 59h	DWORD	time of last access in clock ticks (FFFFFFFFh if never)
---fixed media---
 59h	WORD	partition (FFFFh = primary, 0001h = extended)
 5Bh	WORD	absolute cylinder number of partition's start on physical
		drive (always FFFFh if primary partition)

Format of DOS 4.0-5.0 drive data table:
Offset	Size	Description
 00h	DWORD	pointer to next table
 04h	BYTE	physical unit number (for INT 13)
 05h	BYTE	logical drive number
 06h 25 BYTEs	BIOS Parameter Block (see also INT 21/AH=53h)
		Offset	Size	Description
		 00h	WORD	bytes per sector
		 02h	BYTE	sectors per cluster, FFh if unknown
		 03h	WORD	number of reserved sectors
		 05h	BYTE	number of FATs
		 06h	WORD	number of root dir entries
		 08h	WORD	total sectors (see offset 15h if zero)
		 0Ah	BYTE	media descriptor, 00h if unknown
		 0Bh	WORD	sectors per FAT
		 0Dh	WORD	sectors per track
		 0Fh	WORD	number of heads
		 11h	DWORD	number of hidden sectors
		 15h	DWORD	total sectors if WORD at 08h is zero
 1Fh	BYTE	flags
		bit 6: 16-bit FAT instead of 12-bit
 20h  2 BYTEs	???
 22h	BYTE	device type (see INT 21/AX=440Dh)
 23h	WORD	bit flags describing drive
		bit 0: fixed media
		bit 1: door lock supported
		bit 2: ???
		bit 3: all sectors in a track are the same size
		bit 4: physical drive has multiple logical units
		bit 5: current logical drive for physical drive
		bit 6: ???
		bit 7: ???
		bit 8: ???
 25h	WORD	number of cylinders
 27h 25 BYTEs	BIOS Parameter Block for highest capacity supported
 40h  7 BYTEs	???
---removable media---
 47h	DWORD	time of last access in clock ticks (FFFFFFFFh if never)
---fixed media, DOS 4.x---
 47h	WORD	partition (FFFFh = primary, 0001h = extended)
 49h	WORD	absolute cylinder number of partition's start on phys drive
		(FFFFh if primary partition)
---fixed media, DOS 5.0---
 47h	WORD	??? apparently always 0001h
 49h	WORD	absolute cylinder number of partition's start on phys drive
------
 4Bh 11 BYTEs	volume label or "NO NAME    " if none (apparently taken from
		extended boot record rather than root directory)
 56h	BYTE	terminating null for volume label???
 57h	DWORD	serial number
 5Bh  8 BYTEs	filesystem type ("FAT12	  " or "FAT16	")
 63h	BYTE	terminating null for filesystem type???
----------2F0C00-----------------------------
INT 2F - AD-DOS - INSTALLATION CHECK
	AX = 0C00h
Return: AL = FF if installed
	    BX = 4144H	('AD')
	    CX = 2D44H	('-D')
	    DX = 4F53H	('OS')
Notes:	AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
	AH=0Ch is the default multiplex number
SeeAlso: AX=0C01h
----------2F0C01ES0000-----------------------
INT 2F - AD-DOS - GET RESIDENT CODE SEGMENT
	AX = 0C01h
	ES = 0000h
Return: CF clear succesful
	    ES = AD-DOS TSR Code Segment
	CF set if failed
SeeAlso: AX=0C00h
----------2F0C02-----------------------------
INT 2F - AD-DOS - CHECK FOR NEW INPUT
	AX = 0C02h
Return: BX = status
	    0000h no input since last check
	    0001h new input available
Note:	this call also resets the new-input flag
----------2F0C03-----------------------------
INT 2F - AD-DOS - SET MINUTES TO WAIT
	AX = 0C03h
	BX = minutes to wait before blanking screen
	CF set
Return: n/a???
Notes:	AD-DOS is the DOS version of the After Dark screen blanker
	AH=0Ch is the default multiplex number
SeeAlso: AX=0C04h
----------2F0C04-----------------------------
INT 2F - AD-DOS - GET MINUTES TO WAIT
	AX = 0C04h
	CF set
Return: BX = minutes to wait before blanking screen
	???
SeeAlso: AX=0C03h
----------2F0C05-----------------------------
INT 2F - AD-DOS - SET ENABLE??? FLAG
	AX = 0C05h
	BX = new state (0000h or 0001h) (default 0001h)
	CF set
Return: n/a???
SeeAlso: AX=0C06h
----------2F0C06-----------------------------
INT 2F - AD-DOS - GET ENABLE??? FLAG
	AX = 0C06h
	Carry Set
Return: BX = current state of ??? flag (0000h or 0001h)
	???
Notes:	AD-DOS is the DOS version of the After Dark screen blanker
	AH=0Ch is the default multiplex number
SeeAlso: AX=0C05h
----------2F0C07-----------------------------
INT 2F - AD-DOS - SET HOT KEY
	AX = 0C07h
	BX = hot key
	CL = hot key shift status
	CF set
Return: n/a???
SeeAlso: AX=0C08h
----------2F0C08-----------------------------
INT 2F - AD-DOS - GET CURRENT HOT KEY
	AX = 0C08h
	CF set
Return: AX = status
	    0000h successful
		BX = Hot Key
		CL = Hot Key Shift Status
	    0008h otherwise
SeeAlso: AX=0C07h
----------2F0C09-----------------------------
INT 2F - AD-DOS - ???
	AX = 0C09h
	Carry Set
Return: AX = status
	    0000h successful
		???
	    0009h otherwise
Notes:	AD-DOS is the DOS version of the After Dark screen blanker
	AH=0Ch is the default multiplex number
----------2F0C0A-----------------------------
INT 2F - AD-DOS - ???
	AX = 0C0Ah
	CF set
Return: AX = status
	    0000h successful
		BH = ??
		BL = ??
	    000Ah failed
----------2F0C0B-----------------------------
INT 2F - AD-DOS - ???
	AX = 0C0Bh
	CF set
Return: AX = status 
	    0000h successful
	    000Bh failed
----------2F0C0C-----------------------------
INT 2F - AD-DOS - SET ??? INTERNAL FLAG TO 01h
	AX = 0C0Ch
	CF set
Return: AX = status
	    0000h successful
	    000Ch failed
Notes:	AD-DOS is the DOS version of the After Dark screen blanker
	AH=0Ch is the default multiplex number
----------2F0C20-----------------------------
INT 2F - AD-DOS - GET AND RESET VxD API STATUS
	AX = 0C20h
	CF set
Return: AX = status
	    0000h successful
		BX = VxD API Status
		    0000h no error
		    0001h error
		    0100h neither Windows 3.X enhanced mode nor
				Windows/386 2.x is running
		    0200h VM API entry point found
	    0020h otherwise
Note:	this call resets the VxD API Status to zero
SeeAlso: AX=1602h,AX=1607h
----------2F1000-----------------------------
INT 2F - SHARE - INSTALLATION CHECK
	AX = 1000h
Return: AL = 00h  not installed, OK to install
	     01h  not installed, not OK to install
	     FFh  installed
BUGS:	values of AL other than 00h put DOS 3.x SHARE into an infinite loop
	  (08E9: OR  AL,AL
	   08EB: JNZ 08EB) <- the buggy instruction (DOS 3.3)
	values of AL other than described here put PCDOS 4.00 into the same
	  loop (the buggy instructions are the same)
Notes:	supported by OS/2 v1.3+ compatibility box, which always returns AL=FFh
	if DOS 4.01 SHARE was automatically loaded, file sharing is in an
	  inactive state (due to the undocumented /NC flag used by the autoload
	  code) until this call is made
	DOS 5.0 chains to the previous handler if AL <> 00h on entry
SeeAlso: AX=1080h,INT 21/AH=52h
----------2F1040-----------------------------
INT 2F U - DOS 4 only SHARE internal - ???
	AX = 1040h
	???
Return: AL = FFh???
SeeAlso: AX=1000h
----------2F1080-----------------------------
INT 2F U - DOS 4 only SHARE internal - TURN ON FILE SHARING CHECKS
	AX = 1080h
Return: AL = status
	    F0h successful
	    FFh checking was already on
Note:	DOS 4.x SHARE has dual functions: FCB support for large (>32M) media
	  and file sharing checks.  The undocumented commandline flag /NC can
	  be used to disable the sharing code.
SeeAlso: AX=1000h,AX=1081h
----------2F1081-----------------------------
INT 2F U - DOS 4 only SHARE internal - TURN OFF FILE SHARING CHECKS
	AX = 1081h
Return: AL = status
	    F0h successful
	    FFh checking was already off
Note:	(see AX=1080h)
SeeAlso: AX=1000h,AX=1080h
----------2F10FF-----------------------------
INT 2F U - Multiplex - DR-DOS 5.0 - ???
	AX = 10FFh
	ES:BX -> ???
Note:	sets pointer in kernel
----------2F1100-----------------------------
INT 2F - NETWORK REDIRECTOR - INSTALLATION CHECK
	AX = 1100h
Return: AL = 00h  not installed, OK to install
	     01h  not installed, not OK to install
	     FFh  installed
Notes:	called by DOS 3.1+ kernel
	In DOS 4.x only, the 11xx calls are all in IFSFUNC.EXE, not in the
	  PC LAN Program redirector; DOS 5.0 moves the calls back into the
	  redirector
----------2F1100-----------------------------
INT 2F - MSCDEX (MS CD-ROM Extensions) - INSTALLATION CHECK
	AX = 1100h
	STACK: WORD DADAh
Return: AL = 00h not installed, OK to install
		STACK unchanged
	   = 01h not installed, not OK to install
		STACK unchanged
	   = FFh installed
		STACK: WORD ADADh
----------2F1101-----------------------------
INT 2F U - NETWORK REDIRECTOR - REMOVE REMOTE DIRECTORY
	AX = 1101h
	SS = DOS DS
	SDA first filename pointer -> fully-qualified directory name
	SDA CDS pointer -> current directory structure for drive with dir
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1103h,AX=1105h,INT 21/AH=3Ah,INT 21/AH=60h
----------2F1102-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - REMOVE REMOTE DIRECTORY
	AX = 1102h
	SS = DOS DS
	SDA first filename pointer -> fully-qualified directory name
	SDA CDS pointer -> current directory structure for drive with dir
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	appears to be identical to AX=1101h
SeeAlso: AX=1101h
----------2F1103-----------------------------
INT 2F U - NETWORK REDIRECTOR - MAKE REMOTE DIRECTORY
	AX = 1103h
	SS = DOS DS
	SDA first filename pointer -> fully-qualified directory name
	SDA CDS pointer -> current directory structure for drive with dir
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1101h,AX=1105h,INT 21/AH=39h,INT 21/AH=60h
----------2F1104-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - MAKE REMOTE DIRECTORY
	AX = 1104h
	SS = DOS DS
	SDA first filename pointer -> fully-qualified directory name
	SDA CDS pointer -> current directory structure for drive with dir
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	appears to be identical to AX=1103h
SeeAlso: AX=1103h
----------2F1105-----------------------------
INT 2F U - NETWORK REDIRECTOR - CHDIR
	AX = 1105h
	SS = DOS DS
	SDA first filename pointer -> fully-qualified directory name
	SDA CDS pointer -> current directory structure for drive with dir
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    CDS updated with new path
Notes:	called by DOS 3.1+ kernel
	directory string in CDS should not have a terminating backslash unless
	  the current directory is the root
SeeAlso: AX=1101h,AX=1103h,INT 21/AH=3Bh,INT 21/AH=60h
----------2F1106-----------------------------
INT 2F U - NETWORK REDIRECTOR - CLOSE REMOTE FILE
	AX = 1106h
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive containing file
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    SFT updated (except handle count, which DOS manages itself)
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1201h,AX=1227h,INT 21/AH=3Eh
----------2F1107-----------------------------
INT 2F U - NETWORK REDIRECTOR - COMMIT REMOTE FILE
	AX = 1107h
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive containing file
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    all buffers for file flushed
	    directory entry updated
Note:	called by DOS 3.1+ kernel
SeeAlso: INT 21/AH=68h,INT 21/AX=5D01h
----------2F1108-----------------------------
INT 2F U - NETWORK REDIRECTOR - READ FROM REMOTE FILE
	AX = 1108h
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive containing file
	CX = number of bytes
	SS = DOS DS
	SDA DTA field -> user buffer
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    CX = number of bytes read (0000h = end of file)
	    SFT updated
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1109h,AX=1229h,INT 21/AH=3Fh,INT 21/AX=5D06h
----------2F1109-----------------------------
INT 2F U - NETWORK REDIRECTOR - WRITE TO REMOTE FILE
	AX = 1109h
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive containing file
	CX = number of bytes
	SS = DOS DS
	SDA DTA field -> user buffer
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    CX = number of bytes written
	    SFT updated
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1107h,AX=1108h,INT 21/AH=40h,INT 21/AX=5D06h
----------2F110A-----------------------------
INT 2F U - NETWORK REDIRECTOR (DOS 3.x only) - LOCK REGION OF FILE
	AX = 110Ah
	BX = file handle
	CX:DX = starting offset
	SI = high word of size
	STACK: WORD low word of size
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive containing file
	SS = DOS DS
Return: CF set on error
	   AL = DOS error code (see INT 21/AH=59h)
	STACK unchanged
Notes:	called by DOS 3.10-3.31 kernel
	the redirector is expected to resolve lock conflicts
SeeAlso: AX=110Bh,INT 21/AH=5Ch
----------2F110A-----------------------------
INT 2F U - NETWORK REDIRECTOR (DOS 4+) - LOCK/UNLOCK REGION OF FILE
	AX = 110Ah
	BL = function
	    00h lock
	    01h unlock
	DS:DX -> parameter block (see below)
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive containing file
	SS = DOS DS
Return: CF set on error
	   AL = DOS error code (see INT 21/AH=59h)
Notes:	called by DOS 4.0+ kernel
	the redirector is expected to resolve lock conflicts
SeeAlso: AX=110Bh,INT 21/AH=5Ch

Format of parameter block:
Offset	Size	Description
 00h	DWORD	start offset
 04h	DWORD	size of region
----------2F110B-----------------------------
INT 2F U - NETWORK REDIRECTOR (DOS 3.x only) - UNLOCK REGION OF FILE
	AX = 110Bh
	BX = file handle
	CX:DX = starting offset
	SI = high word of size
	STACK: WORD low word of size
	ES:DI -> SFT for file
	    SFT DPB field -> DPB of drive containing file
Return: CF set on error
	   AL = DOS error code (see INT 21/AH=59h)
	STACK unchanged
Note:	called by DOS 3.1-3.31 kernel; DOS 4.0+ calls AX=110Ah instead
SeeAlso: AX=110Ah,INT 21/AH=5Ch
----------2F110C-----------------------------
INT 2F U - NETWORK REDIRECTOR - GET DISK SPACE
	AX = 110Ch
	ES:DI -> current directory structure for desired drive
Return: AL = sectors per cluster
	AH = media ID byte
	BX = total clusters
	CX = bytes per sector
	DX = number of available clusters
Note:	called by DOS 3.1+ kernel
SeeAlso: INT 21/AH=36h
----------2F110D-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 110Dh
	SDA first filename pointer -> name of file
	???
Return: ???
Note:	appears to be similar to AX=110Fh
SeeAlso: AX=110Fh
----------2F110E-----------------------------
INT 2F U - NETWORK REDIRECTOR - SET REMOTE FILE'S ATTRIBUTES
	AX = 110Eh
	SS = DOS DS
	SDA first filename pointer -> fully-qualified name of file
	SDA CDS pointer -> current directory structure for drive with file
	STACK: WORD new file attributes
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	STACK unchanged
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=110Fh,INT 21/AX=4301h,INT 21/AH=60h
----------2F110F-----------------------------
INT 2F U - NETWORK REDIRECTOR - GET REMOTE FILE'S ATTRIBUTES AND SIZE
	AX = 110Fh
	SS = DOS DS
	SDA first filename pointer -> fully-qualified name of file
	SDA CDS pointer -> current directory structure for drive with file
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    AX = file attributes
	    BX:DI = file size
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=110Eh,INT 21/AX=4300h,INT 21/AH=60h
----------2F1110-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 1110h
	SDA first filename pointer -> name of file
	???
Return: ???
Note:	appears to be similar to AX=110Eh
SeeAlso: AX=110Eh
----------2F1111-----------------------------
INT 2F U - NETWORK REDIRECTOR - RENAME REMOTE FILE
	AX = 1111h
	SS = DS = DOS DS
	SDA first filename pointer = offset of fully-qualified old name
	SDA second filename pointer = offset of fully-qualified new name
	SDA CDS pointer -> current directory structure for drive with file
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	called by DOS 3.1+ kernel
SeeAlso: INT 21/AH=56h,INT 21/AH=60h
----------2F1112-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 1112h
	SS = DS = DOS DS
	SDA first filename pointer -> name of file
	???
Return: ???
SeeAlso: AX=1111h
----------2F1113-----------------------------
INT 2F U - NETWORK REDIRECTOR - DELETE REMOTE FILE
	AX = 1113h
	SS = DS = DOS DS
	SDA first filename pointer -> fully-qualified filename in DOS DS
	SDA CDS pointer -> current directory structure for drive with file
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Notes:	called by DOS 3.1+ kernel
	the filespec may contain wildcards
SeeAlso: INT 21/AH=41h,INT 21/AH=60h
----------2F1114-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 1114h
	SDA first filename pointer -> name of file
	???
Return: ???
SeeAlso: AX=1113h
----------2F1115-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 1115h
	SS = DOS DS
	ES:DI -> SFT ???
	???
Return: ???
SeeAlso: AX=112Eh
----------2F1116-----------------------------
INT 2F U - NETWORK REDIRECTOR - OPEN EXISTING REMOTE FILE
	AX = 1116h
	ES:DI -> uninitialized SFT
	SS = DOS DS
	SDA first filename pointer -> fully-qualified name of file to open
	STACK: WORD file open mode (see INT 21/AH=3Dh)
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    SFT filled (except handle count, which DOS manages itself)
	STACK unchanged
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1106h,AX=1117h,AX=1118h,AX=112Eh,INT 21/AH=3Dh,INT 21/AH=60h
----------2F1117-----------------------------
INT 2F U - NETWORK REDIRECTOR - CREATE/TRUNCATE REMOTE FILE
	AX = 1117h
	ES:DI -> uninitialized SFT
	SS = DOS DS
	SDA first filename pointer -> fully-qualified name of file to open
	SDA CDS pointer -> current directory structure for drive with file
	STACK: WORD file creation mode
			low byte = file attributes
			high byte = 00h normal create, 01h create new file
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    SFT filled (except handle count, which DOS manages itself)
	STACK unchanged
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1106h,AX=1116h,AX=1118h,AX=112Eh,INT 21/AH=3Ch,INT 21/AH=60h
----------2F1118-----------------------------
INT 2F U - NETWORK REDIRECTOR - CREATE/TRUNCATE FILE WITHOUT CDS
	AX = 1118h
	ES:DI -> uninitialized SFT
	SS = DOS DS
	SDA first filename pointer -> fully-qualified name of file
	STACK: WORD file creation mode
			low byte = file attributes
			high byte = 00h normal create, 01h create new file
Return: ???
	STACK unchanged
Note:	called by DOS 3.1+ kernel when creating a file on a drive for which the
	  SDA CDS pointer has offset FFFFh
SeeAlso: AX=1106h,AX=1116h,AX=1117h,AX=112Eh,INT 21/AH=60h
----------2F1119-----------------------------
INT 2F U - NETWORK REDIRECTOR - FIND FIRST FILE WITHOUT CDS
	AX = 1119h
	SS = DS = DOS DS
	[DTA] = uninitialized 21-byte findfirst search data (see INT 21/AH=4Eh)
	SDA first filename pointer -> fully-qualified search template
	SDA search attribute = attribute mask for search
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    [DTA] = updated findfirst search data
		    (bit 7 of first byte must be set)
	    [DTA+15h] = standard directory entry for file
Notes:	called by DOS 3.1+ kernel
	DOS 4.x IFSFUNC returns CF set, AX=0003h	
----------2F111A-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 111Ah
	???
Return: CF set
	    AX = error code (03h for DOS 4.01 IFSFUNC)
----------2F111B-----------------------------
INT 2F U - NETWORK REDIRECTOR - FINDFIRST
	AX = 111Bh
	SS = DS = DOS DS
	[DTA] = uninitialized 21-byte findfirst search data (see INT 21/AH=4Eh)
	SDA first filename pointer -> fully-qualified search template
	SDA CDS pointer -> current directory structure for drive with file
	SDA search attribute = attribute mask for search
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    [DTA] = updated findfirst search data
		    (bit 7 of first byte must be set)
	    [DTA+15h] = standard directory entry for file
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=111Ch,INT 21/AH=4Eh,INT 21/AH=60h
----------2F111C-----------------------------
INT 2F U - NETWORK REDIRECTOR - FINDNEXT
	AX = 111Ch
	SS = DS = DOS DS
	[DTA] = 21-byte findfirst search data (see INT 21/AH=4Eh)
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    [DTA] = updated findfirst search data
		    (bit 7 of first byte must be set)
	    [DTA+15h] = standard directory entry for file
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=111Bh,INT 21/AH=4Fh
----------2F111D-----------------------------
INT 2F U - NETWORK REDIRECTOR - CLOSE ALL REMOTE FILES FOR PROCESS
	AX = 111Dh
	DS???
	SS = DOS DS
Return: ???
Notes:	called by DOS 3.1+ kernel
	closes all FCBs opened by process
----------2F111E-----------------------------
INT 2F U - NETWORK REDIRECTOR - DO REDIRECTION
	AX = 111Eh
	SS = DOS DS
	STACK: WORD function to execute
		5F00h  get redirection mode
			BL = type (03h printer, 04h disk)
			Return: BH = state (00h off, 01h on)
		5F01h  set redirection mode
			BL = type (03h printer, 04h disk)
			BH = state (00h off, 01h on)
		5F02h  get redirection list entry
			BX = redirection list index
			DS:SI -> 16-byte local device name buffer
			ES:DI -> 128-byte network name buffer
			Return: must set user's BX to device type and CX to
				stored parameter value, using AX=1218h to get
				stack frame address
		5F03h  redirect device
			BL = device type (see INT 21/AX=5F03h)
			CX = stored parameter value
			DS:SI -> ASCIZ source device name
			ES:DI -> destination ASCIZ network path + ASCIZ passwd
		5F04h  cancel redirection
			DS:SI -> ASCIZ device name or network path
		5F05h  get redirection list extended entry
			BX = redirection list index
			DS:SI -> buffer for ASCIZ source device name
			ES:DI -> buffer for destination ASCIZ network path
			Return: BH = status flag
				BL = type (03h printer, 04h disk)
				CX = stored parameter value
				BP = NETBIOS local session number
		5F06h  similar to 5F05h???
Return: CF set on error
	    AX = error code (see INT 21/AH=59h)
	STACK unchanged
Note:	called by DOS 3.1+ kernel
SeeAlso: INT 21/AX=5F00h,INT 21/AX=5F01h,INT 21/AX=5F02h,INT 21/AX=5F03h
SeeAlso: INT 21/AX=5F04h,INT 21/AX=5F05h,INT 21/AX=5F06h
----------2F111F-----------------------------
INT 2F U - NETWORK REDIRECTOR - PRINTER SETUP
	AX = 111Fh
	STACK: WORD function
		5E02h  set printer setup
		5E03h  get printer setup
		5E04h  set printer mode
		5E05h  get printer mode
Return: CF set on error
	    AX = error code (see INT 21/AH=59h)
	STACK unchanged
Note:	called by DOS 3.1+ kernel
SeeAlso: INT 21/AX=5E02h,INT 21/AX=5E03h,INT 21/AX=5E04h,INT 21/AX=5E05h
----------2F1120-----------------------------
INT 2F U - NETWORK REDIRECTOR - FLUSH ALL DISK BUFFERS
	AX = 1120h
	DS = DOS DS
	???
Return: CF clear (successful)
Notes:	called by DOS 3.1+ kernel
	uses CDS array pointer and LASTDRIVE= entries in DOS list of lists
SeeAlso: INT 21/AH=0Dh,INT 21/AX=5D01h
----------2F1121-----------------------------
INT 2F U - NETWORK REDIRECTOR - SEEK FROM END OF REMOTE FILE
	AX = 1121h
	CX:DX = offset (in bytes) from end
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive with file
	SS = DOS DS
Return: CF set on error
	    AL = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    DX:AX = new file position
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1228h,INT 21/AH=42h
----------2F1122-----------------------------
INT 2F U - NETWORK REDIRECTOR - PROCESS TERMINATION HOOK
	AX = 1122h
	SS = DOS DS
	???
Return: ???
Note:	called by DOS 3.1+ kernel
----------2F1123-----------------------------
INT 2F U - NETWORK REDIRECTOR - QUALIFY REMOTE FILENAME
	AX = 1123h
	DS:SI -> ASCIZ filename to canonicalize
	ES:DI -> 128-byte buffer for qualified name
Return: CF set if not resolved
Notes:	called by MSDOS 3.1+ kernel, but not called by DRDOS 5.0 unless the
	  filename matches the name of a character device
	called first when DOS attempts to resolve a filename (unless inside an
	  AX=5D00h server call); if this fails, DOS resolves the name locally
SeeAlso: AX=1221h,INT 21/AH=60h
----------2F1124-----------------------------
INT 2F U - NETWORK REDIRECTOR - PRINTER OFF???
	AX = 1124h
	ES:DI -> SFT
	SS = DOS DS
	???
Return: CX = ???
Note:	called by DOS 3.1+ kernel if AX=1126h returns CF set
SeeAlso: AX=1126h
----------2F1125-----------------------------
INT 2F U - NETWORK REDIRECTOR - REDIRECTED PRINTER MODE
	AX = 1125h
	STACK: WORD subfunction
		5D07h get print stream state
			Return: DL = current state
		5D08h set print stream state
			DL = new state
		5D09h finish print job
Return: CF set on error
	    AX = error code (see INT 21/AH=59h)
	STACK unchanged
Note:	called by DOS 3.1+ kernel
SeeAlso: INT 21/AX=5D07h,INT 21/AX=5D08h,INT 21/AX=5D09h
----------2F1126-----------------------------
INT 2F U - NETWORK REDIRECTOR - PRINTER ON/OFF???
	AX = 1126h
	ES:DI -> SFT for file handle 4???
	SS = DOS DS???
	???
Return: CF set on error
Notes:	called by DOS 3.1+ kernel
	called when print echoing (^P, ^PrtSc) changes state and STDPRN has
	  bit 11 of the device information word in the SFT set
SeeAlso: AX=1124h
----------2F1127-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - UNUSED
	AX = 1127h
Return: CF set
	    AX = 0001h (invalid function) (see INT 21/AH=59h)
----------2F1128-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - UNUSED
	AX = 1128h
Return: CF set
	    AX = 0001h (invalid function) (see INT 21/AH=59h)
----------2F1129-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - UNUSED
	AX = 1129h
Return: CF set
	    AX = 0001h (invalid function) (see INT 21/AH=59h)
----------2F112A-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 112Ah
	DS = DOS DS
	???
Return: ???
Note:	does something to each IFS driver
----------2F112B-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - GENERIC IOCTL???
	AX = 112Bh
	SS = DOS DS
	CX = function/category
	DS:DX -> parameter block
	STACK: WORD value of AX on entry to INT 21 (440Ch or 440Dh)
	???
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	called by DOS 4.0 kernel
----------2F112C-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 112Ch
	SS = DOS DS
	SDA current SFT pointer -> SFT for file
	???
Return: CF set on error
----------2F112D-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 112Dh
	BL = subfunction (value of AL on INT 21)
	    04h truncate open file to zero length
		ES:DI -> SFT for file
		Return: CF clear
	    else ???
		Return: CX = ??? (00h or 02h for DOS 4.01)
	ES:DI -> SFT
	SS = DOS DS
Return: DS = DOS DS
Note:	called by DOS 4.0 kernel on INT 21/AX=5702h,INT 21/AX=5703h,
	  INT 21/AX=5704h
----------2F112E-----------------------------
INT 2F U - NETWORK REDIRECTOR (DOS 4+) - EXTENDED OPEN/CREATE FILE
	AX = 112Eh
	SS = DS = DOS DS
	ES:DI -> uninitialized SFT for file
	STACK: WORD file attribute for created/truncated file
			low byte = file attributes
			high byte = 00h normal create/open, 01h create new file
	SDA first filename pointer -> fully-qualified filename
	SDA extended file open action = action code (see INT 21/AX=6C00h)
	SDA extended file open mode = open mode for file (see INT 21/AX=6C00h)
Return: CF set on error
	    AX = error code
	CF clear if successful
	    CX = result code
		01h file opened
		02h file created
		03h file replaced (truncated)
	    SFT initialized (except handle count, which DOS manages itself)
Note:	called by DOS 4.0 kernel
SeeAlso: AX=1115h,AX=1116h,AX=1117h,INT 21/AX=6C00h
----------2F112F-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 112Fh
	SS = DOS DS
	STACK: WORD function in low byte
		00h ???
		    DS:SI -> Current Directory Structure???
		    CL = drive (1=A:)
		01h ???
		    DS:SI -> ???
		    CL = file handle???
		02h ???
		    DS:SI -> Current Directory Structure???
		    DI = ???
		    CX = drive (1=A:)
	???
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	called by DOS 4.0 kernel
SeeAlso: INT 21/AH=6Bh
----------2F1130-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - GET IFSFUNC SEGMENT
	AX = 1130h
Return: ES = CS of resident IFSFUNC
----------2F1186-----------------------------
INT 2F - LAN Manager Enhanced DOS API - DosReadAsynchNmPipe
	AX = 1186h
	???
Return: ???
Note:	LAN Manager enhance mode adds features beyond the standard redirector
	  file/printer services
SeeAlso: AX=118Fh,INT 21/AX=5F39h
----------2F118A-----------------------------
INT 2F - LAN Manager 2.0 DOS Enhanced ENCRYPT.EXE - STREAM ENCRYPTION SERVICE
	AX = 118Ah
	???
Return: ???
SeeAlso: AX=1186h,AH=41h,AH=42h,AH=4Bh
----------2F118F-----------------------------
INT 2F - LAN Manager Enhanced DOS API - DosWriteAsynchNmPipe
	AX = 118Fh
	???
Return: ???
SeeAlso: AX=1186h,INT 21/AX=5F3Ah
----------2F1200-----------------------------
INT 2F U - DOS 3+ internal - INSTALLATION CHECK
	AX = 1200h
Return: AL = FFh (for compatibility with other INT 2F functions)
----------2F1201-----------------------------
INT 2F U - DOS 3+ internal - CLOSE CURRENT FILE
	AX = 1201h
	SS = DOS DS
	SDA current SFT pointer -> SFT of file to close
Return: CF set on error
	BX???
	CX new reference count of SFT
	ES:DI -> SFT for file
SeeAlso: AX=1106h,AX=1227h,INT 21/AH=3Eh
----------2F1202-----------------------------
INT 2F U - DOS 3+ internal - GET INTERRUPT ADDRESS
	AX = 1202h
	STACK: WORD vector number
Return: ES:BX -> interrupt vector
	STACK unchanged
----------2F1203-----------------------------
INT 2F U - DOS 3+ internal - GET DOS DATA SEGMENT
	AX = 1203h
Return: DS = segment of IBMDOS.COM/MSDOS.SYS
----------2F1204-----------------------------
INT 2F U - DOS 3+ internal - NORMALIZE PATH SEPARATOR
	AX = 1204h
	STACK: WORD character to normalize
Return: AL = normalized character (forward slash turned to backslash, all
		others unchanged)
	ZF set if path separator
	STACK unchanged
----------2F1205-----------------------------
INT 2F U - DOS 3+ internal - OUTPUT CHARACTER TO STANDARD OUTPUT
	AX = 1205h
	STACK: WORD character to output
Return: STACK unchanged
Note:	can be called only from within DOS
----------2F1206-----------------------------
INT 2F U - DOS 3+ internal - INVOKE CRITICAL ERROR
	AX = 1206h
	DI = error code
	BP:SI -> device driver header
	SS = DOS DS
	STACK: WORD value to be passed to INT 24 in AX
Return: AL = 0-3 for Abort, Retry, Ignore, Fail
	STACK unchanged
SeeAlso: INT 24
----------2F1207-----------------------------
INT 2F U - DOS 3+ internal - MAKE DISK BUFFER MOST-RECENTLY USED
	AX = 1207h
	DS:DI -> disk buffer
Return: nothing
Notes:	can be called only from within DOS
	buffer is moved to end of buffer list (least-recently used is first)
SeeAlso: AX=120Fh
----------2F1208-----------------------------
INT 2F U - DOS 3+ internal - DECREMENT SFT REFERENCE COUNT
	AX = 1208h
	ES:DI -> SFT
Return: AX = original value of reference count
Note:	if the reference count was 1, it is set to FFFFh (since 0 indicates
	  that the SFT is not in use).	It is the caller's responsibility to
	  set the reference count to zero after cleaning up.
----------2F1209-----------------------------
INT 2F U - DOS 3+ internal - FLUSH AND FREE DISK BUFFER
	AX = 1209h
	DS:DI -> disk buffer
Return: disk buffer marked unused, contents written to disk if buffer dirty
Note:	can be called only from within DOS
SeeAlso: AX=120Eh,AX=1215h
----------2F120A-----------------------------
INT 2F U - DOS 3+ internal - PERFORM CRITICAL ERROR INTERRUPT
	AX = 120Ah
	DS = SS = DOS DS
	STACK: WORD extended error code
Return: AL = user response (0=ignore, 1=retry, 2=abort, 3=fail)
	CF clear if retry, set otherwise
	STACK unchanged
Notes:	can only be called during a DOS function call, as it uses various
	  fields in the SDA to set up the registers for the INT 24
	reportedly sets current DPB's first root directory sector to 1
SeeAlso: INT 24
----------2F120B-----------------------------
INT 2F U - DOS 3+ internal - SIGNAL SHARING VIOLATION TO USER
	AX = 120Bh
	ES:DI -> system file table entry for previous open of file
	STACK: WORD extended error code (should be 20h--sharing violation)
Return: CF clear if operation should be retried
	CF set if operation should not be retried
	    AX = error code (20h) (see INT 21/AH=59h)
	STACK unchanged
Notes:	can only be called during a DOS function call
	should only be called if an attempt was made to open an already-open
	  file contrary to the sharing rules
	invokes INT 24 if SFT file opened via FCB or in compatibility mode with
	  inheritance allowed
----------2F120C-----------------------------
INT 2F U - DOS 3+ internal - OPEN DEVICE AND SET SFT OWNER???
	AX = 120Ch
	SDA current SFT pointer -> SFT for file
	DS = SS = DOS DS
Return: ES, DI, AX destroyed
Notes:	invoked "device open" call on device driver for SFT
	changes owner of last-accessed SFT to calling process if it was opened
	  via FCB
	called by network redirectors
----------2F120D-----------------------------
INT 2F U - DOS 3+ internal - GET DATE AND TIME
	AX = 120Dh
	SS = DOS DS
Return: AX = current date in packed format (see INT 21/AX=5700h)
	DX = current time in packed format (see INT 21/AX=5700h)
SeeAlso: INT 21/AH=2Ah,INT 21/AH=2Ch
----------2F120E-----------------------------
INT 2F U - DOS 3+ internal - MARK ALL DISK BUFFERS UNREFERENCED
	AX = 120Eh
	SS = DOS DS
Return: DS:DI -> first disk buffer
Note:	clears "referenced" flag on all disk buffers
SeeAlso: AX=1209h,AX=1210h,INT 21/AH=0Dh
----------2F120F-----------------------------
INT 2F U - DOS 3+ internal - MAKE BUFFER MOST RECENTLY USED
	AX = 120Fh
	DS:DI -> disk buffer
	SS = DOS DS
Return: DS:DI -> next buffer in buffer list
Note:	indicated buffer moved to end of chain
SeeAlso: AX=1207h
----------2F1210-----------------------------
INT 2F U - DOS 3+ internal - FIND UNREFERENCED DISK BUFFER
	AX = 1210h
	DS:DI -> first disk buffer to check
Return: ZF clear if found
	    DS:DI -> first unreferenced disk buffer
	ZF set if not found
SeeAlso: AX=120Eh
----------2F1211-----------------------------
INT 2F U - DOS 3+ internal - NORMALIZE ASCIZ FILENAME
	AX = 1211h
	DS:SI -> ASCIZ filename to normalize
	ES:DI -> buffer for normalized filename
Return: destination buffer filled with uppercase filename, with slashes turned
	to backslashes
SeeAlso: AX=121Eh,AX=1221h
----------2F1212-----------------------------
INT 2F U - DOS 3+ internal - GET LENGTH OF ASCIZ STRING
	AX = 1212h
	ES:DI -> ASCIZ string
Return: CX = length of string
SeeAlso: AX=1225h
----------2F1213-----------------------------
INT 2F U - DOS 3+ internal - UPPERCASE CHARACTER
	AX = 1213h
	STACK: WORD character to convert to uppercase
Return: AL = uppercase character
	STACK unchanged
----------2F1214-----------------------------
INT 2F U - DOS 3+ internal - COMPARE FAR POINTERS
	AX = 1214h
	DS:SI = first pointer
	ES:DI = second pointer
Return: ZF set if pointers are equal, ZF clear if not equal
----------2F1215-----------------------------
INT 2F U - DOS 3+ internal - FLUSH BUFFER
	AX = 1215h
	DS:DI -> disk buffer
	SS = DOS DS
	STACK: WORD drives for which to skip buffer
		ignore buffer if drive same as high byte, or bytes differ and
		the buffer is for a drive OTHER than that given in low byte
Return: STACK unchanged
Note:	can be called only from within DOS
SeeAlso: AX=1209h
----------2F1216-----------------------------
INT 2F U - DOS 3+ internal - GET ADDRESS OF SYSTEM FILE TABLE
	AX = 1216h
	BX = system file table entry number
Return: CF clear if successful
	    ES:DI -> system file table entry
	CF set if BX greater than FILES=
SeeAlso: AX=1220h
----------2F1217-----------------------------
INT 2F U - DOS 3+ internal - GET CURRENT DIRECTORY STRUCTURE FOR DRIVE
	AX = 1217h
	SS = DOS DS
	STACK: WORD drive (0 = A:, 1 = B:, etc)
Return: CF set on error
	    (drive > LASTDRIVE)
	CF clear if successful
	    DS:SI -> current directory structure for specified drive
	STACK unchanged
SeeAlso: AX=1219h
----------2F1218-----------------------------
INT 2F U - DOS 3+ internal - GET CALLER'S REGISTERS
	AX = 1218h
Return: DS:SI -> saved caller's AX,BX,CX,DX,SI,DI,BP,DS,ES (on stack)
Note:	only valid while within DOS
----------2F1219-----------------------------
INT 2F U - DOS 3+ internal - SET DRIVE???
	AX = 1219h
	SS = DOS DS
	STACK: WORD drive (0 = default, 1 = A:, etc)
Return: ???
	STACK unchanged
Notes:	calls AX=1217h
	builds a current directory structure if inside server call
	  (INT 21/AX=5D00h)
SeeAlso: AX=1217h,AX=121Fh
----------2F121A-----------------------------
INT 2F U - DOS 3+ internal - GET FILE'S DRIVE
	AX = 121Ah
	DS:SI -> filename
Return: AL = drive (0 = default, 1 = A:, etc, FFh = invalid)
	DS:SI -> filename without leading X: (if present)
SeeAlso: INT 21/AH=19h,INT 21/AH=60h
----------2F121B-----------------------------
INT 2F U - DOS 3+ internal - SET YEAR/LENGTH OF FEBRUARY
	AX = 121Bh
	CL = year - 1980
Return: AL = number of days in February
Note:	requires DS to be set to the DOS code segment
SeeAlso: INT 21/AH=2Bh
----------2F121C-----------------------------
INT 2F U - DOS 3+ internal - CHECKSUM MEMORY
	AX = 121Ch
	DS:SI -> start of memory to checksum
	CX = number of bytes
	DX = initial checksum
	SS = DOS DS
Return: AX, CX destroyed
	DX = checksum
	DS:SI -> first byte after checksummed range
Note:	used by DOS to determine day count since 1/1/80 given a date
SeeAlso: AX=121Dh
----------2F121D-----------------------------
INT 2F U - DOS 3+ internal - SUM MEMORY
	AX = 121Dh
	DS:SI -> memory to add up
	CX = 0000h
	DX = limit
Return: AL = byte which exceeded limit
	CX = number of bytes before limit exceeded
	DX = remainder after adding first CX bytes
	DS:SI -> byte beyond the one which exceeded the limit
Note:	used by DOS to determine year or month given day count since 1/1/80
SeeAlso: AX=121Ch
----------2F121E-----------------------------
INT 2F U - DOS 3+ internal - COMPARE FILENAMES
	AX = 121Eh
	DS:SI -> first ASCIZ filename
	ES:DI -> second ASCIZ filename
Return: ZF set if filenames equivalent, ZF clear if not
SeeAlso: AX=1211h,AX=1221h
----------2F121F-----------------------------
INT 2F U - DOS 3+ internal - BUILD CURRENT DIRECTORY STRUCTURE
	AX = 121Fh
	SS = DOS DS
	STACK: WORD drive letter
Return: ES:DI -> current directory structure (will be overwritten by next call)
	STACK unchanged
----------2F1220-----------------------------
INT 2F U - DOS 3+ internal - GET JOB FILE TABLE ENTRY
	AX = 1220h
	BX = file handle
Return: CF set on error
	    AL = 6 (invalid file handle)
	CF clear if successful
	    ES:DI -> JFT entry for file handle in current process
Note:	the byte pointed at by ES:DI contains the number of the SFT for the
	  file handle, or FFh if the handle is not open
SeeAlso: AX=1216h,AX=1229h
----------2F1221-----------------------------
INT 2F U - DOS 3+ internal - CANONICALIZE FILE NAME
	AX = 1221h
	DS:SI -> file name to be fully qualified
	ES:DI -> 128-byte buffer for resulting canonical file name
	SS = DOS DS
Return: (see INT 21/AH=60h)
Note:	identical to INT 21/AH=60h
SeeAlso: AX=1123h,INT 21/AH=60h
----------2F1222-----------------------------
INT 2F U - DOS 3+ internal - SET EXTENDED ERROR INFO
	AX = 1222h
	SS = DOS data segment
	SS:SI -> 4-byte records
		BYTE	error code, FFh = last record
		BYTE	error class, FFh = don't change
		BYTE	suggested action, FFh = don't change
		BYTE	error locus, FFh = don't change
	SDA error code set
Return: SI destroyed
	SDA error class, error locus, and suggested action fields set
Note:	can be called only from within DOS
SeeAlso: AX=122Dh,INT 21/AH=59h
----------2F1223-----------------------------
INT 2F U - DOS 3+ internal - CHECK IF CHARACTER DEVICE
	AX = 1223h
	SDA+218h (DOS 3.10-3.30) = eight-character blank-padded name
	SDA+22Bh (DOS 4.0x) = eight-character blank-padded name
Return: CF set if no character device by that name found
	CF clear if found
	    BH = low byte of device attribute word
Note:	can only be called from within DOS (assumes DS=SS=DOS DS)
SeeAlso: INT 21/AX=5D06h,INT 21/AX=5D0Bh
----------2F1224-----------------------------
INT 2F U - DOS 3+ internal - DELAY
	AX = 1224h
	SS = DOS DS
Return: after delay set by INT 21/AX=440Bh, unless in server call
	  (INT 21/AX=5D00h)
Note:	delay is dependent on the processor speed, and is skipped entirely if
	  inside a server call
SeeAlso: INT 21/AX=440Bh,INT 21/AH=52h
----------2F1225-----------------------------
INT 2F U - DOS 3+ internal - GET LENGTH OF ASCIZ STRING
	AX = 1225h
	DS:SI -> ASCIZ string
Return: CX = length of string
SeeAlso: AX=1212h
----------2F1226-----------------------------
INT 2F U - DOS 3.3+ internal - OPEN FILE
	AX = 1226h
	CL = access mode
	DS:DX -> ASCIZ filename
Return: CF set on error
	    AL = error code (see INT 21/AH=59h)
	CF clear if successful
	    AX = file handle
Notes:	can only be called from within DOS (assumes SS=DOS DS)
	equivalent to INT 21/AH=3Dh	
SeeAlso: AX=1227h,INT 21/AH=3Dh
----------2F1227-----------------------------
INT 2F U - DOS 3.3+ internal - CLOSE FILE
	AX = 1227h
	BX = file handle
Return: CF set on error
	    AL = 06h invalid file handle
	CF clear if successful
Notes:	can only be called from within DOS (assumes SS=DOS DS)
	equivalent to INT 21/AH=3Eh
SeeAlso: AX=1106h,AX=1201h,AX=1226h,INT 21/AH=3Eh
----------2F1228BP4200-----------------------
INT 2F U - DOS 3.3+ internal - MOVE FILE POINTER
	AX = 1228h
	BP = 4200h, 4201h, 4202h (see INT 21/AH=42h)
	BX = file handle
	CX:DX = offset in bytes
	SS = DOS DS
Return: as for INT 21/AH=42h
Notes:	equivalent to INT 21/AH=42h, but may only be called from inside a DOS
	  function call
	sets user stack frame pointer to dummy buffer, moves BP to AX, performs
	  LSEEK, and restores frame pointer
SeeAlso: INT 21/AH=42h
----------2F1229-----------------------------
INT 2F U - DOS 3.3+ internal - READ FROM FILE
	AX = 1229h
	BX = file handle
	CX = number of bytes to read
	DS:DX -> buffer
	SS = DOS DS
Return: as for INT 21/AH=3Fh
Note:	equivalent to INT 21/AH=3Fh, but may only be called when already inside
	  a DOS function call
SeeAlso: AX=1226h,INT 21/AH=3Fh
----------2F122A-----------------------------
INT 2F U - DOS 3.3+ internal - SET FASTOPEN ENTRY POINT
	AX = 122Ah
	BX = entry point to set (0001h or 0002h)
	DS:SI -> FASTOPEN entry point
		(entry point not set if SI = FFFFh for DOS 4+)
Return: CF set if specified entry point already set
Notes:	entry point in BX is ignored under DOS 3.30
	both entry points set to same handler by DOS 4.01

DOS 3.30+ FASTOPEN is called with:
	AL = 01h  ???
	    CX = ??? seems to be offset
	    DI = ??? seems to be offset
	    SI = offset in DOS DS of filename
	AL = 02h  ???
	AL = 03h  open file???
	    SI = offset in DOS DS of filename
	AL = 04h  ???
	    AH = subfunction (00h,01h,02h)
	    ES:DI -> ???
	    CX = ??? (subfunctions 01h and 02h only)
Returns: CF set on error or not installed
Note: function 03h calls function 01h first

PCDOS 4.01 FASTOPEN is additionally called with:
	AL = 04h ???
	    AH = 03h
	    ???
	AL = 05h ???
	AL = 0Bh ???
	AL = 0Ch ???
	AL = 0Dh ???
	AL = 0Eh ???
	AL = 0Fh ???
	AL = 10h ???

MSDOS 5.0 FASTOPEN is additionally called with:
	AL = 04h ???
	    AH = 03h
	    ???
	AL = 05h ???
	    DL = drive (00h = A:)
	    ???
	AL = 06h ???
----------2F122B-----------------------------
INT 2F U - DOS 3.3+ internal - IOCTL
	AX = 122Bh
	BP = 44xxh
	SS = DOS DS
	additional registers as appropriate for INT 21/AX=44xxh
Return: as for INT 21/AH=44h
Notes:	equivalent to INT 21/AH=44h, but may only be called when already inside
	  a DOS function call
	sets user stack frame pointer to dummy buffer, moves BP to AX, performs
	  IOCTL, and restores frame pointer
SeeAlso: INT 21/AH=44h
----------2F122C-----------------------------
INT 2F U - DOS 3.3+ internal - GET DEVICE CHAIN
	AX = 122Ch
Return: BX:AX -> header of second device driver (NUL is first) in driver chain
SeeAlso: INT 21/AH=52h
----------2F122D-----------------------------
INT 2F U - DOS 3.3+ internal - GET EXTENDED ERROR CODE
	AX = 122Dh
Return: AX = current extended error code
SeeAlso: AX=1222h,INT 21/AH=59h
----------2F122E-----------------------------
INT 2F U - DOS 4+ internal - GET OR SET ERROR TABLE ADDRESSES
	AX = 122Eh
	DL = subfunction
	    00h get standard DOS error table (errors 00h-12h,50h-5Bh)
		Return: ES:DI -> error table
	    01h set standard DOS error table
		ES:DI -> error table
	    02h get parameter error table (errors 00h-0Ah)
		Return: ES:DI -> error table
	    03h set parameter error table
		ES:DI -> error table
	    04h get critical/SHARE error table (errors 13h-2Bh)
		Return: ES:DI -> error table
	    05h set critical/SHARE error table
		ES:DI -> error table
	    06h get ??? error table
		Return: ES:DI -> error table or 0000h:0000h
	    07h set ??? error table
		ES:DI -> error table
	    08h get error message retriever (see below)
		Return: ES:DI -> FAR procedure to fetch error message 
	    09h set ??? error table
		ES:DI -> error table
Notes:	if the returned segment on a "get" is 0001h, then the offset specifies
	  the offset of the error message table within COMMAND.COM, and the
	  procedure returned by DL=08h should be called
	DOS 5.0 COMMAND.COM does not allow setting any of the addresses; they
	  are always returned with segment 0001h
SeeAlso: AX=0500h,INT 21/AH=59h

Format of DOS 4.x error table:
Offset	Size	Description
 00h	BYTE	FFh
 01h  2 BYTEs	04h,00h (DOS version???)
 03h	BYTE	number of error headers following
 04h 2N WORDs	table of all error headers for table
		Offset	Size	Description
		 00h	WORD	error message number
		 02h	WORD	offset of error message from start of header
				error messages are count byte followed by msg
Note:	DOS 5 error tables consist of one word per error number; each word
	  contains either the offset of a counted string or 0000h

Call error retrieval function with:
	AX = error number
	DI = offset of error table
Return: ES:DI -> error message (counted string)
Notes:	this function needs to access COMMAND.COM if the messages were not
	  loaded into memory permanently with /MSG; the caller should assume
	  that the returned message will be overwritten by the next call of
	  the function
	supported by DR-DOS 5.0
----------2F122F-----------------------------
INT 2F U - DOS 4+ internal - SET DOS VERSION NUMBER TO RETURN
	AX = 122Fh
	DX = DOS version number (0000h = return true DOS version)
Note:	not available under DR-DOS 5.0
SeeAlso: INT 21/AH=30h
----------2F13-------------------------------
INT 2F U - DOS 3.2+ - SET DISK INTERRUPT HANDLER
	AH = 13h
	DS:DX -> interrupt handler disk driver calls on read/write
	ES:BX = address to restore INT 13 to on system halt (exit from root
		 shell) or warm boot (INT 19)
Return: DS:DX from previous invocation of this function
	ES:BX from previous invocation of this function
Notes:	IO.SYS hooks INT 13 and inserts one or more filters ahead of the
	  original INT 13 handler.  The first is for disk change detection
	  on floppy drives, the second is for tracking formatting calls and
	  correcting DMA boundary errors, the third is for working around
	  problems in a particular version of IBM's ROM BIOS
	before the first call, ES:BX points at the original BIOS INT 13; DS:DX
	  also points there unless IO.SYS has installed a special filter for
	  hard disk reads (on systems with model byte FCh and BIOS date
	  "01/10/84" only), in which case it points at the special filter
	most DOS 3.3+ disk access is via the vector in DS:DX, although a few
	  functions are still invoked via an INT 13 instruction
	this is a dangerous security loophole for any virus-monitoring software
	  which does not trap this call (many Bulgarian viruses are known to
	  use it to get the original ROM entry point)
SeeAlso: INT 13/AH=01h,INT 19
----------2F1400-----------------------------
INT 2F - NLSFUNC.COM - INSTALLATION CHECK
	AX = 1400h
Return: AL = 00h not installed, OK to install
	     01h not installed, not OK
	     FFh installed
Notes:	called by DOS v3.3+ kernel
	supported by OS/2 v1.3+ compatibility box, which always returns AL=FFh
	supported by DR-DOS 5.0
	documented for MS-DOS 5.0, but undocumented in prior versions
----------2F1401-----------------------------
INT 2F U - NLSFUNC.COM - CHANGE CODE PAGE
	AX = 1401h
	DS:SI -> internal code page structure (see below)
	BX = new code page
	DX = country code???
Return: AL = status
	     00h successful
	     else DOS error code
Note:	called by DOS v3.3+ kernel
SeeAlso: INT 21/AH=66h

Format of DOS 3.30 internal code page structure:
Offset	Size	Description
 00h  8 BYTEs	???
 08h 64 BYTEs	name of country information file
 48h	WORD	system code page
 4Ah	WORD	number of supported subfunctions
 4Ch  5 BYTEs	data to return for INT 21/AX=6502h
 51h  5 BYTEs	data to return for INT 21/AX=6504h
 56h  5 BYTEs	data to return for INT 21/AX=6505h
 5Bh  5 BYTEs	data to return for INT 21/AX=6506h
 60h 41 BYTEs	data to return for INT 21/AX=6501h
----------2F1402-----------------------------
INT 2F U - NLSFUNC.COM - GET COUNTRY INFO
	AX = 1402h
	BP = subfunction (same as AL for INT 21/AH=65h)
	BX = code page
	DX = country code
	DS:SI -> internal code page structure (see AX=1401h)
	ES:DI -> user buffer
	CX = size of user buffer
Return: AL = status
	    00h successful
	    else DOS error code
Notes:	called by DOS v3.3+ kernel on INT 21/AH=65h
	code page structure apparently only needed for COUNTRY.SYS pathname
SeeAlso: AX=1403h,AX=1404h,INT 21/AH=65h
----------2F1403-----------------------------
INT 2F U - NLSFUNC.COM - SET COUNTRY INFO
	AX = 1403h
	DS:SI -> internal code page structure (see AX=1401h)
	BX = code page
	DX = country code
Return: AL = status 
	     ???
Note:	called by DOS v3.3+ kernel on INT 21/AH=38h
SeeAlso: AX=1402h,AX=1404h,INT 21/AH=38h"SET"
----------2F1404-----------------------------
INT 2F U - NLSFUNC.COM - GET COUNTRY INFO
	AX = 1404h
	BX = code page
	DX = country code
	DS:SI -> internal code page structure (see AX=1401h)
	ES:DI -> user buffer
Return: AL = status
	     ???
Notes:	called by DOS v3.3+ kernel on INT 21/AH=38h
	code page structure apparently only needed for COUNTRY.SYS pathname
SeeAlso: AX=1402h,AX=1403h,INT 21/AH=38h"GET"
----------2F14FE-----------------------------
INT 2F U - DR-DOS 5.0 NLSFUNC - ???
	AX = 14FEh
	DI = ???
	???
Return: ???
Note:	DR-DOS 5.0 NLSFUNC returns CF set and AX=0001h if AL was not 00h, FEh,
	  or FFh on entry.
SeeAlso: AX=14FFh
----------2F14FF-----------------------------
INT 2F U - DR-DOS 5.0 NLSFUNC - ???
	AX = 14FFh
	???
Return: ???
Note:	DR-DOS 5.0 NLSFUNC returns CF set and AX=0001h if AL was not 00h, FEh,
	  or FFh on entry.
SeeAlso: AX=14FEh
----------2F1500-----------------------------
INT 2F - DOS 4.00 GRAPHICS.COM - INSTALLATION CHECK
	AX = 1500h
Return: AX = FFFFh
	ES:DI -> ??? (graphics data?)
Note:	this installation check conflicts with the CD-ROM Extensions
	  installation check; moved to AX=AC00h in later versions
SeeAlso: AX=AC00h
----------2F1500BX0000-----------------------
INT 2F - CD-ROM - INSTALLATION CHECK
	AX = 1500h
	BX = 0000h
Return: BX = number of CD-ROM drive letters used
	CX = starting drive letter (0=A:)
Notes:	this installation check DOES NOT follow the format used by other
	  software
	this installation check conflicts with the DOS 4.00 GRAPHICS.COM
	  installation check
SeeAlso: INT 2F/AX=D000h"Lotus"
----------2F1501-----------------------------
INT 2F - CD-ROM - GET DRIVE DEVICE LIST
	AX = 1501h
	ES:BX -> buffer to hold drive letter list (5 bytes per drive letter)
Return: buffer filled, for each drive letter
	  BYTE	subunit number in driver
	  DWORD address of device driver header
----------2F1502-----------------------------
INT 2F - CD-ROM - GET COPYRIGHT FILE NAME
	AX = 1502h
	ES:BX -> 38-byte buffer for name of copyright file
	CX = drive number (0=A:)
Return: CF set if drive is not a CD-ROM drive
	    AX = 15 (invalid drive)
	CF clear if successful
SeeAlso: AX=1503h
----------2F1503-----------------------------
INT 2F - CD-ROM - GET ABSTRACT FILE NAME
	AX = 1503h
	ES:BX -> 38-byte buffer for name of abstract file
	CX = drive number (0=A:)
Return: CF set if drive is not a CD-ROM drive
	    AX = 15 (invalid drive)
	CF clear if successful
SeeAlso: AX=1502h
----------2F1504-----------------------------
INT 2F - CD-ROM - GET BIBLIOGRAPHIC DOC FILE NAME
	AX = 1504h
	ES:BX -> 38-byte buffer for name of bibliographic documentation file
	CX = drive number (0=A:)
Return: CF set if drive is not a CD-ROM drive
	    AX = 15 (invalid drive)
	CF clear if successful
----------2F1505-----------------------------
INT 2F - CD-ROM - READ VTOC
	AX = 1505h
	ES:BX -> 2048-byte buffer
	CX = drive number (0=A:)
	DX = sector index (0=first volume descriptor,1=second,...)
Return: CF set on error
	    AX = error code (15=invalid drive,21=not ready)
	CF clear if successful
	    AX = volume descriptor type (1=standard,FFh=terminator,0=other)
----------2F1506-----------------------------
INT 2F - CD-ROM - TURN DEBUGGING ON
	AX = 1506h
	BX = debugging function to enable
Note:	reserved for development
SeeAlso: AX=1507h
----------2F1507-----------------------------
INT 2F - CD-ROM - TURN DEBUGGING OFF
	AX = 1507h
	BX = debugging function to disable
Note:	reserved for development
SeeAlso: AX=1506h
----------2F1508-----------------------------
INT 2F - CD-ROM - ABSOLUTE DISK READ
	AX = 1508h
	ES:BX -> buffer
	CX = drive number (0=A:)
	SI:DI = starting sector number
	DX = number of sectors to read
Return: CF set on error
	    AL = error code (15=invalid drive,21=not ready)
	CF clear if successful
SeeAlso: AX=1509h
----------2F1509-----------------------------
INT 2F - CD-ROM - ABSOLUTE DISK WRITE
	AX = 1509h
	ES:BX -> buffer
	CX = drive number (0=A:)
	SI:DI = starting sector number
	DX = number of sectors to write
Note:	corresponds to INT 26h and is currently reserved and nonfunctional
SeeAlso: AX=1508h
----------2F150A-----------------------------
INT 2F - CD-ROM - RESERVED
	AX = 150Ah
----------2F150B-----------------------------
INT 2F - CD-ROM v2.00+ - DRIVE CHECK
	AX = 150Bh
	CX = drive number (0=A:)
Return: BX = ADADh if MSCDEX.EXE installed
	    AX = 0000h if drive not supported
		nonzero if supported
SeeAlso: AX=150Dh
----------2F150C-----------------------------
INT 2F - CD-ROM v2.00+ - GET MSCDEX.EXE VERSION
	AX = 150Ch
Return: BH = major version
	BL = minor version
Note:	MSCDEX.EXE versions prior to 2.00 return BX=0
----------2F150D-----------------------------
INT 2F - CD-ROM v2.00+ - GET CD-ROM DRIVE LETTERS
	AX = 150Dh
	ES:BX -> buffer for drive letter list (1 byte per drive)
Return: buffer filled with drive numbers (0=A:).  Each byte corresponds
	to the drive in the same position for function 1501h
SeeAlso: AX=150Bh
----------2F150E-----------------------------
INT 2F - CD-ROM v2.00+ - GET/SET VOLUME DESCRIPTOR PREFERENCE
	AX = 150Eh
	BX = subfunction
	    00h get preference
		DX = 0000h
		Return: DX = preference settings
	    01h set preference
		DH = volume descriptor preference
		    01h = primary volume descriptor
		    02h = supplementary volume descriptor
		DL = supplementary volume descriptor preference
		    01h = shift-Kanji
	CX = drive number (0=A:)
Return: CF set on error
	    AX = error code (15=invalid drive,1=invalid function)
	CF clear if successful
----------2F150F-----------------------------
INT 2F - CD-ROM v2.00+ - GET DIRECTORY ENTRY
	AX = 150Fh
	CL = drive number (0=A:)
	CH bit 0 = copy flag
		clear if direct copy
		set if copy to structure which removed ISO/High Sierra diffs
	ES:BX -> ASCIZ path name
	SI:DI -> buffer for directory entry (see below)
		 minimum 255 bytes for direct copy
Return: CF set on error
	    AX = error code
	CF clear if succesful
	    AX = disk format (0=High Sierra,1=ISO 9660)

Format of directory entry (direct copy):
Offset	Size	Description
 00h	BYTE  length of directory entry
 01h	BYTE  length of XAR in Logical Block Numbers
 02h	DWORD LBN of data, Intel (little-endian) format
 06h	DWORD LBN of data, Motorola (big-endian) format
 0Ah	DWORD length of file, Intel format
 0Eh	DWORD length of file, Motorola format
---High Sierra---
 12h  6 BYTEs date and time
 18h	BYTE  bit flags
 19h	BYTE  reserved
---ISO 9660---
 12h  7 BYTEs date and time
 19h	BYTE  bit flags
---both formats---
 1Ah	BYTE  interleave size
 1Bh	BYTE  interleave skip factor
 1Ch	WORD  volume set sequence number, Intel format
 1Eh	WORD  volume set sequence number, Motorola format
 20h	BYTE  length of file name
 21h  N BYTEs file name
	BYTE (optional) padding if filename is odd length
      N BYTEs system data

Format of directory entry (canonicalized):
Offset	Size	Description
 00h	BYTE	length of XAR in Logical Block Numbers
 01h	DWORD	Logical Block Number of file start
 05h	WORD	size of disk in logical blocks
 07h	DWORD	file length in bytes
 0Bh  7 BYTEs	date and time
 12h	BYTE	bit flags
 13h	BYTE	interleave size
 14h	BYTE	interleave skip factor
 15h	WORD	volume set sequence number
 17h	BYTE	length of file name
 18h 38 BYTEs	ASCIZ filename
 3Eh	WORD	file version number
 40h	BYTE	number of bytes of system use data
 41h 220 BYTEs	system use data
----------2F1510-----------------------------
INT 2F - CD-ROM v2.10+ - SEND DEVICE DRIVER REQUEST
	AX = 1510h
	CX = CD-ROM drive letter (0 = A, 1 = B, etc)
	ES:BX -> CD-ROM device driver request header (see AX=0802h)
----------2F1600-----------------------------
INT 2F - MS WINDOWS - WINDOWS ENHANCED MODE INSTALLATION CHECK
	AX = 1600h
Return: AL = 00h if Windows 3.x enhanced mode or Windows/386 2.x not running
	AL = 80h if Windows 3.x enhanced mode or Windows/386 2.x not running
	AL = 01h if Windows/386 2.x running
	AL = FFh if Windows/386 2.x running
	AL = anything else
	    AL = Windows major version number >= 3
	    AH = Windows minor version number
Note:	INT 2F/AH=16h comprises an API for non-Windows programs (DOS device
	  drivers, TSRs, and applications) to cooperate with multitasking
	  Windows/386 2.x and Windows 3.x and higher enhanced mode.
	certain calls are also supported in the Microsoft 80286 DOS extender in
	  Windows standard mode
SeeAlso: AX=4680h
----------2F1602-----------------------------
INT 2F - MS WINDOWS/386 2.x - GET API ENTRY POINT
	AX = 1602h
Return: ES:DI -> Windows/386 2.x API procedure entry point
Notes:	this interface is supported in Windows 3.x only for 2.x compatibility
	to get the current virtual machine (VM) ID in Windows/386 2.x:
	    AX = 0000h
	    ES:DI -> return address
	    JUMP to address returned from INT 2F/AX=1602h
	After JUMP, at return address:
	    BX = current VM ID.
SeeAlso: AX=0C20h
----------2F1603-----------------------------
INT 2F - RM Nimbus MSDOS 3.3 - ???
	AX = 1603h
Return: AX = 5248h ('RH')
	DS:SI -> first byte after INT 2F handler in IBMBIO.COM
----------2F1605-----------------------------
INT 2F - MS WINDOWS - WINDOWS ENH MODE & 286 DOSX INIT BROADCAST
	AX = 1605h
	ES:BX = 0000h:0000h
	DS:SI = 0000h:0000h
	CX = 0000h
	DX = flags
	    bit 0 = 0 if Windows enhanced-mode initialization
	    bit 0 = 1 if Microsoft 286 DOS extender initialization
	    bits 1-15 reserved (undefined)
	DI = version number (major in upper byte, minor in lower)
Return: CX = 0000h if okay for Windows to load
	CX <> 0 if Windows should not load
	ES:BX -> startup info structure (see below)
	DS:SI -> virtual86 mode enable/disable callback or 0000h:0000h
Notes:	the Windows enhanced mode loader and Microsoft 286 DOS extender will
	  broadcast an INT 2F/AX=1605h call when initializing.	Any DOS device
	  driver or TSR can watch for this broadcast and return the appropriate
	  values.  If the driver or TSR returns CX <> 0, it is also its
	  responsibility to display an error message.
	each handler must first chain to the prior INT 2F handler with
	  registers unchanged before processing the call
	if the handler requires local data on a per-VM basis, it must store the
	  returned ES:BX in the "next" field of a startup info structure and
	  return a pointer to that structure in ES:BX
	a single TSR may set the V86 mode enable/disable callback; if DS:SI is
	  already nonzero, the TSR must fail the initialization by setting CX
	  nonzero
SeeAlso: AX=1606h,AX=1608h,AX=4B05h

Format of Startup Information Structure:
Offset	Size	Description
 00h  2 BYTEs	major, minor version of info structure
 02h	DWORD	pointer to next startup info structure or 0000h:0000h
 06h	DWORD	pointer to ASCIZ name of virtual device file or 0000h:0000h
 0Ah	DWORD	virtual device reference data (only used if above nonzero)
 0Eh	DWORD	pointer to instance data records or 0000h:0000h

Format of one Instance Item in array:
Offset	Size	Description
 00h	DWORD	address of instance data (end of array if 0000h:0000h)
 04h	WORD	size of instance data

Virtual mode enable/disable procedure called with:
	AX = 0000h disable V86 mode
	AX = 0001h enable V86 mode
	interrupts disabled
Return: CF set on error
	CF clear if successful
	interrupts disabled
----------2F1606-----------------------------
INT 2F - MS WINDOWS - WINDOWS ENH MODE & 286 DOSX EXIT BROADCAST
	AX = 1606h
	DX = flags
	    bit 0 = 0 if Windows enhanced-mode exit
	    bit 0 = 1 if Microsoft 286 DOS extender exit
	    bits 1-15 reserved (undefined)
Notes:	if the init broadcast fails (AX=1605h returned CX <> 0), then this
	  broadcast will be issued immediately.
	this call will be issued in real mode
SeeAlso: AX=1605h,AX=1609h
----------2F1607-----------------------------
INT 2F - MS WINDOWS - VIRTUAL DEVICE CALL OUT API
	AX = 1607h
	BX = virtual device ID (see INT 2F/AX=1684h)
Notes:	more of a convention than an API, this call specifies a standard
	  mechanism for Windows enhanced-mode virtual devices (VxD's) to talk
	  to DOS device drivers and TSRs
	VNETBIOS calls this function and then checks ES:DI to determine whether
	  the NetBIOS has any extensions Windows should know about
	VMD (Virtual Mouse Driver) calls this and then checks whether CX is
	  nonzero; if yes, it will not automatically virtualize the mouse
	  driver.  This would be used if MOUSE.COM already virtualizes
	  itself using the Windows API.
SeeAlso: AX=0C20h,AX=1605h,AX=1684h
----------2F1607BX0015-----------------------
INT 2F - DOS 5.0 kernel - "DOSMGR" VIRTUAL DEVICE SUPPORT
	AX = 1607h
	BX = 0015h (VxD identifier of "DOSMGR")
	CX = function
	    0000h ???
	    	Return: CX = 0001h
			ES:BX -> ??? data
	    0001h ???
	    	DX = ???
		Return: AX = B97Ch
			BX = value of DX on call
			DX = A2ABh
	    0002h NOP
	    0003h ???
	    	DX = ??? (bit 0 significant)
		Return: if DX bit 0 set:
				AX = B97Ch
				CX = ??? (0058h)
				DX = A2ABh
			if DX bit 0 clear:
				all registers preserved
	    0004h ???
	    	Return: DX = 0000h
	    0005h get device driver size
	    	ES = segment of device driver
		Return: DX:AX = 0000h:0000h on error (not dev. driver segment)
			DX:AX = A2ABh:B97Ch if successful
			    BX:CX = size of device driver in bytes
----------2F1608-----------------------------
INT 2F - MS WINDOWS - WINDOWS ENHANCED MODE INIT COMPLETE BROADCAST
	AX = 1608h
Notes:	called after all installable devices have been initialized
	real-mode software may be called between the Windows enhanced-mode init
	  call (AX=1605h) and this call; the software must detect this
	  situation
SeeAlso: AX=1605h,AX=1609h
----------2F1609-----------------------------
INT 2F - MS WINDOWS - WINDOWS ENHANCED MODE BEGIN EXIT BROADCAST
	AX = 1609h
Note:	called at the beginning of a normal exit sequence; not made in the
	  event of a fatal system crash
SeeAlso: AX=1606h,AX=1608h
----------2F160A-----------------------------
INT 2F - MS Windows 3.1 - IDENTIFY WINDOWS VERSION AND TYPE
	AX = 160Ah
	???
Return: ???
----------2F160B-----------------------------
INT 2F - MS Windows 3.1 - IDENTIFY TSRs
	AX = 160Bh
	???
Return: ???

Format of TSR-to-Windows communication structure:
Offset	Size	Description
 00h	DWORD	pointer to next structure
 04h	WORD	PSP segment
 06h	WORD	API version ID (0100h)
 08h	WORD	EXEC flags
 		bit 0: "WINEXEC"
		bit 1: "LOADLIBRARY"
		bit 2: "OPENDRIVER"
 0Ah	WORD	"exec_cmd_show"
 0Ch	DWORD	"exec_cmd"
 10h  4 BYTEs	reserved (0)
 14h	DWORD	TSR ID block
 18h	DWORD	TSR data block
----------2F160C-----------------------------
INT 2F - MS Windows 3.1 - DETECT ROMs
	AX = 160Ch
	???
Return: ???
Note:	used by ROM Windows
----------2F1680-----------------------------
INT 2F - MS WINDOWS, DPMI, various - RELEASE CURRENT VIRTUAL MACHINE TIME-SLICE
	AX = 1680h
Return: AL = 00h if the call is supported
	AL = 80h (unchanged) if the call is not supported
Notes:	programs can use this function in idle loops to enhance performance
	  under multitaskers; this call is supported by MS Windows 3.0, DOS 5+,
	  DPMI 1.0+, and will be supported in OS/2 2.0 for multitasking DOS
	  applications
	does not block the program; it just gives up the remainder of the time
	  slice
	should not be used by Windows-specific programs
SeeAlso: INT 15/AX=1000h
----------2F1681-----------------------------
INT 2F - MS WINDOWS 3+ - BEGIN CRITICAL SECTION
	AX = 1681h
Notes:	used to prevent a task switch from occurring
	should be followed by an INT 2F/AX=1682h call as soon as possible
	nested calls are allowed, and must be followed by an appropriate number
	  of "end critical section" calls
	not supported in Windows/386 2.x. Get INDOS flag with INT 21/AH=34h and
	  and increment by hand.
SeeAlso: AX=1682h,INT 15/AX=101Bh,INT 21/AH=34h
----------2F1682-----------------------------
INT 2F - MS WINDOWS 3+ - END CRITICAL SECTION
	AX = 1682h
Notes:	not supported in Windows/386 2.x.  Get InDOS flag with INT 21/AH=34h
	  and decrement by hand, taking care not to decrement InDOS flag
	  through zero
SeeAlso: AX=1681h,INT 15/AX=101Ch,INT 21/AH=34h
----------2F1683-----------------------------
INT 2F - MS WINDOWS 3+ - GET CURRENT VIRTUAL MACHINE ID
	AX = 1683h
Return: BX = current virtual machine (VM) ID
Notes:	Windows itself currently runs in VM 1, but this can't be relied upon
	VM IDs are reused when VMs are destroyed
	an ID of 0 will never be returned
SeeAlso: AX=1684h,AX=1685h,AX=168Bh
----------2F1684-----------------------------
INT 2F - MS WINDOWS - GET DEVICE API ENTRY POINT
	AX = 1684h
	BX = virtual device (VxD) ID (see below)
	ES:DI = 0000h:0000h
Return: ES:DI -> VxD API entry point, or 0:0 if the VxD does not support an API
Note:	some Windows enhanced-mode virtual devices provide services that
	  applications can access.  For example, the Virtual Display Device
	  (VDD) provides an API used in turn by WINOLDAP.
SeeAlso: AX=1683h

Values for VxD ID:
 01h	VMM		Virtual Machine Manager
 02h	Debug
 03h	VPICD		Virtual Prog. Interrupt Controller (PIC) Device
 04h	VDMAD		Virtual Direct Memory Access (DMA) Device
 05h	VTD		Virtual Timer Device
 06h	V86MMGR		Virtual 8086 Mode Device
 07h	PAGESWAP	Paging Device
 08h	Parity
 09h	Reboot
 0Ah	VDD		Virtual Display Device (GRABBER)
 0Bh	VSD		Virtual Sound Device
 0Ch	VMD		Virtual Mouse Device
 0Dh	VKD		Virtual Keyboard Device
 0Eh	VCD		Virtual COMM Device
 0Fh	VPD		Virtual Printer Device
 10h	VHD		Virtual Hard Disk Device
 11h	VMCPD
 12h	EBIOS		Reserve EBIOS page (e.g., on PS/2)
 13h	BIOSXLAT	Map ROM BIOS API between prot & V86 mode
 14h	VNETBIOS	Virtual NetBIOS Device
 15h	DOSMGR
 16h	WINLOAD
 17h	SHELL
 18h	VMPoll
 19h	VPROD
 1Ah	DOSNET		assures network integrity across VMs
 1Bh	VFD		Virtual Floppy Device
 1Ch	VDD2		Secondary display adapter
 1Dh	WINDEBUG
 1Eh	TSRLoad		TSR instance utility
Note:	The high bit of the VxD ID is reserved for future use. The
	next 10 bits are the OEM # which is assigned by Microsoft. The
	low 5 bits are the device number. 

Call VTD.386 entry point with:
	AX = 0000h get VTD version number
	    Return: AH = major version
	    	    AL = minor version
	AX = 0100h get current clock tick time
	    Return: EDX:EAX = clock tick time in 840ns units since Windows was
	    			started
	AX = 0101h get current system time in milliseconds
	    Return: EAX = time in milliseconds that Windows has been running
	AX = 0102h get current virtual machine time
	    Return: EAX = cumulative amount of time the virtual machine has
	    		been active, in milliseconds
Note:	should only be called directly when TOOLHELP.DLL TimerCount() cannot
	  be called
----------2F1685-----------------------------
INT 2F - MS WINDOWS - SWITCH VMs AND CALLBACK
	AX = 1685h
	BX = VM ID of virtual machine to switch to
	CX = flags
		bit 0 wait until interrupts enabled
		bit 1 wait until critical section unowned
		bits 2-15 reserved (zero)
	DX:SI = priority boost (see VMM.INC)
	ES:DI -> FAR procedure to callback
Return: CF set on error
	    AX = error code
		01h invalid VM ID
		02h invalid priority boost
		03h invalid flags
	CF clear if successful
	    event will be or has been called
Notes:	some DOS devices, such as networks, need to call functions in a
	  specific VM. This call forces the appropriate VM to be installed.
	the callback procedure must preserve all registers and return with IRET
SeeAlso: AX=1683h,INT 15/AX=1117h
----------2F1686-----------------------------
INT 2F - DOS Protected-Mode Interface - DETECT MODE
	AX = 1686h
Return: AX = 0000h if operating in protected mode under DPMI (INT 31 available)
	AX nonzero if in real/V86 mode or no DPMI (INT 31 not available)
SeeAlso: AX=1687h
----------2F1687-----------------------------
INT 2F - DOS Protected-Mode Interface - INSTALLATION CHECK
	AX = 1687h
Return: AX = 0000h if installed
	    BX = flags
		bit 0: 32-bit programs supported
	    CL = processor type (02h=80286, 03h=80386, 04h=80486)
	    DH = DPMI major version
	    DL = two-digit DPMI minor version
	    SI = number of paragraphs of DOS extender private data
	    ES:DI -> DPMI mode-switch entry point
	AX nonzero if not installed
SeeAlso: AX=1686h

Call mode switch entry point with:
	AX = flags
	    bit 0: set if 32-bit program
	ES = real mode segment of buffer for DPMI private data (ignored if
		SI was zero)
Return: CF set on error
	    program still in real mode
	    AX = error code (DPMI 1.0+)
	       8011h unable to allocate all necessary descriptors
	       8021h 32-bit program specified, but 16-bit DPMI host
	CF clear if successful
	    CS = 16-bit selector corresponding to real-mode CS
	    SS = selector corresponding to real-mode SS (64K limit)
	    DS = selector corresponding to real-mode DS (64K limit)
	    ES = selector to program's PSP (100h byte limit)
	    FS = GS = 0
	    high word of ESP = 0 if 32-bit program
	    program now in protected mode
Note:	this entry point is only called for the initial switch to protected
	  mode
----------2F1688-----------------------------
INT 2F U - MS Windows 3.0, 386MAX v6.01 - GET SELECTOR TO LDT
	AX = 1688h
Return: AX = status??? (0000h for 386MAX)
	BX = selector for ???
----------2F1689-----------------------------
INT 2F U - MS Windows 3.0+ - KERNEL IDLE CALL
	AX = 1689h
	???
Return: ???
----------2F168A-----------------------------
INT 2F - DPMI 0.9+ - GET VENDOR-SPECIFIC API ENTRY POINT
	AX = 168Ah
	DS:(E)SI = selector:offset of ASCIZ vendor name
Return: AL = status
	    00h successful
	       ES:(E)DI -> extended API entry point
	    8Ah unsuccessful
Notes:	the vendor name is used to determine which entry point to return; it is
	  case-sensitive
	available in protected mode only
	32-bit applications use ESI and EDI, 16-bit applications use SI and DI
	this call is present but not documented for DPMI 0.9
SeeAlso: INT 31/AX=0A00h

Vendor names:
 "MS-DOS"	??? and 386MAX v6.00+
 "386MAX"	386MAX v6.00+
----------2F168B-----------------------------
INT 2F - MS Windows 3.1 - SET FOCUS TO SPECIFIED VIRTUAL MACHINE
	AX = 168Bh
	???
Return: ???
SeeAlso: AX=1683h
----------2F168C-----------------------------
INT 2F - MS Windows 3.1 - RESTART COMMAND
	AX = 168Ch
	???
Return: ???
Note:	WIN.COM executes specified application
----------2F1700-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - IDENTIFY WinOldAp VERSION
	AX = 1700h
Return: AX = 1700h if this version of WINOLDAP doesn't support clipboard
	AX <> 1700h
		AL = WINOLDAP major version
		AH = WINOLDAP minor version
Notes:	WinOldAp (WINOLDAP.MOD) is a Microsoft Windows extension supporting
	  "old" (character-mode) application access to Dynamic Data Exchange,
	  menus, and the Windows clipboard.
	this installation check DOES NOT follow the format used by other
	  software
----------2F1701-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - OPEN CLIPBOARD
	AX = 1701h
Return:	AX <> 0	 success
	AX = 0	 clipboard is already open
----------2F1702-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - EMPTY CLIPBOARD
	AX = 1702h
Return: AX <> 0	 clipboard has been emptied
	AX = 0	 failure
----------2F1703-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - SET CLIPBOARD DATA
	AX = 1703h
	DX = clipboard format supported by WinOldAp:
		01h text
		02h bitmap
		03h metafile picture
		04h SYLK
		05h DIF
		06h TIFF
		07h OEM text
	ES:BX -> data (see below for formats)
	SI:CX = size of data
Return: AX <> 0 data copied into the Clipboard
	AX = 0 failure

Format of bitmap:
Offset	Size	Description
 00h	WORD	type (0000h)
 02h	WORD	width of bitmap in pixels
 04h	WORD	height of bitmap in pixels
 06h	WORD	bytes per line
 08h	BYTE	number of color planes
 09h	BYTE	number of adjacent color bits in pixel
 0Ah	DWORD	pointer to start of data
 0Eh	WORD	width in 0.1mm units
 10h	WORD	height in 0.1mm units
 12h  N BYTEs	bitmap data

Format of metafile picture:
Offset	Size	Description
 00h	WORD	mapping mode
 02h	WORD	X extent
 04h	WORD	Y extent
 06h	WORD	picture data
----------2F1704-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - GET CLIPBOARD DATA SIZE
	AX = 1704h
	DX = clipboard format supported by WinOldAp (see AX=1703h)
Return:	 DX:AX = size of data in bytes, including any headers
Failure: DX:AX = 0  no data in this format in the Clipboard
----------2F1705-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - GET CLIPBOARD DATA
	AX = 1705h
	DX = clipboard format supported by WinOldAp (see AX=1703h)
	ES:BX -> buffer
Return: AX <> 0	 success
	AX = 0	 error, or no data in this format in Clipboard
----------2F1708-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - CloseClipboard
	AX = 1708h
Return: AX <> 0 success
	AX = 0 failure
----------2F1709-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - COMPACT CLIPBOARD
	AX = 1709h
	SI:CX = desired size in bytes
Return: DX:AX = number of bytes in largest block of free memory
Note:	WinOldAp is responsible for including the size of any headers
----------2F170A-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - GET DEVICE CAPABILITIES
	AX = 170Ah
	DX = GDI information index
	    00h device driver version
	    02h device classification
	    04h width in mm
	    06h height in mm
	    08h width in pixels
	    0Ah height in pixels
	    0Ch bits per pixel
	    0Eh number of bit planes
	    10h number of brushes supported by device
	    12h number of pens supported by device
	    14h number of markers supported by device
	    16h number of fonts supported by device
	    18h number of colors
	    1Ah size required for device descriptor
	    1Ch curve capabilities
	    1Eh line capabilities
	    20h polygon capabilities
	    22h text capabilities
	    24h clipping capabilities
	    26h bitblt capabilities
	    28h X aspect
	    2Ah Y aspect
	    2Ch length of hypotenuse of aspect
	    58h logical pixels per inch of width
	    5Ah logical pixels per inch of height
Return:	 AX = integer value of the desired item
		device classification
		    00h vector plotter
		    01h raster display
		    02h raster printer
		    03h raster camera
		    04h character-stream, PLP
		    05h Metafile, VDM
		    06h display-file
		curve capabilities
		    bit 0  circles
		    bit 1  pie wedges
		    bit 2  chord arcs
		    bit 3  ellipses
		    bit 4  wide lines
		    bit 5  styled lines
		    bit 6  wide styled lines
		    bit 7  interiors
		line capabilities
		    bit 1  polylines
		    bit 2  markers
		    bit 3  polymarkers
		    bit 4  wide lines
		    bit 5  styled lines
		    bit 6  wide styled lines
		    bit 7  interiors
		polygon capabilities
		    bit 0  polygons
		    bit 1  rectangles
		    bit 2  trapezoids
		    bit 3  scanlines
		    bit 4  wide borders
		    bit 5  styled borders
		    bit 6  wide styled borders
		    bit 7  interiors
		text capabilities
		    bit 0  output precision character
		    bit 1  output precision stroke
		    bit 2  clippping precision stroke
		    bit 3  90-degree character rotation
		    bit 4  arbitrary character rotation
		    bit 5  independent X and Y scaling
		    bit 6  double-size
		    bit 7  integer scaling
		    bit 8  continuous scaling
		    bit 9  bold
		    bit 10 italic
		    bit 11 underline
		    bit 12 strikeout
		    bit 13 raster fonts
		    bit 14 vector fonts
		    bit 15 reserved
		clipping capabilities
		    00h none
		    01h clipping to rectangles
		raster capabilities
		    bit 0  simple bitBLT
		    bit 1  device requires banding support
		    bit 2  device requires scaling support
		    bit 3  supports >64K bitmap
Note:  This function returns the device-capability bits for the given display
----------2F1900-----------------------------
INT 2F U - DOS 4.x only SHELLB.COM - INSTALLATION CHECK
	AX = 1900h
Return: AL = 00h  not installed
	     FFh  installed
----------2F1901BL00-------------------------
INT 2F U - DOS 4.x only SHELLB.COM - SHELLC.EXE INTERFACE
	AX = 1901h
	BL = 00h if SHELLC transient
	     01h if SHELLC resident
	DS:DX -> far call entry point for resident SHELLC.EXE
Return: ES:DI -> SHELLC.EXE workspace within SHELLB.COM
Note:	SHELLB.COM and SHELLC.EXE are parts of the DOS 4.x shell
----------2F1902-----------------------------
INT 2F U - DOS 4.x only SHELLB.COM - COMMAND.COM INTERFACE
	AX = 1902h
	ES:DI -> ASCIZ full filename of current batch file, with at least the
		 final filename element uppercased
	DS:DX -> buffer for results
Return: AL = 00h  failed, either
		  (a) final filename element quoted at ES:DI does not match
		      identity of shell batch file quoted as parameter of most
		      recent call of SHELLB command, or
		  (b) no more Program Start Commands available.
	AL= FFh	 success, then:
		memory at DS:[DX+1] onwards filled as:
		DX+1:	BYTE	count of bytes of PSC
		DX+2: N BYTEs	Program Start Command text
			BYTE	0Dh terminator 
Explanation: COMMAND.COM executes the result of this call in preference to 
	reading a command from a batch file. Thus the batch file does not
	advance in execution for so long as SHELLB provides PSCs from its
	workspace. The PSCs are planted in SHELLB workspace by SHELLC, the user
	menu interface. The final PSC of a sequence is finished with a 
	GOTO COMMON, which causes a loop back in the batch file which called
	SHELLC so as to execute SHELLC again. The check on batch file name
	permits PSCs to CALL nested batch files while PSCs are still stacked
	up for subsequent execution.
----------2F1903-----------------------------
INT 2F U - DOS 4.x only SHELLB.COM - COMMAND.COM interface
	AX = 1903h
	ES:DI -> ASCIZ batch file name as for AX=1902h
Return: AL = FFh if quoted batch file name matches last SHELLB parameter
	AL = 00h if it does not
----------2F1904-----------------------------
INT 2F U - DOS 4.x only SHELLB.COM - SHELLB transient to TSR intrface
	AX = 1904h
Return: ES:DI -> name of current shell batch file:
		WORD	number of bytes of name following
		BYTEs	(8 max) uppercase name of shell batch file
----------2F1A00-----------------------------
INT 2F - DOS 4+ ANSI.SYS - INSTALLATION CHECK
	AX = 1A00h
Return: AL = FFh if installed
Notes:	AVATAR.SYS also responds to this call
	documented for DOS 5+, but undocumented for DOS 4.x
----------2F1A00BX4156-----------------------
INT 2F - AVATAR.SYS - INSTALLATION CHECK
	AX = 1A00h
	BX = 4156h ('AV')
	CX = 4154h ('AT')
	DX = 4152h ('AR')
Return: AL = FFh if installed
	    CF clear
	    BX = AVATAR protocol level supported
	    CX = driver type
		0000h AVATAR.SYS
		4456h DVAVATAR.COM inside DESQview window
	    DX = 0016h
Notes:	AVATAR also identifies itself as ANSI.SYS if BX, CX, or DX differ from
	  the magic values
	AVATAR.SYS is a CON replacement by George Adam Stanislav which
	  interprets AVATAR command codes in the same way that ANSI interprets
	  ANSI command codes
----------2F1A01-----------------------------
INT 2F U - DOS 4+ ANSI.SYS internal - GET/SET DISPLAY INFORMATION
	AX = 1A01h
	CL = function
	    7Fh for GET
	    5Fh for SET
	DS:DX -> parm block as for INT 21,AX=440Ch,CX=037Fh/035Fh respectively
Return: CF set on error
	    AX = error code (many non-standard)
	CF clear if successful
	    AX destroyed
Note:	presumably this is the DOS IOCTL interface to ANSI.SYS
SeeAlso: AX=1A02h,INT 21/AX=440Ch
----------2F1A02-----------------------------
INT 2F U - DOS 4+ ANSI.SYS internal - MISCELLANEOUS REQUESTS
	AX = 1A02h
	DS:DX -> parameter block (see below)
Note:	DOS 5.0 chains to previous handler if AL > 02h on call
SeeAlso: AX=1A01h

Format of parameter block:
Offset	Size	Description
 00h	BYTE	subfunction
		00h set/reset interlock
		01h get /L flag
 01h	BYTE	interlock state
		00h=reset, 01h=set
		  This interlock prevents some of the ANSI.SYS post-processing
		  in its hook onto INT 10, AH=00h mode set
 02h	BYTE	(returned)
		00h if /L not in effect
		01h if /L in effect
----------2F1A21-----------------------------
INT 2F - AVATAR.SYS - SET DRIVER STATE
	AX = 1A21h (AL='!')
	DS:SI -> command string with one or more state characters
	CX = length of command string
Return: CF set on error (invalid subfunction)
	CF clear if successful
Note:	the characters in the state string are interpreted left to right, and
	  need not be in any particular order
SeeAlso: AX=1A3Fh

Values of state characters:
 'a'	activate driver
 'd'	disable driver
 'f'	use fast screen output
 'g'	always convert gray keys (+ and -) to function keys
 'G'	never convert gray keys
 'l'	convert gray keys only when ScrollLock active
 's'	use slow screen output
 't'	Tandy 1000 keyboard (not yet implemented)
----------2F1A3C-----------------------------
INT 2F U - AVATAR.SYS v0.11 - ???
	AX = 1A3Ch
	???
Return: CX = 0000h
----------2F1A3E-----------------------------
INT 2F U - AVATAR.SYS v0.11 - ???
	AX = 1A3Eh
	CL = ???
	CH = ???
	DL = ???
	DH = ???
Return: CL = ???
	CH = ???
	DL = ???
	DH = ???
----------2F1A3F-----------------------------
INT 2F - AVATAR.SYS - QUERY DRIVER STATE
	AX = 1A3Fh (AL='?')
	ES:DI -> buffer
	CX = length of buffer in bytes
Return: CF clear
	CX = actual size of returned info
Note:	the returned information consists of multiple letters whose meanings
	  are described under AX=1A21h
SeeAlso: AX=1A21h
----------2F1A42BX4156-----------------------
INT 2F - AVATAR Serial Dispatcher - INSTALL IRQ3 HANDLER
	AX = 1A42h
	BX = 4156h ('AV')
	ES:DI -> FAR handler for serial port using IRQ3
	DS = data segment needed by handler
Return: AX = 1A42h if ASD not installed
	   = 0000h if no more room
	   else handle to use when uninstalling
Notes:	the handler need not save/restore registers or signal EOI to the
	  interrupt controller
	the handler should return AX=0000h if the interrupt was meant for it,
	  and either leave AX unchanged or return a non-zero value otherwise
	the most recently installed handler will be called first, continuing
	  to earlier handlers until one returns AX=0000h
SeeAlso: AX=1A43h,AX=1A62h
----------2F1A43BX4156-----------------------
INT 2F - AVATAR Serial Dispatcher - INSTALL IRQ4 HANDLER
	AX = 1A43h
	BX = 4156h ('AV')
	ES:DI -> FAR handler for serial port using IRQ4
	DS = data segment needed by handler
Return: AX = 1A43h if ASD not installed
	   = 0000h if no more room
	   else handle to use when uninstalling
Notes:	(see AX=1A42h)
SeeAlso: AX=1A42h,AX=1A63h
----------2F1A44BX4156-----------------------
INT 2F - AVATAR.SYS v0.11+ - GET DATA SEGMENT
	AX = 1A44h
	BX = 4156h ('AV')
Return: AX = 0000h
	DS = data segment
	CX = size of data segment
Note:	AVATAR.SYS calls this function whenever it is invoked.	If each
	  process under a multitasker hooks this function and provides a
	  separate data segment, AVATAR.SYS becomes fully reentrant.
SeeAlso: AX=1A21h,AX=1A3Fh
----------2F1A52-----------------------------
INT 2F U - AVATAR.SYS v0.11 - GET ???
	AX = 1A52h
	CX = size of buffer
	ES:DI -> buffer
Return: ??? copied into user buffer
Note:	the maximum size of the data which may be copied is returned by
	  AX=1A72h
SeeAlso: AX=1A72h
----------2F1A53-----------------------------
INT 2F U - AVATAR.SYS v0.11 - ???
	AX = 1A53h
	CL = ??? (00h-05h)
	???
Return: ???
----------2F1A62BX4156-----------------------
INT 2F - AVATAR Serial Dispatcher - UNINSTALL IRQ3 HANDLER
	AX = 1A62h
	BX = 4156h ('AV')
	CX = handle for IRQ routine returned by AX=1A42h
SeeAlso: AX=1A42h,AX=1A63h
----------2F1A63BX4156-----------------------
INT 2F - AVATAR Serial Dispatcher - UNINSTALL IRQ4 HANDLER
	AX = 1A63h
	BX = 4156h ('AV')
	CX = handle for IRQ routine returned by AX=1A43h
SeeAlso: AX=1A43h,AX=1A62h
----------2F1A72-----------------------------
INT 2F U - AVATAR.SYS v0.11 - GET ??? SIZE
	AX = 1A72h
Return: CX = maximum size of ???
SeeAlso: AX=1A52h
----------2F1A7B-----------------------------
INT 2F U - AVATAR.SYS v0.11 - ???
	AX = 1A7Bh
Return: AX = 0000h
	CX = 0000h
----------2F1A7D-----------------------------
INT 2F U - AVATAR.SYS v0.11 - ???
	AX = 1A7Dh
Return: AX = ???
----------2F1AADDX0000-----------------------
INT 2F U - AVATAR.SYS v0.11 - ???
	AX = 1AADh
	DX = 0000h
	CX = subfunction (00h-0Ch)
	???
Return: AX = 0000h if DX was nonzero
	???
----------2F1B00-----------------------------
INT 2F U - DOS 4+ XMA2EMS.SYS extension internal - INSTALLATION CHECK
	AX = 1B00h
Return: AL = FFh if installed
Note:	XMA2EMS.SYS extension is only installed if DOS has page frames to hide.
	This extension hooks onto INT 67/AH=58h and returns from that call data
	  which excludes the physical pages being used by DOS.
SeeAlso: AH=1Bh"FRAME INFO"
----------2F1B-------------------------------
INT 2F U - DOS 4+ XMA2EMS.SYS extension internal - GET HIDDEN FRAME INFORMATION
	AH = 1Bh
	AL <> 00h
	DI = hidden physical page number
Return: AX = FFFFh if failed (no such hidden page)
	AX = 0000h if OK, then
	     ES = segment of page frame
	     DI = physical page number
Notes:	this corresponds to the data edited out of the INT 67/AH=58h call
	FASTOPEN makes this call with AL = FFh
SeeAlso: AX=1B00h
----------2F2300-----------------------------
INT 2F - DR-DOS 5.0 GRAFTABL - INSTALLATION CHECK
	AX = 2300h
Return: AH = FFh
Note:	this installation check does not follow the usual format
SeeAlso: AH=23h
----------2F23-------------------------------
INT 2F - DR-DOS 5.0 GRAFTABL - GET GRAPHICS DATA
	AH = 23h
	AL nonzero
Return: AH = FFh
	ES:BX -> graphics data
SeeAlso: AX=2300h
----------2F2700-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - INSTALLATION CHECK
	AX = 2700h
Return: AL = 00h not installed
	   = FFh installed
----------2F2701-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET STATUS
	AX = 2701h
Return: AX = maximum simultaneous tasks
	BX = index into TASK_IDS of current foreground task
	CX = currently-active tasks
	DX = version number (DR-DOS 6.0 = 0001h)
	ES:SI -> TASK_IDS
	ES:DI -> name table (array of 8-byte names, NUL-terminated if <8 chars)
Notes:	do not attempt to create a new task if CX == AX
	the task's index is its position on the task menu, while its ID is the
	  position within the internal task name table
SeeAlso: AX=2714h,AX=2716h
----------2F2702-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET PER-TASK EMS LIMIT
	AX = 2702h
Return: DX = maximum pages INT 67/AH=42h will report available
Note:	TaskMAX does not limit EMS allocations other than by limiting the
	  amount which is reported as being available at a given time
SeeAlso: AX=2703h,INT 67/AH=42h
----------2F2703-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - SET PER-TASK EMS LIMIT
	AX = 2703h
	DX = maximum pages INT 67/AH=42h should report available
Return: DX = new maximum for reporting
SeeAlso: AX=2702h,INT 67/AH=42h
----------2F2704-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - REGISTER/UNREGISTER TASK MANAGER
	AX = 2704h
	DL = subfunction
	    00h unregister task manager
	    01h register task manager
Return: DL = status
	    00h registered
	    01h unregistered
Notes:	a task manager replaces TaskMAX's menu system with its own user
	  interface; while one is registered, the TaskMAX hotkeys and
	  Ctrl-Alt-Del invoke the manager rather than the built-in menu system
	unregister the task manager before terminating it
SeeAlso: AX=2705h
----------2F2705-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - ENABLE/DISABLE DIRECT SWITCHING
	AX = 2705h
	DL = subfunction
	    00h disable keystrokes for switching to next/prev/specified task
	    01h enable
Return: nothing
Note:	should only be called by a registered task manager (see AX=2704h)
SeeAlso: AX=2704h,AX=2706h
----------2F2706-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - SWITCH TO SPECIFIED TASK
	AX = 2706h
	DX = task index (see AX=2701h) of task to be activated
Return: DX = task index of previously-active task
SeeAlso: AX=2705h,AX=2707h,AX=2715h
----------2F2707-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - CREATE NEW TASK
	AX = 2707h
	DS:DX -> ASCIZ pathname of executable
	ES:BX -> parameter block (see below)
	CX = number of ticks before automatic return to task manager
		(0000h = run until termination or explicitly switched)
Return: DX = new task's task index (FFFFh if task terminated)
SeeAlso: AX=2706h,AX=2708h

Format of parameter block:
Offset	Size	Description
 00h	WORD	reserved, should be 0000h
 02h	DWORD	pointer to command tail to be copied into child's PSP
 06h	DWORD	pointer to first FCB to be copied into child's PSP
 0Ah	DWORD	pointer to second FCB to be copied into child's PSP
----------2F2708-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - DELETE TASK
	AX = 2708h
	DX = task index
Return: DX = FFFFh (task deleted)
Notes:	this call should only be used for abnormal task termination, after
	  first checking for open files with AX=270Ch; should not be used
	  with programs that allocate EMS or XMS memory
	switches to specified task first
SeeAlso: AX=2707h
----------2F2709-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - NAME TASK
	AX = 2709h
	DX = task index
	DS:SI -> 8-byte name (8 NULs = remove name)
Return: AL = task flags
	    00h ID unused or task terminated
	    01h ID in use, task name table entry valid
	    81h ID in use, task name fixed
	BX = task ID
	ES:DI -> name in task name table (see AX=2701h)
Note:	the task retains the given name until it terminates or the name is
	  removed by specifying a name of 8 NULs.
SeeAlso: AX=2701h,AX=2707h
----------2F270A-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - CONVERT TASK INDEX TO TASK ID
	AX = 270Ah
	DX = task index
Return: DX = task ID (FFFFh if index invalid)
Note:	task IDs stay constant, while indexes can change when other tasks are
	  deleted
SeeAlso: AX=2701h,AX=270Bh
----------2F270B-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - CONVERT TASK ID TO TASK INDEX
	AX = 270Bh
	DX = task ID
Return: DX = task index (FFFFh if task not active)
SeeAlso: AX=270Ah
----------2F270C-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - CHECK OPEN FILES
	AX = 270Ch
	DX = task index
Return: AX = number of files currently open for specified task
SeeAlso: AX=2708h
----------2F270D-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - CHECK IF TASK RUNNING PRIMARY COMMAND INTERPRETER
	AX = 270Dh
	DX = task index
Return: DX = status
	    0000h if primary command interpreter (COMMAND.COM, etc.) running
	    0001h if not in root shell for task
Note:	TaskMAX will return 0001h if the specified task has spawned another
	  command interpreter with AX=2707h
SeeAlso: AX=2707h,AX=270Ch
----------2F270E-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET/SET TEXT PASTE LEAD-IN
	AX = 270Eh
	CX = length of string (max 15 keystrokes, 0000h to get current string)
	DS:SI -> pasting lead-in string (character/scan-code pairs)
Return: ES:DI -> current lead-in string
Note:	the specified sequence of keystrokes is sent to the application before
	  every line of a text-mode spreadsheet paste
SeeAlso: AX=270Fh,AX=2710h,AX=2713h
----------2F270F-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET/SET NUMERIC PASTE LEAD-IN
	AX = 270Fh
	CX = length of string (max 15 keystrokes, 0000h to get current string)
	DS:SI -> pasting lead-in string (character/scan-code pairs)
Return: ES:DI -> current lead-in string
Note:	the specified sequence of keystrokes is sent to the application before
	  every number in a numeric-mode spreadsheet paste
SeeAlso: AX=270Eh,AX=2710h,AX=2711h,AX=2713h
----------2F2710-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET/SET PASTE LINE TERMINATOR STRING
	AX = 2710h
	CX = length of string (max 15 keystrokes, 0000h to get current string)
	DS:SI -> pasting lead-in string (character/scan-code pairs)
Return: ES:DI -> current lead-in string
Note:	the specified sequence of keystrokes is sent to the application after
	  every line of a spreadsheet paste operation
SeeAlso: AX=270Eh,AX=270Fh,AX=2713h
----------2F2711-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET/SET NUMERIC PASTE DECIMAL POINT
	AX = 2711h
	DX = ASCII code for separator (FFFFh to get current)
Return: DL = current separator character
SeeAlso: AX=270Fh
----------2F2712-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - INITIATE EXPORTING TASK DATA
	AX = 2712h
	DX = task index
----------2F2713-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - INITIATE PASTE OPERATION
	AX = 2713h
	DX = task index
	CX = past mode
	    0000h alphanumeric
	    0001h numeric
	    0002h text
SeeAlso: AX=270Eh,AX=270Fh,AX=2710h,AX=2711h
----------2F2714-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET SWAP SPACE INFO
	AX = 2714h
Return: CX = total KB of swap space
	DX = available KB of swap space
SeeAlso: AX=2701h
----------2F2715-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - SWITCH TO TASK MANAGER
	AX = 2715h
Return: only after calling task is again selected
SeeAlso: AX=2706h
----------2F2716-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET PASTE BUFFER STATUS
	AX = 2716h
Return: AX = 0000h if AX=2716h,AX=2717h,AX=2718h supported
	    CX = bytes in paste buffer
	    DX = current generation number (updated after every copy operation)
SeeAlso: AX=2701h,AX=2713h,AX=2714h,AX=2717h,AX=2718h
----------2F2717-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - PASTE DATA DIRECTLY TO APPLICATION BUFFER
	AX = 2717h
	CX = bytes in destination buffer
	ES:DI -> destination buffer
Return: AX = 0000h if function supported
	    CX = bytes actually copied (FFFFh if buffer too small)
	    DX = current generation number for paste buffer
Note:	the destination buffer may be too small if another task adds more data
	  to the paste buffer after the AX=2716h call but before this call
SeeAlso: AX=2713h,AX=2716h,AX=2718h
----------2F2718-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - COPY DATA DIRECTLY INTO PASTE BUFFER
	AX = 2718h
	CX = bytes in source buffer
	DS:SI -> source buffer (plain ASCII, lines terminated with CR LF)
Return: AX = 0000h if function supported
	    CX = bytes actually copied
	    DX = current generation number for paste buffer
SeeAlso: AX=2712h,AX=2716h,AX=2717h
----------2F2A-------------------------------
INT 2F - Gammafax DOS Dispatcher INTERFACE
	AH = 2Ah
Note:	details not available at this time
SeeAlso: AX=8000h"FaxBIOS",AX=CB00h,AX=CBDDh,INT 66"BitFax"
----------2F3900-----------------------------
INT 2F - Kingswood TSR INTERFACE - COMPATIBILITY MODE
	AX = 3900h
Return: AL = status
	    00h not installed
	    FFh one or more TSRs using this interface is installed
Note:	this function is provided to that the multiplex number will appear used
	  to other programs
SeeAlso: AH=39h/BL=00h
----------2F39--BL00-------------------------
INT 2F - Kingswood TSR INTERFACE - INSTALLATION CHECK
	AH = 39h
	BL = 00h
	AL = TSR ID number (01h-FFh, currently only 01h-0Eh used) (see below)
Return: AL = status
	    00h not installed
	    FFh installed
		DX = segment address of resident module
Note:	All of Kingswood Software's TSRs use this interface.  Usually the
	  resident module is installed by allocating a block of upper memory,
	  setting its owner ID to 0008h (DOS data), and filling the MCB name
	  field with the TSR's name.
SeeAlso: AX=3900h,AH=39h/BL=01h

Values for TSR ID number:
 01h TSR Windows
 02h NOBUSY
 03h CD STACK
 04h DISK WATCH
 05h PUSHBP
 06h ALIAS
 07h KEYMACRO
 08h SLOWDOWN
 09h ANSIGRAB
 0Ah TEE
 0Bh FASTMOUS
 0Ch EXTWILD
 0Dh BREAKOUT
 0Eh STOPDISK

Format of TSR modules:
Offset	Size	Description
 00h  4 BYTEs	signature "FTSR"
 04h	WORD	segment address of this module
 06h	WORD	number of words to skip (usually 0000h if no PSP present)
 08h  N WORDs	module-defined data that must be at a fixed segment offset
		(usually only a PSP if file access is required)
     5N BYTEs	interrupt list (see below)
	BYTE	FFh terminator

Format of interrupt list entry:
Offset	Size	Description
 00h	BYTE	interrupt number (00h-FEh)
 01h	WORD	offset within segment of DWORD pointer to previous interrupt
 03h	WORD	offset within segment of begin of interrupt handler code
----------2F39--BL01-------------------------
INT 2F - Kingswood TSR INTERFACE - REMOVAL CHECK
	AH = 39h
	BL = 01h
	AL = TSR ID number (01h-FFh) (see AH=39h/BL=00h)
Return: AL = status
	    00h not ready to be removed
	    FFh resident module may be removed by deassigning the interrupts
		hooked by the TSR and deallocating the TSR's memory block
	AH,BX,CX,DX,ES may be destroyed
SeeAlso: AX=3900h,AH=39h/BL=00h
----------2F39-------------------------------
INT 2F - Kingswood TSR INTERFACE - APPLICATION-SPECIFIC FUNCTION CALLS
	AH = 39h
	BL = function number (02h-FFh)
	AL = TSR ID number (01h-FFh)
	CX,DX,SI,DI,DS,ES may contain parameters
Return: as appropriate for the called function
SeeAlso: AX=3900h,AH=39h/BL=00h,AX=3901h/BL=02h
----------2F3901BL02-------------------------
INT 2F - Kingswood TSR Windows - OPEN WINDOW
	AX = 3901h
	BL = 02h
Return: AX = error code (0000h if successful)
Notes:	opens the next TSR window on top of any others.	 Only three
	  TSR windows can be opened at any one time.  The three windows
	  are all 40x11 characters, partly overlapping.
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=03h,AX=3901h/BL=05h,AX=3901h/BL=06h
----------2F3901BL03-------------------------
INT 2F - Kingswood TSR Windows - HIDE WINDOWS
	AX = 3901h
	BL = 03h
Return: AX = error code (0000h if successful)
Notes:	Hide any visible TSR windows from view.
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=02h,AX=3901h/BL=05h
----------2F3901BL04-------------------------
INT 2F - Kingswood TSR Windows - SHOW WINDOWS
	AX = 3901h
	BL = 04h
Return: AX = error code (0000h if successful)
Notes:	Re-display all TSR windows after a HIDE WINDOWS call.
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=02h,AX=3901h/BL=03h
----------2F3901BL05-------------------------
INT 2F - Kingswood TSR Windows - CLOSE WINDOW
	AX = 3901h
	BL = 05h
Return: AX = error code (0000h if successful)
Notes:	Close the last opened TSR window.
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=02h
----------2F3901BL06-------------------------
INT 2F - Kingswood TSR Windows - SET WINDOW TITLE
	AX = 3901h
	BL = 06h
	DS:SI -> title string
Return: AX = error code (0000h if successful)
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=02h
----------2F3901BL07-------------------------
INT 2F - Kingswood TSR Windows - POSITION CURSOR
	AX = 3901h
	BL = 07h
	CH = Y coordinate (0-10)
	CL = X coordinate (0-39)
Return: AX = error code (0000h if successful)
Note:	the hardware cursor is always disabled when a TSR window is opened;
	  this call only sets a text position
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=08h,AX=3901h/BL=09h
----------2F3901BL08-------------------------
INT 2F - Kingswood TSR Windows - DISPLAY STRING
	AX = 3901h
	BL = 08h
	DS:SI -> string
Return: AX = error code (0000h if successful)
Notes:	The text is not clipped.
	This routine understands Tab, NewLine and Carriage Return
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=07h
----------2F3901BL09-------------------------
INT 2F - Kingswood TSR Windows - SCROLL WINDOW
	AX = 3901h
	BL = 09h
	CL = scroll direction: 00h up, FFh down, 00h clear window
Return: AX = error code (0000h if successful)
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=07h
----------2F3901BL0A-------------------------
INT 2F - Kingswood TSR Windows - SOUND BEEPER
	AX = 3901h
	BL = 0Ah
	DX = sound divisor, or 0 for silence.
	     (divide 1843200 by required frequency to get value for DX)
	CL = sound length in 18.2 Hz clock ticks
Return: AX = error code (0000h if successful)
SeeAlso: AH=39h/BL=00h
----------2F3901BL0B-------------------------
INT 2F - Kingswood TSR Windows - ADD OR REMOVE USER
	AX = 3901h
	BL = 0Bh
	CL = number of users increment: +1 if adding a new user
					-1 if removing a user
Return: AX = error code (0000h if successful)
Note:	the TSR windows resident module may only be removed when the internal
	  user count is zero
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=02h
----------2F4000-----------------------------
INT 2F - Windows 3.x (OS/2 2.x???) - GET VIRTUAL DEVICE DRIVER (VDD) CAPABLTIES
	AX = 4000h
Return: AL = 01h does not virtualize video access
	     02h virtualizes the video when in text mode
	     03h virtualizes the video when in text mode or single plane
		 graphics modes
	     04h virtualizes the video when in text mode, single plane
		 graphics modes, and VGA multiplane modes
	     FFh virtualizes the video fully
Note:	this function is used by display drivers to find out what capabilities
	  exist for the VDD driver and also trigger then VDD driver to call
	  functions 4005h and 4006h.  This function also gives the Video Driver
	  hardware access to the video registers.
----------2F4001-----------------------------
INT 2F - OS/2 compatibility box - SWITCHING DOS TO BACKGROUND
	AX = 4001h
Note:	called by OS/2 when the DOS box is about to be placed in the background
	  and the video driver should save any necessary state
SeeAlso: AX=4002h,AX=4005h
----------2F4002-----------------------------
INT 2F - OS/2 compatibility box - SWITCHING DOS TO FOREGROUND
	AX = 4002h
Note:	called by OS/2 when the DOS box is about to be placed in the foreground
	  and the video driver should restore the previously-saved state
SeeAlso: AX=4001h,AX=4006h
----------2F4003-----------------------------
INT 2F - Windows 3.x - ENTERING VIDEO DRIVER CRITICAL SECTION
	AX = 4003h
Note:	This critical section must be exited within 1 second.
SeeAlso: AX=4004h
----------2F4004-----------------------------
INT 2F - Windows 3.x - EXITING VIDEO DRIVER CRITICAL SECTION
	AX = 4004h
SeeAlso: AX=4003h
----------2F4005-----------------------------
INT 2F - Windows 3.x - SWITCHING DOS TO BACKGROUND
	AX = 4005h
Note:	called by Windows when the DOS box is about to be placed in the
	  background and the video driver should save any necessary state
	  information
SeeAlso: AX=4001h,AX=4006h
----------2F4006-----------------------------
INT 2F - Windows 3.x - SWITCHING DOS TO FOREGROUND
	AX = 4006h
Note:	called by Windows when the DOS box is about to be placed in the
	  foreground and the video driver should restore any necessary state
	  information
SeeAlso: AX=4002h,AX=4005h
----------2F4007-----------------------------
INT 2F - Windows 3.x - ENABLE VDD TRAPPING OF VIDEO REGISTERS
	AX = 4007h
----------2F41-------------------------------
INT 2F - LAN Manager 2.0 DOS Enhanced NETPOPUP.EXE - NETWORK POP-UP SERVICE
	AH = 41h
	???
Return: ???
Note:	LAN Manager enhanced mode adds features beyond the standard redirector
	  file/printer services
SeeAlso: AX=118Ah,AH=42h,AH=4Bh
----------2F42-------------------------------
INT 2F - LAN Manager 2.0 DOS Enhanced MSRV.EXE - MESSENGER SERVICE
	AH = 42h
	???
Return: ???
Note:	LAN Manager enhanced mode adds features beyond the standard redirector
	  file/printer services
SeeAlso: AX=118Ah,AH=41h,AH=4Bh
----------2F4300-----------------------------
INT 2F - EXTENDED MEMORY SPECIFICATION (XMS) - INSTALLATION CHECK
	AX = 4300h
Return: AL = 80h XMS driver installed
	AL <> 80h no driver
Notes:	XMS gives access to extended memory and noncontiguous/nonEMS memory
	  above 640K
	this installation check DOES NOT follow the format used by other
	  software
SeeAlso: AX=4310h
----------2F4310-----------------------------
INT 2F - EXTENDED MEMORY SPECIFICATION (XMS) - GET DRIVER ADDRESS
	AX = 4310h
Return: ES:BX -> driver entry point
Note:	HIMEM.SYS v2.77 chains to previous handler if AH is not 00h or 10h
SeeAlso: AX=4300h

Perform a FAR call to the driver entry point with AH set to the function code
	AH	function
	00h  Get XMS version number
	     Return: AX = XMS version (in BCD, AH=major, AL=minor)
		     BX = internal revision number
		     DX = 0001h if HMA (1M to 1M + 64K) exists
			  0000h if HMA does not exist
	01h  Request High Memory Area (1M to 1M + 64K)
	     DX = memory in bytes (for TSR or device drivers)
		  FFFFh if application program
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,90h,91h,92h) (see below)
	02h  Release High Memory Area
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,90h,93h) (see below)
	03h  Global enable A20, for using the HMA
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,82h) (see below)
	04h  Global disable A20
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,82h,94h) (see below)
	05h  Local enable A20, for direct access to extended memory
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,82h) (see below)
	06h  Local disable A20
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,82h,94h) (see below)
	07h  Query A20 state
	     Return: AX = 0001h enabled
			= 0000h disabled
		     BL = error code (00h,80h,81h) (see below)
	08h  Query free extended memory, not counting HMA
	     BL = 00h (some implementations leave BL unchanged on success)
	     Return: AX = size of largest extended memory block in K
		     DX = total extended memory in K
		     BL = error code (00h,80h,81h,A0h) (see below)
	09h  Allocate extended memory block
	     DX = Kbytes needed
	     Return: AX = 0001h success
			   DX = handle for memory block
			= 0000h failure
			   BL = error code (80h,81h,A0h) (see below)
	0Ah  Free extended memory block
	     DX = handle of block to free
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,A2h,ABh) (see below)
	0Bh  Move extended memory block
	     DS:SI -> EMM structure (see below)
	     Note: if either handle is 0000h, the corresponding offset is
		   considered to be an absolute segment:offset address in
		   directly addressable memory
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h-82h,A3h-A9h) (see below)
	0Ch  Lock extended memory block
	     DX = handle of block to lock
	     Return: AX = 0001h success
			   DX:BX = 32-bit linear address of locked block
			= 0000h failure
			   BL = error code (80h,81h,A2h,ACh,ADh) (see below)
	0Dh  Unlock extended memory block
	     DX = handle of block to unlock
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,A2h,AAh) (see below)
	0Eh  Get handle information
	     DX = handle for which to get info
	     Return: AX = 0001h success
			   BH = block's lock count
			   BL = number of free handles left
			   DX = block size in K
			= 0000h failure
			   BL = error code (80h,81h,A2h) (see below)
	0Fh  Reallocate extended memory block
	     DX = handle of block
	     BX = new size of block in K
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,A0h-A2h,ABh) (see below)
	10h  Request upper memory block (nonEMS memory above 640K)
	     DX = size of block in paragraphs
	     Return: AX = 0001h success
			   BX = segment address of UMB
			   DX = actual size of block
			= 0000h failure
			   BL = error code (80h,B0h,B1h) (see below)
			   DX = largest available block
	11h  Release upper memory block
	     DX = segment address of UMB to release
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,B2h) (see below)
	12h  (XMS v3.0) Reallocate upper memory block
	     DX = segment address of UMB to resize
	     BX = new size of block in paragraphs
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,B0h,B2h) (see below)
	34h  (QEMM 5.11 only, undocumented) ???
	44h  (QEMM 5.11 only, undocumented) ???
	88h  (XMS v3.0) Query free extended memory
	     Return: EAX = largest block of extended memory, in K
		     BL = status
		         00h success
			 80h not implemented (i.e. on a 286 system)
			 81h VDISK detected
			 A0h all extended memory allocated
	     	     ECX = physical address of highest byte of memory
		     		(valid even on error codes 81h and A0h)
		     EDX = total Kbytes of extended memory (0 if status A0h)
	89h  (XMS v3.0) Allocate any extended memory
	     EDX = Kbytes needed
	     Return: AX = 0001h success
	     		    DX = handle for allocated block (free with AH=0Ah)
			= 0000h failure
			    BL = status (80h,81h,A0h,A1h,A2h) (see below)
	8Eh  (XMS v3.0) Get extended EMB handle information
	     DX = handle
	     Return: AX = 0001h success
	     		    BH = block's lock count
			    CX = number of free handles left
			    EDX = block size in K
	     		= 0000h failure
	     		    BL = status (80h,81h,A2h) (see below)
	8Fh  (XMS v3.0) Reallocate any extended memory block
	     DX = unlocked handle
	     EBX = new size in K
	     Return: AX = 0001h success
	     		= 0000h failure
			    BL = status (80h,81h,A0h-A2h,ABh) (see below)
Notes:	HIMEM.SYS requires at least 256 bytes free stack space
	the XMS driver need not implement functions 10h through 12h to be
	  considered compliant with the standard

Format of EMM structure:
Offset	Size	Description
 00h	DWORD	number of bytes to move (must be even)
 04h	WORD	source handle
 06h	DWORD	offset into source block
 0Ah	WORD	destination handle
 0Ch	DWORD	offset into destination block
Notes:	if source and destination overlap, only forward moves (source base
	  less than destination base) are guaranteed to work properly
	if either handle is zero, the corresponding offset is interpreted
	  as a real-mode address referring to memory directly addressable
	  by the processor

Error codes returned in BL:
	00h successful
	80h function not implemented
	81h Vdisk was detected
	82h an A20 error occurred
	8Eh a general driver error
	8Fh unrecoverable driver error
	90h HMA does not exist
	91h HMA is already in use
	92h DX is less than the /HMAMIN= parameter
	93h HMA is not allocated
	94h A20 line still enabled
	A0h all extended memory is allocated
	A1h all available extended memory handles are allocated
	A2h invalid handle
	A3h source handle is invalid
	A4h source offset is invalid
	A5h destination handle is invalid
	A6h destination offset is invalid
	A7h length is invalid
	A8h move has an invalid overlap
	A9h parity error occurred
	AAh block is not locked
	ABh block is locked
	ACh block lock count overflowed
	ADh lock failed
	B0h only a smaller UMB is available
	B1h no UMB's are available
	B2h UMB segment number is invalid
----------2F44-------------------------------
INT 2F U - ???
	AH = 44h
	AL = function (at least 0Bh, 15h, 17h)
	???
Return: ???
Note:	called by Codeview for Windows
SeeAlso: AH=86h
----------2F4500-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - INSTALLATION CHECK
	AX = 4500h
Return: AL = 01h if PROF.COM installed
	AL = 02h if VPROD.386 installed
SeeAlso: AX=4501h,AX=4502h
----------2F4501-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - SETUP PROFILER
	AX = 4501h
	BX = CSIPS buffer size in KB (first parameter for ProfSetup)
	CX = output limit in KB (second parameter for ProfSetup)
Note:	this call is not supported by PROF.COM
SeeAlso: AX=4502h,AX=4503h
----------2F4502-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - SET SAMPLING RATE
	AX = 4502h
	BL = sampling rate for PROF.COM (0 < BL <= 13)
	    (01h = 8192/s, 04h = 1024/s, 08h = 32/s, 0Dh = 1/s)
	CX = sampling rate for VPROD.386
Note:	for PROF.COM, this programs the CMOS clock by setting BL+2 as the
	  low four bits of CMOS register 0Ah.  The interruption rate is
	  1 SHL (15 - BL) per second.
SeeAlso: AX=4501h,AX=4503h
----------2F4503-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - START PROFILING
	AX = 4503h
Notes:	Profiling is also turned on by the key combinations
	  LeftShift + RightShift + Alt
	  LeftShift + RightShift + Ctrl
	for PROF.COM, this call programs the CMOS clock by reading register
	  0Ch, and setting bit 6 of register 0Bh.  It then makes sure that IRQ8
	  is unmasked
SeeAlso: AX=4504h
----------2F4504-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - STOP PROFILING
	AX = 4504h
Notes:	profiling is also turned off by the key combination
	  LeftShift + RightShift
	for PROF.COM, this programs the CMOS clock by reading register 0Ch
	  and clearing bit 6 of register 0Bh.  It then masks IRQ8.
SeeAlso: AX=4503h,AX=4505h,AX=4506h,AX=4507h
----------2F4505-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - CLEAR PROFILING DATA
	AX = 4505h
SeeAlso: AX=4503h,AX=4504h,AX=4506h
----------2F4506-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - "ProfFlush"
	AX = 4506h
SeeAlso: AX=4505h,AX=4507h
----------2F4507-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - "ProfFinish"
	AX = 4507h
Note:	this call is essentially a "ProfStop" (AX=4504h) followed by
	  "ProfFlush" (AX=4506h)
SeeAlso: AX=4504h,AX=4505h,AX=4506h
----------2F4508-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - ALTERNATE SEGDEBUG IFACE
	AX = 4508h
	BX = ordinal (or 0000h)
	CX = segment
	DX = instance (or 0000h)
	SI = type (or 0000h)
	ES:DI -> ASCIZ module name
Notes:	this call is an alternate entry to the profiler's SEGDEBUG
	  interface, but only to function 0, for notifying the profiler of
	  each new segment loaded.  The SHOWHITS utility then examines the
	  profiler's output files (CSIPS.DAT and SEGENTRY.DAT) in conjunction
	  with symbol files to provide information in a useful form.
	this call does not have a corresponding Windows function
SeeAlso: AX=4500h 
----------2F4601-----------------------------
INT 2F U - DOS 5.0 kernel - ???
	AX = 4601h
Return: ???
Note:	copies the MCB following the caller's PSP memory block into DOS data
	  segment
SeeAlso: AX=4602h
----------2F4602-----------------------------
INT 2F U - DOS 5.0 kernel - ???
	AX = 4602h
Return: ???
Note:	copies previously copied MCB from DOS data segment into MCB following
	  caller's PSP memory block
SeeAlso: AX=4601h
----------2F46-------------------------------
INT 2F U - ???
	AH = 46h
	AL = subfunction (03h,04h)
Return: ???
Note:	these two subfunctions are called by MS Windows 3.0
----------2F4653CX0002-----------------------
INT 2F - F-PROT v1.x only - F-LOCK.EXE 
	AX = 4653h
	CX = 0002h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
		Return: AX,BX,ES destroyed
	    0002h  disable (v1.08 and below only)
	    0003h  enable (v1.08 and below only)
Note:	F-LOCK is part of the F-PROT virus/trojan protection package by Fridrik
	  Skulason
SeeAlso: AX=4653h/CX=0003h,AX=CA00h,INT 21/AX=4BEEh
----------2F4653CX0003-----------------------
INT 2F - F-PROT v1.x only - F-XCHK.EXE
	AX = 4653h
	CX = 0003h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
		Return: AX,BX,ES destroyed
Note:	F-XCHK is part of the F-PROT virus/trojan protection package by Fridrik
	  Skulason
SeeAlso: AX=4653h/CX=0002h,AX=4653h/CX=0004h,AX=CA00h
----------2F4653CX0004-----------------------
INT 2F - F-PROT v1.x only - F-POPUP.EXE
	AX = 4653h
	CX = 0004h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
		Return: AX,BX,ES destroyed
	    0002h  disable (v1.08 and below only)
		   display message (v1.14+)
			other registers: ???
	    0003h  enable (v1.08 and below only)
		   display message (v1.14+)
			other registers: ???
			Return: AX = key pressed by user
Note:	F-POPUP is part of the F-PROT virus/trojan protection package by
	  Fridrik Skulason
SeeAlso: AX=4653h/CX=0003h,AX=4653h/CX=0005h,AX=CA00h
----------2F4653CX0005-----------------------
INT 2F - F-PROT v1.x only - F-DLOCK.EXE
	AX = 4653h
	CX = 0005h
	BX = subfunction
	    0000h installation check
		Return: AX = FFFFh
	    0001h uninstall
		Return: AX,BX,ES destroyed
Note:	F-DLOCK is part of the F-PROT virus/trojan protection package by
	  Fridrik Skulason
SeeAlso: AX=4653h/CX=0004h,AX=CA00h
----------2F4680-----------------------------
INT 2F - MS Windows v3.0 - INSTALLATION CHECK
	AX = 4680h
Return: AX = 0000h MS Windows 3.0 running in real (/R) or standard (/S) mode,
		   or DOS 5 DOSSHELL active
	   nonzero  no Windows, Windows prior to 3.0, or Windows3 in enhanced
		    mode
Note:	not officially documented, but Microsoft has indicated that they
	  intend to provide an installation check which works in all modes
SeeAlso: AX=1600h
----------2F4800-----------------------------
INT 2F - DOS v5.0 DOSKEY - INSTALLATION CHECK
	AX = 4800h
Return: AL = nonzero if installed
SeeAlso: AX=4810h
----------2F4810-----------------------------
INT 2F - DOS v5.0 DOSKEY - READ INPUT LINE FROM CONSOLE
	AX = 4810h
	DS:DX -> line buffer (see INT 21/AH=0Ah)
Return: AX = 0000h if successful
Notes:	the first byte (length) of the buffer MUST be 80h, or DOSKEY chains to
	  the previous handler
	if the user's input is a macro name, no text is placed in the buffer
	  even though AX=0000h on return; the program must immediately issue
	  this call again to retrieve the expansion of the macro.  Similarly,
	  if the user enters a special parameter such as $*, this call must
	  be repeated to retrieve the expansion; on the second call, DOSKEY
	  overwrites the macro name on the screen with its expansion.
SeeAlso: AX=4800h,INT 21/AH=0Ah
----------2F4A00CX0000-----------------------
INT 2F U - DOS v5.0 - SINGLE-FLOPPY LOGICAL DRIVE CHANGE NOTIFICATION
	AX = 4A00h
	CX = 0000h
	DH = new drive number
	DL = current drive number
Return: CX = FFFFh to skip "Insert diskette for drive X:" message
Note:	called by MSDOS 5.00 IO.SYS just before displaying the message
	  "Insert diskette for drive X:" on single-floppy systems
----------2F4A01-----------------------------
INT 2F - DOS v5.0 - QUERY FREE HMA SPACE
	AX = 4A01h
Return: BX = number of bytes available in HMA (0000h if DOS not using HMA)
	ES:DI -> start of available HMA area (FFFFh:FFFFh if not using HMA)
SeeAlso: AX=4310h,AX=4A02h
----------2F4A02-----------------------------
INT 2F - DOS v5.0 - ALLOCATE HMA SPACE
	AX = 4A02h
	BX = number of bytes
Return: ES:DI -> start of allocated HMA block or FFFFh:FFFFh
	BX destroyed
Note:	this call is not valid unless DOS is loaded in the HMA (DOS=HIGH)
SeeAlso: AX=4A01h
----------2F4A05-----------------------------
INT 2F U - DOS v5.0 DOSSHELL - ???
	AX = 4A05h
	SI = function
	    0000h reset???
	    0001h ???
	    0002h ???
	    0003h ???
	    0004h ???
		BL = ???
	    0005h ???
	    0006h get ???
		Return: ES:DI -> ???
	    0007h get ???
		Return: AX = ???
	    0008h get ???
		Return: DX:AX -> ???
	    0009h get ???
		Return: ES = ???
	    000Ah ???
		BL = ???
		ES:DI -> ???
	    000Bh get ???
		Return: AX = ???
	    000Ch ???
		BL = ???
		Return: DX:AX -> ???
Notes:	DOSSHELL chains to the previous handler if SI is not one of the values
	  listed above
	the DOSSWAP.EXE module calls functions 03h,04h,05h,07h,08h,09h,0Ch
SeeAlso: AX=4B01h
----------2F4A06-----------------------------
INT 2F U - ??? - GET MEMORY SIZE
	AX = 4A06h
	DX = segment following last byte of conventional memory
Return: DX = segment following last byte of memory available for use by DOS
Note:	called by MSDOS 5.00 IO.SYS startup code if the signature "RPL" is
	  present three bytes beyond the INT 2F handler; this call overrides
	  the value returned by INT 12
SeeAlso: INT 12
----------2F4A10-----------------------------
INT 2F - SMARTDRV v4.00+ - API
        AX = 4A10h
        BX = command
            0000h installation check and hit ratios
                Return: AX = BABEh if installed
                            DX:BX = cache hits
                            DI:SI = cache misses
                            CX = ???
                            BP = version (4.00 = 0400h)
            0001h reset cache
            0002h flush buffers
            0003h status
                BP = drive # (0=A, 1=B, etc.)
                DL = subfunction
		    00h only get information
                    01h turn on read cache
		    02h turn off read cache
		    03h turn on write cache
		    04h turn off write cache
	    	Return: AX = BABEh if OK
                       	DL = status
                            bit 7  not cached
			    bit 6  write-through
			    bit 5  ???
			    bits 0-4 drive # (0=A, 1=B...)
                        DL = FFh if drive does not exist
                Note:	If the read cache is off, reads will not be cached,
			  but writes will continue to be cached if the write-
			  cache is enabled.
            0004h cache size
                Return: AX = ???
                        BX = largest number of elements
                        CX = size of elements in bytes
                        DX = number of elements under Windows
            0005h double-buffer status
                BP = drive # (0=A, 1=B...)
                Return: AX = BABEh if double-buffered
            0007h ???
                Return: DI = random number???
            000Ah get table pointer???
                Return: ES:BX -> table of about 10 bytes or 5 words. Seems to
				be words pointing to memory addresses 
				containing info??? (see below)
            1234h signal serious error
                pops up a message box saying that a serious error occurred and
                  to hit R to retry.
SeeAlso: INT 21/AX=4402h"SMARTDRV",INT 21/AX=4403h"SMARTDRV"

Format of data table:
Offset	Size	Description
 00h  8 BYTEs	???
 08h	WORD	offset of WORD containing number of elements in cache
----------2F4B-------------------------------
INT 2F - LAN Manager 2.0 DOS Enh NETWKSTA.EXE - NETWORK WORKSTATION REDIRECTOR
	AH = 4Bh
	???
Return: ???
Note:	LAN Manager enhanced mode adds features beyond the standard redirector
	  file/printer services
SeeAlso: AX=118Ah,AH=41h,AH=42h
----------2F4B01-----------------------------
INT 2F - DOS v5.0 TASK SWITCHER - BUILD CALLOUT CHAIN
	AX = 4B01h
	CX:DX -> task switcher entry point (see AX=4B02h)
	ES:BX = 0000h:0000h
Return: ES:BX -> callback info structure (see below) or 0000h:0000h
Notes:	called by the task switcher
	this function is hooked by clients which require notification of task
	  switcher activities; the call must first be passed on to the prior
	  handler with registers unchanged using a simulated interrupt.	 On
	  return, the client must build a callback info structure and store
	  the returned ES:BX in the "next" field, then return the address of
	  its own callback info structure.
	a client program must add itself to the notification chain if it
	  provides services to other programs; before terminating, it must
	  remove itself from the chain by calling the task switcher's entry
	  point with AX=0005h (see AX=4B02h)
	the task switcher entry point should not be saved, as it is subject to
	  change and will be provided on any notification call
	the Windows 3.1 Standard Mode supports this API
SeeAlso: AX=4B02h

Format of callback info structure:
Offset	Size	Description
 00h	DWORD	pointer to next callback info structure
 04h	DWORD	pointer to notification function (see below)
 08h	DWORD	reserved
 0Ch	DWORD	address of zero-terminated list of API info structures
		(see AX=4B02h)

Notification function is called with:
	AX = function
	    0000h switcher initialization
		Return: AX = 0000h if OK to load
			   = nonzero to abort task switcher
	    0001h query suspend
		BX = session ID
		Return: AX = 0000h if OK to switch session
			   = 0001h if not
	    0002h suspend session
		BX = session ID
		interrupts disabled
		Return: AX = 0000h if OK to switch session
			   = 0001h if not
	    0003h activate session
		BX = session ID
		CX = session status flags
			bit 0: set if first activation of session
			bits 1-15: reserved (0)
		interrupts disabled
		Return: AX = 0000h
	    0004h session active
		BX = session ID
		CX = session status flags
			bit 0: set if first activation of session
			bits 1-15: reserved (0)
		Return: AX = 0000h
	    0005h create session
		BX = session ID
		Return: AX = 0000h if OK to create session
			   = 0001h if not
	    0006h destroy session
		BX = session ID
		Return: AX = 0000h
	    0007h switcher termination
		BX = flags
		    bit 0: set if calling switcher is only switcher loaded
		    bits 1-15: reserved (0)
		Return: AX = 0000h
	ES:DI -> task switcher entry point (see AX=4B02h)
Notes:	function 0000h is generally called by the program which controls or
	  invokes the task switcher, rather than by the task switcher itself;
	  the entry point supplied to this function is not necessarily the
	  entry point to the task switcher itself, and may be 0000h:0000h.  If
	  any client indicates that loading is not possible, all clients will
	  be called with function 0007h; thus it is possible for a client to
	  receive a termination notice without a corresponding initialization
	  notice.
	except for functions 0002h and 0003h, the notification handler is
	  called with interrupts enabled and may make any INT 21h function
	  call; interrupts must not be enabled in functions 0002h and 0003h
	function 0007h may be called with ES:DI = 0000h:0000h if the entry
	  point is no longer valid
----------2F4B02BX0000-----------------------
INT 2F - DOS v5.0 TASK SWITCHER - INSTALLATION CHECK
	AX = 4B02h
	BX = 0000h
	ES:DI = 0000h:0000h
Return: ES:DI = 0000h:0000h if task switcher not loaded
	ES:DI -> task switcher entry point (see below) if loaded
	    AX = 0000h
Note:	the returned entry point is that for the most-recently loaded task
	  switcher; the entry points for prior task switchers may be determined
	  with the "get version" call (see below)
SeeAlso: AX=4A05h,AX=4B03h

Call task switcher entry point with:
	AX = 0000h get version
		Return: CF clear if successful
			    AX = 0000h
			    ES:BX -> task switcher version struct (see below)
			CF set if unsupported function
	AX = 0001h test memory region
		ES:DI -> first byte to be tested
		CX = size of region to test
		Return: CF clear if successful
			    AX = memory type of tested region
				0000h global
				0001h global and local
				0002h local (replaced on session switch)
			CF set if unsupported function
	AX = 0002h suspend switcher
		ES:DI -> new task switcher's entry point
		Return: CF clear if successful
			    AX = state
				0000h switcher has been suspended
				0001h switcher not suspended, new switcher must
					abort
				0002h switcher not suspended, but new switcher
					may run anyway
			CF set if unsupported function
	AX = 0003h resume switcher
		ES:DI -> new task switcher's entry point
		Return: CF clear if successful
			    AX = 0000h
			CF set if unsupported function
	AX = 0004h hook notification chain
		ES:DI -> callback info structure to be added to chain
			(see AX=4B01h)
		Return: CF clear if successful
			    AX = 0000h
			CF set if unsupported function
	AX = 0005h unhook notification chain
		ES:DI -> callback info structure to be removed from chain
			(see AX=4B01h)
		Return: CF clear if successful
			    AX = 0000h
			CF set if unsupported function
	AX = 0006h query API support
		BX = asynchronous API identifier
		Return: CF clear if successful
			    AX = 0000h
			    ES:BX -> API info structure (see below) for the
					client which provides the highest
					level of 
			CF set if unsupported function

Format of task switcher version structure:
Offset	Size	Description
 00h	WORD	major version of supported protocol  (current protocol is 1.0)
 02h	WORD	minor version of supported protocol
 04h	WORD	major version of task switcher
 06h	WORD	minor version of task switcher
 08h	WORD	task switcher ID (see AX=4B03h)
 0Ah	WORD	operation flags
		bit 0: set if task switcher disabled
		bits 1-15: reserved (0)
 0Ch	DWORD	pointer to ASCIZ task switcher name
		("MS-DOS Shell Task Switcher" for DOSSHELL task switcher)
 10h	DWORD	pointer to previous task switcher's entry point or 0000h:0000h

Format of API info structure:
Offset	Size	Description
 00h	WORD	size of structure in bytes (000Ah)
 02h	WORD	API identifier
		0001h NetBIOS
		0002h 802.2
		0003h TCP/IP
		0004h LAN Manager named pipes
		0005h Novell NetWare IPX
 04h	WORD	major version \ of highest version of API for which the support
 06h	WORD	minor version / level specified in the next field is provided
 08h	WORD	support level
		0001h minimal support
		0002h API-level support
		0003h switcher compatibility
		0004h seamless compatibility
----------2F4B03-----------------------------
INT 2F - DOS v5.0 TASK SWITCHER - ALLOCATE SWITCHER ID
	AX = 4B03h
	ES:DI -> task switcher entry point (see AX=4B02h)
Return: AX = 0000h
	BX = switcher ID (0001h-000Fh), or 0000h if no more available
Notes:	if a task switcher has determined that it is the first to be loaded, it
	  must allocate an identifier for itself and provide this function to
	  all subsequent task switchers; if it is not the first to be loaded,
	  it must call this function to allocate an ID.	 The switcher ID is
	  used as the high four bits of all session identifiers to ensure
	  unique session IDs.
	if no more switcher IDs are available, the new task switcher making the
	  call must terminate or disable itself
	the task switcher providing the identifiers may call the new task
	  switcher's entry point as needed
	this call is available from within DOSSHELL even if the task switcher
	  is not installed
SeeAlso: AX=4B02h,AX=4B04h
----------2F4B04-----------------------------
INT 2F - DOS v5.0 TASK SWITCHER - FREE SWITCHER ID
	AX = 4B04h
	BX = switcher ID
	ES:DI -> task switcher entry point (see AX=4B02h)
Return: AX = 0000h
	BX = status
	    0000h successful
	    other error (invalid ID or ID not allocated)
Notes:	called by a task switcher when it exits, unless it was the first loaded
	  and is providing the support for AX=4B03h and AX=4B04h
	the task switcher providing the identifiers may call the terminating
	  task switcher's entry point as needed
	this call is available from within DOSSHELL even if the task switcher
	  is not installed
SeeAlso: AX=4B02h,AX=4B03h
----------2F4B05-----------------------------
INT 2F - DOS v5.0 DOSSHELL TASK SWITCHER - IDENTIFY INSTANCE DATA
	AX = 4B05h
	ES:BX = 0000h:0000h
	CX:DX -> task switcher entry point (see AX=4B02h)
Return: ES:BX -> startup info structure (see below) or 0000h:0000h
Notes:	called by task switcher
	clients with instance data should hook this call, pass it through to
	  the previous handler with unchanged registers using a simulated
	  interrupt.  On return, the client should create a startup info
	  structure (see below), store the returned ES:BX in the "next"
	  field, and return the address of the created structure in ES:BX
	all MSDOS function calls are available from within this call
SeeAlso: AX=1605h,AX=4B02h

Format of startup info structure:
Offset	Size	Description
 00h  2 BYTEs	major, minor version of info structure (03h,00h)
 02h	DWORD	pointer to next startup info structure or 0000h:0000h
 06h	DWORD	0000h:0000h (ignored)
 0Ah	DWORD	ignored
 0Eh	DWORD	pointer to instance data records

Format of one instance data record in array:
Offset	Size	Description
 00h	DWORD	address of instance data (end of array if 0000h:0000h)
 04h	WORD	size of instance data
----------2F53-------------------------------
INT 2F U - ???
	AH = 53h
	AL = subfunction (0Bh, maybe others???)
Return: ???
Note:	called by MS Windows 3.1 POWER.DRV; hooked by MS Mouse driver v8.20+
SeeAlso: AH=54h,INT 33/AX=002Fh
----------2F54-------------------------------
INT 2F U - ???
	AH = 54h
	AL = subfunction (00h, 01h, maybe others???)
Return: ???
Note:	called by MS Windows 3.1 POWER.DRV
SeeAlso: AH=53h
----------2F5453-----------------------------
INT 2F - TesSeRact RAM-RESIDENT PROGRAM INTERFACE
	AX = 5453h
	BX = subfunction
	    00h installation check
		CX = 0000h
		DS:SI -> 8-char blank-padded name
		Return: AX = FFFFh installed
				CX = ID number of already-installed copy
			   = anything else, not installed
				CX = ID number for TSR when installed
	    01h get user parameters
		CX = TSR ID number
		Return: AX = 0000h successful
			   ES:BX -> user parameter block (see below)
			   = nonzero failed
	    02h check if hotkey in use
		CL = scan code of hot key
		Return: AX = FFFFh hot key conflicts with another TSR
			     otherwise safe to use the hotkey
	    03h replace default critical error handler
		CX = TSR ID number
		DS:SI -> new routine for INT 24h
		Return: AX = nonzero, unable to install new handler
	    04h get internal data area
		CX = TSR ID number
		Return: AX = 0000h
			    ES:BX -> TSR's internal data area (see below)
			   = nonzero, TSR not found
	    05h set multiple hot keys
		CX = TSR ID number
		DL = number of additional hot keys to allocate
		DS:SI -> table of hot keys
			BYTE  hotkey scan code
			BYTE  hotkey shift state
			BYTE  flag value to pass to TSR (nonzero)
		Return: AX = nonzero, unable to install hot keys
	    06h - 0Fh reserved
	    10h enable TSR
		CX = TSR ID number
		Return: AX = nonzero, unable to enable
	    11h disable TSR
		CX = TSR ID number
		Return: AX = nonzero, unable to disable
	    12h unload TSR
		CX = TSR ID number
		Return: AX = nonzero, invalid TSR number
		Note: if any interrupts used by TSR have been grabbed by
			another TSR, the TesSeRact routines will wait until
			it is safe to remove the indicated TSR from memory
	    13h restart TSR
		CX = TSR ID number of TSR which was unloaded but is still in
		     memory
		Return: AX = nonzero, unable to restart TSR
	    14h get status word
		CX = TSR ID number
		Return: AX = FFFFh invalid ID number
			   = other, successful
				BX = bit flags
	    15h set status word
		CX = TSR ID number
		DX = new bit flags
		Return: AX = nonzero, unable to set status word
	    16h get INDOS state at popup
		CX = TSR ID number
		Return: AX = 0000h successful
			    BX = value of INDOS flag
	    17h - 1Fh reserved
	    20h call user procedure
		CX = TSR ID number
		ES:DI -> user-defined data
		Return: AX = 0000h successful
	    21h stuff keystrokes into keyboard buffer
		CX = TSR ID number
		DL = speed
		    00h stuff keystrokes only when buffer is empty
		    01h stuff up to four keystrokes per clock tick
		    02h stuff up to 15 keystrokes per clock tick
		DH = scan code flag
		    if zero, buffer contains alternating ASCII and scan codes
		    if nonzero, buffer contains only ASCII codes
		SI = number of keystrokes
		ES:DI -> buffer to stuff
		Return: AX = 0000h success
			     F0F0h user aborted with ^C or ^Break
			     other unable to stuff keystrokes
	    22h (v1.10) trigger popup
		CX = TSR ID number
		Return: AX = 0000h success, TSR will either pop up or beep to
				   indicate that it is unable to pop up
			     nonzero invalid ID number
	    23h (v1.10) invoke TSR's background function
		CX = TSR ID number
		Return: AX = 0000h success
			     FFFFh not safe to call background function
			     nonzero invalid ID number
	    24h - 2Fh reserved
Notes:	Borland's THELP.COM popup help system for Turbo Pascal and Turbo C
	  (versions 1.x and 2.x only) fully supports the TesSeRact API, as
	  do the SWAP?? programs by Innovative Data Concepts.
	AVATAR.SYS supports functions 00h and 01h (only the first three fields
	  of the user parameter block) using the name "AVATAR  "
SeeAlso: AX=CAFEh

Format of User Parameter Block:
Offset	Size	Description
 00h  8 BYTEs	blank-padded TSR name
 08h	WORD	TSR ID number
 0Ah	DWORD	bitmap of supported functions
 0Eh	BYTE	scan code of primary hotkey
		    00h = pop up when shift states match
		    FFh = no popup (if shift state also FFh)
 0Fh	BYTE	shift state of primary hotkey
		    FFh = no popup (if scan code also FFh)
 10h	BYTE	number of secondary hotkeys
 11h	DWORD	pointer to extra hotkeys set by func 05h
 15h	WORD	current TSR status flags
 17h	WORD	PSP segment of TSR
 19h	DWORD	DTA for TSR
 1Dh	WORD	default DS for TSR
 1Fh	DWORD	stack at popup
 23h	DWORD	stack at background invocation

Format of TSR internal data area:
Offset	Size	Description
 00h	BYTE	revision level of TesSeRact library
 01h	BYTE	type of popup in effect
 02h	BYTE	INT 08 occurred since last invocation
 03h	BYTE	INT 13 occurred since last invocation
 04h	BYTE	active interrupts
 05h	BYTE	active soft interrupts
 06h	BYTE	DOS major version
 07h	BYTE	how long to wait before popping up
 08h	DWORD	pointer to INDOS flag
 0CH	DWORD	pointer to DOS critical error flag
 10h	WORD	PSP segment of interrupted program
 12h	WORD	PSP segment of prog interrupted by INT 28
 14h	DWORD	DTA of interrupted program
 18h	DWORD	DTA of program interrupted by INT 28
 1Ch	WORD	SS of interrupted program
 1Eh	WORD	SP of interrupted program
 20h	WORD	SS of program interrupted by INT 28
 22h	WORD	SP of program interrupted by INT 28
 24h	DWORD	INT 24 of interrupted program
 28h  3 WORDs	DOS 3+ extended error info
 2Eh	BYTE	old BREAK setting
 2Fh	BYTE	old VERIFY setting
 30h	BYTE	were running MS WORD 4.0 before popup
 31h	BYTE	MS WORD 4.0 special popup flag
 32h	BYTE	enhanced keyboard call in use
 33h	BYTE	delay for MS WORD 4.0
11 times (for INTs 08h,09h,13h,16h,1Ch,21h,28h,2Fh,1Bh,23h, and 24h):
	DWORD	old interrupt vector
	BYTE	interrupt number
	WORD	offset in TesSeRact code segment of new interrupt handler
----------2F5500-----------------------------
INT 2F U - DOS v5.0 - COMMAND.COM INTERFACE
	AX = 5500h
Return: AX = 0000h
	DS:SI -> entry point table
Notes:	used to access the shareable portion of COMMAND.COM, which may have
	  been moved into the HMA; only the primary COMMAND.COM retains this
	  portion
	procedures called from a dispatcher in COMMAND's resident portion;
	  most assume that the segment address of the resident portion is on
	  the stack and are thus not of general use
----------2F6282-----------------------------
INT 2F U - PC Tools v7.0+ VDEFEND, DATAMON - SET ??? ADDRESS
	AX = 6282h
	CX:DX -> ??? or 0000h:0000h
	DI = 0000h ???
	     FFFFh ???
	     other segment of ???
Return: BX = 0062h
Note:	if CX:DX = 0000h:0000h on entry, the ??? address is not changed
	  (DATAMON only)
SeeAlso: INT 21/AH=FAh"VDEFEND"
----------2F6284BX0000-----------------------
INT 2F U - PC Tools v7.0+ DATAMON - INSTALLATION CHECK
	AX = 6284h
	BX = 0000h
	CX = 0000h
Return: AX = segment of resident code
	BX = 5555h
	CX = 5555h
----------2F6284BX0001-----------------------
INT 2F U - PC Tools v7.0+ DATAMON - GET ???
	AX = 6284h
	BX = 0001h
	CX = 0001h
Return: AX:BX -> ???
	CX = BX
----------2F6284BX0002-----------------------
INT 2F U - PC Tools v7.0+ DATAMON - GET ???
	AX = 6284h
	BX = 0002h
	CX = 0002h
Return: AX = ???
	BX = ???
	CX = AX
	DX = BX
----------2F6284BX0003-----------------------
INT 2F U - PC Tools v7.0+ DATAMON - SET ??? FLAGS
	AX = 6284h
	BX = 0003h
	CX = flags
	    bit 12: ???
		10: ???
		 5: ???
		 3: ???
	DX = flags
	    bit 15: ???
----------2F6400-----------------------------
INT 2F - SCRNSAV2.COM - INSTALLATION CHECK
	AX = 6400h
Return: AL = 00h not installed
	     FFh installed
Note:	SCRNSAV2.COM is a screen saver for PS/2's with VGA by Alan Ballard
SeeAlso: INT 10/AX=5555h
----------2F7200-----------------------------
INT 2F - SRDISK v1.30 - INSTALLATION CHECK
	AX = 7200h
Return: AL = FFh if installed
	    ES = segment of device driver header (see below)
Note:	SRDISK is a freeware resizeable RAMdisk by Marko Kohtala

Format of device driver header:
Offset	Size	Description
 00h 10 BYTEs	same as standard device driver header (see INT 21/AH=52h)
 0Ah	BYTE	number of subunits (drives) supported by driver
 0Bh  3 BYTEs	signature "SRD"
 0Eh  4 BYTEs	memory type string (currently only "XMS ")
 12h  4 BYTEs	ASCII driver version string "N.NN"
 16h	BYTE	00h
 17h	BYTE	configuration format version (currently 00h)
 18h	WORD	offset of drive configuration data
----------2F7A00-----------------------------
INT 2F - Novell NetWare - LOW-LEVEL API (IPX) INSTALLATION CHECK
	AX = 7A00h
Return: AL = 00h not installed
	   = FFh installed
		ES:DI -> FAR entry point for routines accessed exclusively
			through INT 7A in NetWare versions through 2.0a.  Call
			with same values as INT 7A
SeeAlso: AX=7AFFh/BX=0000h,AX=D800h,INT 64"Novell",INT 7A"Novell"
----------2F7A10-----------------------------
INT 2F - Novell NetWare - TBMI v2.0 - GET TBMI STATUS
	AX = 7A10h
Return: DH = major TBMI version number
	DL = minor TBMI version number
	CX = segment address of TBMI resident part
	BX = status word of TBMI
		bit 0: INT2F intercepted by TBMI
		bit 1: INT7A intercepted by TBMI
		bit 2: INT64 intercepted by TBMI
		bits 3-14: reserved or unused ???
		bit 15: outstanding task ID was detected
Note:	TBMI is the Task-Switched Buffer Manager Interface
SeeAlso: AX=7A11h,AX=7A12h,AX=7A13h,AX=7A14h
----------2F7A11-----------------------------
INT 2F - Novell NetWare - TBMI v2.0 - GET INT2F HANDLERS
	AX = 7A11h
Return: ES:BX -> old INT 2F handler
	DS:DX -> TBMI INT 2F handler
SeeAlso: AX=7A10h,AX=7A12h,AX=7A13h
----------2F7A12-----------------------------
INT 2F - Novell NetWare - TBMI v2.0 - GET INT64 HANDLERS
	AX = 7A12h
Return: ES:BX -> old INT 64 handler
	DS:DX -> TBMI INT 64 handler
SeeAlso: AX=7A10h,AX=7A11h,AX=7A13h
----------2F7A13-----------------------------
INT 2F - Novell NetWare - TBMI v2.0 - GET INT7A HANDLERS
	AX = 7A13h
Return: ES:BX = old INT 7A handler
	DS:DX = TBMI INT 7A handler
SeeAlso: AX=7A10h,AX=7A11h,AX=7A12h
----------2F7A14-----------------------------
INT 2F - Novell NetWare - TBMI v2.0 - GET STATISTICS
	AX = 7A14h
	CX = statistic to retrieve
	    0000h available diagnostic functions???
		Return: CX = maximum available function??? (000Ch for v2.0)
	    0001h buffers in use
		Return: CX = TBMI buffers currently in use
	    0002h maximum buffers used
		Return: CX = maximum number of buffers ever in use
	    0003h unavailable buffers
		Return: CX = count of unavailable TBMI buffers
	    0004h old interrupt usage
		Return: CX = TBMI accesses to intercepted old vectors INT 2F,
				INT 64, and INT 7A
	    0005h far call usage
		Return: CX = TBMI accesses to IPX/SPX far call handler (not
				including internal accesses)
	    0006h task buffering
		Return: CX = TBMI task buffering status (enabled/disabled or
				disable/enable switch count???)
	    0007h current task ID
		Return: CX = TBMI current task ID number (0000h if ???)
	    0008h outstanding ID count
		Return: CX = number of outstanding TBMI IDs
	    0009h configured ECBs
		Return: CX = number of TBMI Event Control Blocks configured
	    000Ah configured data ECBs
		Return: CX = number of TBMI data ECBs configured
	    000Bh configured sockets
		Return: CX = number of TBMI sockets configured (from NETCFG)
	    000Ch current sockets
		Return: CX = number of TBMI sockets currently in use
SeeAlso: AX=7A10h
----------2F7A1B-----------------------------
INT 2F - Novell NetWare - TBMI v2.0 - RESERVED???
	AX = 7A1Bh
Note:	this call merely performs an IRET
----------2F7A80-----------------------------
INT 2F - Novell NetWare - shell 3.01d - ???
	AX = 7A80h
Return: nothing
Note:	apparently called on abnormal exit of the shell
----------2F7A81-----------------------------
INT 2F - Novell NetWare - shell 3.01d - ???
	AX = 7A81h
	CX:DX -> ??? in shell's CS (may be callback address or data structure)
Return: nothing???
----------2F7A85-----------------------------
INT 2F - Novell NetWare - shell 3.01 - BROADCAST INFORM
	AX = 7A85h
	CX = broadcast server number
Return: CX = 0000h if broadcast message handled by another program
	CX unchanged if broadcast not handled
----------2F7AFE-----------------------------
INT 2F - Novell NetWare - shell 3.01d - ???
	AX = 7AFEh
Return: AL = FFh ???
	     other ???
----------2F7AFFBX0000-----------------------
INT 2F - Novell NetWare - TBMI v2.0 - INSTALLATION CHECK???
	AX = 7AFFh
	BX = 0000h
	CX = 4E65h ("Ne")
	DX = 7457h ("tW")
	ES:DI -> IPX/SPX special handler (XMS/EMS ???)
Return: AL = FFh if installed
	    CX = configured sockets (14h)
	    DS:SI -> data table ???
	    ES:DI -> IPX far call handler
Note:	for IPX/SPX this call reportedly returns DS:DI pointing to the table
	  of pointers to service events queue head and tail
SeeAlso: AX=7AFFh/BX=0001h
----------2F7AFFBX0001-----------------------
INT 2F - Novell NetWare - TBMI v2.0, shell v3.01d - INSTALLATION CHECK???
	AX = 7AFFh
	BX = 0001h
	CX = 4E65h ("Ne")
	DX = 7457h ("tW")
Return: AL = FFh if installed
	    CX = ???  (8000h)
	    SI = ??? (or -> ???) (0002h)
	    ES:DI -> IPX far call handler
	    ES:DX -> 6-byte data area ???
SeeAlso: AX=7AFFh/BX=0000h
----------2F7F24-----------------------------
INT 2F - Multiplex - ???
	AX = 7F24h
	???
Return: ???
Note:	called by PC/370, an IBM 370 emulator by Donald S. Higgins
----------2F7F26-----------------------------
INT 2F - Multiplex - ???
	AX = 7F26h
	???
Return: ???
Note:	called by PC/370, an IBM 370 emulator by Donald S. Higgins
