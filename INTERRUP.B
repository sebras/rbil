Interrupt List, part 2 of 10
This compilation is Copyright (c) 1989,1990,1991,1992,1993,1994 Ralf Brown
--------S-1410-------------------------------
INT 14 - FOSSIL - EXTENDED ^C/^K CHECKING AND TRANSMIT ON/OFF
	AH = 10h
	AL = bit mask
	    bit 0: enable/disable ^C/^K checking
	    bit 1: enable/disable the transmitter
	DX = port number
SeeAlso: AH=0Fh"FOSSIL"
--------S-1410-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - CLEAR RECEIVE BUFFER
	AH = 10h
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    FFh error
SeeAlso: AH=09h"Digiboard",AH=11h"Digiboard"
--------S-1410-------------------------------
INT 14 - MBBIOS PACCOM support - SET CRC WAIT
	AH = 10h
	AL = new setting in clock ticks (should be at least 5 character times)
Desc:	specify the time from start of last character to dropping RTS
SeeAlso: AH=0Dh"MBBIOS",AH=0Fh"MBBIOS"
--------N-1410--DXFFFF-----------------------
INT 14 - Connection Manager - QUERY SERVICE NAMES
	AH = 10h
	DX = FFFFh
	CL = subfunction
	    00h search first
	    01h search next
	ES:DI -> pattern buffer (see below)
Return: AH = return code (00h,01h,03h,06h) (see also AH=00h/DX=FFFFh)
	    01h no (more) matching names
	    03h invalid request
	ES:DI buffer filled with reply buffer (see below) containing matched
		  name if AH=00h
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
Desc:	obtain the names of groups and lines available for connection requests,
	  and the names of active Connection Servers
SeeAlso: AH=04h/DX=FFFFh,AH=0Bh/DX=FFFFh

Format of pattern/reply buffer:
Offset	Size	Description
 00h	WORD	length of pattern (30h or 32h)
 02h 16 BYTEs	server pattern or name
 12h 16 BYTEs	group pattern or name
 22h 16 BYTEs	line pattern or name
 23h	BYTE	(optional) ???
 24h	BYTE	(optional, returned) current line status
		00h available
		01h out of service
		02h currently allocated to a connection
Note:	pattern may include '?' wildcard to match any character
--------S-1411-------------------------------
INT 14 - FOSSIL - SET CURRENT CURSOR LOCATION
	AH = 11h
	DH = row
	DL = column
Note:	this is the same as INT 10/AH=02h
SeeAlso: AH=12h"FOSSIL"
--------S-1411-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - CLEAR TRANSMIT BUFFER
	AH = 11h
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    FFh error
SeeAlso: AH=09h"Digiboard",AH=10h"Digiboard"
--------S-1411-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - DISABLE PORT
	AH = 11h
	DX = port number
Return: AL = status
	    00h successful
	    01h IRQ for port is shared
	    02h IRQ was reserved
SeeAlso: AH=04h,AH=05h,AH=12h"PC-MOS"
--------S-1412-------------------------------
INT 14 - FOSSIL - READ CURRENT CURSOR LOCATION
	AH = 12h
Return: DH = row
	DL = column
Note:	this is the same as INT 10/AH=03h
SeeAlso: AH=11h"FOSSIL"
--------S-1412-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - GET TRANSMIT BUFFER FREE SPACE
	AH = 12h
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AX = number of bytes free
SeeAlso: AH=0Ah"Digiboard",AH=14h"Digiboard"
--------S-1412-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - GET CURRENT PORT PARAMETERS
	AH = 12h
	DX = port number
Return: AH = status
	    FFh port number invalid
	AL = line parameters (see AH=00h)
	AH = flow control configuration (see AH=05h"PC-MOS")
	CX:BX = bps rate
	DL = XOFF character or 00h for none
	DH = XON character or 00h for none
--------S-1413-------------------------------
INT 14 - FOSSIL - SINGLE CHARACTER ANSI WRITE TO SCREEN
	AH = 13h
	AL = character
Note:	should not be called if it is unsafe to call DOS
SeeAlso: AH=15h
--------S-1413-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - REGISTER A PORT WITH A TERMINAL
	AH = 13h
	DX = port number
Return: AH = status
	    FFh port number invalid
	    else
		ES:BX -> BYTE flag (00h buffer empty, FFh buffer contains data)
SeeAlso: AH=17h"PC-MOS"
--------S-1414-------------------------------
INT 14 - FOSSIL - ENABLE OR DISABLE WATCHDOG PROCESSING
	AH = 14h
	AL = 01h enable watchdog
	     00h disable watchdog
	DX = port number
--------S-1414-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - OUTPUT STRING
	AH = 14h
	CX = number of characters in string
	DX = port number
	ES:BX -> string to be sent
	SI = timeout in timer ticks or 0000h for default
Return: AX = number of bytes actually sent
	ZF clear if successful
	ZF set on timeout
SeeAlso: AH=01h,AH=15h"PC-MOS"
--------S-1414-------------------------------
INT 14 - Digiboard - GET NUMBER OF BOARDS INSTALLED
	AH = 14h
Return: AX = number of boards installed
SeeAlso: AH=08h"Digiboard",AH=15h"Digiboard"
--------S-1415-------------------------------
INT 14 - FOSSIL - WRITE CHARACTER TO SCREEN USING BIOS SUPPORT ROUTINES
	AH = 15h
	AL = character
SeeAlso: AH=13h"FOSSIL"
--------S-1415-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - INPUT STRING
	AH = 15h
	CX = size of buffer
	DX = port number
	ES:BX -> buffer for received characters
	SI = timeout in clock ticks or 0000h for default
Return: AX = number of characters actually read
	ZF set on timeout (no data available)
SeeAlso: AH=02h,AH=14h"PC-MOS",AH=16h"PC-MOS"
--------S-1415-------------------------------
INT 14 - Digiboard - ENABLE/DISABLE MEMORY
	AH = 15h
	AL = new state (00h disabled, 01h enabled)
Return: AH = status
	    00h successful
	    80h error
	    FFh error
SeeAlso: AH=14h"Digiboard",AH=16h"Digiboard"
--------S-1416-------------------------------
INT 14 - FOSSIL - INSERT/DELETE FUNCTION FROM TIMER TICK CHAIN
	AH = 16h
	AL = function
	    00h = delete
	    01h = add
	ES:DX -> routine to call
Return: AX = status
	    0000h successful
	    0001h unsuccessful
SeeAlso: AH=07h"FOSSIL"
--------S-1416-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - LINK TO ANOTHER SERIAL DRIVER
	AH = 16h
	ES:BX -> calling driver's INT 14 entry point
Return: nothing
Program: PC-MOS/386 v5.01 is a multitasking, multiuser MS-DOS 5.0-compatible
	  operating system by The Software Link, Inc.
--------S-1416-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - CCB COMMAND
	AH = 16h
	AL = CCB command number (see below) (see also following entries)
	BL = byte 2
	BH = byte 3
	CL = byte 1 (for all channel functions except 4Eh and 4Fh)
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    80h error
	    FFh error
SeeAlso: AX=1646h,AH=18h"Digiboard"

Values for CCB command number:
 40h	Set Receive Mid Water Mark
 41h	Set Receive High Water Mark
 42h	Flush Receive Buffer
 43h	Flush Transmit Buffer
 44h	Transmit Pause
 45h	Transmit Resume
 46h	Set Interrupt to Host Mask
 47h	Set Baud, Data, Stop and Parity
 48h	Send Break
 49h	Set Modem Lines
 4Ah	Set Break Count
 4Bh	Set Handshake
 4Ch	Set Xon/Xoff Characters
 4Dh	Set Transmit Mid Water Mark
 4Eh	IRQ Polling Timer to Host
 4Fh	Buffer Set All
 50h	Port On
 51h	Port Off
 52h	Receive Pause
 53h	Special Character Interrupt
 54h	RS-422 Enable
--------S-141646-----------------------------
INT 14 - Digiboard - CCB COMMAND - SET INTERRUPT TO HOST MASK
	AX = 1646h
	BL = bits to set
	BH = bits to clear
	CL = byte 1
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    80h error
	    FFh error
SeeAlso: AH=16h"Digiboard",AX=1647h
--------S-141647-----------------------------
INT 14 - Digiboard - CCB COMMAND - SET BAUD/DATABITS/STOPBITS/PARITY
	AX = 1647h
	BL = baud
	BH = datatype
	CL = byte 1
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    80h error
	    FFh error
SeeAlso: AH=16h"Digiboard",AX=1646h,AX=1649h
--------S-141649-----------------------------
INT 14 - Digiboard - CCB COMMAND - SET MODEM LINES
	AX = 1649h
	BL = bits to set
	BH = bits to clear
	CL = byte 1
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    80h error
	    FFh error
SeeAlso: AH=16h"Digiboard",AX=1647h
--------S-14164A-----------------------------
INT 14 - Digiboard - CCB COMMAND - SET BREAK COUNT
	AX = 164Ah
	BL = break count
	CL = byte 1
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    80h error
	    FFh error
SeeAlso: AH=16h"Digiboard",AX=1649h,AX=164Bh
--------S-14164B-----------------------------
INT 14 - Digiboard - CCB COMMAND - SET HANDSHAKE
	AX = 164Bh
	BL = bits to set
	BH = bits to clear
	CL = byte 1
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    80h error
	    FFh error
SeeAlso: AH=16h"Digiboard",AX=1649h,AX=164Ch
--------S-14164C-----------------------------
INT 14 - Digiboard - CCB COMMAND - SET XON/XOFF CHARACTERS
	AX = 164Ch
	BL = XON character
	BH = XOFF character
	CL = byte 1
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    80h error
	    FFh error
SeeAlso: AH=16h"Digiboard",AX=164Bh,AX=164Dh
--------S-14164D-----------------------------
INT 14 - Digiboard - CCB COMMAND - SET TRANSMIT MID-WATER MARK
	AX = 164Dh
	BX = new mid-water mark
	CL = byte 1
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    80h error
	    FFh error
SeeAlso: AH=16h"Digiboard",AX=164Ch,AX=164Eh,AX=164Fh
--------S-14164E-----------------------------
INT 14 - Digiboard - CCB COMMAND - IRQ POLLING TIMER TO HOST
	AX = 164Eh
	BL = ticks
	BH = ???
	CL = mode
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    80h error
	    FFh error
SeeAlso: AH=16h"Digiboard",AX=164Dh
--------S-14164F-----------------------------
INT 14 - Digiboard - CCB COMMAND - BUFFER SET ALL
	AX = 164Fh
	BL = size
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    80h error
	    FFh error
SeeAlso: AH=16h"Digiboard",AX=164Dh
--------S-141653-----------------------------
INT 14 - Digiboard - CCB COMMAND - SPECIAL CHARACTER INTERRUPT
	AX = 1653h
	BL = enable/disable
	BH = special character
	CL = byte 1
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    80h error
	    FFh error
SeeAlso: AH=16h"Digiboard",AX=1646h
--------S-1417-------------------------------
INT 14 - FOSSIL - REBOOT SYSTEM
	AH = 17h
	AL = method
	    00h = cold boot
	    01h = warm boot
SeeAlso: INT 19
--------S-1417-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - WRITE MODEM CONTROL REGISTER
	AH = 17h
	AL = new value for UART's modem control register
	DX = port number
Return: nothing
--------S-1418-------------------------------
INT 14 - FOSSIL - READ BLOCK
	AH = 18h
	CX = maximum number of characters to transfer
	DX = port number
	ES:DI -> user buffer
Return: AX = number of characters transferred
SeeAlso: AH=19h"FOSSIL",AH=83h"COURIERS",AX=FF02h,INT 6B/AX=0100h
--------S-1418-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - SEND BIOS COMMAND
	AH = 18h
	ES:BX -> 16-byte command string
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    80h timeout
	AL = mailbox status
	    00h no errors
	    8Xh BIOS error
	ES:BX buffer filled in with mailbox string
	ZF clear if no errors
	ZF set if either status byte contains an error code
SeeAlso: AH=16h"Digiboard"
--------S-1418-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - GET DRIVER DESCRIPTION
	AH = 18h
	DX = port number
Return: DS:BX -> 40-byte buffer containing a string identifying the serial
		driver
SeeAlso: AH=06h"PC-MOS"
--------S-1419-------------------------------
INT 14 - FOSSIL - WRITE BLOCK
	AH = 19h
	CX = maximum number of characters to transfer
	DX = port number
	ES:DI -> user buffer
Return: AX = number of characters transferred
SeeAlso: AH=18h"FOSSIL",AH=86h,INT 6B/AX=0000h
--------S-1419-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - SPECIAL CHARACTER INTERRUPT
	AH = 19h
	BL = flag
	    00h disable special character interrupt
	    FFh enable interrupt
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    FFh failed
SeeAlso: AH=1Ah"Digiboard"
--------S-1419-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - SELECTIVE BUFFER FLUSH
	AH = 19h
	AL = what to flush
		bit 0: input buffer
		bit 1: output buffer
	DX = port number
Return: nothing
SeeAlso: AH=09h"PC-MOS"
--------S-141A-------------------------------
INT 14 - FOSSIL - BREAK BEGIN OR END
	AH = 1Ah
	AL = 00h stop sending 'break'
	     01h start sending 'break'
	DX = port number
SeeAlso: AH=06h"FOSSIL",AH=8Ah,AH=FAh
--------S-141A-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X - SPECIAL CHARACTER FLAG/COUNTER
	AH = 1Ah
	BX = subfunction
	    00h return pointer to special character flag byte
	    01h return pointer to special character counter word
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: ES:BX -> special character flag or counter
Notes:	flag is FFh if one or more special characters are in the receive
	  buffer; it is 00h and the counter is invalid if no special characters
	  are in the receive buffer
	counter (if valid) contains the number of characters in the receive
	  buffer up to and including the last-received special character
--------S-141B-------------------------------
INT 14 - FOSSIL - RETURN INFORMATION ABOUT THE DRIVER
	AH = 1Bh
	DX = port number
	CX = size of user buffer
	ES:DI -> user buffer for driver info (see below)
Return: AX = number of characters transferred
	CX = 3058h ("0X") (X00 FOSSIL only)
	DX = 2030h (" 0") (X00 FOSSIL only)

Format of driver info:
Offset	Size	Description
 00h	WORD	size of structure in bytes
 02h	BYTE	FOSSIL spec driver conforms to
 03h	BYTE	revision level of this specific driver
 04h	DWORD	pointer to ASCIZ identification string
 08h	WORD	size of the input buffer
 0Ah	WORD	number of bytes left in buffer
 0Ch	WORD	size of the output buffer
 0Eh	WORD	number of bytes left in buffer
 10h	BYTE	width of screen
 11h	BYTE	length of screen
 12h	BYTE	actual baud rate, computer to modem
--------S-141C-------------------------------
INT 14 - X00 FOSSIL - ACTIVATE PORT
	AH = 1Ch
	DX = port number
Return: AX = 1954h if successful
	BL = maximum function number supported (not including 7Eh and above)
	BH = revision of FOSSIL specification supported
Note:	this is a duplicate of AH=04h, so that AH=04h may be made compatible
	  with the PS/2 BIOS in a future release
SeeAlso: AH=04h"FOSSIL",AH=1Dh
--------S-141D-------------------------------
INT 14 - X00 FOSSIL - DEACTIVATE PORT
	AH = 1Dh
	DX = port number
Return: none
Notes:	this is a duplicate of AH=05h, so that AH=05h may be made compatible
	  with the PS/2 BIOS in a future release
	ignored if the port was never activated with AH=04h or AH=1Ch
SeeAlso: AH=05h"FOSSIL",AH=1Ch
--------S-141E-------------------------------
INT 14 - X00 FOSSIL - EXTENDED LINE CONTROL INITIALIZATION
	AH = 1Eh
	AL = break status
	    00h if break
	    01h if no break
	BH = parity (see below)
	BL = number of stop bits
	    00h one stop bit
	    01h two stop bits (1.5 if 5 bit word length)
	CH = word length (see below)
	CL = bps rate (see below)
	DX = port number
Return: AX = port status code (see AH=00h)
Notes:	this function is intended to exactly emulate the PS/2 BIOS AH=04h call
	if the port was locked at X00 load time, the appropriate parameters are
	  ignored
SeeAlso: AH=00h,AH=04h"SERIAL I/O"

Values for parity:
 00h	no parity
 01h	odd parity
 02h	even parity
 03h	stick parity odd
 04h	stick parity even

Values for word length:
 00h	5 bits
 01h	6 bits
 02h	7 bits
 03h	8 bits

Values for bps rate:
 00h	110
 01h	150
 02h	300
 03h	600
 04h	1200
 05h	2400
 06h	4800
 07h	9600
 08h	19200
--------S-101E------------------------------------
INT 10 - HUNTER 16 - READ COMMS PARAMETERS
	AH = 1Eh
	CX = channel number (00h COM1, 01h COM2, ...)
	DS:BX -> buffer for communications parameters (see below)
Return: DS:BX buffer filled
Note:	the Husky Hunter 16 is an 8088-based ruggedized laptop.	 Other family
	  members are the Husky Hunter, Husky Hunter 16/80, and Husky Hawk.
SeeAlso: AH=20h"HUNTER"

Format of communications parameters:
Offset	Size	Description
 00h	BYTE	communications type (00h IBM, nonzero Husky)
 01h	BYTE	port number (00h COM1, 01h COM2)
 02h	BYTE	baud rate (00h 110 bps, 01h 150, 02h 300, 03h 600, 04h 1200,
		05h 2400, 06h 4800, 07h 9600, 08h 19200, 09h 38400)
 03h	BYTE	data bits (01h seven, 02h eight)
 04h	BYTE	parity (00h none, 01h odd, 02h even)
 05h	BYTE	stop bits (00h one, 01h two)
 06h	BYTE	handshake
		bits 0-1  0: RTS off, 1: RTS hold, 2: RTS true
		bit    2  DTR enabled
		bit    4  CTS enabled
		bit    5  DSR enabled
		bit    6  DCD enabled
 07h	BYTE	handshake protocol (00h none, 01h Xon/Xoff, 02h HWK3780)
 08h	BYTE	Nulls after CR (0-20)
 09h	BYTE	LF (00h off, 01h on)
 0Ah	BYTE	Serig. 0..7Fh: Ignore this character
		       80h: Serig off
 0Bh	BYTE	echo (00h off, 01h on)
 0Ch	BYTE	transmit timeout in seconds (1-60) or 00h to disable
 0Dh	BYTE	receive timeout in seconds (1-60) or 00h to disable
 0Eh  5 BYTEs	reserved
--------S-141F-------------------------------
INT 14 - X00 FOSSIL - EXTENDED SERIAL PORT STATUS/CONTROL
	AH = 1Fh
	AL = 00h read modem control register
	      Return: BL = modem control register (see below)
		      AH = status
	AL = 01h write modem control register
	      BL = modem control register (see below)
	      Return: AX = status
	DX = port number
Notes:	this function is intended to exactly emulate the PS/2 BIOS AH=05h call
	X00 forces BL bit 3 set (interrupts cannot be disabled)
SeeAlso: AH=00h,AH=05h"SERIAL I/O"

Bitfields for modem control register:
 bit 0	data terminal ready
 bit 1	request to send
 bit 2	OUT1
 bit 3	OUT2 (interrupts) enabled
 bit 4	LOOP
 bits 5-7 reserved
--------S-1420-------------------------------
INT 14 - X00 FOSSIL - DESTRUCTIVE READ WITH NO WAIT
	AH = 20h
	DX = port number
Return: AH = 00h if character was available
	    AL = next character (removed from receive buffer)
	AX = FFFFh if no character available
SeeAlso: AH=0Ch,AH=21h"X00"
--------S-1420-------------------------------
INT 14 - Alloy MW386 - ATTACH LOGICAL COMMUNICATIONS PORT TO PHYSICAL PORT
	AH = 20h
	AL = logical port (01h COM1, 02h COM2)
	DX = physical port number
Return: AX = status
	    0000h successful
	    FFFFh failed
SeeAlso: AH=21h"Alloy",AH=22h"Alloy",AH=23h"Alloy",INT 17/AH=8Bh"Alloy"
--------S-1420-------------------------------
INT 14 - MultiDOS Plus - INITIALIZE PORT
	AH = 20h
	AL = port parameters (see AH=00h"SERIAL")
	DX = port number (0-3)
Return: AH = status
	    00h successful
	    41h no such port
	    64h monitor mode already active
SeeAlso: AH=00h"SERIAL",AH=04h"MultiDOS",AH=21h"MultiDOS",AH=23h"MultiDOS"
--------S-1420-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - CHECK OUTPUT QUEUE
	AH = 20h
	DX = port number
Return: AX = number of bytes in output buffer
SeeAlso: AH=0Ah"PC-MOS"
--------S-1020------------------------------------
INT 10 - HUNTER 16 - SELECT COMMS PARAMETERS
	AH = 20h
	CX = channel number (00h COM1, 01h COM2, ...)
	DS:BX -> buffer with communications parameter (see AH=1Eh"HUNTER")
Return: AX = status
	    0000h successful
	    0001h invalid parameter
SeeAlso: AH=1Eh"HUNTER",AH=21h"HUNTER"
--------S-1421-------------------------------
INT 14 - X00 FOSSIL - STUFF RECEIVE BUFFER
	AH = 21h
	AL = character
	DX = port number
Notes:	the given character is inserted at the end of the receive buffer as if
	  it had just arrived from the serial port; all normal receive
	  processing (XON/XOFF, ^C/^K) is performed on the character
	fully re-entrant
SeeAlso: AH=20h"X00"
--------S-1421-------------------------------
INT 14 - Alloy MW386 v1.x only - RELEASE PHYSICAL COMMUNICATIONS PORT
	AH = 21h
	DX = physical port number
Return: AX = status
	    0000h successful
	    FFFFh failed
SeeAlso: AH=20h"Alloy",AH=22h"Alloy"
--------S-1421-------------------------------
INT 14 - MultiDOS Plus - TRANSMIT CHARACTER
	AH = 21h
	AL = character to send
	DX = port number
Return: AH = status (see below)
Note:	monitor mode must have been turned on with AH=24h before calling
SeeAlso: AH=20h"MultiDOS",AH=22h"MultiDOS",AH=24h"MultiDOS"

Values for status:
 00h	successful
 39h	no DSR or CTS
 3Ch	no DSR
 3Bh	no CTS
 41h	no such port
 42h	monitor mode not active
 97h	timed out
--------S-1421-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - OUTPUT CHARACTER, WITH TIMEOUT
	AH = 21h
	AL = char to send
	DX = port number
	SI = timeout in timer ticks (0000h = default)
Program: PC-MOS/386 v5.01 is a multitasking, multiuser MS-DOS 5.0-compatible
	  operating system by The Software Link, Inc.
SeeAlso: AH=01h,AH=0Eh"PC/MOS",AH=22h"PC-MOS"
--------S-1021------------------------------------
INT 10 - HUNTER 16 - EXTENDED CONTROL
	AH = 21h
	AL = command
	    01h force transmission of buffer
	    02h clear transmit buffer
	    03h clear receive buffer
	DX = port (00h COM1, 01h COM2)
Return: AH = extended status
Desc:	executes the command on the selected port
SeeAlso: AH=1Eh"HUNTER",AH=20h"HUNTER",AH=22h"HUNTER",AH=24h"HUNTER"
--------S-1422-------------------------------
INT 14 - Alloy MW386 v2+ - RELEASE LOGICAL COMMUNICATIONS PORT
	AH = 22h
	AL = logical port (01h COM1, 02h COM2)
Return: AX = status (0000h successful)
SeeAlso: AH=20h"Alloy",AH=21h"Alloy"
--------S-1422-------------------------------
INT 14 - MultiDOS Plus - RECEIVE CHARACTER
	AH = 22h
	DX = port number
Return: AH = status (see also AH=21h"MultiDOS")
	    00h successful
		AL = character
	    3Dh framing and parity error
	    3Eh overrun error
	    3Fh framing error
	    40h parity error
	    96h ring buffer overflow
Note:	if no character is available, this function waits until a character
	  arrives or an implementation-dependent timeout elapses
SeeAlso: AH=20h"MultiDOS",AH=21h"MultiDOS",AH=27h
--------S-1422-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - RECEIVE CHARACTER, WITH TIMEOUT
	AH = 22h
	DX = port number
	SI = timeout in timer ticks (0000h = default)
Return: AH = port status (see AH=03h bits 0..6)
	     bit 7 = 1 indicates time-out
	AL = character received
Program: PC-MOS/386 v5.01 is a multitasking, multiuser MS-DOS 5.0-compatible
	  operating system by The Software Link, Inc.
SeeAlso: AH=02h,AH=0Fh"PC-MOS",AH=21h"PC-MOS"
--------S-1022------------------------------------
INT 10 - HUNTER 16 - EXTENDED STATUS
	AH = 22h
	DX = port (00h COM1, 01h COM2)
Return: AH = extended status
	BX = number of characters in input buffer
	CX = number of characters in output buffer
Desc:	returns the most recent Extended Status code for the port
SeeAlso: AH=21h"HUNTER"
--------S-1423-------------------------------
INT 14 - Alloy MW386 v2+ - GET PORT NUMBER FROM LOGICAL PORT ID
	AH = 23h
	AL = logical port (01h COM1, 02h COM2)
	DH = user ID
	DL = process ID (DH,DL both FFh for current task)
Return: AL = MW386 port mode (see below)
	CX = MW386 port number
	DH = owner's user ID
	DL = owner's task ID
SeeAlso: AH=20h"Alloy",INT 17/AH=8Bh"Alloy"

Bitfields for MW386 port mode:
 bit 0	port is shared (spooler only)
 bit 1	port is spooled instead of direct (spooler only)
 bit 2	port is assigned as logical COM device, not in spooler
 bit 3	port is free
--------S-1423-------------------------------
INT 14 - MultiDOS Plus - GET PORT STATUS
	AH = 23h
	DX = port number
Return: AH = line status (see AH=03h)
	AL = modem status (see AH=03h)
SeeAlso: AH=03h,AH=07h"MultiDOS",AH=20h"MultiDOS"
--------S-1423-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - DECLARE PORT OWNERSHIP
	AH = 23h
	DX = port number
	BX = TCB segment/selector address of owner task
Return: nothing
SeeAlso: AH=0Dh"PC-MOS"
--------S-1023------------------------------------
INT 10 - HUNTER 16 - CONTROL HANDSHAKE LINES
	AH = 23h
	BH = handshake line to set (00h RTS, 01h DTR)
	BL = new level (00h low, 01h high)
Desc:	sets the handshake lines of COM1 to the desired level
SeeAlso: AH=21h"HUNTER",AH=24h"HUNTER"
--------S-1424-------------------------------
INT 14 - Alloy MW386 v2+ - CHANGE PHYSICAL PORT PARAMETERS
	AH = 24h
	CX = physical I/O port number
	DS:DX -> configuration table (see below)
Return: AH = 00h
Note:	invalid port numbers are merely ignored
SeeAlso: INT 17/AH=96h

Format of configuration table:
Offset	Size	Description
 00h	BYTE	baud rate (see below)
 01h	BYTE	data bits (00h=5, 01h=6, 02h=7, 03h=8)
 02h	BYTE	parity (00h none, 01h odd, 02h even)
 03h	BYTE	stop bits (00h=1, 01h=2)
 04h	BYTE	receive flow control
		00h none, 01h XON/XOFF, 02h DTR/DSR, 03h XPC, 04h RTS/CTS
 05h	BYTE	transmit flow control (as for receive)

Values for baud rate:
 00h	38400
 01h	19200
 02h	9600
 03h	7200
 04h	4800
 05h	3600
 06h	2400
 07h	2000
 08h	1200
 09h	600
 0Ah	300
 0Bh	150
 0Ch	134.5
--------S-1424-------------------------------
INT 14 - MultiDOS Plus - SET MONITOR MODE
	AH = 24h
	AL = port status storage
	    00h single status for entire receive buffer
	    01h separate status kept for each byte in receive buffer
	DX = port number
Return: AH = status
	    00h successful
	    3Ah invalid status storage specified
	    41h no such port
	    64h monitor mode already active
Note:	in monitor mode, MultiDOS redirects all BIOS video output to a serial
	  port
SeeAlso: AH=20h"MultiDOS",AH=25h
--------S-1424-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - ???
	AH = 24h
Return: ???
Program: PC-MOS/386 v5.01 is a multitasking, multiuser MS-DOS 5.0-compatible
	  operating system by The Software Link, Inc.
--------S-1024------------------------------------
INT 10 - HUNTER 16 - CONTROL CTS HANDSHAKING
	AH = 24h
	AL = new CTS handshake state for COM1 (00h disabled, 01h enabled)
SeeAlso: AH=23h"HUNTER",AH=25h"HUNTER",AH=26h"HUNTER"
--------S-1425-------------------------------
INT 14 - MultiDOS Plus - CLEAR BUFFERS
	AH = 25h
	AL = function
	    00h only clear buffers
	    01h clear buffers and deactivate
	DX = port number
Return: AH = status
	    00h successful
	    3Ah invalid function
	    41h no such port
	    42h monitor mode not active
SeeAlso: AH=20h"MultiDOS",AH=24h"MultiDOS"
--------S-1025------------------------------------
INT 10 - HUNTER 16 - CONTROL RS232 DRIVERS
	AH = 25h
	AL = new state of RS232 drivers (00h off, 01h on)
Note:	this function can be used to save power by turning off the RS232 
	  drivers.  It can also be used to turn on the RS232 drivers before
	  connecting to a remote system to avoid "garbage" while the drivers
	  turn on.
SeeAlso: AH=23h"HUNTER",AH=24h"HUNTER",AH=26h"HUNTER"
--------S-1026------------------------------------
INT 10 - HUNTER 16 - CONTROL RI POWER UP
	AH = 26h
	AL = 00h enable RI power up
	    else disable RI power up
Desc:	control whether the Ring Indicator handshake can power up the Hunter
--------S-1427-------------------------------
INT 14 - MultiDOS Plus - GET BUFFER CHARACTER COUNT
	AH = 27h
	DX = port number
Return: AH = status
	    00h successful
	    41h no such port
	    42h monitor mode not active
	AL = number of characters in receive buffer
--------S-1027------------------------------------
INT 10 - HUNTER 16 - GET INSTALLED PROTOCOLS COUNT
	AH = 27h
	AL = number of extended protocols installed (since last call)
Return: AL = total number installed, including new ones
Desc:	Returns the number of extended communication protocols installed
SeeAlso: AH=25h"HUNTER",AH=28h"HUNTER"
--------S-1028------------------------------------
INT 10 - HUNTER 16 - GET PROTOCOL NAME
	AH = 28h
	AL = protocol handle
	DS:BX -> 8 character buffer for protocol name
Return:	AH = status
	    00h successful
		DS:BX buffer filled with the protocol name
	    FFh failed
SeeAlso: AH=27h"HUNTER",AH=29h"HUNTER"
--------S-1029------------------------------------
INT 10 - HUNTER 16 - GET PROTOCOL HANDLE
	AH = 29h
	DS:BX -> buffer containing the protocol name
Return: AH = status 
	    00h successful
		AL = handle
	    FFh failed
SeeAlso: AH=28h"HUNTER",AH=2Ah"HUNTER"
--------S-102A------------------------------------
INT 10 - HUNTER 16 - EXTENDED PROTOCOL MENU
	AH = 2Ah
	AL = protocol handle
Return: AH = status
	    00h successful
	    FFh failed
	AL = menu handle
SeeAlso: AH=29h"HUNTER",AH=2Bh"HUNTER"
--------S-102B------------------------------------
INT 10 - HUNTER 16 - GET EXTENDED PROTOCOL PARAMETERS
	AH = 2Bh
	AL = protocol handle
	DS:BX -> buffer for extended protocol parameters
Return: AH = status	
	    00h successful
		DS:BX buffer filled with extended parameters
	    FFh failed
SeeAlso: AH=2Ah"HUNTER"
--------S-102C00----------------------------------
INT 10 - HUNTER 16 - GET DTR
	AX = 2C00h
Return: AH = 00h
	BL = current state
	    00h	 normal DTR operation
	    else DTR is forced high
Desc:	Indicates whether the DTR signal on COM1 is forced high
Note:	the Husky Hunter 16 is an 8088-based ruggedized laptop.	 Other family
	  members are the Husky Hunter, Husky Hunter 16/80, and Husky Hawk.
SeeAlso: AH=2Ch"SET DTR"
--------S-102C------------------------------------
INT 10 - HUNTER 16 - SET DTR
	AH = 2Ch
	AL nonzero
	BL = new state
	    00h	 normal operation
	    else force DTR high
Return: AH = 00h
Desc:	determine whether the DTR signal on COM1 should be forced high
SeeAlso: AX=2C00h
--------S-1456-------------------------------
INT 14 U - BWCOM14 - INSTALLATION CHECK
	AH = 56h
Return: CX = 0001h if installed
Program: BWCOM14 is a network serial port emulator (simulating a Hayes modem
	  connected to the serial port) distributed as part of the
	  Beame&Whiteside BW-NFS package
SeeAlso: AH=57h,AH=58h
--------S-1457-------------------------------
INT 14 U - BWCOM14 - INITIALIZE
	AH = 57h
	DL = port number
Return: AL = initialization status (00h successful, 01h already initialized)
	CX = port status (0001h port redirected, 0002h and FFFFh failed)
Note:	after this call, all invocations of INT 14/AH=00h-03h for the specified
	  port will be handled by BWCOM14 until AH=58h is called
SeeAlso: AH=00h"SERIAL",AH=56h,AH=58h
--------S-1458-------------------------------
INT 14 U - BWCOM14 - SHUTDOWN
	AH = 58h
Return: CX = status (0001h successful, 0002h not initialized)
Note:	after this call, BWCOM14 will no longer redirect the COM port
SeeAlso: AH=56h,AH=57h
--------N-146F--BXFFFE-----------------------
INT 14 U - Connection Manager - ???
	AH = 6Fh
	BX = FFFEh
	???
Return: ???
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
--------N-146F--BXFFFF-----------------------
INT 14 - Connection Manager - INSTALLATION CHECK
	AH = 6Fh
	BX = FFFFh
Return: DX:BX -> Connection Manager Communication Table if installed
	BX = FFFFh if not installed
SeeAlso: AH=0Dh/DX=FFFFh
--------S-147E-------------------------------
INT 14 - FOSSIL - INSTALL AN EXTERNAL APPLICATION FUNCTION
	AH = 7Eh
	AL = code assigned to external application (80h-BFh)
	    80h reserved for communications FOSSIL
	    81h video FOSSIL
	    82h reserved for keyboard FOSSIL
	    83h reserved for system FOSSIL
	ES:DX -> entry point
Return: AX = 1954h
	BL = code assigned to application (same as input AL)
	DH = 00h failed
	     01h successful
SeeAlso: AH=7Fh,AH=80h"FOSSIL",AX=8100h,AH=82h"FOSSIL",AH=83h"FOSSIL"
--------S-147F-------------------------------
INT 14 - FOSSIL - REMOVE AN EXTERNAL APPLICATION FUNCTION
	AH = 7Fh
	AL = code assigned to external application
	ES:DX -> entry point
Return: AX = 1954h
	BL = code assigned to application (same as input AL)
	DH = 00h failed
	     01h successful
SeeAlso: AH=7Eh
--------S-1480-------------------------------
INT 14 - COMMUNICATIONS FOSSIL
	AH = 80h
SeeAlso: AH=7Eh
--------S-1480-------------------------------
INT 14 - COURIERS.COM - INSTALLATION CHECK
	AH = 80h
Return: AH = E8h if loaded
Program: COURIERS is a TSR utility by PC Magazine
--------S-148000-----------------------------
INT 14 - ARTICOM - INSTALLATION CHECK
	AX = 8000h
Return: AL = FFh if installed
	    BH = major version
	    BL = minor version
Program: ArtiCom is an asynchronous communications driver by Artisoft which
	  works on top of NetBIOS and allows modem/serial-port sharing by
	  programs using INT 14 for serial I/O.
Note:	ArtiCom supports 32 simultaneous COM ports using multiport cards and
	  drivers
SeeAlso: AH=00h,AH=01h,AH=02h,AH=03h,AH=04h,AH=05h,AX=8001h,AX=8002h
--------S-148001-----------------------------
INT 14 - ARTICOM - UNLOAD ASYNCHRONOUS REDIRECTOR FROM MEMORY
	AX = 8001h
Return: AX = error code, if error (see AX=8003h)
SeeAlso: AX=8000h,AX=8002h,AX=8003h
Index:	uninstall;ARTICOM
--------S-148002-----------------------------
INT 14 - ARTICOM - GET ASYNCHRONOUS REDIRECTOR STATUS
	AX = 8002h
	ES:DI -> buffer for redirector status structure (see below)
Return: AX = error code, if error (see AX=8003h)
SeeAlso: AX=8000h,AX=8003h

Format of redirector status:
Offset	Size	Description
 00h	WORD	redirector major and minor version numbers
 02h	WORD	redirectable ports found
 04h	WORD	redirectable ports + local ports found
 06h	WORD	redirector internal buffer size
 08h	WORD	maximum servers maintained
 0Ah	WORD	number of adapters found
--------S-148003-----------------------------
INT 14 - ARTICOM - TRANSLATE ERROR CODE TO ERROR STRING
	AX = 8003h
	CX = error number to translate
Return: ES:DI -> ASCIZ error text or NULL if can't translate.
SeeAlso: AX=8000h

Values for error codes:
 00h	"No error"
 01h	"An invalid port number was specified"
 02h	"Port is already redirected"
 03h	"Too many ports redirected"
 04h	"Cannot locate the server"
 05h	"Server is busy"
 06h	"Access denied"
 07h	"Resource in use"
 08h	"Resource in use - request queued"
 09h	"No such resource"
 0Ah	"Invalid username/password pair"
 0Bh	"Noncompatible version number"
 0Ch	"Can't remove from memory"
 0Dh	"Bad NETBIOS adapter number"
 0Eh	"No more entries in list"
 0Fh	"Resource is not available at this time"
 10h	"Invalid value to INT 14 call"
--------S-148004-----------------------------
INT 14 - ARTICOM - ATTACH ASYNCHRONOUS RESOURCE
	AX = 8004h
	DX = port to redirect (COM1=0, COM2=1, ...)
	CH = attach type
	CL = adapter to use for attach, 0FFh to search all
	ES:DI -> attachment structure (see below)
Return: AX = error code, if error (see AX=8003h)
Note:	The wildcard '*' is supported in the server and resource fields.  If
	  wild cards are used then the first matching available server is
	  attached.
SeeAlso: AX=8000h,AX=8003h,AX=8005h

Format of attachment structure:
Offset	Size	Description
 00h 16 BYTEs	server to look for attach
 10h 16 BYTEs	attach to resource name
 20h 16 BYTEs	username for attach
 30h 16 BYTEs	password for username or resource
 40h	BYTE	attach type
		00h normal
		01h queue if resource is in use (not yet supported in v1.00)
--------S-148005-----------------------------
INT 14 - ARTICOM - DETACH ASYNCHRONOUS RESOURCE
	AX = 8005h
	DX = port to detach (COM1=0, COM2=1, ...)
Return: AX = error code, if error (see AX=8003h)
Note:	only a previously attached resource can be detached
SeeAlso: AX=8000h,AX=8003h,AX=8004h
--------S-148006-----------------------------
INT 14 - ARTICOM - GET RESOURCE INFORMATION
	AX = 8006h
	BX = remote port (COM1=0, COM2=1, ...)
	CL = adapter number, FFh to try all adapters
	ES:DI -> resource information structure (see below)
	DS:SI -> 16 byte server name. See note.
Return: AX = error code, if error (see AX=8003h)
	BX = next remote port, recall to get next resource info
Note:	Wild cards supported in both the resource field and server name
	string DS:SI. If wild cards used then first matching available
	resource information is searched. Set the resource field to FFh to
	return all resources.
SeeAlso: AX=8000h,AX=8002h,AX=8003h,AX=8007h

Format of resource information structure:
Offset	Size	Description
 00h	BYTE	00h = free, else used
 01h 16 BYTEs	resource name
 11h 16 BYTEs	username of resource user
 21h	WORD	amount of time used
 23h	WORD	amount of time remaining
 53h 48 BYTEs	description of resource
 93h 64 BYTEs	initialization string for modem
 B3h 32 BYTEs	dial string for modem
 D3h 32 BYTEs	hang-up string for modem
--------S-148007-----------------------------
INT 14 - ARTICOM - GET REDIRECTED PORT INFORMATION
	AX = 8007h
	DX = port index (COM1=0, COM2=1, ...)
	ES:DI -> buffer for port information structure (see below)
Return: CF clear if redirection info returned and port is redirected
	CF set if not a redirected port
	AX = error code, if error (see AX=8003h)
SeeAlso: AX=8000h,AX=8003h,AX=8006h,AX=8008h

Format of port information structure:
Offset	Size	Description
 00h 16 BYTEs	server name resource is on
 10h	BYTE	adapter number server is on
 11h 16 BYTEs	resource name
 21h	WORD	remote port index, use to get additional information
 23h	WORD	buffer size
 25h	WORD	baud rate (see below)
 26h	BYTE	modem status register
 27h	BYTE	modem control register
 28h	BYTE	line status register
 29h	BYTE	line control register
 2Ah	BYTE	flow control in use: 0 - NONE, 1 - XON/XOFF, 2 - RTS/CTS
 2Bh	WORD	send timeout in ticks
 2Dh	WORD	receive timeout in ticks
 2Fh	WORD	time used on remote port
 31h	WORD	time left before timeout
 33h	BYTE	if server changes allowed?
 34h	WORD	FFFFh (-1) if connection ok, else old port index

Values for baud rate:
 00h	110
 01h	150
 02h	300
 03h	600
 04h	1200
 05h	2400
 06h	4800
 07h	9600
 08h	19200
 09h	38400
 0Ah	57600
 0Bh	115200
 0Ch	134.5
 0Dh	1800
 0Eh	2000
 0Fh	3600
 10h	7200
--------S-148008-----------------------------
INT 14 - ARTICOM - GET AVAILABLE SERVER NAME
	AX = 8008h
	BX = server index (0,1,...)
	ES:DI -> server name structure (see below)
Return: AX = error code, if error (see AX=8003h)
	BX = next remote port, repeat call to get next available server
Note:	the wildcard '*' is supported in the server name field.	 Set the
	  server name to FFh to search for all servers.
SeeAlso: AX=8000h,AX=8003h,AX=8007h

Format of server name structure:
Offset	 Size	  Description
  00h 16 BYTEs	  (call) ASCIZ server name
  10h	 BYTE	  (return) the adapter server is found
--------S-148009-----------------------------
INT 14 - ARTICOM - SET SEND AND RECEIVE TIMEOUTS
	AX = 8009h
	BX = send timeout in ticks
	CX = receive timeout in ticks
	DX = port index (COM1=0, COM2=1, ...)
Return: nothing
SeeAlso: AX=8000h,AX=800Ah
--------S-14800A-----------------------------
INT 14 - ARTICOM - MODIFY FLOW CONTROL
	AX = 800Ah
	BL = flow control type (00h none, 01h XON/XOFF, 02h RTS/CTS)
	DX = port index (COM1=0, COM2=1, ...)
Return: AX = error code, if error (see AX=8003h)
Note:	for attached ports only!
SeeAlso: AX=8000h,AX=8003h,AX=8009h
--------S-148025-----------------------------
INT 14 - ARTICOM - SET INTERNAL SEND/RECEIVE VECTOR
	AX = 8025h
	DS:DX -> address of trap function (see below) to call on read/write
Note:	setting the vector to a user function allows the redirector's activity
	  to be monitored.
SeeAlso: AX=8000h,AX=8035h,INT 21/AH=25h

Trap function called with:
	AH = operation
	    80h reading character
	    81h writing character
	AL = character
	Return: AX must be preserved
		far JUMP to old trap function (see AX=8035h)
--------S-148035-----------------------------
INT 14 - ARTICOM - GET INTERNAL SEND/RECEIVE VECTOR
	AX = 8035h
Return: ES:BX -> address of current send/receive routine
Note:	this function returns the address of the routine which is called
	  inside A-REDIR.EXE each time a character is received or sent on the
	  active COM port.
SeeAlso: AX=8000h,AX=8025h,INT 21/AH=35h
--------S-1481-------------------------------
INT 14 - COURIERS.COM - CHECK IF PORT BUSY
	AH = 81h
	AL = port number (1-4)
Return: AH = 00h port available
	     01h port exists but already in use
	     02h port nonexistent
Program: COURIERS is a TSR utility by PC Magazine
SeeAlso: AH=83h,AH=8Dh
--------S-1481-------------------------------
INT 14 - Egberto Willies COMM-DRV - EXTENDED INITIALIZATION
	AH = 81h
	BX:DI -> port control block
Return: ???
SeeAlso: AH=00h

Format of port control block:
Offset	Type	Description
 00h	WORD	port IO address
 02h	WORD	port IRQ
 04h	WORD	baud rate
 06h	WORD	parity
 08h	WORD	data bits
 0Ah	WORD	stop bits
 0Ch	WORD	break status
		0000h off
 0Eh	WORD	flow control protocol
 10h	BYTE	input block
 11h	BYTE	output block
 12h	WORD	low threshold
 14h	WORD	high threshold
 16h	WORD	segment of buffer
 18h	WORD	offset of buffer
 1Ah	WORD	input buffer length
 1Ch	WORD	output buffer length
 1Eh	BYTE	auxiliary address
 1Fh	BYTE	spare
 20h  4 WORDs	spares
--------V-148100-----------------------------
INT 14 - VIDEO FOSSIL - RETURN VFOSSIL INFORMATION
	AX = 8100h
	ES:DI -> buffer for VFOSSIL information (see below)
Return: AX = 1954h if installed
SeeAlso: AH=7Eh,AX=8101h

Format of VFOSSIL information:
Offset	Size	Description
 00h	WORD	size of information in bytes, including this field
 02h	WORD	VFOSSIL major version
 04h	WORD	VFOSSIL revision level
 06h	WORD	highest VFOSSIL application function supported
--------V-148101-----------------------------
INT 14 - VIDEO FOSSIL - OPEN VFOSSIL
	AX = 8101h
	ES:DI -> buffer for application function table (see below)
	CX = length of buffer in bytes
Return: AX = 1954h if installed
	    BH = highest VFOSSIL application function supported
Note:	the number of initialized pointers in the application function table
	  will never exceed CX/4; if the buffer is large enough, BH+1 pointers
	  will be initialized
SeeAlso: AX=8102h

Format of application function table:
Offset	Size	Description
 00h	DWORD	-> function to query current video mode (VioGetMode)
 04h	DWORD	-> function to set video mode (VioSetMode)
 08h	DWORD	-> function to query hardware config (VioGetConfig)
 0Ch	DWORD	-> function to write data in TTY mode (VioWrtTTY)
 10h	DWORD	-> function to get current ANSI state (VioGetANSI)
 14h	DWORD	-> function to set new ANSI state (VioSetANSI)
 18h	DWORD	-> function to get curr cursor position (VioGetCurPos)
 1Ch	DWORD	-> function to set cursor position (VioSetCurPos)
 20h	DWORD	-> function to get cursor shape (VioGetCurType)
 24h	DWORD	-> function to set cursor shape (VioSetCurType)
 28h	DWORD	-> function to scroll screen up (VioScrollUp)
 2Ch	DWORD	-> function to scroll screen down (VioScrollDn)
 30h	DWORD	-> function to read cell string from screen (VioReadCellStr)
 34h	DWORD	-> function to read char string from screen (VioReadCharStr)
 38h	DWORD	-> function to write a cell string (VioWrtCellStr)
 3Ch	DWORD	-> function to write char string, leaving attr (VioWrtCharStr)
 40h	DWORD	-> function to write char string,const attr (VioWrtCharStrAttr)
 44h	DWORD	-> function to replicate an attribute (VioWrtNAttr)
 48h	DWORD	-> function to replicate a cell (VioWrtNCell)
 4Ch	DWORD	-> function to replicate a character (VioWrtNChar)

Format of video mode data structure:
Offset	Size	Description
 00h	WORD	length of structure including this field
 02h	BYTE	mode characteristics
		bit 0: clear if MDA, set otherwise
		bit 1: graphics mode
		bit 2: color disabled (black-and-white)
 03h	BYTE	number of colors supported (1=2 colors, 4=16 colors, etc)
 04h	WORD	number of text columns
 06h	WORD	number of text rows
 08h	WORD	reserved
 0Ah	WORD	reserved
 0Ch	DWORD	reserved

Format of video configuration data:
Offset	Size	Description
 00h	WORD	structure length including this field
 02h	WORD	adapter type
		00h monochrome/printer
		01h CGA
		02h EGA
		03h VGA
		07h 8514/A
 04h	WORD	display type
		00h monochrome
		01h color
		02h enhanced color
		09h 8514
 06h	DWORD	adapter memory size

Format of cursor type record:
Offset	Size	Description
 00h	WORD	cursor start line
 02h	WORD	cursor end line
 04h	WORD	cursor width (always 01h)
 06h	WORD	cursor attribute (FFFFh = hidden)

Call VioGetMode with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to video mode data structure (see above)
Return: AX = error code (00h, 74h, 17Eh, 1B4h) (see below)

Values for error code:
 0000h	successful
 0074h	internal VIO failure
 0163h	unsupported mode
 0166h	invalid row value
 0167h	invalid column value
 017Eh	buffer too small
 01A5h	invalid VIO parameter
 01B4h	invalid VIO handle

Call VioSetMode with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to video mode data structure (see above)
Return: AX = error code (00h, 74h, 163h, 17Eh, 1A5h, 1B4h) (see above)

Call VioGetConfig with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to video configuration data buffer (see above)
Return: AX = error code (00h, 74h, 17Eh, 1B4h) (see above)

Call VioWrtTTY with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	length of string
		DWORD	pointer to character string to be written to screen
Return: AX = error code (00h, 74h, 1B4h) (see above)
Notes:	write wraps at end of line and terminates if it reaches end of screen
	in ANSI mode, ANSI control sequences are interpreted, and this func is
	  not required to be reentrant; in non-ANSI mode, the function is
	  reentrant and may be called from within an MS-DOS function call

Call VioGetANSI with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to WORD which will be set to 00h if ANSI is off
			or 01h if ANSI is on
Return: AX = error code (00h, 74h, 1B4h) (see above)

Call VioSetANSI with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to WORD indicating new state of ANSI
			00h off
			01h on
Return: AX = error code (00h, 74h, 1A4h, 1B4h) (see above)

Call VioGetCurPos with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to WORD to hold current cursor column (0-based)
		DWORD	pointer to WORD to hold current cursor row (0-based)
Return: AX = error code (00h, 74h, 1B4h) (see above)

Call VioSetCurPos with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	cursor column
		WORD	cursor row
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see above)
Note:	if either coordinate is invalid, the cursor is not moved

Call VioGetCurType with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to cursor type record (see above)
Return: AX = error code (00h, 74h, 1B4h) (see above)

Call VioSetCurType with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to cursor type record (see above)
Return: AX = error code (00h, 74h, 1A4h, 1B4h) (see above)

Call VioScrollUp with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to char/attr cell for filling emptied rows
		WORD	number or rows to scroll (FFFFh = clear area)
		WORD	right column of scroll area
		WORD	bottom row of scroll area
		WORD	left column of scroll area
		WORD	top row of scroll area
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see above)

Call VioScrollDn with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to char/attr cell for filling emptied rows
		WORD	number or rows to scroll (FFFFh = clear area)
		WORD	right column of scroll area
		WORD	bottom row of scroll area
		WORD	left column of scroll area
		WORD	top row of scroll area
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see above)

Call VioReadCellStr with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start reading
		WORD	row at which to start reading
		DWORD	pointer to WORD containing length of buffer in bytes
			on return, WORD contains number of bytes actually read
		DWORD	pointer to buffer for cell string
Return: AX = error code (00h, 74h, 166h ,167h, 1B4h) (see above)

Call VioReadCharStr with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start reading
		WORD	row at which to start reading
		DWORD	pointer to WORD containing length of buffer in bytes
			on return, WORD contains number of bytes actually read
		DWORD	pointer to buffer for character string
Return: AX = error code (00h, 74h, 166h ,167h, 1B4h) (see above)

Call VioWrtCellStr with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start writing
		WORD	row at which to start writing
		WORD	length of cell string in bytes
		DWORD	pointer to cell string to write
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see above)
Note:	write wraps at end of line and terminates if it reaches end of screen

Call VioWrtCharStr with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start writing
		WORD	row at which to start writing
		WORD	length of character string
		DWORD	pointer to character string to write
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see above)
Note:	write wraps at end of line and terminates if it reaches end of screen

Call VioWrtCharStrAttr with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to attribute to be applied to each character
		WORD	column at which to start writing
		WORD	row at which to start writing
		WORD	length of character string
		DWORD	pointer to character string to write
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see above)
Note:	write wraps at end of line and terminates if it reaches end of screen

Call VioWrtNAttr with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start writing
		WORD	row at which to start writing
		WORD	number of times to write attribute
		DWORD	pointer to display attribute to replicate
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see above)
Note:	write wraps at end of line and terminates if it reaches end of screen

Call VioWrtNCell with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start writing
		WORD	row at which to start writing
		WORD	number of times to write cell
		DWORD	pointer to cell to replicate
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see above)
Note:	write wraps at end of line and terminates if it reaches end of screen

Call VioWrtNChar with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start writing
		WORD	row at which to start writing
		WORD	number of times to write character
		DWORD	pointer to character to replicate
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see above)
Note:	write wraps at end of line and terminates if it reaches end of screen
--------V-148102-----------------------------
INT 14 - VIDEO FOSSIL - CLOSE VFOSSIL
	AX = 8102h
Return: AX = 1954h
Note:	terminates all operations; after this call, the video FOSSIL may either
	  be removed from memory or reinitialized
SeeAlso: AX=8101h,AX=8103h
--------V-148103-----------------------------
INT 14 - VIDEO FOSSIL - UNINSTALL
	AX = 8103h
Return: AX = 1954h
Note:	this is an extension to the VFOSSIL spec by Bob Hartman's VFOS_IBM
--------K-1482-------------------------------
INT 14 - KEYBOARD FOSSIL
	AH = 82h
SeeAlso: AH=7Eh
--------S-1482-------------------------------
INT 14 - COURIERS.COM - CONFIGURE PORT
	AH = 82h
	AL = port number (1-4)
	BX = speed (bps)
	CX = bit flags
	    bit 0: enable input flow control
	    bit 1: enable output flow control
	    bit 2: use X.PC protocol (not yet implemented)
SeeAlso: AH=00h,AH=8Ch,INT 7A"X.PC"
----------1483-------------------------------
INT 14 - SYSTEM FOSSIL
	AH = 83h
SeeAlso: AH=7Eh
--------S-1483-------------------------------
INT 14 - COURIERS.COM - START INPUT
	AH = 83h
	ES:BX -> circular input buffer
	CX = length of buffer
		(should be at least 128 bytes if input flow control enabled)
SeeAlso: AH=18h,AH=87h,AH=8Dh,AH=A5h"BAPI"
--------S-1484-------------------------------
INT 14 - COURIERS.COM - READ CHARACTER
	AH = 84h
Return: ZF set if no characters available
	ZF clear
	   AL = character
	   AH = modem status bits
		bit 7: set on input buffer overflow
SeeAlso: AH=02h,AH=86h,AH=89h
--------S-1485-------------------------------
INT 14 - COURIERS.COM - FLUSH PENDING INPUT
	AH = 85h
SeeAlso: AH=0Ah,AH=88h
--------S-1486-------------------------------
INT 14 - COURIERS.COM - START OUTPUT
	AH = 86h
	ES:BX -> output buffer
	CX = length of output buffer
SeeAlso: AH=19h,AH=83h"COURIERS",AH=A4h"BAPI"
--------S-1487-------------------------------
INT 14 - COURIERS.COM - OUTPUT STATUS
	AH = 87h
Return: AX = number of unsent characters
--------S-1488-------------------------------
INT 14 - COURIERS.COM - ABORT OUTPUT
	AH = 88h
SeeAlso: AH=09h,AH=85h
--------S-1489-------------------------------
INT 14 - COURIERS.COM - SEND SINGLE CHARACTER
	AH = 89h
	CL = character to send
SeeAlso: AH=01h,AH=84h
--------S-148A-------------------------------
INT 14 - COURIERS.COM - SEND BREAK
	AH = 8Ah
SeeAlso: AH=89h,AH=FAh
--------S-148C-------------------------------
INT 14 - COURIERS.COM - SET SPEED
	AH = 8Ch
	BX = speed in bps
SeeAlso: AH=00h,AH=82h"COURIERS"
--------S-148D-------------------------------
INT 14 - COURIERS.COM - DECONFIGURE PORT
	AH = 8Dh
SeeAlso: AH=82h"COURIERS"
--------S-14A0-------------------------------
INT 14 - 3com BAPI SERIAL I/O - CONNECT TO PORT
	AH = A0h
	ES:BX -> ASCIZ internet host name
	CX = length of name
Return: AH = return code (00h,04h-06h,08h,0Ah-0Ch) (see below)
	CL = session ID
Program: the Bridge Application Program Interface is a set of functions which
	  makes many of the details of LAN communications transparent
Note:	Novell TELAPI.EXE returns AH=09h (not supported) and CL=00h
SeeAlso: AH=A1h"BAPI",AH=A2h"BAPI",AH=A5h"BAPI",AX=AF00h

Values for return code:
 00h	successful
 01h	no characters written
 02h	no characters read
 03h	no such session
 04h	clearinghouse name not found
 05h	no response from host
 06h	no more sessions available
 07h	session aborted
 08h	invalid clearinghouse name
 09h	not supported
 0Ah	internal (general) network error
 0Bh	out of memory
 0Ch	invalid IP address
--------S-14A0--CXFFFF-----------------------
INT 14 - Interconnections Inc. TES - INSTALLATION CHECK/STATUS REPORT
	AH = A0h
	CX = FFFFh
Return: CF clear if successful
	    AX = 5445h ('TE')
	    CX <> FFFFh
	    DX = port number
	CF set on error
Program: TES is a network serial port emulation program
SeeAlso: AH=A1h"TES"
--------S-14A1-------------------------------
INT 14 - 3com BAPI SERIAL I/O - DISCONNECT FROM PORT
	AH = A1h
	DH = session ID (00h for external session managment)
Return: AH = return code (00h,03h,07h,0Ah,0Bh) (see AH=A0h"BAPI")
	AL destroyed (Novell TELAPI.EXE)
SeeAlso: AH=A0h"BAPI"
--------S-14A1-------------------------------
INT 14 - Interconnections Inc. TES - GET LIST OF SESSIONS WITH STATUS
	AH = A1h
Return: CX = number of active sessions
	ES:SI -> status array (see below)
SeeAlso: AH=A2h"TES",AH=A3h"TES"

Format of status array entry:
Offset	Size	Description
 00h	BYTE	status
 01h	WORD	offset of name
--------S-14A2-------------------------------
INT 14 - 3com BAPI SERIAL I/O - WRITE CHARACTER
	AH = A2h
	AL = character
	DH = session ID (00h for external session managment)
Return: AH = return code (00h,01h,03h,07h,0Ah,0Bh) (see AH=A0h"BAPI")
SeeAlso: AH=A0h"BAPI",AH=A3h"BAPI",AH=A4h"BAPI"
--------S-14A2-------------------------------
INT 14 - Interconnections Inc. TES - GET LIST OF SERVER NAMES
	AH = A2h
Return: CX = number of servers
	ES:SI -> array of offsets from ES for server names
SeeAlso: AH=A1h"TES"
--------S-14A3-------------------------------
INT 14 - 3com BAPI SERIAL I/O - READ CHARACTER
	AH = A3h
	DH = session ID (00h for external session managment)
Return: AH = return code (00h,02h,03h,07h,0Ah,0Bh) (see AH=A0h"BAPI")
	AL = character read or 00h if none available
SeeAlso: AH=A0h"BAPI",AH=A2h"BAPI",AH=A5h"BAPI",AH=A7h"BAPI"
--------S-14A3-------------------------------
INT 14 - Interconnections Inc. TES - START A NEW SESSION
	AH = A3h
	ES:SI -> ???
Return: CF clear if successful
	    AX = 5445h ('TE')
	    CX <> FFFFh
	    DX = port number
	CF set on error
SeeAlso: AH=A1h"TES",AH=A4h"TES",AH=A6h"TES"
--------S-14A4-------------------------------
INT 14 - 3com BAPI SERIAL I/O - WRITE BLOCK
	AH = A4h
	CX = length of buffer in bytes
	DH = session ID (00h for external session managment)
	ES:BX -> buffer containing data
Return: AH = return code (00h,01h,03h,07h,0Ah,0Bh) (see AH=A0h"BAPI")
	CX = number of bytes actually sent
SeeAlso: AH=19h,AH=86h,AH=A0h"BAPI",AH=A5h"BAPI"
--------S-14A4-------------------------------
INT 14 - Interconnections Inc. TES - HOLD CURRENTLY ACTIVE SESSION
	AH = A4h
	???
Return: ???
SeeAlso: AH=A3h"TES",AH=A5h"TES"
--------S-14A5-------------------------------
INT 14 - 3com BAPI SERIAL I/O - READ BLOCK
	AH = A5h
	CX = length of buffer
	DH = session ID (00h for external session managment)
	ES:BX -> buffer for data
Return: AH = return code (00h,02h,03h,07h,0Ah,0Bh) (see AH=A0h"BAPI")
	CX = number of bytes actually read
SeeAlso: AH=18h,AH=83h"COURIERS",AH=A0h"BAPI",AH=A3h"BAPI",AH=A4h"BAPI"
SeeAlso: AH=A7h"BAPI",AX=FF02h
--------S-14A5-------------------------------
INT 14 - Interconnections Inc. TES - RESUME A SESSION
	AH = A5h
	AL = session number
Return: ???
SeeAlso: AH=A4h"TES",AH=A6h"TES"
--------S-14A6-------------------------------
INT 14 - 3com BAPI SERIAL I/O - SEND SHORT BREAK
	AH = A6h
	DH = session ID (00h for external session managment)
Return: AH = return code (00h,03h,07h,0Ah,0Bh) (see AH=A0h"BAPI")
Desc:	generate a short break signal; if data delivery was turned off by the
	  break, wait for the host to turn it on again
SeeAlso: AH=1Ah,AH=8Ah,AH=FAh,AH=A0h"BAPI"
--------S-14A6-------------------------------
INT 14 - Interconnections Inc. TES - DROP A SESSION
	AH = A6h
	AL = session number
Return: AH = status
	    00h successful
	    else error
SeeAlso: AH=A3h"TES",AH=A5h"TES"
--------S-14A7-------------------------------
INT 14 - 3com BAPI SERIAL I/O - READ STATUS
	AH = A7h
	DH = session ID (00h for external session managment)
Return: AH = return code (00h,03h,07h,0Ah,0Bh) (see AH=A0h"BAPI")
	CX = number of bytes available for reading
Note:	Novell TELAPI.EXE v4.01 always returns either 0 or 1 bytes available
SeeAlso: AH=A5h"BAPI"
--------S-14A7-------------------------------
INT 14 - Interconnections Inc. TES - SWITCH TO NEXT ACTIVE SESSION
	AH = A7h
	???
Return: ???
SeeAlso: AH=A3h"TES",AH=A5h"TES"
--------S-14A8-------------------------------
INT 14 - Interconnections Inc. TES - SEND STRING TO COMMAND INTERPRETER
	AH = A8h
	AL = 00h no visible response
	ES:SI -> ASCIZ command
Return: ???
--------N-14A8-------------------------------
INT 14 - Novell TelAPI v4.01 - CONNECTION INFORMATION???
	AH = A8h
	DH = session ID???
	CH = subfunction
	    02h ???
	    0Dh ???
	    0Fh ???
	    10h ???
	    11h ???
	    28h ???
	    else
		Return: AH = 09h (not supported)
Return: AH = return code (see AH=A0h"BAPI")
	    00h successful
		CL = ??? (0/1/8) (subfunctions 02h,0Dh,0Fh,10h)
		CL = ??? (7Fh/FFh) (subfunction 28h)
		CX = ??? (subfunction 11h)
SeeAlso: AH=A9h"TelAPI"
--------N-14A9-------------------------------
INT 14 - Novell TelAPI v4.01 - CONNECTION CONTROL???
	AH = A9h
	DH = session ID???
	CH = subfunction
	    02h ???
	    0Dh ???
	    0Fh ???
	    10h ???
	    11h ???
	    28h ???
	    else
		Return: AH = 09h (not supported)
	???
Return: AH = return code (see AH=A0h"BAPI")
	???
SeeAlso: AH=A8h"TelAPI",AH=E4h,INT 6B/AX=0600h
--------S-14AF00BXAAAA-----------------------
INT 14 - 3com BAPI SERIAL I/O - INSTALLATION CHECK
	AX = AF00h
	BX = AAAAh
Return: AX = AF01h if installed
	    BH = protocol type (if BX=AAAAh on entry)
		01h NetManage TCP/IP
	    BL = version for protocol type (if BX=AAAAh on entry)
Note:	early versions of the BAPI and the ROM BIOS simply destroy AX; this
	  behavior is used to determine whether the newer functions (AH=B0h,
	  AH=B1h,etc) are available
SeeAlso: AH=A0h"BAPI"
--------S-14B0-------------------------------
INT 14 - 3com BAPI SERIAL I/O - EN/DISABLE "ENTER COMMAND MODE" (ECM) CHARACTER
	AH = B0h
	AL = new state (00h disabled, 01h enabled)
Return: AH = return code (00h,07h,0Ah) (see AH=A0h"BAPI")
Note:	disabling the ECM character allows applications to send data which
	  includes the ECM character
SeeAlso: AX=AF00h"BAPI",AH=B1h,AH=B2h
--------S-14B1-------------------------------
INT 14 - 3com BAPI SERIAL I/O - ENTER COMMAND MODE
	AH = B1h
Return: AH = return code (00h,07h,0Ah) (see AH=A0h"BAPI")
Desc:	provide a means for the application or terminal emulator to perform
	  the same action normally caused by the ECM character
SeeAlso: AH=B0h,AH=B2h
--------S-14B2-------------------------------
INT 14 - 3com BAPI SERIAL I/O - GET ECM WATCH STATE
	AH = B2h
Return: AH = return code (00h,07h,0Ah) (see AH=A0h"BAPI")
	AL = watch flag (00h disabled, 01h enabled)
Desc:	determine whether the ECM character is enabled
SeeAlso: AH=B0h,AH=B1h
--------S-14B3-------------------------------
INT 14 - 3com BAPI SERIAL I/O - GET/SET CONFIGURATION INFO
	AH = B3h
	AL = direction (00h get, 01h set)
	DH = session ID (00h for external session managment)
	DL = configuration item (00h = end-of-line mapping)
	CX = new configuration item value (if AL=01h)
	    ---if DL=00h---
	    CH = application EOL type (app to Telnet client)
		01h application will send lone CR
		02h application will send CR-? pair
	    CL = driver EOL type (Telnet client to Telnet server)
		01h driver should send CR-NUL pair
		02h driver should send CR-LF pair
Return: AH = return code (00h,03h,09h-0Bh) (see AH=A0h"BAPI")
	---if AL=00h---
	CX = configuration item value (see above)
SeeAlso: AH=B2h
--------N-14E0-------------------------------
INT 14 - TelAPI - ???
	AH = E0h
	BX = ???
	CX:DX = ???
	DS:DI -> ???
	ES:SI -> ???
Return: AX = status (0000h,FF37h,etc.)
	ES:SI -> ??? if ???
	???
SeeAlso: AH=ECh,AX=FF00h
--------S-14E000-----------------------------
INT 14 - MX5 Extended FOSSIL - GET MNP STATUS BLOCK
	AX = E000h
	DX = port number (0-3)
Return: ES:BX -> status block (see below)
Program: MX5 is a FOSSIL driver by MagicSoft which emulates MNP Level 5, and
	  ships with the MTEZ terminal program as MTEMNP.DRV (a TSR despite
	  the .DRV extension)
SeeAlso: AX=E006h

Format of status block:
Offset	Size	Description
 00h	BYTE	flag: active (00h no, 01h yes)
 01h	BYTE	MNP level (2,4,5)
 02h	BYTE	series ID from remote MNP
 03h	DWORD	total packets transmitted
 07h	DWORD	duplicate packets transmitted
 0Bh	DWORD	maximum speed
 0Fh	DWORD	total packets received
 13h	DWORD	duplicate packets received
 17h	DWORD	maximum speed
--------S-14E001-----------------------------
INT 14 - MX5 Extended FOSSIL - GET/SET MNP LEVEL
	AX = E001h
	BH = function
	    00h get MNP level
	    01h set MNP level
		BL = new level (00h none, 02h/04h/05h MNP level N)
	DX = port number (0-3)
Return: BL = MNP level
SeeAlso: AX=E002h,AX=E003h,AX=E004h,AX=E006h
--------S-14E002-----------------------------
INT 14 - MX5 Extended FOSSIL - GET/SET MNP ANSWER/ORIGINATE MODE
	AX = E002h
	BH = function
	    00h get answer/originate mode
	    01h set mode
		BL = new mode (00h originate [default], 01h answer)
	DX = port number (0-3)
Return: BL = answer/originate mode
SeeAlso: AX=E001h,AX=E003h,AX=E006h
--------S-14E003-----------------------------
INT 14 - MX5 Extended FOSSIL - GET/SET MNP WAIT TICKS
	AX = E003h
	BH = function
	    00h get wait ticks
	    01h set wait ticks
		BL = MNP wait ticks (default 0Eh)
	DX = port number (0-3)
Return: BL = wait ticks
SeeAlso: AX=E001h,AX=E002h,AX=E006h
--------S-14E004-----------------------------
INT 14 - MX5 Extended FOSSIL - GET/SET MNP CONNECT SOUND LEVEL
	AX = E004h
	BH = function
	    00h get sound level
	    01h set sound level
		BL = new sound level (00h off, 01h on [default])
	DX = port number
Return: BL = sound state
Desc:	specify whether MX5 should generate beeps after an MNP connection
	  (three high beeps if successful, high then low on connection failure)
SeeAlso: AX=E002h,AX=E006h
--------S-14E005-----------------------------
INT 14 - MX5 Extended FOSSIL - UNINSTALL
	AX = E005h
Return: BX = segment of MX5's memory block or 0000h on failure
Note:	caller must free the returned memory block to complete the uninstall
SeeAlso: AX=E006h
--------S-14E006BX0000-----------------------
INT 14 - MX5 Extended FOSSIL - INSTALLATION CHECK
	AX = E006h
	BX = 0000h
Return: BX = 4D58h ('MX') if installed
	    AH = major version
	    AL = minor version
SeeAlso: AX=E000h,AX=E001h,AX=E005h,AX=E007h
--------S-14E007-----------------------------
INT 14 - MX5 Extended FOSSIL - WAIT SPECIFIED NUMBER OF TICKS
	AX = E007h
	CX = number of ticks to wait
Return: nothing
SeeAlso: AX=E006h
--------N-14E1-------------------------------
INT 14 - TelAPI - ???
	AH = E1h
	BX = connection ID
	???
Return: AX = status (0000h,FFF7h,maybe others)
	???
SeeAlso: AH=E6h,AX=FF00h
--------N-14E2-------------------------------
INT 14 - TelAPI - BUFFERED READ
	AH = E2h
	BX = connection ID
	CX = length of buffer in bytes
	ES:SI -> buffer for data
Return: AX = number of characters actually read??? (negative on error)
SeeAlso: AH=E6h,AX=FF00h,INT 6B/AH=01h
--------N-14E3-------------------------------
INT 14 - TelAPI - BUFFERED WRITE
	AH = E3h
	BX = connection ID
	CX = length of buffer in bytes
	ES:SI -> buffer containing data
Return: AX = number of characters actually written??? (negative on error)
SeeAlso: AH=07h"TelAPI",AH=E6h,AX=FF00h,INT 6B/AH=00h
--------N-14E4-------------------------------
INT 14 - TelAPI - CONNECTION CONTROL???
	AH = E4h
	BX = connection ID
	CX = ???
	ES:SI -> 10-byte buffer containing ???
Return: ???
SeeAlso: AH=A9h,AH=E6h,AX=FF00h,INT 6B/AX=0600h
--------N-14E5-------------------------------
INT 14 - TelAPI - ???
	AH = E5h
Return: AX = status???
SeeAlso: AH=E6h,AX=FF00h
--------N-14E6-------------------------------
INT 14 - TelAPI - ???
	AH = E6h
Return: AX = status???
Notes:	TelAPI also supports the NASI/NACS and NCSI APIs on INT 6B
	this function invokes AH=E5h internally
SeeAlso: AX=FF00h,INT 6B/AH=00h,INT 6B/AH=10h
--------N-14E7-------------------------------
INT 14 - TelAPI - GET ???
	AH = E7h
	ES:SI -> 20-byte buffer for ???
Return: AX = 0000h (successful)
	ES:SI buffer filled
SeeAlso: AX=FF00h
--------N-14E8-------------------------------
INT 14 - TelAPI - SET ???
	AH = E8h
	BX = connection ID
	CL = new value for ???
	DX = ??? (ignored by Novell TELAPI v4.01)
Return: AX = status (0000h,FFFFh)
SeeAlso: AX=FF00h
--------N-14E9-------------------------------
INT 14 - TelAPI - ???
	AH = E9h
	DX = ???
Return: ???
SeeAlso: AX=FF00h
--------N-14EA-------------------------------
INT 14 - TelAPI - GET CONNECTION INFO???
	AH = EAh
	BX = connection ID
	ES:SI -> buffer for info???
Return: AX = status (0000h,FFFFh,etc.)
SeeAlso: AX=FF00h
--------N-14EB-------------------------------
INT 14 - TelAPI - GET ???
	AH = EBh
	ES:SI -> buffer for ???
Return: ES:SI buffer filled
SeeAlso: AX=FF00h
--------N-14EC-------------------------------
INT 14 - TelAPI - ???
	AH = ECh
	BX = ???
	CX:DX = ???
	DS:DI -> ???
	ES:SI -> ???
Return: AX = status (0000h,FF37h,etc.)
	ES:SI -> ??? if ???
	???
Note:	this function is not supported by the Microdyne TelAPI v3.7
SeeAlso: AH=E0h"TelAPI",AX=FF00h
--------N-14ED-------------------------------
INT 14 - TelAPI - ???
	AH = EDh
	BX = connection ID
Return: AX = status (0000h,FFFFh,etc.)
Note:	this function is not supported by the Microdyne TelAPI v3.7
SeeAlso: AX=FF00h
--------a-14F0F0-----------------------------
INT 14 - ASAP v1.0 - ???
	AX = F0F0h
	DX = ???
	???
Return: ???
Program: ASAP (Automatic Screen Access Program) is a shareware screen reader by
	  MicroTalk
SeeAlso: AX=F0F1h
--------a-14F0F1DX0000-----------------------
INT 14 - ASAP v1.0 - INSTALLATION CHECK
	AX = F0F1h
	DX = 0000h
Return: DX = segment of resident code
	   = 0000h if not installed
Program: ASAP (Automatic Screen Access Program) is a shareware screen reader by
	  MicroTalk
SeeAlso: AX=F0F0h,INT 10/AX=3800h
--------S-14F4FF-----------------------------
INT 14 - IBM/Yale EBIOS SERIAL I/O - INSTALLATION CHECK
	AX = F4FFh
	DX = port (00h-03h)
Return: CF clear if present
	    AX = 0000h
	CF set if not present
	    AX <> 0000h
--------S-14F9-------------------------------
INT 14 - IBM/Yale EBIOS SERIAL I/O - REGAIN CONTROL
	AH = F9h
	DX = port (00h-03h)
--------S-14FA-------------------------------
INT 14 - IBM/Yale EBIOS SERIAL I/O - SEND BREAK
	AH = FAh
	DX = port (00h-03h)
SeeAlso: AH=1Ah,AH=8Ah
--------S-14FB-------------------------------
INT 14 - IBM/Yale EBIOS SERIAL I/O - SET OUTGOING MODEM SIGNALS
	AH = FBh
	AL = modem control register (see AH=05h)
	DX = port (00h-03h)
SeeAlso: AH=05h"SERIAL"
--------S-14FC-------------------------------
INT 14 - IBM/Yale EBIOS SERIAL I/O - READ CHARACTER, NO WAIT
	AH = FCh
	DX = port (00h-03h)
Return: AH = RS232 status bits (see AH=00h)
	AL = character
SeeAlso: AH=02h,AH=0Ch,AX=FF02h
--------S-14FD02-----------------------------
INT 14 - IBM/Yale EBIOS SERIAL I/O - READ STATUS
	AX = FD02h
Return: CX = number of characters available
--------N-14FF00-----------------------------
INT 14 - TelAPI - INSTALLATION CHECK
	AX = FF00h
Return: AL = FFh if installed
	AH = 00h for Novell TELAPI.EXE
SeeAlso: AH=E6h
--------S-14FF01-----------------------------
INT 14 - IBM/Yale EBIOS SERIAL I/O - SET SEND BUFFER
	AX = FF01h
	CX = length of buffer (0000h to cancel buffer assignment)
	DX = port (00h-03h)
	ES:BX -> send buffer
SeeAlso: AH=18h,AH=83h"COURIERS",AH=A5h"BAPI",AH=FCh,AX=FF02h
--------S-14FF02-----------------------------
INT 14 - IBM/Yale EBIOS SERIAL I/O - SET RECEIVE BUFFER
	AX = FF02h
	CX = length of buffer (0000h to cancel buffer assignment)
	DX = port (00h-03h)
	ES:BX -> receive buffer
SeeAlso: AH=18h,AH=83h"COURIERS",AH=A5h"BAPI",AH=FCh,AX=FF03h
--------t-15---------------------------------
INT 15 - Microsoft TSR Specification
	No additional information available at this time.
--------B-1500-------------------------------
INT 15 - CASSETTE - TURN ON TAPE DRIVE'S MOTOR (PC and PCjr only)
	AH = 00h
Return: CF set on error
	    AH = 86h no cassette present
	CF clear if successful
SeeAlso: AH=01h"CASSETTE"
--------M-1500-------------------------------
INT 15 - Amstrad PC1512 - GET AND RESET MOUSE COUNTS
	AH = 00h
Return: CX = signed X count
	DX = signed Y count
--------O-1500-------------------------------
INT 15 - VMiX v2+ - INSTALLATION CHECK
	AH = 00h
Return: DX = 0798h if installed
	    AX = version (AH = major, AL = minor)
--------T-1500-------------------------------
INT 15 - MultiDOS Plus - GIVE UP TIME SLICE
	AH = 00h
Note:	if issued by the highest-priority task while MultiDOS is using
	  priority-based rather than round-robin scheduling, control will be
	  returned to the caller immediately
SeeAlso: AH=03h"MultiDOS",AX=1000h
--------B-1501-------------------------------
INT 15 - CASSETTE - TURN OFF TAPE DRIVE'S MOTOR (PC and PCjr only)
	AH = 01h
Return: CF set on error
	    AH = 86h no cassette present
	CF clear if successful
SeeAlso: AH=00h"CASSETTE"
--------b-1501-------------------------------
INT 15 - Amstrad PC1512 - WRITE DATA TO NON-VOLATILE RAM
	AH = 01h
	AL = NVRAM location (00h to 3Fh)
	BL = NVRAM data value
Return: AH = return code
	    00h OK
	    01h address bad
	    02h write error
SeeAlso: AH=02h"Amstrad"

Format of NVRAM:
Offset	Size	Description
 00h	BYTE	time of day: seconds
 01h	BYTE	alarm time: seconds
 02h	BYTE	time of day: minutes
 03h	BYTE	alarm time: minutes
 04h	BYTE	time of day: hours
 05h	BYTE	alarm time: hours
 06h	BYTE	day of week, 1 = Sunday
 07h	BYTE	day of month
 08h	BYTE	month
 09h	BYTE	year mod 100
 0Ah	BYTE	RTC status register A
		bit 7: set if date/time being updated
		bits 6-4: time base speed, default 010 = 32768 Hz
		bits 3-0: interrupt rate selection, default 0110 = 1024 Hz
 0Bh	BYTE	RTC status register B (see below)
 0Ch	BYTE	RTC status register C (read-only)
		bit 7: IRQF flag
		bit 6: PF flag
		bit 5: AF flag
		bit 4: UF flag
 0Dh	BYTE	RTC status register D
		bit 7: battery good
 0Eh  6 BYTEs	time and date machine last used
 14h	BYTE	user RAM checksum
 15h	WORD	Enter key scancode/ASCII code
 17h	WORD	Forward delete key scancode/ASCII code
 19h	WORD	Joystick fire button 1 scancode/ASCII code
 1Bh	WORD	Joystick fire button 2 scancode/ASCII code
 1Dh	WORD	mouse button 1 scancode/ASCII code
 1Fh	WORD	mouse button 2 scancode/ASCII code
 21h	BYTE	mouse X scaling factor
 22h	BYTE	mouse Y scaling factor
 23h	BYTE	initial VDU mode and drive count
 24h	BYTE	initial VDU character attribute
 25h	BYTE	size of RAM disk in 2K blocks
 26h	BYTE	initial system UART setup byte
 27h	BYTE	initial external UART setup byte
 28h 24 BYTEs	available for user application
Note:	bytes 00h-0Dh are the same on the IBM AT as they are used/updated by
	  the clock chip

Bitfields for RTC status register B:
 bit 7	clear if normal update, set if abort update
 bit 6	periodic interrupt enable
 bit 5	alarm interrupt enable
 bit 4	update end interrupt enable
 bit 3	square wave enable
 bit 2	date mode (clear = BCD, set = binary)
 bit 1	24-hour format
 bit 0	daylight saving time enable
--------O-1501-------------------------------
INT 15 - VMiX - "sys_chanreq" - I/O CHANNEL OBJECT MANAGER
	AH = 01h
	STACK:	WORD	object ID of requestor
		DWORD	pointer to ASCIZ name of requested method
			"assign" assign channel to object
			"deassign" deassign channel
			"cursor" set cursor on/off
			"init" initialize comm port
			"open" open I/O channel
			"position" set cursor position
			"receive" get buffered packet from comm port
			"send" send buffered packet to comm port
			"vio" set current virtual I/O to specified channel
			"window" make window at cursor position
		---if "assign"---
		 WORD	object UID
		 WORD	caller UID/PID
		 DWORD	CSL with port
		---if "deassign"---
		 WORD	channel ID
		---if "cursor"---
		 WORD	channel ID (must be a SRCSINK)
		 WORD	new state (0000h off, 0001h on)
		---if "init"---
		 WORD	channel ID (must be a SRCSINK)
		 WORD	comm port number (00h-03h)
		 WORD	UART init code
		---if "open"---
		 WORD	channel ID
		---if "position"---
		 WORD	channel ID (must be a SRCSINK)
		 WORD	position (high byte = row, low byte = column)
		---if "receive"---
		 DWORD	pointer to buffer
		---if "send"---
		 WORD	length of buffer
		 DWORD	pointer to buffer
		---if "vio"---
		 WORD	channel ID (must be a SRCSINK)
		---if "window"---
		 WORD	top left (high byte = row, low byte = column)
		 WORD	bottom right (high byte = row, low byte = column)
Return: DX:AX -> IRP structure or 0000h:0000h
SeeAlso: AH=00h"VMiX",AH=02h"VMiX"
--------T-1501-------------------------------
INT 15 - MultiDOS Plus - REQUEST RESOURCE SEMAPHORE
	AH = 01h
	AL = semaphore number (00h-3Fh)
Return: AH = status
	    00h successful
	    02h invalid semaphore number
Notes:	if the semaphore is not owned, ownership is assigned to the calling
	  task and the call returns immediately
	if the semaphore is already owned by another task, the calling task
	  is placed on a queue for the semaphore and suspended until it can
	  become owner of the semaphore
	semaphore 0 is used internally by MultiDOS to synchronize DOS access
SeeAlso: AH=02h"MultiDOS",AH=10h"MultiDOS",AH=1Bh"MultiDOS"
--------B-1502-------------------------------
INT 15 - CASSETTE - READ DATA (PC and PCjr only)
	AH = 02h
	CX = number of bytes to read
	ES:BX -> buffer
Return: CF clear if successful
	    DX = number of bytes read
	    ES:BX -> byte following last byte read
	CF set on error
	AH = status (see below)
SeeAlso: AH=00h"CASSETTE",AH=03h"CASSETTE"

Values for status:
 00h	successful
 01h	CRC error
 02h	bad tape signals
 04h	no data
 80h	invalid command
 86h	no cassette present
--------b-1502-------------------------------
INT 15 - Amstrad PC1512 - READ DATA FROM NON-VOLATILE RAM
	AH = 02h
	AL = NVRAM location (00h to 3Fh)
Return: AH = return code
	    00h OK
	    01h address bad
	    02h checksum error
	AL = NVRAM data value
SeeAlso: AH=01h"Amstrad"
--------O-1502-------------------------------
INT 15 - VMiX - "sys_memreq" - MEMORY OBJECT MANAGER
	AH = 02h
	STACK:	WORD	object ID of requestor
		DWORD	pointer to ASCIZ name of requested method
			"assign" allocate low memory block
			"assign extended" allocate extended memory pages
			"assign gdt" allocate GDT selector
			"paged" allocate low paged memory
			"paged extended" alllocate extended memory pages
			"deassign" free memory block
			"deassign gdt" free GDT selector
			"getvpage" get physical address for virtual page
			"setvpage" set physical address for virtual page
			"info" get VMiX memory usage info block
			"move" move contents of 32-bit memory
			"newmcb" make new DOS memory control block
			"owner" get process ID of MCB or PSP owner
			"umb" allocate upper memory block
			"video" toggle system use of vidoe memory and get stat
		---if "assign"---
		 WORD	number of objects
		 WORD	size in bytes (multiple of 512 bytes)
		---if "assign extended"---
		 WORD	number of objects
		 WORD	size in bytes (multiple of 4K)
		---if "assign gdt"---
		 WORD	access type (low byte)
		 WORD	segment size in paragraphs
		 DWORD	pointer to start of physical segment
		---if "paged"---
		 WORD	number of 512-byte pages
		---if "paged extended"
		 WORD	number of 4K pages
		---if "deassign"---
		 DWORD	pointer returned by previous allocation call
		---if "deassign gdt"---
		 WORD	GDT selector
		---if "getvpage"---
		 WORD	owner's process ID
		 DWORD	pointer to buffer for page structure (struct VPGE)
		---if "setvpage"---
		 WORD	owner's process ID
		 DWORD	pointer to new page structure (struct VPGE)
		---if "info"---
		 no additional arguments
		---if "move"
		 DWORD	32-bit source address
		 DWORD	32-bit destination address
		 WORD	number of words to move
		---if "newmcb"---
		 DWORD	pointer to new MCB's location
		 WORD	size of memory block
		 DWORD	pointer to ASCIZ name string (max 8 chars)
		---if "owner"---
		 WORD	MCB or PSP segment
		---if "umb"---
		 WORD	size in paragraphs
		---if "video"---
		 no additional arguments
Return: DX:AX -> memory block or VPGE struct or 0000h:0000h
SeeAlso: AH=00h"VMiX",AH=01h"VMiX"
--------T-1502-------------------------------
INT 15 - MultiDOS Plus - RELEASE RESOURCE SEMAPHORE
	AH = 02h
	AL = semaphore number (00h-3Fh)
Return: AH = status
	    00h successful
	    01h not semaphore owner
	    02h invalid semaphore number
Notes:	if any tasks are waiting for the semaphore, the first task on the wait
	  queue will become the new owner and be reawakened
	do not use within an interrupt handler
SeeAlso: AH=01h"MultiDOS",AH=10h"MultiDOS",AH=1Ch"MultiDOS"
--------B-1503-------------------------------
INT 15 - CASSETTE - WRITE DATA (PC and PCjr only)
	AH = 03h
	CX = number of bytes to write
	ES:BX -> data buffer
Return: CF clear if successful
	    ES:BX -> byte following last byte written
	CF set on error
	AH = status (see AH=02h"CASSETTE")
	CX = 0000h
SeeAlso: AH=00h"CASSETTE",AH=02h"CASSETTE"
--------V-1503-------------------------------
INT 15 - Amstrad PC1512 - WRITE VDU COLOR PLANE WRITE REGISTER
	AH = 03h
	AL = value (I,R,G,B bits)
SeeAlso: AH=04h"Amstrad"
--------O-1503-------------------------------
INT 15 - VMiX - "sys_pinput" - PROMPTED CONSOLE INPUT
	AH = 03h
	STACK:	DWORD	pointer to ASCII prompt
		WORD	field outline character
		WORD	length of input field (max 7Fh)
		DWORD	address of pointer to input buffer
Return: AX = length of input (input buffer is padded with blanks)
SeeAlso: AH=04h"VMiX"
--------T-1503-------------------------------
INT 15 - MultiDOS Plus - SUSPEND TASK FOR INTERVAL
	AH = 03h
	DX = number of time slices to remain suspended
Return: after specified interval has elapsed
Note:	when priority-based scheduling is in use, high-priority tasks should
	  use this function to yield the processor
SeeAlso: AH=00h"MultiDOS",AH=0Ah"MultiDOS"
--------B-1504-------------------------------
INT 15 - SYSTEM - BUILD ABIOS SYSTEM PARAMETER TABLE (PS)
	AH = 04h
	ES:DI -> results buffer length 20h for System Parameter Table
	DS = segment containing ABIOS RAM extensions (zero if none)
Return: AH = 00h success: results at ES:DI
	CF set on failure
SeeAlso: AH=05h"ABIOS",C1h

Format of ABIOS System Parameter Table:
Offset	Size	Description
 00h	DWORD	FAR address of ABIOS Common Start Routine
 04h	DWORD	FAR address of ABIOS Interrupt Routine
 08h	DWORD	FAR address of ABIOS Time-out Routine
 0Ch	WORD	number of bytes of stack required by this ABIOS implementation
 0Eh 16 BYTEs	reserved
 1Eh	WORD	number of entries in initialization table
--------V-1504-------------------------------
INT 15 - Amstrad PC1512 - WRITE VDU COLOR PLANE READ REGISTER
	AH = 04h
	AL = value (RDSEL1 and RDSEL0)
SeeAlso: AH=03h"Amstrad",05h"Amstrad"
--------O-1504-------------------------------
INT 15 - VMiX - "sys_vprintf" - FORMATTED OUTPUT TO STREAM
	AH = 04h
	STACK:	DWORD	control string
		DWORD	array of arguments
SeeAlso: AH=03h"VMiX"
--------T-1504-------------------------------
INT 15 - MultiDOS Plus - SEND MESSAGE TO ANOTHER TASK
	AH = 04h
	AL = mailbox number (00h-3Fh)
	CX = message length in bytes
	DS:SI -> message
Return: AH = status
	    00h successful
	    01h out of message memory
	    02h invalid mailbox number
Note:	the message is copied into a system buffer; the caller may immediately
	  reuse its buffer
SeeAlso: AH=05h"MultiDOS"
--------B-1505-------------------------------
INT 15 - SYSTEM - BUILD ABIOS INITIALIZATION TABLE (PS)
	AH = 05h
	ES:DI -> results buffer length (18h * Number_of_Entries)
	DS = segment containing ABIOS RAM extensions (zero if none)
Return: AH = 00h success: results at ES:DI
	CF set on failure
SeeAlso: AH=04h"ABIOS",C1h

Format of one entry of ABIOS Initialization Table:
Offset	Size	Description
 00h	WORD	device ID
 02h	WORD	number of Logical IDs
 04h	WORD	Device Block length (zero for ABIOS patch or extension)
 06h	DWORD	-> init routine for Device Block and Function Transfer Table
 0Ah	WORD	request block length
 0Ch	WORD	Function Transfer Table length (zero for a patch)
 0Eh	WORD	Data Pointers length (in Common Data Area)
 10h	BYTE	secondary device ID (hardware level this ABIOS ver supports)
 11h	BYTE	revision (device driver revision level this ABIOS supports)
 12h  6 BYTEs	reserved
--------V-1505-------------------------------
INT 15 - Amstrad PC1512 - WRITE VDU GRAPHICS BORDER REGISTER
	AH = 05h
	AL = value (I,R,G,B bits)
SeeAlso: AH=04h"Amstrad"
--------O-1505-------------------------------
INT 15 - VMiX - "sys_getpid" - GET PROCESS ID OF CURRENT PROCESS
	AH = 05h
Return: AX = process ID
SeeAlso: AH=06h"VMiX",AH=0Bh"VMiX"
--------T-1505-------------------------------
INT 15 - MultiDOS Plus - CHECK MAILBOX
	AH = 05h
	AL = mailbox number (00h-3Fh)
Return: AH = status
	    00h successful
		DX = length of first message in queue, 0000h if no message
	    02h invalid mailbox number
SeeAlso: AH=04h"MultiDOS",AH=06h"MultiDOS"
--------b-1506-------------------------------
INT 15 - Amstrad PC1512 - GET ROS VERSION NUMBER
	AH = 06h
Return: BX = version number
--------O-1506-------------------------------
INT 15 - VMiX - "sys_getpcb" - GET POINTER TO PROCESS CONTROL BLOCK
	AH = 06h
	STACK:	WORD	process ID
Return: DX:AX -> process control block
SeeAlso: AH=05h"VMiX",AH=07h"VMiX",AH=08h"VMiX"
--------T-1506-------------------------------
INT 15 - MultiDOS Plus - READ MAILBOX
	AH = 06h
	AL = mailbox number (00h-3Fh)
	CX = size of buffer in bytes
	ES:DI -> buffer for message
Return: AH = status
	    00h successful
		CX = number of bytes copied
		DX = actual length of message
	    02h invalid mailbox number
Note:	if the caller's buffer is not large enough, the message is truncated
	  and the remainder is lost
SeeAlso: AH=04h"MultiDOS",AH=05h"MultiDOS"
--------O-1507-------------------------------
INT 15 - VMiX - "sys_getocb" - GET POINTER TO OBJECT CONTROL BLOCK
	AH = 07h
	STACK:	WORD	object type
Return: DX:AX -> object control block
SeeAlso: AH=06h"VMiX",AH=08h"VMiX"
--------T-1507-------------------------------
INT 15 - MultiDOS Plus - SPAWN INTERNAL TASK (CREATE NEW THREAD)
	AH = 07h
	BX:CX = entry point of new task
	DX = stack size in paragraphs
Return: AH = status
	    00h successful
	    01h no free task control blocks
	    02h no free memory for task's stack
Note:	execution returns immediately to calling task
SeeAlso: AH=08h"MultiDOS",AH=09h"MultiDOS",AH=13h"MultiDOS"
--------O-1508-------------------------------
INT 15 - VMiX - "sys_getccb" - GET CHANNEL CONTROL BLOCK
	AH = 08h
	STACK:	WORD	channel ID
Return: DX:AX -> channel control block
SeeAlso: AH=06h"VMiX",AH=07h"VMiX"
--------T-1508-------------------------------
INT 15 - MultiDOS Plus - TERMINATE INTERNAL TASK (KILL THREAD)
	AH = 08h
Return: calling task terminated, so execution never returns to caller
Notes:	an internal task must be terminated with this function rather than a
	  DOS termination function
	task's stack space is returned to parent task's memory pool
SeeAlso: AH=07h"MultiDOS"
--------O-1509-------------------------------
INT 15 - VMiX - "sys_getqueue" - GET ID OF QUEUED ELEMENT
	AH = 09h
	STACK:	WORD	queue ID (0 = process queue, 1 = object, 3 = type)
		WORD	subqueue ID
Return: AX = queue ID
SeeAlso: AH=0Ah"VMiX"
--------T-1509-------------------------------
INT 15 - MultiDOS Plus - CHANGE TASK'S PRIORITY
	AH = 09h
	AL = new priority
Note:	the priority has different meanings depending on whether priority-
	  based or round-robin scheduling is used
SeeAlso: AH=07h"MultiDOS"
--------O-150A-------------------------------
INT 15 - VMiX - "sys_qetqnext" - GET ID OF NEXT QUEUED ELEMENT
	AH = 0Ah
	STACK:	WORD	queue ID (0 = process queue, 1 = object, 3 = type)
		WORD	ID of current element in queue chain
Return: AX = ID of next element
SeeAlso: AH=09h"VMiX",AH=0Fh"VMiX"
--------T-150A-------------------------------
INT 15 - MultiDOS Plus - CHANGE TIME SLICE INTERVAL
	AH = 0Ah
	AL = new interval
	    00h = 55.0 ms (default)
	    80h = 27.5 ms
	    40h = 13.75 ms
	    20h = 6.88 ms
	    10h = 3.44 ms
	    08h = 1.72 ms
SeeAlso: AH=03h"MultiDOS"
--------O-150B-------------------------------
INT 15 - VMiX - "sys_sysreq" - SYSTEM CONFIGURATION MANAGER
	AH = 0Bh
	STACK:	WORD	caller's UID
		DWORD	pointer to ASCIZ name of requested method
			"abort" abort current send/receive on comm port
			"block" start/end critical section
			"close" terminate interrupt-drive comm I/O
			"open" prepare comm port for interrupt-driven I/O
			"delay" set delay timer and wait
			"hibernate" put process to sleep
			"ints" enable/disable interrupt-driven INT 14h
			"length" get current send/receive buffer offsets
			"kswitch" switch stacks
			"numproc" get number of active processes
			"protocol" set protocol function for comm interrupts
			"relocate" set/reset VMiX flag for relocating to himem
			"status" get current open comm port status
			"wake" awaken a process
			"xport" get comm port polled for logins
		---if "abort"---
		 no additional arguments
		---if "block"---
		 WORD	0000h end, 0001h start
		---if "close"---
		 no additional arguments
		---if "open"---
		 WORD	comm port (00h-03h)
		 WORD	BIOS parameter byte (see INT 14/AH=00h), except
			bits 7-5 = 000 for 19200, 001 for 38400, 011 for 115200
		---if "delay"---
		 WORD	time in seconds
		---if "hibernate"---
		 WORD	process ID
		---if "ints"---
		 WORD	0000h if no, 0001h if yes
		---if "length","numproc","relocate","status","xport"---
		 no additional arguments
		---if "kswitch"---
		 DWORD	pointer to new stack
		---if "protocol"---
		 DWORD	pointer to function (must be in low "assign"ed memory
			when in 386 mode)
		---if "wake"---
		 WORD	process ID
Return: DX:AX -> result or 0000h:0000h
		---if "length"---
		 BYTE	receive offset
		 BYTE	send offset
		---if "kswitch"---
		 DWORD	old stack pointer
		---if "numproc"---
		 WORD	number of active processes
		---if "status"---
		 current open comm port status
		---if "xport"---
		 current comm port being polled for logins
SeeAlso: AH=05h"VMiX",AH=0Eh"VMiX"
--------T-150B-------------------------------
INT 15 - MultiDOS Plus - FORCE DISPLAY OUTPUT TO PHYSICAL SCREEN MEMORY
	AH = 0Bh
Notes:	sets calling task's screen pointer to actual screen memory; the pointer
	  may be restored with AH=0Ch
	caller's video mode must be same as foreground task's video mode
	any text written while in the background will be saved to the
	  foreground task's virtual screen when it switches to the background
	useful if a background task wants to display a message on the
	  foreground screen
SeeAlso: AH=0Ch"MultiDOS"
--------O-150C-------------------------------
INT 15 - VMiX - "sys_getstack" - GET POINTER TO PROCESS TSS STACK
	AH = 0Ch
	STACK:	WORD	process ID
Return: DX:AX -> TSS stack store
SeeAlso: AH=00"VMiX"
--------T-150C-------------------------------
INT 15 - MultiDOS Plus - RESTORE OLD VIDEO DISPLAY MEMORY
	AH = 0Ch
Note:	restores task's screen pointer saved by AH=0Bh; must not be called
	  unless AH=0Bh has been called first
SeeAlso: AH=0Bh"MultiDOS"
--------O-150D-------------------------------
INT 15 - VMiX - "sys_spawn" - START A CHILD PROCESS JOB SHELL
	AH = 0Dh
	STACK:	DWORD	ASCIZ string starting with requested I/O channel and
			followed by standard VMiX shell command string
Return: AX = process ID or error code "SYS_ERROR"
Note:	the maximum string length is 7Fh characters
SeeAlso: AH=0Eh"VMIX",AH=11h"VMiX",INT 21/AH=4Bh
--------T-150D-------------------------------
INT 15 - MultiDOS Plus - DISABLE MULTITASKING
	AH = 0Dh
Note:	calling task receives all time slices until AH=0Eh is called; this
	  allows time-critical events or nonreentrant code to be processed
SeeAlso: AH=0Eh"MultiDOS",AH=10h"MultiDOS",AX=101Bh,AH=20h"MultiDOS"
--------O-150E-------------------------------
INT 15 - VMiX - "sys_kill" - HARD TERMINATE PROCESS
	AH = 0Eh
	STACK:	WORD	process ID
Return: AX = status (SYS_OK or SYS_ERROR)
SeeAlso: AH=0Bh"VMiX",AH=0Dh"VMIX"
--------T-150E-------------------------------
INT 15 - MultiDOS Plus - ENABLE MULTITASKING
	AH = 0Eh
SeeAlso: AH=0Dh"MultiDOS",AX=101Ch,AH=20h"MultiDOS"
--------d-150F-------------------------------
INT 15 C - SYSTEM - FORMAT UNIT PERIODIC INTERRUPT (PS ESDI drives only)
	AH = 0Fh
	AL = phase code
	    00h reserved
	    01h surface analysis
	    02h formatting
Return: CF clear if formatting should continue, set if it should terminate
Note:	called during ESDI drive formatting after each cylinder is completed
SeeAlso: INT 13/AH=1Ah
--------O-150F-------------------------------
INT 15 - VMiX - "sys_getqkey" - GET KEY FIELD OF QUEUED ELEMENT
	AH = 0Fh
	STACK:	WORD	queue ID (0 = process queue, 1 = object q, 3 = type q)
		WORD	ID of element in queue chain
Return: AX = key
SeeAlso: AH=0Ah"VMiX"
--------T-150F-------------------------------
INT 15 - MultiDOS Plus - EXECUTE A MULTIDOS PLUS COMMAND
	AH = 0Fh
	DS:BX -> ASCIZ command
Return: after command has been processed
Notes:	specified string is executed as if it had been typed at the MultiDOS
	  command prompt
	the task is placed on a queue which MultiDOS examines periodically and
	  is suspended until MultiDOS has processed the command
	all lowercase characters up to the first blank are converted to upper
	  case within the given buffer
--------O-1510-------------------------------
INT 15 - VMiX - "sys_virtual" - EXECUTE CONFORMING FUNCTION IN PROTECTED MODE
	AH = 10h
	STACK:	DWORD	pointer to function
	      N WORDs	function args
Return: AX = function's return value??? (not specified in documentation)
Note:	while the function is executing, the following global descriptors are
	  available:
		20h stack segment
		38h code segment of function
		40h data alias for function's code segment
	  additional GDT descriptors can be allocated using AH=02h with
	  function "assign gdt"
SeeAlso: AH=02h"VMiX",AH=51h"VMiX"
--------T-1510-------------------------------
INT 15 - MultiDOS Plus - TEST RESOURCE SEMAPHORE
	AH = 10h
	AL = semaphore number (00h-3Fh)
Return: AH = status
	    00h semaphore not in use
	    01h semaphore owned by another task
	    02h invalid semaphore number
	    03h semaphore owned by caller
SeeAlso: AH=02h"MultiDOS",AH=0Dh"MultiDOS",AH=1Dh"MultiDOS"
--------Q-151000-----------------------------
INT 15 - TopView - "PAUSE" - GIVE UP CPU TIME
	AX = 1000h
Return: after other processes run
Note:	under DESQview, if the process issuing this call has hooked INT 08h,
	  the current time-slice is set to expire at the next clock tick rather
	  than immediately
SeeAlso: AH=00h"MultiDOS",AX=5305h,INT 21/AH=89h,INT 21/AH=EEh"DoubleDOS"
SeeAlso: INT 2F/AX=1680h,INT 60/DI=0106h,INT 62/AH=01h,INT 7A/BX=000Ah
SeeAlso: INT 7F/AH=E8h
--------Q-151001-----------------------------
INT 15 - TopView - "GETMEM" - ALLOCATE "SYSTEM" MEMORY
	AX = 1001h
	BX = number of bytes to allocate
Return: ES:DI -> block of memory or 0000h:0000h (DV v2.26+)
	AX = status (DV v2.42)
	    0000h successful
	    0001h failed
Note:	use SETERROR (AX=DE15h) to avoid a user prompt if there is insufficient
	  common memory.  Under DV v2.42, this call never generates a user
	  prompt regardless of the SETERROR value; instead, it always returns
	  AX=0001h and ES:DI=0000h:0000h if out of memory
SeeAlso: AX=1002h,AX=102Eh,AX=DE0Ch,AX=DE15h
--------Q-151002-----------------------------
INT 15 - TopView - "PUTMEM" - DEALLOCATE "SYSTEM" MEMORY
	AX = 1002h
	ES:DI -> previously allocated block
Return: block freed
SeeAlso: AX=1001h,AX=DE0Dh
--------Q-151003-----------------------------
INT 15 - TopView - "PRINTC" - DISPLAY CHARACTER/ATTRIBUTE ON SCREEN
	AX = 1003h
	BH = attribute
	BL = character
	DX = segment of object handle for window
Note:	BX=0 does not display anything, it only positions the hardware cursor
--------Q-1510-------------------------------
INT 15 - TopView - UNIMPLEMENTED IN DV 2.x
	AH = 10h
	AL = 04h thru 12h
Return: pops up "Programming error" window in DV 2.x
--------Q-151013-----------------------------
INT 15 - TopView - "GETBIT" - DEFINE A 2ND-LEVEL INTERRUPT HANDLER
	AX = 1013h
	ES:DI -> FAR service routine
Return: BX = bit mask indicating which bit was allocated
	     0000h if no more bits available
SeeAlso: AX=1014h,AX=1015h
Note:	only a few TopView/DESQview API calls are allowed during a hardware
	  interrupt; if other calls need to be made, the interrupt handler
	  must schedule a 2nd-level interrupt with "SETBIT" (AX=1015h)
--------Q-151014-----------------------------
INT 15 - TopView - "FREEBIT" - UNDEFINE A 2ND-LEVEL INTERRUPT HANDLER
	AX = 1014h
	BX = bit mask from INT 15/AX=1013h
SeeAlso: AX=1013h,AX=1015h
--------Q-151015-----------------------------
INT 15 - TopView - "SETBIT" - SCHEDULE ONE OR MORE 2ND-LEVEL INTERRUPTS
	AX = 1015h
	BX = bit mask for interrupts to post
Return: indicated routines will be called: (DV 2.0x) at next task switch
					   (DV 2.2x) immediately on return from
						     hardware interrupt
SeeAlso: AX=1013h,AX=1014h
Notes:	this is one of the few TopView calls which are allowed from a hardware
	  interrupt handler
	the handler will be called with ES containing the segment of the handle
	  of the next task to be executed; on return, ES must be the segment of
	  a task handle
--------Q-151016-----------------------------
INT 15 - TopView - "ISOBJ" - VERIFY OBJECT HANDLE
	AX = 1016h
	ES:DI = possible object handle
Return: BX = FFFFh if ES:DI is a valid object handle
	     0000h if ES:DI is not
Note:	under DESQview versions prior to 2.50, an object handle is always a
	  pointer to the object; for versions 2.50 and up, only task handles
	  are always pointers (other handles may consist of a unique object
	  number and offset into DESQview's common memory)
SeeAlso: AX=DE14h,AX=DE2Bh,AX=DE2Ch

Format of object:
Offset	Size	Description
 00h	WORD	offset in common memory of previous object of same type
 02h	WORD	offset in common memory of next object of same type
 04h	WORD	signature FEDCh (DV 2.42-)
		signature FEDCh or object number (DV 2.50+)
 06h	WORD	object type
		00h window/task
		01h mailbox
		02h keyboard
		03h timer
		04h pointer
		05h panel
		06h objectq
 08h	DWORD	object handle to return to caller
 0Ch	DWORD	canonicalized object address (segment = common memory)
 10h	WORD	offset in common memory of owning task
		(0000h for unowned OBJECTQs)
 12h	WORD	mapping context
		offset in common memory of mapping context record (see below)
	remainder varies by object type and DESQview version
---v2.42 keyboard object---
 14h	WORD	flag bits (see also AH=12h/BH=0Ah"OBJECT")
		bit 15: keyboard opened
 16h  4 BYTEs	???
 1Ah	WORD	priority in OBJECTQ???
 1Ch	...
 25h	WORD	offset in common memory of ??? task
 27h  4 BYTEs	???
---v2.42 objectq object---
 14h	WORD	flag bits (see also AH=12h/BH=0Ah"OBJECT")
		bit 15: OBJECTQ opened
 16h  2 BYTEs	???
 18h	WORD	offset in common memory of ??? task
 1Ah  6 BYTEs	???
---v2.42 mailbox object---
 14h	WORD	flag bits (see also AH=12h/BH=0Ah"OBJECT")
		bit 15: mailbox opened
 1Ah	WORD	priority in OBJECTQ???
 1Ch  6 BYTEs	???
 22h	WORD	offset in common memory of mailbox name (counted string)
		0000h if no name
     <= 5 BYTEs ???
---v2.22-2.42,2.52,2.60 window/task object---
 14h	BYTE	00h window, 01h task
 15h	BYTE	internal (not Switch menu) window number???
 16h	BYTE	internal (not Switch menu) window number???
 17h	WORD	segment of internal window record (see below)
 19h  2 BYTEs	???
 1Bh	BYTE	cursor row
 1Ch	BYTE	cursor column
 1Dh	BYTE	visible window origin, row
 1Eh	BYTE	visible window origin, column
 1Fh	BYTE	window height (logical)
 20h	BYTE	window width (logical)
 21h	BYTE	window position, row
 22h	BYTE	window position, column
 23h	BYTE	window height (visible)
 24h	BYTE	window width (visible)
 25h	BYTE	row of top of frame (or window if unframed)
 26h	BYTE	column of left of frame (or window if unframed)
 27h	BYTE	window height (physical, including frame)
 28h	BYTE	window width (physical, including frame)
 29h	BYTE	unzoomed visible origin, row (00h before first zoom)
 2Ah	BYTE	unzoomed visible origin, column (00h before first zoom)
 2Bh	BYTE	unzoomed window position, row (00h before first zoom)
 2Ch	BYTE	unzoomed window position, column (00h before first zoom)
 2Dh	BYTE	unzoomed window height (00h before first zoom)
 2Eh	BYTE	unzoomed window width (00h before first zoom)
		unzoomed parameters above are updated when window is zoomed
		to full	screen
 2Fh	BYTE	??? initially logical window height
 30h	BYTE	??? initially logical window width
 31h  2 BYTEs	???
 33h	BYTE	minimum height of window
 34h	BYTE	minimum width of window
 35h	BYTE	maximum height of window
 36h	BYTE	maximum width of window
 37h  3 BYTEs	???
 3Ah  8 BYTEs	window frame characters: ul,ur,ll,lr,t,b,l,r
 42h 24 BYTEs	attributes???
 5Ah  8 BYTEs	window frame characters: ul,ur,ll,lr,t,b,l,r
 62h  3 BYTEs	???
 65h	BYTE	??? bitflags
 66h	BYTE	bit 0: window is zoomed
 67h	BYTE	???
 68h	WORD	offset in common memory of window name or 0000h if untitled
 6Ah	WORD	length of window name
 6Ch  2 BYTEs	???
 6Eh	WORD	offset of logical cursor in window (in character cells)
 70h	DWORD	pointer to field table for window
 74h	BYTE	???
 75h  2 BYTEs	???
 77h	BYTE	number of last-visited field
 78h	DWORD	pointer to field table entry for last-visited field
 7Ch  3 BYTEs	???
 7Fh	BYTE	select field marker character
 80h	BYTE	??? bit flags
		bit 0: allow ECh window stream opcode to change reverse logattr
		bit 1: alternate field processing mode selected
 81h	BYTE	???
 82h	DWORD	notification function (manager stream opcode 8Ah)
		no notification if segment = 0000h
 86h	DWORD	notification argument (manager stream opcode 8Bh)
 8Ah	WORD	offset in common memory of ??? window object or 0000h
 8Ch	WORD	offset in common memory of ??? window object or 0000h
 8Eh	WORD	offset in common memory of ??? window object or 0000h
 90h	BYTE	??? bitflags
 91h	BYTE	???
 ---task object only
 92h	BYTE	bit flags (bits 0-4)
 93h	BYTE	character for ??? (default 20h)
 94h	BYTE	??? flag
 95h	WORD	offset in common memory of ???
 97h  2 BYTEs	???
 99h	WORD	???
 9Bh	BYTE	??? bit flags
		bit 3: ???
		bit 6: perform protected-attribute processing on select fields
 9Ch	BYTE	???
 9Dh	WORD	offset in common memory of current register save record
		(see below).  No register save record in use if < 01C0h
 9Fh	WORD	offset in common memory of task's keyboard object
 A1h	WORD	offset in common memory of task's OBJECTQ object
 A3h	WORD	offset in common memory of task's mailbox object
 A5h	WORD	semaphore: FFFFh if on user stack, else on task's private stack
 A7h	DWORD	user's SS:SP
 ABh	WORD	task's private SP (SS read from offset 0Ah)
 ADh  6 BYTEs	???
 B3h	BYTE	??? bit flags
		bit 0: run in foreground only
 B4h	BYTE	???
 B5h	BYTE	??? bitflags
 B6h	BYTE	task status (see AX=DE2Ch)
 B7h  9 BYTEs	???
 C0h	WORD	head pointer for keyboard buffer (wraps back to 00h after 80h)
 C2h	WORD	tail pointer for keyboard buffer (wraps back to 00h after 80h)
 C4h  2 BYTEs	??? (0000h)
 C6h	WORD	segment of keyboard buffer for task
 C8h	WORD	offset in common memory of ??? keyboard object
 CAh	BYTE	???
---v2.22-2.42
 CBh	WORD	offset in common memory of ??? object
 CEh	BYTE	??? flag
 CFh	WORD	offset in common memory of default notify window for task
		or 0000h if none
 D1h  4 BYTEs	???
 D5h	BYTE	window number on Switch Window menu
 D6h  5 BYTEs	???
 DBh	WORD	offset in common memory of ??? object
 DDh  2 BYTEs	???
 DFh	WORD	API level for task
 E1h	WORD	offset in common memory of object task is waiting on if task
		status is 'waiting', else 0000h
 E7h	WORD	segment of ???
 E9h 4	BYTEs	???
 EDh	WORD	EMS handle of virtualization buffer, 0000h if no virtualization
 F1h 12 BYTEs	???
 FBh	WORD	???
 FDh	BYTE	???
 FFh 12 BYTEs	???
10Bh	DWORD	pointer to process record (see below)
10Dh 10 BYTEs	???
119h	DWORD	SS:SP for ???
11Dh  4 BYTEs	???
121h	DWORD	pointer to ???
125h 25 BYTEs	???
13Eh	DWORD	pointer to ??? in system memory
---v2.22
142h  3 BYTEs	???
145h		task's default keyboard object
---v2.42
142h	DWORD	pointer to first task instance data record in system memory
148h	DWORD	pointer to last task instance data record in system memory
		(see below)
14Ah	BYTE	???
14Dh 42 BYTEs	task's default keyboard object
177h 32 BYTEs	task's ObjectQ object
197h 41 BYTEs	task's default mailbox object
1C0h 24 BYTEs	first register save record
450h	--	default top of private stack
---v2.52 (probably all DV/X)
Same as v2.60 below except there is an extra 29 bytes inserted somewhere
  before offset 9Fh, but not yet known exactly where.  Also, for the WAIT_ON
  field (v2.60 offset E3h), some X apps (probably waiting on a socket) have
  0000h even when waiting.
---v2.60
 CBh	WORD	??? (added in 2.50 - rest is same as 2.42)
 CDh	WORD	offset in common memory of ??? object
 D0h	BYTE	??? flag
 D1h	WORD	offset in common memory of default notify window for task
		or 0000h if none
 D3h  4 BYTEs	???
 D7h	BYTE	window number on Switch Window menu
 D8h  5 BYTEs	???
 DDh	WORD	offset in common memory of ??? object
 DFh  2 BYTEs	???
 E1h	WORD	API level for task
 E3h	WORD	If status at B6h=waiting, offset in common memory of object
		that task is waiting on, else 0000h. (Task with CPU also
		has 0000h here)
 E9h	WORD	segment of ???
 EBh 4	BYTEs	???
 EFh	WORD	EMS handle of virtualization buffer, 0 if no virtualization
 F3h 12 BYTEs	???
 FDh	WORD	???
 FFh	BYTE	???
101h  8 BYTEs	???
109h	DWORD	pointer to process record in system memory
10Dh 14 BYTEs  ???
11Bh	DWORD	SS:SP for ???
11Fh  4 BYTEs	???
123h	DWORD	pointer to ???
127h 25 BYTEs	???
140h	DWORD	pointer to ??? in system memory
144h	DWORD	pointer to first task instance data record in system memory
148h	DWORD	pointer to last task instance data record in system memory
		 (from INT 15/AX=DE27h, see below)
14Ch	BYTE	???
14Eh 42 BYTEs	task's default keyboard object
179h 32 BYTEs	task's ObjectQ object
199h 41 BYTEs	task's default mailbox object
1C2h 24 BYTEs	first register save record
452h	--	default top of private stack

Format of Register Save Record:
Offset	Size	Description
 00h	WORD	AX
 02h	WORD	BX
 04h	WORD	CX
 06h	WORD	DX
 08h	WORD	DI
 0Ah	WORD	SI
 0Eh	WORD	DS
 10h	WORD	ES
 12h	DWORD	return address
 16h	WORD	original flags

Format of mapping context record:
Offset	Size	Description
 00h	WORD	lowest segment in process's memory
		(often start of system memory chain)
 02h	WORD	size of process's memory in paragraphs
 04h	BYTE	flag: 00h if process swapped out, 01h otherwise
 05h	BYTE	flag: 00h if allocated in conventional memory, 01h if EMS
 06h  2 BYTEs	???
 08h	WORD	EMS handle if in EMS, else 0
 0Ah  2 BYTEs	??? (nonzero if system memory resides in shared mem???)
 0Ch	WORD	segment of system memory block that contains process record,
		referenced from segment of start of system memory chain
 0Eh	BYTE	???
 0Fh	WORD	size of system memory block that contains process record
		and DOS memory in paragraphs
 11h	BYTE	bit flags
		Bit 0: Swapped out???
		Bit 1: ???
		Bit 2: Swapped out???
 12h	BYTE	???
 13h	BYTE	reference count
 ---v2.31
 14h 10 BYTEs	???
 1Eh	WORD	segment of process record
 20h  2 BYTEs	???
 22h	WORD	segment of ???	(in first free system memory block???)
 24h	WORD	segment of end of system memory chain
 26h	WORD	segment of start of system memory chain
 28h  8 BYTEs	???
 2Ah	DWORD	pointer to ??? (process record???)
 2Dh 10 BYTEs	???
 37h	BYTE	lowest interrupt vector to save on context switch
 38h	BYTE	highest interrupt vector to save on context switch
 39h	WORD	offset in common memory of main task with this context
 3Ah 12 BYTEs	???
 46h	BYTE	internal mapping context number
 47h 12 BYTEs	???
 ---v2.5x-2.60
 14h  6 BYTEs	???
 1Ah	WORD	segment of process record
 1Ch  2 BYTEs	???
 1Eh	WORD	segment of first free system memory block
 20h	WORD	segment of start of system memory chain
 22h	WORD	segment of end of system memory chain
 24h 8	BYTEs	???
 2Ch	DWORD	pointer to ??? (1 segment into process record???)
 30h 3	BYTEs	???
 33h	WORD	Offset in common memory of main task with this context
 35h 7	BYTEs	???
 3Ch	BYTE	internal mapping context number
 3Dh 14 BYTEs	???
 4Bh	WORD	first DOS memory segment (first MCB segment+1)
 4Dh	BYTE	??? (flag???)
 ---v2.53 (2.5x???)
 4Eh 12 BYTEs	???
 ---v2.60
 4Eh	WORD	segment of script buffer (see below)
 50h  6 BYTEs	???

Format of Internal Window Record (v2.31-2.60):
Offset	Size	Description
 00h	BYTE	internal window number???
 01h	BYTE	display page???
 02h	BYTE	video mode
 03h  3 BYTEs	???
 06h	BYTE	logical window height
 07h	BYTE	logical window width
 08h	DWORD	pointer to text video buffer
 0Ch 116 BYTEs	???

Format of process record (v2.31):
Offset	Size	Description
-470h 13 BYTEs	filename of ??? Script
-463h 1117 BYTEs ??? (script buffer???)
 -6h  6 BYTEs	???
 00h	WORD	segment of parent PSP in process
 02h  5 BYTEs	???
 07h	WORD	segment of current PSP in process
 09h	WORD	segment of first MCB in process
 0Bh 13 BYTEs	???
 18h 1024 BYTEs process's interrupt vector table
418h 376 BYTEs	???
590h		first MCB in process

Format of process record (v2.53-v2.60) (probably also 2.5x):
Offset	Size	Description
 00h 28 BYTEs	EXE header of last EXE, ??? if last program run was COM
 1Ch ??? BYTEs	overwritten with ASCIZ filename of last program run (EXE/COM)
11Ch	WORD	segment of parent PSP in process
11Eh  4 BYTEs	???
122h	WORD	segment of current PSP
124h	WORD	segment of current PSP
126h	WORD	segment of first MCB in process
128h  4 BYTEs	???
12Ch	DWORD	pointer to first process instance data record in system memory
130h	DWORD	pointer to last process instance data record in system memory
		(from INT 15/AX=DE27h, see below)
134h  8 BYTEs	???
13Ch	WORD	size of current environment
13Eh	WORD	segment of current environment
140h	WORD	segment of current PSP
142h	DWORD	entry point of current program
146h 10 BYTEs	???
---v2.52 (v2.5x???)
150h	BYTE	???
151h	WORD	segment of parent PSP in process
153h	WORD	???
155h	WORD	???
157h	WORD	???
159h  4 BYTEs	???
15Dh	WORD	segment of current environment
15Fh	WORD	segment of current PSP
161h	WORD	segment of ???
162h	WORD	???
164h  3 BYTEs	???
168h 1024 BYTEs process's interrupt vector table
568h 120 BYTEs	???
5E0h		first MCB in process
---v2.60
150h	WORD	segment of parent PSP in process
152h	WORD	???
154h	WORD	???
156h	WORD	???
158h  4 BYTEs	???
15Ch	WORD	segment of current environment
15Eh	WORD	segment of current PSP
160h	WORD	segment of ???
162h	WORD	???
164h 1024 BYTEs process's interrupt vector table
564h 108 BYTEs	???
5D0h		first MCB in process

Format of task or process instance data record (v2.5x???, v2.60):
Offset	Size	Description
 00h	DWORD	pointer to next record of same type or 00000000
 04h	DWORD	pointer to previous record of same type or 00000000
 08h	DWORD	pointer to source area of memory during restore state
 0Ch	WORD	number of bytes to save/restore
 0Eh	DWORD	pointer to destination area of memory during restore state
 12h	WORD	??? (0)
 14h  N BYTEs	source memory buffer during restore state

Format of script buffer (v2.60):
Offset	Size	Description
 00h 13 BYTEs	ASCIZ Script filename
 0Dh 80 BYTEs	???
 5Eh  N BYTEs	script records (see below)

Format of one script record (v2.60):
Offset	Size	Description
 00h	BYTE	signature 12h
 01h 18 BYTEs	blank-padded script name
 13h	BYTE	ASCII code of key attached to script or 0 if non-ASCII key
 14h	BYTE	scan code of key attached to script if non-ASCII, else 0
 15h	BYTE	???
 16h	WORD	size of script in bytes
 18h  N	BYTEs	script (ASCII code of each keystroke; if 0, next byte is
		scan code of non-ASCII key)

Format of Common Memory Header (v2.31-2.60) (at beginning of commom mem seg):
Offset	Size	Description
 00h	WORD	offset of lowest used block
 02h	WORD	bytes of commom memory, including header
 04h	WORD	offset of first free block
 06h  N BYTEs	size depends of DV version, ??? (DVP buffer???)

Format of Free block header:
Offset	Size	Description
 00h	WORD	size of block in bytes including header
 02h	WORD	offset of next free block
 04h  N BYTEs	free block

Format of Used block header:
Offset	Size	Description
 00h	WORD	size of block in bytes including header
 02h  N BYTEs	used block
--------Q-151017-----------------------------
INT 15 - TopView - UNIMPLEMENTED IN DV 2.x
	AX = 1017h
Return: pops up "Programming error" window in DV 2.x
--------Q-151018-----------------------------
INT 15 - TopView - "LOCATE" - FIND WINDOW AT A GIVEN SCREEN LOCATION
	AX = 1018h
	BH = column
	BL = row
	ES = segment of object handle for window below which to search
	     0000h = start search with topmost window
Return: ES = segment of object handle for window which is visible at the
	       indicated position, or covered by indicated window
	   = 0000h no window
SeeAlso: AX=1023h,AX=1024h
--------Q-151019-----------------------------
INT 15 - TopView - "SOUND" - MAKE TONE
	AX = 1019h
	BX = frequency in Hertz (0000h = silence)
	CX = duration in clock ticks (18.2 ticks/sec)
Return: immediately, tone continues to completion
Notes:	if another tone is already playing, the new tone does not start until
	  completion of the previous one.  Up to 32 tones may be queued before
	  the process is blocked until a note completes.
	in DV 2.00, the lowest tone allowed is 20 Hz
	if CX = 0, the current note is cancelled; if BX = 0 as well, all queued
	  notes are also cancelled
SeeAlso: AH=82h"HUNTER",INT 16/AH=73h
--------Q-15101A-----------------------------
INT 15 - TopView - "OSTACK" - SWITCH TO TASK'S INTERNAL STACK
	AX = 101Ah
Return: stack switched
Notes:	this call may not be nested; a second call must be preceded by a call
	  to "USTACK" (AX=1025h)
	while TopView requires many API calls to be executed while on the
	  task's internal stack, DESQview allows those calls to be executed
	  regardless of the current stack
SeeAlso: AX=1025h
--------Q-15101B-----------------------------
INT 15 - TopView - "BEGINC" - BEGIN CRITICAL REGION
	AX = 101Bh
Return: task-switching temporarily disabled
Notes:	will not task-switch until "ENDC" (AX = 101Ch) called unless task
	  voluntarily releases the CPU (upon regaining the CPU, task-switching
	  will again be disabled)
	suspends the caller until DOS is free
SeeAlso: AH=0Dh"MultiDOS",AX=101Ch,AX=DE13h,AX=DE1Ch,INT 2F/AX=1681h
SeeAlso: INT 60/DI=0602h
--------Q-15101C-----------------------------
INT 15 - TopView - "ENDC" - END CRITICAL REGION
	AX = 101Ch
Return: task-switching enabled
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=101Bh,AX=DE13h,AX=DE1Bh,INT 2F/AX=1682h,INT 60/DI=0603h
--------Q-15101D-----------------------------
INT 15 - TopView - "STOP" - STOP TASK
	AX = 101Dh
	ES = segment of object handle for task to be stopped
	     (== handle of main window for that task)
Return: indicated task will not get any CPU time until restarted with AX=101Eh
Note:	once a task has been stopped, additional "STOP"s are ignored
BUG:	in DV 2.00, this function is ignored unless the indicated task is the
	  current task
SeeAlso: AX=101Eh,AX=102Bh,AH=12h"VMiX",INT 21/AH=81h
--------Q-15101E-----------------------------
INT 15 - TopView - "START" - START TASK
	AX = 101Eh
	ES = segment of object handle for task to be started
	     (== handle of main window for that task)
Return: indicated task is started up again
Note:	once a task has been started, additional "START"s are ignored
SeeAlso: AX=101Dh,AX=102Bh,INT 21/AH=82h
--------Q-15101F-----------------------------
INT 15 - TopView - "DISPEROR" - POP-UP ERROR WINDOW
	AX = 101Fh
	BX = bit fields
	     bits 0-12: number of characters to display
	     bits 13,14: which mouse button may be pressed to remove window
			 00 = either
			 01 = left
			 10 = right
			 11 = either
	     bit 15: beep if 1
	ES:DI -> text of message
	CH = width of error window (0 = default)
	CL = height of error window (0 = default)
	DX = segment of object handle
Return: BX = status: 1 = left button, 2 = right, 27 = ESC pressed
Note:	window remains on-screen until ESC or indicated mouse button is pressed
--------Q-151020-----------------------------
INT 15 - TopView - UNIMPLEMENTED IN DV v2.00+
	AX = 1020h
Return: pops up "Programming error" window in DV v2.00+
--------Q-151021-----------------------------
INT 15 - TopView - "PGMINT" - INTERRUPT ANOTHER TASK
	AX = 1021h
	BX = segment of object handle for task to interrupt (not self)
	DX:CX -> FAR routine to jump to next time task is run
Return: nothing
Notes:	the FAR routine is entered with the current ES, DS, SI, DI, and BP
	  values, using the task's internal stack (see AX=101Ah); only SS:SP
	  needs to be preserved
	multiple PGMINTs to a single task are processed last-in first-out
	if the other task is in a DOS or DV API call, the interruption will
	  occur on return from that call
--------Q-151022BX0000-----------------------
INT 15 - TopView - "GETVER" - GET VERSION
	AX = 1022h
	BX = 0000h
Return: BX nonzero, TopView or compatible loaded
	(BL = major version, BH = minor version)
Notes:	TaskView returns BX = 0001h, DESQview v2.00+ returns BX = 0A01h
--------Q-151023-----------------------------
INT 15 - TopView - "POSWIN" - POSITION WINDOW
	AX = 1023h
	BX = segment of object handle for parent window within which to
	     position the window (0 = full screen)
	ES = segment of object handle for window to be positioned
	DL = bit flags
	     bits 0,1: horizontal position
		00 = current
		01 = center
		10 = left
		11 = right
	     bits 2,3: vertical position
		00 = current
		01 = center
		10 = top
		11 = bottom
	     bit 4: don't redraw screen if set
	     bits 5-7 not used
	CH = number of columns to offset from position specified by DL
	CL = number of rows to offset from position specified by DL
Return: nothing
--------Q-151024-----------------------------
INT 15 - TopView - "GETBUF" - GET VIRTUAL SCREEN INFO
	AX = 1024h
	BX = segment of object handle for window
	      (0 = use default)
Return: ES:DI -> virtual screen
	CX = size of virtual screen in bytes
	DL = 00h text screen
	     01h graphics screen
SeeAlso: INT 10/AH=FEh,INT 21/AH=2Bh/CX=4445h
--------Q-151025-----------------------------
INT 15 - TopView - "USTACK" - SWITCH BACK TO USER'S STACK
	AX = 1025h
Return: stack switched back
Notes:	call only after having switched to internal stack with AX=101Ah
	while TopView requires many API calls to be executed while on the
	  task's private stack, DESQview allows those calls to be executed
	  regardless of the current stack
SeeAlso: AX=101Ah
--------Q-1510-------------------------------
INT 15 - DESQview (TopView???) - UNIMPLEMENTED IN DV 2.x
	AH = 10h
	AL = 26h thru 2Ah
Return: pops up "Programming error" window in DV 2.x
--------Q-15102B-----------------------------
INT 15 - DESQview v2.00+ (TopView???) - "POSTTASK" - AWAKEN TASK
	AX = 102Bh
	BX = segment of object handle for task
Return: nothing
Note:	forces a task which is waiting on its objectq to continue by placing
	  the handle for the task on the objectq
SeeAlso: AX=101Dh,AX=101Eh,INT 21/AH=82h
--------Q-15102C-----------------------------
INT 15 - DESQview v2.00+ - "NEWPROC" - START NEW APPLICATION IN NEW PROCESS
	AX = 102Ch
	ES:DI -> contents of .PIF/.DVP file (see below)
	BX = size of .PIF/.DVP info
Return: BX = segment of object handle for new task
	     0000h on error
SeeAlso: AX=DE24h,INT 21/AH=4Bh

Format of .PIF/.DVP file:
Offset	Size	Description
 00h	BYTE	reserved (0)
 01h	BYTE	checksum of bytes 02h through 170h
 02h 30 BYTEs	blank-padded program title
 20h	WORD	maximum memory to allocate to partition in KB
 22h	WORD	minimum memory required in KB
 24h 64 BYTEs	ASCIZ program pathname
 64h	BYTE	default drive letter ('A',...)
 65h 64 BYTEs	ASCIZ default directory name
 A5h 64 BYTEs	ASCIZ program parameters
 E5h	BYTE	initial screen mode (0-7) (see also offset 189h)
 E6h	BYTE	number of text pages used
 E7h	BYTE	number of first interrupt to save
 E8h	BYTE	number of last interrupt to save
 E9h	BYTE	rows in virtual screen buffer
 EAh	BYTE	columns in virtual screen buffer
 EBh	BYTE	initial window position, row
 ECh	BYTE	initial window position, column
 EDh	WORD	system memory in KB
 EFh 64 BYTEs	ASCIZ shared program name
12Fh 64 BYTEs	ASCIZ shared program data file
16Fh	BYTE	flags1
		bit 7: writes text directly to screen
		bit 6: runs in foreground only (see also offset 184h)
		bit 5: uses math coprocessor
		bit 4: accesses system keyboard buffer directly
		bits 3-1: reserved (0)
		bit 0: swappable
170h	BYTE	flags2
		bit 6: uses command-line parameters in field at A5h
		bit 5: swaps interrupt vectors
---information unique to .DVP files---
171h  2 BYTEs	keys to use on open menu
173h	WORD	size of script buffer in bytes
175h	WORD	automatically give up CPU after this many tests for keyboard
		input in one clock tick (default 0 = never)
177h	BYTE	nonzero = "uses own colors"
178h	BYTE	nonzero if application swappable
179h  3 BYTEs	reserved (0) according to Quarterdeck documentation
		in actual .DVP files, frequently 01h
17Ch	BYTE	nonzero to automatically close on exit (see also offset 18Bh)
17Dh	BYTE	nonzero if copy-protect floppy is required
---information unique to DESQview 2.0+---
17Eh	BYTE	.DVP version number
		00h DESQview v1.2+
		01h DESQview v2.0+
		02h DESQview v2.2+
17Fh	BYTE	reserved (0)
180h	BYTE	initial number of rows in physical window
181h	BYTE	initial number of columns in physical window
182h	WORD	maximum expanded memory to allow, in KB
184h	BYTE	flags3
		bit 7: automatically assign window position
		bit 5: maximum memory value has been specified
		bit 4: disallow "Close" command
		bit 3: foreground-only when doing graphics
			set by DV 2.3+ when "Runs in Background" = "D" (undoc)
		bit 2: don't virtualize (see also offset 18Bh)
		bit 1: foreground-only during DOS calls
			set by DV 2.3+ when "Runs in Background" = "D" (undoc)
185h	BYTE	keyboard conflict level (0-4 for DV<2.26, 00h-0Fh for DV2.26+)
		bit 3: save/restore entire INT 09 handler state every taskswtch
		bit 2: take special precautions for programs which read the
			BIOS keyboard buffer directly from memory
		bit 1: never indicate keystroke available during scripts/xfers
		bit 0: only indicate keystroke available every sixth poll
186h	BYTE	number of graphics pages used
187h	WORD	extra system memory size
189h	BYTE	initial screen mode (FFh = default) (overrides offset E5h)
---information unique to DESQview 2.2+---
18Ah	BYTE	serial port usage
		FFh uses all serial ports
		00h no serial ports
		01h only COM1
		02h only COM2
18Bh	BYTE	flags4
		bit 7: automatically close application on exit if .COM or .EXE
			specified (see also offset 17Ch)
		bit 6: swappable if not using serial ports
		bit 5: start program with window hidden (v2.26+)
		bit 4: start program in background (v2.26+)
		bit 3: virtualize text (see also offset 184h)
		bit 2: virtualize graphics (see also offset 184h)
		bit 1: share CPU when foreground
		bit 0: share EGA when foreground and zoomed
18Ch	BYTE	protection level for 386 machines
18Dh 19 BYTEs	reserved (0) for regular DESQview
---information unique to DESQview/X 1.0---
18Dh	BYTE	X flags
		bits 3-7: unused (0)
		bit 2: don't display wait message when opening window
		bit 1: don't display DOS window
		bit 0: (XNEWPROC) use DOS client layer (DOS-to-X)
		       (NEWPROC) inherit DOS client layer usage
18Eh	BYTE	X keyboard behavior (0-3)
18Fh	BYTE	font scaling
		00h fixed fonts
		01h scalable fonts
190h 10 BYTEs	reserved (0)
19Ah	WORD	length of data follownig XDVP signature
19Ch  4 BYTEs	signature "XDVP"
1A0h  N BYTEs	list of variable length records (see below)

Format of variable length record:
Offset	Size	Description
 00h	WORD	length of following record, 0000h if end of record list
 02h	BYTE	record type
		01h script filename, up to 64 characters
		02h command-line parameters (allows >64 characters on cmdline)
		03h environment inheritance
		04h environment string
		05h starting window position
---types 01h,02h,04h---
 03h  N BYTEs	ASCII data
---type 03h---
 03h	BYTE	inheritance
		00h do not inherit
		01h inherit environment
---type 05h---
 03h  N BYTEs	ASCII copy of fields as typed into DVPMAN, separated by commas:
		starting row, starting column, starting height, starting width
Note:	if there are multiple occurrences of record types 01h, 02h, or 03h,
	  only the last instance of each type is used; multiple occurrences of
	  type 04h are concatenated
--------Q-15102D-----------------------------
INT 15 - DESQview v2.00+ - "KMOUSE" - KEYBOARD MOUSE CONTROL
	AX = 102Dh
	BL = subfunction
	     00h determine whether using keyboard mouse
		Return: BL = 00h using real mouse
			     01h using keyboard mouse
	     01h turn keyboard mouse on
	     02h turn keyboard mouse off
--------Q-15102E-----------------------------
INT 15 - DESQview v2.40+ - ALLOCATE SYSTEM MEMORY
	AX = 102Eh
	BX = number of bytes
Return: AX = status
	    0000h successful
		ES:DI -> allocated system memory
	    0001h failed
		ES:DI = 0000h:0000h
Note:	under DV 2.42, this call is identical to AX=1001h
SeeAlso: AX=1001h,AX=1002h,AX=DE0Ch

Format of system memory block header (one paragraph before memory block):
Offset	Size	Description
 00h	WORD	segment of next header or 0000h
 02h	WORD	segment of previous header or 0000h
 04h	WORD	size of block in paragraphs, including header
 06h	BYTE	availability flag (00h in use, 01h free)
--------Q-1511-------------------------------
INT 15 - TopView commands
	AH = 11h
	AL = various (except 17h)
Note:	in DESQview 2.x, these function calls are identical to AH=DEh, so
	  see those below
SeeAlso: AH=DEh
--------T-1511-------------------------------
INT 15 - VMiX - "sys_system" - EXECUTE SHELL SYSTEM COMMANDS
	AH = 11h
	STACK:	DWORD	pointer to ASCIZ string containing a VMiX shell
			request (max len = 127)
Return: AX = status (SYS_OK or SYS_ERROR)
SeeAlso: AH=0Ch"VMiX"
--------T-1511-------------------------------
INT 15 - MultiDOS Plus - TURN OFF AltZ TOGGLE
	AH = 11h
Note:	disables the Alt-Z MultiDOS command/program-selection hotkey
SeeAlso: AH=12h"MultiDOS"
Index:	hotkeys;MultiDOS Plus
--------Q-151117BX0000-----------------------
INT 15 - DESQview v2.20+ - "ASSERTMAP" - GET/SET MAPPING CONTEXT
	AX = 1117h
	BX = 0000h	get current mapping context without setting
	     nonzero	set new mapping context
Return: BX = mapping context in effect before call
	interrupts enabled
Notes:	this function differs from AX = DE17h for DESQview v2.20 through 2.25
	mapping contexts determine conventional-memory addressability; setting
	  a mapping context ensures that the associated program and data areas
	  are in memory for access.  Usable by drivers, TSRs and shared
	  programs.
	caller need not be running under DESQview, but must ensure that the
	  stack in use will not be mapped out by the call
SeeAlso: AX=DE17h,INT 2F/AX=1685h
--------m-1511DE-----------------------------
INT 15 - DESQview - QEXT.SYS - INSTALLATION CHECK
	AX = 11DEh
Return: CF clear if installed
	    AX = segment at which QEXT.SYS is located
Desc:	QEXT.SYS is Quarterdeck's HMA manager for DESQview; more recent
	  versions also implement the XMS standard
Note:	a private entry point may be found by searching the beginning of the
	  returned segment for the signature string
	  "QUARTERDECK EXTENDED MEMORY MANAGER 286"; the word immediately
	  prior to the signature contains the QEXT version number in BCD,
	  and the word prior to that contains the offset within the QEXT
	  code segment of the private entry point
SeeAlso: INT 2F/AX=4310h,INT 67/AH=3Fh

Call private entry point with:
	AH = 00h ???
	AH = nonzero ???
--------T-1512-------------------------------
INT 15 - VMiX - "sys_sleep" - PUT PROCESS TO SLEEP
	AH = 12h
	STACK:	WORD	process ID
Return: AX = status (SYS_OK or SYS_ERROR)
SeeAlso: AH=03h"MultiDOS",AX=101Dh,AH=13h"VMiX"
--------T-1512-------------------------------
INT 15 - MultiDOS Plus - TURN ON AltZ TOGGLE
	AH = 12h
Note:	enables the Alt-Z MultiDOS command/program-selection hotkey
SeeAlso: AH=11h"MultiDOS"
Index:	hotkeys;MultiDOS Plus
--------Q-1512--BH00-------------------------
INT 15 - TopView - SEND MESSAGE - "HANDLE" - RETURN OBJECT HANDLE
	AH = 12h
	BH = 00h
	BL = which handle to return
	    00h handle in DWORD on top of stack
	    01h current task's window handle
	    02h given task's mailbox handle (task's handle on stack)
	    03h current task's mailbox handle
	    04h given task's keyboard handle (task's handle on stack)
	    05h current task's keyboard object handle
	    06h given task's OBJECTQ handle (task's handle on stack)
	    07h current task's OBJECTQ handle
	    08h	  \
	      thru > return 0000:0000 under DV < 2.26
	    10h	  /
	    0Ch (2.26+) task owning object with handle in DWORD on top of stack
	    0Dh (2.26+) task handle of owner (parent) of current task
Return: DWORD on top of stack is object handle
Note:	BL=0Ch,0Dh returns 00000000h if the object is not open (keyboard,
	  mailbox, panel, pointer, and timer objects) or is an orphan (task,
	  window)
SeeAlso: AH=12h/BH=02h,AH=12h/BH=80h
--------Q-1512--BH01-------------------------
INT 15 - TopView - SEND MESSAGE - "NEW" - CREATE NEW OBJECT
	AH = 12h
	BH = 01h
	BL = object type to create
	    00h (DV 2.0x only) handle is DWORD on top of stack
	    01h (DV 2.0x only) use task's window handle
	    02h (DV 2.0x only) given task's mailbox (task's handle on stack)
	    03h (DV 2.0x only) current task's mailbox
	    04h (DV 2.0x only) given task's keyboard (task's handle on stack)
	    05h (DV 2.0x only) current task's keyboard object
	    08h WINDOW class
	    09h MAILBOX class
	    0Ah KEYBOARD class
	    0Bh TIMER object (counts down 32-bit time in 10ms increments)
	    0Fh POINTER object
	    10h PANEL object
	STACK: (if window object or WINDOW class)
	       DWORD address to jump to (no new task if high word == 0)
	       DWORD (reserved) 0 = non-task window, FFFFh = task window
	       DWORD bytes for task's private stack (FFFFh == default of 0100h)
	       DWORD bytes system memory for input buffer for READ/READN
			(0 == none, -1 == default--same as logical window size)
	       DWORD window size, columns
	       DWORD window size, rows
	       DWORD length of window title
	       DWORD address of window title
Return: DWORD on top of stack is new object handle
Notes:	if a new task is created, it is started with
	  AX = BX = SI = DI = BP = 0
	  DX:CX = handle of parent task
	  DS = ES = SS = segment of private stack (and new task's handle)
	new windows are orphans, inherit the colors/hidden status of the
	  creating task's window, and are placed in the upper left hand corner
	  of the screen but not automatically redrawn
	new keyboards are closed, and have all object bits cleared except for
	  the hardware cursor bit
SeeAlso: AH=12h/BH=02h,AH=12h/BH=81h
--------Q-1512--BH02-------------------------
INT 15 - TopView - SEND MESSAGE - "FREE" - FREE AN OBJECT
	AH = 12h
	BH = 02h
	BL = object
	    00h handle in DWORD on top of stack
		window: close window and free
		timer: free timer
		panel: free panel object
		pointer: free pointer
	    01h task's window handle - kills task, never returns
	    02h given task's mailbox (task's handle on top of stack)
	    03h current task's mailbox
	    04h given task's keyboard (task's handle on top of stack)
	    05h current task's keyboard object
Notes:	when a window is freed, its keyboard and pointer objects are freed;
	  task windows also free any mailbox, objectq, and panel objects held
	  by the task and any child tasks
	if the keyboard being freed is the default keyboard for a task, this
	  call is equivalent to CLOSE
	panel and pointer objects are automatically closed if open
SeeAlso: AH=12h/BH=01h,AH=12h/BH=0Dh,AH=12h/BH=82h
--------Q-1512--BH03-------------------------
INT 15 - TopView - SEND MESSAGE - "ADDR" - GET HANDLE OF MESSAGE SENDER
	AH = 12h
	BH = 03h
	BL = object
	    00h mailbox handle in DWORD on top of stack
	    02h sender of last msg read from mailbox (task's handle on stack)
	    03h sender of last msg read from current task's mailbox
Return: DWORD on stack is task handle of message sender
SeeAlso: AH=12h/BH=00h,AH=12h/BH=83h
--------Q-1512--BH03-------------------------
INT 15 - DESQview v2.26+ - "CONNECT" - CONNECT TWO WINDOWS
	AH = 12h
	BH = 03h
	BL = window to be connected
	    00h handle of window to be attached in DWORD on top of stack
	    01h attach current task's main window
	STACK: DWORD handle of window to attach to or 00000000h to detach
Return: STACK popped
Notes:	when two windows are connected, both will move if the user moves either
	multiple windows may be attached to a single window, but each window
	  may only be attached to one window at a time
SeeAlso: AH=12h/BH=83h
--------Q-1512--BX0300-----------------------
INT 15 - TopView - SEND MESSAGE - "DIR" - GET PANEL FILE DIRECTORY
	AH = 12h
	BX = 0300h
	STACK: DWORD handle of panel object
Return: STACK: DWORD length of directory (always multiple of 14 bytes)
	       DWORD address of directory
Note:	a null string is returned if the object is not open
SeeAlso: AH=12h/BX=0400h"APPLY",AH=12h/BH=83h

Format of panel file:
Offset	Size	Description
 00h  2 BYTEs	C0h C3h
 02h	BYTE	number of panels in file
 03h	for each panel in file:
	    8 BYTEs  blank-padded panel name
	      DWORD  panel offset in file
	      WORD   panel length
	data for panels (each consists of one or more window/query/manager
	streams)
	    first byte of each panel must be 1Bh, fifth byte must be E5h
--------Q-1512--BH04-------------------------
INT 15 - TopView - SEND MESSAGE - "READ" - READ NEXT LOGICAL LINE OF WINDOW
	AH = 12h
	BH = 04h
	BL = window to read from
	    00h handle is DWORD on top of stack
	    01h use calling task's default window
	    0Ch (DV 2.26+) default window of task owning handle on top of stack
	    0Dh (DV 2.26+) default window of parent task of current task
Return: STACK:	DWORD number of bytes read
		DWORD address of buffer
Notes:	reading starts at the current logical cursor position; the cursor is
	  updated to point at the character following the last one read
	any translucent blanks (FFh) which are visible on screen are changed
	  to the character which is seen through them
	the string produced by the read is placed in an input buffer which may
	  be reused by the next READ or READN of a window
	window stream opcodes D8h and D9h determine whether the read returns
	  characters or attributes
SeeAlso: AH=12h/BH=05h"WINDOW",AH=12h/BH=12h,AH=12h/BH=84h
--------Q-1512--BH04-------------------------
INT 15 - TopView - SEND MESSAGE - "READ" - GET NEXT RECORD FROM OBJECT
	AH = 12h
	BH = 04h
	BL = object
	    00h handle is DWORD on top of stack
		mailbox: wait for and get next message
		keyboard: wait for and get pointer to next input buffer
		pointer: wait for and get next message
	    02h get next message from mailbox (task's handle on top of stack)
	    03h get next message from current task's mailbox
	    04h get the next input from keyboard (handle on top of stack)
	    05h get the next input from task's default keyboard
	    06h wait for input from any object in OBJECTQ (handle on stack)
	    07h wait for input from any object in task's default OBJECTQ
Return: STACK: (if objectq) DWORD handle of object with input
	       (otherwise)  DWORD number of bytes
			    DWORD address
Notes:	for a keyboard in keystroke mode, the input buffer is a single byte
	  containing the character code as returned by the BIOS; the BIOS scan
	  code is available via the STATUS call if the character is zero
	for a keyboard in field mode, the input buffer format is determined
	  by the field table header for the window the keyboard is attached to
	keyboard input buffers and mailbox message buffers may be invalidated
	  by the next READ, ERASE, CLOSE, or FREE message to the same object
SeeAlso: AH=12h/BH=05h"OBJECT",AH=12h/BH=84h

Format of pointer message:
Offset	Size	Description
 00h	WORD	row
 02h	WORD	column
 04h	BYTE	status
		bit 7: set when press/release mode active and button pressed
		bit 6: set when press/release mode active and button released
		bits 7-2: number of clicks-1 if multiple-click mode active
		bits 1,0: button pressed (00=none,01=button1,10=button2)
 05h	BYTE	field number or zero (APILEVEL >= 2.00 only)
--------Q-1512--BX0400-----------------------
INT 15 - TopView - SEND MESSAGE - "READ" - WAIT FOR TIMER TO EXPIRE
	AH = 12h
	BX = 0400h
	STACK: DWORD timer's handle
Return: after timer expires
	STACK: DWORD time in 1/100 sec after midnight when timer expired
SeeAlso: AH=12h/BH=0Ah,AH=12h/BH=84h
--------Q-1512--BX0400-----------------------
INT 15 - TopView - SEND MESSAGE - "APPLY" - WRITE PANEL TO WINDOW
	AH = 12h
	BX = 0400h
	STACK: DWORD handle of panel object
	       DWORD window's handle (or 0 for current task's window)
	       DWORD length of panel name
	       DWORD pointer to panel name
Return: STACK: DWORD handle of window which was used
	       DWORD handle of keyboard or 0
Notes:	status of APPLY may be checked with STATUS message
	panel MUST have the following format
	  first byte must be 1Bh (i.e. must start with a stream)
	  first opcode in stream must be E5h
	    single byte arg of opcode is interpreted thus:
	      bits 7,6	11 means create new window
			10 means create new field table for existing window
			01 means use existing window and field table
	      bit 5 if set, panel contains a field table
			(creates a new keyboard and puts it in field mode)
	      bit 4 if set, panel contains input fields
	      bit 3 if set, panel contains select fields but no input fields
	if the panel contains input or select fields, a keyboard handle is
	  returned; either the window's current open keyboard or a
	  newly-created keyboard object.  The caller should read that keyboard
	  to obtain input from the panel.
SeeAlso: AH=12h/BH=84h
--------Q-1512--BH05------------------------
INT 15 - TopView - SEND MESSAGE - "WRITE" - WRITE TO OBJECT
	AH = 12h
	BH = 05h
	BL = object
	    00h handle is DWORD on top of stack
		timer: start timer to end at a specified time
		keyboard: add input buffer to queue
		pointer: move pointer icon to specified position
	    02h send message by value/status=0 to mbox (task's handle on stack)
	    03h send message by value/status=0 to current task's mailbox
	    04h add input buffer to KEYBOARD queue (handle on top of stack)
	    05h add input buffer to task's default KEYBOARD queue
	    06h add an object to OBJECTQ (handle on top of stack)
	    07h add an object to task's default OBJECTQ
	STACK: (if mailbox)  DWORD length
			     DWORD address
	       (if keyboard) DWORD status (scan code in keystroke mode)
			     DWORD length (should be 1 in keystroke mode)
			     DWORD address
	       (if objectq)  DWORD handle of object to add
	       (if timer)    DWORD 1/100ths seconds since midnight (actually
				   only accurate to 1/18 sec)
	       (if pointer)  DWORD column relative to origin of window
			     DWORD row relative to origin of window
Notes:	under DV 2.2+, failed mailbox writes may return CF set (see AX=DE15h)
	the data and status written to a keyboard object must match the format
	  returned by the keyboard object in the current mode
	the pointer position is scaled according to the current scaling factors
SeeAlso: AH=12h/BH=04h,AH=12h/BH=85h
--------Q-1512--BH05-------------------------
INT 15 - TopView - SEND MESSAGE - "WRITE" - WRITE STRING TO WINDOW
	AH = 12h
	BH = 05h
	BL = window to write to
	    00h DWORD on top of stack is window handle
	    01h write string to task's default window
	    0Ch (DV 2.26+) default window of task owning handle on top of stack
	    0Dh (DV 2.26+) default window of parent of current task
	STACK: DWORD object handle if handle passed on stack
	       DWORD total length of string (high word == 0)
	       DWORD address of string to display
Return: indicated actions performed
	a. non-control characters are displayed (opcodes DEh and DFh control
	   whether the attributes are left or changed to the current attrib)
	b. CR/LF/BS/Tab cause the usual cursor movement
	c. ESC starts a data structure with additional commands if following
	   byte is less than 20h; otherwise, it is written to the window
	STACK:	DWORD handle of new window if window stream opcode E6h
		else nothing
SeeAlso: AH=12h/BH=04h,AH=12h/BH=85h

Data Structure:
	MAGIC  DB  1Bh
	MODE   DB  ?   ; 00h, 01h, 10h, 14h-1Fh legal
	LENGTH DW  ?   ; length of remainder in bytes
	var-length fields follow, each an OPCODE followed by
	     zero or more args

MODE 00h (set or display values) "WINDOW STREAM"
    Opcodes:args
	00h  display 20h blanks with the default attribute
	01h-1Fh display OPCODE blanks with the default attribute
	20h  display char with default attribute 20h times
	     BYTE char to repeat
	21h-3Fh display char with default attribute OPCODE-20h times
	     BYTE char to repeat
	40h  display 20h blanks with specified attribute
	     BYTE attribute of blanks
	41h-5Fh display OPCODE-40h blanks with specified attribute
	     BYTE attribute of blanks
	60h  display next 20h characters
	     20h BYTEs characters to display
	61h-7Fh display next OPCODE-60h characters
	     N BYTEs characters to display
	80h-87h	 display N blanks with default attribute
	     BYTE low 8 bits of 11-bit count (high 3 in low 3 bits of OPCODE)
		      [000h means 800h]
	88h-8Fh display N copies of the character
	     BYTE low 8 bits of 11-bit count (high 3 in low 3 bits of OPCODE)
		      [000h means 800h]
	     BYTE character to repeat
	90h-97h	 display N blanks with specified attribute
	     BYTE low 8 bits of 11-bit length (high 3 in low 3 bits of OPCODE)
		      [000h means 800h]
	     BYTE attribute
	98h-9FH	 display string at logical cursor pos
	     BYTE low 8 bits of 11-bit length (high 3 in low 3 bits of OPCODE)
		      [000h means 800h]
	     N BYTEs string to display
	A0h  set logical cursor row
	     BYTE row number (0 is top)
	A1h  set logical cursor column
	     BYTE column number (0 is leftmost)
	A2h  set top edge of scrolling region
	     BYTE row
	A3h  set left edge of scrolling region
	     BYTE column
	A4h  set row of physical window position
	     BYTE line
	A5h  set column of physical window position
	     BYTE column
	A6h  set height of physical window
	     BYTE #rows
	A7h  set width of physical window
	     BYTE #columns
	A8h  set viewport row
	     BYTE row
	A9h  set viewport column
	     BYTE column
	AAh  set virtual screen height [contents of window unpredictable after]
	     BYTE rows
	ABh  set virtual screen width [contents of window unpredictable after]
	     BYTE columns
	ACh-AEh	 unused
	AFh  set compatible/preferred video modes
	     BYTE compatibility/preference mask
		bit 7	compatible with monochrome
		bit 6	compatible with color text, EGA/VGA graphics
		bit 5	compatible with medium-resolution CGA graphics
		bit 4	compatible with high-resolution CGA graphics
		bit 3	prefer monochrome
		bit 2	prefer color text, EGA/VGA graphics
		bit 1	prefer medium-resolution CGA graphics
		bit 0	prefer high-resolution CGA graphics
	B0h  move logical cursor down
	     BYTE #rows (signed, negative values move up)
			[if #rows=0 and hardware cursor owner, update hw crsr]
	B1h  move logical cursor right
	     BYTE #cols (signed, negative values move left)
			[if #cols=0 and hardware cursor owner, update hw crsr]
	B2h  shift top edge of scrolling region
	     BYTE #rows (signed)
	B3h  shift left edge of scrolling region
	     BYTE #cols (signed)
	B4h  shift physical window down
	     BYTE #lines (signed)
	B5h  shift physical window right
	     BYTE #columns (signed)
	B6h  expand physical window vertically
	     BYTE #lines (signed)
	B7h  expand physical window horizontally
	     BYTE #columns (signed)
	B8h  adjust viewport row
	     BYTE #rows (signed)
	B9h  adjust viewport column
	     BYTE #columns (signed)
	BAh  adjust virtual screen height [contents of window unpredict after]
	     BYTE #rows to increase (signed)
	BBh  adjust virtual screen width [contents of window unpredictbl after]
	     BYTE #cols to increase (signed)
	BCh-BFh	 reserved (currently unused)
	C0h  set logical cursor position
	     BYTE row number (0 is top border)
	     BYTE column number (0 is left border)
	C1h  set top left corner of scrolling region
	     BYTE row
	     BYTE column
	C2h  set physical window pos
	     BYTE upper left row (no top border if 0)
	     BYTE upper left column (no left border if 0)
	C3h  set current window size
	     BYTE #rows
	     BYTE #cols
	C4h  set upper left corner of viewport (portion of virtual screen
	     displayed in window)
	     BYTE row
	     BYTE column
	C5h  set size of virtual screen [contents unpredictable afterwards]
	     BYTE #rows
	     BYTE #cols
	C6h  unused
	C7h  unused
	C8h  set logical cursor relative to current position
	     BYTE number of rows to move down (signed)
	     BYTE number of columns to move right (signed)
		  [if #rows=#cols=0 and hardware cursor owner, update hw cursr]
	C9h  shift top left corner of scrolling region
	     BYTE #rows (signed)
	     BYTE #cols (signed)
	CAh  set window pos relative to current position
	     BYTE number of rows to shift down (signed)
	     BYTE number of columns to shift right (signed)
	CBh  set window size relative to current size
	     BYTE number of rows to expand (signed)
	     BYTE number of cols to expand (signed)
	CCh  shift viewport relative to current position
	     BYTE rows to shift (signed)
	     BYTE cols to shift (signed)
	CDh  resize virtual screen
	     BYTE #rows to expand (signed)
	     BYTE #cols to expand (signed)
	CEh  scroll text when using E8h-EBh/F8h-FBh opcodes (default)
	CFh  scroll attributes when using  E8h-EBh/F8h-FBh opcodes
	D0h  allow window frame to extend beyond screen
	D1h  always display a complete frame, even if window extends beyond
	     edge of screen
	D2h  allow DV to change logical colors on video mode switch (default)
	D3h  application changes logical attributes
	D4h  window is visible [must redraw to actually make visible]
	D5h  window is hidden [must redraw to actually remove]
	D6h  window has frame (default)
	D7h  window unframed [must redraw to actually remove frame]
	D8h  READ/READN will read characters from window (default)
	D9h  READ/READN will read attributes from window
	DAh  use logical attributes, which may be remapped
		attributes
		   1 normal text
		   2 highlighted normal text
		   3 help text
		   4 highlighted help text
		   5 error message
		   6 highlighted error message
		   7 emphasized text
		   8 marked text
		   9-16 are reverse video versions of 1-8
	DBh  use physical attributes for characters
	DCh  enable special actions for control characters (default)
	DDh  disable special control char handling, all chars displayable by
	     BIOS TTY call
	DEh  write both character and attribute (default)
	DFh  write character only, leave attribute untouched
	E0h  repeat following commands through E1h opcode
	     BYTE number of times to repeat (00h means 256 times)
	E1h  end of commands to repeat, start repeating them
	E2h  set current output color
	     BYTE color
	E3h  clear virtual screen from scroll origin to end using current color
	E4h  redraw window
	E5h  select menu style
	     BYTE style (normally 18h)
		bits 5,4 = 01 use two-letter menu entries for remainder of
		  this stream
	E5h  (panel file only)
	     BYTE modifier
		bits 7,6 = 11 panel stream creates new window
			 = 10 panel defines new field table for existing window
			 = 01 panel stream uses existing window & field table
		bit 5 = 1 stream contains a field table (create kyboard object)
		bit 4 = 1 stream defines input fields (create keyboard object)
		bit 3 = 1 stream defines select fields but not input fields
		bit 2 = 1 stream defines exclusive input window (DV 2.2)
		bit 1 reserved
		bit 0 reserved
	E6h  create new window and perform rest of manipulations in new window
	     BYTE number of rows
	     BYTE number of columns
	     Return: DWORD object handle of new window returned on stack at end
	     Note: the window is created with a physical size of 0x0 at the
		     same position as the window to which this stream was sent
	E7h  no operation
	E8h  scroll area up (top left corner defined by opcode C1h)
	     BYTE height
	     BYTE width
	E9h  scroll area down (top left corner defined by opcode C1h)
	     BYTE height
	     BYTE width
	EAh  scroll area left (top left corner defined by opcode C1h)
	     BYTE height
	     BYTE width
	EBh  scroll area right (top left corner defined by opcode C1h)
	     BYTE height
	     BYTE width
	ECh  set logical attributes for window contents
	     BYTE video modes command applies to
		bit 7	monochrome
		bit 6	color text, EGA/VGA graphics
		bit 5	medium-resolution CGA graphics
		bit 4	high-resolution CGA graphics
	     BYTE which attributes to set
		bit 7  if set, copy single following byte to indicated attribs
		bits 4-6  # of first attribute to change - 1
		bits 0-3  # of consecutive attributes to change
	     N BYTEs new attributes
	EDh  set logical attributes for window frame
	     BYTE video modes command applies to (see opcode ECh)
	     BYTE which attributes to set
		bit 7  if set, copy single following byte to indicated attrs
		bits 4-6  # of first attribute to change - 1
		bits 0-3  # of consecutive attributes to change
	     N BYTEs new attributes
		  attributes
		       1 = top left corner
		       2 = top right corner
		       3 = bottom left corner
		       4 = bottom right corner
		       5 = top edge
		       6 = bottom edge
		       7 = left edge
		       8 = right edge
	EEh  set characters for window frame
	     BYTE video modes command applies to (see opcode ECh)
	     BYTE which characters to set
		bit 7  if set, copy single following byte to indicated chars
		bits 4-6  # of first char to change - 1
		bits 0-3  # of consecutive chars to change
	     N BYTEs new chars (same relative position as attributes above)
	EFh  set window name
	     BYTE length of name (should be in range 0 to logical screen width)
	     N BYTEs name
	F0h  clear input field to blanks
	     BYTE field number
	F1h  fill input field with character
	     BYTE field number
	     BYTE char
	F2h  set color of input field
	     BYTE field number (1-N)
	     BYTE attribute
	F3h  set initial contents of input field
	     BYTE field number (1-N)
	     N BYTEs enough chars to exactly fill field as defined by op FFh
	F4h  position cursor to start of specific input field
	     BYTE field number (1-N)
	F5h  change field table entry
	     BYTE field number
	     7-8 BYTEs field table entry (see opcode FFh below)
	F6h  set field type
	     BYTE field number
	     BYTE type
			00h inactive
			40h output field
			80h input field
			C0h deselected field
			C2h selected field
	F7h  "broadcast write"	write data to fields with program output bit
		set in field table entry, in field number order
	     N BYTEs (total length of all program output fields)
	F8h  scroll field up a line
	     BYTE field number
	F9h  scroll field down a line
	     BYTE field number
	FAh  scroll field left
	     BYTE field number
	FBh  scroll field right
	     BYTE field number
	FCh  set field table header
	     BYTE number of fields (must be <= existing number of fields)
	     BYTE screen behavior bits
		bit 7  reserved
		bit 6  set if menu items may be selected via keyboard
		bit 5  set if left mouse button in "status" mode (press
			anywhere in window immediately returns control to app)
		bit 4  set if right mouse button in "status" mode
		bit 3  if set, select fields return contents or blanks rather
			than 'Y' or 'N'
		bit 2  if set, modified bits reset on return to application
		bits 0,1 = 00 no data returned on read of keyboard
			   01 data returned as array of chars containing
				all fields packed together, with no field
				numbers
			   10 data returned as numbered variable-length
				records for all fields
			   11 data returned as numbered variable-length
				records for the fields which were modified
	     BYTE current input field (updated by DESQview)
	     BYTE current select field (updated by DESQview)
	     BYTE attribute for select fields when they are pointed at
	     BYTE attribute for select fields which have been selected
	FDh  reset modified bit for all fields
	FEh  reset selected and modified bits for all fields
	FFh  set up input fields
	     6 BYTEs table header (see opcode FCh above)
	     the field table entries, one for each field
		 BYTE start row	   \
		 BYTE start column  \ if menu selection and start is to
		 BYTE end row	    / right or below end, select from kbd only
		 BYTE end column   /
		 BYTE field type
		    bits 7,6 = 00 inactive (non-entry) field
			       01 echos keystrokes input to make menu selection
			       10 fill-in field
			       11 select field
		    bit 5  field can be filled by broadcast write (F7h opcode)
		    bit 4  reserved
		    bit 3  reserved
		    bit 2  reserved
		    bit 1  set if field selected
		    bit 0  set if field modified
		 BYTE modifier
		      if type is fill-in, then bit flags to determine behavior
			  bit 7	 if set, automatically enter CR when field full
			  bit 6	 move to next field when current field is full
			  bit 5	 if set, enter text from right end (for numbers)
			  bit 4	 if set, force input to uppercase
			  bit 3	 if set, clear old contents on first keystroke
			  bit 2	 if set, input returned when cursor moves out
				 of modified field ("validate",API level 2.02+)
			  bit 1	 reserved
			  bit 0	 reserved
		      if select field, first key to press to activate
			  00h if have to point-&-click or is an extended-ASCII
			      keystroke (only if two-key menus enabled)
		 BYTE (select field only) normal color of field
		 BYTE second key for select field.  This byte is present iff
		      two-letter menu entries selected with opcode E5h, and
		      in that case is present regardless of field type
	     Note: DESQview uses and updates the actual copy of the information
	       which is contained in the stream.  Thus this info must remain
	       intact until after the data entry is complete.

MODE 01h "QUERY STREAM" (valid only for those opcodes listed here)
	A0h return logical cursor row in next byte
	A1h return logical cursor column in next byte
	A2h return top row of scrolling region in next byte
	A3h return left column of scrolling region in next byte
	A4h return row of physical window origin in next byte
	A5h return column of physical window origin in next byte
	A6h return height of physcial window in next byte
	A7h return width of physical window in next byte
	A8h return row of viewport origin in next byte
	A9h return column of viewport origin in next byte
	AAh return height of virtual screen in next byte
	ABh return width of virtual screen in next byte
	AFh return current video mode in next byte
	C0h return current logical cursor position in next two bytes
	C1h return top left corner of scrolling region in next two bytes
	C2h return current window position in next two bytes
	C3h return current window size in next two bytes
	C4h return current viewport origin in next two bytes
	C5h return current virtual screen size in next two bytes
	D0h \ overwritten with D0h if frames may fall off screen edge
	D1h /		       D1h if frames always displayed entirely
	D2h \ overwritten with D2h if DESQview controls color palette
	D3h /		       D3h if application changes color palette
	D4h \ overwritten with D4h if window visible
	D5h /		       D5h if window hidden
	D6h \ overwritten with D6h if window has frame
	D7h /		       D7h if window unframed
	D8h \ overwritten with D8h if reading characters from window
	D9h /		       D9h if reading attributes from window
	DAh \ overwritten with DAh if using logical attributes
	DBh /		       DBh if using physical attributes
	DCh \ overwritten with DCh if TTY control char interpretation on
	DDh /		       DDh if TTY control char interpretation off
	DEh \ overwritten with DEh if writing both characters and attributes
	DFh /		       DFh if leaving attributes untouched
	E2h return current color in next byte
	ECh get logical attributes for window contents
	    BYTE execute call if currently in specified video mode
		bit 7	monochrome
		bit 6	color text, EGA/VGA graphics
		bit 5	medium-resolution CGA graphics
		bit 4	high-resolution CGA graphics
	    BYTE which attributes to get
		bit 7 unused???
		bits 4-6 first attribute to get - 1
		bits 0-3 # consecutive attributes
	    N BYTEs buffer to hold attributes
	EDh get logical attributes for window frame
	    BYTE execute call if currently in video mode (see opcode ECh)
	    BYTE which attributes to get
		bit 7 unused???
		bits 4-6 first attribute to get - 1
		bits 0-3 # consecutive attributes
	    N BYTEs buffer to hold attributes
	EEh get characters for window frame
	    BYTE execute call if currently in video mode (see opcode ECh)
	    BYTE which attributes to get
		bit 7 unused???
		bits 4-6 first char to get - 1
		bits 0-3 # consecutive chars
	    N BYTEs buffer to hold chars
	EFh return first N characters of current window name
	    BYTE    max length of returned name
	    N BYTEs buffer to hold window name
	F3h return contents of specified field
	    BYTE field number
	    N BYTEs buffer to hold field contents (size exactly equal to field
		    size)
	F5h get field table entry
	    BYTE field number
	    7-8 BYTEs buffer to hold field table entry
	       Notes: DV < 2.26 always returns 7 bytes
		      DV 2.26+ w/ APILEVEL < 2.26 returns 8 bytes iff field
			table is using 8-byte entries and eighth byte after
			F5h is E7h (NOP); otherwise, 7 bytes are returned
		      DV 2.26+ w/ APILEVEL > 2.26 returns 7 or 8 bytes
			depending on the field table entry size
	F6h get type of a field
	    BYTE field number
	    BYTE type
	FCh get field table header
	    6 BYTEs buffer to store header

MODE 10h "MANAGER STREAM" (valid only for opcodes listed here)
	00h allow window to be moved horizontally
	01h allow window to be moved vertically
	02h allow window to change width
	03h allow window to change height
	04h allow window to be scrolled horizontally
	05h allow window to be scrolled vertically
	06h allow "Close Window" menu selection for application
	07h allow "Hide Window" menu selection for application
	08h allow application to be suspended ("Rearrange/Freeze")
	0Eh allow "Scissors" menu
	10h allow DESQview main menu to be popped up
	11h allow "Switch Windows" menu
	12h allow "Open Window" menu
	13h allow "Quit" menu selection
	20h-33h opposite of 00h-13h, disallow specified action
	40h notify if horizontal position of window changes
	41h notify if vertical position of window changes
	42h notify if width of window changes
	43h notify if height of window changes
	44h notify if window scrolled horizontally
	45h notify if window scrolled vertically
	46h notify if window is closed--program has to clean up and exit itself
	47h notify if window is hidden
	48h notify if "?" on main menu selected
	49h notify if pointer message sent to window
	4Ah notify if window is placed in foreground
	4Bh notify if window is placed in background
	4Ch notify if video mode changes
	4Dh notify if "Scissors" menu "Cut" option selected
	4Eh notify if "Scissors" menu "Copy" option selected
	4Fh notify if "Scissors" menu "Paste" option selected
	50h notify if DESQview main menu about to pop up
	51h notify if DESQview main menu popped down
	60h-71h	 opposite of 40h-51h: don't notify on specified event
	84h attach window to parent task's window (both move together)
	85h detach window from parent task's window (may move independently)
	86h disable background operation for application
	87h enable running in background
	88h set minimum size of physical window
	    BYTE rows
	    BYTE columns
	89h set maximum size of physical window
	    BYTE rows
	    BYTE cols
	8Ah set primary asynchronous notification routine
	    DWORD address of routine, 0000h:0000h means none (see also below)
	8Bh set async notification parameter
	    DWORD 32-bit value passed to 8Ah async routine in DS:SI
	ACh (DV2.2+) perform regular select field attribute processing
	ADh (DV2.2+) protect attributes in selected field from being lost
	AEh make window default notify window for owning app (API level 2.00+)
	AFh set selected field marker character
	    BYTE character to display at left edge of selected fields
	BCh set standard field processing mode
	BDh set alternate field processing mode (enables cursor pad for menus)
	BEh disables changing reverse logical attributes with ECh opcode
	BFh enables changing reverse logical attributes with ECh opcode
	C0h make current window topmost in system
	C1h force current process into foreground
	C2h make current window topmost in process
	C3h position mouse pointer relative to origin of current field
	    BYTE rows below upper left corner of field
	    BYTE columns to right of upper left corner of field
	C4h position mouse pointer relative to origin of given field
	    BYTE field number
	    BYTE rows below upper left corner of field
	    BYTE columns to right of upper left corner of field
	C5h orphan current window (also hides it)
		Note: must be last in stream; all subsequent commands ignored
	C6h show all windows for this process
	C7h hide all windows for this process
	C8h suspend process and hide all its windows
	C9h force current process into background
	CAh make current window bottom-most in process
	CBh cancel current window manager operation, remove DV menu, give
	    control to topmost application
	CCh orphan window and give it to the system for use as paste data
	CEh reorder windows
	    DWORD pointer to null-terminated list of words
		  each word is segment of object handle for a window
	FFh no operation

MODES 14h to 1Fh "USER STREAMS"
	normally NOPs, but may be defined by SETESC message to invoke FAR
	routines, one for each mode number
	  on entry to handler,
		DS:SI -> first byte of actual stream (not header)
		CX = #bytes in stream
		ES:DI = window's handle

Asynchronous notification routine defined by manager stream 8Ah called with:
	ES:DI = handle of window
	DS:SI is 32-bit value set by 8Bh manager stream opcode
	   mailbox contains message indicating event
	      Opcode
	       40h  horizontal movement
		   DWORD object handle of window
		   BYTE	 new row
		   BYTE	 new col
	       41h  vertical movement
		   DWORD object handle of window
		   BYTE	 new row
		   BYTE	 new col
	       42h  horizontal size change
		   DWORD object handle of window
		   BYTE	 new rows
		   BYTE	 new cols
	       43h  vertical size change
		   DWORD object handle of window
		   BYTE	 new rows
		   BYTE	 new cols
	       44h  scrolled horizontally
		   DWORD object handle of window
		   BYTE	 mouse row within window
		   BYTE	 mouse column within window
		   BYTE	 field mouse is on, 0 if none
		   BYTE	 amount moved: >0 right, <0 left, 0 done
	       45h  scrolled vertically
		   DWORD object hande of window
		   BYTE	 mouse row within window
		   BYTE	 mouse column within window
		   BYTE	 field mouse is on, 0 if none
		   BYTE	 amount moved: >0 down, <0 up, 0 done
	       46h  window close request
		   DWORD object handle of window
		   BYTE	 mouse pointer row
		   BYTE	 mouse pointer column
		   BYTE	 field mouse is on, 0 if none
	       47h  application's windows hidden
	       48h  Help for Program selected
		   DWORD object handle of window
		   BYTE	 mouse pointer row
		   BYTE	 mouse pointer column
		   BYTE	 field mouse is on, 0 if none
	       49h  pointer message sent to window
		   DWORD pointer handle which received message
	       4Ah  switched to window from another ("raise")
	       4Bh  switched away from the window ("lower")
	       4Ch  video mode changed
		   BYTE new BIOS video mode
	       4Dh  Scissors/cUt selected
		   DWORD object handle of window
		   BYTE	 row of upper left corner
		   BYTE	 column of upper left corner
		   BYTE	 field number ul corner is in, 0=none
		   DWORD handle of orphaned window created with
			 copy of data from specified region
		   BYTE	 height of region
		   BYTE	 width of region
	       4Eh  Scissors/Copy selected
		   DWORD object handle of window
		   BYTE	 row of upper left corner
		   BYTE	 column of upper left corner
		   BYTE	 field number ul corner is in, 0=none
		   DWORD handle of orphaned window created with
			 copy of data from specified region
		   BYTE	 height of region
		   BYTE	 width of region
	       4Fh  Scissors/Paste selected
		   DWORD object handle of window
		   BYTE	 row of upper left corner
		   BYTE	 column of upper left corner
		   BYTE	 field number ul corner is in, 0=none
		   DWORD handle of orphaned window with data
		   BYTE	 height of region
		   BYTE	 width of region
			Note: orphaned data window should be adopted or freed
				when done
	       50h  main menu about to pop up
	       51h  main menu popped down
Return: all registers unchanged
--------Q-1512--BH06-------------------------
INT 15 - DESQview 2.20+ - SEND MESSAGE - "SETPRI" - SET PRIORITY WITHIN OBJECTQ
	AH = 12h
	BH = 06h
	BL = object
	    00h object handle in DWORD on top of stack
		mailbox, keyboard, pointer, or timer
		(DV 2.50+) window
	    01h (DV 2.50+) current task's window
	    04h given task's keyboard (task's handle on top of stack)
	    05h current task's default keyboard
	STACK: DWORD new priority of object in task's OBJECTQ
			(new priority of task if window handle)
Notes:	initially all objects have the same default value.  Should only make
	  relative adjustments to this default value.
	when changing priorities, all objects already on the objectq are
	  reordered
	for window handles, only the non-blocked task(s) with the highest
	  priority receive CPU time under DESQview 2.50-2.52; the default
	  priority is 0Ah
SeeAlso: AH=12h/BH=07h,AH=12h/BH=87h
--------Q-1512--BH07-------------------------
INT 15 - DESQview 2.20+ - SEND MESSAGE - "GETPRI" - GET PRIORITY WITHIN OBJECTQ
	AH = 12h
	BH = 07h
	BL = object
	    00h object handle in DWORD on top of stack
		mailbox, keyboard, pointer, or timer
		(DV 2.50+) window
	    01h (DV 2.50+) current task's window
	    04h given task's keyboard (task's handle on top of stack)
	    05h current task's default keyboard
Return: STACK: DWORD object priority
Note:	initially all objects have the same default value.  Should only make
	  relative adjustments to this default value.
SeeAlso: AH=12h/BH=06h
--------Q-1512--BH08-------------------------
INT 15 - TopView - SEND MESSAGE - "SIZEOF" - GET OBJECT SIZE
	AH = 12h
	BH = 08h
	BL = object
	    00h handle in DWORD on top of stack
		window: total character positions in window
		timer: elapsed time since timer started
		pointer: number of messages queued to pointer object
		panel: number of panels in panel file
		keyboard: number of input buffers queued
	    01h total chars in current task's default window
	    02h number of messages in task's mailbox (task's handle on stack)
	    03h number of messages in current task's mailbox
	    04h number of input buffers queued in task's kbd (handle on stack)
	    05h number of input buffers queued for current task's default kbd
	    06h number of objects queued in OBJECTQ (task's handle on stack)
	    07h number of objects queued in current task's OBJECTQ
	    0Ch (DV 2.26+) total chars in window owning handle on top of stack
	    0Dh (DV 2.26+) total chars in parent task's window
Return: DWORD on top of stack is result
Note:	for panel objects, a count of zero is returned if no panel file is open
	  for the object
SeeAlso: AH=12h/BH=04h,AH=12h/BH=09h
--------Q-1512--BH09-------------------------
INT 15 - TopView - SEND MESSAGE - "LEN" - GET OBJECT LENGTH
	AH = 12h
	BH = 09h
	BL = object
	    00h handle in DWORD on top of stack
		window: get chars/line
		timer: get 1/100 seconds remaining before timer expires
		mailbox: (DV/X) get number of bytes queued to mailbox
	    01h get number of chars/line in current task's default window
	    0Ch (DV 2.26+) get chars/line in window owning handle on top of stk
	    0Dh (DV 2.26+) get chars/line in parent task's window
Return: DWORD on top of stack is length
SeeAlso: AH=12h/BH=08h
--------Q-1512--BH0A-------------------------
INT 15 - TopView - SEND MESSAGE - "ADDTO" - WRITE CHARS AND ATTRIBS TO WINDOW
	AH = 12h
	BH = 0Ah
	BL = window to write to
	    00h window handle is DWORD on top of stack
	    01h current task's default window
	    0Ch (DV 2.26+) default window of task owning handle on top of stack
	    0Dh (DV 2.26+) default window of parent of current task
	STACK:	DWORD count of attributes
		DWORD address of attribute string
		DWORD count of characters
		DWORD address of character string
Notes:	if one string is longer than the other, the shorter one will be reused
	  until the longer one is exhausted
	the cursor is left just after the last character written
SeeAlso: AH=12h/BH=0Bh"WINDOW"
--------Q-1512--BH0A-------------------------
INT 15 - TopView - SEND MESSAGE - "ADDTO" - SEND MAILBOX MESSAGE/STAT BY VALUE
	AH = 12h
	BH = 0Ah
	BL = mailbox to write to
	    00h handle is DWORD on top of stack
	    02h default mailbox of task whose handle is on top of stack
	    03h current task's default mailbox
	STACK:	DWORD	status (low byte)
		DWORD	length of message
		DWORD	address of message
Notes:	the message is copied into either system or common memory
	insufficient memory normally causes the process to be aborted; under
	  DESQview 2.2+, failed writes may return CF set instead (see AX=DE15h)
SeeAlso: AH=12h/BH=0Bh"MAILBOX"
--------Q-1512--BH0A-------------------------
INT 15 - TopView - SEND MESSAGE - "ADDTO" - SET OBJECT BITS
	AH = 12h
	BH = 0Ah
	BL = object
	    00h handle is DWORD on top of stack
		timer: start timer for specified interval
		pointer: set control flags
		keyboard: set control flags
	    04h set control flags on KEYBOARD object (handle on top of stack)
	    05h set control flags on task's default KEYBOARD object
	STACK: (if timer)   DWORD duration in 1/100 seconds
	       (otherwise)  DWORD bits to set
SeeAlso: AH=12h/BH=0Bh"OBJECT"

For keyboard objects, the bits have the following significance:
	bit 15 reserved, can't be set
	bit 14 unused
	bit 13 reserved, can't be set
	bit 12-6 unused
	bit 5  (DV 2.2+) exclusive input
	bit 4  filter all keys (used with handler established by SETESC)
		if 0, only keys that would normally be displayed are filtered
	bit 3  program continues executing while input in progress
	bit 2  insert mode active for field mode
	bit 1  hardware cursor displayed when task is hardware cursor owner
		must be set if keyboard in field mode and field table includes
		input fields
	bit 0  keyboard is in field mode rather than keystroke mode

For pointer objects, the bits have the following significance:
	bit 15 reserved, can't be set
	bit 14-8 unused
	bit 7  mouse pointer is hidden while in window
	bit 6  get messages even if window not topmost
	bit 5  get messages even if window not foreground
	bit 4  multiple clicks separated by less than 1/3 second are counted
		and returned in a single message
	bit 3  pointer position is relative to screen origin, not window origin
	bit 2  send message on button release as well as button press
	bit 1  (DV 2.23+) send message with row=FFFFh and col=FFFFh whenever
		pointer leaves the window
	bit 0  send message only on button activity, not movement
	       DV-specific, and INT 15/AX=DE0Fh must have been called first
--------Q-1512--BH0B-------------------------
INT 15 - TopView - SEND MESSAGE - "SUBFROM" - WRITE ATTRIBUTES TO WINDOW
	AH = 12h
	BH = 0Bh
	BL = window to write attributes to
	    00h handle is DWORD on top of stack
	    01h current task's default window
	    0Ch (DV 2.26+) default window of task owning handle on top of stack
	    0Dh (DV 2.26+) default window of parent of current task
	STACK:	DWORD number of attributes to write
		DWORD address of attributes
Note:	the attributes are written starting at the current cursor position; the
	  cursor is left just after the last position written
SeeAlso: AH=12h/BH=0Ah"WINDOW"
--------Q-1512--BH0B-------------------------
INT 15 - TopView - SEND MESSAGE - "SUBFROM" - SEND MAILBOX MESSAGE/STAT BY REF
	AH = 12h
	BH = 0Bh
	BL = mailbox to write to
	    00h handle is DWORD on top of stack
	    02h default mailbox of task whose handle is on top of stack
	    03h current task's default mailbox
	STACK:	DWORD	status (low byte)
		DWORD	length of message
		DWORD	address of message
Notes:	only a pointer to the message is stored, but the write may still fail
	  due to insufficient memory
	under DV 2.2+, failed mailbox writes may return CF set (see AX=DE15h)
SeeAlso: AH=12h/BH=0Ah"MAILBOX"
--------Q-1512--BH0B-------------------------
INT 15 - TopView - SEND MESSAGE - "SUBFROM" - REMOVE OBJECT FROM OBJECTQ
	AH = 12h
	BH = 0Bh
	BL = OBJECTQ from which to remove all copies of a particular object
	    06h OBJECTQ of task whose handle is on top of stack
	    07h task's default OBJECTQ
	STACK:	DWORD	handle of object to remove
Note:	should be sent whenever an object is erased or closed
--------Q-1512--BH0B-------------------------
INT 15 - TopView - SEND MESSAGE - "SUBFROM" - RESET OBJECT BITS
	AH = 12h
	BH = 0Bh
	BL = object
	    00h handle is DWORD on top of stack
		pointer: reset control flags
		keyboard: reset control flags
	    04h clear control flags on KEYBOARD object (handle on top of stack)
	    05h clear control flags on task's default KEYBOARD object
	STACK:	DWORD	which bits to clear (see AH=12h/BH=0Ah"OBJECT")
SeeAlso: AH=12h/BH=0Ah"OBJECT"
--------Q-1512--BH0C-------------------------
INT 15 - TopView - SEND MESSAGE - "OPEN" - OPEN OBJECT
	AH = 12h
	BH = 0Ch
	BL = object
	    00h handle is DWORD on top of stack
		window:	  fill with given character from scroll origin to end
		keyboard: attach to a window
		timer:	  open
		pointer:  start taking input for window
		panel:	  associate with a panel file
	    01h fill task's default window with given char from scrl org to end
	    02h open given task's mailbox for input (task's handle on stack)
	    03h open current task's mailbox
	    04h attach a KEYBOARD to a window (handle on top of stack)
	    05h attach task's default KEYBOARD to a window
	    06h open a task's OBJECTQ (task's handle on top of stack)
	    07h open current task's OBJECTQ
	    0Ch (DV 2.26+) fill def window of task owning handle on top of stck
	    0Dh (DV 2.26+) fill default window of parent of current task
	 STACK: (if window)   DWORD character to fill with
		(if keyboard) DWORD handle of window to attach to
		(if pointer)  DWORD handle of window to attach to
		(if panel)    DWORD length of filename or resident panel
			      DWORD address of filename or resident panel
		(otherwise)   nothing
Notes:	if first byte of panel file name is 1Bh, then the "name" IS a panel
	if first two bytes of panel file "name" are C0hC3h, then the "name" IS
	  the panel file
	result code of open may be retrieved with STATUS message
	logical cursor is left at scroll origin after filling window
	the task opening a mailbox becomes its owner, and the only task allowed
	  to read the mailbox
	messages are only sent to a pointer object when the mouse is positioned
	  in the window to which the pointer has been attached
	there is no need to explicitly open a timer object, as ADDTO and WRITE
	  messages automatically open the timer
SeeAlso: AH=12h/BH=0Dh,AH=12h/BH=14h"LOCK"
--------Q-1512--BH0D-------------------------
INT 15 - TopView - SEND MESSAGE - "CLOSE" - CLOSE OBJECT
	AH = 12h
	BH = 0Dh
	BL = object
	    00h handle is DWORD on top of stack
		timer:	  close
		keyboard: detach from window and discard queued input
		pointer:  stop taking input
		panel:	  close
		mailbox:  close, unlock, and discard any pending messages
	    02h close given task's mailbox (task's handle on top of stack)
	    03h close task's default mailbox
	    04h close KEYBOARD object (handle on top of stack)
	    05h close task's default KEYBOARD
	    06h close given task's OBJECTQ (task's handle on top of stack)
	    07h close current task's OBJECTQ
Notes:	when an OBJECTQ is closed, each object in the OBJECTQ is sent an
	  ERASE message (AH=12h/BH=0Eh)
	when a panel object is closed, the panel file and any panels currently
	  in use are freed; window and keyboard objects created by APPLY are
	  not affected, but field mode input ceases
	open but idle timer objects consume a small amount of CPU time
SeeAlso: AH=12h/BH=0Ch,AH=12h/BH=0Eh,AH=12h/BH=14h"LOCK"
--------Q-1512--BH0E-------------------------
INT 15 - TopView - SEND MESSAGE - "ERASE" - ERASE OBJECT
	AH = 12h
	BH = 0Eh
	BL = object
	    00h handle is DWORD on top of stack
		window:	  clear from scroll origin to end of window
		keyboard: discard input
		timer:	  cancel current interval
		pointer:  discard all pending messages
		mailbox:  discard all pending messages
	    01h clear task's default window from scroll origin to end
	    02h discard all queued messages in mailbox (handle on top of stack)
	    03h discard all queued messages in current task's default mailbox
	    04h discard all input queued to KEYBOARD (handle on top of stack)
	    05h discard all input queued to task's default KEYBOARD
	    06h remove all objects from OBJECTQ (task's handle on top of stack)
	    07h remove all objects from current task's OBJECTQ
	    0Ch (DV 2.26+) clear window of task owning handle on top of stack
	    0Dh (DV 2.26+) clear default window of parent of current task
Note:	when an OBJECTQ is erased, each object in the OBJECTQ is also erased
SeeAlso: AH=12h/BH=02h
--------Q-1512--BH0F-------------------------
INT 15 - TopView - SEND MESSAGE - "STATUS" - GET OBJECT STATUS
	AH = 12h
	BH = 0Fh
	BL = object
	    00h handle is DWORD on top of stack
		timer:	 is it running?
		pointer: return status of last message
		panel:	 verify success of last OPEN or APPLY
	    02h return status of last msg READ from mailbox (handle on stack)
	    03h return status of last msg READ from task's default mailbox
	    04h get stat of last msg from task's KEYBOARD (task handle on stk)
	    05h get status of last msg from task's default KEYBOARD
	    06h return whether OBJECTQ is open or not (handle on top of stack)
	    07h return whether task's default OBJECTQ is open or not
Return: DWORD on top of stack is status
Notes:	if object is a panel object, the status indicates the error code:
	  00h successful
	  14h panel name not in panel directory
	  15h not enough memory to apply panel
	  16h invalid panel format
	  17h panel file already open
	  81h-92h  DOS error codes+80h			\  codes > 80h indicate
	  95h not enough memory to open panel file	 > that the panel was
	  98h null panel file name			/  not opened
	if object is a timer, the status is:
	  00000000h open but not running
	  40000000h open and running
	  80000000h closed
	if object is an OBJECTQ, the status is:
	  00000000h open
	  80000000h closed
	if object is a keyboard in keystroke mode, the status is the extended
	  character code (scan code) of the last keystroke
	if object is a keyboard in field mode, the status indicates the reason
	  for the last return from the field manager
	  00h Enter key pressed
	  01h Button 1 or keystroke selection
	  02h Button 2
	  03h validation
	  04h auto Enter on field
	  1Bh Escape pressed
	  46h ^Break pressed
	  other: extended code for key terminating input
	the status of mailbox messages sent by the window manager is always 80h
	the status of a pointer message is the same as the status field in the
	  message
SeeAlso: AH=12h/BH=04h"READ"
--------Q-1512--BH10-------------------------
INT 15 - TopView - SEND MESSAGE - "EOF" - GET OBJECT EOF STATUS
	AH = 12h
	BH = 10h
	BL = object
	    00h handle is DWORD on top of stack
		window: return TRUE if logical cursor past end of window
		mailbox: ???
	    01h returns TRUE if logical cursor past end of task's def window
	    02h return ??? for task's mailbox (task's handle on top of stack)
	    03h return ??? for current task's mailbox
	    0Ch (DV 2.26+) check log crsr of window owning handle on top of stk
	    0Dh (DV 2.26+) check log cursor of window of parent task
Return: DWORD on top of stack is status
--------Q-1512--BH11-------------------------
INT 15 - TopView - SEND MESSAGE - "AT" - POSITION OBJECT CURSOR
	AH = 12h
	BH = 11h
	BL = window for which to move cursor
	    00h window's handle is DWORD on top of stack
	    01h task's default window
	    0Ch (DV 2.26+) default window of task owning handle on top of stack
	    0Dh (DV 2.26+) default window of parent of current task
	STACK: DWORD column
	       DWORD row
--------Q-1512--BH11-------------------------
INT 15 - TopView - SEND MESSAGE - "SETNAME" - ASSIGN NAME TO MAILBOX
	AH = 12h
	BH = 11h
	BL = mailbox to name
	    00h DWORD on top of stack is mailbox handle
	    02h use given task's mailbox (task's handle on top of stack)
	    03h use current task's default mailbox
	STACK: DWORD length of name
	       DWORD address of name
SeeAlso: AH=12h/BH=12h"GETNAME",AX=DE0Eh
--------Q-1512--BX1100-----------------------
INT 15 - TopView - SEND MESSAGE - "SETSCALE" - SET POINTER SCALE FACTOR
	AH = 12h
	BX = 1100h
	STACK: DWORD object handle for pointer object
	       DWORD number of colums to scale pointer position to
	       DWORD number of rows to scale pointer position to
SeeAlso: AH=12h/BX=1200h
--------Q-1512--BH12-------------------------
INT 15 - TopView - SEND MESSAGE - "READN" - GET NEXT N OBJECT BYTES
	AH = 12h
	BH = 12h
	BL = window to read from
	    00h handle is DWORD on top of stack
	    01h read next N chars or attributes on task's default window
	    0Ch (DV 2.26+) read window of task owning handle on top of stack
	    0Dh (DV 2.26+) read default window of parent of current task
	STACK: DWORD count
Return: STACK: DWORD number of bytes actually read
	       DWORD address of buffer containing data
Notes:	reading starts at the current logical cursor position; the cursor is
	  updated to point at the character following the last one read
	any translucent blanks (FFh) which are visible on screen are changed
	  to the character which is seen through them
	the string produced by the read is placed in an input buffer which may
	  be reused by the next READ or READN of a window
	window stream opcodes D8h and D9h determine whether the read returns
	  characters or attributes
SeeAlso: AH=12h/BH=04h"WINDOW",AH=12h/BH=05h"WINDOW"
--------Q-1512--BH12-------------------------
INT 15 - DESQview 2.50+ - SEND MESSAGE - "GETNAME" - GET NAME OF MAILBOX
	AH = 12h
	BH = 12h
	BL = mailbox for which to retrieve name
	    00h DWORD on top of stack is mailbox handle
	    02h use given task's mailbox (task's handle on top of stack)
	    03h use current task's default mailbox
	STACK: DWORD length of buffer for name
	       DWORD pointer to buffer
Return: STACK: DWORD length of returned name (or size of buffer, if less)
Program: DESQview 2.5x is distributed as part of DESQview/X 1.0x
Note:	the returned name is not NUL-terminated
SeeAlso: AH=12h/BH=11h"SETNAME",AX=DE0Eh
--------Q-1512--BX1200-----------------------
INT 15 - TopView - SEND MESSAGE - "GETSCALE" - GET POINTER SCALE FACTOR
	AH = 12h
	BX = 1200h
	STACK: DWORD object handle for pointer
Return: STACK: DWORD pointer pos scaled as if window were this many colums wide
	       DWORD pointer pos scaled as if window were this many rows high
SeeAlso: AH=12h/BX=1100h
--------Q-1512--BH13-------------------------
INT 15 - TopView - SEND MESSAGE - "REDRAW" - REDRAW WINDOW
	AH = 12h
	BH = 13h
	BL = window object
	    00h DWORD on top of stack is handle for window to redraw
	    01h redraw task's default window
	    0Ch (DV 2.26+) redraw window of task owning handle on top of stack
	    0Dh (DV 2.26+) redraw default window of parent of current task
SeeAlso: AH=12h/BH=05h"WINDOW",AH=12h/BH=0Eh
--------Q-1512--BH13-------------------------
INT 15 - DESQview 2.50+ - SEND MESSAGE - "READINTO" - GET NEXT MAIL MESSAGE
	AH = 12h
	BH = 13h
	BL = mailbox from which to read
	    00h DWORD on top of stack is mailbox handle
	    02h use given task's mailbox (task's handle on top of stack)
	    03h use current task's default mailbox
	STACK: DWORD size of buffer in bytes
	       DWORD pointer to buffer
Return: STACK: DWORD number of bytes read
Program: DESQview 2.5x is distributed as part of DESQview/X 1.0x
Notes:	this call blocks if no input is available, but will return less than
	  the requested number of bytes if some (but insufficient) data is
	  available
	use this call instead of AH=12h/BH=04h if the mailbox has flag bits
	  4 or 5 set, as common memory may be exhausted by that call when
	  attempting to read the next message
SeeAlso: AH=12h/BH=04h"READ",AH=12h/BH=05h,AH=12h/BH=16h
--------Q-1512--BX1300-----------------------
INT 15 - TopView - SEND MESSAGE - "SETICON" - SPECIFY POINTER ICON
	AH = 12h
	BX = 1300h
	STACK: DWORD object handle for pointer
	       DWORD character to use for pointer
--------Q-1512--BH14-------------------------
INT 15 - TopView - SEND MESSAGE - "SETESC" - SET ESCAPE ROUTINE ADDRESS
	AH = 12h
	BH = 14h
	BL = message modifier
	    00h handle is DWORD on top of stack
	    01h define user stream
	    04h intercept keystrokes from KEYBOARD to window (handle on stack)
	    05h intercept keystrokes from task's default KEYBOARD to a window
	STACK: (if window)   DWORD user stream number (14h-1Fh)
			     DWORD address of FAR user stream handler
	       (if keyboard) DWORD address of FAR filter function

The keyboard filter function is called when the keyboard is in field mode.  On
entry,
	AL = character
	AH = 00h or extended ASCII code if AL = 00h
	BL = field number
	CH = cursor column
	CL = cursor row
	DL = field type modifier (sixth item in field table entry)
	DH = seventh item in field table entry
	ES:SI = window's handle
	DS:DI -> field table entry for field containing the cursor
The filter function should return
	AH = 00h use keystroke
	     01h ignore keystroke
	     FFh beep and ignore keystroke
Note: the filter function is not allowed to make INT 15, DOS, or BIOS calls
--------Q-1512--BH14-------------------------
INT 15 - TopView - SEND MESSAGE - "LOCK" - REQUEST EXCLUSIVE ACCESS TO RESOURCE
	AH = 12h
	BH = 14h
	BL = object
	    00h mailbox handle is DWORD on top of stack
	    02h use given task's mailbox (task's handle on top of stack)
	    03h use current task's default mailbox
Note:	release exclusive access by sending CLOSE message to mailbox
	access may be requested multiple times, and requires multiple CLOSEs
SeeAlso: AH=12h/BH=0Dh
--------Q-1512--BH15-------------------------
INT 15 - DESQview v2.20+ - SEND MESSAGE - "SETFLAGS" - SET OBJECT FLAGS
	AH = 12h
	BH = 15h
	BL = object
	    00h DWORD on top of stack
		mailbox, keyboard, or pointer only
	    02h mailbox for task whose handle is on top of stack
	    03h mailbox for current task
	    04h keyboard for task whose handle is on top of stack
	    05h keyboard for current task
	STACK: DWORD flags
		if mailbox:
			bit 0: all mail messages in common memory
			bit 1: allow write even if closed
			bit 2: don't erase messages when mailbox closed
			bit 4: (DV/X) append messages with like status and
				sender (stream-oriented mail)
			bit 5: (DV/X) store mail in expanded memory (pool
				grows as needed)
			bit 6: (DV/X) make mailbox into non-owned mailbox
		if keyboard:
			bit 5: exclusive input when keyboard in use for input
Return: nothing
Notes:	only available if the API level has been set to at least 2.20
	equivalent to performing SUBFROM and ADDTO calls on the object
	if a mailbox has bits 4 or 5 set, you must use "READINTO" rather than
	  "READ" (see AH=12h/BX=1300h"READINTO") to retrieve messages
SeeAlso: AH=12h/BH=0Ah,AH=12h/BH=0Bh,AH=12h/BH=16h
--------Q-1512--BH16-------------------------
INT 15 - DESQview v2.20+ - SEND MESSAGE - "GETFLAGS" - GET OBJECT FLAGS
	AH = 12h
	BH = 16h
	BL = object
	    00h DWORD on top of stack
		mailbox, keyboard, or pointer only
	    02h mailbox for task whose handle is on top of stack
	    03h mailbox for current task
	    04h keyboard for task whose handle is on top of stack
	    05h keyboard for current task
Return: STACK: DWORD current control flags (see AH=12h/BH=15h)
Notes:	only available if the API level has been set to at least 2.20
	if a mailbox has bits 4 or 5 set, you must use "READINTO" rather than
	  "READ" (see AH=12h/BH=13h"READINTO") to retrieve messages
SeeAlso: AH=12h/BH=0Ah,AH=12h/BH=0Bh,AH=12h/BH=13h"READINTO",AH=12h/BH=15h
--------Q-1512--BH17-------------------------
INT 15 - DESQview v2.42-2.52 - BUG
	AH = 12h
	BH = 17h
	BL = object
	    00h DWORD on top of stack
		mailbox, keyboard, or pointer only
	    02h mailbox for task whose handle is on top of stack
	    03h mailbox for current task
	    04h keyboard for task whose handle is on top of stack
	    05h keyboard for current task
Notes:	due to a fencepost error, message 17h is accepted for mailboxes,
	  keyboards, and pointers, but causes a random branch
	DESQview v2.50-2.52 are distributed as part of DESQview/X v1.02
--------Q-1512--BH80-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 00h WITH ERROR RECOVERY
	AH = 12h
	BH = 80h
Note:	this function is identical to AH=12h/BH=00h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL:
		00h no error
		01h invalid values
		02h alias invalid
		03h handle valid but wrong type
		04h invalid handle
SeeAlso: AH=12h/BH=00h
--------Q-1512--BH81-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 01h WITH ERROR RECOVERY
	AH = 12h
	BH = 81h
Note:	this function is identical to AH=12h/BH=01h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=01h
--------Q-1512--BH82-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 02h WITH ERROR RECOVERY
	AH = 12h
	BH = 82h
Note:	this function is identical to AH=12h/BH=02h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=02h
--------Q-1512--BH83-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 03h WITH ERROR RECOVERY
	AH = 12h
	BH = 83h
Note:	this function is identical to AH=12h/BH=03h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=03h,AH=12h/BX=0300h
--------Q-1512--BH84-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 04h WITH ERROR RECOVERY
	AH = 12h
	BH = 84h
Note:	this function is identical to AH=12h/BH=04h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=04h,AH=12h/BX=0400h
--------Q-1512--BH85-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 05h WITH ERROR RECOVERY
	AH = 12h
	BH = 85h
Note:	this function is identical to AH=12h/BH=05h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=05h
--------Q-1512--BH86-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 06h WITH ERROR RECOVERY
	AH = 12h
	BH = 86h
Note:	this function is identical to AH=12h/BH=06h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=06h
--------Q-1512--BH87-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 07h WITH ERROR RECOVERY
	AH = 12h
	BH = 87h
Note:	this function is identical to AH=12h/BH=07h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=07h
--------Q-1512--BH88-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 08h WITH ERROR RECOVERY
	AH = 12h
	BH = 88h
Note:	this function is identical to AH=12h/BH=08h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=08h
--------Q-1512--BH89-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 09h WITH ERROR RECOVERY
	AH = 12h
	BH = 89h
Note:	this function is identical to AH=12h/BH=09h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=09h
--------Q-1512--BH8A-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Ah WITH ERROR RECOVERY
	AH = 12h
	BH = 8Ah
Note:	this function is identical to AH=12h/BH=0Ah, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=0Ah
--------Q-1512--BH8B-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Bh WITH ERROR RECOVERY
	AH = 12h
	BH = 8Bh
Note:	this function is identical to AH=12h/BH=0Bh, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=0Bh
--------Q-1512--BH8C-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Ch WITH ERROR RECOVERY
	AH = 12h
	BH = 8Ch
Note:	this function is identical to AH=12h/BH=0Ch, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=0Ch
--------Q-1512--BH8D-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Dh WITH ERROR RECOVERY
	AH = 12h
	BH = 8Dh
Note:	this function is identical to AH=12h/BH=0Dh, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=0Dh
--------Q-1512--BH8E-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Eh WITH ERROR RECOVERY
	AH = 12h
	BH = 8Eh
Note:	this function is identical to AH=12h/BH=0Eh, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=0Eh
--------Q-1512--BH8F-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Fh WITH ERROR RECOVERY
	AH = 12h
	BH = 8Fh
Note:	this function is identical to AH=12h/BH=0Fh, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=0Fh
--------Q-1512--BH90-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 10h WITH ERROR RECOVERY
	AH = 12h
	BH = 90h
Note:	this function is identical to AH=12h/BH=10h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=10h
--------Q-1512--BH91-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 11h WITH ERROR RECOVERY
	AH = 12h
	BH = 91h
Note:	this function is identical to AH=12h/BH=11h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=11h,AH=12h/BX=1100h
--------Q-1512--BH92-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 12h WITH ERROR RECOVERY
	AH = 12h
	BH = 92h
Note:	this function is identical to AH=12h/BH=12h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=12h,AH=12h/BX=1200h
--------Q-1512--BH93-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 13h WITH ERROR RECOVERY
	AH = 12h
	BH = 93h
Note:	this function is identical to AH=12h/BH=13h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=13h
--------Q-1512--BH94-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 14h WITH ERROR RECOVERY
	AH = 12h
	BH = 94h
Note:	this function is identical to AH=12h/BH=14h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=14h
--------Q-1512--BH95-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 15h WITH ERROR RECOVERY
	AH = 12h
	BH = 95h
Note:	this function is identical to AH=12h/BH=15h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=15h
--------Q-1512--BH96-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 16h WITH ERROR RECOVERY
	AH = 12h
	BH = 96h
Note:	this function is identical to AH=12h/BH=16h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see AH=12h/BH=80h)
SeeAlso: AH=12h/BH=16h
--------T-1513-------------------------------
INT 15 - VMiX - "sys_wake" - WAKE SLEEPING PROCESS
	AH = 13h
	STACK:	WORD	process ID
Return: AX = status (SYS_OK or SYS_ERROR)
SeeAlso: AH=12h"VMiX"
--------T-1513-------------------------------
INT 15 - MultiDOS Plus - GET TASK CONTROL BLOCK
	AH = 13h
Return: BX:AX -> task control block (see below)
SeeAlso: AH=15h"MultiDOS"

Format of MultiDOS Plus v4.0 task control block:
Offset	Size	Description
 00h	DWORD	pointer to next TCB
 04h  8 BYTEs	ASCIZ task name
 0Ch  2 BYTEs	???
 0Eh	WORD	task PSP segment
 10h	WORD	abort/suspend flags
 12h	WORD	current screen segment (see AH=0Bh,AH=0Ch)
 14h	WORD	priority level (0000h-FFFEh)
 16h	WORD	time slice counter
 18h  2 BYTEs	???
 1Ah	WORD	suspend timer value
 1Ch	WORD	stack segment
 1Eh	WORD	stack pointer
 20h	WORD	display type
 22h	WORD	display memory
 24h  2 BYTEs	???
 26h	WORD	termination count
 28h	WORD	equipment flag for BIO10 driver
 2Ah	BYTE	background CRT mode
 2Bh	WORD	screen width in columns
 2Dh	WORD	screen size in bytes
 2Fh	WORD	segment of physical screen memory
 31h 16 BYTEs	eight cursor positions
 41h	WORD	current cursor shape
 43h	BYTE	active display page
 44h	WORD	CRT controller I/O port base
 46h  2 BYTEs	???
 48h	WORD	foreground task flag
 4Ah  6 BYTEs	???
 50h	WORD	saved video segment (see AH=0Bh,AH=0Ch)
 52h	DWORD	old INT 22
 56h	DWORD	old INT 23
 5Ah	DWORD	old INT 24
 5Eh	WORD	top of memory for task
 60h  4 BYTEs	???
 64h	WORD	DTA segment (see INT 21/AH=1Ah)
 66h	WORD	DTA offset
 68h  4 BYTEs	???
 6Ch	BYTE	current ANSI.SYS attribute
 6Dh	BYTE	current ANSI.SYS column
 6Eh	BYTE	current ANSI.SYS row
 6Fh	BYTE	current ANSI.SYS display state
 70h	BYTE	maximum ANSI.SYS columns
 71h	BYTE	current ANSI.SYS page
 72h	WORD	saved ANSI.SYS cursor position
 74h	BYTE	ANSI.SYS parameter buffer index
 75h	BYTE	current ANSI.SYS screen mode
 76h	BYTE	ANSI.SYS wrap flag
 77h  6 BYTEs	ANSI.SYS parameter buffer
 7Dh	BYTE	ANSI.SYS keyboard DSR state
 7Eh  7 BYTEs	ANSI.SYS keyboard DSR buffer
 85h  3 BYTEs	???
 88h 16 BYTEs	request header for DOS driver calls
 98h 14 BYTEs	???
 A6h	WORD	segment of EMS map if EMS task
 A8h	WORD	flag: task makes EMS calls
 AAh	WORD	EMS handle for task
 ACh	WORD	keyboard shift state
 AEh 12 BYTEs	???
 BAh	WORD	TCB of parent if child task
 BCh	WORD	termination code
 BEh	WORD	COM port number
 C0h  4 BYTEs	???
 C4h	WORD	current IRQ number
 C6h  2 BYTEs	???
 C8h	WORD	miscellaneous flag word
 CAh  2 BYTEs	???
 CCh	DWORD	old INT 10
 D0h	WORD	EMS alternate map set number
 D2h 414 BYTEs	DOS current disk and directory context (optional)
--------T-1514-------------------------------
INT 15 - VMiX - "sys_clrwindow" - CLEAR WINDOW
	AH = 14h
	STACK:	WORD	top left corner of window (high byte = row, low = col)
		WORD	bottom right corner of window (high = row, low = col)
Return: AX = status (SYS_OK)
Note:	clears window to color set with "sys_setcolors" (AH=18h)
SeeAlso: AH=15h"VMiX",AH=16h"VMiX",AH=18h"VMiX",AH=1Fh"VMiX"
--------T-1514-------------------------------
INT 15 - MultiDOS Plus - CHECK IF MultiDOS FOREGROUND OR BACKGROUND
	AH = 14h
Return: AX = current state
	    0000h MultiDOS Plus command prompt is background task
	    0001h command prompt is foreground task
SeeAlso: AH=0Bh"MultiDOS"
--------T-1515-------------------------------
INT 15 - VMiX - "sys_setbwindow" - SET BANNER WINDOW MESSAGE
	AH = 15h
	STACK:	DWORD	pointer to ASCIZ banner message for top of screen
Return: AX = status (SYS_OK)
SeeAlso: AH=14h"VMiX",AH=16h"VMiX"
--------T-1515-------------------------------
INT 15 - MultiDOS Plus - GET SYSTEM BLOCK
	AH = 15h
Return: BX:AX -> system block (see below)
SeeAlso: AH=13h"MultiDOS"

Format of MultiDOS Plus 4.0 system block:
Offset	Size	Description
 00h	WORD	segment of system control block
 02h	WORD	redirection flag set by /NOREDIRECT
 04h	WORD	no-INT 10 flag set by /NO10
 06h	DWORD	old INT 10
 0Ah	DWORD	new INT 10
 0Eh	DWORD	pointer to WORD with current TCB offset (see AH=13h)
 12h	DWORD	pointer to WORD with idle task TCB offset
 16h	DWORD	pointer to WORD with foreground TCB offset
 1Ah	DWORD	pointer to WORD with MultiDOS TCB offset
 1Eh	WORD	Task Control Block size
 20h	WORD	number of TCBs
 22h	WORD	flag: EMS present
 24h	WORD	EMS page frame base segment
 26h	WORD	16K pages in EMS page frame
 28h	WORD	base segment for conventional memory tasks
 2Ah	WORD	conventional memory size in paragraphs
 2Ch	DWORD	pointer to list of queue pointers
--------T-1516-------------------------------
INT 15 - VMiX - "sys_setwindow" - SET ROOT WINDOW SIZE AND HOME CURSOR
	AH = 16h
	STACK:	DWORD	pointer to I/O Request Packet
		WORD	top left corner of window (high byte = row, low = col)
		WORD	bottom right corner of window (high = row, low = col)
Return: AX = status (SYS_OK or SYS_ERROR)
SeeAlso: AH=14h"VMiX",AH=17h"VMiX"
--------T-1516-------------------------------
INT 15 - MultiDOS Plus - INITIALIZATION
	AH = 16h
Note:	used internally during initialization; any other calls will cause
	  unpredictable results
--------T-1517-------------------------------
INT 15 - VMiX - "sys_getcolors" - GET CONSOLE WINDOW COLORS
	AH = 17h
Return: AH = foreground color
	AL = background color
SeeAlso: AH=16h"VMiX",AH=18h"VMiX"
--------T-1517-------------------------------
INT 15 - MultiDOS Plus - MAP IRQ
	AH = 17h
	AL = IRQ to map (01h-0Fh)
	BX = offset of task control block (see AH=13h) to associate with IRQ
Return: AX = status
	    0000h successful
	    other invalid IRQ
Note:	the EMS map of the specified TCB is associated with the given interrupt
SeeAlso: AH=18h"MultiDOS",AH=19h"MultiDOS"
--------T-1518-------------------------------
INT 15 - VMiX - "sys_setcolors" - SET CONSOLE COLORS
	AH = 18h
	STACK:	WORD	new background/foreground colors
			bits 3-0: foreground
			bits 7-4: background
			bits 15-8: unused
Return: AX = color
SeeAlso: AH=14h"VMiX",AH=17h"VMiX",AH=19h"VMiX"
--------T-1518-------------------------------
INT 15 - MultiDOS Plus - UNMAP IRQ
	AH = 18h
	AL = IRQ to unmap (01h-0Fh)
Return: AX = status
	    0000h successful
	    0001h invalid IRQ
Note:	results are unpredictable if the IRQ has not been mapped
SeeAlso: AH=17h"MultiDOS",AH=19h"MultiDOS"
--------T-1519-------------------------------
INT 15 - VMiX v2+ - "sys_setconwn" - SET WINDOW COLORS
	AH = 19h
	STACK:	WORD	new background/foreground colors
			bits 3-0: foreground
			bits 7-4: background
			bits 15-8: unused
Return: AX = color
SeeAlso: AH=18h"VMiX"
--------T-1519-------------------------------
INT 15 - MultiDOS Plus - UNMAP ALL IRQs
	AH = 19h
Return: AX destroyed
Note:	for MultiDOS internal use only
SeeAlso: AH=17h"MultiDOS",AH=18h"MultiDOS"
--------T-151A-------------------------------
INT 15 - VMiX v2+ - "sys_sint" - INVOKE SOFTWARE INTERRUPT
	AH = 1Ah
	STACK:	WORD	interrupt number
		DWORD	pointer to register structure
Return: AX = returned flags
--------T-151A-------------------------------
INT 15 - MultiDOS Plus - MAP SEMAPHORE NAME TO NUMBER
	AH = 1Ah
	DS:SI -> 8-byte name
Return: AL = status
	    00h successful
		AH = semaphore number (20h-3Fh)
	    04h out of string space
Notes:	all eight bytes of the name are significant
	if the name does not already exist, it is added to the name table and
	  associated with a free semaphore number
	names cannot be destroyed
SeeAlso: AH=1Bh"MultiDOS",AH=1Ch"MultiDOS",AH=1Dh"MultiDOS"
--------T-151B-------------------------------
INT 15 - VMiX v2+ - "sys_blkmov" - MOVE MEMORY BLOCK
	AH = 1Bh
	STACK:	DWORD	source address
		DWORD	destination address
		WORD	number of words to move
Return: nothing
--------T-151B-------------------------------
INT 15 - MultiDOS Plus - REQUEST RESOURCE SEMAPHORE BY NAME
	AH = 1Bh
	DS:SI -> 8-byte name
Return: AH = status
	    00h successful
	    02h invalid semaphore number
	    03h caller already owns semaphore
	    04h out of string space
Notes:	(see AH=01h"MultiDOS")
	equivalent to AH=1Ah followed by AH=01h
SeeAlso: AH=01h"MultiDOS",AH=1Ah"MultiDOS",AH=1Ch"MultiDOS",AH=1Dh"MultiDOS"
--------T-151C-------------------------------
INT 15 - VMiX v2+ - "sys_bitblt" - PUT GRAPHICAL OBJECT AT CURSOR POSITION
	AH = 1Ch
	STACK:	WORD	AND/OR pixel with background (00h = OR, 01h = AND)
		DWORD	pointer to object bitmap
		WORD	object width in pixels
		WORD	object height in pixels
Return: nothing
SeeAlso: AH=1Dh"VMiX"
--------T-151C-------------------------------
INT 15 - MultiDOS Plus - RELEASE RESOURCE SEMAPHORE BY NAME
	AH = 1Ch
	DS:SI -> 8-byte name
Return: AH = status
	    00h successful
	    01h not semaphore owner
	    02h invalid semaphore number
	    04h out of string space
Notes:	(see AH=02h"MultiDOS")
	equivalent to AH=1Ah followed by AH=02h
SeeAlso: AH=02h"MultiDOS",AH=1Ah"MultiDOS",AH=1Bh"MultiDOS",AH=1Dh"MultiDOS"
--------T-151D-------------------------------
INT 15 - VMiX v2+ - "sys_getfont" - GET CURRENT CONSOLE GRAPHICS FONT
	AH = 1Dh
Return: AX = current font number (00h-03h)
SeeAlso: AH=1Ch"VMiX",AH=1Eh"VMiX"
--------T-151D-------------------------------
INT 15 - MultiDOS Plus - TEST RESOURCE SEMAPHORE BY NAME
	AH = 1Dh
	DS:SI -> 8-byte name
Return: AH = status
	    00h semaphore not in use
	    01h semaphore owned by another task
	    02h invalid semaphore number
	    03h caller owns semaphore
	    04h out of string space
Notes:	(see AH=10h"MultiDOS")
	equivalent to AH=1Ah followed by AH=10h
SeeAlso: AH=10h"MultiDOS",AH=1Ah"MultiDOS",AH=1Bh"MultiDOS",AH=1Ch"MultiDOS"
--------T-151E-------------------------------
INT 15 - VMiX v2+ - "sys_setfont" - SET CONSOLE GRAPHICS FONT
	AH = 1Eh
	STACK: WORD new font number (00h-03h)
Return: AX = current font number (00h-03h)
SeeAlso: AH=1Dh"VMiX"
--------T-151E00-----------------------------
INT 15 - MultiDOS Plus - CLEAR EVENT COUNTER
	AX = 1E00h
	DX = event/trigger number (00h-3Fh)
Return: AH = status
	    00h successful
SeeAlso: AX=1E01h,AX=1E02h
--------T-151E01-----------------------------
INT 15 - MultiDOS Plus - TRIGGER EVENT
	AX = 1E01h
	DX = event/trigger number (00h-3Fh)
Return: AH = status
	    00h successful
	    01h invalid event/trigger number
Notes:	schedules any task waiting for event; if no task is waiting, the event
	  counter is incremented (and will roll over if it was 65535)
	may be invoked by interrupt handler
SeeAlso: AX=1E00h,AX=1E02h
--------T-151E02-----------------------------
INT 15 - MultiDOS Plus - WAIT FOR EVENT
	AX = 1E02h
	DX = event/trigger number (00h-3Fh)
Return: AH = status
	    00h successful
	    01h invalid event/trigger number
Note:	if the event counter is zero, the task is suspended until the event is
	  triggered with AX=1E01h; else, the counter is decremented and the
	  call returns immediately
SeeAlso: AX=1E00h,AX=1E01h
--------T-151E08-----------------------------
INT 15 - MultiDOS Plus 4.01 - SET CONTEXT-SWITCH FUNCTIONS
	AX = 1E08h
	DX:BX -> context save handler
	DX:CX -> context restore handler
Note:	handlers may be removed by setting addresses to 0000h:0000h

Handlers are called with:
	ES:BX -> task's TCB
Return: all registers preserved
--------T-151F-------------------------------
INT 15 - VMiX v2.???+ - "sys_scrollwin" - SCROLL WINDOW
	AH = 1Fh
	STACK:	WORD	top left corner of window (high byte = row, low = col)
		WORD	bottom right corner of window
Return: AX = status (SYS_OK)
SeeAlso: AH=14h"VMiX",AH=18h"VMiX"
--------T-151F-------------------------------
INT 15 - MultiDOS Plus v4.01 - GET MEMORY PARAMETERS
	AH = 1Fh
Return: BX = first segment of conventional memory
	DX = first segment of EMS swap frame into which MultiDOS will load
		programs
--------T-1520-------------------------------
INT 15 - MultiDOS Plus v4.01 - CHECK IF MULTITASKING ENABLED
	AH = 20h
Return: AX = current state
	    0000h multitasking enabled
	    other TCB of task that disabled multitasking
SeeAlso: AH=0Dh"MultiDOS",AH=13h"MultiDOS"
--------c-152000-----------------------------
INT 15 U - DOS 3+ PRINT.COM - DISABLE CRITICAL REGION FLAG
	AX = 2000h
Desc:	stop setting user flag on entry to PRINT critical region
Note:	also supported by PC Network v1.00 RECEIVER.COM
SeeAlso: AX=2001h
--------c-152001-----------------------------
INT 15 U - DOS 3+ PRINT.COM - SET CRITICAL REGION FLAG
	AX = 2001h
	ES:BX -> byte which is to be incremented while in a DOS call
Desc:	specify a user flag which PRINT should set to let an interested
	  application know it is in a critical region
Note:	also supported by PC Network v1.00 RECEIVER.COM
SeeAlso: AX=2000h
--------O-152010-----------------------------
INT 15 - OS HOOK - SETUP SYSREQ ROUTINE (AT,XT286,PS50+)
	AX = 2010h
	???
Return: ???
SeeAlso: AX=2011h
--------O-152011-----------------------------
INT 15 - OS HOOK - COMPLETION OF SYSREQ FUNCTION (AT,XT286,PS50+)
	AX = 2011h
	???
Return: ???
SeeAlso: AX=2010h
--------B-1521-------------------------------
INT 15 - SYSTEM - POWER-ON SELF-TEST ERROR LOG (PS50+)
	AH = 21h
	AL = subfunction
	    00h read POST log
	    01h write POST log
		BH = device ID
		BL = error code
Return: CF set on error
	AH = status (00h OK, 01h list full, 80h invalid cmd, 86h unsupported)
	if function 00h:
	   BX = number of error codes stored
	   ES:DI -> error log
Note:	the log is a series of words, the first byte of which identifies the
	  error code and the second the device.
--------B-1522-------------------------------
INT 15 - SYSTEM - later PS/2s - LOCATE ROM BASIC
	AH = 22h
Return: CF set on error
	    AH = status (86h if function not supported)
	CF clear on success
	    AH = 00h
	    ES:BX -> ROM BASIC
Note:	if this function is not supported, ROM BASIC is at F600h:0000h
SeeAlso: INT 86"BASIC",INT F0"BASIC"
--------b-152400-----------------------------
INT 15 - SYSTEM - later PS/2s - DISABLE A20 GATE
	AX = 2400h
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status
		01h keyboard controller is in secure mode
		86h function not supported
Note:	also supported by Qualitas 386MAX v6.01+
SeeAlso: AX=2401h,AX=2402h,AX=2403h
--------b-152401-----------------------------
INT 15 - SYSTEM - later PS/2s - ENABLE A20 GATE
	AX = 2401h
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status
		01h keyboard controller is in secure mode
		86h function not supported
Note:	also supported by Qualitas 386MAX v6.01+
SeeAlso: AX=2400h,AX=2402h
--------b-152402-----------------------------
INT 15 - SYSTEM - later PS/2s - GET A20 GATE STATUS
	AX = 2402h
Return: CF clear if successful
	    AH = 00h
	    AL = current state (00h disabled, 01h enabled)
	CF set on error
	    AH = status
		01h keyboard controller is in secure mode
		86h function not supported
Note:	also supported by Qualitas 386MAX v6.01+
SeeAlso: AX=2400h,AX=2401h
--------b-152403-----------------------------
INT 15 - SYSTEM - later PS/2s - QUERY A20 GATE SUPPORT
	AX = 2403h
Return: CF clear if successful
	    AH = 00h
	    BX = status of A20 gate support
		bit 0: supported with bit 1 of I/O port 92h
		bit 1: supported on keyboard controller
		bit 15: additional data is available (location not yet defined)
	CF set on error
	    AH = status
		01h keyboard controller is in secure mode
		86h function not supported
Note:	also supported by Qualitas 386MAX v6.01+
SeeAlso: AX=2402h
--------B-1540-------------------------------
INT 15 - SYSTEM - READ/MODIFY PROFILES (CONVERTIBLE)
	AH = 40h
	AL = subfunction
	    00h get system profile in CX and BX
	    01h set system profile from CX and BX
	    02h get internal modem profile in BX
	    03h set internal modem profile from BX
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (80h = profile execution failed)
--------V-154000-----------------------------
INT 15 - Compaq SLT/286 or Portable 386 - READ LCD/PLASMA TIMEOUT
	AX = 4000h
Return: AX = 4000h
	CL = timeout in minutes, 00h if disabled
SeeAlso: AX=4001h,AX=4600h
--------V-154001-----------------------------
INT 15 - Compaq SLT/286 or Portable 386 - SET LCD/PLASMA TIMEOUT
	AX = 4001h
	CL = timeout in minutes, 00h to disable
Return: AL = status
	    00h timeout modified
	    01h timeout cannot be modified
	    40h timeout cannot be modified
	CL = timeout in minutes, 00h if disabled
SeeAlso: AX=4000h,AX=4601h
--------B-1541-------------------------------
INT 15 - SYSTEM - WAIT ON EXTERNAL EVENT (CONVERTIBLE and some others)
	AH = 41h
	AL = condition type
	    bits 0-2: condition to wait for
		     0 any external event
		     1 compare and return if equal
		     2 compare and return if not equal
		     3 test and return if not zero
		     4 test and return if zero
	    bit 3:    reserved
	    bit 4:    1=port address, 0=user byte
	    bits 5-7: reserved
	BH = condition compare or mask value
	BL = timeout value times 55 milliseconds
	    00h means no timeout
	DX = I/O port address if AL bit 4 set
	ES:DI -> user byte if AL bit 4 clear
Note:	call AH=C0h and examine bit 3 of feature byte 1 to determine whether
	  this function is supported
SeeAlso: AH=83h,AH=86h,AH=C0h
--------B-1542-------------------------------
INT 15 - SYSTEM - REQUEST POWER OFF (CONVERTIBLE,HP 95LX)
	AH = 42h
	AL = suspend type
	    00h to use system profile
	    01h to force suspend regardless of system profile
Note:	the HP 95LX apparently suspends regardless of the value in AL; on
	  power-up, execution will resume following the instruction calling
	  this function
SeeAlso: AH=44h
--------b-154280-----------------------------
INT 15 - Compaq SLT/286 - ENTER STANDBY
	AX = 4280h
Return: AH = 42h
	CF clear if successful
	CF set if unable to enter standby
SeeAlso: AX=4600h,AX=5307h/BX=0001h/CX=0001h
--------B-1543-------------------------------
INT 15 - SYSTEM - READ SYSTEM STATUS (CONVERTIBLE)
	AH = 43h
Return: AL = status bits (see below)

Bitfields for Convertible system status:
 bit 0	LCD detached
 bit 1	reserved
 bit 2	RS232/parallel adapter powered on
 bit 3	internal modem powered on
 bit 4	power activated by alarm
 bit 5	standby power lost
 bit 6	external power in use
 bit 7	power low
--------B-1544-------------------------------
INT 15 - SYSTEM - (DE)ACTIVATE INTERNAL MODEM POWER (CONVERTIBLE)
	AH = 44h
	AL = new modem power state (00h power off, 01h power on)
SeeAlso: AH=42h
--------b-1544C0-----------------------------
INT 15 - Olivetti Quaderno - INITIALIZE DIGITAL SIGNAL PROCESSING???
	AX = 44C0h
	ES:DI -> new DSP procedure (exchanged with CMOS[28h])
	ES:SI -> ??? buffer
Return: ES:DI -> old DSP procedure
	ES:SI buffer filled with ten bytes from CMOS (addresses 14h-1Ch)
	  followed by 00h (addresses 15h-1Ch copied only if less than 21h)
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C9h
--------b-1544C1-----------------------------
INT 15 - Olivetti Quaderno - ???
	AX = 44C1h
	???
Return: ???
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C9h
--------b-1544C2-----------------------------
INT 15 - Olivetti Quaderno - ???
	AX = 44C2h
	DL = byte to be written to I/O port 350h
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C3h,AX=44C9h
--------b-1544C3-----------------------------
INT 15 - Olivetti Quaderno - GET ???
	AX = 44C3h
Return: DH = bitfields
	    bits 0,1: "tres complique"
	    bits 2-4: zero
	    bits 5-7: bits 5-7 read from I/O port 351h
	DL = value read from I/O port 350h
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C2h,AX=44C9h
--------b-1544C4-----------------------------
INT 15 - Olivetti Quaderno - ???
	AX = 44C4h and 44C5h
	???
Return: ???
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C9h
--------b-1544C6-----------------------------
INT 15 - Olivetti Quaderno - READ LCD
	AX = 44C6h
Return: DX = FFFFh clock is displayed on LCD display
	DX = other: hex number displayed in first four positions of display
	BH = left alphanumeric character on display (see below)
	BL = right alphanumeric character on display (see below)
	CL = flags
	    bit 0: right colon on
	    bit 1: left colon on
	    bits 2-7 unused	
Notes:	the LCD display has the format HH:HH:AA, where H is a hex digit and A
	  is an alphanumeric character
	this function is also supported by XBIOS.COM
SeeAlso: AX=44C7h,AX=44C9h

Values for alphanumeric characters:
 00h-0Fh hex digit
 2Bh	"+"
 2Dh	"-"
 30h-39h "0" to "9"
 41h-5Ah "A" to "Z"
 61h-6Ah "a" to "z"
 else	blank
--------b-1544C7-----------------------------
INT 15 - Olivetti Quaderno - WRITE LCD
	AX = 44C7h
	DX = hex display
	    FFFFh display clock and "HI", "Md", or "Lo"
		BH,BL,CL unused
	    other: display specified hex number in first four positions
		BH = left alphanumeric character on display (see AX=44C6h)
		BL = right alphanumeric character on display (see AX=44C6h)
		CL = flags
		    bit 0: right colon on
		    bit 1: left colon on
		    bits 2-7 unused
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C6h
--------b-1544C8-----------------------------
INT 15 - Olivetti Quaderno - ???
	AX = 44C8h
	CL = ??? (00h,02h,21h)
	CH = ???
	???
Return: ???
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C9h
--------b-1544C9-----------------------------
INT 15 - Olivetti Quaderno - GET XBIOS VERSION
	AX = 44C9h
Return: AL = major version
	AH = minor version
Note:	this function is also supported by XBIOS.COM
--------b-154600-----------------------------
INT 15 - Compaq SLT/286 - READ POWER CONSERVATION/MODEM CONFIGURATION
	AX = 4600h
Return: AH = modem configuration information
	    bit 0 powerup state (0 off, 1 on)
	    bit	1 modem installed
	    bit	2 IRQ line assignment (0 IRQ 4, 1 IRQ 3)
	    bit 3 COM port assignment (0 = COM 2, 1 = COM 1)
	    bit 4 modem state (0 not assigned, 1 assigned)
	    bit 5 modem is on
	AL = power conservation status information
	    bit 0  power source (0 internal, 1 external)
	    bits 1-2 low battery state
		    00 no low battery condition
		    01 low battery 1
		    10 reserved
		    11 low battery 2
	    bits 3-4 power conservation mode
		    00 automatic
		    01 on
		    10 off
		    11 reserved
	BH = default system inactivity timeout (1-21 minutes)
	BL = current system inactivity timeout (1-21 minutes)
	CH = default video display inactivity timeout (1-63 minutes)
	CL = current video display inactivity timeout (1-63 minutes)
	DH = default fixed disk drive inactivity timeout (1-21 minutes)
	DL = current fixed disk drive inactivity timeout (1-21 minutes)
SeeAlso: AX=4280h,AX=4601h,INT 77
--------b-154601-----------------------------
INT 15 - Compaq SLT/286 - MODIFY POWER CONSERVATION/MODEM CONFIGURATION
	AX = 4601h
	BL = system inactivity timeout (1-21 minutes)
	    FFh do not change
	CL = video display inactivity timeout (1-63 minutes)
	    FFh do not change
	DL = current fixed disk drive inactivity timeout (1-21 minutes)
	    FFh do not change
	DH = new modem state (00h turn off, 01h turn on, FFh don't change)
Return: CF clear if successful
	    AH = 00h
	    BL = current system inactivity timeout (1-21 minutes)
	    CL = current video display inactivity timeout (1-63 minutes)
	    DL = current fixed disk drive inactivity timeout (1-21 minutes)
	    DH = modem state (FFh unchanged, 00h turned off, 01h turned on)
	CF set on error
	    AH = error code
		01h input is out of range
		02h no modem present
SeeAlso: AX=4600h,INT 77
--------b-154604-----------------------------
INT 15 - Compaq Contura 486 and "Alladin" 08/05/93 ROMs - GET ???
	AX = 4604h
Return: CF clear if successful
	    AL = byte read from I/O port 03F8h
	CF set on error (not supported)
	    AH = 86h (unsupported function)
Note:	also supported by 7/26/93 LTE Lite 386 ROM
--------b-154605-----------------------------
INT 15 - Compaq Contura 486 and "Alladin" 08/05/93 ROMs - ???
	AX = 4605h
Return: CF clear if successful
	CF set on error (not supported)
	    AH = 86h (unsupported function)
Note:	this function is a NOP (other than clearing CF) in the 08/05/93 version
	  of the Contura 486/486c/486cx and "Aladdin" ROM, and the 7/26/93
	  LTE Lite 386 ROM
--------D-154900-----------------------------
INT 15 - Far East MS-DOS - GET DOS TYPE
	AX = 4900h
Return: CF clear if successful
	    AH = 00h
	    BL = type of DOS running
		00h DOS/V
		01h DOS/J or DOS/K (early IBM Japan versions of MS-DOS)
	CF set on error
	    AH = 86h (function not supported)
Note:	in practice, DOS/J returns AH=86h; AX DOS does not support this call
SeeAlso: INT 21/AH=30h
--------b-154DD4-----------------------------
INT 15 - HP 95LX - INSTALLATION CHECK
	AX = 4DD4h
Return: BX = 4850h ("HP") if HP 95LX
	    CX = ??? (0101h)
	    DL = ??? (00h)
SeeAlso: INT 0B"HP 95LX",INT 0F"HP 95LX",INT 5F/AH=00h,INT 60/DI=0100h
SeeAlso: INT 61"HP 95LX"
--------b-154E-------------------------------
INT 15 - HP 95LX - ENABLE/DISABLE LIGHT SLEEP
	AH = 4Eh
	AL = light sleep
	    00h disabled
	    01h enabled
Note:	when light sleep is disabled, the system will continue running at full
	  speed; when enabled, it may automatically slow to conserve batteries
SeeAlso: INT 06"HP 95LX",INT 60/DI=0100h
--------B-154F-------------------------------
INT 15 C - KEYBOARD - KEYBOARD INTERCEPT (AT model 3x9,XT2,XT286,CONV,PS)
	AH = 4Fh
	AL = hardware scan code
	CF set
Return: CF set
	   AL = hardware scan code
	CF clear
	   scan code should be ignored
Note:	called by INT 09 handler to translate scan codes; the INT 09 code does
	  not examine the scan code it reads from the keyboard until after
	  this function returns.  This permits software to rearrange the
	  keyboard; for example, swapping the CapsLock and Control keys, or
	  turning the right Shift key into Enter.
SeeAlso: INT 09,INT 15/AH=C0h
--------T-1550-------------------------------
INT 15 - VMIX v2.???+ - "sys_vm_page" - SET NEW VIRTUAL PAGE TABLE
	AH = 50h
	BX = segment of page directory table
	CX = page number of page table
SeeAlso: AH=10h"VMiX",AH=51h"VMiX",AH=52h"VMiX"
--------T-1551-------------------------------
INT 15 - VMiX v2.???+ - "sys_vm_func" - EXECUTE FUNCTION IN PROTECTED MODE
	AH = 51h
	STACK:	DWORD	selector:offset of function
Return: registers as returned by function
Note:	executes function with privilege level 0 (highest privilege)
SeeAlso: AH=10h"VMiX",AH=52h"VMiX"
--------B-155101-----------------------------
INT 15 - SYSTEM - later PS/2s - EXPANSION UNIT, RETURN CONFIGURATION NUMBER
	AX = 5101h
Return: CF set if successful
	    AH = 00h
	    AL = current configuration number
		00h system unit only
		FFh configuration not recognized
	    BX = status flag
		bits 0-14: reserved
		bit 15: additional data is available (location TBD)
	CF clear on error
	    AH = status
		01h expansion unit is not present
		86h function not supported
Note:	CF convention is the reverse of the standard convention for this
	  interrupt.  (Perhaps a typo in the IBM BIOS Tech Ref?)
--------T-1552-------------------------------
INT 15 - VMiX v2.???+ - "sys_vm_init" - INITIALIZE PROTECTED-MODE ENVIRONMENT
	AH = 52h
SeeAlso: AH=50h"VMiX",AH=51h"VMiX"
--------p-155300BX0000-----------------------
INT 15 - Advanced Power Management Specification - INSTALLATION CHECK
	AX = 5300h
	BX = 0000h (device ID of system BIOS)
Return: CF clear if successful
	    AH = major version (BCD)
	    AL = minor version (BCD)
	    BX = 504Dh ("PM")
	    CX = flags
		bit 0: 16-bit protected mode interface supported
		bit 1: 32-bit protected mode interface supported
		bit 2: CPU idle call reduces processor speed
		bit 3: BIOS power management disabled
		bits 4-7 reserved
	CF set on error
	    AH = error code (86h) (see below)

Values for error code:
 01h	power management functionality disabled
 02h	interface connection already in effect
 03h	interface not connected
 04h	real-mode interface not connected
 05h	16-bit protected-mode interface already connected
 06h	16-bit protected-mode interface not supported
 07h	32-bit protected-mode interface already connected
 08h	32-bit protected-mode interface not supported
 09h	unrecognized device ID
 0Ah	invalid parameter value in CX
 0Bh-1Fh reserved for other interface and general errors
 20h-3Fh reserved for CPU errors
 40h-5Fh reserved for device errors
 60h	can't enter requested state
 61h-7Fh reserved for other system errors
 80h	no power management events pending
 81h-85h reserved for other power management event errors
 86h	APM not present
 87h-9Fh reserved for other power management event errors
--------p-155301BX0000-----------------------
INT 15 - Advanced Power Management Specification - CONNECT REAL-MODE INTERFACE
	AX = 5301h
	BX = 0000h (device ID of system BIOS)
Return: CF clear if successful
	CF set on error
	    AH = error code (02h,09h) (see AX=5300h)
SeeAlso: AX=5302h,AX=5303h,AX=5304h
--------p-155302BX0000-----------------------
INT 15 R - Advanced Power Management Spec - CONNECT 16-BIT PROTMODE INTERFACE
	AX = 5302h
	BX = 0000h (device ID of system BIOS)
Return: CF clear if successful
	    AX = real-mode segment base address of protected-mode 16-bit code
		segment
	    BX = offset of entry point
	    CX = real-mode segment base address of protected-mode 16-bit data
		segment
	CF set on error
	    AH = error code (05h,06h,09h) (see AX=5300h)
Notes:	the caller must initialize two consecutive descriptors with the
	  returned segment base addresses; these descriptors must be valid
	  whenever the protected-mode interface is called, and will have
	  their limits arbitrarily set to 64K.
	the protected mode interface is invoked by making a far call with the
	  same register values as for INT 15; it must be invoked while CPL=0,
	  the code segment descriptor must have a DPL of 0, the stack must be
	  in a 16-bit segment and have enough room for BIOS use and possible
	  interrupts, and the current I/O permission bit map must allow access
	  to the I/O ports used for power management.
	functions 00h-03h are not available from protected mode
SeeAlso: AX=5301h,AX=5303h,AX=5304h
--------p-155303BX0000-----------------------
INT 15 - Advanced Power Management Spec - CONNECT 32-BIT PROTMODE INTERFACE
	AX = 5303h
	BX = 0000h (device ID of system BIOS)
Return: CF clear if successful
	    AX = real-mode segment base address of protected-mode 32-bit code
		segment
	    EBX = offset of entry point
	    CX = real-mode segment base address of protected-mode 16-bit code
		segment
	    DX = real-mode segment base address of protected-mode 16-bit data
		segment
	CF set on error
	    AH = error code (07h,08h,09h) (see AX=5300h)
Notes:	the caller must initialize three consecutive descriptors with the
	  returned segment base addresses for 32-bit code, 16-bit code, and
	  16-bit data, respectively; these descriptors must be valid whenever
	  the protected-mode interface is called, and will have their limits
	  arbitrarily set to 64K.
	the protected mode interface is invoked by making a far call to the
	  32-bit code segment with the same register values as for INT 15; it
	  must be invoked while CPL=0, the code segment descriptor must have a
	  DPL of 0, the stack must be in a 32-bit segment and have enough room
	  for BIOS use and possible interrupts, and the current I/O permission
	  bit map must allow access to the I/O ports used for power management.
	functions 00h-03h are not available from protected mode
SeeAlso: AX=5301h,AX=5302h,AX=5304h
--------p-155304BX0000-----------------------
INT 15 - Advanced Power Management Specification - DISCONNECT INTERFACE
	AX = 5304h
	BX = 0000h (device ID of system BIOS)
Return: CF clear if successful
	CF set on error
	    AH = error code (03h,09h) (see AX=5300h)
SeeAlso: AX=5301h,AX=5302h,AX=5303h
--------p-155305-----------------------------
INT 15 - Advanced Power Management Specification - CPU IDLE
	AX = 5305h
Return: after system leaves idle state
	CF clear
Notes:	call when the system is idle and should be suspended until the next
	  system event or interrupt
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
	if an interrupt causes the system to resume normal processing, the
	  interrupt may or may not have been handled when the BIOS returns
	  from this call; thus, the caller should allow interrupts on return
	interrupt handlers may not retain control if the BIOS allows
	  interrupts while in idle mode even if they are able to determine
	  that they were called from idle mode
	the caller should issue this call continuously in a loop until it needs
	  to perform some processing of its own
SeeAlso: AX=1000h,AX=5306h,INT 2F/AX=1680h
--------p-155306-----------------------------
INT 15 - Advanced Power Management Specification - CPU BUSY
	AX = 5306h
Return: CF clear
Notes:	called to ensure that the system runs at full speed even on systems
	  where the BIOS is unable to recognize increased activity (especially
	  if interrupts are hooked by other programs and not chained to the
	  BIOS)
	this call may be made even when the system is already running at full
	  speed, but it will create unnecessary overhead
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
SeeAlso: AX=5305h
--------p-155307-----------------------------
INT 15 - Advanced Power Management Specification - SET POWER STATE
	AX = 5307h
	BX = device ID (see below)
	CX = system state ID
	    0000h ready (not supported for device ID 0001h)
	    0001h stand-by
	    0002h suspend
	    0003h off (not supported for device ID 0001h)
	    0004h-FFFFh reserved
Return: CF clear if successful
	CF set on error
	    AH = error code (01h,09h,0Ah,60h) (see AX=5300h)
Note:	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems

Values for device IDs:
 0000h	system BIOS
 0001h	all devices for which the system BIOS manages power
 01xxh	display (01FFh for all attached display devices)
 02xxh	secondary storage (02FFh for all attached secondary storage devices)
 03xxh	parallel ports (03FFh for all attached parallel ports)
 04xxh	serial ports (04FFh for all attached serial ports)
 0500h-FFFFh reserved
--------p-155307BX0001-----------------------
INT 15 - Advanced Power Management Specification - SYSTEM STAND-BY
	AX = 5307h
	BX = 0001h
	CX = 0001h
Return: CF clear
Notes:	puts the entire system into stand-by mode; normally called in response
	  to a System Stand-by Request notification after any necessary
	  processing, but may also be invoked at the caller's discretion
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
	the stand-by state is typically exited on an interrupt
SeeAlso: AX=4280h,AX=5307h/BX=0001h/CX=0002h,AX=530Bh
--------p-155307BX0001-----------------------
INT 15 - Advanced Power Management Specification - SUSPEND SYSTEM
	AX = 5307h
	BX = 0001h
	CX = 0002h
Return: after system is resumed
	CF clear
Notes:	puts the entire system into a low-power suspended state; normally
	  called in response to a Suspend System Request notification after
	  any necessary processing, but may also be invoked at the caller's
	  discretion
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
	the caller may need to update its date and time values because the
	  system could have been suspended for a long period of time
SeeAlso: AX=5307h/BX=0001h/CX=0001h,AX=530Bh
--------p-155308BXFFFF-----------------------
INT 15 - Advanced Power Management Spec - ENABLE/DISABLE POWER MANAGEMENT
	AX = 5308h
	BX = FFFFh
	CX = new state
	    0000h disabled
	    0001h enabled
Return: CF clear if successful
	CF set on error
	    AH = error code (01h,09h,0Ah) (see AX=5300h)
Notes:	when power management is disabled, the system BIOS will not
	  automatically power down devices, enter stand-by or suspended mode,
	  or perform any power-saving actions in response to AX=5305h calls
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
SeeAlso: AX=5309h
--------p-155309BXFFFF-----------------------
INT 15 - Advanced Power Management Specification - RESTORE POWER-ON DEFAULTS
	AX = 5309h
	BX = FFFFh
Return: CF clear if successful
	CF set on error
	    AH = error code (09h) (see AX=5300h)
Note:	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
SeeAlso: AX=5308h
--------p-15530ABX0001-----------------------
INT 15 - Advanced Power Management Specification - GET POWER STATUS
	AX = 530Ah
	BX = 0001h
Return: CF clear if successful
	    BH = AC line status
		00h off-line
		01h on-line
		FFh unknown
		other reserved
	    BL = battery status
		00h high
		01h low
		02h critical
		03h charging
		FFh unknown
		other reserved
	    CL = remaining battery life
		00h-64h (0-100) percentage of full charge
		FFh unknown
	CF set on error
	    AH = error code (09h) (see AX=5300h)
Note:	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
--------p-15530B-----------------------------
INT 15 - Advanced Power Management Specification - GET POWER MANAGEMENT EVENT
	AX = 530Bh
Return: CF clear if successful
	    BX = event code
		0001h system stand-by request
		0002h system suspend request
		0003h normal resume system notification
		0004h critical resume system notification
		0005h battery low notification
	CF set on error
	    AH = error code (03h,80h) (see AX=5300h)
Notes:	although power management events are often asynchronous, notification
	  will not be made until polled via this call to permit software to
	  only receive event notification when it is prepared to process
	  power management events; since these events are not very time-
	  critical, it should be sufficient to poll once or twice per second
	the critical resume notification is made after the system resumes
	  from an emergency suspension; normally, the system BIOS only notifies
	  its partner that it wishes to suspend and relies on the partner to
	  actually request the suspension, but no notification is made on an
	  emergency suspension
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
SeeAlso: AX=5307h,AX=5307h/BX=0001h/CX=0001h,AX=5307h/BX=0001h/CX=0002h
--------T-155400-----------------------------
INT 15 C - Omniview Multitasker - INSTALLATION NOTIFICATION
	AX = 5400h
	ES:BX -> device information tables
	DI:DX -> dispatcher entry point
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5407h,INT 2F/AX=DE00h
--------T-155401-----------------------------
INT 15 C - Omniview Multitasker - PROCESS CREATION
	AX = 5401h
	ES:BX = process handle
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5402h,INT 2F/AX=DE04h
--------T-155402-----------------------------
INT 15 C - Omniview Multitasker - PROCESS DESTRUCTION
	AX = 5402h
	ES:DX = process handle
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5401h,INT 2F/AX=DE05h
--------T-155403-----------------------------
INT 15 C - Omniview Multitasker - SAVE
	AX = 5403h
	ES:DX = process swapping out
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5404h,INT 2F/AX=DE08h
--------T-155404-----------------------------
INT 15 C - Omniview Multitasker - RESTORE
	AX = 5404h
	ES:DX = process swapping in
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5403h,INT 2F/AX=DE09h
--------T-155405-----------------------------
INT 15 C - Omniview Multitasker - SWITCHING TO BACKGROUND
	AX = 5405h
	ES:DX = process swapping in
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5406h
--------T-155406-----------------------------
INT 15 C - Omniview Multitasker - SWITCHING TO FOREGROUND
	AX = 5406h
	ES:DX = process swapping in
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5405h
--------T-155407-----------------------------
INT 15 C - Omniview Multitasker - EXIT NOTIFICATION
	AX = 5407h
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5400h,INT 2F/AX=DE03h
--------b-1560------------------------------------
INT 15 - HUNTER 16 - SET SYSTEM CLOCK SPEED
	AH = 60h
	AL = new speed
	    00h normal (8 MHz)
	    01h Slow Mode 1 (4 MHz)
	    02h Slow Mode 2 (2 MHz)
Note:	the Husky Hunter 16 is an 8088-based ruggedized laptop.	 Other family
	  members are the Husky Hunter, Husky Hunter 16/80, and Husky Hawk.
SeeAlso: AX=6301h
--------b-1561------------------------------------
INT 15 - HUNTER 16 - GET POWER LEVEL
	AH = 61h
Return: AH = percentage of full power left (0..100)
Desc:	determine how much battery power is left
SeeAlso: AH=62h,AH=66h,AH=73h"HUNTER"
--------b-1562------------------------------------
INT 15 - HUNTER 16 - SET LOW POWER THRESHOLD
	AH = 62h
	AL = level (00h 5%, 01h 10%, ... 12h 95%)
	BX = interval between power low warnings in seconds (1..600)
Return: AH = Status
Desc:	set the level (relative to full power) when power-low warnings begin
	  and the interval between the warnings
SeeAlso: AH=61h,AH=65h,AH=66h
--------b-156300----------------------------------
INT 15 - HUNTER 16 - GET IDLE TIMEOUT
	AX = 6300h
Return: AH = status
	BX = timeout in seconds (0-3600)
Desc:	get the idle timeout value, the interval without keyboard or
	   communications activity before the system shuts down
SeeAlso: AX=6301h
--------b-156301----------------------------------
INT 15 - HUNTER 16 - SET IDLE TIMEOUT
	AX = 6301h
	BX = timeout in seconds (0-3600)
Desc:	sets the idle timeout value, the interval without keyboard or
	  communications activity before the system shuts down
SeeAlso: AX=6300h
--------b-1564------------------------------------
INT 15 - HUNTER 16 - CONTROL RESUME MODE
	AH = 64h
	AL = new state
	    00h disable Resume mode
	    01h enable Resume mode
Return: AH = status
Desc:	turn Resume mode on or off. In Resume mode the system starts in
	  the application that was running when it shut down as if nothing 
	  had happened.
SeeAlso: AH=67h,AH=68h,AH=69h
--------b-1565------------------------------------
INT 15 - HUNTER 16 - AUTHORISE CHARGING
	AH = 65h
	AL = charging level
	    01h charging not allowed
	    02h charging allowed until power down
	    03h charging allowed until batteries changed or fail.
		Ask user if charging is still allowed on next poweron
	    04h charging allowed indefinitely
	BX = 0203h
	CX = 0405h
	DX = 0607h
Return: AH = status
SeeAlso: AH=66h,AH=68h
--------b-1566------------------------------------
INT 15 - HUNTER 16 - SET BATTERY LEVEL
	AH = 66h
	AL = level in percent of maximum (0..100)
Return: AH = status
SeeAlso: AH=61h,AH=65h
--------b-1567------------------------------------
INT 15 - HUNTER 16 - CONTROL STOP MODE
	AH = 67h
	AL = mode when waiting for input
	    00h use STOP mode (allows communication)
	    01h use HALT mode (disallows communication)
Return: AH = status
Desc:	select the power save mode to use when waiting for input
SeeAlso: AH=69h
--------b-1568------------------------------------
INT 15 - HUNTER 16 - REQUEST POWER DOWN
	AH = 68h
Desc:	turns off the Hunter 16 if power down is allowed (see AH=69h)
SeeAlso: AH=69h
--------b-1569------------------------------------
INT 15 - HUNTER 16 - CONTROL POWER DOWN AVAILABILITY
	AH = 69h
	AL = mode
	    00h inhibit power down
	    01h allow power down
Return: AH = status
SeeAlso: AH=67h,AH=68h,AH=6Ah
--------b-156A------------------------------------
INT 15 - HUNTER 16 - CONTROL SLOW MODE
	AH = 6Ah
	AL = mode
	    00h inhibit Slow mode
	    01h allow Slow mode
Return: AH = status
SeeAlso: AH=69h
--------b-156B------------------------------------
INT 15 - HUNTER 16 - GET ROM BIOS VERSION
	AH = 6Bh
Return: BH = version number (ASCII)
	BL = release number (ASCII)
	CH = minor release number (ASCII)
	CL = minor release number (ASCII)
SeeAlso: AH=6Ch
--------b-156C------------------------------------
INT 15 - HUNTER 16 - GET SERIAL NUMBER
	AH = 6Ch
Return: BL:CX = BCD serial number
Note:	when shipped, all Hunter 16s have the same Serial Number, but a
	  different number can be stored (see AH=72h)
SeeAlso: AH=6Bh,AH=72h
--------b-156D------------------------------------
INT 15 - HUNTER 16 - GET EVENT DETAIL
	AH = 6Dh
Return: AH = 00h if successful
	CX:BX = event flags bit 0..31 (see below)
Note:	this function allows testing for events
SeeAlso: AH=6Eh,AH=6Fh

Bitfields for events:
 bit 0	PWR button pressed
 bit 1	error on COM1
 bit 2	error on COM2
 bit 3	data received on COM1
 bit 4	data received on COM2
 bit 5	RTC Alarm
 bit 6	RI received
--------b-156E------------------------------------
INT 15 - HUNTER 16 - ENABLE/TRAP EVENT
	AH = 6Eh
	AL = Software Interrupt
	      00h  do not trap event
	      else trap as software interrupt number AL
	BH = event number (see AH=6Dh)
	BL = enable mask
	    00h disable event
	    01h enable event
Return: AH = 00h if successful
SeeAlso: AH=6Dh,AH=6Fh
--------b-156F------------------------------------
INT 15 - HUNTER 16 - ACKNOWLEDGE EVENT
	AH = 6Fh
	AL = event number (see AH=6Dh)
Return: AH = 00h if successful
Desc:	Acknowledges the event, so the next similar event can be detected 
SeeAlso: AH=6Dh"HUNTER",AH=6Eh
----------157000-----------------------------
INT 15 - Tandy 1000SL/TL - READ FROM EEPROM
	AX = 7000h
	BL = number of word to read (00h-3Fh)
Return: CF clear if function supported
	    DX = contents of EEPROM word
Note:	newer Tandy 1000-series machines use EEPROM instead of CMOS RAM in
	  the clock chip to store system configuration information
SeeAlso: AX=7001h
----------157001-----------------------------
INT 15 - Tandy 1000SL/TL - WRITE TO EEPROM
	AX = 7001h
	BL = number of word to read (00h-3Fh)
	DX = new value for EEPROM word
Return: CF clear if function supported
Note:	the EEPROMs are normally written only by the system setup program;
	  changing the values can badly mess up a Tandy
SeeAlso: AX=7000h
--------b-1570------------------------------------
INT 15 - HUNTER 16 - CONTROL SOUND
	AH = 70h
	AL = new state
	    00h disable sound
	    else enable sound
Note:	the Husky Hunter 16 is an 8088-based ruggedized laptop.	 Other family
	  members are the Husky Hunter, Husky Hunter 16/80, and Husky Hawk.
--------b-1571------------------------------------
INT 15 - HUNTER 16 - SELECT POWER UP KEYS
	AH = 71h
	BL = column
	BH = row
	AL = column switch (00h disable, 01h enable)
	CL = row switch (00h disable, 01h enable)
Return: AH = status
SeeAlso: AH=7Bh,AH=88h
--------b-157200----------------------------------
INT 15 - HUNTER 16 - RESET SERIAL NUMBER
	AX = 7200h
Return: AH = 00h if successful
Desc:	reset the serial number to the default serial number present when the
	  Hunter 16 was shipped
SeeAlso: AH=6Ch,AH=72h
--------b-1572------------------------------------
INT 15 - HUNTER 16 - REDIRECT SERIAL NUMBER
	AH = 72h
	AL nonzero
	DS:BX -> new serial number (6 ASCII digits)
Return: AH = 00h if successful
Desc:	install a new serial number
SeeAlso: AH=6Ch,AX=7200h
--------b-1573------------------------------------
INT 15 - HUNTER 16 - GET ORACLE GT POWER LEVEL
	AH = 73h
	AL = drive (0: A:, 1: B:)
Return: AH = status
	    00h successful
	    FFh Oracle GT drive not connected
	AL = power level in percent of maximum (0..100)
Desc:	get the power remaining in the Oracle GT batteries
SeeAlso: AH=61h
--------b-1574------------------------------------
INT 15 - HUNTER 16 - SET BACKLIGHT POWER UP STATE
	AH = 74h
	AL = new level
	    01h off
	    02h unchanged
	    03h change level
		BL = desired level (00h-7Fh)
Return: AH = status
Desc:	select the backlight level to use when the Hunter is next turned on
SeeAlso: AH=64h,AH=75h,INT 10/AH=64h,INT 10/AH=78h
--------b-1575------------------------------------
INT 15 - HUNTER 16 - SET CONTRAST POWER UP STATE
	AH = 75h
	AL = new level
	    01h off
	    02h unchanged
	    03h change level
		BL = desired level (00h-7Fh)
Return: AH = status
Desc:	select the LCD contrast level to use when the Hunter is next turned on
SeeAlso: AH=63h,AH=74h
--------b-1576------------------------------------
INT 15 - HUNTER 16 - CONTROL POWER SAVE
	AH = 76h
	BX = Control
	     bit 0 power save enabled
	     bit 1 inhibit power save when waiting for COM1 data
	     bit 2 inhibit power save when waiting for COM2 data
	     bit 3 inhibit power save when waiting for data from barcode wand
	     bit 4 inhibit power up on timer tick
SeeAlso: AH=74h
--------b-1579------------------------------------
INT 15 - HUNTER 16 - REDIRECT LPT1
	AH = 79h
	AL = port to which to redirect (00h COM1, 01h COM2)
--------b-157A------------------------------------
INT 15 - HUNTER 16 - INVOKE HOT KEY
	AH = 7Ah
Desc:	this function has the same effect as pressing the HOT key
SeeAlso: AH=7Bh
--------b-157B------------------------------------
INT 15 - HUNTER 16 - CONTROL HOT KEY
	AH = 7Bh
	AL = 00h prevent HOT key
	    else allow HOT key
Desc:	Allow or prevent the HOT key function which is used to examine and
	  change the Hunter setup
SeeAlso: AH=71h,AH=7Ah,AH=7Ch
--------b-157C------------------------------------
INT 15 - HUNTER 16 - CONTROL HOT KEY POWER OPTION
	AH = 7Ch
	AL = 00h prevent HOT key power option
	    else allow HOT key power option
Desc:	allow or prevent changing the power options
SeeAlso: AH=7Bh,AH=7Dh
--------b-157D------------------------------------
INT 15 - HUNTER 16 - OVERRIDE LOW POWER TURN OFF
	AH = 7Dh
	AL = 00h turn off after 10 warnings
	    else never turn off
Desc:	specify whether the Hunter 16 turns off after 10 low power warnings
SeeAlso: AH=7Ch
--------b-157E------------------------------------
INT 15 - HUNTER 16 - CONTROL BATTERY CHANGE FACILITIES (APM)
	AH = 7Eh
	AL = 00h do not prompt
	    else prompt
Desc:	select whether the user is prompted for the battery state if the
	  battery cap has been off when the system is turned on
SeeAlso: AH=7Fh
--------b-157F------------------------------------
INT 15 - HUNTER 16 - SET BATTERY TYPE (APM)
	AH = 7Fh
	AL = battery type
	    00h	 non-rechargeable
	    else rechargeable
SeeAlso: AH=7Eh
--------B-1580-------------------------------
INT 15 C - OS HOOK - DEVICE OPEN (AT,XT286,PS)
	AH = 80h
	BX = device ID
	CX = process ID
	CF clear
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status
		80h invalid command (PC,PCjr)
		86h function not supported (XT)
Note:	this function should be hooked by a multitasker which wishes to keep
	  track of device ownership; the default BIOS handler merely returns
	  successfully
SeeAlso: AH=81h,AH=82h
--------b-1580------------------------------------
INT 15 - HUNTER 16 - GET/SET BATTERY CAPACITY (APM)
	AH = 80h
	AL = function
	    00h get
		Return: AL = capacity (500mA + AL * 50mA, max 40 = 2500mA)
	    else set
		BL = battery capacity (same as AL above)
SeeAlso: AH=61h"HUNTER",AH=81h"HUNTER"
--------B-1581-------------------------------
INT 15 C - OS HOOK - DEVICE CLOSE
	AH = 81h
	BX = device ID
	CX = process ID
	CF clear
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (see AH=80h)
Note:	this function should be hooked by a multitasker which wishes to keep
	  track of device ownership; the default BIOS handler merely returns
	  successfully
SeeAlso: AH=80h,AH=82h
--------b-1581------------------------------------
INT 15 - HUNTER 16 - CONTROL POWER OUTPUT
	AH = 81h
	AL = new state of power output (00h off, nonzero on)
Desc:	turn the +5V low power output on or off
SeeAlso: AH=80h"HUNTER"
--------B-1582-------------------------------
INT 15 C - OS HOOK - PROGRAM TERMINATION
	AH = 82h
	BX = process ID
	CF clear
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (see AH=80h)
Notes:	closes all devices opened by the given process ID with function 80h
	this function should be hooked by a multitasker which wishes to keep
	  track of device ownership; the default BIOS handler merely returns
	  successfully
SeeAlso: AH=80h,AH=81h
--------b-1582------------------------------------
INT 15 - HUNTER 16 - SOUND OUTPUT
	AH = 82h
	DX = length (duration in seconds = DX * 666670 / frequency)
	BX = pitch (see below)
Desc:	Sound the tone specified in BX for the duration in DX
SeeAlso: AX=1019h

Values for pitch:
BX(dec)	 Note	Frequency	BX(dec)	 Note	Frequency
  425	G	1568.000	 1515	A	 440.000
  451	F#	1479.503	 1605	G#	 415.307
  477	F	1396.900	 1701	G	 392.000
  506	E	1318.500	 1802	F#	 369.998
  536	D#	1244.523	 1909	F	 349.230
  568	D	1174.700	 2022	E	 329.630
  601	C#	1108.749	 2143	D#	 311.127
  637	C	1046.500	 2270	D	 293.660
  675	B	 958.770	 2405	C#	 277.183
  715	A#	 932.329	 2548	MID C	 261.630
  758	A	 880.000	 2700	B	 246.940
  803	G#	 830.609	 2860	A#	 233.081
  850	G	 783.990	 3030	A	 220.000
  901	F#	 739.990	 3210	G#	 207.654
  954	F	 698.460	 3401	G	 196.000
 1011	E	 659.260	 3604	F#	 184.996
 1071	D#	 622.257	 3818	F	 174.610
 1135	D	 587.330	 4045	E	 164.810
 1203	C#	 554.365	 4286	D#	 155.560
 1274	C	 523.250	 4540	D	 146.830
 1350	B	 493.880	 4668	C#	 142.827
 1430	A#	 466.162	 4803	C	 138.810
--------B-1583-------------------------------
INT 15 - BIOS - SET EVENT WAIT INTERVAL (AT,PS50+)
	AH = 83h
	AL = subfunction
	    00h set interval
		CX:DX = microseconds to delay
		ES:BX -> byte whose high bit is to be set at end of interval
	    01h cancel wait interval
Return: CF set on error or function already busy
	    AH = status
		80h invalid command (PC,PCjr)
		86h function not supported (XT and later)
	CF clear if successful
Notes:	the resolution of the wait period is 977 microseconds on most systems
	  because most BIOSes use the 1/1024 second fast interrupt from the AT
	  real-time clock chip which is available on INT 70
	IBM AT 1/10/84 BIOS ignores AL and always performs subfunction 00h
SeeAlso: AH=41h,AH=86h,INT 70
--------b-1583------------------------------------
INT 15 - HUNTER 16 - CONTROL SCREEN SYNCHRONISATION
	AH = 83h
	AL = state of LCD window (00h disabled, nonzero enabled)
Desc:	Enable/disable the facility where the displayed window tracks the
	  cursor output to keep the focus visible
--------B-1584-------------------------------
INT 15 - BIOS - JOYSTICK SUPPORT (XT after 11/8/82,AT,XT286,PS)
	AH = 84h
	DX = subfunction
	    0000h read joystick switches
		Return: AL bits 7-4 = switch settings
	    0001h read positions of joysticks
		Return: AX = X position of joystick A
			BX = Y position of joystick A
			CX = X position of joystick B
			DX = Y position of joystick B
Return: CF set on error
	    AH = status
		80h invalid command (PC,PCjr)
		86h function not supported (other)
	CF clear if successful
Notes:	if no game port is installed, subfunction 0000h returns AL=00h (all
	  switches open) and subfunction 0001h returns AX=BX=CX=DX=0000h
	a 250kOhm joystick typically returns 0000h-01A0h
--------b-158400----------------------------------
INT 15 - HUNTER 16 - GET DISKETTE PORT
	AX = 8400h
	BH = Drive (0: A:, 1: B:)
Return: AL = Port (0: COM1, >0: COM2)
Desc:	return the COM port used for the floppy drive
SeeAlso: AX=8401h
--------b-158401----------------------------------
INT 15 - HUNTER 16 - SET DISKETTE PORT
	AX = 8401h
	BH = Drive (0: A:, 1: B:)
	BL = Port (0: COM1, >0: COM2)
Desc:	set the COM port used for the floppy drive
SeeAlso: AX=8400h
--------B-1585-------------------------------
INT 15 C - OS HOOK - SysRq KEY ACTIVITY (AT,PS)
	AH = 85h
	AL = SysRq key action (00h pressed, 01h released)
	CF clear
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (see AH=84h)
Notes:	called by keyboard decode routine
	the default handler simply returns successfully; programs which wish
	  to monitor the SysRq key must hook this call
SeeAlso: INT 09
--------b-158500----------------------------------
INT 15 - HUNTER 16 - RESTORE POWER MENU (APM)
	AX = 8500h
Desc:	restore the standard power menu
SeeAlso: AX=8501h"HUNTER"
--------b-158501----------------------------------
INT 15 - HUNTER 16 - SET POWER MENU (APM)
	AX = 8501h
	BL = user software interrupt number
Desc:	install an alternate power menu routine
SeeAlso: AX=8500h"HUNTER"
--------B-1586-------------------------------
INT 15 - BIOS - WAIT (AT,PS)
	AH = 86h
	CX:DX = interval in microseconds
Return: CF clear if successful (wait interval elapsed)
	CF set on error or AH=83h wait already in progress
	    AH = status (see AH=84h)
Note:	the resolution of the wait period is 977 microseconds on most systems
	  because most BIOSes use the 1/1024 second fast interrupt from the AT
	  real-time clock chip which is available on INT 70
SeeAlso: AH=41h,AH=83h,INT 1A/AX=FF01h,INT 70
--------b-1586------------------------------------
INT 15 - HUNTER 16 - GET/SET SCREEN ATTRIBUTE TABLE
	AH = 86h
	AL = function (00h get, nonzero set)
	BX = 1234h
	DS:SI -> 256-byte Attribute buffer
Note:	In text modes each character has its attribute byte XOR'd with the
	  corresponding byte in the attribute table.  If the attribute is 15,
	  15 is XOR'd with Table[15]
--------B-1587-------------------------------
INT 15 - SYSTEM - COPY EXTENDED MEMORY
	AH = 87h
	CX = number of words to copy (max 8000h)
	ES:SI -> global descriptor table
Return: CF set on error
	CF clear if successful
	AH = status
	    00h source copied into destination
	    01h parity error
	    02h interrupt error
	    03h address line 20 gating failed
	    80h invalid command (PC,PCjr)
	    86h unsupported function (XT,PS30)
Notes:	copy is done in protected mode with interrupts disabled by the default
	  BIOS handler; many 386 memory managers perform the copy with
	  interrupts enabled
	this function is incompatible with the OS/2 compatibility box
SeeAlso: AH=88h,AH=89h

Format of global descriptor table:
Offset	Size	Description
 00h 16 BYTEs	zeros
 10h	WORD	source segment length in bytes (2*CX-1 or greater)
 12h  3 BYTEs	24-bit linear source address, low byte first
 15h	BYTE	source segment access rights (93h)
 16h	WORD	zero
 18h	WORD	destination segment length in bytes (2*CX-1 or greater)
 1Ah  3 BYTEs	24-bit linear destination address, low byte first
 1Dh	BYTE	destination segment access rights (93h)
 1Eh 18 BYTEs	zeros
--------b-1587------------------------------------
INT 15 - HUNTER 16 - SET INT 72h VECTOR
	AH = 87h
	DS:DX = new service routine
Desc:	set the INT 72h vector which is called in 2 cases:
	  - when the machine is about to turn off or reboot, INT 72h is called
	    with AH=0
	  - when the machine is powering up INT 72h is called with AH=01h
Note:	the actual INT 72h vector must also be changed with INT 21/AH=25h
--------B-1588-------------------------------
INT 15 - SYSTEM - GET EXTENDED MEMORY SIZE (286+)
	AH = 88h
Return: CF clear if successful
	    AX = number of contiguous KB starting at absolute address 100000h
	CF set on error
	    AH = status
		80h invalid command (PC,PCjr)
		86h unsupported function (XT,PS30)
Notes:	TSRs which wish to allocate extended memory to themselves often hook
	  this call, and return a reduced memory size.	They are then free to
	  use the memory between the new and old sizes at will.
	the standard BIOS only returns memory between 1MB and 16MB; use AH=C7h
	  for memory beyond 16MB
	not all BIOSes correctly return the carry flag, making this call
	  unreliable unless one first checks whether it is supported through
	  a mechanism other than calling the function and testing CF
SeeAlso: AH=87h,AH=C7h
--------b-1588------------------------------------
INT 15 - HUNTER 16 - GET POWER UP KEYS
	AH = 88h
Return: AH = 00h
	BX = column
	CL = row
SeeAlso: AH=71h
--------B-1589-------------------------------
INT 15 - SYSTEM - SWITCH TO PROTECTED MODE
	AH = 89h
	BL = interrupt number of IRQ0 (IRQ1-7 use next 7 interrupts)
	BH = interrupt number of IRQ8 (IRQ9-F use next 7 interrupts)
	ES:SI -> GDT for protected mode
	       offset 0h  null descriptor (initialize to zeros)
		      8h  GDT descriptor
		     10h  IDT descriptor
		     18h  DS
		     20h  ES
		     28h  SS
		     30h  CS
		     38h  uninitialized, used to build descriptor for BIOS CS
Return: CF set on error
	   AH = FFh  error enabling address line 20
	CF clear if successful
	   AH = 00h
	   in protected mode at specified address
Notes:	BL and BH must be multiples of 8
	the protected-mode CS must reference the same memory as the CS this
	  function is called from because execution continues with the address
	  following the interrupt call
SeeAlso: AH=87h,AH=88h,INT 67/AX=DE0Ch
--------b-158900----------------------------------
INT 15 - HUNTER 16 - GET POWER MODE
	AX = 8900h
Return: AH = 00h
	BL = current power mode
	    00h Standard Power Mode (SPM)
	    01h Advanced Power Mode (APM)
SeeAlso: AX=8901h
--------b-158901----------------------------------
INT 15 - HUNTER 16 - SET POWER MODE
	AX = 8901h
	BL = new mode
	    00h Standard Power Mode (SPM)
	    01h Advanced Power Mode (APM)
Return: AH = 00h
SeeAlso: AX=8900h
--------b-158A------------------------------------
INT 15 - HUNTER 16 - CONTROL POWER INPUT (SPM)
	AH = 8Ah
	AL = new state of Power Input (00h disabled, nonzero enabled)
	SI = 1234h
	DI = 5678h
Return: AH = status
	    00h success
	    FFh failure
Desc:	Enable or disable Power Input. When Power Input is disabled the AC
	  adaptor will neither charge the batteries nor supply power to the
	  Hunter 16. Disable Power Input if using Alkaline batteries.
--------b-158B------------------------------------
INT 15 - HUNTER 16 - GET/SET CHARGER TEMPERATURE OVERRIDE
	AH = 8Bh
	AL = function
	    00h get
		Return:	BH = Maximum charging temperature
				Temp = -20 + (n * 0.63) degrees Centigrade
			BL = Minimum charging temperature
	    else set
		BH = maximum charging temperature (as above)
		BL = minimum charging temperature (as above)
Return: AH = status
	    00h success
	    FFh failure 
Desc:	get/set the temperature interval within which the charger should 
	  operate
--------b-158C------------------------------------
INT 15 - HUNTER 16 - GET/SET POWER SAVE ENTRY FLAG
	AH = 8Ch
	AL = function
	    00h get
		Return: BX = which operations disable power save (see below)
	    else set
		BX = which operations should disable power save (see below)
SeeAlso: AH=8Dh

Bitfields for operations disablign power save:
 bit 0	INT 10h prevents power save
 bit 1	INT 13h prevents power save
 bit 2	INT 14h prevents power save
 bit 3	INT 15h prevents power save
 bit 4	INT 1Ah prevents power save
 bit 5	INT 21h prevents power save
 bit 6	direct write to video RAM prevents power save
 bit 7	access to 8250 UART prevents power save
 bit 8	access to 8253 (Sound) prevents power save
--------b-158D------------------------------------
INT 15 - HUNTER 16 - GET/SET BOOST CHARGE (SPM)
	AH = 8Dh
	AL = function
	    00h get
		Return: AL = Fast Charge state (00h prevented, else allowed)
	    nonzero set
		BH = Fast Charge state (00h prevent, nonzero allow)
Return: AH = status
	    00h success
	    FFh failure
Desc:	control whether Fast Charging (200ma rather than 70ma) is allowed
SeeAlso: AH=8Ch
--------B-1590-------------------------------
INT 15 - OS HOOK - DEVICE BUSY (AT,PS)
	AH = 90h
	AL = device type (see below)
	ES:BX -> request block for type codes 80h through BFh
	CF clear
Return: CF set if wait time satisfied
	CF clear if driver must perform wait
	    AH = 00h
Notes:	type codes are allocated as follows:
	  00-7F non-reentrant devices; OS must arbitrate access
	  80-BF reentrant devices; ES:BX points to a unique control block
	  C0-FF wait-only calls, no complementary INT 15/AH=91h call
	floppy and hard disk BIOS code uses this call to implement a timeout;
	  for device types 00h and 01h, a return of CF set means that the
	  timeout expired before the disk responded.
	this function should be hooked by a multitasker to allow other tasks
	  to execute while the BIOS is waiting for I/O completion; the default
	  handler merely returns with AH=00h and CF clear
SeeAlso: AH=91h,INT 13/AH=00h,INT 17/AH=00h,INT 1A/AH=83h

Values for device type:
 00h	disk
 01h	diskette
 02h	keyboard
 03h	PS/2 pointing device
 21h	waiting for keyboard input (Phoenix BIOS)
 80h	network
 FBh	digital sound (Tandy)
 FCh	disk reset (PS)
 FDh	diskette motor start
 FEh	printer
--------B-1591-------------------------------
INT 15 - OS HOOK - DEVICE POST (AT,PS)
	AH = 91h
	AL = device type (see AH=90h)
	ES:BX -> request block for type codes 80h through BFh
	CF clear
Return: AH = 00h
Note:	this function should be hooked by a multitasker to allow other tasks
	  to execute while the BIOS is waiting for I/O completion; the default
	  handler merely returns with AH=00h and CF clear
SeeAlso: AH=90h
--------b-15BC-------------------------------
INT 15 - Phoenix 386 BIOS - DETERMINE CPU SPEED FOR DELAY LOOPS
	AH = BCh
Return: CF clear
	(Phoenix 1.10 10a) BYTE 0040h:00B0h set to delay loop count
	(Dell 4xxDE BIOS A11) WORD 0040h:00ECh set to delay loop count
Note:	this function reads system timer channel 0 twice, then does
	  calculations on the returned values to determine the delay loop
	  counter needed by the BIOS for beeps and floppy timeouts
--------E-15BF00-----------------------------
INT 15 - Rational Systems DOS/16M - ???
	AX = BF00h
	???
Return: ???
Note:	under DESQview/X 1.02 DVDOS4GX.DVR, this call is identical to AX=BF02h
SeeAlso: AX=BF02h
--------E-15BF01-----------------------------
INT 15 - Rational Systems DOS/16M - ???
	AX = BF01h
	???
Return: ???
Notes:	under DESQview/X 1.02 DVDOS4GX.DVR, this call is identical to AX=BF02h
	called by DOS/4GW
SeeAlso: AX=BF00h,AX=BF02h
--------E-15BF02DX0000-----------------------
INT 15 - Rational Systems DOS/16M - INSTALLATION CHECK
	AX = BF02h
	DX = 0000h
Return: DX = nonzero if installed
	    DX:SI -> XBRK structure (see below)
Note:	this function is also supported by DOS/4G
SeeAlso: AX=BF01h,AX=BFDCh,AX=BFDEh/BX=0000h
SeeAlso: INT 21/AH=FFh/DH=0Eh,INT 2F/AH=A1h,INT 2F/AX=F100h,INT 2F/AX=FBA1h

Format of XBRK structure:
Offset	Size	Description
 00h	DWORD	linear address of first available byte
 04h	DWORD	linear address of last available byte + 1 ???
 08h	DWORD	real-mode address of XBRK structure???
 0Ch	DWORD	???
 10h  2 BYTEs	???
 12h	WORD	segment of ???
 14h  8 BYTEs	???
 1Ch 512 BYTEs	protected-mode IDT
21Ch  N BYTEs	protected-mode GDT
--------E-15BF03-----------------------------
INT 15 - Rational Systems DOS/4GW - UNINSTALL???
	AX = BF03h
	BX = PSP segment of extender
	???
Return: ???
Note:	if BX is not the PSP segment of the extender, it passes the call down
	  the INT 15 chain; this allows nested instances of the extender
SeeAlso: AX=BF06h
--------E-15BF04-----------------------------
INT 15 - Rational Systems DOS/4GW - ???
	AX = BF04h
	BX = PSP segment of extender
Return: nothing???
Notes:	if BX is not the PSP segment of the extender, it passes the call down
	  the INT 15 chain; this allows nested instances of the extender
	grabs INT 2Fh and installs handlers for INT 2F/AX=1605h-1607h
SeeAlso: INT 2F/AX=1607h/BX=22C0h
--------E-15BF05-----------------------------
INT 15 - Rational Systems DOS/4GW - INITIALIZE PROTECTED-MODE INTERFACE
	AX = BF05h
	BX = PSP segment of extender
Return: nothing???
Notes:	if BX is not the PSP segment of the extender, it passes the call down
	  the INT 15 chain; this allows nested instances of the extender
	calls INT 67/AX=DE01h if ???
--------E-15BF06-----------------------------
INT 15 - Rational Systems DOS/4GW - ???
	AX = BF06h
	BX = PSP segment of extender
	???
Return: ???
Note:	if BX is not the PSP segment of the extender, it passes the call down
	  the INT 15 chain; this allows nested instances of the extender
SeeAlso: AX=BF03h
--------E-15BFDCDX0000-----------------------
INT 15 - Rational Systems DOS/4GW - INSTALLATION CHECK
	AX = BFDCh
	DX = 0000h
	SI = 0000h
Return: DX = nonzero if installed
	    DX:SI -> XBRK structure (see AX=BF02h)
SeeAlso: AX=BF02h
--------E-15BFDEBX0000-----------------------
INT 15 - DESQview/X - DVDOS4GX.DVR - INSTALLATION CHECK
	AX = BFDEh
	BX = 0000h
Return: AX = ??? (0003h)
	BX = FFFFh
SeeAlso: AX=BF02h
--------E-15BFDEBX0001-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET PROCESS MANAGER NAME
	AX = BFDEh
	BX = 0001h
Return: BX = 0000h (success)
	CX:DX -> name of process manager executable
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0002-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - SET ???
	AX = BFDEh
	BX = 0002h
	CX:DX -> ???
Return: BX = 0000h (success)
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=0003h
--------E-15BFDEBX0003-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0003h
Return: BX = 0000h (success)
	CX:DX -> ???
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=0002h
--------E-15BFDEBX0004-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 0004h
	CL = ???
Return: BX = 0000h (success)
	CX:DX -> XBRK structure (see AX=BF02h)
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0005-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 0005h
	CX = new value for ???
Return: BX = 0000h (success)
	AX = old value of ???
	DS:SI -> ??? (if AX nonzero on return)
	ES:DI -> ??? (if AX zero on return)
Note:	called by DOS4GW.EXE
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0006-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0006h
Return: BX = 0000h (success)
	AH = interrupt number??? (BEh)
	CX:DX = ???
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=0007h,INT BE"DESQview"
--------E-15BFDEBX0007-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - SET ???
	AX = BFDEh
	BX = 0007h
	CX:DX = ???
Return: BX = 0000h (success)
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=0006h
--------E-15BFDEBX0008-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 0008h
	CX = segment of ???
	DS = ???
Return: BX = status
	    0000h successful
		AL = ??? (80h or C0h)
		DX = ??? (0603h) if AL=C0h
	    0001h failed
		AX = 0000h
Note:	called by DOS4GW.EXE
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0009-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET PROTECTED MODE PROGRAM LOADER
	AX = BFDEh
	BX = 0009h
Return: BX = 0000h (success)
	CX:DX -> full pathname to LOAD32.EXP
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX000A-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - DECREMENT ???
	AX = BFDEh
	BX = 000Ah
Return: BX = 0000h (success)
	AX = new value of ??? counter
Notes:	also resets a variety of values if the counter goes negative
	called by DOS4GW.EXE
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=000Bh
--------E-15BFDEBX000B-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - INCREMENT ???
	AX = BFDEh
	BX = 000Bh
Return: AX = new value of ??? counter
Note:	called by DOS4GW.EXE
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=000Ah
--------E-15BFDEBX000C-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 000Ch
	CL = ???
	    00h
	    nonzero
Return: ???
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX000D-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 000Dh
	???
Return: ???
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX000E-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 000Eh
	DX:CX -> ???
Return: AX = segment of handle for calling task
	BX = ??? (probably destroyed)
	DX:CX -> ???
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=000Fh,AX=BFDEh/BX=0013h
--------E-15BFDEBX000F-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 000Fh
Return: AX = segment of handle for calling task
	BX = ??? (probably destroyed)
	DX:CX -> ???
Note:	identical to AX=BFDEh/BX=000Eh with CX:DX = 0000h:0000h
SeeAlso: AX=BFDEh/BX=000Eh,AX=BFDEh/BX=0010h
--------E-15BFDEBX0010-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET TASK HANDLE
	AX = BFDEh
	BX = 0010h
Return: AX = segment of caller's task handle
	BX destroyed
SeeAlso: AX=BFDEh/BX=000Fh
--------E-15BFDEBX0011-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0011h
Return: CX = code segment of DVDOS4GX.DVR
	BX = ??? (0004h)
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0012-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0012h
Return: DX = code segment of DVDOS4GX.DVR
	BX = ??? (012Ch)
	CX = ??? (0006h)
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0013-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0013h
Return: DX:CX -> ???
SeeAlso: AX=BFDEh/BX=000Eh
--------E-15BFDEBX0014-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - LOCK ??? MAILBOX
	AX = BFDEh
	BX = 0014h
	CX = index of ??? mailbox
		(0000h-0004h valid, but no range checking done)
Return: AX,BX destroyed
SeeAlso: AX=BFDEh/BX=0015h,AX=BFDEh/BX=0017h
--------E-15BFDEBX0015-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - UNLOCK ??? MAILBOX
	AX = BFDEh
	BX = 0015h
	CX = index of ??? mailbox
		(0000h-0004h valid, but no range checking done)
Return: AX,BX destroyed
SeeAlso: AX=BFDEh/BX=0014h,AX=BFDEh/BX=0016h
--------E-15BFDEBX0016-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - CHECK IF ??? MAILBOX OWNED
	AX = BFDEh
	BX = 0016h
	CX = index of ??? mailbox
		(0000h-0004h valid, but no range checking done)
Return: AX = status
	    0000h no one owns mailbox
	    0001h mailbox has an owner
	BX destroyed
SeeAlso: AX=BFDEh/BX=0015h,AX=BFDEh/BX=0017h
--------E-15BFDEBX0017-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ??? MAILBOX OWNER
	AX = BFDEh
	BX = 0017h
	CX = index of ??? mailbox
		(0000h-0004h valid, but no range checking done)
Return: AX = segment of mailbox owner's handle
	BX = segment of caller's task handle
SeeAlso: AX=BFDEh/BX=0015h,AX=BFDEh/BX=0016h
--------E-15BFDEBXFFFD-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = FFFDh
Return: CX:DX = ???
SeeAlso: AX=BFDEh/BX=FFFEh
--------E-15BFDEBXFFFE-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - SET ???
	AX = BFDEh
	BX = FFFEh
	CX:DX = ???
SeeAlso: AX=BFDEh/BX=FFFDh
--------E-15BFDEBXFFFF-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - NOP
	AX = BFDEh
	BX = FFFFh
SeeAlso: AX=BFDEh/BX=0000h
--------B-15C0-------------------------------
INT 15 - SYSTEM - GET CONFIGURATION (XT after 1/10/86,AT mdl 3x9,CONV,XT286,PS)
	AH = C0h
Return: CF set if BIOS doesn't support call
	CF clear on success
	    ES:BX -> ROM table (see below)
	AH = status
	    00h successful
	    86h unsupported function
Notes:	the 1/10/86 XT BIOS returns an incorrect value for the feature byte
	the configuration table is at F000h:E6F5h in 100% compatible BIOSes
	Dell machines contain the signature "DELL" or "Dell" at absolute FE076h
	  and a model byte at absolute address FE845h
	Hewlett-Packard machines contain the signature "HP" at F000h:00F8h and
	  a product identifier at F000h:00FAh (see below)
	Compaq machines can be identified by the signature string "COMPAQ" at
	  F000h:FFEAh, and is preceded by additional information (see below)
	Tandy 1000 machines contain 21h in the byte at F000h:C000h and FFh in
	  the byte at FFFFh:000Eh; Tandy 1000SL/TL machines only provide the
	  first three data bytes (model/submodel/revision) in the returned
	  table
	some AST machines contain the string "COPYRIGHT AST RESEARCH" one byte
	  past the end of the configuration table
	the Phoenix 386 BIOS contains a second version and date string
	  (presumably the last modification for that OEM version) beginning at
	  F000h:FFD8h, with each byte doubled (so that both ROM chips contain
	  the complete information)
SeeAlso: AH=C7h,AH=C9h,AH=D1h

Format of ROM configuration table:
Offset	Size	Description
 00h	WORD	number of bytes following
 02h	BYTE	model (see below)
 03h	BYTE	submodel (see below)
 04h	BYTE	BIOS revision: 0 for first release, 1 for 2nd, etc.
 05h	BYTE	feature byte 1 (see below)
 06h	BYTE	feature byte 2 (see below)
 07h	BYTE	feature byte 3 (see below)
 08h	BYTE	feature byte 4:
		bit 7: ??? (set on N51SX, CL57SX)
		bits 6-4: reserved
		bit 3: ??? (set on some 1992 PS/1's, 35SX, 40SX)
		bits 2-1: reserved
		bit 0: ??? (set on N51SX, CL57SX, 57SX)
 09h	BYTE	feature byte 5:
		reserved (0) (IBM)
		??? (08h) (Phoenix 386 v1.10)
---AWARD BIOS---
 0Ah  N BYTEs	AWARD copyright notice
---Phoenix BIOS---
 0Ah	BYTE	??? (00h)
 0Bh	BYTE	major version
 0Ch	BYTE	minor version (BCD)
 0Dh  4 BYTEs	ASCIZ string "PTL" (Phoenix Technologies Ltd)
---Quadram Quad386---
 0Ah 17 BYTEs	ASCII signature string "Quadram Quad386XT"

Bitfields for feature byte 1:
 bit 7	DMA channel 3 used by hard disk BIOS
 bit 6	2nd 8259 installed
 bit 5	Real-Time Clock installed
 bit 4	INT 15/AH=4Fh called upon INT 09h
 bit 3	wait for external event (INT 15/AH=41h) supported
 bit 2	extended BIOS area allocated (usually at top of RAM)
 bit 1	bus is Micro Channel instead of ISA
 bit 0	system has dual bus (Micro Channel + ISA)

Bitfields for feature byte 2:
 bit 7	reserved
 bit 6	INT 16/AH=09h (keyboard functionality) supported
 bit 5	INT 15/AH=C6h (get POS data) supported
 bit 4	INT 15/AH=C7h (return memory map info) supported
 bit 3	INT 15/AH=C8h (en/disable CPU functions) supported
 bit 2	non-8042 keyboard controller
 bit 1	data streaming supported
 bit 0	reserved

Bitfields for feature byte 3:
 bits 7-5 reserved
 bit 4	??? (set on 1992 PS/1's, N51SX, CL57SX, 35SX?, 40SX?)
 bit 3	SCSI subsystem supported on system board
 bit 2	information panel installed
 bit 1	IML (Initial Machine Load) system
 bit 0	SCSI supported in IML

Values for model/submodel/revision:
Model  Submdl  Rev	BIOS date	System
 FFh	*	*	04/24/81	PC (original)
 FFh	*	*	10/19/81	PC (some bugfixes)
 FFh	*	*	10/27/82	PC (HD, 640K, EGA support)
 FFh	00h	rev	  ???		Tandy 1000SL
 FFh	01h	rev	  ???		Tandy 1000TL
 FFh	46h	***	  ???		Olivetti M15
 FEh	*	*	08/16/82	PC XT
 FEh	*	*	11/08/82	PC XT and Portable
 FEh	43h	***	  ???		Olivetti M240
 FEh	A6h	???	  ???		Quadram Quad386
 FDh	*	*	06/01/83	PCjr
 FCh	*	*	01/10/84	AT models 068,099 6 MHz 20MB
 FCh	00h	00h	  ???		PC3270/AT
 FCh	00h	01h	06/10/85	AT model  239	  6 MHz 30MB
 FCh	00h	> 01h	  ???		7531/2 Industrial AT
 FCh	01h	00h	11/15/85	AT models 319,339 8 MHz, Enh Keyb, 3.5"
 FCh	01h	00h	09/17/87	Tandy 3000
 FCh	01h	00h	01/15&88	Toshiba T5200/100
 FCh	01h	00h	12/26*89	Toshiba T1200/XE
 FCh	01h	00h	04/05A92	Toshiba T4500SX-C
 FCh	01h	00h	07/17o92	Toshiba T1800SX
 FCh	01h	00h	12/25n92	Toshiba T1850SX
 FCh	01h	00h	01/13E93	Toshiba T4400C
			(Those date characters are not typos)
 FCh	01h	00h	03/08/93	Compaq DESKPRO/i
 FCh	01h	00h	 various	Compaq DESKPRO, SystemPro, ProSignia
 FCh	01h	20h	06/10/92	AST
 FCh	01h	30h	  ???		Tandy 3000NL
 FCh	01h	???	  ???		Compaq 286/386
 FCh	02h	00h	04/21/86	PC XT-286
 FCh	02h	00h	 various	Compaq LTE Lite
 FCh	02h	00h	08/05/93	Compaq Contura 486/486c/486cx
 FCh	04h	00h	02/13/87     ** PS/2 Model 50 (10 MHz/1 ws 286)
 FCh	04h	02h	  ???		PS/2 Model 50
 FCh	04h	03h	04/18/88	PS/2 Model 50Z (10 MHz/0 ws 286)
 FCh	04h	04h	  ???		PS/2 Model 50Z
 FCh	05h	00h	02/13/87     ** PS/2 Model 60 (10 MHz 286)
 FCh	06h	00h	  ???		IBM 7552-140 "Gearbox"
 FCh	06h	01h	  ???		IBM 7552-540 "Gearbox"
 FCh	08h	***	  ???		Epson, unknown model
 FCh	08h	00h	  ???		PS/2 Model 25/286
 FCh	09h	00h	  ???		PS/2 Model 25 (10 MHz 286)
 FCh	09h	02h	06/28/89	PS/2 Model 30-286
 FCh	0Bh	00h	02/16/90	PS/1 Model 2011 (10 MHz 286)
 FCh	20h	00h	02/18/93	Compaq ProLinea
 FCh	30h	***	  ???		Epson, unknown model
 FCh	31h	***	  ???		Epson, unknown model
 FCh	33h	***	  ???		Epson, unknown model
 FCh	42h	***	  ???		Olivetti M280
 FCh	45h	***	  ???		Olivetti M380 (XP 1, XP3, XP 5)
 FCh	48h	***	  ???		Olivetti M290
 FCh	4Fh	***	  ???		Olivetti M250
 FCh	50h	***	  ???		Olivetti M380 (XP 7)
 FCh	51h	***	  ???		Olivetti PCS286
 FCh	52h	***	  ???		Olivetti M300
 FCh	81h	00h	01/15/88	Phoenix 386 BIOS v1.10 10a
 FCh	81h	01h	  ???		"OEM machine"
 FCh	82h	01h	  ???		"OEM machine"
 FCh	94h	00h	  ???		Zenith 386
 FBh	00h	01h	01/10/86	PC XT-089, Enh Keyb, 3.5" support
 FBh	00h	02h	05/09/86	PC XT
 FBh	4Ch	***	  ???		Olivetti M200
 FAh	00h	00h	09/02/86	PS/2 Model 30 (8 MHz 8086)
 FAh	00h	01h	12/12/86	PS/2 Model 30
 FAh	01h	00h	  ???		PS/2 Model 25/25L (8 MHz 8086)
 FAh	30h	00h	  ???		IBM Restaurant Terminal
 FAh	4Eh	***	  ???		Olivetti M111
 FAh	FEh	00h	  ???		IBM PCradio 9075
 F9h	00h	00h	09/13/85	PC Convertible
 F9h	FFh	00h	  ???		PC Convertible
 F8h	00h	00h	03/30/87     ** PS/2 Model 80 (16MHz 386)
 F8h	01h	00h	10/07/87	PS/2 Model 80 (20MHz 386)
 F8h	02h	00h	  ???		PS/2 Model 55-5571
 F8h	04h	00h	  ???		PS/2 Model 70
 F8h	04h	02h	04/11/88	PS/2 Model 70 20MHz, type 2 system brd
 F8h	04h	03h	03/17/89	PS/2 Model 70 20MHz, type 2 system brd
 F8h	05h	00h	  ???		IBM PC 7568
 F8h	06h	00h	  ???		PS/2 Model 55-5571
 F8h	07h	00h	  ???		IBM PC 7561/2
 F8h	07h	01h	  ???		PS/2 Model 55-5551
 F8h	07h	02h	  ???		IBM PC 7561/2
 F8h	07h	03h	  ???		PS/2 Model 55-5551
 F8h	09h	00h	  ???		PS/2 Model 70 16MHz, type 1 system brd
 F8h	09h	02h	04/11/88	PS/2 Model 70 some models
 F8h	09h	03h	03/17/89	PS/2 Model 70 some models
 F8h	0Bh	00h	01/18/89	PS/2 Model P70 (8573-121) typ 2 sys brd
 F8h	0Bh	02h	12/16/89	PS/2 Model P70 ??
 F8h	0Ch	00h	11/02/88	PS/2 Model 55SX (16 MHz 386SX)
 F8h	0Dh	00h	  ???		PS/2 Model 70 25MHz, type 3 system brd
 F8h	0Eh	00h	  ???		PS/1 486SX
 F8h	0Fh	00h	  ???		PS/1 486DX
 F8h	10h	00h	  ???		PS/2 Model 55-5551
 F8h	11h	00h	10/01/90	PS/2 Model 90 XP (25 MHz 486)
 F8h	12h	00h	  ???		PS/2 Model 95 XP
 F8h	13h	00h	10/01/90	PS/2 Model 90 XP (33 MHz 486)
 F8h	14h	00h	10/01/90	PS/2 Model 90-AK9 (25 MHz 486), 95 XP
 F8h	15h	00h	  ???		PS/2 Model 90 XP
 F8h	16h	00h	10/01/90	PS/2 Model 90-AKD (33 MHz 486)
 F8h	17h	00h	  ???		PS/2 Model 90 XP
 F8h	19h	05h	  ???		PS/2 Model 35/35LS or 40 (20 MHz 386SX)
 F8h	1Ah	00h	  ???		PS/2 Model 95 XP
 F8h	1Bh	00h	10/02/89	PS/2 Model 70-486 (25 MHz 486)
 F8h	1Ch	00h	02/08/90	PS/2 Model 65-121 (16 MHz 386SX)
 F8h	1Eh	00h	02/08/90	PS/2 Model 55LS (16 MHz 386SX)
 F8h	23h	00h	  ???		PS/2 Model L40 SX
 F8h	23h	01h	  ???		PS/2 Model L40 SX (20 MHz 386SX)
 F8h	25h	00h	  ???		PS/2 Model 57 SLC
 F8h	25h	06h	  ???		PS/2 Model M57 (20 MHz 386SLC)
 F8h	26h	00h	  ???		PS/2 Model 57 SX
 F8h	26h	01h	  ???		PS/2 Model 57 (20 MHz 386SX)
 F8h	28h	00h	  ???		PS/2 Model 95 XP
 F8h	29h	00h	  ???		PS/2 Model 90 XP
 F8h	2Ah	00h	  ???		PS/2 Model 95 XP (50 MHz 486)
 F8h	2Bh	00h	  ???		PS/2 Model 90 (50 MHz 486)
 F8h	2Ch	00h	  ???		PS/2 Model 95 XP
 F8h	2Ch	01h	  ???		PS/2 Model 95 (20 MHz 486SX)
 F8h	2Dh	00h	  ???		PS/2 Model 90 XP (20 MHz 486SX)
 F8h	2Eh	00h	  ???		PS/2 Model 95 XP
 F8h	2Eh	01h	  ???		PS/2 Model 95 (20 MHz 486SX + 487SX)
 F8h	2Fh	00h	  ???		PS/2 Model 90 XP (20 MHz 486SX + 487SX)
 F8h	30h	00h	  ???		PS/1 Model 2121 (16 MHz 386SX)
 F8h	33h	00h	  ???		PS/2 Model 30-386
 F8h	34h	00h	  ???		PS/2 Model 25-386
 F8h	36h	00h	  ???		PS/2 Model 95 XP
 F8h	37h	00h	  ???		PS/2 Model 90 XP
 F8h	38h	00h	  ???		PS/2 Model 57
 F8h	39h	00h	  ???		PS/2 Model 95 XP
 F8h	3Fh	00h	  ???		PS/2 Model 90 XP
 F8h	40h	00h	  ???		PS/2 Model 95 XP
 F8h	41h	00h	  ???		PS/2 Model 77
 F8h	45h	00h	  ???		PS/2 Model 90 XP (Pentium)
 F8h	46h	00h	  ???		PS/2 Model 95 XP (Pentium)
 F8h	47h	00h	  ???		PS/2 Model 90/95 E (Pentium)
 F8h	48h	00h	  ???		PS/2 Model 85
 F8h	49h	00h	  ???		PS/ValuePoint 325T
 F8h	4Ah	00h	  ???		PS/ValuePoint 425SX
 F8h	4Bh	00h	  ???		PS/ValuePoint 433DX
 F8h	4Eh	00h	  ???		PS/2 Model 295
 F8h	50h	00h	  ???		PS/2 Model P70 (8573) (16 MHz 386)
 F8h	50h	01h	12/16/89	PS/2 Model P70 (8570-031)
 F8h	52h	00h	  ???		PS/2 Model P75 (33 MHz 486)
 F8h	56h	00h	  ???		PS/2 Model CL57 SX
 F8h	57h	00h	  ???		PS/2 Model 90 XP
 F8h	58h	00h	  ???		PS/2 Model 95 XP
 F8h	59h	00h	  ???		PS/2 Model 90 XP
 F8h	5Ah	00h	  ???		PS/2 Model 95 XP
 F8h	5Bh	00h	  ???		PS/2 Model 90 XP
 F8h	5Ch	00h	  ???		PS/2 Model 95 XP
 F8h	5Dh	00h	  ???		PS/2 Model N51 SLC
 F8h	5Eh	00h	  ???		IBM ThinkPad 700
 F8h	61h	***	  ???		Olivetti P500
 F8h	62h	***	  ???		Olivetti P800
 F8h	80h	00h	  ???		PS/2 Model 80 (25 MHz 386)
 F8h	80h	01h	11/21/89	PS/2 Model 80-A21
 F8h	81h	00h	  ???		PS/2 Model 55-5502
 F8h	87h	00h	  ???		PS/2 Model N33SX
 F8h	88h	00h	  ???		PS/2 Model 55-5530T
 F8h	97h	00h	  ???		PS/2 Model 55 Note N23SX
 F8h	99h	00h	  ???		PS/2 Model N51 SX
 F8h	F2h	30h	  ???		Reply Model 32
 F8h	F6h	30h	  ???		Memorex Telex
 F8h	FDh	00h	  ???		IBM Processor Complex (with VPD)
 F8h	???	???	  ???		PS/2 Model 90 (25 MHz 486SX)
 F8h	???	???	  ???		PS/2 Model 95 (25 MHz 486SX)
 F8h	???	???	  ???		PS/2 Model 90 (25 MHz 486SX + 487SX)
 F8h	???	???	  ???		PS/2 Model 95 (25 MHz 486SX + 487SX)
 E1h	???	???	  ???		??? (checked for by DOS4GW.EXE)
 E1h	00h	00h	  ???		PS/2 Model 55-5530 Laptop
 9Ah	*	*	  ???		Compaq XT/Compaq Plus
 30h	???	???	  ???		Sperry PC
 2Dh	*	*	  ???		Compaq PC/Compaq Deskpro
 ???	56h	???	  ???		Olivetti, unknown model
 ???	74h	???	  ???		Olivetti, unknown model
    * This BIOS call is not implemented in these early versions.
      Read Model byte at F000h:FFFEh and BIOS date at F000h:FFF5h.
   ** These BIOS versions require the DASDDRVR.SYS patches.
  *** These Olivetti and Epson machines store the submodel in the byte at
	F000h:FFFDh.

Values for Dell model byte:
 02h	Dell 200
 03h	Dell 300
 05h	Dell 220
 06h	Dell 310
 07h	Dell 325
 09h	Dell 310A
 0Ah	Dell 316
 0Bh	Dell 220E
 0Ch	Dell 210
 0Dh	Dell 316SX
 0Eh	Dell 316LT
 0Fh	Dell 320LX
 11h	Dell 425E

Format of Compaq product information:
Address		Size	Description
F000h:FFE4h	BYTE	product family code (first byte)
F000h:FFE4h	BYTE	Point release number
F000h:FFE4h	BYTE	ROM version code
F000h:FFE4h	BYTE	product family code (second byte)
F000h:FFE8h	WORD	BIOS type code

Bitfields for Hewlett-Packard product identifier:
 bits 4-0	machine code
		0 original Vectra
		1 ES/12
		2 RS/20
		3 Portable/CS
		4 ES
		5 CS
		6 RS/16
		other reserved
 bits 7-5	CPU type
		0 = 80286
		1 = 8088
		2 = 8086
		3 = 80386
		other reserved
--------B-15C1-------------------------------
INT 15 - SYSTEM - RETURN EXTENDED-BIOS DATA-AREA SEGMENT ADDRESS (PS)
	AH = C1h
Return: CF set on error
	CF clear if successful
	    ES = segment of data area
SeeAlso: AH=04h"ABIOS"
--------M-15C200-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - ENABLE/DISABLE
	AX = C200h
	BH = new state
	    00h disabled
	    01h enabled
Return: CF set on error
	AH = status
	    00h successful
	    01h invalid function
	    02h invalid input
	    03h interface error
	    04h need to resend
	    05h no device handler installed
--------M-15C201-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - RESET
	AX = C201h
Return: CF set on error
	    AH = status (see AX=C200h)
	CF clear if successful
	    BH = device ID
	    BL = value returned by attached device after reset
		AAh if device is a mouse
Note:	after successful completion of this call, the pointing device is set
	  as follows: disabled, sample rate 100 Hz, resolution 4 counts/mm,
	  scaling 1:1, unchanged data package size
SeeAlso: INT 33/AX=0000h
--------M-15C202-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - SET SAMPLING RATE
	AX = C202h
	BH = sampling rate
	    00h 10/second
	    01h 20/second
	    02h 40/second
	    03h 60/second
	    04h 80/second
	    05h 100/second
	    06h 200/second
Return: CF set on error
	    AH = status (see AX=C200h)
SeeAlso: INT 33/AX=001Ch
--------M-15C203-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - SET RESOLUTION
	AX = C203h
	BH = resolution
	    00h one count per mm
	    01h two counts per mm
	    02h four counts per mm
	    03h eight counts per mm
Return: CF set on error
	    AH = status (see AX=C200h)
--------M-15C204-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - GET TYPE
	AX = C204h
Return: CF set on error
	    AH = status (see AX=C200h)
	CF clear if successful
	    BH = device ID
--------M-15C205-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - INITIALIZE
	AX = C205h
	BH = data package size (1 - 8 bytes)
Return: CF set on error
	    AH = status (see AX=C200h)
Note:	the pointing device is set as follows: disabled, 100 Hz sample rate,
	  resolution 4 counts/mm, scaling 1:1
SeeAlso: AX=C201h
--------M-15C206-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - EXTENDED COMMANDS
	AX = C206h
	BH = subfunction
	    00h return device status
		Return: BL = pointing device status (see below)
			CL = resolution (see AX=C203h)
			DL = sample rate, reports per second
	    01h set scaling at 1:1
	    02h set scaling at 2:1
Return: CF set on error
	    AH = status (see AX=C200h)

Bitfields for pointing device status:
 bit 0	right button pressed
 bit 1	reserved
 bit 2	left button pressed
 bit 3	reserved
 bit 4	0 if 1:1 scaling, 1 if 2:1 scaling
 bit 5	device enabled
 bit 6	0 if stream mode, 1 if remote mode
 bit 7	reserved
--------M-15C207-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - SET DEVICE HANDLER ADDR
	AX = C207h
	ES:BX -> FAR user device handler
Return: CF set on error
	    AH = status (see AX=C200h)
Note:	when the subroutine is called, it is passed the following values on
	  the stack; the handler should return with a FAR return without
	  popping the stack:
		WORD 1: status (see below)
		WORD 2: X data (high byte = 00h)
		WORD 3: Y data (high byte = 00h)
		WORD 4: 0000h
SeeAlso: INT 33/AX=000Ch

Bitfields for status:
 bits 15-8 reserved (0)
 bit 7	Y data overflowed
 bit 6	X data overflowed
 bit 5	Y data is negative
 bit 4	X data is negative
 bit 3	reserved (1)
 bit 2	reserved (0)
 bit 1	right button pressed
 bit 0	left button pressed
--------B-15C3------------------------------
INT 15 - SYSTEM - ENABLE/DISABLE WATCHDOG TIMEOUT (PS50+)
	AH = C3h
	AL = function
	    00h disable PS/2 watchdog timer
	    01h enable PS/2 watchdog timer
		BX = timer counter (0001h-00FFh)
	    02h disable Gearbox system
	    03h enable Gearbox system
Return: CF set on error
	CF clear if successful
Note:	the watchdog timer generates an NMI
--------B-15C4-------------------------------
INT 15 - SYSTEM - PROGRAMMABLE OPTION SELECT (PS50+)
	AH = C4h
	AL = subfunction
	    00h return base POS register address
	    01h enable selected slot for setup
		BL = slot number (1 to 8)
	    02h disable setup for all slots
Return: CF set on error
	DX = base POS register address (if subfunction 00h)
SeeAlso: AH=C6h
--------B-15C5-------------------------------
INT 15 UC - OS HOOK - ROM BIOS TRACING CALLOUT (PS30/286,PS50Z,PS95)
	AH = C5h
	AL = interrupt being invoked
	    01h INT 19
	    02h INT 14
	    03h INT 16
	    04h INT 40 (floppy INT 13)
	    05h INT 17
	    06h INT 10
	    07h INT 12
	    08h INT 11
	    09h INT 1A
Return: all registers except AX must be preserved
Notes:	called as the very first action of the indicated ROM BIOS interrupt
	  handlers on the PS/2 Models 30/286, 50Z, and 95
	default handler does nothing and returns CF clear for the above
	  subfunctions, CF set and AH=86h for all other subfunctions
	value of AX passed to the original interrupt handler is pushed on
	  stack immediately prior to call
--------B-15C6-------------------------------
INT 15 U - later PS/2 models - GET POS DATA
	AH = C6h
	???
Return: ???
Notes:	this function is referenced by name and number in some IBM BIOS manuals
	IBM reports that "there are a number of problems with this call" and
	  does not recommend its use.
SeeAlso: AH=C4h
--------B-15C7-------------------------------
INT 15 - SYSTEM - later PS/2s - RETURN MEMORY-MAP INFORMATION
	AH = C7h
	DS:SI -> user supplied memory map table (see below)
Note:	call AH=C0h and examine bit 4 of feature byte 2 to check if this
	  function is supported
Return: CF set on error, clear if successful
SeeAlso: AH=C0h,AH=C9h,AH=D1h

Format of memory-map table structure:
Offset	Size	Description
 00h	WORD	length of table (excluding this word)
 02h	DWORD	local memory between 1M and 16M, in 1K blocks
 06h	DWORD	local memory between 16M and 4G, in 1K blocks
 0Ah	DWORD	system memory between 1M and 16M, in 1K blocks
 0Eh	DWORD	system memory between 16M and 4G, in 1K blocks
 12h	DWORD	cacheable memory between 1M and 16M, in 1K blocks
 16h	DWORD	cacheable memory between 16M and 4G, in 1K blocks
 1Ah	DWORD	1K blocks before start of non-system memory between 1M and 16M
 1Eh	DWORD	1K blocks before start of non-system memory between 16M and 4G
 22h  2 DWORDs	reserved
--------B-15C8-------------------------------
INT 15 - SYSTEM - ENABLE/DISABLE PROCESSOR FUNCTIONS
	AH = C8h
	AL = function
	    00h disable cache or (90 and 95) disable cache L1
	    01h enable cache or (90 and 95) enable cache L1
	    ---models 90 and 95 only---
	    02h disable cache L2
	    03h enable cache L2
	    04h disable both caches
	    05h enable both caches
	    06h return status of both caches
	    07h-FFh Reserved
Return: CF set on error
	CF clear if successful
	    AH = status (see below)
	For subfunction 06h only:
	    BH = status of cache L2
		00h enabled
		01h disabled or not installed
	    BL = status of cache L1 (same codes as BH)
Notes:	 supported by at least PS/2 70, 70/486, 80-A21, 90, 95
	call AH=C0h and examine bit 3 of feature byte 2 to check if this
	  function is supported.
	on a 486 system, any external caches must be disabled when the
	  on-chip cache (L1) is disabled.
SeeAlso: AH=C0h

Values for status:
 00h	operation successful
 01h	function choice (in AL) is invalid
 02h	NVRAM data is invalid
 03h	cache test error
 04h	(90 and 95 only) cannot perform operation requested due to state of
	  other cache (see note above)
 05h	no L2 cache is present
--------B-15C9-------------------------------
INT 15 - newer PS/2; various BIOSes - GET CPU TYPE AND MASK REVISION
	AH = C9h
	AL = 10h (may be required on some non-PS BIOSes)
Return: CF clear if successful
	    AH = 00h
	    CH = CPU type
		03h 80386DX or clone
		04h 80486
		23h 80386SX or clone
	    CL = mask revision (stepping level)
		80386:
		    03h B1
		    05h D0
		    08h D1/D2/E1
		80386SX:
		    04h A0
		    05h	B
		    08h C/D1
	CF set on error
	    AH = status (80h,86h = function not supported)
Notes:	the BIOS must save DX at startup in order to be able to support this
	  call; PS/2 Models 56, 57, 90, and 95 are known to support it
	the PS/2 BIOS merely reads CMOS locations 190h (type) and 191h (rev)
--------B-15CA-------------------------------
INT 15 U - PS/2 Model 95 - RESERVED
	AH = CAh
	???
Return: ???
--------B-15CB-------------------------------
INT 15 U - PS/2 Model 95 - RESERVED
	AH = CBh
	???
Return: ???
--------B-15CC-------------------------------
INT 15 U - PS/2 Model 95 - RESERVED
	AH = CCh
	???
Return: ???
--------B-15CD-------------------------------
INT 15 U - PS/2 Model 95 - RESERVED
	AH = CDh
	???
Return: ???
--------B-15CE--BL00-------------------------
INT 15 - later PS/2s - ALLOCATE DMA ARBITRATION LEVEL
	AH = CEh
	BL = 00h-0Eh arbitration level to be allocated
	     0Fh-FFh reserved
	AL = option byte
	    bit 7-1: reserved (0)
	    bit 0: 0 = need DMA channel for arbitration level requested
		   1 = no channel required for arbitration level
Return: CF set on error
	    AH = status (80h,86h = function not supported)
	CF clear on success
	    AL = channel number
		00h-07h channel number allocated for the arbiration level
		08h-FEh reserved
		FFh	no channel requested for arbitration level
	    AH = status
		00h success
		01h arbitration level not available
		02h channel not available
		03h invalid arbitration level passed
Notes:	 arbitration level 00h has the highest priority, 0Eh the lowest
	 to perform a DMA transfer operation, be sure to call this function
	   first, and call AH=CFh afterward.  Failure to use this function
	   can cause unpredictable results.
SeeAlso: AH=CFh
--------B-15CF-------------------------------
INT 15 - later PS/2s - DEALLOCATE DMA ARBITRATION LEVEL
	AH = CFh
	BL = arbitration level to be deallocated (see AH=CEh)
Return: CF set on error
	    AH = status (80h,86h = function not supported)
	CF clear on success
	    AH = status
		00h success
		04h arbitration level not allocated
SeeAlso: AH=CEh
--------B-15D0-------------------------------
INT 15 - later PS/2s - RESERVED
	AH = D0h
	???
Return: ???
--------B-15D100DX0000-----------------------
INT 15 - later PS/2s - GET NUMBER OF DEVICE DESCRIPTOR TABLE (DDT) ENTRIES
	AX = D100h
	DX = 0000h (reserved, must set to 0)
Return: BL = size of one DDT entry, in bytes
	CX = number of DDT entries
	AH = return code (see below)
	CF set on error
	CF clear on success
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D101h,AX=D102h,AX=D103h,AX=D104h

Values for return code:
 00h	success
 01h	requested DDT entry not found
 02h	DDT data not valid
 86h	function not supported
--------B-15D101-----------------------------
INT 15 - later PS/2s - RETURN DEVICE DESCRIPTOR TABLE (DDT) ENTRY BY NUMBER
	AX = D101h
	BX = number of requested entry (starting with 1)
	DX = 0000h (reserved, must be set to 0)
	ES:DI -> buffer to contain DDT entry (see below)
Return:	AH = return code (see AX=D100h)
	CF set on error
	CF clear on success
	    ES:DI buffer filled with DDT entry
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D100h,AX=D102h,AX=D104h

Format of DDT:
Offset	Size	Description
 00h	BYTE	bits 7-4: reserved (set to 0)
		bits 3-0: slot of device (0 = system board)
 01h	BYTE	bits 7-4: second interrupt for this device (0 = none)
		bits 3-0: first interrupt for this device (0 = none)
 02h	BYTE	bits 7-4: second arbitration level for this device
		bits 3-0: first arbitration level for this device
 03h	WORD	DDT indicators (see below)
 05h	BYTE	reserved (0)
 06h	WORD	device ID (0 = none)
 08h	WORD	starting address of first  I/O block (0 = none)
 0Ah	WORD	starting address of second I/O block (0 = none)
 OCh	WORD	starting address of third  I/O block (0 = none)
 OEh	DWORD	start of first non-system memory block (0 = none)
 12h	WORD	size of first non-system memory block (in kilobytes)
 14h	DWORD	start of second non-system memory block (0 = none)
 18h	WORD	size of second non-system memory block (in kilobytes)
 1Ah	BYTE	implementation identifier of the device
 1Bh	BYTE	implementation revision level of the device
Note:	I/O block addresses and non-system memory addresses are listed in
	  ascending order in each DDT entry.

Bitfields for DDT indicators:
 bit 15 reserved (0)
 bit 14 second arbitration level exists
 bit 13 first arbitration level exists
 bit 12 serial interface is RS-422
 bit 11 not address limited
 bit 10 DMA channel used
 bit 9	second arbitration level can be shared
 bit 8	first arbitration level can be shared
 bits 7-0 reserved (0)
--------B-15D102-----------------------------
INT 15 - later PS/2s - RETURN DEVICE DESCRIPTOR TABLE (DDT) ENTRY BY I/O ADDRSS
	AX = D102h
	BX = entry number at which to start searching
	CX = requested I/O port address
	DX = 0000h (reserved, must be set to 0)
	ES:DI -> buffer to contain DDT entry (see AX=D101h)
Return:	AH = return code (see AX=D100h)
	BX = DDT entry number where I/O port was found, or total entries
	     plus 1 if port was not found.
	CF set on error
	CF clear on success
	    ES:DI buffer filled with DDT entry
Desc:	the DDT is searched from the specified entry for the I/O port in CX,
	  and the first entry in which it is found is returned
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D100h,AX=D101h,AX=D103h,AX=D104h
--------B-15D103DX0000-----------------------
INT 15 - later PS/2s - RETURN ENTIRE DDT
	AX = D103h
	DX = 0000h (reserved, must be set to 0)
	ES:DI -> buffer to contain DDT entry (see AX=D101h)
Return:	AH = return code (see AX=D100h)
	CF set on error
	CF clear on success
	    ES:DI buffer filled with DDT entry
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D100h,AX=D104h
--------B-15D104-----------------------------
INT 15 - later PS/2s - RETURN DEVICE DESCRIPTOR TABLE (DDT) ENTRY BY DEVICE ID
	AX = D104h
	BX = entry number at which to start searching
	CX = requested device ID
	DX = 0000h (reserved, must be set to 0)
	ES:DI -> buffer to contain DDT entry (see AX=D101h for format)
Return:	AH = return code (see AX=D100h)
	BX = DDT entry number where device ID was found, or total entries
	     plus 1 if port was not found.
	CF set on error
	CF clear on success
	    ES:DI buffer filled with DDT entry
Desc:	the DDT is searched from the specified entry for the device ID in CX,
	  and the first entry in which it is found is returned.
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D100h,AX=D101h,AX=D103h
--------B-15D2-------------------------------
INT 15 - later PS/2s - RESERVED
	AH = D2h
	???
Return: ???
--------B-15D3-------------------------------
INT 15 - later PS/2s - RESERVED
	AH = D3h
	???
Return: ???
--------B-15D4-------------------------------
INT 15 - later PS/2s - GET PHYSICAL FIXED DISK DRIVE NUMBER (SELECTABLE BOOT)
	AH = D4h
	DL = logical fixed disk drive number
Return:	AH = return code
	    00h success
	    01h specified logical drive number is invalid
	    86h function not supported
	    80h function not supported (on PCjr and PC)
	CF set on error
	CF clear on success
	    AL = physical fixed disk drive number
--------B-15D5-------------------------------
INT 15 - later PS/2s - RESERVED
	AH = D5h
	???
Return: ???
--------B-15D600BL00-------------------------
INT 15 - later PS/2s - READ BOOT DEVICE ID
	AX = D600h
	BL = 00h
	DX = device ID
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D600h/BL=01h,AX=D601h/BL=00h,AX=D602h
--------B-15D600BL01-------------------------
INT 15 - later PS/2s - WRITE BOOT DEVICE ID
	AX = D600h
	BL = 01h
	DX = device ID
Return: CF clear on success
	    AH = 00h
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D600h/BL=00h,AX=D601h/BL=01h
--------B-15D601BL00-------------------------
INT 15 - later PS/2s - READ BOOT DEVICE KEY
	AX = D601h
	BL = 00h
	DX = device ID
Return: CF clear on success
	    AH = 00h
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D600h/BL=00h,AX=D601h/BL=01h,AX=D602h
--------B-15D601BL01-------------------------
INT 15 - later PS/2s - WRITE BOOT DEVICE KEY
	AX = D601h
	BL = 01h
	DX = device ID
Return: CF clear on success
	    AH = 00h
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D600h/BL=01h,AX=D601h/BL=00h
--------B-15D602-----------------------------
INT 15 - later PS/2s - QUERY BOOT REFERENCE PARTITION
	AX = D602h
Return: CF clear on success
	    AH = 00h
	    AL = status of reference-partition boot request
		00h boot not requested
		01h boot requested
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D601h/BL=00h
--------X-15D800-----------------------------
INT 15 - EISA SYSTEM ROM - READ SLOT CONFIGURATION INFORMATION
	AX = D800h
	CL = slot number (including embedded and virtual)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code
		80h invalid slot number
		82h EISA CMOS corrupt
		83h empty slot
		86h invalid BIOS-FW function call
		87h invalid system configuration
	AL bit flags
	    bit 7: set if duplicate IDs
	    bit 6: set if product ID readable
	    bits 4,5: slot type (00=expansion, 01=embedded, 10=virtual device)
	    bits 0-3: duplicate ID number if bit 7 set
	BH = major revision level of configuration utility
	BL = minor revision level of configuration utility
	CX = checksum of configuration file
	DH = number of device functions
	DL = combined function information byte
	SI:DI = 4-byte compressed ID (DI = bytes 0&1, SI = bytes 2&3)
Note:	call with AL=80h if using 32-bit CS addressing mode instead of 16-bit
SeeAlso: AX=D801h,AX=D804h
--------X-15D801-----------------------------
INT 15 - EISA SYSTEM ROM - READ FUNCTION CONFIGURATION INFORMATION
	AX = D801h
	CH = function number to read
	CL = slot number (including embedded and virtual)
	DS:SI -> 320-byte buffer for standard configuration data block
Return: CF clear if successful
	    AH = 00h
	    DS:SI buffer filled
	CF set on error
	    AH = error code
		80h invalid slot number
		81h invalid function number
		82h EISA CMOS corrupt
		83h empty slot
		86h invalid BIOS-FW function call
		87h invalid system configuration
	BX destroyed
Note:	call with AL=81h if using 32-bit CS addressing mode instead of 16-bit
--------X-15D802-----------------------------
INT 15 - EISA SYSTEM ROM - CLEAR NONVOLATILE MEMORY (EISA CMOS)
	AX = D802h
	BH = EISA config utility major revision level
	BL = EISA config utility minor revision level
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code
		84h error clearing CMOS
		86h invalid BIOS-FW function call
		88h config utility version not supported
Note:	call with AL=82h if using 32-bit CS addressing mode instead of 16-bit
SeeAlso: AX=D803h
--------X-15D803-----------------------------
INT 15 - EISA SYSTEM ROM - WRITE NONVOLATILE MEMORY
	AX = D803h
	CX = length of data structure (0000h = empty slot)
		includes two bytes for config file checksum
	DS:SI -> configuration data
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code
		84h error clearing CMOS
		85h EISA CMOS is full
		86h invalid BIOS-FW function call
Note:	call with AL=83h if using 32-bit CS addressing mode instead of 16-bit
SeeAlso: AX=D802h
--------X-15D804-----------------------------
INT 15 - EISA SYSTEM ROM - READ PHYSICAL SLOT
	AX = D804h
	CL = slot number (including embedded and virtual)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code
		80h invalid slot number
		83h empty slot
		86h invalid BIOS-FW function call
	SI:DI = 4-byte compressed ID (DI = bytes 0&1, SI = bytes 2&3)
Note:	call with AL=84h if using 32-bit CS addressing mode instead of 16-bit
SeeAlso: AX=D800h
--------b-15D820-----------------------------
INT 15 - Compaq LTE Lite - GET ???
	AX = D820h
	DS:SI -> 17-byte buffer for ???
Return: DS:SI buffer filled (first byte is length of remaining data, unless
	  it is greater than 10h, in which case the second byte is 00h and no
	  other data is returned)
Note:	this function is also supported by Compaq's EISA System ROM, Contura
	  486/486c/486cx and recent DESKPRO/i ROMs
SeeAlso: AX=D821h
--------b-15D821-----------------------------
INT 15 - Compaq LTE Lite - SET ???
	AX = D821h
	DS:SI -> counted string (should not be more than 16 bytes)
Return: AH = 00h
Note:	this function is also supported by Compaq's EISA System ROM, Contura
	  486/486c/486cx and recent DESKPRO/i ROMs
SeeAlso: AX=D820h
--------b-15D822BL00-------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - GET ???
	AX = D822h
	BL = 00h
	CX = size of buffer or 0000h to retrieve required buffer size
	DS:SI -> buffer for ??? (if CX nonzero)
Return: CF clear if successful
	    AH = 00h
	    DH = 08h
	    CX = required buffer size to retrieve all data (if CX=0 on entry)
	    DS:SI buffer filled (if CX nonzero on entry)
	CF set on error (BL nonzero)
	    AH = 86h
--------b-15D823-----------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - ???
	AX = D823h
	BL = subfunction??? (00h or 80h)
	BH = ???
	DS:SI -> buffer for ??? (see below)
Return: CF clear if successful
	    AH = 00h
	    DH = 08h
	    DL = ???
	CF set on error
	    AH = error code
		86h BL neither 00h nor 80h
		87h ???

Format of buffer:
Offset	Size	Description
 00h	BYTE	???
 01h	WORD	???
 03h	BYTE	???
 04h	WORD	???
 06h	WORD	???
	???
----------15D824-----------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - ???
	AX = D824h
	CX = ???
	DS:SI -> ASCIZ string containing ???
Return: CF clear if successful
	    AH = 00h
	    CX = ???
	CF set on error
	    AH = error code
		87h ??? failed
		88h ???
Note:	these functions are only available if ??? from keyboard controller
	  command C0h
----------15D825-----------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - ???
	AX = D825h
	CX = ???
	SI = ???
	DI = ???
	???
Return: CF clear if successful
	    AH = 00h
	    CX = ???
	CF set on error
	    AH = error code
		87h ??? failed
		88h ???
		    CX = ???
Note:	these functions are only available if ??? from keyboard controller
	  command C0h
----------15D826-----------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - ???
	AX = D826h
	BX = ???
	CX = size of buffer in bytes
	DS:SI -> buffer for ???
	???
Return: CF clear if successful
	    AH = 00h
	    CX = ???
	CF set on error
	    AH = error code
		87h ??? failed
		88h ???
Note:	these functions are only available if ??? from keyboard controller
	  command C0h
--------X-15D8-------------------------------
INT 15 - EISA SYSTEM ROM - 32-bit CS ADDRESSING MODE CALLS
	AH = D8h
	AL = 80h to 84h
	other registers as appropriate for AL=00h to 04h
Return: as appropriate for AL=00h to 04h
Note:	these functions are identical to AX=D800h to D804h, except that they
	  should be called when using 32-bit CS addressing mode (pointers use
	  ESI rather than SI as offset) instead of 16-bit addressing mode
SeeAlso: AX=D800h,AX=D801h,AX=D802h,AX=D803h,AX=D804h
--------b-15D8-------------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - 32-bit CS ADDRESSING MODE CALLS
	AH = D8h
	AL = A0h to A6h
	other registers as appropriate for AL=20h to 26h
Return: as appropriate for AL=20h to 26h
Note:	these functions are identical to AX=D820h to D826h, except that they
	  should be called when using 32-bit CS addressing mode
--------Q-15DE00-----------------------------
INT 15 - DESQview - GET PROGRAM NAME
	AX = DE00h
Return: AX = offset into DESQVIEW.DVO of program most recently selected from
		the "Switch Windows" menu (see below)
Note:	always returns AX=0000h under DESQview/X
SeeAlso: AX=DE07h

Format of program entry in DESQVIEW.DVO:
Offset	Size	Description
 00h	BYTE	length of name (FFh if end of file)
 01h  N BYTEs	name
      2 BYTEs	keys to invoke program (second = 00h if only one key used)
	BYTE	program type
		00h normal program
		04h divider
		80h Delete a Program
		81h Change a Program
	WORD	??? apparently always 0000h
--------Q-15DE01-----------------------------
INT 15 - DESQview - UPDATE "OPEN WINDOW" MENU
	AX = DE01h
Return: nothing
Notes:	reads DESQVIEW.DVO, disables Open menu if file not in current directory
	NOP for DESQview/X
--------Q-15DE02-----------------------------
INT 15 - DESQview 1.x only - SET ??? FLAG FOR CURRENT WINDOW
	AX = DE02h
Return: nothing
Note:	this call is a NOP in DV 2.x
SeeAlso: AX=DE03h
--------Q-15DE03-----------------------------
INT 15 - DESQview 1.x only - GET ??? FOR CURRENT WINDOW
	AX = DE03h
Return: AX = ??? for current window
	BX = ??? for current window
Note:	this call is a NOP in DV 2.x
SeeAlso: AX=DE02h
--------Q-15DE04-----------------------------
INT 15 - DESQview - GET AVAILABLE COMMON MEMORY
	AX = DE04h
Return: BX = bytes of common memory available
	CX = largest block available
	DX = total common memory in bytes
SeeAlso: AX=DE05h,AX=DE06h
--------Q-15DE05-----------------------------
INT 15 - DESQview - GET AVAILABLE CONVENTIONAL MEMORY
	AX = DE05h
Return: BX = KB of memory available
	CX = largest block available
	DX = total conventional memory in KB
SeeAlso: AX=DE04h,AX=DE06h
--------Q-15DE06-----------------------------
INT 15 - DESQview - GET AVAILABLE EXPANDED MEMORY
	AX = DE06h
Return: BX = KB of expanded memory available
	CX = largest block available
	DX = total expanded memory in KB
SeeAlso: AX=DE04h,AX=DE05h
--------Q-15DE07-----------------------------
INT 15 - DESQview - "APPNUM" - GET CURRENT PROGRAM'S NUMBER
	AX = DE07h
Return: AX = number of program as it appears on the "Switch Windows" menu
Note:	this API call may be made from a hardware interrupt handler
SeeAlso: AX=DE00h
--------Q-15DE08-----------------------------
INT 15 - DESQview - GET ???
	AX = DE08h
Return: AX = 0000h if ??? is not set to the current task
	     0001h if ??? is set to the current task
--------Q-15DE09-----------------------------
INT 15 - DESQview - UNIMPLEMENTED
	AX = DE09h
Return: nothing (NOP in DV 1.x and 2.x)
--------Q-15DE0A-----------------------------
INT 15 - DESQview v2.00+ - "DBGPOKE" - DISPLAY CHARACTER ON STATUS LINE
	AX = DE0Ah
	BL = character
Return: character displayed, next call will display in next position (which
	wraps back to the start of the line if off the right edge of screen)
Notes:	displays character on bottom line of *physical* screen, regardless
	  of current size of window (even entirely hidden)
	does not know about graphics display modes, just pokes the characters
	  into display memory
	this API call may be made from a hardware interrupt handler
SeeAlso: AX=1003h
--------Q-15DE0B-----------------------------
INT 15 - DESQview v2.00+ - "APILEVEL" - DEFINE MINIMUM API LEVEL REQUIRED
	AX = DE0Bh
	BL = API level minor version number
	BH = API level major version number
Return: AX = maximum API level (AH = major, AL = minor)
Notes:	if the requested API level is greater than the version of DESQview, a
	  "You need a newer version" error window is popped up
	the API level defaults to 1.00, and is inherited by child tasks
--------Q-15DE0C-----------------------------
INT 15 - DESQview v2.00+ - "GETMEM" - ALLOCATE "SYSTEM" MEMORY
	AX = DE0Ch
	BX = number of bytes
Return: ES:DI -> allocated block or 0000h:0000h (DV 2.26+)
Note:	use SETERROR (AX=DE15h) to avoid a user prompt if there is insufficient
	  system memory
SeeAlso: AX=1001h,AX=102Eh,AX=DE0Dh,AX=DE15h,AX=DE19h
--------Q-15DE0D-----------------------------
INT 15 - DESQview v2.00+ - "PUTMEM" - DEALLOCATE "SYSTEM" MEMORY
	AX = DE0Dh
	ES:DI -> previously allocated block
Return: nothing
SeeAlso: AX=1002h,AX=DE0Ch
--------Q-15DE0E-----------------------------
INT 15 - DESQview v2.00+ - "FINDMAIL" - FIND MAILBOX BY NAME
	AX = DE0Eh
	ES:DI -> name to find
	CX = length of name
Return: BX = 0000h not found
	     0001h found
		DS:SI = object handle
SeeAlso: AH=12h/BH=11h,AH=12h/BX=1200h"GETNAME"

Special mailbox names:
 "COM1" ... "COM4"	RBcomm using COM1 ... COM4
 "DESQview/X Help Engine"
 "DESQview/X Network Server"  Network Manager
 "DESQview X Server0"	X-Windows server
 "DESQview X Server7"	X-Windows printing service
 "INBOX"		DESQview/X LPD requests
 "OUTBOX"		DESQview/X LPD responses
 "WAITBOX"		semaphore to synchronize DESQview/X LPD communications
 "_DVNM_"		DV/X v1.10 network manager
--------Q-15DE0F-----------------------------
INT 15 - DESQview v2.00+ - ENABLE DESQview EXTENSIONS
	AX = DE0Fh
Return: AX and BX destroyed (seems to be bug, weren't saved&restored)
Notes:	sends a manager stream with opcodes AEh, BDh, and BFh to task's window
	enables an additional mouse mode
--------Q-15DE10-----------------------------
INT 15 - DESQview v2.00+ - "PUSHKEY" - PUT KEY INTO KEYBOARD INPUT STREAM
	AX = DE10h
	BH = scan code
	BL = character
Return: nothing
Notes:	a later read will get the keystroke as if it had been typed by the user
	multiple pushes are read last-in first-out
	if a script exists for the pushed key in the current application, the
	  script will be executed
	early copies of DV 2.00 destroy AX, BX, ES, and DI
SeeAlso: INT 16/AH=05h
--------Q-15DE11BL00-------------------------
INT 15 - DESQview v2.00+ - "JUSTIFY" - EN/DISABLE AUTOM. WINDOW JUSTIFICATION
	AX = DE11h
	BL = 00h      viewport will not move automatically
	     nonzero  viewport will move to keep cursor visible (default)
Return: nothing
--------Q-15DE12BX0000-----------------------
INT 15 - DESQview v2.01+ - "CSTYLE" - SET "C"-COMPATIBLE CONTROL CHAR INTERPRET
	AX = DE12h
	BX = 0000h    select normal style (linefeed only moves down)
	     nonzero  select C style (linefeed moves to start of next line)
Return: nothing
Note:	set on a per-task basis, and inherited from the parent task
--------Q-15DE13-----------------------------
INT 15 - DESQview v2.20+ - "GETCRIT" - GET CRITICAL NESTING COUNT
	AX = DE13h
Return: BX = number of calls to BEGINC or ENTERC (see INT 15/AX=101Bh,DE1Ch)
	     without matching ENDC (see INT 15/AX=101Ch)
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=101Bh,AX=101Ch,AX=DE1Bh,AX=DE1Ch
--------Q-15DE14-----------------------------
INT 15 - DESQview v2.20+ - GET OBJECT TYPE
	AX = DE14h
	ES:DI -> object
Return: BL = 00h not an object
	     08h window or task
	     09h mailbox
	     0Ah keyboard
	     0Bh timer
	     0Ch objectq
	     0Fh pointer
	     10h panel
SeeAlso: AX=1016h
--------Q-15DE15-----------------------------
INT 15 - DESQview v2.20+ - SET ERROR HANDLING
	AX = DE15h
	BL = error handling mode
	    00h post system error on all error conditions
	    01h return carry flag set on calls to ADDTO, SUBFROM, and WRITE
		messages sent to mailboxes which fail due to lack of system
		or common memory
	    02h (v2.26+) same as 01h, but also return null pointer for GETMEM
		calls which fail due to lack of system memory
Return: nothing
SeeAlso: AX=DE0Ch,AX=DE16h
--------Q-15DE16-----------------------------
INT 15 - DESQview v2.20+ - GET ERROR HANDLING
	AX = DE16h
Return: BL = current mode
	    00h always post system error
	    01h return carry flag set on failed mailbox writes
	    02h return CF set on failed mailbox writes and NULL on failed
		GETMEM calls
SeeAlso: AX=DE15h
--------Q-15DE17-----------------------------
INT 15 - DESQview v2.20-2.25 - reserved
	AX = DE17h
Return: pops up "Programming error" window
Note:	AX = 1117h is NOT identical to this call under DESQview 2.20 thru 2.25
SeeAlso: AX=1117h
--------Q-15DE17-----------------------------
INT 15 - DESQview v2.26+ - "ASSERTMAP" - GET/SET MAPPING CONTEXT
	AX = DE17h
	BX = function
	    0000h   get current mapping context without setting
	    nonzero set new mapping context to BX
Return: BX = mapping context in effect before call
Notes:	mapping contexts determine conventional-memory addressability; setting
	  a mapping context ensures that the associated program and data areas
	  are in memory for access.  Usable by drivers, TSRs and shared
	  programs.
	caller need not be running under DESQview
	this API call may be made from a hardware interrupt handler
SeeAlso: AX=1016h,AX=1117h,AX=DE21h,INT 2F/AX=1685h
--------Q-15DE18-----------------------------
INT 15 - DESQview v2.20+ - internal - ???
	AX = DE18h
	BP = function number
	    high byte must be 10h
	    low byte is function
		00h set ???
		    BL = ???  (00h-10h, video mode???)
		    BH = value to store
		03h set ???
		    BL = ??? (stored in driver)
		0Ah get ???
		    ES:DI -> 18-byte buffer to hold ???
Note:	calls video driver (NOP for Hercules driver,probably CGA and MCGA also)
--------Q-15DE19-----------------------------
INT 15 - DESQview v2.23+ - "GETCOMMON" - ALLOCATE "COMMON" MEMORY
	AX = DE19h
	BX = number of bytes to allocate
Return: AX = 0000h successful
		ES:DI -> allocated block
	     nonzero insufficient memory
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=DE0Ch,AX=DE15h,AX=DE1Ah
--------Q-15DE1A-----------------------------
INT 15 - DESQview v2.23+ - "PUTCOMMON" - DEALLOCATE "COMMON" MEMORY
	AX = DE1Ah
	ES:DI -> previously allocated block
Return:	AX = 0000h (successful)
Note:	this function may be called from within a hardware interrupt handler
SeeAlso: AX=DE0Dh,AX=DE19h
--------Q-15DE1B-----------------------------
INT 15 - DESQview v2.23+ internal - DECREMENT CRITICAL NESTING COUNT
	AX = DE1Bh
Return: nothing
SeeAlso: AX=101Ch,AX=DE13h,AX=DE1Ch
--------Q-15DE1C-----------------------------
INT 15 - DESQview v2.23+ - "ENTERC" - INCREMENT CRITICAL NESTING COUNT
	AX = DE1Ch
Return: nothing
Notes:	similar to AX=101Bh, but begins the critical region without ensuring
	  that DOS is free
	the official documentation states that this call should be paired with
	  "ENDC" (AX=101Ch); no mention is made of AX=DE1Bh
	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=101Bh,AX=101Ch,AX=DE13h,AX=DE1Bh
--------Q-15DE1D-----------------------------
INT 15 - DESQview v2.23+ - "PUTKEY" - FAKE USER KEYSTROKES
	AX = DE1Dh
	DX = segment of handle for task to receive keystroke
	BL = character
	BH = scan code
Return: AX = 0000h if successful
	   nonzero if receiver's keyboard buffer was full
Notes:	the key is treated as though the user had pressed it, ignoring any
	  script which may be bound to the key, and using the current field
	  table if the keyboard object is in field processing mode
	multiple PUTKEYs are seen in the order in which they are executed
SeeAlso: AX=DE10h
--------Q-15DE1E-----------------------------
INT 15 - DESQview v2.23+ - "SCRNINFO" - GET TRUE VIDEO PARAMETERS
	AX = DE1Eh
Return: CL = actual number of rows on screen
	CH = actual number of columns on screen
	BL = actual video mode (may differ from INT 10/AH=0Fh return) (v2.26+)
Note:	this API call may be made from a hardware interrupt handler
SeeAlso: INT 10/AH=0Fh
--------Q-15DE1F-----------------------------
INT 15 - DESQview v2.23+ - "DOSUSER" - GET HANDLE OF TASK CURRENTLY USING DOS
	AX = DE1Fh
Return: BX = segment of task handle or 0000h if no tasks are using DOS
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=DE13h,INT 21/AH=34h
--------Q-15DE20-----------------------------
INT 15 - DESQview v2.26+ - "DISPATCHINT" - INTERRUPT ANOTHER TASK
	AX = DE20h
	BX = segment of handle of task to interupt
	DX:CX -> FAR interrupt routine
	BP,SI,DI,DS,ES as required by interrupt routine
Return: nothing
Notes:	unlike "PGMINT" (AX=1021h), DISPATCHINT may be applied to the task
	  making the DISPATCHINT call
	multiple "DISPATCHINT" calls are processed in the order in which they
	  were executed
	the FAR routine is entered with the current ES, DS, SI, DI, and BP
	  values, using the task's internal stack (see AX=101Ah); only SS:SP
	  needs to be preserved
	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=1021h,AX=DE2Ah
--------Q-15DE21-----------------------------
INT 15 - DESQview v2.26+ - "ASSERTVIR" - CONTROL 386 SCREEN VIRTUALIZATION
	AX = DE21h
	BX = new state
	    0000h turn off
	    nonzero turn on
Return: BX = old state of virtualization
Notes:	this API call may be made from within a hardware interrupt handler
	under DV 2.40 and 2.42, this call appears to have no effect and always
	  returns a nonzero value in BX which appears to be the offset within
	  the DV common memory segment of the caller's task object; it may
	  only have an effect within a hardware interrupt handler
SeeAlso: AX=1117h,AX=DE17h
--------Q-15DE22-----------------------------
INT 15 - DESQview v2.26+ - "PROCESSMEM" - GET TASK MEMORY STATUS
	AX = DE22h
	DX = segment of task handle
Return: DX = total amount of memory in paragraphs
	BX = amount of system memory in paragraphs
	CX = largest block of system memory available in paragraphs
	AX = flags
	    bit 0: system memory resides in shared memory
	    bit 1: process's memory is swapped out
	    bit 2: process's system memory is swapped out
Notes:	if the task handle is a child task, the returned values will be for the
	  process containing the task, rather than the task itself
	if the process's system memory is swapped out, BX,CX,DX remain
	  unchanged, because the memory usage cannot be determined
SeeAlso: AX=DE04h,AX=DE05h,AX=DE06h
--------Q-15DE23-----------------------------
INT 15 U - DESQview v2.31+ - ???
	AX = DE23h
	BX = ??? IRQ number on first PIC?
	CX = ??? IRQ number on second PIC?
Return: ???
Note:	called by QEMM 6.00+
--------Q-15DE24-----------------------------
INT 15 - DESQview v2.40+ - "XNEWPROC" - START NEW APPLICATION
	AX = DE24h
	BX = length of .DVP data
	CX = length of ??? string
	DS:SI -> ??? string
	ES:DI -> .DVP data (see AX=102Ch)
Return: BX = segment of task handle??? or 0000h on error
Note:	this call is similar to AX=102Ch except that it can interpret the
	  extended DVP data
SeeAlso: AX=102Ch
--------Q-15DE25-----------------------------
INT 15 - DESQview v2.40+ - "GETDVPATH" - GET DESQview DIRECTORY
	AX = DE25h
	ES:DI -> 67-byte buffer for ASCIZ directory name
Return: ES:DI buffer filled with directory from which DESQview was started
BUG:	DV 2.42 does not place a terminating NUL at the end of the directory
	  name, so if the buffer is not cleared to zeros before the call,
	  there is no way to tell where the directory name ends.  This bug
	  has been fixed in DV 2.52 (DV/X 1.02)
SeeAlso: AX=DE2Eh,INT 21/AH=47h
--------Q-15DE26-----------------------------
INT 15 - DESQview v2.40+ - "GETFOREGROUND" - GET KEYBOARD FOCUS
	AX = DE26h
Return: BX = segment of handle for task with keyboard focus
Note:	under DESQview/X, the X server always has the keyboard focus unless a
	  "direct" window is active
SeeAlso: AX=DE2Fh,INT 2F/AX=DE0Ah
--------Q-15DE27-----------------------------
INT 15 - DESQview v2.50+ - "ADDINSTANCEDATA" - ADD PER-TASK SAVE/RESTORE AREA
	AX = DE27h
	BX = type
	    0000h process
	    0001h task
	ES:DI -> list of Instance Item Structures (see below)
Return: CF clear if successful
	    AX = ???
	    BX = ???
	CF set on error
	    AX = error code???
		0004h invalid BX value
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
SeeAlso: INT 2F/AX=DE08h,INT 2F/AX=DE09h

Format of Instance Item Structure [one element of list]:
Offset	Size	Description
 00h	WORD	length of data area DESQview should save and restore on context
		switches (0000h = end of list)
 02h	DWORD	pointer to area to be saved/restored
--------Q-15DE28-----------------------------
INT 15 U - DESQview v2.50+ - ???
	AX = DE28h
	BX = segment of ??? or 0000h for default
	???
Return: ???
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
SeeAlso: AX=DE2Ah
--------Q-15DE29BX0000-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0000h
	???
Return: CF clear if successful
	    ???
	CF set on error
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	under DESQview 2.60, this function and all other subfunctions of
	  AX=DE29h always return CF set, as they are unique to DESQview/X
--------Q-15DE29BX0001-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0001h
	DX = segment of window handle
Return: CF clear if successful
	    AX = ???
	    DX = ???
	CF set on error
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
--------Q-15DE29BX0002-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0002h
	DX = segment of window handle
Return: CF clear if successful
	    AX = ???
	    DX = ???
	CF set on error
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
--------Q-15DE29BX0003-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0003h
	DX = segment of window handle
Return: CF clear if successful
	    ???
	CF set on error
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
--------Q-15DE29BX0004-----------------------
INT 15 U - DESQview/X - GET DISPLAY NAME
	AX = DE29h
	BX = 0004h
	CX = size of buffer in bytes
	DX = segment of window handle
	ES:DI -> buffer for display name
Return: CF clear if successful
	    buffer filled with ASCIZ display name (truncated if necessary) or
	      null string if no display
	CF set on error
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	the name ":0" refers to the local display
--------Q-15DE29BX0005-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0005h
	???
Return: CF clear if successful
	    ???
	CF set on error
Note:	under DESQview 2.60, this function and all other subfunctions of
	  AX=DE29h always return CF set, as they are unique to DESQview/X
--------Q-15DE2A-----------------------------
INT 15 - DESQview v2.50+ - "DISPATCHINTAFTERDOS" - INTERRUPT ANOTHER TASK
	AX = DE2Ah
	BX = segment of handle for task to interrupt or 0000h for caller
	DX:CX -> interrupt routine
	BP,SI,DI,DS,ES as required by interrupt routine
Return: nothing
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	this call is the same as AX=DE20h except that it will delay
	  interrupting the specified task until after it has exited DOS
SeeAlso: AX=1021h,AX=DE20h
--------Q-15DE2B-----------------------------
INT 15 - DESQview v2.50+ - "OBJNEXT" - TRAVERSE OBJECT LIST
	AX = DE2Bh
	ES:DI -> starting object
		0000h:0000h for first object in list???
Return: AX = status
	    0000h successful
		ES:DI -> next object of same type (window/non-window)
	    0001h failed (ES:DI was not a valid handle)
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	there are two separate lists, one for window/task objects and one
	  for all other objects
SeeAlso: AX=1016h,AX=DE2Ah,AX=DE2Ch
--------Q-15DE2C-----------------------------
INT 15 - DESQview v2.50+ - "WININFO" - GET WINDOW INFORMATION
	AX = DE2Ch
	DX = window information format version (0100h for DESQview 2.5x)
	BX = segment of window handle or 0000h for default
	ES:DI -> buffer for window information (see below)
Return: AX = status
	    0000h successful
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
SeeAlso: AX=1000h,AX=1016h,AX=DE01h,AX=DE2Bh

Format of window information:
Offset	Size	Description
 00h	BYTE	task flag: 00h window, 01h task
 01h	BYTE	process number if owner task
		00h if non-owner task
 02h	WORD	segment of owner's handle, 0000h if orphaned
 04h	WORD	mapping context (see AX=1016h)
 06h	BYTE	task status (see below)
 07h	BYTE	unused
 08h	WORD	status bits (see below)
 0Ah	BYTE	01h if foreground-only window

Values for task status:
 00h	"Waiting" waiting for input
 01h	"Idle" keyboard poll limit reached
 03h	same as 01h
 04h	"Pausing" INT 15/AX=1000h pause called
 04h	DV/X direct: user did something to allow task switch
 05h	"ModeChg" video mode about to be changed
 06h	"ModeNtf" notify that video mode changed
 07h	"MoniCh" requested change to other monitor
 08h	"StartPgm" control relinquished to start new process
 09h	"MgrCan" made window manager CANCEL command
 0Ah	"Slicing" time slice expired
 0Bh	"Exit DOS" notify on DOS calls
 0Ch	"Enter DOS" process is re-entering DOS
 0Dh	"Terminate" INT 21/AH=4Ch or task freed
 0Eh	"BrkNxt" Control-Break pressed
 0Fh	"MgrCol" keyboard focus taken away
 10h	"PgmInt" interrupted by API call from another task
 11h	"BldOpen" call to INT 15/AX=DE01h

Bitfields for status bits:
 bit 0	DESQview process
 bit 1	process swapped out
 bit 2	process is resized direct window (suspended)
 bit 3	process suspended itself
 bit 4	user suspended process
 bit 5	process is being created
 bit 6	task is freeing another task
--------Q-15DE2D-----------------------------
INT 15 U - DESQview v2.50+ - GET/SET SOCKET HANDLER
	AX = DE2Dh
	CX = direction
	    FFFFh set socket handler
		DX:BX -> FAR function for socket interface
			must be of the format described under INT 63"DESQview"
	    other get socket handler
		Return: DX:BX -> socket handler
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	the "set" subfunction is normally called only by SOCKET.DVR
SeeAlso: AX=DE2Eh,INT 63"DESQview"
--------Q-15DE2E-----------------------------
INT 15 U - DESQview v2.50+ - SOCKET API
	AX = DE2Eh
	DX:BX -> socket record or 0000h:0000h to create a new socket record
Return: CX = size of socket record in bytes
	DX:BX -> socket record which was used
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	socket records are allocated from common memory
	for Unix compatibility, each socket and connection on a socket is
	  allocated a DOS file handle (referencing an SFT for NUL) which is
	  used on various calls to specify which of possibly multiple
	  connections is to be operated upon
SeeAlso: AX=DE2Dh,INT 61/AX=0001h"VINES",INT 63"DESQview"

Values for function number:
 0000h	initialize socket???
 0001h	"gethostname"
 0002h	"ioctl" check for input
 0003h	"sleep" delay for specified period
 0004h	"htons" convert word to network (big-endian) byte order
 0005h	"select"
 0006h	"bsd_close"/"so_close" close socket
 0007h	NOP
 0008h	"connect" initiate connection on socket
 0009h	"recv"/"recvfrom" read from socket
 000Ah	"socket"
 000Bh	???
 000Ch	"gethostbyname"
 000Dh	"send"/"sendto" write to socket
 000Eh	??? (does something to all connections for process)
 000Fh	"getpid" get process identifier
 0010h	"gettimeofday"
 0011h	"bind" assign name to socket
 0012h	"listen" listen for connections on socket
 0013h	"accept" accept connection on socket
 0014h	connect to X server
 0015h	"gethostbyaddr" get host information for an address
 0016h	"getprotobyname"
 0017h	"getprotobynumber"
 0018h	"getservbyname"
 0019h	"getservbyport"
 001Ah	"getsockname" determine name bound to socket
 001Bh	"getpeername" get name of connected peer
 001Ch	"getsockopt"/"setsockopt"
 001Dh	"so_exit"	 close all sockets for calling process
 001Eh	"issock" determine whether file handle references socket
 001Fh	"so_attach" reattach previously detached socket
 0020h	"so_detach" temporarily detach socket
 0021h	get DESQview directory
 0022h	"NewProc" start new application (see AX=102Ch)
 0023h	"so_linkup"
 0024h	canonicalize filename
 0025h	indirect INT 15h call
 0026h	Network Manager interface
 0027h	"so_unlink"    close connection from "so_linkup"
 0028h	"raisepriority"
 0029h	"lowerpriority"
 002Ah	???
 FFFFh	"NetExit" (appears to be a NOP)

Format of socket record:
Offset	Size	Description
 00h	WORD	signature F0ADh
 02h	WORD	function number (see above)
 04h	WORD	returned error code (see below)
 06h	WORD	maximum message size??? (usually 0400h)
 08h	WORD	PSP segment to use or 0000h if socket not valid
 0Ah	WORD	scratch space (JFT size)
 0Ch	DWORD	scratch space (JFT address)
 10h	DWORD	mailbox handle (initialized by function 0000h)
 14h	DWORD	timer object handle (initialized by function 0000h)
---function 0000h---
 18h	WORD	(return) ???
---function 0001h---
 18h	WORD	(return) status???
 1Ah 128 BYTEs	(return) ASCIZ hostname (empty string if not on network)
 9Ah	WORD	maximum length of hostname to return
---function 0002h---
 18h	WORD	(return) status
 1Ah	WORD	socket's file handle
 1Ch	WORD	IOCTL function
		05h "FIONREAD" determine available input
		06h "FIONBIO" set blocking state of socket
 1Eh	WORD	(return, subfn 05h) number of bytes available for reading
		(call, subfn 06h) 0000h blocking, nonzero nonblocking
---function 0003h---
 18h  2 BYTEs	unused
 1Ah	WORD	delay time in seconds
---function 0004h---
 18h	WORD	(return) result in network (big-endian) byte order
 1Ah	WORD	value to convert to network byte order
---function 0005h---
 18h	WORD	(return) number of handles meeting the specified conditions???
 1Ah	WORD	number of file handles in each bitset???
 1Ch	DWORD	bitset of socket handles to check for readability???
 20h	DWORD	bitset of socket handles to check for writability???
 24h	DWORD	bitset of socket handles to check for errors???
 28h	WORD	timeout in ??? or 0000h to block until some socket ready
 2Ah	DWORD	???
 2Eh	DWORD	???
---function 0006h---
 18h	WORD	(return) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
---function 0008h---
 18h	WORD	(return) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	0001h if socket name specified, 0000h if not
 1Eh	WORD	length of socket name
 20h  N BYTEs	name of socket to which to connect
---function 0009h---
 18h	WORD	(return) number of bytes actually read, 0000h if connection
			closed, or FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	number of bytes to read
 1Eh	WORD	flags
 20h	WORD	0000h if no source address desired
		0001h if source address is to be stored (datagram sockets)
 22h	WORD	length of source address
 24h 110 BYTEs	source address
 92h 1K BYTEs	buffer for data to be read
---function 000Ah---
 18h	WORD	(return) socket's file handle or FFFFh on error
 1Ah	WORD	address family (0001h,0002h)
 1Ch	WORD	socket type
 1Eh	WORD	protocol
---function 000Bh---
 18h	WORD	(return) 0001h if ??? or FFFFh on error
 1Ah	WORD	socket's file handle
 1Eh	WORD	(call) ???
---function 000Ch---
 18h 128 BYTEs	buffer containing ASCIZ hostname
		special case if empty string or "unix"
 98h	???	'struct hostent' ???
 A2h	???	(return) ???
---function 000Dh---
 18h	WORD	(return) number of bytes actually written or FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	number of bytes to write
 1Eh	WORD	number of bytes to follow in subsequent writes???
 20h	WORD	flags
 22h	WORD	0000h if no destination specified, 0001h if destination present
 24h	WORD	???
 26h	WORD	length of destination address
 28h 110 BYTEs	destination address
 96h 1K BYTEs	buffer containing data to be written
---function 000Eh---
 no additional fields
---function 000Fh---
 18h	DWORD	(return) DESQview task handle of calling process
---function 0010h---
 18h	DWORD	(return) current time
 1Ch	DWORD	(return) ???
---function 0011h---
 18h	WORD	(return) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	length of name
 1Eh  N BYTEs	buffer for socket name
---function 0012h---
 18h	WORD	(return) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	maximum backlog of pending connections allowed on socket
---function 0013h---
 18h	WORD	(return) file handle for new connection or FFFFh on error
 1Ah	WORD	listen()ing socket's file handle
 1Ch	WORD	(call) length of buffer for connecting entity's address
		(return) actual length of address
 1Eh  N BYTEs	buffer for connecting entity's address
---function 0014h---
 18h	WORD	(return) socket's file handle or FFFFh on error
 1Ah  4 BYTEs	(return) ???
 1Eh	WORD	(return) ???
 20h	WORD	(return) ???
 22h 256 BYTEs	ASCIZ X display name
122h	???
---function 0015h---
 18h	WORD	(call) type of address??? (test for 0001h seen)
 1Ah	WORD	(call) length of buffer for host address
 1Ch 110 BYTEs	buffer containing host address
 8Ah	WORD	(return) offset of official host name???
 8Ch	WORD	(return) offset of alias list???
 8Eh	WORD	(return) address type???
 90h	WORD	(return) length of an address in bytes???
 92h	WORD	(return) offset of address???
 9Ah  N BYTEs	(return) ??? buffer for hostname, alias list, and host address
---function 0016h---
 18h	???	buffer for protocol name???
 98h	???
---function 0017h---
 18h	WORD	(call) protocol number???
 1Ah	WORD	(return) ??? or 0001h
---function 0018h---
 18h 128 BYTEs	buffer containing ???
 98h 128 BYTEs	buffer containing ???
118h	WORD	(return) ???
---function 0019h---
 18h	WORD	length of name???
 1Ah 128 BYTEs	buffer for name???
 9Ah	WORD	(return) ???
---function 001Ah---
 18h	WORD	(return) 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	(call) length of buffer for socket name
		(return) actual length of socket name
 1Eh  N BYTEs	buffer for socket name
---function 001Bh---
 18h	WORD	(return) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	(call) size of buffer for name
		(return) actual size of name
 1Eh  N BYTEs	buffer for peer's name
---function 001Ch---
 18h	WORD	(return) status: 0000h if successful, FFFFh on error
 1Ah	WORD	direction: 0000h to get, 0001h to set
 1Ch	WORD	socket's file handle
 1Eh	WORD	option level
 20h	WORD	option name
 22h	WORD	(call) length of buffer for option value
		(return) actual length of option value
 24h  N BYTEs	buffer for option value
---function 001Dh---
 no additional fields
---function 001Eh---
 18h	WORD	(return) status: 0000h ??? or 0001h ???
 1Ah	WORD	file handle which may or may not be a socket
---function 001Fh---
 18h	WORD	(return) file handle or FFFFh on error
 1Ah	DWORD	(call) pointer to Socket Context Record (see below) of a
			previously detached socket
---function 0020h---
 18h	WORD	(return) status: 0000h if successful or FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	DWORD	(return) pointer to Socket Context Record (see below) for
			the file handle
---function 0021h---
 18h 64 BYTEs	buffer for DESQview startup directory (see AX=DE25h)
---function 0022h---
 18h	DWORD	(return) task handle of new application
 1Ch	WORD	size of .DVP data
 1Eh 129 BYTEs	ASCIZ ???
 9Fh  N BYTEs	.DVP data (see AX=102Ch)
---function 0023h---
 18h	WORD	(return) ??? or FFFFh on error
 1Ah	WORD	socket's file handle???
---function 0024h---
 18h	WORD	(return) DOS error code (see INT 21/AH=59h)
			0000h if successful
 1Ah 129 BYTEs	ASCIZ filename/pathname
11Bh 129 BYTEs	ASCIZ canonicalized filename/pathname (see INT 21/AH=60h)
---function 0025h---
 18h	WORD	value of AX
 1Ah	WORD	value of BX
 1Ch	WORD	(call) value of CX for call if AH value other than 12h
		(call) number of stack parameters if AH value is 12h
		(return) returned CX for calls other than INT 15/AH=12h
 1Eh	WORD	value of DX
 20h	WORD	value of DI
 22h	WORD	value of SI
 24h	WORD	value of DS
 26h	WORD	value of ES
 28h	WORD	(return) value of FLAGS after call
 2Ah  N DWORDs	(call) stack parameters for INT 15/AH=12h call
		(return) stack results from INT 15/AH=12h call
---function 0026h---
 18h	WORD	(call) Network Manager subfunction (see below)
		(return) status???
 1Ah	WORD	(call) size of parameter data
		(return) size of returned data
 1Ch  N BYTEs	(call) parameter data required by call (see below)
		(return) result data (see below)
---function 0027h---
 18h	WORD	(return) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
---functions 0028h,0029h---
 18h	WORD	(call) file handle for which to set priority low/high
			FFFFh to change calling task's priority
---function 002Ah---
 no additional fields

Values for Network Manager subfunction:
 0004h	"so_exit"???
 0005h	"gethostbyname"
 0006h	"gethostname"
 0009h	"socket"
 000Dh	"gethostbyaddr"
 000Fh	"getprotobyname"
 0010h	get protocol name for protocol number
 0011h	"getservbyname"
 0012h	"getservbyport"
 0013h	"getsockname"???
 0016h	???
 0017h	kill Network Manager
 0018h	"getpeername"???
 0019h	??? (called by socket function 0000h)
 001Ah	???
 001Bh	"so_linkup"
 001Dh	get network services
 001Fh	"getpwuid"
 0020h	"getpwnam"
 0021h	"getpwvar"
 0022h	"crypt"
 0023h	"so_unlink"
 0024h	"getlogin"
 0028h	"sethostent"
 0029h	"gethostent"
 002Ah	"soaddhost"
 002Bh	"soupdatehost"
 002Ch	"sodeletehost"
 002Dh	"setservent"
 002Eh	"getservent"
 002Fh	"setpwent"
 0030h	"getpwent"
 0031h	???
 0032h	???
 0033h	???
 0034h	get IP network number
 0035h	??? (pops up Network Manager window)
 0037h	???
 0038h	get machine name and IP address
 0039h	???

Format of Function 0026h/Subfunction 000Fh data:
Offset	Size	Description
 00h  8 BYTEs	(return) ???

Format of Function 0026h/Subfunction 0010h data:
Offset	Size	Description
 00h  2 BYTEs	(return) ???
 02h	WORD	(return) protocol number
 04h	WORD	(call) protocol number for which to get name
 06h	WORD	(return) ???
 08h	var	(return) ASCIZ protocol name
 N	var	(return) ASCIZ protocol name

Format of Function 0026h/Subfunction 0011h data:
Offset	Size	Description
 00h  8 BYTEs	???
 08h	var	(return) ASCIZ protocol name
	var	(return) ASCIZ ??? name
	var	(return) ASCIZ ??? name

Format of Function 0026h/Subfunction 0012h data:
Offset	Size	Description
 00h  8 BYTEs	(return) ???

Format of Function 0026h/Subfunction 0013h data:
Offset	Size	Description
 00h 116 BYTEs	(return) ???

Format of Function 0026h/Subfunction 0016h data:
Offset	Size	Description
 00h  4 BYTEs	(return) ???

Format of Function 0026h/Subfunction 0018h data:
Offset	Size	Description
 00h 116 BYTEs	(return) ???

Format of Function 0026h/Subfunction 0019h data:
Offset	Size	Description
 00h  4 BYTEs	(return) ???
 04h	DWORD	(return) task handle of ???

Format of Function 0026h/Subfunction 001Ah data:
Offset	Size	Description
 00h 38 BYTEs	(return) ???

Format of Function 0026h/Subfunction 001Bh data:
Offset	Size	Description
 00h 10 BYTEs	(return) ???

Format of Function 0026h/Subfunction 001Dh return data [array]:
Offset	Size	Description
 00h	WORD	??? or FFFFh if end of array
 02h  7 BYTEs	???
 09h 27 BYTEs	ASCIZ name of service

Format of Function 0026h/Subfunction 0024h return data:
Offset	Size	Description
 00h	var	ASCIZ username

Format of Function 0026h/Subfunction 0030h data:
Offset	Size	Description
 00h	WORD	(call) UID or 0000h for current user
		(return) ???
 02h	WORD	(return) UID
 04h  6 BYTEs	(return) ???
 0Ah	var	(return) ASCIZ username
	var	(return) ASCIZ encrypted password
	var	(return) ASCIZ initial ("home") directory

Format of Function 0026h/Subfunction 0034h data:
Offset	Size	Description
 00h  1-3 BYTEs IP network number of caller's machine (low byte first)

Format of Function 0026h/Subfunction 0038h return data:
Offset	Size	Description
 00h	BYTE	???
 01h  4 BYTEs	IP address
 05h	var	ASCIZ machine name
	???

Values for error code:
 0000h	successful
 0009h	"BADF" bad file handle
 000Ch	"ENOMEM" out of memory
 000Eh	"EFAULT" bad address
 0016h	"EINVAL" invalid argument
 0018h	"EMFILE" too many open files
 0020h	"EPIPE" ??? broken pipe
 0023h	"EWOULDBLOCK" operation cannot be completed at this time
 0024h	"EINPROGRESS" operation now in progress
 0026h	"ENOTSOCK" socket invalid
 0028h	"EMSGSIZE" message too long to send atomically
 002Ch	"ESOCKTNOSUPPORT" socket type not supported
 002Fh	"EAFNOSUPPORT" address family not supp. by protocol fam.
 0031h	"EDOM" argument too large
 0038h	"EISCONN" socket is already connected
 0039h	"ENOTCONN" socket is not connected

Format of Socket Context Record:
Offset	Size	Description
 00h	DWORD	pointer to next Socket Context Record, 0000h:0000h if last
 04h	WORD	SFT index for socket, 00FFh if not connected, FFFFh if detached
 06h	WORD	PSP segment of owner or 0000h
 08h	WORD	mapping context of owning window (see AX=1016h)
 0Ah  2 BYTEs	???
 0Ch	WORD	address family
 0Eh	WORD	socket type
 10h	WORD	protocol
 12h	WORD	socket state
		0001h created
		0002h bound
		0003h listening???
		0005h connected
 14h	DWORD	timer object handle
 18h	DWORD	object handle (mailbox???)
 1Ch	DWORD	object handle of parent of above object or 0000h:0000h
 20h	DWORD	pointer to ??? or 0000h
 24h  6 BYTEs	???
 2Ah	WORD	file handle for socket or FFFFh
 2Ch  2 BYTEs	???
 2Eh	WORD	nonzero if socket nonblocking
---network connections only---
 30h  2 BYTEs	???
 32h	WORD	???
 34h  4 BYTEs	(big-endian) IP address of remote
 38h  6 BYTEs	???
--------Q-15DE2F-----------------------------
INT 15 - DESQview v2.50+ - "VIDEONOTIFY" - HAS DIRECT WINDOW BEEN ACTIVE?
	AX = DE2Fh
Return: BX = status
	    0001h keyboard focus has been given to a direct window since the
		last call
	    0000h if not
Notes:	DESQview 2.50-2.53 are distributed as part of DESQview/X v1.00-1.10.
	Quarterdeck stated that this call would not be available under future
	  versions of DESQview Classic, but it is still present in v2.60
--------Q-15DE30-----------------------------
INT 15 - DESQview v2.50+ - "GETDVXVERSION" - GET DESQview/X VERSION
	AX = DE30h
Return: BX = version (BH=major, BL=minor) or 0000h if not DESQview/X
Notes:	DESQview 2.50-2.53 are distributed as part of DESQview/X v1.00-1.10.
	you must first check the DESQview version to verify that it is 2.50 or
	  greater
SeeAlso: INT 21/AH=2Bh/CX=4445h
--------Q-15DE31-----------------------------
INT 15 - DESQview/X v1.10 - ???
	AX = DE31h
	CX = ???
	    0000h ???
	    nonzero ???
	???
Return: ???
--------b-15DF-------------------------------
INT 15 - Juko UNIQUE UX BIOS - TURBO MODE CONTROL
	AH = DFh
	AL = function
	    00h turn on Turbo mode
	    01h turn off Turbo mode
	    02h set Turbo mode according to hardware switch
SeeAlso: INT 13/AX=FFFFh
--------b-15E00F-----------------------------
INT 15 - Compaq Systempro - MULTIPROCESSOR DISPATCH
	AX = E00Fh
	ES:BX -> start of 2nd processor's execution
Return: AL = status
	    0Fh successful
	    00h failure
SeeAlso: AX=E10Eh,AX=E200h
--------b-15E10E-----------------------------
INT 15 - Compaq Systempro - MULTIPROCESSOR END-OF-DISPATCH
	AX = E10Eh
	ES:BX -> start of 2nd processor's execution
Return: AL = status
	    0Fh successful (halted)
	    00h failure (not halted)
SeeAlso: AX=E00Fh,AX=E200h
--------b-15E200-----------------------------
INT 15 - Compaq Systempro - MULTIPROCESSOR AVAILABLE
	AX = E200h
Return: AX bit 15 set if 2nd processor available
SeeAlso: AX=E00Fh,AX=E10Eh
--------b-15E4-------------------------------
INT 15 - Tandy??? - ???
	AH = E4h
	AL = subfunction
	    21h, 89h, 8Ah, 8Bh called by 386MAX v6.01
	DL = ???
Return: DL = 00h if successful???
Note:	the section of code in 386MAX which calls these functions also checks
	  whether the ROM BIOS has both Tandy and Phoenix Technologies
	  signatures if these calls fail; the Tandy 1000SL/TL BIOS does not
	  support this function, however, returning the usual CF set/AH=86h for
	  "unsupported function".
--------b-15E4-------------------------------
INT 15 - Compaq ROM BIOS 03/08/93 and newer - ???
	AH = E4h
	AL = subfunction
	    00h get ???
		Return: CF clear
			AH = 00h
			CX = 0000h
			BX = ??? (read from [XBDA:0094h])
	    01h,02h unsupported by this ROM version
		Return: CF set, AH = 86h
	    80h,90h,A0h,B0h,C0h,D0h,E0h,F0h set ???
		Return: CF clear
			AH = 00h
			CX = 0000h
			BX = ???
	    81h,91h,A1h,B1h,C1h,D1h,E1h,F1h unsupported by 3/8/93&4/8/93 ROMs
		Return: CF set, AH = 86h
Notes:	functions 80h/90h/etc. are not supported by the 4/8/93 EISA System ROM
	these functions are not supported by the 7/26/93 LTE Lite 386 ROM
--------b-15E800-----------------------------
INT 15 - Compaq Contura - GET ???
	AX = E800h
Return: AX = 0000h
	BH = 00h
	BL = ??? (read from port 0C7Ch)
	CH = ???
	CL = ???
	DX = 0000h
Note:	also supported by 3/8/93 DESKPRO/i and 7/26/93 LTE Lite 386 ROM BIOS
--------b-15E801-----------------------------
INT 15 - Compaq Contura - GET ???
	AX = E801h
Return: CF clear
	AX = extended memory in K (read from CMOS locations 30h and 31h)
	BH = ???
	BL = ???
	CX = extended memory in K (read from CMOS locations 17h and 18h)
	DX = ???
Note:	also supported by 3/8/93 DESKPRO/i and 7/26/93 LTE Lite 386 ROM BIOS
--------b-15E802-----------------------------
INT 15 - Compaq Contura - GET ???
	AX = E802h
Return: CF clear
	AX = 0000h
	BX = ???
	CX = 0000h
Note:	this function is also supported by the LTE Lite 25c, 25E, and 486; not
	  supported by LTE Lite 20 and 25.
--------m-15F200CX454D-----------------------
INT 15 - Tandon memory mapper - Tandon MAPPER HARDWARE INITIALISATION CHECK ???
	AX = F200h
	CX = 454Dh
Return: CF clear if hardware already initialised
	    BX = upper RAM areas in use
		bit 0: C000-C3FF
		bit 1: C400-C7FF
		...
		bit 11: EC00-EFFF
	CF set if hardware not initialised yet
--------!------------------------------------
