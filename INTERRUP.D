Interrupt List, part 4 of 10
This compilation is Copyright (c) 1989,1990,1991,1992,1993 Ralf Brown
--------D-2142-------------------------------
INT 21 - DOS 2+ - "LSEEK" - SET CURRENT FILE POSITION
	AH = 42h
	AL = origin of move
	    00h start of file
	    01h current file position
	    02h end of file
	BX = file handle
	CX:DX = offset from origin of new file position
Return: CF clear if successful
	    DX:AX = new file position in bytes from start of file
	CF set on error
	    AX = error code (01h,06h) (see AH=59h)
Notes:	for origins 01h and 02h, the pointer may be positioned before the
	  start of the file; no error is returned in that case, but subsequent
	  attempts at I/O will produce errors
	if the new position is beyond the current end of file, the file will
	  be extended by the next write (see AH=40h)
BUG:	using this method to grow a file from zero bytes to a very large size
	  can corrupt the FAT in some versions of DOS; the file should first
	  be grown from zero to one byte and then to the desired large size
SeeAlso: AH=24h,INT 2F/AX=1228h
--------v-214203-----------------------------
INT 21 - VIRUS - "Shake" - INSTALLATION CHECK
	AX = 4203h
Return: AX = 1234h if resident
SeeAlso: AX=3DFFh,AX=4243h
--------v-214243-----------------------------
INT 21 - VIRUS - "Invader" - INSTALLATION CHECK
	AX = 4243h
Return: AX = 5678h if resident
SeeAlso: AX=4203h,AX=4B04h
--------D-214300-----------------------------
INT 21 - DOS 2+ - GET FILE ATTRIBUTES
	AX = 4300h
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    CX = file attributes (see AX=4301h)
	    AX = CX (DR-DOS 5.0)
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see AH=59h)
Notes:	under the FlashTek X-32 DOS extender, the filename pointer is in DS:EDX
	under DR-DOS 3.41 and 5.0, attempts to change the subdirectory bit are
	  simply ignored without an error
SeeAlso: AX=4301h,AX=4310h,AH=B6h,INT 2F/AX=110Fh
--------D-214301-----------------------------
INT 21 - DOS 2+ - "CHMOD" - SET FILE ATTRIBUTES
	AX = 4301h
	CX = new file attributes (see below)
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see AH=59h)
Notes:	will not change volume label or directory attribute bits, but will
	  change the other attribute bits of a directory (the directory
	  bit must be cleared to successfully change the other attributes of a
	  directory, but the directory will not be changed to a normal file as
	  a result)
	MS-DOS 4.01 reportedly closes the file if it is currently open
	for security reasons, the Novell NetWare execute-only bit can never
	  be cleared; the file must be deleted and recreated
	under the FlashTek X-32 DOS extender, the filename pointer is in DS:EDX
	DOS 5.0 SHARE will close the file if it is currently open in sharing-
	  compatibility mode, otherwise a sharing violation critical error is
	  generated if the file is currently open
SeeAlso: AX=4300h,AX=4311h,INT 2F/AX=110Eh

Bitfields for file attributes:
 bit 7	shareable (Novell NetWare)
 bit 6	unused
 bit 5	archive
 bit 4	directory
 bit 3	volume label
	execute-only (Novell NetWare)
 bit 2	system
 bit 1	hidden
 bit 0	read-only
--------O-214302-----------------------------
INT 21 - DR-DOS 3.41+ internal - GET ACCESS RIGHTS
	AX = 4302h
	DS:DX -> ASCIZ pathname
Return: CF clear if successful
	    CX = access rights (see below)
	    AX = CX (DR-DOS 5.0)
	CF set on error
	    AX = error code
Desc:	Determine which operations the calling program may perform on a
	  specified file without being required to provide a password.
Notes:	this protection scheme has been coordinated on all current Digital
	  Research/Novell operating systems (DR-DOS 3.41+, DRMDOS 5.x, and
	  FlexOS 2+)
	this function is documented in DR-DOS 6.0 and corresponds to the
	  "Get/Set File Attributes" function, subfunction 2, documented in
	  Concurrent DOS.
	only FlexOS actually uses the "execution" bits; DR-DOS 3.41+ treats
	  them as "read" bits.
	DR-DOS 3.41-5.x only use bits 0-3.  Only DR-DOS 6.0 using a
	  DRMDOS 5.x security system allowing for users and groups uses bits
	  4-11.
SeeAlso: AX=4303h

Bitfields for access rights:
 bit 0	owner delete requires password
 bit 1	owner execution requires password (FlexOS)
 bit 2	owner write requires password
 bit 3	owner read requires password
 bit 4	group delete requires password
 bit 5	group execution requires password (FlexOS)
 bit 6	group write requires password
 bit 7	group read requires password
 bit 8	world delete requires password
 bit 9	world execution requires password (FlexOS)
 bit 10 world write requires password
 bit 11 world read requires password
--------O-214303-----------------------------
INT 21 - DR-DOS 3.41+ internal - SET ACCESS RIGHTS AND PASSWORD
	AX = 4303h
	CX = access rights
	     bits 11-0: access rights (see AX=4302h)
	     bit 15: new password is to be set
	DS:DX -> ASCIZ pathname
	[DTA] = new password if CX bit 15 is set (blank-padded to 8 characters)
Return: CF clear if successful
	CF set on error
	    AX = error code
Notes:	if the file is already protected, the old password must be added after
	  the pathname, separated by a ";"
	this function is documented in DR-DOS 6.0 and corresponds to the
	  "Get/Set File Attributes" function, subfunction 3, documented in
	  Concurrent DOS.
SeeAlso: AH=0Fh,AH=17h,AX=4302h,AX=4305h,AX=4454h
--------O-214304-----------------------------C26!
INT 21 U - DR-DOS 5.0-6.0 internal - GET ENCRYPTED PASSWORD
	AX = 4304h
	DS:DX -> ASCIZ filename
	???
Return: CF clear if successful
	    CX = AX = 0000h if no password assigned to file
	CF set on error
	    AX = error code (see AH=59h)
Note:	this function is only supported by DR-DOS 5.0 and 6.0 and DRMDOS 5.1
SeeAlso: AX=4303h,AX=4305h
--------O-214305-----------------------------C26!
INT 21 U - DR-DOS 5.0-6.0 internal - SET EXTENDED FILE ATTRIBUTES
	AX = 4305h
	DS:DX -> ASCIZ filename
	???
Return: CF clear if successful
	CF set on error
	    AX = error code (see AH=59h)
Desc:	this function allows the extended attributes, and optionally the
	  encrypted password, of a file to be set.
Note:	this function is only supported by DR-DOS 5.0 and 6.0 and DRMDOS 5.1
SeeAlso: AX=4304h,AX=4311h
--------O-214306-----------------------------C26!
INT 21 - DR-DOS 6.0 - GET FILE OWNER
	AX = 4306h
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    AX = CX = value set with AX=4307h
	CF set on error
	    AX = error code (see AH=59h)
SeeAlso: AX=4307h
--------O-214307-----------------------------C26!
INT 21 - DR-DOS 6.0 - SET FILE OWNER
	AX = 4307h
	CX = ??? (owner identification number?)
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	CF set on error
	    AX = error code (see AH=59h)
SeeAlso: AX=4306h
--------N-214310-----------------------------
INT 21 - Banyan VINES 2.1+ - GET EXTENDED FILE ATTRIBUTES
	AX = 4310h
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    CH = attributes (see AX=4311h)
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see AH=59h)
Note:	the filename may be a directory but must be on a VINES file service
SeeAlso: AX=4300h,AX=4311h,AH=B6h,INT 2F/AX=110Fh
--------N-214311-----------------------------
INT 21 - Banyan VINES 2.1+ - SET EXTENDED FILE ATTRIBUTES
	AX = 4311h
	CH = new attributes
	    bit 7: unused
	    bit 6: shareable
	    bit 5: execute-only
	    bits 4-0: unused
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see AH=59h)
Note:	the filename may be a directory but must be on a VINES file service
SeeAlso: AX=4301h,AX=4305h,AX=4310h,INT 2F/AX=110Eh
----------214380-----------------------------
INT 21 - Novell DOS 7 - UNDELETE PENDING DELETE FILE
	AX = 4380h
	???
Return: ???
SeeAlso: AH=41h,AX=4381h
----------214381-----------------------------
INT 21 - Novell DOS 7 - PURGE PENDING DELETE FILE
	AX = 4381h
	???
Return: ???
SeeAlso: AH=41h,AX=4380h
--------D-214400-----------------------------
INT 21 - DOS 2+ - IOCTL - GET DEVICE INFORMATION
	AX = 4400h
	BX = handle
Return: CF clear if successful
	    DX = device information word (see below)
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h) (see AH=59h)
Notes:	value in DH corresponds to high byte of device driver's attribute word
	  if handle refers to a character device
	Novell NetWare reportedly does not return a drive number in bits 5-0
	  for a disk file
SeeAlso: AX=4401h,INT 2F/AX=122Bh

Bitfields for device information word:
 character device
  bit 14: device driver can process IOCTL requests (see AX=4402h)
  bit 13: output until busy supported
  bit 11: driver supports OPEN/CLOSE calls
  bit  7: set (indicates device)
  bit  6: EOF on input
  bit  5: raw (binary) mode
  bit  4: device is special (uses INT 29)
  bit  3: clock device
  bit  2: NUL device
  bit  1: standard output
  bit  0: standard input
 disk file
  bit 15: file is remote (DOS 3+)
  bit 14: don't set file date/time on closing (DOS 3+)
  bit 11: media not removable
  bit  8: (DOS 4 only) generate INT 24 if no disk space on write or read past
		end of file
  bit  7: clear (indicates file)
  bit  6: file has not been written
  bits 5-0: drive number (0 = A:)
--------D-214401-----------------------------
INT 21 - DOS 2+ - IOCTL - SET DEVICE INFORMATION
	AX = 4401h
	BX = handle (must refer to character device)
	DX = device information word (see AX=4400h)
	    (DH must be zero)
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4400h,INT 2F/AX=122Bh
--------D-214402-----------------------------
INT 21 - DOS 2+ - IOCTL - READ FROM CHARACTER DEVICE CONTROL CHANNEL
	AX = 4402h
	BX = file handle referencing character device
	CX = number of bytes to read
	DS:DX -> buffer
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	format of data is driver-specific (see below for some specific cases)
SeeAlso: AX=4400h,AX=4403h,AX=4404h,INT 2F/AX=122Bh
--------N-214402-----------------------------
INT 21 - Network Driver Interface Spec 2.0.1 - PROTOCOL MANAGER
	AX = 4402h
	BX = file handle for device "PROTMAN$"
	DS:DX -> request block (see below)
	CX = 000Eh (size of request block)

Format of request block for GetProtocolManagerInfo:
Offset	Size	Description
 00h	WORD	01h
 02h	WORD	returned status (see below)
 04h	DWORD	returned pointer to structure representing parsed user config
 08h	DWORD	unused
 0Ch	WORD	returned BCD version of NDIS on which Protocol Manager is based

Format of request block for RegisterModule:
Offset	Size	Description
 00h	WORD	02h
 02h	WORD	returned status (see below)
 04h	DWORD	pointer to module's common characteristics table (see below)
 08h	DWORD	pointer to list of modules to which the module is to be bound
 0Ch	WORD	unused

Format of request block for BindAndStart:
Offset	Size	Description
 00h	WORD	03h
 02h	WORD	returned status (see below)
 04h	DWORD	caller's virtual address in FailingModules structure
 08h	DWORD	unused
 0Ch	WORD	unused

Format of request block for GetProtocolManagerLinkage:
Offset	Size	Description
 00h	WORD	04h
 02h	WORD	returned status (see below)
 04h	DWORD	returned dispatch point
 08h	DWORD	unused
 0Ch	WORD	returned protocol manager DS
Note:	the dispatch point may be called as follows instead of using this IOCTL
	STACK: WORD  protocol manager DS
	       DWORD pointer to request block
	Return: AX = returned status
		STACK popped

Format of request block for GetProtocolIniPath:
Offset	Size	Description
 00h	WORD	05h
 02h	WORD	returned status (see below)
 04h	DWORD	pointer to a buffer for the ASCIZ pathname of PROTOCOL.INI
 08h	DWORD	unused
 0Ch	WORD	buffer length

Format of request block for RegisterProtocolManagerInfo:
Offset	Size	Description
 00h	WORD	06h
 02h	WORD	returned status (see below)
 04h	DWORD	pointer to structure containing parsed user config file
 08h	DWORD	unused
 0Ch	WORD	length of structure

Format of request block for InitAndRegister:
Offset	Size	Description
 00h	WORD	07h
 02h	WORD	returned status (see below)
 04h	DWORD	unused
 08h	DWORD	poitner to ASCIZ name of the module to be prebind initialized
 0Ch	WORD	unused

Format of request block for UnbindAndStop:
Offset	Size	Description
 00h	WORD	08h
 02h	WORD	returned status (see below)
 04h	DWORD	failing modules as for BindAndStart
 08h	DWORD	if not 0000h:0000h, pointer to ASCIZ name of module to unbind
		if 0000h:0000h, terminate a set of previously dynamically
		  bound protocol modules
 0Ch	WORD	unused

Format of request block for BindStatus:
Offset	Size	Description
 00h	WORD	09h
 02h	WORD	returned status (see below)
 04h	DWORD	must be 0000h:0000h
		on return, points to root tree
 08h	DWORD	0000h:0000h
 0Ch	WORD	unused under DOS

Format of request block for RegisterStatus:
Offset	Size	Description
 00h	WORD	0Ah
 02h	WORD	returned status (0000h, 0008h, 002Ch) (see below)
 04h	DWORD	0000h:0000h
 08h	DWORD	pointer to 16-byte ASCIZ module name
 0Ch	WORD	0000h
Note:	not supported by the 10NET v5.0 PROTMAN$ driver

Values for status code:
 0000h	success
 0001h	wait for release--protocol has retained control of the data buffer
 0002h	request queued
 0003h	frame not recognized
 0004h	frame rejected
 0005h	frame should be forwarded
 0006h	out of resource
 0007h	invalid parameter
 0008h	invalid function
 0009h	not supported
 000Ah	hardware error
 000Bh	transmit error
 000Ch	unrecognized destination
 000Dh	buffer too small
 0020h	already started
 0021h	binding incomplete
 0022h	driver not initialized
 0023h	hardware not found
 0024h	hardware failure
 0025h	configuration failure
 0026h	interrupt conflict
 0027h	MAC incompatible
 0028h	initialization failed
 0029h	no binding
 002Ah	network may be disconnected
 002Bh	incompatible OS version
 002Ch	already registered
 002Dh	path not found
 002Eh	insufficient memory
 002Fh	info not found
 00FFh	general failure
 F000h-FFFFh reserved for vendor-specific codes, treated as general failure

Format of common characteristics table:
Offset	Size	Description
 00h	WORD	size of table in bytes
 02h	BYTE	NDIS major version
 03h	BYTE	NDIS minor version
 04h	WORD	reserved
 06h	BYTE	module major version
 07h	BYTE	module minor version
 08h	DWORD	module function flag bits
		bit 0: binding at upper boundary supported
		bit 1: binding at lower boundary supported
		bit 2: dynamically bound
		bits 3-31 reserved, must be 0
 0Ch 16 BYTEs	ASCIZ module name
 1Ch	BYTE	upper boundary protocol level (see below)
 1Dh	BYTE	upper boundary interface type
		for MACs: 1 = MAC
		for data links and transports: to be defined
		for session: 1 = NCB
		any level: 0 = private (ISV-defined)
 1Eh	BYTE	lower boundary protocol level (see below)
 1Fh	BYTE	lower boundary interface type
		same as offset 1Dh
 20h	WORD	module ID filled in by protocol manager
 22h	WORD	module DS
 24h	DWORD	system request entry point
 28h	DWORD	pointer to service-specific characteristics
		0000h:0000h if none
 2Ch	DWORD	pointer to service-specific status, or 0000h:0000h if none
 30h	DWORD	pointer to upper dispatch table (see below)
		0000h:0000h if none
 34h	DWORD	pointer to lower dispatch table (see below)
		0000h:0000h if none
 38h  2 DWORDs	reserved, must be 0
Note:	for compatibility with NDIS 1.x.x, a major version of 00h is
	  interpreted as 01h

Values for boundary protocol level:
 00h	physical
 01h	Media Access Control
 02h	Data link
 03h	network
 04h	transport
 05h	session
 FFh	not specified

Format of MAC Service-Specific Characteristics Table:
Offset	Size	Description
 00h	WORD	length of table in bytes
 02h 16 BYTEs	ASCIZ MAC type name, "802.3", "802.4", "802.5", "802.6", "DIX",
		"DIX+802.3", "APPLETALK", "ARCNET", "FDDI", "SDLC", "BSC",
		"HDLC", or "ISDN"
 12h	WORD	length of station addresses in bytes
 14h 16 BYTEs	permanent station address
 24h 16 BYTEs	current station address
 34h	DWORD	current functional adapter address (00000000h if none)
 38h	DWORD	pointer to multicast address list
 3Ch	DWORD	link speed in bits/sec
 40h	DWORD	service flags (see below)
 44h	WORD	maximum frame size which may be both sent and received
 46h	DWORD	total transmit buffer capacity in bytes
 4Ah	WORD	transmit buffer allocation block size in bytes
 4Ch	DWORD	total receive buffer capacity in bytes
 50h	WORD	receive buffer allocation block size in bytes
 52h  3 BYTEs	IEEE vendor code
 55h	BYTE	vendor adapter code
 56h	DWORD	pointer to ASCIZ vendor adapter description
 5Ah	WORD	IRQ used by adapter
 5Ch	WORD	transmit queue depth
 5Eh	WORD	maximum supported number of data blocks in buffer descriptors
 60h  N BYTEs	vendor-specific info

Bitfields for service flags:
 bit 0	supports broadcast
 bit 1	supports multicast
 bit 2	supports functional/group addressing
 bit 3	supports promiscuous mode
 bit 4	station address software settable
 bit 5	statistics always current
 bit 6	supports InitiateDiagnostics
 bit 7	supports loopback
 bit 8	MAC does primarily ReceiveChain indications instead of ReceiveLookahead
	indications
 bit 9	supports IBM source routing
 bit 10 supports MAC reset
 bit 11 supports Open/Close adapter
 bit 12 supports interrupt request
 bit 13 supports source routing bridge
 bit 14 supports GDT virtual addresses (OS/2 version)
 bit 15 multiple TransferDatas allowed durign a single indication
 bit 16 MAC normally sets FrameSize = 0 in ReceiveLookahead
 bit 17-31 reserved, must be 0

Format of NetBIOS Service-Specific Characteristics Table
Offset	Size	Description
 00h	WORD	length of table in bytes
 02h 16 BYTEs	ASCIZ type name of NetBIOS module
 12h	WORD	NetBIOS module code
 14h  N BYTEs	vendor-specific info

Format of MAC Service-Specific Status Table:
Offset	Size	Description
 00h	WORD	length of table in bytes
 02h	DWORD	seconds since 0:00 1/1/70 when diagnostics last run
		(FFFFFFFFh = never)
 06h	DWORD	MAC status bits (see below)
 0Ah	WORD	current packet filter flags
		bit 0: directed/multicast or group/functional
		bit 1: broadcast
		bit 2: promiscuous
		bit 3: all source routing
		bits 4-15: reserved, must be zero
 0Ch	DWORD	pointer to media-specific status table or 0000h:0000h
 10h	DWORD	seconds past 0:00 1/1/70 of last ClearStatistics
 14h	DWORD	total frames received (FFFFFFFFh = not counted)
 18h	DWORD	frames with CRC error (FFFFFFFFh = not counted)
 1Ch	DWORD	total bytes received (FFFFFFFFh = not counted)
 20h	DWORD	frames discarded--no buffer space (FFFFFFFFh = not counted)
 24h	DWORD	multicast frames received (FFFFFFFFh = not counted)
 28h	DWORD	broadcast frames received (FFFFFFFFh = not counted)
 2Ch	DWORD	frames with errors (FFFFFFFFh = not counted)
 30h	DWORD	overly large frames (FFFFFFFFh = not counted)
 34h	DWORD	frames less than minimum size (FFFFFFFFh = not counted)
 38h	DWORD	multicast bytes received (FFFFFFFFh = not counted)
 3Ch	DWORD	broadcast bytes received (FFFFFFFFh = not counted)
 40h	DWORD	frames discarded--hardware error (FFFFFFFFh = not counted)
 44h	DWORD	total frames transmitted (FFFFFFFFh = not counted)
 48h	DWORD	total bytes transmitted (FFFFFFFFh = not counted)
 4Ch	DWORD	multicast frames transmitted (FFFFFFFFh = not counted)
 50h	DWORD	broadcast frames transmitted (FFFFFFFFh = not counted)
 54h	DWORD	broadcast bytes transmitted (FFFFFFFFh = not counted)
 58h	DWORD	multicast bytes transmitted (FFFFFFFFh = not counted)
 5Ch	DWORD	frames not transmitted--timeout (FFFFFFFFh = not counted)
 60h	DWORD	frames not transmitted--hardware error (FFFFFFFFh = not countd)
 64h  N BYTEs	vendor-specific info

Bitfields for MAC status bits:
 bits 0-2	operational status
		000 hardware not installed
		001 hardware failed startup diagnostics
		010 hardware configuration problem
		011 hardware fault
		100 operating marginally due to soft faults
		101 reserved
		110 reserved
		111 hardware fully operational
 bit 3	MAC bound
 bit 4	MAC open
 bit 5	diagnostics in progress
 bits 6-31 reserved
--------I-214402-----------------------------
INT 21 U - IBM SYSTEM 36/38 WORKSTATION EMULATION - VDI.SYS - GET ???
	AX = 4402h
	BX = handle for character device "GDMS"
	CX = number of bytes to read (>= 4)
	DS:DX -> buffer (see below)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    AX = number of bytes read

Format of returned data:
Offset	Size	Description
 00h  4 BYTEs	???
 04h	DWORD	pointer to ???
 08h  4 BYTEs	???
--------m-214402-----------------------------
INT 21 U - LASTBYTE.SYS v1.19 - IOCTL - GET ??? TABLE
	AX = 4402h
	BX = handle for device "LA$TBYTE"
	CX = 0004h
	DS:DX -> DWORD to hold address of 39-byte table of ???
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    AX = number of bytes read
Program: LASTBYTE.SYS is part of the shareware "The Last Byte" memory
	  management package by Key Software Products
SeeAlso: AX=4402h"HIGHUMM"
--------m-214402-----------------------------
INT 21 - HIGHUMM.SYS v1.17+ - IOCTL - GET API ADDRESS
	AX = 4402h
	BX = handle for device "KSP$UMM"
	CX = 0004h
	DS:DX -> DWORD to hold entry point
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    AX = number of bytes read
Program: HIGHUMM.SYS is part of the shareware "The Last Byte" memory management
	  package by Key Software Products
SeeAlso: AX=4402h"LASTBYTE"

Call HIGHUMM.SYS entry point with:
	AH = 00h allocate UMB (same as XMS function 10h) (see INT 2F/AX=4310h)
	    DX = size in paragraphs
	    Return: BX = segment number (if successful)
		    DX = size of requested block/size of largest block
	AH = 01h deallocate UMB (same as XMS func 11h) (see INT 2F/AX=4310h)
	    DX = segment number of UMB
	AH = 02h request a bank-switched memory block
	    DX = size in paragraphs
	    Return: BX = segment number (if successful)
		    DX = size of requested block/size of largest block
	AH = 03h release a bank-switched memory block
	    DX = segment number
	AH = 04h transfer data to/from high memory
	    DS:SI -> source
	    ES:DI -> destination
	    CX = length in bytes
	    Note: enables bank-switched memory, does the copy, then disables
		bank-switched memory
	AH = 05h get a word from bank-switched memory
	    ES:DI -> word to read
	    Return: DX = word
	AH = 06h put a word to bank-switched memory
	    ES:DI -> word to write
	    DX = word
	AH = 07h put a byte to bank-switched memory
	    ES:DI -> byte to write
	    DL = byte
	AH = 08h enable bank-switched memory
	    DS:SI -> 6-byte status save area
	AH = 09h disable bank-switched memory
	    DS:SI -> 6-byte save area from enable call (AH=08h)
	AH = 0Ah assign name to UMB or high bank-switched block
	    DX = segment number
	    DS:SI -> 8-byte blank-padded name
	AH = 0Bh locate UMB block by name
	    DS:SI -> 8-byte blank-padded name
	    Return: BX = segment number (if successful)
		    DX = size of block
	AH = 0Ch locate bank-switched block by name
	    DS:SI -> 8-byte blank-padded name
	    Return: BX = segment number (if successful)
		    DX = size of block
Return: AX = status code
	    0001h successful
	    0000h failed
		BL = error code
		    80h not implemented
		    B0h insufficient memory, smaller block available
		    B1h insufficient memory, no blocks available
		    B2h invalid segment number
Note:	only functions 00h and 01h are always available; the remaining
	  functions are only enabled if the proper commandline switch is given
--------c-214402-----------------------------
INT 21 - SMARTDRV.SYS - IOCTL - GET CACHE STATUS
	AX = 4402h
	BX = file handle for device "SMARTAAR"
	CX = number of bytes to read (min 28h)
	DS:DX -> buffer for status record (see below)
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4403h"SMARTDRV",INT 2F/AX=4A10h/BX=0000h

Format of SMARTDRV status record:
Offset	Size	Description
 00h	BYTE	write-through flag (always 01h)
 01h	BYTE	writes should be buffered (always 00h)
 02h	BYTE	cache enabled if 01h
 03h	BYTE	driver type (01h extended memory, 02h expanded)
 04h	WORD	clock ticks between cache flushes (currently unused)
 06h	BYTE	cache contains locked tracks if nonzero
 07h	BYTE	flush cache on INT 19 reboot if nonzero
 08h	BYTE	cache full track writes if nonzero
 09h	BYTE	double buffering (for VDS) state (00h off, 01h on, 02h dynamic)
 0Ah	DWORD	original INT 13 vector
 0Eh	BYTE	minor version number
 0Fh	BYTE	major version number
 10h	WORD	unused
 12h	WORD	sectors read			\
 14h	WORD	sectors already in cache	 > may be scaled rather than
 16h	WORD	sectors already in track buffer /  absolute counts
 18h	BYTE	cache hit rate in percent
 19h	BYTE	track buffer hit rate in percent
 1Ah	WORD	total tracks in cache
 1Ch	WORD	number of tracks in use
 1Eh	WORD	number of locked tracks
 20h	WORD	number of dirty tracks
 22h	WORD	current cache size in 16K pages
 24h	WORD	original (maximum) cache size in 16K pages
 26h	WORD	minimum cache size in 16K pages
 28h	DWORD	pointer to byte flag to increment for locking cache contents
--------d-214402-----------------------------
INT 21 - CD-ROM device driver - IOCTL INPUT
	AX = 4402h
	BX = file handle referencing character device for CD-ROM driver
	CX = number of bytes to read
	DS:DX -> control block (see below)
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	the data returned depends on the first byte of the control block; the
	  remainder of the control block is filled by the driver
SeeAlso: AX=4403h"CD-ROM",INT 2F/AX=0802h

Values for data being requested:
 00h	device driver header address
 01h	drive head location
 02h	reserved
 03h	error statistics
 04h	audio channel info
 05h	raw drive bytes (uninterpreted and device-specific)
 06h	device status
 07h	sector size
 08h	volume size
 09h	media change status
 0Ah	audio disk info
 0Bh	audio track info
 0Ch	audio Q-Channel info
 0Dh	audio sub-channel info
 0Eh	UPC code

Format of control block:
Offset	Size	Description
 00h	BYTE	data being requested (see above)
---function 00h---
 01h	DWORD	device driver header address (see also AH=52h)
---function 01h---
 01h	BYTE	addressing mode
		00h HSG
		01h Red Book
 02h	DWORD	current location of drive's head
		logical sector number in HSG mode
		frame/second/minute/unused in Red Book mode
		(HSG sector = minute * 4500 + second * 75 + frame - 150)
---function 03h---
 01h  N BYTEs	undefined as of 5 Aug 88 specification
---function 04h---
 01h	BYTE	input channel (0-3) for output channel 0
 02h	BYTE	volume for output channel 0
 03h	BYTE	input channel (0-3) for output channel 1
 04h	BYTE	volume for output channel 1
 05h	BYTE	input channel (0-3) for output channel 2
 06h	BYTE	volume for output channel 2
 07h	BYTE	input channel (0-3) for output channel 3
 08h	BYTE	volume for output channel 3
Notes:	output channels 0 and 1 are left and right, 2 and 3 are left prime and
	  right prime; a volume of 00h is off
	the default setting is for each input channel to be assigned to the
	  same-numbered output channel at full (FFh) volume
---function 05h---
 01h	BYTE	number of bytes read
 02h 128 BYTEs	buffer for drive bytes
---function 06h---
 01h	DWORD	device parameters (see below)
---function 07h---
 01h	BYTE	read mode
		00h cooked
		01h raw
 02h	WORD	sector size in bytes
---function 08h---
 01h	DWORD	volume size in sectors
---function 09h---
 01h	BYTE	media change status
		00h don't know
		01h media unchanged
		FFh media has been changed
---function 0Ah---
 01h	BYTE	lowest audio track number
 02h	BYTE	highest audio track number
 03h	DWORD	start address of lead-out track (Red Book format)
--function 0Bh---
 01h	BYTE	track number (set by caller)
 02h	DWORD	starting point of track (Red Book format)
 06h	BYTE	track control info
		bits 15,14,12: track type (notice: bits not contiguous!)
			000 two audio channels, no pre-emphasis
			001 two audio channels with pre-emphasis
			010 data track
			100 four audio channels, no pre-emphasis
			101 four audio channels with pre-emphasis
			other reserved
		bit 13: digital copy permitted
---function 0Ch---
 01h	BYTE	CONTROL and ADR byte (as received from drive)
 02h	BYTE	track number
 03h	BYTE	point or index
 04h	BYTE	minute	\
 05h	BYTE	second	 > running time within track
 06h	BYTE	frame	/
 07h	BYTE	zero
 08h	BYTE	"AMIN" or "PMIN"     \
 09h	BYTE	"ASEC" or "PSEC"      > running time on disk
 0Ah	BYTE	"AFRAME" or "PFRAME" /
---function 0Dh---
 01h	DWORD	starting frame address (Red Book format)
 05h	DWORD	transfer address
 09h	DWORD	number of sectors to read
Note:	copies 96 bytes of sub-channel info per sector into buffer
---function 0Eh---
 01h	BYTE	CONTROL and ADR byte
 02h  7 BYTEs	UPC/EAN code (13 BCD digits,low-order nybble of last byte is 0)
 09h	BYTE	zero
 0Ah	BYTE	"AFRAME"

Bitfields for device parameters:
 bit 0	door open
 bit 1	door unlocked
 bit 2	supports raw reading in addition to cooked
 bit 3	writable
 bit 4	can play audio/video tracks
 bit 5	supports interleaving
 bit 6	reserved
 bit 7	supports prefetch requests
 bit 8	supports audio channel control
 bit 9	supports Red Book addressing in addition to HSG
 bit 10 audio is playing
--------m-214402-----------------------------
INT 21 - Quarterdeck - QEMM-386 v5+ - GET API ENTRY POINT
	AX = 4402h
	BX = file handle for device "QEMM386$"
	CX = 0004h
	DS:DX -> DWORD buffer for API entry point
Return: CF clear if successful
	    buffer filled (see INT 67/AH=3Fh for entry point parameters)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	Quarterdeck recently (June 1993) documented this function, but the
	  documentation incorrectly states that it is only available for
	  QEMM 6+
SeeAlso: AX=4402h"HOOKROM",INT 2F/AX=D201h/BX=5145h,INT 67/AH=3Fh
--------Q-214402-----------------------------
INT 21 U - Quarterdeck - HOOKROM.SYS - GET HOOKED VECTOR TABLE
	AX = 4402h
	BX = file handle for device "HOOKROM$"
	CX = 0004h
	DS:DX -> DWORD buffer for address of hooked vector table (see below)
Return: CF clear if successful
	    DS:DX buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4402h/SF=01h

Format of hooked vector table entry:
Offset	Size	Description
 00h  5 BYTEs	FAR jump to actual interrupt handler
		(end of table if first byte is not EAh)
 05h	BYTE	interrupt vector number
--------d-214402-----------------------------
INT 21 - Advanced SCSI Programming Interface (ASPI) - INTERFACE
	AX = 4402h
	BX = file handle for device "SCSIMGR$"
	CX = 0004h
	DS:DX -> buffer for function address
Return: CF clear if successful
	    AX = 0004h
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	the function address is called with the address of a SCSI Request
	  Block on the stack and the caller must clean up the stack
SeeAlso: AX=440Ch"ASPITAPE",INT 11/AH=FFh"WD7000"

Format of SCSI Request Block (64 bytes):
Offset	Size	Description
 00h	BYTE	request number
		00h "HA_INQ"	 host adapter inquiry
		01h "GET_TYPE"	 get device type
		02h "EXEC_SIO"	 execute SCSI I/O
		03h "ABORT_SRB"	 abort SRB
		04h "RESET_DEV"	 reset SCSI device
		05h "SET_HAPRMS" set host adapter parameters
 01h	BYTE	request status
		00h not done yet
		02h aborted
		04h SCSI I/O error
		80h invalid
		81h no adapter
		82h no device attached
		else status
 02h	BYTE	host adapter ID
 03h	BYTE	request flags
		bit 3: ???
 04h	DWORD	reserved
---request 00h---
 08h	BYTE	(returned) number of host adapters
 09h	BYTE	(returned) target adapter ID
 0Ah 16 BYTEs	(returned) manager ID
 1Ah 16 BYTEs	(returned) adapter ID
 2Ah 16 BYTEs	(returned) parameters
---request 01h---
 08h	BYTE	target ID
 09h	BYTE	logical unit number
 0Ah	BYTE	(returned) device type
		01h streamer
---request 02h---
 08h	BYTE	target ID
 09h	BYTE	logical unit number
 0Ah	DWORD	data allocation length
 0Eh	BYTE	sense allocation length
 0Fh	DWORD	data buffer pointer
 13h	DWORD	next request pointer (for linking)
 17h	BYTE	CDB length
 18h	BYTE	(returned) host adapter status
		11h select timeout
		12h data overrun
		13h bus error
		14h bus failure
 19h	BYTE	(returned) target status
		02h sense data stored in SRB
		08h target busy
		18h reservation error
 1Ah	DWORD	post routine address
 1Eh	WORD	real mode Post DS
 20h	DWORD	SRB pointer
 24h	WORD	reserved
 26h	DWORD	SRB physical address
 2Ah 22 BYTEs	SCSIMGR$ workspace
 40h  N BYTEs	CCB (20-24 bytes)
---request 04h---
 08h	BYTE	target ID
 09h	BYTE	logical unit number
 0Ah 14 BYTEs	reserved
 18h	BYTE	(returned) host adapter status (see above)
 19h	BYTE	(returned) target status (see above)
 1Ah	DWORD	post routine address
 1Eh 34 BYTEs	workspace

Format of CCB:
Offset	Size	Description
 00h	BYTE	command code
		01h rewind
		05h get block size limits
		08h read
		0Ah write
		10h write file marks
		11h SCSI Space (set position?)
		12h SCSI Inquire
		19h erase
		1Bh load/unload media
 01h	BYTE	flags
		bits 4-0: vary by function
		bits 7-5: logical unit number
 02h	BYTE	"adr_1"
 03h	BYTE	"adr_0"
 04h	BYTE	length
 05h	BYTE	control
	...
 06h/0Ah 14 BYTEs buffer for sense data
--------m-214402-----------------------------
INT 21 U - Qualitas 386MAX v6.00+ - IOCTL INPUT - GET STATE
	AX = 4402h
	BX = file handle for device "386MAX$$"
	CX = number of bytes to read
	DS:DX -> BYTE 03h followed by 386MAX state buffer (see below)
Return: CF clear if successful
	    buffer at DS:DX+1 filled
	    AX = number of bytes actually copied
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Notes:	if the value given in CX is less than the size of the state record
	  (5Ah for v6.01, 66h for v7.00), only a partial state record will be
	  returned
	the state is 40h bytes for 386MAX (actually ASTEMM) v2.20 ("386MAX$$"
	  did not exist yet, use "QMMXXXX0" and then "EMMXXXX0" instead) and
	  56h bytes for v5.11.
	to invoke 386MAX API functions, push DX onto the stack, load DX with
	  the word at offset 25h in the returned state, load all other
	  registers as needed for the desired function, and execute an
	  OUT DX,AL or OUT DX,AX; DX will be set to the pushed value on return
	  if it is not otherwise modified by the API function.	For safety,
	  in case a function is not supported or 386MAX is not present, SP
	  should be saved and restored around the API call.
	Windows 3.1 Standard mode, LAN Manager, and Windows for Workgroups all
	  use the 386MAX API; LAN Manager and Windows for Workgroups reportedly
	  make some calls incorrectly
SeeAlso: AX=4403h/SF=03h"386MAX",INT 67/AH=3Fh

Format of 386MAX v6.01+ state:
Offset	Size	Description
 -1	BYTE	(call) 03h
 00h  6 BYTEs	signature "386MAX"
 06h  4 BYTEs	version string "N;NN" (i.e. "6;01" for v6.01)
 0Ah	WORD	segment of low-memory portion of 386MAX.SYS
 0Ch  2 BYTEs	???
 0Eh	WORD	segment of ??? memory block or 0000h
 10h	WORD	bit flags 1 (see below)
 12h	WORD	(v6.01) starting address of video memory in KB
		(v7.00) low memory size in bytes
 14h  2 BYTEs	???
 16h	WORD	total high DOS memory in KB
 18h  2 BYTEs	???
 1Ah	WORD	available shared memory in KB
 1Ch	WORD	KBytes extended memory used by 386MAX
 1Eh  2 BYTEs	???
 20h	WORD	total extended memory in KB
 22h	WORD	IO port to write (OUT DX,AL) to invoke 386MAX INT 15 functions
 24h	WORD	IO port to write (OUT DX,AL) to invoke 386MAX API functions
 26h	WORD	??? (depends on DOS version)
 28h  2 BYTEs	???
 2Ah	DWORD	machine type (see below)
 2Eh	WORD	???
 30h	WORD	???
 32h	WORD	system configuration flags (see below)
 34h	WORD	debugging flags 1 (see below)
 36h	WORD	debugging flags 2 (see below)
 38h  2 BYTEs	???
 3Ah	WORD	segment of first MCB in high memory chain???
 3Ch	WORD	feature flags 1 (see below)
 3Eh	WORD	feature flags 2 (see below)
 40h	WORD	feature flags 3 (see below)
 42h	WORD	segment of first 386MAX control block??? (see below)
 44h	WORD	amount of memory to report available on INT 15/AH=88h
 46h  4 BYTEs	???
 4Ah	WORD	number of K at start of address space swapped with fast
		extended memory (SWAP= parameter)
 4Ch  2 BYTEs	???
 4Eh	WORD	???
 50h	WORD	debugging flags 3 (see below)
 52h	DWORD	old INT 21h
 56h	DWORD	pointer to 386MAX's EMS (INT 67h) handler
---386MAX v7.00---
 5Ah	DWORD	KB of extended memory managed by 386MAX
 5Eh	DWORD	bytes of extended memory (EXT= parameter)
 62h  4 BYTEs	???

Bitfields for bit flags 1:
 bit 1	???
 bit 2	???
 bit 3	??? (cleared by calling INT 67 functions)
 bit 4	high RAM present???
 bit 5	386MAX in AUTO mode
 bit 6	386MAX enabled
 bit 7	386MAX is providing EMS services
 bit 8	???
 bit 9	A20 enabled??? (see INT 15/AX=2402h)
 bit 10	Weitek support enabled
 bit 11	???
 bit 12	???
 bit 13	QPMS has been used
 bit 14	???
 bit 15	???

Bitfields for system configuration flags:
 bit 1	ROM compressed???
 bit 3	???
 bit 5	386MAX loaded into high memory
 bit 6	Microchannel bus
 bit 7	Weitek math coprocessor detected
 bit 11	PC/XT (thus only single 8259 interrupt controller present, DMA only
		in 1st megabyte, etc)
 bit 13	LMLTOP= specified
 bit 15	???

Bitfields for debugging flags 1:
 bit 0	DEBUG=LED
 bit 1	DEBUG=X67
 bit 2	DEBUG=INV
 bit 3	DEBUG=EMSPTED
 bit 4	DEBUG=JMP
 bit 5	DEBUG=CALL
 bit 6	DEBUG=HLT
 bit 7	DEBUG=PMR
 bit 8	DEBUG=CR3
 bit 9	DEBUG=CAPS or DEBUG=INT
 bit 10	DEBUG=RC
 bit 11	DEBUG=ROM
 bit 12	DEBUG=XM
 bit 13	DEBUG=SOR
 bit 14	DEBUG=XR
 bit 15	DEBUG=EMSERR

Bitfields for debugging flags 2:
 bit 0	DEBUG=ROMSWAP
 bit 1	DEBUG=UNSHADOWROM
 bit 2	DEBUG=COMPROM
 bit 3	DEBUG=DPMIPHYS
 bit 4	DEBUG=ALLROM
 bit 5	DEBUG=VMS
 bit 6	DEBUG=XMS
 bit 7	DEBUG=I06
 bit 8	DEBUG=VCPI
 bit 9	DEBUG=XDMA
 bit 10	DEBUG=X09
 bit 13	DEBUG=I67
 bit 14	DEBUG=EVM
 bit 15 DEBUG=EMSSAVE or DEBUG=VDS

Bitfields for debugging flags 3:
 bit 10	DEBUG=EPM
 bit 12	DEBUG=ABIOS
 bit 13	DEBUG=XMSPTED
 bit 14	DEBUG=TIME
 bit 15	DEBUG=SCRUB

Bitfields for feature flags 1:
 bit 1	Weitek present
 bit 2	no DPMI services
 bit 3	NODMA
 bit 4	TERSE
 bit 5	NOROM
 bit 6	NOPARITY
 bit 8	NOFLEX (IGNOREFLEXFRAME)
 bit 11	don't create UMBs
 bit 12	don't backfill below video memory (NOLOW)
 bit 13	FRAME= specified
 bit 14	EXT= specified
 bit 15	NOEMS, allow prior expanded memory manager to provide EMS

Bitfields for feature flags 2:
 bit 0	UNSHIFT specified (FORCEA20 disabled)
 bit 1	NOXRAM
 bit 2	NOSCSI specified
 bit 3	SCREEN specified
 bit 4	enabled EISADMA
 bit 5	slow DMA
 bit 6	RESETKEYB specified
 bit 7	???
 bit 9	TOP384
 bit 11	NOWARMBOOT
 bit 12	USE= specified
 bit 13	ROM= specified

Bitfields for feature flags 3:
 bit 0	Windows3 support enabled
 bit 1	SHADOWROM
 bit 2	don't compress ROM (NOCOMPROM)
 bit 3	??? (related to PRGREG=)
 bit 4	??? (related to PRGREG=)
 bit 5	SHADOWRAM
 bit 6	DOS4 specified
 bit 7	NOLOADHIGH
 bit 8	NOPULSE
 bit 11	FORCEA20
 bit 12	DMA buffer enabled
 bit 13 NOSCRUB
 bit 15	NOFRAME

Bitfields for machine type:
 bit 12 Amstrad
 bit 13 Epson
 bit 14 Zenith Data Systems
 bit 15	"ASEM"
 bit 16 NEC
 bit 17	"HPRS" model codes 69h and 6Ah
 bit 18 Dell
 bit 19	"CA"
 bit 20	ITT (Xtra Business Systems/Alcatel)
 bit 21	Toshiba 5100
 bit 22	Olivetti
 bit 23	Quadram Quad386 (BIOS model FEh, submodel A6h)
 bit 24	Tandy???
 bit 25	AST 386
 bit 26	INBOARD, ??? version
 bit 27	INBOARD, ??? version
 bit 28	INBOARD, ??? version
 bit 29	"HPRS"
 bit 30	Compaq 386
 bit 31	JET386

Format of 386MAX control block:
Offset	Size	Description
 00h	WORD	segment of next block (FFFFh if last)
 02h	WORD	segment of previous block (FFFFh if first)
 04h 12 BYTEs	filename
 10h	WORD	resident size in paragraphs
 12h	WORD	environment size???
 14h	WORD	real prsent environment size + 1 (0000h if ENVSAVE used)
 16h  2 BYTEs	???
 18h	DWORD	initial size or SIZE=n in 386LOAD commandline
 1Ch	DWORD	SIZE=-1 ???
 20h	DWORD	SIZE= ???
 24h	BYTE	PRGREG= if specified, else FFh
 25h	BYTE	ENVREG= if specified, else FFh
 26h	BYTE	FlexFrame (00h not present, 01h present)
 27h  3 BYTEs	???
 2Ah	BYTE	GROUP= or 00h if not present
 2Bh	BYTE	???
 2Ch	WORD	PSP

Format of high memory info record:
Offset	Size	Description
 00h	WORD	segment address of memory region
 02h	WORD	size of memory region in paragraphs
 04h	BYTE	type or flags???
		00h if locked out
		02h if EMS page frame
		04h if high RAM
		42h if ROM
 05h	BYTE	???

Format of ROM shadowing record:
Offset	Size	Description
 00h	WORD	segment of ROM???
 02h	WORD	segment of ROM???
 04h  2 BYTEs	???
 06h	WORD	size of shadowed ROM in paragraphs
 08h  4 BYTEs	???

Values for memory type:
 00h	unused by EMS
 01h	DOS
 04h	page frame overlapping ROM???
 80h	high memory
 84h	page frame???
 87h	video ROM???
Note:	the type may be 00h (unused) if the 16K page is split among different
	  uses (such as ROM and high RAM)

Call 386MAX API (via OUT DX,AL) with:
	STACK: WORD value for DX
	AH = 01h get high memory information
		ES:DI -> buffer for array of high memory info records
			(see above)
		Return: CX = number of records placed in buffer
	AH = 02h get shadowed ROM info???
		ES:DI -> buffer for array of ROM shadowing records (see above)
		Return: CX = number of records placed in buffer
	AH = 03h get 386MAX state
		ES:DI -> 90-byte buffer for state (see above)
		Return: AH = 00h (successful)
			buffer filled
		Note:	unlike INT 21/AX=4402h"386MAX", this function omits
			  the first byte specifying the state buffer version
	AH = 04h get memory types???
		ES:DI -> buffer for memory type info (array of bytes, one per
			16K page) (see above)
		Return:	CX = number of bytes placed in buffer
	AH = 05h get ???
		AL = A20 control (00h enable A20 first, 01h leave unchanged)
		CX = number of 4K pages to report (0000h for default)
		SI = first K to report (rounded down to 4K page)
		ES:DI -> buffer for returned info on ???
		Return: CX = number of 4K pages reported on
			???
	AH = 06h get memory speed info
		ES:DI -> buffer for memory speed records (see below)
		Return: AH = 00h (successful)
			CX = number of bytes placed in buffer
		Note:	this function can take over a second to execute
	AH = 07h ???
		DX = EMS handle (on stack)
		???
		Return:	???
	AH = 08h "EMM2_GOREAL" check whether possible to disable 386MAX
		AL = ??? (00h or nonzero)
		Return: AH = status (00h OK, A4h not possible at this time)
		Note:	if AL=00h, this function always returns success
	AH = 09h toggle ??? flags
		BX = bitmask of bits of ??? flags (word at state+10h) to toggle
		Return: AH = 00h (successful)
		Note:	enables A20 first
	AH = 0Ah toggle ??? flags
		BX = bitmask of bits of ??? (word at state+32h) to toggle
		Return: AH = 00h (successful)
		Notes:	enabled A20 first
			does ??? if bit 3 on after specified bits are toggled
	AH = 0Bh toggle ??? flags
		BX = bitmask of bits of ??? (word at state+34h) to toggle
		Return: AH = 00h (successful)
		Note:	enables A20 first
	AH = 0Ch toggle ??? flags
		BX = bitmask of bits of ??? (word at state+40h) to toggle
		Return: AH = 00h (successful)
		Note:	enables A20 first
	AH = 0Dh specify 386MAX high-memory location
		BX = segment address of high-memory real-mode portion of 386MAX
		CX = current segment of real-mode stub???
		Return: AH = status (00h successful)
			???
	AH = 0Eh CRT controller register virtualization
		AL = subfunction
		    00h allow access to CRTC I/O ports 03B4h/03B5h, 03D4h/03D5h
		    01h trap accesses to CRTC I/O ports
	AH = 0Fh reboot system
		Return: never
	AH = 11h get high memory information
		ES:DI -> 96-byte buffer for high memory info
		Return: AH = 00h (successful)
			ES:DI buffer filled
		Notes:	each byte in buffer contains bit flags for a 4K page in
			  the A000h-FFFFh region
				bit 0: ???
				bit 1: physical address same as linear address
				bit 2: EMS page frame
				bit 6: ???
			this function can take over a second to execute,
			  because it also tests the memory
	AH = 12h ???
		AL = subfunction
		    00h ???
		    01h ???
		???
		Return: AH = 00h (successful) if AL=00h or 01h
			AH = 8Fh otherwise
	AH = 13h page protection???
		AL = subfunction
		    00h set all ??? 4K pages to read-only???
		    01h set all ??? 4K pages to read-write???
		???
		Return: AH = 00h (successful) if AL=00h or 01h
			AH = 8Fh otherwise
	AH = 14h ???
		ES:DI -> 54-byte buffer for ???
		Return: AH = 00h if successful
			AH = A4h on error
	AH = 15h ???
		???
		Return: ???
	AH = 16h get 386MAX memory usage screen
		ES:DI -> buffer for memory info display
		CX = size of buffer in bytes
		Return:	ES:DI buffer filled with '$'-terminated string (if
				large enough to hold entire usage screen)
		Note:	the screen is 0303h bytes in v7.00
	AH = 17h Windows 3 startup/termination
		AL = subfunction
		    00h Windows3 initializing
			DX (on stack) = Windows startup flags
			DI = Windows version number (major in upper byte)
			ES:BX = 0000h:0000h
			DS:SI = 0000h:0000h
			Return: CX = 0000h if OK for Windows to load
				   <> 0 if Windows should not load
				ES:BX -> startup info structure
				DS:SI -> Virtual86 mode enable/disable callback
		    01h Windows3 terminating
			ES:BX -> ???
			DX (on stack) = Windows exit flags
			Return: ???
	AH = 18h QPMS (Qualitas Protected Memory Services)
		AL = subfunction
		    00h get QPMS configuration
			Return: BX = starting segment of QPMS memory window
				CX = number of 4K pages reserved for QPMS???
				DX = number of 4K pages in QPMS window???
		    01h map QPMS memory page???
			BX = 4K page number within memory reserved for QPMS???
			CL = 4K page number within QPMS memory window???
		    02h mark all QPMS memory read-only
		    03h mark all QPMS memory read-write
		Return: AH = status (00h,8Ah,8Bh,8Fh)
	AH = 19h get linear address for physical address
		EDX = physical address (low word on stack)
		Return: AH = status
			    00h successful
				EDX = linear address at which physical address
					may be accessed
			    8Bh physical address currently not addressable
		Note:	enables A20 first
	AH = 1Ah set page table entry???
		EDX = new page table entry??? (low word on stack)
		ESI = linear address of page???
		Return: AH = status (00h,8Bh)
		Note:	enables A20 first
	AH = 1Bh get ???
		Return: AH = status
			BX = ???
			CX = ???
			EDX = physical address of ???
	AH = 1Ch get original interrupt vector
		AL = interrupt vector (00h-7Fh)
		Return: AH = 00h (successful)
			EDX = original vector before 386MAX loaded (segment in
				high word, offset in low word)
		Note:	no range checking is performed; requests for INTs 80h-
			  FFh will return random values
	AH = 1Dh display string???
		SI = ???
		Return: AH = 00h (successful)
			???
	AH = 1Eh get memory info
		ES:DI -> memory info (see below)
		Return: ???
	AH = 1Fh get DPMI host information
		Return: AX = 0000h if successful
			BX = DPMI flags (see INT 31/AX=0400h)
			CL = CPU type (02h = 80286, 03h = 80386, etc.)
			DX = DPMI ver supported (DH=major, DL=2-digit minor)
			SI = ???
			ES???:DI -> ???
		Note:	NOP if NODPMI switch specified
	AH = 20h (v7.00) ???
	    AL = ???
	    Return: EDX = ??? for ??? AL
	AH = 21h (v7.00) STACKS support
	    AL = 00h get STACKS parameters
		Return: BX = ???
			CX = number of stacks for hardware interrupts
			DX = size of each stack in bytes
			SI = ???
			DI = ???
	    AL = 01h set ??? "EMM2_DSTKS"
		EBX = ???
		ECX = ???
		DS = ???
	    AL = 02h ???
		BL = ??? (00h-03h)
		???
	AH = 22h (v7.00)
	    AL = 00h ???
	    AL = nonzero ???
	    ???
	AH = 23h (v7.00) ???
	    AL = 00h set ???
		???
	    AL = 01h ???
		???
	    AL = 02h get ???
		CX = size of buffer
		ES:DI -> buffer for ???
		Return: CX = number of bytes actually returned
	    AL = 03h set ???
		ES:DI -> buffer containing ASCIZ ???
	    AL = 04h get ???
		ES:DI -> buffer for ASCIZ ???
	AH = 24h (v7.00) ???
	    AL = 00h get ???
		Return: BX = current state of ??? (0/1)
	    AL = 01h set ???
		BX = new state of ??? (0/1)
	    AL = other ???
	AH = 25h (v7.00) ???
	AH = 26h (v7.00) ???
	    Return: BX = ???
		    CX = ???
	AH = 27h (v7.00) ???
	    AL = 00h get ???
		Return: BX = ???
	    AL = 01h ???
		BX = ???
		ES??? = ???
	    AL = 02h ???
		???
	    AL = 03h ???
		CX = ???
		DX = ???
		ES??? = ???
		Return: ???
	AH = 28h (v7.00) get ???
		Return: CX = ???
			DX = ???
	AH = 29h (v7.00) get ???
		Return: AX = ???
	AH = 40h-5Dh EMS services (see INT 67/AH=40h etc)
	AH = DEh VCPI services (see INT 67/AX=DE00h etc)
Return: AH = status (as for EMS INT 67 calls)
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h	undefined function
	    8Ah invalid logical page nuber
	    8Bh illegal physical page number
	    8Fh undefined subfunction
	    A4h access denied
	    etc.
	STACK popped (value placed in DX if no specific return value for DX)

Format of memory speed record:
Offset	Size	Description
 00h	DWORD	page table entry for 4K page
 04h	WORD	number of microticks (840ns units) required for REP LODSD of
		entire 4K page

Format of memory info [array]:
Offset	Size	Description
 00h	DWORD	???
 04h	DWORD	???
 08h  2 BYTEs	???
 0Ah	BYTE	type??? (03h = conventional???)
 0Bh	BYTE	???
--------V-214402-----------------------------
INT 21 - PGS1600.DEV - IOCTL - GET CONFIGURATION INFO
	AX = 4402h
	BX = file handle for device "PGS1600$"
	CX = 0018h (size of buffer)
	DS:DX -> configuration buffer (see below)
Return: CF clear if successful
	    buffer filled
	    AX = number of bytes actually copied
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Program: PGS1600.DEV is a device driver for the Cornerstone Technology PG1600
	  display adapter, which provides a 1600x1200 monochrome display as
	  well as one of two emulations, MDA or CGA.
SeeAlso: AX=4403h"PGS1600"

Format of configuration information:
Offset	Size	Description
 00h	WORD	version (high byte = major, low byte = minor)
 02h	WORD	board initialisation mode
 04h	WORD	board I/O address
		03D0h CGA emulation
		03B0h MDA emulation
		0390h no emulation
		0350h no emulation, alternate
 06h	WORD	emulation buffer segment
		B800h	CGA emulation
		B000h	MDA emulation
		0000h	no emulation
 08h	WORD	PG1600 graphics buffer segment
 0Ah	WORD	number of bytes between consecutive graphic rows
 0Ch	WORD	horizontal pixel size
 0Eh	WORD	vertical pixel size
 10h	WORD	horizontal dots per inch
 12h	WORD	vertical dots per inch
 14h	WORD	graphics buffer bits per pixel
 16h	WORD	monitor bits per pixel
--------N-214402-----------------------------
INT 21 - PC/TCP IPCUST.SYS - RESET CONFIGURATION DATA READ POINTER
	AX = 4402h
	BX = file handle referencing device "$IPCUST"
	CX, DS:DX ignored
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Notes:	there are a total of 378h bytes of configuration data for IPCUST.SYS
	  version 2.05.	 If less than the entire data is read or written,
	  the next read/write continues where the previous one ended; this
	  call and AX=4403h both reset the location at which the next
	  operation starts to zero
	v2.1+ uses a new configuration method, but allows the installation
	  of IPCUST.SYS for backward compatibility with other software which
	  must read the PC/TCP configuration
SeeAlso: AH=3Fh"IPCUST",AH=40h"IPCUST",AX=4403h"IPCUST"
--------N-214402-----------------------------
INT 21 - WORKGRP.SYS - GET API ENTRY POINT
	AX = 4402h
	BX = file handle for device "NET$HLP$"
	CX = 0008h
	DS:DX -> buffer for entry point record
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code
Program: WORKGRP.SYS is distributed with MS-DOS 6.0 to permit communication
	  with PCs running Windows for Workgroups or LAN Manager
SeeAlso: AH=3Fh"WORKGRP.SYS"

Format of entry point record:
Offset	Size	Description
 00h	WORD	3633h  \ signature???
 02h	WORD	EF6Fh  /
 04h	DWORD	address of entry point
Note:	first four bytes of buffer must be 6Fh E9h 33h 36h on entry when using
	  IOCTL rather than READ to get the entry point record

Call WORKGRP entry point with:
	STACK:	WORD	function number (0000h-0009h)
Return: STACK unchanged

Call WORKGRP function 00h with:
	STACK:	WORD	0000h (function "get ???")
Return: DX:AX -> data table

Call WORKGRP function 01h with:
	STACK:	WORD	0001h (function "hook ???")
Return: STACK:	DWORD	pointer to ???
		WORD	0001h (function number)

Call WORKGRP function 02h with:
	STACK:	WORD	0002h (function "unhook ???")
	???
Return: ???

Call WORKGRP function 03h with:
	STACK:	WORD	0003h (function "reenable printer port")
		WORD	LPT port number
Return: ???

Call WORKGRP function 04h with:
	STACK:	WORD	0004h (function "disable printer port")
		WORD	LPT port number
Return: ???

Call WORKGRP function 05h with:
	STACK:	WORD	0005h (function "???")
		???
Return: ???

Call WORKGRP function 06h with:
	STACK:	WORD	0006h (function "???")
Return: STACK unchanged
	AX = 0000h
	DX = 0000h

Call WORKGRP functions 07h-09h with:
	STACK:	WORD	0007h-0009h (NOP functions)
Return: STACK unchanged
	AX = 0001h
	DX = 0000h
--------N-214402-----------------------------
INT 21 - 10NET v5.0 - 10BEUI.DOS - API
	AX = 4402h
	BX = file handle referencing device "10BEUI$"
	DS:DX -> parameter record (see below)
	CX ignored
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4402h"10MEMMGR",INT 6F/AH=00h"10NET"

Format of parameter record:
Offset	Size	Description
 00h	WORD	000Ah (function number???)
 02h	WORD	???
 04h	DWORD	pointer to buffer for ???
 08h  4 BYTEs	???
 0Ch	WORD	transfer size
--------N-214402-----------------------------
INT 21 - 10NET v5.0 - 10MEMMGR.SYS - API
	AX = 4402h
	BX = file handle referencing device "MEMMGR0$"
	DS:DX -> 6-byte buffer for interface info (see below)
	CX ignored
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4402h"10BEUI",INT 6F/AH=00h"10NET"

Format of interface info:
Offset	Size	Description
 00h	DWORD	address of entry point (see below)
 04h	WORD	version (0500h for v5.00)

Call entry point with:
	AL = 01h ???
	    BX = ???
	    Return: CF clear if successful
		    CF set on error
			AX = error code
	AL = 02h ???
	    ???
	AL = 03h ???
	    ???
	AL = 04h set/restore memory allocation strategy
	    BX = subfunction
		0000h set strategy
		0001h restore strategy
	    Return: CF clear if successful
		    CF set on error (if function disabled)
		    various registers destroyed
	AL = other
	    Return: CF set
		    AX = 0000h
		    BL = 01h
--------m-214402SF00-------------------------
INT 21 U - Memory Managers - GET API ENTRY POINT
	AX = 4402h subfn 00h
	BX = file handle for device "EMMXXXX0"
	CX = 0006h (size of buffer in bytes)
	DS:DX -> buffer for API entry point record (see below)
		first byte must be 00h on entry
Return: CF clear if successful
	    buffer filled (see INT 67/AH=3Fh function 1B00h)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Notes:	this function is supported by Microsoft EMM386.EXE v4.45+ and
	  CEMM v5.10+
	if no other program has hooked INT 67, an alternate installation
	  check for CEMM is testing for the string
	  "COMPAQ EXPANDED MEMORY MANAGER 386" at offset 14h in the INT 67
	  handler's segment; if present, the word at offset 12h contains the
	  offset of the API entry point
SeeAlso: AX=4402h/SF=01h,AX=4402h/SF=02h,AX=4402h"EMM386",INT 67/AH=3Fh

Format of API entry point record:
Offset	Size	Description
 00h	WORD	??? (0022h for CEMM 5.11, 0025h for MS EMM386 v4.45)
 02h	DWORD	manager's private API entry point (see below,INT 67/AX=FFA5h)

Call CEMM v5.10+ entry point with:
	AH = 00h get memory manager's state
	    Return: AH = state
			bit 0: turned OFF
			bit 1: AUTO mode enabled
	AH = 01h set memory manager's state
	    AL = new state (00h ON, 01h OFF, 02h AUTO)
	    Return: CF clear if successful
		    CF set on error
	AH = 02h Weitek coprocessor support
	    AL = subfunction
		00h get Weitek support state
		    Return: AL = status
				bit 0: Weitek coprocessor is present
				bit 1: Weitek support is enabled
		01h turn on Weitek support
		02h turn off Weitek support
	    Return: CF clear if successful
		    CF set on error
			AH = error code (01h invalid subfunc, 02h no Weitek)
	AH = 05h get statistics
	    ???
	AH > 06h
	    Return: CF set
		    AH = 01h (invalid function)
Notes:	AH=03h,04h,06h are NOPs which return CF clear, presumably for backwards
	  compatibility with earlier versions of CEMM
	in v5.11, AH=05h merely prints an error message (using INT 21/AH=09h)
	  stating that a different version of CEMM is installed and it is
	  therefore not possible to display the statistics
--------m-214402SF01-------------------------
INT 21 U - Memory Managers - GET EMM IMPORT STRUCTURE ADDRESS
	AX = 4402h subfn 01h
	BX = file handle for device "EMMXXXX0"
	CX = 0006h (size of buffer in bytes)
	DS:DX -> buffer for EMM import structure record (see below)
		first byte must be 01h on entry
Return: CF clear if successful
	    buffer filled (see INT 67/AH=3Fh function 1B00h)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Notes:	this function is supported by Microsoft EMM386.EXE v4.45+,
	  QEMM-386 v6+, and CEMM v5.10+
	for QEMM-386, this call always returns an error if Windows3 support
	  has been disabled with the NW3 switch
SeeAlso: AX=4402h/SF=00h,AX=4402h"EMM386",INT 2F/AX=D201h/BX=5145h
SeeAlso: INT 67/AH=3Fh

Format of EMM import structure record:
Offset	Size	Description
 00h	DWORD	physical address of EMM import structure
 04h	BYTE	EMM import structure major version
 05h	BYTE	EMM import structure minor version
--------m-214402SF02-------------------------
INT 21 U - Memory Managers - GET MEMORY MANAGER VERSION
	AX = 4402h subfn 02h
	BX = file handle for device "EMMXXXX0"
	CX = 0002h (size of buffer in bytes)
	DS:DX -> buffer for memory manager version (see below)
		first byte must be 02h on entry
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	this function is supported by Microsoft EMM386.EXE v4.45+ and
	  CEMM v5.10+
SeeAlso: AX=4402h/SF=00h,AX=4402h"EMM386",INT 67/AH=3Fh

Format of memory manager version:
Offset	Size	Description
 00h	BYTE	major version
 01h	BYTE	minor version (binary)
--------m-214402-----------------------------
INT 21 U - Microsoft EMM386.EXE v4.45 - GET MEMORY MANAGER INFORMATION
	AX = 4402h
	BX = file handle for device "EMMXXXX0"
	CX = size of buffer in bytes (varies, see below)
	DS:DX -> buffer for returned data (see below)
		first byte must be set on entry to indicate desired data
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	an error is returned if the number of bytes to be read does not match
	  the number of bytes returned for the specified data item
SeeAlso: AX=4402h/SF=00h,AX=4402h/SF=01h,AX=4402h/SF=02h,INT 67/AX=FFA5h

Format of data buffer:
Offset	Size	Description
 00h	BYTE	(call) function
		03h get ???
		04h get ???
---function 03h---
 00h	WORD	???
 02h	WORD	???
---function 04h---
 00h	WORD	segment of UMB containing EMM386 code/data
 02h	WORD	number of paragraphs of EMM386 code/data in UMB
 04h	WORD	???
--------V-214402-----------------------------
INT 21 - Compaq AG1024.SYS - RGDI - GET DRIVER LOCATION
	AX = 4402h
	BX = file handle for device "$$$$RGDI"
	CX = 0006h (size of returned data)
	DS:DX -> location record (see below)
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Program: AG1024.SYS is a device driver for the Advanced Graphics 1024 adapter
SeeAlso: AX=4403h"RGDI"

Format of location record:
Offset	Size	Description
 00h	WORD	signature 55AAh
 02h	WORD	segment of ???
 04h	WORD	segment of device driver's code
--------N-214402-----------------------------
INT 21 - FTPSOFT.DOS - GET ???
	AX = 4402h
	BX = file handle for device "FTPSOFT$"
	CX = size of buffer
	DS:DX -> buffer for data (see below)
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AH=3Fh"PC/TCP"

Format of data:
Offset	Size	Description
 00h	WORD	(call) BA98h (if different, no data returned)
 02h	DWORD	-> ???
 06h	DWORD	(call) -> record with new data (see below)
 0Ah	DWORD	-> ???
 0Eh	DWORD	???
 12h	DWORD	-> ??? function
 16h	BYTE	???

Format of new data:
Offset	Size	Description
 00h  8 BYTEs	???
 08h	WORD	??? \ may be a DWORD
 0Ah	WORD	??? /
 0Ch	DWORD	???
 10h	DWORD	???
 14h	DWORD	???
 18h	DWORD	???
 1Ch	DWORD	???
--------D-214403-----------------------------
INT 21 - DOS 2+ - IOCTL - WRITE TO CHARACTER DEVICE CONTROL CHANNEL
	AX = 4403h
	BX = file handle referencing character device
	CX = number of bytes to write
	DS:DX -> data to write
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Notes:	format of data is driver-specific (see below for some specific cases)
	if the file handle refers to "4DOSSTAK", the 4DOS (v2.x-3.03)
	  KEYSTACK.SYS driver will push the specified characters on the
	  keyboard stack; similarly for "NDOSSTAK", the NDOS KEYSTACK.SYS
	  driver will push the characters onto the keyboard stack
SeeAlso: AX=4400h,AX=4402h,AX=4405h,INT 2F/AX=122Bh,INT 2F/AX=D44Dh
SeeAlso: INT 2F/AX=D44Fh
--------c-214403-----------------------------
INT 21 - SMARTDRV.SYS - IOCTL - CACHE CONTROL
	AX = 4403h
	BX = handle for device "SMARTAAR"
	CX = number of bytes to write
	DS:DX -> SMARTDRV control block (see below)
Return: CF clear if successful
	    AX = number of bytes actually written
	       = 0000h if control block too small for given command
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4402h"SMARTDRV",INT 2F/AX=4A10h/BX=0000h

Format of SMARTDRV control block:
Offset	Size	Description
 00h	BYTE	function code
		00h flush cache
		01h flush and discard cache
		02h disable caching (flushes and discards cache first)
		03h enable caching
		04h control write caching
		05h set flushing tick count
		06h lock cache contents
		07h unlock cache contents
		08h set flush-on-reboot flag
		09h unused
		0Ah control full-track caching
		0Bh reduce cache size
		0Ch increase cache size
		0Dh set INT 13 chain address
---function 04h---
 01h	BYTE	write caching control action
		00h turn off write-through
		01h turn on write-through
		02h turn off write buffering (also flushes cache)
		03h turn on write buffering (also flushes cache)
---function 05h---
 01h	WORD	number of timer ticks between cache flushes
---function 08h---
 01h	BYTE	new flush-on-reboot flag (00h off, 01h on)
---function 0Ah---
 01h	BYTE	full-track writes are
		00h not cached
		01h cached
---functions 0Bh,0Ch---
 01h	WORD	number of 16K pages by which to increase/reduce cache size
---function 0Dh---
 01h	DWORD	new address to which to chain on INT 13
Note:	the previous address is not preserved
--------d-214403-----------------------------
INT 21 - CD-ROM device driver - IOCTL OUTPUT
	AX = 4403h
	BX = file handle referencing character device for CD-ROM driver
	CX = number of bytes to write
	DS:DX -> control block (see below)
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4402h"CD-ROM",INT 2F/AX=0802h

Format of control block:
Offset	Size	Description
 00h	BYTE	function code
		00h eject disk
		01h lock/unlock door
		02h reset drive
		03h control audio channel
		04h write device control string
		05h close tray
---functions 00h,02h,05h---
 no further fields
---function 01h---
 01h	BYTE	lock function
		00h unlock door
		01h lock door
---function 03h---
 01h	BYTE	input channel (0-3) for output channel 0
 02h	BYTE	volume for output channel 0
 03h	BYTE	input channel (0-3) for output channel 1
 04h	BYTE	volume for output channel 1
 05h	BYTE	input channel (0-3) for output channel 2
 06h	BYTE	volume for output channel 2
 07h	BYTE	input channel (0-3) for output channel 3
 08h	BYTE	volume for output channel 3
Note:	output channels 0 and 1 are left and right, 2 and 3 are left prime and
	  right prime; a volume of 00h is off
---function 04h---
 01h  N BYTEs	bytes to send directly to the CD-ROM drive without
		interpretation
--------d-214403-----------------------------
INT 21 - Brian Antoine Seagate ST-01 SCSI.SYS - IOCTL - EXECUTE COMMANDS
	AX = 4403h
	BX = handle for device "SCSITAPE"
	CX = number of bytes to write
	DS:DX -> SCSITAPE control block (see below)
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4405h"ST-01",INT 78/AH=10h

Format of SCSITAPE control block:
Offset	Size	Description
 00h	WORD	command type
		'F' Format (argument 1 = interleave, argument 2 = format type)
		'E' Erase
		'R' Rewind
		'L' Load
		'N' No Load
		'S' Space (argument 1 = count, argument 2 = type)
		'M' File Mark (argument 1 = count)
		'A' Reassign
 02h	WORD	argument 1
 04h	WORD	argument 2
 06h	WORD	segment of command buffer
 08h	WORD	offset of command buffer
 0Ah	WORD	length of command buffer
--------E-214403-----------------------------
INT 21 U - AI Architects - OS/x86??? - API
	AX = 4403h
	BX = handle for device "AIA_OS"
	CX = number of bytes to write (ignored)
	DS:DX -> 12-byte buffer, first byte is command:
			81h installation check
			82h get API entry point
			84h uninstall
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Ch,0Dh) (see AH=59h)
Notes:	these functions are only available if the DOS extender was loaded as a
	  device driver in CONFIG.SYS
	called by TKERNEL (a licensed version of AI Architects/Ergo OS/x86)
SeeAlso: INT 2F/AX=FBA1h/BX=0081h,INT 2F/AX=FBA1h/BX=0082h
Index:	installation check;OS/x86|entry point;OS/x86|uninstall;OS/x86

Format of buffer on return:
Offset	Size	Description
 00h  4 BYTEs	signature "IABH"
---if func 81h---
 (no additional fields)
---if func 82h---
 04h	DWORD	pointer to API entry point (see INT 2F/AX=FBA1h/BX=0082h)
---if func 84h---
 04h	WORD	success indicator
 06h	WORD	segment of ???
 08h	WORD	segment of ??? memory block to free if nonzero
 0Ah	WORD	segment of ??? memory block to free if nonzero
--------V-214403-----------------------------
INT 21 - PGS1600.DEV - IOCTL - SET CONFIGURATION???
	AX = 4403h
	BX = file handle for device "PGS1600$"
	CX = 0018h (size of buffer)
	DS:DX -> configuration buffer (see AX=4402h"PGS1600")
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Program: PGS1600.DEV is a device driver for the Cornerstone Technology PG1600
	  display adapter, which provides a 1600x1200 monochrome display as
	  well as one of two emulations, MDA or CGA.
SeeAlso: AX=4402h"PGS1600"
--------N-214403-----------------------------
INT 21 - PC/TCP IPCUST.SYS - RESET CONFIGURATION DATA READ POINTER
	AX = 4403h
	BX = file handle referencing device "$IPCUST"
	CX, DS:DX ignored
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Notes:	there are a total of 378h bytes of configuration data for IPCUST.SYS
	  version 2.05.	 If less than the entire data is read or written,
	  the next read/write continues where the previous one ended; this
	  call and AX=4402h both reset the location at which the next
	  operation starts to zero
	v2.1+ uses a new configuration method, but allows the installation
	  of IPCUST.SYS for backward compatibility with other software which
	  must read the PC/TCP configuration
SeeAlso: AH=3Fh"IPCUST",AH=40h"IPCUST",AX=4402h"IPCUST"
--------V-214403-----------------------------
INT 21 - Compaq AG1024.SYS - CPQ_MGES - IOCTL OUTPUT
	AX = 4403h
	BX = file handle referencing device "CPQ_MGES"
	DS:DX -> request packet (see below)
	CX ignored
Return: CF clear if successful
	    AX destroyed
	    data buffer filled (if applicable)
	    first word of request packet set to number of bytes of data
	      available (amount returned is smaller of this and requested
	      amount)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Program: AG1024.SYS is a device driver for the Advanced Graphics 1024 adapter
SeeAlso: AX=4403h"RGDI"

Format of request packet:
Offset	Size	Description
 00h	WORD	function
		0000h get ??? (26h bytes)
		0001h get ??? (36h bytes)
		0002h set ??? (same as returned by function 0001h)
		0003h get ??? (6 bytes)
		0004h get ???
		0005h get ???
		0006h get ??? (10h bytes)
		0007h set ??? (same as returned by function 0006h)
---functions 00h-03h,06h,07h---
 02h	WORD	size of data buffer
 04h	DWORD	-> buffer for function's data
 ---functions 04h,05h---
 02h	WORD	???
 04h	WORD	size of data buffer
 06h	DWORD	-> buffer to receive data
--------V-214403-----------------------------
INT 21 - Compaq AG1024.SYS - RGDI - IOCTL OUTPUT
	AX = 4403h
	BX = file handle referencing device "$$$$RGDI"
	DS:DX -> request packet (see below)
	CX ignored
Return: CF clear if successful
	    AX destroyed
	    data buffer filled (if applicable)
	    first word of request packet set to number of bytes of data
	      available (amount returned is smaller of this and requested
	      amount)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Program: AG1024.SYS is a device driver for the Advanced Graphics 1024 adapter
SeeAlso: AX=4402h"RGDI",AX=4403h"CPQ_MGES"

Format of request packet:
Offset	Size	Description
 00h	WORD	function
		0000h get entry points
		0001h get ???
 02h	DWORD	address of buffer for returned data
----------214403SF01-------------------------
INT 21 U - Qualitas 386MAX v6.01+ - TURN 386MAX OFF
	AX = 4403h subfn 01h
	BX = handle for device "386MAX$$"
	DS:DX -> BYTE 01h
	CX ignored
Return: DS:DX -> BYTE status (00h = successful)
	CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	this function will fail if any EMS or UMBs are in use
SeeAlso: AX=4403h/SF=02h,AX=4403h/SF=03h,AX=4403h/SF=05h
----------214403SF02-------------------------
INT 21 U - Qualitas 386MAX v6.01+ - TURN 386MAX ON
	AX = 4403h subfn 02h
	BX = handle for device "386MAX$$"
	DS:DX -> BYTE 02h
	CX ignored
Return: DS:DX -> BYTE status (00h = successful)
	CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4403h/SF=01h,AX=4403h/SF=03h,AX=4403h/SF=05h
--------m-214403SF03-------------------------
INT 21 U - Qualitas 386MAX v6.01+ - SET STATE
	AX = 4403h subfn 03h
	BX = handle for device "386MAX$$"
	CX = number of bytes to copy (up to size of state buffer)
	DS:DX -> BYTE 03h followed by state buffer (see AX=4402h"386MAX")
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	the first byte of the buffer must be either 01h, 02h, or 03h
	  (specifying the version of the state record) and the buffer must
	  contain CX bytes AFTER the initial byte
SeeAlso: AX=4402h"386MAX"
----------214403SF05-------------------------
INT 21 U - Qualitas 386MAX v7.00+ - LIMIT AUTOMATIC ACTIVATION TO STD EMS CALLS
	AX = 4403h subfn 05h
	BX = handle for device "386MAX$$"
	DS:DX -> BYTE 05h
	CX ignored
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Desc:	specifies that 386MAX will only shift from AUTO to ON mode on standard
	  EMS calls INT 67/AH=40h-5Dh
SeeAlso: AX=4403h/SF=02h,AX=4403h/SF=03h,AX=4403h/SF=06h
----------214403SF06-------------------------
INT 21 U - Qualitas 386MAX v7.00+ - ALLOW AUTOMATIC ACTIVATION ON ANY INT 67
	AX = 4403h subfn 06h
	BX = handle for device "386MAX$$"
	DS:DX -> BYTE 06h
	CX ignored
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Desc:	specified that 386MAX should shift from AUTO to ON mode on any INT 67
	  call other than INT 67/AH=3Fh
SeeAlso: AX=4403h/SF=01h,AX=4403h/SF=03h,AX=4403h/SF=05h
--------D-214404-----------------------------
INT 21 - DOS 2+ - IOCTL - READ FROM BLOCK DEVICE CONTROL CHANNEL
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc.)
	CX = number of bytes to read
	DS:DX -> buffer
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	format of data is driver-specific
SeeAlso: AX=4402h,AX=4405h,INT 2F/AX=122Bh
--------d-214404-----------------------------
INT 21 - Stacker - GET DEVICE DRIVER ADDRESS AND SET VOLUME NUMBER
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc.)
	CX = 0004h
	DS:DX -> DWORD buffer to receive device driver address
Note:	In addition to returning the address of the Stacker device driver,
	  this call also sets the volume number at offset 3Eh in the device
	  driver (see INT 25/AX=CDCDh)
SeeAlso: INT 25/AX=CDCDh
--------d-214404-----------------------------
INT 21 - Stacker - GET STACVOL FILE SECTORS
	AX = 4404h
	BL = drive number (0 is current drive)
	CX = byte count (i.e., 200h = 1 sector)
	DS:DX -> buffer (see below)
Return: Data Buffer contains the number of sectors requested from the
	  STACVOL physical file for the drive specified.

Format of stacker buffer:
Offset	Size	Description
 00h	WORD	01CDh
 02h	WORD	sector count
 04h	DWORD	number of starting sector
 08h	DWORD	far pointer to Data Buffer
--------d-214404-----------------------------
INT 21 - DUBLDISK.SYS v2.6 - GET INFO
	AX = 4404h
	BL = drive number of DoubleDisk drive (00h = default, 01h = A:, etc.)
	CX = number of bytes (000Ah-0014h, call ignored otherwise)
	DS:DX -> data record (see below)
Return: CF clear if successful
	    AX = number of bytes read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Program: DUBLDISK.SYS is the device driver portion of DoubleDisk, a disk
	  expander by Vertisoft Systems, Inc.
Note:	the installation check consists of scanning memory for the signature
	  "FAT 2.6  byte:", which is immediately followed by a data table
SeeAlso: AX=440Dh
Index:	installation check;DUBLDISK.SYS

Format of data record:
Offset	Size	Description
 00h	WORD	(call) signature 4444h
 02h	BYTE	(call) function
			00h ???
			01h ???
---function 00h---
 02h	BYTE	(return) ???
 03h	BYTE	(return) ???
---function 01h---
 02h	WORD	(return) 4444h
 04h	WORD	allocation unit size???
 06h	WORD	???
 08h	WORD	???
 0Ah	BYTE	???

Format of signature data table:
Offset	Size	Description
 00h  5 BYTEs	???
 05h	BYTE	first drive number
 06h	BYTE	number of drives
 07h	???
--------d-214404-----------------------------
INT 21 - DBLSPACE.BIN - IOCTL - FLUSH OR INVALIDATE INTERNAL CACHES
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = 000Ah (size of DSPACKET structure)
	DS:DX -> DSPACKET structure (see below)
Return: CF clear if IOCTL successful -- check DSPACKET for actual status
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4405h"DBLSPACE",INT 2F/AX=4A11h/BX=0000h

Format of DSPACKET structure:
Offset	Size	Description
 00h	WORD	signature 444Dh ("DM")
 02h	BYTE	command code
		46h ('F') flush internal caches
		49h ('I') flush and invalidate internal caches
 03h	WORD	result code
		(return) 4F4Bh ("OK") if successful, else unchanged
 05h  5 BYTEs	padding
--------d-214404-----------------------------
INT 21 U - xDISK v3.31 - CONFIGURE
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = 0047h (length of version string)
	DS:DX -> 79-byte buffer for version string and ???
	DS:0081h = commandline containing new switches for driver
Return: CF clear if successful
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Program: xDISK is a shareware resizeable EMS RAMdisk by FM de Monasterio
SeeAlso: AX=4405h"xDISK",INT 2F/AH=DDh"xDISK"
----------214404-----------------------------
INT 21 - COMBI-disk v1.13 - GET DATA RECORD
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc)
	CX =  (length of data packet)
	DS:DX -> buffer for data packet (see below)
Return: CF clear if successful
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Program: COMBI-disk is a shareware combination cache and RAMdisk sharing a
	  single pool of memory by Vadim V. Vlasov
Note:	the installation check consists of scanning the valid drives for one
	  which returns a correctly-sized data packet with the proper
	  signature in the first field
SeeAlso: AX=4405h"COMBI"
Index:	installation check;COMBI-disk

Format of data packet:
Offset	Size	Description
 00h  6 BYTEs	ASCIZ signature "COMBI"
 06h	WORD	version (high byte = major, low = decimal minor version)
 08h	BYTE	current options (see below)
 09h	BYTE	sectors per allocation block
 0Ah	WORD	maximum buffer in KB
 0Ch	WORD	current buffer in KB (less than max if XMS memory being lent)
 0Eh	WORD	total number of allocation blocks
 10h	WORD	current number of allocation blocks
 12h	WORD	number of blocks being used by RAM disk
 14h	WORD	number of blocks being used by cache or unused
 16h	WORD	number of dirty cache blocks
 18h	WORD	number of blocks which could not be written out due to errors
 1Ah	WORD	total number of read requests
 1Ch	WORD	total number of sectors read
 1Eh	WORD	number of BIOS read requests (cache misses)
 20h	WORD	number of sectors read via BIOS (cache misses)
 22h	WORD	total number of write requests
 24h	WORD	total number of sectors written
 26h	WORD	number of BIOS write requests
 28h	WORD	number of sectors written via BIOS
 2Ah	WORD	number of RAM disk read requests
 2Ch	WORD	number of sectors read from RAM disk
 2Eh	WORD	number of RAM disk write requests
 30h	WORD	number of sectors written to RAM disk
--------D-214405-----------------------------
INT 21 - DOS 2+ - IOCTL - WRITE TO BLOCK DEVICE CONTROL CHANNEL
	AX = 4405h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = number of bytes to write
	DS:DX -> data to write
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	format of data is driver-specific
SeeAlso: AX=4403h,AX=4404h,INT 2F/AX=122Bh
--------d-214405-----------------------------
INT 21 - Brian Antoine Seagate ST-01 SCSI.SYS - IOCTL - EXECUTE COMMANDS
	AX = 4405h
	BX = drive number (00h = default, 01h = A:, etc)
	CX = number of bytes to write
	DS:DX -> SCSIDISK control block (see AX=4403h"ST-01")
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4403h"ST-01"
--------d-214405-----------------------------
INT 21 U - DBLSPACE.BIN - IOCTL - FLUSH OR INVALIDATE INTERNAL CACHES
	AX = 4405h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = 000Ah (size of DSPACKET structure)
	DS:DX -> DSPACKET structure (see below)
Return: CF clear if IOCTL successful -- check DSPACKET for actual status
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	this call is identical to the documented AX=4404h
SeeAlso: AX=4404h"DBLSPACE",INT 2F/AX=4A11h/BX=0000h

Format of DSPACKET structure:
Offset	Size	Description
 00h	WORD	signature 444Dh ("DM")
 02h	BYTE	command code
		46h ('F') flush internal caches
		49h ('I') flush and invalidate internal caches
 03h	WORD	result code
		(return) 4F4Bh ("OK") if successful, else unchanged
 05h  5 BYTEs	padding
--------d-214405-----------------------------
INT 21 U - xDISK v3.31 - ???
	AX = 4405h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = number of bytes to write
	DS:DX -> buffer containing version string
	???
Return: CF clear if successful
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Program: xDISK is a shareware resizeable EMS RAMdisk by FM de Monasterio
SeeAlso: AX=4404h"xDISK",INT 2F/AH=DDh"xDISK"
--------d-214405-----------------------------
INT 21 - COMBI-disk v1.13 - CONTROL COMBI-disk
	AX = 4405h
	BL = drive number (00h = default, 01h = A:, etc) for RAM disk
	CX = number of bytes to write
	DS:DX -> buffer containing command packet (see below)
Return: CF clear if successful
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4404h"COMBI"

Format of command packet:
Offset	Size	Description
 00h	WORD	version
 02h	BYTE	command code
		80h flush cache
		81h change options byte
		82h shrink memory
		83h expand memory
		84h get dirty block information
		85h reset write errors
		86h reset counters
---command code 81h---
 03h	BYTE	new options byte (see below)
---command code 82h---
 03h	WORD	number of KB to release
---command code 83h---
 03h	WORD	number of KB to expand
---command code 84h---
 03h	DWORD	-> buffer for block info (see below)
---command code 85h---
 03h	DWORD	block ID
---command code 86h---
 03h	BYTE	which counters to reset
		bit 0: hard disk read counts
		bit 1: hard disk write counts
		bit 2: RAM disk read/write counts
Note:	multiple commands may be placed in a single packet by stringing
	  together as many command/argument pairs as desired

Bitfields for options byte:
 bit 0	cache off
 bit 1	cache frozen
 bit 2	write caching enabled
 bit 3	delayed writing disabled
 bit 5	fix memory allocation (no XMS lending)
 bit 6	no 'sector not found' error

Format of block info:
Offset	Size	Description
 00h	DWORD	block ID
 04h	BYTE	bitmask of valid sectors in block
 05h	BYTE	bitmask of dirty sectors in block
 06h	BYTE	last error returned by BIOS
 07h	BYTE	number of errors
--------D-214406-----------------------------
INT 21 - DOS 2+ - IOCTL - GET INPUT STATUS
	AX = 4406h
	BX = file handle
Return: CF clear if successful
	    AL = input status
		00h not ready (device) or at EOF (file)
		FFh ready
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	files may not register as being at EOF if positioned there by AH=42h
SeeAlso: AX=4407h,INT 2F/AX=122Bh
--------D-214407-----------------------------
INT 21 - DOS 2+ - IOCTL - GET OUTPUT STATUS
	AX = 4407h
	BX = file handle
Return: CF clear if successful
	    AL = input status
		00h not ready
		FFh ready
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	for DOS 2+, files are always ready for output, even if the disk is
	  full or no media is in the drive
SeeAlso: AX=4406h,INT 2F/AX=122Bh
--------D-214408-----------------------------
INT 21 - DOS 3.0+ - IOCTL - CHECK IF BLOCK DEVICE REMOVABLE
	AX = 4408h
	BL = drive number (00h = default, 01h = A:, etc)
Return: CF clear if successful
	    AX = 0000h if removable
	       = 0001h if fixed
	CF set on error
	    AX = error code (01h,0Fh) (see AH=59h)
SeeAlso: AX=4400h,AX=4409h,INT 2F/AX=122Bh
--------D-214409-----------------------------
INT 21 - DOS 3.1+ - IOCTL - CHECK IF BLOCK DEVICE REMOTE
	AX = 4409h
	BL = drive number (00h = default, 01h = A:, etc)
Return: CF clear if successful
	    DX = device attribute word
		bit 15: drive is SUBSTituted
		bit 12: drive is remote
		bit  9: direct I/O not allowed
	CF set on error
	    AX = error code (01h,0Fh) (see AH=59h)
Note:	on local drives, DX bits not listed above are the attribute word from
	  the device driver header (see AH=52h); for remote drives, the other
	  bits appear to be undefined for DOS versions prior to 5.0 (they are
	  all cleared in DOS 5+)
SeeAlso: AX=4400h,AX=4408h,AX=440Ah,INT 2F/AX=122Bh
--------D-21440A-----------------------------
INT 21 - DOS 3.1+ - IOCTL - CHECK IF HANDLE IS REMOTE
	AX = 440Ah
	BX = handle
Return: CF clear if successful
	    DX = attribute word (as stored in SFT)
		bit 15: set if remote
		bit 14: date/time not set on close
	CF set on error
	    AX = error code (01h,06h) (see AH=59h)
Notes:	if file is remote, Novell Advanced NetWare 2.0 returns the number of
	  the file server on which the handle is located in CX
	DR-DOS 3.41 and 5.0 clear all bits of DX except bit 15
SeeAlso: AX=4400h,AX=4409h,AH=52h,INT 2F/AX=122Bh
--------D-21440B-----------------------------
INT 21 - DOS 3.1+ - IOCTL - SET SHARING RETRY COUNT
	AX = 440Bh
	CX = pause between retries (default 1)
	DX = number of retries (default 3)
Return: CF clear if successful
	CF set on error
	    AX = error code (01h) (see AH=59h)
Notes:	delay is dependent on processor speed (value in CX specifies number of
	  64K-iteration empty loops to execute)
	if DX=0000h on entry, the retry count is left unchanged
SeeAlso: AH=52h,INT 2F/AX=1224h,INT 2F/AX=122Bh
--------D-21440C-----------------------------
INT 21 - DOS 3.2+ - IOCTL - GENERIC CHARACTER DEVICE REQUEST
	AX = 440Ch
	BX = device handle
	CH = category code
	    00h unknown (DOS 3.3+)
	    01h COMn: (DOS 3.3+)
	    03h CON (DOS 3.3+)
	    05h LPTn:
	    9Eh Media Access Control driver (STARLITE)
	    00h-7Fh reserved for Microsoft
	    80h-FFh reserved for OEM/user-defined
	CL = function
	    00h MAC driver Bind (STARLITE)
	    45h set iteration (retry) count
	    4Ah select code page
	    4Ch start code-page preparation
	    4Dh end code-page preparation
	    5Fh set display information (DOS 4+)
	    65h get iteration (retry) count
	    6Ah query selected code page
	    6Bh query prepare list
	    7Fh get display information (DOS 4+)
	DS:DX -> parameter block (see below)
	SI = parameter to pass to driver (European MS-DOS 4.0, OS/2 comp box)
	DI = parameter to pass to driver (European MS-DOS 4.0, OS/2 comp box)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    DS:DX -> iteration count if CL=65h
	    SI = returned value (European MS-DOS 4.0, OS/2 comp box)
	    DI = returned value (European MS-DOS 4.0, OS/2 comp box)
Notes:	bit assignments for function code in CL:
		bit 7: set to ignore if unsupported, clear to return error
		bit 6: set if passed to driver, clear if intercepted by DOS
		bit 5: set if queries data from device, clear if sends command
		bits 4-0: subfunction
	DR-DOS 3.41 and 5.0 return error code 16h on CL=45h,65h if the device
	  does not support a retry counter
SeeAlso: AX=440Dh,INT 2F/AX=0802h,INT 2F/AX=122Bh,INT 2F/AX=14FFh
SeeAlso: INT 2F/AX=1A01h

Format of parameter block for function 00h:
Offset	Size	Description
 00h  8 BYTEs	ASCIZ signature "STARMAC"
 08h	WORD	version
 0Ah	WORD	flags
		bit 0: media requires connect or listen request before use
		bit 1: network is a LAN (broadcast/multicast supported)
		bit 2: point-to-point network
 0Ch	WORD	handle for use with MAC driver's private interface (filled in
		by MAC driver)
 0Eh	WORD	context
 10h	WORD	approximate speed in KB/sec (filled in by MAC driver)
 12h	WORD	approximate cost in cents per hour (filled in by MAC driver)
 14h	WORD	maximum packet size in bytes (filled in by MAC driver)
 16h	WORD	addressing format (filled in by MAC driver)
		0000h general addressing
		0001h Ethernet addressing
		0002h Token Ring addressing
		0003h Token Bus addressing
 18h	DWORD	Send entry point (filled in by MAC driver)
 1Ch	DWORD	RegisterEventHandler entry point (filled in by MAC driver)
 20h	DWORD	SetPacketFilter entry point (filled in by MAC driver)
 24h	DWORD	UnBind entry point (filled in by MAC driver)

Format of parameter block for function 45h:
Offset	Size	Description
 00h	WORD	number of times output is attempted before driver assumes
		device is busy

Format of parameter block for functions 4Ah and 6Ah:
Offset	Size	Description
 00h	WORD	length of data
 02h	WORD	code page ID
 04h 2N BYTEs	DCBS (double byte character set) lead byte range
		  start/end for each of N ranges (DOS 4.0)
	WORD	0000h  end of data (DOS 4.0)

Format of parameter block for function 4Ch:
Offset	Size	Description
 00h	WORD	flags
		DISPLAY.SYS = 0000h
		PRINTER.SYS bit 0 clear to prepare downloaded font, set to
			prepare cartridge selection
 02h	WORD	length of remainder of parameter block
 04h	WORD	number of code pages following
 06h  N WORDs	code page 1,...,N

Format of parameter block for function 4Dh:
Offset	Size	Description
 00h	WORD	length of data
 02h	WORD	code page ID

Format of parameter block for functions 5Fh and 7Fh:
Offset	Size	Description
 00h	BYTE	level (0 for DOS 4.x-6.0)
 01h	BYTE	reserved (0)
 02h	WORD	length of following data (14)
 04h	WORD	control flags
		  bit 0 set for blink, clear for intensity
		  bits 1 to 15 reserved
 06h	BYTE	mode type (1=text, 2=graphics)
 07h	BYTE	reserved (0)
 08h	WORD	colors
		   0 = monochrome
		   else N bits per pixel
 0Ah	WORD	pixel columns
 0Ch	WORD	pixel rows
 0Eh	WORD	character columns
 10h	WORD	character rows

Format of parameter block for function 6Bh:
Offset	Size	Description
 00h	WORD	length of following data
 02h	WORD	number of hardware code pages
 04h  N WORDs	hardware code pages 1,...,N
	WORD	number of prepared code pages
      N WORDs	prepared code pages 1,...,N
--------d-21440C-----------------------------
INT 21 - Greg Shenaut ASPITAPE.SYS - INTERFACE
	AX = 440Ch
	BX = device handle
	CH = category code
	    07h tape (ASPITAPE.SYS)
	CL = function
	    01h "mtop" - perform tape operation
	    02h "mtget" - get tape status
	    03h ignore end-of-tape errors
	    04h enable end-of-tape errors
	DS:DX -> parameter block (see below)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    DS:DX -> data block
Notes:	This device driver is a simple DOS interface to the Adaptec Advanced
	  SCSI Programming Interface (ASPI).  It provides the following device
	  names as access to the SCSI tape, 'RMTx' (rewind on close) and
	  'NRMTx' (NO rewind on close) where x can go from 0 to 3.  There may
	  also be the following names 'MTx' and 'NMTx' which default to 1024
	  byte blocks.	The names may also have a '$' appended to try and make
	  them unique from file names of 'RMT0' etc.
	once opend these devices must be put into RAW mode
SeeAlso: AX=4402h"ASPI"

Format of mtop parameter block:
Offset	Size	Description
 00h	WORD	operation code
		00h "MTWEOF" - write an end-of-file record
		01h "MTFSF" - forward space file
		02h "MTBSF" - backward space file
		03h "MTFSR" - forward space record
		04h "MTBSR" - backward space record
		05h "MTREW" - rewind
		06h "MTOFFL" - rewind and unload
		07h "MTNOP" - perform TEST UNIT READY
 02h	DWORD	repetition count

Format of mtget parameter block:
Offset	Size	Description
 00h	BYTE	ASPI host ID
 01h	BYTE	SCSI target ID
 02h	BYTE	SCSI logical unit number
 03h	BYTE	device parameters
		bit 0: drive must use fixed-block read and write
		bit 7: drive is an ASPI device
 04h	BYTE	current device state (see below)
 05h	BYTE	unit number within driver
 06h	WORD	fixed block blocksize
 08h	BYTE	last SCSI status
 09h	BYTE	last SCSI sense key
 0Ah	WORD	last SCSI opcode (packed)
		bits 0-7: SCSI operation (SCSI packet byte 0)
		bits 8-10: SCSI flags (SCSI packet byte 1)
		bits 11-12: ASPI "Direction Bits" (ASPI SRB byte 3)
 0Ch	WORD	residual bytes from SCSI opcode

Bitfields for current device state:
 bit 0	device currently opened in buffered mode
 bit 1	drive currently opened in nonbuffered mode
 bit 2	rewind drive on last close
 bit 3	drive has been written on
 bit 4	drive has been read from
 bit 5	next read will return 0 bytes
 bit 6	EOM will resemble EOF
 bit 7	drive may be busy rewinding
--------D-21440D-----------------------------
INT 21 - DOS 3.2+ - IOCTL - GENERIC BLOCK DEVICE REQUEST
	AX = 440Dh
	BL = drive number (00h=default,01h=A:,etc)
	CH = category code
	    08h disk drive
	    00h-7Fh reserved for Microsoft
	    80h-FFh reserved for OEM/user-defined
	CL = minor code (function) (see below)
	DS:DX -> (DOS) parameter block (see below)
	SI:DI -> (OS/2 comp box) parameter block (see below)
Return: CF set on error
	    AX = error code (01h,02h) (see AH=59h)
	CF clear if successful
	    DS:DX -> data block if CL=60h or CL=61h
Notes:	DOS 4.01 seems to ignore the high byte of the number of directory
	  entries in the BPB for diskettes.
	functions 46h and 66h undocumented in DOS 4.x, documented for DOS 5+
	the DUBLDISK.SYS v2.6 driver only supports minor codes 60h and 67h
	DR-DOS 3.41-6.0 only support minor codes 40h-42h and 60h-62h; all
	  other minor codes return error code 16h
SeeAlso: AX=440Ch,AH=69h,INT 2F/AX=0802h,INT 2F/AX=122Bh

Values for minor code:
 00h	(OS/2)	\ used to lock/unlock a drive
 01h	(OS/2)	/
 40h	set device parameters
 41h	write logical device track
 42h	format and verify logical device track
 46h	(DOS 4+) set volume serial number (see also AH=69h)
 47h	(DOS 4+) set access flag
 50h	(PCMCIA) attribute memory write
 51h	(PCMCIA) common memory write
 52h	(PCMCIA) force media change
 53h	(PCMCIA) erase drive
 54h	(PCMCIA) erase media
 56h	(PCMCIA) set erase status callback
 57h	(PCMCIA) append Card Information Structure (CIS) tuple
 58h	(PCMCIA) erase CIS tuples
 60h	get device parameters
 61h	read logical device track
 62h	verify logical device track
 66h	(DOS 4+) get volume serial number (see also AH=69h)
 67h	(DOS 4+) get access flag
 68h	(DOS 5+) sense media type
 70h	(PCMCIA) attribute memory read
 73h	(PCMCIA) get memory media information
 76h	(PCMCIA) get erase status callback
 77h	(PCMCIA) get first Card Information Structure (CIS) tuple
 78h	(PCMCIA) get next CIS tuple

Format of parameter block for functions 40h, 60h:
Offset	Size	Description
 00h	BYTE	special functions
		bit 0 set if function to use current BPB, clear if Device
			BIOS Parameter Block field contains new default BPB
		bit 1 set if function to use track layout fields only
			must be clear if CL=60h
		bit 2 set if all sectors in track same size (should be set)
		bits 3-7 reserved
 01h	BYTE	device type (see below)
 02h	WORD	device attributes
		bit 0 set if nonremovable medium
		bit 1 set if door lock ("changeline") supported
		bits 2-15 reserved
 04h	WORD	number of cylinders
 06h	BYTE	media type
		for 1.2M drive
		    00h 1.2M disk (default)
		    01h 320K/360K disk
		F8h for DUBLDISK.SYS v2.6 expanded drives
		always 00h for other drive types
 07h 31 BYTEs	device BPB (see AH=53h), bytes after BPB offset 1Eh omitted
---function 40h only---
 26h	WORD	number of sectors per track (start of track layout field)
		max 63
 28h  N word pairs: number,size of each sector in track

Values for device type:
 00h	320K/360K disk
 01h	1.2M disk
 02h	720K disk
 03h	single-density 8-inch disk
 04h	double-density 8-inch disk
 05h	fixed disk
 06h	tape drive
 07h	(DOS 3.3+) other type of block device, normally 1.44M floppy
 08h	read/write optical disk
 09h	(DOS 5+) 2.88M floppy

Format of parameter block for functions 41h, 61h:
Offset	Size	Description
 00h	BYTE	special functions (reserved, must be zero)
 01h	WORD	number of disk head
 03h	WORD	number of disk cylinder
 05h	WORD	number of first sector to read/write
 07h	WORD	number of sectors
 09h	DWORD	transfer address

Format of parameter block for function 42h:
Offset	Size	Description
 00h	BYTE	reserved, must be zero (DOS <3.2)
		  bit 0=0: format/verify track
			1: format status call (DOS 3.2+), don't actually format
		  bits 1-7 reserved, must be zero
		on return (DOS 4.x):
		  bit 0: set if specified tracks, sectors/track supported
		  bit 1: set if function not supported by BIOS
		  bit 2: set if specified tracks, sectors/track not supported
		  bit 3: set if no disk in drive
 01h	WORD	number of disk head
 03h	WORD	number of disk cylinder

Format of parameter block for function 62h:
Offset	Size	Description
 00h	BYTE	reserved, must be zero (DOS <3.2)
		  bit 0=0: verify single track
			1: verify multiple tracks
		  bits 1-7 reserved, must be zero
		on return (DOS 4.x):
		  bit 0: set if specified tracks, sectors/track supported
		  bit 1: set if function not supported by BIOS
		  bit 2: set if specified tracks, sectors/track not supported
		  bit 3: set if no disk in drive
 01h	WORD	number of disk head
 03h	WORD	number of disk cylinder
 05h	WORD	number of tracks to verify (equivalent to 255 or fewer sectors)

Format of parameter block for functions 46h, 66h:
Offset	Size	Description
 00h	WORD	(call) info level (should be 0000h)
 02h	DWORD	disk serial number (binary)
 06h 11 BYTEs	volume label or "NO NAME    "
 11h  8 BYTEs	filesystem type "FAT12	 " or "FAT16   " (CL=66h only)

Format of parameter block for functions 47h, 67h:
Offset	Size	Description
 00h	BYTE	special-function field (must be zero)
 01h	BYTE	disk-access flag, nonzero if access allowed by driver

Format of parameter block for function 68h:
Offset	Size	Description
 00h	BYTE	01h for default media type, 00h for any other media type
		(see also INT 13/AH=20h)
 01h	BYTE	02h for 720K, 07h for 1.44M, 09h for 2.88M
--------D-21440E-----------------------------
INT 21 - DOS 3.2+ - IOCTL - GET LOGICAL DRIVE MAP
	AX = 440Eh
	BL = drive number (00h=default,01h=A:,etc)
Return: CF set on error
	    AX = error code (01h,0Fh) (see AH=59h)
	CF clear if successful
	    AL = 00h block device has only one logical drive assigned
		 1..26 the last letter used to reference the drive (1=A:,etc)
Note:	DR-DOS 3.41-5.0 DRIVER.SYS does not support drive mapping and thus
	  always returns AL=00h
SeeAlso: AX=440Fh,INT 2F/AX=122Bh
--------D-21440F-----------------------------
INT 21 - DOS 3.2+ - IOCTL - SET LOGICAL DRIVE MAP
	AX = 440Fh
	BL = physical drive number (00h=default,01h=A:,etc))
Return: CF set on error
	    AX = error code (01h,0Fh) (see AH=59h)
	CF clear if successful
	    drive now responds to next logical drive number
Notes:	maps logical drives to physical drives, similar to DOS's treatment of
	  a single physical floppy drive as both A: and B:
	DR-DOS 3.41-5.0 DRIVER.SYS does not support drive mapping and thus
	  always returns an error on this function
SeeAlso: AX=440Eh,INT 2F/AX=122Bh
--------D-214410-----------------------------
INT 21 - DOS 5+ - IOCTL - QUERY GENERIC IOCTL CAPABILITY (HANDLE)
	AX = 4410h
	BX = handle for device
	CH = category code (see AX=440Ch)
	CL = function code
Return: CF clear if successful
	    AX = 0000h	specified IOCTL function is supported
	CF set on error
	    AL = 01h	IOCTL capability not available
Note:	a program which wishes to use Generic IOCTL calls beyond those in the
	  standard DOS 3.2 set may use this call first to see whether a
	  particular call is supported
SeeAlso: AX=440Ch,AX=440Dh,AX=4411h
--------d-214410BXFFFF-----------------------
INT 21 U - NewSpace - ENABLE DRIVER
	AX = 4410h
	BX = FFFFh
Program: NewSpace is a TSR by Isogon Corporation which automatically compresses
	  all files as they are written and decompresses them as they are read
Note:	compressed files are not accessible unless the driver is enabled
SeeAlso: AX=4411h/BX=FFFFh
--------D-214411-----------------------------
INT 21 - DOS 5+ - IOCTL - QUERY GENERIC IOCTL CAPABILITY (DRIVE)
	AX = 4411h
	BL = drive number
	CH = category code (see AX=440Dh)
	CL = function code
Return: CF clear if successful
	    AX = 0000h	specified IOCTL function is supported
	CF set on error
	    AL = 01h	IOCTL capability not available
Note:	a program which wishes to use Generic IOCTL calls beyond those in the
	  standard DOS 3.2 set may use this call first to see whether a
	  particular call is supported
SeeAlso: AX=440Ch,AX=440Dh,AX=4410h
--------d-214411BXFFFF-----------------------
INT 21 U - NewSpace - DISABLE DRIVER
	AX = 4411h
	BX = FFFFh
Program: NewSpace is a TSR by Isogon Corporation which automatically compresses
	  all files as they are written and decompresses them as they are read
Note:	compressed files are not accessible unless the driver is enabled
SeeAlso: AX=4410h/BX=FFFFh
--------O-214412-----------------------------
INT 21 - DR-DOS 5+ - DETERMINE DOS TYPE
	AX = 4412h
	CF set
Return: CF set if not DR-DOS
	    AX = error code (see AH=59h)
	CF clear if DR-DOS
	    DX = AX = version code (see AX=4452h)
Note:	this obsolete call which will not be supported in future versions of
	  DR-DOS is identical to AX=4452h
SeeAlso: AX=4452h
--------d-214412BXFFFF-----------------------
INT 21 U - NewSpace - INSTALLATION CHECK???
	AX = 4412h
	BX = FFFFh
Return: AX = PSP segment of NewRes (resident driver for NewSpace)
	BX:DX -> ???
	CX = ???
SeeAlso: AX=4411h/BX=FFFFh
--------d-214413BXFFFF-----------------------
INT 21 U - NewSpace - GET ???
	AX = 4413h
	BX = FFFFh
Return: AX = code segment of NewRes (resident driver for NewSpace)
	BX = offset of ???
SeeAlso: AX=4412h/BX=FFFFh
--------O-214414-----------------------------
INT 21 U - DR-DOS 5.0 - SET GLOBAL PASSWORD
	AX = 4414h
	DS:DX -> password string (blank-padded to 8 characters)
Desc:	Specify the master password for accessing files.
Note:	this obsolete call which will not be supported in future versions of
	  DR-DOS is identical to AX=4452h
SeeAlso: AX=4454h
--------d-214414BXFFFF-----------------------
INT 21 U - NewSpace - DEBUGGING DUMP
	AX = 4414h
	BX = FFFFh
Return: debugging dump written to X:\NEWSPACE.SMP
SeeAlso: AX=4413h/BX=FFFFh,AX=44FFh/BX=FFFFh
--------O-2144-------------------------------
INT 21 U - DR-DOS 5.0 - HISTORY BUFFER, SHARE, AND HILOAD CONTROL
	AH = 44h
	AL = 16h to 18h
Note:	these obsolete subfunctions (which will not be supported in future
	  versions of DR-DOS) are identical to AX=4456h through 4458h
SeeAlso: AX=4456h,AX=4457h,AX=4458h
--------O-214451-----------------------------
INT 21 - Concurrent DOS v3.2+ - INSTALLATION CHECK
	AX = 4451h
Return: CF set if not Concurrent DOS
	    AX = error code (see AH=59h)
	CF clear if successful
	    AH = single-user/multiuser nature
		10h single-user
		    AL = operating system version ID (see AX=4452h)
		14h multiuser
		    AL = operating system version ID (see below)
Notes:	as of Concurrent DOS/XM 5.0 (possibly earlier), the version is stored
	  in the environment variable VER
	use this function if you are looking for multiuser capabilities,
	  AX=4452h for single-user
	this function should never return the single-user values
SeeAlso: AX=4452h,AX=4459h

Values for operating system version ID:
 32h	Concurrent PC DOS 3.2
 41h	Concurrent DOS 4.1
 50h	Concurrent DOS/XM 5.0 or Concurrent DOS/386 1.1
 60h	Concurrent DOS/XM 6.0 or Concurrent DOS/386 2.0
 62h	Concurrent DOS/XM 6.2 or Concurrent DOS/386 3.0
 66h	DR Multiuser DOS 5.1
 67h	Concurrent DOS 5.1
--------O-214452-----------------------------
INT 21 - DR-DOS 3.41+ - DETERMINE DOS TYPE/GET DR-DOS VERSION
	AX = 4452h ("DR")
	CF set
Return: CF set if not DR-DOS
	    AX = error code (see AH=59h)
	CF clear if DR-DOS
	    DX = AX = version code
	    AH = single-user/multiuser nature
		10h single-user
		    AL = operating system version ID (see below)
		14h multiuser
		    AL = operating system version ID (see AX=4451h)
Notes:	the DR-DOS version is stored in the environment variable VER
	use this function if looking for single-user capabilities, AX=4451h
	  if looking for multiuser; this call should never return multiuser
	  values
SeeAlso: AX=4412h,AX=4451h,AX=4459h

Values for operating system version ID:
 60h	DOS Plus
 63h	DR-DOS 3.41
 64h	DR-DOS 3.42
 65h	DR-DOS 5.00
 67h	DR-DOS 6.00
 70h	PalmDOS
 71h	DR-DOS 6.0 March 1993 "business update"
 72h	Novell DOS 7.0
--------O-214454-----------------------------
INT 21 U - DR-DOS 3.41+ - SET GLOBAL PASSWORD
	AX = 4454h
	DS:DX -> password string (blank-padded to 8 characters)
Desc:	Specify the master password for accessing files.
SeeAlso: AX=4303h,AX=4414h
--------O-214456-----------------------------
INT 21 U - DR-DOS 5.0+ - HISTORY BUFFER CONTROL
	AX = 4456h
	DL = flag
	    bit 0: 1 = COMMAND.COM history buffers
		   0 = set to application
Return: AL = ??? (20h if DL bit 0 set, A0h if clear (DR-DOS 6.0))
Note:	This was seen called by COMMAND.COM of DR-DOS 6.0
--------O-214457-----------------------------
INT 21 U - DR-DOS 5.0+ - SHARE/HILOAD CONTROL
	AX = 4457h
	DH = subfunction
	    00h enable/disable SHARE
		DL = 00h disable
		   = 01h enable
		   else Return: AX = ???
	    01h get HILOAD status
		Return: AX = status
			    0000h off
			    0001h on
	    02h set HILOAD status
		DL = new state (00h off, 01h on)
		Return: AX = ???
	    other
		Return: AX = ???
Note:	This was seen called by COMMAND.COM of DR-DOS 6.0
SeeAlso: AX=4457h/DX=FFFFh
--------O-214457DXFFFF-----------------------
INT 21 U - DR-DOS 6.0 - GET SHARE STATUS
	AX = 4457h
	DX = FFFFh
Return: AX = SHARE status
SeeAlso: INT 2F/AX=1000h
--------O-214458-----------------------------
INT 21 U - DR-DOS 5.0+ internal - GET POINTER TO INTERNAL VARIABLE TABLE
	AX = 4458h
Return: ES:BX -> internal variable table (see below)
	AX = ??? (0B50h for DR-DOS 5.0, 0A56h for DR-DOS 6.0)
SeeAlso: AX=4452h

Format of internal variable table:
Offset	Size	Description
 00h	DWORD	pointer to ???
 04h  7 BYTEs	???
 0Bh	WORD	KB of extended memory at startup
 0Dh	BYTE	number of far jump entry points
 0Eh	WORD	segment containing far jumps to DR-DOS entry points (see below)
---DR-DOS 6.0---
 10h	WORD	(only if kernel loaded in HMA) offset in HMA of first free HMA
		memory block (see below) or 0000h if none; segment is FFFFh
 12h	WORD	pointer to segment of environment variables set in CONFIG,
		or 0000h if already used
 14h	WORD	(only if kernel loaded in HMA) offset in HMA of first used HMA
		memory block (see below) or 0000h if none; segment is FFFFh
Note:	the segment used for the DR-DOS 6.0 CONFIG environment variables
	  (excluding COMSPEC, VER and OS) is only useful for programs/drivers
	  called from CONFIG.SYS. The word is set to zero later and the area
	  lost.

Format of kernel entry jump table for DR-DOS 5.0-6.0:
Offset	Size	Description
 00h  5 BYTEs	far jump to kernel entry point for CP/M CALL 5
 05h  5 BYTEs	far jump to kernel entry point for INT 20
 0Ah  5 BYTEs	far jump to kernel entry point for INT 21
 0Fh  5 BYTEs	far jump to kernel entry point for INT 22??? (RETF)
 14h  5 BYTEs	far jump to kernel entry point for INT 23??? (RETF)
 19h  5 BYTEs	far jump to kernel entry point for INT 24
 1Eh  5 BYTEs	far jump to kernel entry point for INT 25
 23h  5 BYTEs	far jump to kernel entry point for INT 26
 28h  5 BYTEs	far jump to kernel entry point for INT 27
 2Dh  5 BYTEs	far jump to kernel entry point for INT 28
 32h  5 BYTEs	far jump to kernel entry point for INT 2A (IRET)
 37h  5 BYTEs	far jump to kernel entry point for INT 2B (IRET)
 3Ch  5 BYTEs	far jump to kernel entry point for INT 2C (IRET)
 41h  5 BYTEs	far jump to kernel entry point for INT 2D (IRET)
 46h  5 BYTEs	far jump to kernel entry point for INT 2E (IRET)
 4Bh  5 BYTEs	far jump to kernel entry point for INT 2F
Note:	all of these entry points are indirected through this jump table
	  to allow the kernel to be relocated into high memory while leaving
	  the actual entry addresses in low memory for maximum compatibility

Format of HMA Memory Block (DR-DOS 6.0 kernel loaded in HMA):
Offset	Size	Description
 00h	WORD	offset of next HMA Memory Block (0000h if last block)
 02h	WORD	size of this block in bytes (at least 10h)
 04h	BYTE	type of HMA Memory Block (interpreted by MEM)
		00h system
		01h KEYB
		02h NLSFUNC
		03h SHARE
		04h TaskMAX
		05h COMMAND
 05h	var	TSR (or system) code and data. DR-DOS TSR's, such as KEYB,
		hooks interrupts using segment FFFEh instead FFFFh.
--------O-214459-----------------------------
INT 21 - DR MultiUser DOS 5.0 - API
	AX = 4459h
	CL = function (see INT E0"CP/M")
	DS,DX = parameters
Notes:	DR-DOS 5.0 returns CF set and AX=0001h
	this API is also available on INT E0
SeeAlso: AX=4452h,INT E0"CP/M"
--------d-2144FFBXFFFF-----------------------
INT 21 U - NewSpace - ???
	AX = 44FFh
	BX = FFFFh
	DX = ???
Program: NewSpace is a TSR by Isogon Corporation which automatically compresses
	  all files as they are written and decompresses them as they are read
SeeAlso: AX=4414h/BX=FFFFh
--------D-2145-------------------------------
INT 21 - DOS 2+ - "DUP" - DUPLICATE FILE HANDLE
	AH = 45h
	BX = file handle
Return: CF clear if successful
	    AX = new handle
	CF set on error
	    AX = error code (04h,06h) (see AH=59h)
Notes:	moving file pointer for either handle will also move it for the other,
	  because both will refer to the same system file table
	for DOS versions prior to 3.3, file writes may be forced to disk by
	  duplicating the file handle and closing the duplicate
SeeAlso: AH=3Dh,AH=46h
--------D-2146-------------------------------
INT 21 - DOS 2+ - "DUP2", "FORCEDUP" - FORCE DUPLICATE FILE HANDLE
	AH = 46h
	BX = file handle
	CX = file handle to become duplicate of first handle
Return: CF clear if successful
	CF set on error
	    AX = error code (04h,06h) (see AH=59h)
Notes:	closes file with handle CX if it is still open
	DOS 3.30 hangs if BX=CX on entry
	moving file pointer for either handle will also move it for the other,
	  because both will refer to the same system file table
SeeAlso: AH=3Dh,AH=45h
--------D-2147-------------------------------
INT 21 - DOS 2+ - "CWD" - GET CURRENT DIRECTORY
	AH = 47h
	DL = drive number (00h = default, 01h = A:, etc)
	DS:SI -> 64-byte buffer for ASCIZ pathname
Return: CF clear if successful
	    AX = 0100h (undocumented)
	CF set on error
	    AX = error code (0Fh) (see AH=59h)
Notes:	the returned path does not include a drive or the initial backslash
	many Microsoft products for Windows rely on AX being 0100h on success
	under the FlashTek X-32 DOS extender, the buffer pointer is in DS:ESI
SeeAlso: AH=19h,AH=3Bh,INT 15/AX=DE25h
--------D-2148-------------------------------
INT 21 - DOS 2+ - ALLOCATE MEMORY
	AH = 48h
	BX = number of paragraphs to allocate
Return: CF clear if successful
	    AX = segment of allocated block
	CF set on error
	    AX = error code (07h,08h) (see AH=59h)
	    BX = size of largest available block
Notes:	DOS 2.1-6.0 coalesces free blocks while scanning for a block to
	  allocate
	.COM programs are initially allocated the largest available memory
	  block, and should free some memory with AH=49h before attempting any
	  allocations
	under the FlashTek X-32 DOS extender, EBX contains a protected-mode
	  near pointer to the allocated block on a successful return
SeeAlso: AH=49h,AH=4Ah,AH=58h,AH=83h
--------D-2149-------------------------------
INT 21 - DOS 2+ - FREE MEMORY
	AH = 49h
	ES = segment of block to free
Return: CF clear if successful
	CF set on error
	    AX = error code (07h,09h) (see AH=59h)
Notes:	apparently never returns an error 07h, despite official docs; DOS 3.30
	  code contains only an error 09h exit
	DOS 2.1-6.0 does not coalesce adjacent free blocks when a block is
	  freed, only when a block is allocated or resized
	the code for this function is identical in DOS 2.1-6.0 except for
	  calls to start/end a critical section in DOS 3+
SeeAlso: AH=48h,AH=4Ah
--------D-214A-------------------------------
INT 21 - DOS 2+ - RESIZE MEMORY BLOCK
	AH = 4Ah
	BX = new size in paragraphs
	ES = segment of block to resize
Return: CF clear if successful
	CF set on error
	    AX = error code (07h,08h,09h) (see AH=59h)
	    BX = maximum paragraphs available for specified memory block
Notes:	under DOS 2.1-5.0, if there is insufficient memory to expand the block
	  as much as requested, the block will be made as large as possible
	DOS 2.1-5.0 coalesces any free blocks immediately following the block
	  to be resized
SeeAlso: AH=48h,AH=49h,AH=83h
--------D-214B-------------------------------
INT 21 - DOS 2+ - "EXEC" - LOAD AND/OR EXECUTE PROGRAM
	AH = 4Bh
	AL = type of load
	    00h load and execute
	    01h load but do not execute
	    03h load overlay
	    04h load and execute in background (European MS-DOS 4.0 only)
		"Exec & Go" (see also AH=80h)
	DS:DX -> ASCIZ program name (must include extension)
	ES:BX -> parameter block (see below)
	CX = mode (subfunction 04h only)
		0000h child placed in zombie mode after termination
		0001h child's return code discarded on termination
Return: CF clear if successful
	    BX,DX destroyed
	    if subfunction 01h, process ID set to new program's PSP; get with
		INT 21/AH=62h
	CF set on error
	    AX = error code (01h,02h,05h,08h,0Ah,0Bh) (see AH=59h)
Notes:	DOS 2.x destroys all registers, including SS:SP
	under ROM-based DOS, if no disk path characters (colons or slashes)
	  are included in the program name, the name is searched for in the
	  ROM module headers (see below) before searching on disk
	for functions 00h and 01h, the calling process must ensure that there
	  is enough unallocated memory available; if necessary, by releasing
	  memory with AH=49h or AH=4Ah
	for function 01h, the AX value to be passed to the child program is put
	  on top of the child's stack
	for function 03h, DOS assumes that the overlay is being loaded into
	  memory allocated by the caller
	function 01h was undocumented prior to the release of DOS 5.0
	some versions (such as DR-DOS 6.0) check the parameters and parameter
	  block and return an error if an invalid value (such as an offset of
	  FFFFh) is found
	background programs under European MS-DOS 4.0 must use the new
	  executable format
	new executables begin running with the following register values
		AX = environment segment
		BX = offset of command tail in environment segment
		CX = size of automatic data segment (0000h = 64K)
		ES,BP = 0000h
		DS = automatic data segment
		SS:SP = initial stack
	  the command tail corresponds to an old executable's PSP:0081h and
	  following, except that the 0Dh is turned into a NUL (00h); new
	  format executables have no PSP
	under the FlashTek X-32 DOS extender, only function 00h is supported
	  and the pointers are passed in DS:EDX and ES:EBX
	DR-DOS 6 always loads .EXE-format programs with no fixups above the
	  64K mark to avoid the EXEPACK bug
	names for the various executable type understood by various
	  environments:
		MZ  old-style DOS executable
		NE  Windows or OS/2 1.x segmented ("new") executable
		LE  Windows virtual device driver (VxD) linear executable
		LX  variant of LE used in OS/2 2.x
		W3  Windows WIN386.EXE file; a collection of LE files
		PE  Win32 (Windows NT and Win32s) portable executable based on
			Unix COFF
BUGS:	DOS 2.00 assumes that DS points at the current program's PSP
	Load Overlay (subfunction 03h) loads up to 512 bytes too many if the
	  file contains additional data after the actual overlay
SeeAlso: AX=4B05h,AH=4Ch,AH=4Dh,AH=64h"OS/2",AH=8Ah,INT 2E

Format of EXEC parameter block for AL=00h,01h,04h:
Offset	Size	Description
 00h	WORD	segment of environment to copy for child process (copy caller's
		environment if 0000h)
 02h	DWORD	pointer to command tail to be copied into child's PSP
 06h	DWORD	pointer to first FCB to be copied into child's PSP
 0Ah	DWORD	pointer to second FCB to be copied into child's PSP
 0Eh	DWORD	(AL=01h) will hold subprogram's initial SS:SP on return
 12h	DWORD	(AL=01h) will hold entry point (CS:IP) on return

Format of EXEC parameter block for AL=03h:
Offset	Size	Description
 00h	WORD	segment at which to load overlay
 02h	WORD	relocation factor to apply to overlay if in .EXE format

Format of EXEC parameter block for FlashTek X-32:
Offset	Size	Description
 00h	PWORD	48-bit far pointer to environment string
 06h	PWORD	48-bit far pointer to command tail string

Format of .EXE file header:
Offset	Size	Description
 00h  2 BYTEs	.EXE signature, either "MZ" or "ZM" (5A4Dh or 4D5Ah)
 02h	WORD	number of bytes in last 512-byte page of executable
 04h	WORD	total number of 512-byte pages in executable (includes any
		partial last page)
 06h	WORD	number of relocation entries
 08h	WORD	header size in paragraphs
 0Ah	WORD	minimum paragraphs of memory to allocation in addition to
		executable's size
 0Ch	WORD	maximum paragraphs to allocate in addition to executable's size
 0Eh	WORD	initial SS relative to start of executable
 10h	WORD	initial SP
 12h	WORD	checksum (one's complement of sum of all words in executable)
 14h	DWORD	initial CS:IP relative to start of executable
 18h	WORD	offset within header of relocation table
		40h or greater for new-format (NE,LE,LX,W3,PE,etc.) executable
 1Ah	WORD	overlay number (normally 0000h = main program)
---new executable---
 1Ch  4 BYTEs	???
 20h	WORD	behavior bits
 22h 26 BYTEs	reserved for additional behavior info
 3Ch	DWORD	offset of new executable (NE,LE,etc) header within disk file,
		or 00000000h if plain MZ executable
---Borland TLINK---
 1Ch  2 BYTEs	??? (apparently always 01h 00h)
 1Eh	BYTE	signature FBh
 1Fh	BYTE	TLINK version (major in high nybble, minor in low nybble)
 20h  2 BYTEs	??? (v2.0 apparently always 72h 6Ah, v3.0+ seems always 6Ah 72h)
---ARJ self-extracting archive---
 1Ch  4 BYTEs	signature "RJSX" (older versions, new signature is "aRJsfX" in
		the first 1000 bytes of the file)
---LZEXE 0.90 compressed executable---
 1Ch  4 BYTEs	signature "LZ09"
---LZEXE 0.91 compressed executable---
 1Ch  4 BYTEs	signature "LZ91"
---PKLITE compressed executable---
 1Ch	BYTE	minor version number
 1Dh	BYTE	bits 0-3: major version
		bit 4: extra compression
		bit 5: huge (multi-segment) file
 1Eh  6 BYTEs	signature "PKLITE" (followed by copyright message)
---LHarc 1.x self-extracting archive---
 1Ch  4 BYTEs	unused???
 20h  3 BYTEs	jump to start of extraction code
 23h  2 BYTEs	???
 25h 12 BYTEs	signature "LHarc's SFX "
---LHA 2.x self-extracting archive---
 1Ch  8 BYTEs	???
 24h 10 BYTEs	signature "LHa's SFX " (v2.10) or "LHA's SFX " (v2.13)
---TopSpeed C 3.0 CRUNCH compressed file---
 1Ch	DWORD	018A0001h
 20h	WORD	1565h
---PKARCK 3.5 self-extracting archive---
 1Ch	DWORD	00020001h
 20h	WORD	0700h
---BSA (Soviet archiver) self-extracting archive---
 1Ch	WORD	000Fh
 1Eh	BYTE	A7h
---LARC self-extracting archive---
 1Ch  4 BYTEs	???
 20h 11 BYTEs	"SFX by LARC "
---LH self-extracting archive---
 1Ch  8 BYTEs	???
 24h  8 BYTEs	"LH's SFX "
---other linkers---
 1Ch	var	optional information
---
  N   N DWORDs	relocation items
Notes:	if word at offset 02h is 4, it should be treated as 00h, since pre-1.10
	  versions of the MS linker set it that way
	if both minimum and maximum allocation (offset 0Ah/0Ch) are zero, the
	  program is loaded as high in memory as possible
	the maximum allocation is set to FFFFh by default

Format of ROM Module Header:
Offset	Size	Description
 00h  2 BYTEs	ROM signature 55h, AAh
 02h	BYTE	size of ROM in 512-byte blocks
 03h  3 BYTEs	POST initialization entry point (near JMP instruction)
 06h	ROM Program Name List [array]
	Offset	Size	Description
	 00h	BYTE	length of ROM program's name (00h if end of name list)
	 01h  N BYTEs	program name
	 N+1  3 BYTEs	program entry point (near JMP instruction)

Format of new executable header:
Offset	Size	Description
 00h  2 BYTEs	"NE" (4Eh 45h) signature
 02h  2 BYTEs	linker version (major, then minor)
 04h	WORD	offset from start of this header to entry table (see below)
 06h	WORD	length of entry table in bytes
 08h	DWORD	file load CRC (0 in Borland's TPW)
 0Ch	BYTE	program flags
		bits 0-1 DGROUP type
		  0 = none
		  1 = single shared
		  2 = multiple (unshared)
		  3 = (null)
		bit 2:	global initialization
		bit 3:	protected mode only
		bit 4:	8086 instructions
		bit 5:	80286 instructions
		bit 6:	80386 instructions
		bit 7:	80x87 instructions
 0Dh	BYTE	application flags
		bits 0-2: application type
		    001 full screen (not aware of Windows/P.M. API)
		    010 compatible with Windows/P.M. API
		    011 uses Windows/P.M. API
		bit 3: is a Family Application (OS/2)
		bit 5: 0=executable, 1=errors in image
		bit 6: non-conforming program (valid stack is not maintained)
		bit 7: DLL or driver rather than application
			(SS:SP info invalid, CS:IP points at FAR init routine
			 called with AX=module handle which returns AX=0000h
			 on failure, AX nonzero on successful initialization)
 0Eh	WORD	auto data segment index
 10h	WORD	initial local heap size
 12h	WORD	initial stack size (added to data seg, 0000h if SS <> DS)
 14h	DWORD	program entry point (CS:IP), "CS" is index into segment table
 18h	DWORD	initial stack pointer (SS:SP), "SS" is segment index
		if SS=automatic data segment and SP=0000h, the stack pointer is
		  set to the top of the automatic data segment, just below the
		  local heap
 1Ch	WORD	segment count
 1Eh	WORD	module reference count
 20h	WORD	length of nonresident names table in bytes
 22h	WORD	offset from start of this header to segment table (see below)
 24h	WORD	offset from start of this header to resource table
 26h	WORD	offset from start of this header to resident names table
 28h	WORD	offset from start of this header to module reference table
 2Ah	WORD	offset from start of this header to imported names table
		(array of counted strings, terminated with a string of length
		 00h)
 2Ch	DWORD	offset from start of file to nonresident names table
 30h	WORD	count of moveable entry point listed in entry table
 32h	WORD	file alignment size shift count
		0 is equivalent to 9 (default 512-byte pages)
 34h	WORD	number of resource table entries
 36h	BYTE	target operating system
		00h unknown
		01h OS/2
		02h Windows
		03h European MS-DOS 4.x
		04h Windows 386
		05h BOSS (Borland Operating System Services)
 37h	BYTE	other EXE flags
		bit 0: supports long filenames
		bit 1: 2.X protected mode
		bit 2: 2.X proportional font
		bit 3: gangload area
 38h	WORD	offset to return thunks or start of gangload area
 3Ah	WORD	offset to segment reference thunks or length of gangload area
 3Ch	WORD	minimum code swap area size
 3Eh  2 BYTEs	expected Windows version (minor version first)
Note:	this header is documented in detail in the Windows 3.1 SDK Programmer's
	  Reference, Vol 4.

Format of Codeview trailer (at end of executable):
Offset	Size	Description
 00h	WORD	signature 4E42h ('NB')
 02h	WORD	Microsoft debug info version number
 04h	DWORD	Codeview header offset

Format of new executable segment table record:
 00h	WORD	offset in file (shift left by alignment shift to get byte offs)
 02h	WORD	length of image in file (0000h = 64K)
 04h	WORD	segment attributes (see below)
 06h	WORD	number of bytes to allocate for segment (0000h = 64K)
Note:	the first segment table entry is entry number 1

Bitfields for segment attributes:
 bit 0	data segment rather than code segment
 bit 1	unused???
 bit 2	real mode
 bit 3	iterated
 bit 4	movable
 bit 5	sharable
 bit 6	preloaded rather than demand-loaded
 bit 7	execute-only (code) or read-only (data)
 bit 8	relocations (directly following code for this segment)
 bit 9	debug info present
 bits 10,11	80286 DPL bits
 bit 12		discardable
 bits 13-15	discard priority

Format of new executable entry table item (list):
Offset	Size	Description
 00h	BYTE	number of entry points (00h if end of entry table list)
 01h	BYTE	segment number (00h if end of entry table list)
 02h 3N BYTEs	entry records
		Offset	Size	Description
		 00h	BYTE	flags
				bit 0: exported
				bit 1: single data
				bits 2-7: unused???
		 01h	WORD	offset within segment

Format of new executable relocation data (immediately follows segment image):
Offset	Size	Description
 00h	WORD	number of relocation items
 02h 8N BYTEs	relocation items
		Offset	Size	Description
		 00h	BYTE	relocation type
				00h LOBYTE
				02h BASE
				03h PTR
				05h OFFS
				0Bh PTR48
				0Dh OFFS32
		 01h	BYTE	flags
				bit 2: additive
		 02h	WORD	offset within segment
		 04h	WORD	target address segment
		 06h	WORD	target address offset

Format of new executable resource data:
Offset	Size	Description
 00h	WORD	alignment shift count for resource data
 02h  N RECORDs resources
	Format of resource record:
	Offset	Size	Description
	 00h	WORD	type ID
			0000h if end of resource records
			>= 8000h if integer type
			else offset from start of resource table to type string
	 02h	WORD	number of resources of this type
	 04h	DWORD	reserved for runtime use
	 08h  N Resources (see below)
Note:	resource type and name strings are stored immediately following the
	  resource table, and are not null-terminated

Format of new executable resource entry:
Offset	Size	Description
 00h	WORD	offset in alignment units from start of file to contents of
		the resource data
 02h	WORD	length of resource image in bytes
 04h	WORD	flags
		bit 4: moveable
		bit 5: shareable
		bit 6: preloaded
 06h	WORD	resource ID
		>= 8000h if integer resource
		else offset from start of resource table to resource string
 08h	DWORD	reserved for runtime use
Notes:	resource type and name strings are stored immediately following the
	  resource table, and are not null-terminated
	strings are counted strings, with a string of length 0 indicating the
	  end of the resource table

Format of new executable module reference table [one bundle of entries]:
Offset	Size	Description
 00h	BYTE	number of records in this bundle (00h if end of table)
 01h	BYTE	segment indicator
		00h unused
		FFh movable segment, segment number is in entry
		else segment number of fixed segment
 02h  N RECORDs
	Format of segment record
	Offset	Size	Description
	 00h	BYTE	flags
			bit 0: entry is exported
			bit 1: entry uses global (shared) data
			bits 7-3: number of parameter words
	---fixed segment---
	 01h	WORD	offset
	---moveable segment---
	 01h  2 BYTEs	INT 3F instruction (CDh 3Fh)
	 03h	BYTE	segment number
	 05h	WORD	offset
Note:	table entries are numbered starting from 1

Format of new executable resident/nonresident name table entry:
Offset	Size	Description
 00h	BYTE	length of string (00h if end of table)
 01h  N BYTEs	ASCII text of string
 N+1	WORD	ordinal number (index into entry table)
Notes:	the first string in the resident name table is the module name; the
	  first entry in the nonresident name table is the module description
	the strings are case-sensitive; if the executable was linked with
	  /IGNORECASE, all strings are in uppercase

Format of Linear Executable (enhanced mode executable) header:
Offset	Size	Description
 00h  2 BYTEs	"LE" (4Ch 45h) signature (Windows)
		"LX" (4Ch 58h) signature (OS/2)
 02h	BYTE	byte order (00h = little-endian, nonzero = big-endian)
 03h	BYTE	word order (00h = little-endian, nonzero = big-endian)
 04h	DWORD	executable format level
 08h	WORD	CPU type (see also INT 15/AH=C9h)
		01h Intel 80286 or upwardly compatible
		02h Intel 80386 or upwardly compatible
		03h Intel 80486 or upwardly compatible
		04h Intel Pentium (80586) or upwardly compatible
		20h Intel i860 (N10) or compatible
		21h Intel "N11" or compatible
		40h MIPS Mark I (R2000, R3000) or compatible
		41h MIPS Mark II (R6000) or compatible
		42h MIPS Mark III (R4000) or compatible
 0Ah	WORD	target operating system
		01h OS/2
		02h Windows
		03h European DOS 4.0
		04h Windows 386
 0Ch	DWORD	module version
 10h	DWORD	module type
		bit 2: initialization (only for DLLs)
			0 = global
			1 = per-process
		bit 4: no internal fixups in executable image
		bit 5: no external fixups in executable image
		bits 8,9,10:
			0 = unknown
			1 = incompatible with PM windowing \
			2 = compatible with PM windowing    > (only for
			3 = uses PM windowing API	   /	programs)
		bit 13: module not loadable (only for programs)
		bits 17,16,15: module type
			000 program
			001 library (DLL)
			011 protected memory library module
			100 physical device driver
			110 virtual device driver
		bit 30: per-process library termination
			(requires valid CS:EIP, can't be set for .EXE)
 14h	DWORD	number of memory pages
 18h	Initial CS:EIP
	DWORD	object number
	DWORD	offset
 20h	Initial SS:ESP
	DWORD	object number
	DWORD	offset
 28h	DWORD	memory page size
 2Ch	DWORD	(Windows LE) bytes on last page
		(OS/2 LX) page offset shift count
 30h	DWORD	fixup section size
 34h	DWORD	fixup section checksum
 38h	DWORD	loader section size
 3Ch	DWORD	loader section checksum
 40h	DWORD	offset of object table (see below)
 44h	DWORD	object table entries
 48h	DWORD	object page map table offset
 4CH	DWORD	object iterate data map offset
 50h	DWORD	resource table offset
 54h	DWORD	resource table entries
 58h	DWORD	resident names table offset
 5Ch	DWORD	entry table offset
 60h	DWORD	module directives table offset
 64h	DWORD	Module Directives entries
 68h	DWORD	Fixup page table offset
 6Ch	DWORD	Fixup record table offset
 70h	DWORD	imported modules name table offset
 74h	DWORD	imported modules count
 78h	DWORD	imported procedures name table offset
 7Ch	DWORD	per-page checksum table offset
 80h	DWORD	data pages offset
 84h	DWORD	preload page count
 88h	DWORD	non-resident names table offset
 8Ch	DWORD	non-resident names table length
 90h	DWORD	non-resident names checksum
 94h	DWORD	automatic data object
 98h	DWORD	debug information offset
 9Ch	DWORD	debug information length
 A0h	DWORD	preload instance pages number
 A4h	DWORD	demand instance pages number
 A8h	DWORD	extra heap allocation
 ACh 20 BYTEs	reserved
 C0h	WORD	device ID (MS-Windows VxD only)
 C2h	WORD	DDK version (MS-Windows VxD only)
Note:	used by EMM386.EXE, QEMM, and Windows 3.0 Enhanced Mode drivers

Format of object table entry:
Offset	Size	Description
 00h	DWORD	virtual size in bytes
 04h	DWORD	relocation base address
 08h	DWORD	object flags (see below)
 0Ch	DWORD	page map index
 10h	DWORD	page map entries
 14h  4 BYTEs	reserved??? (apparently always zeros)

Bitfields for object flags:
 bit 0	readable
 bit 1	writable
 bit 2	executable
 bit 3	resource
 bit 4	discardable
 bit 5	shared
 bit 6	preloaded
 bit 7	invalid
 bit 8-9 type
	00 normal
	01 zero-filled
	10 resident
	11 resident and contiguous
 bit 10 resident and long-lockable
 bit 11 reserved
 bit 12 16:16 alias required
 bit 13 "BIG" (Huge: 32-bit)
 bit 14 conforming
 bit 15 "OBJECT_I/O_PRIVILEGE_LEVEL"
 bits 16-31 reserved

Format of object page map table entry:
Offset	Size	Description
 00h	BYTE	??? (usually 00h)
 01h	WORD	(big-endian) index to fixup table
		0000h if no relocation info
 03h	BYTE	type (00h hard copy in file, 03h some relocation needed)

Format of resident names table entry:
Offset	Size	Description
 00h	BYTE	length of name
 01h  N BYTEs	name
 N+1  3 BYTEs	???

Format of LE linear executable entry table:
Offset	Size	Description
 00h	BYTE	number of entries in table
 01h 10 BYTEs per entry
		Offset	Size	Description
		 00h	BYTE	bit flags
				bit 0: non-empty bundle
				bit 1: 32-bit entry
		 01h	WORD	object number
		 03h	BYTE	entry type flags
				bit 0: exported
				bit 1: uses single data rather than instance
				bit 2: reserved
				bits 3-7: number of stack parameters
		 04h	DWORD	offset of entry point
		 08h  2 BYTEs	???
Note:	empty bundles (bit flags at 00h = 00h) are used to skip unused indices,
	  and do not contain the remaining nine bytes

Format of LX linear executable entry table [array]:
Offset	Size	Description
 00h	BYTE	number of bundles following (00h = end of entry table)
 01h	BYTE	bundle type
		00h empty
		01h 16-bit entry
		02h 286 callgate entry
		03h 32-bit entry
		04h forwarder entry
		bit 7 set if additional parameter typing information is present
---bundle type 00h---
 no additional fields
---bundle type 01h---
 02h	WORD	object number
 04h	BYTE	entry flags
		bit 0: exported
		bits 7-3: number of stack parameters
 05h	WORD	offset of entry point in object (shifted by page size shift)
---bundle type 02h---
 02h	WORD	object number
 04h	BYTE	entry flags
		bit 0: exported
		bits 7-3: number of stack parameters
 05h	WORD	offset of entry point in object
 07h	WORD	reserved for callgate selector (used by loader)
---bundle type 03h---
 02h	WORD	object number
 04h	BYTE	entry flags
		bit 0: exported
		bits 7-3: number of stack parameters
 05h	DWORD	offset of entry point in object
---bundle type 04h---
 02h	WORD	reserved
 04h	BYTE	forwarder flags
		bit 0: import by ordinal
		bits 7-1 reserved
 05h	WORD	module ordinal
		(forwarder's index into Import Module Name table)
 07h	DWORD	procedure name offset or import ordinal number
Note:	all fields after the first two bytes are repeated N times

Bitfields for linear executable fixup type:
 bit 7	ordinal is BYTE rather than WORD
 bit 6	16-bit rather than 8-bit object number/module ordinal
 bit 5	addition with DWORD rather than WORD
 bit 4	relocation info has size with new two bytes at end
 bit 3	reserved (0)
 bit 2	set if add to destination, clear to replace destination
 bits 1-0	type
		00 internal fixup
		01 external fixup, imported by ordinal
		10 external fixup, imported by name
		11 internal fixup via entry table

Format of linear executable fixup record:
Offset	Size	Description
 00h	BYTE	type
		bits 7-4: modifier (0001 single, 0011 multiple)
		bits 3-0: type
			0000 byte offset
			0010 word segment
			0011 16-bit far pointer (DWORD)
			0101 16-bit offset
			0110 32-bit far pointer (PWORD)
			0111 32-bit offset
			1000 near call or jump, WORD/DWORD based on seg attrib
 01h	BYTE	linear executable fixup type (see above)
---if single type---
 02h	WORD	offset within page
 04h	relocation information
	---internal fixup---
	BYTE	object number
	---external,ordinal---
	BYTE	one-based module number in Import Module table
	BYTE/WORD ordinal number
	WORD/DWORD value to add (only present if modifier bit 4 set)
	---external,name---
	BYTE	one-based module number in Import Module table
	WORD	offset in Import Procedure names
	WORD/DWORD value to add (only present if modifier bit 4 set)
---if multiple type---
 02h	BYTE	number of items
 03h	var	relocation info as for "single" type (see above)
      N WORDs	offsets of items to relocate

Format of old Phar Lap .EXP file header:
Offset	Size	Description
 00h  2 BYTEs	"MP" (4Dh 50h) signature
 02h	WORD	remainder of image size / page size (page size = 512h)
 04h	WORD	size of image in pages
 06h	WORD	number of relocation items
 08h	WORD	header size in paragraphs
 0Ah	WORD	minimum number of extra 4K pages to be allocated at the end
		of program, when it is loaded
 0Ch	WORD	maximum number of extra 4K pages to be allocated at the end
		of program, when it is loaded
 0Eh	DWORD	initial ESP
 12h	WORD	word checksum of file
 14h	DWORD	initial EIP
 18h	WORD	offset of first relocation item
 1Ah	WORD	overlay number
 1Ch	WORD	??? (wants to be 1)

Format of new Phar Lap .EXP file header:
Offset	Size	Description
 00h  2 BYTEs	signature ("P2" for 286 .EXP executable, "P3" for 386 .EXP)
 02h	WORD	level (01h flat-model file, 02h multisegmented file)
 04h	WORD	header size
 06h	DWORD	file size in bytes
 0Ah	WORD	checksum
 0Ch	DWORD	offset of run-time parameters within file
 10h	DWORD	size of run-time parameters in bytes
 14h	DWORD	offset of relocation table within file
 18h	DWORD	size of relocation table in bytes
 1Ch	DWORD	offset of segment information table within file
 20h	DWORD	size of segment information table in bytes
 24h	WORD	size of segment information table entry in bytes
 26h	DWORD	offset of load image within file
 2Ah	DWORD	size of load image on disk
 2Eh	DWORD	offset of symbol table within file
 32h	DWORD	size of symbol table in bytes
 36h	DWORD	offset of GDT within load image
 3Ah	DWORD	size of GDT in bytes
 3Eh	DWORD	offset of LDT within load image
 42h	DWORD	size of LDT in bytes
 46h	DWORD	offset of IDT within load image
 4Ah	DWORD	size of IDT in bytes
 4Eh	DWORD	offset of TSS within load image
 52h	DWORD	size of TSS in bytes
 56h	DWORD	minimum number of extra bytes to be allocated at end of program
		(level 1 executables only)
 5Ah	DWORD	maximum number of extra bytes to be allocated at end of program
		(level 1 executables only)
 5Eh	DWORD	base load offset (level 1 executables only)
 62h	DWORD	initial ESP
 66h	WORD	initial SS
 68h	DWORD	initial EIP
 6Ch	WORD	initial CS
 6Eh	WORD	initial LDT
 70h	WORD	initial TSS
 72h	WORD	flags
		bit 0: load image is packed
		bit 1: 32-bit checksum is present
		bits 4-2: type of relocation table
 74h	DWORD	memory requirements for load image
 78h	DWORD	32-bit checksum (optional)
 7Ch	DWORD	size of stack segment in bytes
 80h 256 BYTEs	reserved (0)

Format of Phar Lap segment information table entry:
Offset	Size	Description
 00h	WORD	selector number
 02h	WORD	flags
 04h	DWORD	base offset of selector
 08h	DWORD	minimum number of extra bytes to be allocated to the segment

Format of 386|DOS-Extender run-time parameters:
Offset	Size	Description
 00h  2 BYTEs	signature "DX" (44h 58h)
 02h	WORD	minimum number of real-mode params to leave free at run time
 04h	WORD	maximum number of real-mode params to leave free at run time
 06h	WORD	minimum interrupt buffer size in KB
 08h	WORD	maximum interrupt buffer size in KB
 0Ah	WORD	number of interrupt stacks
 0Ch	WORD	size in KB of each interrupt stack
 0Eh	DWORD	offset of byte past end of real-mode code and data
 12h	WORD	size in KB of call buffers
 14h	WORD	flags
		bit 0: file is virtual memory manager
		bit 1: file is a debugger
 16h	WORD	unprivileged flag (if nonzero, executes at ring 1, 2, or 3)
 18h 104 BYTEs	reserved (0)

Format of Phar Lap repeat block header:
Offset	Size	Description
 00h	WORD	byte count
 02h	BYTE	repeat string length

Format of Borland debugging information header (following load image):
Offset	Size	Description
 00h	WORD	signature 52FBh
 02h	WORD	version ID
 04h	DWORD	size of name pool in bytes
 08h	WORD	number of names in namem pool
 0Ah	WORD	number of type entries
 0Ch	WORD	number of structure members
 0Eh	WORD	number of symbols
 10h	WORD	number of global symbols
 12h	WORD	number of modules
 14h	WORD	number of locals (optional)
 16h	WORD	number of scopes in table
 18h	WORD	number of line-number entries
 1Ah	WORD	number of include files
 1Ch	WORD	number of segment records
 1Eh	WORD	number of segment/file correlations
 20h	DWORD	size of load image after removing uninitialized data and debug
		info
 24h	DWORD	debugger hook; pointer into debugged program whose meaning
		depends on program flags
 28h	BYTE	program flags
		bit 0: case-sensitive link
		bit 1: pascal overlay program
 29h	WORD	no longer used
 2Bh	WORD	size of data pool in bytes
 2Dh	BYTE	padding
 2Eh	WORD	size of following header extension (currently 00h, 10h, or 20h)
 30h	WORD	number of classes
 32h	WORD	number of parents
 34h	WORD	number of global classes (currently unused)
 36h	WORD	number of overloads (currently unused)
 38h	WORD	number of scope classes
 3Ah	WORD	number of module classes
 3Ch	WORD	number of coverage offsets
 3Eh	DWORD	offset relative to symbol base of name pool
 42h	WORD	number of browser information records
 44h	WORD	number of optimized symbol records
 46h	WORD	debugging flags
 48h  8 BYTEs	padding
Note:	additional information on the Borland debugging info may be found in
	  Borland's Open Architecture Handbook
--------U-214B-------------------------------
INT 21 - ELRES v1.0 only - INSTALLATION CHECK
	AH = 4Bh
	DS:DX = 0000h:0000h
Return: ES:BX -> ELRES history structure (see AH=2Bh/CX=454Ch)
	DX = DABEh (signature, DAve BEnnett)
Program: ELRES is an MS-DOS return code (errorlevel) recorder by David H.
	  Bennett
SeeAlso: AH=2Bh/CX=454Ch
--------v-214B04-----------------------------
INT 21 - VIRUS - "MG", "699"/"Thirteen Minutes" - INSTALLATION CHECK
	AX = 4B04h
Return: CF clear if "MG" resident
	AX = 044Bh if "699"/"Thirteen Minutes" resident
SeeAlso: AX=4243h,AX=4B21h
--------D-214B05-----------------------------
INT 21 - DOS 5+ - SET EXECUTION STATE
	AX = 4B05h
	DS:DX -> execution state structure (see below)
Return: CF clear if successful
	    AX = 0000h
	CF set on error
	    AX = error code (see AH=59h)
Note:	used by programs which intercept AX=4B00h to prepare new programs for
	  execution (including setting the DOS version number).	 No DOS, BIOS
	  or other software interrupt may be called after return from this call
	  before commencement of the child process.  If DOS is running in the
	  HMA, A20 is turned off on return from this call.
SeeAlso: AH=4Bh

Format of execution state structure:
Offset	Size	Description
 00h	WORD	reserved (00h)
 02h	WORD	type flags
		bit 0: program is an .EXE
		bit 1: program is an overlay
 04h	DWORD	pointer to ASCIZ name of program file
 08h	WORD	PSP segment of new program
 0Ah	DWORD	starting CS:IP of new program
 0Eh	DWORD	program size including PSP
--------v-214B20-----------------------------
INT 21 - VIRUS - "Holocaust"/"Telefonica" - ???
	AX = 4B20h
SeeAlso: AX=4B04h,AX=4B21h
--------v-214B21-----------------------------
INT 21 C - VIRUS - "Holocaust"/"Telefonica" - ???
	AX = 4B21h
Note:	called at completion of virus installation
SeeAlso: AX=4B04h,AX=4B20h,AX=4B25h
--------v-214B25-----------------------------
INT 21 - VIRUS - "1063"/"Mono" - INSTALLATION CHECK
	AX = 4B25h
Return: DI = 1234h if resident
SeeAlso: AX=4B21h,AX=4B40h
--------v-214B40-----------------------------
INT 21 - VIRUS - "Plastique"/"AntiCad" - INSTALLATION CHECK
	AX = 4B40h
Return: AX = 5678h if resident
SeeAlso: AX=4B25h,AX=4B41h,AX=4B4Ah
--------v-214B41-----------------------------
INT 21 - VIRUS - "Plastique"/"AntiCad" - ???
	AX = 4B41h
	???
Return: ???
SeeAlso: AX=4B40h
--------v-214B4A-----------------------------
INT 21 - VIRUS - "Jabberwocky" - INSTALLATION CHECK
	AX = 4B4Ah
Return: AL = 57h if resident
SeeAlso: AX=4B40h,AX=4B4Bh
--------v-214B4B-----------------------------
INT 21 - VIRUS - "Horse-2" - INSTALLATION CHECK
	AX = 4B4Bh
Return: CF clear if resident
SeeAlso: AX=4B4Ah,AX=4B4Dh
--------v-214B4D-----------------------------
INT 21 - VIRUS - "Murphy-2", "Patricia"/"Smack" - INSTALLATION CHECK
	AX = 4B4Dh
Return: CF clear if resident
SeeAlso: AX=4B4Ah,AX=4B50h
--------v-214B50-----------------------------
INT 21 - VIRUS - "Plastique-2576"/"AntiCad-2576" - INSTALLATION CHECK
	AX = 4B50h
Return: AX = 1234h if resident
SeeAlso: AX=4B4Dh,AX=4B53h,AX=4B60h
--------v-214B53-----------------------------
INT 21 - VIRUS - "Horse" - INSTALLATION CHECK
	AX = 4B53h
Return: CF clear if resident
SeeAlso: AX=4B50h,AX=4B55h
--------v-214B55-----------------------------
INT 21 - VIRUS - "Sparse" - INSTALLATION CHECK
	AX = 4B55h
Return: AX = 1231h if resident
SeeAlso: AX=4B53h,AX=4B59h
--------v-214B59-----------------------------
INT 21 - VIRUS - "Murphy-1", "Murphy-4" - INSTALLATION CHECK
	AX = 4B59h
Return: CF clear if resident
SeeAlso: AX=4B50h,AX=4B5Eh
--------v-214B5E-----------------------------
INT 21 - VIRUS - "Brothers" - INSTALLATION CHECK
	AX = 4B5Eh
Return: CF clear if resident
SeeAlso: AX=4B59h,AX=4B87h
--------v-214B60-----------------------------
INT 21 - VIRUS - "Plastique-2576"/"AntiCad-2576" - ???
	AX = 4B60h
	???
Return: ???
SeeAlso: AX=4B50h
--------v-214B87-----------------------------
INT 21 - VIRUS - "Shirley" - INSTALLATION CHECK
	AX = 4B87h
Return: AX = 6663h if resident
SeeAlso: AX=4B5Eh,AX=4B95h
--------v-214B95-----------------------------
INT 21 - VIRUS - "Zherkov-1882" - INSTALLATION CHECK
	AX = 4B95h
Return: AX = 1973h if resident
SeeAlso: AX=4B87h,AX=4BA7h
--------v-214BA7-----------------------------
INT 21 - VIRUS - "1876"/"Dash-em" - INSTALLATION CHECK
	AX = 4BA7h
Return: AX = B459h if resident
SeeAlso: AX=4B95h,AX=4BAAh
--------v-214BAA-----------------------------
INT 21 - VIRUS - "Nomenklatura" - INSTALLATION CHECK
	AX = 4BAAh
Return: CF clear if resident
SeeAlso: AX=4BA7h,AX=4BAFh
--------v-214BAF-----------------------------
INT 21 - VIRUS - "948"/"Screenplus1", "Magnitogorsk" - INSTALLATION CHECK
	AX = 4BAFh
Return: AL = AFh if "Magnitogorsk" resident
	AL = FAh if "948"/"Screenplus1" resident
SeeAlso: AX=4BAAh,AX=4BDDh
--------v-214BDD-----------------------------
INT 21 - VIRUS - "Lozinsky"/"Zherkov" - INSTALLATION CHECK
	AX = 4BDDh
Return: AX = 1234h
SeeAlso: AX=4BAFh,AX=4BFEh
--------v-214BEE-----------------------------
INT 21 - F-DRIVER.SYS v1.14+ - GRAB INT 21
	AX = 4BEEh
Return: AX = 1234h if grab successful
	   = 2345h if failed (INT 21 grabbed previously)
Notes:	F-DRIVER.SYS is part of the F-PROT virus/trojan protection package by
	  Fridrik Skulason
	when called the first time, this function moves the INT 21 monitoring
	  code from its original location in the INT 21 chain to be the first
	  thing called by INT 21.  This is the mechanism used by F-NET.
SeeAlso: INT 2F/AX=4653h
--------k-214BF0-----------------------------
INT 21 - DIET v1.10+ (Overlay Mode) - INSTALLATION CHECK
	AX = 4BF0h
Return: CF clear if installed
	    AX = 899Dh
Program: DIET is an executable-compression program by Teddy Matsumoto
SeeAlso: AX=37D0h,AX=4BF1h
--------k-214BF1-----------------------------
INT 21 - DIET v1.10+ (Overlay Mode) - EXPAND PROGRAM???
	AX = 4BF1h
Return: ???
SeeAlso: AX=37D0h,AX=4BF0h
--------v-214BFE-----------------------------
INT 21 - VIRUS - "Hitchcock", "Dark Avenger-1028", "1193" - INSTALLATION CHECK
	AX = 4BFEh
Return: AX = 1234h if "Hitchcock" resident
	AX = ABCDh if "1193"/"Copyright" resident
	DI = 55BBh if "Dark Avenger-1028" resident
SeeAlso: AX=4BDDh,AX=4BFFh"Justice"
--------v-214BFF-----------------------------
INT 21 - VIRUS - "USSR-707", "Justice", "Europe 92" - INSTALLATION CHECK
	AX = 4BFFh
Return: BL = FFh if "USSR-707" resident
	DI = 55AAh if "Justice" resident
	CF clear if "Europe 92" resident
SeeAlso: AX=4BFEh,AX=4BFFh"Cascade",AX=5252h
--------v-214BFFSI0000-----------------------
INT 21 - VIRUS - "Cascade" - INSTALLATION CHECK
	AX = 4BFFh
	SI = 0000h
	DI = 0000h
Return: DI = 55AAh if installed
SeeAlso: AX=4BFFh"Justice",AX=5252h
--------D-214C-------------------------------
INT 21 - DOS 2+ - "EXIT" - TERMINATE WITH RETURN CODE
	AH = 4Ch
	AL = return code
Return: never returns
Notes:	unless the process is its own parent (see AH=26h, offset 16h in PSP),
	  all open files are closed and all memory belonging to the process
	  is freed
	all network file locks should be removed before calling this function
SeeAlso: AH=00h,AH=26h,AH=4Bh,AH=4Dh,INT 15/AH=12h/BH=02h,INT 20,INT 22
SeeAlso: INT 60/DI=0601h
----------214C57-----------------------------
INT 21 - Headroom - ???
	AX = 4C57h
	DS:DX -> target address
Note:	jumps to target address instead of terminating program
SeeAlso: AX=5758h
--------D-214D-------------------------------
INT 21 - DOS 2+ - GET RETURN CODE (ERRORLEVEL)
	AH = 4Dh
Return: AH = termination type
	    00h normal (INT 20,INT 21/AH=00h, or INT 21/AH=4Ch)
	    01h control-C abort
	    02h critical error abort
	    03h terminate and stay resident (INT 21/AH=31h or INT 27)
	AL = return code
Notes:	the word in which DOS stores the return code is cleared after being
	  read by this function, so the return code can only be retrieved once
	COMMAND.COM stores the return code of the last external command it
	  executed as ERRORLEVEL
	this call should not be used if the child was started with AX=4B04h;
	  use AH=8Ah instead
	the following sequence will close a Virtual DOS Machine under OS/2 2.0:
	  MOV	AH,4Dh
	  INT	21h
	  HLT
	  DB	02h,0FDh
	  This sequence is the only way to close a specific VDM which was
	  booted from floppy or a disk image.
SeeAlso: AH=4Bh,AH=4Ch,AH=8Ah
--------D-214E-------------------------------
INT 21 - DOS 2+ - "FINDFIRST" - FIND FIRST MATCHING FILE
	AH = 4Eh
	AL = special flag for use by APPEND (see note below)
	CX = file attribute mask (see AX=4301h) (bits 0 and 5 ignored)
	    0088h (Novell DOS 7) find first deleted file
	DS:DX -> ASCIZ file specification (may include path and wildcards)
Return: CF clear if successful
	    [DTA] = FindFirst data block (see below)
	CF set on error
	    AX = error code (02h,03h,12h) (see AH=59h)
Notes:	for search attributes other than 08h, all files with at MOST the
	  specified combination of hidden, system, and directory attributes
	  will be returned.  Under DOS 2.x, searching for attribute 08h
	  (volume label) will also return normal files, while under DOS 3+
	  only the volume label (if any) will be returned.
	this call also returns successfully if given the name of a character
	  device without wildcards.  DOS 2.x returns attribute 00h, size 0,
	  and the current date and time.  DOS 3+ returns attribute 40h and the
	  current date and time.
	immediately after an INT 2F/AX=B711h (APPEND return found name), the
	  name at DS:DX will be overwritten; if AL=00h on entry, the actual
	  found pathname will be stored, otherwise, the actual found path
	  will be prepended to the original filespec without a path.
	under LANtastic, this call may be used to obtain a list of a server's
	  shared resources by searching for "\\SERVER\*.*"; a list of printer
	  resources may be obtained by searching for "\\SERVER\@*.*"
	under the FlashTek X-32 DOS extender, the filespec pointer is in DS:EDX
BUGS:	under DOS 3.x and 4.x, the second and subsequent calls to this function
	  with a character device name (no wildcards) and search attributes
	  which include the volume-label bit (08h) will fail unless there is
	  an intervening DOS call which implicitly or explicity performs a
	  directory search without the volume-label bit.  Such implicit
	  searches are performed by CREATE (AH=3Ch), OPEN (AH=3Dh), UNLINK
	  (AH=41h), and RENAME (AH=56h)
	DR-DOS 3.41 and 5.0 return the Directory attribute for the volume label
SeeAlso: AH=11h,AH=4Fh,AX=4301h,INT 2F/AX=111Bh,INT 2F/AX=B711h

Format of FindFirst data block:
Offset	Size	Description
---PC-DOS 3.10, PC-DOS 4.01, MS-DOS 3.2/3.3/5.0---
 00h	BYTE	drive letter (bits 0-6), remote if bit 7 set
 01h 11 BYTEs	search template
 0Ch	BYTE	search attributes
---DOS 2.x (and some DOS 3.x???)---
 00h	BYTE	search attributes
 01h	BYTE	drive letter
 02h 11 BYTEs	search template
---WILDUNIX.COM---
 00h 12 BYTEs	15-character wildcard search pattern and drive letter (packed)
 0Ch	BYTE	search attributes
---DOS 2.x and most 3.x---
 0Dh	WORD	entry count within directory
 0Fh	DWORD	pointer to DTA???
 13h	WORD	cluster number of start of parent directory
---PC-DOS 4.01, MS-DOS 3.2/3.3/5.0---
 0Dh	WORD	entry count within directory
 0Fh	WORD	cluster number of start of parent directory
 11h  4 BYTEs	reserved
---all versions, documented fields---
 15h	BYTE	attribute of file found
 16h	WORD	file time
		    bits 11-15: hour
		    bits 5-10:	minute
		    bits 0-4:	seconds/2
 18h	WORD	file date
		    bits 9-15:	year-1980
		    bits 5-8:	month
		    bits 0-4:	day
 1Ah	DWORD	file size
 1Eh 13 BYTEs	ASCIZ filename+extension
--------f-214E-------------------------------
INT 21 - WILDUNIX.COM internal - INSTALLATION CHECK
	AH = 4Eh
	DS:DX = 0000h:0000h
Return: AH = 99h if installed
Program: WILDUNIX.COM is a resident Unix-style wildcard expander by Steve
	  Hosgood and Terry Barnaby
--------D-214F-------------------------------
INT 21 - DOS 2+ - "FINDNEXT" - FIND NEXT MATCHING FILE
	AH = 4Fh
	[DTA] = data block from previous FindFirst or FindNext call
Return: CF clear if successful
	CF set on error
	    AX = error code (12h) (see AH=59h)
Note:	under Novell DOS 7, if the FindFirst call (AH=4Eh) had CX=0088h, then
	  the next matching deleted file will be returned
BUG:	DR-DOS 3.41 and 5.0 return the Directory attribute for the volume label
SeeAlso: AH=12h,AH=4Eh
--------D-2150-------------------------------
INT 21 - DOS 2+ internal - SET CURRENT PROCESS ID (SET PSP ADDRESS)
	AH = 50h
	BX = segment of PSP for new process
Notes:	DOS uses the current PSP address to determine which processes own files
	  and memory; it corresponds to process identifiers used by other OSs
	under DOS 2.x, this function cannot be invoked inside an INT 28h
	  handler without setting the Critical Error flag
	under MS-DOS 3+ and DR-DOS 3.41+, this function does not use any of
	  the DOS-internal stacks and may thus be called at any time, even
	  during another INT 21h call
	some Microsoft applications such as Quick C 2.51 use segments of 0000h
	  and FFFFh and direct access to the SDA (see AX=5D06h) to test whether
	  they are running under MS-DOS rather than a compatible OS; although
	  one should only call this function with valid PSP addresses, any
	  program hooking it should be prepared to handle invalid addresses
	supported by OS/2 compatibility box
	this call was undocumented prior to the release of DOS 5.0
SeeAlso: AH=26h,AH=51h,AH=62h
--------D-2151-------------------------------
INT 21 - DOS 2+ internal - GET CURRENT PROCESS ID (GET PSP ADDRESS)
	AH = 51h
Return: BX = segment of PSP for current process
Notes:	DOS uses the current PSP address to determine which processes own files
	  and memory; it corresponds to process identifiers used by other OSs
	under DOS 2.x, this function cannot be invoked inside an INT 28h
	  handler without setting the Critical Error flag
	under DOS 3+, this function does not use any of the DOS-internal stacks
	  and may thus be called at any time, even during another INT 21h call
	supported by OS/2 compatibility box
	identical to the documented AH=62h
	this call was undocumented prior to the release of DOS 5.0
SeeAlso: AH=26h,AH=50h,AH=62h
--------D-2152-------------------------------
INT 21 U - DOS 2+ internal - "SYSVARS" - GET LIST OF LISTS
	AH = 52h
Return: ES:BX -> DOS list of lists
Notes:	partially supported by OS/2 v1.1 compatibility box (however, most
	  pointers are FFFFh:FFFFh, LASTDRIVE is FFh, and the NUL header "next"
	  pointer is FFFFh:FFFFh).
	on return, ES points at the DOS data segment (see also INT 2F/AX=1203h)
SeeAlso: INT 2F/AX=1203h

Format of List of Lists:
Offset	Size	Description
 -24	WORD	(DOS 3.1+) contents of CX from INT 21/AX=5E01h
 -22	WORD	(DOS ???+) LRU counter for FCB caching
 -20	WORD	(DOS ???+) LRU counter for FCB opens
 -18	DWORD	(DOS ???+) address of OEM function handler (see INT 21/AH=F8h)
			FFFFh:FFFFh if not installed or not available
 -14	WORD	(DOS ???+) offset in DOS CS of code to return from INT 21 call
 -12	WORD	(DOS 3.1+) sharing retry count (see AX=440Bh)
 -10	WORD	(DOS 3.1+) sharing retry delay (see AX=440Bh)
 -8	DWORD	(DOS 3+) pointer to current disk buffer
 -4	WORD	(DOS 3+) pointer in DOS code segment of unread CON input
		when CON is read via a handle, DOS reads an entire line,
		  and returns the requested portion, buffering the rest
		  for the next read.  0000h indicates no unread input
 -2	WORD	segment of first memory control block
 00h	DWORD	pointer to first Drive Parameter Block (see AH=32h)
 04h	DWORD	pointer to first System File Table (see below)
 08h	DWORD	pointer to active CLOCK$ device's header (most recently loaded
		driver with CLOCK bit set)
 0Ch	DWORD	pointer to active CON device's header (most recently loaded
		driver with STDIN bit set)
---DOS 2.x---
 10h	BYTE	number of logical drives in system
 11h	WORD	maximum bytes/block of any block device
 13h	DWORD	pointer to first disk buffer (see below)
 17h 18 BYTEs	actual NUL device driver header (not a pointer!)
		NUL is always the first device on DOS's linked list of device
		drivers. (see below)
---DOS 3.0---
 10h	BYTE	number of block devices
 11h	WORD	maximum bytes/block of any block device
 13h	DWORD	pointer to first disk buffer (see below)
 17h	DWORD	pointer to array of current directory structures (see below)
 1Bh	BYTE	value of LASTDRIVE command in CONFIG.SYS (default 5)
 1Ch	DWORD	pointer to STRING= workspace area
 20h	WORD	size of STRING area (the x in STRING=x from CONFIG.SYS)
 22h	DWORD	pointer to FCB table
 26h	WORD	the y in FCBS=x,y from CONFIG.SYS
 28h 18 BYTEs	actual NUL device driver header (not a pointer!)
		NUL is always the first device on DOS's linked list of device
		drivers. (see below)
---DOS 3.1-3.3---
 10h	WORD	maximum bytes per sector of any block device
 12h	DWORD	pointer to first disk buffer in buffer chain (see below)
 16h	DWORD	pointer to array of current directory structures (see below)
 1Ah	DWORD	pointer to system FCB tables (see below)
 1Eh	WORD	number of protected FCBs (the y in the CONFIG.SYS FCBS=x,y)
 20h	BYTE	number of block devices installed
 21h	BYTE	number of available drive letters (largest of 5, installed
		block devices, and CONFIG.SYS LASTDRIVE=).  Also size of
		current directory structure array.
 22h 18 BYTEs	actual NUL device driver header (not a pointer!)
		NUL is always the first device on DOS's linked list of device
		drivers. (see below)
 34h	BYTE	number of JOIN'ed drives
---DOS 4.x---
 10h	WORD	maximum bytes per sector of any block device
 12h	DWORD	pointer to disk buffer info record (see below)
 16h	DWORD	pointer to array of current directory structures (see below)
 1Ah	DWORD	pointer to system FCB tables (see below)
 1Eh	WORD	number of protected FCBs (the y in the CONFIG.SYS FCBS=x,y)
		(always 00h for DOS 5.0)
 20h	BYTE	number of block devices installed
 21h	BYTE	number of available drive letters (largest of 5, installed
		block devices, and CONFIG.SYS LASTDRIVE=).  Also size of
		current directory structure array.
 22h 18 BYTEs	actual NUL device driver header (not a pointer!)
		NUL is always the first device on DOS's linked list of device
		drivers. (see below)
 34h	BYTE	number of JOIN'ed drives
 35h	WORD	pointer within IBMDOS code segment to list of special program
		names (see below)
		(always 0000h for DOS 5.0)
 37h	DWORD	pointer to FAR routine for resident IFS utility functions
		(see below)
		may be called by any IFS driver which does not wish to
		service functions 20h or 24h-28h itself
 3Bh	DWORD	pointer to chain of IFS (installable file system) drivers
 3Fh	WORD	the x in BUFFERS x,y (rounded up to multiple of 30 if in EMS)
 41h	WORD	number of lookahead buffers (the y in BUFFERS x,y)
 43h	BYTE	boot drive (1=A:)
 44h	BYTE	flag: 01h to use DWORD moves (80386+), 00h otherwise
 45h	WORD	extended memory size in KB
---DOS 5.0-6.0---
 10h 39 BYTEs	as for DOS 4.x (see above)
 37h	DWORD	pointer to SETVER program list or 0000h:0000h
 3Bh	WORD	(DOS=HIGH) offset in DOS CS of function to fix A20 control
		when executing special .COM format
 3Dh	WORD	PSP of most-recently EXECed program if DOS in HMA, 0000h if low
 3Fh  8 BYTEs	as for DOS 4.x (see above)

Format of memory control block (see also below):
Offset	Size	Description
 00h	BYTE	block type: 5Ah if last block in chain, otherwise 4Dh
 01h	WORD	PSP segment of owner or
		0000h if free
		0006h if DR-DOS XMS UMB
		0007h if DR-DOS excluded upper memory ("hole")
		0008h if belongs to DOS
		FFFAh if 386MAX UMB control block (see AX=4402h"386MAX")
		FFFDh if 386MAX locked-out memory
		FFFEh if 386MAX UMB (immediately follows its control block)
		FFFFh if 386MAX 6.01 device driver
 03h	WORD	size of memory block in paragraphs
 05h  3 BYTEs	unused by MS-DOS
		(386MAX) if locked-out block, region start/prev region end
---DOS 2.x,3.x---
 08h  8 BYTEs	unused
---DOS 4+ ---
 08h  8 BYTEs	ASCII program name if PSP memory block or DR-DOS UMB,
		  else garbage
		null-terminated if less than 8 characters
Notes:	the next MCB is at segment (current + size + 1)
	under DOS 3.1+, the first memory block is the DOS data segment,
	  containing installable drivers, buffers, etc.	 Under DOS 4+ it is
	  divided into subsegments, each with its own memory control block
	  (see below), the first of which is at offset 0000h.
	for DOS 5+, blocks owned by DOS may have either "SC" or "SD" in bytes
	  08h and 09h.	"SC" is system code or locked-out inter-UMB memory,
	  "SD" is system data, device drivers, etc.
	Some versions of DR-DOS use only seven characters of the program name,
	  placing a NUL in the eighth byte.

Format of MS-DOS 5+ UMB control block:
Offset	Size	Description
 00h	BYTE	type: 5Ah if last block in chain, 4Dh otherwise
 01h	WORD	first available paragraph in UMB if control block at start
		of UMB, 000Ah if control block at end of UMB
 03h	WORD	length in paragraphs of following UMB or locked-out region
 05h  3 BYTEs	unused
 08h  8 BYTEs	block type name: "UMB" if start block, "SM" if end block in UMB

Format of STARLITE (General Software's Embedded DOS) memory control block:
Offset	Size	Description
 00h	BYTE	block type: 5Ah if last block in chain, otherwise 4Dh
 01h	WORD	PSP segment of owner, 0000h if free, 0008h if belongs to DOS
 03h	WORD	size of memory block in paragraphs
 05h	BYTE	unused
 06h	WORD	segment address of next memory control block (0000h if last)
 08h	WORD	segment address of previous memory control block or 0000h
 0Ah  6 BYTEs	reserved

Format of DOS 4+ data segment subsegment control blocks:
Offset	Size	Description
 00h	BYTE	subsegment type (blocks typically appear in this order)
		"D"  device driver
		"E"  device driver appendage
		"I"  IFS (Installable File System) driver
		"F"  FILES=  control block storage area (for FILES>5)
		"X"  FCBS=   control block storage area, if present
		"C"  BUFFERS EMS workspace area (if BUFFERS /X option used)
		"B"  BUFFERS=  storage area
		"L"  LASTDRIVE=	 current directory structure array storage area
		"S"  STACKS=  code and data area, if present (see below)
		"T"  INSTALL= transient code
 01h	WORD	paragraph of subsegment start (usually the next paragraph)
 03h	WORD	size of subsegment in paragraphs
 05h  3 BYTEs	unused
 08h  8 BYTEs	for types "D" and "I", base name of file from which the driver
		  was loaded (unused for other types)

Format of data at start of STACKS code segment (if present):
Offset	Size	Description
 00h	WORD	???
 02h	WORD	number of stacks (the x in STACKS=x,y)
 04h	WORD	size of stack control block array (should be 8*x)
 06h	WORD	size of each stack (the y in STACKS=x,y)
 08h	DWORD	pointer to STACKS data segment
 0Ch	WORD	offset in STACKS data segment of stack control block array
 0Eh	WORD	offset in STACKS data segment of last element of that array
 10h	WORD	offset in STACKS data segment of the entry in that array for
		the next stack to be allocated (initially same as value in 0Eh
		and works its way down in steps of 8 to the value in 0Ch as
		hardware interrupts pre-empt each other)
Note:	the STACKS code segment data may, if present, be located as follows:
    DOS 3.2:	The code segment data is at a paragraph boundary fairly early
		in the IBMBIO segment (seen at 0070:0190h)
    DOS 3.3:	The code segment is at a paragraph boundary in the DOS data
		segment, which may be determined by inspecting the segment
		pointers of the vectors for those of interrupts 02h, 08h-0Eh,
		70h, 72-77h which have not been redirected by device drivers or
		TSRs.
    DOS 4+	Identified by sub-segment control block type "S" within the DOS
		data segment.
SeeAlso: INT B4"STACKMAN"

Format of array elements in STACKS data segment:
Offset	Size	Description
 00h	BYTE	status: 00h=free, 01h=in use, 03h=corrupted by overflow of
		higher stack.
 01h	BYTE	not used
 02h	WORD	previous SP
 04h	WORD	previous SS
 06h	WORD	ptr to word at top of stack (new value for SP). The word at the
		top of the stack is preset to point back to this control block.

SHARE.EXE hooks (DOS 3.1-6.00):
(offsets from first system file table--pointed at by ListOfLists+04h)
Offset	Size	Description
-3Ch	DWORD	pointer to FAR routine for ???
		Note: not called by MS-DOS 3.3, set to 0000h:0000h by
			SHARE 3.3+
-38h	DWORD	pointer to FAR routine called on opening file
		on call, internal DOS location points at filename(see AX=5D06h)
		Return: CF clear if successful
			CF set on error
			    AX = DOS error code (24h) (see AH=59h)
		Note: SHARE directly accesses DOS-internal data to get name of
			file just opened
-34h	DWORD	pointer to FAR routine called on closing file
		ES:DI -> system file table
		Note: does something to every Record Lock Record for file
-30h	DWORD	pointer to FAR routine to close all files for given computer
		(called by AX=5D03h)
-2Ch	DWORD	pointer to FAR routine to close all files for given process
		(called by AX=5D04h)
-28h	DWORD	pointer to FAR routine to close file by name
		(called by AX=5D02h)
		DS:SI -> DOS parameter list (see AX=5D00h)
		   DPL's DS:DX -> name of file to close
		Return: CF clear if successful
			CF set on error
			    AX = DOS error code (03h) (see AH=59h)
-24h	DWORD	pointer to FAR routine to lock region of file
		call with BX = file handle
			  ---DOS 3.x---
			  CX:DX = starting offset
			  SI:AX = size
			  ---DOS 4+---
			  DS:DX -> lock range
					DWORD start offset
					DWORD size in bytes
		Return: CF set on error
			    AL = DOS error code (21h) (see AH=59h)
		Note: not called if file is marked as remote
-20h	DWORD	pointer to FAR routine to unlock region of file
		call with BX = file handle
			  ---DOS 3.x---
			  CX:DX = starting offset
			  SI:AX = size
			  ---DOS 4+---
			  DS:DX -> lock range
					DWORD start offset
					DWORD size in bytes
		Return: CF set on error
			    AL = DOS error code (21h) (see AH=59h)
		Note: not called if file is marked as remote
-1Ch	DWORD	pointer to FAR routine to check if file region is locked
		call with ES:DI -> system file table entry for file
			CX = length of region from current position in file
		Return: CF set if any portion of region locked
			    AX = 0021h
-18h	DWORD	pointer to FAR routine to get open file list entry
		(called by AX=5D05h)
		call with DS:SI -> DOS parameter list (see AX=5D00h)
			DPL's BX = index of sharing record
			DPL's CX = index of SFT in SFT chain of sharing rec
		Return: CF set on error or not loaded
			    AX = DOS error code (12h) (see AH=59h)
			CF clear if successful
			    ES:DI -> filename
			    CX = number of locks owned by specified SFT
			    BX = network machine number
			    DX destroyed
-14h	DWORD	pointer to FAR routine for updating FCB from SFT???
		call with DS:SI -> unopened FCB
			  ES:DI -> system file table entry
		Return: BL = C0h???
		Note: copies following fields from SFT to FCB:
		   starting cluster of file	  0Bh	 1Ah
		   sharing record offset	  33h	 1Ch
		   file attribute		  04h	 1Eh
-10h	DWORD	pointer to FAR routine to get first cluster of FCB file ???
		call with ES:DI -> system file table entry
			  DS:SI -> FCB
		Return: CF set if SFT closed or sharing record offsets
				mismatched
			CF clear if successful
			    BX = starting cluster number from FCB
-0Ch	DWORD	pointer to FAR routine to close file if duplicate for process
		DS:SI -> system file table
		Return: AX = number of handle in JFT which already uses SFT
		Note: called during open/create of a file
		Note: if SFT was opened with inheritance enabled and sharing
			mode 111, does something to all other SFTs owned by
			same process which have the same file open mode and
			sharing record
-08h	DWORD	pointer to FAR routine for closing file
		Note: closes various handles referring to file most-recently
			opened
-04h	DWORD	pointer to FAR routine to update directory info in related SFT
		  entries
		call with ES:DI -> system file table entry for file (see below)
			  AX = subfunction (apply to each related SFT)
				00h: update time stamp (offset 0Dh) and date
				     stamp (offset 0Fh)
				01h: update file size (offset 11h) and starting
				     cluster (offset 0Bh).  Sets last-accessed
				     cluster fields to start of file if file
				     never accessed
				02h: as function 01h, but last-accessed fields
				     always changed
				03h: do both functions 00h and 02h
		Note: follows ptr at offset 2Bh in system file table entries
		Note: NOP if opened with no-inherit or via FCB
Notes:	most of the above hooks (except -04h, -14h, -18h, and -3Ch) assume
	  either that SS=DOS DS or SS=DS=DOS DS and directly access
	  DOS-internal data
	sharing hooks are not supported by DR-DOS 5-6; will reportedly be
	  supported by Novell DOS 7

Format of sharing record:
Offset	Size	Description
 00h	BYTE	flag
		00h free block
		01h allocated block
		FFh end marker
 01h	WORD	size of block
 03h	BYTE	checksum of pathname (including NUL)
		if sum of ASCII values is N, checksum is (N/256 + N%256)
 04h	WORD	offset in SHARE's DS of first Record Lock Record (see below)
 06h	DWORD	pointer to start of system file table chain for file
 0Ah	WORD	unique sequence number
 0Ch	var	ASCIZ full pathname
Note:	not supported by DR-DOS SHARE 1.1 and 2.0; will reportedly be
	  supported by Novell DOS 7

Format of Record Lock Record (SHARE.EXE):
Offset	Size	Description
 00h	WORD	offset in SHARE's DS of next lock table in list or 0000h
 02h	DWORD	offset in file of start of locked region
 06h	DWORD	offset in file of end of locked region
 0Ah	DWORD	pointer to System File Table entry for this file
 0Eh	WORD	PSP segment of lock's owner
---DOS 5+ ---
 10h	WORD	lock type: (00h lock all, 01h lock writes only)

Format of DOS 2.x system file tables:
Offset	Size	Description
 00h	DWORD	pointer to next file table (offset FFFFh if last)
 04h	WORD	number of files in this table
 06h  28h bytes per file
	Offset	Size	Description
	 00h	BYTE	number of file handles referring to this file
	 01h	BYTE	file open mode (see AH=3Dh)
	 02h	BYTE	file attribute
	 03h	BYTE	drive (0 = character device, 1 = A, 2 = B, etc)
	 04h 11 BYTEs	filename in FCB format (no path,no period,blank-padded)
	 0Fh	WORD	???
	 11h	WORD	???
	 13h	DWORD	file size???
	 17h	WORD	file date in packed format (see AX=5700h)
	 19h	WORD	file time in packed format (see AX=5700h)
	 1Bh	BYTE	device attribute (see AX=4400h)
	---character device---
	 1Ch	DWORD	pointer to device driver
	---block device---
	 1Ch	WORD	starting cluster of file
	 1Eh	WORD	relative cluster in file of last cluster accessed
	------
	 20h	WORD	absolute cluster number of current cluster
	 22h	WORD	???
	 24h	DWORD	current file position???

Format of DOS 3.0 system file tables and FCB tables:
Offset	Size	Description
 00h	DWORD	pointer to next file table (offset FFFFh if last)
 04h	WORD	number of files in this table
 06h  38h bytes per file
	Offset	Size	Description
	 00h-1Eh as for DOS 3.1+ (see below)
	 1Fh	WORD	byte offset of directory entry within sector
	 21h 11 BYTES	filename in FCB format (no path/period, blank-padded)
	 2Ch	DWORD	(SHARE.EXE) pointer to previous SFT sharing same file
	 30h	WORD	(SHARE.EXE) network machine number which opened file
			(Windows Enhanced mode DOSMGR uses the virtual machine
			ID as the machine number; see INT 2F/AX=1683h)
	 32h	WORD	PSP segment of file's owner (first three entries for
			AUX/CON/PRN contain segment of IO.SYS startup code)
	 34h	WORD	(SHARE.EXE) offset in SHARE code seg of share record
	 36h	WORD	??? apparently always 0000h

Format of DOS 3.1-3.3x, DR-DOS 5.0-6.0 system file tables and FCB tables:
Offset	Size	Description
 00h	DWORD	pointer to next file table (offset FFFFh if last)
 04h	WORD	number of files in this table
 06h  35h bytes per file
	Offset	Size	Description
	 00h	WORD	number of file handles referring to this file
	 02h	WORD	file open mode (see AH=3Dh)
			bit 15 set if this file opened via FCB
	 04h	BYTE	file attribute (see AX=4301h)
	 05h	WORD	device info word (see AX=4400h)
			bit 15 set if remote file
			bit 14 set means do not set file date/time on closing
			bit 12 set means don't inherit on EXEC
			bits 5-0 drive number for disk files
	 07h	DWORD	pointer to device driver header if character device
			else pointer to DOS Drive Parameter Block (see AH=32h)
	 0Bh	WORD	starting cluster of file
	 0Dh	WORD	file time in packed format (see AX=5700h)
			not used for character devices in DR-DOS
	 0Fh	WORD	file date in packed format (see AX=5700h)
			not used for character devices in DR-DOS
	 11h	DWORD	file size
	---system file table---
	 15h	DWORD	current offset in file (may be larger than size of
			file; INT 21/AH=42h does not check new position)
	---FCB table---
	 15h	WORD	counter for last I/O to FCB
	 17h	WORD	counter for last open of FCB
			(these are separate to determine the times of the
			latest I/O and open)
	---
	 19h	WORD	relative cluster within file of last cluster accessed
	 1Bh	WORD	absolute cluster number of last cluster accessed
			0000h if file never read or written???
	 1Dh	WORD	number of sector containing directory entry
	 1Fh	BYTE	number of dir entry within sector (byte offset/32)
	 20h 11 BYTEs	filename in FCB format (no path/period, blank-padded)
	 2Bh	DWORD	(SHARE.EXE) pointer to previous SFT sharing same file
	 2Fh	WORD	(SHARE.EXE) network machine number which opened file
			(Windows Enhanced mode DOSMGR uses the virtual machine
			ID as the machine number; see INT 2F/AX=1683h)
	 31h	WORD	PSP segment of file's owner (see AH=26h) (first three
			entries for AUX/CON/PRN contain segment of IO.SYS
			startup code)
	 33h	WORD	offset within SHARE.EXE code segment of
			sharing record (see above)  0000h = none

Format of DOS 4.0-6.0 system file tables and FCB tables:
Offset	Size	Description
 00h	DWORD	pointer to next file table (offset FFFFh if last)
 04h	WORD	number of files in this table
 06h  3Bh bytes per file
	Offset	Size	Description
	 00h	WORD	number of file handles referring to this file
			FFFFh if in use but not referenced
	 02h	WORD	file open mode (see AH=3Dh)
			bit 15 set if this file opened via FCB
	 04h	BYTE	file attribute (see AX=4301h)
	 05h	WORD	device info word (see also AX=4400h)
			bit 15 set if remote file
			bit 14 set means do not set file date/time on closing
			bit 13 set if named pipe
			bit 12 set if no inherit
			bit 11 set if network spooler
			bit 7  set if device, clear if file (only if local)
			bits 6-0 as for AX=4400h
	 07h	DWORD	pointer to device driver header if character device
			else pointer to DOS Drive Parameter Block (see AH=32h)
			or REDIR data
	 0Bh	WORD	starting cluster of file (local files only)
	 0Dh	WORD	file time in packed format (see AX=5700h)
	 0Fh	WORD	file date in packed format (see AX=5700h)
	 11h	DWORD	file size
	 15h	DWORD	current offset in file (SFT)
			LRU counters (FCB table, two WORDs)
	---local file---
	 19h	WORD	relative cluster within file of last cluster accessed
	 1Bh	DWORD	number of sector containing directory entry
	 1Fh	BYTE	number of dir entry within sector (byte offset/32)
	---network redirector---
	 19h	DWORD	pointer to REDIRIFS record
	 1Dh  3 BYTEs	???
	------
	 20h 11 BYTEs	filename in FCB format (no path/period, blank-padded)
	 2Bh	DWORD	(SHARE.EXE) pointer to previous SFT sharing same file
	 2Fh	WORD	(SHARE.EXE) network machine number which opened file
			(Windows Enhanced mode DOSMGR uses the virtual machine
			ID as the machine number; see INT 2F/AX=1683h)
	 31h	WORD	PSP segment of file's owner (see AH=26h) (first three
			entries for AUX/CON/PRN contain segment of IO.SYS
			startup code)
	 33h	WORD	offset within SHARE.EXE code segment of
			sharing record (see above)  0000h = none
	 35h	WORD	(local) absolute cluster number of last clustr accessed
			(redirector) ???
	 37h	DWORD	pointer to IFS driver for file, 0000000h if native DOS
Note:	the OS/2 2.0 DOS Boot Session does not properly fill in the filename
	  field due to incomplete support for SFTs; the OS/2 2.0 DOS Window
	  does not appear to support SFTs at all

Format of current directory structure (CDS) (array, LASTDRIVE entries):
Offset	Size	Description
 00h 67 BYTEs	ASCIZ path in form X:\PATH (local) or \\MACH\PATH (network)
 43h	WORD	drive attributes (see also note below and AX=5F07h)
		bit 15: uses network redirector	 \ invalid if 00, installable
		bit 14: physical drive		 / file system if 11
		bit 13: JOIN'ed	  \ path above is true path that would be
		bit 12: SUBST'ed  / needed if not under SUBST or JOIN
		bit  7: remote drive hidden from redirector's assign-list and
			  exempt from network connection make/break commands;
			  set for CD-ROM drives
 45h	DWORD	pointer to Drive Parameter Block for drive (see AH=32h)
---local drives---
 49h	WORD	starting cluster of current directory
		0000h = root, FFFFh = never accessed
 4Bh	WORD	??? seems to be FFFFh always
 4Dh	WORD	??? seems to be FFFFh always
---network drives---
 49h	DWORD	pointer to redirector or REDIRIFS record, or FFFFh:FFFFh
		(DOS 4 only) available for use by IFS driver
 4Dh	WORD	stored user data from INT 21/AX=5F03h
------
 4Fh	WORD	offset in current directory path of backslash corresponding to
		  root directory for drive
		this value specifies how many characters to hide from the
		  "CHDIR" and "GETDIR" calls; normally set to 2 to hide the
		  drive letter and colon, SUBST, JOIN, and networks change it
		  so that only the appropriate portion of the true path is
		  visible to the user
---DOS 4+ ---
 51h	BYTE	(DOS 4 only, remote drives) device type
		04h network drive
 52h	DWORD	pointer to IFS driver (DOS 4) or redirector block (DOS 5+) for
		this drive, 00000000h if native DOS
 56h	WORD	available for use by IFS driver
Notes:	the path for invalid drives is normally set to X:\, but may be empty
	  after JOIN x: /D in DR-DOS 5.0 or NET USE x: /D in older LAN versions
	normally, only one of bits 13&12 may be set together with bit 14, but
	  DR-DOS 5.0 uses other combinations for bits 15-12: 0111 JOIN,
	  0001 SUBST, 0101 ASSIGN (see below)

Format of DR-DOS 5.0-6.0 current directory structure entry (array):
Offset	Size	Description
 00h 67 BYTEs	ASCIZ pathname of actual root directory for this logical drive
 43h	WORD	drive attributes
		1000h SUBSTed drive
		3000h??? JOINed drive
		4000h physical drive
		5000h ASSIGNed drive
		7000h JOINed drive
		8000h network drive
 45h	BYTE	physical drive number (0=A:) if this logical drive is valid
 46h	BYTE	??? apparently flags for JOIN and ASSIGN
 47h	WORD	cluster number of start of parent directory (0000h = root)
 49h	WORD	entry number of current directory in parent directory
 4Bh	WORD	cluster number of start of current directory
 4Dh	WORD	used for media change detection (details not available)
 4Fh	WORD	cluster number of SUBST/JOIN "root" directory
		0000h if physical root directory

Format of device driver header:
Offset	Size	Description
 00h	DWORD	pointer to next driver, offset=FFFFh if last driver
 04h	WORD	device attributes
		Character device:
		   bit 15 set (indicates character device)
		   bit 14 IOCTL supported (see AH=44h)
		   bit 13 (DOS 3+) output until busy supported
		   bit 12 reserved
		   bit 11 (DOS 3+) OPEN/CLOSE/RemMedia calls supported
		   bits 10-8 reserved
		   bit 7  (DOS 5+) Generic IOCTL check call supported (cmd 19h)
				(see AX=4410h,AX=4411h)
		   bit 6  (DOS 3.2+) Generic IOCTL call supported (command 13h)
				(see AX=440Ch,AX=440Dh)
		   bit 5  reserved
		   bit 4  device is special (use INT 29 "fast console output")
		   bit 3  device is CLOCK$ (all reads/writes use transfer
				record described below)
		   bit 2  device is NUL
		   bit 1  device is standard output
		   bit 0  device is standard input
		Block device:
		   bit 15 clear (indicates block device)
		   bit 14 IOCTL supported
		   bit 13 non-IBM format
		   bit 12 network device (device is remote)
		   bit 11 (DOS 3+) OPEN/CLOSE/RemMedia calls supported
		   bit 10 reserved
		   bit 9  direct I/O not allowed???
			  (set by DOS 3.3 DRIVER.SYS for "new" drives)
		   bit 8  ??? set by DOS 3.3 DRIVER.SYS for "new" drives
		   bit 7  (DOS 5+) Generic IOCTL check call supported (cmd 19h)
				(see AX=4410h,AX=4411h)
		   bit 6  (DOS 3.2+) Generic IOCTL call supported (command 13h)
				implies support for commands 17h and 18h
				(see AX=440Ch,AX=440Dh,AX=440Eh,AX=440Fh)
		   bits 5-2 reserved
		   bit 1   driver supports 32-bit sector addressing (DOS 3.31+)
		   bit 0   reserved
		Note: for European MS-DOS 4.0, bit 11 also indicates that bits
			8-6 contain a version code (000 = DOS 3.0,3.1;
			001 = DOS 3.2, 010 = European DOS 4.0)
 06h	WORD	device strategy entry point
		call with ES:BX -> request header (see INT 2F/AX=0802h)
 08h	WORD	device interrupt entry point
---character device---
 0Ah  8 BYTEs	blank-padded character device name
---block device---
 0Ah	BYTE	number of subunits (drives) supported by driver
 0Bh  7 BYTEs	unused
---
 12h	WORD	(CD-ROM driver) reserved, must be 0000h
		appears to be another device chain
 14h	BYTE	(CD-ROM driver) drive letter (must initially be 00h)
 15h	BYTE	(CD-ROM driver) number of units
 16h  6 BYTEs	(CD-ROM driver) signature 'MSCDnn' where 'nn' is version
			(currently '00')

Format of CLOCK$ transfer record:
Offset	Size	Description
 00h	WORD	number of days since 1-Jan-1980
 02h	BYTE	minutes
 03h	BYTE	hours
 04h	BYTE	hundredths of second
 05h	BYTE	seconds

Format of DOS 2.x disk buffer:
Offset	Size	Description
 00h	DWORD	pointer to next disk buffer, offset = FFFFh if last
		least-recently used buffer is first in chain
 04h	BYTE	drive (0=A, 1=B, etc), FFh if not in use
 05h  3 BYTEs	unused??? (seems always to be 00h 00h 01h)
 08h	WORD	logical sector number
 0Ah	BYTE	number of copies to write (1 for non-FAT sectors)
 0Bh	BYTE	sector offset between copies if multiple copies to be written
 0Ch	DWORD	pointer to DOS Drive Parameter Block (see AH=32h)
 10h		buffered data

Format of DOS 3.x disk buffer:
Offset	Size	Description
 00h	DWORD	pointer to next disk buffer, offset = FFFFh if last
		least-recently used buffer is first in chain
 04h	BYTE	drive (0=A,1=B, etc), FFh if not in use
 05h	BYTE	buffer flags
		bit 7: ???
		bit 6: buffer dirty
		bit 5: buffer has been referenced
		bit 4: ???
		bit 3: sector in data area
		bit 2: sector in a directory, either root or subdirectory
		bit 1: sector in FAT
		bit 0: boot sector??? (guess)
 06h	WORD	logical sector number
 08h	BYTE	number of copies to write (1 for non-FAT sectors)
 09h	BYTE	sector offset between copies if multiple copies to be written
 0Ah	DWORD	pointer to DOS Drive Parameter Block (see AH=32h)
 0Eh	WORD	unused??? (almost always 0)
 10h		buffered data

Format of DOS 4.00 (pre UR 25066) disk buffer info:
Offset	Size	Description
 00h	DWORD	pointer to array of disk buffer hash chain heads (see below)
 04h	WORD	number of disk buffer hash chains (referred to as NDBCH below)
 06h	DWORD	pointer to lookahead buffer, zero if not present
 0Ah	WORD	number of lookahead sectors, else zero (the y in BUFFERS=x,y)
 0Ch	BYTE	00h if buffers in EMS (/X), FFh if not
 0Dh	WORD	EMS handle for buffers, zero if not in EMS
 0Fh	WORD	EMS physical page number used for buffers (usually 255)
 11h	WORD	??? seems always to be 0001h
 13h	WORD	segment of EMS physical page frame
 15h	WORD	??? seems always to be zero
 17h  4 WORDs	EMS partial page mapping information???

Format of DOS 4.01 (from UR 25066 Corrctive Services Disk on) disk buffer info:
Offset	Size	Description
 00h	DWORD	pointer to array of disk buffer hash chain heads (see below)
 04h	WORD	number of disk buffer hash chains (referred to as NDBCH below)
 06h	DWORD	pointer to lookahead buffer, zero if not present
 0Ah	WORD	number of lookahead sectors, else zero (the y in BUFFERS=x,y)
 0Ch	BYTE	01h, possibly to distinguish from pre-UR 25066 format
 0Dh	WORD	??? EMS segment for BUFFERS (only with /XD)
 0Fh	WORD	??? EMS physical page number of EMS seg above (only with /XD)
 11h	WORD	??? EMS segment for ??? (only with /XD)
 13h	WORD	??? EMS physical page number of above (only with /XD)
 15h	BYTE	??? number of EMS page frames present (only with /XD)
 16h	WORD	segment of one-sector workspace buffer allocated in main memory
		  if BUFFERS/XS or /XD options in effect, possibly to avoid DMA
		  into EMS
 18h	WORD	EMS handle for buffers, zero if not in EMS
 1Ah	WORD	EMS physical page number used for buffers (usually 255)
 1Ch	WORD	??? appears always to be 0001h
 1Eh	WORD	segment of EMS physical page frame
 20h	WORD	??? appears always to be zero
 22h	BYTE	00h if /XS, 01h if /XD, FFh if BUFFERS not in EMS

Format of DOS 4.x disk buffer hash chain head (array, one entry per chain):
Offset	Size	Description
 00h	WORD	EMS logical page number in which chain is resident, -1 if not
		in EMS
 02h	DWORD	pointer to least recently used buffer header.  All buffers on
		this chain are in the same segment.
 06h	BYTE	number of dirty buffers on this chain
 07h	BYTE	reserved (00h)
Notes:	buffered disk sectors are assigned to chain N where N is the sector's
	  address modulo NDBCH,	 0 <= N <= NDBCH-1
	each chain resides completely within one EMS page
	this structure is in main memory even if buffers are in EMS

Format of DOS 4.0-6.0 disk buffer:
Offset	Size	Description
 00h	WORD	forward ptr, offset only, to next least recently used buffer
 02h	WORD	backward ptr, offset only
 04h	BYTE	drive (0=A,1=B, etc) if bit 7 clear
		SFT index if bit 7 set
		FFh if not in use
 05h	BYTE	buffer flags
		bit 7: remote buffer
		bit 6: buffer dirty
		bit 5: buffer has been referenced (reserved in DOS 5+)
		bit 4: search data buffer (only valid if remote buffer)
		bit 3: sector in data area
		bit 2: sector in a directory, either root or subdirectory
		bit 1: sector in FAT
		bit 0: reserved
 06h	DWORD	logical sector number (local buffers only)
 0Ah	BYTE	number of copies to write
		for FAT sectors, same as number of FATs
		for data and directory sectors, usually 1
 0Bh	WORD	offset in sectors between copies to write for FAT sectors
 0Dh	DWORD	pointer to DOS Drive Parameter Block (see AH=32h)
 11h	WORD	size of data in buffer if remote buffer (see flags above)
 13h	BYTE	reserved (padding)
 14h		buffered data
Note:	for DOS 4.x, all buffered sectors which have the same hash value
	  (computed as the sum of high and low words of the logical sector
	  number divided by the number of disk buffer chains) are on the same
	  doubly-linked circular chain; for DOS 5+, only a single circular
	  chain exists.
	the links consist of offset addresses only, the segment being the same
	  for all buffers in the chain.

Format of DOS 5.0-6.0 disk buffer info:
Offset	Size	Description
 00h	DWORD	pointer to least-recently-used buffer header (may be in HMA)
		(see above)
 04h	WORD	number of dirty disk buffers
 06h	DWORD	pointer to lookahead buffer, zero if not present
 0Ah	WORD	number of lookahead sectors, else zero (the y in BUFFERS=x,y)
 0Ch	BYTE	buffer location
		00h base memory, no workspace buffer
		01h HMA, workspace buffer in base memory
 0Dh	DWORD	pointer to one-segment workspace buffer in base memory
 11h  3 BYTEs	unused
 14h	WORD	???
 16h	BYTE	flag: INT 24 fail while making an I/O status call
 17h	BYTE	temp storage for user memory allocation strategy during EXEC
 18h	BYTE	counter: number of INT 21 calls for which A20 is off
 19h	BYTE	bit flags
		bit 0: ???
		bit 1: SWITCHES=/W specified in CONFIG.SYS (don't load
			WINA20.SYS when MS Windows 3.0 starts)
		bit 2: in EXEC state (INT 21/AX=4B05h)
 1Ah	WORD	offset of unpack code start (used only during INT 21/AX=4B05h)
 1Ch	BYTE	bit 0 set iff UMB MCB chain linked to normal MCB chain
 1Dh	WORD	minimum paragraphs of memory required by program being EXECed
 1Fh	WORD	segment of first MCB in upper memory blocks or FFFFh if DOS
		memory chain in base 640K only (first UMB MCB usually at 9FFFh,
		locking out video memory with a DOS-owned memory block)
 21h	WORD	paragraph from which to start scanning during memory allocation

Format of IFS driver list:
Offset	Size	Description
 00h	DWORD	pointer to next driver header
 04h  8 BYTEs	IFS driver name (blank padded), as used by FILESYS command
 0Ch  4 BYTEs	???
 10h	DWORD	pointer to IFS utility function entry point (see below)
		call with ES:BX -> IFS request (see below)
 14h	WORD	offset in header's segment of driver entry point
	???

Call IFS utility function entry point with:
	AH = 20h miscellaneous functions
	    AL = 00h get date
		Return: CX = year
			DH = month
			DL = day
	    AL = 01h get process ID and computer ID
		Return: BX = current PSP segment
			DX = active network machine number
	    AL = 05h get file system info
		ES:DI -> 16-byte info buffer
		Return: buffer filled
			Offset	Size	Description
			 00h  2 BYTEs	unused
			 02h	WORD	number of SFTs (actually counts only
					the first two file table arrays)
			 04h	WORD	number of FCB table entries
			 06h	WORD	number of proctected FCBs
			 08h  6 BYTEs	unused
			 0Eh	WORD	largest sector size supported
	    AL = 06h get machine name
		ES:DI -> 18-byte buffer for name
		Return: buffer filled with name starting at offset 02h
	    AL = 08h get sharing retry count
		Return: BX = sharing retry count
	    AL = other
		Return: CF set
	AH = 21h get redirection state
		BH = type (03h disk, 04h printer)
		Return: BH = state (00h off, 01h on)
	AH = 22h ??? some sort of time calculation
		AL = 00h ???
		    nonzero ???
	AH = 23h ??? some sort of time calculation
	AH = 24h compare filenames
	    DS:SI -> first ASCIZ filename
	    ES:DI -> second ASCIZ filename
	    Return: ZF set if files are same ignoring case and / vs \
	AH = 25h normalize filename
	    DS:SI -> ASCIZ filename
	    ES:DI -> buffer for result
	    Return: filename uppercased, forward slashes changed to backslashes
	AH = 26h get DOS stack
	    Return: DS:SI -> top of stack
		    CX = size of stack in bytes
	AH = 27h increment InDOS flag
	AH = 28h decrement InDOS flag
Note:	IFS drivers which do not wish to implement functions 20h or 24h-28h may
	  pass them on to the default handler pointed at by [LoL+37h]

Format of IFS request block:
Offset	Size	Description
 00h	WORD	total size in bytes of request
 02h	BYTE	class of request
		02h ???
		03h redirection
		04h ???
		05h file access
		06h convert error code to string
		07h ???
 03h	WORD	returned DOS error code
 05h	BYTE	IFS driver exit status
		00h success
		01h ???
		02h ???
		03h ???
		04h ???
		FFh internal failure
 06h 16 BYTEs	???
---request class 02h---
 16h	BYTE	function code
		04h ???
 17h	BYTE	unused???
 18h	DWORD	pointer to ???
 1Ch	DWORD	pointer to ???
 20h  2 BYTEs	???
---request class 03h---
 16h	BYTE	function code
 17h	BYTE	???
 18h	DWORD	pointer to ???
 1Ch	DWORD	pointer to ???
 22h	WORD	returned ???
 24h	WORD	returned ???
 26h	WORD	returned ???
 28h	BYTE	returned ???
 29h	BYTE	unused???
---request class 04h---
 16h	DWORD	pointer to ???
 1Ah	DWORD	pointer to ???
---request class 05h---
 16h	BYTE	function code
		01h flush disk buffers
		02h get disk space
		03h MKDIR
		04h RMDIR
		05h CHDIR
		06h delete file
		07h rename file
		08h search directory
		09h file open/create
		0Ah LSEEK
		0Bh read from file
		0Ch write to file
		0Dh lock region of file
		0Eh commit/close file
		0Fh get/set file attributes
		10h printer control
		11h ???
		12h process termination
		13h ???
	---class 05h function 01h---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h  4 BYTEs	???
	 26h	BYTE	???
	 27h	BYTE	???
	---class 05h function 02h---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h  4 BYTEs	???
	 26h	WORD	returned total clusters
	 28h	WORD	returned sectors per cluster
	 2Ah	WORD	returned bytes per sector
	 2Ch	WORD	returned available clusters
	 2Eh	BYTE	returned ???
	 2Fh	BYTE	???
	---class 05h functions 03h,04h,05h---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h  4 BYTEs	???
	 26h	DWORD	pointer to directory name
	---class 05h function 06h---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h  4 BYTEs	???
	 26h	WORD	attribute mask
	 28h	DWORD	pointer to filename
	---class 05h function 07h---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h  4 BYTEs	???
	 26h	WORD	attribute mask
	 28h	DWORD	pointer to source filespec
	 2Ch	DWORD	pointer to destination filespec
	---class 05h function 08h---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h  4 BYTEs	???
	 26h	BYTE	00h FINDFIRST
			01h FINDNEXT
	 28h	DWORD	pointer to FindFirst search data + 01h if FINDNEXT
	 2Ch	WORD	search attribute if FINDFIRST
	 2Eh	DWORD	pointer to filespec if FINDFIRST
	---class 05h function 09h---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h	DWORD	pointer to IFS open file structure (see below)
	 26h	WORD	???  \ together, specify open vs. create, whether or
	 28h	WORD	???  / not to truncate
	 2Ah  4 BYTEs	???
	 2Eh	DWORD	pointer to filename
	 32h  4 BYTEs	???
	 36h	WORD	file attributes on call
			returned ???
	 38h	WORD	returned ???
	---class 05h function 0Ah---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h	DWORD	pointer to IFS open file structure (see below)
	 26h	BYTE	seek type (02h = from end)
	 28h	DWORD	offset on call
			returned new absolute position
	---class 05h functions 0Bh,0Ch---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h	DWORD	pointer to IFS open file structure (see below)
	 28h	WORD	number of bytes to transfer
			returned bytes actually transferred
	 2Ah	DWORD	transfer address
	---class 05h function 0Dh---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h	DWORD	pointer to IFS open file structure (see below)
	 26h	BYTE	file handle???
	 27h	BYTE	unused???
	 28h	WORD	???
	 2Ah	WORD	???
	 2Ch	WORD	???
	 2Eh	WORD	???
	---class 05h function 0Eh---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h	DWORD	pointer to IFS open file structure (see below)
	 26h	BYTE	00h commit file
			01h close file
	 27h	BYTE	unused???
	---class 05h function 0Fh---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h  4 BYTEs	???
	 26h	BYTE	02h GET attributes
			03h PUT attributes
	 27h	BYTE	unused???
	 28h 12 BYTEs	???
	 34h	WORD	search attributes???
	 36h	DWORD	pointer to filename
	 3Ah	WORD	(GET) returned ???
	 3Ch	WORD	(GET) returned ???
	 3Eh	WORD	(GET) returned ???
	 40h	WORD	(GET) returned ???
	 42h	WORD	(PUT) new attributes
			(GET) returned attributes
	---class 05h function 10h---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h	DWORD	pointer to IFS open file structure (see below)
	 26h	WORD	???
	 28h	DWORD	pointer to ???
	 2Ch	WORD	???
	 2Eh	BYTE	???
	 2Fh	BYTE	subfunction
			01h get printer setup
			03h ???
			04h ???
			05h ???
			06h ???
			07h ???
			21h set printer setup
	---class 05h function 11h---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h	DWORD	pointer to IFS open file structure (see below)
	 26h	BYTE	subfunction
	 27h	BYTE	unused???
	 28h	WORD	???
	 2Ah	WORD	???
	 2Ch	WORD	???
	 2Eh	BYTE	???
	 2Fh	BYTE	???
	---class 05h function 12h---
	 17h 15 BYTEs	unused???
	 26h	WORD	PSP segment
	 28h	BYTE	type of process termination
	 29h	BYTE	unused???
	---class 05h function 13h---
	 17h 15 BYTEs	unused???
	 26h	WORD	PSP segment
---request class 06h---
 16h	DWORD	returned pointer to string corresponding to error code at 03h
 1Ah	BYTE	returned ???
 1Bh	BYTE	unused
---request class 07h---
 16h	DWORD	pointer to IFS open file structure (see below)
 1Ah	BYTE	???
 1Bh	BYTE	unused???

Format of IFS open file structure:
Offset	Size	Description
 00h	WORD	???
 02h	WORD	device info word
 04h	WORD	file open mode
 06h	WORD	???
 08h	WORD	file attributes
 0Ah	WORD	owner's network machine number
 0Ch	WORD	owner's PSP segment
 0Eh	DWORD	file size
 12h	DWORD	current offset in file
 16h	WORD	file time
 18h	WORD	file date
 1Ah 11 BYTEs	filename in FCB format
 25h	WORD	???
 27h	WORD	hash value of SFT address
		(low word of linear address + segment&F000h)
 29h  3 WORDs	network info from SFT
 2Fh	WORD	???

Format of one item in DOS 4+ list of special program names:
Offset	Size	Description
 00h	BYTE	length of name (00h = end of list)
 01h  N BYTEs	name in format name.ext
 N    2 BYTEs	DOS version to return for program (major,minor)
		(see AH=30h,INT 2F/AX=122Fh)
---DOS 4 only---
 N+2	BYTE	number of times to return fake version number (FFh = always)
Note:	if the name of the executable for the program making the DOS "get
	  version" call matches one of the names in this list, DOS returns the
	  specified version rather than the true version number
--------v-215252-----------------------------
INT 21 - VIRUS - "516"/"Leapfrog" - INSTALLATION CHECK
	AX = 5252h
Return: BX = FFEEh if resident
SeeAlso: AX=4BFFh"Cascade",AX=58CCh
--------D-2153-------------------------------
INT 21 - DOS 2+ internal - TRANSLATE BIOS PARAMETER BLOCK TO DRIVE PARAM BLOCK
	AH = 53h
	DS:SI -> BIOS Parameter Block (see below)
	ES:BP -> buffer for Drive Parameter Block (see AH=32h for format)
Return: ES:BP buffer filled
Note:	for DOS 3+, the cluster at which to start searching is set to 0000h
	  and the number of free clusters is set to FFFFh (unknown)

Format of BIOS Parameter Block:
Offset	Size	Description
 00h	WORD	number of bytes per sector
 02h	BYTE	number of sectors per cluster
 03h	WORD	number of reserved sectors at start of disk
 05h	BYTE	number of FATs
 06h	WORD	number of entries in root directory
 08h	WORD	total number of sectors
		for DOS 4+, set to zero if partition >32M, then set DWORD at
		  15h to actual number of sectors
 0Ah	BYTE	media ID byte
 0Bh	WORD	number of sectors per FAT
---DOS 3+---
 0Dh	WORD	number of sectors per track
 0Fh	WORD	number of heads
 11h	DWORD	number of hidden sectors
 15h 11 BYTEs	reserved
---DOS 4+ ---
 15h	DWORD	total number of sectors if word at 08h contains zero
 19h  6 BYTEs	???
 1Fh	WORD	number of cylinders
 21h	BYTE	device type
 22h	WORD	device attributes (removable or not, etc)
---DR-DOS 5+ ---
 15h	DWORD	total number of sectors if word at 08h contains zero
 19h  6 BYTEs	reserved
---European MS-DOS 4.00---
 15h	DWORD	total number of sectors if word at 08h contains zero
		(however, this DOS does not actually implement >32M partitions)
--------D-2154-------------------------------
INT 21 - DOS 2+ - GET VERIFY FLAG
	AH = 54h
Return: AL = verify flag
	    00h off
	    01h on (all disk writes verified after writing)
SeeAlso: AH=2Eh
--------D-2155-------------------------------
INT 21 - DOS 2+ internal - CREATE CHILD PSP
	AH = 55h
	DX = segment at which to create new PSP
	SI = (DOS 3+) value to place in memory size field at DX:[0002h]
Return: CF clear if successful

Notes:	creates a "child" PSP rather than making an exact copy of the current
	  PSP; the new PSP's parent pointer is set to the current PSP and the
	  reference count for each inherited file is incremented
	(DOS 2+) sets current PSP to DX
	(DOS 3+) marks "no inherit" file handles as closed in child PSP
SeeAlso: AH=26h,AH=50h
--------D-2156-------------------------------
INT 21 - DOS 2+ - "RENAME" - RENAME FILE
	AH = 56h
	DS:DX -> ASCIZ filename of existing file (no wildcards, but see below)
	ES:DI -> ASCIZ new filename (no wildcards)
	CL = attribute mask (server call only, see below)
Return: CF clear if successful
	CF set on error
	    AX = error code (02h,03h,05h,11h) (see AH=59h)
Notes:	allows move between directories on same logical volume
	does not set the archive attribute (see AX=4300h), which results in
	  incremental backups not backing up the file under its new name
	open files should not be renamed
	(DOS 3+) allows renaming of directories
	(DOS 3.1+) wildcards are allowed if invoked via AX=5D00h, in which case
	  error 12h (no more files) is returned on success, and both source and
	  destination specs must be canonical (as returned by AH=60h).
	  Wildcards in the destination are replaced by the corresponding char
	  of each source file being renamed.  Under DOS 3.x, the call will fail
	  if the destination wildcard is *.* or equivalent; under DR-DOS 5.0,
	  the call will fail if any wildcards are used.	 When invoked via
	  AX=5D00h, only those files matching the attribute mask in CL are
	  renamed.
	under the FlashTek X-32 DOS extender, the old-name pointer is in DS:EDX
	  and the new-name pointer is in ES:EDI (DS must equal ES)
BUG:	under DR-DOS 3.41, this function will generate a new directory entry
	  with the new name (including any wildcards) which can only be removed
	  with a sector editor when invoked via AX=5D00h
SeeAlso: AH=17h,AX=4301h,AH=60h,AX=5D00h
--------D-215700-----------------------------
INT 21 - DOS 2+ - GET FILE'S DATE AND TIME
	AX = 5700h
	BX = file handle
Return: CF clear if successful
	    CX = file's time
		bits 15-11: hours (0-23)
		     10-5:  minutes
		      4-0:  seconds/2
	    DX = file's date
		bits 15-9: year - 1980
		      8-5: month
		      4-0: day
	CF set on error
	    AX = error code (01h,06h) (see AH=59h)
Note:	under DR-DOS 3.41 and 5.0, this function returns 0 (no date/time) for
	  character devices; MS-DOS returns date and time of opening
SeeAlso: AX=5701h
--------D-215701-----------------------------
INT 21 - DOS 2+ - SET FILE'S DATE AND TIME
	AX = 5701h
	BX = file handle
	CX = new time (see AX=5700h)
	DX = new date (see AX=5700h)
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,06h) (see AH=59h)
SeeAlso: AX=5700h
--------D-215702-----------------------------
INT 21 - DOS 4.x only - GET EXTENDED ATTRIBUTES FOR FILE
	AX = 5702h
	BX = file handle
	CX = size of result buffer or 0000h
	DS:SI -> EAP list (see below)
	ES:DI -> buffer for returned EAV list (see below)
Return: CF clear if successful
	    CX = size of returned data
	CF set on error
	    AX = error code (see AH=59h)
Desc:	get the current value of one or more extended attributes
Notes:	if CX=0000h on entry, ES:DI is ignored and no data is actually
	  returned, only the amount of data which is available
	the default DOS 4 behavior is to return a single word of 0000h (no
	  structures) in the result buffer if CX>=0002h on entry
SeeAlso: AX=5703h,AX=5704h,AH=6Eh,INT 2F/AX=112Dh

Format of EAP (extended attribute properties) list:
Offset	Size	Description
 00h	WORD	number of EAP structures following
 02h	var	array of EAP structures (see below)

Format of EAP (extended attribute property) structure:
Offset	Size	Description
 00h	BYTE	attribute type
		01h boolean (either 00h or 01h)
		02h number (BYTE, WORD, or DWORD)
		03h string
		04h date stamp
		05h time stamp
 01h	WORD	EAP flags (see below)
 03h	BYTE	size of reference string (name)
 04h  N BYTEs	reference string

Bitfields for EAP flags:
 bit 12 unchangeable
 bit 13 ignore
 bit 14 unchangeable
 bit 15 used by COMMAND.COM for code page, but not understood by ATTRIB

Format of EAV (extended attribute value) list:
Offset	Size	Description
 00h	WORD	number of EAV structures following
 02h	var	array of Extended Attribute Value structures

Format of Extended Attribute Value structures:
Offset	Size	Description
 00h  4 BYTEs	???
 04h	BYTE	size of reference string
 05h	WORD	size of value
 07h	var	reference string
	var	value
----------215702-----------------------------
INT 21 - OS/2 v1.1+ Family API - DosQFileInfo
	AX = 5702h
	BX = file handle
	CX = size of buffer for information
	DX = level of information
	ES:DI -> buffer for information
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5702h/BX=FFFFh,AX=5703h"OS/2"
----------215702BXFFFF-----------------------
INT 21 - OS/2 v1.1+ Family API - DosQPathInfo
	AX = 5702h
	BX = FFFFh
	CX = size of buffer for information
	DX = level of information
	DS:SI -> filename
	ES:DI -> buffer for information
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5702h"OS/2",AX=5703h/BX=FFFFh
--------D-215703-----------------------------
INT 21 - DOS 4.x only - GET EXTENDED ATTRIBUTE PROPERTIES
	AX = 5703h
	BX = file handle
	CX = size of result buffer or 0000h
	ES:DI -> result buffer
Return: CF clear if successful
	    CX = size of returned data
	CF set on error
	    AX = error code (see AH=59h)
	ES:DI -> zero word (DOS 4.0) if CX >= 2 on entry
Desc:	get a list of the extended attributes which are defined for the
	  specified file
Notes:	if CX=0000h on entry, ES:DI is ignored and no data is actually
	  returned, only the amount of data which is available
	the default DOS 4 behavior is to return a trivial EAP list consisting
	  of the single word 0000h (no EAP structures) if CX>=0002h on entry
SeeAlso: AX=5702h,AX=5704h,AH=6Eh,INT 2F/AX=112Dh
----------215703-----------------------------
INT 21 - OS/2 v1.1+ Family API - DosSetFileInfo
	AX = 5703h
	BX = file handle
	CX = size of information buffer
	DX = level of information
	ES:DI -> information buffer
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5702h"OS/2",AX=5703h/BX=FFFFh
----------215703BXFFFF-----------------------
INT 21 - OS/2 v1.1+ Family API - DosSetPathInfo
	AX = 5703h
	BX = FFFFh
	CX = size of information buffer
	DX = level of information
	DS:SI -> filename
	ES:DI -> information buffer
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5702h/BX=FFFFh,AX=5703h"OS/2"
--------D-215704-----------------------------
INT 21 - DOS 4.x only - SET EXTENDED ATTRIBUTES
	AX = 5704h
	BX = file handle
	ES:DI -> EAV list (see AX=5702h)
Return: CF clear if successful
	CF set on error
	    AX = error code (see AH=59h)
Note:	the default DOS 4 behavior is to do nothing and return successfully
SeeAlso: AX=5702h,AX=5703h,INT 2F/AX=112Dh
----------215757BX5757-----------------------
INT 21 U - IBM Genie - Resident Manager - INSTALLATION CHECK
	AX = 5757h
	BX = 5757h
Return: AX = 0000h if installed
	    BX = ???
	    DX = ???
	    DS:SI -> list of 27 DWORD entry point addresses
Program: IBM Genie is a set of utility TSRs by Helix Software
Note:	other functions possible if BX <> 5757h, but details not yet available
----------215758-----------------------------
INT 21 U - Headroom - API
	AX = 5758h
	BL = function
	    00h ???
	    01h get Headroom location
		Return: CF clear if installed
			    AX = PSP segment of Headroom TSR
			    BX = paragraphs of memory used by Headroom
			CF set if not (normal DOS return)
		Note:	this function is also used as an installation check
	    02h get INT 21 handler
		Return: CF clear
			ES:BX -> Headroom's INT 21 handler
		Note: also sets unknown flag
	    03h launch application???
		DS:SI -> 233-byte application record
		Return: ???
	    04h ???
		???
		Return: CF clear
	    05h get swap directory
		Return: CF clear
			DX:AX -> ASCIZ swap directory name
	    06h ???
		DX = ???
		Return: CF clear
	    07h ???
	    08h ???
	    09h get current application
		Return: BX = application number
	    0Ah ???
		DX = application number
		DS:SI = ???
		Return: ???
	    0Bh ???
	    0Ch ???
		DX = application number
		???
		Return: ???
	    0Dh ???
		DX = application number
		???
		Return: ???
	    0Eh get ???
		Return: CF clear
			AX = ???
	    0Fh set ??? flag
	    10h clear ??? flag
	    11h find application by name
		DS:SI -> ASCIZ application name
		Return: CF clear
			AX = application number or FFFFh if not loaded
	    12h ???
		DX = application number
		Return: CF clear
			???
	    13h ???
		Return: CF clear
	    14h ???
		same as function 13h
	    15h set ???
		DX = ???
	    16h get ???
		Return: AX = ??? set by function 15h
	    17h get ???
		Return: BX = ???
			CX = ??? (may be pointer in BX:CX)
	    18h BUG: branches incorrectly due to fencepost error
Program: Headroom is a TSR/task switcher by Helix Software
SeeAlso: AX=4C57h,AX=5757h
--------D-2158-------------------------------
INT 21 - DOS 3+ - GET OR SET MEMORY ALLOCATION STRATEGY
	AH = 58h
	AL = subfunction
	    00h get allocation strategy
		Return: AX = current strategy
			    00h low memory first fit
			    01h low memory best fit
			    02h low memory last fit
			 ---DOS 5+ ---
			    40h high memory first fit
			    41h high memory best fit
			    42h high memory last fit
			    80h first fit, try high then low memory
			    81h best fit, try high then low memory
			    82h last fit, try high then low memory
	    01h set allocation strategy
		BL = new allocation strategy (see above)
		BH = 00h (DOS 5+)
Return: CF clear if successful
	CF set on error
	    AX = error code (01h) (see AH=59h)
Notes:	the Set subfunction accepts any value in BL for DOS 3.x and 4.x;
	  2 or greater means last fit
	the Get subfunction returns the last value set
	setting an allocation strategy involving high memory does not
	  automatically link in the UMB memory chain; this must be done
	  explicitly with AX=5803h in order to actually allocate high memory
	a program which changes the allocation strategy should restore it
	  before terminating
	Toshiba MS-DOS 2.11 supports subfunctions 00h and 01h
	DR-DOS 3.41 reportedly reverses subfunctions 00h and 01h
SeeAlso: AH=48h,AH=49h,AH=4Ah,INT 2F/AX=4310h,INT 67/AH=3Fh
--------D-2158-------------------------------
INT 21 - DOS 5+ - GET OR SET UMB LINK STATE
	AH = 58h
	AL = subfunction
	    02h get UMB link state
		Return: AL = 00h UMBs not part of DOS memory chain
			   = 01h UMBs in DOS memory chain
	    03h set UMB link state
		BX = 0000h remove UMBs from DOS memory chain
		   = 0001h add UMBs to DOS memory chain
Return: CF clear if successful
	CF set on error
	    AX = error code (01h) (see AH=59h)
Note:	a program which changes the UMB link state should restore it before
	  terminating
--------v-2158CC-----------------------------
INT 21 - VIRUS - "1067"/"Headcrash" - INSTALLATION CHECK
	AX = 58CCh
Return: CF clear if resident
SeeAlso: AX=5252h,AX=58DDh,AX=6969h
--------v-2158DD-----------------------------
INT 21 - VIRUS - "1067"/"Headcrash" - GET ORIGINAL INT 21h VECTOR
	AX = 58DDh
Return: CX = code segment of virus
	ES:BX = old INT 21h vector
SeeAlso: AX=5252h,AX=58CCh,AX=6969h
--------D-2159--BX0000-----------------------
INT 21 - DOS 3+ - GET EXTENDED ERROR INFORMATION
	AH = 59h
	BX = 0000h
Return: AX = extended error code (see below)
	BH = error class (see below)
	BL = recommended action (see below)
	CH = error locus (see below)
	ES:DI may be pointer (see error code list below)
	CL, DX, SI, BP, and DS destroyed
Notes:	functions available under DOS 2.x map the true DOS 3+ error code into
	  one supported under DOS 2.x
	you should call this function to retrieve the true error code when an
	  FCB or DOS 2.x call returns an error
	under DR-DOS 5.0, this function does not use any of the DOS-internal
	  stacks and may thus be called at any time
SeeAlso: AH=59h/BX=0001h,AX=5D0Ah,INT 2F/AX=122Dh

Values for extended error code:
 00h (0)   no error
 01h (1)   function number invalid
 02h (2)   file not found
 03h (3)   path not found
 04h (4)   too many open files (no handles available)
 05h (5)   access denied
 06h (6)   invalid handle
 07h (7)   memory control block destroyed
 08h (8)   insufficient memory
 09h (9)   memory block address invalid
 0Ah (10)  environment invalid (usually >32K in length)
 0Bh (11)  format invalid
 0Ch (12)  access code invalid
 0Dh (13)  data invalid
 0Eh (14)  reserved
 0Fh (15)  invalid drive
 10h (16)  attempted to remove current directory
 11h (17)  not same device
 12h (18)  no more files
---DOS 3+---
 13h (19)  disk write-protected
 14h (20)  unknown unit
 15h (21)  drive not ready
 16h (22)  unknown command
 17h (23)  data error (CRC)
 18h (24)  bad request structure length
 19h (25)  seek error
 1Ah (26)  unknown media type (non-DOS disk)
 1Bh (27)  sector not found
 1Ch (28)  printer out of paper
 1Dh (29)  write fault
 1Eh (30)  read fault
 1Fh (31)  general failure
 20h (32)  sharing violation
 21h (33)  lock violation
 22h (34)  disk change invalid
	ES:DI -> ASCIZ volume label of required disk
 23h (35)  FCB unavailable
 24h (36)  sharing buffer overflow
 25h (37)  (DOS 4+) code page mismatch
 26h (38)  (DOS 4+) cannot complete file operation (out of input)
 27h (39)  (DOS 4+) insufficient disk space
 28h-31h   reserved
 32h (50)  network request not supported
 33h (51)  remote computer not listening
 34h (52)  duplicate name on network
 35h (53)  network name not found
 36h (54)  network busy
 37h (55)  network device no longer exists
 38h (56)  network BIOS command limit exceeded
 39h (57)  network adapter hardware error
 3Ah (58)  incorrect response from network
 3Bh (59)  unexpected network error
 3Ch (60)  incompatible remote adapter
 3Dh (61)  print queue full
 3Eh (62)  queue not full
 3Fh (63)  not enough space to print file
 40h (64)  network name was deleted
 41h (65)  network: Access denied
 42h (66)  network device type incorrect
 43h (67)  network name not found
 44h (68)  network name limit exceeded
 45h (69)  network BIOS session limit exceeded
 46h (70)  temporarily paused
 47h (71)  network request not accepted
 48h (72)  network print/disk redirection paused
 49h (73)  network software not installed
	   (LANtastic) invalid network version
 4Ah (74)  unexpected adapter close
	   (LANtastic) account expired
 4Bh (75)  (LANtastic) password expired
 4Ch (76)  (LANtastic) login attempt invalid at this time
 4Dh (77)  (LANtastic v3+) disk limit exceeded on network node
 4Eh (78)  (LANtastic v3+) not logged in to network node
 4Fh (79)  reserved
 50h (80)  file exists
 51h (81)  reserved
 52h (82)  cannot make directory
 53h (83)  fail on INT 24h
 54h (84)  (DOS 3.3+) too many redirections
 55h (85)  (DOS 3.3+) duplicate redirection
 56h (86)  (DOS 3.3+) invalid password
 57h (87)  (DOS 3.3+) invalid parameter
 58h (88)  (DOS 3.3+) network write fault
 59h (89)  (DOS 4+) function not supported on network
 5Ah (90)  (DOS 4+) required system component not installed
 64h (100) (MSCDEX) unknown error
 65h (101) (MSCDEX) not ready
 66h (102) (MSCDEX) EMS memory no longer valid
 67h (103) (MSCDEX) not High Sierra or ISO-9660 format
 68h (104) (MSCDEX) door open

Values for Error Class:
 01h	out of resource (storage space or I/O channels)
 02h	temporary situation (file or record lock)
 03h	authorization (denied access)
 04h	internal (system software bug)
 05h	hardware failure
 06h	system failure (configuration file missing or incorrect)
 07h	application program error
 08h	not found
 09h	bad format
 0Ah	locked
 0Bh	media error
 0Ch	already exists
 0Dh	unknown

Values for Suggested Action:
 01h	retry
 02h	delayed retry
 03h	prompt user to reenter input
 04h	abort after cleanup
 05h	immediate abort
 06h	ignore
 07h	retry after user intervention

Values for Error Locus:
 01h	unknown or not appropriate
 02h	block device (disk error)
 03h	network related
 04h	serial device (timeout)
 05h	memory related
--------D-2159--BX0001-----------------------
INT 21 - European MS-DOS 4.0 - GET HARD ERROR INFORMATION
	AH = 59h
	BX = 0001h
Return: ES:DI -> hard error information packet (see below) for most recent
		hard (critical) error
SeeAlso: AH=59h/BX=0000h,AH=95h,INT 24

Format of hard error information packet:
Offset	Size	Description
 00h	WORD	contents of AX at system entry
 02h	WORD	Process ID which encountered error
 04h	WORD	contents of AX at time of error
 06h	BYTE	error type
		00h physical I/O error
		01h disk change request
		02h file sharing violation
		03h FCB problem
		04h file locking violation
		05h bad FAT
		06h network detected error
 07h	BYTE	INT 24 error code
 08h	WORD	extended error code (see AH=59h/BX=0000h)
 0Ah	DWORD	pointer to associated device
--------D-215A-------------------------------
INT 21 - DOS 3+ - CREATE TEMPORARY FILE
	AH = 5Ah
	CX = file attribute (see AX=4301h)
	DS:DX -> ASCIZ path ending with a '\' + 13 zero bytes to receive the
		generated filename
Return: CF clear if successful
	    AX = file handle opened for read/write in compatibility mode
	    DS:DX pathname extended with generated name for temporary file
	CF set on error
	    AX = error code (03h,04h,05h) (see AH=59h)
Desc:	creates a file with a unique name which must be explicitly deleted
BUGS:	COMPAQ DOS 3.31 hangs if the pathname is at XXXXh:0000h; it apparently
	  wraps around to the end of the segment
	MS-DOS 5.00 revisions A and B and PC-DOS 5.00 revision A reportedly
	  hang the system if the specified path is the root directory and the
	  root directory is full (no free directory entries)
Note:	under the FlashTek X-32 DOS extender, the path pointer is in DS:EDX
SeeAlso: AH=3Ch,AH=5Bh
--------D-215B-------------------------------
INT 21 - DOS 3+ - CREATE NEW FILE
	AH = 5Bh
	CX = file attribute (see AX=4301h)
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    AX = file handle opened for read/write in compatibility mode
	CF set on error
	    AX = error code (03h,04h,05h,50h) (see AH=59h)
Notes:	unlike AH=3Ch, this function will fail if the specified file exists
	  rather than truncating it; this permits its use in creating semaphore
	  files because it is an atomic "test and set" operation
	under the FlashTek X-32 DOS extender, the filename pointer is in DS:EDX
SeeAlso: AH=3Ch,AH=5Ah
--------D-215C-------------------------------
INT 21 - DOS 3+ - "FLOCK" - RECORD LOCKING
	AH = 5Ch
	AL = subfunction
	    00h lock region of file
	    01h unlock region of file
	BX = file handle
	CX:DX = start offset of region within file
	SI:DI = length of region in bytes
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,06h,21h,24h) (see AH=59h)
Notes:	error returned unless SHARE or network installed
	an unlock call must specify the same region as some prior lock call
	locked regions become entirely inaccessible to other processes
	duplicate handles created with AH=45h or AH=46h inherit locks, but
	  handles inherited by child processes (see AH=4Bh) do not
	under DR-DOS 3.41 and 5.0, if a process opens a file without the no-
	  inherit flag and then starts a child, any locks set by the parent
	  are ignored, and the child will only get an error if it tries to
	  lock an area previously locked by the parent process
SeeAlso: AX=440Bh,AH=BCh,AH=BEh,INT 2F/AX=110Ah,INT 2F/AX=110Bh
--------D-215D00-----------------------------
INT 21 U - DOS 3.1+ internal - SERVER FUNCTION CALL
	AX = 5D00h
	DS:DX -> DOS parameter list (see below)
	DPL contains all register values for a call to INT 21h
Return: as appropriate for function being called
Notes:	does not check AH.  Out of range values will crash the system
	executes using specified computer ID and process ID
	sharing delay loops skipped
	a special sharing mode is enabled to handle FCBs opened across network
	wildcards are enabled for DELETE (AH=41h) and RENAME (AH=56h) under
	  MS-DOS; under DR-DOS 3.41, wildcards corrupt the filesystem; and
	  under DR-DOS 5.0-6.0, the call returns error code 03h due to improper
	  support for the server function call (see below)
	an extra file attribute parameter is enabled for OPEN (AH=3Dh),
	  DELETE (AH=41h), and RENAME (AH=56h)
	functions which take filenames require canonical names (as returned
	  by AH=60h); this is apparently to prevent multi-hop file forwarding
BUGS:	the OS/2 2.0 DOS Boot Session incorrectly maps DOS drive letters,
	  seemingly ignoring HPFS drives
	DR-DOS 5.0-6.0 merely recursively call INT 21 after loading the
	  registers from the DPL, leading to problems for peer-to-peer
	  networks
SeeAlso: AH=3Dh,AH=41h,AH=56h,AH=60h

Format of DOS parameter list:
Offset	Size	Description
 00h	WORD	AX
 02h	WORD	BX
 04h	WORD	CX
 06h	WORD	DX
 08h	WORD	SI
 0Ah	WORD	DI
 0Ch	WORD	DS
 0Eh	WORD	ES
 10h	WORD	reserved (0)
 12h	WORD	computer ID (0 = current system)
 14h	WORD	process ID (PSP segment on specified computer)
Note:	under Windows Enhanced mode, the computer ID is normally the virtual
	  machine ID (see INT 2F/AX=1683h), though this can reportedly be
	  changed by setting UniqueDOSPSP= in SYSTEM.INI
--------D-215D01-----------------------------
INT 21 U - DOS 3.1+ internal - COMMIT ALL FILES FOR SPECIFIED COMPUTER/PROCESS
	AX = 5D01h
	DS:DX -> DOS parameter list (see AX=5D00h), only computer ID and
		process ID fields used
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Notes:	flushes buffers and updates directory entries for each file which has
	  been written to; if remote file, calls INT 2F/AX=1107h
	the computer ID and process ID are stored but ignored under DOS 3.3
	not supported by DR-DOS 3.41 and 5.0; returns error code 01h
SeeAlso: AH=0Dh,AH=68h,INT 2F/AX=1107h
--------D-215D02-----------------------------
INT 21 U - DOS 3.1+ internal - SHARE.EXE - CLOSE FILE BY NAME
	AX = 5D02h
	DS:DX -> DOS parameter list (see AX=5D00h), only fields DX, DS,
		computer ID, and process ID used
	DPL's DS:DX -> ASCIZ name of file to close
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Notes:	error unless SHARE is loaded (calls [SysFileTable-28h]) (see AH=52h)
	name must be canonical fully-qualified, such as returned by AH=60h
	not supported by DR-DOS 3.41 and 5.0; returns error code 01h
SeeAlso: AX=5D03h,AX=5D04h,AH=3Eh,AH=60h
--------D-215D03-----------------------------
INT 21 U - DOS 3.1+ internal - SHARE.EXE - CLOSE ALL FILES FOR GIVEN COMPUTER
	AX = 5D03h
	DS:DX -> DOS parameter list (see AX=5D00h), only computer ID used
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Notes:	error unless SHARE is loaded (calls [SysFileTable-30h]) (see AH=52h)
	not supported by DR-DOS 3.41 and 5.0; returns error code 01h
SeeAlso: AX=5D02h,AX=5D04h
--------D-215D04-----------------------------
INT 21 U - DOS 3.1+ internal - SHARE.EXE - CLOSE ALL FILES FOR GIVEN PROCESS
	AX = 5D04h
	DS:DX -> DOS parameter list (see AX=5D00h), only computer ID and
		process ID fields used
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Notes:	error unless SHARE is loaded (calls [SysFileTable-2Ch]) (see AH=52h)
	not supported by DR-DOS 3.41 and 5.0; returns error code 01h
SeeAlso: AX=5D02h,AX=5D03h,INT 2F/AX=111Dh
--------D-215D05-----------------------------
INT 21 U - DOS 3.1+ internal - SHARE.EXE - GET OPEN FILE LIST ENTRY
	AX = 5D05h
	DS:DX -> DOS parameter list (see AX=5D00h)
	DPL's BX = index of sharing record (see AH=52h)
	DPL's CX = index of SFT in sharing record's SFT list
Return: CF clear if successful
	    ES:DI -> ASCIZ filename
	    BX = network machine number of SFT's owner
	    CX = number of locks held by SFT's owner
	CF set if either index out of range
	    AX = 0012h (no more files)
Notes:	error unless SHARE is loaded (calls [SysFileTable-18h]) (see AH=52h)
	names are always canonical fully-qualified, such as returned by AH=60h
	not supported by DR-DOS 3.41 and 5.0, but does not return an error
SeeAlso: AH=5Ch,AH=60h
--------D-215D06-----------------------------
INT 21 U - DOS 3.0+ internal - GET ADDRESS OF DOS SWAPPABLE DATA AREA
	AX = 5D06h
Return: CF set on error
	   AX = error code (see AH=59h)
	CF clear if successful
	    DS:SI -> nonreentrant data area (includes all three DOS stacks)
		(critical error flag is first byte)
	    CX = size in bytes of area which must be swapped while in DOS
	    DX = size in bytes of area which must always be swapped
Notes:	the Critical Error flag is used in conjunction with the InDOS flag
	  (see AH=34h) to determine when it is safe to enter DOS from a TSR
	setting CritErr flag allows use of functions 50h/51h from INT 28h under
	  DOS 2.x by forcing use of correct stack
	swapping the data area allows reentering DOS unless DOS is in a
	  critical section delimited by INT 2A/AH=80h and INT 2A/AH=81h,82h
	under DOS 4.0, AX=5D0Bh should be used instead of this function
	SHARE and other DOS utilities consult the byte at offset 04h in the
	  DOS data segment (see INT 2F/AX=1203h) to determine the SDA format
	  in use: 00h = DOS 3.x, 01h = DOS 4.0-6.0, other = error.
	DR-DOS 3.41+ supports this function, but the SDA format beyond the
	  first 18h bytes is completely different from MS-DOS
SeeAlso: AX=5D0Bh,INT 2A/AH=80h,INT 2A/AH=81h,INT 2A/AH=82h

Format of DOS 3.10-3.30 Swappable Data Area:
Offset	Size	Description
 -31	BYTE	(DOS 3.30) current switch character
 -28	BYTE	(DOS 3.30) incremented on each INT 21/AX=5E01h call
 -27 16 BYTEs	(DOS 3.30) machine name set by INT 21/AX=5E01h
 -11  5 WORDs	zero-terminated list of offsets which need to be patched to
		enabled critical-section calls (see INT 2A/AH=80h)
 -1	BYTE	unused padding
---start of actual SDA---
 00h	BYTE	critical error flag ("ErrorMode")
 01h	BYTE	InDOS flag (count of active INT 21 calls)
 02h	BYTE	drive on which current critical error occurred, or FFh
		(DR-DOS sets to drive number during INT 24, 00h otherwise)
 03h	BYTE	locus of last error
 04h	WORD	extended error code of last error
 06h	BYTE	suggested action for last error
 07h	BYTE	class of last error
 08h	DWORD	ES:DI pointer for last error
 0Ch	DWORD	current DTA
 10h	WORD	current PSP
 12h	WORD	stores SP across an INT 23
 14h	WORD	return code from last process termination (zerod after reading
		with AH=4Dh)
 16h	BYTE	current drive
 17h	BYTE	extended break flag
---remainder need only be swapped if in DOS---
 18h	WORD	value of AX on call to INT 21
 1Ah	WORD	PSP segment for sharing/network
 1Ch	WORD	network machine number for sharing/network (0000h = us)
 1Eh	WORD	first usable memory block found when allocating memory
 20h	WORD	best usable memory block found when allocating memory
 22h	WORD	last usable memory block found when allocating memory
 24h	WORD	memory size in paragraphs (used only during initialization)
 26h	WORD	last entry checked during directory search
 28h	BYTE	flag: INT 24 returned Fail
 29h	BYTE	flags: allowable INT 24 actions (passed to INT 24 in AH)
 2Ah	BYTE	directory flag (00h directory, 01h file)
 2Bh	BYTE	flag: FFh if Ctrl-Break termination, 00h otherwise
 2Ch	BYTE	flag: allow embedded blanks in FCB
 2Dh	BYTE	padding (unused)
 2Eh	BYTE	day of month
 2Fh	BYTE	month
 30h	WORD	year - 1980
 32h	WORD	number of days since 1-1-1980
 34h	BYTE	day of week (0 = Sunday)
 35h	BYTE	flag: console swapped during read from device
 36h	BYTE	flag: safe to call INT 28 if nonzero
 37h	BYTE	flag: if nonzero, INT 24 Abort turned into INT 24 Fail
		(set only during process termination)
 38h 26 BYTEs	device driver request header (see INT 2F/AX=0802h)
 52h	DWORD	pointer to device driver entry point (used in calling driver)
 56h 22 BYTEs	device driver request header for I/O calls
 6Ch 14 BYTEs	device driver request header for disk status check
 7Ah	DWORD	pointer to device I/O buffer???
 7Eh	WORD	???
 80h	WORD	???
 82h	BYTE	type of PSP copy (00h=simple for INT 21/AH=26h, FFh=make child)
 83h	BYTE	padding (unused)
 84h  3 BYTEs	24-bit user number (see AH=30h)
 87h	BYTE	OEM number (see AH=30h)
 88h	WORD	offset to error code conversion table for INT 25/INT 26
 8Ah  6 BYTEs	CLOCK$ transfer record (see AH=52h)
 90h	BYTE	device I/O buffer for single-byte I/O functions
 91h	BYTE	padding??? (unused)
 92h 128 BYTEs	buffer for filename
112h 128 BYTEs	buffer for filename
192h 21 BYTEs	findfirst/findnext search data block (see AH=4Eh)
1A7h 32 BYTEs	directory entry for found file (see AH=11h)
1C7h 81 BYTEs	copy of current directory structure for drive being accessed
218h 11 BYTEs	FCB-format filename for device name comparison
223h	BYTE	terminating NUL for above filename
224h 11 BYTEs	wildcard destination specification for rename (FCB format)
22Fh	BYTE	terminating NUL for above spec
230h	BYTE	???
231h	WORD	destination file/directory starting sector
233h  5 BYTEs	???
238h	BYTE	extended FCB file attribute
239h	BYTE	type of FCB (00h regular, FFh extended)
23Ah	BYTE	directory search attributes
23Bh	BYTE	file open/access mode
23Ch	BYTE	file found/delete flag
		bit 0: file found
		bit 4: file deleted
23Dh	BYTE	flag: device name found on rename, or file not found
23Eh	BYTE	splice flag (file name and directory name together)
23Fh	BYTE	flag indicating how DOS function was invoked
		(00h = direct INT 20/INT 21, FFh = server call AX=5D00h)
240h	BYTE	sector position within cluster
241h	BYTE	flag: translate sector/cluster (00h no, 01h yes)
242h	BYTE	flag: 00h if read, 01h if write
243h	BYTE	current working drive number
244h	BYTE	cluster factor
245h	BYTE	flag: cluster split mode
246h	BYTE	line edit (AH=0Ah) insert mode flag (nonzero = on)
247h	BYTE	canonicalized filename referred to existing file/dir if FFh
248h	BYTE	volume ID flag
249h	BYTE	type of process termination (00h-03h) (see AH=4Dh)
24Ah	BYTE	file create flag (00h = no)
24Bh	BYTE	value with which to replace first byte of deleted file's name
		(normally E5h, but 00h as described under INT 21/AH=13h)
24Ch	DWORD	pointer to Drive Parameter Block for critical error invocation
		temp: used during process termination
250h	DWORD	pointer to stack frame containing user registers on INT 21
254h	WORD	stores SP across INT 24
256h	DWORD	pointer to DOS Drive Parameter Block for ???
25Ah	WORD	saving partial cluster number
25Ch	WORD	temp: sector of work current cluster
25Eh	WORD	high part of cluster number (only low byte referenced)
260h	WORD	??? temp
262h	BYTE	Media ID byte returned by AH=1Bh,1Ch
263h	BYTE	padding (unused)
264h	DWORD	pointer to device header
268h	DWORD	pointer to current SFT
26Ch	DWORD	pointer to current directory structure for drive being accessed
270h	DWORD	pointer to caller's FCB
274h	WORD	number of SFT to which file being opened will refer
276h	WORD	temporary storage for file handle
278h	DWORD	pointer to a JFT entry in process handle table (see AH=26h)
27Ch	WORD	offset in DOS DS of first filename argument
27Eh	WORD	offset in DOS DS of second filename argument
280h	WORD	offset of last component in pathname or FFFFh
282h	WORD	offset of transfer address to add
284h	WORD	last relative cluster within file being accessed
286h	WORD	temp: absolute cluster number being accessed
288h	WORD	directory sector number
28Ah	WORD	??? current cluster number
28Ch	WORD	??? current offset in file DIV bytes per sector
28Eh	WORD	current sector number
290h	WORD	current byte offset within sector
292h	DWORD	current offset in file
296h	DWORD	temp: file byte count
29Ah	WORD	temp: file byte count
29Ch	WORD	free file cluster entry
29Eh	WORD	last file cluster entry
2A0h	WORD	next file cluster number
2A2h	DWORD	number of bytes appended to file
2A6h	DWORD	pointer to current work disk buffer
2AAh	DWORD	pointer to working SFT
2AEh	WORD	used by INT 21 dispatcher to store caller's BX
2B0h	WORD	used by INT 21 dispatcher to store caller's DS
2B2h	WORD	temporary storage while saving/restoring caller's registers
2B4h	DWORD	pointer to prev call frame (offset 250h) if INT 21 reentered
		also switched to for duration of INT 24
2B8h 21 BYTEs	FindFirst search data for source file(s) of a rename operation
		(see AH=4Eh)
2CDh 32 BYTEs	directory entry for file being renamed (see AH=11h for format)
2EDh 331 BYTEs	critical error stack
   403h	 35 BYTEs scratch SFT
438h 384 BYTEs	disk stack (functions greater than 0Ch, INT 25,INT 26)
5B8h 384 BYTEs	character I/O stack (functions 01h through 0Ch)
---DOS 3.2,3.3x only---
738h	BYTE	device driver lookahead flag (usually printer) (see AH=64h)
739h	BYTE	volume change flag
73Ah	BYTE	flag: virtual open
73Bh	BYTE	???
--------D-215D07-----------------------------
INT 21 U - DOS 3.1+ network - GET REDIRECTED PRINTER MODE
	AX = 5D07h
Return: DL = mode
	    00h redirected output is combined
	    01h redirected output in separate print jobs
SeeAlso: AX=5D08h,AX=5D09h,INT 2F/AX=1125h
--------D-215D08-----------------------------
INT 21 U - DOS 3.1+ network - SET REDIRECTED PRINTER MODE
	AX = 5D08h
	DL = mode
	    00h redirected output is combined
	    01h redirected output placed in separate jobs, start new print job
		now
SeeAlso: AX=5D07h,AX=5D09h,INT 2F/AX=1125h
--------D-215D09-----------------------------
INT 21 U - DOS 3.1+ network - FLUSH REDIRECTED PRINTER OUTPUT
	AX = 5D09h
Notes:	forces redirected printer output to be printed, and starts a new print
	  job
	this function is also supported by 10Net, which calls it Terminate All
	  Spool Jobs, and does not flush if in "combine" mode
SeeAlso: AX=5D07h,AX=5D08h,INT 2F/AX=1125h
--------D-215D0A-----------------------------
INT 21 - DOS 3.1+ - SET EXTENDED ERROR INFORMATION
	AX = 5D0Ah
	DS:DX -> 11-word DOS parameter list (see AX=5D00h)
Return: nothing.  next call to AH=59h will return values from fields AX,BX,CX,
	  DX,DI, and ES in corresponding registers
Notes:	documented for DOS 5+, but undocumented in earlier versions
	the MS-DOS Programmer's Reference incorrectly states that this call was
	  introduced in DOS 4, and fails to mention that the ERROR structure
	  passed to this function is a DOS parameter list.
BUG:	DR-DOS 3.41 and 5.0 read the value for ES from the DS field of the DPL;
	  fortunately, MS-DOS ignores the DS field, allowing a generic routine
	  which sets both DS and ES fields to the same value
SeeAlso: AH=59h
--------D-215D0B-----------------------------
INT 21 U - DOS 4.x only internal - GET DOS SWAPPABLE DATA AREAS
	AX = 5D0Bh
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    DS:SI -> swappable data area list (see below)
Notes:	copying and restoring the swappable data areas allows DOS to be
	  reentered unless it is in a critical section delimited by calls to
	  INT 2A/AH=80h and INT 2A/AH=81h,82h
	SHARE and other DOS utilities consult the byte at offset 04h in the
	  DOS data segment (see INT 2F/AX=1203h) to determine the SDA format
	  in use: 00h = DOS 3.x, 01h = DOS 4.0-6.0, other = error.
	DOS 5+ use the SDA format listed below, but revert back to the DOS 3.x
	  call for finding the SDA (see AX=5D06h)
SeeAlso: AX=5D06h,INT 2A/AH=80h,INT 2A/AH=81h,INT 2A/AH=82h,INT 2F/AX=1203h

Format of DOS 4.x swappable data area list:
Offset	Size	Description
 00h	WORD	count of data areas
 02h  N BYTEs	"count" copies of data area record
		Offset	Size	Description
		 00h	DWORD	address
		 04h	WORD	length and type
				bit 15 set if swap always, clear if swap in DOS
				bits 14-0: length in bytes

Format of DOS 4.0-6.0 swappable data area:
Offset	Size	Description
 -31	BYTE	current switch character (ignored by DOS 5+)
 -28	BYTE	incremented on each INT 21/AX=5E01h call
 -27 16 BYTEs	machine name set by INT 21/AX=5E01h
 -11  5 WORDs	zero-terminated list of offsets which need to be patched to
		enabled critical-section calls (see INT 2A/AH=80h)
		(all offsets are 0D0Ch, but this list is still present for
		DOS 3.x compatibility)
 -1	BYTE	unused padding
---start of actual SDA---
 00h	BYTE	critical error flag ("ErrorMode")
 01h	BYTE	InDOS flag (count of active INT 21 calls)
 02h	BYTE	drive on which current critical error occurred or FFh
 03h	BYTE	locus of last error
 04h	WORD	extended error code of last error
 06h	BYTE	suggested action for last error
 07h	BYTE	class of last error
 08h	DWORD	ES:DI pointer for last error
 0Ch	DWORD	current DTA
 10h	WORD	current PSP
 12h	WORD	stores SP across an INT 23
 14h	WORD	return code from last process termination (zerod after reading
		with AH=4Dh)
 16h	BYTE	current drive
 17h	BYTE	extended break flag
 18h	BYTE	flag: code page switching
 19h	BYTE	flag: copy of previous byte in case of INT 24 Abort
---remainder need only be swapped if in DOS---
 1Ah	WORD	value of AX on call to INT 21
 1Ch	WORD	PSP segment for sharing/network
 1Eh	WORD	network machine number for sharing/network (0000h = us)
 20h	WORD	first usable memory block found when allocating memory
 22h	WORD	best usable memory block found when allocating memory
 24h	WORD	last usable memory block found when allocating memory
 26h	WORD	memory size in paragraphs (used only during initialization)
 28h	WORD	last entry checked during directory search
 2Ah	BYTE	flag: nonzero if INT 24 Fail
 2Bh	BYTE	flags: allowable INT 24 responses (passed to INT 24 in AH)
 2Ch	BYTE	flag: do not set directory if nonzero
 2Dh	BYTE	flag: program aborted by ^C
 2Eh	BYTE	flag: allow embedded blanks in FCB
 2Fh	BYTE	padding (unused)
 30h	BYTE	day of month
 31h	BYTE	month
 32h	WORD	year - 1980
 34h	WORD	number of days since 1-1-1980
 36h	BYTE	day of week (0 = Sunday)
 37h	BYTE	flag: console swapped during read from device
 38h	BYTE	flag: safe to call INT 28 if nonzero
 39h	BYTE	flag: abort currently in progress, turn INT 24 Abort into Fail
 3Ah 30 BYTEs	device driver request header (see INT 2F/AX=0802h) for
		device calls
 58h	DWORD	pointer to device driver entry point (used in calling driver)
 5Ch 22 BYTEs	device driver request header for I/O calls
 72h 14 BYTEs	device driver request header for disk status check
 80h	DWORD	pointer to device I/O buffer
 84h	WORD	???
 86h	WORD	??? (0)
 88h	BYTE	type of PSP copy (00h=simple for INT 21/AH=26h, FFh=make child)
 89h	DWORD	start offset of file region to lock/unlock
 8Dh	DWORD	length of file region to lock/unlock
 91h	BYTE	padding (unused)
 92h  3 BYTEs	24-bit user number (see AH=30h)
 95h	BYTE	OEM number (see AH=30h)
 96h  6 BYTEs	CLOCK$ transfer record (see AH=52h)
 9Ch	BYTE	device I/O buffer for single-byte I/O functions???
 9Dh	BYTE	padding???
 9Eh 128 BYTEs	buffer for filename
11Eh 128 BYTEs	buffer for filename
19Eh 21 BYTEs	findfirst/findnext search data block (see AH=4Eh)
1B3h 32 BYTEs	directory entry for found file (see AH=11h)
1D3h 88 BYTEs	copy of current directory structure for drive being accessed
22Bh 11 BYTEs	FCB-format filename for device name comparison
236h	BYTE	terminating NUL for above filename
237h 11 BYTEs	wildcard destination specification for rename (FCB format)
242h	BYTE	terminating NUL for above spec
243h	BYTE	???
244h	WORD	???
246h  5 BYTEs	???
24Bh	BYTE	extended FCB file attributes
24Ch	BYTE	type of FCB (00h regular, FFh extended)
24Dh	BYTE	directory search attributes
24Eh	BYTE	file open/access mode
24Fh	BYTE	??? flag bits
250h	BYTE	flag: device name found on rename, or file not found
251h	BYTE	splice flag??? (file name and directory name together)
252h	BYTE	flag indicating how DOS function was invoked
		(00h = direct INT 20/INT 21, FFh = server call AX=5D00h)
253h	BYTE	???
254h	BYTE	???
255h	BYTE	???
256h	BYTE	???
257h	BYTE	???
258h	BYTE	???
259h	BYTE	???
25Ah	BYTE	canonicalized filename referred to existing file/dir if FFh
25Bh	BYTE	???
25Ch	BYTE	type of process termination (00h-03h)
25Dh	BYTE	???
25Eh	BYTE	???
25Fh	BYTE	???
260h	DWORD	pointer to Drive Parameter Block for critical error invocation
264h	DWORD	pointer to stack frame containing user registers on INT 21
268h	WORD	stores SP???
26Ah	DWORD	pointer to DOS Drive Parameter Block for ???
26Eh	WORD	segment of disk buffer
270h	WORD	???
272h	WORD	???
274h	WORD	???
276h	WORD	???
278h	BYTE	Media ID byte returned by AH=1Bh,1Ch
279h	BYTE	??? (doesn't seem to be referenced)
27Ah	DWORD	pointer to ???
27Eh	DWORD	pointer to current SFT
282h	DWORD	pointer to current directory structure for drive being accessed
286h	DWORD	pointer to caller's FCB
28Ah	WORD	SFT index to which file being opened will refer
28Ch	WORD	temporary storage for file handle
28Eh	DWORD	pointer to a JFT entry in process handle table (see AH=26h)
292h	WORD	offset in DOS DS of first filename argument
294h	WORD	offset in DOS DS of second filename argument
296h	WORD	???
298h	WORD	???
29Ah	WORD	???
29Ch	WORD	???
29Eh	WORD	???
2A0h	WORD	???
2A2h	WORD	??? directory cluster number???
2A4h	DWORD	???
2A8h	DWORD	???
2ACh	WORD	???
2AEh	DWORD	offset in file???
2B2h	WORD	???
2B4h	WORD	bytes in partial sector
2B6h	WORD	number of sectors
2B8h	WORD	???
2BAh	WORD	???
2BCh	WORD	???
2BEh	DWORD	number of bytes appended to file
2C2h	DWORD	pointer to ??? disk buffer
2C6h	DWORD	pointer to ??? SFT
2CAh	WORD	used by INT 21 dispatcher to store caller's BX
2CCh	WORD	used by INT 21 dispatcher to store caller's DS
2CEh	WORD	temporary storage while saving/restoring caller's registers
2D0h	DWORD	pointer to prev call frame (offset 264h) if INT 21 reentered
		also switched to for duration of INT 24
2D4h	WORD	open mode/action for INT 21/AX=6C00h
2D6h	BYTE	??? (set to 00h by INT 21h dispatcher, 02h when a read is
		performed, and 01h or 03h by INT 21/AX=6C00h)
2D7h	WORD	??? apparently unused
2D9h	DWORD	stored ES:DI for AX=6C00h
2DDh	WORD	extended file open action code (see AX=6C00h)
2DFh	WORD	extended file open attributes (see AX=6C00h)
2E1h	WORD	extended file open file mode (see AX=6C00h)
2E3h	DWORD	pointer to filename to open (see AX=6C00h)
2E7h	WORD	???
2E9h	WORD	???
2EBh	BYTE	???
2ECh	WORD	stores DS during call to [List-of-Lists + 37h]
2EEh	WORD	???
2F0h	BYTE	???
2F1h	WORD	??? bit flags
2F3h	DWORD	pointer to user-supplied filename
2F7h	DWORD	pointer to ???
2FBh	WORD	stores SS during call to [List-of-Lists + 37h]
2FDh	WORD	stores SP during call to [List-of-Lists + 37h]
2FFh	BYTE	flag, nonzero if stack switched in calling [List-of-Lists+37h]
300h 21 BYTEs	FindFirst search data for source file(s) of a rename operation
		(see AH=4Eh)
315h 32 BYTEs	directory entry for file being renamed (see AH=11h)
335h 331 BYTEs	critical error stack
480h 384 BYTEs	disk stack (functions greater than 0Ch, INT 25,INT 26)
600h 384 BYTEs	character I/O stack (functions 01h through 0Ch)
780h	BYTE	device driver lookahead flag (usually printer) (see AH=64h)
781h	BYTE	volume change flag
782h	BYTE	flag: virtual open
783h	BYTE	???
784h	WORD	???
786h	WORD	???
788h	WORD	???
78Ah	WORD	???
--------D-215E00-----------------------------
INT 21 - DOS 3.1+ network - GET MACHINE NAME
	AX = 5E00h
	DS:DX -> 16-byte buffer for ASCIZ machine name
Return: CF clear if successful
	    CH = validity
		00h name invalid
		nonzero valid
		    CL = NetBIOS number for machine name
		    DS:DX buffer filled with blank-paded name
	CF set on error
	    AX = error code (01h) (see AH=59h)
Note:	supported by OS/2 v1.3+ compatibility box, PC-NFS
SeeAlso: AX=5E01h
--------N-215E00-----------------------------
INT 21 - 10NET v5.0 - GET MACHINE NAME
	AX = 5E00h
Return: CL = redirector's NetBIOS name number
	ES:DI -> network node ID
SeeAlso: AX=5E01h"10NET"
--------D-215E01CH00-------------------------
INT 21 - DOS 3.1+ network - SET MACHINE NAME
	AX = 5E01h
	CH = 00h undefine name (make it invalid)
	   <> 0	 define name
	CL = name number
	DS:DX -> 15-character blank-padded ASCIZ name
SeeAlso: AX=5E00h
--------N-215E01-----------------------------
INT 21 - 10NET v5.0 - GET LOCAL 10NET CONFIGURATION TABLE
	AX = 5E01h
	CX = length of buffer
	DS:DX -> buffer for 10Net configuration table
SeeAlso: AX=5E00h"10NET",INT 6F/AH=02h,INT 6F/AH=03h

Format of 10Net Configuration Table:
Offset	Size	Description
 00h  8 BYTEs	user name
 08h 15 BYTEs	node ID
 17h  3 BYTEs	unique portion of Ethernet address
 1Ah	BYTE	Who group number
 1Bh	WORD	services mask (see below)
 1Dh	DWORD	serial number
 21h	BYTE	maximum concurrent users with same serial number allowed on net
 22h	BYTE	chat mask (see below)
 23h	BYTE	internal system bits (see below)
 24h  9 BYTEs	version number in format MM.mm.xxx
 2Dh	BYTE	flag: 01h if machine is a PS/2
 2Eh	BYTE	flag: 03h if 80386
 2Fh	BYTE	spool termination mode: 01h concatenate, 02h truncate
		(see AX=5D09h)
 30h	WORD	autospool timeout in clock ticks
 32h	WORD	monitor timeout in clock ticks
 34h	WORD	unused
 36h	WORD	chat timeout in clock ticks
 38h	WORD	netBIOS session timeout in half-seconds
 3Ah	WORD	datagram send timeout in seconds
 3Ch	WORD	keyboard value for initiating chat mode
 3Eh	WORD	Who timeout in clock ticks
 40h	BYTE	flag: 01h if server should process rom NetBIOS Post return
 41h	BYTE	flag: 01h if FCBs should be recycled
 42h  3 BYTEs	signature "DBG"
 45h	BYTE	last interrupt (21h or 6Fh)
 46h	BYTE	last INT 21 AH value
 47h	BYTE	last INT 6F AH value
 48h	WORD	last item posted
 4Ah	WORD	last item free-posted
 4Ch	WORD	last item handled by server
 4Eh	WORD	last redirector send NCB
 50h	WORD	last redirector receive NCB
 52h  4 BYTEs	signature "TABL"
 56h	WORD	offset of datagram buffer table header
 58h	WORD	offset of chat buffer table header
 5Ah	WORD	offset of Raw buffer table header
 5Ch	WORD	offset of Workstation buffer table header
 5Eh	WORD	offset of server receive-any table header
 60h	WORD	offset of Tiny buffer table header
 62h	WORD	offset of zero-length buffer table (NCBs)
 64h	WORD	offset of Rdr (Redirector Mount) table header
 66h	WORD	offset of Ntab (Redirector Session) table header
 68h	WORD	offset of FCB table header
 6Ah	WORD	offset of user file handle table header
 6Ch	WORD	offset of workstation printer RDR extension table header
 6Eh	WORD	offset of server shared device table header
 70h	WORD	offset of server connection table header
 72h	WORD	offset of server login table header
 74h	WORD	offset of server file table header
 76h	WORD	offset of server shared file table header
 78h	WORD	offset of server record lock table header
 7Ah	WORD	offset of remote printer claim table header
 7Ch	WORD	offset of remote printer device table header
 7Eh	WORD	offset of print server mount table header
 80h	WORD	offset of print server sessions table header
 82h	WORD	offset of print server print job structure table header
 84h	WORD	offset of print server pooled device table header
 86h	WORD	size of workstation buffer
 88h	WORD	size of server receive-any buffer
 8Ah	WORD	size of server raw I/O buffer
 8Ch  6 BYTEs	reserved
 92h	DWORD	pointer to profile pathname
 96h	BYTE	datagram retry count
 97h	BYTE	NetBIOS LAN adapter number
 98h  6 BYTEs	physical Ethernet address
 9Eh	BYTE	NetBIOS server name number
 9Fh	BYTE	NetBIOS redirector name number
 A0h	BYTE	10Net interrupt number
 A1h	BYTE	flag: chat is loaded
 A2h	BYTE	flag: INT 6F APIs permanently loaded
 A3h	BYTE	flag: file security present
 A4h	WORD	reserved
 A6h	BYTE	fixed mount bitmask for drives A:-H:
 A7h	BYTE	reserved
 A8h	WORD	10Net system flags (see below)
 AAh	BYTE	monitor flags (see below)
 ABh  5 BYTEs	reserved
 B0h	WORD	offset of monitor timer block
 B2h	WORD	offset of server timer block
 B4h	WORD	offset of chat timer block
 B6h	WORD	timer chain
 B8h  4 BYTEs	signature "TALS"
 BCh	WORD	number of 10Net sends
 BEh	WORD	number of 10Net receives
 C0h	WORD	number of no-buffer conditions
 C2h	WORD	number of dropped posted messages
 C4h	WORD	number of server NCB errors
 C6h	WORD	number of redirector NCB errors
 C8h	WORD	number of datagram send/receive errors
 CAh	WORD	number of dropped Whos
 CCh	WORD	number of dropped submits
 CEh	WORD	number of session aborts
 D0h	BYTE	number of NetBIOS interface-busy errors
 D1h	BYTE	last NetBIOS bad post command
 D2h	BYTE	last NetBIOS bad redirector command
 D3h	BYTE	do send datagram send/receive error command
 D4h	DWORD	-> DOS system parameter table
 D8h	WORD	number of DOS physical drives
 DAh	WORD	offset of DOS PSP field in DOS data segment
 DCh	WORD	offset of in-DOS flag in DOS data segment
 DEh	WORD	DOS data segment
 E0h	WORD	offset of DOS SFT in DOS data segment
 E2h	WORD	offset of number-of-physical-units field in DOS data segment
 E4h	WORD	10Net code segment
 E6h	WORD	10Net data segment
 E8h	WORD	10Net common server segment
 EAh	WORD	10Net file server segment
 ECh	WORD	10Net print server segment
 EEh	WORD	10Net remote printer segment
Note:	documentation lists field at offset D0h as a WORD, but all following
	  offsets are as though it were a BYTE; if it is indeed a WORD, all
	  offsets after D0h must be increased by one byte

Format of 10Net Table Header:
Offset	Size	Description
 -16  4 BYTEs	table identifier
 -12	WORD	peak number of tables allocated
 -10	WORD	number of tables currently in use
 -8	WORD	total number of tables
 -6	WORD	size of each table
 -4	WORD	offset of first allocated table
 -2	WORD	offset of first free table

Bitfields for services mask:
 bit 0	workstation
 bit 1	file server
 bit 2	print queue server
 bit 3	de-spool server

Bitfields for chat mask:
 bit 0	chat permitted
 bit 1	bell enabled
 bit 2	chat keyboard initiated
 bit 3	in INT 16 handler
 bit 4	in Get Input
 bit 5	display has timed out
 bit 6	chat is idle

Bitfields for internal system bits:
 bit 0	submit permitted
 bit 1	submit initiated
 bit 2	submit executing
 bit 3	internal client call/chat/spool/autospool
 bit 4	in spool termination
 bit 5	print permitted
 bit 6	waiting for keyboard input

Bitfields for 10Net System Flags:
 bit 0	in NetBIOS
 bit 1	processing INT 28
 bit 2	is server
 bit 3	in net user-DOS function
 bit 4	in DOS user-DOS function
 bit 5	in net for user non-DOS function
 bit 6	in server DOS function
 bit 7	in server non-DOS function
 bit 8	in terminate
 bit 10	in user on server request
 bit 13	in DOS for user on server
 bit 14	disable critical error handler

Bitfields for Monitor Flags:
 bit 0	waiting for monitor response
 bit 4	in monitor get-input routine
 bit 5	monitor display timeout
 bit 6	sensing for escape key
--------D-215E02-----------------------------
INT 21 - DOS 3.1+ network - SET NETWORK PRINTER SETUP STRING
	AX = 5E02h
	BX = redirection list index (see AX=5F02h)
	CX = length of setup string
	DS:SI -> setup string
Return: CF clear if successful
	CF set on error
	    AX = error code (01h) (see AH=59h)
Note:	also supported by 10NET v5.0
SeeAlso: AX=5E03h,INT 2F/AX=111Fh
--------D-215E03-----------------------------
INT 21 - DOS 3.1+ network - GET NETWORK PRINTER SETUP STRING
	AX = 5E03h
	BX = redirection list index (see AX=5F02h)
	ES:DI -> 64-byte buffer for setup string
Return: CF clear if successful
	    CX = length of setup string
	    ES:DI buffer filled
	CF set on error
	    AX = error code (01h) (see AH=59h)
Note:	also supported by 10NET v5.0, but 10NET is documented as using DS:SI
	  instead of ES:DI
SeeAlso: AX=5E02h,INT 2F/AX=111Fh
--------D-215E04-----------------------------
INT 21 - DOS 3.1+ network - SET PRINTER MODE
	AX = 5E04h
	BX = redirection list index (see AX=5F02h)
	DX = mode
	    bit 0: set if binary, clear if text (tabs expanded to blanks)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Note:	calls INT 2F/AX=111Fh with 5E04h on stack
SeeAlso: AX=5E05h"DOS",INT 2F/AX=111Fh
--------N-215E04-----------------------------
INT 21 - 10NET v5.0 - INITIATE PRINT JOB
	AX = 5E04h
	BX = zero-based redirection list index (see AX=5F02h)
	DS:DX -> extended workstation printer setup structure (see below)
Return: CF clear if successful
	CF set on error
	    AX = error code (see AH=59h)
SeeAlso: AX=5E05h"10NET",AX=5E06h"10NET"

Format of extended workstation printer setup structure:
Offset	Size	Description
 00h	BYTE	notification flags (see below)
 01h	BYTE	job control mask (see below)
 02h	WORD	days to retain file
 04h	WORD	test print length
 06h	BYTE	number of copies to print
 07h	BYTE	compression algorithm
 08h	BYTE	tab width (00h = don't expand)
 09h	BYTE	initiation type (00h normal, 01h non-spooled)
 0Ah 38 BYTEs	job start operation notification instructions
 30h 32 BYTEs	comment for job
 50h 64 BYTEs	output filename or non-spooled file

Bitfields for notification flags:
 bit 0	user at print start
 bit 1	operator at start, with reply
 bit 2	user at print completion
 bit 3	operator at completion, with reply
 bit 4	user on queue switch
 bit 5	operator on queue switch, with reply
 bit 6	user on print error

Bitfields for job control mask:
 bit 0	print banner page
 bit 1	eject page at end of job
 bit 2	mark as "held" (queue but don't print)
 bit 3	rush job (queue at top)
 bit 4	overwrite file with zeros before deletion
 bit 5	hyperspool if possible
--------D-215E05-----------------------------
INT 21 - DOS 3.1+ network - GET PRINTER MODE
	AX = 5E05h
	BX = redirection list index (see AX=5F02h)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    DX = printer mode (see AX=5E04h)
Note:	calls INT 2F/AX=111Fh with 5E05h on stack
SeeAlso: AX=5E04h"DOS",INT 2F/AX=111Fh
--------N-215E05-----------------------------
INT 21 - 10NET v5.0 - TERMINATE PRINT JOB
	AX = 5E05h
	BX = zero-based redirection list index (see AX=5F02h)
Return: CF clear if successful
	CF set on error
	    AX = error code (see AH=59h)
Note:	this call resets the spool termination mode to "truncate"
	  (see AX=5D08h)
SeeAlso: AX=5E04h"10NET",AX=5E06h
--------N-215E06-----------------------------
INT 21 - 10NET v5.0 - GET/SET 10NET WORKSTATION PRINTER SETUP STRUCTURE
	AX = 5E06h
	BX = zero-based redirection list index (see AX=5F02h)
	CX = operation (06h set, 07h get)
	DS:DX -> buffer for setup structure (same as first nine bytes of
		workstation printer setup) (see AX=5E04h"10NET")
Return: CF clear if successful
	    DS:DX buffer updated on get
	CF set on error
	    AX = error code (see AH=59h)
SeeAlso: AX=5E04h"10NET",AX=5E05h"10NET"
--------D-215F00-----------------------------
INT 21 - DOS 3.1+ network - GET REDIRECTION MODE
	AX = 5F00h
	BL = redirection type
	    03h printer
	    04h disk drive
Return: CF set on error
	    AX = error code (see AH=59h)
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
	    AX = error code (see AH=59h)
	CF clear if successful
Notes:	when redirection is off, the local device (if any) rather than the
	  remote device is used
	calls INT 2F/AX=111Eh with AX on top of the stack
SeeAlso: AX=5F00h,INT 2F/AX=111Eh
--------D-215F02-----------------------------
INT 21 - DOS 3.1+ network - GET REDIRECTION LIST ENTRY
	AX = 5F02h
	BX = zero-based redirection list index
	CX = 0000h (LANtastic)
	DS:SI -> 16-byte buffer for ASCIZ local device name
	ES:DI -> 128-byte buffer for ASCIZ network name
Return: CF clear if successful
	    BH = device status
		00h valid
		01h invalid
	    BL = device type
		03h printer
		04h disk drive
	    CX = user data previously set with AX=5F03h
	    DS:SI and ES:DI buffers filled
	    DX,BP destroyed
	CF set on error
	    AX = error code (01h,12h) (see AH=59h)
Notes:	this function is passed through to INT 2F/AX=111Eh by the DOS kernel
	error code 12h is returned if BX is greater than the size of the list
	also supported by Banyan VINES, PC-NFS, LANtastic, and 10NET
SeeAlso: AX=5F03h,INT 2F/AX=111Eh
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
	    AX = error code (01h,03h,05h,08h,0Fh,12h) (see AH=59h)
Notes:	if device type is disk drive, DS:SI must point at either a null string
	  or a string consisting the drive letter followed by a colon; if a
	  null string, the network attempts to access the destination without
	  redirecting a local drive
	the DOS kernel calls INT 2F/AX=111Eh with AX on top of the stack
	also supported by Banyan VINES, LANtastic, and 10NET
SeeAlso: AX=5F02h,AX=5F04h,INT 2F/AX=111Eh
--------D-215F04-----------------------------
INT 21 - DOS 3.1+ network - CANCEL REDIRECTION
	AX = 5F04h
	DS:SI -> ASCIZ local device name or path
	CX = 4E57h ("NW") for NetWare 4.0 requester
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,03h,05h,08h,0Fh,12h) (see AH=59h)
Notes:	the DS:SI string must be either a local device name, a drive letter
	  followed by a colon, or a network directory beginning with two
	  backslashes
	the DOS kernel calls INT 2F/AX=111Eh with AX on top of the stack
	also supported by Banyan VINES, LANtastic, and 10NET
SeeAlso: AX=5F03h,INT 2F/AX=111Eh
--------D-215F05-----------------------------
INT 21 - DOS 4+ network - GET EXTENDED REDIRECTION LIST ENTRY
	AX = 5F05h
	BX = redirection list index
	DS:SI -> buffer for ASCIZ source device name
	ES:DI -> buffer for destination ASCIZ network path
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    AX = server's netowrk process ID handle (10NET)
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
	supported by DR-DOS 5.0
	also supported by 10NET v5.0
SeeAlso: AX=5F06h"Network",INT 2F/AX=111Eh
--------O-215F05-----------------------------
INT 21 - STARLITE architecture - MAP LOCAL DRIVE LETTER TO REMOTE FILE SYSTEM
	AX = 5F05h
	DL = drive number (0=A:)
	DS:SI -> ASCIZ name of the object to map the drive to
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
SeeAlso: AX=5F06h"STARLITE"
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
	    AX = error code (see AH=59h)
	CF clear if successful
SeeAlso: AX=5F05h"STARLITE"
--------D-215F07-----------------------------
INT 21 - DOS 5+ - ENABLE DRIVE
	AX = 5F07h
	DL = drive number (0=A:)
Return: CF clear if successful
	CF set on error
	    AX = error code (0Fh) (see AH=59h)
Note:	simply sets the "valid" bit in the drive's CDS
SeeAlso: AH=52h,AX=5F08h"DOS"
--------O-215F07-----------------------------
INT 21 - STARLITE architecture - MAKE NAMED OBJECT AVAILABLE ON NETWORK
	AX = 5F07h
	DS:SI -> ASCIZ name of object to offer to network
	ES:DI -> ASCIZ name under which object will be known on the network
		MUST begin with three slashes
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
SeeAlso: AX=5F08h"STARLITE"
--------D-215F08-----------------------------
INT 21 - DOS 5+ - DISABLE DRIVE
	AX = 5F08h
	DL = drive number (0=A:)
Return: CF clear if successful
	CF set on error
	    AX = error code (0Fh) (see AH=59h)
Note:	simply clears the "valid" bit in the drive's CDS
SeeAlso: AH=52h,AX=5F07h"DOS"
--------O-215F08-----------------------------
INT 21 - STARLITE architecture - REMOVE GLOBAL NETWORK NAME OF OBJECT
	AX = 5F08h
	DS:SI -> ASCIZ network name (not local name) of object to unshare
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
SeeAlso: AX=5F07h"STARLITE"
--------O-215F09-----------------------------
INT 21 - STARLITE architecture - BIND TO NETWORK DEVICE
	AX = 5F09h
	DS:DX -> ASCIZ name of the device driver to attach to
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Note:	the STARLITE distributed file system can attach to multiple networks
	  simultaneously
SeeAlso: AX=5F0Ah
--------O-215F0A-----------------------------
INT 21 - STARLITE architecture - DETACH FROM NETWORK DEVICE
	AX = 5F0Ah
	DS:DX -> ASCIZ name of device driver to detach from
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
SeeAlso: AX=5F09h
--------N-215F30-----------------------------
INT 21 U - LAN Manager Enhanced DOS - ???
	AX = 5F30h
	???
Return: ???
--------N-215F32-----------------------------
INT 21 u - Named Pipes - LOCAL DosQNmPipeInfo
	AX = 5F32h
	BX = handle
	CX = size of _PIPEINFO structure
	DX = level (must be 0001h)
	DS:SI -> _PIPEINFO structure (see below)
Return: CF clear if successful
	    _PIPEINFO structure filled in
	CF set on error
	    AX = error code
Note:	this function was introduced by LAN Manager but is also supported by
	  the Novell DOS Named Pipe Extender, Banyan VINES, OS/2 Virtual DOS
	  Machines, and others
SeeAlso: AX=5F33h,AX=5F34h

Format of _PIPEINFO structure:
Offset	Size	Description
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
	    AH = pipe mode bit mask (see below)
	    AL = maximum number of instances
	CF set on error
	    AX = error code
Note:	this function was introduced by LAN Manager but is also supported by
	  the Novell DOS Named Pipe Extender, Banyan VINES, OS/2 Virtual DOS
	  Machines, and others
SeeAlso: AX=5F32h,AX=5F34h

Bitfields for pipe mode:
 bit 7	set if nonblocking, clear if blocking
 bit 6	set if server end, clear if client end
 bit 2	set if write in message mode, clear if write in byte mode
 bit 0	set if read in message mode, clear if read in byte mode
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
Return: CF clear if successful
	    CX = bytes read
	    SI = bytes left in the pipe
	    DX = bytes left in the current message
	    DI = pipe status
		0001h disconnected
		0002h listening
		0003h connected
		0004h closing
	CF set if error
	    AX = error code
Note:	this function was introduced by LAN Manager but is also supported by
	  the Novell DOS Named Pipe Extender, Banyan VINES, OS/2 Virtual DOS
	  Machines, and others
SeeAlso: AX=5F38h,AX=5F39h,AX=5F51h
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
	DS:SI -> DosCallNmPipe stack frame (see below)
Return: CF clear if successful
	    CX = bytes read
	CF set on error
	    AX = error code
Note:	this function was introduced by LAN Manager but is also supported by
	  the Novell DOS Named Pipe Extender, Banyan VINES, OS/2 Virtual DOS
	  Machines, and others
SeeAlso: AX=5F36h,AX=5F38h

Format of DosCallNmPipe stack frame:
Offset	Size	Description
 00h	DWORD	timeout
 04h	DWORD	-> bytes read WORD (not used!!)
 08h	WORD	out buffer length
 0Ah	DWORD	address of out buffer
 0Eh	WORD	in buffer length
 10h	DWORD	address of in buffer
 14h	DWORD	address of pipe name
--------N-215F38-----------------------------
INT 21 u - Named Pipes - LOCAL DosWaitNmPipe
	AX = 5F38h
	DS:DX -> pipe name
	BX:CX = timeout value
Return: CF clear if successful
	CF set if error
	    AX = error code
Note:	this function was introduced by LAN Manager but is also supported by
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
	DS:DX -> handle_info_1 structure (DI=0000h) (see below)
		or DWORD (DI=0001h or 0002h)
	SI = level of information (0001h)
Return: CF clear if successful
	    CX = total bytes available
	CF set if error
	    AX = error code
SeeAlso: AX=5F3Ch

Format of handle_info_1 structure:
Offset	Size	Description
 00h	DWORD	number of milliseconds which workstations collects data before
		it sends the data to the named pipe
 04h	DWORD	number of characters which workstations collects before it
		sends the data to the named pipe
--------N-215F3C-----------------------------
INT 21 u - LAN Manager Enhanced DOS - NetHandleGetInfo
	AX = 5F3Ch
	BX = handle
	CX = length of handle_info_1 structure
	DS:DX -> handle_info_1 structure (see AX=5F3Bh)
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
	DS:DX -> NetMessageBufferSend parameter structure (see below)
Return: AX = error code

Format of NetMessageBufferSend parameter structure:
Offset	Size	Description
 00h	DWORD	-> recipient name (name for specific user, name* for domain
			name wide, * for broadcast)
 04h	DWORD	-> buffer
 08h	WORD	length of buffer
--------N-215F41-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetServiceEnum
	AX = 5F41h
	BL = level of detail (0000h, 0001h or 0002h)
	CX = buffer length
	ES:DI -> buffer of service_info_0, service_info_1, or service_info_2
		(see below)
Return: CF clear if successful
	    CX = entries read
	    DX = total available
	CF set on error
	    AX = error code

Format of service_info_0 structure:
Offset	Size	Description
 00h 16 BYTEs	name

Format of service_info_1 structure:
Offset	Size	Description
 00h 16 BYTEs	name
 10h	WORD	status bitmask (see below)
 12h	DWORD	status code (see below)
		(also see Microsoft LAN Manager Programmer's Reference)
 16h	WORD	process id

Format of service_info_2 structure:
Offset	Size	Description
 00h 16 BYTEs	name
 10h	WORD	status bitmask (see below)
 12h	DWORD	status code (see below)
 16h	WORD	process id
 18h 64 BYTEs	text

Bitfields for status bitmask:
 bits 0,1	00 uninstall
		01 install pending
		10 uninstall pending
		11 installed
 bits 2,3	00 active
		01 Continue pending
		10 Pause pending
		11 paused
 bit 4	uninstallable
 bit 5	pausable
 bit 8	disk redirector paused
 bit 9	spooled device redirector paused (printing)
 bit 10 communication device redirector paused

Values for status code:
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
	ES:BX -> NetServiceControl parameter structure (see below)
Return: CF clear if successful
	CF set on error
	    AX = error code

Format of NetServiceControl parameter structure:
Offset	Size	Description
 00h	DWORD	-> service name
 04h	WORD	result buffer size
 06h	DWORD	-> result buffer as service_info_2 structure
--------N-215F43-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL DosPrintJobGetId
	AX = 5F43h
	BX = handle of remote print job
	CX = size of PRIDINFO struture
	ES:DI -> PRIDINFO structure (see below)
Return: CF clear if successful
	    PRIDINFO filled in
	CF set on error
	    AX = error code

Format of PRIDINFO structure:
Offset	Size	Description
 00h	WORD	job id
 02h 16 BYTEs	server name
 12h 13 BYTEs	queue name
 1Fh  1 BYTE	pad
--------N-215F44-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetWkstaGetInfo
	AX = 5F44h
	BX = information level (00h, 01h, or 0Ah)
	CX = buffer size
	ES:DI = buffer in which to store info
Return: AX = error code
	DX = amount of buffer used (or required)
SeeAlso: AX=5F45h,AX=5F49h
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
	ES:DI -> buffer of use_info_0 or use_info_1 structures (see below)
Return: CF clear if successful
	    CX = entries read
	    DX = total available entries
	CF set if error
	    AX = error code
SeeAlso: AX=5F47h,AX=5F48h,AX=5F4Ch

Format of use_info_0 structure:
Offset	Size	Description
 00h  9 BYTEs	local device name
 09h	BYTE	padding
 0Ah	DWORD	-> remote device name in UNC form \\server\share

Format of use_info_1 structure:
Offset	Size	Description
 00h  9 BYTEs	Local device name
 09h	BYTE	padding
 0Ah	DWORD	-> remote device name in UNC form \\server\share
 0Eh	DWORD	-> password
 12h	WORD	ignored
 14h	WORD	use type (-1 wildcard, 0 disk, 1 print, 2 com, 3 ipc)
 16h	WORD	ignored
 18h	WORD	ignored
--------N-215F47-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetUseAdd
	AX = 5F47h
	BX = level (0001h)
	CX = size of use_info_1 structure
	ES:DI -> use_info_1 structure (see AX=5F46h)
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
	DS:DX -> NetUseGetInfo parameter structure
Return: CF clear on success
	    DX = total available
	CF set on error
	    AX = error code
SeeAlso: AX=5F44h,AX=5F47h

Format of NetUseGetInfo parameter structure:
Offset	Size	Description
 00h	DWORD	pointer to either the local device name or UNC remote name
 04h	WORD	level of information (0000h or 0001h)
 06h	DWORD	pointer to buffer of use_info_0 or use_info_1 structures
 0Ah	WORD	length of buffer
--------N-215F4A-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetRemoteCopy
	AX = 5F4Ah
	DS:DX -> NetRemoteCopy parameter structure
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F4Bh

Format of NetRemoteCopy parameter structure:
Offset	Size	Description
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
 12h	WORD	copy control bitmap (see below)
 14h	DWORD	-> copy_info buffer
 18h	WORD	length of copy_info buffer

Bitfields for copy control:
 bit 0	destination must be a file
 bit 1	destination must be a directory
 bit 2	destination is opened in ascii mode instead of binary
 bit 3	source is opened in ascii mode instead of binary
 bit 4	verify all write operations
--------N-215F4B-----------------------------
INT 21 u - LAN Manager Enhanced DOS - LOCAL NetRemoteMove
	AX = 5F4Bh
	DS:DX -> NetRemoteMove parameter structure
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F4Ah

Format of NetRemoteMove parameter structure:
Offset	Size	Description
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
	    ES:DI -> server_info_X structures (depending on level) (see below)
	    BX = entries read
	    CX = total entries available
	CF set on error
	    AX = error code
Notes:	this function is also supported by the Novell DOS Named Pipe Extender
	this function has been obseleted by NetServerEnum2
SeeAlso: AX=5F53h

Format of server_info_0 structure:
Offset	Size	Description
 00h 16 BYTEs	name

Format of server_info_1 structure:
Offset	Size	Description
 00h 16 BYTEs	name
 10h	BYTE	major version in lower nibble
 11h	BYTE	minor version
 12h	DWORD	server type bitmask (see below)
 16h	DWORD	-> comment string

Bitfields for server type:
 bit 0	workstation
 bit 1	server
 bit 2	SQL server
 bit 3	primary domain controller
 bit 4	backup domain controller
 bit 5	time server
 bit 6	Apple File Protocol (AFP) server
 bit 7	Novell server
 bit 8	Domain Member (v2.1+)
 bit 9	Print Queue server (v2.1+)
 bit 10 Dialin server (v2.1+)
 bit 11 Unix server (v2.1+)
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
	ES:DI -> DosWriteMailslot parameter structure (see below)
	DS:SI -> mailslot name
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F4Fh,AX=5F50h,AX=5F51h

Format of DosWriteMailslot parameter structure:
Offset	Size	Description
 00h	DWORD	timeout
 04h	DWORD	-> buffer
--------N-215F53-----------------------------
INT 21 u - LAN Manager Enhanced DOS - NetServerEnum2
	AX = 5F53h
	DS:SI -> NetServerEnum2 parameter structure (see below)
Return: CF clear if successful
	    BX = entries read
	    CX = total entries available
	CF set on error
	    AX = error code
SeeAlso: AX=5F4Ch

Format of NetServerEnum2 parameter structure:
Offset	Size	Description
 00h	WORD	level (0000h or 0001h)
 02h	DWORD	-> buffer as array of server_info_??? structures
 06h	WORD	length of buffer
 08h	DWORD	server type bitmask (see below)
 0Ch	DWORD	-> Domain name (may be 0000h:0000h for all local domains)

Bitfields for server type:
 bit 0	workstation
 bit 1	server
 bit 2	SQL server
 bit 3	primary domain controller
 bit 4	backup domain controller
 bit 5	time server
 bit 6	Apple File Protocol (AFP) server
 bit 7	Novell server
 bit 8	Domain Member (v2.1+)
 bit 9	Print Queue server (v2.1+)
 bit 10 Dialin server (v2.1+)
 bit 11 Unix server (v2.1+)
Note:	set all bits (FFFFFFFFh) for All Types

Format of server_info_0 structure:
Offset	Size	Description
 00h 16 BYTEs	name

Format of server_info_1 structure:
Offset	Size	Description
 00h 16 BYTEs	name
 10h	BYTE	major version in lower nibble
 11h	BYTE	minor version
 12h	DWORD	server type (bits 0-11) (see above)
 16h	DWORD	-> comment string
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
	DS:SI -> 128-byte buffer for account information (see below)
	ES:DI -> ASCIZ machine name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX destroyed
Note:	must be logged into the specified machine

Format of user account structure:
Offset	Size	Description
 00h 16 BYTEs	blank-padded username (zero-padded for v4.x)
 10h 16 BYTEs	reserved (00h)
 20h 32 BYTEs	user description
 40h	BYTE	privilege bits (see below)
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

Bitfields for privilege bits:
 bit 7	bypass access control lists
 bit 6	bypass queue protection
 bit 5	treat as local process
 bit 4	bypass mail protection
 bit 3	allow audit entry creation
 bit 2	system manager
 bit 0	user cannot change password
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
	DS:SI -> message buffer (see below)
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	v4.1- return no errors
SeeAlso: AX=5F99h

Format of message buffer:
Offset	Size	Description
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
	ES:DI -> messsage buffer (see AX=5F98h for format)
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F98h
--------N-215F9A-----------------------------
INT 21 - LANtastic - GET MESSAGE PROCESSING FLAGS
	AX = 5F9Ah
Return: CF clear if successful
	    DL = bits describing processing for received unsolicited messages
		bit 0: beep before message is delivered
		bit 1: deliver message to message service
		bit 2: pop up message automatically (v3+)
	CF set on error
	    AX = error code
SeeAlso: AX=5F9Bh,AX=5F9Ch,AX=5F9Dh
--------N-215F9B-----------------------------
INT 21 - LANtastic - SET MESSAGE PROCESSING FLAG
	AX = 5F9Bh
	DL = bits describing processing for received unsolicited messages
	     (see AX=5F9Ah)
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
	DL = redirector control bits (see AH = 5F9Dh)
Return: nothing
SeeAlso: AX=5F9Bh,AX=5F9Dh
--------N-215FA0-----------------------------
INT 21 - LANtastic - GET QUEUE ENTRY
	AX = 5FA0h
	BX = queue entry index (0000h is first entry)
	DS:SI -> buffer for queue entry (see below)
	ES:DI -> ASCIZ server name in form "\\name"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX = entry index for next queue entry (BX-1 is current index)
SeeAlso: AX=5FA1h,AX=5FA2h

Values for status of entry:
 00h	empty
 01h	being updated
 02h	being held
 03h	waiting for despool
 04h	being despooled
 05h	canceled
 06h	spooled file could not be accessed
 07h	destination could not be accessed
 08h	rush job

Values for type of entry:
 00h	printer queue file
 01h	message
 02h	local file
 03h	remote file
 04h	to remote modem
 05h	batch processor file

Format of queue entry:
Offset	Size	Description
 00h	BYTE	status of entry (see above)
 01h	DWORD	size of spooled file
 05h	BYTE	type of entry (see above)
 06h	BYTE	output control
		bit 6: don't delete (for mail)
		bit 5: mail file contains voice mail (v3+)
		bit 4: mail message has been read
		bit 3: response has been requested for this mail
 07h	WORD	number of copies
 09h	DWORD	sequence number of queue entry
 0Dh 48 BYTEs	pathname of spooled file
 3Dh 16 BYTEs	user who spooled file
 4Dh 16 BYTEs	name of machine from which file was spooled
 5Dh	WORD	date file was spooled (see AX=5700h)
 5Fh	WORD	time file was spooled (see AX=5700h)
 61h 17 BYTEs	ASCIZ destination device or user name
 72h 48 BYTEs	comment field
--------N-215FA1-----------------------------
INT 21 - LANtastic - SET QUEUE ENTRY
	AX = 5FA1h
	BX = handle of opened queue entry
	DS:SI -> queue entry (see AX=5FA0h)
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
	DS:SI -> buffer for printer status (see below)
	ES:DI -> ASCIZ server name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX = next physical printer number
Note:	you must be logged in to the specified server

Format of printer status:
Offset	Size	Description
 00h	BYTE	printer state
		bit 7: printer paused
		bits 0-6: 0 printer disabled
			  1 will stop at end of job
			  2 print multiple jobs
 01h	WORD	queue index of print job being despooled
		FFFFh if not despooling--ignore all following fields
 03h	WORD	actual characters per second being output
 05h	DWORD	number of characters actually output so far
 09h	DWORD	number of bytes read from spooled file so far
 0Dh	WORD	copies remaining to print
--------N-215FA4-----------------------------
INT 21 - LANtastic v3+ - GET STREAM INFO
	AX = 5FA4h
	BX = 0-based stream index number
	DS:SI -> buffer for stream information (see below)
	ES:DI -> ASCIZ machine name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX = next stream number
SeeAlso: AX=5FA5h

Format of stream information:
Offset	Size	Description
 00h	BYTE	queueing of jobs for logical printer (0=disabled,other=enabled)
 01h 11 BYTEs	logical printer resource template (may contain ? wildcards)
--------N-215FA5-----------------------------
INT 21 - LANtastic v3+ - SET STREAM INFO
	AX = 5FA5h
	BX = 0-based stream index number
	DS:SI -> buffer containing stream information (see AX=5FA4h)
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
	DS:SI -> queue entry (see AX=5FA0h)
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
	DS:SI -> buffer for active user entry (see below)
	ES:DI -> ASCIZ machine name in form "\\server"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX = next login index
SeeAlso: AX=5FB2h

Format of active user entry:
Offset	Size	Description
 00h	WORD	virtual circuit number
 02h	BYTE	login state (see below)
 03h	BYTE	last command issued (see below)
 04h  5 BYTEs	number of I/O bytes (40-bit unsigned number)
 09h  3 BYTEs	number of server requests (24-bit unsigned)
 0Ch 16 BYTEs	name of user who is logged in
 1Ch 16 BYTEs	name of remote logged in machine
 2Ch	BYTE	extended privileges (v4+???)
		bit 0: user cannot change his password
 2Dh	WORD	time left in minutes (0000h = unlimited) (v4+???)

Bitfields for login state:
 bit 0	fully logged in
 bit 1	remote program load login
 bit 2	user has system manager privileges
 bit 3	user can create audit entries
 bit 4	bypass mail protection
 bit 5	treat as local process
 bit 6	bypass queue protection
 bit 7	bypass access control lists

Values for last command:
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
	    CX = access control list privileges for requesting user (see below)
	CF set on error
	    AX = error code

Bitfields for access control list:
 bit 4	(I) allow expansion of indirect files
 bit 5	(A) allow attribute changing
 bit 6	(P) allow physical access to device
 bit 7	(E) allow program execution
 bit 8	(N) allow file renaming
 bit 9	(K) allow directory deletion
 bit 10 (D) allow file deletion
 bit 11 (L) allow file/directory lookups
 bit 12 (M) allow directory creation
 bit 13 (C) allow file creation
 bit 14 (W) allow open for write and writing
 bit 15 (R) allow open for read and reading
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
	DS:SI -> time block (see below)
	ES:DI -> ASCIZ server name to get time from
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AH=E7h

Format of time block:
Offset	Size	Description
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
	DX = option flags (see below)
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5FC9h

Bitfields for option flags:
 bit 0	auto reboot
 bit 1	do not notify users
 bit 2	halt after shutdown
 bit 3	shutdown due to power fail (used by UPS)
 bits 4-7	reserved
 bits 8-14	user definable
 bit 15 reserved
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
	CX = bit values (value of bits you want to set) (see below)
	DX = bit mask (bits you are interested in, 0 = get only) (see below)
Return: CF clear if successful
	    CX = control bits after call
		bit 0: disable logins
	CF set on error
	    AX = error code
Note:	you must have the "S" privilege to SET, anyone can GET.
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
	  file and directory names are truncated to 8.3 if necessary.  (DR-DOS
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
	functions which take pathnames require canonical paths if invoked via
	  INT 21/AX=5D00h
	supported by OS/2 v1.1 compatibility box
	NetWare 2.1x does not support characters with the high bit set; early
	  versions of NetWare 386 support such characters except in this call.
	  In addition, NetWare returns error code 3 for the path "X:\"; one
	  should use "X:\." instead.
	for DOS 3.3-6.0, the input and output buffers may be the same, as the
	  canonicalized name is built in an internal buffer and copied to the
	  specified output buffer as the very last step
	for DR DOS 6.0, this function is not automatically called when on a
	  network.  Device drivers reportedly cannot make this call from their
	  INIT function.  Using the same pointer for both input and output
	  buffers is not supported in the April 1992 and earlier versions of
	  DR DOS
SeeAlso: AX=5FB3h,INT 2F/AX=1123h,INT 2F/AX=1221h
--------D-2161-------------------------------
INT 21 - DOS 3+ - UNUSED
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
INT 21 - DOS 3+ - GET CURRENT PSP ADDRESS
	AH = 62h
Return: BX = segment of PSP for current process
Notes:	under DOS 3+, this function does not use any of the DOS-internal stacks
	  and may thus be called at any time, even during another INT 21h call
	the current PSP is not necessarily the caller's PSP
	identical to the undocumented AH=51h
SeeAlso: AH=50h,AH=51h
--------D-216300-----------------------------
INT 21 - DOS 2.25 only - GET LEAD BYTE TABLE ADDRESS
	AX = 6300h
Return: CF clear if successful
	    DS:SI -> lead byte table (see below)
	CF set on error
	    AX = error code (01h) (see AH=59h)
Notes:	does not preserve any registers other than SS:SP
	the US version of MS-DOS 3.30 treats this as an unused function,
	  setting AL=00h and returning immediately
SeeAlso: AX=6301h,AH=07h,AH=08h,AH=0Bh

Format of lead byte table entry:
Offset	Size	Description
 00h  2 BYTEs	low/high ends of a range of leading byte of double-byte chars
 02h  2 BYTEs	low/high ends of a range of leading byte of double-byte chars
	...
  N   2 BYTEs	00h,00h end flag
--------D-216300-----------------------------
INT 21 - Far East DOS 3.2+ - GET DOUBLE BYTE CHARACTER SET LEAD-BYTE TABLE
	AX = 6300h
Return: AL = error code
	    00h successful
		DS:SI -> DBCS table (see below)
		all other registers except CS:IP and SS:SP destroyed
	    FFh not supported
Notes:	probably identical to AH=63h/AL=00h for DOS 2.25
	the US version of MS-DOS 3.30 treats this as an unused function,
	  setting AL=00h and returning immediately
	the US version of DOS 4.0+ accepts this function, but returns an empty
	  list
SeeAlso: AX=6300h"DOS 2.25"

Format of DBCS table:
Offset	Size	Description
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
SeeAlso: AH=07h,AH=08h,AH=0Bh,AH=63h,AX=6301h
--------D-2164-------------------------------
INT 21 - DOS 3.2+ internal - SET DEVICE DRIVER LOOKAHEAD FLAG
	AH = 64h
	AL = flag
		00h (default) call device driver function 5 (non-dest read)
			before INT 21/AH=01h,08h,0Ah
	    nonzero don't call driver function 5
Return: nothing (MS-DOS)
	CF set, AX=error code??? (DR-DOS 5.0, which does not support this call)
Notes:	called by DOS 3.3+ PRINT.COM
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
SeeAlso: AH=64h/BX=0001h,INT 21/AH=4Bh
--------O-2164--DX0001-----------------------
INT 21 U - OS/2 v2.0+ Virtual DOS Machine - SET SESSION TITLE
	AH = 64h
	DX = 0001h (function number)
	CX = 636Ch (magic value, "cl")
	BX = 0000h (indicates special request)
	ES:DI -> new ASCIZ title (max 12 char) or "" to restore default title
Note:	if CX is not 636Ch on entry, INT 21/AH=6Ch is invoked, because a bug
	  in OS/2 1.x FAPI erroneously called AH=64h instead of AH=6Ch
SeeAlso: AH=64h/BX=0000h,AH=64h/BX=0002h,INT 15/AH=12h/BH=05h
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
SeeAlso: AH=64h/BX=0000h,AH=64h/BX=0001h,INT 15/AH=12h/BH=05h
--------O-2164--DX0003-----------------------
INT 21 U - OS/2 v2.1+ Virtual DOS Machine - GET LASTDRIVE
	AH = 64h
	DX = 0003h (function number)
	CX = 636Ch (magic value, "cl")
	BX = 0000h (indicates special request)
Return: AL = highest drive supported
Notes:	if CX is not 636Ch on entry, INT 21/AH=6Ch is invoked, because a bug
	  in OS/2 1.x FAPI erroneously called AH=64h instead of AH=6Ch
	used by WinOS2
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
	BX = API ordinal (see below)
	other registers as appropriate for API call
	  if ordinal 0025h:
		DS:SI -> STARTDATA structure (see below)
Return: as appropriate for API call
	  if ordinal 0025h:
		AX = return code

Values for API ordinal:
 0025h	DOS32StartSession
 0082h	DosGetCP
 00A7h	DosQFSAttach
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

Format of STARTDATA structure:
Offset	Size	Description
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
--------D-2165-------------------------------
INT 21 - DOS 3.3+ - GET EXTENDED COUNTRY INFORMATION
	AH = 65h
	AL = info ID
	    01h get general internationalization info
	    02h get pointer to uppercase table
	    04h get pointer to filename uppercase table
	    05h get pointer to filename terminator table
	    06h get pointer to collating sequence table
	    07h (DOS 4+) get pointer to Double-Byte Character Set table
	BX = code page (FFFFh=global code page)
	DX = country ID (FFFFh=current country)
	ES:DI -> country information buffer (see below)
	CX = size of buffer (>= 5)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if succesful
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
Offset	Size	Description
 00h	BYTE	info ID
---if info ID = 01h---
 01h	WORD	size
 03h	WORD	country ID
 05h	WORD	code page
 07h 34 BYTEs	country-dependent info (see AH=38h)
---if info ID = 02h---
 01h	DWORD	pointer to uppercase table (see below)
---if info ID = 04h---
 01h	DWORD	pointer to filename uppercase table (see below)
---if info ID = 05h---
 01h	DWORD	pointer to filename character table (see below)
---if info ID = 06h---
 01h	DWORD	pointer to collating table (see below)
---if info ID = 07h (DOS 4+)---
 01h	DWORD	pointer to DBCS lead byte table (see below)

Format of uppercase table:
Offset	Size	Description
 00h	WORD	table size
 02h 128 BYTEs	uppercase equivalents (if any) of chars 80h to FFh

Format of collating table:
Offset	Size	Description
 00h	WORD	table size
 02h 256 BYTEs	values used to sort characters 00h to FFh

Format of filename terminator table:
Offset	Size	Description
 00h	WORD	table size (not counting this word)
 02h	BYTE	??? (01h for MS-DOS 3.30-6.00)
 03h	BYTE	lowest permissible character value for filename
 04h	BYTE	highest permissible character value for filename
 05h	BYTE	??? (00h for MS-DOS 3.30-6.00)
 06h	BYTE	first excluded character in range \ all characters in this
 07h	BYTE	last excluded character in range  / range are illegal
 08h	BYTE	??? (02h for MS-DOS 3.30-6.00)
 09h	BYTE	number of illegal (terminator) characters
 0Ah  N BYTES	characters which terminate a filename:	."/\[]:|<>+=;,
Note:	partially documented for DOS 5+, but undocumented for earlier versions

Format of filename uppercase table:
Offset	Size	Description
 00h	WORD	table size
 02h 128 BYTEs	uppercase equivalents (if any) of chars 80h to FFh

Format of DBCS lead byte table:
Offset	Size	Description
 00h	WORD	length
 02h 2N BYTEs	start/end for N lead byte ranges
	WORD	0000h	(end of table)
--------D-2165-------------------------------
INT 21 - DOS 4+ - COUNTRY-DEPENDENT CHARACTER CAPITALIZATION
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
	    AX = error code (see AH=59h)
	CF clear if successful
Note:	these calls have been documented for DOS 5+, but were undocumented in
	  DOS 4.x.
--------D-216523-----------------------------
INT 21 U - DOS 4+ internal - DETERMINE IF CHARACTER REPRESENTS YES/NO RESPONSE
	AX = 6523h
	DL = character
	DH = second character of double-byte character (if applicable)
Return: CF set on error
	CF clear if successful
	    AX = type
		00h no
		01h yes
		02h neither yes nor no
--------D-2165-------------------------------
INT 21 U - DOS 4+ internal - COUNTRY-DEPENDENT FILENAME CAPITALIZATION
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
	    AX = error code (see AH=59h)
	CF clear if successful
Note:	nonfunctional in DOS 4.00 through 6.00 due to a bug (the code sets a
	  pointer depending on the high bit of AL, but doesn't clear the
	  bit before branching by function number).
--------D-216601-----------------------------
INT 21 - DOS 3.3+ - GET GLOBAL CODE PAGE TABLE
	AX = 6601h
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    BX = active code page (see AX=6602h)
	    DX = system code page
SeeAlso: AX=6602h
--------D-216602-----------------------------
INT 21 - DOS 3.3+ - SET GLOBAL CODE PAGE TABLE
	AX = 6602h
	BX = active code page (see below)
	DX = system code page (active page at boot time)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
SeeAlso: AX=6601h,INT 2F/AX=14FFh

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
	    AX = error code (see AH=59h)
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
BUGS:	the original release of DOS 3.30 allocates a full 64K for the handle
	  table on requests for an even number of handles
	DR-DOS 3.41 and 5.0 will lose track of any open file handles beyond
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
	    AX = error code (see AH=59h)
SeeAlso: AX=5D01h,AH=6Ah,INT 2F/AX=1107h
--------D-2169-------------------------------
INT 21 U - DOS 4+ internal - GET/SET DISK SERIAL NUMBER
	AH = 69h
	AL = subfunction
	    00h get serial number
	    01h set serial number
	BL = drive (0=default, 1=A, 2=B, etc)
	DS:DX -> disk info (see below)
Return: CF set on error
	    AX = error code (see AH=59h)
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
Offset	Size	Description
 00h	WORD	info level (zero)
 02h	DWORD	disk serial number (binary)
 06h 11 BYTEs	volume label or "NO NAME    " if none present
 11h  8 BYTEs	(AL=00h only) filesystem type--string "FAT12   " or "FAT16   "
--------O-2169-------------------------------
INT 21 - DR-DOS 5.0 - NULL FUNCTION
	AH = 69h
Return: AL = 00h
SeeAlso: AH=18h
--------v-216969-----------------------------
INT 21 - VIRUS - "Rape-747" - INSTALLATION CHECK
	AX = 6969h
Return: AX = 0666h if resident
SeeAlso: AX=58CCh,AH=76h"VIRUS"
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
INT 21 U - DOS 4+ - COMMIT FILE
	AH = 6Ah
	BX = file handle
Return: CF clear if successful
	    AH = 68h
	CF set on error
	    AX = error code (06h) (see AH=59h)
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
	    AX = error code (see INT 21/AH=59h)
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
INT 21 - DOS 4+ - EXTENDED OPEN/CREATE
	AX = 6C00h
	BL = open mode as in AL for normal open (see INT 21/AH=3Dh)
	    bit 7: inheritance
	    bits 4-6: sharing mode
	    bit 3 reserved
	    bits 0-2: access mode
	BH = flags
	    bit 6 = auto commit on every write (see also AH=68h)
	    bit 5 = return error rather than doing INT 24h
	CX = create attribute
	    bits 6-15 reserved
	    bit 5: archive
	    bit 4: reserved
	    bit 3: volume label
	    bit 2: system
	    bit 1: hidden
	    bit 0: readonly
	DL = action if file exists/does not exists
	    bits 7-4 action if file does not exist
		    0000 fail
		    0001 create
	    bits 3-0 action if file exists
		    0000 fail
		    0001 open
		    0010 replace/open
	DH = 00h (reserved)
	DS:SI -> ASCIZ file name
Return: CF set on error
	   AX = error code (see AH=59h)
	CF clear if successful
	   AX = file handle
	   CX = status
		1 file opened
		2 file created
		3 file replaced
Note:	the PC LAN Program only supports DL=01h, DL=10h/sharing=compatibility,
	  and DL=12h
SeeAlso: AH=3Ch,AH=3Dh,AX=6C01h
--------O-216C01-----------------------------
INT 21 U - OS/2 v2.0 - "DosOpen2"
	AX = 6C01h
	???
Return: ???
Note:	this function is similar to AX=6C00h, but supports OS/2's extended
	  attributes
SeeAlso: AX=5704h,AX=6C00h,AH=6Fh"OS/2"
--------D-216D-------------------------------
INT 21 U - DOS 5+ ROM - FIND FIRST ROM PROGRAM
	AH = 6Dh
	DS:DX -> ASCIZ program name
Return: CF clear if found
	    [DTA] = ASCIZ name found
	CF set if not found
SeeAlso: AH=6Eh,AH=6Fh
--------O-216D-------------------------------
INT 21 U - OS/2 v1.x FAPI - "DosMkDir2"
	AH = 6Dh
	???
Return: ???
Note:	also supported by OS/2 v2.0+ Virtual DOS Machines
SeeAlso: AH=39h
--------D-216E-------------------------------
INT 21 U - DOS 5+ ROM - FIND NEXT ROM PROGRAM
	AH = 6Eh
	[DTA] = result of previous FindFirst ROM
Return: CF clear if found
	    [DTA] = ASCIZ name found
	CF set if not found
SeeAlso: AH=6Dh
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
Return: BX = current ROM scan starting segment
SeeAlso: AH=6DH,AX=6F01h,AX=6F02h
----------216F01-----------------------------
INT 21 U - DOS 5+ ROM - SET ROM SCAN START ADDRESS
	AX = 6F01h
	BX = new ROM scan starting address
SeeAlso: AX=6F00h,AX=6F03h
----------216F02-----------------------------
INT 21 U - DOS 5+ ROM - GET EXCLUSION REGION LIST
	AX = 6F02h
	ES:BX -> buffer for exclusion region list (see below)
Return: ES:BX = 0000h:0000h on error, unchanged if buffer filled
SeeAlso: AX=6F00h,AX=6F03h

Format of exclusion region list:
Offset	Size	Description
 00h	WORD	number of entries
 02h 2N WORDs	start/end segments of N excluded regions
----------216F03-----------------------------
INT 21 U - DOS 5+ ROM - SET EXCLUSION REGION LIST
	AX = 6F03h
	DS:DX -> new exclusion region list (see AX=6F02h)
Note:	DOS saves only the pointer and assumes that the contents of the list
	  are never changed, and that regions do not overlap
SeeAlso: AX=6F01h,AX=6F02h
----------217070BX6060-----------------------
INT 21 - PCW Weather Card interface - GET DATA SEGMENT
	AX = 7070h
	BX = 6060h
	CX = 7070h
	DX = 7070h
	SX = 7070h
	DX = 7070h
Return: AX = segment of data structure
Notes:	the data structure is at offset 516 from this segment.
	the update byte is at offset 514 from this segment.  Updates are
	  once per second while this byte is nonzero and it is decremented
	  once per second.  While this byte is 0 updates are once per minute.
SeeAlso: AX=7070h/BX=7070h

Format of data structure:
Offset	Type	Description
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
	SX = 7070h
	DX = 7070h
Return: AX = 0070h
	BX = 0070h
	CX = 0070h
	DX = 0070h
	SX = 0070h
	DX = 0070h
SeeAlso: AX=7070h/BX=6060h,AX=8080h
--------v-2176-------------------------------
INT 21 - VIRUS - "Klaeren"/"Hate" - INSTALLATION CHECK
	AH = 76h
Return: AL = 48h if resident
SeeAlso: AX=6969h,AX=7700h"VIRUS"
--------U-217761-----------------------------
INT 21 - WATCH.COM v3.2+ - INSTALLATION CHECK
	AX = 7761h ('wa')
Return: AX = 6177h
Note:	WATCH.COM is part of the "TSR" package by TurboPower Software
SeeAlso: INT 16/AX=7761h
--------v-217700-----------------------------
INT 21 - VIRUS - "Growing Block" - INSTALLATION CHECK
	AX = 7700h
Return: AX = 0920h if resident
SeeAlso: AH=76h,AH=7Fh
----------217734-----------------------------
INT 21 U - SCROLLit v1.7 - INSTALLATION CHECK
	AX = 7734h
Return: DX = 3477h if installed
	    AX = segment of resident code
Program: ScrollIt is a shareware backscroll utility by Bromfield Software
	  Products
--------v-217F-------------------------------
INT 21 - VIRUS - "Squeaker" - INSTALLATION CHECK
	AH = 7Fh
Return: AH = 80h if resident
SeeAlso: AX=7700h,AH=83h"VIRUS"
--------!------------------------------------
