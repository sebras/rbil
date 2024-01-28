INT 60 - reserved for user interrupt
----------60---------------------------------
INT 60 - Zero Bug Virus
   The "Zero Bug" virus hooks this vector.  Purpose unknown.
SeeAlso: INT 32
----------60---------------------------------
INT 60 - Adaptec and OMTI controllers - DRIVE 0 DATA
SeeAlso: INT 64"Adaptec"
----------60---------------------------------
INT 60 - Atari Portfolio - USER INTERFACE FUNCTIONS
   supplies a number of subfunctions which perform such functions as drawing
   boxes and menus, and provide input line editing
SeeAlso: INT 61"Atari"
----------60---------------------------------
INT 60 - PC-IPC API
	STACK:	DWORD	pointer to parameter block (see below)
Return: STACK:	unchanged
Notes:	PC-IPC is a shareware TSR by Donnelly Software Engineering which allows
	  communication between independent programs
	INT 60 is the default, any interrupt vector may be used by specifying
	  the vector on the commandline

Format of parameter block:
Offset	Size	Description
 00h	WORD	caller's ID
 02h	WORD	to ID
 04h	WORD	command code (see below)
 06h	WORD	returned status
		bit 0: unused
		bit 1: IPC enabled
		bit 2: IPC installed
		bit 3: error
		bit 4: message(s) available
 08h	WORD	returned error code (see below)
 0Ah	WORD	size of data
 0Ch	DWORD	pointer to data buffer

Values of command code:
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
----------60---------------------------------
INT 60 - Tangram Arbiter - API
Notes:	Arbiter may use any interrupt from 60h to 66h (parameterized)
	identified by string "@ARB_API" immediately following a short jump at
	  the interrupt handler address
	Arbiter makes a PC disk look like a slow disk over an SNA link to an
	  IBM mainframe
----------60---------------------------------
INT 60 - INTRSPY/CMDSPY API
Notes:	INTRSPY will hook the first available interrupt in the range 60h-67h.
	The installation check is to 
	  a) determine that the handler is an IRET instruction
	  b) the signature 0Dh "INTRSPY vN.NN" immediately precedes the handler
	  If INTRSPY is installed, the DWORD immediately after the IRET stores
	  its entry point.
	INTRSPY is a script-driven debugger included with the book
	  _Undocumented_DOS_.

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
----------60---------------------------------
INT 60 - PC/370 v4.2 - ???
	???
Return: ???
Notes:	PC/370 is an IBM 370 emulator by Donald S. Higgins
	this is the default interrupt, however the documentation includes
	  instructions for patching the system for another interrupt
SeeAlso: INT 2F/AX=7F24h,INT DC"PC/370"
----------60---------------------------------
INT 60 - FTP Packet Driver - PC/TCP Packet Driver Specification
   The handler for the interrupt will start with a 3-byte jump instruction, 
   followed by the ASCIZ string "PKT DRVR".  To find the interrupt being used
   by the driver, an application should scan through interrupt vectors 60h to
   80h until it finds one with the "PKT DRVR" string.
----------6000-------------------------------
INT 60 - SYS_PROF.EXE - PROFILER STATUS
	AH = 00h
Return: AX = 0000h    profiling is off
	    otherwise profiling is on
Note:	SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
SeeAlso: AH=01h"SYS_PROF",02h"SYS_PROF"
----------6000-------------------------------
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
		CL = debugger color
		BH = monitor start line
		BL = debugger start line
		AH = makecode of the hotkey
		AL = ASCII code of the hotkey
		DL = status of special keys (only SHIFT, ALT, CTRL) for the
			hotkey (coded as for the keyboard flag at 0040h:0017h)
		DH = basic process number for the communication with drivers
			process number for the display driver, DH+1 = process
			number for the command driver(s)
	DS:SI -> MDEBUG identification table
Notes:	MDEBUG is a shareware memory-resident debugger by Bernd Schemmer
	MDEBUG uses INT 60 by default, but may be directed to any of INT 60
	  through INT 67; the interrupt handler is preceded by the signature
	  "USERINT" and is not chained
	if DS:SI points at a null byte, MDEBUG will prompt for a password if
	  passwords are active; enough stack space must be provided for an
	  INT 10h call
SeeAlso: AH=02h"MDEBUG"

Format of MDEBUG identification table:
Offset	Size	Description
 -2	WORD	entry offset
 00h	WORD	CS of MDEBUG
 02h	DWORD	old INT 08h vector
 06h	DWORD	old INT 09h vector
 0Ah	DWORD	address INT 16h routine used by MDEBUG
 0Eh	BYTE	length of version string
 0Fh  N BYTEs	version string
----------6001-------------------------------
INT 60 - MDEBUG - GET ADDRESS OF THE HELP REGISTERS
	AH = 01h
	DS:SI -> password or a null byte
Return: AX = return code
	    FFFEh password is invalid
	    FFFDh display mode is invalid
	   else successful
		ES:DI point to the help registers of MDEBUG
	       ES:DI-02h  -> R0
	       ES:DI	  -> R1
	       ES:DI+02h  -> R2
	       ES:DI+04h  -> R3
	       ...
	       ES:DI+0Eh  -> R8
----------6001FF-----------------------------
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
	01h invalid handle number
	02h no interfaces of the specified class found
	03h no interfaces of the specified type found
	04h no interfaces of the specified number found
	05h bad packet type
	06h interface does not support multicast messages
	07h this packet driver cannot terminate
	08h invalid receiver mode
	09h insufficient space
	0Ah type accessed but never released
	0Bh bad command
	0Ch packet could not be sent
	0Dh hardware address could not be changed
	0Eh hardware address has a bad length or format
	0Fh could not reset interface

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
    Class 02h  ProNET-10
	01h Proteon p1300
	02h Proteon p1800
    Class 03h  IEEE 802.5/ProNet-4
	01h IBM Token-Ring Adapter
	02h Proteon p1340
	03h Proteon p1344
	04h Gateway PC-bus
	05h Gateway AT-bus
	06h Gateway MCA-bus
    Class 04h  Omninet
    Class 05h  Appletalk
    Class 06h  Serial Line
	01h Clarkson 8250-SLIP
	02h Clarkson "Multiplexor"
    Class 07h  StarLAN (subsumed by Ethernet class)
    Class 08h  ARCnet
	01h Datapoint RIM
    Class 09h  AX.25
    Class 0Ah  KISS
    Class 0Bh  IEEE 802.3 with 802.2 headers
	types same as for class 01h
    Class 0Ch  FDDI with 802.2 headers
    Class 0Dh  Internet X.25
	01h Western Digital
	02h Frontier Technology
    Class 0Eh  N.T. LANSTAR (encapsulating DIX Ethernet)
	01h NT LANSTAR/8
	02h NT LANSTAR/MC
Note: class and type numbers are cleared through FTP Software
----------6001-------------------------------
INT 60 - SYS_PROF.EXE - TURN PROFILING OFF
	AH = 01h
Note:	SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
SeeAlso: AH=00h"SYS_PROF",02h"SYS_PROF"
----------6002-------------------------------
INT 60 - MDEBUG - SET STATUS
	AH = 02h
	DS:SI -> password or a null byte
	ES = new value for the register SE
	DI = new value for the register OF
	CH = new monitor color if nonzero
	CL = new debugger color if nonzero
	BH = new monitor start line if nonzero
	BL = new debugger start line if nonzero
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
	   else AL = error code
		    bit 0 invalid monitor start line
			1 invalid debugger start line
			2 invalid hotkey
			3 invalid process number
		      4-7 reserved
Note:	the values of the registers SE and OF are always changed, the other
	  values are only changed if they are valid
SeeAlso: AH=00h"MDEBUG"
----------6002-------------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - ACCESS TYPE
	AH = 02h
	AL = interface class
	BX = interface type
	DL = interface number
	DS:SI -> type
	CX = length of type
	ES:DI -> receiver
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
	    AX = handle		
SeeAlso: AH=03h"FTP"

Receiver is called with
	AX = subfunction
	    00h application to return pointer to buffer in ES:DI
		returned ES:DI = 0000h:0000h means throw away packet
	    01h copy completed
		DS:SI -> buffer
	BX = handle
	CX = buffer length
when a packet is received
----------6002-------------------------------
INT 60 - SYS_PROF.EXE - TURN PROFILING ON
	AH = 02h
Note:	SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
SeeAlso: AH=00h"SYS_PROF",01h"SYS_PROF"
----------6003-------------------------------
INT 60 - MDEBUG - POP UP
	AH = 03h
	DS:SI point to the password or a null byte
	ES -> new value for the register SE
	DI -> new value for the register OF
Return: AX = return code
	    FFFFh call not allowed
	    FFFEh password is invalid
	    FFFDh display mode is invalid
	   else successful
SeeAlso: AH=04h"MDEBUG"
----------6003-------------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - RELEASE TYPE
	AH = 03h
	BX = handle
Return: CF set on error
	   DH = error code (see AX=01FFh)
	CF clear if successful	
SeeAlso: AH=02h"FTP"
----------6003-------------------------------
INT 60 - SYS_PROF.EXE - GET ADDRESS OF PROFILING TABLE
	AH = 03h
Return: ES:BX -> profiling table
Note:	SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
SeeAlso: AH=04h"SYS_PROF"
----------6004-------------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - SEND PACKET
	AH = 04h
	DS:SI -> buffer
	CX = length
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
Note:	the buffer may be modified immediately upon return from this call
SeeAlso: AH=0Bh
----------6004-------------------------------
INT 60 - MDEBUG - POP UP
	AH = 04h
	DS:SI -> password or a null byte
Return: AX = return code
	    FFFFh call not allowed
	    FFFEh password is invalid
	    FFFDh display mode is invalid
	   else successful
SeeAlso: AH=03h"MDEBUG"
----------6004-------------------------------
INT 60 - SYS_PROF.EXE - CLEAR PROFILING TABLE
	AH = 04h
Note:	SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
SeeAlso: AH=03h"SYS_PROF"
----------6005-------------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - TERMINATE DRIVER FOR HANDLE
	AH = 05h
	BX = handle
Return: CF set on error
	   DH = error code (see AX=01FFh)
	CF clear if successful
----------6005-------------------------------
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
		BL = old value of the semapor of MDEBUG
		BH = old value of the INT 08h semaphor
		    (this semaphor is always reset after this function)
----------6006-------------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - GET ADDRESS
	AH = 06h
	BX = handle
	ES:DI -> buffer
	CX = length
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
	    CX = length	
Note:	copies the local net address associated with the handle into the buffer
----------6006-------------------------------
INT 60 - MDEBUG - GET PASSWORD STATUS
	AH = 06h
Return: AL = status
	    00h password inactive
	    01h password active
----------6007-------------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - RESET INTERFACE
	AH = 07h
	BX = handle
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
----------600A-------------------------------
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
----------600B-------------------------------
INT 60 - FTP Packet Driver 1.09+ - HIGH-PERF FUNC - ASYNCHRONOUS SEND PACKET
	AH = 0Bh
	DS:SI -> buffer
	CX = length of buffer
	ES:DI -> FAR function to call when buffer becomes available
Return: CF set on error
	    DH = error code (0Bh,0Ch) (see AX=01FFh)
	CF clear if successful
Note:	unlike function 04h, the buffer is not available for modification as
	  soon as the call returns; the buffer may be queued by the driver and
	  not processed until later
SeeAlso: AH=04h"Packet Driver"

Completion function called with:
	AX = result
	    00h copy OK
	    nonzero error
	ES:DI -> buffer passed to INT 60/AH=0Bh call
----------600C-------------------------------
INT 60 - Banyan VINES, 3com - GET STATION ADDRESS
	AH = 0Ch
Return: AL = status
	    00h successful
		ES:SI -> 6-byte station address
	    02h semaphore service is unavailable
----------6011-------------------------------
INT 60 - 10-NET, Banyan VINES - LOCK AND WAIT
	AH = 11h
	AL = drive number or 0
	DX = number of seconds to wait
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status
	    00h successful
	    01h timeout
	    02h server not responding
	    03h invalid semaphore name
	    04h semaphore list is full
	    05h invalid drive ID
	    06h invalid Ethernet address
	    07h not logged in
	    08h write to network failed
	    09h semaphore already logged for this CPU
SeeAlso: AH=12h,AH=13h
----------6012-------------------------------
INT 60 - 10-NET, Banyan VINES - LOCK
	AH = 12h
	AL = drive number or 00h
	ES:SI = Ethernet address or 0000h:0000h
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see also AH=11h)
	    01h semaphore currently locked by another PC
Note:	unlike function 11h, this function returns immediately
SeeAlso: AH=11h,AH=13h
----------6013-------------------------------
INT 60 - 10-NET, Banyan VINES - UNLOCK
	AH = 13h
	AL = drive number or 00h
	ES:SI = Ethernet address or 0000h:0000h
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see also AH=11h)
	    1 semaphore not locked
SeeAlso: AH=11h,AH=12h
----------6014-------------------------------
INT 60 - FTP Packet Driver - EXTENDED FUNC - SET RECEIVE MODE
	AH = 14h
	BX = handle
	CX = mode
	    01h turn off receiver
	    02h receive only packets sent to this interface
	    03h mode 2 plus broadcast packets
	    04h mode 3 plus limited multicast packets
	    05h mode 3 plus all multicast packets
	    06h all packets
Return: CF set on error
	   DH = error code (01h,08h) (see AX=01FFh)
	CF clear if successful
SeeAlso: AH=15h
----------6015-------------------------------
INT 60 - FTP Packet Driver - EXTENDED FUNC - GET RECEIVE MODE
	AH = 15h
	BX = handle
Return: CF set on error
	    DH = error code (01h) (see AX=01FFh)
	CF clear if successful
	    AX = mode	
SeeAlso: AH=14h
----------6016-------------------------------
INT 60 - FTP Packet Driver - EXTENDED FUNC - SET MULTICAST LIST
	AH = 16h
	ES:DI -> multicast list
	CX = length of list in bytes
Return: CF set on error
	    DH = error code (06h,09h,0Eh) (see AX=01FFh)
	CF clear if successful
SeeAlso: AX=17h
----------6017-------------------------------
INT 60 - FTP Packet Driver - EXTENDED FUNC - GET MULTICAST LIST
	AH = 17h
Return: CF set on error
	    DH = error code (06h,09h) (see AX=01FFh)
	CF clear if successful
	    ES:DI -> multicast addresses (do not modify)
	    CX = bytes of multicast addresses currently in use
SeeAlso: AH=16h
----------6018-------------------------------
INT 60 - FTP Packet Driver - EXTENDED FUNC - GET STATISTICS
	AH = 18h
	BX = handle
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
----------6019-------------------------------
INT 60 - FTP Packet Driver - EXTENDED FUNC - SET NETWORK ADDRESS
	AH = 19h
	ES:DI -> address
	CX = length of address
Return: CF set on error
	    DH = error code (0Dh,0Eh) (see AX=01FFh)
	CF clear if successful
	    CX = length
----------61---------------------------------
INT 61 - reserved for user interrupt
----------61---------------------------------
INT 61 - Atari Portfolio - EXTENDED BIOS
   provides subfunctions such as turning off the machine, accessing internal
   variables, and mapping memory cards
SeeAlso: INT 61"Atari"
----------61---------------------------------
INT 61 - FTP Software PC/TCP - TCP/IP TSR System Call interface
	AH = system call number
Return: AL = basic error
	AH = suberror number
----------61---------------------------------
INT 61 - Adaptec and OMTI controllers - DRIVE 0 DATA
SeeAlso: INT 60"Adaptec"
----------610001-----------------------------
INT 61 - Banyan VINES - "Sosock" - OPEN COMMUNICATIONS SOCKET
	AX = 0001h
	DS:DX -> communications control block (function 0001h)
Return: AX = status
	    0000h  successful
	    0001h  service not installed
	    0002h  invalid service ID
	    0098h  resource already in use
	    009Eh  address family does not exist
	    009Fh  socket type does not exist
	    00A0h  protocol does not exist
	    00A1h  no more sockets available
	    00A2h  no more buffer space available
Note:	BANYAN can use any interrupt from 60h through 66h.  The Banyan
	  interrupt handler is identified by the string "BANV" in the four
	  bytes immediately preceding the interrupt handler

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
----------610001-----------------------------
INT 61 - Banyan VINES - "Sosend" - INITIATE OUTPUT EVENT
	AX = 0001h
	DS:DX -> communications control block (function 0002h)
Return: AX = status
	    0000h  successful
	    0001h  service not installed
	    0002h  invalid service ID
	    0003h-000Ah reserved for BANV interface errors
	    0097h  invalid socket identifier
	    009Bh  destination node unreachable
	    009Ch  message overflow
	    009Dh  destination socket nonexistent
	    00A2h  no more buffer space
	    00A3h  timeout
	    00B1h  resource disconnect
Note:	BANYAN can use any interrupt from 60h through 66h.  The Banyan
	  interrupt handler is identified by the string "BANV" in the four
	  bytes immediately preceding the interrupt handler

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
		    1: reliable message
		    3: end of user message received
		    4: vectored request (if set, send buffer contains buffer
			descriptors)
		    5: connection-specific receive
		    6: change to connection-specific receive mode
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
----------610001-----------------------------
INT 61 - Banyan VINES - "Sorec" - RECEIVE INPUT EVENT NOTIFICATION
	AX = 0001h
	DS:DX -> communications control block (function 0003h)
Return: AX = status
	    0000h  successful
	    0001h  service not installed
	    0002h  invalid service ID
	    0003h-000Ah reserved for BANV interface errors
	    0097h  invalid socket identifier
	    00A2h  no more buffer space
	    00A3h  timeout
Note:	BANYAN can use any interrupt from 60h through 66h.  The Banyan
	  interrupt handler is identified by the string "BANV" in the four
	  bytes immediately preceding the interrupt handler

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
		    2: flush receive buffer on overflow
		    3: end of user message received
		    4: vectored request (if set, receive buffer contains buffer
			descriptors)
		    5: connection-specific receive
		    6: change to connection-specific receive mode
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
----------610001-----------------------------
INT 61 - Banyan VINES - "Soclose" - CLOSE A SOCKET
	AX = 0001h
	DS:DX -> communications control block (function 0004h)
Return: AX = status
	    0000h  successful
	    0001h  service not installed
	    0002h  invalid service ID
	    0003h-000Ah reserved for BANV interface errors
	    0097h  invalid socket identifier
Note:	BANYAN can use any interrupt from 60h through 66h.  The Banyan
	  interrupt handler is identified by the string "BANV" in the four
	  bytes immediately preceding the interrupt handler

Format of control block:
Offset	Size	Description
 00h	WORD	0004h
 02h	WORD	pointer to argument block (see below)
 04h	WORD	error return code
 06h  4 BYTEs	reserved

Format of argument block:
Offset	Size	Description
 00h	WORD	socket identifier
----------610001-----------------------------
INT 61 - Banyan VINES - "Sowait" - WAIT FOR ASYNCHRONOUS EVENT COMPLETION
	AX = 0001h
	DS:DX -> communications control block (function 0005h)
Return: AX = status
	    0000h  successful
	    0001h  service not installed
	    0002h  invalid service ID
	    0003h-000Ah reserved for BANV interface errors
	    00A2h  no more buffer space available
	    00A3h  timeout event
Notes:	BANYAN can use any interrupt from 60h through 66h.  The Banyan
	  interrupt handler is identified by the string "BANV" in the four
	  bytes immediately preceding the interrupt handler
	returns results for all asynchronous operations invoked from the
	  data segment used for this call

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
----------610001-----------------------------
INT 61 - Banyan VINES - "Sosession" - REGISTER APPLICATION WITH COMM SERVICE
	AX = 0001h
	DS:DX -> communications control block (function 0008h)
Return: AX = status
	    0000h  successful
	    00A2h  no more buffer space available
Note:	BANYAN can use any interrupt from 60h through 66h (default 61h).  The
	  Banyan interrupt handler is identified by the string "BANV" in the
	  four bytes immediately preceding the interrupt handler

Format of control block:
Offset	Size	Description
 00h	WORD	0008h
 02h	WORD	process type
		0001h transient process
		0002h resident process
 04h	WORD	error return code
 06h  4 BYTEs	reserved
----------610001-----------------------------
INT 61 - Banyan VINES - "Soint" - SET USER COMPLETION FUNCTION
	AX = 0001h
	DS:DX -> communications control block (function 000Bh)
Return: AX = status
	    0000h  successful
	    0001h  service not installed
	    0002h  invalid service ID
	    0003h-000Ah reserved for BANV interface errors
	    00A2h  no more buffer space available
Notes:	BANYAN can use any interrupt from 60h through 66h.  The Banyan
	  interrupt handler is identified by the string "BANV" in the four
	  bytes immediately preceding the interrupt handler
	FAR user function is invoked with SS,DS, and ES set to segment of
	  control block, and with the stack containing
		DWORD	return address
		WORD	argument pointer (sosend or sorec argument block)
		WORD	error return code
			0000h argument pointer is valid
			00A3h timeout

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
----------610002-----------------------------
INT 61 - Banyan VINES - 3270 INTERFACE
	AX = 0002h
	BH = function
	    00h "pi2reset"  reset 3270/SNA or 3270/BSC driver
	    02h "pi2bsc" (3270/BSC only)
	    03h	"pi2get"    get information stored in 3270 resident driver
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
Return: AX = status
	    0000h successful
	    000Bh invalid parameter or data does not fit data area
	    000Ch another code path currently active in resident driver
	    000Dh operation currently not allowed
	    0032h encountered connection disconnect error
	    0033h encountered "sosend" completion error
	    0034h encountered "sosend" communication error
	    0035h attach request refused.  extended error info via "pi2gerr":
			01h resource unavailable
			02h invalid type
			03h version mismatch
			04h invalid logical unit number
			05h error during ARL processing
			06h no access for user
	    0071h encountered "sosock" error
	    0072h encountered unrecognizable error
	    0073h encountered "sowait" error (extended info via "pi2gerr")
	    0074h encountered invalid type-of-request on "sowait"
	    0075h encountered "sorec" error (extended info via "pi2gerr")
	    0076h encountered "sorec" completion error (ext info via "pi2gerr")
	    0077h encountered connection request
	    0078h encountered unrecognizable data
	    0079h encountered unknown connection ID (ext info via "pi2gerr")
Notes:	Either 3270/SNA or 3270/BSC interface may use AX=0002h, depending on
	  which is loaded first.  The other interface will use AX=000Ah
	Status codes greater than 63h indicate an inconsistency in the 3270/SNA
	  or 3270/BSC resident driver, which must be reloaded by the user

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
 04h	WORD	pointer to WORD buffer for status
		bit 10: status modified
		bit  9: buffer modified
		bit  8: set cursor
		bit  5: sound alarm
		bits 0,1: size of print line for printer logical units
			00 unformatted line
			01 40-character line
			10 64-character line
			11 80-character line

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
 04h	BYTE	keyboard status
		00h UNLOCK - ready to accept data
		01h TIME - aid was struck
		02h SYSTEM - received response no restore
		03h FUNCTION - unavailable keyboard function
		04h INPUT - not currently used
		05h ENDFIELD - field filled in insert mode
		06h PROTECTED - attempt to enter in protected field
		07h NUMERIC - attempt to enter in numeric field
		08h PROGRAM - error in outbound data stream
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

Format of profile block:
Offset	Size	Description
 00h 64 BYTEs	gateway service name
 40h 16 BYTEs	gateway comm port address
 50h	WORD	primary logical unit number
 52h	WORD	secondary logical unit type
 54h	WORD	secondary logical unit number
 56h	WORD	printer assignment
 58h 50 BYTEs	keyboard definitions filename
----------610003-----------------------------
INT 61 - Banyan VINES - ASYNCHRONOUS TERMINAL EMULATION
	AX = 0003h
	DS:BX -> argument block with function number (see below)
Return: AX = status
	    0000h successful
	    000Bh invalid session ID
	    000Ch session not active
	    000Dh invalid request type
	    000Eh invalid parameters
	    000Fh out of heap space
	    0010h timeout on send
	    0011h Banyan communications error
	    0012h session not waiting for host
	    0013h session is active
	    0014h duplicate suspend session request
	    0015h no session suspended
	    0016h ring data buffer full
	    0017h printer error encountered
	    0018h Banyan communications error
	    0019h unable to make connection
	    001Ah no ring buffer specified at startup
	    001Bh service is down
	    001Ch invalid service name
	    001Dh service is closed
	    001Eh invalid connection name
	    001Fh max session limit reached for service
	    0020h access rights list for connection/dialout does not include
			this user
	    0021h service not responding
	    0022h missing telephone number

Format of argument block:
Offset	Size	Description
 00h	BYTE	session ID (00h)
 01h	BYTE	asynchronous interface request number
		00h initialize user buffer pointer information area
		01h send to host
		02h "control monitor"
		03h "flow control data": freeze/unfreeze display, ring buffer
		04h end active session
		05h set session parameter
		06h get session parameter
		07h set tab settings
		08h get tab settings
		09h refresh emulation screen
		0Ah suspend session temporarily
		0Bh restore previously suspended session
		0Ch set state of scroll lock checking
		0Dh exit emulation
		0Eh interrupt on character from host
		0Fh start a session
		10h start/stop printing of data received from host
		11h get file transfer parameters
		12h get connection information
		13h start/stop tracing data traffic in session
		14h interrupt on message from host
		15h reset error
---request=00h---
 02h	WORD	pointer to info area in caller's current DS
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
---request=01h---
 02h	BYTE	type
		00h ASCII byte
		01h ASCII string
		02h terminal function code
		03h up arrow
		04h down arrow
		05h left arrow
		06h right arrow
		07h break
 03h  N BYTEs	type-specific info
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
---request=02h---
 02h	BYTE	display flag
		00h don't display data received from host
		01h display data
---request=03h---
 02h	BYTE	flow control flag
		00h allow characters to be put into display or ring buffer
		01h don't place any more characters into display or ring buffer
---request=05h,06h---
 02h	BYTE	parameter number
		00h line speed (00h=any, 01h=50, 02h=110, 03h=134.5, 04h=150,
			05h=300,06h=600,07h=1200,08h=2400,09h=4800, 0Ah=9600)
		01h parity (00h=none, 01h=odd, 02h=even)
		02h duplex (00h=full, 01h=half)
		03h character size (00h=7 bits, 01h=8 bits)
		04h stop bits (00h=1, 01h=2)
		05h XON/XOFF flow control (00h=no, 01h=yes)
		07h intercharacter delay in tenths of a second
		08h interline delay in tenths of a second
		09h auto linefeed (00h=no, 01h=yes)
		0Ah filter control characters (00h=no, 01h=yes)
		0Bh terminal type (00h=VT100,01h=glassTTY,02h=VT52,03h=IBM3101)
		0Ch auto wrap (00h=no, 01h=yes)
		0Dh cursor shape (00h=underscore, 01h=block)
		0Eh character set (00h=UK, 01h=US ASCII)
		0Fh printer port (00h=LPT1, 01h=LPT2, 02h=LPT3)
 03h	BYTE	parameter value (returned for 06h)
---request=07h,08h---
 02h	WORD	pointer to 80-byte buffer in caller's current DS
		  each byte = 00h if no tab, 01h if tab at that position
---request=0Ah---
 02h	WORD	size of session information to be saved
 04h	WORD	pointer to buffer in caller's DS
---request=0Bh---
 02h	WORD	size of buffer into which session info is restored
 04h	WORD	pointer to buffer in caller's DS
---request=0Ch---
 02h	BYTE	check_scroll_lock flag
		00h off
		01h on (display of host data stopped while ScrollLock on)
---request=0Eh,14h---
 02h	DWORD	pointer to routine to be called (0000h:0000h = don't call)
 06h	DWORD	stack pointer to use when call is made
---request=0Fh---
 02h	WORD	pointer to information area in caller's current DS
		Offset	Size	Description
		 00h	WORD	length of service name
		 02h	WORD	pointer to service name in caller's DS
		 04h	BYTE	type of connection
				(00h=connection name, 01h=dialout)
		 05h	WORD	length of connection name/telephone number
		 07h	WORD	pointer to connection name/telephone number
---request=10h---
 02h	WORD	print capture flag (00h=off, 01h=on)
---request=11h---
 02h	WORD	pointer to info area in caller's current DS
		Offset	Size	Description
		 00h	BYTE	protocol flag (00h none, 01h Kermit)
		 01h	BYTE	direction flag (00h send, 01h receive)
		 02h	BYTE	length of null-terminated PC filename
		 03h	DWORD	pointer to null-terminated PC filename
		 07h	BYTE	length of null-terminated host filename
		 08h	DWORD	pointer to null-terminated host filename
---request=12h---
 02h	WORD	pointer to info area in caller's current DS (see below)
		Offset	Size	Description
		 00h	WORD	length of service name (returned)
		 02h	WORD	pointer to 64-byte buffer for service name
		 04h	BYTE	type of connection
				00h connection name
				01h dialout
		 05h	WORD	length of connection name/telephone number
		 07h	WORD	pointer to 64-byte buffer for name/telno
		 09h	BYTE	server line number being used (returned)
---request=13h---
 02h	BYTE	trace flag (00h=off, 01h=on)

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
 09h	WORD	primary error code
		0000h no error
		0001h unable to make connection
		0002h communications error, restart session
		0003h async terminal emulation service unavailable
		0004h lost carrier
		0005h all matching lines busy
		0006h no lines defined for connection name
		0007h no dial lines available on server
		0008h no matching dial lines available
		0009h out of heap space
		000Ah service error encountered
		000Bh timed out waiting to connect
		000Ch communications error
		000Dh communications error
		000Eh host want file transferred to/from PC
		000Fh host software changed session parameter
		0010h host software changed tap settings
		0011h host software changed LED indicator
		0012h host software changed display background (secondary error
			code 00h for white on black, 01h for black on white)
		0013h host software changed display option (secondary error
			code 00h for off, 01h for on)
		0014h communications error
		0015h communications error
		0016h unable to make connection
		0017h unable to make connection
 0Bh	WORD	secondary error code
----------610004-----------------------------
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
----------610005-----------------------------
INT 61 - Banyan VINES - PRINTER CONTROL
	AX = 0005h
	DS:DX -> request block
Return: AX = status
	    0000h successful
	    0001h network software not installed or incompatible

Format of request block:
Offset	Size	Description
 00h	WORD	function
		0201h "endspool" all data for a print job has been sent
		0205h "getactive" get currently active printer port
 02h	WORD	number of active port (1-3)
 04h	WORD	??? (0 for func 0201h, 3 for func 0205h)
 06h	WORD	0000h
----------610007BX0002-----------------------
INT 61 - Banyan VINES - GET PORTS FOR A SERVICE
	AX = 0007h
	BX = 0002h
	DS:DX -> StreetTalk service name
	DS:DI -> port record block (see below)
Return: AX = status
	    0000h successful
	    0001h PC network software not installed or incompatible
	    03E9h incorrect name syntax
	    03EAh organization name too long
	    03EBh group name too long
	    03ECh item name too long
	    03EDh StreetTalk name too long
	    03F3h organization not found
	    03F4h group not found
	    03F5h StreetTalk name not found
	    03F8h not a StreetTalk name
	    040Dh appropriate StreetTalk name unavailable

Format of port record block:
Offset	Size	Description
 00h	WORD	number of 17-byte elements
 02h 17 BYTEs	element (byte 00h = input port type, bytes 01h-10h = port)
		(see AX=0001h#"Sosock" for port format)
----------610007BX0004-----------------------
INT 61 - Banyan VINES - VERIFY EXISTENCE OF NAME AND RETURN CANONICAL FORM
	AX = 0007h
	BX = 0004h
	DS:DX -> StreetTalk name of service
	DS:DI -> port record block (see below)
Return: AX = status
	    0000h successful
	    0001h PC network software not installed or incompatible
	    03E9h incorrect name syntax
	    03EAh organization name too long
	    03EBh group name too long
	    03ECh item name too long
	    03EDh StreetTalk name too long
	    03F3h organization not found
	    03F4h group not found
	    03F5h StreetTalk name not found
	    03F8h not a StreetTalk name
	    0409h modify access denied
	    040Dh appropriate StreetTalk name unavailable

Format of port record block:
Offset	Size	Description
 00h	WORD	number of 17-byte elements
 02h 17 BYTEs	element: byte 00h = input port type, 01h-10h = port
		(see AX=0001h#"Sosock" for port format)
----------610007BX0005-----------------------
INT 61 - Banyan VINES - GET USER NAME
	AX = 0007h
	BX = 0005h
	DS:DX -> 64-byte buffer for user's StreetTalk name
Return: AX = status
	    0000h successful
	    0001h network software not installed or incompatible
Note:	if no user logged in, first byte of returned name will be 00h
----------610007BX0006-----------------------
INT 61 - Banyan VINES - TRANSLATE ERROR INTO ASCII STRING
	AX = 0007h
	BX = 0006h
	SI = error code (>100)
	DS:DX -> 80-byte buffer for error text
Return: AX = status
	    0000h successful
	    0001h network software not installed or incompatible	    
----------610007BX0007-----------------------
INT 61 - Banyan VINES - VERIFY EXISTENCE OF NAME AND RETURN CANONICAL FORM
	AX = 0007h
	BX = 0007h
	DS:DX -> NiceName block (see below)
Return: AX = status
	    0000h successful
	    0001h PC network software not installed or incompatible
	    03E9h incorrect name syntax
	    03EAh organization name too long
	    03EBh group name too long
	    03ECh item name too long
	    03EDh StreetTalk name too long
	    03F3h organization not found
	    03F4h group not found
	    03F5h StreetTalk name not found
	    03F8h not a StreetTalk name
	    040Dh appropriate StreetTalk name unavailable
SeeAlso: AX=0007h/BX=0008h

Format of NiceName block:
Offset	Size	Description
 00h	WORD	type of name
		0064h organization
		00C8h group
		012Ch item
 02h	WORD	pointer to ASCIZ input name
 04h	WORD	pointer to 64-byte buffer for output name
----------610007BX0008-----------------------
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
 0002h file service
 0003h print service
 0004h mail service
 0005h StreetTalk
 0006h time service
 0008h semaphore service
 0009h 3270/SNA service
 000Ah asynchronous terminal emulation service
 000Ch NETBIOS service
 000Dh PC-based service
----------610008BX0002-----------------------
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
----------610008BX0003-----------------------
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
----------61000A-----------------------------
INT 61 - Banyan VINES - SECONDARY 3270 INTERFACE
	AX = 000Ah
Notes:	either 3270/SNA or 3270/BSC interface will use AX=000Ah, depending on
	  which is loaded second.  The first interface loaded will use AX=0002h
SeeAlso: INT 61/AX=0002h
----------6101-------------------------------
INT 61 - Banyan VINES - CHECK SERVICE
	AH = 01h
	AL = service ID
	    01h communications
	    02h primary 3270 emulation
	    03h async terminal emulation
	    04h file deflectoin
	    07h StreetTalk
	    08h environment
	    0Ah secondary 3270 emulation
	    0Bh semaphore service
	    0Ch 3270 emulation active status
	    0Dh 3270 keyboard interrupt simulator
Return: AX = status
	    0000h installed
	    0001h not installed
	    0002h invalid ID
----------6102-------------------------------
INT 61 - Banyan VINES - GET REVISION NUMBER
	AH = 02h
	DS:DX -> 2-byte buffer for result
Return: AX = 0000h installed
	    DS:DX buffer contains revision number as
		10000d * major_ver + 100d * minor_ver + patch_revision
----------61---------------------------------
INT 61 - Sangoma CCIP (CCPOP 3270 resident module) INTERFACE
	BX:DX -> control block
----------62---------------------------------
INT 62 - reserved for user interrupt
----------62---------------------------------
INT 62 - Adaptec and OMTI controllers - DRIVE 0 DATA
SeeAlso: INT 61"Adaptec"
----------62---------------------------------
INT 62 - MS SQL Server/Sybase DBLIBRARY interface
----------6201-------------------------------
INT 62 - Cswitch - GIVE UP REST OF TIME-SLICE
	AH = 01h
Note:	Cswitch is a set of multitasking functions by Herb Rose
SeeAlso: AH=05h,AH=06h
----------6202-------------------------------
INT 62 - Cswitch - WAIT FOR SEMAPHORE
	AH = 02h
	DX = semaphore number (0-63)
Return: AX = FFFFh bad semaphore number
	     else  success
SeeAlso: AH=03h,AH=04h
----------6203-------------------------------
INT 62 - Cswitch - CHECK SEMAPHORE
	AH = 03h
	DX = semaphore number (0-63)
Return: AX = FFFFh not owned
	     else  owned
SeeAlso: AH=02h,AH=04h
----------6204-------------------------------
INT 62 - Cswitch - TRIGGER SEMAPHORE
	AH = 04h
	DX = semaphore number (0-63)
Return: AX = FFFFh bad semaphore number
	     else  success
SeeAlso: AH=02h,AH=03h
----------6205-------------------------------
INT 62 - Cswitch - SLEEP
	AH = 05h
	BX = seconds to sleep
SeeAlso: AH=01h,AH=06h,AH=08h
----------6206-------------------------------
INT 62 - Cswitch - SUSPEND
	AH = 06h
SeeAlso: AH=05h,AH=08h
----------6207-------------------------------
INT 62 - Cswitch - SPAWN
	AH = 07h
	ES:BX -> function address to start executing at
	CX = priority (1-10)
Return: AX = FFFDh  no free memory control blocks
	   = FFFEh  no free task control blocks
	   = FFFFh  not enough memory to create new task stack
	   = >0	    the tcb number of the new task, indicating no error
SeeAlso: AH=0Fh,AH=10h
----------6208-------------------------------
INT 62 - Cswitch - WAKE UP TASK
	AH = 08h
	BX = tcb identifier
SeeAlso: AH=05h,AH=06h
----------6209-------------------------------
INT 62 - Cswitch - SET PRIORITY
	AH = 09h
	BX = new base priority (1-10)
Note:	the lower the priority is numerically, the more often the task will run
----------620A-------------------------------
INT 62 - Cswitch - TEST MESSAGE QUEUE
	AH = 0Ah
	DX = queue number (0-63)
Return: AX = FFFFh bad queue number
	   = 0000h nothing on queue
	     else  number of bytes in first message in queue
SeeAlso: AH=0Bh,AH=0Ch
----------620B-------------------------------
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
----------620C-------------------------------
INT 62 - Cswitch - READ MESSAGE
	AH = 0Ch
	CX = number of bytes to read
	DS:SI -> buffer
	DX = queue number (0-63)
Return: AX = FFFFh bad queue number
	     else  number of bytes transferred
SeeAlso: AH=0Ah,AH=0Bh
----------620D-------------------------------
INT 62 - Cswitch - DON'T ALLOW TASK TO BE SWAPPED OUT
	AH = 0Dh
SeeAlso: AH=0Eh
----------620E-------------------------------
INT 62 - Cswitch - ALLOW TASK TO BE SWAPPED OUT
	AH = 0Eh
SeeAlso: AH=0Dh
----------620F-------------------------------
INT 62 - Cswitch - LOAD AND RUN PROGRAM FROM DISK
	AH = 0Fh
	ES:BX -> command line
	CX = priority (1-10)
	DX = background flag
	   = != 0000h  allows loading to EMS
Return: AX = 0000h task loader queue is full
	   = 0001h  no error
SeeAlso: AH=07h,AH=10h,AH=13h
----------6210-------------------------------
INT 62 - Cswitch - TERMINATE SPAWNED PROGRAM
	AH = 10h
SeeAlso: AH=07h,AH=0Fh
----------6211-------------------------------
INT 62 - Cswitch - GET TCB INFORMATION
	AH = 11h
	ES:BX -> a pointer which will be set to the tcb address
Return: AX = tcb indentifier
SeeAlso: AH=12h
----------6212-------------------------------
INT 62 - Cswitch - GET TCB ADDRESS
	AH = 12h
	ES:BX -> a pointer which will be set to the tcb table address
Return: AX = tcb indentifier
SeeAlso: AH=11h
----------6213-------------------------------
INT 62 - Cswitch - CHECK STATUS OF PREVIOUS LOAD_TASK
	AH = 13h
Return: AX = FFFCh no Memory Control Blocks available
	   = FFFDh no TCBs available
	   = FFFEh insufficient memory
	   = FFFFh cannot open file
	   = 0000h load in progress (not done yet)
	     else  tcb indentifier
SeeAlso: AH=0Fh
----------63---------------------------------
INT 63 - reserved for user interrupt
----------63---------------------------------
INT 63 - Adaptec and OMTI controllers - DRIVE 0 DATA
SeeAlso: INT 62"Adaptec"
----------63---------------------------------
INT 63 - Oracle SQL Protected Mode Executive - ???
----------63---------------------------------
INT 63 - 4+Power FLOPPY CONTROLLER - ORIGINAL INT 13/40
   the "4+Power" quad floppy controller BIOS hooks INT 13 (or INT 40 if INT 13
   has been moved there) and places the old value here
----------64---------------------------------
INT 64 - reserved for user interrupt
----------64---------------------------------
INT 64 - Adaptec controllers - DRIVE 1 DATA
SeeAlso: INT 60"Adaptec"
----------64---------------------------------
INT 64 - Oracle SQL Protected Mode Executive - ???
----------64---------------------------------
INT 64 - Novell NetWare to v2.0a - LOW-LEVEL API
Note:	equivalent to INT 7A for NetWare versions through 2.0a only; later
	  versions do not use this interrupt for IPX/SPX access, instead
	  getting an entry point from INT 2F/AX=7A00h
SeeAlso: INT 2F/AX=7A00h,INT 7A"Novell"
----------64---------------------------------
INT 64 - Data General DG10 - MicroECLIPSE COPROCESSOR INTERFACE
----------64---------------------------------
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
Notes:	Extended Batch Language is a batch-file enhancer by Seaware
	the chaining does not check whether the interrupt had been hooked
	  before, so if you try to chain when the previous vector was 
	  0000h:0000h, you'll be in trouble
	functions 72h and 7Ah-7Dh appear to be interfaces to the optional
	  floating-point and extended function packages
----------65---------------------------------
INT 65 - reserved for user interrupt
----------65---------------------------------
INT 65 - Adaptec controllers - DRIVE 1 DATA
SeeAlso: INT 64"Adaptec"
----------65---------------------------------
INT 65 - Data General DG10 - MicroECLIPSE COPROCESSOR INTERFACE
----------65---------------------------------
INT 65 - FTP Software NDIS-Packet Driver adapter - POST PROCESSING INTERRUPT
----------65---------------------------------
INT 65 - SD.COM v6.2
   The unregistered version of SD62.COM uses the low byte of this vector to
   count the number of invocations, displaying a registration reminder each
   time after the 20th use.
----------65---------------------------------
INT 65 - Ad Lib SOUND.COM - INTERFACE
	SI = function number (see separate entries for details on several)
	   = 0000h Init
	   = 0002h RelTimeStart
	   = 0003h SetState
	   = 0004h GetState
	   = 0005h Flush
	   = 0006h SetMode
	   = 0007h GetMode
	   = 0008h SetRelVolume
	   = 0009h SetTempo
	   = 000Ah SetTranspose
	   = 000Bh GetTranspose
	   = 000Ch SetActVoice
	   = 000Dh GetActVoice
	   = 000Eh PlayNoteDel
	   = 000Fh PlayNote
	   = 0010h SetTimbre
	   = 0011h SetPitch
	   = 0012h SetTickBeat
	   = 0013h NoteOn
	   = 0014h NoteOff
	   = 0015h Timbre
	   = 0016h SetPitchBend
	   = 0017h WaveForm
	ES:BX -> arguments
Note:	the installation check consists of checking for the signature block
	  immediately preceding the interrupt handler (see below)

Format of signature block:
Offset	Size	Description
 00h	WORD	version number
 02h 19 BYTEs	"SOUND-DRIVER-AD-LIB"
 15h	BYTE	01h
 16h	BYTE	01h
 17h	BYTE	00h
----------65----SI0000-----------------------
INT 65 - Ad Lib SOUND.COM - INITIALIZE (RESET)
	SI = 0000h
----------65----SI0003-----------------------
INT 65 - Ad Lib SOUND.COM - SET STATE
	SI = 0003h
	ES:BX -> WORD state = 0000h disabled 
			    = 0001h enabled
SeeAlso: SI=0004h
----------65----SI0004-----------------------
INT 65 - Ad Lib SOUND.COM - GET STATE
	SI = 0004h
Return: AX = 0000h all done playing sounds
	   = else  still playing sounds
SeeAlso: SI=0003h
----------65----SI0006-----------------------
INT 65 - Ad Lib SOUND.COM - SET MODE
	SI = 0006h
	ES:BX -> WORD mode = 0000h melodic
			   = 0001h percussive
SeeAlso: SI=0007h
----------65----SI0007-----------------------
INT 65 - Ad Lib SOUND.COM - GET MODE
	SI = 0007h
Return: AX = 0000h melodic
	   = 0001h percussive
SeeAlso: SI=0006h
----------65----SI000C-----------------------
INT 65 - Ad Lib SOUND.COM - SET ACTIVE VOICE
	SI = 000Ch
	ES:BX -> WORD voice = 0000h to 0008h
SeeAlso: SI=000Dh
----------65----SI000D-----------------------
INT 65 - Ad Lib SOUND.COM - GET ACTIVE VOICE
	SI = 000Dh
Return: AX = voice (0000h to 0008h)
SeeAlso: SI=000Ch
----------66---------------------------------
INT 66 - reserved for user interrupt
----------66---------------------------------
INT 66 - Adaptec controllers - DRIVE 1 DATA
SeeAlso: INT 65"Adaptec"
----------66---------------------------------
INT 66 - Data General DG10 - MicroECLIPSE COPROCESSOR INTERFACE
----------66FFFBBXFFFB-----------------------
INT 66 - MicroHelp Stay-Res Plus - ???
	AX = FFFBh
	BX = FFFBh
	???
Return: ???
SeeAlso: AX=FFFEh
----------66FFFEBXFFFE-----------------------
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
SeeAlso: AX=FFFBh,AX=FFFFh
----------66FFFFBXFFF0-----------------------
INT 66 - MicroHelp Stay-Res Plus - FIND PROGRAM NAME
	AX = FFFFh
	BX = FFF0h
Return: DI = offset of program name in interrupt handler segment
SeeAlso: AX=FFFBh,AX=FFFEh
----------660688-----------------------------
INT 66 - John W. Ratcliff (The IBM Digitized Sound Package)
	AX = 0688h
	???
Return: ???
----------660689-----------------------------
INT 66 - John W. Ratcliff (The IBM Digitized Sound Package)
	AX = 0689h
	???
Return: ???
----------67---------------------------------
INT 67 - Adaptec controllers - DRIVE 1 DATA
SeeAlso: INT 66"Adaptec"
----------6700-------------------------------
INT 67 - PC-NET, Alloy NTNX - LOCK SEMAPHORE AND WAIT
	AH = 00h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status
	    00h successful
	    01h invalid function
	    02h semaphore already locked
	    03h unable to lock semaphore
	    04h semaphore space exhausted
	AH = semaphore owner if status=02h
SeeAlso: AH=01h,AH=02h,INT 7F/AH=00h
----------6701-------------------------------
INT 67 - PC-NET, Alloy NTNX - LOCK SEMAPHORE
	AH = 01h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see AH=00h)
	AH = semaphore owner if status=02h
SeeAlso: AH=00h,AH=02h,INT 7F/AH=01h"Alloy"
----------6702-------------------------------
INT 67 - PC-NET, Alloy NTNX - UNLOCK SEMAPHORE
	AH = 02h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see AH=00h)
	AH = semaphore owner if status=02h
SeeAlso: AH=00h,AH=01h,INT 7Fh/AH=02h
----------6740-------------------------------
INT 67 - LIM EMS - GET MANAGER STATUS
	AH = 40h
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested by application
Note:	this call can be used only after establishing that the EMS driver is in
	  fact present
----------6741-------------------------------
INT 67 - LIM EMS - GET PAGE FRAME SEGMENT
	AH = 41h
Return: AH = 00h function successful
	    BX = segment of page frame
	AH = error code (see AH=40h)
----------6742-------------------------------
INT 67 - LIM EMS - GET NUMBER OF PAGES
	AH = 42h
Return: AH = 00h function successful
	    BX = number of unallocated pages
	    DX = total number of pages
	AH = error code (see AH=40h)
----------6743-------------------------------
INT 67 - LIM EMS - GET HANDLE AND ALLOCATE MEMORY
	AH = 43h
	BX = number of logical pages to allocate
Return: AH = status
	    00h function successful
		DX = handle
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested
	    85h no more handles available
	    87h more pages requested than physically exist
	    88h more pages requested than currently available
	    89h zero pages requested
SeeAlso: AH=45h
----------6744-------------------------------
INT 67 - LIM EMS - MAP MEMORY
	AH = 44h
	AL = physical page number (0-3)
	BX = logical page number
	DX = handle
Return: AH = status
	    00h function successful
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h undefined function requested
	    8Ah invalid logical page number
	    8Bh illegal physical-page number
SeeAlso: AH=69h
----------6745-------------------------------
INT 67 - LIM EMS - RELEASE HANDLE AND MEMORY
	AH = 45h
	DX = EMM handle
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h undefined function requested
	    86h error in save or restore of mapping context
SeeAlso: AH=43h
----------6746-------------------------------
INT 67 - LIM EMS - GET EMM VERSION
	AH = 46h
Return: AH = status
	    00h successful
		AL = EMM version number
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested
----------6747-------------------------------
INT 67 - LIM EMS - SAVE MAPPING CONTEXT
	AH = 47h
	DX = handle
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h undefined function requested
	    8Ch page-mapping hardware state save area is full
	    8Dh save of mapping context failed
SeeAlso: AH=47h
----------6748-------------------------------
INT 67 - LIM EMS - RESTORE MAPPING CONTEXT
	AH = 48h
	DX = handle
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h undefined function requested
	    8Eh restore of mapping context failed
SeeAlso: AH=47h
----------6749-------------------------------
INT 67 - LIM EMS - reserved - GET I/O PORT ADDRESSES
	AH = 49h
Note:	defined in EMS 3.0, but undocumented in EMS 3.2
----------674A-------------------------------
INT 67 - LIM EMS - reserved - GET TRANSLATION ARRAY
	AH = 4Ah
Note:	defined in EMS 3.0, but undocumented in EMS 3.2
----------674B-------------------------------
INT 67 - LIM EMS - GET NUMBER OF EMM HANDLES
	AH = 4Bh
Return: AH = status
	    00h successful
		BX = number of EMM handles
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h undefined function requested
----------674C-------------------------------
INT 67 - LIM EMS - GET PAGES OWNED BY HANDLE
	AH = 4Ch
	DX = EMM handle
Return: AH = status
	    00h successful
		BX = number of logical pages
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h undefined function requested
SeeAlso: AH=4Dh
----------674D-------------------------------
INT 67 - LIM EMS - GET PAGES FOR ALL HANDLES
	AH = 4Dh
	ES:DI -> array to receive information
Return: AH = status
	    00h successful
		BX = number of active EMM handles
		array filled with 2-word entries, consisting of a handle
		  and the number of pages allocated to that handle
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested
SeeAlso: AH=4Ch
----------674E-------------------------------
INT 67 - LIM EMS - GET OR SET PAGE MAP
	AH = 4Eh
	AL = 00h if getting mapping registers
	     01h if setting mapping registers
	     02h if getting and setting mapping registers at once
	     03h if getting size of page-mapping array
	DS:SI -> array holding information (AL=01/02)
	ES:DI -> array to receive information (AL=00/02)
Return: AH = status
	    00h successful
		AL = bytes in page-mapping array (AL=03h only)
		array pointed to by ES:DI receives mapping info (AL=00h/02h)
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested
	    8Fh undefined subfunction parameter
	    A3h contents of source array corrupted (EMS 4.0?)
Note:	this function was designed to be used by multitasking operating systems
	  and should not ordinarily be used by appplication software.
SeeAlso: AH=4Fh
----------674F-------------------------------
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
----------6750-------------------------------
INT 67 - LIM EMS 4.0 - MAP/UNMAP MULTIPLE HANDLE PAGES
	AH = 50h
	AL = subfunction
	    00h
	    01h
	DX = handle
	CX = number of entries in array
	DS:SI -> mapping array
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
----------6751-------------------------------
INT 67 - LIM EMS 4.0 - REALLOCATE PAGES
	AH = 51h
	DX = handle
	BX = number of pages to be allocated to handle
Return: BX = actual number of pages allocated to handle
	AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h undefined function requested
	    87h more pages requested than present in system
	    88h more pages requested than currently available
----------6752-------------------------------
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
Return:	AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h undefined function requested
	    8Fh undefined subfunction
	    90h undefined attribute type
	    91h feature not supported
SeeAlso: AH=53h
----------6753-------------------------------
INT 67 - LIM EMS 4.0 - GET/SET HANDLE NAME
	AH = 53h
	AL = subfunction
	    00h get handle name
	       ES:DI -> 8-byte handle name array
	    01h set handle name
	       DS:SI -> 8-byte handle name
	DX = handle
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h undefined function requested
	    8Fh undefined subfunction
	    A1h duplicate handle name
SeeAlso: AH=52h
----------6754-------------------------------
INT 67 - LIM EMS 4.0 - GET HANDLE DIRECTORY
	AH = 54h
	AL = subfunction
	    00h get handle directory
	       ES:DI -> buffer for handle directory
	    01h search for named handle
	       DS:SI -> 8-byte name
	    02h get total number of handles
Return: AL = number of entries in handle directory (subfunction 00h)
	DX = value of named handle (subfunction 01h)
	BX = total number of handles (subfunction 02h)
	AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested
	    8Fh undefined subfunction
	    A0h no such handle name
	    A1h a handle found had no name
----------6755-------------------------------
INT 67 - LIM EMS 4.0 - ALTER PAGE MAP AND JUMP
	AH = 55h
	AL = subfunction
	    00h physical page numbers provided by caller
	    01h segment addresses provided by caller
	DX = handle
	DS:SI -> structure containing map and jump address
Return: (at target address unless error)
	AH = status
	    00h successful
	    80h internal error
	    81h hardware failure
	    83h invalid handle
	    84h undefined function requested
	    8Ah invalid logical page number encountered
	    8Bh invalid physical page number encountered
	    8Fh invalid subfunction
SeeAlso: AH=56h
----------6756-------------------------------
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
----------6757-------------------------------
INT 67 - LIM EMS 4.0 - MOVE/EXCHANGE MEMORY REGION
	AH = 57h
	AL = subfunction
	    00h move memory region
	    01h exchange memory region
	DS:SI -> structure describing source and destination (see below)
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware failure
	    83h invalid handle
	    84h undefined function requested
	    8Ah invalid logical page number encountered
	    8Fh undefined subfunction
	    92h successful, but a portion of the source region has been
		overwritten
	    93h length of source or destination region exceeds length of region
		allocated to either source or destination handle
	    94h conventional and expanded memory regions overlap
	    95h offset within logical page exceeds size of logical page
	    96h region length exceeds 1M
	    97h source and destination EMS regions have same handle and overlap
	    98h memory source or destination type undefined
	    A2h attempted to wrap around 1M conventional address space
Note:	source and destination may overlap for a move, in which case the copy
	  direction is chosen such that the destination receives an intact copy
	  of the source region

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
----------6758-------------------------------
INT 67 - LIM EMS 4.0 - GET MAPPABLE PHYSICAL ADDRESS ARRAY
	AH = 58h
	AL = subfunction
	    00h get mappable physical address array
		ES:DI -> buffer to be filled with array
	    01h get number of entries in m.p.a. array
Return: CX = number of entries in array
	AH = status
	    00h successful
	    80h internal error
	    81h hardware failure
	    84h undefined function requested
	    8Fh undefined subfunction
Note:	the returned array for subfunction 00h is filled in physical segment
	  address order

Format of mappable physical address entry:
Offset	Size	Description
 00h	WORD	physical page segment
 02h	WORD	physical page number
----------6759-------------------------------
INT 67 - LIM EMS 4.0 - GET EXPANDED MEMORY HARDWARE INFORMATION
	AH = 59h
	AL = subfunction
	    00h get hardware configuration array
		ES:DI -> buffer to be filled with array (see below)
	    01h get unallocated raw page count
		Return: BX = unallocated raw pages
			DX = total raw pages
Return:	AH = status
	    00h successful
	    80h internal error
	    81h hardware failure
	    84h undefined function requested
	    8Fh undefined subfunction
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
----------675A-------------------------------
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
----------675B-------------------------------
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
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested
	    8Fh undefined subfunction
	    9Ah specified alternate map register set not supported
	    9Bh all alternate map register sets currently allocated
	    9Ch alternate map register sets not supported
	    9Dh undefined or unallocated alternate map register set
	    A3h source array corrupted
	    A4h operating system denied access
Note:	this function is for use by operating systems only, and can be
	  enabled or disabled at any time by the operating system
----------675B-------------------------------
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
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested
	    8Fh undefined subfunction
	    9Ah specified DMA register set not supported
	    9Bh all DMA register sets currently allocated
	    9Ch alternate DMA sets not supported
	    9Dh undefined or unallocated DMA register set
	    9Eh dedicated DMA channels not supported
	    9Fh specified dedicated DMA channel not supported
	    A3h source array corrupted
	    A4h operating system denied access
Note:	this function is for use by operating systems only, and can be
	  enabled or disabled at any time by the operating system
----------675C-------------------------------
INT 67 - LIM EMS 4.0 - PREPARE EXPANDED MEMORY HARDWARE FOR WARM BOOT
	AH = 5Ch
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested
----------675D-------------------------------
INT 67 - LIM EMS 4.0 - ENABLE/DISABLE OS FUNCTION SET FUNCTIONS
	AH = 5Dh
	AL = subfunction
	    00h enable OS Function Set
	    01h disable OS Function Set
	    02h return access key (resets memory manager, returns access key at
		next invocation)
	BX,CX = access key returned by first invocation
Return: BX,CX = access key, returned only on first invocation of function
	AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested
	    8Fh undefined subfunction
	    A4h operating system denied access
----------6760-------------------------------
INT 67 - EEMS - GET PHYSICAL WINDOW ARRAY
	AH = 60h
	ES:DI -> buffer
Return: AH = status
	AL = number of entries
	buffer at ES:DI filled
----------6761-------------------------------
INT 67 - EEMS - GENERIC ACCELERATOR CARD SUPPORT
	AH = 61h
	???
Return: ???
Note:	can be used by accelerator card manufacturer to flush RAM cache,
	  ensuring that the cache accurately reflects what the processor would
	  see without the cache.
----------6768-------------------------------
INT 67 - EEMS - GET ADDRESSES OF ALL PAGE FRAMES IN SYSTEM
	AH = 68h
	ES:DI -> buffer
Return: AH = status
	AL = number of entries
	buffer at ES:DI filled
Note:	equivalent to LIM 4.0 function 58h
----------6769-------------------------------
INT 67 - EEMS - MAP PAGE INTO FRAME
	AH = 69h
	AL = frame number
	BX = page number
	DX = handle
Return: AH = status
Note:	similar to EMS function 44h
SeeAlso: AH=44h,AH=50h,AH=6Ah
----------676A-------------------------------
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
Return: AH = status
Note:	similar to EMS function 4Eh, except that a subrange of pages can be
	  specified
SeeAlso: AH=69h
----------67DE00-----------------------------
INT 67 - Virtual Control Program Interface - INSTALLATION CHECK
	AX = DE00h
Return: AH = 00h    VCPI is present
	    BH = major version number
	    BL = minor version number
	AH nonzero  VCPI not present
----------67DE01-----------------------------
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
----------67DE02-----------------------------
INT 67 - Virtual Control Program Interface - GET MAX PHYSICAL MEMORY ADDRESS
	AX = DE02h
Return: AH = 00h  successful
	    EDX = physical address of highest 4K memory page
	AH nonzero: failed
----------67DE03-----------------------------
INT 67 - Virtual Control Program Interface - GET NUMBER OF FREE 4K PAGES
	AX = DE03h
Return: AH = 00h  successful
	    EDX = number of free 4K pages
	AH nonzero: failed
Notes:	returns total number of pages available to ALL tasks in system
	also available in protected mode by calling the protected-mode VCPI
	  entry point
SeeAlso: AX=DE04h
----------67DE04-----------------------------
INT 67 - Virtual Control Program Interface - ALLOCATE A 4K PAGE
	AX = DE04h
Return: AH = 00h successful
	    EDX = physical address of allocated page
	AH nonzero: failed
Notes:	the client program is responsible for freeing all memory allocated
	  with this call before terminating
	also available in protected mode by calling the protected-mode VCPI
	  entry point
SeeAlso: AX=DE03h,AX=DE05h
----------67DE05-----------------------------
INT 67 - Virtual Control Program Interface - FREE 4K PAGE
	AX = DE05h
	EDX = physical address of 4K page
Return: AH = 00h successful
	AH nonzero: failed
Note:	also available in protected mode by calling the protected-mode VCPI
	  entry point
SeeAlso: AX=DE04h
----------67DE06-----------------------------
INT 67 - Virtual Control Program Interface - GET PHYS ADDR OF PAGE IN FIRST MB
	AX = DE06h
	CX = page number (linear address shifted right 12 bits)
Return: AH = 00h successful
	    EDX = physical address of page
	AH nonzero: invalid page number (AH = 8Bh recommended)
----------67DE07-----------------------------
INT 67 - Virtual Control Program Interface - READ CR0
	AX = DE07h
Return: AH = 00h
	EBX = value of Control Register 0
SeeAlso: AX=DE07h
----------67DE08-----------------------------
INT 67 - Virtual Control Program Interface - READ DEBUG REGISTERS
	AX = DE08h
	ES:DI -> array of 8 DWORDs
Return: AH = 00h
	buffer filled with DR0 first, DR7 last, DR4 and DR5 unused
SeeAlso: AX=DE09h
----------67DE09-----------------------------
INT 67 - Virtual Control Program Interface - SET DEBUG REGISTERS
	AX = DE09h
	ES:DI -> array of 8 DWORDs holding new values of debug registers
Return: AH = 00h
Note:	values for DR4 and DR5 ignored
SeeAlso: AX=DE08h
----------67DE0A-----------------------------
INT 67 - Virtual Control Program Interface - GET 8259 INTERRUPT VECTOR MAPPINGS
	AX = DE0Ah
Return: AH = 00h successful
	    BX = first vector used by master 8259 (IRQ0)
	    CX = first vector used by slave 8259 (IRQ8)
	AH nonzero: failed
Note:	CX is undefined in systems without a slave 8259
SeeAlso: AX=DE0Bh
----------67DE0B-----------------------------
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
SeeAlso: AX=DE0Ah
----------67DE0C-----------------------------
INT 67 - Virtual Control Program Interface - SWITCH TO PROTECTED MODE
	AX = DE0Ch
	ESI = linear address in first megabyte of values for system registers
	interrupts disabled
Return: interrupts disabled
	GDTR, IDTR, LDTR, TR loaded
	SS:ESP must have at least 16 bytes space, and the entry point is
		required to set up a new stack before enabling interrupts
	EAX, ESI, DS, ES, FS, GS destroyed
SeeAlso: INT 15/AH=89h

Note:	in protected mode, calling the protected-mode VCPI entry point with 
	  AX = DE0Ch
	  DS = segment selector from function DE01h
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
----------67---------------------------------
INT 67 - Sangoma CCPOP 3270 resident module
----------6801-------------------------------
INT 68 - APPC/PC
	AH = 01h
	DS:DX -> control block

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	verb (action)
 0Eh  6 BYTEs	00h
 14h	DWORD	(high byte first) return code (see below)
---if verb = 1B00h (DISPLAY)---
 18h	WORD	00h
 1Ah  8 BYTEs	(high byte first) logical unit ID
 22h  8 BYTEs	(high byte first) partner logical unit name
 2Ah  8 BYTEs	(high byte first) mode name
 32h	BYTE	logical unit session limit
 33h	BYTE	partner logical unit session limit
 34h	BYTE	mode maximum negotiable session limit
 35h	BYTE	current session limit
 36h	BYTE	minimum negotiated winner limit
 37h	BYTE	maximum negotiated loser limit
 38h	BYTE	active session count
 39h	BYTE	active CONWINNER session count
 3Ah	BYTE	active CONLOSER session count
 3Bh	BYTE	session termination count
 3Ch	BYTE	bit 7: SESSION_TERMINATION_TARGET_DRAIN
		bit 6: SESSION_TERMINATION_SOURCE_DRAIN
---if verb=2000h (Attach Physical Unit)---
 18h	WORD	00h
 1Ah	BYTE	version
 1Bh	BYTE	release
 1Ch  8 BYTEs	(high byte first) net name
 24h  8 BYTEs	(high byte first) physical unit name
 2Ch  8 BYTEs	00h
 34h	DWORD	pointer to SYSTEM_LOG_EXIT routine, FFFFFFFFh=don't log errors
 38h	DWORD	00h
 3Ch	BYTE	00h RETURN_CONTROL: COMPLETE
		01h RETURN_CONTROL: INCOMPLETE
---if verb=2100h (Attach Logical Unit)---
 18h	WORD	70  offset to partner logical unit record
 1Ah  8 BYTEs	(high byte first) logical unit name
 22h  8 BYTEs	(high byte first) logical unit ID
 2Ah	BYTE	logical unit local address
 2Bh	BYTE	logical unit session limit
 2Ch	DWORD	pointer to CREATE_TP_EXIT routine,
		FFFFFFFFh = reject incoming ALLOCATEs
		00000000h = queue ALLOCATEs
 30h	DWORD	00h
 34h	DWORD	pointer to SYSTEM_LOG_EXIT routine, FFFFFFFFh=don't log errors
 38h	DWORD	00h
 3Ch	BYTE	maximum TPs
 3Dh	BYTE	queue depth
 3Eh	DWORD	pointer to LU_LU_PASSWORD_EXIT routine, FFFFFFFFh=no pswd exit
 42h	DWORD	00h
 46h	WORD	total length of partner records
    for each partner logical unit:
	WORD	length of this partner logical unit record
	WORD	42  offset to mode records
      8 BYTEs	(high byte first) partner logical unit name
	BYTE	partner logical unit security capabilities
		bit 7: already verified
		bit 6: conversation level security
		bit 5: session level security
	BYTE	partner logical unit session limit
	WORD	partner logical unit maximum MC_SEND_LL
      8 BYTEs	(high byte first) partner logical unit DLC name
	BYTE	partner logical unit adapter number
     17 BYTEs	(counted string) partner logical unit adapter address
	WORD	total length of mode records
   for each mode:
	WORD	16  length of this mode record
      8 BYTEs	(high byte first) mode name
	WORD	RU_SIZE high bound
	WORD	RU_SIZE low bound
	BYTE	mode maximum negotiable session limit
	BYTE	pacing size for receive
---if verb=2200h (Detach Logical Unit)---
 18h  8 BYTEs	(high byte first) logical unit ID
 20h	BYTE	00h
---if verb=2700h (Detach Physical Unit)---
 18h	BYTE	00h  type: hard
		01h  type: soft
---if verb=2B00h (Activate DLC)---
 18h  8 BYTEs	(high byte first) DLC name
 20h	BYTE	adapter number

Values for return code:
	 0000h	successful
	 0001h	BAD_TP_ID
	 0002h	BAD_CONV_ID
	 0003h	bad logical unit ID
	 0008h	no physical unit attached
	 0110h	bad state
	 01B1h	BAD_PART_LUNAME
	 01B2h	bad mode name
	 0201h	physical unit already active
	 0211h	logical unit already active
	 0212h	BAD_PART_SESS
	 0213h	BAD_RU_SIZES
	 0214h	BAD_MODE_SESS
	 0216h	BAD_PACING_CNT
	 0219h	EXTREME_RUS
	 021Ah	SNASVCMG_1
	 0223h	SSCP_CONNECTED_LU
	 0230h	invalid change
	 0243h	too many TPs
	 0272h	adapter close failure
	 0281h	GET_ALLOC_BAD_TYPE
	 0282h	unsuccessful
	 0283h	DLC failure
	 0284h	unrecognized DLC
	 0286h	duplicate DLC
	 0301h	SSCP_PU_SESSION_NOT_ACTIVE
	 0302h	data exceeds RU size
	 0401h	invalid direction
	 0402h	invalid type
	 0403h	segment overlap
	 0404h	invalid first character
	 0405h	table error
	 0406h	conversion error
     F0010000h	APPC disabled
     F0020000h	APPC busy
     F0030000h	APPC abended
     F0040000h	incomplete

Routines defined by LU_LU_PASSWORD_EXIT, CREATE_TP_EXIT, and SYSTEM_LOG_EXIT
pointers are called by pushing the DWORD pointer to the verb on the stack and
then performing a FAR call.

Format of ACCESS_LU_LU_PW verb:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1900h
 0Eh  8 BYTEs	(high byte first) logical unit ID
 16h  8 BYTEs	(high byte first) logical unit name
 1Eh  8 BYTEs	(high byte first) partner logical unit name
 26h 17 BYTEs	(counted string) partner fully qualified logical unit name
 37h	BYTE	password available (0=no, 1=yes)
 38h  8 BYTEs	password

Format of CREATE_TP verb:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2300h
 0Eh  6 BYTEs	00h
 14h	DWORD	(high byte first) sense code
		00000000h	Ok
		080F6051h	SECURITY_NOT_VALID
		084B6031h	TP_NOT_AVAIL_RETRY
		084C0000h	TP_NOT_AVAIL_NO_RETRY
		10086021h	TP_NAME_NOT_RECOGNIZED
		10086034h	CONVERSATION_TYPE_MISMATCH
		10086041h	SYNC_LEVEL_NOT_SUPPORTED
 18h  8 BYTEs	(high byte first) TP ID
 20h  8 BYTEs	(high byte first) logical unit ID
 28h	DWORD	(high byte first) conversation ID
 2Ch	BYTE	0 basic conversation, 1 mapped conversation
 2Dh	BYTE	0 no sync level, 1 confirm
 2Eh	BYTE	reserved
 2Fh 65 BYTEs	(counted string) transaction program name
 70h  6 BYTEs	00h
 76h	WORD	length of ERROR_LOG_DATA to return
 78h	DWORD	pointer to ERROR_LOG_DATA buffer
 7Ch  8 BYTEs	(high byte first) partner logical unit name
 84h 18 BYTEs	(counted string) partner fully qualified logical unit name
 96h  8 BYTEs	(high byte first) mode name
 9Eh 12 BYTEs	00h
 AAh 11 BYTEs	(counted string) password
 B5h 11 BYTEs	(counted string) user ID
 C0h	BYTE	0 verification should be performed
		1 already verified

Format of SYSLOG verb:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2600h
 0Eh 10 BYTEs	00h
 18h	WORD	(high byte first) type
 1Ah	DWORD	(high byte first) subtype
 1Eh	DWORD	pointer to ADDITIONAL_INFO
 22h	DWORD	(high byte first) conversation ID
 26h  8 BYTEs	(high byte first) TP ID
 2Eh  8 BYTEs	(high byte first) physical unit or logical unit name
 36h	WORD	length of data
 38h	DWORD	pointer to data
 3Ch	BYTE	00h
----------6802-------------------------------
INT 68 - APPC/PC
	AH = 02h
	DS:DX -> control block

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	verb (action)
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(high byte first) primary return code (see below)
 16h	DWORD	(high byte first) error code (see below)
 1Ah  8 BYTEs	(high byte first) TP_ID
 22h	DWORD	(high byte first) conversation ID
---if verb=0100h (Allocate or MC_Allocate)---
 26h	BYTE	(MC_Allocate only) 0 basic conversation
				   1 mapped conversation
 27h	BYTE	00h SYNC_LEVEL = none
		01h SYNC_LEVEL = confirm
 28h	WORD	0000h
 2Ah	BYTE	00h RETURN_CONTROL: when session allocated
		01h RETURN_CONTROL: immediate
		02h RETURN_CONTROL: when session free
 2Bh  8 BYTEs	00h
 33h  8 BYTEs	(high byte first) partner logical unit name
 3Bh  8 BYTEs	(high byte first) mode name
 43h 65 BYTEs	(counted string) TP name
 84h	BYTE	00h security: none
		01h security: same
		02h security: pgm
 85h 11 BYTEs	00h
 90h 11 BYTEs	(counted string) password
 9Bh 11 BYTEs	(counted string) user ID
 A6h	WORD	PIP_DATA length
 A8h	DWORD	pointer to PIP_DATA
---if verb=0300h (Confirm or MC_Confirm)---
 26h	BYTE  request to send received (0=no, 1=yes)
---if verb=0400h (Confirmed or MC_Confirmed), no additional fields---
---if verb=0500h (Deallocate or MC_Deallocate)---
 26h	BYTE	00h
 27h	BYTE	type 0 SYNC_LEVEL
		     1 FLUSH
		     2 ABEND_PROC
		     3 ABEND_SVC
		     4 ABEND_TIMER
		     5 ABEND
 28h	WORD	(MC_Deallocate only) length of error log data
 2Ah	DWORD	(MC_Deallocate only) pointer to error log data
---if verb=0600h (Flush or MC_Flush), no additional fields---
---if verb=0700h (Get_Attributes or MC_Get_Attributes)---
 26h  8 BYTEs	(high byte first) logical unit ID
 2Eh	BYTE	00h
 2Fh	BYTE	SYNC_LEVEL (0=none, 1=confirm)
 30h  8 BYTEs	(high byte first) mode name
 38h  8 BYTEs	(high byte first) own net name
 40h  8 BYTEs	(high byte first) own logical unit name
 48h  8 BYTEs	(high byte first) partner logical unit name
 50h 18 BYTEs	(counted string) partner's fully qualified logical unit name
 62h	BYTE	00h
 63h 11 BYTEs	(counted string) user ID
---if verb=0800h (Get_Type)---
 26h	BYTE	type (0=basic conversation, 1=mapped conversation)
---if verb=0900h (Post_on_Receipt)---
 26h	WORD	maximum length
 28h	BYTE	fill (0=buffer, 1=LL)
---if verb=0A00h (Prepare_to_Receive or MC_Prepare_to_Receive)---
 26h	BYTE	type (0=SYNC_LEVEL, 1=FLUSH)
 27h	BYTE	locks (0=short, 1=long)
---if verb=0B00h (Receive_and_Wait or MC_Receive_and_Wait)---
 26h	BYTE	what received
		00h data
		01h data complete
		02h data incomplete
		03h confirm
		04h confirm send
		05h confirm deallocate
		06h send
 27h	BYTE	(MC_Receive_and_Wait only) fill (0=buffer, 1=LL)
 28h	BYTE	Request_to_Send_Received (0=no, 1=yes)
 29h	WORD	maximum length
 2Bh	WORD	data length
 2Dh	DWORD	pointer to data
---if verb=0C00h (Receive_Immediate or MC_Receive_Immediate)---
 26h	BYTE	what received
		00h data
		01h data complete
		02h data incomplete
		03h confirm
		04h confirm send
		05h confirm deallocate
		06h send
 27h	BYTE	(MC_Receive_Immediate only) fill (0=buffer, 1=LL)
 28h	BYTE	Request_to_Send_Received (0=no, 1=yes)
 29h	WORD	maximum length
 2Bh	WORD	data length
 2Dh	DWORD	pointer to data
---if verb=0E00h (Request_to_Send or MC_Request_to_Send), no other fields---
---if verb=0F00h (Send_Data or MC_Send_Data)---
 26h	BYTE	request to send received (0=no, 1=yes)
 27h	BYTE	00h
 28h	WORD	data length
 2Ah	DWORD	pointer to data
---if verb=1000h (Send_Error or MC_Send_Error)---
 26h	BYTE	request to send received (0=no, 1=yes)
 27h	BYTE	type (0=program, 1=SVC)
 28h	DWORD	00h
 2Ch	WORD	(MC_Send_Error only) LOG_DATA length
 2Eh	DWORD	(MC_Send_Error only) pointer to LOG_DATA
---if verb=1200h (Test or MC_Test)---
 26h	BYTE	(MC_Test only) test (0=posted, 1=request_to_send received)
		Note: error code has different interpretations for:
			0 posted data
			1 posted not data (primary return code = 0)
			1 bad TP_ID (primary return code = 1)
---if verb=1300h (Wait)---
 26h	BYTE	number of conversations to wait on
		Note: error codes have interpretations as for 1200h above

Values for primary return code:
 0000h	successful
 0001h	parameter check
 0002h	state check
 0003h	allocation error
 0005h	deallocate abended
 0006h	deallocate abended program
 0007h	deallocate abended SVC
 0008h	deallocate abended timer
 0009h	deallocate normal return
 000Ah	data posting blocked
 000Bh	posting not active
 000Ch	PROG_ERROR_NO_TRUNC
 000Dh	PROG_ERROR_TRUNC
 000Eh	PROG_ERROR_PURGING
 000Fh	CONV_FAILURE_RETRY
 0010h	CONV_FAILURE_NO_RETRY
 0011h	SVC_ERROR_NO_TRUNC
 0012h	SVC_ERROR_TRUNC
 0013h	SVC_ERROR_PURGING
 0014h	unsuccessful
 0018h	CNOS partner logical unit reject
 0019h	conversation type mixed
 F001h	APPC disabled
 F002h	APPC busy
 F003h	APPC abended
 F004h	incomplete

Values for error code:
 0001h bad TP ID
 0002h bad conversation ID
 0004h allocation error, no retry
 0005h allocation error, retry
 0006h data area crosses segment boundary
 0010h bad TPN length
 0011h bad CONV length
 0012h bad SYNC level
 0013h bad security selection
 0014h bad return control
 0015h SEC_TOKENS too big
 0016h PIP_LEN incorrect
 0017h no use of SNASVCMG
 0018h unknown partner mode
 0031h confirm: SYNC_NONE
 0032h confirm: bad state
 0033h confirm: NOT_LL_BDY
 0041h confirmed: bad state
 0051h deallocate: bad type
 0052h deallocate: flush bad state
 0053h deallocate: confirm bad state
 0055h deallocate: NOT_LL_BDY
 0057h deallocate: log LL_WRONG
 0061h flush: not send state
 0091h post on receipt: invalid length
 0092h post on receipt: not in receive state
 0093h post on receipt: bad fill
 00A1h prepare to receive:invalid type
 00A2h prepare to receive: unfinished LL
 00A3h prepare to receive: not in send state
 00B1h receive and wait: bad state
 00B2h receive and wait: NOT_LL_BDY
 00B5h receive and wait: bad fill
 00C1h receive immediate: not in receive state
 00C4h receive immediate: bad fill
 00E1h request to send: not in receive state
 00F1h send data: bad LL
 00F2h send data: not in send state
 0102h send error: log LL wrong
 0103h send error: bad type
 0121h test: invalid type
 0122h test: not in receive state
----------6803-------------------------------
INT 68 - APPC/PC
	AH = 03h
	DS:DX -> control block (see below)

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	verb (action)
 0Eh  6 BYTEs	0
 14h	DWORD	(high byte first) return code (see AH=01h)
 18h	WORD	0
 1Ah  8 BYTEs	(high byte first) logical unit ID
---if verb=2400h (TP Started), control block continues---
 22h  8 BYTEs	(high byte first) TP ID
---if verb=2800h (Get ALLOCATE), control block continues---
 22h	BYTE	type
		00h dequeue
		01h test
 23h	DWORD	pointer to CREATE_TP record
---if verb=2A00h (Change Logical Unit). control block continues---
 22h	DWORD	pointer to CREATE_TP_EXIT routine
		FFFFFFFFh reject incoming ALLOCATEs
		00000000h queue ALLOCATEs
 26h	DWORD	00000000h
 2Ah	DWORD	pointer to SYSTEM_LOG_EXIT routine, FFFFFFFFh= don't log errors
 2Eh	DWORD	00000000h
 32h	BYTE	maximum TPs
 33h	BYTE	00h stop QUEUE_ALLOCATEs
		01h resume QUEUE_ALLOCATEs
 34h	DWORD	pointer to LU_LU_PASSWORD_EXIT routine, FFFFFFFFh = no exit
 38h	DWORD	00000000h
----------6804-------------------------------
INT 68 - APPC/PC
	AH = 04h
	DS:DX -> control block (see below)

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	verb (action)
		2500h TP_ENDED
		2900h TP_VALID
 0Eh  6 BYTEs	0
 14h	DWORD	(high byte first) return code (see AH=01h)
 18h	WORD	0
 1Ah  8 BYTEs	(high byte first) TP_ID
 22h	DWORD -> CREATE_TP record (only if verb = 2900h)
----------6805-------------------------------
INT 68 - APPC/PC - TRANSFER MSG DATA
	AH = 05h
	DS:DX -> control block (see below)

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1C00h
 0Eh	BYTE	00h user defined
		01h NMVT
		02h alert subvectors
		03h PDSTATS subvectors
 0Fh  5 BYTEs	0
 14h	DWORD	(high byte first) return code (see AH=01h)
 18h 12 BYTEs	0
 24h	BYTE	if bit 0 clear, add correlation subvector
		if bit 1 clear, add product set ID subvector
		if bit 2 clear, do SYSLOG
		if bit 3 clear, send SSCP_PU_SESSION
 25h	BYTE	0
 26h	WORD	length of data
 28h  N BYTEs	data
----------6806-------------------------------
INT 68 - APPC/PC - CHANGE NUMBER OF SESSIONS
	AH = 06h
	DS:DX -> control block (see below)

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1500h
 0Eh  6 BYTEs	0
 14h	WORD	(high byte first) primary return code (see AH=02h)
 16h	DWORD	(high byte first) secondary return code (see below, AH=01h)
 1Ah  8 BYTEs	(high byte first) logical unit ID
 22h  8 BYTEs	blanks
 2Ah  8 BYTEs	(high byte first) partner logical unit name
 32h  8 BYTEs	(high byte first) mode name
 3Ah	BYTE	bit 7: use MODE_NAME_SELECT_ALL rather than MODE_NAME
		bit 6: set negotiable values
 3Bh	BYTE	partner logical unit mode session limit
 3Ch	BYTE	minimum CONWINNERS_SOURCE
 3Dh	BYTE	maximum CONWINNERS_TARGET
 3Eh	BYTE	automatic activation
 3Fh	BYTE	0
 40h	BYTE	bit 7: drain target
		bit 6: drain source
		bit 5: target responsible, not source

Values for secondary return code (see also AH=01h):
  0000h accepted
  0001h negotiated
  0003h bad logical unit ID
  0004h allocation failure, no retry
  0005h allocation failure, retry
  0151h can't raise limits
  0153h all modes must reset
  0154h bad SNASVCMG limits
  0155h minimum greater than total
  0156h mode closed (prim return code = 1)
	CNOS mode closed (prim return code = 18h)
  0157h bad mode name (prim return code = 1)
	CNOS bad mode name (prim return code = 18h)
  0159h reset SNA drains
  015Ah single not SRC response
  015Bh bad partner logical unit
  015Ch exceeds maximum allowed
  015Dh change SRC drains
  015Eh logical unit detached
  015Fh CNOS command race reject
----------6807-------------------------------
INT 68 - APPC/PC - PASSTHROUGH
	AH = 07h
	DS:DX -> control block (format depends on application subsystem)
----------68FA-------------------------------
INT 68 - APPC/PC - ENABLE/DISABLE APPC
	AH = FAh
	AL bit 0 = 0 enable
		   1 disable
----------68FB-------------------------------
INT 68 - APPC/PC - CONVERT
	AH = FBh
	DS:DX -> control block (see below)

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1A00h
 0Eh  6 BYTEs	0
 14h	DWORD	(high byte first) return code
 18h	BYTE	conversion
		   00h ASCII to EBCDIC
		   01h EBCDIC to ASCII
 19h	BYTE	character set
		   00h AE
		   01h A
		   02h G
 1Ah	WORD	length of string to convert
 1Ch	DWORD	pointer to source
 20h	DWORD	pointer to target
----------68FC-------------------------------
INT 68 - APPC/PC - ENABLE/DISABLE MESSAGE TRACING
	AH = FCh
	AL = 00h disable tracing
	   = 01h enable tracing
		DX = number of bytes to keep (0=all)
SeeAlso: AH=FDh
----------68FD-------------------------------
INT 68 - APPC/PC - ENABLE/DISABLE API VERB TRACING
	AH = FDh
	AL = 00h disable tracing
	     01h enable tracing
SeeAlso: AH=FCh,AH=FEh
----------68FE-------------------------------
INT 68 - APPC/PC - SET TRACE DESTINATION
	AH = FEh
	AL = trace destinations
	    bit 0  storage (DS:DX -> trace stats record)
	    bit 1  display
	    bit 2  file (trace written to file OUTPUT.PC)
	    bit 3  printer
SeeAlso: AH=FDh

Format of Trace Statistics Record:
Offset	Size	Description
 00h	DWORD	pointer to storage trace buffer
 04h	WORD	max number of 80-byte records in trace
 06h	WORD	(high-order byte first!) current record number (must init to 0)
 08h	DWORD	(high-order byte first!) number of records written (init to 0)
 0Ch	DWORD	reserved
Note:	do not move record while trace is active
----------68FF-------------------------------
INT 68 - APPC/PC - SET PASSTHROUGH
	AH = FFh
	DS:DX -> passthrough exit routine
----------68---------------------------------
INT 68 - Sangoma CCPOP 3270 resident module
----------69---------------------------------
INT 69 - Zenith AT BIOS - ???
   called by INT 09 handler
----------690100-----------------------------
INT 69 - DECnet DOS CTERM - INSTALLATION CHECK
	AX = 0100h
Return: AL = FFh if present
SeeAlso: AX=010Fh
----------690101-----------------------------
INT 69 - DECnet DOS CTERM - SEND BYTE
	AX = 0101h
	BL = character
	DX = session handle
Return: AH >= 80h on error
SeeAlso: AX=0102h
----------690102-----------------------------
INT 69 - DECnet DOS CTERM - READ BYTE
	AX = 0102h
	DX = session handle
Return: AH >= 80h on error
	AH < 80h if successful
	    AL = character
SeeAlso: AX=0101h
----------690103-----------------------------
INT 69 - DECnet DOS CTERM - STATUS
	AX = 0103h
	DX = session handle
Return: AH status flags
	    bit 7 session has been aborted
		6 DECnet error
		1 trace data available
		0 receive data available
	AL = reason code if DECnet error
	    00h normal disconnect
	    01h unknown message from host
	    02h protocol violation from host
	    03h could not process the initiate message
	    04h error receiving message from host
	    05h error sending message to host
	    06h error checking for message from host
	    07h remote system does not support CTERM
	    08h remote system does not support correct protocol version
	    09h did not receive BIND message from host
	    0Ah could not send BIND message to host
	    0Bh no more sessions available
	    0Ch session does not exist
	    0Dh not enough memory to complete operation
	    0Eh connection has broken
SeeAlso: AX=0104h
----------690104-----------------------------
INT 69 - DECnet DOS CTERM - DECnet STATUS
	AX = 0104h
	DX = session handle
Return: AX = reason code (see AX=0103h)
Note:	use this call when AX=0103h returns a DECnet error
SeeAlso: AX=0103h
----------690105-----------------------------
INT 69 - DECnet DOS CTERM - OPEN SESSION
	AX = 0105h
	DS:BX -> ASCIZ node name
	ES:DX -> buffer for session control block (see INT 6A/AH=D0h)
Return: AX <= 0 on error
	AX > 0 session handle
SeeAlso: AX=0103h,AX=0106h,AX=010Ah
----------690106-----------------------------
INT 69 - DECnet DOS CTERM - CLOSE SESSION
	AX = 0106h
	DX = session handle
Return: AH = 00h good close
	   other error code (see AX=0103h)
SeeAlso: AX=0103h,AX=0105h
----------69010A-----------------------------
INT 69 - DECnet DOS CTERM - GET SESSION CONTROL BLOCK SIZE
	AX = 010Ah
Return: AX = length of session control block in bytes
SeeAlso: AX=0105h
----------69010B-----------------------------
INT 69 - DECnet DOS CTERM - GET DECnet SOCKET
	AX = 010Bh
	DX = session handle
Return: AX > 0	DECnet socket for the session
	   = 0	no match for handle
----------69010F-----------------------------
INT 69 - DECnet DOS CTERM - DEINSTALL CTERM
	AX = 010Fh
Return: AH = 00h succesful uninstall
	   other error code
Note:	CTERM must have been the last TSR loaded in order to deinstall it
SeeAlso: AX=0100h
----------6A---------------------------------
INT 6A - OPTHELP.COM
Notes:	OPTHELP is an optionally-resident help system for SLR Systems's OPTASM
	  assembler
	may be configured to use any interrupt from 60h to 7Fh (default 6Ah)
----------6A---------------------------------
INT 6A - DECnet DOS - LOCAL AREA TRANSPORT PROGRAM
Note:	the 3 bytes preceding the interrupt handler are "LAT"; this serves as
	  the installation check
----------6A01--DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - SEND BYTE
	AH = 01h
	DH = FFh
	AL = character
	DL = handle
Return: AH >= 80h on error
SeeAlso: AH=02h
----------6A02--DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - READ BYTE
	AH = 02h
	DH = FFh
	DL = handle
Return: AH < 80h if successful
	    AL = character
	AH >= 80h on error
SeeAlso: AH=01h
----------6A03--DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - STATUS
	AH = 03h
	DH = FFh
	DL = handle
Return: AH = status flags
	    bit 5 transmit buffer empty
		3 session in start state
		2 session not active
		1 unable to queue transmit data
		0 receive data available
----------6AD0--DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - OPEN SESSION
	AH = D0h
	DH = FFh
	AL = FFh no password
	   = 0Fh password at ES:DI
	ES:BX -> LAT session control block (see below)
	ES:DI -> 16-byte blank-padded password
Return: AH = 00h success
	    DL = handle
SeeAlso: AX=D000h

Format of LAT Session Control Block:
Offset	Size	Description
 00h 18 BYTEs	service name
 12h 18 BYTEs	node name (future use)
 24h 18 BYTEs	port name (future use)
 36h	DWORD	-> session stopped post routine
 3Ah	DWORD	-> service table overflow post routine
 3Eh	DWORD	-> transmit post routine
 42h	DWORD	-> receive post routine
 46h	WORD	session status
		04h circuit failure
		08h stop slot received
 48h	WORD	slot state (LAT driver use)
 4Ah	WORD	local credits (LAT driver use)
 4Ch	DWORD	-> VCB (LAT driver use)
 50h	WORD	backward slot (LAT driver use)
 52h	WORD	forward slot (LAT driver use)
 54h	WORD	remote slot ID (LAT driver use)
 56h	WORD	local slot ID (LAT driver use)
 58h	WORD	slot byte count (LAT driver use)
 5Ah	BYTE	remote credits (LAT driver use)
 5Bh 255 BYTEs	transmitted data slot
15Ah	BYTE	number of receive data slots (4 recommended)
15Bh	BYTE	number of occupied slots
15Ch	BYTE	index of next receive slot to use
15Dh	BYTE	index of current receive slot
15Eh	WORD	pointer to first received character
160h  N WORDs	pointers to receive slots (buffers); each is 259 bytes
Note:	set post routines to 0000h:0000h if polled operation will be used
----------6AD000DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - CLOSE SESSION
	AX = D000h
	DH = FFh
	DL = handle
Return: AX = 0000h successful
	   = 0001h no such session
	   = 0002h session not running, try again later
SeeAlso: AH=D0h
----------6AD100DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - SEND BREAK
	AX = D100h
	DH = FFh
	DL = handle
Return: AX = 0000h if successful
	AH bit 7 set is unable to send break
----------6AD300DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - RESET LAT COUNTERS
	AX = D300h
	DH = FFh
SeeAlso: AX=D400h
----------6AD400DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - COPY LAT COUNTERS
	AX = D400h
	DH = FFh
	CX = buffer size
	ES:BX -> buffer for LAT counters
Return: AX = 0000h counters copied into buffer
	   = FFFFh buffer too small
SeeAlso: AX=D300h
----------6AD500DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - GET NEXT LAT SERVICE NAME
	AX = D500h
	DH = FFh
	ES:BX -> 17-byte buffer for name
Return: AH = 00h if successful
	   ES:BX buffer filled
	AX = FFFFh if end of table or no name available
Notes:	use this function to get the names of the hosts on the network
	successive calls are necessary to get all names
SeeAlso: AX=D600h
----------6AD600DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - LAT SERVICE TABLE RESET
	AX = D600h
	DH = FFh
Return: AX = number of service table entries
	BX = 0000h service table has not overflowed
	   = FFFFh service table has overflowed
SeeAlso: AX=D500h
----------6B0000-----------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - BUFFERED WRITE
	AX = 0000h
	CX = length
	ES:BX -> buffer
Return: CX = number of bytes written
SeeAlso: AX=0100h,INT 14/AH=19h
----------6B0100-----------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - BUFFERED READ
	AX = 0100h
	CX = length of buffer
	ES:BX -> buffer
Return: CX = number of bytes read
SeeAlso: AX=0000h,INT 14/AH=18h,INT 14/AX=FF02h
----------6B02-------------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - INSTALL CHECK
	AH = 02h
	AL nonzero
Return: AL = 00h if present and OK
SeeAlso: AX=0700h
----------6B0600-----------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - CONTROL
	AX = 0600h
	CX = command
	    02h send break
	    04h disconnect
	    06h hold
----------6B0700-----------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - GET STATUS
	AX = 0700h
Return: CH <> 00h if connection active
SeeAlso: AH=02h
----------6B6B-------------------------------
INT 6B - Tandy SCHOOLMATE PLUS - API
	AH = 6Bh
	AL = E0h to FFh
----------6B---------------------------------
INT 6B - "Saddam" virus - ???
SeeAlso: INT 21/AX=FFFFh,INT 60"virus",INT 70"virus"
----------6C---------------------------------
INT 6C - system resume vector (CONVERTIBLE)
----------6C---------------------------------
INT 6C - DOS 3.2 Realtime Clock update
----------6D---------------------------------
INT 6D - VGA - internal
Note:	used by IBM, Paradise, Video7, and NCR
----------6D---------------------------------
INT 6D - ATI VGA Wonder - VIDEO BIOS ENTRY POINT
   points at the original INT 10 entry point set up by the ATI BIOS
SeeAlso: INT 10
----------6D---------------------------------
INT 6D - DECnet DOS - DATA LINK LAYER PROGRAM
----------6E---------------------------------
INT 6E - DECnet DOS - DECnet NETWORK PROCESS API
Notes:	this is the main DECnet DOS access, and is described in Digital manual
	  AA-EB46B-TV ("DECnet-DOS Programmer's Reference Manual")
	there is a signature/data area immediately prior to the interrupt
	  handler which may be used as an installation check

Format of signature area:
Offset	Size	Description
 -5	BYTE	major version number
 -4	BYTE	minor version number
 -3   3 BYTEs	signature (ASCII "DNP")
----------6F----BP0012-----------------------
INT 6F - HP ES-12 EXTENDED BIOS - READ CMOS MEMORY
	BP = 0012h
	AH = 22h
	BL = address of CMOS byte to read
Return: AH = status
	AL = byte read
	BP, DS destroyed
SeeAlso: BP=0012h/AH=24h
----------6F----BP0012-----------------------
INT 6F - HP ES-12 EXTENDED BIOS - WRITE CMOS MEMORY
	BP = 0012h
	AH = 24h
	BL = address of CMOS byte to write
	AL = new value
Return: AH = status
	BP, DS destroyed
SeeAlso: BP=0012h/AH=22h
----------6F---------------------------------
INT 6F - Novell NetWare - PCOX API (3270 PC terminal interface)
----------6F00-------------------------------
INT 6F - 10-NET - LOGIN
	AH = 00h
	DS:DX -> login record (see below)
Return: CL = security level
	AX = status
	    0000h successful
	    01FFh time out on response
	    02FFh network (hardware) error
	    03FFh invalid password
	    04FFh local rexource not available
	    05FFh server resource not available
	    06FFh already logged in under different name
	    07FFh login security failure (node)
	    08FFh not logged in
	    09FFh position calc error
	    0AFFh receive subfunction not = send subfunction (i.e. read, write)
	    0BFFh request function not in range
	    0CFFh no more server file handle entries left
	    0DFFh no more shared file table entries left
	    0EFFh no more user file handle entries left
	    0FFFh chat permit not on
	    10FFh not a server on request
	    11FFh no transporter board error
	    12FFh time out on send
	    13FFh item not found (spool item not on queue)
	    14FFh dos access incompatible
	    15FFh record already locked
	    16FFh invalid parameter
	    17FFh record lock time out error
	    18FFh currently spooling to named device
	    19FFh dropped receive message (throttle)
	    1AFFh open sharing violation
	    1BFFh no more tuf entries left
	    1CFFh not file owner on open
	    1DFFh read security not passed
	    1EFFh write security not passed
	    1FFFh group security not passed
	    20FFh security file failure
	    21FFh activity file failure
	    22FFh spool cntrl file failure
	    23FFh device not mounted (spooling)
	    24FFh spool file has not been terminated
	    25FFh device not mounted or is not being shared
	    26FFh duplicate node id
	    27FFh file not found error
	    28FFh no more files
	    29FFh unknown internal system error
	    2AFFh print queue is full or corrupted
	    2BFFh invalid function
	    2CFFh invalid handle
	    2DFFh too many files opened
	    2EFFh path not found
	    2FFFh named file is active
/* I've gotten one submission which says FFxxh, and another with xxFFh */
/* I don't know which way around these should be, does somebody else know? */
	    FF01h timeout
	    FF02h network error
	    FF03h invalid password
	    FF04h no local buffer
	    FF05h superstation not available
	    FF06h node already logged in
	    FF07h login not valid from this node
	    FF08h node ID already in use
	    FF16h invalid parameter (bad length, invalid node ID, etc)
	    FF17h record locked by another user
	    FF18h sent message has been dropped
SeeAlso: AH=01h

Format of login record:
Offset	Size	Description
 00h  8 BYTEs	user name
 08h  8 BYTEs	password
 10h 12 BYTEs	name of SuperStation
----------6F01-------------------------------
INT 6F - 10-NET - LOGOFF
	AH = 01h
	DS:DX -> superstation ID or nulls (12 bytes)
Return: CX = number of files closed
	AX = status (see AH=00h)
	    FF08h superstation ID not already logged in
SeeAlso: AH=00h
----------6F02-------------------------------
INT 6F - 10-NET - STATUS OF NODE
	AH = 02h
	DS:DX -> 512-byte status record (see below)
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful

Format of node status record:
Offset	Size	Description
 00h  8 BYTEs	user name (0 if none)
 08h	BYTE	station type
		   00h workstation
		   01h superstation
		   02h gateway station
		   03h gateway active
		   04h logged into multiple superstations
		   05h reserved
 09h 24 BYTEs	list of superstations logged into more than one superstation
 21h 12 BYTEs	node ID
 2Dh	WORD	message count for this station (send for user node, receive for
		superstations)
---for superstations only---
 2Fh	WORD	drives allocated (bit 0=A:, bit 1=B:,...)
 31h	BYTE	user service flag
		bit 7: gate
		    6: print permit on
		    4: SUBMIT is on
		    3: mail waiting for node
		    2: calendar waiting for you
		    1: news waiting for you
		    0: mail waiting for you
 32h	BYTE	printers allocated (bit 0=LPT1,...)
 33h	BYTE	number of unprinted spool files
 34h	BYTE	number of opened files
 35h	BYTE	number of logged on nodes
 36h	BYTE	primary drive (1=A:)
 37h	BYTE	reserved
 38h  N BYTEs	list of logged on node IDs (each 12 bytes, max 37 IDs)
1F4h  3 BYTEs	time: sec/min/hrs
1F7h  3 BYTEs	date: day/mon/year-1980
----------6F03-------------------------------
INT 6F - 10-NET - GET ADDRESS OF CONFIGURATION TABLE
	AH = 03h
	DS:DI -> node ID (optional)
Return: ES:BX -> configuration table 
SeeAlso: AH=13h

Format of configuration table:
Offset	Size	Description
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
---up to here, 10-Net v3.3---
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
 1Fh	BYTE	CT_PSFLG
		bit 5: PRINT permit
		bit 4: KB initiated
		bit 3: CHAT called FOXPTRM
		bit 2: SUBMIT active
		bit 1: SUBMIT received
		bit 0: SUBMIT permit
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
---beyond here, 10-Net v3.3---
 47h	BYTE	bit 0 = RS232 gate
		    1 = Send6F gate (user set)
 48h	DWORD	pointer into gate (user set)
 4Ch	DWORD	pointer into 10Net send
 50h  N WORDs	addresses of timer blocks
----------6F04-------------------------------
INT 6F - 10-NET - SEND
	AH = 04h
	DS:BX -> record
		12 BYTEs receiving node's ID
			if first byte has high-order bit set, message is
			   directed to the CT_RGATE vector at the receiver
			if second byte is 00h, first byte is taken as a CB
			   channel number and delivered to all nodes on same
			   channel
		   WORD	 length of data at DX
	DS:DX -> data (max 1024 bytes)
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
SeeAlso: AH=05h
----------6F05-------------------------------
INT 6F - 10-NET - RECEIVE
	AH = 05h
	CX = number of seconds before timeout
	DS:DX -> receive buffer (see below)
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
	    AH = FEh if dequeued message is a CB message
SeeAlso: AH=04h

Format of receive buffer:
Offset	Size	Description
 00h 12 BYTEs	sending node's ID
 0Ch	WORD	length of message
 0Eh  N BYTEs	message (maximum 1024 bytes)
----------6F07-------------------------------
INT 6F - 10-NET - LOCK HANDLE
	AH = 07h
	BX = file handle
	CX:DX = starting offset in file
	SI = record length
Return: CF set on error
	    AX = error code (see also AH=00h)
		0002h file not found
	CF clear if successful
SeeAlso: AH=08h,INT 21/AH=5Ch
----------6F08-------------------------------
INT 6F - 10-NET - UNLOCK HANDLE
	AH = 08h
	BX = file handle
	AL = mode
	    00h unlock all
	    01h unlock record at CX:DX
Return: CF set on error
	    AX = error code (see also AH=00h)
		0002h file not found
	CF clear if successful
SeeAlso: AH=07h,INT 21/AH=5Ch
----------6F09-------------------------------
INT 6F - 10-NET - SUBMIT
	AH = 09h
	DS:BX -> submit record (see below)

Format of submit record:
Offset	Size	Description
 00h 12 BYTEs	destination node ID (must be logged in)
 0Ch	WORD	length+2 of following 'command line' text
 0Eh  N BYTEs	command line text (<=100 bytes), system adds CR
----------6F0A-------------------------------
INT 6F - 10-NET - CHAT
	AH = 0Ah
	DS:BX -> control parameters (see below)
	DS:DX -> chat message (see below)

Format of control parameters:
Offset	Size	Description
 00h  8 BYTEs	sender ID, defaults to node's userID if nulls
 08h  8 BYTEs	destination user ID, 'EVERYONE' may be used
 10h 12 BYTEs	destination node ID

Format of chat message:
Offset	Size	Description
 00h	WORD	length+2 of following text
 02h  N BYTEs	text, max 101 bytes
----------6F0B-------------------------------
INT 6F - 10-NET - LOCK SEMAPHORE, RETURN IMMEDIATELY
	AH = 0Bh
	AL = drive number or 0
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status
	    00h successful
	    01h semaphore currently locked
	    02h server not responding
	    03h invalid semaphore name
	    04h semaphore list is full
	    05h invalid drive ID
	    06h invalid Ethernet address
	    07h not logged in
	    08h write to network failed
	    09h semaphore already logged in this CPU
Note:	same as INT 60/AH=12h
SeeAlso: AH=0Ch,INT 60/AH=12h
----------6F0C-------------------------------
INT 6F - 10-NET - UNLOCK SEMAPHORE
	AH = 0Ch
	AL = drive number or 0
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see also AH=0Bh)
	    01h semaphore not locked
Note:	same as INT 60/AH=13h
SeeAlso: AH=0Bh,INT 60/AH=13h
----------6F0D-------------------------------
INT 6F - 10-NET - WHO
	AH = 0Dh
	AL = type code
	    01h return superstations only
	    02h return non-superstations only
	    otherwise return all
	CX = length of data
	DS:DX -> array of records to be filled (see below)
Return: CL = number of records returned (responding stations)

Format of station record:
Offset	Size	Description
 00h 12 BYTEs	node ID
 0Ch	BYTE	flags
		bit 1 = workstation
		    2 = superstation
		    3 = xgate
		    4 = active gate
---if AL = 01h---
 0Dh	BYTE	version number
	WORD	level number of 10Net software in responding node
---if AL = 02h---
 0Dh  8 BYTEs	user ID
 15h	BYTE	version number
 16h	WORD	level number
----------6F0E-------------------------------
INT 6F - 10-NET - SPOOL/PRINT
	AH = 0Eh
	DS:DX -> spool/print record (see below)
Return: CF set on error
	    AX = error code (see also AH=00h)
		FF17h device not mounted
		FF18h already spooling to named device
	CF clear if successful

Format of Spool/Print record:
Offset	Size	Description
 00h	WORD	operation code
		   00h initiate spool
		   01h abort print
		   02h close spool
		   03h delete spool
		   04h print
		   05h get report info
		   06h set chat template
		   07h queue
		   08h return queue
		   09h queue non-spooled file for printing
 02h 11 BYTEs	file name in FCB format
---if operation code = 00h or 06h---
 0Dh	BYTE	notification
		bit 7: queue to top
		bit 6: do ID page
		bit 5: no form feed
		bit 4: reserved
		bit 3: explicity queuing only
		bit 2: notify at print completion
		bit 1: notify server operator/reply
		bit 0: notify at print start
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
 11h	BYTE	code: 01h print device
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

Format of $SCNTL record:
Offset	Size	Description
 00h  8 BYTEs	user ID
 08h 11 BYTEs	filename in FCB format
 13h  6 BYTEs	node ID
 19h  3 BYTEs	creation date
 1Ch	BYTE	flags
		bit 7: queue to top
		    6: do ID page
		    5: no form feed at end
		    4: reserved
		    3: explicit queueing only
		    2: notify at completion
		    1: notify server operator/reply
		    0: notify at start
 1Dh	BYTE	retention time in days
 1Eh	BYTE	printing device (LPTx)
 1Fh  3 BYTEs	date last printed (0 = never)
 22h	BYTE	device containing spoolfile
 23h	WORD	bytes to print for test print
 25h	WORD	block number to start print
 27h	BYTE	reserved
----------6F10-------------------------------
INT 6F - 10-NET - ATTACH/DETACH PRINTER
	AH = 10h
	AL = subfunction
	    00h initiate spooling if LPT1 is mounted
	    01h terminate spooling if LPT1 is mounted
SeeAlso: INT 21/AX=5D08h
----------6F11-------------------------------
INT 6F - 10-NET - LOCK FCB
	AH = 11h
	AL = mode
	    01h sequential
	    02h random
	    03h random block
		CX = number of records
	DS:DX -> FCB (see INT 21/AH=0Fh)
Return: CF set on error
	    AX = error code (see also AH=00h)
		2 file not found
	CF clear if successful
SeeAlso: AH=12h
----------6F12-------------------------------
INT 6F - 10-NET - UNLOCK FCB
	AH = 12h
	AL = mode
	    00h sequential
	    01h random
	    02h random block
		CX = number of records
	DS:DX -> FCB (see INT 21/AH=0Fh)
Return: CF set on error
	    AX = error code (see also AH=00h)
		2 file not found
	CF clear if successful
SeeAlso: AH=11h
----------6F13-------------------------------
INT 6F - 10-NET v3.3 - GET REMOTE CONFIGURATION TABLE ADDRESS
	AH = 13h
	DS:DX -> node ID, 12 bytes blank-padded
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
	    ES:BX = configuration table address on given machine
SeeAlso: AH=03h
----------6F14-------------------------------
INT 6F - 10-NET v3.3 - GET REMOTE MEMORY
	AH = 14h
	BX:SI = address of remote memory
	CX = length (<=1024 bytes)
	DS:DX -> node ID, 12 bytes blank-padded
	DS:DI -> area to receive remote memory image
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
	    CX = amount of memory copied to DS:SI
----------6F1501-----------------------------
INT 6F - 10-NET v3.3 - GET SHARED DEVICE ENTRY
	AX = 1501h
	BX = zero-based index
	DS:SI -> node ID, 12 bytes blank-padded
	ES:DI -> 85-byte buffer for shared device table entry (see below)
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
	    ES:DI buffer contains shared device table entry of BXth device:
SeeAlso: AX=1502h,AX=1503h

Format of shared device table entry:
Offset	Size	Description
 00h  8 BYTEs	device
 08h  8 BYTEs	alias
 10h 64 BYTEs	path
 50h  8 BYTEs	password
 58h	BYTE	access
 59h  4 BYTEs	mask
----------6F1502-----------------------------
INT 6F - 10-NET v3.3 - SET SHARED DEVICE ENTRY
	AX = 1502h
	DS:SI -> node ID, 12 bytes blank-padded
	ES:DI -> valid shared device table entry
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
SeeAlso: AX=1501h,AX=1503h
----------6F1503-----------------------------
INT 6F - 10-NET v3.3 - DELETE SHARED DEVICE ENTRY
	AX = 1503h
	BX = zero-based index
	DS:SI -> node ID, 12 bytes blank-padded
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
SeeAlso: AX=1501h,AX=1502h
----------6F17-------------------------------
INT 6F - 10-NET v3.3 - MOUNT
	AH = 17h
	AL = local drive number (0=A:)
	BL = remote drive letter or '1'..'3' for LPTn or '4' or '5' for COMx
	DS:DX -> node ID, 12 bytes blank-padded
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
SeeAlso: AH=18h
----------6F18-------------------------------
INT 6F - 10-NET v3.3 - UNMOUNT
	AH = 18h
	AL = local drive number (0=A:)
	BL = type
	    00h	    disk
	    01h-03h LPTn
	    04h,05h COMx
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
SeeAlso: AH=17h
----------70---------------------------------
INT 70 - IRQ8 - CMOS REAL-TIME CLOCK
Notes:	this interrupt is called when the real-time clock chip generates an
	  alarm or periodic interrupt, among others.  The periodic interrupt
	  occurs 1024 times per second, although many BIOSes turn it off in
	  the INT 70h handler unless in an event wait (see INT 15/AH=83h or
	  INT 15/AH=86h).
	may be masked by setting bit 0 on I/O port A1h
SeeAlso: INT 08,INT 15/AH=01h"Amstrad",INT 15/AH=83h,INT 15/AH=86h
SeeAlso: INT 1A/AH=02h,INT 58
----------70---------------------------------
INT 70 - "Stupid" virus - ???
SeeAlso: INT 6B"virus",INT E0"virus"
----------71---------------------------------
INT 71 - IRQ9 - REDIRECTED TO INT 0A BY BIOS
Notes:	may be masked by setting bit 1 on I/O port A1h
	the default BIOS handler invokes INT 0A for compatibility, since the
	  pin for IRQ2 on the PC expansion bus became the pin for IRQ9 on the
	  AT expansion bus.
	under DESQview, only the INT 15h vector and BASIC segment address (the
	  word at 0000h:0510h) may be assumed to be valid for the handler's
	  process
SeeAlso: INT 0A,INT 59
----------72---------------------------------
INT 72 - IRQ10 - RESERVED
Note:	may be masked by setting bit 2 on I/O port A1h
SeeAlso: INT 5A
----------73---------------------------------
INT 73 - IRQ11 - RESERVED
Note:	may be masked by setting bit 3 on I/O port A1h
SeeAlso: INT 5B
----------74---------------------------------
INT 74 - IRQ12 - POINTING DEVICE (PS)
Notes:	may be masked by setting bit 4 on I/O port A1h
	under DESQview, only the INT 15h vector and BASIC segment address (the
	  word at 0000h:0510h) may be assumed to be valid for the handler's
	  process
SeeAlso: INT 33,INT 5C
----------75---------------------------------
INT 75 - IRQ13 - MATH COPROCESSOR EXCEPTION (AT and up)
   redirected to INT 02 by the BIOS, for compatibility with the PC
Notes:	may be masked by setting bit 5 on I/O port A1h
	not all clones wire the coprocessor to generate this IRQ; some systems
	  generate an NMI (see INT 02) or assert the -ERROR pin on the CPU
	  (see INT 10"COPROCESSOR")
	under DESQview, only the INT 15h vector and BASIC segment address (the
	  word at 0000h:0510h) may be assumed to be valid for the handler's
	  process
SeeAlso: INT 10"COPROCESSOR",INT 5D
----------76---------------------------------
INT 76 - IRQ14 - HARD DISK CONTROLLER (AT and later)
Note:	may be masked by setting bit 6 on I/O port A1h
SeeAlso: INT 0E"IRQ6",INT 5E
----------77---------------------------------
INT 77 - IRQ15 - RESERVED (AT,PS)
Note:	may be masked by setting bit 7 on I/O port A1h
SeeAlso: INT 5F
----------77---------------------------------
INT 77 - IRQ15 - POWER CONSERVATION (Compaq SLT/286)
Note:	may be masked by setting bit 7 on I/O port A1h
SeeAlso: INT 15/AX=4600h,INT 5F
----------7800-------------------------------
INT 78 - TARGA.DEV - CMC International SCSI device driver - SET I/O PORT
	AH = 00h
	DX = interface board I/O port
Return:	CF set on error
	    AL = error code
		00h illegal command given to SCSI code
		01h invalid I/O port specified (must be from 100H to 3F8H, and
		    must be on an 8-port boundary)
		02h invalid DMA channel specified (must be from 1 to 3)
		03h invalid SCSI board number specified (must be from 0 to 7)
		04h error from data register test during self-test
		05h SCSI input signals not all 0 when SCSI RST activated
		06h SCSI input signals not all 0 before selecting a SCSI device
		07h BSY signal is active; SCSI bus is busy
		08h SCSI board not selected, BSY signal did not come on in
		    response to raising SEL
		09h time-out waiting for status state, signifying end of DMA
		    transfer
Note:	if this routine is not called, the port is the driver's default
	  (usually 0280h or 0300h)
	an installation check is performed by TARGA.DEV upon initialization
	  by checking for the string "SCSI" at offset 03h into the interrupt
	  handler
SeeAlso: AH=01h,AH=02h
----------7801-------------------------------
INT 78 - TARGA.DEV - GET I/O PORT
	AH = 01h
Return: DX = current interface board I/O port
SeeAlso: AH=00h,AH=03h"TARGA"
----------7802-------------------------------
INT 78 - TARGA.DEV - SET DMA CHANNEL
	AH = 02h
	AL = interface board DMA channel
Return: CF set on error
	AL = error code (see AH=00h)
Note:	if this routine is not called, the DMA channel is the driver's default
	  (usually 3)
SeeAlso: AH=00h,AH=03h"TARGA"
----------7803-------------------------------
INT 78 - TARGA.DEV - GET DMA CHANNEL
	AH = 03h
Return: AL = current interface board DMA channel
SeeAlso: AH=01h,AH=02h
----------7803-------------------------------
INT 78 - UofSalford DBOS DOS extender - SWITCH TO PROTECTED MODE
	AH = 03h
	???
Return: ???
Note:	DBOS supports functions 00h through 50h
SeeAlso: AH=1Eh"DBOS",AH=22h"DBOS"
----------7804-------------------------------
INT 78 - TARGA.DEV - SET SCSI DEVICE NUMBER
	AH = 04h
	AL = SCSI device number
Return: CF set on error
	AL = error code (see AH=00h)
Note:	if this routine is not called, the device number used is the driver's
	  default (usually 0)
SeeAlso: AH=02h,AH=05h
----------7805-------------------------------
INT 78 - TARGA.DEV - GET SCSI DEVICE NUMBER
	AH = 05h
Return: AL = current SCSI device number
SeeAlso: AH=03h"TARGA",AH=04h
----------7806-------------------------------
INT 78 - TARGA.DEV - SET/CLEAR EARLY RETURN MODE
	AH = 06h
	AL = 00h clear early return mode
	   = 01h set early return mode
Note:	if early return mode is set then SCSI will return with no errors
	  when the last DMA transfer is started in a call with AH=13h or AH=14h
	if this routine is not called, early return mode is cleared
SeeAlso: AH=13h,AH=14h,AH=15h
----------7808-------------------------------
INT 78 - TARGA.DEV - INTERFACE BOARD SELF-TEST
	AH = 08h
Return: CF set on error
	AL = error code (see AH=00h)
Note:	the SCSI bus is also reset
SeeAlso: AH=09h
----------7809-------------------------------
INT 78 - TARGA.DEV - RESET SCSI BUS
	AH = 09h
Return: AL = error code if carry set (see AH=00h)
SeeAlso: AH=08h
----------7810-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND
	AH = 10h
	DS:SI -> command bytes
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see AH=00h)
SeeAlso: AH=11h

Format of SCSI Command:
Offset	Size	Description
 00h	BYTE	length of command
 01h	???	command bytes
----------7811-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND, RECEIVE DATA (PROGRAMMED I/O)
	AH = 11h
	DS:SI -> command bytes
	ES:BX -> data storage area
	CX = number of data bytes to transfer
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see AH=00h)
Note:	this command receives data internally one byte at a time
SeeAlso: AH=10h,AH=13h

Format of SCSI Command:
Offset	Size	Description
 00h	BYTE	length of command
 01h	???	command bytes
----------7812-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND AND DATA (PROGRAMMED I/O)
	AH = 12h
	DS:SI -> command bytes
	ES:BX -> data storage area
	CX = number of data bytes to transfer
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see AH=00h)
Note:	this command sends data internally one byte at a time
SeeAlso: AH=14h

Format of SCSI Command:
Offset	Size	Description
 00h	BYTE	length of command
 01h	???	command bytes
----------7813-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND, RECEIVE DATA (DMA)
	AH = 13h
	DS:SI -> command bytes
	ES:BX -> data storage area
	DX:CX = number of data bytes to transfer
Return: AH = SCSI status byte (if early return mode is clear)
	CF clear if successful
	    AL = SCSI message byte (if early return mode is clear)
	CF set on error
	    AL = error code (see AH=00h)
Note:	this command receives data using DMA
SeeAlso: AH=11h,AH=12h

Format of SCSI Command:
Offset	Size	Description
 00h	BYTE	length of command
 01h	???	command bytes
----------7814-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND AND DATA (DMA)
	AH = 14h
	DS:SI -> command bytes
	ES:BX -> data storage area
	DX:CX = number of data bytes to transfer
Return: AH = SCSI status byte (if early return mode is clear)
	CF clear if successful
	    AL = SCSI message byte (if early return mode is clear)
	CF set on error
	    AL = error code (see AH=00h)
Note:	this command sends data using DMA
SeeAlso: AH=12h,AH=13h

Format of SCSI Command:
Offset	Size	Description
 00h	BYTE	length of command
 01h	???	command bytes
----------7815-------------------------------
INT 78 - TARGA.DEV - FINISH DATA TRANSFER (DMA)
	AH = 15h
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see AH=00h)
Note:	if AH=06h was previously called to set the early return mode, this
	  function finishes a command AH=13h or AH=14h which returned before
	  the last DMA transfer was finished
SeeAlso: AH=06h,AH=13h,AH=14h
----------781E-------------------------------
INT 78 - UofSalford DBOS DOS extender - SET REAL-MODE MEMORY SIZE
	AH = 1Eh
	???
Return: ???
Notes:	specifies how much real-mode memory to leave free when running FTN77
	  programs
	DBOS supports functions 00h through 50h
SeeAlso: AH=03h"DBOS",AH=22h"DBOS"
----------7822-------------------------------
INT 78 - UofSalford DBOS DOS extender - UNINSTALL
	AH = 22h
	???
Return: ???
Note:	DBOS supports functions 00h through 50h
SeeAlso: AH=03h"DBOS",AH=1Eh"DBOS"
----------79---------------------------------
INT 79 - AVATAR.SYS - FAST GET KEYSTROKE
Return: CF set if no keystroke available
	    AX = FFFFh
	CF clear if key pressed
	    AX = keystroke
Notes:	if a keystroke is available, it is removed from the keyboard buffer
	  before being returned
	AVATAR.SYS is a CON driver by George Adam Stanislav which interprets
	  AVATAR command codes just as ANSI.SYS interprets ANSI commands
SeeAlso: INT 29
----------7A---------------------------------
INT 7A - Topware Network Operating System - ???
	AL = ???
	???
Return: ???
----------7A---------------------------------
INT 7A - AutoCAD Device Interface
	???
----------7A---------------------------------
INT 7A - Novell NetWare - LOW-LEVEL API - Notes
Note:	this interrupt is used for IPX/SPX access in NetWare versions through
	  2.0a; in later versions, you should use INT 2F/AX=7A00h to get an
	  entry point.	For both INT 7A and the FAR entry point, BX contains
	  the function number; IPX is sometimes called internally with BX bit
	  15 set.
SeeAlso: INT 2F/AX=7A00h,INT 64"Novell"
----------7A----BX0000-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - OPEN SOCKET
	BX = 0000h
	AL = mode
	    00h open until close or terminate
	    FFh open until close
	DX = socket number (high byte in DL)
	    0000h dynamic allocation
	    else  socket to open
Return: AL = return code
	    00h success
		DX = socket number
	    FEh socket table full
	    FFh socket already open
SeeAlso: BX=0001h
----------7A----BX0001-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - CLOSE SOCKET
	BX = 0001h
	DX = socket (high byte in DL)
SeeAlso: BX=0000h
----------7A----BX0002-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - GET LOCAL TARGET
	BX = 0002h
	ES:SI -> target internetwork address
	ES:DI -> 6-byte buffer for local target
Return: AL = return code
	    00h success
	       CX = expected one-way transfer time (clock ticks)
	       ES:DI -> local target
	    FAh unsuccessful
Note:	The internetwork address consists of a 4-byte network address followed
	  by a 6-byte node address.  The local target is only a 6-byte node
	  address.  If the target is in the same network, the local target is
	  just the node address of target; otherwise, the local target is the
	  node address of the bridge that leads to the target.
SeeAlso: BX=0009h
----------7A----BX0003-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - SEND PACKET
	BX = 0003h
	ES:SI -> Event Control Block (see below)
SeeAlso: BX=0004h,BX=000Fh

Format of Event Control Block:
Offset	Size	Description
 00h	DWORD	Link
 04h	DWORD	-> Event Service Routine (00000000h if none)
 08h	BYTE	in use flag
 09h	BYTE	completion code
 0Ah	WORD	socket (high byte first [big-endian])
 0Ch  4 BYTES	IPX workspace
 10h 12 BYTES	driver workspace
 1Ch  6 BYTES	immediate local node address
 22h	WORD	fragment count
 26h	var	fragment descriptors
		Offset	Size	Description
		 00h	DWORD	-> fragment data
		 04h	WORD	size of fragment in bytes.
Notes:	ESR is a far procedure that is called when the ECB has been handled.
	  On call, the in use flag is zero if the ECB has been handled,
	  non-zero otherwise. If the flag is zero, the completion code holds
	  the result of the event:
	    00h success
	    F9h event should not be cancelled
	    FCh cancelled
	    FDh malformed packet
	    FEh packet undeliverable
	    FFh physical error
	the first fragment should start with an IPX header
	all fragments are concatenated and sent in one piece
	node address FF FF FF FF FF FF broadcasts to all nodes

Event Service Routine called with:
	AL = caller's identity (00h = AES, FFh = IPX)
	ES:SI -> event control block
	interrupts disabled

Format of IPX header:
Offset	Size	Description
 00h	WORD	checksum (high byte first [big-endian])
 02h	WORD	length in bytes (high byte first) of total packet
 04h	BYTE	transport control
 05h	BYTE	packet type
		00h unknown packet type
		01h routing information packet
		02h echo packet
		03h error packet
		04h packet exchange packet (always use this one)
		05h SPX packet
		11h (used internally)
 06h 10 BYTES	destination internetwork address
 10h	WORD	destination socket (high byte first)
 12h 10 BYTES	source internetwork address
 1Ch	WORD	source socket
----------7A----BX0004-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - LISTEN FOR PACKET
	BX = 0004h
	ES:SI -> Event Control Block (see BX=0003h)
SeeAlso: BX=0003h
----------7A----BX0005-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - SCHEDULE IPX EVENT
	BX = 0005h
	AX = delay time
	ES:SI -> Event Control Block (see BX=0003h)
SeeAlso: BX=0006h,BX=0007h
----------7A----BX0006-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - CANCEL EVENT
	BX = 0006h
	ES:SI -> Event Control Block (see BX=0003h)
Return: AL = return code
	    00h success
	    F9h event in use
	    FFh unsuccessful, event not in use
SeeAlso: BX=0005h
----------7A----BX0007-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - SCHEDULE SPECIAL EVENT
	BX = 0007h
	AX = delay time
	ES:SI -> Event Control Block (see BX=0003h)
SeeAlso: BX=0006h
----------7A----BX0008-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - GET INTERVAL MARKER
	BX = 0008h
Return: AX = interval marker in clock ticks
----------7A----BX0009-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - GET INTERNETWORK ADDRESS
	BX = 0009h
	ES:SI -> 10-byte buffer
Return: ES:SI -> own internetwork address
SeeAlso: BX=0002h,BX=000Bh
----------7A----BX000A-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - RELINQUISH CONTROL
	BX = 000Ah
Note:	this call permits the IPX driver to do some work
----------7A----BX000B-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - DISCONNECT FROM TARGET
	BX = 000Bh
	ES:SI -> internetwork address
Note:	only use in point-to-point networks
SeeAlso: BX=0002h,BX=0009h
----------7A----BX000C-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - INTERNAL
	BX = 000Ch
	???
Return: ???
----------7A----BX000D-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - INTERNAL
	BX = 000Dh
	???
Return: ???
----------7A----BX000E-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - INTERNAL
	BX = 000Eh
	???
Return: ???
----------7A----BX000F-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - INTERNAL - SEND PACKET
	BX = 000Fh
	ES:SI -> Event Control Block (see BX=0003h)
Note:	similar to function 0003h, but apparently does not allow multiple
	  fragments
SeeAlso: BX=0003h
----------7A----BX0010-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - SPX INSTALLACTION CHECK
	BX = 0010h
	AL = 00h
Return: AL = FFh if SPX loaded
SeeAlso: BX=0015h
----------7A----BX0011-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - ESTABLISH SPX CONNECTION
	BX = 0011h
	AL = retry count
	AH = watchdog flag
	ES:SI -> Event Control Block (see BX=0003h)
Return: DX = assigned connection number
Notes:	there should always be at least two SPX ECB's listening to a socket, so
	  that NetWare can perform its internal packet exchanges
	The first fragment should start with a SPX header.  Fill in all
	  destination addresses.
SeeAlso: BX=0000h,BX=0012h,BX=0013h,BX=0014h
 
Format of SPX header:
Offset	Size	Description
 00h	WORD	checksum (high byte first [big-endian])
 02h	WORD	length in bytes of total packet (high byte first)
 04h	BYTE	transport control
 05h	BYTE	packet type
 06h 10 BYTEs	destination internet address
 10h	WORD	destination socket (high byte first)
 12h 10 BYTEs	source internet address
 1Ch	WORD	source socket (high byte first)
 1Eh	BYTE	connection control
 1Fh	BYTE	datastreamtype
 20h	WORD	source connection ID
 22h	WORD	destination connection ID
 24h	WORD	sequence number
 26h	WORD	acknowledge number
 28h	WORD	allocation number
----------7A----BX0012-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - LISTEN FOR SPX CONNECTION
	BX = 0012h
	AL = retry count
	AH = watchdog flag
	ES:SI -> Event Control Block (see BX=0003h)
Notes:	there should always be at least two SPX ECB's listening to a socket, so
	  that NetWare can perform its internal packet exchanges
SeeAlso: BX=0011h,BX=0013h,BX=0014h
----------7A----BX0013-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - TERMINATE SPX CONNECTION
	BX = 0013h
	DX = connection ID to terminate
	ES:SI -> Event Control Block (see BX=0003h)
SeeAlso: BX=0011h,BX=0012h,BX=0014h
----------7A----BX0014-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - ABORT SPX CONNECTION
	BX = 0014h
	DX = connection ID to terminate
Note:	this function does not tell the other side that the connection has been
	  terminated
SeeAlso: BX=0011h,BX=0013h
----------7A----BX0015-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - GET SPX STATUS
	BX = 0015h
	DX = connection ID
	ES:SI -> status buffer (see below)
Return: AL = return code
	    00h connection still valid
		ES:SI -> status buffer filled
SeeAlso: BX=0010h
 
Format of status buffer:
Offset	Size	Description
 00h	BYTE	status
 01h	BYTE	flag
 02h	WORD	source connection (high byte first [big-endian])
 04h	WORD	destination connection (high byte first)
 06h	WORD	sequence number (high byte first)
 08h	WORD	acknowledge number (high byte first)
 0Ah	WORD	allocation number (high byte first)
 0Ch	WORD	remote acknowledge number (high byte first)
 0Eh	WORD	remote allocation number (high byte first)
 10h	WORD	connection socket (high byte first)
 12h  6 BYTEs	immediate node address
 18h 10 BYTEs	destination internet address
 22h	WORD	retransmit count (high byte first)
 24h	WORD	estimated roundtrip delay
 26h	WORD	retransmitted packets
 28h	WORD	suppressed packets
----------7A----BX0016-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - SEND SPX PACKET
	BX = 0016h
	DX = connection ID
	ES:SI -> Event Control Block (see BX=0003h)
Note:	CX may need to be 0001h ???
SeeAlso: BX=0011h,BX=0017h
----------7A----BX0017-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - LISTEN FOR SPX PACKET
	BX = 0017h
	DX = connection ID
	ES:SI -> Event Control Block (see BX=0003h)
Note:	CX may need to be 0001h ???
SeeAlso: BX=0011h,BX=0016h
----------7A----BX0018-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - INTERNAL
	BX = 0018h
	???
Return: ???
----------7A----BX0019-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - INTERNAL
	BX = 0019h
	???
Return: ???
----------7A----BX001A-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - INTERNAL
	BX = 001Ah
	???
Return: ???
----------7A----BX001B-----------------------
INT 7A - Novell NetWare Low-Level API (IPX) Driver - INTERNAL
	BX = 001Bh
	???
Return: ???
----------7A04-------------------------------
INT 7A - IBM 3270 Workstation Program API - CREATE A QUEUE
	AH = 04h
	???
Return: ???
SeeAlso: AH=06h
----------7A06-------------------------------
INT 7A - IBM 3270 Workstation Program API - DELETE A QUEUE
	AH = 06h
	???
Return: ???
SeeAlso: AH=04h
----------7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - SESSION SERVICES
	AH = 09h
	BX = 8020h (synchronous request)
	CX = 0000h
	DX = ID of session manager (SESSMGR)
	AL = service
	    01h get session ID
	    02h get session info
	    04h dettach from session
	    05h attach to session
	    06h get list of windows available
	    07h get environment of window
	    08h get 'PIF' (program information file) info
	    0Ah get base window ID
	    0Bh get cursor info
	ES:DI -> control block
Return: ???
----------7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - KEYBOARD SERVICES
	AH = 09h
	BX = 8020h (synchronous request)
	CX = 0000h
	DX = ID of keyboard manager
	AL = service
	    01h connect to keyboard
	    02h disconnect from keyboard
	    03h read from keyboard
	    04h send keystroke to session
	    05h disable input
	    06h enable input
	    07h update status code
	ES:DI -> control block
Return: ???
----------7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - WINDOW SERVICES
	AH = 09h
	BX = 8020h (synchronous request)
	CX = 00FFh
	DX = ID of window service controller (WSCTRL)
	AL = service
	    01h connect to WS control
	    02h disconnect from WS control
	    03h add a window
	    04h change window's position on screen
	    05h change window's size
	    06h change window's color
	    07h change window's position in the presentation space
	    08h hide/unhide toggle
	    09h enlarge/reduce toggle
	    0Ah change screen background color
	    0Bh get window's position on screen
	    0Ch get window's size
	    0Dh get window's color
	    0Eh get window's position in the presentation space
	    0Fh determine whether hidden
	    10h determine whether enlarged
	    11h get background color
	    12h get window names
	    13h delete all windows from profile
	    14h pick active window
	    15h redraw screen
	    16h redraw window
	    17h delete a window from profile
	    18h get active window
	    19h get active screen
	    1Ah get window data
	    1Bh change window data
	    1Ch select active screen
	ES:DI -> control block
Return: ???
----------7A09--BX8020-----------------------
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
----------7A09--BX8020-----------------------
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
----------7A09--BX8020-----------------------
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
----------7A09--BX8020-----------------------
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
----------7A09--BX8020-----------------------
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
----------7A09--BX8020-----------------------
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
----------7A09-------------------------------
INT 7A - IBM 3270 Workstation Program API - HOST SERVICES
	AH = 09h
	BX = request type (4000h async, 8028h synchronous)
	CX = 0000h
	DX = ID of MFIC
	AL = service
	   01h connect to host
	   02h disconnect from host
	   03h read DFT structured data from host
	   04h write DFT structured data to host
	   05h create a host buffer
	ES:DI -> control block
----------7A13-------------------------------
INT 7A - IBM 3270 Workstation Program API - GET DATA FROM A QUEUE
	AH = 13h
	???
Return: ???
----------7A81-------------------------------
INT 7A - IBM 3270 Workstation Program API - RESOLVE A GATE NAME
	AH = 81h
	ES:DI -> 8-char blank-padded gate name
		"SESSMGR ", "KEYBOARD", "WSCTRL	 ", "MFIC    ", "PCPSM	 ",
		"3270EML ", "COPY    ", "XLATE	 ", "OIAM    ", "MEMORY	 ",
		"INDJQRY ", or "INDJASY "
Return: DX = gate ID
----------7A83-------------------------------
INT 7A - IBM 3270 Workstation Program API - GET COMPLETION RESULTS
	AH = 83h
	???
Return: ???
----------7AFDCB-----------------------------
INT 7A - IBM Personal Communications/3270 - INSTALLATION CHECK
	AX = FDCBh
Return: DX:AX -> PCS/3270 signature block if loaded (see below)

Format of signature block:
Offset	Size	Description
 04h	WORD	PCS/3270 signature (5741h)
 06h	WORD	version (0501h = PCS/3270 v1.0)
----------7AFE01-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL SEND/RECEIVE FUNCTION
	AX = FE01h
	???
Return: ???
SeeAlso: AX=FE02h
----------7AFE02-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL SEND/RECEIVE FUNCTION
	AX = FE02h
	???
Return: ???
SeeAlso: AX=FE01h
----------7AFF01-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL API INITIALIZATION
	AX = FF01h
	ES:DI -> API function handler routine
Return: CX = 1200h
SeeAlso: AX=FF02h,AX=FF03h
----------7AFF02-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL API TERMINATION
	AX = FF02h
Return: CX = 1200h
SeeAlso: AX=FF01h
----------7AFF03-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL API INITIALIZATION
	AX = FF03h
	ES:DI -> send/receive function handler routine
Return: CX = 1200h
SeeAlso: AX=FF01h
----------7AFF04-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL ???
	AX = FF04h
	ES:DI -> ???
Return: CX = 1200h
----------7B---------------------------------
INT 7B - Btrieve API
	DS:DX -> 38-byte parameter record (see below)
Return: return code field set
Note:	Btrieve sets low byte of vector to 33h; this serves as the installation
	  check

Format of Btrieve parameter record:
Offset	Size	Description
 00h	DWORD	pointer to data buffer
 04h	WORD	data buffer length
 06h	DWORD	pointer to 90-byte record containing positioning info
		(should be same for all calls for same file)
 0Ah	DWORD	pointer to 38-byte FCB info buffer
		(should be same for all calls for same file)
 0Eh	WORD	function code (see below)
 10h	DWORD	pointer to file name/key buffer
 14h	BYTE	key length
 15h	BYTE	key number
 16h	DWORD	pointer to status code (see below)
 1Ah	WORD	interface code (version specific)

Values for function code:
 00h open
 01h close
 02h insert
 03h update
 04h delete
 05h get_equal
 06h get_next
 07h get_prev
 08h get_greater
 09h get_gr_eql
 0Ah get_less
 0Bh get_less_eq
 0Ch get_first
 0Dh get_last
 0Eh create
 0Fh stat
 10h extend
 11h set_dir: set directory information
 12h get_dir: get directory information
 13h begin_trans
 14h end_trans
 15h abort_trans
 16h get_pos: get record position number
 17h get_direct: get data by sending record position
 18h step_direct
 19h stop
 1Ah version
 1Bh unlock
 1Ch reset
 1Dh set owner
 1Eh clear owner
 1Fh create supplemental index
 20h drop supplemental index
 21h step first
 22h step last
 23h step next
 31h ???
 37h ???
 38h ???
 39h ???
 3Ah ???
 3Bh ???
 3Ch ???
 3Dh ???
 3Eh ???
 3Fh ???
 add 100 (64h) for a single-record wait lock (automatically released on next
		get)
 add 200 (C8h) for a single-record nowait lock (nowait lock returns error 54h
		or 55h if record already locked)
 add 300 (12Ch) for a multiple-record wait lock (not released until unlock
		called)
 add 400 (190h) for a multiple-record nowait lock (nowait lock returns error
		54h or 55h if record already locked)

Values for status code:
 00h successful
 01h invalid operation
 02h I/O error
 03h file not open
 04h key value not found
 05h duplicate key value
 06h invalid key number
 07h different key number
 08h invalid positioning
 09h end of file
 0Ah modifiable key value error
 0Bh invalid file name
 0Ch file not found
 0Dh extended file error
 0Eh pre-image open error
 0Fh pre-image I/O error
 10h expansion error
 11h close error
 12h disk full
 13h unrecoverable error
 14h record manager inactive
 15h key buffer too short
 16h data buffer length overrun
 17h position block length
 18h page size error
 19h create I/O error
 1Ah number of keys
 1Bh invalid key position
 1Ch invalid record length
 1Dh invalid key length
 1Eh not a Btrieve file
 1Fh file already extended
 20h extended I/O error
 22h invalid extension name
 23h directory error
 24h transaction error
 25h transaction is active
 26h transaction control file I/O error
 27h end/abort transaction error
 28h transaction max files
 29h operation not allowed
 2Ah incomplete accelerated access
 2Bh invalid record address
 2Ch null key path
 2Dh inconsistent key flags
 2Eh access to file denied
 2Fh maximum open files
 30h invalid alternate sequence definition
 31h key type error
 32h owner already set
 33h invalid owner
 34h error writing cache
 35h invalid interface
 36h variable page error
 37h autoincrement error
 38h incomplete index
 39h expanded memory error
 3Ah compression buffer too short
 3Bh file already exists
 50h conflict
 51h lock error
 52h lost position
 53h read outside transaction
 54h record in use
 55h file in use
 56h file table full
 57h handle table full
 58h incompatible open mode
 5Dh incompatible lock type
 5Eh permission error
----------7B---------------------------------
INT 7B - Eicon Access API (3270/5250 gateways)
----------7C---------------------------------
INT 7C - IBM REXX88PC command language
	???
----------7D---------------------------------
INT 7D - not used
----------7E---------------------------------
INT 7E - RESERVED FOR DIP, Ltd. ROM LIBRARY
----------7F---------------------------------
INT 7F - IBM XGA - ???
----------7F---------------------------------
INT 7F - Halo88 - API
	BX = function
		64h arc
		65h bar
		66h box
		67h circle
		68h clr
		69h default hatch style
		6Ah default line style
		6Bh delhcur
		6Ch delln / deltcur
		6Dh ellipse
		6Eh fill
		6Fh flood
		70h flood2
		71h init graphics
		72h init hcur
		73h init marker
		74h init tcur
		75h inqarc
		76h inqbknd
		77h inqclr
		78h inqerr
		79h inqgcur
		7Ah inqhcur
		7Bh inqmarker
		7Dh inqtcur
		7Eh inqtext
		7Fh lnabs
		80h lnrel
		81h markerabs
		82h markerrel
		83h moveabs
		84h movehcurabs
		85h movehcurrel
		86h moverel
		87h movetcurabs
		88h movetcurrel
		89h movefrom
		8Ah moveto
		8Bh pie
		8Ch polylnabs
		8Dh polylnrel
		8Eh ptabs
		8Fh ptrel
		91h setasp
		92h set color
		93h set font
		94h set hatch style
		95h set line style
		97h settext
		98h set text color
		99h btext
		9Ah setseg
		9Bh display
		9Ch setscreen
		9Eh close graphics
		9Fh ftinit
		A0h ftlocate
		A1h ftext
		A5h set viewport
		A6h set window
		A7h set world
		AAh ftcolor
		ACh initlp
		ADh inqasp
		AEh inqdev
		AFh inqdisplay
		B0h inqft
		B1h inqftcolor
		B2h inqinterlace
		B3h inqlpa
		B4h inqlpg
		B5h inqmode
		B6h inqscreen
		B7h inqversion
		B8h roam
		B9h scroll
		BAh setieee
		BBh set interlace
		BCh shift
		BDh start graphics
		BEh vpan
		CBh gwrite
		CCh gread
		CDh setxor
		CEh rbox
		CFh rcir
		D0h rlnabs
		D1h rlnrel
		D2h delbox
		D3h delcir
		D5h setseg2
		DCh worldoff
		DDh mapwtod
		DEh mapdtow
		DFh mapwton
		E0h mapntow
		E1h mapdton
		E2h mapntod
		E3h inqworld
		E4h inqviewport
		E5h set line width
		E6h lnjoint
		E7h set locator
		E8h read locator
		E9h setdev
		EBh setstext
		ECh setstclr
		EDh setstang
		EEh stext
		EFh inqstext
		F0h setdegree
		F1h inqstsize
		F2h polyfabs
		F3h polyfrel
		F4h inqdrange
		F5h inqstang
		F6h orglocator
		F7h inqlocator
		F8h inqarea
		F9h setipal
		FAh setborder
		FBh inqcrange
		FEh setclip
		FFh fcir
	       100h setcrange
	       101h setdrange
	       102h setlattr
	       103h polycabs
	       104h polycrel
	       108h memcom
	       109h memexp
	       10Ah memmov
	       10Eh movefx
	       10Fh movetx
	       110h inqrgb
	       111h save image
	       112h restore image
	       113h setapal
	       114h setxpal
	       118h inqtsize
	       12Eh gprint
	       130h setprn
	       131h setpattr
	       133h setbattr
	       135h pexpand
	       136h ptnorm
	       137h pfnorm
	       13Bh inqprn
	       13Ch lopen
	       13Dh lclose
	       13Eh lappend
	       13Fh lrecord
	       140h lswitch
	       142h inqfun
	       15Dh lsetup
	       15Eh lrest
	       15Fh lsave
	additional parameters on stack
Return: ???
Notes:	Halo88 is a suite of graphics routines
	according to Stuart Kemp, the code appears to make no provisions for
	   chaining
----------7F---------------------------------
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
----------7F---------------------------------
INT 7F - Alloy 386/MultiWare (MW386), Novell-Type Network Executive (NTNX)
Notes:	the words at C800h:0000h and C800h:0002h will both be 584Eh if this
	  multitasking system is present
	NTNX allows its API to be placed on a different interrupt than 7Fh at
	  load time.  To determine the actual vector used, open the device
	  "SPOOLER" with INT 21/AX=3D02h, place it in RAW mode with
	  INT 21/AX=4400h and INT 21/AX=4401h, then read one byte which will
	  be the actual interrupt number being used; the other interrupts may
	  be found with INT 7F/AH=09h/CL=03h
----------7F---------------------------------
INT 7F - Alloy NetWare Support Kit (ANSK) v2.2+ - INSTALLATION CHECK
Note:	a program may determine that it is running on an ANSK Slave by checking
	  the five bytes at F000h:0000h for the ASCIZ signature "ANSK"; this
	  address is RAM, and should not be written.  However, the above check
	  will not work on Slaves with <1MB RAM or those using the SLIM.SYS
	  device driver
----------7F00-------------------------------
INT 7F - Alloy NTNX, MW386 - SEMAPHORE LOCK AND WAIT
	AH = 00h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status
	    00h successful
	    01h invalid function
	    02h semaphore already locked
	    03h unable to lock semaphore
	    04h semaphore space exhausted
	    05h host/target PC did not respond (NTNX)
	AH = semaphore owner if status=02h
SeeAlso: AH=01h,AH=02h,AH=41h,INT 67/AH=00h
----------7F01-------------------------------
INT 7F - Alloy NTNX, MW386 - SEMAPHORE LOCK
	AH = 01h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see AH=00h)
	AH = semaphore owner if status=02h
SeeAlso: AH=00h,AH=02h,AH=41h
----------7F0104BX0000-----------------------
INT 7F - HLLAPI (IBM 3270 High-Level Language API)
	AX = 0104h (HLLAPI gate ID)
	BX = 0000h
	DS:SI -> parameter control block (see below)
Return: parameter control block updated

Format of parameter control block:
Offset	Size	Description
 00h  3 BYTEs	signature = 'PCB'
 03h	BYTE	function number (see below)
 04h	WORD	segment of control string
 06h	WORD	offset of control string
 08h	WORD	length of control string, unless explicit end-of-str char set
 0Ah	BYTE	unused
 0Bh	WORD	return code
 0Dh	WORD	maximum length of control string

Values for function number:
 00h	Query system (Attachmate implementation only)
 01h	Connect presentation space
 02h	Disconnect presentation space
 03h	Send string of keystrokes as if typed from keyboard
 04h	Wait ~60s, returns status of presentation space
 05h	Copy current presentation space into a user-defined buffer
 06h	Search presentation space for first occurrence of a specified string
 07h	Query cursor location in current presentation space
 08h	Copy part or all of current presentation space into user buffer
 09h	Set session parameters; parameters vary by vendor
 0Ah	Get info on sessions currently connected
 0Bh	Lock current presentation space
 0Ch	Unlock previously locked presentation space
 0Dh	Return copy of operator info area (OIA) of current presentation space
 0Eh	get attribute byte for given position in the current presentation space
 0Fh	copy string of characters to the current presentation space
 10h	workstation control functions
 11h	storage manager functions, intended primarily for BASIC applications
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
 32h	start intercepting keystrokes to allow filtering
 33h	get keystrokes after turning on interception
 34h	notify operator when keystroke rejected by filter subroutine
 35h	stop intercepting keystrokes
 5Ah	send file
 5Bh	receive file
 5Ch	run a program
 5Dh	execute DOS command
 63h	change presentation space position to PC display row/col or vice versa
 FFh	Get info on DCA implementation

Session Parameters for function 09h:
 ATTRIB		return attributes in hex
 NOATTRIB	return attributes as blanks
 CONPHYS	make physical connection
 CONLOG		only make logical connection
 EAB		copy extended attribute bytes along with data 
 NOEAB		copy data only
 ESC=n		set escape character to "n" (default '@')
 EOT=n		set end of string character (default 00h)
 FPAUSE		full-duration pause
 IPAUSE		interruptible pause
 STRLEN		use explicit string lengths
 STREOT		use terminated strings
 SRCHALL	search entire presentation space
 SRCHFROM	search from specified offset
 SRCHFRWD	search forward from position 1
 SRCHBKWD	search backward from last position in presentation space
 TWAIT		wait specified time for keyboard ready
 LWAIT		wait until keyboard ready
 NWAIT		no wait
 TRON		enable tracing
 TROFF		disable tracing
 AUTORESET	send reset before sending keys with function 03h
 NORESET	don't send reset
 QUIET		don't display messages sent with INT 21/AH=9
 NOQUIET	allow messages to be displayed
 TIMEOUT=n	set timeout in 30-second intervals, 0 = wait until ^Break
 XLATE		translate extended attribute bytes
 NOXLATE	don't translate
 NEWRET		use HLLAPI v3.0 return code conventions
 OLDRET		use HLLAPI v2.0 return code conventions
----------7F0105-----------------------------
INT 7F - HDILOAD.EXE - 8514/A VIDEO CONTROLLER INTERFACE
	AX = 0105h get 8514/A entry points
Return: CF set on error
	CF clear if successful
	    CX:DX -> array of FAR pointers to entry points
Note:	most functions are invoked by pushing the DWORD parameter block pointer
	  and then performing a FAR call via the appropriate vector of the
	  entry point array

Function numbers: (do FAR call via entry_points+4*function)
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
----------7F02-------------------------------
INT 7F - Alloy NTNX, MW386 - RELEASE SEMAPHORE
	AH = 02h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status
	    00h successful
	    01h invalid function
	    02h semaphore locked by other user
		AH = semaphore owner
	    03h unable to unlock semaphore
	    05h target PC did not respond
SeeAlso: AH=00h,AH=01h,AH=42h
----------7F03-------------------------------
INT 7F - Alloy ANSK, NTNX, MW386 - GET USER NUMBER
	AH = 03h
Return: AL = user number
	AH = machine number (MW386)
Note:	this function call is the recommended method for a CPU-bound process to
	  prevent its priority from being lowered
SeeAlso: AH=04h,AH=05h,AH=A1h
----------7F04-------------------------------
INT 7F - Alloy NTNX, MW386 - GET NUMBER OF USERS
	AH = 04h
Return: AL = total number of users on currrent machine (MW386)
	AL = number of slaves on system (NTNX)
SeeAlso: AH=03h
----------7F05-------------------------------
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
----------7F05-------------------------------
INT 7F - Alloy NTNX (Slave), MW386 - GET USER PARAMETERS
	AH = 05h
	DX:DI -> buffer for user information record (see below)
Notes:	MW386 provides this function for backward compatibility only, and sets
	  many of the fields to zero because they are meaningless under MW386
	this function has no effect when called by the host (user 0)
SeeAlso: AH=03h

Format of user information record:
Offset	Size	Description
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
		intercept flag = FFh if MSDOS intercepts should be disabled
 20h	WORD	offset of terminal lock flag (see INT 10/AH=92h)
		lock flag = FFh if backgrnd screen updates should be suspended
 22h 26 BYTEs	reserved
----------7F06-------------------------------
INT 7F - Alloy NTNX (Host) - GET SHARED DRIVE INFO
	AH = 06h
	AL = drive number (1=A:, 2=B:, etc)
	ES:DI -> drive info record (see below)
Return: AX = status
	    0000h successful
		ES:DI buffer filled
	    0001h not shared drive

Format of drive info record:
Offset	Size	Description
 00h	WORD	segment of drive IO-REQUEST structure (MSDOS DPB)
 02h	WORD	segment of allocation map (owner table)
		one byte per FAT entry, containing user ID owning that entry
 04h	WORD	segment of master FAT for drive (copy of FAT on disk)
 06h	WORD	pointer to configuration file
 08h	WORD	total number of clusters
 0Ah	WORD	bytes per sector
 0Ch	WORD	sectors per cluster
 0Eh	BYTE	FAT type (0Ch = 12-bit, 10h = 16-bit)
----------7F06-------------------------------
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
----------7F07-------------------------------
INT 7F - Alloy NTNX, MW386 - GET LIST OF SHARED DRIVES
	AH = 07h
Return: ES:DI -> shared drive list (see below)
Note:	MW386 considers all fixed disks to be shared drives; only C and D will
	  be returned as shared

Format of shared drive list:
Offset	Size	Description
 00h	BYTE	string length
 01h	BYTE	number of shared drives
 02h  N BYTEs	one byte per shared drive
----------7F08-------------------------------
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
----------7F08--CL02-------------------------
INT 7F - Alloy NTNX - SET MESSAGE DISPLAY TIMEOUT
	AH = 08h
	CL = 02h
	DX = timeout in seconds
Return: AL = status
	    00h successful
	    02h invalid subfunction
----------7F09-------------------------------
INT 7F - MultiLink Advanced - SET TASK PRIORITY
	AH = 09h
	AL = priority (0-7)
Note:	the installation check consists of ensuring that the interrupt vector
	  is not pointing at segment 0000h, then checking whether the byte
	  at offset 0000h in the interrupt handler's segment is E9h
----------7F09-------------------------------
INT 7F - Alloy NTNX - ENABLE/DISABLE MUD FILE CHECKING
	AH = 09h
	CL = function
	    00h enable checking of RTNX.MUD file
	    01h disable RTNX.MUD checking
----------7F09--CL02-------------------------
INT 7F - Alloy NTNX - SWITCH HOST TO DEDICATED MODE
	AH = 09h
	CL = 02h
Note:	in dedicated mode, the host will only poll for I/O requests from the
	  slave processors, and not provide workstation services
----------7F09--CL03-------------------------
INT 7F - Alloy NTNX - GET ALTERNATE INTERRUPT
	AH = 09h
	CL = 03h
	AL = default interrupt number (67h,7Fh,etc)
Return:	CL = actual interrupt which handles specified interrupt's calls
SeeAlso: AH=08h
----------7F0A--CL00-------------------------
INT 7F - Alloy NTNX - GET SYSTEM FLAGS
	AH = 0Ah
	CL = 00h
	ES:DI -> buffer for system flags (see below)
Return: ES:DI buffer filled
Notes:	on a slave, only the NX_Busy flag is returned
	all three flags are at fixed positions, so this function only needs to
	  be called once
	an interrupt handler should only perform DOS or device accesses when
	  all three flags are 00h

Format of system flags:
Offset	Size	Description
 00h	DWORD	pointer to NX_Busy flag (nonzero when communicating with users)
 04h	DWORD	pointer to device driver busy flag
 08h	DWORD	pointer to InTimer flag
----------7F0B--CL02-------------------------
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
----------7F10--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - OPEN CHANNEL
	AH = 10h
	CL = 00h
	AL = channel number
	DX:DI -> channel buffer
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
	    0Dh unable to open
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=01h,AH=10h/CL=04h,AH=14h/CL=02h
----------7F10--CL01-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - CLOSE CHANNEL
	AH = 10h
	CL = 01h
	AL = channel number
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
	    0Ah channel not open
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=00h,AH=10h/CL=05h
----------7F10--CL02-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - LOCK CHANNEL
	AH = 10h
	CL = 02h
	AL = channel number
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
	    0Ah channel not open
	    0Ch channel already locked
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=03h,AH=10h/CL=06h,AH=10h/CL=08h
----------7F10--CL03-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - UNLOCK CHANNEL
	AH = 10h
	CL = 03h
	AL = channel number
Return: AL = status (see AH=10h/CL=02h)
Notes:	should only be used on channels locked with AH=10h/CL=02h, not on those
	  locked by receipt of a datagram
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=02h,AH=10h/CL=04h,AH=10h/CL=09h
----------7F10--CL04-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - RELEASE BUFFER
	AH = 10h
	CL = 04h
	AL = channel number
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
Notes:	unlocks buffer after received datagram has been processed
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=00h
----------7F10--CL05-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - CLOSE ALL CHANNELS
	AH = 10h
	CL = 05h
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
Notes:	clears all pending datagrams and clears buffer pointers before closing
	  the channels
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=01h
----------7F10--CL06-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - LOCK ALL OPEN CHANNELS
	AH = 10h
	CL = 06h
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=02h,AH=10h/CL=08h
----------7F10--CL07-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - UNLOCK ALL LOCKED IDLE CHANNELS
	AH = 10h
	CL = 07h
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
Notes:	unlocks all locked channels which have no pending datagrams
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=03h,AH=10h/CL=09h
----------7F10--CL08-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - LOCK MULTIPLE CHANNELS
	AH = 10h
	CL = 08h
	DX = maximum channel number to lock
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
Notes:	locks channels numbered 00h through the value in DX
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=02h,AH=10h/CL=06h,AH=10h/CL=09h
----------7F10--CL09-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - UNLOCK MULTIPLE CHANNELS
	AH = 10h
	CL = 09h
	DX = maximum channel number to unlock
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
Notes:	unlocks channels numbered 00h through the value in DX
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=03h,AH=10h/CL=07h,AH=10h/CL=08h
----------7F11-------------------------------
INT 7F - Alloy NTNX, MW386 - SEND DATAGRAM
	AH = 11h
	DX:SI -> request block (see below)
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
	    0Ah packet too large (or <2 bytes if NTNX)
	    0Bh can't send packet to itself
	    0Ch invalid number of destinations
	    0Dh destination channel number out of range
	    0Eh destination user is busy
	    0Fh destination user has locked channel
	    10h channel not open
	    11h no datagram server on destination (NTNX)
Note:	if wildcard channel FFh used, actual channel number will be filled in
SeeAlso: AH=12h

Format of request block:
Offset	Size	Description
 00h	DWORD	pointer to packet to send
 04h	WORD	packet size in bytes (1-4096)
 06h	BYTE	number of destinations for packet (max 1Fh)
 07h 31 BYTEs	destination user IDs (FFh = broadcast to all except sender)
 26h 31 BYTEs	destination channels (FFh = first available channel)
 45h 31 BYTEs	return destination statuses
----------7F12-------------------------------
INT 7F - Alloy NTNX, MW386 - ACKNOWLEDGE DATAGRAM
	AH = 12h
	AL = channel number being acknowledged
	DI:DX = 32-bit status to return to sender
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
	    0Ah channel not open
	    0Bh no message in channel
	    0Ch destination slave busy--retry (NTNX)
	    0Dh destination user not active
	    0Eh destination slave not active (NTNX)
	    0Fh destination disabled datagram service
Note:	also unlocks the channel, allowing the next datagram to be received
SeeAlso: AH=11h,AH=15h/CL=04h
----------7F13--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - RESET USER DATAGRAMS
	AH = 13h
	CL = 00h
Note:	clears all pending datagrams and removes all channels opened in NTNX
	  compatibility mode
----------7F14--CL00-------------------------
INT 7F - Alloy NTNX, MW386 -  SET RECEIVE ISR
	AH = 14h
	CL = 00h
	DX:DI -> application FAR receive service routine (see below)
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
SeeAlso: AH=14h/CL=01h,AH=14h/CL=03h

Service routine called with:
	DH = sender ID
	DL = channel with datagram
	interrupts disabled
Return: AL = response code
	    00h leave buffer locked, set channel status, and repeat call later
	    01h release channel buffer
	    02h change buffer pointer to DX:DI
	AH,CX,DX,DI,SI may be destroyed
----------7F14--CL01-------------------------
INT 7F - Alloy NTNX, MW386 - SET ACKNOWLEDGE ISR
	AH = 14h
	CL = 01h
	DX:DI -> application FAR acknowledge service routine (see below)
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
Note:	the service routine will be called as soon as an acknowledgment arrives
SeeAlso: AH=12h,AH=14h/CL=00h,AH=14h/CL=04h,AH=15/CL=04h

Service routine called with:
	DS:SI -> acknowledge structure (see AH=15h/CL=04h)
Return: AL = response code
	    00h application busy, network executive should call again later
	    01h acknowledge accepted
	AH,DX,SI may be destroyed
----------7F14--CL02-------------------------
INT 7F - Alloy NTNX, MW386 - SET CHANNEL BUFFER POINTER
	AH = 14h
	CL = 02h
	AL = channel number
	DX:DI -> receive buffer
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
Note:	may be called from within a receive ISR or when a datagram is pending
SeeAlso: AH=10h/CL=00h,AH=14h/CL=00h
----------7F14--CL03-------------------------
INT 7F - Alloy NTNX, MW386 - GET RECEIVE ISR
	AH = 14h
	CL = 03h
Return: DX:DI -> current receive ISR
SeeAlso: AH=14h/CL=00h,AH=14h/CL=04h
----------7F14--CL04-------------------------
INT 7F - Alloy NTNX, MW386 - GET ACKNOWLEDGE ISR
	AH = 14h
	CL = 04h
Return: DX:DI -> current acknowledge ISR
SeeAlso: AH=14h/CL=01h,AH=14h/CL=03h
----------7F14--CL05-------------------------
INT 7F - Alloy NTNX (Host), MW386 - GET BUSY POINTER
	AH = 14h
	CL = 05h
	DX:DI -> buffer for busy structure (see below)
Return: DX:DI buffer filled

Format of busy structure:
Offset	Size	Description
 00h	DWORD	pointer to busy flag byte
 04h	WORD	fixed port address (FF00h)
----------7F15--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - GET CHANNEL STATUS
	AH = 15h
	CL = 00h
	AL = channel number
	DX:DI -> status structure (see below)
Return: AL = status
	    00h successful
	    01h busy
	    02h channel range error (not 00h-3Fh)
	    03h invalid subfunction
SeeAlso: AH=15h/CL=01h

Format of status structure:
Offset	Size	Description
 00h	BYTE	channel status
		bit 0: channel open
		    1: channel buffer contains received data
		    7: channel locked
 01h	BYTE	sender ID
----------7F15--CL01-------------------------
INT 7F - Alloy NTNX, MW386 - GET NEXT FULL CHANNEL
	AH = 15h
	CL = 01h
	DX:DI -> full-channel structure
Return: AL = status
	    00h successful
	    01h busy
	    0Ah no datagrams available
Note:	MW386 v1.0 returns the lowest channel with a datagram; newer versions
	  and NTNX return the oldest datagram
SeeAlso: AH=15h/CL=00h

Format of full-channel structure:
Offset	Size	Description
 00h	BYTE	number of channel with oldest datagram
 01h	BYTE	sender ID
----------7F15--CL02-------------------------
INT 7F - Alloy NTNX, MW386 - GET MAXIMUM NUMBER OF CHANNELS
	AH = 15h
	CL = 02h
Return: AH = number of channels available (40h for MW386)
Note:	the application may always assume at least 32 channels available
SeeAlso: AH=15h/CL=03h
----------7F15--CL03-------------------------
INT 7F - Alloy NTNX, MW386 - GET MAXIMUM PACKET SIZE
	AH = 15h
	CL = 03h
	DX:DI -> WORD for return value
Return: buffer WORD filled with maximum packet size (4096 for MW386)
SeeAlso: AH=15h/CL=02h
----------7F15--CL04-------------------------
INT 7F - Alloy NTNX, MW386 - GET AND CLEAR ACKNOWLEDGE STATUS
	AH = 15h
	CL = 04h
	DX:DI -> status structure (see below)
Return: AL = status
	    00h successful
		DX:DI structure filled
	    01h busy
	    0Ah no acknowledgement has arrived
SeeAlso: AH=12h,AH=14h/CL=01h

Format of status structure:
Offset	Size	Description
 00h	BYTE	sender ID
 01h	BYTE	channel number
 02h  4 BYTEs	receiver status (see AH=12h)
----------7F16-------------------------------
INT 7F - Alloy NTNX, MW386 - DIRECT MEMORY TRANSFER
	AH = 16h
	DX:SI -> transfer structure (see below)
Return: AL = status
	    00h successful
	    0Ah source or destination out of range
	    0Bh transfer kernal busy--try again
Notes:	this call transfers memory contents directly between users; both source
	  and destination user IDs may differ from the caller's ID
	no segment wrap is allowed

Format of transfer structure:
Offset	Size	Description
 00h	WORD	bytes to transfer
 02h	BYTE	source ID
		FEh = caller
 03h	DWORD	source address
 07h	BYTE	destination ID
		FFh = all slaves except caller
		FEh = caller
 08h	DWORD	destination address
----------7F21-------------------------------
INT 7F - Alloy NTNX, MW386 - SEND MESSAGE OR COMMAND TO USER(S)
	AH = 21h
	AL = sender's user ID
	DS:DX -> control packet (see below)
Note:	messages or commands are ignored if disabled by the destination user
SeeAlso: AH=22h

Format of control packet:
Offset	Size	Description
 00h	BYTE	packet type
		00h message
		01h NTNX command
		02h MW386 command
 01h	BYTE	destination user ID or 'A' for all users
 02h 62 BYTEs	ASCIZ message (packet type 00h)
		BIOS keycodes terminated by NUL byte (type 01h) or word (02h)
Note:	a maximum of 16 keycodes will be processed for NTNX and MW386 commands
----------7F22-------------------------------
INT 7F - Alloy NTNX - GET MESSAGE
	AH = 22h
Return: pending messages displayed on user's screen
SeeAlso: AH=21h
----------7F24-------------------------------
INT 7F - Alloy NTNX, MW386 - ATTACH OR RELEASE DRIVE FOR LOW-LEVEL WRITE ACCESS
	AH = 24h
	CL = function
	    00h attach
	    01h release
	CH = drive (0=A:,1=B:,etc)
Return: AX = status
	    00h successful
	    01h invalid request
	    02h already attached
	    03h not attached
	    04h lock table full
Note:	only drives on the current machine may be attached
----------7F24-------------------------------
INT 7F - Alloy NTNX - ATTACH/RELEASE HOST PROCESSOR
	AH = 24h
	CL = function
	    02h attach host
	    03h release host
Return: AX = status
	    00h successful
	    01h invalid request
	    02h already attached
	    03h not attached
	    04h lock table full
Note:	the host processor may be attached in order to perform I/O via the host
----------7F25--CL00-------------------------
INT 7F - Alloy ANSK, NTNX, MW386 - GET NETWORK EXECUTIVE VERSION
	AH = 25h
	CL = 00h            
Return: AH = version suffix letter
	CH = major version number
	CL = minor version number
SeeAlso: AH=25h/CL=01h
----------7F25--CL01-------------------------
INT 7F - Alloy ANSK, NTNX, MW386 - GET NETWORK EXECUTIVE TYPE
	AH = 25h
	CL = 01h
Return: CL = type
	    00h RTNX
	    01h ATNX
	    02h NTNX
	    03h BTNX
	    04h MW386
	    05h ANSK
SeeAlso: AH=25h/CL=00h
----------7F26--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - GET NTNX FILE MODE
	AH = 26h
	CL = 00h
Return: AX = file mode bits
	    bit 0: directory protection enabled
		1: extended open enabled
		2: flush on every disk write
		3: flush on every disk write in locked interval
		4: flush on reads from simultaneously opened file
Note:	MW386 does not support file modes, and always returns AX=001Fh
SeeAlso: AH=26h,AH=26h/CL=06h
----------7F26-------------------------------
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
----------7F26--CL06-------------------------
INT 7F - Alloy NTNX - CANCEL FLUSH ON WRITE
	AH = 26h
	CL = 06h
Note:	cancels flags set by AH=26h/CL=03h and AH=26h/CL=04h
SeeAlso: AH=26h/CL=00h
----------7F30-------------------------------
INT 7F - Alloy MW386 - GET PORT INFORMATION
	AH = 30h
	CX = MW386 port number
Return: AL = FFh if port not found
	   else	 driver unit number
	       BL = port mode
	       BH = port type
		   02h remote
	       DH = owner's machine ID
	       DL = owner's user ID
SeeAlso: INT 17/AH=8Bh
----------7F31-------------------------------
INT 7F - Alloy MW386 v1.x only - CHECK PORT ASSIGNMENT
	AH = 31h
	???
Return: ???
----------7F37-------------------------------
INT 7F - Alloy NTNX (Host) - GET SEMAPHORE TABLE
	AH = 37h
Return: ES:AX -> semaphore table
----------7F37-------------------------------
INT 7F - Alloy ANSK, NTNX (Slave) - DUMP STRING TO TERMINAL
	AH = 37h
	DS:DX -> ASCIZ string to display
Note:	if the string is empty, a terminal update will be forced
----------7F38-------------------------------
INT 7F - Alloy NTNX (Slave), MW386 - SET NEW TERMINAL DRIVER
	AH = 38h
	AL = new terminal driver number
	    FFh dummy driver
	    FEh current driver
	    FDh load new driver
		DS:SI -> new driver
SeeAlso: AH=39h
----------7F39-------------------------------
INT 7F - Alloy MW386 - SET TERMINAL DRIVER FOR ANOTHER USER
	AH = 39h
	AL = new terminal driver number
	DL = user number (FFh = caller)
	DH = machine number if DL <> FFh
Return: CF set if invalid user number
	CF clear if successful
Notes:	only available to supervisors
	the new driver number will not take effect until the user is rebooted
SeeAlso: AH=38h
----------7F3A-------------------------------
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
----------7F3B-------------------------------
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
----------7F3C-------------------------------
INT 7F - Alloy MW386 - ENABLE/DISABLE AUTOBAUD DETECT
	AH = 3Ch
	AL = new state
	     00h disabled, 01h enabled
	DL = user number (FFh = caller)
	DH = machine number for user
Return: CF set if invalid user number
Note:	only available to supervisors
SeeAlso: AH=3Dh
----------7F3D-------------------------------
INT 7F - Alloy MW386 - POST TERMINAL CONFIGURATION CHANGES
	AH = 3Dh
Note:	should be called whenever a program changes the terminal type or its
	  parameters
SeeAlso: AH=3Bh
----------7F41-------------------------------
INT 7F - Alloy NTNX - LOCK FILE FOR USER
	AH = 41h
	AL = user ID
	DS:DX -> ASCIZ filename
Return: AL = status
	    00h successful
	    01h invalid function
	    02h already locked
	    03h unable to lock
	    04h lock table full
SeeAlso: AH=00h,,AH=41"MW386",AH=42h"NTNX"
----------7F41-------------------------------
INT 7F - Alloy MW386 - LOCK SEMAPHORE FOR USER
	AH = 41h
	AL = user ID
	DS:DX -> ASCIZ semaphore name
Return: AL = status
	    00h successful
	    01h invalid function
	    02h semaphore already locked
	    03h unable to lock semaphore
	    04h semaphore space exhausted
SeeAlso: AH=00h,AH=42h"MW386"
----------7F42-------------------------------
INT 7F - Alloy NTNX - LOCK FILE FOR USER
	AH = 42h
	AL = user ID
	DS:DX -> ASCIZ filename
Return: AL = status
	    00h successful
	    01h invalid function
	    02h already locked
	    03h unable to lock
	    04h lock table full
SeeAlso: AH=00h,AH=41h"NTNX",AH=42"MW386"
----------7F42-------------------------------
INT 7F - Alloy MW386 - UNLOCK SEMAPHORE FOR USER
	AH = 42h
	AL = user ID
	DS:DX -> ASCIZ semaphore name
Return: AL = status
	    00h successful
	    01h invalid function
	    03h unable to unlock semaphore
SeeAlso: AH=02h,AH=41h"MW386",AH=42h"NTNX"
----------7F4E-------------------------------
INT 7F - Alloy MW386 v2+ - SET ERROR MODE
	AH = 4Eh
	AL = error mode flags
	    bit 0: display critical disk errors
		1: display sharing errors
	DX = 4E58h ("NX")
Return: AL = status
	    00h successful
SeeAlso: AH=4Fh
----------7F4F-------------------------------
INT 7F - Alloy MW386 v2+ - SET FCB MODE
	AH = 4Fh
	AL = FCB mode
	    02h read/write compatibility
	    42h read/write shared
	DX = 4E58h ("NX")
Return: AL = status
	    00h successful
----------7F81-------------------------------
INT 7F - Alloy NTNX - ATTACH DEVICE FOR USER
	AH = 81h
	AL = user ID
	DS:DX -> ASCIZ device name
SeeAlso: AH=82h
----------7F82-------------------------------
INT 7F - Alloy NTNX - RELEASE DEVICE FOR USER
	AH = 82h
	AL = user ID
	DS:DX -> ASCIZ device name
SeeAlso: AH=81h
----------7FA0-------------------------------
INT 7F - Alloy MW386 - GET USER NAME
	AH = A0h
	DL = user number (FFh = caller)
	DH = machine number for user
	ES:DI -> 17-byte buffer for ASCIZ user name
Return: CF set if invalid user number
SeeAlso: AH=03h,AH=A1h
----------7FA1-------------------------------
INT 7F - Alloy MW386 - GET MACHINE, USER, AND PROCESS NUMBER
	AH = A1h
Return: AL = process number
	DL = user number
	DH = machine number
SeeAlso: AH=03h,AH=A0h,AH=A2h
----------7FA2-------------------------------
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
----------7FA3-------------------------------
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
----------7FA4-------------------------------
INT 7F - Alloy MW386 - VERIFY USER PASSWORD
	AH = A4h
	DS:DX -> ASCIZ password (null-padded to 16 bytes)
Return: AL = 00h if accepted
	   else	 invalid password
----------7FA5-------------------------------
INT 7F - Alloy MW386 - GET/SET USER STATUS
	AH = A5h
	AL = function
	    00h get status
		Return: BX = user flags
			    bit 5: allow messages
			CL = scan code for task manager hotkey
			CH = scan code for spooler hotkey
			DL = scan code for task swapper hotkey
			DH = modifier key status
	    01h set status
		BX = user flags (see above)
		CL = scan code for task manager hotkey
		CH = scan code for spooler hotkey
		DL = scan code for task swapper hotkey
		DH = modifier key status
	DI = machine number and user number
Return: CF set if invalid user number
Note:	must have supervisor privilege to set another user's status
----------7FB0-------------------------------
INT 7F - Alloy NTNX, MW386 - RELEASE ALL SEMAPHORES FOR USER
	AH = B0h
	AL = user number
	DS = code segment
Note:	MW386 ignores AL and DS; it releases all semaphores locked using INT 67
	  or INT 7F locking functions
SeeAlso: AH=B1h,AH=B2h,AH=B3h,AH=B4h
----------7FB1-------------------------------
INT 7F - Alloy NTNX, MW386 - RELEASE NORMAL SEMAPHORES FOR USER
	AH = B1h
	AL = (bits 7-5) 000
	     (bits 4-0) user ID
Note:	MW386 ignores AL; it releases all semaphores locked using INT 67 or
	  INT 7F locking functions
SeeAlso: AH=B0h,AH=B2h,AH=B3h,AH=B4h
----------7FB2-------------------------------
INT 7F - Alloy NTNX - RELEASE MESSAGES FOR USER
	AH = B2h
	AL = (bits 7-5) 001
	     (bits 4-0) user ID
SeeAlso: AH=B0h,AH=B1h,AH=B3h,AH=B4h
----------7FB3-------------------------------
INT 7F - Alloy NTNX - RELEASE FILES FOR USER
	AH = B3h
	AL = (bits 7-5) 010
	     (bits 4-0) user ID
SeeAlso: AH=B0h,AH=B1h,AH=B2h,AH=B4h
----------7FB4-------------------------------
INT 7F - Alloy NTNX - RELEASE DEVICES FOR USER
	AH = B4h
	AL = user ID
SeeAlso: AH=B0h,AH=B1h,AH=B2h,AH=B3h
----------7FC3-------------------------------
INT 7F - Alloy MW386 - WRITE BYTE TO TERMINAL AUX PORT
	AH = C3h
	AL = byte to write
Return: CF clear if successful
	CF set on error
SeeAlso: AH=C6h
----------7FC5-------------------------------
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
Note:	modes 2 and 3 may be user for input through the console port; no video
	  output should be performed in these modes
----------7FC6-------------------------------
INT 7F - Alloy MW386 - WRITE BYTE TO CONSOLE PORT
	AH = C6h
	AL = byte to write
Return: CF clear if successful
	CF set on error (caller is not remote user)
Note:	any terminal driver data translation will be bypassed
SeeAlso: AH=C3h,AH=C7h
----------7FC7-------------------------------
INT 7F - Alloy MW386 - READ CONSOLE DATA BYTE
	AH = C7h
Return: CF clear if successful
	    AL = byte read
	CF set on error (no data available or caller is not remote user)
Note:	used to read data after placing console in mode 2 or 3 (see AH=C5h)
SeeAlso: AH=C5h,AH=C6h,AH=C8h
----------7FC8-------------------------------
INT 7F - Alloy MW386 - READ CONSOLE DATA INTO BUFFER
	AH = C8h
	AL = maximum bytes to read
	ES:DI -> buffer for console data
Return: CF clear if successful
	    CX = number of bytes read
	CF set on error (caller is not remote user)
SeeAlso: AH=C7h
----------7FCF-------------------------------
INT 7F - Alloy NTNX - REBOOT USER PROCESSOR
	AH = CFh
	DS:DX -> ASCIZ string containing user number to be reset
SeeAlso: AH=D6h
----------7FD6-------------------------------
INT 7F - Alloy MW386 - RESET NETWORK EXECUTIVE
	AH = D6h
	DS:DX -> reset packet (see below)
Return: never if succesful
Note:	all users will be shut down immediately if successful
SeeAlso: AH=CFh

Format of reset packet:
Offset	Size	Description
 00h	DWORD	reset code (60606060h)
 04h 16 BYTEs	ASCIZ supervisor password padded with nulls
----------7FD7-------------------------------
INT 7F - Alloy MW386 - POST EVENT
	AH = D7h
	AL = user number (if local event)
	DX = event number
----------7FD8-------------------------------
INT 7F - Alloy MW386 - FLUSH DISK BUFFERS
	AH = D8h
Return: CF set on error
Note:	forces all disk buffers to be written out immediately
SeeAlso: INT 21/AH=0Dh,INT 21/AX=5D01h,INT 2F/AX=1120h
----------7FDB-------------------------------
INT 7F - Alloy MW386 v2+ - GET MW386 INVOCATION DRIVE
	AH = DBh
Return: AL = drive from which MW386 was started (2=C:,3=D:,etc)
----------7FE0-------------------------------
INT 7F - Alloy MW386 - CREATE DOS TASK
	AH = E0h
	AL = memory size (00h=128K, 01h=256K, 02h=384K, 03h=512K, 04h=640K)
	DS:DX -> ASCIZ task name (max 16 bytes)
Return: CF clear if successful
	    AL = task create ID
	CF set on error
Note:	only foreground DOS tasks can use this function
SeeAlso: AH=E1h,AH=E2h,AH=E3h,AH=E6h,AH=E7h
----------7FE1-------------------------------
INT 7F - Alloy MW386 - GET DOS TASK PID FROM CREATE ID
	AH = E1h
	AL = create ID (from AH=E0h)
Return: AL = DOS process number
	CL = memory size (00h=128K, 01h=256K, 02h=384K, 03h=512K, 04h=640K)
Note:	this function should not be called immediately after creating a new
	  DOS task, since the new task is being initialized by a concurrent
	  process
SeeAlso: AH=E0h,AH=E2h
----------7FE2-------------------------------
INT 7F - Alloy MW386 - SWITCH TO NEW DOS TASK
	AH = E2h
	AL = DOS process number (from AH=E1h)
Return: CF set on error (invalid process number or caller not foreground task)
Notes:	specified task becomes the foreground task and current task is placed
	  in the background
	may only be called by a foreground task
SeeAlso: AH=E0h,AH=E1h
----------7FE3-------------------------------
INT 7F - Alloy MW386 - CHANGE NAME OF DOS TASK
	AH = E3h
---v1.x---
	AL = user number
---v2+---
	BH = user number
	BL = task number
---
	DS:DX -> ASCIZ task name
Return: CF set on error (invalid process number)
SeeAlso: AH=E0h,AH=E4h,AH=E5h
----------7FE4-------------------------------
INT 7F - Alloy MW386 - GET TASK NAME FROM PROCESS NUMBER
	AH = E4h
---v1.x---
	AL = user number
---v2+---
	BH = user number
	BL = task number
---
	ES:DI -> buffer for task name
Return: CF clear if successful
	    CL = memory size (00h=128K, 01h=256K, 02h=384K, 03h=512K, 04h=640K)
	    DX = task flags
		bit 7: MSDOS process
	    ES:DI buffer filled
	CF set on error (invalid process number)
SeeAlso: AH=E3h,AH=E5h
----------7FE5-------------------------------
INT 7F - Alloy MW386 - GET PROCESS NUMBER FROM TASK NAME
	AH = E5h
	DS:DX -> ASCIZ task name
	BH = user number
Return: CF clear if successful
	    AL = DOS process number
	    CL = memory size (00h=128K, 01h=256K, 02h=384K, 03h=512K, 04h=640K)
	CF set on error (no match for name)
SeeAlso: AH=E3h,AH=E4h
----------7FE6-------------------------------
INT 7F - Alloy MW386 - GET NUMBER OF AVAILABLE USER TASKS
	AH = E6h
Return: AX = number of processes available to current user
SeeAlso: AH=E0h
----------7FE7-------------------------------
INT 7F - Alloy MW386 - REMOVE DOS TASK
	AH = E7h
	AL = DOS process number
Return: CF set on error (invalid process number or first process)
Note:	can only be called by a foreground task
SeeAlso: AH=E0h
----------7FE8-------------------------------
INT 7F - Alloy MW386 - DOS TASK DELAY
	AH = E8h
	CX = delay time in milliseconds
Note:	a delay of 0 may be used to surrender the current time slice
SeeAlso: INT 15/AX=1000h,INT 21/AH=EEh"DoubleDOS",INT 2F/AX=1680h
----------7FF0-------------------------------
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
----------7FF1-------------------------------
INT 7F - Alloy MW386 - ASSIGN DIRECTORY TO GROUP
	AH = F1h
	AL = group number
	DS:DX -> ASCIZ directory name
Notes:	performs permanent assignment to a group; no immediate action is taken
	  unless the directory has been restricted with AH=F0h
	may be used to restrict a nonexistent directory
SeeAlso: AH=F0h
----------7FF2-------------------------------
INT 7F - Alloy MW386 - READ RESTRICTED DIRECTORY ENTRY
	AH = F2h
	CX = entry number
	ES:DI -> 64-byte buffer
Return: CF clear if successful
	    buffer filled with 63-byte directory info and 1-byte group number
	CF set on error (invalid entry)
SeeAlso: AH=F0h,AH=F3h
----------7FF3-------------------------------
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
----------7FF8-------------------------------
INT 7F - Alloy MW386 - ASSIGN USER TO GROUP
	AH = F8h
	AL = group number
	DL = user number
	DH = machine number (currently 00h)
Return: CF clear if successful
	CF set on error (user already in maximum number of groups)
Note:	each user is allowed eight group assignments
SeeAlso: AH=F9h,AH=FAh
----------7FF9-------------------------------
INT 7F - Alloy MW386 - REMOVE USER FROM GROUP
	AH = F9h
	AL = group number
	DL = user number
	DH = machine number (currently 00h)
Return: CF set if failed
SeeAlso: AH=F8h,AH=FAh
----------7FFA-------------------------------
INT 7F - Alloy MW386 - GET USER GROUP LIST
	AH = FAh
	DL = user number
	DH = machine number (currently 00h)
	ES:DI -> 16-byte buffer for group list
Return: CX = number of groups
	ES:DI buffer filled with group numbers
SeeAlso: AH=F8h,AH=F9h
----------7FFB-------------------------------
INT 7F - Alloy MW386 - ASSIGN GROUP NAME
	AH = FBh
	CL = group number
	ES:DI -> ASCIZ group name (max 17 bytes)
SeeAlso: AH=FCh
----------7FFC-------------------------------
INT 7F - Alloy MW386 - GET GROUP NAME
	AH = FCh
	CL = group number
	ES:DI -> 17-byte buffer for ASCIZ name
Return: ES:DI buffer filled
Note:	if the group has not been named, "(unnamed)" is returned
SeeAlso: AH=FBh
----------80---------------------------------
INT 80 - Q-PRO4 - ???
----------80---------------------------------
INT 80 - reserved for BASIC
----------80----BX0000-----------------------
INT 80 - SoundBlaster SBFM driver - GET VERSION
	BX = 0000h
Note:	SBFM installs at a free interrupt in the range 80h through BFh
SeeAlso: BX=0008h
----------80----BX0001-----------------------
INT 80 - SoundBlaster SBFM driver - SET MUSIC STATUS BYTE ADDRESS
	BX = 0001h
	DX:AX -> music status byte
SeeAlso: BX=0000h,BX=0002h,BX=0003h
----------80----BX0002-----------------------
INT 80 - SoundBlaster SBFM driver - SET INSTRUMENT TABLE
	BX = 0002h
	CX = number of instruments
	DX:AX -> instrument table
SeeAlso: BX=0000h,BX=0001h,BX=0005h
----------80----BX0003-----------------------
INT 80 - SoundBlaster SBFM driver - SET SYSTEM CLOCK RATE
	BX = 0003h
	AX = clock rate divisor (1193180 / desired frequency in Hertz)
	    FFFFh to restore to 18.2 Hz
SeeAlso: BX=0000h,BX=0001h,BX=0004h
----------80----BX0004-----------------------
INT 80 - SoundBlaster SBFM driver - SET DRIVER CLOCK RATE
	BX = 0004h
	AX = driver clock rate divisor (1193180 / frequency in Hertz)
Note:	default frequency is 96 Hz
SeeAlso: BX=0000h,BX=0003h
----------80----BX0005-----------------------
INT 80 - SoundBlaster SBFM driver - TRANSPOSE MUSIC
	BX = 0005h
	AX = semi-tone offset
SeeAlso: BX=0000h,BX=0002h,BX=0006h
----------80----BX0006-----------------------
INT 80 - SoundBlaster SBFM driver - PLAY MUSIC
	BX = 0006h
	DX:AX -> music block
Return: AX = status
	    0000h successful
	    0001h music already active
SeeAlso: BX=0000h,BX=0007h,BX=000Ah
----------80----BX0007-----------------------
INT 80 - SoundBlaster SBFM driver - STOP MUSIC
	BX = 0007h
Return: AX = status
	    0000h successful
	    0001h music not active
SeeAlso: BX=0000h,BX=0006h,BX=0009h
----------80----BX0008-----------------------
INT 80 - SoundBlaster SBFM driver - RESET DRIVER
	BX = 0008h
Return: AX = status
	    0000h successful
	    0001h music is active
SeeAlso: BX=0000h
----------80----BX0009-----------------------
INT 80 - SoundBlaster SBFM driver - PAUSE MUSIC
	BX = 0009h
Return: AX = status
	    0000h successful
	    0001h no music active
SeeAlso: BX=0000h,BX=0007h,BX=000Ah
----------80----BX000A-----------------------
INT 80 - SoundBlaster SBFM driver - RESUME MUSIC
	BX = 000Ah
Return: AX = status
	    0000h successful
	    0001h no music paused
SeeAlso: BX=0000h,BX=0006h,BX=0009h
----------80----BX000B-----------------------
INT 80 - SoundBlaster SBFM driver - SET USER-DEF TRAP FOR SYSTEM-EXCLUSIVE CMDS
	BX = 000Bh
	DX:AX -> trap routine
SeeAlso: BX=0000h
----------8001-------------------------------
INT 80 - QPC Software PKTINT.COM - INITIALIZE
	AH = 01h
Return: AX = 0000h
	CX = FFFFh
	DX = FFFFh
Notes:	this interrupt is the WinQVTNet protected mode interface to Windows 3.0
	all buffer pointers are reset back to 0
----------8002-------------------------------
INT 80 - QPC Software PKTINT.COM - GET SEGMENT ADDRESSES
	AH = 02h
	BX = extra bytes to allocate per packet
Return: AX = segment address of 10K buffer (for receives???)
	BX = segment address of 2K buffer (for sends???)
SeeAlso: AH=05h
----------8003-------------------------------
INT 80 - QPC Software PKTINT.COM - GET ENTRY POINT
	AH = 03h
Return: CX:DX -> receive call address
Note:	the returned address can be used in the packet driver calls since it
	  will be a valid address in all DOS boxes
SeeAlso: AH=06h
----------8004-------------------------------
INT 80 - QPC Software PKTINT.COM - ENABLE???
	AH = 04h
	BX = ???
Return: ???
----------8005-------------------------------
INT 80 - QPC Software PKTINT.COM - GET STATISTICS
	AH = 05h
Return: AX = amount of buffer currently in use
	BX = current offset in buffer
	CX = number of times receive has been called
SeeAlso: AH=02h
----------8006-------------------------------
INT 80 - QPC Software PKTINT.COM - REMOVE RECEIVED PACKET
	AH = 06h
Return: BX = next packet offset
	CX = number of bytes still buffered
	DX = size of packet released back into buffer pool
SeeAlso: AH=03h
----------81---------------------------------
INT 81 - reserved for BASIC
----------81---------------------------------
INT 81 - IBM TOKEN RING ADAPTER - ???
----------82---------------------------------
INT 82 - reserved for BASIC
----------82---------------------------------
INT 82 - IBM TOKEN RING ADAPTER - ???
	AH = function
	    00h display message???
		DS:BX -> string
	???
Return: ???
----------83---------------------------------
INT 83 - reserved for BASIC
----------84---------------------------------
INT 84 - reserved for BASIC
----------85---------------------------------
INT 85 - reserved for BASIC
----------86---------------------------------
INT 86 - NetBIOS - ORIGINAL INT 18
Note:	some implementations of NetBIOS reportedly relocate INT 18 here
SeeAlso: INT 18
----------86---------------------------------
INT 86 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------86---------------------------------
INT 86 - APL*PLUS/PC - Terminate APL session and return to DOS
----------87---------------------------------
INT 87 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------87---------------------------------
INT 87 - APL*PLUS/PC - ????
----------88---------------------------------
INT 88 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------88----AL00-------------------------
INT 88 - APL*PLUS/PC - CREATE OBJECT OF ARBITRARY RANK OR SHAPE
	AL = 00h
	BX = STPTR of the variable to be assigned
	ES:SI -> model of type, rank, and shape (see below)
Return: ES:DI -> first data byte of object
	DX:CX = number of elements in the object
SeeAlso: INT C8"APL"

Format of shape model:
Offset	Size	Description
 00h	BYTE	type
		01h character (2-byte dimension sizes)
		02h integer (2-byte dimension sizes)
		08h floating point (2-byte dimension sizes)
		11h character (4-byte dimension sizes)
		12h integer (4-byte dimension sizes)
		18h floating point (4-byte dimension sizes)
 01h	BYTE	rank
 02h	WORD/DWORD first dimension of shape
 N	WORD/DWORD second dimension of shape
	...
----------88----AL01-------------------------
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
----------88----AL02-------------------------
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
----------88----AL08-------------------------
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
----------88----ALF5-------------------------
INT 88 - APL*PLUS/PC - FORCE OBJECT INTO REAL WORKSPACE FROM VIRTUAL
	AL = F5h
	BX = STPTR of object
SeeAlso: INT C8"APL"
----------88----ALF6-------------------------
INT 88 - APL*PLUS/PC - MAKE NAME IMMUNE FROM OUTSWAPPING
	AL = F6h
	BX = STPTR of object
SeeAlso: AL=F7h,AL=F8h,INT C8"APL"
----------88----ALF7-------------------------
INT 88 - APL*PLUS/PC - MAKE NAME ELIGIBLE FOR OUTSWAPPING
	AL = F7h
	BX = STPTR of object
SeeAlso: AL=F6h,AL=F8h,INT C8"APL"
----------88----ALF8-------------------------
INT 88 - APL*PLUS/PC - REPORT WHETHER NAME IS ELIGIBLE FOR OUTSWAPPING
	AL = F8h
	BX = STPTR of object
Return:	 BX = 0000h eligible
	      0001h not eligible
SeeAlso: AL=F6h,AL=F7h,INT C8"APL"
----------88----ALF9-------------------------
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
----------88----ALFC-------------------------
INT 88 - APL*PLUS/PC - DETERMINE IF MEMORY AVAIL WITHOUT GARBAGE COLLECTION
	AL = FCh
	BX = amount of memory needed (paragraphs)
Return: CF clear if memory available
	CF set if a workspace compaction is required
SeeAlso: AL=FDh,INT C8"APL"
----------88----ALFD-------------------------
INT 88 - APL*PLUS/PC - PERFORM GARBAGE COLLECTION AND RETURN AVAILABLE MEMORY
	AL = FDh
Return: BX = number of paragraphs available in workspace
SeeAlso: AL=FCh,INT C8"APL"
----------88----ALFE-------------------------
INT 88 - APL*PLUS/PC - CREATE NAME
	AL = FEh
	ES:SI -> name
	CX = length of name
Return: BX = STPTR of name
	DX = interpreter's data segment
SeeAlso: AL=F9h,AL=FFh,INT C8"APL"
----------88----ALFF-------------------------
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
----------89---------------------------------
INT 89 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------8A---------------------------------
INT 8A - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------8A---------------------------------
INT 8A - APL*PLUS/PC - PRINT SCREEN
Note:	same as INT 05
SeeAlso: INT 05,INT CA"APL"
----------8B---------------------------------
INT 8B - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------8B---------------------------------
INT 8B - APL*PLUS/PC - BEEP
Note:	same as printing a ^G via INT 21/AH=02h
SeeAlso: INT 21/AH=02h,INT CB"APL"
----------8C---------------------------------
INT 8C - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------8C---------------------------------
INT 8C - APL*PLUS/PC - CLEAR SCREEN MEMORY
	AX = flag
	    0000h do not save display attributes
	    0001h save attributes
SeeAlso: INT CC"APL"
----------8D---------------------------------
INT 8D - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------8E---------------------------------
INT 8E - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------8F---------------------------------
INT 8F - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------90---------------------------------
INT 90 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------90---------------------------------
INT 90 - APL*PLUS/PC - USED BY PORT 10 PRINTER DRIVER
----------91---------------------------------
INT 91 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------91---------------------------------
INT 91 - IBM TOKEN RING ADAPTER - ???
----------92---------------------------------
INT 92 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------92---------------------------------
INT 92 - Sangoma X.25 INTERFACE PROGRAM
	BX:DX -> control block
----------93---------------------------------
INT 93 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------93---------------------------------
INT 93 - IBM TOKEN RING ADAPTER - ???
----------94---------------------------------
INT 94 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------95---------------------------------
INT 95 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------95---------------------------------
INT 95 - APL*PLUS/PC - DETERMINE R= SPACE
Note:	use only when the R= option is invoked on entering APL
----------96---------------------------------
INT 96 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------97---------------------------------
INT 97 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------98---------------------------------
INT 98 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------99---------------------------------
INT 99 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------9A---------------------------------
INT 9A - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------9B---------------------------------
INT 9B - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------9C---------------------------------
INT 9C - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------9D---------------------------------
INT 9D - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------9E---------------------------------
INT 9E - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------9F---------------------------------
INT 9F - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------A0---------------------------------
INT A0 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------A0---------------------------------
INT A0 - APL*PLUS/PC - USED BY APL/GSS*CGI GRAPHICS INTERFACE
SeeAlso: INT 59
----------A1---------------------------------
INT A1 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------A2---------------------------------
INT A2 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------A3---------------------------------
INT A3 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------A4---------------------------------
INT A4 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------A4---------------------------------
INT A4 - Right Hand Man API
	function number in AH
Note: Right-Hand Man is a TSR desk-top utility, and only hooks this interrupt
	while popped up
----------A5---------------------------------
INT A5 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------A6---------------------------------
INT A6 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------A7---------------------------------
INT A7 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------A8---------------------------------
INT A8 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------A9---------------------------------
INT A9 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------AA---------------------------------
INT AA - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------AB---------------------------------
INT AB - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------AC---------------------------------
INT AC - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------AD---------------------------------
INT AD - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------AE---------------------------------
INT AE - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------AF---------------------------------
INT AF - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------B0---------------------------------
INT B0 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------B1---------------------------------
INT B1 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------B2---------------------------------
INT B2 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------B3---------------------------------
INT B3 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------B370-------------------------------
INT B3 - ZIPKEY - GET VERSION
	AH = 70h
Return: AH = major version
	AL = minor version
	CL = number of states and territories in current database
	DH = year of current database - 1900
	DL = month of current database's file date
Notes:	if installed, the string "ZIPKEY" is present at offset 75h in the
	  interrupt handler's segment, and the byte at 7Bh contains the API
	  version number (currently 00h)
	ZIPKEY is a resident ZIPCODE database by Eric Isaacson
----------B371-------------------------------
INT B3 - ZIPKEY - CONVERT TWO-LETTER ABBREVIATION TO STATE CODE
	AH = 71h
	BX = abbreviation, in either case
Return: CF set on error
	    AL = FFh
	CF clear if successful
	    AL = ZIPKEY state code
SeeAlso: AH=72h
----------B372-------------------------------
INT B3 - ZIPKEY - CONVERT STATE CODE TO TWO-LETTER ABBREVIATION
	AH = 72h
	BL = ZIPKEY state code
Return: CF set on error
	CF clear if successful
	    AX = abbreviation, in upper case
SeeAlso: AH=71h,AH=73h
----------B373-------------------------------
INT B3 - ZIPKEY - CONVERT STATE CODE TO STATE NAME
	AH = 73h
	BL = ZIPKEY state code
	ES:DI -> buffer for name
Return: CF set on error
	CF clear if successful
	    ES:DI points one byte beyond end of name
SeeAlso: AH=72h
----------B374-------------------------------
INT B3 - ZIPKEY - CONVERT ZIPCODE TO ASCII DIGITS
	AH = 74h
	DX = zipcode region (0-999)
	CH = last two digits of zipcode (0-99)
	ES:DI -> buffer
Return: CF set on error
	CF clear if successful
	    ES:DI points one byte beyond end of digit string
----------B375-------------------------------
INT B3 - ZIPKEY - LOOK UP STATE CODE FOR ZIPCODE
	AH = 75h
	DX = zipcode region (0-999)
	CH = last two digits of zipcode (0-99)
Return: CF set on error (zipcode not found)
	    AL = suggested state code, FFh if none
	CF clear if successful
	    AL = ZIPKEY state code
SeeAlso: AH=76h,AH=79h
----------B376-------------------------------
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
	    ES:DI points one byte beyond end of name
SeeAlso: AH=75h,AH=78h
----------B377-------------------------------
INT B3 - ZIPKEY - PLAY BACK EXIT KEY FOR ENTRY WITH GIVEN ZIPCODE
	AH = 77h
	DX = zipcode region (0-999)
	CH = last two digits of zipcode (0-99)
	BX = 16-bit BIOS keycode for a defined ZIPKEY alternate exit key
Return: CF set on error
	CF clear if successful	
	    zipcode specification as defined by the BX keystroke is placed in
	      keyboard buffer, as if the user had popped up ZIPKEY and exited
	      by pressing the key specified by BX
----------B378-------------------------------
INT B3 - ZIPKEY - LOOK UP ZIPCODES FOR A GIVEN STATE AND CITY
	AH = 78h
	BL = ZIPKEY state code
	DS:SI -> city name, terminated with 0Dh if complete name, 00h if prefix
Return: BH = number of matching entries (set to 51 if more than 50)
	DX = zipcode region of first match (0-999)
	CL = last two digits of first zipcode in the range (0-99)
	CH = last two digits of last zipcode in the range (0-99)
SeeAlso: AH=79h,AH=7Ah
----------B379-------------------------------
INT B3 - ZIPKEY - LOOK UP ZIPCODES FOR A GIVEN CITY
	AH = 79h
	BL = ZIPKEY state code of first state to search
	DS:SI -> city name, terminated with 0Dh if complete name, 00h if prefix
Return:	AL = ZIPKEY state code of first matching state
	BH = number of matching entries (set to 51 if more than 50)
	DX = zipcode region of first match (0-999)
	CL = last two digits of first zipcode in first range (0-99)
	CH = last two digits of last zipcode in first range (0-99)
Note:	to find all matching cities, repeat search with BL set to one more than
	  the returned AL
SeeAlso: AH=78h,AH=7Ah
----------B37A-------------------------------
INT B3 - ZIPKEY - FETCH AN ENTRY FROM A PREVIOUS LOOKUP
	AH = 7Ah
	BL = case number (0 to one less than value returned in BH by lookup)
Return: AL = ZIPKEY state code
	DX = zipcode region (0-999)
	CL = last two digits of first zipcode in the range (0-99)
	CH = last two digits of last zipcode in the range (0-99)
SeeAlso: AH=78h,AH=79h
----------B37B-------------------------------
INT B3 - ZIPKEY - GET VALUES NEEDED TO SAVE ZIPKEY CONTEXT
	AH = 7Bh
Return: BL = maximum number of characters for a city name
	BH = ZIPKEY state code for last city-name search
	    FFh if none
	CX:DX = internal code identifying last city search
SeeAlso: AH=7Ch
----------B37C-------------------------------
INT B3 - ZIPKEY - RESTORE ZIPKEY CONTEXT
	AH = 7Ch
	BL = maximum number of characters for a city name
	BH = ZIPKEY state code for last city-name search
	    FFh if none
	CX:DX = internal code returned by AH=7Bh
Return: CF set on error
	CF clear if successful
SeeAlso: AH=7Bh
----------B37D-------------------------------
INT B3 - ZIPKEY - REQUEST POP UP
	AH = 7Dh
	BL = index number to simulate pressing a hotkey
	    FFh for immediate popup with no playback on return
Return: CF set on error
	    AL = FDh already busy with another request
	       = FEh illegal function
	CF clear if successful
	    window popped up and was closed by the user
----------B37E-------------------------------
INT B3 - ZIPKEY - GET NAME OF PRIMARY CITY FOR A ZIPCODE REGION
	AH = 7Eh
	DX = zipcode region (0-999)
	ES:DI -> buffer for name
Return: CF set on error
	    AL = FFh region does not exist
	CF clear if successful
	    AL = ZIPKEY state code
	    ES:DI points one byte beyond end of name
----------B37F-------------------------------
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
----------B4---------------------------------
INT B4 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------B5---------------------------------
INT B5 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------B6---------------------------------
INT B6 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------B7---------------------------------
INT B7 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------B8---------------------------------
INT B8 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------B9---------------------------------
INT B9 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------BA---------------------------------
INT BA - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------BB---------------------------------
INT BB - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------BC---------------------------------
INT BC - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------BD---------------------------------
INT BD - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------BE---------------------------------
INT BE - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------BF---------------------------------
INT BF - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------C0---------------------------------
INT C0 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------C1---------------------------------
INT C1 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------C2---------------------------------
INT C2 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------C3---------------------------------
INT C3 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------C4---------------------------------
INT C4 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------C5---------------------------------
INT C5 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------C6---------------------------------
INT C6 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------C6---------------------------------
INT C6 - APL*PLUS/PC - IDENTICAL TO INT 86
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
----------C7---------------------------------
INT C7 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------C7---------------------------------
INT C7 - APL*PLUS/PC - ???
----------C8---------------------------------
INT C8 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------C8---------------------------------
INT C8 - APL*PLUS/PC - IDENTICAL TO INT 88
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 88"APL"
----------C9---------------------------------
INT C9 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------C9---------------------------------
INT C9 - APL*PLUS/PC - ???
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
----------CA---------------------------------
INT CA - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------CA---------------------------------
INT CA - APL*PLUS/PC - PRINT SCREEN
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 8A"APL"
----------CB---------------------------------
INT CB - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------CB---------------------------------
INT CB - APL*PLUS/PC - BEEP
Notes:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
	same as printing a ^G via INT 21/AH=02h
SeeAlso: INT 8B"APL"
----------CC---------------------------------
INT CC - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------CC---------------------------------
INT CC - APL*PLUS/PC - CLEAR SCREEN MEMORY
	AX = flag
	    0000h do not save display attributes
	    0001h save attributes
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 8C"APL"
----------CD---------------------------------
INT CD - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------CD---------------------------------
INT CD - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------CE---------------------------------
INT CE - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------CE---------------------------------
INT CE - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------CF---------------------------------
INT CF - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------CF---------------------------------
INT CF - APL*PLUS/PC - DEFAULT LOW-RESOLUTION TIMER FOR QUAD MF FUNCTION
----------D0---------------------------------
INT D0 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------D0---------------------------------
INT D0 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------D1---------------------------------
INT D1 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------D1---------------------------------
INT D1 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------D2---------------------------------
INT D2 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------D2---------------------------------
INT D2 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------D3---------------------------------
INT D3 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------D3---------------------------------
INT D3 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------D4---------------------------------
INT D4 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------D4---------------------------------
INT D4 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------D4---------------------------------
INT D4 - PC-MOS/386 - API
----------D5---------------------------------
INT D5 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------D5---------------------------------
INT D5 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------D6---------------------------------
INT D6 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------D6---------------------------------
INT D6 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------D7---------------------------------
INT D7 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------D7---------------------------------
INT D7 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------D8---------------------------------
INT D8 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------D8---------------------------------
INT D8 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------D9---------------------------------
INT D9 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------D9---------------------------------
INT D9 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------DA---------------------------------
INT DA - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------DA---------------------------------
INT DA - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------DB---------------------------------
INT DB - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------DB---------------------------------
INT DB - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------DC---------------------------------
INT DC - PC/370 v4.1- - API
SeeAlso: INT 60"PC/370"
----------DC---------------------------------
INT DC - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------DC---------------------------------
INT DC - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------DD---------------------------------
INT DD - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------DD---------------------------------
INT DD - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
----------DE---------------------------------
INT DE - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------DE---------------------------------
INT DE - APL*PLUS/PC - ???
Note:	appears to be the same as INT 16
----------DF---------------------------------
INT DF - Victor 9000 - SuperBIOS
----------DF---------------------------------
INT DF - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------DF---------------------------------
INT DF - APL*PLUS/PC - SAME AS INT 10
SeeAlso: INT 10
----------E0---------------------------------
INT E0 - CP/M-86 function calls
----------E0---------------------------------
INT E0 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------E0---------------------------------
INT E0 - APL*PLUS/PC - RESTIME HIGH-RESOLUTION TIMER FOR QUAD MF FUNCTION
----------E0---------------------------------
INT E0 - "Micro-128" virus - ???
SeeAlso: INT 70"virus"
----------E1---------------------------------
INT E1 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------E1---------------------------------
INT E1 - PC Cluster Disk Server Information
SeeAlso: INT E2
----------E2---------------------------------
INT E2 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------E2---------------------------------
INT E2 - PC Cluster Program
----------E3---------------------------------
INT E3 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------E40005-----------------------------
INT E4 - Logitech Modula v2.0 - MonitorEntry
	AX = 0005h
	BX = priority
SeeAlso: AX=0006h
----------E40006-----------------------------
INT E4 - Logitech Modula v2.0 - MonitorExit
	AX = 0006h
SeeAlso: AX=0005h
----------E4---------------------------------
INT E4 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------E5---------------------------------
INT E5 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------E6---------------------------------
INT E6 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------E7---------------------------------
INT E7 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------E8---------------------------------
INT E8 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------E9---------------------------------
INT E9 - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------EA---------------------------------
INT EA - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------EB---------------------------------
INT EB - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------EC---------------------------------
INT EC - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------EC---------------------------------
INT EC - used by Alloy NTNX
----------EC---------------------------------
INT EC - Exact - RUNTIME INTERFACE MULTIPLEXOR
	AX = function number (0000h to 0140h)
	STACK:	DWORD address to return to
		any arguments required by function
Return: STACK:	return address popped, but otherwise unchanged
Notes:	this is the interface from applications to the runtime system by Exact
	  Automatisering B.V. of the Netherlands.  By using this interrupt,
	  it can provide DLL-style capabilities under MSDOS.
	the interrupt handler removes the return address and flags placed on
	  the stack by the INT EC, then jumps to the appropriate function
----------ED---------------------------------
INT ED - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------EE---------------------------------
INT EE - used by IBM ROM BASIC while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------EF---------------------------------
INT EF - BASIC - ORIGINAL INT 09 VECTOR
Note:	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT F0"BASIC"
----------EF----CX0473-----------------------
INT EF - GEM - INTERFACE
	CX = 0473h
	DS:DX -> GEM parameter block
----------F0---------------------------------
INT F0 - BASICA.COM, GWBASIC, compiled BASIC - ORIGINAL INT 08 VECTOR
Note:	BASICA.COM does not restore vector on termination
SeeAlso: INT EF"BASIC"
----------F1---------------------------------
INT F1 - reserved for user interrupt
----------F1---------------------------------
INT F1 - SPEECH.COM - CONVERT TEXT STRING TO SPEECH
	DS:BX -> '$'-terminated text string
Note:	SPEECH.COM is a resident text-to-speech converter by Douglas Sisco
----------F1---------------------------------
INT F1 - Andy C. McGuire SPEECH.COM/SAY.COM
----------F2---------------------------------
INT F2 - reserved for user interrupt
----------F2---------------------------------
INT F2 - Andy C. McGuire SPEECH.COM/SAY.COM
----------F3---------------------------------
INT F3 - reserved for user interrupt
----------F4---------------------------------
INT F4 - reserved for user interrupt
----------F4---------------------------------
INT F4 - DoubleDOS - GIVE UP REST OF CURRENT CLOCK TICK AND ALL OF NEXT TICK
SeeAlso: INT 21/AH=EEh"DoubleDOS",INT FE"DoubleDOS"
----------F5---------------------------------
INT F5 - reserved for user interrupt
----------F5---------------------------------
INT F5 - DoubleDOS - ???
----------F6---------------------------------
INT F6 - reserved for user interrupt
----------F6---------------------------------
INT F6 - DoubleDOS - ???
----------F7---------------------------------
INT F7 - reserved for user interrupt
----------F7---------------------------------
INT F7 - DoubleDOS - ???
----------F8---------------------------------
INT F8 - 10 ms INTERVAL TIMER (TANDY???)
----------F8---------------------------------
INT F8 - DoubleDOS - ???
----------F9---------------------------------
INT F9 - reserved for user interrupt
----------F9---------------------------------
INT F9 - DoubleDOS - ???
----------FA---------------------------------
INT FA - USART READY (RS-232C) (TANDY???)
----------FA---------------------------------
INT FA - DoubleDOS - TURN OFF TIMESHARING
SeeAlso: INT 21/AH=EAh"DoubleDOS",INT FB"DoubleDOS"
----------FB---------------------------------
INT FB - USART Rx READY (keyboard) (TANDY???)
----------FB---------------------------------
INT FB - DoubleDOS - TURN ON TIMESHARING
SeeAlso: INT 21/AH=EBh"DoubleDOS",INT FA"DoubleDOS"
----------FC---------------------------------
INT FC - reserved for user interrupt
----------FC---------------------------------
INT FC - DoubleDOS - GET CURRENT SCREEN BUFFER ADDRESS
Return: ES = segment of display buffer
Note:	the display buffer may be moved if multitasking is enabled
SeeAlso: INT 21/AH=ECh"DoubleDOS",INT FB"DoubleDOS"
----------FD---------------------------------
INT FD - reserved for user interrupt
----------FD---------------------------------
INT FD - DoubleDOS - ???
----------FE---------------------------------
INT FE - AT/XT286/PS50+ - destroyed by return from protected mode
----------FE---------------------------------
INT FE - DoubleDOS - GIVE UP TIME
	AL = number of 55ms time slices to give away
SeeAlso: INT 21/AH=EEh"DoubleDOS",INT F4"DoubleDOS"
----------FF---------------------------------
INT FF - AT/XT286/PS50+ - destroyed by return from protected mode
----------FF---------------------------------
INT FF - Z100 - WARM BOOT
---------------------------------------------
Please redistribute the following files unmodified as a group, in a pair of
archives named INTER26A and INTER26B (preferably the original authenticated
PKZIP archives):
	INTERRUP.1ST	the read-me file, containing credits, availability info
	INTERRUP.A	INT 00 through INT 14
	INTERRUP.B	INT 15 through INT 1F
	INTERRUP.C	INT 20 through INT 2E
	INTERRUP.D	INT 2F through INT 5F
	INTERRUP.E	INT 60 through INT FF
	INTERRUP.PRI	a brief introduction to interrupts
	INTPRINT.COM	a simple formatter that also generates a list summary
	INTPRINT.DOC	instructions for INTPRINT
	INTPRINT.C	source code for INTPRINT
	MEMORY.LST	format of the BIOS data area
	INT2QH.*	program to convert list into QuickHelp database
	INT2GUID.*	program to convert list into TurboPower GUIDE database
This compilation is Copyright (c) 1989, 1990, 1991 Ralf Brown
---------------------------------------------
ARPA: ralf@cs.cmu.edu
UUCP: {ucbvax,harvard}!cs.cmu.edu!ralf
BIT:  ralf%cs.cmu.edu@cmuccvma
FIDO: Ralf Brown 1:129/26 or 1:129/53
	or post a message to the DR_DEBUG echo
CIS:  >INTERNET:ralf@cs.cmu.edu
