Interrupt List, part 9 of 10
This compilation is Copyright (c) 1989,1990,1991,1992,1993 Ralf Brown
--------*-60---------------------------------
INT 60 - reserved for user interrupt
--------v-60---------------------------------
INT 60 - VIRUS - "Zero Bug" - INSTALLATION CHECK
   The "Zero Bug" virus hooks this vector.  It considers itself installed if
   offset 103h of the handler's segment contains the bytes "ZE"
SeeAlso: INT 32,INT 44"VIRUS",INT 61"SEMTEX"
--------d-60---------------------------------
INT 60 - Adaptec and OMTI controllers - DRIVE 0 DATA
SeeAlso: INT 61"Adaptec",INT 62"Adaptec",INT 63"Adaptec",INT 64"Adaptec"
Notes:	this vector stores the first four bytes of the parameter table for
	  hard disk 0
	these vectors are used by the following Adaptec controllers:
	    ACB 2370 A/B/C, ACB 2372 A/B/C, ACB 2333 A/B, 2322B-8, 2322B-16
	these vectors are NOT used by the following Adaptec controllers:
	    ACB 2310, ACB 2312, ACB 2320D, ACB 2322D
--------b-60---------------------------------
INT 60 - Atari Portfolio - USER INTERFACE FUNCTIONS
   supplies a number of subfunctions which perform such functions as drawing
   boxes and menus, and provide input line editing
SeeAlso: INT 61"Atari"
--------V-60---------------------------------
INT 60 - Nabbit v2.0 - (NOT A VECTOR!) - INSTALLATION CHECK
Program: Nabbit is a shareware resident screen data grabber by RSE Inc.
Note:	Nabbit searches INT 60 through INT 66 for a vector which points at
	  its ASCIZ signature string "iG" (69h 47h 00h), and uses the first
	  free vector in that range it is it not already installed
--------V-60---------------------------------
INT 60 U - Buffit v3.0 - (NOT A VECTOR!) - INSTALLATION CHECK
Program: Buffit is a shareware scrollback utility by D.T. Hamilton
Notes:	Buffit searches INT 60 through INT 6F for a vector which points at
	  the ASCII signature "Buffit  ", and uses the first free vector in
	  that range if it is not already installed
	there is a private entry point immediately following the signature
	  string, i.e. eight bytes beyond the address pointed at by the
	  interrupt

Call private entry point with:
	AH = function
	    00h get information and hotkey state
	    01h get information and toggle hotkey state
Return: AH = new hotkey state (00h enabled, 01h disabled)
	AL = hotkey scan code
	BH = hotkey shift states
	BL = ??? (01h)
	CX = segment of resident code
	DH = niterrupt number used for signature pointer
	DL = ??? (00h)
	SI = INT 09 handler offset
	DI = INT 21 handler offset
Index:	hotkeys;Buffit
----------60---------------------------------
INT 60 - PC-IPC API
	STACK:	DWORD	pointer to parameter block (see below)
Return: STACK:	unchanged
Program: PC-IPC is a shareware TSR by Donnelly Software Engineering which
	  allows communication between independent programs
Note:	INT 60 is the default, any interrupt vector may be used by specifying
	  the vector on the commandline

Format of parameter block:
Offset	Size	Description
 00h	WORD	caller's ID
 02h	WORD	to ID
 04h	WORD	command code (see below)
 06h	WORD	returned status (see below)
 08h	WORD	returned error code (see below)
 0Ah	WORD	size of data
 0Ch	DWORD	pointer to data buffer

Values for command code:
 01h "IPC_CMND_INQUIRE"	 inquire current status
		set status field, writes WORD to data buffer containing free
		  message space in bytes, and sets the "size" field to the
		  number of messages waiting
 02h "IPC_CMND_ENABLE"	reenable PC-IPC
		ignored unless called with the same ID that disabled PC-IPC
 03h "IPC_CMND_DISABLE" disable PC-IPC
 04h "IPC_CMND_INSTALL" reset PC-IPC
 06h "IPC_CMND_RDATA"	read data
		returns first message in data buffer, sets "size" to message
		  length and "to ID" field to sender's ID
		if no messages available, bit 4 of status is cleared and "size"
		  is set to zero
 07h "IPC_CMND_SDATA"	send data
 08h "IPC_CMND_REQID"	require user ID
		create a new recognized ID and return in "caller's ID" field
 09h "IPC_CMND_DELID"	cancel user ID
		delete caller's ID from pool of recognized IDs
 0Ah "IPC_CMND_RDATAW"	read data, wait if no messages available
 0Bh "IPC_CMND_VERS"	get PC-IPC version
		string representing version returned in data buffer, "size"
		  field set to length of string

Bitfields for returned status:
 bit 0	unused
 bit 1	IPC enabled
 bit 2	IPC installed
 bit 3	error
 bit 4	message(s) available

Values for error code:
 00h	no error
 01h	invalid command or parameter
 02h	only process 0 can install/reset IPC
 03h	process can not install/reset IPC
 04h	IPC is not enabled
 05h	process can not disable IPC
 06h	invalid destination process ID
 07h	invalid sending process ID
 08h	invalid data destination
 09h	no more process IDs available
 0Ah	can not relinquish that process ID
 0Bh	message space is full
 0Ch	IPC is not installed
--------R-60---------------------------------
INT 60 - Tangram Arbiter - API
Notes:	Arbiter may use any interrupt from 60h to 66h (parameterized)
	identified by string "@ARB_API" immediately following a short jump at
	  the interrupt handler address
	Arbiter makes a PC disk look like a slow disk over an SNA link to an
	  IBM mainframe
--------N-60---------------------------------
INT 60 - Excelan LAN Workplace for DOS 3.5 - API
	ES:BX -> request packet
Return: request packet updated
Notes:	this interrupt is also supported by Beame&Whiteside's BWLWP35 shim,
	  which was used in creating this description
	the installation check consists of testing for the WORD 4142h ('AB')
	  immediately preceding the interrupt handler
BUG:	because BWLWP35 range-checks only the low byte of the function number,
	  and has a fencepost error even in that test, functions 000Bh and
	  XX01h-XX0Bh (XX nonzero) branch to random locations
SeeAlso: INT 2F/AX=7A40h

Format of request packet:
Offset	Size	Description
 00h 12 BYTEs	???
 0Ch	WORD	(return) error code (see below)
 0Eh	DWORD	-> FAR function for ???
 12h	WORD	function number
		0001h ???
		0002h NOP
		0003h NOP
		0004h NOP
		0005h ???
		0006h get ??? record
		0007h NOP
		0008h reset ???
		0009h NOP
		000Ah set ???
	???
---function 01h---
 20h	BYTE	(call) subfunction (32h-3Bh)
		3Bh non-blocking I/O request (will be tested every clock tick)
 21h	BYTE	(return) error code
		00h successful
		09h invalid connection number
		2Ah bad connection type
		45h ???
---function 01h, subfunction 32h---
 3Ah	WORD	(call) connection type (01h stream, 02h datagram)
---function 01h, subfunction 34h---
 26h	WORD	(call) ???
 28h	WORD	(call) ???
 2Ah	WORD	(call) ???
---function 01h, subfunction 35h---
 1Ah	WORD	(call) connection number???
 26h	WORD	(return) ???
---function 01h, subfunction 36h---
 1Ah	WORD	(call) connection number???
 38h	WORD	???
---function 01h, subfunction 37h---
 24h	WORD	(return) ???
 26h	WORD	(return) ???
---function 01h, subfunction 38h---
 1Ah	WORD	(call) connection number???
---function 01h, subfunction 3Ah---
 22h	WORD	(call) ???
		667Eh ???
		667Fh ???
 24h	BYTE	(call 667Eh) ???
 24h	WORD	(return 667Fh) ???
---function 01h, subfunction 3Bh---
 0Eh	DWORD	(call) -> function to invoke for I/O or 0000h:0000h
		function called with AX = 0000h
				     STACK: DWORD -> request packet
					    WORD 0000h
			should return STACK unchanged
 1Ah	WORD	(call) connection number???
 21h	BYTE	(return) set to 01h when I/O becomes possible
 22h	BYTE	(call) direction (00h write, 01h read)
 34h	DWORD	(return) -> next pending request packet
---function 05h---
 1Eh	WORD	(call) ???
 20h	WORD	(call) ???
 34h	DWORD	(call) -> ???
---function 06h---
 16h	DWORD	(call) -> buffer for ??? record (see below)
 1Ah	WORD	(call) number of bytes to copy
 22h	WORD	(return) number of bytes transferred
---function 08h---
 14h	WORD	(return) ??? (0001h)
---function 0Ah---
 16h	DWORD	(call) -> WORD ???
 1Ch	WORD	(call) must be 000Ah for BWLWP35

Values for error code:
 0000h	successful
 002Dh	invalid function
 0050h	???

Format of ??? record:
Offset	Size	Description
 00h	WORD	offset of ???
 02h  4 BYTEs	???
 06h	DWORD	IP address (big-endian)
 0Ah  6 BYTEs	physical address (big-endian)
	???
--------G-60---------------------------------
INT 60 U - INTRSPY/CMDSPY API
Program: INTRSPY is a script-driven debugger included with the book
	  _Undocumented_DOS_.
Notes:	INTRSPY will hook the first available interrupt in the range 60h-67h.
	The installation check is to
	  a) determine that the handler is an IRET instruction
	  b) the signature 0Dh "INTRSPY vN.NN" immediately precedes the handler
	  If INTRSPY is installed, the DWORD immediately after the IRET stores
	  its entry point.
Index:	installation check;INTRSPY

Call INTRSPY entry point with:
	AH = function
	    00h ???
	    01h set current directory (for use in reporting)
		ES:DI -> counted string containing directory name (max 79 char)
	    02h set name of script file
		ES:DI -> counted string containing file name (max 79 chars)
	    03h set script arguments
		ES:DI -> counted string containing arguments (max 79 chars)
	    04h get directory set with function 01h
		ES:DI -> 80-byte buffer for directory name
	    05h get name of script file
		ES:DI -> 80-byte buffer for script filename
	    06h get script arguments
		ES:DI -> 80-byte buffer for script arguments
	    07h get ???
		CL = 00h-15h specifies what to get
		ES:DI -> WORD to be set with desired value on return
	    08h get ???
		ES:DI -> WORD to be set with returned value
	    09h get ???
		ES:DI -> WORD to be set with returned value
	    0Bh store code for interrupt handler???
		ES:DI -> data
		CX = number of bytes
	    0Ch ???
		ES:DI -> ???
	    0Dh get ???
		ES:DI -> BYTE to be set with returned value
	    0Eh set ??? flag
	    0Fh clear ??? flag
	    10h ???
		Return: AL = 04h or 05h if failed
	    11h ???
		Return: AL = 05h if failed
	    12h get ???
		ES:DI -> buffer
		Return: CX = number of bytes returned in buffer
	    13h ???
Return: AH = 00h
	AL = status
	    00h successful
	    01h invalid function
	    02h ???
	    03h ???
	    04h ???
	    05h ???
--------u-60---------------------------------
INT 60 U - PC/370 v4.2 - ???
	???
Return: ???
Program: PC/370 is an IBM 370 emulator by Donald S. Higgins
Note:	this is the default interrupt, however the documentation includes
	  instructions for patching the system for another interrupt
SeeAlso: INT 2F/AX=7F24h,INT DC"PC/370"
--------r-60---------------------------------
INT 60 - JPI TopSPEED Modula-2 v1 - PROCEDURE ENTRY TRAP
SeeAlso: INT 61"JPI"
--------N-60---------------------------------
INT 60 - FTP Packet Driver - PC/TCP Packet Driver Specification
Notes:	The handler for the interrupt will start with a 3-byte jump
	  instruction, followed by the ASCIZ string "PKT DRVR" (the
	  terminating NUL is significant).
	To find the interrupt being used by the driver, an application should
	  scan through interrupt vectors 60h to 80h (20h through FFh for
	  v1.10+ of the specification) until it finds one with the "PKT DRVR"
	  string.
	AH values of 80h to FFh have been reserved for user-defined additions.
--------b-60----DI0100-----------------------
INT 60 u - HP 95LX System Manager - WAIT FOR EVENT
	DI = 0100h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to event record (see below)
Return: event record filled
	STACK unchanged
Note:	this call will timeout after about 500ms
SeeAlso: INT 15/AX=4DD4h,INT 60/DI=0101h,INT 61"HP 95LX",INT 62"HP 95LX"

Values for event type:
 00h	no events
 01h	keystroke available
 02h	Ctrl-Break
 03h	reactivation (always follows deactivation event)
 04h	about to deactivate (sleep)
	next get-event call will not return until reactivated
 05h	forced application termination
 06h	1-2-3 bridge service request (only given to 1-2-3)
 07h	request to grow
 08h	request to shrink
 09h	application's alarm expired
 0Ah	daily chance to set an alarm
 0Bh	system date or time has been changed

Format of event record:
Offset	Size	Description
 00h	WORD	event type (see above)
 02h	WORD	ASCII code page 850 translation of keystroke
		or grow/shrink amount in paragraphs or 0000h if error
		or alarm expiration data
 04h	BYTE	scan code from BIOS
 05h	BYTE	shift key states at time keystroke is retrieved
 06h	WORD	LICS translation of keystroke
 08h	BYTE	function key number (1-2-3 only)
 09h	DWORD	pointer to 1-2-3 bridge record (see INT 60/DI=0104h)
		or pointer to time change structure (see below)
Note:	if the System Manager is awaiting the conclusion of a bridge service
	  or grow/shrink call and the event type field is set to FFFFh on
	  entry, the SysMgr will resume

Format of time change structure:
Offset	Size	Description
 00h	WORD	old year
 02h	BYTE	old month
 03h	BYTE	old date
 04h	BYTE	old day
 05h	BYTE	old hour
 06h	BYTE	old minute
 07h	BYTE	old second
 08h	BYTE	old hundredth of a second
 09h  9 BYTEs	new time in same format as old time
--------b-60----DI0101-----------------------
INT 60 u - HP 95LX System Manager - CHECK FOR EVENT
	DI = 0101h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD pointer to event record (INT 60/DI=0100h)
Return: event record filled
	STACK unchanged
Note:	this call returns immediately if no event is available
SeeAlso: INT 60/DI=0100h
--------b-60----DI0102-----------------------
INT 60 u - HP 95LX System Manager - "SH_STATUS"
	DI = 0102h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
--------b-60----DI0104-----------------------
INT 60 u - HP 95LX System Manager - LOTUS 1-2-3 BRIDGE SERVICES
	DI = 0104h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD pointer to bridge record (see below)
Return: ???
	STACK unchanged

Values for function code:
 00h	test
 01h	get range
 02h	"GETRANGE_ADDR"
 03h	"SETRANGE_ADDR"
 04h	"GETRANGE_DATA"
 05h	"SETRANGE_DATA"
 06h	recalculate
 07h	get cursor
 08h	set cursor
 09h	redisplay
 0Ah	cell type
 0Bh	"CALCTYPE"

Format of bridge record:
Offset	Size	Description
 00h	WORD	function code (see above)
 02h	WORD	return code from 1-2-3
 04h 16 BYTEs	ASCII range name
 14h	WORD	start column of range
 16h	WORD	start row of range
 18h	WORD	end column of range
 1Ah	WORD	end row of range
 1Ch	WORD	order in which data is placed in buffer
 1Eh	WORD	buffer size
 20h	WORD	offset within bridge record's segment of buffer for cell data
--------b-60----DI0105-----------------------
INT 60 u - HP 95LX System Manager - FLUSH KEYBOARD BUFFER
	DI = 0105h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
--------b-60----DI0106-----------------------
INT 60 u - HP 95LX System Manager - YIELD CPU
	DI = 0106h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=1000h,INT 2F/AX=1680h
--------b-60----DI0107-----------------------
INT 60 u - HP 95LX System Manager - "NO_FINI" - REFUSE TERMINATION REQUEST
	DI = 0107h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
--------b-60----DI0200-----------------------
INT 60 u - HP 95LX System Manager - SETUP MENU
	DI = 0200h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to menu data (see below)
		DWORD	pointer to ???
		WORD	number of items on menu???
		WORD	???
		DWORD	pointer to ???
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 60/DI=0201h,INT 60/DI=0203h,INT 60/DI=0205h

Format of menu data:
Offset	Size	Description
 00h 80 BYTEs	first line of menu text
 50h 80 BYTEs	second line of menu text
 A0h 80 BYTEs	third line of menu text
 F0h	WORD	number of keywords
 F2h	WORD	index of currently highlighted keyword or FFFFh
 F4h	WORD	single prompt on top line if nonzero
 F6h 20 BYTEs	which line each of 20 keywords is located on
10Ah 20 BYTEs	offset of each of 20 keywords within its line
11Eh 20 BYTEs	length of each of 20 keywords
132h 20 BYTEs	first letter of each of 20 keywords
146h 20 WORDs	offsets of long prompts for each of 20 keywords
--------b-60----DI0201-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY OR REDISPLAY MENU
	DI = 0201h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to menu data (see INT 60/DI=0200h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0200h,INT 60/DI=0202h,INT 60/DI=0206h
--------b-60----DI0202-----------------------
INT 60 u - HP 95LX System Manager - "MENU_ON" - ENABLE PROCESSING OF MENU
	DI = 0202h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to menu data (see INT 60/DI=0200h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0200h,INT 60/DI=0201h,INT 60/DI=0203h
--------b-60----DI0203-----------------------
INT 60 u - HP 95LX System Manager - REMOVE MENU
	DI = 0203h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to menu data (see INT 60/DI=0200h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0201h,INT 60/DI=0202h,INT 60/DI=0204h,INT 60/DI=0208h
--------b-60----DI0204-----------------------
INT 60 u - HP 95LX System Manager - LET SYSTEM MANAGER HANDLE MENU KEYSTROKE
	DI = 0204h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to menu data (see INT 60/DI=0200h)
		WORD	keystroke
		DWORD	pointer to WORD to receive selection number
Return: buffer for selection number filled with index of selected menu item or
	  FFFFh if no final selection yet
	STACK unchanged
SeeAlso: INT 60/DI=0200h,INT 60/DI=0202h,INT 60/DI=0207h
--------b-60----DI0205-----------------------
INT 60 u - HP 95LX System Manager - INITIALIZE FILE SELECTION MENU
	DI = 0205h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file menu structure (see below)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
		DWORD	pointer to wildcard filespec for initial file list
		WORD	row???
		WORD	column???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0200h,INT 60/DI=0206h,INT 60/DI=0208h

Format of file menu structure:
Offset	Size	Description
 00h	DWORD	pointer to ASCIZ base directory name
 04h	DWORD	pointer to ASCIZ file pattern (wildcard filespec)
 08h	DWORD	pointer to file list workspace, at least 1024 bytes (see below)
 0Ch	WORD	size of file list workspace in bytes
 0Eh	WORD	starting row (-3 is topmost, 0 is first non-"reserved" line)
 10h	WORD	starting column
 12h	WORD	number of lines
 14h	WORD	number of columns
 16h	WORD	number of files displayed on each line
---the remaining fields are initialized by the System Manager---
 18h	WORD	0000h if first edit character, else multiline
 1Ah	WORD	number of files in file list
 1Ch	WORD	max files workspace has room for
 1Eh	WORD	file at top of list
 20h	WORD	index of file to highlight
 22h	WORD	index of file to unhighlight
 24h	WORD	current focus (01h FMENU, 02h EDIT)

Format of file list workspace entry:
Offset	Size	Description
 00h	BYTE	file attributes
 01h	WORD	file time (see INT 21/AX=5700h)
 03h	WORD	file date (see INT 21/AX=5700h)
 05h	DWORD	file size
 09h 13 BYTEs	ASCIZ filename
--------b-60----DI0206-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY/REDISPLAY FILE SELECTION MENU
	DI = 0206h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file menu structure (see INT 60/DI=0205h)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0205h
--------b-60----DI0207-----------------------
INT 60 u - HP 95LX System Manager - LET SYSMGR PROCESS FILE SEL MENU KEYSTROKE
	DI = 0207h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file menu structure (see INT 60/DI=0205h)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
		WORD	keystroke
Return: AX = status
	    0000h keystroke processed, call INT 60/DI=0206h to refresh menu
	    0001h redisplay application area before refreshing menu
	    0002h user confirmed selection, filename is in edit record's buffer
	    0003h user aborted menu
	    FFFBh bad filename
	    FFFCh bad directory
	    FFFDh bad drive
	    FFFEh unknown keystroke
	    FFFFh keystroke known but invalid in current context
	STACK unchanged
SeeAlso: INT 60/DI=0205h,INT 60/DI=0208h
--------b-60----DI0208-----------------------
INT 60 u - HP 95LX System Manager - REMOVE FILE SELECTION MENU
	DI = 0208h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file menu structure (see INT 60/DI=0205h)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 60/DI=0205h,INT 60/DI=0206h
--------b-60----DI0300-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY STRING
	DI = 0300h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	starting row (-3 is topmost, 0 is first user line)
		WORD	starting column
		DWORD	pointer to string
		WORD	length of string
		WORD	display style: 0000h normal, 0001h reverse video
		WORD	"OSTYLE"
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0F03h,INT 60/DI=1005h
--------b-60----DI0301-----------------------
INT 60 u - HP 95LX System Manager - CLEAR PORTION OF SCREEN
	DI = 0301h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	starting row (-3 is topmost, 0 is first user line)
		WORD	starting column
		WORD	number of rows
		WORD	number of columns
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0302h,INT 60/DI=1005h
--------b-60----DI0302-----------------------
INT 60 u - HP 95LX System Manager - SCROLL PORTION OF SCREEN
	DI = 0302h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	starting row???
		WORD	starting column???
		WORD	height of scroll region???
		WORD	width of scroll region???
		WORD	number of lines to scroll region???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0301h
--------b-60----DI0303-----------------------
INT 60 u - HP 95LX System Manager - SCREEN SERVICE "M_XCHG"
	DI = 0303h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
		WORD	???
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0304-----------------------
INT 60 u - HP 95LX System Manager - SCREEN SERVICE "M_CHRATTR"
	DI = 0304h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0305-----------------------
INT 60 u - HP 95LX System Manager - SCREEN SERVICE "M_CHRRVRT"
	DI = 0305h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0307-----------------------
INT 60 u - HP 95LX System Manager - SCREEN SERVICE "M_CHRINV"
	DI = 0307h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0308-----------------------
INT 60 u - HP 95LX System Manager - SCREEN SERVICE "M_ROWS_COLS"
	DI = 0308h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
--------b-60----DI0309-----------------------
INT 60 u - HP 95LX System Manager - SET SCREEN (VIDEO???) MODE
	DI = 0309h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	new mode
Return: ???
	STACK unchanged
--------b-60----DI030A-----------------------
INT 60 u - HP 95LX System Manager - GET SCREEN (VIDEO???) MODE
	DI = 030Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
--------b-60----DI030B-----------------------
INT 60 u - HP 95LX System Manager - SET CURSOR POSITION
	DI = 030Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	row (-3 is topmost, 0 is first non-reserved line)
		WORD	column
Return: ???
	STACK unchanged
Note:	cursor is hidden if the specified position is not on the physical
	  display
SeeAlso: INT 10/AH=02h,INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
--------b-60----DI0400-----------------------
INT 60 u - HP 95LX System Manager - "EDIT_INIT"
	DI = 0400h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to edit record (see below)
		DWORD	pointer to string to be edited
		WORD	initial length of string being edited
		WORD	maximum length of edited string
		WORD	row of edit field
		WORD	leftmost column of edit field
Return: ???
	STACK unchanged

Format of edit record:
Offset	Size	Description
 00h	WORD	current length of edit buffer
 02h	BYTE	flag for special processing on first character
 03h	BYTE	flags
		bit 0: tab handling
 04h	WORD	editing in prompt window?
 06h	DWORD	pointer to top line of prompt window message
 0Ah	WORD	length of top line of prompt
 0Ch	DWORD	pointer to second line of prompt window message
 10h	WORD	length of second line of prompt
 12h 80 BYTEs	workspace for editing
 62h  2 WORDs	line array needed for multi-line editing
 66h 36 BYTEs	multi-line edit record (see below)
 8Ah	WORD	displayable columns

Format of multi-line edit record:
Offset	Size	Description
 00h	DWORD	pointer to user-supplied edit buffer
 04h	WORD	length of edit buffer
 06h	WORD	current cursor position
 08h	WORD	starting row of edit area (-3 is topmost, 0 is first user line)
 0Ah	WORD	starting column of edit area
 0Ch	WORD	height of edit area
 0Eh	WORD	width of edit area
 10h	WORD	current top row (-3 is topmost, 0 is first user line)
 12h	WORD	number of rows displayable
 14h	BYTE	cursor column
 15h	BYTE	01h if buffer has been modified
 16h	BYTE	first displayable column (ticker fields only)
 17h	BYTE	01h if wordwrap enabled, FFh if ticker field
 18h	DWORD	pointer to array of line starts (at least one bigger than edit
		  area is high)
 1Ch	BYTE	currently marking?
 1Dh	BYTE	flag
 1Eh	WORD	offset of mark start
 20h	WORD	offset of mark end (inclusive)
 22h	WORD	displayable columns
--------b-60----DI0401-----------------------
INT 60 u - HP 95LX System Manager - EDIT ON TOP LINE
	DI = 0401h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
		DWORD	pointer to string to edit
		WORD	initial length of string being edited
		WORD	maximum length of edited string
		DWORD	pointer to first line of prompt
		WORD	length of first line
		DWORD	pointer to second line of prompt
		WORD	length of second line
Return: ???
	STACK unchanged
--------b-60----DI0402-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY OR REDISPLAY EDIT FIELD
	DI = 0402h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
Return: ???
	STACK unchanged
--------b-60----DI0403-----------------------
INT 60 u - HP 95LX System Manager - LET SYSTEM MANAGER PROCESS EDITING KEYSTROK
	DI = 0403h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
		WORD	keystroke
		DWORD	pointer to WORD buffer for result code
Return: result code buffer filled with 0001h if editing complete
	STACK unchanged
--------b-60----DI0404-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_INI"
	DI = 0404h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
		WORD	???
		WORD	???
		DWORD	pointer to ???
		WORD	???
		WORD	???
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0405-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_DIS"
	DI = 0405h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0406-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_KEY"
	DI = 0406h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0407-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_FIL"
	DI = 0407h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0408-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_MARK"
	DI = 0408h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0409-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_UNMARK"
	DI = 0409h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI040A-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_CUTMARK"
	DI = 040Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI040B-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_INS_STR"
	DI = 040Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
--------b-60----DI0500-----------------------
INT 60 u - HP 95LX System Manager - OPEN FILE
	DI = 0500h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see below)
		DWORD	pointer to filename
		WORD	length of filename
		WORD	???
		WORD	suppress buffering if nonzero
Return: AX = status
	STACK unchanged
SeeAlso: INT 60/DI=0501h,INT 60/DI=0502h,INT 60/DI=0508h

Format of file state record:
Offset	Size	Description
 00h	WORD	DOS file handle
 02h	WORD	flags
		bit 0: buffer contents valid
		bit 1: buffer is dirty and must be written
		bit 2: unbuffered I/O
		bit 3: file is a character device
 04h	DWORD	current DOS physical file offset (FFFFFFFFh if unknown)
 08h	DWORD	DOS file offset of start of buffer
 0Ch	DWORD	effective file offset as seen by caller
 10h	WORD	number of bytes in file buffer
---buffered I/O only---
 12h 512 BYTEs	file buffer
--------b-60----DI0501-----------------------
INT 60 u - HP 95LX System Manager - OPEN FILE IN READ-ONLY MODE
	DI = 0501h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		DWORD	pointer to filename
		WORD	length of filename
		WORD	???
		WORD	suppress buffering if nonzero
Return: AX = status
	STACK unchanged
SeeAlso: INT 60/DI=0500h
--------b-60----DI0502-----------------------
INT 60 u - HP 95LX System Manager - CREATE NEW FILE
	DI = 0502h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		DWORD	pointer to filename
		WORD	length of filename
		WORD	???
		WORD	suppress buffering if nonzero
Return: AX = status
	STACK unchanged
SeeAlso: INT 60/DI=0500h,INT 60/DI=0503h
--------b-60----DI0503-----------------------
INT 60 u - HP 95LX System Manager - CREATE OR TRUNCATE FILE
	DI = 0503h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		DWORD	pointer to filename
		WORD	length of filename
		WORD	???
		WORD	suppress buffering if nonzero
Return: AX = status
	STACK unchanged
SeeAlso: INT 60/DI=0502h
--------b-60----DI0504-----------------------
INT 60 u - HP 95LX System Manager - READ FROM FILE
	DI = 0504h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		DWORD	pointer to data buffer
		WORD	number of bytes to read
		DWORD	pointer to WORD in which to return actual bytes read
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0505h
--------b-60----DI0505-----------------------
INT 60 - HP 95LX System Manager - WRITE TO FILE
	DI = 0505h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		DWORD	pointer to data
		WORD	length of data
Return: AX = status
	STACK unchanged
SeeAlso: INT 60/DI=0504h
--------b-60----DI0506-----------------------
INT 60 u - HP 95LX System Manager - SET FILE POSITION
	DI = 0506h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0507h
--------b-60----DI0507-----------------------
INT 60 u - HP 95LX System Manager - GET FILE POSITION
	DI = 0507h "M_TELL"
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		DWORD	pointer to DWORD buffer for file position???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0506h
--------b-60----DI0508-----------------------
INT 60 u - HP 95LX System Manager - CLOSE FILE
	DI = 0508h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0500h
--------b-60----DI0509-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_SETPAT"
	DI = 0509h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI050A-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_MATCH"
	DI = 050Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged

Format of pattern match control block:
Offset	Size	Description
 00h 43 BYTEs	FindFirst data block (see INT 21/AH=4Eh)
 2Bh 80 BYTEs	full path name
 7Bh	BYTE	offset of last component of filename
 7Ch	BYTE	DOS function number (4Eh or 4Fh)
--------b-60----DI050B-----------------------
INT 60 u - HP 95LX System Manager - IDENTIFY FILENAME REFERENT
	DI = 050Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged

Values returned:
 0000h nonexistent
 0001h file
 0002h directory
 0003h character device
--------b-60----DI050C-----------------------
INT 60 u - HP 95LX System Manager - DELETE FILE
	DI = 050Ch "M_DELETE"
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI050D-----------------------
INT 60 u - HP 95LX System Manager - RENAME FILE
	DI = 050Dh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
		DWORD	pointer to ???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI050E-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_GETDIR"
	DI = 050Eh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI050F-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_SETDIR"
	DI = 050Fh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0510-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_VOLUME"
	DI = 0510h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0511-----------------------
INT 60 u - HP 95LX System Manager - MAKE A SUBDIRECTORY
	DI = 0511h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0512-----------------------
INT 60 u - HP 95LX System Manager - REMOVE A SUBDIRECTORY
	DI = 0512h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0513-----------------------
INT 60 u - HP 95LX System Manager - GET DEFAULT DRIVE
	DI = 0513h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ??? buffer for current drive
Return: ???
	STACK unchanged
--------b-60----DI0514-----------------------
INT 60 u - HP 95LX System Manager - SET DEFAULT DRIVE
	DI = 0514h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	new drive
Return: ???
	STACK unchanged
--------b-60----DI0515-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_FDATE"
	DI = 0515h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0516-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_GET_SYSDIR"
	DI = 0516h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0517-----------------------
INT 60 u - HP 95LX System Manager - GET FILE ATTRIBUTES
	DI = 0517h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
		DWORD	pointer to ??? buffer for file's attributes???
Return: ???
	STACK unchanged
--------b-60----DI0518-----------------------
INT 60 u - HP 95LX System Manager - SET FILE ATTRIBUTES
	DI = 0518h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
		WORD	new attributes???
Return: ???
	STACK unchanged
--------b-60----DI0519-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_COMMON_OPEN"
	DI = 0519h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		WORD	???
		WORD	???
		WORD	???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI051A-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_COPYDT"
	DI = 051Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI051B-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_GETFDT"
	DI = 051Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI051C-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_PUTFDT"
	DI = 051Ch
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0600-----------------------
INT 60 u - HP 95LX System Manager - PROCESS INITIALIZING
	DI = 0600h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 60/DI=0601h,INT 61"HP 95LX"
--------b-60----DI0601-----------------------
INT 60 u - HP 95LX System Manager - PROCESS TERMINATION
	DI = 0601h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: never
	STACK unchanged
SeeAlso: INT 21/AH=4Ch,INT 60/DI=0600h
--------b-60----DI0602-----------------------
INT 60 u - HP 95LX System Manager - "M_LOCK" - PREVENT TASK SWITCHES
	DI = 0602h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=101Bh,INT 60/DI=0603h
--------b-60----DI0603-----------------------
INT 60 u - HP 95LX System Manager - "M_UNLOCK" - ALLOW TASK SWITCHES
	DI = 0603h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=101Ch,INT 60/DI=0602h
--------b-60----DI0604-----------------------
INT 60 u - HP 95LX System Manager - "M_SPAWN"
	DI = 0604h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0605-----------------------
INT 60 u - HP 95LX System Manager - "M_APPCOUNT"
	DI = 0605h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
--------b-60----DI0606-----------------------
INT 60 u - HP 95LX System Manager - "M_REBOOT"
	DI = 0606h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
--------b-60----DI0607-----------------------
INT 60 u - HP 95LX System Manager - "M_SPAWNARG"
	DI = 0607h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0608-----------------------
INT 60 u - HP 95LX System Manager - "M_REG_APP_NAME"
	DI = 0608h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0609-----------------------
INT 60 u - HP 95LX System Manager - "M_APP_NAME"
	DI = 0609h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: DX:AX -> ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
--------b-60----DI0700-----------------------
INT 60 u - HP 95LX System Manager - OPEN CLIPBOARD
	DI = 0700h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0701h,INT 60/DI=0702h

Values for error code:
 0000h	successful
 FFF8h	transfer request out of bounds
 FFF9h	no such representation
 FFFAh	no representation open
 FFFBh	a representation is already open
 FFFCh	representation already exists
 FFFDh	heap allocation failure
 FFFEh	clipboard not open
 FFFFh	clipboard access denied
--------b-60----DI0701-----------------------
INT 60 u - HP 95LX System Manager - CLOSE CLIPBOARD
	DI = 0701h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0700h,INT 60/DI=0702h
--------b-60----DI0702-----------------------
INT 60 u - HP 95LX System Manager - RESET CLIPBOARD
	DI = 0702h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0700h
--------b-60----DI0704-----------------------
INT 60 u - HP 95LX System Manager - "M_NEW_REP" - START A NEW REPRESENTATION???
	DI = 0704h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0705h,INT 60/DI=0706h,INT 60/DI=0707h
--------b-60----DI0705-----------------------
INT 60 u - HP 95LX System Manager - CLIPBOARD SERVICE "M_FINI_REP"
	DI = 0705h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0704h
--------b-60----DI0706-----------------------
INT 60 u - HP 95LX System Manager - CLIPBOARD SERVICE "M_REP_NAME"
	DI = 0706h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0704h,INT 60/DI=0707h
--------b-60----DI0707-----------------------
INT 60 u - HP 95LX System Manager - CLIPBOARD SERVICE "M_REP_INDEX"
	DI = 0707h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0704h,INT 60/DI=0706h
--------b-60----DI0708-----------------------
INT 60 u - HP 95LX System Manager - WRITE TO CLIPBOARD
	DI = 0708h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to data to be written???
		WORD	length of data???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0709h
--------b-60----DI0709-----------------------
INT 60 u - HP 95LX System Manager - READ FROM CLIPBOARD
	DI = 0709h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
		DWORD	pointer to buffer for data???
		WORD	length of buffer???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0708h
--------b-60----DI0800-----------------------
INT 60 u - HP 95LX System Manager - BEEP
	DI = 0800h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0801h,INT 60/DI=0802h,INT 60/DI=0803h
--------b-60----DI0801-----------------------
INT 60 u - HP 95LX System Manager - SOUND SERVICE "M_THUD"
	DI = 0801h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0800h,INT 60/DI=0802h,INT 60/DI=0803h
--------b-60----DI0802-----------------------
INT 60 u - HP 95LX System Manager - MAKE A SOUND PATTERN
	DI = 0802h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	pattern number (00h-06h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0800h,INT 60/DI=0801h,INT 60/DI=0803h
--------b-60----DI0803-----------------------
INT 60 u - HP 95LX System Manager - TURN OFF SOUND
	DI = 0803h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0800h,INT 60/DI=0801h,INT 60/DI=0802h
--------b-60----DI0900-----------------------
INT 60 - HP 95LX System Manager - ALLOCATE REGULAR MEMORY BLOCK
	DI = 0900h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	size of block in bytes
Return: AX -> memory block
	STACK unchanged
Note:	System Manager-compliant applications are always small-model (64K code,
	  64K data)
SeeAlso: INT 15/AX=4DD4h,INT 60/DI=0902h,INT 60/DI=0903h
--------b-60----DI0902-----------------------
INT 60 u - HP 95LX System Manager - FREE REGULAR MEMORY BLOCK
	DI = 0902h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	offset of memory block???
Return: ???
	STACK unchanged
Note:	System Manager-compliant applications are always small-model (64K code,
	  64K data)
SeeAlso: INT 60/DI=0900h,INT 60/DI=0904h
--------b-60----DI0903-----------------------
INT 60 u - HP 95LX System Manager - ALLOCATE LARGE MEMORY BLOCK
	DI = 0903h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	size of block in bytes???
Return: AX -> memory block???
	STACK unchanged
SeeAlso: INT 60/DI=0900h,INT 60/DI=0904h
--------b-60----DI0904-----------------------
INT 60 u - HP 95LX System Manager - FREE LARGE MEMORY BLOCK
	DI = 0904h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	segment of memory block???
Return: AX -> ???
	STACK unchanged
SeeAlso: INT 60/DI=0902h,INT 60/DI=0903h
--------b-60----DI0B00-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_DTINFO"
	DI = 0B00h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0B01-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_GETDTM"
	DI = 0B01h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0B02-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_SETDTM"
	DI = 0B02h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0B03-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_XALARM"
	DI = 0B03h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0B04-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_ALARM"
	DI = 0B04h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to alarm record???
		WORD	???
Return: ???
	STACK unchanged

Format of alarm record:
Offset	Size	Description
 00h	BYTE	hour
 01h	BYTE	minute
 02h	BYTE	second
 03h	BYTE	unused padding
 04h	WORD	rescheduling interval, in seconds
 06h	BYTE	are seconds significant?
 07h	BYTE	alarm sound
 08h 40 BYTEs	message displayed when alarm activates
 30h	BYTE	task ID of owner
 31h	BYTE	application's own use for sub-class
 32h  4 BYTEs	application's own use for private data
--------b-60----DI0B05-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_START_SW"
	DI = 0B05h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0B06-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_GET_SW"
	DI = 0B06h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0B07-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_STOP_SW"
	DI = 0B07h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0B08-----------------------
INT 60 u - HP 95LX System Manager - "M_TELLTIME" - DISPLAY TIMESTAMP
	DI = 0B08h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	timestamp format (see below)
		WORD	row (-3 is topmost, 0 is first non-reserved line)
		WORD	column
Return: ???
	STACK unchanged

Bitfields for timestamp format:
 bits 1-0  timestamp components
	00 date only
	01 time only
	10 date and time
	11 day and date
 bit 4	supply am/pm
 bit 5	supply seconds
 bit 6	show year
 bit 7	four-digit year
--------b-60----DI0B09-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_GET_SETTINGS"
	DI = 0B09h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B0Ah,INT 60/DI=0B0Fh

Format of system settings:
Offset	Size	Description
 00h	WORD	country code
 02h	WORD	speaker volume (00h-03h or FFh for off)
 04h	WORD	contrast level (00h-0Fh)
 06h	WORD	week start (00h Sunday, 01h Monday)
 08h	WORD	punctuation format
		code	decimal arg	thousands
		00h	.	,	,
		01h	,	.	.
		02h	.	;	;
		03h	,	;	.
		04h	.	,	" "
		05h	,	.	" "
		06h	.	;	" "
		07h	,	;	" "
 0Ah	WORD	two-character language code (only 5355h = "US" byte-swapped)
 0Ch	WORD	current date format (see below)
 0Eh	WORD	current time format (see below)
 10h	WORD	collating sequence
		00h numbers first, 01h letters first, 02h ASCII
 12h 80 BYTEs	name of picture file
 62h 30 BYTEs	name
 80h 30 BYTEs	title
 9Eh 28 BYTEs	company name
 BAh	WORD	number of languages
 BCh  6 BYTEs	available languages
 C2h 66 BYTEs	language menu
104h  2 BYTEs	ASCIZ date separator
106h  2 BYTEs	ASCIZ time separator
108h	BYTE	date order
109h	BYTE	use 24 hour time?
10Ah 16 BYTEs	currency string
11Ah	WORD	currency string position (00h prefix, 01h suffix)
11Ch	WORD	keyboard (see below)
11Eh	WORD	printer baud rate
		00h 300, 01h 1200, 02h 2400, 03h 4800, 04h 9600, 05h 19200
120h	WORD	printer driver code
		00h Epson FX80, 01h HP Laserjet, 02h IBM ProPrinter
122h	WORD	printer interface (00h COM1, 01h COM2, 02h IR, 03h LPT1)
124h	WORD	system manager interrupt (60h by default)
126h	WORD	code page (01h CP850, 02h CP437)
128h	WORD	active exit key
12Ah	WORD	active menu key
12Ch	WORD	active CHAR key toggle
12Eh  6 BYTEs	alarm

Values for current date format:
 00h	dd-mmm-yy
 01h	dd-mmm
 02h	mmm-yy
 03h	mm/dd/yy
 04h	dd/mm/yy
 05h	dd.mm.yy
 06h	yy-mm-dd
 07h	mm/dd
 08h	dd/mm
 09h	dd.mm
 0Ah	mm-dd

Values for current time format:
 00h	HH:MM:SS am/pm
 01h	HH:MM am/pm
 02h	HH:MM:SS
 03h	HH.MM.SS
 04h	HH,MM,SS
 05h	HHhMMmSSs
 06h	HH:MM
 07h	HH.MM
 08h	HH,MM
 09h	HHhMMm

Values for keyboard:
 0001h	Belgium
 0002h	French Canadian
 0004h	Denmark
 0008h	Finland
 0010h	French
 0020h	Finland
 0040h	Italy
 0080h	Netherlands
 0100h	Norway
 0200h	Portugal
 0400h	Spain
 0800h	Sweden
 1000h	Swiss French
 2000h	Swiss German
 4000h	United Kingdom
 8000h	USA
--------b-60----DI0B0A-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_SET_SETTINGS"
	DI = 0B0Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B09h
--------b-60----DI0B0B-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_START_TIMER"
	DI = 0B0Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B0Ch,INT 60/DI=0B0Dh
--------b-60----DI0B0C-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_STOP_TIMER"
	DI = 0B0Ch
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B0Bh,INT 60/DI=0B0Dh
--------b-60----DI0B0D-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_GET_TIMER"
	DI = 0B0Dh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B0Bh,INT 60/DI=0B0Ch
--------b-60----DI0B0E-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_TELL_ANYTIME"
	DI = 0B0Eh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
		WORD	???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: DX:AX -> ???
	STACK unchanged
--------b-60----DI0B0F-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVCE "M_GET_SETTINGS_ADDR"
	DI = 0B0Fh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: DX:AX -> system settings record (see INT 60/DI=0B09h)
	STACK unchanged
SeeAlso: INT 60/DI=0B09h
--------b-60----DI0B10-----------------------
INT 60 u - HP 95LX System Manager - PARSE DATE SPECIFICATION
	DI = 0B10h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0B11-----------------------
INT 60 u - HP 95LX System Manager - PARSE TIME SPECIFICATION
	DI = 0B11h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0B12-----------------------
INT 60 u - HP 95LX System Manager - SET DATE PARSING RULE
	DI = 0B12h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	new parsing rule (see below)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B13h

Values for new parsing rule:
 01h	day-month-year
 02h	month-day-year
 03h	year-month-day
 04h	"DMYO"
 05h	"MDYO"
 OR with 08h to get any year
--------b-60----DI0B13-----------------------
INT 60 u - HP 95LX System Manager - SET TIME PARSING RULE
	DI = 0B13h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	new parsing rule (see below)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B12h

Values for new parsing rule:
 01h	HH:MM:SS (am/pm)
 02h	HH:MM:SS (24hr)
 03h	HHMM:SS (24hr)
 04h	HH:MM:SS.hh (24hr)
 05h	HH:MM (am/pm)
 06h	HH:MM (24hr)
 07h	HHMM (24hr)
--------b-60----DI0B14-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_POST_TIME"
	DI = 0B14h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
--------b-60----DI0B15-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_DAY_TRIGGER"
	DI = 0B15h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
--------b-60----DI0C00-----------------------
INT 60 u - HP 95LX System Manager - OPEN PRINTER
	DI = 0C00h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0C01h,INT 60/DI=0C02h,INT 60/DI=0C03h
--------b-60----DI0C01-----------------------
INT 60 u - HP 95LX System Manager - CLOSE PRINTER
	DI = 0C01h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
Note:	relinquishes control of printer
SeeAlso: INT 60/DI=0C00h
--------b-60----DI0C02-----------------------
INT 60 u - HP 95LX System Manager - WRITE TO PRINTER
	DI = 0C02h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to data to be written
		WORD	length of data
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0C00h
--------b-60----DI0C03-----------------------
INT 60 u - HP 95LX System Manager - INITIALIZE PRINTER
	DI = 0C03h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0C00h
--------b-60----DI0C04-----------------------
INT 60 u - HP 95LX System Manager - "M_TRANS_PRINTER"
	DI = 0C04h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0C05-----------------------
INT 60 u - HP 95LX System Manager - "M_FALL_PRINTER"
	DI = 0C05h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
--------b-60----DI0E00-----------------------
INT 60 u - HP 95LX System Manager - COMMUNICATIONS SERVICE "M_COMM_INIT"
	DI = 0E00h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E01h,INT 60/DI=0E02h

Values for error code:
 0000h	successful
 FFF1h	"E_BUSY"
 FFF2h	timeout
 FFF3h	framing error
 FFF4h	parity error
 FFF5h	overrun error
 FFF6h	"E_EMPTY"
 FFF7h	"E_CONECT"
 FFF8h	not open
 FFF9h	out of memory
 FFFAh	buffer overflow
 FFFBh	"E_NOFIT"
 FFFCh	unsupported
 FFFDh	"E_IVOPR"
 FFFEh	"E_IVCHN"
 FFFFh	"E_REOPEN"
--------b-60----DI0E01-----------------------
INT 60 u - HP 95LX System Manager - OPEN COMMUNICATIONS CHANNEL
	DI = 0E01h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to WORD buffer for comm channel handle
		WORD	communications line number (01h-04h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E00h,INT 60/DI=0E02h
--------b-60----DI0E02-----------------------
INT 60 u - HP 95LX System Manager - CLOSE COMMUNICATIONS CHANNEL
	DI = 0E02h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	comm channel handle
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E00h,INT 60/DI=0E01h
--------b-60----DI0E03-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_GETMDM"
	DI = 0E03h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0E04-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_ANSWER"
	DI = 0E04h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0E05-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_DIAL"
	DI = 0E05h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0E06-----------------------
INT 60 u - HP 95LX System Manager - RESET COMMUNICATIONS CHANNEL
	DI = 0E06h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	comm channel handle
		WORD	reset options (see below)
Return: ???
	STACK unchanged

Bitfields for reset options:
 bit 0	reset line
 bit 1	flush transmit buffer
 bit 2	flush receive buffer
 bit 3	reset modem
 bit 4	reset receiver's ^S state
 bit 5	reset transmitter's ^S state
--------b-60----DI0E07-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_HANGUP"
	DI = 0E07h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0E08-----------------------
INT 60 u - HP 95LX System Manager - SEND DATA OVER COMM CHANNEL
	DI = 0E08h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	comm channel handle
		DWORD	pointer to data to be sent
		WORD	option flags
			bit 0: send partial buffer
			bit 1: turn on receiver after sending
		DWORD	pointer to WORD containing length of data to be sent
Return: length WORD updated to contain number of bytes actually sent???
	STACK unchanged
SeeAlso: INT 60/DI=0E09h,INT 60/DI=0E0Bh
--------b-60----DI0E09-----------------------
INT 60 u - HP 95LX System Manager - QUERY COMM CHANNEL TRANSMIT QUEUE
	DI = 0E09h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ??? WORD
		DWORD	pointer to ??? WORD
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E0Ah
--------b-60----DI0E0A-----------------------
INT 60 u - HP 95LX System Manager - QUERY COMM CHANNEL RECEIVE QUEUE
	DI = 0E0Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	comm channel handle
		DWORD	pointer to WORD to get receive buffer size
		DWORD	pointer to WORD to get free bytes in receive buffer
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E09h,INT 60/DI=0E0Bh
--------b-60----DI0E0B-----------------------
INT 60 u - HP 95LX System Manager - RECEIVE DATA FROM COMM CHANNEL
	DI = 0E0Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	comm channel handle
		DWORD	pointer to data buffer
		DWORD	pointer to WORD (input) length of data buffer
					(output) number of bytes received
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E08h,INT 60/DI=0E0Ah
--------b-60----DI0E0C-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_HAZCMD"
	DI = 0E0Ch
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0E0D-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_COMAND"
	DI = 0E0Dh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0E0E-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_BREAK"
	DI = 0E0Eh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0E0F-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_FRCXON"
	DI = 0E0Fh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0E10-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_FRCXOF"
	DI = 0E10h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0E11-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_SETDTR"
	DI = 0E11h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0E12-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_XMITNG"
	DI = 0E12h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0E13-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_STATUS"
	DI = 0E13h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0E14-----------------------
INT 60 u - HP 95LX System Manager - SET COMMUNICATIONS SETTINGS
	DI = 0E14h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	comm channel handle
		DWORD	pointer to comm settings (see below)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E15h

Format of comm settings:
Offset	Size	Description
 00h	BYTE	dial type ('T' tone, 'P' pulse)
 01h	WORD	baud rate divisor (115200/baud_rate)
 03h	BYTE	parity (00h none, 08h odd, 18h even, 28h mark, 38h space)
 04h	BYTE	stop bits (00h one, 04h two)
 05h	BYTE	data bits - 5
 06h	BYTE	software handshake
		01h none, 02h XOFF/XON, 04h XOFF/any, 08h ENQ/ACK
 07h	BYTE	infrared (01h off, 02h on)
 08h	BYTE	duplex (01h half, 02h full)
 09h	BYTE	echo (01h echo, 02h no echo)
--------b-60----DI0E15-----------------------
INT 60 u - HP 95LX System Manager - GET COMMUNICATIONS SETTINGS
	DI = 0E15h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to buffer for settings (see INT 60/DI=0E14h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E14h
--------b-60----DI0E16-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_CNFGUR"
	DI = 0E16h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
		WORD	???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI0E17-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_QRYERR"
	DI = 0E17h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
--------b-60----DI0F00-----------------------
INT 60 u - HP 95LX System Manager - "M_ERRMSG"
	DI = 0F00h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0F01-----------------------
INT 60 u - HP 95LX System Manager - DRAW STANDARD TITLE BOX
	DI = 0F01h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ASCIZ title string
Return: ???
	STACK unchanged
--------b-60----DI0F02-----------------------
INT 60 u - HP 95LX System Manager - "SHOWNAME"
	DI = 0F02h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI0F03-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY TWO-LINE MESSAGE BOX
	DI = 0F03h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to first line of message
		WORD	length of first line
		DWORD	pointer to second line of message
		WORD	length of second line
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0300h,INT 60/DI=0F04h,INT 60/DI=0F09h
--------b-60----DI0F04-----------------------
INT 60 u - HP 95LX System Manager - REMOVE MESSAGE BOX
	DI = 0F04h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0F03h,INT 60/DI=0F09h
--------b-60----DI0F05-----------------------
INT 60 u - HP 95LX System Manager - "M_COM_TIMER_ADDR"
	DI = 0F05h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: DX:AX -> ???
	STACK unchanged
--------b-60----DI0F06-----------------------
INT 60 u - HP 95LX System Manager - "M_COM_TIMER_COUNT_ADDR"
	DI = 0F06h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: DX:AX -> ???
	STACK unchanged
--------b-60----DI0F07-----------------------
INT 60 u - HP 95LX System Manager - "M_SYS_RSRC_ADDR"
	DI = 0F07h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: DX:AX -> ???
	STACK unchanged
--------b-60----DI0F08-----------------------
INT 60 u - HP 95LX System Manager - "M_BIOS_OUTSTR"
	DI = 0F08h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI0F09-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY THREE-LINE MESSAGE BOX
	DI = 0F09h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to first line of message
		WORD	length of first line
		DWORD	pointer to second line of message
		WORD	length of second line
		DWORD	pointer to third line of message
		WORD	length of third line
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0F03h,INT 60/DI=0F04h
--------b-60----DI0F0A-----------------------
INT 60 u - HP 95LX System Manager - DISABLE MACROS
	DI = 0F0Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0F0Bh
--------b-60----DI0F0B-----------------------
INT 60 u - HP 95LX System Manager - ENABLE MACROS
	DI = 0F0Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0F0Ah
--------b-60----DI0F0C-----------------------
INT 60 u - HP 95LX System Manager - "M_DATE_TIME_SEPS"
	DI = 0F0Ch
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI0F0D-----------------------
INT 60 u - HP 95LX System Manager - "M_FORM_FT"
	DI = 0F0Dh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: DX:AX -> ???
	STACK unchanged
--------b-60----DI0F0E-----------------------
INT 60 u - HP 95LX System Manager - "M_RAM_IV_INFO"
	DI = 0F0Eh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: DX:AX -> ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
--------b-60----DI1005-----------------------
INT 60 u - HP 95LX System Manager - "M_DIRTY_SYNC" - FORCE SCREEN UPDATE
	DI = 1005h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 10/AH=FFh,INT 60/DI=0300h,INT 60/DI=0301h
--------b-60----DI1200-----------------------
INT 60 u - HP 95LX System Manager - RESOURCE SERVICE "MAP_RESOURCE_FILE"
	DI = 1200h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI1201-----------------------
INT 60 u - HP 95LX System Manager - "GET_RESOURCE_PTR"
	DI = 1201h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: DX:AX -> ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
--------b-60----DI1202-----------------------
INT 60 u - HP 95LX System Manager - "GET_RSRC_TAB_PTR"
	DI = 1202h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: DX:AX -> ???
	STACK unchanged
--------b-60----DI1203-----------------------
INT 60 u - HP 95LX System Manager - "INIT_SYSGMR_RSRCS"
	DI = 1203h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
--------b-60----DI1300-----------------------
INT 60 u - HP 95LX System Manager - INITIALIZE HELP SYSTEM
	DI = 1300h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI1301-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY HELP
	DI = 1301h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
--------b-60----DI1302-----------------------
INT 60 u - HP 95LX System Manager - "M_HELP_KEY"
	DI = 1302h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI1303-----------------------
INT 60 u - HP 95LX System Manager - "M_HELP_TERM"
	DI = 1303h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
--------b-60----DI1400-----------------------
INT 60 u - HP 95LX System Manager - "M_ColInit"
	DI = 1400h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: AX = ???
	STACK unchanged
--------b-60----DI1401-----------------------
INT 60 u - HP 95LX System Manager - "M_ColCpStr"
	DI = 1401h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI1402-----------------------
INT 60 u - HP 95LX System Manager - "M_ColLicsStr"
	DI = 1402h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI1403-----------------------
INT 60 u - HP 95LX System Manager - "M_ColLicsChar"
	DI = 1403h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI1404-----------------------
INT 60 u - HP 95LX System Manager - "M_ColToLower"
	DI = 1404h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI1405-----------------------
INT 60 u - HP 95LX System Manager - "M_ColCpSearch"
	DI = 1405h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		DWORD	pointer to ???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
--------b-60----DI1406-----------------------
INT 60 u - HP 95LX System Manager - "M_ColToUpper"
	DI = 1406h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
--------b-60----DI1500-----------------------
INT 60 u - HP 95LX System Manager - "GrDispInit"
	DI = 1500h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI1501-----------------------
INT 60 u - HP 95LX System Manager - "GrDispClear"
	DI = 1501h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI1502-----------------------
INT 60 u - HP 95LX System Manager - "GrDispDot"
	DI = 1502h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI1503-----------------------
INT 60 u - HP 95LX System Manager - "GrDispDraw"
	DI = 1503h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI1504-----------------------
INT 60 u - HP 95LX System Manager - "GrDispFill"
	DI = 1504h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI1505-----------------------
INT 60 u - HP 95LX System Manager - "GrDispRead"
	DI = 1505h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI1506-----------------------
INT 60 u - HP 95LX System Manager - "GrDispString"
	DI = 1506h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI1507-----------------------
INT 60 u - HP 95LX System Manager - "GrDispPan"
	DI = 1507h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI1508-----------------------
INT 60 u - HP 95LX System Manager - "GrDispZoom"
	DI = 1508h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI1509-----------------------
INT 60 u - HP 95LX System Manager - "GrDispSave"
	DI = 1509h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI150A-----------------------
INT 60 u - HP 95LX System Manager - "GrDispRestore"
	DI = 150Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
--------b-60----DI150B-----------------------
INT 60 u - HP 95LX System Manager - "GrDispCorner"
	DI = 150Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
--------b-60----DI1604-----------------------
INT 60 u - HP 95LX System Manager - "CP_TO_LICS"
	DI = 1604h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
--------G-6000-------------------------------
INT 60 - SYS_PROF.EXE - PROFILER STATUS
	AH = 00h
Return: AX = 0000h    profiling is off
	    otherwise profiling is on
Note:	SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
SeeAlso: AH=01h"SYS_PROF",02h"SYS_PROF"
--------G-6000-------------------------------
INT 60 - MDEBUG - GET STATUS
	AH = 00h
	DS:SI -> password or a null byte
Return: AX = return code
	    FFFEh password is invalid
	    FFFDh display mode is invalid
	   else successful
		ES = value of the monitor register SE
		DI = value of the monitor register OF
		CH = monitor color
		CL = interpreter color
		BH = monitor start line
		BL = interpreter start line
		AH = makecode of the hotkey
		AL = ASCII code of the hotkey
		DL = status of special keys (only SHIFT, ALT, CTRL) for the
			hotkey (coded as for the keyboard flag at 0040h:0017h)
		DH = basic process number for the communication with drivers
			process number for the display driver, DH+1 = process
			number for the command driver(s)
	DS:SI -> MDEBUG identification table
Program: MDEBUG is a shareware memory-resident debugging tool by Bernd
	  Schemmer, including a memory monitor, an interpreter, and a
	  disassembler
Notes:	MDEBUG uses INT 60 by default, but may be directed to any of INT 60
	  through INT 67; the interrupt handler is preceded by the signature
	  "USERINT" and is not chained
	if DS:SI points at a null byte, MDEBUG will prompt for a password if
	  passwords are active; enough stack space must be provided for an
	  INT 10h call (which MDEBUG uses while prompting for the password)
SeeAlso: AH=02h"MDEBUG"
Index:	hotkeys;MDEBUG

Format of MDEBUG identification table:
Offset	Size	Description
 -2	WORD	entry offset
 00h	WORD	CS of MDEBUG
 02h	DWORD	old INT 08h vector
 06h	DWORD	old INT 09h vector
 0Ah	DWORD	address INT 16h routine used by MDEBUG
 0Eh	BYTE	length of version string
 0Fh  N BYTEs	version string
--------G-6001-------------------------------
INT 60 - MDEBUG - GET ADDRESS OF THE HELP REGISTERS
	AH = 01h
	DS:SI -> password or a null byte
Return: AX = return code
	    FFFEh password is invalid
	    FFFDh display mode is invalid
	   else successful
		ES:DI point to the help registers of MDEBUG
	       ES:DI-02h  -> R0 (WORD)
	       ES:DI	  -> R1 (WORD)
	       ES:DI+02h  -> R2 (WORD)
	       ES:DI+04h  -> R3 (WORD)
	       ...
	       ES:DI+0Eh  -> R8 (WORD)
--------G-6001-------------------------------
INT 60 - SYS_PROF.EXE - TURN PROFILING OFF
	AH = 01h
Note:	SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
SeeAlso: AH=00h"SYS_PROF",02h"SYS_PROF"
--------N-6001FF-----------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - GET DRIVER INFO
	AX = 01FFh
	BX = handle returned by function 02h
Return: CF set on error
	    DH = error code (see below)
	CF clear if successful
	    BX = version
	    CH = network interface class (see below)
	    DX = interface type (see below)
	    CL = number
	    DS:SI -> name
	    AL = driver functions supported
		01h basic
		02h basic and extended
		05h basic and high-performance
		06h basic, high-performance, and extended
		FFh not installed
Note:	the handle in BX is optional for drivers written to v1.07 or later of
	  the packet driver specification

Values for error code:
 01h "BAD_HANDLE"	invalid handle number
 02h "NO_CLASS"		no interfaces of the specified class found
 03h "NO_TYPE"		no interfaces of the specified type found
 04h "NO_NUMBER"	no interfaces of the specified number found
 05h "BAD_TYPE"		bad packet type
 06h "NO_MULTICAST"	interface does not support multicast messages
 07h "CANT_TERMINATE"	this packet driver cannot terminate
 08h "BAD_MODE"		invalid receiver mode
 09h "NO_SPACE"		insufficient space
 0Ah "TYPE_INUSE"	type accessed but never released
 0Bh "BAD_COMMAND"	bad command
 0Ch "CANT_SEND"	packet could not be sent
 0Dh "CANT_SET"		hardware address could not be changed
 0Eh "BAD_ADDRESS"	hardware address has a bad length or format
 0Fh "CANT_RESET"	could not reset interface

Values for Network Interface classes/types:
    Class 01h  Ethernet/IEEE 802.3
	01h 3COM 3C500/3C501
	02h 3COM 3C505
	03h MICOM-Interlan NI5010
	04h BICC Data Networks 4110
	05h BICC Data Networks 4117
	06h MICOM-Interlan NP600
	08h Ungermann-Bass PC-NIC
	09h Univation NC-516
	0Ah TRW PC-2000
	0Bh MICOM-Interlan NI5210
	0Ch 3COM 3C503
	0Dh 3COM 3C523
	0Eh Western Digital WD8003
	0Fh Spider Systems S4
	10h Torus Frame Level
	11h 10Net Communications
	12h Gateway PC-bus
	13h Gateway AT-bus
	14h Gateway MCA-bus
	15h IMC PCnic
	16h IMC PCnic II
	17h IMC PCnic 8-bit
	18h Tigan Communications
	19h Micromatic Research
	1Ah Clarkson "Multiplexor"
	1Bh D-Link 8-bit
	1Ch D-Link 16-bit
	1Dh D-Link PS/2
	1Eh Research Machines 8
	1Fh Research Machines 16
	20h Research Machines MCA
	21h Radix Microsystems EXM1 16-bit
	22h Interlan Ni9210
	23h Interlan Ni6510
	24h Vestra LANMASTER 16-bit
	25h Vestra LANMASTER 8-bit
	26h Allied Telesis PC/XT/AT
	27h Allied Telesis NEC PC-98
	28h Allied Telesis Fujitsu FMR
	29h Ungermann-Bass NIC/PS2
	2Ah Tiara LANCard/E AT
	2Bh Tiara LANCard/E MC
	2Ch Tiara LANCard/E TP
	2Dh Spider Communications SpiderComm 8
	2Eh Spider Communications SpiderComm 16
	2Fh AT&T Starlan NAU
	30h AT&T Starlan-10 NAU
	31h AT&T Ethernet NAU
	32h Intel smart card
	33h Xircom Packet Adapter
	34h Aquila Ethernet
	35h Novell NE1000
	36h Novell NE2000
	37h SMC PC-510
	38h AT&T Fiber NAU
	39h NDIS to Packet Driver adapter
	3Ah Racal-InterLan ES3210
	3Bh General Systems ISDN simulated Ethernet
	3Ch Hewlett-Packard
	3Dh IMC EtherNic-8
	3Eh IMC EtherNic-16
	3Fh IMC EtherNic-MCA
	40h NetWorth EtherNext
	41h Dataco Scanet
	42h DEC DEPCA
	43h C-Net
	44h Gandalf LANLine
	45h Apricot built-in
	46h David Systems Ether-T
	47h ODI to Packet Driver adapter
	48h AMD Am21110-16
	49h Intel ICD Network controller family
	4Ah Intel ICD PCL2
	4Bh Intel ICD PCL2A
	4Ch AT&T LANPacer
	4Dh AT&T LANPacer+
	4Eh AT&T EVB
	4Fh AT&T StarStation
	50h SLIP simulated ethernet
	51h Racal-Interlan NIA310
	52h Racal-Interlan NISE
	53h Racal-Interlan NISE30
	54h Racal-Interlan NI6610
	55h Ethernet over IP/UDP
	56h ICL EtherTeam 16
	57h David Systems
	58h NCR WaveLAN
	59h Thomas Contrad TC5045
	5Ah Russ Nelson's Parallel Port driver
	5Bh Intell EtherExpress 16
	5Ch IBMTOKEN
	5Dh Zenith Z-Note
	5Eh 3Com 3C509
	5Fh Mylex LNE390
	60h Madge Smart Ringnode
	61h Novell NE2100
	62h Allied Telesis 1500
	63h Allied Telesis 1700
	64h Fujitsu EtherCoupler
    Class 02h  ProNET-10
	01h Proteon p1300
	02h Proteon p1800
    Class 03h  IEEE 802.5/ProNet-4 (without expanded RIFs)
	01h IBM Token-Ring Adapter
	02h Proteon p1340
	03h Proteon p1344
	04h Gateway PC-bus
	05h Gateway AT-bus
	06h Gateway MCA-bus
	07h Madge board
	39h NDIS to Packet Driver adapter
	47h ODI to Packet Driver adapter
    Class 04h  Omninet
    Class 05h  Appletalk
	01h ATALK.SYS adapter
    Class 06h  Serial Line
	01h Clarkson 8250-SLIP
	02h Clarkson "Multiplexor"
	03h Eicon Technologies
    Class 07h  StarLAN (subsumed by Ethernet class)
    Class 08h  ARCnet
	01h Datapoint RIM
    Class 09h  AX.25
	01h Ottawa PI card
	02h Eicon Technologies
    Class 0Ah  KISS
    Class 0Bh  IEEE 802.3 with 802.2 headers
	types same as for class 01h
    Class 0Ch  FDDI with 802.2 headers
	01h Western Digital
	02h Frontier Technology
    Class 0Dh  Internet X.25
	01h Western Digital
	02h Frontier Technology
	03h Emerging Technologies
	04h The Software Forge
	05h Link Data Intelligent X.25
	06h Eicon Technologies
    Class 0Eh  N.T. LANSTAR (encapsulating DIX Ethernet)
	01h NT LANSTAR/8
	02h NT LANSTAR/MC
    Class 0Fh  SLFP (MIT serial specification)
	01h MERIT
    Class 10h  PPP (Point-to-Point Protocol)
	01h 8250/16550 UART
	02h Niwot Networks synch
	03h Eicon Technologies
    Class 11h  802.5 with expanded RIFs
	types same as for class 3
    Class 12h  reserved for LCP/NCPs
Note: class and type numbers are cleared through FTP Software
--------G-6002-------------------------------
INT 60 - MDEBUG - SET STATUS
	AH = 02h
	DS:SI -> password or a null byte
	ES = new value for the register SE
	DI = new value for the register OF
	CH = new monitor color if nonzero
	CL = new interpreter color if nonzero
	BH = new monitor start line if nonzero
	BL = new interpreter start line if nonzero
	AL = new ASCII code for the hotkey ('A'..'Z', 'a'..'z') if nonzero
	DL = new status of the special keys (SHIFT, ALT, CTRL) for the hotkey
	    if nonzero
	DH = if nonzero, new basic process number for communication with the
	    drivers (DH = multiplex number for the display driver,
	    DH+1 = multiplex number for the command driver or drivers)
Return: AX = return code
	    FFFFh call not allowed
	    FFFEh password is invalid
	    FFFDh display mode is invalid
	    0000h successful, status changed
	   else AL = error reasons (see below)
Note:	the values of the registers SE and OF are always changed, the other
	  values are only changed if they are valid
SeeAlso: AH=00h"MDEBUG"
Index:	hotkeys;MDEBUG

Bitfields for error reasons:
 bit 0	invalid monitor start line
 bit 1	invalid interpreter start line
 bit 2	invalid hotkey
 bit 3	invalid process number
 bits 4-7 reserved
--------N-6002-------------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - ACCESS TYPE
	AH = 02h
	AL = interface class
	BX = interface type
	DL = interface number
	DS:SI -> type
	CX = length of type (0000h for all packets)
	ES:DI -> receiver
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
	    AX = handle
SeeAlso: AH=03h"FTP"

Receiver is called with:
	AX = subfunction
	    00h get packet buffer
		DX = lookahead length (v1.10+)
		DS:SI -> lookahead buffer if DX nonzero (v1.10+)
		DI = error flags (class dependent) (v1.10+)
		Return: ES:DI -> packet buffer
				0000h:0000h means throw away packet
			CX = size of buffer (v1.10+), may be smaller than
				incoming data
	    01h copy completed
		DS:SI -> buffer
		CX = bytes actually copied (v1.10+)
	BX = handle
	CX = buffer length
when a packet is received
--------G-6002-------------------------------
INT 60 - SYS_PROF.EXE - TURN PROFILING ON
	AH = 02h
Note:	SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
SeeAlso: AH=00h"SYS_PROF",01h"SYS_PROF"
--------G-6003-------------------------------
INT 60 - MDEBUG - POP UP
	AH = 03h
	DS:SI -> password or a null byte
	ES -> new value for the register SE
	DI -> new value for the register OF
Return: AX = return code
	    FFFFh call not allowed
	    FFFEh password is invalid
	    FFFDh display mode is invalid
	   else successful
SeeAlso: AH=04h"MDEBUG"
--------N-6003-------------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - RELEASE TYPE
	AH = 03h
	BX = handle
Return: CF set on error
	   DH = error code (see AX=01FFh)
	CF clear if successful
SeeAlso: AH=02h"FTP"
--------G-6003-------------------------------
INT 60 - SYS_PROF.EXE - GET ADDRESS OF PROFILING TABLE
	AH = 03h
Return: ES:BX -> profiling table
Note:	SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
SeeAlso: AH=04h"SYS_PROF"
--------N-6004-------------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - SEND PACKET
	AH = 04h
	DS:SI -> buffer
	CX = length
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
Note:	the buffer may be modified immediately upon return from this call
SeeAlso: AH=0Bh
--------G-6004-------------------------------
INT 60 - MDEBUG - POP UP
	AH = 04h
	DS:SI -> password or a null byte
Return: AX = return code
	    FFFFh call not allowed
	    FFFEh password is invalid
	    FFFDh display mode is invalid
	   else successful
SeeAlso: AH=03h"MDEBUG",AH=07h"MDEBUG"
--------G-6004-------------------------------
INT 60 - SYS_PROF.EXE - CLEAR PROFILING TABLE
	AH = 04h
Note:	SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
SeeAlso: AH=03h"SYS_PROF"
--------N-6005-------------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - TERMINATE DRIVER FOR HANDLE
	AH = 05h
	BX = handle (optional for v1.10+)
Return: CF set on error
	   DH = error code (see AX=01FFh)
	CF clear if successful
--------G-6005-------------------------------
INT 60 - MDEBUG - GET AND SET MDEBUG FLAGS
	AH = 05h
	DS:SI -> password or a null byte
	BL = new value for the semaphor of MDEBUG
	     00h  enable popup of MDEBUG
	     else disable popup of MDEBUG
Return: AX = return code
	    FFFEh password is invalid
	    FFFDh display mode is invalid
	   else successful
		BL = old value of the semaphor of MDEBUG
		BH = old value of the INT 08h semaphor
		    (this semaphor is always reset after this function)
--------N-6006-------------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - GET ADDRESS
	AH = 06h
	BX = handle (optional for v1.10+)
	ES:DI -> buffer
	CX = length
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
	    CX = length
Note:	copies the local net address associated with the handle into the buffer
--------G-6006-------------------------------
INT 60 - MDEBUG - GET PASSWORD STATUS
	AH = 06h
Return: AL = status
	    00h password inactive
	    01h password active
--------N-6007-------------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - RESET INTERFACE
	AH = 07h
	BX = handle (optional for v1.10+)
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
--------G-6007-------------------------------
INT 60 - MDEBUG v1.70+ - GET ACTIVE PART OF MDEBUG
	AH = 07h
Return: AL = active part for the next popup session of MDEBUG:
	    bit 0: the next popup session will start in the interpreter rather
			than in the monitor
	    bit 1: the next popup session will sart in the online-help
SeeAlso: AH=03h"MDEBUG",AH=04h"MDEBUG"
--------G-6008-------------------------------
INT 60 - MDEBUG - UNUSED
	AH = 08h-FFh
Return: AX = FFFCh
--------N-600A-------------------------------
INT 60 - FTP Packet Driver 1.09+ - HIGH-PERF FUNC - GET PARAMETERS
	AH = 0Ah
Return: CF set on error
	    DH = error code (0Bh) (see AX=01FFh)
	CF clear if successful
	    ES:DI -> parameter table (see below)

Format of parameter table:
Offset	Size	Description
 00h	BYTE	major revision of packet driver spec driver conforms to
 01h	BYTE	minor revision of packet driver spec
 02h	BYTE	length of this structure in bytes
 03h	BYTE	length of a MAC-layer address
 04h	WORD	maximum transfer unit, including MAC headers
 06h	WORD	buffer size for multicast addr
 08h	WORD	number of receive buffers (one less than back-to-back MTU rcvs)
 0Ah	WORD	number of transmit buffers
 0Ch	WORD	interrupt number to hook for post-EOI processing, 00h=none
--------N-600B-------------------------------
INT 60 - FTP Packet Driver 1.09 - HIGH-PERF FUNC - ASYNCHRONOUS SEND PACKET
	AH = 0Bh
	DS:SI -> buffer
	CX = length of buffer
	ES:DI -> FAR function to call when buffer becomes available
Return: CF set on error
	    DH = error code (0Bh,0Ch) (see AX=01FFh)
	CF clear if successful
Notes:	unlike function 04h, the buffer is not available for modification as
	  soon as the call returns; the buffer may be queued by the driver and
	  not processed until later
	this function has been dropped from v1.10+ of the specification and
	  replaced by function 0Ch
SeeAlso: AH=04h"Packet Driver",AH=0Ch"Packet Driver"

Completion function called with:
	AX = result
	    00h copy OK
	    nonzero error
	ES:DI -> buffer passed to INT 60/AH=0Bh call
--------N-600C-------------------------------
INT 60 - FTP Packet Driver 1.10+ - HIGH-PERF FUNC - ASYNCHRONOUS SEND PACKET
	AH = 0Ch
	ES:DI -> pointer to IOCB
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
SeeAlso: AH=04h"Packet Driver",AH=0Bh"Packet Driver"

Format of IOCB:
Offset	Size	Description
 00h	DWORD	pointer to buffer
 04h	WORD	length of buffer
 06h	BYTE	flags
		bit 0: packet driver is finished with IOCB
		bit 1: application requests upcall when driver completes
 07h	DWORD	function address for upcall
 0Bh  4 BYTEs	future gather write
 0Fh	BYTE	???
 10h  8 BYTEs	private driver workspace

Completion function called with:
	ES:DI -> IOCB passed to INT 60/AH=0Ch
--------N-600C-------------------------------
INT 60 - Banyan VINES, 3com - GET STATION ADDRESS
	AH = 0Ch
Return: AL = status
	    00h successful
		ES:SI -> 6-byte station address
	    02h semaphore service is unavailable
--------N-600D-------------------------------
INT 60 - FTP Packet Driver 1.10+ - HIGH-PERF FUNC - DROP PACKET FROM QUEUE
	AH = 0Dh
	ES:DI -> IOCB
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
SeeAlso: AH=0Ch"Packet Driver"
--------N-6011-------------------------------
INT 60 - 3com, 10NET, Banyan VINES - LOCK AND WAIT
	AH = 11h
	AL = drive number or 0
	DX = number of seconds to wait
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see below)
SeeAlso: AH=12h,AH=13h

Values for status:
 00h	successful
 01h	timeout
 02h	server not responding
 03h	invalid semaphore name
 04h	semaphore list is full
 05h	invalid drive ID
 06h	invalid Ethernet address
 07h	not logged in
 08h	write to network failed
 09h	semaphore already logged for this CPU
--------N-6012-------------------------------
INT 60 - 3com, 10NET, Banyan VINES - LOCK
	AH = 12h
	AL = drive number or 00h
	ES:SI = Ethernet address or 0000h:0000h
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see also AH=11h)
	    01h semaphore currently locked by another PC
Note:	unlike function 11h, this function returns immediately
SeeAlso: AH=11h,AH=13h
--------N-6013-------------------------------
INT 60 - 3com, 10NET, Banyan VINES - UNLOCK
	AH = 13h
	AL = drive number or 00h
	ES:SI = Ethernet address or 0000h:0000h
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see also AH=11h)
	    01h semaphore not locked
SeeAlso: AH=11h,AH=12h
--------N-6014-------------------------------
INT 60 - FTP Packet Driver - EXTENDED FUNC - SET RECEIVE MODE
	AH = 14h
	BX = handle (optional for v1.10+)
	CX = mode
	    01h turn off receiver
	    02h receive only packets sent to this interface
	    03h mode 2 plus broadcast packets
	    04h mode 3 plus limited multicast packets
	    05h mode 3 plus all multicast packets
	    06h all packets
	    07h raw mode for serial line only (v1.10+)
Return: CF set on error
	   DH = error code (01h,08h) (see AX=01FFh)
	CF clear if successful
SeeAlso: AH=15h
--------N-6015-------------------------------
INT 60 - FTP Packet Driver - EXTENDED FUNC - GET RECEIVE MODE
	AH = 15h
	BX = handle (optional for v1.10+)
Return: CF set on error
	    DH = error code (01h) (see AX=01FFh)
	CF clear if successful
	    AX = mode
SeeAlso: AH=14h
--------N-6016-------------------------------
INT 60 - FTP Packet Driver - EXTENDED FUNC - SET MULTICAST LIST
	AH = 16h
	ES:DI -> multicast list
	CX = length of list in bytes
Return: CF set on error
	    DH = error code (06h,09h,0Eh) (see AX=01FFh)
	CF clear if successful
SeeAlso: AH=17h
--------N-6017-------------------------------
INT 60 - FTP Packet Driver - EXTENDED FUNC - GET MULTICAST LIST
	AH = 17h
Return: CF set on error
	    DH = error code (06h,09h) (see AX=01FFh)
	CF clear if successful
	    ES:DI -> multicast addresses (do not modify)
	    CX = bytes of multicast addresses currently in use
SeeAlso: AH=16h
--------N-6018-------------------------------
INT 60 - FTP Packet Driver - EXTENDED FUNC - GET STATISTICS
	AH = 18h
	BX = handle (optional for v1.10+)
Return: CF set on error
	    DH = error code (01h) (see AX=01FFh)
	CF clear if successful
	    DS:SI -> statistics (see below)

Format of statistics:
Offset	Size	Description
 00h	DWORD	packets in
 04h	DWORD	packets out
 08h	DWORD	bytes in
 0Ch	DWORD	bytes out
 10h	DWORD	errors in
 14h	DWORD	errors out
 18h	DWORD	packets dropped
--------N-6019-------------------------------
INT 60 - FTP Packet Driver - EXTENDED FUNC - SET NETWORK ADDRESS
	AH = 19h
	ES:DI -> address
	CX = length of address
Return: CF set on error
	    DH = error code (0Dh,0Eh) (see AX=01FFh)
	CF clear if successful
	    CX = length
--------N-601A-------------------------------
INT 60 - FTP Packet Driver v1.10+ - EXTENDED FUNC - SEND RAW BYTES
	AH = 1Ah
	DS:SI -> buffer
	CX = length of buffer
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
SeeAlso: AH=1Ch
--------N-601B-------------------------------
INT 60 - FTP Packet Driver v1.10+ - EXTENDED FUNC - FLUSH RAW BYTES RECEIVED
	AH = 1Bh
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
SeeAlso: AH=1Ch
--------N-601C-------------------------------
INT 60 - FTP Packet Driver v1.10+ - EXTENDED FUNC - FETCH RAW BYTES RECEIVED
	AH = 1Ch
	DS:SI -> buffer
	CX = length of buffer
	DX = timeout in clock ticks
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
	    CX = number of bytes transferred to buffer
SeeAlso: AH=1Ah,AH=1Bh
--------a-60AD-------------------------------
INT 60 - AccessDOS - API
	AH = ADh
	AL = function
	    E1h ???
		Return: AX = ???
	    E2h get configuration
		Return: BX:AX -> configuration data
Program: AccessDOS is a public domain TSR developed at The Trace Research and
	  Development Center which provides extensions for keyboard, mouse,
	  and sound access by the visually, hearing, or motor-control
	  impaired.
Note:	INT 60 is the default vector; AccessDOS will use the first 0000h:0000h
	  vector in the range 60h through 66h.
--------N-60E9-------------------------------
INT 60 - FTP Packet Driver - Crynwr Software - AUTOSELECT TRANSCEIVER
	AH = E9h
	???
Return: ???
--------*-61---------------------------------
INT 61 - reserved for user interrupt
--------b-61---------------------------------
INT 61 - Atari Portfolio - EXTENDED BIOS
   provides subfunctions such as turning off the machine, accessing internal
   variables, and mapping memory cards
SeeAlso: INT 60"Atari"
--------b-61---------------------------------
INT 61 - HP 95LX System Manager - LOAD DS
SeeAlso: INT 0F"HP 95LX",INT 60"HP 95LX"
--------r-61---------------------------------
INT 61 - JPI TopSPEED Modula-2 v1 - PROCEDURE EXIT TRAP
SeeAlso: INT 60"JPI"
--------d-61---------------------------------
INT 61 - Adaptec and OMTI controllers - DRIVE 0 DATA
Note:	this vector stores the second four bytes of the parameter table for
	  hard disk 0
SeeAlso: INT 60"Adaptec",INT 62"Adaptec",INT 63"Adaptec"
--------I-61---------------------------------
INT 61 - Sangoma CCIP (CCPOP 3270 resident module) INTERFACE
	BX:DX -> control block
SeeAlso: INT 67"Sangoma"
--------v-61---------------------------------
INT 61 - VIRUS - "SEMTEX"/"Screen Trasher" - INT 21h SUBSTITUTE
Note:	the virus copies the original INT 21h vector into INT 61h
SeeAlso: INT 21h,INT 60"VIRUS",INT 6B"VIRUS"
--------N-61---------------------------------
INT 61 - TCPOpen kernel - API
	ES:BX -> request packet (see below)
Program: TCPOpen is a TCP/IP protocol stack by Lanera
Note:	the interrupt number may be set to any value from 60h through 7Fh
	  (default 61h) via the configuration file; there does not appear
	  to be an installation check, though function FFFFh can be used to
	  verify that the software is indeed functioning

Format of request packet:
Offset	Size	Description
 00h  8 BYTEs	???
 08h	WORD	function number (0000h-001Ah or FFF9h-FFFFh)
 0Ah	WORD	???
 0Ch  2 BYTEs	???
 0Eh	WORD	(return) return code
 10h  2 BYTEs	???
 12h	WORD	???
 14h	WORD	(return) 0001h if requested function complete
 16h	WORD	(return) ???
 18h  6 BYTEs	???
 1Eh	DWORD	-> ???
 22h	WORD	??? or 0000h
 24h	WORD	(return) ???

Function FFFFh: installation verification
	Return: offset 10h = BEEFh
		offset 14h = 0001h
		offset 24h = ???
Index:	installation check;TCPOpen kernel
--------N-61---------------------------------
INT 61 - FTP Software PC/TCP - TCP/IP TSR System Call interface
	AH = system call number (see also entries below)
	    01h "pkt_alloc" (v2.05; this is "net_config" in v2.1+)
	    02h "pkt_free" (v2.05; this is "get_kernel_info" in v2.1+)
Return: CF clear if successful
	CF set on error
	    AL = basic error (see below)
	    AH = suberror number
Notes:	the installation check consists of testing for the signature "TCPTSR"
	  three bytes beyond the start of the interrupt handler
	INT 61 is the default; PC/TCP v2.05 may be configured to use any
	  interrupt from 20h through E0h
BUG:	the SLIP kernel for v2.05 bounds-checks the wrong register, so values
	  greater than 54h in AH may crash the system.	Other kernels may have
	  this bug as well.
SeeAlso: INT 61/AH=00h"PC/TCP",INT 61/AH=2Ah,INT 61/AH=54h
Index:	installation check;PC/TCP

Values for error code:
 00h "NET_NOERR" successful
 01h "NET_ERR_INUSE" protocol or socket already in use
 02h "NET_DOS_ERR" MS-DOS error (returned as suberror code in AH)
 03h "NET_ERR_NOMEM" out of memory
 04h "NET_ERR_NOTNETCONN" not a network descriptor
 05h "NET_ERR_ILLEGALOP" invalid operation on given kind of network descriptor
 06h "NET_ERR_BADPKT" illegal or corrupted packet
 07h "NET_ERR_NOHOST" no host bound to specified connection
 08h "NET_ERR_CANTOPEN" unable to open file
 09h "NET_ERR_NET_UNREACHABLE" network is unreachable
 0Ah "NET_ERR_HOST_UNREACHABLE" host is unreachable (see subcodes below)
 0Bh "NET_ERR_PROT_UNREACHABLE" protocol is unreachable
 0Ch "NET_ERR_PORT_UNREACHABLE" port is unreachable
 0Dh "NET_ERR_TIMEOUT" operation timed out
 0Eh "NET_ERR_HOSTUNKNOWN" unable to resolve host name
 0Fh "NET_ERR_NOSERVERS" no name servers configured
 10h "NET_ERR_SERVER_ERR" bad reply from name server
	Subcodes: 0= no error, 1 = Host unreachable
 11h "NET_ERR_BADFORMAT" bad format for IP address or field in IP address struc
			is zero
 12h "NET_ERR_BADARG" invalid argument
 13h "NET_ERR_EOF" foreign host closed its end of connection
 14h "NET_ERR_RESET" connection has been reset
 15h "NET_ERR_WOULDBLOCK" recv() call was done on a non-blocking connection
			with no data available
 16h "NET_ERR_UNBOUND" insufficient resources to do operation
 17h "NET_ERR_NODESC" could not allocate network descriptor
 18h "NET_ERR_BADSYSCALL" invalid/unsupported kernel call
 19h "NET_ERR_CANTBROADCAST" unable to broadcast
 1Ah "NET_ERR_NOTESTAB" operation illegal because connection not established
 1Bh kernel busy, try again later
 1Ch "NET_ERR_ICMPMESG" an ICMP message was received (not on streams)
	(see subcodes below)
---v2.1+---
 1Dh "NET_ERR_TERMINATING" internal kernel fatal error
 1Eh "NET_ERR_TAG_LOCKED" not allowed to set this tag (net_config)
 1Fh "NET_ERR_BAD_INTERFACE" non existent interface specified
 20h "NET_ERR_BADCONFIG" kernel cannot run - bad configuration
 21h "NET_ERR_EMM" expanded memory error
 22h "NET_ERR_CANT_SHUTDOWN" cant unload kernel (multitasker running)
 23h "NET_ERR_PARKED_IN" unable to unhook DOS interrupt
 24h "NET_ERR_NOQIOS" ran out of resources; try again later
 25h "NET_ERR_WOULD_TRUNCATE" datagram too large and "don't truncate" was set

Values for subcodes of error 0Ah "NET_ERR_HOST_UNREACHABLE":
 00h	no error
 01h	host unreachable
 02h	ARP failed
 03h	hardware failure
 04h	link failure
 05h	no route
 06h	gateway down

Values for subcodes of error 1Ch "NET_ERR_ICMPMESG":
 07h	unrecognised
 08h	can't fragment
 09h	srcr_fail
 0Ah	source quench
 0Bh	time exceeded
 0Ch	parameter problem
 0Dh	admin_prohib. see also code 0Ah
--------N-6100-------------------------------
INT 61 U - PC/TCP kernel v2.05+ - GET DEBUG INFORMATION
	AH = 00h
	DS:SI -> 216-byte buffer for network debugging information (see below)
Return: CF clear
	AX = 0000h
	buffer filled
Notes:	this call is not documented by FTP, Inc. for any version
	most of the information returned by this call is available via the
	  documented get_kernel_info or net_info commands.
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=2Ah"PC/TCP"

Format of network debugging information:
Offset	Size	Description
 00h	DWORD	number of interrupts
 04h	DWORD	receive buffer low-water mark
 08h	DWORD	transmit buffer low-water mark
 0Ch	DWORD	number of packets received
 10h	DWORD	number of packets transmitted
 14h	DWORD	total receive errors
 18h	DWORD	total transmit errors
 1Ch  4 BYTEs	???
 20h	DWORD	receive resets
 24h	DWORD	transmit resets
 28h	DWORD	number of "runts" received
 2Ch	DWORD	number of alignment errors on received packets
 30h	DWORD	number of CRC errors on received packets
 34h	DWORD	number of parity errors on received packets
 38h	DWORD	number of receive overflow errors
 3Ch	DWORD	number of oversized packets received
 40h	DWORD	number of packets lost due to lack of buffers
 44h	DWORD	receive timeouts
 48h 32 BYTEs	???
 68h	DWORD	number of transmit collisions
 6Ch	DWORD	number of transmit timeouts
 70h	DWORD	number of transmit underflows
 74h	DWORD	number of lost "crs" on transmit
 78h	DWORD	number of times heartbeat failed on transmit
 7Ch 24 BYTEs	???
 94h	WORD	free packet buffers
 96h	WORD	total packet buffers
 98h	WORD	minimum number of packet buffers free since kernel started
 9Ah 24 BYTEs	???
 B2h	DWORD	pointer to TCP connection list???
 B6h	DWORD	pointer to IP routing table???
 BAh 30 BYTEs	???
--------V-610000-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync,ET-3000 chipset - ZOOM DISPLAY
	AX = 0000h
	BX = zoom factor (0-7)
Desc:	zooms the display based on the given zoom factor
Notes:	INT 61h is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
	not all vendors include the Tseng TSR which supports these functions
SeeAlso: AX=0001h"OPTIMA",AX=0002h"OPTIMA",AX=0005h"OPTIMA"
SeeAlso: INT 16/AH=FFh"OPTIMA"
--------N-610001SF0001-----------------------
INT 61 - Banyan VINES - "Sosock" - OPEN COMMUNICATIONS SOCKET
	AX = 0001h subfn 0001h
	DS:DX -> communications control block (function 0001h)
Return: AX = status (see below)
Note:	Banyan can use any interrupt from 60h through 66h.  The Banyan
	  interrupt handler is identified by the string "BANV" in the four
	  bytes immediately preceding the interrupt handler
SeeAlso: AX=0001h/SF=0002h,AX=0001h/SF=0008h,INT 15/AX=DE2Eh

Values for status:
 0000h	successful
 0001h	service not installed
 0002h	invalid service ID
 0098h	resource already in use
 009Eh	address family does not exist
 009Fh	socket type does not exist
 00A0h	protocol does not exist
 00A1h	no more sockets available
 00A2h	no more buffer space available

Format of control block:
Offset	Size	Description
 00h	WORD	0001h
 02h	WORD	pointer to argument block
 04h	WORD	error return code
 06h  4 BYTEs	reserved

Format of argument block:
Offset	Size	Description
 00h	WORD	pointer to 2-byte buffer for socket identifier
 02h	WORD	address family
		0003h Banyan
 04h	WORD	socket type
		in address family 0003h
		    0001h IPC socket
		    0002h SPP socket
 06h	WORD	protocol number
		FFFFh default
 08h	WORD	pointer to 16-byte buffer for socket address
 0Ah	WORD	local port number
		0000h if service should assign transient port number
		0001h to 01FFh well-known port number (assigned by Banyan)

Format of IPC port:
Offset	Size	Description
 00h	WORD	address family (always 0003h for Banyan ports)
 04h  4 BYTEs	network number (server's serial number)
 06h	WORD	subnet number  (0001h = server, 8000h-FFFEh = PC)
 08h	WORD	port ID (0001h-01FFh for "well-known" ports)
 0Ah	BYTE	hop count
 0Bh  5 BYTEs	filler
--------N-610001SF0002-----------------------
INT 61 - Banyan VINES - "Sosend" - INITIATE OUTPUT EVENT
	AX = 0001h subfn 0002h
	DS:DX -> communications control block (function 0002h)
Return: AX = status (see below)
Note:	Banyan can use any interrupt from 60h through 66h.  The Banyan
	  interrupt handler is identified by the string "BANV" in the four
	  bytes immediately preceding the interrupt handler
SeeAlso: AX=0001h/SF=0001h,AX=0001h/SF=0005h

Values for status:
 0000h	successful
 0001h	service not installed
 0002h	invalid service ID
 0003h-000Ah reserved for BANV interface errors
 0097h	invalid socket identifier
 009Bh	destination node unreachable
 009Ch	message overflow
 009Dh	destination socket nonexistent
 00A2h	no more buffer space
 00A3h	timeout
 00B1h	resource disconnect

Format of control block:
Offset	Size	Description
 00h	WORD	0002h
 02h	WORD	pointer to argument block (see below)
 04h	WORD	error return code
		0000h successful
		0097h invalid socket ID
		00A2h no more buffer space
		00A3h timeout event
		00A5h resource not available
		00A6h internal communication failure
		00B1h resource disconnect
 06h  4 BYTEs	reserved

Format of argument block:
Offset	Size	Description
 00h	WORD	routine metric
 02h	WORD	error return code
 04h	WORD	socket identifier
 06h	WORD	pointer to send buffer
 08h	WORD	length of send buffer
 0Ah	WORD	flags
		bit 0: async request
		bit 1: reliable message
		bit 3: end of user message received
		bit 4: vectored request (if set, send buffer contains buffer
			descriptors)
		bit 5: connection-specific receive
		bit 6: change to connection-specific receive mode
 0Ch 16 BYTEs	socket address (see below)
 1Ch	WORD	timeout value in multiples of 200ms
 1Eh	WORD	connection identifier
 20h	WORD	type of request
		0001h send message
		0002h establish a virtual connection
		0003h terminate a virtual connection

Format of buffer descriptor:
Offset	Size	Description
 00h	WORD	data segment
 02h	WORD	buffer pointer
 04h	WORD	buffer length
 06h	WORD	character count

Format of socket address for unreliable datagrams:
Offset	Size	Description
 00h	WORD	0003h	  address family
 02h	DWORD	FFFFFFFFh network number
 06h	WORD	FFFFh	  subnet number
 08h	WORD		  local port number
 0Ah	BYTE	00h-0Fh	  hop count
 0Bh  5 BYTEs	0000h	  filler
--------N-610001SF0003-----------------------
INT 61 - Banyan VINES - "Sorec" - RECEIVE INPUT EVENT NOTIFICATION
	AX = 0001h subfn 0003h
	DS:DX -> communications control block (function 0003h)
Return: AX = status (00-0Ah,97h,A2h,A3h) (see AX=0001h/SF=0002h)
Note:	Banyan can use any interrupt from 60h through 66h.  The Banyan
	  interrupt handler is identified by the string "BANV" in the four
	  bytes immediately preceding the interrupt handler
SeeAlso: AX=0001h/SF=0002h

Format of control block:
Offset	Size	Description
 00h	WORD	0003h
 02h	WORD	pointer to argument block (see below)
 04h	WORD	error return code
		0000h successful
		0097h invalid socket ID
		00A2h no more buffer space
		00A3h timeout event
		00A5h resource not available
		00A6h internal communication failure
		00B1h resource disconnect
 06h  4 BYTEs	reserved

Format of argument block:
Offset	Size	Description
 00h	WORD	character count
 02h	WORD	error return code
 04h	WORD	socket identifier
 06h	WORD	pointer to receive buffer
 08h	WORD	length of receive buffer
 0Ah	WORD	flags
		bit 0: async request
		bit 2: flush receive buffer on overflow
		bit 3: end of user message received
		bit 4: vectored request (if set, receive buffer contains buffer
			descriptors)
		bit 5: connection-specific receive
		bit 6: change to connection-specific receive mode
 0Ch 16 BYTEs	socket address
 1Ch	WORD	timeout value in multiples of 200ms
 1Eh	WORD	connection identifier
 20h	WORD	type of response
		0001h message received
		0002h virtual connection established
		0003h virtual connection terminated

Format of buffer descriptor:
Offset	Size	Description
 00h	WORD	data segment
 02h	WORD	buffer pointer
 04h	WORD	buffer length
 06h	WORD	character count
--------N-610001SF0004-----------------------
INT 61 - Banyan VINES - "Soclose" - CLOSE A SOCKET
	AX = 0001h subfn 0004h
	DS:DX -> communications control block (function 0004h)
Return: AX = status (00h-0Ah,97h) (see AX=0001h/SF=0002h)
Note:	Banyan can use any interrupt from 60h through 66h.  The Banyan
	  interrupt handler is identified by the string "BANV" in the four
	  bytes immediately preceding the interrupt handler
SeeAlso: AX=0001h/SF=0001h,INT 15/AX=DE2Eh

Format of control block:
Offset	Size	Description
 00h	WORD	0004h
 02h	WORD	pointer to argument block (see below)
 04h	WORD	error return code
 06h  4 BYTEs	reserved

Format of argument block:
Offset	Size	Description
 00h	WORD	socket identifier
--------N-610001SF0005-----------------------
INT 61 - Banyan VINES - "Sowait" - WAIT FOR ASYNCHRONOUS EVENT COMPLETION
	AX = 0001h subfn 0005h
	DS:DX -> communications control block (function 0005h)
Return: AX = status (see below)
Notes:	Banyan can use any interrupt from 60h through 66h.  The Banyan
	  interrupt handler is identified by the string "BANV" in the four
	  bytes immediately preceding the interrupt handler
	returns results for all asynchronous operations invoked from the
	  data segment used for this call
SeeAlso: AX=0001h/SF=0002h,AX=0001h/SF=0009h

Values for status:
 0000h	successful
 0001h	service not installed
 0002h	invalid service ID
 0003h-000Ah reserved for BANV interface errors
 00A2h	no more buffer space available
 00A3h	timeout event

Format of control block:
Offset	Size	Description
 00h	WORD	0005h
 02h	WORD	pointer to argument block (see below)
 04h	WORD	error return code
 06h  4 BYTEs	reserved

Format of argument block:
Offset	Size	Description
 00h	WORD	pointer to WORD event pointer
 02h	WORD	timeout in multiples of 200ms, FFFFh = infinite
--------N-610001SF0008-----------------------
INT 61 - Banyan VINES - "Sosession" - REGISTER APPLICATION WITH COMM SERVICE
	AX = 0001h subfn 0008h
	DS:DX -> communications control block (function 0008h)
Return: AX = status
	    0000h  successful
	    00A2h  no more buffer space available
Note:	Banyan can use any interrupt from 60h through 66h (default 61h).  The
	  Banyan interrupt handler is identified by the string "BANV" in the
	  four bytes immediately preceding the interrupt handler
SeeAlso: AX=0001h/SF=0001h,AX=0001h/SF=0009h

Format of control block:
Offset	Size	Description
 00h	WORD	0008h
 02h	WORD	process type
		0001h transient process
		0002h resident process
 04h	WORD	error return code
 06h  4 BYTEs	reserved
--------N-610001SF000B-----------------------
INT 61 - Banyan VINES - "Soint" - SET USER COMPLETION FUNCTION
	AX = 0001h subfn 000Bh
	DS:DX -> communications control block (function 000Bh)
Return: AX = status (00h-0Ah,A2h) (see AX=0001h/SF=0005h)
Notes:	Banyan can use any interrupt from 60h through 66h.  The Banyan
	  interrupt handler is identified by the string "BANV" in the four
	  bytes immediately preceding the interrupt handler
	FAR user function is invoked with SS,DS, and ES set to segment of
	  control block, and with the stack containing
		DWORD	return address
		WORD	argument pointer (sosend or sorec argument block)
		WORD	error return code
			0000h argument pointer is valid
			00A3h timeout
SeeAlso: AX=0001h/SF=0005h,AX=0001h/SF=0008h

Format of control block:
Offset	Size	Description
 00h	WORD	000Bh
 02h	WORD	pointer to argument block (see below)
 04h	WORD	error return code
 06h  2 BYTEs	reserved
 08h	WORD	user CS register

Format of argument block:
Offset	Size	Description
 00h	WORD	pointer to user interrupt function
 02h	WORD	pointer to user stack
 04h	WORD	initial timeout value in multiples of 200ms, FFFFh = infinite
--------V-610001-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync,ET-3000 chipset - CENTER ZOOM WINDOW
	AX = 0001h
	BX = X coordinate to center
	CX = Y coordinate to center
Desc:	Positions the zoom window such that the specified window-relative
	  coordinates appear as close as possible to the center of the
	  display.  Useful for scrolling and panning.
Notes:	INT 61h is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
	not all vendors include the Tseng TSR which supports these functions
SeeAlso: AX=0000h"OPTIMA",AX=0002h"OPTIMA",AX=0005h"OPTIMA"
SeeAlso: INT 16/AH=FFh"OPTIMA"
--------I-610002-----------------------------
INT 61 - Banyan VINES - 3270 INTERFACE
	AX = 0002h
	BH = function
	    00h "pi2reset"  reset 3270/SNA or 3270/BSC driver
	    02h "pi2bsc" (3270/BSC only)
	    03h "pi2get"    get information stored in 3270 resident driver
	    04h "pi2put"    store information in 3270 resident driver
	    05h "pi2gcur"   get current screen position
	    07h "pi2sdat"   send data keystroke
	    08h "pi2scom"   send command keystroke
	    0Ah "pi2field"  get field info for arbitrary screen positions
	    0Fh "pi2stat"   get logical unit/device status
	    12h "pi2nlus"   determine logical unit/device assignment
	    13h "pi2gate"   specifies comm port address to gateway service
	    14h "pi2attach" attach a logical unit/device
	    15h "pi2sdev"   save logical unit/device info in resident driver
			    (not supported in >3.0)
	    16h "pi2gdev"   get device information (not supported in >3.0)
	    17h "pi2luinfo" get info about specific logical unit/device
	    18h "pi2gerr"   get finer error detail
	    19h "pi2dhold"  (3270/SNA only)  holds a 3270 device
	    1Ah "pi2shut"   release memory-resident module
	    1Ch "pi2sprof"  save profile info in res driver (not supp in >3.0)
	    1Dh "pi2gprof"  get prevsly stored profile info (not supp in >3.0)
	DS:CX -> argument block (except BH=00h,1Ah)
Return: AX = status (see below)
Notes:	Either 3270/SNA or 3270/BSC interface may use AX=0002h, depending on
	  which is loaded first.  The other interface will use AX=000Ah
	Status codes greater than 63h indicate an inconsistency in the 3270/SNA
	  or 3270/BSC resident driver, which must be reloaded by the user

Values for status:
 0000h	successful
 000Bh	invalid parameter or data does not fit data area
 000Ch	another code path currently active in resident driver
 000Dh	operation currently not allowed
 0032h	encountered connection disconnect error
 0033h	encountered "sosend" completion error
 0034h	encountered "sosend" communication error
 0035h	attach request refused.	extended error info via "pi2gerr":
	01h resource unavailable
	02h invalid type
	03h version mismatch
	04h invalid logical unit number
	05h error during ARL processing
	06h no access for user
 0071h	encountered "sosock" error
 0072h	encountered unrecognizable error
 0073h	encountered "sowait" error (extended info via "pi2gerr")
 0074h	encountered invalid type-of-request on "sowait"
 0075h	encountered "sorec" error (extended info via "pi2gerr")
 0076h	encountered "sorec" completion error (ext info via "pi2gerr")
 0077h	encountered connection request
 0078h	encountered unrecognizable data
 0079h	encountered unknown connection ID (ext info via "pi2gerr")

Format of argument block for BH=03h,04h:
Offset	Size	Description
 00h	WORD	size of data area (max 256)
 02h  N BYTEs	data area

Format of argument block for BH=05h:
Offset	Size	Description
 00h	WORD	logical unit/device number
 02h	WORD	pointer to WORD buffer for cursor index
 04h	WORD	pointer to BYTE buffer for current field attribute

Format of argument block for BH=07h:
Offset	Size	Description
 00h	WORD	logical unit/device number
 02h	WORD	ASCII data byte
 04h	WORD	pointer to WORD count of characters which will need updating

Format of argument block for BH=08h:
Offset	Size	Description
 00h	WORD	logical unit/device number
 02h	WORD	keystroke
		0000h Enter
		0001h Clear
		0002h PA1
		0003h PA2
		0004h PA3
		0005h PF1
		...
		001Ch PF24
		001Dh CSELECT (cursor select)
		001Eh Insert
		001Fh Delete
		0020h EOField
		0021h EINPUT (erase input)
		0022h Reset
		0023h Attention
		0024h SysReq
		0025h Duplicate
		0026h Fieldmark
		0027h Home
		0028h NextLine
		0029h Tab
		002Ah BackTab
		002Bh cursor up
		002Ch cursor down
		002Dh cursor right
		002Eh cursor left
		002Fh double cursor right
		0030h double cursor left
		0031h PRINT
		0032h CANCEL
		0033h Backspace

Format of argument block for BH=0Ah:
Offset	Size	Description
 00h	WORD	logical unit/device number
 02h	WORD	screen index
 04h	WORD	pointer to WORD buffer for field length
 06h	WORD	pointer to WORD buffer for offset in screen of field start

Format of argument block for BH=0Fh:
Offset	Size	Description
 00h	WORD	logical unit/device number
 02h	WORD	clear mask (clear these bits of status after returning status)
 04h	WORD	pointer to WORD buffer for device status (see below)

Bitfields for device status:
 bit 10 status modified
 bit 9	buffer modified
 bit 8	set cursor
 bit 5	sound alarm
 bits 1-0  size of print line for printer logical units
	00  unformatted line
	01  40-character line
	10  64-character line
	11  80-character line

Format of argument block for BH=12h:
Offset	Size	Description
 00h	WORD	pointer to WORD buffer for number of logical units or devices
 02h	WORD	pointer to WORD buffer for version number
 04h	WORD	pointer to 64-byte buffer for logical unit/device list

Format of argument block for BH=13h:
Offset	Size	Description
 00h 16 BYTEs	communications port address (see AX=0001h#"Sosock")

Format of argument block for BH=14h:
Offset	Size	Description
 00h	WORD	logical unit/device number
		0000h attach any free device of the specified type
 02h	WORD	logical unit/device type
		(3270/SNA) 01h, 02h, or 03h
		(3270/BSC) 02h display
		(3270/BSC) 03h printer
 04h	WORD	pointer to WORD buffer for attached logical unit/device number

Format of argument block for BH=16h:
Offset	Size	Description
 00h	WORD	pointer to 18-byte buffer for device block (see below)
		first WORD must be set to desired logical unit/device number

Format of argument block for BH=17h:
Offset	Size	Description
 00h	WORD	logical unit/device number
 02h	WORD	pointer to information block in caller's DS (see below)

Format of argument block for BH=18h:
Offset	Size	Description
 00h	WORD	pointer to WORD buffer for major error code
 02h	WORD	pointer to WORD buffer for minor error code

Format of argument block for BH=19h:
Offset	Size	Description
 00h	WORD	logical unit/device number

Format of argument block for BH=1Ch,1Dh:
Offset	Size	Description
 00h	WORD	pointer to profile block in caller's DS (see below)

Format of device block, argument block for BH=15h:
Offset	Size	Description
 00h	WORD	logical unit/device number
 02h	WORD	logical unit/device type
 04h	WORD	display model number
 06h	WORD	numeric checking
 08h	WORD	status line
 0Ah	BYTE	unprotected normal field attribute
 0Bh	BYTE	unprotected intensified field attribute
 0Ch	BYTE	protected normal field attribute
 0Dh	BYTE	protected intensified field attribute
 0Eh	WORD	reserved
 10h	WORD	printer port number

Format of information block:
Offset	Size	Description
 00h	WORD	device model number
 02h	DWORD	screen buffer pointer
 06h	DWORD	status line pointer (see below)
 0Ah	DWORD	reserved

Format of status line:
Offset	Size	Description
 00h	BYTE	comm line status
		00h inactive
		01h active
 01h	BYTE	activation level
		01h physical unit activated
		02h logical unit also activated
		03h session is bound
 02h	BYTE	data traffic state
		00h inactive
		01h active
 03h	BYTE	screen ownership
		00h SLU->PLU sessoin owns screen
		01h SLU->SSCP session owns screen
 04h	BYTE	keyboard status (see below)
 05h	BYTE	insert mode
		01h if in insert mode
 06h	BYTE	numeric
		01h if current screen buffer is numeric only
 07h	BYTE	printer status
		00h printer not assigned
		01h printer is inactive
		02h printer error
		03h currently printing
		04h printer is busy
		05h printer is very busy
 08h	BYTE	printer assignment
 09h	BYTE	maximum size of network name
 0Ah  N BYTEs	ASCIZ network name
	BYTE	maximum size of message window
      M BYTEs	null-terminated message window
	BYTE	code set
		00h EBCDIC
		01h ASCII
      M BYTEs	extended attributes
		01h extended attributes are in effect (stored at screen+1920)
			each extended attribute specifies
			bits 0,1: 00=normal, 01=blink, 10=reverse, 11=underscor
			bits 2-4: 000=default,001=blue,010=red,011=pink,
				  100=green,101=turquoise,110=yellow,111=white
	BYTE	extended color
		01h other than base color is in effect

Values for keyboard status:
 00h	UNLOCK - ready to accept data
 01h	TIME - aid was struck
 02h	SYSTEM - received response no restore
 03h	FUNCTION - unavailable keyboard function
 04h	INPUT - not currently used
 05h	ENDFIELD - field filled in insert mode
 06h	PROTECTED - attempt to enter in protected field
 07h	NUMERIC - attempt to enter in numeric field
 08h	PROGRAM - error in outbound data stream

Format of profile block:
Offset	Size	Description
 00h 64 BYTEs	gateway service name
 40h 16 BYTEs	gateway comm port address
 50h	WORD	primary logical unit number
 52h	WORD	secondary logical unit type
 54h	WORD	secondary logical unit number
 56h	WORD	printer assignment
 58h 50 BYTEs	keyboard definitions filename
--------V-610002-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync,ET-3000 chipset - END ZOOM
	AX = 0002h
Desc:	switches off zoom and returns window to its original state
Notes:	INT 61h is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
	not all vendors include the Tseng TSR which supports these functions
SeeAlso: AX=0000h"OPTIMA",INT 16/AH=FFh"OPTIMA"
--------N-610003SF00-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - INIT USER BUFFER PTR INFO
	AX = 0003h subfn 00h
	DS:BX -> argument block (see below)
Return: AX = status (see below)
SeeAlso: AX=0003h/SF=06h,AX=0003h/SF=08h,AX=0003h/SF=0Dh

Values for status:
 0000h	successful
 000Bh	invalid session ID
 000Ch	session not active
 000Dh	invalid request type
 000Eh	invalid parameters
 000Fh	out of heap space
 0010h	timeout on send
 0011h	Banyan communications error
 0012h	session not waiting for host
 0013h	session is active
 0014h	duplicate suspend session request
 0015h	no session suspended
 0016h	ring data buffer full
 0017h	printer error encountered
 0018h	Banyan communications error
 0019h	unable to make connection
 001Ah	no ring buffer specified at startup
 001Bh	service is down
 001Ch	invalid service name
 001Dh	service is closed
 001Eh	invalid connection name
 001Fh	max session limit reached for service
 0020h	access rights list for connection/dialout does not include this user
 0021h	service not responding
 0022h	missing telephone number

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	00h (func "initialize user buffer pointer information area")
 02h	WORD	-> user buffer ptr info area in caller's current DS (see below)

Format of user buffer ptr info area:
Offset	Size	Description
 00h	WORD	flags
		0000h don't read interface's data buffer
		0001h read data buffer
 02h	DWORD	pointer to ring buffer
 06h	WORD	length of ring buffer
 08h	WORD	ring buffer offset to last byte read by caller
 0Ah	DWORD	pointer to WORD containing offset of last byte
		  in ring buffer filled
 0Eh	DWORD	pointer to screen buffer
 12h	DWORD	pointer to field containing cursor position
 16h	DWORD	pointer to terminal status area (see below)

Format of terminal status area:
Offset	Size	Description
 00h	BYTE	status of session: 4Eh=oNline, 46h=oFfline, 57h=Waiting
 01h	BYTE	terminal type (00h=VT100, 01h=TTY, 02h=VT52, 03h=IBM3101)
 02h	BYTE	current keypad mode (VT100,VT52 only)
		4Eh ("N") numeric mode
		41h ("A") application mode
 03h  4 BYTEs	current state of LEDs (VT100 only)
		00h off
		01h on
 07h	WORD	line error count
 09h	WORD	primary error code (see below)
 0Bh	WORD	secondary error code

Values for primary error code:
 0000h	no error
 0001h	unable to make connection
 0002h	communications error, restart session
 0003h	async terminal emulation service unavailable
 0004h	lost carrier
 0005h	all matching lines busy
 0006h	no lines defined for connection name
 0007h	no dial lines available on server
 0008h	no matching dial lines available
 0009h	out of heap space
 000Ah	service error encountered
 000Bh	timed out waiting to connect
 000Ch	communications error
 000Dh	communications error
 000Eh	host wants file transferred to/from PC
 000Fh	host software changed session parameter
 0010h	host software changed tap settings
 0011h	host software changed LED indicator
 0012h	host software changed display background (secondary error code 00h for
	  white on black, 01h for black on white)
 0013h	host software changed display option (secondary error code 00h for off,
	  01h for on)
 0014h	communications error
 0015h	communications error
 0016h	unable to make connection
 0017h	unable to make connection
--------N-610003SF01-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - SEND TO HOST
	AX = 0003h subfn 01h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=00h,AX=0003h/SF=02h,AX=0003h/SF=14h

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	01h (function "send to host")
 02h	BYTE	type
		00h ASCII byte
		01h ASCII string
		02h terminal function code
		03h up arrow
		04h down arrow
		05h left arrow
		06h right arrow
		07h break
 03h  N BYTEs	type-specific info (see below)

Format of type-specific info:
Offset	Size	Description
---ASCII byte---
 03h	BYTE	byte to send to host
---ASCII string---
 03h	WORD	length of string
 05h	WORD	pointer to string
---terminal function code (VT52/VT100)---
 03h	BYTE	function code
		00h keypad 0
		01h keypad 1
		...
		09h keypad 9
		0Ah keypad -
		0Bh keypad ,
		0Ch keypad .
		0Dh keypad ENTER
		0Eh PF1
		0Fh PF2
		10h PF3
		11h PF4
---terminal function code (IBM3101)---
 03h	BYTE	function code
		00h PF1
		...
		07h PF8
		08h Home
--------N-610003SF02-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - "CONTROL MONITOR"
	AX = 0003h subfn 02h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=03h,AX=0003h/SF=05h

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	02h (function "control monitor")
 02h	BYTE	display flag
		00h don't display data received from host
		01h display data
--------N-610003SF03-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - "FLOW CONTROL DATA"
	AX = 0003h subfn 03h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
Desc:	this function permits the caller to freeze/unfreeze the display and
	  the ring buffer
SeeAlso: AX=0003h/SF=02h,AX=0003h/SF=06h

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	03h (function "flow control data")
 02h	BYTE	flow control flag
		00h allow characters to be put into display or ring buffer
		01h don't place any more characters into display or ring buffer
--------N-610003SF04-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - END ACTIVE SESSION
	AX = 0003h subfn 04h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=0Ah,AX=0003h/SF=0Dh,AX=0003h/SF=0Fh

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	04h (function "end active session")
--------N-610003SF05-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - SET SESSION PARAMETER
	AX = 0003h subfn 05h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=00h,AX=0003h/SF=06h,AX=0003h/SF=08h

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	05h (function "set session parameter")
 02h	BYTE	parameter number (see below)
 03h	BYTE	new parameter value

Values for parameter number:
 00h	line speed (00h=any, 01h=50, 02h=110, 03h=134.5, 04h=150,
		  05h=300, 06h=600, 07h=1200, 08h=2400, 09h=4800, 0Ah=9600)
 01h	parity (00h=none, 01h=odd, 02h=even)
 02h	duplex (00h=full, 01h=half)
 03h	character size (00h=7 bits, 01h=8 bits)
 04h	stop bits (00h=1, 01h=2)
 05h	XON/XOFF flow control (00h=no, 01h=yes)
 07h	intercharacter delay in tenths of a second
 08h	interline delay in tenths of a second
 09h	auto linefeed (00h=no, 01h=yes)
 0Ah	filter control characters (00h=no, 01h=yes)
 0Bh	terminal type (00h=VT100,01h=glassTTY,02h=VT52,03h=IBM3101)
 0Ch	auto wrap (00h=no, 01h=yes)
 0Dh	cursor shape (00h=underscore, 01h=block)
 0Eh	character set (00h=UK, 01h=US ASCII)
 0Fh	printer port (00h=LPT1, 01h=LPT2, 02h=LPT3)
--------N-610003SF06-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - GET SESSION PARAMETER
	AX = 0003h subfn 06h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=00h,AX=0003h/SF=05h,AX=0003h/SF=07h

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	06h (function "get session parameter")
 02h	BYTE	parameter number (see AX=0003h/SF=05h)
 03h	BYTE	(return) current parameter value
--------N-610003SF07-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - SET TAB SETTINGS
	AX = 0003h subfn 07h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=05h,AX=0003h/SF=08h

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	07h (function "set tab settings")
 02h	WORD	pointer to 80-byte buffer in caller's current DS
		  each byte = 00h if no tab, 01h if tab at that position
--------N-610003SF08-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - GET TAB SETTINGS
	AX = 0003h subfn 08h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=06h,AX=0003h/SF=07h

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	08h (function "get tab settings")
 02h	WORD	pointer to 80-byte buffer in caller's current DS
		each byte set to 00h if no tab, 01h if tab at that position
--------N-610003SF09-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - REFRESH EMULATION SCREEN
	AX = 0003h subfn 09h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=00h,AX=0003h/SF=0Bh

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	09h (function "refresh emulation screen")
--------N-610003SF0A-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - SUSPEND SESSION TEMPORARILY
	AX = 0003h subfn 0Ah
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=04h,AX=0003h/SF=09h,AX=0003h/SF=0Bh,AX=0003h/SF=0Dh

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	0Ah (function "suspend session temporarily")
 02h	WORD	size of session information to be saved
 04h	WORD	pointer to buffer in caller's DS
--------N-610003SF0B-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - RESUME SUSPENDED SESSION
	AX = 0003h subfn 0Bh
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=09h,AX=0003h/SF=0Ah

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	0Bh (function "restore previously suspended session")
 02h	WORD	size of buffer into which session info is restored
 04h	WORD	pointer to buffer in caller's DS
--------N-610003SF0C-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - SET SCROLL LOCK CHECKING
	AX = 0003h subfn 0Ch
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=00h

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	0Ch (function "set state of scroll lock checking")
 02h	BYTE	check_scroll_lock flag
		00h off
		01h on (display of host data stopped while ScrollLock on)
--------N-610003SF0D-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - EXIT EMULATION
	AX = 0003h subfn 0Dh
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=04h,AX=0003h/SF=0Ah

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	0Dh (function "exit emulation")
--------N-610003SF0E-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - INTERRUPT ON CHAR FROM HOST
	AX = 0003h subfn 0Eh
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=00h,AX=0003h/SF=14h

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	0Eh (function "interrupt on character from host")
 02h	DWORD	pointer to routine to be called (0000h:0000h = don't call)
 06h	DWORD	stack pointer to use when call is made
--------N-610003SF0F-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - START A SESSION
	AX = 0003h subfn 0Fh
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=04h,AX=0003h/SF=0Bh

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	0Fh (function "start a session")
 02h	WORD	pointer to information area in caller's current DS (see below)

Format of information area:
Offset	Size	Description
 00h	WORD	length of service name
 02h	WORD	pointer to service name in caller's DS
 04h	BYTE	type of connection (00h=connection name, 01h=dialout)
 05h	WORD	length of connection name/telephone number
 07h	WORD	pointer to connection name/telephone number
--------N-610003SF10-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - START/STOP PRINTING
	AX = 0003h subfn 10h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=06h,AX=0003h/SF=13h

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	10h (function "start/stop printing of data received from host)
 02h	WORD	print capture flag (00h=off, 01h=on)
--------N-610003SF11-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - GET FILE TRANSFER PARAMETERS
	AX = 0003h subfn 11h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=00h,AX=0003h/SF=12h

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	11h (function "get file transfer parameters")
 02h	WORD	pointer to info area in caller's current DS (see below)

Format of info area:
Offset	Size	Description
 00h	BYTE	protocol flag (00h none, 01h Kermit)
 01h	BYTE	direction flag (00h send, 01h receive)
 02h	BYTE	length of null-terminated PC filename
 03h	DWORD	pointer to null-terminated PC filename
 07h	BYTE	length of null-terminated host filename
 08h	DWORD	pointer to null-terminated host filename
--------N-610003SF12-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - GET CONNECTION INFORMATION
	AX = 0003h subfn 12h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=11h,AX=0003h/SF=15h

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	12h (function "get connection information")
 02h	WORD	offset of buffer for connection information (see below)

Format of connection information:
Offset	Size	Description
 00h	WORD	length of service name (returned)
 02h	WORD	pointer to 64-byte buffer for service name
 04h	BYTE	type of connection
		00h connection name
		01h dialout
 05h	WORD	length of connection name/telephone number
 07h	WORD	pointer to 64-byte buffer for name/telno
 09h	BYTE	server line number being used (returned)
--------N-610003SF13-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - START/STOP TRACING TRAFFIC
	AX = 0003h subfn 13h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=00h,AX=0003h/SF=0Eh

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	13h (function "start/stop tracing data traffic in session")
 02h	BYTE	trace flag (00h=off, 01h=on)
--------N-610003SF14-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - INTERRUPT ON HOST MESSAGE
	AX = 0003h subfn 14h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=0Eh

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	14h (function "interrupt on message from host")
 02h	DWORD	pointer to routine to be called (0000h:0000h = don't call)
 06h	DWORD	stack pointer to use when call is made
--------N-610003SF15-------------------------
INT 61 - Banyan VINES - ASYNC TERMINAL EMULATION - RESET ERROR
	AX = 0003h subfn 15h
	DS:BX -> argument block (see below)
Return: AX = status (see AX=0003h/SF=00h)
SeeAlso: AX=0003h/SF=00h,AX=0003h/SF=12h

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	15h (function "reset error")
--------V-610003-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync,ET-3000 chipset - REPORT ZOOM FACTOR
	AX = 0003h
Return: AX = zoom factor
Desc:	returns the current zoom factor
Notes:	INT 61h is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
	not all vendors include the Tseng TSR which supports these functions
SeeAlso: AX=0000h"OPTIMA",AX=0005h"OPTIMA",INT 16/AH=FFh"OPTIMA"
--------N-610004-----------------------------
INT 61 - Banyan VINES - GET SERVER SERIAL NUMBER
	AX = 0004h
	DS:DX -> request block (function 0008h)
Return: AX = status
	    0000h server ID returned in request block
	    000Fh invalid drive
	    0015h drive not ready

Format of request block:
Offset	Size	Description
 00h	WORD	0008h
 02h	WORD	drive number (0=default, 1=A, ...)
 04h  6 BYTEs	buffer for server ID
--------V-610004-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync,ET-3000 chipset - ENTER SPECIFY MODE
	AX = 0004h
Notes:	Specify Mode is enabled by hot key (seeAlso below), and allows
	  panning and zooming via the numeric keypad.
	INT 61 is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
	not all vendors include the Tseng TSR which supports these functions
SeeAlso: AX=0000h"OPTIMA",AX=0007h"OPTIMA",INT 16/AH=FFh"OPTIMA"
--------N-610005-----------------------------
INT 61 - Banyan VINES - PRINTER CONTROL
	AX = 0005h
	DS:DX -> request block
Return: AX = status
	    0000h successful
	    0001h network software not installed or incompatible
SeeAlso: INT 2F/AX=D702h

Format of request block:
Offset	Size	Description
 00h	WORD	function
		0201h "endspool" all data for a print job has been sent
		0205h "getactive" get currently active printer port
 02h	WORD	number of active port (1-3)
 04h	WORD	??? (0 for func 0201h, 3 for func 0205h)
 06h	WORD	0000h
--------V-610005-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync - QUERY ZOOM WINDOW
	AX = 0005h
	BX:CX -> buffer for window parameters (see below)
Notes:	INT 61 is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
	not all vendors include the Tseng TSR which supports these functions
SeeAlso: AX=0000h"OPTIMA",AX=0003h"OPTIMA",AX=0006h"OPTIMA"
SeeAlso: INT 16/AH=FFh"OPTIMA"

Format of window parameters:
Offset	Size	Description
 00h	WORD	X start of zoom window
 02h	WORD	Y start of zoom window
 04h	WORD	X end of zoom window
 06h	WORD	Y end of zoom window
 08h	WORD	current zoom factor
 0Ah	WORD	zoom offset start X
 0Ch	WORD	zoom offset start Y
--------V-610006-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync,ET-3000 chipset - SET ZOOM WINDOW
	AX = 0006h
	BX:CX -> zoom window description (see below)
Notes:	width of zoom window must be a multiple of the pixel replication (zoom)
	  factor
	INT 61 is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
	not all vendors include the Tseng TSR which supports these functions
SeeAlso: AX=0000h"OPTIMA",AX=0001h"OPTIMA",AX=0005h"OPTIMA",AX=0008h"OPTIMA"
SeeAlso: INT 16/AH=FFh"OPTIMA"

Format of zoom window description:
Offset	Size	Description
 00h	WORD	X start of zoom window
 02h	WORD	Y start of zoom window
 04h	WORD	X end of zoom window
 06h	WORD	Y end of zoom window
--------V-610007-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync,ET-3000 chipset - QUERY APPLICATION KEY
	AX = 0007h
Return: AX = current state (0000h/0001h)
Desc:	returns the current toggle state of the application (END) key in
	  specify mode. E.g. in the OPTIMA AutoCAD driver, 0 means AutoCAD
	  calls INT 61/AX=0001h every time the crosshair cursor moves.
Notes:	In specify mode, the END key has been reserved for applications.
	INT 61 is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
	not all vendors include the Tseng TSR which supports these functions
SeeAlso: AX=0000h"OPTIMA",AX=0001h"OPTIMA",AX=0004h"OPTIMA"
SeeAlso: INT 16/AH=FFh"OPTIMA",INT 7A"AutoCAD"
--------N-610007BX0002-----------------------
INT 61 - Banyan VINES - GET PORTS FOR A SERVICE
	AX = 0007h
	BX = 0002h
	DS:DX -> StreetTalk service name
	DS:DI -> port record block (see below)
Return: AX = status (see below)
SeeAlso: AX=0007h/BX=0004h

Values for status:
 0000h	successful
 0001h	PC network software not installed or incompatible
 03E9h	incorrect name syntax
 03EAh	organization name too long
 03EBh	group name too long
 03ECh	item name too long
 03EDh	StreetTalk name too long
 03F3h	organization not found
 03F4h	group not found
 03F5h	StreetTalk name not found
 03F8h	not a StreetTalk name
 0409h	modify access denied
 040Dh	appropriate StreetTalk name unavailable

Format of port record block:
Offset	Size	Description
 00h	WORD	number of 17-byte elements
 02h 17 BYTEs	element (byte 00h = input port type, bytes 01h-10h = port)
		(see AX=0001h#"Sosock" for port format)
--------N-610007BX0004-----------------------
INT 61 - Banyan VINES - SET PORTS FOR A SERVICE
	AX = 0007h
	BX = 0004h
	DS:DX -> StreetTalk name of service
	DS:DI -> port record block (see below)
Return: AX = status (see AX=0007h/BX=0002h)
SeeAlso: AX=0007h/BX=0002h

Format of port record block:
Offset	Size	Description
 00h	WORD	number of 17-byte elements
 02h 17 BYTEs	element: byte 00h = input port type, 01h-10h = port
		(see AX=0001h#"Sosock" for port format)
--------N-610007BX0005-----------------------
INT 61 - Banyan VINES - GET USER NAME
	AX = 0007h
	BX = 0005h
	DS:DX -> 64-byte buffer for user's StreetTalk name
Return: AX = status
	    0000h successful
	    0001h network software not installed or incompatible
Note:	if no user logged in, first byte of returned name will be 00h
SeeAlso: AX=0007h/BX=0007h
--------N-610007BX0006-----------------------
INT 61 - Banyan VINES - TRANSLATE ERROR INTO ASCII STRING
	AX = 0007h
	BX = 0006h
	SI = error code (>100)
	DS:DX -> 80-byte buffer for error text
Return: AX = status
	    0000h successful
	    0001h network software not installed or incompatible
--------N-610007BX0007-----------------------
INT 61 - Banyan VINES - VERIFY EXISTENCE OF NAME AND RETURN CANONICAL FORM
	AX = 0007h
	BX = 0007h
	DS:DX -> NiceName block (see below)
Return: AX = status (see AX=0007h/BX=0002h)
SeeAlso: AX=0007h/BX=0005h,AX=0007h/BX=0008h

Format of NiceName block:
Offset	Size	Description
 00h	WORD	type of name
		0064h organization
		00C8h group
		012Ch item
 02h	WORD	pointer to ASCIZ input name
 04h	WORD	pointer to 64-byte buffer for output name
--------N-610007BX0008-----------------------
INT 61 - Banyan VINES - ENUMERATE StreetTalk NAMES
	AX = 0007h
	BX = 0008h
	DS:DX -> enumerate block (see below)
Return: AX = status
	    0000h successful
	    0411h all matching names have been returned
	    0412h some groups unavailable, all available matches returned
Note:	each program using this call should continue until a nonzero status
	  is returned; otherwise, some resources will not be freed for several
	  hours
SeeAlso: AX=0007h/BX=0007h

Format of enumerate block:
Offset	Size	Description
 00h	WORD	return code
 02h	WORD	pointer to pattern string
 04h	WORD	enumerate type
		0064h organization
		00C8h group
		012Ch item
 06h	WORD	enumerate class
		0000h unspecified (return all matching items)
		0001h user names
		0002h service names
		0003h list names
		0004h nicknames
 08h	WORD	pointer to category criteria block (see below) or 0
 0Ah	WORD	pointer to array of 64-byte returned names
 0Ch	WORD	number of names returned
 0Eh  6 BYTEs	reserved for subsequent enumerated calls (set to zeros on first
		  call)

Format of category criteria block:
Offset	Size	Description
 00h	WORD	exclude flag
		0000h return only items with the specified categories
		0001h return all items except those with the given categories
 02h	WORD	number of categories
 04h	WORD	category 1 value
 06h	WORD	category 2 value
		...

Values for common service categories:
 0002h	file service
 0003h	print service
 0004h	mail service
 0005h	StreetTalk
 0006h	time service
 0008h	semaphore service
 0009h	3270/SNA service
 000Ah	asynchronous terminal emulation service
 000Ch	NETBIOS service
 000Dh	PC-based service
--------V-610008-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync,ET-3000 chipset - SET ZOOM OFFSET
	AX = 0008h
	BX = X start of zoom offset
	CX = Y start of zoom offset
Desc:	specifies the first byte of video memory to appear in the zoom window
Notes:	INT 61 is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
	not all vendors include the Tseng TSR which supports these functions
SeeAlso: AX=0000h"OPTIMA",AX=0006h"OPTIMA",INT 16/AH=FFh"OPTIMA"
--------N-610008BX0002-----------------------
INT 61 - Banyan VINES - POST MESSAGE ON LOCAL DISPLAY
	AX = 0008h
	BX = 0002h
	CX = flags
	    bit 0: message will remain on screen until user presses ^X
	    bit 1: ring bell after displaying message
	    bit 2: blink
	DS:DX -> ASCIZ string to display (only first 80 chars used)
Return: AX = status
	    0000h successful
	    000Bh message display function currently busy
	    000Ch message queue full
Note:	queues up to three messages to be displayed on the bottom line
SeeAlso: AX=0008h/BX=0003h
--------N-610008BX0003-----------------------
INT 61 - Banyan VINES - INTERCEPT VINES 25th-LINE MESSAGES AT LOCAL PC
	AX = 0008h
	BX = 0003h
	DS:DX -> request block
Return: AX = status
	    0000h successful
	    0001h network software not installed or incompatible
Notes:	message handler should not call BIOS or DOS functions, and should
	  either call next handler or simply return
	to stop intercepting messages, set prev and next request blocks to
	  point at each other
SeeAlso: AX=0008h/BX=0002h

Format of request block:
Offset	Size	Description
 00h	DWORD	pointer to user-written message handler
 04h	DWORD	pointer to next request block (filled in by VINES)
 08h	DWORD	pointer to previous request block (filled in by VINES)
 0Ch	DWORD	pointer to message storage area (filled by VINES) (see below)

Format of message storage area:
Offset	Size	Description
 00h 16 BYTEs	IPC port of message sender (see AX=0001h#"Sosock")
 10h	BYTE	message flags
 11h	WORD	reserved
 13h	BYTE	length of message
 14h 80 BYTEs	message text
--------N-61000A-----------------------------
INT 61 - Banyan VINES - SECONDARY 3270 INTERFACE
	AX = 000Ah
Note:	either 3270/SNA or 3270/BSC interface will use AX=000Ah, depending on
	  which is loaded second.  The first interface loaded will use AX=0002h
SeeAlso: INT 61/AX=0002h
--------N-6101-------------------------------
INT 61 - Banyan VINES - CHECK SERVICE
	AH = 01h
	AL = service ID (see below)
Return: AX = status
	    0000h installed
	    0001h not installed
	    0002h invalid ID

Values for service ID:
 01h	communications
 02h	primary 3270 emulation
 03h	async terminal emulation
 04h	file deflection
 07h	StreetTalk
 08h	environment
 0Ah	secondary 3270 emulation
 0Bh	semaphore service
 0Ch	3270 emulation active status
 0Dh	3270 keyboard interrupt simulator
--------N-6101--BX0000-----------------------
INT 61 u - PC/TCP kernel v2.1+ - "net_config" - CONFIGURE RUNNING KERNEL
	AH = 01h
	BX = 0000h
	DH = tag number
	DL = device number
	DS:SI -> buffer to send to kernel
	ES:DI -> integer containing size of buffer
Return: CF clear if successful
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Notes:	there are a large number of tags available; the items returned
	  all refer to local kernel configuration, and are not needed in
	  normal use.
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=02"PC/TCP"
--------N-6102-------------------------------
INT 61 - Banyan VINES - GET REVISION NUMBER
	AH = 02h
	DS:DX -> 2-byte buffer for result
Return: AX = 0000h installed
	    DS:DX buffer contains revision number as
		10000d * major_ver + 100d * minor_ver + patch_revision
--------N-6102--BX0000-----------------------
INT 61 u - PC/TCP kernel v2.1+ - "get_kernel_info" - GET MISCELLAN LOCAL INFO
	AH = 02h
	BX = 0000h
	DH = tag number
	DL = device number
	DS:SI -> buffer for result (up to 48 bytes for version <= 2.2)
	ES:DI -> integer containing size of buffer
Return: CF clear if successful
	    Data loaded into specified buffer, and size value altered
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Notes:	there are a large number of tags available; the items returned
	  all refer to local kernel configuration, and are not needed in
	  normal use.
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=01h"PC/TCP"
--------N-6105-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "get_addr" - GET INTERNET ADDRESS OF NET DESCR
	AH = 05h
	BX = network descriptor
Return: CF clear if successful
	    DX:AX = Internet address of ND
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Notes:	the installation check consists of testing for the signature "TCPTSR"
	  three bytes beyond the start of the interrupt handler
	INT 61 is the default; PC/TCP v2.05 may be configured to use any
	  interrupt from 20h through E0h
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=16h"PC/TCP"
SeeAlso: INT 63/AH=25h"BW-TCP"
--------N-6106-------------------------------
INT 61 - PC/TCP kernel v2.05 - "net_info" - GET INTERFACE STATISTICS
	AH = 06h
	BX = network descriptor (must be allocated and open)
	DS:SI -> 38-byte buffer (see below)
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Desc:	returns the statistics relevant to the particular network interface
	   used by the specified network descriptor
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=05h"PC/TCP"

Format of buffer:
Offset	Size	Description
 00h	WORD	interface class (e.g. 802.3)
 02h	WORD	type (manufacturer) of interface
 04h	WORD	interface number
 06h	DWORD	(big-endian) IP address of interface
 0Ah	DWORD	subnet mask
 0Eh	WORD	0001h if interface is up
 10h	DWORD	total packets received
 14h	DWORD	total packets sent
 18h	DWORD	receive errors
 1Ch	DWORD	send errors
 20h	WORD	length of local net address (e.g. 0006h for Ethernet)
 22h	DWORD	pointer to local net address
--------N-6107-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_globalize" - MAKE NET DESCRIPTOR GLOBAL
	AH = 07h
	BX = local network descriptor
Return: CF clear if successful
	    AX = global network descriptor
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Notes:	the new network descriptor can be accessed from all processes and is
	  independent of DOS
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=08h"PC/TCP"
SeeAlso: INT 61/AH=29h
--------N-6108-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_release" - CLOSE A NETWORK DESCRIPTOR
	AH = 08h
	BX = network descriptor
Return: CF clear if successful
	    AX = 0000h (BWPCTCP shim)
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	the descriptor will be closed and resources released.  If a stream
	  descriptor, the protocol (FIN etc) is completed unless the
	  non-blocking option has been set.
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=09h"PC/TCP"
SeeAlso: INT 63/AH=0Eh"BW-TCP"
--------N-6109-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_releaseall" - CLOSE ALL NON-GLOBAL DESCRS
	AH = 09h
Return: CF clear
Notes:	this call performs function 08h on every non-global network descriptor.
	  Global descriptors must be released individually.
	INT 61 is the default; PC/TCP v2.05 may be configured to use any
	  interrupt from 20h through E0h
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=08h"PC/TCP"
SeeAlso: INT 63/AH=0Eh"BW-TCP"
--------N-610A-------------------------------
INT 61 - PC/TCP kernel v2.05 - "net_send" - ???
	AH = 0Ah
	???
Return: ???
Notes:	this function is described as "unused" in the v2.05 and v2.2
	  documentation
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: AH=0Bh
--------N-610B-------------------------------
INT 61 - PC/TCP kernel v2.05 - "net_sendto" - ???
	AH = 0Bh
	???
Return: ???
Notes:	this function is described as "unused" in the v2.05 and v2.2
	  documentation
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: AH=0Ah
--------N-610C-------------------------------
INT 61 u - PC/TCP kernel v2.05+ - "net_stat" - GET CONNECTION STATISTICS
	AH = 0Ch
	BX = network descriptor or one of the following:
	    FFFCh for kernel ICMP statistics
	    FFFDh for kernel UDP statistics
	    FFFEh for kernel IP statistics
	    FFFFh for kernel TCP statistics
	DS:DX -> 64-byte buffer
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Notes:	the fields filled in for a network descriptor depend on the protocol
	  family used by that descriptor's connection
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP"

Format of kernel TCP statistics:
Offset	Size	Description
 00h 16 BYTEs	unused
 10h	DWORD	bytes sent
 14h	DWORD	bytes received
 18h  8 BYTEs	unused
 20h	DWORD	packets sent
 24h	DWORD	packets received
 28h	DWORD	bad checksums
 2Ch	DWORD	count of window ignored by remote
 30h	DWORD	timeouts
 34h	DWORD	resets
 38h	DWORD	duplicate packets
 3Ch	DWORD	retransmits

Format of kernel IP statistics:
Offset	Size	Description
 00h  8 BYTEs	unused
 08h	DWORD	invalid IP header length errors
 0Ch	DWORD	protocol errors (unwanted packets)
 10h	DWORD	duplicate fragments received
 14h	DWORD	bad fragments received
 18h	DWORD	security errors
 1Ch	DWORD	count of bad IP addresses received
 20h	DWORD	packets sent
 24h	DWORD	packets received
 28h	DWORD	bad checksums received
 2Ch	DWORD	total IP protocol errors
 30h	DWORD	fragmentation errors
 34h	DWORD	IP packets discarded + bad security + bad fragments
 38h	DWORD	fragments received
 3Ch  4 BYTEs	unused

Format of kernel UDP statistics:
Offset	Size	Description
 00h 28 BYTEs	unused
 1Ch	DWORD	packets dropped for lack of buffers
 20h	DWORD	packets sent
 24h	DWORD	packets received
 28h	DWORD	bad checksums
 2Ch	DWORD	port not listening errors
 30h  4 BYTEs	unused
 34h	DWORD	truncated receives
 38h  8 BYTEs	unused

Format of kernel ICMP statistics:
Offset	Size	Description
 00h	DWORD	"TimeEx" sent
 04h	DWORD	"TimeEx" received
 08h	DWORD	"ParamProb" sent
 0Ch	DWORD	"ParamProb" received
 10h	DWORD	redirects received
 14h	DWORD	source quenches received
 18h	DWORD	ICMP Echo Requests ("ping") sent
 1Ch	DWORD	ICMP Echo Requests received
 20h	DWORD	packets sent
 24h	DWORD	packets received
 28h	DWORD	bad packets received
 2Ch	DWORD	"DestUn" received
 30h	DWORD	packet send errors
 34h	DWORD	"DestUn" sent
 38h	DWORD	ICMP Echo replies received
 3Ch	DWORD	ICMP Echo replies sent
--------N-610D-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "is_netnd" - CHECK IF NETWORK DESCRIPTOR VALID
	AH = 0Dh
	BX = possible network descriptor
Return: CF clear if valid
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=08h"PC/TCP"
SeeAlso: INT 61/AH=22h
--------N-610E-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_select" - DETECT READINESS OF NETWORK
	AH = 0Eh
	BX = maximum value of network descriptor for which to return info
	DS:DX -> 32-bit (max) array of bit flags for read readiness
	ES:DI -> 32-bit (max) array of bit flags for write readiness
Return: CF clear
Notes:	bits in the DS:DX buffer are set if the corresponding network
	  descriptor may be read without blocking; bits in the ES:DI buffer
	  are set if the corresponding network descriptor may be written
	  without blocking.  This implies that the network descriptor has
	  opened correctly and the protocol initialized.
	the installation check consists of testing for the signature "TCPTSR"
	  three bytes beyond the start of the interrupt handler
	INT 61 is the default; PC/TCP v2.05 may be configured to use any
	  interrupt from 20h through E0h
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP"
--------N-610F-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "get_netversion" - GET SOFTWARE VERSION
	AH = 0Fh
Return: CF clear
	AX = version (AH = major, AL = minor)
	BX = patch level
Notes:	patch levels are no longer used starting with version 2.10; instead,
	  the minor version level is incremented.
	Beame&Whiteside's BWPCTCP v3.0a shim reports version 2.05, but does not
	  set BX
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP"
--------N-6110-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_shutdown" - UNINSTALL
	AH = 10h
Return: CF clear if successful
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP"
--------N-6111-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "disable_async" - DISABLE ASYNCHRONOUS HANDLERS
	AH = 11h
Return: CF clear
	AX = previous state
	    0000h async calls were already disabled
	    else  async calls were enabled
SeeAlso: INT 61"PC/TCP",INT 61/AH=12h
--------N-6112-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "enable_async" - ENABLE ASYNCHRONOUS HANDLERS
	AH = 12h
Return: CF clear
	AX = previous state
	    0000h async calls were disabled
	    else  async calls were already enabled
SeeAlso: INT 61"PC/TCP",INT 61/AH=11h
--------N-6113-------------------------------
INT 61 - PC/TCP kernel v2.05 - "net_connect" - OPEN A NETWORK CONNECTION
	AH = 13h
	BX = network descriptor (FFFFh for automatic net_getdesc)
	DX = protocol (see below)
	DS:SI -> buffer for "addr" structure (see below)
Return: CF clear if successful
	    AX = network descriptor used or allocated
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Notes:	invokes AH=22h if BX=FFFFh on entry; also invokes AH=19h in various
	  cases
	will wait for protocol on stream connections unless non-blocking was
	  set with AH=20h
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=18h,INT 61/AH=23h
SeeAlso: INT 63/AH=14h"BW-TCP"

Values for protocol:
 0001h	raw net (undocumented)
 0002h	raw IP
 0003h	datagram (UDP)
 0004h	stream (TCP)
 0005h	raw ICMP

Format of structure "addr":
Offset	Size	Description
 00h	DWORD	Internet address (network order)
 04h	WORD	remote socket number (network order)
 06h	WORD	local socket number (network order) 0000h means "you choose"
 08h	BYTE	protocol (see above)
--------N-6114-------------------------------
INT 61 Ou - PC/TCP kernel v2.05 - "net_recv" - NO LONGER SUPPORTED
	AH = 14h
	BX = network descriptor
Return: CF set
	    AX = 0018h (see INT 61"PC/TCP")
Notes:	displays error message "Illegal system call!  Please upgrade your
	  PCserver software" to standard output
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=0Ah,INT 61/AH=15h
--------N-6115-------------------------------
INT 61 - PC/TCP kernel v2.05 - "net_recvfrom" - ???
	AH = 15h
	???
Return: ???
Notes:	this function is described as "unused" in the v2.2 documentation
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61/AH=0Bh,INT 61/AH=14h
--------N-6116-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_peer" - GET DATA ON REMOTE PEER
	AH = 16h
	BX = network descriptor
	DS:DX -> 9-byte buffer for "addr" structure (see AH=13h)
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP"
--------N-6117-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_reconfig" - RE-READ KERNEL CONFIGURATION
	AH = 17h
Return: CF clear if successful
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Notes:	this routine is deprecated in v2.1+ and will eventually be withdrawn;
	  in v2.1+, this function calls AH=01h which should be used instead
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=01h"PC/TCP"
--------N-6118-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_eof" - CLOSE TRANSMIT SIDE OF CONNECTION
	AH = 18h
	BX = network descriptor
Return: CF clear if successful
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	a TCP "FIN" command is sent and no further data may be transmitted,
	  although the connection remains open
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=13h"PC/TCP"
SeeAlso: INT 63/AH=0Eh"BW-TCP"
--------N-6119-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_abort" - RESET A NETWORK CONNECTION
	AH = 19h
	BX = network descriptor
Return: CF clear if successful
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Desc:	immediately destroys the specified connection
Note:	send a TCP "RST" command if a stream connection is open
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=24h
--------N-611A-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_write" - WRITE TO THE NETWORK
	AH = 1Ah
	BX = network descriptor
	CX = number of bytes to transmit (0000h allowed)
	DX = send options (see below)
	DS:SI -> data to be written
Return: CF clear if successful
	    AX = number of bytes actually written
	    DX = ???
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Notes:	the installation check consists of testing for the signature "TCPTSR"
	  three bytes beyond the start of the interrupt handler
	INT 61 is the default; PC/TCP v2.05 may be configured to use any
	  interrupt from 20h through E0h
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=1Bh,INT 61/AH=1Ch
SeeAlso: INT 63/AH=19h"BW-TCP",INT 63/AH=1Bh"BW-TCP"

Bitfields for send options:
 bit 0	signal "URG"ent data
 bit 3	attempt rerouting on non-stream calls if first attempt fails
 bit 4	send data with PUSH flag (no override of Nagle)
	(see option 0Ch)
 bit 5	fail rather than truncating datagram
 bit 6	fail rather than blocking
 bit 7	broadcast packet
--------N-611B-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_read" - READ FROM THE NETWORK
	AH = 1Bh
	BX = network descriptor
	CX = maximum number of bytes to read
	DX = receive options (see below)
	DS:SI -> buffer for data
	ES:DI -> "addr" structure (see AH=13h) for remote from which to read
		0000h:0000h for any
Return: CF clear if successful
	    AX = number of bytes actually read
	    DX = ???
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=1Ah,INT 61/AH=1Dh

Bitfields for receive options:
 bit 1	do not remove data from queue, just copy it
 bit 2	do not copy data, just remove it from queue
 bit 5	fail if datagram would be truncated
 bit 6	do not block, return error if no data available
Note:	special case for UDP: if both bits 1 and 2 set, return num of datagrams
--------N-611C-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_writeto" - WRITE A DATAGRAM
	AH = 1Ch
	BX = network descriptor
	CX = number of bytes to transmit (0000h allowed)
	DX = send options (see AH=1Ah)
	DS:SI -> data to be written
	ES:DI -> "addr" structure (see AH=13h)
Return: CF clear if successful
	    AX = number of bytes actually written
	    DX = ???
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	this function differs from AH=1Ah in that the address and socket
	  numbers can be overridden
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=1Ah,INT 61/AH=1Dh
SeeAlso: INT 63/AH=21h"BW-TCP"
--------N-611D-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_readfrom" - READ A DATAGRAM
	AH = 1Dh
	BX = network descriptor
	CX = maximum number of bytes to read
	DX = receive options (see AH=1Bh)
	DS:SI -> buffer for received data
	ES:DI -> 9-byte buffer containing "addr" structure (see AH=13h)
Return: CF clear if successful
	    AX = number of bytes read
	    DX = ???
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Notes:	this function can read from any host or a designated host depending
	  on settings in the "addr" structure
	only for use with datagram or Raw descriptors
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=1Bh,INT 61/AH=1Ch
--------N-611E-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_flush" - FLUSH PENDING DATA
	AH = 1Eh
	BX = network descriptor
Return: CF clear if successful
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Notes:	bufferred data is transmitted immediately, overriding Nagle's algorithm
	  if necessary
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP"
--------N-611F-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_asynch" - SET UP ASYNCHRONOUS CALL-BACK
	AH = 1Fh
	BX = network descriptor
	CX = event type (see below)
	DS:SI -> event handler routine
	ES:DI = 32-bit hint passed to handler
Return: CF clear if successful
	    DS:DX -> previous handler
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	ICMP messages do not trigger events on stream connections
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP"

Values for event type:
 00h	alarm
 01h	open (successfully opened stream connection)
 02h	receive (data available)
 03h	transmit (ACK received on stream connection)
 04h	transmit flush???
 05h	foreign close (remote host closed data connection)
 06h	close (local host closed connection and protocol is complete)
 07h	error (error code passed to handler as arg)

Event handler called with:
	BX = network descriptor
	CX = event type (see above)
	DS:DX -> arg
	ES:DI = 32-bit hint value
	STACK:	small stack, possibly the DOS stack
--------N-6120-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "set_option" - SET AN OPTION ON A DESCRIPTOR
	AH = 20h
	BX = network descriptor
	CX = length of buffer (usually 04h)
	DS:DX -> buffer containing option
	SI = (ignored by v2.2-)
	DI = option to set (see below)
Return: CF clear if successful
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	Beame&Whiteside's BWPCTCP shim only supports options 01h and 0Bh; all
	  others return CF clear
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=21h

Values for option to set:
 01h	set non-blocking mode if non-zero
 02h	timeout of call in milliseconds
 03h	user-defined 4-byte magic cookie (not used by kernel)
 04h	TCP window or UDP buffer count (WORD, unsigned)
 06h	do TCP keep-alives if non-zero
 09h	(v2.1+) set IP precedence
 0Ah	(v2.1+) set IP type of service
 0Bh	use a privileged port if port = 0
 0Ch	turn off TCP PUSH bit and don't flush buffer every write (see AH=1Ah)
Note:	use "C" true or false values for boolean options
--------N-6121-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "get_option" - GET OPTIONS APPLIED TO NET DESCR
	AH = 21h
	BX = network descriptor
	CX = length of buffer
	DS:DX -> buffer for return values
	SI = 0004h (ignored by v2.2-)
	DI = option (see AH=20h)
Return: CF clear if successful
	    DS:DX -> value (usually 32 bits) returned by selected option
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=20h
--------N-6122-------------------------------
INT 61 u - PC/TCP kernel v2.05+ - "net_getdesc" - ALLOCATE NETWORK DESCRIPTOR
	AH = 22h
Return: CF clear if successful
	    AX = network descriptor
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	the descriptor will be an integer in the range 00h-1Fh, and a DOS call
	  is made to allocate this as a file descriptor.  Hence a number may
	  not refer to a PC/TCP network descriptor and a DOS file handle
	  simultaneously.
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=13h,INT 61/AH=29h
--------N-6123-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_listen" - LISTEN FOR INCOMING CONNECTIONS
	AH = 23h
	BX = network descriptor or FFFFh to allocate descriptor
	DX = type of service
	DS:SI -> "addr" structure (see AH=13h)
Return: CF clear if successful
	    AX = network descriptor
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Notes:	type of service and "addr" structure are as for AH=13h
	any of the address structure can be zero; normally local socket number
	  is filled in prior to call
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=13h
SeeAlso: INT 63/AH=12h"BW-TCP"
--------N-6124-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_abortall" - RESET ALL NETWORK CONNECTIONS
	AH = 24h
Return: always successful
Note:	performs "net_abort" (AH=19h) on all open non-global descriptors
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=19h
--------N-6125-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "ad_res_name" - GET HOST NAME GIVEN ADDRESS
	AH = 25h
	DX,BX = IP address in network order
	CX = length of buffer for name
	DS:SI -> buffer for host name
Return: CF clear if successful
	   buffer filled with ASCIZ host name
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	this function will use the host table and or DNS to resolve the
	  address, depending on kernel configuration.  Use this call for the
	  normal gethostbyaddr function.
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=26h,INT 61/AH=27h
--------N-6126-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "ad_htable" - GET HOST NAME FROM LOCAL TABLE
	AH = 26h
	DX,BX = IP address in network order
	CX = length of buffer
	DS:SI -> buffer for host name
Return: CF clear if successful
	    buffer filled with ASCIZ host name
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Notes:	normally one would use AH=25h instead of this function
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=25h,INT 61/AH=27h
--------N-6127-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "ad_domain" - GET HOST NAME FROM DNS
	AH = 27h
	DX,BX = IP address in network order
	CX = length of buffer
	DS:SI -> buffer for host name
Return: CF clear if successful
	    buffer filled with ASCIZ host name
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	normally one would use AH=25h instead of this function
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=25h,INT 61/AH=26h
--------N-6128-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_swap" - EXCHANGE TWO NETWORK DESCRIPTORS
	AH = 28h
	BX = network descriptor 1
	CX = network descriptor 2
Return: CF clear if successful
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	the two descriptors will exchange places; both must be local or both
	  global
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP"
--------N-6129-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "net_getglobdesc" - ALLOCATE GLOBAL DESCRIPTOR
	AH = 29h
Return: CF clear if successful
	    AX = network descriptor
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	use this function rather than AH=22h to avoid a DOS call by the PC/TCP
	  kernel; the returned descriptor will be >= 40h and cannot be used
	  with "net_select" (AH=0Eh)
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=07h"PC/TCP"
SeeAlso: INT 61/AH=22h
--------N-612A-------------------------------
INT 61 - PC/TCP kernel v2.05+ - GET CONFIGURATION INFORMATION
	AH = 2Ah
	DS:SI -> 26-byte buffer for configuration information (see below)
Return: CF clear
	AX = 0000h
	buffer filled
Notes:	size of buffer may vary with kernel version; 26 bytes is the size for
	  versions 2.05 through 2.2
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP"

Format of configuration information:
Offset	Size	Description
 00h	BYTE	maximum TCP connections available
 01h	BYTE	maximum UDP connections available
 02h	BYTE	maximum IP connections available
 03h	BYTE	maximum Raw Net connections available
 04h	BYTE	number of TCP connections currently in use
 05h	BYTE	number of UDP connections currently in use
 06h	BYTE	number of IP connections currently in use
 07h	BYTE	number of Raw Net connections currently in use
 08h	WORD	number of local network descriptors active
 0Ah	WORD	number of global network descriptors active
 0Ch	BYTE	maximum header size on network
 0Dh	BYTE	maximum trailer size on network
 0Eh	WORD	size of large packet buffer
 10h	WORD	number of network interfaces attached
 12h	DWORD	milliseconds since kernel started
 16h	DWORD	IP broadcast address
--------N-612B-------------------------------
INT 61 - PC/TCP kernel v2.02+ - "net_alarm" - SET TIMED ASYNCHRONOUS EVENT
	AH = 2Bh
	BX = network descriptor
	CX,DX = time before alarm in milliseconds
	DS:SI -> handler which will receive call (see INT 61/AH=1Fh)
	ES:DI = 32-bit cookie passed to handler
Return: CF clear if successful
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Notes:	this function will case a NET_AS_ALARM to be generated; it is intended
	  for TSRs, etc. to regain control periodically
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP"
--------N-6130-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "icmp_ping" - SEND ICMP ECHO REQUEST (PING)
	AH = 30h
	BX,DX = IP address of host
	CX = length of data to send
Return: CF clear if successful (i.e. reply received)
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP"
--------N-61---------------------------------
INT 61 u - PC/TCP kernel v2.05 - NOP for SLIP kernel
	AH = function
	    31h "net_add_route"
	    32h "net_del_route"
	    33h "net_dump_routes"
Notes:	these functions are described as "unused" in the v2.2 documentation
	router configuration can be altered using INT 61/AH=01h
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
--------N-6134-------------------------------
INT 61 U - PC/TCP kernel v2.1+ - "icmp_destun" - ???
	AH = 34h
	???
Return: ???
Notes:	this function is described as "reserved" in the v2.2 documentation
	this function is not supported by Beame&Whiteside's BWPCTCP v3.0a shim
--------N-6150-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "nm_prs_addr" - TRANSLATE NUMERICAL IP ADDRESS
	AH = 50h
	DS:DX -> ASCIZ IP address as "dotted quad" (max 127 chars)
Return: CF clear if successful
	    DX:AX -> IP address
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=54h
--------N-6151-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "nm_htable" - RESOLVE NAME USING HOST TABLE
	AH = 51h
	CX = size of destination buffer
	DS:DX -> ASCIZ host name (max 127 chars)
	ES:DI -> destination buffer or 0000h:0000h
Return: CF clear if successful
	    DX:AX -> IP address of host
	    destination buffer filled with canonical host name
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	this function calls DOS, and can fail if the DOS call fails
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=54h
--------N-6152-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "nm_domain" - RESOLVE NAME USING DNS
	AH = 52h
	CX = size of destination buffer
	DS:DX -> ASCIZ host name (max 127 chars)
	ES:DI -> destination buffer or 0000h:0000h
Return: CF clear if successful
	    DX:AX -> IP address of host
	    destination buffer filled with canonical host name
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	this function will poll all configured domain name servers if necessary
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=54h
--------N-6153-------------------------------
INT 61 - PC/TCP kernel v2.05- - "nm_ien116" - RESOLVE HOST NAME USING IEN116
	AH = 53h
	DS:DX -> ASCIZ name to be resolved (max 127 chars)
Return: CF clear if successful
	    DX:AX -> IP address of host
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	this function is not supported by v2.10+
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=54h
--------N-6154-------------------------------
INT 61 - PC/TCP kernel v2.05+ - "nm_res_name" - RESOLVE HOST NAME
	AH = 54h
	CX = size of destination buffer
	DS:DX -> ASCIZ host name (max 127 chars)
	ES:DI -> destination buffer or 0000h:0000h
Return: CF clear if successful
	    DX:AX -> IP address of host
	    destination buffer filled with canonical host name
	CF set on error
	    AX = error code (see INT 61"PC/TCP")
Note:	this function uses all configured methods in turn to resolve the
	  name (numerical, then host table, then DNS, then IEN116)
BUG:	the SLIP kernel for v2.05 bounds-checks the wrong register, so values
	  greater than 54h in AH may crash the system.	Other kernels may have
	  this bug as well; it has been fixed in the v2.2 SLIPDRV kernel.
SeeAlso: INT 61"PC/TCP",INT 61/AH=00h"PC/TCP",INT 61/AH=50h,INT 61/AH=51h
SeeAlso: INT 61/AH=52h,INT 61/AH=53h
--------*-62---------------------------------
INT 62 - reserved for user interrupt
--------d-62---------------------------------
INT 62 - Adaptec and OMTI controllers - DRIVE 0 DATA
Notes:	this vector stores the third four bytes of the parameter table for
	  hard disk 0
SeeAlso: INT 60"Adaptec",INT 61"Adaptec",INT 63"Adaptec"
--------b-62---------------------------------
INT 62 - HP 95LX - USED BY CALCULATOR
SeeAlso: INT 60"HP 95LX"
----------62---------------------------------
INT 62 - MS SQL Server/Sybase DBLIBRARY interface - ???
	AH = function (00h to 07h)
	CX = FFFEh
	DX = FFFFh
	???
Return: ???
Note:	the installation check consists of testing for the string "DBLIBRARY"
	  2 bytes past the interrupt handler
SeeAlso: AH=08h"SQL"
Index:	installation check;MS SQL Server|installation check;Sybase DBLIBRARY
--------N-62---------------------------------
INT 62 - BW-TCP - HARDWARE DRIVER (ETHDEV.SYS) - API
	AH = function
	    00h get physical hardware address
		DS:DX -> 6-byte buffer for address
		Return: AX = length of hardware address???
	    01h NOP for ETHDEV.ODI
	    02h initialize
	    03h get real IP address
		DS:SI -> DWORD buffer for IP address
	    04h set ???
		BX = ???
		ES:SI -> FAR routine for ???
	    05h ???
	    06h ???
	    07h ???
		DS:SI -> ???
	    08h ???
		CX = ???
		ES:SI -> func08 buffer
	    09h hook timer interrupt
		Return: AX = handler ID if successful
	    0Ah unhook timer interrupt
		DX = handler ID
	    0Bh add ???
		AL = ???
		DX = ???
		BP = ???
		ES:SI -> ???
	    0Ch remove ???
		DX = ???
		BP = ???
	    0Dh NOP for ETHDEV.ODI
	    0Eh begin critical section
	    0Fh end critical section
	    10h query critical section
		Return: CF clear if no critical section active
			CF set if in critical section
	    11h set ???
		ES:SI -> ???
		Return: CF clear
	    12h get ?
		Return: AX = ??? (memory variable incremented after reading)
	    13h ???
		CX = ???
		Return: AL = 00h if CF clear
	    14h ???
		ES:SI -> ???
		Return: AL = 00h if CF clear
	    15h get ??? (call after reading ETHDEV27 device)
		Return: AX = ??? (destroyed???)
	    16h ???
	    17h ???
		DX = segment of ???
		Return: Cf clear
	    18h allocate and map EMS for driver
		Note: calls function 17h after EMS allocated and mapped
	    FEh map EMS
		00h map in driver's memory
		01h map out driver's memory
Return: CF clear if successful
	CF set on error
	    AL = error code
Note:	the Beame&Whiteside TCP/IP protocol stack uses two consecutive
	  interrupts (62h and 63h by default); the BW-NFS client uses a third
	  consecutive interrupt (64h by default) if it is loaded
SeeAlso: AH=FEh,INT 21/AH=3Fh"BW-TCP",INT 63"BW-TCP",INT 64"BW-NFS"

Format of func08 buffer:
Offset	Size	Description
 00h  6 BYTEs	hardware address???
 06h  6 BYTEs	???
 0Ch	WORD	???
 0Eh	WORD	???
--------V-620000-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETMODE" - GET CURRENT VIDEO MODE NUMBER
	AX = 0000h
	ES:BX -> ???
Return: AX = current video mode number
Notes:	FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
	the installation check consists of testing for the signature "FG" ten
	  bytes beyond the start of the interrupt handler
SeeAlso: AX=0001h,AX=0006h
Index:	installation check;Fastgraph/Light
--------V-620001-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SETMODE" - SELECT VIDEO MODE AND INITIALIZE
	AX = 0001h
	BX = new video mode or FFFFh for current mode
	ES:DX -> ???
Notes:	video modes are the same as the BIOS video modes except for
		0Bh Hercules graphics 720x348
		0Ch Hercules graphics 320x200
		15h VGA graphics 320x400x256
		16h VGA graphics 320x240x256
		17h VGA graphics 320x480x256
	this call resets the active video page to page 0000h, the clipping
	  region to the entire screen, text rows to 25, etc.
SeeAlso: AX=0000h,AX=0002h,INT 10/AH=00h
--------V-620002-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_TESTMODE" - CHECK IF VIDEO MODE AVAILABLE
	AX = 0002h
	BX = desired video mode (00h-17h)
	CX = required number of video pages (ignore memory size if <= 0)
Return: AX = status
	    0000h mode not available with requested number of pages
	    0001h mode is available
SeeAlso: AX=0001h,AX=0003h,AX=0004h,AX=0005h
--------V-620003-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_BESTMODE" - GET BEST VIDEO MODE GIVEN RESOLUTN
	AX = 0003h
	BX = horizontal resolution
	CX = vertical resolution
	DX = number of video pages required (both physical and virtual)
Return: AX = proposed video mode number or FFFFh if no matching video mode
SeeAlso: AX=0002h,AX=0004h
--------V-620004-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_AUTOMODE" - GET VIDEO MODE WITH MOST FEATURES
	AX = 0004h
Return: AX = proposed video mode number
Note:	FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
SeeAlso: AX=0002h,AX=0003h,AX=0005h
--------V-620005-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_EGACHECK" - GET INFO ABOUT ACTIVE EGA DISPLAY
	AX = 0005h
Return: AX = number of 64K banks of video memory, or 0000h if no EGA or EGA
		without an Enhanced Color Display
SeeAlso: AX=0002h,AX=0003h
--------V-620006-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_RESET" - ERASE SCREEN AND RESTORE SCREEN ATTR
	AX = 0006h
Notes:	this call is ignored in graphics modes
	the screen attributes are only restored if ANSI.SYS is loaded
SeeAlso: AX=0000h
--------V-620007-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_CURSOR" - SPECIFY WHETHER TEXT CURSR IS VISIBLE
	AX = 0007h
	BX = new state (0000h invisible, 0001h visible)
Note:	this call is ignored in text modes
--------V-620008-----------------------------
INT 62 - FGDRIVER v1.10 - UNUSED
	AX = 0008h to 0009h
Return: AX = 0000h
--------V-62000A-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETMAXX" - GET MAXIMUM COLUMN IN SCREEN SPACE
	AX = 000Ah
Return: AX = maximum X coordinate in screen space
		(or character space if in text mode)
SeeAlso: AX=000Bh,AX=0045h
--------V-62000B-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETMAXY" - GET MAXIMUM ROW IN SCREEN SPACE
	AX = 000Bh
Return: AX = maximum Y coordinate in screen space
		(or character space if in text mode)
SeeAlso: AX=000Ah,AX=0045h
--------V-62000C-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_XALPHA" - CONVERT SCREEN COLUMN TO CHAR COLUMN
	AX = 000Ch
	BX = screen space column
Return: AX = character space column containing specified coordinate
SeeAlso: AX=000Dh,AX=000Eh
--------V-62000D-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_YALPHA" - CONVERT SCREEN ROW TO CHARACTER ROW
	AX = 000Dh
	BX = screen space row
Return: AX = character space row containing specified coordinate
SeeAlso: AX=000Ch,AX=000Fh
--------V-62000E-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_XCONVERT" - CONVERT CHAR COLUMN TO SCREEN COL
	AX = 000Eh
	BX = character space column
Return: AX = screen space column of leftmost pixel in specified character col
SeeAlso: AX=000Ch,AX=000Fh
--------V-62000F-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_YCONVERT" - CONVERT CHARACTER ROW TO SCREEN ROW
	AX = 000Fh
	BX = character space row
Return: AX = screen space row of topmost pixel in specified character row
SeeAlso: AX=000Dh,AX=000Eh
--------V-620010-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETLINES" - GET TEXT ROWS FOR CURR VIDEO MODE
	AX = 0010h
Return: AX = number of text rows on screen in current video mode
SeeAlso: AX=0011h
--------V-620011-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SETLINES" - SET TEXT ROWS ON SCREEN
	AX = 0011h
	BX = new screen size (25, 43, 50)
SeeAlso: AX=0010h
--------V-620012-----------------------------
INT 62 - FGDRIVER v1.10 - UNUSED
	AX = 0012h to 0013h
Return: AX = 0000h
--------V-620014-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_DEFCOLOR" - ASSIGN COLOR VALUE TO COLOR INDEX
	AX = 0014h
	BX = color index (0000h-00FFh)
	CX = new color value (0 to maximum color value for current video mode)
Note:	this call is ignored in text modes and 256-color graphics modes
SeeAlso: AX=0015h,AX=0016h,AX=001Dh
--------V-620015-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETCOLOR" - GET CURRENT TEXT ATTRIBUTE
	AX = 0015h
Return: AX = current text attribute or color index (graphics modes)
Note:	FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
SeeAlso: AX=0019h,AX=001Ah
--------V-620016-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETINDEX" - GET COLOR VALUE FOR COLOR INDEX
	AX = 0016h
	BX = color index (0000h to 00FFh)
Return: AX = color value for specified color index
Note:	this call returns the value passed to it in text and 256-color
	  graphics modes
SeeAlso: AX=0014h,AX=001Ch
--------V-620017-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_PALETTE" - SET PALETTE / SET VIDEO DAC REGISTER
	AX = 0017h
---CGA 4-color graphics---
	BX = CGA paletee number
	CX = background color
---CGA 2-color graphics---
	BX ignored
	CX = foreground color
---16-color graphics---
	BX = palette register number
	CX = palette value
---256-color graphics---
	BX = DAC register number
	CX =  DAC value
Notes:	ignored in text modes and Hercules graphics modes
	few EGA/VGA adapters correctly set the foreground color in CGA mode 6
SeeAlso: AX=0018h,AX=001Dh
--------V-620018-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_PALETTES" - SET ALL PALETTE REGISTERS
	AX = 0018h
	ES:BX -> array of 16 WORDs containing values for palette registers
		(or first 16 DAC registers in 256-color modes)
Note:	ignored in text modes, CGA and Hercules graphics modes
SeeAlso: AX=0017h
--------V-620019-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SETATTR" - SET TEXT-MODE CHARACTER ATTRIBUTE
	AX = 0019h
	BX = foreground
	CX = background
	DX = blink (0000h nonblinking, 0001h blink)
Note:	this call is ignored in graphics modes
SeeAlso: AX=0015h,AX=001Ah,AX=0037h
--------V-62001A-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SETCOLOR" - SET CURRENT COLOR
	AX = 001Ah
	BX = new color index (or text attribute in text modes)
SeeAlso: AX=0015h,AX=0019h
--------V-62001B-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SETRGB" - SET VIDEO DAC REGISTER CONTENTS
	AX = 001Bh
	BX = palette or DAC register number
	CX = red color component
	DX = green component
	SI = blue component
Notes:	the register number may be negative for Tandy, PCjr, and 200-line
	  EGA graphics modes to specify an intense color
	this call has no effect in text, CGA graphics, and Hercules graphics
	  modes
SeeAlso: AX=001Ch,AX=00A5h
--------V-62001C-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETRGB" - GET VIDEO DAC REGISTER CONTENTS
	AX = 001Ch
	ES:BX -> variable pointer record (see below)
	CX = DAC register number
Return: variables updated
Note:	this call is ignored in text modes and CGA/EGA video modes (since
	  they do not use DAC registers)
SeeAlso: AX=001Bh,AX=001Dh,AX=00A4h

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of WORD buffer for red component of DAC register
 02h	WORD	offset of WORD buffer for red component
 04h	WORD	segment of WORD buffer for green component of DAC register
 06h	WORD	offset of WORD buffer for green component
 08h	WORD	segment of WORD buffer for blue component of DAC register
 0Ah	WORD	offset of WORD buffer for blue component
--------V-62001D-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MAPRGB" - MAP COLOR COMPONENTS INTO PALETTE VAL
	AX = 001Dh
	BX = red component
	CX = green component
	DX = blue component
Return: AX = mode-specific palette value corresponding to specified components
Note:	only meaningful in 16-color graphics modes
SeeAlso: AX=0015h,AX=0017h
--------V-62001E-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_ERASE" - CLEAR THE ACTIVE VIDEO PAGE
	AX = 001Eh
Note:	sets each pixel to 0 in graphics modes, each character cell to a blank
	  with a gray foreground attribute in text modes
--------V-62001F-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_POINT" - DISPLAY A PIXEL
	AX = 001Fh
	BX = column
	CX = row
Note:	this call is ignored in text modes
SeeAlso: AX=0020h
--------V-620020-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETPIXEL" - GET COLOR OF SPECIFIED PIXEL
	AX = 0020h
	BX = column in screen space
	CX = row in screen space
Return: AX = color value of pixel (0 to num_colors-1)
	    0000h in text modes
SeeAlso: AX=001Fh
--------V-620021-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETXPOS" - GET GRAPHICS CURSOR COLUMN
	AX = 0021h
Return: AX = screen space X coordinate of graphics cursor position
SeeAlso: AX=0022h,AX=0023h,AX=0024h
--------V-620022-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETXPOS" - GET GRAPHICS CURSOR ROW
	AX = 0022h
Return: AX = screen space Y coordinate of graphics cursor position
SeeAlso: AX=0021h,AX=0023h,AX=0024h
--------V-620023-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MOVE" - SET GRAPHICS CURSOR POSITION
	AX = 0023h
	BX = new column
	CX = new row
Note:	this call is ignored in text modes
SeeAlso: AX=0021h,AX=0022h,AX=0024h
--------V-620024-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MOVEREL" - ADJUST GRAPHICS CURSOR POSITION
	AX = 0024h
	BX = column offset
	CX = row offset
Note:	this call is ignored in text modes
SeeAlso: AX=0021h,AX=0022h,AX=0023h
--------V-620025-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_DRAW" - DRAW SOLID LINE TO ABSOLUTE POSITION
	AX = 0025h
	BX = endpoint column
	CX = endpoint row
Notes:	this call is ignored in text modes
	the starting point is the current graphics cursor position; the cursor
	  position is updated
SeeAlso: AX=0026h,AX=0027h
--------V-620026-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_DRAWREL" - DRAW SOLID LINE TO RELATIVE POSITION
	AX = 0026h
	BX = endpoint column offset
	CX = endpoint row offset
Notes:	this call is ignored in text modes
	the starting point is the current graphics cursor position; the cursor
	  position is updated
SeeAlso: AX=0025h,AX=0028h
--------V-620027-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_DASH" - DRAW DASHED LINE TO ABSOLUTE POSITION
	AX = 0027h
	BX = endpoint column
	CX = endpoint row
	DX = dash pattern (set bits cause drawn pixels)
Notes:	this call is ignored in text modes
	the starting point is the current graphics cursor position; the cursor
	  position is updated
SeeAlso: AX=0025h,AX=0028h
--------V-620028-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_DASHREL" - DRAW DASHED LINE TO RELATVE POSITION
	AX = 0028h
	BX = endpoint column offset
	CX = endpoint row offset
	DX = dash pattern (set bits cause drawn pixels)
Notes:	this call is ignored in text modes
	the starting point is the current graphics cursor position; the cursor
	  position is updated
SeeAlso: AX=0026h,AX=0027h
--------V-620029-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SETCLIP" - SET CLIPPING REGION
	AX = 0029h
	BX = left edge of clipping region
	CX = right edge of clipping region
	DX = top edge of clipping region
	SI = bottom edge of clipping region
SeeAlso: AX=004Ah,AX=004Ch,AX=0052h,AX=0054h
--------V-62002A-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_RECT" - DRAW UNFILLED RECTANGLE IN SCREEN SPACE
	AX = 002Ah
	BX = left edge column
	CX = right edge column
	DX = top edge row
	SI = bottom edge row
SeeAlso: AX=002Bh,AX=002Ch,AX=002Eh,AX=00A2h
--------V-62002B-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_CLPRECT" - DRAW FILLED RECTANGLE IN SCREEN SPCE
	AX = 002Bh
	BX = screen space column of left edge
	CX = screen space column of right edge
	DX = screen space row of top edge
	SI = screen space row of bottom edge
Note:	this call is ignored in text modes
SeeAlso: AX=002Ah,AX=002Ch,AX=00A2h
--------V-62002C-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_DRECT" - DRAW DITHERED RECTANGLE IN SCRN SPACE
	AX = 002Ch
	BX = screen space column of left edge
	CX = screen space column of right edge
	DX = screen space row of top edge
	SI = screen space row of bottom edge
	ES:DI -> dithering matrix (video-mode dependent)
Note:	this call is ignored in text modes
SeeAlso: AX=002Bh,AX=00A2h
--------V-62002D-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_ELLIPSE" - DRAW UNFILLED ELLIPSE IN SCRN SPACE
	AX = 002Dh
	BX = horizontal semi-axis length in screen space units
	CX = vertical semi-axis length in screen space units
Notes:	this call is ignored in text modes
	the ellipse is centered at the current graphics cursor position
SeeAlso: AX=002Ah,AX=002Eh,AX=00A2h
--------V-62002E-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_POLYGON" - DRAW AN UNFILLED POLYGON
	AX = 002Eh
	CX = number of vertices in polygon
	ES:BX -> variable pointer record (see below)
SeeAlso: AX=002Dh,AX=0030h,AX=00A2h

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of WORD array containing vertex columns
 02h	WORD	offset of WORD array containing vertex columns
 04h	WORD	segment of WORD array containing vertex rows
 06h	WORD	offset of WORD array containing vertex rows
--------V-62002F-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_PAINT" - FLOOD CLOSED REGION WITH COLOR
	AX = 002Fh
	BX = column
	CX = row
Notes:	fills an arbitrary closed region around the specified point with the
	  current color; the screen edges are not considered region boundaries
	ignored in text modes
--------V-620030-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_CIRCLE" - DRAW UNFILLED CIRCLE
	AX = 0030h
	BX = radius in horizontal screen space units (> 0)
Notes:	the circle is drawn in screen space, centered at the current graphics
	  cursor position
	this call is ignored in text modes
SeeAlso: AX=00A2h
--------V-620031-----------------------------
INT 62 - FGDRIVER v1.10 - UNUSED
	AX = 0031h
Return: AX = 0000h
--------V-620032-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_TEXT" - DISPLAY STRING OF CHARACTERS
	AX = 0032h
	CX = length of string
	ES:BX -> string
Notes:	the string is displayed staring at the text cursor position using the
	  current text attribute (text modes) or color index (graphics modes)
	the text cursor position is updated after this call
SeeAlso: AX=001Ah,AX=0033h,AX=0035h,AX=0036h
--------V-620033-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_LOCATE" - SET TEXT-MODE CURSOR POSITION
	AX = 0033h
	BX = row
	CX = column
Note:	there are only eight text cursors shared by successive groups of
	  eight video pages (pages 0, 8, 16, ... share one cursor, 1, 9, ...
	  share the second, etc)
SeeAlso: AX=0034h
--------V-620034-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_WHERE" - GET CURRENT CURSOR POSITION
	AX = 0034h
	ES:BX -> variable pointers (see below)
Return: indicated variables filled with cursor row and column for active
	  display
Note:	FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
SeeAlso: AX=0033h

Format of variable pointers:
Offset	Size	Description
 00h	WORD	segment of WORD buffer for cursor row
 02h	WORD	offset of WORD buffer for cursor row
 04h	WORD	segment WORD buffer for cursor column
 06h	WORD	offset WORD buffer for cursor column
--------V-620035-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_CHGATTR" - APPLY CURRENT TEXT ATTRIB TO CHARS
	AX = 0035h
	BX = number of characters to recolor
Notes:	this call is ignored in graphics modes
	starting at the current text cursor position, the specified number of
	  characters have their attributes to the current text attribute
SeeAlso: AX=0036h
--------V-620036-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_CHGTEXT" - DISPLAY STRING AT CURSOR POSITION
	AX = 0036h
	CX = length of string
	ES:BX -> string to be displayed
Return: text cursor updated
Note:	this call is ignored in graphics modes
SeeAlso: AX=0032h,AX=0035h
--------V-620037-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETATTR" - GET CHARACTER ATTRIB FOR POSITION
	AX = 0037h
	BX = row
	CX = column
Return: AX = character attribute at specified location on active video page
Note:	this call is ignored in graphics modes
SeeAlso: AX=0019h,AX=0038h
--------V-620038-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETCHAR" - GET CHARACTER FOR SCREEN POSITION
	AX = 0038h
	BX = row
	CX = column
Return: AX = character at specified location on active video page
Note:	this call is ignored in graphics modes
SeeAlso: AX=0037h
--------V-620039-----------------------------
INT 62 - FGDRIVER v1.10 - UNUSED
	AX = 0039h to 003Bh
Return: AX = 0000h
--------V-62003C-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETPAGE" - GET ACTIVE VIDEO PAGE NUMBER
	AX = 003Ch
Return: AX = active video page (0000h-003Fh)
SeeAlso: AX=003Dh,AX=003Eh,AX=0040h
--------V-62003D-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SETPAGE" - SET ACTIVE VIDEO PAGE
	AX = 003Dh
	BX = new video page (0000h to 003Fh)
Note:	the specified page must be a physical or virtual page
SeeAlso: AX=0001h,AX=003Ch,AX=003Fh,AX=0041h
--------V-62003E-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETVPAGE" - GET VISIBLE VIDEO PAGE NUMBER
	AX = 003Eh
Return: AX = visible video page (0000h-003Fh)
SeeAlso: AX=003Ch,AX=003Fh,AX=0040h
--------V-62003F-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SETVPAGE" - SET VISIBLE VIDEO PAGE
	AX = 003Fh
	BX = new video page (0000h to 003Fh)
Note:	the specified page must be a physical or virtual page
SeeAlso: AX=0001h,AX=003Dh,AX=003Eh,AX=0041h
--------V-620040-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETHPAGE" - GET CURRENT HIDDEN VIDEO PAGE NUM
	AX = 0040h
Return: AX = current hidden video page number (0000h-003Fh)
SeeAlso: AX=003Ch,AX=003Eh,AX=0041h
--------V-620041-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SETHPAGE" - SET HIDDEN VIDEO PAGE
	AX = 0041h
	BX = new hidden page (0000h to 003Fh)
Note:	specified page must be a physical page or a virtual page
SeeAlso: AX=003Dh,AX=003Fh,AX=0040h
--------V-620042-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_ALLOCATE" - CREATE VIRTUAL VIDEO PAGE
	AX = 0042h
	BX = page number (0000h-003Fh)
Return: AX = status (0000h,0001h,0007h,0008h) (see below)
Notes:	FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
	the amount of memory required by the virtual video page depends on the
	  current video mode
SeeAlso: AX=0043h,AX=009Dh,AX=009Fh

Values for status:
 0000h	successful
 0001h	specified page is a physical or logical page
 0007h	virtual page created/released, but memory control blocks corrupted
 0008h	not enough memory
 0009h	attempt to free a page which was never created
--------V-620043-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_FREEPAGE" - FREE VIRTUAL OR LOGICAL VIDEO PAGE
	AX = 0043h
	BX = page number (0000h-003Fh)
Return: AX = status (0000h,0001h,0007h,0009h) (see AX=0042h)
SeeAlso: AX=0042h,AX=009Dh,AX=009Eh,AX=009Fh
--------V-620044-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETADDR" - GET SEGMENT OF ACTIVE VIDEO PAGE
	AX = 0044h
Return: AX = segment of active video page
--------V-620045-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_RESIZE" - SET GRAPHICS MODE VIDEO PAGE SIZE
	AX = 0045h
	BX = new page width in pixels
	CX = new page height in pixels
Notes:	the visible page must be set to 0000h before making this call
	mouse, joysticks, expanded memory, and extended memory must be
	  reinitialized after this call
SeeAlso: AX=000Ah,AX=000Bh,AX=0075h,AX=007Ah,AX=00A0h,AX=00A1h
--------V-620046-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETMAP" - STORE IMAGE AS MODE-INDEPENDNT BITMAP
	AX = 0046h
	ES:BX -> buffer for video mode-independent bitmap
	CX = width of bitmap in bytes
	DX = height of bitmap in pixel rows
Return: each bit in bitmap is set if corresponding pixel is of the current
	  color, cleared otherwise
Note:	this call is ignored in text modes
SeeAlso: AX=0047h,AX=0048h
--------V-620047-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_DRAWMAP" - DISPLAY MODE-INDEPENDENT BIT MAP
	AX = 0047h
	ES:BX -> bitmap (each set bit is pixel drawn in current color)
	CX = width of bitmap in bytes
	DX = height of bitmap in pixel rows
SeeAlso: AX=0046h,AX=004Ah,AX=004Dh,AX=0052h
--------V-620048-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETIMAGE" - STORE IMAGE AS BITMAP
	AX = 0048h
	ES:BX -> buffer for video mode-specific bitmap
	CX = width of bitmap in bytes
	DX = height of bitmap in pixel rows
SeeAlso: AX=0046h,AX=0049h,AX=0062h
--------V-620049-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_DRWIMAGE" - DISPLAY BITMAPPED IMAGE
	AX = 0049h
	ES:BX -> video mode-specific bitmap
	CX = width of bitmap in bytes
	DX = height of bitmap in pixel rows
Note:	the image will be drawn with its lower left corner at the current
	  cursor position (either text or graphics)
SeeAlso: AX=0048h,AX=004Ah,AX=0062h
--------V-62004A-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_CLPIMAGE" - DISPLAY CLIPPED IMAGE (BITMAP)
	AX = 004Ah
	ES:BX -> mode-specific bitmap
	CX = width of bit map in bytes
	DX = height of bit map in pixel rows
Notes:	this call is ignored in text modes
	the image is drawn with its lower left corner at the current graphics
	  cursor position
	the current clipping region is used, extended to a byte boundary
SeeAlso: AX=0029h,AX=0047h,AX=0049h,AX=004Ch,AX=0052h
--------V-62004B-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_REVIMAGE" - DISPLAY REVERSED IMAGE (BITMAP)
	AX = 004Bh
	ES:BX -> mode-specific bitmap
	CX = width of bitmap in bytes
	DX = height of bitmap in pixel rows
Notes:	this call is ignored in text modes
	the image is drawn with its lower left corner at the current graphics
	  cursor position
SeeAlso: AX=004Ah,AX=004Ch
--------V-62004C-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_FLPIMAGE" - DISPLAY INV CLIPPED IMAGE (BITMAP)
	AX = 004Ch
	ES:BX -> mode-specific bitmap
	CX = width of bit map in bytes
	DX = height of bit map in pixel rows
Notes:	this call is ignored in text modes
	the image is drawn with its lower left corner at the current graphics
	  cursor position
	the current clipping region is used, extended to a byte boundary
SeeAlso: AX=0029h,AX=004Ah
--------V-62004D-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_DISPLAY" - DISPLAY IMAGE (STD PIXEL RUN FORMAT)
	AX = 004Dh
	ES:BX -> pixel run map (pairs of bytes: color index, count)
	CX = number of pixel runs to display
	DX = width of image in pixels (> 0)
Notes:	this call is ignored in text modes
	the image is displayed with its lower left corner at the current
	  graphics cursor position
SeeAlso: AX=0047h,AX=004Eh,AX=004Fh,AX=0050h,AX=0060h
--------V-62004E-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_DISPLAY" - DISPLAY IMAGE (PACKED PIXEL RUN FMT)
	AX = 004Eh
	ES:BX -> pixel run map (trios of bytes: colors, count1, count2; colors
		contains the color for the first run in its high nybble and the
		color for the second run in its low nybble)
	CX = number of pixel runs to display
	DX = width of image in pixels (> 0)
Notes:	this call is ignored in text modes
	the image is displayed with its lower left corner at the current
	  graphics cursor position
SeeAlso: AX=004Dh,AX=004Fh,AX=0050h,AX=0060h
--------V-62004F-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_DISPFILE" - DISPLAY STORED IMAGE
	AX = 004Fh
	ES:BX -> ASCIZ filename
	CX = image width in pixels (> 0)
	DX = image format
	    0000h Fastgraph standard pixel run format
	    0001h packed pixel run format
Notes:	this call is ignored in text modes
	the image is displayed with its lower left corner at the current
	  graphics cursor position
SeeAlso: AX=004Dh,AX=004Eh,AX=0050h,AX=0060h
--------V-620050-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_PATTERN" - SPECIFY DISPLAY PATTERN FOR COLOR
	AX = 0050h
	BX = index of pattern to define
	CX = number of predefined display pattern
Notes:	when displaying a pixel run map, Fastgraph uses the pattern associated
	  with each color index rather than displaying the actual color
	this call has no effect in text and 256-color graphics modes
SeeAlso: AX=004Dh,AX=004Eh,AX=004Fh
--------V-620051-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_DRAWMASK" - DISPLAY IMAGE (MASKING MAP)
	AX = 0051h
	ES:BX -> array containing image stored as a masking map (see below)
	CX = number of pixel runs in masking map
	DX = width of masking map in pixels
Notes:	this call is ignored in text modes and in native EGA and VGA graphics
	  modes
	the image is drawn with its lower left corner at the current graphics
	  cursor position
SeeAlso: AX=0052h

Format of masking map:
Offset	Size	Description
 00h	BYTE	length of first "protect" run (pixels remain unchanged)
 01h	BYTE	length of first "zero" run (pixels set to background color)
 02h	BYTE	length of second "protect" run
 03h	BYTE	length of second "zero" run
	...
--------V-620052-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_CLIPMASK" - DISPLAY CLIPPED IMAGE (MASKING MAP)
	AX = 0052h
	ES:BX -> array containing image stored as a masking map (see AX=0051h)
	CX = number of pixel runs in masking map
	DX = width of masking map in pixels
Notes:	this call is ignored in text modes and in native EGA and VGA graphics
	  modes
	the image is drawn with its lower left corner at the current graphics
	  cursor position
SeeAlso: AX=0029h,AX=004Ah,AX=0051h,AX=0053h,AX=0054h
--------V-620053-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_REVMASK" - DISPLAY REVERSED IMAGE (MASKING MAP)
	AX = 0053h
	ES:BX -> array containing image stored as a masking map (see AX=0051h)
	CX = number of pixel runs in masking map
	DX = width of masking map in pixels
Notes:	this call is ignored in text modes and in native EGA and VGA graphics
	  modes
	the image is drawn with its lower left corner at the current graphics
	  cursor position
SeeAlso: AX=0052h,AX=0054h
--------V-620054-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_FLIPMASK" - DISPLAY INV CLIPPED IMAGE (MASKMAP)
	AX = 0054h
	ES:BX -> array containing image stored as a masking map (see AX=0051h)
	CX = number of pixel runs in masking map
	DX = width of masking map in pixels
Notes:	this call is ignored in text modes and in native EGA and VGA graphics
	  modes
	the image is drawn with its lower left corner at the current graphics
	  cursor position
SeeAlso: AX=0029h,AX=0052h,AX=0053h
--------V-620055-----------------------------
INT 62 - FGDRIVER v1.10 - UNUSED
	AX = 0055h to 0059h
Return: AX = 0000h
--------V-62005A-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SAVE" - COPY REGION FROM VISIBLE TO HIDDEN PAGE
	AX = 005Ah
	BX = left edge column
	CX = right edge column
	DX = top edge row
	SI = bottom edge row
Note:	left and right edges are adjusted to byte boundaries if necessary
SeeAlso: AX=005Bh
--------V-62005B-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_RESTORE" - COPY REGION FROM HIDDEN TO VIS PAGE
	AX = 005Bh
	BX = left edge column
	CX = right edge column
	DX = top edge row
	SI = bottom edge row
Note:	left and right edges are adjusted to byte boundaries if necessary
SeeAlso: AX=005Ah,AX=0064h
--------V-62005C-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_TRANSFER" - COPY REGION
	AX = 005Ch
	CX = source video page
	DX = destination video page
	ES:BX -> copy record (see below)
Note:	source and destination regions must not overlap if on the same page
SeeAlso: AX=005Dh,AX=005Fh

Format of copy record:
Offset	Size	Description
 00h	WORD	left edge column of source region
 02h	WORD	right edge column of source region
 04h	WORD	top edge row of source region
 06h	WORD	bottom edge row of source region
 08h	WORD	left edge of destination
 0Ah	WORD	bottom edge of destination
--------V-62005D-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_TCXFER" - COPY REGION EXCLUDING TRANSPARENT
	AX = 005Dh
	CX = source video page
	DX = destination video page
	ES:BX -> copy record (see AX=005Ch)
Notes:	pixels which are in any of the colors defined as transparent with
	  AX=005Eh are left unchanged in the destination region
	source and destination regions must not overlap if on the same page
	this call is ignored in text modes
SeeAlso: AX=005Ch,AX=005Eh
--------V-62005E-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_TCMASK" - SET TRANSPARENT COLORS
	AX = 005Eh
	BX = colors to consider transparent (bit 0 = color 0, etc)
Notes:	this call is ignored in text modes
	the specified colors are considered transparent by AX=005Dh
SeeAlso: AX=005Dh
--------V-62005F-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_COPYPAGE" - TRANSFER VIDEO PAGE CONTENTS
	AX = 005Fh
	BX = source page number (0000h-003Fh)
	CX = destination page number (0000h-003Fh)
Note:	if both source and destination pages are logical pages, they must both
	  be located in the same type (conventional, EMS, XMS) of memory
SeeAlso: AX=005Ch,AX=009Dh,AX=009Eh,AX=009Fh
--------V-620060-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_DISPPCX" - DISPLAY PCX FILE
	AX = 0060h
	ES:BX -> ASCIZ filename
	CX = flags
	    bit 0: use current palette rather than PCX file's palette
	    bits 1-15 reserved (0)
Return: AX = status
	    0000h success
	    0001h file not found
	    0002h file is not a valid PCX file
Notes:	this call is ignored in text modes and Hercules low-resolution graphics
	the image is displayed with its upper left corner at the current
	  graphics cursor position
SeeAlso: AX=004Dh,AX=004Eh,AX=004Fh,AX=0061h
--------V-620061-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MAKEPCX" - CREATE PCX FILE FROM SCREEN WINDOW
	AX = 0061h
	BX = left edge in screen space units
	CX = right edge in screen space units
	DX = top edge in screen space units
	SI = bottom edge in screen space units
	ES:DI -> ASCIZ filename of PCX file to create
Return: AX = status
	    0000h successful
	    0001h file not created
Notes:	the PCX file is created from the specified region of the active video
	  page; the left and right edges are adjusted to a byte boundary if
	  necessary
	if the specified file already exists, it is overwritten
	this call is ignored in text and Hercules low-resolution graphics modes
SeeAlso: AX=0060h
--------V-620062-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_IMAGESIZ" - DETERMINE IMAGE STORAGE REQUIREMENT
	AX = 0062h
	BX = image width in pixels
	CX = image height in pixels
Return: DX:AX = size in bytes of mode-specific bitmap for current video mode
SeeAlso: AX=0048h
--------V-620063-----------------------------
INT 62 - FGDRIVER v1.10 - UNUSED
	AX = 0063h
Return: AX = 0000h
--------V-620064-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_FADEIN" - FADE IN HIDDEN PAGE
	AX = 0064h
	BX = delay (0000h = fastest possible fade-in)
Notes:	the current hidden page is copied to the current visible page in small
	  random sections to produce a fade-in effect
	this call is ignored in text modes
SeeAlso: AX=005Bh,AX=0065h
--------V-620065-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_FADEOUT" - FADE OUT TO CURRENT COLOR
	AX = 0065h
	BX = delay (0000h = fastest possible fade-out)
Notes:	this call is ignored in text modes
	the current visible page is filled with pixels of the current color in
	  small random sections to give a fade-out effect
SeeAlso: AX=0064h
--------V-620066-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_PAN" - SET SCREEN ORIGIN
	AX = 0066h
	BX = new column for screen origin
	CX = new row for screen origin
SeeAlso: AX=0067h
--------V-620067-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SCROLL" - VERTICALLY SCROLL SCREEN REGION
	AX = 0067h
	BX = left edge column
	CX = right edge column
	DX = top edge row
	SI = bottom edge row
	DI = number of pixels by which to scroll (positive scrolls up,
		negative scrolls down)
	ES = type of scroll
	    0000h circular (rows scrolled off are copied to vacated rows)
	    else vacated rows are filled with the current color
Notes:	in graphics modes, the left and right edges are adjusted to byte
	  boundaries if necessary
	circular scrolling uses part of the hidden page as a workspace
SeeAlso: AX=0066h
--------V-620068-----------------------------
INT 62 - FGDRIVER v1.10 - UNUSED
	AX = 0068h to 006Ch
Return: AX = 0000h
--------V-62006D-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_WAITKEY" - FLUSH KEYBOARD BUFFER AND AWAIT KEY
	AX = 006Dh
Return: after next key pressed
SeeAlso: AX=006Eh,AX=006Fh,AX=0096h
--------V-62006E-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETKEY" - GET NEXT KEYSTROKE
	AX = 006Eh
	ES:BX -> variable pointer record (see below)
Return: (after next keystroke if no typeahead) variables updated
SeeAlso: AX=006Dh,AX=006Fh,AX=0070h

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of BYTE buffer for ASCII keycode
 02h	WORD	offset of BYTE buffer for ASCII keycode
 04h	WORD	segment of BYTE buffer for extended keycode
 06h	WORD	offset of BYTE buffer for extended keycode
--------V-62006F-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_INTKEY" - GET KEYSTROKE, NO WAIT
	AX = 006Fh
	ES:BX -> variable pointer record (see below)
Return: variables updated
Note:	if the keyboard buffer is empty, both the ASCII and extended keycodes
	  are set to 00h
SeeAlso: AX=006Dh,AX=006Eh,AX=0070h,AX=0079h

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of BYTE buffer for ASCII keycode
 02h	WORD	offset of BYTE buffer for ASCII keycode
 04h	WORD	segment of BYTE buffer for extended keycode
 06h	WORD	offset of BYTE buffer for extended keycode
--------V-620070-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_CAPSLOCK" - GET STATE OF CAPSLOCK KEY
	AX = 0070h
Return: AX = CapsLock state (0000h off, 0001h on)
SeeAlso: AX=006Eh,AX=006Fh,AX=0071h,AX=0072h,AX=0074h
--------V-620071-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SETCAPS" - SET STATE OF CAPSLOCK KEY
	AX = 0071h
	BX = new state (0000h off, 0001h on)
SeeAlso: AX=0070h,AX=0073h
--------V-620072-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_NUMLOCK" - GET STATE OF NUMLOCK KEY
	AX = 0072h
Return: AX = NumLock state (0000h off, 0001h on)
SeeAlso: AX=0070h,AX=0074h
--------V-620073-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SETNUM" - SET STATE OF NUMLOCK KEY
	AX = 0073h
	BX = new state (0000h off, 0001h on)
SeeAlso: AX=0071h,AX=0072h
--------V-620074-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SCRLOCK" - GET STATE OF SCROLL LOCK KEY
	AX = 0074h
Return: AX = ScrollLock state (0000h off, 0001h on)
SeeAlso: AX=0070h,AX=0072h
--------V-620075-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_INITJOY" - INITIALIZE JOYSTICK USE
	AX = 0075h
	BX = joystick number (0001h or 0002h)
Return: AX = status
	    0000h successful
	    FFFFh joystick not connected or no game port
Note:	Fastgraph assumes that the requested joystick is centered at the time
	  this function is called
SeeAlso: AX=0076h,AX=0077h,AX=0078h,AX=0079h
--------V-620076-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETXJOY" - GET HORIZONTAL POSITION OF JOYSTICK
	AX = 0076h
	BX = joystick number (0001h or 0002h)
Return: AX = horizontal position of joystick
	    FFFFh if joystick uninitialized or not present
Notes:	the actual coordinates are processor- and joystick-dependent
	you must call AX=0075h before this function
SeeAlso: AX=0075h,AX=0077h,AX=0078h
--------V-620077-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETYJOY" - GET VERTICAL POSITION OF JOYSTICK
	AX = 0077h
	BX = joystick number (0001h or 0002h)
Return: AX = vertical position of joystick
	    FFFFh if joystick uninitialized or not present
Notes:	the actual coordinates are processor- and joystick-dependent
	you must call AX=0075h before this function
SeeAlso: AX=0075h,AX=0076h,AX=0078h
--------V-620078-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_BUTTON" - GET JOYSTICK BUTTON STATE
	AX = 0078h
	BX = joystick number (0001h or 0002h)
Return: AX = button states
	    bit 0: top button pressed
	    bit 1: bottom button pressed
SeeAlso: AX=0075h,AX=0076h,AX=0077h,AX=0079h
--------V-620079-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_INTJOY" - GET KEYCODES CORRESP TO JOYSTICK POS
	AX = 0079h
	CX = joystick number (0001h or 0002h)
	ES:BX -> variable pointer record (see below)
Notes:	if the indicated joystick has not been initialized with AX=0075h, both
	  the button code and joystick position will be set to 00h
	if either button is pressed, a button code of 0Dh is returned;
	  otherwise, a button code of 00h is returned
SeeAlso: AX=006Fh,AX=0075h,AX=0078h

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of BYTE buffer for button code
 02h	WORD	offset of BYTE buffer for button code
 04h	WORD	segment of BYTE buffer for joystick position
 06h	WORD	offset of BYTE buffer for joystick position
--------V-62007A-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MOUSEINI" - INITIALIZE MOUSE SUPPORT
	AX = 007Ah
Return: AX = status
	    0002h two-button mouse
	    0003h three-button mouse
	    FFFFh initialization failed
Note:	after this call, the mouse cursor is invisible
SeeAlso: AX=007Bh,AX=007Ch,AX=007Eh,AX=0080h,INT 33/AX=0000h
--------V-62007B-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MOUSEVIS" - SET MOUSE CURSOR VISIBILITY
	AX = 007Bh
	BX = new state (0000h invisible, 0001h visible)
SeeAlso: AX=007Ah,AX=007Eh,INT 33/AX=0001h,INT 33/AX=0002h
--------V-62007C-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MOUSEBUT" - GET MOUSE BUTTON PRESS/RELEASE CNTS
	AX = 007Ch
	CX = mouse button (1 = left press, 2 = right press, 3 = middle press,
			  -1=left release, -2=right release, -3=middle release)
	ES:BX -> variable pointer record (see below)
Return: variables updated
Note:	returns the count of presses or releases since the last call to this
	  function; if the count is zero, row and col will also be zero
SeeAlso: AX=007Ah,INT 33/AX=0005h,INT 33/AX=0006h

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of WORD buffer for press/release count
 02h	WORD	offset of WORD buffer for press/release count
 04h	WORD	segment of WORD buffer for screen space col of last press/rls
 06h	WORD	offset of WORD buffer for screen space col of last press/rels
 08h	WORD	segment of WORD buffer for screen space row of last press/rls
 0Ah	WORD	offset of WORD buffer for screen space row of last press/rls
--------V-62007D-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MOUSEPOS" - GET CURRENT MOUSE POSITION
	AX = 007Dh
	ES:BX -> variable pointer record (see below)
SeeAlso: AX=007Ah,AX=0081h

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of WORD buffer for mouse column
 02h	WORD	offset of WORD buffer for mouse column
 04h	WORD	segment of WORD buffer for mouse row
 06h	WORD	offset of WORD buffer for mouse row
 08h	WORD	segment of WORD buffer for button status
 0Ah	WORD	offset of WORD buffer for button status
Note:	button status: bit 0 = left button, bit 1 = right, bit 2 = middle
--------V-62007E-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MOUSECUR" - SPECIFY TEXT-MODE MOUSE CURSOR
	AX = 007Eh
	BX = screen mask
	CX = cursor mask
Note:	this call is ignored in graphics modes
SeeAlso: AX=007Ah,AX=007Fh,INT 33/AX=000Ah
--------V-62007F-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MOUSEPTR" - SPECIFY GRAPH-MODE MOUSE CURSOR
	AX = 007Fh
	ES:BX -> masks (16-byte screen mask followed by 16-byte cursor mask)
	CX = X offset of hot spot from upper left corner
	DX = Y offset of hot spot from upper left corner
Note:	this call is ignored in text modes
SeeAlso: AX=007Ah,AX=007Eh,INT 33/AX=0009h
--------V-620080-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MOUSELIM" - SPECIFY MOUSE CURSOR LIMITS
	AX = 0080h
	BX = left-most position allowed for mouse cursor
	CX = right-most position allowed
	DX = top-most position allowed
	SI = bottom-most position allowed
SeeAlso: AX=007Ah,AX=0081h,INT 33/AX=0007h,INT 33/AX=0008h
--------V-620081-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MOUSEMOV" - SET MOUSE CURSOR POSITION
	AX = 0081h
	BX = new column
	CX = new row
Note:	will not move the mouse cursor outside the bounding box specified with
	  AX=0080h
SeeAlso: AX=007Ah,AX=007Dh,AX=0080h,INT 33/AX=0004h
--------V-620082-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MOUSESPD" - SET MOUSE CURSOR SPEED
	AX = 0082h
	BX = horizontal mickeys per eight pixels of movement (default 16)
	CX = vertical mickeys per eight pixels of movement (default 16)
SeeAlso: INT 33/AX=000Fh,INT 33/AX=001Ah
--------V-620083-----------------------------
INT 62 - FGDRIVER v1.10 - UNUSED
	AX = 0083h to 0087h
Return: AX = 0000h
--------V-620088-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SOUND" - MAKE SOUND FOR SPECIFIED DURATION
	AX = 0088h
	BX = frequency in Hertz (18-32767)
	CX = duration in clock ticks (0000h or negative for continuous sound)
Note:	ignored if asynchronous sound (AX=0089h,AX=008Bh,AX=008Dh) is in
	  progress
SeeAlso: AX=0089h,AX=008Ah,AX=008Eh,AX=0090h
--------V-620089-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SOUNDS" - PLAY SOUNDS IN BACKGROUND
	AX = 0089h
	CX = number of times to cycle through sound list
	ES:BX -> sounds array (see below)
Note:	ignored if asynchronous sound (AX=0089h,AX=008Bh,AX=008Dh) is in
	  progress
SeeAlso: AX=0088h,AX=008Eh,AX=008Fh

Format of sounds array element:
Offset	Size	Description
 00h	WORD	frequency of sound in Hertz (0000h ends array)
 02h	WORD	duration of sound in clock ticks
--------V-62008A-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_VOICE" - START SOUND
	AX = 008Ah
	BX = channel on TI sound chip
		1-3 = channels 1-3, 4 = channel 4 with periodic noise,
		5 = channel 4 with white noise
	CX = frequency in Hz (18-32767 for channels 1-3; 0=512 Hz, 1=1024 Hz,
		2=2048 Hz for channels 4 and 5)
	DX = volume
	SI = duration in clock ticks (continuous if <= 0)
Notes:	FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
	only available on PCjr and Tandy 1000
SeeAlso: AX=0088h,AX=008Bh,AX=008Ch
--------V-62008B-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_VOICES" - PLAY SOUNDS IN BACKGROUND
	AX = 008Bh
	ES:BX -> tone array (see below)
	CX = number of times to repeat tone array
Notes:	FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
	only available on PCjr and Tandy 1000
SeeAlso: AX=008Ah,AX=008Dh,AX=008Eh,AX=008Fh,AX=0091h

Format of tone array element:
Offset	Size	Description
 00h	WORD	channel number (0000h terminates array)
 02h	WORD	frequency
 04h	WORD	volume
 06h	WORD	duration in 1/72.8 seconds
--------V-62008C-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MUSIC" - PLAY SERIES OF NOTES
	AX = 008Ch
	ES:BX -> '$'-terminated music string in BASIC PLAY format
Return: after music completed
Note:	ignored if asynchronous sound (AX=0089h,AX=008Bh,AX=008Dh) is in
	  progress
SeeAlso: AX=008Ah,AX=008Dh
--------V-62008D-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MUSICB" - PLAY SERIES OF NOTES IN BACKGROUND
	AX = 008Dh
	CX = number of repetitions (negative = continuous play)
	ES:BX -> '$'-terminated music string in BASIC PLAY format
Note:	ignored if asynchronous sound (AX=0089h,AX=008Bh,AX=008Dh) is in
	  progress
SeeAlso: AX=008Bh,AX=008Ch,AX=008Eh,AX=008Fh,AX=0091h
--------V-62008E-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_HUSH" - STOP ASYNCHRONOUS SOUND IMMEDIATELY
	AX = 008Eh
Note:	immediately stops any sounds started with "FG_MUSICB", "FG_SOUNDS",
	  or AX=008Bh; ignored if no asynchronous sound is playing
SeeAlso: AX=0088h,AX=008Bh,AX=008Fh,AX=0090h,AX=0091h
--------V-62008F-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_HUSHNEXT" - STOP ASYNCHRONOUS SOUND
	AX = 008Fh
Note:	stops any sounds started with "FG_MUSICB", "FG_SOUNDS", or AX=008Bh
	  after the current repetition completes; ignored unless asynchronous
	  sound is continuous
SeeAlso: AX=008Bh,AX=008Eh,AX=0090h
--------V-620090-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_QUIET" - STOP CONTINUOUS SYNCHRONOUS SOUND
	AX = 0090h
Note:	this call has no effect if there is no continuous sound playing
SeeAlso: AX=008Eh,AX=008Fh,AX=0091h
--------V-620091-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_PLAYING" - DETERMINE WHETHER ASYNC SOUND ACTIVE
	AX = 0091h
Return: AX = sound state (0 = no asynchronous sound, 1 = async sound playing)
SeeAlso: AX=008Bh,AX=008Dh,AX=0090h
--------V-620092-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_RESUME" - RESTART ASYNCHRONOUS SOUND
	AX = 0092h
SeeAlso: AX=008Eh,AX=008Fh,AX=0090h
--------V-620093-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SUSPEND" - TEMPORARILY STOP ASYNCHRONOUS SOUND
	AX = 0093h
Notes:	this call has no effect if there is no asynchronous sound in progress
	the program must not exit while sound is suspended
SeeAlso: AX=0092h
--------V-620094-----------------------------
INT 62 - FGDRIVER v1.10 - UNUSED
	AX = 0094h to 0095h
Return: AX = 0000h
--------V-620096-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_WAITFOR" - DELAY FOR SPECIFIED DURATION
	AX = 0096h
	BX = duration in clock ticks
Return: after delay elapses
SeeAlso: AX=006Dh,AX=0097h,INT 1A/AX=FF01h
--------V-620097-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_STALL" - PAUSE FOR SPECIFIED DURATION
	AX = 0097h
	BX = duration in processor-dependent delay units (see AX=0098h)
Return: after delay elapses
SeeAlso: AX=0096h,AX=0098h,INT 2F/AX=1224h
--------V-620098-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MEASURE" - GET DELAY UNITS PER CLOCK TICK
	AX = 0098h
Return: AX = delay units per clock tick (processor-dependent)
Note:	delay units are used by "FG_STALL" (AX=0097h)
SeeAlso: AX=0097h
--------V-620099-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETCLOCK" - GET CLOCK TICKS SINCE MIDNIGHT
	AX = 0099h
Return: DX:AX = number of clock ticks since midnight
Note:	FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
SeeAlso: INT 1A/AH=00h
--------V-62009A-----------------------------
INT 62 - FGDRIVER v1.10 - UNUSED
	AX = 009Ah
Return: AX = 0000h
--------V-62009B-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_MEMAVAIL" - QUERY AMOUNT OF FREE MEMORY
	AX = 009Bh
Return: DX:AX = number of bytes of conventional memory available
SeeAlso: AX=009Dh
--------V-62009C-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SETFUNC" - SET LOGICAL OPERATION FOR VIDEO OPS
	AX = 009Ch
	BX = operation
	    0000h replacement
	    0001h AND
	    0002h OR
	    0003h XOR
Note:	only available in native EGA/VGA graphics mode (0Dh to 12h)
--------V-62009D-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_ALLOCCMS" - CREATE LOGICAL VIDEO PAGE (CONVMEM)
	AX = 009Dh
	BX = page number (0001h-003Fh)
Return: AX = status (0000h,FFFCh,FFFDh,FFFEh) (see below)
Note:	the only operation which is allowed on logical pages is AX=005Fh
SeeAlso: AX=0043h,AX=005Fh,AX=009Bh,AX=009Eh,AX=009Fh

Values for status:
 0000h	successful
 FFFCh	insufficient memory
 FFFDh	page already created, or exists as physical or virtual page
 FFFEh	invalid page number
 FFFFh	memory manager not initialized
--------V-62009E-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_ALLOCEMS" - CREATE LOGICAL VIDEO PAGE (EMS)
	AX = 009Eh
	BX = page number (0001h-003Fh)
Return: AX = status (see AX=009Dh)
Notes:	must first call AX=00A0h
	the only operation which is allowed on logical pages is AX=005Fh
SeeAlso: AX=0043h,AX=005Fh,AX=009Dh,AX=009Fh,AX=00A0h
--------V-62009F-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_ALLOCXMS" - CREATE LOGICAL VIDEO PAGE (XMS)
	AX = 009Fh
	BX = page number (0001h-003Fh)
Return: AX = status (see AX=009Dh)
Notes:	must first call AX=00A1h
	the only operation which is allowed on logical pages is AX=005Fh
SeeAlso: AX=0043h,AX=005Fh,AX=009Dh,AX=009Eh,AX=00A1h
--------V-6200A0-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_INITEMS" - INITIALIZE EXPANDED MEMORY USE
	AX = 00A0h
Return: AX = status
	    0000h successful
	    FFFFh expanded memory manager inaccessible or not installed
SeeAlso: AX=009Eh,AX=00A1h
--------V-6200A1-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_INITXMS" - INITIALIZE EXTENDED MEMORY USE
	AX = 00A1h
Return: AX = status
	    0000h successful
	    FFFFh extended memory manager inaccessible or not installed
SeeAlso: AX=009Fh,AX=00A0h
--------V-6200A2-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_BOX" - DRAW UNFILLED RECTANGLE
	AX = 00A2h
	BX = left column
	CX = right column
	DX = top row
	SI = bottom row
Notes:	FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
	the rectangle is drawn in screen space, respecting the clipping region,
	  with edges of the width specified with AX=00A3h (default = 1 is set
	  by "FG_SETMODE")
	this function has no effect in text modes
SeeAlso: AX=002Bh,AX=002Ch,AX=002Eh,AX=0030h,AX=00A3h
--------V-6200A3-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_BOXDEPTH" - SET RECTANGLE BORDER WIDTH
	AX = 00A3h
	BX = width of left and right edges in pixels (> 0)
	CX = width of top and bottom edges in pixels (> 0)
SeeAlso: AX=00A2h
--------V-6200A4-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_GETDACS" - GET VIDEO DAC CONTENTS
	AX = 00A4h
	CX = number of DAC registers to return (0001h to 0100h)
	DX = starting DAC register number (0000h to 00FFh)
	ES:BX -> buffer for DAC red/green/blue triples
Note:	the register number wraps back to zero after FFh
SeeAlso: AX=001Ch,AX=00A5h,INT 10/AX=1017h
--------V-6200A5-----------------------------
INT 62 u - FGDRIVER v1.10 - "FG_SETDACS" - SET VIDEO DAC CONTENTS
	AX = 00A5h
	CX = number of DAC registers to set (0001h to 0100h)
	DX = starting DAC register number (0000h to 00FFh)
	ES:BX -> buffer containing DAC red/green/blue triples
Notes:	the register number wraps back to zero after FFh
	this call has no effect in text modes or graphics modes below 11h
SeeAlso: AX=001Bh,AX=00A4h,INT 10/AX=1012h
--------T-6201-------------------------------
INT 62 - Cswitch - GIVE UP REST OF TIME-SLICE
	AH = 01h
Program: Cswitch is a set of multitasking functions by Herb Rose
SeeAlso: AH=05h,AH=06h,INT 15/AX=1000h,INT 2F/AX=1680h
--------T-6202-------------------------------
INT 62 - Cswitch - WAIT FOR SEMAPHORE
	AH = 02h
	DX = semaphore number (0-63)
Return: AX = FFFFh bad semaphore number
	     else  success
SeeAlso: AH=03h,AH=04h
--------T-6203-------------------------------
INT 62 - Cswitch - CHECK SEMAPHORE
	AH = 03h
	DX = semaphore number (0-63)
Return: AX = FFFFh not owned
	     else  owned
SeeAlso: AH=02h,AH=04h
--------T-6204-------------------------------
INT 62 - Cswitch - TRIGGER SEMAPHORE
	AH = 04h
	DX = semaphore number (0-63)
Return: AX = FFFFh bad semaphore number
	     else  success
SeeAlso: AH=02h,AH=03h
--------T-6205-------------------------------
INT 62 - Cswitch - SLEEP
	AH = 05h
	BX = seconds to sleep
SeeAlso: AH=01h,AH=06h,AH=08h"Cswitch"
--------T-6206-------------------------------
INT 62 - Cswitch - SUSPEND
	AH = 06h
SeeAlso: AH=05h,AH=08h"Cswitch"
--------T-6207-------------------------------
INT 62 - Cswitch - SPAWN
	AH = 07h
	ES:BX -> function address to start executing at
	CX = priority (1-10)
Return: AX = FFFDh  no free memory control blocks
	   = FFFEh  no free task control blocks
	   = FFFFh  not enough memory to create new task stack
	   = >0	    the tcb number of the new task, indicating no error
SeeAlso: AH=0Fh,AH=10h
--------T-6208-------------------------------
INT 62 - Cswitch - WAKE UP TASK
	AH = 08h
	BX = tcb identifier
SeeAlso: AH=05h,AH=06h
----------6208--CXFFFE-----------------------
INT 62 - MS SQL Server/Sybase DBLIBRARY interface - UNINSTALL/GET PSP ADDR
	AH = 08h
	CX = FFFEh
	DX = FFFFh
Return: AX = PSP address of resident DBLIBRARY
Note:	this call does not free the memory allocated to the TSR; the calling
	  code must do the deallocation.
SeeAlso: INT 62"DBLIBRARY"
--------T-6209-------------------------------
INT 62 - Cswitch - SET PRIORITY
	AH = 09h
	BX = new base priority (1-10)
Note:	the lower the priority is numerically, the more often the task will run
--------T-620A-------------------------------
INT 62 - Cswitch - TEST MESSAGE QUEUE
	AH = 0Ah
	DX = queue number (0-63)
Return: AX = FFFFh bad queue number
	   = 0000h nothing on queue
	     else  number of bytes in first message in queue
SeeAlso: AH=0Bh,AH=0Ch
--------T-620B-------------------------------
INT 62 - Cswitch - SEND MESSAGE
	AH = 0Bh
	CX = number of bytes to write
	DS:SI -> buffer
	DX = queue number (0-63)
Return: AX = FFFEh triggered by something arriving, redo the call
	   = FFFFh bad queue number
	   = 0000h no message was on queue
	     else  number of bytes in message
SeeAlso: AH=0Ah,AH=0Ch
--------T-620C-------------------------------
INT 62 - Cswitch - READ MESSAGE
	AH = 0Ch
	CX = number of bytes to read
	DS:SI -> buffer
	DX = queue number (0-63)
Return: AX = FFFFh bad queue number
	     else  number of bytes transferred
SeeAlso: AH=0Ah,AH=0Bh
--------T-620D-------------------------------
INT 62 - Cswitch - DON'T ALLOW TASK TO BE SWAPPED OUT
	AH = 0Dh
SeeAlso: AH=0Eh
--------T-620E-------------------------------
INT 62 - Cswitch - ALLOW TASK TO BE SWAPPED OUT
	AH = 0Eh
SeeAlso: AH=0Dh
--------T-620F-------------------------------
INT 62 - Cswitch - LOAD AND RUN PROGRAM FROM DISK
	AH = 0Fh
	ES:BX -> command line
	CX = priority (1-10)
	DX = background flag (nonzero allows loading to EMS)
Return: AX = 0000h task loader queue is full
	   = 0001h  no error
SeeAlso: AH=07h,AH=10h,AH=13h
--------T-6210-------------------------------
INT 62 - Cswitch - TERMINATE SPAWNED PROGRAM
	AH = 10h
SeeAlso: AH=07h,AH=0Fh
--------T-6211-------------------------------
INT 62 - Cswitch - GET TCB INFORMATION
	AH = 11h
	ES:BX -> a pointer which will be set to the tcb address
Return: AX = tcb indentifier
SeeAlso: AH=12h
--------T-6212-------------------------------
INT 62 - Cswitch - GET TCB ADDRESS
	AH = 12h
	ES:BX -> a pointer which will be set to the tcb table address
Return: AX = tcb indentifier
SeeAlso: AH=11h
--------T-6213-------------------------------
INT 62 - Cswitch - CHECK STATUS OF PREVIOUS LOAD_TASK
	AH = 13h
Return: AX = FFFCh no Memory Control Blocks available
	   = FFFDh no TCBs available
	   = FFFEh insufficient memory
	   = FFFFh cannot open file
	   = 0000h load in progress (not done yet)
	     else  tcb indentifier
SeeAlso: AH=0Fh
--------R-6247-------------------------------
INT 62 - PC Tools v7 COMMUTE - ???
	AH = 47h
	AL = subfunction (00h-31h)
	???
	CF set
Return: ???
--------R-6248-------------------------------
INT 62 - PC Tools v7 COMMUTE - ???
	AH = 48h
	AL = ???
	???
	CF set
Return: ???
--------R-6249-------------------------------
INT 62 - PC Tools v7 COMMUTE - ???
	AH = 49h
	???
	CF set
Return: ???
Note:	may be the same as AH=4Ch
--------R-624A-------------------------------
INT 62 - PC Tools v7 COMMUTE - ???
	AH = 4Ah
	AL = subfunction (00h-46h)
	???
	CF set
Return: ???
--------R-624B--BX1234-----------------------
INT 62 - PC Tools v7 COMMUTE - ???
	AH = 4Bh
	BX = 1234h
	CX = 1234h
	ES = ???
	CF set
Return: ???
--------R-624C-------------------------------
INT 62 - PC Tools v7 COMMUTE - ???
	AH = 4Ch
	BL = subfunction
	    00h ???
	    02h ???
Return: CF clear if successful
	CF set on error
--------R-626262-----------------------------
INT 62 - PC Tools v7 COMMUTE - INSTALLATION CHECK
	AX = 6262h
	CF set
Return: AX = 0000h
	BX = segment of resident code's PSP
--------N-62FE-------------------------------
INT 62 - BW-TCP - ETHDRV.SYS - MAP EMS PAGE FRAME
	AH = FEh
	AL = direction
	    00h map in driver's memory block
	    01h map out driver's memory block
Return: CF clear if successful
	CF set on error
	    AL = error code
Note:	this function is supported by at least the SLIP and ODI versions of
	  ETHDEV.SYS
SeeAlso: INT 21/AH=3Fh"BW-TCP",INT 62"BW-TCP",INT 63"BW-TCP",INT 64/AH=FEh
--------*-63---------------------------------
INT 63 - reserved for user interrupt
--------d-63---------------------------------
INT 63 - Adaptec and OMTI controllers - DRIVE 0 DATA
Notes:	this vector stores the last four bytes of the parameter table for
	  hard disk 0
SeeAlso: INT 60"Adaptec",INT 61"Adaptec",INT 62"Adaptec",INT 64"Adaptec"
----------63---------------------------------
INT 63 - Oracle SQL Protected Mode Executive - ???
--------d-63---------------------------------
INT 63 - 4+Power FLOPPY CONTROLLER - ORIGINAL INT 13/40
   the "4+Power" quad floppy controller BIOS hooks INT 13 (or INT 40 if INT 13
   has been moved there) and places the old value here
----------63---------------------------------
INT 63 - Kofax KF9X00 image manipulation card interface
--------Q-63---------------------------------
INT 63 - DESQview/X - SOCKET API
Notes:	parameters are passed by patching!! data field immediately following
	  the entry point, as detailed below; the preferred method for calling
	  the socket API is via INT 15/AX=DE2Eh
	the installation check consists of testing for the string "dvxunix"
	  (yes, lowercase) at offset 9 from the interrupt handler start
SeeAlso: INT 15/AX=DE2Eh,INT BE"DESQview"
Index:	installation check;DESQview/X socket interface

Format of interrupt handler entry:
Offset	Size	Description
 00h  3 BYTEs	near jump or short jump + NOP to actual interrupt handler
 03h	WORD	offset from following pointer for initial top of local stack
 05h	DWORD	pointer to argument/stack block (see INT 15/AX=DE2Eh)
 09h  7 BYTEs	signature "dvxunix"
--------b-6300-------------------------------
INT 63 - HP 100LX - MAP HIGH MEMORY
	AH = 00h
	AL = physical page (00h seg C000, 01h seg C400h, ...)
	BX = zero-based logical page
	CX = page number
	DX = device ID (00h system ROM, 05h plugin, etc.)
Return: ???
SeeAlso: AH=01h
--------N-6300-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - SET IP ADDRESS???
	AH = 00h
	DS:BX -> DWORD containing IP address (big-endian)
Return: CF clear if successful
	CF set on error
	AX destroyed
Note:	the Beame&Whiteside TCP/IP protocol stack uses two consecutive
	  interrupts (62h and 63h by default); the BW-NFS client uses a third
	  consecutive interrupt (64h by default) if it is loaded
SeeAlso: AH=01h"BW-TCP",AH=02h"BW-TCP"
--------b-6301-------------------------------
INT 63 - HP 100LX - SAVE/RESTORE MEMORY MAP
	AH = 01h
	AL = function (00h save, 01h restore)
	???
Return: ???
--------N-6301-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 01h
	ES:BX -> ???
	???
Return: ???
Note:	the Beame&Whiteside TCP/IP protocol stack uses two consecutive
	  interrupts (62h and 63h by default); the BW-NFS client uses a third
	  consecutive interrupt (64h by default) if it is loaded
SeeAlso: AH=00h"BW-TCP",AH=02h"BW-TCP"
--------N-6302-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 02h
	???
Return: ???
SeeAlso: AH=00h"BW-TCP",AH=01h"BW-TCP"
--------N-6303-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - GET IP ADDRESS
	AH = 03h
	DS:SI -> buffer for DWORD IP address (big-endian)
Return: AX destroyed
	CF clear if successful
	CF set on error
Note:	this call may use ARP or RARP to determine the address
--------N-6304-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 04h
	???
Return: ???
--------N-6305-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 05h
	DS:BX -> ???
	ES:SI -> ???
Return: ???
--------N-6306-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 06h
	???
Return: ???
--------N-6307-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 07h
	???
Return: ???
--------N-6308-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - SET DEFAULT ??? HANDLER
	AH = 08h
	DS:BX -> DWORD containing IP address
Return: CF clear if successful
	CF set on error
	???
--------N-6309-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - INSTALL ??? HANDLERS
	AH = 09h
	BL = handler type
	ES:SI -> FAR handler of specified type
Return: ???
SeeAlso: AH=0Ah,AH=0Dh
--------N-630A-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - DELETE ??? HANDLERS
	AH = 0Ah
	BL = handler type
Return: CF clear if successful
	CF set on error (no handler of specified type installed)
SeeAlso: AH=09h
--------N-630B-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 0Bh
	AL = ???
	DL = ???
	DS:BX -> ???
	ES:SI -> ???
Return: ???
--------N-630C-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 0Ch
	???
Return: ???
--------N-630D-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - INSTALL DEFAULT ??? HANDLER
	AH = 0Dh
	???
Return: ???
Note:	if not already installed, installs a type 06h handler with AH=09h
SeeAlso: AH=09h
--------N-630E-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - CLOSE NETWORK DESCRIPTOR
	AH = 0Eh
	???
Return: ???
SeeAlso: INT 61/AH=08h"PC/TCP",INT 61/AH=09h"PC/TCP",INT 61/AH=18h
--------N-630F-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 0Fh
	AL = ???
	SI = ???
	DS:DI -> ???
	???
Return: ???
--------N-6310-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 10h
	DS:DI -> ???
	???
Return: ???
--------N-6311-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 11h
	???
Return: ???
--------N-6312-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - LISTEN FOR INCOMING CONNECTIONS
	AH = 12h
	DS:SI -> ???
	ES:BP -> ???
Return: ???
SeeAlso: INT 61/AH=23h
--------N-6313-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - NOP
	AH = 13h
Return: nothing
--------N-6314-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - OPEN NETWORK CONNECTION
	AH = 14h
	BX = network descriptor???
	DS:SI -> ???
	ES:BP -> ???
Return: ???
SeeAlso: INT 61/AH=13h"PC/TCP",INT 62/AH=13h"ETHDEV"
--------N-6315-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 15h
	DS:DI -> ???
	???
Return: ???
--------N-6316-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - RESET NETWORK CONNECTION
	AH = 16h
	DS:DI -> ???
Return: ???
Note:	calls AH=17h after preprocessing
SeeAlso: AH=17h,INT 61/AH=19h"PC/TCP"
--------N-6317-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 17h
	DS:DI -> ???
	???
Return: ???
SeeAlso: AH=18h
--------N-6318-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 18h
	DS:DI -> ???
	???
Return: ???
Note:	same as AH=17h, except performed with interrupts disabled
SeeAlso: AH=17h
--------N-6319-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - WRITE TO THE NETWORK
	AH = 19h
	DS:DI -> ???
	???
Return: BX = number of bytes NOT written
	???
Note:	calls AH=17h with interrupts disabled and ??? set to 01h
SeeAlso: AH=1Ah,AH=1Bh,INT 61/AH=1Ah"PC/TCP"
--------N-631A-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - READ FROM THE NETWORK
	AH = 1Ah
	CX = maximum number of bytes to read
	ES:BP -> ???
	???
Return: CX = number of bytes actually read
	???
SeeAlso: AH=19h,INT 61/AH=1Bh"PC/TCP"
--------N-631B-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 1Bh
	CX = ???
	ES:BP -> ???
Return: DX = ???
	???
--------N-631C-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 1Ch
	DS:DI -> ???
	???
Return: ???
Note:	calls AH=17h with ???
SeeAlso: AH=17h
--------N-631D-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 1Dh
	???
Return: ???
--------N-631E-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 1Eh
	DS:BX -> DWORD containing IP address (big-endian)
	???
Return: CF clear if successful
	CF set on error
	???
--------N-631F-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - SET SOCKET ??? HANDLER
	AH = 1Fh
	BX = socket number
	ES:SI -> FAR function for ???
Return: CF clear if successful
	CF set on error (out of slots)
SeeAlso: AH=20h
--------N-6320-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - REMOVE SOCKET ??? HANDLER
	AH = 20h
	BX = socket number
Return: CF clear if successful
	CF set on error (not set)
SeeAlso: AH=1Fh
--------N-6321-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 21h
	ES:SI -> ???
Return: ???
SeeAlso: INT 61/AH=1Ch"PC/TCP"
--------N-6322-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - REMOVE ??? HANDLER
	AH = 22h
Return: CF clear
Note:	decrements a counter if not already zero, and calls AH=0Ah with BL=11h
	  if the counter reaches zero
--------N-6323-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 23h
	DS:BX -> ???
	ES:SI -> 6-byte buffer for ???
Return: CF clear if successful
	CF set on error
--------N-6324-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - GET SOCKET
	AH = 24h
Return: AX = socket number (0400h-FFFFh)
Note:	the Beame&Whiteside TCP/IP protocol stack uses two consecutive
	  interrupts (62h and 63h by default); the BW-NFS client uses a third
	  consecutive interrupt (64h by default) if it is loaded
SeeAlso: INT 62"BW-TCP",INT 64"BW-NFS"
--------N-6325-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - GET INTERNET ADDRESS
	AH = 25h
Return: CL:CH:DL:DH = caller's Internet address
SeeAlso: AH=26h,INT 61/AH=05h"PC/TCP"
--------N-6326-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - SET INTERNET ADDRESS???
	AH = 26h
	CL:CH:DL:DH = Internet address
Return: nothing
Note:	this function sets a different variable than AH=25h returns
SeeAlso: AH=25h
--------N-6327-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - SET ???
	AH = 27h
	BX = ???
	ES:SI -> ???
Return: ???
--------N-6328-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 28h
	???
Return: ???
--------N-6329-------------------------------
INT 63 - BW-TCP - TCPIP.SYS - ???
	AH = 29h
	???
Return: ???
Note:	the Beame&Whiteside TCP/IP protocol stack uses two consecutive
	  interrupts (62h and 63h by default); the BW-NFS client uses a third
	  consecutive interrupt (64h by default) if it is loaded
--------*-64---------------------------------
INT 64 - reserved for user interrupt
--------d-64---------------------------------
INT 64 - Adaptec controllers - DRIVE 1 DATA
Notes:	this vector stores the first four bytes of the parameter table for
	  hard disk 1
	these vectors are used by the following Adaptec controllers:
	    ACB 2370 A/B/C, ACB 2372 A/B/C, ACB 2333 A/B, 2322B-8, 2322B-16
	these vectors are NOT used by the following Adaptec controllers:
	    ACB 2310, ACB 2312, ACB 2320D, ACB 2322D
SeeAlso: INT 60"Adaptec",INT 65"Adaptec",INT 66"Adaptec",INT 67"Adaptec"
----------64---------------------------------
INT 64 - Oracle SQL Protected Mode Executive - ???
--------N-64---------------------------------
INT 64 - Novell NetWare to v2.0a - LOW-LEVEL API
Note:	equivalent to INT 7A for NetWare versions through 2.0a only; later
	  versions do not use this interrupt for IPX/SPX access, instead
	  getting an entry point from INT 2F/AX=7A00h
SeeAlso: INT 2F/AX=7A00h,INT 7A"Novell"
--------h-64---------------------------------
INT 64 - Data General DG10 - MicroECLIPSE COPROCESSOR INTERFACE
SeeAlso: INT 65"DG10",INT 66"DG10"
--------r-64---------------------------------
INT 64 - Extended Batch Language v3.14+
	AH = function
	    00h to 5Fh chained to previous handler
	    60h to 6Ch reserved, return immediately
	    80h to FFh chained to previous handler
	    6Dh (v4.01+) insert tone in queue
		AL = ???
		CX = frequency in Hertz
		DL = duration in clock ticks
		Return: AL = 00h if note stored
			   = 01h if no room to store
	    6Eh clear ??? counter/flag
	    6Fh return counter/flag that AH=6Eh clears
	    70h ???
		AL = ???
	    71h ???
		AL = ???
	    72h ???
	    73h insert byte at end of keyboard buffer
		AL = byte to insert
		Return: AL = 00h if byte inserted
			   = 01h if no room to store
	    74h insert byte at front of keyboard buffer
		AL = byte to insert
		Return: AL = 00h if byte inserted
			   = 01h if no room to store
	    75h ???
	    76h get keyboard "stack" status
		AL = 'K' if kbd read will read physical keyboard
		     'S' if it will read EBL internal keyboard buffer
		AH = ???
	    77h clear internal keyboard buffer
	    78h ???
		AL = ???
	    79h ???
	    7Ah ???
		AL = ???
	    7Bh ???
		AL = ???
	    7Ch ???
		AL = ???
	    7Dh ???
		AL = ???
	    7Eh clear buffer for ???
	    7Fh installation check
		Return: CX = version in BCD
			DI = segment of ???
			BX = segment of next program's PSP???
Program: Extended Batch Language is a batch-file enhancer by Seaware
Notes:	the chaining does not check whether the interrupt had been hooked
	  before, so if you try to chain when the previous vector was
	  0000h:0000h, you'll be in trouble
	functions 72h and 7Ah-7Dh appear to be interfaces to the optional
	  floating-point and extended function packages
Index:	installation check;EBL|installation check;Extended Batch Language
--------d-64---------------------------------
INT 64 - Pdisk by Scott Garfinkle - Overwritten for Hard Drive information
Note:	This vector is overwritten by Pdisk to install custom harddrive types.
	  It can either destroy 4 vectors and take no memory or TSR and take
	  up some memory.
SeeAlso: INT 65"Pdisk"
--------N-6401-------------------------------
INT 64 U - BW-NFS - BWRPC - ???
	AH = 01h
	ES:BX -> ??? (at least 8 bytes)
	ES:BP -> DWORD ???
	???
Return: CF clear if successful
	    ???
	CF set on error
	    CX = 0000h
Notes:	the Beame&Whiteside TCP/IP protocol stack uses two consecutive
	  interrupts (62h and 63h by default); the BW-NFS client uses a third
	  consecutive interrupt (64h by default) if it is loaded
	the BWRPC installation check consists of determining the interrupt
	  vector assigned to it (two more than the value returned by reading
	  the ETHDEV27 device), and testing whether the word immediately
	  preceding the interrupt handler is 4257h ('BW')
SeeAlso: INT 62"BW-TCP",INT 63"BW-TCP"
Index:	installation checks;BWRPC
--------N-6402-------------------------------
INT 64 U - BW-NFS - BWRPC - ???
	AH = 02h
	DS:DI -> ???
Return: ???
Note:	this call is passed directly through to INT 62/AH=07h
SeeAlso: INT 62"BW-TCP"
--------N-6403-------------------------------
INT 64 U - BW-NFS - BWRPC - ADD ???
	AH = 03h
	AL = ???
	BP = ???
	ES:SI -> ???
Return: ???
Note:	this call is passed directly through to INT 62/AH=0Bh
SeeAlso: AH=04h,INT 62"BW-TCP"
--------N-6404-------------------------------
INT 64 U - BW-NFS - BWRPC - REMOVE ???
	AH = 04h
	BP = ???
Return: ???
Note:	this call is passed directly through to INT 62/AH=0Ch
SeeAlso: AH=03h,INT 62"BW-TCP"
--------N-6405-------------------------------
INT 64 U - BW-NFS - BWRPC - ???
	AH = 05h
	CX = ???
Return: ???
Note:	this call is passed directly through to INT 62/AH=13h
SeeAlso: INT 62"BW-TCP"
--------N-6406-------------------------------
INT 64 U - BW-NFS - BWRPC - ???
	AH = 06h
	ES:SI -> ???
Return: AL = 00h if CF clear
Note:	this call is passed directly through to INT 62/AH=14h
SeeAlso: INT 62"BW-TCP"
--------N-6407-------------------------------
INT 64 U - BW-NFS - BWRPC - GET IP ADDRESS
	AH = 07h
Return: CX:DX = IP address
--------N-6410-------------------------------
INT 64 U - BW-NFS - BWRPC - CALL ETHDEV.SYS
	AH = 10h
	AL = ETHDEV function number
	other registers as appropriate for ETHDEV call
Return: as returned by ETHDEV
Note:	this call is passed directly through to INT 62
SeeAlso: INT 62"BW-TCP"
--------N-6411-------------------------------
INT 64 U - BW-NFS - BWRPC - NOP???
	AH = 11h
Return: CF clear
--------N-64FE-------------------------------
INT 64 - BW-NFS - BWRPC - MAP EMS PAGE FRAME
	AH = FEh
	AL = direction
	    00h map in driver's memory block
	    01h map out driver's memory block
Return: CF clear if successful
	CF set on error
	    AL = error code
Note:	this call is passed through directly to ETHDEV.SYS (see INT 62/AH=FEh)
SeeAlso: INT 21/AH=3Fh"BW-TCP",INT 62/AH=FEh,INT 63"BW-TCP"
--------*-65---------------------------------
INT 65 - reserved for user interrupt
--------d-65---------------------------------
INT 65 - Adaptec controllers - DRIVE 1 DATA
Note:	this vector stores the second four bytes of the parameter table for
	  hard disk 1
SeeAlso: INT 64"Adaptec",INT 66"Adaptec",INT 67"Adaptec"
--------h-65---------------------------------
INT 65 - Data General DG10 - MicroECLIPSE COPROCESSOR INTERFACE
SeeAlso: INT 64"DG10",INT 66"DG10"
--------N-65---------------------------------
INT 65 - FTP Software NDIS-Packet Driver adapter - POST PROCESSING INTERRUPT
--------U-65---------------------------------
INT 65 - SD.COM v6.2
   The unregistered version of SD62.COM uses the low byte of this vector to
   count the number of invocations, displaying a registration reminder each
   time after the 20th use.
--------d-65---------------------------------
INT 65 - Pdisk by Scott Garfinkle - Overwritten for Hard Drive information
SeeAlso: INT 64"Pdisk",INT 66"Pdisk"
--------s-65---------------------------------
INT 65 - Ad Lib SOUND.COM - INTERFACE
	SI = function number (see also entries below)
	    0000h Init
	    0002h RelTimeStart
	    0003h SetState
	    0004h GetState
	    0005h Flush
	    0006h SetMode
	    0007h GetMode
	    0008h SetRelVolume
	    0009h SetTempo
	    000Ah SetTranspose
	    000Bh GetTranspose
	    000Ch SetActVoice
	    000Dh GetActVoice
	    000Eh PlayNoteDel
	    000Fh PlayNote
	    0010h SetTimbre
	    0011h SetPitch
	    0012h SetTickBeat
	    0013h NoteOn
	    0014h NoteOff
	    0015h Timbre
	    0016h SetPitchBend
	    0017h WaveForm
	ES:BX -> arguments
Note:	the installation check consists of checking for the signature block
	  immediately preceding the interrupt handler (see below)
SeeAlso: SI=8000h
Index:	installation check;Ad Lib SOUND.COM

Format of signature block:
Offset	Size	Description
 00h	WORD	version number
 02h 19 BYTEs	"SOUND-DRIVER-AD-LIB"
 15h	BYTE	01h
 16h	BYTE	01h
 17h	BYTE	00h
--------s-65----SI0000-----------------------
INT 65 - Ad Lib SOUND.COM - INITIALIZE (RESET)
	SI = 0000h
--------s-65----SI0003-----------------------
INT 65 - Ad Lib SOUND.COM - SET STATE
	SI = 0003h
	ES:BX -> WORD state = 0000h disabled
			    = 0001h enabled
SeeAlso: SI=0004h
--------s-65----SI0004-----------------------
INT 65 - Ad Lib SOUND.COM - GET STATE
	SI = 0004h
Return: AX = 0000h all done playing sounds
	   = else  still playing sounds
SeeAlso: SI=0003h
--------s-65----SI0006-----------------------
INT 65 - Ad Lib SOUND.COM - SET MODE
	SI = 0006h
	ES:BX -> WORD mode = 0000h melodic
			   = 0001h percussive
SeeAlso: SI=0007h
--------s-65----SI0007-----------------------
INT 65 - Ad Lib SOUND.COM - GET MODE
	SI = 0007h
Return: AX = 0000h melodic
	   = 0001h percussive
SeeAlso: SI=0006h
--------s-65----SI000C-----------------------
INT 65 - Ad Lib SOUND.COM - SET ACTIVE VOICE
	SI = 000Ch
	ES:BX -> WORD voice = 0000h to 0008h
SeeAlso: SI=000Dh
--------s-65----SI000D-----------------------
INT 65 - Ad Lib SOUND.COM - GET ACTIVE VOICE
	SI = 000Dh
Return: AX = voice (0000h to 0008h)
SeeAlso: SI=000Ch
--------s-65----SI8000-----------------------
INT 65 u - Media Vision FM.COM v4.1a+ - GET INTERNAL DATA STRUCTURES
	SI = 8000h
Return: DX:AX -> internal data structures
Program: FM.COM is an Ad Lib SOUND.COM-compatible driver for Media Vision's
	  Pro Audio Spectrum sound boards
SeeAlso: SI=8001h
--------s-65----SI8001-----------------------
INT 65 u - Media Vision FM.COM v4.1a+ - GET VOICE COUNT
	SI = 8001h
Return: AX = ???
	DX = number of voices??? (09h or 0Bh)
SeeAlso: SI=8000h
--------s-65----SI8002-----------------------
INT 65 - Media Vision FM.COM v4.1a+ - START BACKGROUND FM SOUNDS
	SI = 8002h
SeeAlso: SI=8003h
--------s-65----SI8003-----------------------
INT 65 - Media Vision FM.COM v4.1a+ - STOP BACKGROUND FM SOUNDS
	SI = 8003h
SeeAlso: SI=8002h
--------s-65----SI8004-----------------------
INT 65 U - Media Vision FM.COM v4.1a+ - GET ???
	SI = 8004h
Return: AX = ??? (0280h)
	DX = ??? (01A0h)
--------s-65----SI8005-----------------------
INT 65 U - Media Vision FM.COM v4.1a+ - ???
	SI = 8005h
	???
Return: ???
SeeAlso: SI=8000h
--------S-65---------------------------------
INT 65 U - EZRECV v1.0 - API
	AX = function
	    0000h ???
		Return: AX = ??? or FFFFh
	    0001h ???
		Return: AX = status (0000h or 0001h)
	    0002h ???
		Return: AX = status (0000h or 0001h)
	    0003h set ??? to 0001h
		Return: AX = 0000h
	    0004h ???
		Return: AX = ???
Return: BH = COM port being used
	BL = speed???
	CH = ???
	CL = ???
	DX = ???
	DS = ???
	ES = EZRECV data segment
Program: EZRECV is a background Zmodem file receiver by Express Consulting
--------*-66---------------------------------
INT 66 - reserved for user interrupt
--------d-66---------------------------------
INT 66 - Adaptec controllers - DRIVE 1 DATA
Note:	this vector stores the third four bytes of the parameter table for
	  hard disk 1
SeeAlso: INT 64"Adaptec",INT 65"Adaptec",INT 67"Adaptec"
--------h-66---------------------------------
INT 66 - Data General DG10 - MicroECLIPSE COPROCESSOR INTERFACE
SeeAlso: INT 64"DG10"
--------N-66---------------------------------
INT 66 C - Nanosoft, Inc. TurboNET - NETWORK PROCESSING ???
Program: TurboNET is a NetBIOS-based file redirector and server
Note:	hooked but not used (IRET) by both redirector and server; called from
	  server's INT 28 handler
SeeAlso: INT 2F/AX=8100h
--------d-66---------------------------------
INT 66 - Pdisk by Scott Garfinkle - Overwritten for Hard Drive information
SeeAlso: INT 64"Pdisk",INT 67"Pdisk"
--------W-66---------------------------------
INT 66 - Microsoft Windows VITD.386 Virtual Interval Timer
Note:	This Windows 3.x Virtual Device Driver implements a virtual timer
	  which will expire and call INT 66.  This timer can be used to
	  calculate elapsed execution time etc.
--------K-66---------------------------------
INT 66 - Newkey v5.4 - INSTALLATION VECTOR
Return: immediately (IRET)
Program: Newkey is a shareware keyboard macro program by Frank A. Bell
Note:	the installation check consists of testing for the signature bytes
	  FDh FCh FFh FEh at offset 03h in the interrupt handlers segment;
	  Newkey may use any interrupt from 60h through 67h and will install
	  on the highest vector in this range which is unused (normally 66h)
BUG:	the code obviously intends to use INT F0-FE, INT 70-77, and INT 68-6F
	  before falling back to INT 60-67, but only uses the last of these
	  ranges in v5.4
SeeAlso: INT 2F/AX=E300h
Index: installation checks;Newkey|Newkey;installation check
--------F-6601-------------------------------
INT 66 - BitFax Scheduler - SET MODE???
	AH = 01h
SeeAlso: AH=02h
--------F-6602-------------------------------
INT 66 - BitFax Scheduler - SET MODE???
	AH = 02h
SeeAlso: AH=01h
--------F-6603-------------------------------
INT 66 - BitFax Scheduler - SCHEDULE FAX TRANSMISSIONS
	AH = 03h
	???
Return: ???
SeeAlso: AH=05h
--------F-6604-------------------------------
INT 66 - BitFax Scheduler - GET STATUS???
	AH = 04h
Return: AX = ??? (0000h or 0001h)
	DX = BitSched version???  (for versions >= 3.00)
	    9796h (ver. 3.00)
	    97E6h (ver. 3.02)
	    92D0h (ver. 3.04.06)
	    9510h (ver. 3.06.02)
SeeAlso: AH=06h,AX=3345h,INT 2F/AX=8000h"FaxBIOS"
--------F-6605-------------------------------
INT 66 - BitFax Scheduler - CONVERT FILE AND SEND FAX
	AH = 05h
	BX:CX -> command block (see below)
	???
Return: ???
SeeAlso: AH=03h

Format of command block:
Offset	Size	Description
 00h 18 BYTEs	configuration bytes???
 12h	BYTEs	ASCIZ temporary file name to place converted fax
 52h	BYTEs	ASCIZ directory containing BitFax executables
 92h	BYTEs	ASCIZ telephone number
 C2h	BYTE	00h don't send cover page
		01h send cover page
 C3h 15 BYTEs	configuration bytes???
 E2h	BYTEs	ASCIZ path of BITFAX.TRA file (containing additional
		configuration information???)
122h	BYTEs	configuration bytes???
12Ch	BYTE	00h don't send cover page
		01h send cover page
12Dh  7 BYTEs	configuration bytes???
134h	BYTEs	ASCIZ path of file to send
174h	BYTEs	more configuration bytes???
	???
--------F-6606-------------------------------
INT 66 - BitFax Scheduler - SET MODE???
	AH = 06h
Return: DX = BitSched version??? (same as AH=04h)
SeeAlso: AH=04h
--------s-660688-----------------------------
INT 66 - IBMSND driver - PLAY 8-BIT DIGITIZED SOUND
	AX = 0688h
	DS:SI -> SNDSTRUC (see below)
Return: ???
Program: The IBMSND driver is part of John W. Ratcliff's
	   The IBM Digitized Sound Package
Note:	the installation check consists of looking for a valid signature
	  string six bytes prior to the interrupt handler; this string may
	  be either "KERN" or "MIDI" (in the latter case, call AX=0701h to
	  determine whether IBMSND is installed)
SeeAlso: AX=068Bh,AX=068Fh,AX=0701h

Format of SNDSTRUC:
Offset	Size	Description
 00h	DWORD	-> audio data
 04h	WORD	length of audio data in bytes
 06h	DWORD	-> playback status flag
 0Ah	WORD	playback frequency
--------s-660689-----------------------------
INT 66 - IBMSND driver - REPORT SOUND DRIVER STATUS
	AX = 0689h
Return: AX = status
	    0000h no sound playing
	    0001h sound effect is currently playing
SeeAlso: AX=0688h,AX=068Bh,AX=068Ch
--------s-66068A-----------------------------
INT 66 - IBMSND driver - PREFORMAT SOUND
	AX = 068Ah
	DS:SI -> SNDSTRUC (see AX=0688h)
Desc:	convert audio data into output hardware format
SeeAlso: AX=068Bh
--------s-66068B-----------------------------
INT 66 - IBMSND driver - PLAY PREFORMATTED SOUND
	AX = 068Bh
	DS:SI -> SNDSTRUC (see AX=0688h)
Return: AX = ???
SeeAlso: AX=0688h,AX=068Ah,AX=068Fh
--------s-66068C-----------------------------
INT 66 - IBMSND driver - REPORT AUDIO DRIVER CAPABILITIES
	AX = 068Ch
Return: AX = capabilities (see below)
	DX = playback rate if fixed-frequency playback
SeeAlso: AX=0689h,AX=068Dh

Bitfields for capabilities:
 bit 0	can play audio in background
 bit 1	data is massaged
 bit 2	driver plays at fixed frequency, resampling input data to fit
 bit 3	driver uses timer interrupt
--------s-66068D-----------------------------
INT 66 - IBMSND driver - REPORT CURRENT SAMPLE ADDRESS
	AX = 068Dh
Return: AX = current playback address
Desc:	determine what point in the audio data the playback has reached, for
	  synchronization with video or animation effects
Notes:	this function applies to background playback only
	the reported address may be an approximation rather than the exact
	  address
SeeAlso: AX=068Ch,AX=0691h
--------s-66068E-----------------------------
INT 66 - IBMSND driver - SET CALLBACK ADDRESS
	AX = 068Eh
	BX:DX -> callback function
	    0000h:0000h to disable callback
	DS = value to load into DS when calling the callback function
Desc:	specify the function to be called when playback of a sound effect is
	  completed
Note:	the callback function will typically be called during a hardware
	  interrupt, so all the usual precautions should be taken except for
	  preserving registers
SeeAlso: AX=0691h
--------s-66068F-----------------------------
INT 66 - IBMSND driver - STOP CURRENT SOUND
	AX = 068Fh
Desc:	cause any currently-playing sound effect to be terminated
SeeAlso: AX=0688h,AX=068Bh
--------s-660690-----------------------------
INT 66 - IBMSND driver - "SetAudioHardware" SET UP HARDWARE INFO [obsolete]
	AX = 0690h
Note:	this function is no longer implemented
--------s-660691-----------------------------
INT 66 - IBMSND driver - REPORT CALLBACK ADDRESS
	AX = 0691h
Return: AX:DX -> current callback function
	BX = original caller's DS register
Program: The IBMSND driver is part of John W. Ratcliff's
	   The IBM Digitized Sound Package
SeeAlso: AX=068Eh
--------s-660701-----------------------------
INT 66 - IBM Digitized Sound Package MIDI driver - GET DIGITIZED SOUND CAPABIL
	AX = 0701h
Return: AX = digitized sound capabilities
	    0000h if digitized sound driver (functions 06xxh) not available
Note:	the installation check for the MIDI driver is to test for the signature
	  "MIDI" six bytes before the interrupt handler
SeeAlso: AX=0688h
----------6610-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - GET ???
	AH = 10h
Return: CF clear
	AX = 0000h
	BX = ??? (0012h)
	DX:CX -> TDMOUSE INT 33 handler (IRET to hide mouse from other apps)
Program: TDMOUSE is a PenDOS hardware driver which allows a mouse to emulate
	  a touchpad; PenDOS is a set of programs by Communication Intelligence
	  Corporation which makes applications pen-aware
----------6611-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - SET ??? HANDLER
	AH = 11h
	DX:BX -> new handler for ???
Return: CF clear
	AX = 0000h
	DX:BX -> old handler for ??? (points at RETF by default)
----------6612-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - INITIALIZE
	AH = 12h
Return:	CF clear
	AX = 0000h
Note:	this function calls the old mouse handler with functions 0000h, 0002h,
	  0007h, 0008h, 000Fh, 0004h, and 000Ch (in that order)
SeeAlso: AH=13h
----------6613-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - SHUTDOWN???
	AH = 13h
Return: CF clear
	other register as returned by INT 33/AX=0000h
SeeAlso: AH=12h
----------6614-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - ???
	AH = 14h
	BX = ???
	CX = ???
Return: CF clear
	AX = 0000h
----------6615-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - SET ??? HANDLER
	AH = 15h
	DX:BX -> new handler for ???
Return: CF clear
	AX = 0000h
	DX:BX -> old handler (points at RETF by default)
----------6616-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - UNUSED FUNCTIONS
	AH = 16h to 1Fh
Return: CF set
Program: TDMOUSE is a PenDOS hardware driver which allows a mouse to emulate
	  a touchpad; PenDOS is a set of programs by Communication Intelligence
	  Corporation which makes applications pen-aware
----------6621-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 21h
Return: CF clear if successful
	CF set on error
Note:	this function sets ??? flag or counter (also set by AH=2Fh) to FFFFh
----------6622-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 22h
	DX:BX -> ???
	CL = ???
Return: CF clear if successful
	CF set on error
	???
SeeAlso: AH=24h
----------6623-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 23h
	???
Return: CF clear if successful
	CF set on error
	???
----------6624-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 24h
	DX:BX -> ???
	CL = ???
Return: CF clear if successful
	CF set on error
	???
SeeAlso: AH=22h
----------6625-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 25h
	CL = ??? (NOP if 00h)
	???
Return: CF clear if successful
	CF set on error
	???
----------6627-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 27h
	BL = ???
	BH = ???
	CL = ??? (0-3)
	DL = ??? (> BL)
	DH = ??? (> BH)
Return: ???
----------6628-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 28h
	???
Return: CF clear if successful
	CF set on error
	???
Note:	this function sets ??? flag or counter (also set by AH=2Fh) to FFFFh
----------6629-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 29h
	???
Return: ???
Note:	this function sets ??? flag or counter (also set by AH=2Fh) to FFFFh
----------662A-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 2Ah
	DL = ??? (nonzero)
	DH = ??? (nonzero)
Return: CF clear if successful
	CF set on error
	???
----------662B-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 2Bh
	???
Return: CF clear if successful
	CF set on error
	???
----------662F-------------------------------
INT 66 - PenDOS - PINK - INITIALIZE
	AH = 2Fh
	???
Return: AX = status
	    0000h failed
	    FFFFh successful
	???
Note:	this function sets ??? flag or counter to FFFFh and hooks INT 1Ch
--------F-663345-----------------------------
INT 66 - BitFax Scheduler - REMOVE TSR FROM MEMORY
	AX = 3345h
Return: AX = FFFFh error removing TSR
Note:	the installation check consists of checking for the signature
	  "BitFax Scheduler" beginning two bytes past the interrupt handler
SeeAlso: AH=04h,INT 2F/AH=2Ah,INT 2F/AX=CB00h
Index:	installation check;BitFax Scheduler
----------6640-------------------------------
INT 66 - PenDOS - PKEYUS - GET VERSION
	AH = 40h
Return: CF clear
	AX = 0000h
	BH = major version (02h for version bundled with IBM DOS 6.1)
	BL = minor version (00h for version bundled with IBM DOS 6.1)
	DL = ??? (4Eh)
	DH = ??? (0Eh)
----------6641-------------------------------
INT 66 - PenDOS - PKEYUS - SET ???
	AH = 41h
	BX = ???
	CL = ??? (08h-20h)
	DL = screen column??? (<= 50h)
	DH = screen row???  (<= 3Ch)
Return: AX = status (0000h successful, 0001h error)
Note:	this function also sets an internal flag
SeeAlso: AH=42h,AH=43h
----------6642-------------------------------
INT 66 - PenDOS - PKEYUS - ???
	AH = 42h
Return: CF clear
	AX = 0000h
Note:	this function also clears the flag set by AH=41h
SeeAlso: AH=41h
----------6643-------------------------------
INT 66 - PenDOS - PKEYUS - ???
	AH = 43h
	BX = ???
	DX = ???
Return: AX = status
	    0000h if AH=41h flag set
	    else
		AH = ???
		AL = ???
		BX = ???
		DX = ???
SeeAlso: AH=41h	
----------6644-------------------------------
INT 66 - PenDOS - PKEYUS - UNUSED FUNCTIONS
	AH = 44h to 4Fh
Return: CF set
----------6650-------------------------------
INT 66 - PenDOS - PMOUSE - SET ???
	AH = 50h
	BX = ???
	CH = ???
	DX = ???
Return: CF clear
	AX = 0000h
----------6651-------------------------------
INT 66 - PenDOS - PMOUSE - NOP
	AH = 51h
Return: CF set
----------6652-------------------------------
INT 66 - PenDOS - PMOUSE - ???
	AH = 52h
	BX = ???
	CL = ???
	DX = ???
Return: ???
----------6653-------------------------------
INT 66 - PenDOS - PMOUSE - UNUSED FUNCTIONS
	AH = 53h to 57h
Return: CF set
----------66---------------------------------
INT 66 - PenDOS - PMOUSE - ALTERNATE API
	AH = function (58h-5Fh)
Note:	these functions exactly duplicate AH=50h-57h
----------66C5-------------------------------
INT 66 - PenDOS - VLOAD - API
	AH = C5h
	???
Return: ???
--------t-66FFFBBXFFFB-----------------------
INT 66 - MicroHelp Stay-Res Plus - ???
	AX = FFFBh
	BX = FFFBh
	???
Return: ???
SeeAlso: AX=FFFEh,INT 2D"AMIS"
--------t-66FFFEBXFFFE-----------------------
INT 66 - MicroHelp Stay-Res/Stay-Res Plus - UNINSTALL
	AX = FFFEh
	BX = FFFEh
Return: only if unsuccessful
Notes:	installation check is for the interrupt handler to begin with the bytes
	  FBh 9Ch or 9Ch FAh, and the program name (not case-sensitive) to
	  appear at offset 0005h (older versions) or the offset returned by
	  AX=FFFFh/BX=FFF0h in the interrupt handler segment.
	Programs which use Stay-Res include ThesPlus (program name "THESPLUS")
	  and Personal Calendar (program name "CAL") by Paul Mun~oz-Colman.
SeeAlso: AX=FFFBh,AX=FFFFh,INT 2D"AMIS"
Index:	installation check;MicroHelp Stay-Res|installation check;ThesPlus
Index:	installation check;Personal Calendar|installation check;CAL
--------t-66FFFFBXFFF0-----------------------
INT 66 - MicroHelp Stay-Res Plus - FIND PROGRAM NAME
	AX = FFFFh
	BX = FFF0h
Return: DI = offset of program name in interrupt handler segment
SeeAlso: AX=FFFBh,AX=FFFEh,INT 2D"AMIS"
--------d-67---------------------------------
INT 67 - Adaptec controllers - DRIVE 1 DATA
Note:	this vector stores the last four bytes of the parameter table for
	  hard disk 1
SeeAlso: INT 64"Adaptec",INT 65"Adaptec",INT 66"Adaptec"
--------d-67---------------------------------
INT 67 - Pdisk by Scott Garfinkle - Overwritten for Hard Drive information
SeeAlso: INT 64"Pdisk",INT 66"Pdisk"
--------I-67---------------------------------
INT 67 - Sangoma CCPOP 3270 resident module
SeeAlso: INT 61"Sangoma",INT 68"Sangoma"
--------U-67---------------------------------
INT 67 - CUCKOO.COM - INSTALLATION CHECK
Program: CUCKOO is a resident on-screen clock with optional hourly chime or
	  cuckoo by an unknown author with revisions by Thomas A. Lundin
Note:	this is not a vector; when loaded for the first time, CUCKOO.COM uses
	  the last unused (0000h:0000h) vector in the range 60h-67h to store
	  the signature value 434Ch:4F4Bh ('CLOK')
--------N-6700-------------------------------
INT 67 - PC-NET, Alloy NTNX - LOCK SEMAPHORE AND WAIT
	AH = 00h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see below)
SeeAlso: AH=01h,AH=02h"PC-NET",INT 7F/AH=00h

Values for status:
 00h	successful
 01h	invalid function
 02h	semaphore already locked
 03h	unable to lock semaphore
 04h	semaphore space exhausted
 AH = semaphore owner if status=02h
--------N-6701-------------------------------
INT 67 - PC-NET, Alloy NTNX - LOCK SEMAPHORE
	AH = 01h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see AH=00h)
	AH = semaphore owner if status=02h
SeeAlso: AH=00h,AH=02h"PC-NET",INT 7F/AH=01h"Alloy"
--------N-6702-------------------------------
INT 67 - PC-NET, Alloy NTNX - UNLOCK SEMAPHORE
	AH = 02h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see AH=00h)
	AH = semaphore owner if status=02h
SeeAlso: AH=00h,AH=01h"PC-NET",INT 7F/AH=02h
--------m-671E-------------------------------
INT 67 U - Qualitas 386MAX v7.00 - MEMLIMIT - INSTALLATION CHECK
	AH = 1Eh
Return: AH = 00h if installed
	    AL destroyed
	    ES:DI -> ASCII signature "MemLimit"
SeeAlso: AH=1Fh,INT 21/AX=4402h"386MAX"
--------m-671F-------------------------------
INT 67 U - Qualitas 386MAX v7.00 - MEMLIMIT - API
	AH = 1Fh
	DS:SI -> request packet (see below)
Return: AH = status (00h successful, 84h invalid function code, etc.)
SeeAlso: AH=1Eh

Format of request packet:
Offset	Size	Description
 00h	WORD	function code (00h-0Fh)
 02h	WORD	return code (see below)
 04h  4 BYTEs	???
 08h	WORD	???
	???

Values for return code:
 00h	unknown request
 01h	invalid parameter for VCPI limit
 02h	VCPI limit set
 03h	invalid parameter for EMS limit
 04h	EMS limit set
 05h	DPMI disabled
 06h	XMS disabled
 07h	XMS limit set
 08h	unable to uninstall
 09h	unloaded
--------m-673F--CX5145-----------------------
INT 67 U - QEMM-386 v4.23+ - INSTALLATION CHECK
	AH = 3Fh
	CX = 5145h ("QE")
	DX = 4D4Dh ("MM")
Return: AH = 00h if installed
	    ES:DI -> QEMM API entry point
Notes:	if no other program has hooked INT 67, an alternate installation
	  check is to test for the string
	  "QUARTERDECK EXPANDED MEMORY MANAGER 386" at offset 14h in the INT 67
	  handler's segment; the word at offset 12h contains the offset in
	  the handler's segment of the API entry point
	although this function is still undocumented, Quarterdeck has recently
	  documented two alternate methods for determining the QEMM API entry
	  point, as well as several of the API functions
	MICEMM (Micronics Expanded Memory Manager) versions 2.0C and 4D support
	  the alternate QEMM installation check and entry point functions 00h,
	  02h, and 03h; version 4D only provides the signature string if the
	  commandline argument "DV" is provided
	386MAX v6.01 responds to this call, but DESQview 2.42 does not
	  recognize the returned entry point as providing QEMM's capabilities
	  because a) only functions 0Ch (different from QEMM 0Ch) and
			1000h-1009h are supported,
		  b) status is returned as for EMS functions, not QEMM funcs
		  c) the protected-mode entry point returned by function 1000h
			only supports functions 0Ch, 1004h, 1005h, and 100Ah
	the string check mentioned above is not supported by 386MAX
SeeAlso: AX=5BF0h,AH=DDh,AX=FFA5h,INT 15/AX=11DEh,INT 21/AX=4402h/SF=01h
SeeAlso: INT 21/AX=4402h"QEMM",INT 21/AX=4402h"386MAX",INT 2F/AX=D201h/BX=5145h

Call QEMM entry point with:
	AH = 00h get QEMM state (documented)
		Return: CF clear
			AL = QEMM state
			    bit 0 set if QEMM turned OFF
			    bit 1 set if in "Auto" mode
	AH = 01h set QEMM state (documented)
		AL = new state
		    bit 0 set: place QEMM in OFF state
		Return: CF clear if successful
			CF set on error
	AH = 02h get ???
		Return: CF clear
			AX = segment of ??? data structure
			Data Structure
			Offset	Size	Description
			 00h	DWORD	page table entry for ???
				???
	AH = 03h get QEMM version (documented)
		Return: CF clear
			AX = BX = version in BCD
		Notes:	the most recent official docs state that the version is
			  returned in both AX and BX; older documentation only
			  mentions BX
			MICEMM returns AX=0001h, BX unchanged
	AH = 04h allocate 4K page and set AUTO/ON mode
		Return: CF clear if successful
			    DX = page number of a 4K page
			CF set if unable to allocate page
		Note:	QEMM mode unchanged if not AUTO/OFF
	AH = 05h free 4K page and turn QEMM off
		DX = page number returned by function 04h
		Return: CF clear
		Note:	QEMM mode unchanged if not AUTO/ON
	AH = 06h make new mapping context???
		DX = page number of 4K page to hold page table
		Return: CF clear
		Note:	copies page table into given page and then sets ???
			  page table entry to point at copy
	AH = 07h get mapping context
		Return: CF clear
			DX = page number of page table for current mapping
				context
	AH = 08h set mapping context???
		DX = linear page number of page table
		Return: CF clear
	AH = 09h get linear page number for page table entry
		CX = page table index
		Return: CF clear
			DX = linear page number
	AH = 0Ah set linear page number for page table entry
		CX = page table index
		DX = linear page number
		Return: CF clear
	AH = 0Bh map 4K pages
		BX = number of pages
		CX = first page number (must be 0100h to allocate HMA)
		DX = EMS handle (memory belonging to EMS handle will be mapped
			into the address space beginning with the first page
			allocated to the handle)
		Return: AH = 00h
	AH = 0Ch get available memory
		Return: CF clear
			BX = 0001h
			CX = total 4K pages???
			DX = number of 4K pages free
	AH = 0Dh ??? (related to callbacks)
		AL = 00h/01h/02h ???
		Return: CF clear
	AH = 0Eh set ??? callbacks
		DS:BX -> FAR routine for ???
		ES:DX -> FAR routine for ???
		Return: CF clear
		Note:	DS:BX callback should return BX=???; ES:DX is called
			  with BX=???, and should set the ??? from which the
			  other handler read the value of BX.  BH and BL
			  appear to be separate values.
	AH = 0Fh unmap 4K pages
		CX = first page number
		DX = number of pages
		Return: CF clear
			AL = 00h/01h if ???
		Note:	if CX=0100h and DX=0010h, the HMA is remapped to
			  simulate a disabled A20
	AX = 1000h get protected-mode interface
		DS:SI -> 16-byte buffer for two GDT entries
		ES:DI -> buffer for 4K page table
		Return: CF clear
			EAX = offset of protected-mode API entry point
			DS:SI buffer filled with two GDT descriptors
				first is QEMM code segment, second is data???
			ES:DI buffer filled with 4K page table
			DI points to first unused page table entry
		SeeAlso: INT 67/AX=DE01h
	AX = 1001h get CPU debug registers
		ES:DI -> buffer for debug registers (8 DWORDs)
		Return: CF clear
			BL = INT01 handling (see function 1002h)
			ES:DI buffer filled
	AX = 1002h set CPU debug registers
		BL = INT01 handling
		    00h	 reflect all debugging exceptions as V86-mode INT 01's
		    else convert debugging exceptions other than single-step
			   into V86-mode INT 03's, single-step to INT 01's
		ES:DI -> buffer containing debug registers (8 DWORDs)
		Return: CF clear
		Notes:	identical to INT 67/AX=DE09h if BL=01h
			the INT01 handling flag is set to 01h by the general-
			  protection violation handler for certain privileged
			  instructions
	AX = 1003h get machine status word CR0
		Return: CF clear
			EAX = contents of CR0
		SeeAlso: INT 67/AX=DE07h
	AX = 1004h allocate a 4K page
		Return: CF clear if successful
			    EDX = linear address of allocated page
			CF set on error
		SeeAlso: INT 67/AX=DE04h
	AX = 1005h free 4K page
		EDX = linear address of page to free
		Return: CF clear
		SeeAlso: INT 67/AX=DE05h
	AX = 1006h NOP
		Return: CF set
	AX = 1007h get maximum physical memory address
		Return: CF clear
			EDX = physical address of highest 4K memory page
		SeeAlso: INT 67/AX=DE02h
	AX = 1008h get physical address of page in first megabyte
		CX = page number (linear address shifted right 12 bits)
		Return: CF clear
			EDX = linear address of page
		SeeAlso: function 1F00h
	AX = 1009h switch to protected mode
		ESI = linear address in first megabyte of system reg values
			(see INT 67/AX=DE0Ch)
		interrupts disabled
		Return: interrupts disabled
			GDTR, IDTR, LDTR, TR loaded
			SS:ESP must have at least 16 bytes space, and the
				entry point is required to set up a new stack
				before enabling interrupts
			EAX, ESI, DS, ES, FS, GS destroyed
	AX = 100Ah switch back to virtual-86 mode
		DS = selector for data segment from function 1000h
		SS:ESP in first megabyte of linear memory
		interrupts disabled
		STACK:	QWORD  return address from FAR call to 32-bit segment
			DWORD  EIP
			DWORD  CS
			DWORD  reserved for EFLAGS
			DWORD  ESP
			DWORD  SS
			DWORD  ES
			DWORD  DS
			DWORD  FS
			DWORD  GS
		will switch to virtual86 mode with interrupts disabled, all
		  segment registers loaded, and EAX destroyed.
	AH = 11h get memory type map
		AL = zero/nonzero ??? (set by QEMM.COM but apparently ignored
			by QEMM 6.00)
		ES:DI -> 256-byte buffer for memory types
		Return: CF clear
			BL = ???
			ES:DI buffer filled
		Note:	each byte of the buffer corresponds to a 4K page, and
			  contains the type of that page: 00h = mappable,
			  02h = mapped ROM, 03h = high RAM, 04h = excluded,
			  05h = video, 06h = ROM, 07h = adapter ROM,
			  08h = split ROM, 09h = page frame, 0Ah = RAMmable,
			  0Bh = conventional
	AH = 12h get HIRAM chain
		Return: CF clear
			BX = segment of first MCB in high memory
			    0000h if no high memory
	AX = 1300h VIDRAMEGA???
		BL = 00h copy ???
		     nonzero copy ??? (reverse)
		Return: CF clear
			AL = 00h if all pages clean
			   = 01h if any page dirty
	AX = 1301h check if ???
		DX:DI = start address of range to check ???
		CX = length of range
		Return: CF clear
			CX = ??? (0000h or 1000h)
	AX = 1302h ???
		BL = ???
		BH = ???
		CX = ???
		SI = offset of ???
		DI = offset of ???
		???
		Return: CF clear
			???
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution; also modifies CRT controller during
			  execution under certain circumstances
	AX = 1303h EMS allocation???
		BX = number of pages (less 1) of EMS to allocate
		Return: CF clear if successful
			    DX = EMS handle
			CF set on error
	AX = 1304h EMS deallocation
		DX = EMS handle
		Return: CF clear
	AX = 1305h ???
		CX = ???
		Return: CF clear
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution (see AX=130Ch)
	AX = 1306h set DESQview critical section counter address
		ES:BX -> WORD DESQview critical section counter or 0000h:0000h
		Return: CF clear
		Note:	also sets pointer in low-memory part of QEMM to current
			  value of INT 15 if ES:BX not 0000h:0000h
	AX = 1307h ???
		Return: CF clear
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution (see AX=130Ch)
	AX = 1308h ???
		BL = ??? (zero/nonzero)
		Return: CF clear
	AX = 1309h Hercules mode-change support
		ES:BX -> new address for Hercules mode-change callback
		Return: CF clear
		Note:	the callback function is called whenever the CRTC mode
			  register is written, with AL set to the value written
	AX = 130Ah virtualize EGA/VGA I/O ports 03C8h/03C9h???
		CX:DX -> buffer for storing CRTC register contents???
			or 0000h:0000h to disable
		Return: CF clear
	AX = 130Bh ???
		BL = ???
		Return: CF clear
			???
	AX = 130Ch set interrupts to mask
		BX = interrupts to mask out during AX=1302h,AX=1307h,AX=1308h,
			AX=130Dh,AX=1310h (BL = master PIC, BH = slave PIC)
		Return: CF clear
	AX = 130Dh ???
		???
		Return: CF clear
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution (see AX=130Ch)
	AX = 130Eh ??? (modifies CRT controller setup)
		???
		Return: CF clear
	AX = 130Fh reset ???
		Return: CF clear
	AX = 1310h ???
		???
		Return: CF clear
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution (see AX=130Ch)
	AX = 1311h set ???
		BL = ???
		Return: CF clear
	AX = 1312h (v6.02) NOP???
		Note:	called by DV 2.42, but appears to be a NOP in QEMM 6.02
	AX = 1400h ???
		ES:DI -> ??? data structure (at least 24 bytes)
		BL = ???
		Return: AX = ???
		Data structure
		Offset	Size	Description
		 00h	WORD	???
		 02h	DWORD	far pointer to ???
		 06h	DWORD	far pointer to ??? pointer array (see below)
		 0Ah	DWORD	far pointer to ???
		 0Eh	DWORD	???
		 12h	WORD	segment of ???
		 14h	DWORD	far pointer to ???
		Pointer array
		Offset	Size	Description
		 00h	WORD	number of pointers to follow
		 02h  N DWORDs	far pointers to ???
		Note: QEMM converts the pointers into linear addresses in place
	AX = 1401h ???
		Return: CF clear
			???
	AX = 1402h ???
		BL = function
		    00h NOP
		    01h ???
		    02h ???
		    other ???
		ES:DI -> ???
		Return: CF clear
			???
		Data structure
		Offset	Size	Description
		 00h	WORD	segment of ??? (X, word at X:0136h set to X)
		 02h	WORD	segment of ??? (word at X:0124h set to this)
		 04h	WORD	number of paragraphs of ???
		 06h  3 WORDs	??? (copied to X:0000h)
		 0Ch	WORD	???
	AX = 1403h add ??? to list and ??? (execute func 1406h)
		ES:DI -> ??? structure added to end of ??? list
			(at least 31 bytes, DWORD at offset 06h used for
			 storing pointer to next struc, WORD at offset 00h
			 seems to be a key or index)
		Return: CF clear
	AX = 1404h NOP
	AX = 1405h remove ??? from ??? list
		BX = key???
		Return: CF clear
	AX = 1406h ???
		???
		Return: CF clear
			???
	AX = 1407h ???
		???
		Return: CF clear
			???
	AX = 1408h ???
		???
		Return: CF clear
			???
	AX = 1409h ???
		???
		Return: CF clear
			???
	AX = 140Ah ???
		BX = ???
		Return: CF clear
			???
	AX = 140Bh ???
		BX = ???
		Return: CF clear
			SI = segment of 256-byte buffer???
	AH = 15h ???
		ES:BX -> ??? or 0000h:0000h
		Return: CF clear
     ---QEMM v5.00+ ---
	AX = 1600h get memory access status
		ES:DI -> 256-byte buffer
		Return: ES:DI buffer filled
		Note:	each byte of the buffer indicates the status of a 4K
			  page (bit 0 set if read, bit 1 set if written)
	AX = 1601h set memory access status
		ES:DI -> 256-byte buffer containing access statuses (see above)
	AH = 17h get memory usage statistics
		ES:DI -> 81-byte buffer for memory statistics (see below)
		Return: CF clear
     ---QEMM v5.11+ ---
	AH = 18h check whether conventional memory mapped into address range
		ES:BX = starting address
		CX = number of 4K pages
		Return: CF clear
			AL = 00h one or more pages is remapped
			     01h all pages in range are conventional memory
				(physical address == virtual address)
	AH = 19h NOP
		Return: CF set
	AH = 1Ah I/O port access
		AL = subfunction
		    00h get byte from I/O port
			Return: BL = port value
		    01h send byte to I/O port
			BL = value to send
		    02h send byte to I/O port, get byte from following port
			BH = value to send
			Return: BL = value read
		    03h send bytes to two consecutive I/O ports
			BH = value for first I/O port (DX)
			BL = value for second I/O port (DX+1)
		DX = port number
		Return: CF clear
	AH = 1Bh MS Windows 3.x support
		AL = subfunction
		    00h get EMM Import Structure address
			ES:DI -> buffer for EMM import data structure
			Return: CF set on error
				CF clear if successful
			EMM Import data structure:
			Offset	Size	Description
			 00h	DWORD	physical address of EMM import struct
			 04h	BYTE	major version (v6.00 sets to 01h)
			 05h	BYTE	minor version (v6.00 sets to 00h/0Bh)
			SeeAlso: INT 21/AX=4402h/SF=01h
		    01h ???
			Return: CF set on error
				CF clear if successful
		    02h ???
			Return: CF set on error
				CF clear if successful
		    03h MS Windows initializing
			CX = segment from which Windows init broadcast made???
			DL = Windows startup flags???
			DI = Windows version number (major in upper byte)
			Return: ???
			SeeAlso: INT 2F/AX=1605h
		    04h MS Windows terminating
			Return: CF clear
		    05h determine whether program is driver???
			DS:DX -> ASCIZ filename
			Return: CF clear
				AL = 01h if string ends in ".DRV"
				   = FFh if string ends in "GDI.EXE"
				   = 00h otherwise
		    06h ???
			CX = length of data pointed at by DS:DX
			DS:DX -> ???
			Return: CF clear
		    07h BUG: QEMM 6.00-7.01 accept this and branch randomly
		    else Return: CF set
	AH = 1Ch protected-mode hardware interrupt handlers ???
		AL = subfunction
		    00h restore??? IRQ0-7 handlers
		    01h set??? IRQ0-7 handlers
			ES:DI -> 8 DWORDs containing ???
		    02h restore??? IRQ8-15 handlers
		    03h set??? IRQ8-15 handlers
			ES:DI -> 8 DWORDs containing ???
		BUG: although the jump table only contains four entries,
			QEMM 6.00 will attempt to use it for any value of
			AL between 00h and 2Ah, thus branching unpredictably
			for AL=04h-2Ah; QEMM v7.01 behaves similarly for
			AL=04h-1Bh
     ---QEMM v6.00+ ---
	AH = 1Dh Stealth interrupts
		AL = subfunction
		    00h switch to pre-Stealth interrupt vector table
			Note:	also switches VGA Save table pointer
				  (0040h:00A8h) and overwrites the vectors
				  currently assigned for use by the two
				  interrupt controllers (see INT 67/AX=DE0Ah)
				  with the vectors for INT 08-0F and 70-77 (to
				  avoid crashing the system).
		    01h restore user interrupt vector table
			Notes:	interrupts should be disabled around the
				  AX=1D00h and AX=1D01h calls because QEMM does
				  not modify the memory maps to map in ROM, so
				  an interrupt could be disastrous
				clears any pending IRQ7 at end of function
		    else
			Return: CF set
		Note:	functions 1Dxxh are not supported by QEMM v7.01, and
			  always return CF set
	AH = 1Eh Stealth information (documented)
		AL = subfunction
		    00h "QEMM_GET_INFO" get Stealth configuration
			Return: BL = flags (documented as "reserved")
				    bit 0: conventional memory sorted
				    bit 1: conventional memory filled
				    bit 2: ???
				    bit 3: ???
				    bit 4: expanded memory is in use
				    bit 5: ???
				BH = reserved (always 00h for v6.00)
				CL = stealth type (00h none,46h Frame,4Dh Map)
				CH = suspend/resume interrupt (00h none)
				DX = reserved (always 0000h for v6.00)
				SI = reserved (always 0000h for v6.00)
				DI = reserved (always 0000h for v6.00)
		    01h "QEMM_GET_STEALTH_COUNT" get number of Stealth'ed ROMs
			Return: CF clear
				BX = number of Stealth'ed ROMs
		    02h "QEMM_GET_STEALTH_LIST" get Stealth'ed ROM info
			ES:DI -> buffer for Stealth ROM info (see below)
			Return: CF clear
				BX = number of Stealth'ed ROMs
				ES:DI buffer filled
		    else
			Return: CF set
	AH = 1Fh page table manipulation (documented)
		AL = subfunction
		    00h "QEMM_GET_PTE" get page table entry
			CX = page number
			Return: EDX = page table entry
				CF clear
		    01h "QEMM_SET_PTE" set page table entry
			CX = page number
			EDX = new page table entry
			Return: CF clear
			SeeAlso: function 1008h
		    else
			Return: CF set
	AH = 20h asynchronous disk access support (documented)
		AL = subfunction
		    00h "QEMM_GET_VHI_INFO" get VirtualHDIRQ information
			Return: CF clear
				BL = flags
				    bit 7: VirtualHDIRQ setting respected
					 (set if Stealth active)
				    bits 6-1 reserved
				    bit 0: VirtualHDIRQ currently enabled
					(INT 15/AH=90h suppressed when enabled)
		    01h "QEMM_SET_VHI_FINO" set VirtualHDIRQ state
			BL bit 0 = new VirtualHDIRQ state
			Return: CF clear
				BL = old VHI setting (bits 0 and 7, see above)
		    else
			Return: CF set
	AH = 21h Stealth support (documented)
		AL = subfunction
		    00h "QEMM_COPY_STEALTH_ROMS" copy data from Stealthed addr
			DS:SI -> start address of hidden memory to copy
			ES:DI -> buffer for copied data
			ECX = number of bytes to copy
			Return: CF clear if successful
				CF set on error (DS:SI < C000h:0000h or
						 DS:SI + ECX > 1M)
		    else
			Return: CF set
	---QEMM v6.03+ ---
	AH = 22h DESQview/X support
		AL = subfunction
		    00h get ???
			Return: CF clear
				ES:DI -> ???
		    01h set ???
			ES:DI -> ??? or 0000h:0000h
			Return: CF clear if successful
				CF set on error
	---QEMM v6.04+ ---
	AH = 23h ???
		AL = subfunction
		    00h get ???
			BX = which ??? to get (must be 0000h for v6.04)
			Return: CF clear if successful
				    ES:DI -> ???
				CF set on error
		    01h set ???
			BX = which ??? to set (must be 0000h for v6.04)
			ES:DI -> ???
			Return: CF clear if successful
				CF set on error
		    02h clear specified ???
			BX = which ??? to clear (must be 0000h for v6.04)
			Return: CF clear if successful
				CF set on error
		    FFh clear all ???
		    else
			Return: CF set
	---QEMM v7.01 only---
	AH = 24h ST-DBL support
		AL = subfunction
		    00h set ???
			EDX -> information table
				(EDX = segment SHL 16 + offset)
		    01h ???
	other
		Return: CF set

Format of QEMM 6.0 memory statistics:
Offset	Size	Description
 00h	BYTE	01h if Shadow RAM found, 00h otherwise
 01h	DWORD	initial conventional memory in bytes
 05h	DWORD	initial extended memory in bytes
 09h	DWORD	initial expanded memory in bytes
 0Dh	DWORD	initial "top" or "shadow" memory in bytes
 11h	DWORD	Unavailable conventional memory in bytes
 15h	DWORD	Unavailable extended memory in bytes
 19h	DWORD	Unavailable expanded memory in bytes
 1Dh	DWORD	Unavailable "top" or "shadow" memory in bytes
		Add to offset 49h for Total unavailable top/shadow.
 21h	DWORD	QEMM code size in bytes
 25h	DWORD	QEMM data size in bytes
 29h	DWORD	bytes used for TASKS=
 2Dh	DWORD	DMA buffer size
 31h	DWORD	bytes used for MAPS=
 35h	DWORD	bytes of high RAM
 39h	DWORD	bytes used by mapped ROMs
 3Dh	DWORD	bytes of conventional memory provided by QEMM
 41h	DWORD	bytes of extended memory NOT converted by QEMM (EXT=xxx)
 45h	DWORD	bytes of EMS/XMS pool memory provided by QEMM
 49h	DWORD	Unavailable "top" or "shadow" memory in bytes
		Add to offset 1Dh for Total unavailable top/shadow.
 4Dh	DWORD	conventional memory overhead in bytes
		(set to 0 by QEMM.COM prior to call)

Format of Stealth ROM info [array]:
Offset	Size	Description
 00h	WORD	starting segment of ROM
 02h	WORD	length of ROM in paragraphs
--------m-6740-------------------------------
INT 67 - LIM EMS - GET MANAGER STATUS
	AH = 40h
Return: AH = status (00h,80h,81h,84h) (see below)
Note:	this call can be used only after establishing that the EMS driver is in
	  fact present
SeeAlso: AH=3Fh,AX=FFA5h

Values for EMS function status:
 00h	successful
 80h	internal error
 81h	hardware malfunction
 83h	invalid handle
 84h	undefined function requested by application
 85h	no more handles available
 86h	error in save or restore of mapping context
 87h	insufficient memory pages in system
 88h	insufficient memory pages available
 89h	zero pages requested
 8Ah	invalid logical page number encountered
 8Bh	invalid physical page number encountered
 8Ch	page-mapping hardware state save area is full
 8Dh	save of mapping context failed
 8Eh	restore of mapping context failed
 8Fh	undefined subfunction
 90h	undefined attribute type
 91h	feature not supported
 92h	successful, but a portion of the source region has been overwritten
 93h	length of source or destination region exceeds length of region
	  allocated to either source or destination handle
 94h	conventional and expanded memory regions overlap
 95h	offset within logical page exceeds size of logical page
 96h	region length exceeds 1M
 97h	source and destination EMS regions have same handle and overlap
 98h	memory source or destination type undefined
 9Ah	specified alternate map register or DMA register set not supported
 9Bh	all alternate map register or DMA register sets currently allocated
 9Ch	alternate map register or DMA register sets not supported
 9Dh	undefined or unallocated alternate map register or DMA register set
 9Eh	dedicated DMA channels not supported
 9Fh	specified dedicated DMA channel not supported
 A0h	no such handle name
 A1h	a handle found had no name, or duplicate handle name
 A2h	attempted to wrap around 1M conventional address space
 A3h	source array corrupted
 A4h	operating system denied access
--------m-6741-------------------------------
INT 67 - LIM EMS - GET PAGE FRAME SEGMENT
	AH = 41h
Return: AH = status (see also AH=40h)
	    00h function successful
		BX = segment of page frame
SeeAlso: AH=58h,AH=68h
--------m-6742-------------------------------
INT 67 - LIM EMS - GET NUMBER OF PAGES
	AH = 42h
Return: AH = status (see also AH=40h)
	    00h function successful
		BX = number of unallocated pages
		DX = total number of pages
BUG:	DOS 6.0 EMM386.EXE causes a system lock-up or reboot if in AUTO mode
	  when this call is made; use AH=46h to ensure that EMM386 is ON
	  before making this call
SeeAlso: INT 2F/AX=2702h
--------m-6743-------------------------------
INT 67 - LIM EMS - GET HANDLE AND ALLOCATE MEMORY
	AH = 43h
	BX = number of logical pages to allocate
Return: AH = status (00h,80h,81h,84h,85h,87h,88h,89h) (see AH=40h)
	DX = handle if AH=00h
SeeAlso: AH=45h
--------m-6744-------------------------------
INT 67 - LIM EMS - MAP MEMORY
	AH = 44h
	AL = physical page number (0-3)
	BX = logical page number
	DX = handle
Return: AH = status (00h,80h,81h,83h,84h,8Ah,8Bh) (see AH=40h)
SeeAlso: AH=69h
--------m-6745-------------------------------
INT 67 - LIM EMS - RELEASE HANDLE AND MEMORY
	AH = 45h
	DX = EMM handle
Return: AH = status (00h,80h,81h,83h,84h,86h) (see AH=40h)
SeeAlso: AH=43h
--------m-6746-------------------------------
INT 67 - LIM EMS - GET EMM VERSION
	AH = 46h
Return: AH = status (00h,80h,81h,84h) (see AH=40h)
	AL = EMM version number if AH=00h
--------m-6747-------------------------------
INT 67 - LIM EMS - SAVE MAPPING CONTEXT
	AH = 47h
	DX = handle
Return: AH = status (see below)
SeeAlso: AH=48h

Values for status:
 00h	successful
 80h	internal error
 81h	hardware malfunction
 83h	invalid handle
 84h	undefined function requested
 8Ch	page-mapping hardware state save area is full
 8Dh	save of mapping context failed
 8Eh	restore of mapping context failed
--------m-6748-------------------------------
INT 67 - LIM EMS - RESTORE MAPPING CONTEXT
	AH = 48h
	DX = handle
Return: AH = status (00h,80h,81h,83h,84h,8Eh) (see AH=47h)
SeeAlso: AH=47h
--------m-6749-------------------------------
INT 67 - LIM EMS - reserved - GET I/O PORT ADDRESSES
	AH = 49h
Note:	defined in EMS 3.0, but undocumented in EMS 3.2
--------m-674A-------------------------------
INT 67 - LIM EMS - reserved - GET TRANSLATION ARRAY
	AH = 4Ah
Note:	defined in EMS 3.0, but undocumented in EMS 3.2
--------m-674B-------------------------------
INT 67 - LIM EMS - GET NUMBER OF EMM HANDLES
	AH = 4Bh
Return: AH = status (see below)
	BX = number of EMM handles if AH=00h

Values for status:
 00h	successful
 80h	internal error
 81h	hardware malfunction
 83h	invalid handle
 84h	undefined function requested
--------m-674C-------------------------------
INT 67 - LIM EMS - GET PAGES OWNED BY HANDLE
	AH = 4Ch
	DX = EMM handle
Return: AH = status (see AH=4Bh)
	BX = number of logical pages if AH=00h
SeeAlso: AH=4Dh
--------m-674D-------------------------------
INT 67 - LIM EMS - GET PAGES FOR ALL HANDLES
	AH = 4Dh
	ES:DI -> array to receive information
Return: AH = status (00h,80h,81h,84h) (see AH=4Bh)
	---if AH=00h---
	BX = number of active EMM handles
	array filled with 2-word entries, consisting of a handle and the
	  number of pages allocated to that handle
SeeAlso: AH=4Ch
--------m-674E-------------------------------
INT 67 - LIM EMS - GET OR SET PAGE MAP
	AH = 4Eh
	AL = 00h if getting mapping registers
	     01h if setting mapping registers
	     02h if getting and setting mapping registers at once
	     03h if getting size of page-mapping array
	DS:SI -> array holding information (AL=01h/02h)
	ES:DI -> array to receive information (AL=00h/02h)
Return: AH = status
	    00h successful
		AL = bytes in page-mapping array (AL=03h only)
		array pointed to by ES:DI receives mapping info (AL=00h/02h)
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested
	    8Fh undefined subfunction parameter
	    A3h contents of source array corrupted (EMS 4.0?)
Notes:	this function was designed to be used by multitasking operating systems
	  and should not ordinarily be used by appplication software.
	MD386 returns the size of the page-mapping array in AX instead of AL
SeeAlso: AH=4Fh
--------m-674F-------------------------------
INT 67 - LIM EMS 4.0 - GET/SET PARTIAL PAGE MAP
	AH = 4Fh
	AL = subfunction
	    00h get partial page map
	       DS:SI -> structure containing list of segments whose mapping
			contexts are to be saved
	       ES:DI -> array to receive page map
	    01h set partial page map
	       DS:SI -> structure containing saved partial page map
	    02h get size of partial page map
	       BX = number of mappable segments in the partial map to be saved
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested
	    8Bh one of specified segments is not mappable
	    8Fh undefined subfunction parameter
	    A3h contents of partial page map corrupted or count of mappable
		segments exceeds total number of mappable segments in system
	AL = size of partial page map for subfunction 02h
SeeAlso: AH=4Eh
--------m-6750-------------------------------
INT 67 - LIM EMS 4.0 - MAP/UNMAP MULTIPLE HANDLE PAGES
	AH = 50h
	AL = subfunction
	    00h use physical page numbers
	    01h use segment addresses
	DX = handle
	CX = number of entries in array
	DS:SI -> mapping array (see below)
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h undefined function requested
	    8Ah one or more logical pages are invalid
	    8Bh one or more physical pages are invalid
	    8Fh invalid subfunction
SeeAlso: AH=40h

Format of mapping array entry:
Offset	Size	Description
 00h	WORD	logical page number or FFFFh to unmap physical page
 02h	WORD	physical page number or segment address
--------m-6751-------------------------------
INT 67 - LIM EMS 4.0 - REALLOCATE PAGES
	AH = 51h
	DX = handle
	BX = number of pages to be allocated to handle
Return:	AH = status (00h,80h,81h,83h,84h,87h,88h) (see below)
	BX = actual number of pages allocated to handle

Values for status:
 00h	successful
 80h	internal error
 81h	hardware malfunction
 83h	invalid handle
 84h	undefined function requested
 87h	more pages requested than present in system
 88h	more pages requested than currently available
 8Fh	undefined subfunction
 90h	undefined attribute type
 91h	feature not supported
 A0h	no such handle name
 A1h	duplicate handle name
--------m-6752-------------------------------
INT 67 - LIM EMS 4.0 - GET/SET HANDLE ATTRIBUTES
	AH = 52h
	AL = subfunction
	    00h get handle attributes
		Return: AL = attribute
			    00h handle is volatile
			    01h handle is nonvolatile
	    01h set handle attributes
		BL = new attribute (see returned AL)
	    02h get attribute capability
		Return: AL = attribute capability
			    00h only volatile handles supported
			    01h both volatile and non-volatile supported
	DX = handle
Return: AH = status (00h,80h,81h,83h,84h,8Fh-91h) (see AH=51h)
SeeAlso: AH=53h
--------m-6753-------------------------------
INT 67 - LIM EMS 4.0 - GET/SET HANDLE NAME
	AH = 53h
	AL = subfunction
	    00h get handle name
	       ES:DI -> 8-byte buffer for handle name
	    01h set handle name
	       DS:SI -> 8-byte handle name
	DX = handle
Return: AH = status (00h,80h,81h,83h,84h,8Fh,A1h) (see AH=51h)
SeeAlso: AH=52h
--------m-6754-------------------------------
INT 67 - LIM EMS 4.0 - GET HANDLE DIRECTORY
	AH = 54h
	AL = subfunction
	    00h get handle directory
	       ES:DI -> buffer for handle directory (see below)
	    01h search for named handle
	       DS:SI -> 8-byte name
	    02h get total number of handles
Return: AL = number of entries in handle directory (subfunction 00h)
	DX = value of named handle (subfunction 01h)
	BX = total number of handles (subfunction 02h)
	AH = status (00h,80h,81h,84h,8Fh,A0h,A1h) (see also AH=51h)
	    A1h a handle found had no name

Format of handle directory entry:
Offset	Size	Description
 00h	WORD	handle
 02h  8 BYTEs	handle's name
--------m-6755-------------------------------
INT 67 - LIM EMS 4.0 - ALTER PAGE MAP AND JUMP
	AH = 55h
	AL = subfunction
	    00h physical page numbers provided by caller
	    01h segment addresses provided by caller
	DX = handle
	DS:SI -> structure containing map and jump address
Return: (at target address unless error)
	AH = status (see below)
SeeAlso: AH=56h

Values for status:
 00h	successful
 80h	internal error
 81h	hardware failure
 83h	invalid handle
 84h	undefined function requested
 8Ah	invalid logical page number encountered
 8Bh	invalid physical page number encountered
 8Fh	invalid subfunction
--------m-6756-------------------------------
INT 67 - LIM EMS 4.0 - ALTER PAGE MAP AND CALL
	AH = 56h
	AL = subfunction
	    00h physical page numbers provided by caller
		DX = handle
		DS:SI -> structure containing page map and call address
	    01h segment addresses provided by caller
		DX = handle
		DS:SI -> structure containing page map and call address
	    02h get page map stack space required
		Return: BX = stack space required
Return: (if successful, the target address is called.  Use a RETF to return and
	 restore mapping context)
	AH = status (see AH=55h)
SeeAlso: AH=55h
--------m-6756FF-----------------------------
INT 67 - RM386 v6.00 - ???
	AX = 56FFh
	DS:SI -> ???
	???
Return: ???
--------m-6757-------------------------------
INT 67 - LIM EMS 4.0 - MOVE/EXCHANGE MEMORY REGION
	AH = 57h
	AL = subfunction
	    00h move memory region
	    01h exchange memory region
	DS:SI -> structure describing source and destination (see below)
Return: AH = status (see below)
Note:	source and destination may overlap for a move, in which case the copy
	  direction is chosen such that the destination receives an intact copy
	  of the source region

Values for status:
 00h	successful
 80h	internal error
 81h	hardware failure
 83h	invalid handle
 84h	undefined function requested
 8Ah	invalid logical page number encountered
 8Fh	undefined subfunction
 92h	successful, but a portion of the source region has been overwritten
 93h	length of source or destination region exceeds length of region
	  allocated to either source or destination handle
 94h	conventional and expanded memory regions overlap
 95h	offset within logical page exceeds size of logical page
 96h	region length exceeds 1M
 97h	source and destination EMS regions have same handle and overlap
 98h	memory source or destination type undefined
 A2h	attempted to wrap around 1M conventional address space

Format of EMS copy data:
Offset	Size	Description
 00h	DWORD	region length in bytes
 04h	BYTE	source memory type
		00h conventional
		01h expanded
 05h	WORD	source handle (0000h if conventional memory)
 07h	WORD	source initial offset (within page if EMS, segment if convent)
 09h	WORD	source initial segment (conv mem) or logical page (EMS)
 0Bh	BYTE	destination memory type
		00h conventional
		01h expanded
 0Ch	WORD	destination handle
 0Eh	WORD	destination initial offset
 10h	WORD	destination initial segment or page
--------m-6758-------------------------------
INT 67 - LIM EMS 4.0 - GET MAPPABLE PHYSICAL ADDRESS ARRAY
	AH = 58h
	AL = subfunction
	    00h get mappable physical address array
		ES:DI -> buffer to be filled with array
	    01h get number of entries in m.p.a. array
Return: CX = number of entries in array
	AH = status (00h,80h,81h,84h,8Fh) (see AH=57h)
Note:	the returned array for subfunction 00h is filled in physical segment
	  address order

Format of mappable physical address entry:
Offset	Size	Description
 00h	WORD	physical page segment
 02h	WORD	physical page number
--------m-675857-----------------------------
INT 67 U - NETROOM??? - ???
	AX = 5857h
	BX = function??? (0057h,0059h,0159h seen)
	???
Return: ???
Note:	BX=0059h appears to be analogous to AX=5800h and BX=0159h appears to
	  be analogous to AX=5801h; BX=0057h appears to indicate whether
	  AX=580xh or AX=5857h/BX=0x59h should be used
SeeAlso: AX=5BF0h
--------m-6759-------------------------------
INT 67 - LIM EMS 4.0 - GET EXPANDED MEMORY HARDWARE INFORMATION
	AH = 59h
	AL = subfunction
	    00h get hardware configuration array
		ES:DI -> buffer to be filled with array (see below)
	    01h get unallocated raw page count
		Return: BX = unallocated raw pages
			DX = total raw pages
Return: AH = status (see also AH=58h"EMS 4.0")
	    A4h access denied by operating system
Note:	subfunction 00h is for use by operating systems only, and can be
	  enabled or disabled at any time by the operating system

Format of hardware configuration array:
Offset	Size	Description
 00h	WORD	size of raw EMM pages in paragraphs
 02h	WORD	number of alternate register sets
 04h	WORD	size of mapping-context save area in bytes
 06h	WORD	number of register sets assignable to DMA
 08h	WORD	DMA operation type
		0000h DMA with alternate register sets
		0001h only one DMA register set
--------m-675A-------------------------------
INT 67 - LIM EMS 4.0 - ALLOCATE STANDARD/RAW PAGES
	AH = 5Ah
	AL = subfunction
	    00h allocate standard pages
	    01h allocate raw pages
	BX = number of pages to allocate
Return: DX = handle
	AH = status
	    00h successful
	    80h internal error
	    81h hardware failure
	    84h undefined function requested
	    85h no more handles available
	    87h insufficient memory pages in system
	    88h insufficient memory pages available
	    8Fh undefined subfunction
--------m-675B-------------------------------
INT 67 - LIM EMS 4.0 - ALTERNATE MAP REGISTER SET
	AH = 5Bh
	AL = subfunction
	    00h get alternate map register set
		Return: BL = current active alternate map register set number
			ES:DI -> map register context save area if BL=00h
	    01h set alternate map register set
		BL = new alternate map register set number
		ES:DI -> map register context save area if BL=0
	    02h get alternate map save array size
		Return: DX = array size in bytes
	    03h allocate alternate map register set
		Return: BL = number of map register set; 00h = not supported
	    04h deallocate alternate map register set
		BL = number of alternate map register set
Return: AH = status (00h,80h,81h,84h,8Fh,9Ah-9Dh,A3h,A4h) (see below)
Note:	this function is for use by operating systems only, and can be
	  enabled or disabled at any time by the operating system

Values for status:
 00h	successful
 80h	internal error
 81h	hardware malfunction
 84h	undefined function requested
 8Fh	undefined subfunction
 9Ah	specified alternate map register or DMA register set not supported
 9Bh	all alternate map register or DMA register sets currently allocated
 9Ch	alternate map register or DMA register sets not supported
 9Dh	undefined or unallocated alternate map register/DMA register set
 9Eh	dedicated DMA channels not supported
 9Fh	specified dedicated DMA channel not supported
 A3h	source array corrupted
 A4h	operating system denied access
--------m-675B-------------------------------
INT 67 - LIM EMS 4.0 - ALTERNATE MAP REGISTER SET - DMA REGISTERS
	AH = 5Bh
	AL = subfunction
	    05h allocate DMA register set
		Return: BL = DMA register set number, 00h if not supported
	    06h enable DMA on alternate map register set
	       BL = DMA register set number
	       DL = DMA channel number
	    07h disable DMA on alternate map register set
	       BL = DMA register set number
	    08h deallocate DMA register set
	       BL = DMA register set number
Return: AH = status (00h,80h,81h,84h,8Fh,9Ah-9Fh,A3h,A4h) (see AH=5Ah)
Note:	this function is for use by operating systems only, and can be
	  enabled or disabled at any time by the operating system
--------m-675BE0-----------------------------
INT 67 - MICEMM v4D, RM386 - GET LINEAR ADDRESS OF MEMORY
	AX = 5BE0h
	ES:BX -> memory for which to get linear address
Return: AH = 00h
	CX:DX = linear address of physical memory corresponding to ES:BX
Program: RAM-MAN/386 is the memory manager included with Helix's Netroom;
	  MICEMM is a memory manager for some Micronics motherboards
Note:	this has been superceded by AX=DE06h, which should be used instead
SeeAlso: AX=5BF0h,AX=5BF1h,AX=DE06h
--------m-675BE1-----------------------------
INT 67 - RM386 v6.00+ - GET MEMORY MANAGER SIZE
	AX = 5BE1h
Return: AH = 00h
	CX = code and data size in bytes
	DX:BX = physical address of RM386 code
	DI:SI = total size of RM386 area including handle tables
	BP = number of additional pages (high DOS, etc.)
SeeAlso: AX=5BE0h,AX=5BE2h
--------m-675BE2-----------------------------
INT 67 - RM386 v6.00+ - GET INTERRUPT VECTORS
	AX = 5BE2h
Return: DS:SI -> V86-mode table (see below)
	ES:BX -> ??? (undoc, middle of device driver interrupt routine!)
SeeAlso: AX=5BE0h,AX=5BE1h

Format of V86-mode table:
Offset	Size	Description
 00h	DWORD	original INT 13 vector
 04h	DWORD	original INT 15 vector
 08h	DWORD	original INT 19 vector
 0Ch	DWORD	original INT 21 vector
 10h	DWORD	original INT 4B vector
 14h	DWORD	original INT 67 vector
--------m-675BF0-----------------------------
INT 67 - MICEMM v4D, RM386 - INSTALLATION CHECK
	AX = 5BF0h
Return: AH = 00h if MICEMM or RM386 present
	    BX = code segment of driver
Program: MICEMM is the Micronics Expanded Memory Manager; RM386 is the memory
	  manager included in Helix Software's Netroom
SeeAlso: AH=3Fh,AX=5BE0h,AX=5BF1h
--------m-675BF1-----------------------------
INT 67 - MICEMM v4D, RM386 - GET ADDRESS MAP
	AX = 5BF1h
	ES:BX -> 256-byte (MICEMM) or 512-byte (RM386) buffer for memory types
Return: AH = 00h
	ES:BX buffer filled
Note:	each byte in the buffer specifies the type of a 4K page of memory
SeeAlso: AX=5BE0h,AX=5BF0h

Values for memory type:
 00h	unused (MICEMM), RAM/available (RM386)
 02h	DOS extension (XMS UMB)
 04h	shadowed ROM
 08h	mappable EMS
 10h	page frame
 20h	ROM
 40h	reserved (video memory, etc)
 80h	RAM (MICEMM), Windows UMB (RM386)
--------m-675BF2-----------------------------
INT 67 - RM386 - GET RM386 INTERNAL DATA
	AX = 5BF2h
	CX = size of buffer
	DS:SI -> buffer for internal data
	(documentation says ES:BX -> buffer, SI = offset within RM386)
Return: buffer filled
Note:	the data returned by this function is release-specific
SeeAlso: AX=5BF0h
--------m-675BF3-----------------------------
INT 67 - RM386 - RETURN TO REAL MODE
	AX = 5BF3h
Return: nothing
Note:	use AX=5DE0h instead of this functin
SeeAlso: AX=5BF0h,AX=5DE0h
--------m-675BF4-----------------------------
INT 67 - RM386 v6.00 - GET RM386 GLOBAL FLAGS
	AX = 5BF4h
Return: AH = 00h
	BX = global flags 1 (see below)
	CX = global flags 2 (see below)
	DX = global flags 3 (see below)
	SI = global flags 4 (see below)
SeeAlso: AX=5BF0h

Bitfields for global flags 1:
 bits 0-3 reserved
 bit 4	V86 mode
 bit 5	reserved
 bit 6	80386 or higher CPU
 bits 7,8 reserved
 bit 9	A20 enabled at startup
 bit 10 "HIGH_IO"
 bit 11 ROM
 bit 12 large frame
 bits 13,14 reserved
 bit 15 PS/2-style A20 control

Bitfields for global flags 2:
 bit 0	HMA in use
 bit 1	XMS present
 bit 2	using XMS driver memory
 bit 3	HIGH (NEAT only)
 bits 4-7 reserved
 bit 8	NOBKTRAP
 bit 9	NORESET
 bit 10 ALTMAP
 bit 11 NOFRAME
 bits 12-15 reserved

Bitfields for global flags 3:
 bit 0	NOTEST
 bit 1	NOEBDA
 bit 2	Windows3 support
 bit 3	system board mouse
 bit 4	DISKBUF
 bit 5	EBDALOW
 bit 6	A20 global enable flag
 bit 7	A20 flag
 bit 8	EBDA moved to stub
 bit 9	VXD file was found
 bit 10 reserved
 bit 11 NOBOOTMAP
 bit 12 AUTO
 bit 13 PS/2 machine
 bit 14 Compaq ROM merge active
 bit 15 NOHMA set

Bitfields for global flags 4:
 bit 0	"NOV8259" don't virtualize interrupt controller
 bit 1	NOSCSI
 bit 2	NOSCAN
 bit 3	NOTR
 bit 4	ALTBOOT
 bit 5	NOCOMPQ
 bit 6	KB2TRAP
 bit 7	DESHADOW
 bit 8	Video 7 VGA detected
 bit 9	reserved
 bit 10 NOVGA
 bit 11 NOPS2
 bit 12 DEBUG
 bit 13 NOVKB
 bits 14,15 reserved
--------m-675BF5-----------------------------
INT 67 - RM386 v6.00 - GET RM386 EMS HANDLE COUNT
	AX = 5BF5h
Return: AH = status
	    00h successful
		BX = current number of allocated EMS handles
	    84h function not available
SeeAlso: AX=5BF0h
--------m-675C-------------------------------
INT 67 - LIM EMS 4.0 - PREPARE EXPANDED MEMORY HARDWARE FOR WARM BOOT
	AH = 5Ch
Return: AH = status (see below)

Values for status:
 00h	successful
 80h	internal error
 81h	hardware malfunction
 84h	undefined function requested
--------m-675D-------------------------------
INT 67 - LIM EMS 4.0 - ENABLE/DISABLE OS FUNCTION SET FUNCTIONS
	AH = 5Dh
	AL = subfunction
	    00h enable OS Function Set
	    01h disable OS Function Set
	    02h return access key (resets memory manager, returns access key at
		next invocation)
	BX,CX = access key returned by first invocation
Return: BX,CX = access key, returned only on first invocation of function
	AH = status (see also AH=5Ch)
	    8Fh undefined subfunction
	    A4h operating system denied access
--------m-675D03-----------------------------
INT 67 u - Nanosoft MD386 - INTERNAL INITIALIZATION
	AX = 5D03h
	???
Return: ???
Program: MD386 is a subset EMS memory manager by Nanosoft specifically designed
	  for use with the MultiDOS Plus multitasker
SeeAlso: AX=5D04h,AX=5E00h
--------m-675D04-----------------------------
INT 67 - Nanosoft MD386 - GET ALTERNATE MAP STRUCTURE
	AX = 5D04h
	BX = alternate register set number
	ES:DI -> 1024-byte buffer for map structure
Return: AH = status (see AH=40h)
	buffer filled if AH=00h
Note:	used for debugging purposes
SeeAlso: AX=5D05h
--------m-675D05-----------------------------
INT 67 - Nanosoft MD386 - GET INTERNAL HANDLE TABLE
	AX = 5D05h
	BX = handle number
	ES:DI -> 1024-byte buffer for handle table
Return: AH = status (see AH=40h)
	buffer filled if AH=00h
Note:	used for debugging purposes
SeeAlso: AX=5D04h
--------m-675DE0-----------------------------
INT 67 - RM386 - DISABLE RM386
	AX = 5DE0h
Note:	RM386 traps this functions on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
SeeAlso: AX=5DE1h
--------m-675DE1-----------------------------
INT 67 - RM386 - ENABLE RM386
	AX = 5DE1h
Note:	RM386 traps this functions on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
SeeAlso: AX=5DE0h
--------m-675DE2-----------------------------
INT 67 - RM386 - GET PAGE TABLE
	AX = 5DE2h
	ES:DI -> 1088-byte buffer for page table
Return: ES:DI buffer filled
Note:	RM386 traps this functions on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
SeeAlso: AX=5DE3h
--------m-675DE3-----------------------------
INT 67 - RM386 - SET PAGE TABLE
	AX = 5DE3h
	ES:DI -> 1088-byte buffer containing page table
Notes:	only the access bits of the page table are used, the remainder is
	  ignored
	RM386 traps this functions on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
SeeAlso: AX=5DE2h
--------m-675DE4-----------------------------
INT 67 - RM386 - SET WRITE-PROTECTION FOR PAGE IN FIRST MEGABYTE
	AX = 5DE4h
	BL = page number
	BH = access (00h read-only, 01h read-write)
Note:	RM386 traps this functions on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
--------m-675DE5-----------------------------
INT 67 - RM386 - MAP PHYSICAL PAGE TO PHYSICAL SEGMENT
	AX = 5DE5h
	EBX = physical page number
	DX = page number in first megabyte to be remapped (linear-addr SHR 12)
Return: AH = status
	    00h successful
	    8Bh invalid destination page (not in first megabyte)
Note:	RM386 traps this functions on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
SeeAlso: AX=5DE6h
--------m-675DE6-----------------------------
INT 67 - RM386 - MAP LOGICAL 4K PAGE TO PHYSICAL SEGMENT
	AX = 5DE6h
	BX = logical page number in 4K pages from beginning of memory for EMS
		handle
	CX = segment in first megabyte to be remapped
	DX = previously-allocated EMS handle
Return: AH = status
	    00h successful
	    83h invalid handle
	    8Ah invalid logical page (out of handle's range)
	    8Bh invalid destination page (not in first megabyte)
Note:	RM386 traps this functions on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
SeeAlso: AX=5DE5h
--------m-675DE7-----------------------------
INT 67 - RM386 - SET PAGE TABLE BITS FOR RANGE OF PAGES
	AX = 5DE7h
	BL = page table bits to be set (bits 2-0 = U/S, R/W, P)
	CX = number of pages to set
	DX = first page number to set (in first megabyte)
Return: AH = status
	    00h successful
	    8Bh invalid destination page (not in first megabyte)
	    A5h invalid page bits
	    A6h invalid page count (overflows first megabyte)
Note:	RM386 traps this functions on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
--------m-675DE8-----------------------------
INT 67 - RM386 - GET PARTIAL PAGE TABLE
	AX = 5DE8h
	BX = starting page number in first megabyte+HMA (0000h-010Fh)
	CX = number of page table entries to get
	ES:DI -> buffer for DWORD page table entries
Return: AH = status (00h successful, 8Bh invalid page)
Note:	RM386 traps this functions on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
SeeAlso: AX=5DE9h
--------m-675DE9-----------------------------
INT 67 - RM386 - SET PARTIAL PAGE TABLE
	AX = 5DE9h
	BX = starting page number in first megabyte+HMA (0000h-010Fh)
	CX = number of page table entries to get
	DS:SI -> buffer of DWORD page table entries
Return: AH = status (00h successful, 8Bh invalid destination page)
Note:	RM386 traps this functions on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
SeeAlso: AX=5DE8h
--------m-675DEA-----------------------------
INT 67 - RM386 - V86-MODE I/O PORT TRAPPING CONTROL
	AX = 5DEAh
	BX = function
	    00h globally disable V86-mode trapping
	    01h globally enable V86-mode trapping
		CL = interrupt to use for trapping
	    02h get I/O trapping state
Return: AH = status
	    00h successful
		BX = current trapping state (function 02h)
		    0000h disabled, 0001h enabled
		CX = interrupt used as trap interrupt (functions 00h and 02h)
Notes:	RM386 traps this functions on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
	when I/O trapping is enabled and I/O port access occurs, RM386
	  simulates an INT instruction for the specified interrupt; the
	  interrupt handler is responsible for decoding the trapped instruction
	  and performing the appropriate action.  INT 2C/AX=002Dh provides a
	  similar but more-easily used interface.
SeeAlso: AX=5DEBh,AH=EFh"RM386",INT 2C/AX=002Dh
--------m-675DEB-----------------------------
INT 67 - RM386 - V86-MODE I/O TRAPPING PORT CONTROL
	AX = 5DEBh
	BX = function
	    00h disable V86-mode trapping for specified port
	    01h enable V86-mode trapping for specified port
	    02h get V86-mode trapping state for specified port
	DX = port for which to enable/disable/query trapping
Return: AH = status
	    00h successful
		BX = current trapping state (00h off, 01h on) (function 02)
	    A7h invalid port ID
	    A8h reserved port--cannot trap/untrap (DMA/INT/KBD controllers)
Notes:	RM386 traps this functions on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
SeeAlso: AX=5DEAh
--------m-675DFD-----------------------------
INT 67 U - RM386 v6.00 - ???
	AX = 5DFDh
	???
Return: ???
Note:	RM386 traps this function on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
SeeAlso: AX=5DFEh
--------m-675DFE-----------------------------
INT 67 U - RM386 v6.00 - ???
	AX = 5DFEh
	???
Return: ???
Note:	RM386 traps this function on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
SeeAlso: AX=5DFDh
--------m-675DFF-----------------------------
INT 67 U - RM386 v6.00 - ???
	AX = 5DFFh
	???
Return: ???
Note:	RM386 traps this function on the initial transition to protected
	  mode caused by the INT instruction, which means it can not be
	  overridden simply by hooking the interrupt
SeeAlso: AX=5DFDh,AX=5DFEh
--------m-675E00-----------------------------
INT 67 - Nanosoft MD386 - SET HARDWARE BREAKPOINT
	AX = 5E00h
	DH = breakpoint number (0-3)
	DL = breakpoint attributes (used to set DR7)
	CX:BX = linear address of breakpoint
SeeAlso: AX=5D03h,AX=5E01h
--------m-675E01-----------------------------
INT 67 - Nanosoft MD386 - GET HARDWARE DEBUG REGISTER
	AX = 5E01h
	BL = register number (0-3,7)
Return: CX:BX = value of specified DRx register
SeeAlso: AX=5E00h
--------m-675E02-----------------------------
INT 67 - Nanosoft MD386 - SET DEBUG EXCEPTION HANDLER
	AX = 5E02h
	CX:BX -> exception handler
Note:	the specified exception handler is called with a simulated interrupt
	  whenever a debug exception occurs which was caused by a hardware
	  breakpoint set with the debug registers
SeeAlso: AX=5E04h,AX=5E05h
--------m-675E03-----------------------------
INT 67 - Nanosoft MD386 - ENABLE/DISABLE MEMORY WRITE PROTECTION
	AX = 5E03h
	BL = register map set number
	BH = new state (00h read-only, else read-write)
	CX = linear page number (linear address SHR 12)
Note:	setting write protection in map set 0 will cause the setting to become
	  the default for newly-allocated map sets
--------m-675E04-----------------------------
INT 67 - Nanosoft MD386 - GET DEBUG EXCEPTION
	AX = 5E04h
Return: BL = debug exception (low byte of DR6 register)
SeeAlso: AX=5E02h,AX=5E05h
--------m-675E05-----------------------------
INT 67 - Nanosoft MD386 - IGNORE NEXT DEBUG EXCEPTION
	AX = 5E05h
Note:	may be required when using AX=5E02h for handling instruction
	  breakpoints
SeeAlso: AX=5E02h,AX=5E04h
--------m-6760-------------------------------
INT 67 - EEMS - GET PHYSICAL WINDOW ARRAY
	AH = 60h
	ES:DI -> buffer
Return: AH = status (see also AH=40h)
	AL = number of entries
	buffer at ES:DI filled
--------m-6761-------------------------------
INT 67 - EEMS - GENERIC ACCELERATOR CARD SUPPORT
	AH = 61h
	???
Return: ???
Note:	can be used by accelerator card manufacturer to flush RAM cache,
	  ensuring that the cache accurately reflects what the processor would
	  see without the cache.
--------m-6768-------------------------------
INT 67 - EEMS - GET ADDRESSES OF ALL PAGE FRAMES IN SYSTEM
	AH = 68h
	ES:DI -> buffer
Return: AH = status (see also AH=40h)
	AL = number of entries
	buffer at ES:DI filled
Note:	equivalent to LIM 4.0 function 58h
--------m-6769-------------------------------
INT 67 - EEMS - MAP PAGE INTO FRAME
	AH = 69h
	AL = frame number
	BX = page number
	DX = handle
Return: AH = status (see also AH=40h)
Note:	similar to EMS function 44h
SeeAlso: AH=44h,AH=50h,AH=6Ah
--------m-676A-------------------------------
INT 67 - EEMS - PAGE MAPPING
	AH = 6Ah
	AL = subfunction
	    00h save partial page map
		CH = first page frame
		CL = number of frames
		ES:DI -> buffer which is to be filled
	    01h restore partial page map
		CH = first page frame
		CL = number of frames
		DI:SI -> previously saved page map
	    02h save and restore partial page map
		CH = first page frame
		CL = number of frames
		ES:DI = buffer for current page map
		DI:SI = new page map
	    03h get size of save array
		CH = first page frame
		CL = number of frames
		Return: AL = size of array in bytes
	    04h switch to standard map register setting
	    05h switch to alternate map register setting
	    06h deallocate pages mapped to frames in conventional memory
		CH = first page frame
		CL = number of frames
Return: AH = status (see also AH=40h)
Note:	similar to EMS function 4Eh, except that a subrange of pages can be
	  specified
SeeAlso: AH=69h
--------m-676B-------------------------------
INT 67 - DESQview 2.42-2.53 - BUG
	AH = 6Bh
Note:	the EMM.DVR portion of DESQview branches to a random location on this
	  function due to a fencepost error
--------m-67DD-------------------------------
INT 67 - Quadtel QMAPS - API
	AH = DDh
	AL = function
	???
Return: ???
Notes:	details are not yet available
	Hewlett-Packard's HPMM.SYS is a licensed version of QMAPS, and thus
	  supports this API
SeeAlso: AH=3Fh,AX=FFA5h
--------E-67DE00-----------------------------
INT 67 - Virtual Control Program Interface - INSTALLATION CHECK
	AX = DE00h
Return: AH = 00h    VCPI is present
	    BH = major version number
	    BL = minor version number
	AH nonzero  VCPI not present
BUG:	MS Windows 3.00 is reported to "object violently" to this call.
SeeAlso: INT 2F/AX=1687h
--------E-67DE01-----------------------------
INT 67 - Virtual Control Program Interface - GET PROTECTED MODE INTERFACE
	AX = DE01h
	ES:DI -> 4K page table buffer
	DS:SI -> three descriptor table entries in GDT
		first becomes code segment descriptor, other two for use by
		main control program
Return: AH = 00h successful
	    DI -> first unused page table entry in buffer
	    EBX -> protected mode entry point in code segment
	AH = nonzero  failed
Note:	protected mode entry point may be called with AX=DE00h-DE05h and
	  AX=DE0Ch (in each case, all other registers as appropriate for
	  the function)
SeeAlso: INT 2F/AX=1687h,INT 67/AH=3Fh

QEMM v6.03 protected mode entry point may also be called with:
	AX = DF00h ???
		???
		Return: ???
	AX = DF01h ???
		???
		Return: ???
--------E-67DE02-----------------------------
INT 67 - Virtual Control Program Interface - GET MAX PHYSICAL MEMORY ADDRESS
	AX = DE02h
Return: AH = 00h  successful
	    EDX = physical address of highest 4K memory page
	AH nonzero: failed
SeeAlso: AH=3Fh
--------E-67DE03-----------------------------
INT 67 - Virtual Control Program Interface - GET NUMBER OF FREE 4K PAGES
	AX = DE03h
Return: AH = 00h  successful
	    EDX = number of free 4K pages
	AH nonzero: failed
Notes:	returns total number of pages available to ALL tasks in system
	also available in protected mode by calling the protected-mode VCPI
	  entry point
SeeAlso: AX=DE04h
--------E-67DE04-----------------------------
INT 67 - Virtual Control Program Interface - ALLOCATE A 4K PAGE
	AX = DE04h
Return: AH = 00h successful
	    EDX = physical address of allocated page
	AH nonzero: failed
Notes:	the client program is responsible for freeing all memory allocated
	  with this call before terminating
	also available in protected mode by calling the protected-mode VCPI
	  entry point
SeeAlso: AH=3Fh,AX=DE03h,AX=DE05h
--------E-67DE05-----------------------------
INT 67 - Virtual Control Program Interface - FREE 4K PAGE
	AX = DE05h
	EDX = physical address of 4K page
Return: AH = 00h successful
	AH nonzero: failed
Note:	also available in protected mode by calling the protected-mode VCPI
	  entry point
SeeAlso: AH=3Fh,AX=DE04h
--------E-67DE06-----------------------------
INT 67 - Virtual Control Program Interface - GET PHYS ADDR OF PAGE IN FIRST MB
	AX = DE06h
	CX = page number (linear address shifted right 12 bits)
Return: AH = 00h successful
	    EDX = physical address of page
	AH nonzero: invalid page number (AH = 8Bh recommended)
SeeAlso: AX=5BE0h
--------E-67DE07-----------------------------
INT 67 - Virtual Control Program Interface - READ CR0
	AX = DE07h
Return: AH = 00h
	EBX = value of Control Register 0
SeeAlso: AH=3Fh,AX=DE07h
--------E-67DE08-----------------------------
INT 67 - Virtual Control Program Interface - READ DEBUG REGISTERS
	AX = DE08h
	ES:DI -> array of 8 DWORDs
Return: AH = 00h
	buffer filled with DR0 first, DR7 last, DR4 and DR5 unused
SeeAlso: AH=3Fh,AX=DE09h
--------E-67DE09-----------------------------
INT 67 - Virtual Control Program Interface - SET DEBUG REGISTERS
	AX = DE09h
	ES:DI -> array of 8 DWORDs holding new values of debug registers
Return: AH = 00h
Note:	values for DR4 and DR5 ignored
SeeAlso: AH=3Fh,AX=DE08h
--------E-67DE0A-----------------------------
INT 67 - Virtual Control Program Interface - GET 8259 INTERRUPT VECTOR MAPPINGS
	AX = DE0Ah
Return: AH = 00h successful
	    BX = first vector used by master 8259 (IRQ0)
	    CX = first vector used by slave 8259 (IRQ8)
	AH nonzero: failed
Note:	CX is undefined in systems without a slave 8259
SeeAlso: AX=DE0Bh,INT 21/AX=250Ch,INT 31/AX=0400h
--------E-67DE0B-----------------------------
INT 67 - Virtual Control Program Interface - SET 8259 INTERRUPT VECTOR MAPPINGS
	AX = DE0Bh
	BX = first vector used by master 8259
	CX = first vector used by slave 8259
	interrupts disabled
Return: AH = 00h successful
	AH nonzero: failed
Notes:	This call merely informs the server that the client has changed the
	  interrupt mappings.  The client may not change the mappings if they
	  have already been changed by the server or another client, and is
	  responsible for restoring the original mappings before terminating.
SeeAlso: AX=DE0Ah,INT 2C/AX=002Ah
--------E-67DE0C-----------------------------
INT 67 - Virtual Control Program Interface - SWITCH TO PROTECTED MODE
	AX = DE0Ch
	ESI = linear address in first megabyte of values for system registers
	interrupts disabled
Return: interrupts disabled
	GDTR, IDTR, LDTR, TR loaded
	SS:ESP must have at least 16 bytes space, and the entry point is
		required to set up a new stack before enabling interrupts
	EAX, ESI, DS, ES, FS, GS destroyed
SeeAlso: AH=3Fh,INT 15/AH=89h,INT 38/AH=10h

Note:	in protected mode, calling the protected-mode VCPI entry point with
	  AX = DE0Ch
	  DS = segment selector mapping entire linear address space obtained
		via AX=DE01h
	  SS:ESP in first megabyte of linear memory
	  STACK:QWORD  return address from FAR call to 32-bit segment
		DWORD  EIP
		DWORD  CS
		DWORD  reserved for EFLAGS
		DWORD  ESP
		DWORD  SS
		DWORD  ES
		DWORD  DS
		DWORD  FS
		DWORD  GS
	  and interrupts disabled, will switch to virtual86 mode with
	  interrupts disabled, all segment registers loaded, and EAX destroyed.

Format of system register values for switch to protected mode:
Offset	Size	Description
 00h	DWORD	value for CR3
 04h	DWORD	linear address in first megabyte of value for GDTR
 08h	DWORD	linear address in first megabyte of value for IDTR
 0Ch	WORD	value for LDTR
 0Eh	WORD	value for TR
 10h	PWORD	CS:EIP of protected mode entry-point
--------m-67DE0F-----------------------------
INT 67 - Netroom3 - ???
	AX = DE0Fh
	???
Return: ???
Note:	called by Netroom's DPMI.EXE
--------m-67EF-------------------------------
INT 67 - RM386 v6.00+ - EXECUTE XMS FUNCTION
	AH = EFh
	AL = function (00h-12h,80h-8Fh)
	other register as appropriate for XMS function
Return: varies by function (see INT 2F/AX=4310h)
Note:	these functions appear to be equivalent to the XMS functions with the
	  same numbers
SeeAlso: AH=5Dh"RM386",INT 2F/AX=4310h
--------m-67FFA5-----------------------------
INT 67 - Microsoft EMM386.EXE v4.20+ - INSTALLATION CHECK
	AX = FFA5h
Return: AX = 845Ah if loaded
	    BX:CX -> API entry point
Notes:	this call is available even if EMM386 is not providing EMS
	if no other program has hooked INT 67, an alternate installation
	  check is to test for the string
	  "MICROSOFT EXPANDED MEMORY MANAGER 386" at offset 14h in the INT 67
	  handler's segment; the word immediately preceding this string
	  contains the offset of the API entry point
SeeAlso: AH=3Fh,AX=FFA5h/BX=4345h,INT 21/AX=4402h"EMM386.EXE"

Call API entry point with:
	AH = 00h get memory manager's status
	    Return: AH = status
			bit 0: not active (OFF)
			bit 1: in "Auto" mode
	AH = 01h set memory manager's state
	    AL = new state (00h ON, 01h OFF, 02h AUTO)
	AH = 02h Weitek coprocessor support
	    AL = subfunction
		00h get Weitek support state
		    Return: AL = status
				bit 0: Weitek coprocessor is present
				bit 1: Weitek support is enabled
		01h turn on Weitek support
		02h turn off Weitek support
     --- v4.20-4.41 only ---
	AH = 03h Windows support???
	    AL = subfunction (00h, 01h)
	AH = 04h print copyright notice to standard output
		 (using INT 21/AH=09h)
	AH = 05h print available report
		 (the one shown when running EMM386 from the DOS prompt)
----------67FFA5BX4345-----------------------
INT 67 U - Compaq CEMM v5.10+ - PRIVATE API
	AX = FFA5h
	BX = 4345h ("CE")
	DX = subfunction
	    0000h unshadow video ROM???
	    0001h shadow video ROM???
	    0002h map pages
		CX = number of pages (00h=one)
		ESI = linear address of first page to map into address space
		EDI = linear starting address at which pages are to be visible
	    0003h get ???
		Return: DX = ??? (0-2)
	    0004h BUG: crashes system due to fencepost error
Return: AH = 84h
	AL = status (84h = error, FFh = success)
Note:	if BX <> 4345h or DX > 0004h on entry, CEMM behaves identically to
	  Microsoft's EMM386 (see AX=FFA5h"EMM386")
SeeAlso: AX=FFA5h"EMM386"
--------!------------------------------------
