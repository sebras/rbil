Interrupt List, part 9 of 10
This compilation is Copyright (c) 1989,1990,1991,1992,1993 Ralf Brown
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
SeeAlso: INT 16/AH=FFh"OPTIMA",INT 7A/AX=0001h"AutoCAD"
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
Notes:	this function will cause a NET_AS_ALARM to be generated; it is intended
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
INT 62 u - FGDRIVER v3.03 - "FG_ALLOCATE" - CREATE VIRTUAL VIDEO PAGE
	AX = 0000h
	BX = page number (0000h-003Fh)
Return: AX = status (0000h,0001h,0007h,0008h) (see below)
Program: FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
Notes:	For FGDRIVER v1.10, this function was "FG_GETMODE" (see AX=003Fh);
	  "FG_ALLOCATE" was AX=0042h
	The amount of memory required by the virtual video page depends on the
	  current video mode
	The installation check consists of testing for the signature "FG" ten
	  bytes beyond the start of the interrupt handler
SeeAlso: AX=0001h,AX=0002h,AX=0003h,AX=002Eh
Index:	installation check;Fastgraph/Light

Values for status:
 0000h	successful
 0001h	specified page is a physical or logical page
 0007h	virtual page created/released, but memory control blocks corrupted
 0008h	not enough memory
 0009h	attempt to free a page which was never created
--------V-620001-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_ALLOCCMS" - CREATE LOGICAL VIDEO PAGE (CONVMEM)
	AX = 0001h
	BX = page number (0001h-003Fh)
Return: AX = status (0000h,FFFCh,FFFDh,FFFEh) (see below)
Notes:	For FGDRIVER v1.10, this function was "FG_SETMODE" (see AX=0093h);
	  "FG_ALLOCCMS" was AX=009Dh
	The only operation which is allowed on logical pages is "FG_COPYPAGE"
	  (see AX=0012h)
SeeAlso: AX=0000h,AX=0002h,AX=0003h,AX=0012h,AX=002Eh

Values for status:
 0000h	successful
 FFFCh	insufficient memory
 FFFDh	page already created, or exists as physical or virtual page
 FFFEh	invalid page number
 FFFFh	memory manager not initialized
--------V-620002-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_ALLOCEMS" - CREATE LOGICAL VIDEO PAGE (EMS)
	AX = 0002h
	BX = page number (0001h-003Fh)
Return: AX = status (see AX=0001h)
Notes:	For FGDRIVER v1.10, this function was "FG_TESTMODE" (see AX=00A7h);
	  "FG_ALLOCEMS" was AX=009Eh
	You must first call "FG_INITEMS" (see AX=004Ch) before using this
	  function
	The only operation which is allowed on logical pages is "FG_COPYPAGE"
	  (see AX=0012h)
SeeAlso: AX=0000h,AX=0001h,AX=0003h,AX=0012h,AX=002Eh,AX=004Ch
--------V-620003-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_ALLOCXMS" - CREATE LOGICAL VIDEO PAGE (XMS)
	AX = 0003h
	BX = page number (0001h-003Fh)
Return: AX = status (see AX=0001h)
Notes:	For FGDRIVER v1.10, this function was "FG_BESTMODE" (see AX=0005h),
	  and "FG_ALLOCXMS" was AX=009Fh
	You must first call "FG_INITXMS" (see AX=004Eh) before using this
	  function
	The only operation which is allowed on logical pages is "FG_COPYPAGE"
	  (see AX=0012h)
SeeAlso: AX=0000h,AX=0001h,AX=0002h,AX=0012h,AX=002Eh,AX=004Eh
--------V-620004-----------------------------
INT 62 u - FGDRIVER v1.10,3.03 - "FG_AUTOMODE" - GET VIDEO MODE W/MOST FEATURES
	AX = 0004h
Return: AX = proposed video mode number (see AX=0093h)
Program: FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
SeeAlso: AX=0005h,AX=003Fh,AX=0093h,AX=00A1h,AX=00A7h
--------V-620005-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_BESTMODE" - GET BEST VIDEO MODE GIVEN RESOLUTN
	AX = 0005h
	BX = horizontal resolution
	CX = vertical resolution
	DX = number of video pages required (both physical and virtual)
Return: AX = proposed video mode number or FFFFh if no matching video mode
Notes:	For FGDRIVER v1.10, this function was "FG_EGACHECK" (see AX=0023h);
	   "FG_BESTMODE" was AX=0003h
	You must first call "FG_SVGAINIT" (see AX=00A1h) to get SVGA video
	  modes
SeeAlso: AX=0004h,AX=003Fh,AX=0093h,AX=00A1h,AX=00A7h
--------V-620006-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_BOX" - DRAW UNFILLED RECTANGLE
	AX = 0006h
	BX = left column
	CX = right column
	DX = top row
	SI = bottom row
Notes:	For FGDRIVER v1.10, this function was "FG_RESET" (see AX=0081h);
	  "FG_BOX" was AX=00A2h
	The rectangle is drawn in screen space, respecting the clipping region,
	  with edges of the width specified with "FG_BOXDEPTH" (see AX=0007h)
	  (default = 1 is set by "FG_SETMODE")
	This function has no effect in text modes
SeeAlso: AX=0007h,AX=0008h,AX=000Ch,AX=0014h,AX=001Bh,AX=0024h,AX=0076h
--------V-620007-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_BOXDEPTH" - SET RECTANGLE BORDER WIDTH
	AX = 0007h
	BX = width of left and right edges in pixels (> 0)
	CX = width of top and bottom edges in pixels (> 0)
Note:	For FGDRIVER v1.10, this function was "FG_CURSOR" (see AX=0013h);
	  "FG_BOXDEPTH" was AX=00A3h
SeeAlso: AX=0006h,AX=0008h
--------V-620008-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_BOXX" - XOR HOLLOW RECTANGLE
	AX = 0008h
	BX = left column
	CX = right column
	DX = top row
	SI = bottom row
Notes:	For FGDRIVER v1.10, this function was unused and "FG_BOXX" did not
	  exist yet
	The rectangle is XORed into screen space, respecting the clipping
	  region, with edges of the width specified with "FG_BOXDEPTH"
	  (see AX=0007h) (default = 1 is set by "FG_SETMODE")
	This function has no effect in text modes
SeeAlso: AX=0006h,AX=0007h,AX=001Fh,AX=0020h,AX=0077h
--------V-620009-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_BUTTON" - GET JOYSTICK BUTTON STATE
	AX = 0009h
	BX = joystick number (0001h or 0002h)
Return: AX = button states
	    bit 0: top button pressed
	    bit 1: bottom button pressed
Note:	For FGDRIVER v1.10, this function was unused; "FG_BUTTON" was AX=0078h
SeeAlso: AX=0044h,AX=0046h,AX=004Dh,AX=0050h,AX=0061h
--------V-62000A-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_CAPSLOCK" - GET STATE OF CAPSLOCK KEY
	AX = 000Ah
Return: AX = CapsLock state (0000h off, 0001h on)
Note:	For FGDRIVER v1.10, this function was "FG_GETMAXX" (see AX=003Dh);
	  "FG_CAPSLOCK" was AX=0070h
SeeAlso: AX=006Ch,AX=0088h,AX=008Bh,AX=0094h
--------V-62000B-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_CHGATTR" - APPLY CURRENT TEXT ATTRIB TO CHARS
	AX = 000Bh
	BX = number of characters to recolor
Notes:	For FGDRIVER v1.10, this function was "FG_GETMAXY" (see AX=003Eh);
	  "FG_CHGATTR" was AX=0035h
	This call is ignored in graphics modes
	Starting at the current text cursor position, the specified number of
	  characters have their attributes to the current text attribute
SeeAlso: AX=000Ch,AX=0030h,AX=008Ah
--------V-62000C-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_CHGTEXT" - DISPLAY STRING AT CURSOR POSITION
	AX = 000Ch
	CX = length of string
	ES:BX -> string to be displayed
Return: text cursor updated
Notes:	For FGDRIVER v1.10, this function was "FG_XALPHA" (see AX=00B0h);
	  "FG_CHGTEXT" was AX=0036h
	This call is ignored in graphics modes
SeeAlso: AX=000Bh,AX=007Ch
--------V-62000D-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_CIRCLE" - DRAW UNFILLED CIRCLE
	AX = 000Dh
	BX = radius in horizontal screen space units (> 0)
Notes:	For FGDRIVER v1.10, this function was "FG_YALPHA" (see AX=00B2h);
	  "FG_CIRCLE" was AX=0030h
	The circle is drawn in screen space, centered at the current graphics
	  cursor position
	This call is ignored in text modes
SeeAlso: AX=0006h,AX=0008h,AX=000Eh,AX=0024h,AX=0079h
--------V-62000E-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_CIRCLEF" - DRAW FILLED CIRCLE
	AX = 000Eh
	BX = radius in horizontal screen space units (> 0)
Notes:	For FGDRIVER v1.10, this function was "FG_XCONVERT" (see AX=00B1h);
	  "FG_CIRCLEF" did not exist yet
SeeAlso: AX=0008h,AX=000Dh,AX=0025h,AX=0078h
--------V-62000F-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_CLIPMASK" - DISPLAY CLIPPED IMAGE (MASKING MAP)
	AX = 000Fh
	ES:BX -> array containing image stored as a masking map (see AX=001Dh)
	CX = number of pixel runs in masking map
	DX = width of masking map in pixels
Notes:	For FGDRIVER v1.10, this function was "FG_YCONVERT" (see AX=00B3h);
	   "FG_CLIPMASK" was AX=0052h
	This call is ignored in text modes and in native EGA and VGA graphics
	  modes
	The image is drawn with its lower left corner at the current graphics
	  cursor position
SeeAlso: AX=0010h,AX=001Dh,AX=002Ah,AX=0086h,AX=008Ch,AX=00A5h
--------V-620010-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_CLPIMAGE" - DISPLAY CLIPPED IMAGE (BITMAP)
	AX = 0010h
	ES:BX -> mode-specific bitmap
	CX = width of bit map in bytes
	DX = height of bit map in pixel rows
Notes:	For FGDRIVER v1.10, this function was "FG_GETLINES" (see AX=003Bh);
	  "FG_CLPIMAGE" was AX=004Ah
	This call is ignored in text modes
	The image is drawn with its lower left corner at the current graphics
	  cursor position
	The current clipping region is used, extended to a byte boundary
SeeAlso: AX=000Fh,AX=0022h,AX=002Ch,AX=0038h,AX=0085h,AX=008Ch,AX=009Ah
--------V-620011-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_CLPRECT" - DRAW FILLED RECTANGLE IN SCREEN SPCE
	AX = 0011h
	BX = screen space column of left edge
	CX = screen space column of right edge
	DX = screen space row of top edge
	SI = screen space row of bottom edge
Notes:	For FGDRIVER v1.10, this function was "FG_SETLINES" (see AX=0092h);
	  "FG_CLPRECT" was AX=002Bh
	This call is ignored in text modes
SeeAlso: AX=0006h,AX=000Fh,AX=0010h,AX=0021h,AX=0080h,AX=008Ch
--------V-620012-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_COPYPAGE" - TRANSFER VIDEO PAGE CONTENTS
	AX = 0012h
	BX = source page number (0000h-003Fh)
	CX = destination page number (0000h-003Fh)
Notes:	For FGDRIVER v1.10, this function was unused;"FG_COPYPAGE" was AX=005Fh
	If both source and destination pages are logical pages, they must both
	  be located in the same type (conventional, EMS, XMS) of memory
SeeAlso: AX=0083h,AX=0087h,AX=00A6h,AX=00A9h
--------V-620013-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_CURSOR" - SPECIFY WHETHER TEXT CURSR IS VISIBLE
	AX = 0013h
	BX = new state (0000h invisible, 0001h visible)
Notes:	For FGDRIVER v1.10, this function was unused; "FG_CURSOR" was AX=0007h
	This call is ignored in text modes
SeeAlso: AX=000Ch,AX=0045h,AX=0047h,AX=0055h,AX=005Fh,AX=0063h,AX=0068h
SeeAlso: AX=00AFh
--------V-620014-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DASH" - DRAW DASHED LINE TO ABSOLUTE POSITION
	AX = 0014h
	BX = endpoint column
	CX = endpoint row
	DX = dash pattern (set bits cause drawn pixels)
Notes:	For FGDRIVER v1.10, this function was "FG_DEFCOLOR" (see AX=0016h);
	  "FG_DASH" was AX=0027h
	This call is ignored in text modes
	The starting point is the current graphics cursor position; the cursor
	  position is updated
SeeAlso: AX=0015h,AX=001Bh,AX=0076h
--------V-620015-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DASHREL" - DRAW DASHED LINE TO RELATVE POSITION
	AX = 0015h
	BX = endpoint column offset
	CX = endpoint row offset
	DX = dash pattern (set bits cause drawn pixels)
Notes:	For FGDRIVER v1.10, this function was "FG_GETCOLOR" (see AX=0034h);
	  "FG_DASHREL" was AX=0028h
	This call is ignored in text modes
	The starting point is the current graphics cursor position; the cursor
	  position is updated
SeeAlso: AX=0014h,AX=001Ch,AX=0076h
--------V-620016-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DEFCOLOR" - ASSIGN COLOR VALUE TO COLOR INDEX
	AX = 0016h
	BX = color index (0000h-00FFh)
	CX = new color value (0 to maximum color value for current video mode)
Notes:	For FGDRIVER v1.10, this function was "FG_GETINDEX" (see AX=0039h);
	  "FG_DEFCOLOR" was AX=0014h
	This call is ignored in text modes and 256-color graphics modes
SeeAlso: AX=0034h,AX=0039h,AX=008Dh
--------V-620017-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DEFPAGES" - DEF SRC/DEST PAGES FOR BLOCK XFERS
	AX = 0017h
	BX = source page
	CX = destination page
Desc:	specify the source and destination SVGA banks for block transfers on
	  extended video pages
Notes:	For FGDRIVER v1.10, this function was "FG_PALETTE" (see AX=006Fh);
	  "FG_DEFPAGES" did not exist yet
	This function is ignored if the video controller does not support
	  extended pages or the current video mode does not allow them
SeeAlso: AX=0012h,AX=00A9h
--------V-620018-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DISPFILE" - DISPLAY STORED IMAGE
	AX = 0018h
	ES:BX -> ASCIZ filename
	CX = image width in pixels (> 0)
	DX = image format
	    0000h Fastgraph standard pixel run format
	    0001h packed pixel run format
Notes:	For FGDRIVER v1.10, this function was "FG_PALETTES" (see AX=0070h);
	  "FG_DISPFILE" was AX=004Fh
	This call is ignored in text modes
	The image is displayed with its lower left corner at the current
	  graphics cursor position
SeeAlso: AX=0019h,AX=001Ah,AX=009Ah,AX=009Bh,AX=009Ch
--------V-620019-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DISPLAY" - DISPLAY IMAGE (STD PIXEL RUN FORMAT)
	AX = 0019h
	ES:BX -> pixel run map (pairs of bytes: color index, count)
	CX = number of pixel runs to display
	DX = width of image in pixels (> 0)
Notes:	For FGDRIVER v1.10, this function was "FG_SETATTR" (see AX=008Ah);
	  "FG_DISPLAY" was AX=004Dh
	This call is ignored in text modes
	The image is displayed with its lower left corner at the current
	  graphics cursor position
SeeAlso: AX=0018h,AX=001Ah,AX=009Ah,AX=009Bh,AX=009Ch
--------V-62001A-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DISPLAYP" - DISPLAY IMAGE (PACKED PIXEL RUNS)
	AX = 001Ah
	ES:BX -> pixel run map (trios of bytes: colors, count1, count2; colors
		contains the color for the first run in its high nybble and the
		color for the second run in its low nybble)
	CX = number of pixel runs to display
	DX = width of image in pixels (> 0)
Notes:	For FGDRIVER v1.10, this function was "FG_SETCOLOR" (see AX=008Dh);
	  "FG_DISPLAYP" was AX=004Eh
	This call is ignored in text modes
	The image is displayed with its lower left corner at the current
	  graphics cursor position
SeeAlso: AX=0018h,AX=0019h,AX=009Ah,AX=009Bh,AX=009Ch
--------V-62001B-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DRAW" - DRAW SOLID LINE TO ABSOLUTE POSITION
	AX = 001Bh
	BX = endpoint column
	CX = endpoint row
Notes:	For FGDRIVER v1.10, this function was "FG_SETRGB" (see AX=0096h);
	  "FG_DRAW" was AX=0025h
	This call is ignored in text modes
	The starting point is the current graphics cursor position; the cursor
	  position is updated
SeeAlso: AX=0014h,AX=001Eh,AX=001Fh,AX=0024h,AX=0076h,AX=0077h
--------V-62001C-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DRAWMAP" - DISPLAY MODE-INDEPENDENT BIT MAP
	AX = 001Ch
	ES:BX -> bitmap (each set bit is pixel drawn in current color)
	CX = width of bitmap in bytes
	DX = height of bitmap in pixel rows
Note:	For FGDRIVER v1.10, this function was "FG_GETRGB" (see AX=0042h);
	  "FG_DRAWMAP" was AX=0047h
SeeAlso: AX=0010h,AX=0022h,AX=002Ch,AX=0038h,AX=007Eh,AX=0085h
--------V-62001D-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DRAWMASK" - DISPLAY IMAGE (MASKING MAP)
	AX = 001Dh
	ES:BX -> array containing image stored as a masking map (see below)
	CX = number of pixel runs in masking map
	DX = width of masking map in pixels
Notes:	For FGDRIVER v1.10, this function was "FG_MAPRGB" (see AX=005Ah);
	  "FG_DRAWMASK" was AX=0051h
	This call is ignored in text modes and in native EGA and VGA graphics
	  modes
	The image is drawn with its lower left corner at the current graphics
	  cursor position
SeeAlso: AX=000Fh,AX=001Dh,AX=0086h,AX=008Ch

Format of masking map:
Offset	Size	Description
 00h	BYTE	length of first "protect" run (pixels remain unchanged)
 01h	BYTE	length of first "zero" run (pixels set to background color)
 02h	BYTE	length of second "protect" run
 03h	BYTE	length of second "zero" run
	...
--------V-62001E-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DRAWREL" - DRAW SOLID LINE TO RELATIVE POSITION
	AX = 001Eh
	BX = endpoint column offset
	CX = endpoint row offset
Notes:	For FGDRIVER v1.10, this function was "FG_ERASE" (see AX=0026h);
	  "FG_DRAWREL" was AX=0026h
	This call is ignored in text modes
	The starting point is the current graphics cursor position; the cursor
	  position is updated
SeeAlso: AX=0006h,AX=000Dh,AX=001Bh,AX=001Fh,AX=0024h,AX=0076h
--------V-62001F-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DRAWRELX" - XOR SOLID LINE TO RELATIVE POSITION
	AX = 001Fh
	BX = endpoint column offset
	CX = endpoint row offset
Desc:	draw a solid line, XORing each pixel onto the screen
Notes:	For FGDRIVER v1.10, this function was "FG_POINT" (see AX=0076h);
	  "FG_DRAWRELX" did not exist yet
	This call is ignored in text modes
	The starting point is the current graphics cursor position; the cursor
	  position is updated
SeeAlso: AX=0006h,AX=000Dh,AX=001Bh,AX=001Eh,AX=0024h,AX=0077h
--------V-620020-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DRAWX" - XOR SOLID LINE TO ABSOLUTE POSITION
	AX = 0020h
	BX = endpoint column
	CX = endpoint row
Desc:	draw a solid line, XORing each pixel onto the screen
Notes:	For FGDRIVER v1.10, this function was "FG_GETPIXEL" (see AX=0041h);
	  "FG_DRAWX" did not exist yet
	This call is ignored in text modes
	The starting point is the current graphics cursor position; the cursor
	  position is updated
SeeAlso: AX=001Bh,AX=001Fh,AX=0076h
--------V-620021-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DRECT" - DRAW DITHERED RECTANGLE IN SCRN SPACE
	AX = 0021h
	BX = screen space column of left edge
	CX = screen space column of right edge
	DX = screen space row of top edge
	SI = screen space row of bottom edge
	ES:DI -> dithering matrix (video-mode dependent)
Notes:	For FGDRIVER v1.10, this function was "FG_GETXPOS" (see AX=0045h);
	  "FG_DRECT" was AX=002Ch
	This call is ignored in text modes
SeeAlso: AX=0006h,AX=0008h,AX=0011h,AX=0031h,AX=0072h,AX=0080h
--------V-620022-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_DRWIMAGE" - DISPLAY BITMAPPED IMAGE
	AX = 0022h
	ES:BX -> video mode-specific bitmap
	CX = width of bitmap in bytes
	DX = height of bitmap in pixel rows
Notes:	For FGDRIVER v1.10, this function was "FG_GETYPOS" (see AX=0047h);
	  "FG_DRWIMAGE" was AX=0049h
	The image will be drawn with its lower left corner at the current
	  cursor position (either text or graphics)
SeeAlso: AX=0010h,AX=002Ch,AX=0038h,AX=007Eh,AX=0085h
--------V-620023-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_EGACHECK" - GET INFO ABOUT ACTIVE EGA DISPLAY
	AX = 0023h
Return: AX = number of 64K banks of video memory, or 0000h if no EGA or EGA
		  without an Enhanced Color Display
Note:	For FGDRIVER v1.10, this function was "FG_MOVE" (see AX=0068h);
	  "FG_EGACHECK" was AX=0005h
SeeAlso: AX=00A2h
--------V-620024-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_ELLIPSE" - DRAW UNFILLED ELLIPSE IN SCRN SPACE
	AX = 0024h
	BX = horizontal semi-axis length in screen space units
	CX = vertical semi-axis length in screen space units
Notes:	For FGDRIVER v1.10, this function was "FG_MOVEREL" (see AX=0069h);
	  "FG_ELLIPSE" was AX=002Dh
	This call is ignored in text modes
	The ellipse is centered at the current graphics cursor position
SeeAlso: AX=0006h,AX=000Dh,AX=0025h,AX=0076h,AX=0079h
--------V-620025-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_ELLIPSEF" - DRAW FILLED ELLIPSE IN SCREEN SPACE
	AX = 0025h
	BX = horizontal semi-axis length in screen space units
	CX = vertical semi-axis length in screen space units
Notes:	For FGDRIVER v1.10, this function was "FG_DRAW" (see AX=001Bh);
	  "FG_ELLIPSEF" did not exist yet
	This call is ignored in text modes
	The ellipse is centered at the current graphics cursor position
SeeAlso: AX=0006h,AX=000Eh,AX=0024h,AX=0076h,AX=0078h
--------V-620026-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_ERASE" - CLEAR THE ACTIVE VIDEO PAGE
	AX = 0026h
Note:	For FGDRIVER v1.10, this function was "FG_DRAWREL" (see AX=001Eh);
	  "FG_ERASE" was AX=001Eh
	This function sets each pixel to 0 in graphics modes, each character
	  cell to a blank with a gray foreground attribute in text modes
SeeAlso: AX=0027h,AX=0029h,AX=002Bh
--------V-620027-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_FADEIN" - FADE IN HIDDEN PAGE
	AX = 0027h
	BX = delay (0000h = fastest possible fade-in)
Notes:	For FGDRIVER v1.10, this function was "FG_DASH" (see AX=0014h);
	  "FG_FADEIN" was AX=0064h
	The current hidden page is copied to the current visible page in small
	  random sections to produce a fade-in effect
	This call is ignored in text modes
SeeAlso: AX=0026h,AX=0028h,AX=0029h
--------V-620028-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_FADEOUT" - FADE OUT TO CURRENT COLOR
	AX = 0028h
	BX = delay (0000h = fastest possible fade-out)
Notes:	For FGDRIVER v1.10, this function was "FG_DASHREL" (see AX=0015h);
	  "FG_FADEOUT" was AX=0065h
	The current visible page is filled with pixels of the current color in
	  small random sections to give a fade-out effect
	This call is ignored in text modes
SeeAlso: AX=0026h,AX=0027h,AX=0029h
--------V-620029-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_FILLPAGE" - FILL THE ACTIVE VIDEO PAGE
	AX = 0029h
Desc:	fill the active video page with pixels of the current color (graphics
	  modes) or the block character DBh with the current character
	  attributes (text modes)
Note:	For FGDRIVER v1.10, this function was "FG_SETCLIP" (see AX=008Ch);
	  "FG_FILLPAGE" did not exist yet
SeeAlso: AX=0026h,AX=0027h,AX=0028h
--------V-62002A-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_FLIPMASK" - DISPLAY INV CLIPPED IMAGE (MASKMAP)
	AX = 002Ah
	ES:BX -> array containing image stored as a masking map (see AX=0051h)
	CX = number of pixel runs in masking map
	DX = width of masking map in pixels
Notes:	For FGDRIVER v1.10, this function was "FG_RECT" (see AX=0080h);
	  "FG_FLIPMASK" was AX=0054h
	This call is ignored in text modes and in native EGA and VGA graphics
	  modes
	The image is drawn with its lower left corner at the current graphics
	  cursor position
SeeAlso: AX=000Fh,AX=001Dh,AX=002Ch,AX=0086h,AX=008Ch,AX=00A5h
--------V-62002B-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_FLOOD" - FLOOD FILL ARBITRARY CLOSED REGION
	AX = 002Bh
	BX = starting column
	CX = starting row
Desc:	fill the bounded region around the specified point (respecting clipping
	  region) with the currrent color
Notes:	For FGDRIVER v1.10, this function was "FG_CLPRECT" (see AX=0011h);
	  "FG_FLOOD" did not exist yet
	This function is ignored in text modes
SeeAlso: AX=0026h,AX=006Eh
--------V-62002C-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_FLPIMAGE" - DISPLAY INV CLIPPED IMAGE (BITMAP)
	AX = 002Ch
	ES:BX -> mode-specific bitmap
	CX = width of bit map in bytes
	DX = height of bit map in pixel rows
Notes:	For FGDRIVER v1.10, this function was "FG_DRECT" (see AX=0021h);
	   "FG_FLPIMAGE" was AX=004Ch
	This call is ignored in text modes
	The image is drawn with its lower left corner at the current graphics
	  cursor position
	The current clipping region is used, extended to a byte boundary
SeeAlso: AX=0010h,AX=0022h,AX=002Ah,AX=0038h,AX=0085h,AX=008Ch,AX=009Ah
--------V-62002D-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_FONTSIZE" - SPECIFY FONT SIZE FOR TEXT OUTPUT
	AX = 002Dh
	BX = desired character height in scan lines (8, 14, 16)
Notes:	For FGDRIVER v1.10, this function was "FG_ELLIPSE" (see AX=0024h);
	   "FG_FONTSIZE" did not exist yet
	This call is ignored if the current mode is not a VGA or SVGA graphics
	  mode, or the specified character height is not 8, 14, or 16
SeeAlso: AX=007Ch
--------V-62002E-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_FREEPAGE" - FREE VIRTUAL OR LOGICAL VIDEO PAGE
	AX = 002Eh
	BX = page number (0000h-003Fh)
Return: AX = status (0000h,0001h,0007h,0009h) (see AX=0042h)
Note:	For FGDRIVER v1.10, this function was "FG_POLYGON" (see AX=0079h);
	   "FG_FREEPAGE" was AX=0043h
SeeAlso: AX=0000h,AX=0001h,AX=0002h,AX=0003h
--------V-62002F-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETADDR" - GET SEGMENT OF ACTIVE VIDEO PAGE
	AX = 002Fh
Return: AX = segment of active video page
Note:	For FGDRIVER v1.10, this function was "FG_PAINT" (see AX=006Eh);
	   "FG_GETADDR" was AX=0044h
SeeAlso: AX=0036h,AX=008Fh
--------V-620030-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETATTR" - GET CHARACTER ATTRIB FOR POSITION
	AX = 0030h
	BX = row
	CX = column
Return: AX = character attribute at specified location on active video page
Notes:	For FGDRIVER v1.10, this function was "FG_CIRCLE" (see AX=000Dh);
	  "FG_GETATTR" was AX=0037h
	This call is ignored in graphics modes
SeeAlso: AX=000Bh,AX=0032h,AX=0034h,AX=008Ah
--------V-620031-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETBLOCK" - GRAB RECTANGLE OF DISPLAY
	AX = 0031h
	ES:BX -> buffer for screen contents
	CX = leftmost column
	DX = rightmost column
	SI = top row
	DI = bottom row
Notes:	For FGDRIVER v1.10, this function was unused, and "FG_GETBLOCK" did not
	  exist yet
	In text modes, coordinates are character positions; in graphics modes,
	  they are defined in screen space, and the left and right edges are
	  adjusted to a byte boundary if necessary
	Use "FG_IMAGESIZ" (see AX=004Bh) to determine the required buffer size
SeeAlso: AX=0038h,AX=004Bh,AX=007Dh
--------V-620032-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETCHAR" - GET CHARACTER FOR SCREEN POSITION
	AX = 0032h
	BX = row
	CX = column
Return: AX = character at specified location on active video page
Notes:	For FGDRIVER v1.10, this function was "FG_TEXT" (see AX=00A8h);
	  "FG_GETCHAR" was AX=0038h
	This call is ignored in graphics modes
SeeAlso: AX=000Bh,AX=0030h,AX=007Ch,AX=008Ah,AX=00A8h
--------V-620033-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETCLOCK" - GET CLOCK TICKS SINCE MIDNIGHT
	AX = 0033h
Return: DX:AX = number of clock ticks since midnight
Note:	For FGDRIVER v1.10, this function was "FG_LOCATE" (see AX=0055h);
	  "FG_GETCLOCK" was AX=0099h
SeeAlso: INT 1A/AH=00h
--------V-620034-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETCOLOR" - GET CURRENT TEXT ATTRIBUTE
	AX = 0034h
Return: AX = current text attribute or color index (graphics modes)
Note:	For FGDRIVER v1.10, this function was "FG_WHERE" (see AX=00AFh);
	  "FG_GETCOLOR" was AX=0015h
SeeAlso: AX=000Bh,AX=0030h,AX=008Ah
--------V-620035-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETDACS" - GET VIDEO DAC CONTENTS
	AX = 0035h
	CX = number of DAC registers to return (0001h to 0100h)
	DX = starting DAC register number (0000h to 00FFh)
	ES:BX -> buffer for DAC red/green/blue triples
Notes:	For FGDRIVER v1.10, this function was "FG_CHGATTR" (see AX=000Bh);
	  "FG_GETDACS" was AX=00A4h
	The register number wraps back to zero after FFh
SeeAlso: AX=0042h,AX=006Fh,AX=008Eh
--------V-620036-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETENTRY" - GET PAGE TYPE AND ADDRESS
	AX = 0036h
	ES:BX -> variable pointer record (see below)
	CX = page number (00h-3Fh)
Notes:	For FGDRIVER v1.10, this function was "FG_CHGTEXT" (see AX=000Ch);
	  "FG_GETENTRY" did not exist yet
	Page addresses are segments for pages stored in conventional memory
	  (including physical and virtual pages), and EMS or XMS handles for
	  pages stored in EMS or XMS
SeeAlso: AX=0000h,AX=008Fh

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of WORD buffer for page address
 02h	WORD	offset of WORD buffer for page address
 04h	WORD	segment of WORD buffer for page type
 06h	WORD	offset of WORD buffer for page type

Values for page type:
 0000h	unallocated
 0001h	physical
 0002h	virtual
 0003h	logical page, stored in expanded memory (EMS)
 0004h	logical page, stored in extended memory (XMS)
 0005h	logical page, stored in conventional memory
--------V-620037-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETHPAGE" - GET CURRENT HIDDEN VIDEO PAGE NUM
	AX = 0037h
Return: AX = current hidden video page number (0000h-003Fh)
Note:	For FGDRIVER v1.10, this function was "FG_GETATTR" (see AX=0030h);
	  "FG_GETHPAGE" was AX=0040h
SeeAlso: AX=0040h,AX=0043h,AX=0091h
--------V-620038-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETIMAGE" - STORE IMAGE AS BITMAP
	AX = 0038h
	ES:BX -> buffer for video mode-specific bitmap
	CX = width of bitmap in bytes
	DX = height of bitmap in pixel rows
Note:	For FGDRIVER v1.10, this function was "FG_GETCHAR" (see AX=0032h);
	  "FG_GETIMAGE" was AX=0048h
SeeAlso: AX=0010h,AX=0022h,AX=002Ch,AX=007Eh,AX=0085h
--------V-620039-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETINDEX" - GET COLOR VALUE FOR COLOR INDEX
	AX = 0039h
	BX = color index (0000h to 00FFh)
Return: AX = color value for specified color index
Notes:	For FGDRIVER v1.10, this function was unused;"FG_GETINDEX" was AX=0016h
	This call returns the value passed to it in text and 256-color
	  graphics modes
SeeAlso: AX=0016h,AX=0034h
--------V-62003A-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETKEY" - GET NEXT KEYSTROKE
	AX = 003Ah
	ES:BX -> variable pointer record (see below)
Return: (after next keystroke if no typeahead) variables updated
Note:	For FGDRIVER v1.10, this function was unused; "FG_GETKEY" was AX=006Eh
SeeAlso: AX=000Ah,AX=0051h,AX=0054h,AX=00ADh,INT 16/AH=00h

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of BYTE buffer for ASCII keycode
 02h	WORD	offset of BYTE buffer for ASCII keycode
 04h	WORD	segment of BYTE buffer for extended keycode
 06h	WORD	offset of BYTE buffer for extended keycode
--------V-62003B-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETLINES" - GET TEXT ROWS FOR CURR VIDEO MODE
	AX = 003Bh
Return: AX = number of text rows on screen in current video mode
Note:	For FGDRIVER v1.10, this function was unused;"FG_GETLINES" was AX=0010h
SeeAlso: AX=0092h,AX=00A2h
--------V-62003C-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETMAP" - STORE IMAGE AS MODE-INDEPENDNT BITMAP
	AX = 003Ch
	ES:BX -> buffer for video mode-independent bitmap
	CX = width of bitmap in bytes
	DX = height of bitmap in pixel rows
Return: each bit in bitmap is set if corresponding pixel is of the current
	  color, cleared otherwise
Notes:	For FGDRIVER v1.10, this function was "FG_GETPAGE" (see AX=0040h);
	  "FG_GETMAP" was AX=0046h
	This call is ignored in text modes
SeeAlso: AX=0010h,AX=001Ch,AX=0022h
--------V-62003D-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETMAXX" - GET MAXIMUM COLUMN IN SCREEN SPACE
	AX = 003Dh
Return: AX = maximum X coordinate in screen space
		(or character space if in text mode)
Note:	For FGDRIVER v1.10, this function was "FG_SETPAGE" (see AX=0095h);
	   "FG_GETMAXX" was AX=000Ah
SeeAlso: AX=003Eh,AX=00A1h
--------V-62003E-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETMAXY" - GET MAXIMUM ROW IN SCREEN SPACE
	AX = 003Eh
Return: AX = maximum Y coordinate in screen space
		(or character space if in text mode)
Note:	For FGDRIVER v1.10, this function was "FG_GETVPAGE" (see AX=0043h);
	   "FG_GETMAXY" was AX=000Bh
SeeAlso: AX=003Dh,AX=00A1h
--------V-62003F-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETMODE" - GET CURRENT VIDEO MODE NUMBER
	AX = 003Fh
	ES:BX -> WORD ???
Return: AX = current video mode number
Note:	For FGDRIVER v1.10, this function was "FG_SETVPAGE" (see AX=0098h);
	   "FG_GETMODE" was AX=0000h
SeeAlso: AX=0093h
--------V-620040-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETPAGE" - GET ACTIVE VIDEO PAGE NUMBER
	AX = 0040h
Return: AX = active video page (0000h-003Fh)
Note:	For FGDRIVER v1.10, this function was "FG_GETHPAGE" (see AX=0037h);
	   "FG_GETPAGE" was AX=003Ch
SeeAlso: AX=002Fh,AX=0036h,AX=0037h,AX=0043h,AX=0095h
--------V-620041-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETPIXEL" - GET COLOR OF SPECIFIED PIXEL
	AX = 0041h
	BX = column in screen space
	CX = row in screen space
Return: AX = color value of pixel (0 to num_colors-1)
	    0000h in text modes
Note:	For FGDRIVER v1.10, this function was "FG_SETHPAGE" (see AX=0091h);
	   "FG_GETPIXEL" was AX=0020h
SeeAlso: AX=0030h,AX=0032h,AX=0076h,AX=0077h
--------V-620042-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETRGB" - GET VIDEO DAC REGISTER CONTENTS
	AX = 0042h
	ES:BX -> variable pointer record (see below)
	CX = DAC register number
Return: variables updated
Notes:	For FGDRIVER v1.10, this function was "FG_ALLOCATE" (see AX=0000h);
	  "FG_GETRGB" was AX=001Ch
	This call is ignored in text modes and CGA/EGA video modes (since
	  they do not use DAC registers)
SeeAlso: AX=0035h,AX=006Fh,AX=008Eh

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of WORD buffer for red component of DAC register
 02h	WORD	offset of WORD buffer for red component
 04h	WORD	segment of WORD buffer for green component of DAC register
 06h	WORD	offset of WORD buffer for green component
 08h	WORD	segment of WORD buffer for blue component of DAC register
 0Ah	WORD	offset of WORD buffer for blue component
--------V-620043-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETVPAGE" - GET VISIBLE VIDEO PAGE NUMBER
	AX = 0043h
Return: AX = visible video page (0000h-003Fh)
Note:	For FGDRIVER v1.10, this function was "FG_FREEPAGE" (see AX=002Eh);
	  "FG_GETVPAGE" was AX=003Eh
SeeAlso: AX=0037h,AX=0040h,AX=0098h
--------V-620044-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETXJOY" - GET HORIZONTAL POSITION OF JOYSTICK
	AX = 0044h
	BX = joystick number (0001h or 0002h)
Return: AX = horizontal position of joystick
	    FFFFh if joystick uninitialized or not present
Notes:	For FGDRIVER v1.10, this function was "FG_GETADDR" (see AX=002Fh);
	  "FG_GETXJOY" was AX=0076h
	The actual coordinates are processor- and joystick-dependent
	You must call "FG_INITJOY" (AX=004Dh) before using this function
SeeAlso: AX=0009h,AX=0046h,AX=004Dh,AX=0050h,AX=0061h
--------V-620045-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETXPOS" - GET GRAPHICS CURSOR COLUMN
	AX = 0045h
Return: AX = screen space X coordinate of graphics cursor position
Note:	For FGDRIVER v1.10, this function was "FG_RESIZE" (see AX=0082h);
	  "FG_GETXPOS" was AX=0021h
SeeAlso: AX=0047h,AX=0068h,AX=0069h
--------V-620046-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETYJOY" - GET VERTICAL POSITION OF JOYSTICK
	AX = 0046h
	BX = joystick number (0001h or 0002h)
Return: AX = vertical position of joystick
	    FFFFh if joystick uninitialized or not present
Notes:	For FGDRIVER v1.10, this function was "FG_GETMAP" (see AX=003Ch);
	  "FG_GETYJOY" was AX=0077h
	The actual coordinates are processor- and joystick-dependent
	You must call "FG_INITJOY" (AX=004Dh) before using this function
SeeAlso: AX=0009h,AX=0044h,AX=004Dh,AX=0050h,AX=0061h
--------V-620047-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_GETYPOS" - GET GRAPHICS CURSOR ROW
	AX = 0047h
Return: AX = screen space Y coordinate of graphics cursor position
Note:	For FGDRIVER v1.10, this function was "FG_DRAWMAP" (see AX=001Ch);
	  "FG_GETYPOS" was AX=0022h
SeeAlso: AX=0045h,AX=0068h,AX=0069h
--------V-620048-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_HUSH" - STOP ASYNCHRONOUS SOUND IMMEDIATELY
	AX = 0048h
Notes:	For FGDRIVER v1.10, this function was "FG_GETIMAGE" (see AX=0038h);
	  "FG_HUSH" was AX=008Eh
	This function immediately stops any sounds started with "FG_MUSICB",
	  "FG_SOUNDS", or "FG_VOICES"; it is ignored if no asynchronous sound
	  is playing
SeeAlso: AX=0049h,AX=006Bh,AX=009Eh,AX=00ABh
--------V-620049-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_HUSHNEXT" - STOP ASYNCHRONOUS SOUND
	AX = 0049h
Program: FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
Notes:	For FGDRIVER v1.10, this function was "FG_DRWIMAGE" (see AX=0022h);
	  "FG_HUSHNEXT" was AX=008Fh
	This function stops any sounds started with "FG_MUSICB", "FG_SOUNDS",
	  or "FG_VOICES" after the current repetition completes; it is ignored
	  unless asynchronous sound is continuous
SeeAlso: AX=0048h,AX=006Bh,AX=009Eh,AX=00ABh
--------V-62004A-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_IMAGEBUF" - SPECIFY TEMPORARY IMAGE BUFFER
	AX = 004Ah
	ES:BX -> buffer to be used when creating or displaying GIF/PCX/PPR/SPR
		  images
	CX = size of buffer in bytes or 0000h to use internal buffer
Notes:	For FGDRIVER v1.10, this function was "FG_CLPIMAGE" (see AX=0010h);
	  "FG_IMAGEBUF" did not exist yet
	Fastgraph's internal buffer is 4096 bytes; this function allows the
	  application to define a larger buffer which will typically speed
	  processing
SeeAlso: AX=0057h,AX=0058h,AX=0059h,AX=009Ah,AX=009Bh,AX=009Ch
--------V-62004B-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_IMAGESIZ" - DETERMINE IMAGE STORAGE REQUIREMENT
	AX = 004Bh
	BX = image width in pixels
	CX = image height in pixels
Note:	For FGDRIVER v1.10, this function was "FG_REVIMAGE" (see AX=0085h);
	  "FG_IMAGESIZ" was AX=0062h
Return: DX:AX = size in bytes of mode-specific bitmap for current video mode
SeeAlso: AX=0031h,AX=007Dh
--------V-62004C-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_INITEMS" - INITIALIZE EXPANDED MEMORY USE
	AX = 004Ch
Return: AX = status
	    0000h successful
	    FFFFh expanded memory manager inaccessible or not installed
Notes:	For FGDRIVER v1.10, this function was "FG_FLPIMAGE" (see AX=002Ch);
	  "FG_INITEMS" was AX=00A0h
SeeAlso: AX=0002h,AX=004Eh
--------V-62004D-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_INITJOY" - INITIALIZE JOYSTICK USE
	AX = 004Dh
	BX = joystick number (0001h or 0002h)
Return: AX = status
	    0000h successful
	    FFFFh joystick not connected or no game port
Notes:	For FGDRIVER v1.10, this function was "FG_DISPLAY" (see AX=0019h);
	  "FG_INITJOY" was AX=0075h
	Fastgraph assumes that the requested joystick is centered at the time
	  this function is called
SeeAlso: AX=0009h,AX=0044h,AX=0046h,AX=0050h,AX=0061h
--------V-62004E-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_INITXMS" - INITIALIZE EXTENDED MEMORY USE
	AX = 004Eh
Return: AX = status
	    0000h successful
	    FFFFh extended memory manager inaccessible or not installed
Note:	For FGDRIVER v1.10, this function was "FG_DISPLAYP" (see AX=001Ah);
	  "FG_INITXMS" was AX=00A1h
SeeAlso: AX=0003h,AX=004Ch
--------V-62004F-----------------------------
INT 62 u - FDGRIVER v3.03 - "FG_INSIDE" - CHECK IF POINT INSIDE CONVEX POLYGON
	AX = 004Fh
	ES:BX -> vertex array
	CX = number of vertices
	DX = screen space column of point to test
	SI = screen space row of point to test
Return: AX = result
	    0000h point is outside polygon
	    0001h point is inside polygon
	    undefined if not a convex polygon
Note:	For FGDRIVER v1.10, this function was "FG_DISPFILE" (see AX=0018h);
	  "FG_INSIDE" did not exist yet
SeeAlso: AX=0078h,AX=0079h,AX=007Ah
--------V-620050-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_INTJOY" - GET KEYCODES CORRESP TO JOYSTICK POS
	AX = 0050h
	CX = joystick number (0001h or 0002h)
	ES:BX -> variable pointer record (see below)
Notes:	For FGDRIVER v1.10, this function was "FG_PATTERN" (see AX=0072h);
	  "FG_INTJOY" was AX=0079h
	If the indicated joystick has not been initialized with AX=0075h, both
	  the button code and joystick position will be set to 00h
	If either button is pressed, a button code of 0Dh is returned;
	  otherwise, a button code of 00h is returned
SeeAlso: AX=0009h,AX=0044h,AX=0046h,AX=004Dh,AX=0061h

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of BYTE buffer for button code
 02h	WORD	offset of BYTE buffer for button code
 04h	WORD	segment of BYTE buffer for joystick position
 06h	WORD	offset of BYTE buffer for joystick position
--------V-620051-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_INTKEY" - GET KEYSTROKE, NO WAIT
	AX = 0051h
	ES:BX -> variable pointer record (see below)
Return: variables updated
Notes:	For FGDRIVER v1.10, this function was "FG_DRAWMASK" (see AX=001Dh);
	  "FG_INTKEY" was AX=006Fh
	If the keyboard buffer is empty, both the ASCII and extended keycodes
	  are set to 00h
SeeAlso: AX=000Ah,AX=003Ah,AX=0054h,AX=00ADh,INT 16/AH=01h

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of BYTE buffer for ASCII keycode
 02h	WORD	offset of BYTE buffer for ASCII keycode
 04h	WORD	segment of BYTE buffer for extended keycode
 06h	WORD	offset of BYTE buffer for extended keycode
--------V-620052-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_JUSTIFY" - SET TEXT OUTPUT JUSTIFICATION
	AX = 0052h
	BX = horizontal justification
		  (00h centered, 01h right-justified, FFh left-justified)
	CX = vertical justification
		  (00h centered, 01h top of characters, FFh bottom of chars)
Note:	For FGDRIVER v1.10, this function was "FG_CLIPMASK" (see AX=000Fh);
	  "FG_JUSTIFY" did not exist yet
SeeAlso: AX=000Ch,AX=002Dh,AX=007Ch
--------V-620053-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_KBINIT" - ENABLE/DISABLE LOW-LEVEL KBD HANDLER
	AX = 0053h
	BX = new state (0000h disabled, 0001h enabled)
Notes:	For FGDRIVER v1.10, this function was "FG_REVMASK" (see AX=0086h);
	  "FG_KBINIT" did not exist yet
	When the low-level handler is enabled, "FG_GETKEY", "FG_INTKEY",
	  "FG_WAITKEY", and all other functions calling DOS or BIOS keyboard
	  services become unavailable
SeeAlso: AX=0054h
--------V-620054-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_KBTEST" - CHECK WHETHER SPECIFIED KEY PRESSED
	AX = 0054h
	BX = scan code of desired key
Return: AX = state
	    0000h key is not pressed
	    0001h key is currently pressed
Notes:	For FGDRIVER v1.10, this function was "FG_FLIPMASK" (see AX=002Ah);
	  "FG_KBTEST" did not exist yet
	The low-level keyboard handler must have been enabled with AX=0053h
SeeAlso: AX=0053h,INT 16/AH=01h
--------V-620055-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_LOCATE" - SET TEXT-MODE CURSOR POSITION
	AX = 0055h
	BX = row
	CX = column
Notes:	For FGDRIVER v1.10, this function was unused; "FG_LOCATE" was AX=0033h
	There are only eight text cursors shared by successive groups of
	  eight video pages (pages 0, 8, 16, ... share one cursor, 1, 9, ...
	  share the second, etc)
SeeAlso: AX=0045h,AX=0047h,AX=0068h,AX=00AFh
--------V-620056-----------------------------
INT 62 u - FGDRIVER v3.03 - UNUSED
	AX = 0056h
Return: AX destroyed
--------V-620057-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MAKEPCX" - CREATE PCX FILE FROM SCREEN WINDOW
	AX = 0057h
	BX = left edge in screen space units
	CX = right edge in screen space units
	DX = top edge in screen space units
	SI = bottom edge in screen space units
	ES:DI -> ASCIZ filename of PCX file to create
Return: AX = status
	    0000h successful
	    0001h file not created
Notes:	For FGDRIVER v1.10, this function was unused; "FG_MAKEPCX" was AX=0061h
	The PCX file is created from the specified region of the active video
	  page; the left and right edges are adjusted to a byte boundary if
	  necessary
	If the specified file already exists, it is overwritten
	This call is ignored in text and Hercules low-resolution graphics modes
SeeAlso: AX=004Ah,AX=0058h,AX=0059h,AX=009Ah,AX=009Bh,AX=009Ch
--------V-620058-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MAKEPPR" - CREATE PACKED PIXEL RUN FILE
	AX = 0058h
	BX = left edge in screen space units
	CX = right edge in screen space units
	DX = top edge in screen space units
	SI = bottom edge in screen space units
	ES:DI -> ASCIZ filename of PPR file to create
Return: AX = status
	    0000h successful
	    0001h file not created
Notes:	For FGDRIVER v1.10, this function was unused; "FG_MAKEPPR" did not
	  exist yet
	The PPR file is created from the specified region of the active video
	  page; the left and right edges are adjusted to byte boundaries if
	  necessary
	If the specified file already exists, it is overwritten
	This call is ignored in text modes
SeeAlso: AX=004Ah,AX=0057h,AX=0059h,AX=009Ah,AX=009Bh,AX=009Ch
--------V-620059-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MAKESPR" - CREATE STANDARD PIXEL RUN FILE
	AX = 0059h
	BX = left edge in screen space units
	CX = right edge in screen space units
	DX = top edge in screen space units
	SI = bottom edge in screen space units
	ES:DI -> ASCIZ filename of SPR file to create
Return: AX = status
	    0000h successful
	    0001h file not created
Note:	For FGDRIVER v1.10, this function was unused; "FG_MAKESPR" did not
	  exist yet
	The SPR file is created from the specified region of the active video
	  page; the left and right edges are adjusted to byte boundaries if
	  necessary
	If the specified file already exists, it is overwritten
	This call is ignored in text modes
SeeAlso: AX=004Ah,AX=0057h,AX=0058h,AX=009Ah,AX=009Bh,AX=009Ch
--------V-62005A-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MAPRGB" - MAP COLOR COMPONENTS INTO PALETTE VAL
	AX = 005Ah
	BX = red component
	CX = green component
	DX = blue component
Return: AX = mode-specific palette value corresponding to specified components
Notes:	For FGDRIVER v1.10, this function was "FG_SAVE" (see AX=0087h);
	  "FG_MAPRGB" was AX=001Dh
	This function is only meaningful in 16-color graphics modes
SeeAlso: AX=0042h,AX=0096h
--------V-62005B-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MEASURE" - GET DELAY UNITS PER CLOCK TICK
	AX = 005Bh
Return: AX = delay units per clock tick (processor-dependent)
Notes:	For FGDRIVER v1.10, this function was "FG_RESTORE" (see AX=0083h);
	  "FG_MEASURE" was AX=0098h
	These delay units are used by "FG_STALL" (see AX=009Fh)
SeeAlso: AX=009Fh
--------V-62005C-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MEMAVAIL" - QUERY AMOUNT OF FREE MEMORY
	AX = 005Ch
Return: DX:AX = number of bytes of conventional memory available
Note:	For FGDRIVER v1.10, this function was "FG_TRANSFER" (see AX=00A9h);
	  "FG_MEMAVAIL" was AX=009Bh
SeeAlso: AX=004Ch,AX=005Dh
--------V-62005D-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MEMORY" - GET SIZE OF VIDEO MEMORY
	AX = 005Dh
Return: AX = size of video memory in KB
Notes:	For FGDRIVER v1.10, this function was "FG_TCXFER" (see AX=00A6h);
	  "FG_MEMORY" did not exist yet
	You must first call "FG_SVGAINIT" (see AX=00A1h) before using this
	  function
SeeAlso: AX=005Ch
--------V-62005E-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MOUSEBUT" - GET MOUSE BUTTON PRESS/RELEASE CNTS
	AX = 005Eh
	CX = mouse button (1 = left press, 2 = right press, 3 = middle press,
			  -1=left release, -2=right release, -3=middle release)
	ES:BX -> variable pointer record (see below)
Return: variables updated
Notes:	For FGDRIVER v1.10, this function was "FG_TCMASK" (see AX=00A5h);
	  "FG_MOUSEBUT" was AX=007Ch
	This function returns the count of presses or releases since the last
	  call to this function; if the count is zero, row and column will
	  also be zero
SeeAlso: AX=005Fh,AX=0061h,AX=0064h

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of WORD buffer for press/release count
 02h	WORD	offset of WORD buffer for press/release count
 04h	WORD	segment of WORD buffer for screen space col of last press/rls
 06h	WORD	offset of WORD buffer for screen space col of last press/rels
 08h	WORD	segment of WORD buffer for screen space row of last press/rls
 0Ah	WORD	offset of WORD buffer for screen space row of last press/rls
--------V-62005F-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MOUSECUR" - SPECIFY TEXT-MODE MOUSE CURSOR
	AX = 005Fh
	BX = screen mask
	CX = cursor mask
Notes:	For FGDRIVER v1.10, this function was "FG_COPYPAGE" (see AX=0012h);
	  "FG_MOUSECUR" was AX=007Eh
	This call is ignored in graphics modes
SeeAlso: AX=0065h,AX=0067h
--------V-620060-----------------------------
INT 62 u - FGDRIVER v1.10 only - "FG_DISPPCX" - DISPLAY PCX FILE
	AX = 0060h
	ES:BX -> ASCIZ filename
	CX = flags
	    bit 0: use current palette rather than PCX file's palette
	    bits 1-15 reserved (0)
Return: AX = status
	    0000h success
	    0001h file not found
	    0002h file is not a valid PCX file
Notes:	This call is ignored in text modes and Hercules low-resolution graphics
	The image is displayed with its upper left corner at the current
	  graphics cursor position
SeeAlso: AX=009Ah
--------V-620060-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MOUSEFIN" - UNHOOK FASTGRAPH MOUSE HANDLER
	AX = 0060h
Notes:	For FGDRIVER v1.10, this function was "FG_DISPPCX", which no longer
	  exists; "FG_MOUSEFIN" did not exist yet
	This function should be called before switching back to text mode if
	  "FG_MOUSEINI" was called while in an SVGA graphics mode
SeeAlso: AX=0061h
--------V-620061-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MOUSEINI" - INITIALIZE MOUSE SUPPORT
	AX = 0061h
Return: AX = status
	    0002h two-button mouse
	    0003h three-button mouse
	    FFFFh initialization failed
Notes:	For FGDRIVER v1.10, this function was "FG_MAKEPCX" (see AX=0057h);
	  "FG_MOUSEINI" was AX=007Ah
	After this call, the mouse cursor is invisible
SeeAlso: AX=0060h"3.03",AX=0062h,AX=0066h
--------V-620062-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MOUSELIM" - SPECIFY MOUSE CURSOR LIMITS
	AX = 0062h
	BX = left-most position allowed for mouse cursor
	CX = right-most position allowed
	DX = top-most position allowed
	SI = bottom-most position allowed
Note:	For FGDRIVER v1.10, this function was "FG_IMAGESIZ" (see AX=004Bh);
	  "FG_MOUSELIM" was AX=0080h
SeeAlso: AX=0061h,AX=0063h,INT 33/AX=0007h,INT 33/AX=0008h
--------V-620063-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MOUSEMOV" - SET MOUSE CURSOR POSITION
	AX = 0063h
	BX = new column
	CX = new row
Notes:	For FGDRIVER v1.10, this function was unused;"FG_MOUSEMOV" was AX=0081h
	This function will not move the mouse cursor outside the bounding box
	  specified with AX=0080h
SeeAlso: AX=0062h,AX=0064h,INT 33/AX=0004h
--------V-620064-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MOUSEPOS" - GET CURRENT MOUSE POSITION
	AX = 0064h
	ES:BX -> variable pointer record (see below)
Notes:	For FGDRIVER v1.10, this function was "FG_FADEIN" (see AX=0027h);
	  "FG_MOUSEPOS" was AX=007Dh
SeeAlso: AX=0063h

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of WORD buffer for mouse column
 02h	WORD	offset of WORD buffer for mouse column
 04h	WORD	segment of WORD buffer for mouse row
 06h	WORD	offset of WORD buffer for mouse row
 08h	WORD	segment of WORD buffer for button status
 0Ah	WORD	offset of WORD buffer for button status
Note:	button status: bit 0 = left button, bit 1 = right, bit 2 = middle
--------V-620065-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MOUSEPTR" - SPECIFY GRAPH-MODE MOUSE CURSOR
	AX = 0065h
	ES:BX -> masks (16-byte screen mask followed by 16-byte cursor mask)
	CX = X offset of hot spot from upper left corner
	DX = Y offset of hot spot from upper left corner
Notes:	For FGDRIVER v1.10, this function was "FG_FADEOUT" (see AX=0028h);
	  "FG_MOUSEPTR" was AX=007Fh
	This call is ignored in text modes
SeeAlso: AX=005Fh,INT 33/AX=0009h
--------V-620066-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MOUSESPD" - SET MOUSE CURSOR SPEED
	AX = 0066h
	BX = horizontal mickeys per eight pixels of movement (default 16)
	CX = vertical mickeys per eight pixels of movement (default 16)
Note:	For FGDRIVER v1.10, this function was "FG_PAN" (see AX=0071h);
	  "FG_MOUSESPD" was AX=0082h
SeeAlso: INT 33/AX=000Fh,INT 33/AX=001Ah
--------V-620067-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MOUSEVIS" - SET MOUSE CURSOR VISIBILITY
	AX = 0067h
	BX = new state (0000h invisible, 0001h visible)
Note:	For FGDRIVER v1.10, this function was "FG_SCROLL" (see AX=0089h);
	  "FG_MOUSEVIS" was AX=007Bh
SeeAlso: AX=0061h,INT 33/AX=0001h,INT 33/AX=0002h
--------V-620068-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MOVE" - SET GRAPHICS CURSOR POSITION
	AX = 0068h
	BX = new column
	CX = new row
Notes:	For FGDRIVER v1.10, this function was unused; "FG_MOVE" was AX=0023h
	This call is ignored in text modes
SeeAlso: AX=0045h,AX=0047h,AX=0055h,AX=0063h,AX=0069h,AX=00AFh
--------V-620069-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MOVEREL" - ADJUST GRAPHICS CURSOR POSITION
	AX = 0069h
	BX = column offset
	CX = row offset
Notes:	For FGDRIVER v1.10, this function was unused; "FG_MOVEREL" was AX=0024h
	This call is ignored in text modes
SeeAlso: AX=0045h,AX=0047h,AX=0068h
--------V-62006A-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MUSIC" - PLAY SERIES OF NOTES
	AX = 006Ah
	ES:BX -> '$'-terminated music string in BASIC PLAY format
Return: after music completed
Notes:	For FGDRIVER v1.10, this function was unused; "FG_MUSIC" was AX=008Ch
	This call is ignored if asynchronous sound (AX=0089h,AX=008Bh,
	  AX=008Dh) is already in progress
SeeAlso: AX=006Bh,AX=009Dh,AX=00AAh
--------V-62006B-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_MUSICB" - PLAY SERIES OF NOTES IN BACKGROUND
	AX = 006Bh
	CX = number of repetitions (negative = continuous play)
	ES:BX -> '$'-terminated music string in BASIC PLAY format
Notes:	For FGDRIVER v1.10, this function was unused; "FG_MUSICB" was AX=008Dh
	This call is ignored if asynchronous sound (AX=0089h,AX=008Bh,
	  AX=008Dh) is already in progress
SeeAlso: AX=0048h,AX=006Bh,AX=009Eh,AX=00ABh
--------V-62006C-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_NUMLOCK" - GET STATE OF NUMLOCK KEY
	AX = 006Ch
Return: AX = NumLock state (0000h off, 0001h on)
Note:	For FGDRIVER v1.10, this function was unused; "FG_NUMLOCK" was AX=0072h
SeeAlso: AX=000Ah,AX=0088h,AX=008Bh,AX=0094h
--------V-62006D-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_PAGESIZE" - GET VIDEO PAGE SIZE FOR CURR MODE
	AX = 006Dh
Return: DX:AX = page size in bytes
Note:	For FGDRIVER v1.10, this function was "FG_WAITKEY" (see AX=00ADh);
	  "FG_PAGESIZE" did not exist yet
SeeAlso: AX=005Dh
--------V-62006E-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_PAINT" - FLOOD CLOSED REGION WITH COLOR
	AX = 006Eh
	BX = column
	CX = row
Notes:	For FGDRIVER v1.10, this function was "FG_GETKEY" (see AX=003Ah);
	   "FG_PAINT" was AX=002Fh
	This function fills an arbitrary closed region around the specified
	  point with the current color; the screen edges are not considered
	  region boundaries
	This call is ignored in text modes
SeeAlso: AX=002Bh
--------V-62006F-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_PALETTE" - SET PALETTE / SET VIDEO DAC REGISTER
	AX = 006Fh
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
Notes:	For FGDRIVER v1.10, this function was "FG_INTKEY" (see AX=0051h);
	   "FG_PALETTE" was AX=0017h
	This function is ignored in text modes and Hercules graphics modes
	Few EGA/VGA adapters correctly set the foreground color in CGA mode 6
SeeAlso: AX=0035h,AX=0042h,AX=0070h,AX=008Eh
--------V-620070-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_PALETTES" - SET ALL PALETTE REGISTERS
	AX = 0070h
	ES:BX -> array of 16 WORDs containing values for palette registers
		(or first 16 DAC registers in 256-color modes)
Notes:	For FGDRIVER v1.10, this function was "FG_CAPSLOCK" (see AX=000Ah);
	   "FG_PALETTES" was AX=0018h
	This function is ignored in text modes, CGA and Hercules graphics modes
SeeAlso: AX=0035h,AX=0042h,AX=006Fh,AX=008Eh
--------V-620071-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_PAN" - SET SCREEN ORIGIN
	AX = 0071h
	BX = new column for screen origin
	CX = new row for screen origin
Note:	For FGDRIVER v1.10, this function was "FG_SETCAPS" (see AX=008Bh);
	   "FG_PAN" was AX=0066h
SeeAlso: AX=0095h
--------V-620072-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_PATTERN" - SPECIFY DISPLAY PATTERN FOR COLOR
	AX = 0072h
	BX = index of pattern to define
	CX = number of predefined display pattern
Notes:	For FGDRIVER v1.10, this function was "FG_NUMLOCK" (see AX=006Ch);
	   "FG_PATTERN" was AX=0050h
	When displaying a pixel run map, Fastgraph uses the pattern associated
	  with each color index rather than displaying the actual color
	This call has no effect in text and 256-color graphics modes
SeeAlso: AX=0021h,AX=0039h
--------V-620073-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_PCXHEAD" - GET PCX FILE HEADER
	AX = 0073h
	ES:BX -> variable pointer record (see below)
Return: AX = status
	    0000h successful
	    FFFEh not a PCX file
	    FFFFh file does not exist
Note:	For FGDRIVER v1.10, this function was "FG_SETNUM" (see AX=0094h);
	   "FG_PCXHEAD" did not exist yet
SeeAlso: AX=0074h,AX=009Ah

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of ASCIZ filename
 02h	WORD	offset of ASCIZ filename
 04h	WORD	segment of 128-byte buffer for PCX header
 06h	WORD	offset of 128-byte buffer for PCX header
--------V-620074-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_PCXMODE" - GET OPTIMAL VIDEO MODE FOR DISPLAY
	AX = 0074h
	ES:BX -> PCX header (see AX=0073h)
Return: AX = optimal video mode for PCX file
	    FFFEh not a valid PCX header
	    FFFFh unable to determine compatible video mode
Note:	For FGDRIVER v1.10, this function was "FG_SCRLOCK" (see AX=0088h);
	   "FG_PCXMODE" did not exist yet
SeeAlso: AX=0073h,AX=009Ah
--------V-620075-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_PLAYING" - DETERMINE WHETHER ASYNC SOUND ACTIVE
	AX = 0075h
Return: AX = sound state (0 = no asynchronous sound, 1 = async sound playing)
Note:	For FGDRIVER v1.10, this function was "FG_INITJOY" (see AX=004Dh);
	   "FG_PLAYING" was AX=0091h
SeeAlso: AX=0048h,AX=006Bh,AX=009Eh,AX=00ABh
--------V-620076-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_POINT" - DISPLAY A PIXEL
	AX = 0076h
	BX = column
	CX = row
Notes:	For FGDRIVER v1.10, this function was "FG_GETXJOY" (see AX=0044h);
	   "FG_POINT" was AX=001Fh
	This call is ignored in text modes
SeeAlso: AX=0006h,AX=001Bh,AX=0041h,AX=0077h
--------V-620077-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_POINTX" - DISPLAY A PIXEL IN XOR MODE
	AX = 0077h
	BX = column
	CX = row
Notes:	For FGDRIVER v1.10, this function was "FG_GETYJOY" (see AX=0046h);
	   "FG_POINTX" did not exist yet
	This call is ignored in text modes
SeeAlso: AX=0041h,AX=0076h
--------V-620078-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_POLYFILL" - DRAW A FILLED CONVEX POLYGON
	AX = 0078h
	CX = number of vertices
	ES:BX -> variable pointer record (see below)
Notes:	For FGDRIVER v1.10, this function was "FG_BUTTON" (see AX=0009h);
	   "FG_POLYFILL" did not exist yet
	The vertex array consists of pairs of words specifying the X and Y
	  coordinates of each vertex; the work array is used internally and
	  must contain at least four times as many bytes as the polygon is
	  high in pixels
	This function is ignored in text modes
	If the polygon is non-convex, only a portion of it may be filled
SeeAlso: AX=000Eh,AX=0025h,AX=0079h,AX=007Ah,AX=007Bh

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of vertex array
 02h	WORD	offset of vertex array
 04h	WORD	segment of work array
 06h	WORD	offset of work array
--------V-620079-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_POLYGON" - DRAW AN UNFILLED POLYGON
	AX = 0079h
	CX = number of vertices in polygon
	ES:BX -> variable pointer record (see below)
Notes:	For FGDRIVER v1.10, this function was "FG_INTJOY" (see AX=0050h);
	   "FG_POLYGON" was AX=002Eh
	This call is ignored in text modes
SeeAlso: AX=0078h,AX=007Ah,AX=007Bh

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of WORD array containing vertex columns
 02h	WORD	offset of WORD array containing vertex columns
 04h	WORD	segment of WORD array containing vertex rows
 06h	WORD	offset of WORD array containing vertex rows
--------V-62007A-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_POLYLINE" - DRAW AN UNFILLED POLYGON
	AX = 007Ah
	CX = number of vertices in polygon
	ES:BX -> vertex array (see below)
Notes:	For FGDRIVER v1.10, this function was "FG_MOUSEINI" (see AX=0061h);
	   "FG_POLYLINE" did not exist yet
	This function is equivalent to "FG_POLYGON", but uses only a single
	  array to define the vertices
	This call is ignored in text modes
SeeAlso: AX=0076h,AX=0078h,AX=0079h,AX=007Bh

Format of vertex array element:
Offset	Size	Description
 00h	WORD	column
 02h	WORD	row
--------V-62007B-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_POLYOFF" - DEFINE POLYGON DRAWING OFFSET
	AX = 007Bh
	BX = horizontal offset (default 0)
	CX = vertical offset (default 0)
Desc:	define the offsets applied to all vertices of polygons drawn with
	  "FG_POLYFILL" or "FG_POLYLINE"
Note:	For FGDRIVER v1.10, this function was "FG_MOUSEVIS" (see AX=0067h);
	   "FG_POLYOFF" did not exist yet
SeeAlso: AX=0078h,AX=007Ah
--------V-62007C-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_PRINT" - DISPLAY STRING OF HARDWARE CHARACTERS
	AX = 007Ch
	CX = length of string
	ES:BX -> string to display
Notes:	For FGDRIVER v1.10, this function was "FG_MOUSEBUT" (see AX=005Eh);
	   "FG_PRINT" did not exist yet
	The string is displayed in the current color, and the graphics cursor
	  is updated to be just to the right of the last displayed character
	This function is ignored in text modes
SeeAlso: AX=000Ch,AX=002Dh,AX=0052h
--------V-62007D-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_PUTBLOCK" - RESTORE RECTANGLE OF DISPLAY
	AX = 007Dh
	ES:BX -> buffer containing previously-saved image
	CX = left edge
	DX = right edge
	SI = top edge
	DI = bottom edge
Notes:	For FGDRIVER v1.10, this function was "FG_MOUSEPOS" (see AX=0064h);
	   "FG_PUTBLOCK" did not exist yet
	In text modes, coordinates are character positions; in graphics modes,
	  they are defined in screen space, and the left and right edges are
	  adjusted to a byte boundary if necessary
SeeAlso: AX=0031h,AX=007Eh
--------V-62007E-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_PUTIMAGE" - DISPLAY MODE-SPECIFIC BITMAP IMAGE
	AX = 007Eh
	ES:BX -> buffer containing mode-specific bitmap
	CX = width in bytes
	DX = height in pixel rows
Notes:	For FGDRIVER v1.10, this function was "FG_MOUSECUR" (see AX=005Fh);
	   "FG_PUTIMAGE" did not exist yet
	The bitmap is displayed with its lower left corner at the graphics
	  cursor position; color 0 is NOT treated as transparent
SeeAlso: AX=0010h,AX=0022h,AX=002Ch,AX=0038h,AX=007Dh
--------V-62007F-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_QUIET" - STOP CONTINUOUS SYNCHRONOUS SOUND
	AX = 007Fh
Notes:	For FGDRIVER v1.10, this function was "FG_MOUSEPTR" (see AX=0065h);
	  "FG_QUIET" was AX=0090h
	This call has no effect if there is no continuous sound playing
SeeAlso: AX=0048h,AX=006Ah,AX=009Eh,AX=00ABh
--------V-620080-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_RECT" - DRAW UNFILLED RECTANGLE IN SCREEN SPACE
	AX = 0080h
	BX = left edge column
	CX = right edge column
	DX = top edge row
	SI = bottom edge row
Notes:	For FGDRIVER v1.10, this function was "FG_MOUSELIM" (see AX=0062h);
	  "FG_RECT" was AX=002Ah
SeeAlso: AX=0006h,AX=0011h,AX=0021h,AX=0031h
--------V-620081-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_RESET" - ERASE SCREEN AND RESTORE SCREEN ATTR
	AX = 0081h
Notes:	For FGDRIVER v1.10, this function was "FG_MOUSEMOV" (see AX=0063h);
	  "FG_RESET" was AX=0006h
	This call is ignored in graphics modes
	The screen attributes are only restored if ANSI.SYS is loaded
SeeAlso: AX=0026h,AX=0093h
--------V-620082-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_RESIZE" - SET GRAPHICS MODE VIDEO PAGE SIZE
	AX = 0082h
	BX = new page width in pixels
	CX = new page height in pixels
Notes:	For FGDRIVER v1.10, this function was "FG_MOUSESPD" (see AX=0066h);
	  "FG_RESIZE" was AX=0045h
	The visible page must be set to 0000h before making this call
	The mouse, joysticks, expanded memory, and extended memory must be
	  reinitialized after this call
SeeAlso: AX=006Dh,AX=008Fh
--------V-620083-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_RESTORE" - COPY REGION FROM HIDDEN TO VIS PAGE
	AX = 0083h
	BX = left edge column
	CX = right edge column
	DX = top edge row
	SI = bottom edge row
Notes:	For FGDRIVER v1.10, this function was unused; "FG_RESTORE" was AX=005Bh
	The left and right edges are adjusted to byte boundaries if necessary
SeeAlso: AX=0087h,AX=00A6h
--------V-620084-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_RESUME" - RESTART ASYNCHRONOUS SOUND
	AX = 0084h
Notes:	For FGDRIVER v1.10, this function was unused; "FG_RESUME" was AX=0092h
SeeAlso: AX=009Eh,AX=00A0h
--------V-620085-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_REVIMAGE" - DISPLAY REVERSED IMAGE (BITMAP)
	AX = 0085h
	ES:BX -> mode-specific bitmap
	CX = width of bitmap in bytes
	DX = height of bitmap in pixel rows
Notes:	For FGDRIVER v1.10, this function was unused;"FG_REVIMAGE" was AX=004Bh
	This call is ignored in text modes
	The image is drawn with its lower left corner at the current graphics
	  cursor position
SeeAlso: AX=0010h,AX=0022h,AX=002Ch,AX=0038h,AX=0086h,AX=008Ch,AX=009Ah
--------V-620086-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_REVMASK" - DISPLAY REVERSED IMAGE (MASKING MAP)
	AX = 0086h
	ES:BX -> array containing image stored as a masking map (see AX=001Dh)
	CX = number of pixel runs in masking map
	DX = width of masking map in pixels
Notes:	For FGDRIVER v1.10, this function was unused; "FG_REVMASK" was AX=0053h
	This call is ignored in text modes and in native EGA and VGA graphics
	  modes
	The image is drawn with its lower left corner at the current graphics
	  cursor position
SeeAlso: AX=000Fh,AX=001Dh,AX=002Ah,AX=0085h,AX=008Ch,AX=00A5h
--------V-620087-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SAVE" - COPY REGION FROM VISIBLE TO HIDDEN PAGE
	AX = 0087h
	BX = left edge column
	CX = right edge column
	DX = top edge row
	SI = bottom edge row
Notes:	For FGDRIVER v1.10, this function was unused; "FG_SAVE" was AX=005Ah
	The left and right edges are adjusted to byte boundaries if necessary
SeeAlso: AX=0083h,AX=00A6h
--------V-620088-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SCRLOCK" - GET STATE OF SCROLL LOCK KEY
	AX = 0088h
Return: AX = ScrollLock state (0000h off, 0001h on)
Program: FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
Note:	For FGDRIVER v1.10, this function was "FG_SOUND" (see AX=009Dh);
	  "FG_SCRLOCK" was AX=0074h
SeeAlso: AX=000Ah,AX=006Ch,AX=008Bh,AX=0094h
--------V-620089-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SCROLL" - VERTICALLY SCROLL SCREEN REGION
	AX = 0089h
	BX = left edge column
	CX = right edge column
	DX = top edge row
	SI = bottom edge row
	DI = number of pixels by which to scroll (positive scrolls up,
		negative scrolls down)
	ES = type of scroll
	    0000h circular (rows scrolled off are copied to vacated rows)
	    else vacated rows are filled with the current color
Notes:	For FGDRIVER v1.10, this function was "FG_SOUNDS" (see AX=009Eh);
	  "FG_SCROLL" was AX=0067h
	In graphics modes, the left and right edges are adjusted to byte
	  boundaries if necessary
	Circular scrolling uses part of the hidden page as a workspace
SeeAlso: AX=0071h,AX=0095h
--------V-62008A-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETATTR" - SET TEXT-MODE CHARACTER ATTRIBUTE
	AX = 008Ah
	BX = foreground
	CX = background
	DX = blink (0000h nonblinking, 0001h blink)
Notes:	For FGDRIVER v1.10, this function was "FG_VOICE" (see AX=00AAh);
	  "FG_SETATTR" was AX=0019h
	This call is ignored in graphics modes
SeeAlso: AX=000Bh,,AX=0030h,AX=0034h
--------V-62008B-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETCAPS" - SET STATE OF CAPSLOCK KEY
	AX = 008Bh
	BX = new state (0000h off, 0001h on)
Note:	For FGDRIVER v1.10, this function was "FG_VOICES" (see AX=00ABh);
	  "FG_SETCAPS" was AX=0071h
SeeAlso: AX=000Ah,AX=006Ch,AX=0088h,AX=0094h
--------V-62008C-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETCLIP" - SET CLIPPING REGION
	AX = 008Ch
	BX = left edge of clipping region
	CX = right edge of clipping region
	DX = top edge of clipping region
	SI = bottom edge of clipping region
Note:	For FGDRIVER v1.10, this function was "FG_MUSIC" (see AX=006Ah);
	  "FG_SETCLIP" was AX=0029h
SeeAlso: AX=000Fh,AX=001Dh,AX=002Ah,AX=0086h,AX=00A5h
--------V-62008D-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETCOLOR" - SET CURRENT COLOR
	AX = 008Dh
	BX = new color index (or text attribute in text modes)
Note:	For FGDRIVER v1.10, this function was "FG_MUSICB" (see AX=006Bh);
	  "FG_SETCOLOR" was AX=001Ah
SeeAlso: AX=0016h,AX=0034h,AX=0039h
--------V-62008E-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETDACS" - SET VIDEO DAC CONTENTS
	AX = 008Eh
	CX = number of DAC registers to set (0001h to 0100h)
	DX = starting DAC register number (0000h to 00FFh)
	ES:BX -> buffer containing DAC red/green/blue triples
Notes:	For FGDRIVER v1.10, this function was "FG_HUSH" (see AX=0048h);
	  "FG_SETDACS" was AX=00A5h
	The register number wraps back to zero after reaching FFh
	This call has no effect in text modes or graphics modes below 11h
SeeAlso: AX=0035h,AX=0042h,AX=006Fh,INT 10/AX=1012h
--------V-62008F-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETENTRY" - SET TYPE AND ADDRESS OF VIDEO PAGE
	AX = 008Fh
	BX = page number (00h-3Fh)
	CX = page address
	DX = page type (see AX=0036h)
Notes:	For FGDRIVER v1.10, this function was "FG_HUSHNEXT" (see AX=0049h);
	  "FG_SETENTRY" did not exist yet
SeeAlso: AX=002Eh,AX=0036h,AX=0093h
--------V-620090-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETFUNC" - SET LOGICAL OPERATION FOR VIDEO OPS
	AX = 0090h
	BX = operation
	    0000h replacement
	    0001h AND
	    0002h OR
	    0003h XOR
Notes:	For FGDRIVER v1.10, this function was "FG_QUIET" (see AX=007Fh);
	  "FG_SETFUNC" was AX=009Ch
	This function is only available in native EGA/VGA graphics modes
	  (0Dh to 12h)
SeeAlso: AX=001Ch,AX=0076h
--------V-620091-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETHPAGE" - SET HIDDEN VIDEO PAGE
	AX = 0091h
	BX = new hidden page (0000h to 003Fh)
Notes:	For FGDRIVER v1.10, this function was "FG_PLAYING" (see AX=0075h);
	  "FG_SETHPAGE" was AX=0041h
	The specified page must be a physical page or a virtual page
SeeAlso: AX=0037h,AX=0095h,AX=0098h
--------V-620092-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETLINES" - SET TEXT ROWS ON SCREEN
	AX = 0092h
	BX = new screen size (25, 43, 50)
Note:	For FGDRIVER v1.10, this function was "FG_RESUME" (see AX=0084h);
	  "FG_SETLINES" was AX=0011h
SeeAlso: AX=003Bh
--------V-620093-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETMODE" - SELECT VIDEO MODE AND INITIALIZE
	AX = 0093h
	BX = new video mode or FFFFh for current mode
	ES:DX -> WORD ???
Notes:	For FGDRIVER v1.10, this function was "FG_SUSPEND" (see AX=00A0h);
	  "FG_SETMODE" was AX=0001h
	This call resets the active video page to page 0000h, the clipping
	  region to the entire screen, text rows to 25, etc.
SeeAlso: AX=003Fh,INT 10/AH=00h

Values for video mode:
 00h-07h standard BIOS modes
 09h	PCjr/Tandy1000 320x200x16
 0Bh	Hercules graphics 720x348
 0Ch	Hercules graphics 320x200
 0Dh-13h standard BIOS modes
 14h	VGA graphics 320x200x256
 15h	VGA graphics 320x400x256
 16h	VGA graphics 320x240x256
 17h	VGA graphics 320x480x256
 18h	SVGA graphics 640x400x256
 19h	SVGA graphics 640x480x256
 1Ah	SVGA graphics 800x600x256
 1Bh	SVGA graphics 1024x768x256
 1Ch	SVGA graphics 800x600x16
 1Dh	SVGA graphics 1024x768x16
--------V-620094-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETNUM" - SET STATE OF NUMLOCK KEY
	AX = 0094h
	BX = new state (0000h off, 0001h on)
Note:	For FGDRIVER v1.10, this function was unused; "FG_SETNUM" was AX=0073h
SeeAlso: AX=000Ah,AX=006Ch,AX=0088h,AX=008Bh
--------V-620095-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETPAGE" - SET ACTIVE VIDEO PAGE
	AX = 0095h
	BX = new video page (0000h to 003Fh)
Notes:	For FGDRIVER v1.10, this function was unused; "FG_SETPAGE" was AX=003Dh
	The specified page must be a physical or virtual page
SeeAlso: AX=002Fh,AX=0036h,AX=0037h,AX=0043h,AX=0071h
--------V-620096-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETRGB" - SET VIDEO DAC REGISTER CONTENTS
	AX = 0096h
	BX = palette or DAC register number
	CX = red color component
	DX = green component
	SI = blue component
Notes:	For FGDRIVER v1.10, this function was "FG_WAITFOR" (see AX=00ACh);
	  "FG_SETRGB" was AX=001Bh
	The register number may be negative for Tandy, PCjr, and 200-line
	  EGA graphics modes to specify an intense color
	This call has no effect in text, CGA graphics, and Hercules graphics
	  modes
SeeAlso: AX=0042h
--------V-620097-----------------------------
INT 62 u - FGDRIVER v3.03 - UNUSED
	AX = 0097h
Return: AX = 0000h
Note:	For FGDRIVER v1.10, this function was "FG_STALL" (see AX=009Fh)
--------V-620098-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SETVPAGE" - SET VISIBLE VIDEO PAGE
	AX = 0098h
	BX = new video page (0000h to 003Fh)
Notes:	For FGDRIVER v1.10, this function was "FG_MEASURE" (see AX=005Bh);
	  "FG_SETVPAGE" was AX=003Fh
	The specified page must be a physical or virtual page
SeeAlso: AX=0037h,AX=0091h,AX=0095h
--------V-620099-----------------------------
INT 62 u - FGDRIVER v3.03 - UNUSED
	AX = 0099h
Return: AX destroyed
Note:	For FGDRIVER v1.10, this function was "FG_GETCLOCK" (see AX=0033h)
--------V-62009A-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SHOWPCX" - DISPLAY IMAGE FROM PCX FILE
	AX = 009Ah
	ES:BX -> ASCIZ filename of PCX image
	CX = flags (see below)
Return: AX = status
	    0000h success
	    0001h file not found
	    0002h not a PCX file
Notes:	For FGDRIVER v1.10, this function was unused; "FG_SHOWPCX" did not
	  exist yet
	This function is ignored in text modes and Hercules low-res graphics
SeeAlso: AX=004Ah,AX=0057h,AX=0058h,AX=0059h,AX=0060h"1.10",AX=009Bh,AX=009Ch

Bitfields for flags:
 bit 0	use current palette rather than PCX file's palette
 bit 1	display image at cursor position instead of position in PCX header
 bits 2-15 reserved
--------V-62009B-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SHOWPPR" - DISPLAY IMAGE FROM PPR FILE
	AX = 009Bh
	ES:BX -> ASCIZ filename of packed pixel run image
	CX = width in pixels (nonzero)
Return: AX = status
	    0000h successful
	    0001h file not found
Notes:	For FGDRIVER v1.10, this function was "FG_MEMAVAIL" (see AX=005Ch);
	  "FG_SHOWPPR" did not exist yet
	The image is displayed with its lower left corner at the current
	  graphics cursor position
	This function is ignored in text modes and 256-color graphics modes
SeeAlso: AX=004Ah,AX=0057h,AX=0058h,AX=0059h,AX=009Ah,AX=009Ch
--------V-62009C-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SHOWSPR" - DISPLAY IMAGE FROM SPR FILE
	AX = 009Ch
	ES:BX -> ASCIZ filename of standard pixel run image
	CX = width in pixels (nonzero)
Return: AX = status
	    0000h successful
	    0001h file not found
Notes:	For FGDRIVER v1.10, this function was "FG_SETFUNC" (see AX=0090h);
	  "FG_SHOWSPR" did not exist yet
	The image is displayed with its lower left corner at the current
	  graphics cursor position
	This function is ignored in text modes
SeeAlso: AX=004Ah,AX=0057h,AX=0058h,AX=0059h,AX=009Ah,AX=009Bh
--------V-62009D-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SOUND" - MAKE SOUND FOR SPECIFIED DURATION
	AX = 009Dh
	BX = frequency in Hertz (18-32767)
	CX = duration in clock ticks (0000h or negative for continuous sound)
Notes:	For FGDRIVER v1.10, this function was "FG_ALLOCCMS" (see AX=0001h);
	  "FG_SOUND" was AX=0088h
	This call is ignored if asynchronous sound (AX=0089h,AX=008Bh,
	  AX=008Dh) is already in progress
SeeAlso: AX=0048h,AX=006Ah,AX=009Eh,AX=00A0h,AX=00AAh
--------V-62009E-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SOUNDS" - PLAY SOUNDS IN BACKGROUND
	AX = 009Eh
	CX = number of times to cycle through sound list
	ES:BX -> sounds array (see below)
Notes:	For FGDRIVER v1.10, this function was "FG_ALLOCEMS" (see AX=0002h);
	  "FG_SOUNDS" was AX=0089h
	This call is ignored if asynchronous sound (AX=0089h,AX=008Bh,
	  AX=008Dh) is already in progress
SeeAlso: AX=0048h,AX=006Bh,AX=009Dh,AX=00A0h,AX=00ABh

Format of sounds array element:
Offset	Size	Description
 00h	WORD	frequency of sound in Hertz (0000h ends array)
 02h	WORD	duration of sound in clock ticks
--------V-62009F-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_STALL" - PAUSE FOR SPECIFIED DURATION
	AX = 009Fh
	BX = duration in processor-dependent delay units (see AX=0098h)
Return: after delay elapses
Note:	For FGDRIVER v1.10, this function was "FG_ALLOCXMS" (see AX=0003h);
	  "FG_STALL" was AX=0097h
SeeAlso: AX=005Bh,INT 2F/AX=1224h
--------V-6200A0-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SUSPEND" - TEMPORARILY STOP ASYNCHRONOUS SOUND
	AX = 00A0h
Notes:	For FGDRIVER v1.10, this function was "FG_INITEMS" (see AX=004Ch);
	  "FG_SUSPEND" was AX=0093h
	This call has no effect if there is no asynchronous sound in progress
	The program must not exit while sound is suspended
SeeAlso: AX=0048h,AX=006Ah,AX=009Eh,AX=00A0h,AX=00AAh
--------V-6200A1-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SVGAINIT" - INITIALIZE FASTGRAPH SVGA KERNEL
	AX = 00A1h
	BX = method (see below)
Return: AX = status
	    0000h no VESA BIOS or supported SVGA chipset
	    0001h using VESA BIOS
	    0002h-0016h specific chipset being used (same as "method" below)
Notes:	For FGDRIVER v1.10, this function was "FG_INITXMS" (see AX=004Eh);
	  "FG_SVGAINIT" did not exist yet
	This function must be called before attempting to set SVGA graphics
	  modes (18h to 1Dh) or using "FG_BESTMODE", "FG_TESTMODE", or
	  "FG_MEMORY"
SeeAlso: AX=0023h,AX=00A2h,AX=00A3h

Values for method:
 0000h	autodetect, give chipset-specific code priority over VESA
 0001h	autodetect, give VESA priority over chipset-specific code
 0002h	Ahead type "A"
 0003h	Ahead type "B"
 0004h	ATI 18800
 0005h	ATI 18800-1
 0006h	ATI 28800
 0007h	Chips & Technologies 82c451/455/456
 0008h	C&T 82c452
 0009h	C&T 82c453
 000Ah	Genoa 6000 series
 000Bh	Oak OTI-067
 000Ch	Paradise PVGA1a
 000Dh	Paradise WD90C00/WD90C10
 000Eh	Paradise WD90C11/WD90C30/WD90C31
 000Fh	Trident 8800
 0010h	Trident 8900
 0011h	Tseng ET3000
 0012h	Tseng ET4000
 0013h	Video7
 0014h	Cirrus Logic 5400 series
 0015h	S3
 0016h	Trident 8900B/8900C/9000
--------V-6200A2-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SVGASTAT" - GET SVGA CHIPSET INFORMATION
	AX = 00A2h
Return: AX = chipset information (see below)
Note:	For FGDRIVER v1.10, this function was "FG_BOX" (see AX=0006h);
	  "FG_SVGASTAT" did not exist yet
SeeAlso: AX=0023h,AX=00A1h,AX=00A3h

Bitfields for chipset information:
 bit 0	SVGA kernel initialized
 bit 1	VESA support enabled
 bit 2	extended video pages available in modes 13-23
 bit 3	SVGA chipset has separate read and write banks
 bits 4-15 reserved (0)
--------V-6200A3-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_SVGAVER" - GET FASTGRAPH SVGA KERNEL VERSION
	AX = 00A3h
	ES:BX -> variable pointer record (see below)
Note:	For FGDRIVER v1.10, this function was "FG_BOXDEPTH" (see AX=0007h);
	  "FG_SVGAVER" did not exist yet
SeeAlso: AX=00A1h,AX=00A2h

Format of variable pointer record:
Offset	Size	Description
 00h	WORD	segment of WORD buffer for major version
 02h	WORD	offset of WORD buffer for major version
 04h	WORD	segment of WORD buffer for minor version (hundredths)
 06h	WORD	offset of WORD buffer for minor version
--------V-6200A4-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_TCDEFINE" - DEFINE TRANSPARENCY OF COLOR INDEX
	AX = 00A4h
	BX = color index
	CX = transparency (00h opaque, other transparent)
Notes:	For FGDRIVER v1.10, this function was "FG_GETDACS" (see AX=0035h);
	  "FG_TCDEFINE" did not exist yet
	This function is ignored in text modes
SeeAlso: AX=00A5h,AX=00A6h
--------V-6200A5-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_TCMASK" - SET TRANSPARENT COLORS
	AX = 00A5h
	BX = colors to consider transparent (bit 0 = color 0, etc)
Notes:	For FGDRIVER v1.10, this function was "FG_SETDACS" (see AX=008Eh);
	  "FG_TCMASK" was AX=005Eh
	This call is ignored in text modes
	The specified colors are considered transparent by "FG_TCXFER"
SeeAlso: AX=00A4h,AX=00A6h
--------V-6200A6-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_TCXFER" - COPY REGION EXCLUDING TRANSPARENT
	AX = 00A6h
	CX = source video page
	DX = destination video page
	ES:BX -> copy record (see below)
Notes:	For FGDRIVER v1.10, this function was unused; "FG_TCXFER" was AX=005Dh
	Pixels which are in any of the colors defined as transparent with
	  "FG_TCMASK" (see AX=00A5h) are left unchanged in the destination
	  region
	The source and destination regions must not overlap if they are located
	  on the same page
	This call is ignored in text modes
SeeAlso: AX=00A4h,AX=00A5h,AX=00A9h

Format of copy record:
Offset	Size	Description
 00h	WORD	left edge column of source region
 02h	WORD	right edge column of source region
 04h	WORD	top edge row of source region
 06h	WORD	bottom edge row of source region
 08h	WORD	left edge of destination
 0Ah	WORD	bottom edge of destination
--------V-6200A7-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_TESTMODE" - CHECK IF VIDEO MODE AVAILABLE
	AX = 00A7h
	BX = desired video mode (00h-17h, also 18h-1Dh after "FG_SVGAINIT")
	CX = required number of video pages (ignore memory size if <= 0)
Return: AX = status
	    0000h mode not available with requested number of pages
	    0001h mode is available
Note:	For FGDRIVER v1.10, this function was unused;"FG_TESTMODE" was AX=0002h
SeeAlso: AX=0005h,AX=0093h
--------V-6200A8-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_TEXT" - DISPLAY STRING OF CHARACTERS
	AX = 00A8h
	CX = length of string
	ES:BX -> string
Notes:	For FGDRIVER v1.10, this function was unused; "FG_TEXT" was AX=0032h
	The string is displayed starting at the text cursor position using the
	  current text attribute (text modes) or color index (graphics modes)
	The text cursor position is updated after this call
SeeAlso: AX=000Ch,AX=007Ch
--------V-6200A9-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_TRANSFER" - COPY REGION
	AX = 00A9h
	CX = source video page
	DX = destination video page
	ES:BX -> copy record (see below)
Notes:	For FGDRIVER v1.10, this function was unused;"FG_TRANSFER" was AX=005Ch
	The source and destination regions must not overlap if they are located
	  on the same page
SeeAlso: AX=0083h,AX=0087h,AX=0089h,AX=00A6h

Format of copy record:
Offset	Size	Description
 00h	WORD	left edge column of source region
 02h	WORD	right edge column of source region
 04h	WORD	top edge row of source region
 06h	WORD	bottom edge row of source region
 08h	WORD	left edge of destination
 0Ah	WORD	bottom edge of destination
--------V-6200AA-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_VOICE" - START SOUND
	AX = 00AAh
	BX = channel on TI sound chip
		1-3 = channels 1-3, 4 = channel 4 with periodic noise,
		5 = channel 4 with white noise
	CX = frequency in Hz (18-32767 for channels 1-3; 0=512 Hz, 1=1024 Hz,
		2=2048 Hz for channels 4 and 5)
	DX = volume
	SI = duration in clock ticks (continuous if <= 0)
Program: FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
Notes:	For FGDRIVER v1.10, this function was unused; "FG_VOICE" was AX=008Ah
	This function is only available on the PCjr and Tandy 1000 machines
SeeAlso: AX=006Ah,AX=009Dh,AX=00ABh
--------V-6200AB-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_VOICES" - PLAY SOUNDS IN BACKGROUND
	AX = 00ABh
	ES:BX -> tone array (see below)
	CX = number of times to repeat tone array
Notes:	For FGDRIVER v1.10, this function was unused; "FG_VOICES" was AX=008Bh
	This function is only available on the PCjr and Tandy 1000 machines
SeeAlso: AX=0048h,AX=006Bh,AX=009Eh,AX=00AAh

Format of tone array element:
Offset	Size	Description
 00h	WORD	channel number (0000h terminates array)
 02h	WORD	frequency
 04h	WORD	volume
 06h	WORD	duration in 1/72.8 seconds
--------V-6200AC-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_WAITFOR" - DELAY FOR SPECIFIED DURATION
	AX = 00ACh
	BX = duration in clock ticks
Return: after delay elapses
Note:	For FGDRIVER v1.10, this function was unused; "FG_WAITFOR" was AX=0096h
SeeAlso: AX=009Fh,INT 1A/AX=FF01h
--------V-6200AD-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_WAITKEY" - FLUSH KEYBOARD BUFFER AND AWAIT KEY
	AX = 00ADh
Return: after next key pressed
Note:	For FGDRIVER v1.10, this function was unused; "FG_WAITKEY" was AX=006Dh
SeeAlso: AX=000Ah,AX=003Ah,AX=0051h,AX=0054h,INT 16/AH=00h
--------V-6200AE-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_WAITVR" - ENABLE/DISABLE VERTICAL RETRACE WAIT
	AX = 00AEh
	BX = new state (0000h disabled, 0001h enabled)
Note:	For FGDRIVER v1.10, this function was unused; "FG_WAITVR" did not
	  exist yet
--------V-6200AF-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_WHERE" - GET CURRENT CURSOR POSITION
	AX = 00AFh
	ES:BX -> variable pointers (see below)
Return: indicated variables filled with cursor row and column for active
	  display
Note:	For FGDRIVER v1.10, this function was unused; "FG_WHERE" was AX=0034h
SeeAlso: AX=0045h,AX=0047h,AX=0055h,AX=0068h

Format of variable pointers:
Offset	Size	Description
 00h	WORD	segment of WORD buffer for cursor row
 02h	WORD	offset of WORD buffer for cursor row
 04h	WORD	segment WORD buffer for cursor column
 06h	WORD	offset WORD buffer for cursor column
--------V-6200B0-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_XALPHA" - CONVERT SCREEN COLUMN TO CHAR COLUMN
	AX = 00B0h
	BX = screen space column
Return: AX = character space column containing specified coordinate
Note:	For FGDRIVER v1.10, this function was unused; "FG_XALPHA" was AX=000Ch
SeeAlso: AX=00B1h,AX=00B2h
--------V-6200B1-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_XCONVERT" - CONVERT CHAR COLUMN TO SCREEN COL
	AX = 00B1h
	BX = character space column
Return: AX = screen space column of leftmost pixel in specified character col
Note:	For FGDRIVER v1.10, this function was unused;"FG_XCONVERT" was AX=000Eh
SeeAlso: AX=00B0h,AX=00B3h
--------V-6200B2-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_YALPHA" - CONVERT SCREEN ROW TO CHARACTER ROW
	AX = 00B2h
	BX = screen space row
Return: AX = character space row containing specified coordinate
Note:	For FGDRIVER v1.10, this function was unused; "FG_YALPHA" was AX=000Dh
SeeAlso: AX=00B0h,AX=00B3h
--------V-6200B3-----------------------------
INT 62 u - FGDRIVER v3.03 - "FG_YCONVERT" - CONVERT CHARACTER ROW TO SCREEN ROW
	AX = 00B3h
	BX = character space row
Return: AX = screen space row of topmost pixel in specified character row
Program: FGDRIVER is the external video driver for the shareware
	  Fastgraph/Light by Ted Gruber Software
Note:	For FGDRIVER v1.10, this function was unused;"FG_YCONVERT" was AX=000Fh
SeeAlso: AX=00B1h,AX=00B2h
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
--------n-6610-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - GET ???
	AH = 10h
Return: CF clear
	AX = 0000h
	BX = ??? (0012h)
	DX:CX -> TDMOUSE INT 33 handler (IRET to hide mouse from other apps)
Program: TDMOUSE is a PenDOS hardware driver which allows a mouse to emulate
	  a touchpad; PenDOS is a set of programs by Communication Intelligence
	  Corporation which makes applications pen-aware
--------n-6611-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - SET ??? HANDLER
	AH = 11h
	DX:BX -> new handler for ???
Return: CF clear
	AX = 0000h
	DX:BX -> old handler for ??? (points at RETF by default)
--------n-6612-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - INITIALIZE
	AH = 12h
Return:	CF clear
	AX = 0000h
Note:	this function calls the old mouse handler with functions 0000h, 0002h,
	  0007h, 0008h, 000Fh, 0004h, and 000Ch (in that order)
SeeAlso: AH=13h
--------n-6613-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - SHUTDOWN???
	AH = 13h
Return: CF clear
	other register as returned by INT 33/AX=0000h
SeeAlso: AH=12h
--------n-6614-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - ???
	AH = 14h
	BX = ???
	CX = ???
Return: CF clear
	AX = 0000h
--------n-6615-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - SET ??? HANDLER
	AH = 15h
	DX:BX -> new handler for ???
Return: CF clear
	AX = 0000h
	DX:BX -> old handler (points at RETF by default)
--------n-6616-------------------------------
INT 66 - PenDOS - TDMOUSE.EXE - UNUSED FUNCTIONS
	AH = 16h to 1Fh
Return: CF set
Program: TDMOUSE is a PenDOS hardware driver which allows a mouse to emulate
	  a touchpad; PenDOS is a set of programs by Communication Intelligence
	  Corporation which makes applications pen-aware
--------n-6621-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 21h
Return: CF clear if successful
	CF set on error
Note:	this function sets ??? flag or counter (also set by AH=2Fh) to FFFFh
--------n-6622-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 22h
	DX:BX -> ???
	CL = ???
Return: CF clear if successful
	CF set on error
	???
SeeAlso: AH=24h
--------n-6623-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 23h
	???
Return: CF clear if successful
	CF set on error
	???
--------n-6624-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 24h
	DX:BX -> ???
	CL = ???
Return: CF clear if successful
	CF set on error
	???
SeeAlso: AH=22h
--------n-6625-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 25h
	CL = ??? (NOP if 00h)
	???
Return: CF clear if successful
	CF set on error
	???
--------n-6627-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 27h
	BL = ???
	BH = ???
	CL = ??? (0-3)
	DL = ??? (> BL)
	DH = ??? (> BH)
Return: ???
--------n-6628-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 28h
	???
Return: CF clear if successful
	CF set on error
	???
Note:	this function sets ??? flag or counter (also set by AH=2Fh) to FFFFh
--------n-6629-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 29h
	???
Return: ???
Note:	this function sets ??? flag or counter (also set by AH=2Fh) to FFFFh
--------n-662A-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 2Ah
	DL = ??? (nonzero)
	DH = ??? (nonzero)
Return: CF clear if successful
	CF set on error
	???
--------n-662B-------------------------------
INT 66 - PenDOS - PINK - ???
	AH = 2Bh
	???
Return: CF clear if successful
	CF set on error
	???
--------n-662F-------------------------------
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
--------n-6640-------------------------------
INT 66 - PenDOS - PKEYUS - GET VERSION
	AH = 40h
Return: CF clear
	AX = 0000h
	BH = major version (02h for version bundled with IBM DOS 6.1)
	BL = minor version (00h for version bundled with IBM DOS 6.1)
	DL = ??? (4Eh)
	DH = ??? (0Eh)
--------n-6641-------------------------------
INT 66 - PenDOS - PKEYUS - SET ???
	AH = 41h
	BX = ???
	CL = ??? (08h-20h)
	DL = screen column??? (<= 50h)
	DH = screen row???  (<= 3Ch)
Return: AX = status (0000h successful, 0001h error)
Note:	this function also sets an internal flag
SeeAlso: AH=42h,AH=43h
--------n-6642-------------------------------
INT 66 - PenDOS - PKEYUS - ???
	AH = 42h
Return: CF clear
	AX = 0000h
Note:	this function also clears the flag set by AH=41h
SeeAlso: AH=41h
--------n-6643-------------------------------
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
--------n-6644-------------------------------
INT 66 - PenDOS - PKEYUS - UNUSED FUNCTIONS
	AH = 44h to 4Fh
Return: CF set
--------n-6650-------------------------------
INT 66 - PenDOS - PMOUSE - SET ???
	AH = 50h
	BX = ???
	CH = ???
	DX = ???
Return: CF clear
	AX = 0000h
--------n-6651-------------------------------
INT 66 - PenDOS - PMOUSE - NOP
	AH = 51h
Return: CF set
--------n-6652-------------------------------
INT 66 - PenDOS - PMOUSE - ???
	AH = 52h
	BX = ???
	CL = ???
	DX = ???
Return: ???
--------n-6653-------------------------------
INT 66 - PenDOS - PMOUSE - UNUSED FUNCTIONS
	AH = 53h to 57h
Return: CF set
--------n-66---------------------------------
INT 66 - PenDOS - PMOUSE - ALTERNATE API
	AH = function (58h-5Fh)
Note:	these functions exactly duplicate AH=50h-57h
--------n-66C5-------------------------------
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
	AX = 1303h initialize VIDRAM EMS
		BX = number of pages (less 1) of EMS to allocate
		Return: CF clear if successful
			    DX = EMS handle
			CF set on error
	AX = 1304h shutdown VIDRAM EMS
		DX = EMS handle
		Return: CF clear
	AX = 1305h ??? (related to VIDRAM, changes memory mappings)
		CX = ???
		Return: CF clear
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution (see AX=130Ch) and runs inside a QEMM
			  critical section
	AX = 1306h set DESQview critical section counter address
		ES:BX -> WORD DESQview critical section counter or 0000h:0000h
		Return: CF clear
		Note:	also sets a pointer in the low-memory part of QEMM to
			  the current value of INT 15 if ES:BX not 0000h:0000h
	AX = 1307h ??? (changes memory mappings)
		Return: CF clear
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution (see AX=130Ch) and runs inside a QEMM
			  critical section
	AX = 1308h set/reset ???
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
		BL = ??? (??? or 00h)
		Return: CF clear
			???
		Note:	calls AX=130Eh in some cases
	AX = 130Ch set interrupts to mask
		BX = interrupts to mask out during AX=1302h,AX=1307h,AX=1308h,
			AX=130Dh,AX=1310h (BL = master PIC, BH = slave PIC)
		Return: CF clear
	AX = 130Dh map EGA memory at A0000h
		???
		Return: CF clear
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution (see AX=130Ch) and runs inside a QEMM
			  critical section
			calls AX=1307h
	AX = 130Eh ??? (modifies CRT controller setup)
		???
		Return: CF clear
	AX = 130Fh reset ???
		Return: CF clear
	AX = 1310h ???
		???
		Return: CF clear
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution (see AX=130Ch) and runs inside a QEMM
			  critical section
			also calls AX=130Dh
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
	    or FFFFh to unmap (QEMM)
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
--------m-67FFA5BX4345-----------------------
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
--------I-68---------------------------------
INT 68 - Sangoma CCPOP 3270 resident module
SeeAlso: INT 67"Sangoma",INT 92"Sangoma"
--------N-6801--SF1B00-----------------------
INT 68 - APPC/PC - NETWORK DEVICE CONTROL - DISPLAY
	AH = 01h subfn 1B00h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=01h/SF=2000h,AH=01h/SF=2B00h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1B00h (verb "DISPLAY")
 0Eh  6 BYTEs	00h
 14h	DWORD	(big-endian) return code (see below)
 18h	WORD	00h
 1Ah  8 BYTEs	(big-endian) logical unit ID
 22h  8 BYTEs	(big-endian) partner logical unit name
 2Ah  8 BYTEs	(big-endian) mode name
 32h	BYTE	logical unit session limit
 33h	BYTE	partner logical unit session limit
 34h	BYTE	node maximum negotiable session limit
 35h	BYTE	current session limit
 36h	BYTE	minimum negotiated winner limit
 37h	BYTE	maximum negotiated loser limit
 38h	BYTE	active session count
 39h	BYTE	active CONWINNER session count
 3Ah	BYTE	active CONLOSER session count
 3Bh	BYTE	session termination count
 3Ch	BYTE	bit 7: SESSION_TERMINATION_TARGET_DRAIN
		bit 6: SESSION_TERMINATION_SOURCE_DRAIN

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
--------N-6801--SF2000-----------------------
INT 68 - APPC/PC - NETWORK DEVICE CONTROL - ATTACH PHYSICAL UNIT
	AH = 01h subfn 2000h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=01h/SF=2100h,AH=01h/SF=2B00h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2000h (verb "Attach Physical Unit")
 0Eh  6 BYTEs	00h
 14h	DWORD	(big-endian) return code (see AH=01h/SF=1B00h)
 18h	WORD	00h
 1Ah	BYTE	version
 1Bh	BYTE	release
 1Ch  8 BYTEs	(big-endian) net name
 24h  8 BYTEs	(big-endian) physical unit name
 2Ch  8 BYTEs	00h
 34h	DWORD	pointer to SYSTEM_LOG_EXIT routine, FFFFFFFFh=don't log errors
		(see also AH=01h/SF=2100h)
 38h	DWORD	00h
 3Ch	BYTE	00h RETURN_CONTROL: COMPLETE
		01h RETURN_CONTROL: INCOMPLETE
--------N-6801--SF2100-----------------------
INT 68 - APPC/PC - NETWORK DEVICE CONTROL - ATTACH LOGICAL UNIT
	AH = 01h subfn 2100h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=01h/SF=2000h,AH=01h/SF=2200h,AH=01h/SF=2B00h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2100h (verb "Attach Logical Unit")
 0Eh  6 BYTEs	00h
 14h	DWORD	(big-endian) return code (see AH=01h/SF=1B00h)
 18h	WORD	70  offset to partner logical unit record
 1Ah  8 BYTEs	(big-endian) logical unit name
 22h  8 BYTEs	(big-endian) logical unit ID
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
 48h	var	array of partner logical unit records (see below)

Format of partner logical unit record:
Offset	Size	Description
 00h	WORD	length of this partner logical unit record
 02h	WORD	42  offset to mode records
 04h  8 BYTEs	(big-endian) partner logical unit name
 0Ch	BYTE	partner logical unit security capabilities
		bit 7: already verified
		bit 6: conversation level security
		bit 5: session level security
 0Dh	BYTE	partner logical unit session limit
 0Eh	WORD	partner logical unit maximum MC_SEND_LL
 10h  8 BYTEs	(big-endian) partner logical unit DLC name
 18h	BYTE	partner logical unit adapter number
 19h 17 BYTEs	(counted string) partner logical unit adapter address
 2Ah	WORD	total length of mode records
 2Ch 16N BYTEs	array of mode records (see below)

Format of mode record:
Offset	Size	Description
 00h	WORD	16  length of this mode record
 02h  8 BYTEs	(big-endian) mode name
 0Ah	WORD	RU_SIZE high bound
 0Ch	WORD	RU_SIZE low bound
 0Eh	BYTE	mode maximum negotiable session limit
 0Fh	BYTE	pacing size for receive

Routines defined by LU_LU_PASSWORD_EXIT, CREATE_TP_EXIT, and SYSTEM_LOG_EXIT
pointers are called by pushing the DWORD pointer to the verb on the stack and
then performing a FAR call.

Format of ACCESS_LU_LU_PW verb:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1900h (verb "ACCESS_LU_LU_PW")
 0Eh  8 BYTEs	(big-endian) logical unit ID
 16h  8 BYTEs	(big-endian) logical unit name
 1Eh  8 BYTEs	(big-endian) partner logical unit name
 26h 17 BYTEs	(counted string) partner fully qualified logical unit name
 37h	BYTE	password available (0=no, 1=yes)
 38h  8 BYTEs	password

Format of CREATE_TP verb:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2300h (verb "CREATE_TP")
 0Eh  6 BYTEs	00h
 14h	DWORD	(big-endian) sense code (see below)
 18h  8 BYTEs	(big-endian) TP ID
 20h  8 BYTEs	(big-endian) logical unit ID
 28h	DWORD	(big-endian) conversation ID
 2Ch	BYTE	0 basic conversation, 1 mapped conversation
 2Dh	BYTE	0 no sync level, 1 confirm
 2Eh	BYTE	reserved
 2Fh 65 BYTEs	(counted string) transaction program name
 70h  6 BYTEs	00h
 76h	WORD	length of ERROR_LOG_DATA to return
 78h	DWORD	pointer to ERROR_LOG_DATA buffer
 7Ch  8 BYTEs	(big-endian) partner logical unit name
 84h 18 BYTEs	(counted string) partner fully qualified logical unit name
 96h  8 BYTEs	(big-endian) mode name
 9Eh 12 BYTEs	00h
 AAh 11 BYTEs	(counted string) password
 B5h 11 BYTEs	(counted string) user ID
 C0h	BYTE	0 verification should be performed
		1 already verified

Values for sense code:
 00000000h	Ok
 080F6051h	SECURITY_NOT_VALID
 084B6031h	TP_NOT_AVAIL_RETRY
 084C0000h	TP_NOT_AVAIL_NO_RETRY
 10086021h	TP_NAME_NOT_RECOGNIZED
 10086034h	CONVERSATION_TYPE_MISMATCH
 10086041h	SYNC_LEVEL_NOT_SUPPORTED

Format of SYSLOG verb:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2600h (verb "SYSLOG")
 0Eh 10 BYTEs	00h
 18h	WORD	(big-endian) type
 1Ah	DWORD	(big-endian) subtype
 1Eh	DWORD	pointer to ADDITIONAL_INFO
 22h	DWORD	(big-endian) conversation ID
 26h  8 BYTEs	(big-endian) TP ID
 2Eh  8 BYTEs	(big-endian) physical unit or logical unit name
 36h	WORD	length of data
 38h	DWORD	pointer to data
 3Ch	BYTE	00h
--------N-6801--SF2200-----------------------
INT 68 - APPC/PC - NETWORK DEVICE CONTROL - DETACH LOGICAL UNIT
	AH = 01h subfn 2200h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=01h/SF=2000h,AH=01h/SF=2100h,AH=01h/SF=2700h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2200h (verb "Detach Logical Unit")
 0Eh  6 BYTEs	00h
 14h	DWORD	(big-endian) return code (see AH=01h/SF=1B00h)
 18h  8 BYTEs	(big-endian) logical unit ID
 20h	BYTE	00h
--------N-6801--SF2700-----------------------
INT 68 - APPC/PC - NETWORK DEVICE CONTROL - DETACH PHYSICAL UNIT
	AH = 01h subfn 2700h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=01h/SF=2000h,AH=01h/SF=2100h,AH=01h/SF=2200h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2700h (verb "Detach Physical Unit")
 0Eh  6 BYTEs	00h
 14h	DWORD	(big-endian) return code (see AH=01h/SF=1B00h)
 18h	BYTE	00h  type: hard
		01h  type: soft
--------N-6801--SF2B00-----------------------
INT 68 - APPC/PC - NETWORK DEVICE CONTROL - ACTIVATE DLC
	AH = 01h subfn 2B00h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=01h/SF=1B00h,AH=01h/SF=2000h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2B00h (verb "Activate DLC")
 0Eh  6 BYTEs	00h
 14h	DWORD	(big-endian) return code (see AH=01h/SF=1B00h)
 18h  8 BYTEs	(big-endian) DLC name
 20h	BYTE	adapter number
--------N-6802--SF0100-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - ALLOCATE
	AH = 02h subfn 0100h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0500h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	0100h (verb "Allocate" or "MC_Allocate")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see below)
 16h	DWORD	(big-endian) error code (see below)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
 26h	BYTE	(MC_Allocate only) 0 basic conversation
				   1 mapped conversation
 27h	BYTE	SYNC_LEVEL (00h none, 01h confirm)
 28h	WORD	0000h
 2Ah	BYTE	00h RETURN_CONTROL: when session allocated
		01h RETURN_CONTROL: immediate
		02h RETURN_CONTROL: when session free
 2Bh  8 BYTEs	00h
 33h  8 BYTEs	(big-endian) partner logical unit name
 3Bh  8 BYTEs	(big-endian) mode name
 43h 65 BYTEs	(counted string) TP name
 84h	BYTE	security (00h none, 01h same, 02h pgm)
 85h 11 BYTEs	00h
 90h 11 BYTEs	(counted string) password
 9Bh 11 BYTEs	(counted string) user ID
 A6h	WORD	PIP_DATA length
 A8h	DWORD	pointer to PIP_DATA

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
 0001h	bad TP ID
 0002h	bad conversation ID
 0004h	allocation error, no retry
 0005h	allocation error, retry
 0006h	data area crosses segment boundary
 0010h	bad TPN length
 0011h	bad CONV length
 0012h	bad SYNC level
 0013h	bad security selection
 0014h	bad return control
 0015h	SEC_TOKENS too big
 0016h	PIP_LEN incorrect
 0017h	no use of SNASVCMG
 0018h	unknown partner mode
 0031h	confirm: SYNC_NONE
 0032h	confirm: bad state
 0033h	confirm: NOT_LL_BDY
 0041h	confirmed: bad state
 0051h	deallocate: bad type
 0052h	deallocate: flush bad state
 0053h	deallocate: confirm bad state
 0055h	deallocate: NOT_LL_BDY
 0057h	deallocate: log LL_WRONG
 0061h	flush: not send state
 0091h	post on receipt: invalid length
 0092h	post on receipt: not in receive state
 0093h	post on receipt: bad fill
 00A1h	prepare to receive:invalid type
 00A2h	prepare to receive: unfinished LL
 00A3h	prepare to receive: not in send state
 00B1h	receive and wait: bad state
 00B2h	receive and wait: NOT_LL_BDY
 00B5h	receive and wait: bad fill
 00C1h	receive immediate: not in receive state
 00C4h	receive immediate: bad fill
 00E1h	request to send: not in receive state
 00F1h	send data: bad LL
 00F2h	send data: not in send state
 0102h	send error: log LL wrong
 0103h	send error: bad type
 0121h	test: invalid type
 0122h	test: not in receive state
--------N-6802--SF0300-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - CONFIRM
	AH = 02h subfn 0300h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0400h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	0300h (verb "Confirm" or "MC_Confirm")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
 26h	BYTE	request to send received (0=no, 1=yes)
--------N-6802--SF0400-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - CONFIRMED
	AH = 02h subfn 0400h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0300h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	0400h (verb "Confirmed" or "MC_Confirmed")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
--------N-6802--SF0500-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - DEALLOCATE
	AH = 02h subfn 0500h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0100h,AH=02h/SF=0300h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	0500h (verb "Deallocate" or "MC_Deallocate")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
 26h	BYTE	00h
 27h	BYTE	type
		00h SYNC_LEVEL
		01h FLUSH
		02h ABEND_PROC
		03h ABEND_SVC
		04h ABEND_TIMER
		05h ABEND
 28h	WORD	(MC_Deallocate only) length of error log data
 2Ah	DWORD	(MC_Deallocate only) pointer to error log data
--------N-6802--SF0600-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - FLUSH
	AH = 02h subfn 0600h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0300h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	0600h (verb "Flush" or "MC_Flush")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
--------N-6802--SF0700-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - GET ATTRIBUTES
	AH = 02h subfn 0700h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0300h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	0700h (verb "Get_Attributes" or "MC_Get_Attributes")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
 26h  8 BYTEs	(big-endian) logical unit ID
 2Eh	BYTE	00h
 2Fh	BYTE	SYNC_LEVEL (0=none, 1=confirm)
 30h  8 BYTEs	(big-endian) mode name
 38h  8 BYTEs	(big-endian) own net name
 40h  8 BYTEs	(big-endian) own logical unit name
 48h  8 BYTEs	(big-endian) partner logical unit name
 50h 18 BYTEs	(counted string) partner's fully qualified logical unit name
 62h	BYTE	00h
 63h 11 BYTEs	(counted string) user ID
--------N-6802--SF0800-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - GET CONVERSATION TYPE
	AH = 02h subfn 0800h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0300h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	0800h (verb "Get_Type")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
 26h	BYTE	(return) type (0=basic conversation, 1=mapped conversation)
--------N-6802--SF0900-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - POST ON RECEIPT
	AH = 02h subfn 0900h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0A00h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	0900h (verb "Post_on_Receipt")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
 26h	WORD	maximum length
 28h	BYTE	fill (0=buffer, 1=LL)
--------N-6802--SF0A00-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - PREPARE TO RECEIVE
	AH = 02h subfn 0A00h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0900h,AH=02h/SF=0B00h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	0A00h (verb "Prepare_to_Receive" or "MC_Prepare_to_Receive")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
 26h	BYTE	type (0=SYNC_LEVEL, 1=FLUSH)
 27h	BYTE	locks (0=short, 1=long)
--------N-6802--SF0B00-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - RECEIVE AND WAIT
	AH = 02h subfn 0B00h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0C00h,AH=02h/SF=0F00h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	0B00h (verb "Receive_and_Wait" or "MC_Receive_and_Wait")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
 26h	BYTE	type of information received (see below)
 27h	BYTE	(MC_Receive_and_Wait only) fill (0=buffer, 1=LL)
 28h	BYTE	Request_to_Send_Received (0=no, 1=yes)
 29h	WORD	maximum length
 2Bh	WORD	data length
 2Dh	DWORD	pointer to data

Values for type of information received:
 00h	data
 01h	data complete
 02h	data incomplete
 03h	confirm
 04h	confirm send
 05h	confirm deallocate
 06h	send
--------N-6802--SF0C00-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - RECEIVE IMMEDIATE
	AH = 02h subfn 0C00h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0B00h,AH=02h/SF=0F00h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	0C00h (verb "Receive_Immediate" or "MC_Receive_Immediate")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
 26h	BYTE	type of information received (see AH=02h/SF=0B00h)
 27h	BYTE	(MC_Receive_Immediate only) fill (0=buffer, 1=LL)
 28h	BYTE	Request_to_Send_Received (0=no, 1=yes)
 29h	WORD	maximum length
 2Bh	WORD	data length
 2Dh	DWORD	pointer to data
--------N-6802--SF0E00-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - REQUEST TO SEND
	AH = 02h subfn 0E00h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0F00h,AH=02h/SF=1000h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	0E00h (verb "Request_to_Send" or "MC_Request_to_Send")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
--------N-6802--SF0F00-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - SEND DATA
	AH = 02h subfn 0F00h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0E00h,AH=02h/SF=1000h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	0F00h (verb "Send_Data" or "MC_Send_Data")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
 26h	BYTE	request to send received (0=no, 1=yes)
 27h	BYTE	00h
 28h	WORD	data length
 2Ah	DWORD	pointer to data
--------N-6802--SF1000-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - SEND ERROR
	AH = 02h subfn 1000h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=0F00h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1000h (verb "Send_Error" or "MC_Send_Error")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
 26h	BYTE	request to send received (0=no, 1=yes)
 27h	BYTE	type (0=program, 1=SVC)
 28h	DWORD	00h
 2Ch	WORD	(MC_Send_Error only) LOG_DATA length
 2Eh	DWORD	(MC_Send_Error only) pointer to LOG_DATA
--------N-6802--SF1200-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - TEST
	AH = 02h subfn 1200h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=1300h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1200h (verb "Test" or "MC_Test")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
 26h	BYTE	(MC_Test only) test (0=posted, 1=request_to_send received)
		Note: error code has different interpretations for:
			0 posted data
			1 posted not data (primary return code = 0)
			1 bad TP_ID (primary return code = 1)
--------N-6802--SF1300-----------------------
INT 68 - APPC/PC - CONNECTION CONTROL - WAIT
	AH = 02h subfn 1300h
	DS:DX -> control block
Return: control block updated
SeeAlso: AH=02h/SF=1200h

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1300h (verb "Wait")
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(big-endian) primary return code (see AH=02h/SF=0100h)
 16h	DWORD	(big-endian) error code (see AH=02h/SF=0100h)
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	(big-endian) conversation ID
 26h	BYTE	number of conversations to wait on
		Note: error codes have interpretations as for AH=02h/SF=1200h
--------N-6803--SF2400-----------------------
INT 68 - APPC/PC - TP STARTED
	AH = 03h subfn 2400h
	DS:DX -> control block (see below)
Return: control block updated

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2400h (verb "TP Started")
 0Eh  6 BYTEs	00h
 14h	DWORD	(big-endian) return code (see AH=01h/SF=1B00h)
 18h	WORD	00h
 1Ah  8 BYTEs	(big-endian) logical unit ID
 22h  8 BYTEs	(big-endian) TP ID
--------N-6803--SF2800-----------------------
INT 68 - APPC/PC - GET ALLOCATE
	AH = 03h subfn 2800h
	DS:DX -> control block (see below)
Return: control block updated

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2800h (verb "Get ALLOCATE")
 0Eh  6 BYTEs	00h
 14h	DWORD	(big-endian) return code (see AH=01h/SF=1B00h)
 18h	WORD	00h
 1Ah  8 BYTEs	(big-endian) logical unit ID
 22h	BYTE	type (00h dequeue, 01h test)
 23h	DWORD	pointer to CREATE_TP record
--------N-6803--SF2A00-----------------------
INT 68 - APPC/PC - CHANGE LOGICAL UNIT
	AH = 03h subfn 2A00h
	DS:DX -> control block (see below)
Return: control block updated

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2A00h (verb "Change Logical Unit")
 0Eh  6 BYTEs	00h
 14h	DWORD	(big-endian) return code (see AH=01h/SF=1B00h)
 18h	WORD	00h
 1Ah  8 BYTEs	(big-endian) logical unit ID
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
--------N-6804-------------------------------
INT 68 - APPC/PC - TRANSACTION PROCESSING
	AH = 04h
	DS:DX -> control block (see below)
Return: control block updated

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	verb (action)
		2500h TP_ENDED
		2900h TP_VALID
 0Eh  6 BYTEs	00h
 14h	DWORD	(big-endian) return code (see AH=01h/SF=1B00h)
 18h	WORD	00h
 1Ah  8 BYTEs	(big-endian) TP_ID
 22h	DWORD	-> CREATE_TP record (only if verb = 2900h)
--------N-6805-------------------------------
INT 68 - APPC/PC - TRANSFER MESSAGE DATA
	AH = 05h
	DS:DX -> control block (see below)
Return: control block updated

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1C00h (verb "Transfer Message Data")
 0Eh	BYTE	00h user defined
		01h NMVT
		02h alert subvectors
		03h PDSTATS subvectors
 0Fh  5 BYTEs	00h
 14h	DWORD	(big-endian) return code (see AH=01h/SF=1B00h)
 18h 12 BYTEs	00h
 24h	BYTE	if bit 0 clear, add correlation subvector
		if bit 1 clear, add product set ID subvector
		if bit 2 clear, do SYSLOG
		if bit 3 clear, send SSCP_PU_SESSION
 25h	BYTE	00h
 26h	WORD	length of data
 28h  N BYTEs	data
--------N-6806-------------------------------
INT 68 - APPC/PC - CHANGE NUMBER OF SESSIONS
	AH = 06h
	DS:DX -> control block (see below)
Return: control block updated

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1500h (verb "Change Number of Sessions")
 0Eh  6 BYTEs	00h
 14h	WORD	(big-endian) primary return code (see AH=02h)
 16h	DWORD	(big-endian) secondary return code (see below, AH=01h/SF=1B00h)
 1Ah  8 BYTEs	(big-endian) logical unit ID
 22h  8 BYTEs	blanks
 2Ah  8 BYTEs	(big-endian) partner logical unit name
 32h  8 BYTEs	(big-endian) mode name
 3Ah	BYTE	bit 7: use MODE_NAME_SELECT_ALL rather than MODE_NAME
		bit 6: set negotiable values
 3Bh	BYTE	partner logical unit mode session limit
 3Ch	BYTE	minimum CONWINNERS_SOURCE
 3Dh	BYTE	maximum CONWINNERS_TARGET
 3Eh	BYTE	automatic activation
 3Fh	BYTE	00h
 40h	BYTE	bit 7: drain target
		bit 6: drain source
		bit 5: target responsible, not source

Values for secondary return code (see also AH=01h/SF=1B00h):
 0000h	accepted
 0001h	negotiated
 0003h	bad logical unit ID
 0004h	allocation failure, no retry
 0005h	allocation failure, retry
 0151h	can't raise limits
 0153h	all modes must reset
 0154h	bad SNASVCMG limits
 0155h	minimum greater than total
 0156h	mode closed (primary return code = 1)
	CNOS mode closed (primary return code = 18h)
 0157h	bad mode name (primary return code = 1)
	CNOS bad mode name (primary return code = 18h)
 0159h	reset SNA drains
 015Ah	single not SRC response
 015Bh	bad partner logical unit
 015Ch	exceeds maximum allowed
 015Dh	change SRC drains
 015Eh	logical unit detached
 015Fh	CNOS command race reject
--------N-6807-------------------------------
INT 68 - APPC/PC - PASSTHROUGH
	AH = 07h
	DS:DX -> control block (format depends on application subsystem)
Return: control block updated
SeeAlso: AH=FFh
--------N-68FA-------------------------------
INT 68 - APPC/PC - ENABLE/DISABLE APPC
	AH = FAh
	AL bit 0 = 0 enable
		   1 disable
SeeAlso: AH=FDh
--------N-68FB-------------------------------
INT 68 - APPC/PC - CONVERT
	AH = FBh
	DS:DX -> control block (see below)
Return: control block updated

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1A00h (verb "CONVERT")
 0Eh  6 BYTEs	00h
 14h	DWORD	(big-endian) return code
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
--------N-68FC-------------------------------
INT 68 - APPC/PC - ENABLE/DISABLE MESSAGE TRACING
	AH = FCh
	AL = 00h disable tracing
	   = 01h enable tracing
		DX = number of bytes to keep (0=all)
SeeAlso: AH=FDh,AH=FEh
--------N-68FD-------------------------------
INT 68 - APPC/PC - ENABLE/DISABLE API VERB TRACING
	AH = FDh
	AL = 00h disable tracing
	     01h enable tracing
SeeAlso: AH=FAh,AH=FCh,AH=FEh
--------N-68FE-------------------------------
INT 68 - APPC/PC - SET TRACE DESTINATION
	AH = FEh
	AL = trace destinations (see below)
	DS:DX -> trace stats record if AL bit 0 set
SeeAlso: AH=FCh,AH=FDh

Bitfields for trace destinations:
 bit 0	storage (DS:DX -> trace stats record)
 bit 1	display
 bit 2	file (trace written to file OUTPUT.PC)
 bit 3	printer

Format of Trace Statistics Record:
Offset	Size	Description
 00h	DWORD	pointer to storage trace buffer
 04h	WORD	max number of 80-byte records in trace
 06h	WORD	(high-order byte first!) current record number (must init to 0)
 08h	DWORD	(high-order byte first!) number of records written (init to 0)
 0Ch	DWORD	reserved
Note:	do not move record while trace is active
--------N-68FF-------------------------------
INT 68 - APPC/PC - SET PASSTHROUGH
	AH = FFh
	DS:DX -> passthrough exit routine
SeeAlso: AH=07h
--------!------------------------------------
