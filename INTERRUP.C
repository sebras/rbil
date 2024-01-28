Interrupt List, part 3 of 15
Copyright (c) 1989,1990,1991,1992,1993,1994,1995,1996 Ralf Brown
--------T-1513-------------------------------
INT 15 - VMiX - "sys_wake" - WAKE SLEEPING PROCESS
	AH = 13h
	STACK:	WORD	process ID
Return: AX = status (SYS_OK or SYS_ERROR)
SeeAlso: AH=12h"VMiX"
--------T-1513-------------------------------
INT 15 - MultiDOS Plus - GET TASK CONTROL BLOCK
	AH = 13h
Return: BX:AX -> task control block (see #0357)
SeeAlso: AH=15h"MultiDOS"

Format of MultiDOS Plus v4.0 task control block:
Offset	Size	Description	(Table 0357)
 00h	DWORD	pointer to next TCB
 04h  8 BYTEs	ASCIZ task name
 0Ch  2 BYTEs	???
 0Eh	WORD	task PSP segment
 10h	WORD	abort/suspend flags
 12h	WORD	current screen segment (see AH=0Bh,AH=0Ch)
 14h	WORD	priority level (0000h-FFFEh)
 16h	WORD	time slice counter
 18h  2 BYTEs	???
 1Ah	WORD	suspend timer value
 1Ch	WORD	stack segment
 1Eh	WORD	stack pointer
 20h	WORD	display type
 22h	WORD	display memory
 24h  2 BYTEs	???
 26h	WORD	termination count
 28h	WORD	equipment flag for BIO10 driver
 2Ah	BYTE	background CRT mode
 2Bh	WORD	screen width in columns
 2Dh	WORD	screen size in bytes
 2Fh	WORD	segment of physical screen memory
 31h 16 BYTEs	eight cursor positions
 41h	WORD	current cursor shape
 43h	BYTE	active display page
 44h	WORD	CRT controller I/O port base
 46h  2 BYTEs	???
 48h	WORD	foreground task flag
 4Ah  6 BYTEs	???
 50h	WORD	saved video segment (see AH=0Bh,AH=0Ch)
 52h	DWORD	old INT 22
 56h	DWORD	old INT 23
 5Ah	DWORD	old INT 24
 5Eh	WORD	top of memory for task
 60h  4 BYTEs	???
 64h	WORD	DTA segment (see INT 21/AH=1Ah)
 66h	WORD	DTA offset
 68h  4 BYTEs	???
 6Ch	BYTE	current ANSI.SYS attribute
 6Dh	BYTE	current ANSI.SYS column
 6Eh	BYTE	current ANSI.SYS row
 6Fh	BYTE	current ANSI.SYS display state
 70h	BYTE	maximum ANSI.SYS columns
 71h	BYTE	current ANSI.SYS page
 72h	WORD	saved ANSI.SYS cursor position
 74h	BYTE	ANSI.SYS parameter buffer index
 75h	BYTE	current ANSI.SYS screen mode
 76h	BYTE	ANSI.SYS wrap flag
 77h  6 BYTEs	ANSI.SYS parameter buffer
 7Dh	BYTE	ANSI.SYS keyboard DSR state
 7Eh  7 BYTEs	ANSI.SYS keyboard DSR buffer
 85h  3 BYTEs	???
 88h 16 BYTEs	request header for DOS driver calls
 98h 14 BYTEs	???
 A6h	WORD	segment of EMS map if EMS task
 A8h	WORD	flag: task makes EMS calls
 AAh	WORD	EMS handle for task
 ACh	WORD	keyboard shift state
 AEh 12 BYTEs	???
 BAh	WORD	TCB of parent if child task
 BCh	WORD	termination code
 BEh	WORD	COM port number
 C0h  4 BYTEs	???
 C4h	WORD	current IRQ number
 C6h  2 BYTEs	???
 C8h	WORD	miscellaneous flag word
 CAh  2 BYTEs	???
 CCh	DWORD	old INT 10
 D0h	WORD	EMS alternate map set number
 D2h 414 BYTEs	DOS current disk and directory context (optional)
--------T-1514-------------------------------
INT 15 - VMiX - "sys_clrwindow" - CLEAR WINDOW
	AH = 14h
	STACK:	WORD	top left corner of window (high byte = row, low = col)
		WORD	bottom right corner of window (high = row, low = col)
Return: AX = status (SYS_OK)
Note:	clears window to color set with "sys_setcolors" (AH=18h)
SeeAlso: AH=15h"VMiX",AH=16h"VMiX",AH=18h"VMiX",AH=1Fh"VMiX"
--------T-1514-------------------------------
INT 15 - MultiDOS Plus - CHECK IF MultiDOS FOREGROUND OR BACKGROUND
	AH = 14h
Return: AX = current state
	    0000h MultiDOS Plus command prompt is background task
	    0001h command prompt is foreground task
SeeAlso: AH=0Bh"MultiDOS"
--------T-1515-------------------------------
INT 15 - VMiX - "sys_setbwindow" - SET BANNER WINDOW MESSAGE
	AH = 15h
	STACK:	DWORD	pointer to ASCIZ banner message for top of screen
Return: AX = status (SYS_OK)
SeeAlso: AH=14h"VMiX",AH=16h"VMiX"
--------T-1515-------------------------------
INT 15 - MultiDOS Plus - GET SYSTEM BLOCK
	AH = 15h
Return: BX:AX -> system block (see #0358)
SeeAlso: AH=13h"MultiDOS"

Format of MultiDOS Plus 4.0 system block:
Offset	Size	Description	(Table 0358)
 00h	WORD	segment of system control block
 02h	WORD	redirection flag set by /NOREDIRECT
 04h	WORD	no-INT 10 flag set by /NO10
 06h	DWORD	old INT 10
 0Ah	DWORD	new INT 10
 0Eh	DWORD	pointer to WORD with current TCB offset (see #0357)
 12h	DWORD	pointer to WORD with idle task TCB offset
 16h	DWORD	pointer to WORD with foreground TCB offset (see #0357)
 1Ah	DWORD	pointer to WORD with MultiDOS TCB offset (see #0357)
 1Eh	WORD	Task Control Block size
 20h	WORD	number of TCBs
 22h	WORD	flag: EMS present
 24h	WORD	EMS page frame base segment
 26h	WORD	16K pages in EMS page frame
 28h	WORD	base segment for conventional memory tasks
 2Ah	WORD	conventional memory size in paragraphs
 2Ch	DWORD	pointer to list of queue pointers
--------T-1516-------------------------------
INT 15 - VMiX - "sys_setwindow" - SET ROOT WINDOW SIZE AND HOME CURSOR
	AH = 16h
	STACK:	DWORD	pointer to I/O Request Packet
		WORD	top left corner of window (high byte = row, low = col)
		WORD	bottom right corner of window (high = row, low = col)
Return: AX = status (SYS_OK or SYS_ERROR)
SeeAlso: AH=14h"VMiX",AH=17h"VMiX"
--------T-1516-------------------------------
INT 15 - MultiDOS Plus - INITIALIZATION
	AH = 16h
Note:	used internally during initialization; any other calls will cause
	  unpredictable results
--------T-1517-------------------------------
INT 15 - VMiX - "sys_getcolors" - GET CONSOLE WINDOW COLORS
	AH = 17h
Return: AH = foreground color
	AL = background color
SeeAlso: AH=16h"VMiX",AH=18h"VMiX"
--------T-1517-------------------------------
INT 15 - MultiDOS Plus - MAP IRQ
	AH = 17h
	AL = IRQ to map (01h-0Fh)
	BX = offset of task control block (see #0357) to associate with IRQ
Return: AX = status
	    0000h successful
	    other invalid IRQ
Note:	the EMS map of the specified TCB is associated with the given interrupt
SeeAlso: AH=18h"MultiDOS",AH=19h"MultiDOS"
--------T-1518-------------------------------
INT 15 - VMiX - "sys_setcolors" - SET CONSOLE COLORS
	AH = 18h
	STACK:	WORD	new background/foreground colors
			bits 3-0: foreground
			bits 7-4: background
			bits 15-8: unused
Return: AX = color
SeeAlso: AH=14h"VMiX",AH=17h"VMiX",AH=19h"VMiX"
--------T-1518-------------------------------
INT 15 - MultiDOS Plus - UNMAP IRQ
	AH = 18h
	AL = IRQ to unmap (01h-0Fh)
Return: AX = status
	    0000h successful
	    0001h invalid IRQ
Note:	results are unpredictable if the IRQ has not been mapped
SeeAlso: AH=17h"MultiDOS",AH=19h"MultiDOS"
--------T-1519-------------------------------
INT 15 - VMiX v2+ - "sys_setconwn" - SET WINDOW COLORS
	AH = 19h
	STACK:	WORD	new background/foreground colors
			bits 3-0: foreground
			bits 7-4: background
			bits 15-8: unused
Return: AX = color
SeeAlso: AH=18h"VMiX"
--------T-1519-------------------------------
INT 15 - MultiDOS Plus - UNMAP ALL IRQs
	AH = 19h
Return: AX destroyed
Note:	for MultiDOS internal use only
SeeAlso: AH=17h"MultiDOS",AH=18h"MultiDOS"
--------T-151A-------------------------------
INT 15 - VMiX v2+ - "sys_sint" - INVOKE SOFTWARE INTERRUPT
	AH = 1Ah
	STACK:	WORD	interrupt number
		DWORD	pointer to register structure
Return: AX = returned flags
--------T-151A-------------------------------
INT 15 - MultiDOS Plus - MAP SEMAPHORE NAME TO NUMBER
	AH = 1Ah
	DS:SI -> 8-byte name
Return: AL = status
	    00h successful
		AH = semaphore number (20h-3Fh)
	    04h out of string space
Notes:	all eight bytes of the name are significant
	if the name does not already exist, it is added to the name table and
	  associated with a free semaphore number
	names cannot be destroyed
SeeAlso: AH=1Bh"MultiDOS",AH=1Ch"MultiDOS",AH=1Dh"MultiDOS"
--------T-151B-------------------------------
INT 15 - VMiX v2+ - "sys_blkmov" - MOVE MEMORY BLOCK
	AH = 1Bh
	STACK:	DWORD	source address
		DWORD	destination address
		WORD	number of words to move
Return: nothing
--------T-151B-------------------------------
INT 15 - MultiDOS Plus - REQUEST RESOURCE SEMAPHORE BY NAME
	AH = 1Bh
	DS:SI -> 8-byte name
Return: AH = status
	    00h successful
	    02h invalid semaphore number
	    03h caller already owns semaphore
	    04h out of string space
Notes:	(see AH=01h"MultiDOS")
	equivalent to AH=1Ah followed by AH=01h
SeeAlso: AH=01h"MultiDOS",AH=1Ah"MultiDOS",AH=1Ch"MultiDOS",AH=1Dh"MultiDOS"
--------T-151C-------------------------------
INT 15 - VMiX v2+ - "sys_bitblt" - PUT GRAPHICAL OBJECT AT CURSOR POSITION
	AH = 1Ch
	STACK:	WORD	AND/OR pixel with background (00h = OR, 01h = AND)
		DWORD	pointer to object bitmap
		WORD	object width in pixels
		WORD	object height in pixels
Return: nothing
SeeAlso: AH=1Dh"VMiX"
--------T-151C-------------------------------
INT 15 - MultiDOS Plus - RELEASE RESOURCE SEMAPHORE BY NAME
	AH = 1Ch
	DS:SI -> 8-byte name
Return: AH = status
	    00h successful
	    01h not semaphore owner
	    02h invalid semaphore number
	    04h out of string space
Notes:	(see AH=02h"MultiDOS")
	equivalent to AH=1Ah followed by AH=02h
SeeAlso: AH=02h"MultiDOS",AH=1Ah"MultiDOS",AH=1Bh"MultiDOS",AH=1Dh"MultiDOS"
--------T-151D-------------------------------
INT 15 - VMiX v2+ - "sys_getfont" - GET CURRENT CONSOLE GRAPHICS FONT
	AH = 1Dh
Return: AX = current font number (00h-03h)
SeeAlso: AH=1Ch"VMiX",AH=1Eh"VMiX"
--------T-151D-------------------------------
INT 15 - MultiDOS Plus - TEST RESOURCE SEMAPHORE BY NAME
	AH = 1Dh
	DS:SI -> 8-byte name
Return: AH = status
	    00h semaphore not in use
	    01h semaphore owned by another task
	    02h invalid semaphore number
	    03h caller owns semaphore
	    04h out of string space
Notes:	(see AH=10h"MultiDOS")
	equivalent to AH=1Ah followed by AH=10h
SeeAlso: AH=10h"MultiDOS",AH=1Ah"MultiDOS",AH=1Bh"MultiDOS",AH=1Ch"MultiDOS"
--------T-151E-------------------------------
INT 15 - VMiX v2+ - "sys_setfont" - SET CONSOLE GRAPHICS FONT
	AH = 1Eh
	STACK: WORD new font number (00h-03h)
Return: AX = current font number (00h-03h)
SeeAlso: AH=1Dh"VMiX"
--------T-151E00-----------------------------
INT 15 - MultiDOS Plus - CLEAR EVENT COUNTER
	AX = 1E00h
	DX = event/trigger number (00h-3Fh)
Return: AH = status
	    00h successful
SeeAlso: AX=1E01h,AX=1E02h
--------T-151E01-----------------------------
INT 15 - MultiDOS Plus - TRIGGER EVENT
	AX = 1E01h
	DX = event/trigger number (00h-3Fh)
Return: AH = status
	    00h successful
	    01h invalid event/trigger number
Notes:	schedules any task waiting for event; if no task is waiting, the event
	  counter is incremented (and will roll over if it was 65535)
	may be invoked by interrupt handler
SeeAlso: AX=1E00h,AX=1E02h
--------T-151E02-----------------------------
INT 15 - MultiDOS Plus - WAIT FOR EVENT
	AX = 1E02h
	DX = event/trigger number (00h-3Fh)
Return: AH = status
	    00h successful
	    01h invalid event/trigger number
Note:	if the event counter is zero, the task is suspended until the event is
	  triggered with AX=1E01h; else, the counter is decremented and the
	  call returns immediately
SeeAlso: AX=1E00h,AX=1E01h
--------T-151E08-----------------------------
INT 15 - MultiDOS Plus 4.01 - SET CONTEXT-SWITCH FUNCTIONS
	AX = 1E08h
	DX:BX -> context save handler (see #0359)
	DX:CX -> context restore handler (see #0359)
Note:	handlers may be removed by setting addresses to 0000h:0000h

(Table 0359)
Values MultiDOS Plus context-switch handlers are called with:
	ES:BX -> task's TCB
Return: all registers preserved
--------T-151F-------------------------------
INT 15 - VMiX v2.???+ - "sys_scrollwin" - SCROLL WINDOW
	AH = 1Fh
	STACK:	WORD	top left corner of window (high byte = row, low = col)
		WORD	bottom right corner of window
Return: AX = status (SYS_OK)
SeeAlso: AH=14h"VMiX",AH=18h"VMiX"
--------T-151F-------------------------------
INT 15 - MultiDOS Plus v4.01 - GET MEMORY PARAMETERS
	AH = 1Fh
Return: BX = first segment of conventional memory
	DX = first segment of EMS swap frame into which MultiDOS will load
		programs
--------T-1520-------------------------------
INT 15 - MultiDOS Plus v4.01 - CHECK IF MULTITASKING ENABLED
	AH = 20h
Return: AX = current state
	    0000h multitasking enabled
	    other TCB of task that disabled multitasking
SeeAlso: AH=0Dh"MultiDOS",AH=13h"MultiDOS"
--------c-152000-----------------------------
INT 15 U - DOS 3.0+ PRINT.COM - DISABLE CRITICAL REGION FLAG
	AX = 2000h
Desc:	stop setting user flag on entry to PRINT critical region
Note:	also supported by PC Network v1.00 RECEIVER.COM
SeeAlso: AX=2001h
--------c-152001-----------------------------
INT 15 U - DOS 3.0+ PRINT.COM - SET CRITICAL REGION FLAG
	AX = 2001h
	ES:BX -> byte which is to be incremented while in a DOS call
Desc:	specify a user flag which PRINT should set to let an interested
	  application know it is in a critical region
Note:	also supported by PC Network v1.00 RECEIVER.COM
SeeAlso: AX=2000h
--------O-152010-----------------------------
INT 15 - OS HOOK - SETUP SYSREQ ROUTINE (AT,XT286,PS50+)
	AX = 2010h
	???
Return: ???
SeeAlso: AX=2011h
--------O-152011-----------------------------
INT 15 - OS HOOK - COMPLETION OF SYSREQ FUNCTION (AT,XT286,PS50+)
	AX = 2011h
	???
Return: ???
SeeAlso: AX=2010h
--------B-1521-------------------------------
INT 15 - SYSTEM - POWER-ON SELF-TEST ERROR LOG (PS50+)
	AH = 21h
	AL = subfunction
	    00h read POST log
	    01h write POST log
		BH = device ID
		BL = error code
Return: CF set on error
	AH = status (00h OK, 01h list full, 80h invalid cmd, 86h unsupported)
	if function 00h:
	   BX = number of error codes stored
	   ES:DI -> error log
Notes:	the log is a series of words, the first byte of which identifies the
	  error code and the second the device.
	supported by AMI PCI BIOS
--------B-1522-------------------------------
INT 15 - SYSTEM - later PS/2s - LOCATE ROM BASIC
	AH = 22h
Return: CF set on error
	    AH = status (86h if function not supported)
	CF clear on success
	    AH = 00h
	    ES:BX -> ROM BASIC
Note:	if this function is not supported, ROM BASIC is at F600h:0000h
SeeAlso: INT 86"BASIC",INT F0"BASIC"
--------B-152300-----------------------------
INT 15 U - SYSTEM - PS/1s - GET ??? CMOS DATA
	AX = 2300h
Return: CF clear if successful
	    CL = value of CMOS location 2Dh
	    CH = value of CMOS location 2Eh
	CF set on error
	    AH = error code (80h,86h)
SeeAlso: AX=2301h,AX=2304h,AX=2305h
--------B-152301-----------------------------
INT 15 U - SYSTEM - PS/1s - SET ??? CMOS DATA
	AX = 2301h
	CL = new value for CMOS location 2Dh
	CH = new value for CMOS location 2Eh
Return: CF clear if successful
	CF set on error
	    AH = error code (80h,86h)
Note:	sets the contents of CMOS locations 2Dh and 2Eh
SeeAlso: AX=2300h,AX=2304h,AX=2305h
--------B-152302-----------------------------
INT 15 U - SYSTEM - PS/1s - GET ROM STARTUP VIDEO REGISTER TABLES
	AX = 2302h
	BL = data index (00h-0Dh) (see #0360)
Return: ES:BX -> table for register (see #0361,#0362)
	CX = size of table in bytes (may be 0000h)

(Table 0360)
Values for PS/1 ROM startup video register tables:
 00h	DAC registers
 01h	???
 02h	Palette registers
 03h-0Dh ???

Format of PS/1 ROM startup DAC register table:
Offset	Size	Description	(Table 0361)
 00h	WORD	number of DAC registers in table
 02h	var	array of 3-byte DAC register values, starting at register 00h
SeeAlso: #0360

Format of PS/1 ROM startup Palette register table:
Offset	Size	Description	(Table 0362)
 00h 16 BYTEs	colors for palette registers 00h through 0Fh
 10h	BYTE	border color
SeeAlso: #0360,#0017
--------B-152303-----------------------------
INT 15 U - SYSTEM - PS/1s - ???
	AX = 2303h
	BX = ??? ('x')
	DX = 'y' and 'z'
		bits 15-7 = 'y'
		bits 6-3 unused
		bits 2-0 = 'z'
	DI = ??? (0352h)
Return: ???
Note:	performs graphics functions, writes to segment A000h and VGA I/O ports
--------B-152304-----------------------------
INT 15 U - SYSTEM - PS/1s - SYSTEM SETUP
	AX = 2304h
	DX = segment of 32K buffer
Return: CF clear if successful
	    AX = 0003h (left over from setting video mode 3)
	    BX,CX,DX,BP,DS,ES destroyed
	CF set on error
	    AH = error code (80h,86h)
SeeAlso: AX=2301h,AX=2305h
--------B-152305-----------------------------
INT 15 U - SYSTEM - PS/1s - GET PROCESSOR SPEED
	AX = 2305h
Return: CF clear if successful
	    AL = processor speed in MHz
	CF set on error
	    AL = FFh (speed > 80 MHz)
	    AL = error code (80h,86h = unsupported function)
SeeAlso: AX=2301h,AX=2304h,AH=BCh
--------b-152400-----------------------------
INT 15 - SYSTEM - later PS/2s - DISABLE A20 GATE
	AX = 2400h
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status
		01h keyboard controller is in secure mode
		86h function not supported
Note:	also supported by AMI PCI BIOS and Qualitas 386MAX v6.01+
BUG:	AMI BIOS v1.00.03.AV0M never reports an error on failure to disable
	  the A20 gate; it simply writes 0 to PORT 0092h
SeeAlso: AX=2401h,AX=2402h,AX=2403h,PORT 0092h
--------b-152401-----------------------------
INT 15 - SYSTEM - later PS/2s - ENABLE A20 GATE
	AX = 2401h
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status
		01h keyboard controller is in secure mode
		86h function not supported
Note:	also supported by AMI PCI BIOS and Qualitas 386MAX v6.01+
SeeAlso: AX=2400h,AX=2402h,PORT 0092h
--------b-152402-----------------------------
INT 15 - SYSTEM - later PS/2s - GET A20 GATE STATUS
	AX = 2402h
Return: CF clear if successful
	    AH = 00h
	    AL = current state (00h disabled, 01h enabled)
	    CX = ??? (set to 0000h-000Bh or FFFFh by AMI BIOS v1.00.03.AV0M)
		FFFFh if keyboard controller does not become ready within C000h
			 read attempts
	CF set on error
	    AH = status
		01h keyboard controller is in secure mode
		86h function not supported
Note:	also supported by AMI PCI BIOS and Qualitas 386MAX v6.01+
SeeAlso: AX=2400h,AX=2401h
--------b-152403-----------------------------
INT 15 - SYSTEM - later PS/2s - QUERY A20 GATE SUPPORT
	AX = 2403h
Return: CF clear if successful
	    AH = 00h
	    BX = status of A20 gate support (see #0363)
	CF set on error
	    AH = status
		01h keyboard controller is in secure mode
		86h function not supported
Note:	also supported by AMI PCI BIOS and Qualitas 386MAX v6.01+
BUG:	at one point early in processing INT 15/AH=24h, the AMI PCI BIOS
	  version 1.00.05.AX1 compares whether AL==03h instead of AL>=03h,
	  thus causing a random branch on any value of AL greater than 3.
SeeAlso: AX=2402h

Bitfields for A20 gate support status:
Bit(s)	Description	(Table 0363)
 0	supported on keyboard controller
 1	supported with bit 1 of I/O port 92h
 15	additional data is available (location not yet defined)
--------T-153000-----------------------------
INT 15 - Object Kernel for DOS - INSTALLATION CHECK
	AX = 3000h
Return: AX:BX = 4F42h:4A21h ('OBJ!') if installed
	    CX = resident segment
Program: the Object Kernel is a program by M.W. Pieters which is currently
	  under development
Note:	Central Point's CPBACKUP v9 calls INT 15/AX=3000h at startup, but it
	  may be checking for a different program's presence
SeeAlso: AX=3001h,AX=3008h
--------T-153001-----------------------------
INT 15 - Object Kernel for DOS - GET STATUS BLOCK
	AX = 3001h
Return: AX = FFFFh
	ES:DI -> status block
SeeAlso: AX=3000h,AX=3008h
--------T-153002-----------------------------
INT 15 - Object Kernel for DOS - KILL PROCESS
	AX = 3002h
	(not yet implemented)
SeeAlso: AX=3000h
--------T-153003-----------------------------
INT 15 - Object Kernel for DOS - STOP PROCESS
	AX = 3003h
	(not yet implemented)
SeeAlso: AX=3000h
--------T-153004-----------------------------
INT 15 - Object Kernel for DOS - START PROCESS
	AX = 3004h
	(not yet implemented)
SeeAlso: AX=3000h
--------T-153005-----------------------------
INT 15 - Object Kernel for DOS - RESTART PROCESS
	AX = 3005h
	(not yet implemented)
SeeAlso: AX=3000h
--------T-153006-----------------------------
INT 15 - Object Kernel for DOS - EXECUTE PROCESS
	AX = 3006h
	(not yet implemented)
SeeAlso: AX=3000h
--------T-153007-----------------------------
INT 15 - Object Kernel for DOS - LIST PROCESSES
	AX = 3007h
	(not yet implemented)
SeeAlso: AX=3000h
--------T-153008-----------------------------
INT 15 - Object Kernel for DOS - SWITCH ObjectKernel ON/OFF
	AX = 3008h
	BH = new state (00h disabled, 01h enabled)
Return: AX = FFFFh
SeeAlso: AX=3000h,AX=3009h
--------T-153009-----------------------------
INT 15 - Object Kernel for DOS - RESERVED FOR FUTURE USE
	AX = 3009h to 30FFh
SeeAlso: AX=3000h
Program: the Object Kernel is a program by M.W. Pieters which is currently
	  under development
--------B-1540-------------------------------
INT 15 - SYSTEM - READ/MODIFY PROFILES (CONVERTIBLE)
	AH = 40h
	AL = subfunction
	    00h get system profile in CX and BX
	    01h set system profile from CX and BX
	    02h get internal modem profile in BX
	    03h set internal modem profile from BX
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (80h = profile execution failed)
--------V-154000-----------------------------
INT 15 - Compaq SLT/286 or Portable 386 - READ LCD/PLASMA TIMEOUT
	AX = 4000h
Return: AX = 4000h
	CL = timeout in minutes, 00h if disabled
SeeAlso: AX=4001h,AX=4600h
--------V-154001-----------------------------
INT 15 - Compaq SLT/286 or Portable 386 - SET LCD/PLASMA TIMEOUT
	AX = 4001h
	CL = timeout in minutes, 00h to disable
Return: AL = status
	    00h timeout modified
	    01h timeout cannot be modified
	    40h timeout cannot be modified
	CL = timeout in minutes, 00h if disabled
SeeAlso: AX=4000h,AX=4601h
--------B-1541-------------------------------
INT 15 - SYSTEM - WAIT ON EXTERNAL EVENT (CONVERTIBLE and some others)
	AH = 41h
	AL = condition type (see #0364)
	BH = condition compare or mask value
	BL = timeout value times 55 milliseconds
	    00h means no timeout
	DX = I/O port address if AL bit 4 set
	ES:DI -> user byte if AL bit 4 clear
Note:	call AH=C0h and examine bit 3 of feature byte 1 to determine whether
	  this function is supported
SeeAlso: AH=83h,AH=86h,AH=C0h

Bitfields for external event wait condition type:
Bit(s)	Description	(Table 0364)
 0-2	condition to wait for
	0 any external event
	1 compare and return if equal
	2 compare and return if not equal
	3 test and return if not zero
	4 test and return if zero
 3	reserved
 4	1=port address, 0=user byte
 5-7	reserved
--------B-1542-------------------------------
INT 15 - SYSTEM - REQUEST POWER OFF (CONVERTIBLE,HP 95LX)
	AH = 42h
	AL = suspend type
	    00h to use system profile
	    01h to force suspend regardless of system profile
Note:	the HP 95LX apparently suspends regardless of the value in AL; on
	  power-up, execution will resume following the instruction calling
	  this function
SeeAlso: AH=44h
--------b-154280-----------------------------
INT 15 - Compaq SLT/286 - ENTER STANDBY
	AX = 4280h
Return: AH = 42h
	CF clear if successful
	CF set if unable to enter standby
SeeAlso: AX=4600h,AX=5307h/BX=0001h/CX=0001h
--------B-1543-------------------------------
INT 15 - SYSTEM - READ SYSTEM STATUS (CONVERTIBLE)
	AH = 43h
Return: AL = status bits (see #0365)

Bitfields for Convertible system status:
Bit(s)	Description	(Table 0365)
 7	power low
 6	external power in use
 5	standby power lost
 4	power activated by alarm
 3	internal modem powered on
 2	RS232/parallel adapter powered on
 1	reserved
 0	LCD detached
--------B-1544-------------------------------
INT 15 - SYSTEM - (DE)ACTIVATE INTERNAL MODEM POWER (CONVERTIBLE)
	AH = 44h
	AL = new modem power state (00h power off, 01h power on)
SeeAlso: AH=42h
--------b-1544C0-----------------------------
INT 15 - Olivetti Quaderno - INITIALIZE DIGITAL SIGNAL PROCESSING???
	AX = 44C0h
	ES:DI -> new DSP procedure (exchanged with CMOS[28h])
	ES:SI -> ??? buffer
Return: ES:DI -> old DSP procedure
	ES:SI buffer filled with ten bytes from CMOS (addresses 14h-1Ch)
	  followed by 00h (addresses 15h-1Ch copied only if less than 21h)
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C9h
--------b-1544C1-----------------------------
INT 15 - Olivetti Quaderno - ???
	AX = 44C1h
	???
Return: ???
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C9h
--------b-1544C2-----------------------------
INT 15 - Olivetti Quaderno - ???
	AX = 44C2h
	DL = byte to be written to I/O port 350h
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C3h,AX=44C9h
--------b-1544C3-----------------------------
INT 15 - Olivetti Quaderno - GET ???
	AX = 44C3h
Return: DH = bitfields (see #0366)
	DL = value read from I/O port 350h
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C2h,AX=44C9h

Bitfields for Olivetti Quaderno ???:
Bit(s)	Description	(Table 0366)
 5-7	5-7 read from I/O port 351h
 2-4	zero
 1-0	"tres complique"
--------b-1544C4-----------------------------
INT 15 - Olivetti Quaderno - ???
	AX = 44C4h and 44C5h
	???
Return: ???
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C9h
--------b-1544C6-----------------------------
INT 15 - Olivetti Quaderno - READ LCD
	AX = 44C6h
Return: DX = FFFFh clock is displayed on LCD display
	DX = other: hex number displayed in first four positions of display
	BH = left alphanumeric character on display (see #0367)
	BL = right alphanumeric character on display (see #0367)
	CL = colon flags (see #0368)
Notes:	the LCD display has the format HH:HH:AA, where H is a hex digit and A
	  is an alphanumeric character
	this function is also supported by XBIOS.COM
SeeAlso: AX=44C7h,AX=44C9h

(Table 0367)
Values for Olivetti Quaderno LCD alphanumeric characters:
 00h-0Fh hex digit
 2Bh	"+"
 2Dh	"-"
 30h-39h "0" to "9"
 41h-5Ah "A" to "Z"
 61h-6Ah "a" to "z"
 else	blank

Bitfields for Olivetti Quaderno LCD colon flags:
Bit(s)	Description	(Table 0368)
 0	left colon on
 1	right colon on
 2-7	unused
--------b-1544C7-----------------------------
INT 15 - Olivetti Quaderno - WRITE LCD
	AX = 44C7h
	DX = hex display
	    FFFFh display clock and "HI", "Md", or "Lo"
		BH,BL,CL unused
	    other: display specified hex number in first four positions
		BH = left alphanumeric character on display (see #0367)
		BL = right alphanumeric character on display (see #0367)
		CL = colon flags (see #0368)
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C6h
--------b-1544C8-----------------------------
INT 15 - Olivetti Quaderno - ???
	AX = 44C8h
	CL = ??? (00h,02h,21h)
	CH = ???
	???
Return: ???
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C9h
--------b-1544C9-----------------------------
INT 15 - Olivetti Quaderno - GET XBIOS VERSION
	AX = 44C9h
Return: AL = major version
	AH = minor version
Note:	this function is also supported by XBIOS.COM
--------B-1544F1-----------------------------
INT 15 U - Toshiba laptops - SECURITY LEVEL CHECK
	AX = 44F1h
	DS:DX -> byte with 00h ???
Return: ???
Note:	used by Toshiba BIOS setup utility TSETUP.EXE to distinguish
	  between USER and SUPERVISOR security level
SeeAlso: AX=44F2h,AX=44F3h
--------B-1544F2BX0604-----------------------
INT 15 U - Toshiba laptops - SECURITY LEVEL CHECK
	AX = 44F2h
	BX = 0604h ???
Return: CF = ???
	AH = ???
	DX = ???
Note:	used by Toshiba BIOS setup utility TSETUP.EXE to distinguish
	  between USER and SUPERVISOR security level
SeeAlso: AX=44F1h,AX=44F3h
--------B-1544F3-----------------------------
INT 15 U - Toshiba laptops - SECURITY LEVEL CHECK
	AX = 44F3h
	DS:DX -> byte with 00h or 01h ???
Return: DS:DX -> changed ???
Note:	used by Toshiba BIOS setup utility TSETUP.EXE to distinguish
	  between USER and SUPERVISOR security level
SeeAlso: AX=44F1h,AX=44F2h
--------b-1545-------------------------------
INT 15 U - HP 100LX/200LX - SET DISPLAY CONTROL STATUS
	AH = 45h
	AL = new display control status
	    bit 0: DISPCTL flag +C instead of -C
	    bit 1: DISPCTL flag +K instead of -K
SeeAlso: AH=46h"HP",AX=4700h"HP"
--------b-1546-------------------------------
INT 15 U - HP 100LX/200LX - SET POWER OFF TIMEOUT
	AH = 46h
	BX = timeout value in ticks
	    0000h inhibit auto power off
Note:	the 200LX default timeout is 0CCDh = 3277 ticks = approx. 3 min.
SeeAlso: AH=45h"HP",AX=4700h"HP"
--------b-154600-----------------------------
INT 15 - Compaq SLT/286 - READ POWER CONSERVATION/MODEM CONFIGURATION
	AX = 4600h
Return: AH = modem configuration information (see #0369)
	AL = power conservation status information (see #0370)
	BH = default system inactivity timeout (1-21 minutes)
	BL = current system inactivity timeout (1-21 minutes)
	CH = default video display inactivity timeout (1-63 minutes)
	CL = current video display inactivity timeout (1-63 minutes)
	DH = default fixed disk drive inactivity timeout (1-21 minutes)
	DL = current fixed disk drive inactivity timeout (1-21 minutes)
SeeAlso: AX=4280h,AX=4601h,INT 77

Bitfields for Compaq SLT/286 modem configuration information:
Bit(s)	Description	(Table 0369)
 0	powerup state (0 off, 1 on)
 1	modem installed
 2	IRQ line assignment (0 IRQ 4, 1 IRQ 3)
 3	COM port assignment (0 = COM 2, 1 = COM 1)
 4	modem state (0 not assigned, 1 assigned)
 5	modem is on

Bitfields for Compaq SLT/286 power conservation status:
Bit(s)	Description	(Table 0370)
 0	power source (0 internal, 1 external)
 1-2	low battery state
	00 no low battery condition
	01 low battery 1
	10 reserved
	11 low battery 2
 3-4	power conservation mode
	00 automatic, 01 on, 10 off, 11 reserved
--------b-154601-----------------------------
INT 15 - Compaq SLT/286 - MODIFY POWER CONSERVATION/MODEM CONFIGURATION
	AX = 4601h
	BL = system inactivity timeout (1-21 minutes)
	    FFh do not change
	CL = video display inactivity timeout (1-63 minutes)
	    FFh do not change
	DL = current fixed disk drive inactivity timeout (1-21 minutes)
	    FFh do not change
	DH = new modem state (00h turn off, 01h turn on, FFh don't change)
Return: CF clear if successful
	    AH = 00h
	    BL = current system inactivity timeout (1-21 minutes)
	    CL = current video display inactivity timeout (1-63 minutes)
	    DL = current fixed disk drive inactivity timeout (1-21 minutes)
	    DH = modem state (FFh unchanged, 00h turned off, 01h turned on)
	CF set on error
	    AH = error code
		01h input is out of range
		02h no modem present
SeeAlso: AX=4600h,INT 77
--------b-154604-----------------------------
INT 15 - Compaq Contura 486 and "Alladin" 08/05/93 ROMs - GET ???
	AX = 4604h
Return: CF clear if successful
	    AL = byte read from I/O port 03F8h
	CF set on error (not supported)
	    AH = 86h (unsupported function)
Note:	also supported by 7/26/93 LTE Lite 386 ROM
--------b-154605-----------------------------
INT 15 - Compaq Contura 486 and "Alladin" 08/05/93 ROMs - ???
	AX = 4605h
Return: CF clear if successful
	CF set on error (not supported)
	    AH = 86h (unsupported function)
Note:	this function is a NOP (other than clearing CF) in the 08/05/93 version
	  of the Contura 486/486c/486cx and "Aladdin" ROM, and the 7/26/93
	  LTE Lite 386 ROM
--------b-1547-------------------------------
INT 15 U - HP 100LX/200LX - GET/SET DISPLAY CONTRAST
	AH = 47h
	AL = subfunction
	   00h set contrast
		BL = new contrast
		    (00h-0Fh, 0Fh is darkest, 10h-FFh are same as 0Fh)
	   other get current contrast
Return:	AL = contrast (00h-0Fh, 0Fh is darkest)
Note:	may be for backward compatibility with HP95LX, as INT 15/AH=62h does
	  substantially the same thing as this function
SeeAlso: AH=45h"HP",AH=48h"HP",AH=62h"HP"
--------b-1548-------------------------------
INT 15 U - HP 100LX/200LX - SET BUZZER VOLUME
	AH = 48h
	AL = volume (00h-03h; 03h is loudest, 04h-FFh are same as 03h)
SeeAlso: AH=47h"HP"
--------S-1549-------------------------------
INT 15 U - HP 100LX/200LX - SERIAL INTERFACE SELECT
	AH = 49h
	AL = serial interface
	    00h wired (COM1)
	    01h infrared
Note:	interface should only be changed in deactivated state (see AH=4Ah)
SeeAlso: AH=4Ah"HP"
--------J-154900-----------------------------
INT 15 - Far East MS-DOS - GET BIOS TYPE
	AX = 4900h
Return: CF clear if successful
	    AH = 00h
	    BL = BIOS mode
		00h DOS/V
		01h standard DBCS DOS (hardware DBCS support)
	CF set on error
	    AH = 86h (function not supported)
Note:	in practice, DOS/J returns AH=86h; AX DOS does not support this call
SeeAlso: AH=50h,INT 21/AH=30h
--------S-154A-------------------------------
INT 15 U - HP 100LX/200LX - SERIAL INTERFACE CONTROL
	AH = 4Ah
	AL = control
	    00h deactivate
	    01h activate
Note:	interface selected with AH=49h will be (de)activated
SeeAlso: AH=49h"HP",AH=4Bh"HP"
--------b-154B-------------------------------
INT 15 U - HP 100LX/200LX - ADJUST SYSTEM TIME
	AH = 4Bh
Desc:	adjust system time based on real-time clock
SeeAlso: AH=4Ah"HP",INT 1A/AH=02h,INT 21/AH=2Ch
--------b-154DD4-----------------------------
INT 15 - HP 95LX/100LX/200LX - INSTALLATION CHECK
	AX = 4DD4h
Return: BX = 4850h ("HP") if HP 95LX/100LX/200LX
	    CX = model
		0101h HP 95LX
		0102h HP 100LX/200LX
	    DH = ???
		02h HP 200LX 2MB BIOS 1.01 A D german
	    DL = ???
		00h HP 95LX
		01h HP 200LX 2MB BIOS 1.01 A D german
SeeAlso: INT 0B"HP 95LX",INT 0F"HP 95LX",INT 5F/AH=00h,INT 60/DI=0100h
SeeAlso: INT 61"HP 95LX"
--------b-154E-------------------------------
INT 15 - HP 95LX - ENABLE/DISABLE LIGHT SLEEP
	AH = 4Eh
	AL = light sleep
	    00h disabled
	    01h enabled
Note:	when light sleep is disabled, the system will continue running at full
	  speed; when enabled, it may automatically slow to conserve batteries
SeeAlso: INT 06"HP 95LX",INT 60/DI=0100h
--------B-154F-------------------------------
INT 15 C - KEYBOARD - KEYBOARD INTERCEPT (AT model 3x9,XT2,XT286,CONV,PS)
	AH = 4Fh
	AL = hardware scan code (see #0005)
	CF set
Return: CF set to continue processing scan code
	   AL = possibly-altered hardware scan code (see #0005)
	CF clear
	   scan code should be ignored
Notes:	called by INT 09 handler to translate scan codes; the INT 09 code does
	  not examine the scan code it reads from the keyboard until after
	  this function returns.  This permits software to rearrange the
	  keyboard; for example, swapping the CapsLock and Control keys, or
	  turning the right Shift key into Enter.
	DOS 6 KEYB.COM will not pass through this function if Ctrl-Alt-Del is
	  pressed and a SmartDrive v4-compatible cache is installed which has
	  dirty cache buffers; some other disk caches such as HyperDisk
	  operate similarly in order to prevent loss of cached data which has
	  not yet been written to disk
SeeAlso: INT 09,INT 15/AH=C0h
--------J-1550-------------------------------
INT 15 - DOS/V - FONT SUBSYSTEM ACCESS
	AH = 50h
	AL = which function address to retrieve
	    00h "read font" function
	    01h "write font" function
	BL = 00h
	BH = character size (00h single-byte, 01h double-byte)
	DH = width of character cell
	DL = height of character cell
	BP = code page (see #0371)
Return: CF clear if successful
	    AH = 00h
	    ES:BX -> requested function's address
	CF set on error
	    AH = error code (see #0372)
SeeAlso: AH=49h

(Table 0371)
Values for DOS/V code page:
 0	default
 437	US English
 932	Japanese
 934	Korea
 936	China
 938	Taiwan
SeeAlso: #1060

(Table 0372)
Values for DOS/V error code:
 01h	invalid font type in BH
 02h	BL not zero
 03h	invalid font size
 04h	invalid code page
 80h	unsupported function (PC)
 86h	unsupported function (XT)
SeeAlso: #0980
--------T-1550-------------------------------
INT 15 - VMIX v2.???+ - "sys_vm_page" - SET NEW VIRTUAL PAGE TABLE
	AH = 50h
	BX = segment of page directory table
	CX = page number of page table
SeeAlso: AH=10h"VMiX",AH=51h"VMiX",AH=52h"VMiX"
--------T-1551-------------------------------
INT 15 - VMiX v2.???+ - "sys_vm_func" - EXECUTE FUNCTION IN PROTECTED MODE
	AH = 51h
	STACK:	DWORD	selector:offset of function
Return: registers as returned by function
Note:	executes function with privilege level 0 (highest privilege)
SeeAlso: AH=10h"VMiX",AH=52h"VMiX"
--------B-155101-----------------------------
INT 15 - SYSTEM - later PS/2s - EXPANSION UNIT, RETURN CONFIGURATION NUMBER
	AX = 5101h
Return: CF set if successful
	    AH = 00h
	    AL = current configuration number
		00h system unit only
		FFh configuration not recognized
	    BX = status flag
		bits 0-14: reserved
		bit 15: additional data is available (location TBD)
	CF clear on error
	    AH = status
		01h expansion unit is not present
		86h function not supported
Note:	CF convention is the reverse of the standard convention for this
	  interrupt.  (Perhaps a typo in the IBM BIOS Tech Ref?)
--------T-1552-------------------------------
INT 15 - VMiX v2.???+ - "sys_vm_init" - INITIALIZE PROTECTED-MODE ENVIRONMENT
	AH = 52h
SeeAlso: AH=50h"VMiX",AH=51h"VMiX"
--------d-1552-------------------------------
INT 15 C - IBM/MS INT 13 Extensions - MEDIA EJECT INTERCEPT
	AH = 52h
	DL = drive number
Return: CF clear if OK to eject media
	    AH = 00h
	CF set if ejection disallowed
	    AH = error code (B1h,B3h) (see #0142)
Note:	called by the IBM/MS INT 13 Extensions driver/BIOS when an ejection
	  request is made
SeeAlso: INT 13/AH=46h"INT 13 Extensions"
--------p-155300-----------------------------
INT 15 - Advanced Power Management Specification - INSTALLATION CHECK
	AX = 5300h
	BX = device ID of system BIOS (0000h)
Return: CF clear if successful
	    AH = major version (BCD)
	    AL = minor version (BCD)
	    BX = 504Dh ("PM")
	    CX = flags (see #0373)
	CF set on error
	    AH = error code (06h,86h) (see #0374)
BUG:	early versions of the Award Modular BIOS with built-in APM support
	  reportedly do not set BX on return

Bitfields for APM flags:
Bit(s)	Description	(Table 0373)
 0	16-bit protected mode interface supported
 1	32-bit protected mode interface supported
 2	CPU idle call reduces processor speed
 3	BIOS power management disabled
 4	BIOS power management disengaged (APM v1.1)
 5-7	reserved

(Table 0374)
Values for APM error code:
 01h	power management functionality disabled
 02h	interface connection already in effect
 03h	interface not connected
 04h	real-mode interface not connected
 05h	16-bit protected-mode interface already connected
 06h	16-bit protected-mode interface not supported
 07h	32-bit protected-mode interface already connected
 08h	32-bit protected-mode interface not supported
 09h	unrecognized device ID
 0Ah	invalid parameter value in CX
 0Bh	(AMI BIOS) APM already disconnected???
 0Ch-1Fh reserved for other interface and general errors
 20h-3Fh reserved for CPU errors
 40h-5Fh reserved for device errors
 60h	can't enter requested state
 61h-7Fh reserved for other system errors
 80h	no power management events pending
 81h-85h reserved for other power management event errors
 86h	APM not present
 87h-9Fh reserved for other power management event errors
--------p-155301-----------------------------
INT 15 - Advanced Power Management Specification - CONNECT REAL-MODE INTERFACE
	AX = 5301h
	BX = device ID of system BIOS (0000h)
Return: CF clear if successful
	CF set on error
	    AH = error code (02h,05h,07h,09h) (see #0374)
SeeAlso: AX=5302h,AX=5303h,AX=5304h
--------p-155302-----------------------------
INT 15 R - Advanced Power Management Spec - CONNECT 16-BIT PROTMODE INTERFACE
	AX = 5302h
	BX = device ID of system BIOS (0000h)
Return: CF clear if successful
	    AX = real-mode segment base address of protected-mode 16-bit code
		segment
	    BX = offset of entry point
	    CX = real-mode segment base address of protected-mode 16-bit data
		segment
	    ---APM v1.1---
	    SI = APM BIOS code segment length
	    DI = APM BIOS data segment length
	CF set on error
	    AH = error code (02h,05h,06h,07h,09h) (see #0374)
Notes:	the caller must initialize two consecutive descriptors with the
	  returned segment base addresses; these descriptors must be valid
	  whenever the protected-mode interface is called, and will have
	  their limits arbitrarily set to 64K.
	the protected mode interface is invoked by making a far call with the
	  same register values as for INT 15; it must be invoked while CPL=0,
	  the code segment descriptor must have a DPL of 0, the stack must be
	  in a 16-bit segment and have enough room for BIOS use and possible
	  interrupts, and the current I/O permission bit map must allow access
	  to the I/O ports used for power management.
	functions 00h-03h are not available from protected mode
SeeAlso: AX=5301h,AX=5303h,AX=5304h
--------p-155303-----------------------------
INT 15 - Advanced Power Management Spec - CONNECT 32-BIT PROTMODE INTERFACE
	AX = 5303h
	BX = device ID of system BIOS (0000h)
Return: CF clear if successful
	    AX = real-mode segment base address of protected-mode 32-bit code
		segment
	    EBX = offset of entry point
	    CX = real-mode segment base address of protected-mode 16-bit code
		segment
	    DX = real-mode segment base address of protected-mode 16-bit data
		segment
	    ---APM v1.1---
	    SI = APM BIOS code segment length
	    DI = APM BIOS data segment length
	CF set on error
	    AH = error code (02h,05h,07h,08h,09h) (see #0374)
Notes:	the caller must initialize three consecutive descriptors with the
	  returned segment base addresses for 32-bit code, 16-bit code, and
	  16-bit data, respectively; these descriptors must be valid whenever
	  the protected-mode interface is called, and will have their limits
	  arbitrarily set to 64K.
	the protected mode interface is invoked by making a far call to the
	  32-bit code segment with the same register values as for INT 15; it
	  must be invoked while CPL=0, the code segment descriptor must have a
	  DPL of 0, the stack must be in a 32-bit segment and have enough room
	  for BIOS use and possible interrupts, and the current I/O permission
	  bit map must allow access to the I/O ports used for power management.
	functions 00h-03h are not available from protected mode
SeeAlso: AX=5301h,AX=5302h,AX=5304h
--------p-155304-----------------------------
INT 15 - Advanced Power Management Specification - DISCONNECT INTERFACE
	AX = 5304h
	BX = device ID of system BIOS (0000h)
Return: CF clear if successful
	CF set on error
	    AH = error code (03h,09h) (see #0374)
SeeAlso: AX=5301h,AX=5302h,AX=5303h
--------p-155305-----------------------------
INT 15 - Advanced Power Management Specification - CPU IDLE
	AX = 5305h
Return: CF clear if successful (after system leaves idle state)
	CF set on error
	    AH = error code (03h,0Bh) (see #0374)
Notes:	call when the system is idle and should be suspended until the next
	  system event or interrupt
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
	if an interrupt causes the system to resume normal processing, the
	  interrupt may or may not have been handled when the BIOS returns
	  from this call; thus, the caller should allow interrupts on return
	interrupt handlers may not retain control if the BIOS allows
	  interrupts while in idle mode even if they are able to determine
	  that they were called from idle mode
	the caller should issue this call continuously in a loop until it needs
	  to perform some processing of its own
SeeAlso: AX=1000h,AX=5306h,INT 2F/AX=1680h
--------p-155306-----------------------------
INT 15 - Advanced Power Management Specification - CPU BUSY
	AX = 5306h
Return: CF clear if successful
	CF set on error
	    AH = error code (03h,0Bh) (see #0374)
Notes:	called to ensure that the system runs at full speed even on systems
	  where the BIOS is unable to recognize increased activity (especially
	  if interrupts are hooked by other programs and not chained to the
	  BIOS)
	this call may be made even when the system is already running at full
	  speed, but it will create unnecessary overhead
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
SeeAlso: AX=5305h
--------p-155307-----------------------------
INT 15 - Advanced Power Management Specification - SET POWER STATE
	AX = 5307h
	BX = device ID (see #0375)
	CX = system state ID (see #0376)
Return: CF clear if successful
	CF set on error
	    AH = error code (01h,03h,09h,0Ah,0Bh,60h) (see #0374)
Note:	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
SeeAlso: AX=530Ch

(Table 0375)
Values for APM device IDs:
 0000h	system BIOS
 0001h	all devices for which the system BIOS manages power
 01xxh	display (01FFh for all attached display devices)
 02xxh	secondary storage (02FFh for all attached secondary storage devices)
 03xxh	parallel ports (03FFh for all attached parallel ports)
 04xxh	serial ports (04FFh for all attached serial ports)
---APM v1.1---
 05xxh	network adapters (05FFh for all attached network adapters)
 06xxh	PCMCIA sockets (06FFh for all)
 0700h-DFFFh reserved
 Exxxh	OEM-defined power device IDs
 F000h-FFFFh reserved

(Table 0376)
Values for system state ID:
 0000h	ready (not supported for device ID 0001h)
 0001h	stand-by
 0002h	suspend
 0003h	off (not supported for device ID 0001h)
---APM v1.1---
 0004h	last request processing notification (only for device ID 0001h)
 0005h	last request rejected (only for device ID 0001h)
 0006h-001Fh reserved system states
 0020h-003Fh OEM-defined system states
 0040h-007Fh OEM-defined device states
 0080h-FFFFh reserved device states
--------p-155307CX0001-----------------------
INT 15 - Advanced Power Management Specification - SYSTEM STAND-BY
	AX = 5307h
	CX = 0001h
	BX = 0001h (device ID for all power-managed devices)
Return: CF clear
Notes:	puts the entire system into stand-by mode; normally called in response
	  to a System Stand-by Request notification after any necessary
	  processing, but may also be invoked at the caller's discretion
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
	the stand-by state is typically exited on an interrupt
SeeAlso: AX=4280h,AX=5307h/CX=0002h/BX=0001h,AX=530Bh
--------p-155307CX0002-----------------------
INT 15 - Advanced Power Management Specification - SUSPEND SYSTEM
	AX = 5307h
	CX = 0002h
	BX = 0001h (device ID for all power-managed devices)
Return: after system is resumed
	CF clear
Notes:	puts the entire system into a low-power suspended state; normally
	  called in response to a Suspend System Request notification after
	  any necessary processing, but may also be invoked at the caller's
	  discretion
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
	the caller may need to update its date and time values because the
	  system could have been suspended for a long period of time
SeeAlso: AX=5307h/CX=0001h/BX=0001h,AX=530Bh
--------p-155308-----------------------------
INT 15 - Advanced Power Management Spec - ENABLE/DISABLE POWER MANAGEMENT
	AX = 5308h
	BX = device ID for all devices power-managed by APM
	    0001h (APM v1.1)
	    FFFFh (APM v1.0)
	CX = new state
	    0000h disabled
	    0001h enabled
Return: CF clear if successful
	CF set on error
	    AH = error code (01h,03h,09h,0Ah,0Bh) (see #0374)
Notes:	when power management is disabled, the system BIOS will not
	  automatically power down devices, enter stand-by or suspended mode,
	  or perform any power-saving actions in response to AX=5305h calls
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
SeeAlso: AX=5309h,AX=530Dh,AX=530Fh
--------p-155309-----------------------------
INT 15 - Advanced Power Management Specification - RESTORE POWER-ON DEFAULTS
	AX = 5309h
	BX = device ID for all devices power-managed by APM
	    0001h (APM v1.1)
	    FFFFh (APM v1.0)
Return: CF clear if successful
	CF set on error
	    AH = error code (09h) (see #0374)
Note:	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
SeeAlso: AX=5308h
--------p-15530ABX0001-----------------------
INT 15 - Advanced Power Management Specification - GET POWER STATUS
	AX = 530Ah
	BX = 0001h (device ID for all devices power-managed by APM)
Return: CF clear if successful
	    BH = AC line status
		00h off-line
		01h on-line
		02h on backup power (APM v1.1)
		FFh unknown
		other reserved
	    BL = battery status (see #0377)
	    CH = battery flag (APM v1.1) (see #0378)
	    CL = remaining battery life, percentage
		00h-64h (0-100) percentage of full charge
		FFh unknown
	    DX = remaining battery life, time (APM v1.1) (see #0379)
	CF set on error
	    AH = error code (09h) (see #0374)
Note:	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems

(Table 0377)
Values for APM v1.0+ battery status:
 00h	high
 01h	low
 02h	critical
 03h	charging
 FFh	unknown
 other	reserved

Bitfields for APM v1.1 battery flag:
Bit(s)	Description	(Table 0378)
 0	high
 1	low
 2	critical
 3	charging
 4-6	reserved
 7	no system battery
Note:	all bits set (FFh) if unknown

Bitfields for APM v1.1 remaining battery life:
Bit(s)	Description	(Table 0379)
 15	time units: 0=seconds, 1=minutes
 14-0	battery life in minutes or seconds
Note:	all bits set (FFFFh) if unknown
--------p-15530B-----------------------------
INT 15 - Advanced Power Management Specification - GET POWER MANAGEMENT EVENT
	AX = 530Bh
Return: CF clear if successful
	    BX = event code (see #0380)
	CF set on error
	    AH = error code (03h,0Bh,80h) (see #0374)
Notes:	although power management events are often asynchronous, notification
	  will not be made until polled via this call to permit software to
	  only receive event notification when it is prepared to process
	  power management events; since these events are not very time-
	  critical, it should be sufficient to poll once or twice per second
	the critical resume notification is made after the system resumes
	  from an emergency suspension; normally, the system BIOS only notifies
	  its partner that it wishes to suspend and relies on the partner to
	  actually request the suspension, but no notification is made on an
	  emergency suspension
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
SeeAlso: AX=5307h,AX=5307h/BX=0001h/CX=0001h,AX=5307h/BX=0001h/CX=0002h

(Table 0380)
Values for APM event code:
 0001h	system stand-by request
 0002h	system suspend request
 0003h	normal resume system notification
 0004h	critical resume system notification
 0005h	battery low notification
---APM v1.1---
 0006h	power status change notification
 0007h	update time notification
 0008h	critical system suspend notification
 0009h	user system standby request notification
 000Ah	user system suspend request notification
 000Bh	system standby resume notification
 000Ch-00FFh reserved system events
 01xxh	reserved device events
 02xxh	OEM-defined APM events
 0300h-FFFFh reserved
--------p-15530C-----------------------------
INT 15 - Advanced Power Management v1.1 - GET POWER STATE
	AX = 530Ch
	BX = device ID (see #0375)
Return: CF clear if successful
	    BX = system state ID (see #0376)
	CF set on error
	    AH = error code (01h,09h) (see #0374)
SeeAlso: AX=5307h
--------p-15530D-----------------------------
INT 15 - Advanced Power Management v1.1 - EN/DISABLE DEVICE POWER MANAGEMENT
	AX = 530Dh
	BX = device ID (see #0375)
	CX = function
	    0000h disable power management
	    0001h enable power management
Return: CF clear if successful
	CF set on error
	    AH = error code (01h,03h,09h,0Ah,0Bh) (see #0374)
SeeAlso: AX=5308h,AX=530Fh
--------p-15530E-----------------------------
INT 15 - Advanced Power Management v1.1 - DRIVER VERSION
	AX = 530Eh
	BX = device ID of system BIOS (0000h)
	CH = APM driver major version (BCD)
	CL = APM driver minor version (BCD)
Return: CF clear if successful
	    AH = APM connection major version (BCD)
	    AL = APM connection minor version (BCD)
	CF set on error
	    AH = error code (03h,09h,0Bh) (see #0374)
SeeAlso: AX=5300h
--------p-15530F-----------------------------
INT 15 - Advanced Power Management v1.1 - ENGAGE/DISENGAGE POWER MANAGEMENT
	AX = 530Fh
	BX = device ID (see #0375)
	CX = function
	    0000h disengage power management
	    0001h engage power management
Return: CF clear if successful
	CF set on error
	    AH = error code (01h,09h) (see #0374)
Note:	unlike AX=5308h, this call does not affect the functioning of the APM
	  BIOS
SeeAlso: AX=5308h,AX=530Dh
--------p-155380BH00-------------------------
INT 15 - APM SL Enhanced v1.0 - GET SUSPEND/GLOBAL STANDBY MODE
	AX = 5380h
	BH = 00h
Return: CF clear if successful
	    AL = 82360SL Auto Power Off Timer High Count (APWR_TMRH)
	    BL = sustdbymode (see #0381)
SeeAlso: AX=5380h/BH=01h,AX=5380h/BH=02h,AX=5380h/BH=7Fh

Bitfields for APM SL sustdbymode:
Bit(s)	Description	(Table 0381)
 2	???
 1	Auto Power Off Timer Enable (APWR_TMR_EN)
 0	???
--------p-155380BH01-------------------------
INT 15 - APM SL Enhanced v1.0 - SET SUSPEND/GLOBAL STANDBY MODE
	AX = 5380h
	BH = 01h
	BL = sustdbymode (see #0381)
Return: CF clear if successful
SeeAlso: AX=5380h/BH=00h,AX=5380h/BH=7Fh
--------p-155380BH02-------------------------
INT 15 - APM SL Enhanced v1.0 - GET GLOBAL STANDBY TIMER
	AX = 5380h
	BH = 02h
Return: CF clear if successful
	SI:DI = timer count in seconds (actually 1.024 seconds)
Desc:	reads the value of 82360SL GSTDBY_TMRH & GSTDBY_TMRL registers
SeeAlso: AX=5380h/BH=00h,AX=5380h/BH=03h,AX=5380h/BH=04h,AX=5380h/BH=7Fh
--------p-155380BH03-------------------------
INT 15 - APM SL Enhanced v1.0 - SET GLOBAL STANDBY TIMER
	AX = 5380h
	BH = 03h
	SI:DI = timer count in seconds (actually 1.024 seconds)
Return: CF clear if successful
Desc:	sets the value of 82360SL GSTDBY_TMRH & GSTDBY_TMRL registers
Note:	the maximum timer count is 268431 seconds
SeeAlso: AX=5380h/BH=02h,AX=5380h/BH=7Fh
--------p-155380BH04-------------------------
INT 15 - APM SL Enhanced v1.0 - GET AUTO POWER OFF TIMER
	AX = 5380h
	BH = 04h
Return: CF clear if successful
	SI:DI = timer count in seconds (actually 1.024 seconds)
Desc:	reads the value of 82360SL APWR_TMRH & APWR_TMRL registers
SeeAlso: AX=5380h/BH=02h,AX=5380h/BH=05h,AX=5380h/BH=06h,AX=5380h/BH=7Fh
--------p-155380BH05-------------------------
INT 15 - APM SL Enhanced v1.0 - SET AUTO POWER OFF TIMER
	AX = 5380h
	BH = 05h
	SI:DI = timer count in seconds (actually 1.024 seconds)
Return: CF clear if successful
Desc:	sets the value of 82360SL APWR_TMRH & APWR_TMRL registers
Note:	the maximum timer count is 134213 seconds
SeeAlso: AX=5380h/BH=04h,AX=5380h/BH=7Fh
--------p-155380BH06-------------------------
INT 15 - APM SL Enhanced v1.0 - GET RESUME CONDITION
	AX = 5380h
	BH = 06h
Return: CF clear if successful
	    BL = resume condition (see #0382)
Desc:	reads the value of 82360SL RESUME_MASK register
SeeAlso: AX=5380h/BH=04h,AX=5380h/BH=07h,AX=5380h/BH=08h,AX=5380h/BH=7Fh

Bitfields for APM SL resume condition:
Bit(s)	Description	(Table 0382)
 7-2	reserved (0)
 1	alarm enabled (resume on CMOS alarm)
 0	ring enabled
--------p-155380BH07-------------------------
INT 15 - APM SL Enhanced v1.0 - SET RESUME CONDITION
	AX = 5380h
	BH = 07h
	BL = resume condition (see #0382)
Return: CF clear if successful
Desc:	sets the value of 82360SL RESUME_MASK register
SeeAlso: AX=5380h/BH=06h,AX=5380h/BH=7Fh
--------p-155380BH08-------------------------
INT 15 - APM SL Enhanced v1.0 - GET CALENDAR EVENT TIME
	AX = 5380h
	BH = 08h
Return: CF clear if successful
	    CH = hours
	    CL = minutes
	    SI = seconds
	CF set on error
	    AH = error code (see #0383)
Desc:	gets calendar event time from CMOS ram
SeeAlso: AX=5380h/BH=06h,AX=5380h/BH=09h,AX=5380h/BH=0Ah,AX=5380h/BH=7Fh

(Table 0383)
Values for APM SL error code:
 02h	no alarm set
 03h	no battery
--------p-155380BH09-------------------------
INT 15 - APM SL Enhanced v1.0 - SET CALENDAR EVENT TIME
	AX = 5380h
	BH = 09h
	CH = hours
	CL = minutes
	SI = seconds
Return: CF clear if successful
	CF set on error
	    AH = error code (see #0383)
Desc:	sets calendar event time in CMOS ram, enables Alarm resume
SeeAlso: AX=5380h/BH=08h,AX=5380h/BH=7Fh
--------p-155380BH0A-------------------------
INT 15 - APM SL Enhanced v1.0 - GET CALENDAR EVENT DATE
	AX = 5380h
	BH = 0Ah
Return: CF clear if successful
	    SI = century
	    DI = year
	    CH = month
	    CL = day
	CF set on error
	    AH = error code (see #0383)
Desc:	reads calendar event date from Extended CMOS ram
SeeAlso: AX=5380h/BH=08h,AX=5380h/BH=0Bh,AX=5380h/BH=0Ch,AX=5380h/BH=7Fh
--------p-155380BH0B-------------------------
INT 15 - APM SL Enhanced v1.0 - SET CALENDAR EVENT DATE
	AX = 5380h
	BH = 0Bh
	SI = century
	DI = year
	CH = month
	CL = day
Return: CF clear if successful
	CF set on error
	    AH = error code (see #0383)
Desc:	sets calendar event date in Extended CMOS ram
SeeAlso: AX=5380h/BH=0Ah,AX=5380h/BH=7Fh
--------p-155380BH0C-------------------------
INT 15 - APM SL Enhanced v1.0 - GET CPU SPEED MODE
	AX = 5380h
	BH = 0Ch
Return: CF clear if successful
	CL = CPU clock divider (1,2,4 or 8)
	BL = autocpumode ???
Desc:	reads bits 4-5 of CPUPWRMODE register
SeeAlso: AX=5380h/BH=0Ah,AX=5380h/BH=0Dh,AX=5380h/BH=7Fh
--------p-155380BH0D-------------------------
INT 15 - APM SL Enhanced v1.0 - SET CPU SPEED MODE
	AX = 5380h
	BH = 0Dh
	CL = CPU clock divider (1,2,4 or 8)
	BL = autocpumode ???
Return: CF clear if successful
Desc:	writes bits 4-5 of CPUPWRMODE register
SeeAlso: AX=5380h/BH=0Ch,AX=5380h/BH=7Eh,AX=5380h/BH=7Fh
--------p-155380BH7E-------------------------
INT 15 - APM SL Enhanced v1.0 - SL HW PARAMETER
	AX = 5380h
	BH = 7Eh
Return:	AL = ???
	    03h on A-Step 386SL BIOSes
	    12h on later steps
	BX = Control port (00B0h)
SeeAlso: AX=5380h/BH=00h,AX=5380h/BH=7Fh
--------p-155380BH7F-------------------------
INT 15 - Advanced Power Management v1.1 - OEM APM INSTALLATION CHECK
	AX = 5380h
	BH = 7Fh
Return: CF clear if successful
	    BX = OEM identifier
	    all other registers OEM-defined
	    ---Intel SL Enhanced Option BIOS---
	    BX = 534Ch ('SL')
	    CL = 4Fh ('O')
	    AL = version (10h = 1.0)
	    ---HP APM BIOS---
	    BX = 4850h ('HP')
	    CX = version (0001h)
	CF set on error
	    AH = error code (03h) (see #0374)
SeeAlso: AX=5380h/BH=00h
--------p-155380-----------------------------
INT 15 - Advanced Power Management v1.1 - OEM APM FUNCTIONS
	AX = 5380h
	BH <> 7Fh
	all other registers OEM-defined
Return: OEM-defined
SeeAlso: AX=5380h/BH=7Fh
--------X-1553B0BH00-------------------------
INT 15 - Intel System Management Bus - RESERVED
	AX = 53B0h
	BH = 00h
Program: the SMBus is a variant of ACCESS.bus being used by Intel and Duracell
	  for the Smart Battery proposal, but designed to be generic enough to
	  handle other devices besides batteries
--------X-1553B0BH01-------------------------
INT 15 - Intel System Management Bus - INSTALLATION CHECK
	AX = 53B0h
	BH = 01h
	BL = 72h ('r')
	CX = 6164h ('ad')
Return: CF clear if installed
	    AH = SMBus BIOS Interface Specification major version (01h)
	    AL = SMBus BIOS Interface Specification minor version (00h)
	    BL = number of SMBus devices present
	    CX = 6941h ('iA')
	    DX = vendor-specified SMBus hardware code
		0000h means undefined hardware type
	CF set if error
	    AH = Error code 0Ah, 86h (see #0384)
Note:	this function is only supported in INT 15h mode
SeeAlso: AX=53B0h/BH=02h,AX=53B0h/BH=03h,AX=53B0h/BH=04h,AX=53B0h/BH=06h

(Table 0384)
Values for Intel System Management Bus error codes:
 00h	SMBus OK
 01h	SMBus connect failed
 02h	SMBus already connected (see also #0385)
 03h	SMBus disconnect failed
 04h	SMBus not connected
 05h	SMBus INT 15 interface disabled
 06h	SMBus device address request out of range
 07h	SMBus unknown failure
 08h	SMBus message list empty
 09h	SMBus message list overflow
 0Ah	SMBus invalid signature
 10h	SMBus device address not acknowledged
 11h	SMBus device error detected
 12h	SMBus device command access denied
 13h	SMBus unknown error
 14h	SMBus transaction pending
 15h	SMBus no transaction pending
 16h	SMBus request does not match pending transaction
 17h	SMBus device access denied
 18h	SMBus timeout
 19h	SMBus protocol not supported
 1Ah	SMBus busy
 1Bh	SMBus SMI detected
 80h	SMBus OK (previously unreported SMI occurred)
 86h	SMBus not supported

(Table 0385)
Values for Intel System Management Bus Already Connected sub-error codes:
 01h	real mode connect already established
 02h	16-bit PMode connect already established
 03h	32-bit PMode connect already established
SeeAlso: #0384
--------X-1553B0BH02-------------------------
INT 15 - Intel System Management Bus - REAL MODE CONNECT
	AX = 53B0h
	BH = 02h
	CX = 6941h ('iA')
Return: CF clear if successful
	    AX = SMBus Real mode code segment
	    BX = offset of entry point into SMBus BIOS Interface
	    CX = SMBus Real mode data segment
	CF set if error
	    AH = error code (01h,02h,0Ah,86h) (see #0384)
	    AL = sub-error code if error code is 02h (see #0385)
Desc:	connect to SMBus interface; once connected, all SMBus calls are made
	  to the supplied entry point instead of INT 15 (with registers
	  identical to those described here for INT 15)
Notes:	Support for this function is optional
	this function is only supported in INT 15 mode when implemented
SeeAlso: AX=53B0h/BH=01h,AX=53B0h/BH=03h,AX=53B0h/BH=04h,AX=53B0h/BH=05h
--------X-1553B0BH03-------------------------
INT 15 - Intel System Management Bus - 16-BIT PROTECTED-MODE CONNECT
	AX = 53B0h
	BH = 03h
	CX = 6941h ('iA')
Return: CF clear if successful
	    AX = SMBus 16-bit code segment (real mode base address)
	    BX = offset of entry point into SMBus BIOS Interface
	    CX = SMBus 16-bit data segment (real mode base address)
	    SI = code segment length in bytes
	    DI = data segment length in bytes
	CF set if error
	    AH = error code (01h,02h,0Ah,86h) (see #0384)
	    AL = sub-error code if error code is 02h (see #0385)
Desc:	connect to SMBus interface; once connected, all SMBus calls are made
	  to the supplied entry point instead of INT 15 (with registers
	  identical to those described here for INT 15)
Notes:	before calling the entry point, two descriptors must be initialized
	  in the GDT or LDT.  They must be consecutive and be in the order of
	  code, then data.  At the time	of the call, the descriptors must be
	  valid and have CPL=0.
	the code descriptor must be ring-0 privilege
	this function is only supported in INT 15 mode
SeeAlso: AX=53B0h/BH=01h,AX=53B0h/BH=02h,AX=53B0h/BH=04h,AX=53B0h/BH=05h
--------X-1553B0BH04-------------------------
INT 15 - Intel System Management Bus - 32-BIT PROTECTED-MODE CONNECT
	AX = 53B0h
	BH = 04h
	CX = 6941h ('iA')
Return: CF clear if successful
	    AX = SMBus 32-bit code segment (real mode base address)
	    EBX = offset of entry point into SMBus BIOS Interface
	    CX = SMBus 16-bit code segment (real mode base address)
	    DX = SMBus data segment (real mode base address)
	    SI = code segment length in bytes
	    DI = data segment length in bytes
	CF set if error
	    AH = error code (01h,02h,0Ah,86h) (see #0384)
	    AL = sub-error code if error code is 02h (see #0385)
Desc:	connect to SMBus interface; once connected, all SMBus calls are made
	  to the supplied entry point instead of INT 15 (with registers
	  identical to those described here for INT 15)
Notes:	before calling the entry point, two descriptors must be initialized in
	  the GDT or LDT.  They must be consecutive and be in the order of
	  32-bit code, 16-bit code, then data.	At the time of the call, the
	  descriptors must be valid and have CPL=0.
	the code descriptors must be ring-0 privilege
	this function is supported only in INT 15 mode
SeeAlso: AX=53B0h/BH=01h,AX=53B0h/BH=02h,AX=53B0h/BH=03h,AX=53B0h/BH=05h
--------X-1553B0BH05-------------------------
INT 15 - Intel System Management Bus - DISCONNECT
	AX = 53B0h
	BH = 05h
	CX = 6941h ('iA')
Return: CF clear if successful
	    AH = 00h (SMBus OK)
	CF set if error
	    AH = error code (03h,04h,05h,0Ah,86h) (see #0384)
Note:	this function is supported in connected mode (far CALL entry point)
	  only
SeeAlso: AX=53B0h/BH=01h,AX=53B0h/BH=02h,AX=53B0h/BH=03h,AX=53B0h/BH=04h
--------X-1553B0BH06-------------------------
INT 15 - Intel System Management Bus - GET DEVICE ADDRESSES
	AX = 53B0h
	BH = 06h
	BL = position in list to report
	CH = 6941h ('iA')
Return: CF clear if successful
	    AH = 00h (SMBus OK)
	    BH = number of SMBus devices
	    BL = SMBus Device Address of device at position BL in list
		(see #0386)
	CF set if error
	    AH = error code (06h,0Ah,86h) (see #0384)
Desc:	retrieves already assigned SMBus device addresses
Notes:	this function is supported in INT 15h mode only
	bit 0 of the device address indicates read/write, so a device may
	  be listed at both xxxxxxx0b and xxxxxxx1b

(Table 0386)
Values for System Management Bus predefined device addresses:
 10h	SMBus host
 12h	Smart Battery charger
 14h	Smart Battery selector
 16h	Smart Battery
 18h	SMBus Alert response
 50h	ACCESS.bus host
 58h	LCD contrast controller
 5Ah	CCFL backlight driver
 6Eh	ACCESS.bus default address
 80h-86h PCMCIA socket controllers
 88h	VGA graphics controller
 90h-96h unrestricted addresses
 82h	SMBus device default address
--------X-1553B0BH07-------------------------
INT 15 - Intel System Management Bus - RETRIEVE CRITICAL MESSAGES
	AX = 53B0h
	BH = 07h
	CX = 6941h ('iA')
Return: CF clear if successful
	    AH = 00h (SMBus OK)
	    AL = device address
	    BX = device message
	CF set if error
	    AH = error code (05h,07h,08h,09h,0Ah,86h) (see #0384)
Desc:	retrieves oldest queued critical message from an SMBus device to the
	  host
Notes:	up to five messages are queued; if the queue is full, messages will be
	  lost and error 09h returned
--------X-1553B0BH08-------------------------
INT 15 - Intel System Management Bus - RESERVED
	AX = 53B0h
	BH = 08h-0Fh
--------X-1553B0BH10-------------------------
INT 15 - Intel System Management Bus - REQUEST
	AX = 53B0h
	BH = 10h
	BL = protocol (see #0387)
	CH = device address
	CL = device command (see #0388)
	DH = MSB Data or block length (for BlockWrite)
	DL = LSB Data or first byte of block (for BlockWrite)
Return: CF clear if successful
	    AH = 00h or 80h (SMBus OK)
		 (80h indicates a previously unreported SMI took place)
	CF set if error
	    AH = error code (05h,10h,11h,12h,13h,14h,17h,19h,1Ah,86h)
		  (see #0384)
Desc:	request access to a device on the SMBus
SeeAlso: AX=53B0h/BH=11h, AX=53B0h/BH=13h

(Table 0387)
Values for Intel System Management Bus protocol codes:
 00h	Quick Command
 01h	Send Byte
 02h	Receive Byte
 03h	Write Byte
 04h	Read Byte
 05h	Write Word
 06h	Read Word
 07h	Block Write
 08h	Block Read
 09h	Process Call
 0Ah-FFh reserved
SeeAlso: #0388

(Table 0388)
Values for Intel System Management Bus Smart Battery command codes:
 Cmd	Protocol(s)	Description
 00h	Rd/Wr Word	"ManufacturerAccess" implementation-specific
 01h	Rd/Wr Word	get/set Low Capacity Alarm threshold
 02h	Rd/Wr Word	get/set Remaining Time Alarm value (in minutes)
 03h	Rd/Wr Word	get/set battery characteristics (see #0389)
 04h	Rd/Wr Word	"AtRate" indicate charge/discharge rate
 05h	Read Word	"AtRateTimeToFull" time to completely charge (in min.)
 06h	Read Word	"AtRateTimeToEmpty" time to entirely discharge (min.)
 07h	Read Word	"AtRateOK" boolean: can battery supply another 10sec?
 08h	Read Word	internal battery temperature (in 0.1 Kelvins)
 09h	Read Word	current battery voltage in millivolts
 0Ah	Read Word	current flowing through battery in milliamperes
			(positive if charging, negative if discharging)
 0Bh	Read Word	average current over the past minute
 0Ch	Read Word	expected error margin in capacity computations in %
 0Dh	Read Word	predicted remaining charge as % of full charge
 0Eh	Read Word	predicted remaining charge as % of design capacity
 0Fh	Read Word	predicted remaining charge in mAh or 10mWh
 10h	Read Word	predicted full charge capacity in mAh or 10mWh
 11h	Read Word	predicted remaining battery life in minutes
			FFFFh = not discharging
 12h	Read Word	rolling average of predicted life over past minute
 13h	Read Word	rolling average of predicted charge time over past min.
			FFFFh = not charging
 14h	Read Word	get battery's desired charging current in mA
 14h	Write Word	set charging current in mA
 15h	Read Word	get battery's desired charging current in mV
 15h	Write Word	set desired charging voltage in mV
 16h	Read Word	get current battery status (see #0390)
 17h	Read Word	get number of charge/discharge cycles for battery
 18h	Read Word	get design capacity in mAh or 10mWh
 19h	Read Word	get design voltage
 1Ah	Read Word	get specification information (see #0391)
 1Bh	Read Word	get manufacture date (see #0971 at INT 21/AX=5700h)
 1Ch	Read Word	get serial number
 1Dh-1Fh		reserved
 20h	Read Block	get manufacturer's name
 21h	Read Block	get device name
 22h	Read Block	get device chemistry (see #0392)
 23h	Read Block	get manufacturer data
 24h-2Eh		reserved
 2Fh			manufacturer-specific
 30h-3Bh		reserved
 3Ch-3Fh		manufacturer-specific
Note:	bits 7-6 are reserved for addressing multiple batteries in a future
	  version of the specification
SeeAlso: #0387

Bitfields for Smart Battery battery characteristics:
Bit(s)	Description	(Table 0389)
 0	battery has internal charge controller (read-only)
 1	primary/secondary battery support (read-only)
 6-2	reserved
 7	conditioning cycle requested
 8	internal charge controller enabled
 9	battery operating in primary mode
 13-10	reserved
 14	disable broadcast to charger
 15	report capacity in units of 10mW / 10mWh instead of mA / mAh
SeeAlso: #0388,#0390

Bitfields for Smart Battery battery status:
Bit(s)	Description	(Table 0390)
 15	overcharged
 14	terminate-charge alarm
 13	reserved
 12	over-temperature alarm
 11	terminate-discharge alarm
 10	reserved
 9	remaining-capacity alarm
 8	remaining-time alarm
 7	initialized
 6	charging
 5	fully charged
 4	fully discharged
 3-0	error codes
	0000 OK
	0001 busy
	0010 reserved command
	0011 unsupported command
	0100 access denied (tried to write to read-only value)
	0101 overflow/underflow
	0110 bad size
	0111 unknown error
SeeAlso: #0388,#0389,#0391

Bitfields for Smart Battery specification information:
Bit(s)	Description	(Table 0391)
 3-0	SmartBattery specification minor revision number
 7-4	SmartBattery specification version number
 11-8	voltage scaling (0-3, multiply voltages by 10^scale)
 15-12	current scaling (0-3, multiply currents by 10^scale)
SeeAlso: #0388,#0390

(Table 0392)
Values for Smart Battery device chemistry (not case-sensitive):
 "LION"	Lithium ion
 "NiMH"	Nickel metal hydride
 "PbAc"	lead-acid
 "NiCd" Nickel Cadmium
 "NiZn" Nickel Zinc
 "RAM"	rechargeable Alkaline Manganese
 "ZnAr" Zinc-Air
SeeAlso: #0388
--------X-1553B0BH11-------------------------
INT 15 - Intel System Management Bus - REQUEST CONTINUATION
	AX = 53B0h
	BH = 11h
	BL = protocol (see #0387)
	CH = device address
	CL = number of valid bytes in DX (1 or 2)
	DH = MSB Data (CL = 1 or 2)
	DL = LSB Data (CL = 2)
Return: CF clear if successful
	    AH = 00h (SMBus OK)
	    CL = SMBus status
		00h SMBus hardware not ready for more data
		01h SMBus hardware ready for 2 more data bytes
	CF set if error
	    AH = error code (05h,11h,13h,15h,16h,18h,1Bh,86h) (see #0384)
Desc:	continue WriteBlock protocol started with function 10h
SeeAlso: AX=53B0h/BH=10h, AX=53B0h/BH=13h
--------X-1553B0BH12-------------------------
INT 15 - Intel System Management Bus - REQUEST ABORT
	AX = 53B0h
	BH = 12h
	BL = protocol (see #0387)
	CH = device address
	CL = device command
Return: CF clear if successful
	    AH = 00h (SMBus OK)
	CF set if error
	    AH = error code (05h,13h,15h,16h,86h) (see #0384)
Desc:	stop the currently pending SMBus request; usually used to terminate
	  a request after an SMI Detected error
--------X-1553B0BH13-------------------------
INT 15 - Intel System Management Bus - REQUEST DATA AND STATUS
	AX = 53B0h
	BH = 13h
	BL = protocol (see #0387)
	CH = device address
	CL = device command
Return: CF clear if successful
	    AH = 00h (SMBus OK)
	    CH = status
		00h no data pending, transaction complete
		01h no data pending, transaction continues
		02h data pending
	    CL = number of valid bytes in DX (0-2)
	    DH = MSB data
	    DL = LSB data
	CF set if error
	    AH = error code (05h,10h,11h,13h,15h,16h,18h,1Bh,86h) (see #0384)
Desc:	determine when a transaction is complete, gather data returned by read
	  transactions
Note:	for Block Read protocol (08h), first call returns block	length in DH
	  and the first byte of the block in DL
--------T-155400-----------------------------
INT 15 C - Omniview Multitasker - INSTALLATION NOTIFICATION
	AX = 5400h
	ES:BX -> device information tables
	DI:DX -> dispatcher entry point
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5407h,INT 2F/AX=DE00h
--------T-155401-----------------------------
INT 15 C - Omniview Multitasker - PROCESS CREATION
	AX = 5401h
	ES:BX = process handle
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5402h,INT 2F/AX=DE04h
--------T-155402-----------------------------
INT 15 C - Omniview Multitasker - PROCESS DESTRUCTION
	AX = 5402h
	ES:DX = process handle
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5401h,INT 2F/AX=DE05h
--------T-155403-----------------------------
INT 15 C - Omniview Multitasker - SAVE
	AX = 5403h
	ES:DX = process swapping out
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5404h,INT 2F/AX=DE08h
--------T-155404-----------------------------
INT 15 C - Omniview Multitasker - RESTORE
	AX = 5404h
	ES:DX = process swapping in
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5403h,INT 2F/AX=DE09h
--------T-155405-----------------------------
INT 15 C - Omniview Multitasker - SWITCHING TO BACKGROUND
	AX = 5405h
	ES:DX = process swapping in
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5406h
--------T-155406-----------------------------
INT 15 C - Omniview Multitasker - SWITCHING TO FOREGROUND
	AX = 5406h
	ES:DX = process swapping in
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5405h
--------T-155407-----------------------------
INT 15 C - Omniview Multitasker - EXIT NOTIFICATION
	AX = 5407h
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5400h,INT 2F/AX=DE03h
--------b-1560------------------------------------
INT 15 - HUNTER 16 - SET SYSTEM CLOCK SPEED
	AH = 60h
	AL = new speed
	    00h normal (8 MHz)
	    01h Slow Mode 1 (4 MHz)
	    02h Slow Mode 2 (2 MHz)
Note:	the Husky Hunter 16 is an 8088-based ruggedized laptop.	 Other family
	  members are the Husky Hunter, Husky Hunter 16/80, and Husky Hawk.
SeeAlso: AX=6301h
--------p-156000-----------------------------
INT 15 U HP 100LX/200LX - GET MAIN BATTERY LEVEL
	AX = 6000h
Return: AX = battery level
Note:	multiply the returned value with 1Bh and add 622h to get millivolts
SeeAlso: AX=6001h,AX=6002h,AX=6003h,AX=6004h
--------p-156001-----------------------------
INT 15 U HP 100LX/200LX - GET BACKUP BATTERY LEVEL
	AX = 6001h
Return: AX = battery level
Note:	multiply the returned value with 1Bh and add 622h to get millivolts
SeeAlso: AX=6000h,AX=6002h
--------p-156002-----------------------------
INT 15 U HP 100LX/200LX - GET POWER INFO
	AX = 6002h
Return: AL = power settings (see #0393)
SeeAlso: AX=6000h,AX=6003h,AX=6004h

Bitfields for power settings:
Bit(s)	Description	(Table 0393)
 0-1	unused ???
 2	card battery status low (OK if bit clear)
 3	battery charging off (disabled if bits 3-5 clear)
 4	battery charging slow
 5	battery charging fast
 6	power adaptor active
 7	battery type NiCad (alkaline if bit clear)
--------p-156003-----------------------------
INT 15 U HP 100LX/200LX - SET MAIN BATTERY TYPE
	AX = 6003h
	BL = battery type
	    00h alkaline
	    01h NiCad
SeeAlso: AX=6000h,AX=6004h
--------p-156004-----------------------------
INT 15 U HP 100LX/200LX - SET BATTERY CHARGING MODE
	AX = 6004h
	BL = charging
	    00h disabled
	    01h enabled
SeeAlso: AX=6000h,AX=6003h
--------b-1561------------------------------------
INT 15 - HUNTER 16 - GET POWER LEVEL
	AH = 61h
Return: AH = percentage of full power left (0..100)
Desc:	determine how much battery power is left
SeeAlso: AH=62h,AH=66h,AH=73h"HUNTER"
--------b-1561-------------------------------
INT 15 U HP 100LX/200LX - SET ANNOUNCIATORS POSITION
	AH = 61h
	AL = position (20h = left, 60h = right)
Note:	The announciators are the indicator symbols for the Shift and Fn keys
	  in the bottom line
SeeAlso: AH=62h"HP",INT 16/AH=02h
--------b-1562------------------------------------
INT 15 - HUNTER 16 - SET LOW POWER THRESHOLD
	AH = 62h
	AL = level (00h 5%, 01h 10%, ... 12h 95%)
	BX = interval between power low warnings in seconds (1..600)
Return: AH = Status
Desc:	set the level (relative to full power) when power-low warnings begin
	  and the interval between the warnings
SeeAlso: AH=61h,AH=65h,AH=66h
--------b-1562-------------------------------
INT 15 U HP 100LX/200LX - SET DISPLAY CONTRAST
	AH = 62h
	BL = contrast (00h-1Fh, 1Fh is the darkest)
SeeAlso: AH=47h"HP",AH=61h"HP"
--------b-156300----------------------------------
INT 15 - HUNTER 16 - GET IDLE TIMEOUT
	AX = 6300h
Return: AH = status
	BX = timeout in seconds (0-3600)
Desc:	get the idle timeout value, the interval without keyboard or
	   communications activity before the system shuts down
SeeAlso: AX=6301h
--------b-156301----------------------------------
INT 15 - HUNTER 16 - SET IDLE TIMEOUT
	AX = 6301h
	BX = timeout in seconds (0-3600)
Desc:	sets the idle timeout value, the interval without keyboard or
	  communications activity before the system shuts down
SeeAlso: AX=6300h
--------b-1564------------------------------------
INT 15 - HUNTER 16 - CONTROL RESUME MODE
	AH = 64h
	AL = new state
	    00h disable Resume mode
	    01h enable Resume mode
Return: AH = status
Desc:	turn Resume mode on or off. In Resume mode the system starts in
	  the application that was running when it shut down as if nothing
	  had happened.
SeeAlso: AH=67h,AH=68h,AH=69h
--------b-1565------------------------------------
INT 15 - HUNTER 16 - AUTHORISE CHARGING
	AH = 65h
	AL = charging level
	    01h charging not allowed
	    02h charging allowed until power down
	    03h charging allowed until batteries changed or fail.
		Ask user if charging is still allowed on next poweron
	    04h charging allowed indefinitely
	BX = 0203h
	CX = 0405h
	DX = 0607h
Return: AH = status
SeeAlso: AH=66h,AH=68h
--------b-1566------------------------------------
INT 15 - HUNTER 16 - SET BATTERY LEVEL
	AH = 66h
	AL = level in percent of maximum (0..100)
Return: AH = status
SeeAlso: AH=61h,AH=65h
--------b-1567------------------------------------
INT 15 - HUNTER 16 - CONTROL STOP MODE
	AH = 67h
	AL = mode when waiting for input
	    00h use STOP mode (allows communication)
	    01h use HALT mode (disallows communication)
Return: AH = status
Desc:	select the power save mode to use when waiting for input
SeeAlso: AH=69h
--------b-1568------------------------------------
INT 15 - HUNTER 16 - REQUEST POWER DOWN
	AH = 68h
Desc:	turns off the Hunter 16 if power down is allowed (see AH=69h)
SeeAlso: AH=69h
--------b-1569------------------------------------
INT 15 - HUNTER 16 - CONTROL POWER DOWN AVAILABILITY
	AH = 69h
	AL = mode
	    00h inhibit power down
	    01h allow power down
Return: AH = status
SeeAlso: AH=67h,AH=68h,AH=6Ah
--------b-156A------------------------------------
INT 15 - HUNTER 16 - CONTROL SLOW MODE
	AH = 6Ah
	AL = mode
	    00h inhibit Slow mode
	    01h allow Slow mode
Return: AH = status
SeeAlso: AH=69h
--------b-156B------------------------------------
INT 15 - HUNTER 16 - GET ROM BIOS VERSION
	AH = 6Bh
Return: BH = version number (ASCII)
	BL = release number (ASCII)
	CH = major??? release number (ASCII)
	CL = minor??? release number (ASCII)
SeeAlso: AH=6Ch
--------b-156C------------------------------------
INT 15 - HUNTER 16 - GET SERIAL NUMBER
	AH = 6Ch
Return: BL:CX = BCD serial number
Note:	when shipped, all Hunter 16s have the same Serial Number, but a
	  different number can be stored (see AH=72h)
SeeAlso: AH=6Bh,AH=72h
--------b-156D------------------------------------
INT 15 - HUNTER 16 - GET EVENT DETAIL
	AH = 6Dh
Return: AH = 00h if successful
	CX:BX = event flags bit 0..31 (see #0394)
Note:	this function allows testing for events
SeeAlso: AH=6Eh,AH=6Fh

Bitfields for HUNTER 16 events:
Bit(s)	Description	(Table 0394)
 6	RI received
 5	RTC Alarm
 4	data received on COM2
 3	data received on COM1
 2	error on COM2
 1	error on COM1
 0	PWR button pressed
--------b-156E------------------------------------
INT 15 - HUNTER 16 - ENABLE/TRAP EVENT
	AH = 6Eh
	AL = Software Interrupt
	      00h  do not trap event
	      else trap as software interrupt number AL
	BH = event number (see AH=6Dh)
	BL = enable mask
	    00h disable event
	    01h enable event
Return: AH = 00h if successful
SeeAlso: AH=6Dh,AH=6Fh
--------b-156F------------------------------------
INT 15 - HUNTER 16 - ACKNOWLEDGE EVENT
	AH = 6Fh
	AL = event number (see AH=6Dh)
Return: AH = 00h if successful
Desc:	Acknowledges the event, so the next similar event can be detected
SeeAlso: AH=6Dh"HUNTER",AH=6Eh
--------b-1570------------------------------------
INT 15 - HUNTER 16 - CONTROL SOUND
	AH = 70h
	AL = new state
	    00h disable sound
	    else enable sound
Note:	the Husky Hunter 16 is an 8088-based ruggedized laptop.	 Other family
	  members are the Husky Hunter, Husky Hunter 16/80, and Husky Hawk.
--------x-157000-----------------------------
INT 15 - Tandy 1000SL/TL - READ FROM EEPROM
	AX = 7000h
	BL = number of word to read (00h-3Fh)
Return: CF clear if function supported
	    DX = contents of EEPROM word
Note:	newer Tandy 1000-series machines use EEPROM instead of CMOS RAM in
	  the clock chip to store system configuration information
SeeAlso: AX=7001h
--------x-157001-----------------------------
INT 15 - Tandy 1000SL/TL - WRITE TO EEPROM
	AX = 7001h
	BL = number of word to read (00h-3Fh)
	DX = new value for EEPROM word
Return: CF clear if function supported
Note:	the EEPROMs are normally written only by the system setup program;
	  changing the values can badly mess up a Tandy
SeeAlso: AX=7000h
----------157002-----------------------------
INT 15 U - Tandy 1000 Model ??? - GET ROM PAGE
	AX = 7002h
Return: AL = ROM page mapped at 0E0000h (0-6 (13?))
Note:	some Tandy machines have DOS and DeskMate in a 512k paged ROM.	The
	  BIOS uses this call to determine what ROM page is mapped in the 64k
	  segment at 0E0000h.
	the 1000TL has 8 64k ROM pages; page 7 is permanently mapped at
	  0F0000h.  There may be 16 32k ROM pages on other systems.
SeeAlso: AX=7003h,INT E0"DeskMate"
----------157003-----------------------------
INT 15 U - Tandy 1000 Model ??? - SET ROM PAGE
	AX = 7003h
	DL = ROM page to be mapped at 0E0000h (0-6 (13?))
Return: CF clear if valid ROM page specified
Note:	Some Tandy machines have DOS and DeskMate in a 512k paged ROM.	The
	  BIOS uses this call to map ROM pages in the 64k segment at 0E0000h.
	The 1000TL has 8 64k ROM pages; page 7 is permanently mapped at
	  0F0000h.  There may be 16 32k ROM pages on other systems.
SeeAlso: AX=7002h,INT E0"DeskMate"
--------b-1571------------------------------------
INT 15 - HUNTER 16 - SELECT POWER UP KEYS
	AH = 71h
	BL = column
	BH = row
	AL = column switch (00h disable, 01h enable)
	CL = row switch (00h disable, 01h enable)
Return: AH = status
SeeAlso: AH=7Bh,AH=88h
--------b-157200----------------------------------
INT 15 - HUNTER 16 - RESET SERIAL NUMBER
	AX = 7200h
Return: AH = 00h if successful
Desc:	reset the serial number to the default serial number present when the
	  Hunter 16 was shipped
SeeAlso: AH=6Ch,AH=72h
--------b-1572------------------------------------
INT 15 - HUNTER 16 - REDIRECT SERIAL NUMBER
	AH = 72h
	AL nonzero
	DS:BX -> new serial number (6 ASCII digits)
Return: AH = 00h if successful
Desc:	install a new serial number
SeeAlso: AH=6Ch,AX=7200h
--------b-1573------------------------------------
INT 15 - HUNTER 16 - GET ORACLE GT POWER LEVEL
	AH = 73h
	AL = drive (0: A:, 1: B:)
Return: AH = status
	    00h successful
	    FFh Oracle GT drive not connected
	AL = power level in percent of maximum (0..100)
Desc:	get the power remaining in the Oracle GT batteries
SeeAlso: AH=61h
--------b-1574------------------------------------
INT 15 - HUNTER 16 - SET BACKLIGHT POWER UP STATE
	AH = 74h
	AL = new level
	    01h off
	    02h unchanged
	    03h change level
		BL = desired level (00h-7Fh)
Return: AH = status
Desc:	select the backlight level to use when the Hunter is next turned on
SeeAlso: AH=64h,AH=75h,INT 10/AH=64h,INT 10/AH=78h
--------b-1575------------------------------------
INT 15 - HUNTER 16 - SET CONTRAST POWER UP STATE
	AH = 75h
	AL = new level
	    01h off
	    02h unchanged
	    03h change level
		BL = desired level (00h-7Fh)
Return: AH = status
Desc:	select the LCD contrast level to use when the Hunter is next turned on
SeeAlso: AH=63h,AH=74h
--------b-1576------------------------------------
INT 15 - HUNTER 16 - CONTROL POWER SAVE
	AH = 76h
	BX = power save control (see #0395)
SeeAlso: AH=74h

Bitfields for HUNTER 16 power save control:
Bit(s)	Description	(Table 0395)
 0	power save enabled
 1	inhibit power save when waiting for COM1 data
 2	inhibit power save when waiting for COM2 data
 3	inhibit power save when waiting for data from barcode wand
 4	inhibit power up on timer tick
--------b-1579------------------------------------
INT 15 - HUNTER 16 - REDIRECT LPT1
	AH = 79h
	AL = port to which to redirect (00h COM1, 01h COM2)
--------b-157A------------------------------------
INT 15 - HUNTER 16 - INVOKE HOT KEY
	AH = 7Ah
Desc:	this function has the same effect as pressing the HOT key
SeeAlso: AH=7Bh
--------b-157B------------------------------------
INT 15 - HUNTER 16 - CONTROL HOT KEY
	AH = 7Bh
	AL = 00h prevent HOT key
	    else allow HOT key
Desc:	Allow or prevent the HOT key function which is used to examine and
	  change the Hunter setup
SeeAlso: AH=71h,AH=7Ah,AH=7Ch
--------b-157C------------------------------------
INT 15 - HUNTER 16 - CONTROL HOT KEY POWER OPTION
	AH = 7Ch
	AL = 00h prevent HOT key power option
	    else allow HOT key power option
Desc:	allow or prevent changing the power options
SeeAlso: AH=7Bh,AH=7Dh
--------b-157D------------------------------------
INT 15 - HUNTER 16 - OVERRIDE LOW POWER TURN OFF
	AH = 7Dh
	AL = 00h turn off after 10 warnings
	    else never turn off
Desc:	specify whether the Hunter 16 turns off after 10 low power warnings
SeeAlso: AH=7Ch
--------b-157E------------------------------------
INT 15 - HUNTER 16 - CONTROL BATTERY CHANGE FACILITIES (APM)
	AH = 7Eh
	AL = 00h do not prompt
	    else prompt
Desc:	select whether the user is prompted for the battery state if the
	  battery cap has been off when the system is turned on
SeeAlso: AH=7Fh
--------b-157F------------------------------------
INT 15 - HUNTER 16 - SET BATTERY TYPE (APM)
	AH = 7Fh
	AL = battery type
	    00h	 non-rechargeable
	    else rechargeable
SeeAlso: AH=7Eh
--------B-1580-------------------------------
INT 15 C - OS HOOK - DEVICE OPEN (AT,XT286,PS)
	AH = 80h
	BX = device ID
	CX = process ID
	CF clear
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (see #0396)
Note:	this function should be hooked by a multitasker which wishes to keep
	  track of device ownership; the default BIOS handler merely returns
	  successfully
SeeAlso: AH=81h,AH=82h

(Table 0396)
Values for status:
 80h	invalid command (PC,PCjr)
 86h	function not supported (XT)
--------b-1580------------------------------------
INT 15 - HUNTER 16 - GET/SET BATTERY CAPACITY (APM)
	AH = 80h
	AL = function
	    00h get
		Return: AL = capacity (500mA + AL * 50mA, max 40 = 2500mA)
	    else set
		BL = battery capacity (same as AL above)
SeeAlso: AH=61h"HUNTER",AH=81h"HUNTER"
--------B-1581-------------------------------
INT 15 C - OS HOOK - DEVICE CLOSE
	AH = 81h
	BX = device ID
	CX = process ID
	CF clear
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (see #0396)
Note:	this function should be hooked by a multitasker which wishes to keep
	  track of device ownership; the default BIOS handler merely returns
	  successfully
SeeAlso: AH=80h,AH=82h
--------b-1581------------------------------------
INT 15 - HUNTER 16 - CONTROL POWER OUTPUT
	AH = 81h
	AL = new state of power output (00h off, nonzero on)
Desc:	turn the +5V low power output on or off
SeeAlso: AH=80h"HUNTER"
--------B-1582-------------------------------
INT 15 C - OS HOOK - PROGRAM TERMINATION
	AH = 82h
	BX = process ID
	CF clear
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (see #0396)
Notes:	closes all devices opened by the given process ID with function 80h
	this function should be hooked by a multitasker which wishes to keep
	  track of device ownership; the default BIOS handler merely returns
	  successfully
SeeAlso: AH=80h,AH=81h
--------b-1582------------------------------------
INT 15 - HUNTER 16 - SOUND OUTPUT
	AH = 82h
	DX = length (duration in seconds = DX * 666670 / frequency)
	BX = pitch (see #0397)
Desc:	Sound the tone specified in BX for the duration in DX
SeeAlso: AX=1019h

(Table 0397)
Values for HUNTER 16 sound pitch:
BX(dec)	 Note	Frequency	BX(dec)	 Note	Frequency
  425	G	1568.000	 1515	A	 440.000
  451	F#	1479.503	 1605	G#	 415.307
  477	F	1396.900	 1701	G	 392.000
  506	E	1318.500	 1802	F#	 369.998
  536	D#	1244.523	 1909	F	 349.230
  568	D	1174.700	 2022	E	 329.630
  601	C#	1108.749	 2143	D#	 311.127
  637	C	1046.500	 2270	D	 293.660
  675	B	 958.770	 2405	C#	 277.183
  715	A#	 932.329	 2548	MID C	 261.630
  758	A	 880.000	 2700	B	 246.940
  803	G#	 830.609	 2860	A#	 233.081
  850	G	 783.990	 3030	A	 220.000
  901	F#	 739.990	 3210	G#	 207.654
  954	F	 698.460	 3401	G	 196.000
 1011	E	 659.260	 3604	F#	 184.996
 1071	D#	 622.257	 3818	F	 174.610
 1135	D	 587.330	 4045	E	 164.810
 1203	C#	 554.365	 4286	D#	 155.560
 1274	C	 523.250	 4540	D	 146.830
 1350	B	 493.880	 4668	C#	 142.827
 1430	A#	 466.162	 4803	C	 138.810
--------B-1583-------------------------------
INT 15 - BIOS - SET EVENT WAIT INTERVAL (AT,PS50+)
	AH = 83h
	AL = subfunction
	    00h set interval
		CX:DX = microseconds to delay
		ES:BX -> byte whose high bit is to be set at end of interval
	    01h cancel wait interval
Return: CF set on error or function already busy
	    AH = status
		80h invalid command (PC,PCjr)
		86h function not supported (XT and later)
	CF clear if successful
Notes:	the resolution of the wait period is 977 microseconds on most systems
	  because most BIOSes use the 1/1024 second fast interrupt from the AT
	  real-time clock chip which is available on INT 70
	IBM AT 1/10/84 BIOS ignores AL and always performs subfunction 00h
SeeAlso: AH=41h,AH=86h,INT 70
--------b-1583------------------------------------
INT 15 - HUNTER 16 - CONTROL SCREEN SYNCHRONISATION
	AH = 83h
	AL = state of LCD window (00h disabled, nonzero enabled)
Desc:	Enable/disable the facility where the displayed window tracks the
	  cursor output to keep the focus visible
--------B-1584-------------------------------
INT 15 - BIOS - JOYSTICK SUPPORT (XT after 11/8/82,AT,XT286,PS)
	AH = 84h
	DX = subfunction
	    0000h read joystick switches
		Return: AL bits 7-4 = switch settings
	    0001h read positions of joysticks
		Return: AX = X position of joystick A
			BX = Y position of joystick A
			CX = X position of joystick B
			DX = Y position of joystick B
Return: CF set on error
	    AH = status (see #0396)
	CF clear if successful
Notes:	if no game port is installed, subfunction 0000h returns AL=00h (all
	  switches open) and subfunction 0001h returns AX=BX=CX=DX=0000h
	a 250kOhm joystick typically returns 0000h-01A0h
SeeAlso: AH=84h"V20-XT-BIOS"
--------b-1584-------------------------------
INT 15 - V20-XT-BIOS - JOYSTICK SUPPORT
	AH = 84h
	DX = subfunction
	    0000h read joystick switches
		Return: AL bits 7-4 = switch settings
	    other: read positions of joysticks as indicated by bits 0-3
		Return: AX = X position of joystick A (if DX bit 0 set)
			BX = Y position of joystick A (if DX bit 1 set)
			CX = X position of joystick B (if DX bit 2 set)
			DX = Y position of joystick B (if DX bit 3 set)
Return: CF set on error
	    AH = status (see #0396)
	CF clear if successful
Program: V20-XT-BIOS is a ROM BIOS replacement with extensions by Peter
	   Koehlmann / c't magazine
SeeAlso: AH=84h"PS",INT 10/AH=0Eh/CX=ABCDh
--------b-158400----------------------------------
INT 15 - HUNTER 16 - GET DISKETTE PORT
	AX = 8400h
	BH = Drive (0: A:, 1: B:)
Return: AL = Port (0: COM1, >0: COM2)
Desc:	return the COM port used for the floppy drive
SeeAlso: AX=8401h
--------b-158401----------------------------------
INT 15 - HUNTER 16 - SET DISKETTE PORT
	AX = 8401h
	BH = Drive (0: A:, 1: B:)
	BL = Port (0: COM1, >0: COM2)
Desc:	set the COM port used for the floppy drive
SeeAlso: AX=8400h
--------B-1585-------------------------------
INT 15 C - OS HOOK - SysReq KEY ACTIVITY (AT,PS)
	AH = 85h
	AL = SysReq key action (00h pressed, 01h released)
	CF clear
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (see #0396)
Notes:	called by keyboard decode routine
	the default handler simply returns successfully; programs which wish
	  to monitor the SysReq key must hook this call
	the SysReq key is often labeled SysRq
SeeAlso: INT 09
--------b-158500----------------------------------
INT 15 - HUNTER 16 - RESTORE POWER MENU (APM)
	AX = 8500h
Desc:	restore the standard power menu
SeeAlso: AX=8501h"HUNTER"
--------b-158501----------------------------------
INT 15 - HUNTER 16 - SET POWER MENU (APM)
	AX = 8501h
	BL = user software interrupt number
Desc:	install an alternate power menu routine
SeeAlso: AX=8500h"HUNTER"
--------B-1586-------------------------------
INT 15 - BIOS - WAIT (AT,PS)
	AH = 86h
	CX:DX = interval in microseconds
Return: CF clear if successful (wait interval elapsed)
	CF set on error or AH=83h wait already in progress
	    AH = status (see #0396)
Note:	the resolution of the wait period is 977 microseconds on most systems
	  because most BIOSes use the 1/1024 second fast interrupt from the AT
	  real-time clock chip which is available on INT 70
SeeAlso: AH=41h,AH=83h,INT 1A/AX=FF01h,INT 70
--------b-1586------------------------------------
INT 15 - HUNTER 16 - GET/SET SCREEN ATTRIBUTE TABLE
	AH = 86h
	AL = function (00h get, nonzero set)
	BX = 1234h
	DS:SI -> 256-byte Attribute buffer
Note:	In text modes each character has its attribute byte XOR'd with the
	  corresponding byte in the attribute table.  If the attribute is 15,
	  15 is XOR'd with Table[15]
--------B-1587-------------------------------
INT 15 - SYSTEM - COPY EXTENDED MEMORY
	AH = 87h
	CX = number of words to copy (max 8000h)
	ES:SI -> global descriptor table (see #0399)
Return: CF set on error
	CF clear if successful
	AH = status (see #0398)
Notes:	copy is done in protected mode with interrupts disabled by the default
	  BIOS handler; many 386 memory managers perform the copy with
	  interrupts enabled
	this function is incompatible with the OS/2 compatibility box
SeeAlso: AH=88h,AH=89h,INT 1F/AH=90h

(Table 0398)
Values for extended-memory copy status:
 00h	source copied into destination
 01h	parity error
 02h	interrupt error
 03h	address line 20 gating failed
 80h	invalid command (PC,PCjr)
 86h	unsupported function (XT,PS30)

Format of global descriptor table:
Offset	Size	Description	(Table 0399)
 00h 16 BYTEs	zeros (used by BIOS)
 10h	WORD	source segment length in bytes (2*CX-1 or greater)
 12h  3 BYTEs	24-bit linear source address, low byte first
 15h	BYTE	source segment access rights (93h)
 16h	WORD	zero
 18h	WORD	destination segment length in bytes (2*CX-1 or greater)
 1Ah  3 BYTEs	24-bit linear destination address, low byte first
 1Dh	BYTE	destination segment access rights (93h)
 1Eh 18 BYTEs	zeros (used by BIOS)
--------b-1587------------------------------------
INT 15 - HUNTER 16 - SET INT 72h VECTOR
	AH = 87h
	DS:DX = new service routine
Desc:	set the INT 72h vector which is called in 2 cases:
	  - when the machine is about to turn off or reboot, INT 72h is called
	    with AH=0
	  - when the machine is powering up INT 72h is called with AH=01h
Note:	the actual INT 72h vector must also be changed with INT 21/AH=25h
--------B-1588-------------------------------
INT 15 - SYSTEM - GET EXTENDED MEMORY SIZE (286+)
	AH = 88h
Return: CF clear if successful
	    AX = number of contiguous KB starting at absolute address 100000h
	CF set on error
	    AH = status
		80h invalid command (PC,PCjr)
		86h unsupported function (XT,PS30)
Notes:	TSRs which wish to allocate extended memory to themselves often hook
	  this call, and return a reduced memory size.	They are then free to
	  use the memory between the new and old sizes at will.
	the standard BIOS only returns memory between 1MB and 16MB; use AH=C7h
	  for memory beyond 16MB
	not all BIOSes correctly return the carry flag, making this call
	  unreliable unless one first checks whether it is supported through
	  a mechanism other than calling the function and testing CF
SeeAlso: AH=87h,AH=8Ah"Phoenix",AH=C7h,AX=DA88h
--------b-1588------------------------------------
INT 15 - HUNTER 16 - GET POWER UP KEYS
	AH = 88h
Return: AH = 00h
	BX = column
	CL = row
SeeAlso: AH=71h
--------B-1589-------------------------------
INT 15 - SYSTEM - SWITCH TO PROTECTED MODE
	AH = 89h
	BL = interrupt number of IRQ0 (IRQ1-7 use next 7 interrupts)
	BH = interrupt number of IRQ8 (IRQ9-F use next 7 interrupts)
	ES:SI -> GDT for protected mode (see #0400)
Return: CF set on error
	   AH = FFh  error enabling address line 20
	CF clear if successful
	   AH = 00h
	   in protected mode at specified address
Notes:	BL and BH must be multiples of 8
	the protected-mode CS must reference the same memory as the CS this
	  function is called from because execution continues with the address
	  following the interrupt call
SeeAlso: AH=87h,AH=88h,INT 67/AX=DE0Ch

Format of BIOS switch-to-protected-mode Global Descriptor Table:
Offset	Size	Description	(Table 0400)
 00h  8 BYTEs	null descriptor (initialize to zeros)
 08h  8 BYTEs	GDT descriptor (see #0401)
 10h  8 BYTEs	IDT descriptor
 18h  8 BYTEs	DS descriptor
 20h  8 BYTEs	ES
 28h  8 BYTEs	SS
 30h  8 BYTEs	CS
 38h  8 BYTEs	uninitialized, used to build descriptor for BIOS CS

Format of segment descriptor table entry:
Offset	Size	Description	(Table 0401)
 00h	WORD	segment limit, low word
 02h  3 BYTEs	segment base address, low 24 bits
 05h	BYTE	access mode (see #0402)
 06h	BYTE	386+ extended access mode (see #0403)
 07h	BYTE	386+ segment base address, high 8 bits
SeeAlso: #0400,INT 2C/AX=0002h,INT 31/AX=0009h

Bitfields for segment descriptor table access mode field:
Bit(s)	Description	(Table 0402)
 3-0	segment type
 4	descriptor type (1 = application, 0 = system)
 6-5	descriptor privilege level
 7	segment is present in RAM
SeeAlso: #0401,#0403

Bitfields for 386+ segment descriptor table extended access mode field:
Bit(s)	Description	(Table 0403)
 3-0	high 4 bits of segment limit
 4	available
 5	reserved (0)
 6	default operation size (1 = 32 bits, 0 = 16 bits)
 7	granularity (1 = 4K, 0 = byte)
SeeAlso: #0401,#0402,#1844
--------b-158900----------------------------------
INT 15 - HUNTER 16 - GET POWER MODE
	AX = 8900h
Return: AH = 00h
	BL = current power mode
	    00h Standard Power Mode (SPM)
	    01h Advanced Power Mode (APM)
SeeAlso: AX=8901h
--------b-158901----------------------------------
INT 15 - HUNTER 16 - SET POWER MODE
	AX = 8901h
	BL = new mode
	    00h Standard Power Mode (SPM)
	    01h Advanced Power Mode (APM)
Return: AH = 00h
SeeAlso: AX=8900h
--------b-158A------------------------------------
INT 15 - HUNTER 16 - CONTROL POWER INPUT (SPM)
	AH = 8Ah
	AL = new state of Power Input (00h disabled, nonzero enabled)
	SI = 1234h
	DI = 5678h
Return: AH = status
	    00h success
	    FFh failure
Desc:	Enable or disable Power Input. When Power Input is disabled the AC
	  adapter will neither charge the batteries nor supply power to the
	  Hunter 16. Disable Power Input if using Alkaline batteries.
--------b-158A-------------------------------
INT 15 - Phoenix BIOS v4.0 - GET BIG MEMORY SIZE
	AH = 8Ah
Return: DX:AX = extended memory size in K
SeeAlso: AH=88h,AX=E801h,AX=E820h
--------b-158B------------------------------------
INT 15 - HUNTER 16 - GET/SET CHARGER TEMPERATURE OVERRIDE
	AH = 8Bh
	AL = function
	    00h get
		Return:	BH = Maximum charging temperature
				Temp = -20 + (n * 0.63) degrees Centigrade
			BL = Minimum charging temperature
	    else set
		BH = maximum charging temperature (as above)
		BL = minimum charging temperature (as above)
Return: AH = status
	    00h success
	    FFh failure
Desc:	get/set the temperature interval within which the charger should
	  operate
--------b-158C------------------------------------
INT 15 - HUNTER 16 - GET/SET POWER SAVE ENTRY FLAG
	AH = 8Ch
	AL = function
	    00h get
		Return: BX = which operations disable power save (see #0404)
	    else set
		BX = which operations should disable power save (see #0404)
SeeAlso: AH=8Dh

Bitfields for HUNTER 16 operations disabling power save:
Bit(s)	Description	(Table 0404)
 0	INT 10h prevents power save
 1	INT 13h prevents power save
 2	INT 14h prevents power save
 3	INT 15h prevents power save
 4	INT 1Ah prevents power save
 5	INT 21h prevents power save
 6	direct write to video RAM prevents power save
 7	access to 8250 UART prevents power save
 8	access to 8253 (Sound) prevents power save
--------b-158D------------------------------------
INT 15 - HUNTER 16 - GET/SET BOOST CHARGE (SPM)
	AH = 8Dh
	AL = function
	    00h get
		Return: AL = Fast Charge state (00h prevented, else allowed)
	    nonzero set
		BH = Fast Charge state (00h prevent, nonzero allow)
Return: AH = status
	    00h success
	    FFh failure
Desc:	control whether Fast Charging (200ma rather than 70ma) is allowed
SeeAlso: AH=8Ch
--------B-1590-------------------------------
INT 15 - OS HOOK - DEVICE BUSY (AT,PS)
	AH = 90h
	AL = device type (see #0405)
	ES:BX -> request block for type codes 80h through BFh
	CF clear
Return: CF set if wait time satisfied
	CF clear if driver must perform wait
	    AH = 00h
Notes:	type codes are allocated as follows:
	  00-7F non-reentrant devices; OS must arbitrate access
	  80-BF reentrant devices; ES:BX points to a unique control block
	  C0-FF wait-only calls, no complementary INT 15/AH=91h call
	floppy and hard disk BIOS code uses this call to implement a timeout;
	  for device types 00h and 01h, a return of CF set means that the
	  timeout expired before the disk responded.
	this function should be hooked by a multitasker to allow other tasks
	  to execute while the BIOS is waiting for I/O completion; the default
	  handler merely returns with AH=00h and CF clear
SeeAlso: AH=91h,INT 13/AH=00h,INT 17/AH=00h,INT 1A/AH=83h

(Table 0405)
Values for device type:
 00h	disk
 01h	diskette
 02h	keyboard
 03h	PS/2 pointing device
 21h	waiting for keyboard input (Phoenix BIOS)
 80h	network
 FBh	digital sound (Tandy)
 FCh	disk reset (PS)
 FDh	diskette motor start
 FEh	printer
--------B-1591-------------------------------
INT 15 - OS HOOK - DEVICE POST (AT,PS)
	AH = 91h
	AL = device type (see #0405)
	ES:BX -> request block for type codes 80h through BFh
	CF clear
Return: AH = 00h
Note:	this function should be hooked by a multitasker to allow other tasks
	  to execute while the BIOS is waiting for I/O completion; the default
	  handler merely returns with AH=00h and CF clear
SeeAlso: AH=90h
--------x-15A100-----------------------------
INT 15 U - AMI PCI BIOS - SET ??? FLAG
	AX = A100h
Return: AX = 0000h
	CF clear
	BX,CX,DI may be destroyed
Desc:	sets bit 7 of CMOS RAM location 37h and updates the CMOS checksum in
	  locations 3Eh and 3Fh
Notes:	in the examined version of the BIOS, nonzero values in AL cause it to
	  drop through to checking the next possible value of AH, i.e. only
	  subfunction 00h is supported
	also supported by Dell XPS P90 and IBM PS/PV 6384, which also use
	  AMI BIOSes
----------15B001CX5354-----------------------
INT 15 - Stac ??? - INSTALLATION CHECK
	AX = B001h
	CX = 5354h ('ST')
	DX = 4143h ('AC')
Return: AX = 4F4Bh ('OK') if installed
Note:	this function is called by Novell DOS 7 NWCACHE v1.01
--------n-15BA10-----------------------------
INT 15 - HP OmniShare - Pen Driver - REPORT PEN CONTROL AREA EVENT
	AX = BA10h
	BL = event
	   00h the pen left control areas
	   01h the pen entered the Brightness- area
	   02h the pen entered the Brightness+ area
	   03h the pen entered the Contrast- area
	   04h the pen entered the Contrast+ area
Return:	CF clear if successfully processed
	CF set on error (function not supported, ie. not an OmniShare BIOS)
Note:	The pen driver is responsible for detecting when the pen enters and
	  leaves control areas of the OmniShare tablet, and notifying the BIOS.
	The BIOS manages the events, including the autorepetition, and sets
	  the status LEDs.
SeeAlso: AX=BA20h,AX=BA13h
--------n-15BA11-----------------------------
INT 15 - HP OmniShare - Pen Driver - SET THE COMMUNICATION LED STATE
	AX = BA11h
	BL = new LED state (00h steady, 01h flashing)
Return:	CF clear if successful
	CF set on error
Note:	this function is for use by communication software to give visual
	  feedback of active communications even if the display is in standby
	  mode.
SeeAlso: AX=BA10h,AX=BA24h
--------n-15BA12-----------------------------
INT 15 - HP OmniShare - Pen Driver - STORE PEN BATTERY CHARGE
	AX = BA12h
	BL = new battery state (00h good, 01h low charge)
Return: CF set on error
	CF clear if successfully stored in CMOS
Note:	The last report will be displayed by the Power-On Self Test the next
	  time the OmniShare boots.  This allows something meaningful to be
	  reported even if the pen is not detected during the POST.
SeeAlso: AX=BA13h
--------n-15BA13-----------------------------
INT 15 - HP OmniShare - Pen Driver - GET PEN BATTERY CHARGE
	AX = BA13h
Return: CF clear if successful
	    BL = pen battery state (00h good, 01h low charge)
	CF set on error
Note:	returns the last value set by AX=BA12h.
SeeAlso: AX=BA12h
--------p-15BA20-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - INSTALLATION CHECK
	AX = BA20h
Return: CF clear if successful (installed)
	CF set on error (not installed)
Notes:	The display controller can enter a standby mode after a given timeout,
	  to conserve power or (for the OmniShare) to increase the life of
	  the backlight.
	A side effect of standby mode is that the communications LED turns on
	  automatically when the display is in standby mode.  This is done in
	  hardware, and is intended to show that the unit is still on.
SeeAlso: AX=BA10h,AX=BA20h,AX=BA22h,AX=BA24h,AX=BA26h
--------p-15BA21-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - SET STANDBY DURATION
	AX = BA21h
	BL = new timeout before standby mode in minutes (01h-0Fh)
	    00h to disable automatic switch to standby mode
Return:	CF clear if successful
	CF set on error (function not supported)
Note:	The actual timeout with a GD6205 controller is ((N*64)-32) seconds,
	  instead of (N*60) seconds as documented.
SeeAlso: AX=BA20h,AX=BA22h
--------p-15BA22-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - GET STANDBY DURATION
	AX = BA22h
Return:	CF clear if successful
	   BL = standy duration in minutes (01h-0Fh), or 00h if disabled
	CF set on error (function not supported)
Note:	The actual timeout with a GD6205 controller is ((N*64)-32) seconds,
	  instead of (N*60) seconds as documented.
SeeAlso: AX=BA20h,AX=BA21h
--------p-15BA23-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - TURN ON THE SCREEN IMMEDIATELY
	AX = BA23h
Return: CF clear if successful
	CF set on error
SeeAlso: AX=BA11h,AX=BA20h,AX=BA24h
--------p-15BA24-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - TURN OFF THE SCREEN IMMEDIATELY
	AX = BA24h
Return: CF clear if successful
	CF set on error
Note:	This function is not implemented yet. Reserved for future versions
	  of the OmniShare.
SeeAlso: AX=BA11h,AX=BA20h,AX=BA23h
--------p-15BA25-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - PREPARE FOR UNINSTALL
	AX = BA25h
Return: CF clear if successful
	    AX = 25BAh
	    BX = PSP of STANDBY.COM resident portion
	    DX:CX -> previous INT 15 handler
	CF set on error
Note:	This function is used internally by the STANDBY.COM /u option, and
	  should not be used by application programs.
SeeAlso: AX=BA20h
--------p-15BA26-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - IS THE DISPLAY IN STANDBY MODE?
	AX = BA26h
Return: CF clear if successful
	    AL	= display state (00h active, 01h in standby mode)
	CF set on error (function not supported)
SeeAlso: AX=BA20h,AX=BA23h
--------p-15BA27-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - RESERVED FUNCTIONS
	AX = BA27h to BA2Fh
Desc:	reserved for future use
--------b-15BC-------------------------------
INT 15 - Phoenix 386 BIOS - DETERMINE CPU SPEED FOR DELAY LOOPS
	AH = BCh
Return: CF clear
	(Phoenix 1.10 10a) BYTE 0040h:00B0h set to delay loop count
	(Dell 4xxDE BIOS A11) WORD 0040h:00ECh set to delay loop count
Note:	this function reads system timer channel 0 twice, then does
	  calculations on the returned values to determine the delay loop
	  counter needed by the BIOS for beeps and floppy timeouts
SeeAlso: AX=2305h
--------E-15BF00-----------------------------
INT 15 - Rational Systems DOS/16M - ???
	AX = BF00h
	???
Return: ???
Note:	under DESQview/X 1.02 DVDOS4GX.DVR, this call is identical to AX=BF02h
SeeAlso: AX=BF02h
--------E-15BF01-----------------------------
INT 15 - Rational Systems DOS/16M - ???
	AX = BF01h
	???
Return: ???
Notes:	under DESQview/X 1.02 DVDOS4GX.DVR, this call is identical to AX=BF02h
	called by DOS/4GW
SeeAlso: AX=BF00h,AX=BF02h
--------E-15BF02DX0000-----------------------
INT 15 - Rational Systems DOS/16M - INSTALLATION CHECK
	AX = BF02h
	DX = 0000h
Return: DX = nonzero if installed
	    DX:SI -> XBRK structure (see #0406)
Note:	this function is also supported by DOS/4G
SeeAlso: AX=BF01h,AX=BFDCh,AX=BFDEh/BX=0000h
SeeAlso: INT 21/AH=FFh/DH=0Eh,INT 2F/AH=A1h,INT 2F/AX=F100h,INT 2F/AX=FBA1h

Format of DOS/16M XBRK structure:
Offset	Size	Description	(Table 0406)
 00h	DWORD	linear address of first available byte
 04h	DWORD	linear address of last available byte + 1 ???
 08h	DWORD	real-mode address of XBRK structure???
 0Ch	DWORD	???
 10h  2 BYTEs	???
 12h	WORD	segment of ???
 14h  8 BYTEs	???
 1Ch 512 BYTEs	protected-mode IDT
21Ch  N BYTEs	protected-mode GDT
--------E-15BF03-----------------------------
INT 15 - Rational Systems DOS/4GW - UNINSTALL???
	AX = BF03h
	BX = PSP segment of extender
	???
Return: ???
Note:	if BX is not the PSP segment of the extender, it passes the call down
	  the INT 15 chain; this allows nested instances of the extender
SeeAlso: AX=BF06h
--------E-15BF04-----------------------------
INT 15 - Rational Systems DOS/4GW - ???
	AX = BF04h
	BX = PSP segment of extender
Return: nothing???
Notes:	if BX is not the PSP segment of the extender, it passes the call down
	  the INT 15 chain; this allows nested instances of the extender
	grabs INT 2Fh and installs handlers for INT 2F/AX=1605h-1607h
SeeAlso: INT 2F/AX=1607h/BX=22C0h
--------E-15BF05-----------------------------
INT 15 - Rational Systems DOS/4GW - INITIALIZE PROTECTED-MODE INTERFACE
	AX = BF05h
	BX = PSP segment of extender
Return: nothing???
Notes:	if BX is not the PSP segment of the extender, it passes the call down
	  the INT 15 chain; this allows nested instances of the extender
	calls INT 67/AX=DE01h if ???
--------E-15BF06-----------------------------
INT 15 - Rational Systems DOS/4GW - ???
	AX = BF06h
	BX = PSP segment of extender
	???
Return: ???
Note:	if BX is not the PSP segment of the extender, it passes the call down
	  the INT 15 chain; this allows nested instances of the extender
SeeAlso: AX=BF03h
--------E-15BFDCDX0000-----------------------
INT 15 - Rational Systems DOS/4GW - INSTALLATION CHECK
	AX = BFDCh
	DX = 0000h
	SI = 0000h
Return: DX = nonzero if installed
	    DX:SI -> XBRK structure (see #0406)
SeeAlso: AX=BF02h
--------E-15BFDEBX0000-----------------------
INT 15 - DESQview/X - DVDOS4GX.DVR - INSTALLATION CHECK
	AX = BFDEh
	BX = 0000h
Return: AX = ??? (0003h)
	BX = FFFFh
SeeAlso: AX=BF02h
--------E-15BFDEBX0001-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET PROCESS MANAGER NAME
	AX = BFDEh
	BX = 0001h
Return: BX = 0000h (success)
	CX:DX -> name of process manager executable
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0002-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - SET ???
	AX = BFDEh
	BX = 0002h
	CX:DX -> ???
Return: BX = 0000h (success)
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=0003h
--------E-15BFDEBX0003-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0003h
Return: BX = 0000h (success)
	CX:DX -> ???
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=0002h
--------E-15BFDEBX0004-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 0004h
	CL = ???
Return: BX = 0000h (success)
	CX:DX -> XBRK structure (see #0406)
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0005-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 0005h
	CX = new value for ???
Return: BX = 0000h (success)
	AX = old value of ???
	DS:SI -> ??? (if AX nonzero on return)
	ES:DI -> ??? (if AX zero on return)
Note:	called by DOS4GW.EXE
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0006-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0006h
Return: BX = 0000h (success)
	AH = interrupt number??? (BEh)
	CX:DX = ???
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=0007h,INT BE"DESQview"
--------E-15BFDEBX0007-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - SET ???
	AX = BFDEh
	BX = 0007h
	CX:DX = ???
Return: BX = 0000h (success)
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=0006h
--------E-15BFDEBX0008-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 0008h
	CX = segment of ???
	DS = ???
Return: BX = status
	    0000h successful
		AL = ??? (80h or C0h)
		DX = ??? (0603h) if AL=C0h
	    0001h failed
		AX = 0000h
Note:	called by DOS4GW.EXE
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0009-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET PROTECTED MODE PROGRAM LOADER
	AX = BFDEh
	BX = 0009h
Return: BX = 0000h (success)
	CX:DX -> full pathname to LOAD32.EXP
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX000A-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - DECREMENT ???
	AX = BFDEh
	BX = 000Ah
Return: BX = 0000h (success)
	AX = new value of ??? counter
Notes:	also resets a variety of values if the counter goes negative
	called by DOS4GW.EXE
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=000Bh
--------E-15BFDEBX000B-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - INCREMENT ???
	AX = BFDEh
	BX = 000Bh
Return: AX = new value of ??? counter
Note:	called by DOS4GW.EXE
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=000Ah
--------E-15BFDEBX000C-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 000Ch
	CL = ???
	    00h
	    nonzero
Return: ???
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX000D-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 000Dh
	???
Return: ???
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX000E-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 000Eh
	DX:CX -> ???
Return: AX = segment of handle for calling task
	BX = ??? (probably destroyed)
	DX:CX -> ???
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=000Fh,AX=BFDEh/BX=0013h
--------E-15BFDEBX000F-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 000Fh
Return: AX = segment of handle for calling task
	BX = ??? (probably destroyed)
	DX:CX -> ???
Note:	identical to AX=BFDEh/BX=000Eh with CX:DX = 0000h:0000h
SeeAlso: AX=BFDEh/BX=000Eh,AX=BFDEh/BX=0010h
--------E-15BFDEBX0010-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET TASK HANDLE
	AX = BFDEh
	BX = 0010h
Return: AX = segment of caller's task handle
	BX destroyed
SeeAlso: AX=BFDEh/BX=000Fh
--------E-15BFDEBX0011-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0011h
Return: CX = code segment of DVDOS4GX.DVR
	BX = ??? (0004h)
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0012-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0012h
Return: DX = code segment of DVDOS4GX.DVR
	BX = ??? (012Ch)
	CX = ??? (0006h)
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0013-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0013h
Return: DX:CX -> ???
SeeAlso: AX=BFDEh/BX=000Eh
--------E-15BFDEBX0014-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - LOCK ??? MAILBOX
	AX = BFDEh
	BX = 0014h
	CX = index of ??? mailbox
		(0000h-0004h valid, but no range checking done)
Return: AX,BX destroyed
SeeAlso: AX=BFDEh/BX=0015h,AX=BFDEh/BX=0017h
--------E-15BFDEBX0015-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - UNLOCK ??? MAILBOX
	AX = BFDEh
	BX = 0015h
	CX = index of ??? mailbox
		(0000h-0004h valid, but no range checking done)
Return: AX,BX destroyed
SeeAlso: AX=BFDEh/BX=0014h,AX=BFDEh/BX=0016h
--------E-15BFDEBX0016-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - CHECK IF ??? MAILBOX OWNED
	AX = BFDEh
	BX = 0016h
	CX = index of ??? mailbox
		(0000h-0004h valid, but no range checking done)
Return: AX = status
	    0000h no one owns mailbox
	    0001h mailbox has an owner
	BX destroyed
SeeAlso: AX=BFDEh/BX=0015h,AX=BFDEh/BX=0017h
--------E-15BFDEBX0017-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ??? MAILBOX OWNER
	AX = BFDEh
	BX = 0017h
	CX = index of ??? mailbox
		(0000h-0004h valid, but no range checking done)
Return: AX = segment of mailbox owner's handle
	BX = segment of caller's task handle
SeeAlso: AX=BFDEh/BX=0015h,AX=BFDEh/BX=0016h
--------E-15BFDEBXFFFD-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = FFFDh
Return: CX:DX = ???
SeeAlso: AX=BFDEh/BX=FFFEh
--------E-15BFDEBXFFFE-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - SET ???
	AX = BFDEh
	BX = FFFEh
	CX:DX = ???
SeeAlso: AX=BFDEh/BX=FFFDh
--------E-15BFDEBXFFFF-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - NOP
	AX = BFDEh
	BX = FFFFh
SeeAlso: AX=BFDEh/BX=0000h
--------B-15C0-------------------------------
INT 15 - SYSTEM - GET CONFIGURATION (XT after 1/10/86,AT mdl 3x9,CONV,XT286,PS)
	AH = C0h
Return: CF set if BIOS doesn't support call
	CF clear on success
	    ES:BX -> ROM table (see #0407)
	AH = status
	    00h successful
	    86h unsupported function
Notes:	the 1/10/86 XT BIOS returns an incorrect value for the feature byte
	the configuration table is at F000h:E6F5h in 100% compatible BIOSes
	Dell machines contain the signature "DELL" or "Dell" at absolute FE076h
	  and a model byte at absolute address FE845h (see #0413)
	Hewlett-Packard machines contain the signature "HP" at F000h:00F8h and
	  a product identifier at F000h:00FAh (see #0416)
	Compaq machines can be identified by the signature string "COMPAQ" at
	  F000h:FFEAh, and is preceded by additional information (see #0414)
	Tandy 1000 machines contain 21h in the byte at F000h:C000h and FFh in
	  the byte at FFFFh:000Eh; Tandy 1000SL/TL machines only provide the
	  first three data bytes (model/submodel/revision) in the returned
	  table
	Toshiba laptops contain the signature "TOSHIBA" at FE010h as part of
	  a laptop information record at F000h:E000h (see #0417)
	some AST machines contain the string "COPYRIGHT AST RESEARCH" one byte
	  past the end of the configuration table
	the Phoenix 386 BIOS contains a second version and date string
	  (presumably the last modification for that OEM version) beginning at
	  F000h:FFD8h, with each byte doubled (so that both ROM chips contain
	  the complete information)
SeeAlso: AH=C7h,AH=C9h,AH=D1h

Format of ROM configuration table:
Offset	Size	Description	(Table 0407)
 00h	WORD	number of bytes following
 02h	BYTE	model (see #0412)
 03h	BYTE	submodel (see #0412)
 04h	BYTE	BIOS revision: 0 for first release, 1 for 2nd, etc.
 05h	BYTE	feature byte 1 (see #0408)
 06h	BYTE	feature byte 2 (see #0409)
 07h	BYTE	feature byte 3 (see #0410)
 08h	BYTE	feature byte 4 (see #0411)
 09h	BYTE	feature byte 5:
		reserved (0) (IBM)
		??? (08h) (Phoenix 386 v1.10)
---AWARD BIOS---
 0Ah  N BYTEs	AWARD copyright notice
---Phoenix BIOS---
 0Ah	BYTE	??? (00h)
 0Bh	BYTE	major version
 0Ch	BYTE	minor version (BCD)
 0Dh  4 BYTEs	ASCIZ string "PTL" (Phoenix Technologies Ltd)
---Quadram Quad386---
 0Ah 17 BYTEs	ASCII signature string "Quadram Quad386XT"

Bitfields for feature byte 1:
Bit(s)	Description	(Table 0408)
 7	DMA channel 3 used by hard disk BIOS
 6	2nd 8259 installed
 5	Real-Time Clock installed
 4	INT 15/AH=4Fh called upon INT 09h
 3	wait for external event (INT 15/AH=41h) supported
 2	extended BIOS area allocated (usually at top of RAM)
 1	bus is Micro Channel instead of ISA
 0	system has dual bus (Micro Channel + ISA)
SeeAlso: #0407,#0409

Bitfields for feature byte 2:
Bit(s)	Description	(Table 0409)
 7	reserved
 6	INT 16/AH=09h (keyboard functionality) supported (see #0480)
 5	INT 15/AH=C6h (get POS data) supported
 4	INT 15/AH=C7h (return memory map info) supported
 3	INT 15/AH=C8h (en/disable CPU functions) supported
 2	non-8042 keyboard controller
 1	data streaming supported
 0	reserved
SeeAlso: #0407,#0410,AH=C6h,AH=C7h,AH=C8h,INT 16/AH=09h

Bitfields for feature byte 3:
Bit(s)	Description	(Table 0410)
 7-5	reserved
 4	??? (set on 1992 PS/1's, N51SX, CL57SX, 35SX?, 40SX?)
 3	SCSI subsystem supported on system board
 2	information panel installed
 1	IML (Initial Machine Load) system
 0	SCSI supported in IML
SeeAlso: #0407,#0409,#0410

Bitfields for feature byte 4:
Bit(s)	Description	(Table 0411)
 7	??? (set on N51SX, CL57SX)
 6-4	reserved
 3	??? (set on some 1992 PS/1's, 35SX, 40SX)
 2-1	reserved
 0	??? (set on N51SX, CL57SX, 57SX)
SeeAlso: #0407,#0410

(Table 0412)
Values for model/submodel/revision:
Model  Submdl  Rev	BIOS date	System
 FFh	*	*	04/24/81	PC (original)
 FFh	*	*	10/19/81	PC (some bugfixes)
 FFh	*	*	10/27/82	PC (HD, 640K, EGA support)
 FFh	00h	rev	  ???		Tandy 1000SL
 FFh	01h	rev	  ???		Tandy 1000TL
 FFh	46h	***	  ???		Olivetti M15
 FEh	*	*	08/16/82	PC XT
 FEh	*	*	11/08/82	PC XT and Portable
 FEh	*	*	../..x..	Toshiba laptops up to ~1987
					("x"=product ID) (see #0418)
 FEh	43h	***	  ???		Olivetti M240
 FEh	A6h	???	  ???		Quadram Quad386
 FDh	*	*	06/01/83	PCjr
 FCh	*	*	01/10/84	AT models 068,099 6 MHz 20MB
 FCh	*	*	02/25/93	Linux DOSEMU (all versions)
 FCh	00h	00h	  ???		PC3270/AT
 FCh	00h	01h	06/10/85	AT model  239	  6 MHz 30MB
 FCh	00h	> 01h	  ???		7531/2 Industrial AT
 FCh	01h	00h	11/15/85	AT models 319,339 8 MHz, Enh Keyb, 3.5"
 FCh	01h	00h	09/17/87	Tandy 3000
 FCh	01h	00h	../..x..	Toshiba laptops since ~1988
					("x"=product ID) (see #0418)
 FCh	01h	00h	03/08/93	Compaq DESKPRO/i
 FCh	01h	00h	 various	Compaq DESKPRO, SystemPro, ProSignia
 FCh	01h	00h	07/20/93	Zenith Z-Lite 425L
 FCh	01h	00h	04/09/90	AMI BIOS
 FCh	01h	20h	06/10/92	AST
 FCh	01h	30h	  ???		Tandy 3000NL
 FCh	01h	???	  ???		Compaq 286/386
 FCh	02h	00h	04/21/86	PC XT-286
 FCh	02h	00h	 various	Compaq LTE Lite
 FCh	02h	00h	08/05/93	Compaq Contura 486/486c/486cx
 FCh	02h	00h	08/11/88	SoftWindows 1.0.1 (Power Macintosh)
 FCh	04h	00h	02/13/87     ** PS/2 Model 50 (10 MHz/1 ws 286)
 FCh	04h	01h	05/09/87	PS/2 Model 50 (10 Mhz 286, LW-type 32)
 FCh	04h	02h	  ???		PS/2 Model 50
 FCh	04h	02h	01/28/88	PS/2 Model 50Z (10 Mhz 286, LW-type 33)
 FCh	04h	03h	04/18/88	PS/2 Model 50Z (10 MHz/0 ws 286)
 FCh	04h	04h	  ???		PS/2 Model 50Z
 FCh	05h	00h	02/13/87     ** PS/2 Model 60 (10 MHz 286)
 FCh	06h	00h	  ???		IBM 7552-140 "Gearbox"
 FCh	06h	01h	  ???		IBM 7552-540 "Gearbox"
 FCh	08h	***	  ???		Epson, unknown model
 FCh	08h	00h	  ???		PS/2 Model 25/286
 FCh	09h	00h	  ???		PS/2 Model 25 (10 MHz 286)
 FCh	09h	00h	08/25/88	PS/2 Model 30 286 (10 Mhz, LW-type 37)
 FCh	09h	02h	06/28/89	PS/2 Model 30-286
 FCh	09h	02h	06/28/89	PS/2 Model 25 286 (10 Mhz, LW-type 37)
 FCh	0Bh	00h	12/01/89	PS/1 (LW-Type 44)
 FCh	0Bh	00h	02/16/90	PS/1 Model 2011 (10 MHz 286)
 FCh	20h	00h	02/18/93	Compaq ProLinea
 FCh	30h	***	  ???		Epson, unknown model
 FCh	31h	***	  ???		Epson, unknown model
 FCh	33h	***	  ???		Epson, unknown model
 FCh	42h	***	  ???		Olivetti M280
 FCh	45h	***	  ???		Olivetti M380 (XP 1, XP3, XP 5)
 FCh	48h	***	  ???		Olivetti M290
 FCh	4Fh	***	  ???		Olivetti M250
 FCh	50h	***	  ???		Olivetti M380 (XP 7)
 FCh	51h	***	  ???		Olivetti PCS286
 FCh	52h	***	  ???		Olivetti M300
 FCh	81h	00h	01/15/88	Phoenix 386 BIOS v1.10 10a
 FCh	81h	01h	  ???		"OEM machine"
 FCh	82h	01h	  ???		"OEM machine"
 FCh	94h	00h	  ???		Zenith 386
 FBh	00h	01h	01/10/86	PC XT-089, Enh Keyb, 3.5" support
 FBh	00h	01h	05/13/94	HP 200LX 2MB BIOS 1.01 A D german
 FBh	00h	02h	05/09/86	PC XT
 FBh	00h	04h	08/19/93	HP 100LX 1MB BIOS 1.04 A
 FBh	4Ch	***	  ???		Olivetti M200
 FAh	00h	00h	09/02/86	PS/2 Model 30 (8 MHz 8086)
 FAh	00h	01h	12/12/86	PS/2 Model 30
 FAh	00h	02h	02/05/87	PS/2 Model 30
 FAh	01h	00h	06/26/87	PS/2 Model 25/25L (8 MHz 8086)
 FAh	30h	00h	  ???		IBM Restaurant Terminal
 FAh	4Eh	***	  ???		Olivetti M111
 FAh	FEh	00h	  ???		IBM PCradio 9075
 F9h	00h	00h	09/13/85	PC Convertible
 F9h	FFh	00h	  ???		PC Convertible
 F8h	00h	00h	03/30/87     ** PS/2 Model 80 (16MHz 386)
 F8h	00h	00h	  ???		PS/2 Model 75 486 (33Mhz 486)
 F8h	01h	00h	10/07/87	PS/2 Model 80 (20MHz 386)
 F8h	02h	00h	  ???		PS/2 Model 55-5571
 F8h	04h	00h	01/29/88	PS/2 Model 70 (20 Mhz 386DX,LW-type 33)
 F8h	04h	02h	04/11/88	PS/2 Model 70 20MHz, type 2 system brd
 F8h	04h	03h	03/17/89	PS/2 Model 70 20MHz, type 2 system brd
 F8h	05h	00h	  ???		IBM PC 7568
 F8h	06h	00h	  ???		PS/2 Model 55-5571
 F8h	07h	00h	  ???		IBM PC 7561/2
 F8h	07h	01h	  ???		PS/2 Model 55-5551
 F8h	07h	02h	  ???		IBM PC 7561/2
 F8h	07h	03h	  ???		PS/2 Model 55-5551
 F8h	09h	00h	01/29/88	PS/2 Model 70 16MHz 386DX, type 1 sysbd
 F8h	09h	02h	04/11/88	PS/2 Model 70 some models
 F8h	09h	03h	03/17/89	PS/2 Model 70 some models
 F8h	09h	04h	12/15/89	PS/2 Model 70 (16 Mhz 386, LW-type 33)
 F8h	0Bh	00h	01/18/89	PS/2 Model P70 (8573-121) typ 2 sys brd
 F8h	0Bh	02h	12/16/89	PS/2 Model P70 ??
 F8h	0Ch	00h	11/02/88	PS/2 Model 55SX (16 MHz 386SX)
 F8h	0Dh	00h	  ???		PS/2 Model 70 25MHz, type 3 system brd
 F8h	0Dh	00h	06/08/88	PS/2 Model 70 386 25MHz, type 3 sys brd
 F8h	0Dh	01h	02/20/89	PS/2 Model 70 386 25MHz, type 3 sys brd
 F8h	0Dh	???	12/01/89	PS/2 Model 70 486 25Mhz, type 3 sys brd
 F8h	0Eh	00h	  ???		PS/1 486SX
 F8h	0Fh	00h	  ???		PS/1 486DX
 F8h	10h	00h	  ???		PS/2 Model 55-5551
 F8h	11h	00h	10/01/90	PS/2 Model 90 XP (25 MHz 486)
 F8h	12h	00h	  ???		PS/2 Model 95 XP
 F8h	13h	00h	10/01/90	PS/2 Model 90 XP (33 MHz 486)
 F8h	14h	00h	10/01/90	PS/2 Model 90-AK9 (25 MHz 486), 95 XP
 F8h	15h	00h	  ???		PS/2 Model 90 XP
 F8h	16h	00h	10/01/90	PS/2 Model 90-AKD / 95XP486 (33MHz 486)
 F8h	17h	00h	  ???		PS/2 Model 90 XP
 F8h	19h	05h	  ???		PS/2 Model 35/35LS or 40 (20 MHz 386SX)
 F8h	19h	05h	03/15/91	PS/2 Model 35 SX / 40 SX (LW-type 37)
 F8h	19h	06h	04/04/91	PS/2 Model 35 SX / 40 SX (LW-type 37)
 F8h	1Ah	00h	  ???		PS/2 Model 95 XP
 F8h	1Bh	00h	09/29/89	PS/2 Model 70 486 (25 Mhz 386DX)
 F8h	1Bh	00h	10/02/89	PS/2 Model 70-486 (25 MHz 486)
 F8h	1Ch	00h	02/08/90	PS/2 Model 65-121 / 65 SX (16MHz 386SX)
 F8h	1Eh	00h	02/08/90	PS/2 Model 55LS (16 MHz 386SX)
 F8h	23h	00h	  ???		PS/2 Model L40 SX
 F8h	23h	01h	  ???		PS/2 Model L40 SX (20 MHz 386SX)
 F8h	23h	02h	02/27/91	PS/2 Model L40 SX (20Mhz386SX,LW-typ37)
 F8h	25h	00h	  ???		PS/2 Model 57 SLC
 F8h	25h	06h	  ???		PS/2 Model M57 (20 MHz 386SLC)
 F8h	26h	00h	  ???		PS/2 Model 57 SX
 F8h	26h	01h	  ???		PS/2 Model 57 (20 MHz 386SX)
 F8h	26h	02h	07/03/91	PS/2 Model 57 SX (20Mhz 386SX, SCSI)
 F8h	28h	00h	  ???		PS/2 Model 95 XP
 F8h	29h	00h	  ???		PS/2 Model 90 XP
 F8h	2Ah	00h	  ???		PS/2 Model 95 XP (50 MHz 486)
 F8h	2Bh	00h	  ???		PS/2 Model 90 / 90XP486 (50 MHz 486)
 F8h	2Ch	00h	  ???		PS/2 Model 95 XP
 F8h	2Ch	01h	  ???		PS/2 Model 95 (20 MHz 486SX)
 F8h	2Dh	00h	  ???		PS/2 Model 90 XP (20 MHz 486SX)
 F8h	2Eh	00h	  ???		PS/2 Model 95 XP
 F8h	2Eh	00h	  ???		PS/2 Model 95 XP486 (20 Mhz 486SX)
 F8h	2Eh	01h	  ???		PS/2 Model 95 (20 MHz 486SX + 487SX)
 F8h	2Fh	00h	  ???		PS/2 Model 90 XP (20 MHz 486SX + 487SX)
 F8h	30h	00h	  ???		PS/1 Model 2121 (16 MHz 386SX)
 F8h	33h	00h	  ???		PS/2 Model 30-386
 F8h	34h	00h	  ???		PS/2 Model 25-386
 F8h	36h	00h	  ???		PS/2 Model 95 XP
 F8h	37h	00h	  ???		PS/2 Model 90 XP
 F8h	38h	00h	  ???		PS/2 Model 57
 F8h	39h	00h	  ???		PS/2 Model 95 XP
 F8h	3Fh	00h	  ???		PS/2 Model 90 XP
 F8h	40h	00h	  ???		PS/2 Model 95 XP
 F8h	41h	00h	  ???		PS/2 Model 77
 F8h	45h	00h	  ???		PS/2 Model 90 XP (Pentium)
 F8h	46h	00h	  ???		PS/2 Model 95 XP (Pentium)
 F8h	47h	00h	  ???		PS/2 Model 90/95 E (Pentium)
 F8h	48h	00h	  ???		PS/2 Model 85
 F8h	49h	00h	  ???		PS/ValuePoint 325T
 F8h	4Ah	00h	  ???		PS/ValuePoint 425SX
 F8h	4Bh	00h	  ???		PS/ValuePoint 433DX
 F8h	4Eh	00h	  ???		PS/2 Model 295
 F8h	50h	00h	  ???		PS/2 Model P70 (8573) (16 MHz 386)
 F8h	50h	01h	12/16/89	PS/2 Model P70 (8570-031)
 F8h	52h	00h	  ???		PS/2 Model P75 (33 MHz 486)
 F8h	56h	00h	  ???		PS/2 Model CL57 SX
 F8h	57h	00h	  ???		PS/2 Model 90 XP
 F8h	58h	00h	  ???		PS/2 Model 95 XP
 F8h	59h	00h	  ???		PS/2 Model 90 XP
 F8h	5Ah	00h	  ???		PS/2 Model 95 XP
 F8h	5Bh	00h	  ???		PS/2 Model 90 XP
 F8h	5Ch	00h	  ???		PS/2 Model 95 XP
 F8h	5Dh	00h	  ???		PS/2 Model N51 SLC
 F8h	5Eh	00h	  ???		IBM ThinkPad 700
 F8h	61h	***	  ???		Olivetti P500
 F8h	62h	***	  ???		Olivetti P800
 F8h	80h	00h	  ???		PS/2 Model 80 (25 MHz 386)
 F8h	80h	01h	11/21/89	PS/2 Model 80-A21 (25 Mhz 386)
 F8h	81h	00h	  ???		PS/2 Model 55-5502
 F8h	87h	00h	  ???		PS/2 Model N33SX
 F8h	88h	00h	  ???		PS/2 Model 55-5530T
 F8h	97h	00h	  ???		PS/2 Model 55 Note N23SX
 F8h	99h	00h	  ???		PS/2 Model N51 SX
 F8h	F2h	30h	  ???		Reply Model 32
 F8h	F6h	30h	  ???		Memorex Telex
 F8h	FDh	00h	  ???		IBM Processor Complex (with VPD)
 F8h	???	???	  ???		PS/2 Model 90 (25 MHz 486SX)
 F8h	???	???	  ???		PS/2 Model 95 (25 MHz 486SX)
 F8h	???	???	  ???		PS/2 Model 90 (25 MHz 486SX + 487SX)
 F8h	???	???	  ???		PS/2 Model 95 (25 MHz 486SX + 487SX)
 E4h	???	???	  ???		Triumph Adler PC/XT
 E1h	???	???	  ???		??? (checked for by DOS4GW.EXE)
 E1h	00h	00h	  ???		PS/2 Model 55-5530 Laptop
 D9h	???	???	  ???		Peacock XT
 9Ah	*	*	  ???		Compaq XT/Compaq Plus
 30h	???	???	  ???		Sperry PC
 2Dh	*	*	  ???		Compaq PC/Compaq Deskpro
 ???	56h	???	  ???		Olivetti, unknown model
 ???	74h	???	  ???		Olivetti, unknown model
Notes:	BIOS dates may vary without changes to the revision code, especially
	  for non-IBM machines
    * This BIOS call is not implemented in these early versions or under
      Linux's DOSEMU.  Read the Model byte at F000h:FFFEh and BIOS date at
      F000h:FFF5h instead.
   ** These BIOS versions require the DASDDRVR.SYS patches.
  *** These Olivetti and Epson machines store the submodel in the byte at
	F000h:FFFDh.
SeeAlso: #0407,#0413

(Table 0413)
Values for Dell model byte:
 02h	Dell 200
 03h	Dell 300
 05h	Dell 220
 06h	Dell 310
 07h	Dell 325
 09h	Dell 310A
 0Ah	Dell 316
 0Bh	Dell 220E
 0Ch	Dell 210
 0Dh	Dell 316SX
 0Eh	Dell 316LT
 0Fh	Dell 320LX
 11h	Dell 425E
SeeAlso: #0407,#0412

Format of Compaq product information:
Address		Size	Description	(Table 0414)
 F000h:FFE4h	BYTE	product family code (first byte)
 F000h:FFE4h	BYTE	Point release number
 F000h:FFE4h	BYTE	ROM version code
 F000h:FFE4h	BYTE	product family code (second byte)
 F000h:FFE8h	WORD	BIOS type code
SeeAlso: #0415,#0417

Format of Hewlett-Packard ROM ID at F000h:00F8h:
Offset	Size	Description	(Table 0415)
 00h  2 BYTEs	signature "HP" (48h 50h)
 02h  2 BYTEs	00h 00h
 04h	BYTE	secondary code revision
 05h	BYTE	primary code revision
 06h	BYTE	date code, year-1960 (BCD)
 07h	BYTE	date code, week of year (BCD)
SeeAlso: #0414,#0416

Bitfields for Hewlett-Packard product identifier:
Bit(s)	Description	(Table 0416)
 4-0	machine code
	0 original Vectra
	1 ES/12
	2 RS/20
	3 Portable/CS
	4 ES
	5 CS
	6 RS/16
	other reserved
 7-5	CPU type
	0 = 80286
	1 = 8088
	2 = 8086
	3 = 80386
	other reserved
SeeAlso: #0415

Format of Toshiba laptop information:
Offset	Size	Description	(Table 0417)
 00h  8 BYTEs	ASCII product number (e.g. "T2200SX ")
 08h  8 BYTEs	ASCII version number (e.g. "V1.20   ")
 10h  8 BYTEs	ASCII signature string "TOSHIBA "
 18h  8 BYTEs	always zero???
 20h	DWORD	-> built-in BIOS setup program entry point or 0000h:0000h
Note:	this record is located at F000h:E000h
SeeAlso: #0414,#0415

(Table 0418)
Values for Toshiba product ID:
model prodID   version	  date	   product number
 FEh	29h		../..)..   Toshiba T1000LE
 FEh	2Ah		../..*..   Toshiba T1000XE
 FEh	2Bh		../..+..   Toshiba T1000SE
 FEh	2Ch		../..,..   Toshiba T1000
 FEh	2Dh		../..-..   Toshiba T1200F
 FEh	2Dh	V4.00	12/26-87   Toshiba T1200H
 FEh	2Eh		../.....   Toshiba T1100+
 FCh	22h		../.."..   Toshiba T8500
 FCh	26h		01/15&88   Toshiba T5200
 FCh	27h		../..'..   Toshiba T5100
 FCh	28h		../..(..   Toshiba T2000
 FCh	2Ah		12/26*89   Toshiba T1200XE
 FCh	2Bh		../..+..   Toshiba T1600
 FCh	2Ch		../..,..   Toshiba T3100e
 FCh	2Dh		../..-..   Toshiba T3200
 FCh	2Fh		../../..   Toshiba T3100
 FCh	34h	V1.50	02/04494   Toshiba T100X
 FCh	38h		../..8..   Toshiba T2000SXe
 FCh	39h	V1.20	09/16991   Toshiba T2200SX
 FCh	39h	V1.40	10/01992   Toshiba T2200SX
 FCh	3Ch	V1.50	01/28<91   Toshiba T2000SX
 FCh	3Dh		../..=..   Toshiba T3200SXC
 FCh	3Eh		../..>..   Toshiba T3100SX
 FCh	3Fh		../..?..   Toshiba T3200SX
 FCh	40h		../..@..   Toshiba T4500C
 FCh	41h	V1.20	04/05A92   Toshiba T4500     ("T4500SXC" ???)
 FCh	45h	V3.20	04/14E92   Toshiba T4400SX   ("C" or "SXC" on cover)
 FCh	45h		01/13E93   Toshiba T4400SXC
 FCh	46h *		../..F..   Toshiba T6400
 FCh	46h *		../..F..   Toshiba T6400C
 FCh	5Fh	V1.40	01/18_94   Toshiba T3300SL
 FCh	69h		../..i..   Toshiba T1900C
 FCh	6Ah	V1.30	05/19j93   Toshiba T1900
 FCh	???		../.. ..   Toshiba T1900CT
 FCh	???		../.. ..   Toshiba T1900S
 FCh	6Dh	V1.10	12/25m92   Toshiba T1850C
 FCh	6Eh	V1.00	08/19n92   Toshiba T1850
 FCh	6Eh	V1.10	12/25n92   Toshiba T1850
 FCh	6Fh	V1.00	07/17o92   Toshiba T1800
 FCh	6Fh	V1.10	12/25o92   Toshiba T1800
 FCh	7Eh	V1.30	06/17~93   Toshiba T4600C
 FCh	7Fh	V1.40	11/10x94   Toshiba T4600
 FCh	8Ah	V1.30	10/22x93   Toshiba T6600C
 FCh	91h	V1.20	07/15x94   Toshiba T2400CT
 FCh	91h	V5.00	07/28x95   Toshiba T2400CS/CT
 FCh	92h	V5.00	07/28x95   Toshiba T3600CT
 FCh	96h *	V1.40	12/08x94   Toshiba T200
 FCh	96h *	V1.50	12/08x94   Toshiba T200CS	(T200)
 FCh	97h		../..x..   Toshiba T4800CT
 FCh	98h *	V1.10	12/22x93   Toshiba T1910
 FCh	98h *	V2.40	07/12x94   Toshiba T1910/CS	(T19XX)
 FCh	99h		../..x..   Toshiba T4700CS
 FCh	9Bh	V2.30	01/31x94   Toshiba T4700CT
 FCh	9Bh	V2.50	03/22x94   Toshiba T4700CT
 FCh	9Bh	V5.00	07/28x95   Toshiba T4700CT
 FCh	9Ch	V1.30	01/11x94   Toshiba T1950CT
 FCh	9Ch	V2.50	07/22x94   Toshiba T1950CT	(T19XX)
 FCh	9Dh *	V2.40	07/12x94   Toshiba T1950/CS	(T19XX)
 FCh	9Eh *	V1.20	12/25x93   Toshiba T3400
 FCh	9Eh *	V1.30	03/22x94   Toshiba T3400/CT
 FCh	B5h **	V5.10	08/25x95   Toshiba T2110/CS	(T21XX)
 FCh	B5h	V5.10	08/25x95   Toshiba T2130CS/CT	(T21XX)
 FCh	BAh	V1.30	02/16x95   Toshiba T2150CDS/CDT
 FCh	BAh	V5.00	07/27x95   Toshiba T2150CDS/CDT (T2150)
 FCh	BBh **	V1.30	01/25x95   Toshiba T2100/CS/CT
 FCh	BBh **	V5.00	07/27x95   Toshiba T2100/CS/CT
 FCh	BCh	V1.20	12/05x94   Toshiba T2450CT
 FCh	BCh	V5.00	07/28x95   Toshiba T2450CT
 FCh	BEh	V5.00	07/28x95   Toshiba T4850CT
 FCh	C6h	V5.30	11/30x95   Toshiba 410CS/CDT
 FCh	CAh	V5.10	08/18x95   Toshiba 400CS/CDT
 FCh	CAh	V5.40	12/18x95   Toshiba 400CS/CDT
 FCh	CBh	V5.10	09/01x95   Toshiba 610CT
 FCh	CCh		../.. ..   Toshiba 700CS/CT
 FCh	CFh	V5.00	08/07x95   Toshiba T4900CT
 FCh	???		../.. ..   Toshiba 100CS
 FCh	???		../.. ..   Toshiba 700CS/CT
 FCh	???		../.. ..   Toshiba 710CDT
 FCh	???		../.. ..   Toshiba 720CDT
Note:	the 8-bit ASCII graphics character in the "date" column above
	  has been substituted by "x" if larger than 80h
	BIOS version numbers and dates may vary, esp. due to harddisk and
	  (flash) BIOS upgrades; all BIOS versions 5.xx are flash updates
	  for Windows 95, the product number may indicate the series only
	  (T21XX) or does no longer contain the exact type suffix (CS/CT)
	[*] These models have monochrome and color versions which can be
	  distinguished with INT 42/AX=7503h (WD90C24 chipset)
	[**] These models have monochrome and color versions which can be
	  distinguished with INT 10/AX=5F50h (CT655xx chipset)
	models not found here like T21x5 are variants with other software
	  bundlings only
SeeAlso: #0412
--------B-15C1-------------------------------
INT 15 - SYSTEM - RETURN EXTENDED-BIOS DATA-AREA SEGMENT ADDRESS (PS)
	AH = C1h
Return: CF set on error
	CF clear if successful
	    ES = segment of data area
SeeAlso: AH=04h"ABIOS"
--------M-15C200-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - ENABLE/DISABLE
	AX = C200h
	BH = new state
	    00h disabled
	    01h enabled
Return: CF set on error
	AH = status (see #0419)

(Table 0419)
Values for pointing device function status:
 00h	successful
 01h	invalid function
 02h	invalid input
 03h	interface error
 04h	need to resend
 05h	no device handler installed
--------M-15C201-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - RESET
	AX = C201h
Return: CF set on error
	    AH = status (see #0419)
	CF clear if successful
	    BH = device ID
	    BL = value returned by attached device after reset
		AAh if device is a mouse
Note:	after successful completion of this call, the pointing device is set
	  as follows: disabled, sample rate 100 Hz, resolution 4 counts/mm,
	  scaling 1:1, unchanged data package size
SeeAlso: INT 33/AX=0000h
--------M-15C202-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - SET SAMPLING RATE
	AX = C202h
	BH = sampling rate
	    00h 10/second
	    01h 20/second
	    02h 40/second
	    03h 60/second
	    04h 80/second
	    05h 100/second
	    06h 200/second
Return: CF set on error
	    AH = status (see #0419)
SeeAlso: INT 33/AX=001Ch
--------M-15C203-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - SET RESOLUTION
	AX = C203h
	BH = resolution (see #0420)
Return: CF set on error
	    AH = status (see #0419)

(Table 0420)
Values for pointing device resolution:
 00h	one count per mm
 01h	two counts per mm
 02h	four counts per mm
 03h	eight counts per mm
--------M-15C204-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - GET TYPE
	AX = C204h
Return: CF set on error
	    AH = status (see #0419)
	CF clear if successful
	    BH = device ID
--------M-15C205-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - INITIALIZE
	AX = C205h
	BH = data package size (1 - 8 bytes)
Return: CF set on error
	    AH = status (see #0419)
Note:	the pointing device is set as follows: disabled, 100 Hz sample rate,
	  resolution 4 counts/mm, scaling 1:1
SeeAlso: AX=C201h
--------M-15C206-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - EXTENDED COMMANDS
	AX = C206h
	BH = subfunction
	    00h return device status
		Return: BL = pointing device status (see #0421)
			CL = resolution (see #0420)
			DL = sample rate, reports per second
	    01h set scaling at 1:1
	    02h set scaling at 2:1
Return: CF set on error
	    AH = status (see #0419)

Bitfields for pointing device status:
Bit(s)	Description	(Table 0421)
 0	right button pressed
 1	reserved
 2	left button pressed
 3	reserved
 4	0 if 1:1 scaling, 1 if 2:1 scaling
 5	device enabled
 6	0 if stream mode, 1 if remote mode
 7	reserved
--------M-15C207-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - SET DEVICE HANDLER ADDR
	AX = C207h
	ES:BX -> FAR user device handler or 0000h:0000h to cancel
Return: CF set on error
	    AH = status (see #0419)
Note:	when the subroutine is called, it is passed the following values on
	  the stack; the handler should return with a FAR return without
	  popping the stack:
		WORD 1: status (see #0422)
		WORD 2: X data (high byte = 00h)
		WORD 3: Y data (high byte = 00h)
		WORD 4: 0000h
SeeAlso: INT 33/AX=000Ch

Bitfields for pointing device status:
Bit(s)	Description	(Table 0422)
 15-8	reserved (0)
 7	Y data overflowed
 6	X data overflowed
 5	Y data is negative
 4	X data is negative
 3	reserved (1)
 2	reserved (0)
 1	right button pressed
 0	left button pressed
--------B-15C3------------------------------
INT 15 - SYSTEM - ENABLE/DISABLE WATCHDOG TIMEOUT (PS50+)
	AH = C3h
	AL = function
	    00h disable PS/2 watchdog timer
	    01h enable PS/2 watchdog timer
		BX = timer counter (0001h-00FFh)
	    02h disable Gearbox system
	    03h enable Gearbox system
Return: CF set on error
	CF clear if successful
Note:	the watchdog timer generates an NMI
SeeAlso: INT 21/AH=2Bh/CX=6269h/DX=742Dh
--------B-15C4-------------------------------
INT 15 - SYSTEM - PROGRAMMABLE OPTION SELECT (PS50+)
	AH = C4h
	AL = subfunction
	    00h return base POS register address
	    01h enable selected slot for setup
		BL = slot number (1 to 8)
	    02h disable setup for all slots (enable adapter)
Return: CF set on error
	DX = base POS register address (if subfunction 00h)
SeeAlso: AH=C6h
--------B-15C5-------------------------------
INT 15 UC - OS HOOK - ROM BIOS TRACING CALLOUT (PS30/286,PS50Z,PS95)
	AH = C5h
	AL = interrupt being invoked
	    01h INT 19
	    02h INT 14
	    03h INT 16
	    04h INT 40 (floppy INT 13)
	    05h INT 17
	    06h INT 10
	    07h INT 12
	    08h INT 11
	    09h INT 1A
Return: all registers except AX must be preserved
Notes:	called as the very first action of the indicated ROM BIOS interrupt
	  handlers on the PS/2 Models 30/286, 50Z, and 95
	default handler does nothing and returns CF clear for the above
	  subfunctions, CF set and AH=86h for all other subfunctions
	value of AX passed to the original interrupt handler is pushed on
	  stack immediately prior to call
--------B-15C6-------------------------------
INT 15 U - later PS/2 models - GET POS DATA
	AH = C6h
	???
Return: ???
Notes:	this function is referenced by name and number in some IBM BIOS manuals
	IBM reports that "there are a number of problems with this call" and
	  does not recommend its use.
SeeAlso: AH=C4h
--------B-15C7-------------------------------
INT 15 - SYSTEM - later PS/2s - RETURN MEMORY-MAP INFORMATION
	AH = C7h
	DS:SI -> user supplied memory map table (see #0423)
Note:	call AH=C0h and examine bit 4 of feature byte 2 to check if this
	  function is supported
Return: CF set on error, clear if successful
SeeAlso: AH=C0h,AH=C9h,AH=D1h

Format of memory-map table structure:
Offset	Size	Description	(Table 0423)
 00h	WORD	length of table (excluding this word)
 02h	DWORD	local memory between 1M and 16M, in 1K blocks
 06h	DWORD	local memory between 16M and 4G, in 1K blocks
 0Ah	DWORD	system memory between 1M and 16M, in 1K blocks
 0Eh	DWORD	system memory between 16M and 4G, in 1K blocks
 12h	DWORD	cacheable memory between 1M and 16M, in 1K blocks
 16h	DWORD	cacheable memory between 16M and 4G, in 1K blocks
 1Ah	DWORD	1K blocks before start of non-system memory between 1M and 16M
 1Eh	DWORD	1K blocks before start of non-system memory between 16M and 4G
 22h  2 DWORDs	reserved
--------B-15C8-------------------------------
INT 15 - SYSTEM - ENABLE/DISABLE PROCESSOR FUNCTIONS
	AH = C8h
	AL = function
	    00h disable cache or (90 and 95) disable cache L1
	    01h enable cache or (90 and 95) enable cache L1
	    ---models 90 and 95 only---
	    02h disable cache L2
	    03h enable cache L2
	    04h disable both caches
	    05h enable both caches
	    06h return status of both caches
	    07h-FFh Reserved
Return: CF set on error
	CF clear if successful
	    AH = status (see #0424)
	For subfunction 06h only:
	    BH = status of cache L2
		00h enabled
		01h disabled or not installed
	    BL = status of cache L1 (same codes as BH)
Notes:	 supported by at least PS/2 70, 70/486, 80-A21, 90, 95
	call AH=C0h and examine bit 3 of feature byte 2 to check if this
	  function is supported.
	on a 486 system, any external caches must be disabled when the
	  on-chip cache (L1) is disabled.
SeeAlso: AH=C0h

(Table 0424)
Values for status:
 00h	operation successful
 01h	function choice (in AL) is invalid
 02h	NVRAM data is invalid
 03h	cache test error
 04h	(90 and 95 only) cannot perform operation requested due to state of
	  other cache (see note above)
 05h	no L2 cache is present
 09h	CPU in protected mode
--------B-15C9-------------------------------
INT 15 - newer PS/2; various BIOSes - GET CPU TYPE AND MASK REVISION
	AH = C9h
	AL = 10h (may be required on some non-PS BIOSes)
Return: CF clear if successful
	    AH = 00h
	    CH = CPU type (see #0425)
	    CL = mask revision (stepping level) (see #0426)
	CF set on error
	    AH = status (80h,86h = function not supported)
Notes:	the BIOS must save DX at startup in order to be able to support this
	  call; PS/2 Models 56, 57, 90, and 95 are known to support it
	the PS/2 BIOS merely reads CMOS locations 190h (type) and 191h (rev)
SeeAlso: AX=DA92h

(Table 0425)
Values for CPU type:
 03h	80386DX or clone
 04h	80486
 05h	Pentium
 23h	80386SX or clone
 33h	Intel i376
 43h	80386SL or clone
 A3h	IBM 386SLC
 A4h	IBM 486SLC

(Table 0426)
Values for stepping level:
---i376 (type code 33h)---
 05h	A0
 08h	B
---80386/80386DX (type code 03h)---
 03h	Intel B1 to B10, Am386DX/DXL step A
 05h	Intel D0
 08h	Intel D1/D2/E1, Am386DX/DXL step B
---80386SL (type code 43h)---
 05h	A
 1xh	B
---80386SX (type code 23h)---
 04h	Intel A0
 05h	Intel B, Am386SX/SXL step A1
 08h	Intel C/D1, Am386SX/SXL step B
 09h	Intel 386CX/386EX/386SXstatic step A
---80486DX (type code 04h)---
 00h	Intel A0/A1
 01h	Intel B2 to B6
 02h	Intel C0
 03h	Intel C1
 04h	Intel D0
 10h	Intel cA2/cA3, Cx486SLC step A
 11h	Intel cB0/cB1
---486DX2 (type code 04h)---
 02h	Am486DX2 (unknown stepping)
 32h	Intel DX2/Overdrive steps A0 to A2
 33h	Intel DX2/Overdrive step B1
---486SX (type code 04h)---
 20h	Intel A0
 22h	Intel B0
 27h	Intel cA0
 28h	Intel cB0
---486SL (type code 04h)---
 40h	Intel A
---IntelSX2 (type code 04h)---
 5xh	Intel A
---IntelDX4 (type code 04h)---
 8xh	Intel A
---487SX (type code 04h)---
 20h	Intel A0
 21h	Intel B0
---Pentium (type code 05h)---
 0xh	Intel P5 steps Ax (1993)
 1xh	Intel P5 steps Bx (1994)
 2xh	Intel P54C step A
---RapidCAD (type code 03h)---
 40h	A
--------B-15CA-------------------------------
INT 15 U - PS/2 Model 95 - READ/WRITE CMOS MEMORY
	AH = CAh
	AL = function
	    00h read CMOS
		Return: CL = value of CMOS location
	    01h write CMOS
		CL = new value for CMOS location
	BL = CMOS location (0Eh-3Fh)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (see #0427)
Note:	writes do not update the CMOS checksum

(Table 0427)
Values for CMOS read/write error code:
 01h	CMOS lost power or has invalid checksum
 03h	specified location out of range (too high)
 04h	specified location out of range (too low)
 80h	unsupported function (PC)
 86h	unsupported function (XT)
--------B-15CB-------------------------------
INT 15 U - PS/2 Model 95 - RESERVED
	AH = CBh
	???
Return: ???
--------B-15CC-------------------------------
INT 15 U - PS/2 Model 95 - RESERVED
	AH = CCh
	???
Return: ???
--------V-15CCCC-----------------------------
INT 15 U - Toshiba laptops - VCHAD.EXE - INSTALLATION CHECK
	AX = CCCCh
Return: AX = ABCDh if installed
Note:	supported by Toshiba VGA change display utility VCHAD.EXE ver 2.90+
	  older versions have the string "VCHAD" 2 bytes after the address of
	  the INT 15 handler which is hooked by all versions for the SysReq key
SeeAlso: AH=85h
--------B-15CD-------------------------------
INT 15 U - PS/2 Model 95 - RESERVED
	AH = CDh
	???
Return: ???
--------B-15CE--BL00-------------------------
INT 15 - later PS/2s - ALLOCATE DMA ARBITRATION LEVEL
	AH = CEh
	BL = 00h-0Eh arbitration level to be allocated
	     0Fh-FFh reserved
	AL = option byte
	    bit 7-1: reserved (0)
	    bit 0: 0 = need DMA channel for arbitration level requested
		   1 = no channel required for arbitration level
Return: CF set on error
	    AH = status (80h,86h = function not supported)
	CF clear on success
	    AL = channel number
		00h-07h channel number allocated for the arbiration level
		08h-FEh reserved
		FFh	no channel requested for arbitration level
	    AH = status (see #0428)
Notes:	 arbitration level 00h has the highest priority, 0Eh the lowest
	 to perform a DMA transfer operation, be sure to call this function
	   first, and call AH=CFh afterward.  Failure to use this function
	   can cause unpredictable results.
SeeAlso: AH=CFh

(Table 0428)
Values for DMA arbitration status:
 00h	success
 01h	arbitration level not available
 02h	channel not available
 03h	invalid arbitration level passed
--------B-15CF-------------------------------
INT 15 - later PS/2s - DEALLOCATE DMA ARBITRATION LEVEL
	AH = CFh
	BL = arbitration level to be deallocated (see AH=CEh)
Return: CF set on error
	    AH = status (80h,86h = function not supported)
	CF clear on success
	    AH = status
		00h success
		04h arbitration level not allocated
SeeAlso: AH=CEh
--------B-15D0-------------------------------
INT 15 - later PS/2s - RESERVED
	AH = D0h
	???
Return: ???
----------15D042BL00-------------------------
INT 15 R - Intel Pentium Pro BIOS UPDATE - INSTALLATION CHECK
	AX = D042h
	BL = 00h
Return: CF clear if successful
	CF set on error
	AH = status
	    00h successful
		EBX:ECX = signature "INTELPEP"
		EDX = BIOS update loader version
		SI = number of 2K update blocks which can be recorded in NVRAM
	    86h not implemented
	AL = OEM error (if AH is not 00h or 86h, otherwise undefined)
	    00h successful
Program: the Pentium Pro BIOS update allows the system BIOS or other software
	  to install a microcode patch into the Pentium Pro processor
Notes:	this API must be called from actual real mode, not V86 mode
	at least 32K stack space must be available when this function is called
SeeAlso: AX=D042h/BL=01h,AX=D042h/BL=02h,AX=D042h/BL=03h
SeeAlso: @xxxxh:xxxxh"Intel BIOS Upgrade"
----------15D042BL01-------------------------
INT 15 R - Intel Pentium Pro BIOS UPDATE - WRITE BIOS UPDATE AREA
	AX = D042h
	BL = 01h
	ES:DI -> microcode update block (see #0430)
	CX,DX,SI = segments of three 64K scratchpad areas for BIOS use
Return: CF clear if successful
	CF set on error
	AH = status (see #0429)
	AL = OEM error (if AH is not 00h or 86h, otherwise undefined)
	    00h successful
Notes:	a microcode update may also be initiated by a WRMSR instruction
	  with ECX=0079h, EDX=00000000h, and EAX=linear address of update
	  block (see #0430)
	at least 32K stack space must be available when this function is called
SeeAlso: AX=D042h/BL=00h,AX=D042h/BL=02h,AX=D042h/BL=03h

(Table 0429)
Values for Pentium Pro BIOS update status:
 00h	successful
 86h	not implemented
 90h	unable to erase NVRAM device
 91h	unable to write to NVRAM device
 92h	unable to read storage
 93h	NVRAM is full
 94h	specified processor stepping is not present in system
 95h	invalid header or loader version
 96h	wrong checksum in header
 97h	processor rejected the update
 98h	the same or a more recent update is already stored
 99h	update block number was out of range

Format of Pentium Pro microcode update block:
Offset	Size	Description	(Table 0430)
 00h	DWORD	update header version number (currently 00000001h)
		FFFFFFFFh = unused block
 04h	DWORD	revision number of this microcode update
 08h	DWORD	update creation date, as BCD mmddyyyy (month,day,year)
 0Ch	DWORD	family/model/stepping of processor to which update applied
		(same value as returned by CPUID instruction)
 10h	DWORD	checksum (used to force sum of all 512 DWORDs of the update
		block to 00000000h)
 14h	DWORD	revision number of loader needed to install update
		(currently 00000001h)
 18h 24 BYTEs	reserved for future expansion
 30h 2000 BYTEs	encrypted microcode data
----------15D042BL02-------------------------
INT 15 R - Intel Pentium Pro BIOS UPDATE - BIOS UPDATE CONTROL
	AX = D042h
	BL = 02h
	BH = function
	    01h enable update loading at initialization time
	    02h check whether update loading is enabled
	CX,DX,SI = segments of three 64K scratchpad areas for BIOS use
Return: CF clear if successful
	CF set on error
	AH = status (see #0429)
	    00h successful
		BL = enabled/disabled flag
	    86h not implemented
	AL = OEM error (if AH is not 00h or 86h, otherwise undefined)
	    00h successful
Notes:	this API must be called from actual real mode, not V86 mode
	at least 32K stack space must be available when this function is called
	there is no call to disable update loading due to security risks; the
	  BIOS setup can disable loading
SeeAlso: AX=D042h/BL=00h,AX=D042h/BL=02h,AX=D042h/BL=03h
----------15D042BL03-------------------------
INT 15 R - Intel Pentium Pro BIOS UPDATE - READ BIOS UPDATE AREA
	AX = D042h
	BL = 03h
	ES:DI -> buffer for microcode update block (see #0430)
	ECX = two real-mode 64K scratchpad segments (upper and lower words)
	DX = segment of 64K scratchpad area for BIOS use
	SI = zero-based index number of update block to retrieve
Return: CF clear if successful
	CF set on error
	AH = status
	    00h successful
		ES:DI buffer filled with 2048-byte update block
	    86h not implemented
	AL = OEM error (if AH is not 00h or 86h, otherwise undefined)
	    00h successful
Program: the Pentium Pro BIOS update allows the system BIOS or other software
	  to install a microcode patch into the Pentium Pro processor
Notes:	this API must be called from actual real mode, not V86 mode
	at least 32K stack space must be available when this function is called
SeeAlso: AX=D042h/BL=00h,AX=D042h/BL=01h,AX=D042h/BL=03h
--------B-15D100DX0000-----------------------
INT 15 - later PS/2s - GET NUMBER OF DEVICE DESCRIPTOR TABLE (DDT) ENTRIES
	AX = D100h
	DX = 0000h (reserved, must set to 0)
Return: BL = size of one DDT entry, in bytes
	CX = number of DDT entries
	AH = return code (see #0431)
	CF set on error
	CF clear on success
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D101h,AX=D102h,AX=D103h,AX=D104h

(Table 0431)
Values for return code:
 00h	success
 01h	requested DDT entry not found
 02h	DDT data not valid
 86h	function not supported
--------B-15D101-----------------------------
INT 15 - later PS/2s - RETURN DEVICE DESCRIPTOR TABLE (DDT) ENTRY BY NUMBER
	AX = D101h
	BX = number of requested entry (starting with 1)
	DX = 0000h (reserved, must be set to 0)
	ES:DI -> buffer to contain DDT entry (see #0432)
Return:	AH = return code (see #0431)
	CF set on error
	CF clear on success
	    ES:DI buffer filled with DDT entry
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D100h,AX=D102h,AX=D104h

Format of Device Descriptor Table (DDT):
Offset	Size	Description	(Table 0432)
 00h	BYTE	bits 7-4: reserved (set to 0)
		bits 3-0: slot of device (0 = system board)
 01h	BYTE	bits 7-4: second interrupt for this device (0 = none)
		bits 3-0: first interrupt for this device (0 = none)
 02h	BYTE	bits 7-4: second arbitration level for this device
		bits 3-0: first arbitration level for this device
 03h	WORD	DDT indicators (see #0433)
 05h	BYTE	reserved (0)
 06h	WORD	device ID (0 = none)
 08h	WORD	starting address of first  I/O block (0 = none)
 0Ah	WORD	starting address of second I/O block (0 = none)
 OCh	WORD	starting address of third  I/O block (0 = none)
 OEh	DWORD	start of first non-system memory block (0 = none)
 12h	WORD	size of first non-system memory block (in kilobytes)
 14h	DWORD	start of second non-system memory block (0 = none)
 18h	WORD	size of second non-system memory block (in kilobytes)
 1Ah	BYTE	implementation identifier of the device
 1Bh	BYTE	implementation revision level of the device
Note:	I/O block addresses and non-system memory addresses are listed in
	  ascending order in each DDT entry.

Bitfields for DDT indicators:
Bit(s)	Description	(Table 0433)
 15	reserved (0)
 14	second arbitration level exists
 13	first arbitration level exists
 12	serial interface is RS-422
 11	not address limited
 10	DMA channel used
 9	second arbitration level can be shared
 8	first arbitration level can be shared
 7-0	reserved (0)
--------B-15D102-----------------------------
INT 15 - later PS/2s - RETURN DEVICE DESCRIPTOR TABLE (DDT) ENTRY BY I/O ADDRSS
	AX = D102h
	BX = entry number at which to start searching
	CX = requested I/O port address
	DX = 0000h (reserved, must be set to 0)
	ES:DI -> buffer to contain DDT entry (see #0432)
Return:	AH = return code (see #0431)
	BX = DDT entry number where I/O port was found, or total entries
	     plus 1 if port was not found.
	CF set on error
	CF clear on success
	    ES:DI buffer filled with DDT entry
Desc:	the DDT is searched from the specified entry for the I/O port in CX,
	  and the first entry in which it is found is returned
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D100h,AX=D101h,AX=D103h,AX=D104h
--------B-15D103DX0000-----------------------
INT 15 - later PS/2s - RETURN ENTIRE DDT
	AX = D103h
	DX = 0000h (reserved, must be set to 0)
	ES:DI -> buffer to contain DDT entry (see #0432)
Return:	AH = return code (see #0431)
	CF set on error
	CF clear on success
	    ES:DI buffer filled with DDT entry
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D100h,AX=D104h
--------B-15D104-----------------------------
INT 15 - later PS/2s - RETURN DEVICE DESCRIPTOR TABLE (DDT) ENTRY BY DEVICE ID
	AX = D104h
	BX = entry number at which to start searching
	CX = requested device ID
	DX = 0000h (reserved, must be set to 0)
	ES:DI -> buffer to contain DDT entry (see #0432)
Return:	AH = return code (see #0431)
	BX = DDT entry number where device ID was found, or total entries
	      plus 1 if port was not found.
	CF set on error
	CF clear on success
	    ES:DI buffer filled with DDT entry
Desc:	the DDT is searched from the specified entry for the device ID in CX,
	  and the first entry in which it is found is returned.
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D100h,AX=D101h,AX=D103h
--------B-15D2-------------------------------
INT 15 - later PS/2s - RESERVED
	AH = D2h
	???
Return: ???
--------B-15D3-------------------------------
INT 15 - later PS/2s - RESERVED
	AH = D3h
	???
Return: ???
--------B-15D4-------------------------------
INT 15 - later PS/2s - GET PHYSICAL FIXED DISK DRIVE NUMBER (SELECTABLE BOOT)
	AH = D4h
	DL = logical fixed disk drive number
Return:	AH = return code (see #0434)
	CF set on error
	CF clear on success
	    AL = physical fixed disk drive number

(Table 0434)
Values for return code:
 00h	success
 01h	specified logical drive number is invalid
 80h	function not supported (on PCjr and PC)
 86h	function not supported
--------B-15D5-------------------------------
INT 15 - later PS/2s - RESERVED
	AH = D5h
	???
Return: ???
--------B-15D600BL00-------------------------
INT 15 - later PS/2s - READ BOOT DEVICE ID
	AX = D600h
	BL = 00h
	DX = device ID
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D600h/BL=01h,AX=D601h/BL=00h,AX=D602h
--------B-15D600BL01-------------------------
INT 15 - later PS/2s - WRITE BOOT DEVICE ID
	AX = D600h
	BL = 01h
	DX = device ID
Return: CF clear on success
	    AH = 00h
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D600h/BL=00h,AX=D601h/BL=01h
--------B-15D601BL00-------------------------
INT 15 - later PS/2s - READ BOOT DEVICE KEY
	AX = D601h
	BL = 00h
	DX = device ID
Return: CF clear on success
	    AH = 00h
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D600h/BL=00h,AX=D601h/BL=01h,AX=D602h
--------B-15D601BL01-------------------------
INT 15 - later PS/2s - WRITE BOOT DEVICE KEY
	AX = D601h
	BL = 01h
	DX = device ID
Return: CF clear on success
	    AH = 00h
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D600h/BL=01h,AX=D601h/BL=00h
--------B-15D602-----------------------------
INT 15 - later PS/2s - QUERY BOOT REFERENCE PARTITION
	AX = D602h
Return: CF clear on success
	    AH = 00h
	    AL = status of reference-partition boot request
		00h boot not requested
		01h boot requested
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D601h/BL=00h
--------X-15D800-----------------------------
INT 15 - EISA SYSTEM ROM - READ SLOT CONFIGURATION INFORMATION
	AX = D800h
	CL = slot number (including embedded and virtual)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (80h,82h,83h,86h,87h)(see #0436)
	AL = bit flags (see #0435)
	BH = major revision level of configuration utility
	BL = minor revision level of configuration utility
	CX = checksum of configuration file
	DH = number of device functions
	DL = combined function information byte
	SI:DI = 4-byte compressed ID (DI = bytes 0&1, SI = bytes 2&3)
Note:	call with AL=80h if using 32-bit CS addressing mode instead of 16-bit
SeeAlso: AX=D801h,AX=D804h

Bitfields for EISA AL bit flags:
Bit(s)	Description	(Table 0435)
 7	set if duplicate IDs
 6	set if product ID readable
 4,5	slot type (00=expansion, 01=embedded, 10=virtual device)
 0-3	duplicate ID number if bit 7 set

(Table 0436)
Values for EISA error code:
 80h	invalid slot number
 81h	invalid function number
 82h	EISA CMOS corrupt
 83h	empty slot
 84h	error clearing CMOS
 85h	EISA CMOS is full
 86h	invalid BIOS-FW function call
 87h	invalid system configuration
 88h	config utility version not supported
--------X-15D801-----------------------------
INT 15 - EISA SYSTEM ROM - READ FUNCTION CONFIGURATION INFORMATION
	AX = D801h
	CH = function number to read
	CL = slot number (including embedded and virtual)
	DS:SI -> 320-byte buffer for standard configuration data block
Return: CF clear if successful
	    AH = 00h
	    DS:SI buffer filled
	CF set on error
	    AH = error code (80h-83h,86h,87h) (see #0436)
	BX destroyed
Note:	call with AL=81h if using 32-bit CS addressing mode instead of 16-bit
--------X-15D802-----------------------------
INT 15 - EISA SYSTEM ROM - CLEAR NONVOLATILE MEMORY (EISA CMOS)
	AX = D802h
	BH = EISA config utility major revision level
	BL = EISA config utility minor revision level
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (84h,86h,88h) (see #0436)
Note:	call with AL=82h if using 32-bit CS addressing mode instead of 16-bit
SeeAlso: AX=D803h
--------X-15D803-----------------------------
INT 15 - EISA SYSTEM ROM - WRITE NONVOLATILE MEMORY
	AX = D803h
	CX = length of data structure (0000h = empty slot)
		includes two bytes for config file checksum
	DS:SI -> configuration data
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (84h-86h) (see #0436)
Note:	call with AL=83h if using 32-bit CS addressing mode instead of 16-bit
SeeAlso: AX=D802h
--------X-15D804-----------------------------
INT 15 - EISA SYSTEM ROM - READ PHYSICAL SLOT
	AX = D804h
	CL = slot number (including embedded and virtual)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (80h,83h,86h) (see #0436)
	SI:DI = 4-byte compressed ID (DI = bytes 0&1, SI = bytes 2&3)
Note:	call with AL=84h if using 32-bit CS addressing mode instead of 16-bit
SeeAlso: AX=D800h
--------b-15D820-----------------------------
INT 15 - Compaq LTE Lite - GET ???
	AX = D820h
	DS:SI -> 17-byte buffer for ???
Return: DS:SI buffer filled (first byte is length of remaining data, unless
	  it is greater than 10h, in which case the second byte is 00h and no
	  other data is returned)
Note:	this function is also supported by Compaq's EISA System ROM, Contura
	  486/486c/486cx and recent DESKPRO/i ROMs
SeeAlso: AX=D821h
--------b-15D821-----------------------------
INT 15 - Compaq LTE Lite - SET ???
	AX = D821h
	DS:SI -> counted string (should not be more than 16 bytes)
Return: AH = 00h
Note:	this function is also supported by Compaq's EISA System ROM, Contura
	  486/486c/486cx and recent DESKPRO/i ROMs
SeeAlso: AX=D820h
--------b-15D822BL00-------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - GET ???
	AX = D822h
	BL = 00h
	CX = size of buffer or 0000h to retrieve required buffer size
	DS:SI -> buffer for ??? (if CX nonzero)
Return: CF clear if successful
	    AH = 00h
	    DH = 08h
	    CX = required buffer size to retrieve all data (if CX=0 on entry)
	    DS:SI buffer filled (if CX nonzero on entry)
	CF set on error (BL nonzero)
	    AH = 86h
--------b-15D823-----------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - ???
	AX = D823h
	BL = subfunction??? (00h or 80h)
	BH = ???
	DS:SI -> buffer for ??? (see #0437)
Return: CF clear if successful
	    AH = 00h
	    DH = 08h
	    DL = ???
	CF set on error
	    AH = error code
		86h BL neither 00h nor 80h
		87h ???

Format of Compaq EISA buffer:
Offset	Size	Description	(Table 0437)
 00h	BYTE	???
 01h	WORD	???
 03h	BYTE	???
 04h	WORD	???
 06h	WORD	???
	???
----------15D824-----------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - ???
	AX = D824h
	CX = ???
	DS:SI -> ASCIZ string containing ???
Return: CF clear if successful
	    AH = 00h
	    CX = ???
	CF set on error
	    AH = error code
		87h ??? failed
		88h ???
Note:	these functions are only available if ??? from keyboard controller
	  command C0h
----------15D825-----------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - ???
	AX = D825h
	CX = ???
	SI = ???
	DI = ???
	???
Return: CF clear if successful
	    AH = 00h
	    CX = ???
	CF set on error
	    AH = error code
		87h ??? failed
		88h ???
		    CX = ???
Note:	these functions are only available if ??? from keyboard controller
	  command C0h
----------15D826-----------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - ???
	AX = D826h
	BX = ???
	CX = size of buffer in bytes
	DS:SI -> buffer for ???
	???
Return: CF clear if successful
	    AH = 00h
	    CX = ???
	CF set on error
	    AH = error code
		87h ??? failed
		88h ???
Note:	these functions are only available if ??? from keyboard controller
	  command C0h
--------X-15D8-------------------------------
INT 15 - EISA SYSTEM ROM - 32-bit CS ADDRESSING MODE CALLS
	AH = D8h
	AL = 80h to 84h
	other registers as appropriate for AL=00h to 04h
Return: as appropriate for AL=00h to 04h
Note:	these functions are identical to AX=D800h to D804h, except that they
	  should be called when using 32-bit CS addressing mode (pointers use
	  ESI rather than SI as offset) instead of 16-bit addressing mode
SeeAlso: AX=D800h,AX=D801h,AX=D802h,AX=D803h,AX=D804h
--------b-15D8-------------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - 32-bit CS ADDRESSING MODE CALLS
	AH = D8h
	AL = A0h to A6h
	other registers as appropriate for AL=20h to 26h
Return: as appropriate for AL=20h to 26h
Note:	these functions are identical to AX=D820h to D826h, except that they
	  should be called when using 32-bit CS addressing mode
----------15DA-------------------------------
INT 15 U - AMI PCI BIOS v1.00.05.AX1 - ???
	AH = DAh
	AL = function (00h-08h,12h,14h,15h,19h,88h-8Eh,92h,99h)
	other registers vary by function
Return: CF clear if successful
	    varies by function
	CF set on error
	    AH = error code (86h unsupported [sub]function)
Note:	functions not listed above always return CF set and AH=86h; in the
	  examined BIOS, functions 02h-04h,06h-07h,89h-8Bh, and 8Dh also
	  always return CF set and AH=86h
SeeAlso: AX=DA00h,AX=DA01h,AX=DA88h,AX=DA99h,AX=DB00h
--------b-15DA00-----------------------------
INT 15 U - AMI PCI BIOS - ???
	AX = DA00h
	CL = subfunction
	    00h ???
	    01h ???
	    02h get ???
	???
Return: CF clear if successful
	    ???
	CF set on error
	    AH = error code (86h unsupported subfunction)
Note:	in the v1.00.05.AX1 BIOS, subfunctions 00h and 01h always return
	  failure
SeeAlso: AX=DA01h
--------b-15DA01-----------------------------
INT 15 U - AMI PCI BIOS - CPU SPEED CONTROL
	AX = DA01h
	CL = subfunction (00h-02h)
	    00h set low CPU speed
	    01h set high CPU speed
	    02h get current CPU speed
Return: CF clear if successful
	    AH = current/new CPU speed (00h low, 01h high)
	    AL = ??? (00h)
	CF set on error
	    AH = error code (86h unsupported subfunction)
Notes:	in the v1.00.05.AX1 BIOS, subfunctions 00h and 01h are NOPs in both
	  protected and V86 modes due to a test of MSW bit 0
	setting the CPU speed also generates the same audible signals generated
	  when manually switching speeds with Ctrl-Alt-Gray- and Ctrl-Alt-Gray+
BUG:	the BIOS apparently intends to return CF set if ???, but fails to use
	  a different exit path in that case, resulting in CF clear
----------15DA05-----------------------------
INT 15 U - AMI PCI BIOS - GET ??? AND BIOS REVISION STRINGS
	AX = DA05h
	ES:SI -> 8-byte buffer for ??? and BIOS revision strings
Return: CF clear
	ES:SI buffer filled
	AL = 00h
	CX = ??? (0000h)
Notes:	for BIOS v1.00.05.AX1, the ??? string is "IDNO" and the BIOS revision
	  string is "AX1 "
SeeAlso: AX=DA15h,AX=DB04h
----------15DA08-----------------------------
INT 15 U - AMI PCI BIOS - ???
	AX = DA08h
	???
Return: CF clear if successful
	    ???
	CF set on error
	    AH = error code (86h unsupported subfunction)
Note:	in the examined v1.00.05.AX1 BIOS, this call always returns failure
----------15DA12-----------------------------
INT 15 U - AMI PCI BIOS - v1.00.05.AX1 - ???
	AX = DA12h
	CL = subfunction
	    00h ???
	    01h	???
	    02h get ???
	    03h ???
	    04h ???
	???
Return: CF clear if successful
	    ???
	CF set on error
	    AH = error code (86h unsupported subfunction)
Desc:	??? performs various manipulations on system chipset registers
Notes:	subfunctions 00h and 01h are NOPs in protected and V86 modes due to
	  a test of MSW bit 0
	subfunctions 00h-02h always return success
----------15DA14-----------------------------
INT 15 U - AMI PCI BIOS - GET/SET ???
	AX = DA14h
	CL = subfunction
	    00h read
	    01h write
		DH = new value for ??? (00h-02h)
	DL = index of ??? (00h-03h, but not range-checked)
	???
Return: CF clear if successful
	    DH = current value of ??? if reading
	CF set on error
	    AH = error code (86h unsupported subfunction)
Note:	the values for indexes 00h and 01h are stored in CMOS RAM location 19h,
	  and the values for 02h and 03h are stored in location 36h
BUG:	the v1.00.05.AX1 BIOS range-checks DH on subfunction 00h instead of
	  subfunction 01h, even though DH is never used by subfunction 00h
----------15DA15-----------------------------
INT 15 U - AMI PCI BIOS - GET ??? AND BIOS REVISION STRINGS
	AX = DA15h
	ES:DI -> 8-byte buffer for ??? and BIOS revision strings
Return: CF clear
	ES:DI buffer filled
	AL = 00h
Note:	for BIOS v1.00.05.AX1, the ??? string is "IDNO" and the BIOS revision
	  string is "AX1 "
SeeAlso: AX=DA05h,AX=DB04h
----------15DA19-----------------------------
INT 15 U - AMI PCI BIOS - GET/SET ???
	AX = DA19h
	CL = subfunction
	    00h get first ???
	    01h get second ???
	    02h set first ???
		BX = ???
		DX = ???
	    03h set second ???
		BX = ???
		DX = ???
Return: CF clear if successful
	    AX = 0000h
	    BX,DX = ??? (subfunctions 00h and 01h only)
	CF set on error
	    AH = error code (86h unsupported subfunction)
Note:	the first ??? is stored in CMOS RAM locations 1Bh-1Eh, the second in
	  locations 1Fh-22h in the v1.00.05.AX1 BIOS
--------b-15DA20-----------------------------
INT 15 U - AMI PCI BIOS v1.00.12.AX1T - CMOS RAM BITFIELD MANIPULATION
	AX = DA20h
	BL = subfunction
	    00h set CMOS data field
		BH = CMOS data field number (00h-4Dh)
		CH = new value for bitfield (in lowest bits of register)
	    01h read CMOS data field
		BH = CMOS data field number (00h-4Dh)
		Return: CH = value of bitfield
			CL = mask of valid bits
		Note:	both CL/CH shifted to move valid bits into lowest pos
	    02h set CMOS byte
		CL = CMOS RAM address (00h-7Fh)
		CH = new value for CMOS byte
	    03h get CMOS byte
		CL = CMOS RAM address (00h-7Fh)
		Return: CH = value of CMOS byte
	    04h update CMOS checksums
		Note:	sets 2Eh/2Fh to checksum of 10h-2Dh and 7Eh/7Fh to
			  checksum of 48h-7Dh
	    05h verify CMOS checksums
		Return:	CF clear if checksums OK
			    AH = 00h
			CF set if checksum mismatch
			    AH = 01h
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (86h unsupported function/data field)
Notes:	this function was not supported by the v1.00.05.AX1 BIOS, but had been
	  added by 1.00.12.AX1T
	after using subfunctions 00h or 02h, the application must call
	  subfunction 04h to update the checksums to prevent an error the next
	  time the system is booted

(Table 0438)
Values for AMI BIOS v1.00.12.AX1T CMOS bitfield identifier:
 ID	address	bit(s)	contents
 00h	1Ah	7-6
 01h	1Dh	7-6
 02h	6Eh	1
 03h	77h	0
 04h	77h	1
 05h	77h	2
 06h	77h	3
 07h	77h	5
 08h	77h	6
 09h	77h	7
 0Ah	78h	7	power management enabled???
 0Bh	78h	6
 0Ch	10h	7-4	first floppy drive type
 0Dh	10h	3-0	second floppy drive type
 0Eh	11h	7
 0Fh	20h	4-0	selected language for error messages/setup utility
 10h	11h	2-1
 11h	11h	4
 12h	11h	0
 13h	11h	3
 14h	13h	7
 15h	13h	6-5
 16h	13h	4-2
 17h	19h	7
 18h	19h	6
 19h	19h	5
 1Ah	19h	4
 1Bh	1Eh	2-0
 1Ch	1Bh	7-6
 1Dh	1Ch	7
 1Eh	1Ch	3
 1Fh	1Ah	5-4
 20h	1Dh	5-4
 21h	1Bh	5-4
 22h	1Ch	6
 23h	1Ch	2
 24h	1Ah	3-2
 25h	1Dh	3-2
 26h	1Bh	3-2
 27h	1Ch	5
 28h	1Ch	1
 29h	1Ah	1-0
 2Ah	1Dh	1-0
 2Bh	1Bh	1-0
 2Ch	1Ch	4
 2Dh	1Ch	0
 2Eh	50h	7-0
 2Fh	51h	7-0
 30h	52h	7-0
 31h	53h	7-0
 32h	60h	0
 33h	60h	0
 34h	60h	0
 35h	60h	0
 36h	60h	0
 37h	60h	0
 38h	60h	1
 39h	61h	7
 3Ah	60h	2
 3Bh	61h	6-4
 3Ch	61h	2-0
 3Dh	60h	7-6
 3Eh	60h	5-4
 3Fh	78h	5-4
 40h	6Eh	5
 41h	1Eh	3
 42h	6Eh	0
 43h	6Eh	2
 44h	6Fh	1-0
 45h	6Fh	1-0
 46h	28h	4-2
 47h	28h	7-5
 48h	6Eh	4
 49h	6Eh	3
 4Ah	76h	7-0
 4Bh	77h	4
 4Ch	11h	6
 4Dh	1Fh	7-0
----------15DA88-----------------------------
INT 15 U - AMI PCI BIOS - GET EXTENDED MEMORY SIZE
	AX = DA88h
Return: CF clear (successful)
	AX = 0000h
	CL:BX = extended memory size in KBytes
SeeAlso: AH=88h
----------15DA8C-----------------------------
INT 15 U - AMI PCI BIOS - GET BIOS AND CHIPSET IDENTIFICATION
	AX = DA8Ch
	CL = subfunction
	    00h get BIOS version string
		ES:DI -> 12-byte buffer for version string
	    01h get chipset identification
		BL = what to retrieve
		    (00h host/PCI bridge,01h motherboard chipset)
		ES:DI -> 12-byte buffer for chipset identification (see #0439)
Return: CF clear if successful
	    ES:DI buffer filled
	CF set on error
	    AH = error code (86h unsupported subfunction)
Notes:	the v1.00.05.AX1 BIOS returns "1.00.05.AX1 " as its version string
	subfunction 01h returns the five bytes read from the PCI configuration
	  registers 00h-05h (see #0597), padded to 12 bytes with NULs
SeeAlso: AX=DB04h,PORT C000h"Neptune"

Format of AMI PCI BIOS chipset identification:
Offset	Size	Description	(Table 0439)
 00h	WORD	vendor ID (see #0598)
		8086h = Intel
 02h	WORD	device ID
		0484h (BL=01h)
		04A3h (BL=00h)
 04h	BYTE	low byte of PCI Command Register
 05h  7 BYTEs	unused (00h)
----------15DA8E-----------------------------
INT 15 U - AMI PCI BIOS - ???
	AX = DA8Eh
	???
Return: CF clear if successful
	    ???
	CF set on error
	    AH = error code (86h unsupported subfunction)
Note:	in the	v1.00.05.AX1 BIOS, this call always returns failure
----------15DA92-----------------------------
INT 15 U - AMI PCI BIOS - GET CPU TYPE AND SPEED
	AX = DA92h
Return: CF clear (successful)
	AL = CPU stepping (see also #0426 at INT 15/AH=C9h)
	AH = CPU model
	BL = CPU family (05h = Pentium, etc.)
	CX = external clock speed??? in BCD
	    (0040h,0050h,0060h,0066h are possible return values on my
	      Pentium with the Intel "Neptune" chipset)
	EAX high word destroyed
Note:	90 MHz and faster Pentium CPUs can be configured to run at 1.5 or
	  2.0 times the external clock speed, i.e. a typical 90 MHz Pentium
	  system will run the motherboard at 60 MHz (my 90 MHz Pentium returns
	  0060h in CX)
SeeAlso: AH=C9h
----------15DA99-----------------------------
INT 15 U - AMI PCI BIOS - GET/SET ??? FLAG
	AX = DA99h
	CL = subfunction
	    00h check if ???
	    01h set ??? flag
	    02h clear ??? flag
Return: CF clear if successful
	    AH = ??? (00h,01h)
	    AL = 00h
	CF set on error
	    AH = error code (86h unsupported subfunction)
Note:	the flag is stored in bit 0 of CMOS RAM location 2Ch for BIOS
	  v1.00.05.AX1
--------b-15DB00-----------------------------
INT 15 U - AMI BIOS - Flash ROM - READ FLASH BIOS
	AX = DB00h
	DS:SI -> parameter block (see #0440)
	ES:DI -> buffer for copied information
Return: CF clear if successful
	CF set on error
	    AH = status (86h if not implemented)
	DS,ES destroyed, possibly other registers
Note:	used by FMUP.EXE, Intel's Flash Memory Update utility
SeeAlso: AH=DAh,AX=DB01h,AX=DB04h

Format of AMI BIOS Flash ROM parameter block:
Offset	Size	Description	(Table 0440)
 00h 32 BYTEs	ASCIZ description of the file's contents
 20h	BYTE	Logical area type (see #0441)
 21h	DWORD	logical area size (overall size of area)
 25h	BYTE	flag: load from file (FF=yes, 00=no)
 26h	BYTE	flag: reboot after update (FF=yes, 00=no)
 27h	BYTE	flag: update entire image (FF=yes, 00=no)
 28h 24	BYTEs	ASCIZ logical area name (cooresponds to offset 20)
		"System BIOS"
		"Logo Data Area", etc.
 40h 15 BYTEs	ASCIZ time stamp string: MM/DD/YY-HH:MM
 4Fh	BYTE	checksum for this header (sum of all bytes except this one)
		if checksum would be 00h,01h, or FFh, it is set to 2Ah
 50h	DWORD	this file's starting address (offset in image)
 54h	DWORD	size of image chunk in this file
 58h	BYTE	logical area type - same as offset 20h
 59h	BYTE	flag: last file in chain (FF=yes, 00=no)
 5Ah  6 BYTEs	ASCIZ signature "FLASH"
 60h 16 BYTEs	ASCIZ filename of next file in chain
 70h 16 BYTEs	ASCIZ BIOS reserved string (usually version #)
Notes:	this block is identical in format to the 128-byte header on an AMI
	  BIOS Update file
	for AX=DB00h, the following fields must be specified: 50h,54h,58h;
	  the fields at offset 20h and 5Ah should also be set if possible
	the fields at offsets 40h and 70h will be set on return, if available
SeeAlso: #0442
--------b-15DB01-----------------------------
INT 15 U - AMI BIOS - Flash ROM - GET BIOS SUBSYSTEM INFORMATION
	AX = DB01h
	CL = BIOS subsystem information identifier (see #0441)
Return: CF clear if successful
	    AX = 0000h
	    ES:DI -> 56-byte record describing subsystem (see #0442)
	CF set on error
	    AH = status
		01h nonexistent subsystem
		86h function not supported
	    AL = 00h
Note:	used by FMUP.EXE, Intel's Flash Memory Update utility
SeeAlso: AX=DB00h,AX=DB02h

(Table 0441)
Values for AMI BIOS subsystem identifier:
 00h	recovery code
 01h	system BIOS
 02h	PCI configuration data
 03h	OEM logo data area (see #0443)
 04h	system BIOS/Language Set (one system)
	configuration utility (another system)
SeeAlso: #0442

Format of AMI BIOS subsystem information:
Offset	Size	Description	(Table 0442)
 00h	BYTE	subsystem identifier/logical area type (see #0441)
 01h	DWORD	subsystem (FlashROM page) size in bytes
 05h	BYTE	flag: loadable from file (FFh=yes)
 06h	BYTE	flag: reboot after update (FFh=yes)
 07h	BYTE	flag: update entire image (FFh=yes)
 08h 24 BYTEs	subsystem/logical area name
 20h	BYTE	subsystem identifier???
 21h	BYTE	flag: reprogrammable if FFh
 22h	BYTE	??? (01h,02h seen)
 23h  5 BYTEs	??? (apparently always 00h)
 28h 16 BYTEs	BIOS reserved string (usually version number)
SeeAlso: #0440

Format of AMI OEM Logo data area:
Offset	Size	Description	(Table 0443)
 00h  8 BYTEs	signature
		"TEXTLOGO" if text-mode OEM logo
		8 DUP (FFh) if unused
 08h	WORD	offset of logo font definition table
 0Ah	WORD	offset of logo data
 0Ch	WORD	size of logo font table in words
 0Eh	WORD	offset of upper left corner of logo in video page
 10h	WORD	width of logo
 12h	WORD	height of logo
 14h	BYTE	reserved???
 var	var	logo font definition (16 bytes per character)
 var	var	logo data as character/attribute pairs
Note:	the attribute for the logo characters specifies which font will be used
	  for that character.  If bit 3 is cleared, the normal system font is
	  used; if bit 3 is set, the logo font is used, with screen colors
	  adjusted to match the corresponding non-bright attribute for the
	  system font
SeeAlso: #0441,#0442
--------b-15DB02-----------------------------
INT 15 U - AMI BIOS - Flash ROM - GET SIZE OF FLASH ROM PROGRAMMING CODE
	AX = DB02h
Return: CF clear
	AX = 0000h
	BX = size of ROM programming code in bytes
Note:	used by FMUP.EXE, Intel's Flash Memory Update utility
SeeAlso: AX=DB00h,AX=DB03h
--------b-15DB03-----------------------------
INT 15 U - AMI BIOS - Flash ROM - GET FLASH ROM PROGRAMMING CODE
	AX = DB03h
	DS:SI -> ???
	ES:DI -> buffer for Flash ROM programming code
	BX = ???
	DX = ???
Return: CF clear if successful
	    AH = ???
	    BX = ???
	    DX = ???
	CF set on error
	    AH = error code
Notes:	the entry point for the copied code (which is fully relocatable) is
	  the very first byte (see #0444)
	used by FMUP.EXE, Intel's Flash Memory Update utility
SeeAlso: AX=DB00h,AX=DB02h

(Table 0444)
Call AMI BIOS ??? code with:
	AL = function
	    00h erase Flash ROM block
		CX = ???
			bit 8: address line A16 inverted
		???
	    01h program new data into Flash ROM
		???
	    02h perform cold reboot
	DS:SI -> ??? (see #0445)
	ES:DI -> ???
Return: AH = status
	    00h successful
	    01h invalid function
	    02h ???
	    03h ???
	    04h ???
Note:	DS:SI and ES:DI are ignored for function 02h

Format of AMI BIOS Flash ROM programming parameters:
Offset	Size	Description	(Table 0445)
 00h 32 BYTEs	???
 20h	BYTE	BIOS section number
 21h	DWORD	length of BIOS code/data in bytes
 25h 43 BYTEs	???
 50h	DWORD	???
 54h 44 BYTEs	???
SeeAlso: #0444
--------b-15DB04-----------------------------
INT 15 U - AMI BIOS - Flash ROM - GET BIOS REVISION
	AX = DB04h
Return: CF clear if supported
	    BL:BH:DL:DH = BIOS revision string
		(e.g. 'AX1 ' for v1.00.05.AX1, 'AV0M' for v1.00.03.AV0M)
	    CL = flag: DH valid?
		00h ignore DH; ignore DL as well if 20h (space)
		01h ignore DH if 20h (space)
	    CH = BIOS status
		00h normal mode
		01h ROM recovery mode
	    AL = ??? (02h)
Note:	used by FMUP.EXE, Intel's Flash Memory Update utility
SeeAlso: AX=DA05h,AX=DA15h,AX=DA8Ch,AX=DB00h,AX=DB03h
--------Q-15DE00-----------------------------
INT 15 - DESQview - GET PROGRAM NAME
	AX = DE00h
Return: AX = offset into DESQVIEW.DVO of program most recently selected from
	      the "Switch Windows" menu (see #0446)
Note:	always returns AX=0000h under DESQview/X
SeeAlso: AX=DE07h

Format of program entry in DESQVIEW.DVO:
Offset	Size	Description	(Table 0446)
 00h	BYTE	length of name (FFh if end of file)
 01h  N BYTEs	name
      2 BYTEs	keys to invoke program (second = 00h if only one key used)
	BYTE	program type
		00h normal program
		04h divider
		80h Delete a Program
		81h Change a Program
	WORD	??? apparently always 0000h
--------Q-15DE01-----------------------------
INT 15 - DESQview - UPDATE "OPEN WINDOW" MENU
	AX = DE01h
Return: nothing
Notes:	reads DESQVIEW.DVO, disables Open menu if file not in current directory
	NOP for DESQview/X
--------Q-15DE02-----------------------------
INT 15 - DESQview 1.x only - SET ??? FLAG FOR CURRENT WINDOW
	AX = DE02h
Return: nothing
Note:	this call is a NOP in DV 2.x
SeeAlso: AX=DE03h
--------Q-15DE03-----------------------------
INT 15 - DESQview 1.x only - GET ??? FOR CURRENT WINDOW
	AX = DE03h
Return: AX = ??? for current window
	BX = ??? for current window
Note:	this call is a NOP in DV 2.x
SeeAlso: AX=DE02h
--------Q-15DE04-----------------------------
INT 15 - DESQview - GET AVAILABLE COMMON MEMORY
	AX = DE04h
Return: BX = bytes of common memory available
	CX = largest block available
	DX = total common memory in bytes
SeeAlso: AX=DE05h,AX=DE06h
--------Q-15DE05-----------------------------
INT 15 - DESQview - GET AVAILABLE CONVENTIONAL MEMORY
	AX = DE05h
Return: BX = KB of memory available
	CX = largest block available
	DX = total conventional memory in KB
SeeAlso: AX=DE04h,AX=DE06h
--------Q-15DE06-----------------------------
INT 15 - DESQview - GET AVAILABLE EXPANDED MEMORY
	AX = DE06h
Return: BX = KB of expanded memory available
	CX = largest block available
	DX = total expanded memory in KB
SeeAlso: AX=DE04h,AX=DE05h
--------Q-15DE07-----------------------------
INT 15 - DESQview - "APPNUM" - GET CURRENT PROGRAM'S NUMBER
	AX = DE07h
Return: AX = number of program as it appears on the "Switch Windows" menu
Note:	this API call may be made from a hardware interrupt handler
SeeAlso: AX=DE00h
--------Q-15DE08-----------------------------
INT 15 - DESQview - GET ???
	AX = DE08h
Return: AX = 0000h if ??? is not set to the current task
	     0001h if ??? is set to the current task
--------Q-15DE09-----------------------------
INT 15 - DESQview - UNIMPLEMENTED
	AX = DE09h
Return: nothing (NOP in DV 1.x and 2.x)
--------Q-15DE0A-----------------------------
INT 15 - DESQview v2.00+ - "DBGPOKE" - DISPLAY CHARACTER ON STATUS LINE
	AX = DE0Ah
	BL = character
Return: character displayed, next call will display in next position (which
	wraps back to the start of the line if off the right edge of screen)
Notes:	displays character on bottom line of *physical* screen, regardless
	  of current size of window (even entirely hidden)
	does not know about graphics display modes, just pokes the characters
	  into display memory
	this API call may be made from a hardware interrupt handler
SeeAlso: AX=1003h
--------Q-15DE0B-----------------------------
INT 15 - DESQview v2.00+ - "APILEVEL" - DEFINE MINIMUM API LEVEL REQUIRED
	AX = DE0Bh
	BL = API level minor version number
	BH = API level major version number
Return: AX = maximum API level (AH = major, AL = minor)
Notes:	if the requested API level is greater than the version of DESQview, a
	  "You need a newer version" error window is popped up
	the API level defaults to 1.00, and is inherited by child tasks
--------Q-15DE0C-----------------------------
INT 15 - DESQview v2.00+ - "GETMEM" - ALLOCATE "SYSTEM" MEMORY
	AX = DE0Ch
	BX = number of bytes
Return: ES:DI -> allocated block or 0000h:0000h (DV 2.26+)
Note:	use SETERROR (AX=DE15h) to avoid a user prompt if there is insufficient
	  system memory
SeeAlso: AX=1001h,AX=102Eh,AX=DE0Dh,AX=DE15h,AX=DE19h
--------Q-15DE0D-----------------------------
INT 15 - DESQview v2.00+ - "PUTMEM" - DEALLOCATE "SYSTEM" MEMORY
	AX = DE0Dh
	ES:DI -> previously allocated block
Return: nothing
SeeAlso: AX=1002h,AX=DE0Ch
--------Q-15DE0E-----------------------------
INT 15 - DESQview v2.00+ - "FINDMAIL" - FIND MAILBOX BY NAME
	AX = DE0Eh
	ES:DI -> name to find (see #0447)
	CX = length of name
Return: BX = 0000h not found
	     0001h found
		DS:SI = object handle
SeeAlso: AH=12h/BH=11h,AH=12h/BX=1200h"GETNAME"

(Table 0447)
Values for special DESQview mailbox names:
 "COM1" ... "COM4"	RBcomm using COM1 ... COM4
 "DESQview/X Help Engine"
 "DESQview/X Network Server"  Network Manager
 "DESQview X Server0"	X-Windows server
 "DESQview X Server7"	X-Windows printing service
 "INBOX"		DESQview/X LPD requests
 "OUTBOX"		DESQview/X LPD responses
 "WAITBOX"		semaphore to synchronize DESQview/X LPD communications
 "_DVNM_"		DV/X v1.10 network manager
--------Q-15DE0F-----------------------------
INT 15 - DESQview v2.00+ - ENABLE DESQview EXTENSIONS
	AX = DE0Fh
Return: AX and BX destroyed (seems to be bug, weren't saved&restored)
Notes:	sends a manager stream with opcodes AEh, BDh, and BFh to task's window
	enables an additional mouse mode
--------Q-15DE10-----------------------------
INT 15 - DESQview v2.00+ - "PUSHKEY" - PUT KEY INTO KEYBOARD INPUT STREAM
	AX = DE10h
	BH = scan code
	BL = character
Return: nothing
Notes:	a later read will get the keystroke as if it had been typed by the user
	multiple pushes are read last-in first-out
	if a script exists for the pushed key in the current application, the
	  script will be executed
	early copies of DV 2.00 destroy AX, BX, ES, and DI
SeeAlso: INT 16/AH=05h
--------Q-15DE11BL00-------------------------
INT 15 - DESQview v2.00+ - "JUSTIFY" - EN/DISABLE AUTOM. WINDOW JUSTIFICATION
	AX = DE11h
	BL = 00h      viewport will not move automatically
	     nonzero  viewport will move to keep cursor visible (default)
Return: nothing
--------Q-15DE12BX0000-----------------------
INT 15 - DESQview v2.01+ - "CSTYLE" - SET "C"-COMPATIBLE CONTROL CHAR INTERPRET
	AX = DE12h
	BX = 0000h    select normal style (linefeed only moves down)
	     nonzero  select C style (linefeed moves to start of next line)
Return: nothing
Note:	set on a per-task basis, and inherited from the parent task
--------Q-15DE13-----------------------------
INT 15 - DESQview v2.20+ - "GETCRIT" - GET CRITICAL NESTING COUNT
	AX = DE13h
Return: BX = number of calls to BEGINC or ENTERC
	      (see INT 15/AX=101Bh,INT 15/AX=DE1Ch) without matching ENDC
	      (see INT 15/AX=101Ch)
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=101Bh,AX=101Ch,AX=DE1Bh,AX=DE1Ch
--------Q-15DE14-----------------------------
INT 15 - DESQview v2.20+ - GET OBJECT TYPE
	AX = DE14h
	ES:DI -> object
Return: BL = 00h not an object
	     08h window or task
	     09h mailbox
	     0Ah keyboard
	     0Bh timer
	     0Ch objectq
	     0Fh pointer
	     10h panel
SeeAlso: AX=1016h
--------Q-15DE15-----------------------------
INT 15 - DESQview v2.20+ - SET ERROR HANDLING
	AX = DE15h
	BL = error handling mode
	    00h post system error on all error conditions
	    01h return carry flag set on calls to ADDTO, SUBFROM, and WRITE
		messages sent to mailboxes which fail due to lack of system
		or common memory
	    02h (v2.26+) same as 01h, but also return null pointer for GETMEM
		calls which fail due to lack of system memory
Return: nothing
SeeAlso: AX=DE0Ch,AX=DE16h
--------Q-15DE16-----------------------------
INT 15 - DESQview v2.20+ - GET ERROR HANDLING
	AX = DE16h
Return: BL = current mode
	    00h always post system error
	    01h return carry flag set on failed mailbox writes
	    02h return CF set on failed mailbox writes and NULL on failed
		GETMEM calls
SeeAlso: AX=DE15h
--------Q-15DE17-----------------------------
INT 15 - DESQview v2.20-2.25 - reserved
	AX = DE17h
Return: pops up "Programming error" window
Note:	AX = 1117h is NOT identical to this call under DESQview 2.20 thru 2.25
SeeAlso: AX=1117h
--------Q-15DE17-----------------------------
INT 15 - DESQview v2.26+ - "ASSERTMAP" - GET/SET MAPPING CONTEXT
	AX = DE17h
	BX = function
	    0000h   get current mapping context without setting
	    nonzero set new mapping context to BX
Return: BX = mapping context in effect before call
Notes:	mapping contexts determine conventional-memory addressability; setting
	  a mapping context ensures that the associated program and data areas
	  are in memory for access.  Usable by drivers, TSRs and shared
	  programs.
	caller need not be running under DESQview
	this API call may be made from a hardware interrupt handler
SeeAlso: AX=1016h,AX=1117h,AX=DE21h,INT 2F/AX=1685h
--------Q-15DE18-----------------------------
INT 15 - DESQview v2.20+ - internal - ???
	AX = DE18h
	BP = function number
	    high byte must be 10h
	    low byte is function
		00h set ???
		    BL = ???  (00h-10h, video mode???)
		    BH = value to store
		03h set ???
		    BL = ??? (stored in driver)
		0Ah get ???
		    ES:DI -> 18-byte buffer to hold ???
Note:	calls video driver (NOP for Hercules driver,probably CGA and MCGA also)
--------Q-15DE19-----------------------------
INT 15 - DESQview v2.23+ - "GETCOMMON" - ALLOCATE "COMMON" MEMORY
	AX = DE19h
	BX = number of bytes to allocate
Return: AX = 0000h successful
		ES:DI -> allocated block
	     nonzero insufficient memory
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=DE0Ch,AX=DE15h,AX=DE1Ah
--------Q-15DE1A-----------------------------
INT 15 - DESQview v2.23+ - "PUTCOMMON" - DEALLOCATE "COMMON" MEMORY
	AX = DE1Ah
	ES:DI -> previously allocated block
Return:	AX = 0000h (successful)
Note:	this function may be called from within a hardware interrupt handler
SeeAlso: AX=DE0Dh,AX=DE19h
--------Q-15DE1B-----------------------------
INT 15 - DESQview v2.23+ internal - DECREMENT CRITICAL NESTING COUNT
	AX = DE1Bh
Return: nothing
SeeAlso: AX=101Ch,AX=DE13h,AX=DE1Ch
--------Q-15DE1C-----------------------------
INT 15 - DESQview v2.23+ - "ENTERC" - INCREMENT CRITICAL NESTING COUNT
	AX = DE1Ch
Return: nothing
Notes:	similar to AX=101Bh, but begins the critical region without ensuring
	  that DOS is free
	the official documentation states that this call should be paired with
	  "ENDC" (AX=101Ch); no mention is made of AX=DE1Bh
	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=101Bh,AX=101Ch,AX=DE13h,AX=DE1Bh
--------Q-15DE1D-----------------------------
INT 15 - DESQview v2.23+ - "PUTKEY" - FAKE USER KEYSTROKES
	AX = DE1Dh
	DX = segment of handle for task to receive keystroke
	BL = character
	BH = scan code
Return: AX = 0000h if successful
	   nonzero if receiver's keyboard buffer was full
Notes:	the key is treated as though the user had pressed it, ignoring any
	  script which may be bound to the key, and using the current field
	  table if the keyboard object is in field processing mode
	multiple PUTKEYs are seen in the order in which they are executed
SeeAlso: AX=DE10h
--------Q-15DE1E-----------------------------
INT 15 - DESQview v2.23+ - "SCRNINFO" - GET TRUE VIDEO PARAMETERS
	AX = DE1Eh
Return: CL = actual number of rows on screen
	CH = actual number of columns on screen
	BL = actual video mode (may differ from INT 10/AH=0Fh return) (v2.26+)
Note:	this API call may be made from a hardware interrupt handler
SeeAlso: INT 10/AH=0Fh
--------Q-15DE1F-----------------------------
INT 15 - DESQview v2.23+ - "DOSUSER" - GET HANDLE OF TASK CURRENTLY USING DOS
	AX = DE1Fh
Return: BX = segment of task handle or 0000h if no tasks are using DOS
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=DE13h,INT 21/AH=34h
--------Q-15DE20-----------------------------
INT 15 - DESQview v2.26+ - "DISPATCHINT" - INTERRUPT ANOTHER TASK
	AX = DE20h
	BX = segment of handle of task to interupt
	DX:CX -> FAR interrupt routine
	BP,SI,DI,DS,ES as required by interrupt routine
Return: nothing
Notes:	unlike "PGMINT" (AX=1021h), DISPATCHINT may be applied to the task
	  making the DISPATCHINT call
	multiple "DISPATCHINT" calls are processed in the order in which they
	  were executed
	the FAR routine is entered with the current ES, DS, SI, DI, and BP
	  values, using the task's internal stack (see AX=101Ah); only SS:SP
	  needs to be preserved
	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=1021h,AX=DE2Ah
--------Q-15DE21-----------------------------
INT 15 - DESQview v2.26+ - "ASSERTVIR" - CONTROL 386 SCREEN VIRTUALIZATION
	AX = DE21h
	BX = new state
	    0000h turn off
	    nonzero turn on
Return: BX = old state of virtualization
Notes:	this API call may be made from within a hardware interrupt handler
	under DV 2.40 and 2.42, this call appears to have no effect and always
	  returns a nonzero value in BX which appears to be the offset within
	  the DV common memory segment of the caller's task object; it may
	  only have an effect within a hardware interrupt handler
SeeAlso: AX=1117h,AX=DE17h
--------Q-15DE22-----------------------------
INT 15 - DESQview v2.26+ - "PROCESSMEM" - GET TASK MEMORY STATUS
	AX = DE22h
	DX = segment of task handle
Return: DX = total amount of memory in paragraphs
	BX = amount of system memory in paragraphs
	CX = largest block of system memory available in paragraphs
	AX = memory flags (see #0448)
Notes:	if the task handle is a child task, the returned values will be for the
	  process containing the task, rather than the task itself
	if the process's system memory is swapped out, BX,CX,DX remain
	  unchanged, because the memory usage cannot be determined
SeeAlso: AX=DE04h,AX=DE05h,AX=DE06h

Bitfields for DESQview process memory flags:
Bit(s)	Description	(Table 0448)
 0	system memory resides in shared memory
 1	process's memory is swapped out
 2	process's system memory is swapped out
--------Q-15DE23-----------------------------
INT 15 U - DESQview v2.31+ - ???
	AX = DE23h
	BX = ??? IRQ number on first PIC?
	CX = ??? IRQ number on second PIC?
Return: ???
Note:	called by QEMM 6.00+
--------Q-15DE24-----------------------------
INT 15 - DESQview v2.40+ - "XNEWPROC" - START NEW APPLICATION
	AX = DE24h
	BX = length of .DVP data
	CX = length of ??? string
	DS:SI -> ??? string
	ES:DI -> .DVP data (see #0329 at AX=102Ch)
Return: BX = segment of task handle??? or 0000h on error
Note:	this call is similar to AX=102Ch except that it can interpret the
	  extended DVP data
SeeAlso: AX=102Ch
--------Q-15DE25-----------------------------
INT 15 - DESQview v2.40+ - "GETDVPATH" - GET DESQview DIRECTORY
	AX = DE25h
	ES:DI -> 67-byte buffer for ASCIZ directory name
Return: ES:DI buffer filled with directory from which DESQview was started
BUG:	DV 2.42 does not place a terminating NUL at the end of the directory
	  name, so if the buffer is not cleared to zeros before the call,
	  there is no way to tell where the directory name ends.  This bug
	  has been fixed in DV 2.52 (DV/X 1.02)
SeeAlso: AX=DE2Eh,INT 21/AH=47h
--------Q-15DE26-----------------------------
INT 15 - DESQview v2.40+ - "GETFOREGROUND" - GET KEYBOARD FOCUS
	AX = DE26h
Return: BX = segment of handle for task with keyboard focus
Note:	under DESQview/X, the X server always has the keyboard focus unless a
	  "direct" window is active
SeeAlso: AX=DE2Fh,INT 2F/AX=DE0Ah
--------Q-15DE27-----------------------------
INT 15 - DESQview v2.50+ - "ADDINSTANCEDATA" - ADD PER-TASK SAVE/RESTORE AREA
	AX = DE27h
	BX = type
	    0000h process
	    0001h task
	ES:DI -> list of Instance Item Structures (see #0449)
Return: CF clear if successful
	    AX = ???
	    BX = ???
	CF set on error
	    AX = error code???
		0004h invalid BX value
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
SeeAlso: INT 2F/AX=DE08h,INT 2F/AX=DE09h

Format of DESQview Instance Item Structure [one element of list]:
Offset	Size	Description	(Table 0449)
 00h	WORD	length of data area DESQview should save and restore on context
		  switches (0000h = end of list)
 02h	DWORD	pointer to area to be saved/restored
--------Q-15DE28-----------------------------
INT 15 U - DESQview v2.50+ - ???
	AX = DE28h
	BX = segment of ??? or 0000h for default
	???
Return: ???
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
SeeAlso: AX=DE2Ah
--------Q-15DE29BX0000-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0000h
	???
Return: CF clear if successful
	    ???
	CF set on error
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	under DESQview 2.60, this function and all other subfunctions of
	  AX=DE29h always return CF set, as they are unique to DESQview/X
--------Q-15DE29BX0001-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0001h
	DX = segment of window handle
Return: CF clear if successful
	    AX = ???
	    DX = ???
	CF set on error
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
--------Q-15DE29BX0002-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0002h
	DX = segment of window handle
Return: CF clear if successful
	    AX = ???
	    DX = ???
	CF set on error
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
--------Q-15DE29BX0003-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0003h
	DX = segment of window handle
Return: CF clear if successful
	    ???
	CF set on error
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
--------Q-15DE29BX0004-----------------------
INT 15 U - DESQview/X - GET DISPLAY NAME
	AX = DE29h
	BX = 0004h
	CX = size of buffer in bytes
	DX = segment of window handle
	ES:DI -> buffer for display name
Return: CF clear if successful
	    buffer filled with ASCIZ display name (truncated if necessary) or
	      null string if no display
	CF set on error
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	the name ":0" refers to the local display
--------Q-15DE29BX0005-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0005h
	???
Return: CF clear if successful
	    ???
	CF set on error
Note:	under DESQview 2.60, this function and all other subfunctions of
	  AX=DE29h always return CF set, as they are unique to DESQview/X
--------Q-15DE2A-----------------------------
INT 15 - DESQview v2.50+ - "DISPATCHINTAFTERDOS" - INTERRUPT ANOTHER TASK
	AX = DE2Ah
	BX = segment of handle for task to interrupt or 0000h for caller
	DX:CX -> interrupt routine
	BP,SI,DI,DS,ES as required by interrupt routine
Return: nothing
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	this call is the same as AX=DE20h except that it will delay
	  interrupting the specified task until after it has exited DOS
SeeAlso: AX=1021h,AX=DE20h
--------Q-15DE2B-----------------------------
INT 15 - DESQview v2.50+ - "OBJNEXT" - TRAVERSE OBJECT LIST
	AX = DE2Bh
	ES:DI -> starting object
		0000h:0000h for first object in list???
Return: AX = status
	    0000h successful
		ES:DI -> next object of same type (window/non-window)
	    0001h failed (ES:DI was not a valid handle)
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	there are two separate lists, one for window/task objects and one
	  for all other objects
SeeAlso: AX=1016h,AX=DE2Ah,AX=DE2Ch
--------Q-15DE2C-----------------------------
INT 15 - DESQview v2.50+ - "WININFO" - GET WINDOW INFORMATION
	AX = DE2Ch
	DX = window information format version (0100h for DESQview 2.5x)
	BX = segment of window handle or 0000h for default
	ES:DI -> buffer for window information (see #0450)
Return: AX = status
	    0000h successful
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
SeeAlso: AX=1000h,AX=1016h,AX=DE01h,AX=DE2Bh

Format of DESQview window information:
Offset	Size	Description	(Table 0450)
 00h	BYTE	task flag: 00h window, 01h task
 01h	BYTE	process number if owner task
		00h if non-owner task
 02h	WORD	segment of owner's handle, 0000h if orphaned
 04h	WORD	mapping context (see #0318 at AX=1016h)
 06h	BYTE	task status (see #0451)
 07h	BYTE	unused
 08h	WORD	status bits (see #0452)
 0Ah	BYTE	01h if foreground-only window

(Table 0451)
Values for DESQview task status:
 00h	"Waiting" waiting for input
 01h	"Idle" keyboard poll limit reached
 03h	same as 01h
 04h	"Pausing" INT 15/AX=1000h pause called
 04h	DV/X direct: user did something to allow task switch
 05h	"ModeChg" video mode about to be changed
 06h	"ModeNtf" notify that video mode changed
 07h	"MoniCh" requested change to other monitor
 08h	"StartPgm" control relinquished to start new process
 09h	"MgrCan" made window manager CANCEL command
 0Ah	"Slicing" time slice expired
 0Bh	"Exit DOS" notify on DOS calls
 0Ch	"Enter DOS" process is re-entering DOS
 0Dh	"Terminate" INT 21/AH=4Ch or task freed
 0Eh	"BrkNxt" Control-Break pressed
 0Fh	"MgrCol" keyboard focus taken away
 10h	"PgmInt" interrupted by API call from another task
 11h	"BldOpen" call to INT 15/AX=DE01h

Bitfields for DESQview task status bits:
Bit(s)	Description	(Table 0452)
 6	task is freeing another task
 5	process is being created
 4	user suspended process
 3	process suspended itself
 2	process is resized direct window (suspended)
 1	process swapped out
 0	DESQview process
--------Q-15DE2D-----------------------------
INT 15 U - DESQview v2.50+ - GET/SET SOCKET HANDLER
	AX = DE2Dh
	CX = direction
	    FFFFh set socket handler
		DX:BX -> FAR function for socket interface
			must be of the format described under INT 63"DESQview"
			  at #2689
	    other get socket handler
		Return: DX:BX -> socket handler (see #2689)
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	the "set" subfunction is normally called only by SOCKET.DVR
SeeAlso: AX=DE2Eh,INT 63"DESQview",#2689
--------Q-15DE2E-----------------------------
INT 15 U - DESQview v2.50+ - SOCKET API
	AX = DE2Eh
	DX:BX -> socket record (see #0454)
		0000h:0000h to create a new socket record
Return: CX = size of socket record in bytes
	DX:BX -> socket record which was used
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	socket records are allocated from common memory
	for Unix compatibility, each socket and connection on a socket is
	  allocated a DOS file handle (referencing an SFT for NUL) which is
	  used on various calls to specify which of possibly multiple
	  connections is to be operated upon
SeeAlso: AX=DE2Dh,INT 61/AX=0001h/SF=0001h"VINES",INT 63"DESQview"

(Table 0453)
Values for DESQview/X socket API function number:
 0000h	initialize socket???
 0001h	"gethostname"
 0002h	"ioctl" check for input
 0003h	"sleep" delay for specified period
 0004h	"htons" convert word to network (big-endian) byte order
 0005h	"select"
 0006h	"bsd_close"/"so_close" close socket
 0007h	NOP
 0008h	"connect" initiate connection on socket
 0009h	"recv"/"recvfrom" read from socket
 000Ah	"socket"
 000Bh	???
 000Ch	"gethostbyname"
 000Dh	"send"/"sendto" write to socket
 000Eh	??? (does something to all connections for process)
 000Fh	"getpid" get process identifier
 0010h	"gettimeofday"
 0011h	"bind" assign name to socket
 0012h	"listen" listen for connections on socket
 0013h	"accept" accept connection on socket
 0014h	connect to X server
 0015h	"gethostbyaddr" get host information for an address
 0016h	"getprotobyname"
 0017h	"getprotobynumber"
 0018h	"getservbyname"
 0019h	"getservbyport"
 001Ah	"getsockname" determine name bound to socket
 001Bh	"getpeername" get name of connected peer
 001Ch	"getsockopt"/"setsockopt"
 001Dh	"so_exit"	 close all sockets for calling process
 001Eh	"issock" determine whether file handle references socket
 001Fh	"so_attach" reattach previously detached socket
 0020h	"so_detach" temporarily detach socket
 0021h	"dvpath" get DESQview directory (see also AX=DE24h)
 0022h	"NewProc" start new application (see also AX=102Ch)
 0023h	"so_linkup"
 0024h	"CanonicalPath" canonicalize filename (see also INT 21/AH=60h)
 0025h	indirect INT 15h call
 0026h	Network Manager interface
 0027h	"so_unlink"    close connection from "so_linkup"
 0028h	"raisepriority"
 0029h	"lowerpriority"
 002Ah	"so_private" ???
 FFFFh	"NetExit" (appears to be a NOP)

Format of DESQview/X socket record:
Offset	Size	Description	(Table 0454)
 00h	WORD	signature F0ADh
 02h	WORD	function number (see #0453)
 04h	WORD	returned error code (see #0474)
 06h	WORD	maximum message size??? (usually 0400h)
 08h	WORD	PSP segment to use or 0000h if socket not valid
 0Ah	WORD	scratch space (JFT size)
 0Ch	DWORD	scratch space (JFT address)
 10h	DWORD	mailbox handle (initialized by function 0000h)
 14h	DWORD	timer object handle (initialized by function 0000h)
---function 0000h---
 18h	WORD	(ret) ???
---function 0001h---
 18h	WORD	(ret) status???
 1Ah 128 BYTEs	(ret) ASCIZ hostname (empty string if not on network)
 9Ah	WORD	maximum length of hostname to return
---function 0002h---
 18h	WORD	(ret) status
 1Ah	WORD	socket's file handle
 1Ch	WORD	IOCTL function
		05h "FIONREAD" determine available input
		06h "FIONBIO" set blocking state of socket
 1Eh	WORD	(return, subfn 05h) number of bytes available for reading
		(call, subfn 06h) 0000h blocking, nonzero nonblocking
---function 0003h---
 18h  2 BYTEs	unused
 1Ah	WORD	delay time in seconds
---function 0004h---
 18h	WORD	(ret) result in network (big-endian) byte order
 1Ah	WORD	value to convert to network byte order
---function 0005h---
 18h	WORD	(ret) number of handles meeting the specified conditions???
 1Ah	WORD	number of file handles in each bitset
 1Ch	DWORD	bitset of socket handles to check for readability
 20h	DWORD	bitset of socket handles to check for writability
 24h	DWORD	bitset of socket handles to check for errors
 28h	WORD	timeout in ??? or 0000h to block until some socket ready
 2Ah	DWORD	???
 2Eh	DWORD	???
---function 0006h---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
---function 0008h---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	0001h if socket name specified, 0000h if not
 1Eh	WORD	length of socket name
 20h  N BYTEs	name of socket to which to connect
---function 0009h---
 18h	WORD	(ret) number of bytes actually read, 0000h if connection
			closed, or FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	number of bytes to read
 1Eh	WORD	flags
 20h	WORD	0000h if no source address desired
		0001h if source address is to be stored (datagram sockets)
 22h	WORD	length of source address
 24h 110 BYTEs	source address
 92h 1K BYTEs	buffer for data to be read
---function 000Ah---
 18h	WORD	(ret) socket's file handle or FFFFh on error
 1Ah	WORD	address family (0001h,0002h)
 1Ch	WORD	socket type
 1Eh	WORD	protocol
---function 000Bh---
 18h	WORD	(ret) 0001h if ??? or FFFFh on error
 1Ah	WORD	socket's file handle
 1Eh	WORD	(call) ???
---function 000Ch---
 18h 128 BYTEs	ASCIZ hostname (special case if empty string or "unix")
 98h	???	(ret) packed 'hostent' structure
 A2h	???	(ret) ???
---function 000Dh---
 18h	WORD	(ret) number of bytes actually written or FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	number of bytes to write
 1Eh	WORD	number of bytes to follow in subsequent writes???
 20h	WORD	flags
 22h	WORD	0000h if no destination specified, 0001h if destination present
 24h	WORD	0001h if broadcast message???, 0000h if not
		(ignored if no destination specified)
 26h	WORD	length of destination address
 28h 110 BYTEs	destination address
 96h 1K BYTEs	buffer containing data to be written
---function 000Eh---
 no additional fields
---function 000Fh---
 18h	DWORD	(ret) DESQview task handle of calling process
---function 0010h---
 18h	DWORD	(ret) current time
 1Ch	DWORD	(ret) ???
---function 0011h---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	length of name
 1Eh  N BYTEs	buffer for socket name
---function 0012h---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	maximum backlog of pending connections allowed on socket
---function 0013h---
 18h	WORD	(ret) file handle for new connection or FFFFh on error
 1Ah	WORD	listen()ing socket's file handle
 1Ch	WORD	(call) length of buffer for connecting entity's address
		(ret) actual length of address
 1Eh  N BYTEs	buffer for connecting entity's address (110 bytes???)
---function 0014h---
 18h	WORD	(ret) socket's file handle or FFFFh on error
 1Ah  4 BYTEs	(ret) ???
 1Eh	WORD	(ret) ???
 20h	WORD	(ret) ???
 22h 256 BYTEs	ASCIZ X display name
122h	???
---function 0015h---
 18h	WORD	(call) type of address??? (test for 0001h seen)
 1Ah	WORD	(call) length of buffer for host address
 1Ch 110 BYTEs	buffer containing ASCIZ host address
 8Ah	WORD	(ret) offset of official host name
 8Ch	WORD	(ret) offset of alias list???
 8Eh	WORD	(ret) address type???
 90h	WORD	(ret) length of an address in bytes???
 92h	WORD	(ret) offset of address???
 9Ah  N BYTEs	(ret) buffer for hostname, alias list, and host address
---function 0016h---
 18h	???	buffer for ASCIZ protocol name
 98h	???
---function 0017h---
 18h	WORD	(call) protocol number
 1Ah	WORD	(ret) ??? or 0001h
---function 0018h---
 18h 128 BYTEs	buffer containing ASCIZ ???
 98h 128 BYTEs	buffer containing ASCIZ ???
118h	WORD	(ret) ???
---function 0019h---
 18h	WORD	port number
 1Ah 128 BYTEs	(call) ASCIZ host name
		(ret) packed servent strctures???
 9Ah	WORD	(ret) ???
---function 001Ah---
 18h	WORD	(ret) 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	(call) length of buffer for socket name
		(ret) actual length of socket name
 1Eh  N BYTEs	buffer for socket name
---function 001Bh---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	(call) size of buffer for name
		(ret) actual size of name
 1Eh  N BYTEs	buffer for peer's name
---function 001Ch---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	direction: 0000h to get, 0001h to set
 1Ch	WORD	socket's file handle
 1Eh	WORD	option level
 20h	WORD	option name
 22h	WORD	(call) length of buffer for option value
		(ret) actual length of option value
 24h  N BYTEs	buffer for option value
---function 001Dh---
 no additional fields
---function 001Eh---
 18h	WORD	(ret) status: 0000h ??? or 0001h ???
 1Ah	WORD	file handle which may or may not be a socket
---function 001Fh---
 18h	WORD	(ret) file handle or FFFFh on error
 1Ah	DWORD	(call) pointer to Socket Context Record (see #0475) of a
			previously detached socket
---function 0020h---
 18h	WORD	(ret) status: 0000h if successful or FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	DWORD	(ret) pointer to Socket Context Record (see #0475) for
			the file handle
---function 0021h---
 18h 64 BYTEs	buffer for DESQview startup directory (see AX=DE25h)
---function 0022h---
 18h	DWORD	(ret) task handle of new application
 1Ch	WORD	size of .DVP data
 1Eh 129 BYTEs	ASCIZ ???
 9Fh  N BYTEs	.DVP data (see #0329 at AX=102Ch)
---function 0023h---
 18h	WORD	(ret) ??? or FFFFh on error
 1Ah	WORD	socket's file handle???
---function 0024h---
 18h	WORD	(ret) DOS error code (see #0980 at INT 21/AH=59h)
			0000h if successful
 1Ah 129 BYTEs	ASCIZ filename/pathname
11Bh 129 BYTEs	ASCIZ canonicalized filename/pathname (see INT 21/AH=60h)
---function 0025h---
 18h	WORD	value of AX
 1Ah	WORD	value of BX
 1Ch	WORD	(call) value of CX for call if AH value other than 12h
		(call) number of stack parameters if AH value is 12h
		(ret) returned CX for calls other than INT 15/AH=12h
 1Eh	WORD	value of DX
 20h	WORD	value of DI
 22h	WORD	value of SI
 24h	WORD	value of DS
 26h	WORD	value of ES
 28h	WORD	(ret) value of FLAGS after call
 2Ah  N DWORDs	(call) stack parameters for INT 15/AH=12h call
		(ret) stack results from INT 15/AH=12h call
---function 0026h---
 18h	WORD	(call) Network Manager subfunction (see #0455)
		(ret) status??? (0000h on error)
 1Ah	WORD	(call) size of parameter data
		(ret) size of returned data
 1Ch  N BYTEs	(call) parameter data required by call (see #0456,#0457,#0473)
		(ret) result data (see #0466,#0467,#0472)
---function 0027h---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
---functions 0028h,0029h---
 18h	WORD	(call) file handle for which to set priority low/high
			FFFFh to change calling task's priority
---function 002Ah---
 no additional fields

(Table 0455)
Values for DESQview/X Network Manager subfunction:
 0004h	"so_exit"???
 0005h	"gethostbyname"
 0006h	"gethostname"
 0009h	"socket"
 000Dh	"gethostbyaddr"
 000Fh	"getprotobyname"
 0010h	get protocol name for protocol number
 0011h	"getservbyname"
 0012h	"getservbyport" (see #0459)
 0013h	"getsockname"??? (see #0460)
 0016h	"shutdown" (see #0461)
 0017h	kill Network Manager
 0018h	"getpeername"??? (see #0462)
 0019h	??? (called by socket function 0000h) (see #0463)
 001Ah	??? (see #0464)
 001Bh	"so_linkup" (see #0465)
 001Dh	"getnetstatus" get network services (see #0466)
 001Fh	"getpwuid"
 0020h	"getpwnam"
 0021h	"getpwvar"
 0022h	"crypt"
 0023h	"so_unlink"
 0024h	"getlogin" (see #0467)
 0028h	"sethostent"
 0029h	"gethostent"
 002Ah	"soaddhost"
 002Bh	"soupdatehost"
 002Ch	"sodeletehost"
 002Dh	"setservent"
 002Eh	"getservent"
 002Fh	"setpwent"
 0030h	"getpwent" (see #0468)
 0031h	"sethostpath" (see #0469)
 0032h	"endservent"
 0033h	"endhostent"
 0034h	"getnettype" get IP network number (see #0470)
 0035h	??? (pops up Network Manager window)
 0037h	"getnettimeout" (see #0471)
 0038h	get machine name and IP address (see #0472)
 0039h	"getuid" (see #0473)
---DV/X v2.0+ ---
 0041h	"deletepwnam"
 0045h	"renamepw"

Format of Function 0026h/Subfunction 000Fh data:
Offset	Size	Description	(Table 0456)
 00h  8 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 0010h data:
Offset	Size	Description	(Table 0457)
 00h  2 BYTEs	(ret) ???
 02h	WORD	(ret) protocol number
 04h	WORD	(call) protocol number for which to get name
 06h	WORD	(ret) ???
 08h	var	(ret) ASCIZ protocol name
 N	var	(ret) ASCIZ protocol name

Format of Function 0026h/Subfunction 0011h data:
Offset	Size	Description	(Table 0458)
 00h  8 BYTEs	???
 08h	var	(ret) ASCIZ protocol name
	var	(ret) ASCIZ ??? name
	var	(ret) ASCIZ ??? name

Format of Function 0026h/Subfunction 0012h data:
Offset	Size	Description	(Table 0459)
 00h  8 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 0013h data:
Offset	Size	Description	(Table 0460)
 00h 116 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 0016h ("shutdown") data:
Offset	Size	Description	(Table 0461)
 00h	WORD	(ret) shutdown status (0000h successful, FFFFh error)
 02h  4 BYTEs	(ret) ???
 04h	WORD	(call) socket handle
 06*h	WORD	(call) what (0 = receives, 1 = sends, 2 = both)

Format of Function 0026h/Subfunction 0018h data:
Offset	Size	Description	(Table 0462)
 00h 116 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 0019h data:
Offset	Size	Description	(Table 0463)
 00h  4 BYTEs	(ret) ???
 04h	DWORD	(ret) task handle of ???

Format of Function 0026h/Subfunction 001Ah data:
Offset	Size	Description	(Table 0464)
 00h 38 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 001Bh data:
Offset	Size	Description	(Table 0465)
 00h 10 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 001Dh return data [array]:
Offset	Size	Description	(Table 0466)
 00h	WORD	??? or FFFFh if end of array
 02h  7 BYTEs	???
 09h 27 BYTEs	ASCIZ name of service

Format of Function 0026h/Subfunction 0024h return data:
Offset	Size	Description	(Table 0467)
 00h	var	ASCIZ username

Format of Function 0026h/Subfunction 0030h data:
Offset	Size	Description	(Table 0468)
 00h	WORD	(call) UID or 0000h for current user
		(ret) ???
 02h	WORD	(ret) UID
 04h  6 BYTEs	(ret) ???
 0Ah	var	(ret) ASCIZ username
	var	(ret) ASCIZ encrypted password
	var	(ret) ASCIZ initial ("home") directory

Format of Function 0026h/Subfunction 0031h ("sethostpath") data:
Offset	Size	Description	(Table 0469)
 00h   4 BYTEs	???
 04h 144 BYTEs	ASCIZ ???

Format of Function 0026h/Subfunction 0034h data:
Offset	Size	Description	(Table 0470)
 00h  1-3 BYTEs IP network number of caller's machine (low byte first)

Format of Function 0026h/Subfunction 0037h ("getnettimeout") return data:
Offset	Size	Description	(Table 0471)
 00h	WORD	(ret) timeout
 02h  2 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 0038h return data:
Offset	Size	Description	(Table 0472)
 00h	BYTE	???
 01h  4 BYTEs	IP address
 05h	var	ASCIZ machine name
	???

Format of Function 0026h/Subfunction 0039h ("getuid") return data:
Offset	Size	Description	(Table 0473)
 00h	WORD	user ID
 02h  2 BYTEs	???
SeeAlso: #0469,#0472

(Table 0474)
Values for DESQview/X socket error code:
 0000h	successful
 0009h	"BADF" bad file handle
 000Ch	"ENOMEM" out of memory
 000Eh	"EFAULT" bad address
 0016h	"EINVAL" invalid argument
 0018h	"EMFILE" too many open files
 0020h	"EPIPE" ??? broken pipe
 0023h	"EWOULDBLOCK" operation cannot be completed at this time
 0024h	"EINPROGRESS" operation now in progress
 0026h	"ENOTSOCK" socket invalid
 0028h	"EMSGSIZE" message too long to send atomically
 002Ch	"ESOCKTNOSUPPORT" socket type not supported
 002Fh	"EAFNOSUPPORT" address family not supp. by protocol fam.
 0031h	"EDOM" argument too large
 0038h	"EISCONN" socket is already connected
 0039h	"ENOTCONN" socket is not connected

Format of DESQview/X Socket Context Record:
Offset	Size	Description	(Table 0475)
 00h	DWORD	pointer to next Socket Context Record, 0000h:0000h if last
 04h	WORD	SFT index for socket, 00FFh if not connected, FFFFh if detached
 06h	WORD	PSP segment of owner or 0000h
 08h	WORD	mapping context of owning window (see #0318 at AX=1016h)
 0Ah  2 BYTEs	???
 0Ch	WORD	address family
 0Eh	WORD	socket type
 10h	WORD	protocol
 12h	WORD	socket state
		0001h created
		0002h bound
		0003h listening???
		0005h connected
 14h	DWORD	timer object handle
 18h	DWORD	object handle (mailbox???)
 1Ch	DWORD	object handle of parent of above object or 0000h:0000h
 20h	DWORD	pointer to ??? or 0000h
 24h  6 BYTEs	???
 2Ah	WORD	file handle for socket or FFFFh
 2Ch  2 BYTEs	???
 2Eh	WORD	nonzero if socket nonblocking
---network connections only---
 30h  2 BYTEs	???
 32h	WORD	???
 34h  4 BYTEs	(big-endian) IP address of remote
 38h  6 BYTEs	???
--------Q-15DE2F-----------------------------
INT 15 - DESQview v2.50+ - "VIDEONOTIFY" - HAS DIRECT WINDOW BEEN ACTIVE?
	AX = DE2Fh
Return: BX = status
	    0001h keyboard focus has been given to a direct window since the
		last call
	    0000h if not
Notes:	DESQview 2.50-2.53 are distributed as part of DESQview/X v1.00-1.10.
	Quarterdeck stated that this call would not be available under future
	  versions of DESQview Classic, but it is still present in v2.60
--------Q-15DE30-----------------------------
INT 15 - DESQview v2.50+ - "GETDVXVERSION" - GET DESQview/X VERSION
	AX = DE30h
Return: BX = version (BH=major, BL=minor) or 0000h if not DESQview/X
Notes:	DESQview 2.50-2.53 are distributed as part of DESQview/X v1.00-1.10.
	you must first check the DESQview version to verify that it is 2.50 or
	  greater
SeeAlso: INT 21/AH=2Bh/CX=4445h
--------Q-15DE31-----------------------------
INT 15 - DESQview/X v1.10 - ???
	AX = DE31h
	CX = ???
	    0000h ???
	    nonzero ???
	???
Return: ???
--------b-15DF-------------------------------
INT 15 - Juko UNIQUE UX BIOS - TURBO MODE CONTROL
	AH = DFh
	AL = function
	    00h turn on Turbo mode
	    01h turn off Turbo mode
	    02h set Turbo mode according to hardware switch
SeeAlso: INT 13/AX=FFFFh
--------b-15E00F-----------------------------
INT 15 - Compaq Systempro - MULTIPROCESSOR DISPATCH
	AX = E00Fh
	ES:BX -> start of 2nd processor's execution
Return: AL = status
	    0Fh successful
	    00h failure
SeeAlso: AX=E10Eh,AX=E200h
--------b-15E10E-----------------------------
INT 15 - Compaq Systempro - MULTIPROCESSOR END-OF-DISPATCH
	AX = E10Eh
	ES:BX -> start of 2nd processor's execution
Return: AL = status
	    0Fh successful (halted)
	    00h failure (not halted)
SeeAlso: AX=E00Fh,AX=E200h
--------b-15E200-----------------------------
INT 15 - Compaq Systempro - MULTIPROCESSOR AVAILABLE
	AX = E200h
Return: AX bit 15 set if 2nd processor available
SeeAlso: AX=E00Fh,AX=E10Eh
--------b-15E4-------------------------------
INT 15 - Tandy??? - ???
	AH = E4h
	AL = subfunction
	    21h, 89h, 8Ah, 8Bh called by 386MAX v6.01
	DL = ???
Return: DL = 00h if successful???
Note:	the section of code in 386MAX which calls these functions also checks
	  whether the ROM BIOS has both Tandy and Phoenix Technologies
	  signatures if these calls fail; the Tandy 1000SL/TL BIOS does not
	  support this function, however, returning the usual CF set/AH=86h for
	  "unsupported function".
--------b-15E4-------------------------------
INT 15 - Compaq ROM BIOS 03/08/93 and newer - ???
	AH = E4h
	AL = subfunction
	    00h get ???
		Return: CF clear
			AH = 00h
			CX = 0000h
			BX = ??? (read from [XBDA:0094h])
	    01h,02h unsupported by this ROM version
		Return: CF set, AH = 86h
	    80h,90h,A0h,B0h,C0h,D0h,E0h,F0h set ???
		Return: CF clear
			AH = 00h
			CX = 0000h
			BX = ???
	    81h,91h,A1h,B1h,C1h,D1h,E1h,F1h unsupported by 3/8/93&4/8/93 ROMs
		Return: CF set, AH = 86h
Notes:	functions 80h/90h/etc. are not supported by the 4/8/93 EISA System ROM
	these functions are not supported by the 7/26/93 LTE Lite 386 ROM
--------b-15E800-----------------------------
INT 15 - Compaq Contura - GET ???
	AX = E800h
Return: AX = 0000h
	BH = 00h
	BL = ??? (read from port 0C7Ch)
	CH = ???
	CL = ???
	DX = 0000h
Note:	also supported by 3/8/93 DESKPRO/i and 7/26/93 LTE Lite 386 ROM BIOS
--------b-15E800-----------------------------
INT 15 - Compaq Contura Aero, Contura 400 - GET SYSTEM MODEL CODE???
	AX = E800h
	BX = ??? (0000h)
Return: CF clear if successful
	    BH = 02h
	    BL = submodel??? (0Ch,0Dh,34h,38h,40h,44h,48h,64h,68h)
	CF set on error
	others???
Notes:	used by Compaq's SOFTPAQ number 0937 EPPBIOS.SYS to determine whether
	  the Enhanced Parallel Port expected by that driver is available
	used by Compaq's SOFTPAW number 0856 VOLCTRL.EXE to determine whether
	  volume control hardware expected by that driver is available
--------b-15E800-----------------------------
INT 15 - Compaq Prolinea - GET ???
	AX = E800h
	BX = ??? (1369h)
Return: BH = 01h
	BL = ???
	others???
Note:	used by Compaq's SOFTPAQ number 0718 INT10_04.SYS to determine whether
	  the fix that driver applies is required (will not install if BX on
	  return is other than 010Eh or 010Fh)
SeeAlso: AX=E802h
--------b-15E801-----------------------------
INT 15 - Phoenix BIOS v4.0 - GET MEMORY SIZE FOR >64M CONFIGURATIONS
	AX = E801h
Return: CF clear if successful
	    AX = extended memory between 1M and 16M, in K (max 3C00h = 15MB)
	    BX = extended memory above 16M, in 64K blocks
	    CX = configured memory 1M to 16M, in K
	    DX = configured memory above 16M, in 64K blocks
	CF set on error
Notes:	supported by the A03 level (6/14/94) and later XPS P90 BIOSes, as well
	  as the Compaq Contura, 3/8/93 DESKPRO/i, and 7/26/93 LTE Lite 386 ROM
	  BIOS
	supported by AMI BIOSes dated 8/23/94 or later
SeeAlso: AH=8Ah"Phoenix",AX=E802h,AX=E820h"Phoenix",AX=E881h"Phoenix"
--------b-15E802-----------------------------
INT 15 - Compaq Contura - GET ???
	AX = E802h
Return: CF clear
	AX = 0000h
	BX = ???
	CX = 0000h
Note:	this function is also supported by the LTE Lite 25c, 25E, and 486; not
	  supported by LTE Lite 20 and 25.
SeeAlso: AX=E801h"Phoenix"
--------b-15E820-----------------------------
INT 15 - Phoenix BIOS v4.0 - GET SYSTEM MEMORY MAP
	AX = E820h
	EDX = 534D4150h ('SMAP')
	EBX = continuation value or 00000000h to start at beginning of map
	ECX = number of bytes to copy ( >= 20 bytes)
	ES:DI -> buffer for result (see #0476)
Return: CF clear if successful
	    EAX = 534D4150h ('SMAP')
	    ES:DI buffer filled
	    EBX = next offset from which to copy or 00000000h if all done
	    ECX = actual length returned in bytes
	CF set on error
	    AH = error code (86h) (see #0396 at INT 15/AH=80h)
Notes:	supported by the A03 level (6/14/94) and later XPS P90 BIOSes
	supported by AMI BIOSes dated 8/23/94 or later
	a maximum of 20 bytes will be transferred at one time, even if ECX is
	  higher
	if this function is not supported, an application should fall back
	  to AX=E802h, AX=E801h, and then AH=88h
	this function will return base memory and ISA/PCI memory contiguous
	  with base memory as normal memory ranges; it will indicate
	  chipset-defined address holes which are not in use and motherboard
	  memory-mapped devices, and all occurrences of the system BIOS as
	  reserved; standard PC address ranges will not be reported
SeeAlso: AX=E801h"Phoenix",AX=E881h

Format of Phoenix BIOS system memory map address range descriptor:
Offset	Size	Description	(Table 0476)
 00h	QWORD	base address
 08h	QWORD	length in bytes
 10h	DWORD	type of address range
		01h memory, available to OS
		02h reserved, not available (e.g. system ROM, memory-mapped
		  device)
		other: not defined
--------b-15E881-----------------------------
INT 15 - Phoenix BIOS v4.0 - GET MEMORY SIZE FOR >64M CONFIGURATIONS (32-bit)
	AX = E881h
Return: CF clear if successful
	    EAX = extended memory between 1M and 16M, in K (max 3C00h = 15MB)
	    EBX = extended memory above 16M, in 64K blocks
	    ECX = configured memory 1M to 16M, in K
	    EDX = configured memory above 16M, in 64K blocks
	CF set on error
Note:	supported by AMI BIOSes dated 8/23/94 or later
SeeAlso: AX=E801h"Phoenix",AX=E820h"Phoenix"
--------m-15F200CX454D-----------------------
INT 15 - Tandon memory mapper - Tandon MAPPER HARDWARE INITIALISATION CHECK ???
	AX = F200h
	CX = 454Dh
Return: CF clear if hardware already initialised
	    BX = upper RAM areas in use
		bit 0: C000-C3FF
		bit 1: C400-C7FF
		...
		bit 11: EC00-EFFF
	CF set if hardware not initialised yet
--------B-1600-------------------------------
INT 16 - KEYBOARD - GET KEYSTROKE
	AH = 00h
Return: AH = BIOS scan code
	AL = ASCII character
Notes:	on extended keyboards, this function discards any extended keystrokes,
	  returning only when a non-extended keystroke is available
	the BIOS scan code is usually, but not always, the same as the hardware
	  scan code processed by INT 09.  It is the same for ASCII keystrokes
	  and most unshifted special keys (F-keys, arrow keys, etc.), but
	  differs for shifted special keys
	some (older) clone BIOSes do not discard extended keystrokes and manage
	  function AH=00h and AH=10h the same
	the K3PLUS v6.00+ INT 16 BIOS replacement doesn't discard extended
	  keystrokes (same as with functions 10h and 20h), but will always
	  translate prefix E0h to 00h. This allows old programs to use extended
	  keystrokes and should not cause compatibility problems
SeeAlso: AH=01h,AH=05h,AH=10h,AH=20h,AX=AF4Dh"K3PLUS",INT 18/AH=00h
--------B-1601-------------------------------
INT 16 - KEYBOARD - CHECK FOR KEYSTROKE
	AH = 01h
Return: ZF set if no keystroke available
	ZF clear if keystroke available
	    AH = BIOS scan code
	    AL = ASCII character
Note:	if a keystroke is present, it is not removed from the keyboard buffer;
	  however, any extended keystrokes which are not compatible with 83/84-
	  key keyboards are removed by IBM and most fully-compatible BIOSes in
	  the process of checking whether a non-extended keystroke is available
	some (older) clone BIOSes do not discard extended keystrokes and manage
	  function AH=00h and AH=10h the same
	the K3PLUS v6.00+ INT 16 BIOS replacement doesn't discard extended
	  keystrokes (same as with functions 10h and 20h), but will always
	  translate prefix E0h to 00h. This allows old programs to use extended
	  keystrokes and should not cause compatibility problems
SeeAlso: AH=00h,AH=11h,AH=21h,INT 18/AH=01h
--------B-1602-------------------------------
INT 16 - KEYBOARD - GET SHIFT FLAGS
	AH = 02h
Return: AL = shift flags (see #0477)
	AH destroyed by many BIOSes
SeeAlso: AH=12h,AH=22h,INT 17/AH=0Dh,INT 18/AH=02h

Bitfields for keyboard shift flags:
Bit(s)	Description	(Table 0477)
 7	Insert active
 6	CapsLock active
 5	NumLock active
 4	ScrollLock active
 3	Alt key pressed (either Alt on 101/102-key keyboards)
 2	Ctrl key pressed (either Ctrl on 101/102-key keyboards)
 1	left shift key pressed
 0	right shift key pressed
SeeAlso: #0482,#2914
--------B-1603-------------------------------
INT 16 - KEYBOARD - SET TYPEMATIC RATE AND DELAY
	AH = 03h
	AL = subfunction
	    00h set default delay and rate (PCjr and some PS/2)
	    01h increase delay before repeat (PCjr)
	    02h decrease repeat rate by factor of 2 (PCjr)
	    03h increase delay and decrease repeat rate (PCjr)
	    04h turn off typematic repeat (PCjr and some PS/2)
	    05h set repeat rate and delay (AT,PS)
		BH = delay value (00h = 250ms to 03h = 1000ms)
		BL = repeat rate (00h=30/sec to 0Ch=10/sec [def] to 1Fh=2/sec)
	    06h get current typematic rate and delay (newer PS/2s)
		Return: BL = repeat rate (see above)
			BH = delay (see above)
Return:	AH destroyed by many BIOSes
Note:	use INT 16/AH=09h to determine whether some of the subfunctions are
	  supported
SeeAlso: INT 16/AH=09h,AH=29h"HUNTER",AH=2Ah"HUNTER"
--------b-1604-------------------------------
INT 16 - Tandy 2000 - KEYBOARD - FLUSH KEYBOARD BUFFER
	AH = 04h
Note:	this interrupt is identical to INT 51 on the Tandy 2000
SeeAlso: INT 16/AH=00h,INT 16/AH=02h,INT 16/AH=05h"Tandy 2000"
SeeAlso: INT 51"Tandy 2000"
--------B-1604-------------------------------
INT 16 - KEYBOARD - SET KEYCLICK (PCjr only)
	AH = 04h
	AL = keyclick state
	    00h off
	    01h on
Return:	AH destroyed by many BIOSes
SeeAlso: AH=03h,AH=04h"K3PLUS"
--------K-1604-------------------------------
INT 16 - K3PLUS v6.22+ - SET KEYCLICK
	AH = 04h
	AL = keyclick state
	    00h keyclick off, leave loudness setting unchanged
	    01h keyclick on, leave loudness setting unchanged
	    else
	       bit 0: keyclick enabled if set
	       bits 7-1: new keyclick loudness (non-zero)
Return:	AH destroyed by many BIOSes
Note:	Applications which try to set a new loudness, but are unsure of the
	  results of other INT 16/AH=04h implementations, should set the new
	  loudness first, and then call this function again with AL=01h or
	  AL=00h
SeeAlso: AH=03h,AH=04h"KEYBOARD",AX=AF4Dh
--------B-1605-------------------------------
INT 16 - KEYBOARD - STORE KEYSTROKE IN KEYBOARD BUFFER (AT/PS w enh keybd only)
	AH = 05h
	CH = BIOS scan code
	CL = ASCII character
Return: AL = status
	    00h if successful
	    01h if keyboard buffer full
	AH destroyed by many BIOSes
Notes:	under DESQview, a number of "keystrokes" invoke specific
	  DESQview-related actions when they are read from the keyboard
	  buffer (see #0478)
	similarly, some "keystrokes" invoke special functions on the HP 100LX
	  and HP 200LX (see #0479)
SeeAlso: AH=00h,AH=25h"K3",AH=71h,AX=AF4Dh,AH=FFh,INT 15/AX=DE10h

(Table 0478)
Values for pseudo-keystrokes for DESQview:
 38FBh or FB00h	switch to next window (only if main menu already popped up)
 38FCh or FC00h	pop up DESQview main menu
 38FEh or FE00h	close the current window
 38FFh or FF00h	pop up DESQview learn menu

(Table 0479)
Values for pseudo-keystrokes for HP 100LX/200LX:
 EE00h	pop up topcard display and set other system manager applications
	  into sleep mode
--------B-1605-------------------------------
INT 16 - KEYBOARD - SELECT KEYBOARD LAYOUT (PCjr only)
	AH = 05h
	AL = function
	    01h set keyboard layout to French
	    02h set keyboard layout to German
	    03h set keyboard layout to Italian
	    04h set keyboard layout to Spanish
	    05h set keyboard layout to UK
	    80h check if function supported
		Return: AL <> 80h if supported
Return: ???
	AH destroyed by many BIOSes
Note:	this function is called by the DOS 3.2 KEYBxx.COM
SeeAlso: AH=92h,AH=A2h,AX=AF4Dh
--------b-1605-------------------------------
INT 16 - Tandy 2000 - KEYBOARD - RESET KEYBOARD
	AH = 05h
Desc:	reset the keyboard and flush the keyboard buffer
Note:	this interrupt is identical to INT 51 on the Tandy 2000
SeeAlso: INT 16/AH=00h,INT 16/AH=02h,INT 16/AH=03h,INT 51"Tandy 2000"
--------B-1609-------------------------------
INT 16 - KEYBOARD - GET KEYBOARD FUNCTIONALITY
	AH = 09h
Return: AL = supported keyboard functions (see #0480)
	AH destroyed by many BIOSes
Notes:	this function is only available if bit 6 of the second feature byte
	  returned by INT 15/AH=C0h is set (see #0407)
	reportedly, the Award Modular BIOS v4.50G returns the keyboard function
	  flags in AH instead of AL, and provides this function even though
	  its availability is not indicated by INT 15/AH=C0h
SeeAlso: AH=03h,AH=0Ah,AH=10h,AH=11h,AH=12h,AH=20h,AH=21h,AH=22h,INT 15/AH=C0h

Bitfields for supported keyboard functions:
Bit(s)	Description	(Table 0480)
 7	reserved
 6	INT 16/AH=20h-22h supported (122-key keyboard support)
 5	INT 16/AH=10h-12h supported (enhanced keyboard support)
 4	INT 16/AH=0Ah supported
 3	INT 16/AX=0306h supported
 2	INT 16/AX=0305h supported
 1	INT 16/AX=0304h supported
 0	INT 16/AX=0300h supported
SeeAlso: #0409
--------B-160A-------------------------------
INT 16 - KEYBOARD - GET KEYBOARD ID
	AH = 0Ah
Return: BX = keyboard ID (see #0481)
	AH destroyed by many BIOSes
Notes:	check return value from AH=09h to determine whether this function is
	  supported
	this function is also supported by the K3PLUS v6.00+ INT 16 BIOS
	  replacement
SeeAlso: AH=09h,AX=AF4Dh

(Table 0481)
Values for keyboard ID:
 0000h	no keyboard attached
 41ABh	Japanese "G" keyboard (translate mode)
	MF2 Keyboard (usually in translate mode)
 54ABh	Japanese "P" keyboard (translate mode)
 83ABh	Japanese "G" keyboard (pass-through mode)
	MF2 Keyboard (pass-through mode)
 84ABh	Japanese "P" keyboard (pass-through mode)
 90ABh	old Japanese "G" keyboard
 91ABh	old Japanese "P" keyboard
 92ABh	old Japanese "A" keyboard
--------B-1610-------------------------------
INT 16 - KEYBOARD - GET ENHANCED KEYSTROKE (enhanced kbd support only)
	AH = 10h
Return: AH = BIOS scan code
	AL = ASCII character
Notes:	if no keystroke is available, this function waits until one is placed
	  in the keyboard buffer
	the BIOS scan code is usually, but not always, the same as the hardware
	  scan code processed by INT 09.  It is the same for ASCII keystrokes
	  and most unshifted special keys (F-keys, arrow keys, etc.), but
	  differs for shifted special keys.
	unlike AH=00h, this function does not discard extended keystrokes
	INT 16/AH=09h can be used to determine whether this function is
	  supported, but only on later model PS/2s
SeeAlso: AH=00h,AH=09h,AH=11h,AH=20h
--------B-1611-------------------------------
INT 16 - KEYBOARD - CHECK FOR ENHANCED KEYSTROKE (enh kbd support only)
	AH = 11h
Return: ZF set if no keystroke available
	ZF clear if keystroke available
	    AH = BIOS scan code
	    AL = ASCII character
Notes:	if a keystroke is available, it is not removed from the keyboard buffer
	unlike AH=01h, this function does not discard extended keystrokes
	some versions of the IBM BIOS Technical Reference erroneously report
	  that CF is returned instead of ZF
	INT 16/AH=09h can be used to determine whether this function is
	  supported, but only on later model PS/2s
SeeAlso: AH=01h,AH=09h,AH=10h,AH=21h
--------B-1612-------------------------------
INT 16 - KEYBOARD - GET EXTENDED SHIFT STATES (enh kbd support only)
	AH = 12h
Return: AL = shift flags 1 (same as returned by AH=02h) (see #0482)
	AH = shift flags 2 (see #0483)
Notes:	AL bit 3 set only for left Alt key on many machines
	AH bits 7 through 4 always clear on a Compaq SLT/286
	INT 16/AH=09h can be used to determine whether this function is
	  supported, but only on later model PS/2s
	many BIOSes (including at least some versions of Phoenix and AMI) will
	  destroy AH on return from functions higher than AH=12h, returning
	  12h less than was in AH on entry (due to a chain of DEC/JZ
	  instructions)
SeeAlso: AH=02h,AH=09h,AH=22h,AH=51h,INT 17/AH=0Dh

Bitfields for keyboard shift flags 1:
Bit(s)	Description	(Table 0482)
 7	Insert active
 6	CapsLock active
 5	NumLock active
 4	ScrollLock active
 3	Alt key pressed (either Alt on 101/102-key keyboards)
 2	Ctrl key pressed (either Ctrl on 101/102-key keyboards)
 1	left shift key pressed
 0	right shift key pressed
SeeAlso: #0477,#0483

Bitfields for keyboard shift flags 2:
Bit(s)	Description	(Table 0483)
 7	SysReq key pressed (SysReq is often labeled SysRq)
 6	CapsLock pressed
 5	NumLock pressed
 4	ScrollLock pressed
 3	right Alt key pressed
 2	right Ctrl key pressed
 1	left Alt key pressed
 0	left Ctrl key pressed
SeeAlso: #0482
--------J-1613-------------------------------
INT 16 - DOS/V - DOUBLE-BYTE CHARACTER SET SHIFT CONTROL
	AH = 13h
	AL = function
	    00h set shift status
		DX = shift status (see #0484), must preserve internal status
			  bits
	    01h get shift status
		Return: DX = current shift status (see #0484)
Note:	these functions are supplied by the Japanese Front-End Processor
SeeAlso: AH=14h,INT 21/AX=6301h

Bitfields for DOS/V shift status:
Bit(s)	Description	(Table 0484)
 0	full-size rather than half-size
 2-1	character input mode
	00 alphanumeric, 01 Katakana, 10 Hiragana, 11 unused
 5-3	internal status
 6	Romaji enabled
 7	Katakana to Kanji conversion enabled
 15-8	internal status
--------J-1614-------------------------------
INT 16 - DOS/V - SHIFT STATUS DISPLAY CONTROL
	AH = 14h
	AL = function
	    00h enable display
	    01h disable display
	    02h get display state
		Return: AL = current state (00h enabled, 01h disabled)
Desc:	control the screen-bottom shift status row(s) for the Japanese
	  Front-End Processor
SeeAlso: AH=13h,INT 10/AH=19h,INT 10/AH=1Dh
--------B-1620-------------------------------
INT 16 - KEYBOARD - GET 122-KEY KEYSTROKE (122-key kbd support only)
	AH = 20h
Return: AH = BIOS scan code (see AH=10h for details)
	AL = ASCII character
Note:	use AH=09h to determine whether this function is supported
SeeAlso: AH=00h,AH=09h,AH=10h,AH=21h,AH=22h
--------b-1620------------------------------------
INT 16 - HUNTER 16 - SET TEMPORARY SHIFT
	AH = 20h
	AL = shift status (see #0485)
Notes:	the Husky Hunter 16 is an 8088-based ruggedized laptop.	 Other family
	  members are the Husky Hunter, Husky Hunter 16/80, and Husky Hawk.
	the user can override the specified settings by pressing the keys

Bitfields for HUNTER 16 shift status:
Bit(s)	Description	(Table 0485)
 4	Scroll Lock on
 5	Num Lock on
 6	Caps Lock on
--------K-1620-------------------------------
INT 16 O - K3 v1.5x, K3PLUS v5.xx - GET EXTENDED BUFFER STATE
	AH = 20h
Return: AX = K3 version
	ES:BX -> extended keyboard buffer start
	ES:DX -> extended keyboard buffer end
	ES:SI -> next keystroke
	ES:DI -> last keystroke in buffer
	CX = number of keystrokes in buffer
Program: K3PLUS is an extended keyboard driver by Matthias Paul and Axel C.
	  Frinke, originally based on the K3 extended German keyboard driver
	  by Martin Gerdes published in c't magazine in 1988
Note:	this function was normally unsupported under K3PLUS v6.00-v6.22 and
	  is no longer supported by v6.30+; use AX=AF20h instead
SeeAlso: AH=25h"K3",AX=AF20h,INT 2F/AX=D44Fh/BX=0000h,INT 2F/AX=ED58h
--------B-1621-------------------------------
INT 16 - KEYBOARD - CHECK FOR 122-KEY KEYSTROKE (122-key kbd support only)
	AH = 21h
Return: ZF set if no keystroke available
	ZF clear if keystroke available
	    AH = BIOS scan code
	    AL = ASCII character
Notes:	use AH=09h to determine whether this function is supported
	some versions of the IBM BIOS Technical Reference erroneously report
	  that CF is returned instead of ZF
	K3PLUS v6.00+ supports this function as an alias of AH=11h
SeeAlso: AH=01h,AH=09h,AH=11h,AH=20h,AH=21h
--------b-1621------------------------------------
INT 16 - HUNTER 16 - CONTROL SHIFT KEYS
	AH = 21h
	AL = shift keys to control (see #0477)
	BL = shift state for disabled keys
Note:	If a bit in AL is set the key is disabled and set to the state of the
	  corresponding bit in BL
SeeAlso: AH=20h"HUNTER",AH=22h"HUNTER"
--------B-1622-------------------------------
INT 16 - KEYBOARD - GET 122-KEY SHIFT STATUS (122-key kbd support only)
	AH = 22h
Return: AL = shift flags 1 (see #0482)
	AH = shift flags 2 (see #0483)
Notes:	use AH=09h to determine whether this function is supported
	K3PLUS v6.00+ supports this function as an alias of AH=12h
SeeAlso: AH=02h,AH=09h,AH=12h,AH=20h,AH=21h
--------b-1622------------------------------------
INT 16 - HUNTER 16 - CONTROL CTRL-ALT-DEL
	AH = 22h
	AL = new Ctrl-Alt-Del state (00h enabled, nonzero disabled)
	BX = 0708h
	CX = 0910h
	DX = 1112h
Return: AL = 00h if successful
SeeAlso: AH=21h"HUNTER",AH=23h"HUNTER",AH=2Ah
--------b-1623------------------------------------
INT 16 - HUNTER 16 - CONTROL EMERGENCY BREAKOUT
	AH = 23h
	AL = new state of breakout (00h enabled, nonzero disabled)
	BX = 0708h
	CX = 0910h
	DX = 1112h
Return: AL = 00h if successful
Desc:	Enables or disables the emergency breakout feature, where the
	  Hunter 16 at power on checks whether the X and P keys are pressed.
	  If so the machine will boot rather than continue the running program
SeeAlso: AH=22h"HUNTER"
--------b-1624------------------------------------
INT 16 - HUNTER 16 - REDEFINE KEY CODES
	AH = 24h
	AL = Matrix Code (see #0486)
	BL = new Key code
Return: AL = status (00h successful, nonzero failed)
SeeAlso: AH=2Bh,AH=2Ch

(Table 0486)
Values for HUNTER 16 Matrix Code:
 Code  Key		Code	Key		Code	Key
 00h   Esc key		1Eh	Space		3Bh	L
 01h   1		21h	0		3Ch	,
 02h   Q		22h	-		3Eh	Right shift
 03h   Tab		23h	'		42h	8
 04h   Num Lock		24h	Keypad 4	43h	7
 05h   \		25h	Enter		44h	U
 08h   LShift		26h	Keypad 7	45h	I
 09h   Ctrl		27h	.		46h	J
 0Ah   "Paw" key	28h	Keypad 1	47h	K
 0Bh   2		29h	Keypad 0	48h	M
 0Ch   W		2Ch	=		49h	N
 0Dh   A		2Dh	Backspace	4Ah	/
 0Eh   S		2Eh	Keypad 8	4Dh	6
 0Fh   Z		2Fh	Keypad 9	4Eh	5
 11h   Alt		30h	Keypad 5	4Fh	T
 16h   4		31h	Keypad 6	50h	Y
 17h   3		32h	Keypad 2	51h	G
 18h   E		33h	Keypad 3	52h	H
 19h   R		34h	Keypad .	53h	B
 1Ah   D		37h	9		54h	V
 1Bh   F		38h	O		55h	#
 1Ch   X		39h	P		58h	Pwr
 1Dh   C		3Ah	;		59h	Shift Pwr
--------b-1625------------------------------------
INT 16 - HUNTER 16 - RESET KEYBOARD
	AH = 25h
Return: AL = 00h
Desc:	restores the standard keyboard layout after any remapping
SeeAlso: AH=24h,AH=2Bh,AH=2Ch
--------K-1625-------------------------------
INT 16 O - K3 v1.5x, K3PLUS v5.xx - COPY INTO EXTENDED BUFFER
	AH = 25h
	CX = number of keystrokes to copy
	ES:SI -> buffer containing keystrokes
Return: CF clear if successful
	CF set on error (i.e. buffer full)
	    CX = number of keystrokes NOT transferred
	    ES:SI -> first keystroke not transferred
Note:	this function was normally unsupported under K3PLUS v6.00-v6.22 and
	  is no longer supported by v6.30+; use AX=AF25h instead
SeeAlso: AH=05h,AH=20h"K3",AX=AF25h,INT 2F/AX=D44Fh/BX=0001h
--------b-1626------------------------------------
INT 16 - HUNTER 16 - CONTROL KEYCLICK
	AH = 26h
	AL = new state of keyclicks (00h disabled, 01h enabled)
Return: AL = 00h
SeeAlso: AH=2Ah
--------b-1627------------------------------------
INT 16 - HUNTER 16 - CONTROL SCREEN DUMP AREA
	AH = 27h
	AL = what to dump
	    00h whole (virtual) window
	    01h LCD window only
Return: AL = 00h
Desc:	control whether printscren dumps the whole 80x25 screen or only the
	  part displayed in the LCD window
Note:	the Hunter 16 has a 240x64 LCD display which serves as a window into
	  a 640x200 virtual screen
--------b-1629------------------------------------
INT 16 - HUNTER 16 - GET KEY REPEAT
	AH = 29h
Return: BL = Typematic rate (characters per second) (see #0487)
	BH = delay (00h = 250ms, 01h = 500ms, 02h = 750ms, 03h = 1s)
SeeAlso: AH=03h,AH=2Ah

(Table 0487)
Values for HUNTER 16 Typematic rate:
 00h	30.0	 08h	15.0	 10h	7.5	 18h	3.7
 01h	26.7	 09h	13.3	 11h	6.7	 19h	3.3
 02h	24.0	 0Ah	12.0	 12h	6.0	 1Ah	3.0
 03h	21.8	 0Bh	10.9	 13h	5.5	 1Bh	2.7
 04h	20.0	 0Ch	10.0	 14h	5.0	 1Ch	2.5
 05h	18.5	 0Dh	 9.2	 15h	4.6	 1Dh	2.3
 06h	17.1	 0Eh	 8.6	 16h	4.3	 1Eh	2.1
 07h	16.0	 0Fh	 8.0	 17h	4.0	 1Fh	2.0
SeeAlso: AH=2Ah
--------b-162A------------------------------------
INT 16 - HUNTER 16 - CONTROL KEY REPEAT
	AH = 2Ah
	AL = new state of keyboard autorepeat (00h disabled, 01h enabled)
SeeAlso: AH=03h,AH=26h,AH=29h,AH=2Bh
--------b-162B------------------------------------
INT 16 - HUNTER 16 - REDEFINE KEY SCAN CODES
	AH = 2Bh
	AL = which key table to redefine
	    00h unshifted
	    01h shifted
	    02h Numlock
	BH = standard scan code of key (00h-80h)
	BL = new scan code
Desc:	redefine the generated scan code from BH to BL
SeeAlso: AH=24h,AH=2Ah,AH=2Ch
--------b-162C------------------------------------
INT 16 - HUNTER 16 - REDEFINE RAW KEY CODES
	AH = 2Ch
	AL = Matrix code of key (see AH=29h)
	BL = new key code
Return: AL = status (00h success, nonzero failed)
Desc:	redefine the key code generated by holding the PAW key down and
	  pressing the key in AL
SeeAlso: AH=24h,AH=2Bh
--------b-162D------------------------------------
INT 16 - HUNTER 16 - CONTROL BREAK KEYS
	AH = 2Dh
	AL = enabled break keys
	    bit 0 Ctrl-C
	    bit 1 Ctrl-Break
	BX = 0708h
	CX = 0910h
	DX = 1112h
Return: AL = status (00h success, FFh failed)
SeeAlso: AH=21h"HUNTER"
--------U-163577-----------------------------
INT 16 U - TextWare TWTSR - API
	AX = 3577h
	CX = function
	    00CBh ???
		Return: AX = 0000h
			BX = 0000h
			DX:CX -> ???
	    00CCh uninstall
		Return: AX = status
			    0000h successful
			    FFFDh unable to unload because vectors taken
	    00CDh ???
		Return: AX = 0000h
			BX = 0000h
			DX:CX -> ???
	    other
		Return: AX = 5345h ('SE')
Program: TWTSR is a TSR which allows the TextWare hypertext browser to be
	  popped up via hotkey
SeeAlso: AX=D724h
--------U-164252-----------------------------
INT 16 - TEXTCAP 2.0 - INSTALLATION CHECK
	AX = 4252h
Return: AX = 5242h if installed
Program: TEXTCAP 2.0 is a heavily modified (by Gisbert W. Selke) version of the
	  PC Magazine utility CAPTURE written by Tom Kihlken
SeeAlso: AX=4253h,AX=4254h
--------U-164253-----------------------------
INT 16 - TEXTCAP 2.0 - UNINSTALL
	AX = 4253h
Return: AX = segment of resident code
Notes:	the uninstall code does not check whether interrupt vectors have been
	  chained by other programs
	the caller must free the main memory block (using the returned segment)
SeeAlso: AX=4252h,AX=4254h
--------U-164254-----------------------------
INT 16 - TEXTCAP 2.0 - DUMP TEXT SCREEN TO FILE
	AX = 4254h
Return: AX = status
	    4254h if screen dump will be written as soon as disk becomes idle
	    5442h if screen dump written
SeeAlso: AX=4252h,AX=4253h
--------e-164500-----------------------------
INT 16 - Shamrock Software EMAIL - GET STATUS
	AX = 4500h
	DL = port number (01h = COM1)
	ES:BX -> 13-byte buffer for ASCIZ name
Return: AX = 4D00h if EMAIL installed on specified port
	    ES:BX -> "" if no connection
		  -> "*" if connection but caller has not identified name
		  -> name otherwise
	    CX = version (CH = major, CL = minor)
	    DL = privilege level of user (00h = guest)
	    DH = chosen language (00h German, 01h English)
SeeAlso: AX=4501h,AX=4502h
--------e-164501-----------------------------
INT 16 - Shamrock Software EMAIL - GET ELAPSED ONLINE TIME AND MAXIMUM TIME
	AX = 4501h
	DL = port number (01h = COM1)
Return: AX = 4D00h if EMAIL installed on specified port
	    BX = maximum connect time in clock ticks
	    CX = maximum connect time for guests (without name) in clock ticks
	    DX = elapsed connect time of current user in clock ticks
SeeAlso: AX=4500h
--------e-164502-----------------------------
INT 16 - Shamrock Software EMAIL - GET CURRENT COMMUNICATIONS PARAMETERS
	AX = 4502h
	DL = port number (01h = COM1)
Return: AX = 4D00h if EMAIL installed on specified port
	    BL = current value of serial port's Line Control Register
	    BH = flags (see #0488)
	    CX = selected country code (33 = France, 49 = Germany, etc)
	    DX = baudrate divisor (115200/DX = baudrate)
SeeAlso: AX=4500h

Bitfields for Shamrock Software EMAIL flags:
Bit(s)	Description	(Table 0488)
 0	ISO code
 1	pause
 2	linefeed
 3	ANSI sequences
--------e-164503-----------------------------
INT 16 - Shamrock Software EMAIL - SPECIFY COMMAND-WORD FOR USER FUNCTION
	AX = 4503h
	DL = port number (01h = COM1)
	DH = maximum execution time in clock ticks (00h = 5 seconds)
	ES:BX -> ASCIZ string with new user command-word
Return: AX = 4D00h if EMAIL installed on specified port
Notes:	a single user command (consisting of only uppercase letters and digits)
	  may be defined, and remains valid until it is overwritten or the
	  EMAIL program terminates; the user command must be activated by
	  calling AX=4504h at least once.
	an existing command word may be redefined with this function
SeeAlso: AX=4504h,AX=4505h
--------e-164504-----------------------------
INT 16 - Shamrock Software EMAIL - CHECK FOR USER FUNCTION COMMAND-WORD
	AX = 4504h
	DL = port number (01h = COM1)
	ES:BX -> 80-byte buffer for ASCIZ user input line
Return: AX = 4D00h if EMAIL installed on specified port
	    DL = flags
		bit 0: user function supported (always set)
		bit 1: user entered user-function command word
	    if DL bit 1 set,
		ES:BX buffer contains line entered by user which begins with
			the defined command word and has been converted to all
			caps
Note:	caller must process the returned commandline and invoke AX=4505h
	  within five seconds with the result of that processing
SeeAlso: AX=4503h,AX=4505h
--------e-164505-----------------------------
INT 16 - Shamrock Software EMAIL - SEND RESULT OF USER FUNCTION
	AX = 4505h
	DL = port number (01h = COM1)
	DH = error flag
	    bit 3: set on error
	ES:BX -> ASCIZ text to return to user, max 1024 bytes
Return: AH = 4Dh if EMAIL installed on specified port
	AL = status
	    00h successful
	    02h unable to perform function (timeout, prev call not complete)
	    other error
Notes:	if the error flag in DH is set, the string is not sent and an error
	  message is generated instead; if this function is not called within
	  five seconds of AX=4504h, EMAIL automatically generates an error
	  message
	the string is copied into an internal buffer, allowing this function's
	  caller to continue immediately
SeeAlso: AX=4503h,AX=4504h,INT 17/AX=2400h
--------e-164506-----------------------------
INT 16 - Shamrock Software EMAIL - MONITOR XMODEM DOWNLOAD
	AX = 4506h
	DL = port number (01h = COM1)
	ES:BX -> 13-byte buffer for ASCIZ filename
Return: AX = 4D00h if EMAIL installed on specified port
	    DH = Xmodem status
		00h no XGET command given
		01h XGET in progress
		02h XGET completed successfully
	    ES:BX buffer filled with last filename given to XGET command
		(without path)
Note:	DH=02h will only be returned once per XGET; subsequent calls will
	  return DH=00h
SeeAlso: AX=4500h,INT 17/AX=2408h
--------K-164D4F-----------------------------
INT 16 - M16_KBD.COM v5.6 - INSTALLATION CHECK
	AX = 4D4Fh
Return: AX = 6F6Dh if installed
	    ES = segment of resident code
Program: M16_KBD is a shareware Cyrillic keyboard driver by I.V. Morozov
SeeAlso: INT 10/AX=1130h/BX=4D4Fh
--------J-165000-----------------------------
INT 16 - KEYBOARD - AX PC - SET KEYBOARD COUNTRY CODE
	AX = 5000h
	BX = country code
	    0001h USA (English), 0051h Japan
Return: AL = status
	    00h successful
	    01h bad country code
	    02h other error
Notes:	the K3PLUS v6.00+ INT 16 BIOS replacement will switch between the
	  supported country specific layout (e.g. BX=0031h Germany, BX=001Fh
	  Netherlands, BX=0020h Belgium, BX=0022h Spain) (as with <Ctrl>+
	  <Alt>+<F2>) and K3PLUS' transparent mode (as with <Ctrl>+<Alt>+<F1>).
	In transparent mode (BX=0001h), K3PLUS chains to the underlying
	  driver (normally the BIOS driver with US-layout). K3PLUS beeps on
	  mode changes
SeeAlso: AX=5001h,AX=AF4Dh,INT 10/AX=5000h,INT 17/AX=5000h
--------J-165001-----------------------------
INT 16 - KEYBOARD - AX PC - GET KEYBOARD COUNTRY CODE
	AX = 5001h
Return: AL = status
	    00h successful
		BX = country code
	    02h error
Note:	also supported by K3PLUS v6.00+
SeeAlso: AX=5000h,INT 10/AX=5001h,INT 17/AX=5001h
--------J-1651-------------------------------
INT 16 - KEYBOARD - AX PC - READ SHIFT KEY STATUS
	AH = 51h
Return: AL = standard shift key states (see #0477,#0482)
	AH = Kana lock (00h off, 01h on)
Note:	also supported by K3PLUS v6.00+, but K3PLUS always returns AH=00h
SeeAlso: AH=02h,AH=12h,AH=22h
--------t-165453BX5242-----------------------
INT 16 - TSRBONES - INSTALLATION CHECK
	AX = 5453h ('TS')
	BX = 5242h ('RB')
	CX = 4F4Eh ('ON')
	DX = 4553h ('ES')
Return: AX = 4553h if installed
	BX = 4F4Eh if installed
	CX = 5242h if installed
	DX = 5453h if installed
Program: TSRBONES is a skeletal TSR framework by Robert Curtis Davis
Note:	these values are the default as the TSRBONES package is distributed,
	  but will normally be changed when implementing an actual TSR with
	  the TSRBONES skeleton
SeeAlso: INT 2D"AMIS"
--------A-165500-----------------------------
INT 16 C - Microsoft Word internal - MICROSOFT WORD COOPERATION WITH TSR
	AX = 5500h
Return: AX = 4D53h ('MS') if keyboard TSR present
Notes:	during startup, Microsoft Word tries to communicate with any TSRs
	  that are present through this call.
	if the return is not 4D53h, Word installs its own INT 09 and INT 16
	  handlers; otherwise it assumes that the TSR will handle the keyboard
SeeAlso: AX=55FFh,INT 1A/AX=3601h
--------A-1655FE-----------------------------
INT 16 CU - Microsoft QBASIC internal - MICROSOFT COOPERATION WITH TSR
	AX = 55FEh
	DX = function
	    0000h initialize
		ES:BX -> ??? function
		ES:CX -> ??? structure
	    FFFFh shutdown/reset
Return: AX = result
	    4D4Bh only the INT 1B handler will be installed.
	    other: handlers for INT 08, INT 09, INT 16, INT 1B, and INT 1C
		  are installed
Notes:	The pointer in ES:CX seems to point at a structure defining a callback
	  function when new keyboard keys are pressed. If a TSR returns
	  AX=4D4Bh, QBASIC will stop (with IRQ's and interrupts enabled).
	these calls are also made by MS-DOS 6.0's DOSSHELL at startup, exit,
	  and before/after shelling out
	since EDIT.COM and HELP.COM merely invoke QBASIC, those two programs
	  will also cause this interface to be invoked
	K3PLUS v6.07+ supports this function, but will never invoke the
	  callback function
SeeAlso: AX=5500h,AX=AF4Dh,INT 1A/AX=3601h
--------U-1655FF-----------------------------
INT 16 C - Microsoft Word - TSR COOPERATION???
	AX = 55FFh
	BX >= 0004h (version of Microsoft Word [BL = major] ???)
	CX = function
	    0000h set ??? flag
	    other clear ??? flag
Notes:	hooks intercepting this call are present in SWAPSH and SWAPDT v1.77j,
	  distributed with PC Tools v7, as well as the Trusted Access
	  SCRNBLNK.COM; this may be part of the standard TesSeRact library
	known to be called by the German edition of Microsoft Word 5.0
SeeAlso: AX=5500h,INT 2F/AX=5453h
--------c-165758BX4858-----------------------
INT 16 U - Netroom CACHECLK - INSTALLATION CHECK
	AX = 5758h
	BX = 4858h ('HX')
	DX = 4443h ('DC')
	CX <> 5758h
Return: BX = 6878h if installed
	CX = 6463h if installed
	    AX = code segment of TSR
	    CX = internal version??? (v3.00 returns 0100h)
Program: CACHECLK is a "cloaked" disk cache included with Netroom
Notes:	if CX=5758h on entry, CACHECLK returns with all registers unchanged
	the cache statistics are located early in the segment pointed at by
	  AX on return
SeeAlso: INT 2F/AX=5758h
--------m-165758BX5754-----------------------
INT 16 U - Netroom ??? - ???
	AX = 5758h
	BX = 5754h
	???
Return: ???
--------m-165758BX5755-----------------------
INT 16 U - Netroom ??? - ???
	AX = 5758h
	BX = 5755h
	DS:SI -> ???
Return: ???
--------m-165758BX5756-----------------------
INT 16 U - Netroom ??? - INSTALLATION CHECK
	AX = 5758h
	BX = 5756h
Return: BX <> 5756h if installed
--------m-165758BX5858-----------------------
INT 16 U - Netroom PRENET - GET OLD INTERRUPT VECTORS
	AX = 5758h
	BX = 5858h
Return: CF clear
	DX:BX -> saved copy of interrupt vector table
Note:	the installation check consists of calling this function and comparing
	  BX against 5858h on return; if it has changed, PRENET is installed
SeeAlso: AX=5758h/BX=5859h
Index:	installation check;Netroom PRENET
--------m-165758BX5859-----------------------
INT 16 U - Netroom POSTNET - GET OLD INTERRUPT VECTORS
	AX = 5758h
	BX = 5859h
Return: CF clear
	DX:BX -> saved copy of interrupt vector table
Note:	the installation check consists of calling this function and comparing
	  BX against 5859h on return; if it has changed, POSTNET is installed
SeeAlso: AX=5758h/BX=5858h
Index:	installation check;Netroom POSTNET
--------U-166969BX6968-----------------------
INT 16 - PC Tools v5.1+ BACKTALK - UNHOOK
	AX = 6969h
	BX = 6968h
Return: resident code unhooked, but not removed from memory
Index:	uninstall;BACKTALK
--------U-166969BX6969-----------------------
INT 16 - PC Tools v5.1+ BACKTALK - INSTALLATION CHECK
	AX = 6969h
	BX = 6969h
	DX = 0000h
Return: DX nonzero if installed
	    BX = CS of resident code
	    DX = PSP segment of resident code
	    DS:SI -> ASCIZ identification string "CPoint Talk"
--------i-166A6B-----------------------------
INT 16 U - FastJuice - DISABLE/UNLOAD???
	AX = 6A6Bh
Return: ???
Program: FastJuice is a resident battery-power monitor by SeaSide Software
SeeAlso: AX=7463h
Index:	uninstall;FastJuice
--------G-166C63-----------------------------
INT 16 U - TMED v1.6a - INSTALLATION CHECK
	AX = 6C63h ('lc')
Return: AX = 4C43h ('LC') if installed
Program: TMED is a freeware resident memory editor by Liang Chen
--------b-166F00-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_INQUIRE" - Extended BIOS INSTALLATION CHECK
	AX = 6F00h
	BX <> 4850h (usually set to 0000h for simplicity)
Return: BX = 4850h ("HP") if present
Notes:	called by recent MS Mouse drivers looking for an HP-HIL mouse
	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
SeeAlso: AX=6F01h,AX=6F04h,AX=6F07h,AX=6F09h,AX=6F0Dh,AX=6F11h,AX=6F12h
SeeAlso: INT 14/AX=6F00h,INT 17/AX=6F00h,INT 33/AX=6F00h
SeeAlso: INT 6F/AH=00h"HP Vectra"
--------b-166F01-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_DEF_ATTR" - GET DEFAULT TYPEMATIC VALUES
	AX = 6F01h
Return: AH = 00h (successful)
	CX = 0004h (size of returned buffer)
	ES:SI -> buffer for typematic info (see #0489)
Note:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
SeeAlso: AX=6F00h,AX=6F02h,AX=6F03h,AX=6F04h

Format of HP Vectra EX-BIOS typematic info:
Offset	Size	Description	(Table 0489)
 00h	BYTE	delay before repeat for all non-Cursor Control Pad keys
		(see #0490)
 01h	BYTE	typematic rate for all non-Cursor Control Pad keys (see #0491)
 02h	BYTE	delay before repeat for Cursor Control Pad keys	(see #0492)
 03h	BYTE	typematic rate for Cursor Control Pad keys (see #0491)

(Table 0490)
Values for HP Vectra EX-BIOS non-CCP delay time:
 00h	17 ms
 01h	150 ms
 02h	283 ms
 03h	417 ms
 04h	550 ms
 05h	683 ms
 06h	817 ms
 07h	950 ms
 08h	1083 ms
 09h	1217 ms
 0Ah	1350 ms
 0Bh	1483 ms
 0Ch	1617 ms
 0Dh	1750 ms
 0Eh	1883 ms
 0Fh	2017 ms
Note:	the above values assume that the key repeat rate has been set to 60 Hz;
	  double the times if set to 30 Hz
SeeAlso: #0489,#0491,#0492

(Table 0491)
Values for HP Vectra EX-BIOS typematic rate:
 00h	60 / sec
 01h	30 / sec
 02h	20
 03h	15
 04h	12
 05h	10
 06h	8.57
 07h	7.5
 08h	6.66
 09h	6 / sec
 0Ah	5.45
 0Bh	5
 0Ch	4.62
 0Dh	4.28
 0Eh	4 / sec
 0Fh	typematic disabled
Note:	the above values assume that the key repeat rate has been set to 60 Hz;
	  halve the rates if set to 30 Hz
SeeAlso: #0490,#0492

(Table 0492)
Values for HP Vectra EX-BIOS CCP delay time:
 00h	17 ms
 01h	83 ms
 02h	150 ms
 03h	217 ms
 04h	283 ms
 05h	350 ms
 06h	417 ms
 07h	483 ms
 08h	550 ms
 09h	617 ms
 0Ah	683 ms
 0Bh	750 ms
 0Ch	817 ms
 0Dh	883 ms
 0Eh	950 ms
 0Fh	1017 ms
Note:	the above values assume that the key repeat rate has been set to 60 Hz;
	  double the times if set to 30 Hz
SeeAlso: #0490,#0491
--------b-166F02-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_GET_ATTR" - GET CURRENT TYPEMATIC VALUES
	AX = 6F02h
Return: AH = 00h (successful)
	CX = 0004h (size of returned buffer)
	ES:SI -> buffer for typematic info (see #0489)
Note:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
SeeAlso: AX=6F00h,AX=6F02h,AX=6F03h,AX=6F04h
SeeAlso: AX=6F00h,AX=6F01h,AX=6F03h
--------b-166F03-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_SET_ATTR" - SET TYPEMATIC VALUES
	AX = 6F03h
	ES:SI -> buffer containing typematic info (see #0489)
Return: AH = 00h (successful)
Note:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
SeeAlso: AX=6F00h,AX=6F02h,AX=6F03h,AX=6F04h
SeeAlso: AX=6F00h,AX=6F01h,AX=6F02h
--------b-166F04-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_DEF_MAPPING" - GET DEFAULT KEY MAPPINGS
	AX = 6F04h
	ES:SI -> mapping buffer (see #0493)
Return: AH = 00h (successful)
	CX = 001Eh (number of bytes in buffer)
	ES:SI buffer filled
Notes:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
	the HIL input system translates the HIL keyboard events to simulate
	  an IBM-compatible keyboard; the translation can be altered
	  dynamically by applications
SeeAlso: AX=6F00h,AX=6F05h,AX=6F06h

Format of HP Vectra EX-BIOS keyboard mapping info:
Offset	Size	Description	(Table 0493)
 00h  3 WORDs	entry for V_QWERTY driver (IP, CS, DS)
 06h  3 WORDs	entry for V_SOFTKEY driver (IP, CS, DS)
 0Ch  3 WORDs	entry for V_FUNCTION driver
 12h  3 WORDs	entry for V_NUMPAD driver
 18h  3 WORDs	entry for V_CCP driver
--------b-166F05-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_GET_MAPPING" - GET CURRENT KEY MAPPINGS
	AX = 6F05h
	ES:SI -> mapping buffer (see #0493)
Return: AH = 00h (successful)
	CX = 001Eh (number of bytes in buffer)
	ES:SI buffer filled
Note:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
SeeAlso: AX=6F04h,AX=6F06h
--------b-166F06-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_SET_MAPPING" - SET KEY MAPPINGS
	AX = 6F06h
	CX = number of bytes in buffer (001Eh)
	ES:SI -> mapping buffer (see #0493)
Return: AH = 00h (successful)
Notes:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
	any application which modifies the key mappings should restore them
	  before terminating
	drivers installed with this function are assured of 32 bytes of stack
	  space when they are invoked
SeeAlso: AX=6F04h,AX=6F05h,AX=6F07h
--------b-166F07-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_SET_XLATORS" - SET CCP AND SOFTKEY PADS
	AX = 6F07h
	BL = translation to set (see #0494)
Return: AH = 00h (successful)
Notes:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
	this function may no longer work properly if the application has
	  modified the key mappings with AX=6F06h
SeeAlso: AX=6F06h,AX=6F09h

(Table 0494)
Values for HP Vectra keyboard translation specifier:
 00h	map V_CCP to V_CCPCUR, forcing the cursor pad to return cursor keys
 01h	map V_CCP to V_CCPNUM, forcing the cursor pad to always return numbers
 02h	map V_CCP to V_OFF, disabling the cursor pad
 03h	map V_CCP to V_CCPGID, converting cursor pad keys to GID data
 04h	map V_CCP to V_RAW, passing cursor pad data untranslated to INT 09
 05h	map V_SOFTKEY to V_SKEY2KFEY, translating into standard function keys
 06h	map V_SOFTKEY to V_RAW, passing Softkey scancodes direct to INT 09
 07h	map V_SOFTKEY to V_OFF, disabling HP Softkeys
SeeAlso: #0495

(Table 0495)
Values for HP Vectra scancodes and BIOS keycodes for V_RAW translator:
	      INT 09		 INT 16 keycode
    Key	     scan code	Default	 Shifted   Ctrl	     Alt
 * (NumPd)	37h	2Ah	 (Prt Sc)  00/72h    00/37H
 Sysreq		54h	  --	 --	   --	     --
 CCP-Up		60h	00/D9h	 00/BFh	   00/A5h    00/8BH
 CCP-Left	61h	00/DAh	 00/C0h	   00/A6h    00/8CH
 CCP-Down	62h	00/DBh	 00/C1h	   00/A7h    00/8DH
 CCP-Right	63h	00/DCh	 00/C2h	   00/A8h    00/8EH
 CCP-Home	64h	00/DDh	 00/C3h	   00/A9h    00/8FH
 CCP-PgUp	65h	00/DEh	 00/C4h	   00/AAh    00/90H
 CCP-End	66h	00/DFh	 00/C5h	   00/ABh    00/91H
 CCP-PgDn	67h	00/E0h	 00/C6h	   00/ACh    00/92H
 CCP-Ins	68h	00/E1h	 00/C7h	   00/ADh    00/93H
 CCP-Del	69h	00/E2h	 00/C8h	   00/AEh    00/94H
 CCP-CNTR	6Ah	00/E3h	 00/C9h	   00/AFh    00/95H
 f1		70h	00/E9h	 00/CFh	   00/B5h    00/9BH
 f2		71h	00/EAh	 00/D0h	   00/B6h    00/9CH
 f3		72h	00/EBh	 00/D1h	   00/B7h    00/9DH
 f4		73h	00/ECh	 00/D2h	   00/B8h    00/9EH
 f5		74h	00/EDh	 00/D3h	   00/B9h    00/9FH
 f6		75h	00/EEh	 00/D4h	   00/BAh    00/A0H
 f7		76h	00/EFh	 00/D5h	   00/BBh    00/A1H
 f8		77h	00/F0h	 00/D6h	   00/BCh    00/A2H
Note:	only HP-specific codes are listed in this table; see INT 09 for a full
	  list of standard scan codes
SeeAlso: #0005,#0494
--------b-166F08-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_KBD" - GET KEYBOARD INFORMATION
	AX = 6F08h
Return: AH = status
	   00h successful
	   02h unsupported (non-HIL, i.e. standard, keyboard)
	BH = HP-HIL address (HP Vectra AT only???)
	BL = HP-HIL ID (HP Vectra AT only???)
	BL = keyboard language (ES/QS/RS only???) (see #0496)
Notes:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
	the driver's address in the HP_VECTOR_TABLE (see INT 6F/AH=00h) may
	  be computed as (BH-1)*6 + N, where N is the address of the first
	  HP-HIL device driver (see INT 6F/AH=0Ah"SF_INQUIRE_FIRST")
SeeAlso: AX=6F05h,AX=6F09h,INT 6F/AH=0Ah"SF_INQUIRE_FIRST"

(Table 0496)
Values for HP HIL keyboard language code:
 00h	reserved
 01h	Arabic-French
 02h	Kanji
 03h	Swiss-French
 04h	Portugese
 05h	Arabic
 06h	Hebrew
 07h	Canadian-English
 08h	Turkish
 09h	Greek
 0Ah	Thai
 0Bh	Italian
 0Ch	Hangul (Korean)
 0Dh	Dutch
 0Eh	Swedish
 0Fh	German
 10h	Chinese (PRC)
 11h	Chinese (Taiwan)
 12h	Swiss (French ii)
 13h	Spanish
 14h	Swiss (German ii)
 15h	Belgian (Flemish)
 16h	Finish
 17h	United Kingdom
 18h	French-Canadian
 19h	French-German
 1Ah	Norwegian
 1Bh	French
 1Ch	Danish
 1Dh	Katakana
 1Eh	Latin American Spanish
 1Fh	United States-American
 20h-FEh reserved
 FFh	non-HP keyboard (IBM AT keyboard and IBM Enhanced keyboard)
--------b-166F09-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_KBD_RESET" - RESET KEYBOARD TO DEFAULTS
	AX = 6F09h
Return: AH = 00h (successful)
Desc:	reset all keyboard mappings to their default translators, and reset
	  typematic values to their defaults
Note:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
SeeAlso: AX=6F04h,AX=6F07h,AX=6F08h
--------b-166F0A-----------------------------
INT 16 - HP Vectra ES/QS/RS EX-BIOS - READ PROCESSOR SPEED
	AX = 6F0Ah
Return: AH = 00h (successful)
	BX = speed code
	    0Bh for low speed (see #0497)
	    12h for medium speed (see #0497)
	    0Ch for high speed (see #0497)
Note:	supported by ES, QS, and RS series of HP Vectras
SeeAlso: AX=6F00h

(Table 0497)
Values for HP Vetra CPU speed:
	Vectra		Low	    Medium	High
	ES		8 MHz	     -		 8 MHz
	ES/12		8 MHz	     -		12 MHz
	QS/16, RS/16	8 MHz	     -		16 MHz
	QS/16S		8 MHz	     -		16 MHz
	QS/20, RS/20	8 MHz	     -		20 MHz
	RS/20C		5 MHz	    10 MHz	20 MHz
	RS/25C		5 MHz	    12.5 MHz	25 MHz
--------b-166F0B-----------------------------
INT 16 - HP Vectra ES/QS/RS EX-BIOS - SET PROCESSOR SPEED TO LOW
	AX = 6F0Bh
Return: AH = 00h (successful)
Notes:	see AX=6F0Ah for speed definitions
	supported by ES, QS, and RS series of HP Vectras
SeeAlso: AX=6F00h,AX=6F0Ah
--------b-166F0C-----------------------------
INT 16 - HP Vectra ES/QS/RS EX-BIOS - SET PROCESSOR SPEED TO HIGH
	AX = 6F0Ch
Return: AH = 00h (successful)
Notes:	see AX=6F0Ah for speed definitions
	supported by ES, QS, and RS series of HP Vectras
SeeAlso: AX=6F00h,AX=6F0A
--------b-166F0D-----------------------------
INT 16 - HP Vectra ES/QS/RS EX-BIOS - GET HIL Extended BIOS INTERRUPT NUMBER
	AX = 6F0Dh
Return: AH = interrupt number (default 6Fh, 02h means 6Fh as well)
Notes:	supported by ES, QS, and RS series of HP Vectras
	called by MS Windows HPSYSTEM.DRV and HPEBIOS.386 to support the HP-HIL
	  input system
SeeAlso: AX=6F00h,AX=6F0Eh,INT 6F"HP Vectra"
--------b-166F0E-----------------------------
INT 16 - HP Vectra ES/QS/RS EX-BIOS - SET HIL Extended BIOS INTERRUPT NUMBER
	AX = 6F0Eh
	BL = new interrupt number (60h-6Fh,78h-7Fh)
Return: AH = status (00h = successful)
Desc:	allows the HIL Extended BIOS software to use a non-default interrupt
	  number in case of an interrupt conflict with another application
Notes:	supported by ES, QS, and RS series of HP Vectras
	called by MS Windows HPSYSTEM.DRV and HPEBIOS.386 to support the HP-HIL
	  input system
SeeAlso: AX=6F00h,AX=6F0Dh,INT 6F"HP"
--------b-166F0F-----------------------------
INT 16 - HP Vectras RS/20C and RS/25C - ENABLE MEMORY CACHING
	AX = 6F0Fh
Return: AH = status
	    00h successful
	    FEh cache subsystem is bad
SeeAlso: AX=6F00h,AX=6F10h,AX=6F11h
--------b-166F10-----------------------------
INT 16 - HP Vectras RS/20C and RS/25C - DISABLE MEMORY CACHING
	AX = 6F10h
Return: AH = 00h (successful)
SeeAlso: AX=6F00h,AX=6F0Fh,AX=6F11h
--------b-166F11-----------------------------
INT 16 - HP Vectras RS/20C and RS/25C - GET MEMORY CACHING STATE
	AX = 6F11h
Return: AH = 00h (successful)
	AL bit 0 = cache state
	    0 cache disabled
	    1 cache enabled
SeeAlso: AX=6F00h,AX=6F0Fh,AX=6F10h
--------b-166F12-----------------------------
INT 16 - HP Vectras RS/20C and RS/25C - SET PROCESSOR SPEED TO MEDIUM
	AX = 6F12h
Return: AH = 00h (successful)
Note:	see AX=6F0Ah for speed definitions
SeeAlso: AX=6F00h,AX=6F0Ah
--------K-1670-------------------------------
INT 16 - FAKEY.COM - INSTALLATION CHECK
	AH = 70h
Return: AX = 1954h if installed
Program: FAKEY is a keystroke faking utility by System Enhancement Associates
--------K-1671-------------------------------
INT 16 - FAKEY.COM - PUSH KEYSTROKES
	AH = 71h
	CX = number of keystrokes
	DS:SI -> array of words containing keystrokes to be returned by AH=00h
Program: FAKEY is a keystroke faking utility by System Enhancement Associates
SeeAlso: AH=05h,AH=72h
--------K-1672-------------------------------
INT 16 - FAKEY.COM - CLEAR FAKED KEYSTROKES
	AH = 72h
Program: FAKEY is a keystroke faking utility by System Enhancement Associates
SeeAlso: AH=71h
--------K-1673-------------------------------
INT 16 - FAKEY.COM - PLAY TONES
	AH = 73h
	CX = number of tones to play
	DS:SI -> array of tones (see #0498)
Program: FAKEY is a keystroke faking utility by System Enhancement Associates
SeeAlso: INT 15/AX=1019h

Format of FAKEY.COM tone array entries:
Offset	Size	Description	(Table 0498)
 00h	WORD	divisor for timer channel 2
 02h	WORD	duration in clock ticks
--------i-167463-----------------------------
INT 16 U - FastJuice - INSTALLATION CHECK
	AX = 7463h ("tc")
Return: AX = 5443h ("TC") if installed
Program: FastJuice is a resident battery-power monitor by SeaSide Software
SeeAlso: AX=6A6Bh
--------R-1675-------------------------------
INT 16 - pcANYWHERE III - SET TICK COUNT FOR SCANNING
	AH = 75h
	AL = number of ticks between checks for new screen changes
--------R-1676-------------------------------
INT 16 - pcANYWHERE III - SET ERROR CHECKING TYPE
	AH = 76h
	AL = error checking type
	    00h none
	    01h fast
	    02h slow
--------R-1677-------------------------------
INT 16 - pcANYWHERE III - LOG OFF
	AH = 77h
	AL = mode
	    00h wait for another call
	    01h leave in Memory Resident Mode
	    02h leave in Automatic Mode
	    FFh leave in current operating mode
--------U-167761-----------------------------
INT 16 - WATCH.COM v2.x-v3.0 - INSTALLATION CHECK
	AX = 7761h ('wa')
Return: AX = 5741h ('WA') if installed
Note:	WATCH.COM is part of the "TSR" package by Kim Kokkonen
SeeAlso: INT 21/AX=7761h
--------U-167788BX7789-----------------------
INT 16 - PC Magazine PUSHDIR.COM - INSTALLATION CHECK
	AX = 7788h
	BX = 7789h
	DS:SI -> signature "PUSHDIR VERSION 1.0"
Return: AX = 7789h if installed and signature correct
	BX = 7788h
	SI destroyed
--------R-1679-------------------------------
INT 16 - pcANYWHERE III - CHECK STATUS
	AH = 79h
Return: AX = status
	    FFFFh if resident and active
	    FFFEh if resident but not active
	    FFFDh if in Memory Resident mode
	    FFFCh if in Automatic mode
	    other value if not resident
SeeAlso: AX=7B00h,INT 21/AX=2B44h
--------R-167A-------------------------------
INT 16 - pcANYWHERE III - CANCEL SESSION
	AH = 7Ah
--------R-167B00-----------------------------
INT 16 - pcANYWHERE III - SUSPEND
	AX = 7B00h
SeeAlso: AH=79h,AX=7B01h
--------R-167B01-----------------------------
INT 16 - pcANYWHERE III - RESUME
	AX = 7B01h
SeeAlso: AH=79h,AX=7B00h
--------R-167C-------------------------------
INT 16 - pcANYWHERE III - GET PORT CONFIGURATION
	AH = 7Ch
Return: AH = port number
	AL = baud rate (see #0499)
SeeAlso: AX=7B00h,AH=7Eh

(Table 0499)
Values for pcANYWHERE III baud rate:
 00h	50 baud
 01h	75 baud
 02h	110 baud
 03h	134.5 baud
 04h	150 baud
 05h	300 baud
 06h	600 baud
 07h	1200 baud
 08h	1800 baud
 09h	2000 baud
 0Ah	2400 baud
 0Bh	4800 baud
 0Ch	7200 baud
 0Dh	9600 baud
 0Eh	19200 baud
SeeAlso: #0211
--------R-167D-------------------------------
INT 16 - pcANYWHERE III - GET/SET TERMINAL PARAMETERS
	AH = 7Dh
	AL = subfunction
	    00h set terminal parameters
	    01h get terminal parameters
	    02h get configuration header and terminal parameters
	DS:CX -> terminal parameter block
SeeAlso: AH=7Ch,AH=7Eh
--------R-167E-------------------------------
INT 16 - pcANYWHERE III - COMMUNICATIONS I/O THROUGH PORT
	AH = 7Eh
	AL = subfunction
	    01h port input status
		Return AX = 0 if no characer ready,
		       AX = 1 if character ready
	    02h port input character
		Return AL = received character
	    03h port output character in CX
	    11h hang up phone
SeeAlso: AH=7Ch
--------R-167F-------------------------------
INT 16 - pcANYWHERE III - SET KEYBOARD/SCREEN MODE
	AH = 7Fh
	AL = subfunction
	    00h enable remote keyboard only
	    01h enable host keyboard only
	    02h enable both keyboards
	    08h display top 24 lines
	    09h display bottom 24 lines
	    10h Hayes modem
	    11h other modem
	    12h direct connect
--------U-1680-------------------------------
INT 16 - MAKEY.COM - INSTALLATION CHECK
	AH = 80h
Return: AX = 1954h if installed
Program: MAKEY is a utility by System Enhancement Associates
--------K-1687-------------------------------
INT 16 - DK.COM v1.03 - INSTALLATION CHECK
	AH = 87h
Return: AX = 4A57h ('JW') if installed
Program: DK.COM is the resident part of a small keyboard macro utility
	  by Digital Mechanics.
--------U-168765BX4321-----------------------
INT 16 - AT.COM version 8/26/87 - API
	AX = 8765h
	BX = 4321h
	CX = ??? or FFFFh
	if CX = FFFFh
		DX = number of event to remove or FFFFh
Return: ES:BX -> event record array (see #0500)
Program: AT.COM is a resident scheduler by Bill Frolik

Format of AT.COM event record:
Offset	Size	Description	(Table 0500)
 00h	BYTE	in-use flag (00h free, 01h in use, FFh end of array)
 01h	BYTE	day of date on which to trigger
 02h	BYTE	month of date on which to trigger
 03h	BYTE	trigger time, minute
 04h	BYTE	trigger time, hour
 05h	WORD	offset of command to be executed
--------K-1692-------------------------------
INT 16 - KEYB.COM KEYBOARD CAPABILITIES CHECK (not an actual function!)
	AH = 92h
Return: AH <= 80h if enhanced keyboard functions (AH=10h-12h) supported
Desc:	this function is called by the DOS 3.2 KEYBxx.COM and DOS 5+ KEYB.COM
	  to determine the highest supported keyboard function
Note:	many BIOSes (including at least some versions of Phoenix and AMI) will
	  destroy AH on return from functions higher than AH=12h, returning
	  12h less than was in AH on entry (due to a chain of DEC/JZ
	  instructions)
SeeAlso: AH=05h"PCjr",AH=A2h,INT 2F/AX=AD80h
--------U-1699-------------------------------
INT 16 - SCOUT v5.4 - GET ???
	AH = 99h
Return: AX = ABCDh
	BX:CX -> ??? (appears to be start of PSP for resident portion)
Program: Scout is a memory-resident file manager by New-Ware
SeeAlso: AH=9Eh
--------U-169E-------------------------------
INT 16 - SCOUT v5.4 - INSTALLATION CHECK
	AH = 9Eh
Return: AX = ABCDh if installed
Program: Scout is a memory-resident file manager by New-Ware
SeeAlso: AH=99h
--------K-16A2-------------------------------
INT 16 - KEYB.COM KEYBOARD CAPABILITIES CHECK (not an actual function!)
	AH = A2h
Return: AH <= 80h if 122-key keyboard functions (AH=20h-22h) supported
Desc:	this function is called by the DOS 3.2 KEYBxx.COM and DOS 5+ KEYB.COM
	  to determine the highest supported keyboard function
Note:	many BIOSes (including at least some versions of Phoenix and AMI) will
	  destroy AH on return from functions higher than AH=12h, returning
	  12h less than was in AH on entry (due to a chain of DEC/JZ
	  instructions)
SeeAlso: AH=05h"PCjr",AH=92h,INT 2F/AX=AD80h
--------V-16AA-------------------------------
INT 16 - PTxxx.COM - (xxx=CGA,EGA,VGA,HER...) CALL GATE FOR GRAPHICS
	AH = AAh
	Various registers set up by high level language.
Return: Graphics performed
Note:	PT stands for Paint Tools which is a graphics library for Turbo Pascal,
	  Modula 2 and others from DataBiten in Sweden. The library is
	  installed as a memory resident driver.
--------U-16AABBBXEEFF-----------------------
INT 16 U - JORJ v4.3 - INSTALLATION CHECK
	AX = AABBh
	BX = EEFFh
Return: AX = EEFFh if installed
	BX = AABBh if installed
	    CL = hotkey name (default 6Ah 'j' for Alt-J)
Program: JORJ is a shareware dictionary with phonetic lookup by Jorj Software
	  Co.
Index:	hotkeys;JORJ
--------K-16AF20BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.0+) - GET EXTENDED BUFFER STATE
	AX = AF20h
	BX = 4B33h ('K3')
Return: AX = K3 version (same as returned in BX by AX=AF4Dh)
	ES:BX -> extended keyboard buffer start
	ES:DX -> extended keyboard buffer end
	ES:SI -> next keystroke
	ES:DI -> last keystroke in buffer
	CX = number of keystrokes in buffer
Program: K3PLUS is an extended keyboard driver by Matthias Paul and Axel C.
	  Frinke, originally based on the K3 extended German keyboard driver
	  by Martin Gerdes published in c't magazine in 1988
Note:	this function replaces the identical function AH=20h"K3"
SeeAlso: AH=20h"K3",AX=AF25h,AX=AF4Dh,AX=AF50h,INT 2F/AX=ED58h
--------K-16AF25BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.0+) - COPY INTO EXTENDED BUFFER
	AX = AF25h
	BX = 4B33h ('K3')
	CX = number of keystrokes to copy
	ES:SI -> buffer containing keystrokes
Return: CF clear if successful
	CF set on error (i.e. buffer full)
	    CX = number of keystrokes NOT transferred
	    ES:SI -> first keystroke not transferred
Note:	this function replaces the identical function AH=25h"K3"
SeeAlso: AH=25h"K3",AX=AF20h,AX=AF4Dh,AX=AF50h,INT 2F/AX=D44Fh/BX=0001h
--------K-16AF4DBX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.0+) - GET VERSION INFORMATION
	AX = AF4Dh
	BX = 4B33h ('K3')
Return: AL = 50h if installed
	    BX = K3 version
	    DX = API version
	    ES:CX -> K3 structure (version-dependent) (see #0501)
Program: K3PLUS is an extended keyboard driver by Matthias Paul and Axel C.
	  Frinke, originally based on the K3 extended German keyboard driver
	  by Martin Gerdes published in c't magazine in 1988
SeeAlso: AX=AF20h,AX=AF50h,AX=AF80h,AX=AF83h,INT 2F/AX=D44Fh/BX=0000h
SeeAlso: INT 2F/AX=ED58h
Index:	installation check;K3PLUS

Format of internal K3 structure:
Offset	Size	Description	(Table 0501)
 00h  3 BYTEs	signature "K3$"
 03h	BYTE	length of structure, including this byte and signature
 04h	WORD	compiler switch option flags A (see #0502)
 06h	WORD	compiler switch option flags B (see #0503)
 08h	BYTE	internal flags A (see #0504)
 09h	BYTE	internal flags B (see #0505)
 0Ah	WORD	DOS version recorded at startup
 0Ch	WORD	"ActTypeSpeed"
 0Eh	WORD	last Keyboard-ID sent
		41ABh translated, 83ABh native (pass-through)
 10h	WORD	offset of K3TAB Special
 12h	WORD	offset of K3TAB German
 14h	WORD	offset of K3TAB Alt
 16h	WORD	offset of K3TAB AltGr
 18h	WORD	offset of K3TAB Ctrl
 1Ah	WORD	offset of K3TAB NPad
 1Ch	WORD	offset of K3TAB CtrlNPad
 1Eh	WORD	offset of K3TAB AltNPad
 20h	WORD	offset of K3TAB ApoTbl or 0000h
 22h	WORD	offset of K3TAB UmlautTbl or 0000h
 24h	WORD	offset of K3TAB UmlautTblExp or 0000h
 26h	WORD	length of video mode table
 28h	WORD	offset of VidMdTbl or 0000h
 2Ah	BYTE	'$' end marker

Bitfields for K3PLUS compiler switch option flags A:
Bit(s)	Description	(Table 0502)
 15	GuINT16Fct2 (general use of INT 16 function 2)
 14	Int15df (INT 15 has to be predefined)
 13	GuAltNP (general use of Alt Numpad)
 12	SupAT (ATs+ supported)
 11	GuINT16Fct3 (general use of INT 16 function 3)
 10	GuINT16Ret (general use of INT16 bad function return)
 9-8	Layout (0-2, 3 reserved; 0=PC, 1=AT, 2=MF)
 7	ForceMF (force MF decode without read-ID)
 6	KXlate (translate keys for special keyboard)
 5	UmlautX (umlaut translation capability included)
 4	ApoX (translate apostrophe)
 3	DoINT16 (INT 16 handler included)
 2	UseCC (CopyCursor included)
 1-0	UseEB
	0=no extended keystroke buffer, 1=reserve mem, 2=use PSP, 3=reserved

Bitfields for K3 compiler switch option flags B:
Bit(s)	Description	(Table 0503)
 15-11	reserved (0)
 10	CtrlSeq (Ctrl macro capability included)
 9-8	SupINT16fct55FE
 6	DoInstallCheck (check for double installation)
 5	SupINT16fct5PcJr (INT 16/AH=05h"PCjr" supported)
 4	SendOut (sound and message output supported)
 3	SupInt16fct5500 (INT 16/AX=5500h supported)
 2	GuINT15Fct4F (calls to INT 15/AH=4Fh supported)
 1-0	UseBufferStart (0=use standard area, 1=set standard area,
	2=use internal indexes, 3=reserved)

Bitfields for K3 internal flags A:
Bit(s)	Description	(Table 0504)
 7	DoingUmlautExp
 6	CallINT15fct4F
 5	Beep1 (requires SendOut set in option flags B)
 4	ATflag (set for AT, 386, PS/2 Models 50-80)
 3	XTflag (set for PC, PC/XT, Micromint PC, Pencock PC, PS/2 Model 30)
 2	KeyClick
 1	UmlautExp
 0	UmlautTrans

Bitfields for K3 internal flags B:
Bit(s)	Description	(Table 0505)
 7-5	reserved
 4	TranslateE0 enabled
 3	Boot enabled
 2	PrintScreen enabled
 1	Break enabled
 0	ApoPendingBeep
--------K-16AF50BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.0+) - CHECK IF FUNCTION SUPPORTED
	AX = AF50h
	BX = 4B33h ('K3')
	CH = function
	    00h get function flags
		CL = 00h
		Return: CX = supported function flags (see #0506)
	    nonzero reserved for extensions
SeeAlso: AX=AF20h,AX=AF4Dh,AX=AF51h,AX=AF80h

Bitfields for K3PLUS supported function list:
Bit(s)	Description	(Table 0506)
 0	function 4Dh supported
 1	function 50h supported
 2-3	reserved (0)
 4	function 20h supported
 5	function 25h supported
 6	function 51h supported
 7	reserved (0)
 8	function 80h supported
 9	function 81h supported
 10	function 82h supported
 11-15	reserved (0)
--------K-16AF51BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.00+) - SET OPTIONS
	AX = AF51h
	BX = 4B33h ('K3')
	CX = switches
Return: AL = status
	    00h done
		CX = previous switch settings
	    01h switch not supported
	    FFh other error
SeeAlso: AX=AF4Dh,AX=AF50h,AX=AF80h
--------K-16AF80BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.00+) - GET ORIGINAL INT 09h VECTOR
	AX = AF80h
	BX = 4B33h ('K3')
Return: AL = status
	    00h not supported
	    81h if successful
		ES:CX -> original INT 09 handler
SeeAlso: AX=AF4Dh,AX=AF50h,AX=AF81h,AX=AF82h
--------K-16AF81BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.00+) - GET ORIGINAL INT 16h HANDLER
	AX = AF81h
	BX = 4B33h ('K3')
Return: AL = status
	    00h not supported
	    82h if successful
		ES:CX -> original INT 16 handler
SeeAlso: AX=AF4Dh,AX=AF50h,AX=AF80h,AX=AF82h
--------K-16AF82BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.00+) - GET ORIGINAL INT 10h HANDLER
	AX = AF82h
	BX = 4B33h ('K3')
Return: AL = status
	    00h not supported
	    83h if successful
		ES:CX -> original INT 10 handler
Program: K3PLUS is an extended keyboard driver by Matthias Paul and Axel C.
	  Frinke, originally based on the K3 extended German keyboard driver
	  by Martin Gerdes published in c't magazine in 1988
SeeAlso: AX=AF4Dh,AX=AF50h,AX=AF80h,AX=AF81h,INT 2F/AX=ED58h
--------m-16B0B1-----------------------------
INT 16 - VGARAM v1.00 - INSTALLATION CHECK
	AX = B0B1h
	ES:DI -> 6 byte signature "VGARAM"
Return: AX = B1B0h if installed,
	DS:BX -> VGARAM Status byte: 0 = OFF, 1 = ON
Program: VGARAM is a utility by Brett Warthen which makes VGA memory which is
	  not used in text modes available for DOS
--------K-16CA--BX736B-----------------------
INT 16 - CtrlAlt Associates STACKEY.COM v3.00 - API
	AH = CAh
	BX = 736Bh ("sk")
	CX = 736Bh
	AL = function
	    00h installation check
		Return: DX = words available in keyboard buffer
	    01h place keystroke in buffer
		DX = keystroke (DH = scan code, DL = ASCII character)
		Return: DX = words available in keyboard buffer
			    FFFFh on error
	    02h flush STACKEY and BIOS keyboard buffers
Return: AX = CAFFh if installed
	    BX = segment of resident code
	    CX = STACKEY version (CH = major, CL = minor)
Program: STACKEY is a shareware keyboard-input faking TSR
Index:	installation check;STACKEY
--------V-16CA00BX6570-----------------------
INT 16 - CtrlAlt Associates EGAPAL.COM v1.00 - INSTALLATION CHECK
	AX = CA00h
	BX = 6570h ("ep")
	CX = 6570h
Return: AX = CAFFh if installed
	    BX = segment of resident code
	    CX = ??? (0090h)
Program: EGAPAL is a TSR supplied with STACKEY which makes EGA palette settings
	  permanent across mode switches
SeeAlso: AX=CA00h/BX=7670h
--------V-16CA00BX7670-----------------------
INT 16 - CtrlAlt Associates VGAPAL.COM v1.00 - INSTALLATION CHECK
	AX = CA00h
	BX = 7670h ("vp")
	CX = 7670h
Return: AX = CAFFh if installed
	    BX = segment of resident code
	    CX = ??? (0090h)
Program: VGAPAL is a TSR supplied with STACKEY which makes VGA palette settings
	  permanent across mode switches
SeeAlso: AX=CA00h/BX=6570h
--------U-16CB00-----------------------------
INT 16 - PUPClip v1.12+ - INSTALLATION CHECK
	AX = CB00h
Return: BX = 4342h if installed
	    AX = version (AH = major version, AL = BCD minor version)
Program: PUPClip is the freeware PopUP Clipboard for DOS and Windows DOS
	 sessions by SkullC0DEr
SeeAlso: AX=CB01h,AX=CB02h,AX=CB03h,AX=CB04h,AX=CB05h,AX=CB06h,AX=CB08h
SeeAlso: INT 2F/AX=1701h
--------U-16CB01-----------------------------
INT 16 - PUPClip v1.12+ - GET CLIPBOARD CURSOR POSITION
	AX = CB01h
Return: BL = column (0-79)
	BH = row (0-49)
SeeAlso: AX=CB00h,AX=CB02h,AX=CB03h
--------U-16CB02-----------------------------
INT 16 - PUPClip v1.12+ - SET CLIPBOARD CURSOR POSITION
	AX = CB02h
	BL = column (0-79)
	BH = row (0-49)
Return: CF clear if successful
	CF set on error (invalid position)
SeeAlso: AX=CB00h,AX=CB01h,AX=CB04h
--------U-16CB03-----------------------------
INT 16 - PUPClip v1.12+ - GET CHARACTER FROM CURRENT CLIPBOARD CURSOR POSITION
	AX = CB03h
Return: BL = ASCII character at current position
SeeAlso: AX=CB00h,AX=CB02h,AX=CB04h,INT 2F/AX=1705h
--------U-16CB04-----------------------------
INT 16 - PUPClip v1.12+ - WRITE CHARACTER TO CURRENT CLIPBOARD CURSOR POSITION
	AX = CB04h
	BL = ASCII character to store
SeeAlso: AX=CB00h,AX=CB02h,AX=CB03h,AX=CB05h,INT 2F/AX=1703h
--------U-16CB05-----------------------------
INT 16 - PUPClip v1.12+ - CLEAR CLIPBOARD CONTENTS
	AX = CB05h
Return: nothing
SeeAlso: AX=CB00h,AX=CB04h,AX=CB06h,AX=CB07h,INT 2F/AX=1702h
--------U-16CB06-----------------------------
INT 16 - PUPClip v1.12+ - SCROLL UP CLIPBOARD CONTENTS
	AX = CB06h
Return: nothing
SeeAlso: AX=CB00h,AX=CB05h,AX=CB07h
--------U-16CB07-----------------------------
INT 16 - PUPClip v1.12+ - SCROLL DOWN CLIPBOARD CONTENTS
	AX = CB07h
Return: nothing
SeeAlso: AX=CB00h,AX=CB05h,AX=CB06h
--------U-16CB08-----------------------------
INT 16 - PUPClip v1.12+ - POP UP
	AX = CB08h
Return: CF clear if successful
	CF set on error (unsupported video mode)
SeeAlso: AX=CB00h
--------U-16D724CX00CB-----------------------
INT 16 U - APCAL v3.20 - GET ???
	AX = D724h
	CX = 00CBh
Return: AX = 0000h
	BX = 0000h
	DX:CX -> ??? or 0000h:0000h
Program: APCAL is an optionally-resident shareware appointment calendar by
	  Gamma Software
SeeAlso: AX=3577h,AX=D724h/CX=00CCh,AX=D724h/CX=00CDh
--------U-16D724CX00CC-----------------------
INT 16 U - APCAL v3.20 - GET ???
	AX = D724h
	CX = 00CCh
Return: AX = 0000h
	BX = 0000h
	DX:CX -> ??? (apparently an internal data area)
SeeAlso: AX=D724h/CX=00CBh,AX=D724h/CX=00CDh
--------U-16D724CX00CD-----------------------
INT 16 U - APCAL v3.20 - GET ???
	AX = D724h
	CX = 00CDh
Return: AX = ??? (5345h seen)
SeeAlso: AX=D724h/CX=00CBh,AX=D724h/CX=00CCh
--------v-16DD--------------------------
INT 16 - VIRUS - "Frumble" - INSTALLATION CHECK
	AH = DDh
Return: AL = DDh if resident
SeeAlso: INT 13/AX=FD50h,INT 21/AX=010Fh,INT 21/AX=0B56h
--------s-16DFDF-----------------------------
INT 16 U - Corel PowerSCSI - FDAUDIO.COM - INSTALLATION CHECK
	AX = DFDFh
Return: ES:DI -> ASCII signature "FDAUDIO/CD" followed by ASCII date, i.e.
	  "06/18/93" if installed
--------b-16E000-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - GET VERSION NUMBER
	AX = E000h
Return: CF clear if successful
	    AL = FAh
	    BX = version number (BCD) (0200h = v2.00)
	CF set on error (not implemented)
Notes:	this interface is available on AMI BIOSes built from AMI core version
	  8/8/93 (HiFlex BIOS) or 11/15/93 (WinBIOS) or later
	the "Meningitis" virus uses this API when attacking a system equipped
	  with an AMI BIOS; it is supposedly able to write itself into the
	  Flash ROM and thus make itself part of the BIOS
SeeAlso: AX=E001h,AX=E004h,AX=E006h,AX=E008h,AX=E00Ah,AX=E00Bh,AX=E0FFh
--------b-16E001-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - GET CHIPSET SAVE/RESTORE SIZE
	AX = E001h
Return: CF clear if successful
	    AL = FAh
	    BX = number of bytes required to save chipset configuration
	CF set on error
SeeAlso: AX=E000h,AX=E002h,AX=E003h
--------b-16E002-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - SAVE CHIPSET STATUS & PREPARE CHPSET
	AX = E002h
	ES:DI -> buffer for storing chipset status
Return: CF clear if successful
	    AL = FAh
	CF set on error
SeeAlso: AX=E000h,AX=E001h,AX=E003h
--------b-16E003-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface -  RESTORE CHIPSET STATUS
	AX = E003h
	ES:DI -> buffer in which chipset status was previously stored
Return: CF clear if successful
	    AL = FAh
	CF set on error
SeeAlso: AX=E000h,AX=E001h,AX=E002h
--------b-16E004-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - LOWER PROGRAMMING VOLTAGE Vpp
	AX = E004h
Return: CF clear if successful
	    AL = FAh
	CF set on error
Note:	this function does not return until the voltage level stabilizes
SeeAlso: AX=E000h,AX=E005h,AX=E006h
--------b-16E005-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - RAISE PROGRAMMING VOLTAGE Vpp
	AX = E005h
Return: CF clear if successful
	    AL = FAh
	CF set on error
Note:	this function does not return until the voltage level stabilizes
SeeAlso: AX=E000h,AX=E004h,AX=E007h
--------b-16E006-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - FLASH WRITE PROTECT
	AX = E006h
Return: CF clear if successful
	    AL = FAh
	CF set on error
Note:	this function performs any delay required to allow the Flash ROM to
	  stabilize in the write-protected state
SeeAlso: AX=E000h,AX=E004h,AX=E007h
--------b-16E007-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - FLASH WRITE ENABLE
	AX = E007h
Return: CF clear if successful
	    AL = FAh
	CF set on error
Note:	this function performs any delay required to allow the Flash ROM to
	  stabilize in the write-enabled state
SeeAlso: AX=E000h,AX=E005h,AX=E006h,AX=E008h
--------b-16E008-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - FLASH SELECT
	AX = E008h
Return: CF clear if successful
	    AL = FAh
	CF set on error
Desc:	select the Flash ROM if the system contains both EPROM and Flash ROM
Note:	this function performs any delay required to allow the Flash ROM to
	  stabilize in the selected state; if no EPROM is present, this
	  function always returns successfully
SeeAlso: AX=E000h,AX=E007h,AX=E009h
--------b-16E009-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - FLASH DE-SELECT
	AX = E009h
Return: CF clear if successful
	    AL = FAh
	CF set on error
Desc:	select the EPROM if the system contains both EPROM and Flash ROM
Note:	this function performs any delay required to allow the Flash ROM to
	  stabilize in the de-selected state; if no EPROM is present, this
	  function always returns successfully
SeeAlso: AX=E000h,AX=E006h,AX=E008h
--------b-16E00A-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - VERIFY ALLOCATED MEMORY
	AX = E00Ah
	BX = number of paragraphs
	ES = starting segment of memory
Return: CF clear if successful
	    AL = FAh
	CF set on error
Desc:	determine whether the specified memory may be used for flash
	  programming
Note:	always returns error if BX is zero on entry
SeeAlso: AX=E000h,AX=E00Bh
--------b-16E00B-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - SAVE INTERNAL CACHE STATUS
	AX = E00Bh
	ES:DI -> buffer for internal cache status (minimum 4Kbytes)
Return: CF clear if successful
	    AL = FAh
	CF set on error
Note:	always returns error if the hardware does not contain internal
	  cache or this call is made in protected mode
SeeAlso: AX=E000h,AX=E00Ah,AX=E00Ch
--------b-16E00C-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - RESTORE INTERNAL CACHE STATUS
	AX = E00Ch
	ES:DI -> buffer containing internal cache status (minimum 4Kbytes)
Return: CF clear if successful
	    AL = FAh
	CF set on error
Note:	always returns error if the hardware does not contain internal
	  cache or this call is made in protected mode
SeeAlso: AX=E000h,AX=E00Bh
--------t-16E0E0-----------------------------
INT 16 - TurboPower TSRs - ALTERNATE INSTALLATION CHECK
	AX = E0E0h
Return: AX = 1F1Fh if installed
	    DWORD 0040h:00F0h -> last data block in TSR list (see #0508)
Note:	the returned TSR list provides support for communication among TSRs
	  built with TurboPower's Turbo Professional and Object Professional
	  libraries for Turbo Pascal
SeeAlso: AX=F0F0h
--------b-16E0FF-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - GENERATE CPU RESET
	AX = E0FFh
Return: never
SeeAlso: AX=E000h,INT 14/AH=17h"FOSSIL"
--------U-16ED--BHED-------------------------
INT 16 - BORLAND TURBO LIGHTNING - API
	AH = EDh
	BH = EDh
	BL = function
	    00h installation check
		Return: AX = 5205h
			CH = major version
			CL = minor version
	    01h identical to function 00h???
	    02h get resident data segment
		Return: AX = data segment of resident portion
	    03h get resident ???
		Return: AX = offset of some buffer in resident code seg
	    04h redefine auxiliary dictionary
		DS:SI -> counted filename string
		Return: AL = result code
	    05h select active environment
		AL = environment (00h to 0Ch)
		Return: AX = status
			    0000h if OK
			    0001h if out of range
	    06h toggle AutoProof???
		AL = state (00h off, 01h on)
	    07h ???
	    08h ???
		AL = char???
		CX = ???
		DX = ???
		Return: AX = 0, 1 or 2
	    09h ???
	    0Ah ???
		CX = ???
		DX = ???
		Return: AX = ???
	    0Bh check dictionary integrity???
		DS:SI -> counted dictionary filename string
		Return: AX = 0, 40h, 80h
	    0Ch spellcheck string (disk dictionary, possibly RAM dict as well)
		DS:SI -> counted string to check
		Return: AH = 0
			AL = result code
			   00h string found in dictionary
			   20h string begins more than one word
			   40h string not found
	    0Dh set ???
		(sets an internal flag)
	    0Eh spellcheck string (RAM dictionary only)
		DS:SI -> counted string to check
		Return: AH = 00h
			AL = result code
			    00h string found in dictionary
			    01h string not found
			    02h ???
	    0Fh ???
	    10h ???
Notes:	AX in general returns an error code from most functions.
Index:	installation check;Turbo Lightning
--------U-16EF-------------------------------
INT 16 - CALCULATOR - INSTALLATION CHECK
	AH = EFh
Return: AX = 0088h if installed
Program: CALCULATOR is a shareware popup calculator by Andrzej Brzezinski and
	  Marek Kosznik
--------b-16F0-------------------------------
INT 16 - Compaq 386 and newer - SET CPU SPEED
	AH = F0h
	AL = speed code (see #0507)
	if AL=09h,
	    CX = speed value, 1 (slowest) to 50 (full), 3 ~= 8088
Note:	also supported by some versions of AMI BIOS dated June 1992 or later;
	  speed codes 0 or 1 are used for Low Speed, 2 for High Speed
SeeAlso: AH=F1h,AH=F3h

(Table 0507)
Values for speed code:
 00h	equivalent to 6 MHz 80286 (COMMON)
 01h	equivalent to 8 MHz 80286 (FAST)
 02h	full 16 MHz (HIGH)
 03h	toggles between 8 MHz-equivalent and speed set by system board switch
	  (AUTO or HIGH)
 08h	full 16 MHz except 8 MHz-equivalent during floppy disk access
 09h	specify speed directly
--------t-16F0F0-----------------------------
INT 16 - TurboPower TSRs - INSTALLATION CHECK
	AX = F0F0h
Return: AX = 0F0Fh if installed
	    ES:DI -> last data block in TSR list (see #0508)
Note:	the returned TSR list provides support for communication among TSRs
	  built with TurboPower's Turbo Professional and Object Professional
	  libraries for Turbo Pascal
SeeAlso: AX=E0E0h

Format of TurboPower TSR data block:
Offset	Size	Description	(Table 0508)
 00h	DWORD	pointer to program tag (counted ASCII string)
 04h	WORD	interface version number (0400h)
 06h	DWORD	pointer to command entry point
 0Ah	DWORD	pointer to previous data block (0000h:0000h if none)
 0Eh	DWORD	pointer to next data block (0000h:0000h if none)
---swappable TSRs only---
 12h	DWORD	pointer to swapping data
 16h	DWORD	pointer to user data
	more???
--------b-16F1-------------------------------
INT 16 - Compaq 386 and newer - READ CURRENT CPU SPEED
	AH = F1h
Return: AL = speed code (see #0507)
	if AL = 09h, CX = speed code
Note:	also supported by some versions of AMI BIOS dated June 1992 or later
SeeAlso: AH=F0h,AH=F3h
--------b-16F2-------------------------------
INT 16 - Compaq 386 and newer - DETERMINE ATTACHED KEYBOARD TYPE
	AH = F2h
Return: AL = type
	    00h if 11-bit AT keyboard is in use
	    01h if 9-bit PC keyboard is in use
	AH = 00h (04/08/93 system ROM)
--------b-16F3-------------------------------
INT 16 - Compaq 80286s - SET CPU SPEED LIMIT (OVERRIDE JUMPER)
	AH = F3h
	AL = new limit
	    00h limit is 6 Mhz
	    01h limit is 8 Mhz/6 Mhz
SeeAlso: AH=F0h,AH=F1h
--------U-16F398-----------------------------
INT 16 U - NORTON GUIDES - INSTALLATION CHECK
	AX = F398h
Return: AX = 6A73h ("js")
	BH = BIOS scan code of current hot key
	BL = ASCII code of current hot key
Note:	NG.EXE was written by John Socha
--------b-16F400-----------------------------
INT 16 - Compaq Systempro and higher - CACHE CONTROLLER STATUS
	AX = F400h
Return: AH = E2h (*)
	AL = status
	    00h not present
	    01h enabled
	    02h disabled
	CX = cache memory size
	    bit 15:	cache size information is NOT valid
	    bits 14-0:	cache memory size in kilobytes
	DH = cache write technology
	    bit 7:	cache write information is NOT valid
	    bits 6-1:	reserved (0)
	    bit 0:	0 = Write-through caching
			1 = Write-back caching
	DL = cache type
	    bit 7:	cache type information is NOT valid
	    bits 6-1:	reserved (0)
	    bit 0:	0 = Direct mapped
			1 = Two-way set-associative
Notes:	also supported by some versions of AMI BIOS dated June 1992 or later
	many (most) BIOSes return a modified AH when called for an unsupported
	  or non-keyboard function (typically, the highest supported keyboard
	  function [normally 12h] is subtracted from the original AH)
SeeAlso: AX=F401h,AX=F402h
--------b-16F401-----------------------------
INT 16 - Compaq Systempro and higher - ENABLE CACHE CONTROLLER
	AX = F401h
Return: AX = E201h
Notes:	also supported by some versions of AMI BIOS dated June 1992 or later
	many (most) BIOSes return a modified AH when called for an unsupported
	  or non-keyboard function (typically, the highest supported keyboard
	  function [normally 12h] is subtracted from the original AH)
SeeAlso: AX=F400h,AX=F402h
--------b-16F402-----------------------------
INT 16 - Compaq Systempro and higher - DISABLE CACHE CONTROLLER
	AX = F402h
Return: AX = E202h
Notes:	also supported by some versions of AMI BIOS dated June 1992 or later
	many (most) BIOSes return a modified AH when called for an unsupported
	  or non-keyboard function (typically, the highest supported keyboard
	  function [normally 12h] is subtracted from the original AH)
SeeAlso: AX=F400h,AX=F401h
--------v-16FA00DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE, VWATCH - INSTALLATION CHECK
	AX = FA00h
	DX = 5945h
Return: CF clear
	DI = 4559h
	BX = BIOS hotkey scancode (default 2F00h) (VSAFE only)
		FFFFh if disabled
Note:	MS-DOS 6.0 bundles VSAFE and VWATCH as part of its virus protection
SeeAlso: AX=FA05h,INT 13/AH=FAh,INT 21/AH=FAh"VDEFEND",INT 2F/AX=6282h
--------v-16FA01DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE, VWATCH - UNINSTALL
	AX = FA01h
	DX = 5945h
Return: CF clear if successful
	DI = 4559h
SeeAlso: AX=FA00h
--------v-16FA02DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE, VWATCH - GET/SET OPTIONS
	AX = FA02h
	DX = 5945h
	BL = new parameter flags (see #0509)
Return: CF clear
	DI = 4559h
	CL = old value of parameter flags

Bitfields for VSAFE/VWATCH parameter flags:
Bit(s)	Description	(Table 0509)
 7	Protect executable files
 6	Protect FD boot sector
 5	Protect HD boot sector
 4	Boot sector viruses
 3	Check executable files
 2	General write protect
 1	Resident
 0	HD Low level format
--------v-16FA03DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE, VWATCH - GET ???
	AX = FA03h
	DX = 5945h
Return: CF clear
	DI = 4559h
	AX = 0002h
--------v-16FA04DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE - GET HOTKEY DISABLE FLAG
	AX = FA04h
	DX = 5945h
Return: CF clear
	DI = 4559h
	BL = hotkey disable flag (nonzero if hotkey disabled)
Note:	this function is a NOP under VWATCH, merely returning CF clear/DI=4559h
SeeAlso: AX=FA00h,AX=FA05h
--------v-16FA05DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE - SET HOTKEY DISABLE FLAG
	AX = FA05h
	DX = 5945h
	BL = new value of hotkey disable flag (nonzero to disable hotkey)
Return: CF clear
	DI = 4559h
Note:	this function is a NOP under VWATCH, merely returning CF clear/DI=4559h
SeeAlso: AX=FA00h,AX=FA04h
--------v-16FA06DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE, VWATCH - GET NETWORK DRIVES TEST FLAG
	AX = FA06h
	DX = 5945h
Return: CF clear
	DI = 4559h
	BL = test status
	    00h don't monitor network drives (default for VWATCH v2.1)
	    FFh monitor network drives (default for VSAFE v2.0)
	CL = ??? (only VSAFE 2.0)
SeeAlso: AX=FA07h
--------v-16FA07DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE, VWATCH - SET NETWORK DRIVES TEST FLAG
	AX = FA07h
	DX = 5945h
	BL = new state
	    00h don't monitor
	    01h monitor network drives
Return: CF clear
	DI = 4559h
Note:	VWATCH v2.1 (from PC Tools 9.0) returns CF set instead
SeeAlso: AX=FA00h,AX=FA06h
--------v-16FA08DX5945-----------------------
INT 16 U - PC Tools v9+ VWATCH v2.1 - ???
	AX = FA08h
	DX = 5945h
Return: CF clear
	DI = 4559h
	AX = ??? (0002h)
	BX = version (BH=major, BL=two-digit minor)
Note:	this function is not supported by the PC Tools 9.0 VSAFE v2.0
SeeAlso: AX=FA00h,AX=FA06h
--------U-16FE55-----------------------------
INT 16 U - PC Tools v8+ programs - GET ???
	AX = FE55h
	CX = segment of resident program or 0000h for last loaded
	DX = 0000h
Return: DX = resident code segment (unchanged if CX=0000h on entry)
	AX = ??? or 0000h
Note:	this call is supported by CPSCHED, CPTASK, DATAMON, DPROTECT, DRIVEMAP,
	  and DSKLIGHT beginning in PC Tools v8.0; programs other than CPTASK
	  seem to hook it merely to return the same AX as the CPTASK loaded
	  prior to them returned
--------U-16FEA4-----------------------------
INT 16 U - PC Tools v7+ CPSCHED/DESKTOP - RESET ???
	AX = FEA4h
Return: nothing
Note:	this function is identical to AX=FFA4h, and is implemented by the same
	  code in DESKTOP
SeeAlso: AX=FFA4h
--------U-16FEC6-----------------------------
INT 16 U - PC Tools v7+ CPSCHED - ENABLE/DISABLE CPSCHED API
	AX = FEC6h
	BL = new state (00h enabled, nonzero disabled)
Return: nothing
Desc:	specify whether CPSCHED API calls other than this one and AX=FE55h will
	  be honored
--------U-16FED3-----------------------------
INT 16 U - PC Tools v7+ CPSCHED/DESKTOP - ???
	AX = FED3h
	DS:SI -> 92-byte data record for ???
Return: ???
Note:	this function is identical to AX=FFD3h, and is implemented by the same
	  code in DESKTOP
SeeAlso: AX=FFD3h
--------U-16FEDC-----------------------------
INT 16 U - PC Tools v7+ CPSCHED - UNHOOK INTERRUPTS
	AX = FEDCh
Return: AX,DX destroyed
Index:	uninstall;CPSCHED
--------U-16FEEFCX0000-----------------------
INT 16 U - PC Tools v7+ CPSCHED/DESKTOP - INSTALLATION CHECK
	AX = FEEFh
	CX = 0000h
Return: CX = ABCDh if PC Tools scheduler (CPSCHED or DESKTOP) installed
	    BX = segment of resident portion
	    DX = (CPSCHED v8.0) resident CS
Note:	this function is identical to AX=FFD3h, and is implemented by the same
	  code in DESKTOP
SeeAlso: AX=FFEFh
--------U-16FEF1-----------------------------
INT 16 U - PC Tools v7 only CPSCHED/DESKTOP - ALTERNATE INSTALLATION CHECK
	AX = FEF1h
	BX = ???
Return: CX = 5555h if PC Tools scheduler (CPSCHED or DESKTOP) installed
	DX = 5555h
Note:	this function is identical to AX=FFD3h, and is implemented by the same
	  code in DESKTOP
SeeAlso: AX=FFF1h
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
SeeAlso: INT 61"OPTIMA"
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
Return: AX = flags (see #0510)
SeeAlso: AX=FF80h/BX=0004h,AX=FF80h/BX=0006h

Bitfields for CPTASK flags:
Bit(s)	Description	(Table 0510)
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
	DS:DX -> buffer for ??? (see #0511)
Return: ???

Format of PC Tools DESKTOP buffer:
Offset	Size	Description	(Table 0511)
 00h 48 BYTEs	???
 30h 128 BYTEs	???
--------U-16FF98-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - OPEN \DESK.OVL FILE AND SEEK TO OVERLAY
	AX = FF98h
	DX = byte offset in file of overlay header (see #0512)
Return: BX = file handle for DESK.OVL file
Desc:	open the DESK.OVL file, seek to the specified offset, read in the
	  overlay header, and seek to the offset specified by the header

Format of PC Tools DESKTOP overlay header:
Offset	Size	Description	(Table 0512)
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
	    ES:DI -> internal data (see #0513)
	    CL = cache state
		01h enabled
		02h disabled
SeeAlso: INT 13/AH=27h,INT 13/AH=A0h,INT 21/AH=2Bh/CX=4358h

Format of PC-Cache internal data:
Offset	Size	Description	(Table 0513)
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
	BX = window specifier (000Fh to 0019h) (see #0514)
	DX = 0000h get, nonzero = set
	ES:DI -> window parameter buffer (see #0515)
SeeAlso: AX=FFCBh

(Table 0514)
Values for PC Tools DESKTOP window specifier:
 000Fh	comm/FAX
 0014h	hotkey selection
 0015h	ASCII table
 0016h	system colors menu

Format of PC Tools DESKTOP window parameters:
Offset	Size	Description	(Table 0515)
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
	ES:DI -> data structure (see #0516)
	???
Return: AX = ???
Note:	available only when popped up
SeeAlso: AX=FFC2h,AX=FFC3h

Format of PC Tools DESKTOP data structure:
Offset	Size	Description	(Table 0516)
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
	ES:DI -> data structure (see #0516)
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
	ES:DI -> data structure (see #0516)
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
	    DS:SI -> list of pointers (see #0517)

Format of PC Tools PCShell returned pointer list:
Offset	Size	Description	(Table 0517)
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
	DS:SI -> pulldown menu system description (see #0518)
Return: AX destroyed
Notes:	available only when popped up
	if the accessory does not need any menu items of its own, it should
	  call AX=FFFAh instead
SeeAlso: AX=FFF7h,AX=FFFAh

Format of PC Tools DESKTOP pulldown menu system description:
Offset	Size	Description	(Table 0518)
 00h	WORD	offset of menu bar contents (counted string)
 02h	WORD	number of items on menu bar
 04h 10 BYTEs	scan codes for hotkeying to each of up to ten menu items
 0Eh 10 BYTEs	which character to highlight in each menu item (01h=first)
 18h	WORD	offset of first menu definition (see #0519)
 1Ah	WORD	offset of second menu definition
	...

Format of PC Tools DESKTOP menu definition:
Offset	Size	Description	(Table 0519)
 00h	WORD	offset of menu contents (see #0520)
 02h	WORD	number of entries in menu
 04h	for each entry:
		Offset	Size	Description
		 00h	BYTE	scancode of Alt-key to invoke entry
		 01h	BYTE	character to highlight (01h=first, etc)
		 02h	WORD	offset of FAR routine to handle selection

Format of PC Tools DESKTOP menu contents:
Offset	Size	Description	(Table 0520)
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
Return: ES:BX -> screen attributes data structure (see #0521)
	AL = ??? (v6.0+)

Format of PC Tools DESKTOP attribute data structure:
Offset	Size	Description	(Table 0521)
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
	DS = segment of editor buffer structure (see #0522)
	BX = ???
	DX = segment of window parameters structure (see #0515)
Return: ???
Note:	available only when popped up
SeeAlso: AX=FFF4h

Format of PC Tools DESKTOP editor buffer structure:
Offset	Size	Description	(Table 0522)
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
	DS:0000h -> window parameters structure (see #0515)
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
Return: ES:BX -> hotkey table (see #0523)
	DS:DX = original INT 09 vector

Format of PC Tools DESKTOP hotkey table:
Offset	Size	Description	(Table 0523)
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
--------!---Section--------------------------
