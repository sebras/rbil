Interrupt List, part 8 of 12
This compilation is Copyright (c) 1989,1990,1991,1992,1993,1994,1995 Ralf Brown
--------N-2F7A00-----------------------------
INT 2F - Novell NetWare - LOW-LEVEL API (IPX) INSTALLATION CHECK
	AX = 7A00h
Return: AL = status
	    00h not installed
	    FFh installed
		ES:DI -> FAR entry point for routines accessed exclusively
			  through INT 7A in NetWare versions through 2.0a.
			  Call with same values as INT 7A
		ES:BX -> two bytes containing IPX major/minor version
			(IPXODI v2.12; BX unchanged by older IPX drivers)
SeeAlso: AX=7AFFh/BX=0000h,AX=D800h,INT 64"Novell",INT 7A"Novell"
--------N-2F7A10-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET TBMI STATUS
	AX = 7A10h
Return: DH = major TBMI version number
	DL = minor TBMI version number (01h for v1.1)
	CX = segment address of TBMI resident part
	BX = status word of TBMI (see #1569)
Note:	TBMI is the Task-Switched Buffer Manager Interface
SeeAlso: AX=7A11h,AX=7A12h,AX=7A13h,AX=7A14h

Bitfields for NetWare TBMI status word:
Bit(s)	Description	(Table 1569)
 0	INT2F intercepted by TBMI
 1	INT7A intercepted by TBMI
 2	INT64 intercepted by TBMI
 3-14	reserved or unused ???
 15	outstanding task ID was detected
--------N-2F7A11-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET INT2F HANDLERS
	AX = 7A11h
Return: ES:BX -> old INT 2F handler
	DS:DX -> TBMI INT 2F handler
SeeAlso: AX=7A10h,AX=7A12h,AX=7A13h,AX=7A1Ah
--------N-2F7A12-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET INT64 HANDLERS
	AX = 7A12h
Return: ES:BX -> old INT 64 handler
	DS:DX -> TBMI INT 64 handler
SeeAlso: AX=7A10h,AX=7A11h,AX=7A13h
--------N-2F7A13-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET INT7A HANDLERS
	AX = 7A13h
Return: ES:BX -> old INT 7A handler
	DS:DX -> TBMI INT 7A handler
SeeAlso: AX=7A10h,AX=7A11h,AX=7A12h
--------N-2F7A14-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET STATISTICS
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
Return: BX = maximum supported subfunction (000Ch)
SeeAlso: AX=7A10h
--------N-2F7A15-----------------------------
INT 2F OU - Novell NetWare - TBMI v1.1 only - RESET ???
	AX = 7A15h
Return: BX = new value of ???
Desc:	set ??? to its default value
Note:	this call is a NOP under TBMI v2.0 (TBMI2)
SeeAlso: AX=7A17h
--------N-2F7A16-----------------------------
INT 2F OU - Novell NetWare - TBMI v1.1 only - ???
	AX = 7A16h
	CX = ???
	???
Return: ???
Note:	this call is a NOP under TBMI v2.0 (TBMI2)
--------N-2F7A17-----------------------------
INT 2F OU - Novell NetWare - TBMI v1.1 only - ???
	AX = 7A17h
	???
Return: BX = old value of ???
	CX = new value of ???
Note:	this call is a NOP under TBMI v2.0 (TBMI2)
SeeAlso: AX=7A15h
--------N-2F7A18-----------------------------
INT 2F U - Novell NetWare - TASKID v1.0 - INSTALLATION CHECK
	AX = 7A18h
Return: AL = FFh if installed
	    BX = configuration flags (see #1570)
	    CX = resident code segment
SeeAlso: AX=7A10h

Bitfields for NetWare TASKID configuration flags:
Bit(s)	Description	(Table 1570)
 0	INT 2F hooked
 3	INT 08 hooked
 other	unused
--------N-2F7A19-----------------------------
INT 2F U - Novell NetWare - TASKID v1.0 - GET INT 08 HANDLERS
	AX = 7A19h
Return: AL = FFh
	DS:DX -> TASKID INT 08 handler
	ES:BX -> original INT 08 handler
--------N-2F7A1A-----------------------------
INT 2F U - Novell NetWare - TASKID v1.0 - GET INT 2F HANDLERS
	AX = 7A1Ah
Return: AL = FFh
	DX:DX -> TASKID INT 2F handler
	ES:BX -> original INT 2F handler
SeeAlso: AX=7A11h,AX=7A19h
--------N-2F7A1B-----------------------------
INT 2F U - Novell NetWare - TASKID v1.0 - GET DIAGNOSTICS INFORMATION
	AX = 7A1Bh
	CX = desired information
	    0000h supported functions
	    0001h TASKID ID number
		Return: CX = ID number
	    0002h set-ID count
		Return: CX = ID set count
Return: AL = FFh
	BX = highest supported subfunction number (0002h)
SeeAlso: AX=7A14h,AX=7A18h
--------N-2F7A1C-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - ???
	AX = 7A1Ch
	BP = ???
	CX:DX = ???
Return: AX = 70FFh
--------N-2F7A1D-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - ???
	AX = 7A1Dh
	???
Return: ES = ???
	???
	SI destroyed
--------N-2F7A1E-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - ???
	AX = 7A1Eh
	ES:SI -> ???
	???
Return: ???
--------N-2F7A20BX0000-----------------------
INT 2F - Novell NetWare - Adv NetWare 4.0 DOS Requester - GET VLM CALL ADDRESS
	AX = 7A20h
	BX = 0000h
Return: AX = 0000h on success (installed)
	    ES:BX -> far call address for DOS Requester (see #1571)
Notes:	the DOS Requester replaces the NetWare Shell (ANETx, NETx) on
	  NetWare LAN's as of the release of Advanced NetWare 4.0 (1993).  It
	  is backward compatible with NetWare 2.1x through 3.11 servers as
	  well.	 Note that there was a NetWare 4.0 in the early 1980's, which
	  can cause confusion.
	this call is used as the installation check by VLM.EXE, which is the
	  loader for all the modules of the DOS Requester
	.VLMs are standard old .EXE format executables whose normal entry point
	  merely terminates to prevent loading from the command line.  The
	  real entry point is found by looking at the VLM header at the
	  beginning of the load image (see #1574)
Index:	installation check;NetWare 4.0 DOS Requester

(Table 1571)
Call DOS Requester entry point with:
	STACK:	WORD	destination function
		WORD	destination VLM ID (see #1573)
		WORD	source VLM ID (0000h = application program)
	registers as appropriate for function
Return: AX = status code (0000h,8811h,8846h,8848h,8853h) (see #1572)
	other registers as appropriate for function
	STACK popped

(Table 1572)
Values for VLM status code:
 0000h	successful
 88xxh	error generated by requester
 8801h	invalid or non-attached connection handle
 8803h	cannot add CDS
 8804h	bad path
 8811h	nonexistent function called
 8836h	attempted function with invalid parameter
 8846h	???
 8848h	non-loaded or nonexistent VLM called
 884Dh	no more SFT entries (too many handles)
 8850h	too many reply fragments
 8853h	???
 89xxh	error generated by server, low byte = return code from server

(Table 1573)
Values for VLM identifier:
 0001h	VLM.EXE		Virtual Loadable Modules manager (see also #1575)
 0010h	CONN.VLM	connection table manager (see also #1576)
 0020h	TRAN.VLM	transport protocol multiplexor (see also #1578)
 0021h	IPXNCP.VLM	transport protocol implementation using IPX (see #1580)
 0022h	reserved for TCPNCP.VLM
 0030h	NWP.VLM		NetWare protocol multiplexor (see also #1581)
 0031h	BIND.VLM
 0032h	NDS.VLM		NetWare Directory Services (see also #1582)
 0033h	PNW.VLM		Personal NetWare
 0034h	RSA.VLM		RSA encryption for directory services re-authentication
 0040h	REDIR.VLM	DOS redirector (see also #1583)
 0041h	FIO.VLM		file I/O (see also #1585)
 0042h	PRINT.VLM	printer redirector (see also #1586)
 0043h	GENERAL.VLM	misc functions for NETx and REDIR (see also #1587)
 0050h	NETX.VLM	NetWare shell compatibility (see also #1588)
 0060h	AUTO.VLM	auto-reconnect/auto-retry
 0061h	SECURITY.VLM	enhanced security module
 0100h	NMR.VLM		NetWare management responder

Format of VLM header:
Offset	Size	Description	(Table 1574)
 00h	DWORD	-> initialization entry point
 04h	DWORD	-> VLM API entry point
 08h	DWORD	-> ??? entry point
 0Ch	DWORD	-> ??? entry point
 10h	DWORD	-> ??? entry point
	...
 var	DWORD	00000000h (end of entry point list)
      4 BYTEs	signature "NVlm"
	WORD	VLM identifier
Note:	the number of entry points in the header is reported as "Func" in the
	  VLM /D display.

(Table 1575)
Call VLM Manager (VLM.EXE, ID 0001h) with:
Func	Description/Registers
 01h	VLM Statistics

(Table 1576)
Call Connection Manager (CONN.VLM, ID 0010h) with:
Func	Description/Registers
 01h	Conn Get Version
 03h	Conn Statistics
 04h	Conn Alloc Handle
 05h	Conn Validate Handle
	CX = connection handle
	Return: AX = 0000h if valid handle
 06h	Conn Free Handle
 07h	Conn Get Entry Field
	BH = connection parameter (see #1577)
	CX = connection handle
	DX = value if BH is non-array parameter
	DH = offset in array if BH is array parameter
	DL = number of bytes to copy if BH is array
	ES:DI -> return buffer if BH is array
	Return: AX = 0000h if successful
		DX = value if non-array parameter
		DH = maximum number of bytes in buffer if array parameter
		DL = number of bytes copied if array
		BX destroyed
 08h	Conn Set Entry Field
	BH = connection parameter (see #1577)
	CX = connection handle
	DX = value if BH is non-array parameter
	DH = offset in array if BH is array parameter
	DL = number of bytes to copy if BH is array
	DS:SI -> buffer if BH is array
	Return: AX = 0000h if successful
		DH = maximum number of bytes in buffer
		DL = number of bytes copied
		BX destroyed
 09h	Conn Reset Entry Field
	BH = connection parameter (see #1577)
	CX = connection handle
	Return: AX = 0000h if successful
		BX,DX destroyed
 0Ah	Conn Lookup Handle
 0Dh	Conn Name Lookup
	BL = lookup type (00h equal, 40h not equal)
	BH = connection parameter (see #1577)
	CX = connection handle, 0000h if first
	DX = value if BH is non-array parameter
	DH = offset in array if BH is array parameter
	DL = number of bytes to copy if BH is array
	DS:SI -> buffer if BH is array
	Return: AX = 0000h if successful
		CX = handle matching given parameters
 0Eh	Conn Name To Handle
	DS:SI -> uppercased server name
	CX = length of server name, 0000h if ASCIZ name
	Return: AX = error code or 0000h if successful
		    CX = connection handle if successful
 0Fh	Conn Get Num Connections
	Return: DX = number of connections
		CX destroyed

(Table 1577)
Values for NetWare Connection Manager CEI (Connection Entry Information):
 number	flags	description
 00h	FR	error
 1	WL	VLM id of transport protocol (NDS/BIND/PNW)
 2	FR	???
 3	F	authenticated
 4	F	packet burst supported
 5	FR	SFT3 change
 6	FR	???
 7	FR	packet burst reset needed
 8	W	server version
 9	W	???
 0Ah	W	distance to server
 0Bh	W	???
 0Ch	B	NCP sequence number
 0Dh	W	connection number
 0Eh	B	???
 0Fh	WL	VLM id for transport protocol (IPXNCP)
 10h	W	???
 11h	A	transport specific buffer
		12 byte server address
		6 byte	router address
		2 byte round trip time
 12h	FR	broadcast message waiting
 13h	W	large internet packets supported
 14h	B	security options
		01h CRC enabled
		02h packet signing enabled
		20h packet signing active
 15h	W	???
 16h	FR	???
Note:	flag meanings
	    F=flag value
	    B=byte value
	    W=word value
	    A=array
	    R=resettable
	    L=settable only before authentication
	    others=read only
SeeAlso: #1576

(Table 1578)
Call TRAN.VLM (VLM ID 0020h) with:
Func	Description/Registers
 01h	Tran Get Version
 03h	Tran Statistics
 06h	Tran Request Reply (see INT 21/AH=F2h)
	AL = request code (see #1266 at INT 21/AH=F2h)
	BH = error handler flag
	    00h default error handler
	    01h return network errors to caller
	    02h handle network errors in requester
	BL = request list length (max 5 fragments) (see #1579)
	CX = connection handle
	DH = 00h (reserved)
	DL = reply list length (max 5 fragments) (see #1579)
	DS:SI -> address list
	ES:DI -> address list
	Return: AX = error code, 0000h if successful
		BX,DX destroyed
		reply buffer updated if successful
 08h	Tran Schedule/Cancel Event
 09h	Tran Get Max Size
 0Ah	Tran Broadcast Mux

Format of TRAN.VLM request/reply fragment descriptor (array):
Offset	Size	Description	(Table 1579)
 00h	DWORD	address of buffer
 04h	WORD	length of buffer

(Table 1580)
Call IPXNCP.VLM (VLM ID 0021h) with:
Func	Description/Registers
 01h	IPX Get Version
 03h	IPX Statistics
 06h	IPXNCP Request Reply???
	functionally equivalent to Tran Request Reply???

(Table 1581)
Call NWP.VLM (VLM ID 0030h) with:
Func	Description/Registers
 01h	NWP Get Version
 03h	NWP Statistics
 04h	NWP Connect
 05h	NWP Disconnect
 06h	NWP Attach
 08h	NWP Login
 09h	NWP Logout
 0Ah	NWP Get Bindery Object/Get Message Handler
 0Eh	NWP Ordered Send To All
 0Fh	NWP Preferred Handler
 10h	NWP ???
	AL = subfunction
	    01h get security flags (see also INT 21/AX=B301h)
		Return: BX:CX indicates signature level
				= 0100h:0000h if signature level=0
				= 0300h:0000h if signature level=1
				= 0302h:0000h if signature level=2
				= 0302h:0202h if signature level=3
	    02h create session keys (see also INT 21/AX=B302h)
		CX = server connection handle
		DS:SI -> 24-byte input buffer
	    04h set security flags (see also INT 21/AX=B304h)
		BL:CL = new flags
	    06h renegotiate security level (see also INT 21/AX=B306h)
		CX = server connection number (01h-08h)

(Table 1582)
Call NDS.VLM (VLM ID 0032h) with:
Func	Description/Registers
 01h	NDS Get Version
 03h	NDS Statistics
 08h	NDS Fragment Request
 0Ch	NDS ???
	BX = subfunction
	    0000h get default name context
		ES:DI -> output buffer
	    0002h read from TDS
		CX = reply buffer length
		DX = 0110h ???
		SI = offset in TDS
		ES:DI -> reply buffer
	    0003h write to TDS
	    0005h "NWDSChangeResourceConnection/Lock Connection"
		CX = connection handle
		DL = subfunction (00h-09h)
		    04h = NWDSChangeResourceOnConnection
		    07h = NWDSChangeResourceOnConnection
		    08h = NWDSLockConnection
	    0007h "NWDSSetMonitoredConnection"
	    000Ah set NDS CEI Info
		DL = buffer length
		DS:SI -> input buffer

(Table 1583)
Call REDIR.VLM (VLM ID 0040h) with:
Func	Description/Registers
 01h	Redir Get Version
 03h	Redir Statistics
 04h	Redir Build SFT (see INT 21/AH=B4h"NetWare")
	CX = connection handle
	ES:DI -> SFT build request (see #1584)
	Return: AX = 0000h if successful
		    BX = DOS file handle
 05h	Redir DOS To NW Handle
 08h	Redir Specific
	BX = 0000h get item
	    DS:SI -> ASCIZ string "LPTx" (x='1'-'9') or drive spec ("d:")
	    ES:DI -> reply buffer for "\\server\resource",00h,"path",00h

Format of NetWare SFT build request:
Offset	Size	Description	(Table 1584)
 00h  6 BYTEs	NetWare handle
 06h 18 BYTEs	???
 18h	LONG	file size
 1Ch  8 BYTEs	???

(Table 1585)
Call File I/O FIO.VLM (VLM ID 0041h) with:
Func	Description/Registers
 01h	FIO Get Version
 03h	FIO Statistics
 04h	FIO Remote Copy

(Table 1586)
Call PRINT.VLM (VLM ID 0042h) with:
Func	Description/Registers
 01h	Print Get Version
 03h	Print Statistics
 04h	Print Get/Set Data
 05h	Print Open Capture File
 07h	Print Get Num Of Printers
 08h	Print Redirection
	CX = connection handle
	DX = printer (0=LPT1)
	BX = destination
	    0000h redirect device to queue
		AX = length of queue name, 0000h to use queue ID
		DS:SI -> uppercased ASCIZ queue name
		ES:DI -> queue ID, 0000h:0000h to use queue name
	    0003h redirect device to file
		AX = 0000h or 4E57h ('NW')
		ES:DI -> ASCIZ path of file
	Return: AX = 0000h if successful
 09h	Print Flush And Close Job
 0Ch	Print Get/Set Banner Name

(Table 1587)
Call GENERAL.VLM (VLM ID 0043h) with:
Func	Description/Registers
 01h	Gen Get Version
 03h	Gen Statistics
 04h	Gen Get/Set Primary
 09h	Gen Return Drive Info

(Table 1588)
Call NETX.VLM (VLM ID 0050h) with:
Func	Description/Registers
 01h	NetX Get Version
 03h	NetX Statistics

(Table 1589)
Call SECURITY.VLM (VLM ID 0061h) with:
Func	Description/Registers
 04h	???
	AL = subfunction
	    01h compute session key
		DS:SI -> 24-byte input buffer
		ES:DI -> 8-byte output buffer
--------N-2F7A20BX0001-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM CallA ADDRESS
	AX = 7A20h
	BX = 0001h
Return: AX = 0000h if request was handled
	    ES:BX -> CallA entry point (see #1590)

(Table 1590)
Call VLM CallA entry point with:
	AX = function
	    0000h submit
	    0001h cancel (not implemented)
	ES:DI -> Overlay Asynchronous Control Block structure (see #1591)

Format of Overlay Asynchronous Control Block (OACB):
Offset	Size	Description	(Table 1591)
 00h	DWORD	link to next OACB, 0000h:0000h if last
 04h	DWORD	callback address or 0000h:0000h
 08h	BYTE	InUse flag (00h if complete)
 09h	BYTE	flag, reserved for VLM use
 0Ah	WORD	destination VLM
 0Ch	WORD	destination function
 0Eh	WORD	temporary storage for VLM.EXE
 10h  6 BYTEs	reserved
 16h  6 DWORDs	EAX,EBX,ECX,EDX,ESI,EDI
 2Eh  4 WORDs	DS,ES,FS,GS (FS and GS not used)
--------N-2F7A20BX0002-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM MULTIPLEX ADDRESS
	AX = 7A20h
	BX = 0002h
Return: AX = 0000h
	ES:BX -> VLM multiplex entry point (see #1592)
Note:	for v1.10, this function is only available while VLM.EXE is loading
	  the .VLM modules, because ES is destroyed on return

(Table 1592)
Call DOS Requester entry point with:
	BX = function???
	    0000h
		DX = ???
		DI = ???
		BP = ???
	    0002h
		CX = ???
	    0003h
		DX = ???
		BP = ???
	    0006h
		AH = subfunction???
		AL = ???
		STACK: variable (0, 4, 10, 14 bytes seen)
--------N-2F7A20BX0003-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM PARSE API ADDRESS
	AX = 7A20h
	BX = 0003h
Return: AX = 0000h if request was handled
	    ES:BX -> VLM parse API entry point
--------N-2F7A20BX0004-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM MULTICAST CALLOUT
	AX = 7A20h
	BX = 0004h
Return: AX = 0000h if request was handled
	    ES:BX -> VLM multicast data (see #1593)

Format of DOS Requester data:
Offset	Size	Description	(Table 1593)
 00h	DWORD	pointer to ??? (code)
 04h  4 BYTEs	???
 08h	DWORD	pointer to ??? (code) (see #1594)
	???

(Table 1594)
Call offset 08h function with:
	AL = function (00h-07h)
	???
Return: ???
--------N-2F7A20BX0005-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM INT 24 ADDRESS
	AX = 7A20h
	BX = 0005h
Return: AX = 0000h if request was handled
	    ES:BX -> VLM INT 24 handler
--------N-2F7A20BX0006-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0006h
Return: AX = 0000h if request was handled
	    ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
--------N-2F7A20BX0007-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0007h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
--------N-2F7A20BX0008-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0008h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
--------N-2F7A20BX0080-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0080h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
Note:	this function is identical to AX=7A20h/BX=0006h in v1.03 and v1.10
--------N-2F7A20BX0081-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0081h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
Note:	this function is identical to AX=7A20h/BX=0007h in v1.03 and v1.10
--------N-2F7A20BX0082-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0082h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
Note:	this function is identical to AX=7A20h/BX=0008h in v1.03 and v1.10
--------N-2F7A21-----------------------------
INT 2F C - Novell NetWare - DOS Requester - BROADCAST CALLBACK
	AX = 7A21h
	CX = server connection
Return: CX = 0000h if broadcast handled
SeeAlso: AX=7A22h,AX=7A85h
--------N-2F7A22-----------------------------
INT 2F C - Novell NetWare - DOS Requester - BROADCAST/SFT3 INFORM
	AX = 7A22h
	DL = function
	    21h ('!') broadcast
	    40h ('@') SFT3 inform
Return: AX = 0000h if event handled
SeeAlso: AX=7A21h
--------N-2F7A2F-----------------------------
INT 2F U - Novell NetWare - IPXODI v2.12 - GET ???
	AX = 7A2Fh
Return: AX = 0000h if supported and active
	    BX = version??? (0001h)
	    ES:DI -> entry point (see #1595)
Note:	IPXODI v2.12 is distributed as part of the Personal NetWare system
	  bundled with Novell DOS 7
SeeAlso: INT 7A/BX=001Fh

(Table 1595)
Call IPXODI entry point with:
	BX = function
	    0000h ???
		ES:SI -> ??? data
	    0001h ???
		AX = ???
		Return: ES:SI -> ??? data
	    0002h get ??? address
		Return: ES:SI -> ??? buffer
	    0003h send SPX packet???
		AL = ???
		CX = ???
		DX = ???
		SI = ???
		Return: ??? (registers from a call to INT 7A/BX=0016h)
Return: BX corrupted
--------N-2F7A2FBX0EDC-----------------------
INT 2F U - Personal NetWare - HRMIB - UNINSTALL
	AX = 7A2Fh
	BX = 0EDCh
Return: ???
SeeAlso: AX=7AA0h
--------N-2F7A40-----------------------------
INT 2F U - Novell NetWare - TCP/IP Protocol Stack - INSTALLATION CHECK
	AX = 7A40h
Return: AX = 7AFFh if installed
	    BX = ??? bit flags (see #1596)
	    CX = version (CH=major, CL=minor)
	    DX = 0000h
	    ES:DI -> entry point for TCP/IP stack (see #1597)
Notes:	Novell's LAN Workplace for DOS TCPIP.EXE also supports this interface
	this function is also supported by the Beame&Whiteside BWLWP40 shim,
	  but it only returns AL and ES:DI, and does not support AX=7A41h
SeeAlso: AX=7A41h,INT 15/AX=DE2Eh,INT 60"Excelan"

Bitfields for returned BX:
Bit(s)	Description	(Table 1596)
 0	???
 1	???
 15-2	reserved???

(Table 1597)
Call NetWare TCP/IP entry point with:
	ES:SI -> parameter block (see #1598)
Return: ES:SI parameter block updated

Format of NetWare TCP/IP parameter block:
Offset	Size	Description	(Table 1598)
 00h  4 BYTEs	???
 04h	WORD	(ret) ???
 06h	WORD	(ret) ???
 08h	DWORD	-> FAR routine called if bit 7 of function code set
 0Ch	BYTE	flags???
 0Dh  7 BYTEs	???
 14h	BYTE	(ret) ???
 15h	BYTE	(call) function code (bit 7 set if ???) (see #1599)
 16h	BYTE	socket number
 17h	BYTE	(ret) result or error code
 18h  4 WORDs	parameter words 0 to 3 (see #1599 for usage)
 20h	WORD	length of packet sent/received
 22h	WORD	number of pointer/length pairs following
 24h 6N BYTEs	buffer descriptors, each
		Offset	Size	Description
		 00h	DWORD	pointer to buffer
		 04h	WORD	length of buffer

(Table 1599)
Values for NetWare TCP/IP function code:
 01h	"accept"
 02h	"bind"
 03h	close socket
	Call:	socket number field set
 04h	"connect"
 05h	get IP address
	Call:	socket number field set to 0000h
	Return:	parameter words 1 and 2 contain caller's IP address
 06h	get hardware address
 07h	"getpeername"
 08h	get socket name
 0Ah	get netmask
 0Bh	"ioctl"
 0Ch	"listen"
 0Dh	"select"
 10h	"shutdown"
 11h	open socket
	Call:	socket number field set to 0000h
		parameter word 0 = desired protocol (6 = TCP, 17 = UDP)
	Return: socket number set
 12h	"read"
 13h	"recvfrom"
	Call:	socket number set
		packet length and buffer descriptors set
	Return:	packet length and receive buffers updated
		parameter word 1 = source port number
		parameter words 2 and 3 = source IP address
 14h	"write"
 15h	"sendto"
	Call:	socket number set
		flags field = ???
		parameter word 0 = 0000h
		parameter word 1 = destination port number
		parameter words 2 and 3 = destination IP address
		packet length and buffer descriptors set
 16h	get BOOTP data
Note:	these functions are based on the Unix socket interface
--------N-2F7A41-----------------------------
INT 2F - Novell NetWare - TCP/IP Protocol Stack - WINDOWS SUPPORT???
	AX = 7A41h
	ES:DI -> FAR entry point for ??? (will be called with BX=1,2,3,4)
Return: AX = 7AFFh if supported
	    BX = ??? (see #1596)
	    CX = version (CH=major, CL=minor)
	    DX = 0000h
	    ES:SI -> DWORD containing passed value of ES:DI
	    ES:DI -> entry point for TCP/IP stack
Notes:	Novell's LAN Workplace for DOS TCPIP.EXE also supports this interface
	the pointer which is set to ES:DI is cleared to 0000h:0000h when
	  a Windows exit broadcast is received
SeeAlso: AX=7A40h
--------N-2F7A42-----------------------------
INT 2F - Novell NetWare - TCPIP.EXE v4.1 - GET ??? ENTRY POINT
	AX = 7A42h
Return: AX = 7AFFh if supported
	    ES:DI -> ??? entry point (see #1600)

(Table 1600)
Call NetWare TCPIP.EXE entry point with:
	DX = ???
	ES:DI -> ??? (see #1601)
Return: AX = 0000h
	other registers destroyed

Format of data buffer:
Offset	Size	Description	(Table 1601)
 00h	WORD	offset of WORD ??? or 0000h
 02h	WORD	offset of DWORD ??? or 0000h
 04h	WORD	offset of DWORD ??? or 0000h
--------N-2F7A43-----------------------------
INT 2F - Novell NetWare - TCPIP.EXE v4.1 - GET ???
	AX = 7A43h
Return: AX = 7AFFh if supported
	    DX = offset of ???
SeeAlso: AX=7A44h
--------N-2F7A44-----------------------------
INT 2F - Novell NetWare - TCPIP.EXE v4.1 - SET ???
	AX = 7A44h
	DX = offset of ??? (see AX=7A43h)
Return: AX = 7AFFh if supported
SeeAlso: AX=7A43h
--------N-2F7A4C-----------------------------
INT 2F - Novell NetWare - TCPIP.EXE v4.1 - GET ???
	AX = 7A4Ch
Return: AX = 7AFFh if supported
	    BX = ??? (0037h)
	    CX = ??? (001Ch)
--------N-2F7A4DBX0001-----------------------
INT 2F - Novell NetWare - ???
	AX = 7A4Dh
	BX = 0001h
	ES:DI -> ???
Return: AL = FFh if ???
	    ES:DI -> ???
Note:	called by NETBIOS.EXE v3.01
--------N-2F7A4E-----------------------------
INT 2F - Novell LAN Workplace for DOS - RARPD.EXE - INSTALLATION CHECK
	AX = 7A4Eh
Return: AX = 7AFFh if installed
SeeAlso: AX=7A4Fh"RARPD"
--------N-2F7A4F-----------------------------
INT 2F - Novell LAN Workplace for DOS - RARPD.EXE - UNINSTALL
	AX = 7A4Fh
Return: AX = 7AFFh if installed
	DX,ES destroyed
Note:	this call conflicts with SNMP.EXE (both RARPD and SNMP are supplied
	  with LAN Workplace for DOS!), such that running SNMP will uninstall
	  RARPD as SNMP checks whether it is already installed!
SeeAlso: AX=7A4Eh"RARPD",AX=7A4Fh/BX=0001h
--------N-2F7A4FBX0001-----------------------
INT 2F - Novell NetWare - SNMP.EXE - INSTALLATION CHECK
	AX = 7A4Fh
	BX = 0001h
Return: AX = 7AFFh if installed
Note:	this call conflicts with RARPD.EXE (both SNMP and RARPD are supplied
	  with LAN Workplace for DOS!), such that running SNMP will uninstall
	  RARPD as SNMP checks whether it is already installed!
SeeAlso: AX=7A4Fh"RARPD",AX=7A4Fh/BX=0002h
--------N-2F7A4FBX0002-----------------------
INT 2F - Novell NetWare - SNMP.EXE - ???
	AX = 7A4Fh
	BX = 0002h
Return: AL = status
	    4Fh if failed
	    FFh if successful
SeeAlso: AX=7A4Fh/BX=0001h
--------N-2F7A80-----------------------------
INT 2F C - Novell NetWare - SHELL 3.01d BROADCAST - ABNORMAL EXIT
	AX = 7A80h
Return: nothing
Notes:	called on abnormal exit of the NetWare shell to notify other Novell
	  TSRs that it is unsafe to call the shell in the future.
	must be passed through so that all interested programs see the exit
	on receiving this call, IPXODI clears an internal pointer to a
	  default value; Novell's NETBIOS.EXE clears its INT 21h pointer to
	  0000h:0000h and stops calling it
SeeAlso: AX=7A81h
--------N-2F7A81-----------------------------
INT 2F C - Novell NetWare - SHELL 3.01d BROADCAST - SET SHELL INT 21 HANDLER
	AX = 7A81h
	CX:DX -> shell's INT 21h entry point
Return: nothing
Notes:	the shell calls this function as it loads to allow interested TSRs
	  and drivers to make a local copy of the shell's entry point
	must be passed through so that all interested programs see it
--------N-2F7A85-----------------------------
INT 2F C - Novell NetWare - shell 3.01 - BROADCAST INFORM
	AX = 7A85h
	CX = broadcast server number
Return: CX = 0000h if broadcast message handled by another program
	CX unchanged if broadcast not handled
SeeAlso: AX=7A21h
--------N-2F7A90-----------------------------
INT 2F U - Novell NetWare - NETBIOS.EXE 3+ - INSTALLATION CHECK
	AX = 7A90h
Return: AL = 00h if present
	    BX = ???
	    CX = PSP segment of NETBIOS resident code
SeeAlso: AX=7AFEh
--------N-2F7AA0-----------------------------
INT 2F U - Personal NetWare - HRMIB - ???
	AX = 7AA0h
	BX = function
	    0000h ???
	    0001h ???
Return: ???
SeeAlso: AX=7A2Fh/BX=0EDCh
--------N-2F7AC1-----------------------------
INT 2F - LAN HiJack - LHR - DISABLE???
	AX = 7AC1h
Program: LAN HiJack is a NetWare utility by KDS Software which allows a user
	  to take over control of a workstation remotely; LHR is the program
	  run on the slave workstation
SeeAlso: AX=7AC8h,AX=7AC9h,AX=7ACFh
--------N-2F7AC2-----------------------------
INT 2F - LAN HiJack - LHR - SYNCHRONIZE SHIFT STATES???
	AX = 7AC2h
Note:	sets BIOS keyboard status byte to an internal variable
SeeAlso: AX=7AC3h,AX=7ACFh
--------N-2F7AC3-----------------------------
INT 2F - LAN HiJack - LHR - CLEAR ??? FLAG
	AX = 7AC3h
SeeAlso: AX=7AC2h,AX=7ACFh
--------N-2F7AC8-----------------------------
INT 2F - LAN HiJack - LHR - ENABLE FUNCTIONS
	AX = 7AC8h
	BL = function(s) to enable (see #1602)
SeeAlso: AX=7AC1h,AX=7AC9h,AX=7ACFh

Bitfields for LAN HiJack function(s) to enable/disable:
Bit(s)	Description	(Table 1602)
 0	???
 1	remote keyboard enabled
 2	support remote's mouse
 3-7	unused
--------N-2F7AC9-----------------------------
INT 2F - LAN HiJack - LHR - DISABLE FUNCTIONS
	AX = 7AC9h
	BL = function(s) to disable (see #1602)
SeeAlso: AX=7AC1h,AX=7AC8h
--------N-2F7ACA-----------------------------
INT 2F - LAN HiJack - LHJ - ???
	AX = 7ACAh
	BL = ???
Return: ???
Program: LAN HiJack is a NetWare utility by KDS Software which allows a user
	  to take over control of a workstation remotely; LHJ is the program
	  run on the controlling workstation
--------N-2F7ACB-----------------------------
INT 2F - LAN HiJack - LHJ - ???
	AX = 7ACBh
	BX = ???
Return: ???
Note:	this function appears to be related to the keyboard
SeeAlso: AX=7ACCh
--------N-2F7ACC-----------------------------
INT 2F - LAN HiJack - LHJ - ???
	AX = 7ACCh
	BX = ???
Return: ???
Note:	this function appears to be related to the mouse
SeeAlso: AX=7ACBh
--------N-2F7ACFBX0000-----------------------
INT 2F - LAN HiJack - LHR - INSTALLATION CHECK
	AX = 7ACFh
	BX = 0000h
Return: BX = segment of resident code if installed
Program: LAN HiJack is a NetWare utility by KDS Software which allows a user
	  to take over control of a workstation remotely; LHR is the program
	  run on the slave workstation
--------N-2F7AF0-----------------------------
INT 2F - Novell NetWare - DOSNP.EXE v1.30G - INSTALLATION CHECK
	AX = 7AF0h
Return: AL = FFh if present
	    ES = 7AF0h
	    CX = PSP segment of resident code
--------N-2F7AF1-----------------------------
INT 2F - Novell NetWare - Access Server Driver - INSTALLATION CHECK
	AX = 7AF1h
	BL = sequence number (01h first driver, 02h second, 00h no driver)
Return: AX <> 7AF1h if present
	    BH = total number of drivers
	    ---if BL nonzero on entry---
	    AL = number of ports provided by specified driver
	    ES:DI -> driver entry point
		      (see #1603,#1604,#1605,#1606,#1607,#1608,#1609,#1610)
	    ES:DX -> ID string
SeeAlso: INT 7A/BX=001Ch

(Table 1603)
Call Access Server driver "initialize port" function with:
	AH = 01h
	AL = port number (00h-0Fh)
	ES:BX -> configuration parameter block (see #1616)
	interrupts disabled
Return: CF clear if successful
	CF set on error
SeeAlso: #1604

(Table 1604)
Call Access Server driver "get port status" function with:
	AH = 02h
	AL = port number (00h-0Fh)
	interrupts disabled
Return: CF clear if successful
	    BL = transmitter status (see #1613)
	    BH = receiver status (see #1614)
	    DL = external status signals (see #1615)
	CF set on error
	interrupts disabled
SeeAlso: #1603,#1605,#1608

(Table 1605)
Call Access Server driver "get input from port" function with:
	AH = 03h
	AL = port number (00h-0Fh)
	CX = size of data buffer
	ES:BX -> buffer for data
	interrupts disabled
Return: CF clear if successful
	CF set on error
	interrupts disabled
	CX = number of bytes read
Note:	the driver will add a NUL to the buffer when a break signal is detected
SeeAlso: #1605,#1606

(Table 1606)
Call driver "send output data to port" function with:
	AH = 04h
	AL = port number (00h-0Fh)
	CX = number of bytes to send
	ES:BX -> buffer containing data
	interrupts disabled
Return: CF clear if successful
	CF set on error
	interrupts disabled
	CX = number of bytes actually written
SeeAlso: #1605,#1607

(Table 1607)
Call driver "get I/O character counts" function with:
	AH = 05h
	AL = port number (00h-0Fh)
	interrupts disabled
Return: CF clear if successful
	    BX = number of bytes pending transmission
	    CX = number of bytes available for reading
	CF set on error
	interrupts disabled
SeeAlso: #1605,#1606

(Table 1608)
Call driver "control XON/XOFF" function with:
	AH = 06h
	AL = port number (00h-0Fh)
	DL = new state
	    (00h software flow control disabled, else enabled)
	interrupts disabled
Return: CF clear if successful
	CF set on error
	interrupts disabled
SeeAlso: #1609

(Table 1609)
Call driver "get error counts and statistics" function with:
	AH = 07h
	AL = port number (00h-0Fh)
	ES:BX -> buffer for statistics (see #1617)
	interrupts disabled
Return: CF clear if successful
	    ES:BX buffer filled
	CF set on error
	interrupts disabled
SeeAlso: #1610,#1611,#1612

(Table 1610)
Call driver "general request" function with:
	AH = 08h
	AL = port number (00h-0Fh)
	DX = requested operations
	    bit 0: flush transmit buffers
	    bit 1: flush receive buffers
	    bit 4: define XON/XOFF characters
	ES:BX -> XON/XOFF characters (see #1618) if DX bit 4 set
	interrupts disabled
Return: CF clear if successful
	CF set on error
	interrupts disabled

(Table 1611)
Call driver "deadman timer management" function with:
	AH = 09h
	AL = port number (00h-0Fh)
	BX = next time interval in seconds (0000h to disable timer)
	interrupts disabled
Return: CF clear
	interrupts disabled
SeeAlso: #1612

(Table 1612)
Call driver "get buffer sizes" function with:
	AH = 0Ah
	AL = port number (00h-0Fh)
	interrupts disabled
Return: CF clear if successful
	   BX = size of transmit buffer
	   CX = size of receive buffer
	CF set on error
	interrupts disabled
SeeAlso: #1611

(Table 1613)
Values for Access Server transmitter status:
 00h	uninitialized
 01h	ready, not transmitting
 02h	transmitting
 03h	XOFF received
 04h	transmitting, buffer full
 05h	XOFF received and buffer full

(Table 1614)
Values for Access Server receiver status:
 00h	uninitialized
 01h	ready
 02h	receive buffer full, data may have been lost

Bitfields for external status signals:
Bit(s)	Description	(Table 1615)
 7,6	undefined
 5	CTS active
 4	DSR active
 3	DCD active
 2,1	undefined
 0	ring indicator

Format of Access Server configuration parameter block:
Offset	Size	Description	(Table 1616)
 00h	BYTE	receive baud rate index
		00h 50 bps, 01h 75 bps, 02h 110 bps, 03h 134.5 bps,
		04h 150 bps, 05h 300 bps, 06h 600 bps, 07h 1200 bps,
		08h 1800 bps, 09h 2000 bps, 0Ah 2400 bps, 0Bh 3600 bps,
		0Ch 4800 bps, 0Dh 7200 bps, 0Eh 9600 bps, 0Fh 19200 bps,
		10h 38400 bps, 11h 57600 bps, 12h 115200 bps
 01h	BYTE	receive bits per character (0=5 bits..3=8 bits)
 02h	BYTE	receive stop bits
 03h	BYTE	receive parity
		00h none, 01h odd, 02h even, 03h mark, 04h space
 04h	BYTE	transmit baud rate index (same as receive baud rate)
 05h	BYTE	transmit bits per character (0=5 bits..3=8 bits)
 06h	BYTE	transmit stop bits
 07h	BYTE	transmit parity (same as receive parity)
 08h	BYTE	DTR state (00h off, 01h on)
 09h	BYTE	RTS state (00h off, 01h on)
 0Ah	BYTE	flow control (00h none, 01h XON/XOFF, 02h RTS/CTS, 03h both)
 0Bh	BYTE	break control (00h off, 01h on)

Format of Access Server statistics:
Offset	Size	Description	(Table 1617)
 00h	BYTE	port number
 01h	BYTE	external status signals (see #1615)
 02h	BYTE	transmitter status (see #1613)
 03h	BYTE	receiver status (see #1614)
 04h	DWORD	number of characters received
 08h	DWORD	number of characters transmitted
 0Ch	WORD	input parity errors
 0Eh	WORD	input framing errors
 10h	WORD	lost characters due to hardware overrun
 12h	WORD	lost characters due to data buffer overrun
Note:	the counts are not allowed to wrap around; once a count reaches FFFFh
	  or FFFFFFFFh, it is no longer incremented

Format of Access Server XON/XOFF characters:
Offset	Size	Description	(Table 1618)
 00h	BYTE	04h (number of bytes following)
 01h	BYTE	transmit XON character
 02h	BYTE	transmit XOFF character
 03h	BYTE	receive XON character
 04h	BYTE	receive XOFF character
--------N-2F7AFE-----------------------------
INT 2F - Novell NetWare - DOSNP.EXE - INSTALLATION CHECK
	AX = 7AFEh
Return: AL = FFh if present
	    ES = (data???) segment of DOSNP
Program: DOSNP.EXE provides "named pipes" support for DOS workstations running
	   NetWare
Note:	the NetWare shell calls this function and refuses to load if DOSNP is
	  present
SeeAlso: AX=7A90h
--------N-2F7AFFBX0000-----------------------
INT 2F - Novell NetWare - TBMI v1.1+ - INSTALLATION CHECK / Windows SUPPORT
	AX = 7AFFh
	BX = 0000h
	CX = 4E65h ("Ne")
	DX = 7457h ("tW")
	ES:DI -> Windows support procedure (see #1619)
Return: AL = FFh if installed
	    CX = configured sockets (14h)
	    DS:SI -> data table ???
	    ES:DI -> IPX far call handler
Notes:	for IPX/SPX this call reportedly returns DS:SI pointing to the table
	  of pointers to service events queue head and tail
	this function is also supported by IPXODI; v2.12 does not change DS,
	  but does set SI to an internal address
SeeAlso: AX=7AFFh/BX=0001h

(Table 1619)
Values Windows support procedure called with:
	BP = function
	    0001h Get ECB
		BX = socket number
		Return: ES:SI -> ECB or 0000h:0000h if none available
	    0002h Count Listen ECBs
		AX = BX = socket
		Return: CX = number of listen ECBs for socket
				(must be >= 2 for SPX to work)
	    0003h ???
	    0004h Inform task switcher of ECB locations
		Note:	registers other than those listed above are equal
			  to the values when IPX was called
Note:	the support function will not be called if IPX is called with BX
	  bit 15 set
--------N-2F7AFFBX0001-----------------------
INT 2F - Novell NetWare - TBMI v1.1+, shell v3.01d - INSTALLATION CHECK???
	AX = 7AFFh
	BX = 0001h
	CX = 4E65h ("Ne")
	DX = 7457h ("tW")
Return: AL = FFh if installed
	    CX = ???  (8000h)
	    SI = ??? (or -> ???) (0002h and 0007h seen)
	    ES:DI -> IPX far call handler
	    ES:DX -> 6-byte data area ???
Note:	this function is also supported by IPXODI, but IPXODI v2.12 does not
	  return ES:DX
SeeAlso: AX=7AFFh/BX=0000h
--------d-2F7F00-----------------------------
INT 2F - Jim Harper's CD-ROM redirector SCSI driver - INSTALLATION CHECK
	AX = 7F00h
Return: AL = FFh if installed
SeeAlso: AX=7F01h,AX=7F02h,AX=7F03h
--------d-2F7F01-----------------------------
INT 2F - Jim Harper's CD-ROM redirector SCSI driver - DO COMMAND
	AX = 7F01h
	DS:DX -> command record (see #1620)
Return: AL = status
	    00h successful
	    else error code
SeeAlso: AX=7F00h,AX=7F02h,INT 11/AH=FFh"SDLP",INT 21/AX=4402h"ASPI"
SeeAlso: INT 4F/AX=8100h

Format of CD-ROM redirector command record:
Offset	Size	Description	(Table 1620)
 00h	BYTE	ID
 01h 10 BYTEs	CDB (Command Descriptor Block) for operation
 0Bh	WORD	segment of buffer
 0Dh	WORD	offset of buffer
 0Fh	BYTE	status
 10h	BYTE	sense
 12h	WORD	count
--------d-2F7F02-----------------------------
INT 2F - Jim Harper's CD-ROM redirector SCSI driver - DO RESET
	AX = 7F02h
SeeAlso: AX=7F00h,AX=7F01h
--------d-2F7F03-----------------------------
INT 2F - Jim Harper's CD-ROM redirector SCSI driver - UNINSTALL
	AX = 7F03h
Return: AL = status
	    00h successful
	    01h unable to uninstall
SeeAlso: AX=7F00h
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
--------N-2F8000-----------------------------
INT 2F - EASY-NET - INSTALLATION CHECK
	AX = 8000h
Return: AL = 00h not installed
	     FFh installed
Program: EASY-NET is a shareware two-machine serial-port network
--------N-2F8000-----------------------------
INT 2F - Nanosoft, Inc. TurboNET server - INSTALLATION CHECK
	AX = 8000h
Return: AL = FFh if installed
	    BX = CS of resident code
	    CX = ??? (03FCh)
Program: TurboNET is a NetBIOS-based file redirector and server; a
	  demonstration version may be downloaded from Nanosoft's BBS
SeeAlso: AX=8100h
--------t-2F8000-----------------------------
INT 2F - CS_TSR specification - TSR INSTALLATION CHECK
	AX = 8000h
	DS:SI -> 4-byte CS_TSR signature (11h 43h 53h 10h)
Return: AL = status
	    00h no CS_TSR-compliant TSRs installed
	    01h installed, but signature did not match
	    FFh installed, signature matches
		ES:DI -> resident process block (see #1621) of last installed
			  TSR (if DS:SI pointed at signature on entry)
Program: the CS_TSR specification is a standardized TSR interface by Compact
	  Soft group in Kiev, Ukraine
Desc:	determine whether any CS_TSR-compliant TSRs are installed on the
	  selected multiplex number
Range:	AH=80h to AH=FFh
SeeAlso: AX=8001h"CS_TSR",AX=8002h"CS_TSR",AX=8003h"CS_TSR"

Format of CS_TSR process block:
Offset	Size	Description	(Table 1621)
 00h  4 BYTEs	CS_TSR signature 11h 43h 53h 10h
 04h	BYTE	INT 2F multiplex number
 05h	WORD	virtual process handle (unique among loaded TSRs)
 07h  2 BYTEs	version (binary minor version, then major version)
 09h	WORD	PSP segment of TSR
 0Bh	DWORD	pointer to ASCIZ program name
 0Fh  3 BYTEs	program creation date (day, month, year)
 12h  3 BYTEs	process start time (seconds, minutes, hours)
 15h  3 BYTEs	process start date (day, month, year)
--------F-2F8000DX0000-----------------------
INT 2F - FaxBIOS interface - INSTALLATION CHECK
	AX = 8000h
	DX = 0000h
	DI = 0000h
Return: AL = FFh if installed
	DX:DI -> signature "FaxBiosjpc"
Range:	AH=80h to AH=FFh, selected by scanning multiplex numbers for signature
SeeAlso: AH=2Ah,AX=80FBh
--------N-2F8001-----------------------------
INT 2F - Nanosoft, Inc. TurboNET server - ???
	AX = 8001h
	DS:SI -> 16-byte buffer for ???
Return: AH = status
	    00h successful
	    01h error (TurboNET busy)
Note:	makes NetBIOS calls
--------t-2F8001-----------------------------
INT 2F - CS_TSR specification - GET HANDLE (TSR-SPECIFIC INSTALLATION CHECK)
	AX = 8001h
	DS:SI -> ASCIZ signature string for desired TSR (see #1622)
Return: BX = process handle or 0000h if specified TSR not installed
	ES:DI -> process block for TSR (see #1621) if BX<>0000h
Note:	A widely-available copy of ASCII billing itself as "ASCII 2.OO by
	  Nick Zaikin Jr." is in fact a hacked copy of the Compact Soft
	  ASCII v4.23 which is identical except for the changed attribution
	  and version (in fact, some instances of "4.23" were missed); the
	  hacked copy requires the signature string
	  "ASCII 2.OO by Nick Zaikin Jr." instead of the unhacked version's
	  simple signature "ASCII"
SeeAlso: AX=8000h"CS_TSR",AX=8002h"CS_TSR"

(Table 1622)
Values for CS_TSR signature strings:
 "ASCII"	ASCII, a popup ASCII table with character input
 "Halculator"	HALC, a 32-bit RPN WYSIWIH calculator with undo and ptr support
 "AntiTurbo"	AT!, an intelligent system slow-down utility
--------t-2F8002-----------------------------
INT 2F - CS_TSR specification - GET PROCESS BLOCK BY PROCESS HANDLE
	AX = 8002h
	BX = process handle for TSR (see AX=8001h"CS_TSR")
Return: ES:DI -> process block for specified TSR (see #1621)
		unchanged if no match for process handle
Note:	This function is used to allocate a process handle when the TSR
	  installs itself, by setting ES:DI to point at something other than
	  a CS_TSR process block's signature string and iterating through the
	  possible process handles (0001h to FFFFh) until ES:DI is returned
	  unchanged
SeeAlso: AX=8000h"CS_TSR",AX=8001h"CS_TSR",AX=8003h"CS_TSR"
--------t-2F8003-----------------------------
INT 2F - CS_TSR specification - CUSTOM SUBFUNCTION
	AX = 8003h
	BX = process handle for TSR (see AX=8001h"CS_TSR")
	other registers vary by TSR
Return: vary by TSR, unchanged if not supported
Program: the CS_TSR specification is a standardized TSR interface by Compact
	  Soft group in Kiev, Ukraine
SeeAlso: AX=8000h"CS_TSR",AX=8001h"CS_TSR",AX=8002h"CS_TSR"
--------F-2F80FB-----------------------------
INT 2F - FaxBIOS interface - COMMAND SUBMISSION
	AX = 80FBh
	BX = function number (see #1623)
	DX:DI -> command buffer
		  (see #1625,#1628,#1629,#1630,#1631,#1632,#1637,#1643,#1650)
Return: AL = FFh if submitted OK
	CX = result code (see #1624)
Range:	AH=80h to AH=FFh, selected by scanning multiplex numbers for signature
SeeAlso: AX=8000h"FaxBIOS",AX=CBDDh

(Table 1623)
Values for FaxBIOS function number:
 0001h	SYS_LOGIN
 0002h	SYS_LOGOUT
 0003h	SYS_GET_FAXAPP_INFO
 0004h	STAT_IO_GET
 0005h	STAT_FAXBIOS_GET
 0006h	PDIR_OPEN
 0007h	PDIR_CLOSE (see #1633)
 0008h	PDIR_READ_PERSON (see #1634)
 0009h	PDIR_PARTIAL_READ
 000Ah	PDIR_READ_GROUP
 000Bh	PDIR_READ_MEMBER_LIST
 000Ch	PDIR_WRITE_PERSON
 000Dh	PDIR_WRITE_GROUP
 000Eh	PDIR_DELETE_PERSON
 000Fh	PDIR_DELETE_GROUP
 0010h	PDIR_READ_GROUP_LIST
 0011h	PDIR_IN_GROUP
 0012h	PDIR_OUT_GROUP
 0013h	SCHED_OPEN (see #1635)
 0014h	SCHED_ADD_DEST (see #1636)
 0015h	SCHED_ADD_FILE (see #1637)
 0016h	SCHED_SET_PARAMS (see #1638)
 0017h	SCHED_CANCEL (see #1635)
 0018h	SCHED_CLOSE (see #1639)
 0019h	SLOG_OPEN (see #1640)
 001Ah	SLOG_CLOSE (see #1640)
 001Bh	SLOG_SHORT_ENV_STAT
 001Ch	SLOG_LONG_ENV_STAT
 001Dh	SLOG_DEST_STAT
 001Eh	SLOG_FILE_STAT
 001Fh	SLOG_CANCEL_ENV
 0020h	RLOG_OPEN (see #1640)
 0021h	RLOG_CLOSE (see #1640)
 0022h	RLOG_READ
 0023h	GRAPH_GET_FILE_TYPE (see #1641)
 0024h	GRAPH_EXPORT_FILE
 0025h	GRAPH_GET_LAYOUT_INFO
 0026h	GRAPH_CREATE_FILE (see #1642)
 0027h	GRAPH_CLOSE_FILE (see #1643)
 0028h	GRAPH_CREATE_PAGE (see #1644)
 0029h	GRAPH_WRITE (see #1645)
 002Ah	GRAPH_END_PAGE
 002Bh	GRAPH_OPEN_FILE (see #1646)
 002Ch	GRAPH_GOTO_PAGE (see #1647)
 002Dh	GRAPH_READ (see #1648)
 002Eh	IOCTL_GET
 002Fh	IOCTL_SET
 0030h	IOCTL_ANSWER_FAX (see #1649)
 0031h	IOCTL_DIAL (see #1650)

(Table 1624)
Values for FaxBIOS result code:
 0000h	successful
 0001h	not prepared or servicing another client (busy)
 0002h	call failed due to sharing (LOCKED)
 0003h	logged-in client limit reached (FULL)
 0004h	transport denied (TRANSPORT_DENIED)
 0005h	not implemented (NOT_IMPLEMENTED)
 0006h	aborted while in progress (ABORTED)
 0007h	permissions denied (PERMISSION_DENIED)
 0008h	requested data is no longer valid (NO_LONGER_VALID)
 0080h	unspecified system error occurred
 0081h	an internal file was not found
 0082h	an internal file could not be created
 0083h	an internal file could not be opened
 0084h	an internal file could not be closed
 0085h	error occurred writing to an internal file
 0086h	error occurred reading from an internal file
 0087h	bad or corrupted file encountered
 0088h	an access violation occurred
 0089h	an internal file is empty
 008Ah	insufficient memory to process request
 008Bh	FaxBIOS was unable to issue a handle
 008Ch	an error internal to FaxBIOS occurred
 008Dh	no room on disk
 0100h	unspecified error accessing client file
 0101h	file not found
 0102h	creation fault
 0103h	open fault
 0104h	close fault
 0105h	write fault
 0106h	read fault
 0107h	file corrupted
 0108h	access violation
 0109h	empty file
 0200h	unspecified argument error
 0201h	bad function
 0202h	bad option
 0203h	bad structure size
 0204h	bad buffer size
 0205h	bad client ID
 0300h	unspecified error with token
 0301h	cover sheet token was invalid
 0302h	logo token was invalid
 0303h	signature token was invalid
 0304h	font token was invalid
 0305h	phone directory token was invalid
 0306h	outbound route token was invalid
 0307h	priority token was invalid
 0308h	sort token was invalid
 0309h	billing token was invalid
 0400h	unspecified handle error
 0401h	bad Phone Directory handle
 0402h	bad scheduling handle
 0403h	bad read send log handle
 0404h	bad read receive log handle
 0405h	bad graphics handle
 0500h	data passed in structure was invalid
 0501h	name field given is invalid
 0502h	phone number given is invalid
 0503h	poll code submitted is invalid
 0504h	file type constant was invalid
 0505h	BFT constant not defined or supported
 0506h	resolution not defined or supported
 0507h	page length not defined or supported
 0508h	page width not defined or supported
 0509h	date & time requested are ridiculous
 050Ah	Subject text was not an ASCIZ string
 050Bh	From text was not an ASCIZ string
 050Ch	requested envelope ID was not found
 050Dh	requested envelope ID is not valid
 050Eh	envelope requested was not found
 050Fh	destination index is out of range
 0510h	file index is out of range
 0511h	index into receive log is out of range
 0512h	file name specified was incomplete or invalid
 0513h	page selected was out of range
 0514h	bit width more than byte width
 0515h	mode for open is not defined
 0516h	person index is out of range
 0517h	person ID is out of range
 0518h	group index out of range or invalid
 0519h	group ID out of range or invalid
 051Ah	range of indices to read is invalid
 051Bh	group name given is invalid
 051Ch	field_to_use is badly specified
 051Dh	predicate invalid for field specified
 0600h	unspecified client procedure error
 0601h	device of interest is not present
 0602h	device of interest has been removed
 0603h	device of interest is not responding
 0604h	device of interest is disabled
 0605h	could not dial because device was in use
 0606h	maximum destination limit exceeded
 0607h	maximum file limit exceeded
 0608h	scheduling closed with no destination
 0609h	scheduling closed with no files or poll
 060Ah	scheduling closed with no parameters specified
 060Bh	file type specified does not match file
 060Ch	file type specified is not supported
 060Dh	file submitted is not exportable
 060Eh	file type specified is not imageable
 060Fh	error converting file
 0610h	envelope could not be cancelled
 0611h	Phone Directory is full
 0612h	record is already in the Phone Directory
 0613h	selected group in Phone Directory is full
 0614h	person is already in the group
 0615h	person is not in the group & cannot be removed
 0616h	a graphics file to be created already exists
 0617h	a graphics file to be read is empty
 0618h	GRAPH_CREATE_PAGE called before GRAPH_END_PAGE
 0619h	graph read or write attempted without goto or create
 061Ah	graph page contains no data
 061Bh	Phone Directory is already open for this client
 061Ch	schedule log is already open for this client
 061Dh	receive log is aready open for this client
 061Eh	Phone Directory function requires write mode
 0800h	denied exclusive use of the API

Format of FaxBIOS SYS_LOGIN command buffer:
Offset	Size	Description	(Table 1625)
 00h	WORD	structure size
 02h	WORD	function number
 04h	WORD	return code
 06h	WORD	client ID
 08h	WORD	API Major Version
 0Ah	WORD	API Minor Version
 0Ch	DWORD	reserved for manufacturer's use
 10h 22 BYTEs	manufacturer's ID
 26h	WORD	highest possible device number
 28h	WORD	maximum destinations per envelope
 2Ah	WORD	maximum files per envelope
 2Ch	WORD	FaxBIOS capabilities (see #1626)
 2Eh	DWORD	T.30 capabilities (see #1627)
 32h	WORD	IPC handle
 34h	DWORD	amount of memory needed to load
 38h	WORD	scope (00h for public, nonzero for private)
 3Ah  6 BYTEs	future expansion
 40h	WORD	structure size

Bitfields for FaxBIOS capabilities:
Bit(s)	Description	(Table 1626)
 0	transmit supported
 1	receive supported
 2	IOCTL supported
 3	IOCTL_DIAL supported
 4	IOCTL_ANSWER_FAX supported
 5	manual transmit supported
 6	optional phone services supported
 7	canonical phone objects
 8	seam with next supported

Bitfields for T.30 capabilities:
Bit(s)	Description	(Table 1627)
 0	low vertical resolution (minimum)
 1	high vertical resolution
 2	page width 107mm (4.21 in)
 3	page width 151mm (5.91 in)
 4	page width 215mm (8.46 in) (minimum)
 5	page width 255mm (10.04 in)
 6	page width 303mm (11.93 in)
 7	unused
 8	page length 297mm (11.69 in) (minimum)
 9	page length 364mm (14.33 in)
 10	page length 279mm (11 in)
 11	page length unlimited
 12	Group 4 resolution 300x300
 13	Group 4 resolution 400x400
 14	able to respond to poll from remote
 15	able to poll remote
 16	binary file transfer supported

Format of FaxBIOS SYS_LOGOUT command buffer:
Offset	Size	Description	(Table 1628)
 00h	WORD	structure size
 02h	WORD	function number
 04h	WORD	return code
 06h	WORD	client ID
 08h	DWORD	client tag (for client's internal use)
 0Ch  6 BYTEs	future expansion
 12h	WORD	structure size

Format of FaxBIOS SYS_GET_FAXAPP_INFO command buffer:
Offset	Size	Description	(Table 1629)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch 80 BYTEs	FaxBIOS data
 5Ch 80 BYTEs	default cover
 ACh 80 BYTEs	default logo
 FCh 80 BYTEs	default signature
14Ch 80 BYTEs	default font 10
19Ch 80 BYTEs	default font 165
1ECh 80 BYTEs	default user font
23Ch 80 BYTEs	default Pdir
28Ch 80 BYTEs	default sort
2DCh 10 BYTEs	default bill
2E6h 10 BYTEs	default route
2F0h 40 BYTEs	default cover sheet form
318h 34 BYTEs	valid dial characters
33Ah  6 BYTEs	local country code
340h  6 BYTEs	local city or area code
346h  6 BYTEs	future expansion
34Ch	WORD	structure size

Format of FaxBIOS STAT_IO_GET command buffer:
Offset	Size	Description	(Table 1630)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	device number
 0Eh	WORD	current activity
 10h	WORD	number of rings (if ringing)
 12h	WORD	number of fascimiles transmitted
 14h	WORD	number of fascimiles received
 16h	WORD	status of last transmission
 18h	WORD	envelope number of last transmission
 1Ah	WORD	index of last destination in envelope
 1Ch	WORD	status of last reception
 1Eh	WORD	current page (if session in progress)
 20h 80 BYTEs	current file
 70h 104 BYTEs	remote number
 D8h 20 BYTEs	last name
 ECh 20 BYTEs	first name
100h 32 BYTEs	company name
120h 32 BYTEs	notes
140h	WORD	current envelope ID (if sending)
142h	WORD	total pages in transmission (if sending)
144h  6 BYTEs	future expansion
14h	WORD	structure size

Format of FaxBIOS STAT_FAXBIOS_GET command buffer:
Offset	Size	Description	(Table 1631)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	status ID
 0Eh	WORD	currenty FaxBIOS function number
 10h	WORD	current Client ID being serviced
 12h	WORD	number of things to do
 14h	WORD	number of them done
 16h	WORD	number of pages to do (if any)
 18h	WORD	number of them done
 1Ah	WORD	number of files to do
 1Ch	WORD	number of them done
 1Eh 80 BYTEs	current File
 6Eh	WORD	0 if all devices are idle
 70h	WORD	number of fascimiles transmitted
 72h	WORD	number of fascimiles received
 74h	WORD	status of last transmission in system
 76h	WORD	envelope ID of last transmission
 78h	WORD	index of last destination in envelope
 7Ah	WORD	status of last reception in system
 7Ch	DWORD	time of next transmission
 80h  6 BYTEs	future expansion
 86h	WORD	structure size

Format of FaxBIOS PDIR_OPEN command buffer:
Offset	Size	Description	(Table 1632)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch 80 BYTEs	Phone Directory token
 5Ch 80 BYTEs	sort order token
 ACh	WORD	open Mode (0 = read, 1 = write)
 AEh	WORD	Phone Directory handle
 B0h	WORD	number of people
 B2h	WORD	number of groups
 B4h	WORD	bitmap of fields supported by partial read
 B6h  6 BYTEs	future expansion
 BCh	WORD	structure size

Format of FaxBIOS PDIR_CLOSE command buffer:
Offset	Size	Description	(Table 1633)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	Phone Directory handle
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size

Format of FaxBIOS PDIR_READ_PERSON command buffer:
Offset	Size	Description	(Table 1634)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	Phone Directory handle
 0Eh	WORD	retrieve by index
 10h	WORD	person ID or index
 12h	WORD	how many groups person is in
 14h	WORD	person ID
 16h 20 BYTEs	last name
 2Ah 20 BYTEs	first name
 3Eh 32 BYTEs	company
 5Eh 32 BYTEs	notes
 7Eh  6 BYTEs	FAX country code
 84h  6 BYTEs	FAX city/area code
 8Ah 14 BYTEs	FAX local number
 98h 14 BYTEs	FAX extension
 A6h 24 BYTEs	reserved
 BEh  6 BYTEs	voice country code
 C4h  6 BYTEs	voice city/area code
 CAh 14 BYTEs	voice local number
 D8h 14 BYTEs	voice extension
 E6h 24 BYTEs	reserved
 FEh 10 BYTEs	outbound routing information
108h 10 BYTEs	billing information, credit card etc
112h	DWORD	remote FAX capabilities
116h 21 BYTEs	T.30 poll code of FAX number
12Bh 15 BYTEs	reserved
13Ah  6 BYTEs	future expansion
140h	WORD	structure size

Format of FaxBIOS SCHED_OPEN, SCHED_CANCEL command buffer:
Offset	Size	Description	(Table 1635)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	scheduler handle
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size

Format of FaxBIOS SCHED_ADD_DEST command buffer:
Offset	Size	Description	(Table 1636)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	schedule handle
 0Eh	WORD	device number if manual send wanted
 10h	WORD	non-zero if poll desired
 12h	WORD	person ID
 14h 20 BYTEs	last name
 28h 20 BYTEs	first name
 3Ch 32 BYTEs	company
 5Ch 32 BYTEs	notes
 7Ch  6 BYTEs	FAX country code
 82h  6 BYTEs	FAX city/area code
 88h 14 BYTEs	FAX local number
 96h 14 BYTEs	FAX extension
 A4h 24 BYTEs	reserved
 BCh  6 BYTEs	voice country code
 C2h  6 BYTEs	voice city/area code
 C8h 14 BYTEs	voice local number
 D6h 14 BYTEs	voice extension
 E4h 24 BYTEs	reserved
 FCh 10 BYTEs	outbound routing information
106h 10 BYTEs	billing information, credit card etc
110h	DWORD	remote FAX capabilities
114h 21 BYTEs	T.30 poll code of FAX number
129h 15 BYTEs	reserved
138h  6 BYTEs	future expansion
13Eh	WORD	structure size
SeeAlso: #1637

Format of FaxBIOS SCHED_ADD_FILE command buffer:
Offset	Size	Description	(Table 1637)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	schedule handle
 0Eh	WORD	file type
		0000h unidentified
		0001h native file format
		0002h ASCII
		0003h FaxBIOS Tiff Class F
 10h 80 BYTEs	file name
 60h 80 BYTEs	font token
 B0h	WORD	conversion options bitmap
 B2h	WORD	resolution
		0000h standard 98 lines per inch, 204 dpi
		0001h fine 196 lines per inch, 204 dpi
		0002h Group4 300 dpi
		0003h Group4 400 dpi
 B4h	WORD	page length
		0000h 279 mm (11 in)
		0001h 297 mm (11.69 in)
		0002h 364 mm (14.33 in)
		0003h unlimited
 B6h	WORD	page width
		0000h 215 mm (8.46 in)
		0001h 255 mm (10.04 in)
		0002h 303 mm (11.93 in)
		0003h 151 mm (5.91 in)
		0004h 107 mm (4.21 in)
 B8h	WORD	binary file transfer specification
		0000h only as FAX
		0001h only as file (for non-faxable files)
		0002h as file when possible else FAX
 BAh	WORD	seam flag (nonzero for seam with next)
 BCh	WORD	delete flag (nonzero to delete when done)
 BEh  6 BYTEs	future expansion
 C4h	WORD	structure size
SeeAlso: #1636,#1638

Format of FaxBIOS SCHED_SET_PARAMS command buffer:
Offset	Size	Description	(Table 1638)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	scheduler handle
 0Eh	DWORD	time to send
 10h 10 BYTEs	priority token
 1Ch 80 BYTEs	logo file token
 6Ch 80 BYTEs	signature file token
 BCh 80 BYTEs	cover page token
10Ch 40 BYTEs	Subject text
134h 40 BYTEs	From text
15Ch	WORD	user ID
15Eh  6 BYTEs	future expansion
164h	WORD	structure size
SeeAlso: #1636,#1637,#1639

Format of FaxBIOS SCHED_CLOSE command buffer:
Offset	Size	Description	(Table 1639)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	scheduler handle
 0Eh	WORD	envelope ID generated
 10h  6 BYTEs	future expansion
 16h	WORD	structure size
SeeAlso: #1638

Format of FaxBIOS SLOG_OPEN, SLOG_CLOSE, RLOG_OPEN, RLOG_CLOSE command buffer:
Offset	Size	Description	(Table 1640)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	log handle
 0Eh	WORD	number of entries
 10h  6 BYTEs	future expansion
 16h	WORD	structure size

Format of FaxBIOS GRAPH_GET_FILE_TYPE command buffer:
Offset	Size	Description	(Table 1641)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch 80 BYTEs	filename
 5Ch	WORD	file type
		0000h unidentified
		0001h native file format
		0002h ASCII
		0003h FaxBIOS Tiff Class F
 5Eh	WORD	bitmap of supported capabilities
 60h  6 BYTEs	future expansion
 66h	WORD	structure size
SeeAlso: #1642,#1643

Format of FaxBIOS GRAPH_CREATE_FILE command buffer:
Offset	Size	Description	(Table 1642)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch 80 BYTEs	filename
 5Ch	WORD	graph handle
 5Eh  6 BYTEs	future expansion
 64h	WORD	structure size
SeeAlso: #1641,#1643,#1644

Format of FaxBIOS GRAPH_CLOSE_FILE, GRAPH_END_PAGE command buffer:
Offset	Size	Description	(Table 1643)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	graph handle
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size
SeeAlso: #1642,#1644

Format of FaxBIOS GRAPH_CREATE_PAGE command buffer:
Offset	Size	Description	(Table 1644)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	graph handle
 0Eh	WORD	resolution
 10h	WORD	page width
 12h  6 BYTEs	future expansion
 18h	WORD	structure size
SeeAlso: #1642,#1643,#1645

Format of FaxBIOS GRAPH_WRITE_PAGE command buffer:
Offset	Size	Description	(Table 1645)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	graph handle
 0Eh	DWORD	pointer to storage for image
 12h	WORD	band height in lines
 14h	WORD	width of page image in bytes
 16h	WORD	facsimile page width constant
 18h	WORD	width of page image in bits
 1Ah	WORD	number of bytes actually processed
 1Ch  6 BYTEs	future expansion
 22h	WORD	structure size
SeeAlso: #1644,#1646

Format of FaxBIOS GRAPH_OPEN_FILE command buffer:
Offset	Size	Description	(Table 1646)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch 80 BYTEs	filename
 5Ch	WORD	file type
 5Eh	WORD	graph handle
 60h	WORD	number of pages
 62h  6 BYTEs	future expansion
 68h	WORD	structure size
SeeAlso: #1645,#1647

Format of FaxBIOS GRAPH_GOTO_PAGE command buffer:
Offset	Size	Description	(Table 1647)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	graph handle
 0Eh	WORD	page number
 10h	WORD	vertical resolution
 12h	WORD	page width
 14h	DWORD	page length
 18h  6 BYTEs	future expansion
 1Eh	WORD	structure size
SeeAlso: #1645,#1646,#1648

Format of FaxBIOS GRAPH_READ_PAGE command buffer:
Offset	Size	Description	(Table 1648)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	graph handle
 0Eh	DWORD	pointer to storage for image
 12h	WORD	band height in lines
 14h	WORD	width of page image in bytes
 16h	WORD	facsimile page width constant
 18h	WORD	width of page image in bits
 1Ah	WORD	number of bytes actually processed
 1Ch  6 BYTEs	future expansion
 22h	WORD	structure size

Format of FaxBIOS IOCTL_ANSWER_FAX command buffer:
Offset	Size	Description	(Table 1649)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	device number
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size
SeeAlso: #1650

Format of FaxBIOS IOCTL_DIAL command buffer:
Offset	Size	Description	(Table 1650)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	device number
 0Eh  6 BYTEs	country code
 14h  6 BYTEs	city or area code
 1Ah 14 BYTEs	local number
 28h 14 BYTEs	extension
 36h 14 BYTEs	reserved
 4Eh  6 BYTEs	future expansion
 54h	WORD	structure size
SeeAlso: #1649
--------N-2F8100-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - INSTALLATION CHECK
	AX = 8100h
Return: AL = FFh if installed
Program: TurboNET is a NetBIOS-based file redirector and server; a
	  demonstration version may be downloaded from Nanosoft's BBS
SeeAlso: AX=8000h"TurboNET"
--------N-2F8101-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8101h
Return: AL = ???
	DL = ???
--------N-2F8102-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8102h
Return: AL = ???
	DL = ???
--------N-2F8103-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - GET MACHINE NAME???
	AX = 8103h
	ES:DI -> 17-byte buffer
Return: buffer filled
--------N-2F8104-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8104h
	BL = ???
	BH = ???
	CX = ???
	DX = ???
	DS:SI -> 16-byte buffer containing ???
Return: AL = 00h ???
--------N-2F8105-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8105h
	CX = ??? (don't change current value if 0000h)
	DX = ??? (don't change current value if 0000h)
Return: AL = 00h successful
--------s-2F8200-----------------------------
INT 2F - RESPLAY - SAMPLE/PLAYBACK
	AX = 8200h
	DX:DI -> start of sample space
	CX:BX = length in bytes
Return: AX = status (see #1651)
Program: RESPLAY is a freeware sound sampling/playback utility by Mark J. Cox
SeeAlso: AX=8201h"RESPLAY",AX=8210h

(Table 1651)
Values for RESPLAY status:
 1000h	successful
 2000h	not initialized (see AX=8210h)
 other	RESPLAY not installed
--------G-2F8200-----------------------------
INT 2F U - Nanosoft, Inc. CAPDOS - INSTALLATION CHECK
	AX = 8200h
Return: AL = FFh if installed
Program: CAPDOS is a TSR by Nanosoft, Inc. which allows INT 21h calls to be
	  captured and recorded for later analysis
SeeAlso: AX=8100h,AX=8201h"CAPDOS",AX=8202h"CAPDOS",AX=8203h"CAPDOS"
SeeAlso: AX=8204h"CAPDOS"
--------s-2F8201-----------------------------
INT 2F - RESPLAY - INSTALLATION CHECK
	AX = 8201h
Return: AX = 7746h if installed
SeeAlso: AX=8202h"RESPLAY",AX=8210h
--------G-2F8201-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - CLEAR QUEUE
	AX = 8201h
Note:	resets queue of captured INT 21 calls
SeeAlso: AX=8200h"CAPDOS"
--------s-2F8202-----------------------------
INT 2F - RESPLAY - UNINSTALL
	AX = 8202h
Return: AX = status
	    1000h successful
SeeAlso: AX=8201h"RESPLAY",AX=8210h"RESPLAY"
--------G-2F8202-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - START COLLECTION
	AX = 8202h
SeeAlso: AX=8200h"CAPDOS",AX=8203h"CAPDOS"
--------G-2F8203-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - STOP COLLECTION
	AX = 8203h
SeeAlso: AX=8200h"CAPDOS",AX=8202h"CAPDOS",AX=8204h"CAPDOS"
--------G-2F8204-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - GET QUEUE PARAMETERS
	AX = 8204h
Return: AH = flag: queue wrapped if nonzero
	BX = index of current start of queue
	CX = size of queue in entries
SeeAlso: AX=8200h"CAPDOS",AX=8202h"CAPDOS",AX=8205h"CAPDOS"
--------G-2F8205-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - GET QUEUE ITEM
	AX = 8205h
	BX = queue item number
Return: AX,BX,CX,DX,SI,DI,DS,ES as on entry to captured DOS call
SeeAlso: AX=8200h"CAPDOS",AX=8204h"CAPDOS"
--------s-2F8210-----------------------------
INT 2F - RESPLAY - INITIALIZE
	AX = 8210h
	BL = sound device number (see #1652)
	BH = sample rate in multiples of 250 Hz (14h to A0h)
	CL = direction
	    00h playback
	    01h sample
Return: AX = status (see #1651)
SeeAlso: AX=8200h"RESPLAY"

(Table 1652)
Values for RESPLAY sound device:
 00h	printer port LPT1
 01h	printer port LPT2
 02h	prototype board at I/O address 0300h
 03h	printer port (alternative LPT1)
 04h	internal speaker
----------2F86-------------------------------
INT 2F U - ???
	AH = 86h
	AL = function (at least 06h and 07h)
	???
Return: ???
Note:	called by Codeview for Windows
SeeAlso: AH=44h
--------U-2F8900-----------------------------
INT 2F - WHOA!.COM - INSTALLATION CHECK
	AX = 8900h
Return: AL = state
	    00h not installed
	    FFh installed
Program: WHOA!.COM is a system slow-down utility by Brad D Crandall
SeeAlso: AX=8901h,AX=8902h
--------U-2F8901-----------------------------
INT 2F - WHOA!.COM - UNINSTALL
	AX = 8901h
Return: AL = status
	    FDh successful
	    FEh error
SeeAlso: AX=8900h
--------U-2F8902-----------------------------
INT 2F - WHOA!.COM - SET DELAY COUNT
	AX = 8902h
	BX = delay count (larger values slow system down more)
Return: AL = status
	    FDh successful
	    FEh error
Program: WHOA!.COM is a system slow-down utility by Brad D Crandall
SeeAlso: AX=8900h
--------U-2F9000-----------------------------
INT 2F U - RAID - INSTALLATION CHECK
	AX = 9000h
Return: AL = FFh if installed
Program: RAID (Resident AID) is a TSR utility program by Ross Neilson Wentworth
	  that resides mostly in EMS
--------U-2F9001-----------------------------
INT 2F U - RAID - GET ???
	AX = 9001h
Return: DX:AX -> ???
SeeAlso: AX=9000h
--------U-2F9002-----------------------------
INT 2F U - RAID - GET RESIDENT SEGMENT
	AX = 9002h
Return: AX = segment of resident (conventional memory) portion
SeeAlso: AX=9000h
--------U-2F9003-----------------------------
INT 2F U - RAID - UNINSTALL
	AX = 9003h
Return: ???
SeeAlso: AX=9000h
--------U-2F9004-----------------------------
INT 2F U - RAID - GET ???
	AX = 9004h
Return: AX = first available paragraph past end of resident portion???
	CX destroyed
SeeAlso: AX=9000h
--------e-2F92-------------------------------
INT 2F - Network Courier E-Mail - API
	AH = 92h
	AL = function
	    00h installation check
	    01h uninstall
	    02h pop down MICRO.EXE notification window
	    03h ???
	    04h ???
	    05h ???
Return: ???
Program: The Network Courier is an electronic mail package by Consumers
	  Software of Vancouver, BC which was bought by Microsoft in 1991 and
	  renamed Microsoft Mail v3.0.
SeeAlso: AX=9400h,AX=9401h,AX=9402h,AH=9Ch
Index:	installation check;Network Courier E-Mail
Index:	uninstall;Network Courier E-Mail
--------R-2F9200-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - BUG
	AX = 9200h
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
BUG:	jumps to data because jump table entry is 0000h
Note:	DRIVEMAP returns AX=FFFFh if not a valid function number in AL
--------R-2F9201-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - CHECK IF MAPPED DRIVE
	AX = 9201h
	DL = drive number (01h = A:, etc.)
Return: AL = 92h if mapped drive
	AH may be destroyed (v8.0 DRIVEMAP returns AX=0000h if not mapped)
SeeAlso: AX=9204h,AX=920Bh
--------R-2F9202-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - UNINSTALL
	AX = 9202h
	BX = caller's CS
Return: AX = status
	    0000h failed
	    nonzero successful
SeeAlso: AX=9204h
--------R-2F9203-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET VERSION
	AX = 9203h
Return: AH = major version
	AL = minor version
	CX = segment of resident code
Note:	the DRIVEMAP included with PC Tools v8.0 is version 1.00
SeeAlso: AX=9204h,INT 16/AX=FF70h
--------R-2F9204-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - INSTALLATION CHECK
	AX = 9204h
Return: AX = 9200h if installed
	   BL = ???
	   CX = segment of resident code
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
SeeAlso: AX=9201h,AX=9202h,AX=9203h
--------R-2F9205-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - SET ???
	AX = 9205h
	BX = ??? to set
Return: CX = new value of ???
--------R-2F9206-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9206h
	???
Return: ???
--------R-2F9207-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 9207h
	???
Return: AX = ???
--------R-2F9208-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9208h
	???
Return: ???
--------R-2F9209-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9209h
	???
Return: AX = ???
	BX = ???
	CX = ???
	DX = ???
--------R-2F920A-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 920Ah
	BX = ???
Return: AX = ??? or FFFBh on error
--------R-2F920B-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - SET DRIVE MAPPING
	AX = 920Bh
	BL = drive letter (41h ['A'] = A:, etc)
	CX = ??? (0000h removes mapping)
Return: AX = ??? or FFF8h on error
SeeAlso: AX=9201h,AX=920Dh
--------R-2F920C-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 920Ch
	???
Return: AX = ??? (0002h)
	CX = ??? (0000h)
--------R-2F920D-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET DRIVE TYPE
	AX = 920Dh
	BL = drive letter (41h ['A'] = A:, etc)
Return: AX = type flags
		bit 0: ???
		bit 1: available
		bit 5: local
	BX = ???
	CX = segment of resident code (apparently an unintended side effect)
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
SeeAlso: AX=9218h,INT 16/AX=FF70h
--------R-2F920E-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - SET LPT MAPPING
	AX = 920Eh
	BX = port number (0-2)
	CX = ??? (0000h to unmap)
Return: ???
--------R-2F920F-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 920Fh
	ES:DI -> 3-byte buffer for ???
Return: CX = 0000h
	ES:DI buffer filled
--------R-2F9210-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9210h
	???
Return: ???
--------R-2F9211-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 9211h
	ES:DI -> 8-word buffer for ???
Return: CX = 0000h
	ES:DI buffer filled
--------R-2F9212-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - CRITICAL SECTION???
	AX = 9212h
	BX = phase
	    0000h leave critical section???
	    nonzero enter critical section???
--------R-2F9213-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9213h
	BX = function number (0000h-000Bh)
	???
Return: ???
--------R-2F9214-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 9214h
	ES:DI -> 6-word buffer for ???
Return: CX = 0000h
	AX = ???
	ES:DI buffer filled
--------R-2F9215-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 9215h
	ES:DI -> 100-word buffer for ???
Return: CX = 0000h
	ES:DI buffer filled
--------R-2F9216-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9216h
	ES:DI -> ???
Return: ???
--------R-2F9217-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9217h
	DS:SI -> 25-word buffer containing ???
Return: ???
--------R-2F9218-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET LPT TYPE???
	AX = 9218h
	BX = port number???
Return: AX = ???
	BX = ??? (0000h)
	CX = ??? (0000h)
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
--------R-2F9219-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9219h
	???
Return: ???
--------R-2F921A-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 921Ah
	???
Return: AH = ???
	AL = ???
	BX = ???
--------R-2F921B-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 921Bh
	???
Return: AX = ???
	CX = segment of resident code (apparently an unintended side effect)
--------R-2F921C-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 921Ch
	???
Return: ???
--------R-2F921D-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 921Dh
Return: AX = ???
--------R-2F921E-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 921Eh
	???
Return: ???
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
Note:	this function sets two variables to 24h each
SeeAlso: INT 16/AX=FF70h
--------V-2F93-------------------------------
INT 2F - InnerMission v1.7+ - INSTALLATION CHECK
	AH = 93h
	BX = CX = AX
Return: AL = state
	    FFh if installed and BX=CX=AX on entry
		BX = segment of resident code
	    01h if installed but BX or CX differ from AX (multiplex number not
		  available)
Program: InnerMission is a shareware graphical screen blanker by Kevin Stokes
SeeAlso: INT 14/AX=AA01h,INT 2F/AX=6400h
Index:	screen saver;InnerMission
--------e-2F9400-----------------------------
INT 2F - MICRO.EXE - INSTALLATION CHECK
	AX = 9400h
Return: AL = 07h or 08h if installed
Program: MICRO.EXE is a TSR of the Microsoft Mail part of Workgroup Connection
SeeAlso: AH=92h"Network Courier",AX=9401h,AX=9402h,AX=9403h,AX=9404h
SeeAlso: INT 21/AH=3Fh"WORKGRP.SYS"
--------e-2F9401-----------------------------
INT 2F - MICRO.EXE - SET ??? FLAG
	AX = 9401h
SeeAlso: AX=9400h,AX=9403h
--------e-2F9402-----------------------------
INT 2F - MICRO.EXE - ???
	AX = 9402h
	???
Return: ???
SeeAlso: AX=9400h
--------e-2F9403-----------------------------
INT 2F - MICRO.EXE - SET ??? FLAG
	AX = 9403h
SeeAlso: AX=9400h,AX=9404h
--------e-2F9404-----------------------------
INT 2F - MICRO.EXE - CLEAR ??? FLAG
	AX = 9404h
	ES:DI -> name of executable from which MICRO.EXE was started
Note:	if the specified name is identical to the name of the program file
	  from which MICRO was started, the ??? flag is cleared; otherwise,
	  it is left unchanged
SeeAlso: AX=9400h,AX=9403h
--------V-2F96C7-----------------------------
INT 2F U - STRETCH - INSTALLATION CHECK
	AX = 96C7h
Return: AX = AAAAh if installed
Program: stretch.exe is a TSR for Toshiba Laptops to avoid blank screen areas
	  in VGA text modes by increasing inter-line spacing
--------e-2F9C-------------------------------
INT 2F - Network Courier E-Mail OPERATOR.EXE - API
	AH = 9Ch
	AL = subfunction
	    01h uninstall
Return: ???
Program: The Network Courier is an electronic mail package by Consumers
	  Software of Vancouver, BC which was bought by Microsoft in 1991 and
	  renamed Microsoft Mail v3.0.
SeeAlso: AH=92h
Index:	uninstall;Network Courier E-Mail OPERATOR.EXE
--------G-2F9E00-----------------------------
INT 2F U - INTMON v2.1 - INSTALLATION CHECK
	AX = 9E00h
Return: AX = FFFFh if installed
	    BX = segment of resident code
Program: INTMON is a shareware interactive interrupt monitoring TSR for 386
	  and higher machines by Celso Minnitti, Jr.
SeeAlso: AX=9E01h,AX=9E02h,AX=9E03h,AX=9F00h
--------G-2F9E01-----------------------------
INT 2F U - INTMON v2.1 - RESET
	AX = 9E01h
Return: ???
Desc:	this function specifies that INTMON should assume that any interrupts
	  on which it is currently awaiting a return have completed (i.e.
	  interrupts which never return such as INT 20 and INT 27)
SeeAlso: AX=9E00h,AX=9E03h
--------G-2F9E02-----------------------------
INT 2F U - INTMON v2.1 - DISPLAY CPU REGISTERS???
	AX = 9E02h
Return: ???
SeeAlso: AX=9E00h
--------G-2F9E03-----------------------------
INT 2F U - INTMON v2.1 - HOOK INTERRUPT???
	AX = 9E03h
	BH = interrupt number???
Return: ???
Note:	if AL > 03h on entry, INTMON 2.1 returns immediately
SeeAlso: AX=9E00h,AX=9E01h
--------G-2F9F00-----------------------------
INT 2F U - INTCFG v2.1 - INSTALLATION CHECK
	AX = 9F00h
Return: AX = FFFFh if installed
Program: INTCFG is an optionally-resident control program for INTMON by Celso
	  Minnitti, Jr.
SeeAlso: AX=9E00h,AX=9F01h,AX=9F30h,AX=9F49h
--------G-2F9F01-----------------------------
INT 2F U - INTCFG v2.1 - ???
	AX = 9F01h
	???
Return: ???
SeeAlso: AX=9F00h
--------G-2F9F30-----------------------------
INT 2F U - INTCFG v2.1 - GET ???
	AX = 9F30h
Return: AX = ??? (0002h)
SeeAlso: AX=9F00h
--------G-2F9F49-----------------------------
INT 2F U - INTCFG v2.1 - UNINSTALL
	AX = 9F49h
Return: AX,DX,DS,ES destroyed
SeeAlso: AX=9F00h
--------E-2FA1--BX0081-----------------------
INT 2F - Ergo DOS extenders - INSTALLATION CHECK
	AH = A1h
	BX = 0081h
	AL = which
	    FEh OS/286,OS/386
	    FFh HummingBoard DOS extender
	ES:DI -> 16-byte buffer
Return: if installed, first four bytes of ES:DI buffer are "IABH"
Note:	since TKERNEL is a licensed version, it is likely that subfunctions
	  BX=0082h and BX=0084h are present and function identically to the
	  AX=FBA1h/BX=008xh calls
SeeAlso: AX=ED00h,AX=FBA1h/BX=0081h,INT 15/AX=BF02h
--------m-2FA189-----------------------------
INT 2F U - Biologic HRAMDEV.SYS - API
	AX = A189h
	BX = subfunction
	    0000h set ???
	    0001h remove ???
	    0002h get status ???
	    0003h enable ???
	    0004h disable ???
	    0005h set ??? flag
	    0006h clear ??? flag
	    0007h set ??? flag
	    0008h clear ??? flag
	    0009h set ???
	ES:DI -> function-specific arguments
		if func 0000h: 20-byte buffer containing ???
		if func 0001h: 20-byte buffer for returned ???
		if func 0002h: 16-byte buffer for returned ???
		if func 0009h: WORD containing ???
Return: BX = A189h if installed
	AH = status
	    00h successful
	    FFh failed or invalid function number
Program: HRAMDEV.SYS is a part of the shareware package HRAM by Biologic which
	  provides improved high memory access under MS-DOS 5.0
Note:	functions 00h and 01h use a stack of four entries; function 01h always
	  removes the values stored with the most recent function 00h call
	  which has not yet been matched with a function 01h call.
--------U-2FA4E0-----------------------------
INT 2F - Futurus Team - INSTALLATION CHECK
	AX = A4E0h
Return: AL = 52h ("R") if installed
	    AH = major version plus 30h ("0")
	    ES:BX -> ??? (INT A4 handler???)
Note:	older versions of Right Hand Man (from which Team evolved) store the
	  signature "RH" at offset 103h in the INT 2F handler's segment
SeeAlso: INT A4"Right Hand Man"
--------U-2FA900-----------------------------
INT 2F - METZTSR.COM - INSTALLATION CHECK
	AX = A900h
	CF set
Return: CF clear if resident
	    AX = 97FFh
	CF set if not present
Notes:	METZTSR.COM prevents METZ applications (such as the MAGIC screen
	  saver) inactivity timeout while running a DOSapp under MS Windows.
	the default multiplex number is A9h, but may be set to any value from
	  80h to FFh with a commandline switch
SeeAlso: AX=A901h,AX=A902h
--------U-2FA901-----------------------------
INT 2F - METZTSR.COM - GET TIME OF LAST KEYBOARD ACTIVITY
	AX = A901h
	CF set
Return: CF clear if successful
	    AX:DX = BIOS time at which INT 09 was last invoked
	CF set if not present
SeeAlso: INT 09,INT 1A/AH=00h
--------U-2FA902-----------------------------
INT 2F - METZTSR.COM - SET METZ Ctrl-Alt-Del FLAG
	AX = A902h
	BL = new value
	    00h Ctrl-Alt-Del not allowed
	    else Ctrl-Alt-Del allowed (startup default is 01h)
	CF set
Return: CF clear if successful
	    AX = 97FFh
	CF set if not resident
SeeAlso: AX=A903h
--------U-2FA903-----------------------------
INT 2F - METZTSR.COM - GET METZ Ctrl-Alt-Del FLAG
	AX = A903h
	CF set
Return: CF clear if successful
	    AX = 97FFh if Ctrl-Alt-Del allowed
	    AX = 0000h if Ctrl-Alt-Del not allowed
	CF set if not resident
SeeAlso: AX=A902h
--------U-2FAA00-----------------------------
INT 2F - VIDCLOCK.COM - INSTALLATION CHECK
	AX = AA00h
Return: AL = 00h not installed
	     FFh installed
Program: VIDCLOCK.COM is a memory-resident clock by Thomas G. Hanlin III
--------f-2FAB00-----------------------------
INT 2F - Btrieve Multi-User - INSTALLATION CHECK
	AX = AB00h
Return: AL = 4Dh if installed
SeeAlso: AX=AB01h,AX=AB02h,INT 7B"Btrieve"
--------f-2FAB01-----------------------------
INT 2F - Btrieve Multi-User - EXECUTE Btrieve OPERATION
	AX = AB01h
	BX = process ID
	DS:DX -> 38-byte parameter record (see #2425 at INT 7B"Btrieve")
Return: AL = status
	    00h OK
	    other retry after calling INT 7F/AX=0200h
SeeAlso: AX=AB00h,AX=AB02h,INT 7B"Btrieve",INT 7F/AX=0200h
--------f-2FAB02-----------------------------
INT 2F - Btrieve Multi-User - GET NEW PROCESS ID
	AX = AB02h
Return: AL = 00h successful
	    BX = process ID
	AL > 00h failed, retry after calling INT 7F/AX=0200h
SeeAlso: AX=AB00h,AX=AB01h,INT 7B"Btrieve",INT 7F/AX=0200h
--------V-2FAC00-----------------------------
INT 2F - DOS 4.01+ GRAPHICS.COM - INSTALLATION CHECK
	AX = AC00h
Return: AX = FFFFh
	ES:DI -> ??? (graphics data?) (not documented)
Note:	this installation check was moved here to avoid the conflict with the
	  CD-ROM extensions that occurred in DOS 4.00
SeeAlso: AX=1500h"GRAPHICS"
--------V-2FAC00DI1092-----------------------
INT 2F - QRIP/TSR - GIVE CPU TO QRIP
	AX = AC00h
	DI = 1092h
Return: nothing
Program: QRIP/TSR is a shareware TSR by Shane Hathaway implementing the Remote
	  Imaging Protocol (RIP, RIPscrip) used by several BBS systems to
	  provide a graphical user interface
Desc:	give QRIP some CPU time to update music and flashing timers
Notes:	if DI <> 1092h on entry, QRIP chains the call
	this function should be called regularly whenever the terminal program
	  is otherwise idle; the updates are automatically performed on any
	  other QRIP call
SeeAlso: AX=AC01h,AX=ACF0h
--------V-2FAC01DI1092-----------------------
INT 2F - QRIP/TSR - CHANGE INTERNAL FLAGS
	AX = AC01h
	DI = 1092h
	BX = flags to be turned on (see #1653)
	CX = flags to be turned off (see #1653)
Return: AX = 9142h if installed
	    DX = DOS-takeover flag (nonzero if QRIP able to take over DOS)
	    ---if DX nonzero---
	    BX = QRIP version number in hex (BH = major, BL = minor)
	    CX = new flags (see #1653)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC00h/DI=1092h,AX=ACF0h

Bitfields for QRIP internal flags:
Bit(s)	Description	(Table 1653)
 0	ANSI emulation enabled (default on)
 1	RIP emulation enabled (default on)
 2	graphical commands allowed (default on)
 3	TTY text allowed (default on)
 4	disable @ variables (default off in TSR mode)
 5	wait for key on RIP "end scene" command (default off)
 6	anti-stripping (default off in TSR mode)
 7	sound enabled (default on)
 8	automatic message filter (default off in TSR mode)
 9	display-only mode (no user prompts)
 10	TTY text suppression (default off in TSR mode)
 11-15	reserved
--------V-2FAC02DI1092-----------------------
INT 2F - QRIP/TSR - TURN OFF GRAPHICS SCREEN
	AX = AC02h
	DI = 1092h
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC03h,AX=ACF0h
--------V-2FAC03DI1092-----------------------
INT 2F - QRIP/TSR - TURN ON GRAPHICS SCREEN
	AX = AC03h
	DI = 1092h
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	this function does not restore the contents of the screen (see AX=AC15h)
SeeAlso: AX=AC02h,AX=AC14h,AX=AC15h
--------V-2FAC04DI1092-----------------------
INT 2F - QRIP/TSR - OUTPUT STRING THROUGH QRIP
	AX = AC04h
	DI = 1092h
	DX:BX -> string
	CX = length of string
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC05h,AX=AC09h,AX=AC0Ah,AX=ACF0h
--------V-2FAC05DI1092-----------------------
INT 2F - QRIP/TSR - OUTPUT NULL-TERMINATED STRING THROUGH QRIP
	AX = AC05h
	DI = 1092h
	DX:BX -> ASCIZ string
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC04h,AX=AC06h,AX=AC09h,AX=AC0Ah,AX=ACF0h
--------V-2FAC06DI1092-----------------------
INT 2F - QRIP/TSR - RECEIVE CHARACTERS FROM QRIP
	AX = AC06h
	DI = 1092h
Return: AX = character to send to BBS (0001h-00FFh) or special code (see #1654)
	BX = string-waiting flag
	    0001h entire string waiting to be sent to terminal (call AX=AC0Ch)
	CX = DX = AX
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC04h,AX=AC05h,AX=AC0Ch,AX=AC16h,AX=AC18h,AX=AC1Ah

(Table 1654)
Values for QRIP special codes:
 0000h	if none
 0100h	wait for user keypress (must call AX=AC16h/BL=00h or AX=AC18h)
 0101h	both/middle mouse button pressed
 0102h	entering block mode (up/download) (call AX=AC1Ah)
 0103h	right mouse button pressed
 0104h	BBS requested status bar on
 0105h	BBS requested status bar off
 0106h	BBS requested VT-102 terminal emulation
	(keypad keys should send VT-102 escape codes)
 0107h	BBS requested VT-102 mode off
 0108h	BBS requested doorway mode (raw IBM keyboard ASCII/scan code pairs)
 0109h	BBS requested doorway mode off
 010Ah	hotkey mode on
 010Bh	hotkey mode off
 010Ch	BBS requested Tab-key button changing on
 010Dh	BBS requested Tab-key mode off
 010Eh	XOFF (use flow control to stop incoming characters)
 010Fh	XON (use flow control to resume incoming characters)
 0110h-0119h BBS requested application (0-9) be run
	application 0 should be a standard text editor
 01FFh	send ASCII 00h to BBS 
Note:	for special codes 0104h to 010Dh, the terminal program should report
	  any mode changes it make in response by calling AX=AC16h
--------V-2FAC07DI1092-----------------------
INT 2F - QRIP/TSR - GET FONT DIRECTORY
	AX = AC07h
	DI = 1092h
Return: DX:BX -> 80-byte internal buffer containing ASCIZ font directory name
Notes:	if DI <> 1092h on entry, QRIP chains the call
	the application may change the font directory by overwriting the
	  returned buffer, ensuring that it does not exceed 80 bytes incl. NUL
	if changed, the new path will not become effective until the graphics
	  screen is reinitialized
SeeAlso: AX=AC08h,AX=ACF0h
--------V-2FAC08DI1092-----------------------
INT 2F - QRIP/TSR - GET ICON DIRECTORY
	AX = AC08h
	DI = 1092h
Return: DX:BX -> 80-byte internal buffer containing ASCIZ icon directory name
Notes:	if DI <> 1092h on entry, QRIP chains the call
	the application may change the icon directory by overwriting the
	  returned buffer, ensuring that it does not exceed 80 bytes incl. NUL,
	  and includes a trailing backslash
	if changed, the new path becomes effective immediately
SeeAlso: AX=AC07h,AX=ACF0h
--------V-2FAC09DI1092-----------------------
INT 2F - QRIP/TSR - OUTPUT STRING THROUGH QRIP
	AX = AC09h
	DI = 1092h
	DX:BX -> string
	CX = length of string
Return: AX = character to send to BBS (0001h-00FFh) or special code (see #1654)
	BX = string-waiting flag
	    0001h entire string waiting to be sent to terminal (call AX=AC0Ch)
	CX = DX = AX
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC04h,AX=AC06h,AX=AC0Ah,AX=ACF0h
--------V-2FAC0ADI1092-----------------------
INT 2F - QRIP/TSR - OUTPUT NULL-TERMINATED STRING THROUGH QRIP
	AX = AC0Ah
	DI = 1092h
	DX:BX -> ASCIZ string
Return: AX = character to send to BBS (0001h-00FFh) or special code (see #1654)
	BX = string-waiting flag
	    0001h entire string waiting to be sent to terminal (call AX=AC0Ch)
	CX = DX = AX
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC05h,AX=AC06h,AX=AC09h,AX=ACF0h
--------V-2FAC0BDI1092-----------------------
INT 2F - QRIP/TSR - EXECUTE RIP "END SCENE" COMMAND
	AX = AC0Bh
	DI = 1092h
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	enables all mouse buttons and cancels the RIP timeout
SeeAlso: AX=AC01h,AX=AC04h,AX=ACF0h
--------V-2FAC0CDI1092-----------------------
INT 2F - QRIP/TSR - GET STRING TO BE SENT TO BBS
	AX = AC0Ch
	DI = 1092h
Return: AX = status
	    0000h nothing to be sent
	    0001h a string is waiting to be sent
		DX:BX -> string to be sent (may contain NULs)
		CX = length of string
	    0002h special code waiting (call AX=AC06h)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC06h,AX=ACF0h
--------V-2FAC0DDI1092-----------------------
INT 2F - QRIP/TSR - SET PROTECTED SCREEN AREA
	AX = AC0Dh
	DI = 1092h
	CL = number of text lines at bottom of screen to protect (00h = off)
	BL = attribute with which to fill area (bit 7 = high-int. background)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Eh,AX=AC0Fh,AX=AC10h,AX=ACF0h
--------V-2FAC0EDI1092-----------------------
INT 2F - QRIP/TSR - WRITE ASCIZ STRING IN PROTECTED AREA
	AX = AC0Eh
	DI = 1092h
	DX:BX -> ASCIZ string to be written
	CL = column at which to begin writing
	CH = row number within protected area (00h = first line)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Dh,AX=AC0Fh,AX=AC10h,AX=ACF0h
--------V-2FAC0FDI1092-----------------------
INT 2F - QRIP/TSR - SCROLL PROTECTED AREA
	AX = AC0Fh
	DI = 1092h
	BH,BL = row,column of upper-left corner in protected area
	DH,DL = row,column of lower-right corner
	CL = number of lines to scroll up
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Dh,AX=AC0Eh,AX=AC10h,AX=ACF0h
--------V-2FAC10DI1092-----------------------
INT 2F - QRIP/TSR - SET OUTPUT COLOR FOR PROTECTED AREA
	AX = AC10h
	DI = 1092h
	BL = new attribute (bit 7 set for high-intensity background)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Dh,AX=AC0Eh,AX=AC0Fh,AX=AC11h,AX=ACF0h
--------V-2FAC11DI1092-----------------------
INT 2F - QRIP/TSR - CONVERT PROTECTED AREA TO ENTIRE SCREEN
	AX = AC11h
	DI = 1092h
	BX = mode (0000h = normal protect, 0001h = allow full-screen access)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Dh,AX=AC0Eh,AX=AC0Fh,AX=AC10h,AX=AC12h,AX=ACF0h
--------V-2FAC12DI1092-----------------------
INT 2F - QRIP/TSR - BEGIN POPUP-WINDOW MODE
	AX = AC12h
	DI = 1092h
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	while popup-mode is in effect, the terminal program can write to the
	  screen (and easily restore it) by outputting a RIP file with AX=AC04h
	  or AX=AC05h
	QRIP will automatically drop out of popup-window mode if the terminal
	  program invokes RIP pick-lists
	any changes to the protected area will be restored when popup-window
	  mode is cancelled
SeeAlso: AX=AC04h,AX=AC11h,AX=AC13h,AX=ACF0h
--------V-2FAC13DI1092-----------------------
INT 2F - QRIP/TSR - END POPUP-WINDOW MODE
	AX = AC13h
	DI = 1092h
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	restores screen
SeeAlso: AX=AC12h,AX=ACF0h
--------V-2FAC14DI1092-----------------------
INT 2F - QRIP/TSR - SAVE GRAPHICS SCREEN AND SWITCH TO TEXT MODE
	AX = AC14h
	DI = 1092h
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC03h,AX=AC15h
--------V-2FAC15DI1092-----------------------
INT 2F - QRIP/TSR - RESTORE GRAPHICS SCREEN
	AX = AC15h
	DI = 1092h
Return: nothing
Desc:	restores the graphics screen saved by the last call to AX=AC14h
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC03h,AX=AC14h
--------V-2FAC16DI1092-----------------------
INT 2F - QRIP/TSR - REPORT MODE CHANGE TO QRIP
	AX = AC16h
	DI = 1092h
	BL = new mode
	    00h terminate key wait
	    01h status bar on
	    02h status bar off
	    03h VT-102 mode on
	    04h VT-102 mode off
	    05h doorway mode on
	    06h doorway mode off
	    07h hotkeys mode on
	    08h hotkeys mode off
	    09h tabkey mode on
	    0Ah tabkey mode off
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	all modes default to OFF when QRIP is first installed
--------V-2FAC17DI1092-----------------------
INT 2F - QRIP/TSR - CALL (EXECUTE) A RIP FILE
	AX = AC17h
	DI = 1092h
	DX:BX -> ASCIZ filename for RIP file to be executed
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	the specified file may be in the current icon directory, the QRIP
	  startup directory, or the current directory; any pathnames specified
	  with the filename are ignored
--------V-2FAC18DI1092-----------------------
INT 2F - QRIP/TSR - SEND USER KEY TO QRIP
	AX = AC18h
	DI = 1092h
	BX = key (00xxh is normal ASCII, xx00h is an extended key)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC06h,AX=ACF0h
--------V-2FAC19DI1092-----------------------
INT 2F - QRIP/TSR - HANGUP
	AX = AC19h
	DI = 1092h
Return: nothing
Desc:	inform QRIP that carrier has been lost
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=ACF0h
--------V-2FAC1ADI1092-----------------------
INT 2F - QRIP/TSR - GET RIP_ENTER_BLOCK_MODE INFORMATION
	AX = AC1Ah
	DI = 1092h
Return: AH = requested protocol (see #1655)
	AL = file type (see #1656)
	DX:BX -> ASCIZ filename or 0000h:0000h
	CX = length of filename
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=ACF0h

(Table 1655)
Values for QRIP protocol identifier:
 00h	Xmodem (checksum)
 01h	Xmodem-CRC
 02h	Xmodem-1K
 03h	Xmodem-1K-G
 04h	Kermit
 05h	Ymodem
 06h	Ymodem-G
 07h	Zmodem with crash recovery
 08h-0Fh same as 00h-07h, but for uploading instead of downloading
SeeAlso: #1656

(Table 1656)
Values for QRIP file type:
 00h	RIP file sequence to be displayed
 01h	RIP file sequence to be stored in icon directory
 02h	ICN file sequence to be stored in icon directory
 03h	HLP file sequence to be stored, then auto-loaded if needed
 04h	COMPOSITE DYNAMIC file sequence (batch protocols only)
 05h	ACTIVE DYNAMIC file sequence (batch protocols only)
Note:	for file types 04h and 05h, any .RIP or .ICN files are stored in
	  the icon directory; in mode 05h, any .RIP files are also played
	  back as they are received
SeeAlso: #1655
--------V-2FAC1BDI1092-----------------------
INT 2F - QRIP/TSR - SET SYSTEM FONT SIZE
	AX = AC1Bh
	DI = 1092h
	BX = font size (see #1657)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC04h,AX=ACF0h

(Table 1657)
Values for QRIP font size specifier:
 00h	8x8 font, 80x43 screen
 01h	7x8 font, 90x43 screen
 02h	8x14 font, 80x25 screen
 03h	7x14 font, 90x25 screen
 04h	16x14 font, 40x25 screen
--------V-2FACF0DI1092-----------------------
INT 2F - QRIP/TSR - INSTALLATION CHECK
	AX = ACF0h
	DI = 1092h
Return: AX = 9142h if installed
	    DX = DOS-takeover flag (nonzero if QRIP able to take over DOS)
	    ---if DX nonzero---
	    BX = QRIP version number in hex (BH = major, BL = minor)
	    CX = current flags (see AX=AC01h)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC00h/DI=1092h,AX=AC01h,AX=AC04h,AX=AC06h,AX=AC1Ah,AX=ACFFh
--------V-2FACFFDI1092-----------------------
INT 2F - QRIP/TSR - UNINSTALL
	AX = ACFFh
	DI = 1092h
Return: AX = status
	    0000h unable to remove (interrupt vector hooked by another prog)
	    0001h successful
	    0002h unable to take over DOS at this time (retry uninstall)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=ACF0h
--------V-2FAD00-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - INSTALLATION CHECK
	AX = AD00h
Return: AL = FFh if installed
	    BX = ??? (0100h for MS-DOS 3.3+)
Note:	DOS 5+ DISPLAY.SYS chains to previous handler if AL is not one of the
	  subfunctions listed here
--------O-2FAD00-----------------------------
INT 2F U - DR-DOS 3.41,5.0 KEYB - INSTALLATION CHECK
	AX = AD00h
Return: AX = FFFFh if installed
SeeAlso: AX=AD80h
--------V-2FAD01-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - SET ACTIVE CODE PAGE
	AX = AD01h
	BX = new code page
Return: CF clear if successful
	    AX = 0001h
	CF set on error (unsupported code page)
	    AX = 0000h
SeeAlso: AX=AD02h
--------O-2FAD01-----------------------------
INT 2F U - DR-DOS 3.41,5.0 KEYB - GET CONFIGURATION
	AX = AD01h
Return: BX = current code page
	CX = current keyboard layout (0100h = US, 0102h = foreign)
	ES = resident code segment
SeeAlso: AX=AD83h
--------V-2FAD02-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - GET ACTIVE CODE PAGE
	AX = AD02h
Return: CF set if code page never set
	    AX = 0001h
	    BX = FFFFh (assume first hardware code page)
	CF clear if successful
	    BX = current code page
SeeAlso: AX=AD01h,AX=AD03h
--------V-2FAD03-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - GET CODE PAGE INFORMATION
	AX = AD03h
	ES:DI -> buffer for code page information (see #1658)
	CX = size of buffer in bytes
Return: CF set if buffer too small
	CF clear if successful
	    ES:DI buffer filled
SeeAlso: AX=AD01h,AX=AD02h

Format of DOS 5.0-6.0 DISPLAY.SYS code page information:
Offset	Size	Description	(Table 1658)
 00h	WORD	number of software code pages
 02h	WORD	??? (0003h)
 04h	WORD	number of hardware code pages
 06h  N WORDs	hardware code page numbers
      N WORDs	software (prepared) code pages (FFFFh if not yet prepared)
--------V-2FAD04-----------------------------
INT 2F U - DOS 4.x only DISPLAY.SYS internal - ???
	AX = AD04h
	???
Return: ???
--------V-2FAD10-----------------------------
INT 2F U - DOS 4.x DISPLAY.SYS internal - INSTALLATION CHECK???
	AX = AD10h
	???
Return: AX = FFFFh
	BX = ??? (0100h in PC-DOS 4.01)
--------V-2FAD10-----------------------------
INT 2F U - DOS 5+ DISPLAY.SYS internal - ???
	AX = AD10h
	???
Return: CF clear if successful
	CF set on error
Note:	this function is a NOP if the active code page has never been set
	  (AX=AD02h returns BX=FFFFh); its purpose otherwise is not known
--------V-2FAD40-----------------------------
INT 2F - DOS 4+ - ???
	AX = AD40h
	DX = ???
	???
Return: ???
Note:	called by PC-DOS 4.01 PRINT.COM
--------K-2FAD80-----------------------------
INT 2F u - DOS 3.3+ KEYB.COM internal - INSTALLATION CHECK
	AX = AD80h
Return: AL = FFh if installed
	    BX = version number (BH = major, BL = minor)
	    ES:DI -> internal data (see #1659)
Notes:	MS-DOS 3.30, PC-DOS 4.01, and MS-DOS 5.00 all report version 1.00.
	this function was undocumented prior to the release of DOS 5.0

Format of KEYB internal data:
Offset	Size	Description	(Table 1659)
 00h	DWORD	original INT 09
 04h	DWORD	original INT 2F
 08h  6 BYTEs	???
 0Eh	WORD	flags
 10h	BYTE	???
 11h	BYTE	???
 12h  4 BYTEs	???
 16h  2 BYTEs	country ID letters
 18h	WORD	current code page
---DOS 3.3---
 1Ah	WORD	pointer to first item in list of code page tables???
 1Ch	WORD	pointer to ??? item in list of code page tables
 1Eh  2 BYTEs	???
 20h	WORD	pointer to key translation data (see #1661)
 22h	WORD	pointer to last item in code page table list (see #1660)
 24h  9 BYTEs	???
---DOS 4.01---
 1Ah  2 BYTEs	???
 1Ch	WORD	pointer to first item in list of code page tables???
 1Eh	WORD	pointer to ??? item in list of code page tables
 20h  2 BYTEs	???
 22h	WORD	pointer to key translation data (see #1661)
 24h	WORD	pointer to last item in code page table list (see #1660)
 26h  9 BYTEs	???

Format of code page table list entries:
Offset	Size	Description	(Table 1660)
 00h	WORD	pointer to next item, FFFFh = last
 02h	WORD	code page
 04h  2 BYTEs	???

Format of KEYB translation data:
Offset	Size	Description	(Table 1661)
 00h	WORD	size of data in bytes, including this word
 02h N-2 BYTEs	???
--------K-2FAD81-----------------------------
INT 2F - DOS 3.3+ KEYB.COM - SET KEYBOARD CODE PAGE
	AX = AD81h
	BX = code page (see #0962 at INT 21/AX=6601h)
Return: CF set on error
	    AX = 0001h (code page not available)
	CF clear if successful
Notes:	called by DISPLAY.SYS
	this function was undocumented prior to the release of DOS 5.0
SeeAlso: AX=AD82h
--------K-2FAD82-----------------------------
INT 2F - DOS 3.3+ KEYB.COM - SET KEYBOARD MAPPING
	AX = AD82h
	BL = new state
	    00h US keyboard (Control-Alt-F1)
	    FFh foreign keyboard (Control-Alt-F2)
Return: CF set on error (BL not 00h or FFh)
	CF clear if successful
Note:	this function was undocumented prior to the release of DOS 5.0
SeeAlso: AX=AD81h,AX=AD83h
--------K-2FAD83-----------------------------
INT 2F - DOS 5+ KEYB.COM - GET KEYBOARD MAPPING
	AX = AD83h
Return: BL = current state
	    00h US keyboard
	    FFh foreign keyboard
SeeAlso: AX=AD82h
--------l-2FAE00-----------------------------
INT 2F U - DOS 3.3+ internal - INSTALLABLE COMMAND - INSTALLATION CHECK
	AX = AE00h
	DX = magic value FFFFh
	CH = FFh
	CL = length of command line tail (4DOS v4.0)
	DS:BX -> command line buffer (see #1662)
	DS:SI -> command name buffer (see #1663)
	DI = 0000h (4DOS v4.0)
Return: AL = FFh if this command is a TSR extension to COMMAND.COM
	AL = 00h if the command should be executed as usual
Notes:	This call provides a mechanism for TSRs to install permanent
	  extensions to the command repertoire of COMMAND.COM.	It appears
	  that COMMAND.COM makes this call before executing the current
	  command line, and does not execute it itself if the return is FFh.
	APPEND hooks this call, to allow subsequent APPEND commands to
	  execute without re-running APPEND
SeeAlso: AX=AE01h

Format of COMMAND.COM command line buffer:
Offset	Size	Description	(Table 1662)
 00h	BYTE	max length of command line, as in INT 21/AH=0Ah
 01h	BYTE	count of bytes to follow, excluding terminating 0Dh
      N BYTEs	command line text, terminated by 0Dh

Format of command name buffer:
Offset	Size	Description	(Table 1663)
 00h	BYTE	length of command name
 01h  N BYTEs	uppercased command name (blank-padded to 11 chars by 4DOS v4)
--------l-2FAE01-----------------------------
INT 2F U - DOS 3.3+ internal - INSTALLABLE COMMAND - EXECUTE
	AX = AE01h
	DX = magic value FFFFh
	CH = 00h
	CL = length of command name (4DOS v4.0)
	DS:BX -> command line buffer (see #1662)
	DS:SI -> command name buffer (see #1663)
Return: DS:SI buffer updated
	  if length byte is nonzero, the following bytes contain the uppercase
	  internal command to execute and the command line buffer contains the
	  command's parameters (the first DS:[SI] bytes are ignored)
Notes:	this call requests execution of the command which a previous call to
	  AX=AE00h indicated was resident
	APPEND hooks this call
BUG:	Novell DOS 7.0's COMMAND.COM will attempt to run a disk program with
	  the indicated name even if the returned length byte is zero, because
	  the register used to flag this case is clobbered without first
	  checking it.	The workaround is to set the command name buffer to
	  "REM" followed by enough blanks to pad out the original command's
	  length, which will also work with MS-DOS 6.
	  (from padgett@tccslr.dnet.mmc.com)
SeeAlso: AX=AE00h
----------2FAF00-----------------------------
INT 2F U - ???
	AX = AF00h
	???
Return: AX = 0000h if interface supported
SeeAlso: AX=AF02h,AX=AF03h,AX=AF04h,AX=AF13h,AX=AF30h
----------2FAF02-----------------------------
INT 2F U - ???
	AX = AF02h
	???
Return: ES = ???
SeeAlso: AX=AF00h
----------2FAF03-----------------------------
INT 2F U - ???
	AX = AF03h
	???
Return: DX = ???
SeeAlso: AX=AF00h
----------2FAF04-----------------------------
INT 2F U - ???
	AX = AF04h
	???
Return: ???
SeeAlso: AX=AF00h
----------2FAF05-----------------------------
INT 2F U - ???
	AX = AF05h
	???
Return: ???
SeeAlso: AX=AF00h
----------2FAF12-----------------------------
INT 2F U - ???
	AX = AF12h
	???
Return: ES = ???
SeeAlso: AX=AF00h
----------2FAF13-----------------------------
INT 2F U - ???
	AX = AF13h
	???
Return: ???
SeeAlso: AX=AF00h
----------2FAF30-----------------------------
INT 2F U - ???
	AX = AF30h
	???
Return: ???
SeeAlso: AX=AF00h
----------2FAFDE-----------------------------
INT 2F - Disk-Emu - INSTALLATION CHECK / VERSION CHECK
	AX = AFDEh
	ES:DI -> 14-byte buffer for data (see #1664)
Return: AX = CFDEh (Carlos Fernandez Disk-Emu) if installed
	    BX = version (BH = major, BL = minor)

Format of Disk-Emu information data:
Offset	Size	Description	(Table 1664)
 00h	BYTE	number of tracks
 01h	BYTE	sectors per track
 02h	WORD	bytes per sector
 04h	BYTE	number of heads
 05h	BYTE	flag: 00h inactive, 01h active
 06h	BYTE	write protection (00h none, 01h full, 02h pseudo)
 07h	BYTE	saved (00h some unsaved data, 01h all data saved)
 08h	BYTE	disk in memory (00h no, 01h yes)
 09h	WORD	EMS handle
 0Bh	WORD	XMS handle
 0Dh	BYTE	memory type used for disk (00h XMS, 01h EMS)
--------V-2FB000-----------------------------
INT 2F - DOS 3.3+ GRAFTABL.COM - INSTALLATION CHECK
	AX = B000h
Return: AL = status
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
Notes:	called by DISPLAY.SYS
	documented for DOS 5.0, but undocumented in prior versions
SeeAlso: AX=2300h,AX=2E00h,AX=B001h
--------V-2FB001-----------------------------
INT 2F - DOS 3.3+ GRAFTABL.COM - GET GRAPHICS FONT TABLE
	AX = B001h
	DS:BX -> DWORD buffer for address of 8x8 font table
Return: buffer filled
	AL = FFh
Note:	PC-DOS 3.30/4.01 and MS-DOS 6.0 set the font table offset to 0130h,
	  MS-DOS 3.30 sets it to 0030h
SeeAlso: AH=2Eh"GRAFTABL",AX=B000h
--------I-2FB400-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - INSTALLATION CHECK
	AX = B400h
Return: AL = FFh if installed
--------I-2FB401-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - GET HOST BUFFER ADDRESS
	AX = B401h
Return: ES -> host screen buffer (PC ASCII format)
	ES unchanged if communications not started
--------I-2FB402-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B402h
	BX = ???
Return: ???
--------I-2FB403-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B403h
	???
Return: ???
--------I-2FB404-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B404h
	???
Return: ???
--------I-2FB405-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B405h
	???
Return: ???
----------2FB700-----------------------------
INT 2F - APPEND - INSTALLATION CHECK
	AX = B700h
Return: AL = status
	    00h not installed
	    FFh installed
Note:	MS-DOS 3.30 APPEND refuses to install itself when run inside TopView or
	  a TopView-compatible environment
SeeAlso: AX=B702h
----------2FB701-----------------------------
INT 2F U - APPEND v3.21 only - GET APPEND PATH
	AX = B701h
Return: ES:DI -> active APPEND path
Notes:	the only version of APPEND known to support this call is the APPEND
	  shipped with Microtek MS-DOS 3.21; MS-DOS 3.30-6.00 APPEND displays
	  "Incorrect APPEND Version" and aborts the caller
	use AX=B704h first, and only call this function if that one is not
	  supported
SeeAlso: AX=B700h,AX=B704h
----------2FB702-----------------------------
INT 2F - APPEND - VERSION CHECK
	AX = B702h
Return: AX = FFFFh if not DOS 4.0 APPEND (also if DOS 5.0 APPEND)
	AL = major version number
	AH = minor version number, otherwise
SeeAlso: AX=B700h,AX=B710h
----------2FB703-----------------------------
INT 2F U - DOS 3.3, DOS 5.0 APPEND - HOOK INT 21
	AX = B703h
	ES:DI -> INT 21 handler APPEND should chain to
Return: ES:DI -> APPEND's INT 21 handler
Note:	each invocation of this function toggles a flag which APPEND uses to
	  determine whether to chain to the user handler or the original
	  INT 21
SeeAlso: AX=B700h,AX=B706h
----------2FB704-----------------------------
INT 2F - DOS 3.3+ APPEND - GET APPEND PATH
	AX = B704h
Return: ES:DI -> active APPEND path (128 bytes max)
Note:	some versions of append do not support this call, and return ES
	  unchanged; in this case, you should call AX=B701h to get the APPEND
	  path
SeeAlso: AX=B701h
----------2FB706-----------------------------
INT 2F - DOS 4+ APPEND - GET APPEND FUNCTION STATE
	AX = B706h
Return: BX = APPEND state (see #1665)
SeeAlso: AX=B700h,AX=B707h

Bitfields for APPEND state:
Bit(s)	Description	(Table 1665)
 0	set if APPEND enabled
 1-11	reserved
 12	(DOS 5.0) set if APPEND applies directory search even if a drive has
	  been specified
 13	set if /PATH flag active
 14	set if /E flag active (environment var APPEND exists)
 15	set if /X flag active
----------2FB707-----------------------------
INT 2F - DOS 4+ APPEND - SET APPEND FUNCTION STATE
	AX = B707h
	BX = APPEND state bits (see #1665)
SeeAlso: AX=B700h,AX=B706h
----------2FB710-----------------------------
INT 2F U - DOS 3.3+ APPEND - GET VERSION INFO
	AX = B710h
Return: AX = current APPEND state (see #1665)
	BX = ??? (0000h in MS-DOS 3.30 and 5.00)
	CX = ??? (0000h in MS-DOS 3.30 and 5.00)
	DL = major version
	DH = minor version
SeeAlso: AX=B700h,AX=B702h
----------2FB711-----------------------------
INT 2F - DOS 4+ APPEND - SET RETURN FOUND NAME STATE
	AX = B711h
Note:	if the next INT 21h call (and ONLY the next) is function 3Dh, 43h, or
	  6Ch (also 4B03h and 4Eh if /X active), the fully qualified filename
	  is written over top of the filename passed to the INT 21h call.  The
	  application must provide a sufficiently large buffer.	 This state is
	  reset after the next INT 21h call processed by APPEND.
	APPEND uses the byte at offset 3Dh in the PSP
	  (see #0603 at INT 21/AH=26h) to store the flag telling it to
	  overwrite the filename
BUG:	DOS 4.0 APPEND reportedly overwrites DS:DX instead of DS:SI for
	  INT 21/AH=6Ch
SeeAlso: INT 21/AH=26h,INT 21/AH=4Eh
--------N-2FB800-----------------------------
INT 2F - NETWORK - INSTALLATION CHECK
	AX = B800h
Return: AL = status
	    00h	    not installed
	    nonzero installed
	      BX = installed component flags (test in this order!)
		   bit 6   server
		   bit 2   messenger
		   bit 7   receiver
		   bit 3   redirector
		   bit 1   LANPUP (LANtastic 4.0)
Notes:	this function is supported by PC LAN Program, LAN Manager, LANtastic,
	  NetWare Lite, SilverNET, 10NET, etc.
	LANtastic and NetWare Lite use only BL for the return value, preserving
	  BH; LAN Manager and DOS LAN Requester return BH=00h.	This permits
	  differentiation between those two groups by setting BH to a nonzero
	  value before the call and checking its value on return.
SeeAlso: AX=4E53h,AX=B809h
--------N-2FB800CXF041-----------------------
INT 2F - 10NET - INSTALLATION CHECK
	AX = B800h
	CX = F041h
Return: AL = status
	    00h	    not installed
	    nonzero installed
		BX = installed component flags (test in this order!)
		   bit 6   server
		   bit 2   messenger
		   bit 7   receiver
		   bit 3   redirector
		   bit 1   LANPUP (LANtastic 4.0)
		CX = 10Net data segment
		CX:DX -> 10Net Configuration Table
			  (see #0896 at INT 21/AX=5E01h"10NET")
Note:	if CX <> F041h on entry, neither CX nor DX will be changed, and this
	  call becomes identical to the standard installation check above
SeeAlso: AX=B800h"network",INT 21/AX=5E01h"10NET"
--------N-2FB803-----------------------------
INT 2F - NETWORK - GET NETWORK EVENT POST HANDLER
	AX = B803h
Return: ES:BX -> current event post handler (see AX=B804h)
Note:	this function is supported by PC LAN Program, 10NET v5.0
SeeAlso: AC=B800h,AX=B804h,AX=B903h
--------N-2FB804-----------------------------
INT 2F - NETWORK - SET NETWORK EVENT POST HANDLER
	AX = B804h
	CX = (10NET) 0370h if 10Windows is hooking post handler
	ES:BX -> new event post handler (see #1666)
Notes:	used in conjunction with AX=B803h to hook into the network event post
	  routine
	this function is supported by PC LAN Program, 10NET v5.0
	The specified handler is called on any network event.  Two events are
	  defined: message received and critical network error.
SeeAlso: AX=B800h,AX=B803h,AX=B904h

(Table 1666)
Values network post routine is called with:
	AX = 0000h single block message
	    DS:SI -> ASCIZ originator name
	    DS:DI -> ASCIZ destination name
	    ES:BX -> text header (see #1667)
	AX = 0001h start multiple message block
	    CX = block group ID
	    DS:SI -> ASCIZ originator name
	    DS:DI -> ASCIZ destination name
	AX = 0002h multiple block text
	    CX = block group ID
	    ES:BX -> text header (see #1667)
	AX = 0003h end multiple block message
	    CX = block group ID
	AX = 0004h message aborted due to error
	    CX = block group ID
	AX = 0101h server received badly formatted network request
	    Return: AX = FFFFh (PC LAN will process error)
	AX = 0102h unexpected network error
	    ES:BX -> NCB (see #1894 at INT 5C)
	AX = 0103h server received INT 24 error
	    other registers as for INT 24, except AH is in BH
	    Return: as below, but only 0000h and FFFFh allowed
Return: AX = response code
	    0000h user post routine processed message
	    0001h PC LAN will process message, but message window not displayed
	    FFFFh PC LAN will process message

Format of text header:
Offset	Size	Description	(Table 1667)
 00h	WORD	length of text (maximum 512 bytes)
 02h  N BYTEs	text of message
Note:	all CRLF sequences in message text are replaced by 14h; all other
	  values below 20h (space) are reserved
--------N-2FB807-----------------------------
INT 2F - NETWORK - GET NetBIOS NAME NUMBER OF MACHINE NAME
	AX = B807h
Return: CH = NetBIOS name number of the machine name
SeeAlso: INT 21/AX=5E00h
--------N-2FB808-----------------------------
INT 2F U - NETWORK - RELINK KEYBOARD HANDLER
	AX = B808h
	ES:BX -> INT 09 handler network should call after it finishes INT 09
Notes:	this call replaces the address to which the network software chains on
	  an INT 09 without preserving the original value.  This allows a prior
	  handler to unlink, but does not allow a new handler to be added
	  such that the network gets the INT 09 first unless the new handler
	  completely takes over INT 09 and never chains.
	this function is called by the DOS 3.2 KEYBxx.COM
SeeAlso: AX=B908h
--------N-2FB809-----------------------------
INT 2F - NETWORK - LANtastic, NetWare Lite - VERSION CHECK
	AX = B809h
Return: AH = major version
	AL = minor version (decimal)
Notes:	this function is supported in this form by LANtastic, NetWare Lite,
	  SilverNET, ...
	NetWare Lite returns its own version number rather than a PC LAN
	  compatibility version
SeeAlso: AX=4E53h,AX=B800h,AX=B809h"PC LAN Program"
--------N-2FB809-----------------------------
INT 2F - NETWORK - PC LAN Program - VERSION CHECK
	AX = B809h
Return: AH = minor version (decimal)
	AL = major version
Notes:	this function is supported in this form by PC LAN Program, LAN Manager,
	  the DOS LAN Requester, and 10NET v5.0
	10NET returns version 1.10 (AX=0A01h) for compatibility
SeeAlso: AX=4E53h,AX=B800h,AX=B809h"LANtastic"
--------N-2FB80A-----------------------------
INT 2F u - PC Network 1.00 - ???
	AX = B80Ah
	???
Return: ???
Program: PC Network is an early networking package which was renamed the
	  IBM PC Local Area Network Program (PC LAN Program) as of v1.10
Note:	called by RECEIVER (equivalent to NetWare Lite SERVER)
--------N-2FB80F-----------------------------
INT 2F - DOS LAN Requester - GET START PARAMETERS
	AX = B80Fh
	CX = size of return data buffer
	ES:DI -> return data buffer (see #1668)
Return: AX = status
	     00h     network started
	     nonzero network not started
	CX = number of bytes returned in buffer
	ES:DI buffer filled
SeeAlso: AX=B809h"PC LAN Program"

Format of DOS LAN Requester return data buffer:
Offset	Size	Description	(Table 1668)
 00h	BYTE	major version
 01h	BYTE	minor version
 02h	WORD	configuration flags given when network was started (see #1669)
 04h 15 BYTEs	NET START machine name (space padded)
 13h	BYTE	00h
 14h 9	BYTEs	NET START domain name (NULL padded)
 1Dh	BYTE	00h
 1Eh 32 BYTEs	/WRK heuristics string (space padded, not terminated)
 3Eh	WORD	/SRV value
 40h	WORD	/ASG value
 42h	WORD	/NBC value
 44h	WORD	/NBS value
 46h	WORD	/BBC value
 48h	WORD	/BBS value
 4Ah	WORD	/PBC value
 4Ch	WORD	/PBS value
 4Eh	WORD	/PFS value
 50h	WORD	/PFT value
 52h	WORD	/PWT value
 54h	WORD	/KUC value
 56h	WORD	/KST value
 58h	WORD	/NVS value
 5Ah	WORD	/NMS value
 5Ch	WORD	/NDB value
 5Eh	WORD	/MBI value
 60h	BYTE	NetBIOS name number for machine name
 61h	BYTE	NetBIOS name number for domain name
 62h	WORD	NetBIOS sessions required for configuration
 64h	WORD	NetBIOS commands required for configuration
 66h	WORD	NetBIOS names required for configuration
 68h 128 BYTEs	NET START path (LANROOT)
 E8h	BYTE	00h

Bitfields for configuration flags:
Bit(s)	Description	(Table 1669)
 0	/NVS nonzero
 1	/NMS nonzero
 2	/API
 3	/HIM
 4	/LIM
 5	/ENC
 6	/POP
 7	/EMS
 8	/RPL
 9-12	reserved
 13	RDR started
 14	RCV started
 15	User is currently logged on
--------N-2FB900-----------------------------
INT 2F - PC Network RECEIVER.COM - INSTALLATION CHECK
	AX = B900h
Return: AL = state
	    00h if not installed
	    FFh if installed
--------N-2FB901-----------------------------
INT 2F - PC Network RECEIVER.COM - GET RECEIVER.COM INT 2F HANDLER ADDRESS
	AX = B901h
Return: AL = ???
	ES:BX -> RECEIVER.COM INT 2F handler
Desc:	allows more efficient execution by letting the caller bypass any other
	  INT 2F handlers which have been added since RECEIVER.COM was
	  installed
--------N-2FB903-----------------------------
INT 2F - PC Network RECEIVER.COM - GET RECEIVER.COM POST ADDRESS
	AX = B903h
Return: ES:BX -> POST handler
SeeAlso: AX=B803h,AX=B904h
--------N-2FB904-----------------------------
INT 2F - PC Network RECEIVER.COM - SET RECEIVER.COM POST ADDRESS
	AX = B904h
	ES:BX -> new POST handler
SeeAlso: AX=B804h,AX=B903h
--------N-2FB905-----------------------------
INT 2F - PC Network RECEIVER.COM - GET FILENAME
	AX = B905h
	DS:BX -> 128-byte buffer for filename 1
	DS:DX -> 128-byte buffer for filename 2
Return: buffers filled from RECEIVER.COM internal buffers
Note:	use of filenames is unknown, but one appears to be for storing messages
SeeAlso: AX=B906h
--------N-2FB906-----------------------------
INT 2F - PC Network RECEIVER.COM - SET FILENAME
	AX = B906h
	DS:BX -> 128-byte buffer for filename 1
	DS:DX -> 128-byte buffer for filename 2
Return: RECEIVER.COM internal buffers filled from user buffers
Note:	use of filenames is unknown, but one appears to be for storing messages
SeeAlso: AX=B905h
--------N-2FB908-----------------------------
INT 2F - PC Network RECEIVER.COM - UNLINK KEYBOARD HANDLER
	AX = B908h
	ES:BX -> INT 09 handler RECEIVER should call after it finishes INT 09
Note:	this call replaces the address to which RECEIVER.COM chains on an
	  INT 09 without preserving the original value.	 This allows a prior
	  handler to unlink, but does not allow a new handler to be added
	  such that RECEIVER gets the INT 09 first.
SeeAlso: AX=B808h
--------V-2FBC00-----------------------------
INT 2F - Windows 3.0, DOS 5+ EGA.SYS - INSTALLATION CHECK
	AX = BC00h
Return: AL = state
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
		BX = 5456h ("TV")
Range:	AH=80h to AH=FFh, selected by commandline switch
SeeAlso: AX=BC06h"EGA",INT 10/AH=FAh"EGA"
--------s-2FBC00BX3F3F-----------------------
INT 2F - MediaVision MVSOUND.SYS - INSTALLATION CHECK
	AX = BC00h
	BX = 3F3Fh ('??')
	CX = 0000h
	DX = 0000h
Return: if installed, BX XOR CX XOR DX = 4D56h ('MV')
Program: MVSOUND.SYS is a driver for the MediaVision ProAudio Spectrum family
	  of sound boards; its primary programmer was Bryan Crane
SeeAlso: AX=BC01h"MVSOUND",AX=BC02h,AX=BC03h,AX=BC04h,AX=BC06h"MVSOUND"
--------s-2FBC01-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET VERSION
	AX = BC01h
	BX = magic value 6D20h ('m ')
	CX = magic value 2076h (' v')
	DX = magic value 2020h ('  ')
Return: BX = ASCII major version (leading zeros significant)
	CX = ASCII minor version (leading zeros significant)
SeeAlso: AX=BC00h/BX=3F3Fh
--------s-2FBC02-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET STATE TABLE POINTER
	AX = BC02h
Return: BX:DX -> state table
SeeAlso: AX=BC00h/BX=3F3Fh,AX=BC03h
--------s-2FBC03-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET FUNCTION TABLE POINTER
	AX = BC03h
Return: BX:DX -> function table
SeeAlso: AX=BC00h/BX=3F3Fh,AX=BC02h
--------s-2FBC04-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET DMA AND IRQ CHANNELS
	AX = BC04h
Return: AX = 4D56h ('MV')
	BL = DMA channel
	CL = IRQ number
SeeAlso: AX=BC00h/BX=3F3Fh,AX=BC01h"MVSOUND"
--------V-2FBC06-----------------------------
INT 2F U - MS Windows 3.0, DOS 5+ EGA.SYS - GET VERSION INFO
	AX = BC06h
Return: BX = 5456h ("TV")
	CH = major version
	CL = minor version
	DL = revision
SeeAlso: AX=BC00h"EGA",INT 10/AH=FAh"EGA"
--------s-2FBC06-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET STATUS STRING
	AX = BC06h
Return: AX = 4D56h ('MV')
	DX:BX -> status string (first byte 0Ch if no status message to display)
SeeAlso: AX=BC00h/BX=3F3Fh,AX=BC01h"MVSOUND",AX=BC0Bh"MVSOUND"
--------s-2FBC0B-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET EXECUTABLE PATH
	AX = BC0Bh
Return: BX:DX -> ASCIZ path for MVPROAS.EXE, 0000h:0000h if not available
SeeAlso: AX=BC00h/BX=3F3Fh
--------U-2FBE00-----------------------------
INT 2F - REDVIEW - INSTALLATION CHECK
	AX = BE00h
Return: AL = FFh if installed
Program: REDVIEW is a public-domain TSR by Alexandr Novy and Petr Horak which
	  copies data sent to standard output to standard error when the
	  former has been redirected to a file, thus allowing the data to
	  be seen on the screen at the same time it is captured in a file
--------N-2FBF00-----------------------------
INT 2F - PC LAN PROGRAM REDIRIFS.EXE internal - INSTALLATION CHECK
	AX = BF00h
Return: AL = FFh if installed
--------N-2FBF01-----------------------------
INT 2F U - PC LAN PROGRAM REDIRIFS.EXE internal - ???
	AX = BF01h
	???
Return: ???
--------N-2FBF80-----------------------------
INT 2F - PC LAN PROG REDIR.SYS internal - SET REDIRIFS ENTRY POINT
	AX = BF80h
	ES:DI -> FAR entry point to IFS handler in REDIRIFS
Return: AL = FFh if installed
	    ES:DI -> internal workspace
Note:	all future IFS calls to REDIR.SYS are passed to the ES:DI entry point
--------F-2FC0-------------------------------
INT 2F - MTEZ XpressFax Hardware TSR (CLASS2) - API
	AH = C0h
	AL = function code (01h to 15h)
Return: ???
SeeAlso: AX=C000h/BX=444Bh,AX=CB00h/BX=4D53h
--------N-2FC000-----------------------------
INT 2F - Novell ODI Link Support Layer (LSL.COM) - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    DX:BX -> FAR entry point (see #1670,#1671,#1672)
	    ES:SI -> signature string "LINKSUP$"
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	on return, ES = DX for LSL v1.10 and v2.05; LSL makes use of this in
	  its search for a previous installation
SeeAlso: AX=5100h,AX=C000h"NESL"

(Table 1670)
Call LSL function "Request MLID Registration" with:
	BX = 0001h
	ES:SI -> registration??? record (see #1674)
	DS:DI -> buffer for LSL information block (see #1675)
Return: AX = completion code (0000h,8001h) (see #1673)
	DS:DI buffer filled if successful
	BX,CX corrupted
Note:	see "Novell LAN Driver Developer's Guide, Volume III" for more details

(Table 1671)
Call LSL function "get support entry points" with:
	BX = 0002h
	ES:SI -> buffer for entry point record (see #1676)
Return: ES:SI buffer filled

(Table 1672)
Call LSL function "Request MLID API entry point" with:
	BX = 0003h
Return: ES:SI -> MLID (Multiple Link Interface Driver) API entry point
		(call with BX=function 00h-10h, not range-checked)
Note:	LSL v1.10 and v2.05 execute BX=0003h for BX=0000h and any BX >= 0003h

(Table 1673)
Values for LSL completion code:
 0000h	successful
 8001h	out of resources
 8002h	bad parameter
 8003h	no more items
 8004h	item not present
 8005h	failed
 8006h	receive overflow
 8007h	canceled
 8008h	bad command
 8009h	duplicate entry
 800Ah	no such handler
 800Bh	no such driver

Format of LSL registration record:
Offset	Size	Description	(Table 1674)
 00h	DWORD	-> ??? FAR function (to be called with ES:SI -> ??? and
		  returning AX = completion code)
 04h	DWORD	-> ???
 08h	DWORD	-> ??? data (at least 3Eh bytes)

Format of LSL information block:
Offset	Size	Description	(Table 1675)
 00h	DWORD	-> ??? entry point (called with BX=function 00h-11h)
 04h	WORD	???
 06h	WORD	???
Note:	due to a fencepost error, LSL v2.05 (distributed with Novell DOS 7)
	  will crash if the above entry point is called with BX=0012h

Format of entry point record:
Offset	Size	Description	(Table 1676)
 00h	DWORD	pointer to protocol support entry point in LSL (see #1677)
 04h	DWORD	pointer to general support entry point in LSL (see #1678)

(Table 1677)
Call protocol support entry point with:
	BX = function number
	    0000h ???
	    0001h ???
	    0002h ???
	    0003h "ScheduleAESEvent"
		ES:SI -> AES ECB to be scheduled (see #1681)
		Return: ES,SI preserved
	    0004h "CancelAESEvent"
		ES:SI -> ECB to be cancelled (see #1681)
		Return: ES,SI preserved
	    0005h "GetIntervalMarker"
		Return: DX:AX = current interval marker in milliseconds
			all other registers preserved
	    0006h "RegisterStack"
		AX = logical board number
		ES:SI -> bound stack info structure (see #1691)
		Return: BX = assigned Stack ID if AX=0000h
	    0007h "DeRegisterStack"
		AX = protocol stack's assigned Stack ID
	    0008h "RegisterDefaultStack"
		AX = logical board number
		ES:SI -> stack info structure (see #1692)
	    0009h "DeRegisterDefaultStack"
		AX = logical board number
	    000Ah "RegisterPrescanStack"
		AX = logical board number
		ES:SI -> stack info structure (see #1692)
	    000Bh "DeRegisterPrescanStack"
		AX = logical board number
	    000Ch "SendPacket"
		ES:SI -> send ECB
		Return: interrupts disabled
	    000Dh ???
	    000Eh ???
	    000Fh ???
	    0010h "GetStackIDFromName"
		ES:SI -> counted NUL-terminated protocol name (max 15 chars)
		Return: BX = Stack ID if AX=0000h
	    0011h "GetPIDFromStackIDBoard"
		AX = Stack ID for protocol
		CX = logical board number
		ES:SI -> 6-byte buffer for protocol ID
	    0012h "GetMLIDControlEntry"
		AX = logical board number
		Return: ES:SI -> MLID control handler (see #1679) if AX=0000h
	    0013h "GetProtocolControlEntry"
		AX = Stack ID or
			FFFEh Prescan stack
			    CX = logical board number
			FFFFh default protocol
			    CX = logical board number
		Return: ES:SI -> protocol stack control entry point if AX=0000h
				  (see #1680)
	    0014h "GetLSLStatistics"
		Return: AX = 0000h (successful)
			ZF set
			ES:SI -> LSL statistics table (see #1683)
	    0015h "BindStack"
		AX = protocol stack's assigned Stack ID
		CX = logical board number
	    0016h "UnbindStack"
		AX = protocol stack's assigned Stack ID
		CX = logical board number
	    0017h "AddProtocolID"
		AX = frame type ID code
		ES:SI -> 6-byte protocol ID
		CX:DI -> counted NUL-terminated short protocol name (max 15 ch)
	    0018h "RelinquishControl"
		Return: after LSL performs any necessary background processing
	    0019h "GetLSLConfiguration"
		Return: AX = 0000h (successful)
			ZF set
			ES:SI -> LSL configuration table (see #1682)
	    001Ah "GetTickMarker"
		Return: AX = number of 55ms ticks since LSL loaded
			BX destroyed
Return: AX = completion code (see #1673)
	ZF set if successful
	SS:SP, DS, BP preserved; most other registers may be destroyed

(Table 1678)
Call general support entry point with:
	BX = function number
	    0000h "Allocate Memory" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0001h "Free Memory" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0002h "Realloc Memory" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0003h "Memory Statistics" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0004h "Add Memory To Pool" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0005h "AddGeneralService"
		ES:SI -> General Service Control Block (see #1693)
	    0006h "RemoveGeneralService"
		ES:SI -> General Service Control Block (see #1693)
	    0007h "GetNETcfgPath"
		Return: AX = 0000h (successful)
			DS:DX -> ASCIZ pathname for NET.CFG
	    0008h U ???	 (in LSL 1.10)
		Return: AX = 0000h
			ES:SI -> ??? (a 22-byte data area)
	    000Ah "GetCriticalSectionStatus"
		Return: BX = total outstanding calls to "StartCriticalSection"
	    000Bh "ServiceEvents"
		interrupts disabled
		Return: interrupts disabled
	    0010h "GetStackECB"
		DS:DI -> Lookahead structure (see #1694)
		interrupts disabled
		Return: ES:SI -> ECB if successful (AX=0000h,ZF set)
			interrupts disabled
	    8000h-FFFFh reserved for user general service providers
Return: AX = completion code (see #1673)
	ZF set if successful
	SS:SP, DS, BP preserved

(Table 1679)
Call MLID control handler with:
	AX = logical board number
	BX = function number
	    0000h "GetMLIDConfiguration"
		Return: ES:SI -> MLID's configuration table if successful
				  (see #1686 for format)
	    0001h "GetMLIDStatistics"
		Return: ES:SI -> MLID's statistics table if successful
				  (see #1686 for format)
	    0002h "AddMulticastAddress"
		ES:SI -> 6-byte multicast address to add
	    0003h "DeleteMulticastAddress"
		ES:SI -> 6-byte multicast address to delete
	    0005h "MLIDShutdown"
		CX = type
		    0000h permanent (also deregisters from LSL)
		    other temporary (shutdown hardware only)
	    0006h "MLIDReset" reinitialize board / restart from temp shutdown
	    0007h "Create Connection" (obsolete?)
		???
	    0008h "Delete Connection" (obsolete?)
		???
	    0009h "SetLookAheadSize"
		CX = requested lookahead size (00h-80h)
	    000Ah "PromiscuousChange"
		CX = what to receive promiscuously
		    bit 0: MAC frames
		    bit 1: non-MAC frames
	    000Bh "RegisterReceiveMonitor"
		CX = subfunction
		    0000h disable receive monitoring
		    else  enable receive monitoring
		ES:SI -> monitor receive routine
		ES:DI -> monitor transmit routine
	    000Ch "Driver Poll" (obsolete?)
		???
Return: AX = completion code (see #1673)
	ZF set if successful
Note:	not all boards/MLIDs support function 0010h; see bit 13 in the MLID
	  mode flags field of the MLID's configuration table

(Table 1680)
Call protocol stack control entry point with:
	BX = function number
	    0000h "GetProtocolStackConfiguration"
		Return: ES:SI -> protocol stack's configuration table
				   (see #1685)
	    0001h "GetProtocolStackStatistics"
		Return: ES:SI -> protocol stack's statistics table (see #1684)
	    0002h "BindToMLID"
		CX = board number to bind to
		ES:SI -> implementation-dependant parameter string
	    0003h "UnBindFromMLID"
		CX = board number from which protocol should unbind
		ES:SI -> optional implementation-dependant parameter string
	    0004h "MLIDDeRegistered"
		CX = board number that has de-registered from LSL
Return: AX = status
	    0000h successful
	    else implementation-dependant error codes
	ZF set if successful
	SS:SP, DS, BP preserved

Format of AES ECB:
Offset	Size	Description	(Table 1681)
 00h	DWORD	"AESLink" pointer used by LSL for list management
 04h	DWORD	number of milliseconds to wait
 08h	DWORD	"AESStatus" (is set to 00000000h when AES ESR is invoked)
 0Ch	DWORD	-> function to be invoked when time expires
		ES:SI will point to this structure on entry,
		DS, BP, and SS:SP must be preserved.
SeeAlso: #1695

Format of LSL Configuration Table:
Offset	Size	Description	(Table 1682)
 00h	BYTE	major version of configuration table
 01h	BYTE	minor version of configuration table (decimal, 0-99)
 02h  8 BYTEs	reserved
 0Ah	BYTE	LSL major version (decimal)
 0Bh	BYTE	LSL minor version (decimal, 0-99)
---LSL 1.0x ---
 0Ch 14 BYTEs	reserved
---LSL 1.10+ ---
 0Ch	WORD	maximum number of boards which LSL can handle
 0Eh	WORD	maximum number of protocol IDs which LSL can handle
 10h 12 BYTEs	reserved

Format of LSL Statistics Table:
Offset	Size	Description	(Table 1683)
 00h	BYTE	major version of statistics table format
 01h	BYTE	minor version of statistics table format (decimal, 0-99)
 02h	WORD	"GenericCounters" number of counters in static portion of
		  table
 04h	DWORD	"ValidCountersMask" bit mask indicating which generic
		  counters are actually used.  Bit 31 = TotalTxPackets, bit 30
		  is the next field, etc.
 08h	DWORD	"TotalTxPackets" total SendPacket requests made
 0Ch	DWORD	reserved
 10h	DWORD	reserved
 14h	DWORD	"AESEventsCount" number of completed AES events
 18h	DWORD	"PostponedEvents" number of events postponed due to critical
		  sections inside the MLIDs
 1Ch	DWORD	"CancelAESFailures" number of times CancelAESEvent failed
 20h	DWORD	reserved
 24h	DWORD	reserved
 28h	DWORD	"TotalRxPackets" total number of GetStackECB requests
 2Ch	DWORD	"UnclaimedPackets" total number of packets not consumed by a
		  protocol stack
 30h	WORD	"NumberCustom" number of custom variables that follow
 32h  N DWORDs	custom counters
      N DWORDs	-> CustomCounterStrN (one per custom counter)
	var	length-prepended and NULL terminated string for Counter 0
	...
	var	length-prepended and NULL terminated string for Counter N-1
SeeAlso: #1684,#1690

Format of Protocol Stack Statistics Table:
Offset	Size	Description	(Table 1684)
 00h	BYTE	statistics table major version
 01h	BYTE	statistics table minor version (decimal, 0-99)
 02h	WORD	number of generic counters following
 04h	DWORD	"ValidCountersMask" (bitmask, bit 31 is TotalTxPackets)
 08h	DWORD	TotalTxPackets
 0Ch	DWORD	TotalRxPackets
 10h	DWORD	IgnoredRxPackets
 14h	WORD	number of custom counters
 16h  N DWORDs	custom counters
      N DWORDs	-> CustomCounterStrN (one per custom counter)
	var	length-prepended and NULL terminated string for Counter 0
	...
	var	length-prepended and NULL terminated string for Counter N-1
SeeAlso: #1683,#1690

Format of Protocol Stack Configuration Table:
Offset	Size	Description	(Table 1685)
 00h	BYTE	configuration table major version
 01h	BYTE	configuration table minor version (decimal, 0-99)
 02h	DWORD	-> counted NUL-terminated long descriptive name for protocol
 06h	DWORD	-> counted NUL-terminated short name for protocol (15 chars)
 0Ah	BYTE	protocol stack major version
 0Bh	BYTE	protocol stack minor version (decimal, 0-99)
 0Ch 16 BYTEs	reserved for future use

Format of MLID Configuration Table:
Offset	Size	Description	(Table 1686)
 00h 26 BYTEs	signature 'HardwareDriverMLID	     ' (8 spaces on end)
 1Ah	BYTE	configuration table major version
 1Bh	BYTE	configuration table minor version (decimal, 0-99)
 1Ch  6 BYTEs	node address
 22h	WORD	MLID mode flags (see #1687)
 24h	WORD	board number
 26h	WORD	board instance (if more than one of same board installed)
 28h	WORD	maximum packet size
 2Ah	WORD	BestDataSize
 2Ch	WORD	WorstDataSize
 2Eh	DWORD	-> counted NUL-terminated long name for NIC
 32h	DWORD	-> counted NUL-terminated short name for NIC (8 chars max)
 36h	DWORD	-> counted NUL-terminated Frame and Media type
 3Ah	WORD	reserved (0000h)
 3Ch	WORD	frame type ID
 3Eh	WORD	TransportTime (milliseconds)
 40h	DWORD	-> SourceRouteHandler for TokenRing. (Used by ROUTE.COM)
 44h	WORD	lookahead size
 46h	WORD	line speed (Mbps if high bit clear, else Kbps)
 48h	WORD	QueueDepth
 4Ah  6 BYTEs	reserved (0)
 50h	BYTE	driver major version
 51h	BYTE	driver minor version (decimal, 0-99)
 52h	WORD	bus/multicast flags (see #1688)
 54h	WORD	send retries
 56h	DWORD	ConfigTableLink
 5Ah	WORD	MLID sharing flags (see #1689)
 5Ch	WORD	slot number
 5Eh	WORD	I/O address 1
 60h	WORD	I/O range 1
 62h	WORD	I/O address 2
 64h	WORD	I/O range 2
 66h	DWORD	memory address 1
 6Ah	WORD	memory size 1
 6Ch	DWORD	memory address 2
 70h	WORD	memory size 2
 72h	BYTE	interrupt line 1
 73h	BYTE	interrupt line 2
 74h	BYTE	DMA line 1
 75h	BYTE	DMA line 2

Bitfields for MLID mode flags:
Bit(s)	Description	(Table 1687)
 15	MLID supports Octet Reversal
 14	node address is non-canonical
 13	promiscuous mode is supported
 12-8	reserved
 7	LDataSize field in LookAhead structure supported
 6	raw send supported
 5	MLID needs to be polled by LSL
 4	reserved (0)
 3	multicasting is supported
 2	not currently used by DOS ODI, set to 0.
 1	network card uses DMA.
 0	RealDriverBit, always set to 1.

Bitfields for bus/multicast flags:
Bit(s)	Description	(Table 1688)
 10-9	specialized multicast support
	00 = Group addressing is default for medium
	01 = Invalid
	10 = Filter group address in MLID.
	11 = Adapter filters group address.
 2	supports Micro Channel cards
 1	supports ISA cards
 0	supports EISA cards

Bitfields for MLID sharing flags:
Bit(s)	Description	(Table 1689)
 8	NIC can share DMA2
 7	NIC can share DMA1
 6	NIC can share IRQ2
 5	NIC can share IRQ1
 4	NIC can share Memory2
 3	NIC can share Memory1
 2	NIC can share IO2
 1	NIC can share IO1
 0	MLID is currently shut down

Format of MLID Statistics Table:
Offset	Size	Description	(Table 1690)
 00h	BYTE	driver statistics table major version
 01h	BYTE	driver statistics table minor version (decimal, 0-99)
 02h	WORD	number of generic counters (typically 13)
 04h	DWORD	"ValidCountersMask" (bit mask, bit 31 is TotalTxCount)
 08h	DWORD	TotalTxCount
 0Ch	DWORD	TotalRxCount
 10h	DWORD	NoECBAvailableCount
 14h	DWORD	TxTooBigCount
 18h	DWORD	TxTooSmallCount
 1Ch	DWORD	RxOverflowCount
 20h	DWORD	RxTooBigCount
 24h	DWORD	RxTooSmallCount
 28h	DWORD	TxMiscCount
 2Ch	DWORD	RxMiscCount
 30h	DWORD	TxRetryCount
 34h	DWORD	RxChecksumErrorCount
 38h	DWORD	RxMismatchCount
 3Ch	WORD	number of custom counters
 3Eh  N DWORDs	custom counters
      N DWORDs	-> CustomCounterStrN (one per custom counter)
	var	length-prepended and NULL terminated string for Counter 0
	...
	var	length-prepended and NULL terminated string for Counter N-1
SeeAlso: #1683,#1684

Format of bound stack info structure:
Offset	Size	Description	(Table 1691)
 00h	DWORD	-> protocol stack's short name (counted, NUL-terminated)
 04h	DWORD	-> receive handler
 08h	DWORD	-> control handler

Format of stack info structure:
Offset	Size	Description	(Table 1692)
 00h	DWORD	-> receive handler
 04h	DWORD	-> control handler

Format of General Service Control Block:
Offset	Size	Description	(Table 1693)
 00h	DWORD	-> next GSCB (maintained internally by LSL)
 04h	DWORD	-> entry point for general service handler
 08h	WORD	command code for this general service (8000h-FFFFh)
Note:	the control block must not be altered or deallocated until the general
	  service is removed

Format of Lookahead structure:
Offset	Size	Description	(Table 1694)
 00h	DWORD	-> Media header
 04h	DWORD	-> lookahead buffer
 08h	WORD	length of lookahead buffer
 0Ah  6 BYTEs	protocol ID
 10h	WORD	logical board number
 12h	WORD	lookahead size

Format of ODI ECB:
Offset	Size	Description	(Table 1695)
 00h	DWORD	link to next ECB
 04h	DWORD	link to previous ECB
 08h	WORD	general status
		0000h received successfully
		8006h packet overflow
		8007h reception aborted (data not valid)
 0Ah	DWORD	-> event service routine or RETF (never 0000h:0000h)(see #1696)
 0Eh	WORD	protocol stack identifier
 10h  6 BYTEs	protocol ID (sending only)
 16h	WORD	MLID board number (sending only)
 18h  6 BYTEs	MAC destination address
 1Eh  4 BYTEs	driver workspace
 22h  4 BYTEs	protocol workspace
 26h	WORD	total length of sent buffer
 28h	WORD	fragment count
 2Ah  2 WORDs	segment,offset of first fragment buffer
 2Eh	WORD	length of first fragment buffer
	...
SeeAlso: #1681

(Table 1696)
Values event service routine is called with:
	ES:SI -> associated ODI ECB (see #1695)
	interrupts disabled
Return: DS,BP,SS,SP preserved
	interrupt disabled
Notes:	the service routine may invoke any IPX/ODI function except CloseSocket
	it is safe to send a packet and wait for completion if enough stack
	  space is available
--------N-2FC000-----------------------------
INT 2F - Novell NetWare Event Service Layer (NESL) 1.0 - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    DX:BX -> FAR entry point (see #1697,#1698,#1699,#1700,#1701,#1702)
	    ES:SI -> signature string "NESL_EVENTS"
Program: NESL is a generic interface for event handling in ODI drivers and
	  other NetWare-oriented modules.  Primarily intended to support
	  power management and "hot swapping" of PCMCIA cards, but it is not
	  limited to this.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"Link Support Layer",AX=C000h"NETWARN"

(Table 1697)
Call NESL function GetNESLConfigPointer with:
	BX = 0000h
Return: AX = completion code (0000h,8008h) (see #1703)
	ES:SI -> NESL configuration table if successful (see #1704)
	BP,DS,STACK preserved
Desc:	Obtain a pointer to the NESL Configuration Table
SeeAlso: #1698,#1701

(Table 1698)
Call NESL function RegisterEventProducer with:
	BX = 0001h
	ES:SI -> Producer Event Control Block (PECB) (see #1705)
Return: AX = completion code (0000h, 8005h, 8008h) (see #1703)
	ES:SI -> still points to PECB
	BP,DS,STACK preserved
Desc:	Allows a module to register as a producer of a given event class
Note:	PECB_ClassName and PECB_Flags must be filled in on entry
SeeAlso: #1577,#1699,#1700,#1701

(Table 1699)
Call NESL function DeRegisterEventProducer with:
	BX = 0002h
	ES:SI -> PECB previously passed to RegisterEventProducer (see #1705)
Return: AX = completion code (0000h, 8002h, 8008h) (see #1703)
	ES:SI -> still points to PECB
	BP,DS,STACK preserved
Desc:	Allows a module to de-register as a producer of a given event class
SeeAlso: #1698,#1702

(Table 1700)
Call NESL function EventNotification with:
	BX = 0003h
	ES:SI -> PECB previously registered (see #1705)
Return: AX = completion code (0h, 8005h, 8008h) (see #1703)
	ES:SI -> still points to PECB
	BP,DS,STACK preserved
Desc:	Allows a module to signal that an event has just occurred in a given
	  event class.
Notes:	Once called, NESL will generate corresponding callouts for this
	  event, as described in Table #1707.
	on entry, the PECB_DataPtr must point at an Event Parameter Block (EPB)
	  (see #1708) filled in to match the desired event
SeeAlso: #1698

(Table 1701)
Call NESL function RegisterEventConsumer with:
	BX = 0004h
	ES:SI -> Consumer Event Control Block (CECB) (see #1706)
Return: AX = completion code (0h, 8005h, 8008h) (see #1703)
	ES:SI -> still points to CECB
	BP,DS,STACK preserved
Desc:	Allows a module to register as a consumer of a given event class
Note:	on entry, the CECB_ClassName, CECB_NotifProc and CECB_OSILevel must be
	  filled in.
SeeAlso: #1698,#1702

(Table 1702)
Call NESL function DeRegisterEventConsumer with:
	BX = 0005h
	ES:SI -> CECB previously passed to RegisterEventConsumer (see #1706)
Return: AX = completion code (0h, 8002h, 8008h) (see #1703)
	ES:SI -> still points to CECB
	BP,DS,STACK preserved
Desc:	Allows a module to de-register as a consumer of a given event class
SeeAlso: #1699,#1701

(Table 1703)
Values for NESL Error code:
 0000h	Successful
 8002h	Bad Parameter
 8005h	Fail
 8008h	Bad Command

Format of NESL Configuration Table:
Offset	Size	Description	(Table 1704)
 00h	WORD	NESL_Cfg_MajVer	 Major Version of this table (=1)
 02h	WORD	NESL_Cfg_MinVer	 Minor Version of this table (=0)
 04h	DWORD	NESL_Cfg_ModLName   -> ASCIZ long name of NESL module
		(typically -> "NetWare Event Service Layer for 16-Bit DOS")
 08h	DWORD	NESL_Cfg_ModSName   -> ASCIZ short name of NESL module
		(typically -> "NESL")
 0Ch	WORD	NESL_Cfg_ModMajVer  Major Version of NESL itself (=1)
 0Eh	WORD	NESL_Cfg_ModMinVer  Minor Version of NESL itself (=0)

Format of NESL Producer Event Control Block (PECB):
Offset	Size	Description	(Table 1705)
 00h	WORD	PECB_MajVer  Major Version of this structure (=1)
 02h	WORD	PECB_MinVer  Minor Version of this structure (=0)
 04h	DWORD	PECB_NextProducer   -> next PECB.  NULL if last.
 08h	DWORD	PECB_ClassName	    -> ASCIZ string identifying event 
					  class (see #1709)
 0Ch	DWORD	PECB_ConsumerList   -> list of consumers for this event class
 10h	DWORD	PECB_DataPtr	    -> points to additional data during events
 14h	DWORD	PECB_Flags
		Bit 0	=0  consumers should be called "top down" for this
			    event class.  (OSI level 7 down to OSI level 1)
			=1  consumers should be called "bottom up"
		Bits 1-31   Reserved =0
 18h  8 BYTEs	PECB_Reserved (all zeros)
Note:	Although the event producer provides the memory for the PECB, the
	  NESL module controls this memory until the event class is
	  de-registered.
	While owned by NESL, this structure should be treated as read-only,
	  except for the PECB_DataPtr field.

Format of NESL Consumer Event Control Block (CECB):
Offset	Size	Description	(Table 1706)
 00h	WORD	CECB_MajVer  Major Version of this structure (=1)
 02h	WORD	CECB_MinVer  Minor Version of this structure (=0)
 04h	DWORD	CECB_NextConsumer   -> next CECB.  NULL if last.
 08h	DWORD	CECB_ClassName	    -> ASCIZ string identifying event 
					  class (see #1709)
 0Ch	DWORD	CECB_NotifProc	    -> FAR CALL event handler (see #1707)
 10h	WORD	CECB_OSILevel
		Bits 4-7 = OSI Layer of this module (1 through 7)
		Bits 0-3 = relative ordering with other modules on same layer
 13h 14 BYTEs	CECB_Reserved (all zeros)
Note:	Although the event consumer provides the memory for the CECB, the
	  NESL module controls this memory until the consumer is de-registered.
	While owned by NESL, this structure should be treated as read-only,

(Table 1707)
Values NESL Consumer Notification Procedure is called with:
	ES:SI -> Event Parameter Block (EPB) (see #1708)
Return: AX = completion code (0000h, 8005h) (see #1703)
	ES:SI -> still points to EPB
Desc:	Called by NESL to notify the consumer when an event has occurred in
	  an event class for which it has registered.
SeeAlso: #1706

Format of NESL Event Parameter Block (EPB):
Offset	Size	Description	(Table 1708)
 00h	WORD	EPB_MajVer  Major Version of this structure (=1)
 02h	WORD	EPB_MinVer  Minor Version of this structure (=0)
 04h	DWORD	EPB_ClassName  -> ASCIZ string identifying event class 
				  (see #1709)
 08h	DWORD	EPB_EventName  -> ASCIZ string identifying event within 
				  class (see #1710)
 0Ch	DWORD	EPB_ModuleName -> ASCIZ string identifying module 
				  producing event
 10h	DWORD	EPB_DataPtr0   -> event-defined data or NULL if not used
 14h	DWORD	EPB_DataPtr1   -> event-defined data or NULL if not used
 18h  8 BYTEs	EPB_Reserved (all zeros)

(Table 1709)
Values for NESL Event Class Names:
 Event Class		Description
 -------------------	-----------------------------------------
 Service Suspend	Suspension of a service.  Called top-down.
 Service Resume		Resumption/availability of a service. Called bottom-up.
 Service/Status Change	Change in status or level of service.  Called top-down.
 Suspend Request	Request to suspend a service.  Called bottom-up.
Note:	Contact Novell Labs to register new event classes.

(Table 1710)
Values for NESL Event Names:
 Event Name			Class		    Description
 --------------------------	-------------	    ---------------------------
 MLID Cable Disconnect		Service Suspend	    Cable disconnected from NIC
 MLID Card Removal		Service Suspend	    PCMCIA card removed
 MLID Hardware Failure		Service Suspend	    Serious hardware 
							  failure in NIC
 MLID Not In Range		Service Suspend	    Wireless access point 
							  is out of range
 MLID Shutdown			Service Suspend	    MLID was shut down
 MLID Media Access Denied	Service Suspend	    Access to physical 
							  medium unsuccessful
 MLID Cable Reconnect		Service Resume	    Cable re-connected to NIC
 MLID Card Insertion Complete	Service Resume	    PCMCIA card inserted
 MLID In Range			Service Resume	    Wireless access point 
							  in range
 MLID Reset			Service Resume	    MLID was just reset
 MLID Access Point Change	Serv/Status Change  Station has moved to 
							  new access point
 MLID Speed Change		Serv/Status Change  Change in communic. speed
Note:	Contact Novell Labs to register new event names.
	For all predefined events above, EPB_DataPtr0 (see #1708) points
	  to the MLID Configuration table (see AX=C000h"ODI") for the
	  affected MLID.
--------N-2FC000-----------------------------
INT 2F - Novell NetWare Connect NETWARN - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    SI = segment of resident portion
Program: NETWARN is a utility supplied with NetWare Connect to warn a
	  remote dialup user when programs are about to be loaded slowly over
	  the modem link.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	on return, verify that it is NETWARN responding by examining signature
	  at in NETWARN's data table in the resident segment (see #1711)
SeeAlso: AX=C000h"ODI",AX=C000h"NESL"

Format of NETWARN Configuration structure:
Offset	Size	Description	(Table 1711)
 103h 7 BYTEs	signature string "NETWARN"
 10Ah	BYTE	major version in ASCII (="1")
 10Bh	BYTE	minor version in ASCII (="0")
 10Ch	DWORD	minimum size of EXE cared about in bytes (/S=xxxx)
 110h	WORD	same value in kilobytes (see 0113h, bit 4 below)
 112h	BYTE	multiplex code (AH value) actually being used
 113h	WORD	options (see #1712)
 115h	DWORD	INT 21h vector before NETWARN loaded
 119h	DWORD	INT 2Fh vector before NETWARN loaded
 11Dh 16 BYTEs	ASCIIZ local name of last device which was checked
 12Dh 128 BYTEs ASCIIZ remote name of last device which was checked
Note:	the specified offsets are from the start of the resident segment

Bitfields for NETWARN options:
Bit(s)	Description	(Table 1712)
 0	??? (=0)
 1	/U (Unload) selected (never in resident)
 2	/E (Enabled) Will trap & check EXEC's
 3	/D (Disabled) No EXEC checking done
 4	/S (Size) was set (see 010Ch, 0110h above)
 5	/P (Path shown)
 6	/H or /? (Help) (never in resident)
SeeAlso: #1711
--------f-2FC000-----------------------------
INT 2F - FN32 32 character filename utilities - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	   ES:DI -> signature string "FN32 32CHAR TSR"
Program: FN32 is a TSR which supports 32 character filenames under PC/MS-DOS
Note:	the TSR intercepts INT 21 calls and performs filename substitution by
	  managing dictionary files in each directory which contains long
	  filenames
--------M-2FC000-----------------------------
INT 2F - QMR - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    ES:DI -> signature string "QMR1!"
Program: QMR (Cove Software, Quick Mouse Reset) monitors the mouse
	  service interrupt (int 33h) and substitutes a fast software
	  reset (mouse fn 21h) for the slow hardware reset (mouse fn 0).
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C001h"QMR",AX=C002h"QMR",AX=C003h"QMR"
--------V-2FC000-----------------------------
INT 2F - VGAsave v1.93 - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    BX = segment of resident code
Program: VGAsave is a freeware VGA-specific, mouse-aware screenblanker by Bill
	  Javurek
Range:	AH=C0h to AH=FFh, selected by scanning for a free multiplex number
Note:	the transient portion of VGAsave compares the first 38 bytes of the
	  resident code (addressed through BX) against its own copy of the
	  resident code to complete the installation check
SeeAlso: INT 14/AX=AA01h,INT 2F/AH=93h
Index:	screen saver;VGAsave
--------V-2FC000-----------------------------
INT 2F - AD-DOS - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    BX = 4144h ('AD')
	    CX = 2D44h ('-D')
	    DX = 4F53h ('OS')
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C001h,AX=C003h,AX=C005h,AX=C007h,AX=C009h,AX=C020h,INT 14/AX=AA01h
Index:	screen saver;AD-DOS
--------U-2FC000-----------------------------
INT 2F U - WANG_ER.COM - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    ES = segment of resident code
Program: WANG_ER is a TSR from Compaq which permits Compaq systems equipped
	  with 3-mode floppy drives to read Wang document diskettes
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	The installation check is completed by comparing the resident code
	  with the copy in the transient program
--------i-2FC000-----------------------------
INT 2F O - ASPIHOOK.SYS - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if multiplex number in use
	    ES:DI -> ASCIZ signature "ASPIHOOK" if ASPIHOOK.SYS installed
Program: ASPIHOOK is a device driver for monitoring SCSI activity through an
	  ASPI host manager; it is part of the Personal Measure system
	  activity monitor from Spirit of Performance, Inc.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"PMEASURE"
--------i-2FC000-----------------------------
INT 2F - PMEASURE.EXE - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if multiplex number in use
	    ES:DI -> ASCIZ signature "PMEASURE.EXE" if PMEASURE.EXE installed
Program: PMEASURE.EXE is a TSR for monitoring system hardware activity which
	  is part of the Personal Measure system activity monitor from Spirit
	  of Performance, Inc.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	If a Personal Measure Hook Module, such as ASPIHOOK.SYS, is already
	  installed, PMEASURE.EXE uses the next highest free multiplex number.
SeeAlso: AX=C000h"ASPIHOOK",AX=C000h"PERSONAL MEASURE"
--------i-2FC000-----------------------------
INT 2F - PERSONAL MEASURE - HOOK MODULE INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	ES:DI -> signature string "PMEASUREHOOK"
	AX = C000 if not installed, per mux id conventions
	DH = major release number (binary)
	DL = minor release number (binary)
Program: The Personal Measure system activity monitor from Spirit of
	  Performance, Inc. uses an extensible series of modules to hook
	  into various operating system interfaces and monitor system calls.
	  Current hook modules are ASPIHOOK.SYS for ASPI device activity
	  and CDRHOOK.SYS for non-ASPI CD-ROM activity.	 All hook modules
	  share the same mux id.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"PMEASURE.EXE",AX=C001h"PERSONAL MEASURE"
--------c-2FC000-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    SI = signature value 20D6h
	    DI = signature value 8761h
	    ES:BX -> configuration table (see #1713)
	    CX = ??? (0300h)
	    DX = ??? (0020h)
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=0100h/SI=20D6h,AX=C001h"PCACHE"

Format of PrintCache configuration table:
Offset	Size	Description	(Table 1713)
 00h 26 BYTEs	ASCIZ signature string "TORQ Configuration Table: "
 1Ah  2 BYTEs	???
 1Ch	DWORD	-> data table (see #1714)
 20h  4 BYTEs	ASCIZ version string ("3.1" for v3.1)
 24h  5 BYTEs	???
 29h 12 BYTEs	ASCIZ version date string ("Aug 31 1993" for v3.1)
 35h	WORD	buffered port type (01h = LPT, 02h = COM)
 37h	WORD	buffered port BIOS port number
 39h  5 BYTEs	ASCIZ buffered port name ("LPTn" or "COMn")
 3Eh	WORD	physical port type (01h = LPT, 02h = COM)
 40h	WORD	physical port BIOS port number
 42h  5 BYTEs	ASCIZ physical port name ("LPTn" or "COMn")
 47h	BYTE	port driver IRQ
 48h 21 BYTEs	???
 5Dh	WORD	buffer size in K
 5Fh 27 BYTEs	???
 7Ah	BYTE	popup hotkey shift states (see #0442 at INT 16/AH=02h)
 7Bh	BYTE	popup hotkey scan code (see #0005 at INT 09h"IRQ1")
 7Ch  4 BYTEs	???
 80h 20 BYTEs	ASCIZ printer type name
	???

Format of PrintCache data table:
Offset	Size	Description	(Table 1714)
 00h  2 BYTEs	???
 02h	DWORD	-> ??? entry point
	???
--------U-2FC000-----------------------------
INT 2F - Frank Kintrup TSR Utilities - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    BX = program ID (see #1715)
	    CX = 464Bh (signature "FK")
	    DX = revision number (DH = major, DL = minor)
	    ES = resident segment of TSR
Range:	AH=C0h to AH=FFh, selected by searching for a free multiplex number
SeeAlso: AX=C001h"Kintrup",AX=C002h"Kintrup"

(Table 1715)
Values for Frank Kintrup TSR program ID:
 4153h	"AS"	ASCII.COM	ASCII table with paste function
 434Ch	"CL"	CLOCK.COM	clock with date/time display and alarm
 5043h	"PC"	PCALC.COM	programmer's calculator with paste function
 5343h	"SC"	SCRSAVE.COM	screen saver with mouse support and hotkey
 5544h	"UD"	UNDEL.COM	undelete program like SMARTCAN or DPROTECT
--------K-2FC000-----------------------------
INT 2F U - HP 100LX/200LX - PUSHKEYS - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if possibly installed
Range:	AH=C0h to AH=FFh, selected by scanning for signature with AL=AEh
SeeAlso: AX=C001h"HP 100LX",AX=C0AEh"HP 100LX",AX=C0AFh"HP 100LX"
--------V-2FC000-----------------------------
INT 2F - DIMWIT - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    ES:DI -> signature string "DIMDOS" or "DIMWIN"
Program: DIMWIT is a freeware Windows-aware screen blanker by Larry Board
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"AD-DOS",AX=C001h"DIMWIT"
Index:	screen saver;DIMWIT
--------F-2FC000BX444B-----------------------
INT 2F - MTEZ XpressFax Hardware TSR (CLASS2) - INSTALLATION CHECK
	AX = C000h
	BX = 444Bh ('DK')
	CX = 4A4Eh ('AN')
Return: AL = status
	    00h not installed, OK to install
	    FFh installed
		BX = 646Bh ('dk')
		CX = 6A6Eh ('an')
Range:	AH=C0h to AH=FFh, selected automatically
SeeAlso: AH=C0h"MTEZ"
----------2FC000-----------------------------
INT 2F U - TSENGP.COM - INSTALLATION CHECK
	AX = C000h
Return: AL = status
	    00h not installed, OK to install
	    FFh installed
		DS = segment of resident code
Program: TSENGP.COM is a TSR supplied by Compaq to fix an incompatibility
	  between some applications and Tseng ET4000-based video adapters
Range:	AH=C0h to AH=FFh, selected automatically
Note:	the installation check is completed by comparing the first eleven
	  bytes at DS:005Fh against the TSR's code (80h FCh 06h 74h 0Ah
	  80h FCh 07h 74h 05h EAh)
--------M-2FC001-----------------------------
INT 2F - QMR - REQUEST HARDWARE RESET
	AX = C001h
Return: ES = QMR code segment
	AL destroyed
Desc:	this function is used to force a full mouse reset when QMR is installed
SeeAlso: AX=C000h"QMR",AX=C002h"QMR"
--------V-2FC001-----------------------------
INT 2F - DIMWIT - GET CONFIGURATION DATA
	AX = C001h
Return: ES:DI -> TSR configuration data (see #1716)
Program: DIMWIT is a freeware Windows-aware screen blanker by Larry Board
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"DIMWIT",AX=C001h"AD-DOS"
Index:	screen saver;DIMWIT

Format of DIMWIT TSR configuration data:
Offset	Size	Description	(Table 1716)
 00h	WORD	blanking delay in clock ticks
 02h	BYTE	instant-blanking hotkey scan code
		Ctrl and Alt must also be pressed
--------V-2FC001ES0000-----------------------
INT 2F - AD-DOS - GET RESIDENT CODE SEGMENT
	AX = C001h
	ES = 0000h
Return: AL = 00h if successful
	    ES = AD-DOS TSR Code Segment
SeeAlso: AX=C000h"AD-DOS",AX=C001h"DIMWIT"
Index:	screen saver;AD-DOS
--------c-2FC001-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ENTRY POINTS
	AX = C001h
Return: AL = FFh if installed
	    ES:BX -> ???
	    ES:DX -> ???
	    ES:SI -> ???
	    ES:DI -> ??? (equivalent to AX=C002h)
SeeAlso: AX=C000h"PCACHE",AX=C002h"PCACHE"
--------U-2FC001-----------------------------
INT 2F - Frank Kintrup TSR Utilities - CLOCK - DISABLE DISPLAY UPDATE
	AX = C001h
Range:	AH=C0h to AH=FFh, selected by searching for a free multiplex number
SeeAlso: AX=C000h"Kintrup",AX=C002h"Kintrup"
--------K-2FC001CX03FB-----------------------
INT 2F U - HP 100LX/200LX - PUSHKEYS - INTERNAL - UNINSTALL
	AX = C001h
	CX = 03FBh return address to continue uninstall if possible
Return: program uninstalled
Range:	AH=C0h to AH=FFh, selected by scanning for signature with AL=AEh
SeeAlso: AX=C000h"HP 100LX",AX=C0AEh"HP 100LX",AX=C0AFh"HP 100LX"
--------i-2FC001-----------------------------
INT 2F - PERSONAL MEASURE - PASS PARAMETERS TO HOOK MODULE(S)
	AX = C001h
	DX = segment of PMEASURE.EXE or 0000h
	BX = offset in PMEASURE.EXE or 0000h
	CX = offset in PMEASURE.EXE or 0000h
Return: None
Program: PMEASURE.EXE is a TSR for monitoring system hardware activity which
	  is part of the Personal Measure system activity monitor from Spirit
	  of Performance, Inc.	PMEASURE uses this call to inform its hook
	  modules whether or not it is running and to pass information about
	  shared data and procedures.
Warning: This information documents a function that is private to Personal
	  Measure and is provided as information only.	It should NOT be called
	  by any software other than Personal Measure.
SeeAlso: AX=C000h"PERSONAL MEASURE HOOK MODULE"
--------V-2FC002-----------------------------
INT 2F - AD-DOS - CHECK FOR NEW INPUT
	AX = C002h
Return: AL = 00h if successful
	    BX = status
		0000h no input since last check
		0001h new input available
Note:	this call also resets the new-input flag
SeeAlso: AX=C000h"AD-DOS",AX=C004h
Index:	screen saver;AD-DOS
--------M-2FC002-----------------------------
INT 2F - QMR - DISABLE QMR
	AX = C002h
Return: ES = QMR code segment
	AL destroyed
Desc:	this call temporarily disables QMR
SeeAlso: AX=C000h"QMR",AX=C003h"QMR"
--------c-2FC002-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET BUFFER SIZE
	AX = C002h
Return: AX = ??? in K
	BX = size of print buffer in K
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
SeeAlso: AX=C000h"PCACHE"
--------U-2FC002-----------------------------
INT 2F - Frank Kintrup TSR Utilities - CLOCK - ENABLE DISPLAY UPDATE
	AX = C002h
Range:	AH=C0h to AH=FFh, selected by searching for a free multiplex number
SeeAlso: AX=C000h"Kintrup",AX=C002h"Kintrup"
--------V-2FC003-----------------------------
INT 2F - AD-DOS - SET MINUTES TO WAIT
	AX = C003h
	BX = minutes to wait before blanking screen
Return: AL = 00h if successful
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	this call also resets the delay timer
SeeAlso: AX=C000h"AD-DOS",AX=C004h
Index:	screen saver;AD-DOS
--------M-2FC003-----------------------------
INT 2F - QMR - ENABLE QMR
	AX = C003h
Return: ES = QMR code segment
	AL destroyed
Desc:	this call enables QMR after it has been disabled
SeeAlso: AX=C000h"QMR",AX=C002h"QMR"
--------c-2FC003-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - SET ??? FLAG
	AX = C003h
Return: BX destroyed
SeeAlso: AX=C004h"PCACHE"
--------V-2FC004-----------------------------
INT 2F - AD-DOS - GET MINUTES TO WAIT
	AX = C004h
Return: AL = 00h if successful
	    BX = minutes to wait before blanking screen
SeeAlso: AX=C000h"AD-DOS",AX=C003h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC004-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - CLEAR ??? FLAG
	AX = C004h
Return: BX destroyed
SeeAlso: AX=C003h"PCACHE"
--------V-2FC005-----------------------------
INT 2F - AD-DOS - SET BLANKER STATUS
	AX = C005h
	BX = new state (0000h inactive, 0001h active) (default 0001h)
Return: AL = 00h if successful
SeeAlso: AX=C006h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC005-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C005h
	???
Return: BX destroyed
	???
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE"
--------V-2FC006-----------------------------
INT 2F - AD-DOS - GET BLANKER STATUS
	AX = C006h
Return: AL = 00h if successful
	    BX = current state of screen blanker (0000h inactive, 0001h active)
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"AD-DOS",AX=C005h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC006-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C006h
	???
Return: BX destroyed
	???
Note:	this function appears to be identical to AX=C007h
SeeAlso: AX=C000h"PCACHE",AX=C007h"PCACHE"
--------V-2FC007-----------------------------
INT 2F - AD-DOS - SET HOT KEY
	AX = C007h
	BX = hot key
	CL = hot key shift status
Return: AL = 00h if successful
SeeAlso: AX=C008h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC007-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C007h
	???
Return: BX destroyed
	???
Note:	this function appears to be identical to AX=C006h
SeeAlso: AX=C000h"PCACHE",AX=C006h"PCACHE"
--------V-2FC008-----------------------------
INT 2F - AD-DOS - GET CURRENT HOT KEY
	AX = C008h
Return: AX = status
	    0000h successful
		BX = Hot Key
		CL = Hot Key Shift Status
	    0008h otherwise
SeeAlso: AX=C000h"AD-DOS",AX=C007h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC008-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - CLEAR ??? FLAG
	AX = C008h
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C009h"PCACHE"
--------V-2FC009-----------------------------
INT 2F - AD-DOS - UNBLANK MONITOR
	AX = C009h
Return: AL = 00h if successful
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	this function works by simulating keyboard activity
Index:	screen saver;AD-DOS
--------c-2FC009-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - SET ??? FLAG
	AX = C009h
Return: BX destroyed
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE",AX=C008h"PCACHE"
--------V-2FC00A-----------------------------
INT 2F - AD-DOS - ???
	AX = C00Ah
Return: AX = status
	    0000h successful
		BH = ??
		BL = ??
	    000Ah failed
Index:	screen saver;AD-DOS
--------c-2FC00A-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C00Ah
	???
Return: AH = bit flags
	    bit 5: ???
	AL = bit flags
	    bit 4: ???
	    bit 3: ???
	BX destroyed
	???
SeeAlso: AX=C000h"PCACHE"
--------V-2FC00B-----------------------------
INT 2F - AD-DOS - ???
	AX = C00Bh
Return: AX = status
	    0000h successful
	    000Bh failed
Index:	screen saver;AD-DOS
--------c-2FC00B-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - NOP
	AX = C00Bh
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE"
--------V-2FC00C-----------------------------
INT 2F - AD-DOS - SET ??? INTERNAL FLAG TO 01h
	AX = C00Ch
Return: AX = status
	    0000h successful
	    000Ch failed
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Index:	screen saver;AD-DOS
--------c-2FC00C-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ???
	AX = C00Ch
Return: AX = ??? (0000h)
	BX = ??? (0000h)
	CX = ??? (0100h)
	DL = ???
	DH = ???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC00D-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - SET ???
	AX = C00Dh
	DL = ???
Return: BX destroyed
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE"
--------V-2FC00E-----------------------------
INT 2F - AD-DOS - SET PASSWORD STATUS
	AX = C00Eh
	BX = new state (0000h disabled, 0001h enabled)
Return: ???
SeeAlso: AX=C000h"AD-DOS",AX=C00Fh"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC00E-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - INSTALL ???
	AX = C00Eh
	ES:DX -> ???
Return: BX destroyed
Note:	ES:DX is stored internally if the variable is currently 0000h:0000h,
	  but ignored if already set; a counter is incremented
SeeAlso: AX=C000h"PCACHE",AX=C00Fh"PCACHE"
--------V-2FC00F-----------------------------
INT 2F - AD-DOS - GET PASSWORD STATUS
	AX = C00Fh
Return: BX = current state (0000h disabled, 0001h enabled)
SeeAlso: AX=C00Eh"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC00F-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - REMOVE ???
	AX = C00Fh
Return: BX destroyed
Note:	this function decrements the counter used by AX=C00Eh, and clears the
	  internal pointer variable to 0000h:0000h when it reaches zero
SeeAlso: AX=C000h"PCACHE",AX=C00Eh"PCACHE"
--------c-2FC010-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ???
	AX = C010h
	CX = index of ??? table (00h-02h, others treated as 00h)
	SI = offset into data table
Return:	AL = byte at specified offset into table
	BX destroyed
SeeAlso: AX=C000h"PCACHE"
--------c-2FC011-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ???
	AX = C011h
Return: AX = ??? (0007h)
	BX = ??? (0001h)
	CH = ???
	CL = ???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC012-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ???
	AX = C012h
Return: AX = ???
	BX = ???
	CX = ???
	DX = ???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC013-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C013h
	???
Return: BX destroyed
	???
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE"
--------c-2FC014-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C014h
	???
Return: BX destroyed
	???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC015-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C015h
	???
Return: BX destroyed
	???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC016-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - INCREMENT ???
	AX = C016h
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C017h"PCACHE"
--------c-2FC017-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - DECREMENT ???
	AX = C017h
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C016h"PCACH"
--------c-2FC018-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C018h
	???
Return: BX destroyed
	???
Note:	the first instruction of this function is an indirect jump which points
	  at a RET by default
SeeAlso: AX=C000h"PCACHE",AX=C019h"PCACHE"
--------c-2FC019-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C019h
	???
Return: BX destroyed
	???
Note:	the first instruction of this function is an indirect jump which points
	  at a RET by default
SeeAlso: AX=C000h"PCACHE",AX=C018h"PCACHE"
--------c-2FC01A-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - CLEAR ??? FLAG
	AX = C01Ah
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C01Bh"PCACHE"
--------c-2FC01B-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - SET ??? FLAG
	AX = C01Bh
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C01Ah"PCACHE"
--------c-2FC01C-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C01Ch
	???
Return: AX = ???
	BX destroyed
SeeAlso: AX=C000h"PCACHE"
--------c-2FC01D-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - NOP
	AX = C01Dh to C01Fh
Return: BX destroyed
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE"
--------V-2FC020-----------------------------
INT 2F - AD-DOS - GET AND RESET VxD API STATUS
	AX = C020h
Return: AL = 00h if successful
	    BX = VxD API Status
		0000h no error
		0001h error
		0100h neither Windows 3.X enhanced mode nor Windows/386 2.x
			  is running
		0200h VM API entry point not found (VxD not installed)
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	this call resets the VxD API Status to zero
SeeAlso: AX=1602h,AX=1607h
Index:	screen saver;AD-DOS
--------V-2FC04E-----------------------------
INT 2F - Explosiv v2.00+ - NON-TSR EXECUTING CHECK
	AX = C04Eh
Return: AL = 4Fh if Explosiv is running but not memory-resident
Program: Explosiv is a shareware animated screen blanker for DOS and Windows 3
	  by H&G Software (Reidar Gresseth and Chris Hook)
Range:	AH=C0h to AH=C9h, selected by configuration
SeeAlso: AX=C050h
Index:	screen saver;Explosiv
--------V-2FC050-----------------------------
INT 2F - Explosiv v2.00+ - INSTALLATION CHECK
	AX = C050h
Return: AL = 51h if installed
	---v3.0+ ---
	    BX = interval in clock ticks
	    CH = animation display color (00h mono, 01h tinge, 02h color)
	    CL = animation delay factor
	    DH = animation parameters
	    DL = INT 10 checking (00h on, 01h off)
	    SI = number of bytes available for animation code
	    DI = display type (00h VGA, 01h EGA, 02h CGA, 03h HGC, 04h MDA)
Program: Explosiv is a shareware animated screen blanker for DOS and Windows 3
	  by H&G Software (Reidar Gresseth and Chris Hook)
Range:	AH=C0h to AH=C9h, selected by configuration
SeeAlso: AH=93h,AX=C000h"AD-DOS",AX=C04Eh,AX=C052h,AX=C054h"v3"
SeeAlso: INT 14/AX=AA01h
Index:	screen saver;Explosiv
--------V-2FC052-----------------------------
INT 2F - Explosiv v2.00+ - UNINSTALL
	AX = C052h
	DX:BX = address to return to on successful uninstall
Return: at specified address if successful
	AL = 53h on error
Note:	specified return address must have the segment of the caller's PSP
SeeAlso: AX=C050h
Index:	screen saver;Explosiv
--------V-2FC054-----------------------------
INT 2F - Explosiv v2.x - GET ANIMATION DELAY FACTOR
	AX = C054h
Return: AL = delay factor
SeeAlso: AX=C057h
Index:	screen saver;Explosiv
----------2FC054-----------------------------
INT 2F - Explosiv v3.0+ - UPDATE PARAMETERS
	AX = C054h
	BX = new interval in clock ticks
	CH = animation display color (00h mono, 01h tinge, 02h color)
	CL = animation delay factor
	DH = animation parameters
	DL = INT 10 checking (00h on, 01h off)
SeeAlso: AX=C050h
--------V-2FC055-----------------------------
INT 2F - Explosiv v2.x - SET BLANKING INTERVAL
	AX = C055h
	BX = new interval in clock ticks
Index:	screen saver;Explosiv
--------V-2FC056-----------------------------
INT 2F - Explosiv v2.x - SET ANIMATION DISPLAY TYPE
	AX = C056h
	BL = animated display type (00h mono, 01h color)
SeeAlso: AX=C058h"v2.x"
Index:	screen saver;Explosiv
--------V-2FC056-----------------------------
INT 2F - Explosiv v3.0+ - ENABLE/DISABLE EXPLOSIV
	AX = C056h
	BX = new state
	    0000h disabled
	    0100h enabled
	    0101h enabled, but never blank
	    0102h enabled, always blank
--------V-2FC057-----------------------------
INT 2F - Explosiv v2.x - SET ANIMATION DELAY FACTOR
	AX = C057h
	BL = delay factor
SeeAlso: AX=C054h"v2.x"
Index:	screen saver;Explosiv
--------V-2FC058-----------------------------
INT 2F - Explosiv v2.x - SET ANIMATION PARAMETER
	AX = C058h
	BL = animation parameter
Note:	the animation parameter has different interpretations for each display
SeeAlso: AX=C056h"v2.x"
Index:	screen saver;Explosiv
----------2FC058-----------------------------
INT 2F - Explosiv v3.0+ - LOAD NEW ANIMATION DISPLAY CODE
	AX = C058h
	BX = file handle for file containing display code
	CX = number of bytes to load
	DX = offset at which animation code should be loaded
Return: AL = status (see #1717)
Note:	if AL=00h-03h on return, the file will be closed

(Table 1717)
Values for Explosiv function status:
 00h	successful
 01h	code too large to available space
 02h	no data read, load aborted
 03h	incomplete load, default blanking display loaded instead
 58h	unexpected offset in DX
--------V-2FC059-----------------------------
INT 2F - Explosiv v2.x - DISABLE EXPLOSIV
	AX = C059h
Note:	clears flag set by AX=C05Ah
SeeAlso: AX=C05Ah
Index:	screen saver;Explosiv
--------V-2FC05A-----------------------------
INT 2F u - Explosiv v2.x - ENABLE EXPLOSIV
	AX = C05Ah
	BL = ???
Note:	sets flag cleared by AX=C059h then stores BL
SeeAlso: AX=C059h,AX=C05Bh
Index:	screen saver;Explosiv
--------V-2FC05B-----------------------------
INT 2F - Explosiv v2.x - CHANGE ANIMATION DISPLAY
	AX = C05Bh
	BL = animation display
Note:	this function fails silently if the requested display is not in memory
SeeAlso: AX=C05Ah,AX=C05Ch
Index:	screen saver;Explosiv
--------V-2FC05C-----------------------------
INT 2F - Explosiv v2.x - SET INT 10 CHECKING
	AX = C05Ch
	BL = new state of INT 10 checking (00h enabled, 01h disabled)
SeeAlso: AX=C05Bh
Index:	screen saver;Explosiv
--------K-2FC0AE-----------------------------
INT 2F U - HP 100LX/200LX - PUSHKEYS - INSTALLATION CHECK
	AX = C0AEh
Return: AX = 4453h if installed
	CX = 5259h if installed
Range:	AH=C0h to AH=FFh, selected by scanning for signature
SeeAlso: AX=C000h"HP 100LX",AX=C001h"HP 100LX",AX=C0AFh"HP 100LX"
--------K-2FC0AF-----------------------------
INT 2F U - HP 100LX/200LX - PUSHKEYS - INTERNAL - GET BUFFER ADDRESS
	AX = C0AFh
Return: ES:DI -> buffer (behind code)
Range:	AH=C0h to AH=FFh, selected by scanning for signature with AL=AEh
SeeAlso: AX=C000h"HP 100LX",AX=C001h"HP 100LX",AX=C0AEh"HP 100LX"
--------N-2FC100-----------------------------
INT 2F U - Personal NetWare - STPIPX v1.00 - INSTALLATION CHECK
	AX = C100h
Return: AL = FFh if installed
	    ES:SI -> signature string "STP-IPX$"
	    BX = version??? (0001h for v1.00)
	    DI corrupted
Note:	AH=C1h is the default value; STPIPX probably scans a range of
	  multiplex numbers to find a free one, as LSL does
SeeAlso: AX=C000h"LSL",AX=C101h
----------2FC101-----------------------------
INT 2F U - Personal NetWare - STPIPX v1.00 - UNINSTALL
	AX = C101h
Return: AL = status???
	BX corrupted
SeeAlso: AX=C101h
--------d-2FC300-----------------------------
INT 2F - SETWPR.COM - INSTALLATION CHECK
	AX = C300h
Return: AL = FFh if installed
Program: SETWPR is a hard-disk write-protection TSR by Jaroslaw Rafa
SeeAlso: AX=C302h"SETWPR"
--------k-2FC300DX0000-----------------------
INT 2F U - SpaceManager - INSTALLATION CHECK
	AX = C300h
	DX = 0000h
Return: AL = FFh if any SpaceManager programs installed
	    BX = 6F73h
	    CX = 6F68h
Program: SpaceManager is an enhancement for MS-DOS DoubleSpace by Vertisoft
	  Systems, Inc.
Range:	AH=C3h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C300h/DX=0666h
--------k-2FC300-----------------------------
INT 2F U - SpaceManager - INSTALLATION VERIFICATION
	AX = C300h
	DX = program identifier (see #1718) or 0666h for any SpaceManager prog
	BX = 4F53h ('OS')
	CX = 4F48h ('OH')
Return: AL = FFh if BX/CX as specified and specified program installed
	    BX = 6F73h ('os')
	    CX = 6F68h ('oh')
Range:	AH=C3h to AH=FFh, selected by scanning for first free multiplex number
Note:	this call is chained if BX,CX, or DX are not as specified above
SeeAlso: AX=C300h/DX=0000h

(Table 1718)
Values for SpaceManager program identifier:
 9000h	SMOUNT (SuperMount)
 9001h	SELECTC (SelectCompress)
 9002h	SUPERX (SuperExchange)
 9003h	FORTUNE (FortuneTeller)
--------k-2FC301-----------------------------
INT 2F U - SpaceManager - ???
	AX = C301h
	DX = program identifier (9000h,9001h,9003h) (see #1718)
	???
Return: ???
--------k-2FC302-----------------------------
INT 2F U - SpaceManager - ENABLE PROGRAM
	AX = C302h
	DX = program identifier (9000h,9001h,9003h) (see #1718)
Return: AX destroyed
SeeAlso: AX=C303h,AX=C306h
--------d-2FC302-----------------------------
INT 2F - SETWPR.COM - SET WRITE-PROTECTION STATE
	AX = C302h
	BL = new state
	    00h disk may be written
	    01h disk write-protected
Return: AL = FFh if installed
Program: SETWPR is a hard-disk write-protection TSR by Jaroslaw Rafa
SeeAlso: AX=C300h"SETWPR"
--------k-2FC303-----------------------------
INT 2F U - SpaceManager - DISABLE PROGRAM
	AX = C303h
	DX = program identifier (9000h,9001h,9003h) (see #1718)
Return: AX destroyed
SeeAlso: AX=C302h,AX=C306h
--------k-2FC304-----------------------------
INT 2F U - SpaceManager - GET PER-DRIVE ENABLEMENT TABLE
	AX = C304h
	DX = program identifier (9000h,9001h,9003h) (see #1718)
Return: ES:BX -> 26-byte drive table (00h disabled for drive, 01h enabled)
	AX destroyed
--------k-2FC305DX9003-----------------------
INT 2F U - SpaceManager - FORTUNE.EXE - NOP
	AX = C305h
	DX = 9003h
Return: AX destroyed
--------k-2FC305-----------------------------
INT 2F U - SpaceManager - ???
	AX = C305h
	DX = program identifier (9000h,9001h) (see #1718)
	???
Return: ???
--------k-2FC306-----------------------------
INT 2F U - SpaceManager - CHECK WHETHER PROGRAM ENABLED
	AX = C306h
	DX = program identifier (9000h,9001h,9003h) (see #1718)
Return: AL = current state (00h disabled, FAh enabled)
	AH destroyed
SeeAlso: AX=C302h,AX=C303h
--------k-2FC307DX9001-----------------------
INT 2F U - SpaceManager - SELECTC - ???
	AX = C307h
	DX = 9001h
	BX = ???
	CX = ???
	???
Return: ???
--------k-2FC308DX9001-----------------------
INT 2F U - SpaceManager - SELECTC - ???
	AX = C308h
	DX = 9001h
	???
Return: ???
--------d-2FC64CBX5553-----------------------
INT 2F U - Smart Prompt - INSTALLATION CHECK
	AX = C64Ch
	BX = 5553h
Return: AX = 4CC6h if installed
	BX = 5355h if installed
Program: Smart Prompt (SMARTPMT) is a freeware TSR by Steve Gibson which forces
	  an immediate flush of SmartDrive's (and compatible caches') buffers
	  on returning to the DOS prompt
--------V-2FC700CX434C-----------------------
INT 2F u - COLAP - INSTALLATION CHECK
	AX = C700h
	CX = 434Ch  "CL"
Return: AL = FFh if installed
Program: colap.com is a freeware TSR by Eric Meyer which controls contrast
	  and brightness of color laptops by changing the VGA palette colors;
	  for Toshiba laptops there are more hotkeys for shutting off display
	  and harddisk.
--------v-2FC900BP0000-----------------------
INT 2F U - ThunderByte??? - INSTALLATION CHECK
	AX = C900h
	BP = 0000h
Return: AL = FFh if installed
	    BP >= 0014h
Note:	called by TBSCANX
SeeAlso: AX=C987h,AX=CA00h
--------v-2FC987-----------------------------
INT 2F U - ThunderByte??? - DISINFECT FILE???
	AX = C987h
	BX:DX -> filename
	BX:CX -> virus name
Return: AX = status
	    0000h successful???
Note:	called by TBSCANX
SeeAlso: AX=CA00h
--------r-2FC9FF-----------------------------
INT 2F C - StackMan - INSTALLATION BROADCAST
	AX = C9FFh
	BL = BCD version number
	CX = number of stacks
	DX = stack size in bytes
Program: StackMan is a freeware stack manager by Franz Veldman of ESaSS B.V.
	  which functions as a replacement for the DOS STACK= command as well
	  as permitting multiple TSRs to share a pool of stack space
Notes:	called by StackMan when it goes resident to inform interested TSRs that
	  its API is available
	the installation check consists of testing for the string "STACKXXX" at
	  offset 0Ah from the INT B4 handler
SeeAlso: INT B4"StackMan",INT B5"StackMan"
Index:	installation check;STACKMAN|broadcasts;STACKMAN installation
--------F-2FCA-------------------------------
INT 2F - FAXPLUS - FAX TSR
	AH = CAh
	???
Return: ???
Program: FAXTSR is a resident FAX send/receive module for FAXPLUS by Frans
	  Veldman
SeeAlso: AH=2Ah"Gammafax"
--------v-2FCA00BX5442-----------------------
INT 2F - TBSCANX - INSTALLATION CHECK
	AX = CA00h
	BX = 5442h ('TB')
Return: AL = state
	    00h not installed
	    FFh installed
		BX = 7462h ('tb') if BX was 5442h on entry
Program: TBSCANX is a resident virus scanning module by Frans Veldman.
Note:	programs may perform virus checks on themselves, other program files,
	  or their data files by invoking the TBSCANX API.
SeeAlso: AX=4653h,AX=C900h
--------v-2FCA01-----------------------------
INT 2F - TBSCANX - GET STATUS
	AX = CA01h
Return: AH = BCD version number (v2.2+)
	    CAh for versions before 2.2
	AL = state (00h = disabled, 01h = enabled)
	CX = number of signatures which will be searched
---v2.0---
	BX = EMS handle, 0000h if not using EMS
---v2.3+---
	BX = segment of swap area, 0000h if not swapped
	DX = EMS or XMS handle (XMS handle if BX=0000h), FFFFh if not using EMS
SeeAlso: AX=CA02h
--------v-2FCA02-----------------------------
INT 2F - TBSCANX - SET STATE
	AX = CA02h
	BL = new state (00h = disabled, 01h = enabled)
SeeAlso: AX=CA01h
--------v-2FCA03-----------------------------
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
--------v-2FCA04-----------------------------
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
--------U-2FCAFEBX0000-----------------------
INT 2F U - THELP v3.0 - INSTALLATION CHECK
	AX = CAFEh
	BX = 0000h
Return: BX = segment of resident code if installed
	    0000h if not installed
SeeAlso: AX=5453h,INT 2D"AMIS"
--------F-2FCB00-----------------------------
INT 2F - Communicating Applications Specification - INSTALLATION CHECK
	AX = CB00h
Return: AL = status
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
Note:	AH = CBh is the default identifier, but may be reconfigured
SeeAlso: AH=2Ah,AX=8000h"FaxBIOS",AX=CB0Eh,AX=CBDCh
--------F-2FCB00BX4D53-----------------------
INT 2F - MTEZ XpressFax CASMGR - INSTALLATION CHECK
	AX = CB00h
	BX = 4D53h ('MS')
	CX = 4949h ('II')
Return: AL = status
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
		BX = 6D73h ('ms')
		CX = 6969h ('ii')
Note:	this function is equivalent to the standard CASMGR installation check,
	  but uses the additional magic values to identify which CAS is
	  installed
SeeAlso: AH=2Ah,AX=8000h"FaxBIOS",AX=C000h/BX=444Bh,AX=CB0Eh,AX=CB16h
--------F-2FCB01-----------------------------
INT 2F - Communicating Applications Specification - SUBMIT A TASK
	AX = CB01h
	DS:DX -> ASCIZ name of task control file
Return: AX >= 0: event handle
	AX < 0: two's complement of error code (see #1719)
Note:	files needed for an event must be kept until task is complete or error
SeeAlso: AX=CB0Bh,AX=CB15h

(Table 1719)
Values for CAS error code:
  (AH = class, AL = subcode, value passed back is 2's complement)
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
	Subcode 00h	multiplex handler failed
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
--------F-2FCB02-----------------------------
INT 2F - Communicating Applications Specification - ABORT CURRENT EVENT
	AX = CB02h
Return: AX >= 0: event handle of aborted event
	AX < 0: error code (see #1719)
Note:	termination could take up to 30 seconds
SeeAlso: AX=CB08h,AX=CB10h
--------F-2FCB05-----------------------------
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
	AX < 0	   error code (see #1719)
SeeAlso: AX=CB06h,AX=CB07h
--------F-2FCB06-----------------------------
INT 2F - Communicating Applications Specification - FIND NEXT QUEUE ENTRY
	AX = CB06h
	DL = queue to search
	    00h task queue
	    01h receive queue
	    02h log queue
Return: AX = 0000h successful
	    BX = event handle for found event
	AX < 0	   error code (see #1719)
Note:	direction of search is same as preceding FIND FIRST call
SeeAlso: AX=CB05h
--------F-2FCB07-----------------------------
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
	AX < 0	   error code (see #1719)
Note:	the returned file handle has been opened in read-only mode and should
	  be closed with INT 21/AH=3Eh after use
SeeAlso: AX=CB01h,AX=CB05h,AX=CB14h
--------F-2FCB08-----------------------------
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
	AX < 0	   error code (see #1719)
SeeAlso: AX=CB02h,AX=CB09h
--------F-2FCB09-----------------------------
INT 2F - Communicating Applications Specification - DELETE ALL FILES IN Q
	AX = CB09h
	DL = queue
	    00h delete all control files in task queue, including all group
		  files
	    01h delete all files in receive queue
	    02h delete all control files in log queue, including all group
		  files
Return: AX = 0000h successful
	AX < 0	   error code (see #1719)
SeeAlso: AX=CB08h
--------F-2FCB0A-----------------------------
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
	AX < 0	   error code (see #1719)
SeeAlso: AX=CB0Bh,AX=CB0Ch
--------F-2FCB0B-----------------------------
INT 2F - Communicating Applications Specification - SET TASK DATE
	AX = CB0Bh
	BX = event handle (task event only)
	CX = year
	DH = month
	DL = day
Return: AX = 0000h successful
	AX < 0	   error code (see #1719)
Note:	setting a task's date and time to before the current date and time
	  causes it to execute immediately
SeeAlso: AX=CB01h,AX=CB0Ah,AX=CB0Dh
--------F-2FCB0C-----------------------------
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
	AX < 0	   error code (see #1719)
SeeAlso: AX=CB0Ah,AX=CB0Dh
--------F-2FCB0D-----------------------------
INT 2F - Communicating Applications Specification - SET TASK TIME
	AX = CB0Dh
	BX = event handle (task events only)
	CH = hour
	CL = minute
	DH = second
	DL unused
Return: AX = 0000h successful
	AX < 0	   error code (see #1719)
Note:	setting a task's date and time to before the current date and time
	  causes it to execute immediately
SeeAlso: AX=CB0Bh,AX=CB0Ch,AX=CB10h
--------F-2FCB0E-----------------------------
INT 2F - Communicating Applications Specification - GET EXTERNAL DATA BLOCK
	AX = CB0Eh
	DS:DX -> 256-byte buffer for external data block (see #1720)
Return: AX = 0000h successful
	    DS:DX buffer filled
	AX < 0	   error code (see #1719)

Format of CAS external data block:
Offset	Size	Description	(Table 1720)
 00h	BYTE	CAS major version
 01h	BYTE	CAS minor version
 02h 68 BYTEs	ASCIZ path to directory containing CAS software, ends in slash
 46h 13 BYTEs	ASCIZ name of current phonebook (in CAS directory)
 53h 13 BYTEs	ASCIZ name of current logo file (in CAS directory)
 60h 32 BYTEs	ASCIZ default sender name
 80h 21 BYTEs	ASCIZ CCITT identification of fax device
 95h 107 BYTEs	reserved
--------F-2FCB0F-----------------------------
INT 2F - Communicating Applications Specification - GET/SET AUTORECEIVE
	AX = CB0Fh
	DL = subfunction
	    00h get current autoreceive state
	    01h set autoreceive state
		DH = number of rings before answer, 00h = never
Return: AX = 0000h autoreceive disabled
	AX = N	   number of rings before answer
	AX < 0	   error code (see #1719)
--------F-2FCB10-----------------------------
INT 2F - Communicating Applications Specification - GET CURRENT EVENT STATUS
	AX = CB10h
	DS:DX -> 512-byte buffer for status area (see #1722)
Return: AX = 0000h successful
		BX = event handle of current event or negative error code if
		      no current event
		buffer filled
	AX < 0	   error code (see #1719)
SeeAlso: AX=CB02h,AX=CB0Dh

(Table 1721)
Values for CAS event type:
 00h	send
 01h	receive
 02h	polled send
 03h	polled receive
 04h to 7Fh reserved
 FFh	serious hardware error

Format of CAS status area:
Offset	Size	Description	(Table 1722)
 00h	BYTE	event type (see #1721)
 01h	BYTE	transfer type
		00h 200x200 dpi, FAX mode
		01h 100x200 dpi, FAX mode
		02h file transfer mode
		03h to 7Fh reserved
 02h	WORD	event status (see #1723)
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
17Fh 128 BYTEs	file transfer record for current event (see #1724)

(Table 1723)
Values for CAS event status:
 0000h	completed successfully
 0001h	waiting
 0002h	number dialed
 0003h	connected, sending
 0004h	connected, receiving
 0005h	aborted
 0006h to 007Fh reserved
 0080h to 7FFFh application-specific events
 8000h to FFFFh error codes

Format of CAS file transfer record:
Offset	Size	Description	(Table 1724)
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
--------F-2FCB11-----------------------------
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
	AX < 0	error code (see #1719)
SeeAlso: AX=CB12h
--------F-2FCB11DL03-------------------------
INT 2F - Communicating Applications Spec v1.2+ - GET NUMBER OF SEND EVENTS
	AX = CB11h
	DL = 03h
Return: AX = number of successful sends since resident manager started
	BX = number of unsuccessful sends, including warnings
SeeAlso: AX=CB11h/DL=04h
--------F-2FCB11DL04-------------------------
INT 2F - Communicating Applications Spec v1.2+ - GET NUMBER OF RECEIVE EVENTS
	AX = CB11h
	DL = 04h
Return: AX = number of received file events since resident manager started
	BX = number of received FAX events
SeeAlso: AX=CB11h/DL=03h
--------F-2FCB12-----------------------------
INT 2F - Communicating Applications Specification - GET HARDWARE STATUS
	AX = CB12h
	DS:DX -> 128-byte status buffer (see #1725,#1727)
Return: AX = 0000h successful
	    DS:DX buffer filled with hardware-dependent status information
	   < 0	   error code (see #1719)
SeeAlso: AX=CB10h,AX=CB11h

Format of status buffer for Intel Connection CoProcessor:
Offset	Size	Description	(Table 1725)
 00h	BYTE	Connection CoProcessor connection status flags (see #1728)
 01h	BYTE	number of kilobytes of free buffer space
 02h	BYTE	page buffer status
		bit 7: Connection CoProcessor has documents to send
		bits 6-0: number of pages in buffer
 03h	BYTE	number of retries left for dialing number
 04h	BYTE	page number to retransmit
 05h	BYTE	communications status (see #1729)
 06h	BYTE	baud rate (see #1726)
 07h  3 BYTEs	reserved
 0Ah	BYTE	Connection CoProcessor hardware status (see #1730)
 0Bh	BYTE	Connection CoProcessor switch states (see #1731)
 0Ch	BYTE	communications flags (see #1732)
 0Dh	BYTE	reserved
 0Eh	WORD	error count (only valid while busy, reset when idle)
 10h	DWORD	size of nonstandard format (NSF) file in bytes
 14h	BYTE	'A' if Connection CoProcessor board present
 15h  9 BYTEs	reserved
 1Eh 21 BYTEs	ASCIZ CCITT identification
 33h 77 BYTEs	reserved
Note:	the Intel Connection CoProcessor and SatisFAXtion may be distinguished
	  by examining the byte at offset 14h

Bitfields for Connection CoProcessor baud rate:
Bit(s)	Description	(Table 1726)
 7	reserved
 6-4	baud rate
	000 = 300 baud	(V.21 SDLC or HDLC mode)
	100 = 2400 baud (V.27 ter)
	101 = 4800 baud (V.27 ter)
	110 = 7200 baud (V.29)
	111 = 9600 baud (V.29)
 3-0	reserved, should be 0110

Format of status buffer for Intel SatisFAXtion board:
Offset	Size	Description	(Table 1727)
 00h	BYTE	SatisFAXtion connection status flags (see #1733)
 01h	BYTE	SatisFAXtion board state (see #1734)
 02h	BYTE	number of KB free in buffer
 03h	BYTE	number of pages or files in buffer
 04h	BYTE	number of redials remaining on current number
 05h	BYTE	FAX page number to retransmit
 06h	BYTE	current page/file in block transfer
 07h	BYTE	number of rings received (only if auto-answer enabled)
 08h	WORD	error count
 0Ah	DWORD	length of file being transferred
 0Eh  6 BYTEs	reserved
 14h	BYTE	'B' if SatisFAXtion board present
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

Bitfields for Connection CoProcessor connection status flags:
Bit(s)	Description	(Table 1728)
 7	hardware busy sending or receiving
 6	last page of data
 5	no data on current page
 4	retransmit request for current page being transmitted
 3	NSF (nonstandard file) mode active
 2-0	reserved

Bitfields for communications status:
Bit(s)	Description	(Table 1729)
 7	originating call
 6	FAX message to be sent
 5	on line
 4	ring detected and receive enabled
 3	buffer dumped on receive
 2-0	hardware sequence state
	000 idle
	001 dial
	010 answer
	011 transmit
	100 receive
	101 pre-message
	110 post-message
	111 disconnect

Bitfields for Connection CoProcessor hardware status:
Bit(s)	Description	(Table 1730)
 7	modem option installed
 6	Connection CoProcessor has control of DAA (not latched)
 5	on line (not latched)
 4	ring detected (not latched)
 3	data in command buffer (not latched)
 2	set if using DMA channel 1, clear if using DMA channel 3
 1	line length compensation 1 set (not latched)
 0	line length compensation 0 set (not latched)

Bitfields for Connection CoProcessor switch states:
Bit(s)	Description	(Table 1731)
 7	reserved
 6	unused
 5	spare switch open
 4	FAX ADR1 switch open
 3	FAX ADR0 switch open
 2	alternate interrupt switch open
 1	COM SEL 1 switch open
 0	COM SEL 0 switch open
Note:	valid combinations of 0-2 are
	000  COM2 IRQ3 IObase 2F8h
	001  COM1 IRQ4 IObase 3F8h
	010  COM4 IRQ3 IObase 2E8h
	011  COM3 IRQ4 IObase 3E8h
	110  COM4 IRQ2 IObase 2E8h
	111  COM3 IRQ5 IObase 3E8h

Bitfields for communications flags:
Bit(s)	Description	(Table 1732)
 7	reserved
 6	auxiliary relay forced ON
 5	modem select relay forced ON
 4	offhook relay forced ON
 3	9600 bps enabled
 2	7200 bps enabled
 1	4800 bps enabled
 0	2400 bps enabled

Bitfields for SatisFAXtion connection status flags:
Bit(s)	Description	(Table 1733)
 7	busy in T.30 CCITT fax protocol
 6	data on current page/file (only used for block xfers)
 5	retransmission of last page requested
 4	in file transfer mode
 3	data in buffer
 2	data buffer dumped on receive
 1	200x100 dpi resolution instead of 200x200 dpi
 0	data modem in use, FAX image modem not available

Bitfields for SatisFAXtion board state:
Bit(s)	Description	(Table 1734)
 7	reserved
 6	handset jack active, data and FAX modems not available
 5-3	current rate
	000  300 bps (V.21 HDLC)
	100 2400 bps (V.27 ter)
	101 4800 bps (V.27 ter)
	110 7200 bps (V.29)
	111 9600 bps (V.29)
 2-0	T.30 CCITT protocol state
	000 idle
	001 dialing
	010 answering
	011 transmitting
	100 receiving
	101 pre-message
	110 post-message
	111 disconnect
--------F-2FCB13DL00-------------------------
INT 2F - Communicating Applications Specification - GET DIAGNOSTICS RESULTS
	AX = CB13h
	DL = 00h
Return: AX = 0040h in progress
	   >= 0	   passed
	   < 0	   hardware-dependent failure code (see #1735,#1736)
SeeAlso: AX=CB13h/DL=01h

Bitfields for Intel Connection CoProcessor failure codes:
Bit(s)	Description	(Table 1735)
 3	9600 bps FAX modem module failed
 2	SDLC chip failed
 1	RAM failed
 0	ROM checksum failed

Bitfields for Intel SatisFAXtion failure codes:
Bit(s)	Description	(Table 1736)
 1	2400 bps data modem failed
 0	9600 bps FAX modem failed
--------F-2FCB13DL01-------------------------
INT 2F - Communicating Applications Specification - START DIAGNOSTICS
	AX = CB13h
	DL = 01h
Return: AX = 0000h successfully started
	AX < 0	   error code (see #1719)
SeeAlso: AX=CB13h/DL=00h
--------F-2FCB14-----------------------------
INT 2F - Communicating Applications Specification - MOVE RECEIVED FILE
	AX = CB14h
	BX = event handle
	CX = receive file number
	    0001h first received file
	    N	  Nth received file
	DS:DX -> ASCIZ string specifying new name for file (must not exist)
Return: AX = 0000h successful
	AX < 0	   error code (see #1719)
--------F-2FCB15-----------------------------
INT 2F - Communicating Applications Specification - SUBMIT FILE TO SEND
	AX = CB15h
	DS:DX -> variable-length data area (see #1737)
Return: AX >= 0 event handle
	AX < 0	error code (see #1719)
SeeAlso: AX=CB01h

Format of CAS file submission data area:
Offset	Size	Description	(Table 1737)
 00h	BYTE	transfer type
		00h = 200x200 dpi, fax mode
		01h = 100x200 dpi, fax mode
		02h = file transfer mode
		03h to 7Fh reserved
 01h	BYTE	text size
		00h = 80 columns
		01h = 132 columns
		02h to 7Fh reserved
 02h	WORD	time to send (DOS packed time, see #0876 at INT 21/AX=5700h)
 04h	WORD	date to send (DOS packed date, see #0877 at INT 21/AX=5700h)
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
--------F-2FCB16BX1234-----------------------
INT 2F - Communicating Applications Spec v1.2+ - UNLOAD RESIDENT MANAGER
	AX = CB16h
	BX = 1234h
	CX = 5678h
	DX = 9ABCh
Return: AX = 0000h successful
	AX < 0	   error code
Note:	the MTEZ XpressFax CASMGR ignores the values in BX,CX, and DX
SeeAlso: AX=C000h/BX=444Bh,AX=CB00h
Index:	uninstall;CAS Manager
--------F-2FCB17-----------------------------
INT 2F - Communicating Applications Spec v1.2+ - SET COVER PAGE STATUS
	AX = CB17h
	BX = event handle
	CL = cover page status
	    00h not read
	    01h read by user
Return: AX = 0000h successful
	AX < 0	   error code
--------F-2FCB80-----------------------------
INT 2F - Intel SatisFAXtion CASMGR - ???
	AX = CB80h
	???
Return: ???
--------F-2FCB81-----------------------------
INT 2F - Intel SatisFAXtion CASMGR - ???
	AX = CB81h
	???
Return: ???
--------F-2FCB82-----------------------------
INT 2F - Intel SatisFAXtion CASMGR - ???
	AX = CB82h
	???
Return: ???
--------F-2FCBDCBL56-------------------------
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
--------F-2FCBDDBL56-------------------------
INT 2F - Comwave Microfax Specification - COMMAND SUBMISSION
	AX = CBDDh
	BL = 56h
	BH = ?
	CX:DX -> command to execute
Return: AX = status
	    0000h success
	    FFFFh on error
SeeAlso: AH=2Ah,AX=CBDCh,AX=80FBh
--------c-2FCC--SI5453-----------------------
INT 2F U - PC-Kwik Programs - API
	AH = CCh
	SI = 5453h or 7473h
	AL = function number (at least 00h,01h,04h,05h,07h,80h)
	DL = program identifier (see #1738)
Return: SI = 7473h
	other registers vary by function
Note:	Qualitas Qcache v4.00 is an OEM version of Super PC-Kwik v4.00, and
	  thus supports this call
SeeAlso: INT 21/AH=2Bh/CX=4358h

(Table 1738)
Values for PC-Kwik program identifier:
 00h	all installed PowerPak programs
 01h	SUPERPCK/SUPER/QCACHE v4.00+ (disk cache)
 02h	PCKSPL (print spooler)
 04h	PCKSCRN (screen accelerator)
 05h	PCKKEY (keyboard enhancer)
 06h	PCKRAMD (RAM disk)
 08h	PCKWIK.SYS
 10h	PCKCDROM (CD-ROM support for SUPERPCK)
--------N-2FCC00-----------------------------
INT 2F - Tsoft NFSDRVR - INSTALLATION CHECK
	AX = CC00h
Return: AX = 7777h
	BX = ???
	CX = ???
	DX = ???
	ES = data segment of resident portion
SeeAlso: AX=CC01h,AX=CC06h
--------N-2FCC01-----------------------------
INT 2F - Tsoft NFSDRVR - ???
	AX = CC01h
	???
Return: ???
SeeAlso: AX=CC00h
--------N-2FCC02-----------------------------
INT 2F - Tsoft NFSDRVR - ???
	AX = CC02h
	???
Return: ???
SeeAlso: AX=CC00h
--------N-2FCC03-----------------------------
INT 2F - Tsoft NFSDRVR - ???
	AX = CC03h
	???
Return: ???
SeeAlso: AX=CC00h
--------N-2FCC04-----------------------------
INT 2F - Tsoft NFSDRVR - ???
	AX = CC04h
	???
Return: ???
SeeAlso: AX=CC00h
--------N-2FCC05-----------------------------
INT 2F - Tsoft NFSDRVR - ???
	AX = CC05h
	???
Return: ???
SeeAlso: AX=CC00h
--------N-2FCC06-----------------------------
INT 2F - Tsoft NFSDRVR - ???
	AX = CC06h
	???
Return: ???
SeeAlso: AX=CC00h
----------2FCD00-----------------------------
INT 2F - Intel Image Processing Interface - INSTALLATION CHECK
	AX = CD00h
Return: AL = state
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
SeeAlso: AX=CD02h"Image"
--------P-2FCD00-----------------------------
INT 2F - LaserPort Interface - INSTALLATION CHECK
	AX = CD00h
Return: AL = status
	    FFh installed
SeeAlso: AX=CD0Fh"LaserPort"
--------U-2FCD00-----------------------------
INT 2F - SWELL.EXE - INSTALLATION CHECK
	AX = CD00h
Return: AX = 00FFh installed
	    BH = major version
	    BL = minor version
Program: SWELL.EXE is a TSR which swaps programs to disk when they EXEC a child
	  process with INT 21/AH=4Bh
--------s-2FCD00BX464F-----------------------
INT 2F - Forte/Gravis - INSTALLATION CHECK
	AX = CD00h
	BX = 464Fh ('FO')
	CX = 5254h ('RT')
	DX = 4520h ('E ')
Return: AX = CDFFh if installed
	    BX = 4155h ('AU')
	    CX = 4449h ('DI')
	    DX = 4F20h ('O ')
	    ES:SI -> program ID string
SeeAlso: INT 21/AX=FD12h
----------2FCD01-----------------------------
INT 2F - Intel Image Processing Interface - SET DEVICE NAME
	AX = CD01h
	CX:BX -> ASCIZ character device name ("LPTn", "COMn", "PRN")
Return: AL = status
	    00h successful
		CX:BX -> internal character device name
	    80h error
--------U-2FCD01-----------------------------
INT 2F - SWELL.EXE - SUSPEND ONCE
	AX = CD01h
Return: AX = 0000h
SeeAlso: AX=CD02h"SWELL"
----------2FCD02-----------------------------
INT 2F - Intel Image Processing Interface - GET VERSION NUMBER
	AX = CD02h
Return: AL = status
	    00h/01h successful
		BH = major version number (BCD)
		BL = minor version number (BCD)
	    80h error
Note:	if return AL = 01h, the IPI supports network redirection
SeeAlso: AX=CD00h"Image"
--------U-2FCD02-----------------------------
INT 2F - SWELL.EXE - SUSPEND
	AX = CD02h
Return: AX = 0000h
SeeAlso: AX=CD03h"SWELL"
----------2FCD03-----------------------------
INT 2F - Intel Image Processing Interface - SELECT SCAN LINE
	AX = CD03h
	BX = scan line
	CX = requested density in dots per inch (300, 600, or 1200)
Return: AL = status (see also AX=CD04h"Image")
	    00h successful
		CX = density at which scan line was mapped
		ES:DI -> start of scan line
	    80h unsuccessful
	    81h scan line out of range
	    82h unsupported scan line density
	    83h out of memory
SeeAlso: AX=CD04h"Image"
--------U-2FCD03-----------------------------
INT 2F - SWELL.EXE - ACTIVATE
	AX = CD03h
Return: AX = 0000h
SeeAlso: AX=CD02h"SWELL"
----------2FCD04-----------------------------
INT 2F - Intel Image Processing Interface - MOVE BITMAP TO SCANLINE
	AX = CD04h
	CX:BX -> structure (see #1740)
Return: AL = status (see #1739)
SeeAlso: AX=CD03h"Image"

(Table 1739)
Values for IPI function status:
 00h	successful
 80h	unsuccessful
 81h	scan line out of range
 82h	unsupported scan line density
 83h	out of memory
 84h	unrecognized source
 85h	initialization error

Format of structure:
Offset	Size	Description	(Table 1740)
 00h	WORD	image source (0 = conventional memory, 1 = expanded memory)
 02h	DWORD	pointer to image data
 06h	WORD	scan line on which to place
 08h	WORD	bit offset from start of scan line at which to place
 0Ah	WORD	density of bitmap data (300, 600, or 1200 dpi)
 0Ch	WORD	width in bits of data
 0Eh	WORD	source logical page number
 10h	WORD	source handle (only if source in expanded memory)
 12h	WORD	source offset (only if source in expanded memory)
--------U-2FCD04-----------------------------
INT 2F - SWELL.EXE - TURN OFF VERBOSE MODE
	AX = CD04h
Return: AX = 0000h
SeeAlso: AX=CD05h"SWELL"
----------2FCD05-----------------------------
INT 2F - Intel Image Processing Interface - PRINT PAGE
	AX = CD05h
Return: AL = status (00h,80h) (see #1739)
Note:	page image is retained, so multiple calls will print multiple copies of
	  the page
SeeAlso: AX=CD06h"Image"
--------U-2FCD05-----------------------------
INT 2F - SWELL.EXE - TURN ON VERBOSE MODE
	AX = CD05h
Return: AX = 0000h
SeeAlso: AX=CD04h"SWELL"
----------2FCD06-----------------------------
INT 2F - Intel Image Processing Interface - CLEAR PAGE
	AX = CD06h
Return: AL = status (00h,80h) (see #1739)
Note:	palette is reset to default
SeeAlso: AX=CD09h"Image"
--------U-2FCD06-----------------------------
INT 2F - SWELL.EXE - UNINSTALL
	AX = CD06h
Return: AX = status
	    0000h uninstalled
	    8002h programs still swapped, not uninstalled
----------2FCD07-----------------------------
INT 2F - Intel Image Processing Interface - reserved
	AX = CD07h
SeeAlso: AX=CD00h"Image"
--------U-2FCD07-----------------------------
INT 2F - SWELL.EXE - GET INFO
	AX = CD07h
	ES:BX -> 32-byte buffer for info (see #1741)
Return: AX = status
	    0000h successful
		ES:BX buffer filled
	    8001h buffer wrong size

Format of SWELL.EXE info buffer:
Offset	Size	Description	(Table 1741)
 00h	WORD	20h  (total size of buffer)
 02h	BYTE	suspend-once mode active if nonzero
 03h	BYTE	00h active, 01h suspended
 04h	BYTE	00h quiet, 01h verbose
 05h	BYTE	"Borland support" (allowing INT 21/AX=4B01h) on if nonzero
 06h 26 BYTEs	unused???
----------2FCD08-----------------------------
INT 2F - Intel Image Processing Interface - SCREEN IMAGE
	AX = CD08h
	CX:BX -> structure (see #1742)
Return: AL = status (00h,80h-85h) (see #1739)
SeeAlso: AX=CD05h"Image",AX=CD09h"Image"

Format of IPI screen image structure:
Offset	Size	Description	(Table 1742)
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
--------U-2FCD08-----------------------------
INT 2F - SWELL.EXE - UNUSED
	AX = CD08h
Return: AX = FFFFh (error)
----------2FCD09-----------------------------
INT 2F - Intel Image Processing Interface - LOAD SCREEN
	AX = CD09h
	CX:BX -> structure (see #1743)
Return: AL = status (00h,80h) (see #1739)
SeeAlso: AX=CD06h"Image Processing",AX=CD0Ah"Image Processing"

Format of IPI load screen structure:
Offset	Size	Description	(Table 1743)
 00h	BYTE	style
		44h ('D') diamond style
		4Ch ('L') line style
 01h	BYTE	reserved (00h)
 02h	WORD	frequency in lines per inch [sic]
		currently, coerced to nearest of 50, 60, 68, 70, 75, 85, or 100
 04h	WORD	screen angle in degrees (-360 to 360)
		currently coerced to nearest of -45, 0, 45, or 90
--------U-2FCD09-----------------------------
INT 2F - SWELL.EXE - TURN OFF "BORLAND SUPPORT"
	AX = CD09h
Return: AX = 0000h
SeeAlso: AX=CD0Ah"SWELL"
----------2FCD0A-----------------------------
INT 2F - Intel Image Processing Interface - LOAD PALETTE
	AX = CD0Ah
	CX:BX -> palette structure (see #1744)
Return: AL = status (00h,80h) (see #1739)
SeeAlso: AX=CD09h"Image Processing"

Format of IPI palette structure:
Offset	Size	Description	(Table 1744)
 00h	BYTE	bits per pixel for which palette is to be used (1,2,4,6, or 8)
 01h	2**N	palette translation values, one per possible pixel value
--------U-2FCD0A-----------------------------
INT 2F - SWELL.EXE - TURN ON "BORLAND SUPPORT"
	AX = CD0Ah
Return: AX = 0000h
SeeAlso: AX=CD09h"SWELL"
--------P-2FCD0F-----------------------------
INT 2F - LaserPort Interface - EXECUTE FUNCTION
	AX = CD0Fh
	BL = function
		01h enable
		02h disable
		03h ???
Return: AL = status
	    00h success
SeeAlso: AX=CD00h"LaserPort"
--------K-2FCF00-----------------------------
INT 2F - TEMPLEXX 1.0 - INSTALLATION CHECK
	AX = CF00h
Return: AL = FFh if installed
Program: TEMPLEXX is a popup keyboard template by Henson Scientific, Inc.
Note:	values in AL other than 00h cause an immediate return without modifying
	  any registers
--------G-2FD000-----------------------------
INT 2F C - MDEBUG display driver - GET DRIVER STATUS
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
Program: MDEBUG is a shareware memory-resident debugging tool by Bernd
	  Schemmer, including a memory monitor, an interpreter and a
	  disassembler
Range:	AH=C0h to AH=FFh, selected by switch or programmatically
Notes:	MDEBUG can use any two consecutive multiplex numbers between C0h and
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
--------M-2FD000-----------------------------
INT 2F - ZWmous - INSTALLATION CHECK
	AX = D000h
Return: AX = 5A57h ("ZW") if installed
	    BX = segment of resident code
Program: ZWmous is a shareware TSR by Zen Wu which permits the use of a mouse
	  with many non-mouse applications by entering the letter under the
	  mouse cursor on button presses
SeeAlso: INT 33/AX=0003h
--------N-2FD000-----------------------------
INT 2F - Lotus CD/Networker - INSTALLATION CHECK
	AX = D000h
Return: AL = FFh if CD/Networker TSR is loaded
	BX = 4D44h ("MD") signature
	CX = Windows mode word (from INT 2F/AX=1600h) at time of TSR load
	DX = bitmap identifying all loaded CD/Networker TSRs.
Notes:	INT 2F/AH=D0h is used by CD/Networker to communicate between a
	  resident redirector TSR and a transient program that controls the
	  TSR's CD-ROM drive emulation (volume attachments, caching, etc).
	At present there is only one CD/Networker TSR; the bitmap always = 4.
SeeAlso: AX=D002h"Lotus",INT 2F/AX=1500h"CD-ROM"
--------G-2FD001-----------------------------
INT 2F C - MDEBUG display driver - INITIALIZE DRIVER
	AX = D001h
Return: CF set on error
	AL = driver semaphor
	AH = buffer semaphor
Range:	AH=C0h to AH=FFh, selected by switch or programmatically
Notes:	MDEBUG calls this function after every successful call of the function
	  00h. The function should reset all internal data and the status of
	  the driver. If this function returns an error, MDEBUG will not call
	  the other functions in this popup session.
	MDEBUG can use any two consecutive multiplex numbers between C0h and
	  FFh; the default is D0h for the display driver and D1h for the
	  command driver
SeeAlso: AX=D000h
--------G-2FD002-----------------------------
INT 2F C - MDEBUG display driver - SAVE GRAPHIC DATA
	AX = D002h
Return: CF set on error
	CF clear if successful
	    display memory saved and display switched to one of the text modes
	      02h, 03h or 07h.
Note:	MDEBUG calls this function only once every popup session before
	  displaying its windows.
SeeAlso: AX=D000h,AX=D003h
--------N-2FD002BX4D44-----------------------
INT 2F - Multiplex - Lotus CD/Networker GET DATA AREA
	AX = D002h
	BX = 4D44h
	DX = bitmap identifying one loaded CD/Networker TSR
Return: ES:DI -> data area owned by TSR
Note:	the format of the data area changes with each minor revision, so it
	  cannot be counted on
SeeAlso: AX=D000h"Lotus"
--------G-2FD003-----------------------------
INT 2F C - MDEBUG display driver - RESTORE GRAPHIC DATA
	AX = D003h
Return: CF set on error
	CF clear if successful
	    display restored to the mode it was in before calling AX=D002h and
	      the display memory is restored
Note:	MDEBUG calls this function only once every popup session just before
	 it exits to normal DOS.
SeeAlso: AX=D000h,AX=D002h
--------G-2FD004-----------------------------
INT 2F - MDEBUG display driver - SHOW SAVED DATA
	AX = D004h
Return: CF set on error
	CF clear if successful
	    display switched to mode it was in before calling AX=D002h and the
	      display memory is restored
Note:	This function needn't save the display memory before changing it.
SeeAlso: AX=D000h,AX=D005h
--------G-2FD005-----------------------------
INT 2F - MDEBUG display driver - SWITCH BACK TO TEXT SCREEN
	AX = D005h
Return: CF set on error
	CF clear if successful
	    display restored to mode it was in before calling AX=D004h
Note:	This function needn't save or change the display memory
SeeAlso: AX=D000h,AX=D004h
--------G-2FD0-------------------------------
INT 2F - MDEBUG display driver - RESERVED FUNCTION NUMBERS
	AH = D0h
	AL = 06h-7Fh
Note:	these functions are reserved for future use
--------G-2FD0-------------------------------
INT 2F - MDEBUG display driver - USER DEFINED FUNCTION NUMBERS
	AH = D0h
	AL = 80h-FFh
Note:	these functions numbers are reserved for user defined features (e.g.
	  communication between the transient und resident parts of the driver)
--------G-2FD100-----------------------------
INT 2F C - MDEBUG command driver - GET STATUS
	AX = D100h
	BX = version of MDEBUG (BH = major, BL = minor)
	CX = command driver counter
---v1.60+---
	DS:SI -> MDEBUG identification table (see #1745)
	ES = segment of display memory used by MDEBUG
	DI = size of video mode used by MDEBUG
	    (high byte = lines, low byte = columns)
Return: DL = FFh
	BX = version number of the driver if it is less than the version in BX,
	      else unchanged
	CX incremented
Program: MDEBUG is a shareware memory-resident debugging tool by Bernd
	  Schemmer, including a memory monitor, an interpreter, and a
	  disassembler
Range:	AH=C0h to AH=FFh, selected by switch or programmatically
Notes:	called by MDEBUG at start of popup session; if the version number
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
Offset	Size	Description	(Table 1745)
 -2	WORD	entry offset
 00h	WORD	CS of MDEBUG
 02h	DWORD	old INT 08h vector
 06h	DWORD	old INT 09h vector
 0Ah	DWORD	address INT 16h routine used by MDEBUG
 0Eh	BYTE	length of version string
 0Fh  N BYTEs	version string
--------G-2FD101-----------------------------
INT 2F - MDEBUG command driver - INITIALIZE DRIVER
	AX = D101h
	CX = command driver counter
Return: DL = status
	    FFh if successful
		CX incremented
	    else error: all registers unchanged
Note:	this function must end with a  far call to the old INT 2F handler after
	  changing the registers
	this function must be reentrant
--------G-2FD102-----------------------------
INT 2F - MDEBUG command driver - EXECUTE INTERPRETER COMMAND
	AX = D102h
	BL = first character of the interpreter command
	BH = last character of the interpreter command (or blank)
	DS:SI -> parameter for the interpreter command as ASCIZ string
	DS:DI -> MDEBUG data structure (see #1747)
Return: AL = FFh
	CF set on error
	    AH = error number (see #1746)
	    DS:SI -> ASCIZ error message (max 30 characters) if AH=0Ch
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

(Table 1746)
Values for MDEBUG error number:
 01h	syntax error
 02h	first shell of the command.com is activ
 03h	Esc pressed
 04h	break pressed
 05h	DOS is busy
 06h	command ended
 07h	division by zero
 08h	invalid display driver
 09h	invalid command driver
 0Ah	error 8 and 9
 0Bh	unknown error
 0Ch	new error
 else	unknown error

Format of MDEBUG data structure:
Offset	Size	Description	(Table 1747)
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
--------G-2FD103-----------------------------
INT 2F - MDEBUG command driver - EXECUTE KEY IN THE MONITOR
	AX = D103h
	BX = key code (like result of an interrupt 16h call)
	CX = cursor position
	    0000h in the ASCII column of the monitor
	    0001h in one of the hex fields of the monitor
	DS:SI -> MDEBUG data structure (see #1747)
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
--------G-2FD104-----------------------------
INT 2F - MDEBUG command driver - EXECUTE KEY IN THE INTERPRETER
	AX = D104h
	DS:SI -> MDEBUG data structure (see #1747)
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
--------G-2FD1-------------------------------
INT 2F - MDEBUG command driver - RESERVED FUNCTIONS
	AH = D1h
	AL = 05h-0Ah
Note:	these functions are reserved for future use
--------G-2FD110-----------------------------
INT 2F - MDEBUG command driver - GET ADDRESS OF THE OLD INT 2F
	AX = D110h
Return: DL = FFh
	ES:BX -> next program in the chain for INT 2F
	CX = code segment of this driver
	DI = offset of driver identification table (see #1748) (v1.60+)
Notes:	only called by the transient part of the driver
	must be reentrant and the driver must not chain this function to the
	  old INT 2F

Format of the MDEBUG driver identification table:
Offset	Size	Description	(Table 1748)
 00h  26 BYTEs	 signature "Kommandotreiber fÅr MDEBUG"
					     ^- Note: ASCII 129,German U-umlaut
 27h  12 BYTEs	 name of driver, e.g. "MDHISDRV.COM"
		 each driver must have a unique name
--------G-2FD111-----------------------------
INT 2F - MDEBUG command driver - START DRIVER
	AX = D111h
Return: DL = FFh
Notes:	only called by the transient part of the driver to inform the resident
	  part that it is installed
	the function must be reentrant and the driver mustn't chain this
	  function to the old INT 2F
SeeAlso: AX=D101h,AX=D112h
--------G-2FD112-----------------------------
INT 2F - MDEBUG command driver - END DRIVER
	AX = D112h
Return: DL = FFh
Notes:	only called by the transient part of the driver to inform the resident
	  part that it will be released after this function
	the function must be reentrant and the driver mustn't chain this
	  function to the old INT 2F
SeeAlso: AX=D101h,AX=D111h
--------G-2FD1-------------------------------
INT 2F - MDEBUG command driver - RESERVED FUNCTIONS
	AH = D1h
	AL = 13h-7Fh
Note:	these functions are reserved for future use
--------G-2FD1-------------------------------
INT 2F - MDEBUG command driver - USER DEFINED FUNCTIONS
	AH = D1h
	AL = 80h-FFh
Note:	these functions are reserved for user defined features (e.g.
	  communication between the transient und resident parts of the driver)
--------U-2FD200-----------------------------
INT 2F - PCL-838.EXE - INSTALLATION CHECK
	AX = D200h
Return: AL = FFh if installed??? (documented as AX = return value)
Program: PCL-838 is a resident utility for controlling a stepmotor adapter
	  board by Advantec
SeeAlso: AX=D201h"PCL-838",AX=D202h"PCL-838"
--------Q-2FD200BX5144-----------------------
INT 2F - Quarterdeck RPCI - INSTALLATION CHECK
	AX = D200h
	BX = 5144h ("QD")
	CX = 4D45h ("ME")
	DX = 4D30h ("M0")
Return: AL = FFh installed
	if BX,CX,DX registers were as specified on entry:
	    BX = 4D45h ("ME")
	    CX = 4D44h ("MD")
	    DX = 5652h ("VR")
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
Notes:	the Quarterdeck RPCI (Resident Program Communication Interface) is
	  supported by QEMM v5.0+, QRAM, MANIFEST, VIDRAM, etc.
	for AL <> 0, if the BX/CX/DX values don't match the identifier of a
	  Quarterdeck product, it just chains to the previous INT 2F handler
SeeAlso: AX=D201h/BX=4849h,AX=D201h/BX=4D41h,AX=D201h/BX=4D45h
SeeAlso: AX=D201h/BX=5145h,AX=D201h/BX=5649h
--------U-2FD201-----------------------------
INT 2F - PCL-838.EXE - UNINSTALL
	AX = D201h
Return: AX = return value
SeeAlso: AX=D200h"PCL-838",AX=D202h"PCL-838"
--------m-2FD201BX4849-----------------------
INT 2F - Quarterdeck RPCI - GET QD HIMEM PRESENCE
	AX = D201h
	BX = 4849h ("HI")
	CX = 4D45h ("ME")
	DX = 4D51h ("MQ")
Return: BX = 4F4Bh ("OK")
	ES:DI -> HIMEM entry point
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
SeeAlso: AX=D200h,AX=D201h/BX=5145h
--------m-2FD201BX4849-----------------------
INT 2F - Quarterdeck RPCI - QEMM/QRAM v5.0+ - GET HIRAM MEMORY CHAIN
	AX = D201h
	BX = 4849h ("HI")
	CX = 5241h ("RA")
	DX = 4D30h ("M0")
Return: BX = 4F4Bh ("OK")
	CX = segment of start of HIRAM chain
	DX = reserved block owner (QEMM/QRAM code segment)
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
Note:	the HIRAM memory chain has the same format as the regular DOS 4.0
	  memory chain (see #0841 at INT 21/AH=52h), except that XMS Upper
	  Memory Blocks have the block header program name field set to
	  "UMB"; blocks whose "owner" field is set to the reserved segment
	  returned in DX are locked-out regions such as video memory and ROMs.
SeeAlso: AX=12FFh/BX=0006h,AX=D200h
--------G-2FD201BX4D41-----------------------
INT 2F U - Quarterdeck RPCI - MANIFEST v1.0+ - INSTALLATION CHECK
	AX = D201h
	BX = 4D41h ("MA")
	CX = 4E49h ("NI")
	DX = 4645h ("FE")
Return: BX = 5354h ("ST") if installed
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
SeeAlso: AX=D200h
--------E-2FD201BX4D45-----------------------
INT 2F U - Quarterdeck RPCI - DVDOS4GX.DVR - ???
	AX = D201h
	BX = 4D45h ("ME")
	CX = 5155h ("QU")
	DX = 5044h ("PD")
Return: AL = FFh
	BX = 4F4Bh ("OK")
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
Note:	this function is called by QEMM 6.03
	performs a variety of actions before setting return registers
SeeAlso: AX=D200h
--------m-2FD201BX5145-----------------------
INT 2F - Quarterdeck RPCI - QEMM v5.0+ - INSTALLATION CHECK
	AX = D201h
	BX = 5145h ("QE")
	CX = 4D4Dh ("MM")
	DX = 3432h ("42")
Return: BX = 4F4Bh ("OK")
	ES:DI -> QEMM API entry point (see INT 67/AH=3Fh)
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
Note:	this call is not available under QEMM v6.00 unless Windows3 support
	  has been disabled with the NW3 switch to QEMM386.SYS
SeeAlso: AX=D200h,AX=D201h/BX=4849h,INT 67/AH=3Fh
--------V-2FD201BX5649-----------------------
INT 2F u - Quarterdeck RPCI - VIDRAM v5.0+ - INSTALLATION CHECK
	AX = D201h
	BX = 5649h ("VI")
	CX = 4452h ("DR")
	DX = 414Dh ("AM")
Return: BX = 4F4Bh ("OK")
	ES:DI -> VIDRAM entry point (see #1749)
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
SeeAlso: AX=D200h

(Table 1749)
Call VIDRAM entry point with:
	AH = 00h get status
		Return: AL = VIDRAM state (see #1750)
			BL = extra RAM status (see #1751)
			BH = feature flags (see #1752)
			CL = current monitor (01h = mono, 80h = color)
			SI = current top of memory (paragraph)
			DI = segment of start of HiRAM chain
	AH = 01h setup
		AL = VIDRAM state (see #1750)
		BL = extra RAM status (see #1751)
		BH = feature flags (see #1752)
		CL = monitor (01h = monochrome, 80h = color)
		SI = new top of memory (paragraph)
		DI = segment of start of HiRAM chain
	AH = 02h get end address of VIDRAM code
		Return: ES:DI -> VIDRAM partial map context (see #1753,#1754)
Return: CF set on error
	CF clear if successful

(Table 1750)
Values for VIDRAM state:
 00h	off
 01h	no EGA graphics
 02h	no graphics at all

(Table 1751)
Values for VIDRAM extra RAM status:
 00h	VIDRAM does not use extra RAM
 01h	VIDRAM uses EMS as extra RAM
 02h	VIDRAM uses EGA as extra RAM
 
Bitfields for VIDRAM feature flags:
Bit(s)	Description	(Table 1752)
 0	override enabled
 1	mapped memory detected in A000h-B000h range
 2	top of memory not at 640K
 3	MDA detected
 4	high RAM exists in video area
 5	mapped memory detected in video area
 6-7	reserved???

Format of VIDRAM partial map context (EMS 3.2):
Offset	Size	Description	(Table 1753)
 00h	BYTE	EMS version ID (32h)
 01h	WORD	EMM handle for this entry
 03h	BYTE	number of frames
 04h	BYTE	first page frame
 05h	WORD	offset from ES to previously saved map

Format of VIDRAM partial map context (EMS 4.0):
Offset	Size	Description	(Table 1754)
 00h	BYTE	EMS version ID (40h)
 01h	WORD	mappable segment count
 03h  N WORD	mappable segments
	WORD	offset to previously saved map???
--------U-2FD202-----------------------------
INT 2F - PCL-838.EXE - EXECUTE PCL838 COMMANDS
	AX = D202h
	CX:BX -> parameter table
Return: AX = return value
SeeAlso: AX=D200h"PCL-838",AX=D201h"PCL-838"
--------R-2FD300BX4562-----------------------
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
--------R-2FD3CB-----------------------------
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
Index:	uninstall;LapLink Quick Connect
--------l-2FD44D-----------------------------
INT 2F - 4DOS.COM v2.1+ - API
	AX = D44Dh
	BH = function
	    00h installation check
		Return: AX = 44DDh
			BL = major version number
			BH = minor version number
			CX = PSP segment address for current invocation
			DL = 4DOS shell number (0 for the first (root) shell,
			      updated each time a new copy is loaded)
	    01h (internal, v2.1-3.03) terminate current copy of 4DOS
		Return: nothing
		(internal, v4.0) ???
		Return: AX = 44DDh
			ES:BX -> data area (see #1755)
	    02h ???
		DX = ???
	---v2.1-3.03 only---
	    03h EXEC program
		CX:DX -> EXEC record (see #1756)
	    FEh deallocate shell number (passed through to root shell)
		???
	    FFh allocate shell number (passed through to root shell)
Note:	bug in v3.00 will crash system if unrecognized value in BH
SeeAlso: AX=D44Eh,AX=E44Dh,INT 21/AX=4403h
Index:	installation check;4DOS|installation check;NDOS

Format of 4DOS v4.0 data area:
Offset	Size	Description	(Table 1755)
 00h  2 BYTEs	???
 06h	WORD	XMS handle for swapping
	???

Format of 4DOS EXEC record:
Offset	Size	Description	(Table 1756)
 00h	WORD	offset of ASCIZ program name in same segment as EXEC record
 02h	WORD	offset of DOS commandline in same segment as EXEC record
 04h	WORD	segment of environment for child process (see INT 21/AH=26h)
--------l-2FD44E-----------------------------
INT 2F C - 4DOS v3.0+ - AWAITING USER INPUT
	AX = D44Eh
---4DOS v3.01+---
	BX = condition
	    0000h 4DOS is ready to display prompt
	    0001h 4DOS has displayed the prompt, about to accept user input
Return: the handler must preserve SI, DI, BP, SP, DS, ES, and SS
Note:	v3.00 only makes the call corresponding to BX=0001h, does not set BX
SeeAlso: AX=D44Dh
--------K-2FD44FBX0000-----------------------
INT 2F - 4DOS v4.0+ - KSTACK.COM - INSTALLATION CHECK
	AX = D44Fh
	BX = 0000h
Return: AX = 44DDh if installed
Note:	this function is also supported by ANSIPLUS v3.01+ and K3PLUS v6.20+,
	  which emulate the 4DOS and NDOS keystack
SeeAlso: AX=D44Fh/BX=0001h,AX=E44Fh/BX=0000h
--------K-2FD44FBX0001-----------------------
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
	this function is also supported by ANSIPLUS v3.01+ and K3PLUS v6.20+,
	  which emulate the 4DOS and NDOS keystack
SeeAlso: AX=D44Fh/BX=0000h,INT 16/AH=00h,INT 21/AX=4403h
--------G-2FD600-----------------------------
INT 2F - HEART.COM - INSTALLATION CHECK
	AX = D600h
Return: AX = 0303h (two hearts) if installed
	    ES:DI -> buffer (see #1757)
Program: HEART.COM is a CPU lock-up/critical indicator utility by Mitch Davis.
Notes:	Once the host program has identified the address of the data area, it
	  can change this to indicate safe/critical, alternate colours, etc.
	The entries for the color table are in char/attrib form.  Every two
	  entries form a pair which is alternated between 68 times a minute.
	  The first half of the table is for color videos, the second mono.
	  Within each half, the first half is for the safe chars, and the
	  second for the critical chars.

Format of HEART.COM buffer:
Offset	Size	Description	(Table 1757)
 00h  8 WORDs	table of colors/attributes (see notes above)
 10h	BYTE	flags
		bit 0: program is in critical section, so flash double
		      exclamation mark
		bit 1: program is in safe code, so flash the heart character
 11h	WORD	position of heartbeat on screen, normally 009Eh (last column
		of second line)
--------T-2FD600-----------------------------
INT 2F U - VEDIT VSWAP - INSTALLATION CHECK
	AX = D600h
Return: AL = D6h if installed
Program: VSWAP is the resident portion of VEDIT's "swapper" capability; VEDIT
	  is a programmer's text editor by Greenview Data.
SeeAlso: AX=D601h,AX=D602h
--------T-2FD601-----------------------------
INT 2F U - VEDIT VSWAP - ???
	AX = D601h
	BL = subfunction number???
Return: BL = return code ???
	ES = resident portion's data??? segment
	DX = resident portion's code segment
SeeAlso: AX=D600h"VSWAP"
--------T-2FD602-----------------------------
INT 2F U - VEDIT VSWAP - EXEC PROGRAM WITH SWAP
	AX = D602h
	other registers set as for INT 21/AX=4B00h
Return: CF set on error
	    AL = error code
		82h = failure due to ???
	CF clear on success
SeeAlso: AX=D600h"VSWAP",INT 21/AH=4Bh"EXEC"
--------N-2FD701BX0000-----------------------
INT 2F - Banyan VINES v4+ - GET BANV INTERRUPT NUMBER
	AX = D701h
	BX = 0000h
Return: AX = 0000h if installed
	    BX = interrupt number (60h to 66h)
	   nonzero not present
Note:	if AX is nonzero, VINES 3.x or earlier may be installed, thus it is
	  necessary to examine the four bytes preceding the handlers for
	  INT 60 through INT 66 for the string "BANV"
SeeAlso: AX=D702h,AX=D703h,AX=D704h
--------N-2FD702-----------------------------
INT 2F U - Banyan VINES v4+ - PCPRINT interface
	AX = D702h
	BX = function
	???
Return: ???
SeeAlso: AX=D701h,AX=D703h,INT 61/AX=0005h"Banyan"
--------N-2FD703-----------------------------
INT 2F U - Banyan VINES v4+ - MAIL interface
	AX = D703h
	BX = function
	???
Return: ???
SeeAlso: AX=D702h,AX=D704h
--------N-2FD704-----------------------------
INT 2F U - Banyan VINES v4+ - Streettalk Directory Assistance interface
	AX = D704h
	BX = function
	???
Return: ???
SeeAlso: AX=D703h,INT 61/AX=0007h/BX=0002h"Banyan",INT 61/AX=0007h/BX=0008h
--------N-2FD800-----------------------------
INT 2F U - Novell NetWare Lite - CLIENT.EXE - INSTALLATION CHECK
	AX = D800h
Return: AL = FFh if installed
	    DX = version number (0100h for v1.0, 0101h for v1.1)
	    BX = data segment of resident copy
	    ES:DI -> private API entry point (see #1758)
	    SI = segment of resident code
SeeAlso: AX=7A00h,AX=D880h

(Table 1758)
Call CLIENT API entry point with:
	BX = function
	    0000h get ???
		Return: DX = CLIENT version??? (0101h for v1.1)
			ES:BX -> ??? data
	    0001h ???
	    0002h ???
	    0003h ???
	    0004h ???
	    0005h ???
		DL = ???
		???
		Return: ???
	    0006h get module name???
		ES:DI -> 16-byte buffer
		Return: CX = ???
			ES:DI filled with "NWLITE_CLIENT" 00h 00h 00h
	    0007h ???
		DX:CX = ???
		???
		Return: ???
	    0008h ???
	    0009h ???
		DL = ???
		ES:DI -> 16-byte buffer for ???
		Return: CF clear if successful
			    AX = 0000h
			    CX = 0000h
			    SI,DI destroyed
			CF set on error
			    AX = error code 4903h
	    000Ah ???
		AH = subfunction
		    00h get ???
		    01h clear/set ??? flag
			AL = new state (00h cleared, 01h set)
		    02h set ???
			DX = new value of ???
		Return: DX = old value of ???
	    000Bh ???
		AX = ???
		???
		Return: ???
	    000Ch ???
		AX = ???
		???
		Return: ???
	    000Dh ???
		AX = ???
		???
		Return: ???
	    000Eh get original INT 17
		Return: CF clear
			ES:BX -> original INT 17
	    000Fh ???
	    0010h ???
		AX = ???
		???
		Return: ???
	    0011h get ???
		Return: CF clear
			DL = ???
	    0012h get ???
		AL = index of ???
		ES:DI -> 10-byte buffer for ???
		Return: CF clear if successful
			    ES:DI buffer filled
			    AX,CX destroyed
			CF set on error
			    AX = error code (4907h if AL out of range)
	    0013h get ???
		Return: CF clear
			DH = ???
			DL = ???
	    0014h ???
		DL = ???
		???
		Return: CF clear if successful
			    ???
			CF set on error
			    AX = error code 8056h
	    0015h ???
		DX = ???
		Return: ES:DI -> ???
	    other
		Return: CF set
			AX = 0001h (invalid function)
--------N-2FD856-----------------------------
INT 2F U - Novell NetWare Lite v1.1 - SERVER - GET ???
	AX = D856h
Return: AX = 0001h if supported???
	BX = ??? (0004h for v1.1)
	CX = ??? (0F20h for v1.1)
	DS = segment of resident code
	ES = data segment of resident copy
Note:	this function is also supported by Personal NetWare SERVER, bundled
	  with Novell DOS 7
--------N-2FD880-----------------------------
INT 2F U - Novell NetWare Lite v1.0+ - SERVER - INSTALLATION CHECK
	AX = D880h
Return: AL = FFh if installed
	    DX = version number (0100h for v1.0, 0101h for v1.1)
	    BX = data segment of resident copy
	    CL = current state (00h SERVER is disabled, 01h SERVER is active)
	    ES:DI -> private API entry point (see #1759)
	    SI = ??? (offset of configuration info?)
Note:	this function is also supported by Personal NetWare SERVER, but DI is
	  not set; instead, ES:SI points at the API entry point
SeeAlso: AX=7A00h,AX=D800h,INT 2A/AX=D852h

(Table 1759)
Call SERVER API entry point with:
	BX = function
	    0000h ???
		???
		Return: ???
		Note: closes open files by calling INT 21/AH=3Eh
	    0001h get connection information
		DX = connection number (0001h-max connections)
		ES:DI -> 28-byte buffer for connection information
		Return: CF clear if successful
			    ES:DI buffer filled
			CF set on error
			    AX = FFFFh
	---Personal NetWare only---
	    0002h ???
	    0003h ???
	    0004h ???
	    0005h ???
	    0006h ???
	    0007h ???
	    other
		Return: CF set
			AX = 0001h (invalid function)
--------d-2FD8C0-----------------------------
INT 2F U - Novell NLCACHE,NWCACHE - INSTALLATION CHECK
	AX = D8C0h
Return: AL = FFh if installed
	    CL = cache variant (01h NLCACHEC, 02h NLCACHEX, 03h NLCACHEM)
	    DH = major version??? (01h for v1.1)
	    DL = minor version??? (01h for v1.1)
	    ES:DI -> private API entry point (see #1760)
Program: NLCACHE is a disk cache included with NetWare Lite
SeeAlso: AX=D800h,AX=D880h

(Table 1760)
Call NLCACHE/NWCACHE API entry point with:
	BX = function
	    0000h ???
		???
		Return: CF clear if successful
			    AX = 0000h
			    ???
			CF set on error
			    AX = error code
	    0001h (NWCACHE only) ???
		ES:DI -> buffer for ???
		Return: ???
	    other
		Return: CF set
			AX = 0001h (invalid function)
--------F-2FDA00-----------------------------
INT 2F - ZyXEL ZFAX - INSTALLATION CHECK
	AX = DA00h
Return: AH = enabled state (00h = enabled, 01h = disabled)
	AL = 5Ah installed
Program: ZFAX is the bundled FAX software which comes with the ZyXEL model
	  fax modems.
Note:	This function, and the other DAxxh functions, may apply only to version
	  1 of the software; see AX=DB00h for the version 2 installation check
SeeAlso: AX=CBDCh,AX=DA01h,AX=DA02h,AX=DA03h,AX=DB00h
--------F-2FDA01-----------------------------
INT 2F - ZyXEL ZFAX - UNINSTALL
	AX = DA01h
Return: AL = 00h Success
	     01h Failure
SeeAlso: AX=DA00h,AX=DB01h
--------F-2FDA02-----------------------------
INT 2F - ZyXEL ZFAX - DISABLE
	AX = DA02h
Return: AL = 00h
SeeAlso: AX=DA03h,AX=DB02h
--------F-2FDA03-----------------------------
INT 2F - ZyXEL ZFAX - ENABLE
	AX = DA03h
Return: AL = 00h
SeeAlso: AX=DA02h,AX=DB03h
--------G-2FDA55-----------------------------
INT 2F U - TRAP.COM - INSTALLATION CHECK
	AX = DA55h
	DL = interrupt number
	DH = ???
Return: if installed
	    AH = interrupt number
	    AL = ???
	    ES:BX -> ???
Program: TRAP is an interrupt call tracer by Patrick Phillipot/Udo Chrosziel
Note:	a separate copy of TRAP is loaded for each interrupt to be traced; thus
	  the interrupt number is part of the installation check
--------N-2FDAB2-----------------------------
INT 2F U - Beame&Whiteside BWSNMP - INSTALLATION CHECK
	AX = DAB2h
Return: AX = 00FFh if installed
	    BX:CX -> MIB table
Program: BWSNMP is part of the BW-NFS package
SeeAlso: INT 62/AH=00h"ETHDEV"
--------F-2FDB00-----------------------------
INT 2F - ZyXEL ZFAX v2+ - INSTALLATION CHECK
	AX = DB00h
Return:	AL = 5Bh if installed (v2.x)
	    ES:BX -> ???
	AX = 00DBh if installed (v3)
	    ES:BX -> ZFAX configuration table (see #1761)
Program: ZFAX is the bundled FAX software which comes with the ZyXEL model
	  fax modems.
SeeAlso: AX=CBDCh,AX=DA00h,AX=DB01h,AX=DB02h,AX=DB03h

Format of ZFAX Configuration Table:
Offset	Size	Description	(Table 1761)
 00h	WORD	version number (0300h for v3.0)
 02h	BYTE	reserved
 03h 70 BYTEs	ZFAX working path
 49h 128 BYTEs	path to external editor
 C9h 128 BYTEs	path to external terminal emulator
149h 128 BYTEs	path to Ring Shell
1C9h 128 BYTEs	path to DOS Shell
249h 128 BYTEs	path to Data Shell
2C9h 70 BYTEs	path to Chinese font
30Fh	BYTE	printer type (see #1762)
310h	BYTE	printer port (00h = LPT1, etc.)
311h	BYTE	type of graphics adapter
		(00h auto-detect, 01h VGA, 02h EGA, 03h CGA, 04h Hercules)
312h	BYTE	display type
		(00h auto-detect, 01h LCD, 02h color, 03h mono)
313h	BYTE	scan code for ZFAX hotkey
314h	BYTE	shift mask for ZFAX hotkey
315h	BYTE	tone/pulse dialing (00h tone, 01h pulse)
316h	BYTE	Caller ID (00h disabled, 01h enabled)
317h	BYTE	Distinctive Ring (00h disabled, 01h enabled)
318h	BYTE	normal ring answer type (see #1763)
319h	BYTE	Ring 1 answer type (see #1763)
31Ah	BYTE	Ring 2 answer type (see #1763)
31Bh	BYTE	Ring 3 answer type (see #1763)
31Ch	BYTE	COM port for modem
31Dh	BYTE	speaker volume (00h-07h)
31Eh	BYTE	modem dial timer, seconds
31Fh	WORD	user-defined COM port I/O address
321h	BYTE	user-defined COM port IRQ number
322h 81 BYTEs	dial prefix string
373h 79 BYTEs	dial postfix string
3C2h	BYTE	ring count until automatic answer
3C3h	BYTE	retry count on busy signal
3C4h	BYTE	redial delay in seconds
3C5h	WORD	system password
3C7h	BYTE	reserved
3C8h	BYTE	voice file compression format
		00h CELP at 9600bps
		01h two-bit ADPCM at 19200bps
		03h three-bit ADPCM at 28800bps
3C9h	BYTE	voice system: DTMF 0 action (see #1764)
3CAh	BYTE	voice system: DTMF 1 action
3CBh	BYTE	voice system: DTMF 2 action
3CCh	BYTE	voice system: DTMF 3 action
3CDh	BYTE	voice system: DTMF 4 action
3CEh	BYTE	voice system: DTMF 5 action
3CFh	BYTE	voice system: DTMF 6 action
3D0h	BYTE	voice system: DTMF 7 action
3D1h	BYTE	voice system: DTMF 8 action
3D2h	BYTE	voice system: DTMF 9 action (see #1764)
3D3h	WORD	reserved
3D5h 25 BYTEs	local FAX ID to display on page header
3EEh 20 BYTEs	local FAX ID sent to remote FAX
402h	BYTE	FAX page size
		00h A4 (210x297mm)
		01h B4 (250x353mm)
		02h A3 (297x420mm)
403h	BYTE	FAX resolution
		00h normal (3.85 pixels/mm)
		01h high (7.7 pixels/mm)
404h	BYTE	FAX coding scheme
		00h 1-D, modified Huffman coding
		01h 2-D, modified READ coding
405h	BYTE	left margin for text in millimeters
406h	BYTE	vertical insertion for text in mm (0-20)
407h	BYTE	horizontal insertion in mm (0-20)
408h	BYTE	maximum text lines per page
409h	BYTE	text type (00h ASCII, 01h WordStar-formatted)
40Ah	BYTE	PCX image resize (00h disabled, 01h enabled)
40Bh	BYTE	AutoPrint (00h disabled, 01h enabled)
40Ch	BYTE	cover page (00h disabled, 01h enabled)
40Dh 81 BYTEs	cover page logo filename
45Eh 65 BYTEs	cover page sender name
49Fh	BYTE	print capture (00h disabled, 01h enabled)
4A0h	BYTE	send immediately (00h disabled, 01h enabled)
4A1h	BYTE	print capture printer port
4A2h	BYTE	print capture timer in seconds
4A3h	BYTE	scan code for print capture hotkey
4A4h	BYTE	shift mask for print capture hotkey
4A5h	BYTE	DataShell type
		00h internal Zmodem, 01h Data Shell, 02h disable
4A6h	BYTE	video I/O type
		00h auto-detect, 01h use BIOS, 02h direct writes
4A7h	BYTE	call transfer digits
4A8h	WORD	voice recorder maximum time in seconds (0-999)

(Table 1762)
Values for ZFAX printer type:
 00h	EPSON FX (9 pins)
 01h	EPSON LQ (24 pins)
 02h	HP Laser Jet II, letter size
 03h	HP Laser Jet II, legal size
 04h	HP Laser Jet II, A4 size
 05h	HP Laser Jet III, letter size
 06h	HP Laser Jet III, legal size
 07h	HP Laser Jet III, A4 size

(Table 1763)
Values for Ring Answer Type:
 00h	voice system
 01h	FAX only
 02h	Data Shell
 03h	Ring Shell
 04h	DOS Shell
 05h	ignore

(Table 1764)
Values for DTMF action:
 00h	none
 01h	page operator
 02h	FaxBack
 03h	announcement
 04h	call transfer
 05h	receive FAX
 06h	receive data
 07h	voice mailbox
 08h	DOS Shell Out
 09h	Data Shell Out
--------U-2FDB00-----------------------------
INT 2F U - WINGO.COM - INSTALLATION CHECK
	AX = DB00h
Return: AX = FFFFh if installed
	CX = 5749h ('WI') if installed
	DX = 4E47h ('NG') if installed
	    ES = segment of resident code
Program: WINGO.COM is TSR for starting Windows programs from DOS 
	  prompt (together with companion Windows program 
	  WINSTART.EXE) written by Douglas Boling, contributing editor of
	  PC Magazine
Range:	AH=DBh to AH=FFh, selected by scanning for a free multiplex number
SeeAlso: AX=DB01h"WINGO",AX=DB02h"WINGO",AX=DB03h"WINGO",AX=DB04h"WINGO"
SeeAlso: AX=DB05h"WINGO",AX=DB06h"WINGO"
--------F-2FDB01-----------------------------
INT 2F - ZyXEL ZFAX v2+ - UNINSTALL
	AX = DB01h
Return: AX = status
	    0000h successful
	    0001h ZFAX is busy
	    0002h another program resident above ZFAX
Note:	this function unhooks the vectors taken by the ZFAX TSR if they have
	  not been hooked by other TSRs and releases the TSR's memory
	ZFAX v2.x crashes the contributor's machine when this function is
	  called
SeeAlso: AX=DA01h,AX=DB00h
--------U-2FDB01-----------------------------
INT 2F U - WINGO.COM - SET CALLBACK FUNCTION POINTER
	AX = DB01h
	CX:DX -> new callback function
Return: AX = 0000h
	CX:DX -> end of resident code (stack ???)
Desc:	the callback function is used for WINGO <-> WINSTART communication
SeeAlso: AX=DB00h"WINGO",AX=DB02h"WINGO",AX=DB03h"WINGO",AX=DB04h"WINGO"
SeeAlso: AX=DB05h"WINGO",AX=DB06h"WINGO"
--------F-2FDB02-----------------------------
INT 2F - ZyXEL ZFAX v2.x - DISABLE
	AX = DB02h
Return: AL = 00h
SeeAlso: AX=DA02h,AX=DB00h,AX=DB03h
--------U-2FDB02-----------------------------
INT 2F U - WINGO.COM - RESET CALLBACK FUNCTION POINTER
	AX = DB02h
Return: AX = 0000h
Desc:	the callback function is used for WINGO <-> WINSTART communication
SeeAlso: AX=DB00h"WINGO",AX=DB01h"WINGO",AX=DB03h"WINGO",AX=DB04h"WINGO"
SeeAlso: AX=DB05h"WINGO",AX=DB06h"WINGO"
--------F-2FDB03-----------------------------
INT 2F - ZyXEL ZFAX v2.x - ENABLE
	AX = DB03h
Return: AL = 00h
SeeAlso: AX=DA03h,AX=DB00h,AX=DB02h
--------U-2FDB03-----------------------------
INT 2F U - WINGO.COM - SET ??? FLAG
	AX = DB03h
Return: AX = 0000h
SeeAlso: AX=DB00h"WINGO",AX=DB04h"WINGO",AX=DB05h"WINGO",AX=DB06h"WINGO"
--------U-2FDB04-----------------------------
INT 2F U - WINGO.COM - RESET ??? FLAG
	AX = DB04h
Return: AX = 0000h
SeeAlso: AX=DB00h"WINGO",AX=DB03h"WINGO",AX=DB05h"WINGO",AX=DB06h"WINGO"
--------U-2FDB05-----------------------------
INT 2F U - WINGO.COM - GET ??? FLAG
	AX = DB05h
Return: AX = 0000h
	DX = unknown flag - 0 or 1
Program: WINGO.COM is TSR for starting Windows programs from DOS 
	  prompt (together with companion Windows program 
	  WINSTART.EXE) written by Douglas Boling, contributing editor of
	  PC Magazine
SeeAlso: AX=DB00h"WINGO",AX=DB03h"WINGO",AX=DB04h"WINGO"
--------U-2FDB06-----------------------------
INT 2F U - WINGO.COM - CALL CALLBACK FUNCTION
	AX = DB06h
Return: AX = return value of INT 2F/AX=1685h
Note:	uses Windows service INT 2F/AX=1685h (SWITCH VMs AND CALLBACK) to
	  call the callback function previously set by AX=DB01h
	used for WINGO <-> WINSTART communication
SeeAlso: AX=1685h, AX=DB00h"WINGO",AX=DB01h"WINGO",AX=DB02h"WINGO",
SeeAlso: AX=DB03h"WINGO",AX=DB04h"WINGO",AX=DB05h"WINGO"
--------F-2FDB10-----------------------------
INT 2F - ZyXEL ZFAX v3 - EXECUTE ZFAX MAIN MENU
	AX = DB10h
--------F-2FDB11-----------------------------
INT 2F - ZyXEL ZFAX v3 - SEND FAX
	AX = DB11h
	DS:SI -> filename including path
	DS:BX -> remote FAX number
Return:	AX = status (see #1765)
SeeAlso: AX=DB12h,AX=DB13h,AX=DB14h,AX=DB20h,AX=DB21h

(Table 1765)
Values for ZFAX status:
 00h	OK
 01h	invalid DOS function
 02h	file not found
 03h	path not found
 04h	no file handle available
 05h	access denied by DOS
 06h	invalid handle
 07h	disk full
 10h	printer error
 11h	no graphics font
 12h	no ZFAX font
 20h	DCD dropped while sending
 21h	not ZyXEL modem
 22h	busy
 23h	no response from COM port
 24h	no carrier
 25h	no dial tone
 26h	no answer
 27h	no response
 28h	failed to send FAX
 30h	user aborted
 40h	critical error on disk
 50h	parameter error
--------F-2FDB12-----------------------------
INT 2F - ZyXEL ZFAX v3 - PRINT FAX
	AX = DB12h
	DS:SI -> filename, including path
Return: AX = status
SeeAlso: AX=DB11h,AX=DB13h,AX=DB14h
--------F-2FDB13-----------------------------
INT 2F - ZyXEL ZFAX v3 - CONVERT FAX
	AX = DB13h
	DS:SI -> source filename, including path
	DS:BX -> destination filename, including path
	CX = destination file format
	    00h FAX, 01h PCX, 02h TIFF, 03h PRN
Return: AX = status
SeeAlso: AX=DB11h,AX=DB12h,AX=DB14h,AX=DB22h
--------F-2FDB14-----------------------------
INT 2F - ZyXEL ZFAX v3 - VIEW FAX
	AX = DB14h
	DS:SI -> source filename, including path
Return: AX = status
SeeAlso: AX=DB11h,AX=DB12h,AX=DB14h
--------F-2FDB20-----------------------------
INT 2F - ZyXEL ZFAX v3 - POLL FAX
	AX = DB20h
	DS:SI -> remote FAX number
Return: AX = status
SeeAlso: AX=DB11h,AX=DB21h
--------F-2FDB21-----------------------------
INT 2F - ZyXEL ZFAX v3 - SEND VOICE
	AX = DB21h
	DS:SI -> filename including path
	DS:BX -> remote phone number
Return:	AX = status
SeeAlso: AX=DB11h,AX=DB20h,AX=DB22h,AX=DB23h,AX=DB24h
--------F-2FDB22-----------------------------
INT 2F - ZyXEL ZFAX v3 - CONVERT VOICE FILE
	AX = DB22h
	DS:SI -> source filename, including path
	DS:BX -> destination filename, including path
	CX = destination format
	    00h two-bit ADPCM, 01h three-bit ADPCM, 02h VOC
Return:	AX = status
SeeAlso: AX=DB13h,AX=DB20h,AX=DB21h,AX=DB23h
--------F-2FDB23-----------------------------
INT 2F - ZyXEL ZFAX v3 - RECORD VOICE FILE
	AX = DB23h
	DS:SI -> destination filename, including path
	CX = recording channel (0 = telephone line, 1 = microphone/speaker)
	DX = voice file format
	    00h CELP, 01h two-bit ADPCM, 02h three-bit ADPCM
Return: AX = status
SeeAlso: AX=DB21h,AX=DB22h,AX=DB24h
--------F-2FDB24-----------------------------
INT 2F - ZyXEL ZFAX v3 - PLAY VOICE FILE
	AX = DB24h
	DS:SI -> name of voice file, including path
	CX = playback channel (0 = telephone line, 1 = microphone/speaker)
Return: AX = status
SeeAlso: AX=DB21h,AX=DB22h,AX=DB24h
--------F-2FDB25-----------------------------
INT 2F - ZyXEL ZFAX v3 - ANSWER MODEM WITH VOICE SYSTEM
	AX = DB25h
Return: AX = status
SeeAlso: AX=DB21h,AX=DB22h,AX=DB26h,AX=DB27h,AX=DB28h
--------F-2FDB26-----------------------------
INT 2F - ZyXEL ZFAX v3 - DIAL PHONE
	AX = DB26h
	DS:SI -> remote phone number
Return: AX = status
SeeAlso: AX=DB25h
--------F-2FDB27-----------------------------
INT 2F - ZyXEL ZFAX v3 - RECEIVE FAX - ANSWER MODEM AND SET TO FAX MODE
	AX = DB27h
Return: AX = status
SeeAlso: AX=DB25h,AX=DB28h
--------F-2FDB28-----------------------------
INT 2F - ZyXEL ZFAX v3 - RECEIVE FAX DATA - ANSWER MODEM IN MULTI-AUDIO MODE
	AX = DB28h
Return: AX = status
SeeAlso: AX=DB25h,AX=DB27h,AX=DB31h
--------F-2FDB31-----------------------------
INT 2F - ZyXEL ZFAX v3 - SEND DATA - DIAL NUMBER AND UPLOAD FILE WITH ZMODEM
	AX = DB31h
	DS:SI -> source file name, including path
	DS:BX -> remote data number
Return: AX = status
SeeAlso: AX=DB00h,AX=DB28h
--------F-2FDB40-----------------------------
INT 2F - ZyXEL ZFAX v3 - INTERNAL TERMINAL
	AX = DB40h
Return: AX = status
SeeAlso: AX=DB00h
--------K-2FDC00-----------------------------
INT 2F - GOLD.COM - INSTALLATION CHECK
	AX = DC00h
Return: AL = state
	    00h not installed
	    FFh installed
Program: GOLD is a TSR by Bob Eager which makes the NumLock key return the code
	  for F1; the purpose is to improve Kermit's VTxxx emulation
--------K-2FDC01-----------------------------
INT 2F - GOLD.COM - GET STATE
	AX = DC01h
Return: AL = status
	    00h off
	    01h on
SeeAlso: AX=DC00h,AX=DC02h
--------K-2FDC02-----------------------------
INT 2F - GOLD.COM - SET STATE
	AX = DC02h
	DL = new state
	    00h off
	    01h on
Return: AL = 00h (OK)
SeeAlso: AX=DC01h
--------t-2FDD-------------------------------
INT 2F - CappaCom programs - API
	AH = DDh
	AL = 00h general installation check
	    Return: AL = FFh if any CappaCom programs are resident
	AL = FEh get info
	    Return: ES:BX -> TSR info list (see #1766)
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
Note:	CappaCom was originally SoftCom but changed its name due to a trademark
	  conflict
Index:	installation check;SoftCom programs
Index:	installation check;CappaCom programs

Format of CappaCom TSR info list:
Offset	Size	Description	(Table 1766)
 00h  9 BYTEs	blank-padded ASCIZ program name
 09h	BYTE	program ID
 0Ah	WORD	program's PSP segment
 0Ch	WORD	program version (major in high byte)
 0Eh	DWORD	pointer to next item in info list or 0000h:0000h
 12h	BYTE	number of interrupts hooked
 13h  5 BYTEs	interrupt numbers hooked by program
 18h  8 BYTEs	reserved
----------2FDD-------------------------------
INT 2F - MIXFIX.EXE - API
	AH = DDh
	AL = function
	    00h installation check
		Return: AX = 00DDh if installed
			    BX = version (BH = major, BL = minor)
	    41h/61h get From: address
		Return: AX = 0001h
			ES:BX -> ASCIZ 4d address of mail sender ("1:2/3.4")
	    49h/69h get To: address
		Return: AX = 0001h
			ES:BX -> ASCIZ 4d address of recipient ("1:2/3.4")
	    4Ah/6Ah get subject of mail
		Return: AX = 0001h
			ES:BX -> ASCIZ subject of handled mail
	    4Dh/6Dh get mail name
		Return: AX = 0001h
			ES:BX -> ASCIZ full name of current mail file
	    4Eh/6Eh get From: field
		Return: AX = 0001h
			ES:BX -> ASCIZ From: field of mail (mail sender's name)
Program: MIXFIX by "KIV without Co" is a FidoNet mail robot which may execute
	  other programs for mail handling.  The called programs may use the
	  services described here to retrieve information about the mail being
	  handled.
Index: installation check;MIXFIX.EXE
--------d-2FDD--BX7844-----------------------
INT 2F - xDISK v3.32+ - INSTALLATION CHECK
	AH = DDh
	BX = 7844h ('xD')
	CX = 4953h ('IS')
	DX = 4B3Fh ('K?')
	AL = desired drive (01h-1Ah) or 00h to check for xDISK on any drive
	ES:DI -> 25-byte data buffer (see #1767)
Return: AX = DDFFh if installed (on specified drive if AL nonzero on entry)
	   BX = 87BBh
	   DX = B4C0h
	   ES:DI buffer filled
	CX,CF destroyed
SeeAlso: INT 21/AX=4404h"xDISK",INT 21/AX=4405h"xDISK"

Format of xDISK data buffer:
Offset	Size	Description	(Table 1767)
 00h	DWORD	pointer to ASCIZ driver signature "xDISK unit: X"
 04h	BYTE	flag: 01h if disk linked to DOS, 00h if unlinked
 05h	BYTE	flag: 01h if write protected, 00h if not
 06h	BYTE	flag: 01h if root directory full, 00h if not
 07h	BYTE	flag: 01h if free space uncompacted, 00h if compacted
 08h	BYTE	resizing state: 00h not resizable, 01h resized, 80h resizable
 09h	BYTE	flag: 01h inelastic resizable disk, 00h elastic
 0Ah  2 BYTEs	reserved
 0Ch	BYTE	flag: 01h collapsed disk, 00h not collapsed
 0Dh	BYTE	flag: 01h using all EMS, 00h some EMS free
 0Eh	BYTE	flag: 01h password enabled, 00h disabled
 0Fh	BYTE	flag: 01h password audio feedback, 00h no feedback
 10h	BYTE	flag: 01h password video feedback, 00h no feedback
 11h	BYTE	flag: 01h confirm changes, 00h no confirmation
 12h	BYTE	flag: 01h terse display, 00h verbose display
 13h	BYTE	flag: 01h click speaker on disk access, 00h no click
 14h	BYTE	flag: 01h flash icon on disk access, 00h no icon flash
 15h	BYTE	FAT entry size: 00h 12-bit, FFh 16-bit
 16h	WORD	count of open files in RAM disk
 18h	BYTE	unused
--------Q-2FDE00BX4456-----------------------
INT 2F - DESQview v2.26+ External Device Interface - INSTALLATION CHECK
	AX = DE00h
	BX = 4456h ("DV")
	CX = 5844h ("XD")
	DX = 4931h ("I1")
Return: AL = FFh if installed (even if other registers do not match)
	if BX,CX, and DX were as specified on entry,
	    BX = 4845h ("HE")
	    CX = 5245h ("RE")
	    DX = 4456h ("DV")
Range:	AH=C0h to AH=FFh, selected by scanning AH=DEh-FFh, then AH=C0h-DDh
Note:	the XDI handler should not issue any DOS or BIOS calls, nor should it
	  issue DESQview API calls other than those allowed from hardware ints
SeeAlso: AX=DE02h,INT 15/AX=5400h
--------Q-2FDE01-----------------------------
INT 2F - DESQview v2.26+ External Device Interface - DRIVER CUSTOM SUBFUNCTION
	AX = DE01h
	BX = driver ID
	other registers as needed by driver
Notes:	XDI drivers should pass this call through to previous handler if ID
	  does not match
	DESQview never calls this function
--------Q-2FDE01BX4450-----------------------
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
SeeAlso: INT 2F/AX=1687h,INT 31/AX=0000h
Index:	installation check;QDPMI
--------U-2FDE01BX5242-----------------------
INT 2F - DESQview v2.26+ XDI - CUSTOM SUBFUNCTION, Ralf Brown's XDI drivers
	AX = DE01h
	BX = 5242h ("RB")
	CX:DX = program identifier
		656F7000h ("eop",0) for DVeop
Return: AX = 5242h ("RB") if installed
	    ES:BX -> data or entry point (see #1768)
	    CX = version number (CH = major, CL = minor)

(Table 1768)
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
--------U-2FDE01BX7474-----------------------
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
Index:	installation check;DVTXDI
--------U-2FDE01BX7575-----------------------
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
				ES:DI -> process info array (see #1769,#1770)
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
Index:	installation check;DVSIXDI

Format of DVSIXDI v1.00 information for one process:
Offset	Size	Description	(Table 1769)
 00h	BYTE	flags
		bit 7: process slot is valid
 01h	WORD	offset into DESQVIEW.DVO of program's record if started from
		  Open Windows menu, else undefined
 03h	WORD	Switch Windows window number
 05h	WORD	segment of process handle
 07h	WORD	number of tasks owned by process
 09h	WORD	mapping context of process (see #0306 at INT 15/AX=1016h)
 0Bh	DWORD	hook for other programs

Format of DVSIXDI v1.10-v2.00 information for one process:
Offset	Size	Description	(Table 1770)
 00h	BYTE	process flags (see #1771)
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

Bitfields for DVSIXDI process flags:
Bit(s)	Description	(Table 1771)
 7	valid record
 6	(v2.00+) record is allocated; if bit 7 clear, process is "(starting)"
	  and only offsets 01h and 09h are valid
 5	(v2.00+) this app currently owns the CPU
 4	reserved (0)
 3	DESQview system task
 2	reserved (0)
 1	task has keyboard (currently unused)
 0	task swapped out (currently unused)
--------Q-2FDE01BXFFFE-----------------------
INT 2F U - DESQview v2.26+ XDI - DVXMS.DVR - ???
	AX = DE01h
	BX = FFFEh
	CX = 4D47h ("MG")
	DX = 0052h (0,"R")
Return: AL = FFh
	DX = 584Dh
--------Q-2FDE02-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - DV INITIALIZATION COMPLETE
	AX = DE02h
	BX = mapping context of DESQview
	DX = handle of DESQview system task
Note:	driver should pass this call to previous handler after doing its work
SeeAlso: AX=DE03h,AX=DE0Fh,INT 15/AX=5400h
--------Q-2FDE03-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - DV TERMINATION
	AX = DE03h
	BX = mapping context of DESQview
	DX = handle of DESQview system task
Notes:	driver should pass this call to previous handler before doing its work
	DESQview makes this call when it is exiting, but before unhooking any
	  interrupt vectors
SeeAlso: AX=DE02h,AX=DE0Fh,INT 15/AX=5407h
--------Q-2FDE04-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - ADD PROCESS
	AX = DE04h
	BX = mapping context of new process (see #0306 at INT 15/AX=1016h)
	DX = handle of process
Return: nothing
Notes:	XMS XDI handler (installed by default) allocates a 22-byte record
	  (see #1772) from "common" memory to control access to XMS memory
	all DOS, BIOS, and DV API calls are valid in handler
	driver should pass this call to previous handler after processing it
SeeAlso: AX=DE05h,AX=DE06h,INT 15/AX=5401h

Format of XMS XDI structure:
Offset	Size	Description	(Table 1772)
 00h	DWORD	pointer to 10-byte record???
 04h	DWORD	pointer to next XMS XDI structure
 08h	WORD	mapping context
 0Ah	BYTE	???
 0Bh  5 BYTEs	XMS entry point to return for INT 2F/AX=4310h
		(FAR jump to next field)
 10h  6 BYTEs	FAR handler for XMS driver entry point
		(consists of a FAR CALL followed by RETF)
--------Q-2FDE05-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - REMOVE PROCESS
	AX = DE05h
	BX = mapping context of process (see #0306 at INT 15/AX=1016h)
	DX = handle of last task in process
Return: nothing
Notes:	XMS XDI handler releases the structure allocated by AX=DE04h
	driver should pass this call to previous handler before processing it
	all DOS, BIOS, and DV API calls except those generating a task switch
	  are valid in handler
SeeAlso: AX=DE04h,AX=DE07h,INT 15/AX=5402h
--------Q-2FDE06-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - CREATE TASK
	AX = DE06h
	BX = mapping context of process containing task
	DX = handle of new task
Notes:	driver should pass this call to previous handler after processing it
	all DOS, BIOS, and DV API calls are valid in handler
--------Q-2FDE07-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - TERMINATE TASK
	AX = DE07h
	BX = mapping context of process containing task
	DX = handle of task
Notes:	driver should pass this call to previous handler before processing it
	all DOS, BIOS, and DV API calls except those generating a task switch
	  are valid in handler
SeeAlso: AX=DE04h,AX=DE06h,AX=DE10h
--------Q-2FDE08-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - SAVE STATE
	AX = DE08h
	BX = mapping context of task being switched from
	      (see #0306 at INT 15/AX=1016h)
	DX = handle of task being switched from
Notes:	invoked prior to task swap, interrupts, etc
	driver should pass this call to previous handler after processing it
SeeAlso: AX=DE09h,INT 15/AX=5403h,INT 15/AX=DE27h
--------Q-2FDE09-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - RESTORE STATE
	AX = DE09h
	BX = mapping context of task being switched to
	      (see #0306 at INT 15/AX=1016h)
	DX = handle of task being switched to
Notes:	state is restored except for interrupts
	driver should pass this call to previous handler before processing it
SeeAlso: AX=DE08h,INT 15/AX=5404h,INT 15/AX=DE27h
--------Q-2FDE0A-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - CHANGE KEYBOARD FOCUS
	AX = DE0Ah
	BX = mapping context of task receiving focus
	DX = handle of running task
Notes:	driver should pass this call to previous handler before processing it
	this call often occurs inside a keyboard interrupt
	DV 2.42 does not provide this call to XDI handlers running inside a
	  window; instead, it directly calls the INT 2F handler which was
	  active at the time DV started
SeeAlso: INT 15/AX=DE26h,INT 15/AX=DE2Fh
--------Q-2FDE0B-----------------------------
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
--------Q-2FDE0C-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - SWAP OUT PROCESS
	AX = DE0Ch
	BX = mapping context of task being swapped out
	      (see #0306 at INT 15/AX=1016h)
	DX = handle of DESQview system task
Note:	driver should pass this call to previous handler after processing it
--------Q-2FDE0D-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - SWAP IN PROCESS
	AX = DE0Dh
	BX = mapping context of process just swapped in
	      (see #0306 at INT 15/AX=1016h)
	DX = handle of DESQview system task
Note:	driver should pass this call to previous handler before processing it
--------Q-2FDE0E-----------------------------
INT 2F C - DESQview v2.26+ External Dev Interface - DVP START FAILED
	AX = DE0Eh
	BX = mapping context of DESQview system task
	DX = handle of DESQview system task
	SI = mapping context of failed process (same as for call to AX=DE0Bh)
Note:	driver should pass this call to previous handler after processing it
--------Q-2FDE0F-----------------------------
INT 2F C - DESQview v2.50+ External Dev Interface - INITIALIZE DV
	AX = DE0Fh
Note:	DESQview 2.50+ calls this function just before it completes its
	  initialization.  At the time of the call, DESQview has not yet
	  changed any interrupt vectors
SeeAlso: AX=DE02h
--------Q-2FDE10-----------------------------
INT 2F C - DESQview v2.50+ External Dev Interface - FREE TASK
	AX = DE10h
	BX = mapping context of process (see #0306 at INT 15/AX=1016h)
	DX = task handle of process
Note:	DESQview 2.50+ calls this function before it frees the task; it is
	  similar to AX=DE07h but allows the XDI handler to make calls which
	  cause context switches
SeeAlso: AX=DE06h,AX=DE07h
--------c-2FDF00-----------------------------
INT 2F - HyperWare programs - INSTALLATION CHECK
	AX = DF00h
	BX = product code (see #1773)
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
Range:	AH=C0h to AH=FFh, selected by scanning AH=DFh, then AH=C0h-FFh
SeeAlso: INT 13/AX=8EEDh
Index:	installation check;HyperDisk|installation check;HyperStb
Index:	installation check;HyperKey|installation check;HyperScreen
Index:	HyperDisk;installation check|HyperStb;installation check
Index:	HyperKey;installation check|HyperScreen;installation check

(Table 1773)
Values for HyperWare product code:
 4248h	('BH') HyperStb
 4448h	('DH') HyperDisk v4.20+
 4B48h	('KH') HyperKey
 5348h	('SH') HyperScreen
--------Q-2FDF00BX5445-----------------------
INT 2F U - Quarterdeck TELTSR.COM - INSTALLATION CHECK
	AX = DF00h
	BX = 5445h ('TE')
	CX = 4C54h ('LT')
	DX = 5352h ('SR')
Return: BX = 5454h ('TT') if installed
	CX = 494Eh ('IN') if installed
	DX = 5454h ('ST') if installed
Program: TELTSR is a Telnet TSR included with Quarterdeck's DESQview/X v2.00
	  which provides an INT 14h interface to the network
Range:	AH=DEh to AH=FFh and AH=C0h to AH=DDh, selected by scanning
SeeAlso: AX=DF01h"TELTSR",AX=DF02h"TELTSR",INT 14/AH=56h
--------N-2FDF01BX0000-----------------------
INT 2F U - MSG.COM - INSTALLATION CHECK
	AX = DF01h
	BX = 0000h
Return: AX = FDFFh if installed
	   BX = segment of resident code
Program: MSG.COM is a TSR for intercepting incoming Novell broadcast 
	  messages written by Gary Dobbins (Dobbins@Arizona.Edu)
--------c-2FDF01BX4448-----------------------
INT 2F - HyperDisk v4.50+ - GET CURRENT CACHE STATE
	AX = DF01h
	BX = 4448h ('DH')
Return: AX = 0000h if function supported
	    BX = number of cache buffers in use
	    CX = number of cache buffers which have been modified
	    DL = caching flags (see #1774)
Range:	AH=C0h to AH=FFh, selected by scanning AH=DFh, then AH=C0h-FFh
SeeAlso: AX=DF00h,AX=DF02h

Bitfields for HyperDisk caching flags:
Bit(s)	Description	(Table 1774)
 0	staged writes enabled for floppy disks
 1	staged writes enabled for hard disks
 2	writes verified on floppy disks
 3	writes verified on hard disks
 4	reserved (0)
 5	reserved (0)
 6	floppy caching enabled
 7	all caching functions enabled
--------Q-2FDF01-----------------------------
INT 2F U - Quarterdeck TELTSR.COM - CLOSE CONNECTION
	AX = DF01h
Return: nothing???
Note:	invokes the DESQview/X socket API (see INT 15/AX=DE2Eh) function 0006h
	  to close the socket corresponding to the file handle set with
	  AX=DF02h; NOP if no file handle was ever set
SeeAlso: AX=DF00h"TELTSR",AX=DF02h"TELTSR"
--------c-2FDF02BX4448-----------------------
INT 2F - HyperDisk v4.50+ - SET CACHE STATE
	AX = DF02h
	BX = 4448h ('DH')
	DL = new caching flags (see #1774)
Return: AX = 0000h if supported
	    BX = number of cache buffers in use
	    CX = number of cache buffers which have been modified
	    DL = previous caching flags (see #1774)
Program: HyperDisk is a shareware disk cache by HyperWare (Roger Cross)
Range:	AH=C0h to AH=FFh, selected by scanning AH=DFh, then AH=C0h-FFh
SeeAlso: AX=DF00h,AX=DF01h
--------Q-2FDF02-----------------------------
INT 2F U - Quarterdeck TELTSR.COM - OPEN CONNECTION
	AX = DF02h
	BX = file handle for connection's socket
Return: AX = status
	    0000h successful
	    FFFFh no more room in TELTSR's JFT
Program: TELTSR is a Telnet TSR included with Quarterdeck's DESQview/X v2.00
Notes:	the indicated file handle becomes owned by TELTSR, and is closed in
	  the caller's JFT
	multiple calls to this function will override the previous assignment
	  without closing the previous file; use AX=DF01h before further calls
SeeAlso: AX=DF00h"TELTSR",AX=DF01h"TELTSR"
--------U-2FE000-----------------------------
INT 2F - SETDRVER.COM v2.10+ - INSTALLATION CHECK
	AX = E000h
Return: AX = 4A52h ("JR") if present
Program: SETDRVER is a public domain TSR by Jacob Rieper which sets the
	  apparent DOS version analogously to MS-DOS SETVER
Note:	this installation check differs from the usual one of returning AL=FFh
SeeAlso: AX=E001h,INT 21/AH=52h
--------K-2FE000DX5354-----------------------
INT 2F - StuffIt v3.21+ - INSTALLATION CHECK
	AX = E000h
	DX = 5354h ("ST")
Return: AL = FFh if installed
	    BX = version (BH = major, BL = BCD minor)
	    DX = segment of resident code
Program: StuffIt is a freeware delayed keyboard stuffer by Terje Mathisen
--------U-2FE001-----------------------------
INT 2F - SETDRVER.COM v2.10+ - GET SETDRVER VERSION
	AX = E001h
Return: AH = major version
	AL = minor version
SeeAlso: AX=E000h
--------U-2FE002-----------------------------
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
--------U-2FE003-----------------------------
INT 2F - SETDRVER.COM v2.10+ - RESET INTERNAL VARIABLES
	AX = E003h
	BH = new major DOS version
	BL = new minor DOS version
	CH = new DOS version flag
	CL = new DOS revision number
	DH = new OEM number
SeeAlso: AX=E002h
--------U-2FE004-----------------------------
INT 2F - SETDRVER.COM v2.10+ - ENABLE TSR
	AX = E004h
Return: AL = FFh if successful
SeeAlso: AX=E000h,AX=E005h,AX=E006h
--------U-2FE005-----------------------------
INT 2F - SETDRVER.COM v2.10+ - DISABLE TSR
	AX = E005h
Return: AL = FFh if successful
SeeAlso: AX=E000h,AX=E004h,AX=E006h
--------U-2FE006-----------------------------
INT 2F - SETDRVER.COM v2.10+ - GET TSR STATUS
	AX = E006h
Return: AL = FFh if successful
	    BL = status
		01h resident and active
		02h resident and inactive
--------U-2FE007-----------------------------
INT 2F - SETDRVER.COM v2.10+ - GET TaskMAX STATUS AT INSTALLATION
	AX = E007h
Return: AL = FFh if successful
	    BL = status
		00h if TaskMAX not loaded before SETDRVER
		FFh if TaskMAX was loaded before SETDRVER
SeeAlso: AX=E003h
--------U-2FE0-------------------------------
INT 2F - SETDRVER.COM - RESERVED FOR FUTURE USE
	AH = E0h
	AL = 08h-10h
--------K-2FE100-----------------------------
INT 2F - Phantom2 v1.1+ - INSTALLATION CHECK
	AX = E100h
Return: AX = 0001h if installed
	    DS:SI -> ASCIZ hotkey name
	    DS:DI -> ASCIZ recording filename
Program: Phantom of the Keyboard II is a shareware keystroke recorder/replayer
	  by P2 Enterprises
SeeAlso: AX=E101h,AX=E102h,AX=E103h,AX=E300h
Index:	hotkeys;Phantom2
--------K-2FE101-----------------------------
INT 2F - Phantom2 v1.1+ - FUNCTION REQUEST
	AX = E101h
	BX = function mask (see #1775)
	CX = code for hotkey (as returned by INT 16/AH=00h) if BX bit 6 set
	DS:DX -> ASCIZ filespec if BX bit 7 set
SeeAlso: AX=E100h
Index:	hotkeys;Phantom2

Bitfields for Phantom2 function mask:
Bit(s)	Description	(Table 1775)
 0	record
 1	play
 2	QuickPlay
 3	loop
 4	mode display toggle
 5	sound toggle
 6	set hotkey
 7	set filespec
--------K-2FE102-----------------------------
INT 2F - Phantom2 v1.1+ - UNINSTALL
	AX = E102h
Return: AX = status
	    0001h removal successful
	    0002h not installed as TSR
	    FFFFh disabled but not removed
SeeAlso: AX=E100h
--------K-2FE103-----------------------------
INT 2F - Phantom2 v2.8 - SET ??? FLAG
	AX = E103h
Return: AX = 0001h
SeeAlso: AX=E100h
--------y-2FE200-----------------------------
INT 2F - SecureDevice - LOGIN TO DRIVE
	AX = E200h
	DL = drive number (0 = A:)
	DS:SI -> 104-byte key
Return: AL = status
	    00h unable to determine key's validity
	    01h key is valid
	    FFh key is invalid
Program: SecureDevice is a copylefted device driver by Max Loewenthal and
	  Arthur Helwig which turns one or more disk files into encrypted
	  logical drives
SeeAlso: AX=E201h,AX=E203h,AX=E209h
--------y-2FE201-----------------------------
INT 2F - SecureDevice - GET INFORMATION
	AX = E201h
	DX = driver index (0000h = first loaded)
Return: AL = number of volumes handled by driver
	DL = drive number of first volume (00h = A:)
SeeAlso: AX=E200h,AX=E203h,AX=E209h
--------y-2FE203-----------------------------
INT 2F - SecureDevice - DESTROY PASSWORD (LOGOUT FROM DRIVE)
	AX = E203h
	DL = drive number (00h = A:) or FFh for all drives
Return: nothing
SeeAlso: AX=E200h,AX=E209h
--------y-2FE209DX0000-----------------------
INT 2F - SecureDevice - INSTALLATION CHECK
	AX = E209h
	DX = 0000h
Return: AX = 1DEAh if installed
	    DX = number of drivers installed
--------K-2FE300-----------------------------
INT 2F - ANARKEY.COM - INSTALLATION CHECK
	AX = E300h
Return: AL = state
	    00h not installed
	    FEh if installed but suspended (v3.0+)
	    FFh installed
Program: ANARKEY.COM is a commandline recall program by Steven Calwas
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=E100h,AX=E301h,AX=E302h,AX=E303h,AX=E304h,AX=E305h,AX=E306h
SeeAlso: AX=E307h,INT 66"Newkey"
--------V-2FE300-----------------------------
INT 2F - Blank - INSTALLATION CHECK
	AX = E300h
Return: AL = FFh if installed
	    ES = resident code segment
Program: Blank is a shareware screen blanker by Yonah Schmeidler
Note:	AH=E3h is the default, which may be reconfigured by the installation
	  program in the registered version
SeeAlso: AH=93h,AX=C050h,INT 14/AX=AA01h
Index:	screen saver;Blank
--------K-2FE301-----------------------------
INT 2F U - ANARKEY.COM v2+ - GET ???
	AX = E301h
Return: DX:BX -> ??? (see #1776,#1777)
SeeAlso: AX=E300h

Format of returned data structure for ANARKEY v2.0:
Offset	Size	Description	(Table 1776)
 -7   7 BYTEs	signature ('ANARKEY')
 00h	WORD	??? (I see 0001h in v2.0)
 02h	WORD	??? (I see 0001h in v2.0)
 04h	WORD	??? (I see 0 in v2.0)
 06h	WORD	PSP segment of next program loaded

Format of returned data structure for ANARKEY v3+:
Offset	Size	Description	(Table 1777)
 -1	BYTE	multiplex number
 00h	WORD	??? (I see 0001h in v3.0-4.0)
 02h	WORD	??? (I see 0001h in v3.0-4.0)
 04h	BYTE	??? (I see 0 in v3.0-4.0)
 05h	WORD	PSP segment of next program loaded
--------K-2FE302-----------------------------
INT 2F U - ANARKEY.COM v3+ - ???
	AX = E302h
	BL = ???
Return: ???
SeeAlso: AX=E300h
--------K-2FE303-----------------------------
INT 2F U - ANARKEY.COM v3+ - ANARKMD API
	AX = E303h
	BL = function
	    01h toggle insert mode
	    02h display contents of history buffer
	    03h write history buffer to file
		ES:DX -> file name
	    04h clear history buffer
	    05h undefine all aliases
	    06h show aliases
	    07h list programs using Unix switchar
	    08h jump to bottom of history buffer
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
--------K-2FE304-----------------------------
INT 2F U - ANARKEY.COM v2+ - ???
	AX = E304h
	BL = ???
Return: ???
SeeAlso: AX=E300h
--------K-2FE305-----------------------------
INT 2F U - ANARKEY.COM v3+ - ENABLE/SUSPEND ANARKEY
	AX = E305h
	BL = new state
	    01h suspended
	    00h enabled
SeeAlso: AX=E300h
--------K-2FE306-----------------------------
INT 2F U - ANARKEY.COM v4.0 - GET ???
	AX = E306h
Return: AX = ???
SeeAlso: AX=E300h
--------K-2FE307-----------------------------
INT 2F U - ANARKEY.COM v4.0 - GET ???
	AX = E307h
Return: AX = ???
	BL = ???
SeeAlso: AX=E300h
--------l-2FE44D-----------------------------
INT 2F - NDOS - API
	AX = E44Dh
Program: NDOS is a version of 4DOS licensed to Symantec for inclusion in the
	  Norton Utilities
Note:	as NDOS is a licensed version of 4DOS v3.03, the API is identical to
	  that for 4DOS, except that AH=E4h instead of D4h and the installation
	  check returns AX=44EEh instead of AX=44DDh
SeeAlso: AX=D44Dh,AX=E44Eh
--------l-2FE44E-----------------------------
INT 2F C - NDOS - AWAITING USER INPUT
	AX = E44Eh
	BX = condition
	    0000h NDOS is ready to display prompt
	    0001h NDOS has displayed the prompt, about to accept user input
Return: handler must preserve SI, DI, BP, SP, DS, ES, and SS
SeeAlso: AX=E44Dh
--------K-2FE44FBX0000-----------------------
INT 2F - NDOS v4.0+ - KSTACK.COM - INSTALLATION CHECK
	AX = E44Fh
	BX = 0000h
Return: AX = 44EEh if installed
Program: NDOS is a version of 4DOS licensed to Symantec for inclusion in the
	  Norton Utilities
Note:	this function is also supported by ANSIPLUS v3.01+ and K3PLUS v6.20+,
	  which emulate the 4DOS and NDOS keystack
SeeAlso: AX=D44Fh/BX=0000h,AX=E44Fh/BX=0001h
--------K-2FE44FBX0001-----------------------
INT 2F - NDOS v4.0+ - KSTACK.COM - PLACE KEYSTROKES INTO KEYSTACK
	AX = E44Fh
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
	this function is also supported by ANSIPLUS v3.01+ and K3PLUS v6.20+,
	  which emulate the 4DOS and NDOS keystack
SeeAlso: AX=E44Fh/BX=0000h,INT 16/AH=00h,INT 21/AX=4403h
--------E-2FED00-----------------------------
INT 2F - Phar Lap DOS EXTENDERS - INSTALLATION CHECK
	AX = ED00h
	BL = DOS extender ID (see #1778)
Return: AL = status
	    00h not installed
	    FFh installed
		SI = 5048h ("PH")
		DI = 4152h ("AR")
		CH = major version number
		CL = minor version number
		DX = flags
		    bit 0: running under DPMI
		    bit 1: running under Phar Lap VMM
		if running under DPMI:
		    BX = DPMI version (BH = major, BL = minor)
SeeAlso: AH=A1h,AX=F100h,AX=FBA1h

(Table 1778)
Values for Phar Lap DOS extender ID:
 01h	286dosx v1.3+ (Software Development Kit)
 02h	286dosx v1.3+ (Run-Time Kit)
 03h	386dosx v4.0+ (SDK)
 04h	386dosx v4.0+ (RTK)
--------E-2FED03-----------------------------
INT 2F R - Phar Lap 386/DOS-Extender v4.1 - GET EXTENDER ENTRY POINT
	AX = ED03h
	CX = real-mode code segment
	DX = real-mode data segment
Return: CF clear if successful
	    CX = protected-mode code segment selector
	    DX = protected-mode data segment selector
	    ES:DI -> real-mode entry point for calling protected-mode functions
		      (see INT 21/AX=250Dh)
	CF set on error
	    AX = error code
		0008h unable to allocate LDT descriptors
--------E-2FED10BL05-------------------------
INT 2F - Pharlap DOS Extender - ???
	AX = ED10h
	BL = 05h
	ES:SI -> ??? structure
Return:	AX = ???
	SI = ???
	DI = ???
SeeAlso: AX=ED00h,AX=ED11h
--------E-2FED11BL05-------------------------
INT 2F - Pharlap DOS Extender - FATAL EXIT TO REAL MODE ???
	AX = ED11h
	BL = 05h
	CX = ???
	DX = ???
	ES:SI -> ??? structure
	SS:SP = new stack ???
Return: ???
Note:	called immediately prior to terminating program with INT 21/AX=4CFFh
SeeAlso: AX=ED00h,AX=ED10h
--------K-2FED58-----------------------------
INT 2F U - K5.COM - INSTALLATION CHECK
	AX = ED58h
Return: AX = 000Dh if installed
	    BX = 9999h if driver active
	    ???
Program: K5 is an extended keyboard driver by Martin Gerdes, based on his K3
SeeAlso: INT 16/AX=AF20h
--------E-2FED80-----------------------------
INT 2F - Phar Lap 286|DOS Extender Lite v2.5 - ???
	AX = ED80h
	BL = DOS extender ID (see #1778)
	SI = 5048h ("PH")
	DI = 4152h ("AR")
	???
Return: ???
--------y-2FEE00-----------------------------
INT 2F - GRIDLOC.EXE - INSTALLATION CHECK
	AX = EE00h
Return: AL = FFh if installed
Program: GRIDLOC is a PC security program by Intelligent Security Systems, Inc.
SeeAlso: INT 21/AH=40h"NB.SYS"
--------U-2FEE00-----------------------------
INT 2F - XVIEW - INSTALLATION CHECK
	AX = EE00h
Return: AX = 00FFh if installed
Program: XVIEW is a hypertext viewer by Flambeaux Software, Inc.
--------N-2FEE00-----------------------------
INT 2F - WEB v4.02 - INSTALLATION CHECK
	AX = EE00h
Return: AL = status
	    00h not installed
	    FFh installed
Program: WEB is an IPX-based peer-to-peer network by Webcorp.
SeeAlso: AH=EEh"WEB",AX=EEF0h
--------U-2FEE01-----------------------------
INT 2F - XVIEW - POP UP GIVING TOPIC SEARCH KEYWORD
	AX = EE01h
	DS:DX -> ASCIZ string containing case-insensitive keyword to look up
Return: AX = status (see #1779)
Note:	the specified keyword should be a hyperlink in the _IndexPage of some
	  database; the current database is searched first
SeeAlso: AX=EE00h"XVIEW",AX=EE02h,AX=EE03h,AX=EE04h,AX=EE06h

(Table 1779)
Values for XVIEW function status:
 0000h	successful
 00F1h	unknown subfunction
 00F2h	unable to pop up
--------U-2FEE02-----------------------------
INT 2F - XVIEW - POP UP GIVING A PAGE NUMBER
	AX = EE02h
	DX = physical page number or anchor page number (see #1780)
Return: AX = status (see #1779)
Note:	physical page numbers are assigned by the hypertext compiler, and
	  will change if a page is inserted in the middle
SeeAlso: AX=EE00h"XVIEW",AX=EE01h,AX=EE05h,AX=EE06h

(Table 1780)
Values for XVIEW anchor page number:
 FFEAh	_Credits
 FFECh	_SearchTopics
 FFEDh	_SearchText
 FFF0h	_ManualList
 FFF5h	_HelpOnHelp
 FFF8h	_HomePage
 FFF9h	_IndexPage
--------U-2FEE03-----------------------------
INT 2F - XVIEW - POP UP GIVING FILENAME AND SEARCH TOPIC OR PAGE NUMBER
	AX = EE03h
	DS:DX -> data packet (see #1781)
Return: AX = status (see #1779)
SeeAlso: AX=EE00h"XVIEW",AX=EE01h,AX=EE02h,AX=EE06h

Format of XVIEW data packet:
Offset	Size	Description	(Table 1781)
 00h	DWORD	-> ASCIZ database filespec (0000h:0000h for current database)
 04h	DWORD	-> ASCIZ text to look up or 0000h:0000h
 08h	WORD	page number (0000h if keyword used)
 0Ah  6 BYTEs	reserved
--------U-2FEE04-----------------------------
INT 2F - XVIEW - POP UP AND READ SCREEN FOR SEARCH TOPIC KEYWORD
	AX = EE04h
Return: AX = status (see #1779)
Note:	equivalent to the action taken when the user presses the Alt-L hotkey
SeeAlso: AX=EE00h"XVIEW",AX=EE01h,AX=EE03h,AX=EE06h
--------U-2FEE05-----------------------------
INT 2F - XVIEW - POP UP TO MOST-RECENTLY VIEWED PAGE
	AX = EE05h
Return: AX = status (see #1779)
Note:	equivalent to the action taken when the user presses the Alt-H hotkey
SeeAlso: AX=EE00h"XVIEW",AX=EE02h,AX=EE06h
--------U-2FEE06-----------------------------
INT 2F - XVIEW - WAIT FOR POP-DOWN AND GET EXIT CODE
	AX = EE06h
Return: AX = status (see also AX=EE01h)
	    0001h specified filename is not an xText database
	    0002h no databases found
	    0003h bad data in file
	    0004h memory shortage
	    0005h unable to open the requested file
	    0007h invalid page number for file
Note:	although this call is not required, the exit code can alert the
	  caller to problems; if the call is not made, the program should
	  enforce a delay of about 1/2 second to allow the viewer to pop up,
	  and should not get keyboard input or attempt disk accesses during
	  the delay
SeeAlso: AX=EE00h"XVIEW",AX=EE01h,AX=EE02h,AX=EE03h,AX=EE04h,AX=EE05h
--------N-2FEE-------------------------------
INT 2F - WEB v4.02 - WEB MODULE INSTALLATION CHECK
	AH = EEh
	AL = module ID (see #1782)
Return: AX = 0000h if installed
	    ES:DI -> far entry point for module-specific API calls
		  (see #1783,#1784,#1785,#1786,#1787)
Program: WEB is an IPX-based peer-to-peer network by Webcorp.
SeeAlso: AX=EE00h"WEB"

(Table 1782)
Values for WEB module ID:
 10h	server module (SERVER.EXE)
 20h	client module (CLIENT.EXE)
 30h	mail module (MAIL.EXE)
 40h	spooler (PCSPOOL.EXE)
 50h	kernel module (KERNEL.EXE)
 60h	SAP module (KERNEL.EXE)
 70h	resident station manager (SM.EXE)
 90h	router module (ROUTER.EXE)

(Table 1783)
Call server module entry point with:
	BX = function
	    0000h remove server module
		Return: AX = status (0000h if successful, else WEB error code)
	    0001h create SYSINFO file
		Note:	the SYSINFO file is used by the station manager when
			  displaying info for a particular station
	    0002h get server object table
		Return: CX = number of server objects
			ES:DI -> server object table
		Note:	server objects include drives and devices that the
			  server module controls
	    0003h get server variables
		Return: ES:DI -> server variables

(Table 1784)
Call client module entry point with:
	BX = function
	    0000h remove client module
		Return: AX = status (0000h if successful, else WEB error code)
	    0001h decrement client-only flag
	    0002h increment client-only flag
	    0005h set device capture
		Note:	decrements DeviceOutput flag, telling the spooler that
			  it may trap device output again
	    0006h clear device capture
		Note:	increments DeviceOutput flag, telling the spooler that
			  it should not trap device output (this is used
			  internally by the spooler to prevent it from trapping
			  its own output)
	    0007h get client debug pointer
		Return: ES:DI -> client debug data structure (see #1788)
	    0008h get root drive
		Return: AL = WEB startup drive
	    0009h get maximum possible drive/device redirections
		Return: AL = maximum drive redirections
			CH = maximum LPTx redirections
			CL = maximum COMx redirections
	    000Ah suspend client
		Return: AX = previous value of Suspend flag
	    000Bh resume client
		Return: AX = previous value of Suspend flag
	    000Ch get instance data
		CX = maximum number of structures in array
		ES:DI -> buffer for array of WIN_INSTANCE_DATA structures
			  (see #1789)
		Return: CX = number of structures actually returned
		Note:	used internally by WEB4WIN

(Table 1785)
Call mail module entry point with:
	BX = function
	    0000h remove mail module
		Return: AX = status (0000h successful, else WEB error code)
	    0001h set mail poll
		Note:	schedules the WEB mail module
	    0002h set mail notify
		Note:	sets the Notify flag, which determines whether the
			  user will be notified when mail is received
	    0003h clear mail notify
		Note:	clears the Notify flag, which determines whether the
			  user will be notified when mail is received
	    0004h check whether new mail has arrived
		Return: AL = new mail status
			    00h no new mail since last call
			    else new mail has arrived
		Note:	also clears the new-mail flag after retrieving it
	    0005h send notify
		ES:DI -> name of WEB user to be notified
	    0006h get post office
		Return: ES:DI -> full network path of Post Office subdirectory

(Table 1786)
Call spooler entry point with:
	BX = function
	    0000h remove PCSpool module
		Return: AX = status (0000h successful, else WEB error code)
	    0001h set spooler poll
		Note:	schedules the WEB spooler
	    0002h check spooler changed
		Return:	AX = 0000h
		Note:	this call is a NOP in current versions of WEB

(Table 1787)
Call kernel entry point with:
	BX = function
	    0000h remove kernel module
		Return: AX = status (0000h successful, else WEB error code)
	    0001h set kernel ^S filter
		DL = new state (00h don't filter ^S, nonzero do filter)
	    0002h get kernel data area
		Return: ES:DI -> kernel data area
	    0003h display dialog box
		CL = dialog box type
		    00h password
		    01h E-Note received notification
		    02h Novell login
		    03h general notification
		DL = number of rows to display
		ES:SI -> array of far pointers to rows to be displayed
		ES:DI -> Pascal-style input buffer
		Return: AX = status (0000h successful, else error code)
	    0004h kernel service events
	    0005h get kernel's in-critical-section flag
		Return: ES:DI -> kernel InCriticalSection flag
	    0006h schedule DOS event
		AL = directive
		    00h do not ignore WEB ExtraBusy flag
		    01h ignore ExtraBusy flag
		    02h (WEB4WIN) check that current Windows VM is foregrnd VM
		ES:SI -> WEB AES Event Control Block (ECB) (see #1790)
		Notes:	the WEB Asynchronous Event Scheduler is similar to the
			  one used by IPX; this call schedules a special ECB
			  to be executed at a later time.  Unlike IPX ECBs,
			  the timeout must be set explicitly by the caller
			this function also calls function 0004h
	    0007h check busy
		AL = directive
		    00h do not ignore WEB ExtraBusy flag
		    01h ignore ExtraBusy flag
		    02h (WEB4WIN) check that current Windows VM is foregrnd VM
		Return: AX = status (0000h not busy, else busy)
	    0008h set keyboard intercept
		Note:	currently a NOP which returns immediately
	    0009h get keyboard intercept
		Note:	currently a NOP which returns immediately
	    000Ah get dialog flags
		Return: ES:DI -> kernel dialog flags (see #1791)
	    000Bh get network path
		Return: ES:DI -> fully-qualified network path of file where
				the screen is stored on Dialog calls
	    000Ch kernel alternate dialog
		CL = dialog box type
		    00h password
		    01h E-Note received notification
		    02h Novell login
		    03h general notification
		DL = number of rows to display
		ES:SI -> array of far pointers to rows to be displayed
		ES:DI -> Pascal-style input buffer
		Return: AX = status (0000h successful, else error code)
		Note:	this function is identical to function 0003h except
			  that it does not notify WEB4WIN of the impending
			  dialog request
	    000Dh get machine/operating system type
		Return: AX = machine/operating system type
			    01h IBM PC, MS-DOS
			    02h IBM PC, DOSV (Japanese)
			    03h NEC PC-9800, JDOS (Japanese)
			    04h IBM PC, Korean DBC DOS

Format of client debug data structure:
Offset	Size	Description	(Table 1788)
 00h	WORD	total files
 02h	WORD	files free
 04h	WORD	no files
 06h	WORD	minimum files
 08h	WORD	total FCBs
 0Ah	WORD	total safe FCBs
 0Ch	WORD	FCBs in use
 0Eh	WORD	wrong FCB
 10h	WORD	compressed
 12h	WORD	retransmits

Format of WIN_INSTANCE_DATA structure:
Offset	Size	Description	(Table 1789)
 00h	DWORD	real-mode pointer to data to be instanced
 04h	WORD	size of data to be instanced

Format of WEB AES Event Control Block:
Offset	Size	Description	(Table 1790)
 00h	DWORD	link address
 04h	WORD	ESR address
 08h	BYTE	InUse flag
 09h	BYTE	completion code
 0Ah  3 BYTEs	reserved
 0Dh	WORD	timeout
 0Fh	BYTE	IgnoreExtra flag
 10h	WORD	PSP
 12h	DWORD	DTA
 16h	WORD	AX value for DOS critical information
 18h	WORD	BX value for DOS critical information
 1Ah	WORD	CX value for DOS critical information
 1Ch	WORD	DX value for DOS critical information

(Table 1791)
Values for kernel dialog flags:
 01h	dialog will timeout
 02h	display stars instead of entered keystrokes
--------N-2FEEF0-----------------------------
INT 2F - WEB v4.02 - WEB GENERAL NOTIFICATION
	AX = EEF0h
	BX = notification function ID (see #1792)
Return: varies by notification function
Program: WEB is an IPX-based peer-to-peer network by Webcorp.
Note:	the notification functions are used internally by WEB modules to notify
	  other modules and external programs of actions or event, and should
	  never be called by an application
SeeAlso: AX=EE00h"WEB"

(Table 1792)
Values for WEB Notification Function ID:
 00h	node added
 01h	node deleted
 02h	dial attempt
 03h	dial failed
 04h	file close
 05h	close connection
 07h	check Windows mode
 20h	link up
 21h	link down
--------K-2FF000-----------------------------
INT 2F U - 4MAP - INSTALLATION CHECK
	AX = F000h
Return: AX = 00FFh
Program: 4MAP is a keybinding program for 4DOS (see AX=D44Dh) by Ho-Ping Tseng
Note:	returns AX=00FFh for any value of AL not listed here
SeeAlso: AX=D44Dh,AX=F001h,AX=F002h
--------K-2FF001-----------------------------
INT 2F U - 4MAP - GET KEY MAPPINGS
	AX = F001h
Return: ES:BX -> key mappings
SeeAlso: AX=F000h
--------K-2FF002-----------------------------
INT 2F U - 4MAP - INSERT CHARACTER INTO ???
	AX = F002h
	BL = character to insert
Return: AX = status
	    0000h successful
	    0001h buffer full
SeeAlso: AX=F000h,AX=F003h
--------K-2FF003-----------------------------
INT 2F U - 4MAP - INSERT CHARACTER INTO ???
	AX = F003h
	BL = character to insert
Return: AX = status
	    0000h successful
	    0001h buffer full
Program: 4MAP is a keybinding program for 4DOS (see AX=D44Dh) by Ho-Ping Tseng
SeeAlso: AX=F000h,AX=F002h
--------m-2FF1-------------------------------
INT 2F U - MIN-MEM v2.11 - INSTALLATION CHECK
	AH = F1h
	AL <> F1h
Return: AL = F1h if installed
Program: MIN-MEM is a shareware TSR manager by Biologic which permits up to 24
	  popup TSRs to be loaded but swapped out to disk, EMS, or XMS.	 One
	  TSR at a time is brought back into memory at the user's request.
--------E-2FF100-----------------------------
INT 2F - DOS EXTENDER INSTALLATION CHECK
	AX = F100h
Return: AL = FFh if DOS extender present
	    SI = 444Fh ("DO")
	    DI = 5358h ("SX")
Note:	supported or soon to be supported by Phar Lap, Rational, Ergo, and IGC
SeeAlso: AH=A1h,AX=ED00h,AX=FBA1h/BX=0081h,INT 15/AX=BF02h
--------W-2FF200-----------------------------
INT 2F - WINX - INSTALLATION CHECK
	AX = F200h
Return: AX = 00FFh if installed
Program: WINX is a DOS/Windows utilities by Al Williams which can be used to
	  launch Windows applications from a DOS Box; it was published in
	  "DOS and Windows Protected Mode-Programming with DOS Extenders"
	  (Addison-Wesley) and should not be confused with the Windows driver
	  of the same name which is part of the DESQview/X package
--------W-2FF201-----------------------------
INT 2F - WINX - RETURN ADDRESS OF SERVER BUFFER
	AX = F201h
Return: AX = status
	    FFFFh if WINX is busy processing a different request
	    0000h if successful
		BX:CX = address of server buffer (see #1793)

Format of WINX server buffer:
Offset	Size	Description	(Table 1793)
 00h	BYTE	command/status
		00h buffer available
		01h buffer contains result
		02h change directory
		03h execute program
		FFh terminate windows portion of WINX
 01h  ? BYTEs	command (03h) or directory (02h)
  or
 01h	DWORD	result (01h)
--------W-2FF202-----------------------------
INT 2F - WINX - SET SERVER'S WORKING DIRECTORY
	AX = F202h
	BX:CX -> directory
Return: AX = status
	    FFFFh if WINX is busy processing a different request
	    0000h if successful
SeeAlso: AX=F200h,AX=F203h
--------W-2FF203-----------------------------
INT 2F - WINX - EXECUTE COMMAND
	AX = F203h
	BX:CX -> command
Return: AX = status
	    0000h if successful
	    FFFFh if WINX is busy processing a different request
SeeAlso: AX=F200h,AX=F202h
--------G-2FF400-----------------------------
INT 2F - FINDIRQ.COM - INSTALLATION CHECK
	AX = F400h
Return: AL = 01h if installed
Program: FINDIRQ is a program by Rick Knoblaugh published in the 9/28/93 issue
	  of PC Magazine; when run as a TSR it can determine which IRQs are
	  used only when a device is active
SeeAlso: AX=F401h
--------G-2FF401CX5121-----------------------
INT 2F - FINDIRQ.COM - GET HOOKED INTERRUPTS
	AX = F401h
	CX = 5121h ('Q!')
Return: AX:DX -> hooked interrupt table (see #1794)
SeeAlso: AX=F400h

Format of FINDIRQ hooked interrupt table:
Offset	Size	Description	(Table 1794)
 00h	BYTE	1Ch
 01h	DWORD	FINDIRQ's INT 1C handler
 05h	DWORD	original INT 1C handler
 09h	BYTE	28h
 0Ah	DWORD	FINDIRQ's INT 28 handler
 0Eh	DWORD	original INT 28 handler
 12h	BYTE	2Fh
 13h	DWORD	FINDIRQ's INT 2F handler
 17h	DWORD	original INT 2F handler
--------d-2FF700-----------------------------
INT 2F - AUTOPARK.COM - INSTALLATION CHECK
	AX = F700h
Return: AL = state
	    00h not installed
	    FFh installed
Program: AUTOPARK.COM is a resident hard disk parker by Alan D. Jones
--------d-2FF701-----------------------------
INT 2F - AUTOPARK.COM - SET PARKING DELAY
	AX = F701h
	BX:CX = 32-bit count of 55ms timer ticks
--------d-2FF800CX4455-----------------------
INT 2F U - SuperStor PRO 2XON.COM - INSTALLATION CHECK
	AX = F800h
	CX = 4455h ("DU")
	DL = 45h ("E")
Return: AL = FFh if installed
	    ES:BX -> ASCII signature "Universal Data Exchange"
Program: SuperStor is a disk-compression program by Addstor.
Note:	returns AX=0001h if AL is not 00h or 01h
SeeAlso: AX=1001h,AX=F801h
--------d-2FF801CX4455-----------------------
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
--------*-2FFB-------------------------------
INT 2F - Multiplex - RESERVED BY BORLAND INTERNATIONAL
	AH = FBh
SeeAlso: AX=FB42h/BX=0001h
--------f-2FFB-------------------------------
INT 2F U - Conner Backup Exec AUTORES - API
	AH = FBh
	BL = function number (00h-07h)
	???
Return: ???
Program: AUTORES is a resident program launcher for unattended backups
--------a-2FFB00-----------------------------
INT 2F U - AutoBraille v1.1A - INSTALLATION CHECK
	AX = FB00h
Return: AX = 00FFh if installed
Program: AutoBraille is a shareware text-to-braille converter by KANSYS, Inc.
SeeAlso: INT 10/AX=3800h,INT 14/AX=F0F1h
--------U-2FFB00-----------------------------
INT 2F U - Jot-It! v1.50 - INSTALLATION CHECK
	AX = FB00h
Return: AX = FFFFh if installed
	    BX = version (BCD, BH=major, BL=minor)
SeeAlso: AX=FB03h"Jot-It",AX=FB01h"Jot-It"
--------a-2FFB01-----------------------------
INT 2F U - AutoBraille v1.1A - ???
	AX = FB01h
	???
Return: ???
--------U-2FFB01-----------------------------
INT 2F U - Jot-It! v1.50 - GET USER NAME
	AX = FB01h
Return: DX:BX -> ASCIZ user name
SeeAlso: AX=FB02h"Jot-It"
--------a-2FFB02-----------------------------
INT 2F U - AutoBraille v1.1A - ???
	AX = FB02h
Return: AH = ???
	AL = ???
--------U-2FFB02-----------------------------
INT 2F U - Jot-It! v1.50 - GET MESSAGE DIRECTORY
	AX = FB02h
Return: DX:BX -> ASCIZ name of directory in which messages are stored
SeeAlso: AX=FB01h"Jot-It"
--------a-2FFB03-----------------------------
INT 2F U - AutoBraille v1.1A - GET NEXT ???
	AX = FB03h
Return: AX = ???
--------U-2FFB03-----------------------------
INT 2F U - Jot-It! v1.50 - UNINSTALL
	AX = FB03h
Return: resident code removed from memory
Note:	CAUTION: NO checks are performed to ensure that the interrupt vectors
	  being unhooked (08h,09h,28h,2Fh) actually point at the Jot-It! code
SeeAlso: AX=FB00h"Jot-It"
--------a-2FFB-------------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AH = FBh
	AL = 04h-08h
Return: AX = 0000h
--------a-2FFB-------------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AH = FBh
	AL = 09h-0Fh (???, 0Eh = COM1, 0Fh = COM2)
Return: ???
Program: AutoBraille is a shareware text-to-braille converter by KANSYS, Inc.
--------a-2FFB-------------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AH = FBh
	AL = 10h-1Fh
	???
Return: ???
--------a-2FFB20-----------------------------
INT 2F U - AutoBraille v1.1A - SET ??? FLAGS
	AX = FB20h
	BL = flags to set
SeeAlso: AX=FB21h"AutoBraille"
--------a-2FFB21-----------------------------
INT 2F U - AutoBraille v1.1A - CLEAR ??? FLAGS
	AX = FB21h
	BL = flags to clear
SeeAlso: AX=FB20h"AutoBraille"
--------a-2FFB22-----------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AX = FB22h
	BL = ???
Program: AutoBraille is a shareware text-to-braille converter by KANSYS, Inc.
--------a-2FFB28-----------------------------
INT 2F U - AutoBraille v1.1A - ???
	AX = FB28h
	BX = ???
	???
Return: ???
SeeAlso: AX=FB29h"AutoBraille"
--------a-2FFB29-----------------------------
INT 2F U - AutoBraille v1.1A - ???
	AX = FB29h
	BX = ???
	???
Return: ???
SeeAlso: AX=FB28h"AutoBraille"
--------a-2FFB-------------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AH = FBh
	AL = 2Bh-34h
	BX = ???
--------a-2FFB35-----------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AX = FB35h
	BL = ???
--------a-2FFB36-----------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AX = FB36h
	BL = ???
--------a-2FFB37-----------------------------
INT 2F U - AutoBraille v1.1A - SET ???
	AX = FB37h
	BL = ???
Program: AutoBraille is a shareware text-to-braille converter by KANSYS, Inc.
--------E-2FFB42BX0001-----------------------
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
SeeAlso: AX=1687h,AX=FB42h/BX=1001h,AX=FB43h
--------E-2FFB42BX0002-----------------------
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
SeeAlso: AX=FB42h/BX=0003h,AX=FB42h/BX=0008h,INT 31/AX=0501h
--------E-2FFB42BX0002-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ALLOCATE MEMORY
	AX = FB42h
	BX = 0002h
	ES:SI -> memory block info (see #1795)
Return: ???
Note:	The version of DPMILOAD distributed with BC++ v2.0 identifies itself
	  as version 1.000, while the version distributed with BC++ 3.0
	  identifies itself as version 1.0; the former is 10864 bytes, the
	  latter 22180 bytes.
SeeAlso: AX=FB42h/BX=0003h,AX=FB42h/BX=0008h,INT 31/AX=0501h

Format of DPMILOAD memory block info:
Offset	Size	Description	(Table 1795)
 00h	WORD	flags (see #1796)
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

Bitfields for DPMILOAD memory block flags:
Bit(s)	Description	(Table 1796)
 0	set if data segment rather than code segment
 1	information valid
 2	set if DOS memory block rather than DPMI memory block
 4	???
 15	set if no LDT selectors for memory block???
SeeAlso: #1795
--------E-2FFB42BX0003-----------------------
INT 2F PU - Borland C++ DPMILOAD.EXE - GET AVAILABLE MEMORY
	AX = FB42h
	BX = 0003h
Return: DX:AX = size of largest free block in paragraphs
		0000h:0000h on error (BC3.0 version only)
Note:	AX and DX are destroyed on error, but no other error indicator is
	  returned, under the BC++ 2.0 version of DPMILOAD
SeeAlso: AX=FB42h/BX=0002h
--------E-2FFB42BX0004-----------------------
INT 2F PU - Borland C++ DPMILOAD.EXE - LOAD PROTECTED-MODE EXECUTABLE???
	AX = FB42h
	BX = 0004h
	DS:DX -> ASCIZ filename of protected-mode executable
Return: CX = selector of ??? or 0000h
---BC3.0---
	DX = status (0000h,FFF4h,others???) (see #1797)
Note:	the filename may also be terminated by a CR rather than a NUL under the
	  BC++ 3.0 version of DPMILOAD

(Table 1797)
Values for DPMILOAD function status:
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
--------E-2FFB42BX0005-----------------------
INT 2F PU - Borland C++ DPMILOAD.EXE - GET ADDRESS OF ??? BY NAME
	AX = FB42h
	BX = 0005h
	CX = selector of DPMILOAD data (see #1798)
	DS:DX -> ASCIZ or CR-terminated name of ??? (case ignored)
Return: DX = status (see #1797)
	    0000h successful
		AX:BX -> ??? FAR function (called with two words on top of stk)
	    else
		BX destroyed
SeeAlso: AX=FB42h/BX=0006h,AX=FB42h/BX=000Eh

Format of DPMILOAD data:
Offset	Size	Description	(Table 1798)
 00h 12 BYTEs	???
 0Ch	WORD	??? bit flags
 0Eh 14 BYTEs	???
 1Ch	WORD	number of memory control records (see #1801)
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
 52h	WORD	offset of name list (see #1799)
 54h  4 BYTEs	???
 58h	WORD	offset of array of 6-byte objects (see #1800)
 5Ah  8 BYTEs	???
 62h  9 BYTEs	ASCIZ name for ???
 6Bh  9 BYTEs	ASCIZ name for ???
	???

Format of name list entry [array]:
Offset	Size	Description	(Table 1799)
 00h	BYTE	length of name (00h if end of array)
 01h  N BYTEs	name
 N+1	WORD	1-based index into array of unknown 6-byte objects

Format of 6-byte objects:
Offset	Size	Description	(Table 1800)
 00h	BYTE	???
 01h	BYTE	???
 02h	BYTE	???
 03h	BYTE	1-based index of memory control record
 04h	WORD	???

Format of memory control record:
Offset	Size	Description	(Table 1801)
 00h 20 BYTEs	memory block info (see #1795)
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
--------E-2FFB42BX0006-----------------------
INT 2F PU - Borland C++ DPMILOAD.EXE - GET ADDRESS OF ??? BY NUMBER
	AX = FB42h
	BX = 0006h
	CX = selector of DPMILOAD data (see #1798)
	DX = 1-based index into array of ??? 6-byte objects
Return: DX = status (see #1797)
	    0000h successful
		AX:BX -> ??? FAR function (called with two words on top of stk)
	    else
		BX destroyed
SeeAlso: AX=FB42h/BX=0005h,AX=FB42h/BX=000Eh
--------E-2FFB42BX0007-----------------------
INT 2F PU - Borland C++ 2.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0007h
	CX = selector of ???
Return: ???
Note:	The version of DPMILOAD distributed with BC++ v2.0 identifies itself
	  as version 1.000, while the version distributed with BC++ 3.0
	  identifies itself as version 1.0; the former is 10864 bytes, the
	  latter 22180 bytes.
--------E-2FFB42BX0007-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0007h
	CX = selector of DPMILOAD data (see #1798)
	???
Return: DX = status (see #1797)
	    0000h successful
		AX = ???
--------E-2FFB42BX0008-----------------------
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
--------E-2FFB42BX0008-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - FREE MEMORY BLOCK
	AX = FB42h
	BX = 0008h
	ES:SI -> memory block info (see #1795)
Return: ???
SeeAlso: AX=FB42h/BX=0009h
--------E-2FFB42BX0009-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - RESIZE MEMORY BLOCK
	AX = FB42h
	BX = 0009h
	ES:SI -> memory block info (see #1795)
	???
Return: ???
SeeAlso: AX=FB42h/BX=0008h"3.0"
--------E-2FFB42BX000A-----------------------
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
--------E-2FFB42BX000B-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - UNUSED
	AX = FB42h
	BX = 000Bh
--------E-2FFB42BX000C-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - FREE DESCRIPTORS FOR MEMORY BLOCK???
	AX = FB42h
	BX = 000Ch
	ES:SI -> memory block info ??? (see #1795)
Return: DX = status???
SeeAlso: AX=FB42h/BX=000Fh
--------E-2FFB42BX000D-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - SIMULATE REAL MODE INTERRUPT
	AX = FB42h
	BX = 000Dh
	CX = number of words to copy from protected-mode to real mode stack
	DL = interrupt number
	DH = flags
	    bit 0: reset the interrupt controller and A20 line
	ES:DI -> real-mode call structure (see #1815 at INT 31/AX=0300h)
Return: CX = status
	    0000h successful
	    0001h failed
SeeAlso: INT 31/AX=0300h
--------E-2FFB42BX000E-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET ADDRESS OF ???
	AX = FB42h
	BX = 000Eh
	DS:DX -> ASCIZ or CR-terminated name of ???
Return: CX = selector of DPMILOAD data (see #1798) corresponding to name,
	      0000h on error
SeeAlso: AX=FB42h/BX=0006h,AX=FB42h/BX=001Fh
--------E-2FFB42BX000F-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - REALLOCATE LDT DESCRPS TO MEMBLK???
	AX = FB42h
	BX = 000Fh
	ES:SI -> memory block info (see #1795)
Return: ???
SeeAlso: AX=FB42h/BX=000Ch
--------E-2FFB42BX0010-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - CONVERT SEGMENT TO SELECTOR
	AX = FB42h
	BX = 0010h
	DX = segment number
Return: CX = status (0000h,0008h) (see also AX=FB42h/BX=0004h)
	    0000h successful
		DX = selector number for descriptor
	    0008h failed
SeeAlso: AX=FB42h/BX=0023h
--------E-2FFB42BX0011-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0011h
	CX = selector of DPMILOAD data (see #1798)
	???
Return: DX = status (0000h,0002h,FFFEh) (see also #1797)
	    0000h successful
		AX:BX -> ??? name
	    FFFEh ??? error
--------E-2FFB42BX0012-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0012h
	CX = selector for ???
Return: CX = selector for ???
--------E-2FFB42BX0013-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0013h
	CX = selector of DPMILOAD data (see #1798)
	DX = 1-based index of ???
Return: CX = status (0000h,0002h,FFF9h) (see also #1797)
	    0000h successful
		BX = ??? or 0000h
	    FFF9h ??? error
--------E-2FFB42BX0014-----------------------
INT 2F RU - Borland C++ 3.0 DPMILOAD.EXE - INSTALLATION CHECK
	AX = FB42h
	BX = 0014h
	CX = 0001h
Return: BX = 0000h if installed
Note:	unlike most of the DPMILOAD functions, this call is available only in
	  real or V86 mode
SeeAlso: AX=FB42h/BX=0001h,AX=FB42h/BX=000Ah
--------E-2FFB42BX0015-----------------------
INT 2F RU - Borland C++ 3.0 DPMILOAD.EXE - UNINSTALL
	AX = FB42h
	BX = 0015h
	CX = 0001h
Return: ???
Note:	unlike most of the DPMILOAD functions, this call is available only in
	  real or V86 mode
SeeAlso: AX=FB42h/BX=000Ah
--------E-2FFB42BX0016-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET ???
	AX = FB42h
	BX = 0016h
	CX = selector of DPMILOAD data (see #1798)
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		CX = ???
--------E-2FFB42BX0017-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0017h
	CX = ???
	DX = ???
	???
Return: DX = status (0000h,0001h) (see #1797)
--------E-2FFB42BX0018-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - SET ???
	AX = FB42h
	BX = 0018h
	CX = ???
--------E-2FFB42BX0019-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0019h
	CX = selector for ???
	???
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		CX = selector for ???
--------E-2FFB42BX001A-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 001Ah
	CX = selector for ???
	???
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
	    0004h failed
	CX:BX -> ???
--------E-2FFB42BX001B-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 001Bh
	CX = selector of DPMILOAD data (see #1798)
	DX = offset of ???
Return: DX = status (0000h,0002h) (see also #1797)
	    0000h successful
		BX = selector for ???
		CX = selector for ???
--------E-2FFB42BX001C-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 001Ch
	ES = selector for DPMILOAD data (see #1798)
	CX = 1-based index of ???
	DX = 1-based index of ???
Return: DX = status (0000h,0002h,FFF9h) (see #1797)
--------E-2FFB42BX001D-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET ???
	AX = FB42h
	BX = 001Dh
Return: CX:DX = ???
--------E-2FFB42BX001E-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 001Eh
	CX = ???
	???
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
	    FFF7h ??? error
	CX:BX -> ???
--------E-2FFB42BX001F-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET ADDRESS OF ???
	AX = FB42h
	BX = 001Fh
	DS:DX -> 8-character name of ???
	???
Return: CX = selector of DPMILOAD data (see #1798) for ???
		0000h on error
SeeAlso: AX=FB42h/BX=000Eh
--------E-2FFB42BX0020-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - NULL FUNCTION???
	AX = FB42h
	BX = 0020h
Return: DX = ??? (always 0000h)
--------E-2FFB42BX0021-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET PROCESSOR EXCEPTION HANDLER VECT
	AX = FB42h
	BX = 0021h
	CL = exception number (00h-1Fh)
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		AX:BX = selector:offset of handler
	    FFF2h unable to get exception handler vector
SeeAlso: AX=FB42h/BX=0022h,AX=FB42h/BX=0024h,INT 31/AX=0202h
--------E-2FFB42BX0022-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - SET PROCESSOR EXCEPTION HANDLER VECT
	AX = FB42h
	BX = 0022h
	CL = exception number (00h-1Fh)
	SI:DX = selector:offset of new handler
Return: DX = status (0000h,0004h,FFF2h) (see #1797)
SeeAlso: AX=FB42h/BX=0021h,AX=FB42h/BX=0025h,INT 31/AX=0203h
--------E-2FFB42BX0023-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - CONVERT SELECTOR TO SEGMENT NUMBER
	AX = FB42h
	BX = 0023h
	CX = selector
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		CX = real-mode segment number
	    FFF2h descriptor has invalid base address for real-mode segment
SeeAlso: AX=FB42h/BX=0010h
--------E-2FFB42BX0024-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET PROTECTED-MODE INTERRUPT VECTOR
	AX = FB42h
	BX = 0024h
	CL = interrupt number
Return: DX = status (0000h) (see also AX=FB42h/BX=0004h)
	AX:BX = selector:offset of handler
SeeAlso: AX=FB42h/BX=0025h,INT 31/AX=0204h
--------E-2FFB42BX0025-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - SET PROTECTED-MODE INTERRUPT VECTOR
	AX = FB42h
	BX = 0025h
	CL = interrupt number
	SI:DX = selector:offset of new handler
Return: DX = status (0000h,0004h,FFF2h) (see #1797)
SeeAlso: AX=FB42h/BX=0024h,INT 31/AX=0205h
--------E-2FFB42BX0026-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - ???
	AX = FB42h
	BX = 0026h
	CX = selector of DPMILOAD data (see #1798)
	DX = 1-based index of ???
	???
Return: DX = status (0000h,0002h,FFF9h) (see #1797)
	    0000h successful
		BX = offset of ??? within data structure
--------E-2FFB42BX0027-----------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - GET ???
	AX = FB42h
	BX = 0027h
	CX = selector of DPMILOAD data (see #1798)
	DX = offset of ???
Return: DX = status (see also AX=FB42h/BX=0004h)
	    0000h successful
		BX = ???
--------E-2FFB42BX0080-----------------------
INT 2F U - ??? - CALLED BY Borland C++ 3.0 DPMILOAD.EXE
	AX = FB42h
	BX = 0080h
	???
Return: AX = ???
	???
--------E-2FFB42BX0081-----------------------
INT 2F U - ??? - CALLED BY Borland C++ 3.0 DPMILOAD.EXE
	AX = FB42h
	BX = 0081h
	???
Return: AX = ???
	???
--------E-2FFB42BX1001-----------------------
INT 2F U - Borland RTM.EXE 1.0 - INSTALLATION CHECK???
	AX = FB42h
	BX = 1001h
Return: BX = 0000h
SeeAlso: AX=FB42h/BX=0001h,AX=FB42h/BX=1002h,AX=FB42h/BX=1003h
--------E-2FFB42BX1002-----------------------
INT 2F U - Borland RTM.EXE 1.0 - ???
	AX = FB42h
	BX = 1002h
	???
Return: ???
SeeAlso: AX=FB42h/BX=1001h
--------E-2FFB42BX1003-----------------------
INT 2F U - Borland RTM.EXE 1.0 - ???
	AX = FB42h
	BX = 1003h
	???
Return: ???
SeeAlso: AX=FB42h/BX=1001h
--------E-2FFB43-----------------------------
INT 2F PU - Borland C++ 3.0 DPMILOAD.EXE - NULL FUNCTION
	AX = FB43h
	BX = subfunction (at least 0000h-000Eh)
Notes:	this function is only present in protected mode; it does nothing but
	  an immediate IRET
	DPMILOAD.EXE itself calls various subfunctions:
	    subfunction 0004h is called with CX=selector of ???, DI=selector
		  of DPMILOAD data
	    subfunction 0008h is called with CX=selector of DPMILOAD data
SeeAlso: AX=FB42h/BX=0001h
--------G-2FFB43BX0100-----------------------
INT 2F PU - Borland TDX - INSTALLATION CHECK
	AX = FB43h
	BX = 0100h
Return: BX = FB43h if loaded
Program: TDX is Borland's Turbo Debugger variant for DPMI programs
Note:	Borland Pascal 7 DPMI programs use this call to check whether they
	  should install their own stack and general protection exception
	  handlers, or allow TDX to handle those exceptions
--------a-2FFB64-----------------------------
INT 2F U - AutoBraille v1.1A - GET ???
	AX = FB64h
Return: AX = ??? (0006h seen)
Program: AutoBraille is a shareware text-to-braille converter by KANSYS, Inc.
--------E-2FFBA1BX0081-----------------------
INT 2F U - TKERNEL (Borland DOS extender) - INSTALLATION CHECK
	AX = FBA1h
	BX = 0081h
	ES:DI -> 16-byte buffer
Return: if installed, first four bytes of ES:DI buffer are "IABH"
Program: TKERNEL is a licensed version of AI Architects/Ergo's OS/x86.
Note:	TKERNEL was present only in Borland C++ 2.0; with version 3.0, the DOS
	  extender was moved into DPMILOAD.
SeeAlso: AH=A1h,AX=F100h,AX=FBA1h/BX=0082h,AX=FBA1h/BX=0084h,INT 15/AX=BF02h
SeeAlso: INT 21/AX=4403h"TKERNEL"
--------E-2FFBA1BX0082-----------------------
INT 2F U - TKERNEL (Borland DOS extender) - GET ENTRY POINT
	AX = FBA1h
	BX = 0082h
	ES:DI -> response buffer (see #1802)
Return: ES:DI buffer filled
SeeAlso: AX=FBA1h/BX=0081h,AX=FBA1h/BX=0084h

Format of TKERNEL response buffer:
Offset	Size	Description	(Table 1802)
 00h  4 BYTEs	signature "IABH"
 04h	DWORD	pointer to FAR extender entry point (see #1803)

(Table 1803)
Call TKERNEL entry point with:
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
		Return: AX = status???
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
				      (ret) remaining iterations
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
		Format of data structure:
		Offset	Size	Description
		 00h  2 BYTEs	unused
		 02h	WORD	???
		 04h	WORD	???
		 06h	WORD	???
		 08h  2 BYTEs	unused
		 0Ah	WORD	???
		 0Ch	WORD	(call) ???
				(ret) offset of this data structure (BUG?)
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
			  returns CF set on error, AX=error code)
		Note: each of these pointers normally points at INT 21/RETF
	    other Return: AX = 0001h
Note:	BX may be destroyed by any of the API calls
--------E-2FFBA1BX0084-----------------------
INT 2F U - TKERNEL (Borland DOS extender) - UNINSTALL
	AX = FBA1h
	BX = 0084h
	ES:DI -> response buffer (see #1804)
Return: ES:DI buffer filled
SeeAlso: AX=FBA1h/BX=0081h,AX=FBA1h/BX=0084h

Format of TKERNEL response buffer:
Offset	Size	Description	(Table 1804)
 00h  4 BYTEs	signature "IABH"
 04h	WORD	success indicator
		0001h failed (INT 2F hooked by another program)
		unchanged if successful
 06h	WORD	segment of ???
 08h	WORD	segment of ??? memory block to free if nonzero
 0Ah	WORD	segment of ??? memory block to free if nonzero
--------s-2FFBFBES0000-----------------------
INT 2F U - SoundBlaster speech driver - INSTALLATION CHECK
	AX = FBFBh
	ES = 0000h
Return: ES nonzero if installed
	    ES:BX -> entry point data structure (see #1805)
SeeAlso: INT 80/BX=0000h,INT F3"SoundBlaster"

Format of SoundBlaster entry point data structure:
Offset	Size	Description	(Table 1805)
 00h  3 BYTEs	signature "FB "
 03h	BYTE	driver major version number???
 04h	DWORD	speech driver entry point (see #1806)
 08h 24 BYTEs	???
 20h  ? BYTEs	data buffer for calling speech driver

(Table 1806)
Call SoundBlaster speech driver entry point with:
	AL = function
	    07h speak a string
		data buffer (see #1805) contains:
			BYTE  length of string
		      N BYTEs string to speak
--------!---Section--------------------------
