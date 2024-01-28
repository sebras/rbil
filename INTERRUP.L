Interrupt List, part 12 of 13
This compilation is Copyright (c) 1989,1990,1991,1992,1993,1994,1995 Ralf Brown
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
		Return: AX = status word (see #2340)
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
		Return: AX = status word (see #2340)
			CX = error number
	    0012h set cursor position for direct write buffer
		DX = new cursor position
		Return: AX = status word (see #2340)
	    0013h write direct to buffer
		DL = character to be written
		DH = translation option
		Return: AX = status word (see #2340)
	    0014h write direct to buffer without echo
		DL = character to be written
		DH = translation option
		Return: AX = status word (see #2340)
	    0015h set direct write string length
		DX = string value
		Return: nothing
	    0016h write string direct to buffer
		DS:DX -> string
		Return: AX = status word (see #2340)
	    0017h write string direct to buffer, untranslated
		DS:DX -> string
		Return: AX = status word (see #2340)
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
		Return: AX = status word (see #2340)
	    0025h read screen
		DS:DX -> buffer for screen contents
		Return: AX = status word (see #2340)
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
Bit(s)	Description	(Table 2340)
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
	DS:DX -> login record (see #2341)
Return: CL = security level
	AX = status (see #2342)
SeeAlso: AH=01h,AH=80h,INT 21/AX=4402h"10MEMMGR"

Format of 10NET login record:
Offset	Size	Description	(Table 2341)
 00h  8 BYTEs	user name
 08h  8 BYTEs	password
 10h 12 BYTEs	name of SuperStation

(Table 2342)
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
SeeAlso: #2369
Index:	error codes;10Net|10Net;error codes
--------b-6F00-------------------------------
INT 6F - HP Vectra EX-BIOS - "F_ISR" (internal) - RESPOND TO LOGICAL ISR
	AH = 00h
	BP = ID for driver (see #2343)
	DH = data type (see #2344)
	DL = physical device driver's index (driver ID / 6)
	BX,CX = data
	ES:0000h -> physical device's Describe Record (see #2351)
	---keypress event data---
	    BH = keyboard state (only if bit 5 of DH set) (see #2345)
	    BL = scancode (if bit 4 of DH clear)
	    CX = number of scancodes in list (if bit 4 of DH set)
	    ES:SI -> scancode list (if bit 4 of DH set)
	---motion event data---
	    BX = new X position (abs device) or X increment (relative device)
	    CX = new Y position (abs device) or Y increment (relative device)
	---button event data
	    BL = button information
		bits 15-8 reserved
		bit 7: button state (0 = down, 1 = up)
		bits 6-0: button number (0-7)
	    BH = reserved
Return: AH = status (see #2346)
	BP,DS destroyed
	---if device is keyboard translator---
	    BL = translated scancode
	    BH = new keyboard state (if DH bit 5 set) (see #2345)
	    DH = new scancode type (see #2344)
Notes:	INT 6F corresponds to IRQ23 on the original HP Vectra AT, which is
	  unavailable because of its use as a BIOS extension software interrupt
	the INT 6F handler consists of an instruction to load DS with the
	  driver's data segment followed by an indexed far jump using BP to
	  select the destination vector; since the interrupt handler is
	  located immediately following the dispatch table, the HP_VECTOR_TABLE
	  may be found by looking at offset 0000h in the INT 6F segment, and
	  its size is equal to the offset of the interrupt handler
	each entry in the HP_VECTOR table consists of a DWORD for the driver's
	  entry point address and a WORD for the driver's data segment
	this function is not user-callable, as it is a response to a physical
	  event, and assumes that the caller has already handled the physical
	  interrupt and updated the Describe Record (see #2351) to reflect
	  the event
SeeAlso: INT 6C"HP Vectra",INT 6F/AH=02h"HP Vectra"

(Table 2343)
Values for HP Vectra EX-BIOS driver ID:
 0000h	V_SCOPY (null driver, but DS value points at system copyright string)
 0006h	V_DOLITTLE (null driver)
 000Ch	V_PNULL (null driver)
 0012h	V_SYSTEM
 0018h	reserved
 001Eh	V_S8259
 0024h	reserved
 002Ah	V_SINPUT
 0030h	reserved
 0036h	V_QWERTY (keyboard translator)
 003Ch	V_SOFTKEY (keyboard translator)
 0042h	V_FUNCTION (keyboard translator)
 0048h	V_NUMPAD (keyboard translator)
 004Eh	V_CCP (keyboard translator)
 0054h	V_SVIDEO
 005Ah	V_STRACK
 0060h	V_EVENT_TOUCH
 0066h	V_EVENT_TABLET
 006Ch	V_EVENT_POINTER
 0072h	reserved
 0078h	reserved
 007Eh	reserved
 0084h	reserved
 008Ah	V_CCPCUR (keyboard translator)
 0090h	V_RAW (keyboard translator)
 0096h	V_CCPNUM (keyboard translator)
 009Ch	V_OFF (keyboard translator)
 00A2h	V_CCPGID (translator: cursor control pad keys to GID data)
 00A8h	V_SKEY2FKEY (keyboard translator)
 00AEh	V_8041
 00B4h	V_PGID_CCP
 00BAh	C_LTABLET
 00C0h	V_LPOINTER (pointing device: mouse, etc.)
 00C6h	V_LTOUCH (touch screen)
 00CCh	V_LHPMOUSE
 00D2h	???
 ...
 0102h	???
 0108h	V_LNULL
 010Eh	reserved
 0114h	V_HPHIL
 011Ah-01C2h reserved
 016Eh	V_SCANDOOR (scancode management chip driver) (ES/QS/RS only)
 01C8h-0228h available

(Table 2344)
Values for HP Vectra EX-BIOS ISR data type:
 00h	reserved "T_KC_R0"
 01h	reserved "T_KC_R1"
 02h	ASCII data
 03h	reserved "T_KC_R3"
 04h	HP150 keyboard (ITF) scancode
 05h	reserved "T_KC_R5"
 06h	device-definable type
 07h	HP Vectra keyboard set
 08h	IBM AT scancode set
 09h	button data
 0Ah	IBM PC scancode set
 0Bh	Softkey keypad (F1-F8)
 0Ch	function key keypad (F1-F10)
 0Dh	HP Cursor Control Pad keypad
 0Eh	Qwerty keypad
 0Fh	Numeric keypad
 1xh	bit 4 set: string of CX scancode of type 0xh at ES:SI
 2xh	bit 5 set: BH contains current keyboard state
 40h	signed 8-bit relative data
 41h	signed 16-bit relative data
 42h	unsigned 8-bit absolute data
 43h	unsigned 16-bit absolute data
 45h	specially-formed data (80x25) generated by V_LTOUCH
 46h	specially-formed data (640x200) generated by V_LTABLET
 47h	specially-formed data (640x200) generated by V_LPOINTER

Bitfields for HP Vectra EX-BIOS keyboard state:
Bit(s)	Description	(Table 2345)
 0	Alt pressed
 1	Left Shift pressed
 2	Right Shift pressed
 3	Ctrl pressed
 4	CapsLock active
 5	NumLock active
 6	Right unlabeled key pressed (some international keyboards)
 7	Left unlabeled key pressed (some international keyboards)
SeeAlso: #0442

(Table 2346)
Values for HP Vectra EX-BIOS status:
 00h	successful
 02h	unsupported function
 04h	not serviced
 06h	done (no further processing should be performed on the ISR event)
 F2h	device is out of paper
 F4h	device is offline
 F6h	no more space for more drivers
 F8h	driver is busy
 FAh	bad parameter
 FEh	operation failed
Note:	status codes are always even; negative values (>= 80h) indicate errors
	  while positive values indicate exceptional conditions

Format of HP EX-BIOS driver header data:
Offset	Size	Description	(Table 2347)
 00h	WORD	driver attributes (see #2348)
 02h	WORD	string index of driver's name
 04h	WORD	driver's default logical device vector (see #2343)
 06h	WORD	driver's parent class (bitset) (see #2349)
 08h	WORD	driver's child class (bitset)
 0Ah	WORD	driver's parent vector
 0Ch	WORD	driver's child vector
 0Eh	BYTE	major subaddress
 0Fh	BYTE	minor subaddress
Notes:	this structure is located at offset 0 in the driver's data segment,
	  which in turn may be read from the HP_VECTOR_TABLE (see note in
	  main entry)
	only the first WORD is required, and everything from offset 6 onward
	  is only required if the device wishes to perform device mapping
SeeAlso: #2350,#2351

Bitfields for HP EX-BIOS driver header attributes:
Bit(s)	Description	(Table 2348)
 15	this is a complete driver header
 14	"ATR_DEVCFG" reserved
 13	driver can be mapped with the parent vector at offset 0Ah
 12	driver can be mapped with the child vector at offset 0Ch
 11-9	driver type
	000 reserved vector
	001 free vector
	010 EX-BIOS service
	011 logical driver (mapped from parent to child)
	100 mappable driver (cannot be last in driver chain)
	101 mappable driver that is last in driver chain
	110 input driver (mappable)
	111 reserved
 8	"ATR_STRING" reserved
 7	call SF_START whenever driver is remapped
 6-5	addressing requirements
	00 no subaddresses required
	01 requires major address be stored at offset 0Eh
	10 requires minor address be stored at offset 0Fh
	11 required major,minor, and mid addresses (minor in low nybble of
	      offset 0Fh, mid address in high nybble of 0Fh)
 4	driver can be shared between several parent drivers
 3	driver can be shared between several child drivers
 2	this driver header is in ROM
 1	"ATR_YIELD" reserved
 0	reserved
SeeAlso: #2347,#2349

Bitfields for HP EX-BIOS driver class:
Bit(s)	Description	(Table 2349)
 15	maps F1 to F8 softkeys
 14	keyboard
 13	cursor pad
 12	console device
 11	serial output device (may be capable of limited input)
 10	"CL_COMM" reserved
 9	interfaces multiple resources transparent to operating system
 8	serial output device filter (can be mapped between logical and physical
	  driver to perform translations)
 7	addressed block device
 6	priority boot device
 5	logical graphics input device
 4	physical graphics input device (can map to child of another driver)
 3	"CL_GID" can map to an event
 2	physical touch device
 1	reserved
 0	class extension bit
Note:	special values: FFFFh maps to all other devices (V_PNULL), and 0000h
	  maps to no other driver
SeeAlso: #2347

Format of HP EX-BIOS global data area:
Offset	Size	Description	(Table 2350)
 00h 20 BYTEs	reserved
 14h	BYTE	sound driver status
 15h	BYTE	number of pending key clicks (max 4) (see AH=34h/BP=0012h)
 16h	BYTE	current tick duration scaling factor
 17h	BYTE	current key click volume
 18h	WORD	current beep period (10 us increments) (see AH=3Ch/BP=0012h)
 1Ah	WORD	current beep duration (10 us increments)
 1Ch	BYTE	number of pending beep functions (max 4) (see AH=3Ah/BP=0012h)
 1Dh	BYTE	reserved
 1Eh	WORD	next unused string index number
 20h	...	reserved
SeeAlso: #2347

Format of HP EX-BIOS Driver Describe Record:
Offset	Size	Description	(Table 2351)
 00h 16 BYTEs	EX-BIOS driver header data (see #2347)
 10h	BYTE	device GID type
		bits 7-4: device type
		bits 3-0: physical device link address
 11h	BYTE	physical device ID (see #2353)
 12h	WORD	logical device status bits (see #2352)
 14h	BYTE	physical device vector number (driver ID / 6)
 15h	BYTE	maximum number of axes reported (0-2)
 16h	BYTE	device class
		bits 7-4: current class
		bits 3-0: default class
 17h	BYTE	number of buttons/prompts
		bits 7-4: number of prompts
		bits 3-0: number of buttons
 18h	BYTE	reserved
 19h	BYTE	(physical devices only) maximum output burst length
 1Ah	BYTE	(physical devices only) number of write registers
 1Bh	BYTE	(physical devices only) number of read registers
 1Ch	BYTE	button transition flags (bit 0 = button0, etc.)
 1Dh	BYTE	current button states (bit 0 = button0, etc.)
 1Eh	WORD	device resolution
 20h	WORD	maximum x-axis count
 22h	WORD	maximum y-axis count
 24h	WORD	X position data for absolute devices
 26h	WORD	Y position data for absolute devices
 28h	WORD	X delta for relative devices
 2Ah	WORD	Y delta for relative devices
 2Ch	WORD	(logical devices only) X-axis scaling accumulator
		(fraction of one logical unit)
 2Eh	WORD	(logical devices only) Y-axis scaling accumulator
		(fraction of one logical unit)

Bitfields for HP logical device status flags:
Bit(s)	Description	(Table 2352)
 15-5	reserved
 4	event enabled
 3	tracking enabled
 2	clipping enabled
 1	button error occurred
 0	interrupt in progress
SeeAlso: #2351

(Table 2353)
Values for HP-HIL device ID:
 00h-02h reserved
 03h	Swiss-French keyboard
 04h-06h reserved
 07h	Canadian-English keyboard
 08h-0Ah reserved
 0Bh	Italian keyboard
 0Ch	reserved
 0Dh	Dutch keyboard
 0Eh	Swedish keyboard
 0Fh	German keyboard
 10h-12h reserved
 13h	Spanish keyboard
 14h	reserved
 15h	Belgian (Flemish) keyboard
 16h	Finnish keyboard
 17h	UK keyboard
 18h	French-Canadian keyboard
 19h	Swiss-German keyboard
 1Ah	Nerwegian keyboard
 1Bh	Frensh keyboard
 1Ch	Danish keyboard
 1Dh	Katakana keyboard
 1Eh	Latin American-Spanish keyboard
 1Fh	US-American keyboard
 20h-2Bh reserved
 2Ch-2Fh tone generator
 30h-3Fh reserved
 40h-5Bh reserved (character entry)
 5Ch-5Fh barcode reader
 60h-67h reserved (relative positions)
 68h-6Bh mouse
 6Ch-6Fh trackball
 70h-7Fh reserved (relative positions)
 80h-87h reserved (absolute positions)
 88h-8Bh touchpad
 8Ch-8Fh touch screen
 90h-97h graphics tablet
 98h-9Fh reserved (absolute positions)
 A0h-BFh compressed keyboard (91-93 keys)
 C0h-DFh extended keyboard (107-109 keys)
 E0h-FFh standard keyboard (85-87 keys)
--------N-6F01-------------------------------
INT 6F - 10NET - LOGOFF
	AH = 01h
	DS:DX -> superstation ID or nulls (12 bytes)
Return: CX = number of files closed
	AX = status (see also #2342)
	    08FFh superstation ID not already logged in
SeeAlso: AH=00h"10NET",AH=81h
--------N-6F02-------------------------------
INT 6F - 10NET - STATUS OF NODE
	AH = 02h
	DS:DX -> 512-byte status record (see #2355)
Return:	CF clear if successful
	CF set on error
	    AX = error code (see #2342)
SeeAlso: INT 21/AX=5E01h"10NET"

(Table 2354)
Values for 10NET station type:
 00h	workstation
 01h	superstation
 02h	gateway station
 03h	gateway active
 04h	logged into multiple superstations
 05h	reserved

Format of 10NET node status record:
Offset	Size	Description	(Table 2355)
 00h  8 BYTEs	user name (0 if none)
 08h	BYTE	station type (see #2354)
 09h 24 BYTEs	list of superstations logged into more than one superstation
 21h 12 BYTEs	node ID
 2Dh	WORD	message count for this station (send for user node, receive for
		  superstations)
---for superstations only---
 2Fh	WORD	drives allocated (bit 0=A:, bit 1=B:,...)
 31h	BYTE	user service flags (see #2356)
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
Bit(s)	Description	(Table 2356)
 7	gate
 6	print permit on
 4	SUBMIT is on
 3	mail waiting for node
 2	calendar waiting for you
 1	news waiting for you
 0	mail waiting for you
--------b-6F0200-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_SYSTEM SF_INIT" - START INITIALIZING DRIVER
	AX = 0200h
	BP = driver ID (see #2343)
	BX = "last-used DS" value from HP global data area (see #2350)
Return: AH = status (see #2346)
	BX = new "last-used DS" value
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0202h,AH=0Ah"F_INS_FIXOWNDS"
--------b-6F0202-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_SYSTEM SF_START" - COMPLETE DRIVER INITIALIZ.
	AX = 0202h
	BP = driver ID (see #2343)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0200h,AX=0204h"HP Vectra"
--------W-6F0204-----------------------------
INT 6F C - MS Windows 3.0 - DOS APPLICATION SWITCH HOOK
	AX = 0204h
Return: AX = status
	    0000h switch is allowed
	    other switch not allowed
Note:	intercepting this call will allow a DOS application to ensure that
	  Windows will not switch away from it.
--------b-6F0204-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_SYSTEM SF_REPORT_STATE" - GET DRIVER STATE
	AX = 0204h
	BP = driver ID (see #2343)
Return: AH = status (see #2346)
	DX = device state from Logical Describe Record (see #2351,#2357)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0200h,AX=0206h"HP Vectra"

Bitfields for HP Vectra V_HPHIL driver state:
Bit(s)	Description	(Table 2357)
 0	link configuration in progress
 1	reserved
 2	no devices attached
 3	general failure
 4,5	reserved
 6	HP-HIL driver open
 7	reserved
 8	link has been reconfigured
 9	error during output request
 10	reserved
 11	output request complete
 12	timeout
 13-15	reserved
--------b-6F0206-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_SYSTEM SF_VERSION_DESC" - GET DRIVER VERSION
	AX = 0206h
	BP = driver ID (see #2343)
Return: AH = status (see #2346)
	BX = driver release date code
	    (BL = BCD years since 1960, BH = BCD week number within year)
	CX = length of version string
	ES:DI -> version string
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0200h,AX=0204h"HP Vectra",AX=0208h
--------b-6F0208-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_SYSTEM SF_DEF_ATTR" - RESET TO DEFAULT ATTR
	AX = 0208h
	BP = driver ID (see #2343)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0200h,AX=020Ah,AX=020Ch
--------b-6F020A-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_SYSTEM SF_GET_ATTR" - GET CURRENT ATTRIBUTES
	AX = 020Ah
	BP = driver ID (see #2343)
Return: AH = status (see #2346)
	BX,CX = current attributes
	BP,DS destroyed
	---for V_LTOUCH, V_LPOINTER---
	    BX = logical width
	    CX = logical height
SeeAlso: AH=00h"HP Vectra",AX=0200h,AX=0208h,AX=020Ch
--------b-6F020C-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_SYSTEM SF_SET_ATTR" - SET DEVICE ATTRIBUTES
	AX = 020Ch
	BP = driver ID (see #2343)
	BX,CX = new attributes
	---for V_LTOUCH, V_LPOINTER---
	    BX = new logical width
	    CX = new logical height
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0200h,AX=0208h,AX=020Ah
--------b-6F020E-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_SYSTEM SF_OPEN" - RESERVE DRIVER FOR ACCESS
	AX = 020Eh
	BP = driver ID (see #2343) for V_HPHIL, others
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	place device in open state, which allows output to the device
SeeAlso: AH=00h"HP Vectra",AX=0200h,AX=0208h,AX=0210h
--------b-6F0210-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_SYSTEM SF_CLOSE" - RELEASE DRIVER
	AX = 0210h
	BP = driver ID (see #2343) for V_HPHIL, others
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	place device in closed state, which disallows output to the device
SeeAlso: AH=00h"HP Vectra",AX=0200h,AX=0208h,AX=020Eh
--------b-6F0212-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_SYSTEM SF_TIMEOUT" - REPORT REQUESTED TIMEOUT
	AX = 0212h
	BP = driver ID (see #2343)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	report to driver that a previously-requested timeout interval has
	  expired
SeeAlso: AH=00h"HP Vectra",AX=0200h,AX=0208h,AX=020Eh,AX=0214h,AX=0216h
--------b-6F0214-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_SYSTEM SF_INTERVAL" - 60 HZ INTERVAL EXPIRED
	AX = 0214h
	BP = driver ID (see #2343)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	report to driver that a previously-requested 60 Hz interval has
	  expired
SeeAlso: AH=00h"HP Vectra",AX=0200h,AX=0208h,AX=020Eh,AX=0212h,AX=0216h
--------b-6F0216-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_SYSTEM SF_TEST" - PERFORM HARDWARE TEST
	AX = 0216h
	BP = driver ID (see #2343)
Return: AH = status (see #2346)
	BP,DS destroyed
	---on failure---
	CX = length of reason string
	ES:DI -> string describing error
SeeAlso: AH=00h"HP Vectra",AX=0200h,AX=0208h,AX=020Eh,AX=0212h,AX=0214h
--------N-6F03-------------------------------
INT 6F - 10NET - GET ADDRESS OF CONFIGURATION TABLE
	AH = 03h
	DS:DI -> node ID (optional)
Return: ES:BX -> configuration table (see #2358)
SeeAlso: AH=13h,INT 21/AX=5E01h"10NET"

Format of 10NET configuration table:
Offset	Size	Description	(Table 2358)
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
 1Fh	BYTE	CT_PSFLG (see #2359)
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
Bit(s)	Description	(Table 2359)
 5	PRINT permit
 4	KB initiated
 3	CHAT called FOXPTRM
 2	SUBMIT active
 1	SUBMIT received
 0	SUBMIT permit
--------N-6F04-------------------------------
INT 6F - 10NET - SEND
	AH = 04h
	DS:BX -> send record (see #2360)
	DS:DX -> data (max 1024 bytes)
Return:	CF clear if successful
	CF set on error
	    AX = error code (see #2342)
SeeAlso: AH=05h,AH=09h,AH=0Ah

Format of 10NET send record:
Offset	Size	Description	(Table 2360)
 00h 12 BYTEs	receiving node's ID
		if first byte has high-order bit set, message is directed to
		  the CT_RGATE vector at the receiver
		if second byte is 00h, first byte is taken as a CB
		  channel number and delivered to all nodes on same channel
 0Ch	WORD	 length of data at DX
--------b-6F04--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INS_BASEHPVT" - GET HP_VECTOR_TABLE ADDRESS
	AH = 04h
	BP = 0012h (driver ID for V_SYSTEM)
Return: AH = status (see #2346)
	ES = segment of HP_VECTOR_TABLE (see also AH=00h"HP Vectra")
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=06h"F_INS_XCHGFIX",AH=08h"F_INS_XCHGRSVD"
--------b-6F04--BP005A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_TRACK_INIT" - RESET TRACKING DRIVER TO DEFAULTS
	AH = 04h
	BP = 005Ah (driver ID for V_STRACK)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=06h"F_TRACK_ON",AH=08h"F_TRACK_OFF"
SeeAlso: AH=0Ah"F_DEF_MASKS",AH=0Ch"F_SET_LIMITS_X"
--------b-6F0400-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_LOCK" - RESERVE SUB-ADDRESSES
	AX = 0400h
	BP = driver ID (see #2343)
	DH,DL = major,minor address (optional)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	reserve specified sub-addresses on an already-allocated driver for
	  exclusive access
Note:	this function is documented as present but unsupported in the drivers
	  V_LTABLET, V_LPOINTER, and V_LTOUCH
SeeAlso: AH=02h"HP Vectra",AX=0402h"SF_UNLOCK"
--------b-6F0400BP001E-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_ENABLE_SVC" - UNMASK 8041 SVC INT
	AX = 0400h
	BP = 001Eh (driver ID for V_S8259)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0402h"SF_DISABLE_SVC",AX=0404h"SF_ENABLE_KBD"
SeeAlso: AX=0408h"SF_ENABLE_HPHIL"
--------b-6F0400BP002A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_DEF_LINKS" - SET DEFAULT PARENTS
	AX = 0400h
	BP = 002Ah (driver ID for V_SINPUT)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	set the parent vectors in the physical device driver headers to their
	  system defaults
SeeAlso: AH=00h"HP Vectra",AX=0402h/BP=002Ah,AX=0404h/BP=002Ah
SeeAlso: AH=06h"F_INQUIRE"
--------b-6F0400BP0054-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_VID_ID_HP" - INSTALLATION CHECK
	AX = 0400h
	BP = 0054h (driver ID for V_SVIDEO)
	???
Return: AH = status (see #2346)
	BX = 4850h ('BP')
	BP,DS destroyed
	???
Note:	only partially documented
SeeAlso: AX=0402h/BP=0054h,AX=0404h/BP=0054h,AX=0406h/BP=0054h
SeeAlso: AX=0408h/BP=0054h,AX=040Ah/BP=0054h
--------b-6F0400BP00CC-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_MOUSE_COM" - INIT INT 33 HANDLER
	AX = 0400h
	BP = 00CCh (driver ID for V_LHPMOUSE)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0402h/BP=00CCh
--------b-6F0402-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_UNLOCK" - RELEASE SUB-ADDRESSES
	AX = 0402h
	BP = driver ID (see #2343)
	DH,DL = major,minor address (optional)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	release specified sub-addresses from exclusive access
Note:	this function is documented as present but unsupported in the drivers
	  V_LTABLET, V_LPOINTER, and VLTOUCH
SeeAlso: AH=02h"HP Vectra",AX=0400h"SF_LOCK"
--------b-6F0402BP001E-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_DISABLE_SVC" - MASK 8041 SVC INT
	AX = 0402h
	BP = 001Eh (driver ID for V_S8259)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0400h/BP=001Eh,AX=0406h/BP=001Eh
SeeAlso: AX=040Ah/BP=001Eh
--------b-6F0402BP002A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_GET_LINKS" - GET DRIVER LINK FIELDS
	AX = 0402h
	BP = 002Ah (driver ID for V_SINPUT)
	ES:SI -> buffer for link table (see #2361)
Return: AH = status (see #2346)
	ES:SI buffer filled
	BP,DS destroyed
Desc:	get the parent and child vectors for the seven supported physical
	  device drivers
SeeAlso: AH=00h"HP Vectra",AX=0400h"SF_DEF_LINKS",AX=0404h"SF_SET_LINKS"
SeeAlso: AH=06h"F_INQUIRE"

Format of HP Vectra EX-BIOS driver link table:
Offset	Size	Description	(Table 2361)
 00h	BYTE	vector number of HP-HIL device #1's child
 01h	BYTE	vector number of HP-HIL device #1's parent
	...
 0Ch	BYTE	vector number of HP-HIL device #7's child
 0Dh	BYTE	vector number of HP-HIL device #7's parent
--------b-6F0402BP0054-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_VID_GET_INFO" - GET DISPLAY INFO
	AX = 0402h
	BP = 0054h (driver ID for V_SVIDEO)
	???
Return: AH = status (see #2346)
	BP,DS destroyed
	???
Note:	only partially documented
SeeAlso: AX=0400h/BP=0054h,AX=0404h/BP=0054h,AX=0406h/BP=0054h
SeeAlso: AX=0408h/BP=0054h,AX=040Ah/BP=0054h
--------b-6F0402BP00CC-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_MOUSE_COM" - FORCE INT 33 INIT
	AX = 0402h
	BP = 00CCh (driver ID for V_LHPMOUSE)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	set up INT 33 even if no mouse is installed
SeeAlso: AH=00h"HP Vectra",AX=0400h/BP=00CCh
--------b-6F0404-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_TRACK_ON" - GRAPHICS CURSOR ON
	AX = 0404h
	BP = driver ID (see #2343) for V_LPOINTER, V_LTOUCH, V_LTABLET
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	enables graphics cursor tracking of the logical device's movement
SeeAlso: AH=00h"HP Vectra",AX=0400h,AX=0406h"SF_TRACK_OFF"
--------b-6F0404BP001E-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_ENABLE_KBD" - UNMASK 8041 OBF INT
	AX = 0404h
	BP = 001Eh (driver ID for V_S8259)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0400h"SF_ENABLE_SVC",AX=0406h"SF_DISABLE_KBD"
SeeAlso: AX=0408h"SF_ENABLE_HPHIL"
--------b-6F0404BP002A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_SET_LINKS" - SET DRIVER LINK FIELDS
	AX = 0404h
	BP = 002Ah (driver ID for V_SINPUT)
	ES:SI -> buffer containing link table (see #2361)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	specify the parent and child vectors for the seven supported physical
	  device drivers
SeeAlso: AH=00h"HP Vectra",AX=0400h"SF_DEF_LINKS",AX=0402h"SF_GET_LINKS"
SeeAlso: AH=06h"F_INQUIRE"
--------b-6F0404BP0054-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_VID_SET_INFO" - SET EXT-CTRL INFO
	AX = 0404h
	BP = 0054h (driver ID for V_SVIDEO)
	???
Return: AH = status (see #2346)
	BP,DS destroyed
	???
Note:	only partially documented
SeeAlso: AX=0400h/BP=0054h,AX=0402h/BP=0054h,AX=0406h/BP=0054h
SeeAlso: AX=0408h/BP=0054h,AX=040Ah/BP=0054h
--------b-6F0406-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_TRACK_OFF" - GRAPHICS CURSOR OFF
	AX = 0406h
	BP = driver ID (see #2343) for V_LPOINTER, V_LTOUCH, V_LTABLET
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	disables graphics cursor tracking of the logical device's movement
SeeAlso: AH=00h"HP Vectra",AX=0400h,AX=0404h"SF_TRACK_ON"
SeeAlso: AX=0408h"SF_CREATE_EVENT"
--------b-6F0406BP001E-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_DISABLE_KBD" - MASK 8041 OBF INT
	AX = 0406h
	BP = 001Eh (driver ID for V_S8259)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0402h"SF_DISABLE_SVC",AX=0404h"SF_ENABLE_KBD"
SeeAlso: AX=040Ah"SF_DISABLE_HPHIL"
--------b-6F0406BP0054-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_VID_MOD_INFO" - SET EXT-CTRL REG
	AX = 0406h
	BP = 0054h (driver ID for V_SVIDEO)
	???
Return: AH = status (see #2346)
	BP,DS destroyed
	???
Note:	only partially documented
SeeAlso: AX=0400h/BP=0054h,AX=0402h/BP=0054h,AX=0404h/BP=0054h
SeeAlso: AX=0408h/BP=0054h,AX=040Ah/BP=0054h
--------b-6F0406BP0114-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CRV_RECONFIGURE" - RECONFIG LINK
	AX = 0406h
	BP = 0114h (driver ID for V_HPHIL)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=020Eh,AX=0408h"SF_CRV_WR_PROMPTS"
SeeAlso: AX=0410h"SF_CRV_SELF_TEST"
--------b-6F0408-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CREATE_EVENT" - SET EVENT HANDLER
	AX = 0408h
	BP = driver ID (see #2343) for V_LPOINTER, V_LTOUCH, V_LTABLET
	ES:SI -> new event handler (see AH=00h"HP Vectra")
	DX = new handler's DS
Return: AH = status (see #2346)
	ES:SI -> old event handler
	DX = old handler's DS
	BP,DS destroyed
Desc:	specify routine to be called on logical device events
Note:	when events occur, the event handler is called with the same registers
	  as the "F_ISR" function on AH=00h"HP Vectra"
SeeAlso: AH=00h"HP Vectra",AX=0400h,AX=0406h"SF_TRACK_OFF"
SeeAlso: AX=040Ah"SF_EVENT_ON",AX=040Ch"SF_EVENT_OFF",AH=06h"F_SAMPLE"
--------b-6F0408BP001E-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_ENABLE_HPHIL" - UNMASK HP-HIL INT
	AX = 0408h
	BP = 001Eh (driver ID for V_S8259)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0400h/BP=001Eh,AX=0404h/BP=001Eh
SeeAlso: AX=040Ah/BP=001Eh
--------b-6F0408BP0054-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_VID_GET_RES" - GET VIDMODE RESOLUTN
	AX = 0408h
	BP = 0054h (driver ID for V_SVIDEO)
	???
Return: AH = status (see #2346)
	BP,DS destroyed
	???
Note:	only partially documented
SeeAlso: AX=0400h/BP=0054h,AX=0402h/BP=0054h,AX=0404h/BP=0054h
SeeAlso: AX=0406h/BP=0054h,AX=040Ah/BP=0054h
--------b-6F0408BP0114-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CRV_WR_PROMPTS" - WRITE PROMPT
	AX = 0408h
	BP = 0114h (driver ID for V_HPHIL)
	BX = device address indicator (see #2362)
	DH = HP HIL device major address
	DL = prompt number
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=020Eh,AX=0406h/BP=0114h,AX=040Ah/BP=0114h

Bitfields for HP Vectra V_HPHIL device address indicator:
Bit(s)	Description	(Table 2362)
 15-14	reserved
 13	address in DH is valid (must be set, clear is reserved)
 12	valid value in DL
 11-0	reserved
--------b-6F040A-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_EVENT_ON" - ENABLE EVENT HANDLER
	AX = 040Ah
	BP = driver ID (see #2343) for V_LPOINTER, V_LTOUCH, V_LTABLET
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0408h"SF_CREATE_EVENT",AX=040Ch"SF_EVENT_OFF"
SeeAlso: AX=040Eh"SF_CLIPPING_ON"
--------b-6F040ABP001E-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_DISABLE_HPHIL" - MASK HP-HIL INT
	AX = 040Ah
	BP = 001Eh (driver ID for V_S8259)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0402h/BP=001Eh,AX=0406h/BP=001Eh
SeeAlso: AX=0408h/BP=001Eh
--------b-6F040ABP0054-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_VID_SET_MODE" - SET VIDEO MODE
	AX = 040Ah
	BP = 0054h (driver ID for V_SVIDEO)
	???
Return: AH = status (see #2346)
	BP,DS destroyed
	???
Note:	only partially documented
SeeAlso: AX=0400h/BP=0054h,AX=0402h/BP=0054h,AX=0404h/BP=0054h
SeeAlso: AX=0406h/BP=0054h,AX=0408h/BP=0054h
--------b-6F040ABP00AE-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CREATE_INTR" - CREATE INTERVAL ENTRY
	AX = 040Ah
	BP = 00AEh (driver ID for V_8041)
	BH = vector number of driver to be called regularly (vector addr / 6)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	add a driver to the list (max eight) of drivers which will be called
	  by the HP's 8041 at 60 Hz
Note:	the newly added entry will not be called until enabled with
	  AX=040Eh/BP=00AEh
SeeAlso: AH=00h"HP Vectra",AX=040Ch/BP=00AEh,AX=040Eh/BP=00AEh
SeeAlso: AX=0412h/BP=00AEh,AX=0416h/BP=00AEh,AX=041Ah/BP=00AEh
--------b-6F040ABP0114-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CRV_WR_ACK" - ACKNOWLEDGE DEVICE
	AX = 040Ah
	BP = 0114h (driver ID for V_HPHIL)
	BX = device address indicator (see #2362)
	DH = HP HIL device major address
	DL = acknowledge number (specific if 01h-07h, generic otherwise)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0406h/BP=0114h,AX=040Ch/BP=0114h
--------b-6F040C-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_EVENT_OFF" - DISABLE EVENT HANDLER
	AX = 040Ch
	BP = driver ID (see #2343) for V_LPOINTER, V_LTOUCH, V_LTABLET
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0408h"SF_CREATE_EVENT",AX=040Ah"SF_EVENT_ON"
--------b-6F040CBP00AE-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_DELET_INTR" - DELETE INTERVAL ENTRY
	AX = 040Ch
	BP = 00AEh (driver ID for V_8041)
	BH = vector number of driver to be removed (vector addr / 6)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	remove a driver to the list (max eight) of drivers which will be called
	  by the HP's 8041 at 60 Hz
SeeAlso: AH=00h"HP Vectra",AX=040Ah/BP=00AEh,AX=0410h/BP=00AEh
SeeAlso: AX=0412h/BP=00AEh,AX=0416h/BP=00AEh,AX=041Ah/BP=00AEh
--------b-6F040CBP0114-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CRV_REPEAT" - SET KEY REPEAT RATE
	AX = 040Ch
	BP = 0114h (driver ID for V_HPHIL)
	BX = device address indicator (see #2362)
	DH = HP HIL device major address
	DL = repeat rate (00h = 30 Hz, 01h = 60 Hz)
Return: AH = status (see #2346)
	BP,DS destroyed
Note:	this function is only available if the driver is in the open state
	  (see AX=020Eh"SF_OPEN")
SeeAlso: AH=00h"HP Vectra",AX=040Ah/BP=0114h,AX=040Eh/BP=0114h
--------b-6F040E-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CLIPPING_ON" - ENABLE CLIPPING
	AX = 040Eh
	BP = driver ID (see #2343) for V_LPOINTER, V_LTOUCH, V_LTABLET
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	causes the physical device's motion to be clipped to prevent overflow
	  or underflow of the logical position
SeeAlso: AH=00h"HP Vectra",AX=040Ah"SF_EVENT_ON",AX=0410h"SF_CLIPPING_OFF"
--------b-6F040EBP00AE-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_ENABL_INTR" - START INTERRUPT SRVICE
	AX = 040Eh
	BP = 00AEh (driver ID for V_8041)
	BH = vector number of driver to be called regularly (vector addr / 6)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	enable 60 Hz calling of a driver previously added to the list of
	  drivers to be called by the HP's 8041
SeeAlso: AH=00h"HP Vectra",AX=040Ah/BP=00AEh,AX=0410h/BP=00AEh
SeeAlso: AX=0412h/BP=00AEh,AX=0416h/BP=00AEh,AX=041Ah/BP=00AEh
--------b-6F040EBP0114-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CRV_DISABLE_REPEAT" - KEY REPT OFF
	AX = 040Eh
	BP = 0114h (driver ID for V_HPHIL)
	BX = device address indicator (see #2362)
	DH = HP HIL device major address
Return: AH = status (see #2346)
	BP,DS destroyed
Note:	this function is only available if the driver is in the open state
	  (see AX=020Eh"SF_OPEN")
SeeAlso: AH=00h"HP Vectra",AX=040Ch/BP=0114h,AX=0410h/BP=0114h
SeeAlso: AX=0416h/BP=0114h
--------b-6F0410-----------------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CLIPPING_OFF" - DISABLE CLIPPING
	AX = 0410h
	BP = driver ID (see #2343) for V_LPOINTER, V_LTOUCH, V_LTABLET
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	disables clipping of the physical device's motion, which may cause
	  overflow or underflow of the logical position
SeeAlso: AH=00h"HP Vectra",AX=040Ah"SF_EVENT_ON",AX=040Eh"SF_CLIPPING_ON"
--------b-6F0410BP00AE-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_DISBL_INTR" - END INTERRUPT SERVICE
	AX = 0410h
	BP = 00AEh (driver ID for V_8041)
	BH = vector number of driver (vector addr / 6)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	disable 60 Hz interval calls to the specified driver
SeeAlso: AH=00h"HP Vectra",AX=040Ch/BP=00AEh,AX=040Eh/BP=00AEh
SeeAlso: AX=0412h/BP=00AEh,AX=0416h/BP=00AEh,AX=041Ah/BP=00AEh
--------b-6F0410BP0114-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CRV_SELF_TEST" - PERFORM SELFTEST
	AX = 0410h
	BP = 0114h (driver ID for V_HPHIL)
	BX = device address indicator (see #2362)
	DH = HP HIL device major address
	ES:SI -> buffer for result
Return: AH = status (see #2346)
	CX = number of bytes in buffer
	BP,DS destroyed
Note:	this function is only available if the driver is in the open state
	  (see AX=020Eh"SF_OPEN")
SeeAlso: AH=00h"HP Vectra",AX=040Ch/BP=0114h,AX=0412h/BP=0114h
--------b-6F0412BP00AE-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_SET_RAMSW" - SET RAM SWITCH IN 8041
	AX = 0412h
	BP = 00AEh (driver ID for V_8041)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	sets a flag in the 8041 indicating that a second 256K bank of RAM
	  on the motherboard is enabled
SeeAlso: AH=00h"HP Vectra",AX=040Ch/BP=00AEh,AX=040Eh/BP=00AEh
SeeAlso: AX=0414h/BP=00AEh,AX=0416h/BP=00AEh,AX=041Ah/BP=00AEh
--------b-6F0412BP0114-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CRV_REPORT_STATUS" - GET DEVSTATUS
	AX = 0412h
	BP = 0114h (driver ID for V_HPHIL)
	BX = device address indicator (see #2362)
	DH = HP HIL device major address
	ES:SI -> 15-byte buffer for status
Return: AH = status (see #2346)
	CX = number of bytes returned in buffer
	BP,DS destroyed
Note:	this function is only available if the driver is in the open state
	  (see AX=020Eh"SF_OPEN")
SeeAlso: AH=00h"HP Vectra",AX=0410h/BP=0114h,AX=0414h/BP=0114h
--------b-6F0414BP00AE-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CLR_RAMSW" - CLEAR 8041 RAM SWITCH
	AX = 0414h
	BP = 00AEh (driver ID for V_8041)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	clears a flag in the 8041 indicating that a second 256K bank of RAM
	  on the motherboard is enabled, causing the second bank to be disabled
Note:	this function should normally never be called
SeeAlso: AH=00h"HP Vectra",AX=040Ch/BP=00AEh,AX=040Eh/BP=00AEh
SeeAlso: AX=0412h/BP=00AEh,AX=0418h/BP=00AEh,AX=041Ah/BP=00AEh
--------b-6F0414BP0114-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CRV_REPORT_NAME" - GET DEV NAME
	AX = 0414h
	BP = 0114h (driver ID for V_HPHIL)
	BX = device address indicator (see #2362)
	DH = HP HIL device major address
	ES:SI -> 15-byte buffer for name
Return: AH = status (see #2346)
	CX = number of bytes returned in buffer
	BP,DS destroyed
Note:	this function is only available if the driver is in the open state
	  (see AX=020Eh"SF_OPEN")
SeeAlso: AH=00h"HP Vectra",AX=0412h/BP=0114h
--------b-6F0416BP00AE-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_SET_CRTSW" - SET CRT TO MULTIMODE
	AX = 0416h
	BP = 00AEh (driver ID for V_8041)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	sets a flag in the 8041 indicating that the primary display is the
	  Multimode graphics adapter (default)
SeeAlso: AH=00h"HP Vectra",AX=040Ch/BP=00AEh,AX=040Eh/BP=00AEh
SeeAlso: AX=0412h/BP=00AEh,AX=0418h/BP=00AEh,AX=041Ah/BP=00AEh
--------b-6F0416BP0114-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_KEYBOARD_REPEAT" - SET TYPEMATIC
	AX = 0416h
	BP = 0114h (driver ID for V_HPHIL)
	BH = what to set (00h typematic rate, 01h delay, 02h both)
	BL = flag (00h = non-CCP keypad, 01h = Cursor Control Pad only)
	DL = rate
	    bits 7-4: delay value
	    bits 3-0: typematic rate
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=040Eh/BP=0114h,AX=0418h/BP=0114h
--------b-6F0418BP00AE-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_CLR_CRTSW" - SET CRT TO MONOCHROME
	AX = 0418h
	BP = 00AEh (driver ID for V_8041)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	clears a flag in the 8041, indicating that the primary display is the
	  monochrome adapter
SeeAlso: AH=00h"HP Vectra",AX=040Ch/BP=00AEh,AX=040Eh/BP=00AEh
SeeAlso: AX=0414h/BP=00AEh,AX=0416h/BP=00AEh,AX=041Ah/BP=00AEh
--------b-6F0418BP0114-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_KEYBOARD_LED" - SET KEYBOARD LEDS
	AX = 0418h
	BP = 0114h (driver ID for V_HPHIL)
	BL = new LED states
	    bit 0: scroll lock
	    bit 1: NumLock
	    bit 2: CapsLock
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=040Eh/BP=0114h,AX=0416h/BP=0114h
--------b-6F041ABP00AE-----------------------
INT 6F - HP Vectra EX-BIOS - "F_IO_CTRL SF_PASS_THRU" - SEND DATA BYTE TO 8041
	AX = 041Ah
	BP = 00AEh (driver ID for V_8041)
	BL = byte to send to 8041
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=040Ah/BP=00AEh,AX=040Eh/BP=00AEh
--------N-6F05-------------------------------
INT 6F - 10NET - RECEIVE
	AH = 05h
	CX = number of seconds before timeout
	DS:DX -> receive buffer (see #2363)
Return:	CF clear if successful
	    AH = FEh if dequeued message is a CB message
	CF set on error
	    AX = error code (see #2342)
SeeAlso: AH=04h"10NET"

Format of 10NET receive buffer:
Offset	Size	Description	(Table 2363)
 00h 12 BYTEs	sending node's ID
 0Ch	WORD	length of message
 0Eh  N BYTEs	message (maximum 1024 bytes)
--------b-6F06-------------------------------
INT 6F - HP Vectra EX-BIOS - "F_PUT_BYTE" - WRITE A BYTE OF DATA TO DEVICE
	AH = 06h
	BP = driver ID (see #2343) for V_HPHIL, others
	AL = value to output
	---if driver is V_HPHIL---
	BX = device address indicator (see #2362)
	DH = HP HIL device major address
	DL = HP-HIL device register (00h-7Fh)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	output a byte to a specific HP-HIL device register
Note:	this function is only available if the driver is in the open state
	  (see AX=020Eh"SF_OPEN")
SeeAlso: AH=04h"HP Vectra",AH=08h"F_GET_BYTE",AH=0Ah"F_PUT_BUFFER"
--------b-6F06-------------------------------
INT 6F - HP Vectra EX-BIOS - "F_SAMPLE" - POLL CURRENT ABSOLUTE POSITION
	AH = 06h
	BP = driver ID (see #2343) for V_LTOUCH, V_LPOINTER, V_LTABLET, etc.
Return: AH = status (see #2346)
	BX = current logical X position
	CX = current logical Y position
	DL = button transitions (bit N = button N state has changed)
	DH = current button states (bit N = current button N state)
	ES:0000h -> logical device's Describe Record (see #2351)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=040Ah"SF_EVENT_ON",AX=040Eh"SF_CLIPPING_ON"
--------b-6F06--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INS_XCHGFIX" - EXCH VALUES WITH FIXED VECTOR
	AH = 06h
	BP = 0012h (driver ID for V_SYSTEM)
	BX = vector address
	DX = new value for DS
	ES:DI -> new CS:IP entry point
Return: AH = status (see #2346)
	DX = old value for DS
	ES:DI -> old CS:IP entry point
	BP,DS destroyed
Desc:	replace an existing EX-BIOS driver at a fixed HPVT location without
	  initialization
SeeAlso: AH=00h"HP Vectra",AH=04h"F_INS_BASEHPVT",AH=08h"F_INS_XCHGRSVD"
SeeAlso: AH=0Ah"F_INS_XCHGFREE",AH=0Ch"F_INS_FIXOWNDS"
--------b-6F06--BP002A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INQUIRE" - GET DRIVER PHYSICAL DESCRIBE RECORD
	AH = 06h
	BP = 002Ah (driver ID for V_SINPUT)
	AL = HP-HIL physical device number (01h-07h)
Return: AH = status (see #2346)
	ES:SI -> physical describe record for driver
	BP,DS destroyed
Note:	the returned physical describe record must not be modified
SeeAlso: AH=00h"HP Vectra",AX=0400h/BP=002Ah,AH=08h/BP=002Ah,AH=0Ah/BP=002Ah
SeeAlso: AH=0Ch/BP=002Ah
--------b-6F06--BP005A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_TRACK_ON" - ENABLE CURSOR TRACKING
	AH = 06h
	BP = 005Ah (driver ID for V_STRACK)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=04h"F_TRACK_INIT",AH=08h"F_TRACK_OFF"
SeeAlso: AH=0Ah"F_DEF_MASKS",AH=0Ch"F_SET_LIMITS_X"
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
SeeAlso: AH=08h"10NET",AH=0Fh,INT 21/AH=5Ch
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
--------b-6F08-------------------------------
INT 6F - HP Vectra EX-BIOS - "F_GET_BYTE" - READ A BYTE OF DATA FROM DEVICE
	AH = 08h
	BP = driver ID (see #2343) for V_HPHIL (0114h), others
	---if device is V_HPHIL---
	BX = device address indicator (see #2362)
	DH = HP HIL device major address
	DL = HP-HIL device register (00h-7Fh)
Return: AH = status (see #2346)
	AL = value read from device
	BP,DS destroyed
Desc:	generic read-byte function; for driver V_HPHIL, retrieves the value
	  of a specific HP-HIL device register
Note:	this function is only available if the driver is in the open state
	  (see AX=020Eh"SF_OPEN")
SeeAlso: AH=06h"F_PUT_BYTE",AH=0Ah"F_PUT_BUFFER",AH=0Ch"F_GET_BUFFER"
--------b-6F08--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INS_XCHGRSVD" - EXCH VALUES WITH RESRVED VECTOR
	AH = 08h
	BP = 0012h (driver ID for V_SYSTEM)
	DX = new value for DS
	ES:DI -> new CS:IP entry point
Return: AH = status (00h,F6h) (see also #2346)
	    00h successful
		BX = vector address used
		DX = old value for DS
		ES:DI -> old CS:IP entry point
	BP,DS destroyed
Desc:	exchange the supplied entry point and DS with the values in the next
	  reserved entry in the HP_VECTOR_TABLE
Note:	returns AH=F6h if no more reserved vectors are available
SeeAlso: AH=00h"HP Vectra",AH=04h/BP=0012h,AH=06h/BP=0012h,AH=0Ah/BP=0012h
SeeAlso: AH=0Ch/BP=0012h
--------b-6F08--BP002A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INQUIRE_ALL" - GET DRIVER STATUS TABLE
	AH = 08h
	BP = 002Ah (driver ID for V_SINPUT)
	ES:SI -> buffer for device status table (see #2364)
Return: AH = status (see #2346)
	ES:SI buffer filled
	BP,DS destroyed
Note:	the returned physical describe record must not be modified
SeeAlso: AH=00h"HP Vectra",AX=0400h/BP=002Ah,AH=06h/BP=002Ah,AH=0Ah/BP=002Ah
SeeAlso: AH=0Ch/BP=002Ah

Format of HP Vectra HP-HIL physical device status table:
Offset	Size	Description	(Table 2364)
 00h	BYTE	status for HP-HIL device #1
		bit 0: device present
		bits 7-2 reserved
 01h	BYTE	device ID for HP-HIL device #1
	...
 0Ch	BYTE	status for HP-HIL device #7
 0Dh	BYTE	device ID for HP-HIL device #7
--------b-6F08--BP005A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_TRACK_OFF" - DISABLE CURSOR TRACKING
	AH = 08h
	BP = 005Ah (driver ID for V_STRACK)
Return: AH = status (see #2346)
	BP,DS destroyed
Note:	also removes the graphics cursor sprite from the screen
SeeAlso: AH=00h"HP Vectra",AH=04h"F_TRACK_INIT",AH=06h"F_TRACK_ON"
SeeAlso: AH=0Ah"F_DEF_MASKS",AH=0Ch"F_SET_LIMITS_X"
--------N-6F09-------------------------------
INT 6F - 10NET - SUBMIT
	AH = 09h
	DS:BX -> submit record (see #2365)
SeeAlso: AH=04h"10NET"

Format of 10NET submit record:
Offset	Size	Description	(Table 2365)
 00h 12 BYTEs	destination node ID (must be logged in)
 0Ch	WORD	length+2 of following 'command line' text
 0Eh  N BYTEs	command line text (<=100 bytes), system adds CR
--------N-6F0A-------------------------------
INT 6F - 10NET - CHAT
	AH = 0Ah
	DS:BX -> control parameters (see #2366)
	DS:DX -> chat message (see #2367)
SeeAlso: AH=04h"10NET",AH=8Ah

Format of 10NET chat control parameters:
Offset	Size	Description	(Table 2366)
 00h  8 BYTEs	sender ID, defaults to node's userID if nulls
 08h  8 BYTEs	destination user ID, 'EVERYONE' may be used
 10h 12 BYTEs	destination node ID

Format of 10NET chat message:
Offset	Size	Description	(Table 2367)
 00h	WORD	length+2 of following text
 02h  N BYTEs	text, max 101 bytes
--------b-6F0A-------------------------------
INT 6F - HP Vectra EX-BIOS - "F_PUT_BUFFER" - WRITE A BUFFER TO DEVICE
	AH = 0Ah
	BP = driver ID (see #2343) for V_HPHIL (0114h), others
	CX = number of bytes to write
	ES:DI -> buffer containing data
	---if driver is V_HPHIL---
	BX = device address indicator (see #2362)
	DH = HP HIL device major address
	DL = HP-HIL device register (00h-7Fh)
Return: AH = status (see #2346)
	CX = number of unwritten bytes left in buffer
	BP,DS destroyed
SeeAlso: AH=06h"F_PUT_BYTE",AH=0Ah"F_PUT_BLOCK",AH=0Ch"F_GET_BUFFER"
SeeAlso: AH=0Eh"F_PUT_WORD"
--------b-6F0A-------------------------------
INT 6F - HP Vectra EX-BIOS - "F_PUT_BLOCK" - WRITE BLOCKS TO DEVICE
	AH = 0Ah
	BP = driver ID (see #2343) for block device
	DH = device major number
	DL = device minor number
	ES:DI -> command block (see #2368)
Return: AH = status (see #2346)
	BX = operation status
	BP,DS destroyed
SeeAlso: AH=06h"F_PUT_BYTE",AH=0Ah"F_PUT_BUFFER",AH=0Ch"F_GET_BUFFER"
SeeAlso: AH=0Eh"F_PUT_WORD"

Format of HP Vectra F_PUT_BLOCK/F_GET_BLOCK command block:
Offset	Size	Description	(Table 2368)
 00h	DWORD	data transfer address
 04h	WORD	number of blocks
 06h	DWORD	block address (some devices only use low word)
--------b-6F0A--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INS_XCHGFREE" - EXCH VALUES WITH FREE VECTOR
	AH = 0Ah
	BP = 0012h (driver ID for V_SYSTEM)
	DX = new value for DS
	ES:DI -> new CS:IP entry point
Return: AH = status (00h,F6h) (see also #2346)
	    00h successful
		BX = vector address used
		DX = old value for DS
		ES:DI -> old CS:IP entry point
	BP,DS destroyed
Desc:	exchange the supplied entry point and DS with the values in the next
	  free entry in the HP_VECTOR_TABLE
Note:	returns AH=F6h if no more reserved vectors are available
SeeAlso: AH=00h"HP Vectra",AH=04h/BP=0012h,AH=06h/BP=0012h,AH=08h/BP=0012h
SeeAlso: AH=0Ch/BP=0012h
--------b-6F0A--BP002A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INQUIRE_FIRST" - GET PHYSICAL DRIVER VECTOR
	AH = 0Ah
	BP = 002Ah (driver ID for V_SINPUT)
Return: AH = status (see #2346)
	BX = vector address for first HP-HIL device
	BP,DS destroyed
Note:	all seven HP-HIL devices use consecutive vectors in the
	  HP_VECTOR_TABLE
SeeAlso: AH=00h"HP Vectra",AX=0400h/BP=002Ah,AH=06h/BP=002Ah,AH=08h/BP=002Ah
SeeAlso: AH=0Ch/BP=002Ah
--------b-6F0A--BP005A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_DEF_MASKS" - DEFINE GRAPHICS CURSOR MASKS
	AH = 0Ah
	BP = 005Ah (driver ID for V_STRACK)
	BH = width of save area in bytes
	BL = hot-spot X coordinate
	CH = height in scan lines
	CL = hot-spot Y coordinate
	ES:SI -> sprite mask (screen mask followed by XOR sprite mask)
Return: AH = status (see #2346)
	BP,DS destroyed
Note:	the save area is one byte wider than the actual sprite mask; the total
	  size of the sprite is at most 144 bytes
SeeAlso: AH=00h"HP Vectra",AH=04h"F_TRACK_INIT",AH=08h"F_TRACK_OFF"
SeeAlso: AH=0Ch"F_SET_LIMITS_X",AH=10h"F_PUT_SPRITE",AH=12h"F_REMOVE_SPRITE"
--------N-6F0B-------------------------------
INT 6F - 10NET - LOCK SEMAPHORE, RETURN IMMEDIATELY
	AH = 0Bh
	AL = drive number or 0
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see #2369)
Note:	same as INT 60/AH=12h
SeeAlso: AH=0Ch"10NET",INT 60/AH=12h

(Table 2369)
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
SeeAlso: #2342
Index:	error codes;10-Net|10-Net;error codes
--------N-6F0C-------------------------------
INT 6F - 10NET - UNLOCK SEMAPHORE
	AH = 0Ch
	AL = drive number or 0
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see also #2369)
	    01h semaphore not locked
Note:	same as INT 60/AH=13h
SeeAlso: AH=0Bh,INT 60/AH=13h
--------b-6F0C-------------------------------
INT 6F - HP Vectra EX-BIOS - "F_GET_BUFFER" - READ A BUFFER OF DATA FROM DEVICE
	AH = 0Ch
	BP = driver ID (see #2343) for V_HPHIL (0114h), others
	CX = number of bytes or blocks to read
	DS:SI -> buffer for received data
Return: AH = status (see #2346 at AH=00h"HP Vectra")
	BP,DS destroyed
SeeAlso: AH=08h"F_GET_BYTE",AH=0Ah"F_PUT_BUFFER",AH=0Ch"F_GET_BLOCK"
SeeAlso: AH=10h"F_GET_WORD"
--------b-6F0C-------------------------------
INT 6F - HP Vectra EX-BIOS - "F_GET_BLOCK" - READ BLOCKS OF DATA FROM DEVICE
	AH = 0Ch
	BP = driver ID (see #2343)
	DH = device major number
	DL = device minor number
	ES:DI -> command block (see #2368)
Return: AH = status (see #2346 at AH=00h"HP Vectra")
	BX = operation status
	BP,DS destroyed
SeeAlso: AH=08h"F_GET_BYTE",AH=0Ah"F_PUT_BLOCK",AH=0Ch"F_GET_BUFFER"
SeeAlso: AH=10h"F_GET_WORD"
--------b-6F0C--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INS_FIXOWNDS" - INSTALL VALUES IN FIXED VECTOR
	AH = 0Ch
	BP = 0012h (driver ID for V_SYSTEM)
	BX = vector address used
	ES:DI -> new CS:IP entry point
Return: AH = status (00h) (see #2346)
	BP,DS destroyed
Note:	on installation, the given entry point will be invoked with an SF_INIT
	  call (see AX=0200h"SF_INIT"), which should return the routine's DS
	  in BX.  If the SF_INIT call returns with error code FEh, the power-on
	  self-test sequence will be called.
SeeAlso: AH=00h"HP Vectra",AH=04h/BP=0012h,AH=06h/BP=0012h,AH=08h/BP=0012h
SeeAlso: AH=0Eh/BP=0012h,AH=12h/BP=0012h
--------b-6F0C--BP002A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INQUIRE_ENTRY" - GET GID DRIVER ENTRY POINT
	AH = 0Ch
	BP = 002Ah (driver ID for V_SINPUT)
Return: AH = status (see #2346)
	ES:BX -> physical GID driver CS:IP
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AX=0400h/BP=002Ah,AH=06h/BP=002Ah,AH=08h/BP=002Ah
SeeAlso: AH=0Ah/BP=002Ah
--------b-6F0C--BP005A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_SET_LIMITS_X" - SET HORIZONTAL TRACKING LIMITS
	AH = 0Ch
	BP = 005Ah (driver ID for V_STRACK)
	CX = minimum X coordinate
	DX = maximum X coordinate
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=04h/BP=005Ah,AH=08h/BP=005Ah,AH=0Eh/BP=005Ah
SeeAlso: AH=10h/BP=005Ah,AH=12h/BP=005Ah,INT 33/AX=0007h
--------N-6F0D-------------------------------
INT 6F - 10NET - "WHO" - ENUMERATE USERS ON NETWORK
	AH = 0Dh
	AL = type code
	    01h return superstations only
	    02h return non-superstations only
	    otherwise return all
	CX = length of data buffer
	DS:DX -> array of records to be filled (see #2370)
Return: CL = number of records returned (responding stations)
SeeAlso: AH=16h,AH=8Dh

Format of station record:
Offset	Size	Description	(Table 2370)
 00h 12 BYTEs	node ID
 0Ch	BYTE	station flags (see #2371)
---if AL = 01h---
 0Dh	BYTE	version number
 0Eh	WORD	level number of 10Net software in responding node
---if AL = 02h---
 0Dh  8 BYTEs	user ID
 15h	BYTE	version number
 16h	WORD	level number

Bitfields for station flags:
Bit(s)	Description	(Table 2371)
 1	workstation
 2	superstation
 3	xgate
 4	active gate
--------N-6F0E-------------------------------
INT 6F - 10NET - SPOOL/PRINT
	AH = 0Eh
	DS:DX -> spool/print record (see #2373)
Return:	CF clear if successful
	CF set on error
	    AX = error code (see also #2342)
		17FFh device not mounted
		18FFh already spooling to named device

(Table 2372)
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
Offset	Size	Description	(Table 2373)
 00h	WORD	operation code (see #2372)
 02h 11 BYTEs	file name in FCB format
---if operation code = 00h or 06h---
 0Dh	BYTE	notification flags (see #2374)
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
 12h  N BYTEs	up to 64 bytes to receive $SCNTL records (see #2375)
---if operation code = 09h---
 0Dh  3 BYTEs	unused
 10h  N BYTEs	path to non-spooled file to be queued for printing

Bitfields for notification flags:
Bit(s)	Description	(Table 2374)
 7	queue to top
 6	do ID page
 5	no form feed
 4	reserved
 3	explicit queuing only
 2	notify at print completion
 1	notify server operator, with reply
 0	notify at print start

Format of 10NET $SCNTL record:
Offset	Size	Description	(Table 2375)
 00h  8 BYTEs	user ID
 08h 11 BYTEs	filename in FCB format
 13h  6 BYTEs	node ID
 19h  3 BYTEs	creation date
 1Ch	BYTE	notification flags (see #2374)
 1Dh	BYTE	retention time in days
 1Eh	BYTE	printing device (LPTx)
 1Fh  3 BYTEs	date last printed (0 = never)
 22h	BYTE	device containing spoolfile
 23h	WORD	bytes to print for test print
 25h	WORD	block number to start print
 27h	BYTE	reserved
--------b-6F0E-------------------------------
INT 6F - HP Vectra EX-BIOS - "F_PUT_WORD" - WRITE WORD OF DATA TO DEVICE
	AH = 0Eh
	BP = driver ID (see #2343)
	DX = data word
Return: AH = status (see #2346 at AH=00h"HP Vectra")
	BP,DS destroyed
SeeAlso: AH=06h"F_PUT_BYTE",AH=0Ah"F_PUT_BUFFER",AH=10h"F_GET_WORD"
--------b-6F0E-------------------------------
INT 6F - HP Vectra EX-BIOS - "F_PUT_WORD" - WRITE A WORD OF DATA
	AH = 0Eh
	BP = driver ID (see #2343)
	??? details not yet available
Return: ???
SeeAlso: AH=06h"HP Vectra",AH=0Ah"HP Vectra",AH=10h"HP Vectra"
--------b-6F0E--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INS_FIXGETDS" - INSTALL VALUES IN FIXED VECTOR
	AH = 0Eh
	BP = 0012h (driver ID for V_SYSTEM)
	BX = vector address used
	ES:DI -> new CS:IP entry point
Return: AH = status (00h) (see #2346)
	BP,DS destroyed
Note:	on installation, the given entry point will be invoked with an SF_INIT
	  call (see AX=0200h"SF_INIT"), with the "last used DS" value in BX;
	  the routine should adjust BX and return the new value.  If the
	  SF_INIT call returns with error code FEh, the power-on self-test
	  sequence will be called.
SeeAlso: AH=00h"HP Vectra",AH=04h/BP=0012h,AH=06h/BP=0012h,AH=0Ch/BP=0012h
SeeAlso: AH=10h/BP=0012h,AH=14h/BP=0012h
--------b-6F0E--BP005A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_SET_LIMITS_Y" - SET VERTICAL TRACKING LIMITS
	AH = 0Eh
	BP = 005Ah (driver ID for V_STRACK)
	CX = minimum Y coordinate
	DX = maximum Y coordinate
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=04h/BP=005Ah,AH=08h/BP=005Ah,AH=0Ch/BP=005Ah
SeeAlso: AH=10h/BP=005Ah,AH=12h/BP=005Ah,INT 33/AX=0008h
--------N-6F0F-------------------------------
INT 6F - 10NET v5.0 - "RM LOCK" - ???
	AH = 0Fh
	???
Return: ???
SeeAlso: AH=07h,AH=08h"10NET"
--------N-6F10-------------------------------
INT 6F - 10NET - ATTACH/DETACH PRINTER
	AH = 10h
	AL = subfunction
	    00h initiate spooling if LPT1 is mounted
	    01h terminate spooling if LPT1 is mounted
SeeAlso: INT 21/AX=5D08h
--------b-6F0E-------------------------------
INT 6F - HP Vectra EX-BIOS - "F_GET_WORD" - READ WORD OF DATA FROM DEVICE
	AH = 0Eh
	BP = driver ID (see #2343)
Return: AH = status (see #2346 at AH=00h"HP Vectra")
	DX = data word
	BP,DS destroyed
SeeAlso: AH=08h"F_GET_BYTE",AH=0Ch"F_GET_BUFFER",AH=0Eh"F_PUT_WORD"
--------b-6F10--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INS_FIXGLBDS" - INSTALL VALUES IN FIXED VECTOR
	AH = 10h
	BP = 0012h (driver ID for V_SYSTEM)
	BX = vector address used
	ES:DI -> new CS:IP entry point
Return: AH = status (00h) (see #2346)
	BP,DS destroyed
Note:	on installation, the given entry point will be invoked with an SF_INIT
	  call (see AX=0200h"SF_INIT"), with BX set to the EX-BIOS global
	  data area. If the SF_INIT call returns with error code FEh, the
	  power-on self-test sequence will be called.
SeeAlso: AH=00h"HP Vectra",AH=04h/BP=0012h,AH=06h/BP=0012h
SeeAlso: AH=0Ch/BP=0012h,AH=0Eh/BP=0012h,AH=12h/BP=0012h,AH=16h/BP=0012h
--------b-6F10--BP005A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_PUT_SPRITE" - DISPLAY GRAPHICS CURSOR SPRITE
	AH = 10h
	BP = 005Ah (driver ID for V_STRACK)
	BX = X coordinate
	CX = Y coordinate
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=04h"F_TRACK_INIT",AH=08h"F_TRACK_OFF"
SeeAlso: AH=12h"F_REMOVE_SPRITE",INT 33/AX=0004h
--------N-6F11-------------------------------
INT 6F - 10NET - LOCK FCB
	AH = 11h
	AL = mode
	    01h sequential
	    02h random
	    03h random block
		CX = number of records
	DS:DX -> FCB (see #0574 at INT 21/AH=0Fh)
Return:	CF clear if successful
	CF set on error
	    AX = error code (see also #2342)
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
	DS:DX -> FCB (see #0574 at INT 21/AH=0Fh)
Return:	CF clear if successful
	CF set on error
	    AX = error code (see also #2342)
		0002h file not found
SeeAlso: AH=11h
--------b-6F12--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INS_FREEOWNDS" - INSTALL VALUES IN FREE VECTOR
	AH = 12h
	BP = 0012h (driver ID for V_SYSTEM)
	ES:DI -> new CS:IP entry point
Return: AH = status (00h) (see #2346)
	BP,DS destroyed
Note:	on installation, the given entry point will be invoked with an SF_INIT
	  call (see AX=0200h"SF_INIT"), which should return the routine's DS
	  in BX.  If the SF_INIT call returns with error code FEh, the power-on
	  self-test sequence will be called.
SeeAlso: AH=00h"HP Vectra",AH=04h/BP=0012h,AH=0Ch/BP=0012h,AH=14h/BP=0012h
SeeAlso: AH=16h/BP=0012h,AH=18h/BP=0012h
--------b-6F12--BP005A-----------------------
INT 6F - HP Vectra EX-BIOS - "F_REMOVE_SPRITE" - REMOVE GRAPHICS CURSOR SPRITE
	AH = 12h
	BP = 005Ah (driver ID for V_STRACK)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=06h"F_TRACK_ON",AH=10h"F_PUT_SPRITE"
--------N-6F13-------------------------------
INT 6F - 10NET v3.3+ - GET REMOTE CONFIGURATION TABLE ADDRESS
	AH = 13h
	DS:DX -> node ID, 12 bytes blank-padded
Return:	CF clear if successful
	    ES:BX = configuration table address on given machine
	CF set on error
	    AX = error code (see #2342)
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
	    AX = error code (see #2342)
--------b-6F14--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INS_FREEGETDS" - INSTALL VALUES IN FREE VECTOR
	AH = 14h
	BP = 0012h (driver ID for V_SYSTEM)
	ES:DI -> new CS:IP entry point
Return: AH = status (00h) (see #2346)
	BP,DS destroyed
Note:	on installation, the given entry point will be invoked with an SF_INIT
	  call (see AX=0200h"SF_INIT"), with the "last used DS" value in BX;
	  the routine should adjust BX and return the new value.  If the
	  SF_INIT call returns with error code FEh, the power-on self-test
	  sequence will be called.
SeeAlso: AH=00h"HP Vectra",AH=04h/BP=0012h,AH=0Eh/BP=0012h,AH=12h/BP=0012h
SeeAlso: AH=16h/BP=0012h
--------N-6F1501-----------------------------
INT 6F - 10NET v3.3+ - GET SHARED DEVICE ENTRY
	AX = 1501h
	BX = zero-based index
	DS:SI -> node ID, 12 bytes blank-padded
	ES:DI -> 85-byte buffer for shared device table entry (see #2376)
Return:	CF clear if successful
	    ES:DI buffer contains shared device table entry of BXth device
	CF set on error
	    AX = error code (see #2342)
SeeAlso: AX=1502h,AX=1503h,AX=9501h

Format of 10NET shared device table entry:
Offset	Size	Description	(Table 2376)
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
	    AX = error code (see #2342)
SeeAlso: AX=1501h,AX=1503h,AX=9502h
--------N-6F1503-----------------------------
INT 6F - 10NET v3.3+ - DELETE SHARED DEVICE ENTRY
	AX = 1503h
	BX = zero-based index
	DS:SI -> node ID, 12 bytes blank-padded
Return:	CF clear if successful
	CF set on error
	    AX = error code (see #2342)
SeeAlso: AX=1501h,AX=1502h,AX=9503h
--------N-6F16-------------------------------
INT 6F - 10NET v5.0 - "GL WHO" - ???
	AH = 16h
	???
Return: ???
SeeAlso: AH=0Dh
--------b-6F16--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INS_FREEGLBDS" - INSTALL VALUES IN FREE VECTOR
	AH = 16h
	BP = 0012h (driver ID for V_SYSTEM)
	ES:DI -> new CS:IP entry point
Return: AH = status (00h) (see #2346 at INT 6F/AH=00h"HP Vectra")
	BP,DS destroyed
Note:	on installation, the given entry point will be invoked with an SF_INIT
	  call (see AX=0200h"SF_INIT"), with BX set to the EX-BIOS global
	  data area.  If the SF_INIT call returns with error code FEh, the
	  power-on self-test sequence will be called.
SeeAlso: AH=00h"HP Vectra",AH=04h/BP=0012h,AH=10h/BP=0012h,AH=12h/BP=0012h
SeeAlso: AH=14h/BP=0012h,AH=18h/BP=0012h
--------N-6F17-------------------------------
INT 6F - 10NET v3.3+ - MOUNT
	AH = 17h
	AL = local drive number (0=A:)
	BL = remote drive letter or '1'..'3' for LPTn or '4' or '5' for COMx
	DS:DX -> node ID, 12 bytes blank-padded
Return:	CF clear if successful
	CF set on error
	    AX = error code (see #2342)
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
	    AX = error code (see #2342)
SeeAlso: AH=17h
--------b-6F18--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_INS_FIND" - FIND DRIVER BY ATTRIBUTES
	AH = 18h
	BP = 0012h (driver ID for V_SYSTEM)
	AL = sense of test (00h equal, 02h non-equal)
	BX = AND mask
	DX = pattern
	SI = first vector address to search
	DI = offset in HP header of field to test
Return: AH = status (00h,FEh) (see #2346 at INT 6F/AH=00h"HP Vectra")
	BP,DS destroyed
	---if AH=00h---
	SI = first matching vector address
Desc:	compare successive drivers' header fields starting at address SI
	  until the header field AND BX is either equal or non-equal to DX
SeeAlso: AH=00h"HP Vectra",AH=04h/BP=0012h,AH=0Ch/BP=0012h,AH=10h/BP=0012h
SeeAlso: AH=12h/BP=0012h,AH=16h/BP=0012h
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
--------b-6F1E--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_RAM_GET" - GET EX-BIOS FREE RAM AREA
	AH = 1Eh
	BP = 0012h (driver ID for V_SYSTEM)
Return: AH = status (00h) (see #2346 at INT 6F/AH=00h"HP Vectra")
	BX = last-used DS
	DX = maximum DS
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=04h/BP=0012h,AH=20h/BP=0012h,AH=22h/BP=0012h
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
--------b-6F20--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_RAM_RET" - RESERVE EX-BIOS MEMORY
	AH = 20h
	BP = 0012h (driver ID for V_SYSTEM)
	BX = new value for "last-used DS"
	DX = new value for "maximum DS"
Return: AH = status (00h) (see #2346 at INT 6F/AH=00h"HP Vectra")
	BP,DS destroyed
Note:	the F_INS_FIXGETDS and F_INS_FREEGETDS functions
	  (see AH=0Eh/BP=0012h,AH=14h/BP=0012h) also modify the values returned
	  by this call, requiring care if both methods are used to allocate
	  memory
SeeAlso: AH=00h"HP Vectra",AH=0Eh/BP=0012h,AH=14h/BP=0012h,AH=1Eh/BP=0012h
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
INT 6F - HP Vectra EX-BIOS - "F_CMOS_GET" - READ CMOS MEMORY
	AH = 22h
	BP = 0012h (driver ID of V_SYSTEM)
	BL = address of CMOS byte to read
Return: AH = status (see #2346 at AH=00h"HP Vectra")
	AL = byte read
	BP,DS destroyed
Note:	supported by ES, QS, and RS series HP Vectras
SeeAlso: AH=00h"HP Vectra",AH=1Eh/BP=0012h,AH=24h/BP=0012h
--------b-6F24--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_CMOS_RET" - WRITE CMOS MEMORY
	AH = 24h
	BP = 0012h (driver ID of V_SYSTEM)
	BL = address of CMOS byte to write
	AL = new value
Return: AH = status (see #2346)
	BP,DS destroyed
Note:	updates the CMOS checksum fields (both IBM-standard and HP checksums)
SeeAlso: AH=00h"HP Vectra",AH=22h/BP=0012h
--------b-6F2A--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_YIELD" - GIVE UP CPU TO OTHER TASKS
	AH = 2Ah
	BP = 0012h (driver ID of V_SYSTEM)
Return: AH = status (see #2346)
	BP,DS destroyed
Note:	this is a hook for multitasking systems
SeeAlso: AH=00h"HP Vectra",INT 15/AX=1000h,INT 2F/AX=1680h
--------b-6F30--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_SND_CLICK_ENABLE" - TURN ON KEYCLICKS
	AH = 30h
	BP = 0012h (driver ID of V_SYSTEM)
Return: AH = status (see #2346 at AH=00h"HP Vectra")
	BP,DS destroyed
Desc:	enables keyclicks and flushes any pending keyclicks
SeeAlso: AH=32h/BP=0012h,AH=34h/BP=0012h,AH=36h/BP=0012h
--------b-6F32--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_SND_CLICK_DISABLE" - TURN OFF KEYCLICKS
	AH = 32h
	BP = 0012h (driver ID of V_SYSTEM)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	disables keyclicks and flushes any pending keyclicks
SeeAlso: AH=00h"HP Vectra",AH=30h/BP=0012h,AH=38h/BP=0012h
--------b-6F34--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_SND_CLICK" - GENERATE KEYCLICK
	AH = 34h
	BP = 0012h (driver ID of V_SYSTEM)
Return: AH = status (see #2346)
	BP,DS destroyed
Desc:	generate a keyclick if fewer than four clicks are already pending
Note:	if keyclicks are already pending, the remaining click count is
	  incremented and the function returns immediately
SeeAlso: AH=00h"HP Vectra",AH=30h/BP=0012h,AH=36h/BP=0012h,AH=3Ah/BP=0012h
--------b-6F36--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_SND_BEEP_ENABLE" - ENABLE BEEPS
	AH = 36h
	BP = 0012h (driver ID of V_SYSTEM)
Return: AH = status (see #2346 at AH=00h"HP Vectra")
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=30h/BP=0012h,AH=34h/BP=0012h,AH=38h/BP=0012h
--------b-6F38--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_SND_BEEP_DISABLE" - DISABLE BEEPS
	AH = 38h
	BP = 0012h (driver ID of V_SYSTEM)
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=32h/BP=0012h,AH=36h/BP=0012h
--------b-6F3A--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_SND_BEEP" - SOUND BEEP WITH CURRENT VALUES
	AH = 3Ah
	BP = 0012h (driver ID of V_SYSTEM)
Return: AH = status (see #2346 at AH=00h"HP Vectra")
	BP,DS destroyed
Desc:	make a sound of the frequency and duration defined in the EX-BIOS
	  global data area (see #2350)
SeeAlso: AH=00h"HP Vectra",AH=34h/BP=0012h,AH=36h/BP=0012h,AH=38h/BP=0012h
SeeAlso: AH=3Ch/BP=0012h,AH=3Eh/BP=0012h
--------b-6F3C--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_SND_SET_BEEP" - SET BEEP FREQUENCY AND DURATION
	AH = 3Ch
	BP = 0012h (driver ID of V_SYSTEM)
	BX = frequency in Hz (1-25000, 0 = off)
	DX = duration in 10-microsecond increments
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=3Ah/BP=0012h,AH=3Eh/BP=0012h,#2350
--------b-6F3E--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_SND_TONE" - SOUND TONE WITH FREQ AND DURATION
	AH = 3Eh
	BP = 0012h (driver ID of V_SYSTEM)
	BX = frequency in Hz (1-25000, 0 = off)
	DX = duration in 10-microsecond increments
Return: AH = status (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=3Ah/BP=0012h,AH=3Ch/BP=0012h,AH=40h/BP=0012h
--------b-6F40--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_STR_GET_FREE_INDEX" - FIND FREE STRING INDEX
	AH = 40h
	BP = 0012h (driver ID of V_SYSTEM)
Return: AH = status (see #2346)
	BX = next free string index
	BP,DS destroyed
Desc:	get the next string index available to user programs
SeeAlso: AH=00h"HP Vectra",AH=42h/BP=0012h,AH=44h/BP=0012h,AH=46h/BP=0012h
--------b-6F42--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_STR_DEL_BUCKET" - DEL HEADER FROM BUCKET LIST
	AH = 42h
	BP = 0012h (driver ID of V_SYSTEM)
	ES:DI -> bucket header (see #2377)
Return: AH = status (00h,FEh) (see #2346 at AH=00h"HP Vectra")
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=40h/BP=0012h,AH=44h/BP=0012h

Format of HP Vectra EX-BIOS bucket header:
Offset	Size	Description	(Table 2377)
 00h	DWORD	pointer to next bucket header (FFFFh:FFFFh if last)
 04h	WORD	upper bound on string index
 06h	WORD	lower bound on string index
 08h	DWORD	pointer to array of string offset pointers
 0Ch	WORD	segment of strings
Note:	the strings pointed at by the offset pointers are byte-counted ASCIZ
	  strings
--------b-6F44--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_STR_PUT_BUCKET" - ADD HEADER TO BUCKET HDR LIST
	AH = 44h
	BP = 0012h (driver ID of V_SYSTEM)
	ES:DI -> bucket header (see #2377)
Return: AH = status (00h) (see #2346)
	BP,DS destroyed
SeeAlso: AH=00h"HP Vectra",AH=42h/BP=0012h,AH=46h/BP=0012h
--------b-6F46--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_STR_GET_STRING" - FIND STRING IN BUCKET LIST
	AH = 46h
	BP = 0012h (driver ID of V_SYSTEM)
	BX = string index
Return: AH = status (00h,other) (see #2346)
	BP,DS destroyed
	---if successful---
	CX = length of string (excluding count byte and terminating NUL)
	DS:SI -> header for string
	ES:DI -> found string
SeeAlso: AH=00h"HP Vectra",AH=44h/BP=0012h,AH=48h/BP=0012h
--------b-6F48--BP0012-----------------------
INT 6F - HP Vectra EX-BIOS - "F_STR_GET_INDEX" - GET INDEX FOR STRING
	AH = 48h
	BP = 0012h (driver ID of V_SYSTEM)
	ES:DI -> ASCIZ string
Return: AH = status (00h,other) (see #2346 at AH=00h"HP Vectra")
	BP,DS destroyed
	---if successful---
	BX = index for the given string
SeeAlso: AH=00h"HP Vectra",AH=40h/BP=0012h,AH=46h/BP=0012h
--------N-6F80-------------------------------
INT 6F - 10NET v5.0 - LOGIN
	AH = 80h
	DS:DX -> login record (see #2378)
Return: CF clear if successful
	    BL = number of days until password expires (00h = never)
	    CL = security level
	CF set on error
	    AX = status (see #2342)
SeeAlso: AH=00h,AH=81h

Format of 10NET login record:
Offset	Size	Description	(Table 2378)
 00h  8 BYTEs	user name
 08h  8 BYTEs	password
 10h 15 BYTEs	server node ID
 1Fh  8 BYTEs	new password
 27h	BYTE	invoke mode (00h command line, 01h interactive)
--------N-6F81-------------------------------
INT 6F - 10NET v5.0 - LOGOUT
	AH = 81h
	DS:DX -> server node ID (DX=0000h for universal logout)
Return: AX = status (see #2342)
SeeAlso: AH=01h,AH=80h
--------N-6F8A-------------------------------
INT 6F - 10NET v5.0 - CHAT
	AH = 8Ah
	DS:BX -> chat parameters (see #2379)
	DS:DX -> chat message (see #2380)
Return: CF clear if successful
	CF set on error
	    AX = status (see #2342)
SeeAlso: AH=0Ah

Format of 10NET chat parameters:
Offset	Size	Description	(Table 2379)
 00h  8 BYTEs	sender's user name
 08h  8 BYTEs	destination user name
 10h 15 BYTEs	destination node (0 if broadcast-style chat)

Format of 10NET chat message:
Offset	Size	Description	(Table 2380)
 00h	WORD	message length
 02h  N BYTEs	chat message contents
--------N-6F8D-------------------------------
INT 6F - 10NET v5.0 - "WHO" - ENUMERATE USERS ON NETWORK
	AH = 8Dh
	BX = service mask (see #2381)
	CX = length of buffer
	DS:DX -> buffer for array of Who data structures (see #2382)
Return: CF clear if successful
	    CX = number of nodes matching service mask
	    DS:DX buffer filled
	CF set on error
	    AX = status (see #2342)
SeeAlso: AH=0Dh

Bitfields for 10NET service mask:
Bit(s)	Description	(Table 2381)
 0	workstation
 1	file server
 2	print server
 3	de-spool server

Format of 10NET Who data structure:
Offset	Size	Description	(Table 2382)
 00h  8 BYTEs	user name
 08h 15 BYTEs	node ID
 17h  3 BYTEs	unique portion of Ethernet address
 1Ah	BYTE	Who group number
 1Bh	WORD	service mask (see #2381)
 1Dh	DWORD	serial number
 21h	BYTE	maximum concurrent users with same serial number allowed on net
 22h	BYTE	chat mask (see #2383)
 23h	BYTE	internal system bits (see #2384)
 24h  9 BYTEs	version number in format MM.mm.xxx
 2Dh	BYTE	number of shared directories
 2Eh	BYTE	number of shared printer queues

Bitfields for 10NET chat mask:
Bit(s)	Description	(Table 2383)
 0	chat permitted
 1	bell enabled
 2	chat keyboard initiated
 3	in INT 16 handler
 4	in Get Input
 5	display has timed out
 6	chat is idle

Bitfields for 10NET internal system bits:
Bit(s)	Description	(Table 2384)
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
	ES:DI -> buffer for shared device structure (see #2385)
Return: CF clear if successful
	CF set on error
	    AX = status (see #2342)
SeeAlso: AX=1501h,AX=9502h,AX=9503h,AX=9504h

Format of 10NET shared device structure:
Offset	Size	Description	(Table 2385)
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
 32h	BYTE	notification bit mask (see #2386)
 33h	BYTE	job control bit mask (see #2387)
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
Bit(s)	Description	(Table 2386)
 0	user at print start
 1	operator at start, with reply
 2	user at print completion
 3	operator at completion, with reply
 4	user on queue switch
 5	operator on queue switch, with reply
 6	user on print error

Bitfields for 10NET job control mask:
Bit(s)	Description	(Table 2387)
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
	ES:DI -> shared device structure (see #2385)
Return: CF clear if successful
	CF set on error
	    AX = status (see #2342)
SeeAlso: AX=1502h,AX=9501h,AX=9503h,AX=9504h
--------N-6F9503-----------------------------
INT 6F - 10NET v5.0 - DELETE SHARED DEVICE
	AX = 9503h
	BX = zero-based index
	DS:SI -> server's node ID
Return: CF clear if successful
	CF set on error
	    AX = status (see #2342)
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
	    AX = status (see #2342)
SeeAlso: AX=9501h,AX=9502h,AX=9503h
--------N-6F99-------------------------------
INT 6F - 10NET v5.0 - AUDIT
	AH = 99h
	DS:SI -> server's node ID
	ES:DI -> data to be appended to audit trail file (max 106 bytes)
Return: CF clear if successful
	CF set on error
	    AX = status (see #2342)
SeeAlso: AH=19h,AH=9Ch
--------N-6F9C-------------------------------
INT 6F - 10NET v5.0 - GET LOGIN LIST
	AH = 9Ch
	BX = zero-based index
Return: CF clear if successful
	    DS:DI -> BX'th node ID that caller's machine is logged into
	CF set on error
	    AX = status (see #2342)
--------H-70---------------------------------
INT 70 C - IRQ8 - CMOS REAL-TIME CLOCK
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
INT 71 C - IRQ9 - REDIRECTED TO INT 0A BY BIOS
Notes:	may be masked by setting bit 1 on I/O port A1h
	the default BIOS handler invokes INT 0A for compatibility, since the
	  pin for IRQ2 on the PC expansion bus became the pin for IRQ9 on the
	  AT expansion bus.
	under DESQview, only the INT 15h vector and BASIC segment address (the
	  word at 0000h:0510h) may be assumed to be valid for the handler's
	  process
SeeAlso: INT 0A,INT 59
--------H-72---------------------------------
INT 72 C - IRQ10 - RESERVED
Note:	may be masked by setting bit 2 on I/O port A1h
SeeAlso: INT 5A
--------H-73---------------------------------
INT 73 C - IRQ11 - RESERVED
Note:	may be masked by setting bit 3 on I/O port A1h
SeeAlso: INT 5B
--------H-74---------------------------------
INT 74 C - IRQ12 - POINTING DEVICE (PS)
Notes:	may be masked by setting bit 4 on I/O port A1h
	under DESQview, only the INT 15h vector and BASIC segment address (the
	  word at 0000h:0510h) may be assumed to be valid for the handler's
	  process
SeeAlso: INT 33,INT 5C
--------H-75---------------------------------
INT 75 C - IRQ13 - MATH COPROCESSOR EXCEPTION (AT and up)
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
INT 76 C - IRQ14 - HARD DISK CONTROLLER OPERATION COMPLETE (AT and later)
Notes:	may be masked by setting bit 6 on I/O port A1h
	on the PS/2, this interrupt is designed to be shared with other
	  devices that produce an operation-complete interrupt, though
	  the only current user is the hard disk
SeeAlso: INT 0E"IRQ6",INT 15/AH=91h,INT 5E
--------H-77---------------------------------
INT 77 C - IRQ15 - RESERVED (AT,PS)
Note:	may be masked by setting bit 7 on I/O port A1h
SeeAlso: INT 5F
--------H-77---------------------------------
INT 77 C - IRQ15 - POWER CONSERVATION (Compaq SLT/286)
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
Notes:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
	the newest versions of GO32 dynamically allocate the vectors used
	  for the relocated IRQs, much as DESQview does (see INT 50"DESQview")
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
--------s-78-------------------------------
INT 78 - ULTRAMID - API
	AX = function
	--- digital functions ---
	    0000h start digital
		ES:DI -> Sound Structure
		Return: AX = voice used
	    0001h play next buffer
		ES:DI -> Sound Structure
	    0002h set panning
		BX = pan
		CX = voice
	    0003h set volume
		BX = volume
		CX = voice
	    0004h set rate (not yet implemented)
	    0005h pause digital
		CX = voice
	    0006h restart digital
		CX = voice
	    0007h stop digital
		CX = voice
	    0008h get digital position
		CX = voice
		Return: AX:DX -> position in PC buffer
	    0009h get voice status (not yet implemented)
	--- MIDI functions ---
	    000Ah load MIDI patches
		ES:DI -> MIDI track just after the Mtrk header
		BX:DX = length of MIDI track
	    000Bh load XMIDI patches
		ES:DI -> event buffer including the EVNT header
	    000Ch load patch
		CX = MIDI number of patch
	    000Dh unload patch
		CX = MIDI number of patch
	    000Eh start sequence
	    000Fh unload all patches
	    0010h MIDI out byte
		CX = MIDI byte
	    0011h MIDI out string
		CX = length
		ES:DI -> string of MIDI data
	    0012h all notes off
	--- resource functions ---
	    0013h allocate memory
		BX:DX = size of GUS memory needed
		Return: AX:DX = address of memory, or 0000:0000 if not avaiable
	    0014h free memory
		BX:DX = address of memory to be freed
	    0015h uninstall
	    0016h sem enter
	    0017h sem leave
	    0018h add external semaphore
		BX:DX -> external semaphore
	    0019h clear external semaphore
		BX:DX -> external semaphore
	    001Ah application start
	    001Bh application end
Program: UltraMid is a TSR from Advanced Gravis to play MIDI and digital data
	   through the Gravis UltraSound (GUS)
Range:	INT 78 to INT 7F
Notes:	the installation check is testing for the signature "ULTRAMID" at
	  offset 0103h in the interrupt handler's segment
--------d-7800-------------------------------
INT 78 - TARGA.DEV - CMC International SCSI device driver - SET I/O PORT
	AH = 00h
	DX = interface board I/O port
Return: CF set on error
	    AL = error code (see #2388)
Note:	if this routine is not called, the port is the driver's default
	  (usually 0280h or 0300h)
	an installation check is performed by TARGA.DEV upon initialization
	  by checking for the string "SCSI" at offset 03h into the interrupt
	  handler
SeeAlso: AH=01h,AH=02h
Index:	installation check;TARGA.DEV

(Table 2388)
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
----------7800-------------------------------
INT 78 - HugeRealMode Driver - API
	AH = 00h
	AL = function
	    00h installation check
		Return: AX = DBCA if installed
	    01h get entry point
		Return: ES:BX -> far call entry point
Program: the HugeRealMode driver was published in the German DOS Extra Nr. 20
	  (1992), and makes a 4G flat address space (for both data and code)
	  available to real-mode DOS programs
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
	AL = error code (see #2388)
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
	AL = error code (see #2388)
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
	AL = error code (see #2388)
Note:	the SCSI bus is also reset
SeeAlso: AH=09h
--------d-7809-------------------------------
INT 78 - TARGA.DEV - RESET SCSI BUS
	AH = 09h
Return: AL = error code if carry set (see #2388)
SeeAlso: AH=08h
--------d-7810-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND
	AH = 10h
	DS:SI -> command bytes (see #2389)
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see #2388)
SeeAlso: AH=11h,INT 21/AX=4403h"ST-01"

Format of SCSI Command:
Offset	Size	Description	(Table 2389)
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7811-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND, RECEIVE DATA (PROGRAMMED I/O)
	AH = 11h
	DS:SI -> command bytes (see #2390)
	ES:BX -> data storage area
	CX = number of data bytes to transfer
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see #2388)
Note:	this command receives data internally one byte at a time
SeeAlso: AH=10h,AH=13h

Format of TARGA.DEV SCSI Command:
Offset	Size	Description	(Table 2390)
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7812-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND AND DATA (PROGRAMMED I/O)
	AH = 12h
	DS:SI -> command bytes (see #2391)
	ES:BX -> data storage area
	CX = number of data bytes to transfer
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see #2388)
Note:	this command sends data internally one byte at a time
SeeAlso: AH=14h

Format of TARGA.DEV SCSI Command:
Offset	Size	Description	(Table 2391)
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7813-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND, RECEIVE DATA (DMA)
	AH = 13h
	DS:SI -> command bytes (see #2392)
	ES:BX -> data storage area
	DX:CX = number of data bytes to transfer
Return: AH = SCSI status byte (if early return mode is clear)
	CF clear if successful
	    AL = SCSI message byte (if early return mode is clear)
	CF set on error
	    AL = error code (see #2388)
Note:	this command receives data using DMA
SeeAlso: AH=11h,AH=12h

Format of TARGA.DEV SCSI Command:
Offset	Size	Description	(Table 2392)
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7814-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND AND DATA (DMA)
	AH = 14h
	DS:SI -> command bytes (see #2393)
	ES:BX -> data storage area
	DX:CX = number of data bytes to transfer
Return: AH = SCSI status byte (if early return mode is clear)
	CF clear if successful
	    AL = SCSI message byte (if early return mode is clear)
	CF set on error
	    AL = error code (see #2388)
Note:	this command sends data using DMA
SeeAlso: AH=12h,AH=13h

Format of TARGA.DEV SCSI Command:
Offset	Size	Description	(Table 2393)
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7815-------------------------------
INT 78 - TARGA.DEV - FINISH DATA TRANSFER (DMA)
	AH = 15h
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see #2388)
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
SeeAlso: INT 29,INT 2F/AX=1A00h/BX=4156h
--------E-79---------------------------------
INT 79 - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ1
Notes:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
	the newest versions of GO32 dynamically allocate the vectors used
	  for the relocated IRQs, much as DESQview does (see INT 50"DESQview")
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
Notes:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
	the newest versions of GO32 dynamically allocate the vectors used
	  for the relocated IRQs, much as DESQview does (see INT 50"DESQview")
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
	  (see #1619)
SeeAlso: INT 2F/AX=7A00h,INT 64"Novell",INT 7A/BX=0000h
--------N-7A----BX0000-----------------------
INT 7A - Novell NetWare - IPX Driver - OPEN SOCKET
	BX = 0000h
	AL = socket longevity
	    00h open until close or terminate
	    FFh open until close
	DX = socket number (high byte in DL)
	    0000h dynamic allocation
	    else  socket to open (see #2394)
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

(Table 2394)
Values for IPX socket number:
 0451h	File Service (NetWare Core Protocol)
 0452h	Service Advertising Protocol (see #2402)
 0453h	Routing Information Packet (see #2405)
 0455h	NetBIOS Packet
 0456h	diagnostics
 0457h	server serial numbers (labeled "Copy Protection" by Lanalyzer)
 4000h-7FFFh used for dynamic allocation
 4444h	Brightwork Development's SiteLock server
 5555h	Brightwork Development's SiteLock client (workstation)
 8000h-FFFFh assigned by Novell
 869Ch	ID Software's DOOM
Note:	SiteLock is an application metering product using IPX to communicate
	  between the application and the license server
--------N-7A----BX0001-----------------------
INT 7A - Novell NetWare - IPX Driver - CLOSE SOCKET
	BX = 0001h
	DX = socket number (high byte in DL) (see #2394)
Notes:	also cancels events set by any Event Control Blocks for the socket
	the program must close all open sockets before terminating
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0000h
--------N-7A----BX0002-----------------------
INT 7A - Novell NetWare - IPX Driver - GET LOCAL TARGET
	BX = 0002h
	ES:SI -> target internetwork address (see #2409 at INT 7A/BX=000Bh)
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
	ES:SI -> Event Control Block (see #2395,#2396)
Notes:	returns immediately; IPX attempts to send the packet in the background
	this function is supported by Advanced NetWare 1.02+
	this function is nearly identical to BX=000Fh, except that it always
	  copies the source address into the IPX header assumed to be at the
	  beginning of the first fragment
SeeAlso: BX=0004h,BX=000Fh,INT 21/AH=EEh"Novell"

Format of IPX Event Control Block:
Offset	Size	Description	(Table 2395)
 00h	DWORD	Link
 04h	DWORD	-> Event Service Routine (00000000h if none) (see #2399)
 08h	BYTE	in use flag (see #2397)
 09h	BYTE	completion code (see #2398)
 0Ah	WORD	(big-endian) socket number (see #2394)
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
	the first fragment should start with an IPX header (see #2400)
	all fragments are concatenated and sent in one piece
	node address FFh FFh FFh FFh FFh FFh broadcasts to all nodes
SeeAlso: #2396

Format of AES-ECB:
Offset	Size	Description	(Table 2396)
 00h	DWORD	Link
 04h	DWORD	ESR (Event Service Routine) address (see #2399)
 08h	BYTE	in use flag (see #2397)
 09h  5 BYTEs	AES workspace
SeeAlso: #2395

(Table 2397)
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
SeeAlso: #2395,#2396,#2398

(Table 2398)
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
SeeAlso: #2395,#2397

(Table 2399)
Values Event Service Routine is called with:
	AL = caller's identity (00h = AES, FFh = IPX)
	ES:SI -> event control block
	interrupts disabled
Return: all registers preserved
SeeAlso: #2395,#2400

Format of IPX header:
Offset	Size	Description	(Table 2400)
 00h	WORD	(big-endian) checksum
 02h	WORD	(big-endian) length in bytes of total packet
 04h	BYTE	transport control
 05h	BYTE	packet type (see #2401)
 06h 10 BYTEs	destination internetwork address
 10h	WORD	(big-endian) destination socket
 12h 10 BYTEs	source internetwork address
 1Ch	WORD	(big-endian) source socket
SeeAlso: #2395,#2411

(Table 2401)
Values for IPX packet type:
 00h	unknown packet type
 01h	routing information packet
 02h	echo packet
 03h	error packet
 04h	packet exchange packet (always use this one)
 05h	SPX packet (see #2411)
 11h	NetWare Core Protocol
 14h	Propagated Packet (for NetWare), NetBIOS name packet
 15h-1Eh experimental protocols
Note:	undocumented packet type 14h will cross up to 16 networks deep in
	  all directions; as Aaron Martin of Origin Systems discovered, the
	  first 64 bytes of the IPX data in such packets should be considered
	  reserved, as IPX places the traversed server nodes there.

Format of Service Advertising Protocol Service Query Packet:
Offset	Size	Description	(Table 2402)
 00h 30 BYTEs	IPX header
 1Eh	WORD	(big-endian) query type
		0001h general find service
		0003h find nearest server
 20h	WORD	(big-endian) server type (see INT 21/AH=E3h"NetWare")
SeeAlso: #2403

Format of Service Advertising Protocol Server Identification Packet:
Offset	Size	Description	(Table 2403)
 00h 30 BYTEs	IPX header
 1Eh	WORD	(big-endian) response type
		0002h general service
		0004h nearest service
 20h 64N BYTEs	server entries (1-7) (see #2404)
SeeAlso: #2402,#2405

Format of SAP server entry:
Offset	Size	Description	(Table 2404)
 00h	WORD	(big-endian) server type (see INT 21/AH=E3h"NetWare")
 02h 48 BYTEs	ASCIZ server name
 32h  2 WORDs	(big-endian) network number
 34h  3 WORDs	(big-endian) node number
 3Ch	WORD	(big-endian) socket number
 3Eh	WORD	(big-endian) number of hops between caller and server

Format of IPX Routing Information packet:
Offset	Size	Description	(Table 2405)
 00h 30 BYTEs	IPX header
 1Eh	WORD	operation (0001h request, 0002h response)
 20h 8N BYTEs	network entries (1-50) (see #2406)
SeeAlso: #2403

Format of RIP network entry:
Offset	Size	Description	(Table 2406)
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
Return: AL = return code (see #2407)
Notes:	cannot cancel packets which the node's driver has already sent
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0005h

(Table 2407)
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
Return: AX = interval marker in clock ticks (big-endian???)
Notes:	may be used to measure the time elapsed between two events, up to one
	  hour
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0005h
--------N-7A----BX0009-----------------------
INT 7A - Novell NetWare - IPX Driver - GET INTERNETWORK ADDRESS
	BX = 0009h
	ES:SI -> buffer for own internetwork address (see #2408)
Return: ES:SI buffer filled
	SI destroyed
Note:	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0002h,BX=000Bh

Format of IPX internetwork address:
Offset	Size	Description	(Table 2408)
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
	ES:SI -> internetwork address (see #2409)
Return: nothing
Notes:	this function permits the network software on the remote machine to
	  remove any virtual connection with the calling machine
	only use in point-to-point networks
	should never be called from within an Event Service Routine
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0002h,BX=0009h

Format of IPX internetwork address:
Offset	Size	Description	(Table 2409)
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
SeeAlso: INT 7A/BX=0024h
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
Notes:	this function terminates all sockets opened with the current mode; this
	  may be intended for future enhancements as the socket mode never
	  changes in v2.15
	called by the NetWare shell if a program terminates
--------N-7A----BX000F-----------------------
INT 7A - Novell NetWare - IPX Driver - INTERNAL - SEND PACKET
	BX = 000Fh
	ES:SI -> Event Control Block (see BX=0003h)
Note:	nearly identical to function 0003h, but does not copy address into
	  the first fragment, and bypasses normal error checking
SeeAlso: BX=0003h
--------N-7A----BX0010-----------------------
INT 7A - Novell NetWare - SPX Driver - INSTALLATION CHECK
	BX = 0010h
	AL = 00h
Return: AL = status
	    00h if SPX not installed
	    F0h if IPX not installed
	    FFh if SPX loaded
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
	  (see #1619)
SeeAlso: BX=0015h
--------N-7A----BX0011-----------------------
INT 7A - Novell NetWare - SPX Driver - ESTABLISH SPX CONNECTION
	BX = 0011h
	AL = retry count
	AH = watchdog flag
	ES:SI -> Event Control Block (see #2395 at BX=0003h)
Return: AL = status (00h,EFh,FDh,FFh) (see #2410)
	DX = assigned connection ID number
Desc:	attempt to establish a connection with a listening socket
Notes:	there should always be at least two SPX ECB's listening to a socket, so
	  that NetWare can perform its internal packet exchanges
	the first fragment should start with a SPX header (see #2411).	Fill
	  in all destination addresses.
	this function is supported by Advanced NetWare 2.1+
SeeAlso: BX=0000h,BX=0012h,BX=0013h,BX=0014h,BX=0015h

(Table 2410)
Values for SPX function status:
 00h	attempting to contact destination socket
 EEh	no such connection
 EFh	local connection table full
 FDh	buffer size not 42 or fragment count not 1
 FFh	sending socket not open

Format of SPX header:
Offset	Size	Description	(Table 2411)
 00h	WORD	(big-endian) checksum
 02h	WORD	(big-endian) length in bytes of total packet
 04h	BYTE	transport control
 05h	BYTE	packet type (see #2401 at INT 7A/BX=0003h)
 06h 10 BYTEs	destination internet address
 10h	WORD	(big-endian) destination socket
 12h 10 BYTEs	source internet address
 1Ch	WORD	(big-endian) source socket
 1Eh	BYTE	connection control (see #2412)
 1Fh	BYTE	datastream type
		FEh terminate connection request packet
		FFh terminate connection acknowledgement packet
		other user-defined, ignored by SPX
 20h	WORD	(big-endian) source connection ID
 22h	WORD	(big-endian) destination connection ID
 24h	WORD	(big-endian) sequence number
 26h	WORD	(big-endian) acknowledge number
 28h	WORD	(big-endian) allocation number
SeeAlso: #2400

Bitfields for SPX connection control:
Bit(s)	Description	(Table 2412)
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
	ES:SI -> Event Control Block (see #2395 at BX=0003h)
Return: nothing
Notes:	there should always be at least two SPX ECB's listening to a socket, so
	  that NetWare can perform its internal packet exchanges
	this function is supported by Advanced NetWare 2.1+
SeeAlso: BX=0011h,BX=0013h,BX=0014h
--------N-7A----BX0013-----------------------
INT 7A - Novell NetWare - SPX Driver - TERMINATE SPX CONNECTION
	BX = 0013h
	DX = connection ID to terminate
	ES:SI -> Event Control Block (see #2395 at BX=0003h)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: BX=0011h,BX=0012h,BX=0014h
--------N-7A----BX0014-----------------------
INT 7A - Novell NetWare - SPX Driver - ABORT SPX CONNECTION
	BX = 0014h
	DX = connection ID to terminate
Return: nothing
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
	ES:SI -> status buffer (see #2413)
Return: AL = return code (00h,EEh) (see also #2410)
	    00h connection still valid
		ES:SI -> status buffer filled
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: BX=0010h,BX=0011h

Format of SPX status buffer:
Offset	Size	Description	(Table 2413)
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
 18h 10 BYTEs	destination internetwork address (see #2409 at INT 7A/BX=000Bh)
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
	ES:SI -> diagnostic element (see #2414) to be added to Diagnostic Queue
Note:	this function is supported on file servers only under v2.15; v3.02 also
	  supports it on workstations
SeeAlso: BX=0019h

Format of IPX diagnostic element:
Offset	Size	Description	(Table 2414)
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
Return: AX = maximum packet size with preamble (at least 576 bytes)
	CX = IPX retry count
	DS,FLAGS preserved
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
	used by NetWare Access Server, which may call INT 15/AX=1117h with
	  BX=0000h in some cases (it uses a modified DESQview)
--------N-7A----BX001C-----------------------
INT 7A U - Novell NetWare - NetWare Access Server - GET ???
	BX = 001Ch
Return: AX = length of ???
	ES:BX -> ???
Notes:	these functions are NOPs for standard IPX drivers such as IPXODI v2.12
SeeAlso: INT 2F/AX=7AF1h,INT 7A/BX=001Dh,INT 7A/BX=001Eh
--------N-7A----BX001D-----------------------
INT 7A U - Novell NetWare - NetWare Access Server - GET ??? ECB AND SOCKET
	BX = 001Dh
Return: DX = socket number chosen by IPX
	ES:SI -> ECB in IPX's code segment (will be listening)
	BX corrupted
Notes:	these functions are NOPs for standard IPX drivers such as IPXODI v2.12
SeeAlso: INT 2F/AX=7AF1h,INT 7A/BX=001Ch,INT 7A/BX=001Eh
--------N-7A----BX001E-----------------------
INT 7A U - Novell NetWare - NetWare Access Server - GET ??? ECB
	BX = 001Eh
Return: ES:SI -> ECB
	BX corrupted
Notes:	these functions are NOPs for standard IPX drivers such as IPXODI v2.12
SeeAlso: INT 2F/AX=7AF1h,INT 7A/BX=001Ch,INT 7A/BX=001Dh
--------N-7A----BX001F-----------------------
INT 7A - Novell NetWare - IPXODI v2.12+ - GET IPX FLAGS
	BX = 001Fh
	DX = 0000h
Return: AX = ???
	BX:CX -> ??? entry point (see #2415)
	DX = feature flags
	    bit 0: IPXODI rather than dedicated IPX
	    bit 1: checksumming functions 0020h-0022h supported
	ES:SI -> array of words containing used socket number (undocumented);
		0000h ends array
	all other registers except DS and FLAGS may be destroyed
Note:	IPXODI v2.12 is distributed as part of the Personal NetWare system
	  bundled with Novell DOS 7
SeeAlso: BX=0020h,INT 2F/AX=7A2Fh

(Table 2415)
Call IPXODI entry point with:
	ES:SI -> ECB??? (offset 24h is far pointer to ??? data)
--------N-7A----BX0020-----------------------
INT 7A - Novell NetWare - IPXODI v2.12+ - SEND WITH CHECKSUM
	BX = 0020h
	ES:SI -> ECB (see #2395 at INT 7A/BX=0003h)
Return: DS,FLAGS preserved
	BX,BP corrupted (documented as potentially destroying all other regs)
Desc:	generate a checksum for the packet data and store it in the IPX
	  checksum field before transmitting the packet
SeeAlso: BX=001Fh,BX=0021h,BX=0022h,INT 2F/AX=7A2Fh
--------N-7A----BX0021-----------------------
INT 7A - Novell NetWare - IPXODI v2.12+ - IPX GENERATE CHECKSUM
	BX = 0021h
	ES:SI -> ECB data (see #2395 at INT 7A/BX=0003h)
Return: ES,DS,SI preserved
	BX,BP corrupted, all other registers potentially destroyed
Notes:	the checksum and TransportControl fields of the IPX packet are updated
	this function enables interrupts and is fully reentrant
SeeAlso: BX=001Fh,BX=0020h,BX=0022h,INT 2F/AX=7A2Fh
--------N-7A----BX0022-----------------------
INT 7A - Novell NetWare - IPXODI v2.12+ - IPX VERIFY CHECKSUM
	BX = 0022h
	ES:SI -> ECB data (see #2395 at INT 7A/BX=0003h)
Return: AX = status (0000h checksum matches)
	DS,ES,SI preserved
	BX,BP corrupted, all other registers potentially destroyed
Note:	this function enables interrupts and is fully reentrant
SeeAlso: BX=001Fh,BX=0020h,BX=0021h,INT 2F/AX=7A2Fh
--------N-7A----BX0023-----------------------
INT 7A - Novell NetWare - IPXODI v2.12+ - OPEN LOOK-AHEAD SOCKET
	BX = 0023h
	DX = socket number (0000h for dynamic allocation)
	ES:SI -> Look Ahead handler (see #2416)
	BP = desired lookahead size (0000h-0080h)
Return: AL = status
	    00h successful
		DX = assigned socket number (big-endian)
	    FEh maximum number of sockets already open
	    FFh specific socket already opened by another application
	DS,FLAGS preserved
	all other registers may be destroyed
Notes:	the socket will always be long-lived, and must thus be explicitly
	  closed with INT 7A/BX=0001h before the Look Ahead handler code is
	  removed from memory (i.e. the program terminates)
	this function is only supported if INT 2F/AX=7A00h returns ES:BX
	  pointing at an IPX version greater than 3.30
	the desired lookahead size is the smallest-size packet (including IPX
	  header) that should be passed to the lookahead handler when it
	  arrives
SeeAlso: INT 7A/BX=0000h,INT 7A/BX=0001h

(Table 2416)
Call IPX Look-Ahead handler with:
	AX = packet's destination socket
	DS:SI -> look-ahead structure (see #1694 at INT 2F/AX=C000h"LSL")
	DF clear
	interrupt disabled (must remain disabled)
Return: AX = packet use
	    0000h application want packet
		ES:SI -> ODI ECB (see #1695 at INT 2F/AX=C000h"LSL")
	    8001h application does not want packet
	ZF set if AX=0000h
	DS,DI,BP,SS,SP preserved
	interrupts disabled
--------N-7A----BX0024-----------------------
INT 7A U - Novell NetWare - IPXODI v2.20+ - SET INTERNETWORK ADDRESS
	BX = 0024h
	ES:SI -> buffer containing internetwork address (see #2409)
Return: BX,CX,SI,DI,ES destroyed
Note:	this function differs from INT 7A/BX=000Ch in that it unconditionally
	  sets the address
SeeAlso: INT 7A/BX=000Ch
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
	DX:CX -> packet-mode entry point (see #2417)
SeeAlso: AX=0001h,AX=0200h,AX=07D0h,INT 61/AX=0007h"OPTIMA",INT 78"AutoCAD"
SeeAlso: INT 79/AX=0001h,INT 7B/AX=8001h"AutoCAD",INT 7C"AutoShade"

(Table 2417)
Call packet-mode entry point with:
STACK:	DWORD	pointer to request packet (see #2418)
	WORD	length of packet

Format of request packet:
Offset	Size	Description	(Table 2418)
 00h	WORD	function number (00h-45h for Compaq VGADI41.EXE)
--------A-7A0200BX0000-----------------------
INT 7A R - AutoCAD Device Interface - RENDERING DEVICE - INITIALIZE (RDLINKUP)
	AX = 0200h
	BX = 0000h
	CX = interface level (0001h)
Return: BX = 0000h (driver uses packet communication)
	DX:CX -> packet-mode entry point (see #2417)
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
	AL = service (see #2419)
	ES:DI -> control block
Return: ???

(Table 2419)
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
	AL = service number (see #2420)
	ES:DI -> control block
Return: ???

(Table 2420)
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
	AL = service number (see #2421)
	ES:DI -> control block
Return: ???

(Table 2421)
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
	AL = service (see #2422)
	ES:DI -> control block

(Table 2422)
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
	ES:DI -> 8-char blank-padded gate name (see #2423)
Return: DX = gate ID

(Table 2423)
Values for 3270 Workstation Program gate name:
 "SESSMGR "
 "KEYBOARD"
 "WSCTRL  "
 "MFIC	  "
 "PCPSM	  "
 "3270EML "
 "COPY	  "
 "XLATE	  "
 "OIAM	  "
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
Return: DX:AX -> PCS/3270 signature block if loaded (see #2424)

Format of Personal Communications/3270 signature block:
Offset	Size	Description	(Table 2424)
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
	DS:DX -> 38-byte parameter record (see #2425)
Return: return code field set
Note:	Btrieve sets low byte of vector to 33h; this serves as the installation
	  check
SeeAlso: INT 2F/AX=AB01h,INT 7F/AX=0200h

Format of Btrieve parameter record:
Offset	Size	Description	(Table 2425)
 00h	DWORD	pointer to data buffer
 04h	WORD	data buffer length
 06h	DWORD	pointer to 90-byte record containing positioning info
		(should be same for all calls for same file)
 0Ah	DWORD	pointer to 38-byte FCB info buffer
		(should be same for all calls for same file)
 0Eh	WORD	function code (see #2426)
 10h	DWORD	pointer to file name/key buffer
 14h	BYTE	key length
 15h	BYTE	key number
 16h	DWORD	pointer to status code (see #2427)
 1Ah	WORD	interface code (version specific)
		6176h version 5.10

(Table 2426)
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

(Table 2427)
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
Notes:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
	the newest versions of GO32 dynamically allocate the vectors used
	  for the relocated IRQs, much as DESQview does (see INT 50"DESQview")
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
	DS:DX -> parameter block (see #2429)
Return: parameter block updated

(Table 2428)
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
SeeAlso: #2429

Format of XQL parameter block:
Offset	Size	Description	(Table 2429)
 00h  4 BYTEs	signature "XQLP"
 04h	WORD	function number (see #2428)
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
Notes:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
	the newest versions of GO32 dynamically allocate the vectors used
	  for the relocated IRQs, much as DESQview does (see INT 50"DESQview")
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
	       AL = new color attribute (see #0013 at INT 10/AH=08h)
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
	DX = OEM signature (see #2430)
	CL = DLI 2.8+ topology: 1=Ethernet, 2=FDDI, 3=Token-Ring
SeeAlso: AX=0002h,AX=000Bh,AX=000Dh,AX=000Eh

(Table 2430)
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
Return: AX = completion code (see #2431)
Note:	the DLI will refuse to unload if there are any protocols
	  (see AX=0007h) or clients (see AX=0010h) active.
Index:	uninstall;SK-UPPS Data Link Interface

(Table 2431)
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
	ES:DI -> Status Information Block (SIB) (see #2443)
Return: AX = completion code (see #2431)
Note:	GET DRIVER INFO (AX=000Eh) should be used instead.
SeeAlso: AX=0000h,AX=000Bh,AX=000Dh,AX=000Eh
--------N-7C0003-----------------------------
INT 7C - SK-UPPS Data Link Interface API - CHANGE DRIVER ADDRESS
	AX = 0003h
	ES:DI -> new node address (6 bytes)
Return: AX = completion code (see #2431)
Note:	the DLI will refuse to change the address if any protocols
	  (see AX=0007h) are active
SeeAlso: AX=0001h,AX=000Eh
--------N-7C0004-----------------------------
INT 7C - SK-UPPS Data Link Interface API - REQUEST BUFFER
	AX = 0004h
	DX = protocol ID (see AX=0007h,#2434)
Return: AX = completion code (see also #2431)
	    0000h successful
		ES:BX -> Memory Buffer (Mbuf) (see #2432)
Note:	if the DLI has no free Mbufs, it will set an internal flag for the
	  protocol and later call the protocol's Event Upcall with
	  EV_BUFFER_AVAILABLE (see #2438,#2439) as soon as an Mbuf becomes
	  available.  There will only be one "buffer available" Upcall, even
	  if this function has been called several times before.
SeeAlso: AX=0005h,AX=0006h,AX=0012h,AX=0013h

Format of SK-UPPS Memory Buffer (Mbuf):
Offset	Size	Description	(Table 2432)
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
	ES:BX -> Mbuf (see #2432)
Return: nothing
SeeAlso: AX=0004h
--------N-7C0006-----------------------------
INT 7C - SK-UPPS Data Link Interface API - TRANSMIT FRAME
	AX = 0006h
	ES:BX -> Mbuf (see #2432)
Return: nothing
Notes:	The DLI will send LENGTH bytes found in the Mbuf's DATA area starting
	  at OFFSET. A complete and valid frame must be stored there. The DLI
	  will only copy the current node address (see AX=0003h) to the
	  source node field of the frame's MAC header.
	On Ethernet, the DLI will always send a minimum of 60 bytes, regardless
	  of the value found in the LENGTH field.
	This function returns immediately; the DLI will call the protocol's
	  Transmit Upcall (see #2433) when the frame has been sent.
	The Mbuf's IN USE field will be non-zero until the DLI calls the
	  Transmit Upcall.
SeeAlso: AX=0002h,AX=0004h,AX=0013h

(Table 2433)
Values SK-UPPS Transmit Upcall is called with:
	ES:BX -> Mbuf (NEXT field destroyed)
	interrupts disabled
Note:	On FDDI the bytes of the source and destination node fields in the MAC
	  header have been bit-swapped to physical address format.
--------N-7C0007-----------------------------
INT 7C - SK-UPPS Data Link Interface API - REGISTER PROTOCOL
	AX = 0007h
	ES:BX -> Protocol Control Block (see #2434)
Return: AX = completion code (see #2431)
Program: SK-UPPS is the Schneider & Koch Universal Portable Protocol Stack,
	  which provides an API on top of its Data Link Interface, allowing the
	  use of any of several network transport layers
SeeAlso: AX=0008h,AX=000Bh

Format of SK-UPPS Protocol Control Block (PCB):
Offset	Size	Description	(Table 2434)
 00h	WORD	(big-endian) protocol type
 02h	WORD	protocol mode (see #2435)
 04h	DWORD	-> Receive Upcall routine (see #2436)
 08h	DWORD	-> Transmit Upcall routine
 0Ch	DWORD	-> Event Upcall routine (see #2438)
 10h	DWORD	-> ASCIZ protocol name (zero if none)
 14h	WORD	protocol ID will be returned here (always non-zero)

Bitfields for SK-UPPS protocol mode:
Bit(s)	Description	(Table 2435)
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

(Table 2436)
Values SK-UPPS Receive Upcall is called with:
 ES:BX -> Mbuf
 AX = receive status (see #2437) (also stored in Mbuf's RECEIVE STATUS field)
 interrupts disabled

Bitfields for SK-UPPS receive status:
Bit(s)	Description	(Table 2437)
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

(Table 2438)
Values SK-UPPS Event Upcall is called with:
 AX = event code (see #2439)
Note:	All Event Upcalls may be ignored by the protocol.

(Table 2439)
Values for SK-UPPS Event Upcall event code:
 00h	EV_BUFFER_AVAILABLE client may now call REQUEST BUFFER (AX=0004h)
 01h	EV_ISR_START	    start of Interrupt Service Routine
 02h	EV_ISR_END	    end of ISR (see bit 1 in PCB's protocol mode field)
 03h	EV_BUFFER_WANTED    DLI temporarily out of Mbufs
 04h	EV_NETWORK_STATUS   DLI 2.8+ network status -- DX=status (see #2440)
 05h	EV_IO_CONTROL	    DLI 2.8+ I/O control -- DX=subfunc (see AX=0016h)

Bitfields for EV_NETWORK_STATUS in register DX:
Bit(s)	Description	(Table 2440)
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
	BX = protocol ID (see #2434)
Return: AX = completion code (see #2431)
Note:	the DLI will handle any Mbufs given to TRANSMIT FRAME (AX=0006h) as if
	  they had been given to TRANSMIT FRAME RELEASE (AX=0013h).
	all multicast addresses registered for this protocol will be disabled.
	after this function returns, the protocol's Upcall routines will no
	  longer be called.
SeeAlso: AX=0007h,AX=000Bh
--------N-7C0009-----------------------------
INT 7C - SK-UPPS Data Link Interface API - REGISTER MULTICAST
	AX = 0009h
	BX = protocol ID (see #2434)
	ES:DI -> multicast address (6 bytes)
Return: AX = completion code (see #2431)
Notes:	The broadcast address is always enabled.
	Set bit 9 of PCB's protocol mode field in REGISTER PROTOCOL call
	  (AX=0007h) to receive all multicast frames.
SeeAlso: AX=000Ah,AX=0014h
--------N-7C000A-----------------------------
INT 7C - SK-UPPS Data Link Interface API - DISABLE MULTICAST
	AX = 000Ah
	BX = protocol ID (see #2434)
	ES:DI -> multicast address (6 bytes)
Return: AX = completion code (see #2431)
SeeAlso: AX=0009h,AX=0014h
--------N-7C000B-----------------------------
INT 7C - SK-UPPS Data Link Interface API - GET PROTOCOL LIST
	AX = 000Bh
	ES:DI -> protocol ID buffer
	CX = number of 2-byte protocol IDs that may be stored in buffer
Return: AX = completion code (see #2431)
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
	BX = protocol ID (see #2434,AX=000Bh)
	ES:DI -> Protocol Status Block (see #2441)
Return: AX = completion code (see #2431)
SeeAlso: AX=000Bh,AX=0014h

Format of SK-UPPS Protocol Status Block (PSB):
Offset	Size	Description	(Table 2441)
 00h	DWORD	-> ASCIZ protocol name
 04h	WORD	protocol mode (see #2435)
 06h	WORD	protocol type (see AX=0007h)
 08h	WORD	number of registered multicasts (see AX=0009h,AX=0014h)
--------N-7C000D-----------------------------
INT 7C - SK-UPPS Data Link Interface API - GET DRIVER STATISTICS
	AX = 000Dh
	BX = flag: 0=don't clear statistics, 1=clear statistics
	ES:DI -> Statistics Data Block (see #2442)
Return: AX = completion code (see #2431)
SeeAlso: AX=0002h,AX=0015h

Format of SK-UPPS Statistics Data Block (SDB):
Offset	Size	Description	(Table 2442)
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
	ES:DI -> Driver Information Block (see #2443)
	BX = offset of 1st field within DIB to be returned
	CX = number of bytes to be returned
Return: AX = completion code (see #2431)
	CX = number of bytes copied (regardless of value returned in AX)
Program: SK-UPPS is the Schneider & Koch Universal Portable Protocol Stack,
	  which provides an API on top of its Data Link Interface, allowing the
	  use of any of several network transport layers
SeeAlso: AX=0000h,AX=0002h,AX=000Bh,AX=000Dh,AX=0015h

Format of SK-UPPS Driver Information Block (DIB):
Offset	Size	Description	(Table 2443)
 00h  6 BYTEs	physical node address (from adapter's ROM)
 06h  6 BYTEs	current node address (see AX=0003h)
 0Ch	BYTE	adapter id (defined by OEM)
 0Dh	BYTE	IRQ line (FFh if none)
 0Eh	DWORD	-> shared memory (zero if none)
 12h	DWORD	size of shared memory (zero if none)
 16h	WORD	base I/O port (zero if none)
 18h	BYTE	DMA line (FFh if none)
 19h	BYTE	DLI 2.4+ topology (see AX=0000h)
 1Ah	WORD	size of an Mbuf's DATA area (see #2432)
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
	ES:BX -> Mbuf (see #2432)
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
	DX = protocol ID (see #2434)
Return: AX = completion code (see #2431)
	if AX=0000h: ES:BX -> Mbuf (see #2432)
Note:	If the protocol wants to be informed when an Mbuf becomes available,
	  REQUEST BUFFER (AX=0004h) should be used instead.
SeeAlso: AX=0004h,AX=0005h,AX=0006h,AX=0013h
--------N-7C0013-----------------------------
INT 7C - SK-UPPS Data Link Interface API - TRANSMIT FRAME RELEASE
	AX = 0013h
	ES:BX -> Mbuf (see #2432)
Return: nothing
Notes:	Returns immediately; The protocol's Transmit Upcall will NOT be called.
	The Mbuf may no more be used by the protocol in any way (i.e. the
	  Mbuf's IN USE field may not be polled).
SeeAlso: AX=0004h,AX=0013h
--------N-7C0014-----------------------------
INT 7C - SK-UPPS Data Link Interface API - GET MULTICAST LIST
	AX = 0014h
	BX = protocol ID (see #2434,AX=000Bh)
	ES:DI -> multicast address buffer
	CX = number of 6-byte multicast addresses that may be stored in buffer
Return: AX = completion code (see #2431)
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
	ES:DI -> media-specific statistics buffer (see #2444,#2445,#2446)
	BX = offset of 1st field within MSS to be returned
	CX = number of bytes to be returned
Return: AX = completion code (see #2431)
	CX = number of bytes copied (regardless of value returned in AX)
Note:	not supported by all DLIs (will return AX=FFFFh if not supported).
SeeAlso: AX=0000h,AX=000Dh

Format of SK-UPPS media-specific statistics for Ethernet:
Offset	Size	Description	(Table 2444)
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
Offset	Size	Description	(Table 2445)
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
Offset	Size	Description	(Table 2446)
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
Return: AX = completion code (see #2431)
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
Notes:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
	the newest versions of GO32 dynamically allocate the vectors used
	  for the relocated IRQs, much as DESQview does (see INT 50"DESQview")
SeeAlso: INT 0D,INT 7C"GO32",INT 7E"GO32"
--------U-7D---------------------------------
INT 7D - HyperPAD v2.2 - API ACCESS
Note:	this vector is hooked but immediately passed on (without checking
	  whether the previous handler was 0000h:0000h).  The sole purpose of
	  this vector is to provide the address of the data area described
	  below (see #2447).

Format of HyperPAD data area:
Offset	Size	Description	(Table 2447)
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
	ES:BX -> parameter block (see #2448)
Return: CF clear if successful
	CF set on error
	    AL = initiator error
	    AH = target error
Desc:	send the specified command block to the target device and perform any
	  related I/O

Format of SCSILink parameter block:
Offset	Size	Description	(Table 2448)
 00h	DWORD	size of command block
 04h	DWORD	address of command block (see #2449)
 08h	DWORD	size of buffer
 0Ch	DWORD	address of buffer

Format of SCSILink command block:
Offset	Size	Description	(Table 2449)
 00h		info not yet available
----------7D03-------------------------------
INT 7D - SCSILink - SET TIMEOUT
	AH = 03h
	AL = timeout selector (see #2450)
	BX = new value in 55ms ticks
Desc:	change an internal timeout value to allow communication with very
	  slow targets

(Table 2450)
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
Notes:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
	the newest versions of GO32 dynamically allocate the vectors used
	  for the relocated IRQs, much as DESQview does (see INT 50"DESQview")
SeeAlso: INT 0E,INT 7D"GO32",INT 7F"GO32"
--------s-7E00FE-----------------------------
INT 7E - SBOS - UNINSTALL
	AX = 00FEh
Return: nothing, SBOS removed
Program: SBOS is a SoundBlaster emulator for the Gravis UltraSound
Note:	this function may not be called if any SBOS vectors have been hooked
SeeAlso: INT 21/AX=FD12h
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
SeeAlso: AX=5857h/BL=57h,AX=5857h/BL=5Ah
--------V-7F---------------------------------
INT 7F - Halo88 - API
	BX = function number (see #2451)
	additional parameters on stack
Return: ???
Program: Halo88 is a suite of graphics routines
Note:	according to Stuart Kemp, the code appears to make no provisions for
	   chaining

(Table 2451)
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
	ES:SI-> parameter block (see #2452)
Return: CF set on error
	CF clear on success
Notes:	the signature "PDGATEWRKSTNIF" appears just prior to the interrupt
	  handler; this serves as the installation check
Index:	installation check;Telebit ACS Serial I/O

Format of Telebit ACS parameter block:
Offset	Size	Description	(Table 2452)
 00h	BYTE	command (see #2453)
 01h	BYTE	gateway number
 02h	BYTE	reserved
 03h	BYTE	port
 04h 17 BYTEs	auxiliary buffer
 15h	BYTE	session
 16h	WORD	count of bytes passed to API
 18h	DWORD	buffer pointer passed to/from API
 1Ch	WORD	count of bytes passed from API
 1Eh	BYTE	return code (see #2454)

(Table 2453)
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

(Table 2454)
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
	  NetWare broadcast messages be disabled with INT 21/AH=DEh/DL=00h.
SeeAlso: INT 21/AH=DEh/DL=04h
Index:	installation check;non-dedicated NetWare server
--------S-7F---------------------------------
INT 7F U - YTERM - ???
SeeAlso: INT 7E"YTERM"
--------E-7F---------------------------------
INT 7F - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ7
Notes:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the DOS extender
	the newest versions of GO32 dynamically allocate the vectors used
	  for the relocated IRQs, much as DESQview does (see INT 50"DESQview")
SeeAlso: INT 0F,INT 7E"GO32"
----------7F---------------------------------
INT 7F - Canon IXHND2 Scanner Interface
--------U-7F---------------------------------
INT 7F - SBS WinRun 1.00 - TRANSMITTER ENTRY POINT
	DS:SI -> WinRun control block (WCB) (see #2668)
Return: WinRun receiver status returned in WCB
Program: WinRun is a DOS/Windows utility written by Sven B. Schreiber to start
	  Windows applications from a virtual DOS machine under Windows
Note:	The WinRun transmitter (WINRUN-T.COM) and receiver (WINRUN-R.EXE) need
	  to be up and running

Format of the WinRun control block (WCB):
Offset	Size	Description	(Table 2668)
 00h	DWORD	pointer to ASCIZ command string
 04h	WORD	(ret) WinRun receiver status
		0000h-001Fh WinExec() error
		0020h-FFFEh WinExec() instance handle
		FFFFh	    Windows not running or WinRun receiver not
				  installed
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
Return: AL = status (see #2455)
	AH = semaphore owner if status=02h
SeeAlso: AH=01h,AH=02h,AH=41h,INT 67/AH=00h

(Table 2455)
Values for Alloy function status:
 00h	successful
 01h	invalid function
 02h	semaphore already locked
 03h	unable to lock/unlock semaphore
 04h	semaphore space exhausted
 05h	host/target PC did not respond (NTNX)
--------T-7F00-------------------------------
INT 7F - MultiLink Advanced v1.0+ - ENQUEUE SYSTEM RESOURCE
	AH = 00h
	BX = resource identifier
	AL = wait flag
Return: AL = status
	    00h successful
	    01h resource not available
	    02h user error
Notes:	the installation check consists of ensuring that the interrupt vector
	  is not pointing at segment 0000h, then checking whether the byte
	  at offset 0000h in the interrupt handler's segment is E9h
	function will not return until the resource is available if AL is
	  nonzero on entry
	a maximum of 100 resources may be enqueued at once
SeeAlso: AH=01h"MultiLink"
--------N-7F00-------------------------------
INT 7F - G8BPQ v4.07+ - GET NODE/SWITCH VERSION AND DESCRIPTION
	AH = 00h
	ES:SI -> buffer for "USERS" text string
Return: AX = 4250h ('BP') if installed
	BX = 5120h ('Q ') if installed
	DX = version number (DH = major, DL = minor)
	CX = length of returned string
Program: the G8BPQ AX25 Networking Package is amateur packet radio software by
	  John Wiseman which allows a PC to act as a node in an AX.25 network
SeeAlso: AH=01h"G8BPQ",AH=09h"G8BPQ"
--------N-7F01-------------------------------
INT 7F - Alloy NTNX, MW386 - SEMAPHORE LOCK
	AH = 01h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see #2455)
	AH = semaphore owner if status=02h
SeeAlso: AH=00h,AH=02h,AH=41h
--------T-7F01-------------------------------
INT 7F - MultiLink Advanced v1.0+ - DEQUEUE SYSTEM RESOURCE
	AH = 01h
	BX = resource identifier
Return: AL = status
	    00h successful
	    02h user error
Note:	the indicated resource may be dequeued even if it was enqueued by
	  another task
SeeAlso: AH=00h"MultiLink",AH=02h"MultiLink"
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
Range:	INT 00h to INT FFh, set in configuration file BPQCFG.TXT for v4.03+
	  (earlier versions were hard-wired for INT 7F)
SeeAlso: AH=00h"G8BPQ",AH=02h"G8BPQ",AH=0Bh"G8BPQ"
--------I-7F0104BX0000-----------------------
INT 7F - HLLAPI (IBM 3270 High-Level Language API)/LLAPI (Rabbit Low Level API)
	AX = 0104h (HLLAPI gate ID)
	BX = 0000h
	DS:SI -> parameter control block (see #2456)
Return: parameter control block updated
Note:	the installation check for the Novell HLLAPI TSR is the signature
	  string "CXI" (for the company Novell bought) immediately prior to
	  the interrupt handler
SeeAlso: AX=0105h,AX=ABCDh

Format of HLLAPI parameter control block:
Offset	Size	Description	(Table 2456)
 00h  3 BYTEs	signature = 'PCB'
 03h	BYTE	function number (see #2457,#2458)
 04h	WORD	segment of control string
 06h	WORD	offset of control string
 08h	WORD	length of control string, unless explicit end-of-str char set
 0Ah	BYTE	unused (IBM)
		ControlString[0] (Rabbit)
 0Bh	WORD	return code (see #2460)
 0Dh	WORD	maximum length of control string (IBM)
		unused (Rabbit)

(Table 2457)
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
 09h	Set session parameters; parameters vary by vendor (see #2459)
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

(Table 2458)
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

(Table 2459)
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

(Table 2460)
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
INT 7F - IBM 8514/A Adapter Interface (HDILOAD.EXE)
	AX = 0105h
Return: CF set on error
	CF clear if successful
	    CX:DX -> array of FAR pointers to entry points (see #2461)
Note:	most functions are invoked by pushing the DWORD parameter block pointer
	  and then performing a FAR call via the appropriate vector of the
	  entry point array, placing the FAR address of the function's
	  parameter block on the top of the stack
SeeAlso: AX=0104h,AX=0106h,AX=ABCDh

(Table 2461)
Values for HDILOAD function number: (do FAR call via entry_points+4*function)
 08h	HOPEN	Open Adapter (see #2493)
 09h	HSMX	Set Mix (see #2522)
 10h	HINT	Interrupt (see #2489)
 13h	HLDPAL	Load Palette (see #2490)
 15h	HBBW	BitBLT Write Image Data (see #2476)
 17h	HBBR	BitBLT Read Image Data (see #2477)
 18h	HBBCHN	Chained Data Go (see #2475)
 19h	HBBC	BitBLT Copy Data (see #2474)
 1Dh	HQMODE	Get Current Mode (see #2499)
 20h	HRECT	Fill Rectangle (see #2501)
 22h	HCLOSE	Close Adapter and place in quiescent state (see #2482)
 30h	HINIT	Initialize State (see #2488)
 31h	HSYNC	Synchronize Adapter (see #2527)
 39h	HSPAL	Save Palette (see #2524)
 3Ah	HRPAL	Restore Palette (see #2504)
 ???	HSGQ	Set Graphics Quality (see #2513)
 ???	HSCOORD	Set Coordinate Type (see #2510)
 ???	HESC	Escape, Terminate Processing (see #2487)
 ???	HSBCOL	Set Background Color (see #2505)
 ???	HSBP	Set Bit Plane Controls (see #2506)
 ???	HSCMP	Set Color Comparison Register (see #2508)
 ???	HSCOL	Set Color (see #2509)
 ???	HSHS	Set Scissors (clipping rectangle) (see #2514)
 ???	HXLATE	Assign Text Color (see #2528)
 ???	HQMODES	Get Adapter Modes (see #2500)
 ???	HQDPS	Get Drawing Process State Size (see #2498)
 ???	HQDFPAL	Get Default Palette (see #2497)
 ???	HQCOORD	Get Coordinate Type (see #2495)
 ???	HQCP	Get Current Position (see #2496)
 ???	HSMODE	Change Mode (see #2520)
 ???	HLINE	Draw Line at Given Position (see #2491)
 ???	HCLINE	Draw Line at Current Position (see #2481)
 ???	HRLINE	Draw Line Relative from Given Position (see #2502)
 ???	HCRLINE	Draw Line Relative at Current Position (see #2484)
 ???	HSLT	Set Line Type (see #2517)
 ???	HSLW	Set Line Width (see #2519)
 ???	HSLPC	Save Line Pattern Count (see #2516)
 ???	HRLPC	Restore Line Pattern Count (see #2503)
 ???	HCBBW	BitBLT Write Image Data at Current Position (see #2478)
 ???	HBAR	Begin Area (see #2473)
 ???	HEAR	End Area (see #2485)
 ???	HSPATT	Set Pattern (see #2525)
 ???	HSPATTO	Set Pattern Reference Point (see #2526)
 ???	HEGS	Erase Graphics Screen (see #2486)
 ???	HSCP	Set Current Position (see #2511)
 ???	HMRK	Set Marker (see #2492)
 ???	HCMRK	Set Marker at Current Position (see #2483)
 ???	HSMARK	Set Marker Shape (see #2521)
 ???	HSCS	Set Character Set (see #2512)
 ???	HCHST	Write Character String at Given Position (see #2480)
 ???	HCCHST	Write Character String at Current Position (see #2479)
 ???	HSCELL	Set Cell Size for Alphanumeric Text (see #2507)
 ???	ABLOCKMFI Write Character/Attribute Block MFI (see #2464)
 ???	ABLOCKCGA Write Character Block CGA (see #2462)
 ???	AERASE	Erase Rectangle (see #2467)
 ???	ASCROLL Scroll Rectangle (see #2468)
 ???	ACURSOR	Set Alphanumerics Cursor Position (see #2466)
 ???	ASCUR	Set Alphanumeric Cursor Shape (see #2469)
 ???	ASFONT	Set Font (see #2470)
 ???	AXLATE	Assign Alphanumeric Color (see #2472)

Format of ABLOCKCGA parameter block:
Offset	Size	Description	(Table 2462)
 00h	WORD	000Ah (length of following data)
 02h	WORD	top-left coordinate of character block
 04h	WORD	width of block
 06h	DWORD	-> block of WORDs describing characters (see #2463)
 0Ah	BYTE	length of block in characters
 0Bh	BYTE	highlight attribute
		bit 4: transparent background
		bit 5: overstrike
		bit 6: reverse video
		bit 7: underscore
SeeAlso: #2464

Bitfields for one character in ABLOCKCGA character block:
Bit(s)	Description	(Table 2463)
 3-0	foreground attribute
 7-4	background attribute
 15-8	character code

Format of ABLOCKMFI parameter block:
Offset	Size	Description	(Table 2464)
 00h	WORD	0009h (length of following data)
 02h	WORD	top-left coordinate of character block
 04h	WORD	width of block
 06h	DWORD	-> block of DWORDs describing characters (see #2465)
 0Ah	BYTE	length of block in characters
SeeAlso: #2462

Bitfields for one character in ABLOCKMFI character block:
Bit(s)	Description	(Table 2465)
 7-0	reserved
 9-8	low two bits of font number
 12	transparent background
 13	overstrike
 14	reverse video
 15	underscore
 19-16	foreground color attribute
 23-20	background color attribute
 31-24	character code

Format of ACURSOR parameter block:
Offset	Size	Description	(Table 2466)
 00h	WORD	0002h (length of following data)
 02h	BYTE	column (0-based)
 03h	BYTE	row (0-based)
SeeAlso: #2469

Format of AERASE parameter block:
Offset	Size	Description	(Table 2467)
 00h	WORD	0005h (length of following data)
 02h	BYTE	left-most column (0-based)
 03h	BYTE	top-most row (0-based)
 04h	BYTE	rectangle's width in character cells
 05h	BYTE	rectangle's height in character cells
 06h	BYTE	background color (bits 7-4)
SeeAlso: #2468

Format of ASCROLL parameter block:
Offset	Size	Description	(Table 2468)
 00h	WORD	0006h (length of following data)
 02h	BYTE	left-most column (0-based) of source
 03h	BYTE	top-most row (0-based) of source
 04h	BYTE	rectangle's width in character cells
 05h	BYTE	rectangle's height in character cells
 06h	BYTE	left-most column (0-based) of destination
 07h	BYTE	top-most row (0-based) of destination
SeeAlso: #2467

Format of ASCUR parameter block:
Offset	Size	Description	(Table 2469)
 00h	WORD	0003h (length of following data)
 02h	BYTE	cursor start line (00h = top of cell, FFh = keep current shape)
 03h	BYTE	cursor stop line
 04h	BYTE	cursor attribute
		00h normal
		01h hidden
		02h left-arrow (requires start = 2 and stop = bottom of cell)
		03h right-arrow (requires start = 2 and stop = bottom of cell)
Notes:	no cursor is shown if the start line is greater than the stop line
	the alphanumeric cursor is hidden after each mode change
SeeAlso: #2466,INT 10/AH=01h

Format of ASFONT parameter block:
Offset	Size	Description	(Table 2470)
 00h	WORD	0005h (length of following data)
 02h	BYTE	font number (0-3)
 03h	DWORD	-> character set definition block (see #2471)

Format of 8514/A character set definition block:
Offset	Size	Description	(Table 2471)
 00h	BYTE	reserved
 01h	BYTE	type of character set
		00h bitmapped, 01h&02h reserved, 03h short-stroke font
 02h	BYTE	reserved
 03h	DWORD	reserved
 07h	BYTE	cell width in pixels
 08h	BYTE	cell height in pixels
 09h	BYTE	reserved
 0Ah	WORD	cell size in bytes
 0Ch	WORD	flags
		bit 15: reserved (0)
		bit 14: color bitmap
		bit 13: proportional spacing
 0Eh	DWORD	-> index table
 12h	DWORD	-> character width table
 16h	BYTE	initial code point
 17h	BYTE	final code point
 18h	DWORD	-> character definition table
 1Ch	WORD	reserved
 1Eh	DWORD	-> second character definition table
 22h	WORD	reserved
 24h	DWORD	-> third character definition table

Format of AXLATE parameter block:
Offset	Size	Description	(Table 2472)
 00h	WORD	0080h (length of following data)
 02h 64 BYTEs	character foreground translation table
 42h 64 BYTEs	character background translation table

Format of HBAR parameter block:
Offset	Size	Description	(Table 2473)
 00h	WORD	0000h (no data following)
SeeAlso: #2485

Format of HBBC parameter block:
Offset	Size	Description	(Table 2474)
 00h	WORD	0010h (length of following data)
 02h	WORD	data format
		0000h across-the-plane copy (color expansion)
		0008h through-the-plane copy
 04h	WORD	data rectangle's width
 06h	WORD	data rectangle's height
 08h	BYTE	source bit plane number (across-the-plane copies only)
 09h	BYTE	reserved
 0Ah  2 WORDs	X,Y coordinates of source's upper-left corner in display memory
 0Eh  2 WORDs	X,Y coordinates of destination's upper-left corner in
		  display memory
Note:	copies data from one location in video memory to another
SeeAlso: #2475

Format of HBBCHN parameter block:
Offset	Size	Description	(Table 2475)
 00h	WORD	0006h (length of following data)
 02h	DWORD	-> data buffer in system memory
 06h	WORD	number of bytes to transfer
Note:	this function performs the actual data transfer for a bitBLT set up
	  with HBBR, HBBW, or HCBBW
SeeAlso: #2474,#2476,#2477,#2478

Format of HBBR parameter block:
Offset	Size	Description	(Table 2476)
 00h	WORD	000Ch or 0014h (length of following data)
 02h	WORD	data format
		0000h across-the-plane copy (color expansion)
		0008h through-the-plane copy
 04h	WORD	data rectangle's width
 06h	WORD	data rectangle's height
 08h	BYTE	source bit plane number
 09h	BYTE	reserved
 0Ah  2 WORDs	X,Y coordinates of destination's upper-left corner in
		  display memory
---optional---
 0Eh	WORD	sub-rectangle left margin in pixels
 10h	WORD	sub-rectangle top margin in pixels
 12h	WORD	sub-rectangle width
 14h	WORD	sub-rectangle height
SeeAlso: #2475,#2476,#2478

Format of HBBW parameter block:
Offset	Size	Description	(Table 2477)
 00h	WORD	000Ah or 0012h (length of following data)
 02h	WORD	data format
		0000h across-the-plane copy (color expansion)
		0008h through-the-plane copy
 04h	WORD	data rectangle's width
 06h	WORD	data rectangle's height
 08h  2 WORDs	X,Y coordinates of destination in display memory
---optional---
 0Ch	WORD	sub-rectangle left margin in pixels
 0Eh	WORD	sub-rectangle top margin in pixels
 10h	WORD	sub-rectangle width
 12h	WORD	sub-rectangle height
SeeAlso: #2475,#2477,#2478

Format of HCBBW parameter block:
Offset	Size	Description	(Table 2478)
 00h	WORD	0006h or 000Eh (length of following data)
 02h	WORD	data format
		0000h across-the-plane copy (color expansion)
		0008h through-the-plane copy
 04h	WORD	data rectangle's width
 06h	WORD	data rectangle's height
---optional---
 08h	WORD	sub-rectangle left margin in pixels
 0Ah	WORD	sub-rectangle top margin in pixels
 0Ch	WORD	sub-rectangle width
 0Eh	WORD	sub-rectangle height
SeeAlso: #2475,#2476,#2477

Format of HCCHST parameter block:
Offset	Size	Description	(Table 2479)
 00h	WORD	length of following data
 02h  N BYTEs	ASCII string to display (length given by 'length' field above)
SeeAlso: #2480

Format of HCHST parameter block:
Offset	Size	Description	(Table 2480)
 00h	WORD	length of following data
 02h  2 WORDs	X,Y of left-bottom corner of string on screen
 06h  N BYTEs	ASCII string to display (length given by 'length' field above)
SeeAlso: #2479

Format of HCLINE parameter block:
Offset	Size	Description	(Table 2481)
 00h	WORD	length of following data (multiple of 4)
 02h 2N WORDs	X,Y coordinates for each of N points in polyline
Notes:	the first line segment is drawn beginning at the current position
	on completion, the current position is set to the last point drawn
SeeAlso: #2491,#2502,#2484

Format of HCLOSE parameter block:
Offset	Size	Description	(Table 2482)
 00h	WORD	0001h (length of following data)
 01h	BYTE	(ret) return code
SeeAlso: #2493

Format of HCMRK parameter block:
Offset	Size	Description	(Table 2483)
 00h	WORD	length of following data
 02h 2N WORDs	X,Y of N points
Note:	draws N+1 marker symbols, the first one at the current position
SeeAlso: #2492

Format of HCRLINE parameter block:
Offset	Size	Description	(Table 2484)
 00h	WORD	length of following data (multiple of 4)
 02h 2N WORDs	X,Y coordinates relative to the position of the previous point
		  (current position for first point) for each of N points in
		  polyline
Notes:	the first line segment is drawn beginning at the current position
	on completion, the current position is set to the last point drawn
SeeAlso: #2491,#2481,#2502

Format of HEAR parameter block:
Offset	Size	Description	(Table 2485)
 00h	WORD	0001h (length of following data)
 02h	BYTE	area definition flags
		bits 7-6: End Area type
			00 complete, perform fill
			01 suspend definition
			10 complete, but don't fill
SeeAlso: #2473

Format of HEGS parameter block:
Offset	Size	Description	(Table 2486)
 00h	WORD	0000h (no data following)

Format of HESC parameter block:
Offset	Size	Description	(Table 2487)
 00h	WORD	0000h (no data following)

Format of HINIT parameter block:
Offset	Size	Description	(Table 2488)
 00h	WORD	0002h (length of following data)
 02h	WORD	segment of task buffer
SeeAlso: #2527

Format of HINT parameter block:
Offset	Size	Description	(Table 2489)
 00h	WORD	0004h (length of following data)
 02h	DWORD	interrupt/event identifier
		bit 31: vertical blanking

Format of HLDPAL parameter block:
Offset	Size	Description	(Table 2490)
 00h	WORD	000Ah (length of following data)
 02h	BYTE	palette ID (00h = user, 01h = default)
 03h	BYTE	reserved
 04h	WORD	number of first palette entry
 06h	WORD	number of entries
 08h	DWORD	-> palette entries
SeeAlso: #2524

Format of HLINE parameter block:
Offset	Size	Description	(Table 2491)
 00h	WORD	length of following data (multiple of 4)
 02h 2N WORDs	X,Y coordinates for each of N points in polyline
Note:	on completion, the current position is set to the last point drawn
SeeAlso: #2481,#2502,#2484

Format of HMRK parameter block:
Offset	Size	Description	(Table 2492)
 00h	WORD	length of following data (multiple of 4)
 02h 2N WORDs	X,Y for N points
SeeAlso: #2483

Format of HOPEN parameter block:
Offset	Size	Description	(Table 2493)
 00h	WORD	0003h (length of following data)
 01h	BYTE	initialization flags
		bit 6: don't load default palette
		bit 7: clear bitplanes
 02h	BYTE	mode type (see #2494)
 03h	BYTE	(ret) return code
		bit 7: no adapter (hardware mismatch)
SeeAlso: #2482

(Table 2494)
Values for 8514/A display mode:
 0000h	12x20 characters, 1024x768
 0001h	8x14 characters, 640x480
 0002h	8x14 characters, 1024x768
 0003h	7x15 characters, 1024x768

Format of HQCOORD parameter block:
Offset	Size	Description	(Table 2495)
 00h	WORD	0004h (length of following data)
 02h	BYTE	(ret) coordinate format
		bits 7-4: bytes per coordinate
		bits 3-0: fraction bytes in coordinate
 03h	BYTE	(ret) relative coordinate format
		bits 7-4: bytes per coordinate
		bits 3-0: fraction bytes in coordinate
 04h	BYTE	(ret) number of dimensions (2-4)
 05h	BYTE	(ret) test results
		bit 7: coordinate format not supported
		bit 6: relative coordinate format not supported
		bit 5: specified dimension not supported

Format of HQCP parameter block:
Offset	Size	Description	(Table 2496)
 00h	WORD	0004h (length of following data)
 02h	WORD	(ret) current X position
 04h	WORD	(ret) current Y position

Format of HQDFPAL parameter block:
Offset	Size	Description	(Table 2497)
 00h	WORD	0040h (length of following data)
 02h 16	DWORDs	(ret) color index values
Note:	the default palette is set to match the default EGA/VGA 16-color
	  palettes

Format of HQDPS parameter block:
Offset	Size	Description	(Table 2498)
 00h	WORD	0006h (length of following data)
 02h	WORD	(ret) size of data buffer in bytes
 04h	WORD	(ret) stack size in bytes
 06h	WORD	(ret) size of palette save buffer in bytes

Format of HQMODE parameter block:
Offset	Size	Description	(Table 2499)
 00h	WORD	0012h (length of following data)
 02h	BYTE	current video mode (see #2494)
 03h	WORD	driver version
		bit 6: 80286/8086 CPU
		bit 5: 8 bit planes instead of 4 planes
		bits 4-0: hardware release number
 05h	BYTE	adapter type
		03h 8514/A
		04h XGA
 06h	BYTE	reserved (display type)
 07h	BYTE	character cell width
 08h	BYTE	character cell height
 09h	BYTE	number of bit planes
 0Ah	WORD	screen width (pixels)
 0Ch	WORD	screen height (pixels)
 0Eh	WORD	horizontal resolution (pixels/inch)
 10h	WORD	vertical resolution (pixels/inch)
 12h	BYTE	flag: 00h = monochrome, FFh = color
 13h	BYTE	intensity levels
SeeAlso: #2500

Format of HQMODES parameter block:
Offset	Size	Description	(Table 2500)
 00h	WORD	0021h (length of following data)
 02h	BYTE	(ret) adapter type
 03h 32 BYTEs	(ret) available display modes (FFh byte marks end of data)
SeeAlso: #2499

Format of HRECT parameter block:
Offset	Size	Description	(Table 2501)
 00h	WORD	0008h (legth of following data)
 02h  2 WORDs	X,Y coordinates of top left corner or rectangle
 06h	WORD	rectangle's width
 08h	WORD	rectangle's height
Note:	the rectangle is filled using the current pattern, color, and mix

Format of HRLINE parameter block:
Offset	Size	Description	(Table 2502)
 00h	WORD	length of following data (multiple of 4)
 02h  2 WORDs	X,Y coordinates of starting point
 06h 2N WORDs	X,Y coordinates relative to the position of the previous point
		  for each of N points in polyline
Note:	on completion, the current position is set to the last point drawn
SeeAlso: #2491,#2481,#2484

Format of HRLPC parameter block:
Offset	Size	Description	(Table 2503)
 00h	WORD	0000h (no data following)
Note:	used for continuity of lines crossing scissors boundaries
SeeAlso: #2516

Format of HRPAL parameter block:
Offset	Size	Description	(Table 2504)
 00h	WORD	0300h (length of following data)
 02h 768 BYTEs	buffer containing previously-saved palette table
SeeAlso: #2524

Format of HSBCOL parameter block:
Offset	Size	Description	(Table 2505)
 00h	WORD	0004h (length of following data)
 02h	DWORD	color index for new background color
SeeAlso: #2509

Format of HSBP parameter block:
Offset	Size	Description	(Table 2506)
 00h	WORD	000Ch (length of following data)
 02h	DWORD	bitmask for graphics updates
 06h	DWORD	bitmask for alphanumeric updates
 0Ah	DWORD	display bitmask

Format of HSCELL parameter block:
Offset	Size	Description	(Table 2507)
 00h

Format of HSCMP parameter block:
Offset	Size	Description	(Table 2508)
 00h	WORD	0005h (length of following data)
 02h	DWORD	comparison color
 06h	BYTE	logical operation
		00h True
		01h pel > testcolor
		02h pel == testcolor
		03h pel < testcolor
		04h False
		05h pel >= testcolor
		06h pel <> testcolor
		07h pel <= testcolor

Format of HSCOL parameter block:
Offset	Size	Description	(Table 2509)
 00h	WORD	0004h (length of following data)
 02h	DWORD	color index for new foreground color
SeeAlso: #2505

Format of HSCOORD parameter block:
Offset	Size	Description	(Table 2510)
 00h	WORD	0003h (length of following data)
 02h	BYTE	coordinate format
		bits 7-4: bytes per coordinate
		bits 3-0: fraction bytes in coordinate
 03h	BYTE	relative coordinates format
		bits 7-4: bytes per coordinate
		bits 3-0: fraction bytes in coordinate
 04h	BYTE	number of dimensions (2-4)

Format of HSCP parameter block:
Offset	Size	Description	(Table 2511)
 00h	WORD	0004h (length of following data)
 02h  2 WORDs	X,Y or coordinate for new current position

Format of HSCS parameter block:
Offset	Size	Description	(Table 2512)
 00h	WORD	0004h (length of following data)
 02h	DWORD	-> character set definition

Format of HSGQ parameter block:
Offset	Size	Description	(Table 2513)
 00h	WORD	0002h (length of following data)
 02h	WORD	quality settings (see #2515)

Format of HSHS parameter block:
Offset	Size	Description	(Table 2514)
 00h	WORD	0008h (length of following data)
 02h	WORD	left edge of clipping rectangle (-2048 to +6143)
 04h	WORD	right edge
 06h	WORD	top edge
 08h	WORD	bottom edget

Bitfields for 8514/A quality settings:
Bit(s)	Description	(Table 2515)
 15	reserved
 14	high precision
 13	reserved
 12-11	pel code
	00 not drawn
	01 drawn
	02 conditional on overpainting/mixes
 10	don't close areas to be filed
 9-0	reserved

Format of HSLPC parameter block:
Offset	Size	Description	(Table 2516)
 00h	WORD	0000h (no data following)
Note:	used for continuity of lines crossing scissors boundaries
SeeAlso: #2503

Format of HSLT parameter block:
Offset	Size	Description	(Table 2517)
 00h	WORD	0006h (length of following data)
 02h	BYTE	line type (see #2518)
 03h	BYTE	reserved
 04h	DWORD	-> user line-type definition (if user type)
SeeAlso: #2519

(Table 2518)
Values for 8514/A line type:
 00h	user line type
 01h	dotted
 02h	short dashes
 03h	dash-dot
 04h	double dotted
 05h	dashed
 06h	dash double dot
 07h	solid
 08h	invisible
SeeAlso: #2517

Format of HSLW parameter block:
Offset	Size	Description	(Table 2519)
 00h	WORD	0001h (length of following data)
 02h	BYTE	width of line in pixels
SeeAlso: #2517

Format of HSMODE parameter block:
Offset	Size	Description	(Table 2520)
 00h	WORD	0001h (length of following data)
 02h	BYTE	new display mode number (see #2494)

Format of HSMRK paramter block:
Offset	Size	Description	(Table 2521)
 00h	WORD	000Eh (length of following data)
 02h	BYTE	cell width
 03h	BYTE	cell height
 04h	BYTE	flags
 05h	BYTE	reserved
 06h	WORD	length of marker symbol
 08h	DWORD	-> image definition data
 0Ch	DWORD	-> color definition data
SeeAlso: #2525

Format of HSMX parameter block:
Offset	Size	Description	(Table 2522)
 00h	WORD	0002h (length of following data)
 02h	BYTE	foreground mix (see #2523)
 03h	BYTE	background mix (see #2523)

(Table 2523)
Values for 8514/A mix:
 00h	retain previous mix
 01h	source OR destination
 02h	source
 04h	source XOR destination
 05h	leave as-is
 06h	max(source,destination)
 07h	min(source,destination)
 08h	source+destination (clipped)
 09h	destination-source (clipped to zero)
 0Ah	source-destination (clipped to zero)
 0Bh	average source and destination
 10h	zero destination
 11h	source AND destination
 12h	source AND NOT destination
 13h	source
 14h	NOT source AND destination
 15h	leave as-is
 16h	source XOR destination
 17h	source OR destination
 18h	NOT source AND NOT destination
 19h	NOT (source XOR destination)
 1Ah	NOT destination
 1Bh	source OR NOT destination
 1Ch	NOT source
 1Dh	NOT source OR destination
 1Eh	NOT source OR NOT destination
 1Fh	set all bits of destination

Format of HSPAL parameter block:
Offset	Size	Description	(Table 2524)
 00h	WORD	0300h (length of following data)
 02h 768 BYTEs	buffer for palette table
SeeAlso: #2490,#2504

Format of HSPATT parameter block:
Offset	Size	Description	(Table 2525)
 00h	WORD	000Eh (length of following data)
 02h	BYTE	cell width
 03h	BYTE	cell height
 04h	BYTE	flags
 05h	BYTE	reserved
 06h	WORD	length of marker symbol
 08h	DWORD	-> image definition data
 0Ch	DWORD	-> color definition data
SeeAlso: #2521,#2526

Format of HSPATTO parameter block:
Offset	Size	Description	(Table 2526)
 00h	WORD	0004h (length of following data)
 02h  2 WORDs	X,Y of pattern reference point (origin)
SeeAlso: #2525

Format of HSYNC parameter block:
Offset	Size	Description	(Table 2527)
 00h	WORD	0002h (length of following data)
 02h	WORD	segment of task state buffer
SeeAlso: #2488

Format of HXLATE parameter block:
Offset	Size	Description	(Table 2528)
 00h	WORD	0020h (length of following data)
 02h 32 BYTEs	color index table
--------V-7F0105-----------------------------
INT 7F - IBM XGA Adapter Interface (XGAAIDOS.SYS)
	AX = 0105h
Return: CF set on error
	CF clear if successful
	    CX:DX -> array of FAR pointers to entry points (see #2461)
Note:	this API is a superset of the 8514/A Adapter Interface
	  (see AX=0105h"HDILOAD")
----------7F0106-----------------------------
INT 7F - HDILOAD Mach32 Adapter Interface - UNINSTALL
	AX = 0106h
Return: AX = 0105h if successfully unloaded
SeeAlso: AX=0105h
--------N-7F02-------------------------------
INT 7F - Alloy NTNX, MW386 - RELEASE SEMAPHORE
	AH = 02h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see #2455)
	AH = semaphore owner if status=02h
SeeAlso: AH=00h,AH=01h,AH=42h
--------T-7F02-------------------------------
INT 7F - MultiLink Advanced v1.0+ - RELEASE CPU
	AH = 02h
Return: ???
Desc:	yields CPU to other tasks
SeeAlso: AH=00h"MultiLink",AH=09h"MultiLink",INT 15/AX=1000h
--------N-7F02-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - SEND FRAME
	AH = 02h
	AL = stream number (01h-40h)
	CX = length of frame
	ES:SI -> frame to be sent
SeeAlso: AH=00h"G8BPQ",AH=03h"G8BPQ",AH=07h"G8BPQ",AH=0Ah"G8BPQ"
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
SeeAlso: AH=00h"G8BPQ",AH=02h"G8BPQ",AH=05h"G8BPQ"
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
	DX:DI -> buffer for user information record (see #2529)
Notes:	MW386 provides this function for backward compatibility only, and sets
	  many of the fields to zero because they are meaningless under MW386
	this function has no effect when called by the host (user 0)
SeeAlso: AH=03h

Format of Alloy user information record:
Offset	Size	Description	(Table 2529)
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
SeeAlso: AH=00h"G8BPQ",AH=04h"G8BPQ"
--------N-7F06-------------------------------
INT 7F - Alloy NTNX (Host) - GET SHARED DRIVE INFO
	AH = 06h
	AL = drive number (1=A:, 2=B:, etc)
	ES:DI -> drive info record (see #2530)
Return: AX = status
	    0000h successful
		ES:DI buffer filled
	    0001h not shared drive

Format of Alloy drive info record:
Offset	Size	Description	(Table 2530)
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
	    0001h connect to node
		use BBS Call if APPLMASK=1
	    0002h disconnect
	    0003h return user to node
SeeAlso: AH=01h"G8BPQ",AH=04h"G8BPQ"
--------N-7F07-------------------------------
INT 7F - Alloy NTNX, MW386 - GET LIST OF SHARED DRIVES
	AH = 07h
Return: ES:DI -> shared drive list (see #2531)
Note:	MW386 considers all fixed disks to be shared drives; only C and D will
	  be returned as shared

Format of Alloy shared drive list:
Offset	Size	Description	(Table 2531)
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
	AH = session type (see #2532)
	BX = L2 paclen for session
	CX = maximum frame size
	DX = L4 window size or 0000h if not L4 circuit
Program: the G8BPQ AX25 Networking Package is amateur packet radio software by
	  John Wiseman which allows a PC to act as a node in an AX.25 network
SeeAlso: AH=01h"G8BPQ",AH=02h"G8BPQ",AH=03h"G8BPQ",AH=0Ah"G8BPQ"

Bitfields for G8BPQ session type:
Bit(s)	Description	(Table 2532)
 0	L2LINK
 1	SESSION
 2	UPLINK
 3	DOWNLIND
 5	BPQHOST
--------T-7F09-------------------------------
INT 7F - MultiLink Advanced v1.0+ - SET TASK PRIORITY
	AH = 09h
	AL = priority (0-7)
Note:	the installation check consists of ensuring that the interrupt vector
	  is not pointing at segment 0000h, then checking whether the byte
	  at offset 0000h in the interrupt handler's segment is E9h
Index:	installation check;MultiLink Advanced
SeeAlso: AH=00h"MultiLink",AH=0Ah"MultiLink"
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
	ES:DI -> buffer for system flags (see #2533)
Return: ES:DI buffer filled
Notes:	on a slave, only the NX_Busy flag is returned
	all three flags are at fixed positions, so this function only needs to
	  be called once
	an interrupt handler should only perform DOS or device accesses when
	  all three flags are 00h

Format of Alloy system flags:
Offset	Size	Description	(Table 2533)
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
--------T-7F0A-------------------------------
INT 7F - MultiLink Advanced v1.0+ - SET KEYBOARD TEST STATUS
	AH = 0Ah
	AL = task-switch status
	    00h normal (disable task when it repeatedly polls keyboard)
	    01h disable task until keyboard input available
	    FFh never disable task
Return: ???
SeeAlso: AH=09h"MultiLink"
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
	ES:DI -> buffer for received data (see #2534)
Return: CX = number of bytes received
Note:	the specified buffer must be large enough to receive a full frame
SeeAlso: AH=03h"G8BPQ",AH=08h"G8BPQ",AH=0Ah"G8BPQ"

Format of G8BPQ received data:
Offset	Size	Description	(Table 2534)
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
	    0002h (v4.07+) initiate NODES broadcast
SeeAlso: AH=09h"G8BPQ"
--------N-7F0D00-----------------------------
INT 7F - G8BPQ v4.07+ - HOST MODE - GET AVAILABLE STREAM
	AX = 0D00h
Return: AL = first available stream number, or FFh if none free
SeeAlso: AH=00h"G8BPQ",AH=0Dh
--------N-7F0D-------------------------------
INT 7F - G8BPQ v4.07+ - HOST MODE - ALLOCATE/DEALLOCATE STREAM
	AH = 0Dh
	AL = stream number (01h-FFh)
	CL = function
	    01h allocate stream
		Return: CX = status (0000h successful, else already in use)
	    02h deallocate stream
SeeAlso: AX=0D00h
--------N-7F0F-------------------------------
INT 7F - G8BPQ v4.00+ - HOST MODE - GET TIME MARKER
	AH = 0Fh
Return: AX = time marker (clock ticks modulo 64K)
Program: the G8BPQ AX25 Networking Package is amateur packet radio software by
	  John Wiseman which allows a PC to act as a node in an AX.25 network
SeeAlso: AH=01h"G8BPQ",AX=0D00h,INT 1A/AH=00h
--------N-7F10--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - OPEN CHANNEL
	AH = 10h
	CL = 00h
	AL = channel number
	DX:DI -> channel buffer
Return: AL = status (00h-03h,0Dh) (see #2535)
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=01h,AH=10h/CL=04h,AH=14h/CL=02h

(Table 2535)
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
Return: AL = status (00h-03h,0Ah) (see #2535)
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=00h,AH=10h/CL=05h
--------N-7F10--CL02-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - LOCK CHANNEL
	AH = 10h
	CL = 02h
	AL = channel number
Return: AL = status (00h-03h,0Ah,0Ch) (see #2535)
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=03h,AH=10h/CL=06h,AH=10h/CL=08h
--------N-7F10--CL03-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - UNLOCK CHANNEL
	AH = 10h
	CL = 03h
	AL = channel number
Return: AL = status (00h-03h,0Ah) (see #2535)
Notes:	should only be used on channels locked with AH=10h/CL=02h, not on those
	  locked by receipt of a datagram
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=02h,AH=10h/CL=04h,AH=10h/CL=09h
--------N-7F10--CL04-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - RELEASE BUFFER
	AH = 10h
	CL = 04h
	AL = channel number
Return: AL = status (00h-03h) (see #2535)
Notes:	unlocks buffer after received datagram has been processed
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=00h
--------N-7F10--CL05-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - CLOSE ALL CHANNELS
	AH = 10h
	CL = 05h
Return: AL = status (00h-03h) (see #2535)
Notes:	clears all pending datagrams and clears buffer pointers before closing
	  the channels
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=01h
--------N-7F10--CL06-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - LOCK ALL OPEN CHANNELS
	AH = 10h
	CL = 06h
Return: AL = status (00h-03h) (see #2535)
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=02h,AH=10h/CL=08h
--------N-7F10--CL07-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - UNLOCK ALL LOCKED IDLE CHANNELS
	AH = 10h
	CL = 07h
Return: AL = status (00h-03h) (see #2535)
Notes:	unlocks all locked channels which have no pending datagrams
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=03h,AH=10h/CL=09h
--------N-7F10--CL08-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - LOCK MULTIPLE CHANNELS
	AH = 10h
	CL = 08h
	DX = maximum channel number to lock
Return: AL = status (00h-03h) (see #2535)
Notes:	locks channels numbered 00h through the value in DX
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=02h,AH=10h/CL=06h,AH=10h/CL=09h
--------N-7F10--CL09-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - UNLOCK MULTIPLE CHANNELS
	AH = 10h
	CL = 09h
	DX = maximum channel number to unlock
Return: AL = status (00h-03h) (see #2535)
Notes:	unlocks channels numbered 00h through the value in DX
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=03h,AH=10h/CL=07h,AH=10h/CL=08h
--------N-7F11-------------------------------
INT 7F - Alloy NTNX, MW386 - SEND DATAGRAM
	AH = 11h
	DX:SI -> request block (see #2537)
Return: AL = status (see #2536)
Note:	if wildcard channel FFh used, actual channel number will be filled in
SeeAlso: AH=12h

(Table 2536)
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
Offset	Size	Description	(Table 2537)
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
Return: AL = status (see #2538)
Note:	also unlocks the channel, allowing the next datagram to be received
SeeAlso: AH=11h,AH=15h/CL=04h

(Table 2538)
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
	DX:DI -> application FAR receive service routine (see #2539)
Return: AL = status (00h-03h) (see #2538)
SeeAlso: AH=14h/CL=01h,AH=14h/CL=03h

(Table 2539)
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
	DX:DI -> application FAR acknowledge service routine (see #2540)
Return: AL = status (00h-03h) (see #2538)
Note:	the service routine will be called as soon as an acknowledgment arrives
SeeAlso: AH=12h,AH=14h/CL=00h,AH=14h/CL=04h,AH=15h/CL=04h

(Table 2540)
Values Alloy acknowledge service routine is called with:
	DS:SI -> acknowledge structure (see #2544)
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
Return: AL = status (00h-03h) (see #2538)
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
	DX:DI -> buffer for busy structure (see #2541)
Return: DX:DI buffer filled

Format of Alloy busy structure:
Offset	Size	Description	(Table 2541)
 00h	DWORD	pointer to busy flag byte
 04h	WORD	fixed port address (FF00h)
--------N-7F15--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - GET CHANNEL STATUS
	AH = 15h
	CL = 00h
	AL = channel number
	DX:DI -> status structure (see #2542)
Return: AL = status (00h-03h) (see #2538)
SeeAlso: AH=15h/CL=01h

Format of Alloy channel status structure:
Offset	Size	Description	(Table 2542)
 00h	BYTE	channel status
		bit 0: channel open
		bit 1: channel buffer contains received data
		bit 7: channel locked
 01h	BYTE	sender ID
--------N-7F15--CL01-------------------------
INT 7F - Alloy NTNX, MW386 - GET NEXT FULL CHANNEL
	AH = 15h
	CL = 01h
	DX:DI -> full-channel structure (see #2543)
Return: AL = status
	    00h successful
	    01h busy
	    0Ah no datagrams available
Note:	MW386 v1.0 returns the lowest channel with a datagram; newer versions
	  and NTNX return the oldest datagram
SeeAlso: AH=15h/CL=00h

Format of Alloy full-channel structure:
Offset	Size	Description	(Table 2543)
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
	DX:DI -> status structure (see #2544)
Return: AL = status
	    00h successful
		DX:DI structure filled
	    01h busy
	    0Ah no acknowledgement has arrived
SeeAlso: AH=12h,AH=14h/CL=01h

Format of Alloy status structure:
Offset	Size	Description	(Table 2544)
 00h	BYTE	sender ID
 01h	BYTE	channel number
 02h  4 BYTEs	receiver status (see #2538)
--------N-7F16-------------------------------
INT 7F - Alloy NTNX, MW386 - DIRECT MEMORY TRANSFER
	AH = 16h
	DX:SI -> transfer structure (see #2545)
Return: AL = status
	    00h successful
	    0Ah source or destination out of range
	    0Bh transfer kernal busy--try again
Notes:	this call transfers memory contents directly between users; both source
	  and destination user IDs may differ from the caller's ID
	no segment wrap is allowed

Format of Alloy transfer structure:
Offset	Size	Description	(Table 2545)
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
	DS:DX -> control packet (see #2546)
Note:	messages or commands are ignored if disabled by the destination user
SeeAlso: AH=22h

Format of Alloy control packet:
Offset	Size	Description	(Table 2546)
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
Return: AX = status (see #2547)
Note:	only drives on the current machine may be attached

(Table 2547)
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
Return: AX = status (see #2547)
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
Return: CL = executive type (see #2548)
SeeAlso: AH=25h/CL=00h

(Table 2548)
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
Return: AX = file mode bits (see #2549)
Note:	MW386 does not support file modes, and always returns AX=001Fh
SeeAlso: AH=26h,AH=26h/CL=06h

Bitfields for Alloy file mode bits:
Bit(s)	Description	(Table 2549)
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
Return: AL = status (see #2550)
Note:	requests exclusive read/write access to file
SeeAlso: AH=00h,AH=41h"MW386",AH=42h"NTNX"

(Table 2550)
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
Return: AL = status (see #2550)
SeeAlso: AH=00h,AH=42h"MW386"
--------s-7F4150BHC1-------------------------
INT 7F U - Voyetra - AAPISG - API
	AX = 4150h ('AP')
	BH = C1h
	BL = function (00h-13h)
	    00h initialize (fails except first time called)
	???
Return: AX = status???
	    0000h successful
	    0001h failed
Program: AAPISG is a driver by Voyetra for the Aztech Sound Galaxy sound board
BUG:	the function range check uses JL instead of JB, so it will cause a
	  crash if BL >= 80h on entry
SeeAlso: AX=4331h,AX=564Dh,AX=5658h
--------N-7F42-------------------------------
INT 7F - Alloy NTNX - UNLOCK FILE FOR USER
	AH = 42h
	AL = user ID
	DS:DX -> ASCIZ filename
Return: AL = status (see #2550)
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
--------s-7F4331BHC1-------------------------
INT 7F U - Voyetra - VAPISG - API
	AX = 4331h ('C1')
	BH = C1h
	BL = function (00h-7Ah)
	???
Return: ???
Program: VAPISG is a MIDI driver by Voyetra for the Aztech Sound Galaxy
	  sound board
SeeAlso: AX=4150h,AX=564Dh,AX=5658h
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
--------s-7F564DBHC1-------------------------
INT 7F U - Voyetra Multimedia Player - VMP.EXE API
	AX = 564Dh ('VM')
	BH = C1h
	BL = function (00h-1Bh)
	    00h ???
		Return: CF clear
			AX = 0000h
	???
Return: AX = FFFFh if invalid function
	???
SeeAlso: AX=4331h,AX=5658h
--------s-7F5658BHC1-------------------------
INT 7F U - Voyetra - VAPISG - API
	AX = 5658h ('VX')
	BH = C1h
	BL = function (00h-1Bh)
	???
Return: ???
Program: VAPISG is a MIDI driver by Voyetra for the Aztech Sound Galaxy
	  sound board
SeeAlso: AX=4331h,AX=564Dh
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
	    00h	 accepted
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
	ES:BX -> entry point array (see #2551)
SeeAlso: AX=0104h,AX=0105h

(Table 2551)
Values for 8516 Touch Screen function number:
 00h	check initialization and reset (see #2552)
 14h	set user-defined subroutine (see #2553)
Notes:	each driver function takes two stack parameters using Pascal calling
	  conventions: address of parameter block and address of results buffer
	all pointers are FAR pointers
	on return, AX contains the status of the call:
	    AX = 0000h successful
		 0001h invalid input
		 0002h interface error
		 0003h unable to perform function

Format of 8516 Touch Screen Function 00h parameter block:
Offset	Size	Description	(Table 2552)
 00h	WORD	0000h (function number)
Note:	this function should be called before any other device driver functions

Format of 8516 Touch Screen Function 00h results buffer:
Offset	Size	Description	(Table 2553)
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
	DS:DX -> reset packet (see #2554)
Return: never if successful
Note:	all users will be shut down immediately if successful
SeeAlso: AH=CFh

Format of Alloy MW386 reset packet:
Offset	Size	Description	(Table 2554)
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
--------!---Section--------------------------
