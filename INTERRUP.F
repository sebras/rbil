Interrupt List, part 6 of 14
Copyright (c) 1989,1990,1991,1992,1993,1994,1995,1996 Ralf Brown
--------D-215F00-----------------------------
INT 21 - DOS 3.1+ network - GET REDIRECTION MODE
	AX = 5F00h
	BL = redirection type
	    03h printer
	    04h disk drive
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
	    BH = redirection state
		00h off
		01h on
Note:	calls INT 2F/AX=111Eh with AX on top of the stack
SeeAlso: AX=5F01h,INT 2F/AX=111Eh
--------D-215F01-----------------------------
INT 21 - DOS 3.1+ network - SET REDIRECTION MODE
	AX = 5F01h
	BL = redirection type
	    03h printer
	    04h disk drive
	BH = redirection state
	    00h off
	    01h on
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
Notes:	when redirection is off, the local device (if any) rather than the
	  remote device is used
	calls INT 2F/AX=111Eh with AX on top of the stack
SeeAlso: AX=5F00h,INT 2F/AX=111Eh,INT 60/AX=0002h
--------D-215F02-----------------------------
INT 21 - DOS 3.1+ network - GET REDIRECTION LIST ENTRY
	AX = 5F02h
	BX = zero-based redirection list index
	CX = driver signature
	    0000h LANtastic
	    4E57h ('NW') NetWare
	DS:SI -> 16-byte buffer for ASCIZ local device name or drive letter
		  followed by colon
	ES:DI -> 128-byte buffer for ASCIZ network name
Return: CF clear if successful
	    BH = device status
		00h valid
		01h invalid
		02h valid (connected from inside Windows for Workgroups v3.11)
	    BL = device type
		03h printer
		04h disk drive
	    CX = user data previously set with AX=5F03h
	    DS:SI and ES:DI buffers filled
	    DX,BP destroyed
	CF set on error
	    AX = error code (01h,12h) (see #0960 at AH=59h)
Notes:	this function is passed through to INT 2F/AX=111Eh by the DOS kernel
	error code 12h is returned if BX is greater than the size of the list
	also supported by Banyan VINES, PC-NFS, LANtastic, and 10NET
	supported by LapLink RemoteAccess but returns the local drive letter;
	  the remote drive letter can be obtained with INT 2F/AX=Cxxxh
	  (see INT 2F/AX=C000h"LapLink")
	the returned device name may or may not include a colon, depending on
	  the network software
SeeAlso: AX=5F03h,AX=5F46h,INT 2F/AX=111Eh,INT 2F/AX=C000h"LapLink"
--------D-215F03-----------------------------
INT 21 - DOS 3.1+ network - REDIRECT DEVICE
	AX = 5F03h
	BL = device type
	    03h printer
	    04h disk drive
	CX = user data to save
		0000h for LANtastic
		4E57h ("NW") for NetWare 4.0 requester
	DS:SI -> ASCIZ local device name (16 bytes max)
	ES:DI -> ASCIZ network name + ASCIZ password (128 bytes max total)
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,03h,05h,08h,0Fh,12h) (see #0960 at AH=59h)
Notes:	if device type is disk drive, DS:SI must point at either a null string
	  or a string consisting the drive letter followed by a colon; if a
	  null string, the network attempts to access the destination without
	  redirecting a local drive
	the DOS kernel calls INT 2F/AX=111Eh with AX on top of the stack
	also supported by Banyan VINES, LANtastic, and 10NET
SeeAlso: AX=5F02h,AX=5F04h,INT 2F/AX=111Eh,INT 60/AX=0002h
--------D-215F04-----------------------------
INT 21 - DOS 3.1+ network - CANCEL REDIRECTION
	AX = 5F04h
	DS:SI -> ASCIZ local device name or path
	CX = 4E57h ("NW") for NetWare 4.0 requester
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,03h,05h,08h,0Fh,12h) (see #0960 at AH=59h)
Notes:	the DS:SI string must be either a local device name, a drive letter
	  followed by a colon, or a network directory beginning with two
	  backslashes
	the DOS kernel calls INT 2F/AX=111Eh with AX on top of the stack
	also supported by Banyan VINES, LANtastic, and 10NET
	for NetWare, if only a server name is specified (i.e. "\\SERVER"),
	  the connection to that server will be closed
SeeAlso: AX=5F03h,INT 2F/AX=111Eh,INT 60/AX=0003h
--------D-215F05-----------------------------
INT 21 - DOS 4.0+ network - GET EXTENDED REDIRECTION LIST ENTRY
	AX = 5F05h
	BX = redirection list index
	DS:SI -> buffer for ASCIZ source device name
	ES:DI -> buffer for destination ASCIZ network path
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
	    AX = server's network process ID handle (10NET)
	    BH = device status flag (bit 0 clear if valid)
	    BL = device type (03h if printer, 04h if drive)
	    CX = stored parameter value (user data) from AX=5F03h
	    BP = NETBIOS local session number
	    DS:SI buffer filled
	    ES:DI buffer filled
Notes:	the local session number allows sharing the redirector's session number
	if an error is caused on the NETBIOS LSN, the redirector may be unable
	  to correctly recover from errors
	the DOS kernel calls INT 2F/AX=111Eh with AX on top of the stack
	supported by DR DOS 5.0
	also supported by 10NET v5.0
SeeAlso: AX=5F06h"Network",INT 2F/AX=111Eh
--------O-215F05-----------------------------
INT 21 - STARLITE architecture - MAP LOCAL DRIVE LETTER TO REMOTE FILE SYSTEM
	AX = 5F05h
	DL = drive number (0=A:)
	DS:SI -> ASCIZ name of the object to map the drive to
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
SeeAlso: AX=5F06h"STARLITE",INT 60/AX=0002h
--------N-215F06-----------------------------
INT 21 U - Network - GET FULL REDIRECTION LIST
	AX = 5F06h
	???
Return: ???
Notes:	similar to AX=5F02h and AX=5F05h, but also returns redirections
	  excluded from those calls for various reasons
	calls INT 2F/AX=111Eh with AX on top of the stack
SeeAlso: AX=5F05h"DOS",INT 2F/AX=111Eh
--------O-215F06-----------------------------
INT 21 - STARLITE architecture - UNMAP DRIVE LETTER
	AX = 5F06h
	DL = drive to be unmapped (0=A:)
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
SeeAlso: AX=5F05h"STARLITE",INT 60/AX=0003h
--------D-215F07-----------------------------
INT 21 - DOS 5+ - ENABLE DRIVE
	AX = 5F07h
	DL = drive number (0=A:)
Return: CF clear if successful
	CF set on error
	    AX = error code (0Fh) (see #0960 at AH=59h)
Notes:	simply sets the "valid" bit in the drive's CDS
	this function is not supported by Novell DOS 7 through at least
	  Update 4, but support was added by Update 13
SeeAlso: AH=52h,AX=5F08h"DOS"
--------O-215F07-----------------------------
INT 21 - STARLITE architecture - MAKE NAMED OBJECT AVAILABLE ON NETWORK
	AX = 5F07h
	DS:SI -> ASCIZ name of object to offer to network
	ES:DI -> ASCIZ name under which object will be known on the network
		MUST begin with three slashes
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
SeeAlso: AX=5F08h"STARLITE"
--------D-215F08-----------------------------
INT 21 - DOS 5+ - DISABLE DRIVE
	AX = 5F08h
	DL = drive number (0=A:)
Return: CF clear if successful
	CF set on error
	    AX = error code (0Fh) (see #0960 at AH=59h)
Notes:	simply clears the "valid" bit in the drive's CDS
	this function is not supported by Novell DOS 7 through at least
	  Update 4, but support was added by Update 13
SeeAlso: AH=52h,AX=5F07h"DOS"
--------O-215F08-----------------------------
INT 21 - STARLITE architecture - REMOVE GLOBAL NETWORK NAME OF OBJECT
	AX = 5F08h
	DS:SI -> ASCIZ network name (not local name) of object to unshare
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
SeeAlso: AX=5F07h"STARLITE"
--------O-215F09-----------------------------
INT 21 - STARLITE architecture - BIND TO NETWORK DEVICE
	AX = 5F09h
	DS:DX -> ASCIZ name of the device driver to attach to
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
Note:	the STARLITE distributed file system can attach to multiple networks
	  simultaneously
SeeAlso: AX=5F0Ah
--------O-215F0A-----------------------------
INT 21 - STARLITE architecture - DETACH FROM NETWORK DEVICE
	AX = 5F0Ah
	DS:DX -> ASCIZ name of device driver to detach from
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
SeeAlso: AX=5F09h
--------N-215F30-----------------------------
INT 21 U - LAN Manager Enhanced DOS - GET REDIRECTOR VERSION
	AX = 5F30h
Return: AX = version (AH=major,AL=minor)
--------N-215F32-----------------------------
INT 21 u - Named Pipes - LOCAL DosQNmPipeInfo
	AX = 5F32h
	BX = handle
	CX = size of _PIPEINFO structure
	DX = level (must be 0001h)
	DS:SI -> _PIPEINFO structure (see #0981)
Return: CF clear if successful
	    _PIPEINFO structure filled in
	CF set on error
	    AX = error code
Note:	this function was introduced by LAN Manager but is also supported by
	  the Novell DOS Named Pipe Extender, Banyan VINES, OS/2 Virtual DOS
	  Machines, and others
SeeAlso: AX=5F33h,AX=5F34h

Format of Named Pipes _PIPEINFO structure:
Offset	Size	Description	(Table 0981)
 00h	WORD	size of outgoing buffer
 02h	WORD	size of incoming buffer
 04h	BYTE	maximum number of instances allowed
 05h	BYTE	current number of instances
 06h	BYTE	length of the name (including terminating NUL)
 07h  N BYTEs	name
--------N-215F33-----------------------------
INT 21 u - Named Pipes - LOCAL DosQNmPHandState
	AX = 5F33h
	BX = handle
Return: CF clear if successful
	    AH = pipe mode bit mask (see #0982)
	    AL = maximum number of instances
	CF set on error
	    AX = error code
Note:	this function was introduced by LAN Manager but is also supported by
	  the Novell DOS Named Pipe Extender, Banyan VINES, OS/2 Virtual DOS
	  Machines, and others
SeeAlso: AX=5F32h,AX=5F34h

Bitfields for Named Pipes pipe mode:
Bit(s)	Description	(Table 0982)
 7	set if nonblocking, clear if blocking
 6	set if server end, clear if client end
 2	set if write in message mode, clear if write in byte mode
 0	set if read in message mode, clear if read in byte mode
--------N-215F34-----------------------------
INT 21 u - Named Pipes - LOCAL DosSetNmPHandState
	AX = 5F34h
	BX = handle
	CX = pipe mode bit mask
	    bit 15: set if nonblocking, clear if blocking
	    bit	 8: set if read in message mode, clear if read in byte mode
Return: CF clear if successful
	CF set if error
	    AX = error code
Note:	this function was introduced by LAN Manager but is also supported by
	  the Novell DOS Named Pipe Extender, Banyan VINES, OS/2 Virtual DOS
	  Machines, and others
SeeAlso: AX=5F32h,AX=5F33h,AX=5F36h
--------N-215F35-----------------------------
INT 21 u - Named Pipes - LOCAL DosPeekNmPipe
	AX = 5F35h
	BX = handle
	CX = buffer length
	DS:SI -> buffer
Return:	CF set on error
	    AX = error code
	CF clear if successful (LAN Manager v1-v2)
	AX = 0000h if successful (LAN Manager 3.x)
	---if successful---
	    CX = bytes read
	    SI = bytes left in the pipe
	    DX = bytes left in the current message
	    AX = pipe status (v1-v2) (see #0983)
	    DI = pipe status (v3.x)
Note:	this function was introduced by LAN Manager but is also supported by
	  the Novell DOS Named Pipe Extender, Banyan VINES, OS/2 Virtual DOS
	  Machines, and others
SeeAlso: AX=5F38h,AX=5F39h,AX=5F51h

(Table 0983)
Values for pipe status:
 0001h	disconnected
 0002h	listening
 0003h	connected
 0004h	closing
--------N-215F36-----------------------------
INT 21 u - Named Pipes - LOCAL DosTransactNmPipe
	AX = 5F36h
	BX = handle
	CX = in buffer length
	DS:SI -> in buffer
	DX = out buffer length
	ES:DI -> out buffer
Return: CF clear if successful
	    CX = bytes read
	CF set on error
	    AX = error code
Note:	this function was introduced by LAN Manager but is also supported by
	  the Novell DOS Named Pipe Extender, Banyan VINES, OS/2 Virtual DOS
	  Machines, and others
SeeAlso: AX=5F34h,AX=5F37h
--------N-215F37-----------------------------
INT 21 u - Named Pipes - DosCallNmPipe
	AX = 5F37h
	DS:SI -> DosCallNmPipe stack frame (see #0984)
Return: CF clear if successful
	    CX = bytes read
	CF set on error
	    AX = error code
Note:	this function was introduced by LAN Manager but is also supported by
	  the Novell DOS Named Pipe Extender, Banyan VINES, OS/2 Virtual DOS
	  Machines, and others
SeeAlso: AX=5F36h,AX=5F38h

Format of Named Pipes DosCallNmPipe stack frame:
Offset	Size	Description	(Table 0984)
 00h	DWORD	timeout
 04h	DWORD	-> bytes read WORD (not used!)
 08h	WORD	out buffer length
 0Ah	DWORD	address of out buffer
 0Eh	WORD	in buffer length
 10h	DWORD	address of in buffer
 14h	DWORD	address of pipe name
--------N-215F38-----------------------------
INT 21 u - Named Pipes - LOCAL DosWaitNmPipe - AWAIT AVAIL. OF PIPE INSTANCE
	AX = 5F38h
	DS:DX -> pipe name
	BX:CX = timeout value
Return: CF clear if successful
	CF set if error
	    AX = error code
Notes:	when a client gets a return code of ERROR_PIPE_BUSY on attempting to
	  open a pipe, it should issue this call to wait until the pipe
	  instance becomes available again; on return from this call, the
	  client must attempt to open the pipe once again
	this function was introduced by LAN Manager but is also supported by
	  the Novell DOS Named Pipe Extender, Banyan VINES, OS/2 Virtual DOS
	  Machines, and others
SeeAlso: AX=5F37h,AX=5F39h
--------N-215F39-----------------------------
INT 21 U - Named Pipes - LOCAL DosRawReadNmPipe
	AX = 5F39h
	BX = handle
	CX = buffer length
	DS:DX -> buffer
Return: CF clear if successful
	    CX = bytes read
	CF set if error
	    AX = error code
Notes:	this function was introduced by LAN Manager but is also supported by
	  the Novell DOS Named Pipe Extender, Banyan VINES, OS/2 Virtual DOS
	  Machines, and others
	not documented in the LAN Manager Toolkit
SeeAlso: AX=5F35h,AX=5F3Ah,INT 2F/AX=1186h
--------N-215F3A-----------------------------
INT 21 U - Named Pipes - LOCAL DosRawWriteNmPipe
	AX = 5F3Ah
	BX = handle
	CX = buffer length
	DS:DX -> buffer
Return: CF clear if successful
	    CX = bytes written
	CF set if error
	    AX = error code
Notes:	this function was introduced by LAN Manager but is also supported by
	  the Novell DOS Named Pipe Extender, Banyan VINES, OS/2 Virtual DOS
	  Machines, and others
	not documented in the LAN Manager Toolkit
SeeAlso: AX=5F39h,AX=5F3Bh,INT 2F/AX=118Fh
--------N-215F3B-----------------------------
INT 21 u - LAN Manager Enhanced DOS - NetHandleSetInfo
	AX = 5F3Bh
	BX = handle
	CX = handle_info_1 structure length or sizeof DWORD
	DI = parameter number to set
	    0000h all
	    0001h number of milliseconds
	    0002h number of characters
	DS:DX -> handle_info_1 structure (DI=0000h) (see #0985)
		or DWORD (DI=0001h or 0002h)
	SI = level of information (0001h)
Return: CF clear if successful
	    CX = total bytes available
	CF set if error
	    AX = error code
SeeAlso: AX=5F3Ch

Format of LAN Manager handle_info_1 structure:
Offset	Size	Description	(Table 0985)
 00h	DWORD	number of milliseconds which workstation collects data before
		  it sends the data to the named pipe
 04h	DWORD	number of characters which workstation collects before it
		  sends the data to the named pipe
--------N-215F3C-----------------------------
INT 21 u - LAN Manager Enhanced DOS - NetHandleGetInfo
	AX = 5F3Ch
	BX = handle
	CX = length of handle_info_1 structure
	DS:DX -> handle_info_1 structure (see #0985)
	SI = level of information (must be 0001h)
Return: CF clear if successful
	    CX = total bytes available
	CF set if error
	    AX = error code
SeeAlso: AX=5F3Bh
--------N-215F3D-----------------------------
INT 21 U - LAN Manager Enhanced DOS - WRITE MAILSLOT???
	AX = 5F3Dh
	???
Return: ???
--------N-215F3E-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetSpecialSMB
	AX = 5F3Eh
	???
Return: ???
Note:	This function is not documented anywhere in the LAN Manager 2.x Toolkit
	  but was documented in LAN Manager 1.x manuals.
--------N-215F3F-----------------------------
INT 21 U - LAN Manager Enhanced DOS - REMOTE API CALL
	AX = 5F3Fh
	CX = api number
	ES:DI -> data descriptor
	ES:SI -> parameter descriptor
	ES:DX -> auxiliary descriptor (if DX <> 0)
	???
Return: ???
--------N-215F40-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetMessageBufferSend
	AX = 5F40h
	DS:DX -> NetMessageBufferSend parameter structure (see #0986)
Return: AX = error code

Format of LAN Manager NetMessageBufferSend parameter structure:
Offset	Size	Description	(Table 0986)
 00h	DWORD	-> recipient name (name for specific user, name* for domain
		      wide name, * for broadcast)
 04h	DWORD	-> buffer
 08h	WORD	length of buffer
--------N-215F41-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetServiceEnum
	AX = 5F41h
	BL = level of detail (0000h, 0001h or 0002h)
	CX = buffer length
	ES:DI -> buffer of service_info_0, service_info_1, or service_info_2
		(see #0987,#0988,#0989)
Return: CF clear if successful
	    CX = entries read
	    DX = total available
	CF set on error
	    AX = error code

Format of LAN Manager service_info_0 structure:
Offset	Size	Description	(Table 0987)
 00h 16 BYTEs	name
SeeAlso: #0988,#0989

Format of service_info_1 structure:
Offset	Size	Description	(Table 0988)
 00h 16 BYTEs	name
 10h	WORD	status bitmask (see #0990)
 12h	DWORD	status code (see #0991)
		(also see Microsoft LAN Manager Programmer's Reference)
 16h	WORD	process id
SeeAlso: #0987,#0989

Format of service_info_2 structure:
Offset	Size	Description	(Table 0989)
 00h 16 BYTEs	name
 10h	WORD	status bitmask (see #0990)
 12h	DWORD	status code (see #0991)
 16h	WORD	process id
 18h 64 BYTEs	text
SeeAlso: #0987,#0988

Bitfields for LAN Manager status bitmask:
Bit(s)	Description	(Table 0990)
 0,1	00 uninstall
		01 install pending
		10 uninstall pending
		11 installed
 2,3	00 active
		01 Continue pending
		10 Pause pending
		11 paused
 4	uninstallable
 5	pausable
 8	disk redirector paused
 9	spooled device redirector paused (printing)
 10	communication device redirector paused

(Table 0991)
Values for LAN Manager status code:
 high word
    3051 Bad parameter value
    3052 A parameter is missing
    3053 An unknown parameter was specified
    3054 The resource is insufficient
    3055 Configuration is faulty
    3056 An MS-DOS or MS OS/2 error occured
    3057 An internal error occured
    3058 An ambiguous parameter name was given
    3059 A duplicate parameter exists
    3060 The service was terminated by NetSeviceControl when it did not respond
    3061 The service program file could not be executed
    3062 The subservice failed to start
    3063 There is a conflict in the value or use of these parameters
    3064 There is a problem with the file
 low word
    3070 There is insufficient memory
    3071 There is insufficeient disk space
    3072 Unable to create thread
    3073 Unable to create process
    3074 A security failure occured
    3075 There is bad or missing default path
    3076 Network software is not installed
    3077 Server software is not installed
    3078 The server could not access the UAS database
    3079 The action requires user-level security
    3080 The log directory is invalid
    3081 The LAN group specificed could not be used
    3082 The computername is being used as a message alias on another computer
    3083 The workstation failed to announce the servername
    3084 The user accounts system is not configured properly
--------N-215F42-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetServiceControl
	AX = 5F42h
	DH = opcode
	    00h interrogate status
	    01h pause
	    02h continue
	    03h uninstall
	DL = argument
	    01h disk resource
	    02h print resource
	    04h communications resource (not implemented for DOS)
	ES:BX -> NetServiceControl parameter structure (see #0992)
Return: CF clear if successful
	CF set on error
	    AX = error code

Format of LAN Manager NetServiceControl parameter structure:
Offset	Size	Description	(Table 0992)
 00h	DWORD	-> service name
 04h	WORD	result buffer size
 06h	DWORD	-> result buffer as service_info_2 structure
--------N-215F43-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL DosPrintJobGetId
	AX = 5F43h
	BX = handle of remote print job
	CX = size of PRIDINFO struture
	ES:DI -> PRIDINFO structure (see #0993)
Return: CF clear if successful
	    PRIDINFO filled in
	CF set on error
	    AX = error code

Format of LAN Manager PRIDINFO structure:
Offset	Size	Description	(Table 0993)
 00h	WORD	job id
 02h 16 BYTEs	server name
 12h 13 BYTEs	queue name
 1Fh  1 BYTE	pad
--------N-215F44-----------------------------
INT 21 - LAN Manager Enhanced DOS - LOCAL NetWkstaGetInfo
	AX = 5F44h
	BX = information level (00h, 01h, or 0Ah)
	CX = buffer size
	ES:DI -> buffer in which to store info (see #0994,#0995,#0996)
Return: AX = error code
	DX = amount of buffer used (or required)
SeeAlso: AX=5F45h,AX=5F49h

Format of LAN Manager wksta_info_0 structure:
Offset	Size	Description	(Table 0994)
 00h	WORD	 reserved (0)
 02h	DWORD	 reserved (0)
 06h	DWORD	 -> path to computer's LANMAN directory
 0Ah	DWORD	 -> computername of the workstation
 0Eh	DWORD	 -> username of user logged onto workstation
 12h	DWORD	 -> domain to which workstation belongs
 16h	WORD	 LAN Manager version number (2 bytes, Major, Minor)
 18h	DWORD	 reserved (0)
 22h	WORD	 number of seconds workstation waits for resource availability
 24h	DWORD	 delay (in millsecs) before sending data to resource
 28h	WORD	 reserved (0)
 2Ah	WORD	 reserved (0)
 2Ch	WORD	 number of seconds to maintain an inactive connection
 2Eh	WORD	 number of seconds an inactive search continues
 30h	WORD	 threads to dedicate to network (not supported in MSDOS)
 32h	WORD	 number of simultaneous commands sent to network
 34h	WORD	 reserved6 (must be 0)
 36h	WORD	 number of internal buffers
 38h	WORD	 size (in bytes) of each internal buffer
 3Ah	WORD	 max size (in bytes) of an internal cache buffer (not MSDOS)
 3Ch	WORD	 seconds before disconnecting inactive session (not MSDOS)
 3Eh	WORD	 size (in bytes) of an internal error buffer (not MSDOS)
 40h	WORD	 number of clients that can receive alert messages (not MSDOS)
 42h	WORD	 number of services that can be started on workstation
 44h	WORD	 max size (in kilobytes) of error log (not MSDOS)
 46h	WORD	 number of secs before closing inactive print jobs (not MSDOS)
 48h	WORD	 number of character buffers for workstation
 4Ah	WORD	 max size (in bytes) of character buffer
 4Ch	DWORD	 -> name of server that validated logon
 50h	DWORD	 -> workstation heuristics
 52h	WORD	 number of mailslots allowed
SeeAlso: #0995,#0996

Format of LAN Manager wksta_info_1 structure:
Offset	Size	Description	(Table 0995)
 00h 84 BYTEs	wksta_info_0 structure (see #0994)
 54h	DWORD	 -> name of domain which user is logged on to
 58h	DWORD	 -> all domains in which computer is enlisted
 5Ch	WORD	 number of buffers to allocate for receiving datagrams
SeeAlso: #0996

Format of LAN Manager wksta_info_10 structure:
Offset	Size	Description	(Table 0996)
 00h	DWORD	 -> computername of the workstation
 04h	DWORD	 -> username of user logged onto workstation
 08h	DWORD	 -> domain to which workstation belongs
 0Ch	WORD	 LAN Manager version number (2 bytes, Major, Minor)
 0Eh	DWORD	 -> name of domain which user is loggod on to
 12h	DWORD	 -> all domains in which computer is enlisted
SeeAlso: #0994,#0995
--------N-215F45-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetWkstaSetInfo
	AX = 5F45h
	BX = level (0000h or 0001h)
	CX = buffer size
	DX = parameter to set
	ES:DI -> buffer
Return: CF clear if successful
	CF set if error
	    AX = error code
SeeAlso: AX=5F44h
--------N-215F46-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetUseEnum
	AX = 5F46h
	BX = level (0000h or 0001h)
	CX = size of buffer
	ES:DI -> buffer of use_info_0 or use_info_1 structures
		  (see #0997,#0998)
Return: CF clear if successful
	    CX = entries read
	    DX = total available entries
	CF set if error
	    AX = error code
SeeAlso: AX=5F47h,AX=5F48h,AX=5F4Ch

Format of LAN Manager use_info_0 structure:
Offset	Size	Description	(Table 0997)
 00h  9 BYTEs	local device name
 09h	BYTE	padding
 0Ah	DWORD	-> remote device name in UNC form \\server\share
SeeAlso: #0998

Format of LAN Manager use_info_1 structure:
Offset	Size	Description	(Table 0998)
 00h  9 BYTEs	Local device name
 09h	BYTE	padding
 0Ah	DWORD	-> remote device name in UNC form \\server\share
 0Eh	DWORD	-> password
 12h	WORD	network link status
		(00h OK, 02h disconnected, else unsure)
 14h	WORD	use type (-1 wildcard, 0 disk, 1 print, 2 com, 3 ipc)
 16h	WORD	ignored
 18h	WORD	ignored
SeeAlso: #0997
--------N-215F47-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetUseAdd
	AX = 5F47h
	BX = level (0001h)
	CX = size of use_info_1 structure
	ES:DI -> use_info_1 structure (see #0998)
Return: CF clear on success
	CF set on error
	    AX = error code
SeeAlso: AX=5F46h,AX=5F48h
--------N-215F48-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetUseDel
	AX = 5F48h
	BX = force level
	    0000h no force
	    0001h force
	    0002h lots of force
	ES:DI -> buffer as either the local device name or UNC remote name
Return: CF clear on success
	CF set on error
	    AX = error code
SeeAlso: AX=5F46h,AX=5F48h,AX=5F49h
--------N-215F49-----------------------------
INT 21 u - LAN Manager Enhanced DOS - NetUseGetInfo
	AX = 5F49h
	DS:DX -> NetUseGetInfo parameter structure (see #0999)
Return: CF clear on success
	    DX = total available
	CF set on error
	    AX = error code
SeeAlso: AX=5F44h,AX=5F47h

Format of LAN Manager NetUseGetInfo parameter structure:
Offset	Size	Description	(Table 0999)
 00h	DWORD	pointer to either the local device name or UNC remote name
 04h	WORD	level of information (0000h or 0001h)
 06h	DWORD	pointer to buffer of use_info_0 or use_info_1 structures
 0Ah	WORD	length of buffer
--------N-215F4A-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetRemoteCopy
	AX = 5F4Ah
	DS:DX -> NetRemoteCopy parameter structure (see #1000)
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F4Bh

Format of LAN Manager NetRemoteCopy parameter structure:
Offset	Size	Description	(Table 1000)
 00h	DWORD	-> source name as UNC
 04h	DWORD	-> destination name as UNC
 08h	DWORD	-> source password
 0Ch	DWORD	-> destination password
 10h	WORD	destination open bitmap
		if destination path exists
		    0000h open fails
		    0001h file is appended
		    0002h file is overwritten
		if destination path doesn't exist
		    0000h open fails
		    0010h file is created
 12h	WORD	copy control bitmap (see #1001)
 14h	DWORD	-> copy_info buffer
 18h	WORD	length of copy_info buffer

Bitfields for LAN Manager copy control:
Bit(s)	Description	(Table 1001)
 0	destination must be a file
 1	destination must be a directory
 2	destination is opened in ascii mode instead of binary
 3	source is opened in ascii mode instead of binary
 4	verify all write operations
--------N-215F4B-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetRemoteMove
	AX = 5F4Bh
	DS:DX -> NetRemoteMove parameter structure (see #1002)
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F4Ah

Format of LAN Manager NetRemoteMove parameter structure:
Offset	Size	Description	(Table 1002)
 00h	DWORD	-> source name as UNC
 04h	DWORD	-> destination name as UNC
 08h	DWORD	-> source password
 0Ch	DWORD	-> destination password
 10h	WORD	destination open bitmap
		if destination path exists
		    0000h open fails
		    0001h file is appended
		    0002h file is overwritten
		if destination path doesn't exist
		    0000h open fails
		    0010h file is created
 12h	WORD	move control bitmap
		    0001h destination must be a file
		    0002h destination must be a directory
 14h	DWORD	-> move_info buffer
 18h	WORD	length of move_info buffer
--------N-215F4C-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetServerEnum
	AX = 5F4Ch
	BX = level (0000h or 0001h)
	CX = buffer length
	ES:DI -> buffer in which to store information
Return: CF clear if successful
	    ES:DI -> server_info_X structures (depending on level)
		  (see #1003,#1004)
	    BX = entries read
	    CX = total entries available
	CF set on error
	    AX = error code
Notes:	this function is also supported by the Novell DOS Named Pipe Extender
	this function has been obseleted by NetServerEnum2
SeeAlso: AX=5F53h

Format of LAN Manager server_info_0 structure:
Offset	Size	Description	(Table 1003)
 00h 16 BYTEs	name
SeeAlso: #1004

Format of LAN Manager server_info_1 structure:
Offset	Size	Description	(Table 1004)
 00h 16 BYTEs	name
 10h	BYTE	major version in lower nibble
 11h	BYTE	minor version
 12h	DWORD	server type bitmask (see #1005)
 16h	DWORD	-> comment string
SeeAlso: #1003

Bitfields for LAN Manager server type:
Bit(s)	Description	(Table 1005)
 0	workstation
 1	server
 2	SQL server
 3	primary domain controller
 4	backup domain controller
 5	time server
 6	Apple File Protocol (AFP) server
 7	Novell server
 8	Domain Member (v2.1+)
 9	Print Queue server (v2.1+)
 10	Dialin server (v2.1+)
 11	Unix server (v2.1+)
--------N-215F4D-----------------------------
INT 21 u - LAN Manager Enhanced DOS - DosMakeMailslot
	AX = 5F4Dh
	BX = message size
	CX = mailslot size (must be bigger than message size by at least 1)
			   (minimum 1000h, maximum FFF6h)
			   (buffer must be 9 bytes bigger than this)
	DS:SI -> name
	ES:DI -> memory buffer
Return: CF clear if successful
	    AX = handle
	CF set on error
	    AX = error code
SeeAlso: AX=5F4Eh,AX=5F4Fh,AX=5F50h,AX=5F51h
--------N-215F4E-----------------------------
INT 21 u - LAN Manager Enhanced DOS - DosDeleteMailslot
	AX = 5F4Eh
	BX = handle
Return: CF clear if successful
	    ES:DI -> memory to be freed (allocated during DosMakeMailslot)
	CF set on error
	    AX = error code
SeeAlso: AX=5F4Dh,AX=5F4Fh
--------N-215F4F-----------------------------
INT 21 u - LAN Manager Enhanced DOS - DosMailslotInfo
	AX = 5F4Fh
	BX = handle
Return: CF clear if successful
	    AX = max message size
	    BX = mailslot size
	    CX = next message size
	    DX = next message priority
	    SI = number of messages waiting
	CF set on error
	    AX = error code
SeeAlso: AX=5F4Dh,AX=5F4Eh,AX=5F50h
--------N-215F50-----------------------------
INT 21 u - LAN Manager Enhanced DOS - DosReadMailslot
	AX = 5F50h
	BX = handle
	DX:CX = timeout
	ES:DI -> buffer
Return: CF clear if successful
	    AX = bytes read
	    CX = next item's size
	    DX = next item's priority
	CF set on error
	    AX = error code
SeeAlso: AX=5F4Dh,AX=5F4Fh,AX=5F51h,AX=5F52h
--------N-215F51-----------------------------
INT 21 u - LAN Manager Enhanced DOS - DosPeekMailslot
	AX = 5F51h
	BX = handle
	ES:DI -> buffer
Return: CF clear if successful
	    AX = bytes read
	    CX = next item's size
	    DX = next item's priority
	CF set on error
	    AX = error code
SeeAlso: AX=5F35h,AX=5F4Fh,AX=5F50h,AX=5F52h
--------N-215F52-----------------------------
INT 21 u - LAN Manager Enhanced DOS - DosWriteMailslot
	AX = 5F52h
	BX = class
	CX = length of buffer
	DX = priority
	ES:DI -> DosWriteMailslot parameter structure (see #1006)
	DS:SI -> mailslot name
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F4Fh,AX=5F50h,AX=5F51h

Format of LAN Manager DosWriteMailslot parameter structure:
Offset	Size	Description	(Table 1006)
 00h	DWORD	timeout
 04h	DWORD	-> buffer
--------N-215F53-----------------------------
INT 21 u - LAN Manager Enhanced DOS - NetServerEnum2
	AX = 5F53h
	DS:SI -> NetServerEnum2 parameter structure (see #1007)
Return: CF clear if successful
	    BX = entries read
	    CX = total entries available
	CF set on error
	    AX = error code
SeeAlso: AX=5F4Ch

Format of LAN Manager NetServerEnum2 parameter structure:
Offset	Size	Description	(Table 1007)
 00h	WORD	level (0000h or 0001h)
 02h	DWORD	-> buffer as array of server_info_??? structures (see #1009)
 06h	WORD	length of buffer
 08h	DWORD	server type bitmask (see #1008)
 0Ch	DWORD	-> Domain name (may be 0000h:0000h for all local domains)

Bitfields for LAN Manager server type:
Bit(s)	Description	(Table 1008)
 0	workstation
 1	server
 2	SQL server
 3	primary domain controller
 4	backup domain controller
 5	time server
 6	Apple File Protocol (AFP) server
 7	Novell server
 8	Domain Member (v2.1+)
 9	Print Queue server (v2.1+)
 10	Dialin server (v2.1+)
 11	Unix server (v2.1+)
Note:	set all (FFFFFFFFh) for All Types

Format of LAN Manager server_info_0 structure:
Offset	Size	Description	(Table 1009)
 00h 16 BYTEs	name
SeeAlso: #1010

Format of LAN Manager server_info_1 structure:
Offset	Size	Description	(Table 1010)
 00h 16 BYTEs	name
 10h	BYTE	major version in lower nibble
 11h	BYTE	minor version
 12h	DWORD	server type (bits 0-11) (see #1008)
 16h	DWORD	-> comment string
SeeAlso: #1009
--------N-215F55----------------------------
INT 21 U - LAN Manager Enhanced DOS - KILL ALL CONNECTIONS???
	AX = 5F55h
	BX = ???
Return: CF clear if successful
	CF set on error
	    AX = error code
--------N-215F80-----------------------------
INT 21 - LANtastic - GET LOGIN ENTRY
	AX = 5F80h
	BX = login entry index (0-based)
	ES:DI -> 16-byte buffer for machine name
Return: CF clear if successful
	    buffer filled with machine name ("\\" prefix removed)
	    DL = adapter number (v3+)
	CF set on error
	    AX = error code
Note:	the login entry index corresponds to the value BX used in AX=5F83h
SeeAlso: AX=5F83h
--------N-215F81-----------------------------
INT 21 - LANtastic - LOGIN TO SERVER
	AX = 5F81h
	ES:DI -> ASCIZ login path followed immediately by ASCIZ password
	BL = adapter number
	    FFh try all valid adapters
	    00h-07h try only specified adapter
Return: CF clear if successful
	CF set on error
	    AX = error code
Notes:	login path is of form "\\machine\username"
	if no password is used, the string at ES:DI must be terminated with
	  three NULs for compatibility with LANtastic v3.0.
SeeAlso: AX=5F82h,AX=5F84h
--------N-215F82-----------------------------
INT 21 - LANtastic - LOGOUT FROM SERVER
	AX = 5F82h
	ES:DI -> ASCIZ server name (in form "\\machine")
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F81h,AX=5F88h,AX=5FCBh
--------N-215F83-----------------------------
INT 21 - LANtastic - GET USERNAME ENTRY
	AX = 5F83h
	BX = login entry index (0-based)
	ES:DI -> 16-byte buffer for username currently logged into
Return: CF clear if successful
	    DL = adapter number (v3+)
	CF set on error
	    AX = error code
Note:	the login entry index corresponds to the value BX used in AX=5F80h
SeeAlso: AX=5F80h
--------N-215F84-----------------------------
INT 21 - LANtastic - GET INACTIVE SERVER ENTRY
	AX = 5F84h
	BX = server index not currently logged into
	ES:DI -> 16-byte buffer for server name which is available for logging
		in to ("\\" prefix omitted)
Return: CF clear if successful
	    DL = adapter number to non-logged in server is on
	CF set on error
	    AX = error code
SeeAlso: AX=5F81h
--------N-215F85-----------------------------
INT 21 - LANtastic - CHANGE PASSWORD
	AX = 5F85h
	ES:DI -> buffer containing "\\machine\oldpassword" 00h "newpassword"00h
Return: CF clear if successful
	CF set on error
	    AX = error code
Notes:	must be logged into the named machine
	this function is illegal for group accounts
--------N-215F86-----------------------------
INT 21 - LANtastic - DISABLE ACCOUNT
	AX = 5F86h
	ES:DI -> ASCIZ machine name and password in form "\\machine\password"
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	must be logged into the named machine and concurrent logins set to 1
	  by NET_MGR.  Requires system manager to re-enable account.
--------N-215F87-----------------------------
INT 21 - LANtastic v3+ - GET ACCOUNT
	AX = 5F87h
	DS:SI -> 128-byte buffer for account information (see #1011)
	ES:DI -> ASCIZ machine name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX destroyed
Note:	must be logged into the specified machine

Format of LANtastic user account structure:
Offset	Size	Description	(Table 1011)
 00h 16 BYTEs	blank-padded username (zero-padded for v4.x)
 10h 16 BYTEs	reserved (00h)
 20h 32 BYTEs	user description
 40h	BYTE	privilege bits (see #1012)
 41h	BYTE	maximum concurrent users
 42h 42 BYTEs	bit map for disallowed half hours, beginning on Sunday
		(bit set if half-hour not an allowed time)
 6Ch	WORD	internal (0002h)
 6Eh  2 WORDs	last login time
 72h  2 WORDs	account expiration date (MS-DOS-format year/month:day)
 76h  2 WORDs	password expiration date (0 = none)
 7Ah	BYTE	number of days to extend password after change (1-31)
		00h if no extension required
---v3.x---
 7Bh  5 BYTEs	reserved
---v4.x---
 7Bh	BYTE	storage for first letter of user name when deleted (first
		  character is changed to 00h when deleting account)
 7Ch	BYTE	extended privileges
 7Dh  3 BYTEs	reserved

Bitfields for LANtastic privilege bits:
Bit(s)	Description	(Table 1012)
 7	bypass access control lists
 6	bypass queue protection
 5	treat as local process
 4	bypass mail protection
 3	allow audit entry creation
 2	system manager
 0	user cannot change password
--------N-215F88-----------------------------
INT 21 - LANtastic v4.0+ - LOGOUT FROM ALL SERVERS
	AX = 5F88h
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F82h
--------N-215F97-----------------------------
INT 21 - LANtastic - COPY FILE
	AX = 5F97h
	CX:DX = number of bytes to copy (FFFFFFFFh = entire file)
	SI = source file handle
	DI = destination file handle
Return: CF clear if successful
	    DX:AX = number of bytes copied
	CF set on error
	    AX = error code
Note:	copy is performed by server
--------N-215F98-----------------------------
INT 21 - LANtastic - SEND UNSOLICITED MESSAGE
	AX = 5F98h
	DS:SI -> message buffer (see #1013)
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	v4.1- return no errors
SeeAlso: AX=5F99h

Format of LANtastic message buffer:
Offset	Size	Description	(Table 1013)
 00h	BYTE	reserved
 01h	BYTE	message type
		00h general
		01h server warning
		02h-7Fh reserved
		80h-FFh user-defined
 02h 16 BYTEs	ASCIZ destination machine name
 12h 16 BYTEs	ASCIZ server name which user must be logged into
 22h 16 BYTEs	ASCIZ user name
 32h 16 BYTEs	ASCIZ originating machine name (filled in when received)
 42h 80 BYTEs	message text
--------N-215F99-----------------------------
INT 21 - LANtastic - GET LAST RECEIVED UNSOLICITED MESSAGE
	AX = 5F99h
	ES:DI -> messsage buffer (see #1013)
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F98h
--------N-215F9A-----------------------------
INT 21 - LANtastic - GET MESSAGE PROCESSING FLAGS
	AX = 5F9Ah
Return: CF clear if successful
	    DL = bits describing processing of received messages (see #1014)
	CF set on error
	    AX = error code
SeeAlso: AX=5F9Bh,AX=5F9Ch,AX=5F9Dh

Bitfields for unsolicited message processing flags:
Bit(s)	Description	(Table 1014)
 0	beep before message is delivered
 1	deliver message to message service
 2	pop up message automatically (v3+)
--------N-215F9B-----------------------------
INT 21 - LANtastic - SET MESSAGE PROCESSING FLAGS
	AX = 5F9Bh
	DL = bits describing processing for received unsolicited messages
	     (see #1014)
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F9Ah,AX=5F9Eh
--------N-215F9C-----------------------------
INT 21 - LANtastic v3+ - POP UP LAST RECEIVED MESSAGE
	AX = 5F9Ch
	CX = time to leave on screen in clock ticks
	DH = 0-based screen line on which to place message
Return: CF clear if successful
	CF set on error
	    AX = error code (0Bh)
Notes:	the original screen contents are restored when the message is removed
	the message will not appear, and an error will be returned, if the
	  screen is in a graphics mode
SeeAlso: AX=5F9Ah
--------N-215F9D-----------------------------
INT 21 - LANtastic v4.1+ - GET REDIRECTOR CONTROL BITS
	AX = 5F9Dh
Return: DL = redirector control bits
		bit 7: set to notify on print job completion
SeeAlso: AX=5F9Ah,AX=5F9Eh
--------N-215F9E-----------------------------
INT 21 - LANtastic v4.1+ - SET REDIRECTOR CONTROL BITS
	AX = 5F9Eh
	DL = redirector control bits (see AX=5F9Dh)
Return: nothing
SeeAlso: AX=5F9Bh,AX=5F9Dh
--------N-215FA0-----------------------------
INT 21 - LANtastic - GET QUEUE ENTRY
	AX = 5FA0h
	BX = queue entry index (0000h is first entry)
	DS:SI -> buffer for queue entry (see #1015)
	ES:DI -> ASCIZ server name in form "\\name"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX = entry index for next queue entry (BX-1 is current index)
SeeAlso: AX=5FA1h,AX=5FA2h

Format of LANtastic queue entry:
Offset	Size	Description	(Table 1015)
 00h	BYTE	status of entry (see #1016)
 01h	DWORD	size of spooled file
 05h	BYTE	type of entry (see #1017)
 06h	BYTE	output control (see #1018)
 07h	WORD	number of copies
 09h	DWORD	sequence number of queue entry
 0Dh 48 BYTEs	pathname of spooled file
 3Dh 16 BYTEs	user who spooled file
 4Dh 16 BYTEs	name of machine from which file was spooled
 5Dh	WORD	date file was spooled (see #0952 at AX=5700h)
 5Fh	WORD	time file was spooled (see #0951 at AX=5700h)
 61h 17 BYTEs	ASCIZ destination device or user name
 72h 48 BYTEs	comment field

(Table 1016)
Values for status of LANtastic queue entry:
 00h	empty
 01h	being updated
 02h	being held
 03h	waiting for despool
 04h	being despooled
 05h	canceled
 06h	spooled file could not be accessed
 07h	destination could not be accessed
 08h	rush job

(Table 1017)
Values for type of LANtastic queue entry:
 00h	printer queue file
 01h	message
 02h	local file
 03h	remote file
 04h	to remote modem
 05h	batch processor file

Bitfields for output control:
Bit(s)	Description	(Table 1018)
 6	don't delete (for mail)
 5	mail file contains voice mail (v3+)
 4	mail message has been read
 3	response has been requested for this mail
--------N-215FA1-----------------------------
INT 21 - LANtastic - SET QUEUE ENTRY
	AX = 5FA1h
	BX = handle of opened queue entry
	DS:SI -> queue entry (see #1015)
Return: CF clear if successful
	CF set on error
	    AX = error code
Notes:	the only queue entry fields which may be changed are output control,
	  number of copies, destination device, and comment
	the handle in BX is that from a create or open (INT 21/AH=3Ch,3Dh)
	  call on the file "\\server\\@MAIL" or "\\server\@name" (for
	  printer queue entries)
SeeAlso: AX=5FA0h,AX=5FA2h,AX=5FA9h
--------N-215FA2-----------------------------
INT 21 - LANtastic - CONTROL QUEUE
	AX = 5FA2h
	BL = control command
	    00h start despooling (privileged)
	    01h halt despooling (privileged)
	    02h halt despooling at end of job (privileged)
	    03h pause despooler at end of job (privileged)
	    04h print single job (privileged)
	    05h restart current job (privileged)
	    06h cancel the current job
	    07h hold queue entry
	    08h release a held queue entry
	    09h make queue entry a rushed job (privileged)
	CX:DX = sequence number to control (commands 06h-09h)
	DX = physical printer number (commands 00h-05h)
	    00h-02h LPT1-LPT3
	    03h,04h COM1,COM2
	    other	all printers
	ES:DI -> ASCIZ server name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
--------N-215FA3-----------------------------
INT 21 - LANtastic v3+ - GET PRINTER STATUS
	AX = 5FA3h
	BX = physical printer number (00h-02h = LPT1-LPT3, 03h-04h = COM1-COM2)
	DS:SI -> buffer for printer status (see #1019)
	ES:DI -> ASCIZ server name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX = next physical printer number
Note:	you must be logged in to the specified server

Format of LANtastic printer status:
Offset	Size	Description	(Table 1019)
 00h	BYTE	printer state (see #1020)
 01h	WORD	queue index of print job being despooled
		FFFFh if not despooling--ignore all following fields
 03h	WORD	actual characters per second being output
 05h	DWORD	number of characters actually output so far
 09h	DWORD	number of bytes read from spooled file so far
 0Dh	WORD	copies remaining to print

Bitfields for LANtastic printer state:
Bit(s)	Description	(Table 1020)
 7	printer paused
 0-6	0 printer disabled
	1 will stop at end of job
	2 print multiple jobs
--------N-215FA4-----------------------------
INT 21 - LANtastic v3+ - GET STREAM INFO
	AX = 5FA4h
	BX = 0-based stream index number
	DS:SI -> buffer for stream information (see #1021)
	ES:DI -> ASCIZ machine name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX = next stream number
SeeAlso: AX=5FA5h

Format of LANtastic stream information:
Offset	Size	Description	(Table 1021)
 00h	BYTE	queueing of jobs for logical printer (0=disabled,other=enabled)
 01h 11 BYTEs	logical printer resource template (may contain ? wildcards)
--------N-215FA5-----------------------------
INT 21 - LANtastic v3+ - SET STREAM INFO
	AX = 5FA5h
	BX = 0-based stream index number
	DS:SI -> buffer containing stream information (see #1021)
	ES:DI -> ASCIZ machine name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5FA4h
--------N-215FA7-----------------------------
INT 21 - LANtastic - CREATE USER AUDIT ENTRY
	AX = 5FA7h
	DS:DX -> ASCIZ reason code (max 8 bytes)
	DS:SI -> ASCIZ variable reason string (max 128 bytes)
	ES:DI -> ASCIZ machine name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	you must be logged in to the specified server and have the "U"
	  privilege to execute this call
--------N-215FA9-----------------------------
INT 21 - LANtastic v4.1+ - SET EXTENDED QUEUE ENTRY
	AX = 5FA9h
	BX = handle of opened queue entry
	DS:SI -> queue entry (see #1015)
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	functions exactly the same as AX=5FA1h except the spooled filename is
	  also set.  This call supports direct despooling.
SeeAlso: AX=5FA1h
--------N-215FB0-----------------------------
INT 21 - LANtastic - GET ACTIVE USER INFORMATION
	AX = 5FB0h
	BX = server login entry index
	DS:SI -> buffer for active user entry (see #1022)
	ES:DI -> ASCIZ machine name in form "\\server"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX = next login index
SeeAlso: AX=5FB2h

Format of LANtastic active user entry:
Offset	Size	Description	(Table 1022)
 00h	WORD	virtual circuit number
 02h	BYTE	login state (see #1023)
 03h	BYTE	last command issued (see #1024)
 04h  5 BYTEs	number of I/O bytes (40-bit unsigned number)
 09h  3 BYTEs	number of server requests (24-bit unsigned)
 0Ch 16 BYTEs	name of user who is logged in
 1Ch 16 BYTEs	name of remote logged in machine
 2Ch	BYTE	extended privileges (v4+???)
		bit 0: user cannot change his password
 2Dh	WORD	time left in minutes (0000h = unlimited) (v4+???)

Bitfields for login state:
Bit(s)	Description	(Table 1023)
 0	fully logged in
 1	remote program load login
 2	user has system manager privileges
 3	user can create audit entries
 4	bypass mail protection
 5	treat as local process
 6	bypass queue protection
 7	bypass access control lists

(Table 1024)
Values for last LANtastic command:
 00h	login
 01h	process termination
 02h	open file
 03h	close file
 04h	create file
 05h	create new file
 06h	create unique file
 07h	commit data to disk
 08h	read file
 09h	write file
 0Ah	delete file
 0Bh	set file attributes
 0Ch	lock byte range
 0Dh	unlock byte range
 0Eh	create subdirectory
 0Fh	remove subdirectory
 10h	rename file
 11h	find first matching file
 12h	find next matching file
 13h	get disk free space
 14h	get a queue entry
 15h	set a queue entry
 16h	control the queue
 17h	return login information
 18h	return link description
 19h	seek on file
 1Ah	get server's time
 1Bh	create audit entry
 1Ch	open file in multitude of modes
 1Dh	change password
 1Eh	disable account
 1Fh	local server file copy
---v3+---
 20h	get username from account file
 21h	translate server's logical path
 22h	make indirect file
 23h	get indirect file contents
 24h	get physical printer status
 25h	get logical print stream info
 26h	set logical print stream info
 27h	get user's account record
---v4+---
 28h	request server shutdown
 29h	cancel server shutdown
 2Ah	stuff server's keyboard
 2Bh	write then commit data to disk
 2Ch	set extended queue entry
 2Dh	terminate user from server
 2Eh	enable/disable logins
 2Fh	flush server caches
 30h	change username
 31h	get extended queue entry
	(same as get queue, but can return named fields blanked)
--------N-215FB1-----------------------------
INT 21 - LANtastic - GET SHARED DIRECTORY INFORMATION
	AX = 5FB1h
	DS:SI -> 64-byte buffer for link description
	ES:DI -> ASCIZ machine and shared directory name in form
		 "\\machine\shared-resource"
Return: CF clear if successful
	    CX = access control list privileges for requesting user (see #1025)
	CF set on error
	    AX = error code

Bitfields for LANtastic access control list:
Bit(s)	Description	(Table 1025)
 4	(I) allow expansion of indirect files
 5	(A) allow attribute changing
 6	(P) allow physical access to device
 7	(E) allow program execution
 8	(N) allow file renaming
 9	(K) allow directory deletion
 10	(D) allow file deletion
 11	(L) allow file/directory lookups
 12	(M) allow directory creation
 13	(C) allow file creation
 14	(W) allow open for write and writing
 15	(R) allow open for read and reading
--------N-215FB2-----------------------------
INT 21 - LANtastic v3+ - GET USERNAME FROM ACCOUNT FILE
	AX = 5FB2h
	BX = username entry index (0 for first)
	DS:SI -> 16-byte buffer for username
	ES:DI -> ASCIZ server name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX = next queue entry index
SeeAlso: AX=5FB0h
--------N-215FB3-----------------------------
INT 21 - LANtastic v3+ - TRANSLATE PATH
	AX = 5FB3h
	DS:SI -> 128-byte buffer for ASCIZ result
	ES:DI -> full ASCIZ path, including server name
	DX = types of translation to be performed
	    bit 0: expand last component as indirect file
	    bit 1: return actual path relative to server's physical disk
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	always expands any indirect files along the path
SeeALso: AX=5FB4h,INT 21/AH=60h
--------N-215FB4-----------------------------
INT 21 - LANtastic v3+ - CREATE INDIRECT FILE
	AX = 5FB4h
	DS:SI -> 128-byte buffer containing ASCIZ contents of indirect file
	ES:DI -> full ASCIZ path of indirect file to create, incl machine name
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	the contents of the indirect file may be any valid server-relative path
SeeAlso: AX=5FB3h,AX=5FB5h
--------N-215FB5-----------------------------
INT 21 - LANtastic v3+ - GET INDIRECT FILE CONTENTS
	AX = 5FB5h
	DS:SI -> 128-byte buffer for ASCIZ indirect file contents
	ES:DI -> full ASCIZ path of indirect file
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5FB4h
--------N-215FB6-----------------------------
INT 21 - LANtastic v4.1+ - SET AUTO-LOGIN DEFAULTS
	AX = 5FB6h
	ES:DI -> pointer to ASCIZ default user name, immediately followed by
		ASCIZ password
	BL = adapter number to use for default login attempt
	    FFh try all valid adapters
	    00h-05h try adapter 0-5 explicitly
Return: CF clear if successful
	CF set on error
	    AX = error code
Notes:	call with ES:DI -> two nulls to disable auto-login
SeeAlso: AX=5FB7h
--------N-215FB7-----------------------------
INT 21 - LANtastic v4.1+ - GET AUTO-LOGIN DEFAULTS
	AX = 5FB7h
	ES:DI -> pointer to 16-byte buffer to store ASCIZ auto-login user name
Return: CF clear if successful
	    DL = adapter number used for default login attempt
		FFh all valid adapters will be tried
		00h-05h specified adapter will be tried explicitly
	CF set on error
	    AX = error code
SeeAlso: AX=5F81h,AX=5FB6h
--------N-215FC0-----------------------------
INT 21 - LANtastic - GET TIME FROM SERVER
	AX = 5FC0h
	DS:SI -> time block (see #1026)
	ES:DI -> ASCIZ server name to get time from
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AH=E7h

Format of LANtastic time block:
Offset	Size	Description	(Table 1026)
 00h	WORD	year
 02h	BYTE	day
 03h	BYTE	month
 04h	BYTE	minutes
 05h	BYTE	hour
 06h	BYTE	hundredths of second
 07h	BYTE	second
--------N-215FC8-----------------------------
INT 21 - LANtastic v4.0+ - SCHEDULE SERVER SHUTDOWN
	AX = 5FC8h
	ES:DI -> ASCIZ server name in form "\\machine"
	DS:SI -> ASCIZ reason string (80 characters)
	CX = number of minutes until shutdown (0 = immediate)
	DX = option flags (see #1027)
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5FC9h

Bitfields for LANtastic option flags:
Bit(s)	Description	(Table 1027)
 0	auto reboot
 1	do not notify users
 2	halt after shutdown
 3	shutdown due to power fail (used by UPS)
 4-7	reserved
 8-14	user definable
 15	reserved
--------N-215FC9-----------------------------
INT 21 - LANtastic v4.0+ - CANCEL SERVER SHUTDOWN
	AX = 5FC9h
	ES:DI -> ASCIZ server name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	you must have the "S" privilege to use this call
SeeAlso: AX=5FC8h
--------N-215FCA-----------------------------
INT 21 - LANtastic v4.0+ - STUFF SERVER KEYBOARD BUFFER
	AX = 5FCAh
	ES:DI -> ASCIZ server name in form "\\machine"
	DS:SI -> ASCIZ string to stuff (128 bytes)
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	you must have the "S" privilege to use this call
	maximum number of characters that can be stuffed is determined by the
	  server's RUN BUFFER SIZE.
SeeAlso: INT 16/AH=05h
--------N-215FCB-----------------------------
INT 21 - LANtastic v4.1+ - TERMINATE USER
	AX = 5FCBh
	ES:DI -> ASCIZ server name in form "\\machine"
	DS:SI -> blank-padded username.	 A null char = wildcard.
	DS:DX -> blank-padded machine name.  A null char = wildcard.
	CX = minutes until termination (0 = immediate)
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	you must have the "S" privilege to use this call
	you cannot log yourself out using this call
SeeAlso: AX=5F82h
--------N-215FCC-----------------------------
INT 21 - LANtastic v4.1+ - GET/SET SERVER CONTROL BITS
	AX = 5FCCh
	ES:DI -> ASCIZ server name in form "\\machine"
	CX = bit values (value of bits you want to set) (see #1028)
	DX = bit mask (bits you are interested in, 0 = get only) (see #1028)
Return: CF clear if successful
	    CX = control bits after call (see #1028)
	CF set on error
	    AX = error code
Note:	you must have the "S" privilege to SET, anyone can GET.

Bitfields for control bits:
Bit(s)	Description	(Table 1028)
 0	disable logins
--------N-215FCD-----------------------------
INT 21 - LANtastic v4.1+ - FLUSH SERVER CACHES
	AX = 5FCDh
	ES:DI -> ASCIZ server name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	you must have the "S" privilege to use this call.
--------N-215FD0-----------------------------
INT 21 - LANtastic - GET REDIRECTED PRINTER TIMEOUT
	AX = 5FD0h
Return: CF clear if successful
	    CX = redirected printer timeout in clock ticks of 55ms
		0000h if timeout disabled
	CF set on error
	    AX = error code
SeeAlso: AX=5FD1h
--------N-215FD1-----------------------------
INT 21 - LANtastic - SET REDIRECTED PRINTER TIMEOUT
	AX = 5FD1h
	CX = printer timeout in clock ticks of 55ms, 0000h to disable timeouts
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5FD0h
--------N-215FE0-----------------------------
INT 21 C - LANtastic - GET DOS SERVICE VECTOR
	AX = 5FE0h
Return: CF clear if successful
	    ES:BX -> current FAR service routine
	CF set on error
	    AX = error code
Note:	the service routine is called by the LANtastic redirector whenever DOS
	  may safely be called, permitting external TSRs and drivers to hook
	  into LANtastic's DOS busy flag checking
SeeAlso: AX=5FE1h,INT 28,INT 2A/AH=84h
--------N-215FE1-----------------------------
INT 21 - LANtastic - SET DOS SERVICE VECTOR
	AX = 5FE1h
	ES:BX -> FAR routine to call when DOS services are available
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	new handler must chain to previous handler as its first action
SeeAlso: AX=5FE0h
--------N-215FE2-----------------------------
INT 21 - LANtastic - GET MESSAGE SERVICE VECTOR
	AX = 5FE2h
Return: CF clear if successful
	    ES:BX -> current FAR message service routine
	CF set on error
	    AX = error code
SeeAlso: AX=5FE0h,AX=5FE3h
--------N-215FE3-----------------------------
INT 21 - LANtastic - SET MESSAGE SERVICE VECTOR
	AX = 5FE3h
	ES:BX -> FAR routine for processing network messages
Return: CF clear if successful
	CF set on error
	    AX = error code
Notes:	handler must chain to previous handler as its first action
	on invocation, ES:BX -> just-received message
SeeAlso: AX=5FE2h
--------D-2160-------------------------------
INT 21 - DOS 3.0+ - "TRUENAME" - CANONICALIZE FILENAME OR PATH
	AH = 60h
	DS:SI -> ASCIZ filename or path
	ES:DI -> 128-byte buffer for canonicalized name
Return: CF set on error
	    AX = error code
		02h invalid component in directory path or drive letter only
		03h malformed path or invalid drive letter
	    ES:DI buffer unchanged
	CF clear if successful
	    AH = 00h
	    AL = destroyed (00h or 5Ch or last char of current dir on drive)
	    buffer filled with qualified name of form D:\PATH\FILE.EXT or
	      \\MACHINE\PATH\FILE.EXT
Desc:	determine the canonical name of the specified filename or path,
	  corresponding to the undocumented TRUENAME command in COMMAND.COM
Notes:	the input path need not actually exist
	letters are uppercased, forward slashes converted to backslashes,
	  asterisks converted to appropriate number of question marks, and
	  file and directory names are truncated to 8.3 if necessary.  (DR DOS
	  3.41 and 5.0 do not expand asterisks)
	'.' and '..' in the path are resolved
	filespecs on local drives always start with "d:", those on network
	  drives always start with "\\"
	if path string is on a JOINed drive, the returned name is the one that
	  would be needed if the drive were not JOINed; similarly for a
	  SUBSTed, ASSIGNed, or network drive letter.	Because of this, it is
	  possible to get a qualified name that is not legal under the current
	  combination of SUBSTs, ASSIGNs, JOINs, and network redirections
	under DOS 3.3 through 6.00, a device name is translated differently if
	  the device name does not have an explicit directory or the directory
	  is \DEV (relative directory DEV from the root directory works
	  correctly).  In these cases, the returned string consists of the
	  unchanged device name and extension appended to the string X:/
	  (forward slash instead of backward slash as in all other cases) where
	  X is the default or explicit drive letter.
	under MS-DOS 7.0, this call returns the short name for any
	  long-filename portions of the provided pathname or filename
	functions which take pathnames require canonical paths if invoked via
	  INT 21/AX=5D00h
	supported by OS/2 v1.1 compatibility box
	NetWare 2.1x does not support characters with the high bit set; early
	  versions of NetWare 386 support such characters except in this call.
	  In addition, NetWare returns error code 3 for the path "X:\"; one
	  should use "X:\." instead.
	Novell DOS 7 reportedly has difficulty with non-MS-DOS filenames on
	  network drives, and can return "D:" instead of "SERVER/VOLUME"
	for DOS 3.3-6.0, the input and output buffers may be the same, as the
	  canonicalized name is built in an internal buffer and copied to the
	  specified output buffer as the very last step
	for DR DOS 6.0, this function is not automatically called when on a
	  network.  Device drivers reportedly cannot make this call from their
	  INIT function.  Using the same pointer for both input and output
	  buffers is not supported in the April 1992 and earlier versions of
	  DR DOS
	Corel's CORELCDX and MSCDEX without the /S switch return canonical
	  names of the form "\\D.\A.\path", where "D" is the CD-ROM drive
	  letter and "A" appears to indicate the first physical CD-ROM drive;
	  MSCDEX with the /S switch returns a canonical name with embedded
	  blanks.  Novell DOS 7 NWCDEX as of the 11/16/94 update returns the
	  same canonical path as MSCDEX; earlier revisions returned
	  "Cdex.D:\path", where "D" is the CD-ROM drive letter
SeeAlso: AX=5FB3h,AX=7160h/CX=0000h,INT 2F/AX=1123h,INT 2F/AX=1221h
--------D-2161-------------------------------
INT 21 - DOS 3.0+ - UNUSED (RESERVED FOR NETWORK USE)
	AH = 61h
Return: AL = 00h
Note:	this function does nothing and returns immediately
--------O-2161--BP6467-----------------------
INT 21 U - OS/2 v1.x FAPI - OS/2 FILE SYSTEM JOIN/SUBST
	AH = 61h
	BP = 6467h ("dg")
	AL = function
	    00h list
	    01h add
	    02h delete
	BX = drive number
	CX = size of buffer
	SI = type (0002h JOIN, 0003h SUBST)
	ES:DI -> buffer
Return: ???
Notes:	used by JOIN and SUBST to communicate with the OS/2 file system
	also supported by OS/2 v2.0+ Virtual DOS Machines
--------D-2162-------------------------------
INT 21 - DOS 3.0+ - GET CURRENT PSP ADDRESS
	AH = 62h
Return: BX = segment of PSP for current process
Notes:	this function does not use any of the DOS-internal stacks and may
	  thus be called at any time, even during another INT 21h call
	the current PSP is not necessarily the caller's PSP
	identical to the undocumented AH=51h
SeeAlso: AH=50h,AH=51h
--------D-216300-----------------------------
INT 21 - DOS 2.25 only - GET LEAD BYTE TABLE ADDRESS
	AX = 6300h
Return: CF clear if successful
	    DS:SI -> lead byte table (see #1029)
	CF set on error
	    AX = error code (01h) (see #0960 at AH=59h)
Notes:	does not preserve any registers other than SS:SP
	the US version of MS-DOS 3.30 treats this as an unused function,
	  setting AL=00h and returning immediately
SeeAlso: AX=6301h,AH=07h,AH=08h,AH=0Bh

Format of double-byte character set lead byte table entry:
Offset	Size	Description	(Table 1029)
 00h  2 BYTEs	low/high ends of a range of leading byte of double-byte chars
 02h  2 BYTEs	low/high ends of a range of leading byte of double-byte chars
	...
  N   2 BYTEs	00h,00h end flag
--------D-216300-----------------------------
INT 21 - Far East DOS 3.2+ - GET DOUBLE BYTE CHARACTER SET LEAD-BYTE TABLE
	AX = 6300h
Return: AL = error code
	    00h successful
		DS:SI -> DBCS table (see #1030)
		all other registers except CS:IP and SS:SP destroyed
	    FFh not supported
Notes:	probably identical to AH=63h/AL=00h for DOS 2.25
	the US version of MS-DOS 3.30 treats this as an unused function,
	  setting AL=00h and returning immediately
	the US version of DOS 4.0+ accepts this function, but returns an empty
	  list
SeeAlso: AX=6300h"DOS 2.25"

Format of DBCS table:
Offset	Size	Description	(Table 1030)
 00h  2 BYTEs	low/high ends of a range of leading byte of double-byte chars
 02h  2 BYTEs	low/high ends of a range of leading byte of double-byte chars
	...
  N   2 BYTEs	00h,00h end flag
--------D-216301-----------------------------
INT 21 - DOS 2.25, Far East DOS 3.2+ - SET KOREAN (HANGEUL) INPUT MODE
	AX = 6301h
	DL = new mode
	    00h return only full characters on DOS keyboard input functions
	    01h return partially-formed (interim) characters also
Return: AL = status
	    00h successful
	    FFh invalid mode
Note:	Novell DOS 7 simply stores DL in the caller's PSP (see #0677 at AH=26h)
SeeAlso: AH=07h,AH=08h,AH=0Bh,AH=63h,AX=6302h
--------D-216302-----------------------------
INT 21 - DOS 2.25, Far East DOS 3.2+ - GET KOREAN (HANGEUL) INPUT MODE
	AX = 6302h
Return: AL = status
	    00h successful
		DL = current input mode
		    00h return only full characters (clears interim flag)
		    01h return partial characters (sets interim flag)
	    FFh not supported
Note:	Novell DOS 7 simply reads the value out of the caller's PSP, so it
	  can return values other than 00h or 01h if the last call to AX=6301h
	  used another value
SeeAlso: AH=07h,AH=08h,AH=0Bh,AH=63h,AX=6301h
--------v-216303------------------------
INT 21 - VIRUS - "DOS IDLE" - INSTALLATION CHECK
	AX = 6303h
Return: BX = 6303h if resident
SeeAlso: AX=5643h"VIRUS",AX=6304h"VIRUS",AX=9AD5h"VIRUS"
--------v-216304------------------------
INT 21 - VIRUS - "Replicator" - INSTALLATION CHECK
	AX = 6304h
Return: BX = 6304h if resident
SeeAlso: AX=6303h"VIRUS",AX=6969h"VIRUS"
--------D-2164-------------------------------
INT 21 - DOS 3.2+ internal - SET DEVICE DRIVER LOOKAHEAD FLAG
	AH = 64h
	AL = flag
		00h (default) call device driver function 5 (non-dest read)
			before INT 21/AH=01h,08h,0Ah
	    nonzero don't call driver function 5
Return: nothing (MS-DOS)
	CF set, AX=error code??? (DR DOS 5.0, which does not support this call)
Notes:	this function is called by the DOS 3.3+ PRINT.COM
	under MS-DOS, this function does not use any of the DOS-internal stacks
	  and may thus be called at any time, even during another DOS call
SeeAlso: AH=01h,AH=08h,AH=0Ah,AX=5D06h
--------O-2164--DX0000-----------------------
INT 21 U - OS/2 v2.0+ Virtual DOS Machine - ENABLE AUTOMATIC TITLE SWITCH
	AH = 64h
	DX = 0000h (function number)
	CX = 636Ch (magic value, "cl")
	BX = 0000h (indicates special request)
Note:	if CX is not 636Ch on entry, INT 21/AH=6Ch is invoked, because a bug
	  in OS/2 1.x FAPI erroneously called AH=64h instead of AH=6Ch
SeeAlso: AH=64h/DX=0001h,INT 21/AH=4Bh
--------O-2164--DX0001-----------------------
INT 21 U - OS/2 v2.0+ Virtual DOS Machine - SET SESSION TITLE
	AH = 64h
	DX = 0001h (function number)
	CX = 636Ch (magic value, "cl")
	BX = 0000h (indicates special request)
	ES:DI -> new ASCIZ title (max 12 char) or "" to restore default title
Note:	if CX is not 636Ch on entry, INT 21/AH=6Ch is invoked, because a bug
	  in OS/2 1.x FAPI erroneously called AH=64h instead of AH=6Ch
SeeAlso: AH=64h/DX=0000h,AH=64h/DX=0002h,INT 15/AH=12h/BH=05h
--------O-2164--DX0002-----------------------
INT 21 U - OS/2 v2.0+ Virtual DOS Machine - GET SESSION TITLE
	AH = 64h
	DX = 0002h (function number)
	CX = 636Ch (magic value, "cl")
	BX = 0000h (indicates special request)
	ES:DI -> 13-byte buffer for current title
Return: buffer filled (single 00h if title never changed)
Note:	if CX is not 636Ch on entry, INT 21/AH=6Ch is invoked, because a bug
	  in OS/2 1.x FAPI erroneously called AH=64h instead of AH=6Ch
SeeAlso: AH=64h/DX=0000h,AH=64h/DX=0001h,INT 15/AH=12h/BH=05h
--------O-2164--DX0003-----------------------
INT 21 U - OS/2 v2.1 Virtual DOS Machine - GET LASTDRIVE
	AH = 64h
	DX = 0003h (function number)
	CX = 636Ch (magic value, "cl")
	BX = 0000h (indicates special request)
Return: AL = highest drive supported
Notes:	if CX is not 636Ch on entry, INT 21/AH=6Ch is invoked, because a bug
	  in OS/2 1.x FAPI erroneously called AH=64h instead of AH=6Ch
	used by WinOS2
	not supported by OS/2 Warp 3.0, check list of lists instead (see #0914)
SeeAlso: AH=52h
--------O-2164--DX0004-----------------------
INT 21 U - OS/2 v2.1+ Virtual DOS Machine - GET SIZE OF PTDA JFT
	AH = 64h
	DX = 0004h (function number)
	CX = 636Ch (magic value, "cl")
	BX = 0000h (indicates special request)
Return: AX = number of entries in OS/2 JFT for VDM
Notes:	if CX is not 636Ch on entry, INT 21/AH=6Ch is invoked, because a bug
	  in OS/2 1.x FAPI erroneously called AH=64h instead of AH=6Ch
	in an OS/2 VDM, the DOS Job File Table in the PSP contains an index
	  into the OS/2 JFT in the Per-Task Data Area rather than an SFT index
	  because the OS/2 SFT can contain more than 255 entries
--------O-2164--DX0005-----------------------
INT 21 U - OS/2 v2.1+ Virtual DOS Machine - GET SECOND SFT FLAGS WORD
	AH = 64h
	DX = 0005h (function number)
	CX = 636Ch (magic value, "cl")
	BX = 0000h (indicates special request)
	DI = DOS file handle
Return: AX = value of second flags word from OS/2 SFT entry for file
Notes:	if CX is not 636Ch on entry, INT 21/AH=6Ch is invoked, because a bug
	  in OS/2 1.x FAPI erroneously called AH=64h instead of AH=6Ch
	the OS/2 SFT has two flags words rather than DOS's one word, and this
	  function provides access to the word which is not present in DOS
--------O-2164--DX0006-----------------------
INT 21 U - OS/2 v2.1+ Virtual DOS Machine - UNLOAD DOSKRNL SYMBOLS & LOAD PROGR
	AH = 64h
	DX = 0006h (function number)
	CX = 636Ch (magic value, "cl")
	BX = 0000h (indicates special request)
	ES:DI -> ASCIZ filespec
	DS = base address for loading
Notes:	if CX is not 636Ch on entry, INT 21/AH=6Ch is invoked, because a bug
	  in OS/2 1.x FAPI erroneously called AH=64h instead of AH=6Ch
	this function is only supported by the kernel debugging version of
	  OS2KRNL
--------O-2164--DX0007-----------------------
INT 21 U - OS/2 v2.1+ Virtual DOS Machine - GET WinOS2 CALL GATE ADDRESS
	AH = 64h
	DX = 0007h (function number)
	CX = 636Ch (magic value, "cl")
	BX = 0000h (indicates special request)
Return: AX = call gate address
Notes:	if CX is not 636Ch on entry, INT 21/AH=6Ch is invoked, because a bug
	  in OS/2 1.x FAPI erroneously called AH=64h instead of AH=6Ch
	used by WinOS2 to make direct calls to OS2KRNL, bypassing the overhead
	  of DOSKRNL
--------O-2164--DX0008-----------------------
INT 21 U - OS/2 v2.1+ Virtual DOS Machine - GET LOADING MESSAGE
	AH = 64h
	DX = 0008h (function number)
	CX = 636Ch (magic value, "cl")
	BX = 0000h (indicates special request)
Return: DS:DX -> '$'-terminated message "Loading.  Please wait."
Notes:	if CX is not 636Ch on entry, INT 21/AH=6Ch is invoked, because a bug
	  in OS/2 1.x FAPI erroneously called AH=64h instead of AH=6Ch
	this function permits National Language Support for the initial message
	  displayed while WinOS2 starts a full-screen session
--------O-2164--CX636C-----------------------
INT 21 U - OS/2 v2.1+ Virtual DOS Machine - OS/2 API support
	AH = 64h
	CX = 636Ch ("cl")
	BX = API ordinal (see #1031)
	other registers as appropriate for API call
Return: as appropriate for API call
SeeAlso: AH=64h/BX=0025h,AH=64h/BX=00B6h,AH=64h/BX=00CBh

(Table 1031)
Values for OS/2 API ordinal:
 0025h	DOS32StartSession
 0082h	DosGetCP
 00B6h	DosQFSAttach
 00BFh	DosEditName
 00CBh	DosForceDelete
 0144h	Dos32CreateEventSem
 0145h	Dos32OpenEvenSem
 0146h	Dos32CloseEventSem
 0147h	Dos32ResetEventSem
 0148h	Dos32PostEventSem
 0149h	Dos32WaitEventSem
 014Ah	Dos32QueryEventSem
 014Bh	Dos32CreateMutexSem
 014Ch	Dos32OpenMutexSem
 014Dh	Dos32CloseMutexSem
 014Eh	Dos32RequestMutexSem
 014Fh	Dos32ReleaseMutexSem
 0150h	Dos32QueryMutexSem
 0151h	Dos32CreateMuxWaitSem
 0152h	Dos32OpenMuxWaitSem
 0153h	Dos32CloseMuxWaitSem
 0154h	Dos32WaitMuxWaitSem
 0155h	Dos32AddMuxWaitSem
 0156h	Dos32DeleteMuxWaitSem
 0157h	Dos32QueryMuxWaitSem
--------O-2164--BX0025-----------------------
INT 21 U - OS/2 v2.1+ Virtual DOS Machine - OS/2 API DOS32StartSession
	AH = 64h
	BX = 0025h (API ordinal)
	CX = 636Ch ("cl")
	DS:SI -> STARTDATA structure (see #1032)
Return: AX = return code
SeeAlso: AH=64h/CX=636Ch,AH=64h/BX=00B6h

Format of OS/2 Virtual DOS Machine STARTDATA structure:
Offset	Size	Description	(Table 1032)
 00h	WORD	length of structure (must be 0018h,001Eh,0020h,0032h,or 003Ch)
 02h	WORD	relation of new process to caller (00h independent, 01h child)
 04h	WORD	fore/background (00h foreground, 01h background)
 06h	WORD	trace options (00h-02h, 00h = no trace)
 08h	DWORD	pointer to ASCIZ program title (max 62 chars) or 0000h:0000h
 0Ch	DWORD	pointer to ASCIZ program name (max 128 chars) or 0000h:0000h
 10h	DWORD	pointer to ASCIZ program args (max 144 chars) or 0000h:0000h
 14h	DWORD	"TermQ" (currently reserved, must be 00000000h)
 18h	DWORD	pointer to environment (max 486 bytes) or 0000h:0000h
 1Ch	WORD	inheritance (00h or 01h)
 1Eh	WORD	session type
		00h OS/2 session manager determines type (default)
		01h OS/2 full-screen
		02h OS/2 window
		03h PM
		04h VDM full-screen
		07h VDM window
 20h	DWORD	pointer to ASCIZ icon filename (max 128 chars) or 0000h:0000h
 24h	DWORD	"PgmHandle" (currently reserved, must be 00000000h)
 28h	WORD	"PgmControl"
 2Ah	WORD	initial column
 2Ch	WORD	initial row
 2Eh	WORD	initial width
 30h	WORD	initial height
 32h	WORD	reserved (0)
 34h	DWORD	"ObjectBuffer" (currently reserved, must be 00000000h)
 38h	DWORD	"ObjectBufferLen" (currently reserved, must be 00000000h)
--------O-2164--BX00B6-----------------------
INT 21 U - OS/2 v2.1+ Virtual DOS Machine - OS/2 API DosQFSAttach
	AH = 64h
	BX = 00B6h (API ordinal)
	CX = 636Ch (magic value "cl")
	DS = user's data segment
	ES:DI -> FSQAttachStruc (see #1033)
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
	    AX = 0000h
	    data buffer filled
SeeAlso: AH=64h/CX=636Ch

Format of OS/2 Virtual DOS Machine FSQAttachStruc:
Offset	Size	Description	(Table 1033)
 00h	DWORD	reserved
 04h	DWORD	pointer to the offset of the data buffer length
 08h	DWORD	pointer to the offset of the data buffer
 0Ch	WORD	FSA Info level
 0Eh	WORD	ordinal index into table
 10h	DWORD	pointer to the offset of the device name
Notes:	The segment value of the buffer, buffer length, and device
	  name MUST all be the same.  It is defined on entry in the DS
	  register.  The details of each info level are defined in the
	  OS/2 CP Reference.
--------O-2164--BX00CB-----------------------
INT 21 U - OS/2 v2.1+ Virtual DOS Machine - OS/2 API DosForceDelete
	AH = 64h
	BX = 00CBh (API ordinal)
	CX = 636Ch (magic value "cl")
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (02h,03h,05h) (see #0960 at AH=59h)
Desc:	delete a file without saving it to the undelete directory
SeeAlso: AH=41h,AH=64h/CX=636Ch
--------D-2165-------------------------------
INT 21 - DOS 3.3+ - GET EXTENDED COUNTRY INFORMATION
	AH = 65h
	AL = info ID
	    01h get general internationalization info
	    02h get pointer to uppercase table
	    04h get pointer to filename uppercase table
	    05h get pointer to filename terminator table
	    06h get pointer to collating sequence table
	    07h (DOS 4.0+) get pointer to Double-Byte Character Set table
	BX = code page (FFFFh=global code page) (see #1040)
	DX = country ID (FFFFh=current country)
	ES:DI -> country information buffer (see #1034)
	CX = size of buffer (>= 5)
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
	    CX = size of country information returned
	    ES:DI -> country information
Notes:	AL=05h appears to return same info for all countries and codepages; it
	  has been documented for DOS 5+, but was undocumented in ealier
	  versions
	NLSFUNC must be installed to get info for countries other than the
	  default
	subfunctions 02h and 04h are identical under OS/2
SeeAlso: AH=38h,INT 2F/AX=1401h,INT 2F/AX=1402h,INT 2F/AX=14FEh

Format of country information:
Offset	Size	Description	(Table 1034)
 00h	BYTE	info ID
---if info ID = 01h---
 01h	WORD	size
 03h	WORD	country ID
 05h	WORD	code page (see #1040)
 07h 34 BYTEs	country-dependent info (see AH=38h)
---if info ID = 02h---
 01h	DWORD	pointer to uppercase table (see #1035)
---if info ID = 04h---
 01h	DWORD	pointer to filename uppercase table (see #1036)
---if info ID = 05h---
 01h	DWORD	pointer to filename character table (see #1037)
---if info ID = 06h---
 01h	DWORD	pointer to collating table (see #1038)
---if info ID = 07h (DOS 4.0+)---
 01h	DWORD	pointer to DBCS lead byte table (see #1039)

Format of uppercase table:
Offset	Size	Description	(Table 1035)
 00h	WORD	table size
 02h 128 BYTEs	uppercase equivalents (if any) of chars 80h to FFh

Format of filename uppercase table:
Offset	Size	Description	(Table 1036)
 00h	WORD	table size
 02h 128 BYTEs	uppercase equivalents (if any) of chars 80h to FFh

Format of filename terminator table:
Offset	Size	Description	(Table 1037)
 00h	WORD	table size (not counting this word)
 02h	BYTE	??? (01h for MS-DOS 3.30-6.00)
 03h	BYTE	lowest permissible character value for filename
 04h	BYTE	highest permissible character value for filename
 05h	BYTE	??? (00h for MS-DOS 3.30-6.00)
 06h	BYTE	first excluded character in range \ all characters in this
 07h	BYTE	last excluded character in range  / range are illegal
 08h	BYTE	??? (02h for MS-DOS 3.30-6.00)
 09h	BYTE	number of illegal (terminator) characters
 0Ah  N BYTEs	characters which terminate a filename:	."/\[]:|<>+=;,
Note:	partially documented for DOS 5+, but undocumented for earlier versions

Format of collating table:
Offset	Size	Description	(Table 1038)
 00h	WORD	table size
 02h 256 BYTEs	values used to sort characters 00h to FFh

Format of DBCS lead byte table:
Offset	Size	Description	(Table 1039)
 00h	WORD	length
 02h 2N BYTEs	start/end for N lead byte ranges
	WORD	0000h	(end of table)
--------D-2165-------------------------------
INT 21 - DOS 4.0+ - COUNTRY-DEPENDENT CHARACTER CAPITALIZATION
	AH = 65h
	AL = function
	    20h capitalize character
		DL = character to capitalize
		Return: DL = capitalized character
	    21h capitalize string
		DS:DX -> string to capitalize
		CX = length of string
	    22h capitalize ASCIZ string
		DS:DX -> ASCIZ string to capitalize
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
Note:	these calls have been documented for DOS 5+, but were undocumented in
	  DOS 4.x.
--------D-216523-----------------------------
INT 21 U - DOS 4.0+ - DETERMINE IF CHARACTER REPRESENTS YES/NO RESPONSE
	AX = 6523h
	DL = character
	DH = second character of double-byte character (if applicable)
Return: CF set on error
	CF clear if successful
	    AX = type
		00h no
		01h yes
		02h neither yes nor no
Note:	supported by Novell DOS 7, though prior to Update 14, the results
	  depended on the kernel variant rather than the COUNTRY= setting
--------D-2165-------------------------------
INT 21 U - DOS 4.0+ internal - COUNTRY-DEPENDENT FILENAME CAPITALIZATION
	AH = 65h
	AL = function
	    A0h capitalize filename character
		DL = character to capitalize
		Return: DL = capitalized character
	    A1h capitalize counted filename string
		DS:DX -> filename string to capitalize
		CX = length of string
	    A2h capitalize ASCIZ filename
		DS:DX -> ASCIZ filename to capitalize
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
Note:	nonfunctional in MS-DOS 4.00 through 6.00 due to a bug (the code sets a
	  pointer depending on the high bit of AL, but doesn't clear the
	  bit before branching by function number).  Supported and
	  functional(!) in Novell DOS 7 (Update 15)
--------D-216601-----------------------------
INT 21 - DOS 3.3+ - GET GLOBAL CODE PAGE TABLE
	AX = 6601h
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
	    BX = active code page (see #1040)
	    DX = system code page (see #1040)
SeeAlso: AX=6602h
--------D-216602-----------------------------
INT 21 - DOS 3.3+ - SET GLOBAL CODE PAGE TABLE
	AX = 6602h
	BX = active code page (see #1040)
	DX = system code page (active page at boot time)
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
	    AX = EB41h (Novell NWDOS v7.0 when NLSFUNC not installed and
		  request was for previously-active code page)
SeeAlso: AX=6601h,INT 2F/AX=14FFh

(Table 1040)
Values for code page:
 437	US
 850	Multilingual
 852	Slavic/Latin II (DOS 5+)
 857	Turkish
 860	Portugal
 861	Iceland
 863	Canada (French)
 865	Norway/Denmark
--------D-2167-------------------------------
INT 21 - DOS 3.3+ - SET HANDLE COUNT
	AH = 67h
	BX = size of new file handle table for process
Return: CF clear if successful
	CF set on error
	    AX = error code (see #0960 at AH=59h)
Desc:	adjust the size of the per-process open file table, thus raising or
	  lowering the limit on the number of files the caller can open
	  simultaneously
Notes:	if BX <= 20, no action is taken if the handle limit has not yet been
	  increased, and the table is copied back into the PSP if the limit
	  is currently > 20 handles
	for file handle tables of > 20 handles, DOS 3.30 never reuses the
	  same memory block, even if the limit is being reduced; this can lead
	  to memory fragmentation as a new block is allocated and the existing
	  one freed
	only the first 20 handles are copied to child processes in DOS 3.3-6.0
	increasing the file handles here will not, in general, increase the
	  number of files that can be opened using the runtime library of a
	  high-level language such as C
	Novell DOS 7 reportedly terminates the calling program if the JFT is
	  being reduced in size and there are any open file handles beyond
	  the portion of the JFT being retained
BUGS:	the original release of DOS 3.30 allocates a full 64K for the handle
	  table on requests for an even number of handles
	DR DOS 3.41 and 5.0 will lose track of any open file handles beyond
	  the portion of the JFT retained after the call; MS-DOS will indicate
	  error 04h if any of the JFT entries to be removed are open
SeeAlso: AH=26h,AH=86h
--------D-2168-------------------------------
INT 21 - DOS 3.3+ - "FFLUSH" - COMMIT FILE
	AH = 68h
	BX = file handle
Return: CF clear if successful
	    all data still in DOS disk buffers is written to disk immediately,
	      and the file's directory entry is updated
	CF set on error
	    AX = error code (see #0960 at AH=59h)
SeeAlso: AX=5D01h,AH=6Ah,INT 2F/AX=1107h
--------D-2169-------------------------------
INT 21 U - DOS 4.0+ internal - GET/SET DISK SERIAL NUMBER
	AH = 69h
	AL = subfunction
	    00h get serial number
	    01h set serial number
	BL = drive (0=default, 1=A, 2=B, etc)
	BH = info level (00h only for DOS; OS/2 allows other levels)
	DS:DX -> disk info (see #1041)
Return: CF set on error
	    AX = error code (see #0960 at AH=59h)
	CF clear if successful
	    AX destroyed
	    (AL = 00h) buffer filled with appropriate values from extended BPB
	    (AL = 01h) extended BPB on disk set to values from buffer
Notes:	does not generate a critical error; all errors are returned in AX
	error 0005h given if no extended BPB on disk
	does not work on network drives (error 0001h)
	buffer after first two bytes is exact copy of bytes 27h thru 3Dh of
	  extended BPB on disk
	this function is supported under Novell NetWare versions 2.0A through
	  3.11; the returned serial number is the one a DIR would display,
	  the volume label is the NetWare volume label, and the file system
	  is set to "FAT16".
	this function is not supported by Novell DOS 7 through Update 13, but
	  Personal NetWare 1.0 does support this function
	the serial number is computed from the current date and time when the
	  disk is created; the first part is the sum of the seconds/hundredths
	  and month/day, the second part is the sum of the hours/minutes and
	  year
	the volume label which is read or set is the one stored in the extended
	  BPB on disks formatted with DOS 4.0+, rather than the special root
	  directory entry used by the DIR command in COMMAND.COM (use AH=11h
	  to find that volume label)
SeeAlso: AX=440Dh

Format of disk info:
Offset	Size	Description	(Table 1041)
 00h	WORD	info level (zero)
 02h	DWORD	disk serial number (binary)
 06h 11 BYTEs	volume label or "NO NAME    " if none present
 11h  8 BYTEs	(AL=00h only) filesystem type--string "FAT12   " or "FAT16   "
--------O-2169-------------------------------
INT 21 - DR DOS 5.0 - NULL FUNCTION
	AH = 69h
Return: AL = 00h
SeeAlso: AH=18h
--------v-216969-----------------------------
INT 21 - VIRUS - "Rape-747" - INSTALLATION CHECK
	AX = 6969h
Return: AX = 0666h if resident
SeeAlso: AX=58CCh,AX=6304h"VIRUS",AH=76h"VIRUS"
--------d-2169FFDX0000-----------------------
INT 21 U - CUBIT v4.00 - GET CUBIT INT 21 HANDLER
	AX = 69FFh
	DX = 0000h
	BX = CB00h (magic value)
Return: ES:BX -> CUBITR.EXE handler for INT 21
Note:	the installation check consists of testing that the first eight bytes
	  at the returned interrupt handler are EBh 07h "CUBITR" (a short
	  jump around the signature followed by the signature); the byte
	  following the signature (i.e. ES:[BX+8]) indicates whether CUBITR
	  is active (01h) or disabled (00h)
SeeAlso: AX=69FFh/DX=CFBFh
Index:	installation check;CUBIT
--------d-2169FFDXCFBF-----------------------
INT 21 U - CUBIT v4.00 - UNINSTALL
	AX = 69FFh
	DX = CFBFh
	CX = EFCFh
	BX = CB00h (magic value)
Return: ES:BX -> CUBITR.EXE handler for INT 21
	CX = status
	    2020h successful
	    2222h failed
Note:	if DX is neither 0000h nor CFBFh on entry, some other code is executed
SeeAlso: AX=69FFh/DX=0000h
--------D-216A-------------------------------
INT 21 U - DOS 4.0+ - COMMIT FILE
	AH = 6Ah
	BX = file handle
Return: CF clear if successful
	    AH = 68h
	CF set on error
	    AX = error code (06h) (see #0960 at AH=59h)
Note:	identical to AH=68h in DOS 5.0-6.0; not known whether this is the case
	  in DOS 4.x
SeeAlso: AH=68h
--------D-216B-------------------------------
INT 21 U - DOS 4.0 internal - IFS IOCTL
	AH = 6Bh
	AL = subfunction
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
Return: CF set on error
	    AX = error code (see #0960 at INT 21/AH=59h)
	CF clear if successful
Note:	passed through to INT 2F/AX=112Fh with AX on top of stack
SeeAlso: AH=6Bh"DOS 5",INT 2F/AX=112Fh
--------D-216B-------------------------------
INT 21 U - DOS 5+ - NULL FUNCTION
	AH = 6Bh
Return: AL = 00h
Note:	this function does nothing and returns immediately
SeeAlso: AH=6Bh"DOS 4"
--------D-216C00-----------------------------
INT 21 - DOS 4.0+ - EXTENDED OPEN/CREATE
	AX = 6C00h
	BL = open mode as in AL for normal open (see also AH=3Dh)
	    bit 7: inheritance
	    bits 4-6: sharing mode
	    bit 3 reserved
	    bits 0-2: access mode
	BH = flags
	    bit 6 = auto commit on every write (see also AH=68h)
	    bit 5 = return error rather than doing INT 24h
	CX = create attribute (see #1043)
	DL = action if file exists/does not exist (see #1044)
	DH = 00h (reserved)
	DS:SI -> ASCIZ file name
Return: CF set on error
	   AX = error code (see #0960 at AH=59h)
	CF clear if successful
	   AX = file handle
	   CX = status (see #1042)
Notes:	the PC LAN Program only supports DL=01h, DL=10h/sharing=compatibility,
	  and DL=12h
	DR DOS reportedly does not support this function and does not return
	  an "invalid function call" error when this function is used.
	the documented bits of BX are stored in the SFT when the file is opened
	  (see #0928,#0929)
BUG:	this function has bugs (at least in DOS 5.0 and 6.2) when used with
	  drives handled via the network redirector (INT 2F/AX=112Eh):
	    - CX (attribute) is not passed to the redirector if DL=11h,
	    - CX does not return the status, it is returned unchanged because
	      DOS does a PUSH CX/POP CX when calling the redirector.
SeeAlso: AH=3Ch,AH=3Dh,AX=6C01h,AH=71h,INT 2F/AX=112Eh

(Table 1042)
Values for extended open function status:
 01h	file opened
 02h	file created
 03h	file replaced

Bitfields for file create attribute:
Bit(s)	Description	(Table 1043)
 6-15	reserved
 5	archive
 4	reserved
 3	volume label
 2	system
 1	hidden
 0	readonly

Bitfields for action:
Bit(s)	Description	(Table 1044)
 7-4	action if file does not exist
	0000 fail
	0001 create
 3-0	action if file exists
	0000 fail
	0001 open
	0010 replace/open
--------O-216C01-----------------------------
INT 21 U - OS/2 v2.0 - "DosOpen2"
	AX = 6C01h
	BL = open mode as in AL for normal open (see also AH=3Dh)
	    bit 7: inheritance
	    bits 4-6: sharing mode
	    bit 3 reserved
	    bits 0-2: access mode
	BH = flags
	    bit 6 = auto commit on every write (see also AH=68h)
	    bit 5 = return error rather than doing INT 24h
	CX = create attribute (see #1043)
	DL = action if file exists/does not exist (see #1044)
	DH = 00h (reserved)
	DS:SI -> ASCIZ file name
	ES:DI -> EAOP structure
Return: CF set on error
	   AX = error code (see #0960 at AH=59h)
	CF clear if successful
	   AX = file handle
	   CX = status (see #1042)
Note:	this function is virtually identical to AX=6C00h, but supports OS/2's
	  extended attributes
SeeAlso: AX=5704h,AX=6C00h,AH=6Fh"OS/2"
--------D-216D-------------------------------
INT 21 U - DOS 5+ ROM - FIND FIRST ROM PROGRAM
	AH = 6Dh
	DS:DX -> ASCIZ program name (may contain wildcrds)
Return: CF clear if found
	    [DTA] = ROM search structure (see #1045)
	CF set if not found
	    AX = error code
		0002h name not found in ROM
		0003h name contains colon or backslash
Notes:	the '*' wildcard matches all remaining characters in a ROM program's
	  name; any following characters in the search mask are ignored up to
	  another asterisk, which must be matched by an asterisk in the
	  found program's name.
	the search mask and program names may contain multiple periods
SeeAlso: AH=1Ah,AH=4Eh,AH=6Eh,AX=6F00h,AX=6F02h

Format of ROM search structure:
Offset	Size	Description	(Table 1045)
 00h 13 BYTEs	ASCIZ name of found ROM program
 0Dh	DWORD	address at which to resume search (do not modify)
 11h	var	ASCIZ search mask passed in (do not modify)
--------O-216D-------------------------------
INT 21 U - OS/2 v1.x FAPI - "DosMkDir2"
	AH = 6Dh
	???
Return: ???
Note:	also supported by OS/2 v2.0+ Virtual DOS Machines
SeeAlso: AH=39h
--------O-216D-------------------------------
INT 21 U - Novell DOS 7 - NOP
	AH = 6Dh
Return: AX = 0000h
Note:	this function invokes the same code as other NOP functions such as
	  AH=18h and AH=61h
--------D-216E-------------------------------
INT 21 U - DOS 5+ ROM - FIND NEXT ROM PROGRAM
	AH = 6Eh
	[DTA] = result of previous FindFirst ROM (see AH=6Dh)
Return: CF clear if found
	    [DTA] = updated ROM search structure (see #1045)
	CF set if not found
	    AX = 0012h (no more matches)
SeeAlso: AH=4Fh,AH=6Dh
--------O-216E-------------------------------
INT 21 U - OS/2 v1.x FAPI - "DosENumAttrib"
	AH = 6Eh
	???
Return: ???
Note:	also supported by OS/2 v2.0+ Virtual DOS Machines
SeeAlso: AX=5703h,AH=6Fh"OS/2",INT 2F/AX=112Dh
--------O-216F-------------------------------
INT 21 U - OS/2 v1.x FAPI - "DosQMaxEASize" - GET MAXIMUM SIZE OF EXTENDED ATTR
	AH = 6Fh
	???
Return: ???
Note:	also supported by OS/2 v2.0+ Virtual DOS Machines
SeeAlso: AX=5703h,AX=6C01h,AH=6Eh"OS/2"
--------D-216F00-----------------------------
INT 21 U - DOS 5+ ROM - GET ROM SCAN START ADDRESS
	AX = 6F00h
Return: CF clear
	AL = 00h
	BX = current ROM scan starting segment
SeeAlso: AH=6Dh,AX=6F01h,AX=6F02h
--------D-216F01-----------------------------
INT 21 U - DOS 5+ ROM - SET ROM SCAN START ADDRESS
	AX = 6F01h
	BX = new ROM scan starting address
Return: CF clear
	AL = 00h
SeeAlso: AX=6F00h,AX=6F03h
--------D-216F02-----------------------------
INT 21 U - DOS 5+ ROM - GET EXCLUSION REGION LIST
	AX = 6F02h
	ES:BX -> buffer for exclusion region list (see #1046)
Return: CF clear
	AL = 00h
	ES:BX = 0000h:0000h on error, unchanged if buffer filled
SeeAlso: AX=6F00h,AX=6F03h

Format of ROM exclusion region list:
Offset	Size	Description	(Table 1046)
 00h	WORD	number of entries
 02h 2N WORDs	start/end segments of N excluded regions
--------D-216F03-----------------------------
INT 21 U - DOS 5+ ROM - SET EXCLUSION REGION LIST
	AX = 6F03h
	DS:DX -> new exclusion region list (see #1046)
Return: CF clear
	AL = 00h
Notes:	DOS saves only the pointer and assumes that the contents of the list
	  are never changed, and that regions do not overlap
	if AL > 03h on entry, DOS returns CF set/AL=01h
SeeAlso: AX=6F01h,AX=6F02h
--------D-2170-------------------------------
INT 21 - MS-DOS 7 (Windows95) - ??? (country-specific?)
	AH = 70h
	AL = subfunction
	    00h get ??? info
		CX = buffer size (3Ah bytes needed)
		ES:DI -> buffer
	    01h set above info
	    02h set ??? info
		CX = buffer size >= 26h;
		first three bytes are skipped, the rest is copied to somewhere
		  in the DOS data segment
Return: CF clear if successful
	    ES:DI buffer filled (func 00h)
		returned was (among others) "ENU USA GR"..."AM PM M/d/yy"...
		 "dddd,MMMMdd,yyyy" in the German Preview version, and "US"
		 instead of "GR" in the US build 450 version (with German
		 country setting)
	CF set on error
	    AX = error code
		7000h if function not supported
----------217070BX6060-----------------------
INT 21 - PCW Weather Card interface - GET DATA SEGMENT
	AX = 7070h
	BX = 6060h
	CX = 7070h
	DX = 7070h
	SI = 7070h
	DI = 7070h
Return: AX = segment of data structure (see #1047)
Notes:	the data structure is at offset 516 from this segment
	the update byte is at offset 514 from this segment.  Updates are
	  once per second while this byte is nonzero and it is decremented
	  once per second.  While this byte is 0 updates are once per minute.
SeeAlso: AX=7070h/BX=7070h

Format of PCW Weather Card data structure:
Offset	Type	Description	(Table 1047)
 00h	WORD	hour
 02h	WORD	minute
 04h	WORD	second
 06h	WORD	day
 08h	WORD	month
 0Ah	WORD	year
 0Ch	WORD	???
 0Eh	WORD	relative barometric pressure (in 1/100 inches)
 10h	WORD	???
 12h	WORD	???
 14h	WORD	temperature 1 (in 1/10 degrees F)
 16h	WORD	temperature 1 lowest (in 1/10 degrees F)
 18h	WORD	temperature 1 highest (in 1/10 degrees F)
 1Ah	WORD	temperature 2 (in 1/10 degrees F)
 1Ch	WORD	temperature 2 lowest (in 1/10 degrees F)
 1Eh	WORD	temperature 2 highest (in 1/10 degrees F)
 20h	WORD	wind speed (in MPH)
 22h	WORD	average of 60 wind speed samples (in MPH)
 24h	WORD	highest wind speed (in MPH)
 26h	WORD	wind chill factor  (in 1/10 degrees F)
 28h	WORD	lowest wind chill factor (in 1/10 degrees F)
 2Ah	WORD	???
 2Ch	WORD	wind direction (in degrees)
 2Eh	WORD	accumulated daily rainfall (in 1/10 inches)
 30h	WORD	accumulated annual rainfall (in 1/10 inches)
----------217070BX7070-----------------------
INT 21 - PCW Weather Card interface - INSTALLATION CHECK
	AX = 7070h
	BX = 7070h
	CX = 7070h
	DX = 7070h
	SI = 7070h
	DI = 7070h
Return: AX = 0070h
	BX = 0070h
	CX = 0070h
	DX = 0070h
	SI = 0070h
	DI = 0070h
SeeAlso: AX=7070h/BX=6060h,AX=8080h
--------D-2171-------------------------------
INT 21 - MS-DOS 7 (Chicago) - LONG FILENAME FUNCTIONS
	AH = 71h
	AL = function
	    39h create directory
	    3Ah remove directory
	    3Bh set current directory
	    41h delete file
	    43h get file attributes (BL=00h), set file attributes (BL=01h)
	    47h get current directory
	    4Eh find first file
	    4Fh find next file
	    56h move (rename) file
	    6Ch create/open file
Return: CF set on error
	    AX = error code
		7100h if function not supported
	CF clear if successful
	    other registers as for corresponding "old" DOS function
Notes:	if error 7100h is returned, the old-style function should be called
	AX=714Eh returns a "search handle" which must be passed to AX=714Fh;
	  when the search is complete, AX=71A1h must be called to terminate
	  the search
SeeAlso: AH=39h,AH=3Ah,AH=3Bh,AH=41h,AH=43h,AH=47h,AH=4Eh,AH=4Fh,AH=56h,AH=6Ch
SeeAlso: AX=714Eh,AX=714Fh,AX=71A0h,AX=71A1h
--------D-21714ESI0000-----------------------
INT 21 - Windows95 - LONG FILENAME - FIND FIRST MATCHING FILE
	AX = 714Eh
	SI = 0000h
	CX = file attribute mask (see #0717 at AX=4301h) (bits 0 and 5 ignored)
	DS:DX -> ASCIZ filespec (both "*" and "*.*" match any filename)
	ES:DI -> FindData record (see #1048)
Return: CF clear if successful
	    AX = filefind handle (needed to continue search)
	CF set on error
	    AX = error code
		7100h if function not supported
Note:	this function is only available when IFSMgr is running, not under bare
	  MS-DOS 7
SeeAlso: AH=4Eh,AX=714Fh,AX=71A1h

Format of Windows95 long filename FindData record:
Offset	Size	Description	(Table 1048)
 00h	DWORD	file attributes
		bits 0-6 standard DOS attributes (see #0717 at INT 21/AX=4301h)
		bit 8: temporary file
 04h	QWORD	file creation time (number of 100ns intervals since 1/1/1601)
 0Ch	QWORD	last access time
 14h	QWORD	last modification time
 1Ch	DWORD	file size (high 32 bits)
 20h	DWORD	file size (low 32 bits)
 24h  8 BYTEs	reserved
 2Ch 260 BYTEs	ASCIZ full filename
130h 14 BYTEs	ASCIZ short filename (for backward compatibility)
--------D-21714FSI0000-----------------------
INT 21 - Windows95 - LONG FILENAME - FIND NEXT MATCHING FILE
	AX = 714Fh
	SI = 0000h
	BX = filefind handle (from AX=714Eh)
	ES:DI -> FindData record (see #1048)
Return: CF clear if successful
	CF set on error
	    AX = error code
		7100h if function not supported
Note:	this function is only available when IFSMgr is running, not under bare
	  MS-DOS 7
SeeAlso: AX=714Eh,AX=71A1h
--------D-217160CX0000-----------------------
INT 21 - Windows95 - LONG FILENAME - "TRUENAME" - CANONICALIZE PATH
	AX = 7160h
	CX = 0000h
	DS:SI -> ASCIZ filename or path
	ES:DI -> 261-byte buffer for canonicalized name
Return: CF set on error
	    AX = error code
		02h invalid component in directory path or drive letter only
		03h malformed path or invalid drive letter
	    ES:DI buffer unchanged
	CF clear if successful
	    ES:DI buffer filled with fully qualified name
Desc:	determine the canonical name of the specified filename or path,
	  corresponding to the undocumented TRUENAME command in COMMAND.COM
Note:	if a complete path is given, the result will be a short-form complete
	  path; otherwise, the given relative path is appended to the
	  short-form current directory name, '.'/'..'/'...'/etc. are resolved,
	  and the final result uppercased without converting any remaining
	  long-form names to short-form
SeeAlso: AH=60h,AX=7160h/CX=0001h
--------D-217160CX0001-----------------------
INT 21 - Windows95 - LONG FILENAME - GET SHORT (8.3) FILENAME FOR FILE
	AX = 7160h
	CX = 0001h
	DS:SI -> ASCIZ long filename or path
	ES:DI -> 67-byte buffer for short filename
Return: CF set on error
	    AX = error code
		02h invalid component in directory path or drive letter only
		03h malformed path or invalid drive letter
	    ES:DI buffer unchanged
	CF clear if successful
	    ES:DI buffer filled with equivalent short filename (full path,
		  even if relative path given, and all uppercase)
Note:	this call returns the short name for any long-filename portions of
	  the provided pathname or filename
SeeAlso: AH=60h,AX=7160h/CX=0000h,AX=7160h/CX=0002h
--------D-217160CX0002-----------------------
INT 21 - Windows95 - LONG FILENAME - GET CANONICAL LONG FILENAME OR PATH
	AX = 7160h
	CX = 0002h
	DS:SI -> ASCIZ short filename or path
	ES:DI -> 261-byte buffer for canonicalized long name
Return: CF set on error
	    AX = error code
		02h invalid component in directory path or drive letter only
		03h malformed path or invalid drive letter
	    ES:DI buffer unchanged
	CF clear if successful
	    ES:DI buffer filled with qualified long name (can contain
		  lowercase letters)
Desc:	determine the canonical name of the specified filename or path,
	  corresponding to the undocumented TRUENAME command in COMMAND.COM
Note:	this call returns the short name for any long-filename portions of
	  the provided pathname or filename
BUG:	even though the maximum length of a complete long pathname is 260
	  characters, Windows95 returns CF set/AX=0003h even if the file
	  exists whenever the full pathname is more than 255 characters
SeeAlso: AH=60h,AX=7160h/CX=0000h,AX=7160h/CX=0001h
--------D-2171A0-----------------------------
INT 21 - Windows95 - LONG FILENAME - GET VOLUME INFORMATION
	AX = 71A0h
	DS:SI -> ASCIZ root name (e.g. "C:\")
	ES:DI -> buffer for file system name
	CX = size of ES:DI buffer
Return: CF clear if successful
	    BX = flags (see below)
	    CX = maximum length of file name [usually 255]
	    DX = maximum length of path [usually 260]
	    ES:DI buffer filled (ASCIZ, e.g. "FAT","NTFS","CDFS")
	CF set on error
	    AX = error code
		7100h if function not supported
Note:	for the file system name buffer, 32 bytes should be sufficient; that's
	 what is used in some sample code by Walter Oney from Microsoft.
SeeAlso: AX=714Eh

Bitfields for long filename volume information flags:
Bit(s)	Description	(Table 1049)
 0	searches are case sensitive
 1	preserves case in directory entries
 2	uses Unicode characters in file and directory names
 3-13	reserved (0)
 14	supports DOS long filename functions
 15	volume is compressed
--------D-2171A1-----------------------------
INT 21 - Windows95 - LONG FILENAME - "FindClose" - TERMINATE DIRECTORY SEARCH
	AX = 71A1h
	BX = filefind handle (from AX=714Eh)
Return: CF clear if successful
	CF set on error
	   AX = error code
		7100h if function not supported
Notes:	this function must be called after starting a search with AX=714Eh,
	  to indicate that the search handle returned by that function will
	  no longer be used
	this function is only available when IFSMgr is running, not under bare
	  MS-DOS 7
SeeAlso: AH=4Eh,AX=714Eh,AX=714Fh
--------D-2172-------------------------------
INT 21 - MS-DOS 7 (Windows95) - ???
	AH = 72h
	details not available
--------D-2173-------------------------------
INT 21 - MS-DOS 7 (Windows95) - DRIVE LOCKING ???
	AH = 73h
	AL = subfunction
	    00h get ???: CL =
		00h: drive flag???
		01h: ??? flag
	    01h set ???: CL =
		00h: drive flag???
		    set to 06h if CH bit 1 =1, else to 00h
		01h: ??? flag
		    set flag bit 3 to bit 3 of CH
	DL = drive (0=current, 1=A:, etc.)
Return: CF clear if successful
	    for AL=00h:
		AL = value of CL on entry
		for CL=00h: AH = flag and 06h (i.e. bits 1 and 2 used)
		for CL=01h: AH = flag and 08h (i.e. bit 3 used)
		(flag being taken from a table of bytes)
	CF set on error
	    AX = error code
		7300h if function not supported
--------v-217575-----------------------------
INT 21 - VIRUS - "LEGO" -INSTALLATION CHECK
	AX = 7575h
Return: AX = 4321h if resident
SeeAlso: AX=6969h,AH=76h"VIRUS"
--------v-2176-------------------------------
INT 21 - VIRUS - "Klaeren"/"Hate" - INSTALLATION CHECK
	AH = 76h
Return: AL = 48h if resident
SeeAlso: AX=7575h,AX=7700h"VIRUS"
--------v-217700-----------------------------
INT 21 - VIRUS - "Growing Block" - INSTALLATION CHECK
	AX = 7700h
Return: AX = 0920h if resident
SeeAlso: AH=76h,AX=7BCEh,AH=7Fh
--------V-217734-----------------------------
INT 21 U - SCROLLit v1.7 - INSTALLATION CHECK
	AX = 7734h
Return: DX = 3477h if installed
	    AX = segment of resident code
Program: ScrollIt is a shareware backscroll utility by Bromfield Software
	  Products
--------U-217761-----------------------------
INT 21 - WATCH.COM v3.2+ - INSTALLATION CHECK
	AX = 7761h ('wa')
Return: AX = 6177h
Note:	WATCH.COM is part of the "TSR" package by TurboPower Software
SeeAlso: INT 16/AX=7761h
--------v-217BCE-----------------------------
INT 21 - VIRUS - "Whisper"/"Taipan" - INSTALLATION CHECK
	AX = 7BCEh
Return: AX = 7BCEh if resident (???)
SeeAlso: AX=5454h"VIRUS",AX=7700h,AX=7BCFh,AH=7Fh"VIRUS"
--------v-217BCF-----------------------------
INT 21 - VIRUS - "Tai-Pan.666"/"Doom II Death" - INSTALLATION CHECK
	AX = 7BCFh
Return: AX = 7BCFh if resident
SeeAlso: AX=7BCEh"VIRUS",AH=7Fh"VIRUS"
--------v-217F-------------------------------
INT 21 - VIRUS - "Squeaker" - INSTALLATION CHECK
	AH = 7Fh
Return: AH = 80h if resident
SeeAlso: AX=7BCEh,AH=83h"VIRUS"
--------D-2180-------------------------------
INT 21 - European MS-DOS 4.0 - "AEXEC" - EXECUTE PROGRAM IN BACKGROUND
	AH = 80h
	CX = mode
	    0000h place child in zombie mode on exit to preserve exit code
	    0001h discard child process and exit code on termination
	DS:DX -> ASCIZ full program name
	ES:BX -> parameter block (as for AX=4B00h)
Return: CF clear if successful
	    AX = Command Subgroup ID (CSID)
	CF set on error
	    AX = error code (see #0960 at AH=59h)
Program: European MS-DOS 4.0 was written for Siemens in Germany and then used
	  by several other European OEMs; its release falls between mainstream
	  versions 3.2 and 3.3
Desc:	asynchronously execute a program, creating a new process for it
Notes:	this function is called by the DETACH command
	there is a system-wide limit of 32 processes
	the CSID is used to identify all processes that have been spawned by
	  a given process, whether directly or indirectly
	programs to be run in the background must use the new executable format
	  (see #0883 at AH=4Bh)
	background processes may only perform asynchronous (background) EXECs,
	  either this function or AX=4B04h
	background processes may execute INT 11, INT 12, INT 21, INT 2A, and
	  INT 2F at any time; they may execute INT 10 and INT 16 only while
	  they have opened a popup screen via INT 2F/AX=1401h; no other
	  interrupts may be executed from the background
	background processes may not use drive B: or overlay their code
	  segments
	see AX=8700h for an installation check
	the "NE" new executable format made its first appearance in European
	  MS-DOS 4.0
SeeAlso: AH=4Bh,AH=87h,INT 2F/AX=1400h"POPUP"
----------218080-----------------------------
INT 21 - PCW Weather Card interface - UNINSTALL PCW.COM AND FREE MEMORY
	AX = 8080h
Return: ???
SeeAlso: AX=7070h/BX=7070h
--------D-2181-------------------------------
INT 21 - European MS-DOS 4.0 - "FREEZE" - STOP A PROCESS
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
--------D-2182-------------------------------
INT 21 - European MS-DOS 4.0 - "RESUME" - RESTART A PROCESS
	AH = 82h
	BX = flag (00h resume command subtree, 01h only specified process)
	CX = Process ID of head of command subtree
Return: CF clear if successful
	CF set on error
	    AX = error code (no such process)
Desc:	restart a previously-suspended process or a process and all of its
	  children
SeeAlso: AH=81h,INT 15/AX=101Eh
--------D-2183-------------------------------
INT 21 - European MS-DOS 4.0 - "PARTITION" - GET/SET FOREGROUND PARTITION SIZE
	AH = 83h
	AL = function
	    00h get size
	    01h set new size
		BX = new size in paragraphs
Return: CF clear if successful
	    BX = current size (function 00h) or old size (function 01h)
	CF set on error
	    AX = error code (01h,07h,0Dh)(see #0960 at AH=59h)
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
--------v-2183-------------------------------
INT 21 - VIRUS - "SVC" - INSTALLATION CHECK
	AH = 83h
Return: DX = 1990h if resident
SeeAlso: AH=76h,AH=84h"VIRUS"
--------v-2184-------------------------------
INT 21 - VIRUS - "SVC 5.0" or "SVC 6.0" - INSTALLATION CHECK
	AH = 84h
Return: DX = 1990h if resident
	    BH = version number (major in high nybble, minor in low)
SeeAlso: AH=83h"VIRUS",AH=89h"VIRUS"
--------D-218400-----------------------------
INT 21 - European MS-DOS 4.0 - "CREATMEM" - CREATE A SHARED MEMORY AREA
	AX = 8400h
	BX = size in bytes (0000h = 65536)
	CX = flags
	    bit 6: zero-initialize segment
	DS:DX -> ASCIZ name (must begin with "\SHAREMEM\")
Return: CF clear if successful
	    AX = segment address of shared memory global object
	CF set on error
	    AX = error code (06h,08h) (see #0960 at AH=59h)
Desc:	create an area of memory which may be accessed by multiple processes
Notes:	shared memory objects are created as special files (thus the
	  restriction on the name)
	on successful creation, the reference count is set to 1
SeeAlso: AX=8401h,AX=8402h,INT 15/AX=DE19h
--------D-218401-----------------------------
INT 21 - European MS-DOS 4.0 - "GETMEM" - OBTAIN ACCESS TO SHARED MEMORY AREA
	AX = 8401h
	CX = flags
	    bit 7: writable segment (ignored by MS-DOS 4.0)
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
--------D-218402-----------------------------
INT 21 - European MS-DOS 4.0 - "RELEASEMEM" - FREE SHARED MEMORY AREA
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
--------D-2185-------------------------------
INT 21 U - European MS-DOS 4.0 - ???
	AH = 85h
	???
Return: ???
--------D-2186-------------------------------
INT 21 - European MS-DOS 4.0 - "SETFILETABLE" - INSTALL NEW FILE HANDLE TABLE
	AH = 86h
	BX = total number of file handles in new table
Return: CF clear if successful
	CF set on error
	    AX = error code (06h,08h) (see #0960 at AH=59h)
Desc:	adjust the size of the per-process open file table, thus raising or
	  lowering the limit on the number of files the caller can open
	  simultaneously
Notes:	any currently-open files are copied to the new table
	if the table is increased beyond the default 20 handles, only the
	  first 20 will be inherited by child processes
	error 06h is returned if the requested number of handles exceeds
	  system limits or would require closing currently-open files
SeeAlso: AH=26h,AH=67h
--------D-2187-------------------------------
INT 21 - European MS-DOS 4.0 - "GETPID" - GET PROCESS IDENTIFIER
	AH = 87h
Return: AX = PID
	BX = parent process's PID
	CX = Command Subgroup ID (CSID)
Program: European MS-DOS 4.0 was written for Siemens in Germany and then used
	  by several other European OEMs; its release falls between mainstream
	  versions 3.2 and 3.3
Desc:	determine an identifier by which to access the calling process
Notes:	called by MS C v5.1 getpid() function
	this function apparently must return AX=0001h for INT 21/AH=80h to
	  succeed
	one possible check for European MS-DOS 4.0 is to issue this call with
	  AL=00h and check whether AL is nonzero on return
SeeAlso: AH=30h,AH=62h,AH=80h
Index:	installation check;European MS-DOS 4.0
--------D-2188-------------------------------
INT 21 U - European MS-DOS 4.0 - ???
	AH = 88h
	???
Return: ???
SeeAlso: AH=87h
--------D-2189-------------------------------
INT 21 - European MS-DOS 4.0 - SLEEP
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
--------v-2189-------------------------------
INT 21 - VIRUS - "Vriest" - INSTALLATION CHECK
	AH = 89h
Return: AX = 0123h if resident
SeeAlso: AH=84h"VIRUS",AH=90h"VIRUS"
--------D-218A-------------------------------
INT 21 - European MS-DOS 4.0 - "CWAIT" - WAIT FOR CHILD TO TERMINATE
	AH = 8Ah
	BL = range (00h command subtree, 01h any child)
	BH = suspend flag
	    00h suspend if children exist but none are dead
	    01h return if no dead children
	CX = Process ID of head of command subtree
Return: CF clear if successful
	    AH = termination type (see #1050)
	    AL = return code from child or aborting signal
	    BX = PID of child (0000h if no dead children)
	CF set on error
	    AX = error code (no child,interrupted system call)
Desc:	get return code from an asynchronously-executed child program,
	  optionally waiting if no return code is available
SeeAlso: AH=4Bh,AH=4Dh,AH=80h,AH=8Dh

(Table 1050)
Values for termination type:
 00h	normal termination
 01h	aborted by Control-C
 02h	aborted by I/O error
 03h	terminate and stay resident
 04h	aborted by signal
 05h	aborted by program error
--------D-218B-------------------------------
INT 21 U - European MS-DOS 4.0 - ???
	AH = 8Bh
	???
Return: ???
SeeAlso: AH=87h
--------D-218C-------------------------------
INT 21 - European MS-DOS 4.0 - SET SIGNAL HANDLER
	AH = 8Ch
	AL = signal number (see #1051)
	BL = action (see #1052)
	DS:DX -> signal handler (see #1053)
Return: CF clear if successful
	    AL = previous action
	    ES:BX -> previous signal handler
	CF set on error
	    AX = error code (01h,invalid SigNumber or Action)
		  (see #0960 at AH=59h)
Desc:	set the routine which will be invoked on a number of exceptional
	  conditions
Note:	all signals will be sent to the most recently installed handler
SeeAlso: AH=8Dh

(Table 1051)
Values for European MS-DOS 4.0 signal number:
 01h	SIGINTR		Control-C or user defined interrupt key
 08h	SIGTERM		program termination
 09h	SIGPIPE		broken pipe
 0Dh	SIGUSER1	reserved for user definition
 0Eh	SIGUSER2	reserved for user definition

(Table 1052)
Values for signal action:
 00h	SIG_DFL		terminate process on receipt
 01h	SIG_IGN		ignore signal
 02h	SIG_GET		signal is accepted
 03h	SIG_ERR		sender gets error
 04h	SIG_ACK		acknowledge received signal and clear it, but don't
			  change current setting

(Table 1053)
Values signal handler is called with:
	AL = signal number (see #1051)
	AH = signal argument
Return: RETF, CF set: terminate process
	RETF, CF clear, ZF set: abort any interrupted system call with an error
	RETF, CF clear, ZF clear: restart any interrupted system call
	IRET: restart any interrupted system call
Note:	the signal handler may also perform a nonlocal GOTO by resetting the
	  stack pointer and jumping; before doing so, it should dismiss the
	  signal by calling this function with BL=04h
--------D-218D-------------------------------
INT 21 - European MS-DOS 4.0 - SEND SIGNAL
	AH = 8Dh
	AL = signal number (see #1051)
	BH = signal argument
	BL = action
	    00h send to entire command subtree
	    01h send only to specified process
	DX = Process ID
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,06h)(see #0960 at AH=59h)
Desc:	invoke the exceptional-condition handler for the specified process
Note:	error 06h may be returned if one or more of the affected processes
	  have an error handler for the signal
SeeAlso: AH=8Ch
--------D-218E00BH00-------------------------
INT 21 - European MS-DOS 4.0 - "SETPRI" - GET/SET PROCESS PRIORITY
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
	    AX = error code (01h,no such process)(see #0960 at AH=59h)
Desc:	specify or determine the execution priority of the specified process
	  or the process and all of its children
SeeAlso: AH=81h
--------D-218F-------------------------------
INT 21 U - European MS-DOS 4.0 - ???
	AH = 8Fh
	???
Return: ???
SeeAlso: AH=87h
--------D-2190-------------------------------
INT 21 U - European MS-DOS 4.0 - ???
	AH = 90h
	???
Return: ???
SeeAlso: AH=87h
--------v-2190-------------------------------
INT 21 - VIRUS - "Carioca" - INSTALLATION CHECK
	AH = 90h
Return: AH = 01h if resident
SeeAlso: AH=89h"VIRUS",AX=9753h"VIRUS"
--------D-2191-------------------------------
INT 21 U - European MS-DOS 4.0 - ???
	AH = 91h
	???
Return: ???
SeeAlso: AH=87h
--------D-2192-------------------------------
INT 21 U - European MS-DOS 4.0 - ???
	AH = 92h
	???
Return: ???
SeeAlso: AH=87h
--------D-2193-------------------------------
INT 21 - European MS-DOS 4.0 - "PIPE" - CREATE A NEW PIPE
	AH = 93h
	CX = size in bytes
Return: CF clear if successful
	    AX = read handle
	    BX = write handle
	CF set on error
	    AX = error code (08h) (see #0960 at AH=59h)
Desc:	create a communications channel which may be used for interprocess
	  data and command exchanges
SeeAlso: AH=3Ch,AH=3Fh,AH=40h,AH=84h
--------D-2194-------------------------------
INT 21 U - European MS-DOS 4.0 - ???
	AH = 94h
	???
Return: ???
SeeAlso: AH=87h
--------D-2195-------------------------------
INT 21 - European MS-DOS 4.0 - HARD ERROR PROCESSING
	AH = 95h
	AL = new state
	   00h enabled
	   01h disabled, automatically fail hard errors
Return: AX = previous setting
Desc:	specify whether hard (critical) errors should automatically fail the
	  system call or invoke an INT 24
SeeAlso: INT 24
--------D-2196-------------------------------
INT 21 U - European MS-DOS 4.0 - ???
	AH = 96h
	???
Return: ???
--------D-2197-------------------------------
INT 21 U - European MS-DOS 4.0 - ???
	AH = 97h
	???
Return: ???
--------v-219753-----------------------------
INT 21 - VIRUS - "Nina" - INSTALLATION CHECK
	AX = 9753h
Return: never (executes original program) if virus resident
SeeAlso: AH=90h"VIRUS",AX=A1D5h"VIRUS",AX=9AD5h"VIRUS"
--------D-2198-------------------------------
INT 21 U - European MS-DOS 4.0 - ???
	AH = 98h
	???
Return: ???
--------D-2199-------------------------------
INT 21 u - European MS-DOS 4.0 - "PBLOCK" - BLOCK A PROCESS
	AH = 99h
	DS:BX -> memory location to block on
	CX = timeout in milliseconds
	DH = nonzero if interruptable
Return: CF clear if awakened by event
	    AX = 0000h
	CF set if unusual wakeup
	    ZF set if timeout, clear if interrupted by signal
	    AX = nonzero
Desc:	suspend calling process until another process sends a "restart" signal
	  or a timeout occurs
SeeAlso: AH=9Ah,INT 2F/AX=0802h
--------D-219A-------------------------------
INT 21 u - European MS-DOS 4.0 - "PRUN" - UNBLOCK A PROCESS
	AH = 9Ah
	DS:BX -> memory location processes may have blocked on
Return: AX = number of processes awakened
	ZF set if no processes awakened
Program: European MS-DOS 4.0 was written for Siemens in Germany and then used
	  by several other European OEMs; its release falls between mainstream
	  versions 3.2 and 3.3
Desc:	restart all processes waiting for the specified "restart" signal
SeeAlso: AH=99h,INT 2F/AX=0802h
--------v-219AD5------------------------
INT 21 - VIRUS - "Massacre/Beavis" - INSTALLATION CHECK
	AX = 9AD5h
Return: AX = 9AD4h if resident
SeeAlso: AX=6969h"VIRUS",AX=A1D5h"VIRUS"
--------I-21A0-------------------------------
INT 21 - Attachmate Extra! - GET 3270 DISPLAY STATE
	AH = A0h
Return: AL = display status (see #1054)
	BX = host window status (see #1055)
Program: Attachmate Extra! is a 3270 emulator by Attachmate Corporation
SeeAlso: AH=A1h

Bitfields for Attachmate Extra! display status:
Bit(s)	Description	(Table 1054)
 7	0=windowed, 1=enlarged
 6-3	current screen profile number 0-9
 2-0	active window number (0=PC, 1-4=host B-E, 5-6=notepad F-G)

Bitfields for host window status:
Bit(s)	Description	(Table 1055)
 15	reserved
 14	0=host E window installed, 1=not
 13	0=host E terminal on, 1=off
 12	0=host E window displayed, 1=not
 11	reserved
 10	0=host D window installed, 1=not
 9	0=host D terminal on, 1=off
 8	0=host D window displayed, 1=not
 7	reserved
 6	0=host C window installed, 1=not
 5	0=host C terminal on, 1=off
 4	0=host C window displayed, 1=not
 3	reserved
 2	0=host B window installed, 1=not
 1	0=host B terminal on, 1=off
 0	0=host B window displayed, 1=not
--------I-21A1-------------------------------
INT 21 - Attachmate Extra! - SET 3270 DISPLAY STATE
	AH = A1h
	AL = new display status byte (see #1054)
SeeAlso: AH=A0h,AH=A2h
--------v-21A1D5-----------------------------
INT 21 - VIRUS - "789"/"Filehider" - INSTALLATION CHECK
	AX = A1D5h
Return: AX = 900Dh if resident
SeeAlso: AX=9753h,AX=9AD5h,AX=A55Ah
--------I-21A2-------------------------------
INT 21 - Attachmate Extra! - SET HOST WINDOW STATE
	AH = A2h
	AL = new host window status byte (see #1056)
SeeAlso: AH=A1h

Bitfields for Attachmate Extra! host window status:
Bit(s)	Description	(Table 1056)
 7	0=power off, 1=power on
 6	0=not installed, 1=installed
 5-3	reserved
 2-0	window number 1-4=host B-E
--------I-21A3-------------------------------
INT 21 - Attachmate Extra! - SEND KEYSTROKES TO HOST WINDOW
	AH = A3h
	AL = window number (1-4=host B-E)
	CX = 0001h
	DS:BX -> keystroke buffer
	DL = zero if keystroke buffer contains host function code (see #1057),
	      non-zero if keystroke buffer contains ASCII character
Return: CX = zero if character sent, non-zero if not
	BX incremented if CX=0

(Table 1057)
Values for Attachmate Extra! host function code:
 00h=reserved	10h=PF16	20h=Clear	30h=SysReq
 01h=PF1	11h=PF17	21h=Print	31h=ErInp
 02h=PF2	12h=PF18	22h=Left	32h=ErEof
 03h=PF3	13h=PF19	23h=Right	33h=Ident
 04h=PF4	14h=PF20	24h=Up		34h=Test
 05h=PF5	15h=PF21	25h=Down	35h=Reset
 06h=PF6	16h=PF22	26h=Home	36h=DevCncl
 07h=PF7	17h=PF23	27h=Fast Left	37h=Dup
 08h=PF8	18h=PF24	28h=Fast Right	38h=FldMark
 09h=PF9	19h=Alt on	29h=Bksp	39h=Enter
 0Ah=PF10	1Ah=Alt off	2Ah=Insert	3Ah=CrSel
 0Bh=PF11	1Bh=Shift on	2Bh=Delete
 0Ch=PF12	1Ch=Shift off	2Ch=Backtab
 0Dh=PF13	1Dh=PA1		2Dh=Tab
 0Eh=PF14	1Eh=PA2		2Eh=Newline
 0Fh=PF15	1Fh=PA3		2Fh=Attn
--------I-21A4-------------------------------
INT 21 - Attachmate Extra! - GET HOST WINDOW BUFFER ADDRESS
	AH = A4h
	AL = window number (1-4=host B-E)
Return: DS:BX -> 3270 display buffer
SeeAlso: AH=A5h,AH=B8h
--------I-21A5-------------------------------
INT 21 - Attachmate Extra! - GET HOST WINDOW CURSOR POSITION
	AH = A5h
	AL = window number (1-4=host B-E)
Return: BX = cursor position (80 * row + column, where 0:0 is upper left)
Note:	if the host window is configured with the Extended Attribute (EAB)
	  feature, multiply the cursor position by 2 to obtain the byte offset
	  into the display buffer
SeeAlso: AH=A4h
--------v-21A55A-----------------------------
INT 21 - VIRUS - "Eddie-2" - INSTALLATION CHECK
	AX = A55Ah
Return: AX = 5AA5h if resident
SeeAlso: AX=A1D5h,AX=AA00h
--------v-21AA00-----------------------------
INT 21 - VIRUS - "Blinker" - INSTALLATION CHECK
	AX = AA00h
Return: AX = 00AAh if resident
SeeAlso: AX=A55Ah,AX=AA03h
--------v-21AA03-----------------------------
INT 21 - VIRUS - "Backtime" - INSTALLATION CHECK
	AX = AA03h
Return: AX = 03AAh if resident
SeeAlso: AX=AA00h,AH=ABh
--------v-21AB-------------------------------
INT 21 - VIRUS - "600" or "Voronezh"-family - INSTALLATION CHECK
	AH = ABh
Return: AX = 5555h if resident
SeeAlso: AX=AA03h,AX=ABCDh,AX=BBBBh"VIRUS"
--------v-21ABCD------------------------
INT 21 - VIRUS - "SuperVirus 2" - INSTALLATION CHECK
	AX = ABCDh
Return: AX = DCBAh if resident
SeeAlso: AH=ABh"VIRUS",AX=BBBBh"VIRUS"
--------I-21AF-------------------------------
INT 21 - Attachmate Extra! - GET TRANSLATE TABLE ADDRESS
	AH = AFh
Return: DS:BX -> translate tables (see #1058)

Format of Attachmate Extra! translate tables:
Offset	Size	Description	(Table 1058)
 00h 256 BYTEs	ASCII to 3270 buffer code translate table
100h 256 BYTEs	3270 buffer code to ASCII translate table
200h 256 BYTEs	3270 buffer code to EBCDIC translate table
300h 256 BYTEs	EBCDIC to 3270 buffer code translate table
--------v-21B3-------------------------------
INT 21 - VIRUS - "Requires" - INSTALLATION CHECK
	AH = B3h
Return: AX = 9051h if resident
SeeAlso: AH=7Fh"VIRUS",AX=B974h"VIRUS"
--------N-21B300-----------------------------
INT 21 U - Novell NetWare - CHECK LIP/PACKET SIGNING/IPX CHECKSUM SUPPORT???
	AX = B300h
Return: AX = 0000h if supported???
Note:	this function appeared with the packet signing/Large Internet Packets/
	  IPX Checksum-aware NetWare shells
SeeAlso: AX=B301h,AX=B302h
--------N-21B301-----------------------------
INT 21 U - Novell NetWare - CHECK SIGNATURE LEVEL???
	AX = B301h
Return: AX = 0000h if supported???
	    BX:CX indicate signature level (see #1059)
Note:	this function appeared with the packet signing/Large Internet Packets/
	  IPX Checksum-aware NetWare shells
SeeAlso: AX=B300h,AX=B304h,#2058 at INT 2F/AX=7A20h/BX=0000h

(Table 1059)
Values for signature level indicator:
 0000h:0000h = signature level 0
 0002h:0000h = signature level 1
 0202h:0000h = signature level 2
 0202h:0202h = signature level 3
--------N-21B302-----------------------------
INT 21 U - Novell NetWare - START PACKET SIGNING
	AX = B302h
	CX = server connection (1-8)
	DS:SI -> 24-byte buffer containing ???
Return: ???
Notes:	this function appeared with the packet signing/Large Internet Packets/
	  IPX Checksum-aware NetWare shells
	if packet signing is active, this call is required if and only if the
	  last call successfully authenticated the workstation to the server
SeeAlso: AX=B300h,#2058
--------N-21B304-----------------------------
INT 21 U - Novell NetWare - SET SIGNATURE LEVEL
	AX = B304h
	BX:CX = new signature level (see AX=B301h)
Return: ???
Note:	this function appeared with the packet signing/Large Internet Packets/
	  IPX Checksum-aware NetWare shells
SeeAlso: AX=B300h,AX=B301h,AX=B306h,#2058
--------N-21B306-----------------------------
INT 21 - Novell NetWare - RENEGOTIATE SECURITY LEVEL
	AX = B306h
	CX = server connection number (01h-08h)
Return: ???
Note:	this function appeared with the packet signing/Large Internet Packets/
	  IPX Checksum-aware NetWare shells
SeeAlso: AX=B300h,AX=B304h,#2058
--------N-21B4-------------------------------
INT 21 U - Novell NetWare - "AttachHandle"
	AH = B4h
	DS:SI -> input buffer (see #1060)
Return: AX = DOS file handle or return code
Note:	this is an interface provided by NetWare to give DOS file access to
	  NetWare files on non-DOS systems such as Macintosh, OS/2, and Unix
SeeAlso: AX=E909h

Format of Novell NetWare input buffer:
Offset	Size	Description	(Table 1060)
 00h	BYTE	"WorkFileServer"
 01h	BYTE	access code
 02h	DWORD	"OpenHandle"
 06h	WORD	"OpenHandleCount"
 08h	DWORD	"OpenFileSize"
Note:	the six bytes at 02h-07h appear to be the six-byte NetWare handle
	  returned by AX=E909h
--------N-21B500-----------------------------
INT 21 U - Novell NetWare - VNETWARE.386 API - GET INSTANCE DATA
	AX = B500h
Return: ES:BX -> data
	CX = length
SeeAlso: AX=B501h,AX=B502h
--------N-21B501-----------------------------
INT 21 U - Novell NetWare - VNETWARE.386 API - END VIRTUAL MACHINE
	AX = B501h
SeeAlso: AX=B500h,AX=B502h
--------N-21B502-----------------------------
INT 21 U - Novell NetWare - VNETWARE.386 API - START VIRTUAL MACHINE
	AX = B502h
SeeAlso: AX=B500h,AX=B501h
--------N-21B5-------------------------------
INT 21 - Novell NetWare shell 3.01 - TASK MODE CONTROL
	AH = B5h
	AL = subfunction
	    03h get task mode
		Return: AH = 00h
			AL = current task mode byte (see #1061)
	    04h get task mode pointer
		Return: ES:BX -> task mode byte
Notes:	the task mode byte specifies how task cleanup should be performed, but
	  is declared to be version-dependent
	allows a program to disable the automatic cleanup for programs managing
	  task swapping, etc.

(Table 1061)
Values for NetWare task mode byte in version 3.01:
 00h-03h reserved
 04h	 no task cleanup
--------N-21B505-----------------------------
INT 21 U - Novell NetWare - VNETWARE.386 API - SET VIRTUAL MACHINE ID
	AX = B505h
	???
Return: ???
SeeAlso: AX=B502h,AX=B506h
--------N-21B506-----------------------------
INT 21 U - Novell NetWare - VNETWARE.386 API - GET VIRTUAL MACH SUPPORT LEVEL
	AX = B506h
Return: AX = ??? (0002h)
SeeAlso: AX=B505h
--------N-21B507-----------------------------
INT 21 - Novell NetWare - NetWare Shell - GET NUMBER OF PACKET BURST BUFFERS
	AX = B507h
Return: AL = number of packet burst buffers (configured at shell load time)
--------N-21B6-------------------------------
INT 21 - Novell NetWare - FILE SERVICES - EXTENDED FILE ATTRIBUTES
	AH = B6h
	AL = subfunction
	    00h get extended file attributes
	    01h set extended file attributes
		CL = extended file attributes (see #1062)
	DS:DX -> ASCIZ pathname (max 255 bytes)
Return: CF set on error
	    AL = error code
		8Ch caller lacks privileges
		FEh not permitted to search directory
		FFh file not found
	CF clear if successful
	    AL = 00h (success)
	    CL = current extended file attributes (see #1062)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AX=4300h,AH=E3h/SF=0Fh

Bitfields for NetWare extended file attributes:
Bit(s)	Description	(Table 1062)
 2-0	search mode (executables only)
	000 none (use shell's default search)
	001 search on all opens without path
	010 do not search
	011 search on read-only opens without path
	100 reserved
	101 search on all opens
	110 reserved
	111 search on all read-only opens
 3	reserved
 4	transactions on file tracked
 5	file's FAT indexed
 6	read audit (to be implemented)
 7	write audit (to be implemented)
--------N-21B7-------------------------------
INT 21 U - Novell NetWare - "HoldFileModeSet" (obsolete)
	AH = B7h
	AL = new value for HoldFileFlag
Return: AL = previous value of HoldFileFlag
Note:	this function provided backward compatibility with a bug in early
	  DOS versions and CP/M, but is no longer used or supported
--------I-21B8-------------------------------
INT 21 - Attachmate Extra! - DISABLE HOST BUFFER UPDATES
	AH = B8h
	AL = window number (1-4=host B-E)
	DL = 01h
Notes:	only valid in CUT mode
	next AID keystroke (eg Enter) enables host buffer updates
SeeAlso: AH=A4h
--------N-21B800-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - GET DEFAULT CAPTURE FLAGS
	AX = B800h
	CX = size of reply buffer (01h-3Fh)
	ES:BX -> reply buffer for capture flags table (see #1063)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.0+
SeeAlso: AX=B801h,AX=B802h,AH=DFh/DL=00h,AH=DFh/DL=04h

Format of NetWare capture flags table:
Offset	Size	Description	(Table 1063)
 00h	BYTE	status (used internally, should be set to 00h)
 01h	BYTE	print flags (see #1064)
 02h	BYTE	tab size (01h-12h, default 08h)
 03h	BYTE	printer number on server (00h-04h, default 00h)
 04h	BYTE	number of copies to print (00h-FFh, default 01h)
 05h	BYTE	form type required in printer (default 00h)
 06h	BYTE	reserved
 07h 13 BYTEs	text to be placed on banner page
 14h	BYTE	reserved
 15h	BYTE	default local printer (00h = LPT1)
 16h	WORD	(big-endian) timeout in clock ticks for flushing capture file
		  on inactivity, or 0000h to disable timeout
 18h	BYTE	flush capture file on LPT close if nonzero
 19h	WORD	(big-endian) maximum lines per page
 1Bh	WORD	(big-endian) maximum characters per line
 1Dh 13 BYTEs	name of form required in printer
 2Ah	BYTE	LPT capture flag
		00h inactive, FFh LPT device is being captured
 2Bh	BYTE	file capture flag
		00h if no file specified, FFh if capturing to file
 2Ch	BYTE	timing out (00h if no timeout in effect, FFh if timeout counter
		  running)
 2Dh	DWORD	(big-endian) address of printer setup string
 31h	DWORD	(big-endian) address of printer reset string
 35h	BYTE	target connection ID
 36h	BYTE	capture in progress if FFh
 37h	BYTE	job queued for printing if FFh
 38h	BYTE	print job valid if FFh
 39h	DWORD	bindery object ID of print queue if previous byte FFh
 3Dh	WORD	(big-endian) print job number (1-999)

Bitfields for NetWare print flags:
Bit(s)	Description	(Table 1064)
 2	print capture file if interrupted by loss of connection
 3	no automatic form feed after print job
 6	printing control sequences interpreted by print service
 7	print banner page before capture file
--------N-21B801-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - SET DEFAULT CAPTURE FLAGS
	AX = B801h
	CX = size of buffer (01h-3Fh)
	ES:BX -> buffer containing capture flags table (see #1063)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.0+
SeeAlso: AX=B800h,AX=B803h,AH=DFh/DL=00h,AH=DFh/DL=04h
--------N-21B802-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - GET SPECIFIC CAPTURE FLAGS
	AX = B802h
	CX = size of reply buffer (01h-3Fh)
	DH = LPT port (00h-02h)
	ES:BX -> reply buffer for capture flags table (see #1063)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AX=B800h,AX=B803h,AH=DFh/DL=00h,AH=DFh/DL=04h
--------N-21B803-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - SET SPECIFIC CAPTURE FLAGS
	AX = B803h
	CX = size of buffer (01h-3Fh)
	DH = LPT port (00h-02h)
	ES:BX -> buffer containing capture flags table (see #1063)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AX=B800h,AX=B803h,AH=DFh/DL=00h,AH=DFh/DL=04h
--------N-21B804-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - GET DEFAULT LOCAL PRINTER
	AX = B804h
Return: DH = default LPT port (00h-02h)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AX=B800h,AX=B805h,AH=DFh/DL=00h
--------N-21B805-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - SET DEFAULT LOCAL PRINTER
	AX = B805h
	DH = new default LPT port (00h-02h)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AX=B800h,AX=B804h,AH=DFh/DL=00h
--------N-21B806-----------------------------
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
SeeAlso: AX=B801h,AX=B807h,AH=E0h/SF=09h
--------N-21B807-----------------------------
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
SeeAlso: AX=B801h,AX=B806h,AH=E0/SF=09h,AH=E3h/SF=68h
--------N-21B808-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - GET BANNER USER NAME
	AX = B808h
	ES:BX -> 12-byte buffer for user name
Return: AL = status
	    00h successful
Desc:	get the user name which is printed on the banner page
Notes:	this function is supported by Advanced NetWare 2.1+
	the default name is the login name of the user
SeeAlso: AX=B809h
--------N-21B809-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - SET BANNER USER NAME
	AX = B809h
	ES:BX -> 12-byte buffer containing user name
Return: AL = status
	    00h successful
Desc:	specify the user name which is printed on the banner page
Notes:	this function is supported by Advanced NetWare 2.1+
	the default name is the login name of the user
SeeAlso: AX=B808h
--------N-21B9-------------------------------
INT 21 U - Novell NetWare - "SpecialAttachableFunction"
	AH = B9h
	AL = FFh to hook this function
	    ES:BX -> function to invoke on AH=B9h when AL<>FFh
Note:	this function is no longer used or supported by current versions of
	  NetWare
--------v-21B974-----------------------------
INT 21 - VIRUS - "Tracker" - INSTALLATION CHECK
	AX = B974h
Return: AX = 2888h if resident
SeeAlso: AH=B3h"VIRUS",AH=D0h"VIRUS"
--------N-21BA-------------------------------
INT 21 U - Novell NetWare - "ReturnCommandComPointers"
	AH = BAh
Return: DX = environment segment
	ES:DI -> COMMAND.COM drive
Desc:	used to edit the COMSPEC and PATH variables in the master environment
	  when mapping network drives
Note:	this function was documented in older Novell documents which are no
	  longer available
--------N-21BB-------------------------------
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
SeeAlso: AH=19h,AH=D6h
--------v-21BBBB-----------------------------
INT 21 - VIRUS - "Hey You" - INSTALLATION CHECK
	AX = BBBBh
Return: AX = 6969h
SeeAlso: AH=ABh"VIRUS",AH=BEh"VIRUS"
--------N-21BC-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - LOG PHYSICAL RECORD
	AH = BCh
	AL = flags (see #1066)
	BX = file handle
	CX:DX = starting offset in file
	SI:DI = length of region to lock
	BP = timeout in timer ticks (1/18 sec)
		0000h = don't wait if already locked
Return: AL = status (see #1065)
Desc:	add the specified physical record to the log table, optionally locking
	  it
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=5Ch,AH=BDh,AH=BEh,AH=BFh,AH=C2h,AH=D0h

(Table 1065)
Values for NetWare status:
 00h	successful
 96h	no dynamic memory for file
 FEh	timed out
 FFh	failed

Bitfields for NetWare flags:
Bit(s)	Description	(Table 1066)
 0	lock as well as log record
 1	non-exclusive lock
--------N-21BD-------------------------------
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
--------N-21BE-------------------------------
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
--------v-21BE-------------------------------
INT 21 - VIRUS - "Datalock" - INSTALLATION CHECK
	AH = BEh
Return: AX = 1234h if resident
SeeAlso: AX=BBBBh,AX=BE00h
--------v-21BE00-----------------------------
INT 21 - VIRUS - "USSR-1049" - INSTALLATION CHECK
	AX = BE00h
	CF set
Return: CF clear if resident
SeeAlso: AH=BEh"VIRUS",AH=C0h"VIRUS"
--------N-21BF-------------------------------
INT 21 O - Novell NetWare, Alloy NTNX - LOG/LOCK RECORD (FCB)
	AH = BFh
	AL = flags (see #1066)
	DS:DX -> opened FCB (see #0648 at AH=0Fh)
	BX:CX = offset
	BP = lock timeout in timer ticks (1/18 sec) if AL nonzero
	SI:DI = length
Return: AL = error code (see #1065)
Note:	this function was added in NetWare 4.6, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
SeeAlso: AH=BCh,AH=C0h"NetWare",AH=C2h"NetWare"
--------N-21C0-------------------------------
INT 21 O - Novell NetWare, Alloy NTNX - RELEASE RECORD (FCB)
	AH = C0h
	DS:DX -> non-extended FCB (see #0648 at AH=0Fh)
	BX:CX = offset
Return: AL = error code (see #1065)
Notes:	unlocks record but does not remove it from log table
	this function was added in NetWare 4.6, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
SeeAlso: AH=BDh,AH=BFh,AH=C1h"NetWare",AH=C3h
--------v-21C0-------------------------------
INT 21 - VIRUS - "Slow"/"Zerotime", "Solano" - INSTALLATION CHECK
	AH = C0h
Return: AX = 0300h if "Slow"/"Zerotime" resident
	AX = 1234h if "Solano" resident
SeeAlso: AX=BE00h,AX=C000h"VIRUS",AX=C301h"VIRUS"
--------v-21C000-----------------------------
INT 21 - VIRUS - "QUICKY" - INSTALLATION CHECK
	AX = C000h
	BX = most files infected by any other infected file
Return: AX = 76F3h if resident
SeeAlso: AH=C0h"VIRUS",AX=C001h,AX=C002h,AH=C1h"VIRUS"
--------v-21C001-----------------------------
INT 21 - VIRUS - "QUICKY" - TURN INFECTION OFF
	AX = C001h
Return: nothing
Note:	if the virus is already memory resident this call disables any
	  further infections
SeeAlso: AX=C000h,AX=C002h
--------v-21C002-----------------------------
INT 21 - VIRUS - "QUICKY" - TURN INFECTION ON
	AX = C002h
Return: nothing
Note:	if the virus is already memory resident and infection is disabled,
	  this call re-enables it
SeeAlso: AX=C000h,AX=C001h
--------N-21C1-------------------------------
INT 21 O - Novell NetWare, Alloy NTNX - CLEAR RECORD (FCB)
	AH = C1h
	DS:DX -> opened FCB (see #0648 at AH=0Fh)
	BX:CX = offset
Return: AL = error code (see #1065)
Note:	unlocks record and removes it from log table
	this function was added in NetWare 4.6, but was removed some time prior
	  to Advanced NetWare, and is no longer listed in current Novell
	  documentation
SeeAlso: AH=BEh,AH=C0h"NetWare",AH=C4h
--------v-21C1-------------------------------
INT 21 - VIRUS - "Solano" - ???
	AH = C1h
	???
Return: ???
SeeAlso: AH=C0h"VIRUS"
--------N-21C2-------------------------------
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
	status FFh will be returned if one or more physical records have been
	  exclusively locked by another process
SeeAlso: AH=BFh,AH=C3h,AH=D1h
--------v-21C2-------------------------------
INT 21 - VIRUS - "Scott's Valley" - ???
	AH = C2h
	???
Return: ???
SeeAlso: AH=C0h"VIRUS"
--------N-21C3-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - RELEASE PHYSICAL RECRD SET
	AH = C3h
Desc:	unlock all currently-locked physical records in the log table, but do
	  not remove them from the table
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=BDh,AH=C0h,AH=C2h"NetWare",AH=C4h,AH=D3h
--------v-21C301DXF1F1-----------------------
INT 21 - VIRUS - "905"/"Backfont" - INSTALLATION CHECK
	AX = C301h
	DX = F1F1h
Return: DX = 0E0Eh if resident
SeeAlso: AH=C0h"VIRUS",AX=C500h"VIRUS"
--------N-21C4-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - CLEAR PHYSICAL RECORD SET
	AH = C4h
Desc:	unlock all physical records in the log table and remove them from the
	  log table
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=BEh,AH=C1h,AH=D5h
--------N-21C500-----------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - OPEN SEMAPHORE
	AX = C500h
	DS:DX -> semaphore name (counted string, max 127 bytes)
	CL = initial value for semaphore
Return: AL = status
	    00h successful
		BL = number of processes having semaphore open
		CX:DX = semaphore handle
	    03h name length greater than 127 (see Novell document FYI.A.4611)
	    FEh invalid name length
	    FFh invalid semaphore value
Notes:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	the semaphore's value is incremented by AX=C503h and decremented by
	  AX=C502h
SeeAlso: AX=C501h,AX=C502h,AX=C503h,AX=C504h,AX=F220h/SF=00h
--------v-21C500-----------------------------
INT 21 - VIRUS - "Sverdlov" - INSTALLATION CHECK
	AX = C500h
Return: AX = 6731h if resident
SeeAlso: AX=C301h"VIRUS",AH=C6h"VIRUS"
--------N-21C501-----------------------------
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
SeeAlso: AX=C500h"NetWare",AX=C502h,AX=C504h,AX=F220h/SF=01h
--------N-21C502-----------------------------
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
SeeAlso: AX=C500h"NetWare",AX=C501h,AX=C503h,AX=F220h/SF=02h
--------N-21C503-----------------------------
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
SeeAlso: AX=C500h"NetWare",AX=C502h,AX=F220h/SF=03h
--------N-21C504-----------------------------
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
SeeAlso: AX=C500h"NetWare",AX=C501h,AX=F220h/SF=04h
--------N-21C6-------------------------------
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
--------v-21C6-------------------------------
INT 21 - VIRUS - "Socha" - INSTALLATION CHECK
	AH = C6h
Return: AL = 55h if resident
SeeAlso: AX=C500h"VIRUS",AX=C603h
--------v-21C603-----------------------------
INT 21 - VIRUS - "Yankee Doodle" or "MLTI" - INSTALLATION CHECK
	AX = C603h
	BX = version number (002Ch or 002Dh)
	CF set
Return: CF clear if resident
	ZF set if resident and input BX matches version
SeeAlso: AX=C500h"VIRUS",AX=C700h"VIRUS"
--------N-21C700-----------------------------
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
SeeAlso: AX=C701h,AX=C702h,AX=C703h,AX=F222h/SF=01h
--------v-21C700-----------------------------
INT 21 - VIRUS - "MH-757" - INSTALLATION CHECK
	AX = C700h
Return: AL = 07h if resident
SeeAlso: AX=C603h"VIRUS",AH=CBh"VIRUS"
--------N-21C701-----------------------------
INT 21 - Novell NetWare - TRANSACTION TRACKING SYSTEM - END TRANSACTION
	AX = C701h
Return: AL = status (00h,FDh-FFh) (see #1067)
	    00h successful
		CX:DX = transaction number
	CF clear except when AL=FFh
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AX=C700h"NetWare",AX=C703h,AX=F222h/SF=02h

(Table 1067)
Values for NetWare TTS status:
 00h	successful
 FDh	transaction tracking disabled
 FEh	transaction ended records locked
 FFh	no explicit transaction active
--------N-21C702-----------------------------
INT 21 - Novell NetWare - TRANSACTION TRACKING SYSTEM - INSTALLATION CHECK
	AX = C702h
Return: AL = status
	    00h not available
	    01h available
	    FDh available but disabled
Desc:	determine whether the default file server supports TTS
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AX=C700h,AX=C701h,AX=C703h,AX=F222h/SF=00h
--------N-21C703-----------------------------
INT 21 - Novell NetWare - TRANSACTION TRACKING SYSTEM - ABORT TRANSACTION
	AX = C703h
Return: CF clear if successful
	    AL = 00h
	CF set on error
	    AL = error code (FDh-FFh) (see #1067)
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AX=C700h"NetWare",AX=C701h,AX=C704h,AX=F222h/SF=03h
--------N-21C704-----------------------------
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
SeeAlso: AX=C700h"NetWare",AX=C701h,AX=C703h,AX=F222h/SF=04h
--------N-21C705-----------------------------
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
SeeAlso: AX=C706h,AX=C707h,AX=F222h/SF=05h
--------N-21C706-----------------------------
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
SeeAlso: AX=C705h,AX=C708h,AX=F222h/SF=06h
--------N-21C707-----------------------------
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
SeeAlso: AX=C705h,AX=C708h,AX=F222h/SF=07h
--------N-21C708-----------------------------
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
SeeAlso: AX=C706h,AX=C707h,AX=F222h/SF=08h
--------N-21C8-------------------------------
INT 21 O - Novell NetWare - BEGIN LOGICAL FILE LOCKING
	AH = C8h
	if function C6h lock mode 00h:
	    DL = mode
		00h no wait
		01h wait
	if function C6h lock mode 01h:
	    BP = timeout in timer ticks (1/18 sec)
Return: AL = error code
Desc:	used to provide TTS support for applications which are not aware of
	  Novell's Transaction Tracking System
Note:	this function was added in NetWare 4.0, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
SeeAlso: AH=C9h
--------N-21C9-------------------------------
INT 21 O - Novell NetWare - END LOGICAL FILE LOCKING
	AH = C9h
Return: AL = error code
Desc:	used to provide TTS support for applications which are not aware of
	  Novell's Transaction Tracking System
Note:	this function was added in NetWare 4.0, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
SeeAlso: AH=C8h
--------N-21CA-------------------------------
INT 21 O - Novell NetWare, Alloy NTNX - LOG/LOCK PERSONAL FILE (FCB)
	AH = CAh
	DS:DX -> FCB (see #0648 at AH=0Fh)
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
Desc:	provides file locking support for FCBs
Note:	this function was added in NetWare 4.0, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
SeeAlso: AH=CBh
--------v-21CA15-----------------------------
INT 21 - VIRUS - "Piter" - ???
	AX = CA15h
	???
Return: ???
SeeAlso: AH=CCh"VIRUS"
--------N-21CB-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - LOCK FILE SET
	AH = CBh
	if function C6h lock mode 00h:
	    DL = mode (00h no wait, 01h wait)
	if function C6h lock mode 01h:
	    BP = lock timeout in timer ticks (1/18 sec), 0000h = no wait
Return: AL = status (00h,FEh,FFh) (see #1068)
Desc:	attempt to lock all files listed in the log table
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	status FFh will be returned if one or more of the files have already
	  been exclusively locked by another process
SeeAlso: AH=CAh,AH=CDh,AH=D1h,AH=EBh

(Table 1068)
Values for NetWare status:
 00h	successful
 FEh	timed out
 FFh	failed
--------v-21CB-------------------------------
INT 21 - VIRUS - "Milous" - INSTALLATION CHECK
	AH = CBh
Return: AL = 07h if resident
SeeAlso: AX=C700h"VIRUS",AX=CB02h
--------v-21CB02-----------------------------
INT 21 - VIRUS - "Witcode" - INSTALLATION CHECK
	AX = CB02h
Return: AX = 02CBh if resident
SeeAlso: AH=CBh"VIRUS",AH=CCh"VIRUS"
--------N-21CC-------------------------------
INT 21 O - Novell NetWare, Alloy NTNX - RELEASE FILE (FCB)
	AH = CCh
	DS:DX -> FCB (see #0648 at AH=0Fh)
Return: none
Desc:	unlocks file, but does not remove it from the log table or close it
Note:	this function was added in NetWare 4.0, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
SeeAlso: AH=CAh,AH=CDh
--------v-21CC-------------------------------
INT 21 - VIRUS - "Westwood" - INSTALLATION CHECK
	AH = CCh
Return: AX = 0700h if resident
SeeAlso: AX=CB02h,AH=CDh"VIRUS",AX=D000h"VIRUS"
--------N-21CD-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - RELEASE FILE SET
	AH = CDh
Return: none
Desc:	unlock all files listed in the log table, but don't remove them from
	  the table
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=CBh,AH=CCh,AH=CFh,AH=D3h
--------v-21CD-------------------------------
INT 21 - VIRUS - "Westwood" - ???
	AH = CDh
	???
Return: ???
SeeAlso: AH=CCh"VIRUS"
--------N-21CE-------------------------------
INT 21 O - Novell NetWare, Alloy NTNX - CLEAR FILE (FCB)
	AH = CEh
	DS:DX -> FCB (see #0648 at AH=0Fh)
Return: AL = error code
Desc:	unlocks file and removes it from log table, then closes all opened and
	  logged occurrences
Note:	this function was added in NetWare 4.0, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
SeeAlso: AH=CAh,AH=CFh,AH=EDh"NetWare"
--------N-21CF-------------------------------
INT 21 - LANstep - ???
	AH = CFh
	???
Return: ???
Program: LANstep is a redesign of the Waterloo Microsystems PORT network
--------N-21CF-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - CLEAR FILE SET
	AH = CFh
Return: AL = 00h
Desc:	unlock and remove all files from log table
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=CAh,AH=CEh,AH=EBh"NetWare"
--------N-21D0-------------------------------
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
--------v-21D0-------------------------------
INT 21 - VIRUS - "MALAGA" - INSTALLATION CHECK
	AH = D0h
Return: AX = 00D0h if resident
SeeAlso: AH=B3h"VIRUS",AX=D000h"VIRUS"
--------v-21D000-----------------------------
INT 21 - VIRUS - "Fellowship" - INSTALLATION CHECK
	AX = D000h
Return: BX = 1234h if resident
SeeAlso: AH=CCh"VIRUS",AH=D0h"VIRUS",AX=D000h"Warlock",AH=D5h"VIRUS",AX=D5AAh
--------v-21D000-----------------------------
INT 21 - VIRUS - "Warlock" - INSTALLATION CHECK
	AX = D000h
	CF clear
Return: CF set if resident (normal DOS return would be CF clear)
SeeAlso: AX=D000h"VIRUS",AH=D5h"VIRUS"
--------N-21D1-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - LOCK LOGICAL RECORD SET
	AH = D1h
	AL = lock type (00h exclusive, 01h shareable)
	if function C6h lock mode 00h:
	    DL = mode (00h no wait, 01h wait)
	if function C6h lock mode 01h: (Novell only)
	    BP = lock timeout in timer ticks (1/18 sec), 0000h no wait
Return: AL = status (see #1068)
Desc:	attempt to lock all logical record names listed in the log table
Notes:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+,
	  Banyan VINES, and Alloy NTNX
	status FFh will be returned if one or more logical records have been
	  exclusively locked by another process
	locks on logical record names are advisory and may be ignored by other
	  applications
SeeAlso: AH=C2h,AH=CBh,AH=D0h,AH=D3h,AH=D5h
--------N-21D2-------------------------------
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
--------v-21D2-------------------------------
INT 21 - VIRUS???
	AH = D2h
	???
Return: ???
Note:	this call is intercepted by the Search&Destroy SDRes v27.03 bundled
	  with Novell DOS 7, and is presumably some virus's installation check
SeeAlso: AH=4Ah/BX=00B6h
--------N-21D3-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - RELEASE LOGICAL RECORD SET
	AH = D3h
Desc:	unlock all currently-locked logical record names in the log table, but
	  do not remove them from the table
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+,
	  Banyan VINES, and Alloy NTNX
	locks on logical record names are advisory and may be ignored by other
	  applications
SeeAlso: AH=C3h,AH=CDh,AH=D1h,AH=D2h,AH=D5h
--------N-21D4-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - CLEAR LOGICAL RECORD
	AH = D4h
	DS:DX -> logical record name (counted string up to 99 chars long)
Return: AL = status (00h,FFh) (see #1069)
Desc:	unlock and remove the logical record name from the log table
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+,
	  Banyan VINES, and Alloy NTNX
	locks on logical record names are advisory and may be ignored by other
	  applications
SeeAlso: AH=BEh,AH=D0h,AH=D2h,AH=D5h

(Table 1069)
Values for NetWare status:
 00h	successful
 FFh	no such record name
--------N-21D5-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - CLEAR LOGICAL RECORD SET
	AH = D5h
Return: AL = error code (00h,FFh) (see #1069)
Desc:	unlock and remove all logical record name from the log table
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+,
	  Banyan VINES, and Alloy NTNX
	locks on logical record names are advisory and may be ignored by other
	  applications
SeeAlso: AH=D1h,AH=D3h,AH=D4h
--------v-21D5-------------------------------
INT 21 - VIRUS - "Carfield" - ???
	AH = D5h
	???
Return: ???
SeeAlso: AX=D5AAh,AH=F3h"Carfield"
--------v-21D5AA-----------------------------
INT 21 - VIRUS - "Diamond-A", "Diamond-B" - INSTALLATION CHECK
	AX = D5AAh
Return: AX = 2A55h if "Diamond-A" resident
	AX = 2A03h if "Diamond-B"-family virus resident
SeeAlso: AX=D000h,AH=D5h"VIRUS",AX=D5AAh/BP=DEAAh
--------v-21D5AABPDEAA-----------------------
INT 21 - VIRUS - "Dir" - INSTALLATION CHECK
	AX = D5AAh
	BP = DEAAh
Return: SI = 4321h if resident
SeeAlso: AX=D5AAh,AX=DADAh"VIRUS"
--------N-21D6-------------------------------
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
--------N-21D7-------------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - SYSTEM LOGOUT
	AH = D7h
Return: AL = error code
Desc:	this function closes the caller's open files, logs it out from all
	  file servers, detaches the workstation from all non-default file
	  servers, and maps a drive to the default server's SYS:LOGIN directory
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=D6h,AH=E3h/SF=14h,AH=F1h
--------N-21D8-------------------------------
INT 21 - Novell NetWare, Banyan VINES - ALLOCATE RESOURCE
	AH = D8h
	DL = resource number
Return: AL = status (00h successful, FFh unsucessful)
Note:	this function is no longer used or supported by NetWare, and is not
	  documented in Novell documents
SeeAlso: AH=D9h
--------N-21D9-------------------------------
INT 21 - Novell NetWare, Banyan VINES - DEALLOCATE RESOURCE
	AH = D9h
	DL = resource number
Return: AL = status (00h successful, FFh unsucessful)
Note:	this function is no longer used or supported by NetWare, and is not
	  documented in Novell documents
SeeAlso: AH=D8h
--------N-21DA-------------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET VOLUME INFO WITH NUMBER
	AH = DAh
	DL = volume number
	ES:DI -> reply buffer (see #1070)
Return: AL = 00h
Notes:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
	operator console rights are not required to make this call
	reported total blocks and total unused blocks include the Hot Fix
	  Table; the NetWare shell's implementation of INT 21/AH=36h will
	  report values larger than 268MB as 268MB.
SeeAlso: AH=36h,AH=E2h/SF=15h,AH=E3h/SF=E9h

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1070)
 00h	WORD	sectors/block
 02h	WORD	total blocks on volume
 04h	WORD	unused blocks
 06h	WORD	total directory entries
 08h	WORD	unused directory entries
 0Ah 16 BYTEs	volume name, null padded
 1Ah	WORD	removable flag, 0000h = not removable
Note:	all words are big-endian
--------v-21DADA-----------------------------
INT 21 - VIRUS - "Gotcha" - INSTALLATION CHECK
	AX = DADAh
Return: AH = A5h
SeeAlso: AX=D5AAh,AX=DAFEh"VIRUS"
--------v-21DAFE-----------------------------
INT 21 - VIRUS - "Plovdiv 1.3" - INSTALLATION CHECK
	AX = DAFEh
Return: AX = 1234h if resident
SeeAlso: AX=DADAh,AH=DDh"VIRUS",AH=DEh"VIRUS"
--------N-21DB-------------------------------
INT 21 - Novell NetWare - WORKSTATION - GET NUMBER OF LOCAL DRIVES
	AH = DBh
Return: AL = number of local disks as set by LASTDRIVE in CONFIG.SYS
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=0Eh
--------N-21DC-------------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - GET CONNECTION NUMBER
	AH = DCh
Return: AL = logical connection number
	    00h if NetWare not loaded or this machine is a non-dedicated server
	CX = station number in ASCII (CL = first digit)
Notes:	this function is supported by NetWare 4.0+, Banyan VINES, and Alloy
	  NTNX
	station number only unique for those PCs connected to same semaphore
	  service
SeeAlso: AH=F2h"NetWare"
--------d-21DC-------------------------------
INT 21 - PCMag PCMANAGE/DCOMPRES - TURN ON/OFF
	AH = DCh
	DX = state
	    0000h turn on
	    0001h turn off
SeeAlso: AX=FEDCh
--------v-21DC28-----------------------------
INT 21 - VIRUS - "Monika" - INSTALLATION CHECK
	AX = DC28h
Return: AX = 1973h if resident
SeeAlso: AX=D000h"VIRUS",AX=DCBAh"VIRUS"
--------v-21DCBA-----------------------------
INT 21 - VIRUS - "Red Spider" - INSTALLATION CHECK
	AX = DCBAh
Return: AX = ABCDh if resident
SeeAlso: AX=DC28h"VIRUS",AX=DEFEh"VIRUS"
--------N-21DD-------------------------------
INT 21 - Novell NetWare - WORKSTATION - SET NetWare ERROR MODE
	AH = DDh
	DL = error mode
	    00h invoke INT 24 on critical I/O errors (default)
	    01h return NetWare extended error code in AL
	    02h return error code in AL, mapped to standard DOS error codes
Return: AL = previous error mode
Note:	this function is supported by Advanced NetWare 2.0+
SeeAlso: INT 24
--------v-21DD-------------------------------
INT 21 - VIRUS - "Jerusalem"-family - RELOCATE VIRUS???
	AH = DDh
	CX = number of bytes to copy
	DS:SI -> source of copy
	ES:DI -> destination of copy
Return: does not return normally; return address is caller's CS:0100h with
	  AX = ???
SeeAlso: AX=DDEFh,AH=E0h"VIRUS",AH=EEh"VIRUS"
--------v-21DDEF------------------------
INT 21 - VIRUS- "GOLGI" - INSTALLATION CHECK
	AX = DDEFh
Return: AX = EFDDh if resident
SeeAlso: AH=DDh"VIRUS",AH=DEh"VIRUS"
--------v-21DE-------------------------------
INT 21 - VIRUS - "Durban" - INSTALLATION CHECK
	AH = DEh
Return: AH = DFh if resident
SeeAlso: AX=DAFEh,AX=DDEFh,AH=DEh"April 1st",AX=DEADh"90210"
--------v-21DE-------------------------------
INT 21 - VIRUS - "April 1st EXE" - ???
	AH = DEh
	???
Return: ???
--------N-21DE-------------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - SET BROADCAST MODE
	AH = DEh
	DL = broadcast mode
	    00h receive server and workstation broadcasts (default)
	    01h receive server broadcasts, discard user messages
	    02h store server broadcasts for retrieval
	    03h store all broadcasts for retrieval
Return: AL = new broadcast mode
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
--------N-21DE--DL04-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - GET BROADCAST MODE
	AH = DEh
	DL = 04h
Return: AL = current broadcast mode
	    00h receive server and workstation broadcasts (default)
	    01h receive server broadcasts, discard user message
	    02h store server broadcasts for retrieval
	    03h store all broadcasts for retrieval
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
--------N-21DE-------------------------------
INT 21 - Novell NetWare - SHELL TIMER INTERRUPT CHECKS
	AH = DEh
	DL = function
	    05h disable shell timer interrupt checks
	    06h enable shell timer interrupt checks
Return: ???
Note:	this function was added in NetWare 4.0, but is not listed in current
	  Novell documentation and is probably no longer supported
--------v-21DEAD------------------------
INT 21 - VIRUS - "90210" - INSTALLATION CHECK
	AX = DEADh
Return: AX = AAAAh if resident
SeeAlso: AH=DEh"VIRUS",AX=DEADh"Shifting",AX=DEDEh"VIRUS"
--------v-21DEAD------------------------
INT 21 - VIRUS - "Shifting Objective" - RELOCATE CODE ???
	AX = DEADh
SeeAlso: AX=FEADh
SeeAlso: AX=DEADh"90210",AX=DEDEh"VIRUS"
--------v-21DEDE-----------------------------
INT 21 - VIRUS - "Brothers" - INSTALLATION CHECK
	AX = DEDEh
Return: AH = 41h if resident
SeeAlso: AX=DEADh"Shifting",AX=DEFEh"VIRUS"
--------v-21DEFE-----------------------------
INT 21 - VIRUS - "Maze" - INSTALLATION CHECK
	AX = DEFEh
Return: AX = ABCDh if resident
SeeAlso: AX=DCBAh"VIRUS",AX=DEDEh"VIRUS",AH=E0h"VIRUS"
--------N-21DF--DL00-------------------------
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
--------N-21DF--DL01-------------------------
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
--------N-21DF--DL02-------------------------
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
--------N-21DF--DL03-------------------------
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
--------N-21DF--DL04-------------------------
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
--------N-21DF--DL05-------------------------
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
--------N-21DF--DL06-------------------------
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
--------N-21DF--DL07-------------------------
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
--------T-21DF00DX534C-----------------------
INT 21 U - Software Carousel - INSTALLATION CHECK
	AX = DF00h
	DX = 534Ch ("SL")
	DI = 534Ch ("SL")
Return: AX = 00FFh if installed
	    ???
Program: Software Carousel is a task switcher by SoftLogic Solutions, Inc.
--------T-21DF01-----------------------------
INT 21 - Software Carousel - SWITCH TO ANOTHER TASK
	AX = DF01h
	BL = task number (00h = next task)
Return: AL = status
	    00h Carousel not running
	    01h successful
	    FFh unsucessful
		AH = error code (01h,02h) (see #1071)

(Table 1071)
Values for Software Carousel error code:
 00h	invalid subfunction in AL
 01h	invalid task number
 02h	tried to switch to task with no memory size
 03h	tried to kill program in partition with no program running
 04h	tried to change size of an active memory partition
 05h	invalid memory size
 06h	tried to send command to task with a pending previous command
--------T-21DF02-----------------------------
INT 21 - Software Carousel - KILL PROGRAM IN MEMORY PARTITION
	AX = DF02h
	BL = task number
Return: AL = status
	    00h Carousel not running
	    01h successful
	    FFh unsucessful
		AH = error code (01h,03h) (see #1071)
--------T-21DF03-----------------------------
INT 21 - Software Carousel - GET PARTITION SIZE AND PROGRAM STATUS
	AX = DF03h
	BL = task number
Return: AL = status
	    00h Carousel not running
	    01h successful
		BL = partition state (00h no program running, 01h prog running)
		DX = partition size in KB
	    FFh unsucessful
		AH = error code (01h) (see #1071)
SeeAlso: AX=DF05h
--------T-21DF04-----------------------------
INT 21 - Software Carousel - GET PARTITION NAME
	AX = DF04h
	BL = task number
Return: AL = status
	    00h Carousel not running
	    01h successful
		CX = length of name (00h if default partition name)
		ES:BX -> partition name (if CX nonzero)
	    FFh unsucessful
		AH = error code (01h) (see #1071)
SeeAlso: AX=DF06h
--------T-21DF05-----------------------------
INT 21 - Software Carousel - CHANGE PARTITION SIZE
	AX = DF05h
	BL = task number
	DX = new size in KB
Return: AL = status
	    00h Carousel not running
	    01h successful
	    FFh unsucessful
		AH = error code (01h,04h,05h) (see #1071)
	BX = minimum size allowed
	CX = maximum size available
SeeAlso: AX=DF03h
--------T-21DF06-----------------------------
INT 21 - Software Carousel - CHANGE PARTITION NAME
	AX = DF06h
	BL = task number
	CX = length of new name (00h to use default, max 18h)
	DS:SI -> new name
Return: AL = status
	    00h Carousel not running
	    01h successful
	    FFh unsucessful
		AH = error code (01h) (see #1071)
SeeAlso: AX=DF04h
--------T-21DF07-----------------------------
INT 21 - Software Carousel - SEND COMMAND TO MEMORY SECTION
	AX = DF07h
	BL = task number
	CX = length of command (max 8 chars)
	DS:SI -> command line
Return: AL = status
	    00h Carousel not running
	    01h successful
	    FFh unsucessful
		AH = error code (01h,06h) (see #1071)
Note:	the maximum length seems too small and may be a typo for 80 characters
--------T-21DF08-----------------------------
INT 21 - Software Carousel - SELECTIVELY ENABLE/DISABLE MENU AND SWITCHING
	AX = DF08h
	BL = new state of keyboard (00h disabled, 01h enabled)
Return: AL = status
	    00h Carousel not running
	    01h successful
Program: Software Carousel is a task switcher by SoftLogic Solutions, Inc.
Note:	when the keyboard is is disabled, the user may neither access the
	  Carousel menu nor switch to another memory section
--------T-21DF09-----------------------------
INT 21 - Software Carousel - BOOT THE SYSTEM
	AX = DF09h
Return: AL = status
	    00h Carousel not running
	    FFh unsucessful
		AH = error code (01h,03h) (see #1071)
Note:	this function never returns if successful
--------T-21DF0A-----------------------------
INT 21 - Software Carousel - GET MEMORY SIZE/PARTITION NUMBER OF CURRENT TASK
	AX = DF0Ah
Return: AL = status
	    00h Carousel not running
	    01h successful
		BL = task number
		DX = memory size in KB
	    FFh unsucessful
		AH = error code (01h,03h) (see #1071)
--------T-21DF0B-----------------------------
INT 21 - Software Carousel - SET TASK SWITCH CALLBACK
	AX = DF0Bh
	BH = interrupt number or 00h
	BL = function number to invoke on partition switch
	CL = function number to call when it is safe for resident programs
		to perform DOS calls
	DS:DX -> FAR function to call if BH=00h
Return: AL = status
	    00h Carousel not running
	    01h successful
	    FFh unsucessful
		AH = error code (01h,03h) (see #1071)
Notes:	the specified interrupt or FAR function is called with AH set to the
	  appropriate one of the values specified in BL and CL, and BL set to
	  the new task number
	the function specified by CL will not be called until the notification
	  is enabled with AX=DF0Ch
SeeAlso: AX=DF0Ch
--------T-21DF0C-----------------------------
INT 21 - Software Carousel - ENABLE DOS-CALL SAFETY NOTIFICATION
	AX = DF0Ch
Return: AL = status
	    00h Carousel not running
	    01h successful
Program: Software Carousel is a task switcher by SoftLogic Solutions, Inc.
SeeAlso: AX=DF0Bh
--------O-21E0-------------------------------
INT 21 - Digital Research DOS Plus - CALL BDOS
	AH = E0h
	CL = BDOS function number (see #3145 at INT E0"CP/M")
	other registers as appropriate for function
Return: as appropriate for function
SeeAlso: AX=4459h,INT E0"CP/M"
--------E-21E0-------------------------------
INT 21 - OS/286, OS/386 - INITIALIZE REAL PROCEDURE
	AH = E0h
	???
Return: ???
SeeAlso: AH=E1h"OS/286"
--------T-21E0-------------------------------
INT 21 - DoubleDOS - MENU CONTROL
	AH = E0h
	AL = subfunction
	    01h exchange tasks
	    73h resume invisible job if suspended
	    74h kill other job
	    75h suspend invisible job
Note:	identical to AH=F0h
SeeAlso: AH=F0h"DoubleDOS"
--------v-21E0-------------------------------
INT 21 - VIRUS - "Jerusalem", "Armagedon" - INSTALLATION CHECK
	AH = E0h
Return: AX = 0300h if "Jerusalem" resident
	AX = DADAh if "Armagedon" resident
SeeAlso: AH=DEh"VIRUS",AX=DEDEh"VIRUS",AX=E00Fh
--------N-21E0-------------------------------
INT 21 - Novell NetWare, Alloy NTNX - PRINT SPOOLING
	AH = E0h
	DS:SI -> request buffer (see #1072)
	ES:DI -> reply buffer
Return: AL = status
Note:	this function was added in NetWare 4.0, but is no longer listed in
	  current Novell documentation and may no longer be supported
SeeAlso: AH=E3h/SF=68h,AX=F211h/SF=06h,AX=F211h/SF=0Ah

Format of NetWare print spooling request buffer:
Offset	Size	Description	(Table 1072)
 00h	WORD	length of following data
 02h	BYTE	subfunction
		00h spool data to a capture file
		01h close and queue capture file
		02h set spool flags
		03h spool existing file
		04h get spool queue entry
		05h remove entry from spool queue
 03h	???
SeeAlso: #1361
--------N-21E0--SF06-------------------------
INT 21 - Novell NetWare - PRINT SERVICES - GET PRINTER STATUS
	AH = E0h subfn 06h
	DS:SI -> request buffer (see #1073)
	ES:DI -> reply buffer (see #1074)
Return: AL = status
	    00h successful
	    FFh no such printer
Desc:	get current state of specified printer attached to the server
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX

Format of NetWare "Get Printer Status" request buffer:
Offset	Size	Description	(Table 1073)
 00h	WORD	0002h (length of following data)
 02h	BYTE	06h (subfunction "Get Printer Status")
 03h	BYTE	printer number (00h-04h)
SeeAlso: #1074

Format of NetWare "Get Printer Status" reply buffer:
Offset	Size	Description	(Table 1074)
 00h	WORD	(call) 0004h (size of following results buffer)
 02h	BYTE	flag: 00h printer active, FFh printer halted
 03h	BYTE	flag: 00h printer online, 01h printer offline
 04h	BYTE	current form type
 05h	BYTE	target printer number (00h-04h)
		same as number in request buffer unless rerouted by server
		  console
SeeAlso: #1073
--------N-21E0--SF09-------------------------
INT 21 - Novell NetWare - PRINT SERVICES - SPECIFY CAPTURE FILE
	AH = E0h subfn 09h
	DS:SI -> request buffer (see #1075)
	ES:DI -> reply buffer (see #1076)
Return: AL = status
	    00h successful
	    9Ch invalid path
Desc:	create a permanent capture file for the next print capture to be
	  started
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	the caller must have read, write, and create rights for the directory
	  containing the capture file

Format of NetWare "Specify Capture File" request buffer:
Offset	Size	Description	(Table 1075)
 00h	WORD	length of following data (max 102h)
 02h	BYTE	09h (subfunction "Specify Capture File")
 03h	BYTE	directory handle or 00h
 04h	BYTE	length of filename
 05h  N BYTEs	name of capture file
SeeAlso: #1076

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1076)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1075
--------v-21E00F-----------------------------
INT 21 - VIRUS - "8-tunes" - INSTALLATION CHECK
	AX = E00Fh
Return: AX = 4C31h if resident
SeeAlso: AH=E0h"VIRUS",AH=E1h"VIRUS"
--------E-21E1-------------------------------
INT 21 - OS/286, OS/386 - ISSUE REAL PROCEDURE CALL
	AH = E1h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AH=E0h"OS/286",AH=E2h"OS/286",AH=E3h"OS/286",AX=250Eh,INT 31/AX=0301h
--------T-21E1-------------------------------
INT 21 - DoubleDOS - CLEAR KEYBOARD BUFFER FOR CURRENT JOB
	AH = E1h
SeeAlso: AH=E2h"DoubleDOS",AH=E3h"DoubleDOS",AH=E8h"DoubleDOS"
SeeAlso: AH=F1h"DoubleDOS"
--------v-21E1-------------------------------
INT 21 - VIRUS - "Mendoza", "Fu Manchu" - INSTALLATION CHECK
	AH = E1h
Return: AX = 0300h if "Mendoza" resident
	AX = 0400h if "Fu Manchu" resident
SeeAlso: AX=E00Fh,AH=E4h"VIRUS"
--------N-21E1--SF00-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - SEND BROADCAST MESSAGE
	AH = E1h subfn 00h
	DS:SI -> request buffer (see #1077)
	ES:DI -> reply buffer (see #1078)
Return: AL = status
	    00h successful
	    FEh I/O error or out of dynamic workspace
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AH=DEh"NetWare",AH=DEh/DL=04h,AH=E1h/SF=01h,AH=E1h/SF=04h
SeeAlso: AH=E1h/SF=09h

Format of NetWare "Send Broadcast Message" request buffer:
Offset	Size	Description	(Table 1077)
 00h	WORD	length of following data (max 9Eh)
 02h	BYTE	00h (subfunction "Send Broadcast Message")
 03h	BYTE	number of connections (01h-64h)
 04h  N BYTEs	list of connections to receive broadcast message
	BYTE	length of message (01h-37h)
      N BYTEs	broadcast message (no control characters or characters > 7Eh)
SeeAlso: #1078

Format of NetWare "Send Broadcast Message" reply buffer:
Offset	Size	Description	(Table 1078)
 00h	WORD	(call) size of following results buffer (max 65h)
 02h	BYTE	number of connections
 03h  N BYTEs	list of per-connection results
		00h successful
		FCh message rejected due to lack of buffer space
		FDh invalid connection number
		FFh blocked (see also AH=E1h/SF=02h)
SeeAlso: #1077
--------N-21E1--SF01-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - GET BROADCAST MESSAGE (OLD)
	AH = E1h subfn 01h
	DS:SI -> request buffer (see #1079)
	ES:DI -> reply buffer (see #1080)
Return: AL = status
	    00h successful
	    FCh full message queue
	    FEh out of dynamic workspace
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AH=DEh/DL=04h,AH=E1h/SF=00h,AH=E1h/SF=05h,AH=E1h/SF=09h
SeeAlso: AX=F215h/SF=01h,AX=F215h/SF=0Bh

Format of NetWare "Get Broadcast Message" request buffer:
Offset	Size	Description	(Table 1079)
 00h	WORD	0001h (length of following data)
 02h	BYTE	01h (subfunction "Get Broadcast Message")
SeeAlso: #1080,#1369

Format of NetWare "Get Broadcast Message" reply buffer:
Offset	Size	Description	(Table 1080)
 00h	WORD	(call) size of following results buffer (max 38h)
 02h	BYTE	length of message (00h-37h)
		00h if no broadcast messages pending
 03h  N BYTEs	message (no control characters or characters > 7Eh)
SeeAlso: #1079,#1367,#1370
--------N-21E1--SF02-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - DISABLE BROADCAST MESSAGES
	AH = E1h subfn 02h
	DS:SI -> request buffer (see #1082)
	ES:DI -> reply buffer (see #1083)
Return: AL = error code
Note:	these functions are supported by NetWare 4.0+ but are not listed in
	  _NetWare_System_Calls--DOS_; they may be obsolete
SeeAlso: AH=E1h/SF=00h,AH=E1h/SF=03h,AH=E1h/SF=04h,AH=E1h/SF=09h
SeeAlso: AX=F215h/SF=02h

Format of NetWare "Disable Broadcasts" request packet:
Offset	Size	Description	(Table 1081)
 00h	WORD	0001h (length of following data)
 02h	BYTE	02h (subfunction "Enable Broadcast Messages")
SeeAlso: #1082,#1083
--------N-21E1--SF03-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - ENABLE BROADCAST MESSAGES
	AH = E1h subfn 03h
	DS:SI -> request buffer (see #1082)
	ES:DI -> reply buffer (see #1083)
Return: AL = error code
Note:	these functions are supported by NetWare 4.0+ but are not listed in
	  _NetWare_System_Calls--DOS_; they may be obsolete
SeeAlso: AH=E1h/SF=00h,AH=E1h/SF=02h,AH=E1h/SF=04h,AH=E1h/SF=09h
SeeAlso: AX=F215h/SF=03h

Format of NetWare "Enable Broadcast Messages" request buffer:
Offset	Size	Description	(Table 1082)
 00h	WORD	0001h (length of following data)
 02h	BYTE	03h (subfunction "Enable Broadcast Messages")
SeeAlso: #1083,#1081

Format of NetWare "Enable/Disable Broadcast Messages" reply buffer:
Offset	Size	Description	(Table 1083)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1082,#1081
--------N-21E1--SF04-------------------------
INT 21 O - Novell NetWare - MESSAGE SERVICES - SEND PERSONAL MESSAGE
	AH = E1h subfn 04h
	DS:SI -> request buffer (see #1084)
	ES:DI -> reply buffer (see #1085)
Return: AL = status
	    00h successful
	    FEh I/O error or out of dynamic workspace
Notes:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0-2.x
	message pipes use CPU time on the file server; IPX, SPX, or NetBIOS
	  connections should be used for peer-to-peer communications as these
	  protocols do not use file server time
SeeAlso: AH=E1h/SF=00h,AH=E1h/SF=05h,AH=E1h/SF=06h,AH=E1h/SF=08h

Format of NetWare "Send Personal Message" request buffer:
Offset	Size	Description	(Table 1084)
 00h	WORD	length of following data (max E5h)
 02h	BYTE	04h (subfunction "Send Personal Message")
 03h	BYTE	number of connections (01h-64h)
 04h  N BYTEs	list of connections to receive broadcast message
	BYTE	length of message (01h-7Eh)
      N BYTEs	message (no control characters or characters > 7Eh)
SeeAlso: #1085

Format of NetWare "Send Personal Message" reply buffer:
Offset	Size	Description	(Table 1085)
 00h	WORD	(call) size of following results buffer (max 65h)
 02h	BYTE	number of connections
 03h  N BYTEs	list of per-connection results
		00h successful
		FCh message rejected because queue is full (contains 6 msgs)
		FDh incomplete pipe
		FFh failed
SeeAlso: #1084
--------N-21E1--SF05-------------------------
INT 21 O - Novell NetWare - MESSAGE SERVICES - GET PERSONAL MESSAGE
	AH = E1h subfn 05h
	DS:SI -> request buffer (see #1086)
	ES:DI -> reply buffer (see #1087)
Return: AL = status
	    00h successful
	    FEh out of dynamic workspace
Desc:	return the oldest message in the default file server's message queue
	  for the calling workstation
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0-2.x
SeeAlso: AH=E1h/SF=01h,AH=E1h/SF=04h,AH=E1h/SF=06h,AH=E1h/SF=08h

Format of NetWare "Get Personal Message" request buffer:
Offset	Size	Description	(Table 1086)
 00h	WORD	0001h (length of following data)
 02h	BYTE	05h (subfunction "Get Personal Message")
SeeAlso: #1087

Format of NetWare "Get Personal Message" reply buffer:
Offset	Size	Description	(Table 1087)
 00h	WORD	(call) size of following results buffer (max 80h)
 02h	BYTE	connection number of sending station
 03h	BYTE	length of message (00h-7Eh)
		00h if no personal messages pending
 04h  N BYTEs	message (no control characters or characters > 7Eh)
SeeAlso: #1086
--------N-21E1--SF06-------------------------
INT 21 O - Novell NetWare - MESSAGE SERVICES - OPEN MESSAGE PIPE
	AH = E1h subfn 06h
	DS:SI -> request buffer (see #1088)
	ES:DI -> reply buffer (see #1089)
Return: AL = status
	    00h successful
	    FEh out of dynamic workspace
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0-2.x
SeeAlso: AH=E1h/SF=04h,AH=E1h/SF=07h,AH=E1h/SF=08h

Format of NetWare "Open Message Pipe" request buffer:
Offset	Size	Description	(Table 1088)
 00h	WORD	length of following data (max 66h)
 02h	BYTE	06h (subfunction "Open Message Pipe")
 03h	BYTE	number of pipes to open (01h-64h)
 04h  N BYTEs	list of connection numbers
SeeAlso: #1089,#1090,#1093

Format of NetWare "Open Message Pipe" reply buffer:
Offset	Size	Description	(Table 1089)
 00h	WORD	(call) size of following results buffer (max 65h)
 02h	BYTE	number of connections
 03h  N BYTEs	list of results
		00h successful
		FEh incomplete (target half not yet created)
		FFh failed
SeeAlso: #1088,#1091,#1094
--------N-21E1--SF07-------------------------
INT 21 O - Novell NetWare - MESSAGE SERVICES - CLOSE MESSAGE PIPE
	AH = E1h subfn 07h
	DS:SI -> request buffer (see #1090)
	ES:DI -> reply buffer (see #1091)
Return: AL = status
	    00h successful
	    FCh full message queue
	    FEh out of dynamic workspace
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0-2.x
SeeAlso: AH=E1h/SF=05h,AH=E1h/SF=06h,AH=E1h/SF=08h

Format of NetWare "Close Mesage Pipe" request buffer:
Offset	Size	Description	(Table 1090)
 00h	WORD	length of following data (max 66h)
 02h	BYTE	07h (subfunction "Close Message Pipe")
 03h	BYTE	number of pipes to close (01h-64h)
 04h  N BYTEs	list of connection numbers
SeeAlso: #1088,#1091

Format of NetWare "Close Message Pipe" reply buffer:
Offset	Size	Description	(Table 1091)
 00h	WORD	(call) size of following results buffer (max 65h)
 02h	BYTE	number of connections
 03h  N BYTEs	list of results
		00h successful
		FDh failed
		FFh no such pipe
SeeAlso: #1089,#1090
--------N-21E1--SF08-------------------------
INT 21 O - Novell NetWare - MESSAGE SERVICES - CHECK PIPE STATUS
	AH = E1h subfn 08h
	DS:SI -> request buffer (see #1093)
	ES:DI -> reply buffer (see #1094)
Return: AL = status (see #1092)
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0-2.x
SeeAlso: AH=E1h/SF=05h,AH=E1h/SF=06h,AH=E1h/SF=07h,AX=F215h/SF=08h

(Table 1092)
Values for NetWare function status:
 00h	successful
 FCh	full message queue
 FEh	out of dynamic workspace
SeeAlso: #1097

Format of NetWare "Check Pipe Status" request buffer:
Offset	Size	Description	(Table 1093)
 00h	WORD	length of following data (max 66h)
 02h	BYTE	08h (subfunction "Check Pipe Status")
 03h	BYTE	number of pipes to monitor (01h-64h)
 04h  N BYTEs	list of connection numbers
SeeAlso: #1088,#1094

Format of NetWare "Check Pipe Status" reply buffer:
Offset	Size	Description	(Table 1094)
 00h	WORD	(call) size of following results buffer (max 65h)
 02h	BYTE	number of connections
 03h  N BYTEs	list of pipe statuses
		00h open
		FEh incomplete
		FFh closed
SeeAlso: #1089,#1093,#1368
--------N-21E1--SF09-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - BROADCAST TO CONSOLE
	AH = E1h subfn 09h
	DS:SI -> request buffer (see #1095)
	ES:DI -> reply buffer (see #1096)
Return: AL = status (see #1092)
Desc:	send a one-line message to the system console on the default file
	  server
Note:	this function is supported by NetWare 4.0+ and Advanced NetWare 1.0+
SeeAlso: AH=DEh/DL=04h,AH=E1h/SF=00h,AH=E1h/SF=01h,AH=E3h/SF=D1h
SeeAlso: AX=F215h/SF=09h

Format of NetWare "Broadcast to Console" request buffer:
Offset	Size	Description	(Table 1095)
 00h	WORD	length of following data (max 3Eh)
 02h	BYTE	09h (subfunction "Broadcast to Console")
 03h	BYTE	length of message (01h-3Ch)
 04h  N BYTEs	message (no control characters or characters > 7Eh)
SeeAlso: #1096

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1096)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1095
--------E-21E2-------------------------------
INT 21 - OS/286, OS/386 - SET REAL PROCEDURE SIGNAL HANDLER
	AH = E2h
	???
Return: ???
SeeAlso: AH=E0h"OS/286",AH=E1h"OS/286",AH=E6h"OS/286"
--------N-21E2-------------------------------
INT 21 - DoubleDOS - SEND CHARACTER TO KEYBOARD BUFFER OF OTHER JOB
	AH = E2h
	AL = character
Return: AL = 00h successful
	     01h buffer full (128 characters)
SeeAlso: AH=E1h"DoubleDOS",AH=E3h"DoubleDOS",AH=E8h"DoubleDOS"
SeeAlso: AH=F2h"DoubleDOS"
--------N-21E2--SF00-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - SET DIRECTORY HANDLE
	AH = E2h subfn 00h
	DS:SI -> request buffer (see #1098)
	ES:DI -> reply buffer (see #1099)
Return: AL = status (00h,98h,9Bh,9Ch) (see #1097)
Desc:	set the target handle to reference the directory specified by the
	  source handle and the source path; both handles must refer to the
	  same file server
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	the target handle is not changed if this function fails
SeeAlso: AH=E2h/SF=01h,AH=E2h/SF=12h,AH=E2h/SF=13h,AX=F216h/SF=00h

(Table 1097)
Values for NetWare function status:
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
 C6h	no console rights
 FCh	no such bindery object
SeeAlso: #1092,#1124

Format of NetWare "Set Directory Handle" request buffer:
Offset	Size	Description	(Table 1098)
 00h	WORD	length of following data (max 103h)
 02h	BYTE	00h (subfunction "Set Directory Handle")
 03h	BYTE	directory handle of target
 04h	BYTE	directory handle of source
 05h	BYTE	length of source directory path (01h-FFh)
 06h  N BYTEs	source directory path
SeeAlso: #1099

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1099)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1098
--------N-21E2--SF01-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET DIRECTORY PATH
	AH = E2h subfn 01h
	DS:SI -> request buffer (see #1100)
	ES:DI -> reply buffer (see #1101)
Return: AL = status (00h,9Bh) (see #1097)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=02h,AH=E2h/SF=03h,AH=E2h/SF=1Ah,AH=E9h,AX=F216h/SF=01h

Format of NetWare "Get Directory Path" request buffer:
Offset	Size	Description	(Table 1100)
 00h	WORD	0002h (length of following data)
 02h	BYTE	01h (subfunction "Get Directory Path")
 03h	BYTE	directory handle
SeeAlso: #1101,#1102

Format of NetWare "Get Directory Path" reply buffer:
Offset	Size	Description	(Table 1101)
 00h	WORD	(call) length of following data buffer
 02h	BYTE	length of directory path (01h-FFh)
 03h  N BYTEs	full directory path including volume
SeeAlso: #1100,#1103
--------N-21E2--SF02-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - SCAN DIRECTORY INFORMATION
	AH = E2h subfn 02h
	DS:SI -> request buffer (see #1102)
	ES:DI -> reply buffer (see #1103)
Return: AL = status (00h,98h,9Bh,9Ch) (see #1097)
Desc:	get information about the first or next subdirectory of the specified
	  directory
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=01h,AH=E2h/SF=03h,AH=E2h/SF=19h,AX=F216h/SF=02h

Format of NetWare "Scan Directory Information" request buffer:
Offset	Size	Description	(Table 1102)
 00h	WORD	length of following data (max 104h)
 02h	BYTE	02h (subfunction "Scan Directory Information")
 03h	BYTE	directory handle
 04h	WORD	(big-endian) subdirectory number
		0000h for first call, returned subdir number + 1 on next call
 06h	BYTE	length of directory path
 07h  N BYTEs	directory path
SeeAlso: #1100,#1103

Format of NetWare "Scan Directory Information" reply buffer:
Offset	Size	Description	(Table 1103)
 00h	WORD	(call) 001Ch (length of following data buffer)
 02h 16 BYTEs	subdirectory name
 12h	DWORD	(big-endian) date and time of creation (see #1104)
 16h	DWORD	(big-endian) object ID of owner
 1Ah	BYTE	maximum directory rights (see #1107)
 1Bh	BYTE	unused
 1Ch	WORD	(big-endian) subdirectory number
SeeAlso: #1101,#1102,#1371 at AX=F216h/SF=02h

Bitfields for NetWare date and time:
Bit(s)	Description	(Table 1104)
 31-25	year-1980
 24-21	month
 20-16	day
 15-11	hour
 10-5	minute
 4-0	second
--------N-21E2--SF03-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET EFFECTIVE DIRECTORY RIGHTS
	AH = E2h subfn 03h
	DS:SI -> request buffer (see #1105)
	ES:DI -> reply buffer (see #1106)
Return: AL = status (00h,98h,9Bh) (see #1097)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=01h,AH=E2h/SF=02h,AX=F216h/SF=03h

Format of NetWare "Get Effective Directory Rights (old)" request buffer:
Offset	Size	Description	(Table 1105)
 00h	WORD	length of following data (max 102h)
 02h	BYTE	03h (subfunction "Get Effective Directory Rights (old)")
 03h	BYTE	directory handle
 04h	BYTE	length of directory path (00h-FFh)
 05h  N BYTEs	directory path
SeeAlso: #1106,#1108

Format of NetWare "Get Effective Directory Rights" reply buffer:
Offset	Size	Description	(Table 1106)
 00h	WORD	(call) 0001h (length of following data buffer)
 02h	BYTE	effective directory rights (see #1107)
SeeAlso: #1105

Bitfields for NetWare directory rights:
Bit(s)	Description	(Table 1107)
 0	reading allowed
 1	writing allowed
 2	opens allowed
 3	file creation allowed
 4	deletion allowed
 5	"parental" may create/delete subdirectories and grant/revoke trustee
	  rights
 6	directory search allowed
 7	file attributes may be changed
SeeAlso: #1106,#1108
--------N-21E2--SF04-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - MODIFY MAXIMUM RIGHTS MASK
	AH = E2h subfn 04h
	DS:SI -> request buffer (see #1108)
	ES:DI -> reply buffer (see #1109)
Return: AL = status (00h,8Ch,98h,9Ch) (see #1097)
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=03h,AH=E2h/SF=0Ah,AH=E2h/SF=0Dh,AX=F216h/SF=04h

Format of NetWare "Modify Maximum Rights Mask" request buffer:
Offset	Size	Description	(Table 1108)
 00h	WORD	length of following data (max 104h)
 02h	BYTE	04h (subfunction "Modify Maximum Rights Mask")
 03h	BYTE	directory handle
 04h	BYTE	rights to grant (see #1107)
 05h	BYTE	rights to revoke (see #1107)
 06h	BYTE	length of directory path (00h-FFh)
 07h  N BYTEs	directory path
Note:	the rights specified at offset 05h are revoked first, and then the
	  rights specified at offset 04h are added to the resulting rights
	  mask
SeeAlso: #1105,#1109

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1109)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1108
--------N-21E2--SF05-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET VOLUME NUMBER
	AH = E2h subfn 05h
	DS:SI -> request buffer (see #1110)
	ES:DI -> reply buffer (see #1111)
Return: AL = status (00h,98h) (see #1097)
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=DAh,AH=E2h/SF=02h,AH=E2h/SF=05h,AH=E2h/SF=15h,AH=E3h/SF=E9h
SeeAlso: AX=F216h/SF=05h

Format of NetWare "Get Volume Number" request buffer:
Offset	Size	Description	(Table 1110)
 00h	WORD	length of following data (max 12h)
 02h	BYTE	05h (subfunction "Get Volume Number")
 03h	BYTE	length of volume name (01h-10h)
 04h  N BYTEs	volume name
SeeAlso: #1111,#1373 at AX=F216h/SF=05h

Format of NetWare "Get Volume Number" reply buffer:
Offset	Size	Description	(Table 1111)
 00h	WORD	(call) 0001h (length of following results buffer)
 02h	BYTE	volume number
SeeAlso: #1110,#1373 at AX=F216h/SF=05h
--------N-21E2--SF06-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET VOLUME NAME
	AH = E2h subfn 06h
	DS:SI -> request buffer (see #1112)
	ES:DI -> reply buffer (see #1113)
Return: AL = status (00h,98h) (see #1097)
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=DAh,AH=E2h/SF=02h,AH=E2h/SF=05h,AH=E2h/SF=15h,AH=E2h/SF=1Ah
SeeAlso: AH=E3h/SF=E9h,AX=F216h/SF=06h

Format of NetWare "Get Volume Name" request buffer:
Offset	Size	Description	(Table 1112)
 00h	WORD	0002h (length of following data)
 02h	BYTE	06h (subfunction "Get Volume Name")
 03h	BYTE	volume number
SeeAlso: #1113,#1374 at AX=F216h/SF=06h

Format of NetWare "Get Volume Name" reply buffer:
Offset	Size	Description	(Table 1113)
 00h	WORD	(call) 0011h (length of following results buffer)
 02h	BYTE	length of volume name
 03h 16 BYTEs	NUL-padded volume name
SeeAlso: #1112,#1374 at AX=F216h/SF=06h
--------N-21E2--SF0A-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - CREATE DIRECTORY
	AH = E2h subfn 0Ah
	DS:SI -> request buffer (see #1114)
	ES:DI -> reply buffer (see #1115)
Return: AL = status (00h,84h,98h,FCh) (see #1097)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=39h,AH=E2h/SF=0Bh,AH=E2h/SF=0Fh,AX=F216h/SF=0Ah

Format of NetWare "Create Directory" request buffer:
Offset	Size	Description	(Table 1114)
 00h	WORD	length of following data (max 103h)
 02h	BYTE	0Ah (subfunction "Create Directory")
 03h	BYTE	directory handle
 04h	BYTE	maximum directory rights (see #1107)
 05h	BYTE	length of directory path (00h-FFh)
 06h  N BYTEs	directory path
SeeAlso: #1115,#1116

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1115)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1114,#1116
--------N-21E2--SF0B-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - DELETE DIRECTORY
	AH = E2h subfn 0Bh
	DS:SI -> request buffer (see #1116)
	ES:DI -> reply buffer (see #1115)
Return: AL = status (00h,8Ah,98h,9Bh,9Ch,9Fh,A0h) (see #1097)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=3Ah,AH=E2h/SF=0Ah,AH=E2h/SF=0Fh,AX=F216h/SF=0Bh

Format of NetWare "Delete Directory" request buffer:
Offset	Size	Description	(Table 1116)
 00h	WORD	length of following data (max 103h)
 02h	BYTE	0Bh (subfunction "Delete Directory")
 03h	BYTE	directory handle
 04h	BYTE	unused
 05h	BYTE	length of directory path (00h-FFh)
 06h  N BYTEs	directory path
SeeAlso: #1114,#1115
--------N-21E2--SF0C-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - SCAN DIRECTORY FOR TRUSTEES
	AH = E2h subfn 0Ch
	DS:SI -> request buffer (see #1117)
	ES:DI -> reply buffer (see #1118)
Return: AL = status (00h,9Ch) (see also #1097)
	    9Ch no more trustees
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E2h/SF=0Dh,AH=E2h/SF=0Eh,AH=E3h/SF=47h,AX=F216h/SF=0Ch

Format of NetWare "Scan Directory For Trustees" request buffer:
Offset	Size	Description	(Table 1117)
 00h	WORD	length of following data (max 103h)
 02h	BYTE	0Ch (subfunction "Scan Directory For Trustees")
 03h	BYTE	directory handle
 04h	BYTE	sequence number
		00h on first call, increment for each subsequent call
 05h	BYTE	length of directory path (00h-FFh)
 06h  N BYTEs	directory path
SeeAlso: #1118,#1119,#1375 at AX=F216h/SF=0Ch

Format of NetWare "Scan Directory For Trustees" reply buffer:
Offset	Size	Description	(Table 1118)
 00h	WORD	(call) 0031h (length of following results buffer)
 02h 16 BYTEs	directory name
 12h  4 BYTEs	date and time of creation
 16h	DWORD	(big-endian) object ID of owner
 1Ah  5 DWORDs	(big-endian) object IDs of Trustees 0 through 4
		00000000h = end of group
 2Eh  5 BYTEs	directory rights for Trustees 0 through 4 (see #1107)
SeeAlso: #1117,#1121,#1375 at AX=F216h/SF=0Ch
--------N-21E2--SF0D-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - ADD TRUSTEE TO DIRECTORY
	AH = E2h subfn 0Dh
	DS:SI -> request buffer (see #1119)
	ES:DI -> reply buffer (see #1121)
Return: AL = status (00h,8Ch,FCh) (see #1097)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=0Ch,AH=E2h/SF=0Eh,AH=E3h/SF=47h,AX=F216h/SF=0Dh

Format of NetWare "Add Trustee To Directory" request buffer:
Offset	Size	Description	(Table 1119)
 00h	WORD	length of following data (max 107h)
 02h	BYTE	0Dh (subfunction "Add Trustee To Directory")
 03h	BYTE	directory handle
 04h	DWORD	(big-endian) object ID of trustee
 08h	BYTE	trustee directory rights (see #1107)
 09h	BYTE	length of directory path (00h-FFh)
 0Ah  N BYTEs	directory path
SeeAlso: #1121
--------N-21E2--SF0E-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - DELETE TRUSTEE FROM DIRECTORY
	AH = E2h subfn 0Eh
	DS:SI -> request buffer (see #1120)
	ES:DI -> reply buffer (see #1121)
Return: AL = status (00h,98h,9Bh,9Ch) (see #1097)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=0Ch,AH=E2h/SF=0Dh,AX=F216h/SF=0Eh

Format of NetWare "Delete Trustee From Directory" request buffer:
Offset	Size	Description	(Table 1120)
 00h	WORD	length of following data (max 107h)
 02h	BYTE	0Eh (subfunction "Delete Trustee From Directory")
 03h	BYTE	directory handle
 04h	DWORD	(big-endian) object ID of trustee
 08h	BYTE	unused
 09h	BYTE	length of directory path (00h-FFh)
 0Ah  N BYTEs	directory path
SeeAlso: #1121

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1121)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1120,#1122,#1123
--------N-21E2--SF0F-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - RENAME DIRECTORY
	AH = E2h subfn 0Fh
	DS:SI -> request buffer (see #1122)
	ES:DI -> reply buffer (see #1121)
Return: AL = status (00h,8Bh,9Bh,9Ch,9Eh) (see #1097)
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	directories SYS:LOGIN, SYS:MAIL, and SYS:PUBLIC must not be renamed
SeeAlso: AH=56h,AH=E2h/SF=0Ah,AH=E2h/SF=0Bh,AX=F216h/SF=0Fh

Format of NetWare "Rename Directory" request buffer:
Offset	Size	Description	(Table 1122)
 00h	WORD	length of following data (max 111h)
 02h	BYTE	0Fh (subfunction "Rename Directory")
 03h	BYTE	directory handle
 04h	BYTE	length of directory path (00h-FFh)
 05h  N BYTEs	directory path
	BYTE	length of new directory name (01h-0Eh)
      N BYTEs	new directory name
SeeAlso: #1121
--------N-21E2--SF10-------------------------
INT 21 - Novell NetWare - FILE SERVICES - PURGE ERASED FILES (OLD)
	AH = E2h subfn 10h
	DS:SI -> request buffer (see #1123)
	ES:DI -> reply buffer (see #1121)
Return: AL = status (00h,C6h) (see #1124)
Desc:	purges files marked for deletion on the file server by the calling
	  workstation
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=13h,AH=41h,AH=E2h/SF=11h,AH=E3h/SF=CEh,AX=F244h,AX=F216h/SF=10h

Format of NetWare "Purge Erased Files" request buffer:
Offset	Size	Description	(Table 1123)
 00h	WORD	0001h (length of following data)
 02h	BYTE	10h (subfunction "Purge Erased Files")
SeeAlso: #1121
--------N-21E2--SF11-------------------------
INT 21 - Novell NetWare - FILE SERVICES - RESTORE ERASED FILE (OLD)
	AH = E2h subfn 11h
	DS:SI -> request buffer (see #1125)
	ES:DI -> reply buffer (see #1126)
Return: AL = status (00h,98h,FFh) (see #1124)
Desc:	restores one file marked for deletion which has not yet been purged
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=13h,AH=41h,AH=E2h/SF=10h,AH=E3h/SF=CEh,AX=F244h

(Table 1124)
Values for NetWare function status:
 00h	successful
 98h	nonexistent volume
 9Ch	invalid path
 C6h	no console rights
 FFh	no more erased files
SeeAlso: #1097,#1157

Format of NetWare "Restore Erased File" request buffer:
Offset	Size	Description	(Table 1125)
 00h	WORD	length of following data (max 13h)
 02h	BYTE	11h (subfunction "Restore Erased File")
 03h	BYTE	directory handle or 00h
 04h	BYTE	length of volume name
 05h  N BYTEs	volume name (including colon)
Note:	if both a directory handle and a volume name are specified, the volume
	  name overrides the handle
SeeAlso: #1126,#1376

Format of NetWare "Restore Erased File" reply buffer:
Offset	Size	Description	(Table 1126)
 00h	WORD	(call) 001Eh (size of following results buffer)
 02h 15 BYTEs	ASCIZ name of erased file
 11h 15 BYTEs	ASCIZ name under which file was restored
SeeAlso: #1125,#1376
--------N-21E2--SF12-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - ALLOC PERMANENT DIRECTORY HANDLE
	AH = E2h subfn 12h
	DS:SI -> request buffer (see #1127)
	ES:DI -> reply buffer (see #1128)
Return: AL = status (00h,98h,9Ch) (see #1124)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=00h,AH=E2h/SF=13h,AH=E2h/SF=14h,AX=F216h/SF=12h

Format of NetWare "Allocate Permanent Directory Handle" request buffer:
Offset	Size	Description	(Table 1127)
 00h	WORD	length of following data (max 103h)
 02h	BYTE	12h (subfunction "Allocate Permanent Directory Handle")
 03h	BYTE	directory handle
 04h	BYTE	drive ('A'-'Z')
 05h	BYTE	length of directory path
 06h  N BYTEs	directory path
SeeAlso: #1128,#1129,#1378

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1128)
 00h	WORD	(call) 0002h (size of following results buffer)
 02h	BYTE	new directory handle
 03h	BYTE	effective directory rights (see #1107)
SeeAlso: #1127,#1378
--------N-21E2--SF13-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - ALLOC TEMPORARY DIRECTORY HANDLE
	AH = E2h subfn 13h
	DS:SI -> request buffer (see #1129)
	ES:DI -> reply buffer (see #1128)
Return: AL = status (00h,98h,9Ch) (see #1124)
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	this call is the same as AH=E2h/SF=12h except that the directory handle
	  will be automatically deallocated when the calling application
	  executes an End of Job call (AH=D6h) or terminates
SeeAlso: AH=D6h,AH=E2h/SF=00h,AH=E2h/SF=12h,AH=E2h/SF=14h,AH=E2h/SF=16h
SeeAlso: AX=F216h/SF=13h

Format of NetWare "Allocate Temporary Directory Handle" request buffer:
Offset	Size	Description	(Table 1129)
 00h	WORD	length of following data (max 103h)
 02h	BYTE	13h (subfunction "Allocate Temporary Directory Handle")
 03h	BYTE	directory handle
 04h	BYTE	drive ('A'-'Z')
 05h	BYTE	length of directory path
 06h  N BYTEs	directory path
SeeAlso: #1127,#1130
--------N-21E2--SF14-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - DEALLOCATE DIRECTORY HANDLE
	AH = E2h subfn 14h
	DS:SI -> request buffer (see #1130)
	ES:DI -> reply buffer (see #1131)
Return: AL = status (00h,9Bh) (see #1097)
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=12h,AH=E2h/SF=13h,AX=F216h/SF=14h

Format of NetWare "Deallocate Directory Handle" request buffer:
Offset	Size	Description	(Table 1130)
 00h	WORD	0002h (length of following data)
 02h	BYTE	14h (subfunction "Deallocate Directory Handle")
 03h	BYTE	directory handle
SeeAlso: #1131

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1131)
 00h	WORD	(call) 0000h (no returned data)
SeeAlso: #1130
--------N-21E2--SF15-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET VOLUME INFO WITH HANDLE
	AH = E2h subfn 15h
	DS:SI -> request buffer (see #1132)
	ES:DI -> reply buffer (see #1133)
Return: AL = status
	    00h successful
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=DAh,AH=E2h/SF=02h,AH=E2h/SF=06h,AH=E2h/SF=19h,AH=E3h/SF=E9h
SeeAlso: AX=F216h/SF=15h

Format of NetWare "Get Volume Info with Handle" request buffer:
Offset	Size	Description	(Table 1132)
 00h	WORD	0002h (length of following data)
 02h	BYTE	15h (subfunction "Get Volume Info With Handle")
 03h	BYTE	directory handle
SeeAlso: #1133,#1379

Format of NetWare "Get Volume Info with Handle" reply buffer:
Offset	Size	Description	(Table 1133)
 00h	WORD	(call) 001Ch (length of following results buffer)
 02h	WORD	(big-endian) sectors per block
 04h	WORD	(big-endian) total blocks on volume
 06h	WORD	(big-endian) blocks available on volume
 08h	WORD	(big-endian) total directory slots
 0Ah	WORD	(big-endian) directory slots available
 0Ch 16 BYTEs	NUL-padded volume name
 1Ch	WORD	(big-endian) flag: volume removable if nonzero
SeeAlso: #1132,#1379
--------N-21E2--SF16-------------------------
INT 21 u - Novell NetWare - DIRECTORY SERVICES - ALLOC SPECIAL TEMP DIR HANDLE
	AH = E2h subfn 16h
	DS:SI -> request buffer (see #1134)
	ES:DI -> reply buffer (see #1131)
Return: AL = status
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX,
	  but is not described in _NetWare_System_Calls--DOS_
SeeAlso: AH=E2h/SF=13h,AH=E2h/SF=14h,AX=F216h/SF=16h

Format of NetWare "Alloc Special Temporary Directory Handle" request buffer:
Offset	Size	Description	(Table 1134)
 00h	WORD	length of following data
 02h	BYTE	16h (subfunction "Allocate Special Temporary Directory Handle")
 03h	BYTE	source directory handle
 04h	BYTE	drive name ('A'-'Z')
 05h	BYTE	path length
 06h  N BYTEs	directory path
SeeAlso: #1131
--------N-21E2--SF17-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - SAVE DIRECTORY HANDLE
	AH = E2h subfn 17h
	DS:SI -> request buffer (see #1135)
	ES:DI -> reply buffer (see #1136)
Return: AL = status
	    00h successful
	    else network error code
Note:	this function is supported by Advanced NetWare 2.0+ and Alloy NTNX
SeeAlso: AH=E2h/SF=12h,AH=E2h/SF=17h,AX=F216h/SF=17h

Format of NetWare "Save Directory Handle" request buffer:
Offset	Size	Description	(Table 1135)
 00h	WORD	0002h (length of following data)
 02h	BYTE	17h (subfunction "Save Directory Handle")
 03h	BYTE	directory handle
SeeAlso: #1136,#1137

Format of NetWare "Save Directory Handle" reply buffer:
Offset	Size	Description	(Table 1136)
 00h	WORD	(call) 0010h (length of following results buffer)
 02h 16 BYTEs	save buffer
SeeAlso: #1135,#1138
--------N-21E2--SF18-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - RESTORE DIRECTORY HANDLE
	AH = E2h subfn 18h
	DS:SI -> request buffer (see #1137)
	ES:DI -> reply buffer (see #1138)
Return: AL = status
	    00h successful
	    else network error code
Desc:	restore a previously saved directory handle to reproduce an executing
	  environment, possibly on a different execution site
Note:	this function is supported by Advanced NetWare 2.0+ and Alloy NTNX
SeeAlso: AH=E2h/SF=12h,AH=E2h/SF=17h,AX=F216h/SF=18h

Format of NetWare "Restore Directory Handle" request buffer:
Offset	Size	Description	(Table 1137)
 00h	WORD	0011h (length of following data)
 02h	BYTE	18h (subfunction "Restore Directory Handle")
 03h 16 BYTEs	save buffer
SeeAlso: #1135,#1138

Format of NetWare "Restore Directory Handle" reply buffer:
Offset	Size	Description	(Table 1138)
 00h	WORD	(call) 0002h (length of following results buffer)
 02h	BYTE	new directory handle
 03h	BYTE	effective rights (see #1107)
SeeAlso: #1137
--------N-21E2--SF19-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - SET DIRECTORY INFORMATION
	AH = E2h subfn 19h
	DS:SI -> request buffer (see #1139)
	ES:DI -> reply buffer (see #1140)
Return: AL = status (00h,9Bh,9Ch) (see #1097)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E2h/SF=02h,AH=E2h/SF=0Fh,AX=F216h/SF=19h

Format of NetWare "Set Directory Information" request buffer:
Offset	Size	Description	(Table 1139)
 00h	WORD	length of following data (max 10Bh)
 02h	BYTE	19h (subfunction "Set Directory Information")
 03h	BYTE	directory handle
 04h	DWORD	(big-endian) date and time of creation
 08h	DWORD	(big-endian) object ID of owner
 0Ch	BYTE	maximum directory rights (see #1107)
 0Dh	BYTE	length of directory path
 0Eh  N BYTEs	directory path
SeeAlso: #1140

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1140)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1139
--------N-21E2--SF1A-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET PATH FROM DIRECTORY ENTRY
	AH = E2h subfn 1Ah
	DS:SI -> request buffer (see #1141)
	ES:DI -> reply buffer (see #1142)
Return: AL = status
	    00h successful
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=01h,AH=E2h/SF=06h,AH=E3h/SF=D7h,AX=F216h/SF=1Ah

Format of NetWare "Get Path from Directory Entry" request buffer:
Offset	Size	Description	(Table 1141)
 00h	WORD	0004h (length of following data)
 02h	BYTE	1Ah (subfunction "Get Path From Directory Entry")
 03h	BYTE	volume number (00h-1Fh)
 04h	WORD	(big-endian) directory entry number
SeeAlso: #1142,#1382

Format of NetWare "Get Path from Directory Entry" reply buffer:
Offset	Size	Description	(Table 1142)
 00h	WORD	(call) size of following results record (max 200h)
 02h 256 BYTEs	path
SeeAlso: #1141,#1382
--------E-21E3-------------------------------
INT 21 - OS/286, OS/386 - ISSUE REAL INTERRUPT
	AH = E3h
	AL = interrupt number
	???
Return: ???
Note:	protected mode only???
SeeAlso: AH=E1h"OS/286",INT 31/AX=0300h
--------T-21E3-------------------------------
INT 21 - DoubleDOS - ADD CHARACTER TO KEYBOARD BUFFER OF CURRENT JOB
	AH = E3h
	AL = character
Return: AL = status
	    00h successful
	    01h buffer full (128 characters)
SeeAlso: AH=E1h"DoubleDOS",AH=E2h"DoubleDOS",AH=E8h"DoubleDOS"
SeeAlso: AH=F3h"DoubleDOS"
--------N-21E3-------------------------------
INT 21 - Novell NetWare - CONNECTION CONTROL
	AH = E3h
	DS:SI -> request buffer (see #1143)
	ES:DI -> reply buffer (see #1144)
Return: AL = status
	    00h successful
	    else error code
Note:	supported by NetWare 4.0+, Advanced NetWare 1.0+, and Alloy NTNX
SeeAlso: AH=E3h/SF=0Ah,AH=E3h/SF=32h,AH=E3h/SF=64h,AH=E3h/SF=C8h

Format of NetWare request buffer:
Offset	Size	Description	(Table 1143)
 00h	WORD	length of following data
 02h	BYTE	subfunction number (see also AH=E3h/SF=01h,AH=E3h/SF=02h)
		00h login
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
SeeAlso: #1144,#1145,#1148

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1144)
 00h	WORD	(call) length of following buffer space for results
	var	depends on subfunction
SeeAlso: #1143

Format of NetWare object property:
Offset	Size	Description	(Table 1145)
 00h 1-16 BYTEs property name (see also #1146)
  N	BYTE	flags
		bit 0: property is dynamic
		bit 1: property is a set rather than an item
 N+1	BYTE	security levels (see #1147)
	???

(Table 1146)
Values for names of well-known NetWare properties:
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

(Table 1147)
Values for NetWare security levels:
 00h	"anyone" everyone may access
 01h	"logged" only logged-in clients may access
 02h	"object" only clients logged-in with object's name, type, and password
 03h	"supervisor" only clients logged-in with supervisor privileges
 04h	"NetWare" only NetWare may access
Note:	the above values are stored in a nybble; the high half-byte is write
	  access and the low half-byte is read access

(Table 1148)
Values for NetWare object type:
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
 0021h	NAS SNA gateway
 0026h	remote bridge server
 0027h	TCPIP gateway
 002Dh	time synchronization server
 002Eh	archive server dynamic SAP
 0047h	advertising print server
 0053h	print queue uwer
 0048h-8000h reserved
 FFFFh	wild (used only for finding objects)
--------N-21E3--SF01-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - CHANGE USER PASSWORD (OLD)
	AH = E3h subfn 01h
	DS:SI -> request buffer (see #1149)
	ES:DI -> reply buffer (see #1153)
Return: AL = status
	    00h successful
	    else error code
Note:	supported by NetWare 4.0+, Advanced NetWare 1.0+, and Alloy NTNX
SeeAlso: AH=E3h/SF=0Ah,AH=E3h/SF=32h,AH=E3h/SF=64h,AH=E3h/SF=C8h

Format of NetWare "Change User Password (old)" request packet:
Offset	Size	Description	(Table 1149)
 00h	WORD	length of following data
 02h	BYTE	01h (subfunction "Change User Password (old)")
 03h	BYTE	length of user name
 04h  N BYTEs	user name
	BYTE	length of old password
      N BYTEs	old password
	BYTE	length of new password
      N BYTEs	new password
SeeAlso: #1153
--------N-21E3--SF02-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - CHANGE USER PASSWORD (OLD)
	AH = E3h subfn 02h
	DS:SI -> request buffer (see #1150)
	ES:DI -> reply buffer (see #1151)
Return: AL = status
	    00h successful
	    else error code
Note:	supported by NetWare 4.0+, Advanced NetWare 1.0+, and Alloy NTNX
SeeAlso: AH=E3h/SF=01h,AH=E3h/SF=03h,AH=E3h/SF=0Ah

Format of NetWare "Get User Connection List (old)" request packet:
Offset	Size	Description	(Table 1150)
 00h	WORD	length of following data
 02h	BYTE	02h (subfunction "Get User Connection List (old)")
 03h	BYTE	length of user name
 04h  N BYTEs	user name
SeeAlso: #1151,#1422

Format of NetWare "Get User Connection List (old)" reply packet:
Offset	Size	Description	(Table 1151)
 00h	WORD	(call) length of following buffer
 02h	BYTE	length of connection list
 03h	BYTE	number of bytes in connection list
 04h  N BYTEs	list of connection numbers in use by user
SeeAlso: #1150,#1422
--------N-21E3--SF0A-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - ENTER LOGIN AREA
	AH = E3h subfn 0Ah
	DS:SI -> request buffer (see #1152)
	ES:DI -> reply buffer (see #1153)
Return: AL = status
	    00h successful
Desc:	change the login directory for the calling workstation
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=D7h,AH=E3h/SF=14h

Format of NetWare "Enter Login Area" request buffer:
Offset	Size	Description	(Table 1152)
 00h	WORD	length of following data (max 102h)
 02h	BYTE	0Ah (subfunction "Enter Login Area")
 03h	BYTE	number of local drives
 04h	BYTE	length of subdirectory name (00h-FFh)
 05h  N BYTEs	name of subdirectory under SYS:LOGIN where to find the login
		  utility
SeeAlso: #1153

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1153)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1149,#1152,#1156
--------N-21E3--SF0C-------------------------
INT 21 U - Novell NetWare - VERIFY NETWORK SERIAL NUMBER
	AH = E3h subfn 0Ch
	DS:SI -> request buffer (see #1154)
	ES:DI -> reply buffer (see #1155)
Return: AL = status
	    00h successful
Note:	if the network serial number to be verified is correct, the reply
	  buffer will contain the corresponding application number
SeeAlso: AH=E3h/SF=12h,AX=F217h/SF=0Ch

Format of NetWare "Verify Network Serial Number" request buffer:
Offset	Size	Description	(Table 1154)
 00h	WORD	0005h (length of following data)
 02h	BYTE	0Ch (subfunction "Verify Network Serial Number")
 03h	DWORD	(big-endian) network serial number to verify
SeeAlso: #1155,#1423

Format of NetWare "Verify Network Serial Number" reply buffer:
Offset	Size	Description	(Table 1155)
 00h	WORD	(call) 0002h (size of following results buffer)
 02h	WORD	(big-endian) application number
SeeAlso: #1154,#1423
--------N-21E3--SF0D-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - LOG NETWORK MESSAGE
	AH = E3h subfn 0Dh
	DS:SI -> request buffer (see #1156)
	ES:DI -> reply buffer (see #1153)
Return: AL = status
	    00h successful
Desc:	append a line to the default file server's NET$LOG.MSG file
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E1h/SF=09h

Format of NetWare "Log Network Message" request buffer:
Offset	Size	Description	(Table 1156)
 00h	WORD	length of following data (max 52h)
 02h	BYTE	0Dh (subfunction "Log Network Message")
 03h	BYTE	length of message (01h-50h)
 04h  N BYTEs	message (no control characters or characters > 7Eh)
SeeAlso: #1153
--------N-21E3--SF0E-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET DISK UTILIZATION
	AH = E3h subfn 0Eh
	DS:SI -> request buffer (see #1158)
	ES:DI -> reply buffer (see #1159)
Return: AL = status (00h,98h,F2h) (see #1157)
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must have bindery object read privileges
SeeAlso: AH=E3h/SF=11h,AH=E3h/SF=D6h,AH=E3h/SF=D9h,AH=E3h/SF=E6h,AH=E3h/SF=E9h
SeeAlso: AX=F217h/SF=0Eh

(Table 1157)
Values for NetWare function status:
 00h	successful
 98h	nonexistent volume
 F2h	not permitted to read object
SeeAlso: #1124,#1160

Format of NetWare "Get Disk Utilization" request buffer:
Offset	Size	Description	(Table 1158)
 00h	WORD	0005h (length of following data)
 02h	BYTE	0Eh (subfunction "Get Disk Utilization")
 03h	BYTE	volume number (00h-1Fh)
 04h	DWORD	(big-endian) object ID
SeeAlso: #1159,#1424

Format of NetWare "Get Disk Utilization" reply buffer:
Offset	Size	Description	(Table 1159)
 00h	WORD	(call) 000Bh (size of following results buffer)
 02h	BYTE	volume number (00h-1Fh)
 03h	DWORD	(big-endian) object ID
 07h	WORD	(big-endian) directories used by object
 09h	WORD	(big-endian) files created by object
 0Bh	WORD	(big-endian) disk blocks used by object-created files
SeeAlso: #1158,#1424
--------N-21E3--SF0F-------------------------
INT 21 - Novell NetWare - FILE SERVICES - SCAN FILE INFORMATION
	AH = E3h subfn 0Fh
	DS:SI -> request buffer (see #1161)
	ES:DI -> reply buffer (see #1162)
Return: AL = status (see #1160)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=B6h,AH=E3h/SF=10h,AX=F217h/SF=0Fh

(Table 1160)
Values for NetWare function status:
 00h	successful
 89h	not permitted to search directory
 FFh	no more matching files
SeeAlso: #1157,#1178

Format of NetWare "Scan File Information" request buffer:
Offset	Size	Description	(Table 1161)
 00h	WORD	length of following data (max 105h)
 02h	BYTE	0Fh (subfunction "Scan File Information")
 03h	WORD	(big-endian) sequence number
		FFFFh on first call
 05h	BYTE	directory handle or 00h
 06h	BYTE	search attributes (see #0717 at AX=4301h)
 07h	BYTE	length of filespec
 08h  N BYTEs	ASCIZ uppercase filespec
SeeAlso: #1162,#1425

Format of NetWare "Scan File Information" reply buffer:
Offset	Size	Description	(Table 1162)
 00h	WORD	(call) 005Eh (size of following results buffer)
 02h	WORD	next sequence number (place in request buffer for next call)
 04h 14 BYTEs	ASCIZ filename
 12h	BYTE	file attributes (see #0717 at AX=4301h)
 13h	BYTE	extended file attributes (see #1062 at AH=B6h)
 14h	DWORD	(big-endian) file size in bytes
 18h	WORD	(big-endian) file's creation date (see #0952 at AX=5700h)
 1Ah	WORD	(big-endian) date of last access (see #0951 at AX=5700h)
 1Ch	DWORD	(big-endian) date and time of last update (see #1104)
 20h	DWORD	(big-endian) object ID of owner
 24h	DWORD	(big-endian) date and time last archived (see #1104)
 28h 55 BYTEs	reserved
Note:	the official documentation erroneously lists the field at offset 04h as
	  15 bytes and thus shifts the remaining fields by one byte
SeeAlso: #1161,#1425
--------N-21E3--SF10-------------------------
INT 21 - Novell NetWare - FILE SERVICES - SET FILE INFORMATION
	AH = E3h subfn 10h
	DS:SI -> request buffer (see #1163)
	ES:DI -> reply buffer (see #1164)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the caller must have modify privileges on the directory containing the
	  file
SeeAlso: AH=B6h,AH=E3h/SF=0Fh,AX=F217h/SF=10h

Format of NetWare "Set File Information" request buffer:
Offset	Size	Description	(Table 1163)
 00h	WORD	length of following data (max 151h)
 02h	BYTE	10h (subfunction "Set File Information")
 03h	BYTE	file attributes (see #0717 at AX=4301h)
 04h	BYTE	extended file attributes (see #1062 at AH=B6h)
 05h  4 BYTEs	reserved
 09h	WORD	(big-endian) file's creation date (see #0952 at AX=5700h)
 0Bh	WORD	(big-endian) date of last access (see #0951 at AX=5700h)
 0Dh	DWORD	(big-endian) date and time of last update (see #1104)
 11h	DWORD	(big-endian) object ID of owner
 15h	DWORD	(big-endian) date and time last archived (see #1104)
 19h 56 BYTEs	reserved
 51h	BYTE	directory handle or 00h
 52h	BYTE	search attributes (see #0717 at AX=4301h)
 53h	BYTE	length of filename
 54h  N BYTEs	filename
SeeAlso: #1164

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1164)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1163
--------N-21E3--SF11-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER INFORMATION
	AH = E3h subfn 11h
	DS:SI -> request buffer (see #1165)
	ES:DI -> reply buffer (see #1166)
Return: AL = status
	    00h successful
Desc:	determine the version of software installed on the file server and
	  how it is configured
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=0Eh,AE3h/SF=12h,AH=E3h/SF=CDh,AH=E3h/SF=D3h,AH=E3h/SF=E7h
SeeAlso: AH=E7h,AX=F217h/SF=11h

Format of NetWare "Get File Server Information" request buffer:
Offset	Size	Description	(Table 1165)
 00h	WORD	0001h (length of following data)
 02h	BYTE	11h (subfunction "Get File Server Information")
SeeAlso: #1166,#1426 at AX=F217h/SF=11h

Format of NetWare "Get File Server Information" reply buffer:
Offset	Size	Description	(Table 1166)
 00h	WORD	(call) 0080h (size of following results buffer)
 02h 48 BYTEs	server's name
 32h	BYTE	NetWare version
 33h	BYTE	NetWare subversion (0-99)
 34h	WORD	(big-endian) number of connections supported
		NetWare 4.01 reportedly returns maximum simulataneously-used
		  connections
 36h	WORD	(big-endian) number of connections in use
 38h	WORD	(big-endian) maximum connected volumes
---Advanced NetWare 2.1+ ---
 3Ah	BYTE	operating system revision number
 3Bh	BYTE	fault tolerance (SFT) level
 3Ch	BYTE	TTS level
 3Dh	WORD	(big-endian) maximum simultaneously-used connections
		NetWare 4.01 reportedly returns number of connections in use
 3Fh	BYTE	accounting version
 40h	BYTE	VAP version
 41h	BYTE	queueing version
 42h	BYTE	print server version
 43h	BYTE	virtual console version
 44h	BYTE	security restrictions level
 45h	BYTE	internetwork bridge version
 46h 60 BYTEs	reserved
SeeAlso: #1165,#1426
--------N-21E3--SF12-------------------------
INT 21 - Novell NetWare - GET NETWORK SERIAL NUMBER
	AH = E3h subfn 12h
	AL = 00h
	BX = CX = DX = 0000h
	DS:SI -> request buffer (see #1167)
	ES:DI -> reply buffer (see #1168)
Return: AL = status
	    00h successful
Desc:	return the serial number and application number for the software
	  installed on the file server
Notes:	this function is supported by Advanced NetWare 2.1+
	reportedly, the workstation crashes if AL,BX,CX, and DX are not all
	  zero
SeeAlso: AH=E3h/SF=0Ch,AH=E3h/SF=11h,AX=F217h/SF=12h

Format of NetWare "Get Serial Number" request buffer:
offset	 size	description	(Table 1167)
 00h	 WORD	0001h (length of following data)
 02h	 BYTE	12h (subfunction "Get Serial Number")
SeeAlso: #1168,#1427

Format of NetWare "Get Serial Number" reply buffer:
offset	 size	description	(Table 1168)
 00h	 WORD	(call) 0006h (size of following results buffer)
 02h   4 BYTEs	(big-endian) NetWare server serial number
 06h   2 BYTEs	(big-endian) NetWare application serial number
SeeAlso: #1167,#1427
--------N-21E3--SF13-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - GET INTERNET ADDRESS (OLD)
	AH = E3h subfn 13h
	DS:SI -> request buffer (see #1169)
	ES:DI -> reply buffer (see #1170)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=DCh"NetWare",AH=E3h/SF=16h,AH=EEh"NetWare",AX=F217h/SF=13h

Format of NetWare "Get Internet Address (old)" request buffer:
Offset	Size	Description	(Table 1169)
 00h	WORD	0002h (length of following data)
 02h	BYTE	13h (subfunction "Get Internet Address")
 03h	BYTE	logical connection number (01h-64h)
SeeAlso: #1170,#1428

Format of NetWare "Get Internet Address (old)" reply buffer:
Offset	Size	Description	(Table 1170)
 00h	WORD	(call) 000Ch (length of following results buffer)
 02h  4 BYTEs	network number
 06h  6 BYTEs	physical node address
 0Ch  2 BYTEs	socket number
SeeAlso: #1169,#1428 at AX=F217h/SF=13h
--------N-21E3--SF14-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - LOGIN TO FILE SERVER
	AH = E3h subfn 14h
	DS:SI -> request buffer (see #1171)
	ES:DI -> reply buffer (see #1172)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=D7h"NetWare",AH=F1h"NetWare",AX=F217h/SF=14h

Format of NetWare "Login to File Server" request buffer:
Offset	Size	Description	(Table 1171)
 00h	WORD	length of following data (max B3h)
 02h	BYTE	14h (subfunction "Login To File Server")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
	BYTE	length of password
      N BYTEs	password
SeeAlso: #1172

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1172)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1171
--------N-21E3--SF15-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - GET OBJECT CONNECTION LIST(OLD)
	AH = E3h subfn 15h
	DS:SI -> request buffer (see #1173)
	ES:DI -> reply buffer (see #1174)
Return: AL = status
	    00h successful
Desc:	this function retrieves a list indicating the connection numbers under
	  which a bindery object is logged into the default file server
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=DCh"NetWare",AH=E3h/SF=16h,AX=F217h/SF=15h

Format of NetWare "Get Object Connection Numbers" request buffer:
Offset	Size	Description	(Table 1173)
 00h	WORD	length of following data (max 33h)
 02h	BYTE	15h (subfunction "Get Object Connection Numbers")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
SeeAlso: #1174,#1429

Format of NetWare "Get Object Connection Numbers" reply buffer:
Offset	Size	Description	(Table 1174)
 00h	WORD	(call) length of following results buffer (max 65h)
 02h	BYTE	number of connections
 03h  N BYTEs	connection list
SeeAlso: #1173,#1429
--------N-21E3--SF16-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - GET CONNECTION INFORMATION
	AH = E3h subfn 16h
	DS:SI -> request buffer (see #1175)
	ES:DI -> reply buffer (see #1176)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=D7h,AH=DCh"NetWare",AH=E3h/SF=14h

Format of NetWare "Get Connection Information" request buffer:
Offset	Size	Description	(Table 1175)
 00h	WORD	0002h (length of following data)
 02h	BYTE	16h (subfunction "Get Connection Information")
 03h	BYTE	logical connection number (01h-64h)

Format of NetWare "Get Connection Information" reply buffer:
Offset	Size	Description	(Table 1176)
 00h	WORD	(call) 003Eh (length of following results buffer)
 02h	DWORD	(big-endian) object ID for object logged in on the connection
		00000000h if no object logged in
 06h	WORD	(big-endian) type of object
 08h 48 BYTEs	name of object
 38h  7 BYTEs	login time (see #1177)
Note:	much of the Novell documentation incorrectly states the reply buffer
	  length as 3Fh instead of 40h, which corresponds to a results length
	  of 3Dh (61) bytes instead of the correct 3Eh (62) bytes

Format of NetWare login time:
Offset	Size	Description	(Table 1177)
 00h	BYTE	year (80-99 = 1980-1999, 00-79 = 2000-2079)
 01h	BYTE	month (1-12)
 02h	BYTE	day (1-31)
 03h	BYTE	hour (0-23)
 04h	BYTE	minute (0-59)
 05h	BYTE	second (0-59)
 06h	BYTE	day of week (0 = Sunday)
--------N-21E3--SF32-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CREATE BINDERY OBJECT
	AH = E3h subfn 32h
	DS:SI -> request buffer (see #1179)
	ES:DI -> reply buffer (see #1180)
Return: AL = status (see #1178)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=33h,AH=E3h/SF=34h,AH=E3h/SF=38h,AH=E3h/SF=39h
SeeAlso: AX=F217h/SF=32h

(Table 1178)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 EEh	object already exists
 EFh	invalid name
 F0h	wildcard not allowed
 F1h	invalid bindery security level
 F3h	not permitted to rename object
 F4h	not permitted to delete objects
 F5h	not permitted to create objects
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure
SeeAlso: #1160,#1185

Format of NetWare "Create Bindery Object" request buffer:
Offset	Size	Description	(Table 1179)
 00h	WORD	length of following data (max 35h)
 02h	BYTE	32h (subfunction "Create Bindery Object")
 03h	BYTE	object flag (00h static, 01h dynamic)
 04h	BYTE	object security levels
 05h	WORD	(big-endian) type of object
 07h	BYTE	length of object's name
 08h  N BYTEs	object's name
SeeAlso: #1180

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1180)
 00h	WORD	0000h (no data returned)
SeeAlso: #1179,#1181,#1182
--------N-21E3--SF33-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - DELETE BINDERY OBJECT
	AH = E3h subfn 33h
	DS:SI -> request buffer (see #1181)
	ES:DI -> reply buffer (see #1180)
Return: AL = status (see #1178)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=34h,AX=F217h/SF=33h

Format of NetWare "Delete Bindery Object" request buffer:
Offset	Size	Description	(Table 1181)
 00h	WORD	length of following data (max 33h)
 02h	BYTE	33h (subfunction "Delete Bindery Object")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
SeeAlso: #1180
--------N-21E3--SF34-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - RENAME BINDERY OBJECT
	AH = E3h subfn 34h
	DS:SI -> request buffer (see #1182)
	ES:DI -> reply buffer (see #1180)
Return: AL = status (see #1178)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=33h,AX=F217h/SF=34h

Format of NetWare "Rename Bindery Object" request buffer:
Offset	Size	Description	(Table 1182)
 00h	WORD	length of following data (max 63h)
 02h	BYTE	34h (subfunction "Rename Bindery Object")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
	BYTE	length of new name (01h-2Fh)
      N BYTEs	new name
SeeAlso: #1180
--------N-21E3--SF35-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - GET BINDERY OBJECT ID
	AH = E3h subfn 35h
	DS:SI -> request buffer (see #1183)
	ES:DI -> reply buffer (see #1184)
Return: AL = status (00h,96h,FCh,FEh,FFh) (see #1185)
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the requesting workstation must be logged into the file server with
	  read access to the bindery object
SeeAlso: AH=E3h/SF=36h,AH=E3h/SF=44h,AX=F217h/SF=35h

Format of NetWare "Get Bindery Object ID" request buffer:
Offset	Size	Description	(Table 1183)
 00h	WORD	length of following data (max 33h)
 02h	BYTE	35h (subfunction "Get Bindery Object ID")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name
 06h  N BYTEs	object's name
SeeAlso: #1184,#1444

Format of NetWare "Get Bindery Object ID" reply buffer:
Offset	Size	Description	(Table 1184)
 00h	WORD	(call) 0036h (length of following buffer space)
 02h	DWORD	(big-endian) object ID
 06h	WORD	(big-endian) type of object
 08h 48 BYTEs	object name
SeeAlso: #1183,#1444 at AX=F217h/SF=35h
--------N-21E3--SF36-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - GET BINDERY OBJECT NAME
	AH = E3h subfn 36h
	DS:SI -> request buffer (see #1186)
	ES:DI -> reply buffer (see #1187)
Return: AL = status (see #1185)
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the requesting workstation must be logged into the file server with
	  read access to the bindery object
SeeAlso: AH=E3h/SF=35h,AH=E3h/SF=44h,AX=F217h/SF=36h

(Table 1185)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 EFh	invalid name
 F0h	wildcard not allowed
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure
SeeAlso: #1178,#1191

Format of NetWare "Get Bindery Object Name" request buffer:
Offset	Size	Description	(Table 1186)
 00h	WORD	0005h (length of following data)
 02h	BYTE	36h (subfunction "Get Bindery Object Name")
 03h	DWORD	(big-endian) object ID
SeeAlso: #1187,#1445 at AX=F217h/SF=36h

Format of NetWare "Get Bindery Object Name" reply buffer:
Offset	Size	Description	(Table 1187)
 00h	WORD	(call) 0036h (length of following buffer space)
 02h	DWORD	(big-endian) object ID
 06h	WORD	(big-endian) type of object
 08h 48 BYTEs	object name
SeeAlso: #1186,#1445
--------N-21E3--SF37-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - SCAN BINDERY OBJECT
	AH = E3h subfn 37h
	DS:SI -> request buffer (see #1188)
	ES:DI -> reply buffer (see #1189)
Return: AL = status (see #1185)
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the requesting workstation must be logged into the file server with
	  read access to the bindery object
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=33h,AH=E3h/SF=38h,AH=E3h/SF=3Ch
SeeAlso: AX=F217h/SF=37h

Format of NetWare "Scan Bindery Object" request buffer:
Offset	Size	Description	(Table 1188)
 00h	WORD	length of following data (max 37h)
 02h	BYTE	37h (subfunction "Scan Bindery Object")
 03h	DWORD	(big-endian) last object ID
 07h	WORD	(big-endian) type of object
 09h	BYTE	length of object's name
 0Ah  N BYTEs	object's name
SeeAlso: #1189,#1446

Format of NetWare "Scan Bindery Object" reply buffer:
Offset	Size	Description	(Table 1189)
 00h	WORD	(call) 0039h (length of following buffer space)
 02h	DWORD	(big-endian) object ID
		FFFFFFFFh for first call
 06h	WORD	(big-endian) type of object
 08h 48 BYTEs	object name (counted string)
 38h	BYTE	object flag (00h static, 01h dynamic)
 39h	BYTE	object's security levels
 3Ah	BYTE	object properties flag (00h no, FFh yes)
SeeAlso: #1188,#1446
--------N-21E3--SF38-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CHANGE BINDERY OBJECT SECURITY
	AH = E3h subfn 38h
	DS:SI -> request buffer (see #1190)
	ES:DI -> reply buffer (see #1193)
Return: AL = status (00h,96h,F0h,F1h,FBh,FCh,FEh,FFh) (see #1191)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=3Bh,AX=F217h/SF=38h

Format of NetWare "Change Bindery Object Security" request buffer:
Offset	Size	Description	(Table 1190)
 00h	WORD	length of following data (max 34h)
 02h	BYTE	38h (subfunction "Change Bindery Object Security")
 03h	BYTE	new security levels
 04h	WORD	(big-endian) type of object
 06h	BYTE	length of object's name (01h-2Fh)
 07h  N BYTEs	object name
Note:	the object type may not be WILD (FFFFh)
SeeAlso: #1193
--------N-21E3--SF39-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CREATE PROPERTY
	AH = E3h subfn 39h
	DS:SI -> request buffer (see #1192)
	ES:DI -> reply buffer (see #1193)
Return: AL = status (see #1191)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=3Bh,AX=F217h/SF=39h

(Table 1191)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 EDh	property already exists
 EFh	invalid name
 F0h	wildcard not allowed
 F1h	invalid bindery security level
 F6h	not permitted to delete properties
 F7h	not permitted to create properties
 FBh	no such property
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure
SeeAlso: #1185,#1195

Format of NetWare "Create Property" request buffer:
Offset	Size	Description	(Table 1192)
 00h	WORD	length of following data (max 45h)
 02h	BYTE	39h (subfunction "Create Property")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
	BYTE	property flags
	BYTE	property security levels
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property's name
SeeAlso: #1193

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1193)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1190,#1193,#1194
--------N-21E3--SF3A-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - DELETE PROPERTY
	AH = E3h subfn 3Ah
	DS:SI -> request buffer (see #1194)
	ES:DI -> reply buffer (see #1193)
Return: AL = status (see #1191)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=39h,AX=F217h/SF=3Ah

Format of NetWare "Delete Property" request buffer:
Offset	Size	Description	(Table 1194)
 00h	WORD	length of following data (max 43h)
 02h	BYTE	3Ah (subfunction "Delete Property")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property's name
SeeAlso: #1193
--------N-21E3--SF3B-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CHANGE PROPERTY SECURITY
	AH = E3h subfn 3Bh
	DS:SI -> request buffer (see #1196)
	ES:DI -> reply buffer (see #1193)
Return: AL = status (see #1195)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=38h,AX=F217h/SF=3Bh

(Table 1195)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 F0h	wildcard not allowed
 F1h	invalid bindery security level
 FBh	no such property
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure
SeeAlso: #1191,#1199

Format of NetWare "Change Property Security" request buffer:
Offset	Size	Description	(Table 1196)
 00h	WORD	length of following data (max 44h)
 02h	BYTE	3Bh (subfunction "Change Property Security")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	new property security levels
	BYTE	length of property's name
      N BYTEs	property name
Note:	the object type may not be WILD (FFFFh)
--------N-21E3--SF3C-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - SCAN PROPERTY
	AH = E3h subfn 3Ch
	DS:SI -> request buffer (see #1197)
	ES:DI -> reply buffer (see #1198)
Return: AL = status (00h,96h,F1h,FBh,FCh,FEh,FFh) (see #1195)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=37h,AH=E3h/SF=3Bh,AX=F217h/SF=3Ch

Format of NetWare "Scan Property" request buffer:
Offset	Size	Description	(Table 1197)
 00h	WORD	length of following data (max 47h)
 02h	BYTE	3Ch (subfunction "Scan Property")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	DWORD	(big-endian) sequence number
		FFFFFFFFh for first call
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property's name
SeeAlso: #1198,#1447

Format of NetWare "Scan Property" reply buffer:
Offset	Size	Description	(Table 1198)
 00h	WORD	(call) 0018h (length of following results buffer)
 02h 16 BYTEs	property name
 12h	BYTE	property flags
 13h	BYTE	property security levels
 14h	DWORD	(big-endian) sequence number
 18h	BYTE	property value flag (00h no, FFh yes)
 19h	BYTE	more properties (00h no, FFh yes)
SeeAlso: #1197,#1447
--------N-21E3--SF3D-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - READ PROPERTY VALUE
	AH = E3h subfn 3Dh
	DS:SI -> request buffer (see #1200)
	ES:DI -> reply buffer (see #1201)
Return: AL = status (see #1199)
Desc:	retrieve one 128-byte segment of the specified property's value
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=39h,AH=E3h/SF=3Ch,AH=E3h/SF=3Eh,AX=F217h/SF=3Dh

(Table 1199)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 E8h	not item property
 ECh	no such segment
 F0h	wildcard not allowed
 F1h	invalid bindery security level
 F8h	not permitted to write property
 F9h	not permitted to read property
 FBh	no such property
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure
SeeAlso: #1195,#1204

Format of NetWare "Read Property Value" request buffer:
Offset	Size	Description	(Table 1200)
 00h	WORD	length of following data (max 44h)
 02h	BYTE	3Dh (subfunction "Read Property Value")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	segment number (01h on first call, increment until done)
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property name
SeeAlso: #1201,#1448

Format of NetWare "Read Property Value" reply buffer:
Offset	Size	Description	(Table 1201)
 00h	WORD	(call) 0082h (length of following results buffer)
 02h 128 BYTEs	property's value
 82h	BYTE	more segments (00h no, FFh yes)
 83h	BYTE	property's flags
SeeAlso: #1200,#1448
--------N-21E3--SF3E-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - WRITE PROPERTY VALUE
	AH = E3h subfn 3Eh
	DS:SI -> request buffer (see #1202)
	ES:DI -> reply buffer (see #1203)
Return: AL = status (see #1199)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=39h,AH=E3h/SF=3Ch,AH=E3h/SF=3Dh,AX=F217h/SF=3Eh

Format of NetWare "Write Property Value" request buffer:
Offset	Size	Description	(Table 1202)
 00h	WORD	length of following data (max C5h)
 02h	BYTE	3Eh (subfunction "Write Property Value")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	segment number (01h on first call, increment until done)
	BYTE	erase remaining segments (00h no, FFh yes)
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property name
    128 BYTEs	property value segment
SeeAlso: #1203

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1203)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1202,#1205
--------N-21E3--SF3F-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - VERIFY BINDERY OBJECT PASSWORD
	AH = E3h subfn 3Fh
	DS:SI -> request buffer (see #1205)
	ES:DI -> reply buffer (see #1203)
Return: AL = status (see #1204)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=40h,AX=F217h/SF=3Fh

(Table 1204)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 F0h	wildcard not allowed
 FBh	no such property
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure: no such object, bad password, no password for object,
	  or invalid old password
SeeAlso: #1199,#1208

Format of NetWare "Verify Bindery Object Password" request buffer:
Offset	Size	Description	(Table 1205)
 00h	WORD	length of following data (max 133h)
 02h	BYTE	3Fh (subfunction "Verify Bindery Object Password")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	length of password (00h-7Fh)
      N BYTEs	password
SeeAlso: #1203
--------N-21E3--SF40-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CHANGE BINDERY OBJECT PASSWORD
	AH = E3h subfn 40h
	DS:SI -> request buffer (see #1206)
	ES:DI -> reply buffer (see #1207)
Return: AL = status (see #1204)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=3Fh,AH=E3h/SF=41h,AX=F217h/SF=40h

Format of NetWare "Change Bindery Object Password" request buffer:
Offset	Size	Description	(Table 1206)
 00h	WORD	length of following data (max 133h)
 02h	BYTE	40h (subfunction "Change Bindery Object Password")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	length of old password (00h-7Fh)
      N BYTEs	old password
	BYTE	length of new password (00h-7Fh)
      N BYTEs	new password
SeeAlso: #1207,#1455

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1207)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1206,#1209
--------N-21E3--SF41-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - ADD BINDERY OBJECT TO SET
	AH = E3h subfn 41h
	DS:SI -> request buffer (see #1209)
	ES:DI -> reply buffer (see #1207)
Return: AL = status (see #1208)
Desc:	add the specified object to an object's group property
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=40h,AH=E3h/SF=42h,AH=E3h/SF=43h,AX=F217h/SF=41h

(Table 1208)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 E9h	member already exists
 EAh	member does not exist
 EBh	not a group property
 F0h	wildcard not allowed
 F8h	can't write property
 F9h	not permitted to read property
 FBh	no such property
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure
SeeAlso: #1204,#1219

Format of NetWare "Add Bindery Object to Set" request buffer:
Offset	Size	Description	(Table 1209)
 00h	WORD	length of following data (max 75h)
 02h	BYTE	41h (subfunction "Add Bindery Object to Set")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name
 06h  N BYTEs	object name
	BYTE	length of property name (01h-0Fh)
      N BYTEs	property name
	WORD	(big-endian) type of member object
	BYTE	length of member object's name
      N BYTEs	member object's name
SeeAlso: #1207
--------N-21E3--SF42-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - DELETE BINDERY OBJECT FROM SET
	AH = E3h subfn 42h
	DS:SI -> request buffer (see #1210)
	ES:DI -> reply buffer (see #1211)
Return: AL = status (see #1208)
Desc:	delete the specified object from a set property
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=40h,AH=E3h/SF=42h,AH=E3h/SF=43h,AX=F217h/SF=42h

Format of NetWare "Delete Bindery Object from Set" request buffer:
Offset	Size	Description	(Table 1210)
 00h	WORD	length of following data (max 75h)
 02h	BYTE	42h (subfunction "Delete Bindery Object from Set")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name
 06h  N BYTEs	object name
	BYTE	length of property name (01h-0Fh)
      N BYTEs	property name
	WORD	(big-endian) type of member object
	BYTE	length of member object's name
      N BYTEs	member object's name
SeeAlso: #1211

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1211)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1210,#1212,#1213,#1214
--------N-21E3--SF43-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - IS BINDERY OBJECT IN SET
	AH = E3h subfn 43h
	DS:SI -> request buffer (see #1212)
	ES:DI -> reply buffer (see #1211)
Return: AL = status (see #1208)
Desc:	determine whether the specified object is a member of the given set
	  property
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the caller must have read access to the property
SeeAlso: AH=E3h/SF=41h,AH=E3h/SF=42h,AX=F217h/SF=43h

Format of NetWare "Is Bindery Object in Set?" request buffer:
Offset	Size	Description	(Table 1212)
 00h	WORD	length of following data (max 75h)
 02h	BYTE	43h (subfunction "Is Bindery Object In Set")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name
 06h  N BYTEs	object's name
	BYTE	length of property's name
      N BYTEs	property's name
	WORD	(big-endian) type of member object
	BYTE	length of member object's name
      N BYTEs	member object's name
SeeAlso: #1211
--------N-21E3--SF44-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CLOSE BINDERY
	AH = E3h subfn 44h
	DS:SI -> request buffer (see #1213)
	ES:DI -> reply buffer (see #1211)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=45h,AX=F217h/SF=44h

Format of NetWare "Close Bindery" request buffer:
Offset	Size	Description	(Table 1213)
 00h	WORD	0001h (length of following data)
 02h	BYTE	44h (subfunction "Close Bindery")
SeeAlso: #1211,#1214
--------N-21E3--SF45-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - OPEN BINDERY
	AH = E3h subfn 45h
	DS:SI -> request buffer (see #1214)
	ES:DI -> reply buffer (see #1211)
Return: AL = status
	    00h successful
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the bindery may only be opened by the supervisor or an object with
	  equivalent privileges
SeeAlso: AH=E3h/SF=44h,AX=F217h/SF=45h

Format of NetWare "Open Bindery" request buffer:
Offset	Size	Description	(Table 1214)
 00h	WORD	0001h (length of following data)
 02h	BYTE	45h (subfunction "Open Bindery")
SeeAlso: #1211,#1213
--------N-21E3--SF46-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - GET BINDERY ACCESS LEVEL
	AH = E3h subfn 46h
	DS:SI -> request buffer (see #1215)
	ES:DI -> reply buffer (see #1216)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AX=F217h/SF=46h

Format of NetWare "Get Bindery Access Level" request buffer:
Offset	Size	Description	(Table 1215)
 00h	WORD	0001h (length of following data)
 02h	BYTE	46h (subfunction "Get Bindery Access Level")
SeeAlso: #1216,#1449

Format of NetWare "Get Bindery Access Level" reply buffer:
Offset	Size	Description	(Table 1216)
 00h	WORD	0005h (length of following buffer)
 02h	BYTE	security levels
 03h	DWORD	(big-endian) object ID
SeeAlso: #1215,#1449
--------N-21E3--SF47-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - SCAN BINDERY OBJ TRUSTEE PATHS
	AH = E3h subfn 47h
	DS:SI -> request buffer (see #1217)
	ES:DI -> reply buffer (see #1218)
Return: AL = status (00h,96h,F0h,F1h,FCh,FEh,FFh) (see #1219)
Desc:	iterate through the directories to which an object is a trustee
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E2h/SF=0Ch,AH=E2h/SF=0Dh,AH=E2h/SF=0Eh,AX=F217h/SF=47h

Format of NetWare "Scan Bindery Object Trustee Paths" request buffer:
Offset	Size	Description	(Table 1217)
 00h	WORD	0008h (length of following data)
 02h	BYTE	47h (subfunction "Scan Bindery Object Trustee Paths")
 03h	BYTE	volume number (00h-1Fh)
 04h	WORD	(big-endian) last sequence number (FFFFh on first call)
 06h	DWORD	(big-endian) object ID
SeeAlso: #1218,#1450

Format of NetWare "Scan Bindery Object Trustee Paths" reply buffer:
Offset	Size	Description	(Table 1218)
 00h	WORD	(call) length of following results buffer (max 107h)
 02h	WORD	(big-endian) next sequence number
 04h	DWORD	(big-endian) object ID
 08h	BYTE	trustee directory rights (see #1107 at AH=E2h/SF=03h)
 09h	BYTE	length of trustee path
 0Ah  N BYTEs	trustee path
SeeAlso: #1217,#1450
--------N-21E3--SF64-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CREATE QUEUE
	AH = E3h subfn 64h
	DS:SI -> request buffer (see #1220)
	ES:DI -> reply buffer (see #1221)
Return: AL = status (00h,96h,99h,9Bh,9Ch,EDh-F1h,F5h,F7h,FCh,FEh,FFh)
	      (see #1219)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation with supervisor privileges
SeeAlso: AH=E3h/SF=65h,AH=E3h/SF=66h,AH=E3h/SF=68h,AH=E3h/SF=6Bh
SeeAlso: AX=F217h/SF=64h

(Table 1219)
Values for NetWare function status:
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
 D8h	queue not active
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
SeeAlso: #1208,#1260,#2045 at INT 2F/AX=7A20h/BX=0000h

Format of NetWare "Create Queue" request buffer:
Offset	Size	Description	(Table 1220)
 00h	WORD	length of following data (max ABh)
 02h	BYTE	64h (subfunction "Create Queue")
 03h	WORD	(big-endian) queue type
 05h	BYTE	length of queue's name (01h-2Fh)
 06h  N BYTEs	queue's name
	BYTE	directory handle or 00h
	BYTE	length of path name (01h-76h)
      N BYTEs	path name of directory in which to create queue subdirectory
SeeAlso: #1221,#1458

Format of NetWare "Create Queue" reply buffer:
Offset	Size	Description	(Table 1221)
 00h	WORD	(call) 0004h (size of following results buffer)
 02h	DWORD	(big-endian) object ID of queue
SeeAlso: #1220,#1458
--------N-21E3--SF65-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - DESTROY QUEUE
	AH = E3h subfn 65h
	DS:SI -> request buffer (see #1222)
	ES:DI -> reply buffer (see #1227)
Return: AL = status (00h,96h,9Ch,D0h,D1h,FFh) (see also AH=E3h/SF=64h)
	    FFh hardware failure
Desc:	abort all active jobs, detach all job servers, remove all job entries,
	  delete all job files, remove the queue object and its properties
	  from the bindery, and delete the queue's subdirectory
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must have SUPERVISOR privileges
SeeAlso: AH=E3h/SF=64h,AH=E3h/SF=66h,AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=70h
SeeAlso: AX=F217h/SF=65h

Format of NetWare "Destroy Queue" request buffer:
Offset	Size	Description	(Table 1222)
 00h	WORD	0005h (length of following data)
 02h	BYTE	65h (subfunction "Destroy Queue")
 03h	DWORD	(big-endian) object ID of queue
SeeAlso: #1227
--------N-21E3--SF66-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - READ QUEUE CURRENT STATUS (OLD)
	AH = E3h subfn 66h
	DS:SI -> request buffer (see #1223)
	ES:DI -> reply buffer (see #1224)
Return: AL = status (00h,96h,9Ch,D1h-D3h,F1h,FCh,FEh,FFh) (see #1219)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USERS or Q_OPERATORS properties
SeeAlso: AH=E3h/SF=64h,AH=E3h/SF=67h,AH=E3h/SF=6Fh,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=66h

Format of NetWare "Read Queue Current Status (old)" request buffer:
Offset	Size	Description	(Table 1223)
 00h	WORD	0005h (length of following data)
 02h	BYTE	66h (subfunction "Read Queue Current Status")
 03h	DWORD	(big-endian) object ID of queue
SeeAlso: #1224,#1459 at AX=F217h/SF=66h

Format of NetWare "Read Queue Current Status (old)" reply buffer:
Offset	Size	Description	(Table 1224)
 00h	WORD	(call) 0085h (size of following results)
 02h	DWORD	(big-endian) object ID of queue
 06h	BYTE	status of queue (see #1225)
 07h	BYTE	number of jobs in queue (00h-FAh)
 08h	BYTE	number of servers attached to queue (00h-19h)
 09h 25 DWORDs	list of object IDs of attached servers
 6Dh 25 BYTEs	list of attached servers' stations
 86h	BYTE	(call) maximum number of servers to return
SeeAlso: #1223,#1459 at AX=F217h/SF=66h

Bitfields for NetWare queue status:
Bit(s)	Description	(Table 1225)
 0	operator disabled addition of new jobs
 1	operator refuses additional job servers attaching
 2	operator disabled job servicing
SeeAlso: #1224,#1226
--------N-21E3--SF67-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - SET QUEUE CURRENT STATUS (OLD)
	AH = E3h subfn 67h
	DS:SI -> request buffer (see #1226)
	ES:DI -> reply buffer (see #1227)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D3h,FEh,FFh) (see #1219)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must have operator privileges
SeeAlso: AH=E3h/SF=64h,AH=E3h/SF=66h,AH=E3h/SF=6Fh,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=67h

Format of NetWare "Set Queue Current Status (old)" request buffer:
Offset	Size	Description	(Table 1226)
 00h	WORD	0006h (length of following data)
 02h	BYTE	67h (subfunction "Set Queue Current Status")
 03h	DWORD	(big-endian) object ID of queue
 07h	BYTE	queue status (see #1225)
SeeAlso: #1227

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1227)
 00h	WORD	(call) 0000h (no results returned)
--------N-21E3--SF68-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CREATE QUEUE JOB AND FILE
	AH = E3h subfn 68h
	DS:SI -> request buffer (see #1228)
	ES:DI -> reply buffer (see #1230)
Return: AL = status (00h,96h,99h,9Ch,D0h-D4h,DAh,EDh,EFh-F1h,F7h,FCh,FEh,FFh)
		(see #1219)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USER property
SeeAlso: AX=B807h,AH=E0h"SPOOLING",AH=E3h/SF=69h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh
SeeAlso: AX=F217h/SF=68h

Format of NetWare "Create Queue Job and File" request buffer:
Offset	Size	Description	(Table 1228)
 00h	WORD	0107h (length of following data)
 02h	BYTE	68h (subfunction "Close File and Start Queue Job")
 03h	DWORD	(big-endian) object ID of queue
 07h 256 BYTEs	job structure (see #1229)
SeeAlso: #1230,#1460

Format of NetWare old-style job structure:
Offset	Size	Description	(Table 1229)
 00h	BYTE	client station
 01h	BYTE	client task number
 02h	DWORD	(big-endian) object ID of client
 06h	DWORD	(big-endian) object ID of target server
		FFFFFFFh if any server acceptable
 0Ah  6 BYTEs	target execution time (year,month,day,hour,minute,second)
		FFFFFFFFFFFFh to execute as soon as possible
 10h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 16h	WORD	(big-endian) job number
 18h	WORD	(big-endian) job type
 1Ah	BYTE	job position
 1Bh	BYTE	job control flags (see #1238)
 1Ch 14 BYTEs	ASCIZ job file name
 2Ah  6 BYTEs	job file handle
 30h	BYTE	server station
 31h	BYTE	server task number
 32h	DWORD	(big-endian) object ID of server
 36h 50 BYTEs	ASCIZ job description string
 68h 152 BYTEs	client record area
SeeAlso: #1228,#1470

Format of NetWare "Create Queue Job and File" reply buffer:
Offset	Size	Description	(Table 1230)
 00h	WORD	(call) 0036h (size of following results buffer)
 02h	BYTE	client station
 03h	BYTE	client task number
 04h	DWORD	(big-endian) object ID of client
 08h	DWORD	(big-endian) object ID of target server
 0Ch  6 BYTEs	target execution time (year,month,day,hour,minute,second)
 12h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 18h	WORD	(big-endian) job number
 1Ah	WORD	(big-endian) job type
 1Ch	BYTE	job position
 1Dh	BYTE	job control flags (see #1238)
 1Eh 14 BYTEs	ASCIZ job file name
 2Ch  6 BYTEs	job file handle
 32h	BYTE	server station
 33h	BYTE	server task number
 34h	DWORD	(big-endian) object ID of server or 00000000h
SeeAlso: #1228,#1460
--------N-21E3--SF69-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CLOSE FILE AND START QUEUE JOB (OLD)
	AH = E3h subfn 69h
	DS:SI -> request buffer (see #1231)
	ES:DI -> reply buffer (see #1232)
Return: AL = status (00h,96h,D0h,D1h,D3h,D5h,D6h,FEh,FFh) (see #1219)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on the workstation which created the job
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh,AX=F217h/SF=69h

Format of NetWare "Close File and Start Queue Job (old)" request buffer:
Offset	Size	Description	(Table 1231)
 00h	WORD	0007h (length of following data)
 02h	BYTE	69h (subfunction "Close File and Start Queue Job")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
SeeAlso: #1232

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1232)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1231,#1233
--------N-21E3--SF6A-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - REMOVE JOB FROM QUEUE (OLD)
	AH = E3h subfn 6Ah
	DS:SI -> request buffer (see #1233)
	ES:DI -> reply buffer (see #1232)
Return: AL = status (00h,96h,D0h,D1h,D5h,D6h,FEh,FFh) (see #1219)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must have created the job or be an operator
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh,AX=F217h/SF=6Ah

Format of NetWare "Remove Job From Queue (old)" request buffer:
Offset	Size	Description	(Table 1233)
 00h	WORD	0007h (length of following data)
 02h	BYTE	6Ah (subfunction "Remove Job From Queue (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
--------N-21E3--SF6B-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - GET QUEUE JOB LIST (OLD)
	AH = E3h subfn 6Bh
	DS:SI -> request buffer (see #1234)
	ES:DI -> reply buffer (see #1235)
Return: AL = status (00h,96h,9Ch,D0h-D3h,FCh,FEh,FFh) (see #1219)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the Q_USERS or Q_OPERATORS properties
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh,AX=F217h/SF=6Bh

Format of NetWare "Get Queue Job List (old)" request buffer:
Offset	Size	Description	(Table 1234)
 00h	WORD	0005h (length of following data)
 02h	BYTE	6Bh (subfunction "Get Queue Job List (old)")
 03h	DWORD	(big-endian) object ID of queue
SeeAlso: #1235

Format of NetWare "Get Queue Job List (old)" reply buffer:
Offset	Size	Description	(Table 1235)
 00h	WORD	(call) size of following results buffer (max 1F6h)
 02h	WORD	(big-endian) job count
 04h  N WORDs	(big-endian) list of job numbers by position in queue
	WORD	maximum job numbers
SeeAlso: #1234
--------N-21E3--SF6C-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - READ QUEUE JOB ENTRY (OLD)
	AH = E3h subfn 6Ch
	DS:SI -> request buffer (see #1236)
	ES:DI -> reply buffer (see #1237)
Return: AL = status (00h,96h,D0h-D3h,D5h,FCh,FEh,FFh) (see #1219)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the Q_USERS, Q_OPERATORS, or Q_SERVERS properties
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh,AX=F217h/SF=6Ch

Format of NetWare "Read Queue Job Entry (old)" request buffer:
Offset	Size	Description	(Table 1236)
 00h	WORD	0007h (length of following data)
 02h	BYTE	6Ch (subfunction "Read Queue Job Entry (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
SeeAlso: #1237

Format of NetWare "Read Queue Job Entry (old)" reply buffer:
Offset	Size	Description	(Table 1237)
 00h	WORD	(call) 0100h (size of following results)
 02h	BYTE	client station number
 03h	BYTE	client task number
 04h	DWORD	object ID of client
 08h	DWORD	(big-endian) object ID of target server
		FFFFFFFFh if any server acceptable
 0Ch  6 BYTEs	target execution time (year,month,day,hour,minute,second)
		FFFFFFFFFFFFh if serviced as soon as possible
 12h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 18h	WORD	(big-endian) job number
 1Ah	WORD	(big-endian) job type
 1Ch	BYTE	job position
 1Dh	BYTE	job control flags (see #1238)
 1Eh 14 BYTEs	ASCIZ job filename
 2Ch  6 BYTEs	job file handle
 32h	BYTE	server station
 33h	BYTE	server task number
 34h	DWORD	object ID of server
 38h 50 BYTEs	ASCIZ job description string
 6Ah 152 BYTEs	client record area
SeeAlso: #1236

Bitfields for NetWare job control flags:
Bit(s)	Description	(Table 1238)
 3	job will be serviced automatically if connection broken
 4	job remains in queue after server aborts job
 5	client has not filled associated job file
 6	User Hold--job advances, but cannot be serviced until this is
	  cleared by user or operator
 7	Operator Hold--job advances, but cannot be serviced until this is
	  cleared by an operator
SeeAlso: #1237
--------N-21E3--SF6D-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CHANGE QUEUE JOB ENTRY (OLD)
	AH = E3h subfn 6Dh
	DS:SI -> request buffer (see #1239)
	ES:DI -> reply buffer (see #1241)
Return: AL = status (00h,96h,D0h,D1h,D5h,D7h,FEh,FFh) (see #1219)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be an operator or the user who created the job
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Ch,AH=E3h/SF=6Eh
SeeAlso: AX=F217h/SF=6Dh

Format of NetWare "Change Queue Job Entry" request buffer:
Offset	Size	Description	(Table 1239)
 00h	WORD	0105h (length of following data)
 02h	BYTE	6Dh (subfunction "Change Queue Job Entry")
 03h	DWORD	(big-endian) object ID of queue
 07h 256 BYTEs	job structure (see #1229)
SeeAlso: #1241
--------N-21E3--SF6E-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CHANGE QUEUE JOB POSITION
	AH = E3h subfn 6Eh
	DS:SI -> request buffer (see #1240)
	ES:DI -> reply buffer (see #1241)
Return: AL = status (00h,96h,D0h,D1h,D5h,D6h,FEh,FFh) (see #1219)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be an operator
	if the specified position is greater than the number of jobs in the
	  queue, the job is placed at the end of the queue
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Ch,AH=E3h/SF=6Dh
SeeAlso: AX=F217h/SF=6Eh

Format of NetWare "Change Queue Job Position" request buffer:
Offset	Size	Description	(Table 1240)
 00h	WORD	0008h (length of following data)
 02h	BYTE	6Eh (subfunction "Change Queue Job Position")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
 09h	BYTE	new position in queue
		(01h = first, FAh [250] = last position in full queue)
SeeAlso: #1241

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1241)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1239,#1240,#1242
--------N-21E3--SF6F-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - ATTACH QUEUE SERVER TO QUEUE
	AH = E3h subfn 6Fh
	DS:SI -> request buffer (see #1242)
	ES:DI -> reply buffer (see #1241)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D3h,DAh,DBh,FEh,FFh)
		(see also AH=E3h/SF=64h)
	    FFh bindery failure, or no such property, or no such member
Desc:	attach the calling job server to the specified queue
Notes:	this function is supported by Advanced NetWare 2.1+
	a queue may have up to 25 job servers attached
	the calling workstation must be security-equivalent to a member of the
	  queue's Q_SERVERS property
SeeAlso: AH=E3h/SF=70h,AH=E3h/SF=71h,AH=E3h/SF=72h,AH=E3h/SF=73h,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=6Fh

Format of NetWare "Attach Queue Server to Queue" request buffer:
Offset	Size	Description	(Table 1242)
 00h	WORD	0005h (length of following data)
 02h	BYTE	6Fh (subfunction "Attach Queue Server To Queue")
 03h	DWORD	(big-endian) object ID of queue
SeeAlso: #1241,#1243
--------N-21E3--SF70-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - DETACH QUEUE SERVER FROM QUEUE
	AH = E3h subfn 70h
	DS:SI -> request buffer (see #1243)
	ES:DI -> reply buffer (see #1241)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D2h,FEh,FFh) (see #1219)
Desc:	remove the calling job server from the specified queue's list of
	  servers
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must have previously attached itself to the queue
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=72h,AH=E3h/SF=73h,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=70h

Format of NetWare "Detach Queue Server From Queue" request buffer:
Offset	Size	Description	(Table 1243)
 00h	WORD	0005h (length of following data)
 02h	BYTE	70h (subfunction "Detach Queue Server From Queue")
 03h	DWORD	(big-endian) object ID of queue
SeeAlso: #1241,#1242
--------N-21E3--SF71-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - SERVICE QUEUE JOB AND OPEN FILE
	AH = E3h subfn 71h
	DS:SI -> request buffer (see #1244)
	ES:DI -> reply buffer (see #1230)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D3h,D5h,D9h,DAh,FEh,FFh)
		(see #1219)
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USERS, Q_OPERATORS, or Q_SERVERS properties
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=72h,AH=E3h/SF=73h,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=71h

Format of NetWare "Service Queue Job and Open File" request buffer:
Offset	Size	Description	(Table 1244)
 00h	WORD	0007h (length of following data)
 02h	BYTE	71h (subfunction "Service Queue Job and Open File")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) target job type
		FFFFh any
SeeAlso: #1230,#1245
--------N-21E3--SF72-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - FINISH SERVICING QUEUE JOB AND FILE
	AH = E3h subfn 72h
	DS:SI -> request buffer (see #1245)
	ES:DI -> reply buffer (see #1247)
Return: AL = status (00h,96h,D0h,D1h,D6h) (see #1219)
Desc:	inform the Queue Management System (QMS) that the queue server has
	  completed a job
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must be a job server which has previously obtained a job
	  for servicing
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=71h,AH=E3h/SF=73h,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=72h

Format of NetWare "Finish Servicing Queue Job and File (old)" request buffer:
Offset	Size	Description	(Table 1245)
 00h	WORD	000Bh (length of following data)
 02h	BYTE	72h (subfunction "Finish Servicing Queue Job and File (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
 09h	DWORD	(big-endian) charge
SeeAlso: #1247,#1244,#1256
--------N-21E3--SF73-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - ABORT SERVICING QUEUE JOB AND FILE
	AH = E3h subfn 73h
	DS:SI -> request buffer (see #1246)
	ES:DI -> reply buffer (see #1247)
Return: AL = status (00h,96h,D0h,D1h,D6h,D9h) (see #1219)
Desc:	inform the Queue Management System (QMS) that the queue server is
	  unable to service a previously-accepted job
Notes:	this function is supported by Advanced NetWare 2.1+
	this is an old version of the call (see AH=E3h/SF=84h)
	only a job server which previously accepted a job for servicing may
	  call this function
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=71h,AH=E3h/SF=72h,AH=E3h/SF=76h,AH=E3h/SF=84h
SeeAlso: AX=F217h/SF=73h

Format of NetWare "Abort Servicing Queue Job and File (old)" request buffer:
Offset	Size	Description	(Table 1246)
 00h	WORD	0007h (length of following data)
 02h	BYTE	73h (subfunction "Abort Servicing Queue Job and File (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
SeeAlso: #1247,#1245

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1247)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1245,#1246,#1248,#1249
--------N-21E3--SF74-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CHANGE TO CLIENT RIGHTS (OLD)
	AH = E3h subfn 74h
	DS:SI -> request buffer (see #1248)
	ES:DI -> reply buffer (see #1247)
Return: AL = status (00h,96h,D0h,D1h,D5h,D9h) (see #1219)
Desc:	temporarily assume the login identity of the client submitting the
	  job being serviced
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be a job server which has obtained a job for servicing
SeeAlso: AH=E3h/SF=75h,AX=F217h/SF=74h

Format of NetWare "Change to Client Rights (old)" request buffer:
Offset	Size	Description	(Table 1248)
 00h	WORD	0007h (length of following data)
 02h	BYTE	74h (subfunction "Change To Client Rights (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
SeeAlso: #1247,#1249
--------N-21E3--SF75-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - RESTORE QUEUE SERVER RIGHTS
	AH = E3h subfn 75h
	DS:SI -> request buffer (see #1249)
	ES:DI -> reply buffer (see #1247)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D3h,D5h,D9h,DAh,FEh,FFh) (see #1219)
Desc:	restore server's own identity after assuming the login identity of the
	  client submitting the job being serviced
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be a job server which has previously changed its identity
SeeAlso: AH=E3h/SF=74h,AX=F217h/SF=75h

Format of NetWare "Restore Queue Server Rights" request buffer:
Offset	Size	Description	(Table 1249)
 00h	WORD	0001h (length of following data)
 02h	BYTE	75h (subfunction "Change To Client Rights")
SeeAlso: #1247,#1248
--------N-21E3--SF76-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - READ QUEUE SERVER CURRENT STATUS OLD
	AH = E3h subfn 76h
	DS:SI -> request buffer (see #1250)
	ES:DI -> reply buffer (see #1251)
Return: AL = status (00h,96h,9Ch,D1h-D3h,F1h,FCh,FEh,FFh) (see #1219)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the Q_USERS or Q_OPERATORS properties
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ch,AH=E3h/SF=6Fh,AH=E3h/SF=77h,AH=E3h/SF=78h
SeeAlso: AX=F217h/SF=76h

Format of NetWare "Read Queue Server Current Status (old)" request buffer:
Offset	Size	Description	(Table 1250)
 00h	WORD	000Ah (length of following data)
 02h	BYTE	76h (subfunction "Read Queue Server Current Status (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	DWORD	(big-endian) object ID of server
 0Bh	BYTE	server station
SeeAlso: #1251

Format of NetWare "Read Queue Server Current Status (old)" reply buffer:
Offset	Size	Description	(Table 1251)
 00h	WORD	(call) 0040h (size of following results)
 02h 64 BYTEs	server status record (format depends on server)
		first four bytes should contain estimated "price" for an
		  average job
SeeAlso: #1250,#1463
--------N-21E3--SF77-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - SET QUEUE SERVER CURRENT STATUS
	AH = E3h subfn 77h
	DS:SI -> request buffer (see #1252)
	ES:DI -> reply buffer (see #1253)
Return: AL = status (00h,96h,9Ch,D0h,D1h,FEh,FFh) (see #1219)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be a job server which has attached itself to the queue
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ch,AH=E3h/SF=6Fh,AH=E3h/SF=76h,AH=E3h/SF=78h
SeeAlso: AX=F217h/SF=77h

Format of NetWare "Set Queue Server Current Status" request buffer:
Offset	Size	Description	(Table 1252)
 00h	WORD	0045h (length of following data)
 02h	BYTE	77h (subfunction "Set Queue Server Current Status")
 03h	DWORD	(big-endian) object ID of queue
 07h 64 BYTEs	server status record (format depends on server)
		first four bytes should contain estimated "price" for an
		  average job
SeeAlso: #1253

Format of NetWare "Set Queue Server Current Status" reply buffer:
Offset	Size	Description	(Table 1253)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1252
--------N-21E3--SF78-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - GET QUEUE JOB'S FILE SIZE (OLD)
	AH = E3h subfn 78h
	DS:SI -> request buffer (see #1254)
	ES:DI -> reply buffer (see #1255)
Return: AL = status (see also #1219)
	    00h successful
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USERS, Q_OPERATORS, or Q_SERVERS properties
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ch,AH=E3h/SF=71h,AX=F217h/SF=78h

Format of NetWare "Get Queue Job's File Size (old)" request buffer:
Offset	Size	Description	(Table 1254)
 00h	WORD	0007h (length of following data)
 02h	BYTE	78h (subfunction "Get Queue Job's File Size (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
SeeAlso: #1255,#1464 at AX=F217h/SF=78h

Format of NetWare "Get Queue Job's File Size (old)" reply buffer:
Offset	Size	Description	(Table 1255)
 00h	WORD	(call) 000Ah (size of following results)
 02h	DWORD	(big-endian) object ID of queue
 06h	WORD	(big-endian) job number
 08h	DWORD	(big-endian) size of job file in bytes
SeeAlso: #1254,#1464 at AX=F217h/SF=78h
--------N-21E3--SF83-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - FINISH SERVICING QUEUE JOB
	AH = E3h subfn 83h
	DS:SI -> request buffer (see #1256)
	ES:DI -> reply buffer (see #1257)
Return: AL = status (00h,96h,D0h,D1h,D6h,D9h) (see #1219)
Desc:	inform the Queue Management System (QMS) that the queue server has
	 completed servicing a previously-accepted job
Notes:	this function is supported by Advanced NetWare 3.1+
	this variant of Abort Servicing Queue Job allows use of the high
	  connection byte in the NCP packet header, unlike AH=E3h/SF=73h
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=71h,AH=E3h/SF=72h,AH=E3h/SF=73h,AH=E3h/SF=84h
SeeAlso: AX=F217h/SF=83h

Format of NetWare "Finish Servicing Queue Job" request buffer:
Offset	Size	Description	(Table 1256)
 00h	WORD	0007h (length of following data)
 02h	BYTE	84h (subfunction "Abort Servicing Queue Job")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
 09h	DWORD	(big-endian) charge for job
SeeAlso: #1257,#1245

Format of NetWare "Finish Servicing Queue Job" reply buffer:
Offset	Size	Description	(Table 1257)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1256
--------N-21E3--SF84-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - ABORT SERVICING QUEUE JOB
	AH = E3h subfn 84h
	DS:SI -> request buffer (see #1258)
	ES:DI -> reply buffer (see #1259)
Return: AL = status (00h,96h,D0h,D1h,D6h,D9h) (see #1219)
Desc:	inform the Queue Management System (QMS) that the queue server is
	  unable to service a previously-accepted job
Notes:	this function is supported by Advanced NetWare 3.1+
	this variant of Abort Servicing Queue Job allows use of the high
	  connection byte in the NCP packet header, unlike AH=E3h/SF=73h
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=71h,AH=E3h/SF=72h,AH=E3h/SF=73h,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=84h

Format of NetWare "Abort Servicing Queue Job" request buffer:
Offset	Size	Description	(Table 1258)
 00h	WORD	0007h (length of following data)
 02h	BYTE	84h (subfunction "Abort Servicing Queue Job")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
SeeAlso: #1259

Format of NetWare "Abort Servicing Queue Job" reply buffer:
Offset	Size	Description	(Table 1259)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1258
--------N-21E3--SF96-------------------------
INT 21 - Novell NetWare - ACCOUNTING SERVICES - GET ACCOUNT STATUS
	AH = E3h subfn 96h
	DS:SI -> request buffer (see #1261)
	ES:DI -> reply buffer (see #1262)
Return: AL = status (00h,C0h,C1h) (see #1260)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=97h,AH=E3h/SF=98h,AH=E3h/SF=99h,AX=F217h/SF=96h

(Table 1260)
Values for NetWare function status:
 00h	successful
 C0h	no account privileges
 C1h	no account balance
 C2h	credit limit exceeded
 C3h	too many holds on account
SeeAlso: #1219,#1270

Format of NetWare "Get Account Status" request buffer:
Offset	Size	Description	(Table 1261)
 00h	WORD	length of following data (max 33h)
 02h	BYTE	96h (subfunction "Get Account Status")
 03h	WORD	(big-endian) type of bindery object
 05h	BYTE	length of object name (01h to 2Fh)
 06h  N BYTEs	object name
SeeAlso: #1262,#1484 at AX=F217h/SF=96h

Format of NetWare "Get Account Status" reply buffer:
Offset	Size	Description	(Table 1262)
 00h	WORD	(call) length of following buffer space
 02h	DWORD	(big-endian) account balance
 06h	DWORD	(big-endian) credit limit
		signed number indicating lowest allowable account balance
 0Ah 120 BYTEs	reserved
 82h	DWORD	(big-endian) object ID, server 1
 86h	DWORD	(big-endian) hold amount, server 1
	...
 F8h	DWORD	(big-endian) object ID, server 16
 FCh	DWORD	(big-endian) hold amount, server 16
Note:	the reply buffer lists the servers which have placed holds on a portion
	  of the account balance, and the amount reserved by each
SeeAlso: #1261,#1484 at AX=F217h/SF=96h
--------N-21E3--SF97-------------------------
INT 21 - Novell NetWare - ACCOUNTING SERVICES - SUBMIT ACCOUNT CHARGE
	AH = E3h subfn 97h
	DS:SI -> request buffer (see #1263)
	ES:DI -> reply buffer (see #1265)
Return: AL = status (00h,C0h-C2h) (see #1260)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=96h,AH=E3h/SF=98h,AX=F217h/SF=97h

Format of NetWare "Submit Account Charge" request buffer:
Offset	Size	Description	(Table 1263)
 00h	WORD	length of following data (max 13Fh)
 02h	BYTE	97h (subfunction "Submit Account Charge")
 03h	WORD	(big-endian) service type
 05h	DWORD	(big-endian) amount to be charged to account
 09h	DWORD	(big-endian) amount of prior hold to be cancelled
 0Dh	WORD	(big-endian) type of bindery object
 0Fh	WORD	(big-endian) type of comment
		8000h-FFFFh reserved for experimental use
 11h	BYTE	length of object's name
 12h  N BYTEs	object name
	BYTE	length of comment
      N BYTEs	comment
SeeAlso: #1265
--------N-21E3--SF98-------------------------
INT 21 - Novell NetWare - ACCOUNTING SERVICES - SUBMIT ACCOUNT HOLD
	AH = E3h subfn 98h
	DS:SI -> request buffer (see #1264)
	ES:DI -> reply buffer (see #1265)
Return: AL = status (00h,C0h-C3h) (see #1260)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=96h,AH=E3h/SF=97h,AX=F217h/SF=98h

Format of NetWare "Submit Account Hold" request buffer:
Offset	Size	Description	(Table 1264)
 00h	WORD	length of following data (max 37h)
 02h	BYTE	98h (subfunction "Submit Account Hold")
 03h	DWORD	(big-endian) amount of account balance to reserve
 07h	WORD	(big-endian) type of bindery object
 09h	BYTE	length of object's name
 0Ah  N BYTEs	object name
SeeAlso: #1265

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1265)
 00h	WORD	0000h (no data returned)
SeeAlso: #1263,#1264,#1266,#1267
--------N-21E3--SF99-------------------------
INT 21 - Novell NetWare - ACCOUNTING SERVICES - SUBMIT ACCOUNT NOTE
	AH = E3h subfn 99h
	DS:SI -> request buffer (see #1266)
	ES:DI -> reply buffer (see #1265)
Return: AL = status (00h,C0h) (see #1260)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=96h,AX=F217h/SF=99h

Format of NetWare "Submit Account Note" request buffer:
Offset	Size	Description	(Table 1266)
 00h	WORD	length of following data (max 137h)
 02h	BYTE	99h (subfunction "Submit Account Note")
 03h	WORD	(big-endian) type of service
 05h	WORD	(big-endian) type of bindery object
 07h	WORD	(big-endian) type of comment
		8000h-FFFFh reserved for experimental use
 09h	BYTE	length of object's name
 0Ah  N BYTEs	object name
	BYTE	length of comment
      N BYTEs	comment
SeeAlso: #1265
--------N-21E3--SFC8-------------------------
INT 21 - Novell NetWare - FILE SERVER - CHECK CONSOLE PRIVILEGES
	AH = E3h subfn C8h
	DS:SI -> request buffer (see #1267)
	ES:DI -> reply buffer (see #1265)
Return: AL = status (00h,C6h) (see #1270)
Desc:	determine whether the caller is a console operator
Notes:	this function is supported by Advanced NetWare 2.1+
	NetWare determines console privileges by checking the file server's
	  OPERATOR property for the caller's object ID
SeeAlso: AH=E3h/SF=C9h,AH=E3h/SF=D1h,AX=F217h/SF=C8h

Format of NetWare "Check Console Privileges" request buffer:
Offset	Size	Description	(Table 1267)
 00h	WORD	0001h (length of following data)
 02h	BYTE	C8h (subfunction "Check Console Privileges")
SeeAlso: #1265
--------N-21E3--SFC9-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER DESCRIPTION STRINGS
	AH = E3h subfn C9h
	DS:SI -> request buffer (see #1268)
	ES:DI -> reply buffer (see #1269)
Return: AL = status
	    00h successful
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must be attached to the file server
SeeAlso: AH=E3h/SF=11h,AH=E3h/SF=CDh,AH=E3h/SF=E8h,AX=F217h/SF=C9h

Format of NetWare "Get File Server Description Strings" request buffer:
Offset	Size	Description	(Table 1268)
 00h	WORD	0001h (length of following data)
 02h	BYTE	C9h (subfunction "Get File Server Description Strings")
SeeAlso: #1269,#1485 at AX=F217h/SF=C9h

Format of NetWare "Get File Server Description Strings" reply buffer:
Offset	Size	Description	(Table 1269)
 00h	WORD	(call) 0200h (size of following results buffer)
 02h	var	ASCIZ name of company distributing this copy of NetWare
	var	ASCIZ version and revision
      9 BYTEs	ASCIZ revision date (mm/dd/yy)
	var	ASCIZ copyright notice
SeeAlso: #1268,#1485 at AX=F217h/SF=C9h
--------N-21E3--SFCA-------------------------
INT 21 - Novell NetWare - FILE SERVER - SET FILE SERVER DATE AND TIME
	AH = E3h subfn CAh
	DS:SI -> request buffer (see #1271)
	ES:DI -> reply buffer (see #1273)
Return: AL = status (00h,C6h) (see #1270)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=2Bh,AH=2Dh,AH=E3h/SF=C8h,AH=E7h,AX=F217h/SF=CAh,AX=F214h

(Table 1270)
Values for NetWare function status:
 00h	successful
 C6h	no console rights
SeeAlso: #1260,#1284

Format of NetWare "Set File Server Date and Time" request buffer:
Offset	Size	Description	(Table 1271)
 00h	WORD	0007h (length of following data)
 02h	BYTE	CAh (subfunction "Set File Server Date And Time")
 03h	BYTE	year (00-79 = 2000-2079, 80-99 = 1980-1999)
 04h	BYTE	month (1-12)
 05h	BYTE	day (1-31)
 06h	BYTE	hour (0-23)
 07h	BYTE	minute
 08h	BYTE	second
SeeAlso: #1273,#1366 at AX=F214h
--------N-21E3--SFCB-------------------------
INT 21 - Novell NetWare - FILE SERVER - DISABLE FILE SERVER LOGIN
	AH = E3h subfn CBh
	DS:SI -> request buffer (see #1272)
	ES:DI -> reply buffer (see #1273)
Return: AL = status (00h,C6h) (see #1270)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CCh,AH=E3h/SF=D3h,AX=F217h/SF=CBh

Format of NetWare "Disable File Server Login" request buffer:
Offset	Size	Description	(Table 1272)
 00h	WORD	0001h (length of following data)
 02h	BYTE	CBh (subfunction "Disable File Server Login")
SeeAlso: #1273,#1274

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1273)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1271,#1272,#1274
--------N-21E3--SFCC-------------------------
INT 21 - Novell NetWare - FILE SERVER - ENABLE FILE SERVER LOGIN
	AH = E3h subfn CCh
	DS:SI -> request buffer (see #1274)
	ES:DI -> reply buffer (see #1273)
Return: AL = status (00h,C6h) (see #1270)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CBh,AX=F217h/SF=CCh

Format of NetWare "Enable File Server Login" request buffer:
Offset	Size	Description	(Table 1274)
 00h	WORD	0001h (length of following data)
 02h	BYTE	CCh (subfunction "Enable File Server Login")
SeeAlso: #1273
--------N-21E3--SFCD-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER LOGIN STATUS
	AH = E3h subfn CDh
	DS:SI -> request buffer (see #1275)
	ES:DI -> reply buffer (see #1276)
Return: AL = status (00h,C6h) (see #1270)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CBh,AH=E3h/SF=CCh

Format of NetWare "Get File Server Login Status" request buffer:
Offset	Size	Description	(Table 1275)
 00h	WORD	0001h (length of following data)
 02h	BYTE	CDh (subfunction "Get File Server Login Status")
SeeAlso: #1276,#1486 at AX=F217h/SF=CDh

Format of NetWare "Get File Server Login Status" reply buffer:
Offset	Size	Description	(Table 1276)
 00h	WORD	(call) 0001h (size of following results buffer)
 02h	BYTE	login state (00h disabled, 01h enabled)
SeeAlso: #1275,#1486 at AX=F217h/SF=CDh
--------N-21E3--SFCE-------------------------
INT 21 - Novell NetWare - FILE SERVICES - PURGE ALL ERASED FILES
	AH = E3h subfn CEh
	DS:SI -> request buffer (see #1277)
	ES:DI -> reply buffer (see #1279)
Return: AL = status (00h,C6h) (see #1270)
Desc:	all files marked for deletion on the file server are purged, regardless
	  of which workstation actually erased them
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	the calling workstation must have console operator privileges
SeeAlso: AH=13h,AH=E2h/SF=10h,AH=E3h/SF=C8h,AX=F217h/SF=CEh,AX=F244h

Format of NetWare "Purge All Erased Files" request buffer:
Offset	Size	Description	(Table 1277)
 00h	WORD	0001h (length of following data)
 02h	BYTE	CEh (subfunction "Purge All Erased Files")
SeeAlso: #1279
--------N-21E3--SFCF-------------------------
INT 21 - Novell NetWare - FILE SERVER - DISABLE TRANSACTION TRACKING
	AH = E3h subfn CFh
	DS:SI -> request buffer (see #1278)
	ES:DI -> reply buffer (see #1279)
Return: AL = status (00h,C6h) (see #1270)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D0h

Format of NetWare "Disable Transaction Tracking" request buffer:
Offset	Size	Description	(Table 1278)
 00h	WORD	0001h (length of following data)
 02h	BYTE	CFh (subfunction "Disable Transaction Tracking")
SeeAlso: #1279,#1280

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1279)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1277,#1278,#1280
--------N-21E3--SFD0-------------------------
INT 21 - Novell NetWare - FILE SERVER - ENABLE TRANSACTION TRACKING
	AH = E3h subfn D0h
	DS:SI -> request buffer (see #1280)
	ES:DI -> reply buffer (see #1279)
Return: AL = status (00h,C6h) (see #1284)
Desc:	restart transaction tracking after being stopped either explicitly by
	  AH=E3h/SF=CFh or automatically due to a full transaction volume
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CFh,AX=F217h/SF=D0h

Format of NetWare "Enable Transaction Tracking" request buffer:
Offset	Size	Description	(Table 1280)
 00h	WORD	0001h (length of following data)
 02h	BYTE	D0h (subfunction "Enable Transaction Tracking")
SeeAlso: #1279,#1278
--------N-21E3--SFD1-------------------------
INT 21 - Novell NetWare - FILE SERVER - SEND CONSOLE BROADCAST
	AH = E3h subfn D1h
	DS:SI -> request buffer (see #1281)
	ES:DI -> reply buffer (see #1283)
Return: AL = status (00h,C6h) (see #1284)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
	the broadcast message will not be received by workstations which have
	  disabled broadcasts with AH=E1h/SF=02h
SeeAlso: AH=E1h/SF=02h,AH=E1h/SF=09h,AH=E3h/SF=C8h,AH=E3h/SF=D3h
SeeAlso: AX=F217h/SF=D1h

Format of NetWare "Send Console Broadcast" request buffer:
Offset	Size	Description	(Table 1281)
 00h	WORD	length of following data (max A2h)
 02h	BYTE	D1h (subfunction "Send Console Broadcast")
 03h	BYTE	number of connections to receive message
		00h = all, else specific list below
 04h  N BYTEs	connection list
	BYTE	length of message (max 3Ch)
      N BYTEs	message
SeeAlso: #1283
--------N-21E3--SFD2-------------------------
INT 21 - Novell NetWare - FILE SERVER - CLEAR CONNECTION NUMBER
	AH = E3h subfn D2h
	DS:SI -> request buffer (see #1282)
	ES:DI -> reply buffer (see #1283)
Return: AL = status (00h,C6h) (see #1284)
Desc:	close the open files and release all file locks for a connection,
	  abort transactions if a TTS file server, and detach from the file
	  server
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must have SUPERVISOR privileges
SeeAlso: AH=E3h/SF=C9h,AH=E3h/SF=D1h,AX=F217h/SF=D2h,AX=F217h/SF=FEh

Format of NetWare "Clear Connection Number" request buffer:
Offset	Size	Description	(Table 1282)
 00h	WORD	0002h (length of following data)
 02h	BYTE	D2h (subfunction "Clear Connection Number")
 03h	BYTE	connection number
SeeAlso: #1283,#1537

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1283)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1281,#1282,#1285
--------N-21E3--SFD3-------------------------
INT 21 - Novell NetWare - FILE SERVER - DOWN FILE SERVER
	AH = E3h subfn D3h
	DS:SI -> request buffer (see #1285)
	ES:DI -> reply buffer (see #1283)
Return: AL = status (00h,C6h,FFh) (see #1284)
Desc:	take down the file server
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have SUPERVISOR privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CBh,AH=E3h/SF=CFh,AH=E3h/SF=D1h

(Table 1284)
Values for NetWare function status:
 00h	successful
 C6h	no console rights
 FFh	files open
SeeAlso: #1270,#1312

Format of NetWare "Down File Server" request buffer:
Offset	Size	Description	(Table 1285)
 00h	WORD	0002h (length of following data)
 02h	BYTE	D3h (subfunction "Down File Server")
 03h	BYTE	flag: force down even if files open if nonzero
SeeAlso: #1283
--------N-21E3--SFD4-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SYSTEM STATISTICS
	AH = E3h subfn D4h
	DS:SI -> request buffer (see #1286)
	ES:DI -> reply buffer (see #1287)
Return: AL = status (00h,C6h) (see #1284)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=0Eh,AH=E3h/SF=C8h,AH=E3h/SF=D9h,AH=E3h/SF=E7h,AH=E3h/SF=E8h
SeeAlso: AX=F217h/SF=D4h

Format of NetWare "Get File System Statistics" request buffer:
Offset	Size	Description	(Table 1286)
 00h	WORD	0001h (length of following data)
 02h	BYTE	D4h (subfunction "Get File System Statistics")
SeeAlso: #1287,#1487 at AX=F217h/SF=D4h

Format of NetWare "Get File System Statistics" reply buffer:
Offset	Size	Description	(Table 1287)
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
SeeAlso: #1286,#1487 at AX=F217h/SF=D4h
--------N-21E3--SFD5-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET TRANSACTION TRACKING STATISTICS
	AH = E3h subfn D5h
	DS:SI -> request buffer (see #1288)
	ES:DI -> reply buffer (see #1289)
Return: AL = status (00h,C6h) (see #1284)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CFh,AH=E3h/SF=D0h,AH=E3h/SF=E8h
SeeAlso: AX=F217h/SF=D5h

Format of NetWare "Get Transaction Tracking Statistics" request buffer:
Offset	Size	Description	(Table 1288)
 00h	WORD	0001h (length of following data)
 02h	BYTE	D5h (subfunction "TTS Get Statistics")
SeeAlso: #1289,#1488 at AX=F217h/SF=D5h

Format of NetWare "Get Transaction Tracking Statistics" reply buffer:
Offset	Size	Description	(Table 1289)
 00h	WORD	(call) length of following results buffer (max 1BCh)
 02h	DWORD	(big-endian) clock ticks since system started
 06h	BYTE	transaction tracking supported if nonzero
		(all following fields are invalid if zero)
 07h	BYTE	transaction tracking enabled
 08h	WORD	(big-endian) transaction volume number
 0Ah	WORD	(big-endian) maximum simultaneous transactions configured
 0Ch	WORD	(big-endian) maximum simultaneous transactions since startup
 0Eh	WORD	(big-endian) current transactions in progress
 10h	DWORD	(big-endian) total transactions performed
 14h	DWORD	(big-endian) total write transactions
 18h	DWORD	(big-endian) total transactions backed out
 1Ch	WORD	(big-endian) number of unfilled backout requests
 1Eh	WORD	(big-endian) disk blocks used for transaction tracking
 20h	DWORD	(big-endian) blocks allocated for tracked-file FATs
 24h	DWORD	(big-endian) number of file size changes during a transaction
 28h	DWORD	(big-endian) number of file truncations during a transaction
 2Ch	BYTE	number of records following
 2Dh	Active Transaction Records [array]
	Offset	Size	Description
	 00h	BYTE	logical connection number
	 01h	BYTE	task number
SeeAlso: #1288,#1488 at AX=F217h/SF=D5h
--------N-21E3--SFD6-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET DISK CACHE STATISTICS
	AH = E3h subfn D6h
	DS:SI -> request buffer (see #1290)
	ES:DI -> reply buffer (see #1291)
Return: AL = status (00h,C6h) (see #1284)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D5h,AH=E3h/SF=D8h,AH=E3h/SF=D9h,AH=E3h/SF=E6h
SeeAlso: AX=F217h/SF=D6h

Format of NetWare "Get Disk Cache Statistics" request buffer:
Offset	Size	Description	(Table 1290)
 00h	WORD	0001h (length of following data)
 02h	BYTE	D6h (subfunction "Get Disk Cache Statistics")
SeeAlso: #1291,#1489 at AX=F217h/SF=D6h

Format of NetWare "Get Disk Cache Statistics" reply buffer:
Offset	Size	Description	(Table 1291)
 00h	WORD	(call) 004Eh (length of following results buffer)
 02h	DWORD	clock ticks since system started
 06h	WORD	number of cache buffers
 08h	WORD	size of cache buffer in bytes
 0Ah	WORD	number of dirty cache buffers
 0Ch	DWORD	number of cache read requests
 10h	DWORD	number of cache write requests
 14h	DWORD	number of cache hits
 18h	DWORD	number of cache misses
 1Ch	DWORD	number of physical read requests
 20h	DWORD	number of physical write requests
 24h	WORD	number of physical read errors
 26h	WORD	number of physical write errors
 28h	DWORD	cache get requests
 2Ch	DWORD	cache full write requests
 30h	DWORD	cache partial write requests
 34h	DWORD	background dirty writes
 38h	DWORD	background aged writes
 3Ch	DWORD	total cache writes
 40h	DWORD	number of cache allocations
 44h	WORD	thrashing count
 46h	WORD	number of times LRU block was dirty
 48h	WORD	number of reads on cache blocks not yet filled by writes
 4Ah	WORD	number of times a fragmented write occurred
 4Ch	WORD	number of cache hits on unavailable block
 4Eh	WORD	number of times a cache block was scrapped
Note:	all fields except the first are big-endian
SeeAlso: #1290,#1489 at AX=F217h/SF=D6h
--------N-21E3--SFD7-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET DRIVE MAPPING TABLE
	AH = E3h subfn D7h
	DS:SI -> request buffer (see #1292)
	ES:DI -> reply buffer (see #1293)
Return: AL = status (00h,C6h) (see #1284)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D6h,AH=E3h/SF=D9h,AH=E3h/SF=E6h,AH=E3h/SF=E9h
SeeAlso: AX=F217h/SF=D7h

Format of NetWare "Get Drive Mapping Table" request buffer:
Offset	Size	Description	(Table 1292)
 00h	WORD	0001h (length of following data)
 02h	BYTE	D7h (subfunction "Get Drive Mapping Table")
SeeAlso: #1293,#1490 at AX=F217h/SF=D7h

Format of NetWare "Get Drive Mapping Table" reply buffer:
Offset	Size	Description	(Table 1293)
 00h	WORD	(call) 00ECh (length of following results buffer)
 02h	DWORD	(big-endian) clock tick elapsed since system started
 06h	BYTE	fault tolerance (SFT) level
 07h	BYTE	number of logical drives attached to server
 08h	BYTE	number of physical drives attached to server
 09h  5 BYTEs	disk channel types (00h none, 01h XT, 02h AT, 03h SCSI,
		  04h disk coprocessor drive, 32h-FFh value-added drive types)
 0Eh	WORD	(big-endian) number of outstanding controller commands
 10h 32 BYTEs	drive mapping table (FFh = no such drive)
 30h 32 BYTEs	drive mirror table (secondary physical drive, FFh = none)
 50h 32 BYTEs	dead mirror table (last drive mapped to, FFh if never mirrored)
 70h	BYTE	physical drive being remirrored (FFh = none)
 71h	BYTE	reserved
 72h	DWORD	(big-endian) remirrored block
 76h 60 BYTEs	SFT error table (internal error counters)
SeeAlso: #1292,#1490 at AX=F217h/SF=D7h
--------N-21E3--SFD8-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET PHYSICAL DISK STATISTICS
	AH = E3h subfn D8h
	DS:SI -> request buffer (see #1294)
	ES:DI -> reply buffer (see #1295)
Return: AL = status (00h,C6h) (see #1284)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D9h,AH=E3h/SF=E9h,AX=F217h/SF=D8h

Format of NetWare "Get Physical Disk Statistics" request buffer:
Offset	Size	Description	(Table 1294)
 00h	WORD	0002h (length of following data)
 02h	BYTE	D8h (subfunction "Get Physical Disk Statistics")
 03h	BYTE	physical disk number
SeeAlso: #1295,#1491 at AX=F217h/SF=D8h

Format of NetWare "Get Physical Disk Statistics" reply buffer:
Offset	Size	Description	(Table 1295)
 00h	WORD	(call) 005Dh (size of following results record)
 02h	DWORD	(big-endian) clock ticks since system started
 06h	BYTE	physical disk channel
 07h	BYTE	flag: drive removable if nonzero
 08h	BYTE	physical drive type
 09h	BYTE	drive number within controller
 0Ah	BYTE	controller number
 0Bh	BYTE	controller type
 0Ch	DWORD	(big-endian) size of drive in 4K disk blocks
 10h	WORD	(big-endian) number of cylinders on drive
 12h	BYTE	number of heads
 13h	BYTE	number of sectors per track
 14h 64 BYTEs	ASCIZ drive make and model
 54h	WORD	(big-endian) number of I/O errors
 56h	DWORD	(big-endian) start of Hot Fix table
 5Ah	WORD	(big-endian) size of Hot Fix table
 5Ch	WORD	(big-endian) number of Hot Fix blocks available
 5Eh	BYTE	flag: Hot Fix disabled if nonzero
SeeAlso: #1294,#1491 at AX=F217h/SF=D8h
--------N-21E3--SFD9-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET DISK CHANNEL STATISTICS
	AH = E3h subfn D9h
	DS:SI -> request buffer (see #1296)
	ES:DI -> reply buffer (see #1297)
Return: AL = status (00h,C6h) (see #1284)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D8h,AH=E3h/SF=E6h,AH=E3h/SF=E9h
SeeAlso: AX=F217h/SF=D9h

Format of NetWare "Get Disk Channel Statistics" request buffer:
Offset	Size	Description	(Table 1296)
 00h	WORD	0002h (length of following data)
 02h	BYTE	D9h (subfunction "Get Disk Channel Statistics")
 03h	BYTE	channel number
SeeAlso: #1297,#1492 at AX=F217h/SF=D9h

Format of NetWare "Get Disk Channel Statistics" reply buffer:
Offset	Size	Description	(Table 1297)
 00h	WORD	(call) 00A8h (size of following results record)
 02h	DWORD	(big-endian) clock ticks since system started
 06h	WORD	(big-endian) channel run state (see #1298)
 08h	WORD	(big-endian) channel synchronization state (see #1299)
 0Ah	BYTE	driver type
 0Bh	BYTE	major version of driver
 0Ch	BYTE	minor version of driver
 0Dh 65 BYTEs	ASCIZ driver description
 4Eh	WORD	(big-endian) first I/O address used
 50h	WORD	(big-endian) length of first I/O address
 52h	WORD	(big-endian) second I/O address used
 54h	WORD	(big-endian) length of second I/O address
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
SeeAlso: #1296,#1492 at AX=F217h/SF=D9h

(Table 1298)
Values for channel run state:
 0000h	running
 0001h	being stopped
 0002h	stopped
 0003h	nonfunctional
SeeAlso: #1297,#1299

(Table 1299)
Values for channel synchronization state:
 0000h	not in use
 0002h	used by NetWare, no other requests
 0004h	used by NetWare, other requests
 0006h	in use, not needed by NetWare
 0008h	in use, needed by NetWare
 000Ah	channel released, NetWare should use it
SeeAlso: #1297,#1298
--------N-21E3--SFDA-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTION'S TASK INFORMATION
	AH = E3h subfn DAh
	DS:SI -> request buffer (see #1300)
	ES:DI -> reply buffer (see #1301)
Return: AL = status (00h,C6h) (see #1312)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DBh,AH=E3h/SF=DFh,AH=E3h/SF=E1h,AH=E3h/SF=E5h
SeeAlso: AX=F217h/SF=DAh

Format of NetWare "Get Connection's Task Information" request buffer:
Offset	Size	Description	(Table 1300)
 00h	WORD	0003h (length of following data)
 02h	BYTE	DAh (subfunction "Get Connection's Task Information")
 03h	WORD	(big-endian) logical connection number
SeeAlso: #1301,#1493 at AX=F217h/SF=DAh

Format of NetWare "Get Connection's Task Information" reply buffer:
Offset	Size	Description	(Table 1301)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	BYTE	lock status of connection (see #1302)
 03h	var	Lock Status Information (see #1303)
 N	BYTE	number of records following
 N+1	Active Task Information Records [array]
	Offset	Size	Description
	 00h	BYTE	task number (01h-FFh)
	 01h	BYTE	task state
			01h in TTS explicit transaction
			02h in TTS implicit transaction
			04h shared fileset lock active
SeeAlso: #1300,#1493 at AX=F217h/SF=DAh

(Table 1302)
Values for lock status of connection:
 00h	no locks
 01h	waiting on physical record lock
 02h	waiting on file lock
 03h	waiting on logical record lock
 04h	waiting on semaphore
SeeAlso: #1301,#1303

Format of Lock Status Information:
Offset	Size	Description	(Table 1303)
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
SeeAlso: #1301,#1302
--------N-21E3--SFDB-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTION'S OPEN FILES (OLD)
	AH = E3h subfn DBh
	DS:SI -> request buffer (see #1304)
	ES:DI -> reply buffer (see #1305)
Return: AL = status (00h,C6h) (see #1312)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E2h/SF=1Ah,AH=E3h/SF=C8h,AH=E3h/SF=DAh,AH=E3h/SF=DCh,AH=E3h/SF=DFh
SeeAlso: AH=E3h/SF=E1h,AX=F217h/SF=DBh

Format of NetWare "Get Connection's Open Files (old)" request buffer:
Offset	Size	Description	(Table 1304)
 00h	WORD	0005h (length of following data)
 02h	BYTE	DBh (subfunction "Get Connection's Open Files")
 03h	WORD	(big-endian) logical connection number
 05h	WORD	(big-endian) last record seen (0000h on first call)
SeeAlso: #1305,#1494 at AX=F217h/SF=DBh

Format of NetWare "Get Connection's Open Files (old)" reply buffer:
Offset	Size	Description	(Table 1305)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" field on next call)
		0000h if no more records
 04h	BYTE	number of records following
 05h	var	array of File Information Records (see #1306)
SeeAlso: #1304,#1494 at AX=F217h/SF=DBh

Format of NetWare File Information Record:
Offset	Size	Description	(Table 1306)
 00h	BYTE	task number
 01h	BYTE	lock flags (see #1307)
 02h	BYTE	access flags (see #1308)
 03h	BYTE	lock type
		00h no lock
		FEh file lock
		FFh locked by Begin Share File Set
 04h	BYTE	volume number (00h-1Fh)
 05h	WORD	(big-endian) directory entry
 07h 14 BYTEs	ASCIZ filename
SeeAlso: #1305

Bitfields for lock flags:
Bit(s)	Description	(Table 1307)
 0	file is locked
 1	file opened Shareable
 2	logged
 3	file opened Normal
 6	TTS holding lock
 7	Transaction Flag set on file
SeeAlso: #1306,#1308

Bitfields for access flags:
Bit(s)	Description	(Table 1308)
 0	file open for reading by calling station
 1	file open for writing by calling station
 2	deny reads by other stations
 3	deny writes by other stations
 4	file detached
 5	TTS Holding Detach
 6	TTS Holding Open
SeeAlso: #1306,#1307
--------N-21E3--SFDC-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTIONS USING A FILE
	AH = E3h subfn DCh
	DS:SI -> request buffer (see #1309)
	ES:DI -> reply buffer (see #1310)
Return: AL = status (00h,C6h) (see #1312)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DAh,AH=E3h/SF=DBh,AH=E3h/SF=DFh,AH=E3h/SF=E1h
SeeAlso: AX=F217h/SF=DCh

Format of NetWare "Get Connections Using a File" request buffer:
Offset	Size	Description	(Table 1309)
 00h	WORD	length of following data (max 104h)
 02h	BYTE	DCh (subfunction "Get Connections Using a File")
 03h	WORD	(big-endian) last record (0000h on first call)
 05h	BYTE	directory handle
 06h	BYTE	length of file path
 07h  N BYTEs	ASCIZ file path
SeeAlso: #1310,#1495 at AX=F217h/SF=DCh

Format of NetWare "Get Connections Using a File" reply buffer:
Offset	Size	Description	(Table 1310)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	(big-endian) count of tasks which have opened or logged file
 04h	WORD	(big-endian) count of tasks which have opened file
 06h	WORD	(big-endian) count of opens for reading
 08h	WORD	(big-endian) count of opens for writing
 0Ah	WORD	(big-endian) deny read count
 0Ch	WORD	(big-endian) deny write count
 0Eh	WORD	next request record (place in "last record" field on next call)
		0000h if no more records
 10h	BYTE	locked flag
		00h not locked exclusively
		else locked exclusively
 11h	BYTE	number of records following
 12h	var	array of File Usage Information Records (see #1311)
SeeAlso: #1309,#1495 at AX=F217h/SF=DCh

Format of NetWare File Usage Information Record:
Offset	Size	Description	(Table 1311)
 00h	WORD	(big-endian) logical connection number
 02h	BYTE	task number
 03h	BYTE	lock flags (see #1307)
 04h	BYTE	access flags (see #1308)
 05h	BYTE	lock type
		00h no lock
		FEh file lock
		FFh locked by Begin Share File Set
--------N-21E3--SFDD-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET PHYSICAL RECORD LOCKS BY CONN&FILE
	AH = E3h subfn DDh
	DS:SI -> request buffer (see #1313)
	ES:DI -> reply buffer (see #1314)
Return: AL = status (00h,C6h,FFh) (see #1312)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DEh,AH=E3h/SF=DFh,AX=F217h/SF=DDh

(Table 1312)
Values for NetWare function status:
 00h	successful
 C6h	no console rights
 FFh	file not open
SeeAlso: #1284,#1334

Format of NetWare "Get Phys Record Locks by Conn and File" request buffer:
Offset	Size	Description	(Table 1313)
 00h	WORD	0016h (length of following data)
 02h	BYTE	DDh (subfunction "Get Physical Record Locks by Connection and
		  File")
 03h	WORD	(big-endian) logical connection number
 05h	WORD	(big-endian) last record seen (0000h on first call)
 07h	BYTE	volume number (00h-1Fh)
 08h	WORD	(big-endian) directory handle
 0Ah 14 BYTEs	ASCIZ filename
SeeAlso: #1314,#1496 at AX=F217h/SF=DDh

Format of NetWare "Get Phys Record Locks by Conn and File" reply buffer:
Offset	Size	Description	(Table 1314)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" on next call)
		0000h if no more records
 04h	BYTE	number of physical record locks
 05h	BYTE	number of records following
 06h	var	array of Physical Record Lock Info records (see #1315)
SeeAlso: #1313,#1496 at AX=F217h/SF=DDh

Format of NetWare Physical Record Lock Info:
Offset	Size	Description	(Table 1315)
 00h	BYTE	task number
 01h	BYTE	lock status (see #1316)
 02h	DWORD	(big-endian) starting offset of record in file
 06h	DWORD	(big-endian) ending offset of record in file
SeeAlso: #1314

Bitfields for lock status:
Bit(s)	Description	(Table 1316)
 0	exclusive lock
 1	shareable lock
 2	logged
 6	lock held by TTS
SeeAlso: #1315
--------N-21E3--SFDE-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET PHYSICAL RECORD LOCKS BY FILE
	AH = E3h subfn DEh
	DS:SI -> request buffer (see #1317)
	ES:DI -> reply buffer (see #1318)
Return: AL = status (00h,C6h,FFh) (see #1312)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DDh,AH=E3h/SF=DFh,AX=F217h/SF=DEh

Format of NetWare "Get Physical Record Locks by File" request buffer:
Offset	Size	Description	(Table 1317)
 00h	WORD	length of following data (max 104h)
 02h	BYTE	DEh (subfunction "Get Physical Record Locks by File")
 03h	WORD	(big-endian) last record seen (0000h on first call)
 05h	BYTE	directory handle
 06h	BYTE	length of filename
 07h  N BYTEs	ASCIZ filename
SeeAlso: #1318,#1497 at AX=F217h/SF=DEh

Format of NetWare "Get Physical Record Locks by File" reply buffer:
Offset	Size	Description	(Table 1318)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" on next call)
		0000h if no more records
 04h	BYTE	number of physical record locks
 05h	BYTE	number of records following
 06h	var	array of Physical Record Lock Info records (see #1319)
SeeAlso: #1317,#1497 at AX=F217h/SF=DEh

Format of NetWare Physical Record Lock Info:
Offset	Size	Description	(Table 1319)
 00h	WORD	(big-endian) number of tasks logging record
 02h	WORD	(big-endian) number of tasks with shareable lock
 04h	DWORD	(big-endian) starting offset of record in file
 08h	DWORD	(big-endian) ending offset of record in file
 0Ch	WORD	(big-endian) logical connection number
 0Eh	BYTE	task number
 0Fh	BYTE	lock type
		00h none
		FEh file lock
		FFh Begin Share File Set lock
SeeAlso: #1318
--------N-21E3--SFDF-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET LOGICAL RECORDS BY CONNECTION
	AH = E3h subfn DFh
	DS:SI -> request buffer (see #1320)
	ES:DI -> reply buffer (see #1321)
Return: AL = status (00h,C6h) (see #1312)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DDh,AH=E3h/SF=E0h,AH=E3h/SF=E2h
SeeAlso: AX=F217h/SF=DFh

Format of NetWare "Get Logical Records by Connection" request buffer:
Offset	Size	Description	(Table 1320)
 00h	WORD	0005h (length of following data)
 02h	BYTE	DFh (subfunction "Get Logical Records By Connection")
 03h	WORD	(big-endian) logical connection number
 05h	WORD	(big-endian) last record seen (0000h on first call)
SeeAlso: #1321,#1498 at AX=F217h/SF=DFh

Format of NetWare "Get Logical Records by Connection" reply buffer:
Offset	Size	Description	(Table 1321)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" field on next call)
		0000h if no more locked records
 04h	BYTE	number of records following
 05h	var	array of Logical Lock Information Records (see #1322)
SeeAlso: #1320,#1498 at AX=F217h/SF=DFh

Format of NetWare Logical Lock Information Record:
Offset	Size	Description	(Table 1322)
 00h	BYTE	task number
 01h	BYTE	lock status (see #1316)
 02h	BYTE	length of logical lock's name
 03h  N BYTEs	logical lock's name
SeeAlso: #1321
--------N-21E3--SFE0-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET LOGICAL RECORD INFORMATION
	AH = E3h subfn E0h
	DS:SI -> request buffer (see #1323)
	ES:DI -> reply buffer (see #1324)
Return: AL = status (00h,C6h) (see #1312)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DDh,AH=E3h/SF=DFh,AH=E3h/SF=E2h
SeeAlso: AX=F217h/SF=E0h

Format of NetWare "Get Logical Record Information" request buffer:
Offset	Size	Description	(Table 1323)
 00h	WORD	length of following data (max 67h)
 02h	BYTE	E0h (subfunction "Get Logical Record Information")
 03h	WORD	(big-endian) last record seen (0000h on first call)
 05h	BYTE	length of logical record's name
 06h  N BYTEs	logical record's name
SeeAlso: #1324,#1499 at AH=E3h/SF=E0h

Format of NetWare "Get Logical Record Information" reply buffer:
Offset	Size	Description	(Table 1324)
 00h	WORD	(call) size of following results record (max 200h)
 02h	WORD	(big-endian) number of logical connections logging the record
 04h	WORD	(big-endian) number of logical connections with shareable lock
 06h	WORD	(big-endian) next request record (place in "last record" field
		  on next call)
 08h	BYTE	locked exclusively if nonzero
 09h	BYTE	number of records following
 0Ah	var	array of Task Information Records (see #1325)
SeeAlso: #1323,#1499 at AH=E3h/SF=E0h

Format of NetWare Task Information Record:
Offset	Size	Description	(Table 1325)
 00h	WORD	(big-endian) logical connection number
 02h	BYTE	task number
 03h	BYTE	lock status (see #1316)
SeeAlso: #1324
--------N-21E3--SFE1-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTION'S SEMAPHORES
	AH = E3h subfn E1h
	DS:SI -> request buffer (see #1326)
	ES:DI -> reply buffer (see #1327)
Return: AL = status (00h,C6h) (see #1312)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DBh,AH=E3h/SF=DFh,AH=E3h/SF=E2h
SeeAlso: AX=F217h/SF=E1h

Format of NetWare "Get Connection's Semaphores" request buffer:
Offset	Size	Description	(Table 1326)
 00h	WORD	0005h (length of following data)
 02h	BYTE	E1h (subfunction "Get Connection's Semaphores")
 03h	WORD	(big-endian) logical connection number
 05h	WORD	(big-endian) last record seen (0000h on first call)
SeeAlso: #1327,#1500 at AX=F217h/SF=E1h

Format of NetWare "Get Connection's Semaphores" reply buffer:
Offset	Size	Description	(Table 1327)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" field on next call)
 04h	BYTE	number of records following
 05h	var	array of Semaphore Information Records (see #1328)
SeeAlso: #1326,#1500 at AX=F217h/SF=E1h

Format of NetWare Semaphore Information Record:
Offset	Size	Description	(Table 1328)
 00h	WORD	(big-endian) open count
 02h	BYTE	semaphore value (-128 to 127)
 03h	BYTE	task number
 04h	BYTE	lock type
 05h	BYTE	length of semaphore's name
 06h  N BYTEs	semaphore's name
     14 BYTEs	filename
SeeAlso: #1327
--------N-21E3--SFE2-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET SEMAPHORE INFORMATION
	AH = E3h subfn E2h
	DS:SI -> request buffer (see #1329)
	ES:DI -> reply buffer (see #1330)
Return: AL = status (00h,C6h) (see #1334)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=E1h,AX=F217h/SF=E2h

Format of NetWare "Get Semaphore Information" request buffer:
Offset	Size	Description	(Table 1329)
 00h	WORD	length of following data (max 83h)
 02h	BYTE	E2h (subfunction "Get LAN Driver's Configuration Information")
 03h	WORD	(big-endian) last record seen (0000h on first call)
 05h	BYTE	length of semaphore's name (01h-7Fh)
 06h  N BYTEs	semaphore's name
SeeAlso: #1330,#1501 at AX=F217h/SF=E2h

Format of NetWare "Get Semaphore Information" reply buffer:
Offset	Size	Description	(Table 1330)
 00h	WORD	(call) size of following results buffer (max 1FEh)
 02h	WORD	next request record (place in "last record" on next call)
		0000h if no more
 04h	WORD	(big-endian) number of logical connections opening semaphore
 06h	BYTE	semaphore value (-127 to 128)
 07h	BYTE	number of records following
 08h	var	array of Semaphore Information records (see #1331)
SeeAlso: #1330,#1501 at AX=F217h/SF=E2h

Format of NetWare Semaphore Information:
Offset	Size	Description	(Table 1331)
 00h	WORD	(big-endian) logical connection number
 02h	BYTE	task number
SeeAlso: #1330
--------N-21E3--SFE3-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET LAN DRIVER'S CONFIGURATION INFO
	AH = E3h subfn E3h
	DS:SI -> request buffer (see #1332)
	ES:DI -> reply buffer (see #1333)
Return: AL = status (00h,C6h) (see #1334)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=E7h,AH=E3h/SF=E8h,AX=F217h/SF=E3h

Format of NetWare "Get LAN Driver's Configuration Info" request buffer:
Offset	Size	Description	(Table 1332)
 00h	WORD	0002h (length of following data)
 02h	BYTE	E3h (subfunction "Get LAN Driver's Configuration Information")
 03h	BYTE	LAN board (00h-03h)
SeeAlso: #1333,#1502 at AX=F217h/SF=E3h

Format of NetWare "Get LAN Driver's Configuration Info" reply buffer:
Offset	Size	Description	(Table 1333)
 00h	WORD	(call) 00ACh (size of following results buffer)
 02h  4 BYTEs	network number
 06h  6 BYTEs	node number
 0Ch	BYTE	LAN driver installed (00h no--remaining fields invalid)
 0Dh	BYTE	option number selected at configuration time
 0Eh 160 BYTEs	configuration text
		ASCIZ hardware type
		ASCIZ hardware settings
SeeAlso: #1332,#1502 at AX=F217h/SF=E3h
--------N-21E3--SFE5-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTION'S USAGE STATISTICS
	AH = E3h subfn E5h
	DS:SI -> request buffer (see #1335)
	ES:DI -> reply buffer (see #1336)
Return: AL = status (00h,C6h) (see #1334)
Notes:	this function is supported by Advanced NetWare 2.1+
	one must have console operator privileges to get statistics for logical
	  connections other than one's own
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DAh,AH=E3h/SF=DBh,AH=E3h/SF=E1h
SeeAlso: AX=F217h/SF=E5h

(Table 1334)
Values for NetWare function status:
 00h	successful
 C6h	no console rights
SeeAlso: #1312,#1354

Format of NetWare "Get Connection's Usage Statistics" request buffer:
Offset	Size	Description	(Table 1335)
 00h	WORD	0003h (length of following data)
 02h	BYTE	E5h (subfunction "Get Connection's Usage Statistics")
 03h	WORD	(big-endian) logical connection number
SeeAlso: #1336,#1503 at AX=F217h/SF=E5h

Format of NetWare "Get Connection's Usage Statistics" reply buffer:
Offset	Size	Description	(Table 1336)
 00h	WORD	(call) 0014h (size of following results record)
 02h	DWORD	(big-endian) clock ticks since server started
 06h  6 BYTEs	bytes read
 0Ch  6 BYTEs	bytes written
 12h	DWORD	(big-endian) total request packets
SeeAlso: #1335,#1503 at AX=F217h/SF=E5h
--------N-21E3--SFE6-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET BINDERY OBJECT DISK SPACE LEFT
	AH = E3h subfn E6h
	DS:SI -> request buffer (see #1337)
	ES:DI -> reply buffer (see #1338)
Return: AL = status (00h,C6h) (see #1334)
Notes:	this function is supported by Advanced NetWare 2.1+
	one must have console operator privileges to get the free space for
	  other bindery objects
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=E8h,AH=E3h/SF=E9h

Format of NetWare "Get Bindery Object Disk Space Left" request buffer:
Offset	Size	Description	(Table 1337)
 00h	WORD	0005h (length of following data)
 02h	BYTE	E6h (subfunction "Get Bindery Object Disk Space Left")
 03h	DWORD	(big-endian) object ID
SeeAlso: #1338,#1504 at AX=F217h/SF=E6h

Format of NetWare "Get Bindery Object Disk Space Left" reply buffer:
Offset	Size	Description	(Table 1338)
 00h	WORD	(call) 000Fh (size of following results buffer)
 02h	DWORD	(big-endian) clock ticks elapsed since server started
 06h	DWORD	(big-endian) object ID
 0Ah	DWORD	(big-endian) 4K disk blocks available to user
 0Eh	BYTE	restrictions (00h enforced, FFh not enforced)
SeeAlso: #1337,#1504 at AX=F217h/SF=E6h
--------N-21E3--SFE7-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER LAN I/O STATISTICS
	AH = E3h subfn E7h
	DS:SI -> request buffer (see #1339)
	ES:DI -> reply buffer (see #1340)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=0Eh,AH=E3h/SF=11h,AH=E3h/SF=D3h,AH=E3h/SF=E8h,AH=E7h
SeeAlso: AX=F217h/SF=E7h

Format of NetWare "Get File Server LAN I/O Statistics" request buffer:
Offset	Size	Description	(Table 1339)
 00h	WORD	0001h (length of following data)
 02h	BYTE	E7h (subfunction "Get File Server LAN I/O Statistics")
SeeAlso: #1340,#1505 at AX=F217h/SF=E7h

Format of NetWare "Get File Server LAN I/O Statistics" reply buffer:
Offset	Size	Description	(Table 1340)
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
SeeAlso: #1340,#1505 at AX=F217h/SF=E7h
--------N-21E3--SFE8-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER MISC INFORMATION
	AH = E3h subfn E8h
	DS:SI -> request buffer (see #1341)
	ES:DI -> reply buffer (see #1342)
Return: AL = status (00h,C6h) (see #1334)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=0Eh,AH=E3h/SF=11h,AH=E3h/SF=CDh,AH=E3h/SF=E7h
SeeAlso: AX=F217h/SF=E8h

Format of NetWare "Get File Server Misc Information" request buffer:
Offset	Size	Description	(Table 1341)
 00h	WORD	0001h (length of following data)
 02h	BYTE	E8h (subfunction "Get File Server Misc Information")
SeeAlso: #1342,#1506 at AX=F217h/SF=E8h

Format of NetWare "Get File Server Misc Information" reply buffer:
Offset	Size	Description	(Table 1342)
 00h	WORD	(call) size of following results buffer (max 0048h)
 02h	DWORD	(big-endian) clock ticks since system started
 06h	BYTE	CPU type
		00h Motorola 68000
		01h Intel 8086, 8088, or V20
		02h Intel 80286+
 07h	BYTE	reserved
 08h	BYTE	number of service processes in server
 09h	BYTE	server utilization in percent
 0Ah	WORD	(big-endian) maximum bindery objects set by configuration
		0000h = unlimited
 0Ch	WORD	(big-endian) maximum number of bindery objects used
 0Eh	WORD	(big-endian) current number of bindery objects in use
 10h	WORD	(big-endian) total server memory in KB
 12h	WORD	(big-endian) wasted server memory in KB
		normally 0000h
 14h	WORD	number of records following (01h-03h)
 16h	var	array of Dynamic Memory Information records (see #1343)
SeeAlso: #1341,#1506 at AX=F217h/SF=E8h

Format of NetWare Dynamic Memory Information:
Offset	Size	Description	(Table 1343)
 00h	DWORD	(big-endian) total dynamic space
 04h	DWORD	(big-endian) maximum dynamic space used
 08h	DWORD	(big-endian) current dynamic space usage
--------N-21E3--SFE9-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET VOLUME INFORMATION
	AH = E3h subfn E9h
	DS:SI -> request buffer (see #1344)
	ES:DI -> reply buffer (see #1345)
Return: AL = status
	    00h successful
Notes:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=DAh,AH=E2h/SF=15h,AX=F217h/SF=E9h

Format of NetWare "Get Volume Information" request buffer:
Offset	Size	Description	(Table 1344)
 00h	WORD	0002h (length of following data)
 02h	BYTE	E9h (subfunction "Get Volume Information")
 03h	BYTE	directory handle
SeeAlso: #1345,#1507 at AX=F217h/SF=E9h

Format of NetWare "Get Volume Information" reply buffer:
Offset	Size	Description	(Table 1345)
 00h	WORD	(call) 0028h (length of following results buffer)
 02h	DWORD	(big-endian) elapsed system time
 06h	BYTE	volume number
 07h	BYTE	logical drive number
 08h	WORD	(big-endian) sectors per block
 0Ah	WORD	(big-endian) starting block
 0Ch	WORD	(big-endian) total blocks on volume
 0Eh	WORD	(big-endian) blocks available on volume
 10h	WORD	(big-endian) total directory slots
 12h	WORD	(big-endian) directory slots available
 14h	WORD	(big-endian) maximum directory entries actually used
 16h	BYTE	flag: volume hashed if nonzero
 17h	BYTE	flag: volume cached if nonzero
 18h	BYTE	flag: volume removable if nonzero
 19h	BYTE	flag: volume mounted if nonzero
 1Ah 16 BYTEs	NUL-padded volume name
SeeAlso: #1344,#1507 at AX=F217h/SF=E9h
--------N-21E4-------------------------------
INT 21 O - Novell NetWare - SET FILE ATTRIBUTES (FCB)
	AH = E4h
	CL = file attributes (see #1346)
	DX:DX -> FCB (see #0648 at AH=0Fh)
Return: AL = error code
Note:	this function was added in NetWare 4.0, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
SeeAlso: AX=4301h

Bitfields for NetWare file attributes:
Bit(s)	Description	(Table 1346)
 0	read only
 1	hidden
 2	system
 7	shareable
--------v-21E4-------------------------------
INT 21 - VIRUS - "Anarkia" - INSTALLATION CHECK
	AH = E4h
Return: AH = 04h if resident
SeeAlso: AH=E1h"VIRUS",AH=E7h"VIRUS"
--------T-21E400-----------------------------
INT 21 - DoubleDOS - INSTALLATION CHECK/PROGRAM STATUS
	AX = E400h
Return: AL = program status
	    00h if DoubleDOS not present
	    01h if running in visible DoubleDOS partition
	    02h if running in the invisible DoubleDOS partition
SeeAlso: AH=E5h"DoubleDOS",AX=F400h
--------E-21E400-----------------------------
INT 21 - OS/286, OS/386 - CHAIN TO REAL-MODE HANDLER
	AX = E400h
	???
Return: ???
Note:	protected mode only???
--------E-21E402-----------------------------
INT 21 - OS/286, OS/386 - SET PROTECTED-MODE TASK GATE
	AX = E402h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=E403h
--------E-21E403-----------------------------
INT 21 - OS/286, OS/386 - REMOVE PROTECTED-MODE TASK GATE
	AX = E403h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=E402h
--------N-21E5-------------------------------
INT 21 O - Novell NetWare - UPDATE FILE SIZE (FCB)
	AH = E5h
	DS:DX -> FCB (see #0648 at AH=0Fh)
Return: AL = (unreliable) return code
Notes:	this function was added in NetWare 4.0, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
	on success, NetWare sets AL to zero; on errors it restores AL
--------T-21E5-------------------------------
INT 21 - DoubleDOS - OTHER PROGRAM STATUS
	AH = E5h
Return: AL = status
	    00h no program in other partition
	    01h program in other partition is running
	    02h program in other partition is suspended
SeeAlso: AX=E400h"DoubleDOS",AH=F5h"DoubleDOS"
--------E-21E500-----------------------------
INT 21 - OS/286, OS/386 - HEAP MANAGEMENT STRATEGY
	AX = E500h
	???
Return: ???
SeeAlso: AX=E501h
--------E-21E501-----------------------------
INT 21 - OS/286, OS/386 - FORCE HEAP COMPACTION
	AX = E501h
	???
Return: ???
SeeAlso: AX=E500h
--------N-21E6-------------------------------
INT 21 O - Novell NetWare - COPY FILE TO FILE (FCB)
	AH = E6h
	CX:DX = number of bytes to copy
	DS:SI -> opened source FCB
	ES:DI -> opened destination FCB
Return: AL = error code
	CX = ???
	DX = ???
Note:	this function was added in NetWare 4.0, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
--------E-21E6-------------------------------
INT 21 P - OS/286, OS/386 - ISSUE REAL PROCEDURE SIGNAL FROM PROTECTED MODE
	AH = E6h
	???
Return: ???
SeeAlso: AH=E2h"OS/286"
--------!---Section--------------------------
