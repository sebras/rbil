Interrupt List, part 4 of 8
This compilation is Copyright (c) 1989,1990,1991,1992,1993 Ralf Brown
----------2180-------------------------------
INT 21 - European MSDOS 4.0 - "AEXEC" - EXECUTE PROGRAM IN BACKGROUND
	AH = 80h
	CX = mode
	    0000h place child in zombie mode on exit to preserve exit code
	    0001h discard child process and exit code on termination
	DS:DX -> ASCIZ full program name
	ES:BX -> parameter block (as for AX=4B00h)
Return: CF clear if successful
	    AX = Command Subgroup ID (CSID)
	CF set on error
	    AX = error code (see AH=59h)
Desc:	asynchronously execute a program, creating a new process for it
Notes:	this function is called by the DETACH command
	there is a system-wide limit of 32 processes
	the CSID is used to identify all processes that have been spawned by
	  a given process, whether directly or indirectly
	programs to be run in the background must use the new executable format
	  (see AH=4Bh)
	background processes may only perform asynchronous (background) EXECs,
	  either this function or AX=4B04h
	background processes may execute INT 11, INT 12, INT 21, INT 2A, and
	  INT 2F at any time; they may execute INT 10 and INT 16 only while
	  they have opened a popup screen via INT 2F/AX=1401h; no other
	  interrupts may be executed from the background
	background processes may not use drive B: or overlay their code
	  segments
SeeAlso: AH=4Bh,AX=8700h,INT 2F/AX=1400h"POPUP"
----------218080-----------------------------
INT 21 - PCW Weather Card interface - UNINSTALL PCW.COM AND FREE MEMORY
	AX = 8080h
Return: ???
SeeAlso: AX=7070h/BX=7070h
----------2181-------------------------------
INT 21 - European MSDOS 4.0 - "FREEZE" - STOP A PROCESS
	AH = 81h
	BX = flag (00h freeze command subtree, 01h only specified process)
	CX = Process ID of head of command subtree
Return: CF clear if successful
	CF set on error
	    AX = error code (no such process)
Desc:	temporarily suspend a process or a process and all of its children
Note:	if BX=0001h, this call will not return until the process is actually
	  frozen, which may not be until after it unblocks from an I/O
	  operation
SeeAlso: AH=82h,AH=89h,AX=8E00h,INT 15/AX=101Dh
----------2182-------------------------------
INT 21 - European MSDOS 4.0 - "RESUME" - RESTART A PROCESS
	AH = 82h
	BX = flag (00h resume command subtree, 01h only specified process)
	CX = Process ID of head of command subtree
Return: CF clear if successful
	CF set on error
	    AX = error code (no such process)
Desc:	restart a previously-suspended process or a process and all of its
	  children
SeeAlso: AX=81h,INT 15/AX=101Eh
----------2183-------------------------------
INT 21 - European MSDOS 4.0 - "PARTITION" - GET/SET FOREGROUND PARTITION SIZE
	AH = 83h
	AL = function
	    00h get size
	    01h set new size
		BX = new size in paragraphs
Return: CF clear if successful
	    BX = current size (function 00h) or old size (function 01h)
	CF set on error
	    AX = error code (01h,07h,0Dh)(see AH=59h)
Desc:	specify or determine how much memory may be allocated by the foreground
	  process
Note:	if the partition size is set to 0000h, no partition management is done
	  and all memory allocation is compatible with DOS 3.2.
	the partition size can be changed regardless of what use is being made
	  of the changed memory; subsequent allocations will follow the
	  partition rules (foreground processes may allocate only foreground
	  memory; background processes allocate background memory first, then
	  foreground memory)
SeeAlso: AH=48h,AH=4Ah
----------2183-------------------------------
INT 21 - VIRUS - "SVC" - INSTALLATION CHECK
	AH = 83h
Return: DX = 1990h if resident
SeeAlso: AH=76h,AH=84h"VIRUS"
----------2184-------------------------------
INT 21 - VIRUS - "SVC 5.0" or "SVC 6.0" - INSTALLATION CHECK
	AH = 84h
Return: DX = 1990h if resident
	    BH = version number (major in high nybble, minor in low)
SeeAlso: AH=83h"VIRUS",AH=89h"VIRUS"
----------218400-----------------------------
INT 21 - European MSDOS 4.0 - "CREATMEM" - CREATE A SHARED MEMORY AREA
	AX = 8400h
	BX = size in bytes (0000h = 65536)
	CX = flags
	    bit 6: zero-initialize segment
	DS:DX -> ASCIZ name (must begin with "\SHAREMEM\")
Return: CF clear if successful
	    AX = segment address of shared memory global object
	CF set on error
	    AX = error code (06h,08h) (see AH=59h)
Desc:	create an area of memory which may be accessed by multiple processes
Notes:	shared memory objects are created as special files (thus the
	  restriction on the name)
	on successful creation, the reference count is set to 1
SeeAlso: AX=8401h,AX=8402h,INT 15/AX=DE19h
----------218401-----------------------------
INT 21 - European MSDOS 4.0 - "GETMEM" - OBTAIN ACCESS TO SHARED MEMORY AREA
	AX = 8401h
	CX = flags
	    bit 7: writable segment (ignored by MSDOS 4.0)
	DS:DX -> ASCIZ name (must begin with "\SHAREMEM\")
Return: CF clear if successful
	    AX = segment address of shared memory global object
	    CX = size in bytes
	CF set on error
	    AX = error code (invalid name)
Desc:	get address of a previously-created area of memory which may be
	  accessed by multiple processes	
Note:	this call increments the reference count for the shared memory area
SeeAlso: AX=8400h,AX=8402h
----------218402-----------------------------
INT 21 - European MSDOS 4.0 - "RELEASEMEM" - FREE SHARED MEMORY AREA
	AX = 8402h
	BX = handle (segment address of shared memory object)
Return: CF clear if successful
	CF set on error
	    AX = error code (no such name)
Desc:	indicate that the specified area of shared memory will no longer be
	  used by the caller
Note:	the reference count is decremented and the shared memory area is
	  deallocated if the new reference count is zero
SeeAlso: AX=8400h,AX=8401h,INT 15/AX=DE19h
----------2185-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 85h
	???
Return: ???
----------2186-------------------------------
INT 21 - European MSDOS 4.0 - "SETFILETABLE" - INSTALL NEW FILE HANDLE TABLE
	AH = 86h
	BX = total number of file handles in new table
Return: CF clear if successful
	CF set on error
	    AX = error code (06h,08h) (see AH=59h)
Desc:	adjust the size of the per-process open file table, thus raising or
	  lowering the limit on the number of files the caller can open
	  simultaneously
Notes:	any currently-open files are copied to the new table
	if the table is increased beyond the default 20 handles, only the
	  first 20 will be inherited by child processes
	error 06h is returned if the requested number of handles exceeds
	  system limits or would require closing currently-open files
SeeAlso: AH=26h,AH=67h
----------2187-------------------------------
INT 21 - European MSDOS 4.0 - "GETPID" - GET PROCESS IDENTIFIER
	AH = 87h
Return: AX = PID
	BX = parent process's PID
	CX = Command Subgroup ID (CSID)
Desc:	determine an identifier by which to access the calling process
Notes:	called by MS C v5.1 getpid() function
	this function apparently must return AX=0001h for INT 21/AH=80h to
	  succeed
	one possible check for European MSDOS 4.0 is to issue this call with
	  AL=00h and check whether AL is nonzero on return
SeeAlso: AH=30h,AH=62h,AH=80h
----------2188-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 88h
	???
Return: ???
----------2189-------------------------------
INT 21 - European MSDOS 4.0 - SLEEP
	AH = 89h
	CX = time in milliseconds or 0000h to give up time slice
Return: CF clear if successful
	    CX = 0000h
	CF set on error
	    AX = error code (interrupted system call)
	    CX = sleep time remaining
Desc:	suspend the calling process for the specified duration
Notes:	the sleep interval is rounded up to the next higher increment of the
	  scheduler clock, and may be extended further if other processes are
	  running
	this call may be interrupted by signals (see AH=8Dh)
	reportedly called by Microsoft C 4.0 startup code
	background processes have higher priority than the foreground process,
	  and should thus periodically yield the CPU
SeeAlso: AH=81h,INT 15/AX=1000h,INT 2F/AX=1680h,INT 7A/BX=000Ah
----------2189-------------------------------
INT 21 - VIRUS - "Vriest" - INSTALLATION CHECK
	AH = 89h
Return: AX = 0123h if resident
SeeAlso: AH=84h"VIRUS",AH=90h"VIRUS"
----------218A-------------------------------
INT 21 - European MSDOS 4.0 - "CWAIT" - WAIT FOR CHILD TO TERMINATE
	AH = 8Ah
	BL = range (00h command subtree, 01h any child)
	BH = suspend flag
	    00h suspend if children exist but none are dead
	    01h return if no dead children
	CX = Process ID of head of command subtree
Return: CF clear if successful
	    AH = termination type
		00h normal termination
		01h aborted by Control-C
		02h aborted by I/O error
		03h terminate and stay resident
		04h aborted by signal
		05h aborted by program error
	    AL = return code from child or aborting signal
	    BX = PID of child (0000h if no dead children)
	CF set on error
	    AX = error code (no child,interrupted system call)
Desc:	get return code from an asynchronously-executed child program,
	  optionally waiting if no return code is available
SeeAlso: AH=4Bh,AH=4Dh,AH=80h,AH=8Dh
----------218B-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 8Bh
	???
Return: ???
----------218C-------------------------------
INT 21 - European MSDOS 4.0 - SET SIGNAL HANDLER
	AH = 8Ch
	AL = signal number (see below)
	BL = action (see below)
	DS:DX -> signal handler
Return: CF clear if successful
	    AL = previous action
	    ES:BX -> previous signal handler
	CF set on error
	    AX = error code (01h,invalid SigNumber or Action) (see AH=59h)
Desc:	set the routine which will be invoked on a number of exceptional
	  conditions
Note:	all signals will be sent to the most recently installed handler
SeeAlso: AH=8Dh

Values for signal number:
 01h	SIGINTR		Control-C or user defined interrupt key
 08h	SIGTERM		program termination
 09h	SIGPIPE		broken pipe
 0Dh	SIGUSER1	reserved for user definition
 0Eh	SIGUSER2	reserved for user definition

Values for signal action:
 00h	SIG_DFL		terminate process on receipt
 01h	SIG_IGN		ignore signal
 02h	SIG_GET		signal is accepted
 03h	SIG_ERR		sender gets error
 04h	SIG_ACK		acknowledge received signal and clear it, but don't
			change current setting

Signal handler is called with:
	AL = signal number
	AH = signal argument
Return: RETF, CF set: terminate process
	RETF, CF clear, ZF set: abort any interrupted system call with an error
	RETF, CF clear, ZF clear: restart any interrupted system call
	IRET: restart any interrupted system call
Note:	the signal handler may also perform a nonlocal GOTO by resetting the
	  stack pointer and jumping; before doing so, it should dismiss the
	  signal by calling this function with BL=04h
----------218D-------------------------------
INT 21 - European MSDOS 4.0 - SEND SIGNAL
	AH = 8Dh
	AL = signal number (see AH=8Ch)
	BH = signal argument
	BL = action
	    00h send to entire command subtree
	    01h send only to specified process
	DX = Process ID
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,06h)(see AH=59h)
Desc:	invoke the exceptional-condition handler for the specified process
Note:	error 06h may be returned if one or more of the affected processes
	  have an error handler for the signal
SeeAlso: AH=8Ch
----------218E00-----------------------------
INT 21 - European MSDOS 4.0 - "SETPRI" - GET/SET PROCESS PRIORITY
	AX = 8E00h
	BH = 00h
	BL = action
	    00h set priority for command subtree
	    01h set priority for specified process only
	CX = Process ID
	DH = 00h
	DL = change in priority (00h to get priority)
Return: CF clear if successful
	    DL = process priority
	    DH destroyed
	CF set on error
	    AX = error code (01h,no such process)(see AH=59h)
Desc:	specify or determine the execution priority of the specified process
	  or the process and all of its children
SeeAlso: AH=81h
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
INT 21 - European MSDOS 4.0 - "PIPE" - CREATE A NEW PIPE
	AH = 93h
	CX = size in bytes
Return: CF clear if successful
	    AX = read handle
	    BX = write handle
	CF set on error
	    AX = error code (08h) (see AH=59h)
Desc:	create a communications channel which may be used for interprocess
	  data and command exchanges
SeeAlso: AH=3Ch,AH=3Fh,AH=40h,AH=84h
----------2194-------------------------------
INT 21 U - European MSDOS 4.0 - ???
	AH = 94h
	???
Return: ???
----------2195-------------------------------
INT 21 - European MSDOS 4.0 - HARD ERROR PROCESSING
	AH = 95h
	AL = new state
	   00h enabled
	   01h disabled, automatically fail hard errors
Return: AX = previous setting
Desc:	specify whether hard (critical) errors should automatically fail the
	  system call or invoke an INT 24
SeeAlso: INT 24
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
INT 21 u - European MSDOS 4.0 - "PBLOCK" - BLOCK A PROCESS
	AH = 99h
	DS:BX -> memory location to block on
	CX = timeout in milliseconds
	DH = nonzero if interruptible
Return: CF clear if awakened by event
	    AX = 0000h
	CF set if unusual wakeup
	    ZF set if timeout, clear if interrupted by signal
	    AX = nonzero
Desc:	suspend calling process until another process sends a "restart" signal
	  or a timeout occurs
SeeAlso: AH=9Ah,INT 2F/AX=0802h
----------219A-------------------------------
INT 21 u - European MSDOS 4.0 - "PRUN" - UNBLOCK A PROCESS
	AH = 9Ah
	DS:BX -> memory location processes may have blocked on
Return: AX = number of processes awakened
	ZF set if no processes awakened
Desc:	restart all processes waiting for the specified "restart" signal
SeeAlso: AH=99h,INT 2F/AX=0802h
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
INT 21 - Novell NetWare - FILE SERVICES - EXTENDED FILE ATTRIBUTES
	AH = B6h
	AL = subfunction
	    00h get extended file attributes
	    01h set extended file attributes
		CL = extended file attributes (see below)
	DS:DX -> ASCIZ pathname (max 255 bytes)
Return: CF set on error
	    AL = error code
		8Ch caller lacks privileges
		FEh not permitted to search directory
		FFh file not found
	CF clear if successful
	    AL = 00h (success)
	    CL = current extended file attributes (see below)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AX=4300h,AH=E3h/SF=0Fh

Bitmask of extended file attributes:
 bits 2-0: search mode (executables only)
	000 none (use shell's default search)
	001 search on all opens without path
	010 do not search
	011 search on read-only opens without path
	100 reserved
	101 search on all opens
	110 reserved
	111 search on all read-only opens
 bit 3: reserved
 bit 4: transactions on file tracked
 bit 5: file's FAT indexed
 bit 6: read audit (to be implemented)
 bit 7: write audit (to be implemented)
----------21B8-------------------------------
INT 21 - Attachmate Extra - DISABLE HOST BUFFER UPDATES
	AH = B8h
	AL = window number (1-4=host B-E)
	DL = 01h
Notes:	only valid in CUT mode
	next AID keystroke (eg Enter) enables host buffer updates
SeeAlso: AH=A4h
----------21B800-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - GET DEFAULT CAPTURE FLAGS
	AX = B800h
	CX = size of reply buffer (01h-3Fh)
	ES:BX -> reply buffer for capture flags table (see below)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.0+
SeeAlso: AX=B801h,AX=B802h,AH=DFh/DL=00h,AH=DFh/DL=04h

Format of capture flags table:
Offset	Size	Description
 00h	BYTE	status (used internally, should be set to 00h)
 01h	BYTE	print flags
		bit 2: print capture file if interrupted by loss of connection
		    3: no automatic form feed after print job
		    6: printing control sequences interpreted by print service
		    7: print banner page before capture file
 02h	BYTE	tab size (01h-12h, default 08h)
 03h	BYTE	printer number on server (00h-04h, default 00h)
 04h	BYTE	number of copies to print (00h-FFh, default 01h)
 05h	BYTE	form type required in printer (default 00h)
 06h	BYTE	reserved
 07h 13 BYTEs	text to be placed on banner page
 14h	BYTE	reserved
 15h	BYTE	default local printer (00h = LPT1)
 16h	WORD	timeout in clock ticks for flushing capture file on inactivity
		(big-endian)
		0000h = never timeout
 18h	BYTE	flush capture file on LPT close if nonzero
 19h	WORD	maximum lines per page (big-endian)
 1Bh	WORD	maximum characters per line (big-endian)
 1Dh 13 BYTEs	name of form required in printer
 2Ah	BYTE	LPT capture flag
		00h inactive, FFh LPT device is being captured
 2Bh	BYTE	file capture flag
		00h if no file specified, FFh if capturing to file
 2Ch	BYTE	timing out (00h if no timeout in effect, FFh if timeout counter
		running)
 2Dh	DWORD	address of printer setup string (big-endian)
 31h	DWORD	address of printer reset string (big-endian)
 35h	BYTE	target connection ID
 36h	BYTE	capture in progress if FFh
 37h	BYTE	job queued for printing if FFh
 38h	BYTE	print job valid if FFh
 39h	DWORD	bindery object ID of print queue if previous byte FFh
 3Dh	WORD	print job number (1-999) `````(big-endian)
----------21B801-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - SET DEFAULT CAPTURE FLAGS
	AX = B801h
	CX = size of buffer (01h-3Fh)
	ES:BX -> buffer containing capture flags table (see below)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.0+
SeeAlso: AX=B800h,AX=B803h,AH=DFh/DL=00h,AH=DFh/DL=04h
----------21B802-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - GET SPECIFIC CAPTURE FLAGS
	AX = B802h
	CX = size of reply buffer (01h-3Fh)
	DH = LPT port (00h-02h)
	ES:BX -> reply buffer for capture flags table (see AX=B800h)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AX=B800h,AX=B803h,AH=DFh/DL=00h,AH=DFh/DL=04h
----------21B803-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - SET SPECIFIC CAPTURE FLAGS
	AX = B803h
	CX = size of buffer (01h-3Fh)
	DH = LPT port (00h-02h)
	ES:BX -> buffer containing capture flags table (see below)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AX=B800h,AX=B803h,AH=DFh/DL=00h,AH=DFh/DL=04h
----------21B804-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - GET DEFAULT LOCAL PRINTER
	AX = B804h
Return: DH = default LPT port (00h-02h)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AX=B800h,AX=B805h,AH=DFh/DL=00h
----------21B805-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - SET DEFAULT LOCAL PRINTER
	AX = B805h
	DH = new default LPT port (00h-02h)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AX=B800h,AX=B804h,AH=DFh/DL=00h
----------21B806-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - SET CAPTURE PRINT QUEUE
	AX = B806h
	DH = LPT port (00h-02h)
	BX:CX = print queue's object ID
Return: AL = status
	    00h successful
	    FFh job already set
Desc:	specify the print queue on which a print job is to be placed the next
	  time a capture is started on the given printer port
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AX=B801h,AX=B807h,AX=E009h
----------21B807-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - SET CAPTURE PRINT JOB
	AX = B807h
	DH = LPT port (00h-02h)
	BX = job number (see AH=E3h/SF=68h)
	SI:DI:CX = NetWare file handle (see AH=E3h/SF=68h)
Return: AL = status
	    00h successful
	    FFh job already queued
Desc:	specify the capture file and print job to be used for subsequent
	  output to the given printer port
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AX=B801h,AX=B806h,AX=E009h,AH=E3h/SF=68h
----------21B808-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - GET BANNER USER NAME
	AX = B808h
	ES:BX -> 12-byte buffer for user name
Return: AL = status
	    00h successful
Desc:	get the user name which is printed on the banner page
Notes:	this function is supported by Advanced NetWare 2.1+
	the default name is the login name of the user
SeeAlso: AX=B809h
----------21B809-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - GET BANNER USER NAME
	AX = B809h
	ES:BX -> 12-byte buffer containing user name
Return: AL = status
	    00h successful
Desc:	specify the user name which is printed on the banner page
Notes:	this function is supported by Advanced NetWare 2.1+
	the default name is the login name of the user
SeeAlso: AX=B808h
----------21BB-------------------------------
INT 21 - Novell NetWare - WORKSTATION - SET END OF JOB STATUS
	AH = BBh
	AL = new EOJ flag
	    00h disable EOJs
	    01h enable EOJs
Return: AL = old EOJ flag
Desc:	specify whether the network shell should automatically generate an
	  End of Job call when the root command processor regains control
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=D6h
----------21BBBB-----------------------------
INT 21 - VIRUS - "Hey You" - INSTALLATION CHECK
	AX = BBBBh
Return: AX = 6969h
SeeAlso: AH=ABh"VIRUS",AH=BEh"VIRUS"
----------21BC-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - LOG PHYSICAL RECORD
	AH = BCh
	AL = flags
	    bit 0: lock as well as log record
		1: non-exclusive lock
	BX = file handle
	CX:DX = starting offset in file
	SI:DI = length of region to lock
	BP = timeout in timer ticks (1/18 sec)
		0000h = don't wait if already locked
Return: AL = status
	    00h successful
	    96h no dynamic memory for file
	    FEh timed out
	    FFh failed
Desc:	add the specified physical record to the log table, optionally locking
	  it
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=5Ch,AH=BDh,AH=BEh,AH=BFh,AH=C2h,AH=D0h
----------21BD-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - RELEASE PHYSICAL RECORD
	AH = BDh
	BX = file handle
	CX:DX = starting offset in file
	SI:DI = length of record
Return: AL = status
	    00h successful
	    FFh record not locked
Desc:	unlock the specified physical record but do not remove it from log
	  table
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=BCh,AH=BEh"NetWare",AH=C0h,AH=C3h,AH=D2h
----------21BE-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - CLEAR PHYSICAL RECORD
	AH = BEh
	BX = file handle
	CX:DX = starting offset within file
	SI:DI = record length in bytes
Return: AL = status
	    00h successful
	    FFh specified record not locked
Desc:	unlock the physical record and remove it from the log table
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=5Ch,AH=BCh,AH=BDh,AH=C1h,AH=C4h,AH=D4h
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
SeeAlso: AH=BCh,AH=C0h"NetWare",AH=C2h"NetWare"
----------21C0-------------------------------
INT 21 - Novell NetWare 4.6, Alloy NTNX - RELEASE RECORD (FCB)
	AH = C0h
	DS:DX -> FCB (see AH=0Fh)
	BX:CX = offset
Return: AL = error code (see AH=BCh)
Note:	unlocks record but does not remove it from log table
SeeAlso: AH=BDh,AH=BFh,AH=C1h"NetWare",AH=C3h
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
SeeAlso: AH=BEh,AH=C0h"NetWare",AH=C4h
----------21C1-------------------------------
INT 21 - VIRUS - "Solano" - ???
	AH = C1h
	???
Return: ???
SeeAlso: AH=C0h"VIRUS"
----------21C2-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - LOCK PHYSICAL RECORD SET
	AH = C2h
	AL = flags
	    bit 1: non-exclusive lock
	BP = lock timeout in timer ticks (1/18 sec) 0000h = no wait
Return: AL = status
	    00h successful
	    FEh timed out
	    FFh failed
Desc:	attempt to lock all physical records listed in the log table
Notes:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	status FFh will be retuend if one or more physical records have been
	  exclusively locked by another process
SeeAlso: AH=BFh,AH=C3h,AH=D1h
----------21C2-------------------------------
INT 21 - VIRUS - "Scott's Valley" - ???
	AH = C2h
	???
Return: ???
SeeAlso: AH=C0h"VIRUS"
----------21C3-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - RELEASE PHYSICAL RECRD SET
	AH = C3h
Desc:	unlock all currently-locked physical records in the log table, but do
	  not remove them from the table
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=BDh,AH=C0h,AH=C2h"NetWare",AH=C4h,AH=D3h
----------21C301DXF1F1-----------------------
INT 21 - VIRUS - "905"/"Backfont" - INSTALLATION CHECK
	AX = C301h
	DX = F1F1h
Return: DX = 0E0Eh if resident
SeeAlso: AH=C0h"VIRUS",AX=C500h"VIRUS"
----------21C4-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - CLEAR PHYSICAL RECORD SET
	AH = C4h
Desc:	unlock all physical records in the log table and remove them from the
	  log table
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=BEh,AH=C1h,AH=D5h
----------21C500-----------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - OPEN SEMAPHORE
	AX = C500h
	DS:DX -> semaphore name (counted string, max 127 bytes)
	CL = initial value for semaphore
Return: AL = status
	    00h successful
		BL = number of processes having semaphore open
		CX:DX = semaphore handle
	    FEh invalid name length
	    FFh invalid semaphore value
Notes:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	the semaphore's value is incremented by AX=C503h and decremented by
	  AX=C502h
SeeAlso: AX=C501h,AX=C502h,AX=C503h,AX=C504h
----------21C500-----------------------------
INT 21 - VIRUS - "Sverdlov" - INSTALLATION CHECK
	AX = C500h
Return: AX = 6731h if resident
SeeAlso: AX=C301h"VIRUS",AH=C6h"VIRUS"
----------21C501-----------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - EXAMINE SEMAPHORE
	AX = C501h
	CX:DX = semaphore handle
Return: AL = status
	    00h successful
		CX = semaphore value (-127 to 127)
		DL = count of processes which have the semaphore open
	    FFh invalid handle
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AX=C500h"NetWare",AX=C502h,AX=C504h
----------21C502-----------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - WAIT ON SEMAPHORE
	AX = C502h
	CX:DX = semaphore handle
	BP = timeout limit in timer ticks (1/18 sec)
		0000h return immediately if semaphore already zero or negative
Return: AL = status
	    00h successful
	    FEh timeout
	    FFh invalid handle
Desc:	decrement the semaphore's value, optionally waiting until its value
	  becomes positive before decrementing
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AX=C500h"NetWare",AX=C501h,AX=C503h
----------21C503-----------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - SIGNAL SEMAPHORE
	AX = C503h
	CX:DX = semaphore handle
Return: AL = status
	    00h successful
	    01h semaphore value overflowed
	    FFh invalid handle
Desc:	increment the semaphore's value and signal the first process (if any)
	  in the queue waiting on the semaphore
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AX=C500h"NetWare",AX=C502h
----------21C504-----------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - CLOSE SEMAPHORE
	AX = C504h
	CX:DX = semaphore handle
Return: AL = status
	    00h successful
	    FFh invalid handle
Desc:	decrement the semaphore's open count, and delete the semaphore if the
	  count reaches zero
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AX=C500h"NetWare",AX=C501h
----------21C6-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - GET OR SET LOCK MODE
	AH = C6h
	AL = subfunction
	    00h set old "compatibility" mode (default)
	    01h set new extended locks mode 
	    02h get lock mode
Return: AL = current lock mode
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	the locking mode should be 01h for NetWare 4.61+ and Advanced
	  NetWare 1.0+ locking calls, and 00h for all older calls
SeeAlso: AH=BCh,AH=C4h,AH=D0h
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
----------21C700-----------------------------
INT 21 - Novell NetWare - TRANSACTION TRACKING SYSTEM - BEGIN TRANSACTION
	AX = C700h
Return: CF clear if successful
	    AL = 00h
	CF set on error
	    AL = error code
		96h out of memory
		FEh implicit transaction already active, converted to explicit
		FFh explicit transaction already active
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AX=C701h,AX=C702h,AX=C703h
----------21C700-----------------------------
INT 21 - VIRUS - "MH-757" - INSTALLATION CHECK
	AX = C700h
Return: AL = 07h if resident
SeeAlso: AX=C603h"VIRUS",AH=CBh"VIRUS"
----------21C701-----------------------------
INT 21 - Novell NetWare - TRANSACTION TRACKING SYSTEM - END TRANSACTION
	AX = C701h
Return: AL = status
	    00h successful
		CX:DX = transaction number
	    FDh transaction tracking disabled
	    FEh transaction ended records locked
	    FFh no explicit transaction active
	CF clear except when AL=FFh
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AX=C700h"NetWare",AX=C703h
----------21C702-----------------------------
INT 21 - Novell NetWare - TRANSACTION TRACKING SYSTEM - INSTALLATION CHECK
	AX = C702h
Return: AL = status
	    00h not available
	    01h available
	    FDh available but disabled
Desc:	determine whether the default file server supports TTS
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
----------21C703-----------------------------
INT 21 - Novell NetWare - TRANSACTION TRACKING SYSTEM - ABORT TRANSACTION
	AX = C703h
Return: CF clear if successful
	    AL = 00h
	CF set on error
	    AL = error code
		FDh transaction tracking disabled, no backout
		FEh transaction ended records locked
		FFh no explicit transaction active
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AX=C700h"NetWare",AX=C701h,AX=C704h
----------21C704-----------------------------
INT 21 - Novell NetWare - TRANSACTION TRACKING SYSTEM - TRANSACTION STATUS
	AX = C704h
	CX:DX = transaction number (see AX=C701h)
Return: AL = status
	    00h successful
	    FFh not yet written to disk
Desc:	verify that a transaction has actually been written to disk
Notes:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
	transactions are written to disk in the order in which they are ended,
	  but it may take as much as five seconds for the data to be written
SeeAlso: AX=C700h"NetWare",AX=C701h,AX=C703h
----------21C705-----------------------------
INT 21 - Novell NetWare - TRANSACTION TRACKING SYSTEM - GET APPLICTN THRESHOLDS
	AX = C705h
Return: AL = status
	    00h successful
	CL = maximum logical record locks (default 0)
	CH = maximum physical record locks (default 0)
Desc:	get the per-application limits on record locks allowed before an
	  implicit transaction is begun
Notes:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
	if either limit is FFh, implicit transactions are disabled for the
	  corresponding lock type
SeeAlso: AX=C706h,AX=C707h
----------21C706-----------------------------
INT 21 - Novell NetWare - TRANSACTION TRACKING SYSTEM - SET APPLICTN THRESHOLDS
	AX = C706h
	CL = maximum logical record locks (default 0)
	CH = maximum physical record locks (default 0)
Return: AL = status
	    00h successful
Desc:	specify the per-application limits on record locks allowed before an
	  implicit transaction is begun
Notes:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
	if either limit is set to FFh, implicit transactions are disabled for
	  the corresponding lock type
SeeAlso: AX=C705h,AX=C708h
----------21C707-----------------------------
INT 21 - Novell NetWare - TRANSACTION TRACKING SYSTEM - GET WORKSTN THRESHOLDS
	AX = C707h
Return: AL = status
	    00h successful
	CL = maximum logical record locks (default 0)
	CH = maximum physical record locks (default 0)
Desc:	get the per-workstation limits on record locks allowed before an
	  implicit transaction is begun
Notes:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
	if either limit is FFh, implicit transactions are disabled for the
	  corresponding lock type
SeeAlso: AX=C705h,AX=C708h
----------21C708-----------------------------
INT 21 - Novell NetWare - TRANSACTION TRACKING SYSTEM - SET WORKSTN THRESHOLDS
	AX = C708h
	CL = maximum logical record locks (default 0)
	CH = maximum physical record locks (default 0)
Return: AL = status
	    00h successful
Desc:	specify the per-workstation limits on record locks allowed before an
	  implicit transaction is begun
Notes:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
	if either limit is set to FFh, implicit transactions are disabled for
	  the corresponding lock type
SeeAlso: AX=C706h,AX=C707h
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
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - LOCK FILE SET
	AH = CBh
	if function C6h lock mode 00h:
	    DL = mode
		00h no wait
		01h wait
	if function C6h lock mode 01h:
	    BP = lock timeout in timer ticks (1/18 sec) 0000h = no wait
Return: AL = status
	    00h successful
	    FEh timed out
	    FFh failed
Desc:	attempt to lock all files listed in the log table
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	status FFh will be returned if one or more of the files have already
	  been exclusively locked by another process
SeeAlso: AH=CAh,AH=CDh,AH=D1h,AH=EBh
----------21CB-------------------------------
INT 21 - VIRUS - "Milous" - INSTALLATION CHECK
	AH = CBh
Return: AL = 07h if resident
SeeAlso: AX=C700h"VIRUS",AX=CB02h
----------21CB02-----------------------------
INT 21 - VIRUS - "Witcode" - INSTALLATION CHECK
	AX = CB02h
Return: AX = 02CBh if resident
SeeAlso: AH=CBh"VIRUS",AH=CCh"VIRUS"
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
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - RELEASE FILE SET
	AH = CDh
Return: none
Desc:	unlock all files listed in the log table, but don't remove them from
	  the table
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=CBh,AH=CCh,AH=CFh,AH=D3h
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
SeeAlso: AH=CAh,AH=CFh,AH=EDh"NetWare"
----------21CF-------------------------------
INT 21 - LANstep - ???
	AH = CFh
	???
Return: ???
Note:	LANstep is a redesign of the Waterloo Microsystems PORT network
----------21CF-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - CLEAR FILE SET
	AH = CFh
Return: AL = 00h
Desc:	unlock and remove all files from log table
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=CAh,AH=CEh,AH=EBh"NetWare"
----------21D0-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - LOG LOGICAL RECORD
	AH = D0h
	DS:DX -> record string (counted string, max 99 data bytes)
	if function C6h lock mode 01h: (Novell, NTNX only)
	    AL = flags
		bit 0: lock as well as log the record
		bit 1: non-exclusive lock
	    BP = lock timeout in timer ticks (1/18 sec)
Return: AL = status
	    00h successful
	    96h no dynamic memory for file
	    FEh timed out
	    FFh unsuccessful
Desc:	add the specified logical record name to the log table, and optionally
	  lock the record
Notes:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+,
	  Banyan VINES, and Alloy NTNX
	locks on logical record names are advisory and may be ignored by other
	  applications
SeeAlso: AH=BCh,AH=D1h,AH=D2h,AH=D4h,AH=EBh
----------21D000-----------------------------
INT 21 - VIRUS - "Fellowship" - INSTALLATION CHECK
	AX = D000h
Return: BX = 1234h if resident
SeeAlso: AH=CCh"VIRUS",AH=D5h"VIRUS",AX=D5AAh
----------21D1-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - LOCK LOGICAL RECORD SET
	AH = D1h
	AL = lock type (00h exclusive, 01h shareable)
	if function C6h lock mode 00h:
	    DL = mode
		00h no wait
		01h wait
	if function C6h lock mode 01h: (Novell only)
	   BP = lock timeout in timer ticks (1/18 sec) 0000h = no wait
		0000h no wait
Return: AL = status (see AH=CBh)
Desc:	attempt to lock all logical record names listed in the log table
Notes:	this function is supported by NetWare 4.6+, Advanced Netware 1.0+,
	  Banyan VINES, and Alloy NTNX
	status FFh will be returned if one or more logical records have been
	  exclusively locked by another process
	locks on logical record names are advisory and may be ignored by other
	  applications
SeeAlso: AH=C2h,AH=CBh,AH=D0h,AH=D3h,AH=D5h
----------21D2-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - RELEASE LOGICAL RECORD
	AH = D2h
	DS:DX -> semaphore identifier (counted string up to 99 chars long)
Return: AL = status
	    00h successful
	    FFh no such record
Desc:	unlock the logical record name but do not remove it from the log table
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+,
	  Banyan VINES, and Alloy NTNX
	locks on logical record names are advisory and may be ignored by other
	  applications
SeeAlso: AH=BDh,AH=D0h,AH=D3h,AH=D4h
----------21D3-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - RELEASE LOGICAL RECORD SET
	AH = D3h
Desc:	unlock all currently-locked logical record names in the log table, but
	  do not remove them from the table
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+,
	  Banyan VINES, and Alloy NTNX
	locks on logical record names are advisory and may be ignored by other
	  applications
SeeAlso: AH=C3h,AH=CDh,AH=D1h,AH=D2h,AH=D5h
----------21D4-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - CLEAR LOGICAL RECORD
	AH = D4h
	DS:DX -> logical record name (counted string up to 99 chars long)
Return: AL = status
	    00h successful
	    FFh no such record name
Desc:	unlock and remove the logical record name from the log table
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+,
	  Banyan VINES, and Alloy NTNX
	locks on logical record names are advisory and may be ignored by other
	  applications
SeeAlso: AH=BEh,AH=D0h,AH=D2h,AH=D5h
----------21D5-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - CLEAR LOGICAL RECORD SET
	AH = D5h
Return: AL = error code (see AH=D4h)
Desc:	unlock and remove all logical record name from the log table
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+,
	  Banyan VINES, and Alloy NTNX
	locks on logical record names are advisory and may be ignored by other
	  applications
SeeAlso: AH=D1h,AH=D3h,AH=D4h
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
INT 21 - Novell NetWare - WORKSTATION - END OF JOB
	AH = D6h
	BX = job flag (0000h current job, FFFFh all processes on workstation)
Return: AL = error code
Desc:	unlocks and clears all locked or logged files and records held by the
	  process(es), closes all files, resets error and lock modes, and
	  releases all network resources
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=BBh,AH=D7h
----------21D7-------------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - SYSTEM LOGOUT
	AH = D7h
Return: AL = error code
Desc:	this function closes the caller's open files, logs it out from all
	  file servers, detaches the workstation from all non-default file
	  servers, and maps a drive to the default server's SYS:LOGIN directory
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=D6h,AH=E3h/SF=14h,AH=F1h
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
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET VOLUME INFO WITH NUMBER
	AH = DAh
	DL = volume number
	ES:DI -> reply buffer (see below)
Return: AL = 00h
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AH=36h,AH=E2h/SF=15h,AH=E3h/SF=E9h

Format of reply buffer:
Offset	Size	Description
 00h	WORD	sectors/block
 02h	WORD	total blocks on volume
 04h	WORD	unused blocks
 06h	WORD	total directory entries
 08h	WORD	unused directory entries
 0Ah 16 BYTEs	volume name, null padded
 1Ah	WORD	removable flag, 0000h = not removable
Note:	all words are big-endian
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
INT 21 - Novell NetWare - WORKSTATION - GET NUMBER OF LOCAL DRIVES
	AH = DBh
Return: AL = number of local disks as set by LASTDRIVE in CONFIG.SYS
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=0Eh
----------21DC-------------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - GET CONNECTION NUMBER
	AH = DCh
Return: AL = logical connection number
	    00h if NetWare not loaded or this machine is a non-dedicated server
	CX = station number in ASCII (CL = first digit)
Notes:	this function is supported by NetWare 4.0+, Banyan VINES, and Alloy
	  NTNX
	station number only unique for those PCs connected to same semaphore
	  service
----------21DC-------------------------------
INT 21 - PCMag PCMANAGE/DCOMPRES - TURN ON/OFF
	AH = DCh
	DX = state
	    0000h turn on
	    0001h turn off
SeeAlso: AX=FEDCh
----------21DD-------------------------------
INT 21 - Novell NetWare - WORKSTATION - SET NetWare ERROR MODE
	AH = DDh
	DL = error mode
	    00h invoke INT 24 on critical I/O errors (default)
	    01h return NetWare extended error code in AL
	    02h return error code in AL, mapped to standard DOS error codes
Return: AL = previous error mode
Note:	this function is supported by Advanced NetWare 2.0+
SeeAlso: INT 24
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
INT 21 - VIRUS - "Durban" - INSTALLATION CHECK
	AH = DEh
Return: AH = DFh if resident
SeeAlso: AX=DAFEh,AX=DEDEh"VIRUS"
----------21DE-------------------------------
INT 21 - VIRUS - "April 1st EXE" - ???
	AH = DEh
	???
Return: ???
----------21DE-------------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - SET BROADCAST MODE
	AH = DEh
	DL = broadcast mode
	    00h receive server and workstation broadcasts (default)
	    01h receive server broadcasts, discard user messages
	    02h store server broadcasts for retrieval
	    03h store all broadcasts for retrieval
Return: AL = new broadcast mode
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
----------21DE--DL04-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - GET BROADCAST MODE
	AH = DEh
	DL = 04h
Return: AL = current broadcast mode
	    00h receive server and workstation broadcasts (default)
	    01h receive server broadcasts, discard user message
	    02h store server broadcasts for retrieval
	    03h store all broadcasts for retrieval
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
----------21DE-------------------------------
INT 21 - Novell NetWare 4.0 - SHELL TIMER INTERRUPT CHECKS
	AH = DEh
	DL = function
	    05h disable shell timer interrupt checks
	    06h enable shell timer interrupt checks
Return: ???
----------21DEDE-----------------------------
INT 21 - VIRUS - "Brothers" - INSTALLATION CHECK
	AX = DEDEh
Return: AH = 41h if resident
SeeAlso: AH=DEh"VIRUS",AH=E0h"VIRUS"
----------21DF--DL00-------------------------
INT 21 - Novell NetWare - PRINT SERVICES - START LPT CAPTURE
	AH = DFh
	DL = 00h
Return: AL = status
	    00h successful
Desc:	this function redirects the default LPT to a capture file on the file
	  server
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX; under NTNX, it sends a print break (see INT 17/AH=84h)
	a print job is queued when the first character of output is captured
SeeAlso: AX=B800h,AX=B804h,AH=DFh/DL=01h,AH=DFh/DL=02h,AH=DFh/DL=03h
SeeAlso: AH=DFh/DL=04h,AX=F003h
----------21DF--DL01-------------------------
INT 21 - Novell NetWare - PRINT SERVICES - END LPT CAPTURE
	AH = DFh
	DL = 01h
Return: AL = status
	    00h successful
Desc:	stop redirecting the default LPT, close the capture file, and release
	  the job in the print queue for printing
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX; under NTNX, it sends a print break (see INT 17/AH=84h)
	after this call, the default LPT defaults to local printing
SeeAlso: AH=DFh/DL=00h,AH=DFh/DL=02h,AH=DFh/DL=03h,AH=DFh/DL=05h
----------21DF--DL02-------------------------
INT 21 - Novell NetWare - PRINT SERVICES - CANCEL LPT CAPTURE
	AH = DFh
	DL = 02h
Return: AL = status
	    00h successful
Desc:	this function ends the capture of the default LPT, removes the job from
	  the print queue, and deletes the capture file unless it is a
	  permanent capture file
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX; under NTNX, it sends a print break (see INT 17/AH=84h)
	after this call, the default LPT defaults to local printing
SeeAlso: AH=DFh/DL=00h,AH=DFh/DL=06h
----------21DF--DL02-------------------------
INT 21 - Novell NetWare - PRINT SERVICES - FLUSH LPT CAPTURE
	AH = DFh
	DL = 03h
Return: AL = status
	    00h successful
Desc:	this function closes the current capture file for the default LPT
	  and starts printing it if it is not a permanent capture file
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX; under NTNX, it sends a print break (see INT 17/AH=84h)
	if more data is sent to the LPT port after this call, a new capture
	  file will be opeend
SeeAlso: AH=DFh/DL=00h,AH=DFh/DL=01h,AH=DFh/DL=02h,AH=DFh/DL=07h
----------21DF--DL04-------------------------
INT 21 - Novell NetWare - PRINT SERVICES - START SPECIFIC LPT CAPTURE
	AH = DFh
	DL = 04h
	DH = LPT port (00h-02h)
Return: AL = status
	    00h successful
Desc:	this function redirects the specified LPT to a capture file on the file
	  server
Notes:	this function is supported by Advanced NetWare 2.1+
	a print job is queued when the first character of output is captured
SeeAlso: AX=B800h,AH=DFh/DL=00h,AH=DFh/DL=05h,AH=DFh/DL=06h,AH=DFh/DL=07h
SeeAlso: AX=F003h
----------21DF--DL05-------------------------
INT 21 - Novell NetWare - PRINT SERVICES - END SPECIFIC LPT CAPTURE
	AH = DFh
	DL = 05h
	DH = LPT port (00h-02h)
Return: AL = status
	    00h successful
Desc:	stop redirecting the specified LPT, close the capture file, and release
	  the job in the print queue for printing
Notes:	this function is supported by Advanced NetWare 2.1+
	after this call, the specified LPT defaults to local printing
SeeAlso: AH=DFh/DL=01h,AH=DFh/DL=04h,AH=DFh/DL=06h,AH=DFh/DL=07h
----------21DF--DL06-------------------------
INT 21 - Novell NetWare - PRINT SERVICES - CANCEL SPECIFIC LPT CAPTURE
	AH = DFh
	DL = 06h
	DH = LPT port (00h-02h)
Return: AL = status
	    00h successful
Desc:	this function ends the capture of the specified LPT, removes the job
	  from the print queue, and deletes the capture file unless it is a
	  permanent capture file
Notes:	this function is supported by Advanced NetWare 2.1+
	after this call, the specified LPT defaults to local printing
SeeAlso: AH=DFh/DL=02h,AH=DFh/DL=04h,AH=DFh/DL=05h,AH=DFh/DL=07h
----------21DF--DL07-------------------------
INT 21 - Novell NetWare - PRINT SERVICES - FLUSH SPECIFIC LPT CAPTURE
	AH = DFh
	DL = 07h
	DH = LPT port (00h-02h)
Return: AL = status
	    00h successful
Desc:	this function closes the current capture file for the specified LPT
	  and starts printing it if it is not a permanent capture file
Notes:	this function is supported by Advanced NetWare 2.1+
	if more data is sent to the LPT port after this call, a new capture
	  file will be opeend
SeeAlso: AH=DFh/DL=03h,AH=DFh/DL=04h,AH=DFh/DL=05h,AH=DFh/DL=06h
----------21E0-------------------------------
INT 21 - Digital Research DOS Plus - CALL BDOS
	AH = E0h
	CL = BDOS function number (see INT E0"CP/M")
	other registers as appropriate for function
Return: as appropriate for function
SeeAlso: AX=4459h,INT E0"CP/M"
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
Return: AL = status
----------21E0--SF06-------------------------
INT 21 - Novell NetWare - PRINT SERVICES - GET PRINTER STATUS
	AH = E0h subfn 06h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    FFh no such printer
Desc:	get current state of specified printer attached to the server
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	06h (subfunction "Get Printer Status")
 03h	BYTE	printer number (00h-04h)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0004h (size of following results buffer)
 02h	BYTE	flag: 00h printer active, FFh printer halted
 03h	BYTE	flag: 00h printer online, 01h printer offline
 04h	BYTE	current form type
 05h	BYTE	target printer number (00h-04h)
		same as number in request buffer unless rerouted by server
		console
----------21E0--SF09-------------------------
INT 21 - Novell NetWare - PRINT SERVICES - SPECIFY CAPTURE FILE
	AH = E0h subfn 09h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    9Ch invalid path
Desc:	create a permanent capture file for the next print capture to be
	  started
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	the caller must have read, write, and create rights for the directory
	  containing the capture file

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 102h)
 02h	BYTE	09h (subfunction "Specify Capture File")
 03h	BYTE	directory handle or 00h
 04h	BYTE	length of filename
 05h  N BYTEs	name of capture file

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E00F-----------------------------
INT 21 - VIRUS - "8-tunes" - INSTALLATION CHECK
	AX = E00Fh
Return: AX = 4C31h if resident
SeeAlso: AH=E0h"VIRUS",AH=E1h"VIRUS"
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
----------21E1--SF00-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - SEND BROADCAST MESSAGE
	AH = E1h subfn 00h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    FEh I/O error or out of dynamic workspace
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AH=DEh"NetWare",AH=DEh/DL=04h,AH=E1h/SF=01h,AH=E1h/SF=04h
SeeAlso: AH=E1h/SF=09h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 9Eh)
 02h	BYTE	00h (subfunction "Send Broadcast Message")
 03h	BYTE	number of connections (01h-64h)
 04h  N BYTEs	list of connections to receive broadcast message
	BYTE	length of message (01h-37h)
      N BYTEs	broadcast message (no control characters or characters > 7Eh)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results buffer (max 65h)
 02h	BYTE	number of connections
 03h  N BYTEs	list of per-connection results
		00h successful
		FCh message rejected due to lack of buffer space
		FDh invalid connection number
		FFh blocked (see also AH=E1h/SF=02h)
----------21E1--SF01-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - GET BROADCAST MESSAGE
	AH = E1h subfn 01h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    FCh full message queue
	    FEh out of dynamic workspace
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AH=DEh/DL=04h,AH=E1h/SF=00h,AH=E1h/SF=05h,AH=E1h/SF=09h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	01h (subfunction "Get Broadcast Message")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results buffer (max 38h)
 02h	BYTE	length of message (00h-37h)
		00h if no broadcast messages pending
 03h  N BYTEs	message (no control characters or characters > 7Eh)
----------21E1-------------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - ENABLE/DISABLE BROADCAST MESSAGES
	AH = E1h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer
Return: AL = error code
Note:	these functions are supported by NetWare 4.0+ but are not listed in
	  _NetWare_System_Calls--DOS_; they may be obsolete
SeeAlso: AH=E1h/SF=00h,AH=E1h/SF=04h,AH=E1h/SF=09h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 9Eh)
 02h	BYTE	subfunction
		02h disable station broadcasts
		03h enable station broadcasts
 03h	???

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results buffer
 02h	???
----------21E1--SF04-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - SEND PERSONAL MESSAGE
	AH = E1h subfn 04h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    FEh I/O error or out of dynamic workspace
Notes:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
	message pipes use CPU time on the file server; IPX, SPX, or NetBIOS
	  connections should be used for peer-to-peer communications as these
	  protocols do not use file server time
SeeAlso: AH=E1h/SF=00h,AH=E1h/SF=05h,AH=E1h/SF=06h,AH=E1h/SF=08h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max E5h)
 02h	BYTE	04h (subfunction "Send Personal Message")
 03h	BYTE	number of connections (01h-64h)
 04h  N BYTEs	list of connections to receive broadcast message
	BYTE	length of message (01h-7Eh)
      N BYTEs	message (no control characters or characters > 7Eh)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results buffer (max 65h)
 02h	BYTE	number of connections
 03h  N BYTEs	list of per-connection results
		00h successful
		FCh message rejected because queue is full (contains 6 msgs)
		FDh incomplete pipe
		FFh failed
----------21E1--SF05-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - GET PERSONAL MESSAGE
	AH = E1h subfn 05h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    FEh out of dynamic workspace
Desc:	return the oldest message in the default file server's message queue
	  for the calling workstation
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AH=E1h/SF=01h,AH=E1h/SF=04h,AH=E1h/SF=06h,AH=E1h/SF=08h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	05h (subfunction "Get Personal Message")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results buffer (max 80h)
 02h	BYTE	connection number of sending station
 03h	BYTE	length of message (00h-7Eh)
		00h if no personal messages pending
 04h  N BYTEs	message (no control characters or characters > 7Eh)
----------21E1--SF06-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - OPEN MESSAGE PIPE
	AH = E1h subfn 06h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    FEh out of dynamic workspace
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AH=E1h/SF=04h,AH=E1h/SF=07h,AH=E1h/SF=08h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 66h)
 02h	BYTE	06h (subfunction "Open Message Pipe")
 03h	BYTE	number of pipes to open (01h-64h)
 04h  N BYTEs	list of connection numbers

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results buffer (max 65h)
 02h	BYTE	number of connections
 03h  N BYTEs	list of results
		00h successful
		FEh incomplete (target half not yet created)
		FFh failed
----------21E1--SF07-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - CLOSE MESSAGE PIPE
	AH = E1h subfn 07h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    FCh full message queue
	    FEh out of dynamic workspace
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AH=E1h/SF=05h,AH=E1h/SF=06h,AH=E1h/SF=08h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 66h)
 02h	BYTE	07h (subfunction "Close Message Pipe")
 03h	BYTE	number of pipes to close (01h-64h)
 04h  N BYTEs	list of connection numbers

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results buffer (max 65h)
 02h	BYTE	number of connections
 03h  N BYTEs	list of results
		00h successful
		FDh failed
		FFh no such pipe
----------21E1--SF08-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - CHECK PIPE STATUS
	AH = E1h subfn 08h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    FCh full message queue
	    FEh out of dynamic workspace
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AH=E1h/SF=05h,AH=E1h/SF=06h,AH=E1h/SF=07h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 66h)
 02h	BYTE	08h (subfunction "Check Pipe Status")
 03h	BYTE	number of pipes to monitor (01h-64h)
 04h  N BYTEs	list of connection numbers

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results buffer (max 65h)
 02h	BYTE	number of connections
 03h  N BYTEs	list of pipe statuses
		00h open
		FEh incomplete
		FFh closed
----------21E1--SF09-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - BROADCAST TO CONSOLE
	AH = E1h subfn 09h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    FCh full message queue
	    FEh out of dynamic workspace
Desc:	send a one-line message to the system console on the default file
	  server
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AH=DEh/DL=04h,AH=E1h/SF=00h,AH=E1h/SF=01h,AH=E3h/SF=D1h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 3Eh)
 02h	BYTE	09h (subfunction "Broadcast to Console")
 03h	BYTE	length of message (01h-3Ch)
 04h  N BYTEs	message (no control characters or characters > 7Eh)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
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
----------21E2--SF00-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - SET DIRECTORY HANDLE
	AH = E2h subfn 00h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,98h,9Bh,9Ch) (see below)
Desc:	set the target handle to reference the directory specified by the
	  source handle and the source path; both handles must refer to the
	  same file server
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	the target handle is not changed if this function fails
SeeAlso: AH=E2h/SF=01h,AH=E2h/SF=12h,AH=E2h/SF=13h

Values for status:
 00h	successful
 84h	not permitted to create
 8Ah	not permitted to delete
 8Bh	not permitted to rename
 8Ch	not permitted to modify
 98h	nonexistent volume
 9Bh	invalid directory handle
 9Ch	invalid path
 9Eh	invalid filename
 9Fh	directory currently in use
 A0h	directory not empty
 FCh	no such bindery object

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 103h)
 02h	BYTE	00h (subfunction "Set Directory Handle")
 03h	BYTE	directory handle of target
 04h	BYTE	directory handle of source
 05h	BYTE	length of source directory path (01h-FFh)
 06h  N BYTEs	source directory path

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E2--SF01-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET DIRECTORY PATH
	AH = E2h subfn 01h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,9Bh) (see AH=E2h/SF=00h)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=02h,AH=E2h/SF=03h,AH=E2h/SF=1Ah,AH=E9h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	01h (subfunction "Get Directory Path")
 03h	BYTE	directory handle

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) length of following data buffer
 02h	BYTE	length of directory path (01h-FFh)
 03h  N BYTEs	full directory path including volume
----------21E2--SF02-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - SCAN DIRECTORY INFORMATION
	AH = E2h subfn 02h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,98h,9Bh,9Ch) (see AH=E2h/SF=00h)
Desc:	get information about the first or next subdirectory of the specified
	  directory
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=01h,AH=E2h/SF=03h,AH=E2h/SF=19h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 104h)
 02h	BYTE	02h (subfunction "Scan Directory Information")
 03h	BYTE	directory handle
 04h	WORD	subdirectory number (big-endian)
		0000h for first call, returned subdir number + 1 on next call
 06h	BYTE	length of directory path
 07h  N BYTEs	directory path

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 001Ch (length of following data buffer)
 02h 16 BYTEs	subdirectory name
 12h	DWORD	date and time of creation (big-endian) (see below)
 16h	DWORD	object ID of owner (bid-endian)
 1Ah	BYTE	maximum directory rights (see AH=E2h/SF=03h)
 1Bh	BYTE	unused
 1Ch	WORD	subdirectory number (big-endian)

Bitmask of date and time:
 bits 31-25: year-1980
 bits 24-21: month
 bits 20-16: day
 bits 15-11: hour
 bits 10-5: minute
 bits 4-0: second
----------21E2--SF03-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET EFFECTIVE DIRECTORY RIGHTS
	AH = E2h subfn 03h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,98h,9Bh) (see AH=E2h/SF=00h)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=01h,AH=E2h/SF=02h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 102h)
 02h	BYTE	03h (subfunction "Get Effective Directory Rights")
 03h	BYTE	directory handle
 04h	BYTE	length of directory path (00h-FFh)
 05h  N BYTEs	directory path

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0001h (length of following data buffer)
 02h	BYTE	effective directory rights (see below)

Bitmask of directory rights:
 bit 0: reading allowed
 bit 1: writing allowed
 bit 2: opens allowed
 bit 3: file creation allowed
 bit 4: deletion allowed
 bit 5: "parental" may create/delete subdirectories and
	grant/revoke trustee rights
 bit 6: directory search allowed
 bit 7: file attributes may be changed
----------21E2--SF04-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - MODIFY MAXIMUM RIGHTS MASK
	AH = E2h subfn 04h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,8Ch,98h,9Ch) (see AH=E2h/SF=00h)
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=03h,AH=E2h/SF=0Ah,AH=E2h/SF=0Dh

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 104h)
 02h	BYTE	04h (subfunction "Modify Maximum Rights Mask")
 03h	BYTE	directory handle
 04h	BYTE	rights to grant (see AH=E2h/SF=03h)
 05h	BYTE	rights to revoke (see AH=E2h/SF=03h)
 06h	BYTE	length of directory path (00h-FFh)
 07h  N BYTEs	directory path
Note:	the rights specified at offset 05h are revoked first, and then the
	  rights specified at offset 04h are added to the resulting rights
	  mask

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E2--SF05-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET VOLUME NUMBER
	AH = E2h subfn 05h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,98h) (see AH=E2h/SF=00h)
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=DAh,AH=E2h/SF=02h,AH=E2h/SF=05h,AH=E2h/SF=15h,AH=E3h/SF=E9h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 12h)
 02h	BYTE	05h (subfunction "Get Volume Number")
 03h	BYTE	length of volume name (01h-10h)
 04h  N BYTEs	volume name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0001h (length of following results buffer)
 02h	BYTE	volume number
----------21E2--SF06-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET VOLUME NAME
	AH = E2h subfn 06h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,98h) (see AH=E2h/SF=00h)
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=DAh,AH=E2h/SF=02h,AH=E2h/SF=05h,AH=E2h/SF=15h,AH=E2h/SF=1Ah
SeeAlso: AH=E3h/SF=E9h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	06h (subfunction "Get Volume Name")
 03h	BYTE	volume number

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0011h (length of following results buffer)
 02h	BYTE	length of volume name
 03h 16 BYTEs	NUL-padded volume name
----------21E2--SF0A-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - CREATE DIRECTORY
	AH = E2h subfn 0Ah
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,84h,98h,FCh) (see AH=E2h/SF=00h)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=39h,AH=E2h/SF=0Bh,AH=E2h/SF=0Fh

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 103h)
 02h	BYTE	0Ah (subfunction "Create Directory")
 03h	BYTE	directory handle
 04h	BYTE	maximum directory rights (see AH=E2h/SF=01h)
 05h	BYTE	length of directory path (00h-FFh)
 06h  N BYTEs	directory path

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E2--SF0B-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - DELETE DIRECTORY
	AH = E2h subfn 0Bh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,8Ah,98h,9Bh,9Ch,9Fh,A0h) (see AH=E2h/SF=00h)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=3Ah,AH=E2h/SF=0Ah,AH=E2h/SF=0Fh

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 103h)
 02h	BYTE	0Bh (subfunction "Delete Directory")
 03h	BYTE	directory handle
 04h	BYTE	unused
 05h	BYTE	length of directory path (00h-FFh)
 06h  N BYTEs	directory path

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E2--SF0C-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - SCAN DIRECTORY FOR TRUSTEES
	AH = E2h subfn 0Ch
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    9Ch no more trustees
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E2h/SF=0Dh,AH=E2h/SF=0Eh,AH=E3h/SF=47h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 103h)
 02h	BYTE	0Ch (subfunction "Scan Directory For Trustees")
 03h	BYTE	directory handle
 04h	BYTE	sequence number
		00h on first call, increment for each subsequent call
 05h	BYTE	length of directory path (00h-FFh)
 06h  N BYTEs	directory path

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0031h (length of following results buffer)
 02h 16 BYTEs	directory name
 12h  4 BYTEs	date and time of creation
 16h	DWORD	object ID of owner (big-endian)
 1Ah  5 DWORDs	object IDs of Trustees 0 through 4 (big-endian)
		00000000h = end of group
 2Eh  5 BYTEs	directory rights for Trustees 0 through 4 (see AH=E2h/SF=03h)
----------21E2--SF0D-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - ADD TRUSTEE TO DIRECTORY
	AH = E2h subfn 0Dh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,8Ch,FCh) (see AH=E2h/SF=00h)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=0Ch,AH=E2h/SF=0Eh,AH=E3h/SF=47h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 107h)
 02h	BYTE	0Dh (subfunction "Add Trustee To Directory")
 03h	BYTE	directory handle
 04h	DWORD	object ID of trustee (big-endian)
 08h	BYTE	trustee directory rights (see AH=E2h/SF=01h)
 09h	BYTE	length of directory path (00h-FFh)
 0Ah  N BYTEs	directory path

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E2--SF0E-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - DELETE TRUSTEE FROM DIRECTORY
	AH = E2h subfn 0Eh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,98h,9Bh,9Ch) (see AH=E2h/SF=00h)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=0Ch,AH=E2h/SF=0Dh

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 107h)
 02h	BYTE	0Eh (subfunction "Delete Trustee From Directory")
 03h	BYTE	directory handle
 04h	DWORD	object ID of trustee (big-endian)
 08h	BYTE	unused
 09h	BYTE	length of directory path (00h-FFh)
 0Ah  N BYTEs	directory path

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E2--SF0F-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - RENAME DIRECTORY
	AH = E2h subfn 0Fh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,8Bh,9Bh,9Ch,9Eh) (see AH=E2h/SF=00h)
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	directories SYS:LOGIN, SYS:MAIL, and SYS:PUBLIC must not be renamed
SeeAlso: AH=56h,AH=E2h/SF=0Ah,AH=E2h/SF=0Bh

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 111h)
 02h	BYTE	0Fh (subfunction "Rename Directory")
 03h	BYTE	directory handle
 04h	BYTE	length of directory path (00h-FFh)
 05h  N BYTEs	directory path
	BYTE	length of new directory name (01h-0Eh)
      N BYTEs	new directory name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E2--SF10-------------------------
INT 21 - Novell NetWare - FILE SERVICES - PURGE ERASED FILES
	AH = E2h subfn 10h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	purges files marked for deletion on the file server by the calling
	  workstation
SeeAlso: AH=13h,AH=41h,AH=E2h/SF=11h,AH=E3h/SF=CEh,AX=F244h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	10h (subfunction "Purge Erased Files")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E2--SF11-------------------------
INT 21 - Novell NetWare - FILE SERVICES - RESTORE ERASED FILE
	AH = E2h subfn 11h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    98h nonexistent volume
	    FFh no more erased files
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	restores one file marked for deletion which has not yet been purged
SeeAlso: AH=13h,AH=41h,AH=E2h/SF=10h,AH=E3h/SF=CEh,AX=F244h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 13h)
 02h	BYTE	11h (subfunction "Restore Erased File")
 03h	BYTE	directory handle or 00h
 04h	BYTE	length of volume name
 05h  N BYTEs	volume name (including colon)
Note:	if both a directory handle and a volume name are specified, the volume
	  name overrides the handle

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 001Eh (size of following results buffer)
 02h 15 BYTEs	ASCIZ name of erased file
 11h 15 BYTEs	ASCIZ name under which file was restored
----------21E2--SF12-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - ALLOC PERMANENT DIRECTORY HANDLE
	AH = E2h subfn 12h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,98h,9Ch) (see AH=E2h/SF=00h)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=00h,AH=E2h/SF=13h,AH=E2h/SF=14h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 103h)
 02h	BYTE	12h (subfunction "Alloc Permanent Directory Handle")
 03h	BYTE	directory handle
 04h	BYTE	drive ('A'-'Z')
 05h	BYTE	length of directory path
 06h  N BYTEs	directory path

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0002h (size of following results buffer)
 02h	BYTE	new directory handle
 03h	BYTE	effective directory rights (see AH=E2h/SF=01h)
----------21E2--SF13-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - ALLOC TEMPORARY DIRECTORY HANDLE
	AH = E2h subfn 13h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see AH=E2h/SF=12h)
Return: AL = status (00h,98h,9Ch) (see AH=E2h/SF=00h)
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	this call is the same as AH=E2h/SF=12h except that the directory handle
	  will be automatically deallocated when the calling application
	  executes an End of Job call (AH=D6h) or terminates
SeeAlso: AH=D6h,AH=E2h/SF=00h,AH=E2h/SF=12h,AH=E2h/SF=14h,AH=E2h/SF=16h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 103h)
 02h	BYTE	13h (subfunction "Alloc Temporary Directory Handle")
 03h	BYTE	directory handle
 04h	BYTE	drive ('A'-'Z')
 05h	BYTE	length of directory path
 06h  N BYTEs	directory path
----------21E2--SF14-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - DEALLOCATE DIRECTORY HANDLE
	AH = E2h subfn 14h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,9Bh) (see AH=E2h/SF=00h)
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=12h,AH=E2h/SF=13h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	14h (subfunction "Deallocate Directory Handle")
 03h	BYTE	directory handle

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no returned data)
----------21E2--SF15-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET VOLUME INFO WITH HANDLE
	AH = E2h subfn 15h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=DAh,AH=E2h/SF=02h,AH=E2h/SF=06h,AH=E2h/SF=19h,AH=E3h/SF=E9h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	15h (subfunction "Get Volume Info With Handle")
 03h	BYTE	directory handle

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 001Ch (length of following results buffer)
 02h	WORD	sectors per block (big-endian)
 04h	WORD	total blocks on volume (big-endian)
 06h	WORD	blocks available on volume (big-endian)
 08h	WORD	total directory slots  (big-endian)
 0Ah	WORD	directory slots available (big-endian)
 0Ch 16 BYTEs	NUL-padded volume name
 1Ch	WORD	flag: volume removable if nonzero (big-endian)
----------21E2--SF16-------------------------
INT 21 u - Novell NetWare - DIRECTORY SERVICES - ALLOC SPECIAL TEMP DIR HANDLE
	AH = E2h subfn 16h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer
Return: AL = status
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX,
	  but is not described in _NetWare_System_Calls--DOS_
SeeAlso: AH=E2h/SF=13h,AH=E2h/SF=14h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data
 02h	BYTE	16h (subfunction "Allocate Special Temporary Directory Handle")
	???
----------21E2--SF17-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - SAVE DIRECTORY HANDLE
	AH = E2h subfn 17h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    else network error code
Note:	this function is supported by Advanced NetWare 2.0+ and Alloy NTNX
SeeAlso: AH=E2h/SF=12h,AH=E2h/SF=17h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	18h (subfunction "Restore Directory Handle")
 03h	BYTE	directory handle

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0010h (length of following results buffer)
 02h 16	BYTEs	save buffer
----------21E2--SF18-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - RESTORE DIRECTORY HANDLE
	AH = E2h subfn 18h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    else network error code
Desc:	restore a previously saved directory handle to reproduce an executing
	  environment, possibly on a different execution site
Note:	this function is supported by Advanced NetWare 2.0+ and Alloy NTNX
SeeAlso: AH=E2h/SF=12h,AH=E2h/SF=17h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0011h (length of following data)
 02h	BYTE	18h (subfunction "Restore Directory Handle")
 03h 16 BYTEs	save buffer

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0002h (length of following results buffer)
 02h	BYTE	new directory handle
 03h	BYTE	effective rights (see AH=E2h/SF=03h)
----------21E2--SF19-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - SET DIRECTORY INFORMATION
	AH = E2h subfn 19h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,9Bh,9Ch) (see AH=E2h/SF=00h)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E2h/SF=02h,AH=E2h/SF=0Fh

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 10Bh)
 02h	BYTE	19h (subfunction "Set Directory Information")
 03h	BYTE	directory handle
 04h	DWORD	date and time of creation (big-endian)
 08h	DWORD	object ID of owner (big-endian)
 0Ch	BYTE	maximum directory rightes (see AH=E2h/SF=03h)
 0Dh	BYTE	length of directory path
 0Eh  N BYTEs	directory path

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E2--SF1A-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET PATH FROM DIRECTORY ENTRY
	AH = E2h subfn 1Ah
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=01h,AH=E2h/SF=06h,AH=E3h/SF=D7h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0004h (length of following data)
 02h	BYTE	1Ah (subfunction "Get Path From Directory Entry")
 03h	BYTE	volume number (00h-1Fh)
 04h	WORD	directory entry number (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results record (max 200h)
 02h 256 BYTEs	path
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
----------21E3-------------------------------
INT 21 - Novell NetWare - CONNECTION CONTROL
	AH = E3h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    else error code
Note:	supported by NetWare 4.0+, Advanced NetWare 1.0+, and Alloy NTNX
SeeAlso: AH=E3h/SF=0Ah,AH=E3h/SF=32h,AH=E3h/SF=64h,AH=E3h/SF=C8h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data
 02h	BYTE	subfunction number
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
	var	depends on subfunction
Notes:	the above subfunctions are not described in _NetWare_System_Calls--DOS_
	see separate entries below for other subfunctions

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) length of following buffer space for results
	var	depends on subfunction

Format of object property:
Offset	Size	Description
 00h 1-16 BYTEs	property name
  N	BYTE	flags
		bit 0: property is dynamic
		bit 1: property is a set rather than an item
 N+1	BYTE	security levels (see below)
	???

Names of well-known properties:
 ACCOUNT_BALANCE
 ACCOUNT_SERVERS
 GROUP_MEMBERS
 GROUPS_I'M_IN
 IDENTIFICATION		user's name
 LOGIN_CONTROL
 NET_ADDRESS
 OPERATORS
 PASSWORD
 SECURITY_EQUALS

Values for security levels:
 00h	"anyone" everyone may access
 01h	"logged" only logged-in clients may access
 02h	"object" only clients logged-in with object's name, type, and password
 03h	"supervisor" only clients logged-in with supervisor privileges
 04h	"NetWare" only NetWare may access
Note:	the above values are stored in a nybble; the high half-byte is write
	  access and the low half-byte is read access

Values for object type:
 0000h	unknown
 0001h	user
 0002h	user group
 0003h	print queue
 0004h	file server
 0005h	job server
 0006h	gateway
 0007h	print server
 0008h	archive queue
 0009h	archive server
 000Ah	job queue
 000Bh	administration
 0026h	remote bridge server
 0047h	advertising print server
 0048h-8000h reserved
 FFFFh	wild (used only for finding objects)
----------21E3--SF0A-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - ENTER LOGIN AREA
	AH = E3h subfn 0Ah
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Desc:	change the login directory for the calling workstation
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=D7h,AH=E3h/SF=14h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 102h)
 02h	BYTE	0Ah (subfunction "Enter Login Area")
 03h	BYTE	number of local drives
 04h	BYTE	length of subdirectory name (00h-FFh)
 05h  N BYTEs	name of subdirectory under SYS:LOGIN where to find the login
		utility

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF0D-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - LOG NETWORK MESSAGE
	AH = E3h subfn 0Dh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Desc:	append a line to the default file server's NET$LOG.MSG file
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E1h/SF=09h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 52h)
 02h	BYTE	0Dh (subfunction "Log Network Message")
 03h	BYTE	length of message (01h-50h)
 04h  N BYTEs	message (no control characters or characters > 7Eh)
----------21E3--SF0E-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET DISK UTILIZATION
	AH = E3h subfn 0Eh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    98h nonexistent volume
	    F2h not permitted to read object
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must have bindery object read privileges
SeeAlso: AH=E3h/SF=11h,AH=E3h/SF=D6h,AH=E3h/SF=D9h,AH=E3h/SF=E6h,AH=E3h/SF=E9h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0005h (length of following data)
 02h	BYTE	0Eh (subfunction "Get Disk Utilization")
 03h	BYTE	volume number (00h-1Fh)
 04h	DWORD	object ID (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 000Bh (size of following results buffer)
 02h	BYTE	volume number (00h-1Fh)
 03h	DWORD	object ID (big-endian)
 07h	WORD	directories used by object (big-endian)
 09h	WORD	files created by object (big-endian)
 0Bh	WORD	disk blocks used by object-created files (big-endian)
----------21E3--SF0F-------------------------
INT 21 - Novell NetWare - FILE SERVICES - SCAN FILE INFORMATION
	AH = E3h subfn 0Fh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    89h not permitted to search directory
	    FFh no more matching files
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=B6h,AH=E3h/SF=10h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 105h)
 02h	BYTE	0Fh (subfunction "Scan File Information")
 03h	WORD	sequence number (big-endian)
		FFFFh on first call
 05h	BYTE	directory handle or 00h
 06h	BYTE	search attributes (see AX=4301h)
 07h	BYTE	length of filespec
 08h  N BYTEs	ASCIZ uppercase filespec

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 005Eh (size of following results buffer)
 02h	WORD	next sequence number (place in request buffer for next call)
 04h 15 BYTEs	ASCIZ filename
 13h	BYTE	file attributes (see AX=4301h for format)
 14h	BYTE	extended file attributes (see AH=B6h for format)
 15h	DWORD	file size in bytes (big-endian)
 19h	WORD	file's creation date (big-endian) (see AX=5700h for format)
 1Bh	WORD	date of last access (big-endian) (see AX=5700h for format)
 1Dh	DWORD	date and time of last update (big-endian) (see AH=E2h/SF=02h)
 21h	DWORD	object ID of owner (big-endian)
 25h	DWORD	date and time last archived (big-endian) (see AH=E2h/SF=02h)
 29h 55 BYTEs	reserved
----------21E3--SF10-------------------------
INT 21 - Novell NetWare - FILE SERVICES - SET FILE INFORMATION
	AH = E3h subfn 10h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the caller must have modify privileges on the directory containing the
	  file
SeeAlso: AH=B6h,AH=E3h/SF=0Fh

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 151h)
 02h	BYTE	10h (subfunction "Set File Information")
 03h	BYTE	file attributes (see AX=4301h for format)
 04h	BYTE	extended file attributes (see AH=B6h for format)
 05h  4 BYTEs	reserved
 09h	WORD	file's creation date (big-endian) (see AX=5700h for format) 
 0Bh	WORD	date of last access (big-endian) (see AX=5700h for format)
 0Dh	DWORD	date and time of last update (big-endian) (see AH=E2h/SF=02h)
 11h	DWORD	object ID of owner (big-endian)
 15h	DWORD	date and time last archived (big-endian) (see AH=E2h/SF=02h)
 19h 56 BYTEs	reserved
 51h	BYTE	directory handle or 00h
 52h	BYTE	search attributes (see AX=4301h for format)
 53h	BYTE	length of filename
 54h  N BYTEs	filename
Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF11-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER INFORMATION
	AH = E3h subfn 11h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=0Eh,AH=E3h/SF=CDh,AH=E3h/SF=D3h,AH=E3h/SF=E7h,AH=E7h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	11h (subfunction "Get File Server Information")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0080h (size of following results buffer)
 02h 48 BYTEs	server's name
 32h	BYTE	NetWare version
 33h	BYTE	NetWare subversion (0-99)
 34h	WORD	number of connections supported (big-endian)
 36h	WORD	number of connections in use (big-endian)
 38h	WORD	maximum connected volumes (big-endian)
---Advanced NetWare 2.1+ ---
 3Ah	BYTE	operating system revision number
 3Bh	BYTE	fault tolerance (SFT) level
 3Ch	BYTE	TTS level
 3Dh	WORD	maximum simultaneously-used connections (big-endian)
 3Fh	BYTE	accounting version
 40h	BYTE	VAP version
 41h	BYTE	queueing version
 42h	BYTE	print server version
 43h	BYTE	virtual console version
 44h	BYTE	security restrictions level
 45h	BYTE	internetwork bridge version
 46h 60 BYTEs	reserved
----------21E3--SF13-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - GET INTERNET ADDRESS
	AH = E3h subfn 13h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=DCh"NetWare",AH=E3h/SF=16h,AH=EEh"NetWare"

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	13h (subfunction "Get Internet Address")
 03h	BYTE	logical connection number (01h-64h)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 000Ch (length of following results buffer)
 02h  4 BYTEs	network number
 06h  6 BYTEs	physical node address
 0Ch  2 BYTEs	socket number
----------21E3--SF14-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - LOGIN TO FILE SERVER
	AH = E3h subfn 14h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Desc:	this function retrieves a list indicating the connection numbers under
	  which a bindery object is logged into the default file server
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=D7h"NetWare",AH=F1h"NetWare"

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max B3h)
 02h	BYTE	14h (subfunction "Login To File Server")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
	BYTE	length of password
      N BYTEs	password

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF15-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - GET OBJECT CONNECTION NUMBERS
	AH = E3h subfn 15h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Desc:	this function retrieves a list indicating the connection numbers under
	  which a bindery object is logged into the default file server
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=DCh"NetWare",AH=E3h/SF=16h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 33h)
 02h	BYTE	15h (subfunction "Get Object Connection Numbers")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) length of following results buffer (max 65h)
 02h	BYTE	number of connections
 03h  N BYTEs	connection list
----------21E3--SF16-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - GET CONNECTION INFORMATION
	AH = E3h subfn 16h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=D7h,AH=DCh"NetWare",AH=E3h/SF=14h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	16h (subfunction "Get Connection Information")
 03h	BYTE	logical connection number (01h-64h)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 003Dh (length of following results buffer)
 02h	DWORD	object ID for object logged in on the connection (big-endian)
		00000000h if no object logged in
 06h	WORD	type of object (big-endian)
 08h 48 BYTEs	name of object
 38h  7 BYTEs	login time (see below)

Format of login time:
Offset	Size	Description
 00h	BYTE	year (80-99 = 1980-1999, 00-79 = 2000-2079)
 01h	BYTE	month (1-12)
 02h	BYTE	day (1-31)
 03h	BYTE	hour (0-23)
 04h	BYTE	minute (0-59)
 05h	BYTE	second (0-59)
 06h	BYTE	day of week (0 = Sunday)
----------21E3--SF32-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CREATE BINDERY OBJECT
	AH = E3h subfn 32h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    EEh	object already exists
	    EFh invalid name
	    F1h invalid bindery security level
	    F5h not permitted to create objects
	    FEh	server bindery locked
	    FFh	bindery failure
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=33h,AH=E3h/SF=34h,AH=E3h/SF=38h,AH=E3h/SF=39h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 35h)
 02h	BYTE	32h (subfunction "Create Bindery Object")
 03h	BYTE	object flag
		00h static
		01h dynamic
 04h	BYTE	object security levels
 05h	WORD	type of object (big-endian)
 07h	BYTE	length of object's name
 08h  N BYTEs	object's name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	0000h (no data returned)
----------21E3--SF33-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - DELETE BINDERY OBJECT
	AH = E3h subfn 33h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    EFh invalid name
	    F0h wildcard not allowed
	    F4h not permitted to delete objects
	    FCh no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=34h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 33h)
 02h	BYTE	33h (subfunction "Delete Bindery Object")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF34-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - RENAME BINDERY OBJECT
	AH = E3h subfn 34h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    EFh invalid name
	    F0h wildcard not allowed
	    F3h not permitted to rename object
	    FCh no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=33h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 63h)
 02h	BYTE	34h (subfunction "Rename Bindery Object")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
	BYTE	length of new name (01h-2Fh)
      N BYTEs	new name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF35-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - GET BINDERY OBJECT ID
	AH = E3h subfn 35h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    FCh no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the requesting workstation must be logged into the file server with
	  read access to the bindery object
SeeAlso: AH=E3h/SF=36h,AH=E3h/SF=44h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 33h)
 02h	BYTE	35h (subfunction "Get Bindery Object ID")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name
 06h  N BYTEs	object's name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0036h (length of following buffer space)
 02h	DWORD	object ID (big-endian)
 06h	WORD	type of object (big-endian)
 08h 48 BYTEs	object name
----------21E3--SF36-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - GET BINDERY OBJECT NAME
	AH = E3h subfn 36h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    EFh invalid name
	    F0h	wildcard not allowed
	    FCh no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the requesting workstation must be logged into the file server with
	  read access to the bindery object
SeeAlso: AH=E3h/SF=35h,AH=E3h/SF=44h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0005h (length of following data)
 02h	BYTE	36h (subfunction "Get Bindery Object Name")
 03h	DWORD	object ID (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0036h (length of following buffer space)
 02h	DWORD	object ID (big-endian)
 06h	WORD	type of object (big-endian)
 08h 48 BYTEs	object name
----------21E3--SF37-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - SCAN BINDERY OBJECT
	AH = E3h subfn 37h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    EFh invalid name
	    FCh no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the requesting workstation must be logged into the file server with
	  read access to the bindery object
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=33h,AH=E3h/SF=38h,AH=E3h/SF=3Ch

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 37h)
 02h	BYTE	37h (subfunction "Scan Bindery Object")
 03h	DWORD	last object ID (big-endian)
 07h	WORD	type of object (big-endian)
 09h	BYTE	length of object's name
 0Ah  N BYTEs	object's name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0039h (length of following buffer space)
 02h	DWORD	object ID (big-endian)
		FFFFFFFFh for first call
 06h	WORD	type of object (big-endian)
 08h	BYTE	length of object's name (01h-2Fh)
 09h  N BYTEs	object name
	BYTE	object flag (00h static, 01h dynamic)
	BYTE	object's security levels
	BYTE	object properties flag (00h no, FFh yes)
----------21E3--SF38-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CHANGE BINDERY OBJECT SECURITY
	AH = E3h subfn 38h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    F0h	wildcard not allowed
	    F1h invalid bindery security level
	    FBh	no such property
	    FCh	no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=3Bh

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 34h)
 02h	BYTE	38h (subfunction "Change Bindery Object Security")
 03h	BYTE	new security levels
 04h	WORD	type of object (big-endian)
 06h	BYTE	length of object's name (01h-2Fh)
 07h  N BYTEs	object name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF39-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CREATE PROPERTY
	AH = E3h subfn 39h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    EDh	property already exists
	    EFh invalid name
	    F0h wildcard not allowed
	    F1h invalid bindery security level
	    F7h not permitted to create properties
	    FCh no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=3Bh

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 45h)
 02h	BYTE	39h (subfunction "Create Property")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
	BYTE	property flags
	BYTE	property security levels
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property's name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF3A-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - DELETE PROPERTY
	AH = E3h subfn 3Ah
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    F0h wildcard not allowed
	    F1h invalid bindery security level
	    F6h not permitted to delete properties
	    FBh no such property
	    FCh no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=39h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 43h)
 02h	BYTE	3Ah (subfunction "Delete Property")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property's name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF3B-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CHANGE PROPERTY SECURITY
	AH = E3h subfn 3Bh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    F0h	wildcard not allowed
	    F1h invalid bindery security level
	    FBh	no such property
	    FCh	no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=38h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 44h)
 02h	BYTE	3Bh (subfunction "Change Property Security")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	new property security levels
	BYTE	length of property's name
      N BYTEs	property name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF3C-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - SCAN PROPERTY
	AH = E3h subfn 3Ch
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    F0h	wildcard not allowed
	    F1h invalid bindery security level
	    FBh	no such property
	    FCh	no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=37h,AH=E3h/SF=3Bh

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 47h)
 02h	BYTE	3Ch (subfunction "Scan Property")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	DWORD	sequence number (big-endian)
		FFFFFFFFh for first call
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property's name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0018h (length of following results buffer)
 02h 16 BYTEs	property name
 12h	BYTE	property flags
 13h	BYTE	property security levels
 14h	DWORD	sequence number (big-endian)
 18h	BYTE	property value flag (00h no, FFh yes)
 19h	BYTE	more properties (00h no, FFh yes)
----------21E3--SF3D-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - READ PROPERTY VALUE
	AH = E3h subfn 3Dh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    ECh no such segment
	    F0h	wildcard not allowed
	    F1h invalid bindery security level
	    F9h not permitted to read property
	    FBh	no such property
	    FCh	no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Desc:	retrieve one 128-byte segment of the specified property's value
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=39h,AH=E3h/SF=3Ch,AH=E3h/SF=3Eh

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 44h)
 02h	BYTE	3Dh (subfunction "Read Property Value")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	segment number (01h on first call, increment until done)
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0082h (length of following results buffer)
 02h 128 BYTEs	property's value
 82h	BYTE	more segments (00h no, FFh yes)
 83h	BYTE	property's flags
----------21E3--SF3E-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - WRITE PROPERTY VALUE
	AH = E3h subfn 3Eh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    E8h not item property
	    ECh no such segment
	    F0h	wildcard not allowed
	    F1h invalid bindery security level
	    F8h not permitted to write property
	    FBh	no such property
	    FCh	no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=39h,AH=E3h/SF=3Ch,AH=E3h/SF=3Eh

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max C5h)
 02h	BYTE	3Eh (subfunction "Write Property Value")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	segment number (01h on first call, increment until done)
	BYTE	erase remaining segments (00h no, FFh yes)
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property name
    128 BYTEs	property value segment

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF3F-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - VERIFY BINDERY OBJECT PASSWORD
	AH = E3h subfn 3Fh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    F0h	wildcard not allowed
	    FBh	no such property
	    FCh	no such object
	    FEh	server bindery locked
	    FFh	bindery failure: no such object, bad password
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=40h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 133h)
 02h	BYTE	3Fh (subfunction "Verify Bindery Object Password")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	length of password (00h-7Fh)
      N BYTEs	password

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF40-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CHANGE BINDERY OBJECT PASSWORD
	AH = E3h subfn 40h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    F0h	wildcard not allowed
	    FBh	no such property
	    FCh	no such object
	    FEh	server bindery locked
	    FFh	bindery failure: no such object, no password for object, or
			invalid old password
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=3Fh,AH=E3h/SF=41h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 133h)
 02h	BYTE	40h (subfunction "Change Bindery Object Password")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	length of old password (00h-7Fh)
      N BYTEs	old password
	BYTE	length of new password (00h-7Fh)
      N BYTEs	new password

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF41-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - ADD BINDERY OBJECT TO SET
	AH = E3h subfn 41h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    E9h	member already exists
	    EBh	not a group property
	    F0h	wildcard not allowed
	    F8h	can't write property
	    FBh	no such property
	    FCh	no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Desc:	add the specified object to a set property
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=40h,AH=E3h/SF=42h,AH=E3h/SF=43h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 75h)
 02h	BYTE	41h (subfunction "Add Bindery Object to Set")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name
 06h  N BYTEs	object name
	BYTE	length of property name (01h-0Fh)
      N BYTEs	property name
	WORD	type of member object (big-endian)
	BYTE	length of member object's name
      N BYTEs	member object's name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF42-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - DELETE BINDERY OBJECT FROM SET
	AH = E3h subfn 42h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    EAh	member does not exist
	    EBh	not a group property
	    F0h	wildcard not allowed
	    F8h	can't write property
	    FBh	no such property
	    FCh	no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Desc:	delete the specified object from a set property
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=40h,AH=E3h/SF=42h,AH=E3h/SF=43h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 75h)
 02h	BYTE	42h (subfunction "Delete Bindery Object from Set")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name
 06h  N BYTEs	object name
	BYTE	length of property name (01h-0Fh)
      N BYTEs	property name
	WORD	type of member object (big-endian)
	BYTE	length of member object's name
      N BYTEs	member object's name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF43-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - IS BINDERY OBJECT IN SET
	AH = E3h subfn 43h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    EAh member does not exist
	    EBh not a group property
	    F0h	wildcard not allowed
	    F9h not permitted to read property
	    FBh no such property
	    FCh no such object
	    FEh	server bindery locked
	    FFh	bindery failure
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the caller must have read access to the property
SeeAlso: AH=E3h/SF=41h,AH=E3h/SF=42h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 75h)
 02h	BYTE	43h (subfunction "Is Bindery Object In Set")
 03h	WORD	type of object (big-endian)
 05h	BYTE	length of object's name
 06h  N BYTEs	object's name
	BYTE	length of property's name
      N BYTEs	property's name
	WORD	type of member object (big-endian)
	BYTE	length of member object's name
      N BYTEs	member object's name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF44-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CLOSE BINDERY
	AH = E3h subfn 44h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=45h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	44h (subfunction "Close Bindery")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF45-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - OPEN BINDERY
	AH = E3h subfn 45h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the bindery may only be opened by the supervisor or an object with
	  equivalent privileges
SeeAlso: AH=E3h/SF=44h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	45h (subfunction "Open Bindery")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no data returned)
----------21E3--SF46-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - GET BINDERY ACCESS LEVEL
	AH = E3h subfn 46h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	46h (subfunction "Get Bindery Access Level")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	0005h (length of following buffer)
 02h	BYTE	security levels
 03h	DWORD	object ID (big-endian)
----------21E3--SF47-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - SCAN BINDERY OBJ TRUSTEE PATHS
	AH = E3h subfn 47h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    96h server out of memory
	    F0h wildcard not allowed
	    F1h invalid bindery security level
	    FCh no such object
	    FEh server bindery locked
	    FFh bindery failure
Desc:	iterate through the directories to which an object is a trustee
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E2h/SF=0Ch,AH=E2h/SF=0Dh,AH=E2h/SF=0Eh

Format of request buffer:
Offset	Size	Description
 00h	WORD	0008h (length of following data)
 02h	BYTE	47h (subfunction "Scan Bindery Object Trustee Paths")
 03h	BYTE	volume number (00h-1Fh)
 04h	WORD	last sequence number (big-endian)
		00h on first call
 06h	DWORD	object ID (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) length of following results buffer (max 107h)
 02h	WORD	next sequence number (big-endian)
 04h	DWORD	object ID (big-endian)
 08h	BYTE	trustee directory rights (see AH=E2h/SF=03h)
 09h	BYTE	length fo trustee path
 0Ah  N BYTEs	trustee path
----------21E3--SF64-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CREATE QUEUE
	AH = E3h subfn 64h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,99h,9Bh,9Ch,EDh-F1h,F5h,F7h,FCh,FEh,FFh)
		(see below)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation with supervisor privileges
SeeAlso: AH=E3h/SF=65h,AH=E3h/SF=66h,AH=E3h/SF=68h,AH=E3h/SF=6Bh

Values for status:
 00h	successful
 96h	server out of memory
 99h	directory full
 9Bh	invalid directory handle
 9Ch	invalid path
 D0h	queue error
 D1h	no such queue
 D2h	no server for queue
 D3h	no queue rights
 D4h	queue full
 D5h	no queue job
 D6h	no job rights
 D7h	queue servicing error
 D9h	station is not a server
 DAh	queue halted
 DBh	too many queue servers
 EDh	property already exists
 EEh	object already exists
 EFh	invalid name
 F0h	wildcard not allowed
 F1h	invalid bindery security level
 F5h	not permitted to create object
 F7h	not permitted to create property
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max ABh)
 02h	BYTE	64h (subfunction "Create Queue")
 03h	WORD	queue type (big-endian)
 05h	BYTE	length of queue's name (01h-2Fh)
 06h  N BYTEs	queue's name
	BYTE	directory handle or 00h
	BYTE	length of path name (01h-76h)
      N BYTEs	path name of directory in which to create queue subdirectory

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0004h (size of following results buffer)
 02h	DWORD	object ID of queue (big-endian)
----------21E3--SF65-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - DESTROY QUEUE
	AH = E3h subfn 65h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,9Ch,D0h,D1h,FFh) (see also AH=E3h/SF=64h)
	    FFh hardware failure
Desc:	abort all active jobs, detach all job servers, remove all job entries,
	  delete all job files, remove the queue object and its properties
	  from the bindery, and delete the queue's subdirectory
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must have SUPERVISOR privileges
SeeAlso: AH=E3h/SF=64h,AH=E3h/SF=66h,AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=70h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0005h (length of following data)
 02h	BYTE	65h (subfunction "Destroy Queue")
 03h	DWORD	object ID of queue (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF66-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - READ QUEUE CURRENT STATUS
	AH = E3h subfn 66h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,9Ch,D1h-D3h,F1h,FCh,FEh,FFh) (see AH=E3h/SF=64h)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USERS or Q_OPERATORS properties
SeeAlso: AH=E3h/SF=64h,AH=E3h/SF=67h,AH=E3h/SF=6Fh,AH=E3h/SF=76h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0005h (length of following data)
 02h	BYTE	66h (subfunction "Read Queue Current Status")
 03h	DWORD	object ID of queue (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0085h (size of following results)
 02h	DWORD	object ID of queue (big-endian)
 06h	BYTE	status of queue
		bit 0: operator disabled addition of new jobs
		bit 1: operator refuses additional job servers attaching
		bit 2: operator disabled job servicing
 07h	BYTE	number of jobs in queue (00h-FAh)
 08h	BYTE	number of servers attached to queue (00h-19h)
 09h 25 DWORDs	list of object IDs of attached servers
 6Dh 25 BYTEs	list of attached servers' stations
 86h	BYTE	(call) maximum number of servers to return
----------21E3--SF67-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - SET QUEUE CURRENT STATUS
	AH = E3h subfn 67h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D3h,FEh,FFh) (see AH=E3h/SF=64h)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must have operator privileges
SeeAlso: AH=E3h/SF=64h,AH=E3h/SF=66h,AH=E3h/SF=6Fh,AH=E3h/SF=76h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0006h (length of following data)
 02h	BYTE	67h (subfunction "Set Queue Current Status")
 03h	DWORD	object ID of queue (big-endian)
 07h	BYTE	queue status
		bit 0: operator disabled addition of new jobs
		bit 1: operator refuses additional job servers attaching
		bit 2: operator disabled job servicing

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF68-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CREATE QUEUE JOB AND FILE
	AH = E3h subfn 68h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,99h,9Ch,D0h-D4h,DAh,EDh,EFh-F1h,F7h,FCh,FEh,FFh)
		(see AH=E3h/SF=64h)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USER property
SeeAlso: AH=E3h/SF=69h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh

Format of request buffer:
Offset	Size	Description
 00h	WORD	0107h (length of following data)
 02h	BYTE	68h (subfunction "Close File and Start Queue Job")
 03h	DWORD	object ID of queue (big-endian)
 07h	BYTE	client station
 08h	BYTE	client task number
 09h	DWORD	object ID of client (big-endian)
 0Dh	DWORD	object ID of target server (big-endian)
		FFFFFFFh if any server acceptable
 11h  6 BYTEs	target execution time (year,month,day,hour,minute,second)
		FFFFFFFFFFFFh to execute as soon as possible
 17h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 1Dh	WORD	job number (big-endian)
 1Fh	WORD	job type (big-endian)
 21h	BYTE	job position
 22h	BYTE	job control flags
 23h 14 BYTEs	ASCIZ job file name
 31h  6 BYTEs	job file handle
 37h	BYTE	server station
 38h	BYTE	server task number
 39h	DWORD	object ID of server (big-endian)
 3Dh 50 BYTEs	ASCIZ job description string
 6Fh 152 BYTEs	client record area

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0036h (size of following results buffer)
 02h	BYTE	client station
 03h	BYTE	client task number
 04h	DWORD	object ID of client (big-endian)
 08h	DWORD	object ID of target server (big-endian)
 0Ch  6 BYTEs	target execution time (year,month,day,hour,minute,second)
 12h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 18h	WORD	job number (big-endian)
 1Ah	WORD	job type (big-endian)
 1Ch	BYTE	job position
 1Dh	BYTE	job control flags
 1Eh 14 BYTEs	ASCIZ job file name
 2Ch  6 BYTEs	job file handle
 32h	BYTE	server station
 33h	BYTE	server task number
 34h	DWORD	object ID of server or 00000000h (big-endian)
----------21E3--SF69-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CLOSE FILE AND START QUEUE JOB
	AH = E3h subfn 69h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,D0h,D1h,D3h,D5h,D6h,FEh,FFh) (see AH=E3h/SF=64h)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on the workstation which created the job
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh

Format of request buffer:
Offset	Size	Description
 00h	WORD	0007h (length of following data)
 02h	BYTE	69h (subfunction "Close File and Start Queue Job")
 03h	DWORD	object ID of queue (big-endian)
 07h	WORD	job number (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF6A-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - REMOVE JOB FROM QUEUE
	AH = E3h subfn 6Ah
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,D0h,D1h,D5h,D6h,FEh,FFh) (see AH=E3h/SF=64h)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must have created the job or be an operator
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh

Format of request buffer:
Offset	Size	Description
 00h	WORD	0007h (length of following data)
 02h	BYTE	6Ah (subfunction "Remove Job From Queue")
 03h	DWORD	object ID of queue (big-endian)
 07h	WORD	job number (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF6B-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - GET QUEUE JOB LIST
	AH = E3h subfn 6Bh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,9Ch,D0h-D3h,FCh,FEh,FFh) (see AH=E3h/SF=64h)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the Q_USERS or Q_OPERATORS properties
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh

Format of request buffer:
Offset	Size	Description
 00h	WORD	0005h (length of following data)
 02h	BYTE	6Bh (subfunction "Get Queue Job List")
 03h	DWORD	object ID of queue (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results buffer (max 1F6h)
 02h	WORD	job count (big-endian)
 04h  N WORDs	list of job numbers by position in queue (big-endian)
	WORD	maximum job numbers
----------21E3--SF6C-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - READ QUEUE JOB ENTRY
	AH = E3h subfn 6Ch
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,D0h-D3h,D5h,FCh,FEh,FFh) (see AH=E3h/SF=64h)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the Q_USERS, Q_OPERATORS, or Q_SERVERS properties
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh

Format of request buffer:
Offset	Size	Description
 00h	WORD	0007h (length of following data)
 02h	BYTE	6Ch (subfunction "Read Queue Job Entry")
 03h	DWORD	object ID of queue (big-endian)
 07h	WORD	job number (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0100h (size of following results)
 02h	BYTE	client station number
 03h	BYTE	client task number
 04h	DWORD	object ID of client
 08h	DWORD	object ID of target server (big-endian)
		FFFFFFFFh if any server acceptable
 0Ch  6 BYTEs	target execution time (year,month,day,hour,minute,second)
		FFFFFFFFFFFFh if serviced as soon as possible
 12h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 18h	WORD	job number (big-endian)
 1Ah	WORD	job type (big-endian)
 1Ch	BYTE	job position
 1Dh	BYTE	job control flags
		bit 3: job will be serviced automatically if connection broken
		bit 4: job remains in queue after server aborts job
		bit 5: client has not filled associated job file
		bit 6: User Hold--job advances, but cannot be serviced until
			this bit is cleared by user or operator
		bit 7: Operator Hold--job advances, but cannot be serviced
			until this bit is cleared by an operator
 1Eh 14 BYTEs	ASCIZ job filename
 2Ch  6 BYTEs	job file handle
 32h	BYTE	server station
 33h	BYTE	server task number
 34h	DWORD	object ID of server
 38h 50 BYTEs	ASCIZ job description string
 6Ah 152 BYTEs	client record area
----------21E3--SF6D-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CHANGE QUEUE JOB ENTRY
	AH = E3h subfn 6Dh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,D0h,D1h,D5h,D7h,FEh,FFh) (see AH=E3h/SF=64h)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be an operator or the user who created the job
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Ch,AH=E3h/SF=6Eh

Format of request buffer:
Offset	Size	Description
 00h	WORD	0105h (length of following data)
 02h	BYTE	6Dh (subfunction "Change Queue Job Entry")
 03h	DWORD	object ID of queue (big-endian)
 07h	BYTE	client station number
 08h	BYTE	client task number
 09h	DWORD	object ID of client
 0Dh	DWORD	object ID of target server (big-endian)
 11h  6 BYTEs	target execution time (year,month,day,hour,minute,second)
 17h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 1Dh	WORD	job number (big-endian)
 1Fh	WORD	job type (big-endian)
 21h	BYTE	job position
 22h	BYTE	job control flags
		bit 3: job will be serviced automatically if connection broken
		bit 4: job remains in queue after server aborts job
		bit 5: client has not filled associated job file
		bit 6: User Hold--job advances, but cannot be serviced until
			this bit is cleared by user or operator
		bit 7: Operator Hold--job advances, but cannot be serviced
			until this bit is cleared by an operator
 23h 14 BYTEs	ASCIZ job filename
 31h  6 BYTEs	job file handle
 37h	BYTE	server station
 38h	BYTE	server task number
 39h	DWORD	object ID of server
 3Dh 50 BYTEs	ASCIZ job description string
 6Fh 152 BYTEs	client record area

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF6E-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CHANGE QUEUE JOB POSITION
	AH = E3h subfn 6Eh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,D0h,D1h,D5h,D6h,FEh,FFh) (see AH=E3h/SF=64h)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be an operator
	if the specified position is greater than the number of jobs in the
	  queue, the job is placed at the end of the queue
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Ch,AH=E3h/SF=6Dh

Format of request buffer:
Offset	Size	Description
 00h	WORD	0008h (length of following data)
 02h	BYTE	6Eh (subfunction "Change Queue Job Position")
 03h	DWORD	object ID of queue (big-endian)
 07h	WORD	job number (big-endian)
 09h	BYTE	new position in queue (01h-FAh)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF6F-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - ATTACH QUEUE SERVER TO QUEUE
	AH = E3h subfn 6Fh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D3h,DAh,DBh,FEh,FFh)
		(see also AH=E3h/SF=64h)
	    FFh bindery failure, or no such property, or no such member
Desc:	attach the calling job server to the specified queue
Notes:	this function is supported by Advanced NetWare 2.1+
	a queue may have up to 25 job servers attached
	the calling workstation must be security-equivalent to a member of the
	  queue's Q_SERVERS property
SeeAlso: AH=E3h/SF=70h,AH=E3h/SF=71h,AH=E3h/SF=72h,AH=E3h/SF=73h,AH=E3h/SF=76h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0005h (length of following data)
 02h	BYTE	6Fh (subfunction "Attach Queue Server To Queue")
 03h	DWORD	object ID of queue (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF70-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - DETACH QUEUE SERVER FROM QUEUE
	AH = E3h subfn 70h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D2h,FEh,FFh) (see AH=E3h/SF=64h)
Desc:	remove the calling job server from the specified queue's list of
	  servers
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must have previously attached itself to the queue
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=72h,AH=E3h/SF=73h,AH=E3h/SF=76h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0005h (length of following data)
 02h	BYTE	70h (subfunction "Detach Queue Server From Queue")
 03h	DWORD	object ID of queue (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF71-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - SERVICE QUEUE JOB AND OPEN FILE
	AH = E3h subfn 71h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see AH=E3h/SF=68h)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D3h,D5h,D9h,DAh,FEh,FFh)
		(see AH=E3h/SF=64h)
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USERS, Q_OPERATORS, or Q_SERVERS properties
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=72h,AH=E3h/SF=73h,AH=E3h/SF=76h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0007h (length of following data)
 02h	BYTE	71h (subfunction "Service Queue Job and Open File")
 03h	DWORD	object ID of queue (big-endian)
 07h	WORD	target job type (big-endian)
		FFFFh any
----------21E3--SF72-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - FINISH SERVICING QUEUE JOB AND FILE
	AH = E3h subfn 72h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,D0h,D1h,D6h) (see AH=E3h/SF=64h)
Desc:	inform the Queue Management System (QMS) that the queue server has
	  completed a job
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must be a job server which has previously obtained a job
	  for servicing
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=71h,AH=E3h/SF=73h,AH=E3h/SF=76h

Format of request buffer:
Offset	Size	Description
 00h	WORD	000Bh (length of following data)
 02h	BYTE	72h (subfunction "Finish Servicing Queue Job and File")
 03h	DWORD	object ID of queue (big-endian)
 07h	WORD	job number (big-endian)
 09h	DWORD	charge (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF73-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - ABORT SERVICING QUEUE JOB AND FILE
	AH = E3h subfn 73h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,D0h,D1h,D6h,D9h) (see AH=E3h/SF=64h)
Desc:	inform the Queue Management System (QMS) that the queue server is
	  unable to service a previously-accepted job
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=71h,AH=E3h/SF=72h,AH=E3h/SF=76h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0007h (length of following data)
 02h	BYTE	73h (subfunction "Abort Servicing Queue Job and File")
 03h	DWORD	object ID of queue (big-endian)
 07h	WORD	job number (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF74-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CHANGE TO CLIENT RIGHTS
	AH = E3h subfn 74h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,D0h,D1h,D5h,D9h) (see AH=E3h/SF=64h)
Desc:	temporarily assume the login identity of the client submitting the
	  job being serviced
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be a job server which has obtained a job for servicing
SeeAlso: AH=E3h/SF=75h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0007h (length of following data)
 02h	BYTE	74h (subfunction "Change To Client Rights")
 03h	DWORD	object ID of queue (big-endian)
 07h	WORD	job number (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF75-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - RESTORE QUEUE SERVER RIGHTS
	AH = E3h subfn 75h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D3h,D5h,D9h,DAh,FEh,FFh)
		(see AH=E3h/SF=64h)
Desc:	restore server's own identity after assuming the login identity of the
	  client submitting the job being serviced
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be a job server which has previously changed its identity
SeeAlso: AH=E3h/SF=74h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	75h (subfunction "Change To Client Rights")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF76-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - READ QUEUE SERVER CURRENT STATUS
	AH = E3h subfn 76h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,9Ch,D1h-D3h,F1h,FCh,FEh,FFh) (see AH=E3h/SF=64h)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the Q_USERS or Q_OPERATORS properties
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ch,AH=E3h/SF=6Fh,AH=E3h/SF=77h,AH=E3h/SF=78h

Format of request buffer:
Offset	Size	Description
 00h	WORD	000Ah (length of following data)
 02h	BYTE	76h (subfunction "Read Queue Server Current Status")
 03h	DWORD	object ID of queue (big-endian)
 07h	DWORD	object ID of server (big-endian)
 0Bh	BYTE	server station

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0040h (size of following results)
 02h 64 BYTEs	server status record (format depends on server)
		first four bytes should contain estimated "price" for an
		average job
----------21E3--SF76-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - READ QUEUE SERVER CURRENT STATUS
	AH = E3h subfn 76h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (00h,96h,9Ch,D0h,D1h,FEh,FFh) (see AH=E3h/SF=64h)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be a job server which has attached itself to the queue
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ch,AH=E3h/SF=6Fh,AH=E3h/SF=76h,AH=E3h/SF=78h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0045h (length of following data)
 02h	BYTE	77h (subfunction "Set Queue Server Current Status")
 03h	DWORD	object ID of queue (big-endian)
 02h 64 BYTEs	server status record (format depends on server)
		first four bytes should contain estimated "price" for an
		average job

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SF78-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - GET QUEUE JOB'S FILE SIZE
	AH = E3h subfn 78h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status (see also AH=E3h/SF=64h)
	    00h successful
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USERS, Q_OPERATORS, or Q_SERVERS properties
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ch,AH=E3h/SF=71h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0007h (length of following data)
 02h	BYTE	78h (subfunction "Get Queue Job's File Size")
 03h	DWORD	object ID of queue (big-endian)
 07h	WORD	job number (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 000Ah (size of following results)
 02h	DWORD	object ID of queue (big-endian)
 06h	WORD	job number (big-endian)
 08h	DWORD	size of job file in bytes (big-endian)
----------21E3--SF96-------------------------
INT 21 - Novell NetWare - ACCOUNTING SERVICES - GET ACCOUNT STATUS
	AH = E3h subfn 96h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C0h	no account privileges
	    C1h	no account balance
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=97h,AH=E3h/SF=98h,AH=E3h/SF=99h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 33h)
 02h	BYTE	96h (subfunction "Get Account Status")
 03h	WORD	type of bindery object (big-endian)
 05h	BYTE	length of object name (01h to 2Fh)
 06h  N BYTEs	object name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) length of following buffer space
 02h	DWORD	account balance (big-endian)
 06h	DWORD	credit limit (big-endian)
		signed number indicating lowest allowable account balance
 0Ah 120 BYTEs	reserved
 82h	DWORD	object ID, server 1 (big-endian)
 86h	DWORD	hold amount, server 1 (big-endian)
	...
 F8h	DWORD	object ID, server 16 (big-endian)
 FCh	DWORD	hold amount, server 16 (big-endian)
Note:	the reply buffer lists the servers which have placed holds on a portion
	  of the account balance, and the amount reserved by each
----------21E3--SF97-------------------------
INT 21 - Novell NetWare - ACCOUNTING SERVICES - SUBMIT ACCOUNT CHARGE
	AH = E3h subfn 97h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C0h	no account privileges
	    C1h	no account balance
	    C2h credit limit exceeded
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=96h,AH=E3h/SF=98h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 13Fh)
 02h	BYTE	97h (subfunction "Submit Account Charge")
 03h	WORD	service type (big-endian)
 05h	DWORD	amount to be charged to account (big-endian)
 09h	DWORD	amount of prior hold to be cancelled (big-endian)
 0Dh	WORD	type of bindery object (big-endian)
 0Fh	WORD	type of comment (big-endian)
		8000h-FFFFh reserved for experimental use
 11h	BYTE	length of object's name
 12h  N BYTEs	object name
	BYTE	length of comment
      N BYTEs	comment

Format of reply buffer:
Offset	Size	Description
 00h	WORD	0000h (no data returned)
----------21E3--SF98-------------------------
INT 21 - Novell NetWare - ACCOUNTING SERVICES - SUBMIT ACCOUNT HOLD
	AH = E3h subfn 98h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C0h	no account privileges
	    C1h	no account balance
	    C2h credit limit exceeded
	    C3h too many holds on account
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=96h,AH=E3h/SF=97h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 37h)
 02h	BYTE	98h (subfunction "Submit Account Hold")
 03h	DWORD	amount of account balance to reserve (big-endian)
 07h	WORD	type of bindery object
 09h	BYTE	length of object's name
 0Ah  N BYTEs	object name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	0000h (no data returned)
----------21E3--SF99-------------------------
INT 21 - Novell NetWare - ACCOUNTING SERVICES - SUBMIT ACCOUNT NOTE
	AH = E3h subfn 99h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C0h	no account privileges
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=96h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 137h)
 02h	BYTE	99h (subfunction "Submit Account Note")
 03h	WORD	type of service (big-endian)
 05h	WORD	type of bindery object (big-endian)
 07h	WORD	type of comment (big-endian)
		8000h-FFFFh reserved for experimental use
 09h	BYTE	length of object's name
 0Ah  N BYTEs	object name
	BYTE	length of comment
      N BYTEs	comment

Format of reply buffer:
Offset	Size	Description
 00h	WORD	0000h (no data returned)
----------21E3--SFC8-------------------------
INT 21 - Novell NetWare - FILE SERVER - CHECK CONSOLE PRIVILEGES
	AH = E3h subfn C8h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Desc:	determine whether the caller is a console operator
Notes:	this function is supported by Advanced NetWare 2.1+
	NetWare determines console privileges by checking the file server's
	  OPERATOR property for the caller's object ID
SeeAlso: AH=E3h/SF=C9h,AH=E3h/SF=D1h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	C8h (subfunction "Check Console Privileges")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SFC9-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER DESCRIPTION STRINGS
	AH = E3h subfn C9h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must be attached to the file server
SeeAlso: AH=E3h/SF=11h,AH=E3h/SF=CDh,AH=E3h/SF=E8h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	C9h (subfunction "Get File Server Description Strings")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0200h (size of following results buffer)
 02h	var	ASCIZ name of company distributing this copy of NetWare
	var	ASCIZ version and revision
      9 BYTEs	ASCIZ revision date (mm/dd/yy)
	var	ASCIZ copyright notice
----------21E3--SFCA-------------------------
INT 21 - Novell NetWare - FILE SERVER - SET FILE SERVER DATE AND TIME
	AH = E3h subfn CAh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=2Bh,AH=2Dh,AH=E3h/SF=C8h,AH=E7h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0007h (length of following data)
 02h	BYTE	CAh (subfunction "Set File Server Date And Time")
 03h	BYTE	year (00-79 = 2000-2079, 80-99 = 1980-1999)
 04h	BYTE	month (1-12)
 05h	BYTE	day (1-31)
 06h	BYTE	hour (0-23)
 07h	BYTE	minute
 08h	BYTR	second

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SFCB-------------------------
INT 21 - Novell NetWare - FILE SERVER - DISABLE FILE SERVER LOGIN
	AH = E3h subfn CBh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CCh,AH=E3h/SF=D3h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	CBh (subfunction "Disable File Server Login")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SFCC-------------------------
INT 21 - Novell NetWare - FILE SERVER - ENABLE FILE SERVER LOGIN
	AH = E3h subfn CCh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CBh

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	CCh (subfunction "Enable File Server Login")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SFCD-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER LOGIN STATUS
	AH = E3h subfn CDh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CBh,AH=E3h/SF=CCh

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	CDh (subfunction "Get File Server Login Status")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0001h (size of following results buffer)
 02h	BYTE	login state (00h disabled, 01h enabled)
----------21E3--SFCE-------------------------
INT 21 - Novell NetWare - FILE SERVICES - PURGE ALL ERASED FILES
	AH = E3h subfn CEh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	all files marked for deletion on the file server are purged, regardless
	  of which workstation actually erased them
	the calling workstation must have console operator privileges
SeeAlso: AH=13h,AH=E2h/SF=10h,AH=E3h/SF=C8h,AX=F244h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	CEh (subfunction "Purge All Erased Files")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SFCF-------------------------
INT 21 - Novell NetWare - FILE SERVER - DISABLE TRANSACTION TRACKING
	AH = E3h subfn CFh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D0h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	CFh (subfunction "Disable Transaction Tracking")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SFD0-------------------------
INT 21 - Novell NetWare - FILE SERVER - ENABLE TRANSACTION TRACKING
	AH = E3h subfn D0h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Desc:	restart transaction tracking after being stopped either explicitly by
	  AH=E3h/SF=CFh or automatically due to a full transaction volume
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CFh

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	D0h (subfunction "Enable Transaction Tracking")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SFD1-------------------------
INT 21 - Novell NetWare - FILE SERVER - SEND CONSOLE BROADCAST
	AH = E3h subfn D1h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
	the broadcast message will not be received by workstations which have
	  disabled broadcasts with AH=E1h/SF=02h
SeeAlso: AH=E1h/SF=02h,AH=E1h/SF=09h,AH=E3h/SF=C8h,AH=E3h/SF=D3h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max A2h)
 02h	BYTE	D1h (subfunction "Send Console Broadcast")
 03h	BYTE	number of connections to receive message 
		00h = all, else specific list below
 04h  N BYTEs	connection list
	BYTE	length of message (max 3Ch)
      N BYTEs	message

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SFD2-------------------------
INT 21 - Novell NetWare - FILE SERVER - CLEAR CONNECTION NUMBER
	AH = E3h subfn D2h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Desc:	close the open files and release all file locks for a connection,
	  abort transactions if a TTS file server, and detach from the file
	  server
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must have SUPERVISOR privileges
SeeAlso: AH=E3h/SF=C9h,AH=E3h/SF=D1h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	D2h (subfunction "Clear Connection Number")
 03h	BYTE	connection number

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SFD3-------------------------
INT 21 - Novell NetWare - FILE SERVER - DOWN FILE SERVER
	AH = E3h subfn D3h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
	    FFh files open
Desc:	take down the file server
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have SUPERVISOR privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CBh,AH=E3h/SF=CFh,AH=E3h/SF=D1h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	D3h (subfunction "Down File Server")
 03h	BYTE	flag: force down even if files open if nonzero

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0000h (no results returned)
----------21E3--SFD4-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SYSTEM STATISTICS
	AH = E3h subfn D4h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=0Eh,AH=E3h/SF=C8h,AH=E3h/SF=D9h,AH=E3h/SF=E7h,AH=E3h/SF=E8h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	D4h (subfunction "Get File System Statistics")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0028h (size of following results buffer)
 02h	DWORD	clock ticks since system started
 06h	WORD	maximum open files set by configuration
 08h	WORD	maximum files open concurrently
 0Ah	WORD	current number of open files
 0Ch	DWORD	total files opened
 10h	DWORD	total file read requests
 14h	DWORD	total file write requests
 18h	WORD	current changed FATs
 1Ah	WORD	total changed FATs
 1Ch	WORD	number of FAT write errors
 1Eh	WORD	number of fatal FAT write errors
 20h	WORD	number of FAT scan errors
 22h	WORD	maximum concurrently-indexed files
 24h	WORD	current number of indexed files
 26h	WORD	number of attached indexed files
 28h	WORD	number of indexed files available
Note:	all fields except the first are big-endian
----------21E3--SFD5-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET TRANSACTION TRACKING STATISTICS
	AH = E3h subfn D5h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CFh,AH=E3h/SF=D0h,AH=E3h/SF=E8h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	D5h (subfunction "TTS Get Statistics")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) length of following results buffer (max 1BCh)
 02h	DWORD	clock ticks since system started (big-endian)
 06h	BYTE	transaction tracking supported if nonzero
		(all following fields are invalid if zero)
 07h	BYTE	transaction tracking enabled
 08h	WORD	transaction volume number (big-endian)
 0Ah	WORD	maximum simultaneous transactions configured (big-endian)
 0Ch	WORD	maximum simultaneous transactions since startup (big-endian)
 0Eh	WORD	current transactions in progress (big-endian)
 10h	DWORD	total transactions performed (big-endian)
 14h	DWORD	total write transactions (big-endian)
 18h	DWORD	total transactions backed out (big-endian)
 1Ch	WORD	number of unfilled backout requests (big-endian)
 1Eh	WORD	disk blocks used for transaction tracking (big-endian)
 20h	DWORD	blocks allocated for tracked-file FATs (big-endian)
 24h	DWORD	number of file size changes during a transaction (big-endian)
 28h	DWORD	number of file truncations during a transaction (big-endian)
 2Ch	BYTE	number of records following
 2Dh	Active Transaction Records [array]
	Offset	Size	Description
	 00h	BYTE	logical connection number
	 01h	BYTE	task number
----------21E3--SFD6-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET DISK CACHE STATISTICS
	AH = E3h subfn D6h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D5h,AH=E3h/SF=D8h,AH=E3h/SF=D9h,AH=E3h/SF=E6h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	D6h (subfunction "Get Disk Cache Statistics")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 004Eh (length of following results buffer)
 02h	DWORD	clock ticks since system started (big-endian)
 06h	WORD	number of cache buffers (big-endian)
 08h	WORD	size of cache buffer in bytes (big-endian)
 0Ah	WORD	number of dirty cache buffers (big-endian)
 0Ch	DWORD	number of cache read requests (big-endian)
 10h	DWORD	number of cache write requests (big-endian)
 14h	DWORD	number of cache hits (big-endian)
 18h	DWORD	number of cache misses (big-endian)
 1Ch	DWORD	number of physical read requests (big-endian)
 20h	DWORD	number of physical write requests (big-endian)
 24h	WORD	number of physical read errors (big-endian)
 26h	WORD	number of physical write errors (big-endian)
 28h	DWORD	cache get requests (big-endian)
 2Ch	DWORD	cache full write requests (big-endian)
 30h	DWORD	cache partial write requests (big-endian)
 34h	DWORD	background dirty writes (big-endian)
 38h	DWORD	background aged writes (big-endian)
 3Ch	DWORD	total cache writes (big-endian)
 40h	DWORD	number of cache allocations (big-endian)
 44h	WORD	thrashing count (big-endian)
 46h	WORD	number of times LRU block was dirty (big-endian)
 48h	WORD	number of reads on cache blocks not yet filled by writes
		(big-endian)
 4Ah	WORD	number of times a fragmented write occurred (big-endian)
 4Ch	WORD	number of cache hits on unavailable block (big-endian)
 4Eh	WORD	number of times a cache block was scrapped (big-endian)
----------21E3--SFD7-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET DRIVE MAPPING TABLE
	AH = E3h subfn D7h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D6h,AH=E3h/SF=D9h,AH=E3h/SF=E6h,AH=E3h/SF=E9h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	D7h (subfunction "Get Drive Mapping Table")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 00ECh (length of following results buffer)
 02h	DWORD	clock tick elapsed since system started (big-endian)
 06h	BYTE	fault tolerance (SFT) level
 07h	BYTE	number of logical drives attached to server
 08h	BYTE	number of physical drives attached to server
 09h  5 BYTEs	disk channel types (00h none, 01h XT, 02h AT, 03h SCSI, 
		04h disk coprocessor drive, 32h-FFh value-added drive types)
 0Eh	WORD	number of outstanding controller commands (big-endian)
 10h 32 BYTEs	drive mapping table (FFh = no such drive)
 30h 32 BYTEs	drive mirror table (secondary physical drive, FFh = none)
 50h 32 BYTEs	dead mirror table (last drive mapped to, FFh if never mirrored)
 70h	BYTE	physical drive being remirrored (FFh = none)
 71h	BYTE	reserved
 72h	DWORD	remirrored block (big-endian)
 76h 60 BYTEs	SFT error table (internal error counters)
----------21E3--SFD8-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET PHYSICAL DISK STATISTICS
	AH = E3h subfn D8h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D9h,AH=E3h/SF=E9h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	D8h (subfunction "Get Physical Disk Statistics")
 03h	BYTE	physical disk number

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 005Dh (size of following results record)
 02h	DWORD	clock ticks since system started (big-endian)
 06h	BYTE	physical disk channel
 07h	BYTE	flag: drive removable if nonzero
 08h	BYTE	physical drive type
 09h	BYTE	drive number within controller
 0Ah	BYTE	controller number
 0Bh	BYTE	controller type
 0Ch	DWORD	size of drive in 4K disk blocks (big-endian)
 10h	WORD	number of cylinders on drive (big-endian)
 12h	BYTE	number of heads
 13h	BYTE	number of sectors per track
 14h 64 BYTEs	ASCIZ drive make and model
 54h	WORD	number of I/O errors (big-endian)
 56h	DWORD	start of Hot Fix table (big-endian)
 5Ah	WORD	size of Hot Fix table (big-endian)
 5Ch	WORD	number of Hot Fix blocks available (big-endian)
 5Eh	BYTE	flag: Hot Fix disabled if nonzero
----------21E3--SFD9-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET DISK CHANNEL STATISTICS
	AH = E3h subfn D9h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D8h,AH=E3h/SF=E6h,AH=E3h/SF=E9h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	D9h (subfunction "Get Disk Channel Statistics")
 03h	BYTE	channel number

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 00A8h (size of following results record)
 02h	DWORD	clock ticks since system started (big-endian)
 06h	WORD	channel run state (big-endian)
		00h running
		01h being stopped
		02h stopped
		03h nonfunctional
 08h	WORD	channel synchronization state (big-endian)
		00h not in use
		02h used by NetWare, no other requests
		04h used by NetWare, other requests
		06h in use, not needed by NetWare
		08h in use, needed by NetWare
		0Ah channel released, NetWare should use it
 0Ah	BYTE	driver type
 0Bh	BYTE	major version of driver
 0Ch	BYTE	minor version of driver
 0Dh 65 BYTEs	ASCIZ driver description
 4Eh	WORD	first I/O address used (big-endian)
 50h	WORD	length of first I/O address (big-endian)
 52h	WORD	second I/O address used (big-endian)
 54h	WORD	length of second I/O address (big-endian)
 56h  3 BYTEs	first shared memory address
 59h  2 BYTEs	length of first shared memory address
 5Bh  3 BYTEs	second shared memory address
 5Eh  2 BYTEs	length of second shared memory address
 60h	BYTE	first interrupt number in-use flag
 61h	BYTE	first interrupt number used
 62h	BYTE	second interrupt number in-use flag
 63h	BYTE	second interrupt number used
 64h	BYTE	first DMA channel in-use flag
 65h	BYTE	first DMA channel used
 66h	BYTE	second DMA channel in-use flag
 67h	BYTE	second DMA channel used
 68h	BYTE	flags
 69h	BYTE	reserved
 6Ah 80 BYTEs	ASCIZ configuration description
----------21E3--SFDA-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTION'S TASK INFORMATION
	AH = E3h subfn DAh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DBh,AH=E3h/SF=DFh,AH=E3h/SF=E1h,AH=E3h/SF=E5h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0003h (length of following data)
 02h	BYTE	DAh (subfunction "Get Connection's Task Information")
 03h	WORD	logical connection number (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	BYTE	lock status of connection
		00h no locks
		01h waiting on physical record lock
		02h waiting on file lock
		03h waiting on logical record lock
		04h waiting on semaphore
 03h	var	Lock Status Information (see below)
 N	BYTE	number of records following
 N+1	Active Task Information Records [array]
	Offset	Size	Description
	 00h	BYTE	task number (01h-FFh)
	 01h	BYTE	task state
			01h in TTS explicit transaction
			02h in TTS implicit transaction
			04h shared fileset lock active

Format of Lock Status Information:
Offset	Size	Description
---lock status 00h---
 no fields
---lock status 01h---
 00h	BYTE	number of waiting task
 01h	DWORD	start address
 05h	DWORD	end address
 09h	BYTE	volume number
 0Ah	WORD	directory entry number
 0Ch 14 BYTEs	ASCIZ filename
---lock status 02h---
 00h	BYTE	number of waiting task
 01h	BYTE	volume number
 02h	WORD	directory entry number
 04h 14 BYTEs	ASCIZ filename
---lock status 03h---
 00h	BYTE	number of waiting task
 01h	BYTE	length of record name
 02h  N BYTEs	ASCIZ record name
---lock status 04h---
 00h	BYTE	number of waiting task
 01h	BYTE	length of semaphore's name
 02h  N BYTEs	ASCIZ semaphore name
----------21E3--SFDB-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTION'S OPEN FILES
	AH = E3h subfn DBh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E2h/SF=1Ah,AH=E3h/SF=C8h,AH=E3h/SF=DAh,AH=E3h/SF=DCh,AH=E3h/SF=DFh
SeeAlso: AH=E3h/SF=E1h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0005h (length of following data)
 02h	BYTE	DBh (subfunction "Get Connection's Open Files")
 03h	WORD	logical connection number (big-endian)
 05h	WORD	last record seen (big-endian)
		0000h on first call

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" field on next call)
		0000h if no more records
 04h	BYTE	number of records following
 05h	File Information Records [array]
	Offset	Size	Description
	 00h	BYTE	task number
	 01h	BYTE	lock flags (see below)
	 02h	BYTE	access flags (see below)
	 03h	BYTE	lock type
			00h no lock
			FEh file lock
			FFh locked by Begin Share File Set
	 04h	BYTE	volume number (00h-1Fh)
	 05h	WORD	directory entry (big-endian)
	 07h 14 BYTEs	ASCIZ filename

Bitmask of lock flags:
 bit 0: file is locked
 bit 1: file opened Shareable
 bit 2: logged
 bit 3: file opened Normal
 bit 6: TTS holding lock
 bit 7: Transaction Flag set on file

Bitmask of access flags:
 bit 0: file open for reading by calling station
 bit 1: file open for writing by calling station
 bit 2: deny reads by other stations
 bit 3: deny writes by other stations
 bit 4: file detached
 bit 5: TTS Holding Detach
 bit 6: TTS Holding Open
----------21E3--SFDC-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTIONS USING A FILE
	AH = E3h subfn DCh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DAh,AH=E3h/SF=DBh,AH=E3h/SF=DFh,AH=E3h/SF=E1h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 104h)
 02h	BYTE	DCh (subfunction "Get Connections Using a File")
 03h	WORD	last record (big-endian)
		0000h on first call
 05h	BYTE	directory handle
 06h	BYTE	length of file path
 07h  N BYTEs	ASCIZ file path

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	count of tasks which have opened or logged file (big-endian)
 04h	WORD	count of tasks which have opened file (big-endian)
 06h	WORD	count of opens for reading (big-endian)
 08h	WORD	count of opens for writing (big-endian)
 0Ah	WORD	deny read count (big-endian)
 0Ch	WORD	deny write count (big-endian)
 0Eh	WORD	next request record (place in "last record" field on next call)
		0000h if no more records
 10h	BYTE	locked flag
		00h not locked exclusively
		else locked exclusively
 11h	BYTE	number of records following
 12h	File Usage Information Records [array]
	Offset	Size	Description
	 00h	WORD	logical connection number (big-endian)
	 02h	BYTE	task number
	 03h	BYTE	lock flags (see AH=E3h/SF=DBh)
	 04h	BYTE	access flags (see AH=E3h/SF=DBh)
	 05h	BYTE	lock type
			00h no lock
			FEh file lock
			FFh locked by Begin Share File Set
----------21E3--SFDD-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET PHYSICAL RECORD LOCKS BY CONN&FILE
	AH = E3h subfn DDh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
	    FFh file not open
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DEh,AH=E3h/SF=DFh

Format of request buffer:
Offset	Size	Description
 00h	WORD	0016h (length of following data)
 02h	BYTE	DDh (subfunction "Get Physical Record Locks by Connection and
			File")
 03h	WORD	logical connection number (big-endian)
 05h	WORD	last record seen (big-endian)
		0000h on first call
 07h	BYTE	volume number (00h-1Fh)
 08h	WORD	directory handle (big-endian)
 0Ah 14 BYTEs	ASCIZ filename

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" on next call)
		0000h if no more records
 04h	BYTE	number of physical record locks
 05h	BYTE	number of records following
 06h	Physical Record Lock Info [array]
	Offset	Size	Description
	 00h	BYTE	task number
	 01h	BYTE	lock status (see below)
	 02h	DWORD	starting offset of record in file (big-endian)
	 06h	DWORD	ending offset of record in file (big-endian)

Bitmask of lock status:
 bit 0: exclusive lock
 bit 1: shareable lock
 bit 2: logged
 bit 6: lock held by TTS
----------21E3--SFDE-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET PHYSICAL RECORD LOCKS BY FILE
	AH = E3h subfn DEh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
	    FFh file not open
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DDh,AH=E3h/SF=DFh

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 104h)
 02h	BYTE	DEh (subfunction "Get Physical Record Locks by File")
 03h	WORD	last record seen (big-endian)
		0000h on first call
 05h	BYTE	directory handle
 06h	BYTE	length of filename
 07h  N BYTEs	ASCIZ filename

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" on next call)
		0000h if no more records
 04h	BYTE	number of physical record locks
 05h	BYTE	number of records following
 06h	Physical Record Lock Info [array]
	Offset	Size	Description
	 00h	WORD	number of tasks logging record (big-endian)
	 02h	WORD	number of tasks with shareable lock (big-endian)
	 04h	DWORD	starting offset of record in file (big-endian)
	 08h	DWORD	ending offset of record in file (big-endian)
	 0Ch	WORD	logical connection number (big-endian)
	 0Eh	BYTE	task number
	 0Fh	BYTE	lock type
			00h none
			FEh file lock
			FFh Begin Share File Set lock
----------21E3--SFDF-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET LOGICAL RECORDS BY CONNECTION
	AH = E3h subfn DFh
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DDh,AH=E3h/SF=E0h,AH=E3h/SF=E2h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0005h (length of following data)
 02h	BYTE	DFh (subfunction "Get Logical Records By Connection")
 03h	WORD	logical connection number (big-endian)
 05h	WORD	last record seen (big-endian)
		0000h on first call

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" field on next call)
		0000h if no more locked records
 09h	BYTE	number of records following
 0Ah	Logical Lock Information Records [list]
	Offset	Size	Description
	 00h	BYTE	task number
	 01h	BYTE	lock status (see AH=E3h/SF=DDh)
	 02h	BYTE	length of logical lock's name
	 03h  N BYTEs	logical lock's name
----------21E3--SFE0-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET LOGICAL RECORD INFORMATION
	AH = E3h subfn E0h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DDh,AH=E3h/SF=DFh,AH=E3h/SF=E2h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 67h)
 02h	BYTE	E0h (subfunction "Get Logical Record Information")
 03h	WORD	last record seen (big-endian)
		0000h on first call
 05h	BYTE	length of logical record's name
 06h  N BYTEs	logical record's name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results record (max 200h)
 02h	WORD	number of logical connections logging the record (big-endian)
 04h	WORD	number of logical connections with shareable lock (big-endian)
 06h	WORD	next request record (place in "last record" field on next call)
 08h	BYTE	locked exclusively if nonzero
 09h	BYTE	number of records following
 0Ah	Task Information Records [array]
	Offset	Size	Description
	 00h	WORD	logical connection number (big-endian)
	 02h	BYTE	task number
	 03h	BYTE	lock status (see AH=E3h/SF=DFh)
----------21E3--SFE1-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTION'S SEMAPHORES
	AH = E3h subfn E1h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DBh,AH=E3h/SF=DFh,AH=E3h/SF=E2h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0005h (length of following data)
 02h	BYTE	E1h (subfunction "Get Connection's Semaphores")
 03h	WORD	logical connection number (big-endian)
 05h	WORD	last record seen (big-endian)
		0000h on first call

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" field on next call)
 04h	BYTE	number of records following
 05h	Semaphore Information Records [array]
	Offset	Size	Description
	 00h	WORD	open count (big-endian)
	 02h	BYTE	semaphore value (-128 to 127)
	 03h	BYTE	task number
	 04h	BYTE	lock type
	 05h	BYTE	length of semaphore's name
	 06h  N BYTEs	semaphore's name
	     14 BYTEs	filename
----------21E3--SFE2-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET SEMAPHORE INFORMATION
	AH = E3h subfn E2h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=E1h

Format of request buffer:
Offset	Size	Description
 00h	WORD	length of following data (max 83h)
 02h	BYTE	E2h (subfunction "Get LAN Driver's Configuration Information")
 03h	WORD	last record seen (big-endian)
		0000h on first call
 05h	BYTE	length of semaphore's name (01h-7Fh)
 06h  N BYTEs	semaphore's name

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results buffer (max 1FEh)
 02h	WORD	next request record (place in "last record" on next call)
		0000h if no more
 04h	WORD	number of logical connections opening semaphore (big-endian)
 06h	BYTE	semaphore value (-127 to 128)
 07h	BYTE	number of records following
 08h	Semaphore Information [array]
	Offset	Size	Description
	 00h	WORD	logical connection number (big-endian)
	 02h	BYTE	task number
----------21E3--SFE3-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET LAN DRIVER'S CONFIGURATION INFO
	AH = E3h subfn E3h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=E7h,AH=E3h/SF=E8h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	E3h (subfunction "Get LAN Driver's Configuration Information")
 03h	BYTE	LAN board (00h-03h)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 00ACh (size of following results buffer)
 02h  4 BYTEs	network number
 06h  6 BYTEs	node number
 0Ch	BYTE	LAN driver installed (00h no--remaining fields invalid)
 0Dh	BYTE	option number selected at configuration time
 0Eh 160 BYTEs	configuration text
		ASCIZ hardware type
		ASCIZ hardware settings
----------21E3--SFE5-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTION'S USAGE STATISTICS
	AH = E3h subfn E5h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	one must have console operator privileges to get statistics for logical
	  connections other than one's own
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DAh,AH=E3h/SF=DBh,AH=E3h/SF=E1h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0003h (length of following data)
 02h	BYTE	E5h (subfunction "Get Connection's Usage Statistics")
 03h	WORD	logical connection number (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0014h (size of following results record)
 02h	DWORD	clock ticks since server started (big-endian)
 06h  6 BYTEs	bytes read
 0Ch  6 BYTEs	bytes written
 12h	DWORD	total request packets (big-endian)
----------21E3--SFE6-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET BINDERY OBJECT DISK SPACE LEFT
	AH = E3h subfn E6h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Notes:	this function is supported by Advanced NetWare 2.1+
	one must have console operator privileges to get the free space for
	  other bindery objects
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=E8h,AH=E3h/SF=E9h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0005h (length of following data)
 02h	BYTE	E6h (subfunction "Get Bindery Object Disk Space Left")
 03h	DWORD	object ID (big-endian)

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 000Fh (size of following results buffer)
 02h	DWORD	clock ticks elapsed since server started (big-endian)
 06h	DWORD	object ID (big-endian)
 0Ah	DWORD	4K disk blocks available to user (big-endian)
 0Eh	BYTE	restrictions
		00h enforced
		FFh not enforced
----------21E3--SFE7-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER LAN I/O STATISTICS
	AH = E3h subfn E7h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=0Eh,AH=E3h/SF=11h,AH=E3h/SF=D3h,AH=E3h/SF=E8h,AH=E7h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	E7h (subfunction "Get File Server LAN I/O Statistics")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0042h (size of following results buffer)
 02h	DWORD	clock ticks since system started
 06h	WORD	total routing buffers
 08h	WORD	maximum routing buffers used
 0Ah	WORD	current routing buffers used
 0Ch	DWORD	total file service packets
 10h	WORD	number of file service packets buffered
 12h	WORD	number of invalid connection packets
 14h	WORD	packets with bad logical connection numbers
 16h	WORD	number of packets received during processing
 18h	WORD	number of requests reprocessed
 1Ah	WORD	packets with bad sequence numbers
 1Ch	WORD	number of duplicate replies sent
 1Eh	WORD	number of acknowledgements sent
 20h	WORD	number of packets with bad request types
 22h	WORD	requests to attach to ws for which a request is being processed
 24h	WORD	requests to attach from ws which is already attaching
 26h	WORD	number of forged detach requests
 28h	WORD	detach requests with bad connection number
 2Ah	WORD	requests to detach from ws for which requests pending
 2Ch	WORD	number of cancelled replies
 2Eh	WORD	packets discarded due to excessive hop count
 30h	WORD	packets discarded due to unknown net
 32h	WORD	incoming packets discarded for lack of DGroup buffer
 34h	WORD	outgoing packets discarded due to lack of buffer
 36h	WORD	received packets destined for B,C, or D side drivers
 38h	DWORD	number of NetBIOS packets propagated through net
 3Ch	DWORD	total number of non-file-service packets
 40h	DWORD	total number of routed packets
Note:	all fields except the first are big-endian
----------21E3--SFE8-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER MISC INFORMATION
	AH = E3h subfn E8h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
	    C6h no console rights
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=0Eh,AH=E3h/SF=11h,AH=E3h/SF=CDh,AH=E3h/SF=E7h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0001h (length of following data)
 02h	BYTE	E8h (subfunction "Get File Server Misc Information")

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) size of following results buffer (max 0048h)
 02h	DWORD	clock ticks since system started
 06h	BYTE	CPU type
		00h Motorola 68000
		01h Intel 8086, 8088, or V20
		02h Intel 80286+
 07h	BYTE	reserved
 08h	BYTE	number of service processes in server
 09h	BYTE	server utilization in percent
 0Ah	WORD	maximum bindery objects set by configuration (big-endian)
		0000h = unlimited
 0Ch	WORD	maximum number of bindery objects used (big-endian)
 0Eh	WORD	current number of bindery objects in use (big-endian)
 10h	WORD	total server memory in K (big-endian)
 12h	WORD	wasted server memory in K (big-endian)
		normally 0000h
 14h	WORD	number of records following (01h-03h)
 16h	Dynamic Memory Information [array]
	Offset	Size	Description
	 00h	DWORD	total dynamic space (big-endian)
	 04h	DWORD	maximum dynamic space used (big-endian)
	 08h	DWORD	current dynamic space usage (big-endian)
----------21E3--SFE9-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET VOLUME INFORMATION
	AH = E3h subfn E9h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (see below)
Return: AL = status
	    00h successful
Notes:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=DAh,AH=E2h/SF=15h

Format of request buffer:
Offset	Size	Description
 00h	WORD	0002h (length of following data)
 02h	BYTE	E9h (subfunction "Get Volume Information")
 03h	BYTE	directory handle

Format of reply buffer:
Offset	Size	Description
 00h	WORD	(call) 0028h (length of following results buffer)
 02h	DWORD	elapsed system time (big-endian)
 06h	BYTE	volume number
 07h	BYTE	logical drive number
 08h	WORD	sectors per block (big-endian)
 0Ah	WORD	starting block (big-endian)
 0Ch	WORD	total blocks on volume (big-endian)
 0Eh	WORD	blocks available on volume (big-endian)
 10h	WORD	total directory slots (big-endian)
 12h	WORD	directory slots available (big-endian)
 14h	WORD	maximum directory entries actually used (big-endian)
 16h	BYTE	flag: volume hashed if nonzero
 17h	BYTE	flag: volume cached if nonzero
 18h	BYTE	flag: volume removable if nonzero
 19h	BYTE	flag: volume mounted if nonzero
 1Ah 16 BYTEs	NUL-padded volume name
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
SeeAlso: AH=E2h"OS/286"
----------21E7-------------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER DATE AND TIME
	AH = E7h
	DS:DX -> date/time buffer (see below)
Return: AL = error code
	    00h successful
	    FFh unsuccessful
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+,
	  Alloy NTNX, and Banyan VINES
SeeAlso: AH=2Ah,AH=2Ch,AH=E3h/SF=CAh

Format of date/time buffer:
Offset	Size	Description
 00h	BYTE	year (80-99 = 1980-1999, 0-79 = 2000-2079)
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
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET DIRECTORY HANDLE
	AX = E900h
	DX = drive number to check (0 = A:, ..., 25 = Z:, 26 ... 31)
Return: AL = directory handle
	AH = flags (drive not mapped if none set)
	    bit 0: permanent handle
	    bit 1: temporary handle
	    bit 7: mapped to local drive
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=00h,AH=E2h/SF=01h,AH=E2h/SF=0Ah
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
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - LOG FILE
	AH = EBh
	DS:DX -> ASCIZ filename
	if function C6h lock mode 01h:
	    AL = flags
		00h log file only
		01h lock as well as log file
		    BP = lock timeout in timer ticks (1/18 second)
			0000h = don't wait if file already locked
Return: AL = error code
	    00h successful
	    96h no dynamic memory for file
	    FEh timed out
	    FFh failed
Desc:	add the location and size of the specified file to the log table and
	  optionally lock the file
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=BCh"NetWare",AH=CAh,AH=D0h,AH=ECh"NetWare",AH=EDh"NetWare"
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
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - RELEASE FILE
	AH = ECh
	DS:DX -> ASCIZ filename
Return: AL = status
	    00h successful
	    FFh file not found
Desc:	unlock the specified file but retain it in the log table
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=CDh,AH=EBh"NetWare",AH=EDh"NetWare"
----------21EC-------------------------------
INT 21 - DoubleDOS - GET VIRTUAL SCREEN ADDRESS
	AH = ECh
Return: ES = segment of virtual screen
Notes:	screen address can change if task-switching is on!!
	identical to AH=FCh
SeeAlso: INT 10/AH=FEh,AH=FCh"DoubleDOS",INT FC"DoubleDOS"
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
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - CLEAR FILE
	AH = EDh
	DS:DX -> ASCIZ filename
Return: AL = status
	    00h successful
	    FFh no files found
Desc:	unlock the file and remove it from the log table
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=CBh"NetWare",AH=CEh,AH=CFh,AH=EBh"NetWare",AH=ECh"NetWare"
----------21ED-------------------------------
INT 21 - OS/286, OS/386 - GET SEGMENT OR WINDOW DESCRIPTOR
	AH = EDh
	???
Return: ???
Note:	protected mode only???
SeeAlso: AH=E9h"OS/286"
----------21EE-------------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - GET PHYSICAL STATION ADDRESS
	AH = EEh
Return: CX:BX:AX = six-byte physical address
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E3h/SF=13h
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
----------21EF00-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET DRIVE HANDLE TABLE
	AX = EF00h
Return: ES:SI -> network shell's 32-byte drive handle table
	AX = 0000h
Notes:	this function is supported by Advanced NetWare 1.0+
	each byte in the drive handle table contains the directory handle for
	  the corresponding drive, or 00h if not mapped to a directory
SeeAlso: AX=EF01h,AX=EF02h,AX=EF03h,AX=EF04h
----------21EF01-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET DRIVE FLAG TABLE
	AX = EF01h
Return: ES:SI -> network shell's 32-byte drive flag table (see below)
	AX = 0000h
Notes:	this function is supported by Advanced NetWare 1.0+
	each byte in the drive flag table corresponds to a drive
SeeAlso: AX=EF00h,AX=EF02h,AX=EF03h

Values in drive flag table:
 00h	drive is not mapped
 01h	permanent network drive
 02h	temporary network drive
 80h	mapped to local drive
 81h	local drive used as permanent network drive
 82h	local drive used as temporary network drive
----------21EF02-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET DRIVE CONNECTION ID
	AX = EF02h
Return: ES:SI -> network shell's 32-byte drive conection ID table
	AX = 0000h
Notes:	this function is supported by Advanced NetWare 1.0+
	each byte in the connection ID table corresponds to a drive and
	  contains either the connection ID (1-8) of the server for that drive
	  or 00h if the drive is not mapped to a file server
SeeAlso: AX=EF01h,AX=EF03h,AX=F002h
----------21EF03-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET CONNECTION ID
	AX = EF03h
Return: ES:SI -> network shell's connection ID table (see below)
	AX = 0000h
Note:	this function is supported by Advanced NetWare 1.0+
SeeAlso: AX=EF00h,AX=EF02h,AX=EF04h,AX=F002h

Format of connection ID table [one entry of eight-element array]:
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
 01h	BYTE	order number assigned to server (1-8)
 02h	DWORD	file server's network address (big-endian)
 06h  6 BYTEs	file server's node address (big-endian)
 0Ch	WORD	socket number (big-endian)
 0Eh	WORD	base receive timeout in clock ticks (big-endian)
 10h  6 BYTEs	preferred routing node (big-endian)
 16h	BYTE	packet sequence number
 17h	BYTE	connection number (FFh = no connection)
 18h	BYTE	connection status (00h if active)
 19h	WORD	maximum receive timeout in clock ticks (big-endian)
 1Bh  5 BYTEs	reserved
----------21EF04-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET FILE SERVER NAME
	AX = EF04h
Return: ES:SI -> network shell's file server name table (see below)
	AX = 0000h
Notes:	this function is supported by Advanced NetWare 1.0+
	the name table consists of eight 48-byte entries, each consisting of
	  an ASCIZ server name for the corresponding entry in the connection
	  ID table
SeeAlso: AX=EF03h
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
----------21F000-----------------------------
INT 21 - Novell NetWare - WORKSTATION - SET PREFERRED CONNECTION ID
	AX = F000h
	DL = connection ID of prefered file server (1-8) or 00h for none
Notes:	this function is supported by Advanced NetWare 1.0+
	the preferred connection ID is set to 00h by the shell on EOJ
SeeAlso: AH=D6h,AX=EF03h,AX=F001h,AX=F002h,AX=F005h
----------21F001-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET PREFERRED CONNECTION ID
	AX = F001h
Return: AL = connection ID of preferred file server (1-8), 00h if not set
Notes:	this function is supported by Advanced NetWare 1.0+
	the preferred connection ID is set to 00h by the shell on EOJ
SeeAlso: AH=D6h,AX=EF03h,AX=F000h,AX=F002h,AX=F005h
----------21F002-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET DEFAULT CONNECTION ID
	AX = F002h
Return: AL = connection ID of current default file server (1-8) (see AX=EF03h)
Note:	this function is supported by Advanced NetWare 1.0+
SeeAlso: AX=EF03h,AX=F000h,AX=F004h
----------21F003-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - GET LPT CAPTURE STATUS
	AX = F003h
Return: AH = status
	    00h not active
	    FFh active
		AL = connection ID (01h-08h)
Note:	this function is supported by Advanced NetWare 1.0+
SeeAlso: AX=B800h,AX=B804h,AH=DFh/DL=00h,AH=DFh/DL=04h
----------21F004-----------------------------
INT 21 - Novell NetWare - WORKSTATION - SET PRIMARY CONNECTION ID
	AX = F004h
	DL = connection ID of primary file server (1-8) or 00h for none
Note:	this function is supported by Advanced NetWare 2.0+
SeeAlso: AH=D6h,AX=EF03h,AX=F000h,AX=F002h,AX=F005h
----------21F005-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET PRIMARY CONNECTION ID
	AX = F005h
Return: AL = connection ID of primary file server (1-8), 00h if not set
Notes:	this function is supported by Advanced NetWare 2.0+
	by default, the primary file server is the one from which the login
	  script executed; it is set to 00h if the workstation is not logged in
	  and when it detaches from its primary file server
SeeAlso: AH=D6h,AX=EF03h,AX=F000h,AX=F002h,AX=F004h
----------21F1-------------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - FILE SERVER CONNECTION
	AH = F1h
	AL = subfunction
	    00h attach to file server
		DL = preferred file server (01h-08h)
	    01h detach from file server
		DL = connection ID
	    02h logout from file server
		DL = connection ID
Return: AL = status
	    00h successful
	    F8h already attached to server
	    F9h connection table full
	    FAh no more server slots
	    FCh unknown file server
	    FEh server bindery locked
	    FFh no response from server, or connection does not exist
Note:	these functions are supported by Advanced NetWare 1.0+
SeeAlso: AH=D7h"NetWare",AH=E3h/SF=14h
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
	    15h broadcast services (see AH=E1h"NetWare")
	    16h file/directory services (see AH=E2h"NetWare")
	    17h connection control (see AH=E3h"NetWare")
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (contents vary by function)
	ES:DI -> reply buffer (contents vary by function)
Return: AL = status
	reply buffer filled as appropriate for function
Note:	this is a multiplexor providing a "raw" interface to the underlying
	  Netware Core Protocol.  Many functions which were accessed via a
	  separate AH function in older versions can also be accessed here
	  (the function number in AL is added to CCh to get the old function
	  number which is desired), but some NetWare 3.x calls appear to be
	  available only here.
SeeAlso: AX=F244h
----------21F2-------------------------------
INT 21 - DoubleDOS - SEND CHARACTER TO KEYBOARD BUFFER OF OTHER JOB
	AH = F2h
	AL = character
Return: AL = 00h successful
	     01h buffer full (128 characters)
SeeAlso: AH=E2h"DoubleDOS",AH=F1h"DoubleDOS",AH=F3h"DoubleDOS"
SeeAlso: AH=F8h"DoubleDOS"
----------21F244-----------------------------
INT 21 - Novell NetWare - FILE SERVICES - ERASE FILES
	AX = F244h
	DS:SI -> request buffer (see below)
	ES:DI -> reply buffer (ignored???)
Return: AL = status
	    00h successful
	    98h nonexistent volume
	    9Bh invaid directory handle
	    9Ch invalid path
	    FFh no files found
Note:	this function only marks the file for deletion; use AH=E2h/SF=CEh to
	  actually delete all marked files
SeeAlso: AH=13h,AH=41h,AH=E2h/SF=0Bh,AH=E3h/SF=CEh

Format of request buffer:
Offset	Size	Description
 00h	BYTE	directory handle
 01h	BYTE	search attributes (see AX=4301h)
 02h	BYTE	length of filespec
 03h  N BYTEs	ASCIZ filespec (may include wildcards)
----------21F2AA-----------------------------
INT 21 - VIRUS - "PcVrsDs" - INSTALLATION CHECK
	AX = F2AAh
Return: AH = AAh if resident
SeeAlso: AH=F1h"VIRUS",AH=F3h"VIRUS"
----------21F3-------------------------------
INT 21 - Novell NetWare - FILE SERVICES - FILE SERVER FILE COPY
	AH = F3h
	ES:DI -> request buffer (see below)
Return: AL = status/error code
	CX:DX = number of bytes copied
Notes:	this function is supported by Advanced NetWare 2.0+
	both source and destination must be on the same file server
SeeAlso: AH=3Ch,AH=3Fh

Format of request buffer:
Offset	Size	Description
 00h	WORD	source file handle (as returned by AH=3Ch or AH=3Dh)
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
INT 21 - DOS v2.11 - SET OEM INT 21 HANDLER
	AH = F8h
	DS:DX -> OEM INT 21 handler for functions F9h to FFh
		 FFFFh:FFFFh disables OEM handler
Notes:	this function is supported by Toshiba T1000 ROM MSDOS 2.11
	calls to AH=F9h through AH=FFH will return AL=00h if no handler set
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
INT 21 - DOS v2.11 - OEM FUNCTION
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
INT 21 - DOS v2.11 - OEM FUNCTION
	AH = FAh
SeeAlso: AH=F8h"OEM",AH=F9h"OEM",AH=FBh"OEM"
----------21FA-------------------------------
INT 21 - DoubleDOS - TURN OFF TASK SWITCHING
	AH = FAh
Return: task switching turned off
SeeAlso: AH=EAh"DoubleDOS",AH=F9h"DoubleDOS",AH=FBh"DoubleDOS"
SeeAlso: INT FA"DoubleDOS"
----------21FA--DX5945-----------------------
INT 21 U - PC Tools v7+ VDEFEND, VSAFE, VWATCH - API
	AH = FAh
	DX = 5945h
	AL = function (00h-02h for VDEFEND, 00h-07h for VSAFE and VWATCH)
Return: varies by function
Note:	this API is identical to the API on INT 13/AH=FAh and INT 16/AH=FAh,
	  so it is listed in its entirety only under INT 16/AX=FA00h and
	  following
SeeAlso: INT 13/AX=FA00h,INT 16/AX=FA00h
----------21FB-------------------------------
INT 21 - DOS v2.11 - OEM FUNCTION
	AH = FBh
SeeAlso: AH=F8h"OEM",AH=FAh"OEM",AH=FCh"OEM"
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
INT 21 - DOS v2.11 - OEM FUNCTION
	AH = FCh
SeeAlso: AH=F8h"OEM",AH=FBh"OEM",AH=FDh"OEM"
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
INT 21 - DOS v2.11 - OEM FUNCTION
	AH = FDh
SeeAlso: AH=F8h"OEM",AH=FCh"OEM",AH=FEh"DOS"
----------21FD-------------------------------
INT 21 - VIRUS - "Border" - INSTALLATION CHECK
	AH = FDh
Return: AH = 13h if resident
SeeAlso: AH=FCh"VIRUS",AH=FEh"VIRUS"
----------21FE-------------------------------
INT 21 - DOS v2.11 - OEM FUNCTION
	AH = FEh
SeeAlso: AH=F8h"OEM",AH=FDh"OEM",AH=FFh"OEM"
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
INT 21 - DOS v2.11 - OEM FUNCTION
	AH = FFh
SeeAlso: AH=F8h"OEM",AH=FEh"OEM"
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
----------21FF-------------------------------
INT 21 UP - Rational Systems DOS/4GW - API
	AH = FFh
	DH = function (00h-17h) (see also separate entries below)
	DL = subfunction or argument
Return: CF clear if valid function number
	    AX = status???
	CF set if invalid function
SeeAlso: INT 15/AX=BFDCh
----------21FF--DH02-------------------------
INT 21 UP - Rational Systems DOS/4GW - SET ???
	AH = FFh
	DH = 02h
	DL = ???
Return: CF clear
----------21FF--DH05-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 05h
	BX = ???
Return: ???
----------21FF--DH06-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 06h
	BX = ???
Return: ???
----------21FF--DH07-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 07h
	BX = ???
Return: ???
----------21FF--DH08-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 08h
	BX = ???
	CX = ???
	ES = ???
Return: ???
----------21FF--DH09-------------------------
INT 21 UP - Rational Systems DOS/4GW - GET ???
	AH = FFh
	DH = 09h
Return: ES:BX -> ???
----------21FF--DH0A-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 0Ah
	AL = ???
	BX = ???
	CX = ???
Return: ES = ??? or 0000h
----------21FF--DH0B-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 0Bh
	AL = ???
	BX = ???
	CX = ???
Return: ???
----------21FF--DH0C-------------------------
INT 21 UP - Rational Systems DOS/4GW - GET/SET ???
	AH = FFh
	DH = 0Ch
	DL = ??? (00h or 01h)
Return: CF clear if successful
	    AL = previous value of ???
	CF set on error (DL out of range)
	    AX = FFFFh
----------21FF--DH0D-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 0Dh
	???
Return: ???
----------21FF--DH0E-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 0Eh
Return: DX:AX -> XBRK structure (see INT 15/AX=BF02h)
	BX = ???
	CX = ???
SeeAlso: INT 15/AX=BF02h
----------21FF--DH0F-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 0Fh
	???
Return: ???
----------21FF--DH10-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 10h
	AL = ???
	BX = ???
	CX = ???
	DI = ???
	SI = ???
Return: ???
Note:	among other things, frees two memory blocks via INT 21/AH=49h
----------21FF--DH11-------------------------
INT 21 UP - Rational Systems DOS/4GW - NOP
	AH = FFh
	DH = 11h
----------21FF--DH12-------------------------
INT 21 UP - Rational Systems DOS/4GW - EXCHANGE ??? POINTERS
	AH = FFh
	DH = 12h
	DS:SI -> new ???
	ES:DI -> new ???
Return: DS:SI -> previous ???
	ES:DI -> previous ???
----------21FF--DH13-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 13h
	AL = ???
	ES = ???
Return: ???
----------21FF--DH14-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 14h
	BX = ???
	CX = ???
Return: CF clear
	    AX = ???
	    DX = ???
----------21FF--DH15-------------------------
INT 21 UP - Rational Systems DOS/4GW - GET ??? FUNCTIONS
	AH = FFh
	DH = 15h
Return: CF clear
	    DX:AX -> FAR function for ???
	    CX:BX -> FAR function for ???
	    SI:DI -> FAR function for ???
----------21FF--DH16-------------------------
INT 21 UP - Rational Systems DOS/4GW - GET ???
	AH = FFh
	DH = 16h
Return: AX = ???
----------21FF--DH17-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFH
	DH = 17h
	AL = ???
	DL = ???
Return: ???
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
	AX = 1992h if "Year 1992"/"B1M92" resident
SeeAlso: AX=FF0Fh,AX=FFFFh/CX=0000h,INT 6B"VIRUS"
----------21FFFFCX0000-----------------------
INT 21 - VIRUS - "Revenge" - INSTALLATION CHECK
	AX = FFFFh
	CX = 0000h
Return: CX = 0006h if resident
SeeAlso: AX=FFFFh,INT 6B"VIRUS"
----------22---------------------------------
INT 22 - DOS 1+ - PROGRAM TERMINATION ADDRESS
Desc:	this vector specifies the address of the routine which is to be given
	  control after a program is terminated; it should never be called
	  directly, since it does not point at an interrupt handler
Notes:	this vector is restored from the DWORD at offset 0Ah in the PSP during
	  termination, and then a FAR JMP is performed to the address in INT 22
	normally points at the instruction immediately following INT 21/AH=4Bh
	  call which loaded the current program
SeeAlso: INT 20,INT 21/AH=00h,INT 21/AH=31h,INT 21/AH=4Ch
---------------------------------------------
INT 22 - COMTROL HOSTESS i/ISA DEBUGGER - CHANGE FIRMWARE DEBUGGING PORT
	AL = new firmware debugging port
Return: ???
SeeAlso: INT 21"COMTROL HOSTESS",INT 23"COMTROL HOSTESS"
----------23---------------------------------
INT 23 - DOS 1+ - CONTROL-C/CONTROL-BREAK HANDLER
---DOS 1.x---
Return: AH = 00h abort program
	if all registers preserved, restart DOS call
---DOS 2+---
	CF clear
Return: all registers preserved
	return via RETF or RETF 2 with CF set
	    DOS will abort program with errorlevel 0
	else (RETF/RETF 2 with CF clear or IRET)
	    interrupted DOS call is restarted
Notes:	this interrupt is invoked whenever DOS detects a ^C or ^Break; it
	  should never be called directly
	MSDOS 1.25 also invokes INT 23 on a divide overflow (INT 00)
	DOS remembers the stack pointer before calling INT 23, and if it is
	  not the same on return, pops and discards the top word; this is what
	  permits a return with RETF as well as IRET or RETF 2
	any DOS call may safely be made within the INT 23 handler, although
	  the handler must to check for a recursive invocation if it does
	  call DOS
SeeAlso: INT 1B
---------------------------------------------
INT 23 - COMTROL HOSTESS i/ISA DEBUGGER - GET CONFIGURATION INFORMATION
	AL = query type
	    00h get old config map
		Return: AX = old config map
	    01h get dual-ported RAM map
		Return: BX:AX = dual-ported RAM map
	    02h get SCC port map
		Return: BX:AX = SCC port map
SeeAlso: INT 22"COMTROL HOSTESS",INT 26"COMTROL HOSTESS"
----------24---------------------------------
INT 24 - DOS 1+ - CRITICAL ERROR HANDLER
Note:	invoked when a critical (usually hardware) error is encountered; should
	  never be called directly
SeeAlso: INT 21/AH=95h

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
----------25--FFSI4358-----------------------
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
---------------------------------------------
INT 26 - COMTROL HOSTESS i/ISA DEBUGGER - ENTER/EXIT EXTENDED ADDRESSING MODE
	???
Return: ???
SeeAlso: INT 23"COMTROL HOSTESS",INT 27"COMTROL HOSTESS"
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
---------------------------------------------
INT 27 - COMTROL HOSTESS i/ISA DEBUGGER - INVOKE REMOTE TURBO DEBUGGER KERNEL
	???
Return: ???
Desc:	invoke a copy of the remote Turbo Debugger kernel on the Hostess i
	  controller
SeeAlso: INT 20"COMTROL HOSTESS",INT 26"COMTROL HOSTESS"
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
INT 29 C - DOS 2+ - FAST CONSOLE OUTPUT
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
	CF set if NetWare v2.15 NetBIOS emulator installed
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
Notes:	invokes either INT 5B or INT 5C as appropriate
	NetWare 2.15 NetBIOS emulator returns CF clear if succesful, set on err
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
INT 2A C - NETWORK - BEGIN DOS CRITICAL SECTION
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
INT 2A C - NETWORK - END DOS CRITICAL SECTION
	AH = 81h
	AL = critical section number (00h-0Fh) (see AH=80h)
Notes:	normally hooked rather than called
	the handler should reawaken any tasks which were suspended due to an
	  attempt to enter the specified critical section
SeeAlso: AH=80h,AH=82h,AH=87h
----------2A82-------------------------------
INT 2A C - NETWORK - END DOS CRITICAL SECTIONS 0 THROUGH 7
	AH = 82h
Notes:	called by the INT 21h function dispatcher for function 0 and functions
	  greater than 0Ch except 59h, and on process termination
	the handler should reawaken any tasks which were suspended due to an
	  attempt to enter one of the critical sections 0 through 7
SeeAlso: AH=81h
----------2A84-------------------------------
INT 2A C - Microsoft Networks - KEYBOARD BUSY LOOP
	AH = 84h
Note:	similar to DOS's INT 28h, called from inside the DOS keyboard input
	  loop to allow network to process requests
SeeAlso: INT 28
----------2A87-------------------------------
!!!
INT 2A C - PRINT??? - CRITICAL SECTION
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
INT 2D - ALTERNATE MULTIPLEX INTERRUPT SPECIFICATION (AMIS) [v3.5]
	AH = multiplex number
	AL = function
	    00h installation check
		Return: AL = 00h if free
			AL = FFh if multiplex number in use
			    CX = binary version number (CH = major, CL = minor)
			    DX:DI -> signature string (see below) identifying
				    the program using the multiplex number
	    01h get entry point
		Return: AL = 00h if all API calls via INT 2D
			AL = FFh if entry point supported
			    DX:BX -> entry point for bypassing interrupt chain
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
			    01h (obsolete) unable to determine
			    02h (obsolete) interrupt hooked
			    03h (obsolete) interrupt hooked, address returned
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
			return values 01h thru 03h are disparaged and will be
			  removed from the next version of this specification;
			  they are included for compatibility with version 3.3,
			  though they were probably never used in any
			  implementation
	    05h get hotkeys
		Return: AL = status
			    00h not implemented
			    FFh supported
				DX:BX -> hotkey list (see below)
	    06h-0Fh reserved for future enhancements
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
	to be considered fully compliant with version 3.5 of the specification,
	  programs must implement at least functions 00h, 02h (no resident
	  uninstall code required), and 04h (return value 04h).	 TSRs that
	  provide hotkeys with which the user can activate them must also
	  implement function 05h.  The absolute minimum fully-compliant
	  implementation has an overhead of 64 bytes (80 bytes with function
	  05h) plus 22 bytes per hooked interrupt (for the interrupt sharing
	  protocol header and hook list entry).
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
	  (AMISL090.ZIP as of this writing).
	Please let me know if you choose to follow this proposal.  The
	  signature and a list of the private API calls you use would be
	  appreciated, as well.
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

Format of hotkey list:
Offset	Size	Description
 00h	BYTE	type of hotkey checking
		bit 0: checks before chaining INT 09
		bit 1: checks after chaining INT 09
		bit 2: checks before chaining INT 15/AH=4Fh
		bit 3: checks after chaining INT 15/AH=4Fh
		bit 4: checks on INT 16/AH=00h,01h,02h
		bit 5: checks on INT 16/AH=10h,11h,12h
		bits 6,7: reserved (0)
 01h	BYTE	number of hotkeys (may be zero if TSR can disable hotkeys)
 02h 6N BYTEs	array of hotkey definitions
		(one per hotkey, first should be primary hotkey)
		Offset	Size	Description
		 00h	BYTE	hotkey scan code (00h/80h if shift states only)
				hotkey triggers on release if bit 7 set
		 01h	WORD	required shift states (see below)
		 03h	WORD	disallowed shift states (see below)
		 05h	BYTE	flags
				bit 0: hotkey chained before processing
				bit 1: hotkey chained after processing
				bit 2: others should pass through this hotkey
					so that it can be monitored
				bit 3: hotkey will not activate if other keys
					pressed/released before hotkey press is
					completed
				bit 4: this key is remapped into some other key
				bit 5-7: reserved (0)
Notes:	except for bit 7, the shift states correspond exactly to the return
	  values from INT 16/AH=12h.  A set bit in the required states word
	  indicates that the corresponding shift state must be active when the
	  hotkey's scan code is received for the hotkey to be recognized; a
	  clear bit means that the corresponding state may be ignored.	A set
	  bit in the disallowed shift states word indicates that the
	  corresponding shift state must be inactive.
	if bit 2 is set, either control key may be pressed for the hotkey; if
	  bits 8 and 10 are both set, then both control keys must be pressed.
	  Similarly for bits 3 and 9/11, as well as 7 and 0/1.
	for the disallowed-states word, if one of the "either" bits is set,
	  then both the corresponding left bit and right bit must be set
	examples:
		Ctrl-Alt-Del monitoring: 53h 000Ch 0003h 06h
		Alt-key tap (DESQview):	 B8h 0000h 0007h 08h
		Shf-Shf-N (NOTE.COM):	 31h 0003h 000Ch 00h

Bitmask of shift states:
 bit 0: right shift pressed
 bit 1: left shift pressed
 bit 2: either control key pressed
 bit 3: either Alt key pressed
 bit 4: ScrollLock active
 bit 5: NumLock active
 bit 6: CapsLock active
 bit 7: either shift key pressed
 bit 8: left control key pressed
 bit 9: left Alt key pressed
 bit 10: right control key pressed
 bit 11: right Alt key pressed
 bit 12: ScrollLock pressed
 bit 13: NumLock pressed
 bit 14: CapsLock pressed
 bit 15: SysRq key pressed

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
 'Crynwr  ' 'SPELLER '	TSR spelling-checker
 'heathh  ' 'Monitor '
 'Ralf B  ' 'FASTMOUS'	example TSR included with sample AMIS library code
 'Ralf B  ' 'NOLPT n '	example TSR -- turn LPTn into bit-bucket
 'Ralf B  ' 'NOTE    '	example TSR -- popup note-taker
 'Ralf B  ' 'RBkeyswp'	RBkeyswap v3.0+ -- swap Esc/~ and LCtrl/CapsLock keys
 'Ralf B  ' 'SWITCHAR'	example TSR -- add switchar() support removed from DOS5
 'Ralf B  ' 'VGABLANK'	example TSR -- VGA-only screen blanker
 'TifaWARE' 'EATMEM  '	George A. Theall's public domain memory restrictor for
			testing programs (v1.1+)
	    'RECALL  '	public domain commandline editor and history (v1.2+)
 'Todd	  ' 'XPTR2   '	PC-to-Transputer interface by Todd Radel
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
	the MSDOS 5 Programmer's Reference calls this "Reload Transient"

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
---------------------------------------------
