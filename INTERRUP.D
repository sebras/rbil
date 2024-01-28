Interrupt List, part 4 of 13
This compilation is Copyright (c) 1989,1990,1991,1992,1993,1994,1995 Ralf Brown
--------B-1A00-------------------------------
INT 1A - TIME - GET SYSTEM TIME
	AH = 00h
Return: CX:DX = number of clock ticks since midnight
	AL = midnight flag, nonzero if midnight passed since time last read
Notes:	there are approximately 18.2 clock ticks per second, 1800B0h per 24 hrs
	IBM and many clone BIOSes set the flag for AL rather than incrementing
	  it, leading to loss of a day if two consecutive midnights pass
	  without a request for the time (e.g. if the system is on but idle)
	since the midnight flag is cleared, if an application calls this
	  function after midnight before DOS does, DOS will not receive the
	  midnight flag and will fail to advance the date
SeeAlso: AH=01h,AH=02h,INT 21/AH=2Ch,INT 62/AX=0099h,MEM 0040h:006Ch
--------B-1A01-------------------------------
INT 1A - TIME - SET SYSTEM TIME
	AH = 01h
	CX:DX = number of clock ticks since midnight
SeeAlso: AH=00h,AH=03h,INT 21/AH=2Dh
--------B-1A02-------------------------------
INT 1A - TIME - GET REAL-TIME CLOCK TIME (AT,XT286,PS)
	AH = 02h
Return: CF clear if successful
	    CH = hour (BCD)
	    CL = minutes (BCD)
	    DH = seconds (BCD)
	    DL = daylight savings flag (00h standard time, 01h daylight time)
	CF set on error (i.e. clock not running or in middle of update)
Note:	this function is also supported by the Sperry PC, which predates the
	  IBM AT; the data is returned in binary rather than BCD on the Sperry,
	  and DL is always 00h
SeeAlso: AH=00h,AH=03h,AH=04h,INT 21/AH=2Ch
--------B-1A03-------------------------------
INT 1A - TIME - SET REAL-TIME CLOCK TIME (AT,XT286,PS)
	AH = 03h
	CH = hour (BCD)
	CL = minutes (BCD)
	DH = seconds (BCD)
	DL = daylight savings flag (00h standard time, 01h daylight time)
Note:	this function is also supported by the Sperry PC, which predates the
	  IBM AT; the data is specified in binary rather than BCD on the
	  Sperry, and the value of DL is ignored
SeeAlso: AH=01h,AH=03h,AH=05h,INT 21/AH=2Dh
--------B-1A04-------------------------------
INT 1A - TIME - GET REAL-TIME CLOCK DATE (AT,XT286,PS)
	AH = 04h
Return: CF clear if successful
	    CH = century (BCD)
	    CL = year (BCD)
	    DH = month (BCD)
	    DL = day (BCD)
	CF set on error
SeeAlso: AH=02h,AH=04h"Sperry",AH=05h,INT 21/AH=2Ah
--------b-1A04-------------------------------
INT 1A - Sperry PC - GET REAL-TIME CLOCK DATE
	AH = 04h
Return: CF clear if successful
	    CL = year-1980
	    DH = month (binary)
	    DL = day (binary)
	CF set on error
SeeAlso: AH=02h,AH=04h,AH=05h"Sperry",INT 21/AH=2Ah
--------B-1A05-------------------------------
INT 1A - TIME - SET REAL-TIME CLOCK DATE (AT,XT286,PS)
	AH = 05h
	CH = century (BCD)
	CL = year (BCD)
	DH = month (BCD)
	DL = day (BCD)
SeeAlso: AH=04h,INT 21/AH=2Bh
--------b-1A04-------------------------------
INT 1A - Sperry PC - SET REAL-TIME CLOCK DATE
	AH = 04h
	CL = year-1980
	DH = month (binary)
	DL = day (binary)
SeeAlso: AH=02h,AH=04h"Sperry",AH=05h,INT 21/AH=2Bh
--------B-1A06-------------------------------
INT 1A - TIME - SET ALARM (AT,XT286,PS)
	AH = 06h
	CH = hour (BCD)
	CL = minutes (BCD)
	DH = seconds (BCD)
Return: CF set on error (alarm already set or clock stopped for update)
	CF clear if successful
Notes:	the alarm occurs every 24 hours until turned off, invoking INT 4A each
	  time
	the BIOS does not check for invalid values for the time, so the CMOS
	  clock chip's "don't care" setting (any values between C0h and FFh)
	  may be used for any or all three part.  For example, to create an
	  alarm once a minute, every minute, call with CH=C0h, CL=C0h, and
	  DH=00h.
SeeAlso: AH=07h,INT 4A
--------B-1A07-------------------------------
INT 1A - TIME - CANCEL ALARM (AT,XT286,PS)
	AH = 07h
Return: alarm disabled
Note:	does not disable the real-time clock's IRQ
SeeAlso: AH=06h,INT 70
--------B-1A08-------------------------------
INT 1A - TIME - SET RTC ACTIVATED POWER ON MODE (CONVERTIBLE)
	AH = 08h
	CH = hours in BCD
	CL = minutes in BCD
	DH = seconds in BCD
SeeAlso: AH=09h
--------B-1A09-------------------------------
INT 1A - TIME - READ RTC ALARM TIME AND STATUS (CONV,PS30)
	AH = 09h
Return: CH = hours in BCD
	CL = minutes in BCD
	DH = seconds in BCD
	DL = alarm status
	    00h alarm not enabled
	    01h alarm enabled but will not power up system
	    02h alarm will power up system
SeeAlso: AH=08h
--------B-1A0A-------------------------------
INT 1A - TIME - READ SYSTEM-TIMER DAY COUNTER (XT2,PS)
	AH = 0Ah
Return: CF set on error
	CF clear if successful
	    CX = count of days since Jan 1,1980
SeeAlso: AH=04h,AH=0Bh
--------B-1A0B-------------------------------
INT 1A - TIME - SET SYSTEM-TIMER DAY COUNTER (XT2,PS)
	AH = 0Bh
	CX = count of days since Jan 1,1980
Return: CF set on error
	CF clear if successful
SeeAlso: AH=05h,AH=0Ah
--------J-1A10-------------------------------
INT 1A - NEC PC-9800 series - PRINTER - INITIALIZE
	AH = 10h
	???
Return: ???
SeeAlso: AH=11h,AH=12h,INT 17/AH=01h
--------J-1A11-------------------------------
INT 1A - NEC PC-9800 series - PRINTER - OUTPUT CHARACTER
	AH = 11h
	???
Return: ???
SeeAlso: AH=10h,AH=12h,INT 17/AH=00h
--------J-1A12-------------------------------
INT 1A - NEC PC-9800 series - PRINTER - SENSE STATUS
	AH = 12h
	???
Return: ???
SeeAlso: AH=10h,AH=11h,INT 17/AH=02h
--------A-1A3601-----------------------------
INT 1A - WORD PERFECT v5.0 Third Party Interface - INSTALLATION CHECK
	AX = 3601h
Return: DS:SI = routine to monitor keyboard input, immediately preceded by the
		ASCIZ string "WPCORP\0"
Notes:	WordPerfect 5.0 will call this interrupt at start up to determine if a
	  third party product wants to interface with it.  The third party
	  product must intercept this interrupt and return the address of a
	  keyboard monitor routine.
	Before checking for keyboard input, and after every key entered by the
	  user, Word Perfect will call the routine whose address was provided
	  in DS:SI with the following parameters:
		Entry:	AX = key code or 0
			BX = WordPerfect state flag
		Exit:	AX = 0 or key code
			BX = 0 or segment address of buffer with key codes
	See the "WordPerfect 5.0 Developer's Toolkit" for further information.
SeeAlso: INT 16/AX=5500h
--------N-1A6108-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SENDWITHREPLY" - SEND MSG AND GET REPLY
	AX = 6108h
	STACK:	WORD	conversation ID (0000h-0009h)
		DWORD	pointer to message buffer
		WORD	length of message
		DWORD	pointer to reply buffer
		WORD	length of reply buffer
		WORD	0000h (use default "Cparams" structure)
Return: AX = status (see #0505)
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=6205h

(Table 0505)
Values for SNAP.EXE status:
 0000h	successful
 F830h	"SNAP_ABORTED"
 FC04h	"SNAP_SERVERDIED"
 FC05h	"SNAP_RESEND"
 FC06h	"SNAP_SELECTFAILED"
 FC07h	"SNAP_WRONGVERSION"
 FC08h	"SNAP_INVALIDACK"
 FC09h	"SNAP_TIMEOUT"
 FC0Ah	"SNAP_SERVERREJECT"
 FC0Bh	"SNAP_NOREPLYDUE"
 FC0Ch	"SNAP_NOAUTHENTICATE"/"SNAP_GUARDIAN_ERROR"
 FC0Dh	"SNAP_NOINIT"
 FC0Eh	"SNAP_SOCKETERROR"
 FC0Fh	"SNAP_BUFFERLIMIT"
 FC10h	"SNAP_INVALIDCID"
 FC11h	"SNAP_INVALIDOP"
 FC12h	"SNAP_XMITFAIL"
 FC13h	"SNAP_NOMORERETRIES"
 FC14h	"SNAP_BADPARMS"
 FC15h	"SNAP_NOMEMORY"
 FC16h	"SNAP_NOMORECONVS"
 FFFFh	failed (invalid function/parameter)
--------N-1A6205-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SENDNOREPLY" - SEND MSG, DON'T AWAIT REPLY
	AX = 6205h
	STACK:	WORD	conversation ID (0000h-0009h)
		DWORD	pointer to message
		WORD	length of message
		WORD	0000h (use default "Cparms" structure)
Return: AX = status (see #0505)
	STACK unchanged
SeeAlso: AX=6108h
--------N-1A6308-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_BEGINCONV" - BEGIN CONVERSATION
	AX = 6308h
	STACK:	WORD	offset of ASCIZ "guardian"
		WORD	offset of ASCIZ hostname
		WORD	offset of ASCIZ server name
		WORD	offset of ASCIZ userid
		WORD	offset of ASCIZ password
		WORD	offset of password length
		WORD	offset of password type
		WORD	offset of "Cparms" structure (see #0506)
Return: ???
	STACK unchanged
Note:	all stacked offsets are within the SNAP data segment (use AX=6A01h
	  to allocate a buffer)
SeeAlso: AX=6405h,AX=7202h

Format of SNAP.EXE Cparms structure:
Offset	Size	Description	(Table 0506)
 00h	WORD	retry delay in seconds
 02h	WORD	timeout delay in seconds
 04h	WORD	maximum buffer size
 06h	WORD	encryption level
--------N-1A6405-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_ENDCONV" - END CONVERSATION
	AX = 6405h
	STACK:	WORD	conversation ID (0000h-0009h)
		DWORD	pointer to message buffer
		WORD	length of message
		WORD	0000h (use default "Cparms" structure)
Return: AX = status (see #0505)
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=6308h
--------N-1A6900-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_DATASEG" - GET RESIDENT DATA SEGMENT
	AX = 6900h
Return: AX = value used for DS by resident code
SeeAlso: AX=6A01h,AX=6F01h
--------N-1A6A01-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_ALLOC" - ALLOCATE BUFFER IN SNAP DATA SEGMENT
	AX = 6A01h
	STACK:	WORD	number of bytes to allocate
Return: AX = offset of allocated buffer or 0000h if out of memory
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=6B01h
--------N-1A6B01-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_FREE" - DEALLOCATE BUFFER IN SNAP DATA SEGMENT
	AX = 6B01h
	STACK:	WORD	offset within SNAP data segment of previously allocated
			buffer
Return: STACK unchanged
Note:	this call is a NOP if the specified offset is 0000h
SeeAlso: AX=6A01h
--------N-1A6C04-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_COPYTO" - COPY DATA TO RESIDENT SNAP PACKAGE
	AX = 6C04h
	STACK:	WORD	offset within SNAP data segment of dest (nonzero)
		WORD	segment of source buffer
		WORD	offset of source buffer
		WORD	number of bytes to copy
Return: AX = offset of byte after last one copied to destination
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=6D04h
--------N-1A6D04-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_COPYFROM" - COPY DATA FROM RESIDENT SNAP PACKAGE
	AX = 6D04h
	STACK:	WORD	offset within SNAP data segment of source buffer
		WORD	segment of destination buffer
		WORD	offset of destination buffer
		WORD	number of bytes to copy
Return: AX = offset of byte after last one copied from source
	buffer filled
	STACK unchanged
SeeAlso: AX=6C04h
--------N-1A6E01-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SETDEBUG" - SET ???
	AX = 6E01h
	STACK:	WORD	new value for ???
Return: AX = old value of ???
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
--------N-1A6F01-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_CHKINSTALL" - INSTALLATION CHECK
	AX = 6F01h
	STACK: WORD 0000h
Return: AX = status
	    0000h SNAP is resident
	    other SNAP not present
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol, and is
	  required by PCVENUS (a network shell).  The combination of SNAP and
	  PCVENUS allows the use of the Andrew File System as one or more
	  networked drives.
SeeAlso: AX=6900h,AX=7400h
--------N-1A7002-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SETANCHOR"
	AX = 7002h
	STACK:	WORD	anchor number (0000h-0009h)
		WORD	new value for the anchor
Return: AX = status
	    0000h successful
	    FFFFh failed (top word on stack not in range 00h-09h)
	STACK unchanged
SeeAlso: AX=7101h
--------N-1A7101-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_GETANCHOR"
	AX = 7101h
	STACK:	WORD	anchor number (0000h-0009h)
Return: AX = anchor's value
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=7002h
--------N-1A7202-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SETCONVPARMS" - SET CONVERSATION PARAMETERS
	AX = 7202h
	STACK:	WORD	conversation ID (0000h-0009h)
		WORD	offset within resident data segment of "Cparms"
			  structure (see #0506)
Return: AX = status???
	STACK unchanged
SeeAlso: AX=6308h
--------N-1A7302-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_CLIENTVERSION" - ???
	AX = 7302h
	STACK:	WORD	conversation ID (0000h-0009h)
		WORD	offset within resident data segment of ???
Return: AX = ???
	???
	STACK unchanged
SeeAlso: AX=7400h
--------N-1A7400-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_VERSION" - GET VERSION
	AX = 7400h
Return: AX = version (AH=major, AL=minor)
Note:	this call is only valid if SNAP is installed
SeeAlso: AX=7302h,INT 1A/AX=6F01h
--------N-1A75-------------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_NOP" - ???
	AH = 75h
	AL = ???
Return: AX = ??? (0000h)
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
--------N-1A76-------------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_802_5" - ???
	AH = 76h
	AL = ???
Return: AX = ???
--------N-1A77-------------------------------
INT 1A - SNAP.EXE 3.4 - ???
	AH = 77h
	AL = ??? (at least 01h)
	STACK:	WORD	???
		???
Return: ???
	STACK unchanged
--------N-1A7802-----------------------------
INT 1A - SNAP.EXE 3.4 - ???
	AX = 7802h
	STACK:	WORD	???
		WORD	???
Return: ???
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
--------s-1A7F-------------------------------
INT 1A - Tandy 2500, Tandy 1000L series - DIGITAL SOUND???
	AH = 7Fh
	???
Return: ???
Note:	this function is not supported by the Tandy 1000SL/TL BIOS
SeeAlso: AH=80h,AH=83h,AH=85h
--------s-1A80-------------------------------
INT 1A - PCjr, Tandy 2500???, Tandy 1000SL/TL - SET UP SOUND MULTIPLEXOR
	AH = 80h
	AL = 00h source is 8253 channel 2
	     01h source is cassette input
	     02h source is I/O channel "Audio IN"
	     03h source is sound generator chip
Note:	although documented in the 1000TL Technical Reference, the 1000TL
	  BIOS has just an IRET for this call
SeeAlso: AH=7Fh,AH=83h
--------X-1A80-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET NUMBER OF ADAPTERS
	AH = 80h
Return: CF clear if successful
	    CX = 5353h ('SS') if Socket Services installed
		AL = number of adapters present (0-16)
	    AH destroyed
	CF set on error
	    AH = error code (see #0507)
SeeAlso: AH=83h"PCMCIA"

(Table 0507)
Values for PCMCIA error codes:
 01h	"BAD_ADAPTER" nonexistent adapter
 02h	"BAD_ATTRIBUTE" invalid attribute specified
 03h	"BAD_BASE" invalid system memory base address
 04h	"BAD_EDC" invalid EDC generator specified
 05h	"BAD_INDICATOR" invalid indicator specified
 06h	"BAD_IRQ" invalid IRQ channel specified
 07h	"BAD_OFFSET" invalid PCMCIA card offset specified
 08h	"BAD_PAGE" invalid page specified
 09h	"BAD_READ" unable to complete request
 0Ah	"BAD_SIZE" invalid window size specified
 0Bh	"BAD_SOCKET" nonexistent socket specified
 0Ch	"BAD_TECHNOLOGY" unsupported Card Technology for writes
 0Dh	"BAD_TYPE" unavailable window type specified
 0Eh	"BAD_VCC" invalid Vcc power level index specified
 0Fh	"BAD_VPP" invalid Vpp1 or Vpp2 power level index specified
 10h	"BAD_WAIT" invalid number of wait states specified
 11h	"BAD_WINDOW" nonexistent window specified
 12h	"BAD_WRITE" unable to complete request
 13h	"NO_ADAPTERS" no adapters installed, but Socket Services is present
 14h	"NO_CARD" no card in socket
 15h	function not supported
 16h	invalid mode
 17h	invalid speed
 18h	busy
--------X-1A81-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - REGISTER STATUS CHANGE CALLBACK
	AH = 81h
	DS:DX -> callback routine (see #0508) or 0000h:0000h to disable
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (see #0507)
Note:	the callback will be invoked on any socket changes whose notification
	  has not been disabled with the status change enable mask; it may be
	  invoked either while processing a hardware interrupt from the adapter
	  or while processing the following Socket Services request
SeeAlso: AH=80h"PCMCIA",AH=82h"PCMCIA"

(Table 0508)
Values PCMCIA callback routine is invoked with:
	AL = adapter number
	BH = status change interrupt enable mask (see #0509)
	BL = socket number
	DH = current socket status (see #0510)
	DL = current card status (see #0511)
Return: all registers preserved
Notes:	the callback may be invoked during a hardware interrupt, and may not
	  call on Socket Services
	the callback will be invoked once for each socket with a status change

Bitfields for PCMCIA status change interrupt enable mask:
Bit(s)	Description	(Table 0509)
 7	card detect change
 6	ready change
 5	battery warning change
 4	battery dead change
 3	insertion request
 2	ejection request
 1-0	reserved (0)

Bitfields for PCMCIA current socket status:
Bit(s)	Description	(Table 0510)
 7	card changed
 6	reserved (0)
 5	card insertion complete
 4	card ejection complete
 3	card insertion request pending
 2	card ejection request pending
 1	card locked
 0	reserved (0)

Bitfields for PCMCIA current card status:
Bit(s)	Description	(Table 0511)
 7	card detect
 6	ready
 5	battery voltage detect 2 (battery warning)
 4	battery voltage detect 1 (battery dead)
 3-1	reserved (0)
 0	write protected
--------s-1A8100-----------------------------
INT 1A - Tandy 2500, Tandy 1000L series - DIGITAL SOUND - INSTALLATION CHECK
	AX = 8100h
Return: AL > 80h if supported
	AX = 00C4h if supported (1000SL/TL)
	    CF set if sound chip is busy
	    CF clear  if sound chip is free
Note:	the value of CF is not definitive; call this function until CF is
	  clear on return, then call AH=84h"Tandy"
--------s-1A82-------------------------------
INT 1A - Tandy 2500???, Tandy 1000SL/TL - DIGITAL SOUND - RECORD SOUND
	AH = 82h
	ES:BX -> buffer for sound samples
	CX = length of buffer
	DX = transfer rate (1-4095, 1 is fastest)
Return: AH = 00h
	CF set if sound busy
	CF clear if sound chip free
Note:	the value in DX should be 1/10 the corresponding value for
	  INT 1A/AH=83h on the 1000TL, 1/11.5 on the 1000SL.  Call
	  INT 1A/AX=8100h and INT 1A/AH=84h before invoking this function.
	The BIOS issues an INT 15/AX=91FBh when the input is complete
	DMA across a 64K boundary is masked by the BIOS
--------X-1A82-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - REGISTER CARD TECHNOLOGY CALLBACK
	AH = 82h
	DS:DX -> callback routine (see #0512) or 0000h:0000h
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (see #0507)
Note:	the callback is invoked on a Write Multiple request with an unsupported
	  card technology type
SeeAlso: AH=81h"PCMCIA",AH=94h

(Table 0512)
Values PCMCIA callback routine is invoked with:
	ES:AX -> Low-Level Socket Services Routines (see #0514)
	BH = socket attributes (see #0513)
	CX = number of bytes or words to write
	DS:SI -> data buffer to be written
	DX:DI -> 26-bit linear card address
	BP = card technology type
Return: CF clear if successful
	CF set on error
	    AH = error code (07h,0Ch,12h,14h) (see #0507)

Bitfields for PCMCIA socket attributes:
Bit(s)	Description	(Table 0513)
 7-4	reserved (0)
 3	packed buffer
 2	even bytes only (only valid if 1 set)
 1	data width (clear = byte, set = word)
 0	memory type (clear = common, set = attribute)

Format of PCMCIA Low-Level Socket Services Routines:
Offset	Size	Description	(Table 0514)
 00h	WORD	offset of Write Many routine (see #0515)
 02h	WORD	offset of Write One routine (see #0516)
 04h	WORD	offset of Read One routine (see #0517)
 06h	WORD	offset of Increment Offset routine (see #0518)
 08h	WORD	offset of Set Offset routine (see #0519)
 0Ah	WORD	offset of Get Status routine (see #0520)

(Table 0515)
Call Write Many routine with:
	BH = socket attributes (see #0513)
	CX = number of bytes or words to write
	DS:SI -> data to be written
Return: CF clear if successful
	CF set on error

(Table 0516)
Call Write One routine with:
	AL/AX = data to be written
	BH = socket attributes (see #0513)
Return: CF clear if successful
	CF set on error

(Table 0517)
Call Read One routine with:
	BH = socket attributes (see #0513)
Return: CF clear if successful
	    AL/AX = data read
	CF set on error

(Table 0518)
Call Increment Offset routine with:
	BH = socket attributes (see #0513)
Return: CF clear if successful
	CF set on error

(Table 0519)
Call Set Offset routine with:
	DX:DI = new offset address
Return: CF clear if successful
	CF set on error

(Table 0520)
Call Get Status routine with:
	nothing
Return: AL = current card status (see #0511)
--------s-1A83-------------------------------
INT 1A - Tandy 2500, Tandy 1000L series - START PLAYING DIGITAL SOUND
	AH = 83h
	AL = volume (0=silence, 7=highest)
	CX = number of bytes to play
	DX = time between sound samples (multiples of 273 nanoseconds)
	    only bits 11-0 used
	ES:BX -> sound data (array of 8-bit unsigned PCM samples)
Return: AH = 00h
	CF set if sound is busy
	CF clear if sound chip is free
Notes:	this call returns immediately while the sound plays in the
	  background; the sound chip is clocked at 3.57 MHz, with the low 12
	  bits of DX specifying the clock divisor
	The BIOS appears to call INT 15/AX=91FBh when the sound device
	  underflows to allow another INT 1A/AH=83h for seamless playing of
	  long sounds.
SeeAlso: AH=84h"Tandy",INT 15/AH=91h
--------X-1A83-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET SOCKET SERVICES VERSION NUMBER
	AH = 83h
	AL = adapter number
Return: CF clear if successful
	    AX = Socket Services version (BCD)
	    BX = implementation version (BCD)
	    CX = 5353h ("SS")
	    DS:SI -> ASCIZ implementor description
	CF set on error
	    AH = error code (01h) (see #0507)
Note:	the current version (from the Revision A.00 documentation) of Socket
	  Services is 1.00 (AX=0100h)
SeeAlso: AH=80h"PCMCIA"
--------s-1A84-------------------------------
INT 1A - Tandy 2500, Tandy 1000L series - STOP PLAYING DIGITAL SOUND
	AH = 84h
Return: ???
Note:	the BIOS will call INT 15/AX=91FBh when the sound has stopped playing
SeeAlso: AH=83h"Tandy",AH=85h"Tandy"
--------X-1A84-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - INQUIRE ADAPTER
	AH = 84h
	AL = adapter number
Return: CF clear if successful
	    AH destroyed
	    BH = number of windows
	    BL = number of sockets (1-16)
	    CX = number of EDCs
	    DH = capabilities (see #0521)
	    DL = status change interrupt used (only if DH bit 3 set)(see #0522)
	CF set on error
	    AH = error code (01h) (see #0507)
SeeAlso: AH=80h"PCMCIA",AH=85h"PCMCIA",AH=87h

Bitfields for PCMCIA capabilities:
Bit(s)	Description	(Table 0521)
 7-6	reserved (0)
 5	status change interrupt is hardware shareable
 4	status change interrupt is software shareable
 3	status change interrupt
 2	data bus width is per-socket rather than per-window
 1	power management is per-adapter rather than per-socket
 0	indicators are per-adapter rather than per-socket

(Table 0522)
Values for PCMCIA status change interrupt usage:
 00h-0Fh IRQ level
 10h	NMI
 11h	I/O check
 12h	bus error
 13h	vendor specific
 14h-FFh reserved
--------s-1A85-------------------------------
INT 1A - Tandy 2500, Tandy 1000L series - DIGITAL SOUND???
	AH = 85h
	???
Return: ???
Note:	this function is not supported by the Tandy 1000SL/TL BIOS
SeeAlso: AH=7Fh,AH=83h"Tandy"
--------X-1A85-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET ADAPTER
	AH = 85h
	AL = adapter number
Return: CF clear if successful
	    AH destroyed
	    DH = adapter attributes (see #0523)
	CF set on error
	    AH = error code (01h) (see #0507)
SeeAlso: AH=84h"PCMCIA",AH=86h

Bitfields for PCMCIA adapter attributes:
Bit(s)	Description	(Table 0523)
 7-5	reserved (0)
 4	hardware share status change
 3	software share status change
 2	enable status change interrupts
 1	adapter preserves state information during reduced power consumption
 0	attempting to reduce power consumption
--------X-1A86-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET ADAPTER
	AH = 86h
	AL = adapter number
	DH = new adapter attributes (see #0523)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h) (see #0507)
SeeAlso: AH=84h"PCMCIA",AH=85h"PCMCIA"
--------X-1A87-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - INQUIRE WINDOW
	AH = 87h
	AL = adapter number
	BH = window number
Return: CF clear if successful
	    AH destroyed
	    BL = capabilities (see #0524)
	    CX = bitmap of assignable sockets
	    DH = EISA A15-A12 address lines (in bits 7-4, bits 3-0 = 0)
	    DL = supported access speeds (see #0525)
	    DS:SI -> Memory Window Characteristics table (see #0526)
	    DS:DI -> I/O Window Characteristics table (see #0527)
	CF set on error
	    AH = error code (01h,11h) (see #0507)
SeeAlso: AH=84h"PCMCIA",AH=88h,AH=89h,AH=8Ch

Bitfields for PCMCIA window capabilities:
Bit(s)	Description	(Table 0524)
 7-5	reserved (0)
 4	separate enable for EISA comon space
 3	EISA I/O mappable
 2	I/O space
 1	attribute memory
 0	common memory

Bitfields for PCMCIA supported access speeds:
Bit(s)	Description	(Table 0525)
 7	reserved (0)
 6	600 ns
 5	300 ns
 4	250 ns
 3	200 ns
 2	150 ns
 1	100 ns
 0	WAIT line monitoring

Format of PCMCIA Memory Window Characteristics table:
Offset	Size	Description	(Table 0526)
 00h	WORD	window capabilities (see #0528)
 02h	WORD	minimum base address in 4K pages
 04h	WORD	maximum base address in 4K pages
 06h	WORD	minimum window size in 4K pages
 08h	WORD	maximum window size in 4K pages
 0Ah	WORD	window size granularity (4K units)
 0Ch	WORD	required base address alignment (4K units)
 0Eh	WORD	required card offset alignment (4K units)

Format of PCMCIA I/O Window Characteristics table:
Offset	Size	Description	(Table 0527)
 00h	WORD	window capabilities (see #0528)
 02h	WORD	minimum base address in bytes
 04h	WORD	maximum base address in bytes
 06h	WORD	minimum window size in bytes
 08h	WORD	maximum window size in bytes
 0Ah	WORD	window size granularity (bytes)

Bitfields for PCMCIA window capabilities:
Bit(s)	Description	(Table 0528)
 0	programmable base address
 1	programmable window size
 2	window disable/enable supported
 3	8-data bus
 4	16-data bus
 5	base address alignment on size boundary required
 6	power-of-two size granularity
---memory windows---
 7	card offset must be aligned on size boundary
 8	paging hardware available
 9	paging hardware shared
 10	page disable/enable supported
 11-15	reserved (0)
---I/O windows---
 7-15	reserved (0)
--------X-1A88-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET WINDOW
	AH = 88h
	AL = adapter number
	BH = window number
Return: CF clear if successful
	    AH destroyed
	    BL = socket number (0-16) (0 = not assigned)
	    CX = window size (bytes for I/O window, 4K units for memory window)
	    DH = window attributes (see #0529)
	    DL = access speed (only one bit set) (see #0525)
	    SI = window base address (bytes if I/O, 4K units if memory)
	    DI = card offset address (memory only, 4K units)
	CF set on error
	    AH = error code (01h,11h) (see #0507)
SeeAlso: AH=87h,AH=89h,AH=8Ah

Bitfields for PCMCIA window attributes:
Bit(s)	Description	(Table 0529)
 0	memory-mapped rather than I/O-mapped
 1	attribute memory rather than common (memory-mapped)
	EISA mapped (I/O)
 2	enabled
 3	16-data path
 4	subdivided into pages (memory-mapped only)
 5	non-specific access slot enable (EISA-mapped only)
 6-7	reserved (0)
--------X-1A89-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET WINDOW
	AH = 89h
	AL = adapter number
	BH = window number
	BL = socket number
	CX = window size (bytes if I/O window, 4K units if memory window)
	DH = window attributes (see #0529)
	DL = access speed (only one bit set) (see #0525)
	SI = window base address (bytes if I/O, 4K units if memory window)
	DI = card offset addrress (memory only, 4K units)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,03h,07h,08h,0Ah,0Bh,0Dh,10h,11h) (see #0507)
SeeAlso: AH=87h,AH=88h,AH=8Bh
--------X-1A8A-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET PAGE
	AH = 8Ah
	AL = adapter number
	BH = window number
	BL = page number
Return: CF clear if successful
	    AH destroyed
	    DX = page attributes (see #0530)
	    DI = memory card offset (4K units)
	CF set on error
	    AH = error code (01h,08h,11h) (see #0507)
Notes:	this function is only valid for memory-mapped windows
	the socket being operated on is implied by the previous AH=89h call
SeeAlso: AH=88h,AH=8Bh

Bitfields for PCMCIA page attributes:
Bit(s)	Description	(Table 0530)
 0	page enabled
 15-1	reserved (0)
--------X-1A8B-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET PAGE
	AH = 8Bh
	AL = adapter number
	BH = window number
	BL = page number
	DX = page attributes (see #0530)
	DI = memory card offset (4K units)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,02h,07h,08h,11h) (see #0507)
Notes:	this function is only valid for memory-mapped windows
	the socket being operated on is implied by the previous AH=89h call
SeeAlso: AH=89h,AH=8Ah
--------X-1A8C-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - INQUIRE SOCKET
	AH = 8Ch
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
Return: CF clear if successful
	    AH destroyed
	    DH = capabilities (see #0531)
	    DL = hardware indicators (see #0532)
	    DS:SI -> Socket Characteristics table (see #0533)
	    DS:DI -> Power Management table (see #0535)
	CF set on error
	    AH = error code (01h,0Bh) (see #0507)
SeeAlso: AH=87h,AH=8Dh,AH=8Eh

Bitfields for PCMCIA socket capabilities:
Bit(s)	Description	(Table 0531)
 0	card change
 1	card lock
 2	insert card (motor control)
 3	eject card (motor control)
 4-7	reserved (0)

Bitfields for PCMCIA socket hardware indicators:
Bit(s)	Description	(Table 0532)
 0	busy status
 1	write-protected
 2	battery status
 3	card lock status
 4	XIP status (eXecute-In-Place)
 5-7	reserved (0)

Format of PCMCIA Socket Characteristics table:
Offset	Size	Description	(Table 0533)
 00h	WORD	supported card types (see #0534)
 02h	WORD	steerable IRQ levels (bit 0 = IRQ0 to bit 15 = IRQ15)
 04h	WORD	additional steerable IRQ levels
		bit 0: NMI
		bit 1: I/O check
		bit 2: bus error
		bit 3: vendor-unique
		bits 4-7 reserved (0)

Bitfields for supported card types:
Bit(s)	Description	(Table 0534)
 0	memory card
 1	I/O card
 2-7	reserved (0)

Format of PCMCIA Power Management table:
Offset	Size	Description	(Table 0535)
 00h	WORD	number of entries in table (0 if power management not avail)
 02h 2N BYTEs	power levels
		byte 0: voltage in 0.1V units
		byte 1: power supply
			bit 7: Vcc
			bit 6: Vpp1
			bit 5: Vpp2
--------X-1A8D-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET SOCKET
	AH = 8Dh
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
Return: CF clear if successful
	    AH destroyed
	    BH = status change interrupt enable mask (see #0509)
	    CH = Vcc level (lower nybble) (see #0535)
	    CL = Vpp1 level (upper nybble) and Vpp2 level (lower nybble)
	    DH = current socket status (see #0510)
	    DL = indicators (see #0532)
	    SI = card type (see #0536)
	    DI = IRQ level steering (I/O only) (see #0537)
	CF set on error
	    AH = error code (01h,0Bh) (see #0507)
SeeAlso: AH=8Ch,AH=8Eh

Bitfields for PCMCIA card type:
Bit(s)	Description	(Table 0536)
 0	memory
 1	I/O
 2-15	reserved (0)

Bitfields for PCMCIA I/O level steering:
Bit(s)	Description	(Table 0537)
 15	interrupt steering enabled
 14-5	reserved (0)
 4-0	IRQ level (0-15=IRQ,16=NMI,17=I/O check,18=bus error,19=vendor)
--------X-1A8E-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET SOCKET
	AH = 8Eh
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = status change interrupt enable mask (see #0509)
	CL = Vpp1 level (upper nybble) and Vpp2 level (lower nybble)
	DH = current socket status (see #0510)
	DL = indicators (see #0532)
	SI = card type (see #0536)
	DI = IRQ level steering (I/O only) (see #0537)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,02h,05h,06h,0Bh,0Eh,0Fh) (see #0507)
SeeAlso: AH=8Ch,AH=8Dh
--------X-1A8F-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET CARD
	AH = 8Fh
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
Return: CF clear if successful
	    AH destroyed
	    DL = current card status (see #0511)
	CF set on error
	    AH = error code (01h,0Bh) (see #0507)
SeeAlso: AH=8Dh,AH=90h
--------X-1A90-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - RESET CARD
	AH = 90h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,0Bh,14h) (see #0507)
Note:	toggles RESET pin of the specified card, but does not wait after
	  toggling the pin; it is the caller's responsibility to avoid
	  accessing the card before it is ready again
--------X-1A91-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - READ ONE
	AH = 91h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = attributes (see #0538)
	DX:SI = card address
Return: CF clear if successful
	    AH destroyed
	    CL/CX = value read
	CF set on error
	    AH = error code (01h,07h,09h,0Bh,14h) (see #0507)
	    CX may be destroyed
Note:	this function is only valid for I/O-mapped sockets
SeeAlso: AH=92h,AH=93h,INT 21/AX=440Dh"IOCTL"

Bitfields for PCMCIA attributes:
Bit(s)	Description	(Table 0538)
 2	even bytes only
 1	word rather than byte
 0	attribute memory instead of common memory
--------X-1A92-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - WRITE ONE
	AH = 92h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = attributes (see #0538)
	CL/CX = value to write
	DX:SI = card address
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,07h,0Bh,12h,14h) (see #0507)
Note:	this function is only valid for I/O-mapped sockets; it also does not
	  implement Card Technology handling--use AH=94h when writing to
	  non-RAM technologies
SeeAlso: AH=91h,AH=94h,INT 21/AX=440Dh"IOCTL"
--------X-1A93-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - READ MULTIPLE
	AH = 93h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = attributes (see #0538)
	CX = number of bytes or words to read
	DX:SI = card address
	DS:DI -> data buffer to be filled
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,07h,09h,0Bh,14h) (see #0507)
Note:	this function is only available on I/O-mapped sockets
SeeAlso: AH=91h,AH=94h,INT 21/AX=440Dh"IOCTL"
--------X-1A94-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - WRITE MULTIPLE
	AH = 94h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = attributes (see #0538)
	CX = number of bytes or words to read
	DX:DI = card address
	DS:SI -> buffer containing data
	BP = Card Technology type (0000h = RAM)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,07h,0Bh,0Ch,12h,14h) (see #0507)
Notes:	this function is only available on I/O-mapped sockets
	Socket Services calls the Card Technology callback (see #0512) for
	  any card technology it does not directly support
SeeAlso: AH=82h"PCMCIA",AH=92h,AH=93h,INT 21/AX=440Dh"IOCTL"
--------X-1A95-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - INQUIRE ERROR DETECTION CODE
	AH = 95h
	AL = adapter number
	BH = EDC generator number
Return: CF clear if successful
	    AH destroyed
	    CX = bitmap of assignable sockets
	    DH = EDC capabilities (see #0539)
	    DL = supported EDC types (see #0540)
	CF set on error
	    AH = error code (01h,04h) (see #0507)
SeeAlso: AH=96h,AH=9Ch

Bitfields for EDC capabilities:
Bit(s)	Description	(Table 0539)
 0	unidirectional only generation
 1	bidirectional only generation
 2	register-based (I/O-mapped) support
 3	memory-mapped support
 4	pausable
 5-7	reserved (0)

Bitfields for supported EDC types:
Bit(s)	Description	(Table 0540)
 0	8-checksum
 1	16-CRC-SDLC
 2-7	reserved (0)
--------X-1A96-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET ERROR DETECTION CODE
	AH = 96h
	AL = adapter number
	BH = EDC generator number
Return: CF clear if successful
	    AH destroyed
	    BL = socket number
	    DH = EDC attributes (see #0541)
	    DL = EDC type (see #0540) (only one bit set)
	CF set on error
	    AH = error code (01h,04h) (see #0507)
SeeAlso: AH=95h,AH=97h,AH=9Ch

Bitfields for EDC attributes:
Bit(s)	Description	(Table 0541)
 0	unidirectional only
 1	(if 0 set) clear=read, set=write
 2-7	reserved (0)
--------X-1A97-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET ERROR DETECTION CODE
	AH = 97h
	AL = adapter number
	BH = EDC generator
	BL = socket number
	DH = EDC attributes (see #0541)
	DL = EDC type (see #0540) (only one bit may be set)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,02h,04h,0Bh) (see #0507)
SeeAlso: AH=96h,AH=9Ch
--------X-1A98-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - START ERROR DETECTION CODE
	AH = 98h
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,04h) (see #0507)
SeeAlso: AH=96h,AH=99h,AH=9Bh,AH=9Ch
--------X-1A99-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - PAUSE ERROR DETECTION CODE
	AH = 99h
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,04h) (see #0507)
SeeAlso: AH=9Ah
--------X-1A9A-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - RESUME ERROR DETECTION CODE
	AH = 9Ah
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,04h) (see #0507)
SeeAlso: AH=99h,AH=98h
--------X-1A9B-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - STOP ERROR DETECTION CODE
	AH = 9Bh
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (see #0507)
SeeAlso: AH=98h,AH=99h,AH=9Ch
--------X-1A9C-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - READ ERROR DETECTION CODE
	AH = 9Ch
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	    DL/DX = computed checksum or CRC
	CF set on error
	    AH = error code (01h,04h) (see #0507)
SeeAlso: AH=95h,AH=96h,AH=98h,AH=99h,AH=9Bh
--------X-1A9D-------------------------------
INT 1A - PCMCIA Socket Services v2.1? - GET VENDOR INFO
	AH = 9Dh
	AL = adapter number
	BH = EDC generator
	ES:EDI -> vendor information structure (see #2622 below)
Return: CF clear if successful
	    AH destroyed
	    DX = vendor release number in BCD
	    ES:EDI unchanged
	CF set on error
	    AH = error code (01h,15h) (see #0507)
Notes:	this API is supported by recent versions of the AMI BIOS
	appears to conflict with Intel ExCa API.

Vendor Information structure:
Offset	Size	Description	(Table 2622)
 00h	WORD	buffer length (set to size of buffer below)
 04h	WORD	(ret) data length
 08h  x BYTEs	implementor name (ASCIIZ string)
--------X-1A9D-------------------------------
INT 1A - Intel PCMCIA ExCA Card Services - API
	AH = 9Dh
	AL = subfunction (see #0542)
	???
Return: ???
Note:	this API is supported by recent versions of the AMI BIOS

(Table 0542)
Values for PCMCIA ExCA Card Services subfunction number:
 00h	Client Services: Get Number of Sockets
 01h	Advanced Client Utilities: Initialize
 02h	Client Services: Register Client
 03h	Client Services: Deregister Client
 04h	Advanced Client Utilities: Enumerate Clients
 05h	Client Services: Register SCB
 06h	Client Services: Deregister SCB
 07h	Advanced Client Utilities: Register MTD
 08h	Advanced Client Utilities: Deregister MTD
 09h	Advanced Client Utilities: Enumerate MTD
 0Ah	Client Services: Get Status
 0Bh	Client Services: Reset Card
 0Ch	Client Utilities: Get First Tuple
 0Dh	Client Utilities: Get Next Tuple
 0Eh	Client Utilities: Determine First Region
 0Fh	Client Utilities: Determine Next Region
 10h	Client Utilities: Get First Region
 11h	Client Utilities: Get Next Region
 12h	Client Utilities: Get First Partition
 13h	Client Utilities: Get Next Partition
 14h	Bulk Memory Services: Open Region
 15h	Bulk Memory Services: Read Memory
 16h	Bulk Memory Services: Write Memory
 17h	Bulk Memory Services: Copy Memory
 18h	Bulk Memory Services: Erase Memory
 19h	Resource Management: Request I/O
 1Ah	Resource Management: Release I/O
 1Bh	Resource Management: Request Memory
 1Ch	Client Services: Modify Window
 1Dh	Resource Management: Release Memory
 1Eh	Client Services: Map Mem Page
 1Fh	Advanced Client Utilities: Return SS Entry
 20h	Advanced Client Utilities: Map Log to Phy
 21h	Advanced Client Utilities: Map Log Phy to Log
 22h	Resource Management: Request IRQ
 23h	Resource Management: Release IRQ
 24h	Bulk Memory Services: Close Region
--------X-1A9E-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - ACKNOWLEDGE INTERRUPT
	AH = 9Eh
	AL = adapter number
Return: CF clear if successful
	    AH destroyed
	    CX = bitmap representing sockets which have changed status
	CF set on error
	    AH = error code (01h) (see #0507)
Note:	this API is supported by recent versions of the AMI BIOS
--------X-1A9F-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - GET/SET PRIOR INT 1A HANDLER
	AH = 9Fh
	AL = adapter number
	BL = mode
	    00h get prior INT 1Ah handler
	    01h set prior INT 1Ah handler
		CX:DX -> new prior handler
Return: CF clear if successful
	    AH destroyed
	    CX:DX -> old prior handler
	CF set on error
	    AH = error code (01h,15h,18h) (see #0507)
Desc:	allows hooking of INT 16h "behind" the Socket Services hook
Note:	this API is supported by recent versions of the AMI BIOS
SeeAlso: AH=9Eh,AH=A0h"PCMCIA",AH=AEh"PCMCIA"
--------c-1AA0-------------------------------
INT 1A U - Disk Spool II v2.07+ - INSTALLATION CHECK
	AH = A0h
Return: AH = B0h if installed
	    AL = pending INT 1A/AH=D0h subfunction if nonzero???
	    ES = code segment
	    ES:BX -> name of current spool file
	    ES:SI -> current despool file
	    CL = despooler state (00h disabled, 41h enabled)
	    CH = spooler state (00h disabled, 41h enabled)
	    DL = despooler activity
		00h currently active printing a file
		41h standing by
	    DH = 00h ???
	       = 41h ???
	    DI = 0000h ???
		 0001h ???
Program: Disk Spool II is a shareware disk-based print spooler by Budget
	  Software Company
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=ABh,AH=C0h,AH=D0h,AH=E1h
--------X-1AA0-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - GET/SET SOCKET SERVICES ADDRESS
	AH = A0h
	AL = adapter number
	BH = mode
	    00h real mode
	    01h 16:16 protected mode
	    02h 16:32 protected mode
	    03h 00:32 (Flat) protected mode
	BL = subfunction
	    00h return number of additional data areas (see #2623)
	    01h return description of additional data areas (see #2624)
	    02h accept mode-specific pointers to data areas (see #2625)
	ES:EDI -> buffer supplied by caller
Return: CF clear if successful
	    AH destroyed
	    CX = number of additional data areas
	    ES:EDI unchanged
	CF set on error
	    AH = error code (01h,02h,15h,16h,18h) (see #0507)
SeeAlso: AH=9Fh,AH=AEh

Format of PCMCIA Subfunction 00h Buffer Table Entry structure:
Offset	Size	Description	(Table 2623)
 00h	DWORD	32-bit linear base address of the code segment
 04h	DWORD	segment limit of the code segment
 08h	DWORD	entry point offset
 0Ch	DWORD	32-bit linear base address of the data segment
		(ignored in 00:32 flat mode)
 10h	DWORD	segment limit of the data segment
 14h	DWORD	data area offset.  Only used in 32-bit protected mode.
SeeAlso: #2624,#2625

Format of PCMCIA Additional Data Area Description structure [array]:
Offset	Size	Description	(Table 2624)
 00h	DWORD	32-bit linear base address of the additional data segment
		(ignored in 00:32 flat mode)
 04h	DWORD	segment limit of the code segment
 08h	DWORD	data area offset (only used in 32-bit protected mode)
SeeAlso: #2623,#2625

Format of PCMCIA Subfunction 02h Buffer Table Entry structure:
Offset	Size	Description	(Table 2625)
 00h	DWORD	32-bit offset(ignored in 16:16 protected mode)
 04h	DWORD	selector (only used in 00:32 flat mode)
 08h	DWORD	reserved
SeeAlso: #2623,#2624
--------X-1AA1-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - GET ACCESS OFFSETS
	AH = A1h
	AL = adapter number
	BH = Mode
	     00h = Real Mode
	     01h = 16:16 Protected Mode
	     02h = 16:32 Protected Mode
	     03h = 00:32 Protected Mode
	CX = Number of access offsets
	ES:EDI -> buffer supplied by caller, CX words long (see #2626)
Return: CF clear if successful
	    AH destroyed
	    DX = number of access offsets supported
	    ES:EDI unchanged
	CF set on error
	    AH = error code (01h,15h,16h) (see #0507)
Desc:	Returns an array of low-level adapter-specific optimized
	PC Card access routines for adapters that use registers
	or I/O ports to access PC Card memory.	Adapters that access
	PC Card memory through windows mapped to host system memory
	do not support this function.
Note:	offsets returned are 16-bit offsets into the
	Socket Services code segment.  They must be called
	appropriately for the processor mode selected.
	(Real, 16:16 and 16:32 modes use FAR CALL,
	Flat 00:32 mode uses a 32-bit NEAR CALL).
SeeAlso: AH=AEh

Offset Table structure:
Offset	Size	Description	(Table 2626)
 00h	WORD	Set Address
 02h	WORD	Set Auto Increment
 04h	WORD	Read Byte
 06h	WORD	Read Word
 08h	WORD	Read Byte with Auto Increment
 0Ah	WORD	Read Word with Auto Increment
 0Ch	WORD	Read Words
 0Eh	WORD	Read Words with Auto Increment
 10h	WORD	Write Byte
 12h	WORD	Write Word
 14h	WORD	Write Byte with Auto Increment
 16h	WORD	Write Word with Auto Increment
 18h	WORD	Write Words
 1Ah	WORD	Write Words with Auto Increment
 1Ch	WORD	Compare Byte
 1Eh	WORD	Compare Byte with Auto Increment
 20h	WORD	Compare Words
 22h	WORD	Compare Words with Auto Increment
--------c-1AAB-------------------------------
INT 1A U - Disk Spool II v1.83 - INSTALLATION CHECK
	AH = ABh
Return: AH = BAh if installed
	    AL = pending INT 1A/AH=ADh subfunction if nonzero???
	    ES = code segment
	    ES:BX -> name of current spool file
	    ES:SI -> current despool file
	    CL = despooler state (00h disabled, 41h enabled)
	    CH = spooler state (00h disabled, 41h enabled)
	    DL = despooler activity
		00h currently active printing a file
		41h standing by
	    DH = 00h ???
	       = 41h ???
	    DI = 0000h ???
		 0001h ???
Program: Disk Spool II is a shareware disk-based print spooler by Budget
	  Software Company
SeeAlso: AH=A0h,AH=ACh,AH=ADh,AH=E1h
--------c-1AAC-------------------------------
INT 1A U - Disk Spool II v1.83 - INSTALLATION CHECK
	AH = ACh
Return: (see AH=ABh)
Note:	this function is identical to AH=ABh
SeeAlso: AH=A0h,AH=ABh,AH=ADh
--------c-1AAD-------------------------------
INT 1A U - Disk Spool II v1.83 - FUNCTION CALLS
	AH = ADh
	AL = function code (see #0543)
Return: AH = 00h if successful
SeeAlso: AH=ABh

(Table 0543)
Values for Disk Spool function code:
 02h	enable spooler only
 03h	enable the despooler
 04h	disable the despooler
 08h	inhibit popup menu
 09h	enable popup menu
 0Ah	???
 0Bh	disable the spooler
 0Ch	start despooler after last successfully printed document???
 0Dh	start despooler at the exact point where it last left off???
 0Eh	pop up the menu
 0Fh	???
 11h	???
 14h	???
 15h	???
 16h	???
 17h	???
 18h	???
 19h	???
 20h	clear file pointed to by the despooler???
 21h	???
 22h	???
 23h	???
 30h	???
--------X-1AAE-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - VENDOR SPECIFIC
	AH = AEh
	AL = adapter number
	all other registers are vendor-specific
Return: vendor specific
SeeAlso: AH=A1h,AH=AFh
--------X-1AAE-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - API
	AH = AEh
	SI = function
	    0002h ???
	    0100h ???
	    0101h ???
	    8000h ???
	    8001h ???
	details not yet available
Return: CF clear if successful
	CF set on error
	    AH = error code (02h,0Bh,11h,15h,17h) (see #0507)
SeeAlso: AH=9Eh
--------X-1AAF-------------------------------
INT 1A - PCMCIA v2 - API
	AH = AFh
	details not yet available
SeeAlso: AH=AEh
--------X-1AB000-----------------------------
INT 1A U - HP 100LX/200LX - PCMCIA - ???
	AX = B000h
	ES:BX -> parameter block ???
Return: CF clear if ???
	CF set if ???
Note:	called by HP 100LX/200LX PCMCIA client CIC100.EXE
--------d-1AB001CX4D52-----------------------
INT 1A - Microsoft Real-Time Compression Interface (MRCI) - ROM-BASED SERVER
	AX = B001h
	CX = 4D52h ("MR")
	DX = 4349h ("CI")
Return: CX = 4943h ("IC") if installed
	DX = 524Dh ("RM") if installed
	    ES:DI -> MRCINFO structure (see #0544)
Note:	this call is functionally identical to INT 2F/AX=4A12h, which should
	  be called first, as this call is used for the first, ROM-based
	  MRCI server, while the other call is used for RAM-based servers
	  which may be partially or entirely replacing a prior server
SeeAlso: INT 2F/AX=4A12h

Format of MRCINFO structure:
Offset	Size	Description	(Table 0544)
 00h  4 BYTEs	vendor signature
		"MSFT" Microsoft
 04h	WORD	server version (high=major)
 06h	WORD	MRCI specification version
 08h	DWORD	address of server entry point (see #0546)
 0Ch	WORD	bit flags: server capabilities (see #0545)
 0Eh	WORD	bit flags: hardware assisted capabilities (see #0545)
 10h	WORD	maximum block size supported by server (at least 8192 bytes)

Bitfields for MRCI capabilities:
Bit(s)	Description	(Table 0545)
 0	standard compress
 1	standard decompress
 2	update compress
 3	MaxCompress (not present in initial public release)
 4	reserved
 5	incremental decompress
 6	MRCI 2.0 standard compress
 7	MRCI 2.0 standard decompress
 8-14	reserved
 15	this structure is in ROM and can't be modified
	(server capabilities only)

(Table 0546)
Call MRCI entry point with:
	DS:SI -> MRCREQUEST structure (see #0547)
	CX = type of client (0000h application, 0001h file system)
	AX = operation
	    0001h perform standard compression
	    0002h perform standard decompression
	    0004h perform update compression
	    0008h perform MaxCompress
	    0020h perform incremental decompression
	    0040h perform MRCI 2.0 standard compression
	    0080h perform MRCI 2.0 standard decompression
	AX = FFFFh clear flags
	    BX = bitmask of flags to clear (set bits in BX are flags to clear)
Return: AX = status
	    0000h successful
	    0001h invalid function
	    0002h server busy, try again
	    0003h destination buffer too small
	    0004h incompressible data
	    0005h bad compressed data format
	BP destroyed (MS-DOS 6.2)
Note:	MRCI driver may chain to a previous driver

Format of MRCREQUEST structure:
Offset	Size	Description	(Table 0547)
 00h	DWORD	pointer to source buffer
 04h	WORD	size of source buffer (0000h = 64K)
 06h	WORD	(UpdateCompress only)
		(call) offset in source buffer of beginning of changed data
		(ret) offset in destination buffer of beginning of changed
			  compressed data
 08h	DWORD	pointer to destination buffer
		must contain original compressed data for UpdateCompress
 0Ch	WORD	size of destination buffer (0000h = 64K)
		any compression: size of buffer for compressed data
		standard decompression: number of bytes to be decompressed
		incremental decompression: number of byte to decompress now
		(ret) actual size of resulting data
 0Eh	WORD	client compressed data storage allocation size
 10h	DWORD	incremental decompression state data
		set to 00000000h before first incremental decompression call
Notes:	the source and destination buffers may not overlap
	the source and destination buffer sizes should normally be the same
	application should not update the contents of the MRCREQUEST structure
	  between incremental decompression calls
--------X-1AB101-----------------------------
INT 1A - Intel PCI BIOS v2.0c - INSTALLATION CHECK
	AX = B101h
Return: AH = 00h if installed
	    CF clear
	    EDX = 20494350h (' ICP')
	    EDI = physical address of protected-mode entry point (see #0550)
	    AL = PCI hardware characteristics (see #0549)
	    BH = PCI interface level major version (BCD)
	    BL = PCI interface level minor version (BCD)
	    CL = number of last PCI bus in system
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Note:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
SeeAlso: AX=B181h

(Table 0548)
Values for PCI BIOS v2.0c status codes:
 00h	successful
 81h	unsupported function
 83h	bad vendor ID
 86h	device not found
 87h	bad PCI register number

Bitfields for PCI hardware characteristics:
Bit(s)	Description	(Table 0549)
 0	configuration space access mechanism 1 supported
 1	configuration space access mechanism 2 supported
 2-3	reserved
 4	Special Cycle generation mechanism 1 supported
 5	Special Cycle generation mechanism 2 supported
 6-7	reserved

(Table 0550)
Call protected-mode entry point with:
	registers as for real/V86-mode INT call
	CS = ring 0 descriptor with access to full address space
Return: as for real/V86-mode call
--------X-1AB102-----------------------------
INT 1A - Intel PCI BIOS v2.0c - FIND PCI DEVICE
	AX = B102h
	CX = device ID
	DX = vendor ID
	SI = device index (0-n)
Return: CF clear if successful
	CF set on error
	AH = status (00h,83h,86h) (see #0548)
	    00h successful
		BH = bus number
		BL = device/function number (bits 7-3 device, bits 2-0 func)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	device ID FFFFh may be reserved as a wildcard in future implementations
	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
	all devices sharing a single vendor ID and device ID may be enumerated
	  by incrementing SI from 0 until error 86h is returned
SeeAlso: AX=B182h
--------X-1AB103-----------------------------
INT 1A - Intel PCI BIOS v2.0c - FIND PCI CLASS CODE
	AX = B103h
	ECX = class code (bits 23-0)
	    xx400000h = multimedia device, video subclass
	    xx408000h = multimedia device, other multimedia device
	SI = device index (0-n)
Return: CF clear if successful
	CF set on error
	AH = status (00h,86h) (see #0548)
	    00h successful
		BH = bus number
		BL = device/function number (bits 7-3 device, bits 2-0 func)
	    86h device not found
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
	all devices sharing the same Class Code may be enumerated by
	  incrementing SI from 0 until error 86h is returned
SeeAlso: AX=B183h
--------X-1AB106-----------------------------
INT 1A - Intel PCI BIOS v2.0c - PCI BUS-SPECIFIC OPERATIONS
	AX = B106h
	BL = bus number
	EDX = Special Cycle data
Return: CF clear if successful
	CF set on error
	AH = status (00h,81h) (see #0548)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Note:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
SeeAlso: AX=B186h
--------X-1AB108-----------------------------
INT 1A - Intel PCI BIOS v2.0c - READ CONFIGURATION BYTE
	AX = B108h
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	BH = bus number
	DI = register number (0000h-00FFh)
Return: CF clear if successful
	    CL = byte read
	CF set on error
	AH = status (00h,87h) (see #0548)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B188h
--------X-1AB109-----------------------------
INT 1A - Intel PCI BIOS v2.0c - READ CONFIGURATION WORD
	AX = B109h
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	BH = bus number
	DI = register number (0000h-00FFh)
Return: CF clear if successful
	    CX = word read
	CF set on error
	AH = status (00h,87h) (see #0548)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B189h
--------X-1AB10A-----------------------------
INT 1A - Intel PCI BIOS v2.0c - READ CONFIGURATION DWORD
	AX = B10Ah
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #0548)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B18Ah
--------X-1AB10B-----------------------------
INT 1A - Intel PCI BIOS v2.0c - WRITE CONFIGURATION BYTE
	AX = B10Bh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
	CL = byte to write
Return: CF clear if successful
	CF set on error
	AH = status (00h,87h) (see #0548)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B18Bh
--------X-1AB10C-----------------------------
INT 1A - Intel PCI BIOS v2.0c - WRITE CONFIGURATION WORD
	AX = B10Ch
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 2 less than 0100h)
	CX = word to write
Return: CF clear if successful
	CF set on error
	AH = status (00h,87h) (see #0548)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B18Ch
--------X-1AB10D-----------------------------
INT 1A - Intel PCI BIOS v2.0c - WRITE CONFIGURATION DWORD
	AX = B10Dh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 4 less than 0100h)
	ECX = dword to write
Return: CF clear if successful
	CF set on error
	AH = status (00h,87h) (see #0548)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B18Dh
--------X-1AB181-----------------------------
INT 1A - Intel PCI BIOS v2.0c - INSTALLATION CHECK (32-bit)
	AX = B181h
Return: as for AX=B101h
SeeAlso: AX=B101h
--------X-1AB182-----------------------------
INT 1A - Intel PCI BIOS v2.0c - FIND PCI DEVICE (32-bit)
	AX = B182h
	CX = device ID
	DX = vendor ID
	SI = device index (0-n)
Return: as for AX=B102h
SeeAlso: AX=B102h
--------X-1AB183-----------------------------
INT 1A - Intel PCI BIOS v2.0c - FIND PCI CLASS CODE (32-bit)
	AX = B183h
	ECX = class code (bits 23-0)
	SI = device index (0-n)
Return: as for AX=B103h
SeeAlso: AX=B103h
--------X-1AB186-----------------------------
INT 1A - Intel PCI BIOS v2.0c - PCI BUS-SPECIFIC OPERATIONS (32-bit)
	AX = B186h
	BH = bus number
	EDX = Special Cycle data
Return: as for AX=B106h
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B106h
--------X-1AB188-----------------------------
INT 1A - Intel PCI BIOS v2.0c - READ CONFIGURATION BYTE (32-bit)
	AX = B188h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
Return: as for AX=B108h
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B108h
--------X-1AB189-----------------------------
INT 1A - Intel PCI BIOS v2.0c - READ CONFIGURATION WORD (32-bit)
	AX = B189h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
Return: as for AX=B109h
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B109h
--------X-1AB18A-----------------------------
INT 1A - Intel PCI BIOS v2.0c - READ CONFIGURATION DWORD (32-bit)
	AX = B18Ah
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
Return: as for AX=B10Ah
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah
--------X-1AB18B-----------------------------
INT 1A - Intel PCI BIOS v2.0c - WRITE CONFIGURATION BYTE (32-bit)
	AX = B18Bh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
	CL = byte to write
Return: as for AX=B10Bh
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Bh
--------X-1AB18C-----------------------------
INT 1A - Intel PCI BIOS v2.0c - WRITE CONFIGURATION WORD (32-bit)
	AX = B18Ch
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 2 less than 0100h)
	CX = word to write
Return: as for AX=B10Ch
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ch
--------X-1AB18D-----------------------------
INT 1A - Intel PCI BIOS v2.0c - WRITE CONFIGURATION DWORD (32-bit)
	AX = B18Dh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 4 less than 0100h)
	ECX = dword to write
Return: as for AX=B10Dh
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Dh
--------X-1AB400-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - INSTALLATION CHECK
	AX = B400h
Return: CF clear if installed
	AX = 0000h if installed
	    BH = ??? (02h)
	    BL = ??? (08h)
	    CX = ??? (0002h)
	    EDX = 47464341h ('GFCA', which is byte-swapped 'ACFG')
	    SI = ??? (001Fh)
SeeAlso: AX=B401h,AX=B402h,AX=B403h,AX=B404h,AX=B405h,AX=B406h,AX=B407h
SeeAlso: @xxxxh:xxxxh"Plug-and-Play"

(Table 0551)
Values for Intel Plug-and-Play AUTO-CONFIGURATION error codes:
 0000h	successful
 0051h	???
 0055h	unable to read/write configuration table from/to nonvolatile storage
 0056h	not a valid configuration table or wrong table version
 0059h	buffer too small
 FFFFh	???
--------X-1AB401-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET DEFAULT CONFIG TABLE
	AX = B401h
Return: CF clear if successful
	    AX = 0000h
	    BX = maximum size of configuration table??? (1000h)
	    CX = ??? (2000h)
	    EDI = linear/physical address of ESCD table (see #0552)
	CF set on error
	    AX = error code (see #0551)
SeeAlso: AX=B400h,AX=B402h,@xxxxh:xxxxh"Plug-and-Play"

Format of Intel Plug-and-Play Extended System Configuration Data table:
Offset	Size	Description	(Table 0552)
 00h	WORD	total length of this table
 02h  4 BYTEs	signature "ACFG"
 06h	BYTE	minor version number
 07h	BYTE	major version number (currently 02h)
 08h	BYTE	number of boards listed in the configuration data
 09h  3 BYTEs	reserved (00h)
 0Ch	var	board data
	WORD	checksum
Notes:	this table contains information about the standard devices in the
	  system, such as serial ports, parallel ports, etc.  For each device,
	  it includes at least the I/O port address (03F8h,02F8h,0378h,etc).
	the sum of all words in the table, including the checksum field (with
	  implied zero padding if the length is odd), must equal 0000h
SeeAlso: #0553

Format of Extended System Configuration Data Board Header:
Offset	Size	Description	(Table 0553)
 00h	WORD	length of this header in bytes
 02h	BYTE	slot number
		00h motherboard
		01h-0Fh ISA/EISA
		10h-40h	PCI
 03h	BYTE	reserved (00h)
SeeAlso: #0552,#0554

Format of Extended System Configuration Data Freeform Board Header:
Offset	Size	Description	(Table 0554)
 00h  4 BYTEs	signature "ACFG"
 04h	BYTE	minor version number
 05h	BYTE	major version number (currently 02h)
 06h	BYTE	board type
		01h ISA
		02h EISA
		04h PCI
		08h PCMCIA
		10h PnPISA
		20h MCA
 07h	BYTE	reserved (00h)
 08h	WORD	disabled functions (bit N set = function N disabled)
 0Ah	WORD	configuration error functions
 0Ch	WORD	reconfigurable functions (bit N set = function N reconfig'able)
 0Eh  2 BYTEs	reserved (00h)
SeeAlso: #0557,#0558

Format of Extended System Configuration Data Freeform PCI Device Data:
Offset	Size	Description	(Table 0555)
 00h	BYTE	PCI bus number
 01h	BYTE	PCI device and function number
 02h	WORD	PCI device identifier
 04h	WORD	PCI vendor ID
		1002h = ATI
 06h  2 BYTEs	reserved (00h)
SeeAlso: #0555,#0558

Format of Extended System Configuration Data Freeform PnP ISA Board ID:
Offset	Size	Description	(Table 0556)
 00h	DWORD	vendor ID (EISA device identifier)
 04h	DWORD	serial number
SeeAlso: #0556,#0557

Format of Extended System Configuration Data PnP ISA ECD Extension Function:
Offset	Size	Description	(Table 0557)
 00h	WORD	001Eh (length of this structure)
 02h	BYTE	01h (selection size)
 03h	BYTE	00h (selection data)
 04h	BYTE	C0h (function information byte) (see #0560)
 05h	BYTE	18h (size of following free-format data)
 06h 16 BYTEs	freeform board header (see #0554)
 16h  8 BYTEs	Plug-and-Play board ID (see #0556)
Note:	ECD = Extended Configuration Data; this structure must be the last
	  "function" for a particular ISA Plug-and-Play board
SeeAlso: #0558

Format of Extended System Configuration Data PCI ECD Extension Function:
Offset	Size	Description	(Table 0558)
 00h	WORD	length of this structure (at least 001Eh, up to 0056h)
 02h	BYTE	01h (selection size)
 03h	BYTE	00h (selection data)
 04h	BYTE	C0h (function information byte) (see #0560)
 05h	BYTE	size of following free-format data (at least 18h, max 50h)
 06h 16 BYTEs	freeform board header (see #0554)
 16h 8N BYTEs	PCI board ID (see #0555) for one to eight boards
Notes:	ECD = Extended Configuration Data; this structure must be the last
	  "function" for a particular PCI board
	AMI BIOS v1.00.05.AX1 sets the length field to 001Ch for entries with
	  a single board ID, apparently treating the field as the length of
	  the remainder of the structure instead of the full structure's length
SeeAlso: #0557

Bitfields for EISA ID and Slot Information:
Bit(s)	Description	(Table 0559)
 3-0	selector among duplicate configuration file names (0000 if no dups)
 5-4	slot type
	00 expansion slot
	01 embedded
	10 virtual slot
	11 reserved
 6	ID is readable
 7	duplicate IDs present
 8	board can be disabled
 9	IOCHKERR supported
 10	board or entries locked
 13-11	reserved
 14	board does not have or need configuration file
 15	configuration not complete
SeeAlso: #0560

Bitfields for EISA Function Information:
Bit(s)	Description	(Table 0560)
 0	subtype data
 1	memory information (see #0561)
 2	IRQ information (see #0563)
 3	DMA information (see #0564)
 4	port range information (see #0565)
 5	port initialization data (see #0566)
 6	free form data
 7	function disabled
SeeAlso: #0557,#0558,#0559

Format of EISA Memory Information:
Offset	Size	Description	(Table 0561)
 00h	WORD	memory information flags (see #0562)
 02h  3 BYTEs	high 24 bits of memory start address (LSB first)
 05h	WORD	memory size in K (0000h = 65536K)
SeeAlso: #0560

Bitfields for EISA Memory Information Flags:
Bit(s)	Description	(Table 0562)
 0	writable (RAM rather than ROM)
 1	cached
 2	write-back cache rather than write-through
 4-3	memory type
	00 system
	01 expantion
	10 virtual
	11 other
 5	shared
 6	reserved (0)
 7	more entries follow
 9-8	memory width
	00 byte
	01 word
	10 dword
	11 reserved
 11-10	decoded address lines
	00 = 20
	01 = 24
	10 = 32
	11 reserved
 15-12	reserved (0)
SeeAlso: #0561

Bitfields for EISA IRQ Information:
Bit(s)	Description	(Table 0563)
 3-0	IRQ number
 4	reserved (0)
 5	IRQ triggering (0 = edge, 1 = level)
 6	IRQ is shareable
 7	more entries follow
 15-8	reserved (0)
SeeAlso: #0560

Bitfields for EISA DMA Information:
Bit(s)	Description	(Table 0564)
 2-0	DMA channel number
 5-3	reserved (0)
 6	shareable
 7	more entries follow
 9-8	reserved
 11-10	DMA transfer size
	00 byte
	01 word
	10 dword
	11 word, but count in bytes
 13-12	DMA timing
	00 ISA-compatible
	01 EISA type "A"
	10 EISA type "B"
	11 EISA type "C"/"F" (burst)
 15-14	reserved (0)
SeeAlso: #0560

Format of EISA Port Range Information:
Offset	Size	Description	(Table 0565)
 00h	BYTE	port description
		bits 4-0: number of sequential ports
		bit 5 reserved (0)
		bit 6: shareable
		bit 7: more entries follow
 01h	WORD	I/O port address
SeeAlso: #0560,#0566

Format of EISA Port Initialization Data:
Offset	Size	Description	(Table 0566)
 00h	BYTE	flags
		bits 1-0: port size
			00 byte
			01 word
			10 dword
			11 reserved
		bit 2: masked write
		bits 6-3 reserved (0)
		bit 7: more entries follow
 01h	???
SeeAlso: #0560,#0565
--------X-1AB402-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - COPY AND VERIFY CONFIG TABLE
	AX = B402h
	DS:SI -> configuration table (see #0552)
	ES:DI -> buffer for copy of configuration table
Return: CF clear if successful
	    AX = 0000h
	CF set on error
	    AX = error code (0055h,0056h) (see #0551)
Note:	the buffer pointed at by ES:DI must be at least as large as the
	  maximum configuration table size reported by AX=B401h
SeeAlso: AX=B400h,AX=B401h
--------X-1AB403-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - ???
	AX = B403h
	DS:SI -> configuration table (see #0552)
Return: CF clear if successful
	    AX = 0000h
	CF set on error
	    AX = error code (0055h) (see #0551)
Note:	sets the configuration table's checksum field, then ???
SeeAlso: AX=B400h
--------X-1AB404-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - ???
	AX = B404h
	BX = ???
Return: CF clear if successful
	    AX = 0000h
	    BX = ???
	    CX = ???
	    DX = ???
	CF set on error
	    AX = error code (0051h) (see #0551)
SeeAlso: AX=B400h
--------X-1AB405-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET ???
	AX = B405h
Return: AX = ??? (0008h)
SeeAlso: AX=B400h
--------X-1AB406-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET ???
	AX = B406h
	ES:DI -> ??? header (see #0567)
Return: CF clear if successful
	    AX = 0000h
	    WORD ES:[DI] = size of returned data
	CF set on error
	    AX = error code (0059h) (see #0551)
	    WORD ES:[DI] = required size of buffer
SeeAlso: AX=B400h

Format of Intel Plug-and-Play AUTO-CONFIGURATION ??? header:
Offset	Size	Description	(Table 0567)
 00h	WORD	length of structure buffer
 02h	DWORD	-> structure array buffer (see #0568)

Format of Intel Plug-and-Play AUTO-CONFIGURATION ??? structure entry [array]:
Offset	Size	Description	(Table 0568)
 00h	BYTE	???
 01h	BYTE	???
 02h	BYTE	???
 03h	WORD	???
 05h	BYTE	???
 06h	WORD	???
 08h	BYTE	???
 09h	WORD	???
 0Bh	BYTE	???
 0Ch	WORD	???
 0Eh	WORD	???
SeeAlso: #0567
--------X-1AB407-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - ???
	AX = B407h
	EDX = length of ???
	EDI = physical address of ???
Return: CF clear if successful
	    AX = 0000h
	    EDI = ???
	CF set on error
	    AX = error code (FFFFh) (see #0551)
Note:	returns error if EDI < 000C0000h
SeeAlso: AX=B400h
--------X-1AB4-------------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - 32-BIT API
	AH = B4h
	AL = function (80h-87h)
	further details not yet available
Note:	these functions are 32-bit versions of functions 00h-07h
--------c-1AC0-------------------------------
INT 1A U - Disk Spool II v2.07+ - ALTERNATE INSTALLATION CHECK
	AH = C0h
Return: (see AH=A0h)
Notes:	this call is identical to AH=A0h
	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=ABh,AH=D0h
--------U-1ACCCCBXCCCC-----------------------
INT 1A U - DATEFIX - INSTALLATION CHECK
	AX = CCCCh
	BX = CCCCh
	CX = 0000h
Return: CX = CCCCh if installed
	    ES:BX -> original interrupt handler
Program: DATEFIX is a public-domain TSR to correct the date on AT&T 6300
	  machines, where the realtime clock's calendar wraps after 1991
SeeAlso: AH=FEh,AH=FFh"AT&T"
--------c-1AD0-------------------------------
INT 1A U - Disk Spool II v2.07+ - FUNCTION CALLS
	AH = D0h
	AL = function code
	    01h enable spooler and despooler
	    02h enable spooler only
	    03h enable despooler at beginning of file
	    04h disable the despooler
	    05h disable the despooler and spooler
	    06h clear the spool file
	    08h inhibit the popup menu
	    09h enable the popup menu
	    0Ah ??? (called by Disk Spool's INT 21 handler)
	    0Bh disable the spooler
	    0Ch start despooler after last successfully printed document
	    0Dh start despooler at the exact point where it last left off
	    0Eh pop up the menu
	    0Fh ???
	    11h start new spool file??? (called by Disk Spool's INT 21 handler
			when a program terminates)
	    14h ???
	    15h delete despool file and reset ???
	    16h ??? (writes something to unknown file)
	    17h ??? (writes something to despool file, then reads something
			else and ???)
	    18h ??? (reads something from despool file, and then ???)
	    19h ??? (creates/truncates spool file)
	    20h clear file pointed to by the despooler
	    21h ??? (writes something to unknown file)
	    22h ??? (writes something to spool file if spooler/despooler using
			same file)
	    23h ??? (opens/creates unknown file, then ???)
	    30h ???
	    31h ???
	    32h beep
	    33h append CRLF to spool file???
	    34h ???
	    35h ???
	    36h ???
	    37h append CRLF to spool file and start a new spool file???
	    38h ???
	    40h ??? (v4.05)
	    41h ??? (v4.05)
	    51h ??? (called by Disk Spool's INT 21 handler)
	    52h ??? (called by Disk Spool's INT 21 handler)
	    57h ???
	    5Ah ??? (v4.05)
	    5Bh ??? (v4.05)
	    5Ch ??? (v4.05)
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=ADh
--------c-1AE0-------------------------------
INT 1A - Disk Spool II v4.0x - ENABLE/DISABLE
	AH = E0h
	AL = subfunction
	    01h enable spooler
	    02h disable spooler
	    03h enable despooler
	    04h disable despooler
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
	    F0h printer port not managed by Disk Spool II
	    FFH failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=E1h,AX=E301h,AX=E401h
--------c-1AE1-------------------------------
INT 1A - Disk Spool II v4.0x - GET STATUS
	AH = E1h
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
		CL = despooler state (00h disabled, 41h enabled)
		CH = spooler state (00h disabled, 41h enabled)
		DL = despooler activity (00h standing by, 41h printing)
		ES:BX -> ASCIZ name of current spool file (or next if AutoSpool
			or AutoDespool enabled)
		ES:SI -> ASCIZ name of current despool file
		ES:DI -> 3-byte file extension used by Disk Spool II
	    F0h printer port not managed by Disk Spool II
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=E0h,AH=E2h
--------U-1AE11B-----------------------------
INT 1A - TheGrab v4.60 - ???
	AX = E11Bh
	???
Return: ??? (may destroy all registers)
SeeAlso: AX=E11Dh
--------U-1AE11D-----------------------------
INT 1A - TheGrab v4.60 - INSTALLATION CHECK
	AX = E11Dh
Return: ES:DI -> signature block (see #0569) if installed
	    CX = length of signature block (000Fh)
Program: TheGrab is a resident ANSI screen grabber bundled with TheDraw
SeeAlso: AX=E11Bh

Format of TheGrab signature block:
Offset	Size	Description	(Table 0569)
 00h	BYTE	08h
 01h  8 BYTEs	ASCIZ "THEGRAB"
 09h  6 BYTEs	??? (zeros)
--------c-1AE2-------------------------------
INT 1A - Disk Spool II v4.0x - GET SPOOL FILES
	AH = E2h
	AL = which
	    01h first
	    02h next (can only call after "first")
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
		ES:BX -> ASCIZ filename
	    F0h no (more) spool files
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E0h,AH=E1h
--------c-1AE301-----------------------------
INT 1A - Disk Spool II v4.0x - GET SPOOL FILE STATUS
	AX = E301h
	ES:BX -> ASCIZ filename (max 32 chars)
Return: AH = status
	    00h successful
		ES:SI -> spool file status record (see #0570)
	    F0h not a spool file
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E0h,AX=E302h,AX=E401h

Format of Disk Spool II spool file status record:
Offset	Size	Description	(Table 0570)
 00h	BYTE	hour of creation or last update
 01h	BYTE	minute of creation or last update
 02h	BYTE	year-1980 of creation or last update
 03h	BYTE	month of creation or last update
 04h	BYTE	day of creation or last update
 05h	BYTE	total number of copies to print
 06h	BYTE	number of copies already printed
 07h	BYTE	printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
 08h	BYTE	save status (00h delete after printing, 01h save)
 09h	BYTE	file status
		01h done printing, but being saved
		02h on hold
		03h queued for printing
		04h being spooled
		05h being despooled (i.e. printed)
 0Ah 16 BYTEs	ASCIZ description
 1Ah  2 WORDs	file size in bytes (high,low)
 1Eh  2 WORDs	bytes left to print (high,low)
--------c-1AE302-----------------------------
INT 1A - Disk Spool II v4.0x - UPDATE SPOOL FILE
	AX = E302h
	ES:BX -> ASCIZ filename (max 32 chars)
	ES:SI -> spool file status record (see #0570)
Return: AH = status
	    00h successful
	    F0h not a spool file
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E0h,AX=E301h,AX=E401h
--------c-1AE401-----------------------------
INT 1A - Disk Spool II v4.0x - SPOOL EXISTING FILE
	AX = E401h
	ES:BX -> ASCIZ filename (max 32 chars)
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E1h,AX=E302h,AX=E402h
--------c-1AE402-----------------------------
INT 1A U - Disk Spool II v4.0x - SPOOL EXISTING FILE???
	AX = E402h
	ES:BX -> ASCIZ filename (max 32 chars)
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E1h,AX=E302h,AX=E401h
--------c-1AE5-------------------------------
INT 1A U - Emulaser ELSPL.COM - ???
	AH = E5h
	???
Return: ???
Program: ELSPL.COM is a licensed version of Disk Spool II which is distributed
	  as part of Vertisoft's Emulaser PostScript emulator
SeeAlso: AH=A0h,INT 17/AH=03h
--------c-1AEE-------------------------------
INT 1A U - Disk Spool II v4.05 - ???
	AH = EEh
	AL = printer port???
	???
Return: ???
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E1h
--------U-1AF7-------------------------------
INT 1A - RighTime v1.1 - TEMPORARILY DISABLE
	AH = F7h
Program: RighTime is a TSR by G.T. Becker which continuously adjusts the system
	  time to correct for clock drift
Note:	any AH value from F0h-F7h or F9h-FEh will perform this function in
	  version 1.1, but F7h is the function called by transient portion
SeeAlso: AH=F8h,AH=FFh"RighTime"
--------U-1AF8-------------------------------
INT 1A - RighTime v1.1 - ENABLE
	AH = F8h
Program: RighTime is a TSR by G.T. Becker which continuously adjusts the system
	  time to correct for clock drift
Note:	RighTime is TeSseRact-compatible (see INT 2F/AX=5453h) and modifies its
	  TeSseRact program identifier based on its current state: "RighTime"
	  when enabled, "RighTim"F7h when disabled.
SeeAlso: AH=F7h,AH=FFh"RighTime"
--------b-1AFE-------------------------------
INT 1A - AT&T 6300 - READ TIME AND DATE
	AH = FEh
Return: BX = day count (0 = Jan 1, 1984)
	CH = hour
	CL = minute
	DH = second
	DL = hundredths
SeeAlso: AX=CCCCh/BX=CCCCh,AH=FFh"AT&T",INT 21/AH=2Ah,INT 21/AH=2Ch
--------b-1AFF-------------------------------
INT 1A - AT&T 6300 - SET TIME AND DATE
	AH = FFh
	BX = day count (0 = Jan 1, 1984)
	CH = hour
	CL = minute
	DH = second
	DL = hundredths
Return: ???
SeeAlso: AX=CCCCh/BX=CCCCh,AH=FEh,INT 21/AH=2Bh,INT 21/AH=2Dh
--------U-1AFF-------------------------------
INT 1A - RighTime v1.1 - PERMANENTLY DISABLE
	AH = FFh
Program: RighTime is a TSR by G.T. Becker which continuously adjusts the system
	  time to correct for clock drift
Note:	upon being permanently disabled, RighTime closes the file handle
	  referencing its executable (which is updated with time correction
	  information every two minutes while RighTime is enabled).
--------s-1AFF00-----------------------------
INT 1A - SND - INSTALLATION CHECK???
	AX = FF00h
Return: AL = version??? (02h)
	AH = busy flag (00h if not in a SND call, 01h if SND currently active)
Note:	the SND API is also supported by IC (Internal Commands) v2.0, a
	  shareware TSR by Geoff Friesen which extends COMMAND.COM's internal
	  command set
SeeAlso: AX=FF01h,AX=FF02h,AX=FF04h,AX=FF05h
--------s-1AFF01-----------------------------
INT 1A - SND - PAUSE
	AX = FF01h
	DX = number of clock ticks to delay
Return: AH = status
	    00h successful
	    01h SND busy
Notes:	if successful, execution returns to the caller after the delay expires;
	  if SND is busy, execution returns immediately
	the IC v2.0 implementation of this API makes no special allowance for
	  time rollover at midnight, which can cause the delay to be over one
	  hour if this function is called just before the BIOS time count
	  rolls over and the delay extends into the next day
SeeAlso: AX=FF00h,INT 15/AH=86h,INT 62/AX=0096h,INT 7F/AH=E8h,INT 80/BX=0009h
SeeAlso: INT E0/CL=BDh
--------s-1AFF02-----------------------------
INT 1A - SND - START SOUND
	AX = FF02h
	DX = frequency in Hertz (14h-FFFFh)
Return: AH = status
	    00h successful
	    01h SND busy
SeeAlso: AX=FF00h,AX=FF01h,AX=FF03h
--------s-1AFF03-----------------------------
INT 1A - SND - STOP SOUND
	AX = FF03h
Return: AH = status
	    00h successful
	    01h busy
Note:	turns off any sound currently being emitted by the PC's speaker unless
	  SND is currently busy processing an API call (this includes
	  background music).  Use AX=FF05h to stop the sound even if an API
	  call is in progress.
SeeAlso: AX=FF00h,AX=FF02h,AX=FF05h
--------s-1AFF04-----------------------------
INT 1A - SND - PLAY MUSIC STRING IN BACKGROUND
	AX = FF04h
	DS:DX -> ASCIZ music string
Return: AH = status
	    00h successful (music begins playing in background)
	    01h busy
Note:	the music string accepted by SND is not the same as that accepted by
	  BASIC and other programs which process music strings
SeeAlso: AX=FF00h,AX=FF05h,INT 80/BX=0006h
--------s-1AFF05-----------------------------
INT 1A - SND - UNCONDITIONALLY STOP SOUND
	AX = FF05h
Return: AH = 00h (successful)
Note:	this function is the same as AX=FF03h, but will stop the sound even if
	  SND is currently busy, such as playing background music
SeeAlso: AX=FF00h,AX=FF03h,INT 80/BX=0007h
--------B-1B---------------------------------
INT 1B C - KEYBOARD - CONTROL-BREAK HANDLER
Desc:	this interrupt is automatically called when INT 09 determines that
	  Control-Break has been pressed
Note:	normally points to a short routine in DOS which sets the Ctrl-C flag,
	  thus invoking INT 23h the next time DOS checks for Ctrl-C.
SeeAlso: INT 23
--------B-1C---------------------------------
INT 1C - TIME - SYSTEM TIMER TICK
Desc:	this interrupt is automatically called on each clock tick by the INT 08
	  handler
Notes:	this is the preferred interrupt to chain when a program needs to be
	  invoked regularly
	not available on NEC 9800-series PCs
SeeAlso: INT 08,INT E2"PC Cluster"
--------B-1D---------------------------------
INT 1D - SYSTEM DATA - VIDEO PARAMETER TABLES
Note:	the default parameter table (see #0571) is located at F000h:F0A4h for
	  100% compatible BIOSes
SeeAlso: INT 10/AH=00h

Format of video parameters:
Offset	Size	Description	(Table 0571)
 00h 16 BYTEs	6845 register values for modes 00h and 01h
 10h 16 BYTEs	6845 register values for modes 02h and 03h
 20h 16 BYTEs	6845 register values for modes 04h and 05h
 30h 16 BYTEs	6845 register values for modes 06h and 07h
 40h	WORD	bytes in video buffer for modes 00h and 01h (0800h)
 42h	WORD	bytes in video buffer for modes 02h and 03h (1000h)
 44h	WORD	bytes in video buffer for modes 04h and 05h (4000h)
 46h	WORD	bytes in video buffer for mode 06h (4000h)
 48h  8 BYTEs	columns on screen for each of modes 00h through 07h
 50h  8 BYTEs	CRT controller mode bytes for each of modes 00h through 07h
Note:	QEMM v7.5 Stealth appears to copy only the first 40h bytes of this
	  table into always-accessible memory
--------B-1E---------------------------------
INT 1E - SYSTEM DATA - DISKETTE PARAMETERS
Note:	the default parameter table (see #0572) is located at F000h:EFC7h for
	  100% compatible BIOSes
SeeAlso: INT 13/AH=0Fh,INT 41,INT 4D/AH=0Ah

Format of diskette parameter table:
Offset	Size	Description	(Table 0572)
 00h	BYTE	first specify byte
		bits 7-4: step rate
		bits 3-0: head unload time (0Fh = 240 ms)
 01h	BYTE	second specify byte
		bits 7-1: head load time (01h = 4 ms)
		bit    0: non-DMA mode (always 0)
 02h	BYTE	delay until motor turned off (in clock ticks)
 03h	BYTE	bytes per sector (00h = 128, 01h = 256, 02h = 512, 03h = 1024)
 04h	BYTE	sectors per track
 05h	BYTE	length of gap between sectors (2Ah for 5.25", 1Bh for 3.5")
 06h	BYTE	data length (ignored if bytes-per-sector field nonzero)
 07h	BYTE	gap length when formatting (50h for 5.25", 6Ch for 3.5")
 08h	BYTE	format filler byte (default F6h)
 09h	BYTE	head settle time in milliseconds
 0Ah	BYTE	motor start time in 1/8 seconds
SeeAlso: #1878 at INT 4D/AH=09h
--------B-1F---------------------------------
INT 1F - SYSTEM DATA - 8x8 GRAPHICS FONT
Desc:	this vector points at 1024 bytes of graphics data, 8 bytes for each
	  character 80h-FFh
Note:	graphics data for characters 00h-7Fh stored at F000h:FA6Eh in 100%
	  compatible BIOSes
SeeAlso: INT 10/AX=5000h,INT 43
--------b-1F12-------------------------------
INT 1F U - C&T "SuperState" BIOS - POWER OFF
	AH = 12h
Return: none
Note:	POWER OFF
--------b-1F17-------------------------------
INT 1F U - C&T "SuperState" BIOS - EXECUTE FAR PROC ROUTINE ON SuperState
	AH = 17h
	ES:DI -> far procedure
Return: all registers except AH,ES,DI
Note:	You can change the BIOS area (F000h:0000h - F000h:FFFFh) only through
	  this function
--------b-1F19-------------------------------
INT 1F U - C&T "SuperState" BIOS - ENABLE AUTO WAKEUP AND SET TIME AND DATE
	AH = 19h
	AL = hour in BCD
	BH = minutes in BCD
	BL = seconds in BCD
	CH = year century in BCD (must be 19h)
	CL = year low in BCD
	DH = month in BCD
	DL = date in BCD
Return: CF clear
--------b-1F1C-------------------------------
INT 1F U - C&T "SuperState" BIOS - SET SUSPEND TIMEOUT
	AH = 1Ch
	BX = sec until suspend starts
Return: None
--------b-1F1D-------------------------------
INT 1F U - C&T "SuperState" BIOS - SET SLEEP TIMEOUT
	AH = 1Dh
	BX = sec until sleep starts
Return: None
--------J-1F90-------------------------------
INT 1F - NEC PC-9801 - COPY EXTENDED MEMORY
	AH = 90h
	ES:BX -> global descriptor table (see #0375 at INT 15/AH=87h)
	CX = number of bytes to copy
	SI = 0000h
	DI = 0000h
Return: CF clear if successful
	CF set on error
	???
SeeAlso: INT 15/AH=87h
--------b-1FF5--BLFA-------------------------
INT 1F U - C&T "SuperState" BIOS - REQUEST PASSWORD INPUT
	AH = F5h
	BL = FAh
Return: none
Note:	this function will not return until the correct password is entered
SeeAlso: AH=F5h/BL=FDh,AX=F5h/BL=FEh
--------b-1FF5--BLFD-------------------------
INT 1F U - C&T "SuperState" BIOS - ENCRYPT PASSWORD
	AH = F5h
	BL = FDh
	CX:SI = input string
	DX:DI = encrypted string
	BH = length of input string
Return: CF set on error
SeeAlso: AH=F5h/BL=FAh,AX=F5h/BL=FEh
--------b-1FF5--BLFE-------------------------
INT 1F U - C&T "SuperState" BIOS - SET PASSWORD
	AH = F5h
	BL = FEh
	CX:SI -> input string
	BH = length of input string (if BH = 00h, clear password)
Return: CF set on error
Note:	the input string must be encrypted by INT 1Fh/AH=F5h/BL=FDh
SeeAlso: AH=F5h/BL=FDh,AX=F5h/BL=FFh
--------b-1FF5--BLFF-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ENCRYPTED PASSWORD
	AH = F5h
	BL = FFh
	DX:DI = string buffer
Return: CF set on error
	CF clear if successful
	    BH = length of input string (if BH = 00h, password is not valid)
	    DX:DI -> encrypted password string
SeeAlso: AH=F5h/BL=FDh,AX=F5h/BL=FEh
--------b-1FFB-------------------------------
INT 1F U - C&T "SuperState" BIOS - GET/SET CPU SPEED
	AH = FBh
	BL = function
	    00h get CPU speed
		Return: AL = current CPU speed (00h = fast, 01h = slow)
	    01h set CPU speed
		AL = new CPU speed (00h = fast, 01h = slow)
SeeAlso: AH=FCh/BL=00h
--------b-1FFC--BL00-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ALARM STATUS
	AH = FCh
	BL = 00h
Return: AL = current alarm state (00h = disabled, 01h = enabled)
SeeAlso: AH=FCh/BL=01h,AH=FCh/BL=02h
--------b-1FFC--BL01-------------------------
INT 1F U - C&T "SuperState" BIOS - SET ALARM STATUS
	AH = FCh
	BL = 01h
	AL = new alarm state (00h = disabled, 01h = enabled)
SeeAlso: AH=FCh/BL=00h,AH=FCh/BL=03h
--------b-1FFC--BL02-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ALARM TIME
	AH = FCh
	BL = 02h
Return: CH = hour by BCD
	CL = min by BCD
	DH = sec by BCD
SeeAlso: AH=FCh/BL=00h,AH=FCh/BL=03h,AH=FCh/BL=04h
--------b-1FFC--BL03-------------------------
INT 1F U - C&T "SuperState" BIOS - SET ALARM TIME
	AH = FCh
	BL = 03h
	CH = hour by BCD
	CL = min by BCD
	DH = sec by BCD
Return: CF set on error (incorrect time format or Alarm is not enable)
SeeAlso: AH=FCh/BL=01h,AH=FCh/BL=02h,AH=FCh/BL=05h
--------b-1FFC--BL04-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ALARM DATE
	AH = FCh
	BL = 04h
Return: CH = year century by BCD
	CL = year low by BCD
	DH = month by BCD
	DL = date by BCD
SeeAlso: AH=FCh/BL=02h,AH=FCh/BL=05h
--------b-1FFC--BL05-------------------------
INT 1F U - C&T "SuperState" BIOS - SET ALARM DATE
	AH = FCh
	BL = 05h
	CH = year century by BCD
	CL = year low by BCD
	DH = month by BCD
	DL = date by BCD
Return: CF set on error (incorrect date format or Alarm is not enable)
SeeAlso: AH=FCh/BL=03h,AH=FCh/BL=04h
--------b-1FFD--BL00-------------------------
INT 1F U - C&T "SuperState" BIOS - GET AUTO WAKE UP STATUS
	AH = FDh
	BL = 00h
Return: AL = current wake-up state (00h = disabled, 01h = enabled)
SeeAlso: AH=FDh/BL=01h,AH=FDh/BL=02h
--------b-1FFD--BL01-------------------------
INT 1F U - C&T "SuperState" BIOS - SET AUTO WAKE UP STATUS
	AH = FDh
	BL = 01h
	AL = new wake-up state (00h = disabled, 01h = enabled)
SeeAlso: AH=FDh/BL=00h,AH=FDh/BL=03h
--------b-1FFD--BL02-------------------------
INT 1F U - C&T "SuperState" BIOS - GET AUTO WAKE UP TIME
	AH = FDh
	BL = 02h
Return: CH = hour by BCD
	CL = min by BCD
	DH = sec by BCD
SeeAlso: AH=FDh/BL=00h,AH=FDh/BL=03h
--------b-1FFD-------------------------------
INT 1F U - C&T "SuperState" BIOS - SET AUTO WAKE UP TIME
       AH = FDh
       BL = 3h
       CH = hour by BCD
       CL = min by BCD
       DH = sec by BCD
Return: CF set on error (incorrect Time format or Auto Wake up is not enable)
SeeAlso: AH=FDh/BL=01h,AH=FDh/BL=02h
--------b-1FFD--BL04-------------------------
INT 1F U - C&T "SuperState" BIOS - GET AUTO WAKE UP DATE
	AH = FDh
	BL = 04h
Return: CH = year century in BCD
	CL = year low in BCD
	DH = month in BCD
	DL = date in BCD
SeeAlso: AH=FDh/BL=02h,AH=FDh/BL=05h
--------b-1FFD--BL05-------------------------
INT 1F U - C&T "SuperState" BIOS - SET AUTO WAKE UP DATE
	AH = FDh
	BL = 05h
	CH = year century in BCD
	CL = year low in BCD
	DH = month in BCD
	DL = date in BCD
Return: CF set on error (incorrect date format or Auto Wake up is not enable)
SeeAlso: AH=FDh/BL=03h,AH=FDh/BL=04h
--------O-20---------------------------------
INT 20 - Minix - SEND/RECEIVE MESSAGE
	AX = process ID of other process
	BX -> message
	CX = operation (1 send, 2 receive, 3 send&receive)
Program: Minix is a Version 7 Unix-compatible operating system by Andrew
	  Tanenbaum
Note:	the message contains the system call number (numbered as in V7
	  Unix(tm)) and the call parameters
--------D-20---------------------------------
INT 20 - DOS 1+ - TERMINATE PROGRAM
	CS = PSP segment
Return: never
Note:	(see INT 21/AH=00h)
SeeAlso: INT 21/AH=00h,INT 21/AH=4Ch
--------G-20---------------------------------
INT 20 - COMTROL HOSTESS i/ISA DEBUGGER - INVOKE FIRMWARE DEBUGGER
	???
Return: ???
SeeAlso: INT 21"COMTROL"
--------W-20---------------------------------
INT 20 P - Microsoft Windows - VxD FUNCTIONS
Note:	the desired VxD and function are identified by the data immediately
	  following the INT 20 instruction, as in:
		INT	20h
		DW	function number
		DW	VxD identifier

(Table 2631)
Values for VMM (VxD ID 0001h) function number:
 00h	get version
 01h	get current VM handle
 02h	test current VM handle
 03h	get system VM handle
 04h	test system VM handle
 05h	validate VM handle
 06h	get VMM reenter count
 07h	begin reentrant execution
 08h	end reentrant execution
 09h	install V86 breakpoint
 0Ah	remove V86 breakpoint
 0Bh	allocate V86 callback
 0Ch	allocation PM callback
 0Dh	call when VM returns
 0Eh	schedule global event
 0Fh	schedule VM event
 10h	call global event
 11h	call VM event
 12h	cancel global event
 13h	cancel VM event
 14h	call priority VM event
 15h	cancel priority VM event
 16h	get NMI handler address
 17h	set NMI handler address
 18h	hook NMI event
 19h	call when VM interrupts enabled
 1Ah	enable VM interrupts
 1Bh	disable VM interrupts
 1Ch	map flat
 1Dh	map linear to VM address
 1Eh	adjust execution priority
 1Fh	begin critical section
 20h	end critical section
 21h	end critical section and suspend
 22h	claim critical section
 23h	release critical section
 24h	call when not critical
 25h	create semaphore
 26h	destroy semaphore
 27h	wait on semaphore
 28h	signal semaphore
 29h	get critical section status
 2Ah	call when task switched
 2Bh	suspend VM
 2Ch	resume VM
 2Dh	no-fail resume VM
 2Eh	nuke VM
 2Fh	crash current VM
 30h	get execution focus
 31h	set execution focus
 32h	get time slice priority
 33h	set time slice priority
 34h	get time slice granularity
 35h	set time slice granularity
 36h	get time slice information
 37h	adjust execution time
 38h	release time slice
 39h	wake up VM
 3Ah	call when idle
 3Bh	get next VM handle
 3Ch	set global timeout
 3Dh	set VM timeout
 3Eh	cancel timeout
 3Fh	get system time
 40h	get VM execution time
 41h	hook V86 interrupt chain
 42h	get V86 interrupt vector
 43h	set V86 interrupt vector
 44h	get PM interrupt vector
 45h	set PM interrupt vector
 46h	simulate interrupt
 47h	simulate IRET
 48h	simulate far call
 49h	simulate far jump
 4Ah	simulate far RET
 4Bh	simulate far RET N
 4Ch	build interrupt stack frame
 4Dh	simulate push
 4Eh	simulate pop
 4Fh	_HeapAllocate
 50h	_HeapReAllocate
 51h	_HeapFree
 52h	_HeapGetSize
 53h	_PageAllocate
 54h	_PageReAllocate
 55h	_PageFree
 56h	_PageLock
 57h	_PageUnLock
 58h	_PageGetSizeAddr
 59h	_PageGetAllocInfo
 5Ah	_GetFreePageCount
 5Bh	_GetSysPageCount
 5Ch	_GetVMPgCount
 5Dh	_MapIntoV86
 5Eh	_PhysIntoV86
 5Fh	_TestGlobalV86Mem
 60h	_ModifyPageBits
 61h	copy page table
 62h	map linear into V86
 63h	linear page lock
 64h	linear page unlock
 65h	_SetResetV86Pageabl
 66h	_GetV86PageableArray
 67h	_PageCheckLinRange
 68h	page out dirty pages
 69h	discard pages
 6Ah	_GetNulPageHandle
 6Bh	get first V86 page
 6Ch	map physical address to linear address
 6Dh	_GetAppFlatDSAlias
 6Eh	_SelectorMapFlat
 6Fh	_GetDemandPageInfo
 70h	_GetSetPageOutCount
 71h	hook V86 page
 72h	assign device V86 pages
 73h	deassign device V86 pages
 74h	get array of V86 pages for device
 75h	_SetNULPageAddr
 76h	allocate GDT selector
 77h	free GDT selector
 78h	allocate LDT selector
 79h	free LDT selector
 7Ah	_BuildDescriptorDWORDs
 7Bh	get descriptor
 7Ch	set descriptor
 7Dh	toggle HMA
 7Eh	get fault hook addresses
 7Fh	hook V86 fault
 80h	hook PM fault
 81h	hook VMM fault
 82h	begin nested V86 execution
 83h	begin nested execution
 84h	execute interrupt
 85h	resume execution
 86h	end nested execution
 87h	allocate PM application callback area
 88h	get current PM application callback area
 89h	set V86 execution mode
 8Ah	set PM execution mode
 8Bh	begin using locked PM stack
 8Ch	end using locked PM stack
 8Dh	save client state
 8Eh	restore client state
 8Fh	execute VxD interrupt
 90h	hook device service
 91h	hook device V86 API
 92h	hook device PM API
 93h	system control
 94h	simulate I/O
 95h	install multiple I/O handlers
 96h	install I/O handler
 97h	enable global trapping
 98h	enable local trapping
 99h	disable global trapping
 9Ah	disable local trapping
 9Bh	create list
 9Ch	destroy list
 9Dh	allocate list
 9Eh	attach list
 9Fh	attach list tail
 A0h	insert into list
 A1h	remove from list
 A2h	deallocate list
 A3h	get first item in list
 A4h	get next item in list
 A5h	remove first item in list
 A6h	add instance item
 A7h	allocate device callback area
 A8h	allocate global V86 data area
 A9h	allocate temporary V86 data area
 AAh	free temporary V86 data area
 ABh	get decimal integer from profile
 ACh	convert decimal string to integer
 ADh	get fixed-point number from profile
 AEh	convert fixed-point string
 AFh	get hex integer from profile
 B0h	convert hex string to integer
 B1h	get boolean value from profile
 B2h	convert boolean string
 B3h	get string from profile
 B4h	get next string from profile
 B5h	get environment string
 B6h	get exec path
 B7h	get configuration directory
 B8h	open file
 B9h	get PSP segment
 BAh	get DOS vectors
 BBh	get machine information
 BCh	get/set HMA information
 BDh	set system exit code
 BEh	fatal error handler
 BFh	fatal memory error
 C0h	update system clock
 C1h	test if debugger installed
 C2h	output debugger string
 C3h	output debugger character
 C4h	input debugger character
 C5h	debugger convert hex to binary
 C6h	debugger convert hex to decimal
 C7h	debugger test if valid handle
 C8h	validate client pointer
 C9h	test reentry
 CAh	queue debugger string
 CBh	log procedure call
 CCh	debugger test current VM
 CDh	get PM interrupt type
 CEh	set PM interrupt type
 CFh	get last updated system time
 D0h	get last updated VM execution time
 D1h	test if double-byte character-set lead byte
 D2h	_AddFreePhysPage
 D3h	_PageResetHandlePAddr
 D4h	_SetLastV86Page
 D5h	_GetLastV86Page
 D6h	_MapFreePhysReg
 D7h	_UnmapFreePhysReg
 D8h	_XchgFreePhysReg
 D9h	_SetFreePhysRegCalBk
 DAh	get next arena (MCB)
 DBh	get name of ugly TSR
 DCh	get debug options
 DDh	set physical HMA alias
 DEh	_GetGlblRng0V86IntBase
 DFh	add global V86 data area
 E0h	get/set detailed VM error
 E1h	Is_Debug_Chr
 E2h	clear monochrome screen
 E3h	output character to mono screen
 E4h	output string to mono screen
 E5h	set current position on mono screen
 E6h	get current position on mono screen
 E7h	get character from mono screen
 E8h	locate byte in ROM
 E9h	hook invalid page fault
 EAh	unhook invalid page fault
 EBh	set delete on exit file
SeeAlso: #2632

(Table 2632)
Values for VPICD (VxD ID 0003h) function number:
 00h	get version
 01h	virtualize IRQ
 02h	set interrupt request
 03h	clear interrupt request
 04h	physical EOI
 05h	get complete status
 06h	get status
 07h	test physical request
 08h	physically mask
 09h	physically unmask
 0Ah	set automatic masking
 0Bh	get IRQ complete status
 0Ch	convert handle to IRQ
 0Dh	convert IRQ to interrupt
 0Eh	convert interrupt to IRQ
 0Fh	call on hardware interrupt
 10h	force default owner
 11h	force default behavior
SeeAlso: #2631,#2633

(Table 2633)
Values for VDMAD (VxD ID 0004h) function number:
 00h	get version
 01h	virtualize channel
 02h	get region information
 03h	set region information
 04h	get virtual state
 05h	set virtual state
 06h	set physical state
 07h	mask channel
 08h	unmask channel
 09h	lock DMA region
 0Ah	unlock DMA region
 0Bh	scatter lock
 0Ch	scatter unlock
 0Dh	reserve buffer space
 0Eh	request buffer
 0Fh	release buffer
 10h	copy to buffer
 11h	copy from buffer
 12h	default handler
 13h	disable translation
 14h	enable translation
 15h	get EISA address mode
 16h	set EISA address mode
 17h	unlock DMA region (ND)
SeeAlso: #2632,#1420,#1431 at INT 2F/AX=1684h/BX=0444h

(Table 2654)
Values for VTD (VxD ID 0005h) function number:
 0000h	get version
 0001h	update system clock
 0002h	get interrupt period
 0003h	begin minimum interrupt period
 0004h	end minimum interrupt period
 0005h	disable trapping
 0006h	enable trapping
 0007h	get real time
SeeAlso: #1420 at INT 2F/AX=1684h/BX=0005h

(Table 2634)
Values for V86MMGR (VxD ID 0006h) function number:
 00h	get version
 01h	allocate V86 pages
 02h	set EMS and XMS limits
 03h	get EMS and XMS limits
 04h	set mapping information
 05h	get mapping information
 06h	Xlat API
 07h	load client pointer
 08h	allocate buffer
 09h	free buffer
 0Ah	get Xlat buffer state
 0Bh	set Xlat buffer state
 0Ch	get VM flat selector
 0Dh	map pages
 0Eh	free page map region
 0Fh	_LocalGlobalReg
 10h	get page status
 11h	set local A20
 12h	reset base pages
 13h	set available mapped pages
SeeAlso: #1420,#2635

(Table 2635)
Values for PageSwap (VxD ID 0007h) function number:
 00h	get version
 01h	test create
 02h	create swap file
 03h	destroy swap file
 04h	in
 05h	out
 06h	test if I/O valid
SeeAlso: #2634,#2636,#1421

(Table 2636)
Values for VDD (VxD ID 000Ah) function number:
 00h	get version
 01h	PIF state
 02h	get GrabRtn
 03h	hide cursor
 04h	set VM type
 05h	get ModTime
 06h	set HCurTrk
 07h	message clear screen
 08h	message foreground color
 09h	message background color
 0Ah	message output text
 0Bh	message set cursor position
 0Ch	query access
SeeAlso: #2635,#2637,#1421

(Table 2637)
Values for VSD (VxD ID 000Bh) function number:
 00h	get version
 01h	bell
SeeAlso: #2636,#2638

(Table 2638)
Values for VMD (VxD ID 000Ch) function number:
 00h	get version
 01h	set mouse type
 02h	get mouse owner
SeeAlso: #2637,#2639

(Table 2639)
Values for VKD (VxD ID 000Dh) function number:
 00h	get version
 01h	define hotkey
 02h	remove hotkey
 03h	locally enable hotkey
 04h	locally disable hotkey
 05h	reflect hotkey
 06h	cancel hotkey state
 07h	force keys
 08h	get keyboard owner
 09h	define paste mode
 0Ah	start pasting
 0Bh	cancel paste
 0Ch	get message key
 0Dh	peek message key
 0Eh	flush message key queue
SeeAlso: #2638,#2640

(Table 2640)
Values for VCD (VxD ID 000Eh) function number:
 00h	get version
 01h	set port global
 02h	get focus
 03h	virtualize port
SeeAlso: #2639,#2641

(Table 2641)
Values for BlockDev (VxD ID 0010h) function number:
 00h	get version
 01h	register device
 02h	find INT 13 drive
 03h	get device list
 04h	send command
 05h	command complete
 06h	synchronous command
SeeAlso: #2640,#2642

(Table 2642)
Values for EBIOS (VxD ID 0012h) function number:
 00h	get version
 01h	get unused memory
SeeAlso: #2641,#2643

(Table 2643)
Values for VNETBIOS (VxD ID 0014h) function number:
 00h	get version
SeeAlso: #2642,#2647

(Table 2647)
Values for DOSMGR (VxD ID 0015h) function number:
 00h	get version
 01h	set exec VM data
 02h	coyp VM drive state
 03h	execute VM
 04h	get InDOS pointer
 05h	add device
 06h	remove device
 07h	instance device
 08h	get DOS critical status
 09h	enable InDOS polling
 0Ah	backfill allowed
 0Bh	"LocalGlobalReg"
SeeAlso: #2643,#1422 at INT 2F/AX=1684h/BX=0015h

(Table 2655)
Values for SHELL (VxD ID 0017h) function number:
 00h	get version
 01h	resolve contention
 02h	event
 03h	SYSMODAL message
 04h	message
 05h	get VM information
SeeAlso: #2647,#2644,#1423 at INT 2F/AX=1684h/BX=0017h

(Table 2644)
Values for VMPoll (VxD ID 0018h) function number:
 00h	get version
 01h	enable/disable
 02h	reset detection
SeeAlso: #2654,#1423 at INT 2F/AX=1684h/BX=0017h

(Table 2645)
Values for DOSNET (VxD ID 001Ah) function number:
 00h	get version
 01h	send FILESYSCHANGE
 02h	do PSP adjust
SeeAlso: #2644,#2646

(Table 2646)
Values for Int13 (VxD ID 0020h) function number:
 00h	get version
 01h	device registered
 02h	translate VM interrupt
 03h	hooking BIOS interrupt
 04h	unhooking BIOS interrupt
SeeAlso: #2645,#2656

(Table 2656)
Values for PAGEFILE (VxD ID 0021h) function number:
 00h	get version
 01h	init file
 02h	clean up
 03h	grow file
 04h	read or write
 05h	cancel
 06h	test I/O valid
SeeAlso: #2646,#1427 at INT 2F/AX=1684h/BX=0021h
--------G-21---------------------------------
INT 21 - COMTROL HOSTESS i/ISA DEBUGGER - GET SEGMENT FOR CONTROL PROGRAM USE
	???
Return: AX = first segment available for control program use
SeeAlso: INT 20"COMTROL",INT 22"COMTROL"
--------D-2100-------------------------------
INT 21 - DOS 1+ - TERMINATE PROGRAM
	AH = 00h
	CS = PSP segment
Notes:	Microsoft recommends using INT 21/AH=4Ch for DOS 2+
	execution continues at the address stored in INT 22 after DOS performs
	  whatever cleanup it needs to do
	if the PSP is its own parent, the process's memory is not freed; if
	  INT 22 additionally points into the terminating program, the
	  process is effectively NOT terminated
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=26h,AH=31h,AH=4Ch,INT 20,INT 22
--------D-2101-------------------------------
INT 21 - DOS 1+ - READ CHARACTER FROM STANDARD INPUT, WITH ECHO
	AH = 01h
Return: AL = character read
Notes:	^C/^Break are checked, and INT 23 executed if read
	character is echoed to standard output
	standard input is always the keyboard and standard output the screen
	  under DOS 1.x, but they may be redirected under DOS 2+
SeeAlso: AH=06h,AH=07h,AH=08h,AH=0Ah
--------D-2102-------------------------------
INT 21 - DOS 1+ - WRITE CHARACTER TO STANDARD OUTPUT
	AH = 02h
	DL = character to write
Return: AL = last character output (despite the official docs which state
		nothing is returned) (at least DOS 3.3-5.0)
Notes:	^C/^Break are checked, and INT 23 executed if pressed
	standard output is always the screen under DOS 1.x, but may be
	  redirected under DOS 2+
	the last character output will be the character in DL unless DL=09h
	  on entry, in which case AL=20h as tabs are expanded to blanks
SeeAlso: AH=06h,AH=09h
--------D-2103-------------------------------
INT 21 - DOS 1+ - READ CHARACTER FROM STDAUX
	AH = 03h
Return: AL = character read
Notes:	keyboard checked for ^C/^Break, and INT 23 executed if detected
	STDAUX is usually the first serial port
SeeAlso: AH=04h,INT 14/AH=02h,INT E0/CL=03h
--------D-2104-------------------------------
INT 21 - DOS 1+ - WRITE CHARACTER TO STDAUX
	AH = 04h
	DL = character to write
Notes:	keyboard checked for ^C/^Break, and INT 23 executed if detected
	STDAUX is usually the first serial port
	if STDAUX is busy, this function will wait until it becomes free
SeeAlso: AH=03h,INT 14/AH=01h,INT E0/CL=04h
--------D-2105-------------------------------
INT 21 - DOS 1+ - WRITE CHARACTER TO PRINTER
	AH = 05h
	DL = character to print
Notes:	keyboard checked for ^C/^Break, and INT 23 executed if detected
	STDPRN is usually the first parallel port, but may be redirected under
	  DOS 2+
	if the printer is busy, this function will wait
SeeAlso: INT 17/AH=00h
--------D-2106-------------------------------
INT 21 - DOS 1+ - DIRECT CONSOLE OUTPUT
	AH = 06h
	DL = character (except FFh)
Return: AL = character output (despite official docs which state nothing is
		returned) (at least DOS 3.3-5.0)
Notes:	does not check ^C/^Break
	writes to standard output, which is always the screen under DOS 1.x,
	  but may be redirected under DOS 2+
SeeAlso: AH=02h,AH=09h
--------D-2106--DLFF-------------------------
INT 21 - DOS 1+ - DIRECT CONSOLE INPUT
	AH = 06h
	DL = FFh
Return: ZF set if no character available
	    AL = 00h
	ZF clear if character available
	    AL = character read
Notes:	^C/^Break are NOT checked
	if the returned character is 00h, the user pressed a key with an
	  extended keycode, which will be returned by the next call of this
	  function
	this function reads from standard input, which is always the keyboard
	  under DOS 1.x, but may be redirected under DOS 2+
	although the return of AL=00h when no characters are available is not
	  documented, some programs rely on this behavior
SeeAlso: AH=0Bh
--------D-2107-------------------------------
INT 21 - DOS 1+ - DIRECT CHARACTER INPUT, WITHOUT ECHO
	AH = 07h
Return: AL = character read from standard input
Notes:	does not check ^C/^Break
	standard input is always the keyboard under DOS 1.x, but may be
	  redirected under DOS 2+
	if the interim console flag is set (see AX=6301h), partially-formed
	  double-byte characters may be returned
SeeAlso: AH=01h,AH=06h,AH=08h,AH=0Ah
--------D-2108-------------------------------
INT 21 - DOS 1+ - CHARACTER INPUT WITHOUT ECHO
	AH = 08h
Return: AL = character read from standard input
Notes:	^C/^Break are checked, and INT 23 executed if detected
	standard input is always the keyboard under DOS 1.x, but may be
	  redirected under DOS 2+
	if the interim console flag is set (see AX=6301h), partially-formed
	  double-byte characters may be returned
SeeAlso: AH=01h,AH=06h,AH=07h,AH=0Ah,AH=64h
--------D-2109-------------------------------
INT 21 - DOS 1+ - WRITE STRING TO STANDARD OUTPUT
	AH = 09h
	DS:DX -> '$'-terminated string
Return: AL = 24h (the '$' terminating the string, despite official docs which
		state that nothing is returned) (at least DOS 3.3-5.0)
Notes:	^C/^Break are checked, and INT 23 is called if either pressed
	standard output is always the screen under DOS 1.x, but may be
	  redirected under DOS 2+
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
SeeAlso: AH=02h,AH=06h"OUTPUT"
--------D-210A-------------------------------
INT 21 - DOS 1+ - BUFFERED INPUT
	AH = 0Ah
	DS:DX -> buffer (see #0573)
Return: buffer filled with user input
Notes:	^C/^Break are checked, and INT 23 is called if either detected
	reads from standard input, which may be redirected under DOS 2+
	if the maximum buffer size (see #0573) is set to 00h, this call returns
	  immediately without reading any input
SeeAlso: AH=0Ch,INT 2F/AX=4810h

Format of DOS input buffer:
Offset	Size	Description	(Table 0573)
 00h	BYTE	maximum characters buffer can hold
 01h	BYTE	(call) number of chars from last input which may be recalled
		(ret) number of characters actually read, excluding CR
 02h  N BYTEs	actual characters read, including the final carriage return
--------K-210A00-----------------------------
INT 21 - WCED v1.6+ - INSTALLATION CHECK
	AX = 0A00h
	DS:DX -> 6-byte buffer whose first two bytes must be 00h
Return: buffer offset 02h-05h filled with "Wced" if installed
Program: WCED is a free command-line editor and history utility by Stuart
	  Russell
SeeAlso: AH=FFh"CED"
--------D-210B-------------------------------
INT 21 - DOS 1+ - GET STDIN STATUS
	AH = 0Bh
Return: AL = status
	    00h if no character available
	    FFh if character is available
Notes:	^C/^Break are checked, and INT 23 is called if either pressed
	standard input is always the keyboard under DOS 1.x, but may be
	  redirected under DOS 2+
	if the interim console flag is set (see AX=6301h), this function
	  returns AL=FFh if a partially-formed double-byte character is
	  available
SeeAlso: AH=06h"INPUT",AX=4406h
--------v-210B56-----------------------------
INT 21 - VIRUS - "Perfume" - INSTALLATION CHECK
	AX = 0B56h
Return: AX = 4952h if resident
SeeAlso: AX=0D20h,INT 12/AX=4350h/BX=4920h,INT 13/AH=F2h
--------D-210C-------------------------------
INT 21 - DOS 1+ - FLUSH BUFFER AND READ STANDARD INPUT
	AH = 0Ch
	AL = STDIN input function to execute after flushing buffer
	other registers as appropriate for the input function
Return: as appropriate for the specified input function
Note:	if AL is not one of 01h,06h,07h,08h, or 0Ah, the buffer is flushed but
	  no input is attempted
SeeAlso: AH=01h,AH=06h"INPUT",AH=07h,AH=08h,AH=0Ah
--------D-210D-------------------------------
INT 21 - DOS 1+ - DISK RESET
	AH = 0Dh
Return: (DOS 6 only) CF clear (earlier versions preserve CF)
Notes:	This function writes all modified disk buffers to disk, but does not
	  update the directory information (that is only done when files are
	  closed or a SYNC call is issued)
SeeAlso: AX=5D01h,INT 13/AH=00h,INT 2F/AX=1120h
--------v-210D20-----------------------------
INT 21 - VIRUS - "Crazy Imp" - INSTALLATION CHECK
	AX = 0D20h
Return: AX = 1971h if resident
SeeAlso: AX=0B56h,AX=1812h,AX=2C2Ch,AH=30h/DX=ABCDh
--------D-210E-------------------------------
INT 21 - DOS 1+ - SELECT DEFAULT DRIVE
	AH = 0Eh
	DL = new default drive (00h = A:, 01h = B:, etc)
Return: AL = number of potentially valid drive letters
Notes:	under Novell NetWare, the return value is always 32, the number of
	  drives that NetWare supports
	under DOS 3.0+, the return value is the greatest of 5, the value of
	  LASTDRIVE= in CONFIG.SYS, and the number of drives actually present
	on a DOS 1.x/2.x single-floppy system, AL returns 2 since the floppy
	  may be accessed as either A: or B:
	otherwise, the return value is the highest drive actually present
	DOS 1.x supports a maximum of 16 drives, 2.x a maximum of 63 drives,
	  and 3+ a maximum of 26 drives
	under Novell DOS 7, this function returns the correct LASTDRIVE value
	  even when the undocumented LASTDRIVE=32 directive was used in
	  CONFIG.SYS
SeeAlso: AH=19h,AH=3Bh,AH=DBh
--------v-210E--DLAD-------------------------
INT 21 U - Novell DOS 7 - SDRes v27.03 - INSTALLATION CHECK
	AH = 0Eh
	DL = ADh
Return: AL = BAh if installed
Program: SDRes is the resident portion of the Search&Destroy antiviral by
	  Fifth Generation Systems, as bundled with Novell DOS 7
Note:	SDRes will terminate programs which test for the presence of viruses
	  using interrupt-based installation calls, saying that the program
	  may be infected
SeeAlso: AH=0Eh/DL=AEh,AH=0Eh/DL=AFh,AH=4Ah/BX=00B6h,INT 13/AX=A759h
--------v-210E--DLAE-------------------------
INT 21 U - Novell DOS 7 - SDRes v27.03 - CLEAR ??? FLAG
	AH = 0Eh
	DL = AEh
SeeAlso: AH=0Eh/DL=ADh,AH=0Eh/DL=AFh,INT 13/AX=A759h
--------v-210E--DLAF-------------------------
INT 21 U - Novell DOS 7 - SDRes v27.03 - SET ??? FLAG
	AH = 0Eh
	DL = AFh
SeeAlso: AH=0Eh/DL=ADh,AH=0Eh/DL=AEh,INT 13/AX=A759h
--------D-210F-------------------------------
INT 21 - DOS 1+ - OPEN FILE USING FCB
	AH = 0Fh
	DS:DX -> unopened File Control Block (see #0574)
Return: AL = status
	    00h successful
	    FFh file not found or access denied
Notes:	(DOS 3.1+) file opened for read/write in compatibility mode
	an unopened FCB has the drive, filename, and extension fields filled
	  in and all other bytes cleared
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
	DR-DOS checks password attached with AX=4303h
BUG:	APPEND for DOS 3.3+ corrupts DX if the file is not found
SeeAlso: AH=10h,AH=16h,AH=3Dh,AX=4303h

Format of File Control Block:
Offset	Size	Description	(Table 0574)
 -7	BYTE	extended FCB if FFh
 -6   5 BYTEs	reserved
 -1	BYTE	file attribute if extended FCB
 00h	BYTE	drive number (0 = default, 1 = A, etc)
 01h  8 BYTEs	blank-padded file name
 09h  3 BYTEs	blank-padded file extension
 0Ch	WORD	current block number
 0Eh	WORD	logical record size
 10h	DWORD	file size
 14h	WORD	date of last write (see #0877 at AX=5700h)
 16h	WORD	time of last write (see #0876 at AX=5700h) (DOS 1.1+)
 18h  8 BYTEs	reserved (see #0575,#0576,#0577,#0578,#0579)
 20h	BYTE	record within current block
 21h	DWORD	random access record number (if record size is > 64 bytes, high
		  byte is omitted)
Note:	to use an extended FCB, you must specify the address of the FFh flag at
	  offset -7, rather than the address of the drive number field

Format of FCB reserved field for DOS 1.0:
Offset	Size	Description	(Table 0575)
 16h	WORD	location in directory (if high byte = FFh, low byte is device
		  ID)
 18h	WORD	number of first cluster in file
 1Ah	WORD	current absolute cluster number on disk
 1Ch	WORD	current relative cluster number within file
		(0 = first cluster of file, 1 = second cluster, etc.)
 1Eh	BYTE	dirty flag (00h = not dirty)
 1Fh	BYTE	unused

Format of FCB reserved field for DOS 1.10-1.25:
Offset	Size	Description	(Table 0576)
 18h	BYTE	bit 7: set if logical device
		bit 6: not dirty
		bits 5-0: disk number or logical device ID
 19h	WORD	starting cluster number on disk
 1Bh	WORD	current absolute cluster number on disk
 1Dh	WORD	current relative cluster number within file
 1Fh	BYTE	unused

Format of FCB reserved field for DOS 2.x:
Offset	Size	Description	(Table 0577)
 18h	BYTE	bit 7: set if logical device
		bit 6: set if open???
		bits 5-0: ???
 19h	WORD	starting cluster number on disk
 1Bh	WORD	???
 1Dh	BYTE	???
 1Eh	BYTE	???
 1Fh	BYTE	???

Format of FCB reserved field for DOS 3.x:
Offset	Size	Description	(Table 0578)
 18h	BYTE	number of system file table entry for file
 19h	BYTE	attributes
		bits 7,6: 00 = SHARE.EXE not loaded, disk file
			  01 = SHARE.EXE not loaded, character device
			  10 = SHARE.EXE loaded, remote file
			  11 = SHARE.EXE loaded, local file or device
		bits 5-0: low six bits of device attribute word
---SHARE.EXE loaded, local file---
 1Ah	WORD	starting cluster of file on disk
 1Ch	WORD	(DOS 3.x) offset within SHARE of sharing record
		  (see #0849 at AH=52h)
 1Eh	BYTE	file attribute
 1Fh	BYTE	???
---SHARE.EXE loaded, remote file---
 1Ah	WORD	number of sector containing directory entry
 1Ch	WORD	relative cluster within file of last cluster accessed
 1Eh	BYTE	absolute cluster number of last cluster accessed
 1Fh	BYTE	???
---SHARE.EXE not loaded---
 1Ah	BYTE	(low byte of device attribute word AND 0Ch) OR open mode
 1Bh	WORD	starting cluster of file
 1Dh	WORD	number of sector containing directory entry
 1Fh	BYTE	number of directory entry within sector
Note:	if FCB opened on character device, DWORD at 1Ah is set to the address
	  of the device driver header, then the BYTE at 1Ah is overwritten.

Format of FCB reserved field for DOS 5.0:
Offset	Size	Description	(Table 0579)
 18h	BYTE	number of system file table entry for file
 19h	BYTE	attributes
		bits 7,6: 00 = SHARE.EXE not loaded, disk file
			  01 = SHARE.EXE not loaded, character device
			  10 = SHARE.EXE loaded, remote file
			  11 = SHARE.EXE loaded, local file or device
		bits 5-0: low six bits of device attribute word
---SHARE.EXE loaded, local file---
 1Ah	WORD	starting cluster of file on disk
 1Ch	WORD	unique sequence number of sharing record
 1Eh	BYTE	file attributes
 1Fh	BYTE	unused???
---SHARE.EXE loaded, remote file---
 1Ah	WORD	network handle
 1Ch	DWORD	network ID
---SHARE not loaded, local device---
 1Ah	DWORD	pointer to device driver header
 1Eh  2 BYTEs	unused???
---SHARE not loaded, local file---
 1Ah	BYTE	extra info
		bit 7: read-only attribute from SFT
		bit 6: archive attribute from SFT
		bits 5-0: high bits of sector number
 1Bh	WORD	starting cluster of file
 1Dh	WORD	low word of sector number containing directory entry
 1Fh	BYTE	number of directory entry within sector
--------D-2110-------------------------------
INT 21 - DOS 1+ - CLOSE FILE USING FCB
	AH = 10h
	DS:DX -> File Control Block (see #0574)
Return: AL = status
	    00h successful
	    FFh failed
Notes:	a successful close forces all disk buffers used by the file to be
	  written and the directory entry to be updated
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=0Fh,AH=16h,AH=3Eh
--------D-2111-------------------------------
INT 21 - DOS 1+ - FIND FIRST MATCHING FILE USING FCB
	AH = 11h
	DS:DX -> unopened FCB (see #0574), may contain '?' wildcards
Return: AL = status
	    00h successful
		[DTA] unopened FCB for first matching file
	    FFh no matching filename, or bad FCB
Notes:	the type of the returned FCB depends on whether the input FCB was a
	  normal or an extended FCB
	the data returned in the DTA is actually the drive number (or extended
	  FCB header and drive number) followed by the file's directory entry
	  (see #0580); this format happens to be compatible with an unopened
	  FCB
	for extended FCBs with search attribute 08h, the volume label (if any)
	  will be returned even if the current directory is not the root dir.
	DOS 3.0+ also allows the '*' wildcard
	the search FCB must not be modified if AH=12h will be used to continue
	  searching; DOS 3.3 has set the following parts of the FCB:
		 0Ch	BYTE	???
		 0Dh	WORD	directory entry number of matching file
		 0Fh	WORD	cluster number of current directory
		 11h  4 BYTEs	???
		 15h	BYTE	drive number (1=A:)
	this function is used by many copy protection schemes to obtain the
	  starting cluster of a file
SeeAlso: AH=12h,AH=1Ah,AH=4Eh,INT 2F/AX=111Bh

Format of DOS directory entry:
Offset	Size	Description	(Table 0580)
 00h  8 BYTEs	blank-padded filename
 08h  3 BYTEs	blank-padded file extension
 0Bh	BYTE	attributes
 0Ch 10 BYTEs	reserved
		used by DR-DOS to store file password
 16h	WORD	time of creation or last update (see #0876 at AX=5700h)
 18h	WORD	date of creation or last update (see #0877 at AX=5700h)
 1Ah	WORD	starting cluster number
 1Ch	DWORD	file size
--------D-2112-------------------------------
INT 21 - DOS 1+ - FIND NEXT MATCHING FILE USING FCB
	AH = 12h
	DS:DX -> unopened FCB (see #0574)
Return: AL = status
	    00h successful
		[DTA] = unopened FCB
	    FFh no more matching filenames
Note:	(see AH=11h)
	assumes that successful FindFirst executed on search FCB before call
SeeAlso: AH=1Ah,AH=4Fh,INT 2F/AX=111Ch
--------D-2113-------------------------------
INT 21 - DOS 1+ - DELETE FILE USING FCB
	AH = 13h
	DS:DX -> unopened FCB (see #0574), filename filled with template for
		deletion ('?' wildcards allowed)
Return: AL = status
	    00h one or more files successfully deleted
	    FFh no matching files or all were read-only or locked
Notes:	DOS 1.25+ deletes everything in the current directory (including
	  subdirectories) and sets the first byte of the name to 00h (entry
	  never used) instead of E5h if called on an extended FCB with
	  filename '???????????' and bits 0-4 of the attribute set (bits 1 and
	  2 for DOS 1.x).  This may have originally been an optimization to
	  minimize directory searching after a mass deletion (DOS 1.25+ stop
	  the directory search upon encountering a never-used entry), but can
	  corrupt the filesystem under DOS 2+ because subdirectories are
	  removed without deleting the files they contain.
	currently-open files should not be deleted
	MS-DOS allows deletion of read-only files with an extended FCB, whereas
	  Novell NetWare, DR-DOS 6, and Novell DOS 7 do not
SeeAlso: AH=41h,INT 2F/AX=1113h
--------D-2114-------------------------------
INT 21 - DOS 1+ - SEQUENTIAL READ FROM FCB FILE
	AH = 14h
	DS:DX -> opened FCB (see #0574)
Return: AL = status
	    00h successful
	    01h end of file (no data)
	    02h segment wrap in DTA
	    03h end of file, partial record read
	[DTA] = record read from file
Notes:	reads a record of the size specified in the FCB beginning at the
	  current file position, then updates the current block and current
	  record fields in the FCB
	if a partial record was read, it is zero-padded to the full size
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=0Fh,AH=15h,AH=1Ah,AH=3Fh,INT 2F/AX=1108h
--------D-2115-------------------------------
INT 21 - DOS 1+ - SEQUENTIAL WRITE TO FCB FILE
	AH = 15h
	DS:DX -> opened FCB (see #0574)
	[DTA] = record to write
Return: AL = status
	    00h successful
	    01h disk full
	    02h segment wrap in DTA
Notes:	writes a record of the size specified in the FCB beginning at the
	  current file position, then updates the current block and current
	  record fields in the FCB
	if less than a full sector is written, the data is placed in a DOS
	  buffer to be written out at a later time
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=0Fh,AH=14h,AH=1Ah,AH=40h,INT 2F/AX=1109h
--------D-2116-------------------------------
INT 21 - DOS 1+ - CREATE OR TRUNCATE FILE USING FCB
	AH = 16h
	DS:DX -> unopened FCB (see #0574), wildcards not allowed
Return: AL = status
	    00h successful
	    FFh directory full or file exists and is read-only or locked
Notes:	if file already exists, it is truncated to zero length
	if an extended FCB is used, the file is given the attribute in the
	  FCB; this is how to create a volume label in the disk's root dir
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=0Fh,AH=10h,AH=3Ch
--------D-2117-------------------------------
INT 21 - DOS 1+ - RENAME FILE USING FCB
	AH = 17h
	DS:DX -> modified FCB (see also #0574)
		the old filename ('?' wildcards OK) is in the standard location
		while the new filename ('?' wildcards OK, no drive) is stored
		in the 11 bytes beginning at offset 11h
Return: AL = status
	    00h successfully renamed
	    FFh no matching files,file is read-only, or new name already exists
Notes:	subdirectories may be renamed using an extended FCB with the
	  appropriate attribute, as may volume labels
	DR-DOS checks password attached with AX=4303h before permitting rename
SeeAlso: AH=0Fh,AH=13h,AX=4303h,AH=56h,INT 2F/AX=1111h
--------D-2118-------------------------------
INT 21 - DOS 1+ - NULL FUNCTION FOR CP/M COMPATIBILITY
	AH = 18h
Return: AL = 00h
Note:	corresponds to the CP/M BDOS function "get bit map of logged drives",
	  which is meaningless under MS-DOS
SeeAlso: AH=1Dh,AH=1Eh,AH=20h,AX=4459h,INT 60/DI=0513h
--------v-211812------------------------
INT 21 - VIRUS - "Tasha Yar" - INSTALLATION CHECK
	AX = 1812h
Return: AL = 00h if resident
	DX = 4310h if resident
SeeAlso: INT 16/AH=DDh"VIRUS",INT 21/AX=2C2Ch"VIRUS"
--------D-2119-------------------------------
INT 21 - DOS 1+ - GET CURRENT DEFAULT DRIVE
	AH = 19h
Return: AL = drive (00h = A:, 01h = B:, etc)
Note:	Novell NetWare uses the fact that DOS 2.x COMMAND.COM issues this call
	  from a particular location every time it starts a command to
	  determine when to issue an automatic EOJ
SeeAlso: AH=0Eh,AH=47h,AH=BBh
--------D-211A-------------------------------
INT 21 - DOS 1+ - SET DISK TRANSFER AREA ADDRESS
	AH = 1Ah
	DS:DX -> Disk Transfer Area (DTA)
Notes:	the DTA is set to PSP:0080h when a program is started
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
SeeAlso: AH=11h,AH=12h,AH=2Fh,AH=4Eh,AH=4Fh
--------D-211B-------------------------------
INT 21 - DOS 1+ - GET ALLOCATION INFORMATION FOR DEFAULT DRIVE
	AH = 1Bh
Return: AL = sectors per cluster (allocation unit)
	CX = bytes per sector
	DX = total number of clusters
	DS:BX -> media ID byte (see #0581)
Note:	under DOS 1.x, DS:BX points at an actual copy of the FAT; later
	  versions return a pointer to a copy of the FAT's ID byte
SeeAlso: AH=1Ch,AH=36h

(Table 0581)
Values for media ID byte:
 FFh	floppy, double-sided, 8 sectors per track (320K)
 FEh	floppy, single-sided, 8 sectors per track (160K)
 FDh	floppy, double-sided, 9 sectors per track (360K)
 FCh	floppy, single-sided, 9 sectors per track (180K)
 FAh	HP 200LX D: ROM disk, 16 sectors per track (995K)
	HP 200LX E: (Stacker host drive ???)
 F9h	floppy, double-sided, 15 sectors per track (1.2M)
	floppy, double-sided, 9 sectors per track (720K,3.5")
 F8h	hard disk
 F0h	other media
	(e.g. floppy, double-sized, 18 sectors per track -- 1.44M,3.5")
--------D-211C-------------------------------
INT 21 - DOS 1+ - GET ALLOCATION INFORMATION FOR SPECIFIC DRIVE
	AH = 1Ch
	DL = drive (00h = default, 01h = A:, etc)
Return: AL = sectors per cluster (allocation unit), or FFh if invalid drive
	CX = bytes per sector
	DX = total number of clusters
	DS:BX -> media ID byte (see #0581)
Notes:	under DOS 1.x, DS:BX points at an actual copy of the FAT; later
	  versions return a pointer to a copy of the FAT's ID byte
	on a DBLSPACE drive, the total number of clusters is based on the
	  estimated compression ratio
SeeAlso: AH=1Bh,AH=36h
--------D-211D-------------------------------
INT 21 - DOS 1+ - NULL FUNCTION FOR CP/M COMPATIBILITY
	AH = 1Dh
Return: AL = 00h
Note:	corresponds to the CP/M BDOS function "get bit map of read-only
	  drives", which is meaningless under MS-DOS
SeeAlso: AH=18h,AH=1Eh,AH=20h,AX=4459h
--------D-211E-------------------------------
INT 21 - DOS 1+ - NULL FUNCTION FOR CP/M COMPATIBILITY
	AH = 1Eh
Return: AL = 00h
Note:	corresponds to the CP/M BDOS function "set file attributes" which was
	 meaningless under MS-DOS 1.x
SeeAlso: AH=18h,AH=1Dh,AH=20h
--------D-211F-------------------------------
INT 21 - DOS 1+ - GET DRIVE PARAMETER BLOCK FOR DEFAULT DRIVE
	AH = 1Fh
Return: AL = status
	    00h successful
		DS:BX -> Drive Parameter Block (DPB) (see #0582 for DOS 1.x,
			AH=32h for DOS 2+)
	    FFh invalid drive
Note:	this call was undocumented prior to the release of DOS 5.0; however,
	  only the DOS 4.0+ version of the DPB has been documented
SeeAlso: AH=32h

Format of DOS 1.1 and MS-DOS 1.25 drive parameter block:
Offset	Size	Description	(Table 0582)
 00h	BYTE	sequential device ID
 01h	BYTE	logical drive number (0=A:)
 02h	WORD	bytes per sector
 04h	BYTE	highest sector number within a cluster
 05h	BYTE	shift count to convert clusters into sectors
 06h	WORD	starting sector number of first FAT
 08h	BYTE	number of copies of FAT
 09h	WORD	number of directory entries
 0Bh	WORD	number of first data sector
 0Dh	WORD	highest cluster number (number of data clusters + 1)
 0Fh	BYTE	sectors per FAT
 10h	WORD	starting sector of directory
 12h	WORD	address of allocation table
Note:	the DOS 1.0 table is the same except that the first and last fields
	  are missing; see INT 21/AH=32h for the DOS 2+ version
--------D-2120-------------------------------
INT 21 - DOS 1+ - NULL FUNCTION FOR CP/M COMPATIBILITY
	AH = 20h
Return: AL = 00h
Note:	corresponds to the CP/M BDOS function "get/set default user
	  (sublibrary) number", which is meaningless under MS-DOS
SeeAlso: AH=18h,AH=1Dh,AH=1Eh,AX=4459h
--------D-2121-------------------------------
INT 21 - DOS 1+ - READ RANDOM RECORD FROM FCB FILE
	AH = 21h
	DS:DX -> opened FCB (see #0574)
Return: AL = status
	    00h successful
	    01h end of file, no data read
	    02h segment wrap in DTA, no data read
	    03h end of file, partial record read
	[DTA] = record read from file
Notes:	the record is read from the current file position as specified by the
	  random record and record size fields of the FCB
	the file position is not updated after reading the record
	if a partial record is read, it is zero-padded to the full size
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=14h,AH=22h,AH=27h,AH=3Fh
--------D-2122-------------------------------
INT 21 - DOS 1+ - WRITE RANDOM RECORD TO FCB FILE
	AH = 22h
	DS:DX -> opened FCB (see #0574)
	[DTA] = record to write
Return: AL = status
	    00h successful
	    01h disk full
	    02h segment wrap in DTA
Notes:	the record is written to the current file position as specified by the
	  random record and record size fields of the FCB
	the file position is not updated after writing the record
	if the record is located beyond the end of the file, the file is
	  extended but the intervening data remains uninitialized
	if the record only partially fills a disk sector, it is copied to a
	  DOS disk buffer to be written out to disk at a later time
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=15h,AH=21h,AH=28h,AH=40h
--------D-2123-------------------------------
INT 21 - DOS 1+ - GET FILE SIZE FOR FCB
	AH = 23h
	DS:DX -> unopened FCB (see #0574), wildcards not allowed
Return: AL = status
	    00h successful (matching file found)
		FCB random record field filled with size in records, rounded up
		to next full record
	    FFh failed (no matching file found)
Notes:	not supported by MS Windows 3.0 DOSX.EXE DOS extender
	MS-DOS returns nonsense if the FCB record number field is set to a very
	  large positive number, and status FFh if negative; DR-DOS returns the
	  correct file size in both cases
BUG:	APPEND for DOS 3.3+ corrupts DX if the file is not found
SeeAlso: AH=42h
--------D-2124-------------------------------
INT 21 - DOS 1+ - SET RANDOM RECORD NUMBER FOR FCB
	AH = 24h
	DS:DX -> opened FCB (see #0574)
Notes:	computes the random record number corresponding to the current record
	  number and record size, then stores the result in the FCB
	normally used when switching from sequential to random access
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=21h,AH=27h,AH=42h
--------D-2125-------------------------------
INT 21 - DOS 1+ - SET INTERRUPT VECTOR
	AH = 25h
	AL = interrupt number
	DS:DX -> new interrupt handler
Notes:	this function is preferred over direct modification of the interrupt
	  vector table
	some DOS extenders place an API on this function, as it is not
	  directly meaningful in protected mode
	under DR-DOS 5.0+, this function does not use any of the DOS-internal
	  stacks and may thus be called at any time
	Novell NetWare (except the new DOS Requester) monitors the offset of
	  any INT 24 set, and if equal to the value at startup, substitutes
	  its own handler to allow handling of network errors; this introduces
	  the potential bug that any program whose INT 24 handler offset
	  happens to be the same as COMMAND.COM's will not have its INT 24
	  handler installed
SeeAlso: AX=2501h,AH=35h
--------E-212501-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - RESET DOS EXTENDER DATA STRUCTURES
	AX = 2501h
	SS = application's original SS or DS (FlashTek X-32VM)
Return: CF clear if successful
	CF set on error
	    caller is operating on X-32 stack (FlashTek X-32VM)
Notes:	Phar Lap uses INT 21/AH=25h as the entry point for all 386/DOS-Extender
	  system calls.	 Only available when directly using 386/DOS-Extender or
	  a compatible DOS extender, or when using a product that was created
	  using 386-DOS/Extender or a compatible
	this function is also supported by FlashTek X-32VM
SeeAlso: AH=30h"Phar Lap"
--------E-212502-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET PROTECTED-MODE INTERRUPT VECTOR
	AX = 2502h
	CL = interrupt number
Return: CF clear
	ES:EBX = CS:EIP of protected-mode interrupt handler
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2503h,AX=2504h,INT 31/AX=0204h
--------E-212503-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET REAL-MODE INTERRUPT VECTOR
	AX = 2503h
	CL = interrupt number
Return: CF clear
	EBX = CS:IP of real-mode interrupt handler
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2502h,AX=2504h,AH=35h,INT 31/AX=0200h
--------E-212504-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - SET PROTECTED-MODE INTERRUPT VECTOR
	AX = 2504h
	CL = interrupt number
	DS:EDX = CS:EIP of protected-mode interrupt handler
Return: CF clear
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2502h,AX=2505h,INT 31/AX=0205h
--------E-212505-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - SET REAL-MODE INTERRUPT VECTOR
	AX = 2505h
	CL = interrupt number
	EBX = CS:IP of real-mode interrupt handler
Return: CF clear
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2503h,AX=2504h,INT 31/AX=0201h
--------E-212506-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - SET INT TO ALWAYS GAIN CNTRL IN PR. MODE
	AX = 2506h
	CL = interrupt number
	DS:EDX = CS:EIP of protected-mode interrupt handler
Return: CF clear
Notes:	this function modifies both the real-mode low-memory interrupt
	  vector table and the protected-mode Interrupt Descriptor Table (IDT)
	interrupts occurring in real mode are resignaled in protected mode
	this function is also supported by FlashTek X-32VM
--------E-212507-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - SET REAL- & PROTECTED-MODE INT VECTORS
	AX = 2507h
	CL = interrupt number
	DS:EDX = CS:EIP of protected-mode interrupt handler
	EBX = CS:IP of real-mode interrupt handler
Return: CF clear
Notes:	interrupts are disabled until both vectors have been modified
	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2504h,AX=2505h
--------E-212508-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET SEGMENT LINEAR BASE ADDRESS
	AX = 2508h
	BX = segment selector
Return: CF clear if successful
	    ECX = linear base address of segment
	CF set if invalid segment selector
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2509h
--------E-212509-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - CONVERT LINEAR TO PHYSICAL ADDRESS
	AX = 2509h
	EBX = linear address to convert
Return: CF clear if successful
	    ECX = physical address (carry flag clear)
	CF set if linear address not mapped in page tables
SeeAlso: AX=2508h
--------E-212509-----------------------------
INT 21 P - FlashTek X-32VM - GET SYSTEM SEGMENTS AND SELECTORS
	AX = 2509h
Return: CF clear
	EAX high word = default DS
	AX = alias for 16-bit data segment
	BX = real mode code segment
	EDX high word = selector covering full 4GB address space
	DX = default SS
	ESI high word = PSP selector
	SI = environment selector
--------E-21250A-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - MAP PHYSICAL MEMORY AT END OF SEGMENT
	AX = 250Ah
	ES = segment selector in the Local Descriptor Table (LDT) of segment
	     to modify
	EBX = physical base address of memory to map (multiple of 4K)
	ECX = number of physical 4K pages to map
Return: CF clear if successful
	    EAX = 32-bit offset in segment of mapped memory
	CF set on error
	    EAX = error code
		08h insufficient memory to create page tables
		09h invalid segment selector
SeeAlso: INT 31/AX=0800h
--------E-21250C-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET HARDWARE INTERRUPT VECTORS
	AX = 250Ch
Return: CF clear
	AL = base interrupt vector for IRQ0-IRQ7
	AH = base interrupt vector for IRQ8-IRQ15
	BL = interrupt vector for BIOS print screen function (Phar Lap only)
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: INT 31/AX=0400h,INT 67/AX=DE0Ah
--------E-21250D-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET REAL-MODE LINK INFORMATION
	AX = 250Dh
Return: CF clear
	EAX = CS:IP of real-mode callback procedure (see #0583) that will
		  call through from real mode to a protected-mode routine
	EBX = 32-bit real-mode address of intermode call data buffer
	ECX = size in bytes of intermode call data buffer
	ES:EDX = protected-mode address of intermode call data buffer
Notes:	this function is also supported by FlashTek X-32VM
	X-32VM guarantees the intermode buffer to be at least 4 KB
SeeAlso: AX=250Eh

(Table 0583)
Call Phar Lap real-mode callback with:
	STACK:	DWORD	offset to protected-mode code
		WORD	placeholder for protected-mode CS
		DWORD	pointer to selector structure (see #0584)
			or 0000h:0000h for defaults
		var	parameters for protected-mode procedure
Return: via FAR return

Format of Phar Lap selector structure:
Offset	Size	Description	(Table 0584)
 00h	WORD	protected-mode GS selector
 02h	WORD	protected-mode FS selector
 04h	WORD	protected-mode ES selector
 06h	WORD	protected-mode DS selector
--------E-21250E-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - CALL REAL-MODE PROCEDURE
	AX = 250Eh
	EBX = CS:IP of real-mode procedure to call
	ECX = number of two-byte words to copy from protected-mode stack
	      to real-mode stack
Return: CF clear if successful
	    all segment registers unchanged
	    all general registers contain values set by real-mode procedure
	    all other flags set as they were left by real-mode procedure
	    stack unchanged
	CF set on error
	    EAX = error code
		01h not enough real-mode stack space
Note:	this function is also supported by FlashTek X-32VM; under X-32VM, the
	  call will fail if ECX > 0000003Fh
SeeAlso: AX=250Dh,AX=2510h,AH=E1h"OS/286",INT 31/AX=0301h
--------E-21250F-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - CONVERT PROTECTED-MODE ADDRESS TO MS-DOS
	AX = 250Fh
	ES:EBX = 48-bit protected-mode address to convert
	ECX = 00000000h or length of data in bytes
Return: CF clear if successful (address < 1MB and contiguous)
	    ECX = 32-bit real-mode MS-DOS address
	CF set on error (address >= 1MB or not contiguous)
	    ECX = linear address
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2510h
--------E-212510-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - CALL REAL-MODE PROCEDURE, REGISTERS
	AX = 2510h
	EBX = CS:IP of real-mode procedure to call
	ECX = number of two-byte words to copy to protected-mode stack to
	      real-mode stack
	DS:EDX -> pointer to parameter block (see #0585)
Return: CF clear if successful
	    all segment registers unchanged,
	    EDX unchanged
	    all other general registers contain values set by real-mode proc
	    all other flags are set as they were left by real-mode procedure
	    real-mode register values are returned in the parameter block
	CF set on error
	    EAX = error code
		01h not enough real-mode stack space
Note:	unlike most of the preceding 25xxh functions, this one is not
	  supported by FlashTek X-32VM
SeeAlso: AX=250Eh,AX=250Fh

Format of Phar Lap real-mode call parameter block:
Offset	Size	Description	(Table 0585)
 00h	WORD	real-mode DS value
 02h	WORD	real-mode ES value
 04h	WORD	real-mode FS value
 06h	WORD	real-mode GS value
 08h	DWORD	real-mode EAX value
 0Ch	DWORD	real-mode EBX value
 10h	DWORD	real-mode ECX value
 14h	DWORD	real-mode EDX value
--------E-212511-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - ISSUE REAL-MODE INTERRUPT
	AX = 2511h
	DS:EDX -> parameter block (see #0586)
Return: all segment registers unchanged
	EDX unchanged
	all other registers contain values set by the real-mode int handler
	the flags are set as they were left by the real-mode interrupt handler
	real-mode register values are returned in the parameter block
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2503h,AX=2505h,AX=250Eh,AH=E3h"OS/286",INT 31/AX=0300h

Format of Phar Lap real-mode interrupt parameter block:
Offset	Size	Description	(Table 0586)
 00h	WORD	interrupt number
 02h	WORD	real-mode DS value
 04h	WORD	real-mode ES value
 06h	WORD	real-mode FS value
 08h	WORD	real-mode GS value
 0Ah	DWORD	real-mode EAX value
 0Eh	DWORD	real-mode EDX value
Note: all other real-mode values set from protected-mode registers
--------E-212512-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - LOAD PROGRAM FOR DEBUGGING
	AX = 2512h
	DS:EDX -> pointer to ASCIZ program name
	ES:EBX -> pointer to parameter block (see #0588)
	ECX = size in bytes of LDT buffer
Return: CF clear if successful
	    EAX = number of segment descriptors in LDT
	CF set on error
	    EAX = error code (see #0587)
SeeAlso: AX=2517h

(Table 0587)
Values for Phar Lap error code:
 02h	file not found or path invalid
 05h	access denied
 08h	insufficient memory
 0Ah	environment invalid
 0Bh	invalid file format
 80h	LDT too small

Format of Phar Lap program load parameter block:
Offset	Size	Description	(Table 0588)
Input:
 00h	DWORD	32-bit offset of environment string
 04h	WORD	segment of environment string
 06h	DWORD	32-bit offset of command-tail string
 0Ah	WORD	segment of command-tail string
 0Ch	DWORD	32-bit offset of LDT buffer (size in ECX)
 10h	WORD	segment of LDT buffer
Output:
 12h	WORD	real-mode paragraph address of PSP (see also AH=26h)
 14h	WORD	real/protected mode flag
		0000h  real mode
		0001h  protected mode
 16h	DWORD	initial EIP value
 1Ah	WORD	initial CS value
 1Ch	DWORD	initial ESP value
 20h	WORD	initial SS value
 22h	WORD	initial DS value
 24h	WORD	initial ES value
 26h	WORD	initial FS value
 28h	WORD	initial GS value
--------E-212513-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - ALIAS SEGMENT DESCRIPTOR
	AX = 2513h
	BX = segment selector of descriptor in GDT or LDT
	CL = access-rights byte for alias descriptor
	CH = use-type bit (USE16 or USE32) for alias descriptor
Return: CF clear if successful
	    AX = segment selector for created alias
	CF set on error
	    EAX = error code
		08h insufficient memory (can't grow LDT)
		09h invalid segment selector in BX
--------E-212514-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - CHANGE SEGMENT ATTRIBUTES
	AX = 2514h
	BX = segment selector of descriptor in GDT or LDT
	CL = new access-rights byte
	CH = new use-type bit (USE16 or USE32)
Return: CF clear if successful
	CF set on error
	    EAX = error code
		09h invalid selector in BX
SeeAlso: AX=2515h,INT 31/AX=0009h
--------E-212515-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET SEGMENT ATTRIBUTES
	AX = 2515h
	BX = segment selector of descriptor in GDT or LDT
Return: CF clear if successful
	    CL = access-rights byte for segment
	    CH = use-type bit (USE16 or USE32)
	ECX<16-31> destroyed
	CF set on error
	    EAX = error code
		09h invalid segment selector in BX
SeeAlso: AX=2514h
--------E-212516-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v2.2+ - FREE ALL MEMORY OWNED BY LDT
	AX = 2516h
Return: CF clear
Note:	this function must be called from Ring 0 or the CS descriptor is freed
--------E-212517-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v2.1c+ - GET INFO ON DOS DATA BUFFER
	AX = 2517h
Return: CF clear
	ES:EBX -> data buffer (protected mode address)
	ECX -> data buffer (real mode address)
	EDX = size of data buffer in bytes
Note:	the data buffer's address changes after calls to AX=2512h and AX=252Ah
SeeAlso: AX=2512h,AX=252Ah,AX=2530h
--------E-212518-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender 2.1c+ - SPECIFY HANDLER FOR MOVED SEGMENTS
	AX = 2518h
	ES:EBX -> function to call when a segment is moved
Return: CF clear
	ES:EBX -> previous handler
--------E-212519-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - GET ADDITIONAL MEMORY ERROR INFO
	AX = 2519h
Return: CF clear
	EAX = error code
	    0000h  no error
	    0001h  out of physical memory
	    0002h  out of swap space (unable to grow swap file)
	    0003h  out of LDT entries and unable to grow LDT
	    0004h  unable to change extended memory allocation mark
	    FFFFFFFFh	paging disabled
Note:	VMM is the Virtual Memory Manager option
--------E-21251A-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - LOCK PAGES IN MEMORY
	AX = 251Ah
	EDX = number of 4k pages to lock
	if BL = 00h
	    ECX = linear address of first page to lock
	if BL = 01h
	    ES:ECX -> pointer to first page to lock
Return: CF clear if successful
	CF set on error
	    EAX = error code
		08h insufficient memory
		09h invalid address range
SeeAlso: AX=251Bh,AX=EB06h,INT 31/AX=0600h
--------E-21251B-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - UNLOCK PAGES
	AX = 251Bh
	EDX = number of pages to unlock
	if BL = 00h
	    ECX = linear address of first page to unlock
	if BL = 01h
	    ES:ECX -> pointer to first page to unlock
Return: CF clear if successful
	CF set on error
	    EAX = error code
		09h invalid address range
SeeAlso: AX=251Ah,AX=EB07h,INT 31/AX=0601h
--------E-21251C-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM v2.1c+ - FREE PHYSICAL MEMORY PAGES
	AX = 251Ch
	BH = preservation flag (00h preserve contents, 01h discard contents)
	EDX = number of pages to free
	BL = address type
	    00h linear address
		ECX = linear address of first page to be freed
	    01h pointer
		ES:ECX -> first page to be freed
Return: CF clear if successful
	CF set on error
	    EAX = error code
		08h memory error, swap space full, no VMM or DPMI
		09h invalid address
--------E-21251D-----------------------------
INT 21 OP - Phar Lap 386/DOS-Extender VMM v2.1c - READ PAGE-TABLE ENTRY
	AX = 251Dh
	BL = address type
	    00h linear address
		ECX = linear address of page table entry to read
	    01h pointer
		ES:ECX -> page table entry to read
Return: CF clear if successful
	    EAX = contents of page table entry
	CF set on error
	    EAX = error code
		09h invalid address or NOPAGE option set
		78h invalid under DPMI
Note:	this function is obsolete; use AX=252Bh/BH=09h instead
SeeAlso: AX=251Eh,AX=252Bh/BH=09h,AX=EB00h,INT 31/AX=0506h
--------E-21251E-----------------------------
INT 21 OP - Phar Lap 386/DOS-Extender VMM v2.1c - WRITE PAGE-TABLE ENTRY
	AX = 251Eh
	BL = address type
	    00h linear address
		ECX = linear address of page table entry to read
	    01h pointer
		ES:ECX -> page table entry to read
	EDX = new value for page table entry
Return: CF clear if successful
	CF set on error
	    EAX = error code
		09h invalid address or NOPAGE option set
		82h not compatible with DPMI
Note:	this call is obsolete; use AX=252Bh/BH=0Ah instead
SeeAlso: AX=251Dh,AX=252Bh/BH=0Ah,INT 31/AX=0507h
--------E-21251F-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - EXHANGE TWO PAGE-TABLE ENTRIES
	AX = 251Fh
	BL = address type
	    00h linear address
		ECX = linear address of first page table entry
		EDX = linear address of second page table entry
	    01h pointer
		ES:ECX -> first page table entry
		ES:EDX -> second page table entry
Return: CF clear if successful
	CF set on error
	    EAX = error code
		09h invalid address or NOPAGE option set
		82h not compatible with DPMI
SeeAlso: AX=251Dh,AX=251Eh
--------E-212520-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - GET MEMORY STATISTICS
	AX = 2520h
	DS:EDX -> pointer to buffer at least 100 bytes in size (see #0589)
	BL = 0 (don't reset VM stats), 1 (reset VM stats)
Return: carry flag clear

Format of Phar Lap VM statistics buffer:
Offset	Size	Description	(Table 0589)
 00h	DWORD	VM status
		0001h VM subsystem is present
		0000h VM not present
 04h	DWORD	"nconvpg" number of conventional memory pages available
 08h	DWORD	"nbimpg" number of Compaq built-in memory pages available
 0Ch	DWORD	"nextpg" total number of extended memory pages
 10h	DWORD	"extlim" extender memory pages limit
 14h	DWORD	"aphyspg" number of physical memory pages allocated to appl
 18h	DWORD	"alockpg" number of locked pages owned by application
 1Ch	DWORD	"sysphyspg" number physical memory pages allocated to system
 20h	DWORD	"nfreepg" number of free physical pages; approx if EMS VCPI
 24h	DWORD	linear address of beginning of application address space
 28h	DWORD	linear address of end of application address space
 2Ch	DWORD	number of seconds since last time VM stats were reset
 30h	DWORD	number of page faults since last time
 34h	DWORD	number of pages written to swap file since last time
 38h	DWORD	number of reclaimed pages (page faults on swapped pages)
 3Ch	DWORD	number of virtual pages allocated to the application
 40h	DWORD	size in pages of swap file
 44h	DWORD	number of system pages allocated with EMS calls
 48h	DWORD	minimum number of conventional memory pages
 4Ch	DWORD	maximum size in pages to which swap file can be increased
 50h	DWORD	"vmflags"
		bit 0 = 1 if page fault in progress
---v4.0+ ---
 54h	DWORD	number of physical pages guaranteed to be free
 58h	DWORD	number of free physical pages currently available
 5Ch	DWORD	size in pages of largest free block of memory (including disk
		  swap space)
 60h	DWORD	reserved
--------E-212521-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - LIMIT PROGRAM'S EXTENDED MEM USAGE
	AX = 2521h
	EBX = max 4k pages of physical extended memory which program may use
Return: CF clear if successful
	   EBX = maximum limit in pages
	   ECX = minimum limit in pages
	CF set on error
	    EAX = error code
		08h insufficient memory or -nopage switch used
SeeAlso: AX=2522h
--------E-212522-----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v2.2+ - SPECIFY ALTERNATE PAGE-FAULT HANDLR
	AX = 2522h
	ES:EBX -> alternate handler for page faults
Return: CF clear
	ES:EBX -> previous page-fault handler
SeeAlso: AX=2523h
--------E-212523-----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v2.2+ - SPECIFY OUT-OF-SWAP-SPACE HANDLER
	AX = 2523h
	???
Return: ???
Note:	this function takes a DWORD pointer and a DWORD pointer to a DWORD
	  pointer as arguments
SeeAlso: AX=2522h
--------E-212524-----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v2.2+ - INSTALL PAGE-REPLACEMENT HANDLERS
	AX = 2524h
	???
Return: ???
Note:	this function takes three DWORD pointers and three DWORD pointers to
	  DWORD pointers as arguments
--------E-212525-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - LIMIT PROGRAM'S CONVENT'L MEM USAGE
	AX = 2525h
	EBX = limit in 4k pages of physical conventional memory which program
	      may use
Return: CF clear if successful
	    EBX = maximum limit in pages
	    ECX = minimum limit in pages
	CF set on error
	    EAX = error code
		08h insufficient memory or -nopage switch used
SeeAlso: AX=2521h
--------E-212526-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET CONFIGURATION INFORMATION
	AX = 2526h
	???
Return: ???
Notes:	details are not yet available
	this function takes a pointer to the configuration buffer (see #0590)
	  and a poitner to a BYTE as arguments

Format of Phar Lap configuration buffer:
Offset	Size	Description	(Table 0590)
 00h	DWORD	flags 1 (see #0591)
 04h	DWORD	flags 2 (unused through v5.0)
 08h	DWORD	flags 3 (unused through v5.0)
 0Ch	DWORD	386|DOS-Extender major version
 10h	DWORD	386|DOS-Extender minor version
 14h	DWORD	first letter of text after minor version number in version str
 18h	DWORD	beta flag (00h normal release, 01h beta release)
 1Ch	DWORD	processor (3 = 386, 4 = 486)
 20h	DWORD	coprocessor (4 = none, 6 = 287, 7 = 387/486)
 24h	DWORD	Weitek coprocessor flag (0 = none, 1 = present)
 28h	DWORD	machine type (0 = IBM PC compatible, 1 = NEC 9800 series)
 2Ch	DWORD	machine class
		IBM: bus type (0=ISA, 1=MCA, 2=XT, 3=EISA)
		NEC: 0=normal mode, 1=high-res mode
 30h	DWORD	VCPI flag (0 = none, 1 = present)
 34h	DWORD	-WEITEK/-1167 switch (0 = AUTO, 1 = ON, 2 = OFF)
 38h	DWORD	-MINREAL setting
 3Ch	DWORD	-MAXREAL setting
 40h	DWORD	-MINIBUF setting
 44h	DWORD	-MAXIBUF setting
 48h	DWORD	size in bytes of DOS call data buffer
 4Ch	DWORD	number of interrupt stacks (-NISTACK)
 50h	DWORD	interrupt stack size (-ISTKSIZE)
 54h	DWORD	-REALBREAK setting
 58h	DWORD	-CALLBUFS
 5Ch	DWORD	-HWIVEC
 60h	DWORD	-PRIVEC
 64h	DWORD	-INTMAP
 68h	DWORD	-PRIMAP
 6Ch	DWORD	VCPI: master 8259 interrupt vector base (IRQ0 mapping)
 70h	DWORD	VCPI: slave 8259 interrupt vector base (IRQ8 mapping)
 74h	DWORD	BIOS print screen interrupt vector (0 if NEC)
 78h	DWORD	-EXTLOW setting
 7Ch	DWORD	-EXTHIGH setting
 80h	DWORD	lowest physical extended-memory address allocatable
 84h	DWORD	highest physical extended-memory address allocatable + 1
 88h	DWORD	special memory's physical base address (00000000h if none)
 8Ch	DWORD	special memory size in bytes (00000000h if none)
 90h	DWORD	-MAXVCPIMEM setting
 94h	DWORD	-VSCAN
 98h	DWORD	-SWAPCHK (0 = OFF, 1 = ON, 2 = FORCE, 3 = MAX)
 9Ch	DWORD	-CODESIZE setting
 A0h	DWORD	minimum swap file size (-MINSWFSIZE)
 A4h	DWORD	maximum swap fiel size (-MAXSWFSIZE)
 A8h	DWORD	page replacement policy (0 = LFU, 1 = NUR)
 ACh	DWORD	number of GDT entries (-NGDTENT)
 B0h	DWORD	number of LDT entries (-NLDTENT)
 B4h	DWORD	program's privilege level (0-3)
---386|DOS-Extender v3.0+ ---
 B8h	DWORD	-LOCKSTACK setting
 BCh	DWORD	-MAXEXTMEM
 C0h	DWORD	-MAXXMSMEM
 C4h	DWORD	-MAXPGMMEM
 C8h	DWORD	-DATATHRESHOLD
 CCh	DWORD	virtual memory manager flag (0 = not present, 1 = present)
 D0h	DWORD	Cyrix coprocessor flag (0 = no Cyrix EMC387, 1 = present)
 D4h	DWORD	-CYRIX setting (0 = AUTO, 1 = ON, 2 = OFF)
 D8h	DWORD	DPMI flag (0 = not present, 1 = present)
 DCh	DWORD	DPMI major version
 E0h	DWORD	DPMI minor version
 E4h	DWORD	DPMI capabilities flags (see #0592)
 E8h	DWORD	VCPI major version
 ECh	DWORD	VCPI minor version
 F0h	WORD	VCPI: IRQ0-7 physical base interrupt vector
 F2h	WORD	VCPI: IRQ8-15 physical base interrupt vector
 F4h	DWORD	XMS flag (0 = none, 1 = present)
 F8h	DWORD	XMS major version
 FCh	DWORD	XMS minor version
100h	WORD	application's CS selector
102h	WORD	application's DS selector
104h	WORD	application's PSP selector
106h	WORD	application's environment selector
108h	WORD	selector mapping entire first megabyte
10Ah	WORD	selector mapping text video memory
10Ch	WORD	selector mapping video memory (text for IBM, graphics for NEC)
10Eh	WORD	selector mapping Weitek address space, 0000h if not present
110h	WORD	selector mapping Cyrix EMC387 address space, 0000h if none
112h	WORD	reserved (0)
114h	DWORD	real-mode FAR entry point to call to switch to protected mode
		  with no saved context
118h	DWORD	size of LDT in bytes
---386|DOS-Extender v5.0+ ---
11Ch	DWORD	Windows flag (0 = not present, 1 = Windows present)
120h	DWORD	Windows major version
124h	DWORD	Windows minor version
128h	DWORD	Windows mode (0 = real/standard, 1 = enhanced)
12Ch	DWORD	OS/2 flag (0 = not present, 1 = OS/2 present)
130h	DWORD	OS/2 major version
134h	DWORD	OS/2 minor version
138h 50 DWORDs	reserved (0)

Bitfields for flags 1:
Bit(s)	Description	(Table 0591)
 0	-NOPAGE specified
 1	-A20 specified
 2	-VDISK specified
 3	-XT specified
 4	-AT specified
 5	-MCA specified
 6	-EISA specified
 7	-NORMRES specified (NEC only)
 8	-HIGHRES specified (NEC only)
 9	set if -SWFGROW1ST, clear if -NOSWFGROW1ST
 10	-NOVM specified
 11	-SAVEREGS specified
 12	unused (clear)
 13	-NOVCPI specified
 14	-NOMUL specified
 15	-NOBMCHK specified
 16	-NOSPCLMEM or -NOBIM
 17	-NOPGEXP specified
 18	-SWAPDEFDISK specified
---v3.0+ ---
 19	-SAVEINTS specified
 20	-NOLOAD specified
 21	-PAGELOG specified
 22	-OPENDENY specified
 23	-ERRATA17 specified
---v4.1+ ---
 24	-NESTDPMI specified
 25	-NONESTDPMI specified
 26	-NODPMI specified
 27	-NOPCDWEITEK specified
---v4.2+ ---
 28	-WININT21 specified

Bitfields for DPMI capabilities flags:
Bit(s)	Description	(Table 0592)
 0	paging supported
 1	physical device mapping
 2	conventional memory mapping
 3	exceptions restartable
--------E-212527-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - EN/DISABLE STATE SAVE ON INTERRUPTS
	AX = 2527h
	EBX = new status (00h disabled, 01h enabled)
Return: CF clear
	EBX = previous state save flag
SeeAlso: AX=2528h
--------E-212528-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - READ REGISTERS AFTER CTRL-C INT
	AX = 2528h
	DS:EBX -> buffer for registers (see #0593)
Return: CF clear if successful
	    DS:EBX buffer filled
	CF set on error
	    EAX = error code
		83h interrupt state save not enabled
		84h no active interrupt
SeeAlso: AX=2527h

Format of Phar Lap buffer for registers:
Offset	Size	Description	(Table 0593)
 00h  8 BYTEs	unused
 08h  4	DWORDs	EAX,EBX,ECX,EDX
 18h  4 DWORDs	ESI,EDI,EBP,ESP
 28h  6 WORDs	CS,DS,SS,ES,FS,GS
 34h	DWORD	EIP
 38h	DWORD	EFLAGS
--------E-212529-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - LOAD FLAT MODEL .EXP or .REX FILE
	AX = 2529h
	???
Return: ES:EBX -> parameter block (see #0594)
	???
Note:	details not available at this time
SeeAlso: AX=252Ah

Format of Phar Lap program load parameter block:
Offset	Size	Description	(Table 0594)
 00h	DWORD	initial EIP
 04h	WORD	initial CS
 06h	DWORD	initial ESP
 0Ah	WORD	initial SS
 0Ch  4 WORDs	initial DS, ES, FS, GS
 14h	DWORD	minimum size in bytes of program segment
 18h	DWORD	bytes of additional memory allocated
 1Ch	DWORD	flags
		bit 0: child linked with -UNPRIVILEGED
		---v6.0+ ---
		bit 1: child is PE file instead of .EXP
		bit 2: loaded file is a DLL
		bits 3-31 reserved
---v6.0+ ---
 20h	DWORD	module handles (PE files only)
 24h  7 DWORDs	reserved (0)
--------E-21252A-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - NEW LOAD PROGRAM FOR DEBUG
	AX = 252Ah
	DS:EDX -> ASCIZ program name
	ES:EBX -> parameter block (see #0588)
	ECX = size of LDT buffer in bytes
	ESI = bit flags
	    bit 0: allow demand paging rather than loading entire program
	    bit 1: demand page from swap file rather than from .EXP
Return: CF clear if successful
	    EAX = VMM handle or FFFFFFFFh if none
	    ECX = number of descriptors in LDT buffer
	CF set on error
	    EAX = error code
		02h file error
		    EBX = file error code (see #0595)
		    ECX = DOS error code if EBX=1,2,3, or 8
		08h insufficient memory
		    EBX = memory error code (see #0596)
		80h LDT buffer too small
		87h called twice without intervening call to AX=2531h
SeeAlso: AX=2512h,AX=2517h,AX=2529h,AX=2531h

(Table 0595)
Values for Phar Lap file error code:
 01h	DOS open error
 02h	DOS seek error
 03h	DOS read error
 04h	not an .EXP or .REX file
 05h	invalid file format
 06h	-OFFSET is not a multiple of 64K
 07h	-NOPAGE incompatible with -REALBREAK/-OFFSET
 08h	DOS error loading .EXE file

(Table 0596)
Values for Phar Lap memory error code:
 01h	out of physical memory
 02h	out of swap space
 04h	unable to change extended memory allocation
 05h	-MAXPGMMEM exceeded
 06h	insufficient low memory to REALBREAK value
 07h	insufficient low memory for PSP and environment
--------E-21252BBH00-------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender - CREATE UNMAPPED PAGES
	AX = 252Bh
	BH = 00h
	???
Return: ???
--------E-21252BBH01-------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender - CREATE ALLOCATED PAGES
	AX = 252Bh
	BH = 01h
	???
Return: ???
--------E-21252BBH02-------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender - CREATE PHYSICAL DEVICE PAGES
	AX = 252Bh
	BH = 02h
	???
Return: ???
--------E-21252BBH03-------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender - MAP DATA FILE
	AX = 252Bh
	BH = 03h
	???
Return: ???
SeeAlso: AX=252Bh/BL=0Bh
--------E-21252BBH04-------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender - GET PAGE TYPES
	AX = 252Bh
	BH = 04h
	???
Return: ???
Note:	returns one word per page
SeeAlso: #0597

Bitfields for Phar Lap page information:
Bit(s)	Description	(Table 0597)
 7	mapped to read/write data file
 6	mapped to read-only data file
 5	swapped to disk
 4	locked
 3-0	page type
	0 unmapped
	1 allocated
	2 physical device page
--------E-21252B-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - VIRTUAL MEMORY MANAGEMENT - PAGE LOCKING
	AX = 252Bh
	BH = function
	    05h lock pages
	    06h unlock pages
	BL = address type
	    00h linear address
		ECX = linear start address of memory region
	    01h segmented address
		ES:ECX -> start of memory region
	EDX = size of memory region in bytes
Return: CF clear if successful
	CF set on error
Note:	this function is also supported by FlashTek X-32VM; if X-32 is not
	  using virtual memory, this function always succeeds
--------E-21252B-----------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender - FREE PHYSICAL PAGES
	AX = 252Bh
	BH = function (07h,08h)
	???
Return: ???
--------E-21252BBH09-------------------------
INT 21 P - Phar Lap 386/DOS-Extender v4.1 - GET PAGETABLE ENTRY/PAGE TABLE INFO
	AX = 252Bh
	BH = 09h
	BL = subfunction
	    00h get page table entry by linear address
		ECX = linear address for which to get page table entry
	    01h get page table entry by logical address
		ES:ECX = address for which to get page table entry
Return: CF clear if successful
	    EAX = page table entry
	    EBX = additional page table information
	CF set on error
	    EAX = error code
		0009h invalid address
		0082h running under DPMI
SeeAlso: AX=251Dh,AX=252Bh/BH=0Ah
--------E-21252BBH0A-------------------------
INT 21 P - Phar Lap 386/DOS-Extender v4.1 - SET PAGETABLE ENTRY/PAGE TABLE INFO
	AX = 252Bh
	BH = 0Ah
	BL = subfunction
	    00h set page table entry for linear address
		ECX = linear address for which to get page table entry
	    01h set page table entry for logical address
		ES:ECX = address for which to get page table entry
	ESI = page table entry
	EDI = additional page table information
Return: CF clear if successful
	CF set on error
	    EAX = error code
		0009h invalid address
		0082h running under DPMI
SeeAlso: AX=252Bh/BH=09h
--------E-21252BBH0B-------------------------
INT 21 P - Phar Lap 386/DOS-Extender v4.1+ - MAP DATA FILE AT FILE OFFSET
	AX = 252Bh
	BH = 0Bh
	BL = subfunction
	    00h by linear address
		ECX = linear address at which to map data file
	    01h by logical address
		ES:ECX = logical address at which to map data file
	EDX = number of bytes to map
	DS:ESI -> mapping structure (see #0598)
	DS:EDI -> ASCIZ filename
Return: CF clear if successful
	CF set on error
	    EAX = error code
		0002h file error
		    ECX = phase (01h opening file, 02h seeking, 03h reading)
		    EDX = error code returned by DOS
		0009h invalid address
		0081h invalid parameters or 386|VMM not present
		0086h all 386|VMM file handles already in use
SeeAlso: AX=252Bh/BH=03h,AX=252Bh/BH=09h

Format of Phar Lap mapping structure:
Offset	Size	Description	(Table 0598)
 00h	DWORD	starting file offset to be mapped
 04h	DWORD	DOS file access and sharing modes (see #0628 at INT 21/AH=3Dh)
--------E-21252C-----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v3.0 - ADD UNMAPPED PAGES AT END OF SEGMENT
	AX = 252Ch
	BX = segment selector
	ECX = number of 4K pages to add
Return: CF clear if successful
	    EAX = offset in segment of beginning of unmapped pages
	CF set on error
	    EAX = error code
		08h insufficent memory
		09h invalid selector
		82h not supported by current DPMI
--------E-21252D-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM v2.3+ - CLOSE VMM FILE HANDLE
	AX = 252Dh
	EBX = VMM file handle
Return: CF clear if successful
	CF set on error
	    EAX = error code (81h invalid VMM handle)
--------E-21252E-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM v2.3+ - GET/SET VMM PARAMETERS
	AX = 252Eh
	CL = direction (00h get parameters, 01h set parameters)
	DS:EBX -> parameter buffer (see #0599)
Return: CF clear if successful
	CF set on error
	    EAX = error code (81h bad parameter value)

Format of Phar Lap VMM parameter buffer:
Offset	Size	Description	(Table 0599)
 00h	DWORD	flags
		bit 0: page fault logging enabled
		---v5.0+ ---
		bit 1: swap extender to disk during DOS EXEC call
		bit 2: don't zero allocated memory
 04h	DWORD	scan period for page aging, in milliseconds
 08h	DWORD	maximum size (in bytes) to check on each page scan
 0Ch 52 BYTEs	unused
--------E-21252F-----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v3.0 - WRITE RECORD TO VMM PAGE LOG FILE
	AX = 252Fh
	DS:EBX -> data to be written
	CX = size of data in bytes
Return: CF clear if successful
	CF set on error
	    EAX = error code (85h no page log file or not 386/VMM)
--------E-212530-----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v2.3+ - SET SIZE OF BUFFER FOR DOS CALLS
	AX = 2530h
	ECX = size of data buffer in bytes (1024 to 65536)
Return: CF clear if successful
	CF set on error
	    EAX = error code
		08h insufficient low memory
		81h invalid size
SeeAlso: AX=2517h
--------E-212531-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM v3.0 - READ/WRITE LDT DESCRIPTOR
	AX = 2531h
	BX = segment selector
	ECX = direction (00h read, 01h write)
	DS:EDX -> 8-byte buffer for descriptor contents
Return: CF clear if successful
	CF set on error
	    EAX = error code
		81h invalid selector
		82h DPMI running, or not a code or data segment
--------E-212532-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET EXCEPTION HANDLER VECTOR
	AX = 2532h
	CL = exception number (00h-0Fh)
Return: CF clear if successful
	    ES:EBX = CS:EIP of current exception handler
	CF set on error (CL > 0Fh)
Notes:	this call is also supported by the FlashTek X-32VM extender
	this function is incompatible with 386|VMM; use AX=2522h instead
SeeAlso: AX=2522h,AX=2533h
--------E-212533-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - SET EXCEPTION HANDLER VECTOR
	AX = 2533h
	CL = exception number (00h-0Fh)
	DS:EDX = CS:EIP of new exception handler
Return: CF clear if successful
	CF set on error (CL > 0Fh)
Notes:	this call is also supported by the FlashTek X-32VM extender
	this function is incompatible with 386|VMM; use AX=2522h instead
SeeAlso: AX=2522h,AX=2532h
--------E-212534-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v3.0+ - GET INTERRUPT FLAG
	AX = 2534h
Return: CF clear
	EAX = interrupt state (00h disabled, 01h enabled)
--------E-212535-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v3.0+ - READ/WRITE SYSTEM REGISTERS
	AX = 2535h
	EBX = direction (00h read registers, 01h write)
	DS:EDX -> system register record (see #0600)
Return: CF clear
Note:	this call is only available under MS Windows if PHARLAP.386 VDD is
	  installed

Format of Phar Lap system register record:
Offset	Size	Description	(Table 0600)
 00h	DWORD	CR0
 04h  4 DWORDs	DR0,DR1,DR2,DR3
 14h  2 DWORDs	reserved
 1Ch  2 DWORDs	DR6,DR7
 24h  3 DWORDs	reserved
--------E-212536----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v3.0+ - MIN/MAX EXTENDED/CONV MEMORY USAGE
	AX = 2536h
	EBX = bit flags
	    bit 0: modifying conventional memory rather than extended memory
	    bit 1: setting maximum memory usage rather than minimum
	ECX = new limit in 4K pages
Return: CF clear if successful
	    EAX = new limit
	CF set on error
	    EAX = error code (08h memory error or -NOPAGE set)
	    EBX = maximum limit in pages
	    ECX = minimum limit in pages
--------E-212537----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v3.0 - ALLOCATE DOS MEMORY ABOVE DOS BUFFER
	AX = 2537h
	BX = number of paragraphs to allocate
Return: CF clear if successful
	    AX = real-mode segment of allocated block
	CF set on error
	    AX = error code
		07h MS-DOS memory chain corrupted
		08h insufficient low memory
	    BX = size in paragraphs of largest free block
SeeAlso: AH=48h
--------E-212538----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v3.0 - READ PROTMODE REGS AFTER SFTWARE INT
	AX = 2538h
	DS:EBX -> buffer for registers (see #0593)
	ECX = register record to retrieve
	    00h first interrupt state
	    01h next interrupt state
		EDX = handle for current interrupt state
Return: CF clear if successful
	    DS:EBX buffer filled
	    EDX = handle of current interrupt state
	    ESI = number of interrupt which occurred
	CF set on error
	    EAX = error code
		81h invalid handle in EDX
		83h register saving not enabled
		84h no more interrupt states
SeeAlso: AX=2527h,AX=2528h
--------E-212539----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v3.0 - GET OFFSET OF .EXP FILE HEADER
	AX = 2539h
	BX = MS-DOS file handle for open file
Return: CF clear if successful
	    EAX = offset of .EXP header in file
	CF set on error
	    EAX = error code (02h file error)
	    EBX = file error code
		02h DOS error seeking
		03h DOS error reading
		04h invalid file type
		05h invalid file format
	    ECX = DOS error code if EBX=02h or 03h
	current file position in file modified
--------E-21253A----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v3.0+ - INSTALL MOD. SEG FAILURE HANDLER
	AX = 253Ah
	ES:EBX -> function to be called when INT 21/AH=4Ah is about to return
		an error
Return: CF clear
	ES:EBX -> previous handler
SeeAlso: AH=4Ah
--------E-21253B----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v3.0+ - JUMP TO REAL MODE CODE, NO CONTEXT
	AX = 253Bh
	DS:EBX -> buffer containing register contents (see #0593)
Return: never returns
SeeAlso: AX=2528h
--------E-21253C-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM v3.0+ - SHRINK 386|VMM SWAP FILE
	AX = 253Ch
Return: CF clear
	EAX = old size of swap file in bytes
	EBX = new size of swap file in bytes
--------E-21253D-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v4.0+ - READ/WRITE IDT DESCRIPTOR
	AX = 253Dh
	BL = interrupt number
	ECX = direction (0 = read, 1 = write)
	DS:EDX -> 8-byte buffer for descriptor
Return: CF clear if successful
	    DS:EDX filled if reading
	CF set on error
	    EAX = error code (0082h if running under DPMI)
Desc:	access hardware-level IDT rather than the internal 386/DOS-Extender
	  shadow IDT
Notes:	this call will always fail under DPMI because it is not possible to
	  access the IDT
	the descriptor is not checked when writing
	this call can normally be used only by programs running in ring 0
	  because the processor does not allow an interrupt to be vectored to
	  a less privileged ring
--------E-21253F-----------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender v6.0+ - ALLOCATE LDT DESCRIPTOR
	AX = 253Fh
	BX = LDT descriptor to allocate (0000h for any)
	???
Return: ???
--------E-212540-----------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender v6.0+ - FORCE ALIAS OF SEGMENT
	AX = 2540h
	???
Return: ???
--------E-212544-----------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender v6.0+ - FREE DLL
	AX = 2544h
	???
Return: ???
--------E-212545-----------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender v6.0+ - GET/SET PROCEDURE ADDRESS
	AX = 2545h
	ECX = direction (00h get, 01h set)
	???
Return: ???
--------E-212546-----------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender v6.0+ - GET MODULE HANDLE
	AX = 2546h
	???
Return: ???
--------E-2125C0-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - ALLOCATE MS-DOS MEMORY BLOCK
	AX = 25C0h
	BX = number of 16-byte paragraphs of MS-DOS memory requested
Return: CF clear if successful
	    AX = real-mode paragraph address of memory
	CF set on error
	    AX = error code
		07h MS-DOS memory control blocks destroyed
		08h insufficient memory
	    BX = size in paragraphs of largest available memory block
SeeAlso: AX=25C1h,AX=25C2h
--------E-2125C1-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - RELEASE MS-DOS MEMORY BLOCK
	AX = 25C1h
	CX = real-mode paragraph address of memory block to free
Return: CF clear if successful
	    EAX destroyed
	CF set on error
	    AX = error code
		07h MS-DOS memory control blocks destroyed
		09h invalid memory block address in CX
SeeAlso: AX=25C0h,AX=25C2h
--------E-2125C2-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - MODIFY MS-DOS MEMORY BLOCK
	AX = 25C2h
	BX = new requested block size in paragraphs
	CX = real-mode paragraph address of memory block to modify
Return: CF clear if successful
	    EAX destroyed
	CF set on error
	    AX = error code
		07h MS-DOS memory control blocks destroyed
		08h insufficient memory
		09h invalid memory block address in CX
	    BX = size in paragraphs of largest available memory block
SeeAlso: AX=25C0h,AX=25C1h
--------E-2125C3-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - EXECUTE PROGRAM
	AX = 25C3h
	ES:EBX -> pointer to parameter block (see #0602)
	DS:EDX -> pointer to ASCIZ program filename
Return: CF clear if successful
	    all registers unchanged
	CF set on error
	    EAX = error code (see #0601)

(Table 0601)
Values for Phar Lap error code:
 01h	function code in AL is invalid ???
 02h	file not found or path invalid
 05h	access denied
 08h	insufficient memory to load program
 0Ah	environment invalid
 0Bh	invalid file format

Format of parameter block:
Offset	Size	Description	(Table 0602)
 00h	DWORD	32-bit offset of environment string
 04h	WORD	segment selector of environment string
 06h	DWORD	32-bit offset of command-tail string
 0Ah	WORD	segment selector of command-tail string
--------D-2126-------------------------------
INT 21 - DOS 1+ - CREATE NEW PROGRAM SEGMENT PREFIX
	AH = 26h
	DX = segment at which to create PSP (see #0603)
Notes:	new PSP is updated with memory size information; INTs 22h, 23h, 24h
	  taken from interrupt vector table; the parent PSP field is set to 0
	(DOS 2+) DOS assumes that the caller's CS is the segment of the PSP to
	  copy
SeeAlso: AH=4Bh,AH=50h,AH=51h,AH=55h,AH=62h,AH=67h

Format of Program Segment Prefix (PSP):
Offset	Size	Description	(Table 0603)
 00h  2 BYTEs	INT 20 instruction for CP/M CALL 0 program termination
		the CDh 20h here is often used as a signature for a valid PSP
 02h	WORD	segment of first byte beyond memory allocated to program
 04h	BYTE	(DOS) unused filler
		(OS/2) count of fake DOS version returns
 05h	BYTE	CP/M CALL 5 service request (FAR CALL to absolute 000C0h)
		BUG: (DOS 2+ DEBUG) PSPs created by DEBUG point at 000BEh
 06h	WORD	CP/M compatibility--size of first segment for .COM files
 08h  2 BYTEs	remainder of FAR JMP at 05h
 0Ah	DWORD	stored INT 22 termination address
 0Eh	DWORD	stored INT 23 control-Break handler address
 12h	DWORD	DOS 1.1+ stored INT 24 critical error handler address
 16h	WORD	segment of parent PSP
 18h 20 BYTEs	DOS 2+ Job File Table, one byte per file handle, FFh = closed
 2Ch	WORD	DOS 2+ segment of environment for process (see #0604)
 2Eh	DWORD	DOS 2+ process's SS:SP on entry to last INT 21 call
 32h	WORD	DOS 3+ number of entries in JFT (default 20)
 34h	DWORD	DOS 3+ pointer to JFT (default PSP:0018h)
 38h	DWORD	DOS 3+ pointer to previous PSP (default FFFFFFFFh in 3.x)
		used by SHARE in DOS 3.3
 3Ch	BYTE	DOS 4+ (DBCS) interim console flag (see AX=6301h)
 3Dh	BYTE	(APPEND) TrueName flag (see INT 2F/AX=B711h)
 3Eh	BYTE	(Novell NetWare) flag: next byte initialized if CEh
		(OS/2) capabilities flag
 3Fh	BYTE	(Novell NetWare) Novell task number if previous byte is CEh
 40h  2 BYTEs	DOS 5+ version to return on INT 21/AH=30h
 42h	WORD	(MSWindows3) selector of next PSP (PDB) in linked list
		Windows keeps a linked list of Windows programs only
 44h	WORD	(MSWindows3) "PDB_Partition"
 46h	WORD	(MSWindows3) "PDB_NextPDB"
 48h	BYTE	(MSWindows3) bit 0 set if non-Windows application (WINOLDAP)
 49h	BYTE	unused by DOS versions <= 6.00
 4Ch	WORD	(MSWindows3) "PDB_EntryStack"
 4Eh  2 BYTEs	unused by DOS versions <= 6.00
 50h  3 BYTEs	DOS 2+ service request (INT 21/RETF instructions)
 53h  2 BYTEs	unused in DOS versions <= 6.00
 55h  7 BYTEs	unused in DOS versions <= 6.00; can be used to make first FCB
		  into an extended FCB
 5Ch 16 BYTEs	first default FCB, filled in from first commandline argument
		overwrites second FCB if opened
 6Ch 16 BYTEs	second default FCB, filled in from second commandline argument
		  overwrites beginning of commandline if opened
 7Ch  4 BYTEs	unused
 80h 128 BYTEs	commandline / default DTA
		command tail is BYTE for length of tail, N BYTEs for the tail,
		  followed by a BYTE containing 0Dh
Notes:	in DOS v3+, the limit on simultaneously open files may be increased by
	  allocating memory for a new open file table, filling it with FFh,
	  copying the first 20 bytes from the default table, and adjusting the
	  pointer and count at 34h and 32h.  However, DOS will only copy the
	  first 20 file handles into a child PSP (including the one created on
	  EXEC).
	network redirectors based on the original MS-Net implementation use
	  values of 80h-FEh in the open file table to indicate remote files;
	  Novell NetWare also uses values from FEh down to 80h or one more than
	  FILES= (whichever is greater) to indicate remote files
	MS-DOS 5.00 incorrectly fills the FCB fields when loading a program
	  high; the first FCB is empty and the second contains the first
	  parameter
	some DOS extenders place protected-mode values in various PSP fields
	  such as the "parent" field, which can confuse PSP walkers.  Always
	  check either for the CDh 20h signature or that the suspected PSP is
	  at the beginning of a memory block which owns itself (the preceding
	  paragraph should be a valid MCB with "owner" the same as the
	  suspected PSP).
	Novell NetWare updates the fields at offsets 3Eh and 3Fh without
	  checking that a legal PSP segment is current; see AH=50h for further
	  discussion

Format of environment block:
Offset	Size	Description	(Table 0604)
 00h  N BYTEs	first environment variable, ASCIZ string of form "var=value"
      N BYTEs	second environment variable, ASCIZ string
	...
      N BYTEs	last environment variable, ASCIZ string of form "var=value"
	BYTE	00h
---DOS 3.0+ ---
	WORD	number of strings following environment (normally 1)
      N BYTEs	ASCIZ full pathname of program owning this environment
		other strings may follow
--------D-2127-------------------------------
INT 21 - DOS 1+ - RANDOM BLOCK READ FROM FCB FILE
	AH = 27h
	CX = number of records to read
	DS:DX -> opened FCB (see #0574)
Return: AL = status
	    00h successful, all records read
	    01h end of file, no data read
	    02h segment wrap in DTA, no data read
	    03h end of file, partial read
	[DTA] = records read from file
	CX = number of records read (return AL = 00h or 03h)
Notes:	read begins at current file position as specified in FCB; the file
	  position is updated after reading
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=21h,AH=28h,AH=3Fh
--------D-2128-------------------------------
INT 21 - DOS 1+ - RANDOM BLOCK WRITE TO FCB FILE
	AH = 28h
	CX = number of records to write
	DS:DX -> opened FCB (see #0574)
	[DTA] = records to write
Return: AL = status
	    00h successful
	    01h disk full or file read-only
	    02h segment wrap in DTA
	CX = number of records written
Notes:	write begins at current file position as specified in FCB; the file
	  position is updated after writing
	if CX = 0000h on entry, no data is written; instead the file size is
	  adjusted to be the same as the file position specified by the random
	  record and record size fields of the FCB
	if the data to be written is less than a disk sector, it is copied into
	  a DOS disk buffer, to be written out to disk at a later time
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=22h,AH=27h,AH=40h,AH=59h
--------D-2129-------------------------------
INT 21 - DOS 1+ - PARSE FILENAME INTO FCB
	AH = 29h
	AL = parsing options (see #0605)
	DS:SI -> filename string (both '*' and '?' wildcards OK)
	ES:DI -> buffer for unopened FCB
Return: AL = result code
	    00h successful parse, no wildcards encountered
	    01h successful parse, wildcards present
	    FFh failed (invalid drive specifier)
	DS:SI -> first unparsed character
	ES:DI buffer filled with unopened FCB (see #0574)
Notes:	asterisks expanded to question marks in the FCB
	all processing stops when a filename terminator is encountered
	cannot be used with filespecs which include a path (DOS 2+)
	Novell NetWare monitors the result code since an 'invalid drive' may
	  signal an attempt to reconnect a network drive; if there are no
	  connections to the specified drive, NetWare attempts to build a
	  connection and map the drive to the SYS:LOGIN directory
SeeAlso: AH=0Fh,AH=16h,AH=26h

Bitfields for parsing options:
Bit(s)	Description	(Table 0605)
 0	skip leading separators
 1	use existing drive number in FCB if no drive is specified, instead of
	  setting field to zero
 2	use existing filename in FCB if no base name is specified, instead of
	  filling field with blanks
 3	use existing extension in FCB if no extension is specified, instead of
	  filling field with blanks
 4-7	reserved (0)
--------D-212A-------------------------------
INT 21 - DOS 1+ - GET SYSTEM DATE
	AH = 2Ah
Return: CX = year (1980-2099)
	DH = month
	DL = day
---DOS 1.10+---
	AL = day of week (00h=Sunday)
SeeAlso: AH=2Bh"DOS",AH=2Ch,AH=E7h,INT 1A/AH=04h,INT 2F/AX=120Dh
--------D-212B-------------------------------
INT 21 - DOS 1+ - SET SYSTEM DATE
	AH = 2Bh
	CX = year (1980-2099)
	DH = month
	DL = day
Return: AL = status
	    00h successful
	    FFh invalid date, system date unchanged
Note:	DOS 3.3+ also sets CMOS clock
SeeAlso: AH=2Ah,AH=2Dh,INT 1A/AH=05h
--------E-212B--CX4149-----------------------
INT 21 - AI Architects - ??? - INSTALLATION CHECK
	AH = 2Bh
	CX = 4149h ('AI')
	DX = 413Fh ('A?')
Return: AL <> FFh if installed
Note:	Borland's TKERNEL makes this call
--------c-212B--CX4358-----------------------
INT 21 - Super PC-Kwik v3.20+ - INSTALLATION CHECK
	AH = 2Bh
	CX = 4358h ('CX')
Return: AL = FFh if PC-Kwik/PC-Cache not installed
	AL = 00h if installed
	    CF clear
	    CX = 6378h ('cx')
	    BX = ???
	    DX = version (DH = major version, DL = binary minor version)
Note:	PC Tools PC-Cache v5.x and Qualitas Qcache v4.00 are OEM versions of
	  Super PC-Kwik, and thus support this call (PC-Cache 5.1 corresponds
	  to PC-Kwik v3.20)
SeeAlso: INT 13/AH=A0h,INT 13/AH=B0h,INT 16/AX=FFA5h/CX=1111h
Index:	PC-Cache;installation check|Qualitas Qcache;installation check
Index:	installation check;PC-Cache 5.x|installation check;Qualitas Qcache
--------Q-212B--CX4445-----------------------
INT 21 - DESQview - INSTALLATION CHECK
	AH = 2Bh
	CX = 4445h ('DE')
	DX = 5351h ('SQ')
	AL = subfunction (DV v2.00+)
	    01h get version
		Return: BX = version (BH = major, BL = minor)
		Note: early copies of v2.00 return 0002h
	    02h get shadow buffer info, and start shadowing
		Return: BH = rows in shadow buffer
			BL = columns in shadow buffer
			DX = segment of shadow buffer
	    04h get shadow buffer info
		Return: BH = rows in shadow buffer
			BL = columns in shadow buffer
			DX = segment of shadow buffer
	    05h stop shadowing
Return: AL = FFh if DESQview not installed
Notes:	in DESQview v1.x, there were no subfunctions; this call only identified
	  whether or not DESQview was loaded.  DESQview v2.52 performs function
	  01h for all subfunction requests 0Ch and higher and appears to ignore
	  all lower-numbered functions not listed here.
	DESQview versions 2.50-2.52 are part of DESQview/X v1.0x; version 2.53
	  is part of DESQview/X v1.10; and version 2.63 is part of DESQview/X
	  v2.00.
BUG:	subfunction 05h does not appear to work correctly in DESQview 2.52
SeeAlso: INT 10/AH=FEh,INT 10/AH=FFh,INT 15/AX=1024h,INT 15/AX=DE30h
--------U-212B--CX454C-----------------------
INT 21 - ELRES v1.1 - INSTALLATION CHECK
	AH = 2Bh
	CX = 454Ch ('EL')
	DX = 5253h ('RS')
Return: ES:BX -> ELRES history structure (see #0606)
	DX = DABEh (signature, DAve BEnnett)
Program: ELRES is an MS-DOS return code (errorlevel) recorder by David H.
	  Bennett which stores recent errorlevel values, allows them to be
	  retrieved for use in batch files, and can place them in an
	  environment variable
SeeAlso: AH=4Bh"ELRES",AH=4Dh

Format of ELRES history structure:
Offset	Size	Description	(Table 0606)
 00h	WORD	number of return codes which can be stored by following buffer
 02h	WORD	current position in buffer (treated as a ring)
 04h  N BYTEs	ELRES buffer
--------m-212B01CX444D-----------------------
INT 21 - Quarterdeck DOS-UP.SYS v2.00 - INSTALLATION CHECK
	AX = 2B01h
	CX = 444Dh ('DM')
	DX = 4158h ('AX')
Return: AX = 0000h if installed
	    BX = version??? (0002h)
	    CX = 4845h ('HE')
	    DX = 5245h ('RE')
	    ES = DOS-UP driver segment
--------T-212B01CX5441-----------------------
INT 21 - TAME v2.10+ - INSTALLATION CHECK
	AX = 2B01h
	CX = 5441h ('TA')
	DX = 4D45h ('ME')
---v2.60---
	BH = ???
	    00h skip ???, else do
Return: AL = 02h if installed
	ES:DX -> data area in TAME-RES (see #0607,#0611,#0613)
Program: TAME is a shareware program by David G. Thomas which gives up CPU time
	  to other partitions under a multitasker when the current partition's
	  program incessantly polls the keyboard or system time

Format of TAME 2.10-2.20 data area:
Offset	Size	Description	(Table 0607)
 00h	BYTE	data structure minor version number (01h in TAME 2.20)
 01h	BYTE	data structure major version number (07h in TAME 2.20)
 02h	DWORD	number of task switches
 06h	DWORD	number of keyboard polls
 0Ah	DWORD	number of time polls
 0Eh	DWORD	number of times DESQview told program runs only in foreground
 12h	DWORD	original INT 10h
 16h	DWORD	original INT 14h
 1Ah	DWORD	original INT 15h
 1Eh	DWORD	original INT 16h
 22h	DWORD	original INT 17h
 26h	DWORD	original INT 21h
 2Ah	DWORD	original INT 28h
 2Eh	WORD	offset of TAME INT 10h handler
 30h	WORD	offset of TAME INT 14h handler
 32h	WORD	offset of TAME INT 15h handler
 34h	WORD	offset of TAME INT 16h handler
 36h	WORD	offset of TAME INT 17h handler
 38h	WORD	offset of TAME INT 21h handler
 3Ah	WORD	offset of TAME INT 28h handler
 3Ch	WORD	X in /max:X,Y or /freq:X,Y
 3Eh	WORD	Y in /max:X,Y or /freq:X,Y
 40h	WORD	number of polls remaining before next task switch
 42h	WORD	/KEYIDLE value
 44h	BYTE	interrupts already grabbed by TAME (see #0608)
 45h	BYTE	flags for interrupts which may be acted on (same bits as above)
 46h	BYTE	TAME enabled (01h) or disabled (00h)
 47h	BYTE	/TIMEPOLL (01h) or /NOTIMEPOLL (00h)
 48h	BYTE	/NOTIMER (01h) or /TIMER (00h)
 49h	BYTE	window or task number for this task
 4Ah	BYTE	multitasker type (see #0609)
 4Bh	BYTE	type of task switching selected
		bit 0: DESQview???
		bit 1: DoubleDOS???
		bit 2: TopView???
		bit 3: KeySwitch
		bit 4: HLT instruction
 4Ch	BYTE	???
 4Dh	BYTE	flags
		bit 1: /FREQ instead of /MAX
 4Eh	BYTE	/FG: value
 4Fh	BYTE	task switches left until next FGONLY DESQview API call
 50h	BYTE	???

Bitfields for interrupts already grabbed by TAME:
Bit(s)	Description	(Table 0608)
 0	INT 10h
 1	INT 14h
 2	INT 15h
 3	INT 16h
 4	INT 17h
 5	INT 21h
 6	INT 28h

(Table 0609)
Values for multitasker type:
 01h	DESQview
 02h	DoubleDOS
 03h	TopView
 04h	OmniView
 05h	VM/386

Bitfields for type of task switching selected:
Bit(s)	Description	(Table 0610)
 0	DESQview
 1	DoubleDOS
 2	TopView
 3	OmniView
 4	KeySwitch
 5	HLT instruction

Format of TAME 2.30 data area:
Offset	Size	Description	(Table 0611)
 00h	BYTE	data structure minor version number (02h in TAME 2.30)
 01h	BYTE	data structure major version number (0Ah in TAME 2.30)
 02h	DWORD	number of task switches
 06h	DWORD	number of keyboard polls
 0Ah	DWORD	number of time polls
 0Eh	DWORD	number of times DESQview told program runs only in foreground
 12h	DWORD	time of last /CLEAR or TAME-RES load
 16h	DWORD	time yielded
 1Ah	DWORD	time spent polling
 1Eh	DWORD	time spent waiting on key input with INT 16/AH=01h,11h
 22h	DWORD	original INT 10h
 26h	DWORD	original INT 14h
 2Ah	DWORD	original INT 15h
 2Eh	DWORD	original INT 16h
 32h	DWORD	original INT 17h
 36h	DWORD	original INT 21h
 3Ah	DWORD	original INT 28h
 3Eh	WORD	offset of TAME INT 10h handler
 40h	WORD	offset of TAME INT 14h handler
 42h	WORD	offset of TAME INT 15h handler
 44h	WORD	offset of TAME INT 16h handler
 46h	WORD	offset of TAME INT 17h handler
 48h	WORD	offset of TAME INT 21h handler
 4Ah	WORD	offset of TAME INT 28h handler
 4Ch	WORD	X in /max:X,Y or /freq:X,Y
 4Eh	WORD	Y in /max:X,Y or /freq:X,Y
 50h	WORD	number of polls remaining before next task switch
 52h	WORD	/KEYIDLE value
 54h	WORD	/FG: value
 56h	WORD	task switches left until next FGONLY DESQview API call
 58h	WORD	multitasker version
 5Ah	WORD	virtual screen segment
 5Ch	BYTE	interrupts already grabbed by TAME (see #0608)
 5Dh	BYTE	flags for interrupts which may be acted on (same bits as above)
 5Eh	BYTE	window or task number for this task
 5Fh	BYTE	multitasker type (see #0609)
 60h	BYTE	type of task switching selected (bit flags) (see #0610)
 61h	BYTE	watch_DOS
 62h	BYTE	action flags (see #0612)
 63h	BYTE	old status
 64h	WORD	signature DA34h

Bitfields for TAME action flags:
Bit(s)	Description	(Table 0612)
 0	TAME enabled
 1	/FREQ instead of /MAX (X and Y count fields are per tick)
 2	/TIMEPOLL
 3	/KEYPOLL
 4	inhibit timer
 5	enable status monitoring
SeeAlso: #0611,#0613

Format of TAME 2.60 data area:
Offset	Size	Description	(Table 0613)
 00h	BYTE	data structure minor version number (02h in TAME 2.60)
 01h	BYTE	data structure major version number (0Bh in TAME 2.60)
 02h	DWORD	number of task switches
 06h	DWORD	number of keyboard polls
 0Ah	DWORD	number of time polls
 0Eh	DWORD	number of times DESQview told program runs only in foreground
 12h	DWORD	time of last /CLEAR or TAME-RES load
 16h	DWORD	time yielded
 1Ah	DWORD	time spent polling
 1Eh	DWORD	time spent waiting on key input with INT 16/AH=01h,11h
 22h  4 BYTEs	???
 26h	DWORD	original INT 10h
 2Ah	DWORD	original INT 14h
 2Eh	DWORD	original INT 15h
 32h	DWORD	original INT 16h
 36h	DWORD	original INT 17h
 3Ah	DWORD	original INT 21h
 3Eh	DWORD	original INT 28h
 42h	WORD	offset of TAME INT 10h handler
 44h	WORD	offset of TAME INT 14h handler
 46h	WORD	offset of TAME INT 15h handler
 48h	WORD	offset of TAME INT 16h handler
 4Ah	WORD	offset of TAME INT 17h handler
 4Ch	WORD	offset of TAME INT 21h handler
 4Eh	WORD	offset of TAME INT 28h handler
 50h	WORD	X in /max:X,Y or /freq:X,Y
 52h	WORD	Y in /max:X,Y or /freq:X,Y
 54h	WORD	number of polls remaining before next task switch
 56h	WORD	/KEYIDLE value
 58h  4 BYTEs	???
 5Ch	WORD	X in /boost:X,Y
 5Eh	WORD	Y in /boost:X,Y
 60h	WORD	/FG: value
 62h	WORD	task switches remaining until next FGONLY DESQview API call
 64h	WORD	multitasker version ???
 66h	WORD	virtual screen segment
 68h	BYTE	interrupts already grabbed by TAME (see #0608)
 69h	BYTE	flags for interrupts which may be acted on (same bits as above)
 6Ah	BYTE	window or task number for this task
 6Bh	BYTE	multitasker type (see #0609)
 6Ch	BYTE	type of task switching selected (bit flags) (see #0610)
 6Dh	BYTE	watch_DOS
 6Eh	BYTE	action flags (see #0612)
 6Fh	BYTE	old status
 70h	WORD	signature DA34h
--------v-212B16CX0643-----------------------
INT 21 - VIRUS - "Maltese Amoeba" - INSTALLATION CHECK
	AX = 2B16h
	CX = 0643h
Return: AX = 1603h if installed
--------R-212B44BX4D41-----------------------
INT 21 - pcANYWHERE IV/LAN - INSTALLATION CHECK
	AX = 2B44h ('D')
	BX = 4D41h ('MA')
	CX = 7063h ('pc')
	DX = 4157h ('AW')
Return: AX = resident program
	    4F4Bh ('OK') if large host resident
	    6F6Bh ('ok') if small host resident
	CX:DX -> API entry point (see #0614)
SeeAlso: INT 16/AH=79h

(Table 0614)
Call pcANYWHERE API entry point with:
	AX = 0000h get pcANYWHERE IV version
	    DS:SI -> BYTE buffer for host type code
	    Return: AH = version number
		    AL = revision number
		    DS:DI buffer byte filled with
			00h full-featured host
			01h limited-feature LAN host
			other API may not be supported
	AX = 0001h initialize operation
	    DS:SI -> initialization request structure (see #0615)
	    Return: AX = function status (see #0618)
	AX = 0002h get status
	    Return: AH = current operating mode (see init req structure below)
		    AL = current connection status (see #0617)
	AX = 0003h suspend remote screen updates
	    Return: AX = function status (see #0618)
	AX = 0004h resume screen updates
	    Return: AX = function status (see #0618)
	AX = 0005h end current remote access session
	    DS:SI -> termination request structure (see #0616)
	    Return: AX = function status (see #0618)
	AX = 0006h remove pcANYWHERE IV from memory
	    Return: AX = status (see #0618)
	AX = 8000h read data from communications channel
	    DS:BX -> buffer
	    CX = buffer size
	    Return: AX >= number of characters read/available
		    AX < 0 on error
	AX = 8001h write data to communications channel
	    DS:BX -> buffer
	    CX = buffer size
	    Return: AX >= number of characters written
		    AX < 0 on error
	AX = 8002h get connection status
	    Return: AX = status
			> 0000h if connection active
			= 0000h if connection lost
			< 0000h on error

Format of pcANYWHERE initialization request structure:
Offset	Size	Description	(Table 0615)
 00h	BYTE	operating mode
		00h wait for a call
		01h hot key activates
		02h incoming call activates
		03h initiate a call
 01h  3 BYTEs	user ID to append to config file names
 04h	WORD	DS-relative pointer to path for config files
 06h	WORD	DS-relative pointer to path for program files

Format of pcANYWHERE termination request structure:
Offset	Size	Description	(Table 0616)
 00h	BYTE	operating mode after termination
		00h wait for a call
		01h hot key activates
		02h incoming call activates
		80h use current mode
		FFh remove from memory

Bitfields for current connection status:
Bit(s)	Description	(Table 0617)
 0	a physical connection is active
 1	remove screen updating is active
 2	connection checking is active
 3	hot key detection is active
 4	background file transfer is active

(Table 0618)
Values for pcANYWHERE function status:
 0000h	function completed successfully
 FFD1h	unable to release interrupt vectors
 FFD2h	unable to release allocated memory
 FFF2h	unable to establish a connection when operating mode is
	  "Initiate a call"
 FFF3h	modem configuration is invalid (corrupt config)
 FFF4h	modem initialization failed (no modem response)
 FFF5h	the communications device could not be initialized
 FFF6h	the host operator aborted the function
 FFF7h	the communications driver type specified in the configuration file is
	  different than the one loaded when pcANYWHERE IV was started
 FFF9h	the configuration file is invalid
 FFFAh	the configuration file could not be found
 FFFBh	no session is active
 FFFCh	a remote access session is active
 FFFDh	the specified operating mode is invalid
--------G-212B--CX6269-----------------------
INT 21 - WDTSR.COM - INSTALLATION CHECK
	AH = 2Bh
	CX = 6269h ('bi')
	DX = 742Dh ('t-')
Return: AL = FFh if not installed
	AL = 77h ('w') if WDTSR is installed
	    CX = 6174h ('at')
	    DX = 6368h ('ch')
	    ES = resident code segment
	    ES:DI -> identification and configuration data
Program: WDTSR is a driver for the bitWatch watchdog hardware by bit-design
	  GmbH
SeeAlso: AH=2Bh/CX=6269h"bitFOSSI",INT 14/AH=14h"FOSSIL",INT 15/AH=C3h
--------S-212B--CX6269-----------------------
INT 21 - bitFOSS - INSTALLATION CHECK
	AH = 2Bh
	CX = 6269h ('bi')
	DX = 7446h ('tF')
Return: AL = FFh if not installed
	AL = 4Fh ('O') if bitFOSS is installed
	    CX = 5353h ('SS')
	    DX = 494Ch ('IL')
	    ES = resident code segment
	    ES:DI -> identification data
Program: bitFOSS is a revision 5 FOSSIL driver
SeeAlso: AH=2Bh/CX=6269h"bitFOSSI",INT 11/AH=BCh
--------S-212B--CX6269-----------------------
INT 21 - bitFOSSI - INSTALLATION CHECK
	AH = 2Bh
	CX = 6269h ('bi')
	DX = 7449h ('tI')
Return: AL = FFh if not installed
	AL = 53h ('S') if bitFOSSI is installed
	    CX = 444Eh ('DN')
	    DX = 2D46h ('-F')
	    ES = resident code segment
	    ES:DI -> identification data
Program: bitFOSSI is a revision 5 FOSSIL driver for ???'s ISDN board
SeeAlso: AH=2Bh/CX=6269h/DX=7446h,INT 11/AH=BCh
--------D-212C-------------------------------
INT 21 - DOS 1+ - GET SYSTEM TIME
	AH = 2Ch
Return: CH = hour
	CL = minute
	DH = second
	DL = 1/100 seconds
Note:	on most systems, the resolution of the system clock is about 5/100sec,
	  so returned times generally do not increment by 1
	on some systems, DL may always return 00h
SeeAlso: AH=2Ah,AH=2Dh,AH=E7h,INT 1A/AH=00h,INT 1A/AH=02h,INT 1A/AH=FEh
SeeAlso: INT 2F/AX=120Dh
--------v-212C--------------------------
INT 21 - VIRUS - "Anti Pode 2.0" - INSTALLATION CHECK
	AH = 2Ch
Return: DL = F2h if resident
SeeAlso: AX=1812h"VIRUS",AX=2C2Ch
--------v-212C00CX534B-----------------------
INT 21 - SKUDO - INSTALLATION CHECK
	AX = 2C00h
	CX = 534Bh ('SK')
	DX = 5544h ('UD')
	BX = 4F21h ('O!')
Return: AX = 5349h ('SI') if installed
	    CH = version number
	    CL = subversion
Program: SKUDO is an antivirus TSR by Jordi Mas
--------v-212C2C------------------------
INT 21 - VIRUS - "LockJaw/Proto-T" - INSTALLATION CHECK
	AX = 2C2Ch
Return: AX = 0DCDh if resident
SeeAlso: AH=2Ch"VIRUS",AX=3000h"VIRUS"
--------D-212D-------------------------------
INT 21 - DOS 1+ - SET SYSTEM TIME
	AH = 2Dh
	CH = hour
	CL = minute
	DH = second
	DL = 1/100 seconds
Return: AL = result
	    00h successful
	    FFh invalid time, system time unchanged
Note:	DOS 3.3+ also sets CMOS clock
SeeAlso: AH=2Bh"DOS",AH=2Ch,INT 1A/AH=01h,INT 1A/AH=03h,INT 1A/AH=FFh"AT&T"
--------T-212D01CX7820-----------------------
INT 21 - PC-Mix - INSTALLATION CHECK
	AX = 2D01h
	CX = 7820h ('X ')
	DX = 6D69h ('MI')
Return: AL = 00h if installed
--------D-212E--DL00-------------------------
INT 21 - DOS 1+ - SET VERIFY FLAG
	AH = 2Eh
	DL = 00h (DOS 1.x/2.x only)
	AL = new state of verify flag
	    00h off
	    01h on
Notes:	default state at system boot is OFF
	when ON, all disk writes are verified provided the device driver
	  supports read-after-write verification
SeeAlso: AH=54h
--------D-212F-------------------------------
INT 21 - DOS 2+ - GET DISK TRANSFER AREA ADDRESS
	AH = 2Fh
Return: ES:BX -> current DTA
Note:	under the FlashTek X-32 DOS extender, the pointer is in ES:EBX
SeeAlso: AH=1Ah
--------D-2130-------------------------------
INT 21 - DOS 2+ - GET DOS VERSION
	AH = 30h
---DOS 5+ ---
	AL = what to return in BH
	    00h OEM number (as for DOS 2.0-4.0x)
	    01h version flag
Return: AL = major version number (00h if DOS 1.x)
	AH = minor version number
	BL:CX = 24-bit user serial number (most versions do not use this)
---if DOS <5 or AL=00h---
	BH = MS-DOS OEM number (see #0619)
---if DOS 5+ and AL=01h---
	BH = version flag
	    bit 3: DOS is in ROM
	    other: reserved (0)
Notes:	the OS/2 v1.x Compatibility Box returns major version 0Ah (10)
	the OS/2 v2.x Compatibility Box returns major version 14h (20)
	OS/2 Warp 3.0 Virtual DOS Machines report v20.30.
	the Windows/NT DOS box returns version 5.00, subject to SETVER
	DOS 4.01 and 4.02 identify themselves as version 4.00; use
	  INT 21/AH=87h to distinguish between the original European MS-DOS 4.0
	  and the later PC-DOS 4.0x and MS-DOS 4.0x
	IBM DOS 6.1 reports its version as 6.00; use the OEM number to
	  distinguish between MS-DOS 6.00 and IBM DOS 6.1 (there was never an
	  IBM DOS 6.0)
	MS-DOS 6.21 reports its version as 6.20; version 6.22 returns the
	  correct value
	the "Chicago" beta returns version 7.00 (reported in
	  _Microsoft_Systems_Journal_, August 1994).
	DR-DOS 5.0 and 6.0 report version 3.31; Novell DOS 7 reports IBM v6.00,
	  which some software displays as IBM DOS v6.10 (because of the version
	  mismatch in true IBM DOS, as mentioned above)
	generic MS-DOS 3.30, Compaq MS-DOS 3.31, and others identify themselves
	  as PC-DOS by returning OEM number 00h
	the version returned under DOS 4.0x may be modified by entries in
	  the special program list (see #0874 at AH=52h); the version returned
	  under DOS 5+ may be modified by SETVER--use AX=3306h to get the true
	  version number
SeeAlso: AX=3000h/BX=3000h,AX=3306h,AX=4452h,AH=87h,INT 15/AX=4900h
SeeAlso: INT 2F/AX=122Fh,INT 2F/AX=4010h,INT 2F/AX=E002h

(Table 0619)
Values for DOS OEM number:
 00h	IBM
 01h	Compaq
 02h	MS Packaged Product
 04h	AT&T
 05h	ZDS (Zenith Electronics)
 06h	Hewlett-Packard
 07h	ZDS (Groupe Bull)
 0Dh	Packard-Bell
 16h	DEC
 23h	Olivetti
 28h	Texas Instruments
 29h	Toshiba
 33h	Novell (Windows/386 device IDs only)
 34h	MS Multimedia Systems (Windows/386 device IDs only)
 35h	MS Multimedia Systems (Windows/386 device IDs only)
 4Dh	Hewlett-Packard
 5Eh	RxDOS
 66h	PhysTechSoft (PTS-DOS)
 99h	General Software's Embedded DOS
 EEh	DR-DOS
 EFh	Novell DOS
 FFh	Microsoft, Phoenix
--------E-2130-------------------------------
INT 21 - Phar Lap 386/DOS-Extender, Intel Code Builder - INSTALLATION CHECK
	AH = 30h
	EAX = 00003000h
	EBX = 50484152h ("PHAR")
Return: AL = major DOS version
	AH = minor DOS version
	EAX bits 31-16 = 4458h ('DX') if 386/DOS-extender installed
	    BL = ASCII major version number
	EAX bits 31-16 = 4243h ('BC') if Intel Code Builder installed
	    EDX = address of GDA
SeeAlso: AX=2501h,AX=FF00h,INT 2F/AX=F100h
--------v-2130--DXABCD-----------------------
INT 21 - VIRUS - "Possessed" - INSTALLATION CHECK
	AH = 30h
	DX = ABCDh
Return: DX = DCBAh if installed
SeeAlso: AX=0D20h,AX=3000h"VIRUS",AX=30F1h
--------T-213000BX1234-----------------------
INT 21 - CTask 2.0+ - INSTALLATION CHECK
	AX = 3000h
	BX = 1234h
	DS:DX -> 8-byte version string (DX < FFF0h) "CTask21",00h for v2.1-2.2
Return: AL = DOS major version
	AH = DOS minor version
	CX:BX -> Ctask global data block
Program: CTask is a multitasking kernel for C written by Thomas Wagner
Note:	if first eight bytes of returned data block equal eight bytes passed
	  in, CTask is resident
--------O-213000BX3000-----------------------
INT 21 - PC-MOS/386 v3.0 - INSTALLATION CHECK/GET VERSION
	AX = 3000h
	BX = 3000h
	CX = DX = 3000h
Return: AX = PC-MOS version
Program: PC-MOS/386 is a multitasking/multiuser MS-DOS-compatible operating
	  system by The Software Link, Inc.
SeeAlso: AH=30h,INT 38/AH=02h,INT 38/AH=10h
--------v-213000BX614A------------------
INT 21 - VIRUS - "Jackal" - INSTALLATION CHECK
	AX = 3000h
	BX = 614Ah ('aJ')
	CX = 6B63h ('kc')
	DX = 6C61h ('la')
Return: BX = ???
SeeAlso: AX=2C2Ch"VIRUS",AX=33DAh"VIRUS"
--------G-213022-----------------------------
INT 21 - StopPrg v2.0 - INSTALLATION CHECK
	AX = 3022h
Return: AX = DOS version (see AH=30h)
	CX = 1112h if StopPrg installed
	    BX = segment of resident code
Program: StopPrg is a resident program aborter by MAK-TRAXON's Prophet
Note:	StopPrg may be temporarily disabled by storing 9090h in the word at
	  0000h:04FEh
--------v-2130F1-----------------------------
INT 21 - VIRUS - "Dutch-555"/"Quit 1992" - INSTALLATION CHECK
	AX = 30F1h
Return: AL = 00h if resident
SeeAlso: AH=30h/DX=ABCDh,AX=330Fh,AX=33DAh
----------2130FFCX4445-----------------------
INT 21 - DESQ??? - INSTALLATION CHECK
	AX = 30FFh
	CX = 4445h ("DE")
	DX = 5351h ("SQ")
Return: BH = 05h if installed
	???
Note:	called by DUBLDISK.COM v2.6; this function is not supported by
	  DESQview, so it may be for DESQview's precursor DESQ.
SeeAlso: AX=4404h"DUBLDISK"
--------D-2131-------------------------------
INT 21 - DOS 2+ - TERMINATE AND STAY RESIDENT
	AH = 31h
	AL = return code
	DX = number of paragraphs to keep resident
Return: never
Notes:	the value in DX only affects the memory block containing the PSP;
	  additional memory allocated via AH=48h is not affected
	the minimum number of paragraphs which will remain resident is 11h
	  for DOS 2.x and 06h for DOS 3.0+
	most TSRs can save some memory by releasing their environment block
	  before terminating (see #0603 at AH=26h,AH=49h)
SeeAlso: AH=00h,AH=4Ch,AH=4Dh,INT 20,INT 22,INT 27
--------D-2132-------------------------------
INT 21 - DOS 2+ - GET DOS DRIVE PARAMETER BLOCK FOR SPECIFIC DRIVE
	AH = 32h
	DL = drive number (00h = default, 01h = A:, etc)
Return: AL = status
	    00h successful
		DS:BX -> Drive Parameter Block (DPB) (see #0620) for specified
			  drive
	    FFh invalid or network drive
Notes:	the OS/2 compatibility box supports the DOS 3.3 version of this call
	  except for the DWORD at offset 12h
	this call updates the DPB by reading the disk; the DPB may be accessed
	  via the DOS list of lists (see #0840 at AH=52h) if disk access is not
	  desirable.
	undocumented prior to the release of DOS 5.0; only the DOS 4.0+
	  version of the DPB has been documented, however
	supported by DR-DOS 3.41+; DR-DOS 3.41-6.0 return the same data as
	  MS-DOS 3.31
SeeAlso: AH=1Fh,AH=52h

Format of DOS Drive Parameter Block:
Offset	Size	Description	(Table 0620)
 00h	BYTE	drive number (00h = A:, 01h = B:, etc)
 01h	BYTE	unit number within device driver
 02h	WORD	bytes per sector
 04h	BYTE	highest sector number within a cluster
 05h	BYTE	shift count to convert clusters into sectors
 06h	WORD	number of reserved sectors at beginning of drive
 08h	BYTE	number of FATs
 09h	WORD	number of root directory entries
 0Bh	WORD	number of first sector containing user data
 0Dh	WORD	highest cluster number (number of data clusters + 1)
		16-bit FAT if greater than 0FF6h, else 12-bit FAT
 0Fh	BYTE	number of sectors per FAT
 10h	WORD	sector number of first directory sector
 12h	DWORD	address of device driver header
 16h	BYTE	media ID byte (see #0581)
 17h	BYTE	00h if disk accessed, FFh if not
 18h	DWORD	pointer to next DPB
---DOS 2.x---
 1Ch	WORD	cluster containing start of current directory, 0000h=root,
		FFFFh = unknown
 1Eh 64 BYTEs	ASCIZ pathname of current directory for drive
---DOS 3.x---
 1Ch	WORD	cluster at which to start search for free space when writing
 1Eh	WORD	number of free clusters on drive, FFFFh = unknown
---DOS 4.0-6.0---
 0Fh	WORD	number of sectors per FAT
 11h	WORD	sector number of first directory sector
 13h	DWORD	address of device driver header
 17h	BYTE	media ID byte (see #0581)
 18h	BYTE	00h if disk accessed, FFh if not
 19h	DWORD	pointer to next DPB
 1Dh	WORD	cluster at which to start search for free space when writing,
		usually the last cluster allocated
 1Fh	WORD	number of free clusters on drive, FFFFh = unknown
SeeAlso: #0875
--------D-2133-------------------------------
INT 21 - DOS 2+ - EXTENDED BREAK CHECKING
	AH = 33h
	AL = subfunction
	    00h get current extended break state
		Return: DL = current state, 00h = off, 01h = on
	    01h set state of extended ^C/^Break checking
		DL = new state
		    00h off, check only on character I/O functions
		    01h on, check on all DOS functions
		Return: (Novell DOS 7) DL = old state of extended Break checks
Note:	under DOS 3.1+ and DR-DOS, this function does not use any of the
	  DOS-internal stacks and may thus be called at any time
SeeAlso: AX=3302h
--------D-213302-----------------------------
INT 21 - DOS 3.x+ internal - GET AND SET EXTENDED CONTROL-BREAK CHECKING STATE
	AX = 3302h
	DL = new state (00h for OFF, 01h for ON)
Return: DL = old state of extended BREAK checking
Notes:	this function does not use any of the DOS-internal stacks and may thus
	  be called at any time; one possible use is modifying Control-Break
	  checking from within an interrupt handler or TSR
	not supported by DR-DOS through version 6.0; newly-supported by
	  Novell DOS 7
SeeAlso: AH=33h
--------D-213303-----------------------------
INT 21 - DOS 4.0+ - UNUSED
	AX = 3303h
Return: nothing
Note:	this function and AX=3304h were apparently intended to support a
	  code-page switching flag for OS/2 compatibility (OS/2 allows a file
	  to have a code page as an attribute); however, this function has
	  always been a NOP in public releases of DOS.	See _DOS_Internals_
	  Chapter 2 for more information
SeeAlso: AX=3304h
--------D-213304-----------------------------
INT 21 - DOS 4.0+ - UNUSED
	AX = 3304h
Return: nothing
Note:	this function and AX=3303h were apparently intended to support a
	  code-page switching flag for OS/2 compatibility (OS/2 allows a file
	  to have a code page as an attribute); however, this function has
	  always been a NOP in public releases of DOS.	See _DOS_Internals_
	  Chapter 2 for more information
SeeAlso: AX=3303h
--------D-213305-----------------------------
INT 21 - DOS 4.0+ - GET BOOT DRIVE
	AX = 3305h
Return: DL = boot drive (1=A:,...)
Notes:	fully reentrant
	NEC 9800-series PCs always call the boot drive A: and assign the other
	  drive letters sequentially to the other drives in the system
	this call is supported by OS/2 Warp 3.0, but not earlier versions of
	  OS/2; it is also supported by Novell DOS 7
--------D-213306-----------------------------
INT 21 - DOS 5+ - GET TRUE VERSION NUMBER
	AX = 3306h
Return: BL = major version
	BH = minor version
	DL = revision (bits 2-0, all others 0)
	DH = version flags
	    bit 3: DOS is in ROM
	    bit 4: DOS is in HMA
	AL = FFh if true DOS version < 5.0
Notes:	this function always returns the true version number, unlike AH=30h,
	  whose return value may be changed with SETVER
	because of the conflict from the CBIS PowerLAN redirector (see next
	  entry), programs should check whether BH is less than 100 (64h)
	  and BL is at least 5 before accepting the returned BX as the true
	  version number; however, even this is not entirely reliable when
	  that redirector is loaded
	fully reentrant
	OS/2 v2.1 will return BX=0A14h (version 20.10)
	the Windows NT DOS box returns BX=3205h (version 5.50)
	Novell DOS 7 returns IBM v6.00, which some software displays as
	  IBM DOS v6.10 (because of the version mismatch in true IBM DOS
	  mentioned for INT 21/AH=30h)
BUG:	DR-DOS 5.0 and 6.0 return CF set/AX=0001h for INT 21/AH=33h
	  subfunctions other than 00h-02h and 05h, while MS-DOS returns AL=FFh
	  for invalid subfunctions
SeeAlso: AH=30h,INT 2F/AX=122Fh
--------N-213306-----------------------------
INT 21 - CBIS POWERLAN - NETWORK REDIRECTOR - ???
	AX = 3306h
Return: AX = 3306h
	BL = ??? (usually 00h)
	BH = ??? (usually 00h or FFh)
Note:	unknown function, is in conflict with DOS 5+ version call
SeeAlso: AX=3306h"DOS"
--------v-21330F-----------------------------
INT 21 - VIRUS - "Burghofer" - INSTALLATION CHECK
	AX = 330Fh
Return: AL = 0Fh if resident (DOS returns AL=FFh)
SeeAlso: AX=30F1h,AX=33DAh,AX=33E0h
--------k-213341-----------------------------
INT 21 - Diet Disk v1.0 - INSTALLATION CHECK
	AX = 3341h
Return: DX = 1234h if installed
	    CX = resident code segment
Program: Diet Disk is a public domain transparent data file compressor by
	  Barry Nance
--------v-2133DA------------------------
INT 21 - VIRUS - "CoffeeShop" - INSTALLATION CHECK
	AX = 33DAh
Return: AH = A5h if resident
	    AL = virus version
SeeAlso: AX=330Fh,AX=33E0h,AX=5643h"VIRUS"
--------v-2133E0-----------------------------
INT 21 - VIRUS - "Oropax" - INSTALLATION CHECK
	AX = 33E0h
Return: AL = E0h if resident (DOS returns AL=FFh)
SeeAlso: AX=330Fh,AX=33DAh,AX=357Fh
--------D-2134-------------------------------
INT 21 - DOS 2+ - GET ADDRESS OF INDOS FLAG
	AH = 34h
Return: ES:BX -> one-byte InDOS flag
Notes:	this function executes on the DOS stack, and thus cannot be called
	  while another DOS function is already executing; you should use
	  this function once at the beginning of the program and store the
	  returned pointer rather than calling it when requiring DOS access
	the value of InDOS is incremented whenever an INT 21 function begins
	  and decremented whenever one completes
	during an INT 28 call, it is safe to call some INT 21 functions even
	  though InDOS may be 01h instead of zero
	InDOS alone is not sufficient for determining when it is safe to
	  enter DOS, as the critical error handling decrements InDOS and
	  increments the critical error flag for the duration of the critical
	  error.  Thus, it is possible for InDOS to be zero even if DOS is
	  busy.
	SMARTDRV 4.0 sets the InDOS flag while flushing its buffers to disk,
	  then zeros it on completion
	the critical error flag is the byte immediately following InDOS in
	  DOS 2.x, and the byte BEFORE the InDOS flag in DOS 3.0+ and
	  DR-DOS 3.41+ (except COMPAQ DOS 3.0, where the critical error flag
	  is located 1AAh bytes BEFORE the critical section flag)
	for DOS 3.1+, an undocumented call exists to get the address of the
	  critical error flag (see AX=5D06h)
	this function was undocumented prior to the release of DOS 5.0.
SeeAlso: AX=5D06h,AX=5D0Bh,INT 15/AX=DE1Fh,INT 28
--------D-2135-------------------------------
INT 21 - DOS 2+ - GET INTERRUPT VECTOR
	AH = 35h
	AL = interrupt number
Return: ES:BX -> current interrupt handler
Note:	under DR-DOS 5.0+, this function does not use any of the DOS-internal
	  stacks and may thus be called at any time
SeeAlso: AH=25h,AX=2503h
--------E-213501-----------------------------
INT 21 P - FlashTek X-32VM - ALLOCATE PROTECTED-MODE SELECTOR
	AX = 3501h
Return: CF clear if successful
	    BX = new selector
	CF set on error (no more selectors available)
Note:	the new selector will be an expand-up read/write data selector with
	  undefined base and limit
SeeAlso: AX=3502h,INT 31/AX=0000h
--------E-213502-----------------------------
INT 21 P - FlashTek X-32VM - DEALLOCATE PROTECTED-MODE SELECTOR
	AX = 3502h
	BX = selector
Return: CF clear if successful
	CF set on error (invalid selector)
Note:	only selectors allocated via AX=3501h should be deallocated
SeeAlso: AX=3501h,INT 31/AX=0001h
--------E-213503-----------------------------
INT 21 P - FlashTek X-32VM - SET SELECTOR BASE ADDRESS
	AX = 3503h
	BX = selector
	ECX = base address
Return: CF clear if successful
	CF set on error (invalid selector)
SeeAlso: AX=3504h,AX=3505h,INT 31/AX=0007h
--------E-213504-----------------------------
INT 21 P - FlashTek X-32VM - GET SELECTOR BASE ADDRESS
	AX = 3504h
	BX = selector
Return: CF clear if successful
	    ECX = absolute base address of selector
	CF set on error (invalid selector)
SeeAlso: AX=3503h,INT 31/AX=0006h
--------E-213505-----------------------------
INT 21 P - FlashTek X-32VM - SET SELECTOR LIMIT
	AX = 3505h
	BX = selector
	ECX = desired limit
Return: CF clear if successful
	    ECX = actual limit set
	CF set on error (no more selectors available)
Note:	the limit will be rounded down to nearest 4K boundary if the requested
	  limit is greater than 1MB
SeeAlso: AX=3503h,INT 31/AX=0008h
--------E-21350A-----------------------------
INT 21 P - FlashTek X-32VM - PHYSICAL ADDRESS MAPPING
	AX = 350Ah
	EBX = absolute physical address
	ECX = size in bytes of area to map
Return: CF clear if successful
	CF set on error (insufficient memory or service refused by DPMI host)
Notes:	should not make repeated calls for the same physical address
	there is no provision for unmapping memory
--------E-21350B-----------------------------
INT 21 P - FlashTek X-32VM - UPDATE AND RETURN AVAILABLE FREE MEMORY
	AX = 350Bh
	DS = default selector for DS
Return: CF clear
	EAX = maximum amount of memory which can be allocated via AX=350Ch
SeeAlso: AX=350Ch
--------E-21350C-----------------------------
INT 21 P - FlashTek X-32VM - ALLOCATE A BLOCK OF MEMORY
	AX = 350Ch
	ECX = size of block in bytes
	DS = default DS
Return: CF clear if successful
	    EAX = near pointer to new block
	    EDX = new lowest legal value for stack
	CF set on error (requested size not multiple of 4K)
SeeAlso: AX=350Bh,AX=350Dh
--------E-21350D-----------------------------
INT 21 P - FlashTek X-32VM - RESERVE BLOCK OF MEMORY FOR 32-BIT STACK
	AX = 350Dh
	EBX = current ESP value
	ECX = size of block in bytes
	DS = default DS
Return: CF clear if successful
	    EBX = new value for ESP
	    EDX = suggested new limit for SS
	CF set on error
Note:	this function should only be called once during initialization
SeeAlso: AX=350Bh,AX=350Ch
--------v-21357F-----------------------------
INT 21 - VIRUS - "Agiplan"/"Month 4-6" - INSTALLATION CHECK
	AX = 357Fh
Return: DX = FFFFh if installed
SeeAlso: AX=33E0h,AX=3DFFh
--------D-2136-------------------------------
INT 21 - DOS 2+ - GET FREE DISK SPACE
	AH = 36h
	DL = drive number (00h = default, 01h = A:, etc)
Return: AX = FFFFh if invalid drive
	else
	    AX = sectors per cluster
	    BX = number of free clusters
	    CX = bytes per sector
	    DX = total clusters on drive
Notes:	free space on drive in bytes is AX * BX * CX
	total space on drive in bytes is AX * CX * DX
	"lost clusters" are considered to be in use
	according to Dave Williams' MS-DOS reference, the value in DX is
	  incorrect for non-default drives after ASSIGN is run
SeeAlso: AH=1Bh,AH=1Ch
--------D-213700-----------------------------
INT 21 - DOS 2+ - "SWITCHAR" - GET SWITCH CHARACTER
	AX = 3700h
Return: AL = status
	    00h successful
		DL = current switch character
	    FFh unsupported subfunction
Desc:	Determine the character which is used to introduce command switches.
	  This setting is ignored by MS-DOS commands in version 4.0 and higher,
	  but is honored by many third-party programs and by Novell DOS 7
	  external commands
BUG:	Novell DOS 7's COMMAND.COM fails to honor the SwitChar setting for
	  internal commands even though COMMAND.COM honors it in its own
	  command tail (i.e. COMMAND /?)
Notes:	documented in some OEM versions of some releases of DOS
	supported by OS/2 compatibility box
	always returns AL=00h/DL=2Fh for MS-DOS 5+ and DR-DOS 3.41-6.0
	Novell DOS 7 COMMAND.COM indicates switch characters other than '/'
	  by changing the first backslash (and only the first one) in the
	  path it prints for PROMPT $p with a forward slash
SeeAlso: AX=3701h
--------D-213701-----------------------------
INT 21 - DOS 2+ - "SWITCHAR" - SET SWITCH CHARACTER
	AX = 3701h
	DL = new switch character
Return: AL = status
	    00h successful
	    FFh unsupported subfunction
Notes:	documented in some OEM versions of some releases of DOS
	supported by OS/2 compatibility box and Novell DOS 7
	ignored by MS-DOS 5+ and DR-DOS 3.41-6.0; DR-DOS 6.0 and Novell DOS 7
	  leave AX unchanged
SeeAlso: AX=3700h
--------D-2137-------------------------------
INT 21 - DOS 2.x and 3.3+ only - "AVAILDEV" - SPECIFY \DEV\ PREFIX USE
	AH = 37h
	AL = subfunction
	    02h get availdev flag
		Return: DL = 00h \DEV\ must precede character device names
			   = nonzero \DEV\ is optional
	    03h set availdev flag
		DL = new state
		    00h		\DEV\ is mandatory
		    nonzero	\DEV\ is optional
Return: AL = status
	    00h successful
	    FFh unsupported subfunction
Notes:	all versions of DOS from 2.00 allow \DEV\ to be prepended to device
	  names without generating an error even if the directory \DEV does
	  not actually exist (other paths generate an error if they do not
	  exist).
	although MS-DOS 3.3+, DR-DOS 3.41+, and Novell DOS 7 accept these
	  calls, they have no effect, and AL=02h always returns DL=FFh (except
	  for Novell DOS 7, which leaves AX unchanged for both subfunctions)
--------k-2137D0BX899D-----------------------
INT 21 - DIET v1.43e - TSR INSTALLATION CHECK
	AX = 37D0h
	BX = 899Dh ('DI' + 'ET')
Return: AL = FFh if not present as TSR (default return value from DOS)
	AX = 0000h if installed as a TSR
	    CX = 899Dh
	    DX = version ID
Program: DIET is a transparent file copressor/decompressor by Teddy Matsumoto
SeeAlso: AX=37D1h,AX=37D2h,AX=37D4h,AX=37D6h,AX=37DFh,AX=4BF0h,AX=4BF1h
--------k-2137D1BX899D-----------------------
INT 21 - DIET v1.43e - GET DIET.EXE RESIDENT SEGMENT
	AX = 37D1h
	BX = 899Dh ('DI' + 'ET')
Return: AX = 0000h
	CX = code segment of TSR part of DIET.EXE
	DX = memory block segment of TSR DIET.EXE
		(0000h if installed as device driver)
SeeAlso: AX=37D0h,AX=37DFh
--------k-2137D2BX899D-----------------------
INT 21 - DIET v1.43e - GET TSR CONTROL FLAGS
	AX = 37D2h
	BX = 899Dh ('DI' + 'ET')
Return: AX = 0000h
	DL = control flag (00h active, else disabled)
	DH = skip flag (nonzero while TSR active)
SeeAlso: AX=37D0h,AX=37D3h,AX=37D4h
--------k-2137D3BX899D-----------------------
INT 21 - DIET v1.43e - SET TSR CONTROL FLAGS
	AX = 37D3h
	BX = 899Dh ('DI' + 'ET')
	DL = control flag (00h active, else disabled)
	DH = skip flag (00h)
Return: AX = 0000h
SeeAlso: AX=37D0h,AX=37D2h,AX=37D5h
--------k-2137D4BX899D-----------------------
INT 21 - DIET v1.43e - GET TSR OPTIONS
	AX = 37D4h
	BX = 899Dh ('DI' + 'ET')
Return: AX = 0000h
	DX = TSR options (see #0621)
SeeAlso: AX=37D0h,AX=37D2h,AX=37D5h

Bitfields for DIET TSR options:
Bit(s)	Description	(Table 0621)
 0	automated compression of DIETed file
 1	automated compression of newly-created file
 2	suppress DIET message
 3	display original file size
 4-15	reserved (0)
--------k-2137D5BX899D-----------------------
INT 21 - DIET v1.43e - SET TSR OPTIONS
	AX = 37D5h
	BX = 899Dh ('DI' + 'ET')
	DX = TSR options (see #0621)
Return: AX = 0000h
Program: DIET is a transparent file copressor/decompressor by Teddy Matsumoto
SeeAlso: AX=37D0h,AX=37D3h,AX=37D4h
--------k-2137D6BX899D-----------------------
INT 21 - DIET v1.43e - GET TEMPORARY DIRECTORY NAMES
	AX = 37D6h
	BX = 899Dh ('DI' + 'ET')
Return: AX = 0000h
	DS:DX -> name of temporary directory or 0000h:0000h for current dir
SeeAlso: AX=37D0h,AX=37D7h
--------k-2137D7BX899D-----------------------
INT 21 - DIET v1.43e - SET TEMPORARY DIRECTORY NAMES
	AX = 37D7h
	BX = 899Dh ('DI' + 'ET')
	DS:DX -> ASCIZ name of temporary directory (max 61 chars)
		0000h:0000h for current directory
Return: AX = 0000h
Note:	the specified directory name must include a drive letter and end with
	  a backslash
SeeAlso: AX=37D0h,AX=37D6h
--------k-2137DCBX899D-----------------------
INT 21 - DIET v1.43e - SET ADDRESS OF EXTERNAL PROCEDURE
	AX = 37DCh
	BX = 899Dh ('DI' + 'ET')
	DS:DX -> external procedure (see #0622)
Return: AX = 0000h
Note:	the resident code will call the specified external procedure at the
	  beginning of decompression and when compression is exited on failure
SeeAlso: AX=37DDh

(Table 0622)
Values DIET external procedure is called with:
	STACK:	WORD	class
			FFFDh creation failed for unknown reasons
			FFFEh creation failed due to lack of space
			FFFFh file creation error
			else file handle of DIETed file to be decompressed
		DWORD	-> compressed filename
		DWORD	-> decompressed or temporary filename
Return: SI,DI,BP,DS,ES must be preserved by external procedure
--------k-2137DDBX899D-----------------------
INT 21 - DIET v1.43e - RELEASE EXTERNAL PROCEDURE
	AX = 37DDh
	BX = 899Dh ('DI' + 'ET')
Program: DIET is a transparent file copressor/decompressor by Teddy Matsumoto
Note:	unlinks the external procedure specified by AX=37DCh
SeeAlso: AX=37DCh
--------k-2137DEBX899D-----------------------
INT 21 - DIET v1.43e - READ EMS STATUS
	AX = 37DEh
	BX = 899Dh ('DI' + 'ET')
Return: AX = 0000h
	CX = EMS status
	    0000h not used
	    0001h used as work area
	    0002h used for code and as work area
	DX = EMM handle when EMS is in use
--------k-2137DFBX899D-----------------------
INT 21 - DIET v1.43e - UNLOAD TSR
	AX = 37DFh
	BX = 899Dh ('DI' + 'ET')
Return: AX = status
	    0000h successful
	    00FFh failed
Program: DIET is a transparent file copressor/decompressor by Teddy Matsumoto
SeeAlso: AX=37D0h
Index:	uninstall;DIET
--------D-2138-------------------------------
INT 21 - DOS 2+ - GET COUNTRY-SPECIFIC INFORMATION
	AH = 38h
--DOS 2.x--
	AL = 00h get current-country info
	DS:DX -> buffer for returned info (see #0623,#0624)
Return: CF set on error
	    AX = error code (02h)
	CF clear if successful
	    AX = country code (MS-DOS 2.11 only)
	    buffer at DS:DX filled
--DOS 3.0+--
	AL = 00h for current country
	AL = 01h thru 0FEh for specific country with code <255 (see #0625)
	AL = 0FFh for specific country with code >= 255
	   BX = 16-bit country code (see #0625)
	DS:DX -> buffer for returned info (see #0624)
Return: CF set on error
	    AX = error code (02h)
	CF clear if successful
	    AX = country code (Novell NWDOS v7.0)
	    BX = country code
	    DS:DX buffer filled
Note:	this function is not supported by the Borland DPMI host, but no error
	  is returned; as a workaround, one should allocate a buffer in
	  conventional memory with INT 31/AX=0100h and simulate an INT 21 with
	  INT 31/AX=0300h
SeeAlso: AH=65h,INT 10/AX=5001h,INT 2F/AX=110Ch,INT 2F/AX=1404h

Format of DOS 2.00-2.10 country info:
Offset	Size	Description	(Table 0623)
 00h	WORD	date format  0 = USA	mm dd yy
			     1 = Europe dd mm yy
			     2 = Japan	yy mm dd
 02h	BYTE	currency symbol
 03h	BYTE	00h
 04h	BYTE	thousands separator char
 05h	BYTE	00h
 06h	BYTE	decimal separator char
 07h	BYTE	00h
 08h 24 BYTEs	reserved

Format of DOS 2.11+ country info:
Offset	Size	Description	(Table 0624)
 00h	WORD	date format (see #0623)
 02h  5 BYTEs	ASCIZ currency symbol string
 07h  2 BYTEs	ASCIZ thousands separator
 09h  2 BYTEs	ASCIZ decimal separator
 0Bh  2 BYTEs	ASCIZ date separator
 0Dh  2 BYTEs	ASCIZ time separator
 0Fh	BYTE	currency format
		bit 2 = set if currency symbol replaces decimal point
		bit 1 = number of spaces between value and currency symbol
		bit 0 = 0 if currency symbol precedes value
			1 if currency symbol follows value
 10h	BYTE	number of digits after decimal in currency
 11h	BYTE	time format
		bit 0 = 0 if 12-hour clock
			1 if 24-hour clock
 12h	DWORD	address of case map routine
		(FAR CALL, AL = character to map to upper case [>= 80h])
 16h  2 BYTEs	ASCIZ data-list separator
 18h 10 BYTEs	reserved

(Table 0625)
Values for country code:
 001h	United States
 002h	Canadian-French
 003h	Latin America
 01Fh	Netherlands
 020h	Belgium
 021h	France
 022h	Spain
 024h	Hungary (not supported by DR-DOS 5.0)
 026h	Yugoslavia (not supported by DR-DOS 5.0)
 027h	Italy
 029h	Switzerland
 02Ah	Czechoslovakia/Tjekia (not supported by DR-DOS 5.0)
 02Bh	Austria (DR-DOS 5.0)
 02Ch	United Kingdom
 02Dh	Denmark
 02Eh	Sweden
 02Fh	Norway
 030h	Poland (not supported by DR-DOS 5.0)
 031h	Germany
 037h	Brazil (not supported by DR-DOS 5.0)
 03Dh	International English [Australia in DR-DOS 5.0]
 051h	Japan (DR-DOS 5.0, MS-DOS 5.0+)
 052h	Korea (DR-DOS 5.0)
 056h	China (MS-DOS 5.0+)
 058h	Taiwan (MS-DOS 5.0+)
 05Ah	Turkey (MS-DOS 5.0+)
 15Fh	Portugal
 162h	Iceland
 166h	Finland
 311h	Middle East/Saudi Arabia (DR-DOS 5.0,MS-DOS 5.0+)
 3CCh	Israel (DR-DOS 5.0,MS-DOS 5.0+)
--------D-2138--DXFFFF-----------------------
INT 21 - DOS 3.0+ - SET COUNTRY CODE
	AH = 38h
	DX = FFFFh
	AL = 01h thru FEh for specific country with code <255
	AL = FFh for specific country with code >= 255
	   BX = 16-bit country code (see #0625)
Return: CF set on error
	    AX = error code (see #0885 at AH=59h)
	CF clear if successful
Note:	not supported by OS/2
SeeAlso: INT 2F/AX=1403h
--------D-2139-------------------------------
INT 21 - DOS 2+ - "MKDIR" - CREATE SUBDIRECTORY
	AH = 39h
	DS:DX -> ASCIZ pathname
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (03h,05h) (see #0885 at AH=59h)
Notes:	all directories in the given path except the last must exist
	fails if the parent directory is the root and is full
	DOS 2.x-3.3 allow the creation of a directory sufficiently deep that
	  it is not possible to make that directory the current directory
	  because the path would exceed 64 characters
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
SeeAlso: AH=3Ah,AH=3Bh,AH=6Dh,AH=71h,AH=E2h/SF=0Ah,INT 2F/AX=1103h
SeeAlso: INT 60/DI=0511h
--------D-213A-------------------------------
INT 21 - DOS 2+ - "RMDIR" - REMOVE SUBDIRECTORY
	AH = 3Ah
	DS:DX -> ASCIZ pathname of directory to be removed
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (03h,05h,06h,10h) (see #0885 at AH=59h)
Notes:	directory must be empty (contain only '.' and '..' entries)
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
SeeAlso: AH=39h,AH=3Bh,AH=71h,AH=E2h/SF=0Bh,INT 2F/AX=1101h,INT 60/DI=0512h
--------D-213B-------------------------------
INT 21 - DOS 2+ - "CHDIR" - SET CURRENT DIRECTORY
	AH = 3Bh
	DS:DX -> ASCIZ pathname to become current directory (max 64 bytes)
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (03h) (see #0885 at AH=59h)
Notes:	if new directory name includes a drive letter, the default drive is
	  not changed, only the current directory on that drive
	changing the current directory also changes the directory in which
	  FCB file calls operate
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
SeeAlso: AH=47h,AH=71h,INT 2F/AX=1105h
--------D-213C-------------------------------
INT 21 - DOS 2+ - "CREAT" - CREATE OR TRUNCATE FILE
	AH = 3Ch
	CX = file attributes (see #0626)
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    AX = file handle
	CF set on error
	    AX = error code (03h,04h,05h) (see #0885 at AH=59h)
Notes:	if a file with the given name exists, it is truncated to zero length
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
	DR-DOS checks the system password or explicitly supplied password at
	  the end of the filename against the reserved field in the directory
	  entry before allowing access
SeeAlso: AH=16h,AH=3Dh,AH=5Ah,AH=5Bh,AH=93h,INT 2F/AX=1117h

Bitfields for file attributes:
Bit(s)	Description	(Table 0626)
 0	read-only
 1	hidden
 2	system
 3	volume label (ignored)
 4	reserved, must be zero (directory)
 5	archive bit
 7	if set, file is shareable under Novell NetWare
--------D-213D-------------------------------
INT 21 - DOS 2+ - "OPEN" - OPEN EXISTING FILE
	AH = 3Dh
	AL = access and sharing modes (see #0627)
	DS:DX -> ASCIZ filename
	CL = attribute mask of files to look for (server call only)
Return: CF clear if successful
	    AX = file handle
	CF set on error
	    AX = error code (01h,02h,03h,04h,05h,0Ch,56h) (see #0885 at AH=59h)
Notes:	file pointer is set to start of file
	file handles which are inherited from a parent also inherit sharing
	  and access restrictions
	files may be opened even if given the hidden or system attributes
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
	DR-DOS checks the system password or explicitly supplied password at
	  the end of the filename against the reserved field in the directory
	  entry before allowing access
	sharing modes are only effective on local drives if SHARE is loaded
BUG:	Novell DOS 7 SHARE v1.00 would refuse file access in the cases in
	  #0628 marked with [1] (read-only open of a read-only file
	  which had previously been opened in compatibility mode); this was
	  fixed in SHARE v1.01 of 09/29/94
SeeAlso: AH=0Fh,AH=3Ch,AX=4301h,AX=5D00h,INT 2F/AX=1116h,INT 2F/AX=1226h

Bitfields for access and sharing modes:
Bit(s)	Description	(Table 0627)
 2-0	access mode
	000 read only
	001 write only
	010 read/write
	011 (DOS 5+ internal) passed to redirector on EXEC to allow
		case-sensitive filenames
 3	reserved (0)
 6-4	sharing mode (DOS 3.0+) (see #0628)
	000 compatibility mode
	001 "DENYALL" prohiboth read and write access by others
	010 "DENYWRITE" prohiwrite access by others
	011 "DENYREAD" prohiread access by others
	100 "DENYNONE" allow full access by others
	111 network FCB (only available during server call)
 7	inheritance
	if set, file is private to current process and will not be inherited
	  by child processes

(Table 0628)
Values of DOS file sharing behavior:
	  |	Second and subsequent Opens
 First	  |Compat  Deny	  Deny	 Deny	Deny
 Open	  |	   All	  Write	 Read	None
	  |R W RW R W RW R W RW R W RW R W RW
 - - - - -| - - - - - - - - - - - - - - - - -
 Compat R |Y Y Y  N N N	 1 N N	N N N  1 N N
	W |Y Y Y  N N N	 N N N	N N N  N N N
	RW|Y Y Y  N N N	 N N N	N N N  N N N
 - - - - -|
 Deny	R |C C C  N N N	 N N N	N N N  N N N
 All	W |C C C  N N N	 N N N	N N N  N N N
	RW|C C C  N N N	 N N N	N N N  N N N
 - - - - -|
 Deny	R |2 C C  N N N	 Y N N	N N N  Y N N
 Write	W |C C C  N N N	 N N N	Y N N  Y N N
	RW|C C C  N N N	 N N N	N N N  Y N N
 - - - - -|
 Deny	R |C C C  N N N	 N Y N	N N N  N Y N
 Read	W |C C C  N N N	 N N N	N Y N  N Y N
	RW|C C C  N N N	 N N N	N N N  N Y N
 - - - - -|
 Deny	R |2 C C  N N N	 Y Y Y	N N N  Y Y Y
 None	W |C C C  N N N	 N N N	Y Y Y  Y Y Y
	RW|C C C  N N N	 N N N	N N N  Y Y Y
Legend: Y = open succeeds, N = open fails with error code 05h
	C = open fails, INT 24 generated
	1 = open succeeds if file read-only, else fails with error code
	2 = open succeeds if file read-only, else fails with INT 24
SeeAlso: #0848
--------v-213DFF-----------------------------
INT 21 - VIRUS - "JD-448" - INSTALLATION CHECK
	AX = 3DFFh
Return: AX = 4A44h if resident
SeeAlso: AX=357Fh,AX=4203h
--------D-213E-------------------------------
INT 21 - DOS 2+ - "CLOSE" - CLOSE FILE
	AH = 3Eh
	BX = file handle
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (06h) (see #0885 at AH=59h)
Note:	if the file was written to, any pending disk writes are performed, the
	  time and date stamps are set to the current time, and the directory
	  entry is updated
SeeAlso: AH=10h,AH=3Ch,AH=3Dh,INT 2F/AX=1106h,INT 2F/AX=1227h
--------D-213F-------------------------------
INT 21 - DOS 2+ - "READ" - READ FROM FILE OR DEVICE
	AH = 3Fh
	BX = file handle
	CX = number of bytes to read
	DS:DX -> buffer for data
Return: CF clear if successful
	    AX = number of bytes actually read (0 if at EOF before call)
	CF set on error
	    AX = error code (05h,06h) (see #0885 at AH=59h)
Notes:	data is read beginning at current file position, and the file position
	  is updated after a successful read
	the returned AX may be smaller than the request in CX if a partial
	  read occurred
	if reading from CON, read stops at first CR
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
BUG:	Novell NETX.EXE v3.26 and 3.31 do not set CF if the read fails due to
	  a record lock (see AH=5Ch), though it does return AX=0005h; this
	  has been documented by Novell
SeeAlso: AH=27h,AH=40h,AH=93h,INT 2F/AX=1108h,INT 2F/AX=1229h
--------G-213F-------------------------------
INT 21 - Turbo Debug HARDWARE BREAKPOINTS - READ STATUS BLOCK
	AH = 3Fh
	BX = handle for character device "TDHDEBUG"
	CX = number of bytes to read
	DS:DX -> buffer for status block (see #0630)
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (05h,06h) (see #0885 at AH=59h)
SeeAlso: AH=40h"Turbo Debug"

(Table 0629)
Values for status of Turbo Debugger command:
 00h	successful
 01h	invalid handle
 02h	no more breakpoints available
 03h	hardware does not support specified breakpoint type
 04h	previous command prevents execution
 05h	debugger hardware not found
 06h	hardware failure
 07h	invalid command
 08h	driver not initialized yet
 FEh	recursive entry (hardware breakpoint inside hw bp handler)

Format of Turbo Debugger status block:
Offset	Size	Description	(Table 0630)
 00h	BYTE	status of command (see #0629)
---status for command 01h---
 01h	WORD	device driver interface version number (currently 1)
 03h	WORD	device driver software version
 05h	BYTE	maximum simultaneous hardware breakpoints
 06h	BYTE	configuration bits (see #0631)
 07h	BYTE	supported breakpoint types (see #0632)
 08h	WORD	supported addressing match modes (see #0633)
 0Ah	WORD	supported data matches (see #0634)
 0Ch	BYTE	maximum data match length (01h, 02h, or 04h)
 0Dh	WORD	size of onboard memory (in KB)
 0Fh	WORD	maximum number of trace-back events
 11h	WORD	hardware breakpoint enable byte address segment (0000h if not
		  supported)
---status for command 04h---
 01h	BYTE	handle to use when referring to the just-set breakpoint

Bitfields for Turbo Debugger configuration bits:
Bit(s)	Description	(Table 0631)
 0	CPU and DMA accesses are distinct
 1	can detect DMA transfers
 2	supports data mask
 3	hardware pass counter on breakpoints
 4	can match on data as well as addresses

Bitfields for Turbo Debugger supported breakpoint types:
Bit(s)	Description	(Table 0632)
 0	memory read
 1	memory write
 2	memory read/write
 3	I/O read
 4	I/O write
 5	I/O read/write
 6	instruction fetch

Bitfields for Turbo Debugger supported addressing match modes:
Bit(s)	Description	(Table 0633)
 0	any address
 1	equal to test value
 2	not equal
 3	above test value
 4	below test value
 5	below or equal
 6	above or equal
 7	within range
 8	outside range

Bitfields for Turbo Debugger supported data matches:
Bit(s)	Description	(Table 0634)
 0	any data
 1	equal to test value
 2	not equal
 3	above test value
 4	below test value
 5	below or equal
 6	above or equal
 7	within range
 8	outside range
--------N-213F-------------------------------
INT 21 - PC/TCP IPCUST.SYS - READ CONFIGURATION DATA
	AH = 3Fh
	BX = handle for character device "$IPCUST"
	CX = number of bytes to read
	DS:DX -> buffer for configuration data (see #0635)
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (05h,06h) (see #0885 at AH=59h)
Notes:	if less than the entire data is read or written, the next read/write
	  continues where the previous one ended; IOCTL calls AX=4402h and
	  AX=4403h both reset the location at which the next operation starts
	  to zero
	the data pointer is also reset to zero if the previous read or write
	  reached or exceeded the end of the data, when the current function
	  is read and the previous was write, or vice versa
	v2.1+ uses a new configuration method, but allows the installation
	  of IPCUST.SYS for backward compatibility with other software which
	  must read the PC/TCP configuration
SeeAlso: AH=40h"IPCUST",AX=4402h"IPCUST",AX=4402h"FTPSOFT"

Format of PC/TCP configuration data:
Offset	Size	Description	(Table 0635)
 00h 12 BYTEs	IPCUST.SYS device driver header
 12h	BYTE	???
 13h	BYTE	???
 14h	WORD	???
 16h	BYTE	bit flags
		bit 0: send BS rather than DEL for BackSpace key
		bit 1: wrap long lines
 17h	BYTE	???
 18h 64 BYTEs	ASCIZ hostname
 58h 64 BYTEs	ASCIZ domain name
		(fully qualified domain name is hostname.domain-name)
 98h 16 BYTEs	ASCIZ username
 A8h 64 BYTEs	ASCIZ full name
 E8h 64 BYTEs	ASCIZ office address
128h 32 BYTEs	ASCIZ phone number
148h	WORD	offset from GMT in minutes
14Ah  4 BYTEs	ASCIZ timezone name
14Eh	WORD	number of time servers
150h  ? DWORDs	(big-endian) IP addresses for time servers
	???
164h	WORD	number of old-style name servers
166h  3 DWORDs	(big-endian) IP addresses for name servers
172h	WORD	number of domain name servers
174h  3 DWORDs	(big-endian) IP addresses for domain name servers
180h	DWORD	(big-endian) IP address of default gateway
184h	DWORD	(big-endian) IP address of log server
188h	DWORD	(big-endian) IP address of cookie server
18Ch	DWORD	(big-endian) IP address of lpr server
190h	DWORD	(big-endian) IP address of imagen print server
194h 54 BYTEs	???
1E8h	WORD	TCP default window size in bytes
1EAh	WORD	TCP low window size
1ECh 64 BYTEs	ASCIZ host tabel filename
22Ch  2 BYTEs	???
22Eh 80 BYTEs	ASCIZ mail relay host name
27Eh	BYTE	???
27Fh	BYTE	??? bit flags
280h 44 BYTEs	???
2ACh	WORD	???
2AEh 202 BYTEs	???
--------N-213F-------------------------------
INT 21 - WORKGRP.SYS - GET ENTRY POINT
	AH = 3Fh
	BX = file handle for device "NET$HLP$"
	CX = 0008h
	DS:DX -> buffer for entry point record (see #0705)
Return: CF clear if successful
	    AX = number of bytes actually read (0 if at EOF before call)
	CF set on error
	    AX = error code (05h,06h) (see #0885 at AH=59h)
Program: WORKGRP.SYS is the portion of Microsoft's Workgroup Connection which
	  permits communication with PCs running Windows for Workgroups or
	  LAN Manager
SeeAlso: AX=4402h"WORKGRP.SYS",INT 2F/AX=9400h
--------N-213F-------------------------------
INT 21 - BW-TCP - GET DRIVER INFO
	AH = 3Fh
	BX = file handle for device "ETHDEV27"
	CX = 002Bh
	DS:DX -> buffer for driver info (see #0636)
Return: CF clear if successful
	    AX = number of bytes actually read (0 if at EOF before call)
	CF set on error
	    AX = error code (05h,06h) (see #0885 at AH=59h)
Program: BW-TCP is a TCP/IP protocol stack by Beame & Whiteside Software
Notes:	the B&W socket library performs an INT 21/AX=4401h with DX=0060h before
	  making this call to retrieve the driver information; one should also
	  call the private API interrupt with AH=15h
	the installation check for the TCP/IP stack is to test for the
	  existence of the character device UDP-IP10
SeeAlso: INT 14/AH=56h,INT 62/AH=00h"ETHDEV",INT 63/AH=03h,INT 64/AH=00h
Index:	installation check;BW-TCP hardware driver
Index:	installation check;BW-TCP TCPIP.SYS

Format of BW-TCP driver info:
Offset	Size	Description	(Table 0636)
 00h	WORD	I/O base address
 02h	BYTE	shared memory page (01h = segment 0100h, etc.)
 03h	BYTE	interrupt vector for private API
 04h	BYTE	IRQ used by board
 05h	WORD	size of data buffer
 07h	WORD	maximum transfer window
 09h	WORD	time zone
 0Bh	BYTE	address type (01h user, 04h RARP, 05h BOOTP)
 0Ch	DWORD	internet address
 10h	WORD	"value" ???
 12h	BYTE	subnet mask
 13h	WORD	"ether_pointer" ???
 15h	WORD	offset in device driver of log server records (see #0637)
 17h	WORD	offset in device driver of name server records (see #0637)
 19h	WORD	offset in device driver of print server records (see #0637)
 1Bh	WORD	offset in device driver of time server records (see #0637)
 1Dh	WORD	offset in device driver of gateway records (see #0637)
 1Fh	WORD	segment address of device driver
 21h	BYTE	transfer size
 22h  9 BYTEs	network adapter board name
---11/21/91+ ---
 23h	BYTE	ETHDEV version (major in high nybble, minor in low nybble)
 24h	BYTE	ETHDEV revision
 25h	BYTE	TCPIP version (major in high nybble, minor in low nybble)
 26h	BYTE	TCPIP revision
 27h	BYTE	BWRPC version (major in high nybble, minor in low nybble)
 28h	BYTE	BWRPC revision
 29h	BYTE	BWNFS version (major in high nybble, minor in low nybble)
 2Ah	BYTE	BWNFS revision
 2Bh	BYTE	Telnet version (major in high nybble, minor in low nybble)
 2Ch	BYTE	Telnet revision
 2Dh	BYTE	NETBIOS version (major in high nybble, minor in low nybble)
 2Eh	BYTE	NETBIOS revision
Note:	for each driver, if version=0, the driver is not installed or does
	  not support the version check

Format of BW-TCP server records:
Offset	Size	Description	(Table 0637)
 00h	BYTE	number of server records following
 01h  N DWORDs	internet addresses of servers
--------y-213F-------------------------------
INT 21 - Trusted Access - NB.SYS - GET STATE
	AH = 3Fh
	BX = file handle for device "$$NB$$NB"
	CX = 0002h (size of state)
	DS:DX -> buffer for state record (see #0638)
Return: CF clear if successful
	    AX = number of bytes actually read (0 if at EOF before call)
	CF set on error
	    AX = error code (05h,06h) (see #0885 at AH=59h)
Program: Trusted Access is a security and access-control package by Lassen
	  Software, Inc.; NB.SYS is a device driver to prevent the user from
	  terminating CONFIG.SYS or AUTOEXEC.BAT with Ctrl-Break
SeeAlso: AH=40h"NB.SYS",AX=4101h

Format of Trusted Access state record:
Offset	Size	Description	(Table 0638)
 00h	BYTE	00h off, 01h on
 01h	BYTE	keys being disabled
		bit 0: Ctrl-Break
		bit 1: SysReq
		bit 2: Ctrl and Alt
		bit 3: Ctrl-Alt-Del
		bit 7: all keys (overrides other bits)
----------213F-------------------------------
INT 21 U - IFSHLP.SYS - GET ENTRY POINT
	AH = 3Fh
	BX = file handle for device "IFS$HLP$"
	CX = 0008h (size of buffer in bytes)
	DS:DX -> buffer for entry point record (see #0639)
Return: CF clear if successful
	    AX = number of bytes actually read (0 if at EOF before call)
	CF set on error
	    AX = error code (05h,06h) (see #0885 at AH=59h)
Program: IFSHLP.SYS is a support driver for Microsoft Windows for Workgroups
SeeAlso: AX=4402h"IFSHLP"

Format of IFSHLP.SYS entry point record:
Offset	Size	Description	(Table 0639)
 00h  4 BYTEs	(call) signature 70h E9h 34h 37h
		signature must be 34h 37h 70h EFh if called via IOCTL
 04h	DWORD	(ret) pointer to FAR call entry point (see #0640)

(Table 0640)
Call IFSHLP.SYS entry point with:
	STACK:	WORD	function number (00h-0Ch)
			00h ???
			01h set ??? intercept
			02h remove ??? intercept
			03h ??? LPT2
			04h ??? LPT1
			05h ??? and remove ??? intercept
			06h set ??? flag
			07h clear ??? flag
			08h get ??? flag word
			09h ???
			0Ah ???
			0Bh ???
			0Ch get ???
---if function 00h---
Return: AX = ??? (0024h seen)
	DX = resident code segment
---if function 01h---
	STACK:	DWORD	new intercept address
Return: AX = status
	    0000h successful
	    0001h failed (already set)
		DX = 0000h
---if function 02h---
Return: AX = status
	    0000h successful
	    0001h failed (not set)
	DX = 0000h
---if function 03h,04h---
	STACK:	WORD	???
Return: AX = 0000h
	DX = 0000h
---if function 05h---
	???
---if function 06h---
Return: AX = 0001h and DX = 0000h if already set
	AX,DX unchanged if successful
---if function 07h---
Return: AX = 0001h and DX = 0000h if not set
	AX,DX unchanged if successful
---if function 08h---
Return: DX = 0000h
	AX = flags (bit 0 set/cleared by functions 06h and 07h)
---if function 09h---
Return: AX = status
	    0000h successful
	    0001h failed (already called)
---if function 0Ah---
	STACK:	WORD	???
	???
---if function 0Bh---
Return: AX = status
	    0000h successful
	    0001h failed (not set)
---if function 0Ch---
Return: AX = 0000h
	ES:BX -> ??? data
---if function > 0Ch---
Return:	AX = 0001h
	DX = 0000h
--------D-2140-------------------------------
INT 21 - DOS 2+ - "WRITE" - WRITE TO FILE OR DEVICE
	AH = 40h
	BX = file handle
	CX = number of bytes to write
	DS:DX -> data to write
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (05h,06h) (see #0885 at AH=59h)
Notes:	if CX is zero, no data is written, and the file is truncated or
	  extended to the current position
	data is written beginning at the current file position, and the file
	  position is updated after a successful write
	the usual cause for AX < CX on return is a full disk
BUG:	a write of zero bytes will appear to succeed when it actually failed
	  if the write is extending the file and there is not enough disk
	  space for the expanded file (DOS 5.0-6.0); one should therefore check
	  whether the file was in fact extended by seeking to 0 bytes from
	  the end of the file (INT 21/AX=4202h/CX=0/DX=0)
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
SeeAlso: AH=28h,AH=3Fh,AH=93h,INT 2F/AX=1109h
--------G-2140-------------------------------
INT 21 - Turbo Debug HARDWARE BREAKPOINTS - SEND CMD TO HARDWARE BRKPNT DRIVER
	AH = 40h
	BX = handle for character device "TDHDEBUG"
	CX = number of bytes to write
	DS:DX -> hardware breakpoint command (see #0641)
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (05h,06h) (see #0885 at AH=59h)
Note:	results are retrieved by reading from the device
SeeAlso: AH=3Fh"Turbo Debug"

Format of Turbo Debugger hardware breakpoint commands:
Offset	Size	Description	(Table 0641)
 00h	BYTE	command code
		00h install interrupt vectors
		01h get hardware capabilities
		02h enable hardware breakpoints
		03h disable hardware breakpoints
		04h set hardware breakpoint
		05h clear hardware breakpoint
		06h set I/O base address and reset hardware
		07h restore interrupt vectors
---command code 00h---
 01h	DWORD	pointer to Turbo Debugger entry point to be jumped to on
		  hardware breakpoint; call with CPU state the same as on
		  the breakpoint except for pushing AX and placing an entry
		  code (FFh if breakout button or breakpoint handle) in AH
---command code 04h---
 01h	BYTE	breakpoint type
		00h memory read
		01h memory write
		02h memory read/write
		03h I/O read
		04h I/O write
		05h I/O read/write
		06h instruction fetch
 02h	BYTE	address matching mode (see #0642)
 03h	DWORD	32-bit linear low address
 07h	DWORD	32-bit linear high address
 0Bh	WORD	pass count
 0Dh	BYTE	data size (01h, 02h, or 04h)
 0Eh	BYTE	source of matched bus cycle (01h CPU, 02h DMA, 03h either)
 0Fh	BYTE	data-matching mode (see #0642)
 10h	DWORD	low data value
 14h	DWORD	high data value
 18h	DWORD	data mask specifying which bits of the data are tested
---command code 05h---
 01h	BYTE	handle of breakpoint to clear (breakpoint returned from command
		  04h)
---command code 06h---
 01h	WORD	base address of hardware debugger board

(Table 0642)
Values for Turbo Debugger address/data matching mode:
 00h	match any
 01h	equal to test value
 02h	different from test value
 03h	above test value
 04h	below test value
 05h	below or equal to test value
 06h	above or equal to test value
 07h	within inclusive range
 08h	outside specified range
--------N-2140-------------------------------
INT 21 - PC/TCP IPCUST.SYS - WRITE CONFIGURATION DATA
	AH = 40h
	BX = handle for character device "$IPCUST"
	CX = number of bytes to write
	DS:DX -> buffer for configuration data (AH=3Fh"IPCUST")
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (05h,06h) (see #0885 at AH=59h)
Notes:	if less than the entire data is read or written, the next read/write
	  continues where the previous one ended; IOCTL calls AX=4402h and
	  AX=4403h both reset the location at which the next operation starts
	  to zero
	the data pointer is also reset to zero if the previous read or write
	  reached or exceeded the end of the data, when the current function
	  is read and the previous was write, or vice versa
	v2.1+ uses a new configuration method, but allows the installation
	  of IPCUST.SYS for backward compatibility with other software which
	  must read the PC/TCP configuration
SeeAlso: AH=3Fh"IPCUST",AX=4402h"IPCUST"
--------y-2140-------------------------------
INT 21 U - Trusted Access - NB.SYS - SET STATE
	AH = 40h
	BX = handle for character device "$$NB$$NB"
	DS:DX -> state record (see #0638)
	CX ignored
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (05h,06h) (see #0885 at AH=59h)
Program: Trusted Access is a security and access-control package by Lassen
	  Software, Inc.; NB.SYS is a device driver to prevent the user from
	  terminating CONFIG.SYS or AUTOEXEC.BAT with Ctrl-Break
SeeAlso: AH=3Fh"NB.SYS"
--------j-214000BX0002-----------------------
INT 21 - FARTBELL.EXE - INSTALLATION CHECK
	AX = 4000h
	BX = 0002h
	CX = 0000h
	DS:DX = 0000h:0000h
Return: CF clear if installed
	    AX = CS of resident code
Program: FARTBELL is a joke program by Guenther Thiele which makes various
	  noises when programs output a bell
SeeAlso: AX=4001h
--------j-214001BX0002-----------------------
INT 21 - FARTBELL.EXE - FORCE NOISE
	AX = 4001h
	BX = 0002h
	CX = 0000h
	DS:DX = 0000h:0000h
Program: FARTBELL is a joke program by Guenther Thiele which makes various
	  noises when programs output a bell
SeeAlso: AX=4000h
--------D-2141-------------------------------
INT 21 - DOS 2+ - "UNLINK" - DELETE FILE
	AH = 41h
	DS:DX -> ASCIZ filename (no wildcards, but see notes)
	CL = attribute mask for deletion (server call only, see notes)
Return: CF clear if successful
	    AX destroyed (DOS 3.3) AL seems to be drive of deleted file
	CF set on error
	    AX = error code (02h,03h,05h) (see #0885 at AH=59h)
Notes:	(DOS 3.1+) wildcards are allowed if invoked via AX=5D00h, in which case
	  the filespec must be canonical (as returned by AH=60h), and only
	  files matching the attribute mask in CL are deleted
	DR-DOS 5.0-6.0 returns error code 03h if invoked via AX=5D00h
	DOS does not erase the file's data; it merely becomes inaccessible
	  because the FAT chain for the file is cleared
	deleting a file which is currently open may lead to filesystem
	  corruption.  Unless SHARE is loaded, DOS does not close the handles
	  referencing the deleted file, thus allowing writes to a nonexistant
	  file.
	under DRDOS and DR Multiuser DOS, this function will fail if the file
	  is currently open
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
BUG:	DR-DOS 3.41 crashes if called via AX=5D00h
SeeAlso: AH=13h,AX=4301h,AX=4380h,AX=5D00h,AH=60h,AH=71h,AX=F244h
SeeAlso: INT 2F/AX=1113h
--------y-214101DXFFFE-----------------------
INT 21 - SoftLogic Data Guardian - ???
	AX = 4101h
	DX = FFFEh
Return: AX = 0000h if installed
Note:	resident code sets several internal variables on this call
SeeAlso: AH=3Fh"NB.SYS",INT 16/AX=FFA3h/BX=0000h
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
	    AX = error code (01h,06h) (see #0885 at AH=59h)
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
	    CX = file attributes (see #0643)
	    AX = CX (DR-DOS 5.0)
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see #0885 at AH=59h)
Notes:	under the FlashTek X-32 DOS extender, the filename pointer is in DS:EDX
	under DR-DOS 3.41 and 5.0, attempts to change the subdirectory bit are
	  simply ignored without an error
BUG:	Windows for Workgroups returns error code 05h (access denied) instead
	  of error code 02h (file not found) when attempting to get the
	  attributes of a nonexistent file.  This causes open() with O_CREAT
	  and fopen() with the "w" mode to fail in Borland C++.
SeeAlso: AX=4301h,AX=4310h,AH=71h,AH=B6h,INT 2F/AX=110Fh,INT 60/DI=0517h
--------D-214301-----------------------------
INT 21 - DOS 2+ - "CHMOD" - SET FILE ATTRIBUTES
	AX = 4301h
	CX = new file attributes (see #0643)
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see #0885 at AH=59h)
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
SeeAlso: AX=4300h,AX=4311h,AH=71h,INT 2F/AX=110Eh

Bitfields for file attributes:
Bit(s)	Description	(Table 0643)
 7	shareable (Novell NetWare)
 6	unused
 5	archive
 4	directory
 3	volume label
	execute-only (Novell NetWare)
 2	system
 1	hidden
 0	read-only
--------D-214302-----------------------------
INT 21 - DOS 7 (Chicago) - GET VOLUME INFORMATION
	AX = 4302h
	details not yet available
SeeAlso: AH=71h,AH=72h
--------O-214302-----------------------------
INT 21 - DR-DOS 3.41+ internal - GET ACCESS RIGHTS
	AX = 4302h
	DS:DX -> ASCIZ pathname
Return: CF clear if successful
	    CX = access rights (see #0644)
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

Bitfields for DR-DOS file access rights:
Bit(s)	Description	(Table 0644)
 0	owner delete requires password
 1	owner execution requires password (FlexOS)
 2	owner write requires password
 3	owner read requires password
 4	group delete requires password
 5	group execution requires password (FlexOS)
 6	group write requires password
 7	group read requires password
 8	world delete requires password
 9	world execution requires password (FlexOS)
 10	world write requires password
 11	world read requires password
--------O-214303-----------------------------
INT 21 - DR-DOS 3.41+ internal - SET ACCESS RIGHTS AND PASSWORD
	AX = 4303h
	CX = access rights
	     bits 11-0: access rights (see #0644)
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
SeeAlso: AH=0Fh,AH=17h,AX=4302h"DR-DOS",AX=4305h,AX=4454h
--------O-214304-----------------------------
INT 21 U - DR-DOS 5.0-6.0 internal - GET ENCRYPTED PASSWORD
	AX = 4304h
	DS:DX -> ASCIZ filename
	???
Return: CF clear if successful
	    CX = AX = 0000h if no password assigned to file
	CF set on error
	    AX = error code (see #0885 at AH=59h)
Note:	this function is only supported by DR-DOS 5.0 and 6.0 and DRMDOS 5.1
SeeAlso: AX=4303h,AX=4305h
--------O-214305-----------------------------
INT 21 U - DR-DOS 5.0-6.0 internal - SET EXTENDED FILE ATTRIBUTES
	AX = 4305h
	DS:DX -> ASCIZ filename
	???
Return: CF clear if successful
	CF set on error
	    AX = error code (see #0885 at AH=59h)
Desc:	this function allows the extended attributes, and optionally the
	  encrypted password, of a file to be set.
Note:	this function is only supported by DR-DOS 5.0 and 6.0 and DRMDOS 5.1
SeeAlso: AX=4304h,AX=4311h
--------O-214306-----------------------------
INT 21 - DR-DOS 6.0 - GET FILE OWNER
	AX = 4306h
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    AX = CX = value set with AX=4307h
	CF set on error
	    AX = error code (see #0885 at AH=59h)
SeeAlso: AX=4307h
--------O-214307-----------------------------
INT 21 - DR-DOS 6.0 - SET FILE OWNER
	AX = 4307h
	CX = ??? (owner identification number?)
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	CF set on error
	    AX = error code (see #0885 at AH=59h)
SeeAlso: AX=4306h
--------N-214310-----------------------------
INT 21 - Banyan VINES 2.1+ - GET EXTENDED FILE ATTRIBUTES
	AX = 4310h
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    CH = attributes (see #0645)
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see #0885 at AH=59h)
Note:	the filename may be a directory but must be on a VINES file service
SeeAlso: AX=4300h,AX=4311h,AH=B6h,INT 2F/AX=110Fh
--------N-214311-----------------------------
INT 21 - Banyan VINES 2.1+ - SET EXTENDED FILE ATTRIBUTES
	AX = 4311h
	CH = new attributes (see #0645)
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see #0885 at AH=59h)
Note:	the filename may be a directory but must be on a VINES file service
SeeAlso: AX=4301h,AX=4305h,AX=4310h,INT 2F/AX=110Eh

Bitfields for VINES extended file attributes:
Bit(s)	Description	(Table 0645)
 7	unused
 6	shareable
 5	execute-only
 4-0	unused
--------u-214321BX0000-----------------------
INT 21 R - Q87, Q387 - INSTALLATION CHECK
	AX = 4321h
	BX = 0000h
	EAX = 87654321h (entire EAX value is required, not just AX)
Return: EAX = 12345678h if installed
Program: Q387 (renamed to Q87 as of v3.7) is a math coprocessor emulator from
	  Quickware
Note:	this function is available only in virtual-86 mode
SeeAlso: AX=4321h/BX=0001h,AX=4321h/BX=0002h
--------u-214321BX0001-----------------------
INT 21 R - Q87, Q387 - ENABLE EMULATOR
	AX = 4321h
	BX = 0001h
	EAX = 87654321h (entire EAX value is required, not just AX)
Desc:	enable the emulator by setting the CPU MSW's EM bit and updating
	  the BIOS equipment list
Note:	this function is available only in virtual-86 mode
SeeAlso: AX=4321h/BX=0000h,AX=4321h/BX=0002h
--------u-214321BX0002-----------------------
INT 21 R - Q87, Q387 - DISABLE EMULATOR
	AX = 4321h
	BX = 0002h
	EAX = 87654321h (entire EAX value is required, not just AX)
Desc:	disable the emulator by clearing the CPU MSW's EM bit and updating
	  the BIOS equipment list
Note:	this function is available only in virtual-86 mode
SeeAlso: AX=4321h/BX=0000h,AX=4321h/BX=0001h
--------O-214380-----------------------------
INT 21 - Novell DOS 7 - UNDELETE PENDING DELETE FILE
	AX = 4380h
	???
Return: ???
SeeAlso: AH=41h,AX=4381h
--------O-214381-----------------------------
INT 21 - Novell DOS 7 - PURGE PENDING DELETE FILE
	AX = 4381h
	???
Return: ???
SeeAlso: AH=41h,AX=4380h
--------!---Section--------------------------
