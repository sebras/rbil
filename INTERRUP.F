Interrupt List, part 6 of 8
This compilation is Copyright (c) 1989,1990,1991,1992,1993 Ralf Brown
----------2FC0-------------------------------
INT 2F - MTEZ XpressFax Hardware TSR (CLASS2) - API
	AH = C0h
	AL = function code (01h to 15h)
Return: ???
SeeAlso: AX=C000h"MTEZ",AX=CB00h"MTEZ"
----------2FC000-----------------------------
INT 2F - Novell ODI Link Support Layer (LSL.COM) - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh
	ES:BX -> FAR entry point
	ES:SI -> signature string "LINKSUP$"
Note:	LSL.COM may use any multiplex number between C0h and FFh; it searches
	  for itself in that range, and installs using the first free multiplex
	  number in the range if not already loaded.

Call entry point with:
	BX = 0002h get entry points
		ES:SI -> buffer for entry point record (see below)
		Return: ES:SI buffer filled

Format of entry point record:
Offset	Size	Description
 00h	DWORD	pointer to ??? entry point in LSL
 04h	DWORD	pointer to ??? entry point in LSL
----------2FC000-----------------------------
INT 2F - MTEZ XpressFax Hardware TSR (CLASS2) - INSTALLATION CHECK
	AX = C000h
	BX = 444Bh
	CX = 4A4Eh
Return: AL = status
	    00h not installed, OK to install
	    FFh installed
		BX = 646Bh
		CX = 6A6Eh
Note:	this TSR will use any free multiplex number from C0h to FFh
SeeAlso: AH=C0h"MTEZ"
----------2FC000-----------------------------
INT 2F - AD-DOS - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    BX = 4144h ('AD')
	    CX = 2D44h ('-D')
	    DX = 4F53h ('OS')
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Note:	AH=C0h is the default multiplex number; if this is already in use,
	  After Dark will try successive values up to AH=FFh
SeeAlso: AX=C001h,AX=C003h,AX=C005h,AX=C007h,AX=C009h,AX=C020h
----------2FC001ES0000-----------------------
INT 2F - AD-DOS - GET RESIDENT CODE SEGMENT
	AX = C001h
	ES = 0000h
Return: AL = 00h if successful
	    ES = AD-DOS TSR Code Segment
SeeAlso: AX=C000h"AD-DOS"
----------2FC002-----------------------------
INT 2F - AD-DOS - CHECK FOR NEW INPUT
	AX = C002h
Return: AL = 00h if succesful
	    BX = status
		0000h no input since last check
		0001h new input available
Note:	this call also resets the new-input flag
SeeAlso: AX=C000h"AD-DOS",AX=C004h
----------2FC003-----------------------------
INT 2F - AD-DOS - SET MINUTES TO WAIT
	AX = C003h
	BX = minutes to wait before blanking screen
Return: AL = 00h if successful
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Notes:	AH=C0h is the default multiplex number; if this is already in use,
	  After Dark will try successive values up to AH=FFh
	this call also resets the delay timer
SeeAlso: AX=C000h"AD-DOS",AX=C004h
----------2FC004-----------------------------
INT 2F - AD-DOS - GET MINUTES TO WAIT
	AX = C004h
Return: AL = 00h if succesful
	    BX = minutes to wait before blanking screen
SeeAlso: AX=C000h"AD-DOS",AX=C003h
----------2FC005-----------------------------
INT 2F - AD-DOS - SET BLANKER STATUS
	AX = C005h
	BX = new state (0000h inactive, 0001h active) (default 0001h)
Return: AL = 00h if successful
SeeAlso: AX=C006h
----------2F0C06-----------------------------
INT 2F - AD-DOS - GET BLANKER STATUS
	AX = C006h
Return: AL = 00h if successful
	    BX = current state of screen blanker (0000h inactive, 0001h active)
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Note:	AH=C0h is the default multiplex number; if this is already in use,
	  After Dark will try successive values up to AH=FFh
SeeAlso: AX=C000h"AD-DOS",AX=C005h
----------2F0C07-----------------------------
INT 2F - AD-DOS - SET HOT KEY
	AX = C007h
	BX = hot key
	CL = hot key shift status
Return: AL = 00h if successful
SeeAlso: AX=C008h
----------2F0C08-----------------------------
INT 2F - AD-DOS - GET CURRENT HOT KEY
	AX = C008h
Return: AX = status
	    0000h successful
		BX = Hot Key
		CL = Hot Key Shift Status
	    0008h otherwise
SeeAlso: AX=C000h"AD-DOS",AX=C007h
----------2F0C09-----------------------------
INT 2F - AD-DOS - UNBLANK MONITOR
	AX = C009h
Return: AL = 00h if successful
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Notes:	AH=C0h is the default multiplex number; if this is already in use,
	  After Dark will try successive values up to AH=FFh
	this function works by simulating keyboard activity
----------2F0C0A-----------------------------
INT 2F - AD-DOS - ???
	AX = C00Ah
Return: AX = status
	    0000h successful
		BH = ??
		BL = ??
	    000Ah failed
----------2F0C0B-----------------------------
INT 2F - AD-DOS - ???
	AX = C00Bh
Return: AX = status 
	    0000h successful
	    000Bh failed
----------2F0C0C-----------------------------
INT 2F - AD-DOS - SET ??? INTERNAL FLAG TO 01h
	AX = C00Ch
Return: AX = status
	    0000h successful
	    000Ch failed
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Note:	AH=C0h is the default multiplex number; if this is already in use,
	  After Dark will try successive values up to AH=FFh
----------2F0C0E-----------------------------
INT 2F - AD-DOS - SET PASSWORD STATUS
	AX = C00Eh
	BX = new state (0000h disabled, 0001h enabled)
Return: ???
SeeAlso: AX=C000h"AD-DOS",AX=C00Fh
----------2F0C0F-----------------------------
INT 2F - AD-DOS - GET PASSWORD STATUS
	AX = C00Fh
Return: BX = current state (0000h disabled, 0001h enabled)
SeeAlso: AX=C00Eh
----------2F0C20-----------------------------
INT 2F - AD-DOS - GET AND RESET VxD API STATUS
	AX = C020h
Return: AL = 00h if successful
	    BX = VxD API Status
		0000h no error
		0001h error
		0100h neither Windows 3.X enhanced mode nor
			Windows/386 2.x is running
		0200h VM API entry point not found (VxD not installed)
Notes:	AH=C0h is the default multiplex number; if this is already in use,
	  After Dark will try successive values up to AH=FFh
	this call resets the VxD API Status to zero
SeeAlso: AX=1602h,AX=1607h
----------2FC050-----------------------------
INT 2F U - Explosiv 2.00 - INSTALLATION CHECK
	AX = C050h
Return: AL = 51h if installed
Notes:	Explosiv is a shareware animated screen blanker for DOS and Windows 3
	  by Reidar Gresseth and Chris Hook
	AH=C0h is the default multiplex number, but may be reconfigured to
	  any value from C0h to C9h
SeeAlso: AX=C052h
----------2FC052-----------------------------
INT 2F U - Explosiv 2.00 - UNINSTALL
	AX = C052h
	DX:BX = address to return to on successful uninstall
Return: at specified address if successful
	AL = 53h on error
Note:	specified return address must have the segment of the caller's PSP
SeeAlso: AX=C050h
----------2FC054-----------------------------
INT 2F U - Explosiv 2.00 - GET ???
	AX = C054h
Return: AL = ???
Note:	returns value set by AX=C057h
SeeAlso: AX=C057h
----------2FC055-----------------------------
INT 2F U - Explosiv 2.00 - SET BLANKING INTERVAL
	AX = C055h
	BX = new interval in clock ticks
----------2FC056-----------------------------
INT 2F U - Explosiv 2.00 - SET ???
	AX = C056h
	BL = ???
----------2FC057-----------------------------
INT 2F U - Explosiv 2.00 - SET ???
	AX = C057h
	BL = ???
SeeAlso: AX=C054h
----------2FC058-----------------------------
INT 2F U - Explosiv 2.00 - SET ???
	AX = C058h
	BL = ???
----------2FC059-----------------------------
INT 2F U - Explosiv 2.00 - CLEAR ???
	AX = C059h
Note:	clears flag set by AX=C05Ah
SeeAlso: AX=C05Ah
----------2FC05A-----------------------------
INT 2F U - Explosiv 2.00 - SET ???
	AX = C05Ah
	BL = ???
Note:	sets flag cleared by AX=C059h then stores BL
SeeAlso: AX=C059h,AX=C05Bh
----------2FC05B-----------------------------
INT 2F U - Explosiv 2.00 - SET ???
	AX = C05Bh
	BL = ???
SeeAlso: AX=C05Ah,AX=C05Ch
----------2FC05C-----------------------------
INT 2F U - Explosiv 2.00 - SET ???
	AX = C05Ch
	BL = ???
SeeAlso: AX=C05Bh
----------2FC900BP0000-----------------------
INT 2F U - ThunderByte??? - INSTALLATION CHECK
	AX = C900h
	BP = 0000h
Return: AL = FFh if installed
	    BP >= 0014h
Note:	called by TBSCANX
SeeAlso: AX=C987h,AX=CA00h
----------2FC987-----------------------------
INT 2F U - ThunderByte??? - DISINFECT FILE???
	AX = C987h
	BX:DX -> filename
	BX:CX -> virus name
Return: AX = status
	    0000h successful???
Note:	called by TBSCANX
SeeAlso: AX=CA00h
----------2FC9FF-----------------------------
INT 2F C - STACKMAN - INSTALLATION BROADCAST
	AX = C9FFh
	BL = BCD version number
	CX = number of stacks
	DX = stack size in bytes
Notes:	called by STACKMAN when it goes resident to inform interested TSRs that
	  its API is available
	the installation check consists of testing for the string "STACKXXX" at
	  offset 0Ah from the INT B4 handler
SeeAlso: INT B4"STACKMAN",INT B5"STACKMAN"
----------2FCA00BX5442-----------------------
INT 2F - TBSCANX - INSTALLATION CHECK
	AX = CA00h
	BX = 5442h ('TB')
Return:	AL = 00h not installed
	   = FFh installed
		BX = 7462h ('tb') if BX was 5442h on entry
Note:	TBSCANX is a resident virus scanning module by Frans Veldman.  Programs
	  may perform virus checks on themselves, other program files, or their
	  data files by invoking the TBSCANX API.
SeeAlso: AX=4653h,AX=C900h
----------2FCA01-----------------------------
INT 2F - TBSCANX - GET STATUS
	AX = CA01h
Return: AH = BCD version number (v2.2+)
	   = CAh for versions before 2.2
	AL = state (00h = disabled, 01h = enabled)
	CX = number of signatures which will be searched
---v2.0---
	BX = EMS handle, 0000h if not using EMS
---v2.3+---
	BX = segment of swap area, 0000h if not swapped
	DX = EMS or XMS handle (XMS handle if BX=0000h), FFFFh if not using EMS
SeeAlso: AX=CA02h
----------2FCA02-----------------------------
INT 2F - TBSCANX - SET STATE
	AX = CA02h
	BL = new state (00h = disabled, 01h = enabled)
SeeAlso: AX=CA01h
----------2FCA03-----------------------------
INT 2F - TBSCANX - SCAN BUFFER
	AX = CA03h
	CX = size of buffer
	DS:DX -> buffer containing data to scan
Return: CF clear if no virus signatures found
	    BX,ES destroyed
	CF set if signature found
	    ES:BX -> ASCIZ virus name (v2.3+)
	    DS:DX -> ASCIZ virus name (v2.0)
	AX,CX,DX destroyed (v2.3+)
	all other registers except CS:IP and SS:SP destroyed (v2.0)
SeeAlso: AX=CA04h
----------2FCA04-----------------------------
INT 2F - TBSCANX - SCAN FILE
	AX = CA04h
	DS:DX -> filename
Return: CF clear if no virus signatures found
	    BX,ES destroyed
	CF set if signature found
	    ES:BX -> ASCIZ virus name
	AX,CX,DX destroyed
Note:	this function requires at least 4K free memory
SeeAlso: AX=CA03h
----------2FCAFEBX0000-----------------------
INT 2F U - THELP v3.0 - INSTALLATION CHECK
	AX = CAFEh
	BX = 0000h
Return: BX = segment of resident code if installed
	   = 0000h if not installed
SeeAlso: AX=5453h
----------2FCB00-----------------------------
INT 2F - Communicating Applications Specification - INSTALLATION CHECK
	AX = CB00h
Return: AL = status
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
Note:	AH = CBh is the default identifier, but may be reconfigured
SeeAlso: AH=2Ah,AX=8000h"FaxBIOS",AX=CB0Eh,AX=CBDCh
----------2FCB00BX4D53-----------------------
INT 2F - MTEZ XpressFax CASMGR - INSTALLATION CHECK
	AX = CB00h
	BX = 4D53h
	CX = 4949h
Return: AL = status
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
		BX = 6D73h
		CX = 6969h
Note:	this function is equivalent to the standard CASMGR installation check,
	  but uses the additional magic values to identify which CAS is
	  installed
SeeAlso: AH=2Ah,AX=8000h"FaxBIOS",AX=C000h"MTEZ",AX=CB0Eh,AX=CB16h
----------2FCB01-----------------------------
INT 2F - Communicating Applications Specification - SUBMIT A TASK
	AX = CB01h
	DS:DX -> ASCIZ name of task control file
Return: AX >= 0: event handle
	   < 0: error code
Note:	files needed for an event must be kept until task is complete or error
SeeAlso: AX=CB0Bh,AX=CB15h

Error codes (AH = class, AL = subcode, value passed back is 2's complement):
  Class 00h	--- FAX warnings
	Subcode 00h	no error
		02h	bad scanline count
		03h	page sent with errors, could not retransmit
		04h	received data lost
		05h	invalid or missing logo file
		06h	filename does not match nonstandard format (NSF) header
		07h	file size does not match NSF header
  Class 01h	--- DOS warnings (data was sent)
	Subcode 01h	invalid function
		05h	access denied
		06h	invalid handle
		others	see INT 21/AH=59h
  Class 02h	--- fatal errors (data not sent)
	Subcode	00h	multiplex handler failed
		01h	unknown command
		02h	bad event handle
		03h	FIND NEXT attempted before FIND FIRST
		04h	no more events
		07h	invalid queue type
		08h	bad control file
		09h	communication board busy
		0Ah	invalid command parameter
		0Bh	can't uninstall resident code
		0Ch	file exists
		80h	unknown task type
		81h	bad phone number
		82h	bad .PCX file header
		83h	unexpected EOF
		84h	unexpected disconnect
		85h	too many dialing retries
		86h	no file specified for send
		87h	communication board timeout
		88h	received too many pages (>1023) of data
		89h	manual connect initiated too long ago
		8Ah	hardware command set error
		8Bh	bad NonStandard Format (NSF) header file
  Class 03h	--- fatal DOS errors
	Subcode 02h	file not found
		03h	path not found
		others	see INT 21/AH=59h
  Class 04h	--- FAX errors
	Subcode 01h	remote unit not Group 3 compatible
		02h	remote unit did not send capabilities
		03h	other FAX machine incompatible
		04h	other FAX incapable of file transfers
		05h	exceeded retrain or FAX resend limit
		06h	line noise or failure to agree on bit rate
		07h	remote disconnected after receiving data
		08h	no response from remote after sending data
		09h	remote's capabilities incompatible
		0Ah	no dial tone (v1.2+)
		0Bh	invalid response from remote unit after sending data
		0Dh	phone line dead or remote unit disconnected
		0Eh	timeout while waiting for secondary dial tone (v1.2+)
		11h	invalid command from remote after receiving data
		15h	tried to receive from incompatible hardware
		5Ch	received data overflowed input buffer
		5Dh	remote unexpectedly stopped sending data
		5Eh	other FAX machine jammed (no data sent)
		5Fh	remote took too long to send fax scan line
		63h	can't get through to remote unit
		64h	user canceled event
  Class 05h	--- application-specific (v1.2+)
  ---Intel FAXPOP.EXE
	Subcode 00h	tried to send while in graphics mode
		01h	insufficient disk space
		02h	internal buffer overflow
  Class 06h	--- CAS implementation-specific (v1.2+)
----------2FCB02-----------------------------
INT 2F - Communicating Applications Specification - ABORT CURRENT EVENT
	AX = CB02h
Return: AX >= 0: event handle of aborted event
	   < 0: error code (see AX=CB01h)
Note:	termination could take up to 30 seconds
SeeAlso: AX=CB08h,AX=CB10h
----------2FCB05-----------------------------
INT 2F - Communicating Applications Specification - FIND FIRST QUEUE ENTRY
	AX = CB05h
	CX = status of events to find
	    0000h successful completion
	    0001h waiting to be processed
	    0002h number has been dialed
	    0003h connection established, sending
	    0004h connection established, receiving
	    0005h event aborted
	    FFFFh find any event, regardless of status
	    other negative values, match error code
	DH = direction
	    00h chronological order, earliest to latest
	    01h reverse chronological order, latest to earliest
	DL = queue to search
	    00h task queue
	    01h receive queue
	    02h log queue
Return: AX = 0000h successful
	    BX = event handle for found event
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB06h,AX=CB07h
----------2FCB06-----------------------------
INT 2F - Communicating Applications Specification - FIND NEXT QUEUE ENTRY
	AX = CB06h
	DL = queue to search
	    00h task queue
	    01h receive queue
	    02h log queue
Return: AX = 0000h successful
	    BX = event handle for found event
	   < 0	   error code (see AX=CB01h)
Note:	direction of search is same as preceding FIND FIRST call
SeeAlso: AX=CB05h
----------2FCB07-----------------------------
INT 2F - Communicating Applications Specification - OPEN FILE
	AX = CB07h
	BX = event handle from find (AL=05h,06h) or submit task (AL=01h)
	CX = receive file number (ignored for task queue and log queue)
	    0000h  open receive control file
	    N	   open Nth received data file
	DL = queue
	    00h task queue
	    01h receive queue control file or received file, as given by CX
	    02h log queue
	    03h group file in task queue (v1.2+)
	    04h group file in log queue (v1.2+)
Return: AX = 0000h successful
	    BX = DOS file handle for requested file
	   < 0	   error code (see AX=CB01h)
Note:	the returned file handle has been opened in read-only mode and should
	  be closed with INT 21/AH=3Eh after use
SeeAlso: AX=CB01h,AX=CB05h,AX=CB14h
----------2FCB08-----------------------------
INT 2F - Communicating Applications Specification - DELETE FILE
	AX = CB08h
	BX = event handle
	CX = receive file number
	    0000h delete ALL received files and receive control file
	    N	  delete Nth received file
	DL = queue
	    00h delete control file in task queue and corresponding group file
		if it exists
	    01h delete file in receive queue, as given by CX
	    02h delete control file in log queue (individual deletions not
		recommended, to maintain integrity of log) and corresponding
		group file if it exists
Return: AX = 0000h successful
	   < 0	   error code (see AX=CB01h)\
SeeAlso: AX=CB02h,AX=CB09h
----------2FCB09-----------------------------
INT 2F - Communicating Applications Specification - DELETE ALL FILES IN Q
	AX = CB09h
	DL = queue
	    00h delete all control files in task queue, including all group
		files
	    01h delete all files in receive queue
	    02h delete all control files in log queue, including all group
		files
Return: AX = 0000h successful
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB08h
----------2FCB0A-----------------------------
INT 2F - Communicating Applications Specification - GET EVENT DATE
	AX = CB0Ah
	BX = event handle
	DL = queue
	    00h task queue
	    01h receive queue
	    02h log queue
Return: AX = 0000h successful
		CX = year
		DH = month
		DL = day
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB0Bh,AX=CB0Ch
----------2FCB0B-----------------------------
INT 2F - Communicating Applications Specification - SET TASK DATE
	AX = CB0Bh
	BX = event handle (task event only)
	CX = year
	DH = month
	DL = day
Return: AX = 0000h successful
	   < 0	   error code (see AX=CB01h)
Note:	setting a task's date and time to before the current date and time
	  causes it to execute immediately
SeeAlso: AX=CB01h,AX=CB0Ah,AX=CB0Dh
----------2FCB0C-----------------------------
INT 2F - Communicating Applications Specification - GET EVENT TIME
	AX = CB0Ch
	BX = event handle
	DL = queue
	    00h task queue
	    01h receive queue
	    02h log queue
Return: AX = 0000h successful
		CH = hour
		CL = minute
		DH = second
		DL = 00h
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB0Ah,AX=CB0Dh
----------2FCB0D-----------------------------
INT 2F - Communicating Applications Specification - SET TASK TIME
	AX = CB0Dh
	BX = event handle (task events only)
	CH = hour
	CL = minute
	DH = second
	DL unused
Return: AX = 0000h successful
	   < 0	   error code (see AX=CB01h)
Note:	setting a task's date and time to before the current date and time
	  causes it to execute immediately
SeeAlso: AX=CB0Bh,AX=CB0Ch,AX=CB10h
----------2FCB0E-----------------------------
INT 2F - Communicating Applications Specification - GET EXTERNAL DATA BLOCK
	AX = CB0Eh
	DS:DX -> 256-byte buffer
Return: AX = 0000h successful
		buffer filled
	   < 0	   error code (see AX=CB01h)

Format of external data block:
Offset	Size	Description
 00h	BYTE	CAS major version
 01h	BYTE	CAS minor version
 02h 68 BYTEs	ASCIZ path to directory containing CAS software, ends in slash
 46h 13 BYTEs	ASCIZ name of current phonebook (in CAS directory)
 53h 13 BYTEs	ASCIZ name of current logo file (in CAS directory)
 60h 32 BYTEs	ASCIZ default sender name
 80h 21 BYTEs	ASCIZ CCITT identification of fax device
 95h 107 BYTEs	reserved
----------2FCB0F-----------------------------
INT 2F - Communicating Applications Specification - GET/SET AUTORECEIVE
	AX = CB0Fh
	DL = subfunction
	    00h get current autoreceive state
	    01h set autoreceive state
		DH = number of rings before answer, 00h = never
Return: AX = 0000h autoreceive disabled
	   = N	   number of rings before answer
	   < 0	   error code (see AX=CB01h)
----------2FCB10-----------------------------
INT 2F - Communicating Applications Specification - GET CURRENT EVENT STATUS
	AX = CB10h
	DS:DX -> 512-byte buffer
Return: AX = 0000h successful
		BX = event handle of current event or negative error code if
			no current event
		buffer filled
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB02h,AX=CB0Dh

Format of status area:
Offset	Size	Description
 00h	BYTE	event type
		00h send
		01h receive
		02h polled send
		03h polled receive
		04h to 7Fh reserved
		FFh serious hardware error
 01h	BYTE	transfer type
		00h 200x200 dpi, FAX mode
		01h 100x200 dpi, FAX mode
		02h file transfer mode
		03h to 7Fh reserved
 02h	WORD	event status 
		0000h completed successfully
		0001h waiting
		0002h number dialed
		0003h connected, sending
		0004h connected, receiving
		0005h aborted
		0006h to 007Fh reserved
		0080h to 7FFFh application-specific events
		8000h to FFFFh error codes
 04h	WORD	event time (packed DOS time format, see INT 21/AX=5700h)
 06h	WORD	event date (packed DOS date format, see INT 21/AX=5700h)
 08h	WORD	number of files to transfer, max 7FFFh
 0Ah	WORD	offset of file transfer record
 0Ch 47 BYTEs	ASCIZ phone number to call
 3Bh 64 BYTEs	ASCIZ application-specific tag string
 7Bh	BYTE	reserved (00h)
 7Ch	BYTE	connect time, seconds
 7Dh	BYTE	connect time, minutes
 7Eh	BYTE	connect time, hours
 7Fh	DWORD	total number of pages in all files
 83h	DWORD	pages already transmitted 
 87h	WORD	number of files already transmitted
 89h	BYTE	cover page flag
		00h don't transmit cover page
		01h transmit cover page
		02h to 7Fh reserved
 8Ah	WORD	total number of transmission errors
 8Ch 78 BYTEs	reserved (zeros)
 DAh 21 BYTEs	ASCIZ remote FAX's CCITT identification
 EFH 32 BYTEs	ASCIZ destination name
10Fh 32 BYTEs	ASCIZ sender name
12Fh 80 BYTEs	filename of PCX logo file (max 1780x800 pixels)
17Fh 128 BYTEs	file transfer record for current event (see below)

Format of file transfer record:
Offset	Size	Description
 00h	BYTE	file type (ignored unless FAX)
		00h ASCII
		01h PCX
		02h DCX
		03h to 7Fh reserved
 01h	BYTE	text size for ASCII FAX file
		00h = 80 columns by 66 lines (11 inches)
		01h = 132 columns by 88 lines (11 inches)
		02h to 7Fh reserved
 02h	BYTE	status of file
		00h untouched
		01h opened
		02h moved
		03h deleted
		04h not yet received
		05h to 7Fh reserved
 03h	DWORD	bytes already transmitted
 07h	DWORD	file size in bytes
 0Bh	WORD	pages alread transmitted
 0Dh	WORD	number of pages in file
 0Fh 80 BYTEs	ASCIZ filename
 5Fh	BYTE	1/8 inch page length
		if page length below set to 01h through 7Fh, this value 
		specifies additional 1/8 inch increments to page length
 60h	BYTE	page length
		00h = 11 inches
		01h to 7Fh = page length is this number of inches plus value of
			1/8 inch field above
		80h to FEh reserved
		FFh = ASCII pages ending with formfeed
 61h 31 BYTEs	reserved (zeros)
----------2FCB11-----------------------------
INT 2F - Communicating Applications Specification - GET QUEUE STATUS
	AX = CB11h
	DL = queue to get status of
	    00h task queue
	    01h receive queue
	    02h log queue
	    03h send events (v1.2+)
	    04h receive events (v1.2+)
Return: AX >= 0	 total number of changes made to queue, modulo 32768
		BX = number of control files currently in queue
		CX = number of received files (zero for task and log queues)
	AX < 0	error code (see AX=CB01h)
SeeAlso: AX=CB12h
----------2FCB11DL03-------------------------
INT 2F - Communicating Applications Spec v1.2+ - GET NUMBER OF SEND EVENTS
	AX = CB11h
	DL = 03h
Return: AX = number of successful sends since resident manager started
	BX = number of unsuccessful sends, including warnings
SeeAlso: AX=CB11h/DL=04h
----------2FCB11DL04-------------------------
INT 2F - Communicating Applications Spec v1.2+ - GET NUMBER OF RECEIVE EVENTS
	AX = CB11h
	DL = 04h
Return:	AX = number of received file events since resident manager started
	BX = number of received FAX events
SeeAlso: AX=CB11h/DL=03h
----------2FCB12-----------------------------
INT 2F - Communicating Applications Specification - GET HARDWARE STATUS
	AX = CB12h
	DS:DX -> 128-byte status buffer
Return: AX = 0000h successful
		buffer filled with hardware-dependent status information
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB10h,AX=CB11h

Format of status buffer for Intel Connection CoProcessor:
Offset	Size	Description
 00h	BYTE	bit flags
		bit 7: hardware busy sending or receiving
		bit 6: last page of data
		bit 5: no data on current page
		bit 4: retransmit request for current page being transmitted
		bit 3: NSF mode active
		bits 2-0: reserved
 01h	BYTE	number of kilobytes of free buffer space
 02h	BYTE	page buffer status
		bit 7: Connection CoProcessor has documents to send
		bits 6-0: number of pages in buffer
 03h	BYTE	number of retries left for dialing number
 04h	BYTE	page number to retransmit
 05h	BYTE	communications status
		bit 7: originating call
		bit 6: FAX message to be sent
		bit 5: on line
		bit 4: ring detected and receive enabled
		bit 3: buffer dumped on receive
		bits 2-0: hardware sequence state
			000 idle
			001 dial
			010 answer
			011 transmit
			100 receive
			101 pre-message
			110 post-message
			111 disconnect
 06h	BYTE	baud rate
		bit 7: reserved
		bits 6-4: baud rate
			000 = 300 baud	(V.21 SDLC or HDLC mode)
			100 = 2400 baud (V.27 ter)
			101 = 4800 baud (V.27 ter)
			110 = 7200 baud (V.29)
			111 = 9600 baud (V.29)
		bits 3-0: reserved, should be 0110
 07h  3 BYTEs	reserved
 0Ah	BYTE	hardware status
		bit 7: modem option installed
		bit 6: Connection CoProcessor has control of DAA (not latched)
		bit 5: on line (not latched)
		bit 4: ring detected (not latched)
		bit 3: data in command buffer (not latched)
		bit 2: set if using DMA channel 1, clear if using DMA channel 3
		bit 1: line length compensation bit 1 set (not latched)
		bit 0: line length compensation bit 0 set (not latched)
 0Bh	BYTE	switch states
		bit 7: reserved
		bit 6: unused
		bit 5: spare switch open
		bit 4: FAX ADR1 switch open
		bit 3: FAX ADR0 switch open
		bit 2: alternate interrupt switch open
		bit 1: COM SEL 1 switch open
		bit 0: COM SEL 0 switch open
			Note: valid combinations of bits 0-2 are
				000  COM2 IRQ3 IObase 2F8h
				001  COM1 IRQ4 IObase 3F8h
				010  COM4 IRQ3 IObase 2E8h
				011  COM3 IRQ4 IObase 3E8h
				110  COM4 IRQ2 IObase 2E8h
				111  COM3 IRQ5 IObase 3E8h
 0Ch	BYTE	bit flags
		bit 7: reserved
		bit 6: auxiliary relay forced ON
		bit 5: modem select relay forced ON
		bit 4: offhook relay forced ON
		bit 3: 9600 bps enabled
		bit 2: 7200 bps enabled
		bit 1: 4800 bps enabled
		bit 0: 2400 bps enabled
 0Dh	BYTE	reserved
 0Eh	WORD	error count (only valid while busy, reset when idle)
 10h	DWORD	size of nonstandard format (NSF) file in bytes
 14h	BYTE	'A' if Connection CoProcessor board present
 15h  9 BYTEs	reserved
 1Eh 21 BYTEs	ASCIZ CCITT identification
 33h 77 BYTEs	reserved

Format of status buffer for Intel SatisFAXtion board:
Offset	Size	Description
 00h	BYTE	connection status flags
		bit 7: busy in T.30 CCITT fax protocol
		bit 6: data on current page/file (only used for block xfers)
		bit 5: retransmission of last page requested
		bit 4: in file transfer mode
		bit 3: data in buffer
		bit 2: data buffer dumped on receive
		bit 1: 200x100 dpi resolution instead of 200x200 dpi
		bit 0: data modem in use, FAX image modem not available
 01h	BYTE	board state
		bit 7: reserved
		bit 6: handset jack active, data and FAX modems not available
		bits 5-3: current bit rate
		    000	 300 bps (V.21 HDLC)
		    100 2400 bps (V.27 ter)
		    101 4800 bps (V.27 ter)
		    110 7200 bps (V.29)
		    111 9600 bps (V.29)
		bits 2-0: T.30 CCITT protocol state
		    000 idle
		    001 dialing
		    010 answering
		    011 transmitting
		    100 receiving
		    101 pre-message
		    110 post-message
		    111 disconnect
 02h	BYTE	number of KB free in buffer
 03h	BYTE	number of pages or files in buffer
 04h	BYTE	number of redials remaining on current number
 05h	BYTE	FAX page number to retransmit
 06h	BYTE	current page/file in block transfer
 07h	BYTE	number of rings received (only if auto-answer enabled)
 08h	WORD	error count
 0Ah	DWORD	length of file being transferred
 0Eh  6 BYTEs	reserved
 14h	BYTE	'B' is SatisFAXtion board present
 15h 13 BYTEs	ASCIZ transfer agent name
 22h  5 BYTEs	ASCIZ transfer agent version number
 27h 13 BYTEs	ASCIZ resident loader name
 34h  5 BYTEs	ASCIZ resident loader version number
 39h 21 BYTEs	ASCIZ remote CSID
 4Eh 13 BYTEs	ASCIZ resident manager name
 5Bh  5 BYTEs	ASCIZ resident manager version number
 60h 32 BYTEs	reserved
Note:	the Intel Connection CoProcessor and SatisFAXtion may be distinguished
	  by examining the byte at offset 14h
----------2FCB13DL00-------------------------
INT 2F - Communicating Applications Specification - GET DIAGNOSTICS RESULTS
	AX = CB13h
	DL = 00h
Return: AX = 0040h in progress
	   >= 0	   passed
	   < 0	   hardware-dependent failure code (see below)
SeeAlso: AX=CB13h/DL=01h

Intel Connection CoProcessor failure codes:
	bit 3: 9600 bps FAX modem module failed
	bit 2: SDLC chip failed
	bit 1: RAM failed
	bit 0: ROM checksum failed

Intel SatisFAXtion failure codes:
	bit 1: 2400 bps data modem failed
	bit 0: 9600 bps FAX modem failed
----------2FCB13DL01-------------------------
INT 2F - Communicating Applications Specification - START DIAGNOSTICS
	AX = CB13h
	DL = 01h
Return: AX = 0000h successfully started
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB13h/DL=00h
----------2FCB14-----------------------------
INT 2F - Communicating Applications Specification - MOVE RECEIVED FILE
	AX = CB14h
	BX = event handle
	CX = receive file number
	     0001h first received file
	     N	   Nth received file
	DS:DX -> ASCIZ string specifying new name for file (must not exist)
Return: AX = 0000h successful
	   < 0	   error code (see AX=CB01h)
----------2FCB15-----------------------------
INT 2F - Communicating Applications Specification - SUBMIT FILE TO SEND
	AX = CB15h
	DS:DX -> variable-length data area (see below)
Return: AX >= 0	event handle
	   < 0	error code (see AX=CB01h)
SeeAlso: AX=CB01h

Format of data area:
Offset	Size	Description
 00h	BYTE	transfer type
		00h = 200x200 dpi, fax mode
		01h = 100x200 dpi, fax mode
		02h = file transfer mode
		03h to 7Fh reserved
 01h	BYTE	text size
		00h = 80 columns
		01h = 132 columns
		02h to 7Fh reserved
 02h	WORD	time to send (DOS packed time format, see INT 21/AX=5700h)
 04h	WORD	date to send (DOS packed date format, see INT 21/AX=5700h)
 06h 32 BYTEs	ASCIZ destination name
 26h 80 BYTEs	ASCIZ name of file to send
 76h 47 BYTEs	ASCIZ phone number to dial
 A5h 64 BYTEs	ASCIZ application-specific tag string
 E5h	BYTE	reserved (00h)
 E6h	BYTE	cover page
		00h don't send cover page
		01h send cover page
		02h to 7Fh reserved
 E7h 23 BYTEs	reserved (zeros)
 FEh variable	ASCIZ string containing text of cover page (if cover page flag
		set to 01h)
----------2FCB16BX1234-----------------------
INT 2F - Communicating Applications Spec v1.2+ - UNLOAD RESIDENT MANAGER
	AX = CB16h
	BX = 1234h
	CX = 5678h
	DX = 9ABCh
Return: AX = 0000h successful
	   < 0	   error code
Note:	the MTEZ XpressFax CASMGR ignores the values in BX,CX, and DX
SeeAlso: AX=C000h"MTEZ",AX=CB00h
----------2FCB17-----------------------------
INT 2F - Communicating Applications Spec v1.2+ - SET COVER PAGE STATUS
	AX = CB17h
	BX = event handle
	CL = cover page status
	    00h not read
	    01h read by user
Return: AX = 0000h successful
	   < 0	   error code
----------2FCB80-----------------------------
INT 2F - Intel SatisFAXtion CASMGR - ???
	AX = CB80h
	???
Return: ???
----------2FCB81-----------------------------
INT 2F - Intel SatisFAXtion CASMGR - ???
	AX = CB81h
	???
Return: ???
----------2FCB82-----------------------------
INT 2F - Intel SatisFAXtion CASMGR - ???
	AX = CB82h
	???
Return: ???
----------2FCBDCBL56-------------------------
INT 2F - Comwave Microfax Specification - GET STATUS ARRAY
	AX = CBDCh
	BL = 56h
	BH = line number (starts with 1)
	CX:DX -> 32-byte status buffer or 80 character string
Return: AX = number of cards installed, or FFFFh on error
Program: Comwave manufacturers the Microfax line of fax cards which are a high-
	  performance multi-card FAX solution for OEMs.
Note:	defaults to AH=CBh but can be changed
SeeAlso: AX=CBDDh,AX=DA00h
----------2FCBDDBL56-------------------------
INT 2F - Comwave Microfax Specification - COMMAND SUBMISSION
	AX = CBDDh
	BL = 56h
	BH = ?
	CX:DX -> command to execute
Return: AX = status
	    0000h success
	    FFFFh on error
SeeAlso: AH=2Ah,AX=CBDCh,AX=80FBh
----------2FCC--SI5453-----------------------
INT 2F U - Qualitas Qcach v4.00
	AH = CCh
	SI = 5453h or 7473h
	AL = ???
	DL = 00h or ???
Return: SI = 7473h
	???
----------2FCD00-----------------------------
INT 2F - Intel Image Processing Interface - INSTALLATION CHECK
	AX = CD00h
Return: AL = 00h not installed, OK to install
	     01h not installed, not OK to install
	     FFh installed
SeeAlso: AX=CD02h"Image"
----------2FCD00-----------------------------
INT 2F - SWELL.EXE - INSTALLATION CHECK
	AX = CD00h
Return: AX = 00FFh installed
	    BH = major version
	    BL = minor version
Note:	SWELL.EXE is a TSR which swaps programs to disk when they EXEC a child
	  process with INT 21/AH=4Bh
----------2FCD01-----------------------------
INT 2F - Intel Image Processing Interface - SET DEVICE NAME
	AX = CD01h
	CX:BX -> ASCIZ character device name ("LPTn", "COMn", "PRN")
Return: AL = 00h successful
		CX:BX -> internal character device name
	   = 80h error
----------2FCD01-----------------------------
INT 2F - SWELL.EXE - SUSPEND ONCE
	AX = CD01h
Return: AX = 0000h
SeeAlso: AX=CD02h"SWELL"
----------2FCD02-----------------------------
INT 2F - Intel Image Processing Interface - GET VERSION NUMBER
	AX = CD02h
Return: AL = 00h/01h successful
		BH = major version number (BCD)
		BL = minor version number (BCD)
	   = 80h error
Note:	if return AL = 01h, the IPI supports network redirection
SeeAlso: AX=CD00h"Image"
----------2FCD02-----------------------------
INT 2F - SWELL.EXE - SUSPEND
	AX = CD02h
Return: AX = 0000h
SeeAlso: AX=CD03h"SWELL"
----------2FCD03-----------------------------
INT 2F - Intel Image Processing Interface - SELECT SCAN LINE
	AX = CD03h
	BX = scan line
	CX = requested density in dots per inch (300, 600, or 1200)
Return: AL = 00h succesful
		CX = density at which scan line was mapped
		ES:DI -> start of scan line
	AL = 80h unsuccessful
	   = 81h scan line out of range
	   = 82h unsupported scan line density
	   = 83h out of memory
SeeAlso: AX=CD04h"Image"
----------2FCD03-----------------------------
INT 2F - SWELL.EXE - ACTIVATE
	AX = CD03h
Return: AX = 0000h
SeeAlso: AX=CD02h"SWELL"
----------2FCD04-----------------------------
INT 2F - Intel Image Processing Interface - MOVE BITMAP TO SCANLINE
	AX = CD04h
	CX:BX -> structure (see below)
Return: AL = 00h successful
	   = 80h unsuccessful
	   = 81h scan line out of range
	   = 82h unsupported scan line density
	   = 83h out of memory
	   = 84h unrecognized source
	   = 85h initialization error
SeeAlso: AX=CD03h"Image"

Format of structure:
Offset	Size	Description
 00h	WORD	image source (0 = conventional memory, 1 = expanded memory)
 02h	DWORD	pointer to image data
 06h	WORD	scan line on which to place
 08h	WORD	bit offset from start of scan line at which to place
 0Ah	WORD	density of bitmap data (300, 600, or 1200 dpi)
 0Ch	WORD	width in bits of data
 0Eh	WORD	source logical page number
 10h	WORD	source handle (only if source in expanded memory)
 12h	WORD	source offset (only if source in expanded memory)
----------2FCD04-----------------------------
INT 2F - SWELL.EXE - TURN OFF VERBOSE MODE
	AX = CD04h
Return: AX = 0000h
SeeAlso: AX=CD05h"SWELL"
----------2FCD05-----------------------------
INT 2F - Intel Image Processing Interface - PRINT PAGE
	AX = CD05h
Return: AL = 00h successful
	   = 80h unsuccessful
Note:	page image is retained, so multiple calls will print multiple copies of
	  the page
SeeAlso: AX=CD06h"Image"
----------2FCD05-----------------------------
INT 2F - SWELL.EXE - TURN ON VERBOSE MODE
	AX = CD05h
Return: AX = 0000h
SeeAlso: AX=CD04h"SWELL"
----------2FCD06-----------------------------
INT 2F - Intel Image Processing Interface - CLEAR PAGE
	AX = CD06h
Return: AL = 00h successful
	   = 80h unsuccessful
Note:	palette is reset to default
SeeAlso: AX=CD09h"Image"
----------2FCD06-----------------------------
INT 2F - SWELL.EXE - UNINSTALL
	AX = CD06h
Return: AX = 0000h uninstalled
	   = 8002h programs still swapped, not uninstalled
----------2FCD07-----------------------------
INT 2F - Intel Image Processing Interface - reserved
	AX = CD07h
----------2FCD07-----------------------------
INT 2F - SWELL.EXE - GET INFO
	AX = CD07h
	ES:BX -> 32-byte buffer for info
Return: AX = 0000h successful
	    ES:BX buffer filled
	   = 8001h buffer wrong size

Format of info buffer:
Offset	Size	Description
 00h	WORD	20h  (total size of buffer)
 02h	BYTE	suspend-once mode active if nonzero
 03h	BYTE	00h active, 01h suspended
 04h	BYTE	00h quiet, 01h verbose
 05h	BYTE	"Borland support" (allowing INT 21/AX=4B01h) on if nonzero
 06h 26 BYTEs	unused???
----------2FCD08-----------------------------
INT 2F - Intel Image Processing Interface - SCREEN IMAGE
	AX = CD08h
	CX:BX -> structure (see below)
Return: AL = 00h successful
	   = 80h unsuccessful
	   = 81h scan line out of range
	   = 82h unsupported scan line density
	   = 83h out of memory
	   = 84h unrecognized source
	   = 85h initialization error
SeeAlso: AX=CD05h"Image",AX=CD09h"Image"

Format of structure:
Offset	Size	Description
 00h	WORD	image source (0 = conventional memory, 1 = expanded memory)
 02h	DWORD	pointer to image data
 06h	WORD	horizontal position on paper of left edge (in 1200 dpi units)
 08h	WORD	vertical position on paper of top edge (in 1200 dpi units)
 0Ah	WORD	left cropping (currently must be zero)
 0Ch	WORD	top cropping (currently must be zero)
 0Eh	WORD	width (currently must be 8000h)
 10h	WORD	height (currently must be 8000h)
 12h	WORD	horizontal size of image in 1200 dpi units
 14h	WORD	vertical size of image in 1200 dpi units
 16h	WORD	aspect ratio (currently reserved)
 18h	WORD	initialization flag (if 01h, initialization is performed)
 1Ah	WORD	pixels per line of source data
 1Ch	WORD	number of scan lines in source data
 1Eh	WORD	number of scan lines in packet
 20h	WORD	bits per pixel (1,2,4,6, or 8)
 22h	WORD	pixels per byte (1,2,4, or 8)
 24h	WORD	compression type (currently only 00h [uncompressed] supported)
 26h	WORD	source page number (if in expanded memory)
 28h	WORD	source handle (if in expanded memory)
 2Ah	WORD	source offset (if in expanded memory)
----------2FCD08-----------------------------
INT 2F - SWELL.EXE - UNUSED
	AX = CD08h
Return: AX = FFFFh (error)
----------2FCD09-----------------------------
INT 2F - Intel Image Processing Interface - LOAD SCREEN
	AX = CD09h
	CX:BX -> structure (see below)
Return: AL = 00h successful
	   = 80h unsuccessful
SeeAlso: AX=CD06h"Image Processing",AX=CD0Ah"Image Processing"

Format of structure:
Offset	Size	Description
 00h	BYTE	style
		44h ('D') diamond style
		4Ch ('L') line style
 01h	BYTE	reserved (00h)
 02h	WORD	frequency in lines per inch [sic]
		currently, coerced to nearest of 50, 60, 68, 70, 75, 85, or 100
 04h	WORD	screen angle in degrees (-360 to 360)
		currently coerced to nearest of -45, 0, 45, or 90
----------2FCD09-----------------------------
INT 2F - SWELL.EXE - TURN OFF "BORLAND SUPPORT"
	AX = CD09h
Return: AX = 0000h
SeeAlso: AX=CD0Ah"SWELL"
----------2FCD0A-----------------------------
INT 2F - Intel Image Processing Interface - LOAD PALETTE
	AX = CD0Ah
	CX:BX -> palette structure (see below)
Return: AL = 00h successful
	   = 80h unsuccessful
SeeAlso: AX=CD09h"Image Processing"

Format of palette structure:
Offset	Size	Description
 00h	BYTE	bits per pixel for which palette is to be used (1,2,4,6, or 8)
 01h	2**N	palette translation values, one per possible pixel value
----------2FCD0A-----------------------------
INT 2F - SWELL.EXE - TURN ON "BORLAND SUPPORT"
	AX = CD0Ah
Return: AX = 0000h
SeeAlso: AX=CD09h"SWELL"
----------2FCF00-----------------------------
INT 2F - TEMPLEXX - INSTALLATION CHECK
	AX = CF00h
Return: AL = FFh if installed
Program: TEMPLEXX is a popup keyboard template by Henson Scientific, Inc.
Note:	values in AL other than 00h cause an immediate return without modifying
	  any registers
----------2FD000-----------------------------
INT 2F - MDEBUG display driver - GET DRIVER STATUS
	AX = D000h
Return: CF set on error
	    all other registers must be unchanged)
	CF clear if successful
	    AL = FFh
	    AH = driver semaphor
		00h driver is not active
		01h driver is active
	    BX = CS of the driver
	    CX = driver version (CH = major, CL = minor, must be >= 013Ch)
	    DL = buffer semaphor
		00h driver is not pending
		01h driver is pending between functions 02h and 03h
	    DH = show semaphor
		00h driver is not pending
		01h driver is pending between functions 04h and 05h
Notes:	MDEBUG is a shareware memory-resident debugging tool by Bernd Schemmer,
	  including a memory monitor, an interpreter and a disassembler
	MDEBUG can use any two consecutive multiplex numbers between C0h and
	  FFh; the default is D0h for the display driver and D1h for the
	  command driver (see INT 60/AH=00h"MDEBUG" for the actual multiplex
	  numbers used)
	this function MUST be reentrant, as MDEBUG calls it after every popup
	  before any other actions.  The handler should not change any
	  registers if the display is in an unsupported mode or in a mode
	  MDEBUG supports itself, e.g. a normal text mode with at least 80x25
	  characters (i.e. 80x43 or 132x44 (v1.60+)). In this case MDEBUG will
	  not call any of the other functions for this popup session.
	MDEBUG will not call the other functions if the returned version is
	  less than the actual version of MDEBUG.
	if the driver is reentrant, DL and DH should be 00h
SeeAlso: AX=D001h,AX=D002h,AX=D003h,AX=D004h,AX=D005h
----------2FD000-----------------------------
INT 2F - ZWmous - INSTALLATION CHECK
	AX = D000h
Return: AX = 5A57h ("ZW") if installed
	    BX = segment of resident code
Note:	ZWmous is a shareware TSR by Zen Wu which permits the use of a mouse
	  with many non-mouse applications by entering the letter under the
	  mouse cursor on button presses
SeeAlso: INT 33/AX=0003h
----------2FD000-----------------------------
INT 2F - Lotus CD/Networker - INSTALLATION CHECK
	AX = D000h
Return: AL = FF if CD/Networker TSR is loaded
	BX = 4D44h ("MD") signature
	CX = Windows mode word (from INT 2F/AX=1600h) at time of TSR load
	DX = bitmap identifying all loaded CD/Networker TSRs.
Notes:	INT 2F/AH=D0h is used by CD/Networker to communicate between a
	  resident redirector TSR and a transient program that controls the
	  TSR's CD-ROM drive emulation (volume attachments, caching, etc).
	At present there is only one CD/Networker TSR; the bitmap always = 4.
SeeAlso: AX=D002h"Lotus",INT 2F/AX=1500h"CD-ROM"
----------2FD001-----------------------------
INT 2F - MDEBUG display driver - INITIALIZE DRIVER
	AX = D001h
Return: CF set on error
	AL = driver semaphor
	AH = buffer semaphor
Notes:	MDEBUG calls this function after every succesful call of the function
	  00h. The function should reset all internal data and the status of
	  the driver. If this function returns an error, MDEBUG will not call
	  the other functions in this popup session.
	MDEBUG can use any two consecutive multiplex numbers between C0h and
	  FFh; the default is D0h for the display driver and D1h for the
	  command driver
SeeAlso: AX=D000h
----------2FD002-----------------------------
INT 2F - MDEBUG display driver - SAVE GRAPHIC DATA
	AX = D002h
Return: CF set on error
	CF clear if successful
	    display memory saved and display switched to one of the text modes
	      02h, 03h or 07h.
Note:	MDEBUG calls this function only once every popup session before
	  displaying its windows.
SeeAlso: AX=D000h,AX=D003h
----------2FD002BX4D44-----------------------
INT 2F - Multiplex - Lotus CD/Networker GET DATA AREA
	AX = D002h
	BX = 4D44h
	DX = bitmap identifying one loaded CD/Networker TSR
Return: ES:DI -> data area owned by TSR
Note:	the format of the data area changes with each minor revision, so it
	  cannot be counted on
SeeAlso: AX=D000h"Lotus"
----------2FD003-----------------------------
INT 2F - MDEBUG display driver - RESTORE GRAPHIC DATA
	AX = D003h
Return: CF set on error
	CF clear if successful
	    display restored to the mode it was in before calling AX=D002h and
	      the display memory is restored
Note:	MDEBUG calls this function only once every popup session just before
	 it exits to normal DOS.
SeeAlso: AX=D000h,AX=D002h
----------2FD004-----------------------------
INT 2F - MDEBUG display driver - SHOW SAVED DATA
	AX = D004h
Return: CF set on error
	CF clear if successful
	    display switched to mode it was in before calling AX=D002h and the
	      display memory is restored
Note:	This function needn't save the display memory before changing it.
SeeAlso: AX=D000h,AX=D005h
----------2FD005-----------------------------
INT 2F - MDEBUG display driver - SWITCH BACK TO TEXT SCREEN
	AX = D005h
Return: CF set on error
	CF clear if successful
	    display restored to mode it was in before calling AX=D004h
Note:	This function needn't save or change the display memory
SeeAlso: AX=D000h,AX=D004h
----------2FD0-------------------------------
INT 2F - MDEBUG display driver - RESERVED FUNCTION NUMBERS
	AH = D0h
	AL = 06h-7Fh
Note:	these functions are reserved for future use
----------2FD0-------------------------------
INT 2F - MDEBUG display driver - USER DEFINED FUNCTION NUMBERS
	AH = D0h
	AL = 80h-FFh
Note:	these functions numbers are reserved for user defined features (e.g.
	  communication between the transient und resident parts of the driver)
----------2FD100-----------------------------
INT 2F C - MDEBUG command driver - GET STATUS
	AX = D100h
	BX = version of MDEBUG (BH = major, BL = minor)
	CX = command driver counter
---v1.60+---
	DS:SI -> MDEBUG identification table (see below)
	ES = segment of display memory used by MDEBUG
	DI = size of video mode used by MDEBUG
	    (high byte = lines, low byte = columns)
Return: DL = FFh
	BX = version number of the driver if it is less than the version in BX,
	     else unchanged
	CX incremented
Notes:	MDEBUG is a shareware memory-resident debugging tool by Bernd Schemmer,
	  including a memory monitor, an interpreter, and a disassembler
	called by MDEBUG at start of popup session; if the version number
	  returned in BX is less than 1.52 (1.60 for MDEBUG v1.70), MDEBUG will
	  not call any of the other functions during this popup session
	MDEBUG can use any two consecutive multiplex numbers between C0h and
	  FFh; the default is D0h for the display driver and D1h for the
	  command driver (see INT 60/AH=00h"MDEBUG" for the multiplex numbers
	  actually used)
	this function must end with a far call to the old INT 2F handler after
	  changing the registers
	this function MUST be reentrant
	command drivers must also declare the following data at the given
	  offsets in the code segment
		100h  3 BYTEs	JMP-command in .COM-files
		103h	BYTE	NOP-command (90h)
		104h 26 BYTEs	signature "Kommandotreiber fÅr MDEBUG"
		11Eh 12 BYTEs	name of driver, e.g. "MDHISDRV.COM"
				each driver must have a unique name
	MDEBUG will pass every key and command to the command driver(s) before
	  checking for a valid internal command
SeeAlso: AX=D000h,AX=D101h

Format of MDEBUG identification table:
Offset	Size	Description
 -2	WORD	entry offset
 00h	WORD	CS of MDEBUG
 02h	DWORD	old INT 08h vector
 06h	DWORD	old INT 09h vector
 0Ah	DWORD	address INT 16h routine used by MDEBUG
 0Eh	BYTE	length of version string
 0Fh  N BYTEs	version string
----------2FD101-----------------------------
INT 2F - MDEBUG command driver - INITIALIZE DRIVER
	AX = D101h
	CX = command driver counter
Return: DL = FFh if successful
		CX incremented
	     else error: all registers unchanged
Note:	this function must end with a  far call to the old INT 2F handler after
	  changing the registers
	this function must be reentrant
----------2FD102-----------------------------
INT 2F - MDEBUG command driver - EXECUTE INTERPRETER COMMAND
	AX = D102h
	BL = first character of the interpreter command
	BH = last character of the interpreter command (or blank)
	DS:SI -> parameter for the interpreter command as ASCIZ string
	DS:DI -> MDEBUG data structure (see below)
Return: AL = FFh
	CF set on error
	    AH = error number
		01h syntax error
		02h first shell of the command.com is activ
		03h esc pressed
		04h break pressed
		05h DOS is busy
		06h command ended
		07h division by zero
		08h invalid display driver
		09h invalid command driver
		0Ah error 8 and 9
		0Bh unknown error
		0Ch new error
		    DS:SI -> ASCIZ error message (max 30 characters)
	       else unknown error
	CF clear if successful
	    AH = return code
		00h continue processing the command line
		01h leave MDEBUG popup session
		02h leave MDEBUG popup session and automatically popup again
		    if the InDOS flag is zero
		03h not used (same as 00h)
		04h not used (same as 00h)
		05h put new command line into the input buffer,
		    DS:SI -> new command line (ASCIZ string, max 66 chars)
		06h process new command line
		    DS:SI -> new command line (ASCIZ string, max 66 chars)
	       else unknown status, but continue processing commmand line
Note:	this function must end with a far call to the old INT 2F handler (with
	  registers unchanged) if the driver does not support the interpreter
	  command in BX.  Otherwise, the driver must not chain to the old
	  INT 2F.

Format of MDEBUG data structure:
Offset	Size	Description
 00h	WORD	register SE
 02h	WORD	register OF
 04h	WORD	register FS
 06h	WORD	register FO
 08h	WORD	register AX
 0Ah	WORD	register BX
 0Ch	WORD	register CX
 0Eh	WORD	register DX
 10h	WORD	register SI
 12h	WORD	register DI
 14h	WORD	register DS
 16h	WORD	register ES
 18h	WORD	register BP
 1Ah	WORD	register SS
 1Ch	WORD	register SP
 1Eh	WORD	register FL (flags)
 20h	WORD	register R0
 22h	WORD	register R1
 24h	WORD	register R2
 26h	WORD	register R3
 28h	WORD	register R4
 2Ah	WORD	register R5
 2Ch	WORD	register R6
 2Eh	WORD	register R7
 30h	WORD	register R8
 32h	WORD	register CS, return-address
 34h	WORD	register IP, return-address
 36h	DWORD	saved pointer to data for key <F6> (v1.60)
		saved monitor address (v1.70)
 3Ah 12 WORDs	saved register values on last popup entry (for <F8> key)
		(original register values at popup entry of MDEBUG)
		AX, BX, CX, DX, SI, DI, DS, ES, BP, SS, SP, flags
 52h 12 WORDs	saved register values on last popup exit (for <SHIFT-F8> key)
		AX, BX, CX, DX, SI, DI, DS, ES, BP, SS, SP, flags
 6Ah	DWORD	address of the DOS-invars-table
 6Eh	DWORD	address of the InDOS flag
 72h	WORD	offset of the register which is used for the segment of the
		first monitor window
 74h	WORD	offset of the register which is used for the offset of the
		first monitor window
 76h	WORD	name of the register which is used for the segment of the
		first monitor segment
 78h	WORD	name of the register which is used for the offset of the first
		monitor window	 
 7Ah	WORD	pseudo register 1
 7Ch	WORD	pseudo register 2
----------2FD103-----------------------------
INT 2F - MDEBUG command driver - EXECUTE KEY IN THE MONITOR
	AX = D103h
	BX = key code (like result of an interrupt 16h call)
	CX = 0 -> the cursor is in the ASCII column of the monitor
	CX = 1 -> the cursor is in one of the hex fields of the monitor
	DS:SI -> MDEBUG data structure (see AX=D102h)
	ES:DI -> actual byte in the monitor
Return: AL = FFh
	AH = return code
	    00h key processed, read next key
	    01h leave MDEBUG popup session
	    02h leave MDEBUG popup session and automatically popup again if DOS
		is not busy
	    03h signal an error (beep)
	    04h driver has redefined the key, proceed with the new key
		BX = new key code
		MDEBUG will not pass the new key to the command driver(s)
	   else treat like code 00h
Note:	this function must end with a far call to the old INT 2F handler (with
	  registers unchanged) if the driver does not support the key in BX.
	  Otherwise, the driver must not chain to the old INT 2F.
SeeAlso: AX=D104h
----------2FD104-----------------------------
INT 2F - MDEBUG command driver - EXECUTE KEY IN THE INTERPRETER
	AX = D104h
	DS:SI -> MDEBUG data structure (see AX=D102h)
Return: AL = FFh
	AH = return code
	    00h key processed, read next key
	    01h leave MDEBUG popup session
	    02h leave MDEBUG popup session and automactically popup again if
		DOS is not busy
	    03h signal an error (beep)
	    04h driver has redefined the key, proceed with the new key
		BX = new key code
		MDEBUG won't pass the new key to the command driver(s)
	    05h put new command line into the input buffer
		DS:SI -> new command line (ASCIZ string, max 66 chars)
	    06h process new command line
		DS:SI -> new command line (ASCIZ string, max 66 chars)
	   else treat like code 00h
Note:	this function must end with a far call to the old INT 2F handler if the
	  driver does not support the key in BX.  Otherwise, the driver must
	  not chain to the old INT 2F.
SeeAlso: AX=D103h
----------2FD1-------------------------------
INT 2F - MDEBUG command driver - RESERVED FUNCTIONS
	AH = D1h
	AL = 05h-0Ah
Note:	these functions are reserved for future use
----------2FD110-----------------------------
INT 2F - MDEBUG command driver - GET ADDRESS OF THE OLD INT 2F
	AX = D110h
Return: DL = FFh
	ES:BX -> next program in the chain for INT 2F
	CX = code segment of this driver
	DI = offset of driver identification table (see below) (v1.60+)
Notes:	only called by the transient part of the driver
	must be reentrant and the driver must not chain this function to the
	  old INT 2F

Format of the driver identification table:
Offset	Size	Description
 00h  26 BYTEs	 signature "Kommandotreiber fÅr MDEBUG"
					     ^- Note: ASCII 129,German U-umlaut
 27h  12 BYTEs	 name of driver, e.g. "MDHISDRV.COM"
		 each driver must have a unique name
----------2FD111-----------------------------
INT 2F - MDEBUG command driver - START DRIVER
	AX = D111h
Return: DL = FFh
Notes:	only called by the transient part of the driver to inform the resident
	  part that it is installed
	the function must be reentrant and the driver mustn't chain this
	  function to the old INT 2F
SeeAlso: AX=D101h,AX=D112h
----------2FD112-----------------------------
INT 2F - MDEBUG command driver - END DRIVER
	AX = D112h
Return: DL = FFh
Notes:	only called by the transient part of the driver to inform the resident
	  part that it will be released after this function
	the function must be reentrant and the driver mustn't chain this
	  function to the old INT 2F
SeeAlso: AX=D101h,AX=D111h
----------2FD1-------------------------------
INT 2F - MDEBUG command driver - RESERVED FUNCTIONS
	AH = D1h
	AL = 13h-7Fh
Note:	these functions are reserved for future use
----------2FD1-------------------------------
INT 2F - MDEBUG command driver - USER DEFINED FUNCTIONS
	AH = D1h
	AL = 80h-FFh
Note:	these functions are reserved for user defined features (e.g.
	  communication between the transient und resident parts of the	driver)
----------2FD200BX5144-----------------------
INT 2F U - Quarterdeck - QEMM/QRAM/VIDRAM/MANIFEST v5.0+ - INSTALLATION CHECK
	AX = D200h
	BX = 5144h ("QD")
	CX = 4D45h ("ME")
	DX = 4D30h ("M0")
Return: AL = FFh installed	  
	if BX,CX,DX registers were as specified on entry:
	    BX = 4D45h ("ME")
	    CX = 4D44h ("MD")
	    DX = 5652h ("VR")
Notes:	QEMM/QRAM/VIDRAM/MANIFEST/etc will search for a free AH value from D2h
	  through FFh, then C0h through D1h
	for AL <> 0, if the BX/CX/DX values don't match a the identifier of a
	  Quarterdeck product, it just chains to the previous INT 2F handler
----------2FD201BX4849-----------------------
INT 2F U - Quarterdeck - GET QD HIMEM PRESENCE
	AX = D201h
	BX = 4849h ("HI")
	CX = 4D45h ("ME")
	DX = 4D51h ("MQ")
Return: BX = 4F4Bh ("OK")
	ES:DI -> HIMEM entry point
Notes:	QEMM/QRAM/VIDRAM/MANIFEST will search for a free AH value from D2h
	  through FFh, then C0h through D1h
SeeAlso: AX=D201h/BX=5145h
----------2FD201BX4849-----------------------
INT 2F U - Quarterdeck - QEMM/QRAM v5.0+ - GET HIRAM MEMORY CHAIN
	AX = D201h
	BX = 4849h ("HI")
	CX = 5241h ("RA")
	DX = 4D30h ("M0")
Return: BX = 4F4Bh ("OK")
	CX = segment of start of HIRAM chain
	DX = QEMM/QRAM code segment
Notes:	QEMM/QRAM/VIDRAM/MANIFEST will search for a free AH value from D2h
	  through FFh, then C0h through D1h
	QEMM and QRAM both responded the same
	the HIRAM memory chain has the same format as the regular DOS 4.0
	  memory chain (see INT 21/AH=52h), except that XMS Upper Memory Blocks
	  have the block header program name field set to "UMB"; blocks whose
	  "owner" field is set to the QEMM/QRAM code segment returned in DX
	  are locked out regions such as video memory and ROMs.
----------2FD201BX4D41-----------------------
INT 2F U - Quarterdeck - MANIFEST v1.0+ - INSTALLATION CHECK
	AX = D201h
	BX = 4D41h ("MA")
	CX = 4E49h ("NI")
	DX = 4645h ("FE")
Return: BX = 5354h ("ST")
Note:	QEMM/QRAM/VIDRAM/MANIFEST will search for a free AH value from D2h
	  through FFh, then C0h through D1h
----------2FD201BX4D45-----------------------
INT 2F U - Quarterdeck - DVDOS4GX.DVR - ???
	AX = D201h
	BX = 4D45h ("ME")
	CX = 5155h ("QU")
	DX = 5044h ("PD")
Return: ???
Notes:	AH=D2h is the default; use the Quarterdeck installation check described
	  under AX=D200h
	called by QEMM 6.03
----------2FD201BX5145-----------------------
INT 2F U - Quarterdeck - QEMM v5.0+ - INSTALLATION CHECK
	AX = D201h
	BX = 5145h ("QE")
	CX = 4D4Dh ("MM")
	DX = 3432h ("42")
Return: BX = 4F4Bh ("OK")
	ES:DI -> QEMM API entry point (see INT 67/AH=3Fh)
Notes:	QEMM/QRAM/VIDRAM/MANIFEST will search for a free AH value from D2h
	  through FFh, then C0h through D1h
	this call is not available under QEMM v6.00 unless Windows3 support
	  has been disabled with the NW3 switch to QEMM386.SYS
SeeAlso: AX=D201h/BX=4849h,INT 67/AH=3Fh
----------2FD201BX5649-----------------------
INT 2F U - Quarterdeck - VIDRAM v5.0+ - INSTALLATION CHECK
	AX = D201h
	BX = 5649h ("VI")
	CX = 4452h ("DR")
	DX = 414dh ("AM")
Return: BX = 4F4Bh ("OK")
	ES:DI -> VIDRAM entry point
Note:	QEMM/QRAM/VIDRAM/MANIFEST will search for a free AH value from D2h
	  through FFh, then C0h through D1h

Call VIDRAM entry point with:
	AH = 00h get status
		Return: AL = VIDRAM state (see below)
			BL = extra RAM status
			    00h VIDRAM does not use extra RAM
			    01h VIDRAM uses EMS as extra RAM
			    02h VIDRAM uses EGA as extra RAM
			BH = feature flags
			    bit 0: override enabled
			    bit 1: mapped memory detected in A000h-B000h range
			    bit 2: top of memory not at 640K
			    bit 3: MDA detected
			    bit 4: high RAM exists in video area
			    bit 5: mapped memory detected in video area
			    bits 6-7: reserved???
			CL = current monitor (01h = mono, 80h = color)
			SI = current top of memory (paragraph)
			DI = segment of start of HiRAM chain
	AH = 01h setup
		AL = VIDRAM state (00h off, 01h no EGA graphics, 02h no graph)
		BL = extra RAM status (see above)
		BH = feature flags (see above)
		CL = monitor (01h = monochrome, 80h = color)
		SI = new top of memory (paragraph)
		DI = segment of start of HiRAM chain
	AH = 02h get end address of VIDRAM code
		Return: ES:DI -> VIDRAM partial map context (see below)
Return: CF set on error
	CF clear if successful

Format of partial map context (EMS 3.2):
Offset	Size	Description
 00h	BYTE	EMS version ID (32h)
 01h	WORD	EMM handle for this entry
 03h	BYTE	number of frames
 04h	BYTE	first page frame
 05h	WORD	offset from ES to previously saved map

Format of partial map context (EMS 4.0):
Offset	Size	Description
 00h	BYTE	EMS version ID (40h)
 01h	WORD	mappable segment count
 03h  N WORD	mappable segments
	WORD	offset to previously saved map???
----------2FD300BX4562-----------------------
INT 2F U - TeleReplica - INSTALLATION CHECK
	AX = D300h
	BX = 4562h
	CX = 2745h
	DX = serial port I/O base address??? (03F8h for v3.9)
Return: SI = segment of resident code
	AX = 251Dh
	BX = DF21h
	CX = F321h
	DX = ???
----------2FD3CB-----------------------------
INT 2F U - LapLink Quick Connect v6 - API
	AX = D3CBh
	CX = function
	    0002h get ???
		Return: BX:AX -> ???
			CL = ???
			CH = ???
			DX = ???
			DI = COM1 I/O port???
			SI = COM2 I/O port???
	    0003h initialization???
	    0004h ???
	    0005h initialization???
	    0006h reset/clear ???
		Return: AX = 0000h
			ES:DI -> next byte after ??? cleared by this call
	    0007h initialization???
	    0008h uninstall
		Return: BX = status
			    0000h successful
			    FFFFh incomplete, stub remains in memory
Return: CX = 534Bh (except function 0002h)
----------2FD44D-----------------------------
INT 2F - 4DOS.COM v2.1+ - API
	AX = D44Dh
	BH = function
	    00h installation check
		Return: AX = 44DDh
			BL = minor version number
			BH = major version number
			CX = PSP segment address for current invocation
			DL = 4DOS shell number (0 for the first (root) shell,
			     updated each time a new copy is loaded)
	    01h (internal, v2.1-3.03) terminate current copy of 4DOS
		Return: nothing
		(internal, v4.0) ???
		Return: ES:BX -> data area (see below)
	    02h ???
		DX = ???
	---v2.1-3.03 only---
	    03h EXEC program
		CX:DX -> EXEC record
	    FEh deallocate shell number (passed through to root shell)
		???
	    FFh allocate shell number (passed through to root shell)
Note:	bug in v3.00 will crash system if unrecognized value in BH
SeeAlso: AX=D44Eh,AX=E44Dh,INT 21/AX=4403h

Format of EXEC record:
Offset	Size	Description
 00h	WORD	offset of ASCIZ program name in same segment as EXEC record
 02h	WORD	offset of DOS commandline in same segment as EXEC record
 04h	WORD	segment of environment for child process (see INT 21/AH=26h)

Format of 4DOS v4.0 data area:
Offset	Size	Description
 00h  2 BYTEs	???
 06h	WORD	XMS handle for swapping
	???
----------2FD44E-----------------------------
INT 2F - 4DOS v3.0+ - AWAITING USER INPUT
	AX = D44Eh
---4DOS v3.01+---
	BX = 0000h 4DOS is ready to display prompt
	   = 0001h 4DOS has displayed the prompt, about to accept user input
Return: handler must preserve SI, DI, BP, SP, DS, ES, and SS
Note:	v3.00 only makes the call corresponding to BX=0001h, does not set BX
SeeAlso: AX=D44Dh
----------2FD44FBX0000-----------------------
INT 2F - 4DOS v4.0+ - KSTACK.COM - INSTALLATION CHECK
	AX = D44Fh
	BX = 0000h
Return: AX = 44DDh if installed
SeeAlso: AX=D44Fh/BX=0001h
----------2FD44FBX0001-----------------------
INT 2F - 4DOS v4.0+ - KSTACK.COM - PLACE KEYSTROKES INTO KEYSTACK
	AX = D44Fh
	BX = 0001h
	CX = number of keystrokes (01h-FFh)
	DS:DX -> keystroke list (one word per keystroke)
Return: AX = status
	    0000h successful
	    nonzero failed
	BX,CX,DX destroyed
Notes:	the keystrokes are the exact values to return from subsequent calls to
	  INT 16 with AH=00h,01h,10h, or 11h, with the following exceptions:
		0000h causes subfunctions 01h and 11h to indicate an empty
			keyboard buffer
		FFFFh is followed by a word indicating the number of clock
			ticks to delay before the next faked keystroke
	v4.00 KSTACK overwrites any unread keystrokes from the previous
	  invocation, and does not range-check CX; it will overwrite memory
	  following the resident portion if CX is greater than 100h.
SeeAlso: AX=D44Fh/BX=0000h,INT 16/AH=00h,INT 21/AX=4403h
----------2FD600-----------------------------
INT 2F - HEART.COM - INSTALLATION CHECK
	AX = D600h
Return: AX = 0303h (two hearts) if installed
	    ES:DI -> buffer (see below)
Program: HEART.COM is a CPU lock-up/critical indicator utility by Mitch Davis.
Notes:	Once the host program has identified the address of the data area, it
	  can change this to indicate safe/critical, alternate colours, etc.
	The entries for the color table are in char/attrib form.  Every two
	  entries form a pair which is alternated between 68 times a minute.
	  The first half of the table is for color videos, the second mono.
	  Within each half, the first half is for the safe chars, and the
	  second for the critical chars.

Format of buffer:
Offset	Size	Description
 00h  8 WORDs	table of colors/attributes (see notes above)
 10h	BYTE	flags
		bit 0: program is in critical section, so flash double
			exclamation mark
		bit 1: program is in safe code, so flash the heart character
 11h	WORD	position of heartbeat on screen, normally 009Eh (last column
		of second line)
----------2FD600-----------------------------
INT 2F U - VEDIT VSWAP - INSTALLATION CHECK
	AX = D600h
Return: AL = D6h if installed
Note:	VSWAP is the resident portion of VEDIT's "swapper" capability.
	VEDIT is a programmer's text editor by Greenview Data.
SeeAlso: AX=D601h,AX=D602h
----------2FD601-----------------------------
INT 2F U - VEDIT VSWAP - ???
	AX = D601h
	BL = subfunction number???
Return: BL = return code ???
	ES = resident portion's data??? segment
	DX = resident portion's code segment
SeeAlso: AX=D600h"VSWAP"
----------2FD602-----------------------------
INT 2F U - VEDIT VSWAP - EXEC PROGRAM WITH SWAP
	AX = D602h
	other registers set as for INT 21/AX=4B00h
Return: CF set on error
	    AL = error code
		82h = failure due to ???
	CF clear on success
SeeAlso: AX=D600h"VSWAP",INT 21/AH=4Bh"EXEC"
----------2FD701-----------------------------
INT 2F - BANYAN VINES v4+ - GET BANV INTERRUPT NUMBER
	AX = D701h
	BX = 0000h
Return: AX = 0000h installed
	    BX = interrupt number (60h to 66h)
	   nonzero not present
Note:	if AX is nonzero, VINES 3.x or earlier may be installed, thus it is
	  necessary to examine the four bytes preceding the handlers for
	  INT 60 through INT 66 for the string "BANV"
SeeAlso: AX=D702h,AX=D703h,AX=D704h
----------2FD702-----------------------------
INT 2F U - BANYAN VINES v4+ - PCPRINT interface
	AX = D702h
	BX = function
	???
Return: ???
SeeAlso: AX=D701h,AX=D703h,INT 61/AX=0005h"Banyan"
----------2FD703-----------------------------
INT 2F U - BANYAN VINES v4+ - MAIL interface
	AX = D703h
	BX = function
	???
Return: ???
SeeAlso: AX=D702h,AX=D704h
----------2FD704-----------------------------
INT 2F U - BANYAN VINES v4+ - Streettalk Directory Assistance interface
	AX = D704h
	BX = function
	???
Return: ???
SeeAlso: AX=D703h,INT 61/AX=0007h"Banyan"
----------2FD800-----------------------------
INT 2F - Novell NetWare Lite - CLIENT.EXE - INSTALLATION CHECK
	AX = D800h
Return:	AL = FFh if installed
	    DX = version number??? (0100h in 1.00)
	    BX = data segment of resident copy???
	    ES:DI = FAR entry point for API routines
		    Load BX = function number and call for various
		    functions.	Functions 00h - 10h supported in 1.00.
SeeAlso: AX=7A00h,AX=D880h
----------2FD880-----------------------------
INT 2F - Novell NetWare Lite - SERVER.EXE - INSTALLATION CHECK
	AX = D880h
Return:	AL = FFh if installed
	    DX = version number??? (0100h in 1.00)
	    BX = Data segment of resident copy???
	    CL = 01h if SERVER is active
	       = 00h if SERVER is disabled
SeeAlso: AX=7A00h,AX=D800h
----------2FDA00-----------------------------
INT 2F - ZyXEL ZFAX - INSTALLATION CHECK
	AX = DA00h
Return: AH = enabled state (00h = enabled, 01h = disabled)
	AL = 5Ah installed
Note:	ZFAX is the bundled FAX software which comes with the ZyXEL model
	  fax modems.
SeeAlso: AX=CBDCh,AX=DA01h,AX=DA02h,AX=DA03h
----------2FDA01-----------------------------
INT 2F - ZyXEL ZFAX - UNINSTALL
	AX = DA01h
Return: AL = 00h Success
	     01h Failure
SeeAlso: AX=DA00h
----------2FDA02-----------------------------
INT 2F - ZyXEL ZFAX - DISABLE
	AX = DA02h
Return: AL = 00h
SeeAlso: AX=DA03h
----------2FDA03-----------------------------
INT 2F - ZyXEL ZFAX - ENABLE
	AX = DA03h
Return: AL = 00h
SeeAlso: AX=DA02h
----------2FDA55-----------------------------
INT 2F U - TRAP.COM - INSTALLATION CHECK
	AX = DA55h
	DL = interrupt number
	DH = ???
Return: if installed
	    AH = interrupt number
	    AL = ???
	    ES:BX -> ???
Notes:	TRAP is an interrupt call tracer by Patrick Phillipot/Udo Chrosziel
	a separate copy of TRAP is loaded for each interrupt to be traced; thus
	  the interrupt number is part of the installation check
----------2FDC00-----------------------------
INT 2F - GOLD.COM - INSTALLATION CHECK
	AX = DC00h
Return: AL = 00h not installed
	   = FFh installed
Note:	GOLD is a TSR by Bob Eager which makes the NumLock key return the code
	  for F1; the purpose is to improve Kermit's VTxxx emulation
----------2FDC01-----------------------------
INT 2F - GOLD.COM - GET STATE
	AX = DC01h
Return:	AL = status
	    00h off
	    01h on
SeeAlso: AX=DC00h,AX=DC02h
----------2FDC02-----------------------------
INT 2F - GOLD.COM - SET STATE
	AX = DC02h
	DL = new state
	    00h off
	    01h on
Return: AL = 00h (OK)
SeeAlso: AX=DC01h
----------2FDD-------------------------------
INT 2F - SoftCom programs - API
	AH = DDh
	AL = FEh get info
	    Return: ES:BX -> TSR info list (see below)
	AL = program identifier
	    BH = function
		FDh get version
		    Return: BX = version
		FFh installation check
		    Return: AL = FFh if installed
				BX = version
				ES = segment of resident code
		others vary by program
Return: AL = status
	    bit 7 set on error
	    AL = 81h unknown function

Format of TSR info list:
Offset	Size	Description
 00h  9 BYTEs	blank-padded ASCIZ program name
 09h	BYTE	program ID
 0Ah	WORD	program's PSP segment
 0Ch	WORD	program version (major in high byte)
 0Eh	DWORD	pointer to next item in info list or 0000h:0000h
 12h	BYTE	number of interrupts hooked
 13h  5 BYTEs	interrupt numbers hooked by program
 18h  8 BYTEs	reserved
----------2FDE00BX4445-----------------------
INT 2F - DESQview v2.26+ External Device Interface - INSTALLATION CHECK
	AX = DE00h
	BX = 4445h ("DE")
	CX = 5844h ("XD")
	DX = 4931h ("I1")
Return: AL = FFh if installed (even if other registers do not match)
	if BX,CX, and DX were as specified on entry,
	    BX = 4845h ("HE")
	    CX = 5245h ("RE")
	    DX = 4456h ("DV")
Notes:	AH=DEh is the default XDI multiplex number, but may range from C0h-FFh
	programs should check for XDI starting at DEh to FFh, then C0h to DDh
	the XDI handler should not issue any DOS or BIOS calls, nor should it
	  issue DESQview API calls other than those allowed from hardware ints
SeeAlso: AX=DE02h,INT 15/AX=5400h
----------2FDE01-----------------------------
INT 2F - DESQview v2.26+ External Device Interface - DRIVER CUSTOM SUBFUNCTION
	AX = DE01h
	BX = driver ID
	other registers as needed by driver
Notes:	XDI drivers should pass this call through to previous handler if ID
	  does not match
	DESQview never calls this function
----------2FDE01BX4450-----------------------
INT 2F U - Quarterdeck QDPMI.SYS v1.0 - INSTALLATION CHECK
	AX = DE01h
	BX = 4450h ("DP")
	CX = 4D49h ("MI")
	DX = 3039h ("09")
Return: AL = FFh if installed
	    BX = 4D42h ("MB")
	    CX = 4921h ("I!")
	    DX = 8F4Fh
	    ES:DI -> filename of DPMI host overlay
Note:	the installation check consists of testing for the existence of the
	  character device QDPMI$$$
----------2FDE01BX5242-----------------------
INT 2F - DESQview v2.26+ XDI - CUSTOM SUBFUNCTION, Ralf Brown's XDI drivers
	AX = DE01h
	BX = 5242h ("RB")
	CX:DX = program identifier
		656F7000h ("eop",0) for DVeop
Return: AX = 5242h ("RB") if installed
	    ES:BX -> data or entry point
	    CX = version number (CH = major, CL = minor)

Call DVeop entry point with:
	ES:DI -> callback address or 0000h:0000h to remove callback
Return: AX = status
	    0000h failed (callback table full or attempted to remove non-
			existent callback)
	    0001h successful
		ES:DI -> chaining address
	BX,CX,DX destroyed
Notes:	the callback function is called with a simulated interrupt when the
	  DESQview window containing it is closed; it should perform all
	  necessary cleanup and then perform a FAR jump to the chaining address
	  or an IRET if the chaining address is 0000h:0000h
	if the program wishes to remove itself before the window is closed, it
	  should call the DVeop entry point with the previously returned
	  chaining address and ignore the returned chaining address.
----------2FDE01BX7474-----------------------
INT 2F - DESQview v2.26+ XDI - CUSTOM SUBFUNCTION, DVTXDI.COM
	AX = DE01h
	BX = 7474h
	CL = function
	    00h installation check
		Return: AL = FFh
	    01h get process handle
		DX = keys on Open Window menu (DL = first, DH = second)
		Return: AX = process handle or 0000h if not running
	    02h (v1.3+) set TMAN handle
		DX = TMAN process handle
	    03h (v1.3+) set open keys to ignore on next CL=01h call
		DX = keys on Open Window menu (DL = first, DH = second)
Return: BX = 4F4Bh ("OK")
	DL destroyed
Note:	DVTXDI is distributed as part of the shareware products DVTree (DOS
	 shell/DESQview process manager) and DVTMAN by Mike Weaver
----------2FDE01BX7575-----------------------
INT 2F - DESQview v2.26+ XDI - CUSTOM SUBFUNCTION, DVSIXDI.COM
	AX = DE01h
	BX = 7575h
	CX = function
	    0000h installation check
		Return: AX = 00FFh if installed
	    0001h turn on notification (currently unused)
		Return: AX = 0001h
	    0002h turn off notification (currently unused)
		Return: AX = 0001h
	    0003h get process information
		Return: AX = status
			    0000h failed
			    0001h successful
				BX = last instantaneous time slice
					in 1/100s (v1.10)
					in 1/18s (v1.11+)
				CX = number of processes
				DX = number of "(starting)" records (v2.00+)
				SI = number of records in process info array
				     (v2.00+) (always 15 for v1.x)
				ES:DI -> process info array (see below)
	    0004h get version
		Return: AH = major version
			AL = minor version
	    0005h (v1.10+) get time since DESQview started
		Return: DX:AX = 1/100s since DV start (v1.10)
			DX:AX = 1/18s since DV start (v1.11+)
	    0006h (v1.10+) get number of task switches
		Return: DX:AX = total task switches
			CX = task switches in last instantaneous interval
Notes:	DVSIXDI is part of the DVSI (DESQview System Information) package by
	  Daniel J. Bodoh
	for v1.00, function 0003h allocates common memory, which the caller
	  must deallocate after reading the process information; only the
	  currently used records are placed in the buffer
	for v1.10+, function 0003h merely returns a pointer to the internal
	  array of process information; the caller should make a copy of the
	  array while inside a critical section (see INT 15/AX=101Bh).	Only
	  those records with bit 7 of the first byte set are valid.

Format of information for one process (v1.00):
Offset	Size	Description
 00h	BYTE	flags
		bit 7: process slot is valid
 01h	WORD	offset into DESQVIEW.DVO of program's record if started from
		Open Windows menu, else undefined
 03h	WORD	Switch Windows window number
 05h	WORD	segment of process handle
 07h	WORD	number of tasks owned by process
 09h	WORD	mapping context of process
 0Bh	DWORD	hook for other programs

Format of information for one process (v1.10-v2.00):
Offset	Size	Description
 00h	BYTE	flags
		bit 7: valid record
		    6: (v2.00+) record is allocated; if bit 7 clear, process
			is "(starting)" and only offsets 01h and 09h are valid
		    5: (v2.00+) this app currently owns the CPU
		    4: reserved (0)
		    3: DESQview system task
		    2: reserved (0)
		    1: task has keyboard (currently unused)
		    0: task swapped out (currently unused)
 01h	WORD	Open Window keys
 03h	WORD	Switch Windows number
 05h	WORD	segment of process handle
 07h	WORD	number of tasks for process
 09h	WORD	process mapping context
 0Bh	DWORD	time process started (relative to start of DESQview)
 0Fh	DWORD	time process last got CPU (relative to start of DESQview)
 13h	DWORD	time process last gave up CPU (relative to start of DESQview)
 17h	DWORD	total CPU time since process started
 1Bh	DWORD	CPU time at start of current instantaneous interval
 1Fh	DWORD	CPU time in current instantaneous interval
 23h	DWORD	hook for other programs
Note:	all times are in 1/100s for v1.10, in 1/18s for v1.11+
----------2FDE01BXFFFE-----------------------
INT 2F U - DESQview v2.26+ XDI - DVXMS.DVR - ???
	AX = DE01h
	BX = FFFEh
	CX = 4D47h ("MG")
	DX = 0052h (0,"R")
Return: AL = FFh
	DX = 584Dh
----------2FDE02-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - DV INITIALIZATION COMPLETE
	AX = DE02h
	BX = mapping context of DESQview
	DX = handle of DESQview system task
Note:	driver should pass this call to previous handler after doing its work
SeeAlso: AX=DE03h,AX=DE0Fh,INT 15/AX=5400h
----------2FDE03-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - DV TERMINATION
	AX = DE03h
	BX = mapping context of DESQview
	DX = handle of DESQview system task
Notes:	driver should pass this call to previous handler before doing its work
	DESQview makes this call when it is exiting, but before unhooking any
	  interrupt vectors
SeeAlso: AX=DE02h,AX=DE0Fh,INT 15/AX=5407h
----------2FDE04-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - ADD PROCESS
	AX = DE04h
	BX = mapping context of new process
	DX = handle of process
Return: nothing
Notes:	XMS XDI handler (installed by default) allocates a 22-byte record
	  (see below) from "common" memory to control access to XMS memory
	all DOS, BIOS, and DV API calls are valid in handler
	driver should pass this call to previous handler after processing it
SeeAlso: AX=DE05h,AX=DE06h,INT 15/AX=5401h

Format of XMS XDI structure:
Offset	Size	Description
 00h	DWORD	pointer to 10-byte record???
 04h	DWORD	pointer to next XMS XDI structure
 08h	WORD	mapping context
 0Ah	BYTE	???
 0Bh  5 BYTEs	XMS entry point to return for INT 2F/AX=4310h
		(FAR jump to next field)
 10h  6 BYTEs	FAR handler for XMS driver entry point
		(consists of a FAR CALL followed by RETF)
----------2FDE05-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - REMOVE PROCESS
	AX = DE05h
	BX = mapping context of process
	DX = handle of last task in process
Return: nothing
Notes:	XMS XDI handler releases the structure allocated by AX=DE04h
	driver should pass this call to previous handler before processing it
	all DOS, BIOS, and DV API calls except those generating a task switch
	  are valid in handler
SeeAlso: AX=DE04h,AX=DE07h,INT 15/AX=5402h
----------2FDE06-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - CREATE TASK
	AX = DE06h
	BX = mapping context of process containing task
	DX = handle of new task
Notes:	driver should pass this call to previous handler after processing it
	all DOS, BIOS, and DV API calls are valid in handler
----------2FDE07-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - TERMINATE TASK
	AX = DE07h
	BX = mapping context of process containing task
	DX = handle of task
Notes:	driver should pass this call to previous handler before processing it
	all DOS, BIOS, and DV API calls except those generating a task switch
	  are valid in handler
SeeAlso: AX=DE04h,AX=DE06h,AX=DE10h
----------2FDE08-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - SAVE STATE
	AX = DE08h
	BX = mapping context of task being switched from
	DX = handle of task being switched from
Notes:	invoked prior to task swap, interrupts, etc
	driver should pass this call to previous handler after processing it
SeeAlso: AX=DE09h,INT 15/AX=5403h,INT 15/AX=DE27h
----------2FDE09-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - RESTORE STATE
	AX = DE09h
	BX = mapping context of task being switched to
	DX = handle of task being switched to
Notes:	state is restored except for interrupts
	driver should pass this call to previous handler before processing it
SeeAlso: AX=DE08h,INT 15/AX=5404h,INT 15/AX=DE27h
----------2FDE0A-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - CHANGE KEYBOARD FOCUS
	AX = DE0Ah
	BX = mapping context of task receiving focus
	DX = handle of running task
Notes:	driver should pass this call to previous handler before processing it
	this call often occurs inside a keyboard interrupt
SeeAlso: INT 15/AX=DE26h,INT 15/AX=DE2Fh
----------2FDE0B-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - DVP PROCESSING COMPLETE
	AX = DE0Bh
	BX = mapping context of DESQview system task
	CX = number of system memory paragraphs required for the use of all
		XDI drivers (DV will add this to system memory in DVP buffer)
	DX = handle of DESQview system task
	SI = mapping context of new process if it starts
	ES:DI -> DVP buffer
Return: CX incremented as needed
Notes:	once DV invokes this function, the DVP buffer contents may be changed
	driver should pass this call to previous handler before processing it
----------2FDE0C-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - SWAP OUT PROCESS
	AX = DE0Ch
	BX = mapping context of task being swapped out
	DX = handle of DESQview system task
Note:	driver should pass this call to previous handler after processing it
----------2FDE0D-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - SWAP IN PROCESS
	AX = DE0Dh
	BX = mapping context of process just swapped in
	DX = handle of DESQview system task
Note:	driver should pass this call to previous handler before processing it
----------2FDE0E-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - DVP START FAILED
	AX = DE0Eh
	BX = mapping context of DESQview system task
	DX = handle of DESQview system task
	SI = mapping context of failed process (same as for call to AX=DE0Bh)
Note:	driver should pass this call to previous handler after processing it
----------2FDE0F-----------------------------
INT 2F C - DESQview v2.50+ External Dev Interface - INITIALIZE DV
	AX = DE0Fh
Note:	DESQview 2.50+ calls this function just before it completes its
	  initialization.  At the time of the call, DESQview has not yet
	  changed any interrupt vectors
SeeAlso: AX=DE02h
----------2FDE10-----------------------------
INT 2F C - DESQview v2.50+ External Dev Interface - FREE TASK
	AX = DE10h
	BX = mapping context of process
	DX = task handle of process
Note:	DESQview 2.50+ calls this function before it frees the task; it is
	  similar to AX=DE07h but allows the XDI handler to make calls which
	  cause context switches
SeeAlso: AX=DE06h,AX=DE07h
----------2FDF00-----------------------------
INT 2F - HyperWare programs - INSTALLATION CHECK
	AX = DF00h
	BX = product code
	    4248h ('BH') HyperStb
	    4448h ('DH') HyperDisk v4.20+
	    4B48h ('KH') HyperKey
	    5348h ('SH') HyperScreen
	CX = 0000h
	DX = 0000h
Return: AL = status
	    00h not installed
	    FFh multiplex number in use
		CX = 5948h ('YH') if selected product installed
		---HyperDisk---
		BX = code segment of resident portion
		DX = HyperDisk local data version
Program: HyperDisk is a shareware disk cache by HyperWare (Roger Cross)
Note:	AH=DFh is the default; if it is already in use by some other program,
	  HyperWare programs then scan multiplex numbers from C0h through FFh
SeeAlso: INT 13/AX=8EEDh
---------------------------------------------
INT 2F - HyperDisk v4.50+ - GET CURRENT CACHE STATE
	AX = DF01h
	BX = 4448h ('DH')
Return: AX = 0000h if function supported
	    BX = number of cache buffers in use
	    CX = number of cache buffers which have been modified
	    DL = caching flags (see below)
Note:	AH=DFh is the default; if it is already in use by some other program,
	  HyperWare programs then scan multiplex numbers from C0h through FFh
SeeAlso: AX=DF00h,AX=DF02h

Bitmask of caching flags:
 bit 0: staged writes enabled for floppy disks
 bit 1: staged writes enabled for hard disks
 bit 2: writes verified on floppy disks
 bit 3: writes verified on hard disks
 bit 4: reserved (0)
 bit 5: reserved (0)
 bit 6: floppy caching enabled
 bit 7: all caching functions enabled
---------------------------------------------
INT 2F - HyperDisk v4.50+ - SET CACHE STATE
	AX = DF02h
	BX = 4448h ('DH')
	DL = new caching flags (see AX=DF01h)
Return: AX = 0000h if supported
	    BX = number of cache buffers in use
	    CX = number of cache buffers which have been modified
	    DL = previous caching flags (see AX=DF01h)
Program: HyperDisk is a shareware disk cache by HyperWare (Roger Cross)
Note:	AH=DFh is the default; if it is already in use by some other program,
	  HyperWare programs then scan multiplex numbers from C0h through FFh
SeeAlso: AX=DF00h,AX=DF01h
----------2FE000-----------------------------
INT 2F - SETDRVER.COM v2.10+ - INSTALLATION CHECK
	AX = E000h
Return: AX = 4A52h ("JR") if present
Program: SETDRVER is a public domain TSR by Jacob Rieper which sets the
	  apparent DOS version analogously to MSDOS SETVER
Note:	this installation check differs from the usual one of returning AL=FFh
SeeAlso: AX=E001h,INT 21/AH=52h
----------2FE001-----------------------------
INT 2F - SETDRVER.COM v2.10+ - GET SETDRVER VERSION
	AX = E001h
Return: AH = major version
	AL = minor version
SeeAlso: AX=E000h
----------2FE002-----------------------------
INT 2F - SETDRVER.COM v2.10+ - GET ORIGINAL DOS VERSION INFO
	AX = E002h
Return: AL = FFh if successful
	    BH = major DOS version
	    BL = minor DOS version
	    CH = DOS version flag
	    CL = OEM number
	    DH = major DR-DOS version number (FFh if unknown)
	    DL = minor DR-DOS version number (FFh if unknown)
SeeAlso: AX=E003h,AX=E007h,INT 21/AH=30h
----------2FE003-----------------------------
INT 2F - SETDRVER.COM v2.10+ - RESET INTERNAL VARIABLES
	AX = E003h
	BH = new major DOS version
	BL = new minor DOS version
	CH = new DOS version flag
	CL = new DOS revision number
	DH = new OEM number
SeeAlso: AX=E002h
----------2FE004-----------------------------
INT 2F - SETDRVER.COM v2.10+ - ENABLE TSR
	AX = E004h
Return: AL = FFh if successful
SeeAlso: AX=E000h,AX=E005h,AX=E006h
----------2FE005-----------------------------
INT 2F - SETDRVER.COM v2.10+ - DISABLE TSR
	AX = E005h
Return: AL = FFh if successful
SeeAlso: AX=E000h,AX=E004h,AX=E006h
----------2FE006-----------------------------
INT 2F - SETDRVER.COM v2.10+ - GET TSR STATUS
	AX = E006h
Return: AL = FFh if successful
	    BL = status
		01h resident and active
		02h resident and inactive
----------2FE007-----------------------------
INT 2F - SETDRVER.COM v2.10+ - GET TaskMAX STATUS AT INSTALLATION
	AX = E007h
Return: AL = FFh if successful
	    BL = status
		00h if TaskMAX not loaded before SETDRVER
		FFh if TaskMAX was loaded before SETDRVER
SeeAlso: AX=E003h
----------2FE0-------------------------------
INT 2F - SETDRVER.COM - RESERVED FOR FUTURE USE
	AH = E0h
	AL = 08h-10h
----------2FE300-----------------------------
INT 2F - ANARKEY.COM - INSTALLATION CHECK
	AX = E300h
Return: AL = 00h not installed
	     FEh if installed but suspended (v3.0+)
	     FFh installed
Notes:	ANARKEY.COM is a commandline recall program by Steven Calwas
	E3h is the default function number, but can be set to any value from
	  C0h to FFh
SeeAlso: AX=E301h,AX=E302h,AX=E303h,AX=E304h,AX=E305h,AX=E306h,AX=E307h
----------2FE301-----------------------------
INT 2F U - ANARKEY.COM v2+ - GET ???
	AX = E301h
Return: DX:BX -> ???
SeeAlso: AX=E300h

Format of returned data structure for ANARKEY v2.0:
Offset	Size	Description
 -7   7 BYTEs	signature ('ANARKEY')
 00h	WORD	??? (I see 0001h in v2.0)
 02h	WORD	??? (I see 0001h in v2.0)
 04h	WORD	??? (I see 0 in v2.0)
 06h	WORD	PSP segment of next program loaded

Format of returned data structure for ANARKEY v3+:
Offset	Size	Description
 -1	BYTE	multiplex number
 00h	WORD	??? (I see 0001h in v3.0-4.0)
 02h	WORD	??? (I see 0001h in v3.0-4.0)
 04h	BYTE	??? (I see 0 in v3.0-4.0)
 05h	WORD	PSP segment of next program loaded
----------2FE302-----------------------------
INT 2F U - ANARKEY.COM v3+ - ???
	AX = E302h
	BL = ???
Return: ???
SeeAlso: AX=E300h
----------2FE303-----------------------------
INT 2F U - ANARKEY.COM v3+ - ANARKMD API
	AX = E303h
	BL = function
	    01h	toggle insert mode
	    02h	display contents of history buffer
	    03h	write history buffer to file
		ES:DX -> file name
	    04h	clear history buffer
	    05h	undefine all aliases
	    06h	show aliases
	    07h	list programs using Unix switchar
	    08h	jump to bottom of history buffer	
	    09h (v4.0) add string to history buffer
		ES:DX -> ASCIZ string
	    0Ah (v4.0) ???
		ES:DX -> ???
	    0Bh (v4.0) copy string to edit buffer for use as next input line
		ES:DX -> ASCIZ string
	    0Ch (v4.0) ???
	    0Dh (v4.0) copy ??? to ???
	    0Eh (v4.0) ???
	    0Fh (v4.0) ???
	    10h (v4.0) set ??? flag
	    11h (v4.0) display error message about running in EMS under Windows
Return: ???
SeeAlso: AX=E300h
----------2FE304-----------------------------
INT 2F U - ANARKEY.COM v2+ - ???
	AX = E304h
	BL = ???
Return: ???
SeeAlso: AX=E300h
----------2FE305-----------------------------
INT 2F U - ANARKEY.COM v3+ - ENABLE/SUSPEND ANARKEY
	AX = E305h
	BL = new state
	    01h suspended
	    00h enabled
SeeAlso: AX=E300h
----------2FE306-----------------------------
INT 2F U - ANARKEY.COM v4.0 - GET ???
	AX = E306h
Return: AX = ???
SeeAlso: AX=E300h
----------2FE307-----------------------------
INT 2F U - ANARKEY.COM v4.0 - GET ???
	AX = E307h
Return: AX = ???
	BL = ???
SeeAlso: AX=E300h
----------2FE44D-----------------------------
INT 2F - NDOS - API
	AX = E44Dh
Note:	as NDOS is a licensed version of 4DOS v3.03, the API is identical to
	  that for 4DOS, except that AH=E4h instead of D4h and the installation
	  check returns AX=44EEh instead of AX=44DDh
SeeAlso: AX=D44Dh,AX=E44Eh
----------2FE44EBX0000-----------------------
INT 2F - NDOS - AWAITING USER INPUT
	AX = E44Eh
	BX = 0000h NDOS is ready to display prompt
	   = 0001h NDOS has displayed the prompt, about to accept user input
Return: handler must preserve SI, DI, BP, SP, DS, ES, and SS
SeeAlso: AX=E44Dh
----------2FED00-----------------------------
INT 2F - Phar Lap DOS EXTENDERS - INSTALLATION CHECK
	AX = ED00h
	BL = DOS extender
	    01h 286dosx v1.3+ (Software Development Kit)
	    02h 286dosx v1.3+ (Run-Time Kit)
	    03h 386dosx v4.0+ (SDK)
	    04h 386dosx v4.0+ (RTK)
Return: AL = status
	    00h not installed
	    FFh installed
		SI = 5048h ("PH")
		DI = 4152h ("AR")
		CH = major version number
		CL = minor version number
		DX = flags
		    bit 0: running under DPMI
			1: running under Phar Lap VMM
SeeAlso: AH=A1h,AX=F100h,AX=FBA1h
----------2FED80-----------------------------
INT 2F - Phar Lap 286|DOS Extender Lite v2.5 - ???
	AX = ED80h
	BL = DOS extender ID (see AX=ED00h)
	SI = 5048h ("PH")
	DI = 4152h ("AR")
	???
Return: ???
----------2FEE00-----------------------------
INT 2F - GRIDLOC.EXE - INSTALLATION CHECK
	AX = EE00h
Return: AL = FFh if installed
Note:	GRIDLOC is a PC security program by Intelligent Security Systems, Inc.
----------2FF000-----------------------------
INT 2F U - 4MAP - INSTALLATION CHECK
	AX = F000h
Return: AX = 00FFh
Notes:	returns AX=00FFh for any value of AL not listed here
	4MAP is a keybinding program for 4DOS (see AX=D44Dh) by Ho-Ping Tseng
----------2FF001-----------------------------
INT 2F U - 4MAP - GET KEY MAPPINGS
	AX = F001h
Return: ES:BX -> key mappings
SeeAlso: AX=F000h
----------2FF002-----------------------------
INT 2F U - 4MAP - INSERT CHARACTER INTO ???
	AX = F002h
	BL = character to insert
Return: AX = status
	    0000h successful
	    0001h buffer full
SeeAlso: AX=F000h,AX=F003h
----------2FF003-----------------------------
INT 2F U - 4MAP - INSERT CHARACTER INTO ???
	AX = F003h
	BL = character to insert
Return: AX = status
	    0000h successful
	    0001h buffer full
SeeAlso: AX=F000h,AX=F002h
----------2FF1-------------------------------
INT 2F U - MIN-MEM v2.11 - INSTALLATION CHECK
	AH = F1h
	AL <> F1h
Return: AL = F1h if installed
Note:	MIN-MEM is a shareware TSR manager by Biologic which permits up to 24
	  popup TSRs to be loaded but swapped out to disk, EMS, or XMS.	 One
	  TSR at a time is brought back into memory at the user's request.
----------2FF100-----------------------------
INT 2F - DOS EXTENDER INSTALLATION CHECK
	AX = F100h
Return: AL = FFh if DOS extender present
	    SI = 444Fh ("DO")
	    DI = 5358h ("SX")
Note:	supported or soon to be supported by Phar Lap, Rational, Ergo, and IGC
SeeAlso: AH=A1h,AX=ED00h,AX=FBA1h/BX=0081h,INT 15/AX=BF02h
----------2FF700-----------------------------
INT 2F - AUTOPARK.COM - INSTALLATION CHECK
	AX = F700h
Return: AL = 00h not installed
	     FFh installed
Note:	AUTOPARK.COM is a resident hard disk parker by Alan D. Jones
----------2FF701-----------------------------
INT 2F - AUTOPARK.COM - SET PARKING DELAY
	AX = F701h
	BX:CX = 32-bit count of 55ms timer ticks
----------2FF800CX4455-----------------------
INT 2F U - SuperStor PRO 2XON.COM - INSTALLATION CHECK
	AX = F800h
	CX = 4455h ("DU")
	DL = 45h ("E")
Return: AL = FFh if installed
	    ES:BX -> ASCII signature "Universal Data Exchange"
Program: SuperStor is a disk-compression program by Addstor.
Note:	returns AX=0001h if AL is not 00h or 01h
SeeAlso: AX=1001h,AX=F801h
----------2FF801CX4455-----------------------
INT 2F U - SuperStor PRO 2XON.COM - UNINSTALL
	AX = F801h
	CX = 4455h ("DU")
	DL = 45h ("E")
	ES:BX = return address if successful
Return: at specified address if successfully removed from memory
	else
	    AL = error code
	    ???
Program: SuperStor is a disk-compression program by Addstor.
Note:	returns AX=0001h if AL is not 00h or 01h
SeeAlso: AX=1001h,AX=F800h
----------2FFB-------------------------------
INT 2F - Multiplex - RESERVED BY BORLAND INTERNATIONAL
	AH = FBh
----------2FFB00-----------------------------
INT 2F U - AutoBraille v1.1A - INSTALLATION CHECK
	AX = FB00h
Return: AX = 00FFh if installed
Note:	AutoBraille is a shareware text-to-braille converter by KANSYS, Inc.
SeeAlso: INT 10/AH=38h,INT 14/AX=F0F1h
----------2FFB00-----------------------------
INT 2F U - Jot-It! v1.50 - INSTALLATION CHECK
	AX = FB00h
Return: AX = FFFFh if installed
	    BX = version (BCD, BH=major, BL=minor)
SeeAlso: AX=FB03h"Jot-It",AX=FB01h"Jot-It"
----------2FFB01-----------------------------
INT 2F U - AutoBraille v1.1A - ???
	AX = FB01h
	???
Return: ???
----------2FFB01-----------------------------
INT 2F U - Jot-It! v1.50 - GET USER NAME
	AX = FB01h
Return: DX:BX -> ASCIZ user name
SeeAlso: AX=FB02h"Jot-It"
----------2FFB02-----------------------------
INT 2F U - AutoBraille v1.1A - ???
	AX = FB02h
Return: AH = ???
	AL = ???
----------2FFB02-----------------------------
INT 2F U - Jot-It! v1.50 - GET MESSAGE DIRECTORY
	AX = FB02h
Return: DX:BX -> ASCIZ name of directory in which messages are stored
SeeAlso: AX=FB01h"Jot-It"
----------2FFB03-----------------------------
INT 2F U - AutoBraille v1.1A - GET NEXT ???
	AX = FB03h
Return: AX = ???
----------2FFB03-----------------------------
INT 2F U - Jot-It! v1.50 - UNINSTALL
	AX = FB03h
Return: resident code removed from memory
Note:	CAUTION: NO checks are performed to ensure that the interrupt vectors
	  being unhooked (08h,09h,28h,2Fh) actually point at the Jot-It! code
SeeAlso: AX=FB00h"Jot-It"
----------2FFB-------------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AH = FBh
	AL = 04h-08h
Return: AX = 0000h
----------2FFB-------------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AH = FBh
	AL = 09h-0Fh (???, 0Eh = COM1, 0Fh = COM2)
Return: ???
Note:	AutoBraille is a shareware text-to-braille converter by KANSYS, Inc.
----------2FFB-------------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AH = FBh
	AL = 10h-1Fh
	???
Return: ???
----------2FFB20-----------------------------
INT 2F U - AutoBraille v1.1A - SET ??? FLAGS
	AX = FB20h
	BL = flags to set
SeeAlso: AX=FB21h"AutoBraille"
----------2FFB21-----------------------------
INT 2F U - AutoBraille v1.1A - CLEAR ??? FLAGS
	AX = FB21h
	BL = flags to clear
SeeAlso: AX=FB20h"AutoBraille"
----------2FFB22-----------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AX = FB22h
	BL = ???
Note:	AutoBraille is a shareware text-to-braille converter by KANSYS, Inc.
----------2FFB28-----------------------------
INT 2F U - AutoBraille v1.1A - ???
	AX = FB28h
	BX = ???
	???
Return: ???
SeeAlso: AX=FB29h"AutoBraille"
----------2FFB29-----------------------------
INT 2F U - AutoBraille v1.1A - ???
	AX = FB29h
	BX = ???
	???
Return: ???
SeeAlso: AX=FB28h"AutoBraille"
----------2FFB-------------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AH = FBh
	AL = 2Bh-34h
	BX = ???
----------2FFB35-----------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AX = FB35h
	BL = ???
----------2FFB36-----------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AX = FB36h
	BL = ???
----------2FFB37-----------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AX = FB37h
	BL = ???
Note:	AutoBraille is a shareware text-to-braille converter by KANSYS, Inc.
----------2FFB42BX0001-----------------------
INT 2F PU - Borland C++ DPMILOAD.EXE - INSTALLATION CHECK???
	AX = FB42h
	BX = 0001h
Return: AX = version number??? (AL=major, AH=minor)
	CX = next-selector increment
---BC2.0---
	ES:BX -> 80-byte buffer for ???
	DX = DPMI version
---BC3.0---
	BX = ??? (0000h)
	DX = ???
	ES:SI -> list of valid selectors ???
Notes:	The version of DPMILOAD distributed with BC++ v2.0 identifies itself
	  as version 1.000, while the version distributed with BC++ 3.0
	  identifies itself as version 1.0; the former is 10864 bytes, the
	  latter 22180 bytes.  The BC2.0 version is a DPMI loader, while
	  the BC3.0 version also adds a DPMI host and DOS extender
	the BC++ 2.0 version displays an error message if called with BX
	  values other than 0001h-0008h
----------2FFB42BX0002-----------------------
INT 2F PU - Borland C++ 2.0 DPMILOAD.EXE - ALLOCATE MEMORY
	AX = FB42h
	BX = 0002h
	CX = size in bytes
	DX = bit flags
	    bit 2: set to allocate DOS memory, clear for DPMI memory
	SI = selector of descriptor to be modified to access allocated memory
	DI = selector of a second descriptor to be modified
Return: AX = ??? or 0000h on error
	CX:DX = linear base address of DPMI memory block
	SI:DI = handle for DPMI memory block or FFFFh:FFFFh
	???
Note:	two segment descriptors may be set if a code and an aliased data
	  segment are required; if only one descriptor is needed, SI should
	  equal DI on entry
BUG:	when allocating DOS memory, the code computes the linear address by
	  multiplying the segment number by 4 rather than shifting by 4
SeeAlso: AX=FB42h/BX=0003h,AX=FB42h/BX=0008h
----------2FFB42BX0002-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ALLOCATE MEMORY
	AX = FB42h
	BX = 0002h
	ES:SI -> memory block info (see below)
Return: ???
Note:	The version of DPMILOAD distributed with BC++ v2.0 identifies itself
	  as version 1.000, while the version distributed with BC++ 3.0
	  identifies itself as version 1.0; the former is 10864 bytes, the
	  latter 22180 bytes.
SeeAlso: AX=FB42h/BX=0003h,AX=FB42h/BX=0008h

Format of memory block info:
Offset	Size	Description
 00h	WORD	flags
		bit 0: set if data segment rather than code segment
		bit 1: information valid
		bit 2: set if DOS memory block rather than DPMI memory block
		bit 4: ???
		bit 15: set if no LDT selectors for memory block???
 02h	DWORD	block size in bytes
---DPMI memory block---
 06h	DWORD	DPMI memory block handle
---DOS memory block---
 06h	WORD	real-mode segment of memory block
 08h	WORD	selector of memory block
---
 0Ah	DWORD	linear address of memory
 0Eh	WORD	memory operation error code
		0008h no more free LDT descriptors
---if flags bit 0 clear---
 10h	WORD	code segment selector for memory block or 0000h or FFFFh
 12h	WORD	data alias selector for memory block or 0000h or FFFFh
---if flags bit 0 set---
 10h	WORD	data segment selector for memory block or 0000h or FFFFh
 12h	WORD	unused???
----------2FFB42BX0003-----------------------
INT 2F PU - Borland C++ DPMILOAD.EXE - GET AVAILABLE MEMORY
	AX = FB42h
	BX = 0003h
Return: DX:AX = size of largest free block in paragraphs
		0000h:0000h on error (BC3.0 version only)
Note:	AX and DX are destroyed on error, but no other error indicator is
	  returned, under the BC++ 2.0 version of DPMILOAD
SeeAlso: AX=FB42h/BX=0002h
----------2FFB42BX0004-----------------------
INT 2F PU - Borland C++ DPMILOAD.EXE - LOAD PROTECTED-MODE EXECUTABLE???
	AX = FB42h
	BX = 0004h
	DS:DX -> ASCIZ filename of protected-mode executable
Return: CX = selector of ??? or 0000h
---BC3.0---
	DX = status (0000h,FFF4h,others???) (see below)
Note:	the filename may also be terminated by a CR rather than a NUL under the
	  BC++ 3.0 version of DPMILOAD

Values for status:
 0000h	successful
 0001h	??? failure
 0002h	invalid selector
 0004h	unknown error
 0008h	no more LDT descriptors available???
 FFDEh	unable to set descriptor
 FFDFh	unable to get segment base address
 FFE0h	???
 FFF2h	invalid parameter value
 FFF4h	component of filename too long (name not in 8.3 format)
 FFF5h	pathname too long (>79 chars)
 FFF6h	???
 FFF8h	???
 FFF9h	index out of range
 FFFAh	???
 FFFCh	invalid access to code segment???
 FFFEh	???
 FFFFh	general error
----------2FFB42BX0005-----------------------
INT 2F PU - Borland C++ DPMILOAD.EXE - GET ADDRESS OF ??? BY NAME
	AX = FB42h
	BX = 0005h
	CX = selector of DPMILOAD data (see below)
	DS:DX -> ASCIZ or CR-terminated name of ??? (case ignored)
Return: DX = status (see AX=FB42h/BX=0004h)
	    0000h successful
		AX:BX -> ??? FAR function (called with two words on top of stk)
	    else
		BX destroyed
SeeAlso: AX=FB42h/BX=0006h,AX=FB42h/BX=000Eh

Format of DPMILOAD data:
Offset	Size	Description
 00h 12 BYTEs	???
 0Ch	WORD	??? bit flags
 0Eh 14 BYTEs	???
 1Ch	WORD	number of memory control records
 1Eh 25 BYTEs	???
 37h	BYTE	??? bit flags
		bit 4: data valid???
 38h  4 BYTEs	???
 3Ch	WORD	???
 3Eh 12 BYTEs	???
 46h	BYTE	??? counter
 47h	BYTE	???
 48h	BYTE	???
 49h	BYTE	???
 4Ah	WORD	???
 4Ch  2 BYTEs	???
 4Eh	WORD	offset of array of 64-byte memory control records
 52h	WORD	offset of name list (see below)
 54h  4 BYTEs	???
 58h	WORD	offset of array of 6-byte objects
 5Ah  8 BYTEs	???
 62h  9 BYTEs	ASCIZ name for ???
 6Bh  9 BYTEs	ASCIZ name for ???
	???

Format of name list entry [array]:
Offset	Size	Description
 00h	BYTE	length of name (00h if end of array)
 01h  N BYTEs	name
 N+1	WORD	1-based index into array of unknown 6-byte objects

Format of 6-byte objects:
Offset	Size	Description
 00h	BYTE	???
 01h	BYTE	???
 02h	BYTE	???
 03h	BYTE	1-based index of memory control record
 04h	WORD	???

Format of memory control record:
Offset	Size	Description
 00h 20 BYTEs	memory block info (see AX=FB42h/BX=0002h)
 14h  6 BYTEs	???
 1Ah	BYTE	???
 1Bh  2 BYTEs	???
 1Dh	BYTE	??? bit flags
 1Eh 14 BYTEs	???
 2Ch	DWORD	pointer to ??? memory control record or 0000h:0000h
 30h	DWORD	pointer to ??? memory control record or 0000h:0000h
 34h	DWORD	pointer to next??? memory control record or 0000h:0000h
 38h	DWORD	pointer to prev??? memory control record or 0000h:0000h
 3Ch  4 BYTEs	???
Note:	the pointers at offsets 2Ch and 30h form a doubly-linked list, as do
	  the pointers at offsets 34h and 38h
----------2FFB42BX0006-----------------------
INT 2F PU - Borland C++ DPMILOAD.EXE - GET ADDRESS OF ??? BY NUMBER
	AX = FB42h
	BX = 0006h
	CX = selector of DPMILOAD data (see AX=FB42h/BX=0005h)
	DX = 1-based index into array of ??? 6-byte objects
Return: DX = status (see AX=FB42h/BX=0004h)
	    0000h successful
		AX:BX -> ??? FAR function (called with two words on top of stk)
	    else
		BX destroyed
SeeAlso: AX=FB42h/BX=0005h,AX=FB42h/BX=000Eh
----------2FFB42BX0007-----------------------
INT 2F PU - Borland C++ 2.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0007h
	CX = selector of ???
Return: ???
Note:	The version of DPMILOAD distributed with BC++ v2.0 identifies itself
	  as version 1.000, while the version distributed with BC++ 3.0
	  identifies itself as version 1.0; the former is 10864 bytes, the
	  latter 22180 bytes.
----------2FFB42BX0007-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0007h
	CX = selector of DPMILOAD data (see AX=FB42h/BX=0005h)
	???
Return: DX = status (see AX=FB42h/BX=0004h)
	    0000h successful	
		AX = ???
----------2FFB42BX0008-----------------------
INT 2F PU - Borland C++ 2.0 DPMILOAD.EXE - FREE MEMORY BLOCK
	AX = FB42h
	BX = 0008h
	CX = bit flags
	    bit 2: set if DPMI memory, clear if DOS memory
	DX = selector of DOS memory block
	SI:DI = handle of DPMI memory block
Return: DX = 0000h on error, unchanged if succcessful
Note:	The version of DPMILOAD distributed with BC++ v2.0 identifies itself
	  as version 1.000, while the version distributed with BC++ 3.0
	  identifies itself as version 1.0; the former is 10864 bytes, the
	  latter 22180 bytes.
SeeAlso: AX=FB42h/BX=0002h
----------2FFB42BX0008-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - FREE MEMORY BLOCK
	AX = FB42h
	BX = 0008h
	ES:SI -> memory block info (see AX=FB42h/BX=0002h"3.0")
Return: ???
SeeAlso: AX=FB42h/BX=0009h
----------2FFB42BX0009-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - RESIZE MEMORY BLOCK
	AX = FB42h
	BX = 0009h
	ES:SI -> memory block info (see AX=FB42h/BX=0002h"3.0")
	???
Return: ???
SeeAlso: AX=FB42h/BX=0008h"3.0"
----------2FFB42BX000A-----------------------
INT 2F RU - Borland C++ 3.0 DPMILOAD.EXE - INIT DPMI HOST AND SPAWN SUBSHELL
	AX = FB42h
	BX = 000Ah
	CX = 0001h
	DX = ???
	SI = ???
Return: after user exits subshell
Notes:	this call is used by DPMIRES; unlike most of the DPMILOAD calls, this
	  function is not available in protected mode.
	the BC2.0 version of DPMILOAD is purely a DPMI loader, while the BC3.0
	  version also adds a DPMI host and DOS extender.
SeeAlso: AX=FB42h/BX=0004h,AX=FB42h/BX=0015h
----------2FFB42BX000B-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - UNUSED
	AX = FB42h
	BX = 000Bh
----------2FFB42BX000C-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - FREE DESCRIPTORS FOR MEMORY BLOCK???
	AX = FB42h
	BX = 000Ch ???
	ES:SI -> memory block info ??? (see AX=FB42h/BX=0002h"3.0")
Return: DX = status???
SeeAlso: AX=FB42h/BX=000Fh
----------2FFB42BX000D-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - SIMULATE REAL MODE INTERRUPT
	AX = FB42h
	BX = 000Dh
	CX = number of words to copy from protected-mode to real mode stack
	DL = interrupt number
	DH = flags
	    bit 0: reset the interrupt controller and A20 line
	ES:DI -> real-mode call structure (see INT 31/AX=0300h)
Return: CX = status
	    0000h successful
	    0001h failed
SeeAlso: INT 31/AX=0300h
----------2FFB42BX000E-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET ADDRESS OF ???
	AX = FB42h
	BX = 000Eh
	DS:DX -> ASCIZ or CR-terminated name of ???
Return: CX = selector of DPMILOAD data (see AX=FB42h/BX=0005h) corresponding to
		name, 0000h on error
SeeAlso: AX=FB42h/BX=0006h,AX=FB42h/BX=001Fh
----------2FFB42BX000F-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - REALLOCATE LDT DESCRPS TO MEMBLK???
	AX = FB42h
	BX = 000Fh
	ES:SI -> memory block info (see AX=FB42h/BX=0002h"3.0")
Return: ???
SeeAlso: AX=FB42h/BX=000Ch
----------2FFB42BX0010-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - CONVERT SEGMENT TO SELECTOR
	AX = FB42h
	BX = 0010h
	DX = segment number
Return: CX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		DX = selector number for descriptor
	    0008h failed
SeeAlso: AX=FB42h/BX=0023h
----------2FFB42BX0011-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0011h
	CX = selector of DPMILOAD data (see AX=FB42h/BX=0005h)
	???
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		AX:BX -> ??? name
	    0002h invalid selector
	    FFFEh ??? error
----------2FFB42BX0012-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0012h
	CX = selector for ???
Return: CX = selector for ???
----------2FFB42BX0013-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0013h
	CX = selector of DPMILOAD data (see AX=FB42h/BX=0005h)
	DX = 1-based index of ???
Return: CX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		BX = ??? or 0000h
	    0002h invalid selector
	    FFF9h ??? error
----------2FFB42BX0014-----------------------
INT 2F RU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0014h ???
		CX = 0001h
		Return: BX = 0000h
Note:	unlike most of the DPMILOAD functions, this call is available only in
	  real or V86 mode
SeeAlso: AX=FB42h/BX=000Ah
----------2FFB42BX0015-----------------------
INT 2F RU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0015h uninstall
	CX = 0001h
Return: ???
Note:	unlike most of the DPMILOAD functions, this call is available only in
	  real or V86 mode
SeeAlso: AX=FB42h/BX=000Ah
----------2FFB42BX0016-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET ???
	AX = FB42h
	BX = 0016h
	CX = selector of DPMILOAD data (see AX=FB42h/BX=0005h)
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		CX = ???
----------2FFB42BX0017-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0017h
	CX = ???
	DX = ???
	???
Return: DX = status (0000h,0001h) (see below)
----------2FFB42BX0018-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - SET ???
	AX = FB42h
	BX = 0018h
	CX = ???
----------2FFB42BX0019-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0019h
	CX = selector for ???
	???
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		CX = selector for ???
----------2FFB42BX001A-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 001Ah
	CX = selector for ???
	???
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
	    0004h failed
	CX:BX -> ???
----------2FFB42BX001B-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 001Bh
	CX = selector of DPMILOAD data (see AX=FB42h/BX=0005h)
	DX = offset of ???
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		BX = selector for ???
		CX = selector for ???
	    0002h invalid selector
----------2FFB42BX001C-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 001Ch
	ES = selector for DPMILOAD data (see AX=FB42h/BX=0005h)
	CX = 1-based index of ???
	DX = 1-based index of ???
Return: DX = status (0000h,0002h,FFF9h) (see AX=FB42h/BX=0004h)
----------2FFB42BX001D-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET ???
	AX = FB42h
	BX = 001Dh
Return: CX:DX = ???
----------2FFB42BX001E-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 001Eh
	CX = ???
	???
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
	    FFF7h ??? error
	CX:BX -> ???
----------2FFB42BX001F-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET ADDRESS OF ???
	AX = FB42h
	BX = 001Fh
	DS:DX -> 8-character name of ???
	???
Return: CX = selector of DPMILOAD data (see AX=FB42h/BX=0005h) for ???
		0000h on error
SeeAlso: AX=FB42h/BX=000Eh
----------2FFB42BX0020-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - NULL FUNCTION???
	AX = FB42h
	BX = 0020h
Return: DX = ??? (always 0000h)
----------2FFB42BX0021-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET PROCESSOR EXCEPTION HANDLER VECT
	AX = FB42h
	BX = 0021h
	CL = exception number (00h-1Fh)
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		AX:BX = selector:offset of handler
	    FFF2h unable to get exception handler vector
SeeAlso: AX=FB42h/BX=0022h,AX=FB42h/BX=0024h,INT 31/AX=0202h
----------2FFB42BX0022-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - SET PROCESSOR EXCEPTION HANDLER VECT
	AX = FB42h
	BX = 0022h
	CL = exception number (00h-1Fh)
	SI:DX = selector:offset of new handler
Return: DX = status (0000h,0004h,FFF2h) (see AX=FB42h/BX=0004h)
SeeAlso: AX=FB42h/BX=0021h,AX=FB42h/BX=0025h,INT 31/AX=0203h
----------2FFB42BX0023-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - CONVERT SELECTOR TO SEGMENT NUMBER
	AX = FB42h
	BX = 0023h
	CX = selector
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		CX = real-mode segment number
	    FFF2h descriptor has invalid base address for real-mode segment
SeeAlso: AX=FB42h/BX=0010h
----------2FFB42BX0024-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET PROTECTED-MODE INTERRUPT VECTOR
	AX = FB42h
	BX = 0024h
	CL = interrupt number
Return: DX = status (0000h) (see also AX=FB42h/BX=0004h)
	AX:BX = selector:offset of handler
SeeAlso: AX=FB42h/BX=0025h,INT 31/AX=0204h
----------2FFB42BX0025-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - SET PROTECTED-MODE INTERRUPT VECTOR
	AX = FB42h
	BX = 0025h
	CL = interrupt number
	SI:DX = selector:offset of new handler
Return: DX = status (0000h,0004h,FFF2h) (see AX=FB42h/BX=0004h)
SeeAlso: AX=FB42h/BX=0024h,INT 31/AX=0205h
----------2FFB42BX0026-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0026h
	CX = selector of DPMILOAD data (see AX=FB42h/BX=0005h)
	DX = 1-based index of ???
	???
Return: DX = status (0000h,0002h,FFF9h) (see AX=FB42h/BX=0004h)
	    0000h successful
		BX = offset of ??? within data structure
----------2FFB42BX0027-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET ???
	AX = FB42h
	BX = 0027h
	CX = selector of DPMILOAD data (see AX=FB42h/BX=0005h)
	DX = offset of ???
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		BX = ???
----------2FFB42BX0080-----------------------
INT 2F U - ??? - CALLED BY Borland C++ 3.0 DPMILOAD.EXE
	AX = FB42h
	BX = 0080h
	???
Return: AX = ???
	???
----------2FFB42BX0081-----------------------
INT 2F U - ??? - CALLED BY Borland C++ 3.0 DPMILOAD.EXE
	AX = FB42h
	BX = 0081h
	???
Return: AX = ???
	???
----------2FFB43-----------------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - NULL FUNCTION
	AX = FB43h
	BX = subfunction (at least 0000h-000Eh)
Notes:	this function is only present in protected mode; it does nothing but
	  an immediate IRET
	DPMILOAD.EXE itself calls various subfunctions:
	    subfunction 0004h is called with CX=selector of ???, DI=selector
		of DPMILOAD data
	    subfunction 0008h is called with CX=selector of DPMILOAD data
----------2FFB64-----------------------------
INT 2F U - AutoBraille v1.1A - GET ???
	AX = FB64h
Return: AX = ??? (0006h seen)
Note:	AutoBraille is a shareware text-to-braille converter by KANSYS, Inc.
----------2FFBA1BX0081-----------------------
INT 2F U - TKERNEL (Borland DOS extender) - INSTALLATION CHECK
	AX = FBA1h
	BX = 0081h
	ES:DI -> 16-byte buffer
Return: if installed, first four bytes of ES:DI buffer are "IABH"
Note:	TKERNEL is a licensed version of AI Architects/Ergo's OS/x86.  It was
	  present only in Borland C++ 2.0; with version 3.0, the DOS extender
	  was moved into DPMILOAD.
SeeAlso: AH=A1h,AX=F100h,AX=FBA1h/BX=0082h,AX=FBA1h/BX=0084h,INT 15/AX=BF02h 
SeeAlso: INT 21/AX=4403h"TKERNEL"
----------2FFBA1BX0082-----------------------
INT 2F U - TKERNEL (Borland DOS extender) - GET ENTRY POINT
	AX = FBA1h
	BX = 0082h
	ES:DI -> response buffer (see below)
Return: ES:DI buffer filled
SeeAlso: AX=FBA1h/BX=0081h,AX=FBA1h/BX=0084h

Format of response buffer:
Offset	Size	Description
 00h  4 BYTEs	signature "IABH"
 04h	DWORD	pointer to FAR extender entry point

Call entry point with:
	AX = function number
	    0000h initialize???
		STACK:	WORD  ???
		Return: AX = status???
			STACK unchanged
	    0001h get version???
		Return: AX = 0200h for v2.0.34
	    0002h get ???
		Return: AX = ??? (011Eh or 0182h seen)
	    0003h load protected-mode executable
		STACK:	DWORD -> ASCIZ filename of executable
			DWORD	???
			DWORD -> program arguments (counted string plus CR)
			DWORD -> environment for protected-mode executable
				(terminated with two consecutive NULs)
			DWORD -> WORD buffer for ???
		Return:	AX = status???
			STACK unchanged
	    0004h get descriptor
		STACK:	WORD	selector for which to get descriptor
			WORD	segment number (when running in real mode)
			DWORD -> buffer for descriptor
		Return: CF clear if successful
			    buffer filled
			CF set on error
			    AX destroyed???
			STACK unchanged
	    0005h ???
		STACK:	WORD	selector for ???
			WORD	subfunction number???
				0000h run previously-loaded program???
				0001h ??? (similar to 0000h)
				0002h
				0003h
				0005h ??? (similar to 0000h and 0001h)
		Return: AX = status???
			STACK unchanged
	    0006h ???
		STACK:	WORD ???
			DWORD -> WORD (call) max iterations of ???
				      (return) remaining iterations
		Return: AX = ???
			STACK unchanged
	    0007h unused
		Return: AX = 0001h
	    0008h unused
		Return: AX = 0001h
	    0009h copy protected-mode memory into conventional memory
		STACK:	WORD	selector for source segment
			WORD	segment of source if in real mode???
			DWORD	offset of source
			WORD	number of bytes to copy
			DWORD -> low-memory destination
		Return: AX = status
			STACK unchanged
	    000Ah copy conventional memory into protected-mode memory
		STACK:	WORD	selector for destination segment
			WORD	segment of destination if in real mode???
			DWORD	offset of destination
			WORD	number of bytes to copy
			DWORD -> low-memory source
		Return: AX = status
			STACK unchanged
	    000Bh get ??? pointers
		STACK:	WORD desired pointer
				0000h get ???
				0002h get protected-mode CR3
				0003h get 4K page table buffer pointer
				else Return: DX:AX = FFFFh:FFFFh
		Return: DX:AX = requested pointer
			STACK unchanged
	    000Ch set ??? pointers
		STACK:	WORD desired pointer
				0000h set ???
				0002h set protected-mode CR3
				0003h set 4K page table buffer pointer
				else ignore
			DWORD new value for pointer
		Return: STACK unchanged
	    000Dh get ??? pointers
		STACK:	WORD desired pointer
				0000h get ???
				0001h get ???
				0002h get ???
				0003h get ???
				0004h get ???
				0005h get ???
				0006h get ???
				0007h get ???
				else Return: DX:AX = FFFFh:FFFFh
		Return: DX:AX = desired pointer
			STACK unchanged
	    000Eh set ??? pointer
		STACK:	WORD desired pointer
				0000h set ???
				0001h set ???
				0002h set ???
				0003h set ???
				0004h set ???
				0005h set ???
				0006h set ???
				0007h set ???
				else Return: DX:AX = FFFFh:FFFFh
		Return: STACK unchanged
	    000Fh get ???
		Return: AX = ??? (seen 0008h)
	    0010h get ???
		Return: AX = ???
	    0011h determine whether selector is valid
		STACK:	WORD	possible selector
		Return: AX = selector or 0000h if invalid
			STACK unchanged
	    0012h get physical address
		STACK:	WORD	selector for desired segment
			WORD	segment number if in real mode
			DWORD	offset within segment
		Return: DX:AX = 32-bit physical address or 00000000h on error
			BX destroyed
			STACK unchanged
	    0013h ???
		Note:	normally jumps to code for function 0012h
	    0014h copy protected-mode memory to conventional memory, with ???
		STACK:	WORD	selector for source segment
			WORD	segment of source if in real mode???
			DWORD	offset of source
			WORD	number of bytes to copy
			DWORD -> low-memory destination
		Return: AX = status???
			STACK unchanged
	    0015h copy conventional memory to protected-mode memory, with ???
		STACK:	WORD	selector for destination segment
			WORD	segment of destination if in real mode???
			DWORD	offset of destination
			WORD	number of bytes to copy
			DWORD -> low-memory source
		Return: AX = status???
			STACK unchanged
	    0016h set ??? pointer
		STACK:	WORD	unused
			DWORD -> ??? or 0000h:0000h
		Return: AX = 0000h
			STACK unchanged
	    0017h allocate real-mode procedure???
		STACK:	DWORD	ASCIZ name of procedure
			DWORD ???
			DWORD	address of subroutine to invoke
		Return: AX = status
			    0032h procedure by that name exists
			    0033h no more real-mode procedures available
			DX destroyed
			STACK unchanged
	    0018h unused
		Return: AX = 0001h
	    0019h get parameter block
		Return: DX:AX -> parameter block (format unknown at this time,
				but 92h bytes)
				(preceded by signature "!!PARAM-BLOCK!!")
	    001Ah get ???
		Return: AX = ??? (0148h seen)
	    001Bh free real-mode procedure???
		STACK:	DWORD -> ASCIZ name of procedure
		Return: ???
			STACK unchanged
	    001Ch check whether packets from protected mode task pending
		Return: AX = 0001h if packets pending, 0000h if not
	    001Dh set ???
		STACK:	DWORD ??? or 0000h:0000h
		Return: AX,BX destroyed
			STACK unchanged
	    001Eh ???
		STACK:	WORD ??? (high byte ignored)
			DWORD -> data structure (see below)
		Return: AX,BX,CX,DX destroyed
			data structure updated
			STACK unchanged
		Format of data structure
		Offset	Size	Description
		 00h  2 BYTEs	unused
		 02h	WORD	???
		 04h	WORD	???
		 06h	WORD	???
		 08h  2 BYTEs	unused
		 0Ah	WORD	???
		 0Ch	WORD	(call) ???
				(return) offset of this data structure (BUG?)
	    001Fh set ???
		STACK:	WORD ??? (set to 0001h if zero)
		Return: AX destroyed
			STACK unchanged
	    0020h ???
		STACK:	DWORD -> ??? (8 bytes of data)
		Return: AX = ???
			STACK unchanged
	    0021h ???
		STACK:	DWORD -> ??? (8 bytes of data)
			WORD	???
			WORD	???
		Return: AX = ???
			STACK unchanged
	    0022h ???
		STACK:	DWORD -> ??? (8 bytes of data)
			DWORD -> 4-byte buffer for results
		Return: AX = ???
			STACK unchanged
	    0023h ???
		STACK:	DWORD -> ??? (8 bytes of data)
		Return: AX = ???
			STACK unchanged
	    0024h set ???
		STACK:	WORD ???
		Return: AX destroyed
			STACK unchanged
	    0025h get ???
		Return: AX = ??? (value set with func 0024h)
	    0026h BUG: jumps to hyperspace due to fencepost error
	    FFFFh set DOS memory management functions
		BX:SI -> FAR routine for allocating DOS memory
			(called with AH=48h,BX=number of paragraphs to alloc;
			 returns CF clear, AX=segment of allocated memory, or
				 CF set on error)
		CX:DI -> FAR routine for freeing DOS memory
			(called with AH=49h,ES=segment of block to free;
			 returns CF set on error,AX=error code)
		Note: each of these pointers normally points at INT 21/RETF
	    other Return: AX = 0001h
Note:	BX may be destroyed by any of the API calls
----------2FFBA1BX0084-----------------------
INT 2F U - TKERNEL (Borland DOS extender) - UNINSTALL
	AX = FBA1h
	BX = 0084h
	ES:DI -> response buffer (see below)
Return: ES:DI buffer filled
SeeAlso: AX=FBA1h/BX=0081h,AX=FBA1h/BX=0084h

Format of response buffer:
Offset	Size	Description
 00h  4 BYTEs	signature "IABH"
 04h	WORD	success indicator
		0001h failed (INT 2F hooked by another program)
		unchanged if successful
 06h	WORD	segment of ???
 08h	WORD	segment of ??? memory block to free if nonzero
 0Ah	WORD	segment of ??? memory block to free if nonzero
----------2FFBFBES0000-----------------------
INT 2F U - SoundBlaster speech driver - INSTALLATION CHECK
	AX = FBFBh
	ES = 0000h
Return: ES nonzero if installed
	    ES:BX -> entry point data structure (see below)
SeeAlso: INT 80/BX=0000h,INT F3"SoundBlaster"

Format of entry point data structure:
Offset	Size	Description
 00h  3 BYTEs	signature "FB "
 03h	BYTE	driver major version number???
 04h	DWORD	speech driver entry point
 08h 24 BYTEs	???
 20h  ? BYTEs	data buffer for calling speech driver

Call driver entry point with:
	AL = function
	    07h speak a string
		data buffer (see above) contains:
			BYTE  length of string
		      N BYTEs string to speak
----------2FFE00DI4E55-----------------------
INT 2F U - NORTON UTILITIES 5.0+ TSRs - INSTALLATION CHECK/STATUS REPORT
	AX = FE00h
	DI = 4E55h ("NU")
	SI = TSR identifier
	    4346h ("CF") NCACHE-F (v5) / NCACHE (v6.0+)
	    4353h ("CS") NCACHE-S (v5 only)
	    4443h ("DC") DISKREET
	    444Dh ("DM") DISKMON
	    4653h ("FS") FILESAVE (v5) / EP (v6.0+)
Return: SI = TSR reply
	    lowercase version of SI on entry (i.e. SI OR 2020h)
	AH = status
	    00h installed but disabled internally
	    01h installed and enabled
	AL = status
	    00h	NCACHE-x or DISKREET installed
	    01h FILESAVE / EP / DISKMON v6 installed
	    45h	DISKMON v5 installed
	BX = length of *.INI file (DISKMON and FILESAVE/EP only) (see below)
	CX = segment of resident portion
	    FFFFh if completely loaded high (NCACHE)
---FILESAVE/EP---
	DL = ??? (apparently always 00h)
---DISKMON---
	DX = ??? (apparently always 1AE6h [v5] / 1B86h [v6])
Note:	the value returned in CX is incorrect for NCACHE 6.00
SeeAlso: AX=FE01h,AX=FE02h,AX=FE03h,AX=FE04h,AX=FE05h

Format of DISKMON.INI file:
Offset	Size	Description
-6Ch 108 BYTEs	(in memory copy only)
		list of filenames which are always protected:
		  IBMBIO.COM/IBMDOS.COM, IO.SYS/MSDOS.SYS, TBIOS.SYS/TDOS.SYS,
		  MIO.SYS/IO.BIN, COMMAND.COM
 00h	BYTE	??? always 01h
 01h	BYTE	disk light (00h off, 01h on)
 02h	BYTE	disk protection (00h off, 01h on)
 03h	BYTE	protected areas
		01h system area
		02h files
		03h system area and files
		04h entire disk
 04h	BYTE	floppy access (00h not allowed, 01h allowed)
 05h 27 BYTEs	filename extension list (9 entries)
		(lowercase, blank padded or = 000000h)
 20h 240 BYTEs	filename list (20 entries)
		(lowercase, name and extension blank padded, with '.')
Note:	CX:0508h -> copy in installed TSR (v5)
	CX:052Fh -> copy in installed TSR (v6)

Format of FILESAVE.INI / EP.INI file:
Offset	Size	Description
 00h 26 BITs	drive list (bit set: file protection on, cleared: off):
 00h	BYTE	drives	A: - H:
 01h	BYTE	drives	I: - P:
 02h	BYTE	drives	Q: - X:
 03h	BYTE	drives	Y: - Z:
 04h	BYTE	which files to protect
		00h all files
		01h all files with extension in list
		02h all files except those with extension in list
 05h 27 BYTEs	filename extension list (9 entries, uppercase, ASCIZ)
 20h	BYTE	include files with archive bit clear (00h no, 01h yes)
 21h	WORD	number of days after which files are purged (0 = never)
 23h	WORD	max kilobytes of erased file space to hold (0 = all)
Note:	CX:03D2h -> copy in installed TSR (v5.0)
	CX:03F5h -> copy in installed TSR (v6.0)
----------2FFE01DI4E55-----------------------
INT 2F U - NORTON UTILITIES 5.0+ TSRs - ENABLE
	AX = FE01h
	DI = 4E55h ("NU")
	SI = TSR identifier (see AX=FE00h)
Return: SI = TSR reply (lowercase version of entry SI, i.e. SI OR 2020h)
	AX = status
	    0002h successful (DISKMON, FILESAVE, EP)
	    FE00h successful (NCACHE-x, DISKREET)
Notes:	if the enable/disable calls are used on DISKMON or NCACHE-x, the status
	  report generated by the programs still indicates the previous state,
	  and DISKMON.INI is not updated
	apparently has no effect on DISKREET
SeeAlso: AX=FE00h,AX=FE02h
----------2FFE02DI4E55-----------------------
INT 2F U - NORTON UTILITIES 5.0+ TSRs - DISABLE
	AX = FE02h
	DI = 4E55h ("NU")
	SI = TSR identifier (see AX=FE00h)
Return: SI = TSR reply (lowercase version of entry SI, i.e. SI OR 2020h)
	AX = status
	    0004h successful (DISKMON, FILESAVE)
	    FE00h successful (NCACHE-x, DISKREET)
Note:	(see AX=FE01h)
SeeAlso: AX=FE00h,AX=FE01h
----------2FFE03DI4E55-----------------------
INT 2F U - NORTON UTILITIES 5.0+ TSRs - internal - ???
	AX = FE03h
	DI = 4E55h ("NU")
	SI = TSR identifier (see AX=FE00h)
Return: SI = TSR reply (lowercase version of entry SI, i.e. SI OR 2020h)
	AX = status
	    0006h successful???
Notes:	only supported by DISKMON, FILESAVE, and NCACHE-x
	reportedly dangerous
SeeAlso: AX=FE00h
----------2FFE04DI4E55-----------------------
INT 2F U - NORTON UTILITIES 5.0+ DISKMON, FILESAVE / EP - internal - ???
	AX = FE04h
	DI = 4E55h ("NU")
	SI = TSR identifier (see AX=FE00h)
Return: SI = TSR reply (lowercase version of entry SI, i.e. SI or 2020h)
	AX = status
	    0008h successful???
SeeAlso: AX=FE00h
----------2FFE05DI4E55-----------------------
INT 2F U - NORTON UTILITIES 5.0+ DISKMON, FILESAVE / EP - internal - ???
	AX = FE05h
	DI = 4E55h ("NU")
	SI = TSR identifier (see AX=FE00h)
Return: SI = TSR reply (lowercase version of entry SI, i.e. SI or 2020h)
	AX = status
	    000Ah successful???
Note:	reportedly dangerous
SeeAlso: AX=FE00h
----------2FFF00-----------------------------
INT 2F - Topware Network Operating System - INSTALLATION CHECK
	AX = FF00h
Return: AL = 00h not installed, OK to install
	   = 01h not installed, not OK to install
	   = FFh installed
SeeAlso: AX=FF01h,INT 21/AH=FFh"Topware",INT 7A"Topware"
----------2FFF01-----------------------------
INT 2F - Topware Network Operating System - GET VERSION
	AX = FF01h
Return: AX = version
SeeAlso: AX=FF00h
----------30---------------------------------
INT 30 - (NOT A VECTOR!) - DOS 1+ - FAR JMP instruction for CP/M-style calls
   the CALL 5 entry point does a FAR jump to here
Note:	under DOS 2+, the instruction at PSP:0005 points two bytes too low in
	  memory
SeeAlso: INT 21/AH=26h
----------31---------------------------------
INT 31 - overwritten by CP/M jump instruction in INT 30
----------310000-----------------------------
INT 31 P - DPMI 0.9+ - ALLOCATE LDT DESCRIPTORS
	AX = 0000h
	CX = number of descriptors to allocate
Return: CF clear if successful
	    AX = base selector
	CF set on error
	    AX = error code (DPMI 1.0+)
		0000h-7FFFh DOS error passed through by DPMI
		8001h unsupported function
		8002h object in wrong state for function
		8003h system integrity would be endangered
		8004h deadlock detected
		8005h pending serialization request cancelled
		8010h out of DPMI internal resources
		8011h descriptor unavailable
		8012h linear memory unavailable
		8013h physical memory unavailable
		8014h backing store unavailable
		8015h callback unavailable
		8016h handle unavailable
		8017h maximum lock count exceeded
		8018h shared memory already serialized exclusively by another
		8019h shared memory already serialized shared by another client
		8021h invalid value for numeric or flag parameter
		8022h invalid segment selector
		8023h invalid handle
		8024h invalid callback
		8025h invalid linear address
		8026h request not supported by hardware
Notes:	DPMI is the DOS Protected-Mode Interface
	the base and limit of the returned descriptors will be 0, and the type
	  will be "data"
	add the value returned by INT 31/AX=0003h to move to subsequent
	  descriptors if multiple descriptors were allocated
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0001h,AX=000Dh,INT 21/AX=3501h
----------310001-----------------------------
INT 31 P - DPMI 0.9+ - FREE LDT DESCRIPTOR
	AX = 0001h
	BX = selector to free
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8022h) (see AX=0000h)
Notes:	only one descriptor is freed per call
	the program's initial CS, DS, and SS descriptors may be freed
	(DPMI 1.0+) any segment registers containing the freed selector are
	  set to 0000h
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0000h,AX=000Ah,AX=000Dh,INT 21/AX=3502h
----------310002-----------------------------
INT 31 P - DPMI 0.9+ - SEGMENT TO DESCRIPTOR
	AX = 0002h
	BX = real mode segment
Return: CF clear if successful
	    AX = selector corresponding to real mode segment (64K limit)
	CF set on error
	    AX = error code (DPMI 1.0+) (8011h) (see AX=0000h)
Notes:	multiple calls for the same real mode segment return the same selector
	the returned descriptor can never be modified or freed
	not supported by MS Windows 3.0 in Standard mode
----------310003-----------------------------
INT 31 P - DPMI 0.9+ - GET NEXT SELECTOR INCREMENT VALUE
	AX = 0003h
Return: CF clear
	    AX = value to add to get next sequential selector
Notes:	the increment will be a power of two
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0000h
----------310004-----------------------------
INT 31 P - DPMI 0.9+ - LOCK SELECTOR
	AX = 0004h
	BX = selector to lock (prevent paging)
Return: ???
Note:	although marked as reserved in versions 0.9 and 1.0 of the DPMI
	  specification, this function is called by MS Windows TASKMAN,
	  PROGMAN, and KERNEL
SeeAlso: AX=0005h,AX=0600h
----------310005-----------------------------
INT 31 P - DPMI 0.9+ - UNLOCK SELECTOR
	AX = 0005h
	BX = selector to unlock (permit paging)
Return: ???
Note:	although marked as reserved in versions 0.9 and 1.0 of the DPMI
	  specification, this function is called by MS Windows TASKMAN,
	  PROGMAN, and KERNEL
SeeAlso: AX=0004h,AX=0601h
----------310006-----------------------------
INT 31 P - DPMI 0.9+ - GET SEGMENT BASE ADDRESS
	AX = 0006h
	BX = selector
Return: CF clear if successful
	    CX:DX = linear base address of segment
	CF set on error
	    AX = error code (DPMI 1.0+) (8022h) (see AX=0000h)
Note:	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0007h,INT 21/AX=3504h
----------310007-----------------------------
INT 31 P - DPMI 0.9+ - SET SEGMENT BASE ADDRESS
	AX = 0007h
	BX = selector
	CX:DX = linear base address
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8022h,8025h) (see AX=0000h)
Notes:	only modify descriptors allocated with INT 31/AX=0000h
	only the low 24 bits of the address will be used by 16-bit DPMI
	  implementations even on a 386 or higher
	DPMI 1.0+ automatically reloads any segment registers containing the
	  selector being modified
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0006h,AX=0008h,AX=0009h,AX=000Ch,INT 21/AX=3503h
SeeAlso: INT 21/AH=E9h"OS/286"
----------310008-----------------------------
INT 31 P - DPMI 0.9+ - SET SEGMENT LIMIT
	AX = 0008h
	BX = selector
	CX:DX = segment limit
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8021h,8022h,8025h) (see AX=0000h)
Notes:	CX must be zero for 16-bit DPMI implementations
	limits greater than 1MB must be page aligned (low 12 bits set)
	only modify descriptors allocated with INT 31/AX=0000h
	DPMI 1.0+ automatically reloads any segment registers containing the
	  selector being modified
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0007h,AX=0009h,AX=000Ch,INT 21/AX=3505h,INT 21/AH=E9h"OS/286"
----------310009-----------------------------
INT 31 P - DPMI 0.9+ - SET DESCRIPTOR ACCESS RIGHTS
	AX = 0009h
	BX = selector
	CL = access rights/type byte
	CH = 80386 extended rights/type byte (32-bit DPMI implementations only)
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8021h,8022h,8025h) (see AX=0000h)
Notes:	if the Present bit is clear, CL bits 0-3 may have any value
	DPMI 1.0+ automatically reloads any segment registers containing the
	  selector being modified
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0007h,AX=0008h,AX=000Ch,INT 21/AX=2514h
----------31000A-----------------------------
INT 31 P - DPMI 0.9+ - CREATE ALIAS DESCRIPTOR
	AX = 000Ah
	BX = selector
Return: CF clear if successful
	    AX = new data selector
	CF set on error
	    AX = error code (DPMI 1.0+) (8011h,8022h) (see AX=0000h)
Notes:	fails if selector in BX is not a code segment or is invalid
	use INT 31/AX=0001h to free new selector
	future changes to the original selector will not be reflected in the
	  returned alias selector
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0001h
----------31000B-----------------------------
INT 31 P - DPMI 0.9+ - GET DESCRIPTOR
	AX = 000Bh
	BX = LDT selector
	ES:(E)DI -> 8-byte buffer for copy of descriptor
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (DPMI 1.0+) (8022h) (see AX=0000h)
Notes:	16-bit programs use ES:DI as pointer, 32-bit must use ES:EDI
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=000Ch
----------31000C-----------------------------
INT 31 P - DPMI 0.9+ - SET DESCRIPTOR
	AX = 000Ch
	BX = LDT selector
	ES:(E)DI -> 8-byte buffer containing descriptor
Return:	CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8021h,8022h,8025h) (see AX=0000h)
Notes:	16-bit programs use ES:DI as pointer, 32-bit must use ES:EDI
	only modify descriptors allocated with INT 31/AX=0000h
	DPMI 1.0+ automatically reloads any segment registers containing the
	  selector being modified
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=000Bh
----------31000D-----------------------------
INT 31 P - DPMI 0.9+ - ALLOCATE SPECIFIC LDT DESCRIPTOR
	AX = 000Dh
	BX = LDT selector
Return: CF clear if successful
	    descriptor allocated
	CF set on error
	    AX = error code (DPMI 1.0+) (8011h,8022h) (see AX=0000h)
Notes:	free descriptor with INT 31/AX=0001h
	the first 16 descriptors (04h-7Ch) are reserved for this function, but
	  some may already be in use by other applications under DPMI 0.9;
	  DPMI 1.0 guarantees 16 descriptors per client
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0000h,AX=0001h
----------31000E-----------------------------
INT 31 P - DPMI 1.0+ - GET MULTIPLE DESCRIPTORS
	AX = 000Eh
	CX = number of descriptors to copy
	ES:(E)DI -> descriptor buffer (see below)
Return: CF clear if successful
	    descriptors copied
	CF set on error
	    AX = error code (8022h) (see AX=0000h)
	    CX = number of descriptors successfully copied
Notes:	16-bit programs use ES:DI as pointer, 32-bit must use ES:EDI
	if the function fails, the first CX descriptors are valid; the
	  remainder are not modified
SeeAlso: AX=000Bh,AX=000Fh

Format of descriptor buffer entry (one per descriptor to get):
Offset	Size	Description
 00h	WORD	selector (set by client)
 02h	QWORD	descriptor (set by host)
----------31000F-----------------------------
INT 31 P - DPMI 1.0+ - SET MULTIPLE DESCRIPTORS
	AX = 000Fh
	CX = number of descriptors to copy
	ES:(E)DI -> descriptor buffer (see below)
Return: CF clear if successful
	    descriptors copied
	CF set on error
	    AX = error code (8021h,8022h,8025h) (see AX=0000h)
	    CX = number of descriptors successfully copied
Notes:	16-bit programs use ES:DI as pointer, 32-bit must use ES:EDI
	if the function fails, the first CX descriptors are valid; the
	  remainder are not modified
	DPMI 1.0+ automatically reloads any segment registers containing a
	  selector being modified
SeeAlso: AX=000Ch,AX=000Eh

Format of descriptor buffer entry (one per descriptor to set):
Offset	Size	Description
 00h	WORD	selector
 02h	QWORD	descriptor
----------310100-----------------------------
INT 31 P - DPMI 0.9+ - ALLOCATE DOS MEMORY BLOCK
	AX = 0100h
	BX = number of paragraphs to allocate
Return: CF clear if successful
	    AX = real mode segment of allocated block
	    DX = first selector for allocated block
	CF set on error
	    AX = DOS error code (07h,08h) (see INT 21/AH=59h)
		 (DPMI 1.0+) DPMI error code (8011h) (see AX=0000h)
	    BX = size (in paragraphs) of largest available block
Notes:	multiple contiguous selectors are allocated for blocks of more than 64K
	  if the caller is a 16-bit program
	never modify or deallocate returned descriptors
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0101h,AX=0501h
----------310101-----------------------------
INT 31 P - DPMI 0.9+ - FREE DOS MEMORY BLOCK
	AX = 0101h
	DX = selector of block
Return: CF set if successful
	CF set on error
	    AX = DOS error code (07h,09h) (see INT 21/AH=59h)
Notes:	all descriptors allocated for the block are automatically freed
	DPMI 1.0+ automatically zeros any segment registers containing a
	  selector freed by this function
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0100h,AX=0102h,AX=0502h
----------310102-----------------------------
INT 31 P - DPMI 0.9+ - RESIZE DOS MEMORY BLOCK
	AX = 0102h
	BX = new block size in paragraphs
	DX = selector of block
Return: CF clear if successful
	CF set on error
	    AX = DOS error code (07h,08h,09h) (see INT 21/AH=59h)
		 (DPMI 1.0+) DPMI error code (8011h,8022h) (see AX=0000h)
	    BX = maximum block size (in paragraphs) possible
Notes:	increasing the size of a block past a 64K boundary will fail if the
	  next descriptor in the LDT is already in use
	shrinking a block past a 64K boundary will cause some selectors to be
	  freed; DPMI 1.0+ automatically zeros any segment registers containing
	  a selector freed by this function
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0100h
----------310200-----------------------------
INT 31 P - DPMI 0.9+ - GET REAL MODE INTERRUPT VECTOR
	AX = 0200h
	BL = interrupt number
Return: CF clear
	CX:DX = segment:offset of real mode interrupt handler
Note:	the DPMI implementation is required to support all 256 vectors
SeeAlso: AX=0201h,AX=0204h,INT 21/AX=2503h
----------310201-----------------------------
INT 31 P - DPMI 0.9+ - SET REAL MODE INTERRUPT VECTOR
	AX = 0201h
	BL = interrupt number
	CX:DX = segment:offset of real mode handler
Return: CF clear
Note:	all memory that may be touched by a hardware interrupt handler must be
	  locked down with INT 31/AX=0600h	
SeeAlso: AX=0200h,AX=0205h,AX=0600h,INT 21/AX=2505h
----------310202-----------------------------
INT 31 P - DPMI 0.9+ - GET PROCESSOR EXCEPTION HANDLER VECTOR
	AX = 0202h
	BL = exception number (00h-1Fh)
Return:	CF clear if successful
	    CX:(E)DX = selector:offset of handler
	CF set on error
	    AX = error code (DPMI 1.0+) (8021h) (see AX=0000h)
Notes:	16-bit programs receive the pointer in CX:DX, 32-bit programs in CX:EDX
	DPMI 1.0+ supports this function only for backward compatibility; use
	   AX=0210h or AX=0211h instead
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0203h,AX=0210h,AX=0211h,INT 2F/AX=FB42h/BX=0021h
----------310203-----------------------------
INT 31 P - DPMI 0.9+ - SET PROCESSOR EXCEPTION HANDLER VECTOR
	AX = 0203h
	BL = exception number (00h-1Fh)
	CX:(E)DX = selector:offset of handler
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8021h,8022h) (see AX=0000h)
Notes:	32-bit programs must supply an offset in EDX and use a 32-bit interrupt
	  stack frame on chaining to the next exception handler
	the handler should return using a FAR return
	all fault stack frames contain an error code, but it is only valid for
	  exceptions 08h and 0Ah-0Eh
	handlers will only be called if the exception occurs in protected mode,
	  and the DPMI host does not transparently handle the exception
	the handler may change certain values on the stack frame (see below)
	DPMI 1.0+ supports this function only for backward compatibility; use
	   AX=0212h or AX=0213h instead
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0202h,AX=0212h,AX=0213h,INT 2F/AX=FB42h/BX=0022h

Format of stack frame for 16-bit programs: (offset from SS:SP)
Offset	Size	Description
 00h	DWORD	return CS:IP (do not change)
 04h	WORD	error code
 06h	DWORD	CS:IP of exception
 0Ah	WORD	flags
 0Ch	DWORD	SS:SP

Format of stack frame for 32-bit programs: (offset from SS:ESP)
Offset	Size	Description
 00h	DWORD	return EIP (do not change)
 04h	WORD	return CS selector (do not change)
 06h	WORD	reserved (do not change)
 08h	DWORD	error code
 0Ch	DWORD	EIP of exception
 10h	WORD	CS selector of exception
 12h	WORD	reserved (do not change)
 14h	DWORD	EFLAGS
 18h	DWORD	ESP
 1Ch	WORD	SS
 1Eh	WORD	reserved (do not change)
----------310204-----------------------------
INT 31 P - DPMI 0.9+ - GET PROTECTED MODE INTERRUPT VECTOR
	AX = 0204h
	BL = interrupt number
Return:	CF clear
	CX:(E)DX = selector:offset of handler
Notes:	16-bit programs use CX:DX, 32-bit programs use CX:EDX
	DPMI implementations are required to support all 256 vectors
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0200h,AX=0205h,INT 21/AX=2502h,INT 2F/AX=FB42h/BX=0024h
----------310205-----------------------------
INT 31 P - DPMI 0.9+ - SET PROTECTED MODE INTERRUPT VECTOR
	AX = 0205h
	BL = interrupt number
	CX:(E)DX = selector:offset of handler
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8022h) (see AX=0000h)
Notes:	16-bit programs use CX:DX, 32-bit programs use CX:EDX
	32-bit programs must use a 32-bit interrupt stack frame when chaining
	  to the next handler
	DPMI implementations are required to support all 256 vectors
	hardware interrupts are reflected to the virtual machine's primary
	  client, software interrupts to the current client
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0201h,AX=0204h,INT 21/AX=2504h,INT 2F/AX=FB42h/BX=0025h
----------310210-----------------------------
INT 31 P - DPMI 1.0+ - GET PROTECTED MODE EXTENDED PROCESSOR EXCEPTION HANDLER
	AX = 0210h
	BL = exception number (00h-1Fh)
Return: CF clear if successful
	    CX:(EDX) = selector:offset of exception handler
	CF set on error
	    AX = error code (8021h) (see AX=0000h)
Note:	DPMI host reflects exception to current client's handler
SeeAlso: AX=0202h,AX=0211h,AX=0212h
----------310211-----------------------------
INT 31 P - DPMI 1.0+ - GET REAL MODE EXTENDED PROCESSOR EXCEPTION HANDLER
	AX = 0211h
	BL = exception number (00h-1Fh)
Return: CF clear if successful
	    CX:(EDX) = selector:offset of exception handler
	CF set on error
	    AX = error code (8021h) (see AX=0000h)
Notes:	returns address of protected-mode handler for real-mode exception
	DPMI host performs a switch to protected mode, reflects the exception
	  to the virtual machine's primary client, and returns to real mode
	  on the handler's completion
SeeAlso: AX=0202h,AX=0210h,AX=0213h
----------310212-----------------------------
INT 31 P - DPMI 1.0+ - SET PROTECTED MODE EXTENDED PROCESSOR EXCEPTION HANDLER
	AX = 0212h
	BL = exception or fault number (00h-1Fh)
	CX:(E)DX = exception handler selector:offset
Return: CF clear if successful
	CF set on error
	    AX = error code (8021h,8022h) (see AX=0000h)
Note:	DPMI host sends exception to current client's handler
SeeAlso: AX=0203h,AX=0210h,AX=0213h
----------310213-----------------------------
INT 31 P - DPMI 1.0+ - SET REAL MODE EXTENDED PROCESSOR EXCEPTION HANDLER
	AX = 0213h
	BL = exception or fault number (00h-1Fh)
	CX:(E)DX = exception handler selector:offset
Return: CF clear if successful
	CF set on error
	    AX = error code (8021h,8022h) (see AX=0000h)
Notes:	specifies address of protected-mode handler for real-mode exception
	DPMI host performs a switch to protected mode, reflects the exception
	  to the virtual machine's primary client, and returns to real mode
	  on the handler's completion
SeeAlso: AX=0203h,AX=0211h,AX=0212h
----------310300-----------------------------
INT 31 P - DPMI 0.9+ - SIMULATE REAL MODE INTERRUPT
	AX = 0300h
	BL = interrupt number
	BH = flags
	    bit 0: reset the interrupt controller and A20 line (DPMI 0.9)
		   reserved, must be 0 (DPMI 1.0+)
	    others must be 0
	CX = number of words to copy from protected mode to real mode stack
	ES:(E)DI = selector:offset of real mode call structure (see below)
Return:	CF clear if successful
	    real mode call structure modified (all fields except SS:SP, CS:IP
	      filled with return values from real mode interrupt)
	CF set on error
	    AX = error code (DPMI 1.0+) (8012h,8013h,8014h,8021h)(see AX=0000h)
	protected mode stack unchanged
Notes:	16-bit programs use ES:DI as pointer, 32-bit programs use ES:EDI
	CS:IP in the real mode call structure is ignored for this call,
	  instead, the indicated interrupt vector is used for the address
	the flags in the call structure are pushed on the real mode stack to
	  form an interrupt stack frame, and the trace and interrupt flags are
	  clear on entry to the handler
	DPMI will provide a small (30 words) real mode stack if SS:SP is zero
	the real mode handler must return with the stack in the same state as
	  it was on being called
SeeAlso: AX=0302h,INT 21/AX=2511h,INT 21/AH=E3h"OS/286"
SeeAlso: INT 2F/AX=FB42h/BX=000Dh

Format of real mode call structure:
Offset	Size	Description
 00h	DWORD	EDI
 04h	DWORD	ESI
 08h	DWORD	EBP
 0Ch	DWORD	reserved (00h)
 10h	DWORD	EBX
 14h	DWORD	EDX
 18h	DWORD	ECX
 1Ch	DWORD	EAX
 20h	WORD	flags
 22h	WORD	ES
 24h	WORD	DS
 26h	WORD	FS
 28h	WORD	GS
 2Ah	WORD	IP
 2Ch	WORD	CS
 2Eh	WORD	SP
 30h	WORD	SS
----------310301-----------------------------
INT 31 P - DPMI 0.9+ - CALL REAL MODE PROCEDURE WITH FAR RETURN FRAME
	AX = 0301h
	BH = flags
	    bit 0: reset the interrupt controller and A20 line (DPMI 0.9)
		   reserved, must be 0 (DPMI 1.0+)
	    others must be 0
	CX = number of words to copy from protected mode to real mode stack
	ES:DI / ES:EDI = selector:offset of real mode call structure
			(see INT 31/AX=0300h)
Return: CF clear if successful
	    real mode call structure modified (all fields except SS:SP, CS:IP
	      filled with return values from real mode interrupt)
	CF set on error
	    AX = error code (DPMI 1.0+) (8012h,8013h,8014h,8021h)(see AX=0000h)
	protected mode stack unchanged
Notes:	16-bit programs use ES:DI as pointer, 32-bit programs use ES:EDI
	the real mode procedure must exit with a FAR return
	DPMI will provide a small (30 words) real mode stack if SS:SP is zero
	the real mode handler must return with the stack in the same state as
	  it was on being called
SeeAlso: AX=0300h,AX=0302h,INT 21/AX=250Eh,INT 21/AH=E1h"OS/286"
----------310302-----------------------------
INT 31 P - DPMI 0.9+ - CALL REAL MODE PROCEDURE WITH IRET FRAME
	AX = 0302h
	BH = flags
	    bit 0: reset the interrupt controller and A20 line (DPMI 0.9)
		   reserved, must be 0 (DPMI 1.0+)
	    others must be 0
	CX = number of words to copy from protected mode to real mode stack
	ES:DI / ES:EDI = selector:offset of real mode call structure
			(see INT 31/AX=0300h)
Return:	CF clear if successful
	    real mode call structure modified (all fields except SS:SP, CS:IP
	      filled with return values from real mode interrupt)
	CF set on error
	    AX = error code (DPMI 1.0+) (8012h,8013h,8014h,8021h)(see AX=0000h)
	protected mode stack unchanged
Notes:	16-bit programs use ES:DI as pointer, 32-bit programs use ES:EDI
	the flags in the call structure are pushed on the real mode stack to
	  form an interrupt stack frame, and the trace and interrupt flags are
	  clear on entry to the handler
	the real mode procedure must exit with an IRET
	DPMI will provide a small (30 words) real mode stack if SS:SP is zero
	the real mode handler must return with the stack in the same state as
	  it was on being called
SeeAlso: AX=0300h
----------310303-----------------------------
INT 31 P - DPMI 0.9+ - ALLOCATE REAL MODE CALLBACK ADDRESS
	AX = 0303h
	DS:SI / DS:ESI = selector:offset of procedure to call
	ES:DI / ES:EDI = selector:offset of real mode call structure
			(see AX=0300h)
Return: CF clear if successful
	    CX:DX = segment:offset of real mode call address
	CF set on error
	    AX = error code (DPMI 1.0+) (8015h) (see AX=0000h)
Notes:	the real mode call structure is static, causing reentrancy problems;
	  its contents are only valid at the time of a callback
	the called procedure must modify the real mode CS:IP before returning
	values are returned to real mode by modifying the real mode call struc
	DPMI hosts must provide at least 16 callbacks per client
SeeAlso: AX=0304h,AX=0C00h

Values callback procedure is called with:
	DS:SI / DS:ESI = selector:offset of real mode SS:SP
	ES:DI / ES:EDI = selector:offset of real mode call structure
	SS:SP / SS:ESP = locked protected mode API stack
	interrupts disabled
Return: (with IRET)
	ES:DI / ES:EDI = selector:offset of real mode call structure to restore
----------310304-----------------------------
INT 31 P - DPMI 0.9+ - FREE REAL MODE CALLBACK ADDRESS
	AX = 0304h
	CX:DX = real mode callback address
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8024h) (see AX=0000h)
SeeAlso: AX=0303h
----------310305-----------------------------
INT 31 P - DPMI 0.9+ - GET STATE SAVE/RESTORE ADDRESSES
	AX = 0305h
Return: CF clear
	AX = size in bytes of state buffer
	BX:CX = real mode address of procedure to save/restore state
	SI:DI / SI:EDI = protected mode procedure to save/restore state
Notes:	the buffer size will be zero if it is not necessary to preserve state
	16-bit programs should call SI:DI, 32-bit programs should call SI:EDI
	this function is only needed if using the raw mode switch service
SeeAlso: AX=0306h

Values to call state-save procedures with:
	AL = direction
	    00h save state
	    01h restore state
	ES:DI / ES:EDI -> state buffer
Return: all registers preserved
----------310306-----------------------------
INT 31 P - DPMI 0.9+ - GET RAW MODE SWITCH ADDRESSES
	AX = 0306h
Return:	CF clear
	BX:CX -> procedure to switch from real to protected mode
	SI:DI / SI:EDI -> procedure to switch from protected to real mode
Notes:	16-bit programs should jump to SI:DI, 32-bit programs should use SI:EDI
	the caller must save and restore the state of the task with AX=0305h
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0305h

Values to JUMP at mode-switch procedures with:
	AX = new DS
	CX = new ES
	DX = new SS
	BX / EBX = new SP / ESP
	SI = new CS
	DI / EDI = new IP / EIP
Notes:	BP/EBP is preserved across the call, but AX/EAX, BX/EBX, CX/ECX,
	  DX/EDX, SI/ESI, and DI/EDI will be undefined; FS and GS will be 0000h
	interrupts will stay disabled during the entire mode switch if they
	  are disabled on entry to the mode-switch procedure
----------310400-----------------------------
INT 31 P - DPMI 0.9+ - GET DPMI VERSION
	AX = 0400h
Return: CF clear
	AH = major version of DPMI spec supported
	AL = two-digit minor version of DPMI spec supported
	BX = flags
	    bit 0: running under an 80386 (32-bit) implementation
	    bit 1: processor returns to real mode for reflected interrupts
		   instead of V86 mode
	    bit 2: virtual memory supported
	    bit 3: reserved (undefined)
	    others reserved (zero)
	CL = processor type (02h=80286, 03h=80386, 04h=80486)
	DH = curr value of virtual master interrupt controller base interrupt
	DL = curr value of virtual slave interrupt controller base interrupt
SeeAlso: AX=0401h,INT 21/AX=250Ch,INT 67/AX=DE0Ah
----------310401-----------------------------
INT 31 P - DPMI 1.0+ - GET DPMI CAPABILITIES
	AX = 0401h
	ES:(E)DI -> 128-byte buffer (see below)
Return: CF clear if successful
	    AX = capabilities
		bit 0: paged accessed/dirty supported (see AX=0506h,AX=0507h)
		    1: exceptions restartability supported
		    2: device mapping supported (see AX=0508h)
		    3: conventional memory mapping supported (see AX=0509h)
		    4: demand zero-fill supported
		    5: write-protect client capability supported
		    6: write-protect host capability supported
		    7-15: reserved
	    CX = reserved (00h)
	    DX = reserved (00h)
	    buffer filled
	CF set on error (DPMI 0.9 only)
SeeAlso: AX=0400h

Format of buffer:
Offset	Size	Description
 00h	BYTE	host major version number
 01h	BYTE	host minor version number
 02h 126 BYTEs	ASCIZ host vendor name
----------310500-----------------------------
INT 31 P - DPMI 0.9+ - GET FREE MEMORY INFORMATION
	AX = 0500h
	ES:DI / ES:EDI -> buffer for memory information (see below)
Return: CF clear
Notes:	16-bit programs use ES:DI, 32-bit programs use ES:EDI
	this function must be considered advisory because other applications
	  may affect the results at any time after the call
	fields not supported by the DPMI implementation are filled with
	  FFFFFFFFh
	DPMI 1.0+ supports this function solely for backward compatibility; use
	  AX=050Bh instead
SeeAlso: AX=0501h,AX=0604h

Format of memory information:
Offset	Size	Description
 00h	DWORD	largest available block in bytes
 04h	DWORD	maximum unlocked page allocation
 08h	DWORD	maximum locked page allocation
 0Ch	DWORD	total linear address space in pages
 10h	DWORD	total unlocked pages
 14h	DWORD	free pages
 18h	DWORD	total physical pages
 1Ch	DWORD	free linear address space in pages
 20h	DWORD	size of paging file/partition in pages
 24h 12 BYTEs	reserved
----------310501-----------------------------
INT 31 P - DPMI 0.9+ - ALLOCATE MEMORY BLOCK
	AX = 0501h
	BX:CX = size in bytes
Return: CF clear if successful
	    BX:CX = linear address of block
	    SI:DI = memory block handle for resizing and freeing block
	CF set on error
	    AX = error code (DPMI 1.0+) (8012h-8014h,8016h,8021h)(see AX=0000h)
Notes:	no selectors are allocated
	the memory block is allocated unlocked (can be locked with AX=0600h)
	allocations are often page granular (see AX=0604h)
SeeAlso: AX=0000h,AX=0100h,AX=0500h,AX=0502h,AX=0503h,AX=0504h,AX=0D00h
----------310502-----------------------------
INT 31 P - DPMI 0.9+ - FREE MEMORY BLOCK
	AX = 0502h
	SI:DI = handle of memory block
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8023h) (see AX=0000h)
Note:	any selectors allocated for the memory block must also be freed,
	  preferably before freeing the memory block
SeeAlso: AX=0001h,AX=0101h,AX=0501h,AX=0D01h
----------310503-----------------------------
INT 31 P - DPMI 0.9+ - RESIZE MEMORY BLOCK
	AX = 0503h
	BX:CX = new size in bytes (nonzero)
	SI:DI = handle of memory block
Return: CF clear if successful
	    BX:CX = new linear address
	    SI:DI = new handle of memory block
	CF set on error
	    AX = error code (DPMI 1.0+) (8012h-8014h,8016h,8021h,8023h)
		(see AX=0000h)
Notes:	any selectors pointing at the block must be updated
	the previous memory block handle becomes invalid
	an error is returned if the new size is 0
SeeAlso: AX=0102h,AX=0501h,AX=0505h
----------310504-----------------------------
INT 31 P - DPMI 1.0+ - ALLOCATE LINEAR MEMORY BLOCK
	AX = 0504h
	EBX = page-aligned linear address of memory block (00000000h if any
		address is acceptable)
	ECX = size in bytes (nonzero)
	EDX = flags
	    bit 0: set to create committed pages instead of uncommitted pages
	    bits 1-31: reserved (0)
Return: CF clear if successful
	    EBX = linear address of memory block
	    ESI = memory block handle
	CF set on error
	    AX = error code (8001h,8012h-8014h,8016h,8021h,8025h)(see AX=0000h)
Note:	only supported by 32-bit DPMI hosts, but may be used by 16-bit clients
SeeAlso: AX=0501h,AX=0505h
----------310505-----------------------------
INT 31 P - DPMI 1.0+ - RESIZE LINEAR MEMORY BLOCK
	AX = 0505h
	ESI = memory block handle
	ECX = new size in bytes (nonzero)
	EDX = flags
	    bit 0: create committed pages rather than uncommitted pages
	    bit 1: segment descriptor update required
		ES:EBX -> buffer containing array of WORDs with selectors
		EDI = number of selectors in array
	    bits 2-31: reserved (0)
Return: CF clear if successful
	    EBX = new linear base address
	    ESI = new memory block handle
	CF set on error
	    AX = error code (8001h,8012h-8014h,8016h,8021h,8023h)(see AX=0000h)
Notes:	only supported by 32-bit DPMI hosts, but may be used by 16-bit clients
	the old memory block handle becomes invalid
	if EDX bit 1 set and the block's base address is changed, DPMI updates
	  all descriptors for selectors in the update buffer which fall within
	  the memory block
SeeAlso: AX=0503h,AX=0504h
----------310506-----------------------------
INT 31 P - DPMI 1.0+ - GET PAGE ATTRIBUTES
	AX = 0506h
	ESI = memory block handle
	EBX = offset in memory block of first page
	ECX = number of pages
	ES:EDX -> array of WORDs to hold page attributes (see below)
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (8001h,8023h,8025h) (see AX=0000h)
Notes:	only supported by 32-bit DPMI hosts, but may be used by 16-bit clients
	if EBX is not page-aligned, it will be rounded down
SeeAlso: AX=0504h,AX=0507h,INT 21/AX=251Dh,INT 21/AX=EB00h

Format of page attribute words:
 bits 0-2	page type
		000 uncommitted
		001 committed
		010 mapped (see AX=0508h,AX=0509h)
		other currently unused
 bit 3		page is read/write rather than read-only
 bit 4		accessed/dirty bits supplied in bits 5 and 6
 bit 5		page has been accessed (only valid if bit 4 set)
 bit 6		page has been written (only valid if bit 4 set)
 bits 7-15	reserved (0)
----------310507-----------------------------
INT 31 P - DPMI 1.0+ - MODIFY PAGE ATTRIBUTES
	AX = 0507h
	ESI = memory block handle
	EBX = offset in memory block of first page
	ECX = number of pages
	ES:EDX -> array of WORDs with new page attributes (see AX=0506h)
Return: CF clear if successful
	CF set on error
	    AX = error code (8001h,8002h,8013h,8014h,8021h,8023h,8025h)
		(see AX=0000h)
	    ECX = number of pages which have been set
Notes:	only supported by 32-bit DPMI hosts, but may be used by 16-bit clients
	if EBX is not page-aligned, it will be rounded down
SeeAlso: AX=0504h,AX=0506h,INT 21/AX=251Eh
----------310508-----------------------------
INT 31 P - DPMI 1.0+ - MAP DEVICE IN MEMORY BLOCK
	AX = 0508h
	ESI = memory block handle
	EBX = page-aligned offset within memory block of page(s) to be mapped
	ECX = number of pages to map
	EDX = page-aligned physical address of device
Return: CF clear if successful
	CF set on error
	    AX = error code (8001h,8003h,8023h,8025h) (see AX=0000h)
Notes:	only supported by 32-bit DPMI hosts, but may be used by 16-bit clients
	support of this function is optional; hosts are also allowed to support
	  the function for some devices but not others
SeeAlso: AX=0504h,AX=0509h,AX=0800h,AX=0801h
----------310509-----------------------------
INT 31 P - DPMI 1.0+ - MAP CONVENTIONAL MEMORY IN MEMORY BLOCK
	AX = 0509h
	ESI = memory block handle
	EBX = page-aligned offset within memory block of page(s) to map
	ECX = number of pages to map
	EDX = page-aligned linear address of conventional (below 1M) memory
Return: CF clear if successful
	CF set on error
	    AX = error code (8001h,8003h,8023h,8025h) (see AX=0000h)
Notes:	only supported by 32-bit DPMI hosts, but may be used by 16-bit clients
	support of this function is optional
SeeAlso: AX=0504h,AX=0508h,AX=0801h
----------31050A-----------------------------
INT 31 P - DPMI 1.0+ - GET MEMORY BLOCK SIZE AND BASE
	AX = 050AH
	SI:DI = memory block handle
Return: CF clear if successful
	    SI:DI = size in bytes
	    BX:CX = base address
	CF set on error
	    AX = error code (8023h) (see AX=0000h)
SeeAlso: AX=0501h,AX=0504h
----------31050B-----------------------------
INT 31 P - DPMI 1.0+ - GET MEMORY INFORMATION
	AX = 050Bh
	ES:(E)DI -> 128-byte buffer for memory information (see below)
Return: CF clear if successful
	CF set on error (DPMI 0.9 only)
Note:	16-bit programs use ES:DI, 32-bit programs must use ES:EDI
SeeAlso: AX=0500h

Format of memory information:
Offset	Size	Description
 00h	DWORD	total allocated bytes of physical memory controlled by host
 04h	DWORD	total allocated bytes of virtual memory controlled by host
 08h	DWORD	total available bytes of virtual memory controlled by host
 0Ch	DWORD	total allocated bytes of virtual memory for curr virtual mach
 10h	DWORD	total available bytes of virtual memory for curr virtual mach
 14h	DWORD	total allocated bytes of virtual memory for current client
 18h	DWORD	total available bytes of virtual memory for current client
 1Ch	DWORD	total locked bytes for current client
 20h	DWORD	maximum locked bytes for current client
 24h	DWORD	highest linear address available to current client
 28h	DWORD	largest available memory block in bytes
 2Ch	DWORD	minimum allocation unit in bytes
 30h	DWORD	allocation alignment unit size in bytes
 34h 76 BYTEs	reserved (00h)
----------310600-----------------------------
INT 31 P - DPMI 0.9+ - LOCK LINEAR REGION
	AX = 0600h
	BX:CX = starting linear address
	SI:DI = size of region in bytes
Return: CF clear if successful
	CF set on error
	    none of the memory is locked
	    AX = error code (DPMI 1.0+) (8013h,8017h,8025h) (see AX=0000h)
Notes:	pages at beginning and end will be locked if the region overlaps them
	may be called multiple times for a given page; the DPMI host keeps a
	  lock count for each page
SeeAlso: AX=0004h,AX=0601h,INT 21/AX=251Ah,INT 21/AX=EB06h
----------310601-----------------------------
INT 31 P - DPMI 0.9+ - UNLOCK LINEAR REGION
	AX = 0601h
	BX:CX = starting linear address
	SI:DI = size of region in bytes
Return: CF clear if successful
	CF set on error
	    none of the memory is unlocked
	    AX = error code (DPMI 1.0+) (8002h,8025h) (see AX=0000h)
Notes:	pages at beginning and end will be unlocked if the region overlaps them
	memory whose lock count has not reached zero remains locked
SeeAlso: AX=0005h,AX=0600h,INT 21/AX=251Bh,INT 21/AX=EB07h
----------310602-----------------------------
INT 31 P - DPMI 0.9+ - MARK REAL MODE REGION AS PAGEABLE
	AX = 0602h
	BX:CX = starting linear address
	SI:DI = size of region in bytes
Return: CF clear if successful
	CF set on error	
	    none of the memory is made pageable
	    AX = error code (DPMI 1.0+) (8002h,8025h) (see AX=0000h)
Notes:	must relock all unlocked real mode memory before terminating process
	  for DPMI 0.9; DPMI 1.0+ automatically relocks real mode memory
	pages at beginning and end will be unlocked if the region overlaps them
	pageability of real mode pages is binary, not a count
SeeAlso: AX=0600h,AX=0603h
----------310603-----------------------------
INT 31 P - DPMI 0.9+ - RELOCK REAL MODE REGION
	AX = 0603h
	BX:CX = starting linear address
	SI:DI = size of region in bytes
Return: CF clear if successful
	CF set on error	
	    none of the memory is relocked
	    AX = error code (DPMI 1.0+) (8002h,8013h,8025h) (see AX=0000h)
Notes:	pages at beginning and end will be relocked if the region overlaps them
	pageability of real mode pages is binary, not a count
SeeAlso: AX=0602h
----------310604-----------------------------
INT 31 P - DPMI 0.9+ - GET PAGE SIZE
	AX = 0604h
Return: CF clear if successful
	    BX:CX = page size in bytes
	CF set on error
	    AX = error code (DPMI 1.0+)
		8001h unsupported, 16-bit host
----------310700-----------------------------
INT 31 P - DPMI 0.9+ - MARK PAGES AS PAGING CANDIDATES
	AX = 0700h
	BX:CX = starting linear page number
	SI:DI = number of pages to mark as paging candidates
Return: ???
Note:	although marked as reserved in versions 0.9 and 1.0 of the DPMI
	  specification, this function is called by MS Windows TASKMAN,
	  PROGMAN, and KERNEL
SeeAlso: AX=0701h,AX=0702h
----------310701-----------------------------
INT 31 P - DPMI 0.9+ - DISCARD PAGES
	AX = 0701h
	BX:CX = starting linear page number
	SI:DI = number of pages to discard
Return: ???
Note:	although marked as reserved in versions 0.9 and 1.0 of the DPMI
	  specification, this function is called by MS Windows TASKMAN,
	  PROGMAN, and KERNEL
SeeAlso: AX=0700h,AX=0703h
----------310702-----------------------------
INT 31 P - DPMI 0.9+ - MARK PAGE AS DEMAND PAGING CANDIDATE
	AX = 0702h
	BX:CX = starting linear address
	SI:DI = number of bytes to mark as paging candidates
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8025h) (see AX=0000h)
Notes:	this function is advisory, and does not force immediate paging
	partial pages will not be discarded
SeeAlso: AX=0700h,AX=0703h
----------310703-----------------------------
INT 31 P - DPMI 0.9+ - DISCARD PAGE CONTENTS
	AX = 0703h
	BX:CX = starting linear address
	SI:DI = number of bytes to mark as discarded
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8025h) (see AX=0000h)
Notes:	this function is advisory, and may be ignored by DPMI implementations
	partial pages will not be discarded
SeeAlso: AX=0701h,AX=0702h
----------310800-----------------------------
INT 31 P - DPMI 0.9+ - PHYSICAL ADDRESS MAPPING
	AX = 0800h
	BX:CX = physical address (should be above 1 MB)
	SI:DI = size in bytes
Return:	CF clear if successful
	    BX:CX = linear address which maps the requested physical memory
	CF set on error
	    AX = error code (DPMI 1.0+) (8003h,8021h) (see AX=0000h)
Notes:	implementations may refuse this call because it can circumvent protects
	the caller must build an appropriate selector for the memory
	do not use for memory mapped in the first megabyte
SeeAlso: AX=0002h,AX=0508h,AX=0509h,AX=0801h,INT 21/AX=250Ah,INT 21/AX=EB05h
----------310801-----------------------------
INT 31 P - DPMI 1.0+ - FREE PHYSICAL ADDRESS MAPPING
	AX = 0801h
	BX:CX = linear address returned by AX=0800h
Return: CF clear if successful
	CF set on error
	    AX = error code (8025h) (see AX=0000h)
Note:	should be called at end of access to device mapped with AX=0800h
SeeAlso: AX=0508h,AX=0509h,AX=0800h,INT 21/AX=EB03h
----------310900-----------------------------
INT 31 P - DPMI 0.9+ - GET AND DISABLE VIRTUAL INTERRUPT STATE
	AX = 0900h
Return: CF clear
	virtual interrupts disabled
	AL = 00h if previously disabled
	   = 01h if previously enabled
	AH preserved
Notes:	the previous state may be restored simply by executing another INT 31
	a CLI instruction may be used if the previous state is unimportant,
	  but should be assumed to be very slow due to trapping by the host
SeeAlso: AX=0901h,AX=0902h
----------310901-----------------------------
INT 31 P - DPMI 0.9+ - GET AND ENABLE VIRTUAL INTERRUPT STATE
	AX = 0901h
Return: CF clear
	virtual interrupts enabled
	AL = 00h if previously disabled
	   = 01h if previously enabled
	AH preserved
Notes:	the previous state may be restored simply by executing another INT 31
	a STI instruction may be used if the previous state is unimportant,
	  but should be assumed to be very slow due to trapping by the host
SeeAlso: AX=0900h,AX=0902h
----------310902-----------------------------
INT 31 P - DPMI 0.9+ - GET VIRTUAL INTERRUPT STATE
	AX = 0902h
Return: CF clear
	AL = 00h if disabled
	   = 01h if enabled
Note:	should be used rather than PUSHF because that instruction yields the
	  physical interrupt state rather than the per-client virtualized
	  interrupt flag
SeeAlso: AX=0900h,AX=0901h
----------310A00-----------------------------
INT 31 P - DPMI 0.9+ - GET VENDOR SPECIFIC API ENTRY POINT
	AX = 0A00h
	DS:SI / DS:ESI -> case-sensitive ASCIZ vendor name or identifier
Return: CF clear if successful
	    ES:DI / ES:EDI -> FAR extended API entry point
	    DS, FS, GS, EAX, EBX, ECX, EDX, ESI, EBP destroyed
	CF set on error
	    AX = error code (DPMI 1.0+) (8001h) (see AX=0000h)
Notes:	extended API parameters are vendor-specific
	DPMI 1.0+ supports this function solely for backward compatibility; use
	  INT 2F/AX=168Ah instead
SeeAlso: INT 2F/AX=168Ah
----------310B00-----------------------------
INT 31 P - DPMI 0.9+ - SET DEBUG WATCHPOINT
	AX = 0B00h
	BX:CX = linear address
	DL = size (1,2,4 bytes)
	DH = type (00h execute, 01h write, 02h read/write)
Return: CF clear if successful
	    BX = watchpoint handle
	CF set on error
	    AX = error code (DPMI 1.0+) (8016h,8021h,8025h) (see AX=0000h)
SeeAlso: AX=0212h,AX=0601h
----------310B01-----------------------------
INT 31 P - DPMI 0.9+ - CLEAR DEBUG WATCHPOINT
	AX = 0B01h
	BX = watchpoint handle
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8023h) (see AX=0000h)
Note:	the watchpoint handle is freed
SeeAlso: AX=0B00h
----------310B02-----------------------------
INT 31 P - DPMI 0.9+ - GET STATE OF DEBUG WATCHPOINT
	AX = 0B02h
	BX = watchpoint handle
Return: CF clear if successful
	    AX = status flags
		bit 0: watch point has been executed since AX=0B00h or AX=0B03h
	CF set on error
	    AX = error code (DPMI 1.0+) (8023h) (see AX=0000h)
SeeAlso: AX=0B00h,AX=0B03h
----------310B03-----------------------------
INT 31 P - DPMI 0.9+ - RESET DEBUG WATCHPOINT
	AX = 0B03h
	BX = watchpoint handle
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8023h) (see AX=0000h)
SeeAlso: AX=0B02h
----------310C00-----------------------------
INT 31 P - DPMI 1.0+ - INSTALL RESIDENT HANDLER INIT CALLBACK
	AX = 0C00h
	ES:(E)DI -> resident service provider structure (see below)
Return: CF clear if successful
	CF set on error
	    AX = error code (8015h,8021h,8025h) (see AX=0000h)
Note:	calling this function declares an intent to provide resident
	  protected mode services after terminating with AX=0C01h
SeeAlso: AX=0303h,AX=0C01h

Format of resident service provider structure:
Offset	Size	Description
 00h	QWORD	descriptor for 16-bit data segment
 08h	QWORD	descriptor for 16-bit code segment (zeros if not supported)
 10h	WORD	offset of 16-bit callback procedure
 12h  2 BYTEs	reserved
 14h	QWORD	descriptor for 32-bit data segment
 1Ch	QWORD	descriptor for 32-bit code segment (zeros if not supported)
 24h	DWORD	offset of 32-bit callback procedure
----------310C01-----------------------------
INT 31 P - DPMI 1.0+ - TERMINATE AND STAY RESIDENT
	AX = 0C01h
	BL = return code
	DX = number of paragraphs of DOS memory to reserve (0 or >= 6)
Return: never
Notes:	should only be used if the program will only provide services to
	  other DPMI programs
	any protected mode memory remains allocated to the program unless
	  explicitly freed before this call
	must first call AX=0C00h or program will simply be terminated
SeeAlso: AX=0C00h,INT 21/AH=31h
----------310D00-----------------------------
INT 31 P - DPMI 1.0+ - ALLOCATE SHARED MEMORY
	AX = 0D00h
	ES:(E)DI -> shared memory allocation request structure (see below)
Return: CF clear if successful
	    request structure updated
	CF set on error
	    AX = error code (8012h,8013h,8014h,8016h,8021h) (see AX=0000h)
Note:	first 16 bytes of memory block will be initialized to zeros on the
	  first allocation
SeeAlso: AX=0501h,AX=0D01h,AX=0D02h

Format of shared memory allocation request structure:
Offset	Size	Description
 00h	DWORD	requested length of shared memory block in bytes
 04h	DWORD	(return) allocated length of block
 08h	DWORD	(return) shared memory handle
 0Ch	DWORD	(return) linear address of memory block
 10h  6 BYTEs	selector:offset32 of ASCIZ name for memory block
		(name max 128 bytes)
 16h  2 BYTEs	reserved
 18h  4 BYTEs	reserved (00h)
----------310D01-----------------------------
INT 31 P - DPMI 1.0+ - FREE SHARED MEMORY
	AX = 0D01h
	SI:DI = shared memory block handle
Return: CF clear if successful
	CF set on error
	    AX = error code (8023h) (see AX=0000h)
Notes:	handle becomes invalid after this call
	DPMI maintains separate global and virtual machine use counts for each
	  shared memory block; when the global use counts reaches zero, the
	  block is finally destroyed
SeeAlso: AX=0502h,AX=0D00h
----------310D02-----------------------------
INT 31 P - DPMI 1.0+ - SERIALIZE SHARED MEMORY
	AX = 0D02h
	SI:DI = shared memory block handle
	DX = flags
	    bit 0: return immediately rather than suspending if serialization
			unavailable
		1: shared rather than exclusive serialization
		2-15: reserved (0)
Return: CF clear if successful
	CF set on error
	    AX = error code (8004h,8005h,8017h-8019h,8023h) (see AX=0000h)
Notes:	an exclusive serialization blocks any other serialization attempts for
	  the same block by another virtual machine; a shared serialization
	  blocks attempts at exclusive serialization by another virtual machine
	hosts are not required to detect deadlock
	a client's interrupt handler can cancel a serialization call which
	  caused it to block by calling AX=0D03h
SeeAlso: AX=0D00h,AX=0D03h
----------310D03-----------------------------
INT 31 P - DPMI 1.0+ - FREE SERIALIZATION ON SHARED MEMORY
	AX = 0D03h
	SI:DI = shared memory block handle
	DX = flags
	    bit 0: release shared serialization rather than exclusive serialztn
	    bit 1: free pending serialization
	    bits 2-15: reserved (0)
Return: CF clear if successful
	CF set on error
	    AX = error code (8002h,8023h) (see AX=0000h)
SeeAlso: AX=0D00h,AX=0D02h
----------310E00-----------------------------
INT 31 P - DPMI 1.0+ - GET COPROCESSOR STATUS
	AX = 0E00h
Return: CF clear
	AX = coprocessor status
	    bit 0: numeric coprocessor enabled for current client
	    bit 1: client is emulating coprocessor
	    bit 2: numeric coprocessor is present
	    bit 3: host is emulating coprocessor instructions
	    bits 4-7: coprocessor type
		0000 none
		0010 80287
		0011 80387
		0100 80486 with numeric coprocessor
		other reserved
	    bits 8-15: not used
Note:	supported by 386MAX v6.01, which otherwise only supports DPMI 0.9
SeeAlso: AX=0E01h
----------310E01-----------------------------
INT 31 P - DPMI 1.0+ - SET EMULATION
	AX = 0E01h
	BX = coprocessor flag bits
	    bit 0: enable numeric coprocessor for current client
	    bit 1: client will emulate coprocessor
	    bits 2-15: not used
Return: CF clear if successful
	CF set on error
	    AX = error code (8026h) (see AX=0000h)
Note:	supported by 386MAX v6.01, which otherwise only supports DPMI 0.9
SeeAlso: AX=0E00h
----------32---------------------------------
INT 32 - VIRUS - reportedly used by "Tiny" Viruses
SeeAlso: INT 60"VIRUS"
----------330000-----------------------------
INT 33 - MS MOUSE - RESET DRIVER AND READ STATUS
	AX = 0000h
Return: AX = status
	    0000h hardware/driver not installed
	    FFFFh hardware/driver installed
	BX = number of buttons
	    0000h other than two
	    0002h two buttons (many drivers)
	    0003h Mouse Systems/Logitech three-button mouse
	    FFFFh two buttons
Notes:	to use mouse on a Hercules-compatible monographics card in graphics
	  mode, you must first set 0040h:0049h to 6 for page 0 or 5 for page 1,
	  and then call this function.	Logitech drivers v5.01 and v6.00
	  reportedly do not correctly use Hercules graphics in dual-monitor
	  systems, while version 4.10 does.
	the Logitech mouse driver contains the signature string "LOGITECH" 
	  three bytes past the interrupt handler; many of the Logitech mouse
	  utilities check for this signature.
SeeAlso: AX=0011h,AX=0021h,AX=002Fh,INT 62/AX=007Ah,INT 74
----------330001-----------------------------
INT 33 - MS MOUSE - SHOW MOUSE CURSOR
	AX = 0001h
SeeAlso: AX=0002h,INT 16/AX=FFFEh,INT 62/AX=007Bh
----------330002-----------------------------
INT 33 - MS MOUSE - HIDE MOUSE CURSOR
	AX = 0002h
Note:	multiple calls to hide the cursor will require multiple calls to
	  function 01h to unhide it.
SeeAlso: AX=0001h,AX=0010h,INT 16/AX=FFFFh,INT 62/AX=007Bh
----------330003-----------------------------
INT 33 - MS MOUSE - RETURN POSITION AND BUTTON STATUS
	AX = 0003h
Return: BX = button status
	   bit 0  left button pressed if 1
	   bit 1  right button pressed if 1
	   bit 2  middle button pressed if 1 (Mouse Systems/Logitech mouse)
	CX = column
	DX = row
SeeAlso: AX=0004h,AX=000Bh,INT 2F/AX=D000h"ZWmous"
----------330004-----------------------------
INT 33 - MS MOUSE - POSITION MOUSE CURSOR
	AX = 0004h
	CX = column
	DX = row
Note:	the row and column are truncated to the next lower multiple of the cell
	  size; however, some versions of the Microsoft documentation
	  incorrectly state that the coordinates are rounded
SeeAlso: AX=0003h,INT 62/AX=0081h
----------330005-----------------------------
INT 33 - MS MOUSE - RETURN BUTTON PRESS DATA
	AX = 0005h
	BX = button
	    0000h left
	    0001h right
	    0002h middle (Mouse Systems/Logitech mouse)
Return: AX = button states
	    bit 0 left button pressed if 1
	    bit 1 right button pressed if 1
	    bit 2 middle button pressed if 1 (Mouse Systems/Logitech mouse)
	BX = number of times specified button has been pressed since last call
	CX = column at time specified button was last pressed
	DX = row at time specified button was last pressed
SeeAlso: AX=0006h,INT 62/AX=007Ch
----------330006-----------------------------
INT 33 - MS MOUSE - RETURN BUTTON RELEASE DATA
	AX = 0006h
	BX = button
	    0000h left
	    0001h right
	    0002h middle (Mouse Systems/Logitech mouse)
Return: AX = button states
	    bit 0 left button pressed if 1
	    bit 1 right button pressed if 1
	    bit 2 middle button pressed if 1 (Mouse Systems/Logitech mouse)
	BX = number of times specified button has been released since last call
	CX = column at time specified button was last released
	DX = row at time specified button was last released
SeeAlso: AX=0005h,INT 62/AX=007Ch
----------330007-----------------------------
INT 33 - MS MOUSE - DEFINE HORIZONTAL CURSOR RANGE
	AX = 0007h
	CX = minimum column
	DX = maximum column
SeeAlso: AX=0008h,AX=0010h,AX=0031h,INT 62/AX=0080h
----------330008-----------------------------
INT 33 - MS MOUSE - DEFINE VERTICAL CURSOR RANGE
	AX = 0008h
	CX = minimum row
	DX = maximum row
SeeAlso: AX=0007h,AX=0010h,AX=0031h,INT 62/AX=0080h
----------330009-----------------------------
INT 33 - MS MOUSE - DEFINE GRAPHICS CURSOR
	AX = 0009h
	BX = column of cursor hot spot in bitmap (-16 to 16)
	CX = row of cursor hot spot (-16 to 16)
	ES:DX -> bitmap
		16 words screen mask
		16 words cursor mask
		    each word defines the sixteen pixels of a row, low bit
		    rightmost
SeeAlso: AX=000Ah,AX=0012h,AX=002Ah,INT 62/AX=007Fh
----------33000A-----------------------------
INT 33 - MS MOUSE - DEFINE TEXT CURSOR
	AX = 000Ah
	BX = hardware/software text cursor
	    0000h software
		CX = screen mask
		DX = cursor mask
	    0001h hardware
		CX = start scan line
		DX = end scan line
Note:	when the software cursor is selected, the char/attribute data at the
	  current screen position is ANDed with the screen mask and then XORed
	  with the cursor mask
SeeAlso: AX=0009h,INT 62/AX=007Eh
----------33000B-----------------------------
INT 33 - MS MOUSE - READ MOTION COUNTERS
	AX = 000Bh
Return: CX = number of mickeys mouse moved horizontally since last call
	DX = number of mickeys mouse moved vertically
Notes:	a mickey is the smallest increment the mouse can sense
	positive values indicate down/right
SeeAlso: AX=0003h,AX=001Bh,AX=0027h
----------33000C-----------------------------
INT 33 - MS MOUSE - DEFINE INTERRUPT SUBROUTINE PARAMETERS
	AX = 000Ch
	CX = call mask
	     bit 0 call if mouse moves
	     bit 1 call if left button pressed
	     bit 2 call if left button released
	     bit 3 call if right button pressed
	     bit 4 call if right button released
	     bit 5 call if middle button pressed (Mouse Systems/Logitech mouse)
	     bit 6 call if middle button released (Mouse Sys/Logitech mouse)
	ES:DX -> FAR routine
Notes:	when the subroutine is called, it is passed the following values:
	  AX = condition mask (same bit assignments as call mask)
	  BX = button state
	  CX = cursor column
	  DX = cursor row
	  SI = horizontal mickey count
	  DI = vertical mickey count
	some versions of the Microsoft documentation incorrectly state that CX
	  bit 0 means call if mouse cursor moves, and swap the meanings of SI
	  and DI
SeeAlso: AX=0018h
----------33000D-----------------------------
INT 33 - MS MOUSE - LIGHT PEN EMULATION ON
	AX = 000Dh
SeeAlso: AX=000Eh,INT 10/AH=04h
----------33000E-----------------------------
INT 33 - MS MOUSE - LIGHT PEN EMULATION OFF
	AX = 000Eh
SeeAlso: AX=000Dh
----------33000F-----------------------------
INT 33 - MS MOUSE - DEFINE MICKEY/PIXEL RATIO
	AX = 000Fh
	CX = number of mickeys per 8 pixels horizontally (default 8)
	DX = number of mickeys per 8 pixels vertically (default 16)
SeeAlso: AX=0013h,AX=001Ah,INT 62/AX=0082h
----------330010-----------------------------
INT 33 - MS MOUSE - DEFINE SCREEN REGION FOR UPDATING
	AX = 0010h
	CX,DX = X,Y coordinates of upper left corner
	SI,DI = X,Y coordinates of lower right corner
Note:	mouse cursor is hidden in the specified region, and needs to be
	  explicitly turned on again
SeeAlso: AX=0001h,AX=0002h,AX=0007h,AX=0010h"Genius MOUSE",AX=0031h
----------330010-----------------------------
INT 33 - Genius MOUSE - DEFINE SCREEN REGION FOR UPDATING
	AX = 0010h
	ES:DX -> update region list (see below)
Notes:	mouse cursor is hidden in the specified region, and needs to be
	  explicitly turned on again
	this version of the call is described in an August 1988 version of the
	  Genius Mouse programmer's reference; it has been changed to conform
	  to the Microsoft version shown above by version 9.06 (and possibly
	  earlier versions)
SeeAlso: AX=0001h,AX=0002h,AX=0007h,AX=0010h"MS MOUSE"

Format of update region list:
Offset	Size	Description
 00h	WORD	left-most column
 02h	WORD	top-most row
 04h	WORD	right-most column
 06h	WORD	bottom-most row
----------330011-----------------------------
INT 33 - Genius Mouse 9.06 - GET NUMBER OF BUTTONS
	AX = 0011h
Return: AX = FFFFh
	BX = number of buttons
SeeAlso: AX=0000h
----------330012-----------------------------
INT 33 - MS MOUSE - SET LARGE GRAPHICS CURSOR BLOCK
	AX = 0012h
	BH = cursor width in words
	CH = rows in cursor
	BL = horizontal hot spot (-16 to 16)
	CL = vertical hot spot (-16 to 16)
	ES:DX -> bit map of screen and cursor maps
Return: AX = FFFFh if successful
SeeAlso: AX=0009h,AX=002Ah,AX=0035h
----------330013-----------------------------
INT 33 - MS MOUSE - DEFINE DOUBLE-SPEED THRESHOLD
	AX = 0013h
	DX = threshold speed in mickeys/second, 0000h = default of 64/second
Note:	if speed exceeds threshold, the cursor's on-screen motion is doubled
SeeAlso: AX=000Fh,AX=001Bh,AX=002Ch
----------330014-----------------------------
INT 33 - MS MOUSE - EXCHANGE INTERRUPT SUBROUTINES
	AX = 0014h
	CX = call mask (see AX=000Ch)
	ES:DX -> FAR routine 
Return: CX = call mask of previous interrupt routine
	ES:DX = FAR address of previous interrupt routine
SeeAlso: AX=000Ch,AX=0018h
----------330015-----------------------------
INT 33 - MS MOUSE - RETURN DRIVER STORAGE REQUIREMENTS
	AX = 0015h
Return: BX = size of buffer needed to store driver state
SeeAlso: AX=0016h,AX=0017h,AX=0042h
----------330016-----------------------------
INT 33 - MS MOUSE - SAVE DRIVER STATE
	AX = 0016h
	BX = size of buffer (see AX=0015h)
	ES:DX -> buffer for driver state
Note:	although not documented, many drivers appear to require BX on input
SeeAlso: AX=0015h,AX=0017h
----------330017-----------------------------
INT 33 - MS MOUSE - RESTORE DRIVER STATE
	AX = 0017h
	BX = size of buffer (see AX=0015h)
	ES:DX -> buffer containing saved state
Notes:	although not documented, many drivers appear to require BX on input
	some mouse drivers range-check the values in the saved state based on
	  the current video mode; thus, the video mode should be restored
	  before the mouse driver's state is restored
SeeAlso: AX=0015h,AX=0016h
----------330018-----------------------------
INT 33 - MS MOUSE - SET ALTERNATE MOUSE USER HANDLER
	AX = 0018h
	CX = call mask
	     bit 0 call if mouse moves
	     bit 1 call if left button pressed
	     bit 2 call if left button released
	     bit 3 call if right button pressed
	     bit 4 call if right button released
	     bit 5 call if shift button pressed during event
	     bit 6 call if ctrl key pressed during event
	     bit 7 call if alt key pressed during event
	ES:DX -> FAR routine
Return: AX = 0018h if successful
	   = FFFFh on error
Notes:	when the subroutine is called, it is passed the following values:
	  AX = condition mask (same bit assignments as call mask)
	  BX = button state
	  CX = cursor column
	  DX = cursor row
	  SI = horizontal mickey count
	  DI = vertical mickey count
	up to three handlers can be defined by separate calls to this function
SeeAlso: AX=000Ch,AX=0014h,AX=0019h
----------330019-----------------------------
INT 33 - MS MOUSE - RETURN USER ALTERNATE INTERRUPT VECTOR
	AX = 0019h
	CX = call mask (see AX=0018h)
Return: BX:DX = user interrupt vector
	CX = call mask (0000h if not found)
Note:	attempts to find a user event handler (defined by function 18h)
	  whose call mask matches CX
SeeAlso: AX=0018h
----------33001A-----------------------------
INT 33 - MS MOUSE - SET MOUSE SENSITIVITY
	AX = 001Ah
	BX = horizontal speed \
	CX = vertical speed   / (see AX=000Fh)
	DX = double speed threshold (see AX=0013h)
SeeAlso: AX=0013h,AX=001Bh,INT 62/AX=0082h
----------33001B-----------------------------
INT 33 - MS MOUSE - RETURN MOUSE SENSITIVITY
	AX = 001Bh
Return: BX = horizontal speed
	CX = vertical speed
	DX = double speed threshold
SeeAlso: AX=000Bh,AX=001Ah
----------33001C-----------------------------
INT 33 - MS MOUSE - SET INTERRUPT RATE
	AX = 001Ch
	BX = rate
	    00h no interrupts allowed
	    01h 30 per second
	    02h 50 per second
	    03h 100 per second
	    04h 200 per second
Notes:	only available on InPort mouse
	values greater than 4 may cause unpredictable driver behavior
----------33001D-----------------------------
INT 33 - MS MOUSE - DEFINE DISPLAY PAGE NUMBER
	AX = 001Dh
	BX = display page number
Note:	the cursor will be displayed on the specified page
SeeAlso: AX=001Eh
----------33001E-----------------------------
INT 33 - MS MOUSE - RETURN DISPLAY PAGE NUMBER
	AX = 001Eh
Return: BX = display page number
SeeAlso: AX=001Dh
----------33001F-----------------------------
INT 33 - MS MOUSE - DISABLE MOUSE DRIVER
	AX = 001Fh
Return: AX = 001Fh unsuccessful
	     FFFFh successful
	ES:BX = vector for INT 33h before mouse driver was first installed
Note:	restores vectors for Int 10h and Int 71h (8086) or Int 74h (286/386)
	if you restore Int 33h to ES:BX, driver will be completely disabled
SeeAlso: AX=0020h
----------330020-----------------------------
INT 33 - MS MOUSE - ENABLE MOUSE DRIVER
	AX = 0020h
Return: AX = 0020h unsuccessful (or driver not installed)
	     FFFFh successful
Note:	restores vectors for Int 10h and Int 71h (8086) or Int 74h (286/386)
	  which were removed by function 1Fh
SeeAlso: AX=001Fh
----------330021-----------------------------
INT 33 - MS MOUSE - SOFTWARE RESET
	AX = 0021h
Return: AX = FFFFh if mouse driver installed
		BX = number of buttons (FFFFh = two buttons)
	     0021h if mouse driver not installed
Note:	identical to funtion 00h, but does not reset the mouse
SeeAlso: AX=0000h
----------330022-----------------------------
INT 33 - MS MOUSE - SET LANGUAGE FOR MESSAGES
	AX = 0022h
	BX = language
	    00h English
	    01h French
	    02h Dutch
	    03h German
	    04h Swedish
	    05h Finnish
	    06h Spanish
	    07h Portugese
	    08h Italian
Note:	only available on international versions of the driver, US versions
	  ignore this call
SeeAlso: AX=0023h
----------330023-----------------------------
INT 33 - MS MOUSE - GET LANGUAGE FOR MESSAGES
	AX = 0023h
Return:	BX = language (see AX=0022h)
Note:	the US version of the driver always returns zero 
SeeAlso: AX=0022h
----------330024-----------------------------
INT 33 - MS MOUSE v6.26+ - GET SOFTWARE VERSION, MOUSE TYPE, AND IRQ NUMBER
	AX = 0024h
Return: AX = FFFFh on error
	otherwise,
	    BH = major version
	    BL = minor version
	    CH = type (1=bus, 2=serial, 3=InPort, 4=PS/2, 5=HP)
	    CL = interrupt (0=PS/2, 2=IRQ2, 3=IRQ3,...,7=IRQ7)
SeeAlso: AX=004Dh,AX=006Dh
----------330025-----------------------------
INT 33 - MS MOUSE v6.26+ - GET GENERAL DRIVER INFORMATION
	AX = 0025h
Return: AX = general information
	    bit 15: driver loaded as device driver rather than TSR
	    bit 14: driver is newer integrated type
	    bits 13,12: current cursor type
			00 software text cursor
			01 hardware text cursor
			1X graphics cursor
	    bits 11-8: interrupt rate (see AX=001Ch)
	    bits 7-0:  count of currently-active Mouse Display Drivers (MDD),
			the newer integrated driver type
	BX = cursor lock flag for OS/2 to prevent reentrancy problems
	CX = mouse code active flag (for OS/2)
	DX = mouse driver busy flag (for OS/2)
----------330026-----------------------------
INT 33 - MS MOUSE v6.26+ - GET MAXIMUM VIRTUAL COORDINATES
	AX = 0026h
Return: BX = mouse-disabled flag
	CX = maximum virtual X (for current video mode)
	DX = maximum virtual Y
SeeAlso: AX=0031h
----------330026-----------------------------
INT 33 - Genius Mouse 9.06 - ???
	AX = 0026h
Return: CX = 0204h if CX was 0105h on entry, else unchanged
----------330027-----------------------------
INT 33 - MS MOUSE v7.01+ - GET SCREEN/CURSOR MASKS AND MICKEY COUNTS
	AX = 0027h
Return: AX = screen-mask value (or hardware cursor scan-line start for v7.02+)
	BX = cursor-mask value (or hardware cursor scan-line stop for v7.02+)
	CX = horizontal mickeys moved since last call
	DX = vertical mickeys moved since last call
SeeAlso: AX=000Bh
----------330028-----------------------------
INT 33 - MS MOUSE v7.0+ - SET VIDEO MODE
	AX = 0028h
	CX = new video mode (call is NOP if 0000h)
	DH = Y font size (00h = default)
	DL = X font size (00h = default)
Return: CL = status (00h = successful)
Note:	DX is ignored unless the selected video mode supports font size control
SeeAlso: AX=0029h,INT 10/AH=00h
----------330029-----------------------------
INT 33 - MS MOUSE v7.0+ - ENUMERATE VIDEO MODES
	AX = 0029h
	CX = previous video mode
	    0000h get first supported video mode
	    other get next supported mode after mode CX
Return: CX = first/next video mode (0000h = no more video modes)
	BS:DX -> description of video mode or 0000h:0000h if none
Notes:	the enumerated video modes may be in any order and may repeat
	the description string (if available) is terminated by '$' followed by
	  a NUL byte
SeeAlso: AX=0028h
----------33002A-----------------------------
INT 33 - MS MOUSE v7.02+ - GET CURSOR HOT SPOT
	AX = 002Ah
Return: AX = internal counter controlling cursor visibility
	BX = cursor hot spot column
	CX = cursor hot spot row
	DX = mouse type (00h none, 01h bus, 02h serial, 03h InPort, 04h IBM,
			 05h Hewlett-Packard)
Note:	the hot spot location is relative to the upper left corner of the
	  cursor block and may range from -128 to +127 both horizontally and
	  vertically
SeeAlso: AX=0009h,AX=0012h,AX=0035h
----------33002B-----------------------------
INT 33 - MS MOUSE v7.0+ - LOAD ACCELERATION PROFILES
	AX = 002Bh
	BX = active acceleration profile
		0001h-0004h or FFFFh to restore default curves
	ES:SI -> buffer containing acceleration profile data (see below)
Return: AX = success flag
SeeAlso: AX=002Ch,AX=002Dh,AX=0033h

Format of acceleration profile data:
Offset	Size	Description
 00h	BYTE	length of acceleration profile 1
 01h	BYTE	length of acceleration profile 2
 02h	BYTE	length of acceleration profile 3
 03h	BYTE	length of acceleration profile 4
 04h 32 BYTEs	threshold speeds for acceleration profile 1
 24h 32 BYTEs	threshold speeds for acceleration profile 2
 44h 32 BYTEs	threshold speeds for acceleration profile 3
 64h 32 BYTEs	threshold speeds for acceleration profile 4
 84h 32 BYTEs	speedup factor for acceleration profile 1
		(10h = 1.0, 14h = 1.25, 20h = 2.0, etc)
 A4h 32 BYTEs	speedup factor for acceleration profile 2
		(10h = 1.0, 14h = 1.25, 20h = 2.0, etc)
 C4h 32 BYTEs	speedup factor for acceleration profile 3
		(10h = 1.0, 14h = 1.25, 20h = 2.0, etc)
 E4h 32 BYTEs	speedup factor for acceleration profile 4
		(10h = 1.0, 14h = 1.25, 20h = 2.0, etc)
104h 16 BYTEs	name of acceleration profile 1 (blank-padded)
114h 16 BYTEs	name of acceleration profile 2 (blank-padded)
124h 16 BYTEs	name of acceleration profile 3 (blank-padded)
134h 16 BYTEs	name of acceleration profile 4 (blank-padded)
Note:	unused bytes in the threshold speed fields are filled with 7Fh and
	  unused bytes in the speedup factor fields are filled with 10h
----------33002C-----------------------------
INT 33 - MS MOUSE v7.0+ - GET ACCELERATION PROFILES
	AX = 002Ch
Return: AX = status (0000h success)
	BX = currently-active acceleration profile
	ES:SI -> acceleration profile data (see AX=002Bh)
SeeAlso: AX=002Bh,AX=002Dh,AX=0033h
----------33002D-----------------------------
INT 33 - MS MOUSE v7.0+ - SELECT ACCELERATION PROFILE
	AX = 002Dh
	BX = acceleration level
		0001h-0004h to set profile, or FFFFh to get current profile
Return: AX = status
	    0000h successful
		ES:SI -> 16-byte blank-padded name of acceleration profile
	    FFFEh invalid acceleration curve number
		ES:SI destroyed
	BX = active acceleration curve number
SeeAlso: AX=0013h,AX=002Bh,AX=002Ch,AX=002Eh
----------33002E-----------------------------
INT 33 - MS MOUSE v8.10+ - SET ACCELERATION PROFILE NAMES
	AX = 002Eh
	BL = flag (if nonzero, fill ES:SI buffer with default names on return)
	ES:SI -> 64-byte buffer for profile names (16 bytes per name)
Return: AX = status (0000h success)
	ES:SI buffer filled with default names if BL nonzero on entry
Note:	not supported by Logitech driver v6.10
SeeAlso: AX=002Ch,AX=002Dh,AX=012Eh,AX=022Eh
----------33002F-----------------------------
INT 33 - MS MOUSE v7.02+ - MOUSE HARDWARE RESET
	AX = 002Fh
Return: AX = status
Note:	invoked by mouse driver v8.20 on being called with INT 2F/AX=530Bh
SeeAlso: INT 2F/AH=53h
----------330030-----------------------------
INT 33 - MS MOUSE v7.04+ - GET/SET BallPoint INFORMATION
	AX = 0030h
	CX = command
	    0000h get status of BallPoint device
	    other set rotation angle and masks
		BX = rotation angle (-32768 to 32767 degrees)
		CH = primary button mask
		CL = secondary button mask
Return: AX = button status (FFFFh if no BallPoint)
		bit 5: button 1
		bit 4: button 2
		bit 3: button 3
		bit 2: button 4
		other: zero
	BX = rotation angle (0-360 degrees)
	CH = primary button mask
	CL = secondary button mask
----------330031-----------------------------
INT 33 - MS MOUSE v7.05+ - GET CURRENT MINIMUM/MAXIMUM VIRTUAL COORDINATES
	AX = 0031h
Return: AX = virtual X minimum
	BX = virtual Y minimum
	CX = virtual X maximum
	DX = virtual Y maximum
Note:	the minimum and maximum values are those set by AX=0007h and AX=0008h;
	  the default is minimum = 0 and maximum = absolute maximum
	  (see AX=0026h)
SeeAlso: AX=0007h,AX=0008h,AX=0010h,AX=0026h
----------330032-----------------------------
INT 33 - MS MOUSE v7.05+ - GET ACTIVE ADVANCED FUNCTIONS
	AX = 0032h
Return: AX = active function flags (FFFFh for v8.10)
		bit 15: function 0025h supported
		bit 14: function 0026h supported
		...
		bit 0: function 0034h supported
	BX = ??? (0000h) officially unused
	CX = ??? (E000h) officially unused
	DX = ??? (0000h) officially unused
----------330033-----------------------------
INT 33 - MS MOUSE v7.05+ - GET SWITCH SETTINGS AND ACCELERATION PROFILE DATA
	AX = 0033h
	CX = size of buffer
	    0000h get required buffer size
		Return: AX = 0000h
			CX = required size (0154h for Logitech v6.10, 0159h
				for MS v8.10-8.20)
	    other
		ES:DX -> buffer of CX bytes
		Return: AX = 0000h
			CX = number of bytes returned
			ES:DX buffer filled (see below)
SeeAlso: AX=002Bh

Format of data buffer:
Offset	Size	Description
 00h	BYTE	mouse type
 01h	BYTE	current language
 02h	BYTE	horizontal sensitivity (00h-64h)
 03h	BYTE	vertical sensitivity (00h-64h)
 04h	BYTE	double-speed threshold (00h-64h)
 05h	BYTE	ballistic curve (01h-04h)
 06h	BYTE	interrupt rate (01h-04h)
 07h	BYTE	cursor override mask
 08h	BYTE	laptop adjustment
 09h	BYTE	memory type (00h-02h)
 0Ah	BYTE	SuperVGA support (00h,01h)
 0Bh	BYTE	rotation angle
 0Ch	BYTE	???
 0Dh	BYTE	primary button (01h-04h)
 0Eh	BYTE	secondary button (01h-04h)
 0Fh	BYTE	click lock enabled (00h,01h)
 10h 324 BYTEs	acceleration profile data (see AX=002Bh)
154h  5 BYTEs	??? (Microsoft driver, but not Logitech)
----------330034-----------------------------
INT 33 - MS MOUSE v8.0+ - GET INITIALIZATION FILE
	AX = 0034h
Return: AX = status (0000h successful)
	ES:DX -> ASCIZ initialization (.INI) file name
----------330035-----------------------------
INT 33 - MS MOUSE v8.10+ - LCD SCREEN LARGE POINTER SUPPORT
	AX = 0035h
	BX = function
	    FFFFh get current settings
		Return: AX = 0000h
			BH = style (see below)
			BL = size (see below)
			CH = threshold
			CL = active flag (00h disabled, 01h enabled)
			DX = delay
	    other
		BH = style (00h normal, 01h reverse, 02h transparent)
		BL = size (00h small "1", 01h medium "1.5", 02h large "2")
		CH = threshold (00h-64h)
		CL = active flag (00h disable size change, 01h enable)
		DX = delay (0000h-0064h)
		Return: AX = 0000h
Note:	not supported by Logitech driver v6.10
SeeAlso: AX=0012h,AX=002Ah
----------330042-----------------------------
INT 33 - PCMOUSE - GET MSMOUSE STORAGE REQUIREMENTS
	AX = 0042h
Return: AX = FFFFh successful
		BX = buffer size in bytes for functions 50h and 52h
	   = 0000h MSMOUSE not installed
	   = 0042h functions 42h, 50h, and 52h not supported
Note:	this function is also supported by the Genius Mouse 9.06 driver
SeeAlso: AX=0015h,AX=0050h,AX=0052h
----------330043-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - CONFIGURE MOUSE???
	AX = 0043h
	CX:BX -> ??? buffer (see below)
	DL = ???
Return: ???
Notes:	also calls routines for INT 33/AX=0053h and INT 33/AX=004Fh
	this function is also supported by the Genius Mouse 9.06 driver

Format of buffer:
Offset	Size	Description
 00h	WORD	I/O port address
 02h	BYTE	???
 03h	BYTE	interrupt number
 04h	BYTE	interrupt mask for interrupt controller
 05h  5 BYTEs	???
----------330044CXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - TOGGLE ???
	AX = 0044h
	CX = CDEFh
Return: AX = new state of ???
Note:	this function is also supported by the Genius Mouse 9.06 driver
SeeAlso: AX=0045h
----------330045CXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - TOGGLE ???
	AX = 0045h
	CX = CDEFh
Return: AX = new state of ???
Note:	this function is also supported by the Genius Mouse 9.06 driver
SeeAlso: AX=0044h
----------330047-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - SET BUTTON ASSIGNMENTS
	AX = 0047h
	ES:BX -> button assignments (3 bytes, combinations of "L", "M", "R")
Return: ???
Note:	also supported by Genius Mouse 9.06 driver
SeeAlso: AX=0067h
----------330048BXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - GET ???
	AX = 0048h
	BX = CDEFh
Return: CX = ???
	BH = ???
	BL = ??? (if 50h, driver is using PS/2 pointing device BIOS interface)
Note:	also supported by Genius Mouse 9.06 driver
----------33004B-----------------------------
INT 33 - Z-NIX MOUSE DRIVER v7.04d - INSTALLATION CHECK
	AX = 004Bh
Return: ES:DI -> signature/description string if installed
Note:	the signature string in v7.04d is
	  "Z-NIX;BUS,AUX,Serial 3-byte and 5-byte Mouse Driver;ZMOUSE;v7.04d"
----------33004CBXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - SET ??? FLAG
	AX = 004Ch
	BX = CDEFh
Note:	also supported by Genius Mouse 9.06
SeeAlso: AX=006Ch
----------33004D-----------------------------
INT 33 - MS MOUSE - RETURN POINTER TO COPYRIGHT STRING
	AX = 004Dh
Return: ES:DI -> copyright message "*** This is Copyright 1983 Microsoft"
Notes:	also supported by Logitech, Kraft, Genius Mouse, and Mouse Systems
	  mouse drivers
	in the Genius Mouse 9.06 driver, the ASCIZ signature "KYE" immediately
	  follows the above copyright message (KYE Corp. manufactures the
	  driver)
SeeAlso: AX=0024h,AX=006Dh
----------33004F-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - ENABLE MOUSE
	AX = 004Fh
Return: nothing
Note:	also supported by Genius Mouse 9.06
SeeAlso: AX=0043h,AX=0053h
----------330050-----------------------------
INT 33 - PCMOUSE - SAVE MSMOUSE STATE
	AX = 0050h
	BX = buffer size (ignored by some driver versions)
	ES:DX -> buffer
Return: AX = FFFFh if successful
Notes:	the buffer must be large enough to hold the entire state, or following
	  data will be overwritten by state data in versions which ignore BX;
	  use INT 33/AX=0042h to get the required size
	this function is also supported by the Genius Mouse 9.06 driver
SeeAlso: AX=0042h,AX=0052h
----------330052-----------------------------
INT 33 - PCMOUSE - RESTORE MSMOUSE STATE
	AX = 0052h
	BX = buffer size (ignored by some driver versions)
	ES:DX -> buffer
Return: AX = FFFFh if successful
Note:	also supported by Genius Mouse 9.06 driver
SeeAlso: AX=0050h
----------330053-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - DISABLE MOUSE
	AX = 0053h
Return: nothing
Note:	also supported by Genius Mouse 9.06
SeeAlso: AX=0043h,AX=004Fh
----------330054CXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - SELECT ULTRARES ACCELERATION LEVEL
	AX = 0054h
	CX = CDEFh
	BX = ??? (NOP if <= 0000h)
Return: ???
Note:	this function is also supported by the Genius Mouse 9.06 driver
SeeAlso: AX=005Ah
----------330055-----------------------------
INT 33 - Kraft Mouse - GET ???
	AX = 0055h
Return: CX = ???
	DX = ???
	ES = ???
----------330058-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - ???
	AX = 0058h
Return: AX = CS of driver
	CX:BX = original INT 33 vector
	DX = ???
Note:	this function is also supported by the Genius Mouse 9.06 driver
----------33005A-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - SET ULTRARES ACCELERATIONS
	AX = 005Ah
	CX = number of WORDs to copy (max 0014h, but not range-checked)
	DX:SI -> buffer containing thresholds??? (CX words)
	DX:BX -> buffer containing acceleration values???
		(9*14h words, only first CX of each 14h used)
	???
Return: CF clear
	???
Note:	this function is also supported by Genius Mouse 9.06
SeeAlso: AX=0054h
----------330061BXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - ???
	AX = 0061h
	BX = CDEFh
Return: CX = ???
Note:	also supported by Genius Mouse 9.06
----------330067-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - GET MOUSE BUTTONS???
	AX = 0067h	     
Return: BL = number of buttons???
Note:	also supported by Genius Mouse 9.06
SeeAlso: AX=0047h
----------33006CBXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - CLEAR ??? FLAG
	AX = 006Ch
	BX = CDEFh
Note:	also supported by Genius Mouse 9.06
SeeAlso: AX=004Ch   
----------33006D-----------------------------
INT 33 - MS MOUSE - GET VERSION STRING
	AX = 006Dh
Return: ES:DI -> Microsoft version number of resident driver (see below)
Notes:	also supported by Logitech, Mouse Systems, Kraft, and Genius mouse
	  drivers
	the Mouse Systems 7.01 and Genius Mouse 9.06 drivers report their
	  Microsoft version as 7.00 even though they do not support any of the
	  functions from 0025h through 002Dh supported by the MS 7.00 driver
	  (the Genius Mouse driver supports function 0026h, but it differs
	  from the Microsoft function)
SeeAlso: AX=0024h,AX=004Dh,AX=266Ch

Format of Microsoft version number:
Offset	Size	Description
 00h	BYTE	major version
 01h	BYTE	minor version (BCD)
----------330070BXABCD-----------------------
INT 33 - Mouse Systems MOUSE DRIVER - POPUP.COM - INSTALLATION CHECK
	AX = 0070h
	BX = ABCDh
Return: AX = ABCDh if installed
	    BX:CX -> data structure (see below)
Notes:	this function is also supported by the Genius Mouse 9.06 driver
	the v7.01 POPUP.COM and menu drivers also check for the signature
	  CDh ABh BAh DCh at offset -2Ch from the interrupt handler
	if POPUP is not loaded, the returned data structure contains the proper
	  signature at offset 00h, but not at offset 08h

Format of data structure:
Offset	Size	Description
 00h	WORD	signature ABCDh
 02h	DWORD	pointer to info structure???
 06h  2 BYTEs	???
 08h	WORD	signature ABCDh

Format of info structure:
Offset	Size	Description
 00h	WORD	driver version
 02h  8 BYTEs	???
 0Ah	WORD	segment of ???
	???
----------330072BXABCD-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - ???
	AX = 0072h
	BX = ABCDh
Return: ???
Note:	this function is also supported by the Genius Mouse 9.06 driver
----------330073BXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - GET BUTTON ASSIGNMENTS
	AX = 0073h
	BX = CDEFh
	ES:DX -> 3-byte buffer for button assignments
Return: CX = number of buttons???
	ES:DX buffer filled (default is "LMR")
Note:	also supported by Genius Mouse 9.06
SeeAlso: AX=0067h
----------33012E-----------------------------
INT 33 - MS MOUSE v8.10+ - ???
	AX = 012Eh
	BL = ???
Return: AX = 0000h
Note:	not supported by Logitech driver v6.10
SeeAlso: AX=002Eh,AX=022Eh
----------33022E-----------------------------
INT 33 - MS MOUSE v8.10+ - ???
	AX = 022Eh
	BL = ???
Return: AX = 0000h
Note:	not supported by Logitech driver v6.10
SeeAlso: AX=002Eh,AX=012Eh
----------33136C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 136Ch
	BX = ???
Return: AX = ???
	BX = ???
----------33146C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - GET/SET ???
	AX = 146Ch
	BL = function
	    00h set ???
		BH = new value (zero/nonzero to clear/set)
	    else get ???
		Return: ???
----------33156C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - GET SIGNATURE AND VERSION STRINGS
	AX = 156Ch
Return: ES:DI -> signature "LOGITECH MOUSE DRIVER"
	ES:SI -> version string, terminated with CRLF
----------33166C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 166Ch
	BL = ???
	    00h ???
	    01h ???
	    other ???
		BH = new value of ???
		Return: AX = FFFFh
----------33176C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 176Ch
	???
Return: ???
----------33186C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 186Ch
	???
Return: ???
----------33196C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 196Ch
	???
Return: ???
----------331A6C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - GET ???
	AX = 1A6Ch
Return: AX = FFFFh
	BX = ???
	CX = ???
SeeAlso: AX=1B6Ch
----------331B6C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - SET ???
	AX = 1B6Ch
	BX = new value for ??? (0000h-0003h)
Return: AX = FFFFh
SeeAlso: AX=1A6Ch
----------331C6C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 1C6Ch
	BX = ???
		<42h ???
		=42h ???
		>42h ???
			ES:DI -> ???
			Return: AX = ???
----------331D6C-----------------------------
INT 33 - LOGITECH MOUSE - GET COMPASS PARAMETER
	AX = 1D6Ch
Return: BX = direction (0=north, 1=south, 2=east, 3=west)
SeeAlso: AX=1E6Ch
----------331E6C-----------------------------
INT 33 - LOGITECH MOUSE - SET COMPASS PARAMETER
	AX = 1E6Ch
	BX = direction (0=north, 1=south, 2=east, 3=west)
SeeAlso: AX=1D6Ch
----------331F6C-----------------------------
INT 33 - LOGITECH MOUSE - GET BALLISTICS INFORMATION
	AX = 1F6Ch
Return: BX = 0=off, 1=on
	CX = 1=low, 2=high
SeeAlso: AX=002Ch,AX=236Ch
----------33206C-----------------------------
INT 33 - LOGITECH MOUSE - SET LEFT OR RIGHT PARAMETER
	AX = 206Ch
	BX = parameter (00h = right, FFh = left)
SeeAlso: AX=216Ch
----------33216C-----------------------------
INT 33 - LOGITECH MOUSE - GET LEFT OR RIGHT PARAMETER
	AX = 216Ch
Return: BX = parameter (00h = right, FFh = left)
SeeAlso: AX=206Ch
----------33226C-----------------------------
INT 33 - LOGITECH MOUSE - REMOVE DRIVER FROM MEMORY
	AX = 226Ch
Note:	this only frees memory; does not restore hooked interrupts
----------33236C-----------------------------
INT 33 - LOGITECH MOUSE - SET BALLISTICS INFORMATION
	AX = 236Ch
	BX = 0=off, 1=on
	CX = 1=low, 2=high
SeeAlso: AX=002Ch,AX=1F6Ch
----------33246C-----------------------------
INT 33 - LOGITECH MOUSE - GET PARAMETERS AND RESET SERIAL MOUSE
	AX = 246Ch
	ES:DX -> parameter table buffer (see below)
Return: AX = FFFFh if driver installed for serial mouse
SeeAlso: AX=0000h,AX=256Ch

Format of parameter table:
Offset	Size	Description
 00h	WORD	baud rate divided by 100  (serial mouse only)
 02h	WORD	emulation		  (serial mouse only)
 04h	WORD	report rate		  (serial mouse only)
 06h	WORD	firmware revision	  (serial mouse only)
 08h	WORD	0			  (serial mouse only)
 0Ah	WORD	port			  (serial mouse only)
 0Ch	WORD	physical buttons
 0Eh	WORD	logical buttons
----------33256CBX00h -----------------------
INT 33 - LOGITECH MOUSE - SET PARAMETERS
	AX = 256Ch
	BX = 00h set baud rate (serial mouse only)
		CX = rate (0=1200, 1=2400, 2=4800, 3=9600)
	   = 01h set emulation (serial mouse only)
		CX = emulation
		    0 = 5 byte packed binary
		    1 = 3 byte packed binary
		    2 = hexadecimal
		    3 = relative bit pad
		    4 = not supported
		    5 = MM Series
		    6 = not supported
		    7 = Microsoft
	   = 02h set report rate (serial mouse only)
		CX = rate (0=10, 1=20, 2=35, 3=50, 4=70, 5=100, 6=150)
	   = 03h set port (serial mouse only)
		CX = port (1, 2)
	   = 04h set mouse logical buttons
		CX = buttons (2, 3)
Return: AX = FFFFh if driver installed for serial mouse
SeeAlso: AX=246Ch,AX=276Ch
----------33266C-----------------------------
INT 33 - LOGITECH MOUSE - GET VERSION???
	AX = 266Ch
Return: BX = 'SS'
	CH = '4'  major version number
	CL = '1'  minor version number
SeeAlso: AX=006Dh
----------33276C-----------------------------
INT 33 - LOGITECH MOUSE - ??? Tries MMSeries, Baud 2400
	AX = 276Ch
SeeAlso: AX=256Ch
----------333000-----------------------------
INT 33 - Smooth Mouse Driver, PrecisePoint - INSTALLATION CHECK
	AX = 3000h
Return: AX = FFFFh if installed
	    BX = version number (BH = major, BL = minor)
Program: SMD is a programmer's library by Andy Hakim which provides a
	  graphics-style mouse cursor in text mode.  PrecisePoint is an
	  SMD-based TSR which replaces the block mouse cursor in text
	  applications.
SeeAlso: AX=0000h,AX=3001h,AX=3003h
----------333001-----------------------------
INT 33 - Smooth Mouse Driver, PrecisePoint - ENABLE SMOOTH MOUSE
	AX = 3001h
Return: AX = status (0000h = disabled, 0001h = enabled)
Note:	SMD remains disabled if running under Desqview or in graphics mode
SeeAlso: AX=0001h,AX=0002h,AX=3002h
----------333002-----------------------------
INT 33 - Smooth Mouse Driver, PrecisePoint - DISABLE SMOOTH MOUSE
	AX = 3002h
Return: AX = status (0000h = disabled, 0001h = enabled)
SeeAlso: AX=0001h,AX=0002h,AX=3000h,AX=3001h
----------333003-----------------------------
INT 33 - Smooth Mouse Driver, PrecisePoint - GET INFORMATION
	AX = 3003h
	BL = data structure selector
	    00h Primary Bitmap (used for 25 line mode)
	    01h Secondary Bitmap (used for 43/50 line modes)
	    02h Sacrifice Character Map
	    03h Program Information
Return: ES:DI -> selected data structure
SeeAlso: AX=3000h

Format of Primary/Secondary Bitmap [SMD_BITMAP_STRUCT]
Offset	Size	Description
 00h	BYTE	vertical size of bitmap (00h - 10h)
 01h	BYTE	horizontal size of bitmap (00h - 10h)
 02h	BYTE	vertical hotspot position (00h - 10h)
 03h	BYTE	horizontal hotspot position (00h - 10h)
 04h 16 WORDs	cursor bitmap data
 14h 16 WORDs	screen bitmap data
 
Format of Sacrifice Character Map [SMD_SMAP_STRUCT]
Offset	Size	Description
 00h	BYTE	bytes are character values (00h-FFh) used in place of the
 01h	BYTE	actual character for the corresponding position on the screen
 02h	BYTE	     +--------------+	  occupied by part or all of the mouse
 03h	BYTE	     | 0h | 1h | 2h |	  cursor
 04h	BYTE	     |----+----+----|
 05h	BYTE	     | 3h | 4h | 5h |
 06h	BYTE	     |----+----+----|
 07h	BYTE	     | 6h | 7h | 8h |
 08h	BYTE	     +--------------+

Format of Program Information [SMD_INFO_STRUCT]
Offset	Size	Description
 00h	WORD	segment of old interrupt 33h handler
 02h	WORD	offset of old interrupt 33h handler
 04h	WORD	PSP of SMD
 06h	BYTE	ENABLE/DISABLE manual setting status
 07h	BYTE	ENABLE/DISABLE internal usage status
----------33---------------------------------
INT 33 - Smooth Mouse Driver, PrecisePoint - RESERVED FUTURE EXPANSION
	AX = 3004
SeeAlso: AX=3000h
----------33---------------------------------
INT 33 - Smooth Mouse Driver, PrecisePoint - RESERVED FUTURE EXPANSION
	AX = 3005
SeeAlso: AX=3000h
----------334F00-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - GET ???
	AX = 4F00h
Return: AX = 004Fh if supported
	BX = ???
	ES:DI -> ???
SeeAlso: AX=4F01h
----------334F01-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 4F01h
	ES = ???
Return: AX = 004Fh if supported
	ES:DI -> ???
SeeAlso: AX=4F00h
----------34---------------------------------
INT 34 - FLOATING POINT EMULATION - OPCODE D8h
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of D8h
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 35,INT 3E
----------35---------------------------------
INT 35 - FLOATING POINT EMULATION - OPCODE D9h
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of D9h
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 34,INT 36
----------36---------------------------------
INT 36 - FLOATING POINT EMULATION - OPCODE DAh
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of DAh
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 35,INT 37
----------37---------------------------------
INT 37 - FLOATING POINT EMULATION - OPCODE DBh
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of DBh
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 36,INT 38
----------38---------------------------------
INT 38 - FLOATING POINT EMULATION - OPCODE DCh
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of DCh
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 37,INT 39
----------3802-------------------------------
INT 38 - PC-MOS/386 v3.0 - GET MOS INTERNAL DATA POINTER
	AH = 02h
Return: AX = 0000h
	ES:BX -> ??? internal data structure
Program: PC-MOS/386 is a multitasking/multiuser MSDOS-compatible operating
	  system by Software Links, Inc.
SeeAlso: AH=04h,AH=10h,INT 21/AX=3000h,INT D4
----------3804-------------------------------
INT 38 - PC-MOS/386 v3.0 - GET TASK CONTROL BLOCK
	AH = 04h
Return: ES = segment of Task Control Block (TCB) (see below)
SeeAlso: AH=02h,INT D4

Format of Task Control Block:
Offset	Size	Description
 00h  2 BYTEs	signature "HT"
 02h 23 BYTEs	???
 19h	BYTE	task time slice
 1Ah  7 BYTEs	???
 21h 11 BYTEs	name of currently executing task
 2Ch 79 BYTEs	???
 7Bh  4 BYTEs	user name
 7Fh	BYTE	current output class
 80h  7 BYTEs	protection access rights, 2 bits per class (writeable!)
	???
----------380703-----------------------------
INT 38 - PC-MOS/386 v3.0 - WAIT FOR KEYPRESS OR TIMEOUT
	AX = 0703h
	CX = timeout (in seconds???)
Return: AH bit 0 set if key pressed, clear otherwise
SeeAlso: INT 16/AH=00h,INT D4
----------3810-------------------------------
INT 38 - PC-MOS/386 v3.0 - ENTER NATIVE 386 EXECUTION MODE
	AH = 10h
	CX = NCA (???) length in bytes (at least 1024???)
	DX = NCA segment
Return: in protected mode
	all segment registers converted to appropriate selectors
Note:	MSDOS calls are available in protected mode
SeeAlso: AH=11h,AH=12h,INT 2F/AX=1687h,INT 67/AX=DE0Ch,INT D4
----------3811-------------------------------
INT 38 - PC-MOS/386 v3.0 - ALLOCATE NATIVE MODE MEMORY BLOCK
	AH = 11h
	EBX = block length
Return: ES = selector for allocated block
SeeAlso: AH=10h,AH=12h,INT D4
----------3812-------------------------------
INT 38 - PC-MOS/386 v3.0 - FREE NATIVE MODE MEMORY BLOCK
	AH = 12h
	ES = selector for block to free
SeeAlso: AH=10h,AH=11h,INT D4
----------39---------------------------------
INT 39 - FLOATING POINT EMULATION - OPCODE DDh
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of DDh
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 38,INT 3A
----------3A---------------------------------
INT 3A - FLOATING POINT EMULATION - OPCODE DEh
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of DEh
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 39,INT 3B
----------3B---------------------------------
INT 3B - FLOATING POINT EMULATION - OPCODE DFh
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of DFh
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 3A,INT 3C
----------3C---------------------------------
INT 3C - FLOATING POINT EMULATION - INSTRUCTIONS WITH SEGMENT OVERRIDE
Notes:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
	the generated code is  CD 3C xy mm ....
	  where xy is a modified ESC instruction and mm is the modR/M byte.
	  The xy byte appears to be encoded as
		s s 0 1 1 x x x	  or	s s 0 0 0 x x x
	  where "ss" specifies the segment override:
		00 -> DS:
		01 -> SS:
		10 -> CS:
		11 -> ES:
SeeAlso: INT 3B,INT 3D
----------3D---------------------------------
INT 3D - FLOATING POINT EMULATION - STANDALONE FWAIT
Notes:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
	this vector is modified but not restored by Direct Access v4.0, and
	  may be left dangling by other programs written with the same version
	  of compiled BASIC
SeeAlso: INT 3C,INT 3E
----------3E---------------------------------
INT 3E - FLOATING POINT EMULATION - Borland LANGUAGES "SHORTCUT" CALL
Notes:	the two bytes following the INT 3E instruction are the subcode and
	  a NOP (90h), except for subcodes DCh and DEh, where the second byte
	  is a register count (01h-08h)
	this vector is modified but not restored by Direct Access v4.0, and
	  may be left dangling by other programs written with the same version
	  of compiled BASIC
SeeAlso: INT 3D

Subcode		Function
 DCh	load 8086 stack with 8087 registers; overwrites the 10*N bytes at the
	  top of the stack prior to the INT 3E with the 8087 register contents
 DEh	load 8087 registers from top of 8086 stack; ST0 is furthest from top
	  of 8086 stack
 E0h	round TOS and R1 to single precision, compare, pop twice
	  returns AX=8087 status word, FLAGS=8087 condition bits
 E2h	round TOS and R1 to double precision, compare, pop twice
	  returns AX=8087 status word, FLAGS=8087 condition bits
	Note: buggy in TPas5.5, because it sets the 8087 precision control
	  field to the undocumented value 01h; this results in actually
	  rounding to single precision
 E4h	compare TOS/R1 with two POP's
	  returns FLAGS=8087 condition bits
 E6h	compare TOS/R1 with POP
	  returns FLAGS=8087 condition bits
 E8h	FTST (check TOS value)
	  returns FLAGS=8087 condition bits
 EAh	FXAM (check TOS value)
	  returns AX=8087 status word
 ECh	sine(ST0)
 EEh	cosine(ST0)
 F0h	tangent(ST0)
 F2h	arctangent(ST0)
 F4h	ST0 = ln(ST0)
 F6h	ST0 = log2(ST0)
 F8h	ST0 = log10(ST0)
 FAh	ST0 = e**ST0
 FCh	ST0 = 2**ST0
 FEh	ST0 = 10**ST0
----------3F---------------------------------
INT 3F - Overlay manager interrupt (Microsoft LINK.EXE, Borland TLINK VROOMM)
Notes:	INT 3F is the default, and may be overridden while linking
	this vector is modified but not restored by Direct Access v4.0, and
	  may be left dangling by other programs written with the same version
	  of compiled BASIC
SeeAlso: INT FE"OVERLAY"
----------3F---------------------------------
INT 3F - Microsoft Dynamic Link Library manager
SeeAlso: INT 21/AH=4Bh
----------40---------------------------------
INT 40 - DISKETTE - ROM BIOS DISKETTE HANDLER RELOCATED BY HARD DISK BIOS
SeeAlso: INT 13,INT 63
----------40---------------------------------
INT 40 - Z100 - Master 8259 - Parity error or S100 error
SeeAlso: INT 41"Z100",INT FF"Z100"
----------40---------------------------------
INT 40 - Acorn BBC Master 512 - "OSFIND" - OPEN FILE
	AL = operation
	    00h close file
	    40h open file for reading
	    80h open file for writing
	    C0h open file for random access
	DS:BX -> CR-terminated filename
Return: AL = file handle (00h if file closed or could not be opened)
Note:	the Acorn BBC Master 512 is an 80186-based add-on board for the
	  6502-based Master 128 which uses the original CPU as an I/O processor
SeeAlso: INT 41"Acorn",INT 42"Acorn",INT 43"Acorn",INT 44"Acorn",INT 4C"Acorn"
----------41---------------------------------
INT 41 - SYSTEM DATA - HARD DISK 0 PARAMETER TABLE
Note:	the default parameter table array is located at F000h:E401h in 100%
	  compatible BIOSes; the pointer may be overridden by the hard disk
	  controller's BIOS to support drive formats unknown to the ROM BIOS
SeeAlso: INT 13/AH=09h,INT 1E,INT 46

Format of fixed disk parameters:
Offset	Size	Description
 00h	WORD	number of cylinders
 02h	BYTE	number of heads
 03h	WORD	starting reduced write current cylinder (XT only, 0 for others)
 05h	WORD	starting write precompensation cylinder number
 07h	BYTE	maximum ECC burst length (XT only)
 08h	BYTE	control byte
		   bits 0-2: drive option (XT only, 0 for others)
		   bit 3:    set if more than 8 heads (AT and later only)
		   bit 4:    always 0
		   bit 5:    set if manufacturer's defect map on max cylinder+1
			     (AT and later only)
		   bit 6:    disable ECC retries
		   bit 7:    disable access retries
 09h	BYTE	standard timeout (XT only, 0 for others)
 0Ah	BYTE	formatting timeout (XT only, 0 for others)
 0Bh	BYTE	timeout for checking drive (XT only, 0 for others)
 0Ch	WORD	cylinder number of landing zone (AT and later only)
 0Eh	BYTE	number of sectors per track (AT and later only)
 0Fh	BYTE	reserved
----------41---------------------------------
INT 41 - Z100 - Master 8259 - Processor Swap
SeeAlso: INT 40"Z100",INT 42"Z100"
----------41---------------------------------
INT 41 - Acorn BBC Master 512 - "OSGBPB" - MULTI-BYTE GET/PUT
	AL = function
	    01h put bytes sequentially
	    02h put bytes, ignoring sequential pointer
	    03h get bytes sequentially
	    04h get bytes, ignoring sequential pointer
	    05h get media title and boot option
	    06h get current device and directory
	    07h get current library and device
	    08h search directory
	DS:BX -> control block (see below)
Return: CF clear if successful
	CF set on error
	AL = 00h if operation attempted
	AL unchanged if unsupported function
SeeAlso: INT 40"Acorn",INT 42"Acorn",INT 43"Acorn"

Format of control block:
Offset	Size	Description
 00h	BYTE	file handle
 01h	DWORD	pointer to data in either I/O processor or Tube processor
 05h	DWORD	number of bytes to be transferred
 09h	DWORD	transfer address
----------4112-------------------------------
INT 41 P - MS Windows debugging kernel - "OutputDebugString"
	AH = 12h
	???
Return: ???
SeeAlso: AH=50h
----------4150-------------------------------
INT 41 P - MS Windows debugging kernel - "DefineDebugSegment"
	AH = 50h
	???
Return: ???
SeeAlso: AH=12h
----------42---------------------------------
INT 42 - VIDEO - RELOCATED DEFAULT INT 10 VIDEO SERVICES (EGA,VGA)
SeeAlso: INT 10
Note:	not used by PS/2 built-in VGA or XGA
----------42---------------------------------
INT 42 - Z100 - Master 8259 - Timer
SeeAlso: INT 41"Z100",INT 43"Z100"
----------42---------------------------------
INT 42 - Acorn BBS Master 512 - "OSBPUT" - WRITE SINGLE BYTE TO FILE
	AL = byte to be written
	BH = file handle
Return: flags destroyed
SeeAlso: INT 40"Acorn",INT 41"Acorn",INT 43"Acorn",INT 47"Acorn",INT 49"Acorn"
----------43---------------------------------
INT 43 - VIDEO DATA - CHARACTER TABLE (EGA,MCGA,VGA)
   points at graphics data for characters 00h-7Fh of the current font
SeeAlso: INT 1F,INT 44"VIDEO"
----------43---------------------------------
INT 43 - Z100 - Master 8259 - Slave 8259 input
Note:	slave runs in special fully nested mode
SeeAlso: INT 42"Z100",INT 44"Z100"
----------43---------------------------------
INT 43 - Acorn BBC Master 512 - "OSBGET" - READ SINGLE BYTE FROM FILE
	BH = file handle
Return: CF clear if successful
	    AL = byte read from file
	CF set on error
SeeAlso: INT 40"Acorn",INT 41"Acorn",INT 42"Acorn",INT 46"Acorn"
----------44---------------------------------
INT 44 - VIDEO DATA - ROM BIOS CHARACTER FONT, CHARACTERS 00h-7Fh (PCjr)
   points at graphics data for current character font
SeeAlso: INT 1F,INT 43"VIDEO"
----------44---------------------------------
INT 44 - Novell NetWare - HIGH-LEVEL LANGUAGE API
----------44---------------------------------
INT 44 - IBM 3270-PC High Level Language API
	DS:SI -> parameter control block
----------44---------------------------------
INT 44 - Z100 - Master 8259 - Serial A
SeeAlso: INT 43"Z100",INT 45"Z100"
----------44---------------------------------
INT 44 - Acorn BBC Master 512 - "OSARGS" - GET/SET FILE PARAMS FOR OPEN FILE
	AH = 00h
	    AL = function
		00h get current filing system
			Return: AL = filing system (see below)
		01h get address of commandline tail
			Return: BX buffer filled with address of command tail
					in I/O processor address space
					(use INT 4A/AL=05h to retrieve)
		FFh flush all files onto secondary storage
	AH = file handle
	    AL = function
		00h get sequential pointer for file
		01h set sequential pointer for file
		02h get length of file
	BX -> 4-byte data buffer
Return: BX buffer updated if appropriate
Note:	the commandline tail is terminated with a carriage return (0Dh)
SeeAlso: INT 40"Acorn",INT 41"Acorn",INT 45"Acorn",INT 4A"Acorn"

Values for filing system:
 00h none
 01h 1200 bps cassette
 02h 300 bps cassette
 03h ROM FS
 04h DFS
 05h ANFS/NFS
 06h TFS
 08h ADFS
----------45---------------------------------
INT 45 - Z100 - Master 8259 - Serial B
SeeAlso: INT 44"Z100",INT 46"Z100"
----------45---------------------------------
INT 45 - Acorn BBC Master 512 - "OSFILE" - READ/WRITE FILE OR DIRECTORY INFO
	AL = function
	    00h save block of memory as file
	    01h update directory entry for existing file
	    02h set load address for existing file
	    03h set execution address for existing file
	    04h set attributes for existing file
	    05h read directory
	    06h delete file
	    FFh load file
	DS:BX -> control block (see below)
Return: FLAGS destroyed
	AL = file type
	    00h not found
	    01h file found
	    02h directory found
	    FFh	protected file
SeeAlso: INT 40"Acorn",INT 41"Acorn",INT 44"Acorn",INT 46"Acorn"

Format of control block:
Offset	Size	Description
 00h	WORD	address of CR-terminated filename
 02h	DWORD	load address of file
 06h	DWORD	execution address of file
 0Ah	DWORD	start address of data to save
 0Eh	DWORD	end address of data to save, or file attributes
		file attributes in low byte:
		    bit 0: no owner read access
		    bit 1: no owner write access
		    bit 2: not executable by owner
		    bit 3: not deletable by owner
		    bit 4: no public read access
		    bit 5: no public write access
		    bit 6: not executable with public access
		    bit 7: not deletable with public access
		other three bytes are filing-system specific file attributes
----------46---------------------------------
INT 46 - SYSTEM DATA - HARD DISK 1 DRIVE PARAMETER TABLE
SeeAlso: INT 13/AH=09h,INT 41
----------46---------------------------------
INT 46 - Z100 - Master 8259 - Keyboard, Retrace, and Light Pen
SeeAlso: INT 45"Z100",INT 47"Z100"
----------46---------------------------------
INT 46 - Acorn BBC Master 512 - "OSRDCH" - GET CHARACTER FROM CUR INPUT STREAM
Return: CF clear if successful
	    AL = character read
	CF set on error
	    AL = error code
SeeAlso: INT 40"Acorn",INT 43"Acorn",INT 47"Acorn",INT 49"Acorn"
----------47---------------------------------
INT 47 - Z100 - Master 8259 - Printer
SeeAlso: INT 46"Z100",INT 48"Z100"
----------47---------------------------------
INT 47 - Acorn BBC Master 512 - "OSWRCH" - WRITE CHARACTER TO CUR OUTPUT STREAM
	AL = character to be written
Return: FLAGS destroyed
SeeAlso: INT 40"Acorn",INT 46"Acorn",INT 49"Acorn"
----------478000-----------------------------
INT 47 - SQL Base - DATABASE ENGINE API
	AX = 8000h
	DS:BX -> parameter block, first word is function number
Note:	SQL Base is a network-oriented database engine by Gupta Technologies

Values for function number:
 01h	"SQLFINI" initalialize application's use of the database
 02h	"SQLFDON" application is done using the database
 03h	"SQLFCON" connect to a cursor/database
 04h	"SQLFDIS" disconnect from a cursor/database
 05h	"SQLFCOM" compile a SQL command
 06h	"SQLFEXE" execute a SQL command
 07h	"SQLFCEX" compile and execute a SQL command
 08h	"SQLFCMT" commit a transaction to the database
 09h	"SQLFDES" describe the items of a SELECT statement
 0Ah	"SQLFGFI" get fetch information
 0Bh	"SQLFFBK" fetch previous result row from SELECT statement
 0Ch	"SQLFFET" fetch next result row from SELECT statement
 0Dh	"SQLFEFB" enable fetch backwards
 0Eh	"SQLFPRS" position in result set
 0Fh	"SQLFURS" undo result set
 10h	"SQLFNBV" get number of bind variables
 11h	"SQLFBND" bind data variables
 12h	"SQLFBNN" bind numerics
 13h	"SQLFBLN" bind long number
 14h	"SQLFBLD" bind long data variables
 15h	"SQLFSRS" start restriction set processing
 16h	"SQLFRRS" restart restriction set processing
 17h	"SQLFCRS" close restriction set
 18h	"SQLFDRS" drop restriction set
 19h	"SQLFARF" apply Roll Forward journal
 1Ah	"SQLFERF" end Roll Forward journal
 1Bh	"SQLFSRF" start Roll Forward journal
 1Ch	"SQLFSTO" store a compiled SQL command
 1Dh	"SQLFRET" retrieve a compiled SQL command
 1Eh	"SQLFDST" drop a stored command
 1Fh	"SQLFCTY" get command type
 20h	"SQLFEPO" get error position
 21h	"SQLFGNR" get number of rows
 22h	"SQLFNSI" get number of select items
 23h	"SQLFRBF" get Roll Back flag
 24h	"SQLFRCD" get return code
 25h	"SQLFROW" get number of ROWs
 26h	"SQLFSCN" set cursor name
 27h	"SQLFSIL" set isolation level
 28h	"SQLFSLP" set log parameters
 29h	"SQLFSSB" set select buffer
 2Ah	"SQLFSSS" set sort space
 2Bh	"SQLFRLO" read long
 2Ch	"SQLFWLO" write long
 2Dh	"SQLFLSK" long seek
 2Eh	"SQLFGLS" get long size
 2Fh	"SQLFELO" end long operation
 30h	"SQLFRBK" roll back a transaction from the database
 31h	"SQLFERR" error message
 32h	"SQLFCPY" copy
 33h	"SQLFR01" reserved
 34h	"SQLFSYS" system
 35h	"SQLFSTA" statistics
 36h	"SQLFR02" reserved
 37h	"SQLFXAD" extra add
 38h	"SQLFXCN" extra character to number
 39h	"SQLFXDA" extra date add
 3Ah	"SQLFXDP" extra date picture
 3Bh	"SQLFXDV" extra divide
 3Ch	"SQLFXML" extra multiply
 3Dh	"SQLFXNP" extra number picture
 3Eh	"SQLFXPD" extra picture date
 3Fh	"SQLFXSB" extra subtract
 40h	"SQLFINS" install database
 41h	"SQLFDIN" deinstall database
 42h	"SQLFDIR" directory of databases
 43h	"SQLFTIO" timeout
 44h	"SQLFFQN" get fully qualified column name
 45h	"SQLFEXP" explain execution plan
 46h	"SQLFFER" get full error
 47h	"SQLFBKP" begin online backup
 48h	"SQLFRDC" read backup data chunk
 49h	"SQLFEBK" end backup
 4Ah	"SQLFRES" begin restore from backup
 4Bh	"SQLFWDC" write backup data chunk for restore
 4Ch	"SQLFRRD" recover restored database to consistent state
 4Dh	"SQLFERS" end restore
 4Eh	"SQLFNRR" return number of result set rows
 4Fh	"SQLFSTR" start restriction mode
 50h	"SQLFSPR" stop restriction mode
 51h	"SQLFCNC" connect 2
 52h	"SQLFCNR" connect with no recovery
 53h	"SQLFOMS" set output message size
 54h	"SQLFIMS" set input message size
 55h	"SQLFSCP" set cache pages
 56h	"SQLFDSC" describe items of a SELECT statement (external)
 57h	"SQLFLAB" get label info for items in SELECT statement
 58h	"SQLFCBV" clear bind variables
 59h	"SQLFGET" get database information
 5Ah	"SQLFSET" set database information
 5Bh	"SQLFTEC" translate error code
----------478001-----------------------------
INT 47 - SQL Base - GET VERSION NUMBER
	AX = 8001h
Return: ???
Note:	SQL Base is a network-oriented database engine by Gupta Technologies
----------48---------------------------------
INT 48 - KEYBOARD - CORDLESS KEYBOARD TRANSLATION (PCjr)
SeeAlso: INT 49"PCjr"
----------48---------------------------------
INT 48 - Z100 - Slave 8259 - S100 vectored line 0
SeeAlso: INT 47"Z100",INT 49"Z100"
----------48---------------------------------
INT 48 - Watstar PC Network data pointer 1
SeeAlso: INT 49"Watstar"
----------48---------------------------------
INT 48 - Acorn BBC Master 512 - "OSNEWL" - SEND NEWLINE TO OUTPUT STREAM
Return: FLAGS destroyed
Note:	writes a carriage return (0Dh) followed by a linefeed (0Ah)
SeeAlso: INT 40"Acorn",INT 47"Acorn",INT 49"Acorn"
----------49---------------------------------
INT 49 - SYSTEM DATA - NON-KEYBOARD SCAN-CODE TRANSLATION TABLE (PCjr)
SeeAlso: INT 48"PCjr"

Format of translation table:
Offset	Size	Description
 00h	BYTE	number of nonkeyboard scancodes in the table
 01h  N WORDs	high byte 00h (NUL) byte scancode with low order byte
		representing the scancode mapped values relative to their
		input values within the range of 56h through 7Eh
----------49---------------------------------
INT 49 - Z100 - Slave 8259 - S100 vectored line 1
SeeAlso: INT 48"Z100",INT 4A"Z100"
----------49---------------------------------
INT 49 - Texas Instruments PC - VIDEO I/O???
	apparently provides direct video display on the TI Professional PC
----------49---------------------------------
INT 49 - Watstar PC Network data pointer 2
SeeAlso: INT 49"Watstar"
----------49---------------------------------
INT 49 - Acorn BBC Master 512 - "OSASCI" - WRITE CHARACTER TO CUR OUTPUT STREAM
	AL = character to be written
Return: FLAGS destroyed
Note:	converts carriage return (0Dh) into CRLF sequence (0Dh 0Ah)
SeeAlso: INT 40"Acorn",INT 46"Acorn",INT 47"Acorn",INT 48"Acorn"
----------490001-----------------------------
INT 49 - MAGic v1.16+ - TURN ON MAGNIFICATION
	AX = 0001h
Return: AX = status
	    0000h cannot magnify current video mode
	    0002h magnified (text mode)
	    0003h magnified (graphics mode)
	    FFFDh function works only in magnified mode
	    FFFFh MAGic busy, retry later
	BX,CX,DX destroyed
Notes:	MAGic (MAGnification In Color) is a TSR by Microsystems Software, Inc.
	  providing 2x2 text and graphics magnification on VGA, XGA, and SVGA
	INT 49 is the default, but may be overridden on the commandline.  The
	  actual interrupt in use may be found by searching for the signature
	  "MAGic" or "xMAGic" (for the deluxe version) immediately preceding
	  the interrupt handler (this is also the installation check).	MAGic
	  uses CodeRunneR, which places the signature "RT" at offset 0000h in
	  the interrupt handler's segment, followed by MAGic's TSR ID of
	  "VMAG".
SeeAlso: AX=0001h,AX=0003h,AX=0004h,AX=0008h
----------490002-----------------------------
INT 49 - MAGic v1.16+ - TURN OFF MAGNIFICATION
	AX = 0002h
Return: AX = status (see AX=0001h)
	BX,CX,DX destroyed
SeeAlso: AX=0001h
----------490003-----------------------------
INT 49 - MAGic v1.16+ - SHIFT MAGNIFIED WINDOW TO INCLUDE SPECIFIED LOCATION
	AX = 0003h
	BX = vertical position (character row [text] or pixel row [graphics])
	DX = horizontal position (char column [text] or 8-pixel units [gr])
Return: AX = status
	    0000h successful
	    FFFFh MAGic busy, retry later
	BX,CX,DX destroyed
Note:	window is not moved if the position is inside the current window
SeeAlso: AX=0001h,AX=0004h,AX=0005h
----------490004-----------------------------
INT 49 - MAGic v1.16+ - REPOSITION MAGNIFIED WINDOW
	AX = 0004h
	BX = vertical position of upper left corner
	DX = horizontal position
Return: AX = status (see AX=0003h)
	BX,CX,DX destroyed
SeeAlso: AX=0001h,AX=0003h,AX=0005h
----------490005-----------------------------
INT 49 - MAGic v1.16+ - GET POSITION OF MAGNIFIED WINDOW
	AX = 0005h
Return: AX = status
	    0000h successful
		BX = vertical position (char row or pixel row)
		DX = horizontal position (char column or 8-pixel units)
	    FFFFh MAGic busy, retry later
		BX,DX destroyed
	CX destroyed
SeeAlso: AX=0001h,AX=0003h,AX=0004h,AX=0006h,AX=0007h
----------490006-----------------------------
INT 49 - MAGic v1.16+ - GET SIZE OF FULL SCREEN
	AX = 0006h
Return: AX = status
	    0000h successful
		BX = vertical size (char rows or pixel rows)
		DX = horizontal size (char cols or 8-pixel units)
	    FFFFh MAGic busy, retry later
		BX,DX destroyed
	CX destroyed
SeeAlso: AX=0001h,AX=0005h,AX=0007h
----------490007-----------------------------
INT 49 - MAGic v1.16+ - GET SIZE OF MAGNIFICATION WINDOW
	AX = 0007h
Return: AX = status
	    0000h successful
		BX = vertical size (char rows or pixel rows)
		DX = horizontal size (char cols or 8-pixel units)
	    FFFEh invalid function
	    FFFFh MAGic busy, retry later
		BX,DX destroyed
	CX destroyed
BUG:	in v1.16 and v1.17, this function is not recognized as valid, but
	  AX=0000h is accepted and will branch into hyperspace
SeeAlso: AX=0001h,AX=0006h
----------490008-----------------------------
INT 49 - MAGic v1.23+ - SET TEXT MODE MAGNIFICATION SIZE
	AX = 0008h
	BX = scaling factor (01h=1.4 times, 02h, 04h, 06h, 08h, 09h=12 times)
Return: AX = status
	    0000h successful
	    FFFBh scaling factor only available in MAGic Deluxe
	    FFFCh already in magnified state, can't set size
Notes:	this call specifies the amount a subsequent call to AX=0001h should
	  magnify the display
	scaling factors greater than 2 are only available in MAGic Deluxe
SeeAlso: AX=0001h
----------4A---------------------------------
INT 4A C - SYSTEM - USER ALARM HANDLER
Desc:	This interrupt is invoked by the BIOS when a real-time clock alarm
	  occurs; an application may use it to perform an action at a
	  predetermined time.
Note:	this interrupt is called from within a hardware interrupt handler,
	  so all usual precautions against reentering DOS must be taken
SeeAlso: INT 1A/AH=06h
----------4A---------------------------------
INT 4A - Z100 - Slave 8259 - S100 vectored line 2
SeeAlso: INT 49"Z100",INT 4B"Z100"
----------4A---------------------------------
INT 4A - Acorn BBC Master 512 - "OSWORD" - MISC FUNCTIONS USING CONTROL BLOCK
	AL = function code
	    FAh transfer data between 80186 and 65C12 I/O processor
	DS:BX -> control block (see below)
Return: FLAGS destroyed
	control block updated
Note:	there are more functions than are listed here, but details are not
	  available
SeeAlso: INT 40"Acorn",INT 4B"Acorn",INT 4C"Acorn"

Format of control block for function FAh:
Offset	Size	Description
 00h	BYTE	number of parameters sent to I/O processor (0Dh,0Eh)
 01h	BYTE	number of parameters read from I/O processor (01h)
 02h	DWORD	I/O processor address
 06h	DWORD	80186 segment:offset address
 0Ah	WORD	number of bytes to transfer
 0Ch	BYTE	operation type
		00h write to 65C12 at 24 us/byte
		01h read from 65C12 at 24 us/byte
		02h write to 65C12 at 26 us/word
		03h read from 65C12 at 26 us/word
		04h write to 65C12 at 10 us/byte using 256-byte blocks
		05h read from 65C12 at 10 us/byte using 256-byte blocks
 0Dh	BYTE	65C12 memory access control (only used if offset 00h = 0Eh)
		bit 7: unused
		bit 6: always use main screen memory if I/O addr 3000h-7FFFh
			(overrides bit 5)
		bit 5: use shadow screen memory if screen address specified
		bit 4: use current ROM rather than ROM selected by bits 3-0
			(only if I/O address between 8000h and BFFFh)
		bits 3-0: paged ROM number
----------4B---------------------------------
INT 4B - Z100 - Slave 8259 - S100 vectored line 3
SeeAlso: INT 4A"Z100",INT 4C"Z100"
----------4B---------------------------------
INT 4B - Common Access Method SCSI interface (draft revision 1.9)
	ES:DI -> CAM Control Block (see INT 4F/AX=8100h)
Notes:	the CAM committee moved the interface to INT 4F after revision 1.9
	  to avoid conflicting with the IBM SCSI interface and the Virtual
	  DMA specification
	the installation check for the driver is the string "SCSI_CAM" eight
	  bytes past the INT 4Bh handler
	it is not known whether any drivers actually implemented this
	  interface on INT 4B instead of INT 4F
SeeAlso: INT 4F/AX=8100h
----------4B---------------------------------
INT 4B - Acorn BBC Master 512 - "OSBYTE" - MISC FUNCTIONS USING REGISTER PARAMS
	AL = function code
	BL = first parameter
	BH = second parameter (if needed)
Return: BL = first return parameter
	BH = second return parameter
	CF depends on function
SeeAlso: INT 40"Acorn",INT 4A"Acorn",INT 4C"Acorn"
----------4B80-------------------------------
INT 4B - IBM SCSI interface
	AH = 80h
	details not yet available
----------4B8102DX0000-----------------------
INT 4B - Virtual DMA Specification (VDS) - GET VERSION
	AX = 8102h
	DX = 0000h
Return: CF clear if successful
	    AH = major version number
	    AL = minor version number
	    BX = product number
		0000h for Quadtel's QMAPS and Hewlett-Packard's HPMM.SYS
		0001h for Microsoft's EMM386.EXE
		4560h ("E`") for Qualitas' 386MAX
		4D43h ("MC") for V Communication's Memory Commander
		5145h ("QE") for Quarterdeck's QEMM-386
	    CX = product revision number
		always 0000h for QMAPS and HPMM.SYS
		always 0001h for Microsoft's EMM386.EXE v4.20-4.41
	    SI:DI = maximum DMA buffer size
	    DX = flags
		bit 0: PC/XT bus (DMA in first megabyte only)
		    1: physical buffer/remap region in first megabyte
		    2: automatic remap enabled
		    3: all memory is physically contiguous
		 4-15: reserved (zero)
	CF set on error
	    AL = error code (see below)
Note:	bit 5 of 0040h:007Bh is supposed to be set if VDS is supported; this is
	  apparently not always the case
SeeAlso: INT 31

Values for error code:
 01h	region not in contiguous memory
 02h	region crossed a physical alignment boundary
 03h	unable to lock pages
 04h	no buffer available
 05h	region too large for buffer
 06h	buffer currently in use
 07h	invalid memory region
 08h	region was not locked
 09h	number of physical pages greater than table length
 0Ah	invalid buffer ID
 0Bh	copy out of buffer range
 0Ch	invalid DMA channel number
 0Dh	disable count overflow
 0Eh	disable count underflow
 0Fh	function not supported
 10h	reserved flag bits set in DX

Format of DMA descriptor structure (DDS):
Offset	Size	Description
 00h	DWORD	region size
 04h	DWORD	offset
 08h	WORD	segment/selector
 0Ah	WORD	buffer ID
 0Ch	DWORD	physical address

Format of Extended DMA descriptor structure (EDDS):
Offset	Size	Description
 00h	DWORD	region size
 04h	DWORD	offset
 08h	WORD	segment/selector
 0Ah	WORD	reserved
 0Ch	WORD	number available
 0Eh	WORD	number used
 10h	DWORD	region 0 physical address
 14h	DWORD	region 0 size in bytes
 18h	DWORD	region 1 physical address
 1Ch	DWORD	region 1 size in bytes
	...

Format of Extended DMA descriptor structure (EDDS) with page table entries:
Offset	Size	Description
 00h	DWORD	region size
 04h	DWORD	offset
 08h	WORD	segment/selector
 0Ah	WORD	reserved
 0Ch	WORD	number available
 0Eh	WORD	number used
 10h	DWORD	page table entry 0 (same as 80386 page table entry)
 14h	DWORD	page table entry 1
	...
Note:	bits 1-11 of the page table entries should be zero; bit 0 set if page
	  is present and locked
----------4B8103-----------------------------
INT 4B - Virtual DMA Specification - LOCK DMA REGION
	AX = 8103h
	DX = flags
	    bit 0: reserved (zero)
		1: data should be copied into buffer (ignored if bit 2 set)
		2: buffer should not be allocated if region noncontiguous or
		   crosses physical alignment boundary specified by bits 4-5
		3: don't attempt automatic remap
		4: region must not cross 64K physical alignment boundary
		5: region must not cross 128K physical alignment boundary
	     6-15: reserved (zero)
	ES:DI -> DMA descriptor structure (see AX=8102h)
Return:	CF clear if successful
	    DDS physical address field filled in
	    DDS buffer ID field filled (0000h if no buffer allocated)
	CF set on error
	    AL = error code (see AX=8102h)
	    DDS region size field filled wth maximum contiguous length in bytes
SeeAlso: AX=8104h,AX=8105h
----------4B8104-----------------------------
INT 4B - Virtual DMA Specification - UNLOCK DMA REGION
	AX = 8104h
	DX = flags
	    bit 0: reserved (zero)
		1: data should be copied out of buffer
	     2-15: reserved (zero)
	ES:DI -> DMA descriptor structure (see AX=8102h) with region size,
		physical address, and buffer ID fields set
Return: CF clear if successful
	    DDS physical address field set
	    DDS buffer ID field set (0000h if no buffer allocated)
	CF set on error
	    AL = error code (see AX=8102h)
	    DDS region size field filled wth maximum contiguous length in bytes
SeeAlso: AX=8103h,AX=8106h
----------4B8105-----------------------------
INT 4B - Virtual DMA Specification - SCATTER/GATHER LOCK REGION
	AX = 8105h
	DX = flags
	    bits 0-5: reserved (zero)
		   6: EDDS should be returned with page table entries
		   7: only present pages should be locked (not-present pages
			receive entry of 0000h)
		8-15: reserved (zero)
	ES:DI -> Extended DMA descriptor structure (see AX=8102h)
		region size, linear segment, linear offset, and number avail
		fields set
Return: CF clear if successful
	    EDDS number used field set
	    if DX bit 6 set, lower 12 bits of BX = offset in first page
	CF set on error
	    AL = error code (see AX=8102h)
	    EDDS region size field filled with max length in bytes that can be
		locked and described in the EDDS table
SeeAlso: AX=8103h,AX=8106h
----------4B8106-----------------------------
INT 4B - Virtual DMA Specification - SCATTER/GATHER UNLOCK REGION
	AX = 8106h
	DX = flags
	    bits 0-5: reserved (zero)
		   6: EDDS contains page table entries
		   7: EDDS may contain not-present pages (entry = 0000h)
		8-15: reserved (zero)
	ES:DI -> Extended DMA descriptor structure (see AX=8102h) returned
		by AX=8105h	
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
Note:	according to the Microsoft version of the VDS specification, the
	  actual scatter/gather list is ignored, while according to the IBM
	  version of the specification, "the result of a LOCK operation"
	  must be provided to this function
SeeAlso: AX=8104h,AX=8105h
----------4B8107-----------------------------
INT 4B - Virtual DMA Specification - REQUEST DMA BUFFER
	AX = 8107h
	DX = flags
	    bit 0: reserved (zero)
		1: data should be copied into buffer
	     2-15: reserved (zero)
	ES:DI -> DMA descriptor structure (see AX=8102h) with region size set
		(also region offset and region segment if DX bit 1 set)
Return: CF clear if successful
	    DDS physical address and buffer ID set
	    DDS region size filled with length of buffer
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=8108h
----------4B8108-----------------------------
INT 4B - Virtual DMA Specification - RELEASE DMA BUFFFER
	AX = 8108h
	DX = flags
	    bit 0: reserved (zero)
		1: data should be copied out of buffer
	     2-15: reserved (zero)
	ES:DI -> DMA descriptor structure (see AX=8102h) with buffer ID set
		(also region size/region offset/segment if DX bit 1 set)
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=8107h
----------4B8109DX0000-----------------------
INT 4B - Virtual DMA Specification - COPY INTO DMA BUFFER
	AX = 8109h
	DX = 0000h
	ES:DI -> DMA descriptor structure (see AX=8102h) with buffer ID,
		region segment/offset, and region size fields set
	BX:CX = starting offset into DMA buffer
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=810Ah
----------4B810ADX0000-----------------------
INT 4B - Virtual DMA Specification - COPY OUT OF DMA BUFFER
	AX = 810Ah
	DX = 0000h
	ES:DI -> DMA descriptor structure (see AX=8102h) with buffer ID,
		region segment/offset, and region size fields set
	BX:CX = starting offset into DMA buffer
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=8109h
----------4B810B-----------------------------
INT 4B - Virtual DMA Specification - DISABLE DMA TRANSLATION
	AX = 810Bh
	BX = DMA channel number
	DX = 0000h
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=810Ch
----------4B810C-----------------------------
INT 4B - Virtual DMA Specification - ENABLE DMA TRANSLATION
	AX = 810Ch
	BX = DMA channel number
	DX = 0000h
Return: CF clear if successful
	    ZF set if disable count decremented to zero
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=810Bh
----------4B810D-----------------------------
INT 4B - QEMM-386 - BUG
	AX = 810Dh
Note:	the code in QEMM v5.11 and 6.00 jumps to an invalid location on this
	  call
----------4C---------------------------------
INT 4C - Z100 - Slave 8259 - S100 vectored line 4
SeeAlso: INT 4B"Z100",INT 4D"Z100"
----------4C---------------------------------
INT 4C - Acorn BBC Master 512 - "OSCLI" - INTERPRET COMMAND LINE
	DS:BX -> CR-terminated command string
Return: FLAGS destroyed
SeeAlso: INT 40"Acorn",INT 4A"Acorn",INT 4B"Acorn"
----------4D---------------------------------
INT 4D - Z100 - Slave 8259 - S100 vectored line 5
SeeAlso: INT 4C"Z100",INT 4E"Z100"
----------4E---------------------------------
INT 4E - TI Professional PC - DISK I/O
	used instead of INT 13 on the TI Professional PC
SeeAlso: INT 13
----------4E---------------------------------
INT 4E - Z100 - Slave 8259 - S100 vectored line 6
SeeAlso: INT 4D"Z100",INT 4F"Z100"
----------4F---------------------------------
INT 4F - Z100 - Slave 8259 - S100 vectored line 7
SeeAlso: INT 4E"Z100"
----------4F8100-----------------------------
INT 4F - Common Access Method SCSI interface rev 2.3 - SEND CCB TO XPT/SIM
	AX = 8100h
	ES:BX -> CAM Control Block (CCB) (see below)
Return: AH = status
	    00h successful
	    01h invalid CCB address (0000h:0000h)
Note:	the SCSI Interface Module (SIM) may complete the requested function
	  and invoke the completion callback function before this call returns
SeeAlso: AX=8200h,INT 4B"Common Access Method"

Format of CAM Control Block:
Offset	Size	Description
 00h	DWORD	physical address of this CCB
 04h	WORD	CAM control block length
 06h	BYTE	function code (see below)
 07h	BYTE	CAM status (see below)
 08h	BYTE	SCSI status
 09h	BYTE	path ID (FFh = XPT)
 0Ah	BYTE	target ID
 0Bh	BYTE	logical unit number
 0Ch	BYTE	CAM flags
		bits 7-6: direction
			00 reserved
			01 in
			10 out
			11 no data transfer
		bit 5: disable autosense
		    4: scatter/gather
		    3: disable callback on completion
		    2: linked CDB
		    1: tagged queue action enable
		    0: CDB is a pointer
 0Dh	BYTE	CAM flags
		bit 7: disable disconnect
		    6: initiate synchronous transfers  \ mutually
		    5: disable synchronous transfers   / exclusive
		    4: SIM queue priority
			1 head insertion
			0 tail insertion (normal)
		bit 3: SIM queue freeze
		    2: engine synchronize
		bits 1-0: reserved
 0Eh	BYTE	CAM address flags
		bit 7: SG list/data (0 = host, 1 = engine)
		bit 6: CDB pointer    (bits 6-1: 0=virtual addr, 1=phys addr)
		bit 5: SG list/data
		bit 4: sense buffer
		bit 3: message buffer
		bit 2: next CCB
		bit 1: callback on completion
		bit 0: reserved
 0Fh	BYTE	target-mode flags
		bit 7: data buffer valid
		bit 6: status valid
		bit 5: message buffer valid
		bit 4: reserved
		bit 3: phase-cognizant mode
		bit 2: target CCB available
		bit 1: disable autodisconnect
		bit 0: disable autosave/restore
---function 02h---
 10h	DWORD	pointer to 36-byte buffer for inquiry data or 0000h:0000h
 14h	BYTE	peripheral device type of target logical unit number
---function 03h---
 10h	BYTE	version number (00h-07h prior to rev 1.7, 08h = rev 1.7,
		09h-FFh = rev no, i.e. 23h = rev 2.3)
 11h	BYTE	SCSI capabilities
		bit 7: modify data pointers
		    6: wide bus (32 bits)
		    5: wide bus (16 bits)
		    4: synchronous transfers
		    3: linked commands
		    2: reserved
		    1: tagged queueing
		    0: soft reset
 12h	BYTE	target mode support
		bit 7: processor mode
		    6: phase-cognizant mode
		    5-0: reserved
 13h	BYTE	miscellaneous flags
		bit 7: scanned high to low instead of low to high
		    6: removables not included in scan
		    5: inquiry data not kept by XPT
		    4-0: reserved
 14h	WORD	engine count
 16h 14 BYTEs	vendor-specific data
 24h	DWORD	size of private data area
 28h	DWORD	asynchronous event capabilities
		bits 31-24: vendor-specific
		     23-8: reserved
			7: new devices found during rescan
			6: SIM module deregistered
			5: SIM module registered
			4: sent bus device reset to target
			3: SCSI AEN
			2: reserved
			1: unsolicited reselection
			0: unsolicited SCSI bus reset
 2Ch	BYTE	highest path ID assigned
 2Dh	BYTE	SCSI device ID of initiator
 2Eh  2 BYTEs	reserved
 30h 16 BYTEs	SIM vendor ID
 40h 16 BYTEs	HBA (host bus adaptor) vendor ID
 50h  4 BYTEs	operating-system dependant usage
---functions 00h,04h,11h,12h---
 no additional fields
---function 05h---
 10h	DWORD	asynchronous event enables (see function 03h above)
 14h	DWORD	pointer to asynchronous callback routine
 18h	DWORD	pointer to peripheral driver buffer
 1Ch	BYTE	size of peripheral buffer
---function 06h---
 10h	BYTE	peripheral device type of target
---functions 10h,13h---
 10h	DWORD	pointer to CCB to be aborted
---function 20h---
 10h	WORD	engine number
 12h	BYTE	engine type
		00h buffer memory
		01h lossless compression
		02h lossy compression
		03h encryption
 13h	BYTE	engine algorithm ID
		00h vendor-unique
		01h LZ1 variation 1 (STAC)
		02h LZ2 variation 1 (HP DCZL)
		03h LZ2 variation 2 (Infochip)
 14h	DWORD	engine memory size
---function 21h---
 10h	DWORD	pointer to peripheral driver
 14h  4 BYTEs	reserved
 18h	DWORD	OS-dependent request-mapping info
 1Ch	DWORD	address of completion callback routine
 20h	DWORD	pointer to scatter/gather list or data buffer
 24h	DWORD	length of data transfer
 28h	DWORD	pointer to engine buffer data
 2Ch  2 BYTEs	reserved
 2Eh	WORD	number of scatter/gather entries
 30h	DWORD	maximum destination data length
 34h	DWORD	length of destination data
 38h	DWORD	source residual length
 3Ch 12 BYTEs	reserved
 48h	DWORD	OS-dependent timeout value
 4Ch  4 BYTEs	reserved
 50h	WORD	engine number
 52h	WORD	vendor-unique flags
 54h  4 BYTEs	reserved
 58h  N BYTEs	private data area for SIM
---function 30h---
 10h	WORD	group 6 vendor-unique CDB length
 12h	WORD	group 7 vendor-unique CDB length
 14h	DWORD	pointer to target CCB list
 18h	WORD	number of target CCBs
---other functions---
 10h	DWORD	pointer to peripheral driver
 14h	DWORD	pointer to next CCB
 18h	DWORD	OS-dependent request mapping information
 1Ch	DWORD	address of completion callback routine
 20h	DWORD	pointer to scatter/gather list or data buffer
 24h	DWORD	length of data transfer
 28h	DWORD	pointer to sense info buffer
 2Ch	BYTE	length of sense info buffer
 2Dh	BYTE	CDB length
 2Eh	WORD	number of scatter/gather entries
 30h  4 BYTEs	reserved
 34h	BYTE	SCSI status
 35h  3 BYTEs	reserved
 38h	DWORD	residual length
 40h 12 BYTEs	Command Descriptor Block (CDB)
 44h	DWORD	OS-dependent timeout value
 48h	DWORD	pointer to message buffer
 4Ch	WORD	length of message buffer
 4Eh	WORD	vendor-unique flags
 50h	BYTE	tag queue action
 51h  3 BYTEs	reserved
 54h  N BYTEs	private data area for SIM

Values for CAM function code:
 00h NOP
 01h execute SCSI I/O
 02h get device type
 03h path inquiry
 04h release SIM queue
 05h set async callback
 06h set device type
 07h-0Fh reserved
 10h abort SCSI command
 11h reset SCSI bus
 12h reset SCSI device
 13h terminate I/O process
 14h-1Fh reserved
 20h engine inquiry
 21h execute engine request
 22h-2Fh reserved
 30h enable logical unit number
 31h execute target I/O
 32h-7Fh reserved
 80h-FFh vendor-specific functions

Values for CAM status:
 00h request in progress
 01h request successful
 02h host aborted request
 03h unable to abort request
 04h request completed with error
 05h CAM is busy
 06h invalid request
 07h invalid path ID
 08h no such SCSI device
 09h unable to terminate I/O process
 0Ah timeout on target selection
 0Bh timeout on command
 0Dh receive message rejection
 0Eh sent/received SCSI bus reset
 0Fh detected uncorrectable parity error
 10h Autosense request failed
 11h no HBA detected
 12h data over/underrun
 13h bus freed unexpectedly
 14h target bus phase sequence failure
 15h CCB too small
 16h requested capability not available
 17h sent bus device reset
 18h terminate I/O process
 38h invalid LUN
 39h invalid target ID
 3Ah unimplemented function
 3Bh nexus not established
 3Ch invalid initiator ID
 3Dh received SCSI Command Descriptor Block
 3Eh LUN already enabled
 3Fh SCSI bus busy
Note:	bit 6 set to indicate frozen SIM queue
	bit 7 set to indicate valid autosense

Completion callback function called with:
	interrupts disabled
	ES:BX -> completed CCB

Asynchronous callback function called with:
	AH = opcode
	AL = path ID generating callback
	DH = target ID causing event
	DL = LUN causing event
	CX = data byte count (if applicable)
	ES:BX -> data buffer (if applicable)
Return: all registers preserved
----------4F8200CX8765-----------------------
INT 4F - Common Access Method SCSI interface rev 2.3 - INSTALLATION CHECK
	AX = 8200h
	CX = 8765h
	DX = CBA9h
Return: AH = 00h if installed
	    CX = 9ABCh
	    DX = 5678h
	    ES:DI -> "SCSI_CAM"
SeeAlso: AX=8100h,INT 4B"Common Access Method"
---------------------------------------------
