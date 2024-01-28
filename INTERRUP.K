Interrupt List, part 11 of 11
This compilation is Copyright (c) 1989,1990,1991,1992,1993,1994 Ralf Brown
--------N-6B---------------------------------
INT 6B - DECnet DOS - PORT DRIVER
Note:	the installation check consists of testing for a signature area
	  (see #1971) immediately preceding the interrupt handler
SeeAlso: INT 6A"DECnet",INT 6C"DECnet"
Index:	installation check;DECnet DOS Port Driver

Format of DECnet DOS signature area:
Offset	Size	Description	(Table 1971)
 -5	BYTE	major version number
 -4	BYTE	minor version number
 -3   3 BYTEs	signature (ASCII "PDV")
--------v-6B---------------------------------
INT 6B - VIRUS - "Saddam" - ORIGINAL INT 21h VECTOR
SeeAlso: INT 21/AX=FFFFh,INT 61"VIRUS",INT 70"VIRUS"
--------S-6B0000-----------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - BUFFERED WRITE
	AX = 0000h
	CX = length
	ES:BX -> buffer
Return: CX = number of bytes written
Program: NASI is Novell's NetWare Asynchronous Services Interface (purchased
	  from Network Products Corp, who call it NCSI) which runs on
	  workstations; NACS is the NetWare Asynchronous Communications
	  Services module which runs on servers
Notes:	the installation check consists of testing for the signature string
	  "NCSI" three bytes past the interrupt handler; see also AH=02h.
	  As of version 3.0, Novell's NASI can be distinguished from NPC's
	  NCSI by the presence of an 'A' immediately following the signature
	this function is also supported by TelAPI, NPC NCSI, and Connection
	  Manager CLIENT.EXE; for TelAPI, nonzero values in AL specify a
	  connection ID
	Connection Manager returns CF set/AL=FFh if called while an INT 6B
	  call is already in progress
SeeAlso: AX=0100h,AH=18h,INT 14/AH=19h,INT 14/AH=E3h
--------S-6B0100-----------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - BUFFERED READ
	AX = 0100h
	CX = length of buffer
	ES:BX -> buffer
Return: CX = number of bytes read
Note:	also supported by TelAPI and NPC NCSI; for TelAPI, nonzero values in
	  AL specify a connection ID
SeeAlso: AX=0000h,AH=19h,INT 14/AH=18h,INT 14/AH=E2h,INT 14/AX=FF02h
--------S-6B02-------------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - INSTALL CHECK
	AH = 02h
	AL nonzero
Return: AL = 00h if present and OK
Note:	this function is also supported by TelAPI and NPC NCSI
SeeAlso: AX=0700h
--------S-6B0600-----------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - CONTROL
	AX = 0600h
	CX = command
	    02h send break
	    04h disconnect
	    06h hold
Return: CF clear if successful
	    AL = 00h
	CF set on error
	    AX < 0
Note:	this function is also supported by TelAPI and NPC NCSI
--------S-6B0700-----------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - GET STATUS
	AX = 0700h
Return: CH <> 00h if connection active
Notes:	this function is also supported by TelAPI and NPC NCSI
	Novell TelAPI returns CX=FF01h and CF clear
SeeAlso: AH=02h,AH=10h
--------N-6B08-------------------------------
INT 6B - TelAPI - ???
	AH = 08h
Return: CF clear
	    AL = 00h
	    CX = 0000h
Note:	this function also clears ??? flag
SeeAlso: INT 14/AX=FF00h
--------S-6B10-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - GET STATUS
	AH = 10h
	AL = connection ID (Novell TELAPI.EXE)
	CX = ???
Return: CF clear if successful
	    CL = ???
	    CH = ???
	CF set on error
	???
Notes:	this function is also supported by TelAPI
	when shelled out to an external protocol from Novell NASI, the circuit
	  whose status indicates that it is connected is the currently active
	  circuit
SeeAlso: AX=0700h,AH=12h,AH=1Fh
--------S-6B11--DX0001-----------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - ALLOCATE A VIRTUAL CIRCUIT
	AH = 11h
	DX = 0001h
	AL = 00h
	ES:BX -> service name string (8 characters, blank-padded)
Return: CF clear if successful
	    AL = virtual circuit number allocated (01h for Novell TELAPI.EXE)
	    CL = ??? (01h for Novell TELAPI.EXE)
	    CH = ??? (01h for Novell TELAPI.EXE)
	CF set on error
	    ???
Note:	this function is also supported by TelAPI
SeeAlso: AH=12h,AH=15h,AH=16h,AH=17h,AH=18h
--------S-6B12-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - VIRTUAL CIRCUIT STATUS
	AH = 12h
	AL = virtual circuit number
	CL = ???
	ES:BX -> ???
Return: ???
Note:	this function is also supported by TelAPI
SeeAlso: AH=10h,AH=15h,AH=1Ah,AH=1Bh,AH=1Fh
--------S-6B13-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - SET/RETRIEVE REQUEST/REPLY SERVICE NAME
	AH = 13h
	AL = virtual circuit number
	CL = direction (00h get, nonzero set)
	ES:BX -> buffer for/containing service name
Return: ???
Note:	this function is also supported by TelAPI
SeeAlso: AH=14h,AH=15h
--------S-6B14-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - SET/RETRIEVE SERVICE ADDRESS
	AH = 14h
	AL = virtual circuit number
	ES:BX -> buffer for/containing service address
Return: ???
Note:	this function is also supported by TelAPI, which only supports
	  retrieving the address
SeeAlso: AH=13h,AH=15h,AH=21h
--------S-6B15-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - SET/RETRIEVE VIRTUAL CIRCUIT CONFIG
	AH = 15h
	AL = virtual circuit number
	CL = direction (00h get, nonzero set)
	ES:BX -> buffer for/containing virtual circuit config (see #1972)
Return: ES:BX buffer filled
Note:	this function is also supported by TelAPI
SeeAlso: AH=13h"NCSI",AH=14h"NCSI"

Format of virtual circuit configuration:
Offset	Size	Description	(Table 1972)
 00h	WORD	buffer length
 02h	WORD	port ID
 04h	WORD	receive rate
 06h	WORD	receive word length
 08h	WORD	receive stop bits
 0Ah	WORD	receive parity
 0Ch	WORD	transmit rate
 0Eh	WORD	transmit word length
 10h	WORD	transmit stop bits
 12h	WORD	transmit parity
 14h	WORD	DTR
 16h	WORD	RTS
--------S-6B16-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - LOG AND/OR INITIALIZE VIRTUAL CIRCUIT
	AH = 16h
	AL = virtual circuit number
	CL = ??? switch (00h, ???)
Return: CF clear if successful
	    AL = virtual circuit number
	CF set on error
	    ???
Note:	this function is also supported by TelAPI, which always returns CF
	  clear and AL=00h
SeeAlso: AH=11h,AH=12h,AH=17h
--------S-6B17-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - DISCONNECT A VIRTUAL CIRCUIT
	AH = 17h
	AL = virtual circuit number
Return: CF clear if successful
	CF set on error
	???
Note:	this function is also supported by TelAPI, which always returns CF
	  clear and AL=00h
SeeAlso: AH=11h,AH=16h
--------S-6B18-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - WRITE DATA ON A VIRTUAL CIRCUIT
	AH = 18h
	AL = virtual circuit number
	CX = number of characters to send
	ES:BX -> buffer containing characters to be sent
Return: CF clear if successful
	CF set on error
	???
Note:	this function is also supported by TelAPI, which always returns CF
	  clear and AL=30h
SeeAlso: AX=0000h,AH=12h,AH=19h
--------S-6B19-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - READ DATA ON A VIRTUAL CIRCUIT
	AH = 19h
	AL = virtual circuit number
	CX = number of characters to read
	ES:BX -> buffer for received characters
Return: CX = 0000h if failed
	CX = nonzero (possibly number of characters received) if successful
Note:	this function is also supported by TelAPI
SeeAlso: AX=0100h,AH=12h,AH=18h
--------S-6B1A-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - RECEIVE STATUS
	AH = 1Ah
	???
Return: ???
SeeAlso: AH=12h,AH=1Bh
--------S-6B1B-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - TRANSMIT STATUS
	AH = 1Bh
	???
Return: ???
SeeAlso: AH=12h,AH=1Ah
--------S-6B1C-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - CLEAR RECEIVE BUFFER
	AH = 1Ch
	AL = circuit number
Return: nothing
SeeAlso: AH=1Dh"NCSI",AH=1Eh"NCSI"
--------S-6B1D-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - TRANSMIT BUFFER CONTROL
	AH = 1Dh
	???
Return: ???
SeeAlso: AH=1Ch,AH=1Eh
--------S-6B1E-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - ISSUE CONTROL REQUEST
	AH = 1Eh
	???
Return: ???
SeeAlso: AH=1Ch,AH=1Dh
--------S-6B1F-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - EXTERNAL STATUS
	AH = 1Fh
	???
Return: ???
SeeAlso: AH=10h,AH=12h
--------S-6B20-------------------------------
INT 6B - Connection Manager CLIENT.EXE - ???
	AH = 20h
	???
Return: ???
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
Note:	CLIENT.EXE returns CF set/AL=F9h if AH is not 00h to 21h on entry
--------S-6B21-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - QUERY NAME SERVICE
	AH = 21h
	AL = virtual circuit number
	CL = ??? (00h or 01h)
	ES:BX -> buffer for service name structure (see #1973)
Return: CF clear if successful
	    ES:BX buffer filled
	CF set on error
Notes:	a program should call this function after allocating a virtual circuit
	  and check that the general name matches the requested service
	prior to version 3.0, Novell's NASI returned the first available port;
	  v3.0+ returns the first port found--check the returned status to
	  determine whether the port is available
SeeAlso: AH=14h"NCSI"

Format of NCSI service name structure:
Offset	Size	Description	(Table 1973)
 00h	WORD	buffer length
 02h  8 BYTEs	service name
 0Ah  8 BYTEs	general name
 12h  8 BYTEs	specific name
 1Ah  4 BYTEs	???
---Novell NASI v3.0+ ---
 1Eh	BYTE	port number
 1Fh	BYTE	port status
		00h idle (available)
		01h allocated (available)
		02h connected
		03h on hold
----------6B6B-------------------------------
INT 6B - Tandy SCHOOLMATE PLUS - API
	AH = 6Bh
	AL = E0h to FFh
Note:	details not yet available
----------6C---------------------------------
INT 6C - system resume vector (CONVERTIBLE)
----------6C---------------------------------
INT 6C - DOS 3.2 Realtime Clock update
--------N-6C---------------------------------
INT 6C - DECnet DOS network scheduler
Notes:	the installation check consists of testing for a signature area
	  immediately preceding the interrupt handler
	also supported by DEC Pathworks for DOS
SeeAlso: INT 6B"DECnet",INT 6D"DECnet",INT 6E"DECnet"
Index:	installation check;DECnet DOS scheduler

Format of DECnet DOS signature area:
Offset	Size	Description	(Table 1974)
 -5	BYTE	major version number
 -4	BYTE	minor version number
 -3   3 BYTEs	signature (ASCII "SCH")
--------V-6D---------------------------------
INT 6D - VIDEO - many VGA - VIDEO BIOS ENTRY POINT
Desc:	points at the original INT 10 entry point set up by the VGA BIOS
Note:	used by IBM, ATI VGA Wonder, Paradise, Video7, and NCR, and many others
SeeAlso: INT 10
--------V-6D---------------------------------
INT 6D - Trident SVGA - VIDEO BIOS HANDLER
Note:	the BIOS INT 10 handler on various Trident VGA cards consists merely
	  of a call to INT 6D followed by an IRET.
--------N-6D---------------------------------
INT 6D - DECnet DOS (before 2.1) - DATA LINK LAYER PROGRAM
	AH = function
	???
Return: ???
Note:	the installation check consists of testing for a signature area
	  immediately preceding the interrupt handler
SeeAlso: INT 69/AH=0Ah,INT 6C"DECnet",INT 6E"DECnet"
Index:	installation check;DECnet DOS Data Link Layer

Format of DECnet DOS signature area:
Offset	Size	Description	(Table 1975)
 -5	BYTE	major version number
 -4	BYTE	minor version number
 -3   3 BYTEs	signature (ASCII "DLL")
--------N-6E---------------------------------
INT 6E - DECnet DOS - DECnet NETWORK PROCESS API
Notes:	this is the main DECnet DOS access, and is described in Digital manual
	  AA-EB46B-TV ("DECnet-DOS Programmer's Reference Manual")
	there is a signature/data area immediately prior to the interrupt
	  handler which may be used as an installation check
Index:	installation check;DECnet DOS

Format of DECnet DOS signature area:
Offset	Size	Description	(Table 1976)
 -5	BYTE	major version number
 -4	BYTE	minor version number
 -3   3 BYTEs	signature (ASCII "DNP")
--------N-6F---------------------------------
INT 6F - Novell NetWare - PCOX API (3270 PC terminal interface)
	AX = function
	    0000h enter terminal mode
		Return: AX = status
			    0000h no action requested
			    0001h screen save
	    0001h reset interface and set configuration parameters
		DX = bitfields
		    bits 2-0: model number
		    bits 4-3: I/O address
		    bits 6-5: DMA channel
		Return: nothing
	    0002h set display parameters
		DX = bitfields
		    bits 1-0: OIA mode
		    bits 4-2: monitor support
		Return: nothing
	    0003h read status
		Return: AX = status word (see #1977)
	    0004h read cursor position
		Return: AX = cursor position
	    0005h get character from device buffer
		DX = cursor position
		Return: AH = type (00h data, 01h attribute)
			AL = data or attribute character
	    0006h send character
		DH = type (00h ASCII, 01h extended code)
		DL = ASCII character or extended code
		Return: nothing
	    0007h set timeout
		DX = timeout in seconds
		Return: nothing
	    0008h wait for location to be modified
		DX = cursor position
		Return: AX = status (0000h modified, nonzero timeout)
	    0009h NOP
	    000Ah restore display
		Return: nothing
	    000Bh update device buffer
		Return: AX = cursor positoin
	    000Ch write string to add information area
		DS:DX -> string
		Return: nothing
	    000Dh maintenance operations
		DX = maintenance operation code
		Return: AX = operation status
	    000Eh get control program version
		Return: AH = release number (major version)
			AL = level number (minor version)
	    000Fh get microcode version
		Return: AH = release number (major version)
			AL = level number (minor version)
	    0010h save or display graphics
		BX = length of data buffer
		CX = subfunction request code
		DS:DX -> data buffer
		Return: AX = return code
			CX = length of PIF data
	    0011h perform structured field operation
		CX = request number
		DS:DX -> parameter list
		Return: AX = status word (see #1977)
			CX = error number
	    0012h set cursor position for direct write buffer
		DX = new cursor position
		Return: AX = status word (see #1977)
	    0013h write direct to buffer
		DL = character to be written
		DH = translation option
		Return: AX = status word (see #1977)
	    0014h write direct to buffer without echo
		DL = character to be written
		DH = translation option
		Return: AX = status word (see #1977)
	    0015h set direct write string length
		DX = string value
		Return: nothing
	    0016h write string direct to buffer
		DS:DX -> string
		Return: AX = status word (see #1977)
	    0017h write string direct to buffer, untranslated
		DS:DX -> string
		Return: AX = status word (see #1977)
	    0018h get direct-write cursor position
		Return: AX = cursor position
	    0019h convert row/column to cursor position
		DH = display row (1-43)
		DL = display column (1-132)
		Return: AX = cursor position
	    001Ah convert cursor position to row/column
		DX = cursor position
		Return: AH = display row
			AL = display column
	    001Bh find next field
		DX = initial cursor position
		Return: AX = field cursor position
	    001Ch find previous field
		DX = initial cursor position
		Return: AX = field cursor position
	    001Dh find next unprotected field
		DX = initial cursor position
		Return: AX = field cursor position
	    001Eh find previous unprotected field
		DX = initial cursor position
		Return: AX = field cursor position
	    001Fh find next protected field
		DX = initial cursor position
		Return: AX = field cursor position
	    0020h find previous protected field
		DX = initial cursor position
		Return: AX = field cursor position
	    0021h masked search forward
		DH = mask
		DL = search pattern
		Return: AX = cursor position or 0000h
	    0022h masked search backward
		DH = mask
		DL = search pattern
		Return: AX = cursor position or 0FFFh
	    0023h find field length
		DX = cursor position
		Return: AX = field length
	    0024h read field
		DS:DX -> buffer for field contents
		Return: AX = status word (see #1977)
	    0025h read screen
		DS:DX -> buffer for screen contents
		Return: AX = status word (see #1977)
	    0026h read buffer untranslated
		DX = cursor position
		Return: AX = buffer code
			CX:BX -> 3278/79 device buffer image
	    0027h enable/disable keyboard
		DL = new state of keyboard breaks (00h enabled, 01h disabled)
		Return: nothing
	    0028h select host session
		DL = session short name
		Return: AX = session information
	    0029h retrieve host session name
		AX = short name (DFT) or 0000h (not available, CUT mode)
	    002Ah get current device buffer size
		Return: AX = device buffer size
			CX = segment of EAB
	    002Bh arm modified location trigger
		DX = cursor position
		Return: AX = status (0000h not available, 0001h successful)

Bitfields for PCOX status word:
Bit(s)	Description	(Table 1977)
 0,1	cursor type
 2	cursor inhibited
 3	display inhibited
 4	feature step inhibited
 5	480-character format code
 6,7	unused
 8-10	model number (2-5)
 11	unit has been reset by controller (cleared after status returned)
 12	buffer has been written into (cleared after status returned)
 13	alarm has been sounded (cleared after status returned)
 14-15	monitor type (01 mono, 10 color, 11 hybrid)
--------N-6F00-------------------------------
INT 6F - 10NET - LOGIN
	AH = 00h
	DS:DX -> login record (see #1978)
Return: CL = security level
	AX = status (see #1979)
SeeAlso: AH=01h,AH=80h,INT 21/AX=4402h"10MEMMGR"

Format of 10NET login record:
Offset	Size	Description	(Table 1978)
 00h  8 BYTEs	user name
 08h  8 BYTEs	password
 10h 12 BYTEs	name of SuperStation

(Table 1979)
Values for 10NET status:
 0000h	successful
 01FFh	"RTO_NERR" transmit interrupt lost (time out on response)
 02FFh	"NET_NERR" network (hardware) error
 03FFh	"PAS_NERR" invalid password
 04FFh	"LRN_NERR" local resource not available
 05FFh	"SRN_NERR" server resource not available
 06FFh	"LNM_NERR" already logged in under different name
 07FFh	"LSF_NERR" login security failure (node)
 08FFh	"NLI_NERR" not logged in
 09FFh	"DIVZ_NERR" position calc error
 0AFFh	"NT1_NERR" receive subfunction not = send subfunction (i.e. read,write)
 0BFFh	"RFNC_NERR" request function not in range
 0CFFh	"NSFH_NERR" no more server file handle entries left
 0DFFh	"NFTAB_NERR" no more shared file table entries left
 0EFFh	"NUFH_NERR" no more user file handle entries left
 0FFFh	"CHAT_NERR" chat permit not on
 10FFh	"NSRV_NERR" not a server on request
 11FFh	"NOBD_NERR" no transporter board error
 12FFh	"STO_NERR" time out on send
 13FFh	"INF_NERR" item not found (spool item not on queue)
 14FFh	"DACS_NERR" DOS access incompatible
 15FFh	"RLOCK_NERR" record already locked
 16FFh	"IVP_NERR" invalid parameter
 17FFh	"RLTO_NERR" record lock time out error
 18FFh	"CSPL_NERR" currently spooling to named device
 19FFh	"DRP_NERR" dropped receive message (throttle)
 1AFFh	"SOPV_NERR" open sharing violation
 1BFFh	"NTUF_NERR" no more tuf entries left
 1CFFh	"NOWN_NERR" not file owner on open
 1DFFh	"RSEC_NERR" read security not passed
 1EFFh	"WSEC_NERR" write security not passed
 1FFFh	"GSEC_NERR" group security not passed
 20FFh	"SEC1_NERR" security file failure
 21FFh	"ACT1_NERR" activity file failure
 22FFh	"SPL1_NERR" spool control file failure
 23FFh	"NMT_NERR" device not mounted (spooling)
 24FFh	"RSPL_NERR" spool file has not been terminated
 25FFh	"DNSH_NERR" device not mounted or is not being shared
 26FFh	"DUP_NERR" duplicate node ID
 27FFh	"FNF_NERR" file not found error
 28FFh	"NMF_NERR" no more files
 29FFh	"UN_NERR" unknown internal system error
 2AFFh	"QCP_NERR" print queue is full or corrupted
 2BFFh	"IFNC_NERR" invalid function
 2CFFh	"IVH_NERR" invalid handle
 2DFFh	"TOF_NERR" too many files opened
 2EFFh	"PNF_NERR" path not found
 2FFFh	"SACT_NERR" named file is active
---10NET v5.0+ ---
 30FFh	"NAK_NERR" received NAK on send (destination out of buffers)
 31FFh	"RENT_NERR" reentrancy in driver F_SEND
 32FFh	"RECV_NERR" driver could not be put in receive mode
 33FFh	"NRLT_NERR" no more RLTAB entries left
 34FFh	"DIAL_NERR" function requires an unsupported dialect
 35FFh	"IVD_NERR" invalid device
 36FFh	"NALV_NERR" netname access level violated
 37FFh	"NPIDNF_NERR" network path not found
 38FFh	"SP_NERR" server is paused
 39FFh	"TMNM_NERR" too many remote user names
 3AFFh	"DUPD_NERR" duplicate network device
 3BFFh	"DIU_NERR" shared device in use, can't delete
 3CFFh	"NNWD_NERR" network name was deleted
 3DFFh	"NPFS_NERR" not enough space for print file
 3EFFh	"NNNF_NERR" network name not found (can't find the call name)
 3FFFh	"NB_NERR" network busy
 40FFh	"NDNLE_NERR" network device no longer exists
 41FFh	"NBCLE_NERR" NetBIOS command limit exceeded
 42FFh	"FINT24_NERR" Fail on INT 24h
 43FFh	"PEXP_NERR" password expired
 44FFh	"NPUP_NERR" new password error
 45FFh	"MAXS_NERR" maximum allowed disk space exceeded
 46FFh	"TDOW_NERR" time-of-day/day-of-week error
SeeAlso: #1990
Index:	error codes;10Net|10Net;error codes
--------N-6F01-------------------------------
INT 6F - 10NET - LOGOFF
	AH = 01h
	DS:DX -> superstation ID or nulls (12 bytes)
Return: CX = number of files closed
	AX = status (see also #1979)
	    08FFh superstation ID not already logged in
SeeAlso: AH=00h,AH=81h
--------N-6F02-------------------------------
INT 6F - 10NET - STATUS OF NODE
	AH = 02h
	DS:DX -> 512-byte status record (see #1981)
Return:	CF clear if successful
	CF set on error
	    AX = error code (see #1979)
SeeAlso: INT 21/AX=5E01h"10NET"

(Table 1980)
Values for 10NET station type:
 00h	workstation
 01h	superstation
 02h	gateway station
 03h	gateway active
 04h	logged into multiple superstations
 05h	reserved

Format of 10NET node status record:
Offset	Size	Description	(Table 1981)
 00h  8 BYTEs	user name (0 if none)
 08h	BYTE	station type (see #1980)
 09h 24 BYTEs	list of superstations logged into more than one superstation
 21h 12 BYTEs	node ID
 2Dh	WORD	message count for this station (send for user node, receive for
		  superstations)
---for superstations only---
 2Fh	WORD	drives allocated (bit 0=A:, bit 1=B:,...)
 31h	BYTE	user service flags (see #1982)
 32h	BYTE	printers allocated (bit 0=LPT1,...)
 33h	BYTE	number of unprinted spool files
 34h	BYTE	number of opened files
 35h	BYTE	number of logged on nodes
 36h	BYTE	primary drive (1=A:)
 37h	BYTE	reserved
 38h  N BYTEs	list of logged on node IDs (each 12 bytes, max 37 IDs)
1F4h  3 BYTEs	time: sec/min/hrs
1F7h  3 BYTEs	date: day/mon/year-1980

Bitfields for 10NET user service flags:
Bit(s)	Description	(Table 1982)
 7	gate
 6	print permit on
 4	SUBMIT is on
 3	mail waiting for node
 2	calendar waiting for you
 1	news waiting for you
 0	mail waiting for you
--------W-6F0204-----------------------------
INT 6F C - MS Windows 3.0 - DOS APPLICATION SWITCH HOOK
	AX = 0204h
Return: AX = status
	    0000h switch is allowed
	    other switch not allowed
Note:	intercepting this call will allow a DOS application to ensure that
	  Windows will not switch away from it.
--------N-6F03-------------------------------
INT 6F - 10NET - GET ADDRESS OF CONFIGURATION TABLE
	AH = 03h
	DS:DI -> node ID (optional)
Return: ES:BX -> configuration table (see #1983)
SeeAlso: AH=13h,INT 21/AX=5E01h"10NET"

Format of 10NET configuration table:
Offset	Size	Description	(Table 1983)
-41	WORD	local device table address
-39	WORD	extended network error mapping table address
-37	WORD	shared device table address
-35	WORD	mounted device table address
-33	BYTE	receive buffer counter
-32	BYTE	collect buffer counter
-31	WORD	TUF address
-29	BYTE	enable flag
-28	BYTE	FCB keep flag
-27	WORD	reserved
---up to here, 10NET v3.3---
-25	WORD	count of dropped Send6F
-23	WORD	buffer start address
-21	WORD	comm driver base address
-19	WORD	send/receive retry count
-17	BYTE	number of 550ms loops before timeout
-16	WORD	UFH address
-14	WORD	CDIR address
-12	WORD	LTAB address
-10	WORD	SFH address
-8	WORD	FTAB address
-6	WORD	RLTAB address
-4	WORD	SMI address
-2	WORD	NTAB address
 00h	WORD	address of first CT_DRV
 02h	BYTE	number of DRV entries
 03h  8 BYTEs	login name
 0Bh 12 BYTEs	node ID (blank-padded)
 17h  6 BYTEs	node address
 1Dh	BYTE	flag
 1Eh	BYTE	CT_CFLG (chat permit)
		bit 1: sound bell
		bit 0: CHAT permit
 1Fh	BYTE	CT_PSFLG (see #1984)
 20h	BYTE	in 10Net flag
 21h	WORD	receive message count
 23h	WORD	send message count
 25h	WORD	retry count
 27h	WORD	failed count
 29h	WORD	driver errors
 2Bh	WORD	dropped responses/CHATs
 2Dh  9 BYTEs	LIST ID/NTAB address (3 entries--LPT1-3)
 36h  6 BYTEs	AUX ID/NTAB address (2 entries--COM1-2)
 3Ch	BYTE	active CB channel
 3Dh	BYTE	received 6F messages on queue
 3Eh  9 BYTEs	activity counters for channels 1-9
---beyond here, 10NET v3.3---
 47h	BYTE	bit 0: RS232 gate
		bit 1: Send6F gate (user set)
 48h	DWORD	pointer into gate (user set)
 4Ch	DWORD	pointer into 10Net send
 50h  N WORDs	addresses of timer blocks

Bitfields for CT_PSFLG:
Bit(s)	Description	(Table 1984)
 5	PRINT permit
 4	KB initiated
 3	CHAT called FOXPTRM
 2	SUBMIT active
 1	SUBMIT received
 0	SUBMIT permit
--------N-6F04-------------------------------
INT 6F - 10NET - SEND
	AH = 04h
	DS:BX -> send record (see #1985)
	DS:DX -> data (max 1024 bytes)
Return:	CF clear if successful
	CF set on error
	    AX = error code (see #1979)
SeeAlso: AH=05h,AH=09h,AH=0Ah

Format of 10NET send record:
Offset	Size	Description	(Table 1985)
 00h 12 BYTEs	receiving node's ID
		if first byte has high-order bit set, message is directed to
		  the CT_RGATE vector at the receiver
		if second byte is 00h, first byte is taken as a CB
		  channel number and delivered to all nodes on same channel
 0Ch	WORD	 length of data at DX
--------N-6F05-------------------------------
INT 6F - 10NET - RECEIVE
	AH = 05h
	CX = number of seconds before timeout
	DS:DX -> receive buffer (see #1986)
Return:	CF clear if successful
	    AH = FEh if dequeued message is a CB message
	CF set on error
	    AX = error code (see #1979)
SeeAlso: AH=04h

Format of 10NET receive buffer:
Offset	Size	Description	(Table 1986)
 00h 12 BYTEs	sending node's ID
 0Ch	WORD	length of message
 0Eh  N BYTEs	message (maximum 1024 bytes)
--------N-6F07-------------------------------
INT 6F - 10NET - LOCK HANDLE
	AH = 07h
	BX = file handle
	CX:DX = starting offset in file
	SI = record length
Return:	CF clear if successful
	CF set on error
	    AX = error code (see also AH=00h)
		0002h file not found
SeeAlso: AH=08h,AH=0Fh,INT 21/AH=5Ch
--------N-6F08-------------------------------
INT 6F - 10NET - UNLOCK HANDLE
	AH = 08h
	BX = file handle
	AL = mode
	    00h unlock all
	    01h unlock record at CX:DX
Return:	CF clear if successful
	CF set on error
	    AX = error code (see also AH=00h)
		0002h file not found
SeeAlso: AH=07h,AH=0Fh,INT 21/AH=5Ch
--------N-6F09-------------------------------
INT 6F - 10NET - SUBMIT
	AH = 09h
	DS:BX -> submit record (see #1987)
SeeAlso: AH=04h

Format of 10NET submit record:
Offset	Size	Description	(Table 1987)
 00h 12 BYTEs	destination node ID (must be logged in)
 0Ch	WORD	length+2 of following 'command line' text
 0Eh  N BYTEs	command line text (<=100 bytes), system adds CR
--------N-6F0A-------------------------------
INT 6F - 10NET - CHAT
	AH = 0Ah
	DS:BX -> control parameters (see #1988)
	DS:DX -> chat message (see #1989)
SeeAlso: AH=04h,AH=8Ah

Format of 10NET chat control parameters:
Offset	Size	Description	(Table 1988)
 00h  8 BYTEs	sender ID, defaults to node's userID if nulls
 08h  8 BYTEs	destination user ID, 'EVERYONE' may be used
 10h 12 BYTEs	destination node ID

Format of 10NET chat message:
Offset	Size	Description	(Table 1989)
 00h	WORD	length+2 of following text
 02h  N BYTEs	text, max 101 bytes
--------N-6F0B-------------------------------
INT 6F - 10NET - LOCK SEMAPHORE, RETURN IMMEDIATELY
	AH = 0Bh
	AL = drive number or 0
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see #1990)
Note:	same as INT 60/AH=12h
SeeAlso: AH=0Ch,INT 60/AH=12h

(Table 1990)
Values for 10NET status:
 00h	successful
 01h	semaphore currently locked
 02h	server not responding
 03h	invalid semaphore name
 04h	semaphore list is full
 05h	invalid drive ID
 06h	invalid Ethernet address
 07h	not logged in
 08h	write to network failed
 09h	semaphore already logged in this CPU
SeeAlso: #1979
Index:	error codes;10-Net|10-Net;error codes
--------N-6F0C-------------------------------
INT 6F - 10NET - UNLOCK SEMAPHORE
	AH = 0Ch
	AL = drive number or 0
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see also #1990)
	    01h semaphore not locked
Note:	same as INT 60/AH=13h
SeeAlso: AH=0Bh,INT 60/AH=13h
--------N-6F0D-------------------------------
INT 6F - 10NET - "WHO" - ENUMERATE USERS ON NETWORK
	AH = 0Dh
	AL = type code
	    01h return superstations only
	    02h return non-superstations only
	    otherwise return all
	CX = length of data buffer
	DS:DX -> array of records to be filled (see #1991)
Return: CL = number of records returned (responding stations)
SeeAlso: AH=16h,AH=8Dh

Format of station record:
Offset	Size	Description	(Table 1991)
 00h 12 BYTEs	node ID
 0Ch	BYTE	station flags (see #1992)
---if AL = 01h---
 0Dh	BYTE	version number
 0Eh	WORD	level number of 10Net software in responding node
---if AL = 02h---
 0Dh  8 BYTEs	user ID
 15h	BYTE	version number
 16h	WORD	level number

Bitfields for station flags:
Bit(s)	Description	(Table 1992)
 1	workstation
 2	superstation
 3	xgate
 4	active gate
--------N-6F0E-------------------------------
INT 6F - 10NET - SPOOL/PRINT
	AH = 0Eh
	DS:DX -> spool/print record (see #1994)
Return:	CF clear if successful
	CF set on error
	    AX = error code (see also #1979)
		17FFh device not mounted
		18FFh already spooling to named device

(Table 1993)
Values for 10NET spooler operation code:
 0000h	initiate spool
 0001h	abort print
 0002h	close spool
 0003h	delete spool
 0004h	print
 0005h	get report info
 0006h	set chat template
 0007h	queue
 0008h	return queue
 0009h	queue non-spooled file for printing

Format of 10NET Spool/Print record:
Offset	Size	Description	(Table 1994)
 00h	WORD	operation code (see #1993)
 02h 11 BYTEs	file name in FCB format
---if operation code = 00h or 06h---
 0Dh	BYTE	notification flags (see #1995)
 0Eh	BYTE	days to keep (FFh=forever)
 0Fh	BYTE	bits 0,1: device (1=LPT1)
		bits 4-7: remote drive to store spool file (1=A,...)
 10h	WORD	length of following data area
 12h  N BYTEs	up to 64 bytes of description
---if operation code = 03h---
 0Dh  8 BYTEs	user ID to associate with filename
---if operation code = 04h---
 0Dh	WORD	block number
 0Fh  8 BYTEs	user ID to associate with filename
---if operation code = 05h---
 0Dh	BYTE	RRN to start retrieve
 0Eh	BYTE	bits 0,1: local print device (LPTx)
		bit 3: if set, return entries for all users
 0Fh	WORD	length of following area
 11h  N BYTEs	up to 1500 bytes to receive $SCNTL records returned
---if operation code = 07h---
 0Dh	BYTE	queue number
 0Eh	BYTE	bits 0,1: local print device (LPTx)
 0Fh	WORD	number of bytes of test print to be done
 11h	BYTE	code:
		01h print device
		02h test print count
		03h prn
---if operation code = 08h---
 0Dh	BYTE	queue location or $SCNTL location to start access
		returns next item for access:
		    00h-7Fh queued items
		    80h-FEh non-queued, non-printed items
		    FFh	no more items
 0Eh	WORD	unused
 10h	WORD	length of following area
 12h  N BYTEs	up to 64 bytes to receive $SCNTL records
---if operation code = 09h---
 0Dh  3 BYTEs	unused
 10h  N BYTEs	path to non-spooled file to be queued for printing

Bitfields for notification flags:
Bit(s)	Description	(Table 1995)
 7	queue to top
 6	do ID page
 5	no form feed
 4	reserved
 3	explicit queuing only
 2	notify at print completion
 1	notify server operator, with reply
 0	notify at print start

Format of 10NET $SCNTL record:
Offset	Size	Description	(Table 1996)
 00h  8 BYTEs	user ID
 08h 11 BYTEs	filename in FCB format
 13h  6 BYTEs	node ID
 19h  3 BYTEs	creation date
 1Ch	BYTE	notification flags (see #1995)
 1Dh	BYTE	retention time in days
 1Eh	BYTE	printing device (LPTx)
 1Fh  3 BYTEs	date last printed (0 = never)
 22h	BYTE	device containing spoolfile
 23h	WORD	bytes to print for test print
 25h	WORD	block number to start print
 27h	BYTE	reserved
--------N-6F0F-------------------------------
INT 6F - 10NET v5.0 - "RM LOCK" - ???
	AH = 0Fh
	???
Return: ???
SeeAlso: AH=07h,AH=08h
--------N-6F10-------------------------------
INT 6F - 10NET - ATTACH/DETACH PRINTER
	AH = 10h
	AL = subfunction
	    00h initiate spooling if LPT1 is mounted
	    01h terminate spooling if LPT1 is mounted
SeeAlso: INT 21/AX=5D08h
--------N-6F11-------------------------------
INT 6F - 10NET - LOCK FCB
	AH = 11h
	AL = mode
	    01h sequential
	    02h random
	    03h random block
		CX = number of records
	DS:DX -> FCB (see #0469 at INT 21/AH=0Fh)
Return:	CF clear if successful
	CF set on error
	    AX = error code (see also #1979)
		0002h file not found
SeeAlso: AH=12h,INT 21/AH=0Fh
--------N-6F12-------------------------------
INT 6F - 10NET - UNLOCK FCB
	AH = 12h
	AL = mode
	    00h sequential
	    01h random
	    02h random block
		CX = number of records
	DS:DX -> FCB (see #0469 at INT 21/AH=0Fh)
Return:	CF clear if successful
	CF set on error
	    AX = error code (see also #1979)
		0002h file not found
SeeAlso: AH=11h
--------N-6F13-------------------------------
INT 6F - 10NET v3.3+ - GET REMOTE CONFIGURATION TABLE ADDRESS
	AH = 13h
	DS:DX -> node ID, 12 bytes blank-padded
Return:	CF clear if successful
	    ES:BX = configuration table address on given machine
	CF set on error
	    AX = error code (see #1979)
SeeAlso: AH=03h
--------N-6F14-------------------------------
INT 6F - 10NET v3.3+ - GET REMOTE MEMORY
	AH = 14h
	BX:SI = address of remote memory
	CX = length (<=1024 bytes)
	DS:DX -> node ID, 12 bytes blank-padded
	DS:DI -> area to receive remote memory image
Return:	CF clear if successful
	    CX = amount of memory copied to DS:SI
	CF set on error
	    AX = error code (see #1979)
--------N-6F1501-----------------------------
INT 6F - 10NET v3.3+ - GET SHARED DEVICE ENTRY
	AX = 1501h
	BX = zero-based index
	DS:SI -> node ID, 12 bytes blank-padded
	ES:DI -> 85-byte buffer for shared device table entry (see #1997)
Return:	CF clear if successful
	    ES:DI buffer contains shared device table entry of BXth device
	CF set on error
	    AX = error code (see #1979)
SeeAlso: AX=1502h,AX=1503h,AX=9501h

Format of 10NET shared device table entry:
Offset	Size	Description	(Table 1997)
 00h  8 BYTEs	device
 08h  8 BYTEs	alias
 10h 64 BYTEs	path
 50h  8 BYTEs	password
 58h	BYTE	access
 59h  4 BYTEs	mask
--------N-6F1502-----------------------------
INT 6F - 10NET v3.3+ - SET SHARED DEVICE ENTRY
	AX = 1502h
	DS:SI -> node ID, 12 bytes blank-padded
	ES:DI -> valid shared device table entry
Return:	CF clear if successful
	CF set on error
	    AX = error code (see #1979)
SeeAlso: AX=1501h,AX=1503h,AX=9502h
--------N-6F1503-----------------------------
INT 6F - 10NET v3.3+ - DELETE SHARED DEVICE ENTRY
	AX = 1503h
	BX = zero-based index
	DS:SI -> node ID, 12 bytes blank-padded
Return:	CF clear if successful
	CF set on error
	    AX = error code (see #1979)
SeeAlso: AX=1501h,AX=1502h,AX=9503h
--------N-6F16-------------------------------
INT 6F - 10NET v5.0 - "GL WHO" - ???
	AH = 16h
	???
Return: ???
SeeAlso: AH=0Dh
--------N-6F17-------------------------------
INT 6F - 10NET v3.3+ - MOUNT
	AH = 17h
	AL = local drive number (0=A:)
	BL = remote drive letter or '1'..'3' for LPTn or '4' or '5' for COMx
	DS:DX -> node ID, 12 bytes blank-padded
Return:	CF clear if successful
	CF set on error
	    AX = error code (see #1979)
SeeAlso: AH=18h
--------N-6F18-------------------------------
INT 6F - 10NET v3.3+ - UNMOUNT
	AH = 18h
	AL = local drive number (0=A:)
	BL = type
	    00h	    disk
	    01h-03h LPTn
	    04h,05h COMx
Return:	CF clear if successful
	CF set on error
	    AX = error code (see #1979)
SeeAlso: AH=17h
--------N-6F19-------------------------------
INT 6F U - 10NET v5.0 - AUDIT
	AH = 19h
	???
Return: ???
SeeAlso: AH=99h
--------N-6F1A-------------------------------
INT 6F U - 10NET v5.0 - "BULL" - ???
	AH = 1Ah
	???
Return: ???
--------N-6F1B-------------------------------
INT 6F U - 10NET v5.0 - "GMOUNT" - ???
	AH = 1Bh
	???
Return: ???
--------N-6F1C-------------------------------
INT 6F U - 10NET v5.0 - "GLOGIN" - GET LOGIN LIST
	AH = 1Ch
	???
Return: ???
--------N-6F1D-------------------------------
INT 6F U - 10NET v5.0 - "TABDATA" - ???
	AH = 1Dh
	???
Return: ???
--------N-6F1E-------------------------------
INT 6F U - 10NET v5.0 - "SCHED" - ???
	AH = 1Eh
	???
Return: ???
--------N-6F1F-------------------------------
INT 6F U - 10NET v5.0 - "WHOAMI" - ???
	AH = 1Fh
	???
Return: ???
--------N-6F20-------------------------------
INT 6F U - 10NET v5.0 - ???
	AH = 20h
	???
Return: ???
--------N-6F21-------------------------------
INT 6F U - 10NET v5.0 - ???
	AH = 21h
	???
Return: ???
--------N-6F22-------------------------------
INT 6F U - 10NET v5.0 - ???
	AH = 22h
	???
Return: ???
--------b-6F22--BP0012-----------------------
INT 6F - HP HIL Vectras - EXTENDED BIOS - READ CMOS MEMORY
	AH = 22h
	BP = 0012h (ID of V_SYSTEM driver)
	BL = address of CMOS byte to read
Return: AH = status
	AL = byte read
	BP, DS destroyed
Note:	supported by ES, QS, and RS series HP Vectras
SeeAlso: BP=0012h/AH=24h
--------b-6F24--BP0012-----------------------
INT 6F - HP HIL Vectras - EXTENDED BIOS - WRITE CMOS MEMORY
	AH = 24h
	BP = 0012h (ID of V_SYSTEM driver)
	BL = address of CMOS byte to write
	AL = new value
Return: AH = status
	BP, DS destroyed
SeeAlso: BP=0012h/AH=22h
--------N-6F80-------------------------------
INT 6F - 10NET v5.0 - LOGIN
	AH = 80h
	DS:DX -> login record (see #1998)
Return: CF clear if successful
	    BL = number of days until password expires (00h = never)
	    CL = security level
	CF set on error
	    AX = status (see #1979)
SeeAlso: AH=00h,AH=81h

Format of 10NET login record:
Offset	Size	Description	(Table 1998)
 00h  8 BYTEs	user name
 08h  8 BYTEs	password
 10h 15 BYTEs	server node ID
 1Fh  8 BYTEs	new password
 27h	BYTE	invoke mode (00h command line, 01h interactive)
--------N-6F81-------------------------------
INT 6F - 10NET v5.0 - LOGOUT
	AH = 81h
	DS:DX -> server node ID (DX=0000h for universal logout)
Return: AX = status (see #1979)
SeeAlso: AH=01h,AH=80h
--------N-6F8A-------------------------------
INT 6F - 10NET v5.0 - CHAT
	AH = 8Ah
	DS:BX -> chat parameters (see #1999)
	DS:DX -> chat message (see #2000)
Return: CF clear if successful
	CF set on error
	    AX = status (see #1979)
SeeAlso: AH=0Ah

Format of 10NET chat parameters:
Offset	Size	Description	(Table 1999)
 00h  8 BYTEs	sender's user name
 08h  8 BYTEs	destination user name
 10h 15 BYTEs	destination node (0 if broadcast-style chat)

Format of 10NET chat message:
Offset	Size	Description	(Table 2000)
 00h	WORD	message length
 02h  N BYTEs	chat message contents
--------N-6F8D-------------------------------
INT 6F - 10NET v5.0 - "WHO" - ENUMERATE USERS ON NETWORK
	AH = 8Dh
	BX = service mask (see #2001)
	CX = length of buffer
	DS:DX -> buffer for array of Who data structures (see #2002)
Return: CF clear if successful
	    CX = number of nodes matching service mask
	    DS:DX buffer filled
	CF set on error
	    AX = status (see #1979)
SeeAlso: AH=0Dh

Bitfields for 10NET service mask:
Bit(s)	Description	(Table 2001)
 0	workstation
 1	file server
 2	print server
 3	de-spool server

Format of 10NET Who data structure:
Offset	Size	Description	(Table 2002)
 00h  8 BYTEs	user name
 08h 15 BYTEs	node ID
 17h  3 BYTEs	unique portion of Ethernet address
 1Ah	BYTE	Who group number
 1Bh	WORD	service mask (see #2001)
 1Dh	DWORD	serial number
 21h	BYTE	maximum concurrent users with same serial number allowed on net
 22h	BYTE	chat mask (see #2003)
 23h	BYTE	internal system bits (see #2004)
 24h  9 BYTEs	version number in format MM.mm.xxx
 2Dh	BYTE	number of shared directories
 2Eh	BYTE	number of shared printer queues

Bitfields for 10NET chat mask:
Bit(s)	Description	(Table 2003)
 0	chat permitted
 1	bell enabled
 2	chat keyboard initiated
 3	in INT 16 handler
 4	in Get Input
 5	display has timed out
 6	chat is idle

Bitfields for 10NET internal system bits:
Bit(s)	Description	(Table 2004)
 0	submit permitted
 1	submit initiated
 2	submit executing
 3	internal client call/chat/spool/autospool
 4	in spool termination
 5	print permitted
 6	waiting for keyboard input
--------N-6F9501-----------------------------
INT 6F - 10NET v5.0 - GET SHARED DEVICE ENTRY
	AX = 9501h
	BX = zero-based index
	DS:SI -> server's node ID
	ES:DI -> buffer for shared device structure (see #2005)
Return: CF clear if successful
	CF set on error
	    AX = status (see #1979)
SeeAlso: AX=1501h,AX=9502h,AX=9503h,AX=9504h

Format of 10NET shared device structure:
Offset	Size	Description	(Table 2005)
 00h  8 BYTEs	alias
 08h	BYTE	type (02h modem, 03h print queue, 04h directory)
 09h	BYTE	access rights
		bit 0: read
		bit 1: write
		bit 2: create
 0Ah  8 BYTEs	password
 12h 32 BYTEs	comment
---directory---
 32h 64 BYTEs	pathname of shared directory
---print queue---
 32h	BYTE	notification bit mask (see #2006)
 33h	BYTE	job control bit mask (see #2007)
 34h	WORD	number of days to retain file
 36h	WORD	test print length
 38h	BYTE	number of copies to print
 39h	BYTE	compression algorithm
 3Ah	BYTE	tab width (00h = don't expand)
 3Bh	BYTE	priority
 3Ch	WORD	time to open queue (FFFFh = always)
 3Eh	WORD	time to close queue
 40h	WORD	pause following queue switch, in clock ticks
 42h	WORD	pause between print jobs, in clock ticks
 44h	BYTE	associate queue file existence mask
		bit 0: queue switch file exists
		bit 1: initiate file exists
		bit 2: abort file exists
 45h  6 BYTEs	character sequence for page eject
 4Bh	BYTE	status of print queue
		bit 0: queue is closed
 4Ch	WORD	number of jobs on queue
 4Eh	WORD	offset of next print job to be dispatched (FFFFh = none)
 50h	BYTE	number of print devices in printer pool
 51h	WORD	offset of first print device structure (FFFFh if empty)

Bitfields for notification flags:
Bit(s)	Description	(Table 2006)
 0	user at print start
 1	operator at start, with reply
 2	user at print completion
 3	operator at completion, with reply
 4	user on queue switch
 5	operator on queue switch, with reply
 6	user on print error

Bitfields for 10NET job control mask:
Bit(s)	Description	(Table 2007)
 0	print banner page
 1	eject page at end of job
 2	mark as "held" (queue but don't print)
 3	rush job (queue at top)
 4	overwrite file with zeros before deletion
 5	hyperspool if possible
--------N-6F9502-----------------------------
INT 6F - 10NET v5.0 - SET SHARED DEVICE ENTRY
	AX = 9502h
	DS:SI -> server's node ID
	ES:DI -> shared device structure (see #2005)
Return: CF clear if successful
	CF set on error
	    AX = status (see #1979)
SeeAlso: AX=1502h,AX=9501h,AX=9503h,AX=9504h
--------N-6F9503-----------------------------
INT 6F - 10NET v5.0 - DELETE SHARED DEVICE
	AX = 9503h
	BX = zero-based index
	DS:SI -> server's node ID
Return: CF clear if successful
	CF set on error
	    AX = status (see #1979)
SeeAlso: AX=1503h,AX=9501h,AX=9502h,AX=9504h
--------N-6F9504-----------------------------
INT 6F - 10NET v5.0 - ENUMERATE USERS OF SHARED DEVICE
	AX = 9504h
	BX = zero-based shared device index
	CX = zero-based user index
	DS:SI -> server's node ID
Return: CF clear if successful
	    ES:DI -> node ID of the CX'th user of the BX'th device
	CF set on error
	    AX = status (see #1979)
SeeAlso: AX=9501h,AX=9502h,AX=9503h
--------N-6F99-------------------------------
INT 6F - 10NET v5.0 - AUDIT
	AH = 99h
	DS:SI -> server's node ID
	ES:DI -> data to be appended to audit trail file (max 106 bytes)
Return: CF clear if successful
	CF set on error
	    AX = status (see #1979)
SeeAlso: AH=19h,AH=9Ch
--------N-6F9C-------------------------------
INT 6F - 10NET v5.0 - GET LOGIN LIST
	AH = 9Ch
	BX = zero-based index
Return: CF clear if successful
	    DS:DI -> BX'th node ID that caller's machine is logged into
	CF set on error
	    AX = status (see #1979)
--------H-70---------------------------------
INT 70 - IRQ8 - CMOS REAL-TIME CLOCK
Desc:	this interrupt is called when the real-time clock chip generates an
	  alarm or periodic interrupt, among others.  The periodic interrupt
	  occurs 1024 times per second.
Nots:	many BIOSes turn off the periodic interrupt in the INT 70h handler
	  unless in an event wait (see INT 15/AH=83h or INT 15/AH=86h).
	may be masked by setting bit 0 on I/O port A1h
SeeAlso: INT 08,INT 0F"HP 95LX",INT 15/AH=01h"Amstrad",INT 15/AH=83h
SeeAlso: INT 15/AH=86h,INT 1A/AH=02h,INT 58"DESQview"
--------v-70---------------------------------
INT 70 - VIRUS - "Stupid" - ORIGINAL INT 21h VECTOR
Note:	the virus sets this interrupt to be the same as INT 21, and then
	  performs only INT 70 calls; since INT 70 is also generated by the
	  real-time clock on the PC/AT and higher, this could cause random
	  actions on an infected system
SeeAlso: INT 6B"VIRUS",INT 9E"VIRUS",INT E0"VIRUS"
--------H-71---------------------------------
INT 71 - IRQ9 - REDIRECTED TO INT 0A BY BIOS
Notes:	may be masked by setting bit 1 on I/O port A1h
	the default BIOS handler invokes INT 0A for compatibility, since the
	  pin for IRQ2 on the PC expansion bus became the pin for IRQ9 on the
	  AT expansion bus.
	under DESQview, only the INT 15h vector and BASIC segment address (the
	  word at 0000h:0510h) may be assumed to be valid for the handler's
	  process
SeeAlso: INT 0A,INT 59
--------H-72---------------------------------
INT 72 - IRQ10 - RESERVED
Note:	may be masked by setting bit 2 on I/O port A1h
SeeAlso: INT 5A
--------H-73---------------------------------
INT 73 - IRQ11 - RESERVED
Note:	may be masked by setting bit 3 on I/O port A1h
SeeAlso: INT 5B
--------H-74---------------------------------
INT 74 - IRQ12 - POINTING DEVICE (PS)
Notes:	may be masked by setting bit 4 on I/O port A1h
	under DESQview, only the INT 15h vector and BASIC segment address (the
	  word at 0000h:0510h) may be assumed to be valid for the handler's
	  process
SeeAlso: INT 33,INT 5C
--------H-75---------------------------------
INT 75 - IRQ13 - MATH COPROCESSOR EXCEPTION (AT and up)
Desc:	redirected to INT 02 by the BIOS, for compatibility with the PC
Notes:	may be masked by setting bit 5 on I/O port A1h
	not all clones wire the coprocessor to generate this IRQ; some systems
	  generate an NMI (see INT 02) or assert the -ERROR pin on the CPU
	  (see INT 10"COPROCESSOR")
	under DESQview, only the INT 15h vector and BASIC segment address (the
	  word at 0000h:0510h) may be assumed to be valid for the handler's
	  process
SeeAlso: INT 10"COPROCESSOR",INT 5D
--------H-76---------------------------------
INT 76 - IRQ14 - HARD DISK CONTROLLER OPERATION COMPLETE (AT and later)
Notes:	may be masked by setting bit 6 on I/O port A1h
	on the PS/2, this interrupt is designed to be shared with other
	  devices that produce an operation-complete interrupt, though
	  the only current user is the hard disk
SeeAlso: INT 0E"IRQ6",INT 15/AH=91h,INT 5E
--------H-77---------------------------------
INT 77 - IRQ15 - RESERVED (AT,PS)
Note:	may be masked by setting bit 7 on I/O port A1h
SeeAlso: INT 5F
--------H-77---------------------------------
INT 77 - IRQ15 - POWER CONSERVATION (Compaq SLT/286)
Note:	may be masked by setting bit 7 on I/O port A1h
SeeAlso: INT 15/AX=4600h,INT 5F
--------E-78---------------------------------
INT 78 - UofSalford DBOS DOS extender - API
	AH = function
	    00h (PB) display 32-bit memory specified by command argument
	    01h (PT) display 32-bit instruction(s) specified by command arg
	    02h specify offset to subsequent PB and PT commands
	    03h switch to protected mode
		DWORD following INT instruction point to map; protected-mode
			  entry point is immediately following the DWORD
		Return: never
		Note:	if bit 31 of the map address is set, only a stub was
			  loaded by DOS and DBOS will load the entire program
	    04h specify that subsequent load (AH=03h) should leave program in
		  memory
	    05h release program from memory
	    06h set break point at address and option count from commandline
	    07h resume program execution
	    08h single-step program
	    09h set read/write breakpoint using 386 debug registers
	    0Ah set write breakpoint using 386 debug register
	    0Bh set memory byte to new value
	    0Ch display CPU registers
	    0Dh run until specified program address reached
	    0Fh print trace from program map
	    10h specify an offset using a map symbol
	    14h print memory without any offset
	    18h switch DBOS into/out of test mode (ON/OFF commandline args)
	    1Dh get address of real/protected-mode communication buffer
		Return: ES:BP -> comm buffer
	    1Eh set real-mode memory size (specify how much real-mode memory
		  to leave free when running FTN77 programs)
	    22h uninstall DBOS
	    24h force DBOS to emulate coprocessor instructions
	    26h set named DBOS switches from commandline
	    27h reset named DBOS switched from commandline
	    2Ah set list of dynamic link libraries to contents of commandline
		  file
	    35h specify that subsequent load (AH=03h) should stop at first
		  instruction
Return: ???
Notes:	DBOS supports functions 00h through 50h; many of these functions
	  provide a low-level debugging interface
	command arguments are read from the calling program's PSP
SeeAlso: INT 79"DBOS"
Index:	uninstall;DBOS DOS extender
--------E-78---------------------------------
INT 78 - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ0
Program: GO32.EXE is a DOS extender included as part of the 80386 port of the
	  GNU C/C++ compiler by DJ Delorie and distributed as DJGPP
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 08,INT 10/AH=FFh"GO32",INT 79"GO32"
--------A-78---------------------------------
INT 78 R - AutoCAD Device Interface - PLOTTER - SEND COMMAND
	AX = function
	    0001h begin plot
		BX = file level
		    0000h ASCII file
		    0001h binary file
		    0002h AutoCAD DXB file
		    0003h installed ADI driver
	    0002h end plot (close plotter)
	    0003h move (pen up)
		BX = new X position
		CX = new Y position
	    0004h move (pen down)
		BX = new X position
		CX = new Y position
	    0005h select pen
		BX = pen number
	    0006h select drawing speed
		BX = drawing speed N
	    0007h select line style
		BX = line style N
	    0008h raise pen
	    0009h abort plot
Return: AX = 0000h (may be used for driver status in future releases)
SeeAlso: INT 79"AutoCAD",INT 7A/AX=0001h"AutoCAD",INT 7B/AX=8001h"AutoCAD"
--------d-78---------------------------------
INT 78 - ADP-60 IDE controller - ORIGINAL INT 13
SeeAlso: INT 79"ADP-60"
--------d-7800-------------------------------
INT 78 - TARGA.DEV - CMC International SCSI device driver - SET I/O PORT
	AH = 00h
	DX = interface board I/O port
Return: CF set on error
	    AL = error code (see #2008)
Note:	if this routine is not called, the port is the driver's default
	  (usually 0280h or 0300h)
	an installation check is performed by TARGA.DEV upon initialization
	  by checking for the string "SCSI" at offset 03h into the interrupt
	  handler
SeeAlso: AH=01h,AH=02h
Index:	installation check;TARGA.DEV

(Table 2008)
Values for TARGA.DEV error code:
 00h	illegal command given to SCSI code
 01h	invalid I/O port specified (must be from 100H to 3F8H, and must be on
	  an 8-port boundary)
 02h	invalid DMA channel specified (must be from 1 to 3)
 03h	invalid SCSI board number specified (must be from 0 to 7)
 04h	error from data register test during self-test
 05h	SCSI input signals not all 0 when SCSI RST activated
 06h	SCSI input signals not all 0 before selecting a SCSI device
 07h	BSY signal is active; SCSI bus is busy
 08h	SCSI board not selected, BSY signal did not come on in response to
	  raising SEL
 09h	time-out waiting for status state, signifying end of DMA transfer
--------d-7801-------------------------------
INT 78 - TARGA.DEV - GET I/O PORT
	AH = 01h
Return: DX = current interface board I/O port
SeeAlso: AH=00h,AH=03h"TARGA"
--------d-7802-------------------------------
INT 78 - TARGA.DEV - SET DMA CHANNEL
	AH = 02h
	AL = interface board DMA channel
Return: CF set on error
	AL = error code (see #2008)
Note:	if this routine is not called, the DMA channel is the driver's default
	  (usually 3)
SeeAlso: AH=00h,AH=03h"TARGA"
--------d-7803-------------------------------
INT 78 - TARGA.DEV - GET DMA CHANNEL
	AH = 03h
Return: AL = current interface board DMA channel
SeeAlso: AH=01h,AH=02h
--------d-7804-------------------------------
INT 78 - TARGA.DEV - SET SCSI DEVICE NUMBER
	AH = 04h
	AL = SCSI device number
Return: CF set on error
	AL = error code (see #2008)
Note:	if this routine is not called, the device number used is the driver's
	  default (usually 0)
SeeAlso: AH=02h,AH=05h
--------d-7805-------------------------------
INT 78 - TARGA.DEV - GET SCSI DEVICE NUMBER
	AH = 05h
Return: AL = current SCSI device number
SeeAlso: AH=03h"TARGA",AH=04h
--------d-7806-------------------------------
INT 78 - TARGA.DEV - SET/CLEAR EARLY RETURN MODE
	AH = 06h
	AL = new state
	    00h clear early return mode
	    01h set early return mode
Note:	if early return mode is set then SCSI will return with no errors
	  when the last DMA transfer is started in a call with AH=13h or AH=14h
	if this routine is not called, early return mode is cleared
SeeAlso: AH=13h,AH=14h,AH=15h
--------d-7808-------------------------------
INT 78 - TARGA.DEV - INTERFACE BOARD SELF-TEST
	AH = 08h
Return: CF set on error
	AL = error code (see #2008)
Note:	the SCSI bus is also reset
SeeAlso: AH=09h
--------d-7809-------------------------------
INT 78 - TARGA.DEV - RESET SCSI BUS
	AH = 09h
Return: AL = error code if carry set (see #2008)
SeeAlso: AH=08h
--------d-7810-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND
	AH = 10h
	DS:SI -> command bytes
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see #2008)
SeeAlso: AH=11h,INT 21/AX=4403h"ST-01"

Format of SCSI Command:
Offset	Size	Description	(Table 2009)
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7811-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND, RECEIVE DATA (PROGRAMMED I/O)
	AH = 11h
	DS:SI -> command bytes
	ES:BX -> data storage area
	CX = number of data bytes to transfer
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see #2008)
Note:	this command receives data internally one byte at a time
SeeAlso: AH=10h,AH=13h

Format of TARGA.DEV SCSI Command:
Offset	Size	Description	(Table 2010)
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7812-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND AND DATA (PROGRAMMED I/O)
	AH = 12h
	DS:SI -> command bytes
	ES:BX -> data storage area
	CX = number of data bytes to transfer
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see #2008)
Note:	this command sends data internally one byte at a time
SeeAlso: AH=14h

Format of TARGA.DEV SCSI Command:
Offset	Size	Description	(Table 2011)
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7813-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND, RECEIVE DATA (DMA)
	AH = 13h
	DS:SI -> command bytes
	ES:BX -> data storage area
	DX:CX = number of data bytes to transfer
Return: AH = SCSI status byte (if early return mode is clear)
	CF clear if successful
	    AL = SCSI message byte (if early return mode is clear)
	CF set on error
	    AL = error code (see #2008)
Note:	this command receives data using DMA
SeeAlso: AH=11h,AH=12h

Format of TARGA.DEV SCSI Command:
Offset	Size	Description	(Table 2012)
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7814-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND AND DATA (DMA)
	AH = 14h
	DS:SI -> command bytes
	ES:BX -> data storage area
	DX:CX = number of data bytes to transfer
Return: AH = SCSI status byte (if early return mode is clear)
	CF clear if successful
	    AL = SCSI message byte (if early return mode is clear)
	CF set on error
	    AL = error code (see #2008)
Note:	this command sends data using DMA
SeeAlso: AH=12h,AH=13h

Format of TARGA.DEV SCSI Command:
Offset	Size	Description	(Table 2013)
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7815-------------------------------
INT 78 - TARGA.DEV - FINISH DATA TRANSFER (DMA)
	AH = 15h
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see #2008)
Note:	if AH=06h was previously called to set the early return mode, this
	  function finishes a command AH=13h or AH=14h which returned before
	  the last DMA transfer was finished
SeeAlso: AH=06h,AH=13h,AH=14h
--------V-79---------------------------------
INT 79 - AVATAR.SYS - FAST GET KEYSTROKE
Return: CF set if no keystroke available
	    AX = FFFFh
	CF clear if key pressed
	    AX = keystroke
Program: AVATAR.SYS is a CON driver by George Adam Stanislav which interprets
	  AVATAR command codes just as ANSI.SYS interprets ANSI commands
Note:	if a keystroke is available, it is removed from the keyboard buffer
	  before being returned
SeeAlso: INT 29
--------E-79---------------------------------
INT 79 - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ1
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 09,INT 78"GO32",INT 7A"GO32"
--------d-79---------------------------------
INT 79 U - ADP-60 IDE adapter - ???
SeeAlso: INT 78"ADP-60"
--------E-79---------------------------------
INT 79 - DBOS DOS Extender
	details not available
Desc:	this interrupt is used by an MS Windows virtual device driver with
	  which the DBOS extender communicates when run inside a Windows
	  Enhanced Mode DOS box
SeeAlso: INT 78"DBOS"
--------A-790001-----------------------------
INT 79 R - AutoCAD Device Interface - DIGITIZER - INITIALIZE
	AX = 0001h
	BX = interface level (0001h)
Return: AX = status (0000h initialization failed, 0001h init successful)
	BX = digitizer type
	    0000h relative pointing device (mouse, etc.)
	    0001h digitizing tablet
	CX = digitizer dataflow type
	    0000h continuous
	    0001h pauses between packets
SeeAlso: AX=0002h,AX=0003h,INT 7A/AX=0001h"AutoCAD"
--------A-790002-----------------------------
INT 79 R - AutoCAD Device Interface - DIGITIZER - TERMINATE
	AX = 0002h
SeeAlso: AX=0001h,AX=0003h
--------A-790003-----------------------------
INT 79 R - AutoCAD Device Interface - DIGITIZER - GET DIGITIZER STATUS
	AX = 0003h
Return: AX = status
	    0000h nothing
	    0002h tracking point (no button pressed)
		BX = X coordinate
		CX = Y coordinate
	    0003h picked point (button 0,A,B,C,D pressed)
		BX = X coordinate
		CX = Y coordinate
	    0004h button pick
		BX = button number
	    0005h button and coordinates
		BX = button number
		CX = X coordinate
		DX = Y coordinate
SeeAlso: AX=0001h,AX=0002h
--------N-7A---------------------------------
INT 7A U - Topware Network Operating System - ???
	AL = ???
	???
Return: ???
SeeAlso: INT 21/AX=FF00h"Topware",INT 2F/AX=FF00h
--------N-7A---------------------------------
INT 7A - X.PC Packet software interface
	ES:BX -> parameter block
SeeAlso: INT 60/AX=01FFh
--------E-7A---------------------------------
INT 7A - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ2
Program: GO32.EXE is a DOS extender included as part of the 80386 port of the
	  GNU C/C++ compiler by DJ Delorie and distributed as DJGPP
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 0A,INT 79"GO32",INT 7B"GO32"
--------P-7A---------------------------------
INT 7A O - PRINDIR - API (moved to INT 7C)
SeeAlso: INT 7C"PRINDIR"
--------N-7A---------------------------------
INT 7A - Novell NetWare - LOW-LEVEL API - Notes
Note:	this interrupt is used for IPX/SPX access in NetWare versions through
	  2.0a; in later versions, you should use INT 2F/AX=7A00h to get an
	  entry point even though INT 7A still exists.	For both INT 7A and
	  the FAR entry point, BX contains the function number; IPX is
	  sometimes called internally with BX bit 15 set, which causes the
	  handler to bypass some initial checks and an optional call to the
	  IPX Windows support handler set with INT 2F/AX=7AFFh/BX=0000h
	  (see #1432)
SeeAlso: INT 2F/AX=7A00h,INT 64"Novell",INT 7A/BX=0000h
--------N-7A----BX0000-----------------------
INT 7A - Novell NetWare - IPX Driver - OPEN SOCKET
	BX = 0000h
	AL = socket longevity
	    00h open until close or terminate
	    FFh open until close
	DX = socket number (high byte in DL)
	    0000h dynamic allocation
	    else  socket to open (see #2014)
Return: AL = return code
	    00h success
		DX = socket number
	    FEh socket table full
	    FFh socket already open
Notes:	TSRs which need to use sockets should set AL to FFh, non-resident
	  programs should normally use AL=00h
	IPX can be configured to support up to 150 open sockets on a
	  workstation, and defaults to 20
	this function is supported by Advanced NetWare 1.02+
SeeAlso: INT 7A/BX=0001h,INT 7A/BX=0004h,INT 7A/BX=0023h

(Table 2014)
Values for IPX socket number:
 0451h	File Service (NetWare Core Protocol)
 0452h	Service Advertising Protocol
 0453h	Routing Information Packet
 0455h	NetBIOS Packet
 0456h	diagnostics
 0457h	server serial numbers (labeled "Copy Protection" by Lanalyzer)
 4000h-7FFFh used for dynamic allocation
 4444h	Brightwork Development's SiteLock server
 5555h	Brightwork Development's SiteLock client (workstation)
 8000h-FFFFh assigned by Novell
Note:	SiteLock is an application metering product using IPX to communicate
	  between the application and the license server
--------N-7A----BX0001-----------------------
INT 7A - Novell NetWare - IPX Driver - CLOSE SOCKET
	BX = 0001h
	DX = socket number (high byte in DL)
Notes:	also cancels events set by any Event Control Blocks for the socket
	the program must close all open sockets before terminating
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0000h
--------N-7A----BX0002-----------------------
INT 7A - Novell NetWare - IPX Driver - GET LOCAL TARGET
	BX = 0002h
	ES:SI -> target internetwork address (see INT 7A/BX=000Bh)
	ES:DI -> 6-byte buffer for local target
Return: AL = return code
	    00h success
	       CX = expected one-way transfer time (clock ticks) for a 576-byte
		      packet
	       ES:DI -> local target
	    FAh unsuccessful (no path to destination)
Notes:	the internetwork address consists of a 4-byte network address followed
	  by a 6-byte node address.  The local target is only a 6-byte node
	  address.  If the target is in the same network, the local target is
	  just the node address of target; otherwise, the local target is the
	  node address of the bridge that leads to the target.
	this function may be called from inside IPX and AES Event Service
	  Routines, but not from other interrupt handlers
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0009h
--------N-7A----BX0003-----------------------
INT 7A - Novell NetWare - IPX Driver - SEND PACKET
	BX = 0003h
	ES:SI -> Event Control Block (see #2015,#2016)
Notes:	returns immediately; IPX attempts to send the packet in the background
	this function is supported by Advanced NetWare 1.02+
	this function is nearly identical to BX=000Fh, except that it always
	  copies the source address into the IPX header assumed to be at the
	  beginning of the first fragment
SeeAlso: BX=0004h,BX=000Fh,INT 21/AH=EEh"Novell"

Format of IPX Event Control Block:
Offset	Size	Description	(Table 2015)
 00h	DWORD	Link
 04h	DWORD	-> Event Service Routine (00000000h if none)
 08h	BYTE	in use flag (see #2017)
 09h	BYTE	completion code (see #2018)
 0Ah	WORD	(big-endian) socket number (see INT 7A/BX=0000h)
 0Ch  4 BYTEs	IPX workspace
 10h 12 BYTEs	driver workspace
 1Ch  6 BYTEs	immediate local node address
 22h	WORD	fragment count
 24h	var	fragment descriptors
		Offset	Size	Description
		 00h	DWORD	-> fragment data
		 04h	WORD	size of fragment in bytes.
Notes:	ESR is a far procedure that is called when the ECB has been handled.
	  On call, the in use flag is zero if the ECB has been handled,
	  non-zero otherwise. If the flag is zero, the completion code holds
	  the result of the event.
	the first fragment should start with an IPX header
	all fragments are concatenated and sent in one piece
	node address FFh FFh FFh FFh FFh FFh broadcasts to all nodes

Format of AES-ECB:
Offset	Size	Description	(Table 2016)
 00h	DWORD	Link
 04h	DWORD	ESR address
 08h	BYTE	in use flag (see #2017)
 09h  5 BYTEs	AES workspace

(Table 2017)
Values for ECB in use flag:
 00h	available
 E0h	AES temporary
 F6h	\ special IPX/SPX processing for v3.02+
 F7h	/
 F8h	IPX in critical section
 F9h	SPX listening
 FAh	processing
 FBh	holding
 FCh	AES waiting
 FDh	AES couting down delay time
 FEh	awaiting packet reception
 FFh	sending packet

(Table 2018)
Values for ECB completion code:
 00h	success
 ECh	remote terminated connection without acknowledging packet
 EDh	abnormal connection termination
 EEh	invalid connection ID
 EFh	SPX connection table full
 F9h	event should not be cancelled
 FAh	cannot establish connection with specified destination
 FCh	cancelled
 FDh	malformed packet
 FEh	packet undeliverable
 FFh	physical error

(Table 2019)
Values event Service Routine is called with:
	AL = caller's identity (00h = AES, FFh = IPX)
	ES:SI -> event control block
	interrupts disabled

Format of IPX header:
Offset	Size	Description	(Table 2020)
 00h	WORD	(big-endian) checksum
 02h	WORD	(big-endian) length in bytes of total packet
 04h	BYTE	transport control
 05h	BYTE	packet type (see #2021)
 06h 10 BYTEs	destination internetwork address
 10h	WORD	(big-endian) destination socket
 12h 10 BYTEs	source internetwork address
 1Ch	WORD	(big-endian) source socket

(Table 2021)
Values for IPX packet type:
 00h	unknown packet type
 01h	routing information packet
 02h	echo packet
 03h	error packet
 04h	packet exchange packet (always use this one)
 05h	SPX packet
 11h	NetWare Core Protocol
 14h	Propagated Packet (for NetWare), NetBIOS name packet
 15h-1Eh experimental protocols

Format of Service Advertising Protocol Service Query Packet:
Offset	Size	Description	(Table 2022)
 00h 30 BYTEs	IPX header
 1Eh	WORD	(big-endian) query type
		0001h general find service
		0003h find nearest server
 20h	WORD	(big-endian) server type (see INT 21/AH=E3h"NetWare")

Format of Service Advertising Protocol Server Identification Packet:
Offset	Size	Description	(Table 2023)
 00h 30 BYTEs	IPX header
 1Eh	WORD	(big-endian) response type
		0002h general service
		0004h nearest service
 20h 64N BYTEs	server entries (1-7) (see #2024)

Format of SAP server entry:
Offset	Size	Description	(Table 2024)
 00h	WORD	(big-endian) server type (see INT 21/AH=E3h"NetWare")
 02h 48 BYTEs	ASCIZ server name
 32h  2 WORDs	(big-endian) network number
 34h  3 WORDs	(big-endian) node number
 3Ch	WORD	(big-endian) socket number
 3Eh	WORD	(big-endian) number of hops between caller and server

Format of IPX Routing Information packet:
Offset	Size	Description	(Table 2025)
 00h 30 BYTEs	IPX header
 1Eh	WORD	operation (0001h request, 0002h response)
 20h 8N BYTEs	network entries (1-50) (see #2026)

Format of RIP network entry:
Offset	Size	Description	(Table 2026)
 00h	DWORD	network number (FFFFFFFFh = general request)
 04h	WORD	(response) number of hops
 06h	WORD	(response) number of clock ticks to reach destination
--------N-7A----BX0004-----------------------
INT 7A - Novell NetWare - IPX Driver - LISTEN FOR PACKET
	BX = 0004h
	ES:SI -> Event Control Block (see BX=0003h)
Return: AL = status
	    00h successful
	    FFh no listening socket for packet
Desc:	this function provides IPX with an ECB for receiving an IPX packet, but
	  does not wait for a packet to arrive
Notes:	the application must open a socket and initialize the ECB's ESR
	  address, socket number, fragment count, and fragment descriptor
	  fields before invoking this function
	there is no limit on the number of ECBs which may simultaneously be
	  listening on a socket
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0000h,BX=0003h
--------N-7A----BX0005-----------------------
INT 7A - Novell NetWare - IPX Driver - SCHEDULE IPX EVENT
	BX = 0005h
	AX = delay time in clock ticks
	ES:SI -> Event Control Block (see BX=0003h)
Note:	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0006h,BX=0007h,BX=0008h
--------N-7A----BX0006-----------------------
INT 7A - Novell NetWare - IPX Driver - CANCEL EVENT
	BX = 0006h
	ES:SI -> Event Control Block (see BX=0003h)
Return: AL = return code (see #2027)
Notes:	cannot cancel packets which the node's driver has already sent
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0005h

(Table 2027)
Values for IPX return code:
 00h	success
 F9h	event in use
 FCh	event cancelled
 FFh	unsuccessful, event not in use, or unrecognized ECB flag
--------N-7A----BX0007-----------------------
INT 7A - Novell NetWare - IPX Driver - SCHEDULE SPECIAL EVENT
	BX = 0007h
	AX = delay time
	ES:SI -> Event Control Block (see BX=0003h)
Note:	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0006h
--------N-7A----BX0008-----------------------
INT 7A - Novell NetWare - IPX Driver - GET INTERVAL MARKER
	BX = 0008h
Return: AX = interval marker in clock ticks
Notes:	may be used to measure the time elapsed between two events, up to one
	  hour
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0005h
--------N-7A----BX0009-----------------------
INT 7A - Novell NetWare - IPX Driver - GET INTERNETWORK ADDRESS
	BX = 0009h
	ES:SI -> buffer for own internetwork address (see #2028)
Return: ES:SI buffer filled
	SI destroyed
Note:	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0002h,BX=000Bh

Format of internetwork address:
Offset	Size	Description	(Table 2028)
 00h  4 BYTEs	(big-endian) network number
 04h  6 BYTEs	(big-endian) node number within network
--------N-7A----BX000A-----------------------
INT 7A - Novell NetWare - IPX Driver - RELINQUISH CONTROL
	BX = 000Ah
Desc:	this call indicates that the application is idle and permits the IPX
	  driver to do some work
Note:	this function is supported by Advanced NetWare 1.02+
SeeAlso: INT 15/AX=1000h,INT 21/AH=89h,INT 2F/AX=1680h
--------N-7A----BX000B-----------------------
INT 7A - Novell NetWare - IPX Driver - DISCONNECT FROM TARGET
	BX = 000Bh
	ES:SI -> internetwork address (see #2029)
Notes:	this function permits the network software on the remote machine to
	  remove any virtual connection with the calling machine
	only use in point-to-point networks
	should never be called from within an Event Service Routine
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0002h,BX=0009h

Format of internetwork address:
Offset	Size	Description	(Table 2029)
 00h  4 BYTEs	(big-endian) destination network
 04h  6 BYTEs	(big-endian) destination node
 0Ah  2 BYTEs	(big-endian) destination socket
--------N-7A----BX000C-----------------------
INT 7A U - Novell NetWare - IPX Driver - internal - INITIALIZE NETWORK ADDRESS
	BX = 000Ch
	CX:DX = global network address (see INT 7A/BX=0002h)
	ES:DI -> "OSINCRITICALSECTION" flag
	DS:SI -> current mode for socket
Note:	the address cannot be changed once it has been initialized
--------N-7A----BX000D-----------------------
INT 7A U - Novell NetWare - IPX Driver - internal - IPX GET PACKET SIZE
	BX = 000Dh
Return: AX = maximum packet size
	CX = retry count
SeeAlso: BX=001Ah
--------N-7A----BX000E-----------------------
INT 7A U - Novell NetWare - IPX Driver - internal - TERMINATE SOCKETS
	BX = 000Eh
Return: nothing
Note:	this function terminates all sockets opened with the current mode; this
	  may be intended for future enhancements as the socket mode never
	  changes in v2.15
--------N-7A----BX000F-----------------------
INT 7A U - Novell NetWare - IPX Driver - INTERNAL - SEND PACKET
	BX = 000Fh
	ES:SI -> Event Control Block (see BX=0003h)
Note:	nearly identical to function 0003h, but does not copy address into
	  the first fragment
SeeAlso: BX=0003h
--------N-7A----BX0010-----------------------
INT 7A - Novell NetWare - SPX Driver - INSTALLATION CHECK
	BX = 0010h
	AL = 00h
Return: AL = FFh if SPX loaded
	    BH = SPX major version
	    BL = SPX minor version
	    CX = maximum SPX connections
	    DX = SPX connections available
Notes:	this function is supported by Advanced NetWare 2.1+
	this interrupt is used for IPX/SPX access in NetWare versions through
	  2.0a; in later versions, you should use INT 2F/AX=7A00h to get an
	  entry point even though INT 7A still exists.	For both INT 7A and
	  the FAR entry point, BX contains the function number
	IPX is sometimes called internally with BX bit 15 set, which causes the
	  entry point handler to bypass some checks and an optional call to
	  the IPX Windows support handler set with INT 2F/AX=7AFFh/BX=0000h
	  (see #1432)
SeeAlso: BX=0015h
--------N-7A----BX0011-----------------------
INT 7A - Novell NetWare - SPX Driver - ESTABLISH SPX CONNECTION
	BX = 0011h
	AL = retry count
	AH = watchdog flag
	ES:SI -> Event Control Block (see BX=0003h)
Return: AL = status (see #2030)
	DX = assigned connection ID number
Desc:	attempt to establish a connection with a listening socket
Notes:	there should always be at least two SPX ECB's listening to a socket, so
	  that NetWare can perform its internal packet exchanges
	the first fragment should start with a SPX header.  Fill in all
	  destination addresses.
	this function is supported by Advanced NetWare 2.1+
SeeAlso: BX=0000h,BX=0012h,BX=0013h,BX=0014h,BX=0015h

(Table 2030)
Values for SPX function status:
 00h	attempting to contact destination socket
 EFh	local connection table full
 FDh	buffer size not 42 or fragment count not 1
 FFh	sending socket not open

Format of SPX header:
Offset	Size	Description	(Table 2031)
 00h	WORD	(big-endian) checksum
 02h	WORD	(big-endian) length in bytes of total packet
 04h	BYTE	transport control
 05h	BYTE	packet type (see INT 7A/BX=0003h)
 06h 10 BYTEs	destination internet address
 10h	WORD	(big-endian) destination socket
 12h 10 BYTEs	source internet address
 1Ch	WORD	(big-endian) source socket
 1Eh	BYTE	connection control (see #2032)
 1Fh	BYTE	datastream type
		FEh terminate connection request packet
		FFh terminate connection acknowledgement packet
		other user-defined, ignored by SPX
 20h	WORD	(big-endian) source connection ID
 22h	WORD	(big-endian) destination connection ID
 24h	WORD	(big-endian) sequence number
 26h	WORD	(big-endian) acknowledge number
 28h	WORD	(big-endian) allocation number

Bitfields for connection control:
Bit(s)	Description	(Table 2032)
 3-0	unused???
 4	end of message
 5	reserved
 6	acknowledgement required
 7	system packet
--------N-7A----BX0012-----------------------
INT 7A - Novell NetWare - SPX Driver - LISTEN FOR SPX CONNECTION
	BX = 0012h
	AH = watchdog flag (00h disabled, 01h enabled)
	AL = retry count (00h = default)
	ES:SI -> Event Control Block (see BX=0003h)
Notes:	there should always be at least two SPX ECB's listening to a socket, so
	  that NetWare can perform its internal packet exchanges
	this function is supported by Advanced NetWare 2.1+
SeeAlso: BX=0011h,BX=0013h,BX=0014h
--------N-7A----BX0013-----------------------
INT 7A - Novell NetWare - SPX Driver - TERMINATE SPX CONNECTION
	BX = 0013h
	DX = connection ID to terminate
	ES:SI -> Event Control Block (see BX=0003h)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: BX=0011h,BX=0012h,BX=0014h
--------N-7A----BX0014-----------------------
INT 7A - Novell NetWare - SPX Driver - ABORT SPX CONNECTION
	BX = 0014h
	DX = connection ID to terminate
Notes:	this function is supported by Advanced NetWare 2.1+
	this function does not tell the other side that the connection has been
	  terminated
	also aborts any outstanding Establish Connection, Terminate Connection,
	  and Send Sequenced Packet commands
SeeAlso: BX=0011h,BX=0013h
--------N-7A----BX0015-----------------------
INT 7A - Novell NetWare - SPX Driver - GET SPX CONNECTION STATUS
	BX = 0015h
	DX = connection ID
	ES:SI -> status buffer (see #2033)
Return: AL = return code
	    00h connection still valid
		ES:SI -> status buffer filled
	    EEh no such connection
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: BX=0010h,BX=0011h

Format of status buffer:
Offset	Size	Description	(Table 2033)
 00h	BYTE	connection state
		01h waiting to establish connection
		02h starting (attempting to create connection)
		03h connection established
		04h terminating
 01h	BYTE	watchdog flag
		bit 0: used internally by SPX
		bit 1: SPX watchdog is monitoring connection
		bits 2-7 used internally by SPX
 02h	WORD	(big-endian) source connection ID
 04h	WORD	(big-endian) destination connection ID
 06h	WORD	(big-endian) sequence number of next packet sent
 08h	WORD	(big-endian) acknowledge number, expected sequence number of
		  next received packet
 0Ah	WORD	(big-endian) maximum sequence number remote SPX may send
		  without ACK from local SPX
 0Ch	WORD	(big-endian) remote acknowledge number, next sequence number
		  remote SPX expects to receive
 0Eh	WORD	(big-endian) remote allocation number, maximum sequence number
		  local SPX may send
 10h	WORD	(big-endian) connection socket
 12h  6 BYTEs	immediate node address--bridge on local network to destination
 18h 10 BYTEs	destination internetwork address (see INT 7A/BX=000Bh)
 22h	WORD	(big-endian) retransmit count
 24h	WORD	(big-endian) estimated roundtrip delay
 26h	WORD	(big-endian) retransmitted packets
 28h	WORD	(big-endian) suppressed packets
 2Ah 12 BYTEs	??? (v2.15)
--------N-7A----BX0016-----------------------
INT 7A - Novell NetWare - SPX Driver - SEND SPX PACKET
	BX = 0016h
	DX = connection ID
	ES:SI -> Event Control Block (see BX=0003h)
Notes:	this function is supported by Advanced NetWare 2.1+
	CX may need to be 0001h ???
SeeAlso: BX=0011h,BX=0017h
--------N-7A----BX0017-----------------------
INT 7A - Novell NetWare - SPX Driver - LISTEN FOR SPX PACKET
	BX = 0017h
	DX = connection ID (unused in v2.15)
	ES:SI -> Event Control Block (see BX=0003h)
Notes:	this function is supported by Advanced NetWare 2.1+
	CX may need to be 0001h ???
SeeAlso: BX=0011h,BX=0016h
--------N-7A----BX0018-----------------------
INT 7A U - Novell NetWare - IPX Driver - internal - ADD DIAGNOSTIC ELEMENT
	BX = 0018h
	ES:SI -> diagnostic element (see #2034) to be added to Diagnostic Queue
Note:	this function is supported on file servers only under v2.15; v3.02 also
	  supports it on workstations
SeeAlso: BX=0019h

Format of diagnostic element:
Offset	Size	Description	(Table 2034)
 00h	DWORD	pointer to next diagnostic element
 04h	DWORD	pointer to function for ???
 08h	DWORD	pointer to function for ???
--------N-7A----BX0019-----------------------
INT 7A U - Novell NetWare - IPX Driver - internal - CANCEL DIAGNOSTIC ELEMENT
	BX = 0019h
	ES:SI -> diagnostic element (see BX=0018h) to be removed
Note:	this function is supported on file servers only under v2.15; v3.02 also
	  supports it on workstations
SeeAlso: BX=0018h
--------N-7A----BX001A-----------------------
INT 7A - Novell NetWare - IPX Driver - internal - GET DRIVER PACKT SIZE LIMIT
	BX = 001Ah
Return: AX = packet size with preamble
	CX = IPX retry count
Note:	this function is has existed since November 1989; it is documented in
	  Novell document FYI.A.3709, 03May91
SeeAlso: BX=000Dh
--------N-7A----BX001B-----------------------
INT 7A U - Novell NetWare - IPX Driver - INTERNAL
	BX = 001Bh
	???
Return: ???
Notes:	this function is supported on file servers only under v2.15; v3.02 also
	  supports it on workstations
	used by NetWare Access Server
--------N-7A----BX001C-----------------------
INT 7A U - Novell NetWare - NetWare Access Server - ???
	BX = 001Ch to 001Eh
	???
Return: ???
	BX corrupted
Notes:	these functions are NOPs for standard IPX drivers such as IPXODI v2.12
SeeAlso: INT 2F/AX=7AF1h
--------N-7A----BX001F-----------------------
INT 7A U - Novell NetWare - IPXODI v2.12+ - GET ???
	BX = 001Fh
Return: AX = ???
	BX:CX -> ??? entry point (see #2035)
	DX = flags
	    bit 0: IPXODI rather than dedicated IPX
	    bit 1: checksumming functions 0020h-0022h supported
	ES:SI -> ???
Note:	IPXODI v2.12 is distributed as part of the Personal NetWare system
	  bundled with Novell DOS 7
SeeAlso: BX=0020h,INT 2F/AX=7A2Fh

(Table 2035)
Call entry point with:
	ES:SI -> ??? data (offset 24h is far pointer to ??? data)
--------N-7A----BX0020-----------------------
INT 7A U - Novell NetWare - IPXODI v2.12+ - ??? CHECKSUMMING
	BX = 0020h
	ES:SI -> ??? data (see #2036)
Return: ???
	BX,BP corrupted
SeeAlso: BX=001Fh,BX=0021h,BX=0022h,INT 2F/AX=7A2Fh

Format of data:
Offset	Size	Description	(Table 2036)
 00h  8 BYTEs	???
 08h	BYTE	(return) ???
 09h	BYTE	(return) ???
 0Ah	WORD	???
 0Ch 16 BYTEs	???
 1Ch  3 WORDs	???
 22h	WORD	number of records at offset 28h
 24h	DWORD	-> ???
 28h 6N BYTEs	??? records
--------N-7A----BX0021-----------------------
INT 7A U - Novell NetWare - IPXODI v2.12+ - ??? CHECKSUMMING
	BX = 0021h
	ES:SI -> ??? data (see BX=0020h)
Return: ???
	BX,BP corrupted
SeeAlso: BX=001Fh,BX=0020h,BX=0022h,INT 2F/AX=7A2Fh
--------N-7A----BX0022-----------------------
INT 7A U - Novell NetWare - IPXODI v2.12+ - ??? CHECKSUMMING
	BX = 0022h
	ES:SI -> ??? data (see BX=0020h)
	???
Return: ???
	BX,BP corrupted
SeeAlso: BX=001Fh,BX=0020h,BX=0021h,INT 2F/AX=7A2Fh
--------N-7A----BX0023-----------------------
INT 7A U - Novell NetWare - IPXODI v2.12+ - OPEN LOOK-AHEAD SOCKET
	BX = 0023h
	AL = ???
	DX = socket number
	ES:SI -> Look Ahead handler
Return: AL = 00h if successful
	BX corrupted
Note:	the socket will always be long-lived, and must thus be explicitly
	  closed with INT 7A/BX=0001h before the Look Ahead handler code is
	  removed from memory (i.e. the program terminates)
SeeAlso: INT 7A/BX=0000h,INT 7A/BX=0001h
--------A-7A0001-----------------------------
INT 7A R - AutoCAD Device Interface - DISPLAY - INITIALIZE (INIT1)
	AX = 0001h
	BX = configuration
	CX = interface level (0001h)
Return: AX = status
	    0000h initialization failed
	    0001h pre-v4.0 driver initialized successfully
	    0003h post-v3.1 driver initialized successfully (driver truncates
		  excessivly long packets)
	BX = width of graphics area in pixels, or 0000h if using packet
		  communication
	DX:CX -> packet-mode entry point (see #2037)
SeeAlso: AX=0001h,AX=0200h,AX=07D0h,INT 61/AX=0007h"OPTIMA",INT 78"AutoCAD"
SeeAlso: INT 79/AX=0001h,INT 7B/AX=8001h"AutoCAD",INT 7C"AutoShade"

(Table 2037)
Call packet-mode entry point with:
STACK:	DWORD	pointer to request packet (see #2038)
	WORD	length of packet

Format of request packet:
Offset	Size	Description	(Table 2038)
 00h	WORD	function number (00h-45h for Compaq VGADI41.EXE)
--------A-7A0200BX0000-----------------------
INT 7A R - AutoCAD Device Interface - RENDERING DEVICE - INITIALIZE (RDLINKUP)
	AX = 0200h
	BX = 0000h
	CX = interface level (0001h)
Return: BX = 0000h (driver uses packet communication)
	DX:CX -> packet-mode entry point (see #2037)
SeeAlso: AX=0001h"AutoCAD",INT 79/AX=0001h,INT 7B/AX=8001h"AutoCAD"
--------I-7A04-------------------------------
INT 7A - IBM 3270 Workstation Program API - CREATE A QUEUE
	AH = 04h
	???
Return: ???
SeeAlso: AH=06h
--------I-7A06-------------------------------
INT 7A - IBM 3270 Workstation Program API - DELETE A QUEUE
	AH = 06h
	???
Return: ???
SeeAlso: AH=04h
----------7A07D0-----------------------------
INT 7A R - AutoCAD Device Interface - Compaq VGADI41.EXE - GET ENTRY POINT
	AX = 07D0h
Return: AX = ??? (0003h)
	BX = 0000h
	DX:CX -> ADI entry point (see AX=0001h)
SeeAlso: AX=0001h
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - SESSION SERVICES
	AH = 09h
	BX = 8020h (synchronous request)
	CX = 0000h
	DX = ID of session manager (SESSMGR)
	AL = service (see #2039)
	ES:DI -> control block
Return: ???

(Table 2039)
Values for service:
 01h	get session ID
 02h	get session info
 04h	dettach from session
 05h	attach to session
 06h	get list of windows available
 07h	get environment of window
 08h	get 'PIF' (program information file) info
 0Ah	get base window ID
 0Bh	get cursor info
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - KEYBOARD SERVICES
	AH = 09h
	BX = 8020h (synchronous request)
	CX = 0000h
	DX = ID of keyboard manager
	AL = service number (see #2040)
	ES:DI -> control block
Return: ???

(Table 2040)
Values for 3270 Workstation Program keyboard service:
 01h	connect to keyboard
 02h	disconnect from keyboard
 03h	read from keyboard
 04h	send keystroke to session
 05h	disable input
 06h	enable input
 07h	update status code
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - WINDOW SERVICES
	AH = 09h
	BX = 8020h (synchronous request)
	CX = 00FFh
	DX = ID of window service controller (WSCTRL)
	AL = service number (see #2041)
	ES:DI -> control block
Return: ???

(Table 2041)
Values for 3270 Workstation Program window service:
 01h	connect to WS control
 02h	disconnect from WS control
 03h	add a window
 04h	change window's position on screen
 05h	change window's size
 06h	change window's color
 07h	change window's position in the presentation space
 08h	hide/unhide toggle
 09h	enlarge/reduce toggle
 0Ah	change screen background color
 0Bh	get window's position on screen
 0Ch	get window's size
 0Dh	get window's color
 0Eh	get window's position in the presentation space
 0Fh	determine whether hidden
 10h	determine whether enlarged
 11h	get background color
 12h	get window names
 13h	delete all windows from profile
 14h	pick active window
 15h	redraw screen
 16h	redraw window
 17h	delete a window from profile
 18h	get active window
 19h	get active screen
 1Ah	get window data
 1Bh	change window data
 1Ch	select active screen
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - PRESENTATION SPACE SERVICES
	AH = 09h
	BX = 8020h
	CX = 00FFh
	DX = ID of PCPSM
	AL = service
	    01h define presentation space
	    02h delete presentation space
	    03h display presentation space
	    04h position cursor in presentation space
	    05h change default presentation space
	ES:DI -> control block
Return: ???
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - 3270 EMULATION
	AH = 09h
	BX = 8020h
	CX = 00FFh
	DX = ID of 3270EML
	AL = service
	    01h connect
	    02h disconnect
	ES:DI -> control block
Return: ???
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - OPERATOR INFORMATION AREA
	AH = 09h
	BX = 8020h
	CX = 00FFh
	DX = ID of OIAM
	AL = service
	    01h read Operator Information Area
	    02h read OIA subset
	ES:DI -> control block
Return: ???
Note: the OIA is the 25th line on the Host session
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - TRANSLATE DATA
	AH = 09h
	BX = 8020h
	CX = 00FFh
	DX = ID of XLATE
	AL = service
	    01h translate from host characters to ASCII and vice versa
		(determined by control block byte 11)
	ES:DI -> control block
Return: ???
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - COPY SERVICE
	AH = 09h
	BX = 8020h
	CX = 00FFh
	DX = ID of copy service
	AL = service
	    01h copy string from one presentation space to another
	    02h copy block from one presentation space to another
	    03h connect to PC session for copy
	    04h disconnect PC session from copy
	ES:DI -> control block
Return: ???
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - Multi-DOS
	AH = 09h
	BX = 8020h
	CX = 00FFh
	ES:DI -> control block
	DX = ID of INDJQRY
		get environment size
	   = ID of INDJASY
		request DOS functions from workstation
	   = ID of MEMORY
		AL = function
		    01h allocate memory
		    02h deallocate memory
		    03h modify allocated size
Return: ???
--------I-7A09-------------------------------
INT 7A - IBM 3270 Workstation Program API - HOST SERVICES
	AH = 09h
	BX = request type (4000h async, 8028h synchronous)
	CX = 0000h
	DX = ID of MFIC
	AL = service (see #2042)
	ES:DI -> control block

(Table 2042)
Values for 3270 Workstation Program host service:
 01h	connect to host
 02h	disconnect from host
 03h	read DFT structured data from host
 04h	write DFT structured data to host
 05h	create a host buffer
--------I-7A13-------------------------------
INT 7A - IBM 3270 Workstation Program API - GET DATA FROM A QUEUE
	AH = 13h
	???
Return: ???
----------7A7A-------------------------------
INT 7A - Canon IX-30F Image Scanner SI3.SYS - INTERFACE
	AH = 7Ah
	???
Return: AX = status
	    0000h success
	    000Eh undefined function code
Range:	unknown, selected by device driver commandline arguments
--------I-7A81-------------------------------
INT 7A - IBM 3270 Workstation Program API - RESOLVE A GATE NAME
	AH = 81h
	ES:DI -> 8-char blank-padded gate name (see #2043)
Return: DX = gate ID

(Table 2043)
Values for 3270 Workstation Program gate name:
 "SESSMGR "
 "KEYBOARD"
 "WSCTRL  "
 "MFIC    "
 "PCPSM	  "
 "3270EML "
 "COPY    "
 "XLATE	  "
 "OIAM    "
 "MEMORY  "
 "INDJQRY "
 "INDJASY "
--------I-7A83-------------------------------
INT 7A - IBM 3270 Workstation Program API - GET COMPLETION RESULTS
	AH = 83h
	???
Return: ???
--------I-7AFDCB-----------------------------
INT 7A - IBM Personal Communications/3270 - INSTALLATION CHECK
	AX = FDCBh
Return: DX:AX -> PCS/3270 signature block if loaded (see #2044)

Format of Personal Communications/3270 signature block:
Offset	Size	Description	(Table 2044)
 04h	WORD	PCS/3270 signature (5741h)
 06h	WORD	version (0501h = PCS/3270 v1.0)
--------I-7AFE01-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL SEND/RECEIVE FUNCTION
	AX = FE01h
	???
Return: ???
SeeAlso: AX=FE02h
--------I-7AFE02-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL SEND/RECEIVE FUNCTION
	AX = FE02h
	???
Return: ???
SeeAlso: AX=FE01h
--------I-7AFF01-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL API INITIALIZATION
	AX = FF01h
	ES:DI -> API function handler routine
Return: CX = 1200h
SeeAlso: AX=FF02h,AX=FF03h
--------I-7AFF02-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL API TERMINATION
	AX = FF02h
Return: CX = 1200h
SeeAlso: AX=FF01h
--------I-7AFF03-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL API INITIALIZATION
	AX = FF03h
	ES:DI -> send/receive function handler routine
Return: CX = 1200h
SeeAlso: AX=FF01h
--------I-7AFF04-----------------------------
INT 7A U - IBM PC3270 EMUL PROG v3 - INTERNAL ???
	AX = FF04h
	ES:DI -> ???
Return: CX = 1200h
--------f-7B---------------------------------
INT 7B - Btrieve API (single user)
	DS:DX -> 38-byte parameter record (see #2045)
Return: return code field set
Note:	Btrieve sets low byte of vector to 33h; this serves as the installation
	  check
SeeAlso: INT 2F/AX=AB01h,INT 7F/AX=0200h

Format of Btrieve parameter record:
Offset	Size	Description	(Table 2045)
 00h	DWORD	pointer to data buffer
 04h	WORD	data buffer length
 06h	DWORD	pointer to 90-byte record containing positioning info
		(should be same for all calls for same file)
 0Ah	DWORD	pointer to 38-byte FCB info buffer
		(should be same for all calls for same file)
 0Eh	WORD	function code (see #2046)
 10h	DWORD	pointer to file name/key buffer
 14h	BYTE	key length
 15h	BYTE	key number
 16h	DWORD	pointer to status code (see #2047)
 1Ah	WORD	interface code (version specific)
		6176h version 5.10

(Table 2046)
Values for function code:
 00h	open
 01h	close
 02h	insert
 03h	update
 04h	delete
 05h	get_equal
 06h	get_next
 07h	get_prev
 08h	get_greater
 09h	get_gr_eql
 0Ah	get_less
 0Bh	get_less_eq
 0Ch	get_first
 0Dh	get_last
 0Eh	create
 0Fh	stat
 10h	extend
 11h	set_dir: set directory information
 12h	get_dir: get directory information
 13h	begin_trans
 14h	end_trans
 15h	abort_trans
 16h	get_pos: get record position number
 17h	get_direct: get data by sending record position
 18h	step_next
 19h	stop
 1Ah	version
 1Bh	unlock
 1Ch	reset
 1Dh	set owner
 1Eh	clear owner
 1Fh	create supplemental index
 20h	drop supplemental index
 21h	step first
 22h	step last
 23h	step previous
 24h	get next extended: get multiple records using a filter
 25h	get previous extended: get multiple records using a filter
 26h	step next extended: get multiple records using a filter
 27h	step previous extended: get multiple records using a filter
 28h	insert extended: insert one or more records
 31h	???
Notes:	add 50 (32h) to any "get" operation to just return the key data
	add 100 (64h) for a single-record wait lock (automatically released
	  on next get)
	add 200 (C8h) for a single-record nowait lock (nowait lock returns
	  error 54h or 55h if record already locked)
	add 300 (12Ch) for a multiple-record wait lock (not released until
	  unlock called)
	add 400 (190h) for a multiple-record nowait lock (nowait lock returns
	  error 54h or 55h if record already locked)

(Table 2047)
Values for Btrieve status code:
 00h	successful
 01h	invalid operation
 02h	I/O error
 03h	file not open
 04h	key value not found
 05h	duplicate key value
 06h	invalid key number
 07h	different key number
 08h	invalid positioning
 09h	end of file
 0Ah	modifiable key value error
 0Bh	invalid file name
 0Ch	file not found
 0Dh	extended file error
 0Eh	pre-image open error
 0Fh	pre-image I/O error
 10h	expansion error
 11h	close error
 12h	disk full
 13h	unrecoverable error
 14h	record manager inactive
 15h	key buffer too short
 16h	data buffer length overrun
 17h	position block length
 18h	page size error
 19h	create I/O error
 1Ah	number of keys
 1Bh	invalid key position
 1Ch	invalid record length
 1Dh	invalid key length
 1Eh	not a Btrieve file
 1Fh	file already extended
 20h	extended I/O error
 22h	invalid extension name
 23h	directory error
 24h	transaction error
 25h	transaction is active
 26h	transaction control file I/O error
 27h	end/abort transaction error
 28h	transaction max files
 29h	operation not allowed
 2Ah	incomplete accelerated access
 2Bh	invalid record address
 2Ch	null key path
 2Dh	inconsistent key flags
 2Eh	access to file denied
 2Fh	maximum open files
 30h	invalid alternate sequence definition
 31h	key type error
 32h	owner already set
 33h	invalid owner
 34h	error writing cache
 35h	invalid interface
 36h	variable page error
 37h	autoincrement error
 38h	incomplete index
 39h	expanded memory error
 3Ah	compression buffer too short
 3Bh	file already exists
 3Ch	reject count reached
 3Dh	work space too small
 3Eh	incorrect descriptor
 3Fh	invalid extended insert
 40h	filter limit reached
 41h	incorrect field offset
 4Ah	automatic transaction abort
 4Dh	Btrieve engine busy or resource locked by another user
 4Eh	deadlock detected
 50h	conflict
 51h	lock error
 52h	lost position
 53h	read outside transaction
 54h	record in use
 55h	file in use
 56h	file table full
 57h	handle table full
 58h	incompatible open mode
 5Ah	redirected device table full
 5Bh	server error
 5Ch	transaction table full
 5Dh	incompatible lock type
 5Eh	permission error
 5Fh	session no longer valid
 60h	communications environment error
 61h	data message too small
 62h	internal transaction error
--------I-7B---------------------------------
INT 7B - Eicon Access API (3270/5250 gateways)
SeeAlso: INT 5C"NetBIOS"
--------E-7B---------------------------------
INT 7B - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ3
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 0B,INT 10/AH=FFh"GO32",INT 7A"GO32",INT 7C"GO32"
--------A-7B---------------------------------
INT 7B CR - AutoCAD Device Interface - PRINTER/PLOTTER - SEND PLOTTING DATA
	AX = data length (0000h-7FFFh)
	CX:BX -> data to be plotted
	DX = vertical position of line on page
Return: nothing
Notes:	This interrupt is called by AutoCAD to perform its output
	A data length of 0000h indicates that a blank line is to be output
SeeAlso: AX=8001h,AX=8002h,INT 78"AutoCAD",INT 7A/AX=0001h"AutoCAD"
----------7B---------------------------------
INT 7B - Novell XQL - XQL PRIMITIVES MANAGER API
	DS:DX -> parameter block (see #2048)
Return: parameter block updated

(Table 2048)
Values for Novell XQL function number:
 00h	log in
 01h	log out
 02h	"tNewFcn"
 03h	"tFreeFcn"
 04h	"tMoveFldFcn"
 05h	"tFieldFcn"
 06h	"tDescribeFcn"
 07h	"tFetchFcn"
 08h	"tComputeFcn"
 09h	"tOrderFcn"
 0Ah	"tRestrictFcn"
 0Bh	"tJoinFcn"
 0Ch	"tInsertFcn"
 0Dh	"tUpdateFcn"
 0Eh	"tUpdallFcn"
 0Fh	"tRemoveFcn"
 10h	"tRemallFcn"
 11h	"tResetFcn"
 12h	"tTransFcn"
 13h	"tStatFcn"
 14h	"tDDCreFcn"
 15h	"tStoreFcn"
 16h	"tRecallFcn"
 17h	"tStopFcn"
 18h	"tDDFileFcn"
 19h	"tDDFieldFcn"
 1Ah	"tDDIndexFcn"
 1Bh	"tDDModFcn"
 1Ch	"tDDViewFcn"
 1Dh	"tDDDrpFcn"
 1Eh	"tDDPathFcn"
 1Fh	"tDDAttrFcn"
 20h	"tDDFcn"
 21h	"tSecurFcn"
 22h	"tUserFcn"
 23h	"tAccessFcn"
 24h	"tPswdFcn"
 25h	"tCharFcn"
 26h	"tVersionFcn"
 27h	"tCnvFcn"
 28h	"tValFcn"
 29h	"tMaskFcn"

Format of XQL parameter block:
Offset	Size	Description	(Table 2049)
 00h  4 BYTEs	signature "XQLP"
 04h	WORD	function number (see #2048)
 06h	WORD	handle
 08h	WORD	status
 0Ah	WORD	session ID
 0Ch	var	data record (varies by function)
---function 00h---
 0Ch	DWORD	-> user name
 10h	DWORD	-> password
 14h	DWORD	-> dictionary
 18h	DWORD	-> filepath
 1Ch	DWORD	-> machine name
 20h	WORD	process ID
---function 01h---
 no additional fields???
---function 02h---
 0Ch	DWORD	-> filename
 10h	DWORD	-> owner name
 14h	WORD	open mode
---function 03h---
 no additional fields???
---function 04h---
 0Ch	WORD	"frompos"
 0Eh	WORD	"topos"
---function 05h---
 0Ch	WORD	subfunction
 0Eh	WORD	position
 10h	WORD	count
 12h	DWORD	-> field list
---function 06h---
 0Ch	WORD	subfunction
 0Eh	WORD	length of description
 10h	WORD	position
 12h	WORD	count
 14h	DWORD	pointer to description list
---function 07h---
 0Ch	WORD	data length
 0Eh	WORD	"op"
 10h	DWORD	"select"
 14h	DWORD	"reject"
 18h	DWORD	pointer to data buffer
---function 08h---
 0Ch	DWORD	-> field name
 10h	WORD	field type
 12h	WORD	field size
 14h	WORD	"flddec"
 16h	WORD	"explen"
 18h	DWORD	pointer to "expbuf"
---function 09h---
 0Ch	WORD	count
 0Eh	DWORD	-> field list
---function 0Ah---
 0Ch	WORD	"newexp"
 0Eh	WORD	"explen"
 10h	DWORD	-> "expbuf"
---function 0Bh---
 0Ch	DWORD	-> filename
 10h	DWORD	-> owner name
 14h	WORD	type of join
 16h	WORD	"pCount"
 18h	DWORD	-> "pNames"
 1Ch	WORD	"sCount"
 1Eh	DWORD	-> "sNames"
---functions 0Ch, 0Dh, 0Fh---
 0Ch	WORD	file count
 0Eh	DWORD	-> file list
 12h	DWORD	count
 16h	DWORD	-> buffer
---function 0Eh---
 0Ch	WORD	file count
 0Eh	DWORD	-> file list
 12h	WORD	"op"
 14h	DWORD	"select"
 18h	DWORD	"reject"
 1Ch	WORD	count
 1Eh	DWORD	-> "res"
 22h	DWORD	-> "comp"
---function 10h---
 0Ch	WORD	file count
 0Eh	DWORD	-> file list
 12h	WORD	"op"
 14h	DWORD	"select"
 18h	DWORD	"reject"
---function 11h---
 0Ch	DWORD	machine name
---function 12h---
 0Ch	WORD	option
---function 13h---
 0Ch	WORD	subfunction
 0Eh	WORD	length of buffer
 10h	DWORD	-> buffer
---function 14h---
 0Ch	WORD	subfunction
 0Eh	DWORD	-> filename
 12h	WORD	"create"
 14h	DWORD	-> pathname
 18h	DWORD	-> owner name
 1Ch	WORD	owner access restrictions
 1Eh	WORD	number of fields
 20h	DWORD	-> field list
 24h	WORD	number of keys
 28h	DWORD	-> key list
 2Ch	WORD	"buflen"
 2Eh	DWORD	-> create parameters
---function 15h---
 0Ch	DWORD	-> "StoreName"
 10h	WORD	length of buffer
 12h	DWORD	-> buffer
---function 16h---
 0Ch	DWORD	-> "RecallName"
 10h	WORD	owner number
 12h	DWORD	-> owner list
 16h	WORD	open mode
 18h	WORD	length of buffer
 1Ah	DWORD	-> buffer
---function 17h---
 no additional fields???
---function 18h---
 0Ch	WORD	"rtype"
 0Eh	WORD	count
 10h	DWORD	-> "filebuf"
 14h	WORD	length of following buffer
 16h	DWORD	-> output buffer
---functions 19h, 1Ah---
 0Ch	WORD	"rtype"
 0Eh	WORD	count
 10h	DWORD	-> field buffer
 14h	WORD	length of following buffer
 16h	DWORD	-> output buffer
---function 1Bh---
 0Ch	WORD	subfunction
 0Eh	DWORD	-> filename
 12h	WORD	"create"
 14h	DWORD	-> pathname
 18h	DWORD	-> owner name
 1Ch	WORD	owner access restrictions
 1Eh	WORD	field count
 20h	DWORD	-> field list
 24h	WORD	number of keys
 26h	DWORD	-> list of keys
---function 1Ch---
 0Ch	WORD	count
 0Eh	DWORD	-> view name
 12h	WORD	length of following buffer
 14h	DWORD	-> output buffer
---function 1Dh---
 0Ch	DWORD	-> filename
 10h	WORD	file type
 12h	WORD	"deletepath"
---function 1Eh---
 0Ch	WORD	"dirtype"
 0Eh	DWORD	-> pathname
---function 1Fh---
 0Ch	WORD	function
 0Eh	DWORD	-> field name
 12h	WORD	attribute
 14h	WORD	size of buffer
 16h	DWORD	-> buffer for attributes
---function 20h---
 0Ch	DWORD	-> directory path
 10h	WORD	function
---function 21h---
 0Ch	DWORD	-> master password
 10h	WORD	"securityflag"
---function 22h---
 0Ch	DWORD	-> master password
 10h	WORD	function (add/modify/remove)
 12h	DWORD	-> user name
 16h	DWORD	-> password
 1Ah	WORD	global rights
 1Ch	WORD	count
 1Eh	WORD	length of following buffer
 20h	DWORD	-> "userbuf"
---function 23h---
 0Ch	DWORD	-> master password
 10h	DWORD	-> user name
 14h	WORD	function (allow/deny/getrights)
 16h	WORD	rights
 18h	DWORD	-> filename
 1Ch	WORD	number of field names in following buffer
 1Eh	DWORD	-> field names
 22h	WORD	maximum buffer length
 24h	DWORD	-> output buffer
---function 24h---
 0Ch	DWORD	-> user name
 10h	DWORD	-> password
---function 25h---
 0Ch	WORD	"charFcn"
 0Eh	WORD	"charType"
 10h	WORD	"charValue"
---function 26h---
 0Ch	DWORD	-> buffer
---function 27h---
 0Ch	WORD	option
 0Eh	WORD	type
 10h	WORD	size
 12h	WORD	"dec"
 14h	WORD	"dsize"
 16h	DWORD	-> value
 1Ah	DWORD	-> "retval"
 1Eh	DWORD	-> mask
 22h	WORD	"justify"
---function 28h---
 0Ch	DWORD	-> field name
 10h	WORD	length of buffer
 12h	DWORD	-> buffer for data
---function 29h---
 0Ch	WORD	option
 0Eh	WORD	type
 10h	WORD	size
 12h	WORD	"dec"
 14h	WORD	length of mask
 16h	DWORD	-> mask
--------A-7B8001-----------------------------
INT 7B R - AutoCAD Device Interface - PRINTER/PLOTTER - BEGIN PLOT
	AX = 8001h
	BX = file level
	    0000h binary file
	    0001h CAD/camera image file
	    0002h installed ADI driver
	CX = horizontal size in pixels
	DX = vertical size in pixels
Return: AX = status (0000h initialization failed, 0001h init successful)
	BX = allowed output format
	    0000h monochrome
	    0001h color (4 bits per pixel)
SeeAlso: AX=8002h,AX=8003h,INT 7B"AutoCAD",INT 7C"AutoShade"
--------A-7B8002-----------------------------
INT 7B R - AutoCAD Device Interface - PRINTER/PLOTTER - END PLOT
	AX = 8002h
SeeAlso: AX=8001h,AX=8003h
--------A-7B8003-----------------------------
INT 7B R - AutoCAD Device Interface - PRINTER/PLOTTER - ABORT PLOT
	AX = 8003h
SeeAlso: AX=8001h,AX=8002h
--------r-7C---------------------------------
INT 7C U - IBM REXX88PC command language
	???
--------E-7C---------------------------------
INT 7C - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ4
Program: GO32.EXE is a DOS extender included as part of the 80386 port of the
	  GNU C/C++ compiler by DJ Delorie and distributed as DJGPP
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 0C,INT 7B"GO32",INT 7D"GO32"
--------P-7C---------------------------------
INT 7C - PRINDIR v8.02+ - API
	AH = function
	   00h set output to Invisible mode
	   01h set output to LPT1
	   02h set output to LPT2
	   03h set output to LPT3
	   04h set output to COM1
	   05h set output to COM2
	   06h set output to COM3
	   07h set output to COM4
	   08h set output to screen
	   09h set output to file
	   0Ah change file path
	       ES:DI -> new path
	       CX = length of path (max 41, but not range-checked)
	   0Bh change file name
	       ES:DI -> new filename
	       CX = length of new name (max 41, but not range-checked)
	   0Ch set redirected device
		(01h = LPT1 ... 03h = LPT3, 04h = COM1 ... 07h = COM4)
	   0Dh force buffer dump
	   0Eh set display color
	       AL = new color attribute (see INT 10/AH=08h)
	   0Fh set popup hotkey
	       AL = hotkey scancode
	   10h toggle byte display
	       AL = new state (00h off, 01h on)
	   11h change buffer flush delay
	       AL = timer ticks before flush
Return: AX = status
	    0000h successful
	    0001h invalid function or nothing in buffer to be dumped
	    (documented as "nonzero = error")
Program: PRINDIR is a shareware printer-redirection program by J.M. Allen
	  Creations
Notes:	the installation check consists of testing for the ASCIZ signature
	  "PRINDIR N.NN" (where N.NN is the version number) two bytes beyond
	  the start of the interrupt handler
	prior versions of PRINDIR used INT 7A instead of INT 7C
SeeAlso: INT 7A"PRINDIR"
Index:	hotkeys;PRINDIR
--------A-7C---------------------------------
INT 7C - AutoShade v2 - RENDERING HARDCOPY DRIVER
Note:	this is the default interrupt vector for rendering hardcopy drivers
	  instead of INT 7A used by AutoCAD drivers
SeeAlso: INT 7A/AX=0001h"AutoCAD"
--------N-7C---------------------------------
INT 7C - SK-UPPS/SK-PASSPORT Data Link Interface (DLI) API
Program: SK-UPPS is the Schneider & Koch Universal Portable Protocol Stack,
	  which provides an API on top of it Data Link Interface, allowing the
	  use of any of several network transport layers; this product is
	  called SK-PASSPORT in the USA.
Notes:	The installation check consists of testing for the ASCII signature
	  string "UPPS_DLI" immediately preceding the interrupt handler.
	To find the service interrupt being used by the driver, an application
	  should scan through the interrupt table until it finds an interrupt
	  vector with the "UPPS_DLI" string.
	There may be more than one DLI loaded, each having its own service
	  interrupt.
SeeAlso: AX=0000h,AX=0002h,AX=000Fh
Index:	installation check;SK-UPPS
--------N-7C0000-----------------------------
INT 7C - SK-UPPS Data Link Interface API - GET DRIVER VERSION
	AX = 0000h
Return: AH = major DLI version
	AL = minor DLI version
	DX = OEM signature (see #2050)
	CL = DLI 2.8+ topology: 1=Ethernet, 2=FDDI, 3=Token-Ring
SeeAlso: AX=0002h,AX=000Bh,AX=000Dh,AX=000Eh

(Table 2050)
Values for SK-UPPS Data Link Interface OEM signature (defined by SK):
 0001h		experimental
 3343h	('3C')	3COM
 4942h	('IB')	IBM
 4943h	('IC')	Intellicom
 494Eh	('IN')	Intel
 4B4Fh	('KO')	Kodiak
 4D41h	('MA')	Madge
 4E45h	('NE')	Novell
 4F43h	('OC')	Olicom
 5349h	('SI')	Siemens
 534Bh	('SK')	Schneider & Koch (SysKonnect)
 5744h	('WD')	Western Digital
--------N-7C0001-----------------------------
INT 7C - SK-UPPS Data Link Interface API - DOWN DRIVER
	AX = 0001h
Return: AX = completion code (see #2051)
Note:	the DLI will refuse to unload if there are any protocols
	  (see AX=0007h) or clients (see AX=0010h) active.
Index:	uninstall;SK-UPPS Data Link Interface

(Table 2051)
Values for SK-UPPS completion code:
 0000h	SUCCESS
 0005h	INVALID_MULTICAST
 0006h	BUFFER_TOO_SMALL
 0007h	NO_BUFFERS_LEFT
 0008h	NO_RESOURCES_LEFT
 000Bh	ILLEGAL_PROTOCOL_ID
 000Ch	PROTOCOL_IN_USE
 000Dh	NO_MULTICAST_ADDRESS
 000Fh	PROTOCOLS_ACTIVE
 0010h	CLIENTS_ACTIVE
 001Bh	INVALID_MODE
 001Ch	MODE_NOT_SUPPORTED
 FFFFh	UNKNOWN_SERVICE
--------N-7C0002-----------------------------
INT 7C - SK-UPPS Data Link Interface API - GET DRIVER STATUS
	AX = 0002h
	ES:DI -> Status Information Block (SIB) (see #2063)
Return: AX = completion code (see #2051)
Note:	GET DRIVER INFO (AX=000Eh) should be used instead.
SeeAlso: AX=0000h,AX=000Bh,AX=000Dh,AX=000Eh
--------N-7C0003-----------------------------
INT 7C - SK-UPPS Data Link Interface API - CHANGE DRIVER ADDRESS
	AX = 0003h
	ES:DI -> new node address (6 bytes)
Return: AX = completion code (see #2051)
Note:	the DLI will refuse to change the address if any protocols
	  (see AX=0007h) are active
SeeAlso: AX=0001h,AX=000Eh
--------N-7C0004-----------------------------
INT 7C - SK-UPPS Data Link Interface API - REQUEST BUFFER
	AX = 0004h
	DX = protocol ID (see AX=0007h,#2054)
Return: AX = completion code (see also #2051)
	    0000h successful
		ES:BX -> Memory Buffer (Mbuf) (see #2052)
Note:	if the DLI has no free Mbufs, it will set an internal flag for the
	  protocol and later call the protocol's Event Upcall with
	  EV_BUFFER_AVAILABLE (see #2058,#2059) as soon as an Mbuf becomes
	  available.  There will only be one "buffer available" Upcall, even
	  if this function has been called several times before.
SeeAlso: AX=0005h,AX=0006h,AX=0012h,AX=0013h

Format of SK-UPPS Memory Buffer (Mbuf):
Offset	Size	Description	(Table 2052)
 00h	DWORD	-> NEXT Mbuf (linked list)
 04h	WORD	OFFSET of actual data within DATA area
 06h  2 BYTEs	reserved (currently unused)
 08h	WORD	LENGTH of actual data found in DATA area starting at OFFSET
 0Ah  2 BYTEs	reserved (currently unused)
 0Ch	DWORD	-> DATA area (size can be obtained via AX=000Eh call)
 10h	WORD	PROTOCOL ID of protocol currently "owning" the Mbuf
 12h	BYTE	IN USE flag; nonzero if Mbuf still in use by DLI (see AX=0006h)
 13h	BYTE	RECEIVE STATUS (bit 0-7 only; see AX=0007h - Receive Upcall)
--------N-7C0005-----------------------------
INT 7C - SK-UPPS Data Link Interface API - RELEASE BUFFER
	AX = 0005h
	ES:BX -> Mbuf (see #2052)
Return: nothing
SeeAlso: AX=0004h
--------N-7C0006-----------------------------
INT 7C - SK-UPPS Data Link Interface API - TRANSMIT FRAME
	AX = 0006h
	ES:BX -> Mbuf (see #2052)
Return: nothing
Notes:	The DLI will send LENGTH bytes found in the Mbuf's DATA area starting
	  at OFFSET. A complete and valid frame must be stored there. The DLI
	  will only copy the current node address (see AX=0003h) to the
	  source node field of the frame's MAC header.
	On Ethernet, the DLI will always send a minimum of 60 bytes, regardless
	  of the value found in the LENGTH field.
	This function returns immediately; the DLI will call the protocol's
	  Transmit Upcall (see #2053) when the frame has been sent.
	The Mbuf's IN USE field will be non-zero until the DLI calls the
	  Transmit Upcall.
SeeAlso: AX=0002h,AX=0004h,AX=0013h

(Table 2053)
Values SK-UPPS Transmit Upcall is called with:
	ES:BX -> Mbuf (NEXT field destroyed)
	interrupts disabled
Note:	On FDDI the bytes of the source and destination node fields in the MAC
	  header have been bit-swapped to physical address format.
--------N-7C0007-----------------------------
INT 7C - SK-UPPS Data Link Interface API - REGISTER PROTOCOL
	AX = 0007h
	ES:BX -> Protocol Control Block (see #2054)
Return: AX = completion code (see #2051)
Program: SK-UPPS is the Schneider & Koch Universal Portable Protocol Stack,
	  which provides an API on top of its Data Link Interface, allowing the
	  use of any of several network transport layers
SeeAlso: AX=0008h,AX=000Bh

Format of SK-UPPS Protocol Control Block (PCB):
Offset	Size	Description	(Table 2054)
 00h	WORD	(big-endian) protocol type
 02h	WORD	protocol mode (see #2055)
 04h	DWORD	-> Receive Upcall routine
 08h	DWORD	-> Transmit Upcall routine
 0Ch	DWORD	-> Event Upcall routine
 10h	DWORD	-> ASCIZ protocol name (zero if none)
 14h	WORD	protocol ID will be returned here (always non-zero)

Bitfields for SK-UPPS protocol mode:
Bit(s)	Description	(Table 2055)
 0	promiscuous mode; protocol receives all frames regardless of their
	  destination (PROTOCOL TYPE must be FFFFh)
 1	if set, protocol's Event Upcall will be called on entry and exit of the
	  DLI's Interrupt Service Routine (see event codes below)
 2	DLI 2.2+ hook mode; protocol receives all directed frames destined for
	  this station (PROTOCOL TYPE must be FFFFh)
 3	DLI 2.3+ receive error frames (only valid in promiscuous mode (0))
 4-5	DLI 2.5+ frame type:
	00 Ethernet II; specify type code in PROTOCOL TYPE field (high-low)
	01 IEEE 802.2; specify Service Access Point (SAP) in MSB
	      (offset 0) of PROCOTOL TYPE field; LSB must be zero
	10 IEEE 802.2 with SNAP header; specify type code in PROTOCOL TYPE
	      field (high-low)
	11 reserved (currently unused)
 6	DLI 2.5+ if set, protocol's Event Upcall will be called with event code
	  EV_BUFFER_WANTED, when DLI runs out of Mbufs
 7	DLI 2.7+ chain mode; if set, client allows the specified frame type to
	  be shared with other clients
 8	DLI 2.8+ receive non-LLC frames rather than LLC frames
 9	DLI 2.8+ receive all multicast frames (see also AX=0009h)
 10-15	reserved (currently unused; must be zero)
Notes:	If PROTOCOL TYPE is FFFFh and neither the "promiscuous" nor the "hook"
	  mode is set, the protocol receives all frames that did not match
	  any registered frame type (demultiplexor mode).
	Protocols using "promiscuous", "hook" or "chain" mode should always
	  return from the Receive Upcall with the received Mbuf in ES:BX and
	  the Carry Flag set. The DLI will then pass the Mbuf to the FEED BACK
	  BUFFER function (see AX=000Fh).
	Some DLIs do not support all or even any of the "promiscuous",
	  "receive non-LLC" and "receive all multicasts" mode bits.

(Table 2056)
Values SK-UPPS Receive Upcall is called with:
 ES:BX -> Mbuf
 AX = receive status (see #2057) (also stored in Mbuf's RECEIVE STATUS field)
 interrupts disabled

Bitfields for SK-UPPS receive status:
Bit(s)	Description	(Table 2057)
 0-2	reserved (0), currently unused
 3	frame check sequence (FCS) error
 4	overflow (frame too long)
 5	framing error
 6	reserved (0), currently unused
 7	non-LLC frame (see 8 of PCB's protocol mode field)
 8-15	reserved (0), currently unused
Notes:	The protocol's Receive Upcall routine will be called whenever a frame
	  matching the specified frame type is received. A received frame is
	  passed to the protocol in the Mbuf's DATA area at OFFSET and its size
	  is LENGTH bytes.
	The receive status passed to the Receive Upcall in register AL is
	  always zero, except for protocols using "non-LLC" mode (8 of PCB's
	  protocol mode field) or "promiscuous" mode together with "receive
	  error frames" (0 & 3).
	Upcalls are FAR routines and must return with a RET FAR. If the Carry
	  Flag is set on return from a Receive or Transmit Upcall, then ES:BX
	  must point to an Mbuf, which the DLI will then pass to the RELEASE
	  BUFFER function (see AX=0005h). See also notes for PROTOCOL MODE.

(Table 2058)
Values SK-UPPS Event Upcall is called with:
 AX = event code (see #2059)
Note:	All Event Upcalls may be ignored by the protocol.

(Table 2059)
Values for SK-UPPS Event Upcall event code:
 00h	EV_BUFFER_AVAILABLE client may now call REQUEST BUFFER (AX=0004h)
 01h	EV_ISR_START	    start of Interrupt Service Routine
 02h	EV_ISR_END	    end of ISR (see bit 1 in PCB's protocol mode field)
 03h	EV_BUFFER_WANTED    DLI temporarily out of Mbufs
 04h	EV_NETWORK_STATUS   DLI 2.8+ network status (DX=status; see below)
 05h	EV_IO_CONTROL	    DLI 2.8+ I/O control (DX=subfunction; see AX=0016h)

Bitfields for EV_NETWORK_STATUS in register DX:
Bit(s)	Description	(Table 2060)
	Token-Ring		FDDI
 15	SIGNAL_LOSS		SIGNAL_LOSS
 14	HARD_ERROR		HARD_ERROR
 13	SOFT_ERROR		SOFT_ERROR
 12	TRANSMIT_BEACON		TRANSMIT_BEACON
 11	LOBE_WIRE_FAULT		PATH_TEST_FAILED
 10	AUTO_REMOVAL		SELF_TEST_REQUIRED
 9	reserved		reserved
 8	REMOVE_RECEIVED		REMOTE_DISCONNECT
 7	COUNTER_OVERFLOW	reserved
 6	SINGLE_STATION		DUPLICATE_ADDRESS
 5	RING_RECOVERY		NO_RING_OP_STATUS
 4	reserved		VERSION_MISMATCH
 3	reserved		STUCK_BYPASS
 2	reserved		FDDI_EVENT
 1	reserved		RING_OP_CHANGE
 0	reserved		reserved
Note:	EV_NETWORK_STATUS is not supported on Ethernet
--------N-7C0008-----------------------------
INT 7C - SK-UPPS Data Link Interface API - DISABLE PROTOCOL
	AX = 0008h
	BX = protocol ID (see #2054)
Return: AX = completion code (see #2051)
Note:	the DLI will handle any Mbufs given to TRANSMIT FRAME (AX=0006h) as if
	  they had been given to TRANSMIT FRAME RELEASE (AX=0013h).
	all multicast addresses registered for this protocol will be disabled.
	after this function returns, the protocol's Upcall routines will no
	  longer be called.
SeeAlso: AX=0007h,AX=000Bh
--------N-7C0009-----------------------------
INT 7C - SK-UPPS Data Link Interface API - REGISTER MULTICAST
	AX = 0009h
	BX = protocol ID (see #2054)
	ES:DI -> multicast address (6 bytes)
Return: AX = completion code (see #2051)
Notes:	The broadcast address is always enabled.
	Set bit 9 of PCB's protocol mode field in REGISTER PROTOCOL call
	  (AX=0007h) to receive all multicast frames.
SeeAlso: AX=000Ah,AX=0014h
--------N-7C000A-----------------------------
INT 7C - SK-UPPS Data Link Interface API - DISABLE MULTICAST
	AX = 000Ah
	BX = protocol ID (see #2054)
	ES:DI -> multicast address (6 bytes)
Return: AX = completion code (see #2051)
SeeAlso: AX=0009h,AX=0014h
--------N-7C000B-----------------------------
INT 7C - SK-UPPS Data Link Interface API - GET PROTOCOL LIST
	AX = 000Bh
	ES:DI -> protocol ID buffer
	CX = number of 2-byte protocol IDs that may be stored in buffer
Return: AX = completion code (see #2051)
	CX = number of active protocols (regardless of value returned in AX)
	protocol ID buffer filled with active protocol IDs
Program: SK-UPPS is the Schneider & Koch Universal Portable Protocol Stack,
	  which provides an API on top of its Data Link Interface, allowing the
	  use of any of several network transport layers
Note:	If the buffer supplied is too small, CX still contains the total number
	  of active protocols and the buffer has been filled until full.
SeeAlso: AX=000Ch,AX=0014h
--------N-7C000C-----------------------------
INT 7C - SK-UPPS Data Link Interface API - GET PROTOCOL STATUS
	AX = 000Ch
	BX = protocol ID (see #2054,AX=000Bh)
	ES:DI -> Protocol Status Block (see #2061)
Return: AX = completion code (see #2051)
SeeAlso: AX=000Bh,AX=0014h

Format of SK-UPPS Protocol Status Block (PSB):
Offset	Size	Description	(Table 2061)
 00h	DWORD	-> ASCIZ protocol name
 04h	WORD	protocol mode (see #2055)
 06h	WORD	protocol type (see AX=0007h)
 08h	WORD	number of registered multicasts (see AX=0009h,AX=0014h)
--------N-7C000D-----------------------------
INT 7C - SK-UPPS Data Link Interface API - GET DRIVER STATISTICS
	AX = 000Dh
	BX = flag: 0=don't clear statistics, 1=clear statistics
	ES:DI -> Statistics Data Block (see #2062)
Return: AX = completion code (see #2051)
SeeAlso: AX=0002h,AX=0015h

Format of SK-UPPS Statistics Data Block (SDB):
Offset	Size	Description	(Table 2062)
 00h	DWORD	node uptime in ticks (1/18.21 sec.)
 04h	DWORD	bytes received
 08h	DWORD	bytes transmitted
 0Ch	DWORD	frames received
 10h	DWORD	frames transmitted
 14h	DWORD	multicast bytes received
 18h	DWORD	multicast frames received
 1Ch	DWORD	unrecognized frames
 20h	WORD	missed frames
 22h	WORD	frame check sequence (FCS) errors
 24h	WORD	framing errors
 26h	WORD	babbling errors
 28h	WORD	late collision errors
 2Ah	WORD	loss of carrier errors
 2Ch	WORD	16 retries failed errors
 2Eh	WORD	overflow errors
Note:	fields 26h through 2Ch are always zero, except in some very old
	  versions of the DLI.	Use GET MEDIA STATISTICS (AX=0015h) to get
	  more detailed information.
--------N-7C000E-----------------------------
INT 7C - SK-UPPS Data Link Interface API - DLI 2.5+ - GET DRIVER INFO
	AX = 000Eh
	ES:DI -> Driver Information Block (see #2063)
	BX = offset of 1st field within DIB to be returned
	CX = number of bytes to be returned
Return: AX = completion code (see #2051)
	CX = number of bytes copied (regardless of value returned in AX)
Program: SK-UPPS is the Schneider & Koch Universal Portable Protocol Stack,
	  which provides an API on top of its Data Link Interface, allowing the
	  use of any of several network transport layers
SeeAlso: AX=0000h,AX=0002h,AX=000Bh,AX=000Dh,AX=0015h

Format of SK-UPPS Driver Information Block (DIB):
Offset	Size	Description	(Table 2063)
 00h  6 BYTEs	physical node address (from adapter's ROM)
 06h  6 BYTEs	current node address (see AX=0003h)
 0Ch	BYTE	adapter id (defined by OEM)
 0Dh	BYTE	IRQ line (FFh if none)
 0Eh	DWORD	-> shared memory (zero if none)
 12h	DWORD	size of shared memory (zero if none)
 16h	WORD	base I/O port (zero if none)
 18h	BYTE	DMA line (FFh if none)
 19h	BYTE	DLI 2.4+ topology (see AX=0000h)
 1Ah	WORD	size of an Mbuf's DATA area (see #2052)
 1Ch  2 BYTEs	reserved (currently unused)
 1Eh	WORD	total number of Mbufs the DLI has
 20h	WORD	maximum number of Mbufs that can be allocated via REQUEST
		  BUFFER (AX=0004h) and SYNC REQUEST BUFFER (AX=0012h)
 ---- end of Status Information Block returned by GET DRIVER STATUS (AX=0002h)
 22h	DWORD	-> ASCIZ adapter name
 26h	WORD	number of I/O ports used (zero if none)
 28h	DWORD	line speed in bits/sec.
--------N-7C000F-----------------------------
INT 7C - SK-UPPS Data Link Interface API - FEED BACK BUFFER
	AX = 000Fh
	ES:BX -> Mbuf (see #2052)
Return: nothing
Notes:	A protocol may call this function instead of returning the Mbuf
	  directly from the Receive Upcall if it is running in "promiscuous",
	  "hook" or "chain" mode.
SeeAlso: AX=0007h
--------N-7C0010-----------------------------
INT 7C - SK-UPPS Data Link Interface API - CLIENT HOOK
	AX = 0010h
Return: nothing
Notes:	An application having no active protocols may call this function to
	  prevent the DLI from unloading.
SeeAlso: AX=0001h,AX=0011h
--------N-7C0011-----------------------------
INT 7C - SK-UPPS Data Link Interface API - CLIENT UNHOOK
	AX = 0011h
Return: nothing
Program: SK-UPPS is the Schneider & Koch Universal Portable Protocol Stack,
	  which provides an API on top of its Data Link Interface, allowing the
	  use of any of several network transport layers
SeeAlso: AX=0010h
--------N-7C0012-----------------------------
INT 7C - SK-UPPS Data Link Interface API - SYNC REQUEST BUFFER
	AX = 0012h
	DX = protocol ID (see #2054)
Return: AX = completion code (see #2051)
	if AX=0000h: ES:BX -> Mbuf (see #2052)
Note:	If the protocol wants to be informed when an Mbuf becomes available,
	  REQUEST BUFFER (AX=0004h) should be used instead.
SeeAlso: AX=0004h,AX=0005h,AX=0006h,AX=0013h
--------N-7C0013-----------------------------
INT 7C - SK-UPPS Data Link Interface API - TRANSMIT FRAME RELEASE
	AX = 0013h
	ES:BX -> Mbuf (see #2052)
Return: nothing
Notes:	Returns immediately; The protocol's Transmit Upcall will NOT be called.
	The Mbuf may no more be used by the protocol in any way (i.e. the
	  Mbuf's IN USE field may not be polled).
SeeAlso: AX=0004h,AX=0013h
--------N-7C0014-----------------------------
INT 7C - SK-UPPS Data Link Interface API - GET MULTICAST LIST
	AX = 0014h
	BX = protocol ID (see #2054,AX=000Bh)
	ES:DI -> multicast address buffer
	CX = number of 6-byte multicast addresses that may be stored in buffer
Return: AX = completion code (see #2051)
	CX = number of registered multicast addresses for this protocol
	  (regardless of value returned in AX)
	multicast address buffer filled with multicast addresses registered for
	  this protocol
Note:	If the buffer supplied is too small, CX still contains the total number
	  of registered multicast addresses for this protocol and the buffer
	  has been completely filled
SeeAlso: AX=000Bh,AX=0009h,AX=000Ch
--------N-7C0015-----------------------------
INT 7C - SK-UPPS Data Link Interface API - DLI 2.6+ - GET MEDIA STATISTICS
	AX = 0015h
	ES:DI -> media-specific statistics buffer (see #2064,#2065,#2066)
	BX = offset of 1st field within MSS to be returned
	CX = number of bytes to be returned
Return: AX = completion code (see #2051)
	CX = number of bytes copied (regardless of value returned in AX)
Note:	not supported by all DLIs (will return AX=FFFFh if not supported).
SeeAlso: AX=0000h,AX=000Dh

Format of SK-UPPS media-specific statistics for Ethernet:
Offset	Size	Description	(Table 2064)
 00h	DWORD	alignment errors
 04h	DWORD	frame check sequence (FCS) errors
 08h	DWORD	single collision frames
 0Ch	DWORD	multiple collision frames
 10h	DWORD	signal quality error (SQE) test errors
 14h	DWORD	deferred transmissions
 18h	DWORD	late collisions
 1Ch	DWORD	excessive collisions
 20h	DWORD	internal MAC transmit errors
 24h	DWORD	carrier sense errors
 28h	DWORD	excessive deferrals
 2Ch	DWORD	frame too longs
 30h	DWORD	in range length errors
 34h	DWORD	out of range length fields
 38h	DWORD	internal MAC receive errors

Format of SK-UPPS media-specific statistics for FDDI:
Offset	Size	Description	(Table 2065)
 00h	DWORD	SMT operating version id (refer to ANSI 7.1.2.2)
 04h	DWORD	SMT CF state: 1=Isolated, 2= Wrap_S, 3=Wrap_A, 4=Wrap_B,
		  5=Wrap_AB, 6=Thru (refer to ANSI SMT 9.7.4.3)
 08h	DWORD	SMT frames sent
 0Ch	DWORD	SMT frames received
 10h	DWORD	SMT ring up count
 14h  6 BYTEs	MAC upstream neighbour
 1Ah  6 BYTEs	MAC downstream neighbour
 20h	DWORD	MAC frame counter (refer to ANSI MAC 2.2.1)
 24h	DWORD	MAC error counter ( " )
 28h	DWORD	MAC lost counter ( " )
 2Ch	BYTE	port 1 link error estimate (ranges from 10**-4 to 10**-15 and
		  is reported as the absolute value of the exponent)
 2Dh	BYTE	port 2 link error estimate ( " )
 2Eh  2 BYTEs	reserved (currently unused)
 30h	DWORD	attachment class: 1=single-attachment (S PORT),
		  2=dual-attachment (A/B PORT pairs), 3=concentrator (M PORTs)
 34h	DWORD	attachment optical bypass present: 1=true, 2=false

Format of SK-UPPS media-specific statistics for Token-Ring:
Offset	Size	Description	(Table 2066)
 00h  6 BYTEs	upstream neighbour
 06h	WORD	local ring number
 08h	DWORD	ring up count
 0Ch	DWORD	signal loss errors
 10h	DWORD	lobe wire faults
 14h	DWORD	ring recovery count
 18h	DWORD	line errors
 1Ch	DWORD	burst errors
 20h	DWORD	ARI/FCI errors
 24h	DWORD	lost frame errors
 28h	DWORD	receive congestion errors
 2Ch	DWORD	frame copied errors
 30h	DWORD	token errors
 34h	DWORD	DMA bus errors
 38h	DWORD	DMA parity errors
 3Ch	DWORD	receive overflow errors
--------N-7C0016-----------------------------
INT 7C - SK-UPPS Data Link Interface API - DLI 2.8+ - DRIVER I/O CONTROL
	AX = 0016h
	DX = subfunction; bits 14-15 specify direction of I/O:
		00 no data at all (ES:BX undefined)
		01 driver -> application (GET)
		10 application -> driver (SET)
		11 both directions (GET/SET)
	ES:BX -> I/O buffer (optional)
	CX = size of buffer (if ES:BX valid)
Return: AX = completion code; defined by OEM
Program: SK-UPPS is the Schneider & Koch Universal Portable Protocol Stack,
	  which provides an API on top of its Data Link Interface, allowing the
	  use of any of several network transport layers
Notes:	not supported by all DLIs (will return AX=FFFFh if not supported)
	subfunction codes are defined by OEMs
SeeAlso: AX=0001h
--------N-7C0017-----------------------------
INT 7C - SK-UPPS Data Link Interface API - DLI 2.8+ - INTERRUPT REQUEST
	AX = 0017h
Return: AX = completion code (see #2051)
Notes:	not supported by all DLIs (will return AX=FFFFh, if not supported).
	must be called with interrupts disabled; when the client re-enables
	  interrupts, an interrupt will be generated and reported to the client
	  through an Event Upcall (see AX=0007h [EV_ISR_START/EV_ISR_END])
SeeAlso: AX=0007h
--------t-7D---------------------------------
INT 7D O - [obsoleted proposal] - ALTERNATE MULTIPLEX INTERRUPT
Note:	this interface has been moved to INT 2D; there are no known
	  implementations on INT 7D
SeeAlso: INT 2D,INT 2F
--------S-7D---------------------------------
INT 7D U - YTERM 1.4 - CLOCK SUPPORT
SeeAlso: INT 7E"YTERM"
--------E-7D---------------------------------
INT 7D - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ5
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 0D,INT 7C"GO32",INT 7E"GO32"
--------U-7D---------------------------------
INT 7D - HyperPAD v2.2 - API ACCESS
Note:	this vector is hooked but immediately passed on (without checking
	  whether the previous handler was 0000h:0000h).  The sole purpose of
	  this vector is to provide the address of the data area described
	  below.

Format of HyperPAD data area:
Offset	Size	Description	(Table 2067)
 -16h	DWORD	pointer to ??? FAR function
 -12h	DWORD	pointer to callback setting function
		[C calling conventions, (*callback)(int (_loadds far *)()) ]
 -0Eh 6 BYTEs	signature "BRC001"
 -08h	DWORD	pointer to previous INT 7D handler
 -04h	DWORD	pointer to ??? data
 00h		HyperPAD INT 7D handler
----------7D---------------------------------
INT 7D - IBM DOS 6.1 E.EXE - ???
Note:	E.EXE checks whether this interrupt is in use (not 0000h:0000h),
	  and if it is used, attempts to load E55VGA.EX instead of the 
	  default E.EX overlay.	 However, E55VGA.EX is not included in
	  IBM DOS 6.1.
----------7D00-------------------------------
INT 7D - SCSILink - RESET SCSI BUS
	AH = 00h
Program: SCSILink is a TSR by Cross Products Ltd which allows its PC-hosted
	  cross assemblers and similar products to communicate with Cross
	  Products hardware debuggers
Desc:	reset all devices on the SCSI bus
Note:	the installation check is the signature "SCSILINK" immediately prior
	  to the interrupt handler
Index:	installation check;SCSILink
----------7D01-------------------------------
INT 7D - SCSILink - CONNECT TO TARGET
	AH = 01h
	AL = target ID
Return: CF clear if successful
	CF set on error
	    AL = initiator error
	    AH = target error
Desc:	arbitrate the use of the bus and select the specified target device
----------7D02-------------------------------
INT 7D - SCSILink - SEND COMMAND
	AH = 02h
	ES:BX -> parameter block (see #2068)
Return: CF clear if successful
	CF set on error
	    AL = initiator error
	    AH = target error
Desc:	send the specified command block to the target device and perform any
	  related I/O

Format of SCSILink parameter block:
Offset	Size	Description	(Table 2068)
 00h	DWORD	size of command block
 04h	DWORD	address of command block (see #2069)
 08h	DWORD	size of buffer
 0Ch	DWORD	address of buffer

Format of SCSILink command block:
Offset	Size	Description	(Table 2069)
 00h		info not yet available
----------7D03-------------------------------
INT 7D - SCSILink - SET TIMEOUT
	AH = 03h
	AL = timeout selector (see #2070)
	BX = new value in 55ms ticks
Desc:	change an internal timeout value to allow communication with very
	  slow targets

(Table 2070)
Values for SCSILink timeout selector:
 00h	time to wait for bus (default 18)
 01h	time to wait for new phase (default 5)
 02h	maximum time to send/receive block (default 18)
 03h	time to wait for reselect (default 180)
----------7D04-------------------------------
INT 7D - SCSILink - GET ERROR STRING
	AH = 04h
	AL = error number
Return: ES:BX -> ASCIZ error string for error number
----------7D05-------------------------------
INT 7D - SCSILink - GET ADDRESS
	AH = 05h
Return: AL = DMA channel
	AH = initiator ID
	BX = card address
Desc:	determine the current hardware configuration
----------7D06-------------------------------
INT 7D - SCSILink - PUT DATA
	AH = 06h
	CX = number of bytes to store (0001h-0100h)
	ES:BX -> data to be saved
Return: CF clear if successful
	CF set on error
	    AL = error code (01h = too much data)
Note:	the specified data is stored in SCSILink's PSP
SeeAlso: AH=07h
----------7D07-------------------------------
INT 7D - SCSILink - GET DATA
	AH = 07h
	CX = number of bytes to retrieve (0001h-0100h)
	ES:BX -> buffer for data
Return: CF clear if successful
	CF set on error
	    AL = error code (01h = too much data)
Note:	retrieve data previously stored with AH=06h
SeeAlso: AH=06h
----------7D08-------------------------------
INT 7D - SCSILink - TERMINATE SESSION
	AH = 08h
Desc:	indicate to any other programs that intercept INT 7D that the program
	  has finished with the link
Note:	the program should call this function even if a SCSI error caused its
	  termination
----------7D09-------------------------------
INT 7D - SCSILink - POLL REQUEST
	AH = 09h
	AL = target ID
Return: AL = status
	    FEh resident driver experienced SCSI error
	    FFh resident driver handleded event
Desc:	give any drivers chained onto INT 7D a chance to handle an exception
	  not specifically handled by the calling program
Notes:	this service exists so that resident disk servers, etc. can continue
	  running even while debuggers and profilers are active
	the resident driver assumes that a connection has been established and
	  attempts to leave the target connected
--------*-7E---------------------------------
INT 7E - RESERVED FOR DIP, Ltd. ROM LIBRARY
--------S-7E---------------------------------
INT 7E U - YTERM 1.4 - ???
SeeAlso: INT 7D"YTERM",INT 7F"YTERM"
--------E-7E---------------------------------
INT 7E - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ6
Program: GO32.EXE is a DOS extender included as part of the 80386 port of the
	  GNU C/C++ compiler by DJ Delorie and distributed as DJGPP
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 0E,INT 7D"GO32",INT 7F"GO32"
--------m-7E5857BL57-------------------------
INT 7E - XLOAD - INSTALLATION CHECK
	AX = 5857h
	BL = 57h
Return: AX = 0000h if installed
Program: XLOAD is the LOADHIGH-equivalent from Helix Software's Netroom
SeeAlso: AX=5857h/BL=5Ah,AX=5857h/BL=5Bh
--------m-7E5857BL5A-------------------------
INT 7E - XLOAD - GET ???
	AX = 5857h
	BL = 5Ah
Return: AX = 0000h
	CX = ???
	DS:SI -> ???
SeeAlso: AX=5857h/BL=57h,AX=5857h/BL=5Bh
--------m-7E5857BL5B-------------------------
INT 7E - XLOAD - GET XLOAD MEMORY SIZE
	AX = 5857h
	BL = 5Bh
Return: AX = 0000h
	CX = segment of XLOAD TSR
	DX = size of memory block in which XLOAD TSR is located
SeeAlso: AX=5857h/BL=57h/AX=5857h/BL=5Ah
--------V-7F---------------------------------
INT 7F - IBM XGA - ???
--------V-7F---------------------------------
INT 7F - Halo88 - API
	BX = function number (see #2071)
	additional parameters on stack
Return: ???
Program: Halo88 is a suite of graphics routines
Note:	according to Stuart Kemp, the code appears to make no provisions for
	   chaining

(Table 2071)
Values for Halo88 API function:
 64h	arc
 65h	bar
 66h	box
 67h	circle
 68h	clr
 69h	default hatch style
 6Ah	default line style
 6Bh	delhcur
 6Ch	delln / deltcur
 6Dh	ellipse
 6Eh	fill
 6Fh	flood
 70h	flood2
 71h	init graphics
 72h	init hcur
 73h	init marker
 74h	init tcur
 75h	inqarc
 76h	inqbknd
 77h	inqclr
 78h	inqerr
 79h	inqgcur
 7Ah	inqhcur
 7Bh	inqmarker
 7Dh	inqtcur
 7Eh	inqtext
 7Fh	lnabs
 80h	lnrel
 81h	markerabs
 82h	markerrel
 83h	moveabs
 84h	movehcurabs
 85h	movehcurrel
 86h	moverel
 87h	movetcurabs
 88h	movetcurrel
 89h	movefrom
 8Ah	moveto
 8Bh	pie
 8Ch	polylnabs
 8Dh	polylnrel
 8Eh	ptabs
 8Fh	ptrel
 91h	setasp
 92h	set color
 93h	set font
 94h	set hatch	style
 95h	set line style
 97h	settext
 98h	set text color
 99h	btext
 9Ah	setseg
 9Bh	display
 9Ch	setscreen
 9Eh	close graphics
 9Fh	ftinit
 A0h	ftlocate
 A1h	ftext
 A5h	set viewport
 A6h	set window
 A7h	set world
 AAh	ftcolor
 ACh	initlp
 ADh	inqasp
 AEh	inqdev
 AFh	inqdisplay
 B0h	inqft
 B1h	inqftcolor
 B2h	inqinterlace
 B3h	inqlpa
 B4h	inqlpg
 B5h	inqmode
 B6h	inqscreen
 B7h	inqversion
 B8h	roam
 B9h	scroll
 BAh	setieee
 BBh	set interlace
 BCh	shift
 BDh	start graphics
 BEh	vpan
 CBh	gwrite
 CCh	gread
 CDh	setxor
 CEh	rbox
 CFh	rcir
 D0h	rlnabs
 D1h	rlnrel
 D2h	delbox
 D3h	delcir
 D5h	setseg2
 DCh	worldoff
 DDh	mapwtod
 DEh	mapdtow
 DFh	mapwton
 E0h	mapntow
 E1h	mapdton
 E2h	mapntod
 E3h	inqworld
 E4h	inqviewport
 E5h	set line width
 E6h	lnjoint
 E7h	set locator
 E8h	read locator
 E9h	setdev
 EBh	setstext
 ECh	setstclr
 EDh	setstang
 EEh	stext
 EFh	inqstext
 F0h	setdegree
 F1h	inqstsize
 F2h	polyfabs
 F3h	polyfrel
 F4h	inqdrange
 F5h	inqstang
 F6h	orglocator
 F7h	inqlocator
 F8h	inqarea
 F9h	setipal
 FAh	setborder
 FBh	inqcrange
 FEh	setclip
 FFh	fcir
100h	setcrange
101h	setdrange
102h	setlattr
103h	polycabs
104h	polycrel
108h	memcom
109h	memexp
10Ah	memmov
10Eh	movefx
10Fh	movetx
110h	inqrgb
111h	save image
112h	restore image
113h	setapal
114h	setxpal
118h	inqtsize
12Eh	gprint
130h	setprn
131h	setpattr
133h	setbattr
135h	pexpand
136h	ptnorm
137h	pfnorm
13Bh	inqprn
13Ch	lopen
13Dh	lclose
13Eh	lappend
13Fh	lrecord
140h	lswitch
142h	inqfun
15Dh	lsetup
15Eh	lrest
15Fh	lsave
--------N-7F---------------------------------
INT 7F - CONVERGENT TECHNOLOGIES ClusterShare CTOS ACCESS VECTOR
	AL = request ID
	    01h "Request"/"RequestDirect"
		ES:BX -> pRq
		DX ignored
	    04h "Wait"
		ES:BX -> ppMsgRet
		DX = exchange
	    05h "AllocExch"
		ES:BX -> pExchRet
	    06h "DeAllocExch"
		DX = exchange
	    07h "Check"
		ES:BX -> ppMsgRet
		DX = exchange
	CX = 4354h ('CT')
Return: AX = status
	    0000h successful
--------S-7F---------------------------------
INT 7F - Telebit ACS SERIAL I/O
	ES:SI-> parameter block (see #2072)
Return: CF set on error
	CF clear on success
Notes:	the signature "PDGATEWRKSTNIF" appears just prior to the interrupt
	  handler; this serves as the installation check
Index:	installation check;Telebit ACS Serial I/O

Format of Telebit ACS parameter block:
Offset	Size	Description	(Table 2072)
 00h	BYTE	command (see #2073)
 01h	BYTE	gateway number
 02h	BYTE	reserved
 03h	BYTE	port
 04h 17 BYTEs	auxiliary buffer
 15h	BYTE	session
 16h	WORD	count of bytes passed to API
 18h	DWORD	buffer pointer passed to/from API
 1Ch	WORD	count of bytes passed from API
 1Eh	BYTE	return code (see #2074)

(Table 2073)
Values for Telebit ACS command:
 3Ch	status
 3Dh	connect
 3Eh	disconnect
 3Fh	read
 40h	data/command write
 41h	clear receive buffer
 42h	get configuration
 43h	get receiver status
 44h	raw write
 45h	search servers
 46h	set transmit buffer size

(Table 2074)
Values for Telebit ACS return code:
 00h	success
 01h	invalid session
 05h	servername invalid
 06h	NetWare fileserver bindery is locked
 07h	communication server not active
 08h	general failure in NetWare fileserver
 09h	not logged into a fileserver
 10h	connection table full
 11h	no response from communication server
 12h	connection attempt terminated abnormally
 13h	connection refused - no sessions available
 14h	gateway number/port already in use
 15h	invalid connection response
 16h	port invalid
 17h	incorrect version in server response
 18h	gateway number/port combination not configured
 19h	initialization has not been completed
 20h	no more sockets are available
 21h	no active poolname
 23h	FATAL internal interface error
 24h	registration of host workstation failed - name is already in use
 25h	registration of host workstation failed - workstation name table full
 26h	registration of host workstation failed - only one session may be
	  registered for dial-in
 FFh	Telebit ACS API is busy - retry later
--------N-7F---------------------------------
INT 7F - Non-dedicated NetWare 2.x File Server - ENTER CONSOLE MODE
Notes:	the installation check consists of checking for the signature "Lynn"
	  in the four bytes preceding the interrupt handler; if present, the
	  current program is running as a DOS task on a non-dedicated NetWare
	  2.x file server.
	Before placing the server into "console" mode, it is recommended that
	  NetWare broadcast messages be disabled with INT 21/AX=DE00h.
SeeAlso: INT 21/AX=DE00h
Index:	installation check;non-dedicated NetWare server
--------S-7F---------------------------------
INT 7F U - YTERM - ???
SeeAlso: INT 7E"YTERM"
--------E-7F---------------------------------
INT 7F - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ7
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the DOS extender
SeeAlso: INT 0F,INT 7E"GO32"
----------7F---------------------------------
INT 7F - Canon IXHND2 Scanner Interface
--------N-7F---------------------------------
INT 7F - Alloy 386/MultiWare (MW386), Novell-Type Network Executive (NTNX)
Notes:	the words at C800h:0000h and C800h:0002h will both be 584Eh if the
	  MW386 multitasking system is present (i.e. signature "NXNX")
	NTNX allows its API to be placed on a different interrupt than 7Fh at
	  load time.  To determine the actual vector used, open the device
	  "SPOOLER" with INT 21/AX=3D02h, place it in RAW mode with
	  INT 21/AX=4400h and INT 21/AX=4401h, then read one byte which will
	  be the actual interrupt number being used; the other interrupts may
	  be found with INT 7F/AH=09h/CL=03h
--------N-7F---------------------------------
INT 7F - Alloy NetWare Support Kit (ANSK) v2.2+ - INSTALLATION CHECK
Note:	a program may determine that it is running on an ANSK Slave by checking
	  the five bytes at F000h:0000h for the ASCIZ signature "ANSK"; this
	  address is RAM, and should not be written.  However, the above check
	  will not work on Slaves with <1MB RAM or those using the SLIM.SYS
	  device driver
--------N-7F00-------------------------------
INT 7F - Alloy NTNX, MW386 - SEMAPHORE LOCK AND WAIT
	AH = 00h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see #2075)
	AH = semaphore owner if status=02h
SeeAlso: AH=01h,AH=02h,AH=41h,INT 67/AH=00h

(Table 2075)
Values for Alloy function status:
 00h	successful
 01h	invalid function
 02h	semaphore already locked
 03h	unable to lock/unlock semaphore
 04h	semaphore space exhausted
 05h	host/target PC did not respond (NTNX)
--------N-7F00-------------------------------
INT 7F - G8BPQ - proposed addition - GET NODE/SWITCH VERSION AND DESCRIPTION
	AH = 00h
	ES:SI -> buffer for "USERS" text string
Return: AH = major version
	AL = minor version
	CX = length of returned string
Program: the G8BPQ AX25 Networking Package is amateur packet radio software by
	  John Wiseman which allows a PC to act as a node in an AX.25 network
SeeAlso: AH=01h"G8BPQ",AH=09h"G8BPQ"
--------N-7F01-------------------------------
INT 7F - Alloy NTNX, MW386 - SEMAPHORE LOCK
	AH = 01h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see #2075)
	AH = semaphore owner if status=02h
SeeAlso: AH=00h,AH=02h,AH=41h
--------V-7F01-------------------------------
INT 7F - TIGA Communications Driver v2.05 - GET ENTRY POINTS
	AH = 01h
Return: BX = 1234h if installed
	    DX:AX -> array of FAR entry points
	    CH = driver major version
	    CL = driver minor version
Note:	TIGACD 2.05 returns CF set on unrecognized functions in AX
SeeAlso: AX=1234h,AX=4321h
--------N-7F01-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - SET APPLICATION FLAGS AND MASK
	AH = 01h
	AL = stream number (01h-40h)
	CL = new application flags
	    bit 7: monitored frames available via AH=0Bh"G8BPQ"
	DL = new application mask
Program: the G8BPQ AX25 Networking Package is amateur packet radio software by
	  John Wiseman which allows a PC to act as a node in an AX.25 network
Note:	INT 7Fh is the default, which may be changed in the configuration file
	  for v4.03+
SeeAlso: AH=00h"G8BPQ",AH=02h"G8BPQ",AH=0Bh"G8BPQ"
--------I-7F0104BX0000-----------------------
INT 7F - HLLAPI (IBM 3270 High-Level Language API)/LLAPI (Rabbit Low Level API)
	AX = 0104h (HLLAPI gate ID)
	BX = 0000h
	DS:SI -> parameter control block (see #2076)
Return: parameter control block updated
Note:	the installation check for the Novell HLLAPI TSR is the signature
	  string "CXI" (for the company Novell bought) immediately prior to
	  the interrupt handler
SeeAlso: AX=0105h,AX=ABCDh

Format of HLLAPI parameter control block:
Offset	Size	Description	(Table 2076)
 00h  3 BYTEs	signature = 'PCB'
 03h	BYTE	function number (see #2077,#2078)
 04h	WORD	segment of control string
 06h	WORD	offset of control string
 08h	WORD	length of control string, unless explicit end-of-str char set
 0Ah	BYTE	unused (IBM)
		ControlString[0] (Rabbit)
 0Bh	WORD	return code (see #2080)
 0Dh	WORD	maximum length of control string (IBM)
		unused (Rabbit)

(Table 2077)
Values for HLLAPI function number:
 00h	OEM function (Query system for Attachmate implementation)
 01h	Connect presentation space
 02h	Disconnect presentation space
 03h	Send string of keystrokes as if typed from keyboard
 04h	Wait ~60s, returns status of presentation space
 05h	Copy current presentation space into a user-defined buffer
 06h	Search presentation space for first occurrence of a specified string
 07h	Query cursor location in current presentation space
 08h	Copy part or all of current presentation space into user buffer
 09h	Set session parameters; parameters vary by vendor (see #2079)
 0Ah	Get info on sessions currently connected
 0Bh	Lock current presentation space
 0Ch	Unlock previously locked presentation space
 0Dh	Return copy of operator info area (OIA) of current presentation space
 0Eh	get attribute byte for given position in the current presentation space
 0Fh	copy string of characters to the current presentation space
 10h	workstation control functions
 11h	storage manager functions, intended primarily for BASIC applications
	(not implemented by Rabbit)
 12h	set delay period in half-second intervals
 14h	get info on level of workstation support used
 15h	reset session parameters to default values
 16h	get detailed info on the current session
 17h	start host notification to application on presentation sp or OIA update
 18h	check host update when host notification enabled
 19h	stop host notification
 1Eh	search field within current presentation space for string
 1Fh	get first positionof a selected field in the current presentation space
 20h	get length of specified field
 21h	copy string into a specified field
 22h	copy specified field into a user-defined buffer
 23h	create alternate presentation space (IBM only), don't use with BASIC
 24h	switch to alternate presentation space (IBM only), not with BASIC
 25h	display cursor in specified area (IBM only), don't use with BASIC
 26h	display alternate presentation space (IBM only), don't use with BASIC
 27h	delete alternate presentation space (IBM only), don't use with BASIC
 28h	set cursor
 29h	start Close Intercept
 2Ah	query Close Intercept
 2Bh	stop Close Intercept
 32h	start intercepting keystrokes to allow filtering
 33h	get keystrokes after turning on interception
 34h	notify operator when keystroke rejected by filter subroutine
 35h	stop intercepting keystrokes
 5Ah	send file
 5Bh	receive file
 5Ch	run a program (not implemented by Rabbit)
 5Dh	execute DOS command (not implemented by Rabbit)
 63h	change presentation space position to PC display row/col or vice versa
 65h	connect to Window Services
 66h	disconnect from Window Services
 67h	set/query window coordinates
 68h	set/query window status
 69h	change presentation space name
 78h	connect Structured Fields
 79h	disconnect Structured Fields
 7Ah	query size of communications buffer
 7Bh	allocate communications buffer
 7Ch	free communications buffer
 7Dh	get request completion state
 7Eh	read Structured Fields
 7Fh	write Structured Fields
 FFh	Get info on DCA implementation

(Table 2078)
Values for LLAPI function number:
 80h	initialize LLAPI (internal call)
 83h	set Session ID (one-character ID)
 84h	read Session ID (one-character ID)
 85h	lock 327x keyboard
 86h	unlock 327x keyboard
 87h	wait for Clear to Send
 88h	type ASCII character
 89h	type 327x key
 8Ah	read keyboard lock state
 8Fh	force screen update
 90h	view session
 91h	relinquish (suspend foreground until background becomes idle)
 92h	poke screen character
 93h	poke translated character
 94h	peek screen character
 95h	peek translated character
 96h	set cursor position
 97h	send scan code (Rabbit only)
 98h	synchronize (returns after keystroke queue empty)
 99h	type PC key (Rabbit only)

(Table 2079)
Values for HLLAPI Function 09h Session Parameters:
 ASCII		??? (Rabbit only)
 ATTRIB		return attributes in hex
 NOATTRIB	return attributes as blanks
 CONPHYS	make physical connection
 CONLOG		only make logical connection
 EAB		copy extended attribute bytes along with data
 NOEAB		copy data only
 ESC=n		set escape character to "n" (default '@')
 EOT=n		set end of string character (default 00h)
 FPAUSE		full-duration pause
 FTNOWAIT	return immediately from functions 5Ah and 5Bh (Rabbit only)
 FTWAIT		wait for file transfer to complete (Rabbit only)
 IPAUSE		interruptable pause
 RABESC		??? (Rabbit only)
 NORABESC	??? (Rabbit only)
 SCANCODE	??? (Rabbit only)
 STRLEN		use explicit string lengths
 STREOT		use terminated strings
 SRCHALL	search entire presentation space
 SRCHFROM	search from specified offset
 SRCHFRWD	search forward from position 1
 SRCHBKWD	search backward from last position in presentation space
 TIMEOUT=n	??? (Rabbit only)
 TWAIT		wait specified time for keyboard ready
 LWAIT		wait until keyboard ready
 NWAIT		no wait
 TRON		enable tracing
 TROFF		disable tracing
 AUTORESET	send reset before sending keys with function 03h
 NORESET	don't send reset
 QUIET		don't display messages sent with INT 21/AH=09h
 NOQUIET	allow messages to be displayed
 TIMEOUT=n	set timeout in 30-second intervals, 0 = wait until ^Break
 XLATE		translate extended attribute bytes
 NOXLATE	don't translate
 NEWRET		use HLLAPI v3.0 return code conventions
 OLDRET		use HLLAPI v2.0 return code conventions

(Table 2080)
Values for Windows HLLAPI return code:
 00h	successful
 01h	Presentation Space not connected/requested size unavailable
 02h	invalid function or parameter error/invalid block ID
 03h	file transfer complete
 04h	file transfer complete (segmented)/Presentation Space busy
 05h	inhibited or keyboard locked
 06h	data truncated
 07h	invalid Presentation Space position
 08h	operation not available
 09h	system error
 0Ah	blocking error
 0Bh	resource not available
 0Ch	session stopped
 14h	undefined key combination
 15h	OIA updated
 16h	Presentation Space updated
 17h	both Presentation Space and OIA updated
 18h	no such field
 19h	no keystrokes available
 1Ah	Presentation Space or Operator Information Area changed
 1Bh	file transfer aborted
 1Ch	zero-length field
 1Eh	cursor type invalid
 1Fh	keystroke overflow
 20h	another application is already connected
 22h	message sent to host cancelled
 23h	transmission from host cancelled
 24h	lost contact with host
 25h	function successful
 26h	function incomplete
 27h	a DDM session is already connected
 28h	disconnected, but asynchronous requests still pending
 29h	buffer already in use
 2Ah	no matching request found
12Dh	invalid function number
12Eh	file not found
131h	access denied
134h	out of memory
136h	environment invalid
137h	format invalid
270Eh (9998) invalid Presentation Space ID
270Fh (9999) invalid row or column code
---Windows HLLAPI extensions---
F000h	asynchronous call already in progress
F001h	invalid asynchronous task ID
F002h	blocking call cancelled
F003h	underlying subsystem not started
F004h	unsupported application version
--------V-7F0105-----------------------------
INT 7F - HDILOAD.EXE - 8514/A VIDEO CONTROLLER INTERFACE
	AX = 0105h
Return: CF set on error
	CF clear if successful
	    CX:DX -> array of FAR pointers to entry points (see #2081)
Note:	most functions are invoked by pushing the DWORD parameter block pointer
	  and then performing a FAR call via the appropriate vector of the
	  entry point array
SeeAlso: AX=0104h,AX=ABCDh

(Table 2081)
Values for HDILOAD function number: (do FAR call via entry_points+4*function)
 08h	HOPEN
 10h	HINT
 13h	HLDPAL
 15h	HBBW
 17h	HBBR
 18h	HBBCHN
 1Dh	HQMODE
 22h	HCLOSE
 30h	HINIT
 31h	HSYNC
 39h	HSPAL
 3Ah	HRPAL
--------N-7F02-------------------------------
INT 7F - Alloy NTNX, MW386 - RELEASE SEMAPHORE
	AH = 02h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see #2075)
	AH = semaphore owner if status=02h
SeeAlso: AH=00h,AH=01h,AH=42h
--------N-7F02-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - SEND FRAME
	AH = 02h
	AL = stream number (01h-40h)
	CX = length of frame
	ES:SI -> frame to be sent
SeeAlso: AH=03h"G8BPQ",AH=07h"G8BPQ",AH=0Ah"G8BPQ"
--------f-7F0200-----------------------------
INT 7F - Btrieve Multi-User - GIVE UP TIME???
	AX = 0200h
SeeAlso: INT 2F/AX=AB01h,INT 2F/AX=AB02h,INT 7B"Btrieve"
--------N-7F03-------------------------------
INT 7F - Alloy ANSK, NTNX, MW386 - GET USER NUMBER
	AH = 03h
Return: AL = user number
	AH = machine number (MW386)
Note:	this function call is the recommended method for a CPU-bound process to
	  prevent its priority from being lowered
SeeAlso: AH=04h,AH=05h,AH=A1h
--------N-7F03-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - RECEIVE FRAME
	AH = 03h
	AL = stream number (01h-40h)
	ES:DI -> buffer for frame (must be large enough for a full frame; 350
		  bytes is usually sufficient)
Return:	BX = number of pending frames (0000h if returned frame was last avail)
	CX = length of received frame
SeeAlso: AH=02h"G8BPQ",AH=07h"G8BPQ",AH=0Bh"G8BPQ"
--------N-7F04-------------------------------
INT 7F - Alloy NTNX, MW386 - GET NUMBER OF USERS
	AH = 04h
Return: AL = total number of users on currrent machine (MW386)
	AL = number of slaves on system (NTNX)
SeeAlso: AH=03h
--------N-7F04-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - GET STREAM STATUS
	AH = 04h
	AL = stream number (01h-40h)
Return: CX = state (0000h disconnected, 0001h connected)
	DX = delta state (0000h no change, 0001h changed since last check)
SeeAlso: AH=02h"G8BPQ",AH=05h"G8BPQ"
--------N-7F05-------------------------------
INT 7F - Alloy NTNX (Host) - LOCK/UNLOCK SYSTEM, SPOOLER CONTROL
	AH = 05h
	AL = function
	    00h lock system (disable slave services)
	    01h unlock system
	    02h enable spooler
	    03h disable spooler
	    04h enable slave timer update
	    05h disable slave timer update
	    06h enable form feeds
	    07h disable form feeds
SeeAlso: INT 17/AH=A4h
--------N-7F05-------------------------------
INT 7F - Alloy NTNX (Slave), MW386 - GET USER PARAMETERS
	AH = 05h
	DX:DI -> buffer for user information record (see #2082)
Notes:	MW386 provides this function for backward compatibility only, and sets
	  many of the fields to zero because they are meaningless under MW386
	this function has no effect when called by the host (user 0)
SeeAlso: AH=03h

Format of Alloy user information record:
Offset	Size	Description	(Table 2082)
 00h	WORD	segment of video RAM
 02h	WORD	segment of secondary copy of video RAM
 04h	WORD	offset of screen update flag (see INT 10/AH=8Bh)
		flag nonzero if update needed
 06h	WORD	video NMI enable port
		(not used by MW386, set to 0000h)
 08h	WORD	video NMI disable port
		(not used by MW386, set to 0000h)
 0Ah	BYTE	processor type
		00h 8088
		01h V20
		02h 8086
		03h V30
		06h 80386
 0Bh	WORD	multitasking flag (00h = single tasking, 01h = multitasking)
		(not used by MW386, set to 0000h)
 0Dh	WORD	offset of terminal driver
		(not used by MW386, set to 0000h)
 0Fh	BYTE	port for console I/O
		(not used by MW386, set to 0000h)
 10h	WORD	offset of processor communication busy flag
		bit 7 set when slave communicating with host
 12h	WORD	pointer to FAR NX system call
		(not used by MW386, set to 0000h)
 14h	WORD	offset of 16-byte user configuration record (see AH=38h)
 16h	WORD	offset of command/status word
 18h	WORD	offset of screen valid flag (see INT 10/AH=93h)
		nonzero if screen must be repainted
 1Ah	WORD	offset of screen repaint flag
 1Ch	WORD	pointer to NEAR NX system call
		(not used by MW386, set to 0000h)
 1Eh	WORD	offset for intercept flags
		(not used by MW386, set to 0000h)
		intercept flag = FFh if MS-DOS intercepts should be disabled
 20h	WORD	offset of terminal lock flag (see INT 10/AH=92h)
		lock flag = FFh if backgrnd screen updates should be suspended
 22h 26 BYTEs	reserved
--------N-7F05-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - ACKNOWLEDGE STREAM STATUS CHANGE
	AH = 05h
	AL = stream number (01h-40h)
Note:	this function must be called in order to receive a report of another
	  status change
SeeAlso: AH=04h"G8BPQ"
--------N-7F06-------------------------------
INT 7F - Alloy NTNX (Host) - GET SHARED DRIVE INFO
	AH = 06h
	AL = drive number (1=A:, 2=B:, etc)
	ES:DI -> drive info record (see #2083)
Return: AX = status
	    0000h successful
		ES:DI buffer filled
	    0001h not shared drive

Format of Alloy drive info record:
Offset	Size	Description	(Table 2083)
 00h	WORD	segment of drive IO-REQUEST structure (MS-DOS DPB)
 02h	WORD	segment of allocation map (owner table)
		one byte per FAT entry, containing user ID owning that entry
 04h	WORD	segment of master FAT for drive (copy of FAT on disk)
 06h	WORD	pointer to configuration file
 08h	WORD	total number of clusters
 0Ah	WORD	bytes per sector
 0Ch	WORD	sectors per cluster
 0Eh	BYTE	FAT type (0Ch = 12-bit, 10h = 16-bit)
--------N-7F06-------------------------------
INT 7F - Alloy NTNX (Slave) - ALLOCATE FREE CLUSTER ON SHARED DRIVE
	AH = 06h
	DL = drive number (1=A:,2=B:,etc)
	CX = number of clusters to allocate
Return: AH = status
	    00h successful
		CX = number of clusters still free
	    10h invalid shared drive request
		CL = first and second shared drives
	    11h invalid cluster count (must be 01h-FFh)
--------N-7F06-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - SESSION CONTROL
	AH = 06h
	AL = stream number (01h-40h)
	CX = subfunction
	    0000h connect to node
		DL bit 0: use BBS callsign instead of Node Call
	    0001h connect ot node
		use BBS Call if APPLMASK=1
	    0002h disconnect
	    0003h return user to node
SeeAlso: AH=01h"G8BPQ",AH=04h"G8BPQ"
--------N-7F07-------------------------------
INT 7F - Alloy NTNX, MW386 - GET LIST OF SHARED DRIVES
	AH = 07h
Return: ES:DI -> shared drive list (see #2084)
Note:	MW386 considers all fixed disks to be shared drives; only C and D will
	  be returned as shared

Format of Alloy shared drive list:
Offset	Size	Description	(Table 2084)
 00h	BYTE	string length
 01h	BYTE	number of shared drives
 02h  N BYTEs	one byte per shared drive
--------N-7F07-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - GET BUFFER COUNTS FOR STREAM
	AH = 07h
	AL = stream number (01h-40h)
Return: BX = number of pending receive frames
	CX = number of unacknowledged sent frames
	DX = number of buffers available
SeeAlso: AH=02h"G8BPQ",AH=03h"G8BPQ"
--------N-7F08-------------------------------
INT 7F - Alloy NTNX (Host) - GET INTERRUPT VECTORS
	AH = 08h
	CL = function
	    00h get original interrupt vector
	    01h get Network Executive interrrupt
	AL = interrupt number
	DX:SI -> DWORD to hold interrupt vector
Return: AL = status
	    00h successful
	    01h interrupt vector not used by network executive
	    02h invalid subfunction
Note:	the network executive uses interrupts 02h,08h,09h,0Fh,10h,13h,16h-19h,
	  1Ch,20h,28h,2Ah,2Fh,5Bh,67h,7Fh,ECh, and F0h-FFh
SeeAlso: AH=09h/CL=03h,INT 21/AH=35h
--------N-7F08--CL02-------------------------
INT 7F - Alloy NTNX - SET MESSAGE DISPLAY TIMEOUT
	AH = 08h
	CL = 02h
	DX = timeout in seconds
Return: AL = status
	    00h successful
	    02h invalid subfunction
--------N-7F08-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - PORT CONTROL/INFORMATION
	AH = 08h
	AL = stream number (01h-40h)
Return: ES:DI -> 10-byte buffer containing blank-padded callsign
	---v4.05+ ---
	AL = radio port to which channel is connected (level 2)
	AH = session type (see #2085)
	BX = L2 paclen for session
	CX = maximum frame size
	DX = L4 window size or 0000h if not L4 circuit
Program: the G8BPQ AX25 Networking Package is amateur packet radio software by
	  John Wiseman which allows a PC to act as a node in an AX.25 network
SeeAlso: AH=01h"G8BPQ",AH=02h"G8BPQ",AH=03h"G8BPQ",AH=0Ah"G8BPQ"

Bitfields for G8BPQ session type:
Bit(s)	Description	(Table 2085)
 0	L2LINK
 1	SESSION
 2	UPLINK
 3	DOWNLIND
 5	BPQHOST
--------T-7F09-------------------------------
INT 7F - MultiLink Advanced - SET TASK PRIORITY
	AH = 09h
	AL = priority (0-7)
Note:	the installation check consists of ensuring that the interrupt vector
	  is not pointing at segment 0000h, then checking whether the byte
	  at offset 0000h in the interrupt handler's segment is E9h
Index:	installation check;MultiLink Advanced
--------N-7F09-------------------------------
INT 7F - G8BPQ - proposed addition - GET NODE/APPLICATION CALLSIGN AND ALIAS
	AH = 09h
	AL = application
	    00h node
	    01h BBS
	    02h HOST
	    03h SYSOP
	BL = what to get (00h callsign, 01h application name)
	ES:SI -> buffer for callsign/name string
Return: CX = length of returned string
SeeAlso: AH=00h"G8BPQ",AH=01h"G8BPQ",AH=0Ch"G8BPQ"
--------N-7F09-------------------------------
INT 7F - Alloy NTNX - ENABLE/DISABLE MUD FILE CHECKING
	AH = 09h
	CL = function
	    00h enable checking of RTNX.MUD file
	    01h disable RTNX.MUD checking
--------N-7F09--CL02-------------------------
INT 7F - Alloy NTNX - SWITCH HOST TO DEDICATED MODE
	AH = 09h
	CL = 02h
Note:	in dedicated mode, the host will only poll for I/O requests from the
	  slave processors, and not provide workstation services
--------N-7F09--CL03-------------------------
INT 7F - Alloy NTNX,MW386 - GET ALTERNATE INTERRUPT
	AH = 09h
	CL = 03h
	AL = default interrupt number (67h,7Fh,etc)
Return: CL = actual interrupt which handles specified interrupt's calls
SeeAlso: AH=08h
--------N-7F0A--CL00-------------------------
INT 7F - Alloy NTNX - GET SYSTEM FLAGS
	AH = 0Ah
	CL = 00h
	ES:DI -> buffer for system flags (see #2086)
Return: ES:DI buffer filled
Notes:	on a slave, only the NX_Busy flag is returned
	all three flags are at fixed positions, so this function only needs to
	  be called once
	an interrupt handler should only perform DOS or device accesses when
	  all three flags are 00h

Format of Alloy system flags:
Offset	Size	Description	(Table 2086)
 00h	DWORD	pointer to NX_Busy flag (nonzero when communicating with users)
 04h	DWORD	pointer to device driver busy flag
 08h	DWORD	pointer to InTimer flag
--------N-7F0A-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - TRANSMIT RAW (KISS) FRAME
	AH = 0Ah
	AL = radio port
	ES:SI -> buffer containing data to be sent
	CX = number of bytes to send
SeeAlso: AH=02h"G8BPQ",AH=08h"G8BPQ",AH=0Bh"G8BPQ"
--------N-7F0B--CL02-------------------------
INT 7F - Alloy NTNX (Host) - SET/RESET GRAPHICS DOS ON SLAVE
	AH = 0Bh
	CL = 02h
	AL = slave ID number
	CH = DOS to activate
	    00h graphics DOS
	    01h character DOS
Return: AL = status
	    00h successful
	    01h nothing done, proper DOS type already loaded
--------N-7F0B-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - RECEIVE TRACE (RAW DATA) FRAME
	AH = 0Bh
	ES:DI -> buffer for received data (see #2087)
Return: CX = number of bytes received
Note:	the specified buffer must be large enough to receive a full frame
SeeAlso: AH=03h"G8BPQ",AH=08h"G8BPQ",AH=0Ah"G8BPQ"

Format of G8BPQ received data:
Offset	Size	Description	(Table 2087)
 00h	WORD	internal control information
 02h	BYTE	port number (bit 7 set if transmitted frame)
 03h	WORD	frame length including this header
 05h	var	user data
--------N-7F0C-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - UPDATE SWITCH INFORMATION
	AH = 0Ch
	DX = function
	    0001h update beacon text
		CX = length of data
		ES:SI -> data to be sent in beacons
SeeAlso: AH=09h"G8BPQ"
--------N-7F0F-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - GET TIME MARKER
	AH = 0Fh
Return: AX = time marker (clock ticks modulo 64K)
Program: the G8BPQ AX25 Networking Package is amateur packet radio software by
	  John Wiseman which allows a PC to act as a node in an AX.25 network
SeeAlso: AH=01h"G8BPQ",INT 1A/AH=00h
--------N-7F10--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - OPEN CHANNEL
	AH = 10h
	CL = 00h
	AL = channel number
	DX:DI -> channel buffer
Return: AL = status (00h-03h,0Dh) (see #2088)
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=01h,AH=10h/CL=04h,AH=14h/CL=02h

(Table 2088)
Values for Alloy function status:
 00h	successful
 01h	busy
 02h	channel range error (not 00h-3Fh)
 03h	invalid subfunction
 0Ah	channel not open
 0Ch	channel already locked
 0Dh	unable to open
--------N-7F10--CL01-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - CLOSE CHANNEL
	AH = 10h
	CL = 01h
	AL = channel number
Return: AL = status (00h-03h,0Ah) (see #2088)
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=00h,AH=10h/CL=05h
--------N-7F10--CL02-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - LOCK CHANNEL
	AH = 10h
	CL = 02h
	AL = channel number
Return: AL = status (00h-03h,0Ah,0Ch) (see #2088)
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=03h,AH=10h/CL=06h,AH=10h/CL=08h
--------N-7F10--CL03-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - UNLOCK CHANNEL
	AH = 10h
	CL = 03h
	AL = channel number
Return: AL = status (00h-03h,0Ah) (see #2088)
Notes:	should only be used on channels locked with AH=10h/CL=02h, not on those
	  locked by receipt of a datagram
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=02h,AH=10h/CL=04h,AH=10h/CL=09h
--------N-7F10--CL04-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - RELEASE BUFFER
	AH = 10h
	CL = 04h
	AL = channel number
Return: AL = status (00h-03h) (see #2088)
Notes:	unlocks buffer after received datagram has been processed
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=00h
--------N-7F10--CL05-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - CLOSE ALL CHANNELS
	AH = 10h
	CL = 05h
Return: AL = status (00h-03h) (see #2088)
Notes:	clears all pending datagrams and clears buffer pointers before closing
	  the channels
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=01h
--------N-7F10--CL06-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - LOCK ALL OPEN CHANNELS
	AH = 10h
	CL = 06h
Return: AL = status (00h-03h) (see #2088)
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=02h,AH=10h/CL=08h
--------N-7F10--CL07-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - UNLOCK ALL LOCKED IDLE CHANNELS
	AH = 10h
	CL = 07h
Return: AL = status (00h-03h) (see #2088)
Notes:	unlocks all locked channels which have no pending datagrams
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=03h,AH=10h/CL=09h
--------N-7F10--CL08-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - LOCK MULTIPLE CHANNELS
	AH = 10h
	CL = 08h
	DX = maximum channel number to lock
Return: AL = status (00h-03h) (see #2088)
Notes:	locks channels numbered 00h through the value in DX
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=02h,AH=10h/CL=06h,AH=10h/CL=09h
--------N-7F10--CL09-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - UNLOCK MULTIPLE CHANNELS
	AH = 10h
	CL = 09h
	DX = maximum channel number to unlock
Return: AL = status (00h-03h) (see #2088)
Notes:	unlocks channels numbered 00h through the value in DX
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=03h,AH=10h/CL=07h,AH=10h/CL=08h
--------N-7F11-------------------------------
INT 7F - Alloy NTNX, MW386 - SEND DATAGRAM
	AH = 11h
	DX:SI -> request block (see #2090)
Return: AL = status (see #2089)
Note:	if wildcard channel FFh used, actual channel number will be filled in
SeeAlso: AH=12h

(Table 2089)
Values for Alloy function status:
 00h	successful
 01h	busy
 02h	channel range error (not 00h-3Fh)
 03h	invalid subfunction
 0Ah	packet too large (or <2 bytes if NTNX)
 0Bh	can't send packet to itself
 0Ch	invalid number of destinations
 0Dh	destination channel number out of range
 0Eh	destination user is busy
 0Fh	destination user has locked channel
 10h	channel not open
 11h	no datagram server on destination (NTNX)

Format of Alloy request block:
Offset	Size	Description	(Table 2090)
 00h	DWORD	pointer to packet to send
 04h	WORD	packet size in bytes (1-4096)
 06h	BYTE	number of destinations for packet (max 1Fh)
 07h 31 BYTEs	destination user IDs (FFh = broadcast to all except sender)
 26h 31 BYTEs	destination channels (FFh = first available channel)
 45h 31 BYTEs	return destination statuses
--------N-7F12-------------------------------
INT 7F - Alloy NTNX, MW386 - ACKNOWLEDGE DATAGRAM
	AH = 12h
	AL = channel number being acknowledged
	DI:DX = 32-bit status to return to sender
Return: AL = status (see #2091)
Note:	also unlocks the channel, allowing the next datagram to be received
SeeAlso: AH=11h,AH=15h/CL=04h

(Table 2091)
Values for Alloy function status:
 00h	successful
 01h	busy
 02h	channel range error (not 00h-3Fh)
 03h	invalid subfunction
 0Ah	channel not open
 0Bh	no message in channel
 0Ch	destination slave busy--retry (NTNX)
 0Dh	destination user not active
 0Eh	destination slave not active (NTNX)
 0Fh	destination disabled datagram service
--------V-7F1234-----------------------------
INT 7F - TIGA Communications Driver v2.05 - UNINSTALL
	AX = 1234h
SeeAlso: AX=4321h
--------N-7F13--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - RESET USER DATAGRAMS
	AH = 13h
	CL = 00h
Note:	clears all pending datagrams and removes all channels opened in NTNX
	  compatibility mode
--------N-7F14--CL00-------------------------
INT 7F - Alloy NTNX, MW386 -  SET RECEIVE ISR
	AH = 14h
	CL = 00h
	DX:DI -> application FAR receive service routine (see #2092)
Return: AL = status (00h-03h) (see #2091)
SeeAlso: AH=14h/CL=01h,AH=14h/CL=03h

(Table 2092)
Values Alloy receive service routine is called with:
	DH = sender ID
	DL = channel with datagram
	interrupts disabled
Return: AL = response code
	    00h leave buffer locked, set channel status, and repeat call later
	    01h release channel buffer
	    02h change buffer pointer to DX:DI
	AH,CX,DX,DI,SI may be destroyed
--------N-7F14--CL01-------------------------
INT 7F - Alloy NTNX, MW386 - SET ACKNOWLEDGE ISR
	AH = 14h
	CL = 01h
	DX:DI -> application FAR acknowledge service routine (see #2093)
Return: AL = status (00h-03h) (see #2091)
Note:	the service routine will be called as soon as an acknowledgment arrives
SeeAlso: AH=12h,AH=14h/CL=00h,AH=14h/CL=04h,AH=15h/CL=04h

(Table 2093)
Values Alloy acknowledge service routine is called with:
	DS:SI -> acknowledge structure (see #2097)
Return: AL = response code
	    00h application busy, network executive should call again later
	    01h acknowledge accepted
	AH,DX,SI may be destroyed
--------N-7F14--CL02-------------------------
INT 7F - Alloy NTNX, MW386 - SET CHANNEL BUFFER POINTER
	AH = 14h
	CL = 02h
	AL = channel number
	DX:DI -> receive buffer
Return: AL = status (00h-03h) (see #2091)
Note:	may be called from within a receive ISR or when a datagram is pending
SeeAlso: AH=10h/CL=00h,AH=14h/CL=00h
--------N-7F14--CL03-------------------------
INT 7F - Alloy NTNX, MW386 - GET RECEIVE ISR
	AH = 14h
	CL = 03h
Return: DX:DI -> current receive ISR
SeeAlso: AH=14h/CL=00h,AH=14h/CL=04h
--------N-7F14--CL04-------------------------
INT 7F - Alloy NTNX, MW386 - GET ACKNOWLEDGE ISR
	AH = 14h
	CL = 04h
Return: DX:DI -> current acknowledge ISR
SeeAlso: AH=14h/CL=01h,AH=14h/CL=03h
--------N-7F14--CL05-------------------------
INT 7F - Alloy NTNX (Host), MW386 - GET BUSY POINTER
	AH = 14h
	CL = 05h
	DX:DI -> buffer for busy structure (see #2094)
Return: DX:DI buffer filled

Format of Alloy busy structure:
Offset	Size	Description	(Table 2094)
 00h	DWORD	pointer to busy flag byte
 04h	WORD	fixed port address (FF00h)
--------N-7F15--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - GET CHANNEL STATUS
	AH = 15h
	CL = 00h
	AL = channel number
	DX:DI -> status structure (see #2095)
Return: AL = status (00h-03h) (see #2091)
SeeAlso: AH=15h/CL=01h

Format of Alloy channel status structure:
Offset	Size	Description	(Table 2095)
 00h	BYTE	channel status
		bit 0: channel open
		bit 1: channel buffer contains received data
		bit 7: channel locked
 01h	BYTE	sender ID
--------N-7F15--CL01-------------------------
INT 7F - Alloy NTNX, MW386 - GET NEXT FULL CHANNEL
	AH = 15h
	CL = 01h
	DX:DI -> full-channel structure (see #2096)
Return: AL = status
	    00h successful
	    01h busy
	    0Ah no datagrams available
Note:	MW386 v1.0 returns the lowest channel with a datagram; newer versions
	  and NTNX return the oldest datagram
SeeAlso: AH=15h/CL=00h

Format of Alloy full-channel structure:
Offset	Size	Description	(Table 2096)
 00h	BYTE	number of channel with oldest datagram
 01h	BYTE	sender ID
--------N-7F15--CL02-------------------------
INT 7F - Alloy NTNX, MW386 - GET MAXIMUM NUMBER OF CHANNELS
	AH = 15h
	CL = 02h
Return: AH = number of channels available (40h for MW386)
Note:	the application may always assume at least 32 channels available
SeeAlso: AH=15h/CL=03h
--------N-7F15--CL03-------------------------
INT 7F - Alloy NTNX, MW386 - GET MAXIMUM PACKET SIZE
	AH = 15h
	CL = 03h
	DX:DI -> WORD for return value
Return: buffer WORD filled with maximum packet size (4096 for MW386)
SeeAlso: AH=15h/CL=02h
--------N-7F15--CL04-------------------------
INT 7F - Alloy NTNX, MW386 - GET AND CLEAR ACKNOWLEDGE STATUS
	AH = 15h
	CL = 04h
	DX:DI -> status structure (see #2097)
Return: AL = status
	    00h successful
		DX:DI structure filled
	    01h busy
	    0Ah no acknowledgement has arrived
SeeAlso: AH=12h,AH=14h/CL=01h

Format of Alloy status structure:
Offset	Size	Description	(Table 2097)
 00h	BYTE	sender ID
 01h	BYTE	channel number
 02h  4 BYTEs	receiver status (see #2091)
--------N-7F16-------------------------------
INT 7F - Alloy NTNX, MW386 - DIRECT MEMORY TRANSFER
	AH = 16h
	DX:SI -> transfer structure (see #2098)
Return: AL = status
	    00h successful
	    0Ah source or destination out of range
	    0Bh transfer kernal busy--try again
Notes:	this call transfers memory contents directly between users; both source
	  and destination user IDs may differ from the caller's ID
	no segment wrap is allowed

Format of Alloy transfer structure:
Offset	Size	Description	(Table 2098)
 00h	WORD	bytes to transfer
 02h	BYTE	source ID
		FEh = caller
 03h	DWORD	source address
 07h	BYTE	destination ID
		FFh = all slaves except caller
		FEh = caller
 08h	DWORD	destination address
--------N-7F21-------------------------------
INT 7F - Alloy NTNX, MW386 - SEND MESSAGE OR COMMAND TO USER(S)
	AH = 21h
	AL = sender's user ID
	DS:DX -> control packet (see #2099)
Note:	messages or commands are ignored if disabled by the destination user
SeeAlso: AH=22h

Format of Alloy control packet:
Offset	Size	Description	(Table 2099)
 00h	BYTE	packet type
		00h message
		01h NTNX command
		02h MW386 command
 01h	BYTE	destination user ID or 'A' for all users
 02h 62 BYTEs	ASCIZ message (packet type 00h)
		BIOS keycodes terminated by NUL byte (type 01h) or word (02h)
Note:	a maximum of 16 keycodes will be processed for NTNX and MW386 commands
--------N-7F22-------------------------------
INT 7F - Alloy NTNX - GET MESSAGE
	AH = 22h
Return: pending messages displayed on user's screen
SeeAlso: AH=21h
--------N-7F24-------------------------------
INT 7F - Alloy NTNX, MW386 - ATTACH OR RELEASE DRIVE FOR LOW-LEVEL WRITE ACCESS
	AH = 24h
	CL = function
	    00h attach
	    01h release
	CH = drive (0=A:,1=B:,etc)
Return: AX = status (see #2100)
Note:	only drives on the current machine may be attached

(Table 2100)
Values for Alloy function status:
 00h	successful
 01h	invalid request
 02h	already attached
 03h	not attached
 04h	lock table full
--------N-7F24-------------------------------
INT 7F - Alloy NTNX - ATTACH/RELEASE HOST PROCESSOR
	AH = 24h
	CL = function
	    02h attach host
	    03h release host
Return: AX = status (see #2100)
Note:	the host processor may be attached in order to perform I/O via the host
--------N-7F25--CL00-------------------------
INT 7F - Alloy ANSK, NTNX, MW386 - GET NETWORK EXECUTIVE VERSION
	AH = 25h
	CL = 00h
Return: AH = version suffix letter
	CH = major version number
	CL = minor version number
SeeAlso: AH=25h/CL=01h
--------N-7F25--CL01-------------------------
INT 7F - Alloy ANSK, NTNX, MW386 - GET NETWORK EXECUTIVE TYPE
	AH = 25h
	CL = 01h
Return: CL = executive type (see #2101)
SeeAlso: AH=25h/CL=00h

(Table 2101)
Values for Alloy network executive type:
 00h	RTNX
 01h	ATNX
 02h	NTNX
 03h	BTNX
 04h	MW386
 05h	ANSK
----------7F2525-----------------------------
INT 7F - TIGA Communications Driver v2.05 - ???
	AX = 2525h
	BX = ???
Return: ???
SeeAlso: AX=4321h,AX=5555h
--------N-7F26--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - GET NTNX FILE MODE
	AH = 26h
	CL = 00h
Return: AX = file mode bits (see #2102)
Note:	MW386 does not support file modes, and always returns AX=001Fh
SeeAlso: AH=26h,AH=26h/CL=06h

Bitfields for Alloy file mode bits:
Bit(s)	Description	(Table 2102)
 0	directory protection enabled
 1	extended open enabled
 2	flush on every disk write
 3	flush on every disk write in locked interval
 4	flush on reads from simultaneously opened file
--------N-7F26-------------------------------
INT 7F - Alloy NTNX - SET FILE I/O CHECKING LEVEL
	AH = 26h
	CL = check type to set/reset
	    01h directory protection
	    02h extended open
	    03h flush on every disk write
	    04h flush on disk write if any lock set during write
	    05h flush on all reads if file written
	AL = new state (00h off, 01h on)
SeeAlso: AH=26h/CL=00h,AH=26h/CL=06h
--------N-7F26--CL06-------------------------
INT 7F - Alloy NTNX - CANCEL FLUSH ON WRITE
	AH = 26h
	CL = 06h
Note:	cancels flags set by AH=26h/CL=03h and AH=26h/CL=04h
SeeAlso: AH=26h/CL=00h
--------N-7F30-------------------------------
INT 7F - Alloy MW386 - GET PORT INFORMATION
	AH = 30h
	CX = MW386 port number
Return: AL = result
	    FFh if port not found
	    else driver unit number
		BL = port mode
		BH = port type
		    02h remote
		DH = owner's machine ID
		DL = owner's user ID
SeeAlso: INT 17/AH=8Bh
--------N-7F31-------------------------------
INT 7F - Alloy MW386 v1.x only - CHECK PORT ASSIGNMENT
	AH = 31h
	???
Return: ???
--------N-7F37-------------------------------
INT 7F - Alloy NTNX (Host) - GET SEMAPHORE TABLE
	AH = 37h
Return: ES:AX -> semaphore table
--------N-7F37-------------------------------
INT 7F - Alloy ANSK, NTNX (Slave) - DUMP STRING TO TERMINAL
	AH = 37h
	DS:DX -> ASCIZ string to display
Note:	if the string is empty, a terminal update will be forced
--------N-7F38-------------------------------
INT 7F - Alloy NTNX (Slave), MW386 - SET NEW TERMINAL DRIVER
	AH = 38h
	AL = new terminal driver number
	    FFh dummy driver
	    FEh current driver
	    FDh load new driver
		DS:SI -> new driver
SeeAlso: AH=39h
--------N-7F39-------------------------------
INT 7F - Alloy MW386 - SET TERMINAL DRIVER FOR ANOTHER USER
	AH = 39h
	AL = new terminal driver number
	    FFh dummy driver
	    FEh current driver
	    FDh load new driver
		DS:SI -> new driver
	DL = user number (FFh = caller)
	DH = machine number if DL <> FFh
Return: CF set if invalid user number
	CF clear if successful
Notes:	only available to supervisors
	the new driver number will not take effect until the user is rebooted
SeeAlso: AH=38h
--------N-7F3A-------------------------------
INT 7F - Alloy MW386 - GET TERMINAL PARAMETERS
	AH = 3Ah
	DL = user number (FFh = caller)
	DH = machine number
Return: CF clear if successful
	    AH = terminal driver number
	    AL = baud rate (00h = 38400, 01h = 19200, etc)
	    CL = parity (00h none, 01h even, 02h odd)
	    CH = handshaking (00h none, 01h XON/XOFF, 02h DTR/DSR, 03h XPC)
	CF set if invalid user number
SeeAlso: AH=3Bh
--------N-7F3B-------------------------------
INT 7F - Alloy MW386 - SET TERMINAL PARAMETERS
	AH = 3Bh
	AL = baud rate (00h = 38400, 01h = 19200, etc)
	CL = parity (00h none, 01h even, 02h odd)
	CH = handshaking (00h none, 01h XON/XOFF, 02h DTR/DSR, 03h XPC)
	DL = user number (FFh = caller)
	DH = machine number for user
Return: CF set if invalid user number
Notes:	only available to supervisors
	the new parameters will take effect immediately if the user's terminal
	  has not been started, else AH=3Dh must be called to post the changes
SeeAlso: AH=3Ah,AH=3Dh
--------N-7F3C-------------------------------
INT 7F - Alloy MW386 - ENABLE/DISABLE AUTOBAUD DETECT
	AH = 3Ch
	AL = new state (00h disabled, 01h enabled)
	DL = user number (FFh = caller)
	DH = machine number for user
Return: CF set if invalid user number
Note:	only available to supervisors
SeeAlso: AH=3Dh
--------N-7F3D-------------------------------
INT 7F - Alloy MW386 - POST TERMINAL CONFIGURATION CHANGES
	AH = 3Dh
Note:	should be called whenever a program changes the terminal type or its
	  parameters
SeeAlso: AH=3Bh
--------N-7F41-------------------------------
INT 7F - Alloy NTNX - LOCK FILE FOR USER
	AH = 41h
	AL = user ID
	DS:DX -> ASCIZ filename
Return: AL = status (see #2103)
Note:	requests exclusive read/write access to file
SeeAlso: AH=00h,AH=41h"MW386",AH=42h"NTNX"

(Table 2103)
Values for Alloy function status:
 00h	successful
 01h	invalid function
 02h	already locked
 03h	unable to lock
 04h	lock table full or semaphore space exhausted
--------N-7F41-------------------------------
INT 7F - Alloy MW386 - LOCK SEMAPHORE FOR USER
	AH = 41h
	AL = user ID
	DS:DX -> ASCIZ semaphore name
Return: AL = status (see #2103)
SeeAlso: AH=00h,AH=42h"MW386"
--------N-7F42-------------------------------
INT 7F - Alloy NTNX - UNLOCK FILE FOR USER
	AH = 42h
	AL = user ID
	DS:DX -> ASCIZ filename
Return: AL = status (see #2103)
SeeAlso: AH=00h,AH=41h"NTNX",AH=42h"MW386"
--------N-7F42-------------------------------
INT 7F - Alloy MW386 - UNLOCK SEMAPHORE FOR USER
	AH = 42h
	AL = user ID
	DS:DX -> ASCIZ semaphore name
Return: AL = status
	    00h successful
	    01h invalid function
	    03h unable to unlock semaphore
SeeAlso: AH=02h,AH=41h"MW386",AH=42h"NTNX"
----------7F4321-----------------------------
INT 7F - TIGA Communications Driver v2.05 - INSTALLATION CHECK
	AX = 4321h
Return: AX = 0000h if installed
Note:	INT 7F is the default, but may be overridden
SeeAlso: AH=01h"TIGA",AX=1234h,AX=2525h,AX=4321h,AX=5555h
--------N-7F4E-------------------------------
INT 7F - Alloy MW386 v2+ - SET ERROR MODE
	AH = 4Eh
	AL = error mode flags
	    bit 0: display critical disk errors
	    bit 1: display sharing errors
	DX = 4E58h ("NX")
Return: AL = status
	    00h successful
SeeAlso: AH=4Fh
--------N-7F4F-------------------------------
INT 7F - Alloy MW386 v2+ - SET FCB MODE
	AH = 4Fh
	AL = FCB mode
	    02h read/write compatibility
	    42h read/write shared
	DX = 4E58h ("NX")
Return: AL = status
	    00h successful
--------V-7F5555-----------------------------
INT 7F - TIGA Communications Driver v2.05 - ???
	AX = 5555h
	BX = ???
Return: ???
SeeAlso: AX=4321h
--------N-7F81-------------------------------
INT 7F - Alloy NTNX - ATTACH DEVICE FOR USER
	AH = 81h
	AL = user ID
	DS:DX -> ASCIZ device name
SeeAlso: AH=82h
--------N-7F82-------------------------------
INT 7F - Alloy NTNX - RELEASE DEVICE FOR USER
	AH = 82h
	AL = user ID
	DS:DX -> ASCIZ device name
SeeAlso: AH=81h
--------N-7FA0-------------------------------
INT 7F - Alloy MW386 - GET USER NAME
	AH = A0h
	DL = user number (FFh = caller)
	DH = machine number for user
	ES:DI -> 17-byte buffer for ASCIZ user name
Return: CF set if invalid user number
SeeAlso: AH=03h,AH=A1h
--------N-7FA1-------------------------------
INT 7F - Alloy MW386 - GET MACHINE, USER, AND PROCESS NUMBER
	AH = A1h
Return: AL = process number
	DL = user number
	DH = machine number
SeeAlso: AH=03h,AH=A0h,AH=A2h
--------N-7FA2-------------------------------
INT 7F - Alloy MW386 - GET USER PRIVILEGE LEVEL
	AH = A2h
	DL = user number (FFh = caller)
	DH = machine number for user
Return: CF clear if successful
	    AL = privilege level
		00h supervisor
		01h high
		02h medium
		03h low
	CF set if invalid user number
SeeAlso: AH=A1h,AH=A3h
--------N-7FA3-------------------------------
INT 7F - Alloy MW386 - GET USER LOGIN STATE
	AH = A3h
	DL = user number
	DH = machine number for user
Return: CF clear if successful
	    AL = login state
		00h never logged in
		01h currently logged out
		03h currently logged in
	CF set if invalid user number or user not active
SeeAlso: AH=A2h
--------N-7FA4-------------------------------
INT 7F - Alloy MW386 - VERIFY USER PASSWORD
	AH = A4h
	DS:DX -> ASCIZ password (null-padded to 16 bytes)
Return: AL = status
	    00h  accepted
	    else invalid password
--------N-7FA500-----------------------------
INT 7F - Alloy MW386 - GET USER STATUS
	AX = A500h
	DI = machine number and user number
Return: CF clear if successful
	    BX = user flags
		bit 5: allow messages
	    CL = scan code for task manager hotkey
	    CH = scan code for spooler hotkey
	    DL = scan code for task swapper hotkey
	    DH = modifier key status
	CF set if invalid user number
SeeAlso: AX=A501h
Index:	hotkeys;Alloy MW386
--------N-7FA501-----------------------------
INT 7F - Alloy MW386 - SET USER STATUS
	AX = A501h
	BX = user flags (see AX=A500h)
	CL = scan code for task manager hotkey
	CH = scan code for spooler hotkey
	DL = scan code for task swapper hotkey
	DH = modifier key status
	DI = machine number and user number
Return: CF set if invalid user number
Note:	must have supervisor privilege to set another user's status
SeeAlso: AX=A500h
Index:	hotkeys;Alloy MW386
--------V-7FABCDBX0000-----------------------
INT 7F - IBM 8516 Touch Screen Device Driver - GET API ENTRY
	AX = ABCDh
	BX = 0000h
Return: AX = total number of functions available
	ES:BX -> entry point array (see #2104)
SeeAlso: AX=0104h,AX=0105h

(Table 2104)
Values for 8516 Touch Screen function number:
 00h	check initialization and reset (see #2105)
 14h	set user-defined subroutine (see #2106)
Notes:	each driver function takes two stack parameters using Pascal calling
	  conventions: address of parameter block and address of results buffer
	all pointers are FAR pointers
	on return, AX contains the status of the call:
	    AX = 0000h successful
		 0001h invalid input
		 0002h interface error
		 0003h unable to perform function

Format of 8516 Touch Screen Function 00h parameter block:
Offset	Size	Description	(Table 2105)
 00h	WORD	0000h (function number)
Note:	this function should be called before any other device driver functions

Format of 8516 Touch Screen Function 00h results buffer:
Offset	Size	Description	(Table 2106)
 00h	WORD	touch screen status
		0000h unavailable
		0001h uncalibrated
		FFFFh available
 02h	WORD	aux mouse status (0000h not present, FFFFh present)
Notes:	the following driver parameters will have been reset to zero:
	  touchdown counter, liftoff counter, position at last touch, position
	  at last lift, int call mask, select on count, select off count,
	  pos select on count, pos select off count.
	the following driver parameters will have been reset as listed:
	  mouse emulation mode: left on
	  thresholds: 46 on screen, 96 push harder, 80 push release
	  x, y hysteresis: 400
	  data repeat rate: 40/sec
	  select mechanism: push-harder - first-touch
	  coordinate origin: upper left corner
	  filter frequency: medium
	  data block mask: all enabled
	  click lock: on
--------N-7FB0-------------------------------
INT 7F - Alloy NTNX, MW386 - RELEASE ALL SEMAPHORES FOR USER
	AH = B0h
	AL = user number
	DS = code segment
Note:	MW386 ignores AL and DS; it releases all semaphores locked using INT 67
	  or INT 7F locking functions
SeeAlso: AH=B1h,AH=B2h,AH=B3h,AH=B4h
--------N-7FB1--SF00-------------------------
INT 7F - Alloy NTNX, MW386 - RELEASE NORMAL SEMAPHORES FOR USER
	AH = B1h subfn 00h
	AL = (bits 7-5) 000
	     (bits 4-0) user ID
Note:	MW386 ignores AL; it releases all semaphores locked using INT 67 or
	  INT 7F locking functions
SeeAlso: AH=B0h,AH=B2h,AH=B3h,AH=B4h
--------N-7FB2--SF01-------------------------
INT 7F - Alloy NTNX - RELEASE MESSAGES FOR USER
	AH = B2h subfn 01h
	AL = (bits 7-5) 001
	     (bits 4-0) user ID
SeeAlso: AH=B0h,AH=B1h,AH=B3h,AH=B4h
--------N-7FB3--SF02-------------------------
INT 7F - Alloy NTNX - RELEASE FILES FOR USER
	AH = B3h subfn 02h
	AL = (bits 7-5) 010
	     (bits 4-0) user ID
SeeAlso: AH=B0h,AH=B1h,AH=B2h,AH=B4h
--------N-7FB4-------------------------------
INT 7F - Alloy NTNX - RELEASE DEVICES FOR USER
	AH = B4h
	AL = user ID
SeeAlso: AH=B0h,AH=B1h,AH=B2h,AH=B3h
--------N-7FC3-------------------------------
INT 7F - Alloy MW386 - WRITE BYTE TO TERMINAL AUX PORT
	AH = C3h
	AL = byte to write
Return: CF clear if successful
	CF set on error
SeeAlso: AH=C6h
--------N-7FC5-------------------------------
INT 7F - Alloy MW386 - CHANGE CONSOLE MODE
	AH = C5h
	AL = new console mode
	    00h keyboard indirect
	    01h keyboard direct
	    02h data handshake enforced
	    03h no data handshake
Return: CF clear if successful
	    AL = prior console mode
	CF set on error (caller is not remote user)
Note:	modes 2 and 3 may be used for input through the console port; no video
	  output should be performed in these modes
--------N-7FC6-------------------------------
INT 7F - Alloy MW386 - WRITE BYTE TO CONSOLE PORT
	AH = C6h
	AL = byte to write
Return: CF clear if successful
	CF set on error (caller is not remote user)
Note:	any terminal driver data translation will be bypassed
SeeAlso: AH=C3h,AH=C7h
--------N-7FC7-------------------------------
INT 7F - Alloy MW386 - READ CONSOLE DATA BYTE
	AH = C7h
Return: CF clear if successful
	    AL = byte read
	CF set on error (no data available or caller is not remote user)
Note:	used to read data after placing console in mode 2 or 3 (see AH=C5h)
SeeAlso: AH=C5h,AH=C6h,AH=C8h
--------N-7FC8-------------------------------
INT 7F - Alloy MW386 - READ CONSOLE DATA INTO BUFFER
	AH = C8h
	AL = maximum bytes to read
	ES:DI -> buffer for console data
Return: CF clear if successful
	    CX = number of bytes read
	CF set on error (caller is not remote user)
SeeAlso: AH=C7h
--------N-7FCF-------------------------------
INT 7F - Alloy NTNX - REBOOT USER PROCESSOR
	AH = CFh
	DS:DX -> ASCIZ string containing user number to be reset
SeeAlso: AH=D6h
--------N-7FD6-------------------------------
INT 7F - Alloy MW386 - RESET NETWORK EXECUTIVE
	AH = D6h
	DS:DX -> reset packet (see #2107)
Return: never if successful
Note:	all users will be shut down immediately if successful
SeeAlso: AH=CFh

Format of Alloy MW386 reset packet:
Offset	Size	Description	(Table 2107)
 00h	DWORD	reset code (60606060h)
 04h 16 BYTEs	ASCIZ supervisor password padded with nulls
--------N-7FD7-------------------------------
INT 7F - Alloy MW386 - POST EVENT
	AH = D7h
	AL = user number (if local event)
	DX = event number
--------N-7FD8-------------------------------
INT 7F - Alloy MW386 - FLUSH DISK BUFFERS
	AH = D8h
Return: CF set on error
Note:	forces all disk buffers to be written out immediately
SeeAlso: INT 21/AH=0Dh,INT 21/AX=5D01h,INT 2F/AX=1120h
--------N-7FDB-------------------------------
INT 7F - Alloy MW386 v2+ - GET MW386 INVOCATION DRIVE
	AH = DBh
Return: AL = drive from which MW386 was started (2=C:,3=D:,etc)
--------N-7FE0-------------------------------
INT 7F - Alloy MW386 - CREATE DOS TASK
	AH = E0h
	AL = memory size (00h=128K, 01h=256K, 02h=384K, 03h=512K, 04h=640K)
	DS:DX -> ASCIZ task name (max 16 bytes)
Return: CF clear if successful
	    AL = task create ID
	CF set on error
Note:	only foreground DOS tasks can use this function
SeeAlso: AH=E1h,AH=E2h,AH=E3h,AH=E6h,AH=E7h
--------N-7FE1-------------------------------
INT 7F - Alloy MW386 - GET DOS TASK PID FROM CREATE ID
	AH = E1h
	AL = create ID (from AH=E0h)
Return: AL = DOS process number
	CL = memory size (00h=128K, 01h=256K, 02h=384K, 03h=512K, 04h=640K)
Note:	this function should not be called immediately after creating a new
	  DOS task, since the new task is being initialized by a concurrent
	  process
SeeAlso: AH=E0h,AH=E2h
--------N-7FE2-------------------------------
INT 7F - Alloy MW386 - SWITCH TO NEW DOS TASK
	AH = E2h
	AL = DOS process number (from AH=E1h)
Return: CF set on error (invalid process number or caller not foreground task)
Notes:	specified task becomes the foreground task and current task is placed
	  in the background
	may only be called by a foreground task
SeeAlso: AH=E0h,AH=E1h
--------N-7FE3-------------------------------
INT 7F - Alloy MW386 - CHANGE NAME OF DOS TASK
	AH = E3h
	DS:DX -> ASCIZ task name
---v1.x---
	AL = user number
---v2+---
	BH = user number
	BL = task number
Return: CF clear if successful
	CF set on error (invalid process number)
SeeAlso: AH=E0h,AH=E4h,AH=E5h
--------N-7FE4-------------------------------
INT 7F - Alloy MW386 - GET TASK NAME FROM PROCESS NUMBER
	AH = E4h
	ES:DI -> buffer for task name
---v1.x---
	AL = user number
---v2+---
	BH = user number
	BL = task number
Return: CF clear if successful
	    CL = memory size (00h=128K, 01h=256K, 02h=384K, 03h=512K, 04h=640K)
	    DX = task flags
		bit 7: MS-DOS process
	    ES:DI buffer filled
	CF set on error (invalid process number)
SeeAlso: AH=E3h,AH=E5h
--------N-7FE5-------------------------------
INT 7F - Alloy MW386 - GET PROCESS NUMBER FROM TASK NAME
	AH = E5h
	DS:DX -> ASCIZ task name
	BH = user number
Return: CF clear if successful
	    AL = DOS process number
	    CL = memory size (00h=128K, 01h=256K, 02h=384K, 03h=512K, 04h=640K)
	CF set on error (no match for name)
SeeAlso: AH=E3h,AH=E4h
--------N-7FE6-------------------------------
INT 7F - Alloy MW386 - GET NUMBER OF AVAILABLE USER TASKS
	AH = E6h
Return: AX = number of processes available to current user
SeeAlso: AH=E0h
--------N-7FE7-------------------------------
INT 7F - Alloy MW386 - REMOVE DOS TASK
	AH = E7h
	AL = DOS process number
Return:	CF clear if successful
	CF set on error (invalid process number or first process)
Note:	can only be called by a foreground task
SeeAlso: AH=E0h
--------N-7FE8-------------------------------
INT 7F - Alloy MW386 - DOS TASK DELAY
	AH = E8h
	CX = delay time in milliseconds
Note:	a delay of 0 may be used to surrender the current time slice
SeeAlso: INT 15/AX=1000h,INT 1A/AX=FF01h,INT 21/AH=EEh"DoubleDOS"
SeeAlso: INT 2F/AX=1680h
--------N-7FF0-------------------------------
INT 7F - Alloy MW386 - RESTRICT DIRECTORY TO GROUP
	AH = F0h
	AL = group number
	DS:DX -> ASCIZ directory name
Return: CF clear if successful
	    AX = status
		0002h directory not found
		0003h directory not found
		0005h directory in use, cannot be restricted
		02xxh restricted to group xxh
	CF set on error
Note:	the restriction on the directory may be removed by calling this
	  function with group 0, then using AH=F1h to assign the directory to
	  group 0
SeeAlso: AH=F1h,AH=F2h,AH=F3h
--------N-7FF1-------------------------------
INT 7F - Alloy MW386 - ASSIGN DIRECTORY TO GROUP
	AH = F1h
	AL = group number
	DS:DX -> ASCIZ directory name
Notes:	performs permanent assignment to a group; no immediate action is taken
	  unless the directory has been restricted with AH=F0h
	may be used to restrict a nonexistent directory
SeeAlso: AH=F0h
--------N-7FF2-------------------------------
INT 7F - Alloy MW386 - READ RESTRICTED DIRECTORY ENTRY
	AH = F2h
	CX = entry number
	ES:DI -> 64-byte buffer
Return: CF clear if successful
	    buffer filled with 63-byte directory info and 1-byte group number
	CF set on error (invalid entry)
SeeAlso: AH=F0h,AH=F3h
--------N-7FF3-------------------------------
INT 7F - Alloy MW386 - READ RESTRICTED DIRECTORY ENTRY FOR GROUP
	AH = F3h
	AL = group number
	CX = entry number
	ES:DI -> 64-byte buffer
Return: CF clear if successful
	    CX = next entry number
	    buffer filled with 63-byte directory info and 1-byte group number
	CF set on error (no more matching entries)
Note:	like AH=F2h, but only returns directories belonging to the specified
	  group
SeeAlso: AH=F2h
--------N-7FF8-------------------------------
INT 7F - Alloy MW386 - ASSIGN USER TO GROUP
	AH = F8h
	AL = group number
	DL = user number
	DH = machine number (currently 00h)
Return: CF clear if successful
	CF set on error (user already in maximum number of groups)
Note:	each user is allowed eight group assignments
SeeAlso: AH=F9h,AH=FAh
--------N-7FF9-------------------------------
INT 7F - Alloy MW386 - REMOVE USER FROM GROUP
	AH = F9h
	AL = group number
	DL = user number
	DH = machine number (currently 00h)
Return: CF clear if successful
	CF set if failed
SeeAlso: AH=F8h,AH=FAh
--------N-7FFA-------------------------------
INT 7F - Alloy MW386 - GET USER GROUP LIST
	AH = FAh
	DL = user number
	DH = machine number (currently 00h)
	ES:DI -> 16-byte buffer for group list
Return: CX = number of groups
	ES:DI buffer filled with group numbers
SeeAlso: AH=F8h,AH=F9h
--------N-7FFB-------------------------------
INT 7F - Alloy MW386 - ASSIGN GROUP NAME
	AH = FBh
	CL = group number
	ES:DI -> ASCIZ group name (max 17 bytes)
SeeAlso: AH=FCh
--------N-7FFC-------------------------------
INT 7F - Alloy MW386 - GET GROUP NAME
	AH = FCh
	CL = group number
	ES:DI -> 17-byte buffer for ASCIZ name
Return: ES:DI buffer filled
Note:	if the group has not been named, "(unnamed)" is returned
SeeAlso: AH=FBh
----------80---------------------------------
INT 80 - Q-PRO4 - ???
--------r-80---------------------------------
INT 80 - reserved for BASIC
Note:	this vector and INT 81 through INT ED are modified but not restored by
	  Direct Access v4.0, and may be left dangling by other programs
	  written with the same version of compiled BASIC
SeeAlso: INT 81"BASIC",INT 86"BASIC",INT EF"BASIC"
--------s-80----BL00-------------------------
INT 80 - SBSIM - "STARTSND" - START SOUND ON SPECIFIED DRIVER
	BL = 00h
	BH = driver number (01h = FM, 02h=DDBV, 03h=memvoice, 05h=MIDI)
Return: AX = initialization result (see #2108)
Program: SBSIM is Creative Labs' SoundBlaster Simplified Interface Module,
	  which provides access to multiple drivers for the SoundBlaster
	  board through a single interface
Range:	INT 80h to INT BFh, selected automatically
Note:	the SBSIM installation check consists of testing for the signature
	  "SBSIM" at offset 103h in the interrupt handler's segment.
SeeAlso: INT 80/BL=01h"SBSIM",INT 80/BL=02h"SBSIM",INT 80/BL=03h"SBSIM"
SeeAlso: INT 80/BX=0000h"SBSIM"

(Table 2108)
Values for SBSIM error code:
 01h	busy--currently in use
 02h	bad driver specified
 03h	invalid function
 04h	voice process already active
 05h	couldn't start CT-VOICE
 06h	couldn't start CTVDSK
 07h	invalid SBSIM handle
 08h	buffer not initialized yet
 09h	bad filename
 0Ah	bad file handle
 0Bh	driver not started yet
 0Ch	XMS driver not installed
 0Dh	no free SBSIM handles
 0Eh	bad file type
 0Fh	couldn't free XMS block
 10h	invalid source selected
 11h	get pan position failed
 12h	set pan position failed
 13h	set volume failed
 14h	couldn't start fade/pan
 15h	couldn't stop fade/pan
 16h	couldn't pause fade/pan
 17h	not a fade/pan operation
 18h	bad mode for fade/pan
 19h	couldn't start fade/pan
 1Ah	source not fading/panning
 1Bh	FM or MIDI already playing
 1Ch	bad MIDI mapper format
--------s-80----BL01-------------------------
INT 80 - SBSIM - "PLAYSND" - PLAY MUSIC/VOICE ON SELECTED DRIVER
	BL = 01h
	BH = driver number (01h = FM, 02h=DDBV, 03h=memvoice, 05h=MIDI)
Return: AX = result (see #2108)
SeeAlso: INT 80/BL=00h"SBSIM",INT 80/BL=02h"SBSIM",INT 80/BL=04h"SBSIM"
--------s-80----BL02-------------------------
INT 80 - SBSIM - "STOPSND" - STOP MUSIC/VOICE ON SELECTED DRIVER
	BL = 02h
	BH = driver number (01h = FM, 02h=DDBV, 03h=memvoice, 05h=MIDI)
Return: nothing
SeeAlso: INT 80/BL=00h"SBSIM",INT 80/BL=01h"SBSIM",INT 80/BL=03h"SBSIM"
--------s-80----BL03-------------------------
INT 80 - SBSIM - "PAUSESND" - TEMPORARILY PAUSE PLAYBACK ON SELECTED DRIVER
	BL = 03h
	BH = driver number (01h = FM, 02h=DDBV, 03h=memvoice, 05h=MIDI)
Return: nothing
SeeAlso: INT 80/BL=00h"SBSIM",INT 80/BL=02h"SBSIM",INT 80/BL=04h"SBSIM"
SeeAlso: INT 80/BL=05h
--------s-80----BL04-------------------------
INT 80 - SBSIM - "RESUMESND" - RESTART PLAYBACK ON SELECTED DRIVER
	BL = 04h
	BH = driver number (01h = FM, 02h=DDBV, 03h=memvoice, 05h=MIDI)
Return: nothing
SeeAlso: INT 80/BL=00h"SBSIM",INT 80/BL=03h"SBSIM",INT 80/BL=05h"SBSIM"
--------s-80----BL05-------------------------
INT 80 - SBSIM - "GETSNDSTAT" - GET DRIVER'S STATUS
	BL = 05h
	BH = driver number (01h = FM, 02h=DDBV, 03h=memvoice, 05h=MIDI)
Return: AX = status
SeeAlso: INT 80/BL=00h"SBSIM",INT 80/BL=01h"SBSIM",INT 80/BL=03h"SBSIM"
--------s-80----BX0000-----------------------
INT 80 - SoundBlaster SBFM driver - GET VERSION
	BX = 0000h
Return: ???
Note:	SBFM installs at a free interrupt in the range 80h through BFh
SeeAlso: BX=0008h"SBFM",INT 2F/AX=FBFBh
--------s-80----BX0000-----------------------
INT 80 - SBSIM - "QUERYVERSION" - GET VERSION
	BX = 0000h
Return: AX = version (AH = major, AL = minor)
Program: SBSIM is Creative Labs' SoundBlaster Simplified Interface Module,
	  which provides access to multiple drivers for the SoundBlaster
	  board through a single interface
Range:	INT 80h to INT BFh, selected automatically
Note:	the SBSIM installation check consists of testing for the signature
	  "SBSIM" at offset 103h in the interrupt handler's segment.
SeeAlso: BX=0001h"SBSIM",BX=0005h"SBSIM",INT 80/BL=00h"SBSIM"
Index:	installation check;SBSIM|installation check;SoundBlaster
--------s-80----BX0001-----------------------
INT 80 - SoundBlaster SBFM driver - SET MUSIC STATUS BYTE ADDRESS
	BX = 0001h
	DX:AX -> music status byte
SeeAlso: BX=0000h"SBFM",BX=0002h"SBFM",BX=0003h"SBFM"
--------s-80----BX0001-----------------------
INT 80 - SBSIM - "QUERYDRIVERS" - CHECK DRIVERS INSTALLED
	BX = 0001h
Return: AX = bit flags for loaded drivers (see #2109)
SeeAlso: BX=0000h"SBSIM",BX=0002h"SBSIM",BX=0005h"SBSIM",INT 80/BL=00h"SBSIM"

Bitfields for SBSIM loaded drivers:
Bit(s)	Description	(Table 2109)
 0	FM
 1	double disk-buffered voice driver (DDBV)
 2	memory voice driver
 3	auxiliary driver (mixer)
 4	MIDI
--------s-80----BX0002-----------------------
INT 80 - SoundBlaster SBFM driver - SET INSTRUMENT TABLE
	BX = 0002h
	CX = number of instruments
	DX:AX -> instrument table
SeeAlso: BX=0000h"SBFM",BX=0001h"SBFM",BX=0005h"SBFM"
--------s-80----BX0002-----------------------
INT 80 - SBSIM - GETADDRESS" - GET SELECTED DRIVER'S ENTRY POINT
	BX = 0002h
	AX = driver (00h = FM,01h = DDBV,02h = memvoice,03h = mixer,04h = MIDI)
Return: CF clear if successful
	    DX:AX -> entry point
	CF set on error
SeeAlso: BX=0000h"SBSIM",BX=0001h"SBSIM",BX=0005h"SBSIM",INT 80/BL=00h"SBSIM"
--------s-80----BX0003-----------------------
INT 80 - SoundBlaster SBFM driver - SET SYSTEM CLOCK RATE
	BX = 0003h
	AX = clock rate divisor (1193180 / desired frequency in Hertz)
	    FFFFh to restore to 18.2 Hz
SeeAlso: BX=0000h"SBFM",BX=0001h"SBFM",BX=0004h"SBFM"
--------s-80----BX0004-----------------------
INT 80 - SoundBlaster SBFM driver - SET DRIVER CLOCK RATE
	BX = 0004h
	AX = driver clock rate divisor (1193180 / frequency in Hertz)
Note:	default frequency is 96 Hz
SeeAlso: BX=0000h"SBFM",BX=0003h"SBFM"
--------s-80----BX0005-----------------------
INT 80 - SoundBlaster SBFM driver - TRANSPOSE MUSIC
	BX = 0005h
	AX = semi-tone offset
SeeAlso: BX=0000h"SBFM",BX=0002h"SBFM",BX=0006h"SBFM"
--------s-80----BX0005-----------------------
INT 80 - SBSIM - "GETBUFFERINFO" - GET DRIVER'S BUFFER ADDRESS
	BX = 0005h
	AX = driver (00h = FM, 01h = DDB Voice, 04h = MIDI)
Return: CF clear if successful
	    DX:AX -> buffer
	    CX = buffer size in K
	CF set on error
Program: SBSIM is Creative Labs' SoundBlaster Simplified Interface Module,
	  which provides access to multiple drivers for the SoundBlaster
	  board through a single interface
Range:	INT 80h to INT BFh, selected automatically
Note:	the SBSIM installation check consists of testing for the signature
	  "SBSIM" at offset 103h in the interrupt handler's segment.
SeeAlso: BX=0000h"SBSIM",BX=0001h"SBSIM",BX=0002h"SBSIM",INT 80/BL=00h"SBSIM"
--------s-80----BX0006-----------------------
INT 80 - SoundBlaster SBFM driver - PLAY MUSIC
	BX = 0006h
	DX:AX -> music block
Return: AX = status
	    0000h successful
	    0001h music already active
SeeAlso: BX=0000h"SBFM",BX=0007h"SBFM",BX=000Ah"SBFM",INT 1A/AX=FF04h
--------s-80----BX0007-----------------------
INT 80 - SoundBlaster SBFM driver - STOP MUSIC
	BX = 0007h
Return: AX = status
	    0000h successful
	    0001h music not active
SeeAlso: BX=0000h"SBFM",BX=0006h"SBFM",BX=0009h"SBFM",INT 1A/AX=FF05h
--------s-80----BX0008-----------------------
INT 80 - SoundBlaster SBFM driver - RESET DRIVER
	BX = 0008h
Return: AX = status
	    0000h successful
	    0001h music is active
SeeAlso: BX=0000h"SBFM"
--------s-80----BX0009-----------------------
INT 80 - SoundBlaster SBFM driver - PAUSE MUSIC
	BX = 0009h
Return: AX = status
	    0000h successful
	    0001h no music active
SeeAlso: BX=0000h"SBFM",BX=0007h"SBFM",BX=000Ah"SBFM",INT 1A/AX=FF01h
--------s-80----BX000A-----------------------
INT 80 - SoundBlaster SBFM driver - RESUME MUSIC
	BX = 000Ah
Return: AX = status
	    0000h successful
	    0001h no music paused
SeeAlso: BX=0000h"SBFM",BX=0006h"SBFM",BX=0009h"SBFM"
--------s-80----BX000B-----------------------
INT 80 - SoundBlaster SBFM driver - SET USER-DEF TRAP FOR SYSTEM-EXCLUSIVE CMDS
	BX = 000Bh
	DX:AX -> trap routine
SeeAlso: BX=0000h"SBFM"
--------s-80----BX0400-----------------------
INT 80 - SBSIM - "GETVOLUME" - GET SOURCE'S VOLUME
	BX = 0400h
	AX = sound source (see #2110)
Return: CF clear if successful
	    AX = volume
	CF set on error
	    AX = error code (see INT 80/BL=00h)
SeeAlso: BX=0401h"SBSIM"

(Table 2110)
Values for SBSIM sound source:
 00h	master volume
 01h	voice
 02h	FM
 03h	CD
 04h	line in
 05h	microphone
--------s-80----BX0401-----------------------
INT 80 - SBSIM - "SETVOLUME" - SET SOURCE'S VOLUME
	BX = 0401h
	AX = sound source (see INT 80/BX=0400h)
	DX = new volume
Return: AX = result (0000h = success) (see also INT 80/BL=00h)
SeeAlso: BX=0400h"SBSIM"
--------N-8001-------------------------------
INT 80 - QPC Software PKTINT.COM - INITIALIZE
	AH = 01h
Return: AX = 0000h
	CX = FFFFh
	DX = FFFFh
Notes:	this interrupt is the WinQVTNet protected mode interface to Windows 3.0
	all buffer pointers are reset back to 0
--------N-8002-------------------------------
INT 80 - QPC Software PKTINT.COM - GET BUFFER ADDRESSES
	AH = 02h
	BX = extra bytes to allocate per packet
Return: AX = segment address of 10K buffer (for receives???)
	BX = segment address of 2K buffer (for sends???)
SeeAlso: AH=05h
--------N-8003-------------------------------
INT 80 - QPC Software PKTINT.COM - GET ENTRY POINT
	AH = 03h
Return: CX:DX -> receive call address
Note:	the returned address can be used in the packet driver calls since it
	  will be a valid address in all DOS boxes
SeeAlso: AH=06h
--------N-8004-------------------------------
INT 80 - QPC Software PKTINT.COM - ENABLE???
	AH = 04h
	BX = ???
Return: ???
SeeAlso: AH=01h
--------N-8005-------------------------------
INT 80 - QPC Software PKTINT.COM - GET RECEIVE STATISTICS
	AH = 05h
Return: AX = amount of buffer currently in use
	BX = current offset in buffer
	CX = number of times receive has been called
SeeAlso: AH=02h
--------N-8006-------------------------------
INT 80 - QPC Software PKTINT.COM - REMOVE RECEIVED PACKET
	AH = 06h
Return: BX = next packet offset
	CX = number of bytes still buffered
	DX = size of packet released back into buffer pool
SeeAlso: AH=03h
--------r-81---------------------------------
INT 81 - reserved for BASIC
Note:	this vector is modified but not restored by Direct Access v4.0, and
	  may be left dangling by other programs written with the same version
	  of compiled BASIC
SeeAlso: INT 80"BASIC",INT 82"BASIC"
--------N-81---------------------------------
INT 81 - IBM TOKEN RING ADAPTER - ???
SeeAlso: INT 82"TOKEN RING",INT 91"TOKEN RING"
--------r-82---------------------------------
INT 82 - reserved for BASIC
SeeAlso: INT 81"BASIC",INT 83"BASIC"
--------N-82---------------------------------
INT 82 - IBM TOKEN RING ADAPTER - ???
	AH = function
	    00h display message???
		DS:BX -> string
	???
Return: ???
SeeAlso: INT 81"TOKEN RING",INT 91"TOKEN RING"
--------r-83---------------------------------
INT 83 - reserved for BASIC
SeeAlso: INT 82"BASIC",INT 84"BASIC"
--------r-84---------------------------------
INT 84 - reserved for BASIC
SeeAlso: INT 83"BASIC",INT 85"BASIC"
--------r-85---------------------------------
INT 85 - reserved for BASIC
Note:	INT 80 through INT ED are modified but not restored by Direct Access
	  v4.0, and may be left dangling by other programs written with the
	  same version of compiled BASIC
SeeAlso: INT 84"BASIC",INT 86"BASIC"
--------N-86---------------------------------
INT 86 - NetBIOS - ORIGINAL INT 18
Note:	some implementations of NetBIOS reportedly relocate INT 18 here
SeeAlso: INT 18
--------r-86---------------------------------
INT 86 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 85"BASIC",INT 87"BASIC"
--------r-86---------------------------------
INT 86 - APL*PLUS/PC - Terminate APL session and return to DOS
SeeAlso: INT 21/AH=4Ch,INT 87"APL"
--------r-87---------------------------------
INT 87 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 86"BASIC",INT 88"BASIC"
--------r-87---------------------------------
INT 87 - APL*PLUS/PC - ???
SeeAlso: INT 86"APL",INT 88/AL=00h
--------v-87---------------------------------
INT 87 - VIRUS - "ZeroHunt" - VIRAL CODE (NOT A VECTOR!)
Note:	the ZeroHunt virus copies its resident code down to 0000h:021Ch and
	  following
SeeAlso: INT 8B"VIRUS"
--------r-88---------------------------------
INT 88 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 87"BASIC",INT 89"BASIC"
--------r-88--00-----------------------------
INT 88 - APL*PLUS/PC - CREATE OBJECT OF ARBITRARY RANK OR SHAPE
	AL = 00h
	BX = STPTR of the variable to be assigned
	ES:SI -> model of type, rank, and shape (see #2111)
Return: ES:DI -> first data byte of object
	DX:CX = number of elements in the object
SeeAlso: INT C8"APL"

Format of APL*PLUS/PC shape model:
Offset	Size	Description	(Table 2111)
 00h	BYTE	type
		01h character (2-byte dimension sizes)
		02h integer (2-byte dimension sizes)
		08h floating point (2-byte dimension sizes)
		11h character (4-byte dimension sizes)
		12h integer (4-byte dimension sizes)
		18h floating point (4-byte dimension sizes)
 01h	BYTE	rank
 02h	(D)WORD first dimension of shape
 N	(D)WORD second dimension of shape
	...
--------r-88--01-----------------------------
INT 88 - APL*PLUS/PC - CREATE CHARACTER SCALAR/VECTOR/MATRIX <64K IN SIZE
	AL = 01h
	AH = rank
	BX = STPTR of the variable to be assigned
	CX = first dimension (if any)
	DX = second dimension (if any)
Return: ES:DI -> object
	CX = number of elements in the object
Note:	each dimension must be 32767 or smaller
SeeAlso: AL=02h,AL=08h,INT C8"APL"
--------r-88--02-----------------------------
INT 88 - APL*PLUS/PC - CREATE INTEGER SCALAR/VECTOR/MATRIX <64K IN SIZE
	AL = 02h
	AH = rank
	BX = STPTR of the variable to be assigned
	CX = first dimension (if any)
	DX = second dimension (if any)
Return: ES:DI -> object
	CX = number of elements in the object
Note:	each dimension must be 32767 or smaller
SeeAlso: AL=01h,AL=08h,INT C8"APL"
--------r-88--08-----------------------------
INT 88 - APL*PLUS/PC - CREATE FLOATING POINT SCALAR/VECTOR/MATRIX <64K IN SIZE
	AL = 08h
	AH = rank
	BX = STPTR of the variable to be assigned
	CX = first dimension (if any)
	DX = second dimension (if any)
Return: ES:DI -> object
	CX = number of elements in the object
Note:	each dimension must be 32767 or smaller
SeeAlso: AL=01h,AL=02h,INT C8"APL"
--------r-88--F5-----------------------------
INT 88 - APL*PLUS/PC - FORCE OBJECT INTO REAL WORKSPACE FROM VIRTUAL
	AL = F5h
	BX = STPTR of object
SeeAlso: INT C8"APL"
--------r-88--F6-----------------------------
INT 88 - APL*PLUS/PC - MAKE NAME IMMUNE FROM OUTSWAPPING
	AL = F6h
	BX = STPTR of object
SeeAlso: AL=F7h,AL=F8h,INT C8"APL"
--------r-88--F7-----------------------------
INT 88 - APL*PLUS/PC - MAKE NAME ELIGIBLE FOR OUTSWAPPING
	AL = F7h
	BX = STPTR of object
SeeAlso: AL=F6h,AL=F8h,INT C8"APL"
--------r-88--F8-----------------------------
INT 88 - APL*PLUS/PC - REPORT WHETHER NAME IS ELIGIBLE FOR OUTSWAPPING
	AL = F8h
	BX = STPTR of object
Return: BX = name's outswapping status
	    0000h eligible
	    0001h not eligible
SeeAlso: AL=F6h,AL=F7h,INT C8"APL"
--------r-88--F9-----------------------------
INT 88 - APL*PLUS/PC - DETERMINE NAME STATUS
	AL = F9h
	ES:SI -> name
	CX = length of name
Return: CF set if name ill-formed or already in use
	    BX = STPTR if already in symbol table
	CF clear if name is available for use
	    BX = 0000h
Note:	does not force the name into the workspace
SeeAlso: AL=FEh,AL=FFh,INT C8"APL"
--------r-88--FC-----------------------------
INT 88 - APL*PLUS/PC - DETERMINE IF MEMORY AVAIL WITHOUT GARBAGE COLLECTION
	AL = FCh
	BX = amount of memory needed (paragraphs)
Return: CF clear if memory available
	CF set if a workspace compaction is required
SeeAlso: AL=FDh,INT C8"APL"
--------r-88--FD-----------------------------
INT 88 - APL*PLUS/PC - PERFORM GARBAGE COLLECTION AND RETURN AVAILABLE MEMORY
	AL = FDh
Return: BX = number of paragraphs available in workspace
SeeAlso: AL=FCh,INT C8"APL"
--------r-88--FE-----------------------------
INT 88 - APL*PLUS/PC - CREATE NAME
	AL = FEh
	ES:SI -> name
	CX = length of name
Return: BX = STPTR of name
	DX = interpreter's data segment
SeeAlso: AL=F9h,AL=FFh,INT C8"APL"
--------r-88--FF-----------------------------
INT 88 - APL*PLUS/PC - DETERMINE NAME STATUS
	AL = FFh
	ES:SI -> name
	CX = length of name
Return: CF set if name ill-formed or already in use
	    BX = STPTR if already in symbol table
	CF clear if name is available for use
	    BX = 0000h
Note:	forces the name into the workspace and makes it immune from outswapping
SeeAlso: AL=F9h,AL=FEh,INT C8"APL"
--------r-89---------------------------------
INT 89 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 88"BASIC",INT 8A"BASIC"
--------r-8A---------------------------------
INT 8A - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 89"BASIC",INT 8B"BASIC"
--------r-8A---------------------------------
INT 8A - APL*PLUS/PC - PRINT SCREEN
Note:	same as INT 05
SeeAlso: INT 05,INT 8C"APL",INT CA"APL"
--------r-8B---------------------------------
INT 8B - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 8A"BASIC",INT 8C"BASIC"
--------r-8B---------------------------------
INT 8B - APL*PLUS/PC - BEEP
Note:	same as printing a ^G via INT 21/AH=02h
SeeAlso: INT 21/AH=02h,INT CB"APL"
--------v-8B---------------------------------
INT 8B - VIRUS - "ZeroHunt" - INSTALLATION CHECK (NOT A VECTOR!)
Note:	if the ZeroHunt virus is resident, this vector will contain either
	  EE83h:019Bh (ZH-411) or EE83h:019Fh (ZH-415)
SeeAlso: INT 70"VIRUS",INT 87"VIRUS",INT 9C"VIRUS"
--------r-8C---------------------------------
INT 8C - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-8C---------------------------------
INT 8C - APL*PLUS/PC - CLEAR SCREEN MEMORY
	AX = flag
	    0000h do not save display attributes
	    0001h save attributes
SeeAlso: INT CC"APL"
--------r-8D---------------------------------
INT 8D - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-8E---------------------------------
INT 8E - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-8F---------------------------------
INT 8F - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-90---------------------------------
INT 90 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-90---------------------------------
INT 90 - APL*PLUS/PC - USED BY PORT 10 PRINTER DRIVER
--------r-91---------------------------------
INT 91 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------N-91---------------------------------
INT 91 - IBM TOKEN RING ADAPTER - ???
SeeAlso: INT 81"TOKEN RING",INT 82"TOKEN RING",INT 93"TOKEN RING"
--------r-92---------------------------------
INT 92 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------N-92---------------------------------
INT 92 - Sangoma X.25 INTERFACE PROGRAM
	BX:DX -> control block
SeeAlso: INT 68"Sangoma"
--------e-92E1-------------------------------
INT 92 - Da Vinci eMail Dispatcher INTERFACE
	AH = E1h
	AL = function
	BX = stack count (number of words to push)
	CX:DX -> stack data (in word-reversed order ready to push)
Return: AX = status (see #2112)
Note:	preserves BP, DS, SI, DI; other registers may be destroyed

(Table 2112)
Values for Da Vinci eMail function status:
 0001h	success
 FF97h	"ERS_NOT_AVAILABLE"
 FF99h	"ERS_TOO_MANY_NAMES"
 FF9Ah	"ERS_BAD_NAME_PASSWORD"
 FFE3h	"ERS_NAME_NOT_FOUND"
 FFF8h	"ERS_USE_STRING" (call NetGetError to get error string)
 FFFFh	"ERS_NO_SUCH_FILE"
--------e-92E100-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetInitStart"
	AX = E100h
	BX = size of parameter block in words (000Ah)
	CX:DX -> parameter block (see #2113)
Return: AX = 0001h success
Desc:	this function is used to initialize the dispatcher
SeeAlso: AX=E101h,AX=E103h

Format of Da Vinci eMail "NetInitStart" parameter block:
Offset	Size	Description	(Table 2113)
 00h	WORD	segment of ???
 02h	WORD	offset of ???
 04h	WORD	high part of long ???
 06h	WORD	low part of long ???
 08h	WORD	high part of long ???
 0Ah	WORD	low part of long ???
 0Ch	WORD	high part of long ???
 0Eh	WORD	low part of long ???
 10h	WORD	high part of long ???
 12h	WORD	low part of long ???
--------e-92E101BX0000-----------------------
INT 92 - Da Vinci eMail Dispatcher - "NetInitCheck"
	AX = E101h
	BX = 0000h
	CX:DX ignored
Return: AX = 0001h success
SeeAlso: AX=E100h,AX=E180h
--------e-92E102BX0000-----------------------
INT 92 - Da Vinci eMail Dispatcher - "NetCheckDriver"
	AX = E102h
	BX = 0000h
	CX:DX ignored
Return: AX = 0001h success
Desc:	this function is used to determine if the dispatcher is loaded
SeeAlso: AX=E10Bh,AX=E180h
--------e-92E103BX0000-----------------------
INT 92 - Da Vinci eMail Dispatcher - "NetTerminate"
	AX = E103h
	BX = 0000h
	CX:DX ignored
Return: AX = status (see #2112)
SeeAlso: AX=E100h
--------e-92E104-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetWhereIs"
	AX = E104h
	BX = size of parameter block in words (0006h)
	CX:DX -> parameter block (see #2114)
Return: AX = status (see #2112)
Desc:	this function is used to verify node address for usernames
SeeAlso: AX=E180h

Format of Da Vinci eMail "NetWhereIs" parameter block:
Offset	Size	Description	(Table 2114)
 00h	WORD	segment of node address buffer
 02h	WORD	offset of node address buffer
 04h	WORD	segment of uppercase username
 06h	WORD	offset of uppercase username
 08h	WORD	segment of "DVSEMAIL"
 0Ah	WORD	offset of "DVSEMAIL"
--------e-92E105-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetOpen"
	AX = E105h
	BX = size of parameter block in words (0007h)
	CX:DX -> parameter block (see #2115)
Return: AX = 0000h Error
	AX = handle
Desc:	this function is used to open a submission channel
SeeAlso: AX=E10Ah,AX=E106h,AX=E108h

Format of Da Vinci eMail "NetOpen" parameter block:
Offset	Size	Description	(Table 2115)
 00h	WORD	operation (1 = read, 2 = write)
 02h	WORD	segment of uppercase To: username
 04h	WORD	offset of uppercase To: username
 06h	WORD	segment of "DVSEMAIL"
 08h	WORD	offset of "DVSEMAIL"
 0Ah	WORD	segment of node address
 0Ch	WORD	offset of node address
--------e-92E106BX0004-----------------------
INT 92 - Da Vinci eMail Dispatcher - "NetRead"
	AX = E106h
	BX = 0004h
	CX:DX -> parameter block
Return: AX = 0001h
SeeAlso: AX=E108h
--------e-92E107BX0002-----------------------
INT 92 - Da Vinci eMail Dispatcher - "NetGetError"
	AX = E107h
	BX = 0002h
	CX:DX -> parameter block
Return: AX = 0001h
SeeAlso: AX=E109h,AX=E180h
--------e-92E108-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetWrite"
	AX = E108h
	BX = size of parameter block in words (0004h)
	CX:DX -> parameter block (see #2116)
Return: AX = amount written
Desc:	This function is used to write transactions to the dispatcher.
	  The command block is written first and then another call is used
	  to write the associated data.
SeeAlso: AX=E106h

Format of Da Vinci eMail "NetWrite" parameter block:
Offset	Size	Description	(Table 2116)
 00h	WORD	buffer count (see #2118)
 02h	WORD	segment of command buffer (see #2117)
 04h	WORD	offset of command buffer
 06h	WORD	handle from NetOpen

Format of Da Vinci eMail command buffer:
Offset	Size	Description	(Table 2117)
 00h	BYTE	command
		21h '!' Protocol commands for remote control
		41h 'A' Authorization protocol element
		42h 'B' Return(back) routing information
		    Associated data is the From: username
		43h 'C' Carbon Copy list
		    Associated data is a comma delimitted list of usernames
		44h 'D' Distribution list
		    Associated data is a comma delimitted list of usernames
		45h 'E' Mail end marker
		    No associated data
		48h 'H' Mail message header
		    Associated data is a message header buffer
		4Dh 'M' Mail message
		    Associated data is the body of the message
		4Fh 'O' Object
		50h 'P' Paperclip attachment
		52h 'R' Routing information
		    Associated data is the To: username
		53h 'S' Subject
		    Associated data is the subject of the message
		54h 'T' Trail of Reply/Forwards
 01h	BYTE	subcommand
 02h	DWORD	length of associated data

Format of Da Vinci eMail message header buffer:
Offset	Size	Description	(Table 2118)
 00h 30 BYTEs	subject line
 1Eh 24 BYTEs	To
 36h 24 BYTEs	From
 4Eh	DWORD	Time
		BYTE	00h
		BYTE	hour
		BYTE	minute
		BYTE	second
 52h	DWORD	Date
		BYTE	00h
		BYTE	year
		BYTE	month
		BYTE	day
 56h	DWORD	serial number (00000000h)
 5Ah	WORD	mail types (see #2119)
 5Ch	WORD	special types (0)

Bitfields for Da Vinci eMail mail types:
Bit(s)	Description	(Table 2119)
 7	blind carbon copy
 6	carbon copy
 5	priority
 4	confidential
 3	certified
 2	bulk
 1-0	class (first, second, third, bulk)
--------e-92E109-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetErrorFix" (UNUSED)
	AX = E109h
	BX = size of parameter block in words (0001h)
	CX:DX -> parameter block (see #2120)
Return: AX = FF97h (ERS_NOT_AVAILABLE)
SeeAlso: AX=E107h,AX=E180h

Format of Da Vinci eMail "NetErrorFix" parameter block:
Offset	Size	Description	(Table 2120)
 00h	WORD	???
--------e-92E10A-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetClose"
	AX = E10Ah
	BX = size of parameter block in words (0001h)
	CX:DX -> parameter block (see #2121)
Return: AX = 0001h
Desc:	this function is used to close a dispatcher handle
SeeAlso: AX=E105h

Format of Da Vinci eMail "NetClose" parameter block:
Offset	Size	Description	(Table 2121)
 00h	WORD	handle from NetOpen
--------e-92E10B-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetCheckQueue"
	AX = E10Bh
	BX = size of parameter block in words (0004h)
	CX:DX -> parameter block (see #2122)
Return: AX = 0001h
SeeAlso: AX=E102h,AX=E10Ch

Format of Da Vinci eMail "NetCheckQueue" parameter block:
Offset	Size	Description	(Table 2122)
 00h	WORD	segment of 24-byte username buffer
 02h	WORD	offset of 24-byte username buffer
 04h	WORD	segment of 24-byte protocol buffer
 06h	WORD	offset of 24-byte protocol buffer
--------e-92E10C-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetReadQueue"
	AX = E10Ch
	BX = size of parameter block in words (0002h)
	CX:DX -> parameter block (see #2123)
Return: AX = 0001h
SeeAlso: AX=E10Bh

Format of Da Vinci eMail "NetReadQueue" parameter block:
Offset	Size	Description	(Table 2123)
 00h	WORD	Segment of 128 byte node address buffer
 02h	WORD	Offset of 128 byte node address buffer
--------e-92E10D-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetSubmitName"
	AX = E10Dh
	BX = size of parameter block in words (0006h)
	CX:DX -> parameter block (see #2124)
Return: AX = status (see #2112)
Desc:	this function is used to verify username/password
SeeAlso: AX=E10Eh

Format of Da Vinci eMail "NetSubmitName" parameter block:
Offset	Size	Description	(Table 2124)
 00h	WORD	segment of uppercase password string
 02h	WORD	offset of uppercase password string
 04h	WORD	segment of uppercase username string
 06h	WORD	offset of uppercase username string
 08h	WORD	segment of "DVSEMAIL"
 0Ah	WORD	offset of "DVSEMAIL"
--------e-92E10E-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetRemoveName"
	AX = E10Eh
	BX = size of parameter block in words (0004h)
	CX:DX -> parameter block (see #2125)
Return: AX = 0001h
Desc:	this function is used to remove a username
SeeAlso: AX=E10Dh

Format of Da Vinci eMail "NetRemoveName" parameter block:
Offset	Type	Description	(Table 2125)
 00h	WORD	segment of uppercase username
 02h	WORD	offset of uppercase username
 04h	WORD	segment of "DVSEMAIL"
 06h	WORD	offset of "DVSEMAIL"
--------e-92E10FBX0000-----------------------
INT 92 - Da Vinci eMail Dispatcher - IS ANYONE THERE? QUERY
	AX = E10Fh
	BX = 0000h
	CX:DX ignored
Return: AX = 0001h
SeeAlso: AX=E180h
--------e-92E110-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetGetAltRoute"
	AX = E110h
	BX = size of parameter block in words (0006h)
	CX:DX -> parameter block (see #2126)
Return: AX = 0001h
SeeAlso: AX=E111h,AX=E113h

Format of Da Vinci eMail "NetGetAltRoute" parameter block:
Offset	Size	Description	(Table 2126)
 00h  6 WORDs	???
--------e-92E111-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetDeleteAltRoutes"
	AX = E111h
	BX = size of parameter block in words (0004h)
	CX:DX -> parameter block (see #2127)
Return: AX = 0001h
SeeAlso: AX=E110h,AX=E113h

Format of Da Vinci eMail "NetDeleteAltRoutes" parameter block:
Offset	Size	Description	(Table 2127)
 00h  4 WORDs	???
--------e-92E112-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetChangePassword"
	AX = E112h
	BX = size of parameter block in words (0008h)
	CX:DX -> parameter block (see #2128)
Return: AX = 0001h
SeeAlso: AX=E180h

Format of Da Vinci eMail "NetChangePassword" parameter block:
Offset	Size	Description	(Table 2128)
 00h  8 WORDs	???
--------e-92E113-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetSetAltRoute"
	AX = E113h
	BX = size of parameter block in words (0008h)
	CX:DX -> parameter block (see #2129)
Return: AX = 0001h
SeeAlso: AX=E110h,AX=E111h

Format of Da Vinci eMail "NetSetAltRoute" parameter block:
Offset	Size	Description	(Table 2129)
 00h  8 WORDs	???
--------e-92E175-----------------------------
INT 92 - Da Vinci eMail Dispatcher - BECOME MICRO TSR
	AX = E175h
Return: AX = 0012h
	BX = PSP
SeeAlso: AX=E180h
--------e-92E180-----------------------------
INT 92 - Da Vinci eMail Dispatcher - INSTALLATION CHECK
	AX = E180h
Return: AX = 0012h if installed
	ES:DX -> '$'-terminated driver information string
SeeAlso: AX=E102h,AX=E105h,AX=E10Fh,AX=E175h
--------r-93---------------------------------
INT 93 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------N-93---------------------------------
INT 93 - IBM TOKEN RING ADAPTER - ???
SeeAlso: INT 81"TOKEN RING",INT 91"TOKEN RING"
--------r-94---------------------------------
INT 94 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------s-94----SI0000-----------------------
INT 94 u - PCM driver - INITIALIZE SOUND
	SI = 0000h
	ES:BX -> parameters
Return: ???
Program: PCM.COM is a sound driver for Media Vision's Pro Audio Spectrum
	  sound boards
Note:	the installation check consists of testing for the signature string
	  "PCMDRIVER" immediately preceding the interrupt handler; the word
	  preceding the signature gives the PCM driver's version
SeeAlso: SI=0001h,SI=0002h,SI=0003h,SI=0004h,SI=0005h,SI=000Ah
Index:	installation check;PCM driver|PCM.COM;installation check
Index:	PCM driver;installation check
--------s-94----SI0001-----------------------
INT 94 u - PCM driver - INITIALIZE PCM
	SI = 0001h
	ES:BX -> parameters
Return: ???
SeeAlso: SI=0000h,SI=0002h,SI=0003h,SI=000Ah
--------s-94----SI0002-----------------------
INT 94 u - PCM driver - INITIALIZE PCM INFO
	SI = 0002h
	ES:BX -> parameters (see #2130)
Return: ???
SeeAlso: SI=0000h,SI=0001h,SI=0003h,SI=000Ah

Format of PCM driver parameters:
Offset	Size	Description	(Table 2130)
 00h	DWORD	rate
 04h	WORD	channel number
 06h	WORD	"comp"
 08h	WORD	"dsize"
--------s-94----SI0003-----------------------
INT 94 u - PCM driver - INITIALIZE DMA BUFFER
	SI = 0003h
	ES:BX -> parameters (see #2131)
Return: ???
SeeAlso: SI=0000h,SI=000Ah,SI=000Bh

Format of PCM driver parameters:
Offset	Size	Description	(Table 2131)
 00h	DWORD	-> DMA buffer
 04h	WORD	size of DMA buffer
 06h	WORD	number of divisions
--------s-94----SI0004-----------------------
INT 94 u - PCM driver - INITIALIZE USER FUNCTION
	SI = 0004h
	ES:BX -> parameters (see #2132)
Return: ???
SeeAlso: SI=0000h,SI=0001h

Format of PCM driver parameters:
Offset	Size	Description	(Table 2132)
 00h	DWORD	-> user function
--------s-94----SI0005-----------------------
INT 94 u - PCM driver - BEGIN AUDIO PLAY
	SI = 0005h
Return: ???
SeeAlso: SI=0000h,SI=0006h,SI=0007h,SI=0009h
--------s-94----SI0006-----------------------
INT 94 u - PCM driver - BEGIN AUDIO RECORD
	SI = 0006h
Return: ???
SeeAlso: SI=0005h,SI=0007h,SI=0009h
--------s-94----SI0007-----------------------
INT 94 u - PCM driver - PAUSE AUDIO PLAY/RECORD
	SI = 0007h
Return: ???
SeeAlso: SI=0005h,SI=0006h,SI=0008h
--------s-94----SI0008-----------------------
INT 94 u - PCM driver - RESUME AUDIO PLAY/RECORD
	SI = 0008h
Return: ???
SeeAlso: SI=0007h
--------s-94----SI0009-----------------------
INT 94 u - PCM driver - STOP AUDIO PLAY/RECORD
	SI = 0009h
Return: ???
SeeAlso: SI=0005h,SI=0006h,SI=0007h
--------s-94----SI000A-----------------------
INT 94 u - PCM driver - UNHOOK INTERRUPTS AND TURN OFF DMA
	SI = 000Ah
Return: ???
SeeAlso: SI=0000h,SI=0001h,SI=0003h
Index:	uninstall;PCM driver
--------s-94----SI000B-----------------------
INT 94 u - PCM driver - FIND VALID DMA BUFFER IN HUGE MEMORY BLOCK
	SI = 000Bh
	ES:BX -> parameters (see #2133)
Return: ???
SeeAlso: SI=0003h

Format of PCM driver parameters:
Offset	Size	Description	(Table 2133)
 00h	DWORD	-> memory block to contain DMA buffer
 04h	WORD	desired size of DMA buffer
--------s-94----SI000D-----------------------
INT 94 u - Media Vision PCM.COM - GET STATUS
	SI = 000Dh
Return: AX = status (0000h = waiting) (see #2134)

Bitfields for PCM.COM status:
Bit(s)	Description	(Table 2134)
 0	playing
 1	recording
 2	SBplaying
 3	SBrecording
 14	SBpaused
 15	paused
--------s-94----SI8000-----------------------
INT 94 u - Media Vision PCM.COM - GET INTERNAL DMA BUFFER ADDRESS
	SI = 8000h
Return: DX:AX -> DMA buffer
Program: PCM.COM is a superset of the standard PCM driver which provides
	  additional functions for fine control of the driver
Note:	the installation check for the Media Vision PCM.COM "shark" functions
	  consists of testing for the signature "PCM-SHARK" at offset 107h in
	  the INT 94 handler's segment
SeeAlso: SI=8001h,SI=8004h
Index:	installation check;Media Vision PCM.COM|PCM.COM;installation check
Index:	Media Vision PCM.COM;"shark" functions
--------s-94----SI8001-----------------------
INT 94 u - Media Vision PCM.COM - GET INTERNAL DMA BUFFER SIZE AND DIVISIONS
	SI = 8001h
Return: AX = DMA buffer size
	DX = divisions
SeeAlso: SI=8000h
--------s-94----SI8002-----------------------
INT 94 u - Media Vision PCM.COM - CHECK BOARD ADDRESS
	SI = 8002h
Return: AX = status
	    0000h if board not at specified I/O address
	    other if board found
Note:	the I/O address is specified by ORing the base I/O port shifted left
	  four bits into SI before calling INT 94
SeeAlso: SI=8000h
--------s-94----SI8004-----------------------
INT 94 u - Media Vision PCM.COM - GET INTERNAL NOTE BUFFER
	SI = 8004h
Return: AX = offset of note buffer (segment = segment of internal DMA buffer)
	DX = size of buffer in note structures
SeeAlso: SI=8000h
--------s-94----SI8005-----------------------
INT 94 u - Media Vision PCM.COM - SINGLE-STEP QUEUE
	SI = 8005h
Return: ???
--------s-94----SI8011-----------------------
INT 94 u - Media Vision PCM.COM - INITIALIZE
	SI = 8011h
	ES:BX -> "iobf91" structure
Return: ???
--------s-94----SI8012-----------------------
INT 94 u - Media Vision PCM.COM - LOAD SOUND FOR LATER PLAY THROUGH KEYBOARD
	SI = 8012h
	ES:BX -> "i94f92buf" structure
Return: ???
SeeAlso: SI=8013h,SI=8014h
--------s-94----SI8013-----------------------
INT 94 u - Media Vision PCM.COM - GET INTERNAL SOUND USAGE
	SI = 8013h
Return: AX = number of sounds used
	DX = maximum handles
--------s-94----SI8014-----------------------
INT 94 u - Media Vision PCM.COM - GET DATA FOR SPECIFIED SOUND
	SI = 8014h
	ES:BX -> "i94f92buf" structure to be filled in
		sound number field set to desired sound
Return: AX = status
	    0000h successful
	    FFFFh sound number out of range
SeeAlso: SI=8012h,SI=8013h
--------s-94----SI8015-----------------------
INT 94 u - Media Vision PCM.COM - GET/SET INTERNAL DMA BUFFER
	SI = 8015h
	ES:BX -> DMA info structure (see #2135)
Return: ???

Format of PCM.COM DMA info structure:
Offset	Size	Description	(Table 2135)
 00h	DWORD	-> DMA buffer (offset FFFFh = return current buffer info)
 04h	WORD	DMA buffer size
 06h	WORD	divisions
--------s-94----SI8016-----------------------
INT 94 u - Media Vision PCM.COM - SIMULATE DOUBLE-SHIFT HOTKEY
	SI = 8016h
	AX = hotkey number (01h-08h)
Return: ???
SeeAlso: AL=02h/SI=8017h
--------s-94--01SI8017-----------------------
INT 94 u - Media Vision PCM.COM - CTRL-G INTERCEPT
	AL = 01h
	SI = 8017h
	AH = new state (00h off, 01h on)
Return: ???
SeeAlso: AL=02h/SI=8017h
--------s-94--02SI8017-----------------------
INT 94 u - Media Vision PCM.COM - DOUBLE-SHIFT-HOTKEY SOUND FEATURE
	AL = 02h
	SI = 8017h
	AH = new state (00h off, 01h on)
Return: ???
--------s-94--04SI8017-----------------------
INT 94 u - Media Vision PCM.COM - RANDOM SOUND FEATURE
	AL = 04h
	SI = 8017h
	AH = new state
	    00h off
	    01h on
		CX = minimum delay
		DX = maximum delay
Return: ???
--------s-94--08SI8017-----------------------
INT 94 u - Media Vision PCM.COM - NO ACTIVITY FEATURE
	AL = 08h
	SI = 8017h
	AH = new state
	    00h off
	    01h on
		DX:CX = delay
Return: ???
SeeAlso: AL=10h/SI=8017h
--------s-94--10SI8017-----------------------
INT 94 u - Media Vision PCM.COM - TIMER CONTROL
	AL = 10h
	SI = 8017h
	AH bit 7: set timer
	AH bit 6: timer active (timer turned off if clear)
	AH bits 5-0: timer number
	DX:CX = delay if AH bit 7 set (one-shot if DX bit 15 set)
Return: ???
SeeAlso: AL=08h/SI=8017h
--------s-94----SI8018-----------------------
INT 94 u - Media Vision PCM.COM - GET INFO
	SI = 8018h
	AL = what to get
	    00h "F92state"
	    01h "F92bkgd"
	    02h "I10timer"
	    03h "I08state"
Return: DX:AX -> desired information
--------r-95---------------------------------
INT 95 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-95---------------------------------
INT 95 - APL*PLUS/PC - DETERMINE R= SPACE
Note:	use only when the R= option is invoked on entering APL
--------r-96---------------------------------
INT 96 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-97---------------------------------
INT 97 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-98---------------------------------
INT 98 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-99---------------------------------
INT 99 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-9A---------------------------------
INT 9A - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT 99,INT 9B
--------r-9B---------------------------------
INT 9B - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT 9A,INT 9C"BASIC"
--------r-9C---------------------------------
INT 9C - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT 9B,INT 9D"BASIC"
--------v-9C---------------------------------
INT 9C - VIRUS - "INT13" - ORIGINAL INT 13h VECTOR
SeeAlso: INT 8B"VIRUS",INT 9D"VIRUS",INT 9E"VIRUS",INT 9F"VIRUS"
--------r-9D---------------------------------
INT 9D - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT 9C"BASIC",INT 9E"BASIC"
--------v-9D---------------------------------
INT 9D - VIRUS - "INT13" - ROM INT 13h ENTRY POINT
Note:	this vector is used by the virus to store the result of a call to
	  INT 2F/AH=13h
SeeAlso: INT 2F/AH=13h,INT 9C"VIRUS",INT 9E"VIRUS",INT 9F"VIRUS"
--------r-9E---------------------------------
INT 9E - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT 9D"BASIC",INT 9F"BASIC"
--------v-9E---------------------------------
INT 9E - VIRUS - "INT13" - ORIGINAL INT 21h VECTOR
SeeAlso: INT 70"VIRUS",INT 9C"VIRUS",INT 9D"VIRUS",INT E0"VIRUS"
--------r-9F---------------------------------
INT 9F - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT 9D"BASIC",INT A0"BASIC"
--------v-9F---------------------------------
INT 9F - VIRUS - "INT13" - STORAGE FOR USER INT 13h VECTOR
Note:	while it is infecting a file, the INT13 virus grabs INT 13 and uses
	  this interrupt to store the existing INT 13 vector for later
	  restoration
SeeAlso: INT 9C"VIRUS",INT 9D"VIRUS"
--------r-A0---------------------------------
INT A0 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT 9F"BASIC",INT A1"BASIC"
--------r-A0---------------------------------
INT A0 - APL*PLUS/PC - USED BY APL/GSS*CGI GRAPHICS INTERFACE
SeeAlso: INT 59
--------r-A1---------------------------------
INT A1 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT A0"BASIC",INT A2"BASIC"
--------r-A2---------------------------------
INT A2 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT A1"BASIC",INT A3"BASIC"
--------r-A3---------------------------------
INT A3 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT A2"BASIC",INT A4"BASIC"
--------r-A4---------------------------------
INT A4 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT A3"BASIC",INT A5"BASIC"
--------U-A4---------------------------------
INT A4 U - Right Hand Man - API
	AH = function number (v3.3 supports functions 00h-52h)
Return: CF set on error
	CF clear if successful
Program: Right Hand Man is a TSR desk-top utility originally by Red E Products
	  which has evolved into Futurus Team
Note:	this interrupt is only hooked while popped up
SeeAlso: INT 2F/AX=A4E0h
--------r-A5---------------------------------
INT A5 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT A4"BASIC",INT A6"BASIC"
--------r-A6---------------------------------
INT A6 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT A5"BASIC",INT A7"BASIC"
--------r-A7---------------------------------
INT A7 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-A8---------------------------------
INT A8 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-A9---------------------------------
INT A9 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-AA---------------------------------
INT AA - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-AB---------------------------------
INT AB - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-AC---------------------------------
INT AC - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-AD---------------------------------
INT AD - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-AE---------------------------------
INT AE - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-AF---------------------------------
INT AF - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-B0---------------------------------
INT B0 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-B1---------------------------------
INT B1 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-B2---------------------------------
INT B2 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-B3---------------------------------
INT B3 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------U-B370-------------------------------
INT B3 - ZIPKEY - GET VERSION
	AH = 70h
Return: AH = major version
	AL = minor version
	CL = number of states and territories in current database
	DH = year of current database - 1900
	DL = month of current database's file date
Program: ZIPKEY is a resident ZIPCODE database by Eric Isaacson
Note:	if installed, the string "ZIPKEY" is present at offset 75h in the
	  interrupt handler's segment, and the byte at 7Bh contains the API
	  version number (00h for v1.x, 01h for v2.0)
--------U-B371-------------------------------
INT B3 - ZIPKEY - CONVERT TWO-LETTER ABBREVIATION TO STATE CODE
	AH = 71h
	BX = abbreviation, in either case (first letter in BL)
Return: CF set on error
	    AL = FFh
	CF clear if successful
	    AL = ZIPKEY state code
SeeAlso: AH=72h
--------U-B372-------------------------------
INT B3 - ZIPKEY - CONVERT STATE CODE TO TWO-LETTER ABBREVIATION
	AH = 72h
	BL = ZIPKEY state code
Return: CF set on error
	    AX destroyed
	CF clear if successful
	    AX = abbreviation, in upper case
SeeAlso: AH=71h,AH=73h
--------U-B373-------------------------------
INT B3 - ZIPKEY - CONVERT STATE CODE TO STATE NAME
	AH = 73h
	BL = ZIPKEY state code
	ES:DI -> buffer for name
Return: CF set on error
	    AX destroyed
	CF clear if successful
	    ES:DI points one byte beyond end of name
SeeAlso: AH=72h
--------U-B374-------------------------------
INT B3 - ZIPKEY - CONVERT ZIPCODE TO ASCII DIGITS
	AH = 74h
	DX = zipcode region (0-999)
	CH = last two digits of zipcode (0-99)
	ES:DI -> buffer
Return: CF set on error
	    AX destroyed
	CF clear if successful
	    ES:DI points one byte beyond end of digit string
--------U-B375-------------------------------
INT B3 - ZIPKEY - LOOK UP STATE CODE FOR ZIPCODE
	AH = 75h
	DX = zipcode region (0-999)
	CH = last two digits of zipcode (0-99)
Return: CF set on error (zipcode not found)
	    AL = suggested state code, FFh if none
	CF clear if successful
	    AL = ZIPKEY state code
	    BX = area code (v2.0+)
SeeAlso: AH=76h,AH=79h
--------U-B376-------------------------------
INT B3 - ZIPKEY - LOOK UP CITY AND STATE FOR ZIPCODE
	AH = 76h
	DX = zipcode region (0-999)
	CH = last two digits of zipcode (0-99)
	ES:DI -> buffer for name
Return: CF set on error
	    AL = suggested state code, FFh if none
	    ES:DI buffer filled with suggested city name
	CF clear if successful
	    AL = ZIPKEY state code
	    BX = area code (v2.0+)
	    ES:DI points one byte beyond end of name
SeeAlso: AH=75h,AH=78h,AH=7Eh
--------U-B377-------------------------------
INT B3 - ZIPKEY - PLAY BACK EXIT KEY FOR ENTRY WITH GIVEN ZIPCODE
	AH = 77h
	DX = zipcode region (0-999)
	CH = last two digits of zipcode (0-99)
	BX = 16-bit BIOS keycode for a defined ZIPKEY alternate exit key
Return: CF set on error
	    AX destroyed
	CF clear if successful
	    zipcode specification as defined by the BX keystroke is placed in
	      keyboard buffer, as if the user had popped up ZIPKEY and exited
	      by pressing the key specified by BX
--------U-B378-------------------------------
INT B3 - ZIPKEY - LOOK UP ZIPCODES FOR A GIVEN STATE AND CITY
	AH = 78h
	BL = ZIPKEY state code
	DS:SI -> city name, terminated with 0Dh if complete name, 00h if prefix
Return: BH = number of matching entries (set to 51 if more than 50)
	DX = zipcode region of first match (0-999)
	CL = last two digits of first zipcode in the range (0-99)
	CH = last two digits of last zipcode in the range (0-99)
	AX destroyed
SeeAlso: AH=79h,AH=7Ah
--------U-B379-------------------------------
INT B3 - ZIPKEY - LOOK UP ZIPCODES FOR A GIVEN CITY
	AH = 79h
	BL = ZIPKEY state code of first state to search
	DS:SI -> city name, terminated with 0Dh if complete name, 00h if prefix
Return: AL = ZIPKEY state code of first matching state
	BH = number of matching entries (set to 51 if more than 50)
	DX = zipcode region of first match (0-999)
	CL = last two digits of first zipcode in first range (0-99)
	CH = last two digits of last zipcode in first range (0-99)
Note:	to find all matching cities, repeat search with BL set to one more than
	  the returned AL
SeeAlso: AH=78h,AH=7Ah
--------U-B37A-------------------------------
INT B3 - ZIPKEY - FETCH AN ENTRY FROM A PREVIOUS LOOKUP
	AH = 7Ah
	BL = case number (0 to one less than value returned in BH by lookup)
Return: AL = ZIPKEY state code
	DX = zipcode region (0-999)
	CL = last two digits of first zipcode in the range (0-99)
	CH = last two digits of last zipcode in the range (0-99)
SeeAlso: AH=78h,AH=79h
--------U-B37B-------------------------------
INT B3 - ZIPKEY - GET VALUES NEEDED TO SAVE ZIPKEY CONTEXT
	AH = 7Bh
Return: BL = maximum number of characters for a city name
	BH = ZIPKEY state code for last city-name search, or FFh if none
	CX:DX = internal code identifying last city search
	AX destroyed
SeeAlso: AH=7Ch
--------U-B37C-------------------------------
INT B3 - ZIPKEY - RESTORE ZIPKEY CONTEXT
	AH = 7Ch
	BL = maximum number of characters for a city name
	BH = ZIPKEY state code for last city-name search, or FFh if none
	CX:DX = internal code returned by AH=7Bh
Return: CF set on error
	CF clear if successful
	AX destroyed
SeeAlso: AH=7Bh
--------U-B37D-------------------------------
INT B3 - ZIPKEY - REQUEST POP UP
	AH = 7Dh
	BL = index number to simulate pressing a hotkey
	    FFh for immediate popup with no playback on return
Return: CF set on error
	    AL = error code
	        FDh already busy with another request
	        FEh illegal function
	CF clear if successful
	    AX destroyed
	    window popped up and was closed by the user
SeeAlso: AH=70h
--------U-B37E-------------------------------
INT B3 - ZIPKEY - GET NAME OF PRIMARY CITY FOR A ZIPCODE REGION
	AH = 7Eh
	DX = zipcode region (0-999)
	ES:DI -> buffer for name
Return: CF set on error
	    AL = FFh region does not exist
	CF clear if successful
	    AL = ZIPKEY state code
	    ES:DI points one byte beyond end of name
SeeAlso: AH=76h
--------U-B37F-------------------------------
INT B3 - ZIPKEY - ENABLE/DISABLE HOTKEYS
	AH = 7Fh
	BL = function
	    00h turn off hotkeys
	    01h turn on hotkeys
	    02h return hotkey status
	    03h toggle hotkey status
Return: AL = hotkey status
	    00h off
	    01h on
--------U-B380-------------------------------
INT B3 - ZIPKEY v2.0+ - DETERMINE STATE FOR AREA CODE
	AH = 80h
	BX = telephone area code (decimal)
Return: CF clear if successful
	    AL = ZIPKEY state code
	    DX = first ZIP region for state (03E8h if Canada)
	    CX = number of ZIP regions in state
	CF set on error
	    AL = FFh
	    DX = 03E9h
--------r-B4---------------------------------
INT B4 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-B4---------------------------------
INT B4 - StackMan - REQUEST NEW STACK
Return: SS:SP -> new stack
Program: StackMan is a freeware stack manager by Franz Veldman of ESaSS B.V.
	  which functions as a replacement for the DOS STACK= command as well
	  as permitting multiple TSRs to share a pool of stack space
Note:	the installation check consists of testing for the string "STACKXXX" at
	  offset 0Ah from the interrupt handler
SeeAlso: INT 2F/AX=C9FFh,INT B5"STACKMAN"
Index:	installation check;STACKMAN
--------r-B5---------------------------------
INT B5 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT B4"BASIC",INT B6"BASIC"
--------r-B5---------------------------------
INT B5 - StackMan - RESTORE ORIGINAL STACK
	SS:SP -> stack returned by INT B4
Return: SS:SP restored to value before INT B4
SeeAlso: INT 2F/AX=C9FFh,INT B4"StackMan"
--------m-B5---------------------------------
INT B5 U - Netroom NETSWAP4 - ???
	???
Return: ???
SeeAlso: INT 31/AH=57h
--------r-B6---------------------------------
INT B6 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT B5"BASIC",INT B7"BASIC"
--------y-B6---------------------------------
INT B6 - (NOT A VECTOR!) - USED BY TBFENCE
Program: TBFence is a security program by ESaSS B.V. which transparently
	  encrypts floppies and optionally allows only encrypted diskettes to
	  be accessed
Note:	the low word of this vector (0000h:02D8h) contains the segment of the
	  TBFence INT 13h code, which starts with the signature word E487h;
	  this forms the installation check
	the highest byte of this vector contains the start of a FAR JMP
	  instruction to ???
SeeAlso: INT B7"TBFENCE"
Index:	installation check;TBFence
--------r-B7---------------------------------
INT B7 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT B6"BASIC",INT B8"BASIC"
--------y-B7---------------------------------
INT B7 - TBFENCE - ???
SeeAlso: INT B6"TBFENCE"
--------r-B8---------------------------------
INT B8 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT B7"BASIC",INT B9"BASIC"
--------r-B9---------------------------------
INT B9 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-BA---------------------------------
INT BA - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-BB---------------------------------
INT BB - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-BC---------------------------------
INT BC - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-BD---------------------------------
INT BD - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-BE---------------------------------
INT BE - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT BD"BASIC",INT BF"BASIC"
--------Q-BE---------------------------------
INT BE - DESQview/X - ???
Note:	points at an IRET
SeeAlso: INT 15/AX=BFDEh/BX=0006h,INT 63"DESQview"
--------r-BF---------------------------------
INT BF - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT BE"BASIC",INT C0"BASIC"
--------r-C0---------------------------------
INT C0 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT BF"BASIC",INT C1"BASIC"
--------d-C0---------------------------------
INT C0 - AMI BIOS - DRIVE 0 DATA
Note:	this vector is used by some AMI BIOSes to store the first four bytes
	  of the hard disk parameter table
SeeAlso: INT 41,INT 60"Adaptec",INT C1"AMI",INT C2"AMI",INT C3"AMI",INT C4"AMI"
--------r-C1---------------------------------
INT C1 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT C0"BASIC",INT C2"BASIC"
--------d-C1---------------------------------
INT C1 - AMI BIOS - DRIVE 0 DATA
Note:	this vector is used by some AMI BIOSes to store the second four bytes
	  of the hard disk parameter table
SeeAlso: INT 41,INT 60"Adaptec",INT C0"AMI",INT C2"AMI",INT C3"AMI"
--------r-C2---------------------------------
INT C2 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT C1"BASIC",INT C3"BASIC"
--------d-C2---------------------------------
INT C2 - AMI BIOS - DRIVE 0 DATA
Note:	this vector is used by some AMI BIOSes to store the third four bytes
	  of the hard disk parameter table
SeeAlso: INT 41,INT 60"Adaptec",INT C0"AMI",INT C1"AMI",INT C3"AMI"
--------r-C3---------------------------------
INT C3 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT C2"BASIC",INT C4"BASIC"
--------d-C3---------------------------------
INT C3 - AMI BIOS - DRIVE 0 DATA
Note:	this vector is used by some AMI BIOSes to store the final four bytes
	  of the hard disk parameter table
SeeAlso: INT 41,INT 60"Adaptec",INT C0"AMI",INT C1"AMI",INT C2"AMI"
--------r-C4---------------------------------
INT C4 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT C3"BASIC",INT C5"BASIC"
--------d-C4---------------------------------
INT C4 - AMI BIOS - DRIVE 1 DATA
Note:	this vector is used by some AMI BIOSes to store the first four bytes
	  of the second hard disk's parameter table
SeeAlso: INT 46,INT 64"Adaptec",INT C0"AMI",INT C5"AMI",INT C6"AMI",INT C7"AMI"
--------r-C5---------------------------------
INT C5 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT C4"BASIC",INT C6"BASIC"
--------d-C5---------------------------------
INT C5 - AMI BIOS - DRIVE 1 DATA
Note:	this vector is used by some AMI BIOSes to store the second four bytes
	  of the second hard disk's parameter table
SeeAlso: INT 46,INT 64"Adaptec",INT C0"AMI",INT C4"AMI",INT C6"AMI",INT C7"AMI"
--------r-C6---------------------------------
INT C6 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT C5"BASIC",INT C7"BASIC"
--------r-C6---------------------------------
INT C6 - APL*PLUS/PC - IDENTICAL TO INT 86
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 86"APL"
--------d-C6---------------------------------
INT C6 - AMI BIOS - DRIVE 1 DATA
Note:	this vector is used by some AMI BIOSes to store the third four bytes
	  of the second hard disk's parameter table
SeeAlso: INT 46,INT 64"Adaptec",INT C0"AMI",INT C4"AMI",INT C5"AMI",INT C7"AMI"
--------r-C7---------------------------------
INT C7 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT C6"BASIC",INT C8"BASIC"
--------r-C7---------------------------------
INT C7 - APL*PLUS/PC - ???
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 87"APL"
--------d-C7---------------------------------
INT C7 - AMI BIOS - DRIVE 1 DATA
Note:	this vector is used by some AMI BIOSes to store the final four bytes
	  of the second hard disk's parameter table
SeeAlso: INT 46,INT 64"Adaptec",INT C0"AMI",INT C4"AMI",INT C5"AMI",INT C6"AMI"
--------r-C8---------------------------------
INT C8 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT C7"BASIC",INT C9"BASIC"
--------r-C8---------------------------------
INT C8 - APL*PLUS/PC - IDENTICAL TO INT 88
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 88"APL"
--------r-C9---------------------------------
INT C9 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT C8"BASIC",INT CA"BASIC"
--------r-C9---------------------------------
INT C9 - APL*PLUS/PC - ???
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 89"APL"
--------r-CA---------------------------------
INT CA - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT C9"BASIC",INT CB"BASIC"
--------r-CA---------------------------------
INT CA - APL*PLUS/PC - PRINT SCREEN
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 8A"APL"
--------r-CB---------------------------------
INT CB - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT CA"BASIC",INT CC"BASIC"
--------r-CB---------------------------------
INT CB - APL*PLUS/PC - BEEP
Notes:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
	same as printing a ^G via INT 21/AH=02h
SeeAlso: INT 8B"APL"
--------r-CC---------------------------------
INT CC - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT CB"BASIC",INT CD"BASIC"
--------r-CC---------------------------------
INT CC - APL*PLUS/PC - CLEAR SCREEN MEMORY
	AX = flag
	    0000h do not save display attributes
	    0001h save attributes
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 8C"APL"
--------r-CD---------------------------------
INT CD - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT CC"BASIC",INT CE"BASIC"
--------r-CD---------------------------------
INT CD - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-CE---------------------------------
INT CE - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT CD"BASIC",INT CF"BASIC"
--------r-CE---------------------------------
INT CE - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-CF---------------------------------
INT CF - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT CE"BASIC",INT D0"BASIC"
--------r-CF---------------------------------
INT CF - APL*PLUS/PC - DEFAULT LOW-RESOLUTION TIMER FOR QUAD MF FUNCTION
SeeAlso: INT E0"APL"
--------r-D0---------------------------------
INT D0 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT CF"BASIC",INT D1"BASIC"
--------r-D0---------------------------------
INT D0 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------U-D0---------------------------------
INT D0 - [not a vector!] - NJFRERAM SIGNATURE VECTOR
Program: NJFRERAM is a resident free-memory display utility by Mike "Nifty
	  James" Blaszczak
Note:	if NJFRERAM is installed, this vector points at the signature "NJ"
Index:	installation check;NJFRERAM
--------r-D1---------------------------------
INT D1 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT D0"BASIC",INT D2"BASIC"
--------r-D1---------------------------------
INT D1 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-D2---------------------------------
INT D2 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT D1"BASIC",INT D3"BASIC"
--------r-D2---------------------------------
INT D2 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-D3---------------------------------
INT D3 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT D2"BASIC",INT D4"BASIC"
--------r-D3---------------------------------
INT D3 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-D4---------------------------------
INT D4 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT D3"BASIC",INT D5"BASIC"
--------r-D4---------------------------------
INT D4 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------O-D400-------------------------------
INT D4 O - PC-MOS/386 v5.01 - OBSOLETE FUNCTIONS
	AH = 00h and 01h
Return: nothing
Desc:	PC-MOS/386 v5.01 reports that these functions are no longer supported
	  and enters an endless loop
Program: PC-MOS/386 is a multitasking/multiuser MS-DOS-compatible operating
	  system by The Software Link, Inc.
--------O-D402-------------------------------
INT D4 - PC-MOS/386 v3.0+ - GET SYSTEM CONTROL BLOCK POINTER
	AH = 02h
Return: AX = 0000h
	ES:BX -> System Control Block in V86 mode (see #2136)
	ES:EBX -> System Control Block in native mode (see #2136)
Note:	superseded by AH=26h
SeeAlso: AH=04h,AH=10h,AH=26h,AH=28h,AH=29h,AH=2Ah,INT 21/AX=3000h,INT 38

Format of PC-MOS/386 System Control Block:
Offset	Size	Description	(Table 2136)
 00h	WORD	pointer to first TCB in chain
 02h 17 BYTEs	reserved
 13h	WORD	pointer to current task's TCB
 15h	WORD	pointer to TCB of visible (console) task
--------O-D403-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET/SET EXTENDED DIRECTORY INFORMATION
	AH = 03h
	AL = subfunction (00h get, 01h set)
	DS:(E)DX -> pathname
	ES:(E)BX -> 10-byte buffer for directory information (see #2137)
Return: CF clear if successful
	    AL = permitted access level for file (00h-03h)
	    ES:(E)BX -> modified buffer (AL=01h on entry)
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
Notes:	BX/DX are used in V86 mode, EBX/EDX in native mode
	the file class cannot be changed for files because it affects the
	  encryption method, but directories can have their classes changed

Format of PC-MOS/386 directory information:
Offset	Size	Description	(Table 2137)
 00h	BYTE	reserved (0)
 01h	BYTE	file class ('A'-'Z' or 00h)
 02h	DWORD	user ID of file creator
 06h	WORD	file creation time (see #0761 at INT 21/AX=5700h)
 08h	WORD	file creation date (see #0762 at INT 21/AX=5700h)
--------O-D404-------------------------------
INT D4 - PC-MOS/386 v3.0+ - GET TASK CONTROL BLOCK
	AH = 04h
	BX = task ID or FFFFh for calling task
Return: CF clear if successful
	    ES = segment of Task Control Block (TCB) (see #2138)
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
Note:	superseded by AH=27h
SeeAlso: AH=02h,AH=27h,AH=28h,AH=29h,AH=2Ah,INT 38

Format of PC-MOS/386 Task Control Block:
Offset	Size	Description	(Table 2138)
 00h	BYTE	signature byte "H" if allocated from system memory pool
 01h	BYTE	header block ID, "T" = TCB
 02h	WORD	length of block in paragraphs
 04h	WORD	segment address of next header block (0000h if last)
 06h	WORD	segment address of previous header block (0000h if first)
 08h	WORD	pointer to next TCB
 0Ah	WORD	pointer to previous TCB
 0Ch	WORD	pointer to associated TCB (if applicable)
 0Eh	WORD	reserved
---TCB---
 10h	WORD	TCB task ID
 12h	WORD	native context save area
 14h	WORD	start address of task
 16h	WORD	end address of task
 18h	BYTE	task priority
 19h	BYTE	task time slice
 1Ah	BYTE	"TCBWAIT" run status of task
 1Bh	BYTE	"TCBSTAT" what the task is waiting for
 1Ch	DWORD	address of polling routine
 20h	BYTE	error code from last function call
 21h 11 BYTEs	name of currently executing task
 2Ch  4 BYTEs	???
 30h	BYTE	keyboard disabled if bit 1 set
 31h	BYTE	current shift state and toggles
 32h  2 BYTEs	???
 34h	BYTE	current video mode
 35h	BYTE	current video page
 36h	BYTE	number of text columns per screen
 37h	BYTE	number of text rows per screen
 38h	WORD	length of video buffer
 3Ah	WORD	video page length
 3Ch	WORD	apge start address in video RAM
 3Eh  4 WORDs	current cursor positions for four screen pages
 46h  8 BYTEs	???
 4Eh	WORD	current cursor type
 50h	BYTE	current palette setting
 51h	BYTE	original video mode
 52h	BYTE	start CRT row (00h or 01h)
 53h	BYTE	video RAM in task active
 54h	WORD	handle of video save area
 56h	WORD	page count of video save area
 58h	WORD	segment address of video save area
 5Ah	WORD	poitner to first Task File Block (see #2141)
 5Ch	WORD	pointer to first Current Directory Block (see #2144)
 5Eh	WORD	pointer to active Current Directory Block (see #2144)
 60h	BYTE	number of drives
 61h	BYTE	current drive (0=A:, etc.)
 62h	DWORD	disk transfer address
 66h  4 BYTEs	???
 6Ah	BYTE	verify flag (nonzero = on)
 6Bh	BYTE	break flag (nonzero = on)
 6Ch	WORD	share/lock retry count
 6Eh	WORD	ticks between share/lock retries
 70h	BYTE	remote printer flags (see #2139)
 71h	BYTE	ETX/ACK delay count
 72h	WORD	spooler segment address
 74h  2 BYTEs	???
 76h  3 BYTEs	remote printer redirection for LPT1 through LPT3 (see #2140)
 79h  2 BYTEs	???
 7Bh	DWORD	offset of username in TCB
 7Fh	BYTE	current output class
 80h  7 BYTEs	protection access rights, 2 bits per class (writeable!)
 87h 122 BYTEs	???
101h	BYTE	TCB sleep downcounter value
102h 20 BYTEs	???
116h	BYTE	last scan code
	...
5D0h	DWORD	far pointer to Device Driver Terminal's entry point
5D4h	WORD	offset of logical screen
5D6h	WORD	segment of logical screen
5D8h	WORD	cursor offset within page
5DAh	BYTE	screen columns
5DBh	WORD	async port number (0000h = none)
5DDh	DWORD	physical baudrate
5E1h 19 BYTEs	reserved for Device Driver Terminal (DDT)
	...
7A6h	DWORD	far pointer to unregister calling chain

Bitfields for PC-MOS/386 remote printer flags:
Bit(s)	Description	(Table 2139)
 0	LPT1 to terminal
 1	LPT2 to terminal
 2	LPT3 to terminal
 3	escape to printer pending
 4	use XON/XOFF
 5	use ETX/ACK
 6	waiting for ACK or XON
 7	transparent printing on

(Table 2140)
Values for PC-MOS/386 remote printer redirection:
 00h	not redirected
 01h	redirected to COM1
 ...
 18h	redirected to COM24
 51h	redirected to LPT1
 52h	redirected to LPT2
 53h	redirected to LPT3

Format of PC-MOS/386 Task File Block:
Offset	Size	Description	(Table 2141)
 00h	BYTE	signature byte "H" if allocated from system memory pool
 01h	BYTE	header block ID, "F" = task file block
 02h	WORD	length of block in paragraphs
 04h	WORD	segment address of next header block (0000h if last)
 06h	WORD	segment address of previous header block (0000h if first)
 08h	WORD	pointer to next TCB
 0Ah	WORD	pointer to previous TCB
 0Ch	WORD	pointer to associated TCB (if applicable)
 0Eh	WORD	reserved
---TFB---
 10h	WORD	segment address of next TFB
 12h	WORD	segment address of previous TFB
 14h	WORD	segment address of TFB's Global File Block (see #2143)
 16h	WORD	segment address of owner's PSP
 18h	WORD	file handle
 1Ah  3 BYTEs	???
 1Dh	DWORD	file position
 21h  4 BYTEs	???
 25h	BYTE	IOCTL flags (see #2142)
 26h  2 BYTEs	???

Bitfields for PC-MOS/386 IOCTL flags:
Bit(s)	Description	(Table 2142)
 0	stdin
 1	stdout
 2	null device
 3	clock device
 4	reserved
 5	ASCII mode instead of binary
 6	EOF encountered on input
 7	device rather than file

Format of PC-MOS/386 Global File Block:
Offset	Size	Description	(Table 2143)
 00h	BYTE	signature byte "H" if allocated from system memory pool
 01h	BYTE	header block ID, "G" = global file block
 02h	WORD	length of block in paragraphs
 04h	WORD	segment address of next header block (0000h if last)
 06h	WORD	segment address of previous header block (0000h if first)
 08h	WORD	pointer to next TCB
 0Ah	WORD	pointer to previous TCB
 0Ch	WORD	pointer to associated TCB (if applicable)
 0Eh	WORD	reserved
---GFB---
 10h 10 BYTEs	???
 1Ah	WORD	file attribute
 1Ch	BYTE	???
 1Dh	DWORD	address of device driver
 21h	WORD	first cluster
 23h	WORD	time of last modification
 25h	WORD	date of last modification
 27h	DWORD	size of file in bytes
 2Bh 11 BYTEs	???
 36h 11 BYTEs	device name or FCB-format filename
 41h	WORD	segment address of TFB list
 43h	WORD	segment address of first RLB (see #2146) (0000h = none)
 45h	BYTE	flag: nonzero if GFB refers to character device
 46h	WORD	address of Block Device Block (see #2145)
 48h	WORD	sector of file's directory entry
 4Ah	WORD	high word of file's directory entry
 4Ch	WORD	ofsset of directory entry within sector

Format of PC-MOS/386 Current Directory Block:
Offset	Size	Description	(Table 2144)
 00h	BYTE	signature byte "H" if allocated from system memory pool
 01h	BYTE	header block ID, "C" = current directory block
 02h	WORD	length of block in paragraphs
 04h	WORD	segment address of next header block (0000h if last)
 06h	WORD	segment address of previous header block (0000h if first)
 08h	WORD	pointer to next TCB
 0Ah	WORD	pointer to previous TCB
 0Ch	WORD	pointer to associated TCB (if applicable)
 0Eh	WORD	reserved
---CDB---
 10h	BYTE	drive number
 11h	BYTE	???
 12h 64 BYTEs	directory name
 52h	WORD	first directory cluster (0000h = root)

Format of PC-MOS/386 Block Device Block:
Offset	Size	Description	(Table 2145)
 00h	BYTE	signature byte "H" if allocated from system memory pool
 01h	BYTE	header block ID, "B" = block device block
 02h	WORD	length of block in paragraphs
 04h	WORD	segment address of next header block (0000h if last)
 06h	WORD	segment address of previous header block (0000h if first)
 08h	WORD	pointer to next TCB
 0Ah	WORD	pointer to previous TCB
 0Ch	WORD	pointer to associated TCB (if applicable)
 0Eh	WORD	reserved
---BDB---
 10h	BYTE	logical drive
 11h	BYTE	unit passed to driver
 12h	WORD	sector size
 14h	BYTE	cluster mask
 15h	BYTE	cluster shift count
 16h	WORD	starting sector of first FAT
 18h	BYTE	number of FATs
 19h	WORD	number of root directories
 1Bh	WORD	sector number of first data sector (cluster 0002h)
 1Dh	WORD	number of clusters + 1 (number of highest data cluster)
 1Fh	BYTE	number of sectors in FAT
 20h	WORD	beginning root directory sector number
 22h	DWORD	device driver address
 26h	BYTE	media descriptor byte
 27h  5 BYTEs	???
 2Ch	BYTE	flag: volume > 32MB
 2Dh	BYTE	???
 2Eh	BYTE	number of sectors per cluster
 2Fh	WORD	number of clusters on device
 31h	WORD	number of free clusters (FFFFh = unknown)
 33h	WORD	root directory cluster number
 35h	WORD	pointer to alias/subst string
 37h	WORD	TCB segment address of owner (0000h = none)

Format of PC-MOS/386 Record Lock Block:
Offset	Size	Description	(Table 2146)
 00h	BYTE	signature byte "H" if allocated from system memory pool
 01h	BYTE	header block ID, "R" = record lock block
 02h	WORD	length of block in paragraphs
 04h	WORD	segment address of next header block (0000h if last)
 06h	WORD	segment address of previous header block (0000h if first)
 08h	WORD	pointer to next TCB
 0Ah	WORD	pointer to previous TCB
 0Ch	WORD	pointer to associated TCB (if applicable)
 0Eh	WORD	reserved
---RLB---
 10h	WORD	segment address of owner's PSP
 12h	WORD	segment address of Global File Block (see #2143)
 14h	WORD	segment address of owner's Task File Block (see #2141)
 16h	DWORD	file offset of locked region start
 1Ah	DWORD	length of locked region
 1Eh	WORD	owner's handle for file
--------O-D407-------------------------------
INT D4 - PC-MOS/386 v3.0+ - WAIT FOR EVENT
	AH = 07h
	AL = events to monitor (see #2147)
	BX = number of timer ticks until timeout if AL bit 1 set
	CX = bitmap of IRQs to monitor if AL bit 2 set
		(bit 0 = IRQ0 .. bit 15 = IRQ15)
	DX = port to monitor if AL bit 3 set
Return: CF clear if successful
	    AL = type of event which woke up task (see above)
	    CX = IRQ (if any) which awakened task
	    DX = port (if any) which awakened task
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
Note:	a device driver may make this call with AL=00h, which indicates that
	  the driver is responsible for setting and clearing the TCBWAIT field
	  in the TCB.  To put task to sleep, set TCBWAIT bits 2-0 to 001; to
	  reawaken it, set bit 1 (leaving other bits unchanged)
SeeAlso: AH=04h,INT 16/AH=00h,INT 38

Bitfields for PC-MOS/386 events to monitor:
Bit(s)	Description	(Table 2147)
 0	keystroke
 1	timeout
 2	IRQ
 3	port access
 7	return status of user poll routine (other ignored if set)
--------O-D410-------------------------------
INT D4 - PC-MOS/386 v3.0+ - ENTER/LEAVE NATIVE 386 EXECUTION MODE
	AH = 10h
	AL = direction (00h return to V86 mode, 01h enter native mode)
	CX = length in bytes of Native Context Area ( >=1024 )
	DX = segment of Native Context Area
Return: CF clear if successful
	    running in desired mode at instruction following INT D4 call
	    all segment registers converted to appropriate selectors/segments
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
Note:	MS-DOS calls are available in protected mode
SeeAlso: AH=11h,AH=12h,AH=13h,INT 2F/AX=1687h,INT 67/AX=DE0Ch,INT 38
--------O-D411-------------------------------
INT D4 - PC-MOS/386 v3.0+ - ALLOCATE NATIVE MODE MEMORY BLOCK
	AH = 11h
	EBX = block length in bytes
Return: CF clear if successful
	    EBX = number of bytes actually allocated
	    ES = selector for allocated block
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
Program: PC-MOS/386 is a multitasking/multiuser MS-DOS-compatible operating
	  system by The Software Link, Inc.
Note:	the memory must be released before the program terminates
SeeAlso: AH=10h,AH=12h,INT 38
--------O-D412-------------------------------
INT D4 - PC-MOS/386 v3.0+ - FREE NATIVE MODE MEMORY BLOCK
	AH = 12h
	ES = selector for block to free
Return: CF clear if successful
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
SeeAlso: AH=10h,AH=11h,AH=13h,INT 38
--------O-D413-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET ALIAS FOR SELECTOR (NATIVE MODE ONLY)
	AH = 13h
	AL = type of alias selector (00h data, 01h stack, 02h code)
	BX = selector
Return: CF clear if successful
	    AX = new selector or 0000h if BX selector not found
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
SeeAlso: AH=11h,AH=12h
--------O-D416-------------------------------
INT D4 - PC-MOS/386 v5.01 - SET/CLEAR IRQ RESERVATION
	AH = 16h
	AL = function (00h clear, 01h set reservation)
	CX = IRQ number
Return: AX = status
	    (0000h successful, 0001h currently reserved by another task)
SeeAlso: AH=07h,INT 14/AH=11h"PC-MOS"
--------O-D419-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET TASK ID
	AH = 19h
Return: BX = caller's task ID
Program: PC-MOS/386 is a multitasking/multiuser MS-DOS-compatible operating
	  system by The Software Link, Inc.
SeeAlso: AH=1Dh,AH=1Eh
--------O-D41A-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET/SET TASK PRIORITY
	AH = 1Ah
	AL = subfunction (00h read, 01h set, 02h get and set)
	BX = task ID (FFFFh for current task)
	CL = new priority value
Return: CF clear if successful
	    CL = current priority value
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
SeeAlso: AH=1Bh,AH=1Ch
--------O-D41B-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET/SET TIME SLICE
	AH = 1Bh
	AL = subfunction (00h read, 01h set, 02h get and set)
	BX = task ID (FFFFh for current task) (see AH=19h)
	CL = new time slice value
Return: CF clear if successful
	    CL = current time slice value
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
SeeAlso: AH=1Ah,AH=1Ch
--------O-D41C-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET/SET KEYBOARD MODE
	AH = 1Ch
	AL = subfunction (00h enable, 01h disable, 02h get mode)
	BX = task ID (FFFFh for current task)
Return: CF clear if successful
	    CL = current keyboard state
	CF set on error
	    AX = error code (INT 21/AH=59h)
Program: PC-MOS/386 is a multitasking/multiuser MS-DOS-compatible operating
	  system by The Software Link, Inc.
SeeAlso: AH=1Ah,AH=1Bh
--------O-D41D-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET CURRENT PROGRAM NAME
	AH = 1Dh
	BX = task ID (FFFFh for current task) (see AH=19h)
	ES:DI -> buffer for program name (see #2148)
Return: CF clear if successful
	    ES:DI buffer filled
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
SeeAlso: AH=19h,AH=1Eh

Format of PC-MOS/386 program name buffer:
Offset	Size	Description	(Table 2148)
 00h  8 BYTEs	filename
 08h  3 BYTEs	extension
--------O-D41E-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET CURRENT USERNAME AND SECURITY CLASS
	AH = 1Eh
	BX = task ID (FFFFh for current task)
	ES:DI -> 4-byte buffer for username
Return: CF clear if successful
	    CL = security class
		20h (' ') none
		41h-5Ah ('A'-'Z') security level
	    ES:DI buffer filled
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
SeeAlso: AH=19h,AH=1Dh
--------O-D41F-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET TASK PARTITION INFORMATION
	AH = 1Fh
	BX = task ID (FFFFh for current task) (see AH=19h)
Return: CF clear if successful
	    CX = start segment of task
	    DX = ending segment of task
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
Program: PC-MOS/386 is a multitasking/multiuser MS-DOS-compatible operating
	  system by The Software Link, Inc.
SeeAlso: AH=2Dh
--------O-D420-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET PORT AND BAUDRATE INFORMATION
	AH = 20h
	BX = task ID (FFFFh for current task) (see AH=19h)
Return: CF clear if successful
	    CX = port number (0000h if none)
	    DI:SI = baudrate (if CX nonzero)
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
SeeAlso: INT 14/AH=0Ch"FOSSIL"
--------O-D421-------------------------------
INT D4 - PC-MOS/386 v5.01 - REMOVE A TASK
	AH = 21h
	BX = task ID (FFFFh for current task) (see AH=19h)
Return: CF clear if successful
	    AX = ASCII percentage of System Memory Pool used
		(AH = tens digit, AL = ones digit)
	    DS,SI destroyed
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
Program: PC-MOS/386 is a multitasking/multiuser MS-DOS-compatible operating
	  system by The Software Link, Inc.
SeeAlso: AH=22h
--------O-D422-------------------------------
INT D4 - PC-MOS/386 v5.01 - ADD A TASK TO THE SYSTEM
	AH = 22h
	DS:SI -> addtask data structure (see #2150)
Return: CF clear if successful
	    ES = segment address of the new task's TCB data structure
	CF set on error
	    AX = error code (see #2149)
SeeAlso: AH=21h

(Table 2149)
Values for PC-MOS/386 error code:
 08h	insufficient memory
 0Bh	invalid addtask structure format
 12h	insufficient available space in system memory pool
 1Fh	general failure
 55h	already allocated
 57h	if task already in use or invalid parameter

Format of PC-MOS/386 addtask data structure:
Offset	Size	Description	(Table 2150)
 00h	WORD	task size in KB (min 16KB)
 02h	WORD	task ID (0000h for automatic selection)
 04h	BYTE	task class (' ' or 'A'-'Z')
 05h	DWORD	-> ASCIZ name of task startup batchfile
 09h	DWORD	-> task's terminal driver (0000000h = background task)
 0Dh	WORD	task port
 0Fh	DWORD	task baud rate
 13h	DWORD	(return) total extended memory
 17h	DWORD	(return) number of 4K extended memory pages allocated
 1Bh	WORD	(return) paragraphs of system memory pool allocated
 1Dh	WORD	(return) system memory pool size in paragraphs
 1Fh	WORD	(return) ASCII task percentage of system memory pool
 21h  3 BYTEs	reserved
--------O-D423-------------------------------
INT D4 - PC-MOS/386 v5.01 - CHANGE TERMINAL DRIVER
	AH = 23h
	BX = task ID (FFFFh for current task)
	DS:SI -> entry point of the new Device Driver Terminal
Return: CF clear if successful
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
--------O-D424-------------------------------
INT D4 U - PC-MOS/386 v5.01 - GET OPERATING SYSTEM SERIAL NUMBER
	AH = 24h
Return: DS:DX -> '$'-terminated string containing the serial number
--------O-D425-------------------------------
INT D4 - PC-MOS/386 v5.01 - IDENTIFY LOAD ADDRESS OF DEVICE DRIVER LOCATION
	AH = 25h
	DX = driver's CS value
Return: AX = segment address of driver in system memory pool
	    (0000h if the driver is not within the system memory pool)
Program: PC-MOS/386 is a multitasking/multiuser MS-DOS-compatible operating
	  system by The Software Link, Inc.
--------O-D426-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET SYSTEM CONTROL BLOCK SEGMENT/SELECTOR
	AH = 26h
Return: DX = segment/selector of the System Control Block (see #2136)
Note:	this function supersedes AH=02h
SeeAlso: AH=02h,AH=27h,AH=28h,AH=29h,AH=2Ah
--------O-D427-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET TASK CONTROL BLOCK SEGMENT/SELECTOR
	AH = 27h
	BX = task ID (FFFFh if current task) (see AH=19h)
Return: CF clear if successful
	    DX = segment/selector for the Task Control Block (see #2138)
	CF set on error
	    AX = error code (INT 21/AH=59h)
Note:	this function supersedes AH=04h
SeeAlso: AH=26h,AH=28h,AH=29h,AH=2Ah
--------O-D428-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET CONTROL BLOCK DATA FROM SCB OR TCB
	AH = 28h
	BX = offset into control block at which to start reading
	CX = number of bytes to read
	DX = segment/selector of control block obtained via AH=26h or AH=27h
	ES:DI -> buffer for data
Return: CF clear if successful
	CF set on error
	    AX = error code (see also INT 21/AH=59h)
		05h access denied due to an invalid segment/selector
SeeAlso: AH=26h,AH=27h,AH=29h,AH=2Ah
--------O-D429-------------------------------
INT D4 - PC-MOS/386 v5.01 - WRITE CONTROL BLOCK DATA INTO SCB OR TCB
	AH = 29h
	BX = offset into control block at which to start writing
	CX = number of bytes to write
	DX = segment/selector of control block obtained via AH=26h or AH=27h
	DS:SI -> buffer containing data to be written
Return: CF clear if successful
	CF set on errro
	    AX = error code (see also INT 21/AH=59h)
		05h access denied due to an invalid segment/selector
Note:	 this function performs no bounds checking
Program: PC-MOS/386 is a multitasking/multiuser MS-DOS-compatible operating
	  system by The Software Link, Inc.
SeeAlso: AH=26h,AH=27h,AH=28h,AH=2Ah
--------O-D42A-------------------------------
INT D4 - PC-MOS/386 v5.01 - SWAP CONTROL BLOCK DATA OF SCB OR TCB
	AH = 2Ah
	BX = offset into control block at which to start swap
	CX = number of bytes to swap
	DX = segment/selector of control block obtained via AH=26h or AH=27h
	DS:SI -> buffer containing new data and to receive current data
Return: CF clear if successful
	CF set on error
	    AX = error code (see also INT 21/AH=59h)
		05h access denied due to an invalid segment/selector
Note:	the interrupts are disabled during the swap to prevent corruption
SeeAlso: AH=26h,AH=27h,AH=28h,AH=29h
--------O-D42C-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET/SET SPOOLER PARAMETERS
	AH = 2Ch
	AL = function
	    00h set spooler timeout
		CX = timout value in seconds
	    01h get spooler timeout
		Return: CX = current timeout in seconds
	    02h get spooler parameters
		Return: CH = priority (00h-09h)
			CL = disposition (d, h, i, n, s)
			SI = class (a - z)
	    03h set spooler parameters
		CH = priority (00h-09h)
		CL = disposition (d, h, i, n, s)
		SI = class (a - z)
		BX = task ID (FFFFh for current task)
		DX = LPT number
Return: CF clear if successful
	CF set on error
	    AX = error code (see #0770 at INT 21/AH=59h)
SeeAlso: AH=00h,AH=02h,AH=03h
--------O-D42D-------------------------------
INT D4 - PC-MOS/386 v5.01 - GET MAXIMUM TASK SIZE
	AH = 2Dh
Return: DX = maximum task size in paragraphs
	BX = start address of task space
Program: PC-MOS/386 is a multitasking/multiuser MS-DOS-compatible operating
	  system by The Software Link, Inc.
SeeAlso: AH=1Fh,AH=22h
--------r-D5---------------------------------
INT D5 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT D4"BASIC",INT D6"BASIC"
--------r-D5---------------------------------
INT D5 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-D6---------------------------------
INT D6 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT D5"BASIC",INT D7"BASIC"
--------r-D6---------------------------------
INT D6 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-D7---------------------------------
INT D7 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT D6"BASIC",INT D8"BASIC"
--------r-D7---------------------------------
INT D7 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-D8---------------------------------
INT D8 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT D7"BASIC",INT D9"BASIC"
--------r-D8---------------------------------
INT D8 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------H-D8---------------------------------
INT D8 - Screen Thief v1.00 - RELOCATED IRQ0
Range:	INT 78h to INT E0h, selected by commandline switch
Note:	Screen Thief relocates IRQs 0 through 7 to INT D8 to INT DF by default,
	  but may be directed via a commandline switch to use any range
	  starting at a multiple of 8 between 78h and E0h
SeeAlso: INT 08"IRQ0",INT 2D/AL=10h"Screen Thief",INT 50"DESQview"
SeeAlso: INT D9"Screen Thief"
--------r-D9---------------------------------
INT D9 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT D8"BASIC",INT DA"BASIC"
--------r-D9---------------------------------
INT D9 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------H-D9---------------------------------
INT D9 - Screen Thief v1.00 - RELOCATED IRQ1
Range:	INT 79h to INT E1h, selected by commandline switch
Note:	(see INT D8"Screen Thief")
SeeAlso: INT 09"IRQ1",INT D8"Screen Thief",INT DA"Screen Thief"
--------r-DA---------------------------------
INT DA - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT D9"BASIC",INT DB"BASIC"
--------r-DA---------------------------------
INT DA - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------H-DA---------------------------------
INT DA - Screen Thief v1.00 - RELOCATED IRQ2
Range:	INT 7Ah to INT E2h, selected by commandline switch
Note:	(see INT D8"Screen Thief")
SeeAlso: INT 0A"IRQ2",INT D9"Screen Thief",INT DB"Screen Thief"
--------r-DB---------------------------------
INT DB - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT DA"BASIC",INT DC"BASIC"
--------r-DB---------------------------------
INT DB - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------H-DB---------------------------------
INT DB - Screen Thief v1.00 - RELOCATED IRQ3
Range:	INT 7Bh to INT E3h, selected by commandline switch
Note:	(see INT D8"Screen Thief")
SeeAlso: INT 0B"IRQ3",INT DA"Screen Thief",INT DC"Screen Thief"
--------u-DC---------------------------------
INT DC - PC/370 v4.1- - API
SeeAlso: INT 60"PC/370"
--------r-DC---------------------------------
INT DC - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT DB"BASIC",INT DD"BASIC"
--------r-DC---------------------------------
INT DC - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------H-DC---------------------------------
INT DC - Screen Thief v1.00 - RELOCATED IRQ4
Range:	INT 7Ch to INT E4h, selected by commandline switch
Note:	(see INT D8"Screen Thief")
SeeAlso: INT 0C"IRQ4",INT DB"Screen Thief",INT DD"Screen Thief"
--------r-DD---------------------------------
INT DD - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT DC"BASIC",INT DE"BASIC"
--------r-DD---------------------------------
INT DD - STSC APL*PLUS/PC v9.0 - PLACE KEYSTROKE EVENTS IN INPUT BUFFER
	BX = where to place keystrokes
	    FFFFh insert before current buffer contents
	    0000h replace current contents
	    0001h insert after current contents
	CX = number of keystroke events to insert
	ES:SI -> data to be placed into buffer (list of WORD key codes)
	    4000h + N = normal ASCII keystroke N (N = 00h to FFh)
	    4100h + N = extended ASCII keystroke N (N = 03h to 84h)
SeeAlso: INT 16/AH=05h
--------H-DD---------------------------------
INT DD - Screen Thief v1.00 - RELOCATED IRQ5
Range:	INT 7Dh to INT E5h, selected by commandline switch
Note:	(see INT D8"Screen Thief")
SeeAlso: INT 0D"IRQ5",INT DC"Screen Thief",INT DE"Screen Thief"
--------r-DE---------------------------------
INT DE - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT DD"BASIC",INT DF"BASIC"
--------r-DE---------------------------------
INT DE - APL*PLUS/PC - ???
Note:	appears to be the same as INT 16
--------H-DE---------------------------------
INT DE - Screen Thief v1.00 - RELOCATED IRQ6
Range:	INT 7Eh to INT E6h, selected by commandline switch
Note:	(see INT D8"Screen Thief")
SeeAlso: INT 0E"IRQ6",INT DD"Screen Thief",INT DF"Screen Thief"
--------b-DF---------------------------------
INT DF - Victor 9000 - SuperBIOS
--------r-DF---------------------------------
INT DF - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT DE"BASIC",INT E0"BASIC"
--------r-DF---------------------------------
INT DF - APL*PLUS/PC - SAME AS INT 10
SeeAlso: INT 10
--------H-DF---------------------------------
INT DF - Screen Thief v1.00 - RELOCATED IRQ7
Range:	INT 7Fh to INT E7h, selected by commandline switch
Note:	(see INT D8"Screen Thief")
SeeAlso: INT 0F"IRQ7",INT DE"Screen Thief"
--------r-E0---------------------------------
INT E0 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 80"BASIC",INT DF"BASIC",INT E1"BASIC"
--------r-E0---------------------------------
INT E0 - APL*PLUS/PC - RESTIME HIGH-RESOLUTION TIMER FOR QUAD MF FUNCTION
SeeAlso: INT CF"APL"
--------v-E0---------------------------------
INT E0 - VIRUS - "Micro-128" - ???
Note:	Micro-128 also overwrites the upper half of the interrupt table
SeeAlso: INT 9E"VIRUS",INT F1"VIRUS"
--------O-E0---------------------------------
INT E0 - CP/M-86, Concurrent CP/M, DR Multiuser DOS - FUNCTION CALLS
	CL = function number
	DS,DX = parameters
Return: as appropriate for function
Notes:	several functions are covered in more detail in following entries
	most of these calls are also supported by Digital Research's DOS Plus
	  v2.1; the unsupported functions are 26h,29h-2Bh,3Ah,3Dh-62h,71h-8Ch,
	  90h-92h,94h-97h,9Bh-ABh, and AEh-FFh
SeeAlso: INT 21/AX=4459h,INT 21/AH=E0h"DOS Plus"

(Table 2151)
Values for CP/M-86,DR Multiuser DOS function number:
 00h	terminate calling process (see also INT 21/AH=00h)
 01h	read a character
 02h	write character to default console (see also INT 21/AH=02h)
 03h	read character from default AUX (see also INT 21/AH=03h)
 04h	write character to default AUX (see also INT 21/AH=04h)
 05h	write character to default list device (see also INT 21/AH=05h)
 06h	perform raw I/O on default console (see also INT 21/AH=06h)
 07h	return default AUX input status
 08h	return default AUX output status
 09h	write string to default console (see also INT 21/AH=09h)
 0Ah	read string from default console (see also INT 21/AH=0Ah)
 0Bh	return default console input status (see also INT 21/AH=0Bh)
 0Ch	get BDOS release ID
 0Dh	reset all disk drives (see also INT 21/AH=0Dh)
 0Eh	set default drive (see also INT 21/AH=0Eh)
 0Fh	open file via FCB (see also INT 21/AH=0Fh,#0469)
 10h	close file via FCB (see also INT 21/AH=10h)
 11h	search for first matching file with FCB (see also INT 21/AH=11h)
 12h	search for next matching file with FCB (see also INT 21/AH=12h)
 13h	delete file via FCB (see also INT 21/AH=13h)
 14h	sequential read via FCB (see also INT 21/AH=14h)
 15h	sequential write via FCB (see also INT 21/AH=15h)
 16h	create file via FCB (see also INT 21/AH=16h)
 17h	rename file via FCB (see also INT 21/AH=17h)
 18h	get bit map of logged drives
 19h	get default drive (see also INT 21/AH=19h)
 1Ah	set DMA address offset
 1Bh	get default disk allocation vector (see also INT 21/AH=1Bh)
 1Ch	set default drive to read-only
 1Dh	get bit map of read-only drives
 1Eh	set file attributes via FCB (see also INT 21/AX=4301h)
 1Fh	get address of disk parameter block (see also INT 21/AH=1Fh)
 20h	get/set default user number
 21h	read random record via FCB (see also INT 21/AH=21h)
 22h	write random record via FCB (see also INT 21/AH=22h)
 23h	compute file size with FCB (see also INT 21/AH=23h)
 24h	get FCB random record number (see also INT 21/AH=24h)
 25h	reset specified drives
 26h	access specified drives (not in DR DOS Plus v2.1)
 27h	free specified drives
 28h	write random with FCB, zero fill (see also also INT 21/AH=28h)
 2Ah	lock records in FCB file (see also INT 21/AH=5Ch)
 2Bh	unlock records in FCB file (see also INT 21/AH=5Ch)
 2Ch	set BDOS multisector count
 2Dh	set BDOS error mode
 2Eh	get free space on disk
 2Fh	load, initialize, and jump to process (see also INT 21/AH=4Bh)
 30h	flush write-deferred buffers
 31h	get/set system variable (DOS Plus v2.1)
 32h	call BIOS (XIOS) character routine (see #2152)
 33h	set DMA address segment
 34h	get DMA buffer address
 35h	CP/M-86 allocate maximum memory
 36h	allocate maximum memory at specified segment
 37h	CP/M-86 allocate memory segment (see also INT 21/AH=48h)
 38h	allocate memory at specified segment
 39h	CP/M-86 free specified memory segment (see also INT 21/AH=49h)
 3Ah	CP/M-86 free all memory (not in DOS Plus v2.1)
 3Bh	load .CMD file into memory
 3Ch	(DOS Plus v2.1) call RSX program
 40h	(DR-NET) log on a server
 41h	(DR-NET) log off a server
 42h	(DR-NET) send a message
 43h	(DR-NET) receive a message
 44h	(DR-NET) get network status
 45h	(DR-NET) get requestor configuration table
 46h	(DR-NET) set compatibility attributes
 47h	(DR-NET) get server configuration table
 48h	(DR-NET) set network error mode
 49h	(DR-NET) attach network
 4Ah	(DR-NET) detach network
 4Bh	(DR-NET) set default password
 4Ch	(DR-NET) get-set long timeout
 4Dh	(DR-NET) get parameter table
 50h	(DR-NET) get network information
 53h	get current time (see also INT 21/AH=2Ch)
 54h	set current time (see also INT 21/AH=2Dh)
 55h	get binary system date (see also INT 21/AH=2Ah)
 56h	set system date (see also INT 21/AH=2Bh)
 57h	allocate system flag
 58h	deallocate system flag
 59h	reserve memory in global area
 5Ah	lock physical drive
 5Bh	unlock physical drive
 5Ch	search path for executable file
 5Dh	load and execute command (see also INT 21/AH=4Bh)
 5Eh	get/set process exit code
 5Fh	set country information
 60h	get country information
 63h	truncate FCB file (see also INT 21/AH=28h)
 64h	create/update directory label
 65h	get directory label
 66h	get FCB date stamp and password mode
 67h	write extended FCB
 68h	set system date and time
 69h	get system date and time in binary
 6Ah	establish password for file access
 6Bh	get OS serial number
 6Ch	(DOS Plus v2.1) get/set program return code
 6Dh	get/set console mode
 6Eh	get/set string delimiter
 6Fh	write block to default console
 70h	write block to default list device
 71h	execute DOS-compatible function
 74h	set FCB time and date stamps
 80h	allocate memory
 82h	deallocate memory
 83h	poll I/O device
 84h	wait on system flag
 85h	set system flag
 86h	create message queue
 87h	open message queue
 88h	delete message queue
 89h	read from message queue
 8Ah	conditionally read from message queue
 8Bh	write to message queue
 8Ch	conditionally write to message queue
 8Dh	delay calling process
 8Eh	call process dispatcher (yield CPU)
 8Fh	terminate calling process (same as function 00h)
 90h	create a process
 91h	set calling process' priority
 92h	attach to default console
 93h	detach from default console
 95h	assign default console to process
 96h	interpret and execute commandline
 97h	resident procedure library
 98h	parse ASCII string into FCB (see also INT 21/AH=29h)
 99h	return default console
 9Ah	get address of system data (SYSDAT)
 9Bh	get system time and date
 9Ch	return calling process' descriptor
 9Dh	terminate process by name or PD address
 9Eh	attach to default list device
 9Fh	detach from default list device
 A0h	select default list device
 A1h	conditionally attach to default list device
 A2h	conditionally attach to default console
 A3h	get OS version number
 A4h	get default list device
 A5h	attach to default AUX
 A6h	detach from default AUX
 A7h	conditionally attach to default AUX
 A8h	set default AUX
 A9h	return default AUX
 ACh	read block from default AUX
 ADh	(DOS Plus v2.1) write block to default AUX
 B0h	configure default AUX
 B1h	get/set device control parameters
 B2h	send Break through default AUX
 B3h	allocate physical memory
 B4h	free physical memory
 B5h	map physical memory
 B6h	nondestructive message queue read
 B7h	timed wait on system flag
 B8h	get/set I/O port mapping
 B9h	set list device timeout
 BAh	set AUX timeout value
 BBh	execute XIOS service
 BDh	(DR Multiuser DOS) delay
 FFh	return 80386 to native mode

(Table 2152)
Values for DOS Plus v2.1 XIOS functions:
 00h	terminate program
 01h	???
 02h	check for console input status
 03h	read character from console
 04h	write character to console
 05h	write character to list device
 06h	write character to auxiliary device
 07h	read cahracter from auxiliary device
 0Fh	get list device status
 10h-14h reserved
 15h	device initialization
 16h	check console output status
 17h-7Fh reserved
---BBC Acorn---
 80h	get XIOS version
 81h	get Tube semaphore
 82h	release Tube semaphore
 83h	select text/graphics
 84h	update B&W graphics rectangle
 85h	update color graphics rectangle
 86h	get/release/update mouse
 87h	get system error info
 88h	entry in CLOCK called by WatchDog RSP
 89h	BBC OSBYTE function
 8Ah	BBC OSWORD function

(Table 2153)
Values for DR Multiuser DOS Error Return Code:
 00h	no error
 01h	system call not implemented
 02h	illegal system call number
 03h	cannot find memory
 04h	illegal flag number
 05h	flag overrun
 06h	flag underrun
 07h	no unused Queue Descriptors
 08h	no free queue buffer
 09h	cannot find queue
 0Ah	queue in use
 0Ch	no free Process Descriptors
 0Dh	no queue access
 0Eh	empty queue
 0Fh	full queue
 10h	CLI queue missing
 11h	no 8087 in system
 12h	no unused Memory Descriptors
 13h	illegal console number
 14h	no Process Descriptor match
 15h	no console match
 16h	no CLI process
 17h	illegal disk number
 18h	illegal filename
 19h	illegal filetype
 1Ah	character not ready
 1Bh	illegal Memory Descriptor
 1Ch	bad return from BDOS load
 1Dh	bad return from BDOS read
 1Eh	bad return from BDOS open
 1Fh	null command
 20h	not owner of resource
 21h	no CSEG in load file
 22h	process Descriptor exists on Thread Root
 23h	could not terminate process
 24h	cannot attach to process
 25h	illegal list device number
 26h	illegal password
 28h	external termination occurred
 29h	fixup error upon load
 2Ah	flag set ignored
 2Bh	illegal auxilliary device number
--------O-E0----CL03-------------------------
INT E0 - DR Multiuser DOS - "A_READ" - READ CHARACTER FROM AUX DEVICE
	CL = 03h
Return: AL = ASCII character
Notes:	A_READ reads the next 8-bit character from the logical auxilliary
	  input device (AUXn:); control is not returned to the calling
	  process until a character has been read.
	if another process owns AUX, this call blocks until the device becomes
	  available
SeeAlso: INT 21/AH=03h,INT E0/CL=04h,INT E0/CL=07h,INT E0/CL=A5h,INT E0/CL=ACh
--------O-E0----CL04-------------------------
INT E0 - DR Multiuser DOS - "A_WRITE" - WRITE CHARACTER TO AUX DEVICE
	CL = 04h
	DL = ASCII character
Return: nothing
Note:	if another process owns AUX, this call blocks until the device becomes
	  available
SeeAlso: INT 21/AH=04h,INT E0/CL=03h,INT E0/CL=08h,INT E0/CL=A5h,INT E0/CL=ADh
--------O-E0----CL07-------------------------
INT E0 - DR Multiuser DOS - "A_STATIN" - GET INPUT STATUS OF AUX DEVICE
	CL = 07h
Return: AL = status
	    00h not ready
	    FFh character available
Desc:	determine whether the current AUX device has input available
SeeAlso: INT E0/CL=03h,INT E0/CL=08h
--------O-E0----CL08-------------------------
INT E0 - DR Multiuser DOS - "A_STATOUT" - GET OUTPUT STATUS OF AUX DEVICE
	CL = 08h
Return: AL = status
	    00h not ready
	    FFh ready for output
Desc:	determine whether the current AUX device is able to accept more output
SeeAlso: INT E0/CL=04h,INT E0/CL=07h
--------O-E0----CL59-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "S_MEMORY" - RESERVE MEMORY IN GLOBAL AREA
	CL = 59h
	DX = size in bytes
Return: AX = status
	    FFFFh failed
	    other successful
		ES:BX -> reserved memory
--------O-E0----CL86-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "Q_MAKE" - CREATE MESSAGE QUEUE
	CL = 86h
	DS:DX -> queue descriptor (see #2154)
Return: AX = status (0000h success, FFFFh failure)
	CX = error code (see #2153)
SeeAlso: INT E0/CL=87h

Format of DR Multiuser DOS queue descriptor:
Offset	Size	Description	(Table 2154)
 00h  2 WORDs	internal use, initialize to zeros
 04h	WORD	flags
 06h  8 BYTEs	queue name
 0Eh	WORD	length of message
 10h	WORD	number of messages
 12h  4 WORDs	internal use, initialize to zeros
 1Ah	WORD	offset in system area of buffer for messages
--------O-E0----CL87-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "Q_OPEN" - OPEN MESSAGE QUEUE
	CL = 87h
	DS:DX -> queue parameter block (see #2155)
Return: AX = status (0000h success, FFFFh failure)
	CX = error code (see #2153)
SeeAlso: INT E0/CL=86h,INT E0/CL=89h

Format of DR Multiuser DOS queue parameter block:
Offset	Size	Description	(Table 2155)
 00h	WORD	internal use, initialize to zero
 02h	WORD	queue ID (set by INT E0/CL=87h)
 04h	WORD	internal use, initialize to zero
 06h	WORD	offset of queue message buffer
 08h  8 BYTEs	queue name
--------O-E0----CL89-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "Q_READ" - READ MESSAGE QUEUE
	CL = 89h
	DS:DX -> queue parameter block (see #2155)
Return: AX = status (0000h success, FFFFh failure)
	CX = error code (see #2153)
SeeAlso: INT E0/CL=87h,INT E0/CL=8Ah,INT E0/CL=8Bh
--------O-E0----CL8A-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "Q_CREAD" - CONDITIONALLY READ MSG QUEUE
	CL = 8Ah
	DS:DX -> queue parameter block (see #2155)
Return: AX = status (0000h success, FFFFh failure)
	CX = error code (see #2153)
SeeAlso: INT E0/CL=87h,INT E0/CL=89h,INT E0/CL=8Ch
--------O-E0----CL8B-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "Q_WRITE" - WRITE MESSAGE QUEUE
	CL = 8Bh
	DS:DX -> queue parameter block (see #2155)
Return: AX = status (0000h success, FFFFh failure)
	CX = error code (see #2153)
SeeAlso: INT E0/CL=89h,INT E0/CL=8Ch
--------O-E0----CL8C-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "Q_CWRITE" - CONDITIONALLY WRITE MSG QUEUE
	CL = 8Ch
	DS:DX -> queue parameter block (see #2155)
Return: AX = status (0000h success, FFFFh failure)
	CX = error code (see #2153)
SeeAlso: INT E0/CL=8Ah,INT E0/CL=8Bh
--------O-E0----CL8E-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "P_DISPATCH" - CALL DISPATCHER
	CL = 8Eh
	DX = FFFFh (optional) to force dispatch
Return: nothing
Desc:	allow other processes of the same or higher priority to run if they
	  are ready
Note:	if DX=FFFFh, a dispatch is forced even if no other process is ready
SeeAlso: INT E0/CL=91h
--------O-E0----CL91-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "P_PRIORITY" - SET PROCESS PRIORITY
	CL = 91h
	DL = new priority (00h highest to FFh lowest)
Note:	sets priority of calling process; transient processes are initialized
	  to priority C8h
SeeAlso: INT E0/CL=8Eh
--------O-E0----CL93-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "C_DETACH" - DETACH FROM DEFAULT CONSOLE
	CL = 93h
Return: AX = status
	    0000h successfully detached
	    FFFFh detach failed
SeeAlso: INT E0/CL=A6h
--------O-E0----CLA5-------------------------
INT E0 - DR Multiuser DOS - "A_ATTACH" - ATTACH AUX DEVICE
	CL = A5h
Desc:	attaches the default auxiliary device to the calling process unless
	  it is already attached to another process, in which case the call
	  blocks until the device becomes available
Note:	this call should be used before attempting to read or write from
	  the AUX device; however, the I/O calls internally call this function
	  to ensure device ownership
SeeAlso: INT E0/CL=03h,INT E0/CL=04h,INT E0/CL=A6h,INT E0/CL=A7h,INT E0/CL=A8h
SeeAlso: INT E0/CL=ACh,INT E0/CL=ADh,INT E0/CL=B0h
--------O-E0----CLA6-------------------------
INT E0 - DR Multiuser DOS - "A_DETACH" - DETACH FROM AUX DEVICE
	CL = A6h
Return: AX = status
	    0000h successfully detached
	    FFFFh detach failed
	CX = error code
SeeAlso: INT E0/CL=93h,INT E0/CL=A5h,INT E0/CL=A7h
--------O-E0----CLA7-------------------------
INT E0 - DR Multiuser DOS - "A_CATTACH" - CONDITIONALLY ATTACH TO AUX DEVICE
	CL = A7h
Return: AX = status
	    0000h attached
	    FFFFh unable to attach
Desc:	attaches the default auxiliary device to the calling process if it is
	  available
Note:	does not block if the device is already in use
SeeAlso: INT E0/CL=A5h,INT E0/CL=A6h,INT E0/CL=A8h,INT E0/CL=B0h
--------O-E0----CLA8-------------------------
INT E0 - DR Multiuser DOS - "A_SET" - SET DEFAULT AUX DEVICE NUMBER
	CL = A8h
	DL = auxiliary device number
Return: AX = status
	    0000h successful
	    FFFFh failed
	CX = error code
Desc:	specify which physical device will become AUX
SeeAlso: INT E0/CL=A5h,INT E0/CL=A9h
--------O-E0----CLA9-------------------------
INT E0 - DR Multiuser DOS - "A_GET" - GET DEFAULT AUX DEVICE NUMBER
	CL = A9h
Return: AL = current default auxiliary device number
Desc:	determine which physical device is currently AUX
SeeAlso: INT E0/CL=A8h
--------O-E0----CLAC-------------------------
INT E0 - DR Multiuser DOS - "A_READBLK" - READ STRING FROM AUX DEVICE
	CL = ACh
	DS:DX -> character control block (CHCB) (see #2156)
Return: AX = number of characters read
Desc:	read characters from the default auxiliary (AUXn:) device into a buffer
	  until the buffer is full or the device is no longer ready
Notes:	if the device is initially not ready, blocks until at least one
	  character has been read
	if another process owns AUX, this call blocks until the device becomes
	  available
SeeAlso: INT E0/CL=03h,INT E0/CL=A5h,INT E0/CL=ADh

Format of DR Multiuser DOS character control block (CHCB):
Offset	Size	Description	(Table 2156)
 00h	DWORD	pointer to character buffer
 04h	WORD	length of character buffer
--------O-E0----CLAD-------------------------
INT E0 - DR Multiuser DOS - "A_WRITEBLK" - WRITE STRING TO AUX DEVICE
	CL = ADh
	DS:DX -> character control block (see INT E0/CL=ACh)
Return: AX = number of characters written
Note:	does not return until at least one character has been written
SeeAlso: INT E0/CL=04h,INT E0/CL=A5h,INT E0/CL=ACh
--------O-E0----CLB0-------------------------
INT E0 - DR Multiuser DOS - "A_CONFIG" - GET/SET AUX DEVICE PARAMETERS
	CL = B0h
	DX:DX -> AUX device parameter block (see #2157)
Return: AX = status
	    0000h successful
		parameter block updated
	    FFFFh failed
		CX = error code
SeeAlso: INT E0/CL=A5h,INT E0/CL=B1h

Format of DR Multiuser DOS AUX device parameter block:
Offset	Size	Description	(Table 2157)
 00h	BYTE	function (00h get, 01h set)
 01h	BYTE	baud rate (see #2159) FFh = don't change/unknown
 02h	BYTE	parity (see #2158)
 03h	BYTE	stop bits (00h one, 01h 1.5, 02h two, FFh unknown/don't change)
 04h	BYTE	data bits (05h-08h or FFh unknown/don't change)
 05h	BYTE	handshake (00h none, 01h DTS/DSR, 02h RTS/CTS, 04h XON/XOFF,
		FFh unknown/don't change)
 06h	BYTE	XON character, FFh unknown/don't change
 07h	BYTE	XOFF character, FFh unknown/don't change

(Table 2158)
Values for parity:
 00h	none
 01h	odd
 02h	none
 03h	even
 04h	stick parity bit
 FFh	don't change/unknown

(Table 2159)
Values for baud rate:
 00h	50 baud
 01h	62.5 baud
 02h	75 baud
 03h	110 baud
 04h	134.5 baud
 05h	150 baud
 06h	200 baud
 07h	300 baud
 08h	600 baud
 09h	1200 baud
 0Ah	1800 baud
 0Bh	2000 baud
 0Ch	2400 baud
 0Dh	3600 baud
 0Eh	4800 baud
 0Fh	7200 baud
 10h	9600 baud
 11h	19200 baud
 12h	38400 baud
 13h	56000 baud
 14h	76800 baud
 15h	115200 baud
--------O-E0----CLB1-------------------------
INT E0 - DR Multiuser DOS - "A_CONTROL" - GET/SET AUX CONTROL PARAMETERS
	CL = B1h
	DS:DX -> AUX device control block (see #2160)
Return: AX = status
	    0000h successful
		control block updated
	    FFFFh failed
		CX = error code
SeeAlso: INT E0/CL=B0h,INT E0/CL=B2h

Format of DR Multiuser DOS AUX device control block:
Offset	Size	Description	(Table 2160)
 00h	BYTE	function (00h get, 01h set)
 01h	BYTE	DTR state (00h low, 01h high, FFh unknown/don't change)
 02h	BYTE	RTS state (00h low, 01h high, FFh unknown/don't change)
 03h	BYTE	DSR state (00h low, 01h high, FFh unknown/don't change)
 04h	BYTE	CTS state (00h low, 01h high, FFh unknown/don't change)
 05h	BYTE	DCD state (00h low, 01h high, FFh unknown/don't change)
 06h	BYTE	RI state (00h inactive, 01h active, FFh unknown/don't change)
--------O-E0----CLB2-------------------------
INT E0 - DR Multiuser DOS - "A_BREAK" - SEND BREAK TO AUX DEVICE
	CL = B2h
	DX = duration of break in system ticks (0001h-FFFFh)
Return: AX = status
	    0000h successful
		break signal completed
	    FFFFh failed
		CX = error code
Note:	if the AUX device is currently owned by another process, this call will
	  block until the device becomes available
SeeAlso: INT E0/CL=A5h,INT E0/CL=B1h
--------O-E0----CLBD-------------------------
INT E0 - DR Multiuser DOS - "P_DELAY" - DELAY EXECUTION
	CL = BDh
	DX = delay in system ticks
Return: after the delay elapses
Notes:	the length of a system tick is installation-dependent (typically
	  1/50 or 1/60 second); the length may be determined by reading the
	  TICKSPERSEC value from the system data segment
	the actual delay before the process is rescheduled to run may be up to
	  one tick longer than requested; the delay between rescheduling and
	  actual execution cannot be predicted if higher-priority processes
	  are awaiting a turn at the CPU
SeeAlso: INT 15/AH=86h,INT 1A/AX=FF01h,INT 2F/AX=1224h,INT 62/AX=0096h
--------g-E00000-----------------------------
INT E0 - PCROBOTS v1.41 - "SWAPTASK" - END CURRENT ROBOT'S TURN
	AX = 0000h
Program: PCROBOTS is P.D. Smith's adaptation of Tom Poindexter's CROBOTS, in
	  which specially-written .COM or .EXE programs form robots battling
	  each other in a user-defined arena
--------g-E00001-----------------------------
INT E0 - PCROBOTS v1.41 - "MOVEMENT" - START MOVING
	AX = 0001h
	BX = speed (0-maximum for robot)
	CX = direction (0-359 degrees)
Notes:	the speed will change to the specified value at the maximum
	  acceleration the robot is capable of; if the robot is already moving
	  faster than its maximum maneuverability speed, it will not be able
	  to change direction
	this call also terminates the current robot's turn
SeeAlso: AX=0000h,AX=0002h,AX=0003h
--------g-E00002-----------------------------
INT E0 - PCROBOTS v1.41 - "SCAN" - SCAN FOR OTHER ROBOTS IN THE GIVEN DIRECTION
	AX = 0002h
	BX = direction (0-359 degrees)
	CX = resolution (0-45 degrees)
Return: AX = status
	    FFFFh if nothing detected
	    else robot ID (0-19)
		BX = range to detected robot
Notes:	the scan searches within CX degrees to either side of the specified
	  direction
	the scanner will see right through walls, but shells will not pass
	  through walls
	this call also terminates the current robot's turn
SeeAlso: AX=0000h,AX=0001h,AX=0003h
--------g-E00003-----------------------------
INT E0 - PCROBOTS v1.41 - "SHOOT" - FIRE A SHELL AT ANOTHER ROBOT
	AX = 0003h
	BX = direction (0-359 degrees)
	CX = range (0-700)
Return: AX = status (0000h not fired, else ID of shell fired)
Notes:	up to seven shells may be in flight for a robot at one time; the cannon
	  takes 50 ticks to reload
	this call also terminates the current robot's turn
SeeAlso: AX=0000h,AX=0001h,AX=0002h,AX=002Ch
--------g-E00010-----------------------------
INT E0 - PCROBOTS v1.41 - "GETXY" - GET ROBOT'S CURRENT POSITION
	AX = 0010h
Return: BX = current X coordinate (0-999)
	CX = current Y coordinate (0-999)
--------g-E00011-----------------------------
INT E0 - PCROBOTS v1.41 - "TRANSMIT" - SEND DATA TO ANOTHER ROBOT
	AX = 0011h
	BX = target robot ID
	CX = data to be sent
Return: AX = status (0000h data could not be sent, 0001h data sent)
Note:	this call costs one unit of battery power
--------g-E00012-----------------------------
INT E0 - PCROBOTS v1.41 - "RECEIVE" - GET DATA FROM OTHER ROBOTS
	AX = 0012h
Return: AX = status
	    0000h no data available
	    0001h data retrieved
		BX = sender's ID
		CX = data
Note:	each robot has a 20-word receive FIFO; if the FIFO is full, other
	  robots will be unable to send more data until some is read
--------g-E00013-----------------------------
INT E0 - PCROBOTS v1.41 - "DAMAGE" - DETERMINE HOW MUCH DAMAGE SUSTAINED
	AX = 0013h
Return: BX = damage status
Note:	the initial value depends on configuration, but is typically 100; as
	  the robot is damaged, it decreases
--------g-E00014-----------------------------
INT E0 - PCROBOTS v1.41 - "SPEED" - DETERMINE HOW FAST ROBOT IS MOVING
	AX = 0014h
Return: BX = current speed
--------g-E00015-----------------------------
INT E0 - PCROBOTS v1.41 - "BATTERY" - DETERMINE HOW MUCH BATTERY POWER LEFT
	AX = 0015h
Return: BX = current battery charge
Note:	the battery starts off with 1000 units of charge, and is constantly
	  being charged by solar panels and constantly discharged by motion;
	  the battery is charged at 4 units per turn and discharged at
	  0.1*speed units per turn.
--------g-E00016-----------------------------
INT E0 - PCROBOTS v1.41 - "TICKS" - DETERMINE HOW LONG SINCE GAME STARTED
	AX = 0016h
Return: BX:CX = number of game ticks elapsed (not related to real time)
--------g-E00017-----------------------------
INT E0 - PCROBOTS v1.41 - "L_SIN" - GET SCALED SINE OF AN ANGLE
	AX = 0017h
	BX = angle (0-359 degrees)
Return: BX:CX = 100000*sine of angle
SeeAlso: AX=0018h,AX=0019h,AX=001Ah,AX=001Bh
--------g-E00018-----------------------------
INT E0 - PCROBOTS v1.41 - "L_COS" - GET SCALED COSINE OF AN ANGLE
	AX = 0018h
	BX = angle (0-359 degrees)
Return: BX:CX = 100000*cosine of angle
SeeAlso: AX=0017h,AX=0019h,AX=001Ah
--------g-E00019-----------------------------
INT E0 - PCROBOTS v1.41 - "L_TAN" - GET SCALED TANGENT OF AN ANGLE
	AX = 0019h
	BX = angle (0-359 degrees)
Return: BX:CX = 100000*tangent of angle
SeeAlso: AX=0017h,AX=0018h,AX=001Ah
--------g-E0001A-----------------------------
INT E0 - PCROBOTS v1.41 - "L_ATAN" - GET ANGLE GIVEN SCALED TANGENT
	AX = 001Ah
	BX:CX = 100000*tangent of an angle
Return: AX = angle (-90 to +90 degrees)
SeeAlso: AX=0017h,AX=0018h,AX=0019h
--------g-E0001B-----------------------------
INT E0 - PCROBOTS v1.41 - "SQRT" - DETERMINE SQUARE ROOT OF A NUMBER 
	AX = 001Bh
	BX:CX = value
Return: BX:CX = square root
SeeAlso: AX=0017h
--------g-E0001C-----------------------------
INT E0 - PCROBOTS v1.41 - "SET_PATTERN" - SPECIFY ROBOT'S DISPLAY IMAGE
	AX = 001Ch
	BX:CX -> pattern array
Note:	the pattern array consists of five bytes, the low five bits of each
	  specifying the bit pattern for one line of the robot's screen display
--------g-E0001D-----------------------------
INT E0 - PCROBOTS v1.41 - "DEBUG_FLAG" - SET/CLEAR MARKERS NEXT TO ROBOT'S NAME
	AX = 001Dh
	BX = flag number (0 or 1)
	CX = new value (0 reset, 1 set)
Program: PCROBOTS is P.D. Smith's adaptation of Tom Poindexter's CROBOTS, in
	  which specially-written .COM or .EXE programs form robots battling
	  each other in a user-defined arena
Note:	the two flag markers may be used for any purpose, typically for
	  debugging to provide a visual display of progress
--------g-E0001E-----------------------------
INT E0 - PCROBOTS v1.41 - "BUY_ARMOUR" - BUY OR SELL ARMOR FOR ROBOT
	AX = 001Eh
	BX = number of armor units to buy (negative to sell)
Note:	each armor unit is worth 50 battery units; the robot's armor rating
	  will not go above its initial rating, so attempts to purchase more
	  will waste battery units
SeeAlso: AX=001Fh
--------g-E0001F-----------------------------
INT E0 - PCROBOTS v1.41 - "BUY_SHELLS" - BUY ADDITIONAL CANNON SHELLS
	AX = 001Fh
	BX = number of shells to buy
Note:	each shell costs ten battery units
SeeAlso: AX=001Eh,AX=0020h
--------g-E00020-----------------------------
INT E0 - PCROBOTS v1.41 - "SHELLS LEFT" - DETERMINE HOW MANY SHELLS ROBOT HAS
	AX = 0020h
Return: BX = number of shells remaining
SeeAlso: AX=001Fh
--------g-E00021-----------------------------
INT E0 - PCROBOTS v1.41 - "GET LOCAL MAP"
	AX = 0021h
	BX:CX -> 81-byte buffer for map
Return: buffer filled with 9x9 area of map centered on robot's position

(Table 2161)
Values for PCROBOTS map squares:
 2Eh '.' empty square
 44h 'D' damaging trap
 52h 'R' refueling point
 58h 'X' wall
--------g-E00022-----------------------------
INT E0 - PCROBOTS v1.41 - "INVISIBILITY" - CONTROL ROBOT'S INVISIBILITY DEVICE
	AX = 0022h
	BX = new state (0000h become visible, 0001h become invisible)
Notes:	this function has no effect if the robot is not capable of invisibility
	the robot can only stay invisible for 100 turns, after which it will
	  automatically become visible; it must also be remain visible for
	  as many turns as it was invisible before it can turn invisible
	  again
SeeAlso: AX=0024h,AX=0080h
--------g-E00023-----------------------------
INT E0 - PCROBOTS v1.41 - "GET_SHELL_STATUS" - FIND OUT WHAT HAPPENED TO SHELL
	AX = 0023h
Return: BX = status of last shell to land
	    0000h missed completely
	    0001h hit a wall
	    0002h hit a robot within 50-square radius
	    0003h hit a robot within 25-square radius
	    0004h hit a robot within 5-square radius
--------g-E00024-----------------------------
INT E0 - PCROBOTS v1.41 - "IS_INVISIBLE" - DETERMINE WHETHER ROBOT IS INVISIBLE
	AX = 0024h
Return: BX = visibility (0000h visible, 0001h invisible)
SeeAlso: AX=0022h,AX=0080h
--------g-E00025-----------------------------
INT E0 - PCROBOTS v1.41 - "L_ATAN2" - GET ARCTANGENT
	AX = 0025h
	BX = Y
	CX = X
Return: AX = angle (arctangent of Y/X)
--------g-E00026-----------------------------
INT E0 - PCROBOTS v1.41 - "GET_ROBOT_ID" - DETERMINE CURRENT ROBOT'S IDENTIFIER
	AX = 0026h
Return: AX = robot ID
--------g-E00027-----------------------------
INT E0 - PCROBOTS v1.41 - "REGISTER_IFF" - REGISTER FRIEND/FOE IDENT STRING
	AX = 0027h
	BX:CX = ASCIZ IFF string
Note:	the IFF string may only be set once
SeeAlso: AX=0028h,AX=0029h
--------g-E00028-----------------------------
INT E0 - PCROBOTS v1.41 - "CHECK_IFF" - QUERY FRIEND/FOE IDENTIFICATION STRING
	AX = 0028h
	BX = robot ID to test
Return: AX = status
	    0000h IFF strings match
	    0001h IFF strings differ or invalid robot ID
SeeAlso: AX=0027h
--------g-E00029-----------------------------
INT E0 - PCROBOTS v1.41 - "REGISTER_NAME" - SPECIFY ROBOT'S NAME
	AX = 0029h
	BX:CX -> ASCIZ name string
Note:	the name may only be set once
SeeAlso: AX=0027h,AX=002Ah
--------g-E0002A-----------------------------
INT E0 - PCROBOTS v1.41 - "FIND_NAME" - SEARCH FOR ROBOT WITH GIVEN NAME
	AX = 002Ah
	BX:CX -> ASCIZ name string
	DX = first ID to check
Return: AX = robot ID or FFFFh if no robot with specified name
SeeAlso: AX=0028h,AX=0029h,AX=002Bh
--------g-E0002B-----------------------------
INT E0 - PCROBOTS v1.41 - "GET_TEAM_ID" - DETERMINE TEAM MEMBERSHIP OF ROBOT
	AX = 002Bh
Return: AX = team ID (0-2) or FFFFh if 'loner'
SeeAlso: AX=0029h
--------g-E0002C-----------------------------
INT E0 - PCROBOTS v1.41 - "GET_ASHELL_STATUS" - FIND OUT WHAT HAPPENED TO SHELL
	AX = 002Ch
	BX = shell ID
Return: AX = status
	    0000h missed completely
	    0001h hit a wall
	    0002h hit a robot within a 50-square radius
	    0003h hit a robot within a 25-square radius
	    0004h hit a robot within a 5-square radius
	    0005h shell not known (too old or not yet fired)
	    0006h shell still in flight
SeeAlso: AX=0003h
--------g-E0002D-----------------------------
INT E0 - PCROBOTS v1.41 - "REGISTER_X" - SELECT AUTOMATIC X POSITION UPDATES
	AX = 002Dh
	BX:CX -> X word variable
Return: AX = status (0001h OK, 0000h problem with address)
Note:	after this call, PCROBOTS will automatically update the specified
	  word whenever the robot moves
SeeAlso: AX=002Eh
--------g-E0002E-----------------------------
INT E0 - PCROBOTS v1.41 - "REGISTER_Y" - SELECT AUTOMATIC Y POSITION UPDATES
	AX = 002Eh
	BX:CX -> Y word variable
Return: AX = status (0001h OK, 0000h problem with address)
Note:	after this call, PCROBOTS will automatically update the specified
	  word whenever the robot moves
SeeAlso: AX=002Dh
--------g-E00080-----------------------------
INT E0 - PCROBOTS v1.41 - "CONFIGURE" - CUSTOMIZE ROBOT
	AX = 0080h
	BX = basic configuration (see #2162)
	CX = advanced configuration (see #2163)
Return: AX = status (0001h OK, 0000h not first call in program)
Program: PCROBOTS is P.D. Smith's adaptation of Tom Poindexter's CROBOTS, in
	  which specially-written .COM or .EXE programs form robots battling
	  each other in a user-defined arena
Notes:	a maximum of ten points may be allocated to the robot; if you attempt
	  to allocate more, some items will be given a value of zero.  If this
	  function is not called, each attribute is set to the default value
	  of 2.
	if the invisibility option is chosen, the robot will start with only
	  900 cannon shells instead of the default 1000

Bitfields for PCROBOTS basic configuration:
Bit(s)	Description	(Table 2162)
 0-3	maximum speed (0-4 = 50,75,100,150,200)
 4-7	maneuverability (0-4 = 20%,35%,50%,75%,100%)
 8-11	cannon range (0-4 = 300,500,700,1000,1500)
 12-15	robot armor (0-4 = 50,75,100,150,200)

Bitfields for PCROBOTS advanced configuration:
Bit(s)	Description	(Table 2163)
 0-2	robot acceleration (0-4 = 5,7,10,15,20)
 3	capable of invisibility
--------r-E1---------------------------------
INT E1 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------N-E1---------------------------------
INT E1 - PC Cluster Disk Server Information
SeeAlso: INT E2
--------r-E2---------------------------------
INT E2 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------N-E2---------------------------------
INT E2 - PC Cluster Program
--------r-E3---------------------------------
INT E3 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-E40005-----------------------------
INT E4 - Logitech Modula v2.0 - MonitorEntry
	AX = 0005h
	BX = priority
SeeAlso: AX=0006h
--------r-E40006-----------------------------
INT E4 - Logitech Modula v2.0 - MonitorExit
	AX = 0006h
SeeAlso: AX=0005h
--------r-E4---------------------------------
INT E4 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-E5---------------------------------
INT E5 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-E6---------------------------------
INT E6 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-E7---------------------------------
INT E7 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-E8---------------------------------
INT E8 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-E9---------------------------------
INT E9 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-EA---------------------------------
INT EA - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-EB---------------------------------
INT EB - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-EC---------------------------------
INT EC - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------N-EC---------------------------------
INT EC - used by Alloy NTNX
--------r-EC---------------------------------
INT EC - Exact - RUNTIME INTERFACE MULTIPLEXOR
	AX = function number (0000h to 0140h)
	STACK:	DWORD address to return to
		any arguments required by function
Return: STACK:	return address popped, but otherwise unchanged
Desc:	this is the interface from applications to the runtime system by Exact
	  Automatisering B.V. of the Netherlands.  By using this interrupt,
	  it can provide DLL-style capabilities under MS-DOS.
Note:	the interrupt handler removes the return address and flags placed on
	  the stack by the INT EC, then jumps to the appropriate function
--------r-ED---------------------------------
INT ED - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
	INT 80 through INT ED are modified but not restored by Direct Access
	  v4.0, and may be left dangling by other programs written with the
	  same version of compiled BASIC
SeeAlso: INT EC"BASIC",INT EE"BASIC"
--------r-EE---------------------------------
INT EE - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT ED"BASIC",INT EE"BASIC"
--------r-EF---------------------------------
INT EF - BASIC - ORIGINAL INT 09 VECTOR
Note:	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT EE"BASIC",INT F0"BASIC"
--------O-EF----CX0473-----------------------
INT EF - GEM - INTERFACE
	CX = 0473h
	DS:DX -> GEM parameter block
--------r-F0---------------------------------
INT F0 - BASICA.COM, GWBASIC, compiled BASIC - ORIGINAL INT 08 VECTOR
Note:	BASICA.COM does not restore vector on termination
SeeAlso: INT EF"BASIC"
--------*-F1---------------------------------
INT F1 - reserved for user interrupt
--------s-F1---------------------------------
INT F1 - SPEECH.COM - CONVERT TEXT STRING TO SPEECH
	DS:BX -> '$'-terminated text string
Program: SPEECH.COM is a resident text-to-speech converter by Douglas Sisco
--------s-F1---------------------------------
INT F1 - Andy C. McGuire SPEECH.COM/SAY.COM
SeeAlso: INT F2"SPEECH"
--------U-F1---------------------------------
INT F1 - AQUEDUCT, PIPELINE - GET DATA AREA ADDRESS
Return: AX:BX -> data area
Program: AQUEDUCT and PIPELINE are TSRs by James W. Birdsall to connect COM1
	  and COM2 in software
Note:	The installation check consists of testing for the following signature
	  immediately preceding the interrupt handler: "JWBtvv" where 't' is
	  either "A" for AQUEDUCT or "P" for PIPELINE and "vv" is a two-digit
	  version number
Index:	installation check;AQUEDUCT|installation check;PIPELINE
--------N-F1---------------------------------
INT F1 - NetWare Remote Boot - INSTALLATION CHECK (NOT A VECTOR!)
Note:	if this vector contains the value 5774654Eh ("NetW"), the remote boot
	  BIOS extension is active, and access to the floppy disk is redirected
	  to an image file in the server's SYS:LOGIN directory
--------v-F1---------------------------------
INT F1 - VIRUS - "Violetta" - ???
Note:	used but not chained by virus
SeeAlso: INT E0"VIRUS",INT FF"VIRUS"
--------*-F2---------------------------------
INT F2 - reserved for user interrupt
--------s-F2---------------------------------
INT F2 - Andy C. McGuire SPEECH.COM/SAY.COM
SeeAlso: INT F1"SPEECH"
----------F2---------------------------------
INT F2 - ICCTSR 1.0 - ImageCapture COLOR Developer's Kit - API
	AH = function number (see #2164)
	???
Return: ???
Program: ImageCapture is a product of International Computers
SeeAlso: INT F3"ICCTSR"

(Table 2164)
Values for ImageCapture function:
 01h	power up
 02h	power down
 03h	set controls
 04h	capture image
 05h	display image
 06h	read file
 07h	write file
 08h	write array
 09h	read pixel
 0Ah	write pixel
 0Bh	check if VGA present
 0Ch	set video mode
 0Dh	check for keystroke
 0Eh	delay
--------*-F3---------------------------------
INT F3 - reserved for user interrupt
--------s-F3---------------------------------
INT F3 - SoundBlaster - POINTER TO ECHO VALUE
Note:	this is not a vector, but a pointer to a DWORD containing the echo
	  value selected with SET-ECHO.EXE
SeeAlso: INT 2F/AX=FBFBh
----------F3---------------------------------
INT F3 - ICCTSR 1.0 - HANDSHAKE ID VECTOR
Program: ImageCapture is a product of International Computers
SeeAlso: INT F2"ICCTSR"
--------*-F4---------------------------------
INT F4 - reserved for user interrupt
--------T-F4---------------------------------
INT F4 - DoubleDOS - GIVE UP REST OF CURRENT CLOCK TICK AND ALL OF NEXT TICK
SeeAlso: INT 21/AH=EEh"DoubleDOS",INT FE"DoubleDOS"
--------*-F5---------------------------------
INT F5 - reserved for user interrupt
--------T-F5---------------------------------
INT F5 - DoubleDOS - ???
--------*-F6---------------------------------
INT F6 - reserved for user interrupt
--------T-F6---------------------------------
INT F6 - DoubleDOS - ???
--------*-F7---------------------------------
INT F7 - reserved for user interrupt
--------T-F7---------------------------------
INT F7 - DoubleDOS - ???
----------F700-------------------------------
INT F7 - FSBBS 2.0 - CONFIGURATION RECORD
	AH = 00h
	AL = function
	    00h get configuration record
		Return: DS:DX -> configuration record
	    01h set configuration record
	    02h get path for option
		DS:DX -> option name
		Return: DS:DX -> path
	    03h determine whether configuration record set
		Return: AX = status
			    0000h set
			    0001h not yet set
	    04h get link state
		Return: AX = state
			    0000h unlinked
			    0001h linked
Notes:	this information is preliminary and still subject to change
	all of the INT F7 calls for FSBBS are used for interprogram
	  communication between the BBS kernel and the programs it spawns
SeeAlso: AH=01h
----------F701-------------------------------
INT F7 - FSBBS 2.0 - USER RECORD
	AH = 01h
	AL = function
	    00h get user record for user currently online
		Return: DS:DX -> user record
	    01h set user record
		DS:DX -> user record
SeeAlso: AH=00h,AH=02h
----------F702-------------------------------
INT F7 - FSBBS 2.0 - GET ACCOUNT NAME
	AH = 02h
Return: DS:DX -> 8-character blank-padded account name
SeeAlso: AH=01h
----------F703-------------------------------
INT F7 - FSBBS 2.0 - TERMINAL NUMBER
	AH = 03h
	AL = function
	    00h get terminal index number
		Return: DX = index number
	    01h set terminal index number
		DX = terminal index
----------F704-------------------------------
INT F7 - FSBBS 2.0 - PASSDATA BUFFER
	AH = 04h
	AL = function
	    00h get PassData buffer contents
		DS:DX -> buffer for PassData contents
	    01h set PassData contents
		DS:DX -> buffer containing new PassData
		CH = length of data in buffer
----------F705-------------------------------
INT F7 - FSBBS 2.0 - TIMER FUNCTIONS
	AH = 05h
	AL = function
	    00h get time remaining
		Return: DX = number of minutes remaining
	    01h get current time
		Return: DS:DX -> 8-character time string
	    02h increment time
		DX = number of additional minutes
	    03h decrement time
		DX = number of minutes
SeeAlso: AH=06h
----------F706-------------------------------
INT F7 - FSBBS 2.0 - FUNCTION AVAILABILITY
	AH = 06h
	AL = function
	    00h determine whether function is available
		DX = index of function
	    01h set function availability
		DX = index of function
		???
SeeAlso: AH=05h,AH=07h
----------F707-------------------------------
INT F7 - FSBBS 2.0 - DUMP FUNCTIONS
	AH = 07h
	AL = function
	    00h get current dump mode
		Return: DL = mode
	    01h set dump mode
		DL = mode
SeeAlso: AH=06h
--------*-F8---------------------------------
INT F8 - reserved for user interrupt
--------h-F8---------------------------------
INT F8 - TANDY??? - 100 HZ INTERRUPT
Note:	this vector is not used on the Tandy 1000TL
SeeAlso: INT FA"USART"
--------T-F8---------------------------------
INT F8 - DoubleDOS - ???
--------*-F9---------------------------------
INT F9 - reserved for user interrupt
--------T-F9---------------------------------
INT F9 - DoubleDOS - ???
--------*-FA---------------------------------
INT FA - reserved for user interrupt
--------h-FA---------------------------------
INT FA - TANDY??? - SERIAL PORT USART INTERRUPT
Note:	this vector is not used on the Tandy 1000TL
SeeAlso: INT F8"100 HZ",INT FB"USART"
--------T-FA---------------------------------
INT FA - DoubleDOS - TURN OFF TIMESHARING
SeeAlso: INT 21/AH=EAh"DoubleDOS",INT FB"DoubleDOS"
--------*-FB---------------------------------
INT FB - reserved for user interrupt
--------h-FB---------------------------------
INT FB - TANDY??? - KEYBOARD USART RECEIVE INTERRUPT
SeeAlso: INT FA"USART"
--------T-FB---------------------------------
INT FB - DoubleDOS - TURN ON TIMESHARING
SeeAlso: INT 21/AH=EBh"DoubleDOS",INT FA"DoubleDOS"
--------*-FC---------------------------------
INT FC - reserved for user interrupt
--------T-FC---------------------------------
INT FC - DoubleDOS - GET CURRENT SCREEN BUFFER ADDRESS
Return: ES = segment of display buffer
Desc:	determine the address of the virtual screen to which the program
	  should write instead of the actual video memory, so that the
	  multitasked programs do not interfere with each other's output
Note:	the display buffer may be moved if multitasking is enabled
SeeAlso: INT 21/AH=ECh"DoubleDOS",INT FB"DoubleDOS"
--------*-FD---------------------------------
INT FD - reserved for user interrupt
--------T-FD---------------------------------
INT FD - DoubleDOS - ???
--------S-FD---------------------------------
INT FD - TFPCX - INSTALLATION CHECK
	AH = function (see separate entries below)
Program: TFPCX is an interface between modem and terminal program for packet-
	  radio communications
Notes:	the installation check consists of testing for the string "N5NX" three
	  bytes beyond the interrupt handler; INT FD is the default, but may
	  be changed, so the full installation check consists of scanning
	  for the signature
	TFPCX returns AX=FFFFh on any unsupported function call
SeeAlso: AH=01h,AH=03h,AH=FEh
--------S-FD01-------------------------------
INT FD - TFPCX - TEST FOR CHARACTER WAITING
	AH = 01h
Return: AX = status
	    0000h no characters waiting
	    0001h character available for input
Program: TFPCX is an interface between modem and terminal program for packet-
	  radio communications
SeeAlso: AH=02h
--------S-FD02-------------------------------
INT FD - TFPCX - GET CHARACTER
	AH = 02h
Return: AL = character
Notes:	this call is only allowed if AH=01h indicated that a character is
	  available
	all available characters should be read before sending any additional
	  characters
SeeAlso: AH=01h,AH=03h
--------S-FD03-------------------------------
INT FD - TFPCX - OUTPUT CHARACTER
	AH = 03h
	AL = character to send
SeeAlso: AH=02h
--------S-FDFE-------------------------------
INT FD - TFPCX - GET VERSION
	AH = FEh
Return: AH = major version
	AL = minor version
Program: TFPCX is an interface between modem and terminal program for packet-
	  radio communications
SeeAlso: AH=01h,AH=03h
--------B-FE---------------------------------
INT FE - AT/XT286/PS50+ - destroyed by return from protected mode
Note:	the ROM BIOS uses 0030h:0100h as the initial stack on startup, which
	  is the last fourth of the interrupt vector table.  If the processor
	  is returned to real mode via a hardware reset (the only possibility
	  on an 80286, though there are a number of ways of generating one),
	  then the BIOS startup code stacks three words on its scratch stack
	  before determining that a return to real mode has been requested.
	  As a result, INT FE and INT FF are corrupted.
SeeAlso: INT FF"XT286"
--------T-FE---------------------------------
INT FE - DoubleDOS - GIVE UP TIME
	AL = number of 55ms time slices to give away
Return: after other program (if active) has run
SeeAlso: INT 21/AH=EEh"DoubleDOS",INT F4"DoubleDOS"
--------G-FE---------------------------------
INT FE - Turbo Debugger 8086 v2.5+ - OVERLAY MANAGER
SeeAlso: INT 3F
--------B-FF---------------------------------
INT FF - AT/XT286/PS50+ - destroyed by return from protected mode
Note:	(see INT FE"XT286")
SeeAlso: INT FE"XT286"
--------b-FF---------------------------------
INT FF - Z100 - WARM BOOT
SeeAlso: INT 40"Z100"
--------Q-FF---------------------------------
INT FF U - QEMM-386.SYS v6.0+ - internal
Notes:	requires that a byte in the conventional-memory stub be set to the
	  desired function number (00h through 0Ch)

(Table 2165)
Values for QEMM internal functions:
 00h	reflect back to Virtual86-mode interrupt handler (default)
 01h	???
 02h	access DR7???
 03h	QPI upcall (see INT 67/AH=3Fh)
 04h	???
 05h	???
 06h	INT 15/AH=87h
 07h	EMS services (see INT 67/AH=40h-5Dh)
 08h	???
 09h	QEMM exception handler
 0Ah	XMS services (see INT 2F/AX=4310h)
 0Bh	Virtual DMA Services (see INT 4B/AX=8102h)
 0Ch	???
--------v-FF---------------------------------
INT FF - VIRUS - "Violetta" - ???
Note:	used but not chained by virus
SeeAlso: INT E0"VIRUS",INT F1"VIRUS"
--------!---Admin----------------------------
Highest Table Number = 2176
--------!---FILELIST-------------------------
Please redistribute all of the files comprising the interrupt list (listed at
the beginning of the list and in INTERRUP.1ST) unmodified as a group, in a
trio of archives named INTER41A through INTER41C (preferably the original
authenticated PKZIP archives), and the utility programs in a fourth archive
called INTER41D.ZIP

This compilation is Copyright (c) 1989,1990,1991,1992,1993,1994 Ralf Brown
--------!---CONTACT_INFO---------------------
Internet: ralf@telerama.lm.com
UUCP: {uunet,harvard}!telerama.lm.com!ralf
FIDO: Ralf Brown 1:129/26.1
	or post a message to me in the DR_DEBUG echo (I probably won't see it
	unless you address it to me)
CIS:  >INTERNET:ralf@telerama.lm.com
