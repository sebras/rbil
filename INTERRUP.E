Interrupt List, part 5 of 8
This compilation is Copyright (c) 1989,1990,1991,1992 Ralf Brown
----------2F---------------------------------
INT 2F - Multiplex - NOTES
	AH = identifier of program which is to handle the interrupt
	   00h-7Fh reserved for DOS
	   B8h-BFh reserved for networks
	   C0h-FFh reserved for applications
	AL is the function code
   This is a general mechanism for verifying the presence of a TSR and 
   communicating with it.  When searching for a free identifier code for AH
   using the installation check (AL=00h), the calling program should set
   BX/CX/DX to 0000h and must not depend on any registers other than CS:IP
   and SS:SP to be valid on return, since numerous programs now use additional
   registers on input and/or output for the installation check.
Note:	Since the multiplex chain is growing so long, and beginning to
	  experience multiplex number collisions, I am proposing an alternate
	  multiplex interrupt on INT 2D.  If you decide to use the alternate
	  multiplex, please let me know.
SeeAlso: INT 2D
----------2F---------------------------------
INT 2F - BMB Compuscience Canada Utilities Interface
	AH = xx (dynamically assigned based upon a search for a multiplex
		 number which doesn't answer installed)
	AL = 00h installation check
	ES:DI = EBEBh:BEBEh
Return: AL = 00h not installed
	     01h not installed, not OK to install
	     FFh installed; if ES:DI was EBEBh:BEBEh on entry, ES:DI will point
		 to a string of the form 'MMMMPPPPPPPPvNNNN' where MMMM is a
		 short form of the manufacturer's name, PPPPPPPP is a product
		 name and NNNN is the product's version number
----------2F---------------------------------
INT 2F - Ross Wentworth's Turbo Pascal POPUP LIBRARY
	AH = programmer-selected multiplex number
	AL = function
	    00h installation check
		Return: AL = FFh if installed
	    01h get TSR interrupt vectors
		Return: DX:AX -> vector table (see below)
	    02h get TSR code segment
		Return: AX = code segment for all interrupt handlers
	    03h call user exit routine and release TSR's memory
	    04h get signature string
		Return: DX:AX -> counted string containing signature
	    05h get TSR's INT 2F handler
		Return: DX:AX -> INT 2F handler
	    06h enable/disable TSR
		BL = new state (00h disabled, 01h enabled)
	    07h activate TSR (popup if not disabled)
	    08h get hotkeys
		BL = which hotkey (00h = hotkey 1, 01h = hotkey 2)
		Return: AX = hotkey (AH = keyflags, AL = scancode)
	    09h set hotkey
		BL = which hotkey (00h = hotkey 1, 01h = hotkey 2)
		CX = new hotkey (CH = keyflags, CL = scancode)
	    0Ah-1Fh reserved

Format of vector table entry:
Offset	Size	Description
 00h	BYTE	vector number (00h = end of table)
 01h	DWORD	original vector
 05h	WORD	offset of interrupt handler in TSR's code segment
----------2F---------------------------------
INT 2F - CiriSOFT Spanish University of Valladolid TSR's Interface
	AH = xx (dynamically assigned based upon a search for a multiplex
		 number from C0h to FFh which doesn't answer installed)
	AL = 00h installation check
	ES:DI = 1492h:1992h
Return: AL = 00h not installed
	     01h not installed, not OK to install
	     FFh installed; and if ES:DI was 1492h:1992h on entry, ES:DI will
		 point to author_name_ver table (see below)
	AH = FFh
Note:	this interface permits advanced communication with TSRs: it is possible
	  to make a generic unistall utility, advanced TSR relocator programs
	  in order to fit fragmented memory areas, etc.
See also: INT 2D"AMIS",INT 2F"Compuscience"

Format of author_name_ver table:
Offset	Size	Description
 -16	WORD	segment in which really begins the TSR code (CS in programs
		with PSP, XMS upper memory segment if installed as UMB...)
 -14	WORD	offset in which really begins the TSR code (frecuently 100h
		in *.COM programs and 0 in upper memory TSR's).
 -12	WORD	memory used by TSR (in paragraphs). Knowing the memory area
		used by TSR is possible to determine if hooked vectors are
		still pointing it (and if it is safe the unistall process).
 -10	BYTE	characteristics byte
		bits 0-2: 000 normal program (with PSP)
			  001 upper XMS memory block (needed HIMEM.SYS function
			      to free memory when unistalling)
			  010 device driver (*.SYS)
			  011 device driver in EXE format
			  1xx others (reserved)
		bits 3-6 reserved
		bit 7 set if extra_table defined and supported
 -9	BYTE	number of multiplex entry used (redefinition available). Note
		that the TSR must be use THIS variable in it's INT 2Fh handler.
 -8	WORD	offset to vector_area table (see bellow)
 -6	WORD	offset to extra_area table (see bit 7 in offset -10 and bellow)
 -4   4 BYTEs	"*##*"	(to insure that the TSR verify this agreement)
 00h	var	"AUTHOR:PROGRAM_NAME:VERSION",0	 (variable length, this area
		is used in order to determine if the TSR is already resident
		and it's version code; the ':' char is used as delimiter)

Format of vector_area table:
Offset	Size	Description
 -1	BYTE	number of vectors intercepted by TSR
 00h	BYTE	first vector number
 01h	DWORD	first vector pointer before installing the TSR
 05h	BYTE	second vector number
 06h	DWORD	second vector pointer before installing the TSR
  .	  .	(and so on) Note that the TSR must be use THIS variables to
		invoke previous interrupt handler routines.

Format of extra_area table (needed only to improve relocation feature):
Offset	Size	Description
 00h	WORD	offset to external_ctrl table (0 if not supported)
 02h	WORD	reserved for future use (0)

Format of external_ctrl table:
Offset	Size	Description
 00h	BYTE	bit 0: TSR is relocatable (no absolute segment references)
 01h	WORD	offset to a variable which can activate/inhibit the TSR
 ---And if bit 0 in offset 00h is off:
 03h	DWORD	pointer to ASCIIZ with pathname to executable file which
		supports /SR parameter (silent installation & inhibit)
 07h	DWORD	pointer to first variable to initialize on the copy reloaded
		from the previous TSR still resident
 0Bh	DWORD	pointer to last variable (all variables packed in one block)
----------2F00-------------------------------
INT 2F U - DOS 2.x PRINT.COM - ???
	AH = 00h
	???
Return: ???
Notes:	DOS 2.x PRINT.COM does not chain to previous INT 2F handler
	values in AH other than 00h or 01h cause PRINT to return the number of
	  files in the queue in AH
SeeAlso: AH=01h
----------2F0080-----------------------------
INT 2F - DOS 3.1+ PRINT.COM - GIVE PRINT A TIME SLICE
	AX = 0080h
Return: after PRINT executes
----------2F01-------------------------------
INT 2F U - DOS 2.x PRINT.COM - ???
	AH = 01h
	???
Return: ???
Notes:	DOS 2.x PRINT.COM does not chain to previous INT 2F handler
	values in AH other than 00h or 01h cause PRINT to return the number of
	  files in the queue in AH
SeeAlso: AH=00h
----------2F0100-----------------------------
INT 2F - DOS 3+ PRINT.COM - INSTALLATION CHECK
	AX = 0100h
Return: AL = status
	    00h not installed
	    01h not installed, but not OK to install
	    FFh installed
SeeAlso: AX=0101h
----------2F0101-----------------------------
INT 2F - DOS 3+ PRINT.COM - SUBMIT FILE FOR PRINTING
	AX = 0101h
	DS:DX -> submit packet (see below)
Return: CF clear if successful
	    AL = 01h added to queue
		 9Eh now printing
	CF set on error
	    AX = error code (see also INT 21/AH=59h)
		01h invalid function
		02h file not found
		03h path not found
		04h out of file handles
		05h access denied
		08h print queue full
		09h spooler busy
		0Ch name too long
		0Fh invalid drive
SeeAlso: AX=0102h

Format of submit packet:
Offset	Size	Description
 00h	BYTE	level (must be 00h)
 01h	DWORD	pointer to ASCIZ filename (no wildcards)
----------2F0102-----------------------------
INT 2F - DOS 3+ PRINT.COM - REMOVE FILE FROM PRINT QUEUE
	AX = 0102h
	DS:DX -> ASCIZ filename (wildcards allowed)
Return: CF clear if successful
	CF set on error
	    AX = error code (see AX=0101h)
SeeAlso: AX=0101h,AX=0103h
----------2F0103-----------------------------
INT 2F - DOS 3+ PRINT.COM - CANCEL ALL FILES IN PRINT QUEUE
	AX = 0103h
Return: CF clear if successful
	CF set on error
	    AX = error code (see AX=0101h)
SeeAlso: AX=0102h
----------2F0104-----------------------------
INT 2F - DOS 3+ PRINT.COM - FREEZE PRINT QUEUE TO READ JOB STATUS
	AX = 0104h
Return: CF clear if successful
	    DX = error count
	    DS:SI -> print queue
	CF set on error
	    AX = error code (see AX=0101h)
Notes:	the print queue is an array of 64-byte ASCIZ filenames terminated by
	  an empty filename; the first name is the file currently being printed
	printing is stopped until AX=0105h is called to prevent the queue
	  from changing while the filenames are being read
SeeAlso: AX=0101h,AX=0105h
----------2F0105-----------------------------
INT 2F - DOS 3+ PRINT.COM - RESTART PRINT QUEUE AFTER STATUS READ
	AX = 0105h
Return: CF clear if successful
	CF set on error
	    AX = error code (see AX=0101h)
SeeAlso: AX=0104h
----------2F0106-----------------------------
INT 2F - DOS 3.3+ PRINT.COM - GET PRINTER DEVICE
	AX = 0106h
Return: CF set if files in print queue
	    AX = error code 0008h (queue full)
	    DS:SI -> device driver header
	CF clear if print queue empty
	    AX = 0000h
Note:	documented for DOS 5+, but not documented for prior versions
SeeAlso: AX=0104h
----------2F0200-----------------------------
INT 2F U - PC LAN PROGRAM REDIR/REDIRIFS internal - INSTALLATION CHECK
	AX = 0200h
Return: AL = FFh if installed
----------2F0201-----------------------------
INT 2F U - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0201h
Return: nothing???
Notes:	called by DOS 3.3+ PRINT.COM
	AX=0202h appears to be the opposite function
SeeAlso: AX=0202h
----------2F0202-----------------------------
INT 2F U - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0202h
	???
Return: nothing???
Note:	called by DOS 3.3+ PRINT.COM
SeeAlso: AX=0201h
----------2F0203-----------------------------
INT 2F U - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0203h
Return: nothing???
Notes:	called by DOS 3.3+ PRINT.COM
	AX=0204h appears to be the opposite function
SeeAlso: AX=0204h
----------2F0204-----------------------------
INT 2F U - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0204h
	???
Return: nothing???
Note:	called by DOS 3.3 PRINT.COM
----------2F---------------------------------
INT 2F U - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 02xxh
	???
Return: ???
----------2F0500-----------------------------
INT 2F U - DOS 3+ CRITICAL ERROR HANDLER - INSTALLATION CHECK
	AX = 0500h
Return: AL = 00h not installed, OK to install
	     01h not installed, can't install
	     FFh installed
Note:	this set of functions allows a user program to partially or completely
	  override the default critical error handler's message in COMMAND.COM
SeeAlso: AH=05h,INT 24
----------2F05-------------------------------
INT 2F U - DOS 3+ CRITICAL ERROR HANDLER - EXPAND ERROR INTO STRING
	AH = 05h
---DOS 3.x---
	AL = extended error code (not zero)
---DOS 4+ ---
	AL = error type
	    01h DOS extended error code
	    02h parameter error
	BX = error code
Return: CF clear if successful
	    ES:DI -> ASCIZ error message (read-only)
	    AL = ???
	CF set if error code can't be converted to string
Notes:	called at start of COMMAND.COM's default critical error handler if 
	  installed by a user program, allowing partial or complete overriding
	  of the default error message
	subfunction 02h called by many DOS 4 external programs
SeeAlso: AX=122Eh,INT 24
----------2F0600-----------------------------
INT 2F - DOS 3+ ASSIGN - INSTALLATION CHECK
	AX = 0600h
Return: AL = status
	    00h not installed
	    01h not installed, but not OK to install
	    FFh installed
Notes:	ASSIGN is not a TSR in DR-DOS 5.0; it is internally replaced by SUBST
	  (see INT 21/AH=52h)
	undocumented prior to the release of DOS 5.0
SeeAlso: AX=0601h,INT 21/AH=52h
----------2F0601-----------------------------
INT 2F U - DOS 3+ ASSIGN - GET DRIVE ASSIGNMENT TABLE
	AX = 0601h
Return: ES = segment of ASSIGN work area and assignment table
Note:	under DOS 3+, the 26 bytes starting at ES:0103h specify which drive
	  each of A: to Z: is mapped to.  Initially set to 01h 02h 03h....
SeeAlso: AX=0600h
----------2F0800-----------------------------
INT 2F U - DRIVER.SYS support - INSTALLATION CHECK
	AX = 0800h
Return:	AL = 00h not installed, OK to install
	     01h not installed, not OK to install
	     FFh installed
Note:	supported by DR-DOS 5.0
----------2F0801-----------------------------
INT 2F U - DRIVER.SYS support - ADD NEW BLOCK DEVICE
	AX = 0801h
	DS:DI -> drive data table (see AX=0803h)
Notes:	moves down internal list of drive data tables, copying and modifying
	  the drive description flags word for tables referencing same physical
	  drive
	data table appended to chain of tables
	supported by DR-DOS 5.0
SeeAlso: AX=0803h
----------2F0802-----------------------------
INT 2F U - DRIVER.SYS support - EXECUTE DEVICE DRIVER REQUEST
	AX = 0802h
	ES:BX -> device driver request header (see below)
Return: request header updated as per requested operation
Notes:	supported by DR-DOS 5.0
	DOS 3.2 executes this function on any AL value from 02h through F7h
SeeAlso: AX=0800h,AX=0801h,AX=0803h,INT 21/AH=52h,INT 21/AH=99h,INT 21/AH=9Ah

Values for command code:
	00h INIT
	01h MEDIA CHECK (block devices)
	02h BUILD BPB (block devices)
	03h IOCTL INPUT
	04h INPUT
	05h NONDESTRUCTIVE INPUT, NO WAIT (character devices)
	06h INPUT STATUS (character devices)
	07h INPUT FLUSH (character devices)
	08h OUTPUT
	09h OUTPUT WITH VERIFY
	0Ah OUTPUT STATUS (character devices)
	0Bh OUTPUT FLUSH (character devices)
	0Ch IOCTL OUTPUT
	0Dh (DOS 3+) DEVICE OPEN
	0Eh (DOS 3+) DEVICE CLOSE
	0Fh (DOS 3+) REMOVABLE MEDIA (block devices)
	10h (DOS 3+) OUTPUT UNTIL BUSY (character devices)
	11h (European MSDOS 4.0) STOP OUTPUT (console screen drivers only)
	12h (European MSDOS 4.0) RESTART OUTPUT (console screen drivers only)
	13h (DOS 3.2+) GENERIC IOCTL
	14h unused
	15h (European MSDOS 4.0) RESET UNCERTAIN MEDIA FLAG
	16h unused
	17h (DOS 3.2+) GET LOGICAL DEVICE
	18h (DOS 3.2+) SET LOGICAL DEVICE
	19h (DOS 5.0+) CHECK GENERIC IOCTL SUPPORT
	80h (CD-ROM) READ LONG
	81h (CD-ROM) reserved
	82h (CD-ROM) READ LONG PREFETCH
	83h (CD-ROM) SEEK
	84h (CD-ROM) PLAY AUDIO
	85h (CD-ROM) STOP AUDIO
	86h (CD-ROM) WRITE LONG
	87h (CD-ROM) WRITE LONG VERIFY
	88h (CD-ROM) RESUME AUDIO

Format of device driver request header:
Offset	Size	Description
 00h	BYTE	length of request header
 01h	BYTE	subunit within device driver
 02h	BYTE	command code (see above)
 03h	WORD	status (filled in by device driver)
		bit 15: error
		bits 14-11: reserved
		bit 10: ??? set by DOS kernel on entry to some driver calls
		bit 9: busy
		bit 8: done (may be clear on return under European MSDOS 4.0)
		bits 7-0: error code if bit 15 set (see below)
---DOS---
 05h  4 BYTEs	reserved (unused in DOS 2.x and 3.x)
 09h	DWORD	(European MSDOS 4.0 only) pointer to next request header in
			device's request queue
		(other versions) reserved (unused in DOS 2.x and 3.x)
---STARLITE architecture---
 05h	DWORD	pointer to next request header
 09h  4 BYTEs	reserved
---command code 00h---
 0Dh	BYTE	(return) number of units
 0Eh	DWORD	(call) pointer to DOS device helper function (see below)
 			(European MSDOS 4.0 only)
		(call) pointer past end of memory available to driver (DOS 5.0)
 		(return) address of first free byte following driver
 12h	DWORD	(call) pointer to commandline arguments
 		(return) pointer to BPB array (block drivers) or
				0000h:0000h (character drivers)
 16h	BYTE	(DOS 3+) drive number for first unit of block driver (0=A)
   ---European MSDOS 4.0---
 17h	DWORD	pointer to function to save registers on stack
   ---DOS 5.0---
 17h	WORD	(return) error-message flag
 			0001h MSDOS should display error msg on init failure
---command code 01h---
 0Dh	BYTE	media descriptor
 0Eh	BYTE	returned status
		00h don't know
		01h media has not changed
		FFh media has been changed
 0Fh	DWORD	(return, DOS 3+) pointer to previous volume ID if OPEN/CLOSE/RM
 		  bit in device header is set and disk changed
---command code 02h---
 0Dh	BYTE	media descriptor
 0Eh	DWORD	transfer address
		-> scratch sector if NON-IBM FORMAT bit in device header set
		-> first FAT sector otherwise
 12h	DWORD	pointer to BPB (set by driver) (see INT 21/AH=53h)
---command codes 03h,0Ch--- (see also INT 21/AX=4402h,INT 21/AX=4403h)
 0Dh	BYTE	media descriptor (block devices only)
 0Eh	DWORD	transfer address
 12h	WORD	(call) number of bytes to read/write
 		(return) actual number of bytes read or written
---command codes 04h,08h,09h---
 0Dh	BYTE	media descriptor (block devices only)
 0Eh	DWORD	transfer address
 12h	WORD	byte count (character devices) or sector count (block devices)
 14h	WORD	starting sector number (block devices only)
 16h	DWORD	(DOS 3+) pointer to volume ID if error 0Fh returned
 1Ah	DWORD	(DOS 4+) 32-bit starting sector number (block devices with
		device attribute word bit 1 set only) (see INT 21/AH=52h)
---command code 05h---
 0Dh	BYTE	byte read from device if BUSY bit clear on return
---command codes 06h,07h,0Ah,0Bh,0Dh,0Eh,0Fh---
 no further fields
---command code 10h---
 0Dh	BYTE	unused
 0Eh	DWORD	transfer address
 12h	WORD	(call) number of bytes to write
 		(return) actual number of bytes written
---command codes 11h,12h---
 0Dh	BYTE	reserved
---command code 15h---
 no further fields
---command codes 13h,19h---
 0Dh	BYTE	category code
		00h unknown
		01h COMn:
		03h CON
		05h LPTn:
		07h mouse (European MSDOS 4.0)
		08h disk
		9Eh (STARLITE) Media Access Control driver
 0Eh	BYTE	function code
		00h (STARLITE) MAC Bind request
 0Fh	WORD	copy of DS at time of IOCTL call (apparently unused in DOS 3.3)
 		SI contents (European MSDOS 4.0)
 11h	WORD	offset of device driver header
 		DI contents (European MSDOS 4.0)
 13h	DWORD	pointer to parameter block from INT 21/AX=440Ch or AX=440Dh
---command codes 80h,82h---
 0Dh	BYTE	addressing mode
		00h HSG (default)
		01h Phillips/Sony Red Book
 0Eh	DWORD	transfer address (ignored for command 82h)
 12h	WORD	number of sectors to read
		(if 0 for command 82h, request is an advisory seek)
 14h	DWORD	starting sector number
		logical sector number in HSG mode
		frame/second/minute/unused in Red Book mode
		(HSG sector = minute * 4500 + second * 75 + frame - 150)
 18h	BYTE	data read mode
		00h cooked (2048 bytes per frame)
		01h raw (2352 bytes per frame, including EDC/ECC)
 19h	BYTE	interleave size (number of sectors stored consecutively)
 1Ah	BYTE	interleave skip factor (# sectors between consec portions)
---command code 83h---
 0Dh	BYTE	addressing mode (see above)
 0Eh	DWORD	transfer address (ignored)
 12h	WORD	number of sectors to read (ignored)
 14h	DWORD	starting sector number (see also above)
---command code 84h---
 0Dh	BYTE	addressing mode (see above)
 0Eh	DWORD	starting sector number (see also above)
 12h	DWORD	number of sectors to play
---command codes 85h,88h---
 no further fields
---command codes 86h,87h---
 0Dh	BYTE	addressing mode (see above)
 0Eh	DWORD	transfer address (ignored in write mode 0)
 12h	WORD	number of sectors to write
 14h	DWORD	starting sector number (see also above)
 18h	BYTE	write mode
		00h mode 0 (write all zeros)
		01h mode 1 (default) (2048 bytes per sector)
		02h mode 2 form 1 (2048 bytes per sector)
		03h mode 2 form 2 (2336 bytes per sector)
 19h	BYTE	interleave size (number of sectors stored consecutively)
 1Ah	BYTE	interleave skip factor (# sectors between consec portions)

Values for error code:
	00h write-protect violation
	01h unknown unit
	02h drive not ready
	03h unknown command
	04h CRC error
	05h bad drive request structure length
	06h seek error
	07h unknown media
	08h sector not found
	09h printer out of paper
	0Ah write fault
	0Bh read fault
	0Ch general failure
	0Dh reserved
	0Eh (CD-ROM) media unavailable
	0Fh invalid disk change

Call European MSDOS 4.0 device helper function with:
	DL = function
	    00h "SchedClock" called on each timer tick
	    	AL = tick interval in milliseconds
	    01h "DevDone" device I/O complete
		ES:BX -> request header
		Note:	must update status word first; may be called from
			  an interrupt handler
	    02h "PullRequest" pull next request from queue
	    	DS:SI -> DWORD pointer to start of device's request queue
		Return: ZF clear if pending request
			    ES:BX -> request header
			ZF set if no more requests
	    03h "PullParticular" remove specific request from queue
	    	DS:SI -> DWORD pointer to start of device's request queue
		ES:BX -> request header
		Return: ZF set if request header not found
	    04h "PushRequest" push the request onto the queue
	    	DS:SI -> DWORD pointer to start of device's request queue
		ES:BX -> request header
		interrupts disabled
	    05h "ConsInputFilter" keyboard input check
	    	AX = character (high byte 00h if PC ASCII character)
		Return: ZF set if character should be discarded
			ZF clear if character should be handled normally
		Note:	called by keyboard interrupt handler so DOS can scan
			  for special input characters
	    06h "SortRequest" push request in sorted order by starting sector
	    	DS:SI -> DWORD pointer to start of device's request queue
		ES:BX -> request header
		interrupts disabled
	    07h "SigEvent" send signal on keyboard event
	    	AH = event identifier
		Return: AL,FLAGS destroyed
	    09h "ProcBlock" block on event
	    	AX:BX = event identifier (typically a pointer)
		CX = timeout in ms or 0000h for never
		DH = interruptible flag (nonzero if pause may be interrupted)
		interrupts disabled
		Return:	after corresponding ProcRun call
			CF clear if event wakeup, set if unusual wakeup
			ZF set if timeout wakeup, clear if interrupted
			AL = wakeup code, nonzero if unusual wakeup
			interrupts enabled
			BX,CX,DX destroyed
		Note:	block process and schedules another to run
	    0Ah "ProcRun" unblock process
	    	AX:BX = event identifier (typically a pointer)
		Return:	AX = number of processes awakened
			ZF set if no processes awakened
			BX,CX,DX destroyed
	    0Bh "QueueInit" initialize/clear character queue
	    	DS:BX -> character queue structure (see below)
		Note:	the queue size field must be set before calling
	    0Dh "QueueWrite" put a character in the queue
	    	DS:BX -> character queue (see below)
		AL = character to append to end of queue
		Return: ZF set if queue is full
			ZF clear if character stored
	    0Eh "QueueRead" get a character from the queue
	    	DS:BX -> character queue (see below)
		Return: ZF set if queue is empty
			ZF clear if characters in queue
			    AL = first character in queue
	    10h "GetDOSVar" return pointer to DOS variable
	    	AL = index of variable
		    03h current process ID
		BX = index into variable if AL specifies an array
		CX = expected length of variable
		Return: CF clear if successful
			    DX:AX -> variable
			CF set on error
			    AX,DX destroyed
			BX,CX destroyed
		Note:	the variables may not be modified
	    14h "Yield" yield CPU if higher-priority task ready to run
	    	Return: FLAGS destroyed
	    1Bh "CritEnter" begin system critical section
	    	DS:BX -> semaphore (6 BYTEs, initialized to zero)
		Return: AX,BX,CX,DX destroyed
	    1Ch "CritLeave" end system critical section
		DS:BX -> semaphore (6 BYTEs, initialized to zero)
		Return: AX,BX,CX,DX destroyed
		Note:	must be called in the context of the process which
			  called CritEnter on the semaphore
Note:	the DWORD pointing at the request queue must be allocated by the driver
	  and initialized to 0000h:0000h.  It always points at the next request
	  to be executed

Format of character queue:
Offset	Size	Description
 00h	WORD	size of queue in bytes
 02h	WORD	index of next character out
 04h	WORD	count of characters in the queue
 06h  N BYTEs	queue buffer
----------2F0803-----------------------------
INT 2F U - DOS 4+ DRIVER.SYS support - GET DRIVE DATA TABLE LIST
	AX = 0803h
Return: DS:DI -> first drive data table in list
Note:	not available under DR-DOS 5.0
SeeAlso: AX=0801h

Format of DOS 3.30 drive data table:
Offset	Size	Description
 00h	DWORD	pointer to next table
 04h	BYTE	physical unit number (for INT 13)
 05h	BYTE	logical drive number
 06h 19 BYTEs	BIOS Parameter Block (see also INT 21/AH=53h)
		Offset	Size	Description
		 00h	WORD	bytes per sector
		 02h	BYTE	sectors per cluster, FFh if unknown
		 03h	WORD	number of reserved sectors
		 05h	BYTE	number of FATs
		 06h	WORD	number of root dir entries
		 08h	WORD	total sectors
		 0Ah	BYTE	media descriptor, 00h if unknown
		 0Bh	WORD	sectors per FAT
		 0Dh	WORD	sectors per track
		 0Fh	WORD	number of heads
		 11h	WORD	number of hidden sectors
 19h	BYTE	flags
		bit 6: 16-bit FAT instead of 12-bit FAT
 1Ah	WORD	number of DEVICE OPEN calls without corresponding DEVICE CLOSE
 1Ch 11 BYTEs	volume label or "NO NAME    " if none (always "NO NAME" for
		fixed media)
 27h	BYTE	terminating null for volume label???
 28h	BYTE	device type (see INT 21/AX=440Dh)
 29h	WORD	bit flags describing drive
		bit 0: fixed media
		bit 1: door lock supported
		bit 2: ??? (used in determining BPB to set for INT 21/AX=440Dh)
		bit 3: all sectors in a track are the same size
		bit 4: physical drive has multiple logical units
		bit 5: current logical drive for physical drive
		bit 6: ???
		bit 7: ???
		bit 8: ??? (related to disk change detection)
 2Bh	WORD	number of cylinders
 2Dh 19 BYTEs	BIOS Parameter Block for highest capacity supported
 40h  3 BYTEs	???
 43h  9 BYTEs	filesystem type???, default = "NO NAME	"
		(apparently only MSDOS 3.30 fixed media, nulls for removable
		media and PCDOS 3.30)
 4Ch	BYTE	least-significant byte of last-accessed cylinder number
---removable media---
 4Dh	DWORD	time of last access in clock ticks (FFFFFFFFh if never)
---fixed media---
 4Dh	WORD	partition (FFFFh = primary, 0001h = extended)
 4Fh	WORD	absolute cylinder number of partition's start on physical
		drive (always FFFFh if primary partition)

Format of COMPAQ DOS 3.31 drive data table:
Offset	Size	Description
 00h	DWORD	pointer to next table
 04h	BYTE	physical unit number (for INT 13)
 05h	BYTE	logical drive number
 06h 25 BYTEs	BIOS Parameter Block (see DOS 4.0-5.0 drive data table below)
 1Fh  6 BYTEs	??? apparently always zeros
 25h	BYTE	flags
		bit 6: 16-bit FAT instead of 12-bit FAT
		    5: large volume???
 26h	WORD	device-open count???
 28h 11 BYTEs	volume label or "NO NAME    " if none (always "NO NAME" for
		fixed media)
 33h	BYTE	terminating null for volume label
 34h	BYTE	device type (see INT 21/AX=440Dh)
 35h	WORD	bit flags describing drive
 37h	WORD	number of cylinders
 39h 25 BYTEs	BIOS parameter block for highest capacity drive supports
 52h  6 BYTEs	??? apparently always zeros
 58h	BYTE	least-significant byte of last-accessed cylinder number
---removable media---
 59h	DWORD	time of last access in clock ticks (FFFFFFFFh if never)
---fixed media---
 59h	WORD	partition (FFFFh = primary, 0001h = extended)
 5Bh	WORD	absolute cylinder number of partition's start on physical
		drive (always FFFFh if primary partition)

Format of DOS 4.0-5.0 drive data table:
Offset	Size	Description
 00h	DWORD	pointer to next table
 04h	BYTE	physical unit number (for INT 13)
 05h	BYTE	logical drive number
 06h 25 BYTEs	BIOS Parameter Block (see also INT 21/AH=53h)
		Offset	Size	Description
		 00h	WORD	bytes per sector
		 02h	BYTE	sectors per cluster, FFh if unknown
		 03h	WORD	number of reserved sectors
		 05h	BYTE	number of FATs
		 06h	WORD	number of root dir entries
		 08h	WORD	total sectors (see offset 15h if zero)
		 0Ah	BYTE	media descriptor, 00h if unknown
		 0Bh	WORD	sectors per FAT
		 0Dh	WORD	sectors per track
		 0Fh	WORD	number of heads
		 11h	DWORD	number of hidden sectors
		 15h	DWORD	total sectors if WORD at 08h is zero
 1Fh	BYTE	flags
		bit 6: 16-bit FAT instead of 12-bit
 20h  2 BYTEs	???
 22h	BYTE	device type (see INT 21/AX=440Dh)
 23h	WORD	bit flags describing drive
		bit 0: fixed media
		bit 1: door lock supported
		bit 2: ???
		bit 3: all sectors in a track are the same size
		bit 4: physical drive has multiple logical units
		bit 5: current logical drive for physical drive
		bit 6: ???
		bit 7: ???
		bit 8: ???
 25h	WORD	number of cylinders
 27h 25 BYTEs	BIOS Parameter Block for highest capacity supported
 40h  7 BYTEs	???
---removable media---
 47h	DWORD	time of last access in clock ticks (FFFFFFFFh if never)
---fixed media, DOS 4.x---
 47h	WORD	partition (FFFFh = primary, 0001h = extended)
 49h	WORD	absolute cylinder number of partition's start on phys drive
		(FFFFh if primary partition)
---fixed media, DOS 5.0---
 47h	WORD	??? apparently always 0001h
 49h	WORD	absolute cylinder number of partition's start on phys drive
------
 4Bh 11 BYTEs	volume label or "NO NAME    " if none (apparently taken from
		extended boot record rather than root directory)
 56h	BYTE	terminating null for volume label???
 57h	DWORD	serial number
 5Bh  8 BYTEs	filesystem type ("FAT12	  " or "FAT16	")
 63h	BYTE	terminating null for filesystem type???
----------2F0C00-----------------------------
INT 2F - AD-DOS - INSTALLATION CHECK
	AX = 0C00h
Return: AL = FF if installed
	    BX = 4144H	('AD')
	    CX = 2D44H	('-D')
	    DX = 4F53H	('OS')
Notes:	AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
	AH=0Ch is the default multiplex number (there is one report of a
	  version with AH=C0h as default)
SeeAlso: AX=0C01h
----------2F0C01ES0000-----------------------
INT 2F - AD-DOS - GET RESIDENT CODE SEGMENT
	AX = 0C01h
	ES = 0000h
Return: CF clear succesful
	    ES = AD-DOS TSR Code Segment
	CF set if failed
SeeAlso: AX=0C00h
----------2F0C02-----------------------------
INT 2F - AD-DOS - CHECK FOR NEW INPUT
	AX = 0C02h
Return: BX = status
	    0000h no input since last check
	    0001h new input available
Note:	this call also resets the new-input flag
----------2F0C03-----------------------------
INT 2F - AD-DOS - SET MINUTES TO WAIT
	AX = 0C03h
	BX = minutes to wait before blanking screen
	CF set
Return: n/a???
Notes:	AD-DOS is the DOS version of the After Dark screen blanker
	AH=0Ch is the default multiplex number
SeeAlso: AX=0C04h
----------2F0C04-----------------------------
INT 2F - AD-DOS - GET MINUTES TO WAIT
	AX = 0C04h
	CF set
Return: BX = minutes to wait before blanking screen
	???
SeeAlso: AX=0C03h
----------2F0C05-----------------------------
INT 2F - AD-DOS - SET BLANKER STATUS
	AX = 0C05h
	BX = new state (0000h inactive, 0001h active) (default 0001h)
	CF set
Return: n/a???
SeeAlso: AX=0C06h
----------2F0C06-----------------------------
INT 2F - AD-DOS - GET BLANKER STATUS
	AX = 0C06h
	CF set
Return: BX = current state of screen blanker (0000h inactive, 0001h active)
Note:	AD-DOS is the DOS version of the After Dark screen blanker
SeeAlso: AX=0C05h
----------2F0C07-----------------------------
INT 2F - AD-DOS - SET HOT KEY
	AX = 0C07h
	BX = hot key
	CL = hot key shift status
	CF set
Return: n/a???
SeeAlso: AX=0C08h
----------2F0C08-----------------------------
INT 2F - AD-DOS - GET CURRENT HOT KEY
	AX = 0C08h
	CF set
Return: AX = status
	    0000h successful
		BX = Hot Key
		CL = Hot Key Shift Status
	    0008h otherwise
SeeAlso: AX=0C07h
----------2F0C09-----------------------------
INT 2F - AD-DOS - ???
	AX = 0C09h
	Carry Set
Return: AX = status
	    0000h successful
		???
	    0009h otherwise
Notes:	AD-DOS is the DOS version of the After Dark screen blanker
	AH=0Ch is the default multiplex number
----------2F0C0A-----------------------------
INT 2F - AD-DOS - ???
	AX = 0C0Ah
	CF set
Return: AX = status
	    0000h successful
		BH = ??
		BL = ??
	    000Ah failed
----------2F0C0B-----------------------------
INT 2F - AD-DOS - ???
	AX = 0C0Bh
	CF set
Return: AX = status 
	    0000h successful
	    000Bh failed
----------2F0C0C-----------------------------
INT 2F - AD-DOS - SET ??? INTERNAL FLAG TO 01h
	AX = 0C0Ch
	CF set
Return: AX = status
	    0000h successful
	    000Ch failed
Notes:	AD-DOS is the DOS version of the After Dark screen blanker
	AH=0Ch is the default multiplex number
----------2F0C0E-----------------------------
INT 2F - AD-DOS - SET PASSWORD STATUS
	AX = 0C0Eh
	BX = new state (0000h disabled, 0001h enabled)
Return: ???
SeeAlso: AX=0C0Fh
----------2F0C0F-----------------------------
INT 2F - AD-DOS - GET PASSWORD STATUS
	AX = 0C0Fh
Return: BX = current state (0000h disabled, 0001h enabled)
SeeAlso: AX=0C0Eh
----------2F0C20-----------------------------
INT 2F - AD-DOS - GET AND RESET VxD API STATUS
	AX = 0C20h
	CF set
Return: AX = status
	    0000h successful
		BX = VxD API Status
		    0000h no error
		    0001h error
		    0100h neither Windows 3.X enhanced mode nor
				Windows/386 2.x is running
		    0200h VM API entry point found
	    0020h otherwise
Note:	this call resets the VxD API Status to zero
SeeAlso: AX=1602h,AX=1607h
----------2F1000-----------------------------
INT 2F - SHARE - INSTALLATION CHECK
	AX = 1000h
Return: AL = 00h  not installed, OK to install
	     01h  not installed, not OK to install
	     FFh  installed
BUGS:	values of AL other than 00h put DOS 3.x SHARE into an infinite loop
	  (08E9: OR  AL,AL
	   08EB: JNZ 08EB) <- the buggy instruction (DOS 3.3)
	values of AL other than described here put PCDOS 4.00 into the same
	  loop (the buggy instructions are the same)
Notes:	supported by OS/2 v1.3+ compatibility box, which always returns AL=FFh
	if DOS 4.01 SHARE was automatically loaded, file sharing is in an
	  inactive state (due to the undocumented /NC flag used by the autoload
	  code) until this call is made
	DOS 5.0 chains to the previous handler if AL <> 00h on entry
SeeAlso: AX=1080h,INT 21/AH=52h
----------2F1040-----------------------------
INT 2F U - DOS 4 only SHARE internal - ???
	AX = 1040h
	???
Return: AL = FFh???
SeeAlso: AX=1000h
----------2F1080-----------------------------
INT 2F U - DOS 4 only SHARE internal - TURN ON FILE SHARING CHECKS
	AX = 1080h
Return: AL = status
	    F0h successful
	    FFh checking was already on
Note:	DOS 4.x SHARE has dual functions: FCB support for large (>32M) media
	  and file sharing checks.  The undocumented commandline flag /NC can
	  be used to disable the sharing code.
SeeAlso: AX=1000h,AX=1081h
----------2F1081-----------------------------
INT 2F U - DOS 4 only SHARE internal - TURN OFF FILE SHARING CHECKS
	AX = 1081h
Return: AL = status
	    F0h successful
	    FFh checking was already off
Note:	(see AX=1080h)
SeeAlso: AX=1000h,AX=1080h
----------2F10FF-----------------------------
INT 2F U - Multiplex - DR-DOS 5.0 - ???
	AX = 10FFh
	ES:BX -> ???
Note:	sets pointer in kernel
----------2F1100-----------------------------
INT 2F - NETWORK REDIRECTOR - INSTALLATION CHECK
	AX = 1100h
Return: AL = 00h  not installed, OK to install
	     01h  not installed, not OK to install
	     FFh  installed
Notes:	called by DOS 3.1+ kernel
	In DOS 4.x only, the 11xx calls are all in IFSFUNC.EXE, not in the
	  PC LAN Program redirector; DOS 5.0 moves the calls back into the
	  redirector
----------2F1100-----------------------------
INT 2F - MSCDEX (MS CD-ROM Extensions) - INSTALLATION CHECK
	AX = 1100h
	STACK: WORD DADAh
Return: AL = 00h not installed, OK to install
		STACK unchanged
	   = 01h not installed, not OK to install
		STACK unchanged
	   = FFh installed
		STACK: WORD ADADh
----------2F1101-----------------------------
INT 2F U - NETWORK REDIRECTOR - REMOVE REMOTE DIRECTORY
	AX = 1101h
	SS = DOS DS
	SDA first filename pointer -> fully-qualified directory name
	SDA CDS pointer -> current directory structure for drive with dir
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1103h,AX=1105h,INT 21/AH=3Ah,INT 21/AH=60h
----------2F1102-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - REMOVE REMOTE DIRECTORY
	AX = 1102h
	SS = DOS DS
	SDA first filename pointer -> fully-qualified directory name
	SDA CDS pointer -> current directory structure for drive with dir
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	appears to be identical to AX=1101h
SeeAlso: AX=1101h
----------2F1103-----------------------------
INT 2F U - NETWORK REDIRECTOR - MAKE REMOTE DIRECTORY
	AX = 1103h
	SS = DOS DS
	SDA first filename pointer -> fully-qualified directory name
	SDA CDS pointer -> current directory structure for drive with dir
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1101h,AX=1105h,INT 21/AH=39h,INT 21/AH=60h
----------2F1104-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - MAKE REMOTE DIRECTORY
	AX = 1104h
	SS = DOS DS
	SDA first filename pointer -> fully-qualified directory name
	SDA CDS pointer -> current directory structure for drive with dir
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	appears to be identical to AX=1103h
SeeAlso: AX=1103h
----------2F1105-----------------------------
INT 2F U - NETWORK REDIRECTOR - CHDIR
	AX = 1105h
	SS = DOS DS
	SDA first filename pointer -> fully-qualified directory name
	SDA CDS pointer -> current directory structure for drive with dir
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    CDS updated with new path
Notes:	called by DOS 3.1+ kernel
	directory string in CDS should not have a terminating backslash unless
	  the current directory is the root
SeeAlso: AX=1101h,AX=1103h,INT 21/AH=3Bh,INT 21/AH=60h
----------2F1106-----------------------------
INT 2F U - NETWORK REDIRECTOR - CLOSE REMOTE FILE
	AX = 1106h
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive containing file
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    SFT updated (redirector must decrement open count, which may be
	    		done with INT 2F/AX=1208h)
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1201h,AX=1208h,AX=1227h,INT 21/AH=3Eh
----------2F1107-----------------------------
INT 2F U - NETWORK REDIRECTOR - COMMIT REMOTE FILE
	AX = 1107h
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive containing file
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    all buffers for file flushed
	    directory entry updated
Note:	called by DOS 3.1+ kernel
SeeAlso: INT 21/AH=68h,INT 21/AX=5D01h
----------2F1108-----------------------------
INT 2F U - NETWORK REDIRECTOR - READ FROM REMOTE FILE
	AX = 1108h
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive containing file
	CX = number of bytes
	SS = DOS DS
	SDA DTA field -> user buffer
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    CX = number of bytes read (0000h = end of file)
	    SFT updated
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1109h,AX=1229h,INT 21/AH=3Fh,INT 21/AX=5D06h
----------2F1109-----------------------------
INT 2F U - NETWORK REDIRECTOR - WRITE TO REMOTE FILE
	AX = 1109h
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive containing file
	CX = number of bytes
	SS = DOS DS
	SDA DTA field -> user buffer
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    CX = number of bytes written
	    SFT updated
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1107h,AX=1108h,INT 21/AH=40h,INT 21/AX=5D06h
----------2F110A-----------------------------
INT 2F U - NETWORK REDIRECTOR (DOS 3.x only) - LOCK REGION OF FILE
	AX = 110Ah
	BX = file handle
	CX:DX = starting offset
	SI = high word of size
	STACK: WORD low word of size
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive containing file
	SS = DOS DS
Return: CF set on error
	   AL = DOS error code (see INT 21/AH=59h)
	STACK unchanged
Notes:	called by DOS 3.10-3.31 kernel
	the redirector is expected to resolve lock conflicts
SeeAlso: AX=110Bh,INT 21/AH=5Ch
----------2F110A-----------------------------
INT 2F U - NETWORK REDIRECTOR (DOS 4+) - LOCK/UNLOCK REGION OF FILE
	AX = 110Ah
	BL = function
	    00h lock
	    01h unlock
	DS:DX -> parameter block (see below)
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive containing file
	SS = DOS DS
Return: CF set on error
	   AL = DOS error code (see INT 21/AH=59h)
Notes:	called by DOS 4.0+ kernel
	the redirector is expected to resolve lock conflicts
SeeAlso: AX=110Bh,INT 21/AH=5Ch

Format of parameter block:
Offset	Size	Description
 00h	DWORD	start offset
 04h	DWORD	size of region
----------2F110B-----------------------------
INT 2F U - NETWORK REDIRECTOR (DOS 3.x only) - UNLOCK REGION OF FILE
	AX = 110Bh
	BX = file handle
	CX:DX = starting offset
	SI = high word of size
	STACK: WORD low word of size
	ES:DI -> SFT for file
	    SFT DPB field -> DPB of drive containing file
Return: CF set on error
	   AL = DOS error code (see INT 21/AH=59h)
	STACK unchanged
Note:	called by DOS 3.1-3.31 kernel; DOS 4.0+ calls AX=110Ah instead
SeeAlso: AX=110Ah,INT 21/AH=5Ch
----------2F110C-----------------------------
INT 2F U - NETWORK REDIRECTOR - GET DISK SPACE
	AX = 110Ch
	ES:DI -> current directory structure for desired drive
Return: AL = sectors per cluster
	AH = media ID byte
	BX = total clusters
	CX = bytes per sector
	DX = number of available clusters
Note:	called by DOS 3.1+ kernel
SeeAlso: INT 21/AH=36h
----------2F110D-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 110Dh
	SDA first filename pointer -> name of file
	???
Return: ???
Note:	appears to be similar to AX=110Fh
SeeAlso: AX=110Fh
----------2F110E-----------------------------
INT 2F U - NETWORK REDIRECTOR - SET REMOTE FILE'S ATTRIBUTES
	AX = 110Eh
	SS = DOS DS
	SDA first filename pointer -> fully-qualified name of file
	SDA CDS pointer -> current directory structure for drive with file
	STACK: WORD new file attributes
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	STACK unchanged
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=110Fh,INT 21/AX=4301h,INT 21/AH=60h
----------2F110F-----------------------------
INT 2F U - NETWORK REDIRECTOR - GET REMOTE FILE'S ATTRIBUTES AND SIZE
	AX = 110Fh
	SS = DOS DS
	SDA first filename pointer -> fully-qualified name of file
	SDA CDS pointer -> current directory structure for drive with file
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    AX = file attributes
	    BX:DI = file size
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=110Eh,INT 21/AX=4300h,INT 21/AH=60h
----------2F1110-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 1110h
	SDA first filename pointer -> name of file
	???
Return: ???
Note:	appears to be similar to AX=110Eh
SeeAlso: AX=110Eh
----------2F1111-----------------------------
INT 2F U - NETWORK REDIRECTOR - RENAME REMOTE FILE
	AX = 1111h
	SS = DS = DOS DS
	SDA first filename pointer = offset of fully-qualified old name
	SDA second filename pointer = offset of fully-qualified new name
	SDA CDS pointer -> current directory structure for drive with file
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	called by DOS 3.1+ kernel
SeeAlso: INT 21/AH=56h,INT 21/AH=60h
----------2F1112-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 1112h
	SS = DS = DOS DS
	SDA first filename pointer -> name of file
	???
Return: ???
SeeAlso: AX=1111h
----------2F1113-----------------------------
INT 2F U - NETWORK REDIRECTOR - DELETE REMOTE FILE
	AX = 1113h
	SS = DS = DOS DS
	SDA first filename pointer -> fully-qualified filename in DOS DS
	SDA CDS pointer -> current directory structure for drive with file
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Notes:	called by DOS 3.1+ kernel
	the filespec may contain wildcards
SeeAlso: INT 21/AH=41h,INT 21/AH=60h
----------2F1114-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 1114h
	SDA first filename pointer -> name of file
	???
Return: ???
SeeAlso: AX=1113h
----------2F1115-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 1115h
	SS = DOS DS
	ES:DI -> SFT ???
	???
Return: ???
SeeAlso: AX=112Eh
----------2F1116-----------------------------
INT 2F U - NETWORK REDIRECTOR - OPEN EXISTING REMOTE FILE
	AX = 1116h
	ES:DI -> uninitialized SFT
	SS = DOS DS
	SDA first filename pointer -> fully-qualified name of file to open
	STACK: WORD file open mode (see INT 21/AH=3Dh)
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    SFT filled (except handle count, which DOS manages itself)
	STACK unchanged
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1106h,AX=1117h,AX=1118h,AX=112Eh,INT 21/AH=3Dh,INT 21/AH=60h
----------2F1117-----------------------------
INT 2F U - NETWORK REDIRECTOR - CREATE/TRUNCATE REMOTE FILE
	AX = 1117h
	ES:DI -> uninitialized SFT
	SS = DOS DS
	SDA first filename pointer -> fully-qualified name of file to open
	SDA CDS pointer -> current directory structure for drive with file
	STACK: WORD file creation mode
			low byte = file attributes
			high byte = 00h normal create, 01h create new file
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    SFT filled (except handle count, which DOS manages itself)
	STACK unchanged
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1106h,AX=1116h,AX=1118h,AX=112Eh,INT 21/AH=3Ch,INT 21/AH=60h
----------2F1118-----------------------------
INT 2F U - NETWORK REDIRECTOR - CREATE/TRUNCATE FILE WITHOUT CDS
	AX = 1118h
	ES:DI -> uninitialized SFT
	SS = DOS DS
	SDA first filename pointer -> fully-qualified name of file
	STACK: WORD file creation mode
			low byte = file attributes
			high byte = 00h normal create, 01h create new file
Return: ???
	STACK unchanged
Note:	called by DOS 3.1+ kernel when creating a file on a drive for which the
	  SDA CDS pointer has offset FFFFh
SeeAlso: AX=1106h,AX=1116h,AX=1117h,AX=112Eh,INT 21/AH=60h
----------2F1119-----------------------------
INT 2F U - NETWORK REDIRECTOR - FIND FIRST FILE WITHOUT CDS
	AX = 1119h
	SS = DS = DOS DS
	[DTA] = uninitialized 21-byte findfirst search data (see INT 21/AH=4Eh)
	SDA first filename pointer -> fully-qualified search template
	SDA search attribute = attribute mask for search
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    [DTA] = updated findfirst search data
		    (bit 7 of first byte must be set)
	    [DTA+15h] = standard directory entry for file
Notes:	called by DOS 3.1+ kernel
	DOS 4.x IFSFUNC returns CF set, AX=0003h	
----------2F111A-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 111Ah
	???
Return: CF set
	    AX = error code (03h for DOS 4.01 IFSFUNC)
----------2F111B-----------------------------
INT 2F U - NETWORK REDIRECTOR - FINDFIRST
	AX = 111Bh
	SS = DS = DOS DS
	[DTA] = uninitialized 21-byte findfirst search data (see INT 21/AH=4Eh)
	SDA first filename pointer -> fully-qualified search template
	SDA CDS pointer -> current directory structure for drive with file
	SDA search attribute = attribute mask for search
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    [DTA] = updated findfirst search data
		    (bit 7 of first byte must be set)
	    [DTA+15h] = standard directory entry for file
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=111Ch,INT 21/AH=4Eh,INT 21/AH=60h
----------2F111C-----------------------------
INT 2F U - NETWORK REDIRECTOR - FINDNEXT
	AX = 111Ch
	SS = DS = DOS DS
	[DTA] = 21-byte findfirst search data (see INT 21/AH=4Eh)
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    [DTA] = updated findfirst search data
		    (bit 7 of first byte must be set)
	    [DTA+15h] = standard directory entry for file
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=111Bh,INT 21/AH=4Fh
----------2F111D-----------------------------
INT 2F U - NETWORK REDIRECTOR - CLOSE ALL REMOTE FILES FOR PROCESS
	AX = 111Dh
	DS???
	SS = DOS DS
Return: ???
Notes:	called by DOS 3.1+ kernel
	closes all FCBs opened by process
SeeAlso: INT 21/AX=5D04h
----------2F111E-----------------------------
INT 2F U - NETWORK REDIRECTOR - DO REDIRECTION
	AX = 111Eh
	SS = DOS DS
	STACK: WORD function to execute
		5F00h  get redirection mode
			BL = type (03h printer, 04h disk)
			Return: BH = state (00h off, 01h on)
		5F01h  set redirection mode
			BL = type (03h printer, 04h disk)
			BH = state (00h off, 01h on)
		5F02h  get redirection list entry
			BX = redirection list index
			DS:SI -> 16-byte local device name buffer
			ES:DI -> 128-byte network name buffer
			Return: must set user's BX to device type and CX to
				stored parameter value, using AX=1218h to get
				stack frame address
		5F03h  redirect device
			BL = device type (see INT 21/AX=5F03h)
			CX = stored parameter value
			DS:SI -> ASCIZ source device name
			ES:DI -> destination ASCIZ network path + ASCIZ passwd
		5F04h  cancel redirection
			DS:SI -> ASCIZ device name or network path
		5F05h  get redirection list extended entry
			BX = redirection list index
			DS:SI -> buffer for ASCIZ source device name
			ES:DI -> buffer for destination ASCIZ network path
			Return: BH = status flag
				BL = type (03h printer, 04h disk)
				CX = stored parameter value
				BP = NETBIOS local session number
		5F06h  similar to 5F05h???
Return: CF set on error
	    AX = error code (see INT 21/AH=59h)
	STACK unchanged
Note:	called by DOS 3.1+ kernel
SeeAlso: INT 21/AX=5F00h,INT 21/AX=5F01h,INT 21/AX=5F02h,INT 21/AX=5F03h
SeeAlso: INT 21/AX=5F04h,INT 21/AX=5F05h,INT 21/AX=5F06h
----------2F111F-----------------------------
INT 2F U - NETWORK REDIRECTOR - PRINTER SETUP
	AX = 111Fh
	STACK: WORD function
		5E02h  set printer setup
		5E03h  get printer setup
		5E04h  set printer mode
		5E05h  get printer mode
Return: CF set on error
	    AX = error code (see INT 21/AH=59h)
	STACK unchanged
Note:	called by DOS 3.1+ kernel
SeeAlso: INT 21/AX=5E02h,INT 21/AX=5E03h,INT 21/AX=5E04h,INT 21/AX=5E05h
----------2F1120-----------------------------
INT 2F U - NETWORK REDIRECTOR - FLUSH ALL DISK BUFFERS
	AX = 1120h
	DS = DOS DS
	???
Return: CF clear (successful)
Notes:	called by DOS 3.1+ kernel
	uses CDS array pointer and LASTDRIVE= entries in DOS list of lists
SeeAlso: INT 21/AH=0Dh,INT 21/AX=5D01h
----------2F1121-----------------------------
INT 2F U - NETWORK REDIRECTOR - SEEK FROM END OF REMOTE FILE
	AX = 1121h
	CX:DX = offset (in bytes) from end
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive with file
	SS = DOS DS
Return: CF set on error
	    AL = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    DX:AX = new file position
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1228h,INT 21/AH=42h
----------2F1122-----------------------------
INT 2F U - NETWORK REDIRECTOR - PROCESS TERMINATION HOOK
	AX = 1122h
	SS = DOS DS
	???
Return: ???
Note:	called by DOS 3.1+ kernel
----------2F1123-----------------------------
INT 2F U - NETWORK REDIRECTOR - QUALIFY REMOTE FILENAME
	AX = 1123h
	DS:SI -> ASCIZ filename to canonicalize
	ES:DI -> 128-byte buffer for qualified name
Return: CF set if not resolved
Notes:	called by MSDOS 3.1+ kernel, but not called by DR-DOS 5.0 unless the
	  filename matches the name of a character device
	called first when DOS attempts to resolve a filename (unless inside an
	  AX=5D00h server call); if this fails, DOS resolves the name locally
SeeAlso: AX=1221h,INT 21/AH=60h
----------2F1124-----------------------------
INT 2F U - NETWORK REDIRECTOR - PRINTER OFF???
	AX = 1124h
	ES:DI -> SFT
	SS = DOS DS
	???
Return: CX = ???
Note:	called by DOS 3.1+ kernel if AX=1126h returns CF set
SeeAlso: AX=1126h
----------2F1125-----------------------------
INT 2F U - NETWORK REDIRECTOR - REDIRECTED PRINTER MODE
	AX = 1125h
	STACK: WORD subfunction
		5D07h get print stream state
			Return: DL = current state
		5D08h set print stream state
			DL = new state
		5D09h finish print job
Return: CF set on error
	    AX = error code (see INT 21/AH=59h)
	STACK unchanged
Note:	called by DOS 3.1+ kernel
SeeAlso: INT 21/AX=5D07h,INT 21/AX=5D08h,INT 21/AX=5D09h
----------2F1126-----------------------------
INT 2F U - NETWORK REDIRECTOR - PRINTER ON/OFF???
	AX = 1126h
	ES:DI -> SFT for file handle 4???
	SS = DOS DS???
	???
Return: CF set on error
Notes:	called by DOS 3.1+ kernel
	called when print echoing (^P, ^PrtSc) changes state and STDPRN has
	  bit 11 of the device information word in the SFT set
SeeAlso: AX=1124h
----------2F1127-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - UNUSED
	AX = 1127h
Return: CF set
	    AX = 0001h (invalid function) (see INT 21/AH=59h)
----------2F1128-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - UNUSED
	AX = 1128h
Return: CF set
	    AX = 0001h (invalid function) (see INT 21/AH=59h)
----------2F1129-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - UNUSED
	AX = 1129h
Return: CF set
	    AX = 0001h (invalid function) (see INT 21/AH=59h)
----------2F112A-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 112Ah
	DS = DOS DS
	???
Return: ???
Note:	does something to each IFS driver
----------2F112B-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - GENERIC IOCTL???
	AX = 112Bh
	SS = DOS DS
	CX = function/category
	DS:DX -> parameter block
	STACK: WORD value of AX on entry to INT 21 (440Ch or 440Dh)
	???
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	called by DOS 4.0 kernel
----------2F112C-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 112Ch
	SS = DOS DS
	SDA current SFT pointer -> SFT for file
	???
Return: CF set on error
Note:	called by SHARE in DOS 5.0
----------2F112D-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 112Dh
	BL = subfunction (value of AL on INT 21)
	    04h truncate open file to zero length
		ES:DI -> SFT for file
		Return: CF clear
	    else ???
		Return: CX = ??? (00h or 02h for DOS 4.01)
	ES:DI -> SFT
	SS = DOS DS
Return: DS = DOS DS
Note:	called by DOS 4.0 kernel on INT 21/AX=5702h,INT 21/AX=5703h,
	  INT 21/AX=5704h
----------2F112E-----------------------------
INT 2F U - NETWORK REDIRECTOR (DOS 4+) - EXTENDED OPEN/CREATE FILE
	AX = 112Eh
	SS = DS = DOS DS
	ES:DI -> uninitialized SFT for file
	STACK: WORD file attribute for created/truncated file
			low byte = file attributes
			high byte = 00h normal create/open, 01h create new file
	SDA first filename pointer -> fully-qualified filename
	SDA extended file open action = action code (see INT 21/AX=6C00h)
	SDA extended file open mode = open mode for file (see INT 21/AX=6C00h)
Return: CF set on error
	    AX = error code
	CF clear if successful
	    CX = result code
		01h file opened
		02h file created
		03h file replaced (truncated)
	    SFT initialized (except handle count, which DOS manages itself)
Note:	called by DOS 4.0 kernel
SeeAlso: AX=1115h,AX=1116h,AX=1117h,INT 21/AX=6C00h
----------2F112F-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - ???
	AX = 112Fh
	SS = DOS DS
	STACK: WORD function in low byte
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
	???
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
Note:	called by DOS 4.0 kernel
SeeAlso: INT 21/AH=6Bh
----------2F1130-----------------------------
INT 2F U - IFSFUNC.EXE (DOS 4.x only) - GET IFSFUNC SEGMENT
	AX = 1130h
Return: ES = CS of resident IFSFUNC
----------2F1186-----------------------------
INT 2F - LAN Manager Enhanced DOS API - DosReadAsynchNmPipe
	AX = 1186h
	???
Return: ???
Note:	LAN Manager enhance mode adds features beyond the standard redirector
	  file/printer services
SeeAlso: AX=118Fh,INT 21/AX=5F39h
----------2F118A-----------------------------
INT 2F - LAN Manager 2.0 DOS Enhanced ENCRYPT.EXE - STREAM ENCRYPTION SERVICE
	AX = 118Ah
	???
Return: ???
SeeAlso: AX=1186h,AH=41h,AH=42h,AH=4Bh
----------2F118F-----------------------------
INT 2F - LAN Manager Enhanced DOS API - DosWriteAsynchNmPipe
	AX = 118Fh
	???
Return: ???
SeeAlso: AX=1186h,INT 21/AX=5F3Ah
----------2F1200-----------------------------
INT 2F U - DOS 3+ internal - INSTALLATION CHECK
	AX = 1200h
Return: AL = FFh (for compatibility with other INT 2F functions)
----------2F1201-----------------------------
INT 2F U - DOS 3+ internal - CLOSE CURRENT FILE
	AX = 1201h
	SS = DOS DS (must be using a DOS internal stack)
	SDA current SFT pointer -> SFT of file to close
Return: CF set on error
	BX???
	CX new reference count of SFT
	ES:DI -> SFT for file
SeeAlso: AX=1106h,AX=1227h,INT 21/AH=3Eh
----------2F1202-----------------------------
INT 2F U - DOS 3+ internal - GET INTERRUPT ADDRESS
	AX = 1202h
	STACK: WORD vector number
Return: ES:BX -> interrupt vector
	STACK unchanged
----------2F1203-----------------------------
INT 2F U - DOS 3+ internal - GET DOS DATA SEGMENT
	AX = 1203h
Return: DS = data segment of IBMDOS.COM/MSDOS.SYS
Note:	for DOS prior to version 5.0, the data segment is the same as the code
	  segment
----------2F1204-----------------------------
INT 2F U - DOS 3+ internal - NORMALIZE PATH SEPARATOR
	AX = 1204h
	STACK: WORD character to normalize
Return: AL = normalized character (forward slash turned to backslash, all
		others unchanged)
	ZF set if path separator
	STACK unchanged
----------2F1205-----------------------------
INT 2F U - DOS 3+ internal - OUTPUT CHARACTER TO STANDARD OUTPUT
	AX = 1205h
	STACK: WORD character to output
Return: STACK unchanged
Note:	can be called only from within DOS
----------2F1206-----------------------------
INT 2F U - DOS 3+ internal - INVOKE CRITICAL ERROR
	AX = 1206h
	DI = error code
	BP:SI -> device driver header
	SS = DOS DS (must be using a DOS internal stack)
	STACK: WORD value to be passed to INT 24 in AX
Return: AL = 0-3 for Abort, Retry, Ignore, Fail
	STACK unchanged
SeeAlso: INT 24
----------2F1207-----------------------------
INT 2F U - DOS 3+ internal - MAKE DISK BUFFER MOST-RECENTLY USED
	AX = 1207h
	DS:DI -> disk buffer
Return: nothing
Desc:	move the indicated buffer to the end of the disk buffer chain (least-
	  recently used is first); under DOS 3.3, the buffer is then moved to
	  the start of the disk buffer chain if it was marked unused
Note:	can be called only from within DOS
SeeAlso: AX=120Fh
----------2F1208-----------------------------
INT 2F U - DOS 3+ internal - DECREMENT SFT REFERENCE COUNT
	AX = 1208h
	ES:DI -> SFT
Return: AX = original value of reference count
Notes:	if the reference count was 1, it is set to FFFFh (since 0 indicates
	  that the SFT is not in use).	It is the caller's responsibility to
	  set the reference count to zero after cleaning up.
	used by network redirectors such as MSCDEX
SeeAlso: AX=1106h
----------2F1209-----------------------------
INT 2F U - DOS 3+ internal - FLUSH AND FREE DISK BUFFER
	AX = 1209h
	DS:DI -> disk buffer
Return: disk buffer marked unused, contents written to disk if buffer dirty
Note:	can be called only from within DOS
SeeAlso: AX=120Eh,AX=1215h
----------2F120A-----------------------------
INT 2F U - DOS 3+ internal - PERFORM CRITICAL ERROR INTERRUPT
	AX = 120Ah
	DS = SS = DOS DS (must be using a DOS internal stack)
	STACK: WORD extended error code
Return: AL = user response (0=ignore, 1=retry, 2=abort, 3=fail)
	CF clear if retry, set otherwise
	STACK unchanged
Notes:	can only be called during a DOS function call, as it uses various
	  fields in the SDA to set up the registers for the INT 24
	reportedly sets current DPB's first root directory sector to 1
SeeAlso: INT 24
----------2F120B-----------------------------
INT 2F U - DOS 3+ internal - SIGNAL SHARING VIOLATION TO USER
	AX = 120Bh
	ES:DI -> system file table entry for previous open of file
	STACK: WORD extended error code (should be 20h--sharing violation)
Return: CF clear if operation should be retried
	CF set if operation should not be retried
	    AX = error code (20h) (see INT 21/AH=59h)
	STACK unchanged
Notes:	can only be called during a DOS function call
	should only be called if an attempt was made to open an already-open
	  file contrary to the sharing rules
	invokes INT 24 if SFT file opened via FCB or in compatibility mode with
	  inheritance allowed
----------2F120C-----------------------------
INT 2F U - DOS 3+ internal - OPEN DEVICE AND SET SFT OWNER???
	AX = 120Ch
	SDA current SFT pointer -> SFT for file
	DS = DOS DS
	SS = DOS DS (must be using a DOS internal stack)
Return: ES, DI, AX destroyed
Notes:	invokes "device open" call on device driver for SFT
	changes owner of last-accessed SFT to calling process if it was opened
	  via FCB
	called by network redirectors such as MSCDEX
----------2F120D-----------------------------
INT 2F U - DOS 3+ internal - GET DATE AND TIME
	AX = 120Dh
	SS = DOS DS (must be using a DOS internal stack)
Return: AX = current date in packed format (see INT 21/AX=5700h)
	DX = current time in packed format (see INT 21/AX=5700h)
SeeAlso: INT 21/AH=2Ah,INT 21/AH=2Ch
----------2F120E-----------------------------
INT 2F U - DOS 3+ internal - MARK ALL DISK BUFFERS UNREFERENCED
	AX = 120Eh
	SS = DOS DS (must be using a DOS internal stack)
Return: DS:DI -> first disk buffer
Note:	clears "referenced" flag on all disk buffers
SeeAlso: AX=1209h,AX=1210h,INT 21/AH=0Dh
----------2F120F-----------------------------
INT 2F U - DOS 3+ internal - MAKE BUFFER MOST RECENTLY USED
	AX = 120Fh
	DS:DI -> disk buffer
	SS = DOS DS (must be using a DOS internal stack)
Return: DS:DI -> next buffer in buffer list
Desc:	move the indicated buffer to the end of the disk buffer chain (least-
	  recently used is first); under DOS 3.3, the buffer is then moved to
	  the start of the disk buffer chain if it was marked unused
Note:	this function is the same as AX=1207h except that it returns a
	  pointer to the buffer following the specified buffer in the buffer
	  chain
SeeAlso: AX=1207h
----------2F1210-----------------------------
INT 2F U - DOS 3+ internal - FIND UNREFERENCED DISK BUFFER
	AX = 1210h
	DS:DI -> first disk buffer to check
Return: ZF clear if found
	    DS:DI -> first unreferenced disk buffer
	ZF set if not found
SeeAlso: AX=120Eh
----------2F1211-----------------------------
INT 2F U - DOS 3+ internal - NORMALIZE ASCIZ FILENAME
	AX = 1211h
	DS:SI -> ASCIZ filename to normalize
	ES:DI -> buffer for normalized filename
Return: destination buffer filled with uppercase filename, with slashes turned
	to backslashes
SeeAlso: AX=121Eh,AX=1221h
----------2F1212-----------------------------
INT 2F U - DOS 3+ internal - GET LENGTH OF ASCIZ STRING
	AX = 1212h
	ES:DI -> ASCIZ string
Return: CX = length of string
SeeAlso: AX=1225h
----------2F1213-----------------------------
INT 2F U - DOS 3+ internal - UPPERCASE CHARACTER
	AX = 1213h
	STACK: WORD character to convert to uppercase
Return: AL = uppercase character
	STACK unchanged
----------2F1214-----------------------------
INT 2F U - DOS 3+ internal - COMPARE FAR POINTERS
	AX = 1214h
	DS:SI = first pointer
	ES:DI = second pointer
Return: ZF set if pointers are equal, ZF clear if not equal
----------2F1215-----------------------------
INT 2F U - DOS 3+ internal - FLUSH BUFFER
	AX = 1215h
	DS:DI -> disk buffer
	SS = DOS DS (must be using a DOS internal stack)
	STACK: WORD drives for which to skip buffer
		ignore buffer if drive same as high byte, or bytes differ and
		the buffer is for a drive OTHER than that given in low byte
Return: STACK unchanged
Note:	can be called only from within DOS
SeeAlso: AX=1209h
----------2F1216-----------------------------
INT 2F U - DOS 3+ internal - GET ADDRESS OF SYSTEM FILE TABLE
	AX = 1216h
	BX = system file table entry number
Return: CF clear if successful
	    ES:DI -> system file table entry
	CF set if BX greater than FILES=
SeeAlso: AX=1220h
----------2F1217-----------------------------
INT 2F U - DOS 3+ internal - GET CURRENT DIRECTORY STRUCTURE FOR DRIVE
	AX = 1217h
	SS = DOS DS (must be using a DOS internal stack)
	STACK: WORD drive (0 = A:, 1 = B:, etc)
Return: CF set on error
	    (drive > LASTDRIVE)
	CF clear if successful
	    DS:SI -> current directory structure for specified drive
	STACK unchanged
SeeAlso: AX=1219h
----------2F1218-----------------------------
INT 2F U - DOS 3+ internal - GET CALLER'S REGISTERS
	AX = 1218h
Return: DS:SI -> saved caller's AX,BX,CX,DX,SI,DI,BP,DS,ES (on stack)
Note:	only valid while within DOS
----------2F1219-----------------------------
INT 2F U - DOS 3+ internal - SET DRIVE???
	AX = 1219h
	SS = DOS DS (must be using a DOS internal stack)
	STACK: WORD drive (0 = default, 1 = A:, etc)
Return: ???
	STACK unchanged
Notes:	calls AX=1217h
	builds a current directory structure if inside server call
	  (INT 21/AX=5D00h)
SeeAlso: AX=1217h,AX=121Fh
----------2F121A-----------------------------
INT 2F U - DOS 3+ internal - GET FILE'S DRIVE
	AX = 121Ah
	DS:SI -> filename
Return: AL = drive (0 = default, 1 = A:, etc, FFh = invalid)
	DS:SI -> filename without leading X: (if present)
SeeAlso: INT 21/AH=19h,INT 21/AH=60h
----------2F121B-----------------------------
INT 2F U - DOS 3+ internal - SET YEAR/LENGTH OF FEBRUARY
	AX = 121Bh
	CL = year - 1980
Return: AL = number of days in February
Note:	requires DS to be set to the DOS code segment
SeeAlso: INT 21/AH=2Bh
----------2F121C-----------------------------
INT 2F U - DOS 3+ internal - CHECKSUM MEMORY
	AX = 121Ch
	DS:SI -> start of memory to checksum
	CX = number of bytes
	DX = initial checksum
	SS = DOS DS (must be using a DOS internal stack)
Return: AX, CX destroyed
	DX = checksum
	DS:SI -> first byte after checksummed range
Note:	used by DOS to determine day count since 1/1/80 given a date
SeeAlso: AX=121Dh
----------2F121D-----------------------------
INT 2F U - DOS 3+ internal - SUM MEMORY
	AX = 121Dh
	DS:SI -> memory to add up
	CX = 0000h
	DX = limit
Return: AL = byte which exceeded limit
	CX = number of bytes before limit exceeded
	DX = remainder after adding first CX bytes
	DS:SI -> byte beyond the one which exceeded the limit
Note:	used by DOS to determine year or month given day count since 1/1/80
SeeAlso: AX=121Ch
----------2F121E-----------------------------
INT 2F U - DOS 3+ internal - COMPARE FILENAMES
	AX = 121Eh
	DS:SI -> first ASCIZ filename
	ES:DI -> second ASCIZ filename
Return: ZF set if filenames equivalent, ZF clear if not
SeeAlso: AX=1211h,AX=1221h
----------2F121F-----------------------------
INT 2F U - DOS 3+ internal - BUILD CURRENT DIRECTORY STRUCTURE
	AX = 121Fh
	SS = DOS DS (must be using a DOS internal stack)
	STACK: WORD drive letter
Return: ES:DI -> current directory structure (will be overwritten by next call)
	STACK unchanged
----------2F1220-----------------------------
INT 2F U - DOS 3+ internal - GET JOB FILE TABLE ENTRY
	AX = 1220h
	BX = file handle
Return: CF set on error
	    AL = 6 (invalid file handle)
	CF clear if successful
	    ES:DI -> JFT entry for file handle in current process
Note:	the byte pointed at by ES:DI contains the number of the SFT for the
	  file handle, or FFh if the handle is not open
SeeAlso: AX=1216h,AX=1229h
----------2F1221-----------------------------
INT 2F U - DOS 3+ internal - CANONICALIZE FILE NAME
	AX = 1221h
	DS:SI -> file name to be fully qualified
	ES:DI -> 128-byte buffer for resulting canonical file name
	SS = DOS DS (must be using a DOS internal stack)
Return: (see INT 21/AH=60h)
Note:	identical to INT 21/AH=60h
SeeAlso: AX=1123h,INT 21/AH=60h
----------2F1222-----------------------------
INT 2F U - DOS 3+ internal - SET EXTENDED ERROR INFO
	AX = 1222h
	SS = DOS data segment
	SS:SI -> 4-byte records
		BYTE	error code, FFh = last record
		BYTE	error class, FFh = don't change
		BYTE	suggested action, FFh = don't change
		BYTE	error locus, FFh = don't change
	SDA error code set
Return: SI destroyed
	SDA error class, error locus, and suggested action fields set
Note:	can be called only from within DOS
SeeAlso: AX=122Dh,INT 21/AH=59h
----------2F1223-----------------------------
INT 2F U - DOS 3+ internal - CHECK IF CHARACTER DEVICE
	AX = 1223h
	DS = DOS DS
	SS = DOS DS (must be using a DOS internal stack)
	SDA+218h (DOS 3.10-3.30) = eight-character blank-padded name
	SDA+22Bh (DOS 4.0-5.0) = eight-character blank-padded name
Return: CF set if no character device by that name found
	CF clear if found
	    BH = low byte of device attribute word
Note:	can only be called from within DOS
SeeAlso: INT 21/AX=5D06h,INT 21/AX=5D0Bh
----------2F1224-----------------------------
INT 2F U - DOS 3+ internal - DELAY
	AX = 1224h
	SS = DOS DS (must be using a DOS internal stack)
Return: after delay set by INT 21/AX=440Bh, unless in server call
	  (INT 21/AX=5D00h)
Note:	delay is dependent on the processor speed, and is skipped entirely if
	  inside a server call
SeeAlso: INT 21/AX=440Bh,INT 21/AH=52h
----------2F1225-----------------------------
INT 2F U - DOS 3+ internal - GET LENGTH OF ASCIZ STRING
	AX = 1225h
	DS:SI -> ASCIZ string
Return: CX = length of string
SeeAlso: AX=1212h
----------2F1226-----------------------------
INT 2F U - DOS 3.3+ internal - OPEN FILE
	AX = 1226h
	CL = access mode
	DS:DX -> ASCIZ filename
	SS = DOS DS (must be using a DOS internal stack)
Return: CF set on error
	    AL = error code (see INT 21/AH=59h)
	CF clear if successful
	    AX = file handle
Notes:	can only be called from within DOS
	equivalent to INT 21/AH=3Dh	
SeeAlso: AX=1227h,INT 21/AH=3Dh
----------2F1227-----------------------------
INT 2F U - DOS 3.3+ internal - CLOSE FILE
	AX = 1227h
	BX = file handle
	SS = DOS DS (must be using a DOS internal stack)
Return: CF set on error
	    AL = 06h invalid file handle
	CF clear if successful
Notes:	can only be called from within DOS
	equivalent to INT 21/AH=3Eh
SeeAlso: AX=1106h,AX=1201h,AX=1226h,INT 21/AH=3Eh
----------2F1228BP4200-----------------------
INT 2F U - DOS 3.3+ internal - MOVE FILE POINTER
	AX = 1228h
	BP = 4200h, 4201h, 4202h (see INT 21/AH=42h)
	BX = file handle
	CX:DX = offset in bytes
	SS = DOS DS (must be using a DOS internal stack)
Return: as for INT 21/AH=42h
Notes:	equivalent to INT 21/AH=42h, but may only be called from inside a DOS
	  function call
	sets user stack frame pointer to dummy buffer, moves BP to AX, performs
	  LSEEK, and restores frame pointer
SeeAlso: INT 21/AH=42h
----------2F1229-----------------------------
INT 2F U - DOS 3.3+ internal - READ FROM FILE
	AX = 1229h
	BX = file handle
	CX = number of bytes to read
	DS:DX -> buffer
	SS = DOS DS (must be using a DOS internal stack)
Return: as for INT 21/AH=3Fh
Note:	equivalent to INT 21/AH=3Fh, but may only be called when already inside
	  a DOS function call
SeeAlso: AX=1226h,INT 21/AH=3Fh
----------2F122A-----------------------------
INT 2F U - DOS 3.3+ internal - SET FASTOPEN ENTRY POINT
	AX = 122Ah
	BX = entry point to set (0001h or 0002h)
	DS:SI -> FASTOPEN entry point
		(entry point not set if SI = FFFFh for DOS 4+)
Return: CF set if specified entry point already set
Notes:	entry point in BX is ignored under DOS 3.30
	both entry points set to same handler by DOS 4.01

DOS 3.30+ FASTOPEN is called with:
	AL = 01h  ???
	    CX = ??? seems to be offset
	    DI = ??? seems to be offset
	    SI = offset in DOS DS of filename
	AL = 02h  ???
	AL = 03h  open file???
	    SI = offset in DOS DS of filename
	AL = 04h  ???
	    AH = subfunction (00h,01h,02h)
	    ES:DI -> ???
	    CX = ??? (subfunctions 01h and 02h only)
Returns: CF set on error or not installed
Note: function 03h calls function 01h first

PCDOS 4.01 FASTOPEN is additionally called with:
	AL = 04h ???
	    AH = 03h
	    ???
	AL = 05h ???
	AL = 0Bh ???
	AL = 0Ch ???
	AL = 0Dh ???
	AL = 0Eh ???
	AL = 0Fh ???
	AL = 10h ???

MSDOS 5.0 FASTOPEN is additionally called with:
	AL = 04h ???
	    AH = 03h
	    ???
	AL = 05h ???
	    DL = drive (00h = A:)
	    ???
	AL = 06h ???
----------2F122B-----------------------------
INT 2F U - DOS 3.3+ internal - IOCTL
	AX = 122Bh
	BP = 44xxh
	SS = DOS DS (must be using a DOS internal stack)
	additional registers as appropriate for INT 21/AX=44xxh
Return: as for INT 21/AH=44h
Notes:	equivalent to INT 21/AH=44h, but may only be called when already inside
	  a DOS function call
	sets user stack frame pointer to dummy buffer, moves BP to AX, performs
	  IOCTL, and restores frame pointer
SeeAlso: INT 21/AH=44h
----------2F122C-----------------------------
INT 2F U - DOS 3.3+ internal - GET DEVICE CHAIN
	AX = 122Ch
Return: BX:AX -> header of second device driver (NUL is first) in driver chain
SeeAlso: INT 21/AH=52h
----------2F122D-----------------------------
INT 2F U - DOS 3.3+ internal - GET EXTENDED ERROR CODE
	AX = 122Dh
Return: AX = current extended error code
SeeAlso: AX=1222h,INT 21/AH=59h
----------2F122E-----------------------------
INT 2F U - DOS 4+ internal - GET OR SET ERROR TABLE ADDRESSES
	AX = 122Eh
	DL = subfunction
	    00h get standard DOS error table
		Return: ES:DI -> error table
				 (DOS 4: errors 00h-12h,50h-5Bh)
				 (DOS 5: errors 00h-26h,4Fh,51h-59h)
	    01h set standard DOS error table
		ES:DI -> error table
	    02h get parameter error table (errors 00h-0Ah)
		Return: ES:DI -> error table
	    03h set parameter error table
		ES:DI -> error table
	    04h get critical/SHARE error table (errors 13h-2Bh)
		Return: ES:DI -> error table
	    05h set critical/SHARE error table
		ES:DI -> error table
	    06h get ??? error table
		Return: ES:DI -> error table or 0000h:0000h
	    07h set ??? error table
		ES:DI -> error table
	    08h get error message retriever (see below)
		Return: ES:DI -> FAR procedure to fetch error message 
	    09h set ??? error table
		ES:DI -> error table
Notes:	if the returned segment on a "get" is 0001h, then the offset specifies
	  the offset of the error message table within COMMAND.COM, and the
	  procedure returned by DL=08h should be called
	DOS 5.0 COMMAND.COM does not allow setting any of the addresses (calls
	  with DL odd are ignored); they are always returned with segment 0001h
	for DOS 5.0, the standard and critical/SHARE error tables are combined
	  into a single error table
SeeAlso: AX=0500h,INT 21/AH=59h

Format of DOS 4.x error table:
Offset	Size	Description
 00h	BYTE	FFh
 01h  2 BYTEs	04h,00h (DOS version???)
 03h	BYTE	number of error headers following
 04h 2N WORDs	table of all error headers for table
		Offset	Size	Description
		 00h	WORD	error message number
		 02h	WORD	offset of error message from start of header
				error messages are count byte followed by msg
Note:	DOS 5 error tables consist of one word per error number; each word
	  contains either the offset of a counted string or 0000h

Call error retrieval function with:
	AX = error number
	DI = offset of error table
Return: ES:DI -> error message (counted string)
Notes:	this function needs to access COMMAND.COM if the messages were not
	  loaded into memory permanently with /MSG; the caller should assume
	  that the returned message will be overwritten by the next call of
	  the function
	supported by DR-DOS 5.0
----------2F122F-----------------------------
INT 2F U - DOS 4.x internal - SET DOS VERSION NUMBER TO RETURN
	AX = 122Fh
	DX = DOS version number (0000h = return true DOS version)
Note:	not available under DR-DOS 5.0 or 6.0
SeeAlso: INT 21/AH=30h,INT 21/AX=3306h
----------2F13-------------------------------
INT 2F U - DOS 3.2+ - SET DISK INTERRUPT HANDLER
	AH = 13h
	DS:DX -> interrupt handler disk driver calls on read/write
	ES:BX = address to restore INT 13 to on system halt (exit from root
		 shell) or warm boot (INT 19)
Return: DS:DX from previous invocation of this function
	ES:BX from previous invocation of this function
Notes:	IO.SYS hooks INT 13 and inserts one or more filters ahead of the
	  original INT 13 handler.  The first is for disk change detection
	  on floppy drives, the second is for tracking formatting calls and
	  correcting DMA boundary errors, the third is for working around
	  problems in a particular version of IBM's ROM BIOS
	before the first call, ES:BX points at the original BIOS INT 13; DS:DX
	  also points there unless IO.SYS has installed a special filter for
	  hard disk reads (on systems with model byte FCh and BIOS date
	  "01/10/84" only), in which case it points at the special filter
	most DOS 3.3+ disk access is via the vector in DS:DX, although a few
	  functions are still invoked via an INT 13 instruction
	this is a dangerous security loophole for any virus-monitoring software
	  which does not trap this call (many Bulgarian viruses are known to
	  use it to get the original ROM entry point)
SeeAlso: INT 13/AH=01h,INT 19
----------2F1400-----------------------------
INT 2F - NLSFUNC.COM - INSTALLATION CHECK
	AX = 1400h
Return: AL = 00h not installed, OK to install
	     01h not installed, not OK
	     FFh installed
Notes:	called by DOS v3.3+ kernel
	supported by OS/2 v1.3+ compatibility box, which always returns AL=FFh
	supported by DR-DOS 5.0
	documented for MS-DOS 5.0, but undocumented in prior versions
SeeAlso: AX=1401h"NLSFUNC",AX=1402h"NLSFUNC"
----------2F1400-----------------------------
INT 2F - European MSDOS 4.0 POPUP - "CheckPu" - INSTALLATION CHECK
	AX = 1400h
Return: AX = FFFFh if installed
	    BX = maximum memory required to save screen and keyboard info
	CF clear if successful
	CF set on error
	    AX = error code
	    	0002h invalid function
		0004h unknown error
Note:	the POPUP interface is used by background programs (see INT 21/AH=80h)
	  to communicate with the user
SeeAlso: AX=1401h"POPUP",AX=1402h"POPUP",AX=1403h"POPUP"
----------2F1401-----------------------------
INT 2F U - NLSFUNC.COM - CHANGE CODE PAGE
	AX = 1401h
	DS:SI -> internal code page structure (see below)
	BX = new code page
	DX = country code???
Return: AL = status
	     00h successful
	     else DOS error code
Note:	called by DOS v3.3+ kernel
SeeAlso: AX=1400h"NLSFUNC",AX=1402h"NLSFUNC",INT 21/AH=66h

Format of DOS 3.30 internal code page structure:
Offset	Size	Description
 00h  8 BYTEs	???
 08h 64 BYTEs	name of country information file
 48h	WORD	system code page
 4Ah	WORD	number of supported subfunctions
 4Ch  5 BYTEs	data to return for INT 21/AX=6502h
 51h  5 BYTEs	data to return for INT 21/AX=6504h
 56h  5 BYTEs	data to return for INT 21/AX=6505h
 5Bh  5 BYTEs	data to return for INT 21/AX=6506h
 60h 41 BYTEs	data to return for INT 21/AX=6501h
----------2F1401-----------------------------
INT 2F - European MSDOS 4.0 POPUP - "PostPu" - OPEN/CLOSE POPUP SCREEN
	AX = 1401h
	DL = function (00h open, 01h close)
	DH = wait flag
	    00h block until screen opens
	    01h return error if screen is not available
	    02h urgent--always open screen immediately
Return: CF clear if successful
	    BX = amount of memory needed to save screen and keyboard info,
	    	0000h if default save location can be used (only if DH was 02h)
	CF set on error
Note:	the application using the screen is frozen until the popup screen is
	  closed
SeeAlso: AX=1400h"POPUP",AX=1402h"POPUP",AX=1403h"POPUP"
----------2F1402-----------------------------
INT 2F U - NLSFUNC.COM - GET COUNTRY INFO
	AX = 1402h
	BP = subfunction (same as AL for INT 21/AH=65h)
	BX = code page
	DX = country code
	DS:SI -> internal code page structure (see AX=1401h)
	ES:DI -> user buffer
	CX = size of user buffer
Return: AL = status
	    00h successful
	    else DOS error code
Notes:	called by DOS v3.3+ kernel on INT 21/AH=65h
	code page structure apparently only needed for COUNTRY.SYS pathname
SeeAlso: AX=1401h"NLSFUNC",AX=1403h"NLSFUNC",AX=1404h,INT 21/AH=65h
----------2F1402-----------------------------
INT 2F - European MSDOS 4.0 POPUP - "SavePu" - SAVE POPUP SCREEN
	AX = 1402h
	ES:DI -> save buffer (0000h:0000h for default buffer in POPUP)
Return: CF clear if successful
	CF set on error
	    AX = error code
		0001h process does not own screen
		0004h unknown error
		0005h invalid pointer
SeeAlso: AX=1400h"POPUP",AX=1401h"POPUP",AX=1403h"POPUP"
----------2F1403-----------------------------
INT 2F U - NLSFUNC.COM - SET COUNTRY INFO
	AX = 1403h
	DS:SI -> internal code page structure (see AX=1401h)
	BX = code page
	DX = country code
Return: AL = status 
	     ???
Note:	called by DOS v3.3+ kernel on INT 21/AH=38h
SeeAlso: AX=1402h"NLSFUNC",AX=1404h,INT 21/AH=38h"SET"
----------2F1403-----------------------------
INT 2F - European MSDOS 4.0 POPUP - "RestorePu" - RESTORE SCREEN
	AX = 1403h
	ES:DI -> buffer containing saved screen
		(0000h:0000h for default buffer in POPUP)
Return: CF clear if successful
	CF set on error
	    AX = error code (see AX=1402h"POPUP")
SeeAlso: AX=1400h"POPUP",AX=1401h"POPUP",AX=1402h"POPUP"
----------2F1404-----------------------------
INT 2F U - NLSFUNC.COM - GET COUNTRY INFO
	AX = 1404h
	BX = code page
	DX = country code
	DS:SI -> internal code page structure (see AX=1401h)
	ES:DI -> user buffer
Return: AL = status
	     ???
Notes:	called by DOS v3.3+ kernel on INT 21/AH=38h
	code page structure apparently only needed for COUNTRY.SYS pathname
SeeAlso: AX=1402h,AX=1403h,INT 21/AH=38h"GET"
----------2F14FE-----------------------------
INT 2F U - DR-DOS 5.0 NLSFUNC - ???
	AX = 14FEh
	DI = ???
	???
Return: ???
Note:	DR-DOS 5.0 NLSFUNC returns CF set and AX=0001h if AL was not 00h, FEh,
	  or FFh on entry.
SeeAlso: AX=14FFh
----------2F14FF-----------------------------
INT 2F U - DR-DOS 5.0 NLSFUNC - ???
	AX = 14FFh
	???
Return: ???
Note:	DR-DOS 5.0 NLSFUNC returns CF set and AX=0001h if AL was not 00h, FEh,
	  or FFh on entry.
SeeAlso: AX=14FEh
----------2F1500-----------------------------
INT 2F - DOS 4.00 GRAPHICS.COM - INSTALLATION CHECK
	AX = 1500h
Return: AX = FFFFh
	ES:DI -> ??? (graphics data?)
Note:	this installation check conflicts with the CD-ROM Extensions
	  installation check; moved to AX=AC00h in later versions
SeeAlso: AX=AC00h
----------2F1500BX0000-----------------------
INT 2F - CD-ROM - INSTALLATION CHECK
	AX = 1500h
	BX = 0000h
Return: BX = number of CD-ROM drive letters used
	CX = starting drive letter (0=A:)
Notes:	this installation check DOES NOT follow the format used by other
	  software
	this installation check conflicts with the DOS 4.00 GRAPHICS.COM
	  installation check
SeeAlso: INT 2F/AX=D000h"Lotus"
----------2F1501-----------------------------
INT 2F - CD-ROM - GET DRIVE DEVICE LIST
	AX = 1501h
	ES:BX -> buffer to hold drive letter list (5 bytes per drive letter)
Return: buffer filled, for each drive letter
	  BYTE	subunit number in driver
	  DWORD address of device driver header
----------2F1502-----------------------------
INT 2F - CD-ROM - GET COPYRIGHT FILE NAME
	AX = 1502h
	ES:BX -> 38-byte buffer for name of copyright file
	CX = drive number (0=A:)
Return: CF set if drive is not a CD-ROM drive
	    AX = 15 (invalid drive)
	CF clear if successful
SeeAlso: AX=1503h
----------2F1503-----------------------------
INT 2F - CD-ROM - GET ABSTRACT FILE NAME
	AX = 1503h
	ES:BX -> 38-byte buffer for name of abstract file
	CX = drive number (0=A:)
Return: CF set if drive is not a CD-ROM drive
	    AX = 15 (invalid drive)
	CF clear if successful
SeeAlso: AX=1502h
----------2F1504-----------------------------
INT 2F - CD-ROM - GET BIBLIOGRAPHIC DOC FILE NAME
	AX = 1504h
	ES:BX -> 38-byte buffer for name of bibliographic documentation file
	CX = drive number (0=A:)
Return: CF set if drive is not a CD-ROM drive
	    AX = 15 (invalid drive)
	CF clear if successful
----------2F1505-----------------------------
INT 2F - CD-ROM - READ VTOC
	AX = 1505h
	ES:BX -> 2048-byte buffer
	CX = drive number (0=A:)
	DX = sector index (0=first volume descriptor,1=second,...)
Return: CF set on error
	    AX = error code (15=invalid drive,21=not ready)
	CF clear if successful
	    AX = volume descriptor type (1=standard,FFh=terminator,0=other)
----------2F1506-----------------------------
INT 2F - CD-ROM - TURN DEBUGGING ON
	AX = 1506h
	BX = debugging function to enable
Note:	reserved for development
SeeAlso: AX=1507h
----------2F1507-----------------------------
INT 2F - CD-ROM - TURN DEBUGGING OFF
	AX = 1507h
	BX = debugging function to disable
Note:	reserved for development
SeeAlso: AX=1506h
----------2F1508-----------------------------
INT 2F - CD-ROM - ABSOLUTE DISK READ
	AX = 1508h
	ES:BX -> buffer
	CX = drive number (0=A:)
	SI:DI = starting sector number
	DX = number of sectors to read
Return: CF set on error
	    AL = error code (15=invalid drive,21=not ready)
	CF clear if successful
SeeAlso: AX=1509h
----------2F1509-----------------------------
INT 2F - CD-ROM - ABSOLUTE DISK WRITE
	AX = 1509h
	ES:BX -> buffer
	CX = drive number (0=A:)
	SI:DI = starting sector number
	DX = number of sectors to write
Note:	corresponds to INT 26h and is currently reserved and nonfunctional
SeeAlso: AX=1508h
----------2F150A-----------------------------
INT 2F - CD-ROM - RESERVED
	AX = 150Ah
----------2F150B-----------------------------
INT 2F - CD-ROM v2.00+ - DRIVE CHECK
	AX = 150Bh
	CX = drive number (0=A:)
Return: BX = ADADh if MSCDEX.EXE installed
	    AX = 0000h if drive not supported
		nonzero if supported
SeeAlso: AX=150Dh
----------2F150C-----------------------------
INT 2F - CD-ROM v2.00+ - GET MSCDEX.EXE VERSION
	AX = 150Ch
Return: BH = major version
	BL = minor version
Note:	MSCDEX.EXE versions prior to 2.00 return BX=0
----------2F150D-----------------------------
INT 2F - CD-ROM v2.00+ - GET CD-ROM DRIVE LETTERS
	AX = 150Dh
	ES:BX -> buffer for drive letter list (1 byte per drive)
Return: buffer filled with drive numbers (0=A:).  Each byte corresponds
	to the drive in the same position for function 1501h
SeeAlso: AX=150Bh
----------2F150E-----------------------------
INT 2F - CD-ROM v2.00+ - GET/SET VOLUME DESCRIPTOR PREFERENCE
	AX = 150Eh
	BX = subfunction
	    00h get preference
		DX = 0000h
		Return: DX = preference settings
	    01h set preference
		DH = volume descriptor preference
		    01h = primary volume descriptor
		    02h = supplementary volume descriptor
		DL = supplementary volume descriptor preference
		    01h = shift-Kanji
	CX = drive number (0=A:)
Return: CF set on error
	    AX = error code (15=invalid drive,1=invalid function)
	CF clear if successful
----------2F150F-----------------------------
INT 2F - CD-ROM v2.00+ - GET DIRECTORY ENTRY
	AX = 150Fh
	CL = drive number (0=A:)
	CH bit 0 = copy flag
		clear if direct copy
		set if copy to structure which removed ISO/High Sierra diffs
	ES:BX -> ASCIZ path name
	SI:DI -> buffer for directory entry (see below)
		 minimum 255 bytes for direct copy
Return: CF set on error
	    AX = error code
	CF clear if succesful
	    AX = disk format (0=High Sierra,1=ISO 9660)

Format of directory entry (direct copy):
Offset	Size	Description
 00h	BYTE  length of directory entry
 01h	BYTE  length of XAR in Logical Block Numbers
 02h	DWORD LBN of data, Intel (little-endian) format
 06h	DWORD LBN of data, Motorola (big-endian) format
 0Ah	DWORD length of file, Intel format
 0Eh	DWORD length of file, Motorola format
---High Sierra---
 12h  6 BYTEs date and time
 18h	BYTE  bit flags
 19h	BYTE  reserved
---ISO 9660---
 12h  7 BYTEs date and time
 19h	BYTE  bit flags
---both formats---
 1Ah	BYTE  interleave size
 1Bh	BYTE  interleave skip factor
 1Ch	WORD  volume set sequence number, Intel format
 1Eh	WORD  volume set sequence number, Motorola format
 20h	BYTE  length of file name
 21h  N BYTEs file name
	BYTE (optional) padding if filename is odd length
      N BYTEs system data

Format of directory entry (canonicalized):
Offset	Size	Description
 00h	BYTE	length of XAR in Logical Block Numbers
 01h	DWORD	Logical Block Number of file start
 05h	WORD	size of disk in logical blocks
 07h	DWORD	file length in bytes
 0Bh  7 BYTEs	date and time
 12h	BYTE	bit flags
 13h	BYTE	interleave size
 14h	BYTE	interleave skip factor
 15h	WORD	volume set sequence number
 17h	BYTE	length of file name
 18h 38 BYTEs	ASCIZ filename
 3Eh	WORD	file version number
 40h	BYTE	number of bytes of system use data
 41h 220 BYTEs	system use data
----------2F1510-----------------------------
INT 2F - CD-ROM v2.10+ - SEND DEVICE DRIVER REQUEST
	AX = 1510h
	CX = CD-ROM drive letter (0 = A, 1 = B, etc)
	ES:BX -> CD-ROM device driver request header (see AX=0802h)
----------2F1600-----------------------------
INT 2F - MS WINDOWS - WINDOWS ENHANCED MODE INSTALLATION CHECK
	AX = 1600h
Return: AL = 00h if Windows 3.x enhanced mode or Windows/386 2.x not running
	AL = 80h if Windows 3.x enhanced mode or Windows/386 2.x not running
	AL = 01h if Windows/386 2.x running
	AL = FFh if Windows/386 2.x running
	AL = anything else
	    AL = Windows major version number >= 3
	    AH = Windows minor version number
Note:	INT 2F/AH=16h comprises an API for non-Windows programs (DOS device
	  drivers, TSRs, and applications) to cooperate with multitasking
	  Windows/386 2.x and Windows 3.x and higher enhanced mode.
	certain calls are also supported in the Microsoft 80286 DOS extender in
	  Windows standard mode
SeeAlso: AX=4680h
----------2F1602-----------------------------
INT 2F - MS WINDOWS/386 2.x - GET API ENTRY POINT
	AX = 1602h
Return: ES:DI -> Windows/386 2.x API procedure entry point
Notes:	this interface is supported in Windows 3.x only for 2.x compatibility
	to get the current virtual machine (VM) ID in Windows/386 2.x:
	    AX = 0000h
	    ES:DI -> return address
	    JUMP to address returned from INT 2F/AX=1602h
	After JUMP, at return address:
	    BX = current VM ID.
SeeAlso: AX=0C20h
----------2F1603-----------------------------
INT 2F - RM Nimbus MSDOS 3.3 - ???
	AX = 1603h
Return: AX = 5248h ('RH')
	DS:SI -> first byte after INT 2F handler in IBMBIO.COM
----------2F1605-----------------------------
INT 2F - MS WINDOWS - WINDOWS ENH MODE & 286 DOSX INIT BROADCAST
	AX = 1605h
	ES:BX = 0000h:0000h
	DS:SI = 0000h:0000h
	CX = 0000h
	DX = flags
	    bit 0 = 0 if Windows enhanced-mode initialization
	    bit 0 = 1 if Microsoft 286 DOS extender initialization
	    bits 1-15 reserved (undefined)
	DI = version number (major in upper byte, minor in lower)
Return: CX = 0000h if okay for Windows to load
	CX <> 0 if Windows should not load
	ES:BX -> startup info structure (see below)
	DS:SI -> virtual86 mode enable/disable callback or 0000h:0000h
Notes:	the Windows enhanced mode loader and Microsoft 286 DOS extender will
	  broadcast an INT 2F/AX=1605h call when initializing.	Any DOS device
	  driver or TSR can watch for this broadcast and return the appropriate
	  values.  If the driver or TSR returns CX <> 0, it is also its
	  responsibility to display an error message.
	each handler must first chain to the prior INT 2F handler with
	  registers unchanged before processing the call
	if the handler requires local data on a per-VM basis, it must store the
	  returned ES:BX in the "next" field of a startup info structure and
	  return a pointer to that structure in ES:BX
	a single TSR may set the V86 mode enable/disable callback; if DS:SI is
	  already nonzero, the TSR must fail the initialization by setting CX
	  nonzero
SeeAlso: AX=1606h,AX=1608h,AX=4B05h

Format of Startup Information Structure:
Offset	Size	Description
 00h  2 BYTEs	major, minor version of info structure
 02h	DWORD	pointer to next startup info structure or 0000h:0000h
 06h	DWORD	pointer to ASCIZ name of virtual device file or 0000h:0000h
 0Ah	DWORD	virtual device reference data (only used if above nonzero)
 0Eh	DWORD	pointer to instance data records or 0000h:0000h

Format of one Instance Item in array:
Offset	Size	Description
 00h	DWORD	address of instance data (end of array if 0000h:0000h)
 04h	WORD	size of instance data

Virtual mode enable/disable procedure called with:
	AX = 0000h disable V86 mode
	AX = 0001h enable V86 mode
	interrupts disabled
Return: CF set on error
	CF clear if successful
	interrupts disabled
----------2F1606-----------------------------
INT 2F - MS WINDOWS - WINDOWS ENH MODE & 286 DOSX EXIT BROADCAST
	AX = 1606h
	DX = flags
	    bit 0 = 0 if Windows enhanced-mode exit
	    bit 0 = 1 if Microsoft 286 DOS extender exit
	    bits 1-15 reserved (undefined)
Notes:	if the init broadcast fails (AX=1605h returned CX <> 0), then this
	  broadcast will be issued immediately.
	this call will be issued in real mode
SeeAlso: AX=1605h,AX=1609h
----------2F1607-----------------------------
INT 2F - MS WINDOWS - VIRTUAL DEVICE CALL OUT API
	AX = 1607h
	BX = virtual device ID (see INT 2F/AX=1684h)
	CX = (usually) callout subfunction
Return: (usually) AX,BX,CX,DX,ES contain results
Notes:	more of a convention than an API, this call specifies a standard
	  mechanism for Windows enhanced-mode virtual devices (VxD's) to talk
	  to DOS device drivers and TSRs
	see below for details on several virtual devices
SeeAlso: AX=0C20h,AX=1605h,AX=1607h/BX=000Ch,AX=1607h/BX=0014h
SeeAlso: AX=1607h/BX=0015h,AX=1684h
----------2F1607BX000C-----------------------
INT 2F - MS WINDOWS - "VMD" VIRTUAL DEVICE API
	AX = 1607h
	BX = 000Ch (VxD identifier of "VMD")
Return: CX = nonzero if mouse driver already virtualized
Note:	VMD (Virtual Mouse Driver) calls this and then checks whether CX is
	  nonzero; if yes, it will not automatically virtualize the mouse
	  driver.  This would be used if MOUSE.COM already virtualizes
	  itself using the Windows API.
SeeAlso: AX=1607h/BX=0014h,AX=1607h/BX=0015h
----------2F1607BX0014-----------------------
INT 2F - MS WINDOWS - "VNETBIOS" VIRTUAL DEVICE API
	AX = 1607h
	BX = 0014H (VxD identifier of "VNETBIOS")
Return: ES:DI -> 128-byte table specifying VNETBIOS actions for each NetBIOS
		command code (see below)
Note:	VNETBIOS (Virtual NetBIOS) calls this function to determine whether
	  the NetBIOS has an extensions Windows should know about
SeeAlso: AX=1607h/BX=000Ch,AX=1607h/BX=0015h

Values for action code:
 00h	"VN_Unknown" unknown command
 04h	"VN_No_Map"  no memory mapping necessary
 08h	"VN_Map_In"  input buffer is quickly used, so no global mapping needed
 0Ch	"VN_Map_In"  output buffer is quickly used, so no global mapping needed
 10h	"VN_Map_In_Out"  buffer is quickly used, so no global mapping needed
 14h	"VN_Chain_Send"  the chain-send command
 18h	"VN_Cancel"	special case for cancel command
 1Ch	"VN_Buffer_In"	buffer is incoming
 20h	"VN_Buffer_Out" buffer is outgoing
 24h	"VN_Buffer_In_Out" buffer used for both incoming and outgoing data
----------2F1607BX0015-----------------------
INT 2F - MS WINDOWS - "DOSMGR" VIRTUAL DEVICE API
	AX = 1607h
	BX = 0015h (VxD identifier of "DOSMGR")
	CX = function
	    0000h query instance processing
	    	Return: CX = state
			    0000h not instanced
			    other instanced (DOS 5.0 kernel returns 0001h)
				DX = segment of DOS drivers
					(unchanged if call handled by DOS 5.0)
				ES:BX -> patch table (see below)
	    0001h set patches in DOS
	    	DX = bit mask of patch requests
		    bit 0 enable critical sections
		    bit 1 NOP setting/checking user ID
		    bit 2 turn INT 21/AH=3Fh on STDIN into polling loop
		    bit 3 trap stack fault in "SYSINIT" to WIN386
		    bit 4 BIOS patch to trap "Insert disk X:" to WIN386
		Return: AX = B97Ch
			BX = bit mask of patches applied
			DX = A2ABh
	    0002h remove patches in DOS (ignored by DOS 5.0 kernel)
		DX = bit mask of patch requests (see function 0001h)
	    0003h get size of DOS data structures
	    	DX = bit mask of request (only one bit can be set)
		    bit 0: Current Directory Structure size
		Return: if supported request:
			    AX = B97Ch
			    CX = size in bytes of requested structure
			    DX = A2ABh
			else:
			    all registers preserved
	    0004h determine instanced data structures
	    	Return: AX = B97Ch if supported
			DX = A2ABh if supported (DOS 5.0 kernel returns 0000h)
			BX = bit mask of instanced items
			    bit 0: CDS
			    bit 1: SFT
			    bit 2: device list
			    bit 3: DOS swappable data area
	    0005h get device driver size
	    	ES = segment of device driver
		Return: DX:AX = 0000h:0000h on error (not dev. driver segment)
			DX:AX = A2ABh:B97Ch if successful
			    BX:CX = size of device driver in bytes
Notes:	the DOS 5.0 kernel provides these calls; earlier versions require a
	  separate driver
	DOSMGR (DOS Manager) will check whether the OEM DOS/BIOS data has
	  been instanced via INT 2F/AX=1605h and will not perform its own
	  instancing of the normal DOS/BIOS data if so
SeeAlso: AX=1605h,AX=1607h/BX=000Ch,AX=1607h/BX=0014h,AX=1684h

Format of patch table:
Offset	Size	Description
 00h	WORD	number of items in patch table
 02h  N WORDs	offsets of ??? to be patched
----------2F1607BX22C0-----------------------
INT 2F - Rational Systems DOS/4GW - ???
	AX = 1607h
	BX = 22C0h
	???
Return: ???
SeeAlso: INT 15/AX=BF02h,INT 15/AX=BF04h
----------2F1608-----------------------------
INT 2F - MS WINDOWS - WINDOWS ENHANCED MODE INIT COMPLETE BROADCAST
	AX = 1608h
Notes:	called after all installable devices have been initialized
	real-mode software may be called between the Windows enhanced-mode init
	  call (AX=1605h) and this call; the software must detect this
	  situation
SeeAlso: AX=1605h,AX=1609h
----------2F1609-----------------------------
INT 2F - MS WINDOWS - WINDOWS ENHANCED MODE BEGIN EXIT BROADCAST
	AX = 1609h
Note:	called at the beginning of a normal exit sequence; not made in the
	  event of a fatal system crash
SeeAlso: AX=1606h,AX=1608h
----------2F160A-----------------------------
INT 2F - MS Windows 3.1 - IDENTIFY WINDOWS VERSION AND TYPE
	AX = 160Ah
	???
Return: ???
----------2F160B-----------------------------
INT 2F - MS Windows 3.1 - IDENTIFY TSRs
	AX = 160Bh
	???
Return: ???

Format of TSR-to-Windows communication structure:
Offset	Size	Description
 00h	DWORD	pointer to next structure
 04h	WORD	PSP segment
 06h	WORD	API version ID (0100h)
 08h	WORD	EXEC flags
 		bit 0: "WINEXEC"
		bit 1: "LOADLIBRARY"
		bit 2: "OPENDRIVER"
 0Ah	WORD	"exec_cmd_show"
 0Ch	DWORD	"exec_cmd"
 10h  4 BYTEs	reserved (0)
 14h	DWORD	TSR ID block
 18h	DWORD	TSR data block
----------2F160C-----------------------------
INT 2F - MS Windows 3.1 - DETECT ROMs
	AX = 160Ch
	???
Return: ???
Note:	used by ROM Windows
----------2F1680-----------------------------
INT 2F - MS WINDOWS, DPMI, various - RELEASE CURRENT VIRTUAL MACHINE TIME-SLICE
	AX = 1680h
Return: AL = 00h if the call is supported
	AL = 80h (unchanged) if the call is not supported
Notes:	programs can use this function in idle loops to enhance performance
	  under multitaskers; this call is supported by MS Windows 3.0, DOS 5+,
	  DPMI 1.0+, and will be supported in OS/2 2.0 for multitasking DOS
	  applications
	does not block the program; it just gives up the remainder of the time
	  slice
	should not be used by Windows-specific programs
SeeAlso: INT 15/AX=1000h,INT 15/AX=5305h,INT 21/AH=89h,INT 7A/BX=000Ah
----------2F1681-----------------------------
INT 2F - MS WINDOWS 3+ - BEGIN CRITICAL SECTION
	AX = 1681h
Notes:	used to prevent a task switch from occurring
	should be followed by an INT 2F/AX=1682h call as soon as possible
	nested calls are allowed, and must be followed by an appropriate number
	  of "end critical section" calls
	not supported in Windows/386 2.x. Get INDOS flag with INT 21/AH=34h and
	  and increment by hand.
SeeAlso: AX=1682h,INT 15/AX=101Bh,INT 21/AH=34h
----------2F1682-----------------------------
INT 2F - MS WINDOWS 3+ - END CRITICAL SECTION
	AX = 1682h
Notes:	not supported in Windows/386 2.x.  Get InDOS flag with INT 21/AH=34h
	  and decrement by hand, taking care not to decrement InDOS flag
	  through zero
SeeAlso: AX=1681h,INT 15/AX=101Ch,INT 21/AH=34h
----------2F1683-----------------------------
INT 2F - MS WINDOWS 3+ - GET CURRENT VIRTUAL MACHINE ID
	AX = 1683h
Return: BX = current virtual machine (VM) ID
Notes:	Windows itself currently runs in VM 1, but this can't be relied upon
	VM IDs are reused when VMs are destroyed
	an ID of 0 will never be returned
SeeAlso: AX=1684h,AX=1685h,AX=168Bh
----------2F1684-----------------------------
INT 2F - MS WINDOWS - GET DEVICE API ENTRY POINT
	AX = 1684h
	BX = virtual device (VxD) ID (see below)
	ES:DI = 0000h:0000h
Return: ES:DI -> VxD API entry point, or 0:0 if the VxD does not support an API
Note:	some Windows enhanced-mode virtual devices provide services that
	  applications can access.  For example, the Virtual Display Device
	  (VDD) provides an API used in turn by WINOLDAP.
SeeAlso: AX=1683h

Values for VxD ID:
 01h	VMM		Virtual Machine Manager
 02h	Debug
 03h	VPICD		Virtual Prog. Interrupt Controller (PIC) Device
 04h	VDMAD		Virtual Direct Memory Access (DMA) Device
 05h	VTD		Virtual Timer Device
 06h	V86MMGR		Virtual 8086 Mode Device
 07h	PAGESWAP	Paging Device
 08h	Parity
 09h	Reboot
 0Ah	VDD		Virtual Display Device (GRABBER)
 0Bh	VSD		Virtual Sound Device
 0Ch	VMD		Virtual Mouse Device
 0Dh	VKD		Virtual Keyboard Device
 0Eh	VCD		Virtual COMM Device
 0Fh	VPD		Virtual Printer Device
 10h	VHD		Virtual Hard Disk Device
 11h	VMCPD
 12h	EBIOS		Reserve EBIOS page (e.g., on PS/2)
 13h	BIOSXLAT	Map ROM BIOS API between prot & V86 mode
 14h	VNETBIOS	Virtual NetBIOS Device
 15h	DOSMGR
 16h	WINLOAD
 17h	SHELL
 18h	VMPoll
 19h	VPROD
 1Ah	DOSNET		assures network integrity across VMs
 1Bh	VFD		Virtual Floppy Device
 1Ch	VDD2		Secondary display adapter
 1Dh	WINDEBUG
 1Eh	TSRLoad		TSR instance utility
Note:	The high bit of the VxD ID is reserved for future use. The
	next 10 bits are the OEM # which is assigned by Microsoft. The
	low 5 bits are the device number. 

Call VTD.386 entry point with:
	AX = 0000h get VTD version number
	    Return: AH = major version
	    	    AL = minor version
	AX = 0100h get current clock tick time
	    Return: EDX:EAX = clock tick time in 840ns units since Windows was
	    			started
	AX = 0101h get current system time in milliseconds
	    Return: EAX = time in milliseconds that Windows has been running
	AX = 0102h get current virtual machine time
	    Return: EAX = cumulative amount of time the virtual machine has
	    		been active, in milliseconds
Note:	should only be called directly when TOOLHELP.DLL TimerCount() cannot
	  be called
----------2F1685-----------------------------
INT 2F - MS WINDOWS - SWITCH VMs AND CALLBACK
	AX = 1685h
	BX = VM ID of virtual machine to switch to
	CX = flags
		bit 0 wait until interrupts enabled
		bit 1 wait until critical section unowned
		bits 2-15 reserved (zero)
	DX:SI = priority boost (see VMM.INC)
	ES:DI -> FAR procedure to callback
Return: CF set on error
	    AX = error code
		01h invalid VM ID
		02h invalid priority boost
		03h invalid flags
	CF clear if successful
	    event will be or has been called
Notes:	some DOS devices, such as networks, need to call functions in a
	  specific VM. This call forces the appropriate VM to be installed.
	the callback procedure must preserve all registers and return with IRET
SeeAlso: AX=1683h,INT 15/AX=1117h
----------2F1686-----------------------------
INT 2F - DOS Protected-Mode Interface - DETECT MODE
	AX = 1686h
Return: AX = 0000h if operating in protected mode under DPMI (INT 31 available)
	AX nonzero if in real/V86 mode or no DPMI (INT 31 not available)
SeeAlso: AX=1687h
----------2F1687-----------------------------
INT 2F - DOS Protected-Mode Interface - INSTALLATION CHECK
	AX = 1687h
Return: AX = 0000h if installed
	    BX = flags
		bit 0: 32-bit programs supported
	    CL = processor type (02h=80286, 03h=80386, 04h=80486)
	    DH = DPMI major version
	    DL = two-digit DPMI minor version
	    SI = number of paragraphs of DOS extender private data
	    ES:DI -> DPMI mode-switch entry point
	AX nonzero if not installed
SeeAlso: AX=1686h,INT 38/AH=10h

Call mode switch entry point with:
	AX = flags
	    bit 0: set if 32-bit program
	ES = real mode segment of buffer for DPMI private data (ignored if
		SI was zero)
Return: CF set on error
	    program still in real mode
	    AX = error code (DPMI 1.0+)
	       8011h unable to allocate all necessary descriptors
	       8021h 32-bit program specified, but 16-bit DPMI host
	CF clear if successful
	    CS = 16-bit selector corresponding to real-mode CS
	    SS = selector corresponding to real-mode SS (64K limit)
	    DS = selector corresponding to real-mode DS (64K limit)
	    ES = selector to program's PSP (100h byte limit)
	    FS = GS = 0
	    high word of ESP = 0 if 32-bit program
	    program now in protected mode
Note:	this entry point is only called for the initial switch to protected
	  mode
----------2F1688-----------------------------
INT 2F U - MS Windows 3.0, 386MAX v6.01 - GET SELECTOR TO LDT
	AX = 1688h
Return: AX = status??? (0000h for 386MAX)
	BX = selector for ???
----------2F1689-----------------------------
INT 2F U - MS Windows 3.0+ - KERNEL IDLE CALL
	AX = 1689h
	???
Return: ???
----------2F168A-----------------------------
INT 2F - DPMI 0.9+ - GET VENDOR-SPECIFIC API ENTRY POINT
	AX = 168Ah
	DS:(E)SI = selector:offset of ASCIZ vendor name
Return: AL = status
	    00h successful
	       ES:(E)DI -> extended API entry point
	    8Ah unsuccessful
Notes:	the vendor name is used to determine which entry point to return; it is
	  case-sensitive
	available in protected mode only
	32-bit applications use ESI and EDI, 16-bit applications use SI and DI
	this call is present but not documented for DPMI 0.9
SeeAlso: INT 31/AX=0A00h

Vendor names:
 "MS-DOS"	??? and 386MAX v6.00+
 "386MAX"	386MAX v6.00+
----------2F168B-----------------------------
INT 2F - MS Windows 3.1 - SET FOCUS TO SPECIFIED VIRTUAL MACHINE
	AX = 168Bh
	???
Return: ???
SeeAlso: AX=1683h
----------2F168C-----------------------------
INT 2F - MS Windows 3.1 - RESTART COMMAND
	AX = 168Ch
	???
Return: ???
Note:	WIN.COM executes specified application
----------2F1700-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - IDENTIFY WinOldAp VERSION
	AX = 1700h
Return: AX = 1700h if this version of WINOLDAP doesn't support clipboard
	AX <> 1700h
		AL = WINOLDAP major version
		AH = WINOLDAP minor version
Notes:	WinOldAp (WINOLDAP.MOD) is a Microsoft Windows extension supporting
	  "old" (character-mode) application access to Dynamic Data Exchange,
	  menus, and the Windows clipboard.
	this installation check DOES NOT follow the format used by other
	  software
----------2F1701-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - OPEN CLIPBOARD
	AX = 1701h
Return:	AX <> 0	 success
	AX = 0	 clipboard is already open
----------2F1702-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - EMPTY CLIPBOARD
	AX = 1702h
Return: AX <> 0	 clipboard has been emptied
	AX = 0	 failure
----------2F1703-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - SET CLIPBOARD DATA
	AX = 1703h
	DX = clipboard format supported by WinOldAp:
		01h text
		02h bitmap
		03h metafile picture
		04h SYLK
		05h DIF
		06h TIFF
		07h OEM text
	ES:BX -> data (see below)
	SI:CX = size of data
Return: AX <> 0 data copied into the Clipboard
	AX = 0 failure

Format of bitmap:
Offset	Size	Description
 00h	WORD	type (0000h)
 02h	WORD	width of bitmap in pixels
 04h	WORD	height of bitmap in pixels
 06h	WORD	bytes per line
 08h	BYTE	number of color planes
 09h	BYTE	number of adjacent color bits in pixel
 0Ah	DWORD	pointer to start of data
 0Eh	WORD	width in 0.1mm units
 10h	WORD	height in 0.1mm units
 12h  N BYTEs	bitmap data

Format of metafile picture:
Offset	Size	Description
 00h	WORD	mapping mode
 02h	WORD	X extent
 04h	WORD	Y extent
 06h	WORD	picture data
----------2F1704-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - GET CLIPBOARD DATA SIZE
	AX = 1704h
	DX = clipboard format supported by WinOldAp (see AX=1703h)
Return:	 DX:AX = size of data in bytes, including any headers
Failure: DX:AX = 0  no data in this format in the Clipboard
----------2F1705-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - GET CLIPBOARD DATA
	AX = 1705h
	DX = clipboard format supported by WinOldAp (see AX=1703h)
	ES:BX -> buffer
Return: AX <> 0	 success
	AX = 0	 error, or no data in this format in Clipboard
----------2F1708-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - CloseClipboard
	AX = 1708h
Return: AX <> 0 success
	AX = 0 failure
----------2F1709-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - COMPACT CLIPBOARD
	AX = 1709h
	SI:CX = desired size in bytes
Return: DX:AX = number of bytes in largest block of free memory
Note:	WinOldAp is responsible for including the size of any headers
----------2F170A-----------------------------
INT 2F - MS WINDOWS "WINOLDAP" - GET DEVICE CAPABILITIES
	AX = 170Ah
	DX = GDI information index
	    00h device driver version
	    02h device classification
	    04h width in mm
	    06h height in mm
	    08h width in pixels
	    0Ah height in pixels
	    0Ch bits per pixel
	    0Eh number of bit planes
	    10h number of brushes supported by device
	    12h number of pens supported by device
	    14h number of markers supported by device
	    16h number of fonts supported by device
	    18h number of colors
	    1Ah size required for device descriptor
	    1Ch curve capabilities
	    1Eh line capabilities
	    20h polygon capabilities
	    22h text capabilities
	    24h clipping capabilities
	    26h bitblt capabilities
	    28h X aspect
	    2Ah Y aspect
	    2Ch length of hypotenuse of aspect
	    58h logical pixels per inch of width
	    5Ah logical pixels per inch of height
Return:	 AX = integer value of the desired item
		device classification
		    00h vector plotter
		    01h raster display
		    02h raster printer
		    03h raster camera
		    04h character-stream, PLP
		    05h Metafile, VDM
		    06h display-file
		curve capabilities
		    bit 0  circles
		    bit 1  pie wedges
		    bit 2  chord arcs
		    bit 3  ellipses
		    bit 4  wide lines
		    bit 5  styled lines
		    bit 6  wide styled lines
		    bit 7  interiors
		line capabilities
		    bit 1  polylines
		    bit 2  markers
		    bit 3  polymarkers
		    bit 4  wide lines
		    bit 5  styled lines
		    bit 6  wide styled lines
		    bit 7  interiors
		polygon capabilities
		    bit 0  polygons
		    bit 1  rectangles
		    bit 2  trapezoids
		    bit 3  scanlines
		    bit 4  wide borders
		    bit 5  styled borders
		    bit 6  wide styled borders
		    bit 7  interiors
		text capabilities
		    bit 0  output precision character
		    bit 1  output precision stroke
		    bit 2  clippping precision stroke
		    bit 3  90-degree character rotation
		    bit 4  arbitrary character rotation
		    bit 5  independent X and Y scaling
		    bit 6  double-size
		    bit 7  integer scaling
		    bit 8  continuous scaling
		    bit 9  bold
		    bit 10 italic
		    bit 11 underline
		    bit 12 strikeout
		    bit 13 raster fonts
		    bit 14 vector fonts
		    bit 15 reserved
		clipping capabilities
		    00h none
		    01h clipping to rectangles
		raster capabilities
		    bit 0  simple bitBLT
		    bit 1  device requires banding support
		    bit 2  device requires scaling support
		    bit 3  supports >64K bitmap
Note:  This function returns the device-capability bits for the given display
----------2F1900-----------------------------
INT 2F U - DOS 4.x only SHELLB.COM - INSTALLATION CHECK
	AX = 1900h
Return: AL = 00h  not installed
	     FFh  installed
----------2F1901BL00-------------------------
INT 2F U - DOS 4.x only SHELLB.COM - SHELLC.EXE INTERFACE
	AX = 1901h
	BL = 00h if SHELLC transient
	     01h if SHELLC resident
	DS:DX -> far call entry point for resident SHELLC.EXE
Return: ES:DI -> SHELLC.EXE workspace within SHELLB.COM
Note:	SHELLB.COM and SHELLC.EXE are parts of the DOS 4.x shell
----------2F1902-----------------------------
INT 2F U - DOS 4.x only SHELLB.COM - COMMAND.COM INTERFACE
	AX = 1902h
	ES:DI -> ASCIZ full filename of current batch file, with at least the
		 final filename element uppercased
	DS:DX -> buffer for results
Return: AL = 00h  failed, either
		  (a) final filename element quoted at ES:DI does not match
		      identity of shell batch file quoted as parameter of most
		      recent call of SHELLB command, or
		  (b) no more Program Start Commands available.
	AL= FFh	 success, then:
		memory at DS:[DX+1] onwards filled as:
		DX+1:	BYTE	count of bytes of PSC
		DX+2: N BYTEs	Program Start Command text
			BYTE	0Dh terminator 
Explanation: COMMAND.COM executes the result of this call in preference to 
	reading a command from a batch file. Thus the batch file does not
	advance in execution for so long as SHELLB provides PSCs from its
	workspace. The PSCs are planted in SHELLB workspace by SHELLC, the user
	menu interface. The final PSC of a sequence is finished with a 
	GOTO COMMON, which causes a loop back in the batch file which called
	SHELLC so as to execute SHELLC again. The check on batch file name
	permits PSCs to CALL nested batch files while PSCs are still stacked
	up for subsequent execution.
----------2F1903-----------------------------
INT 2F U - DOS 4.x only SHELLB.COM - COMMAND.COM interface
	AX = 1903h
	ES:DI -> ASCIZ batch file name as for AX=1902h
Return: AL = FFh if quoted batch file name matches last SHELLB parameter
	AL = 00h if it does not
----------2F1904-----------------------------
INT 2F U - DOS 4.x only SHELLB.COM - SHELLB transient to TSR intrface
	AX = 1904h
Return: ES:DI -> name of current shell batch file:
		WORD	number of bytes of name following
		BYTEs	(8 max) uppercase name of shell batch file
----------2F1A00-----------------------------
INT 2F - DOS 4+ ANSI.SYS - INSTALLATION CHECK
	AX = 1A00h
Return: AL = FFh if installed
Notes:	AVATAR.SYS also responds to this call
	documented for DOS 5+, but undocumented for DOS 4.x
----------2F1A00BX4156-----------------------
INT 2F - AVATAR.SYS - INSTALLATION CHECK
	AX = 1A00h
	BX = 4156h ('AV')
	CX = 4154h ('AT')
	DX = 4152h ('AR')
Return: AL = FFh if installed
	    CF clear
	    BX = AVATAR protocol level supported
	    CX = driver type
		0000h AVATAR.SYS
		4456h DVAVATAR.COM inside DESQview window
	    DX = 0016h
Notes:	AVATAR also identifies itself as ANSI.SYS if BX, CX, or DX differ from
	  the magic values
	AVATAR.SYS is a CON replacement by George Adam Stanislav which
	  interprets AVATAR command codes in the same way that ANSI interprets
	  ANSI command codes
----------2F1A01-----------------------------
INT 2F U - DOS 4+ ANSI.SYS internal - GET/SET DISPLAY INFORMATION
	AX = 1A01h
	CL = function
	    7Fh for GET
	    5Fh for SET
	DS:DX -> parm block as for INT 21,AX=440Ch,CX=037Fh/035Fh respectively
Return: CF set on error
	    AX = error code (many non-standard)
	CF clear if successful
	    AX destroyed
Note:	presumably this is the DOS IOCTL interface to ANSI.SYS
SeeAlso: AX=1A02h,INT 21/AX=440Ch
----------2F1A02-----------------------------
INT 2F U - DOS 4+ ANSI.SYS internal - MISCELLANEOUS REQUESTS
	AX = 1A02h
	DS:DX -> parameter block (see below)
Note:	DOS 5.0 chains to previous handler if AL > 02h on call
SeeAlso: AX=1A01h

Format of parameter block:
Offset	Size	Description
 00h	BYTE	subfunction
		00h set/reset interlock
		01h get /L flag
 01h	BYTE	interlock state
		00h=reset, 01h=set
		  This interlock prevents some of the ANSI.SYS post-processing
		  in its hook onto INT 10, AH=00h mode set
 02h	BYTE	(returned)
		00h if /L not in effect
		01h if /L in effect
----------2F1A21-----------------------------
INT 2F - AVATAR.SYS - SET DRIVER STATE
	AX = 1A21h (AL='!')
	DS:SI -> command string with one or more state characters
	CX = length of command string
Return: CF set on error (invalid subfunction)
	CF clear if successful
Note:	the characters in the state string are interpreted left to right, and
	  need not be in any particular order
SeeAlso: AX=1A3Fh

Values of state characters:
 'a'	activate driver
 'd'	disable driver
 'f'	use fast screen output
 'g'	always convert gray keys (+ and -) to function keys
 'G'	never convert gray keys
 'l'	convert gray keys only when ScrollLock active
 's'	use slow screen output
 't'	Tandy 1000 keyboard (not yet implemented)
----------2F1A3C-----------------------------
INT 2F U - AVATAR.SYS v0.11 - ???
	AX = 1A3Ch
	???
Return: CX = 0000h
----------2F1A3E-----------------------------
INT 2F U - AVATAR.SYS v0.11 - ???
	AX = 1A3Eh
	CL = ???
	CH = ???
	DL = ???
	DH = ???
Return: CL = ???
	CH = ???
	DL = ???
	DH = ???
----------2F1A3F-----------------------------
INT 2F - AVATAR.SYS - QUERY DRIVER STATE
	AX = 1A3Fh (AL='?')
	ES:DI -> buffer
	CX = length of buffer in bytes
Return: CF clear
	CX = actual size of returned info
Note:	the returned information consists of multiple letters whose meanings
	  are described under AX=1A21h
SeeAlso: AX=1A21h
----------2F1A42BX4156-----------------------
INT 2F - AVATAR Serial Dispatcher - INSTALL IRQ3 HANDLER
	AX = 1A42h
	BX = 4156h ('AV')
	ES:DI -> FAR handler for serial port using IRQ3
	DS = data segment needed by handler
Return: AX = 1A42h if ASD not installed
	   = 0000h if no more room
	   else handle to use when uninstalling
Notes:	the handler need not save/restore registers or signal EOI to the
	  interrupt controller
	the handler should return AX=0000h if the interrupt was meant for it,
	  and either leave AX unchanged or return a non-zero value otherwise
	the most recently installed handler will be called first, continuing
	  to earlier handlers until one returns AX=0000h
SeeAlso: AX=1A43h,AX=1A62h
----------2F1A43BX4156-----------------------
INT 2F - AVATAR Serial Dispatcher - INSTALL IRQ4 HANDLER
	AX = 1A43h
	BX = 4156h ('AV')
	ES:DI -> FAR handler for serial port using IRQ4
	DS = data segment needed by handler
Return: AX = 1A43h if ASD not installed
	   = 0000h if no more room
	   else handle to use when uninstalling
Notes:	(see AX=1A42h)
SeeAlso: AX=1A42h,AX=1A63h
----------2F1A44BX4156-----------------------
INT 2F - AVATAR.SYS v0.11+ - GET DATA SEGMENT
	AX = 1A44h
	BX = 4156h ('AV')
Return: AX = 0000h
	DS = data segment
	CX = size of data segment
Note:	AVATAR.SYS calls this function whenever it is invoked.	If each
	  process under a multitasker hooks this function and provides a
	  separate data segment, AVATAR.SYS becomes fully reentrant.
SeeAlso: AX=1A21h,AX=1A3Fh
----------2F1A52-----------------------------
INT 2F U - AVATAR.SYS v0.11 - GET ???
	AX = 1A52h
	CX = size of buffer
	ES:DI -> buffer
Return: ??? copied into user buffer
Note:	the maximum size of the data which may be copied is returned by
	  AX=1A72h
SeeAlso: AX=1A72h
----------2F1A53-----------------------------
INT 2F U - AVATAR.SYS v0.11 - ???
	AX = 1A53h
	CL = ??? (00h-05h)
	???
Return: ???
----------2F1A62BX4156-----------------------
INT 2F - AVATAR Serial Dispatcher - UNINSTALL IRQ3 HANDLER
	AX = 1A62h
	BX = 4156h ('AV')
	CX = handle for IRQ routine returned by AX=1A42h
SeeAlso: AX=1A42h,AX=1A63h
----------2F1A63BX4156-----------------------
INT 2F - AVATAR Serial Dispatcher - UNINSTALL IRQ4 HANDLER
	AX = 1A63h
	BX = 4156h ('AV')
	CX = handle for IRQ routine returned by AX=1A43h
SeeAlso: AX=1A43h,AX=1A62h
----------2F1A72-----------------------------
INT 2F U - AVATAR.SYS v0.11 - GET ??? SIZE
	AX = 1A72h
Return: CX = maximum size of ???
SeeAlso: AX=1A52h
----------2F1A7B-----------------------------
INT 2F U - AVATAR.SYS v0.11 - ???
	AX = 1A7Bh
Return: AX = 0000h
	CX = 0000h
----------2F1A7D-----------------------------
INT 2F U - AVATAR.SYS v0.11 - ???
	AX = 1A7Dh
Return: AX = ???
----------2F1AADDX0000-----------------------
INT 2F U - AVATAR.SYS v0.11 - ???
	AX = 1AADh
	DX = 0000h
	CX = subfunction (00h-0Ch)
	???
Return: AX = 0000h if DX was nonzero
	???
----------2F1B00-----------------------------
INT 2F U - DOS 4+ XMA2EMS.SYS extension internal - INSTALLATION CHECK
	AX = 1B00h
Return: AL = FFh if installed
Note:	XMA2EMS.SYS extension is only installed if DOS has page frames to hide.
	This extension hooks onto INT 67/AH=58h and returns from that call data
	  which excludes the physical pages being used by DOS.
SeeAlso: AH=1Bh"FRAME INFO"
----------2F1B-------------------------------
INT 2F U - DOS 4+ XMA2EMS.SYS extension internal - GET HIDDEN FRAME INFORMATION
	AH = 1Bh
	AL <> 00h
	DI = hidden physical page number
Return: AX = FFFFh if failed (no such hidden page)
	AX = 0000h if OK, then
	     ES = segment of page frame
	     DI = physical page number
Notes:	this corresponds to the data edited out of the INT 67/AH=58h call
	FASTOPEN makes this call with AL = FFh
SeeAlso: AX=1B00h
----------2F2300-----------------------------
INT 2F - DR-DOS 5.0 GRAFTABL - INSTALLATION CHECK
	AX = 2300h
Return: AH = FFh
Note:	this installation check does not follow the usual format
SeeAlso: AH=23h
----------2F23-------------------------------
INT 2F - DR-DOS 5.0 GRAFTABL - GET GRAPHICS DATA
	AH = 23h
	AL nonzero
Return: AH = FFh
	ES:BX -> graphics data
SeeAlso: AX=2300h
----------2F2700-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - INSTALLATION CHECK
	AX = 2700h
Return: AL = 00h not installed
	   = FFh installed
----------2F2701-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET STATUS
	AX = 2701h
Return: AX = maximum simultaneous tasks
	BX = index into TASK_IDS of current foreground task
	CX = currently-active tasks
	DX = version number (DR-DOS 6.0 = 0001h)
	ES:SI -> TASK_IDS
	ES:DI -> name table (array of 8-byte names, NUL-terminated if <8 chars)
Notes:	do not attempt to create a new task if CX == AX
	the task's index is its position on the task menu, while its ID is the
	  position within the internal task name table
SeeAlso: AX=2714h,AX=2716h
----------2F2702-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET PER-TASK EMS LIMIT
	AX = 2702h
Return: DX = maximum pages INT 67/AH=42h will report available
Note:	TaskMAX does not limit EMS allocations other than by limiting the
	  amount which is reported as being available at a given time
SeeAlso: AX=2703h,INT 67/AH=42h
----------2F2703-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - SET PER-TASK EMS LIMIT
	AX = 2703h
	DX = maximum pages INT 67/AH=42h should report available
Return: DX = new maximum for reporting
SeeAlso: AX=2702h,INT 67/AH=42h
----------2F2704-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - REGISTER/UNREGISTER TASK MANAGER
	AX = 2704h
	DL = subfunction
	    00h unregister task manager
	    01h register task manager
Return: DL = status
	    00h registered
	    01h unregistered
Notes:	a task manager replaces TaskMAX's menu system with its own user
	  interface; while one is registered, the TaskMAX hotkeys and
	  Ctrl-Alt-Del invoke the manager rather than the built-in menu system
	unregister the task manager before terminating it
SeeAlso: AX=2705h
----------2F2705-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - ENABLE/DISABLE DIRECT SWITCHING
	AX = 2705h
	DL = subfunction
	    00h disable keystrokes for switching to next/prev/specified task
	    01h enable
Return: nothing
Note:	should only be called by a registered task manager (see AX=2704h)
SeeAlso: AX=2704h,AX=2706h
----------2F2706-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - SWITCH TO SPECIFIED TASK
	AX = 2706h
	DX = task index (see AX=2701h) of task to be activated
Return: DX = task index of previously-active task
SeeAlso: AX=2705h,AX=2707h,AX=2715h
----------2F2707-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - CREATE NEW TASK
	AX = 2707h
	DS:DX -> ASCIZ pathname of executable
	ES:BX -> parameter block (see below)
	CX = number of ticks before automatic return to task manager
		(0000h = run until termination or explicitly switched)
Return: DX = new task's task index (FFFFh if task terminated)
SeeAlso: AX=2706h,AX=2708h

Format of parameter block:
Offset	Size	Description
 00h	WORD	reserved, should be 0000h
 02h	DWORD	pointer to command tail to be copied into child's PSP
 06h	DWORD	pointer to first FCB to be copied into child's PSP
 0Ah	DWORD	pointer to second FCB to be copied into child's PSP
----------2F2708-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - DELETE TASK
	AX = 2708h
	DX = task index
Return: DX = FFFFh (task deleted)
Notes:	this call should only be used for abnormal task termination, after
	  first checking for open files with AX=270Ch; should not be used
	  with programs that allocate EMS or XMS memory
	switches to specified task first
SeeAlso: AX=2707h
----------2F2709-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - NAME TASK
	AX = 2709h
	DX = task index
	DS:SI -> 8-byte name (8 NULs = remove name)
Return: AL = task flags
	    00h ID unused or task terminated
	    01h ID in use, task name table entry valid
	    81h ID in use, task name fixed
	BX = task ID
	ES:DI -> name in task name table (see AX=2701h)
Note:	the task retains the given name until it terminates or the name is
	  removed by specifying a name of 8 NULs.
SeeAlso: AX=2701h,AX=2707h
----------2F270A-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - CONVERT TASK INDEX TO TASK ID
	AX = 270Ah
	DX = task index
Return: DX = task ID (FFFFh if index invalid)
Note:	task IDs stay constant, while indexes can change when other tasks are
	  deleted
SeeAlso: AX=2701h,AX=270Bh
----------2F270B-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - CONVERT TASK ID TO TASK INDEX
	AX = 270Bh
	DX = task ID
Return: DX = task index (FFFFh if task not active)
SeeAlso: AX=270Ah
----------2F270C-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - CHECK OPEN FILES
	AX = 270Ch
	DX = task index
Return: AX = number of files currently open for specified task
SeeAlso: AX=2708h
----------2F270D-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - CHECK IF TASK RUNNING PRIMARY COMMAND INTERPRETER
	AX = 270Dh
	DX = task index
Return: DX = status
	    0000h if primary command interpreter (COMMAND.COM, etc.) running
	    0001h if not in root shell for task
Note:	TaskMAX will return 0001h if the specified task has spawned another
	  command interpreter with AX=2707h
SeeAlso: AX=2707h,AX=270Ch
----------2F270E-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET/SET TEXT PASTE LEAD-IN
	AX = 270Eh
	CX = length of string (max 15 keystrokes, 0000h to get current string)
	DS:SI -> pasting lead-in string (character/scan-code pairs)
Return: ES:DI -> current lead-in string
Note:	the specified sequence of keystrokes is sent to the application before
	  every line of a text-mode spreadsheet paste
SeeAlso: AX=270Fh,AX=2710h,AX=2713h
----------2F270F-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET/SET NUMERIC PASTE LEAD-IN
	AX = 270Fh
	CX = length of string (max 15 keystrokes, 0000h to get current string)
	DS:SI -> pasting lead-in string (character/scan-code pairs)
Return: ES:DI -> current lead-in string
Note:	the specified sequence of keystrokes is sent to the application before
	  every number in a numeric-mode spreadsheet paste
SeeAlso: AX=270Eh,AX=2710h,AX=2711h,AX=2713h
----------2F2710-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET/SET PASTE LINE TERMINATOR STRING
	AX = 2710h
	CX = length of string (max 15 keystrokes, 0000h to get current string)
	DS:SI -> pasting lead-in string (character/scan-code pairs)
Return: ES:DI -> current lead-in string
Note:	the specified sequence of keystrokes is sent to the application after
	  every line of a spreadsheet paste operation
SeeAlso: AX=270Eh,AX=270Fh,AX=2713h
----------2F2711-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET/SET NUMERIC PASTE DECIMAL POINT
	AX = 2711h
	DX = ASCII code for separator (FFFFh to get current)
Return: DL = current separator character
SeeAlso: AX=270Fh
----------2F2712-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - INITIATE EXPORTING TASK DATA
	AX = 2712h
	DX = task index
----------2F2713-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - INITIATE PASTE OPERATION
	AX = 2713h
	DX = task index
	CX = past mode
	    0000h alphanumeric
	    0001h numeric
	    0002h text
SeeAlso: AX=270Eh,AX=270Fh,AX=2710h,AX=2711h
----------2F2714-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET SWAP SPACE INFO
	AX = 2714h
Return: CX = total KB of swap space
	DX = available KB of swap space
SeeAlso: AX=2701h
----------2F2715-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - SWITCH TO TASK MANAGER
	AX = 2715h
Return: only after calling task is again selected
SeeAlso: AX=2706h
----------2F2716-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - GET PASTE BUFFER STATUS
	AX = 2716h
Return: AX = 0000h if AX=2716h,AX=2717h,AX=2718h supported
	    CX = bytes in paste buffer
	    DX = current generation number (updated after every copy operation)
SeeAlso: AX=2701h,AX=2713h,AX=2714h,AX=2717h,AX=2718h
----------2F2717-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - PASTE DATA DIRECTLY TO APPLICATION BUFFER
	AX = 2717h
	CX = bytes in destination buffer
	ES:DI -> destination buffer
Return: AX = 0000h if function supported
	    CX = bytes actually copied (FFFFh if buffer too small)
	    DX = current generation number for paste buffer
Note:	the destination buffer may be too small if another task adds more data
	  to the paste buffer after the AX=2716h call but before this call
SeeAlso: AX=2713h,AX=2716h,AX=2718h
----------2F2718-----------------------------
INT 2F - DR-DOS 6.0 TaskMAX - COPY DATA DIRECTLY INTO PASTE BUFFER
	AX = 2718h
	CX = bytes in source buffer
	DS:SI -> source buffer (plain ASCII, lines terminated with CR LF)
Return: AX = 0000h if function supported
	    CX = bytes actually copied
	    DX = current generation number for paste buffer
SeeAlso: AX=2712h,AX=2716h,AX=2717h
----------2F2A-------------------------------
INT 2F - Gammafax DOS Dispatcher INTERFACE
	AH = 2Ah
Note:	details not available at this time
SeeAlso: AX=8000h"FaxBIOS",AX=C000h"MTEZ",AX=CB00h,AX=CBDDh,INT 66"BitFax"
----------2F3900-----------------------------
INT 2F - Kingswood TSR INTERFACE - COMPATIBILITY MODE
	AX = 3900h
Return: AL = status
	    00h not installed
	    FFh one or more TSRs using this interface is installed
Note:	this function is provided to that the multiplex number will appear used
	  to other programs
SeeAlso: AH=39h/BL=00h
----------2F39--BL00-------------------------
INT 2F - Kingswood TSR INTERFACE - INSTALLATION CHECK
	AH = 39h
	BL = 00h
	AL = TSR ID number (01h-FFh, currently only 01h-0Eh used) (see below)
Return: AL = status
	    00h not installed
	    FFh installed
		DX = segment address of resident module
Note:	All of Kingswood Software's TSRs use this interface.  Usually the
	  resident module is installed by allocating a block of upper memory,
	  setting its owner ID to 0008h (DOS data), and filling the MCB name
	  field with the TSR's name.
SeeAlso: AX=3900h,AH=39h/BL=01h

Values for TSR ID number:
 01h TSR Windows
 02h NOBUSY
 03h CD STACK
 04h DISK WATCH
 05h PUSHBP
 06h ALIAS
 07h KEYMACRO
 08h SLOWDOWN
 09h ANSIGRAB
 0Ah TEE
 0Bh FASTMOUS
 0Ch EXTWILD
 0Dh BREAKOUT
 0Eh STOPDISK

Format of TSR modules:
Offset	Size	Description
 00h  4 BYTEs	signature "FTSR"
 04h	WORD	segment address of this module
 06h	WORD	number of words to skip (usually 0000h if no PSP present)
 08h  N WORDs	module-defined data that must be at a fixed segment offset
		(usually only a PSP if file access is required)
     5N BYTEs	interrupt list (see below)
	BYTE	FFh terminator

Format of interrupt list entry:
Offset	Size	Description
 00h	BYTE	interrupt number (00h-FEh)
 01h	WORD	offset within segment of DWORD pointer to previous interrupt
 03h	WORD	offset within segment of begin of interrupt handler code
----------2F39--BL01-------------------------
INT 2F - Kingswood TSR INTERFACE - REMOVAL CHECK
	AH = 39h
	BL = 01h
	AL = TSR ID number (01h-FFh) (see AH=39h/BL=00h)
Return: AL = status
	    00h not ready to be removed
	    FFh resident module may be removed by deassigning the interrupts
		hooked by the TSR and deallocating the TSR's memory block
	AH,BX,CX,DX,ES may be destroyed
SeeAlso: AX=3900h,AH=39h/BL=00h
----------2F39-------------------------------
INT 2F - Kingswood TSR INTERFACE - APPLICATION-SPECIFIC FUNCTION CALLS
	AH = 39h
	BL = function number (02h-FFh)
	AL = TSR ID number (01h-FFh)
	CX,DX,SI,DI,DS,ES may contain parameters
Return: as appropriate for the called function
SeeAlso: AX=3900h,AH=39h/BL=00h,AX=3901h/BL=02h
----------2F3901BL02-------------------------
INT 2F - Kingswood TSR Windows - OPEN WINDOW
	AX = 3901h
	BL = 02h
Return: AX = error code (0000h if successful)
Notes:	opens the next TSR window on top of any others.	 Only three
	  TSR windows can be opened at any one time.  The three windows
	  are all 40x11 characters, partly overlapping.
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=03h,AX=3901h/BL=05h,AX=3901h/BL=06h
----------2F3901BL03-------------------------
INT 2F - Kingswood TSR Windows - HIDE WINDOWS
	AX = 3901h
	BL = 03h
Return: AX = error code (0000h if successful)
Notes:	Hide any visible TSR windows from view.
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=02h,AX=3901h/BL=05h
----------2F3901BL04-------------------------
INT 2F - Kingswood TSR Windows - SHOW WINDOWS
	AX = 3901h
	BL = 04h
Return: AX = error code (0000h if successful)
Notes:	Re-display all TSR windows after a HIDE WINDOWS call.
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=02h,AX=3901h/BL=03h
----------2F3901BL05-------------------------
INT 2F - Kingswood TSR Windows - CLOSE WINDOW
	AX = 3901h
	BL = 05h
Return: AX = error code (0000h if successful)
Notes:	Close the last opened TSR window.
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=02h
----------2F3901BL06-------------------------
INT 2F - Kingswood TSR Windows - SET WINDOW TITLE
	AX = 3901h
	BL = 06h
	DS:SI -> title string
Return: AX = error code (0000h if successful)
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=02h
----------2F3901BL07-------------------------
INT 2F - Kingswood TSR Windows - POSITION CURSOR
	AX = 3901h
	BL = 07h
	CH = Y coordinate (0-10)
	CL = X coordinate (0-39)
Return: AX = error code (0000h if successful)
Note:	the hardware cursor is always disabled when a TSR window is opened;
	  this call only sets a text position
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=08h,AX=3901h/BL=09h
----------2F3901BL08-------------------------
INT 2F - Kingswood TSR Windows - DISPLAY STRING
	AX = 3901h
	BL = 08h
	DS:SI -> string
Return: AX = error code (0000h if successful)
Notes:	The text is not clipped.
	This routine understands Tab, NewLine and Carriage Return
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=07h
----------2F3901BL09-------------------------
INT 2F - Kingswood TSR Windows - SCROLL WINDOW
	AX = 3901h
	BL = 09h
	CL = scroll direction: 00h up, FFh down, 00h clear window
Return: AX = error code (0000h if successful)
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=07h
----------2F3901BL0A-------------------------
INT 2F - Kingswood TSR Windows - SOUND BEEPER
	AX = 3901h
	BL = 0Ah
	DX = sound divisor, or 0 for silence.
	     (divide 1843200 by required frequency to get value for DX)
	CL = sound length in 18.2 Hz clock ticks
Return: AX = error code (0000h if successful)
SeeAlso: AH=39h/BL=00h
----------2F3901BL0B-------------------------
INT 2F - Kingswood TSR Windows - ADD OR REMOVE USER
	AX = 3901h
	BL = 0Bh
	CL = number of users increment: +1 if adding a new user
					-1 if removing a user
Return: AX = error code (0000h if successful)
Note:	the TSR windows resident module may only be removed when the internal
	  user count is zero
SeeAlso: AH=39h/BL=00h,AX=3901h/BL=02h
----------2F4000-----------------------------
INT 2F - Windows 3.x (OS/2 2.x???) - GET VIRTUAL DEVICE DRIVER (VDD) CAPABLTIES
	AX = 4000h
Return: AL = 01h does not virtualize video access
	     02h virtualizes the video when in text mode
	     03h virtualizes the video when in text mode or single plane
		 graphics modes
	     04h virtualizes the video when in text mode, single plane
		 graphics modes, and VGA multiplane modes
	     FFh virtualizes the video fully
Note:	this function is used by display drivers to find out what capabilities
	  exist for the VDD driver and also trigger then VDD driver to call
	  functions 4005h and 4006h.  This function also gives the Video Driver
	  hardware access to the video registers.
----------2F4001-----------------------------
INT 2F - OS/2 compatibility box - SWITCHING DOS TO BACKGROUND
	AX = 4001h
Note:	called by OS/2 when the DOS box is about to be placed in the background
	  and the video driver should save any necessary state
SeeAlso: AX=4002h,AX=4005h
----------2F4002-----------------------------
INT 2F - OS/2 compatibility box - SWITCHING DOS TO FOREGROUND
	AX = 4002h
Note:	called by OS/2 when the DOS box is about to be placed in the foreground
	  and the video driver should restore the previously-saved state
SeeAlso: AX=4001h,AX=4006h
----------2F4003-----------------------------
INT 2F - Windows 3.x - ENTERING VIDEO DRIVER CRITICAL SECTION
	AX = 4003h
Note:	This critical section must be exited within 1 second.
SeeAlso: AX=4004h
----------2F4004-----------------------------
INT 2F - Windows 3.x - EXITING VIDEO DRIVER CRITICAL SECTION
	AX = 4004h
SeeAlso: AX=4003h
----------2F4005-----------------------------
INT 2F - Windows 3.x - SWITCHING DOS TO BACKGROUND
	AX = 4005h
Note:	called by Windows when the DOS box is about to be placed in the
	  background and the video driver should save any necessary state
	  information
SeeAlso: AX=4001h,AX=4006h
----------2F4006-----------------------------
INT 2F - Windows 3.x - SWITCHING DOS TO FOREGROUND
	AX = 4006h
Note:	called by Windows when the DOS box is about to be placed in the
	  foreground and the video driver should restore any necessary state
	  information
SeeAlso: AX=4002h,AX=4005h
----------2F4007-----------------------------
INT 2F - Windows 3.x - ENABLE VDD TRAPPING OF VIDEO REGISTERS
	AX = 4007h
----------2F4040-----------------------------
INT 2F - PharLap 286|DOS-Extender Lite v2.5 - ???
	AX = 4040h
Return: BX:CX -> ???
----------2F41-------------------------------
INT 2F - LAN Manager 2.0 DOS Enhanced NETPOPUP.EXE - NETWORK POP-UP SERVICE
	AH = 41h
	???
Return: ???
Note:	LAN Manager enhanced mode adds features beyond the standard redirector
	  file/printer services
SeeAlso: AX=118Ah,AH=42h,AH=4Bh
----------2F42-------------------------------
INT 2F - LAN Manager 2.0 DOS Enhanced MSRV.EXE - MESSENGER SERVICE
	AH = 42h
	???
Return: ???
Note:	LAN Manager enhanced mode adds features beyond the standard redirector
	  file/printer services
SeeAlso: AX=118Ah,AH=41h,AH=4Bh
----------2F4300-----------------------------
INT 2F - EXTENDED MEMORY SPECIFICATION (XMS) - INSTALLATION CHECK
	AX = 4300h
Return: AL = 80h XMS driver installed
	AL <> 80h no driver
Notes:	XMS gives access to extended memory and noncontiguous/nonEMS memory
	  above 640K
	this installation check DOES NOT follow the format used by other
	  software
SeeAlso: AX=4310h
----------2F4310-----------------------------
INT 2F - EXTENDED MEMORY SPECIFICATION (XMS) - GET DRIVER ADDRESS
	AX = 4310h
Return: ES:BX -> driver entry point
Note:	HIMEM.SYS v2.77 chains to previous handler if AH is not 00h or 10h
SeeAlso: AX=4300h

Perform a FAR call to the driver entry point with AH set to the function code
	AH	function
	00h  Get XMS version number
	     Return: AX = XMS version (in BCD, AH=major, AL=minor)
		     BX = internal revision number
		     DX = 0001h if HMA (1M to 1M + 64K) exists
			  0000h if HMA does not exist
	01h  Request High Memory Area (1M to 1M + 64K)
	     DX = memory in bytes (for TSR or device drivers)
		  FFFFh if application program
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,90h,91h,92h) (see below)
	02h  Release High Memory Area
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,90h,93h) (see below)
	03h  Global enable A20, for using the HMA
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,82h) (see below)
	04h  Global disable A20
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,82h,94h) (see below)
	05h  Local enable A20, for direct access to extended memory
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,82h) (see below)
	06h  Local disable A20
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,82h,94h) (see below)
	07h  Query A20 state
	     Return: AX = 0001h enabled
			= 0000h disabled
		     BL = error code (00h,80h,81h) (see below)
	08h  Query free extended memory, not counting HMA
	     BL = 00h (some implementations leave BL unchanged on success)
	     Return: AX = size of largest extended memory block in K
		     DX = total extended memory in K
		     BL = error code (00h,80h,81h,A0h) (see below)
	09h  Allocate extended memory block
	     DX = Kbytes needed
	     Return: AX = 0001h success
			   DX = handle for memory block
			= 0000h failure
			   BL = error code (80h,81h,A0h) (see below)
	0Ah  Free extended memory block
	     DX = handle of block to free
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,A2h,ABh) (see below)
	0Bh  Move extended memory block
	     DS:SI -> EMM structure (see below)
	     Note: if either handle is 0000h, the corresponding offset is
		   considered to be an absolute segment:offset address in
		   directly addressable memory
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h-82h,A3h-A9h) (see below)
	0Ch  Lock extended memory block
	     DX = handle of block to lock
	     Return: AX = 0001h success
			   DX:BX = 32-bit linear address of locked block
			= 0000h failure
			   BL = error code (80h,81h,A2h,ACh,ADh) (see below)
	0Dh  Unlock extended memory block
	     DX = handle of block to unlock
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,A2h,AAh) (see below)
	0Eh  Get handle information
	     DX = handle for which to get info
	     Return: AX = 0001h success
			   BH = block's lock count
			   BL = number of free handles left
			   DX = block size in K
			= 0000h failure
			   BL = error code (80h,81h,A2h) (see below)
	0Fh  Reallocate extended memory block
	     DX = handle of block
	     BX = new size of block in K
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,81h,A0h-A2h,ABh) (see below)
	10h  Request upper memory block (nonEMS memory above 640K)
	     DX = size of block in paragraphs
	     Return: AX = 0001h success
			   BX = segment address of UMB
			   DX = actual size of block
			= 0000h failure
			   BL = error code (80h,B0h,B1h) (see below)
			   DX = largest available block
	11h  Release upper memory block
	     DX = segment address of UMB to release
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,B2h) (see below)
	12h  (XMS v3.0) Reallocate upper memory block
	     DX = segment address of UMB to resize
	     BX = new size of block in paragraphs
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (80h,B0h,B2h) (see below)
	34h  (QEMM 5.11 only, undocumented) ???
	44h  (QEMM 5.11 only, undocumented) ???
	88h  (XMS v3.0) Query free extended memory
	     Return: EAX = largest block of extended memory, in K
		     BL = status
			 00h success
			 80h not implemented (i.e. on a 286 system)
			 81h VDISK detected
			 A0h all extended memory allocated
	     	     ECX = physical address of highest byte of memory
		     		(valid even on error codes 81h and A0h)
		     EDX = total Kbytes of extended memory (0 if status A0h)
	89h  (XMS v3.0) Allocate any extended memory
	     EDX = Kbytes needed
	     Return: AX = 0001h success
	     		    DX = handle for allocated block (free with AH=0Ah)
			= 0000h failure
			    BL = status (80h,81h,A0h,A1h,A2h) (see below)
	8Eh  (XMS v3.0) Get extended EMB handle information
	     DX = handle
	     Return: AX = 0001h success
	     		    BH = block's lock count
			    CX = number of free handles left
			    EDX = block size in K
	     		= 0000h failure
	     		    BL = status (80h,81h,A2h) (see below)
	8Fh  (XMS v3.0) Reallocate any extended memory block
	     DX = unlocked handle
	     EBX = new size in K
	     Return: AX = 0001h success
	     		= 0000h failure
			    BL = status (80h,81h,A0h-A2h,ABh) (see below)
Notes:	HIMEM.SYS requires at least 256 bytes free stack space
	the XMS driver need not implement functions 10h through 12h to be
	  considered compliant with the standard

Format of EMM structure:
Offset	Size	Description
 00h	DWORD	number of bytes to move (must be even)
 04h	WORD	source handle
 06h	DWORD	offset into source block
 0Ah	WORD	destination handle
 0Ch	DWORD	offset into destination block
Notes:	if source and destination overlap, only forward moves (source base
	  less than destination base) are guaranteed to work properly
	if either handle is zero, the corresponding offset is interpreted
	  as a real-mode address referring to memory directly addressable
	  by the processor

Error codes returned in BL:
	00h successful
	80h function not implemented
	81h Vdisk was detected
	82h an A20 error occurred
	8Eh a general driver error
	8Fh unrecoverable driver error
	90h HMA does not exist
	91h HMA is already in use
	92h DX is less than the /HMAMIN= parameter
	93h HMA is not allocated
	94h A20 line still enabled
	A0h all extended memory is allocated
	A1h all available extended memory handles are allocated
	A2h invalid handle
	A3h source handle is invalid
	A4h source offset is invalid
	A5h destination handle is invalid
	A6h destination offset is invalid
	A7h length is invalid
	A8h move has an invalid overlap
	A9h parity error occurred
	AAh block is not locked
	ABh block is locked
	ACh block lock count overflowed
	ADh lock failed
	B0h only a smaller UMB is available
	B1h no UMB's are available
	B2h UMB segment number is invalid
----------2F44-------------------------------
INT 2F U - ???
	AH = 44h
	AL = function (at least 0Bh, 15h, 17h)
	???
Return: ???
Note:	called by Codeview for Windows
SeeAlso: AH=86h
----------2F4500-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - INSTALLATION CHECK
	AX = 4500h
Return: AL = 01h if PROF.COM installed
	AL = 02h if VPROD.386 installed
SeeAlso: AX=4501h,AX=4502h
----------2F4501-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - SETUP PROFILER
	AX = 4501h
	BX = CSIPS buffer size in KB (first parameter for ProfSetup)
	CX = output limit in KB (second parameter for ProfSetup)
Note:	this call is not supported by PROF.COM
SeeAlso: AX=4502h,AX=4503h
----------2F4502-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - SET SAMPLING RATE
	AX = 4502h
	BL = sampling rate for PROF.COM (0 < BL <= 13)
	    (01h = 8192/s, 04h = 1024/s, 08h = 32/s, 0Dh = 1/s)
	CX = sampling rate for VPROD.386
Note:	for PROF.COM, this programs the CMOS clock by setting BL+2 as the
	  low four bits of CMOS register 0Ah.  The interruption rate is
	  1 SHL (15 - BL) per second.
SeeAlso: AX=4501h,AX=4503h
----------2F4503-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - START PROFILING
	AX = 4503h
Notes:	Profiling is also turned on by the key combinations
	  LeftShift + RightShift + Alt
	  LeftShift + RightShift + Ctrl
	for PROF.COM, this call programs the CMOS clock by reading register
	  0Ch, and setting bit 6 of register 0Bh.  It then makes sure that IRQ8
	  is unmasked
SeeAlso: AX=4504h
----------2F4504-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - STOP PROFILING
	AX = 4504h
Notes:	profiling is also turned off by the key combination
	  LeftShift + RightShift
	for PROF.COM, this programs the CMOS clock by reading register 0Ch
	  and clearing bit 6 of register 0Bh.  It then masks IRQ8.
SeeAlso: AX=4503h,AX=4505h,AX=4506h,AX=4507h
----------2F4505-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - CLEAR PROFILING DATA
	AX = 4505h
SeeAlso: AX=4503h,AX=4504h,AX=4506h
----------2F4506-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - "ProfFlush"
	AX = 4506h
SeeAlso: AX=4505h,AX=4507h
----------2F4507-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - "ProfFinish"
	AX = 4507h
Note:	this call is essentially a "ProfStop" (AX=4504h) followed by
	  "ProfFlush" (AX=4506h)
SeeAlso: AX=4504h,AX=4505h,AX=4506h
----------2F4508-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - ALTERNATE SEGDEBUG IFACE
	AX = 4508h
	BX = ordinal (or 0000h)
	CX = segment
	DX = instance (or 0000h)
	SI = type (or 0000h)
	ES:DI -> ASCIZ module name
Notes:	this call is an alternate entry to the profiler's SEGDEBUG
	  interface, but only to function 0, for notifying the profiler of
	  each new segment loaded.  The SHOWHITS utility then examines the
	  profiler's output files (CSIPS.DAT and SEGENTRY.DAT) in conjunction
	  with symbol files to provide information in a useful form.
	this call does not have a corresponding Windows function
SeeAlso: AX=4500h 
----------2F4601-----------------------------
INT 2F U - DOS 5.0 kernel - ???
	AX = 4601h
Return: ???
Note:	copies the MCB following the caller's PSP memory block into DOS data
	  segment
SeeAlso: AX=4602h
----------2F4602-----------------------------
INT 2F U - DOS 5.0 kernel - ???
	AX = 4602h
Return: ???
Note:	copies previously copied MCB from DOS data segment into MCB following
	  caller's PSP memory block
SeeAlso: AX=4601h
----------2F46-------------------------------
INT 2F U - ???
	AH = 46h
	AL = subfunction (03h,04h)
Return: ???
Note:	these two subfunctions are called by MS Windows 3.0
----------2F4653CX0002-----------------------
INT 2F - F-PROT v1.x only - F-LOCK.EXE 
	AX = 4653h
	CX = 0002h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
		Return: AX,BX,ES destroyed
	    0002h  disable (v1.08 and below only)
	    0003h  enable (v1.08 and below only)
Note:	F-LOCK is part of the F-PROT virus/trojan protection package by Fridrik
	  Skulason
SeeAlso: AX=4653h/CX=0003h,AX=CA00h,INT 21/AX=4BEEh
----------2F4653CX0003-----------------------
INT 2F - F-PROT v1.x only - F-XCHK.EXE
	AX = 4653h
	CX = 0003h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
		Return: AX,BX,ES destroyed
Note:	F-XCHK is part of the F-PROT virus/trojan protection package by Fridrik
	  Skulason
SeeAlso: AX=4653h/CX=0002h,AX=4653h/CX=0004h,AX=CA00h
----------2F4653CX0004-----------------------
INT 2F - F-PROT v1.x only - F-POPUP.EXE
	AX = 4653h
	CX = 0004h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
		Return: AX,BX,ES destroyed
	    0002h  disable (v1.08 and below only)
		   display message (v1.14+)
			other registers: ???
	    0003h  enable (v1.08 and below only)
		   display message (v1.14+)
			other registers: ???
			Return: AX = key pressed by user
Note:	F-POPUP is part of the F-PROT virus/trojan protection package by
	  Fridrik Skulason
SeeAlso: AX=4653h/CX=0003h,AX=4653h/CX=0005h,AX=CA00h
----------2F4653CX0005-----------------------
INT 2F - F-PROT v1.x only - F-DLOCK.EXE
	AX = 4653h
	CX = 0005h
	BX = subfunction
	    0000h installation check
		Return: AX = FFFFh
	    0001h uninstall
		Return: AX,BX,ES destroyed
Note:	F-DLOCK is part of the F-PROT virus/trojan protection package by
	  Fridrik Skulason
SeeAlso: AX=4653h/CX=0004h,AX=CA00h
----------2F4680-----------------------------
INT 2F - MS Windows v3.0 - INSTALLATION CHECK
	AX = 4680h
Return: AX = 0000h MS Windows 3.0 running in real (/R) or standard (/S) mode,
		   or DOS 5 DOSSHELL active
	   nonzero  no Windows, Windows prior to 3.0, or Windows3 in enhanced
		    mode
Note:	not officially documented, but Microsoft has indicated that they
	  intend to provide an installation check which works in all modes
SeeAlso: AX=1600h
----------2F4800-----------------------------
INT 2F - DOS v5.0 DOSKEY - INSTALLATION CHECK
	AX = 4800h
Return: AL = nonzero if installed
SeeAlso: AX=4810h
----------2F4810-----------------------------
INT 2F - DOS v5.0 DOSKEY - READ INPUT LINE FROM CONSOLE
	AX = 4810h
	DS:DX -> line buffer (see INT 21/AH=0Ah)
Return: AX = 0000h if successful
Notes:	the first byte (length) of the buffer MUST be 80h, or DOSKEY chains to
	  the previous handler
	if the user's input is a macro name, no text is placed in the buffer
	  even though AX=0000h on return; the program must immediately issue
	  this call again to retrieve the expansion of the macro.  Similarly,
	  if the user enters a special parameter such as $*, this call must
	  be repeated to retrieve the expansion; on the second call, DOSKEY
	  overwrites the macro name on the screen with its expansion.
SeeAlso: AX=4800h,INT 21/AH=0Ah
----------2F4A00CX0000-----------------------
INT 2F U - DOS v5.0 - SINGLE-FLOPPY LOGICAL DRIVE CHANGE NOTIFICATION
	AX = 4A00h
	CX = 0000h
	DH = new drive number
	DL = current drive number
Return: CX = FFFFh to skip "Insert diskette for drive X:" message
Note:	called by MSDOS 5.00 IO.SYS just before displaying the message
	  "Insert diskette for drive X:" on single-floppy systems
----------2F4A01-----------------------------
INT 2F - DOS 5.0 - QUERY FREE HMA SPACE
	AX = 4A01h
Return: BX = number of bytes available in HMA (0000h if DOS not using HMA)
	ES:DI -> start of available HMA area (FFFFh:FFFFh if not using HMA)
Note:	called by Windows 3.1 DOSX.EXE
SeeAlso: AX=4310h,AX=4A02h
----------2F4A02-----------------------------
INT 2F - DOS 5.0 - ALLOCATE HMA SPACE
	AX = 4A02h
	BX = number of bytes
Return: ES:DI -> start of allocated HMA block or FFFFh:FFFFh
	BX destroyed
Notes:	this call is not valid unless DOS is loaded in the HMA (DOS=HIGH)
	called by Windows 3.1 DOSX.EXE
SeeAlso: AX=4A01h
----------2F4A05-----------------------------
INT 2F U - DOS 5.0 DOSSHELL - TASK SWITCHING API???
	AX = 4A05h
	SI = function
	    0000h reset???
	    0001h ???
	    0002h ???
	    0003h ???
	    0004h ???
		BL = ???
	    0005h ???
	    0006h get ???
		Return: ES:DI -> ???
	    0007h get ???
		Return: AX = ???
	    0008h get ???
		Return: DX:AX -> ???
	    0009h get ???
		Return: ES = ???
	    000Ah ???
		BL = ???
		ES:DI -> ???
	    000Bh get ???
		Return: AX = ???
	    000Ch ???
		BL = ???
		Return: DX:AX -> ???
Notes:	DOSSHELL chains to the previous handler if SI is not one of the values
	  listed above
	the DOSSWAP.EXE module calls functions 03h,04h,05h,07h,08h,09h,0Ch
	the Windows 3.1 DSWAP.EXE and WSWAP.EXE task switchers use these calls
SeeAlso: AX=4B01h
----------2F4A06-----------------------------
INT 2F U - ??? - GET MEMORY SIZE
	AX = 4A06h
	DX = segment following last byte of conventional memory
Return: DX = segment following last byte of memory available for use by DOS
Note:	called by MSDOS 5.00 IO.SYS startup code if the signature "RPL" is
	  present three bytes beyond the INT 2F handler; this call overrides
	  the value returned by INT 12
SeeAlso: INT 12
----------2F4A10-----------------------------
INT 2F - SMARTDRV v4.00+ - API
	AX = 4A10h
	BX = command
	    0000h installation check and hit ratios
		Return: AX = BABEh if installed
			    DX:BX = cache hits
			    DI:SI = cache misses
			    CX = ???
			    BP = version (4.00 = 0400h)
	    0001h reset cache
	    0002h flush buffers
	    0003h status
		BP = drive # (0=A, 1=B, etc.)
		DL = subfunction
		    00h only get information
		    01h turn on read cache
		    02h turn off read cache
		    03h turn on write cache
		    04h turn off write cache
	    	Return: AX = BABEh if OK
		       	DL = status
			    bit 7  not cached
			    bit 6  write-through
			    bit 5  ???
			    bits 0-4 drive # (0=A, 1=B...)
			DL = FFh if drive does not exist
		Note:	If the read cache is off, reads will not be cached,
			  but writes will continue to be cached if the write-
			  cache is enabled.
	    0004h cache size
		Return: AX = ???
			BX = largest number of elements
			CX = size of elements in bytes
			DX = number of elements under Windows
	    0005h double-buffer status
		BP = drive # (0=A, 1=B...)
		Return: AX = BABEh if double-buffered
	    0007h ???
		Return: DI = random number???
	    000Ah get table pointer???
		Return: ES:BX -> table of about 10 bytes or 5 words. Seems to
				be words pointing to memory addresses 
				containing info??? (see below)
	    1234h signal serious error
		pops up a message box saying that a serious error occurred and
		  to hit R to retry.
SeeAlso: INT 21/AX=4402h"SMARTDRV",INT 21/AX=4403h"SMARTDRV"

Format of data table:
Offset	Size	Description
 00h  8 BYTEs	???
 08h	WORD	offset of WORD containing number of elements in cache
----------2F4B-------------------------------
INT 2F - LAN Manager 2.0 DOS Enh NETWKSTA.EXE - NETWORK WORKSTATION REDIRECTOR
	AH = 4Bh
	???
Return: ???
Note:	LAN Manager enhanced mode adds features beyond the standard redirector
	  file/printer services
SeeAlso: AX=118Ah,AH=41h,AH=42h
----------2F4B01-----------------------------
INT 2F - DOS v5.0 TASK SWITCHER - BUILD CALLOUT CHAIN
	AX = 4B01h
	CX:DX -> task switcher entry point (see AX=4B02h)
	ES:BX = 0000h:0000h
Return: ES:BX -> callback info structure (see below) or 0000h:0000h
Notes:	called by the task switcher
	this function is hooked by clients which require notification of task
	  switcher activities; the call must first be passed on to the prior
	  handler with registers unchanged using a simulated interrupt.	 On
	  return, the client must build a callback info structure and store
	  the returned ES:BX in the "next" field, then return the address of
	  its own callback info structure.
	a client program must add itself to the notification chain if it
	  provides services to other programs; before terminating, it must
	  remove itself from the chain by calling the task switcher's entry
	  point with AX=0005h (see AX=4B02h)
	the task switcher entry point should not be saved, as it is subject to
	  change and will be provided on any notification call
	the Windows 3.1 Standard Mode supports this API
SeeAlso: AX=4B02h

Format of callback info structure:
Offset	Size	Description
 00h	DWORD	pointer to next callback info structure
 04h	DWORD	pointer to notification function (see below)
 08h	DWORD	reserved
 0Ch	DWORD	address of zero-terminated list of API info structures
		(see AX=4B02h)

Notification function is called with:
	AX = function
	    0000h switcher initialization
		Return: AX = 0000h if OK to load
			   = nonzero to abort task switcher
	    0001h query suspend
		BX = session ID
		Return: AX = 0000h if OK to switch session
			   = 0001h if not
	    0002h suspend session
		BX = session ID
		interrupts disabled
		Return: AX = 0000h if OK to switch session
			   = 0001h if not
	    0003h activate session
		BX = session ID
		CX = session status flags
			bit 0: set if first activation of session
			bits 1-15: reserved (0)
		interrupts disabled
		Return: AX = 0000h
	    0004h session active
		BX = session ID
		CX = session status flags
			bit 0: set if first activation of session
			bits 1-15: reserved (0)
		Return: AX = 0000h
	    0005h create session
		BX = session ID
		Return: AX = 0000h if OK to create session
			   = 0001h if not
	    0006h destroy session
		BX = session ID
		Return: AX = 0000h
	    0007h switcher termination
		BX = flags
		    bit 0: set if calling switcher is only switcher loaded
		    bits 1-15: reserved (0)
		Return: AX = 0000h
	ES:DI -> task switcher entry point (see AX=4B02h)
Notes:	function 0000h is generally called by the program which controls or
	  invokes the task switcher, rather than by the task switcher itself;
	  the entry point supplied to this function is not necessarily the
	  entry point to the task switcher itself, and may be 0000h:0000h.  If
	  any client indicates that loading is not possible, all clients will
	  be called with function 0007h; thus it is possible for a client to
	  receive a termination notice without a corresponding initialization
	  notice.
	except for functions 0002h and 0003h, the notification handler is
	  called with interrupts enabled and may make any INT 21h function
	  call; interrupts must not be enabled in functions 0002h and 0003h
	function 0007h may be called with ES:DI = 0000h:0000h if the entry
	  point is no longer valid
----------2F4B02BX0000-----------------------
INT 2F - DOS v5.0 TASK SWITCHER - INSTALLATION CHECK
	AX = 4B02h
	BX = 0000h
	ES:DI = 0000h:0000h
Return: ES:DI = 0000h:0000h if task switcher not loaded
	ES:DI -> task switcher entry point (see below) if loaded
	    AX = 0000h
Note:	the returned entry point is that for the most-recently loaded task
	  switcher; the entry points for prior task switchers may be determined
	  with the "get version" call (see below)
SeeAlso: AX=4A05h,AX=4B03h

Call task switcher entry point with:
	AX = 0000h get version
		Return: CF clear if successful
			    AX = 0000h
			    ES:BX -> task switcher version struct (see below)
			CF set if unsupported function
	AX = 0001h test memory region
		ES:DI -> first byte to be tested
		CX = size of region to test
		Return: CF clear if successful
			    AX = memory type of tested region
				0000h global
				0001h global and local
				0002h local (replaced on session switch)
			CF set if unsupported function
	AX = 0002h suspend switcher
		ES:DI -> new task switcher's entry point
		Return: CF clear if successful
			    AX = state
				0000h switcher has been suspended
				0001h switcher not suspended, new switcher must
					abort
				0002h switcher not suspended, but new switcher
					may run anyway
			CF set if unsupported function
	AX = 0003h resume switcher
		ES:DI -> new task switcher's entry point
		Return: CF clear if successful
			    AX = 0000h
			CF set if unsupported function
	AX = 0004h hook notification chain
		ES:DI -> callback info structure to be added to chain
			(see AX=4B01h)
		Return: CF clear if successful
			    AX = 0000h
			CF set if unsupported function
	AX = 0005h unhook notification chain
		ES:DI -> callback info structure to be removed from chain
			(see AX=4B01h)
		Return: CF clear if successful
			    AX = 0000h
			CF set if unsupported function
	AX = 0006h query API support
		BX = asynchronous API identifier
		Return: CF clear if successful
			    AX = 0000h
			    ES:BX -> API info structure (see below) for the
					client which provides the highest
					level of 
			CF set if unsupported function

Format of task switcher version structure:
Offset	Size	Description
 00h	WORD	major version of supported protocol  (current protocol is 1.0)
 02h	WORD	minor version of supported protocol
 04h	WORD	major version of task switcher
 06h	WORD	minor version of task switcher
 08h	WORD	task switcher ID (see AX=4B03h)
 0Ah	WORD	operation flags
		bit 0: set if task switcher disabled
		bits 1-15: reserved (0)
 0Ch	DWORD	pointer to ASCIZ task switcher name
		("MS-DOS Shell Task Switcher" for DOSSHELL task switcher)
 10h	DWORD	pointer to previous task switcher's entry point or 0000h:0000h

Format of API info structure:
Offset	Size	Description
 00h	WORD	size of structure in bytes (000Ah)
 02h	WORD	API identifier
		0001h NetBIOS
		0002h 802.2
		0003h TCP/IP
		0004h LAN Manager named pipes
		0005h Novell NetWare IPX
 04h	WORD	major version \ of highest version of API for which the support
 06h	WORD	minor version / level specified in the next field is provided
 08h	WORD	support level
		0001h minimal support
		0002h API-level support
		0003h switcher compatibility
		0004h seamless compatibility
----------2F4B03-----------------------------
INT 2F - DOS v5.0 TASK SWITCHER - ALLOCATE SWITCHER ID
	AX = 4B03h
	ES:DI -> task switcher entry point (see AX=4B02h)
Return: AX = 0000h
	BX = switcher ID (0001h-000Fh), or 0000h if no more available
Notes:	if a task switcher has determined that it is the first to be loaded, it
	  must allocate an identifier for itself and provide this function to
	  all subsequent task switchers; if it is not the first to be loaded,
	  it must call this function to allocate an ID.	 The switcher ID is
	  used as the high four bits of all session identifiers to ensure
	  unique session IDs.
	if no more switcher IDs are available, the new task switcher making the
	  call must terminate or disable itself
	the task switcher providing the identifiers may call the new task
	  switcher's entry point as needed
	this call is available from within DOSSHELL even if the task switcher
	  is not installed
SeeAlso: AX=4B02h,AX=4B04h
----------2F4B04-----------------------------
INT 2F - DOS v5.0 TASK SWITCHER - FREE SWITCHER ID
	AX = 4B04h
	BX = switcher ID
	ES:DI -> task switcher entry point (see AX=4B02h)
Return: AX = 0000h
	BX = status
	    0000h successful
	    other error (invalid ID or ID not allocated)
Notes:	called by a task switcher when it exits, unless it was the first loaded
	  and is providing the support for AX=4B03h and AX=4B04h
	the task switcher providing the identifiers may call the terminating
	  task switcher's entry point as needed
	this call is available from within DOSSHELL even if the task switcher
	  is not installed
SeeAlso: AX=4B02h,AX=4B03h
----------2F4B05-----------------------------
INT 2F - DOS v5.0 DOSSHELL TASK SWITCHER - IDENTIFY INSTANCE DATA
	AX = 4B05h
	ES:BX = 0000h:0000h
	CX:DX -> task switcher entry point (see AX=4B02h)
Return: ES:BX -> startup info structure (see below) or 0000h:0000h
Notes:	called by task switcher
	clients with instance data should hook this call, pass it through to
	  the previous handler with unchanged registers using a simulated
	  interrupt.  On return, the client should create a startup info
	  structure (see below), store the returned ES:BX in the "next"
	  field, and return the address of the created structure in ES:BX
	all MSDOS function calls are available from within this call
SeeAlso: AX=1605h,AX=4B02h

Format of startup info structure:
Offset	Size	Description
 00h  2 BYTEs	major, minor version of info structure (03h,00h)
 02h	DWORD	pointer to next startup info structure or 0000h:0000h
 06h	DWORD	0000h:0000h (ignored)
 0Ah	DWORD	ignored
 0Eh	DWORD	pointer to instance data records

Format of one instance data record in array:
Offset	Size	Description
 00h	DWORD	address of instance data (end of array if 0000h:0000h)
 04h	WORD	size of instance data
----------2F53-------------------------------
INT 2F U - ???
	AH = 53h
	AL = subfunction (0Bh, maybe others???)
Return: ???
Note:	called by MS Windows 3.1 POWER.DRV; hooked by MS Mouse driver v8.20+
SeeAlso: AH=54h,INT 33/AX=002Fh
----------2F54-------------------------------
INT 2F U - ???
	AH = 54h
	AL = subfunction (00h, 01h, maybe others???)
Return: ???
Note:	called by MS Windows 3.1 POWER.DRV
SeeAlso: AH=53h
----------2F5453-----------------------------
INT 2F - TesSeRact RAM-RESIDENT PROGRAM INTERFACE
	AX = 5453h
	BX = subfunction
	    00h installation check
		CX = 0000h
		DS:SI -> 8-char blank-padded name
		Return: AX = FFFFh installed
				CX = ID number of already-installed copy
			   = anything else, not installed
				CX = ID number for TSR when installed
	    01h get user parameters
		CX = TSR ID number
		Return: AX = 0000h successful
			   ES:BX -> user parameter block (see below)
			   = nonzero failed
	    02h check if hotkey in use
		CL = scan code of hot key
		Return: AX = FFFFh hot key conflicts with another TSR
			     otherwise safe to use the hotkey
	    03h replace default critical error handler
		CX = TSR ID number
		DS:SI -> new routine for INT 24h
		Return: AX = nonzero, unable to install new handler
	    04h get internal data area
		CX = TSR ID number
		Return: AX = 0000h
			    ES:BX -> TSR's internal data area (see below)
			   = nonzero, TSR not found
	    05h set multiple hot keys
		CX = TSR ID number
		DL = number of additional hot keys to allocate
		DS:SI -> table of hot keys
			BYTE  hotkey scan code
			BYTE  hotkey shift state
			BYTE  flag value to pass to TSR (nonzero)
		Return: AX = nonzero, unable to install hot keys
	    06h - 0Fh reserved
	    10h enable TSR
		CX = TSR ID number
		Return: AX = nonzero, unable to enable
	    11h disable TSR
		CX = TSR ID number
		Return: AX = nonzero, unable to disable
	    12h unload TSR
		CX = TSR ID number
		Return: AX = nonzero, invalid TSR number
		Note: if any interrupts used by TSR have been grabbed by
			another TSR, the TesSeRact routines will wait until
			it is safe to remove the indicated TSR from memory
	    13h restart TSR
		CX = TSR ID number of TSR which was unloaded but is still in
		     memory
		Return: AX = nonzero, unable to restart TSR
	    14h get status word
		CX = TSR ID number
		Return: AX = FFFFh invalid ID number
			   = other, successful
				BX = bit flags
	    15h set status word
		CX = TSR ID number
		DX = new bit flags
		Return: AX = nonzero, unable to set status word
	    16h get INDOS state at popup
		CX = TSR ID number
		Return: AX = 0000h successful
			    BX = value of INDOS flag
	    17h - 1Fh reserved
	    20h call user procedure
		CX = TSR ID number
		ES:DI -> user-defined data
		Return: AX = 0000h successful
	    21h stuff keystrokes into keyboard buffer
		CX = TSR ID number
		DL = speed
		    00h stuff keystrokes only when buffer is empty
		    01h stuff up to four keystrokes per clock tick
		    02h stuff up to 15 keystrokes per clock tick
		DH = scan code flag
		    if zero, buffer contains alternating ASCII and scan codes
		    if nonzero, buffer contains only ASCII codes
		SI = number of keystrokes
		ES:DI -> buffer to stuff
		Return: AX = 0000h success
			     F0F0h user aborted with ^C or ^Break
			     other unable to stuff keystrokes
	    22h (v1.10) trigger popup
		CX = TSR ID number
		Return: AX = 0000h success, TSR will either pop up or beep to
				   indicate that it is unable to pop up
			     nonzero invalid ID number
	    23h (v1.10) invoke TSR's background function
		CX = TSR ID number
		Return: AX = 0000h success
			     FFFFh not safe to call background function
			     nonzero invalid ID number
	    24h - 2Fh reserved
Notes:	Borland's THELP.COM popup help system for Turbo Pascal and Turbo C
	  (versions 1.x and 2.x only) fully supports the TesSeRact API, as
	  do the SWAP?? programs by Innovative Data Concepts.
	AVATAR.SYS supports functions 00h and 01h (only the first three fields
	  of the user parameter block) using the name "AVATAR  "
SeeAlso: AX=CAFEh

Format of User Parameter Block:
Offset	Size	Description
 00h  8 BYTEs	blank-padded TSR name
 08h	WORD	TSR ID number
 0Ah	DWORD	bitmap of supported functions
 0Eh	BYTE	scan code of primary hotkey
		    00h = pop up when shift states match
		    FFh = no popup (if shift state also FFh)
 0Fh	BYTE	shift state of primary hotkey
		    FFh = no popup (if scan code also FFh)
 10h	BYTE	number of secondary hotkeys
 11h	DWORD	pointer to extra hotkeys set by func 05h
 15h	WORD	current TSR status flags
 17h	WORD	PSP segment of TSR
 19h	DWORD	DTA for TSR
 1Dh	WORD	default DS for TSR
 1Fh	DWORD	stack at popup
 23h	DWORD	stack at background invocation

Format of TSR internal data area:
Offset	Size	Description
 00h	BYTE	revision level of TesSeRact library
 01h	BYTE	type of popup in effect
 02h	BYTE	INT 08 occurred since last invocation
 03h	BYTE	INT 13 occurred since last invocation
 04h	BYTE	active interrupts
 05h	BYTE	active soft interrupts
 06h	BYTE	DOS major version
 07h	BYTE	how long to wait before popping up
 08h	DWORD	pointer to INDOS flag
 0CH	DWORD	pointer to DOS critical error flag
 10h	WORD	PSP segment of interrupted program
 12h	WORD	PSP segment of prog interrupted by INT 28
 14h	DWORD	DTA of interrupted program
 18h	DWORD	DTA of program interrupted by INT 28
 1Ch	WORD	SS of interrupted program
 1Eh	WORD	SP of interrupted program
 20h	WORD	SS of program interrupted by INT 28
 22h	WORD	SP of program interrupted by INT 28
 24h	DWORD	INT 24 of interrupted program
 28h  3 WORDs	DOS 3+ extended error info
 2Eh	BYTE	old BREAK setting
 2Fh	BYTE	old VERIFY setting
 30h	BYTE	were running MS WORD 4.0 before popup
 31h	BYTE	MS WORD 4.0 special popup flag
 32h	BYTE	enhanced keyboard call in use
 33h	BYTE	delay for MS WORD 4.0
11 times (for INTs 08h,09h,13h,16h,1Ch,21h,28h,2Fh,1Bh,23h, and 24h):
	DWORD	old interrupt vector
	BYTE	interrupt number
	WORD	offset in TesSeRact code segment of new interrupt handler
----------2F5500-----------------------------
INT 2F U - DOS v5.0 - COMMAND.COM INTERFACE
	AX = 5500h
Return: AX = 0000h
	DS:SI -> entry point table
Notes:	used to access the shareable portion of COMMAND.COM, which may have
	  been moved into the HMA; only the primary COMMAND.COM retains this
	  portion
	procedures called from a dispatcher in COMMAND's resident portion;
	  most assume that the segment address of the resident portion is on
	  the stack and are thus not of general use
----------2F6282-----------------------------
INT 2F U - PC Tools v7.0+ VDEFEND, DATAMON - SET ??? ADDRESS
	AX = 6282h
	CX:DX -> ??? or 0000h:0000h
	DI = 0000h ???
	     FFFFh ???
	     other segment of ???
Return: BX = 0062h
Note:	if CX:DX = 0000h:0000h on entry, the ??? address is not changed
	  (DATAMON only)
SeeAlso: INT 21/AH=FAh"VDEFEND"
----------2F6284BX0000-----------------------
INT 2F U - PC Tools v7.0+ DATAMON - INSTALLATION CHECK
	AX = 6284h
	BX = 0000h
	CX = 0000h
Return: AX = segment of resident code
	BX = 5555h
	CX = 5555h
----------2F6284BX0001-----------------------
INT 2F U - PC Tools v7.0+ DATAMON - GET ???
	AX = 6284h
	BX = 0001h
	CX = 0001h
Return: AX:BX -> ???
	CX = BX
----------2F6284BX0002-----------------------
INT 2F U - PC Tools v7.0+ DATAMON - GET ???
	AX = 6284h
	BX = 0002h
	CX = 0002h
Return: AX = ???
	BX = ???
	CX = AX
	DX = BX
----------2F6284BX0003-----------------------
INT 2F U - PC Tools v7.0+ DATAMON - SET ??? FLAGS
	AX = 6284h
	BX = 0003h
	CX = flags
	    bit 12: ???
		10: ???
		 5: ???
		 3: ???
	DX = flags
	    bit 15: ???
----------2F6400-----------------------------
INT 2F - SCRNSAV2.COM - INSTALLATION CHECK
	AX = 6400h
Return: AL = 00h not installed
	     FFh installed
Note:	SCRNSAV2.COM is a screen saver for PS/2's with VGA by Alan Ballard
SeeAlso: INT 10/AX=5555h
----------2F7000------------------------------
INT 2F - License Service API - INSTALLATION CHECK
	AX = 7000h
	CX = license server index (0000h to 001Fh)
Return: AL = status
	    00h not installed
	    FFh installed
Notes:	The License Service API is being maintained by Microsoft but is being
	  supported by a large number of companies including Apple, Banyan,
	  DEC, HP, Lotus, Microsoft, Novell, Software Publishers Association,
	  and Wordperfect (not a complete list!)
	Each license service provider must search for the next free index
	  slot to use
SeeAlso: AX=7001h,AX=7003h,AX=7004h,AX=7005h
----------2F7001------------------------------
INT 2F - License Service API - REQUEST License
	AX = 7001h
	CX = license server index (0000h to 001Fh)
	DS:DX -> SLSREQEUST structure (see below)
Return: AX = status
	    0000h success
	    else  provider error code
	ES:BX = provider specific handle for the license context
SeeAlso: AX=7002h,AX=7004h,AX=7005h

Format of SLSREQUEST structure:
Offset	Size	Description
 00h	DWORD	(return) status code
 04h	DWORD	(return) handle identifying context
 08h	DWORD	(call) address of Publisher string
 0Ch	DWORD	(call) address of Product string
 10h	DWORD	(call) address of Version string
 14h	DWORD	units required
 18h	DWORD	address of comment string
 1Ch	DWORD	address of SLSCHALLENGE structure (see below)

Format of SLSCHALLENGE structure:
Offset	Size	Description
 00h	DWORD	algorithm (currently always 1)
 04h	DWORD	secret to be challenged (1-255)
 08h	DWORD	size of challenge in bytes (1-255)
 0Ch  N BYTEs	challenge data
----------2F7002------------------------------
INT 2F - License Service API - RELEASE License
	AX = 7002h
	CX = license server index (0000h to 001Fh)
	DS:DX -> SLSRELEASE structure (see below)
	ES:BX = provider specific handle for the license context
Return: AL = status
	    00h not installed
	    FFh installed
SeeAlso: AX=7001h,AX=7005h

Format of SLSRELEASE structure:
Offset	Size	Description
 00h	DWORD	handle indentifying license context
 04h	DWORD	total units consumed
 08h	DWORD	address of comment string
----------2F7003------------------------------
INT 2F - License Service API - UPDATE
	AX = 7003h
	CX = license server index (0000h to 001Fh)
	DS:DX -> SLSUPDATE structure
	ES:BX = provider specific handle for the license context
Return: AL = status
	    00h not installed
	    FFh installed
SeeAlso: AX=7004h,AX=7005h

Format of SLSUPDATE structure:
Offset	Size	Description
 00h	DWORD	(return) status code
 04h	DWORD	(call) handle identifying license context
 08h	DWORD	(call) total units consumed
 0Ch	DWORD	additional units required
 10h	DWORD	address of comment string
 14h	DWORD	address of SLSCHALLENGE structure (see AX=7001h)
----------2F7004------------------------------
INT 2F - License Service API - GET ERROR
	AX = 7004h
	CX = license server index (0000h to 001Fh)
	DS:DX -> SLSGETERROR structure (see below)
	ES:BX = provider specific handle for the license context
Return: AL = status
	    00h not installed
	    FFh installed
SeeAlso: AX=7000h,AX=7001h

Format of SLSGETERROR structure:
Offset	Size	Description
 00h	DWORD	(return) status code
 04h	DWORD	handle identifying license context
 08h	DWORD	error code
 0Ch	DWORD	buffer size in bytes
 10h  N BYTEs	data buffer
----------2F7005------------------------------
INT 2F - License Service API - QUERY License
	AX = 7005h
	CX = license server index (0000h to 001Fh)
	DS:DX -> SLSQUERY structure (see below)
	ES:BX = provider specific handle for the license context
Return: AL = status
	    00h not installed
	    FFh installed
SeeAlso: AX=7001h,AX=7002h

Format of SLSQUERY structure:
Offset	Size	Description
 00h	DWORD	(return) status code
 04h	DWORD	handle identifying license context
 08h	DWORD	information index
 0Ch	DWORD	buffer size in bytes
 10h  N BYTEs	data buffer
----------2F7200-----------------------------
INT 2F - SRDISK v1.30 - INSTALLATION CHECK
	AX = 7200h
Return: AL = FFh if installed
	    ES = segment of device driver header (see below)
Note:	SRDISK is a freeware resizeable RAMdisk by Marko Kohtala

Format of device driver header:
Offset	Size	Description
 00h 10 BYTEs	same as standard device driver header (see INT 21/AH=52h)
 0Ah	BYTE	number of subunits (drives) supported by driver
 0Bh  3 BYTEs	signature "SRD"
 0Eh  4 BYTEs	memory type string (currently only "XMS ")
 12h  4 BYTEs	ASCII driver version string "N.NN"
 16h	BYTE	00h
 17h	BYTE	configuration format version (currently 00h)
 18h	WORD	offset of drive configuration data
----------2F7A00-----------------------------
INT 2F - Novell NetWare - LOW-LEVEL API (IPX) INSTALLATION CHECK
	AX = 7A00h
Return: AL = 00h not installed
	   = FFh installed
		ES:DI -> FAR entry point for routines accessed exclusively
			through INT 7A in NetWare versions through 2.0a.  Call
			with same values as INT 7A
SeeAlso: AX=7AFFh/BX=0000h,AX=D800h,INT 64"Novell",INT 7A"Novell"
----------2F7A10-----------------------------
INT 2F - Novell NetWare - TBMI v2.0 - GET TBMI STATUS
	AX = 7A10h
Return: DH = major TBMI version number
	DL = minor TBMI version number
	CX = segment address of TBMI resident part
	BX = status word of TBMI
		bit 0: INT2F intercepted by TBMI
		bit 1: INT7A intercepted by TBMI
		bit 2: INT64 intercepted by TBMI
		bits 3-14: reserved or unused ???
		bit 15: outstanding task ID was detected
Note:	TBMI is the Task-Switched Buffer Manager Interface
SeeAlso: AX=7A11h,AX=7A12h,AX=7A13h,AX=7A14h
----------2F7A11-----------------------------
INT 2F - Novell NetWare - TBMI v2.0 - GET INT2F HANDLERS
	AX = 7A11h
Return: ES:BX -> old INT 2F handler
	DS:DX -> TBMI INT 2F handler
SeeAlso: AX=7A10h,AX=7A12h,AX=7A13h
----------2F7A12-----------------------------
INT 2F - Novell NetWare - TBMI v2.0 - GET INT64 HANDLERS
	AX = 7A12h
Return: ES:BX -> old INT 64 handler
	DS:DX -> TBMI INT 64 handler
SeeAlso: AX=7A10h,AX=7A11h,AX=7A13h
----------2F7A13-----------------------------
INT 2F - Novell NetWare - TBMI v2.0 - GET INT7A HANDLERS
	AX = 7A13h
Return: ES:BX = old INT 7A handler
	DS:DX = TBMI INT 7A handler
SeeAlso: AX=7A10h,AX=7A11h,AX=7A12h
----------2F7A14-----------------------------
INT 2F - Novell NetWare - TBMI v2.0 - GET STATISTICS
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
SeeAlso: AX=7A10h
----------2F7A1B-----------------------------
INT 2F - Novell NetWare - TBMI v2.0 - RESERVED???
	AX = 7A1Bh
Note:	this call merely performs an IRET
----------2F7A80-----------------------------
INT 2F - Novell NetWare - SHELL 3.01d BROADCAST - ABNORMAL EXIT
	AX = 7A80h
Return: nothing
Notes:	called on abnormal exit of the NetWare shell to notify other Novell
	  TSRs that it is unsafe to call the shell in the future.
	must be passed through so that all interested programs see the exit
	on receiving this call, IPXODI clears an internal pointer to a
	  default value; Novell's NETBIOS.EXE clears its INT 21h pointer to
	  0000h:0000h and stops calling it
SeeAlso: AX=7A81h
----------2F7A81-----------------------------
INT 2F - Novell NetWare - SHELL 3.01d BROADCAST - SET SHELL INT 21 HANDLER
	AX = 7A81h
	CX:DX -> shell's INT 21h entry point
Return: nothing
Notes:	the shell calls this function as it loads to allow interested TSRs
	  and drivers to make a local copy of the shell's entry point
	must be passed through so that all interested programs see it
----------2F7A85-----------------------------
INT 2F - Novell NetWare - shell 3.01 - BROADCAST INFORM
	AX = 7A85h
	CX = broadcast server number
Return: CX = 0000h if broadcast message handled by another program
	CX unchanged if broadcast not handled
----------2F7A90-----------------------------
INT 2F U - Novell NetWare - NETBIOS.EXE 3+ - INSTALLATION CHECK
	AX = 7A90h
Return: AL = 00h if present
	    BX = ???
	    CX = PSP segment of NETBIOS resident code
SeeAlso: AX=7AFEh
----------2F7AFE-----------------------------
INT 2F - Novell NetWare - DOSNP.EXE - INSTALLATION CHECK
	AX = 7AFEh
Return: AL = FFh if present
	    ES = (data???) segment of DOSNP
Program: DOSNP.EXE provides "named pipes" support for DOS workstations running
	   NetWare
Note:	the NetWare shell calls this function and refuses to load if DOSNP is
	  present
SeeAlso: AX=7A90h
----------2F7AFFBX0000-----------------------
INT 2F - Novell NetWare - TBMI v2.0 - INSTALLATION CHECK???
	AX = 7AFFh
	BX = 0000h
	CX = 4E65h ("Ne")
	DX = 7457h ("tW")
	ES:DI -> IPX/SPX special handler (XMS/EMS ???)
Return: AL = FFh if installed
	    CX = configured sockets (14h)
	    DS:SI -> data table ???
	    ES:DI -> IPX far call handler
Note:	for IPX/SPX this call reportedly returns DS:DI pointing to the table
	  of pointers to service events queue head and tail
SeeAlso: AX=7AFFh/BX=0001h
----------2F7AFFBX0001-----------------------
INT 2F - Novell NetWare - TBMI v2.0, shell v3.01d - INSTALLATION CHECK???
	AX = 7AFFh
	BX = 0001h
	CX = 4E65h ("Ne")
	DX = 7457h ("tW")
Return: AL = FFh if installed
	    CX = ???  (8000h)
	    SI = ??? (or -> ???) (0002h)
	    ES:DI -> IPX far call handler
	    ES:DX -> 6-byte data area ???
SeeAlso: AX=7AFFh/BX=0000h
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
----------2F8000-----------------------------
INT 2F - EASY-NET - INSTALLATION CHECK
	AX = 8000h
Return: AL = 00h not installed
	     FFh installed
Note:	EASY-NET is a shareware two-machine serial-port network
----------2F8000-----------------------------
INT 2F - Nanosoft, Inc. TurboNET server - INSTALLATION CHECK
	AX = 8000h
Return: AL = FFh if installed
	    BX = CS of resident code
	    CX = ??? (03FCh)
Note:	TurboNET is a NetBIOS-based file redirector and server; a demonstration
	  version may be downloaded from Nanosoft's BBS
SeeAlso: AX=8100h
----------2F8000DX0000-----------------------
INT 2F - FaxBIOS interface - INSTALLATION CHECK
	AX = 8000h
	DX = 0000h
	DI = 0000h
Return: AL = FFh if installed
	DX:DI -> signature "FaxBiosjpc"
Note:	FaxBIOS may use any multiplex number from 80h through FFh; to determine
	  whether it is installed, it is necessary to poll all multiplex
	  numbers for one which returns the above signature
SeeAlso: AH=2Ah,AX=80FBh
----------2F8001-----------------------------
INT 2F - Nanosoft, Inc. TurboNET server - ???
	AX = 8001h
	DS:SI -> 16-byte buffer for ???
Return: AH = status
	    00h successful
	    01h error
Note:	makes NetBIOS calls
----------2F80FB-----------------------------
INT 2F - FaxBIOS interface - COMMAND SUBMISSION
	AX = 80FBh
	BX = function number (see below)
	DX:DI -> command buffer (see below)
Return: AL = FFh if submitted OK
	CX = result code (see below)
Note:	FaxBIOS may use any multiplex number from 80h through FFh
SeeAlso: AX=8000h"FaxBIOS",AX=CBDDh

Values for function number:
 0001h	SYS_LOGIN
 0002h	SYS_LOGOUT
 0003h	SYS_GET_FAXAPP_INFO
 0004h	STAT_IO_GET
 0005h	STAT_FAXBIOS_GET
 0006h	PDIR_OPEN
 0007h	PDIR_CLOSE
 0008h	PDIR_READ_PERSON
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
 0013h	SCHED_OPEN
 0014h	SCHED_ADD_DEST
 0015h	SCHED_ADD_FILE
 0016h	SCHED_SET_PARAMS
 0017h	SCHED_CANCEL
 0018h	SCHED_CLOSE
 0019h	SLOG_OPEN
 001Ah	SLOG_CLOSE
 001Bh	SLOG_SHORT_ENV_STAT
 001Ch	SLOG_LONG_ENV_STAT
 001Dh	SLOG_DEST_STAT
 001Eh	SLOG_FILE_STAT
 001Fh	SLOG_CANCEL_ENV
 0020h	RLOG_OPEN
 0021h	RLOG_CLOSE
 0022h	RLOG_READ
 0023h	GRAPH_GET_FILE_TYPE
 0024h	GRAPH_EXPORT_FILE
 0025h	GRAPH_GET_LAYOUT_INFO
 0026h	GRAPH_CREATE_FILE
 0027h	GRAPH_CLOSE_FILE
 0028h	GRAPH_CREATE_PAGE
 0029h	GRAPH_WRITE
 002Ah	GRAPH_END_PAGE
 002Bh	GRAPH_OPEN_FILE
 002Ch	GRAPH_GOTO_PAGE
 002Dh	GRAPH_READ
 002Eh	IOCTL_GET
 002Fh	IOCTL_SET
 0030h	IOCTL_ANSWER_FAX
 0031h	IOCTL_DIAL

Values for result code:
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
 050Ah	Subject text was not an ASCIIZ string
 050Bh	From text was not an ASCIIZ string
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
 0617h	a grphics file to be read is empty
 0618h	GRAPH_CREATE_PAGE called before GRAPH_END_PAGE
 0619h	graph read or write attempted without goto or create
 061Ah	graph page contains no data
 061Bh	Phone Directory is already open for this client
 061Ch	schedule log is already open for this client
 061Dh	receive log is aready open for this client
 061Eh	Phone Directory function requires write mode
 0800h	denied exclusive use of the API

Format of SYS_LOGIN command buffer:
Offset	Size	Description
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
 2Ch	WORD	FaxBIOS capabilities bitmap
 		bit 0: transmit supported
		bit 1: receive supported
		bit 2: IOCTL supported
		bit 3: IOCTL_DIAL supported
		bit 4: IOCTL_ANSWER_FAX supported
		bit 5: manual transmit supported
		bit 6: optional phone services supported
		bit 7: canonical phone objects
		bit 8: seam with next supported
 2Eh	DWORD	T.30 capabilities bitmap
 		bit 0:	low vertical resolution (minimum)
		bit 1:	high vertical resolution
		bit 2:	page width 107mm (4.21 in)
		bit 3:	page width 151mm (5.91 in)
		bit 4:	page width 215mm (8.46 in) (minimum)
		bit 5:	page width 255mm (10.04 in)
		bit 6:	page width 303mm (11.93 in)
		bit 7:	unused
		bit 8:	page length 297mm (11.69 in) (minimum)
		bit 9:	page length 364mm (14.33 in)
		bit 10: page length 279mm (11 in)
		bit 11: page length unlimited
		bit 12: Group 4 resolution 300x300
		bit 13: Group 4 resolution 400x400
		bit 14: able to respond to poll from remote
		bit 15: able to poll remote
		bit 16: binary file transfer supported
 32h	WORD	IPC handle
 34h	DWORD	amount of memory needed to load
 38h	WORD	scope (00h for public, nonzero for private)
 3Ah  6 BYTEs	future expansion
 40h	WORD	structure size

Format of SYS_LOGOUT command buffer:
Offset	Size	Description
 00h	WORD	structure size
 02h	WORD	function number
 04h	WORD	return code
 06h	WORD	client ID
 08h	DWORD	client tag (for client's internal use)
 0Ch  6 BYTEs	future expansion
 12h	WORD	structure size

Format of SYS_GET_FAXAPP_INFO command buffer:
Offset	Size	Description
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

Format of STAT_IO_GET command buffer:
Offset	Size	Description
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
 70h104 BYTEs	remote number
 D8h 20 BYTEs	last name
 ECh 20 BYTEs	first name
100h 32 BYTEs	company name
120h 32 BYTEs	notes
140h	WORD	current envelope ID (if sending)
142h	WORD	total pages in transmission (if sending)
144h  6 BYTEs	future expansion
14h	WORD	structure size

Format of STAT_FAXBIOS_GET command buffer:
Offset	Size	Description
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
 
Format of PDIR_OPEN command buffer:
Offset	Size	Description
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
 
Format of PDIR_CLOSE command buffer:
Offset	Size	Description
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	Phone Directory handle
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size
 
Format of PDIR_READ_PERSON command buffer:
Offset	Size	Description
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

Format of SCHED_OPEN, SCHED_CANCEL command buffer:
Offset	Size	Description
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	scheduler handle
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size
 
Format of SCHED_ADD_DEST command buffer:
Offset	Size	Description
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

Format of SCHED_ADD_FILE command buffer:
Offset	Size	Description
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
 
Format of SCHED_SET_PARAMS command buffer:
Offset	Size	Description
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

Format of SCHED_CLOSE command buffer:
Offset	Size	Description
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	scheduler handle
 0Eh	WORD	envelope ID generated
 10h  6 BYTEs	future expansion
 16h	WORD	structure size

Format of SLOG_OPEN, SLOG_CLOSE, RLOG_OPEN, RLOG_CLOSE command buffer:
Offset	Size	Description
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	log handle
 0Eh	WORD	number of entries 
 10h  6 BYTEs	future expansion
 16h	WORD	structure size

Format of GRAPH_GET_FILE_TYPE command buffer:
Offset	Size	Description
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

Format of GRAPH_CREATE_FILE command buffer:
Offset	Size	Description
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch 80 BYTEs	filename
 5Ch	WORD	graph handle
 5Eh  6 BYTEs	future expansion
 64h	WORD	structure size

Format of GRAPH_CLOSE_FILE, GRAPH_END_PAGE command buffer:
Offset	Size	Description
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	graph handle
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size

Format of GRAPH_CREATE_PAGE command buffer:
Offset	Size	Description
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	graph handle
 0Eh	WORD	resolution
 10h	WORD	page width
 12h  6 BYTEs	future expansion
 18h	WORD	structure size

Format of GRAPH_WRITE_PAGE command buffer:
Offset	Size	Description
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

Format of GRAPH_OPEN_FILE command buffer:
Offset	Size	Description
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch 80 BYTEs	filename
 5Ch	WORD	file type
 5Eh	WORD	graph handle
 60h	WORD	number of pages
 62h  6 BYTEs	future expansion
 68h	WORD	structure size

Format of GRAPH_GOTO_PAGE command buffer:
Offset	Size	Description
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	graph handle
 0Eh	WORD	page number
 10h	WORD	vertical resolution
 12h	WORD	page width
 14h	DWORD	page length
 18h  6 BYTEs	future expansion
 1Eh	WORD	structure size

Format of GRAPH_READ_PAGE command buffer:
Offset	Size	Description
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

Format of IOCTL_ANSWER_FAX command buffer:
Offset	Size	Description
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	device number
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size
 
Format of IOCTL_DIAL command buffer:
Offset	Size	Description
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	device number
 0Eh  6 BYTEs	country code
 14h  6 BYTEs	city or area code
 1Ah 14 BYTEs	local number
 28h 14 BYTEs	extension
 36h 14 BYTEs	reserved
 4Eh  6 BYTEs	future expansion
 54h	WORD	structure size
----------2F8100-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - INSTALLATION CHECK
	AX = 8100h
Return: AL = FFh if installed
Note:	TurboNET is a NetBIOS-based file redirector and server; a demonstration
	  version may be downloaded from Nanosoft's BBS
SeeAlso: AX=8000h"TurboNET"
----------2F8101-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8101h
Return: AL = ???
	DL = ???
----------2F8102-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8102h
Return: AL = ???
	DL = ???
----------2F8103-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - GET MACHINE NAME???
	AX = 8103h
	ES:DI -> 17-byte buffer
Return: buffer filled
----------2F8104-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8104h
	BL = ???
	BH = ???
	CX = ???
	DX = ???
	DS:SI -> 16-byte buffer containing ???
Return: AL = 00h ???
----------2F8105-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8105h
	CX = ??? (don't change current value if 0000h)
	DX = ??? (don't change current value if 0000h)
Return: AL = 00h successful
----------2F82-------------------------------
INT 2F U - Nanosoft, Inc. TurboNET - ???
	AH = 82h
	???
Return: ???
Note:	called by TNR.EXE, the TurboNET redirector configuration program
SeeAlso: AX=8100h
----------2F8200-----------------------------
INT 2F - RESPLAY - SAMPLE/PLAYBACK
	AX = 8200h
	DX:DI -> start of sample space
	CX:BX = length in bytes
Return: AX = status
	    1000h successful
	    2000h not initialized (see AX=8210h)
	    other RESPLAY not installed
Note:	RESPLAY is a freeware sound sampling/playback utility by Mark J. Cox
SeeAlso: AX=8201h,AX=8210h
----------2F8201-----------------------------
INT 2F - RESPLAY - INSTALLATION CHECK
	AX = 8201h
Return: AX = 7746h if installed
SeeAlso: AX=8202h
----------2F8202-----------------------------
INT 2F - RESPLAY - UNINSTALL
	AX = 8202h
Return:	AX = status
	    1000h successful
SeeAlso: AX=8201h
----------2F8210-----------------------------
INT 2F - RESPLAY - INITIALIZE
	AX = 8210h
	BL = sound device
	    00h printer port LPT1
	    01h printer port LPT2
	    02h prototype board at I/O address 0300h
	    03h printer port (alternative LPT1)
	    04h internal speaker
	BH = sample rate in multiples of 250 Hz (14h to A0h)
	CL = direction
	    00h playback
	    01h sample
Return: AX = status
	    1000h successful
	    2000h parameter out of range
	    other RESPLAY not installed
SeeAlso: AX=8200h
----------2F86-------------------------------
INT 2F U - ???
	AH = 86h
	AL = function (at least 06h and 07h)
	???
Return: ???
Note:	called by Codeview for Windows
SeeAlso: AH=44h
----------2F8900-----------------------------
INT 2F - WHOA!.COM - INSTALLATION CHECK
	AX = 8900h
Return: AL = 00h not installed
	   = FFh installed
Note:	WHOA!.COM is a system slow-down utility by Brad D Crandall
SeeAlso: AX=8901h,AX=8902h
----------2F8901-----------------------------
INT 2F - WHOA!.COM - UNINSTALL
	AX = 8901h
Return: AL = FDh successful
	   = FEh error
Note:	WHOA!.COM is a system slow-down utility by Brad D Crandall
SeeAlso: AX=8900h
----------2F8902-----------------------------
INT 2F - WHOA!.COM - SET DELAY COUNT
	AX = 8902h
	BX = delay count (larger values slow system down more)
Return: AL = FDh successful
	   = FEh error
Note:	WHOA!.COM is a system slow-down utility by Brad D Crandall
SeeAlso: AX=8900h
----------2F9000-----------------------------
INT 2F U - RAID - INSTALLATION CHECK
	AX = 9000h
Return: AL = FFh if installed
Note:	RAID (Resident AID) is a TSR utility program by Ross Neilson Wentworth
	  that resides mostly in EMS
----------2F9001-----------------------------
INT 2F U - RAID - GET ???
	AX = 9001h
Return: DX:AX -> ???
SeeAlso: AX=9000h
----------2F9002-----------------------------
INT 2F U - RAID - GET RESIDENT SEGMENT
	AX = 9002h
Return: AX = segment of resident (conventional memory) portion
SeeAlso: AX=9000h
----------2F9003-----------------------------
INT 2F U - RAID - UNINSTALL
	AX = 9003h
Return: ???
SeeAlso: AX=9000h
----------2F9004-----------------------------
INT 2F U - RAID - GET ???
	AX = 9004h
Return: AX = first available paragraph past end of resident portion???
	CX destroyed
SeeAlso: AX=9000h
----------2F92-------------------------------
INT 2F - Couriers LAN E-Mail - API
	AH = 92h
	AL = function
	    00h installation check
	    01h uninstall
	    02h pop down MICRO.EXE notification window
	    03h ???
	    04h ???
	    05h ???
Return: ???
SeeAlso: AH=9Ch
----------2F93-------------------------------
INT 2F - InnerMission v1.7+ - INSTALLATION CHECK
	AH = 93h
	BX = CX = AX
Return: AL = FFh if installed and BX=CX=AX on entry
	    BX = segment of resident code
	   = 01h if installed but BX or CX differ from AX
Note:	InnerMission is a shareware graphical screen blanker by Kevin Stokes
----------2F9C-------------------------------
INT 2F - Couriers LAN E-Mail OPERATOR.EXE - API
	AH = 9Ch
	AL = subfunction
	    01h uninstall
Return: ???
SeeAlso: AH=92h
----------2FA1--BX0081-----------------------
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
SeeAlso: AX=ED00h,AX=FBA1h,INT 15/AX=BF02h
----------2FA189-----------------------------
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
Notes:	HRAMDEV.SYS is a part of the shareware package HRAM by Biologic which
	  provides improved high memory access under MSDOS 5.0
	functions 00h and 01h use a stack of four entries; function 01h always
	  removes the values stored with the most recent function 00h call
	  which has not yet been matched with a function 01h call.
----------2FA4E0-----------------------------
INT 2F - Futurus Team - INSTALLATION CHECK
	AX = A4E0h
Return: AL = 52h ("R") if installed
	    AH = major version plus 30h ("0")
	    ES:BX -> ??? (INT A4 handler???)
Note:	older versions of Right Hand Man (from which Team evolved) store the
	  signature "RH" at offset 103h in the INT 2F handler's segment
SeeAlso: INT A4"Right Hand Man"
----------2FA900-----------------------------
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
----------2FA901-----------------------------
INT 2F - METZTSR.COM - GET TIME OF LAST KEYBOARD ACTIVITY
	AX = A901h
	CF set
Return: CF clear if successful
	    AX:DX = BIOS time at which INT 09 was last invoked
	CF set if not present
SeeAlso: INT 09,INT 1A/AH=00h
----------2FA902-----------------------------
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
----------2FA903-----------------------------
INT 2F - METZTSR.COM - GET METZ Ctrl-Alt-Del FLAG
	AX = A903h
	CF set
Return: CF clear if successful	
	    AX = 97FFh if Ctrl-Alt-Del allowed
	    AX = 0000h if Ctrl-Alt-Del not allowed
	CF set if not resident
SeeAlso: AX=A902h
----------2FAA00-----------------------------
INT 2F - VIDCLOCK.COM - INSTALLATION CHECK
	AX = AA00h
Return: AL = 00h not installed
	     FFh installed
Note:	VIDCLOCK.COM is a memory-resident clock by Thomas G. Hanlin III
----------2FAB00-----------------------------
INT 2F - Btrieve Multi-User - INSTALLATION CHECK
	AX = AB00h
Return: AL = 4Dh if installed
SeeAlso: AX=AB01h,AX=AB02h,INT 21/AX=3000h"Btrieve",INT 7B"Btrieve"
----------2FAB01-----------------------------
INT 2F - Btrieve Multi-User - EXECUTE Btrieve OPERATION
	AX = AB01h
	BX = process ID
	DS:DX -> 38-byte parameter record (see INT 7B"Btrieve")
Return: AL = 00h OK
	   = other retry after calling INT 7F/AX=0200h
SeeAlso: AX=AB00h,AX=AB02h,INT 7B"Btrieve",INT 7F/AX=0200h
----------2FAB02-----------------------------
INT 2F - Btrieve Multi-User - GET NEW PROCESS ID
	AX = AB02h
Return: AL = 00h succesful
	    BX = process ID
	AL > 00h failed, retry after calling INT 7F/AX=0200h
SeeAlso: AX=AB00h,AX=AB01h,INT 7B"Btrieve",INT 7F/AX=0200h
----------2FAC00-----------------------------
INT 2F - DOS 4.01+ GRAPHICS.COM - INSTALLATION CHECK
	AX = AC00h
Return: AX = FFFFh
	ES:DI -> ??? (graphics data?) (not documented)
Note:	this installation check was moved here to avoid the conflict with the
	  CD-ROM extensions that occurred in DOS 4.00
SeeAlso: AX=1500h"GRAPHICS"
----------2FAD00-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - INSTALLATION CHECK
	AX = AD00h
Return: AL = FFh if installed
	    BX = ??? (0100h in MS-DOS 3.30, PCDOS 4.01)
Note:	DOS 5.0 DISPLAY.SYS chains to previous handler if AL is not one of the
	  subfunctions listed here
----------2FAD01-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - SET ACTIVE CODE PAGE
	AX = AD01h
	BX = new code page
Return: CF clear if successful
	    AX = 0001h
	CF set on error (unsupported code page)
	    AX = 0000h
SeeAlso: AX=AD02h
----------2FAD02-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - GET ACTIVE CODE PAGE
	AX = AD02h
Return: CF set if code page never set
	    AX = 0001h
	    BX = FFFFh (assume first hardware code page)
	CF clear if successful
	    BX = current code page
SeeAlso: AX=AD01h,AX=AD03h
----------2FAD03-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - GET CODE PAGE INFORMATION
	AX = AD03h
	ES:DI -> buffer for code page information (see below)
	CX = size of buffer in bytes
Return: CF set if buffer too small
	CF clear if successful
	    ES:DI buffer filled
SeeAlso: AX=AD01h,AX=AD02h

Format of DOS 5.0 code page information:
Offset	Size	Description
 00h	WORD	number of software code pages
 02h	WORD	??? (0003h)
 04h	WORD	number of hardware code pages
 06h  N WORDs	hardware code page numbers
      N WORDs	software (prepared) code pages (FFFFh if not yet prepared)
----------2FAD04-----------------------------
INT 2F U - DOS 4.x only DISPLAY.SYS internal - ???
	AX = AD04h
	???
Return: ???
----------2FAD10-----------------------------
INT 2F U - DOS 4.x DISPLAY.SYS internal - INSTALLATION CHECK???
	AX = AD10h
	???
Return: AX = FFFFh
	BX = ??? (0100h in PCDOS 4.01)
----------2FAD10-----------------------------
INT 2F U - DOS 5.0 DISPLAY.SYS internal - ???
	AX = AD10h
	???
Return: CF clear if successful
	CF set on error
Note:	this function is a NOP if the active code page has never been set
	  (AX=AD02h returns BX=FFFFh); its purpose otherwise is not known
----------2FAD40-----------------------------
INT 2F - DOS 4.0 - ???
	AX = AD40h
	DX = ???
	???
Return: ???
Note:	called by PCDOS 4.01 PRINT.COM
----------2FAD80-----------------------------
INT 2F u - DOS 3.3+ KEYB.COM internal - INSTALLATION CHECK
	AX = AD80h
Return: AL = FFh if installed
	    BX = version number (BH = major, BL = minor)
	    ES:DI -> internal data (see below)
Notes:	MSDOS 3.30, PCDOS 4.01, and MSDOS 5.00 all report version 1.00.
	undocumented prior to the release of DOS 5.0

Format of KEYB internal data:
Offset	Size	Description
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
 20h	WORD	pointer to key translation data
 22h	WORD	pointer to last item in code page table list (see below)
 24h  9 BYTEs	???
---DOS 4.01---
 1Ah  2 BYTEs	???
 1Ch	WORD	pointer to first item in list of code page tables???
 1Eh	WORD	pointer to ??? item in list of code page tables
 20h  2 BYTEs	???
 22h	WORD	pointer to key translation data
 24h	WORD	pointer to last item in code page table list (see below)
 26h  9 BYTEs	???

Format of code page table list entries:
Offset	Size	Description
 00h	WORD	pointer to next item, FFFFh = last
 02h	WORD	code page
 04h  2 BYTEs	???

Format of translation data:
Offset	Size	Description
 00h	WORD	size of data in bytes, including this word
 02h N-2 BYTEs	???
----------2FAD81-----------------------------
INT 2F - DOS 3.3+ KEYB.COM - SET KEYBOARD CODE PAGE
	AX = AD81h
	BX = code page (see INT 21/AX=6601h)
Return: CF set on error
	    AX = 0001h (code page not available)
	CF clear if successful
Notes:	called by DISPLAY.SYS
	undocumented prior to the release of DOS 5.0
SeeAlso: AX=AD82h
----------2FAD82-----------------------------
INT 2F - DOS 3.3+ KEYB.COM - SET KEYBOARD MAPPING
	AX = AD82h
	BL = new state
	    00h US keyboard (Control-Alt-F1)
	    FFh foreign keyboard (Control-Alt-F2)
Return: CF set on error (BL not 00h or FFh)
	CF clear if successful
Note:	undocumented prior to the release of DOS 5.0
SeeAlso: AX=AD81h,AX=AD83h
----------2FAD83-----------------------------
INT 2F - DOS 5.0 KEYB.COM - GET KEYBOARD MAPPING
	AX = AD83h
Return: BL = current state
	    00h US keyboard
	    FFh foreign keyboard
SeeAlso: AX=AD82h
----------2FAE00DXFFFF-----------------------
INT 2F U - DOS 3.3+ internal - INSTALLABLE COMMAND - INSTALLATION CHECK
	AX = AE00h
	DX = FFFFh
	CH = FFh
	CL = length of command line tail (4DOS v4.0)
	DS:BX -> command line buffer (see below)
	DS:SI -> command name buffer (see below)
	DI = 0000h (4DOS v4.0)
Return: AL = FFh if this command is a TSR extension to COMMAND.COM
	AL = 00h if the command should be executed as usual
Notes:	This call provides a mechanism for TSRs to install permanent
	  extensions to the command repertoire of COMMAND.COM.	It appears
	  that COMMAND.COM makes this call before executing the current
	  command line, and does not execute it itself if the return is FFh.
	APPEND hooks this call, to allow subsequent APPEND commands to
	  execute without re-running APPEND

Format of command line buffer:
Offset	Size	Description
 00h	BYTE	max length of command line, as in INT 21/AH=0Ah
 01h	BYTE	count of bytes to follow, excluding terminating 0Dh
      N BYTEs	command line text, terminated by 0Dh

Format of command name buffer:
Offset	Size	Description
 00h	BYTE	length of command name
 01h  N BYTEs	uppercased command name (blank-padded to 11 chars by 4DOS v4)
----------2FAE01DXFFFF-----------------------
INT 2F U - DOS 3.3+ internal - INSTALLABLE COMMAND - EXECUTE
	AX = AE01h
	DX = FFFFh
	CH = 00h
	CL = length of command name (4DOS v4.0)
	DS:SI -> command name buffer (see AX=AE00h)
	DS:BX -> command line buffer (see AX=AE00h)
Return: DS:SI buffer updated
	  if length byte is nonzero, the following bytes contain the uppercase
	  internal command to execute and the command line buffer contains the
	  command's parameters (the first DS:[SI] bytes are ignored)
Notes:	this call requests execution of the command which a previous call to
	  AX=AE00h indicated was resident
	APPEND hooks this call
----------2FB000-----------------------------
INT 2F - DOS 3.3+ GRAFTABL.COM - INSTALLATION CHECK
	AX = B000h
Return: AL = 00h not installed, OK to install
	   = 01h not installed, not OK to install
	   = FFh installed
Notes:	called by DISPLAY.SYS
	documented for DOS 5.0, but undocumented in prior versions
SeeAlso: AX=B001h
----------2FB001-----------------------------
INT 2F - DOS 3.3+ GRAFTABL.COM - GET GRAPHICS FONT TABLE
	AX = B001h
	DS:BX -> DWORD buffer for address of 8x8 font table
Return: buffer filled
	AL = FFh
Note:	PCDOS 3.30/4.01 set the font table offset to 0130h, MSDOS 3.30 to 0030h
SeeAlso: AX=B000h
----------2FB400-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - INSTALLATION CHECK
	AX = B400h
Return: AL = FFh if installed
----------2FB401-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - GET HOST BUFFER ADDRESS
	AX = B401h
Return: ES -> host screen buffer (PC ASCII format)
	ES unchanged if communications not started
----------2FB402-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B402h
	BX = ???
Return: ???
----------2FB403-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B403h
	???
Return: ???
----------2FB404-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B404h
	???
Return: ???
----------2FB405-----------------------------
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
Note:	MSDOS 3.30 APPEND refuses to install itself when run inside TopView or
	  a TopView-compatible environment
----------2FB701-----------------------------
INT 2F U - APPEND - ???
	AX = B701h
	???
Return: ???
Note:	MSDOS 3.30 APPEND displays "Incorrect APPEND Version" and aborts caller
----------2FB702-----------------------------
INT 2F - APPEND - VERSION CHECK
	AX = B702h
Return: AX = FFFFh if not DOS 4.0 APPEND (also if DOS 5.0 APPEND)
	AL = major version number
	AH = minor version number, otherwise
SeeAlso: AX=B710h
----------2FB703-----------------------------
INT 2F U - DOS 3.3, DOS 5.0 APPEND - HOOK INT 21
	AX = B703h
	ES:DI -> INT 21 handler APPEND should chain to
Return: ES:DI -> APPEND's INT 21 handler
Note:	each invocation of this function toggles a flag which APPEND uses to
	  determine whether to chain to the user handler or the original
	  INT 21
----------2FB704-----------------------------
INT 2F - DOS 3.3+ APPEND - GET APPEND PATH
	AX = B704h
Return: ES:DI -> active APPEND path (128 bytes max)
----------2FB706-----------------------------
INT 2F - DOS 4+ APPEND - GET APPEND FUNCTION STATE
	AX = B706h
Return: BX = APPEND state
	    bit 0: set if APPEND enabled
	    bits 1-11 reserved
	    bit 12: (DOS 5.0) set if APPEND applies directory search even if a
			drive has been specified
	    bit 13: set if /PATH flag active
	    bit 14: set if /E flag active (environment var APPEND exists)
	    bit 15: set if /X flag active
----------2FB707-----------------------------
INT 2F - DOS 4+ APPEND - SET APPEND FUNCTION STATE
	AX = B707h
	BX = APPEND state bits (see AX=B706h)
----------2FB710-----------------------------
INT 2F U - DOS 3.3+ APPEND - GET VERSION INFO
	AX = B710h
Return: AX = current APPEND state (see AX=B706h)
	BX = ??? (0000h in MSDOS 3.30 and 5.00)
	CX = ??? (0000h in MSDOS 3.30 and 5.00)
	DL = major version
	DH = minor version
SeeAlso: AX=B702h
----------2FB711-----------------------------
INT 2F - DOS 4+ APPEND - SET RETURN FOUND NAME STATE
	AX = B711h
Note:	if the next INT 21h call (and ONLY the next) is function 3Dh, 43h, or
	6Ch (also 4B03h and 4Eh if /X active), the fully qualified filename is
	written over top of the filename passed to the INT 21h call.  The
	application must provide a sufficiently large buffer.  This state is
	reset after the next INT 21h call processed by APPEND.
BUG:	DOS 4.0 APPEND reportedly overwrites DS:DX instead of DS:SI for
	  INT 21/AH=6Ch
SeeAlso: INT 21/AH=4Eh
----------2FB800-----------------------------
INT 2F - network - INSTALLATION CHECK
	AX = B800h
Return: AL = status
	    00h	    not installed
	    nonzero installed
	      BX = installed component flags (test in this order!)
		   bit 6   server
		   bit 2   messenger
		   bit 7   receiver
		   bit 3   redirector
----------2FB803-----------------------------
INT 2F - network - GET NETWORK EVENT POST HANDLER
	AX = B803h
Return: ES:BX -> event post handler (see AX=B804h)
SeeAlso: AX=B804h,AX=B903h
----------2FB804-----------------------------
INT 2F - network - SET NETWORK EVENT POST HANDLER
	AX = B804h
	ES:BX -> new event post handler
Notes:	used in conjunction with AX=B803h to hook into the network event post
	  routine
	The specified handler is called on any network event.  Two events are
	  defined: message received and critical network error.
SeeAlso: AX=B803h,AX=B904h

Values post routine is called with:
	AX = 0000h single block message
	    DS:SI -> ASCIZ originator name
	    DS:DI -> ASCIZ destination name
	    ES:BX -> text header (see below)
	AX = 0001h start multiple message block
	    CX = block group ID
	    DS:SI -> ASCIZ originator name
	    DS:DI -> ASCIZ destination name
	AX = 0002h multiple block text
	    CX = block group ID
	    ES:BX -> text header (see below)
	AX = 0003h end multiple block message
	    CX = block group ID
	AX = 0004h message aborted due to error
	    CX = block group ID
	AX = 0101h server received badly formatted network request
	    Return: AX = FFFFh (PC LAN will process error)
	AX = 0102h unexpected network error
	    ES:BX -> NCB (see INT 5C)
	AX = 0103h server received INT 24 error
	    other registers as for INT 24, except AH is in BH
	    Return: as below, but only 0000h and FFFFh allowed
Return:	AX = response code
	    0000h user post routine processed message
	    0001h PC LAN will process message, but message window not displayed
	    FFFFh PC LAN will process message
	
Format of text header:
Offset	Size	Description
 00h	WORD	length of text (maximum 512 bytes)
 02h  N BYTEs	text of message
Note:	all CRLF sequences in message text are replaced by 14h
----------2FB807-----------------------------
INT 2F - Network - GET NetBIOS NAME NUMBER OF MACHINE NAME
	AX = B807h
Return: CH = NetBIOS name number of the machine name
SeeAlso: INT 21/AX=5E00h
----------2FB808-----------------------------
INT 2F U - Network - RELINK KEYBOARD HANDLER
	AX = B808h
	ES:BX -> INT 09 handler network should call after it finishes INT 09
Notes:	this call replaces the address to which the network software chains on
	  an INT 09 without preserving the original value.  This allows a prior
	  handler to unlink, but does not allow a new handler to be added
	  such that the network gets the INT 09 first unless the new handler
	  completely takes over INT 09 and never chains.
	called by DOS 3.2 KEYBxx.COM
SeeAlso: AX=B908h
----------2FB809-----------------------------
INT 2F - LANtastic Network, NetWare Lite - VERSION CHECK
	AX = B809h
Return: AH = major version
	AL = minor version (decimal)
----------2FB900-----------------------------
INT 2F - PC Network RECEIVER.COM - INSTALLATION CHECK
	AX = B900h
Return: AL = 00h if not installed
	     FFh if installed
----------2FB901-----------------------------
INT 2F - PC Network RECEIVER.COM - GET RECEIVER.COM INT 2F HANDLER ADDRESS
	AX = B901h
Return: AL = ???
	ES:BX -> RECEIVER.COM INT 2F handler
Note:	allows more efficient execution by letting the caller bypass any other
	  INT 2F handlers which have been added since RECEIVER.COM was
	  installed
----------2FB903-----------------------------
INT 2F - PC Network RECEIVER.COM - GET RECEIVER.COM POST ADDRESS
	AX = B903h
Return: ES:BX -> POST handler
SeeAlso: AX=B803h,AX=B904h
----------2FB904-----------------------------
INT 2F - PC Network RECEIVER.COM - SET RECEIVER.COM POST ADDRESS
	AX = B904h
	ES:BX -> new POST handler
SeeAlso: AX=B804h,AX=B903h
----------2FB905-----------------------------
INT 2F - PC Network RECEIVER.COM - GET FILENAME
	AX = B905h
	DS:BX -> 128-byte buffer for filename 1
	DS:DX -> 128-byte buffer for filename 2
Return: buffers filled from RECEIVER.COM internal buffers
Note:	use of filenames is unknown, but one appears to be for storing messages
SeeAlso: AX=B906h
----------2FB906-----------------------------
INT 2F - PC Network RECEIVER.COM - SET FILENAME
	AX = B906h
	DS:BX -> 128-byte buffer for filename 1
	DS:DX -> 128-byte buffer for filename 2
Return: RECEIVER.COM internal buffers filled from user buffers
Note:	use of filenames is unknown, but one appears to be for storing messages
SeeAlso: AX=B905h
----------2FB908-----------------------------
INT 2F - PC Network RECEIVER.COM - UNLINK KEYBOARD HANDLER
	AX = B908h
	ES:BX -> INT 09 handler RECEIVER should call after it finishes INT 09
Note:	this call replaces the address to which RECEIVER.COM chains on an
	  INT 09 without preserving the original value.	 This allows a prior
	  handler to unlink, but does not allow a new handler to be added
	  such that RECEIVER gets the INT 09 first.
SeeAlso: AX=B808h
----------2FBC00-----------------------------
INT 2F - Windows 3.0, DOS 5.0 EGA.SYS - INSTALLATION CHECK
	AX = BC00h
Return: AL = 00h not installed, OK to install
	   = 01h not installed, not OK to install
	   = FFh installed
		BX = 5456h ("TV")
Note:	AH=BCh is the default value, which may be changed by a command line
	  parameter to any value between 80h and FFh
SeeAlso: AX=BC06h,INT 10/AH=FAh"EGA"
----------2FBC06-----------------------------
INT 2F U - MS Windows 3.0, DOS 5.0 EGA.SYS - GET VERSION INFO
	AX = BC06h
Return: BX = 5456h ("TV")
	CH = major version
	CL = minor version
	DL = revision
SeeAlso: AX=BC00h,INT 10/AH=FAh"EGA"
----------2FBE00-----------------------------
INT 2F - REDVIEW - INSTALLATION CHECK
	AX = BE00h
Return: AL = FFh if installed
Note:	REDVIEW is a public-domain TSR by Alexandr Novy and Petr Horak which
	  copies data sent to standard output to standard error when the
	  former has been redirected to a file, thus allowing the data to
	  be seen on the screen at the same time it is captured in a file
----------2FBF00-----------------------------
INT 2F - PC LAN PROGRAM REDIRIFS.EXE internal - INSTALLATION CHECK
	AX = BF00h
Return: AL = FFh if installed
----------2FBF01-----------------------------
INT 2F U - PC LAN PROGRAM REDIRIFS.EXE internal - ???
	AX = BF01h
	???
Return: ???
----------2FBF80-----------------------------
INT 2F - PC LAN PROG REDIR.SYS internal - SET REDIRIFS ENTRY POINT
	AX = BF80h
	ES:DI -> FAR entry point to IFS handler in REDIRIFS
Return: AL = FFh if installed
	    ES:DI -> internal workspace
Note:	all future IFS calls to REDIR.SYS are passed to the ES:DI entry point
---------------------------------------------
