---------------------------------------------
Interrupt List, part 4 of 5
This compilation is Copyright (c) 1989,1990,1991 Ralf Brown
----------2F---------------------------------
INT 2F - Multiplex - NOTES
	AH = identifier of program which is to handle the interrupt
	   00h-7Fh reserved for DOS
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
INT 2F - Multiplex - BMB Compuscience Canada Utilities Interface
	AH = xx (dynamically assigned based upon a search for a multiplex
		 number which doesn't answer installed)
	AL = 00h install check
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
----------2F00-------------------------------
INT 2F - Multiplex - DOS 2.x PRINT.COM - ???
	AH = 00h
	???
Return: ???
Notes:	DOS 2.x PRINT.COM does not chain to previous INT 2F handler
	values in AH other than 00h or 01h cause PRINT to return the number of
	  files in the queue in AH
SeeAlso: AH=01h
----------2F0080-----------------------------
INT 2F - Multiplex - DOS 3.1+ PRINT.COM - GIVE PRINT A TIME SLICE
	AX = 0080h
Return: after PRINT executes
----------2F01-------------------------------
INT 2F - Multiplex - DOS 2.x PRINT.COM - ???
	AH = 01h
	???
Return: ???
Notes:	DOS 2.x PRINT.COM does not chain to previous INT 2F handler
	values in AH other than 00h or 01h cause PRINT to return the number of
	  files in the queue in AH
SeeAlso: AH=00h
----------2F0100-----------------------------
INT 2F - Multiplex - DOS 3+ PRINT.COM - INSTALLATION CHECK
	AX = 0100h
Return: AL = status
	    00h not installed
	    01h not installed, but not OK to install
	    FFh installed
SeeAlso: AX=0101h
----------2F0101-----------------------------
INT 2F - Multiplex - DOS 3+ PRINT.COM - SUBMIT FILE FOR PRINTING
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
INT 2F - Multiplex - DOS 3+ PRINT.COM - REMOVE FILE FROM PRINT QUEUE
	AX = 0102h
	DS:DX -> ASCIZ filename (wildcards allowed)
Return: CF clear if successful
	CF set on error
	    AX = error code (see AX=0101h)
SeeAlso: AX=0101h,AX=0103h
----------2F0103-----------------------------
INT 2F - Multiplex - DOS 3+ PRINT.COM - CANCEL ALL FILES IN PRINT QUEUE
	AX = 0103h
Return: CF clear if successful
	CF set on error
	    AX = error code (see AX=0101h)
SeeAlso: AX=0102h
----------2F0104-----------------------------
INT 2F - Multiplex - DOS 3+ PRINT.COM - FREEZE PRINT QUEUE TO READ JOB STATUS
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
INT 2F - Multiplex - DOS 3+ PRINT.COM - RESTART PRINT QUEUE AFTER STATUS READ
	AX = 0105h
Return: CF clear if successful
	CF set on error
	    AX = error code (see AX=0101h)
SeeAlso: AX=0104h
----------2F0106-----------------------------
INT 2F - Multiplex - DOS 3.3+ PRINT.COM - GET PRINTER DEVICE
	AX = 0106h
Return: CF set if files in print queue
	    AX = error code 0008h (queue full)
	    DS:SI -> device driver header
	CF clear if print queue empty
	    AX = 0000h
Note:	documented for DOS 5+, but not documented for prior versions
SeeAlso: AX=0104h
----------2F0200-----------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - INSTALL CHECK
	AX = 0200h
Return: AL = FFh if installed
----------2F0201-----------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0201h
Return: nothing???
Notes:	called by DOS 3.3+ PRINT.COM
	AX=0202h appears to be the opposite function
SeeAlso: AX=0202h
----------2F0202-----------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0202h
	???
Return: nothing???
Note:	called by DOS 3.3+ PRINT.COM
SeeAlso: AX=0201h
----------2F0203-----------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0203h
Return: nothing???
Notes:	called by DOS 3.3+ PRINT.COM
	AX=0204h appears to be the opposite function
SeeAlso: AX=0204h
----------2F0204-----------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0204h
	???
Return: nothing???
Note:	called by DOS 3.3 PRINT.COM
----------2F---------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 02xxh
	???
Return: ???
----------2F0500-----------------------------
INT 2F - Multiplex - DOS 3+ CRITICAL ERROR HANDLER - INSTALLATION CHECK
	AX = 0500h
Return: AL = 00h not installed, OK to install
	     01h not installed, can't install
	     FFh installed
Note:	this set of functions allows a user program to partially or completely
	  override the default critical error handler's message in COMMAND.COM
SeeAlso: AH=05h,INT 24
----------2F05-------------------------------
INT 2F - Multiplex - DOS 3+ CRITICAL ERROR HANDLER - EXPAND ERROR INTO STRING
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
INT 2F - Multiplex - DOS 3+ ASSIGN - INSTALLATION CHECK
	AX = 0600h
Return: AL = status
	    00h not installed
	    01h not installed, but not OK to install
	    FFh installed
Note:	ASSIGN is not a TSR in DR-DOS 5.0; it is internally replaced by SUBST
	  (see INT 21/AX=2152h)
SeeAlso: AX=0601h,INT 21/AX=2152h
----------2F0601-----------------------------
INT 2F - Multiplex - DOS 3+ ASSIGN - GET DRIVE ASSIGNMENT TABLE
	AX = 0601h
Return: ES = segment of ASSIGN work area and assignment table
Note:	under DOS 3+, the 26 bytes starting at ES:0103h specify which drive
	  each of A: to Z: is mapped to.  Initially set to 01h 02h 03h....
SeeAlso: AX=0600h
----------2F0800-----------------------------
INT 2F - Multiplex - DRIVER.SYS support - INSTALLATION CHECK
	AX = 0800h
Return:	AL = 00h not installed, OK to install
	     01h not installed, not OK to install
	     FFh installed
----------2F0801-----------------------------
INT 2F - Multiplex - DRIVER.SYS support - ADD NEW BLOCK DEVICE
	AX = 0801h
	DS:DI -> drive data table (see AX=0803h)
Notes:	moves down internal list of drive data tables, copying and modifying
	  the drive description flags word for tables referencing same physical
	  drive
	data table appended to chain of tables
SeeAlso: AX=0803h
----------2F0802-----------------------------
INT 2F - Multiplex - DRIVER.SYS support - EXECUTE DEVICE DRIVER REQUEST
	AX = 0802h
	ES:BX -> device driver request header (see below)
Return: request header updated as per requested operation

Format of device driver request header:
Offset	Size	Description
 00h	BYTE	length of request header
 01h	BYTE	subunit within device driver
 02h	BYTE	command code (see below)
 03h	WORD	status (filled in by device driver)
		bit 15: error
		bits 14-11: reserved
		bit 10: ??? set by DOS kernel on entry to some driver calls
		bit 9: busy
		bit 8: done
		bits 7-0: error code if bit 15 set (see below)
---DOS---
 05h  8 BYTEs	reserved (unused in DOS 2.x and 3.x)
---STARLITE architecture---
 05h	DWORD	pointer to next request header
 09h  4 BYTEs	reserved
---command code 00h---
 0Dh	BYTE	number of units (set by driver)
 0Eh	DWORD	address of first free byte following driver (set by driver)
 12h	DWORD	pointer to BPB array (set by block drivers only)
 16h	BYTE	(DOS 3+) drive number for first unit of block driver (0=A)
---command code 01h---
 0Dh	BYTE	media descriptor
 0Eh	BYTE	returned status
		00h don't know
		01h media has not changed
		FFh media has been changed
 0Fh	DWORD	(DOS 3+) pointer to previous volume ID if OPEN/CLOSE/RM bit in
		  device header set and disk changed (set by driver)
---command code 02h---
 0Dh	BYTE	media descriptor
 0Eh	DWORD	transfer address
		-> scratch sector if NON-IBM FORMAT bit in device header set
		-> first FAT sector otherwise
 12h	DWORD	pointer to BPB (set by driver)
---command codes 03h,0Ch--- (see also INT 21/AX=4402h,INT 21/AX=4403h)
 0Dh	BYTE	media descriptor (block devices only)
 0Eh	DWORD	transfer address
 12h	WORD	byte count (character devices) or sector count (block devices)
 14h	WORD	starting sector number (block devices only)
 16h	DWORD	(DOS 3+) pointer to volume label if error 0Fh (set by driver)
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
---command codes 06h,07h,0Ah,0Bh,0Dh,0Eh,0Fh,85h,88h---
 no further fields
---command code 10h---
 0Dh	BYTE	unused
 0Eh	DWORD	transfer address
 12h	WORD	byte count
---command codes 13h,19h---
 0Dh	BYTE	category code
		00h unknown
		01h COMn:
		03h CON
		05h LPTn:
		08h disk
		9Eh (STARLITE) Media Access Control driver
 0Eh	BYTE	function code
		00h (STARLITE) MAC Bind request
 0Fh	WORD	copy of DS at time of IOCTL call (apparently unused in DOS 3.3)
 11h	WORD	offset of device driver header
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
	11h unused
	12h unused
	13h (DOS 3.2+) GENERIC IOCTL
	14h unused
	15h unused
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
----------2F0803-----------------------------
INT 2F - Multiplex - DOS 4+ DRIVER.SYS support - GET DRIVE DATA TABLE LIST
	AX = 0803h
Return: DS:DI -> first drive data table in list
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
 06h 25 BYTEs	BIOS Parameter Block (see DOS 4.01 drive data table below)
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
----------2F1000-----------------------------
INT 2F - Multiplex - SHARE - INSTALLATION CHECK
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
INT 2F - Multiplex - DOS 4 only SHARE internal - ???
	AX = 1040h
	???
Return: AL = FFh???
SeeAlso: AX=1000h
----------2F1080-----------------------------
INT 2F - Multiplex - DOS 4 only SHARE internal - TURN ON FILE SHARING CHECKS
	AX = 1080h
Return: AL = status
	    F0h successful
	    FFh checking was already on
Note:	DOS 4.x SHARE has dual functions: FCB support for large (>32M) media
	  and file sharing checks.  The undocumented commandline flag /NC can
	  be used to disable the sharing code.
SeeAlso: AX=1000h,AX=1081h
----------2F1081-----------------------------
INT 2F - Multiplex - DOS 4 only SHARE internal - TURN OFF FILE SHARING CHECKS
	AX = 1081h
Return: AL = status
	    F0h successful
	    FFh checking was already off
Note:	(see AX=1080h)
SeeAlso: AX=1000h,AX=1080h
----------2F1100-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - INSTALLATION CHECK
	AX = 1100h
Return: AL = 00h  not installed, OK to install
	     01h  not installed, not OK to install
	     FFh  installed
Notes:	called by DOS 3.1+ kernel
	In DOS 4.x only, the 11xx calls are all in IFSFUNC.EXE, not in the
	  PC LAN Program redirector; DOS 5.0 moves the calls back into the
	  redirector
----------2F1100-----------------------------
INT 2F - Multiplex - MSCDEX (MS CD-ROM Extensions) - INSTALLATION CHECK
	AX = 1100h
	STACK: WORD DADAh
Return: AL = 00h not installed, OK to install
		STACK unchanged
	   = 01h not installed, not OK to install
		STACK unchanged
	   = FFh installed
		STACK: WORD ADADh
----------2F1101-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - REMOVE REMOTE DIRECTORY
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
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - REMOVE REMOTE DIRECTORY
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
INT 2F - Multiplex - NETWORK REDIRECTOR - MAKE REMOTE DIRECTORY
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
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - MAKE REMOTE DIRECTORY
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
INT 2F - Multiplex - NETWORK REDIRECTOR - CHDIR
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
INT 2F - Multiplex - NETWORK REDIRECTOR - CLOSE REMOTE FILE
	AX = 1106h
	ES:DI -> SFT
	    SFT DPB field -> DPB of drive containing file
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
	CF clear if successful
	    SFT updated (except handle count, which DOS manages itself)
Note:	called by DOS 3.1+ kernel
SeeAlso: AX=1201h,AX=1227h,INT 21/AH=3Eh
----------2F1107-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - COMMIT REMOTE FILE
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
INT 2F - Multiplex - NETWORK REDIRECTOR - READ FROM REMOTE FILE
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
INT 2F - Multiplex - NETWORK REDIRECTOR - WRITE TO REMOTE FILE
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
INT 2F - Multiplex - NETWORK REDIRECTOR - LOCK REGION OF FILE
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
Notes:	called by DOS 3.1+ kernel
	the redirector is expected to resolve lock conflicts
SeeAlso: AX=110Bh,INT 21/AH=5Ch
----------2F110B-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR (DOS 3.x only) - UNLOCK REGION OF FILE
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
Note:	called by DOS 3.x kernel; DOS 4.0+ calls AX=110Ah instead
SeeAlso: AX=110Ah,INT 21/AH=5Ch
----------2F110C-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - GET DISK SPACE
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
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - ???
	AX = 110Dh
	SDA first filename pointer -> name of file
	???
Return: ???
Note:	appears to be similar to AX=110Fh
SeeAlso: AX=110Fh
----------2F110E-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - SET REMOTE FILE'S ATTRIBUTES
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
INT 2F - Multiplex - NETWORK REDIRECTOR - GET REMOTE FILE'S ATTRIBUTES AND SIZE
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
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - ???
	AX = 1110h
	SDA first filename pointer -> name of file
	???
Return: ???
Note:	appears to be similar to AX=110Eh
SeeAlso: AX=110Eh
----------2F1111-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - RENAME REMOTE FILE
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
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - ???
	AX = 1112h
	SS = DS = DOS DS
	SDA first filename pointer -> name of file
	???
Return: ???
SeeAlso: AX=1111h
----------2F1113-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - DELETE REMOTE FILE
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
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - ???
	AX = 1114h
	SDA first filename pointer -> name of file
	???
Return: ???
SeeAlso: AX=1113h
----------2F1115-----------------------------
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - ???
	AX = 1115h
	SS = DOS DS
	ES:DI -> SFT ???
	???
Return: ???
SeeAlso: AX=112Eh
----------2F1116-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - OPEN EXISTING REMOTE FILE
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
INT 2F - Multiplex - NETWORK REDIRECTOR - CREATE/TRUNCATE REMOTE FILE
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
INT 2F - Multiplex - NETWORK REDIRECTOR - CREATE/TRUNCATE FILE WITHOUT CDS
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
INT 2F - Multiplex - NETWORK REDIRECTOR - FIND FIRST FILE WITHOUT CDS
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
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - ???
	AX = 111Ah
	???
Return: CF set
	    AX = error code (03h for DOS 4.01 IFSFUNC)
----------2F111B-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - FINDFIRST
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
INT 2F - Multiplex - NETWORK REDIRECTOR - FINDNEXT
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
INT 2F - Multiplex - NETWORK REDIRECTOR - CLOSE ALL REMOTE FILES FOR PROCESS
	AX = 111Dh
	DS???
	SS = DOS DS
Return: ???
Notes:	called by DOS 3.1+ kernel
	closes all FCBs opened by process
----------2F111E-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - DO REDIRECTION
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
INT 2F - Multiplex - NETWORK REDIRECTOR - PRINTER SETUP
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
INT 2F - Multiplex - NETWORK REDIRECTOR - FLUSH ALL DISK BUFFERS
	AX = 1120h
	DS = DOS DS
	???
Return: CF clear (successful)
Notes:	called by DOS 3.1+ kernel
	uses CDS array pointer and LASTDRIVE= entries in DOS list of lists
SeeAlso: INT 21/AH=0Dh,INT 21/AX=5D01h
----------2F1121-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - SEEK FROM END OF REMOTE FILE
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
INT 2F - Multiplex - NETWORK REDIRECTOR - PROCESS TERMINATION HOOK
	AX = 1122h
	SS = DOS DS
	???
Return: ???
Note:	called by DOS 3.1+ kernel
----------2F1123-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - QUALIFY REMOTE FILENAME
	AX = 1123h
	DS:SI -> ASCIZ filename to canonicalize
	ES:DI -> 128-byte buffer for qualified name
Return: CF set if not resolved
Notes:	called by MSDOS 3.1+ kernel, but not called by DRDOS 5.0 unless the
	  filename matches the name of a character device
	called first when DOS attempts to resolve a filename (unless inside an
	  AX=5D00h server call); if this fails, DOS resolves the name locally
SeeAlso: AX=1221h,INT 21/AH=60h
----------2F1124-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - PRINTER OFF???
	AX = 1124h
	ES:DI -> SFT
	SS = DOS DS
	???
Return: CX = ???
Note:	called by DOS 3.1+ kernel if AX=1126h returns CF set
SeeAlso: AX=1126h
----------2F1125-----------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - REDIRECTED PRINTER MODE
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
INT 2F - Multiplex - NETWORK REDIRECTOR - PRINTER ON/OFF???
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
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - UNUSED
	AX = 1127h
Return: CF set
	    AX = 0001h (invalid function) (see INT 21/AH=59h)
----------2F1128-----------------------------
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - UNUSED
	AX = 1128h
Return: CF set
	    AX = 0001h (invalid function) (see INT 21/AH=59h)
----------2F1129-----------------------------
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - UNUSED
	AX = 1129h
Return: CF set
	    AX = 0001h (invalid function) (see INT 21/AH=59h)
----------2F112A-----------------------------
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - ???
	AX = 112Ah
	DS = DOS DS
	???
Return: ???
Note:	does something to each IFS driver
----------2F112B-----------------------------
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - GENERIC IOCTL???
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
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - ???
	AX = 112Ch
	SS = DOS DS
	SDA current SFT pointer -> SFT for file
	???
Return: CF set on error
----------2F112D-----------------------------
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - ???
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
INT 2F - Multiplex - DOS 4+ - EXTENDED OPEN/CREATE FILE
	AX = 112Eh
	SS = DS = DOS DS
	ES:DI -> uninitialized SFT for file
	STACK: WORD file attribute for created/truncated file
			low byte = file attributes
			high byte = 00h normal create/open, 01h create new file
	SDA first filename pointer -> fully-qualified filename
	SDA extended file open action -> action code (see INT 21/AX=6C00h)
	SDA extended file open mode -> open mode for file (see INT 21/AX=6C00h)
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
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - ???
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
INT 2F - Multiplex - DOS 4.x only IFSFUNC.EXE - GET IFSFUNC SEGMENT
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
INT 2F - Multiplex - DOS 3+ internal - INSTALLATION CHECK
	AX = 1200h
Return: AL = FFh (for compatibility with other INT 2F functions)
----------2F1201-----------------------------
INT 2F - Multiplex - DOS 3+ internal - CLOSE CURRENT FILE
	AX = 1201h
	SS = DOS DS
	SDA current SFT pointer -> SFT of file to close
Return: CF set on error
	BX???
	CX new reference count of SFT
	ES:DI -> SFT for file
SeeAlso: AX=1106h,AX=1227h,INT 21/AH=3Eh
----------2F1202-----------------------------
INT 2F - Multiplex - DOS 3+ internal - GET INTERRUPT ADDRESS
	AX = 1202h
	STACK: WORD vector number
Return: ES:BX -> interrupt vector
	STACK unchanged
----------2F1203-----------------------------
INT 2F - Multiplex - DOS 3+ internal - GET DOS DATA SEGMENT
	AX = 1203h
Return: DS = segment of IBMDOS.COM/MSDOS.SYS
----------2F1204-----------------------------
INT 2F - Multiplex - DOS 3+ internal - NORMALIZE PATH SEPARATOR
	AX = 1204h
	STACK: WORD character to normalize
Return: AL = normalized character (forward slash turned to backslash, all
		others unchanged)
	ZF set if path separator
	STACK unchanged
----------2F1205-----------------------------
INT 2F - Multiplex - DOS 3+ internal - OUTPUT CHARACTER TO STANDARD OUTPUT
	AX = 1205h
	STACK: WORD character to output
Return: STACK unchanged
Note:	can be called only from within DOS
----------2F1206-----------------------------
INT 2F - Multiplex - DOS 3+ internal - INVOKE CRITICAL ERROR
	AX = 1206h
	DI = error code
	BP:SI -> device driver header
	SS = DOS DS
	STACK: WORD value to be passed to INT 24 in AX
Return: AL = 0-3 for Abort, Retry, Ignore, Fail
	STACK unchanged
SeeAlso: INT 24
----------2F1207-----------------------------
INT 2F - Multiplex - DOS 3+ internal - MAKE DISK BUFFER MOST-RECENTLY USED
	AX = 1207h
	DS:DI -> disk buffer
Return: nothing
Notes:	can be called only from within DOS
	buffer is moved to end of buffer list (least-recently used is first)
SeeAlso: AX=120Fh
----------2F1208-----------------------------
INT 2F - Multiplex - DOS 3+ internal - DECREMENT SFT REFERENCE COUNT
	AX = 1208h
	ES:DI -> SFT
Return: AX = original value of reference count
Note:	if the reference count was 1, it is set to FFFFh (since 0 indicates
	  that the SFT is not in use).	It is the caller's responsibility to
	  set the reference count to zero after cleaning up.
----------2F1209-----------------------------
INT 2F - Multiplex - DOS 3+ internal - FLUSH AND FREE DISK BUFFER
	AX = 1209h
	DS:DI -> disk buffer
Return: disk buffer marked unused, contents written to disk if buffer dirty
Note:	can be called only from within DOS
SeeAlso: AX=120Eh,AX=1215h
----------2F120A-----------------------------
INT 2F - Multiplex - DOS 3+ internal - PERFORM CRITICAL ERROR INTERRUPT
	AX = 120Ah
	DS = SS = DOS DS
	STACK: WORD extended error code
Return: AL = user response (0=ignore, 1=retry, 2=abort, 3=fail)
	CF clear if retry, set otherwise
	STACK unchanged
Notes:	can only be called during a DOS function call, as it uses various
	  fields in the SDA to set up the registers for the INT 24
	reportedly sets current DPB's first root directory sector to 1
SeeAlso: INT 24
----------2F120B-----------------------------
INT 2F - Multiplex - DOS 3+ internal - SIGNAL SHARING VIOLATION TO USER
	AX = 120Bh
	ES:DI -> system file table entry for previous open of file
	STACK: WORD extended error code (should be 20h--sharing violation)
Return: CF clear if operation should be retried
	CF set if operation should not be retried
	    AX = error code (20h) (see AH=59h)
	STACK unchanged
Notes:	can only be called during a DOS function call
	should only be called if an attempt was made to open an already-open
	  file contrary to the sharing rules
	invokes INT 24 if SFT file opened via FCB or in compatibility mode with
	  inheritance allowed
----------2F120C-----------------------------
INT 2F - Multiplex - DOS 3+ internal - OPEN DEVICE AND SET SFT OWNER???
	AX = 120Ch
	SDA current SFT pointer -> SFT for file
	DS = SS = DOS DS
Return: ES, DI, AX destroyed
Notes:	invoked "device open" call on device driver for SFT
	changes owner of last-accessed SFT to calling process if it was opened
	  via FCB
	called by network redirectors
----------2F120D-----------------------------
INT 2F - Multiplex - DOS 3+ internal - GET DATE AND TIME
	AX = 120Dh
	SS = DOS DS
Return: AX = current date in packed format (see INT 21/AX=5700h)
	DX = current time in packed format (see INT 21/AX=5700h)
SeeAlso: INT 21/AH=2Ah,INT 21/AH=2Ch
----------2F120E-----------------------------
INT 2F - Multiplex - DOS 3+ internal - MARK ALL DISK BUFFERS UNREFERENCED
	AX = 120Eh
	SS = DOS DS
Return: DS:DI -> first disk buffer
Note:	clears "referenced" flag on all disk buffers
SeeAlso: AX=1209h,AX=1210h,INT 21/AH=0Dh
----------2F120F-----------------------------
INT 2F - Multiplex - DOS 3+ internal - MAKE BUFFER MOST RECENTLY USED
	AX = 120Fh
	DS:DI -> disk buffer
	SS = DOS DS
Return: DS:DI -> next buffer in buffer list
Note:	indicated buffer moved to end of chain
SeeAlso: AX=1207h
----------2F1210-----------------------------
INT 2F - Multiplex - DOS 3+ internal - FIND UNREFERENCED DISK BUFFER
	AX = 1210h
	DS:DI -> first disk buffer to check
Return: ZF clear if found
	    DS:DI -> first unreferenced disk buffer
	ZF set if not found
SeeAlso: AX=120Eh
----------2F1211-----------------------------
INT 2F - Multiplex - DOS 3+ internal - NORMALIZE ASCIZ FILENAME
	AX = 1211h
	DS:SI -> ASCIZ filename to normalize
	ES:DI -> buffer for normalized filename
Return: destination buffer filled with uppercase filename, with slashes turned
	to backslashes
SeeAlso: AX=121Eh,AX=1221h
----------2F1212-----------------------------
INT 2F - Multiplex - DOS 3+ internal - GET LENGTH OF ASCIZ STRING
	AX = 1212h
	ES:DI -> ASCIZ string
Return: CX = length of string
SeeAlso: AX=1225h
----------2F1213-----------------------------
INT 2F - Multiplex - DOS 3+ internal - UPPERCASE CHARACTER
	AX = 1213h
	STACK: WORD character to convert to uppercase
Return: AL = uppercase character
	STACK unchanged
----------2F1214-----------------------------
INT 2F - Multiplex - DOS 3+ internal - COMPARE FAR POINTERS
	AX = 1214h
	DS:SI = first pointer
	ES:DI = second pointer
Return: ZF set if pointers are equal, ZF clear if not equal
----------2F1215-----------------------------
INT 2F - Multiplex - DOS 3+ internal - FLUSH BUFFER
	AX = 1215h
	DS:DI -> disk buffer
	SS = DOS DS
	STACK: WORD drives for which to skip buffer
		ignore buffer if drive same as high byte, or bytes differ and
		the buffer is for a drive OTHER than that given in low byte
Return: STACK unchanged
Note:	can be called only from within DOS
SeeAlso: AX=1209h
----------2F1216-----------------------------
INT 2F - Multiplex - DOS 3+ internal - GET ADDRESS OF SYSTEM FILE TABLE
	AX = 1216h
	BX = system file table entry number
Return: CF clear if successful
	    ES:DI -> system file table entry
	CF set if BX greater than FILES=
SeeAlso: AX=1220h
----------2F1217-----------------------------
INT 2F - Multiplex - DOS 3+ internal - GET CURRENT DIRECTRY STRUCTURE FOR DRIVE
	AX = 1217h
	SS = DOS DS
	STACK: WORD drive (0 = A:, 1 = B:, etc)
Return: CF set on error
	    (drive > LASTDRIVE)
	CF clear if successful
	    DS:SI -> current directory structure for specified drive
	STACK unchanged
SeeAlso: AX=1219h
----------2F1218-----------------------------
INT 2F - Multiplex - DOS 3+ internal - GET CALLER'S REGISTERS
	AX = 1218h
Return: DS:SI -> saved caller's AX,BX,CX,DX,SI,DI,BP,DS,ES (on stack)
Note:	only valid while within DOS
----------2F1219-----------------------------
INT 2F - Multiplex - DOS 3+ internal - SET DRIVE???
	AX = 1219h
	SS = DOS DS
	STACK: WORD drive (0 = default, 1 = A:, etc)
Return: ???
	STACK unchanged
Notes:	calls AX=1217h
	builds a current directory structure if inside server call
	  (INT 21/AX=5D00h)
SeeAlso: AX=1217h,AX=121Fh
----------2F121A-----------------------------
INT 2F - Multiplex - DOS 3+ internal - GET FILE'S DRIVE
	AX = 121Ah
	DS:SI -> filename
Return: AL = drive (0 = default, 1 = A:, etc, FFh = invalid)
	DS:SI -> filename without leading X: (if present)
SeeAlso: INT 21/AH=19h,INT 21/AH=60h
----------2F121B-----------------------------
INT 2F - Multiplex - DOS 3+ internal - SET YEAR/LENGTH OF FEBRUARY
	AX = 121Bh
	CL = year - 1980
Return: AL = number of days in February
Note:	requires DS to be set to the DOS code segment
SeeAlso: INT 21/AH=2Bh
----------2F121C-----------------------------
INT 2F - Multiplex - DOS 3+ internal - CHECKSUM MEMORY
	AX = 121Ch
	DS:SI -> start of memory to checksum
	CX = number of bytes
	DX = initial checksum
	SS = DOS DS
Return: AX, CX destroyed
	DX = checksum
	DS:SI -> first byte after checksummed range
Note:	used by DOS to determine day count since 1/1/80 given a date
SeeAlso: AX=121Dh
----------2F121D-----------------------------
INT 2F - Multiplex - DOS 3+ internal - SUM MEMORY
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
INT 2F - Multiplex - DOS 3+ internal - COMPARE FILENAMES
	AX = 121Eh
	DS:SI -> first ASCIZ filename
	ES:DI -> second ASCIZ filename
Return: ZF set if filenames equivalent, ZF clear if not
SeeAlso: AX=1211h,AX=1221h
----------2F121F-----------------------------
INT 2F - Multiplex - DOS 3+ internal - BUILD CURRENT DIRECTORY STRUCTURE
	AX = 121Fh
	SS = DOS DS
	STACK: WORD drive letter
Return: ES:DI -> current directory structure (will be overwritten by next call)
	STACK unchanged
----------2F1220-----------------------------
INT 2F - Multiplex - DOS 3+ internal - GET JOB FILE TABLE ENTRY
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
INT 2F - Multiplex - DOS 3+ internal - CANONICALIZE FILE NAME
	AX = 1221h
	DS:SI -> file name to be fully qualified
	ES:DI -> 128-byte buffer for resulting canonical file name
	SS = DOS DS
Return: (see INT 21/AH=60h)
Note:	identical to INT 21/AH=60h
SeeAlso: AX=1123h,INT 21/AH=60h
----------2F1222-----------------------------
INT 2F - Multiplex - DOS 3+ internal - SET EXTENDED ERROR INFO
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
INT 2F - Multiplex - DOS 3+ internal - CHECK IF CHARACTER DEVICE
	AX = 1223h
	SDA+218h (DOS 3.10-3.30) = eight-character blank-padded name
	SDA+22Bh (DOS 4.0x) = eight-character blank-padded name
Return: CF set if no character device by that name found
	CF clear if found
	    BH = low byte of device attribute word
Note:	can only be called from within DOS (assumes DS=SS=DOS DS)
SeeAlso: INT 21/AX=5D06h,INT 21/AX=5D0Bh
----------2F1224-----------------------------
INT 2F - Multiplex - DOS 3+ internal - DELAY
	AX = 1224h
	SS = DOS DS
Return: after delay set by INT 21/AX=440Bh, unless in server call
	  (INT 21/AX=5D00h)
Note:	delay is dependent on the processor speed, and is skipped entirely if
	  inside a server call
SeeAlso: INT 21/AX=440Bh,INT 21/AH=52h
----------2F1225-----------------------------
INT 2F - Multiplex - DOS 3+ internal - GET LENGTH OF ASCIZ STRING
	AX = 1225h
	DS:SI -> ASCIZ string
Return: CX = length of string
SeeAlso: AX=1212h
----------2F1226-----------------------------
INT 2F - Multiplex - DOS 3.3+ internal - OPEN FILE
	AX = 1226h
	CL = access mode
	DS:DX -> ASCIZ filename
Return: CF set on error
	    AL = error code (see INT 21/AH=59h)
	CF clear if successful
	    AX = file handle
Notes:	can only be called from within DOS (assumes SS=DOS DS)
	equivalent to INT 21/AH=3Dh	
SeeAlso: AX=1227h,INT 21/AH=3Dh
----------2F1227-----------------------------
INT 2F - Multiplex - DOS 3.3+ internal - CLOSE FILE
	AX = 1227h
	BX = file handle
Return: CF set on error
	    AL = 06h invalid file handle
	CF clear if successful
Notes:	can only be called from within DOS (assumes SS=DOS DS)
	equivalent to INT 21/AH=3Eh
SeeAlso: AX=1106h,AX=1201h,AX=1226h,INT 21/AH=3Eh
----------2F1228BP4200-----------------------
INT 2F - Multiplex - DOS 3.3+ internal - MOVE FILE POINTER
	AX = 1228h
	BP = 4200h, 4201h, 4202h (see INT 21/AH=42h)
	BX = file handle
	CX:DX = offset in bytes
	SS = DOS DS
Return: as for INT 21/AH=42h
Notes:	equivalent to INT 21/AH=42h, but may only be called from inside a DOS
	  function call
	sets user stack frame pointer to dummy buffer, moves BP to AX, performs
	  LSEEK, and restores frame pointer
SeeAlso: INT 21/AH=42h
----------2F1229-----------------------------
INT 2F - Multiplex - DOS 3.3+ internal - READ FROM FILE
	AX = 1229h
	BX = file handle
	CX = number of bytes to read
	DS:DX -> buffer
	SS = DOS DS
Return: as for INT 21/AH=3Fh
Note:	equivalent to INT 21/AH=3Fh, but may only be called when already inside
	  a DOS function call
SeeAlso: AX=1226h,INT 21/AH=3Fh
----------2F122A-----------------------------
INT 2F - Multiplex - DOS 3.3+ internal - SET FASTOPEN ENTRY POINT
	AX = 122Ah
	BX = entry point to set (0001h or 0002h)
	DS:SI -> FASTOPEN entry point
		(entry point not set if SI = FFFFh for DOS 4+)
Return: CF set if specified entry point already set
Notes:	entry point in BX is ignored under DOS 3.30
	both entry points set to same handler by DOS 4.01

DOS 3.30 FASTOPEN is called with:
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
----------2F122B-----------------------------
INT 2F - Multiplex - DOS 3.3+ internal - IOCTL
	AX = 122Bh
	BP = 44xxh
	SS = DOS DS
	additional registers as appropriate for INT 21/AX=44xxh
Return: as for INT 21/AH=44h
Notes:	equivalent to INT 21/AH=44h, but may only be called when already inside
	  a DOS function call
	sets user stack frame pointer to dummy buffer, moves BP to AX, performs
	  IOCTL, and restores frame pointer
SeeAlso: INT 21/AH=44h
----------2F122C-----------------------------
INT 2F - Multiplex - DOS 3.3+ internal - GET DEVICE CHAIN
	AX = 122Ch
Return: BX:AX -> header of second device driver (NUL is first) in driver chain
SeeAlso: INT 21/AH=52h
----------2F122D-----------------------------
INT 2F - Multiplex - DOS 3.3+ internal - GET EXTENDED ERROR CODE
	AX = 122Dh
Return: AX = current extended error code
SeeAlso: AX=1222h,INT 21/AH=59h
----------2F122E-----------------------------
INT 2F - Multiplex - DOS 4+ internal - GET OR SET ERROR TABLE ADDRESSES
	AX = 122Eh
	DL = subfunction
	    00h get standard DOS error table (errors 00h-12h,50h-5Bh)
		Return: ES:DI -> error table
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
	DOS 5.0 COMMAND.COM does not allow setting any of the addresses; they
	  are always returned with segment 0001h
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
Note:	this function needs to access COMMAND.COM if the messages were not
	  loaded into memory permanently with /MSG; the caller should assume
	  that the returned message will be overwritten by the next call of
	  the function
----------2F122F-----------------------------
INT 2F - Multiplex - DOS 4+ internal - SET DOS VERSION NUMBER TO RETURN
	AX = 122Fh
	DX = DOS version number (0000h = return true DOS version)
SeeAlso: INT 21/AH=30h
----------2F13-------------------------------
INT 2F - Multiplex - DOS 3.3+ - SET DISK INTERRUPT HANDLER
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
INT 2F - Multiplex - NLSFUNC.COM - INSTALLATION CHECK
	AX = 1400h
Return: AL = 00h not installed, OK to install
	     01h not installed, not OK
	     FFh installed
Notes:	called by DOS v3.3+ kernel
	supported by OS/2 v1.3+ compatibility box, which always returns AL=FFh
	documented for DOS 5.0, but undocumented in prior versions
----------2F1401-----------------------------
INT 2F - Multiplex - NLSFUNC.COM - CHANGE CODE PAGE
	AX = 1401h
	DS:SI -> internal code page structure (see below)
	BX = new code page
	DX = country code???
Return: AL = status
	     00h successful
	     else DOS error code
Note:	called by DOS v3.3+ kernel
SeeAlso: INT 21/AH=66h

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
----------2F1402-----------------------------
INT 2F - Multiplex - NLSFUNC.COM - GET COUNTRY INFO
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
SeeAlso: AX=1403h,AX=1404h,INT 21/AH=65h
----------2F1403-----------------------------
INT 2F - Multiplex - NLSFUNC.COM - SET COUNTRY INFO
	AX = 1403h
	DS:SI -> internal code page structure (see AX=1401h)
	BX = code page
	DX = country code
Return: AL = status 
	     ???
Note:	called by DOS v3.3+ kernel on INT 21/AH=38h
SeeAlso: AX=1402h,AX=1404h,INT 21/AH=38h"SET"
----------2F1404-----------------------------
INT 2F - Multiplex - NLSFUNC.COM - GET COUNTRY INFO
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
----------2F1500-----------------------------
INT 2F - Multiplex - DOS 4.00 GRAPHICS.COM - INSTALLATION CHECK
	AX = 1500h
Return: AX = FFFFh
	ES:DI -> ??? (graphics data?)
Note:	this installation check conflicts with the CD-ROM Extensions
	  installation check; moved to AX=AC00h in later versions
SeeAlso: AX=AC00h
----------2F1500BX0000-----------------------
INT 2F - Multiplex - CD-ROM - INSTALLATION CHECK
	AX = 1500h
	BX = 0000h
Return: BX = number of CD-ROM drive letters used
	CX = starting drive letter (0=A:)
Notes:	this installation check DOES NOT follow the format used by other
	  software
	this installation check conflicts with the DOS 4.00 GRAPHICS.COM
	  installation check
----------2F1501-----------------------------
INT 2F - Multiplex - CD-ROM - GET DRIVE DEVICE LIST
	AX = 1501h
	ES:BX -> buffer to hold drive letter list (5 bytes per drive letter)
Return: buffer filled, for each drive letter
	  BYTE	subunit number in driver
	  DWORD address of device driver header
----------2F1502-----------------------------
INT 2F - Multiplex - CD-ROM - GET COPYRIGHT FILE NAME
	AX = 1502h
	ES:BX -> 38-byte buffer for name of copyright file
	CX = drive number (0=A:)
Return: CF set if drive is not a CD-ROM drive
	    AX = 15 (invalid drive)
	CF clear if successful
SeeAlso: AX=1503h
----------2F1503-----------------------------
INT 2F - Multiplex - CD-ROM - GET ABSTRACT FILE NAME
	AX = 1503h
	ES:BX -> 38-byte buffer for name of abstract file
	CX = drive number (0=A:)
Return: CF set if drive is not a CD-ROM drive
	    AX = 15 (invalid drive)
	CF clear if successful
SeeAlso: AX=1502h
----------2F1504-----------------------------
INT 2F - Multiplex - CD-ROM - GET BIBLIOGRAPHIC DOC FILE NAME
	AX = 1504h
	ES:BX -> 38-byte buffer for name of bibliographic documentation file
	CX = drive number (0=A:)
Return: CF set if drive is not a CD-ROM drive
	    AX = 15 (invalid drive)
	CF clear if successful
----------2F1505-----------------------------
INT 2F - Multiplex - CD-ROM - READ VTOC
	AX = 1505h
	ES:BX -> 2048-byte buffer
	CX = drive number (0=A:)
	DX = sector index (0=first volume descriptor,1=second,...)
Return: CF set on error
	    AX = error code (15=invalid drive,21=not ready)
	CF clear if successful
	    AX = volume descriptor type (1=standard,FFh=terminator,0=other)
----------2F1506-----------------------------
INT 2F - Multiplex - CD-ROM - TURN DEBUGGING ON
	AX = 1506h
	BX = debugging function to enable
Note:	reserved for development
SeeAlso: AX=1507h
----------2F1507-----------------------------
INT 2F - Multiplex - CD-ROM - TURN DEBUGGING OFF
	AX = 1507h
	BX = debugging function to disable
Note:	reserved for development
SeeAlso: AX=1506h
----------2F1508-----------------------------
INT 2F - Multiplex - CD-ROM - ABSOLUTE DISK READ
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
INT 2F - Multiplex - CD-ROM - ABSOLUTE DISK WRITE
	AX = 1509h
	ES:BX -> buffer
	CX = drive number (0=A:)
	SI:DI = starting sector number
	DX = number of sectors to write
Note:	corresponds to INT 26h and is currently reserved and nonfunctional
SeeAlso: AX=1508h
----------2F150A-----------------------------
INT 2F - Multiplex - CD-ROM - RESERVED
	AX = 150Ah
----------2F150B-----------------------------
INT 2F - Multiplex - CD-ROM 2.00 - DRIVE CHECK
	AX = 150Bh
	CX = drive number (0=A:)
Return: BX = ADADh if MSCDEX.EXE installed
	    AX = 0000h if drive not supported
		nonzero if supported
SeeAlso: AX=150Dh
----------2F150C-----------------------------
INT 2F - Multiplex - CD-ROM 2.00 - GET MSCDEX.EXE VERSION
	AX = 150Ch
Return: BH = major version
	BL = minor version
Note:	MSCDEX.EXE versions prior to 2.00 return BX=0
----------2F150D-----------------------------
INT 2F - Multiplex - CD-ROM 2.00 - GET CD-ROM DRIVE LETTERS
	AX = 150Dh
	ES:BX -> buffer for drive letter list (1 byte per drive)
Return: buffer filled with drive numbers (0=A:).  Each byte corresponds
	to the drive in the same position for function 1501h
SeeAlso: AX=150Bh
----------2F150E-----------------------------
INT 2F - Multiplex - CD-ROM 2.00 - GET/SET VOLUME DESCRIPTOR PREFERENCE
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
INT 2F - Multiplex - CD-ROM 2.00 - GET DIRECTORY ENTRY
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
INT 2F - Multiplex - CD-ROM 2.10 - SEND DEVICE DRIVER REQUEST
	AX = 1510h
	CX = CD-ROM drive letter (0 = A, 1 = B, etc)
	ES:BX -> CD-ROM device driver request header (see AX=0802h)
----------2F1600-----------------------------
INT 2F - Multiplex - MS WINDOWS - WINDOWS ENHANCED MODE INSTALLATION CHECK
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
INT 2F - Multiplex - MS WINDOWS/386 2.x - GET API ENTRY POINT
	AX = 1602h
Return: ES:DI -> Windows/386 2.x API procedure entry point
Notes:	this interface is supported in Windows 3.x only for 2.x compatibility
	to get the current virtual machine (VM) ID in Windows/386 2.x:
	    AX = 0000h
	    ES:DI -> return address
	    JUMP to address returned from INT 2F/AX=1602h
	After JUMP, at return address:
	    BX = current VM ID.
----------2F1605-----------------------------
INT 2F - Multiplex - MS WINDOWS - WINDOWS ENH MODE & 286 DOSX INIT BROADCAST
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
INT 2F - Multiplex - MS WINDOWS - WINDOWS ENH MODE & 286 DOSX EXIT BROADCAST
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
INT 2F - Multiplex - MS WINDOWS - VIRTUAL DEVICE CALL OUT API
	AX = 1607h
	BX = virtual device ID (see INT 2F/AX=1684h)
Note:	more of a convention than an API, this call specifies a standard
	  mechanism for Windows enhanced-mode virtual devices (VxD's) to talk
	  to DOS device drivers and TSRs
SeeAlso: AX=1605h,AX=1684h
----------2F1608-----------------------------
INT 2F - Multiplex - MS WINDOWS - WINDOWS ENHANCED MODE INIT COMPLETE BROADCAST
	AX = 1608h
Notes:	called after all installable devices have been initialized
	real-mode software may be called between the Windows enhanced-mode init
	  call (AX=1605h) and this call; the software must detect this
	  situation
SeeAlso: AX=1605h,AX=1609h
----------2F1609-----------------------------
INT 2F - Multiplex - MS WINDOWS - WINDOWS ENHANCED MODE BEGIN EXIT BROADCAST
	AX = 1609h
Note:	called at the beginning of a normal exit sequence; not made in the
	  event of a fatal system crash
SeeAlso: AX=1606h,AX=1608h
----------2F1680-----------------------------
INT 2F - Multiplex - various - RELEASE CURRENT VIRTUAL MACHINE TIME-SLICE
	AX = 1680h
Return: AL = 00h if the call is supported
	AL = 80h (unchanged) if the call is not supported
Notes:	programs can use this function in idle loops to enhance performance
	  under multitaskers; this call is supported by MS Windows 3.0, DOS 5+,
	  DPMI 1.0+, and will be supported in OS/2 2.0 for multitasking DOS
	  applications
	does not block the program; it just gives up the remainder of the time
	  slice
	should not be used by Windows programs
SeeAlso: INT 15/AX=1000h
----------2F1681-----------------------------
INT 2F - Multiplex - MS WINDOWS 3+ - BEGIN CRITICAL SECTION
	AX = 1681h
Notes:	used to prevent a task switch from occurring
	should be followed by an INT 2F/AX=1682h call as soon as possible
	nested calls are allowed, and must be followed by an appropriate number
	  of "end critical section" calls
	not supported in Windows/386 2.x. Get INDOS flag with INT 21/AH=34h and
	  and increment by hand.
SeeAlso: AX=1682h,INT 15/AX=101Bh,INT 21/AH=34h
----------2F1682-----------------------------
INT 2F - Multiplex - MS WINDOWS 3+ - END CRITICAL SECTION
	AX = 1682h
Notes:	not supported in Windows/386 2.x.  Get InDOS flag with INT 21/AH=34h
	  and decrement by hand, taking care not to decrement InDOS flag
	  through zero
SeeAlso: AX=1681h,INT 15/AX=101Ch,INT 21/AH=34h
----------2F1683-----------------------------
INT 2F - Multiplex - MS WINDOWS 3+ - GET CURRENT VIRTUAL MACHINE ID
	AX = 1683h
Return: BX = current virtual machine (VM) ID
Notes:	Windows itself currently runs in VM 1, but this can't be relied upon
	VM IDs are reused when VMs are destroyed
	an ID of 0 will never be returned
SeeAlso: AX=1684h,AX=1685h
----------2F1684-----------------------------
INT 2F - Multiplex - MS WINDOWS - GET DEVICE API ENTRY POINT
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
----------2F1685-----------------------------
INT 2F - Multiplex - MS WINDOWS - SWITCH VMs AND CALLBACK
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
INT 2F - Multiplex - DOS Protected-Mode Interface - DETECT MODE
	AX = 1686h
Return: AX = 0000h if operating in protected mode under DPMI (INT 31 available)
	AX nonzero if in real/V86 mode or no DPMI (INT 31 not available)
SeeAlso: AX=1687h
----------2F1687-----------------------------
INT 2F - Multiplex - DOS Protected-Mode Interface - INSTALLATION CHECK
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
SeeAlso: AX=1686h

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
----------2F168A-----------------------------
INT 2F - Multiplex - DPMI 0.9+ - GET VENDOR-SPECIFIC API ENTRY POINT
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
----------2F1700-----------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - IDENTIFY WinOldAp VERSION
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
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - OPEN CLIPBOARD
	AX = 1701h
Return:	AX <> 0	 success
	AX = 0	 clipboard is already open
----------2F1702-----------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - EMPTY CLIPBOARD
	AX = 1702h
Return: AX <> 0	 clipboard has been emptied
	AX = 0	 failure
----------2F1703-----------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - SET CLIPBOARD DATA
	AX = 1703h
	DX = clipboard format supported by WinOldAp:
		01h text
		02h bitmap
		03h metafile picture
		04h SYLK
		05h DIF
		06h TIFF
		07h OEM text
	ES:BX -> data (see below for formats)
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
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - GET CLIPBOARD DATA SIZE
	AX = 1704h
	DX = clipboard format supported by WinOldAp (see AX=1703h)
Return:	 DX:AX = size of data in bytes, including any headers
Failure: DX:AX = 0  no data in this format in the Clipboard
----------2F1705-----------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - GET CLIPBOARD DATA
	AX = 1705h
	DX = clipboard format supported by WinOldAp (see AX=1703h)
	ES:BX -> buffer
Return: AX <> 0	 success
	AX = 0	 error, or no data in this format in Clipboard
----------2F1708-----------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - CloseClipboard
	AX = 1708h
Return: AX <> 0 success
	AX = 0 failure
----------2F1709-----------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - COMPACT CLIPBOARD
	AX = 1709h
	SI:CX = desired size in bytes
Return: DX:AX = number of bytes in largest block of free memory
Note:	WinOldAp is responsible for including the size of any headers
----------2F170A-----------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - GET DEVICE CAPABILITIES
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
INT 2F - Multiplex - DOS 4.x only SHELLB.COM - INSTALLATION CHECK
	AX = 1900h
Return: AL = 00h  not installed
	     FFh  installed
----------2F1901BL00-------------------------
INT 2F - Multiplex - DOS 4.x only SHELLB.COM - SHELLC.EXE INTERFACE
	AX = 1901h
	BL = 00h if SHELLC transient
	     01h if SHELLC resident
	DS:DX -> far call entry point for resident SHELLC.EXE
Return: ES:DI -> SHELLC.EXE workspace within SHELLB.COM
Note:	SHELLB.COM and SHELLC.EXE are parts of the DOS 4.x shell
----------2F1902-----------------------------
INT 2F - Multiplex - DOS 4.x only SHELLB.COM - COMMAND.COM INTERFACE
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
INT 2F - Multiplex - DOS 4.x only SHELLB.COM - COMMAND.COM interface
	AX = 1903h
	ES:DI -> ASCIZ batch file name as for AX=1902h
Return: AL = FFh if quoted batch file name matches last SHELLB parameter
	AL = 00h if it does not
----------2F1904-----------------------------
INT 2F - Multiplex - DOS 4.x only SHELLB.COM - SHELLB transient to TSR intrface
	AX = 1904h
Return: ES:DI -> name of current shell batch file:
		WORD	number of bytes of name following
		BYTEs	(8 max) uppercase name of shell batch file
----------2F1A00-----------------------------
INT 2F - Multiplex - DOS 4+ ANSI.SYS - INSTALLATION CHECK
	AX = 1A00h
Return: AL = FFh if installed
Notes:	AVATAR.SYS also responds to this call
	documented for DOS 5+, but undocumented for DOS 4.x
----------2F1A00BX4156-----------------------
INT 2F - Multiplex - AVATAR.SYS - INSTALLATION CHECK
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
INT 2F - Multiplex - DOS 4+ ANSI.SYS internal - GET/SET DISPLAY INFORMATION
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
INT 2F - Multiplex - DOS 4+ ANSI.SYS internal - MISC REQUESTS
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
INT 2F - Multiplex - AVATAR.SYS - SET DRIVER STATE
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
INT 2F - Multiplex - AVATAR.SYS v0.11 - ???
	AX = 1A3Ch
	???
Return: CX = 0000h
----------2F1A3E-----------------------------
INT 2F - Multiplex - AVATAR.SYS v0.11 - ???
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
INT 2F - Multiplex - AVATAR.SYS - QUERY DRIVER STATE
	AX = 1A3Fh (AL='?')
	ES:DI -> buffer
	CX = length of buffer in bytes
Return: CF clear
	CX = actual size of returned info
Note:	the returned information consists of multiple letters whose meanings
	  are described under AX=1A21h
SeeAlso: AX=1A21h
----------2F1A42BX4156-----------------------
INT 2F - Multiplex - AVATAR Serial Dispatcher - INSTALL IRQ3 HANDLER
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
INT 2F - Multiplex - AVATAR Serial Dispatcher - INSTALL IRQ4 HANDLER
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
INT 2F - Multiplex - AVATAR.SYS v0.11+ - GET DATA SEGMENT
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
INT 2F - Multiplex - AVATAR.SYS v0.11 - GET ???
	AX = 1A52h
	CX = size of buffer
	ES:DI -> buffer
Return: ??? copied into user buffer
Note:	the maximum size of the data which may be copied is returned by
	  AX=1A72h
SeeAlso: AX=1A72h
----------2F1A53-----------------------------
INT 2F - Multiplex - AVATAR.SYS v0.11 - ???
	AX = 1A53h
	CL = ??? (00h-05h)
	???
Return: ???
----------2F1A62BX4156-----------------------
INT 2F - Multiplex - AVATAR Serial Dispatcher - UNINSTALL IRQ3 HANDLER
	AX = 1A62h
	BX = 4156h ('AV')
	CX = handle for IRQ routine returned by AX=1A42h
SeeAlso: AX=1A42h,AX=1A63h
----------2F1A63BX4156-----------------------
INT 2F - Multiplex - AVATAR Serial Dispatcher - UNINSTALL IRQ4 HANDLER
	AX = 1A63h
	BX = 4156h ('AV')
	CX = handle for IRQ routine returned by AX=1A43h
SeeAlso: AX=1A43h,AX=1A62h
----------2F1A72-----------------------------
INT 2F - Multiplex - AVATAR.SYS v0.11 - GET ??? SIZE
	AX = 1A72h
Return: CX = maximum size of ???
SeeAlso: AX=1A52h
----------2F1A7B-----------------------------
INT 2F - Multiplex - AVATAR.SYS v0.11 - ???
	AX = 1A7Bh
Return: AX = 0000h
	CX = 0000h
----------2F1A7D-----------------------------
INT 2F - Multiplex - AVATAR.SYS v0.11 - ???
	AX = 1A7Dh
Return: AX = ???
----------2F1AADDX0000-----------------------
INT 2F - Multiplex - AVATAR.SYS v0.11 - ???
	AX = 1AADh
	DX = 0000h
	CX = subfunction (00h-0Ch)
	???
Return: AX = 0000h if DX was nonzero
	???
----------2F1B00-----------------------------
INT 2F - Multiplex - DOS 4+ XMA2EMS.SYS extension internal - INSTALLATION CHECK
	AX = 1B00h
Return: AL = FFh if installed
Note:	XMA2EMS.SYS extension is only installed if DOS has page frames to hide.
	This extension hooks onto INT 67/AH=58h and returns from that call data
	  which excludes the physical pages being used by DOS.
SeeAlso: AX=1Bh"FRAME INFO"
----------2F1B-------------------------------
INT 2F - Multiplex - DOS 4+ XMA2EMS.SYS extens internal - GET HIDDEN FRAME INFO
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
----------2F4001-----------------------------
INT 2F - Multiplex - OS/2 compatibility box - SWITCHING DOS TO BACKGROUND
	AX = 4001h
Note:	called by OS/2 when the DOS box is about to be placed in the background
SeeAlso: AX=4002h
----------2F4002-----------------------------
INT 2F - Multiplex - OS/2 compatibility box - SWITCHING DOS TO FOREGROUND
	AX = 4002h
Note:	called by OS/2 when the DOS box is about to be placed in the foreground
SeeAlso: AX=4001h
----------2F41-------------------------------
INT 2F - LAN Manager 2.0 DOS Enhanced NETPOPUP.EXE - NETWORK POP-UP SERVICE
	AH = 41h
	???
Return: ???
Note:	LAN Manager enhance mode adds features beyond the standard redirector
	  file/printer services
SeeAlso: AX=118Ah,AH=42h,AH=4Bh
----------2F42-------------------------------
INT 2F - LAN Manager 2.0 DOS Enhanced MSRV.EXE - MESSENGER SERVICE
	AH = 42h
	???
Return: ???
Note:	LAN Manager enhance mode adds features beyond the standard redirector
	  file/printer services
SeeAlso: AX=118Ah,AH=41h,AH=4Bh
----------2F4300-----------------------------
INT 2F - Multiplex - XMS - INSTALLATION CHECK
	AX = 4300h
Return: AL = 80h XMS driver installed
	AL <> 80h no driver
Notes:	XMS gives access to extended memory and noncontiguous/nonEMS memory
	  above 640K
	this installation check DOES NOT follow the format used by other
	  software
SeeAlso: AX=4310h
----------2F4310-----------------------------
INT 2F - Multiplex - XMS - GET DRIVER ADDRESS
	AX = 4310h
Return: ES:BX -> driver entry point
Note:	HIMEM.SYS v2.77 chains to previous handler if AH is not 00h or 10h
SeeAlso: AX=4300h

Perform a FAR call to the driver entry point with AH set to the function code
	AH	function
	00h  Get XMS version number
	     Return: AX = XMS version (in BCD)
		     BX = internal revision number
		     DX = 0001h if HMA (1M to 1M + 64K) exists
			  0000h if HMA does not exist
	01h  Request High Memory Area (1M to 1M + 64K)
	     DX = memory in bytes (for TSR or device drivers)
		  FFFFh if application program
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (see below)
	02h  Release High Memory Area
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (see below)
	03h  Global enable A20, for using the HMA
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (see below)
	04h  Global disable A20
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (see below)
	05h  Local enable A20, for direct access to extended memory
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (see below)
	06h  Local disable A20
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (see below)
	07h  Query A20 state
	     Return: AX = 0001h enabled
			= 0000h disabled
		     BL = error code (0 = successful)
	08h  Query free extended memory, not counting HMA
	     Return: AX = size of largest extended memory block in K
		     DX = total extended memory in K
		     BL = error code (see below)
	09h  Allocate extended memory block
	     DX = Kbytes needed
	     Return: AX = 0001h success
			   DX = handle for memory block
			= 0000h failure
			   BL = error code (see below)
	0Ah  Free extended memory block
	     DX = handle of block to free
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (see below)
	0Bh  Move extended memory block
	     DS:SI -> EMM structure (see below)
	     Note: if either handle is 0000h, the corresponding offset is
		   considered to be an absolute segment:offset address in
		   directly addressable memory
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (see below)
	0Ch  Lock extended memory block
	     DX = handle of block to lock
	     Return: AX = 0001h success
			   DX:BX = 32-bit linear address of locked block
			= 0000h failure
			   BL = error code (see below)
	0Dh  Unlock extended memory block
	     DX = handle of block to unlock
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (see below)
	0Eh  Get handle information
	     DX = handle for which to get info
	     Return: AX = 0001h success
			   BH = block's lock count
			   BL = number of free handles left
			   DX = block size in K
			= 0000h failure
			   BL = error code (see below)
	0Fh  Reallocate extended memory block
	     DX = handle of block
	     BX = new size of block in K
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (see below)
	10h  Request upper memory block (nonEMS memory above 640K)
	     DX = size of block in paragraphs
	     Return: AX = 0001h success
			   BX = segment address of UMB
			   DX = actual size of block
			= 0000h failure
			   BL = error code (see below)
			   DX = largest available block
	11h  Release upper memory block
	     DX = segment address of UMB to release
	     Return: AX = 0001h success
			= 0000h failure
			   BL = error code (see below)
	12h  Reallocate upper memory block (XMS v3.0)
	     DX = segment address of UMB to resize
	     BX = new size of block in paragraphs
	     Return: AX = 0001h success
	     		= 0000h failure
			   BL = error code (see below)
Note:	HIMEM.SYS requires at least 256 bytes free stack space

Format of EMM structure:
Offset	Size	Description
 00h	DWORD	number of bytes to move (must be even)
 04h	WORD	source handle
 06h	DWORD	offset into source block
 0Ah	WORD	destination handle
 0Ch	DWORD	offset into destination block

Error codes returned in BL:
	80h Function not implemented
	81h Vdisk was detected
	82h An A20 error occurred
	8Eh a general driver error
	8Fh unrecoverable driver error
	90h HMA does not exist
	91h HMA is already in use
	92h DX is less than the /HMAMIN= parameter
	93h HMA is not allocated
	94h A20 line still enabled
	A0h all extended memory is allocated
	A1h all available extended memory handles are allocated
	A2h Invalid handle
	A3h Source handle is invalid
	A4h Source offset is invalid
	A5h Destination handle is invalid
	A6h Destination offset is invalid
	A7h Length is invalid
	A8h Move has an invalid overlap
	A9h Parity error occurred
	AAh Block is not locked
	ABh Block is locked
	ACh Block lock count overflowed
	ADh Lock failed
	B0h Only a smaller UMB is available
	B1h No UMB's are available
	B2h UMB segment number is invalid
----------2F4601-----------------------------
INT 2F - Multiplex - DOS 5.0 kernel - ???
	AX = 4601h
Return: ???
Note:	copies the MCB following the caller's PSP memory block into DOS data
	  segment
SeeAlso: AX=4602h
----------2F4602-----------------------------
INT 2F - Multiplex - DOS 5.0 kernel - ???
	AX = 4602h
Return: ???
Note:	copies previously copied MCB from DOS data segment into MCB following
	  caller's PSP memory block
SeeAlso: AX=4601h
----------2F4653CX0002-----------------------
INT 2F - Multiplex - F-LOCK.EXE 
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
SeeAlso: AX=4653h/CX=0003h,INT 21/AX=4BEEh
----------2F4653CX0003-----------------------
INT 2F - Multiplex - F-XCHK.EXE
	AX = 4653h
	CX = 0003h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
		Return: AX,BX,ES destroyed
Note:	F-XCHK is part of the F-PROT virus/trojan protection package by Fridrik
	  Skulason
SeeAlso: AX=4653h/CX=0002h,AX=4653h/CX=0004h
----------2F4653CX0004-----------------------
INT 2F - Multiplex - F-POPUP.EXE
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
SeeAlso: AX=4653h/CX=0003h,AX=4653h/CX=0005h
----------2F4653CX0005-----------------------
INT 2F - Multiplex - F-DLOCK.EXE
	AX = 4653h
	CX = 0005h
	BX = subfunction
	    0000h installation check
		Return: AX = FFFFh
	    0001h uninstall
		Return: AX,BX,ES destroyed
Note:	F-DLOCK is part of the F-PROT virus/trojan protection package by
	  Fridrik Skulason
SeeAlso: AX=4653h/CX=0004h
----------2F4680-----------------------------
INT 2F - Multiplex - MS Windows 3 - INSTALLATION CHECK
	AX = 4680h
Return: AX = 0000h MS Windows 3.0 running in real (/R) or standard (/S) mode,
		   or DOS 5 DOSSHELL active
	   nonzero  no Windows, Windows prior to 3.0, or Windows3 in enhanced
		    mode
Note:	not officially documented, but Microsoft has indicated that they
	  intend to provide an installation check which works in all modes
SeeAlso: AX=1600h
----------2F4800-----------------------------
INT 2F - Multiplex - DOS 5+ DOSKEY - INSTALLATION CHECK
	AX = 4800h
Return: AL = nonzero if installed
SeeAlso: AX=4810h
----------2F4810-----------------------------
INT 2F - Multiplex - DOS 5+ DOSKEY - READ INPUT LINE FROM CONSOLE
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
----------2F4A01-----------------------------
INT 2F - Multiplex - DOS 5.0 - QUERY FREE HMA SPACE
	AX = 4A01h
Return: BX = number of bytes available in HMA (0000h if DOS not using HMA)
	ES:DI -> start of available HMA area (FFFFh:FFFFh if not using HMA)
SeeAlso: AX=4310h,AX=4A02h
----------2F4A02-----------------------------
INT 2F - Multiplex - DOS 5.0 - ALLOCATE HMA SPACE
	AX = 4A02h
	BX = number of bytes
Return: ES:DI -> start of allocated HMA block or FFFFh:FFFFh
	BX destroyed
Note:	this call is not valid unless DOS is loaded in the HMA (DOS=HIGH)
SeeAlso: AX=4A01h
----------2F4A05-----------------------------
INT 2F - DOS 5 DOSSHELL - ???
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
Note:	DOSSHELL chains to the previous handler if SI is not one of the values
	  listed above
SeeAlso: AX=4B01h
----------2F4B-------------------------------
INT 2F - LAN Manager 2.0 DOS Enh NETWKSTA.EXE - NETWORK WORKSTATION REDIRECTOR
	AH = 4Bh
	???
Return: ???
Note:	LAN Manager enhanced mode adds features beyond the standard redirector
	  file/printer services
SeeAlso: AX=118Ah,AH=41h,AH=42h
----------2F4B01-----------------------------
INT 2F - DOS 5 TASK SWITCHER - BUILD CALLOUT CHAIN
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
INT 2F - DOS 5 TASK SWITCHER - INSTALLATION CHECK
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
INT 2F - DOS 5 TASK SWITCHER - ALLOCATE SWITCHER ID
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
INT 2F - DOS 5 TASK SWITCHER - FREE SWITCHER ID
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
INT 2F - DOS 5 DOSSHELL TASK SWITCHER - IDENTIFY INSTANCE DATA
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
----------2F5453-----------------------------
INT 2F - Multiplex - TesSeRact RAM-RESIDENT PROGRAM INTERFACE
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
	  fully supports the TesSeRact API, as do the SWAP?? programs by 
	  Innovative Data Concepts.
	AVATAR.SYS supports functions 00h and 01h (only the first three fields
	  of the user parameter block) using the name "AVATAR  "

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
INT 2F - Multiplex - DOS 5.0 COMMAND.COM INTERFACE
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
INT 2F - PC Tools 7 VDEFEND, DATAMON - SET ??? ADDRESS
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
INT 2F - PC Tools 7 DATAMON - INSTALLATION CHECK
	AX = 6284h
	BX = 0000h
	CX = 0000h
Return: AX = segment of resident code
	BX = 5555h
	CX = 5555h
----------2F6284BX0001-----------------------
INT 2F - PC Tools 7 DATAMON - GET ???
	AX = 6284h
	BX = 0001h
	CX = 0001h
Return: AX:BX -> ???
	CX = BX
----------2F6284BX0002-----------------------
INT 2F - PC Tools 7 DATAMON - GET ???
	AX = 6284h
	BX = 0002h
	CX = 0002h
Return: AX = ???
	BX = ???
	CX = AX
	DX = BX
----------2F6284BX0003-----------------------
INT 2F - PC Tools 7 DATAMON - SET ??? FLAGS
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
INT 2F - Multiplex - SCRNSAV2.COM - INSTALLATION CHECK
	AX = 6400h
Return: AL = 00h not installed
	     FFh installed
Note:	SCRNSAV2.COM is a screen saver for PS/2's with VGA by Alan Ballard
----------2F7A00-----------------------------
INT 2F - Multiplex - Novell NetWare - LOW-LEVEL API (IPX) INSTALLATION CHECK
	AX = 7A00h
Return: AL = 00h not installed
	   = FFh installed
		ES:DI -> FAR entry point for routines accessed exclusively
			through INT 7A in NetWare versions through 2.0a.  Call
			with same values as INT 7A
SeeAlso: INT 64"Novell",INT 7A"Novell"
----------2F7A80-----------------------------
INT 2F - Multiplex - Novell NetWare shell 3.01d - ???
	AX = 7A80h
Return: nothing
Note:	apparently called on abnormal exit of the shell
----------2F7A81-----------------------------
INT 2F - Multiplex - Novell NetWare shell 3.01d - ???
	AX = 7A81h
	CX:DX -> ??? in shell's CS (may be callback address or data structure)
Return: nothing???
----------2F7A85-----------------------------
INT 2F - Multiplex - Novell NetWare shell 3.01 - BROADCAST INFORM
	AX = 7A85h
	CX = broadcast server number
Return: CX = 0000h if broadcast message handled by another program
	CX unchanged if broadcast not handled
----------2F7AFE-----------------------------
INT 2F - Multiplex - Novell NetWare shell 3.01d - ???
	AX = 7AFEh
Return: AL = FFh ???
	     other ???
----------2F7AFFBX0001-----------------------
INT 2F - Multiplex - Novell NetWare shell 3.01d - ???
	AX = 7AFFh
	BX = 0001h
	CX = offset of ???
	DX = offset of ???
Return: CX unchanged if ???
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
INT 2F - Multiplex - EASY-NET - INSTALLATION CHECK
	AX = 8000h
Return: AL = 00h not installed
	     FFh installed
Note:	EASY-NET is a shareware two-machine serial-port network
----------2F8200-----------------------------
INT 2F - Multiplex - RESPLAY - SAMPLE/PLAYBACK
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
INT 2F - Multiplex - RESPLAY - INSTALLATION CHECK
	AX = 8201h
Return: AX = 7746h if installed
SeeAlso: AX=8202h
----------2F8202-----------------------------
INT 2F - Multiplex - RESPLAY - UNINSTALL
	AX = 8202h
Return:	AX = status
	    1000h successful
SeeAlso: AX=8201h
----------2F8210-----------------------------
INT 2F - Multiplex - RESPLAY - INITIALIZE
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
----------2F8900-----------------------------
INT 2F - Multiplex - WHOA!.COM - INSTALLATION CHECK
	AX = 8900h
Return: AL = 00h not installed
	   = FFh installed
Note:	WHOA!.COM is a system slow-down utility by Brad D Crandall
SeeAlso: AX=8901h,AX=8902h
----------2F8901-----------------------------
INT 2F - Multiplex - WHOA!.COM - UNINSTALL
	AX = 8901h
Return: AL = FDh successful
	   = FEh error
Note:	WHOA!.COM is a system slow-down utility by Brad D Crandall
SeeAlso: AX=8900h
----------2F8902-----------------------------
INT 2F - Multiplex - WHOA!.COM - SET DELAY COUNT
	AX = 8902h
	BX = delay count (larger values slow system down more)
Return: AL = FDh successful
	   = FEh error
Note:	WHOA!.COM is a system slow-down utility by Brad D Crandall
SeeAlso: AX=8900h
----------2F9000-----------------------------
INT 2F - Multiplex - RAID - INSTALLATION CHECK
	AX = 9000h
Return: AL = FFh if installed
Note:	RAID (Resident AID) is a TSR utility program by Ross Neilson Wentworth
	  that resides mostly in EMS
----------2F9001-----------------------------
INT 2F - Multiplex - RAID - GET ???
	AX = 9001h
Return: DX:AX -> ???
SeeAlso: AX=9000h
----------2F9002-----------------------------
INT 2F - Multiplex - RAID - GET RESIDENT SEGMENT
	AX = 9002h
Return: AX = segment of resident (conventional memory) portion
SeeAlso: AX=9000h
----------2F9003-----------------------------
INT 2F - Multiplex - RAID - UNINSTALL
	AX = 9003h
Return: ???
SeeAlso: AX=9000h
----------2F9004-----------------------------
INT 2F - Multiplex - RAID - GET ???
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
INT 2F - Multiplex - InnerMission v1.7+ - INSTALLATION CHECK
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
----------2FA1-------------------------------
INT 2F - Multiplex - Ergo DOS extenders - INSTALLATION CHECK
	AH = A1h
	AL = which
	    FEh OS/286,OS/386
	    FFh HummingBoard DOS extender
	BX = 0081h
	ES:DI -> 16-byte buffer
Return: if installed, first four bytes of ES:DI buffer are "IABH"
SeeAlso: AX=ED00h,AX=FBA1h,INT 15/AX=BF02h
----------2FAA00-----------------------------
INT 2F - Multiplex - VIDCLOCK.COM - INSTALLATION CHECK
	AX = AA00h
Return: AL = 00h not installed
	     FFh installed
Note:	VIDCLOCK.COM is a memory-resident clock by Thomas G. Hanlin III
----------2FAC00-----------------------------
INT 2F - Multiplex - DOS 4.01+ GRAPHICS.COM - INSTALLATION CHECK
	AX = AC00h
Return: AX = FFFFh
	ES:DI -> ??? (graphics data?)
Note:	this installation check was moved here to avoid the conflict with the
	  CD-ROM extensions that occurred in DOS 4.00
SeeAlso: AX=1500h"GRAPHICS"
----------2FAD00-----------------------------
INT 2F - Multiplex - DOS 3.3+ DISPLAY.SYS internal - INSTALLATION CHECK
	AX = AD00h
Return: AL = FFh if installed
	    BX = ??? (0100h in MS-DOS 3.30, PCDOS 4.01)
Note:	DOS 5.0 DISPLAY.SYS chains to previous handler if AL is not one of the
	  subfunctions listed here
----------2FAD01-----------------------------
INT 2F - Multiplex - DOS 3.3+ DISPLAY.SYS internal - SET ???
	AX = AD01h
	BX = ???
Return: ???
	CF set on error
----------2FAD02-----------------------------
INT 2F - Multiplex - DOS 3.3+ DISPLAY.SYS internal - GET ???
	AX = AD02h
Return: BX = ??? (value set with AX=AD01h)
----------2FAD03-----------------------------
INT 2F - Multiplex - DOS 3.3+ DISPLAY.SYS internal - GET ???
	AX = AD03h
	ES:DI -> user buffer
	CX = size of buffer
Return: CF set if buffer too small
	CF clear if successful
----------2FAD04-----------------------------
INT 2F - Multiplex - DOS 4.x only DISPLAY.SYS internal - ???
	AX = AD04h
	???
Return: ???
----------2FAD10-----------------------------
INT 2F - Multiplex - DOS 4+ DISPLAY.SYS internal - INSTALLATION CHECK???
	AX = AD10h
	???
Return: AX = FFFFh
	BX = ??? (0100h in PCDOS 4.01)
----------2FAD40-----------------------------
INT 2F - Multiplex - DOS 4.0 - ???
	AX = AD40h
	DX = ???
	???
Return: ???
Note:	called by PCDOS 4.01 PRINT.COM
----------2FAD80-----------------------------
INT 2F - Multiplex - DOS 3.3+ KEYB.COM internal - INSTALLATION CHECK
	AX = AD80h
Return: AL = FFh if installed
	    BX = version number (BH = major, BL = minor)
	    ES:DI -> internal data (see below)
Note:	MSDOS 3.30, PCDOS 4.01, and MSDOS 5.00 all report version 1.00.

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
INT 2F - Multiplex - DOS 3.3+ KEYB.COM - SET KEYBOARD CODE PAGE
	AX = AD81h
	BX = code page (see INT 21/AX=6601h)
Return: CF set on error
	    AX = 0001h (code page not available)
	CF clear if successful
Notes:	called by DISPLAY.SYS
	documented for DOS 5+, but undocumented for earlier versions
SeeAlso: AX=AD82h
----------2FAD82-----------------------------
INT 2F - Multiplex - DOS 3.3+ KEYB.COM - SET KEYBOARD MAPPING
	AX = AD82h
	BL = new state
	    00h US keyboard (Control-Alt-F1)
	    FFh foreign keyboard (Control-Alt-F2)
Return: CF set on error (BL not 00h or FFh)
	CF clear if successful
Note:	documented for DOS 5+, but undocumented for earlier versions
SeeAlso: AX=AD81h,AX=AD83h
----------2FAD83-----------------------------
INT 2F - Multiplex - DOS 5.0 KEYB.COM - GET KEYBOARD MAPPING
	AX = AD83h
Return: BL = current state
	    00h US keyboard
	    FFh foreign keyboard
SeeAlso: AX=AD82h
----------2FAE00DXFFFF-----------------------
INT 2F - Multiplex - DOS 3.3+ internal - INSTALLABLE COMMAND - INSTALL CHECK
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
	  extensions to the command repertoire of COMMAND.COM.  It appears
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
INT 2F - Multiplex - DOS 3.3+ internal - INSTALLABLE COMMAND - EXECUTE
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
INT 2F - Multiplex - DOS 3.3+ GRAFTABL.COM - INSTALLATION CHECK
	AX = B000h
Return: AL = 00h not installed, OK to install
	   = 01h not installed, not OK to install
	   = FFh installed
Notes:	called by DISPLAY.SYS
	documented for DOS 5.0, but undocumented in prior versions
SeeAlso: AX=B001h
----------2FB001-----------------------------
INT 2F - Multiplex - DOS 3.3+ GRAFTABL.COM - GET GRAPHICS FONT TABLE
	AX = B001h
	DS:BX -> DWORD buffer for address of 8x8 font table
Return: buffer filled
	AL = FFh
Note:	PCDOS 3.30/4.01 set the font table offset to 0130h, MSDOS 3.30 to 0030h
SeeAlso: AX=B000h
----------2FB400-----------------------------
INT 2F - Multiplex - IBM PC3270 EMUL PROG v3 - INSTALLATION CHECK
	AX = B400h
Return: AL = FFh if installed
----------2FB401-----------------------------
INT 2F - Multiplex - IBM PC3270 EMUL PROG v3 - GET HOST BUFFER ADDRESS
	AX = B401h
Return: ES -> host screen buffer (PC ASCII format)
	ES unchanged if communications not started
----------2FB402-----------------------------
INT 2F - Multiplex - IBM PC3270 EMUL PROG v3 - ???
	AX = B402h
	BX = ???
Return: ???
----------2FB403-----------------------------
INT 2F - Multiplex - IBM PC3270 EMUL PROG v3 - ???
	AX = B403h
	???
Return: ???
----------2FB404-----------------------------
INT 2F - Multiplex - IBM PC3270 EMUL PROG v3 - ???
	AX = B404h
	???
Return: ???
----------2FB405-----------------------------
INT 2F - Multiplex - IBM PC3270 EMUL PROG v3 - ???
	AX = B405h
	???
Return: ???
----------2FB700-----------------------------
INT 2F - Multiplex - APPEND - INSTALLATION CHECK
	AX = B700h
Return: AL = status
	    00h not installed
	    FFh installed
Note:	MSDOS 3.30 APPEND refuses to install itself when run inside TopView or
	  a TopView-compatible environment
----------2FB701-----------------------------
INT 2F - Multiplex - APPEND - ???
	AX = B701h
	???
Return: ???
Note:	MSDOS 3.30 APPEND displays "Incorrect APPEND Version" and aborts caller
----------2FB702-----------------------------
INT 2F - Multiplex - APPEND - VERSION CHECK
	AX = B702h
Return: AX = FFFFh if not DOS 4.0 APPEND (also if DOS 5.0 APPEND)
	AL = major version number
	AH = minor version number, otherwise
SeeAlso: AX=B710h
----------2FB703-----------------------------
INT 2F - Multiplex - DOS 3.3, DOS 5.0 APPEND - HOOK INT 21
	AX = B703h
	ES:DI -> INT 21 handler APPEND should chain to
Return: ES:DI -> APPEND's INT 21 handler
Note:	each invocation of this function toggles a flag which APPEND uses to
	  determine whether to chain to the user handler or the original
	  INT 21
----------2FB704-----------------------------
INT 2F - Multiplex - DOS 3.3+ APPEND - GET APPEND PATH
	AX = B704h
Return: ES:DI -> active APPEND path (128 bytes max)
----------2FB706-----------------------------
INT 2F - Multiplex - DOS 4+ APPEND - GET APPEND FUNCTION STATE
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
INT 2F - Multiplex - DOS 4+ APPEND - SET APPEND FUNCTION STATE
	AX = B707h
	BX = APPEND state bits (see AX=B706h)
----------2FB710-----------------------------
INT 2F - Multiplex - DOS 3.3+ APPEND - GET VERSION INFO
	AX = B710h
Return: AX = current APPEND state (see AX=B706h)
	BX = ??? (0000h in MSDOS 3.30 and 5.00)
	CX = ??? (0000h in MSDOS 3.30 and 5.00)
	DL = major version
	DH = minor version
SeeAlso: AX=B702h
----------2FB711-----------------------------
INT 2F - Multiplex - DOS 4+ APPEND - SET RETURN FOUND NAME STATE
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
INT 2F - Multiplex - network - INSTALLATION CHECK
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
INT 2F - Multiplex - network - GET NETWORK EVENT POST HANDLER
	AX = B803h
Return: ES:BX -> event post handler (see AX=B804h)
SeeAlso: AX=B804h,AX=B903h
----------2FB804-----------------------------
INT 2F - Multiplex - network - SET NETWORK EVENT POST HANDLER
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
INT 2F - Multiplex - Network - GET NetBIOS NAME NUMBER OF MACHINE NAME
	AX = B807h
Return: CH = NetBIOS name number of the machine name
SeeAlso: INT 21/AX=5E00h
----------2FB808-----------------------------
INT 2F - Multiplex - Network - ???
	AX = B808h
	???
Return: ???
----------2FB809-----------------------------
INT 2F - Multiplex - LANtastic Network - VERSION CHECK
	AX = B809h
Return: AH = major version
	AL = minor version
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
----------2FBC00-----------------------------
INT 2F - Multiplex - Windows 3.0, DOS 5.0 EGA.SYS - INSTALLATION CHECK
	AX = BC00h
Return: AL = 00h not installed, OK to install
	   = 01h not installed, not OK to install
	   = FFh installed
		BX = 5456h ("TV")
Note:	AH=BCh is the default value, which may be changed by a command line
	  parameter to any value between 80h and FFh
SeeAlso: AX=BC06h,INT 10/AH=FAh"EGA"
----------2FBC06-----------------------------
INT 2F - Multiplex - MS Windows 3.0, DOS 5.0 EGA.SYS - GET VERSION INFO
	AX = BC06h
Return: BX = 5456h ("TV")
	CH = major version
	CL = minor version
	DL = revision
SeeAlso: AX=BC00h,INT 10/AH=FAh"EGA"
----------2FBF00-----------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIRIFS.EXE internal - INSTALLATION CHECK
	AX = BF00h
Return: AL = FFh if installed
----------2FBF01-----------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIRIFS.EXE internal - ???
	AX = BF01h
	???
Return: ???
----------2FBF80-----------------------------
INT 2F - Multiplex - PC LAN PROG REDIR.SYS internal - SET REDIRIFS ENTRY POINT
	AX = BF80h
	ES:DI -> FAR entry point to IFS handler in REDIRIFS
Return: AL = FFh if installed
	    ES:DI -> internal workspace
Note:	all future IFS calls to REDIR.SYS are passed to the ES:DI entry point
----------2FC000-----------------------------
INT 2F - Multiplex - Novell ODI Link Support Layer (LSL.COM) - INSTALL CHECK
	AX = C000h
Return: AL = FFh
	ES:BX -> call entry point
	ES:SI -> signature string "LINKSUP$"
Note:	LSL.COM may use any multiplex number between C0h and FFh; it searches
	  for itself in that range, and installs using the first free multiplex
	  number in the range if not already loaded.
----------2FC900BP0000-----------------------
INT 2F - Multiplex - ThunderByte??? - INSTALLATION CHECK
	AX = C900h
	BP = 0000h
Return: AL = FFh if installed
	    BP >= 0014h
Note:	called by TBSCANX
SeeAlso: AX=C987h,AX=CA00h
----------2FC987-----------------------------
INT 2F - Multiplex - ThunderByte??? - DISINFECT FILE???
	AX = C987h
	BX:DX -> filename
	BX:CX -> virus name
Return: AX = status
	    0000h successful???
Note:	called by TBSCANX
SeeAlso: AX=CA00h
----------2FCA00BX5442-----------------------
INT 2F - Multiplex - TBSCANX - INSTALLATION CHECK
	AX = CA00h
	BX = 5442h ('TB')
Return:	AL = 00h not installed
	   = FFh installed
		BX = 7462h ('tb') if BX was 5442h on entry
Note:	TBSCANX is a resident virus scanning module by Frans Veldman.  Programs
	  may perform virus checks on themselves, other program files, or their
	  data files by invoking the TBSCANX API.
SeeAlso: AX=C900h
----------2FCA01-----------------------------
INT 2F - Multiplex - TBSCANX - GET STATUS
	AX = CA01h
Return: AH = BCD version number (v2.2+)
	   = CAh for versions before 2.2
	AL = state (00h = disabled, 01h = enabled)
	CX = number of signatures which will be searched
---v2.0---
	BX = EMS handle, 0000h if not using EMS
---v2.3+---
	BX = segment of swap area, 0000h if not swapped
	DX = EMS handle, FFFFh if not using EMS
SeeAlso: AX=CA02h
----------2FCA02-----------------------------
INT 2F - Multiplex - TBSCANX - SET STATE
	AX = CA02h
	BL = new state (00h = disabled, 01h = enabled)
SeeAlso: AX=CA01h
----------2FCA03-----------------------------
INT 2F - Multiplex - TBSCANX - SCAN BUFFER
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
----------2FCA04-----------------------------
INT 2F - Multiplex - TBSCANX - SCAN FILE
	AX = CA04h
	DS:DX -> filename
Return: CF clear if no virus signatures found
	    BX,ES destroyed
	CF set if signature found
	    ES:BX -> ASCIZ virus name
	AX,CX,DX destroyed
Note:	this function requires at least 4K free memory
SeeAlso: AX=CA03h
----------2FCB00-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - INSTALLATION CHECK
	AX = CB00h
Return: AL = 00h not installed, OK to install
	     01h not installed, not OK to install
	     FFh installed
Note:	AH = CBh is the default identifier, but may be reconfigured
SeeAlso: AX=CB0Eh
----------2FCB01-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - SUBMIT A TASK
	AX = CB01h
	DS:DX -> ASCIZ name of task control file
Return: AX >= 0: event handle
	   < 0: error code
Note:	files needed for an event must be kept until task is complete or error
SeeAlso: AX=CB0Bh,AX=CB15h

Error codes (AH = class, AL = subcode, value passed back is 2's complement):
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
	Subcode	00h	multiplex handler failed
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
----------2FCB02-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - ABORT CURRENT EVENT
	AX = CB02h
Return: AX >= 0: event handle of aborted event
	   < 0: error code (see AX=CB01h)
Note:	termination could take up to 30 seconds
SeeAlso: AX=CB08h,AX=CB10h
----------2FCB05-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - FIND FIRST QUEUE ENTRY
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
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB06h,AX=CB07h
----------2FCB06-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - FIND NEXT QUEUE ENTRY
	AX = CB06h
	DL = queue to search
	    00h task queue
	    01h receive queue
	    02h log queue
Return: AX = 0000h successful
	    BX = event handle for found event
	   < 0	   error code (see AX=CB01h)
Note:	direction of search is same as preceding FIND FIRST call
SeeAlso: AX=CB05h
----------2FCB07-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - OPEN FILE
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
	   < 0	   error code (see AX=CB01h)
Note:	the returned file handle has been opened in read-only mode and should
	  be closed with INT 21/AH=3Eh after use
SeeAlso: AX=CB01h,AX=CB05h,AX=CB14h
----------2FCB08-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - DELETE FILE
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
	   < 0	   error code (see AX=CB01h)\
SeeAlso: AX=CB02h,AX=CB09h
----------2FCB09-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - DELETE ALL FILES IN Q
	AX = CB09h
	DL = queue
	    00h delete all control files in task queue, including all group
		files
	    01h delete all files in receive queue
	    02h delete all control files in log queue, including all group
		files
Return: AX = 0000h successful
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB08h
----------2FCB0A-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - GET EVENT DATE
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
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB0Bh,AX=CB0Ch
----------2FCB0B-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - SET TASK DATE
	AX = CB0Bh
	BX = event handle (task event only)
	CX = year
	DH = month
	DL = day
Return: AX = 0000h successful
	   < 0	   error code (see AX=CB01h)
Note:	setting a task's date and time to before the current date and time
	  causes it to execute immediately
SeeAlso: AX=CB01h,AX=CB0Ah,AX=CB0Dh
----------2FCB0C-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - GET EVENT TIME
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
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB0Ah,AX=CB0Dh
----------2FCB0D-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - SET TASK TIME
	AX = CB0Dh
	BX = event handle (task events only)
	CH = hour
	CL = minute
	DH = second
	DL unused
Return: AX = 0000h successful
	   < 0	   error code (see AX=CB01h)
Note:	setting a task's date and time to before the current date and time
	  causes it to execute immediately
SeeAlso: AX=CB0Bh,AX=CB0Ch,AX=CB10h
----------2FCB0E-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - GET EXTERNAL DATA BLOCK
	AX = CB0Eh
	DS:DX -> 256-byte buffer
Return: AX = 0000h successful
		buffer filled
	   < 0	   error code (see AX=CB01h)

Format of external data block:
Offset	Size	Description
 00h	BYTE	CAS major version
 01h	BYTE	CAS minor version
 02h 68 BYTEs	ASCIZ path to directory containing CAS software, ends in slash
 46h 13 BYTEs	ASCIZ name of current phonebook (in CAS directory)
 53h 13 BYTEs	ASCIZ name of current logo file (in CAS directory)
 60h 32 BYTEs	ASCIZ default sender name
 80h 21 BYTEs	ASCIZ CCITT identification of fax device
 95h 107 BYTEs	reserved
----------2FCB0F-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - GET/SET AUTORECEIVE
	AX = CB0Fh
	DL = subfunction
	    00h get current autoreceive state
	    01h set autoreceive state
		DH = number of rings before answer, 00h = never
Return: AX = 0000h autoreceive disabled
	   = N	   number of rings before answer
	   < 0	   error code (see AX=CB01h)
----------2FCB10-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - GET CURRENT EVENT STATUS
	AX = CB10h
	DS:DX -> 512-byte buffer
Return: AX = 0000h successful
		BX = event handle of current event or negative error code if
			no current event
		buffer filled
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB02h,AX=CB0Dh

Format of status area:
Offset	Size	Description
 00h	BYTE	event type
		00h send
		01h receive
		02h polled send
		03h polled receive
		04h to 7Fh reserved
		FFh serious hardware error
 01h	BYTE	transfer type
		00h 200x200 dpi, FAX mode
		01h 100x200 dpi, FAX mode
		02h file transfer mode
		03h to 7Fh reserved
 02h	WORD	event status 
		0000h completed successfully
		0001h waiting
		0002h number dialed
		0003h connected, sending
		0004h connected, receiving
		0005h aborted
		0006h to 007Fh reserved
		0080h to 7FFFh application-specific events
		8000h to FFFFh error codes
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
17Fh 128 BYTEs	file transfer record for current event (see below)

Format of file transfer record:
Offset	Size	Description
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
----------2FCB11-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - GET QUEUE STATUS
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
	AX < 0	error code (see AX=CB01h)
SeeAlso: AX=CB12h
----------2FCB11DL03-------------------------
INT 2F - Multiplex - Communicating Apps Spec v1.2+ - GET NUM SEND EVENTS
	AX = CB11h
	DL = 03h
Return: AX = number of successful sends since resident manager started
	BX = number of unsuccessful sends, including warnings
SeeAlso: AX=CB11h/DL=04h
----------2FCB11DL04-------------------------
INT 2F - Multiplex - Communicating Apps Spec v1.2+ - GET NUM RECEIVE EVENTS
	AX = CB11h
	DL = 04h
Return:	AX = number of received file events since resident manager started
	BX = number of received FAX events
SeeAlso: AX=CB11h/DL=03h
----------2FCB12-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - GET HARDWARE STATUS
	AX = CB12h
	DS:DX -> 128-byte status buffer
Return: AX = 0000h successful
		buffer filled with hardware-dependent status information
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB10h,AX=CB11h

Format of status buffer for Intel Connection CoProcessor:
Offset	Size	Description
 00h	BYTE	bit flags
		bit 7: hardware busy sending or receiving
		bit 6: last page of data
		bit 5: no data on current page
		bit 4: retransmit request for current page being transmitted
		bit 3: NSF mode active
		bits 2-0: reserved
 01h	BYTE	number of kilobytes of free buffer space
 02h	BYTE	page buffer status
		bit 7: Connection CoProcessor has documents to send
		bits 6-0: number of pages in buffer
 03h	BYTE	number of retries left for dialing number
 04h	BYTE	page number to retransmit
 05h	BYTE	communications status
		bit 7: originating call
		bit 6: FAX message to be sent
		bit 5: on line
		bit 4: ring detected and receive enabled
		bit 3: buffer dumped on receive
		bits 2-0: hardware sequence state
			000 idle
			001 dial
			010 answer
			011 transmit
			100 receive
			101 pre-message
			110 post-message
			111 disconnect
 06h	BYTE	baud rate
		bit 7: reserved
		bits 6-4: baud rate
			000 = 300 baud	(V.21 SDLC or HDLC mode)
			100 = 2400 baud (V.27 ter)
			101 = 4800 baud (V.27 ter)
			110 = 7200 baud (V.29)
			111 = 9600 baud (V.29)
		bits 3-0: reserved, should be 0110
 07h  3 BYTEs	reserved
 0Ah	BYTE	hardware status
		bit 7: modem option installed
		bit 6: Connection CoProcessor has control of DAA (not latched)
		bit 5: on line (not latched)
		bit 4: ring detected (not latched)
		bit 3: data in command buffer (not latched)
		bit 2: set if using DMA channel 1, clear if using DMA channel 3
		bit 1: line length compensation bit 1 set (not latched)
		bit 0: line length compensation bit 0 set (not latched)
 0Bh	BYTE	switch states
		bit 7: reserved
		bit 6: unused
		bit 5: spare switch open
		bit 4: FAX ADR1 switch open
		bit 3: FAX ADR0 switch open
		bit 2: alternate interrupt switch open
		bit 1: COM SEL 1 switch open
		bit 0: COM SEL 0 switch open
			Note: valid combinations of bits 0-2 are
				000  COM2 IRQ3 IObase 2F8h
				001  COM1 IRQ4 IObase 3F8h
				010  COM4 IRQ3 IObase 2E8h
				011  COM3 IRQ4 IObase 3E8h
				110  COM4 IRQ2 IObase 2E8h
				111  COM3 IRQ5 IObase 3E8h
 0Ch	BYTE	bit flags
		bit 7: reserved
		bit 6: auxiliary relay forced ON
		bit 5: modem select relay forced ON
		bit 4: offhook relay forced ON
		bit 3: 9600 bps enabled
		bit 2: 7200 bps enabled
		bit 1: 4800 bps enabled
		bit 0: 2400 bps enabled
 0Dh	BYTE	reserved
 0Eh	WORD	error count (only valid while busy, reset when idle)
 10h	DWORD	size of nonstandard format (NSF) file in bytes
 14h	BYTE	'A' if Connection CoProcessor board present
 15h  9 BYTEs	reserved
 1Eh 21 BYTEs	ASCIZ CCITT identification
 33h 77 BYTEs	reserved

Format of status buffer for Intel SatisFAXtion board:
Offset	Size	Description
 00h	BYTE	connection status flags
		bit 7: busy in T.30 CCITT fax protocol
		bit 6: data on current page/file (only used for block xfers)
		bit 5: retransmission of last page requested
		bit 4: in file transfer mode
		bit 3: data in buffer
		bit 2: data buffer dumped on receive
		bit 1: 200x100 dpi resolution instead of 200x200 dpi
		bit 0: data modem in use, FAX image modem not available
 01h	BYTE	board state
		bit 7: reserved
		bit 6: handset jack active, data and FAX modems not available
		bits 5-3: current bit rate
		    000	 300 bps (V.21 HDLC)
		    100 2400 bps (V.27 ter)
		    101 4800 bps (V.27 ter)
		    110 7200 bps (V.29)
		    111 9600 bps (V.29)
		bits 2-0: T.30 CCITT protocol state
		    000 idle
		    001 dialing
		    010 answering
		    011 transmitting
		    100 receiving
		    101 pre-message
		    110 post-message
		    111 disconnect
 02h	BYTE	number of KB free in buffer
 03h	BYTE	number of pages or files in buffer
 04h	BYTE	number of redials remaining on current number
 05h	BYTE	FAX page number to retransmit
 06h	BYTE	current page/file in block transfer
 07h	BYTE	number of rings received (only if auto-answer enabled)
 08h	WORD	error count
 0Ah	DWORD	length of file being transferred
 0Eh  6 BYTEs	reserved
 14h	BYTE	'B' is SatisFAXtion board present
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
----------2FCB13DL00-------------------------
INT 2F - Multiplex - Communicating Applications Spec - GET DIAGNOSTICS RESULTS
	AX = CB13h
	DL = 00h
Return: AX = 0040h in progress
	   >= 0	   passed
	   < 0	   hardware-dependent failure code (see below)
SeeAlso: AX=CB13h/DL=01h

Intel Connection CoProcessor failure codes:
	bit 3: 9600 bps FAX modem module failed
	bit 2: SDLC chip failed
	bit 1: RAM failed
	bit 0: ROM checksum failed

Intel SatisFAXtion failure codes:
	bit 1: 2400 bps data modem failed
	bit 0: 9600 bps FAX modem failed
----------2FCB13DL01-------------------------
INT 2F - Multiplex - Communicating Applications Spec - START DIAGNOSTICS
	AX = CB13h
	DL = 01h
Return: AX = 0000h successfully started
	   < 0	   error code (see AX=CB01h)
SeeAlso: AX=CB13h/DL=00h
----------2FCB14-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - MOVE RECEIVED FILE
	AX = CB14h
	BX = event handle
	CX = receive file number
	     0001h first received file
	     N	   Nth received file
	DS:DX -> ASCIZ string specifying new name for file (must not exist)
Return: AX = 0000h successful
	   < 0	   error code (see AX=CB01h)
----------2FCB15-----------------------------
INT 2F - Multiplex - Communicating Applications Spec - SUBMIT FILE TO SEND
	AX = CB15h
	DS:DX -> variable-length data area (see below)
Return: AX >= 0	event handle
	   < 0	error code (see AX=CB01h)
SeeAlso: AX=CB01h

Format of data area:
Offset	Size	Description
 00h	BYTE	transfer type
		00h = 200x200 dpi, fax mode
		01h = 100x200 dpi, fax mode
		02h = file transfer mode
		03h to 7Fh reserved
 01h	BYTE	text size
		00h = 80 columns
		01h = 132 columns
		02h to 7Fh reserved
 02h	WORD	time to send (DOS packed time format, see INT 21/AX=5700h)
 04h	WORD	date to send (DOS packed date format, see INT 21/AX=5700h)
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
----------2FCB16BX1234-----------------------
INT 2F - Multiplex - Communicating Apps Spec v1.2+ - UNLOAD RESIDENT MANAGER
	AX = CB16h
	BX = 1234h
	CX = 5678h
	DX = 9ABCh
Return: AX = 0000h successful
	   < 0	   error code
SeeAlso: AX=CB00h
----------2FCB17-----------------------------
INT 2F - Multiplex - Communicating Apps Spec v1.2+ - SET COVER PAGE STATUS
	AX = CB17h
	BX = event handle
	CL = cover page status
	    00h not read
	    01h read by user
Return: AX = 0000h successful
	   < 0	   error code
----------2FCD00-----------------------------
INT 2F - Multiplex - Intel Image Processing Interface - INSTALLATION CHECK
	AX = CD00h
Return: AL = 00h not installed, OK to install
	     01h not installed, not OK to install
	     FFh installed
----------2FCD00-----------------------------
INT 2F - Multiplex - SWELL.EXE - INSTALLATION CHECK
	AX = CD00h
Return: AX = 00FFh installed
	    BH = major version
	    BL = minor version
Note:	SWELL.EXE is a TSR which swaps programs to disk when they EXEC a child
	  process with INT 21/AH=4Bh
----------2FCD01-----------------------------
INT 2F - Multiplex - Intel Image Processing Interface - SET DEVICE NAME
	AX = CD01h
	CX:BX -> ASCIZ character device name ("LPTn", "COMn", "PRN")
Return: AL = 00h successful
		CX:BX -> internal character device name
	   = 80h error
----------2FCD01-----------------------------
INT 2F - Multiplex - SWELL.EXE - SUSPEND ONCE
	AX = CD01h
Return: AX = 0000h
SeeAlso: AX=CD02h"SWELL"
----------2FCD02-----------------------------
INT 2F - Multiplex - Intel Image Processing Interface - GET VERSION NUMBER
	AX = CD02h
Return: AL = 00h/01h successful
		BH = major version number (BCD)
		BL = minor version number (BCD)
	   = 80h error
Note:	if return AL = 01h, the IPI supports network redirection
----------2FCD02-----------------------------
INT 2F - Multiplex - SWELL.EXE - SUSPEND
	AX = CD02h
Return: AX = 0000h
SeeAlso: AX=CD03h"SWELL"
----------2FCD03-----------------------------
INT 2F - Multiplex - Intel Image Processing Interface - SELECT SCAN LINE
	AX = CD03h
	BX = scan line
	CX = requested density in dots per inch (300, 600, or 1200)
Return: AL = 00h succesful
		CX = density at which scan line was mapped
		ES:DI -> start of scan line
	AL = 80h unsuccessful
	   = 81h scan line out of range
	   = 82h unsupported scan line density
	   = 83h out of memory
----------2FCD03-----------------------------
INT 2F - Multiplex - SWELL.EXE - ACTIVATE
	AX = CD03h
Return: AX = 0000h
SeeAlso: AX=CD02h"SWELL"
----------2FCD04-----------------------------
INT 2F - Multiplex - Intel Image Processing Interface - MOVE BITMAP TO SCANLINE
	AX = CD04h
	CX:BX -> structure (see below)
Return: AL = 00h successful
	   = 80h unsuccessful
	   = 81h scan line out of range
	   = 82h unsupported scan line density
	   = 83h out of memory
	   = 84h unrecognized source
	   = 85h initialization error

Format of structure:
Offset	Size	Description
 00h	WORD	image source (0 = conventional memory, 1 = expanded memory)
 02h	DWORD	pointer to image data
 06h	WORD	scan line on which to place
 08h	WORD	bit offset from start of scan line at which to place
 0Ah	WORD	density of bitmap data (300, 600, or 1200 dpi)
 0Ch	WORD	width in bits of data
 0Eh	WORD	source logical page number
 10h	WORD	source handle (only if source in expanded memory)
 12h	WORD	source offset (only if source in expanded memory)
----------2FCD04-----------------------------
INT 2F - Multiplex - SWELL.EXE - TURN OFF VERBOSE MODE
	AX = CD04h
Return: AX = 0000h
SeeAlso: AX=CD05h"SWELL"
----------2FCD05-----------------------------
INT 2F - Multiplex - Intel Image Processing Interface - PRINT PAGE
	AX = CD05h
Return: AL = 00h successful
	   = 80h unsuccessful
Note:	page image is retained, so multiple calls will print multiple copies of
	  the page
----------2FCD05-----------------------------
INT 2F - Multiplex - SWELL.EXE - TURN ON VERBOSE MODE
	AX = CD05h
Return: AX = 0000h
SeeAlso: AX=CD04h"SWELL"
----------2FCD06-----------------------------
INT 2F - Multiplex - Intel Image Processing Interface - CLEAR PAGE
	AX = CD06h
Return: AL = 00h successful
	   = 80h unsuccessful
Note:	palette is reset to default
----------2FCD06-----------------------------
INT 2F - Multiplex - SWELL.EXE - UNINSTALL
	AX = CD06h
Return: AX = 0000h uninstalled
	   = 8002h programs still swapped, not uninstalled
----------2FCD07-----------------------------
INT 2F - Multiplex - Intel Image Processing Interface - reserved
	AX = CD07h
----------2FCD07-----------------------------
INT 2F - Multiplex - SWELL.EXE - GET INFO
	AX = CD07h
	ES:BX -> 32-byte buffer for info
Return: AX = 0000h successful
	    ES:BX buffer filled
	   = 8001h buffer wrong size

Format of info buffer:
Offset	Size	Description
 00h	WORD	20h  (total size of buffer)
 02h	BYTE	suspend-once mode active if nonzero
 03h	BYTE	00h active, 01h suspended
 04h	BYTE	00h quiet, 01h verbose
 05h	BYTE	"Borland support" (allowing INT 21/AX=4B01h) on if nonzero
 06h 26 BYTEs	unused???
----------2FCD08-----------------------------
INT 2F - Multiplex - Intel Image Processing Interface - SCREEN IMAGE
	AX = CD08h
	CX:BX -> structure (see below)
Return: AL = 00h successful
	   = 80h unsuccessful
	   = 81h scan line out of range
	   = 82h unsupported scan line density
	   = 83h out of memory
	   = 84h unrecognized source
	   = 85h initialization error

Format of structure:
Offset	Size	Description
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
----------2FCD08-----------------------------
INT 2F - Multiplex - SWELL.EXE - UNUSED
	AX = CD08h
Return: AX = FFFFh (error)
----------2FCD09-----------------------------
INT 2F - Multiplex - Intel Image Processing Interface - LOAD SCREEN
	AX = CD09h
	CX:BX -> structure (see below)
Return: AL = 00h successful
	   = 80h unsuccessful
SeeAlso: AX=CD0Ah"Image Processing"

Format of structure:
Offset	Size	Description
 00h	BYTE	style
		44h ('D') diamond style
		4Ch ('L') line style
 01h	BYTE	reserved (00h)
 02h	WORD	frequency in lines per inch [sic]
		currently, coerced to nearest of 50, 60, 68, 70, 75, 85, or 100
 04h	WORD	screen angle in degrees (-360 to 360)
		currently coerced to nearest of -45, 0, 45, or 90
----------2FCD09-----------------------------
INT 2F - Multiplex - SWELL.EXE - TURN OFF "BORLAND SUPPORT"
	AX = CD09h
Return: AX = 0000h
SeeAlso: AX=CD0Ah"SWELL"
----------2FCD0A-----------------------------
INT 2F - Multiplex - Intel Image Processing Interface - LOAD PALETTE
	AX = CD0Ah
	CX:BX -> palette structure (see below)
Return: AL = 00h successful
	   = 80h unsuccessful
SeeAlso: AX=CD09h"Image Processing"

Format of palette structure:
Offset	Size	Description
 00h	BYTE	bits per pixel for which palette is to be used (1,2,4,6, or 8)
 01h	2**N	palette translation values, one per possible pixel value
----------2FCD0A-----------------------------
INT 2F - Multiplex - SWELL.EXE - TURN ON "BORLAND SUPPORT"
	AX = CD0Ah
Return: AX = 0000h
SeeAlso: AX=CD09h"SWELL"
----------2FD000-----------------------------
INT 2F - MDEBUG display driver - GET DRIVER STATUS
	AX = D000h
Return: CF set on error
	    all other registers must be unchanged)
	CF clear if successful
	    AL = FFh
	    AH = driver semaphor
		00h driver is not active
		01h driver is active
	    BX = CS of the driver
	    CX = driver version (CH = major, CL = minor, must be >= 0151h)
	    DL = buffer semaphor
		00h driver is not pending
		01h driver is pending between functions 02h and 03h
	    DH = show semaphor
		00h driver is not pending
		01h driver is pending between functions 04h and 05h
Notes:	MDEBUG is a shareware memory-resident debugger by Bernd Schemmer
	MDEBUG can use any two consecutive multiplex numbers between C0h and
	  FFh; the default is D0h for the display driver and D1h for the
	  command driver (see INT 60/AH=00h"MDEBUG" for the actual multiplex
	  numbers used)
	this function MUST be reentrant, as MDEBUG calls it after every popup
	  before any other actions.  The handler should not change any
	  registers if the display is in an unsupported mode or in a mode
	  MDEBUG supports itself, e.g. a normal text mode like 80x25 or
	  132x44 (v1.60+). In this case MDEBUG will not call any of the other
	  functions for this popup session.
	MDEBUG will not call the other functions if the returned version is
	  less than the actual version of MDEBUG.
	if the driver is reentrant, DL and DH should be 00h
SeeAlso: AX=D001h,AX=D002h,AX=D003h,AX=D004h,AX=D005h
----------2FD001-----------------------------
INT 2F - MDEBUG display driver - INITIALIZE DRIVER
	AX = D001h
Return: CF set on error
	AL = driver semaphor
	AH = buffer semaphor
Notes:	MDEBUG calls this function after every succesful call of the function
	  00h. The function should reset all internal data and the status of
	  the driver. If this function returns an error, MDEBUG will not call
	  the other functions in this popup session.
	MDEBUG can use any two consecutive multiplex numbers between C0h and
	  FFh; the default is D0h for the display driver and D1h for the
	  command driver
SeeAlso: AX=D000h
----------2FD002-----------------------------
INT 2F - MDEBUG display driver - SAVE GRAPHIC DATA
	AX = D002h
Return: CF set on error
	CF clear if successful
	    display memory saved and display switched to one of the text modes
	      02h, 03h or 07h.
Note:	MDEBUG calls this function only once every popup session before
	  displaying its windows.
SeeAlso: AX=D000h,AX=D003h
----------2FD003-----------------------------
INT 2F - MDEBUG display driver - RESTORE GRAPHIC DATA
	AX = D003h
Return: CF set on error
	CF clear if successful
	    display restored to the mode it was in before calling AX=D002h and
	      the display memory is restored
Note:	MDEBUG calls this function only once every popup session just before
	 it exits to normal DOS.
SeeAlso: AX=D000h,AX=D002h
----------2FD004-----------------------------
INT 2F - MDEBUG display driver - SHOW SAVED DATA
	AX = D004h
Return: CF set on error
	CF clear if successful
	    display switched to mode it was in before calling AX=D002h and the
	      display memory is restored
Note:	This function needn't save the display memory before changing it.
SeeAlso: AX=D000h,AX=D005h
----------2FD005-----------------------------
INT 2F - MDEBUG display driver - SWITCH BACK TO TEXT SCREEN
	AX = D005h
Return: CF set on error
	CF clear if successful
	    display restored to mode it was in before calling AX=D004h
Note:	This function needn't save or change the display memory
SeeAlso: AX=D000h,AX=D004h
----------2FD0-------------------------------
INT 2F - MDEBUG display driver - RESERVED FUNCTION NUMBERS
	AH = D0h
	AL = 06h-7Fh
Note:	these functions are reserved for future use
----------2FD0-------------------------------
INT 2F - MDEBUG display driver - USER DEFINED FUNCTION NUMBERS
	AH = D0h
	AL = 80h-FFh
Note:	these functions numbers are reserved for user defined features (e.g.
	  communication between the transient und resident parts of the driver)
----------2FD100-----------------------------
INT 2F - MDEBUG command driver - GET STATUS
	AX = D100h
	BX = version of MDEBUG (BH = major, BL = minor)
	CX = command driver counter
Return: DL = FFh
	BX = version number of the driver if it is less than the version in BX,
	     else unchanged
	CX incremented
---v1.60+---
	DS:SI -> MDEBUG identification table (see below)
	ES = segment of display memory used by MDEBUG
	DI = size of video mode used by MDEBUG
	    (high byte = lines, low byte = columns)
Notes:	MDEBUG is a shareware memory-resident debugger by Bernd Schemmer
	MDEBUG can use any two consecutive multiplex numbers between C0h and
	  FFh; the default is D0h for the display driver and D1h for the
	  command driver (see INT 60/AH=00h"MDEBUG" for the multiplex numbers
	  actually used)
	this function must end with a far call to the old INT 2F handler after
	  changing the registers
	this function MUST be reentrant
	if the version number returned in BX is less than 1.52, MDEBUG will
	  not call any of the other functions during this popup session
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
Offset	Size	Description
 -2	WORD	entry offset
 00h	WORD	CS of MDEBUG
 02h	DWORD	old INT 08h vector
 06h	DWORD	old INT 09h vector
 0Ah	DWORD	address INT 16h routine used by MDEBUG
 0Eh	BYTE	length of version string
 0Fh  N BYTEs	version string
----------2FD101-----------------------------
INT 2F - MDEBUG command driver - INITIALIZE DRIVER
	AX = D101h
	CX = command driver counter
Return: DL = FFh if successful
		CX incremented
	     else error: all registers unchanged
Note:	this function must end with a  far call to the old INT 2F handler after
	  changing the registers
	this function must be reentrant
----------2FD102-----------------------------
INT 2F - MDEBUG command driver - EXECUTE DEBUGGER COMMAND
	AX = D102h
	BL = first character of the debugger command
	BH = last character of the debugger command (or blank)
	DS:SI -> parameter for the debugger command as ASCIZ string
	DS:DI -> MDEBUG data structure (see below)
Return: AL = FFh
	CF set on error
	    AH = error number
		01h syntax error
		02h first shell of the command.com is activ
		03h esc pressed
		04h break pressed
		05h DOS is busy
		06h command ended
		07h division by zero
		08h invalid display driver
		09h invalid command driver
		0Ah error 8 and 9
		0Bh unknown error
		0Ch new error
		    DS:SI -> ASCIZ error message (max 30 characters)
	       else unknown error
	CF clear if successful
	    AH = return code
		00h continue processing the command line
		01h leave MDEBUG popup session
		02h leave MDEBUG popup session and automatically popup again
		    if the InDOS flag is zero
		03h put new command line into the input buffer,
		    DS:SI -> new command line (ASCIZ string, max 66 chars)
		04h process new command line
		    DS:SI -> new command line (ASCIZ string, max 66 chars)
	       else unknown status, but continue processing commmand line
Note:	this function must end with a far call to the old INT 2F handler (with
	  registers unchanged) if the driver does not support the debugger
	  command in BX.  Otherwise, the driver must not chain to the old
	  INT 2F.

Format of MDEBUG data structure:
Offset	Size	Description
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
 36h	WORD	saved data for key <F6>, segment
 38h	WORD	saved data for key <F6>, offset
 3Ah 12 WORDs	saved registers for the key <F8>
		(original register values at popup entry of MDEBUG)
		AX, BX, CX, DX, SI, DI, DS, ES, BP, SS, SP, flags
 52h 12 WORDs	saved registers for the key <SHIFT-F8>
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
----------2FD103-----------------------------
INT 2F - MDEBUG command driver - EXECUTE KEY IN THE MONITOR
	AX = D103h
	BX = key code (like result of an interrupt 16h call)
	CX = 0 -> the cursor is in the ASCII column of the monitor
	CX = 1 -> the cursor is in one of the hex fields of the monitor
	DS:SI -> MDEBUG data structure (see AX=D102h)
	ES:DI -> actual byte in the monitor
Return: AL = FFh
	AH = return code
	    00h key processed, read next key
	    01h leave MDEBUG popup session
	    02h leave MDEBUG popup session and automatically popup again if DOS
		is not busy
	    03h signal an error (beep)
	    04h driver has redefinded the key, proceed with the new key
		BX = new key code
		MDEBUG will not pass the new key to the command driver
	   else treat like code 00h
Note:	this function must end with a far call to the old INT 2F handler (with
	  registers unchanged) if the driver does not support the key in BX.
	  Otherwise, the driver must not chain to the old INT 2F.
SeeAlso: AX=D104h
----------2FD104-----------------------------
INT 2F - MDEBUG command driver - EXECUTE KEY IN THE DEBUGGER
	AX = D104h
	DS:SI -> MDEBUG data structure (see AX=D102h)
Return: AL = FFh
	AH = return code
	    00h key processed, read next key
	    01h leave MDEBUG popup session
	    02h leave MDEBUG popup session and automactically popup again if
		DOS is not busy
	    03h signal an error (beep)
	    04h driver has redefinded the key, proceed with the new key
		BX = new key code
		MDEBUG won't pass the new key to the command driver
	    05h put new command line into the input buffer
		DS:SI -> new command line (ASCIZ string, max 66 chars)
	    06h process new command line
		DS:SI -> new command line (ASCIZ string, max 66 chars)
	   else treat like code 00h
Note:	this function must end with a far call to the old INT 2F handler if the
	  driver does not support the key in BX.  Otherwise, the driver must
	  not chain to the old INT 2F.
SeeAlso: AX=D103h
----------2FD1-------------------------------
INT 2F - MDEBUG command driver - RESERVED FUNCTIONS
	AH = D1h
	AL = 05h-0Ah
Note:	these functions are reserved for future use
----------2FD110-----------------------------
INT 2F - MDEBUG command driver - GET ADDRESS OF THE OLD INT 2F
	AX = D110h
Return: DL = FFh
	ES:BX -> next program in the chain for INT 2F
	CX = code segment of this driver
	DI = offset of driver identification table (see below) (v1.60+)
Notes:	only called by the transient part of the driver
	must be reentrant and the driver must not chain this function to the
	  old INT 2F

Format of the driver identification table:
Offset	Size	Description
 00h  26 BYTEs	 signature "Kommandotreiber fÅr MDEBUG"
 27h  12 BYTEs	 name of driver, e.g. "MDHISDRV.COM"
		 each driver must have a unique name
----------2FD111-----------------------------
INT 2F - MDEBUG command driver - START DRIVER
	AX = D111h
Return: DL = FFh
Notes:	only called by the transient part of the driver to inform the resident
	  part that it is installed
	the function must be reentrant and the driver mustn't chain this
	  function to the old INT 2F
SeeAlso: AX=D101h,AX=D112h
----------2FD112-----------------------------
INT 2F - MDEBUG command driver - END DRIVER
	AX = D112h
Return: DL = FFh
Notes:	only called by the transient part of the driver to inform the resident
	  part that it will be released after this function
	the function must be reentrant and the driver mustn't chain this
	  function to the old INT 2F
SeeAlso: AX=D101h,AX=D111h
----------2FD1-------------------------------
INT 2F - MDEBUG command driver - RESERVED FUNCTIONS
	AH = D1h
	AL = 13h-7Fh
Note:	these functions are reserved for future use
----------2FD1-------------------------------
INT 2F - MDEBUG command driver - USER DEFINED FUNCTIONS
	AH = D1h
	AL = 80h-FFh
Note:	these functions are reserved for user defined features (e.g.
	  communication between the transient und resident parts of the	driver)
----------2FD200BX5144-----------------------
INT 2F - Multiplex - Quarterdeck QEMM/QRAM/MFT 5.0 - INSTALLATION CHECK
	AX = D200h
	BX = 5144h ("QD")
	CX = 4D45h ("ME")
	DX = 4D30h ("M0")
Return: AL = FFh installed	  
	if BX,CX,DX registers were as specified on entry:
	    BX = 4D45h ("ME")
	    CX = 4D44h ("MD")
	    DX = 5652h ("VR")
Notes:	QEMM/QRAM/VIDRAM/MANIFEST will search for a free AH value from D2h
	  through FFh, then C0h through D1h
	QEMM and QRAM both responded the same
	for AL <> 0, if the BX/CX/DX values don't match a the identifier of a
	  Quarterdeck product, it just chains to the previous INT 2F handler
----------2FD201BX4849-----------------------
INT 2F - Multiplex - Quarterdeck QEMM/QRAM 5.0 - GET HIRAM MEMORY CHAIN
	AX = D201h
	BX = 4849h ("HI")
	CX = 5241h ("RA")
	DX = 4D30h ("M0")
Return: BX = 4F4Bh ("OK")
	CX = segment of start of HIRAM chain
	DX = QEMM/QRAM code segment
Notes:	QEMM/QRAM/VIDRAM/MANIFEST will search for a free AH value from D2h
	  through FFh, then C0h through D1h
	QEMM and QRAM both responded the same
	the HIRAM memory chain has the same format as the regular DOS 4.0
	  memory chain (see INT 21/AH=52h), except that XMS Upper Memory Blocks
	  have the block header program name field set to "UMB"
----------2FD201BX5145-----------------------
INT 2F - Multiplex - Quarterdeck QEMM 5.0+ - INSTALLATION CHECK
	AX = D201h
	BX = 5145h ("QE")
	CX = 4D4Dh ("MM")
	DX = 3432h ("42")
Return: BX = 4F4Bh ("OK")
	ES:DI -> QEMM API entry point (see INT 67/AH=3Fh)
Note:	QEMM/QRAM/VIDRAM/MANIFEST will search for a free AH value from D2h
	  through FFh, then C0h through D1h
SeeAlso: INT 67/AH=3Fh
----------2FD201BX5649-----------------------
INT 2F - Multiplex - Quarterdeck VIDRAM 5.0 - INSTALLATION CHECK
	AX = D201h
	BX = 5649h ("VI")
	CX = 4452h ("DR")
	DX = 414dh ("AM")
Return: BX = 4F4Bh ("OK")
	ES:DI -> VIDRAM entry point
Note:	QEMM/QRAM/VIDRAM/MANIFEST will search for a free AH value from D2h
	  through FFh, then C0h through D1h

Call VIDRAM entry point with:
	AH = 00h get status
		Return: AL = VIDRAM state (see below)
			BL = bit 0: ???
			     bits 1-7 not used
			BH = ???
			CL = current monitor (01h = mono, 80h = color)
			SI = current top of memory (paragraph)???
			DI = segment of ???
	AH = 01h setup
		AL = VIDRAM state (00h off, 01h no EGA graphics, 02h no graph)
		BL = bit 0: ???
		     bits 1-7 not used
		BH = ???
		CL = monitor (01h = monochrome, 80h = color)
		SI = new top of memory (paragraph)???
	AH = 02h get ???
		Return: ES:DI -> ??? data
Return: CF set on error
	CF clear if successful
----------2FD201BX4D41-----------------------
INT 2F - Multiplex - Quarterdeck MANIFEST 5.0 - INSTALLATION CHECK
	AX = D201h
	BX = 4D41h ("MA")
	CX = 4E49h ("NI")
	DX = 4645h ("FE")
Return: BX = 5354h ("ST")
Note:	QEMM/QRAM/VIDRAM/MANIFEST will search for a free AH value from D2h
	  through FFh, then C0h through D1h
----------2FD300BX4562-----------------------
INT 2F - Multiplex - TeleReplica - INSTALLATION CHECK
	AX = D300h
	BX = 4562h
	CX = 2745h
	DX = ??? (03F8h for v3.9)
Return: SI = segment of resident code
	AX = 251Dh
	BX = DF21h
	CX = F321h
	DX = ???
----------2FD3CB-----------------------------
INT 2F - LapLink Quick Connect v6 - API
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
----------2FD44D-----------------------------
INT 2F - Multiplex - 4DOS.COM v2.1+
	AX = D44Dh
	BH = function
	    00h installation check
		Return: AX = 44DDh
			BL = minor version number
			BH = major version number
			CX = PSP segment address for current invocation
			DL = 4DOS shell number (0 for the first (root) shell,
			     updated each time a new copy is loaded)
	    01h (internal, v2.1-3.03) terminate current copy of 4DOS
	    	Return: nothing
	    	(internal, v4.0) ???
		Return: ES:BX -> data area (see below)
	    02h ???
		DX = ???
	---v2.1-3.03 only---
	    03h EXEC program
		CX:DX -> EXEC record
	    FEh deallocate shell number (passed through to root shell)
		???
	    FFh allocate shell number (passed through to root shell)
Note:	bug in v3.00 will crash system if unrecognized value in BH
SeeAlso: AX=D44Eh,AX=E44Dh,INT 21/AX=4403h

Format of EXEC record:
Offset	Size	Description
 00h	WORD	offset of ASCIZ program name in same segment as EXEC record
 02h	WORD	offset of DOS commandline in same segment as EXEC record
 04h	WORD	segment of environment for child process (see INT 21/AH=26h)

Format of 4DOS v4.0 data area:
Offset	Size	Description
 00h  2 BYTEs	???
 06h	WORD	XMS handle for swapping
 	???
----------2FD44E-----------------------------
INT 2F - Multiplex - 4DOS.COM v3.0+ - AWAITING USER INPUT
	AX = D44Eh
---4DOS v3.01+---
	BX = 0000h 4DOS is ready to display prompt
	   = 0001h 4DOS has displayed the prompt, about to accept user input
Return: handler must preserve SI, DI, BP, SP, DS, ES, and SS
Note:	v3.00 only makes the call corresponding to BX=0001h, does not set BX
SeeAlso: AX=D44Dh
----------2FD44FBX0000-----------------------
INT 2F - Multiplex - 4DOS.COM v4.0+ - KSTACK.COM INSTALLATION CHECK
	AX = D44Fh
	BX = 0000h
Return: AX = 44DDh if installed
SeeAlso: AX=D44Fh/BX=0001h
----------2FD44FBX0001-----------------------
INT 2F - Multiplex - 4DOS.COM v4.0+ - PLACE KEYSTROKES INTO KEYSTACK
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
SeeAlso: AX=D44Fh/BX=0000h,INT 16/AH=00h,INT 21/AX=4403h
----------2FD600-----------------------------
INT 2F - Multiplex - HEART.COM - INSTALLATION CHECK
	AX = D600h
Return: AX = 0303h (two hearts) if installed
	    ES:DI -> buffer (see below)
Note:	HEART.COM is a CPU lock-up/critical indicator utility by Mitch Davis.
	Once the host program has identified the address of the data area, it
	  can change this to indicate safe/critical, alternate colours, etc.
	The entries for the color table are in char/attrib form.  Every two
	  entries form a pair which is alternated between 68 times a minute.
	  The first half of the table is for color videos, the second mono.
	  Within each half, the first half is for the safe chars, and the
	  second for the critical chars.

Format of buffer:
Offset	Size	Description
 00h  8 WORD	Table of colors/attributes (see notes).
 10h	BYTE	flags
 		bit 0: program is in critical section, so flash double
			exclamation mark
		bit 1: program is in safe code, so flash the heart character
 11h	WORD	position of heartbeat on screen, normally 009Eh (last column
 		of second line)
----------2FD701-----------------------------
INT 2F - Multiplex - BANYAN VINES v4+ - GET BANV INTERRUPT NUMBER
	AX = D701h
Return: AX = 0000h installed
	    BX = interrupt number (60h to 66h)
	   nonzero not present
Note:	if AX is nonzero, VINES 3.x or earlier may be installed, thus it is
	  necessary to examine the four bytes preceding the handlers for
	  INT 60 through INT 66 for the string "BANV"
----------2FDA55-----------------------------
INT 2F - Multiplex - TRAP.COM - INSTALLATION CHECK
	AX = DA55h
	DL = interrupt number
	DH = ???
Return: if installed
	    AH = interrupt number
	    AL = ???
	    ES:BX -> ???
Notes:	TRAP is an interrupt call tracer by Patrick Phillipot/Udo Chrosziel
	a separate copy of TRAP is loaded for each interrupt to be traced; thus
	  the interrupt number is part of the installation check
----------2FDC00-----------------------------
INT 2F - Multiplex - GOLD.COM - INSTALLATION CHECK
	AX = DC00h
Return: AL = 00h not installed
	   = FFh installed
Note:	GOLD is a TSR by Bob Eager which makes the NumLock key return the code
	  for F1; the purpose is to improve Kermit's VTxxx emulation
----------2FDC01-----------------------------
INT 2F - Multiplex - GOLD.COM - GET STATE
	AX = DC01h
Return:	AL = status
	    00h off
	    01h on
SeeAlso: AX=DC00h,AX=DC02h
----------2FDC02-----------------------------
INT 2F - Multiplex - GOLD.COM - SET STATE
	AX = DC02h
	DL = new state
	    00h off
	    01h on
Return: AL = 00h (OK)
SeeAlso: AX=DC01h
----------2FDD-------------------------------
INT 2F - SoftCom programs - API
	AH = DDh
	AL = FEh get info
	    Return: ES:BX -> TSR info list (see below)
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

Format of TSR info list:
Offset	Size	Description
 00h  9 BYTEs	blank-padded ASCIZ program name
 09h	BYTE	program ID
 0Ah	WORD	program's PSP segment
 0Ch	WORD	program version (major in high byte)
 0Eh	DWORD	pointer to next item in info list or 0000h:0000h
 12h	BYTE	number of interrupts hooked
 13h  5 BYTEs	interrupt numbers hooked by program
 18h  8 BYTEs	reserved
----------2FDE00BX4445-----------------------
INT 2F - DESQview 2.26+ External Device Interface - INSTALLATION CHECK
	AX = DE00h
	BX = 4445h ("DE")
	CX = 5844h ("XD")
	DX = 4931h ("I1")
Return: AL = FFh if installed (even if other registers do not match)
	if BX,CX, and DX were as specified on entry,
	    BX = 4845h ("HE")
	    CX = 5245h ("RE")
	    DX = 4456h ("DV")
Notes:	AH=DEh is the default XDI multiplex number, but may range from C0h-FFh
	programs should check for XDI starting at DEh to FFh, then C0h to DDh
	the XDI handler should not issue any DOS or BIOS calls, nor should it
	  issue DESQview API calls other than those allowed from hardware ints
----------2FDE01-----------------------------
INT 2F - DESQview 2.26+ External Device Interface - DRIVER CUSTOM SUBFUNCTION
	AX = DE01h
	BX = driver ID
	other registers as needed by driver
Notes:	XDI drivers should pass this call through to previous handler if ID
	  does not match
	DESQview never calls this function
----------2FDE01BX5242-----------------------
INT 2F - DESQview 2.26+ XDI - CUSTOM SUBFUNCTION, Ralf Brown's XDI drivers
	AX = DE01h
	BX = 5242h ("RB")
	CX:DX = program identifier
		656F7000h ("eop",0) for DVeop
Return: AX = 5242h ("RB") if installed
	    ES:BX -> data or entry point
	    CX = version number (CH = major, CL = minor)

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
----------2FDE01BX7474-----------------------
INT 2F - DESQview 2.26+ XDI - CUSTOM SUBFUNCTION, DVTXDI.COM
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
----------2FDE01BX7575-----------------------
INT 2F - DESQview 2.26+ XDI - CUSTOM SUBFUNCTION, DVSIXDI.COM
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
				BX = last instantaneous time slice in 1/100s
				CX = number of processes
				ES:DI -> process info array (see below)
	    0004h get version
		Return: AH = major version
			AL = minor version
	    0005h (v1.10+) get time since DESQview started
		Return: DX:AX = 1/100s since DV start
	    0006h (v1.10+) get number of task switches
		Return: DX:AX = total task switches
			CX = task switches in last instantaneous interval
Notes:	DVSIXDI is part of the DVSI (DESQview System Information) package by
	  Daniel J. Bodoh
	for v1.00, function 0003h allocates common memory, which the caller
	  must deallocate after reading the process information; only the
	  currently used records are placed in the buffer
	for v1.10, function 0003h merely returns a pointer to the internal
	  array of process information; the caller should make a copy of the
	  array while inside a critical section (see INT 15/AX=101Bh).	Only
	  those records with bit 7 of the first byte set are valid.

Format of information for one process (v1.00):
Offset	Size	Description
 00h	BYTE	flags
		bit 7: process slot is valid
 01h 14 BYTEs	???

Format of information for one process (v1.10):
Offset	Size	Description
 00h	BYTE	flags
		bit 7: valid record
		    2: DESQview system task
		    1: task has keyboard (currently unused)
		    0: task swapped out (currently unused)
 01h	WORD	Open Window keys
 03h	WORD	Switch Windows number
 05h	WORD	segment of process handle
 07h	WORD	number of tasks for process
 09h	WORD	process mapping context
 0Bh	DWORD	time process started (relative to start of DESQview)
 0Fh	DWORD	time process last got CPU (relative to start of DESQview)
 13h	DWORD	time process last gave up CPU (relative to start of DESQview)
 17h	DWORD	total CPU time in 1/100s since process started
 1Bh	DWORD	CPU time at start of current instantaneous interval
 1Fh	DWORD	CPU time in current instantaneous interval
 23h	DWORD	hook for other programs
----------2FDE01BXFFFE-----------------------
INT 2F - DESQview 2.26+ XDI - DVXMS.DVR - ???
	AX = DE01h
	BX = FFFEh
	CX = 4D47h ("MG")
	DX = 0052h (0,"R")
Return: AL = FFh
	DX = 584Dh
----------2FDE02-----------------------------
INT 2F - Multiplex - DESQview 2.26 External Device Interface - DV INIT COMPLETE
	AX = DE02h
	BX = mapping context of DESQview
	DX = handle of DESQview system task
SeeAlso: AX=DE03h
Note:	driver should pass this call to previous handler after doing its work
----------2FDE03-----------------------------
INT 2F - Multiplex - DESQview 2.26 External Device Interface - DV TERMINATION
	AX = DE03h
	BX = mapping context of DESQview
	DX = handle of DESQview system task
SeeAlso: AX=DE02h
Notes:	driver should pass this call to previous handler before doing its work
	DESQview makes this call when it is exiting, but before unhooking any
	  interrupt vectors
----------2FDE04-----------------------------
INT 2F - Multiplex - DESQview 2.26 External Device Interface - ADD PROCESS
	AX = DE04h
	BX = mapping context of new process
	DX = handle of process
Return: nothing
Notes:	XMS XDI handler (installed by default) allocates a 22-byte record
	  (see below) from "common" memory to control access to XMS memory
	all DOS, BIOS, and DV API calls are valid in handler
	driver should pass this call to previous handler after processing it
SeeAlso: AX=DE05h

Format of XMS XDI structure:
Offset	Size	Description
 00h	DWORD	pointer to 10-byte record???
 04h	DWORD	pointer to next XMS XDI structure
 08h	WORD	mapping context
 0Ah	BYTE	???
 0Bh  5 BYTEs	XMS entry point to return for INT 2F/AX=4310h
		(FAR jump to next field)
 10h  6 BYTEs	FAR handler for XMS driver entry point
		(consists of a FAR CALL followed by RETF)
----------2FDE05-----------------------------
INT 2F - Multiplex - DESQview 2.26 External Device Interface - REMOVE PROCESS
	AX = DE05h
	BX = mapping context of process
	DX = handle of last task in process
Return: nothing
Notes:	XMS XDI handler releases the structure allocated by AX=DE04h
	driver should pass this call to previous handler before processing it
	all DOS, BIOS, and DV API calls except those generating a task switch
	  are valid in handler
SeeAlso: AX=DE04h
----------2FDE06-----------------------------
INT 2F - Multiplex - DESQview 2.26 XDI - CREATE TASK
	AX = DE06h
	BX = mapping context of process containing task
	DX = handle of new task
Notes:	driver should pass this call to previous handler after processing it
	all DOS, BIOS, and DV API calls are valid in handler
----------2FDE07-----------------------------
INT 2F - Multiplex - DESQview 2.26 XDI - TERMINATE TASK
	AX = DE07h
	BX = mapping context of process containing task
	DX = handle of task
Notes:	driver should pass this call to previous handler before processing it
	all DOS, BIOS, and DV API calls except those generating a task switch
	  are valid in handler
----------2FDE08-----------------------------
INT 2F - Multiplex - DESQview 2.26 XDI - SAVE STATE
	AX = DE08h
	BX = mapping context of task being switched from
	DX = handle of task being switched from
Notes:	invoked prior to task swap, interrupts, etc
	driver should pass this call to previous handler after processing it
----------2FDE09-----------------------------
INT 2F - Multiplex - DESQview 2.26 XDI - RESTORE STATE
	AX = DE09h
	BX = mapping context of task being switched to
	DX = handle of task being switched to
Notes:	state is restored except for interrupts
	driver should pass this call to previous handler before processing it
----------2FDE0A-----------------------------
INT 2F - Multiplex - DESQview 2.26 XDI - CHANGE KEYBOARD FOCUS
	AX = DE0Ah
	BX = mapping context of task receiving focus
	DX = handle of running task
Notes:	driver should pass this call to previous handler before processing it
	this call often occurs inside a keyboard interrupt
----------2FDE0B-----------------------------
INT 2F - Multiplex - DESQview 2.26 XDI - DVP PROCESSING COMPLETE
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
----------2FDE0C-----------------------------
INT 2F - Multiplex - DESQview 2.26 XDI - SWAP OUT PROCESS
	AX = DE0Ch
	BX = mapping context of task being swapped out
	DX = handle of DESQview system task
Note:	driver should pass this call to previous handler after processing it
----------2FDE0D-----------------------------
INT 2F - Multiplex - DESQview 2.26 XDI - SWAP IN PROCESS
	AX = DE0Dh
	BX = mapping context of process just swapped in
	DX = handle of DESQview system task
Note:	driver should pass this call to previous handler before processing it
----------2FDE0E-----------------------------
INT 2F - Multiplex - DESQview 2.26 XDI - DVP START FAILED
	AX = DE0Eh
	BX = mapping context of DESQview system task
	DX = handle of DESQview system task
	SI = mapping context of failed process (same as for call to AX=DE0Bh)
Note:	driver should pass this call to previous handler after processing it
----------2FDF--BX4448-----------------------
INT 2F - Multiplex - HyperDisk v4.20+ - INSTALLATION CHECK
	AH = DFh
	BX = 4448h ('DH')
Return: AL = FFh if installed
	    CX = 5948h ('YH')
	    BX:DX -> ??? in resident portion if BX=4448h on entry
Note:	HyperDisk is a shareware disk cache by HyperWare (Roger Cross)
SeeAlso: INT 13/AX=8EEDh
----------2FE300-----------------------------
INT 2F - Multiplex - ANARKEY.COM - INSTALLATION CHECK
	AX = E300h
Return: AL = 00h not installed
	     FEh if installed but suspended (v3.0+)
	     FFh installed
Notes:	ANARKEY.COM is a commandline recall program by Steven Calwas
	E3h is the default function number, but can be set to any value from
	  C0h to FFh
SeeAlso: AX=E301h,AX=E302h,AX=E303h,AX=E304h,AX=E305h,AX=E306h,AX=E307h
----------2FE301-----------------------------
INT 2F - Multiplex - ANARKEY.COM v2+ - GET ???
	AX = E301h
Return: DX:BX -> ???
SeeAlso: AX=E300h

Format of returned data structure for ANARKEY v2.0:
Offset	Size	Description
 -7   7 BYTEs	signature ('ANARKEY')
 00h	WORD	??? (I see 0001h in v2.0)
 02h	WORD	??? (I see 0001h in v2.0)
 04h	WORD	??? (I see 0 in v2.0)
 06h	WORD	PSP segment of next program loaded

Format of returned data structure for ANARKEY v3+:
Offset	Size	Description
 -1	BYTE	multiplex number
 00h	WORD	??? (I see 0001h in v3.0-4.0)
 02h	WORD	??? (I see 0001h in v3.0-4.0)
 04h	BYTE	??? (I see 0 in v3.0-4.0)
 05h	WORD	PSP segment of next program loaded
----------2FE302-----------------------------
INT 2F - Multiplex - ANARKEY.COM v3+ - ???
	AX = E302h
	BL = ???
Return: ???
SeeAlso: AX=E300h
----------2FE303-----------------------------
INT 2F - Multiplex - ANARKEY.COM v3+ - ANARKMD API
	AX = E303h
	BL = function
	    01h	toggle insert mode
	    02h	display contents of history buffer
	    03h	write history buffer to file
		ES:DX -> file name
	    04h	clear history buffer
	    05h	undefine all aliases
	    06h	show aliases
	    07h	list programs using Unix switchar
	    08h	jump to bottom of history buffer	
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
----------2FE304-----------------------------
INT 2F - Multiplex - ANARKEY.COM v2+ - ???
	AX = E304h
	BL = ???
Return: ???
SeeAlso: AX=E300h
----------2FE305-----------------------------
INT 2F - Multiplex - ANARKEY.COM v3+ - ENABLE/SUSPEND ANARKEY
	AX = E305h
	BL = new state
	    01h suspended
	    00h enabled
SeeAlso: AX=E300h
----------2FE306-----------------------------
INT 2F - Multiplex - ANARKEY.COM v4.0 - GET ???
	AX = E306h
Return: AX = ???
SeeAlso: AX=E300h
----------2FE307-----------------------------
INT 2F - Multiplex - ANARKEY.COM v4.0 - GET ???
	AX = E307h
Return: AX = ???
	BL = ???
SeeAlso: AX=E300h
----------2FE44D-----------------------------
INT 2F - NDOS - API
	AX = E44Dh
Note:	as NDOS is a licensed version of 4DOS v3.03, the API is identical to
	  that for 4DOS, except that AH=E4h instead of D4h and the installation
	  check returns AX=44EEh instead of AX=44DDh
SeeAlso: AX=D44Dh,AX=E44Eh
----------2FE44EBX0000-----------------------
INT 2F - NDOS - AWAITING USER INPUT
	AX = E44Eh
	BX = 0000h NDOS is ready to display prompt
	   = 0001h NDOS has displayed the prompt, about to accept user input
Return: handler must preserve SI, DI, BP, SP, DS, ES, and SS
SeeAlso: AX=E44Dh
----------2FED00-----------------------------
INT 2F - Multiplex - Phar Lap DOS EXTENDERS - INSTALLATION CHECK
	AX = ED00h
	BL = DOS extender
	    01h 286dosx v1.3+ (Software Development Kit)
	    02h 286dosx v1.3+ (Run-Time Kit)
	    03h 386dosx v4.0+ (SDK)
	    04h 386dosx v4.0+ (RTK)
Return: AL = status
	    00h not installed
	    FFh installed
		SI = 5048h ("PH")
		DI = 4152h ("AR")
		CH = major version number
		CL = minor version number
		DX = flags
		    bit 0: running under DPMI
			1: running under Phar Lap VMM
SeeAlso: AH=A1h,AX=F100h,AX=FBA1h
----------2FEE00-----------------------------
INT 2F - Multiplex - GRIDLOC.EXE
	AX = EE00h
Return: AL = FFh if installed
Note:	GRIDLOC is a PC security program by Intelligent Security Systems, Inc.
----------2FF000-----------------------------
INT 2F - 4MAP - INSTALLATION CHECK
	AX = F000h
Return: AX = 00FFh
Notes:	returns AX=00FFh for any value of AL not listed here
	4MAP is a keybinding program for 4DOS (see AX=D44Dh) by Ho-Ping Tseng
----------2FF001-----------------------------
INT 2F - 4MAP - GET KEY MAPPINGS
	AX = F001h
Return: ES:BX -> key mappings
SeeAlso: AX=F000h
----------2FF002-----------------------------
INT 2F - 4MAP - INSERT CHARACTER INTO ???
	AX = F002h
	BL = character to insert
Return: AX = status
	    0000h successful
	    0001h buffer full
SeeAlso: AX=F000h,AX=F003h
----------2FF003-----------------------------
INT 2F - 4MAP - INSERT CHARACTER INTO ???
	AX = F003h
	BL = character to insert
Return: AX = status
	    0000h successful
	    0001h buffer full
SeeAlso: AX=F000h,AX=F002h
----------2FF100-----------------------------
INT 2F - Multiplex - DOS EXTENDER INSTALLATION CHECK
	AX = F100h
Return: AL = FFh if DOS extender present
	    SI = 444Fh ("DO")
	    DI = 5358h ("SX")
Note:	supported or soon to be supported by Phar Lap, Rational, Ergo, and IGC
SeeAlso: AH=A1h,AX=ED00h,AX=FBA1h,INT 15/AX=BF02h
----------2FF700-----------------------------
INT 2F - Multiplex - AUTOPARK.COM - INSTALLATION CHECK
	AX = F700h
Return: AL = 00h not installed
	     FFh installed
Note:	AUTOPARK.COM is a resident hard disk parker by Alan D. Jones
----------2FF701-----------------------------
INT 2F - Multiplex - AUTOPARK.COM - SET PARKING DELAY
	AX = F701h
	BX:CX = 32-bit count of 55ms timer ticks
----------2FFB-------------------------------
INT 2F - Multiplex - RESERVED BY BORLAND INTERNATIONAL
	AH = FBh
----------2FFB42-----------------------------
INT 2F - Multiplex - Borland DPMI LOADER (DPMILOAD.EXE)
	AX = FB42h
	BX = function
	    0001h ???
		Return: AX = 0001h
			ES:BX -> ???
			CX = ???
			DX = ???
	    0002h ???
		Call: ES,SI,DI
		Return: AX = ???
	    0003h get free memory???
		Return: DX:AX = free memory???
	    0004h ???
		Return:	CX = ???
	    0005h ???
		Return: DX = ???
	    0006h ???
		CX = ???
		DX = ???
		Return: DX = ???
	    0007h ???
		CX = ???
		Return: ???
	    0008h ???
		CX = ???
		DX = ???
		Return: DX = ???
	    else calls INT 31/AX=0900h
----------2FFBA1BX0081-----------------------
INT 2F - Multiplex - Borland DOS extender (TKERNEL) - INSTALLATION CHECK
	AX = FBA1h
	BX = 0081h
	ES:DI -> 16-byte buffer
Return: if installed, first four bytes of ES:DI buffer are "IABH"
SeeAlso: AH=A1h,AX=FBA1h/BX=0082h,AX=FBA1h/BX=0084h,INT 15/AX=BF02h 
----------2FFBA1BX0082-----------------------
INT 2F - Multiplex - Borland DOS extender (TKERNEL) - GET ENTRY POINT
	AX = FBA1h
	BX = 0082h
	ES:DI -> response buffer (see below)
Return: ES:DI buffer filled
SeeAlso: AX=FBA1h/BX=0081h,AX=FBA1h/BX=0084h

Format of response buffer:
Offset	Size	Description
 00h  4 BYTEs	signature "IABH"
 04h	DWORD	pointer to FAR extender entry point

Call entry point with:
	AX = function number
	    0000h to 0026h ???
	    FFFFh ???
		BX:SI -> ???
		CX:DI -> ???
	    other Return: AX = 0001h
----------2FFBA1BX0084-----------------------
INT 2F - Multiplex - Borland DOS extender (TKERNEL) - UNINSTALL
	AX = FBA1h
	BX = 0084h
	ES:DI -> response buffer (see below)
Return: ES:DI buffer filled
SeeAlso: AX=FBA1h/BX=0081h,AX=FBA1h/BX=0084h

Format of response buffer:
Offset	Size	Description
 00h  4 BYTEs	signature "IABH"
 04h	WORD	success indicator
		0001h failed (INT 2F hooked by another program
		unchanged if successful
----------2FFE00DI4E55-----------------------
INT 2F - NORTON UTILITIES 5.0+ TSRs - INSTALLATION CHECK/STATUS REPORT
	AX = FE00h
	DI = 4E55h ("NU")
	SI = TSR identifier
	    4346h ("CF") NCACHE-F (v5) / NCACHE (v6.0+)
	    4353h ("CS") NCACHE-S (v5 only)
	    4443h ("DC") DISKREET
	    444Dh ("DM") DISKMON
	    4653h ("FS") FILESAVE (v5) / EP (v6.0+)
Return: SI = TSR reply
	    lowercase version of SI on entry (i.e. SI OR 2020h)
	AH = status
	    00h installed but disabled internally
	    01h installed and enabled
	AL = status
	    00h	NCACHE-x or DISKREET installed
	    01h FILESAVE / EP / DISKMON v6 installed
	    45h	DISKMON v5 installed
	BX = length of *.INI file (DISKMON and FILESAVE/EP only) (see below)
	CX = segment of resident portion
	    FFFFh if completely loaded high (NCACHE)
---FILESAVE/EP---
	DL = ??? (apparently always 00h)
---DISKMON---
	DX = ??? (apparently always 1AE6h [v5] / 1B86h [v6])
Note:	the value returned in CX is incorrect for NCACHE 6.00
SeeAlso: AX=FE01h,AX=FE02h,AX=FE03h,AX=FE04h,AX=FE05h

Format of DISKMON.INI file:
Offset	Size	Description
-6Ch 108 BYTEs	(in memory copy only)
		list of filenames which are always protected:
		  IBMBIO.COM/IBMDOS.COM, IO.SYS/MSDOS.SYS, TBIOS.SYS/TDOS.SYS,
		  MIO.SYS/IO.BIN, COMMAND.COM
 00h	BYTE	??? always 01h
 01h	BYTE	disk light (00h off, 01h on)
 02h	BYTE	disk protection (00h off, 01h on)
 03h	BYTE	protected areas
		01h system area
		02h files
		03h system area and files
		04h entire disk
 04h	BYTE	floppy access (00h not allowed, 01h allowed)
 05h 27 BYTEs	filename extension list (9 entries)
		(lowercase, blank padded or = 000000h)
 20h 240 BYTEs	filename list (20 entries)
		(lowercase, name and extension blank padded, with '.')
Note:	CX:0508h -> copy in installed TSR (v5)
	CX:052Fh -> copy in installed TSR (v6)

Format of FILESAVE.INI / EP.INI file:
Offset	Size	Description
 00h 26 BITs	drive list (bit set: file protection on, cleared: off):
 00h	BYTE	drives	A: - H:
 01h	BYTE	drives	I: - P:
 02h	BYTE	drives	Q: - X:
 03h	BYTE	drives	Y: - Z:
 04h	BYTE	which files to protect
		00h all files
		01h all files with extension in list
		02h all files except those with extension in list
 05h 27 BYTEs	filename extension list (9 entries, uppercase, ASCIZ)
 20h	BYTE	include files with archive bit clear (00h no, 01h yes)
 21h	WORD	number of days after which files are purged (0 = never)
 23h	WORD	max kilobytes of erased file space to hold (0 = all)
Note:	CX:03D2h -> copy in installed TSR (v5.0)
	CX:03F5h -> copy in installed TSR (v6.0)
----------2FFE01DI4E55-----------------------
INT 2F - NORTON UTILITIES 5.0+ TSRs - ENABLE
	AX = FE01h
	DI = 4E55h ("NU")
	SI = TSR identifier (see AX=FE00h)
Return: SI = TSR reply (lowercase version of entry SI, i.e. SI OR 2020h)
	AX = status
	    0002h successful (DISKMON, FILESAVE, EP)
	    FE00h successful (NCACHE-x, DISKREET)
Notes:	if the enable/disable calls are used on DISKMON or NCACHE-x, the status
	  report generated by the programs still indicates the previous state,
	  and DISKMON.INI is not updated
	apparently has no effect on DISKREET
SeeAlso: AX=FE00h,AX=FE02h
----------2FFE02DI4E55-----------------------
INT 2F - NORTON UTILITIES 5.0+ TSRs - DISABLE
	AX = FE02h
	DI = 4E55h ("NU")
	SI = TSR identifier (see AX=FE00h)
Return: SI = TSR reply (lowercase version of entry SI, i.e. SI OR 2020h)
	AX = status
	    0004h successful (DISKMON, FILESAVE)
	    FE00h successful (NCACHE-x, DISKREET)
Note:	(see AX=FE01h)
SeeAlso: AX=FE00h,AX=FE01h
----------2FFE03DI4E55-----------------------
INT 2F - NORTON UTILITIES 5.0+ TSRs - internal - ???
	AX = FE03h
	DI = 4E55h ("NU")
	SI = TSR identifier (see AX=FE00h)
Return: SI = TSR reply (lowercase version of entry SI, i.e. SI OR 2020h)
	AX = status
	    0006h successful???
Notes:	only supported by DISKMON, FILESAVE, and NCACHE-x
	reportedly dangerous
SeeAlso: AX=FE00h
----------2FFE04DI4E55-----------------------
INT 2F - NORTON UTILITIES 5.0+ DISKMON, FILESAVE / EP - internal - ???
	AX = FE04h
	DI = 4E55h ("NU")
	SI = TSR identifier (see AX=FE00h)
Return: SI = TSR reply (lowercase version of entry SI, i.e. SI or 2020h)
	AX = status
	    0008h successful???
SeeAlso: AX=FE00h
----------2FFE05DI4E55-----------------------
INT 2F - NORTON UTILITIES 5.0+ DISKMON, FILESAVE / EP - internal - ???
	AX = FE05h
	DI = 4E55h ("NU")
	SI = TSR identifier (see AX=FE00h)
Return: SI = TSR reply (lowercase version of entry SI, i.e. SI or 2020h)
	AX = status
	    000Ah successful???
Note:	reportedly dangerous
SeeAlso: AX=FE00h
----------2FFF00-----------------------------
INT 2F - Multiplex - Topware Network Operating System - INSTALLATION CHECK
	AX = FF00h
Return: AL = 00h not installed, OK to install
	   = 01h not installed, not OK to install
	   = FFh installed
----------2FFF01-----------------------------
INT 2F - Multiplex - Topware Network Operating System - GET VERSION
	AX = FF01h
Return: AX = version
----------30---------------------------------
INT 30 - (NOT A VECTOR!) - DOS 1+ - FAR JMP instruction for CP/M-style calls
   the CALL 5 entry point does a FAR jump to here
Note:	under DOS 2+, the instruction at PSP:0005 points two bytes too low in
	  memory
SeeAlso: INT 21/AH=26h
----------31---------------------------------
INT 31 - overwritten by CP/M jump instruction in INT 30
----------310000-----------------------------
INT 31 - DOS Prot-Mode Interface 0.9+ - protected mode - ALLOCATE LDT DESCRPTRS
	AX = 0000h
	CX = number of descriptors to allocate
Return: CF clear if successful
	    AX = base selector
	CF set on error
	    AX = error code (DPMI 1.0+)
		0000h-7FFFh DOS error passed through by DPMI
		8001h unsupported function
		8002h object in wrong state for function
		8003h system integrity would be endangered
		8004h deadlock detected
		8005h pending serialization request cancelled
		8010h out of DPMI internal resources
		8011h descriptor unavailable
		8012h linear memory unavailable
		8013h physical memory unavailable
		8014h backing store unavailable
		8015h callback unavailable
		8016h handle unavailable
		8017h maximum lock count exceeded
		8018h shared memory already serialized exclusively by another
		8019h shared memory already serialized shared by another client
		8021h invalid value for numeric or flag parameter
		8022h invalid segment selector
		8023h invalid handle
		8024h invalid callback
		8025h invalid linear address
		8026h request not supported by hardware
Notes:	the base and limit of the returned descriptors will be 0, and the type
	  will be "data"
	add the value returned by INT 31/AX=0003h to move to subsequent
	  descriptors if multiple descriptors were allocated
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0001h,AX=000Dh
----------310001-----------------------------
INT 31 - DPMI 0.9+ - protected mode - FREE LDT DESCRIPTOR
	AX = 0001h
	BX = selector to free
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8022h) (see AX=0000h)
Notes:	only one descriptor is freed per call
	the program's initial CS, DS, and SS descriptors may be freed
	(DPMI 1.0+) any segment registers containing the freed selector are
	  set to 0000h
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0000h,AX=000Ah,AX=000Dh
----------310002-----------------------------
INT 31 - DPMI 0.9+ - protected mode - SEGMENT TO DESCRIPTOR
	AX = 0002h
	BX = real mode segment
Return: CF clear if successful
	    AX = selector corresponding to real mode segment (64K limit)
	CF set on error
	    AX = error code (DPMI 1.0+) (8011h) (see AX=0000h)
Notes:	multiple calls for the same real mode segment return the same selector
	the returned descriptor can never be modified or freed
	not supported by MS Windows 3.0 in Standard mode
----------310003-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET NEXT SELECTOR INCREMENT VALUE
	AX = 0003h
Return: CF clear
	    AX = value to add to get next sequential selector
Notes:	the increment will be a power of two
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0000h
----------310004-----------------------------
INT 31 - DPMI 0.9+ - protected mode - LOCK SELECTOR
	AX = 0004h
	BX = selector to lock (prevent paging)
Return: ???
Note:	although marked as reserved in versions 0.9 and 1.0 of the DPMI
	  specification, this function is called by MS Windows TASKMAN,
	  PROGMAN, and KERNEL
SeeAlso: AX=0005h,AX=0600h
----------310005-----------------------------
INT 31 - DPMI 0.9+ - protected mode - UNLOCK SELECTOR
	AX = 0005h
	BX = selector to unlock (permit paging)
Return: ???
Note:	although marked as reserved in versions 0.9 and 1.0 of the DPMI
	  specification, this function is called by MS Windows TASKMAN,
	  PROGMAN, and KERNEL
SeeAlso: AX=0004h,AX=0601h
----------310006-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET SEGMENT BASE ADDRESS
	AX = 0006h
	BX = selector
Return: CF clear if successful
	    CX:DX = linear base address of segment
	CF set on error
	    AX = error code (DPMI 1.0+) (8022h) (see AX=0000h)
Note:	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0007h
----------310007-----------------------------
INT 31 - DPMI 0.9+ - protected mode - SET SEGMENT BASE ADDRESS
	AX = 0007h
	BX = selector
	CX:DX = linear base address
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8022h,8025h) (see AX=0000h)
Notes:	only modify descriptors allocated with INT 31/AX=0000h
	only the low 24 bits of the address will be used by 16-bit DPMI
	  implementations even on a 386 or higher
	DPMI 1.0+ automatically reloads any segment registers containing the
	  selector being modified
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0006h,AX=0008h,AX=0009h,AX=000Ch,INT 21/AH=E9h"OS/286"
----------310008-----------------------------
INT 31 - DPMI 0.9+ - protected mode - SET SEGMENT LIMIT
	AX = 0008h
	BX = selector
	CX:DX = segment limit
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8021h,8022h,8025h) (see AX=0000h)
Notes:	CX must be zero for 16-bit DPMI implementations
	limits greater than 1MB must be page aligned (low 12 bits set)
	only modify descriptors allocated with INT 31/AX=0000h
	DPMI 1.0+ automatically reloads any segment registers containing the
	  selector being modified
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0007h,AX=0009h,AX=000Ch,INT 21/AH=E9h"OS/286"
----------310009-----------------------------
INT 31 - DPMI 0.9+ - protected mode - SET DESCRIPTOR ACCESS RIGHTS
	AX = 0009h
	BX = selector
	CL = access rights/type byte
	CH = 80386 extended rights/type byte (32-bit DPMI implementations only)
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8021h,8022h,8025h) (see AX=0000h)
Notes:	if the Present bit is clear, CL bits 0-3 may have any value
	DPMI 1.0+ automatically reloads any segment registers containing the
	  selector being modified
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0007h,AX=0008h,AX=000Ch,INT 21/AX=2514h
----------31000A-----------------------------
INT 31 - DPMI 0.9+ - protected mode - CREATE ALIAS DESCRIPTOR
	AX = 000Ah
	BX = selector
Return: CF clear if successful
	    AX = new data selector
	CF set on error
	    AX = error code (DPMI 1.0+) (8011h,8022h) (see AX=0000h)
Notes:	fails if selector in BX is not a code segment or is invalid
	use INT 31/AX=0001h to free new selector
	future changes to the original selector will not be reflected in the
	  returned alias selector
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0001h
----------31000B-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET DESCRIPTOR
	AX = 000Bh
	BX = LDT selector
	ES:(E)DI -> 8-byte buffer for copy of descriptor
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (DPMI 1.0+) (8022h) (see AX=0000h)
Notes:	16-bit programs use ES:DI as pointer, 32-bit must use ES:EDI
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=000Ch
----------31000C-----------------------------
INT 31 - DPMI 0.9+ - protected mode - SET DESCRIPTOR
	AX = 000Ch
	BX = LDT selector
	ES:(E)DI -> 8-byte buffer containing descriptor
Return:	CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8021h,8022h,8025h) (see AX=0000h)
Notes:	16-bit programs use ES:DI as pointer, 32-bit must use ES:EDI
	only modify descriptors allocated with INT 31/AX=0000h
	DPMI 1.0+ automatically reloads any segment registers containing the
	  selector being modified
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=000Bh
----------31000D-----------------------------
INT 31 - DPMI 0.9+ - protected mode - ALLOCATE SPECIFIC LDT DESCRIPTOR
	AX = 000Dh
	BX = LDT selector
Return: CF clear if successful
	    descriptor allocated
	CF set on error
	    AX = error code (DPMI 1.0+) (8011h,8022h) (see AX=0000h)
Notes:	free descriptor with INT 31/AX=0001h
	the first 16 descriptors (04h-7Ch) are reserved for this function, but
	  some may already be in use by other applications under DPMI 0.9;
	  DPMI 1.0 guarantees 16 descriptors per client
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0000h,AX=0001h
----------31000E-----------------------------
INT 31 - DPMI 1.0+ - protected mode - GET MULTIPLE DESCRIPTORS
	AX = 000Eh
	CX = number of descriptors to copy
	ES:(E)DI -> descriptor buffer (see below)
Return: CF clear if successful
	    descriptors copied
	CF set on error
	    AX = error code (8022h) (see AX=0000h)
	    CX = number of descriptors successfully copied
Notes:	16-bit programs use ES:DI as pointer, 32-bit must use ES:EDI
	if the function fails, the first CX descriptors are valid; the
	  remainder are not modified
SeeAlso: AX=000Bh,AX=000Fh

Format of descriptor buffer entry (one per descriptor to get):
Offset	Size	Description
 00h	WORD	selector (set by client)
 02h	QWORD	descriptor (set by host)
----------31000F-----------------------------
INT 31 - DPMI 1.0+ - protected mode - SET MULTIPLE DESCRIPTORS
	AX = 000Fh
	CX = number of descriptors to copy
	ES:(E)DI -> descriptor buffer (see below)
Return: CF clear if successful
	    descriptors copied
	CF set on error
	    AX = error code (8021h,8022h,8025h) (see AX=0000h)
	    CX = number of descriptors successfully copied
Notes:	16-bit programs use ES:DI as pointer, 32-bit must use ES:EDI
	if the function fails, the first CX descriptors are valid; the
	  remainder are not modified
	DPMI 1.0+ automatically reloads any segment registers containing a
	  selector being modified
SeeAlso: AX=000Ch,AX=000Eh

Format of descriptor buffer entry (one per descriptor to set):
Offset	Size	Description
 00h	WORD	selector
 02h	QWORD	descriptor
----------310100-----------------------------
INT 31 - DPMI 0.9+ - protected mode - ALLOCATE DOS MEMORY BLOCK
	AX = 0100h
	BX = number of paragraphs to allocate
Return: CF clear if successful
	    AX = real mode segment of allocated block
	    DX = first selector for allocated block
	CF set on error
	    AX = DOS error code (07h,08h) (see INT 21/AH=59h)
		 (DPMI 1.0+) DPMI error code (8011h) (see AX=0000h)
	    BX = size (in paragraphs) of largest available block
Notes:	multiple contiguous selectors are allocated for blocks of more than 64K
	  if the caller is a 16-bit program
	never modify or deallocate returned descriptors
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0101h,AX=0501h
----------310101-----------------------------
INT 31 - DPMI 0.9+ - protected mode - FREE DOS MEMORY BLOCK
	AX = 0101h
	DX = selector of block
Return: CF set if successful
	CF set on error
	    AX = DOS error code (07h,09h) (see INT 21/AH=59h)
Notes:	all descriptors allocated for the block are automatically freed
	DPMI 1.0+ automatically zeros any segment registers containing a
	  selector freed by this function
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0100h,AX=0102h,AX=0502h
----------310102-----------------------------
INT 31 - DPMI 0.9+ - protected mode - RESIZE DOS MEMORY BLOCK
	AX = 0102h
	BX = new block size in paragraphs
	DX = selector of block
Return: CF clear if successful
	CF set on error
	    AX = DOS error code (07h,08h,09h) (see INT 21/AH=59h)
		 (DPMI 1.0+) DPMI error code (8011h,8022h) (see AX=0000h)
	    BX = maximum block size (in paragraphs) possible
Notes:	increasing the size of a block past a 64K boundary will fail if the
	  next descriptor in the LDT is already in use
	shrinking a block past a 64K boundary will cause some selectors to be
	  freed; DPMI 1.0+ automatically zeros any segment registers containing
	  a selector freed by this function
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0100h
----------310200-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET REAL MODE INTERRUPT VECTOR
	AX = 0200h
	BL = interrupt number
Return: CF clear
	CX:DX = segment:offset of real mode interrupt handler
Note:	the DPMI implementation is required to support all 256 vectors
SeeAlso: AX=0201h,AX=0204h,INT 21/AX=2503h
----------310201-----------------------------
INT 31 - DPMI 0.9+ - protected mode - SET REAL MODE INTERRUPT VECTOR
	AX = 0201h
	BL = interrupt number
	CX:DX = segment:offset of real mode handler
Return: CF clear
Note:	all memory that may be touched by a hardware interrupt handler must be
	  locked down with INT 31/AX=0600h	
SeeAlso: AX=0200h,AX=0205h,AX=0600h,INT 21/AX=2505h
----------310202-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET PROCESSOR EXCEPTION HANDLER VECTOR
	AX = 0202h
	BL = exception number (00h-1Fh)
Return:	CF clear if successful
	    CX:(E)DX = selector:offset of handler
	CF set on error
	    AX = error code (DPMI 1.0+) (8021h) (see AX=0000h)
Notes:	16-bit programs receive the pointer in CX:DX, 32-bit programs in CX:EDX
	DPMI 1.0+ supports this function only for backward compatibility; use
	   AX=0210h or AX=0211h instead
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0203h,AX=0210h,AX=0211h
----------310203-----------------------------
INT 31 - DPMI 0.9+ - protected mode - SET PROCESSOR EXCEPTION HANDLER VECTOR
	AX = 0203h
	BL = exception number (00h-1Fh)
	CX:(E)DX = selector:offset of handler
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8021h,8022h) (see AX=0000h)
Notes:	32-bit programs must supply an offset in EDX and use a 32-bit interrupt
	  stack frame on chaining to the next exception handler
	the handler should return using a FAR return
	all fault stack frames contain an error code, but it is only valid for
	  exceptions 08h and 0Ah-0Eh
	handlers will only be called if the exception occurs in protected mode,
	  and the DPMI host does not transparently handle the exception
	the handler may change certain values on the stack frame (see below)
	DPMI 1.0+ supports this function only for backward compatibility; use
	   AX=0212h or AX=0213h instead
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0202h,AX=0212h,AX=0213h

Format of stack frame for 16-bit programs: (offset from SS:SP)
Offset	Size	Description
 00h	DWORD	return CS:IP (do not change)
 04h	WORD	error code
 06h	DWORD	CS:IP of exception
 0Ah	WORD	flags
 0Ch	DWORD	SS:SP

Format of stack frame for 32-bit programs: (offset from SS:ESP)
Offset	Size	Description
 00h	DWORD	return EIP (do not change)
 04h	WORD	return CS selector (do not change)
 06h	WORD	reserved (do not change)
 08h	DWORD	error code
 0Ch	DWORD	EIP of exception
 10h	WORD	CS selector of exception
 12h	WORD	reserved (do not change)
 14h	DWORD	EFLAGS
 18h	DWORD	ESP
 1Ch	WORD	SS
 1Eh	WORD	reserved (do not change)
----------310204-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET PROTECTED MODE INTERRUPT VECTOR
	AX = 0204h
	BL = interrupt number
Return:	CF clear
	CX:(E)DX = selector:offset of handler
Notes:	16-bit programs use CX:DX, 32-bit programs use CX:EDX
	DPMI implementations are required to support all 256 vectors
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0200h,AX=0205h,INT 21/AX=2502h
----------310205-----------------------------
INT 31 - DPMI 0.9+ - protected mode - SET PROTECTED MODE INTERRUPT VECTOR
	AX = 0205h
	BL = interrupt number
	CX:(E)DX = selector:offset of handler
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8022h) (see AX=0000h)
Notes:	16-bit programs use CX:DX, 32-bit programs use CX:EDX
	32-bit programs must use a 32-bit interrupt stack frame when chaining
	  to the next handler
	DPMI implementations are required to support all 256 vectors
	hardware interrupts are reflected to the virtual machine's primary
	  client, software interrupts to the current client
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0201h,AX=0204h,INT 21/AX=2504h
----------310210-----------------------------
INT 31 - DPMI 1.0+ - prot mode - GET PROTMODE EXT PROCESSOR EXCEPTION HANDLER
	AX = 0210h
	BL = exception number (00h-1Fh)
Return: CF clear if successful
	    CX:(EDX) = selector:offset of exception handler
	CF set on error
	    AX = error code (8021h) (see AX=0000h)
Note:	DPMI host reflects exception to current client's handler
SeeAlso: AX=0202h,AX=0211h,AX=0212h
----------310211-----------------------------
INT 31 - DPMI 1.0+ - prot mode - GET REALMODE EXT PROCESSOR EXCEPTION HANDLER
	AX = 0211h
	BL = exception number (00h-1Fh)
Return: CF clear if successful
	    CX:(EDX) = selector:offset of exception handler
	CF set on error
	    AX = error code (8021h) (see AX=0000h)
Notes:	returns address of protected-mode handler for real-mode exception
	DPMI host performs a switch to protected mode, reflects the exception
	  to the virtual machine's primary client, and returns to real mode
	  on the handler's completion
SeeAlso: AX=0202h,AX=0210h,AX=0213h
----------310212-----------------------------
INT 31 - DPMI 1.0+ - prot mode - SET PROTMODE EXT PROCESSOR EXCEPTION HANDLER
	AX = 0212h
	BL = exception or fault number (00h-1Fh)
	CX:(E)DX = exception handler selector:offset
Return: CF clear if successful
	CF set on error
	    AX = error code (8021h,8022h) (see AX=0000h)
Note:	DPMI host sends exception to current client's handler
SeeAlso: AX=0203h,AX=0210h,AX=0213h
----------310213-----------------------------
INT 31 - DPMI 1.0+ - prot mode - SET REALMODE EXT PROCESSOR EXCEPTION HANDLER
	AX = 0213h
	BL = exception or fault number (00h-1Fh)
	CX:(E)DX = exception handler selector:offset
Return: CF clear if successful
	CF set on error
	    AX = error code (8021h,8022h) (see AX=0000h)
Notes:	specifies address of protected-mode handler for real-mode exception
	DPMI host performs a switch to protected mode, reflects the exception
	  to the virtual machine's primary client, and returns to real mode
	  on the handler's completion
SeeAlso: AX=0203h,AX=0211h,AX=0212h
----------310300-----------------------------
INT 31 - DPMI 0.9+ - protected mode - SIMULATE REAL MODE INTERRUPT
	AX = 0300h
	BL = interrupt number
	BH = flags
	    bit 0: reset the interrupt controller and A20 line (DPMI 0.9)
		   reserved, must be 0 (DPMI 1.0+)
	    others must be 0
	CX = number of words to copy from protected mode to real mode stack
	ES:(E)DI = selector:offset of real mode call structure (see below)
Return:	CF clear if successful
	    real mode call structure modified (all fields except SS:SP, CS:IP
	      filled with return values from real mode interrupt)
	CF set on error
	    AX = error code (DPMI 1.0+) (8012h,8013h,8014h,8021h)(see AX=0000h)
	protected mode stack unchanged
Notes:	16-bit programs use ES:DI as pointer, 32-bit programs use ES:EDI
	CS:IP in the real mode call structure is ignored for this call,
	  instead, the indicated interrupt vector is used for the address
	the flags in the call structure are pushed on the real mode stack to
	  form an interrupt stack frame, and the trace and interrupt flags are
	  clear on entry to the handler
	DPMI will provide a small (30 words) real mode stack if SS:SP is zero
	the real mode handler must return with the stack in the same state as
	  it was on being called
SeeAlso: AX=0302h,INT 21/AX=2511h,INT 21/AH=E3h"OS/286"

Format of real mode call structure:
Offset	Size	Description
 00h	DWORD	EDI
 04h	DWORD	ESI
 08h	DWORD	EBP
 0Ch	DWORD	reserved (00h)
 10h	DWORD	EBX
 14h	DWORD	EDX
 18h	DWORD	ECX
 1Ch	DWORD	EAX
 20h	WORD	flags
 22h	WORD	ES
 24h	WORD	DS
 26h	WORD	FS
 28h	WORD	GS
 2Ah	WORD	IP
 2Ch	WORD	CS
 2Eh	WORD	SP
 30h	WORD	SS
----------310301-----------------------------
INT 31 - DPMI 0.9+ - prot mode - CALL REAL MODE PROCEDURE WITH FAR RETURN FRAME
	AX = 0301h
	BH = flags
	    bit 0: reset the interrupt controller and A20 line (DPMI 0.9)
		   reserved, must be 0 (DPMI 1.0+)
	    others must be 0
	CX = number of words to copy from protected mode to real mode stack
	ES:DI / ES:EDI = selector:offset of real mode call structure
			(see INT 31/AX=0300h)
Return: CF clear if successful
	    real mode call structure modified (all fields except SS:SP, CS:IP
	      filled with return values from real mode interrupt)
	CF set on error
	    AX = error code (DPMI 1.0+) (8012h,8013h,8014h,8021h)(see AX=0000h)
	protected mode stack unchanged
Notes:	16-bit programs use ES:DI as pointer, 32-bit programs use ES:EDI
	the real mode procedure must exit with a FAR return
	DPMI will provide a small (30 words) real mode stack if SS:SP is zero
	the real mode handler must return with the stack in the same state as
	  it was on being called
SeeAlso: AX=0300h,AX=0302h,INT 21/AX=250Eh,INT 21/AH=E1h"OS/286"
----------310302-----------------------------
INT 31 - DPMI 0.9+ - protected mode - CALL REAL MODE PROCEDURE WITH IRET FRAME
	AX = 0302h
	BH = flags
	    bit 0: reset the interrupt controller and A20 line (DPMI 0.9)
		   reserved, must be 0 (DPMI 1.0+)
	    others must be 0
	CX = number of words to copy from protected mode to real mode stack
	ES:DI / ES:EDI = selector:offset of real mode call structure
			(see INT 31/AX=0300h)
Return:	CF clear if successful
	    real mode call structure modified (all fields except SS:SP, CS:IP
	      filled with return values from real mode interrupt)
	CF set on error
	    AX = error code (DPMI 1.0+) (8012h,8013h,8014h,8021h)(see AX=0000h)
	protected mode stack unchanged
Notes:	16-bit programs use ES:DI as pointer, 32-bit programs use ES:EDI
	the flags in the call structure are pushed on the real mode stack to
	  form an interrupt stack frame, and the trace and interrupt flags are
	  clear on entry to the handler
	the real mode procedure must exit with an IRET
	DPMI will provide a small (30 words) real mode stack if SS:SP is zero
	the real mode handler must return with the stack in the same state as
	  it was on being called
SeeAlso: AX=0300h
----------310303-----------------------------
INT 31 - DPMI 0.9+ - protected mode - ALLOCATE REAL MODE CALLBACK ADDRESS
	AX = 0303h
	DS:SI / DS:ESI = selector:offset of procedure to call
	ES:DI / ES:EDI = selector:offset of real mode call structure
			(see AX=0300h)
Return: CF clear if successful
	    CX:DX = segment:offset of real mode call address
	CF set on error
	    AX = error code (DPMI 1.0+) (8015h) (see AX=0000h)
Notes:	the real mode call structure is static, causing reentrancy problems;
	  its contents are only valid at the time of a callback
	the called procedure must modify the real mode CS:IP before returning
	values are returned to real mode by modifying the real mode call struc
	DPMI hosts must provide at least 16 callbacks per client
SeeAlso: AX=0304h,AX=0C00h

Values callback procedure is called with:
	DS:SI / DS:ESI = selector:offset of real mode SS:SP
	ES:DI / ES:EDI = selector:offset of real mode call structure
	SS:SP / SS:ESP = locked protected mode API stack
	interrupts disabled
Return: (with IRET)
	ES:DI / ES:EDI = selector:offset of real mode call structure to restore
----------310304-----------------------------
INT 31 - DPMI 0.9+ - protected mode - FREE REAL MODE CALLBACK ADDRESS
	AX = 0304h
	CX:DX = real mode callback address
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8024h) (see AX=0000h)
SeeAlso: AX=0303h
----------310305-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET STATE SAVE/RESTORE ADDRESSES
	AX = 0305h
Return: CF clear
	AX = size in bytes of state buffer
	BX:CX = real mode address of procedure to save/restore state
	SI:DI / SI:EDI = protected mode procedure to save/restore state
Notes:	the buffer size will be zero if it is not necessary to preserve state
	16-bit programs should call SI:DI, 32-bit programs should call SI:EDI
	this function is only needed if using the raw mode switch service
SeeAlso: AX=0306h

Values to call state-save procedures with:
	AL = direction
	    00h save state
	    01h restore state
	ES:DI / ES:EDI -> state buffer
Return: all registers preserved
----------310306-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET RAW MODE SWITCH ADDRESSES
	AX = 0306h
Return:	CF clear
	BX:CX -> procedure to switch from real to protected mode
	SI:DI / SI:EDI -> procedure to switch from protected to real mode
Notes:	16-bit programs should jump to SI:DI, 32-bit programs should use SI:EDI
	the caller must save and restore the state of the task with AX=0305h
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0305h

Values to JUMP at mode-switch procedures with:
	AX = new DS
	CX = new ES
	DX = new SS
	BX / EBX = new SP / ESP
	SI = new CS
	DI / EDI = new IP / EIP
Notes:	BP/EBP is preserved across the call, but AX/EAX, BX/EBX, CX/ECX,
	  DX/EDX, SI/ESI, and DI/EDI will be undefined; FS and GS will be 0000h
	interrupts will stay disabled during the entire mode switch if they
	  are disabled on entry to the mode-switch procedure
----------310400-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET DPMI VERSION
	AX = 0400h
Return: CF clear
	AH = major version of DPMI spec supported
	AL = two-digit minor version of DPMI spec supported
	BX = flags
	    bit 0: running under an 80386 (32-bit) implementation
	    bit 1: processor returns to real mode for reflected interrupts
		   instead of V86 mode
	    bit 2: virtual memory supported
	    bit 3: reserved (undefined)
	    others reserved (zero)
	CL = processor type (02h=80286, 03h=80386, 04h=80486)
	DH = curr value of virtual master interrupt controller base interrupt
	DL = curr value of virtual slave interrupt controller base interrupt
SeeAlso: AX=0401h,INT 21/AX=250Ch
----------310401-----------------------------
INT 31 - DPMI 1.0+ - protected mode - GET DPMI CAPABILITIES
	AX = 0401h
	ES:(E)DI -> 128-byte buffer (see below)
Return: CF clear if successful
	    AX = capabilities
		bit 0: paged accessed/dirty supported (see AX=0506h,AX=0507h)
		    1: exceptions restartability supported
		    2: device mapping supported (see AX=0508h)
		    3: conventional memory mapping supported (see AX=0509h)
		    4: demand zero-fill supported
		    5: write-protect client capability supported
		    6: write-protect host capability supported
		    7-15: reserved
	    CX = reserved (00h)
	    DX = reserved (00h)
	    buffer filled
	CF set on error (DPMI 0.9 only)
SeeAlso: AX=0400h

Format of buffer:
Offset	Size	Description
 00h	BYTE	host major version number
 01h	BYTE	host minor version number
 02h 126 BYTEs	ASCIZ host vendor name
----------310500-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET FREE MEMORY INFORMATION
	AX = 0500h
	ES:DI / ES:EDI -> buffer for memory information (see below)
Return: CF clear
Notes:	16-bit programs use ES:DI, 32-bit programs use ES:EDI
	this function must be considered advisory because other applications
	  may affect the results at any time after the call
	fields not supported by the DPMI implementation are filled with
	  FFFFFFFFh
	DPMI 1.0+ supports this function solely for backward compatibility; use
	  AX=050Bh instead
SeeAlso: AX=0501h,AX=0604h

Format of memory information:
Offset	Size	Description
 00h	DWORD	largest available block in bytes
 04h	DWORD	maximum unlocked page allocation
 08h	DWORD	maximum locked page allocation
 0Ch	DWORD	total linear address space in pages
 10h	DWORD	total unlocked pages
 14h	DWORD	free pages
 18h	DWORD	total physical pages
 1Ch	DWORD	free linear address space in pages
 20h	DWORD	size of paging file/partition in pages
 24h 12 BYTEs	reserved
----------310501-----------------------------
INT 31 - DPMI 0.9+ - protected mode - ALLOCATE MEMORY BLOCK
	AX = 0501h
	BX:CX = size in bytes
Return: CF clear if successful
	    BX:CX = linear address of block
	    SI:DI = memory block handle for resizing and freeing block
	CF set on error
	    AX = error code (DPMI 1.0+) (8012h-8014h,8016h,8021h)(see AX=0000h)
Notes:	no selectors are allocated
	the memory block is allocated unlocked (can be locked with AX=0600h)
	allocations are often page granular (see AX=0604h)
SeeAlso: AX=0000h,AX=0100h,AX=0500h,AX=0502h,AX=0503h,AX=0504h,AX=0D00h
----------310502-----------------------------
INT 31 - DPMI 0.9+ - protected mode - FREE MEMORY BLOCK
	AX = 0502h
	SI:DI = handle of memory block
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8023h) (see AX=0000h)
Note:	any selectors allocated for the memory block must also be freed,
	  preferably before freeing the memory block
SeeAlso: AX=0001h,AX=0101h,AX=0501h,AX=0D01h
----------310503-----------------------------
INT 31 - DPMI 0.9+ - protected mode - RESIZE MEMORY BLOCK
	AX = 0503h
	BX:CX = new size in bytes (nonzero)
	SI:DI = handle of memory block
Return: CF clear if successful
	    BX:CX = new linear address
	    SI:DI = new handle of memory block
	CF set on error
	    AX = error code (DPMI 1.0+) (8012h-8014h,8016h,8021h,8023h)
		(see AX=0000h)
Notes:	any selectors pointing at the block must be updated
	the previous memory block handle becomes invalid
	an error is returned if the new size is 0
SeeAlso: AX=0102h,AX=0501h,AX=0505h
----------310504-----------------------------
INT 31 - DPMI 1.0+ - protected mode - ALLOCATE LINEAR MEMORY BLOCK
	AX = 0504h
	EBX = page-aligned linear address of memory block (00000000h if any
		address is acceptable)
	ECX = size in bytes (nonzero)
	EDX = flags
	    bit 0: set to create committed pages instead of uncommitted pages
	    bits 1-31: reserved (0)
Return: CF clear if successful
	    EBX = linear address of memory block
	    ESI = memory block handle
	CF set on error
	    AX = error code (8001h,8012h-8014h,8016h,8021h,8025h)(see AX=0000h)
Note:	only supported by 32-bit DPMI hosts, but may be used by 16-bit clients
SeeAlso: AX=0501h,AX=0505h
----------310505-----------------------------
INT 31 - DPMI 1.0+ - protected mode - RESIZE LINEAR MEMORY BLOCK
	AX = 0505h
	ESI = memory block handle
	ECX = new size in bytes (nonzero)
	EDX = flags
	    bit 0: create committed pages rather than uncommitted pages
	    bit 1: segment descriptor update required
		ES:EBX -> buffer containing array of WORDs with selectors
		EDI = number of selectors in array
	    bits 2-31: reserved (0)
Return: CF clear if successful
	    EBX = new linear base address
	    ESI = new memory block handle
	CF set on error
	    AX = error code (8001h,8012h-8014h,8016h,8021h,8023h)(see AX=0000h)
Notes:	only supported by 32-bit DPMI hosts, but may be used by 16-bit clients
	the old memory block handle becomes invalid
	if EDX bit 1 set and the block's base address is changed, DPMI updates
	  all descriptors for selectors in the update buffer which fall within
	  the memory block
SeeAlso: AX=0503h,AX=0504h
----------310506-----------------------------
INT 31 - DPMI 1.0+ - protected mode - GET PAGE ATTRIBUTES
	AX = 0506h
	ESI = memory block handle
	EBX = offset in memory block of first page
	ECX = number of pages
	ES:EDX -> array of WORDs to hold page attributes (see below)
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (8001h,8023h,8025h) (see AX=0000h)
Notes:	only supported by 32-bit DPMI hosts, but may be used by 16-bit clients
	if EBX is not page-aligned, it will be rounded down
SeeAlso: AX=0504h,AX=0507h,INT 21/AX=251Dh,INT 21/AX=EB00h

Format of page attribute words:
 bits 0-2	page type
		000 uncommitted
		001 committed
		010 mapped (see AX=0508h,AX=0509h)
		other currently unused
 bit 3		page is read/write rather than read-only
 bit 4		accessed/dirty bits supplied in bits 5 and 6
 bit 5		page has been accessed (only valid if bit 4 set)
 bit 6		page has been written (only valid if bit 4 set)
 bits 7-15	reserved (0)
----------310507-----------------------------
INT 31 - DPMI 1.0+ - protected mode - MODIFY PAGE ATTRIBUTES
	AX = 0507h
	ESI = memory block handle
	EBX = offset in memory block of first page
	ECX = number of pages
	ES:EDX -> array of WORDs with new page attributes (see AX=0506h)
Return: CF clear if successful
	CF set on error
	    AX = error code (8001h,8002h,8013h,8014h,8021h,8023h,8025h)
		(see AX=0000h)
	    ECX = number of pages which have been set
Notes:	only supported by 32-bit DPMI hosts, but may be used by 16-bit clients
	if EBX is not page-aligned, it will be rounded down
SeeAlso: AX=0504h,AX=0506h,INT 21/AX=251Eh
----------310508-----------------------------
INT 31 - DPMI 1.0+ - protected mode - MAP DEVICE IN MEMORY BLOCK
	AX = 0508h
	ESI = memory block handle
	EBX = page-aligned offset within memory block of page(s) to be mapped
	ECX = number of pages to map
	EDX = page-aligned physical address of device
Return: CF clear if successful
	CF set on error
	    AX = error code (8001h,8003h,8023h,8025h) (see AX=0000h)
Notes:	only supported by 32-bit DPMI hosts, but may be used by 16-bit clients
	support of this function is optional; hosts are also allowed to support
	  the function for some devices but not others
SeeAlso: AX=0504h,AX=0509h,AX=0800h,AX=0801h
----------310509-----------------------------
INT 31 - DPMI 1.0+ - protected mode - MAP CONVENTIONAL MEMORY IN MEMORY BLOCK
	AX = 0509h
	ESI = memory block handle
	EBX = page-aligned offset within memory block of page(s) to map
	ECX = number of pages to map
	EDX = page-aligned linear address of conventional (below 1M) memory
Return: CF clear if successful
	CF set on error
	    AX = error code (8001h,8003h,8023h,8025h) (see AX=0000h)
Notes:	only supported by 32-bit DPMI hosts, but may be used by 16-bit clients
	support of this function is optional
SeeAlso: AX=0504h,AX=0508h,AX=0801h
----------31050A-----------------------------
INT 31 - DPMI 1.0+ - protected mode - GET MEMORY BLOCK SIZE AND BASE
	AX = 050AH
	SI:DI = memory block handle
Return: CF clear if successful
	    SI:DI = size in bytes
	    BX:CX = base address
	CF set on error
	    AX = error code (8023h) (see AX=0000h)
SeeAlso: AX=0501h,AX=0504h
----------31050B-----------------------------
INT 31 - DPMI 1.0+ - protected mode - GET MEMORY INFORMATION
	AX = 050Bh
	ES:(E)DI -> 128-byte buffer for memory information (see below)
Return: CF clear if successful
	CF set on error (DPMI 0.9 only)
Note:	16-bit programs use ES:DI, 32-bit programs must use ES:EDI
SeeAlso: AX=0500h

Format of memory information:
Offset	Size	Description
 00h	DWORD	total allocated bytes of physical memory controlled by host
 04h	DWORD	total allocated bytes of virtual memory controlled by host
 08h	DWORD	total available bytes of virtual memory controlled by host
 0Ch	DWORD	total allocated bytes of virtual memory for curr virtual mach
 10h	DWORD	total available bytes of virtual memory for curr virtual mach
 14h	DWORD	total allocated bytes of virtual memory for current client
 18h	DWORD	total available bytes of virtual memory for current client
 1Ch	DWORD	total locked bytes for current client
 20h	DWORD	maximum locked bytes for current client
 24h	DWORD	highest linear address available to current client
 28h	DWORD	largest available memory block in bytes
 2Ch	DWORD	minimum allocation unit in bytes
 30h	DWORD	allocation alignment unit size in bytes
 34h 76 BYTEs	reserved (00h)
----------310600-----------------------------
INT 31 - DPMI 0.9+ - protected mode - LOCK LINEAR REGION
	AX = 0600h
	BX:CX = starting linear address
	SI:DI = size of region in bytes
Return: CF clear if successful
	CF set on error
	    none of the memory is locked
	    AX = error code (DPMI 1.0+) (8013h,8017h,8025h) (see AX=0000h)
Notes:	pages at beginning and end will be locked if the region overlaps them
	may be called multiple times for a given page; the DPMI host keeps a
	  lock count for each page
SeeAlso: AX=0004h,AX=0601h,INT 21/AX=251Ah,INT 21/AX=EB06h
----------310601-----------------------------
INT 31 - DPMI 0.9+ - protected mode - UNLOCK LINEAR REGION
	AX = 0601h
	BX:CX = starting linear address
	SI:DI = size of region in bytes
Return: CF clear if successful
	CF set on error
	    none of the memory is unlocked
	    AX = error code (DPMI 1.0+) (8002h,8025h) (see AX=0000h)
Notes:	pages at beginning and end will be unlocked if the region overlaps them
	memory whose lock count has not reached zero remains locked
SeeAlso: AX=0005h,AX=0600h,INT 21/AX=251Bh,INT 21/AX=EB07h
----------310602-----------------------------
INT 31 - DPMI 0.9+ - protected mode - MARK REAL MODE REGION AS PAGEABLE
	AX = 0602h
	BX:CX = starting linear address
	SI:DI = size of region in bytes
Return: CF clear if successful
	CF set on error	
	    none of the memory is made pageable
	    AX = error code (DPMI 1.0+) (8002h,8025h) (see AX=0000h)
Notes:	must relock all unlocked real mode memory before terminating process
	  for DPMI 0.9; DPMI 1.0+ automatically relocks real mode memory
	pages at beginning and end will be unlocked if the region overlaps them
	pageability of real mode pages is binary, not a count
SeeAlso: AX=0600h,AX=0603h
----------310603-----------------------------
INT 31 - DPMI 0.9+ - protected mode - RELOCK REAL MODE REGION
	AX = 0603h
	BX:CX = starting linear address
	SI:DI = size of region in bytes
Return: CF clear if successful
	CF set on error	
	    none of the memory is relocked
	    AX = error code (DPMI 1.0+) (8002h,8013h,8025h) (see AX=0000h)
Notes:	pages at beginning and end will be relocked if the region overlaps them
	pageability of real mode pages is binary, not a count
SeeAlso: AX=0602h
----------310604-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET PAGE SIZE
	AX = 0604h
Return: CF clear if successful
	    BX:CX = page size in bytes
	CF set on error
	    AX = error code (DPMI 1.0+)
		8001h unsupported, 16-bit host
----------310700-----------------------------
INT 31 - DPMI 0.9+ - protected mode - MARK PAGES AS PAGING CANDIDATES
	AX = 0700h
	BX:CX = starting linear page number
	SI:DI = number of pages to mark as paging candidates
Return: ???
Note:	although marked as reserved in versions 0.9 and 1.0 of the DPMI
	  specification, this function is called by MS Windows TASKMAN,
	  PROGMAN, and KERNEL
SeeAlso: AX=0701h,AX=0702h
----------310701-----------------------------
INT 31 - DPMI 0.9+ - protected mode - DISCARD PAGES
	AX = 0701h
	BX:CX = starting linear page number
	SI:DI = number of pages to discard
Return: ???
Note:	although marked as reserved in versions 0.9 and 1.0 of the DPMI
	  specification, this function is called by MS Windows TASKMAN,
	  PROGMAN, and KERNEL
SeeAlso: AX=0700h,AX=0703h
----------310702-----------------------------
INT 31 - DPMI 0.9+ - protected mode - MARK PAGE AS DEMAND PAGING CANDIDATE
	AX = 0702h
	BX:CX = starting linear address
	SI:DI = number of bytes to mark as paging candidates
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8025h) (see AX=0000h)
Notes:	this function is advisory, and does not force immediate paging
	partial pages will not be discarded
SeeAlso: AX=0700h,AX=0703h
----------310703-----------------------------
INT 31 - DPMI 0.9+ - protected mode - DISCARD PAGE CONTENTS
	AX = 0703h
	BX:CX = starting linear address
	SI:DI = number of bytes to mark as discarded
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8025h) (see AX=0000h)
Notes:	this function is advisory, and may be ignored by DPMI implementations
	partial pages will not be discarded
SeeAlso: AX=0701h,AX=0702h
----------310800-----------------------------
INT 31 - DPMI 0.9+ - protected mode - PHYSICAL ADDRESS MAPPING
	AX = 0800h
	BX:CX = physical address (should be above 1 MB)
	SI:DI = size in bytes
Return:	CF clear if successful
	    BX:CX = linear address which maps the requested physical memory
	CF set on error
	    AX = error code (DPMI 1.0+) (8003h,8021h) (see AX=0000h)
Notes:	implementations may refuse this call because it can circumvent protects
	the caller must build an appropriate selector for the memory
	do not use for memory mapped in the first megabyte
SeeAlso: AX=0002h,AX=0508h,AX=0509h,AX=0801h,INT 21/AX=250Ah,INT 21/AX=EB05h
----------310801-----------------------------
INT 31 - DPMI 1.0+ - protected mode - FREE PHYSICAL ADDRESS MAPPING
	AX = 0801h
	BX:CX = linear address returned by AX=0800h
Return: CF clear if successful
	CF set on error
	    AX = error code (8025h) (see AX=0000h)
Note:	should be called at end of access to device mapped with AX=0800h
SeeAlso: AX=0508h,AX=0509h,AX=0800h,INT 21/AX=EB03h
----------310900-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET AND DISABLE VIRTUAL INTERRUPT STATE
	AX = 0900h
Return: CF clear
	virtual interrupts disabled
	AL = 00h if previously disabled
	   = 01h if previously enabled
	AH preserved
Notes:	the previous state may be restored simply by executing another INT 31
	a CLI instruction may be used if the previous state is unimportant,
	  but should be assumed to be very slow due to trapping by the host
SeeAlso: AX=0901h,AX=0902h
----------310901-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET AND ENABLE VIRTUAL INTERRUPT STATE
	AX = 0901h
Return: CF clear
	virtual interrupts enabled
	AL = 00h if previously disabled
	   = 01h if previously enabled
	AH preserved
Notes:	the previous state may be restored simply by executing another INT 31
	a STI instruction may be used if the previous state is unimportant,
	  but should be assumed to be very slow due to trapping by the host
SeeAlso: AX=0900h,AX=0902h
----------310902-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET VIRTUAL INTERRUPT STATE
	AX = 0902h
Return: CF clear
	AL = 00h if disabled
	   = 01h if enabled
Note:	should be used rather than PUSHF because that instruction yields the
	  physical interrupt state rather than the per-client virtualized
	  interrupt flag
SeeAlso: AX=0900h,AX=0901h
----------310A00-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET VENDOR SPECIFIC API ENTRY POINT
	AX = 0A00h
	DS:SI / DS:ESI -> case-sensitive ASCIZ vendor name or identifier
Return: CF clear if successful
	    ES:DI / ES:EDI -> FAR extended API entry point
	    DS, FS, GS, EAX, EBX, ECX, EDX, ESI, EBP destroyed
	CF set on error
	    AX = error code (DPMI 1.0+) (8001h) (see AX=0000h)
Notes:	extended API parameters are vendor-specific
	DPMI 1.0+ supports this function solely for backward compatibility; use
	  INT 2F/AX=168Ah instead
SeeAlso: INT 2F/AX=168Ah
----------310B00-----------------------------
INT 31 - DPMI 0.9+ - protected mode - SET DEBUG WATCHPOINT
	AX = 0B00h
	BX:CX = linear address
	DL = size (1,2,4 bytes)
	DH = type (00h execute, 01h write, 02h read/write)
Return: CF clear if successful
	    BX = watchpoint handle
	CF set on error
	    AX = error code (DPMI 1.0+) (8016h,8021h,8025h) (see AX=0000h)
SeeAlso: AX=0212h,AX=0601h
----------310B01-----------------------------
INT 31 - DPMI 0.9+ - protected mode - CLEAR DEBUG WATCHPOINT
	AX = 0B01h
	BX = watchpoint handle
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8023h) (see AX=0000h)
Note:	the watchpoint handle is freed
SeeAlso: AX=0B00h
----------310B02-----------------------------
INT 31 - DPMI 0.9+ - protected mode - GET STATE OF DEBUG WATCHPOINT
	AX = 0B02h
	BX = watchpoint handle
Return: CF clear if successful
	    AX = status flags
		bit 0: watch point has been executed since AX=0B00h or AX=0B03h
	CF set on error
	    AX = error code (DPMI 1.0+) (8023h) (see AX=0000h)
SeeAlso: AX=0B00h,AX=0B03h
----------310B03-----------------------------
INT 31 - DPMI 0.9+ - protected mode - RESET DEBUG WATCHPOINT
	AX = 0B03h
	BX = watchpoint handle
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8023h) (see AX=0000h)
SeeAlso: AX=0B02h
----------310C00-----------------------------
INT 31 - DPMI 1.0+ - protected mode - INSTALL RESIDENT HANDLER INIT CALLBACK
	AX = 0C00h
	ES:(E)DI -> resident service provider structure (see below)
Return: CF clear if successful
	CF set on error
	    AX = error code (8015h,8021h,8025h) (see AX=0000h)
Note:	calling this function declares an intent to provide resident
	  protected mode services after terminating with AX=0C01h
SeeAlso: AX=0303h,AX=0C01h

Format of resident service provider structure:
Offset	Size	Description
 00h	QWORD	descriptor for 16-bit data segment
 08h	QWORD	descriptor for 16-bit code segment (zeros if not supported)
 10h	WORD	offset of 16-bit callback procedure
 12h  2 BYTEs	reserved
 14h	QWORD	descriptor for 32-bit data segment
 1Ch	QWORD	descriptor for 32-bit code segment (zeros if not supported)
 24h	DWORD	offset of 32-bit callback procedure
----------310C01-----------------------------
INT 31 - DPMI 1.0+ - protected mode - TERMINATE AND STAY RESIDENT
	AX = 0C01h
	BL = return code
	DX = number of paragraphs of DOS memory to reserve (0 or >= 6)
Return: never
Notes:	should only be used if the program will only provide services to
	  other DPMI programs
	any protected mode memory remains allocated to the program unless
	  explicitly freed before this call
	must first call AX=0C00h or program will simply be terminated
SeeAlso: AX=0C00h,INT 21/AH=31h
----------310D00-----------------------------
INT 31 - DPMI 1.0+ - protected mode - ALLOCATE SHARED MEMORY
	AX = 0D00h
	ES:(E)DI -> shared memory allocation request structure (see below)
Return: CF clear if successful
	    request structure updated
	CF set on error
	    AX = error code (8012h,8013h,8014h,8016h,8021h) (see AX=0000h)
Note:	first 16 bytes of memory block will be initialized to zeros on the
	  first allocation
SeeAlso: AX=0501h,AX=0D01h,AX=0D02h

Format of shared memory allocation request structure:
Offset	Size	Description
 00h	DWORD	requested length of shared memory block in bytes
 04h	DWORD	(return) allocated length of block
 08h	DWORD	(return) shared memory handle
 0Ch	DWORD	(return) linear address of memory block
 10h  6 BYTEs	selector:offset32 of ASCIZ name for memory block
		(name max 128 bytes)
 16h  2 BYTEs	reserved
 18h  4 BYTEs	reserved (00h)
----------310D01-----------------------------
INT 31 - DPMI 1.0+ - protected mode - FREE SHARED MEMORY
	AX = 0D01h
	SI:DI = shared memory block handle
Return: CF clear if successful
	CF set on error
	    AX = error code (8023h) (see AX=0000h)
Notes:	handle becomes invalid after this call
	DPMI maintains separate global and virtual machine use counts for each
	  shared memory block; when the global use counts reaches zero, the
	  block is finally destroyed
SeeAlso: AX=0502h,AX=0D00h
----------310D02-----------------------------
INT 31 - DPMI 1.0+ - protected mode - SERIALIZE SHARED MEMORY
	AX = 0D02h
	SI:DI = shared memory block handle
	DX = flags
	    bit 0: return immediately rather than suspending if serialization
			unavailable
		1: shared rather than exclusive serialization
		2-15: reserved (0)
Return: CF clear if successful
	CF set on error
	    AX = error code (8004h,8005h,8017h-8019h,8023h) (see AX=0000h)
Notes:	an exclusive serialization blocks any other serialization attempts for
	  the same block by another virtual machine; a shared serialization
	  blocks attempts at exclusive serialization by another virtual machine
	hosts are not required to detect deadlock
	a client's interrupt handler can cancel a serialization call which
	  caused it to block by calling AX=0D03h
SeeAlso: AX=0D00h,AX=0D03h
----------310D03-----------------------------
INT 31 - DPMI 1.0+ - protected mode - FREE SERIALIZATION ON SHARED MEMORY
	AX = 0D03h
	SI:DI = shared memory block handle
	DX = flags
	    bit 0: release shared serialization rather than exclusive serialztn
	    bit 1: free pending serialization
	    bits 2-15: reserved (0)
Return: CF clear if successful
	CF set on error
	    AX = error code (8002h,8023h) (see AX=0000h)
SeeAlso: AX=0D00h,AX=0D02h
----------310E00-----------------------------
INT 31 - DPMI 1.0+ - protected mode - GET COPROCESSOR STATUS
	AX = 0E00h
Return: CF clear
	AX = coprocessor status
	    bit 0: numeric coprocessor enabled for current client
	    bit 1: client is emulating coprocessor
	    bit 2: numeric coprocessor is present
	    bit 3: host is emulating coprocessor instructions
	    bits 4-7: coprocessor type
		0000 none
		0010 80287
		0011 80387
		0100 80486 with numeric coprocessor
		other reserved
	    bits 8-15: not used
SeeAlso: AX=0E01h
----------310E01-----------------------------
INT 31 - DPMI 1.0+ - protected mode - SET EMULATION
	AX = 0E01h
	BX = coprocessor flag bits
	    bit 0: enable numeric coprocessor for current client
	    bit 1: client will emulate coprocessor
	    bits 2-15: not used
Return: CF clear if successful
	CF set on error
	    AX = error code (8026h) (see AX=0000h)
SeeAlso: AX=0E00h
----------32---------------------------------
INT 32 - reportedly used by "Tiny" Viruses
SeeAlso: INT 60"Virus"
----------330000-----------------------------
INT 33 - MS MOUSE - RESET DRIVER AND READ STATUS
	AX = 0000h
Return: AX = status
	    0000h hardware/driver not installed
	    FFFFh hardware/driver installed
	BX = number of buttons
	    FFFFh two buttons
	    0000h other than two
	    0003h Mouse Systems/Logitech mouse
Notes:	to use mouse on a Hercules-compatible monographics card in graphics
	  mode, you must first set 0040h:0049h to 6 for page 0 or 5 for page 1,
	  and then call this function.
	the Logitech mouse driver contains the signature string "LOGITECH"
SeeAlso: AX=0021h,INT 74
----------330001-----------------------------
INT 33 - MS MOUSE - SHOW MOUSE CURSOR
	AX = 0001h
SeeAlso: AX=0002h,INT 16/AX=FFFEh
----------330002-----------------------------
INT 33 - MS MOUSE - HIDE MOUSE CURSOR
	AX = 0002h
Note:	multiple calls to hide the cursor will require multiple calls to
	  function 01h to unhide it.
SeeAlso: AX=0001h,AX=0010h,INT 16/AX=FFFFh
----------330003-----------------------------
INT 33 - MS MOUSE - RETURN POSITION AND BUTTON STATUS
	AX = 0003h
Return: BX = button status
	   bit 0  left button pressed if 1
	   bit 1  right button pressed if 1
	   bit 2  middle button pressed if 1 (Mouse Systems/Logitech mouse)
	CX = column
	DX = row
SeeAlso: AX=0004h,AX=000Bh
----------330004-----------------------------
INT 33 - MS MOUSE - POSITION MOUSE CURSOR
	AX = 0004h
	CX = column
	DX = row
Note:	the row and column are truncated to the next lower multiple of the cell
	  size; however, some versions of the Microsoft documentation
	  incorrectly state that the coordinates are rounded
SeeAlso: AX=0003h
----------330005-----------------------------
INT 33 - MS MOUSE - RETURN BUTTON PRESS DATA
	AX = 0005h
	BX = button
	    0000h left
	    0001h right
	    0002h middle (Mouse Systems/Logitech mouse)
Return: AX = button states
	    bit 0 left button pressed if 1
	    bit 1 right button pressed if 1
	    bit 2 middle button pressed if 1 (Mouse Systems/Logitech mouse)
	BX = number of times specified button has been pressed since last call
	CX = column at time specified button was last pressed
	DX = row at time specified button was last pressed
SeeAlso: AX=0006h
----------330006-----------------------------
INT 33 - MS MOUSE - RETURN BUTTON RELEASE DATA
	AX = 0006h
	BX = button
	    0000h left
	    0001h right
	    0002h middle (Mouse Systems/Logitech mouse)
Return: AX = button states
	    bit 0 left button pressed if 1
	    bit 1 right button pressed if 1
	    bit 2 middle button pressed if 1 (Mouse Systems/Logitech mouse)
	BX = number of times specified button has been released since last call
	CX = column at time specified button was last released
	DX = row at time specified button was last released
SeeAlso: AX=0005h
----------330007-----------------------------
INT 33 - MS MOUSE - DEFINE HORIZONTAL CURSOR RANGE
	AX = 0007h
	CX = minimum column
	DX = maximum column
SeeAlso: AX=0008h,AX=0010h
----------330008-----------------------------
INT 33 - MS MOUSE - DEFINE VERTICAL CURSOR RANGE
	AX = 0008h
	CX = minimum row
	DX = maximum row
SeeAlso: AX=0007h,AX=0010h
----------330009-----------------------------
INT 33 - MS MOUSE - DEFINE GRAPHICS CURSOR
	AX = 0009h
	BX = column of cursor hot spot in bitmap (-16 to 16)
	CX = row of cursor hot spot (-16 to 16)
	ES:DX -> bitmap
		16 words screen mask
		16 words cursor mask
		    each word defines the sixteen pixels of a row, low bit
		    rightmost
SeeAlso: AX=000Ah,AX=0012h
----------33000A-----------------------------
INT 33 - MS MOUSE - DEFINE TEXT CURSOR
	AX = 000Ah
	BX = hardware/software text cursor
	    0000h software
		CX = screen mask
		DX = cursor mask
	    0001h hardware
		CX = start scan line
		DX = end scan line
Note:	when the software cursor is selected, the char/attribute data at the
	  current screen position is ANDed with the screen mask and then XORed
	  with the cursor mask
SeeAlso: AX=0009h
----------33000B-----------------------------
INT 33 - MS MOUSE - READ MOTION COUNTERS
	AX = 000Bh
Return: CX = number of mickeys mouse moved horizontally since last call
	DX = number of mickeys mouse moved vertically
Notes:	a mickey is the smallest increment the mouse can sense
	positive values indicate down/right
SeeAlso: AX=0003h,AX=001Bh
----------33000C-----------------------------
INT 33 - MS MOUSE - DEFINE INTERRUPT SUBROUTINE PARAMETERS
	AX = 000Ch
	CX = call mask
	     bit 0 call if mouse moves
	     bit 1 call if left button pressed
	     bit 2 call if left button released
	     bit 3 call if right button pressed
	     bit 4 call if right button released
	     bit 5 call if middle button pressed (Mouse Systems/Logitech mouse)
	     bit 6 call if middle button released (Mouse Sys/Logitech mouse)
	ES:DX -> FAR routine
Notes:	when the subroutine is called, it is passed the following values:
	  AX = condition mask (same bit assignments as call mask)
	  BX = button state
	  CX = cursor column
	  DX = cursor row
	  SI = horizontal mickey count
	  DI = vertical mickey count
	some versions of the Microsoft documentation incorrectly state that CX
	  bit 0 means call if mouse cursor moves, and swap the meanings of SI
	  and DI
SeeAlso: AX=0018h
----------33000D-----------------------------
INT 33 - MS MOUSE - LIGHT PEN EMULATION ON
	AX = 000Dh
SeeAlso: AX=000Eh
----------33000E-----------------------------
INT 33 - MS MOUSE - LIGHT PEN EMULATION OFF
	AX = 000Eh
SeeAlso: AX=000Dh
----------33000F-----------------------------
INT 33 - MS MOUSE - DEFINE MICKEY/PIXEL RATIO
	AX = 000Fh
	CX = number of mickeys per 8 pixels horizontally (default 8)
	DX = number of mickeys per 8 pixels vertically (default 16)
SeeAlso: AX=0013h,AX=001Ah
----------330010-----------------------------
INT 33 - MS MOUSE - DEFINE SCREEN REGION FOR UPDATING
	AX = 0010h
	CX,DX = X,Y coordinates of upper left corner
	SI,DI = X,Y coordinates of lower right corner
Note:	mouse cursor is hidden during updating, and needs to be explicitly
	  turned on again
SeeAlso: AX=0001h,AX=0002h,AX=0007h
----------330012-----------------------------
INT 33 - MS MOUSE - SET LARGE GRAPHICS CURSOR BLOCK
	AX = 0012h
	BH = cursor width in words
	CH = rows in cursor
	BL = horizontal hot spot (-16 to 16)
	CL = vertical hot spot (-16 to 16)
	ES:DX -> bit map of screen and cursor maps
Return: AX = FFFFh if successful
SeeAlso: AX=0009h
----------330013-----------------------------
INT 33 - MS MOUSE - DEFINE DOUBLE-SPEED THRESHOLD
	AX = 0013h
	DX = threshold speed in mickeys/second, 0000h = default of 64/second
Note:	if speed exceeds threshold, the cursor's on-screen motion is doubled
SeeAlso: AX=000Fh,AX=001Bh,AX=002Ch
----------330014-----------------------------
INT 33 - MS MOUSE - EXCHANGE INTERRUPT SUBROUTINES
	AX = 0014h
	CX = call mask (see AX=000Ch)
	ES:DX -> FAR routine 
Return: CX = call mask of previous interrupt routine
	ES:DX = FAR address of previous interrupt routine
SeeAlso: AX=0018h
----------330015-----------------------------
INT 33 - MS MOUSE - RETURN DRIVER STORAGE REQUIREMENTS
	AX = 0015h
Return: BX = size of buffer needed to store driver state
SeeAlso: AX=0016h,AX=0017h,AX=0042h
----------330016-----------------------------
INT 33 - MS MOUSE - SAVE DRIVER STATE
	AX = 0016h
	BX = size of buffer (see AX=0015h)
	ES:DX -> buffer for driver state
Note:	although not documented, many drivers appear to require BX on input
SeeAlso: AX=0015h,AX=0017h
----------330017-----------------------------
INT 33 - MS MOUSE - RESTORE DRIVER STATE
	AX = 0017h
	BX = size of buffer (see AX=0015h)
	ES:DX -> buffer containing saved state
Notes:	although not documented, many drivers appear to require BX on input
	some mouse drivers range-check the values in the saved state based on
	  the current video mode; thus, the video mode should be restored
	  before the mouse driver's state is restored
SeeAlso: AX=0015h,AX=0016h
----------330018-----------------------------
INT 33 - MS MOUSE - SET ALTERNATE MOUSE USER HANDLER
	AX = 0018h
	CX = call mask
	     bit 0 call if alt key pressed during event
	     bit 1 call if ctrl key pressed during event
	     bit 2 call if shift button pressed during event
	     bit 3 call if right button released
	     bit 4 call if right button pressed
	     bit 5 call if left button released
	     bit 6 call if left button pressed
	     bit 7 call if mouse moves
	ES:DX = address of FAR routine
Return: AX = 0018h if successful
	   = FFFFh on error
Notes:	when the subroutine is called, it is passed the following values:
	  AX = condition mask (same bit assignments as call mask)
	  BX = button state
	  CX = cursor column
	  DX = cursor row
	  DI = horizontal mickey count
	  SI = vertical mickey count
	up to three handlers can be defined by separate calls to this function
SeeAlso: AX=0014h,AX=0019h
----------330019-----------------------------
INT 33 - MS MOUSE - RETURN USER ALTERNATE INTERRUPT VECTOR
	AX = 0019h
	CX = call mask
Return: BX:DX = user interrupt vector
	CX = call mask (0 if not found)
Note:	attempts to find a user event handler (defined by function 18h)
	  whose call mask matches CX
SeeAlso: AX=0018h
----------33001A-----------------------------
INT 33 - MS MOUSE - SET MOUSE SENSITIVITY
	AX = 001Ah
	BX = horizontal speed \
	CX = vertical speed   / (see AX=000Fh)
	DX = double speed threshold (see AX=0013h)
SeeAlso: AX=0013h,AX=001Bh
----------33001B-----------------------------
INT 33 - MS MOUSE - RETURN MOUSE SENSITIVITY
	AX = 001Bh
Return: BX = horizontal speed
	CX = vertical speed
	DX = double speed threshold
SeeAlso: AX=000Bh,AX=001Ah
----------33001C-----------------------------
INT 33 - MS MOUSE - SET INTERRUPT RATE
	AX = 001Ch
	BX = rate
	    00h no interrupts allowed
	    01h 30 per second
	    02h 50 per second
	    03h 100 per second
	    04h 200 per second
Notes:	only available on InPort mouse
	values greater than 4 may cause unpredictable driver behavior
----------33001D-----------------------------
INT 33 - MS MOUSE - DEFINE DISPLAY PAGE NUMBER
	AX = 001Dh
	BX = display page number
Note:	the cursor will be displayed on the specified page
SeeAlso: AX=001Eh
----------33001E-----------------------------
INT 33 - MS MOUSE - RETURN DISPLAY PAGE NUMBER
	AX = 001Eh
Return: BX = display page number
SeeAlso: AX=001Dh
----------33001F-----------------------------
INT 33 - MS MOUSE - DISABLE MOUSE DRIVER
	AX = 001Fh
Return: AX = 001Fh successful
	     FFFFh unsuccessful
	ES:BX = vector for INT 33h before mouse driver was first installed
Note:	restores vectors for Int 10h and Int 71h (8086) or Int 74h (286/386)
	if you restore Int 33h to ES:BX, driver will be completely disabled
SeeAlso: AX=0020h
----------330020-----------------------------
INT 33 - MS MOUSE - ENABLE MOUSE DRIVER
	AX = 0020h
Note:	restores vectors for Int 10h and Int 71h (8086) or Int 74h (286/386)
	  which were removed by function 1Fh
SeeAlso: AX=001Fh
----------330021-----------------------------
INT 33 - MS MOUSE - SOFTWARE RESET
	AX = 0021h
Return: AX = FFFFh if mouse driver installed
	     0021h if mouse driver not installed
	BX = 2 if mouse driver is installed
Note:	identical to funtion 00h, but does not reset the mouse
SeeAlso: AX=0000h
----------330022-----------------------------
INT 33 - MS MOUSE - SET LANGUAGE FOR MESSAGES
	AX = 0022h
	BX = language
	    00h English
	    01h French
	    02h Dutch
	    03h German
	    04h Swedish
	    05h Finnish
	    06h Spanish
	    07h Portugese
	    08h Italian
Note:	only available on international versions of the driver, US versions
	  ignore this call
SeeAlso: AX=0023h
----------330023-----------------------------
INT 33 - MS MOUSE - GET LANGUAGE FOR MESSAGES
	AX = 0023h
Return:	BX = language (see AX=0022h)
Note:	the US version of the driver always returns zero 
SeeAlso: AX=0022h
----------330024-----------------------------
INT 33 - MS MOUSE - GET SOFTWARE VERSION AND MOUSE TYPE
	AX = 0024h
Return: AX = FFFFh on error
	otherwise,
	    BH = major version
	    BL = minor version
	    CH = type (1=bus, 2=serial, 3=InPort, 4=PS/2, 5=HP)
	    CL = interrupt (0=PS/2, 2=IRQ2, 3=IRQ3,...,7=IRQ7)
SeeAlso: AX=004Dh
----------330026-----------------------------
INT 33 - MS MOUSE - ???
	AX = 0026h
Note:	called by the newest Microsoft applications
----------33002C-----------------------------
INT 33 - MS MOUSE - SET ACCELERATION PROFILES
	AX = 002Ch
	ES:DX -> name of file containing profiles
Note:	see MOUSEPRO.FIL for an example set of acceleration profiles
SeeAlso: AX=0013h,AX=002Dh
----------33002D-----------------------------
INT 33 - MS MOUSE - SELECT ACCELERATION PROFILE
	AX = 002Dh
	BX = acceleration level (01h to 04h)
Note:	acceleration of FFFFh appears to be legal as well, since it is used
	  by the MS Control Panel v7.04
SeeAlso: AX=0013h,AX=002Ch
----------330042-----------------------------
INT 33 - PCMOUSE - GET MSMOUSE STORAGE REQUIREMENTS
	AX = 0042h
Return: AX = FFFFh successful
		BX = buffer size in bytes for functions 50h and 52h
	   = 0000h MSMOUSE not installed
	   = 0042h functions 42h, 50h, and 52h not supported
SeeAlso: AX=0015h,AX=0050h
----------33004D-----------------------------
INT 33 - MS MOUSE, LOGITECH - RETURN POINTER TO COPYRIGHT STRING
	AX = 004Dh
Return: ES:DI -> copyright message "Copyright 1983 Microsoft ***"
Note:	also supported by Kraft mouse driver
SeeAlso: AX=0024h,AX=006Dh
----------330050-----------------------------
INT 33 - PCMOUSE - SAVE MSMOUSE STATE
	AX = 0050h
	BX = buffer size
	ES:DX -> buffer
Return: AX = FFFFh if successful
SeeAlso: AX=0042h,AX=0052h
----------330052-----------------------------
INT 33 - PCMOUSE - RESTORE MSMOUSE STATE
	AX = 0052h
	BX = buffer size
	ES:DX -> buffer
Return: AX = FFFFh if successful
SeeAlso: AX=0050h
----------330055-----------------------------
INT 33 - Kraft Mouse - GET ???
	AX = 0055h
Return: CX = ???
	DX = ???
	ES = ???
----------33006D-----------------------------
INT 33 - MS MOUSE, Logitech - GET VERSION STRING
	AX = 006Dh
Return: ES:DI -> Microsoft version number of resident driver
Note:	also supported by Kraft mouse driver
SeeAlso: AX=004Dh
----------331D6C-----------------------------
INT 33 - LOGITECH - GET COMPASS PARAMETER
	AX = 1D6Ch
Return: BX = direction (0=north, 1=south, 2=east, 3=west)
SeeAlso: AX=1E6Ch
----------331E6C-----------------------------
INT 33 - LOGITECH - SET COMPASS PARAMETER
	AX = 1E6Ch
	BX = direction (0=north, 1=south, 2=east, 3=west)
SeeAlso: AX=1D6Ch
----------331F6C-----------------------------
INT 33 - LOGITECH - GET BALLISTICS INFORMATION
	AX = 1F6Ch
Return: BX = 0=off, 1=on
	CX = 1=low, 2=high
SeeAlso: AX=002Ch,AX=236Ch
----------33206C-----------------------------
INT 33 - LOGITECH - SET LEFT OR RIGHT PARAMETER
	AX = 206Ch
	BX = parameter (00h = right, FFh = left)
SeeAlso: AX=216Ch
----------33216C-----------------------------
INT 33 - LOGITECH - GET LEFT OR RIGHT PARAMETER
	AX = 216Ch
Return: BX = parameter (00h = right, FFh = left)
SeeAlso: AX=206Ch
----------33226C-----------------------------
INT 33 - LOGITECH - REMOVE DRIVER FROM MEMORY
	AX = 226Ch
Note:	this only frees memory; does not restore hooked interrupts
----------33236C-----------------------------
INT 33 - LOGITECH - SET BALLISTICS INFORMATION
	AX = 236Ch
	BX = 0=off, 1=on
	CX = 1=low, 2=high
SeeAlso: AX=002Ch,AX=1F6Ch
----------33246C-----------------------------
INT 33 - LOGITECH - GET PARAMETERS AND RESET SERIAL MOUSE
	AX = 246Ch
	ES:DX -> parameter table buffer (see below)
Return: AX = FFFFh if driver installed for serial mouse
SeeAlso: AX=0000h,AX=256Ch

Format of parameter table:
Offset	Size	Description
 00h	WORD	baud rate divided by 100  (serial mouse only)
 02h	WORD	emulation		  (serial mouse only)
 04h	WORD	report rate		  (serial mouse only)
 06h	WORD	firmware revision	  (serial mouse only)
 08h	WORD	0			  (serial mouse only)
 0Ah	WORD	port			  (serial mouse only)
 0Ch	WORD	physical buttons
 0Eh	WORD	logical buttons
----------33256CBX00h -----------------------
INT 33 - LOGITECH - SET PARAMETERS
	AX = 256Ch
	BX = 00h set baud rate (serial mouse only)
		CX = rate (0=1200, 1=2400, 2=4800, 3=9600)
	   = 01h set emulation (serial mouse only)
		CX = emulation
		    0 = 5 byte packed binary
		    1 = 3 byte packed binary
		    2 = hexadecimal
		    3 = relative bit pad
		    4 = not supported
		    5 = MM Series
		    6 = not supported
		    7 = Microsoft
	   = 02h set report rate (serial mouse only)
		CX = rate (0=10, 1=20, 2=35, 3=50, 4=70, 5=100, 6=150)
	   = 03h set port (serial mouse only)
		CX = port (1, 2)
	   = 04h set mouse logical buttons
		CX = buttons (2, 3)
Return: AX = FFFFh if driver installed for serial mouse
SeeAlso: AX=246Ch
----------33266C-----------------------------
INT 33 - LOGITECH - GET VERSION???
	AX = 266Ch
Return: BX = 'SS'
	CH = '4'  major version number
	CL = '1'  minor version number
SeeAlso: AX=006Dh
----------33276C-----------------------------
INT 33 - LOGITECH - ??? Tries MMSeries, Baud 2400
	AX = 276Ch
----------34---------------------------------
INT 34 - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode D8h
----------35---------------------------------
INT 35 - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode D9h
----------36---------------------------------
INT 36 - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode DAh
----------37---------------------------------
INT 37 - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode DBh
----------38---------------------------------
INT 38 - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode DCh
----------39---------------------------------
INT 39 - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode DDh
----------3A---------------------------------
INT 3A - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode DEh
----------3B---------------------------------
INT 3B - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode DFh
----------3C---------------------------------
INT 3C - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates instructions with a segment override
Note:	the generated code is  CD 3C xy mm ....
	where xy is a modified ESC instruction and mm is the modR/M byte.  The
	xy byte appears to be encoded as
	    s s 0 1 1 x x x
	where "ss" specifies the segment override:
		00 -> DS:
		01 -> SS:
		10 -> CS:
		11 -> ES:
----------3D---------------------------------
INT 3D - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates a standalone FWAIT instruction
----------3E---------------------------------
INT 3E - Borland languages - Floating Point emulation "shortcut" call
	The two bytes following the INT 3E instruction are the subcode and
	a NOP (90h)

Subcode		Function
 DCh	load 8086 stack with 8087 registers
 DEh	load 8087 registers from 8086 stack
 E0h	round TOS and R1 to single precision, compare, pop twice
 E2h	round TOS and R1 to double precision, compare, pop twice
	Note: apparently buggy in TPas5.5, actually rounding to single prec.
 E4h	compare TOS/R1 with two POP's
 E6h	compare TOS/R1 with POP
 E8h	FTST (check TOS value)
 EAh	FXAM (check TOS value)
 ECh	sine
 EEh	cosine
 F0h	tangent
 F2h	arctangent
 F4h	Ln (FLDLN2 to TOS)
 F6h	Log2 (FLDLG2 to TOS)
 F8h	Log10 (FLDLG10 to TOS
 FAh	Exp (FLDL2E to TOS)
 FCh	TOS = 2**TOS
 FEh	TOS = 10**TOS
----------3F---------------------------------
INT 3F - Overlay manager interrupt (Microsoft LINK.EXE, Borland TLINK VROOMM)
Note:	INT 3F is the default, and may be overridden while linking
----------3F---------------------------------
INT 3F - Microsoft Dynamic Link Library manager
----------40---------------------------------
INT 40 - DISKETTE - ROM BIOS DISKETTE HANDLER RELOCATED BY HARD DISK BIOS
SeeAlso: INT 13,INT 63
----------40---------------------------------
INT 40 - Z100 - Master 8259 - Parity error or S100 error
----------41---------------------------------
INT 41 - SYSTEM DATA - HARD DISK 0 PARAMETER TABLE
Note:	the default parameter table array is located at F000h:E401h in 100%
	  compatible BIOSes; the pointer may be overridden by the hard disk
	  controller's BIOS to support drive formats unknown to the ROM BIOS
SeeAlso: INT 13/AH=09h,INT 1E,INT 46

Format of fixed disk parameters:
Offset	Size	Description
 00h	WORD	number of cylinders
 02h	BYTE	number of heads
 03h	WORD	starting reduced write current cylinder (XT only, 0 for others)
 05h	WORD	starting write precompensation cylinder number
 07h	BYTE	maximum ECC burst length (XT only)
 08h	BYTE	control byte
		   bits 0-2: drive option (XT only, 0 for others)
		   bit 3:    set if more than 8 heads (AT and later only)
		   bit 4:    always 0
		   bit 5:    set if manufacturer's defect map on max cylinder+1
			     (AT and later only)
		   bit 6:    disable ECC retries
		   bit 7:    disable access retries
 09h	BYTE	standard timeout (XT only, 0 for others)
 0Ah	BYTE	formatting timeout (XT only, 0 for others)
 0Bh	BYTE	timeout for checking drive (XT only, 0 for others)
 0Ch	WORD	cylinder number of landing zone (AT and later only)
 0Eh	BYTE	number of sectors per track (AT and later only)
 0Fh	BYTE	reserved
----------41---------------------------------
INT 41 - Z100 - Master 8259 - Processor Swap
----------42---------------------------------
INT 42 - VIDEO - RELOCATED DEFAULT INT 10 VIDEO SERVICES (EGA,VGA)
SeeAlso: INT 10
Note:	not used by PS/2 built-in VGA or XGA
----------42---------------------------------
INT 42 - Z100 - Master 8259 - Timer
----------43---------------------------------
INT 43 - VIDEO DATA - CHARACTER TABLE (EGA,MCGA,VGA)
   points at graphics data for characters 00h-7Fh of the current font
SeeAlso: INT 1F,INT 44"VIDEO"
----------43---------------------------------
INT 43 - Z100 - Master 8259 - Slave 8259 input
Note:	slave runs in special fully nested mode
----------44---------------------------------
INT 44 - VIDEO DATA - ROM BIOS CHARACTER FONT, CHARACTERS 00h-7Fh (PCjr)
   points at graphics data for current character font
SeeAlso: INT 1F,INT 43"VIDEO"
----------44---------------------------------
INT 44 - Novell NetWare - HIGH-LEVEL LANGUAGE API
----------44---------------------------------
INT 44 - IBM 3270-PC High Level Language API
	DS:SI -> parameter control block
----------44---------------------------------
INT 44 - Z100 - Master 8259 - Serial A
SeeAlso: INT 45"Z100"
----------45---------------------------------
INT 45 - Z100 - Master 8259 - Serial B
SeeAlso: INT 44"Z100"
----------46---------------------------------
INT 46 - SYSTEM DATA - HARD DISK 1 DRIVE PARAMETER TABLE
SeeAlso: INT 13/AH=09h,INT 41
----------46---------------------------------
INT 46 - Z100 - Master 8259 - Keyboard, Retrace, and Light Pen
SeeAlso: INT 47"Z100"
----------47---------------------------------
INT 47 - Z100 - Master 8259 - Printer
SeeAlso: INT 46"Z100"
----------478000-----------------------------
INT 47 - SQL Base - DATABASE ENGINE API
	AX = 8000h
	DS:BX -> parameter block, first word is function number
Note:	SQL Base is a network-oriented database engine by Gupta Technologies

Values for function number:
 01h	"SQLFINI" initalialize application's use of the database
 02h	"SQLFDON" application is done using the database
 03h	"SQLFCON" connect to a cursor/database
 04h	"SQLFDIS" disconnect from a cursor/database
 05h	"SQLFCOM" compile a SQL command
 06h	"SQLFEXE" execute a SQL command
 07h	"SQLFCEX" compile and execute a SQL command
 08h	"SQLFCMT" commit a transaction to the database
 09h	"SQLFDES" describe the items of a SELECT statement
 0Ah	"SQLFGFI" get fetch information
 0Bh	"SQLFFBK" fetch previous result row from SELECT statement
 0Ch	"SQLFFET" fetch next result row from SELECT statement
 0Dh	"SQLFEFB" enable fetch backwards
 0Eh	"SQLFPRS" position in result set
 0Fh	"SQLFURS" undo result set
 10h	"SQLFNBV" get number of bind variables
 11h	"SQLFBND" bind data variables
 12h	"SQLFBNN" bind numerics
 13h	"SQLFBLN" bind long number
 14h	"SQLFBLD" bind long data variables
 15h	"SQLFSRS" start restriction set processing
 16h	"SQLFRRS" restart restriction set processing
 17h	"SQLFCRS" close restriction set
 18h	"SQLFDRS" drop restriction set
 19h	"SQLFARF" apply Roll Forward journal
 1Ah	"SQLFERF" end Roll Forward journal
 1Bh	"SQLFSRF" start Roll Forward journal
 1Ch	"SQLFSTO" store a compiled SQL command
 1Dh	"SQLFRET" retrieve a compiled SQL command
 1Eh	"SQLFDST" drop a stored command
 1Fh	"SQLFCTY" get command type
 20h	"SQLFEPO" get error position
 21h	"SQLFGNR" get number of rows
 22h	"SQLFNSI" get number of select items
 23h	"SQLFRBF" get Roll Back flag
 24h	"SQLFRCD" get return code
 25h	"SQLFROW" get number of ROWs
 26h	"SQLFSCN" set cursor name
 27h	"SQLFSIL" set isolation level
 28h	"SQLFSLP" set log parameters
 29h	"SQLFSSB" set select buffer
 2Ah	"SQLFSSS" set sort space
 2Bh	"SQLFRLO" read long
 2Ch	"SQLFWLO" write long
 2Dh	"SQLFLSK" long seek
 2Eh	"SQLFGLS" get long size
 2Fh	"SQLFELO" end long operation
 30h	"SQLFRBK" roll back a transaction from the database
 31h	"SQLFERR" error message
 32h	"SQLFCPY" copy
 33h	"SQLFR01" reserved
 34h	"SQLFSYS" system
 35h	"SQLFSTA" statistics
 36h	"SQLFR02" reserved
 37h	"SQLFXAD" extra add
 38h	"SQLFXCN" extra character to number
 39h	"SQLFXDA" extra date add
 3Ah	"SQLFXDP" extra date picture
 3Bh	"SQLFXDV" extra divide
 3Ch	"SQLFXML" extra multiply
 3Dh	"SQLFXNP" extra number picture
 3Eh	"SQLFXPD" extra picture date
 3Fh	"SQLFXSB" extra subtract
 40h	"SQLFINS" install database
 41h	"SQLFDIN" deinstall database
 42h	"SQLFDIR" directory of databases
 43h	"SQLFTIO" timeout
 44h	"SQLFFQN" get fully qualified column name
 45h	"SQLFEXP" explain execution plan
 46h	"SQLFFER" get full error
 47h	"SQLFBKP" begin online backup
 48h	"SQLFRDC" read backup data chunk
 49h	"SQLFEBK" end backup
 4Ah	"SQLFRES" begin restore from backup
 4Bh	"SQLFWDC" write backup data chunk for restore
 4Ch	"SQLFRRD" recover restored database to consistent state
 4Dh	"SQLFERS" end restore
 4Eh	"SQLFNRR" return number of result set rows
 4Fh	"SQLFSTR" start restriction mode
 50h	"SQLFSPR" stop restriction mode
 51h	"SQLFCNC" connect 2
 52h	"SQLFCNR" connect with no recovery
 53h	"SQLFOMS" set output message size
 54h	"SQLFIMS" set input message size
 55h	"SQLFSCP" set cache pages
 56h	"SQLFDSC" describe items of a SELECT statement (external)
 57h	"SQLFLAB" get label info for items in SELECT statement
 58h	"SQLFCBV" clear bind variables
 59h	"SQLFGET" get database information
 5Ah	"SQLFSET" set database information
 5Bh	"SQLFTEC" translate error code
----------478001-----------------------------
INT 47 - SQL Base - GET VERSION NUMBER
	AX = 8001h
Return: ???
Note:	SQL Base is a network-oriented database engine by Gupta Technologies
----------48---------------------------------
INT 48 - KEYBOARD - CORDLESS KEYBOARD TRANSLATION (PCjr)
SeeAlso: INT 49"PCjr"
----------48---------------------------------
INT 48 - Z100 - Slave 8259 - S100 vectored line 0
SeeAlso: INT 49"Z100"
----------49---------------------------------
INT 49 - SYSTEM DATA - NON-KEYBOARD SCAN-CODE TRANSLATION TABLE (PCjr)
SeeAlso: INT 48"PCjr"

Format of translation table:
Offset	Size	Description
 00h	BYTE	number of nonkeyboard scancodes in the table
 01h  N WORDs	high byte 00h (NUL) byte scancode with low order byte
		representing the scancode mapped values relative to their
		input values within the range of 56h through 7Eh
----------49---------------------------------
INT 49 - Z100 - Slave 8259 - S100 vectored line 1
SeeAlso: INT 48"Z100",INT 4A"Z100"
----------49---------------------------------
INT 49 - Texas Instruments PC - VIDEO I/O???
	apparently provides direct video display on the TI Professional PC
----------490001-----------------------------
INT 49 - MAGic v1.16+ - TURN ON MAGNIFICATION
	AX = 0001h
Return: AX = status
	    0000h cannot magnify current video mode
	    0002h magnified (text mode)
	    0003h magnified (graphics mode)
	    FFFDh function works only in magnified mode
	    FFFFh MAGic busy, retry later
	BX,CX,DX destroyed
Notes:	MAGic (MAGnification In Color) is a TSR by Microsystems Software, Inc.
	  providing 2x2 text and graphics magnification on VGA, XGA, and SVGA
	INT 49 is the default, but may be overridden on the commandline.  The
	  actual interrupt in use may be found by searching for the signature
	  "MAGic" immediately preceding the interrupt handler (this is also
	  the installation check).  MAGic uses CodeRunneR, which places the
	  signature "RT" at offset 0000h in the interrupt handler's segment,
	  followed by MAGic's TSR ID of "VMAG".
SeeAlso: AX=0001h,AX=0003h,AX=0004h
----------490002-----------------------------
INT 49 - MAGic v1.16+ - TURN OFF MAGNIFICATION
	AX = 0002h
Return: AX = status (see AX=0001h)
	BX,CX,DX destroyed
SeeAlso: AX=0001h
----------490003-----------------------------
INT 49 - MAGic v1.16+ - SHIFT MAGNIFIED WINDOW TO INCLUDE SPECIFIED LOCATION
	AX = 0003h
	BX = vertical position (character row [text] or pixel row [graphics])
	DX = horizontal position (char column [text] or 8-pixel units [gr])
Return: AX = status
	    0000h successful
	    FFFFh MAGic busy, retry later
	BX,CX,DX destroyed
Note:	window is not moved if the position is inside the current window
SeeAlso: AX=0001h,AX=0004h,AX=0005h
----------490004-----------------------------
INT 49 - MAGic v1.16+ - REPOSITION MAGNIFIED WINDOW
	AX = 0004h
	BX = vertical position of upper left corner
	DX = horizontal position
Return: AX = status (see AX=0003h)
	BX,CX,DX destroyed
SeeAlso: AX=0001h,AX=0003h,AX=0005h
----------490005-----------------------------
INT 49 - MAGic v1.16+ - GET POSITION OF MAGNIFIED WINDOW
	AX = 0005h
Return: AX = status
	    0000h successful
		BX = vertical position (char row or pixel row)
		DX = horizontal position (char column or 8-pixel units)
	    FFFFh MAGic busy, retry later
		BX,DX destroyed
	CX destroyed
SeeAlso: AX=0001h,AX=0003h,AX=0004h,AX=0006h,AX=0007h
----------490006-----------------------------
INT 49 - MAGic v1.16+ - GET SIZE OF FULL SCREEN
	AX = 0006h
Return: AX = status
	    0000h successful
		BX = vertical size (char rows or pixel rows)
		DX = horizontal size (char cols or 8-pixel units)
	    FFFFh MAGic busy, retry later
		BX,DX destroyed
	CX destroyed
SeeAlso: AX=0001h,AX=0005h,AX=0007h
----------490007-----------------------------
INT 49 - MAGic v1.16+ - GET SIZE OF MAGNIFICATION WINDOW
	AX = 0007h
Return: AX = status
	    0000h successful
		BX = vertical size (char rows or pixel rows)
		DX = horizontal size (char cols or 8-pixel units)
	    FFFEh invalid function
	    FFFFh MAGic busy, retry later
		BX,DX destroyed
	CX destroyed
BUG:	in v1.16 and v1.17, this function is not recognized as valid, but
	  AX=0000h is accepted and will branch into hyperspace
SeeAlso: AX=0001h,AX=0006h
----------4A---------------------------------
INT 4A - SYSTEM - USER ALARM HANDLER
   This interrupt is invoked by the BIOS when a real-time clock alarm occurs.
   An application may use it to perform an action at a predetermined time;
   however, this interrupt is called from within a hardware interrupt handler,
   so all usual precautions against reentering DOS must be taken.
SeeAlso: INT 1A/AH=06h
----------4A---------------------------------
INT 4A - Z100 - Slave 8259 - S100 vectored line 2
SeeAlso: INT 49"Z100",INT 4B"Z100"
----------4B---------------------------------
INT 4B - Z100 - Slave 8259 - S100 vectored line 3
SeeAlso: INT 4A"Z100",INT 4C"Z100"
----------4B---------------------------------
INT 4B - Common Access Method SCSI interface (draft revision 1.9)
	ES:DI -> CAM Control Block (see INT 4F/AX=8100h)
Notes:	the CAM committee moved the interface to INT 4F after revision 1.9
	  to avoid conflicting with the IBM SCSI interface and the Virtual
	  DMA specification
	the installation check for the driver is the string "SCSI_CAM" eight
	  bytes past the INT 4Bh handler
	it is not known whether any drivers actually implemented this
	  interface on INT 4B instead of INT 4F
SeeAlso: INT 4F/AX=8100h
----------4B80-------------------------------
INT 4B - IBM SCSI interface
	AH = 80h
	details not yet available
----------4B8102DX0000-----------------------
INT 4B - Virtual DMA Specification (VDS) - GET VERSION
	AX = 8102h
	DX = 0000h
Return: CF clear if successful
	    AH = major version number
	    AL = minor version number
	    BX = product number
		5145h ("QE") for QEMM-386
	    CX = product revision number
	    SI:DI = maximum DMA buffer size
	    DX = flags
		bit 0: PC/XT bus (DMA in first megabyte only)
		    1: physical buffer/remap region in first megabyte
		    2: automatic remap enabled
		    3: all memory is physically contiguous
		 4-15: reserved (zero)
	CF set on error
	    AL = error code (see below)
Note:	bit 5 of 0040h:007Bh is supposed to be set if VDS is supported; this is
	  apparently not always the case
SeeAlso: INT 31

Values for error code:
 01h	region not in contiguous memory
 02h	region crossed a physical alignment boundary
 03h	unable to lock pages
 04h	no buffer available
 05h	region too large for buffer
 06h	buffer currently in use
 07h	invalid memory region
 08h	region was not locked
 09h	number of physical pages greater than table length
 0Ah	invalid buffer ID
 0Bh	copy out of buffer range
 0Ch	invalid DMA channel number
 0Dh	disable count overflow
 0Eh	disable count underflow
 0Fh	function not supported
 10h	reserved flag bits set in DX

Format of DMA descriptor structure (DDS):
Offset	Size	Description
 00h	DWORD	region size
 04h	DWORD	offset
 08h	WORD	segment/selector
 0Ah	WORD	buffer ID
 0Ch	DWORD	physical address

Format of Extended DMA descriptor structure (EDDS):
Offset	Size	Description
 00h	DWORD	region size
 04h	DWORD	offset
 08h	WORD	segment/selector
 0Ah	WORD	reserved
 0Ch	WORD	number available
 0Eh	WORD	number used
 10h	DWORD	region 0 physical address
 14h	DWORD	region 0 size in bytes
 18h	DWORD	region 1 physical address
 1Ch	DWORD	region 1 size in bytes
	...

Format of Extended DMA descriptor structure (EDDS) with page table entries:
Offset	Size	Description
 00h	DWORD	region size
 04h	DWORD	offset
 08h	WORD	segment/selector
 0Ah	WORD	reserved
 0Ch	WORD	number available
 0Eh	WORD	number used
 10h	DWORD	page table entry 0 (same as 80386 page table entry)
 14h	DWORD	page table entry 1
	...
Note:	bits 1-11 of the page table entries should be zero; bit 0 set if page
	  is present and locked
----------4B8103-----------------------------
INT 4B - Virtual DMA Specification - LOCK DMA REGION
	AX = 8103h
	DX = flags
	    bit 0: reserved (zero)
		1: data should be copied into buffer (ignored if bit 2 set)
		2: buffer should not be allocated if region noncontiguous or
		   crosses physical alignment boundary specified by bits 4-5
		3: don't attempt automatic remap
		4: region must not cross 64K physical alignment boundary
		5: region must not cross 128K physical alignment boundary
	     6-15: reserved (zero)
	DS:SI -> DMA descriptor structure (see AX=8102h)
Return:	CF clear if successful
	    DDS physical address field filled in
	    DDS buffer ID field filled (0000h if no buffer allocated)
	CF set on error
	    AL = error code (see AX=8102h)
	    DDS region size field filled wth maximum contiguous length in bytes
SeeAlso: AX=8104h,AX=8105h
----------4B8104-----------------------------
INT 4B - Virtual DMA Specification - UNLOCK DMA REGION
	AX = 8104h
	DX = flags
	    bit 0: reserved (zero)
		1: data should be copied out of buffer
	     2-15: reserved (zero)
	ES:DI -> DMA descriptor structure (see AX=8102h) with region size,
		physical address, and buffer ID fields set
Return: CF clear if successful
	    DDS physical address field set
	    DDS buffer ID field set (0000h if no buffer allocated)
	CF set on error
	    AL = error code (see AX=8102h)
	    DDS region size field filled wth maximum contiguous length in bytes
SeeAlso: AX=8103h,AX=8106h
----------4B8105-----------------------------
INT 4B - Virtual DMA Specification - SCATTER/GATHER LOCK REGION
	AX = 8105h
	DX = flags
	    bits 0-5: reserved (zero)
		   6: EDDS should be returned with page table entries
		   7: only present pages should be locked (not-present pages
			receive entry of 0000h)
		8-15: reserved (zero)
	ES:DI -> Extended DMA descriptor structure (see AX=8102h)
		region size, linear segment, linear offset, and number avail
		fields set
Return: CF clear if successful
	    EDDS number used field set
	    if DX bit 6 set, lower 12 bits of BX = offset in first page
	CF set on error
	    AL = error code (see AX=8102h)
	    EDDS region size field filled with max length in bytes that can be
		locked and described in the EDDS table
SeeAlso: AX=8103h,AX=8106h
----------4B8106-----------------------------
INT 4B - Virtual DMA Specification - SCATTER/GATHER UNLOCK REGION
	AX = 8106h
	DX = flags
	    bits 0-5: reserved (zero)
		   6: EDDS contains page table entries
		   7: EDDS may contain not-present pages (entry = 0000h)
		8-15: reserved (zero)
	ES:DI -> Extended DMA descriptor structure (see AX=8102h) returned
		by AX=8105h	
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=8104h,AX=8105h
----------4B8107-----------------------------
INT 4B - Virtual DMA Specification - REQUEST DMA BUFFER
	AX = 8107h
	DX = flags
	    bit 0: reserved (zero)
		1: data should be copied into buffer
	     2-15: reserved (zero)
	ES:DI -> DMA descriptor structure (see AX=8102h) with region size set
		(also region offset and region segment if DX bit 1 set)
Return: CF clear if successful
	    DDS physical address and buffer ID set
	    DDS region size filled with length of buffer
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=8108h
----------4B8108-----------------------------
INT 4B - Virtual DMA Specification - RELEASE DMA BUFFFER
	AX = 8108h
	DX = flags
	    bit 0: reserved (zero)
		1: data should be copied out of buffer
	     2-15: reserved (zero)
	ES:DI -> DMA descriptor structure (see AX=8102h) with buffer ID set
		(also region size/region offset/segment if DX bit 1 set)
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=8107h
----------4B8109DX0000-----------------------
INT 4B - Virtual DMA Specification - COPY INTO DMA BUFFER
	AX = 8109h
	DX = 0000h
	ES:DI -> DMA descriptor structure (see AX=8102h) with buffer ID,
		region segment/offset, and region size fields set
	BX:CX = starting offset into DMA buffer
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=810Ah
----------4B810ADX0000-----------------------
INT 4B - Virtual DMA Specification - COPY OUT OF DMA BUFFER
	AX = 810Ah
	DX = 0000h
	ES:DI -> DMA descriptor structure (see AX=8102h) with buffer ID,
		region segment/offset, and region size fields set
	BX:CX = starting offset into DMA buffer
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=8109h
----------4B810B-----------------------------
INT 4B - Virtual DMA Specification - DISABLE DMA TRANSLATION
	AX = 810Bh
	BX = DMA channel number
	DX = 0000h
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=810Ch
----------4B810C-----------------------------
INT 4B - Virtual DMA Specification - ENABLE DMA TRANSLATION
	AX = 810Ch
	BX = DMA channel number
	DX = 0000h
Return: CF clear if successful
	    ZF set if disable count decremented to zero
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=810Bh
----------4B810D-----------------------------
INT 4B - QEMM-386 - BUG
	AX = 810Dh
Note:	the code in QEMM v5.11 and 6.00 jumps to an invalid location on this
	  call
----------4C---------------------------------
INT 4C - Z100 - Slave 8259 - S100 vectored line 4
SeeAlso: INT 4B"Z100",INT 4D"Z100"
----------4D---------------------------------
INT 4D - Z100 - Slave 8259 - S100 vectored line 5
SeeAlso: INT 4C"Z100",INT 4E"Z100"
----------4E---------------------------------
INT 4E - TI Professional PC - DISK I/O
	used instead of INT 13 on the TI Professional PC
SeeAlso: INT 13
----------4E---------------------------------
INT 4E - Z100 - Slave 8259 - S100 vectored line 6
SeeAlso: INT 4D"Z100",INT 4F"Z100"
----------4F---------------------------------
INT 4F - Z100 - Slave 8259 - S100 vectored line 7
SeeAlso: INT 4E"Z100"
----------4F8100-----------------------------
INT 4F - Common Access Method SCSI interface rev 2.3 - SEND CCB TO XPT/SIM
	AX = 8100h
	ES:BX -> CAM Control Block (CCB) (see below)
Return: AH = status
	    00h successful
	    01h invalid CCB address (0000h:0000h)
Note:	the SCSI Interface Module (SIM) may complete the requested function
	  and invoke the completion callback function before this call returns
SeeAlso: AX=8200h,INT 4B"Common Access Method"

Format of CAM Control Block:
Offset	Size	Description
 00h	DWORD	physical address of this CCB
 04h	WORD	CAM control block length
 06h	BYTE	function code (see below)
 07h	BYTE	CAM status (see below)
 08h	BYTE	SCSI status
 09h	BYTE	path ID (FFh = XPT)
 0Ah	BYTE	target ID
 0Bh	BYTE	logical unit number
 0Ch	BYTE	CAM flags
		bits 7-6: direction
			00 reserved
			01 in
			10 out
			11 no data transfer
		bit 5: disable autosense
		    4: scatter/gather
		    3: disable callback on completion
		    2: linked CDB
		    1: tagged queue action enable
		    0: CDB is a pointer
 0Dh	BYTE	CAM flags
		bit 7: disable disconnect
		    6: initiate synchronous transfers  \ mutually
		    5: disable synchronous transfers   / exclusive
		    4: SIM queue priority
			1 head insertion
			0 tail insertion (normal)
		bit 3: SIM queue freeze
		    2: engine synchronize
		bits 1-0: reserved
 0Eh	BYTE	CAM address flags
		bit 7: SG list/data (0 = host, 1 = engine)
		bit 6: CDB pointer    (bits 6-1: 0=virtual addr, 1=phys addr)
		bit 5: SG list/data
		bit 4: sense buffer
		bit 3: message buffer
		bit 2: next CCB
		bit 1: callback on completion
		bit 0: reserved
 0Fh	BYTE	target-mode flags
		bit 7: data buffer valid
		bit 6: status valid
		bit 5: message buffer valid
		bit 4: reserved
		bit 3: phase-cognizant mode
		bit 2: target CCB available
		bit 1: disable autodisconnect
		bit 0: disable autosave/restore
---function 02h---
 10h	DWORD	pointer to 36-byte buffer for inquiry data or 0000h:0000h
 14h	BYTE	peripheral device type of target logical unit number
---function 03h---
 10h	BYTE	version number (00h-07h prior to rev 1.7, 08h = rev 1.7,
		09h-FFh = rev no, i.e. 23h = rev 2.3)
 11h	BYTE	SCSI capabilities
		bit 7: modify data pointers
		    6: wide bus (32 bits)
		    5: wide bus (16 bits)
		    4: synchronous transfers
		    3: linked commands
		    2: reserved
		    1: tagged queueing
		    0: soft reset
 12h	BYTE	target mode support
		bit 7: processor mode
		    6: phase-cognizant mode
		    5-0: reserved
 13h	BYTE	miscellaneous flags
		bit 7: scanned high to low instead of low to high
		    6: removables not included in scan
		    5: inquiry data not kept by XPT
		    4-0: reserved
 14h	WORD	engine count
 16h 14 BYTEs	vendor-specific data
 24h	DWORD	size of private data area
 28h	DWORD	asynchronous event capabilities
		bits 31-24: vendor-specific
		     23-8: reserved
			7: new devices found during rescan
			6: SIM module deregistered
			5: SIM module registered
			4: sent bus device reset to target
			3: SCSI AEN
			2: reserved
			1: unsolicited reselection
			0: unsolicited SCSI bus reset
 2Ch	BYTE	highest path ID assigned
 2Dh	BYTE	SCSI device ID of initiator
 2Eh  2 BYTEs	reserved
 30h 16 BYTEs	SIM vendor ID
 40h 16 BYTEs	HBA (host bus adaptor) vendor ID
 50h  4 BYTEs	operating-system dependant usage
---functions 00h,04h,11h,12h---
 no additional fields
---function 05h---
 10h	DWORD	asynchronous event enables (see CAM function 03h above)
 14h	DWORD	pointer to asynchronous callback routine
 18h	DWORD	pointer to peripheral driver buffer
 1Ch	BYTE	size of peripheral buffer
---function 06h---
 10h	BYTE	peripheral device type of target
---functions 10h,13h---
 10h	DWORD	pointer to CCB to be aborted
---function 20h---
 10h	WORD	engine number
 12h	BYTE	engine type
		00h buffer memory
		01h lossless compression
		02h lossy compression
		03h encryption
 13h	BYTE	engine algorithm ID
		00h vendor-unique
		01h LZ1 variation 1 (STAC)
		02h LZ2 variation 1 (HP DCZL)
		03h LZ2 variation 2 (Infochip)
 14h	DWORD	engine memory size
---function 21h---
 10h	DWORD	pointer to peripheral driver
 14h  4 BYTEs	reserved
 18h	DWORD	OS-dependent request-mapping info
 1Ch	DWORD	address of completion callback routine
 20h	DWORD	pointer to scatter/gather list or data buffer
 24h	DWORD	length of data transfer
 28h	DWORD	pointer to engine buffer data
 2Ch  2 BYTEs	reserved
 2Eh	WORD	number of scatter/gather entries
 30h	DWORD	maximum destination data length
 34h	DWORD	length of destination data
 38h	DWORD	source residual length
 3Ch 12 BYTEs	reserved
 48h	DWORD	OS-dependent timeout value
 4Ch  4 BYTEs	reserved
 50h	WORD	engine number
 52h	WORD	vendor-unique flags
 54h  4 BYTEs	reserved
 58h  N BYTEs	private data area for SIM
---function 30h---
 10h	WORD	group 6 vendor-unique CDB length
 12h	WORD	group 7 vendor-unique CDB length
 14h	DWORD	pointer to target CCB list
 18h	WORD	number of target CCBs
---other functions---
 10h	DWORD	pointer to peripheral driver
 14h	DWORD	pointer to next CCB
 18h	DWORD	OS-dependent request mapping information
 1Ch	DWORD	address of completion callback routine
 20h	DWORD	pointer to scatter/gather list or data buffer
 24h	DWORD	length of data transfer
 28h	DWORD	pointer to sense info buffer
 2Ch	BYTE	length of sense info buffer
 2Dh	BYTE	CDB length
 2Eh	WORD	number of scatter/gather entries
 30h  4 BYTEs	reserved
 34h	BYTE	SCSI status
 35h  3 BYTEs	reserved
 38h	DWORD	residual length
 40h 12 BYTEs	Command Descriptor Block (CDB)
 44h	DWORD	OS-dependent timeout value
 48h	DWORD	pointer to message buffer
 4Ch	WORD	length of message buffer
 4Eh	WORD	vendor-unique flags
 50h	BYTE	tag queue action
 51h  3 BYTEs	reserved
 54h  N BYTEs	private data area for SIM

Values for CAM function code:
 00h NOP
 01h execute SCSI I/O
 02h get device type
 03h path inquiry
 04h release SIM queue
 05h set async callback
 06h set device type
 07h-0Fh reserved
 10h abort SCSI command
 11h reset SCSI bus
 12h reset SCSI device
 13h terminate I/O process
 14h-1Fh reserved
 20h engine inquiry
 21h execute engine request
 22h-2Fh reserved
 30h enable logical unit number
 31h execute target I/O
 32h-7Fh reserved
 80h-FFh vendor-specific functions

Values for CAM status:
 00h request in progress
 01h request successful
 02h host aborted request
 03h unable to abort request
 04h request completed with error
 05h CAM is busy
 06h invalid request
 07h invalid path ID
 08h no such SCSI device
 09h unable to terminate I/O process
 0Ah timeout on target selection
 0Bh timeout on command
 0Dh receive message rejection
 0Eh sent/received SCSI bus reset
 0Fh detected uncorrectable parity error
 10h Autosense request failed
 11h no HBA detected
 12h data over/underrun
 13h bus freed unexpectedly
 14h target bus phase sequence failure
 15h CCB too small
 16h requested capability not available
 17h sent bus device reset
 18h terminate I/O process
 38h invalid LUN
 39h invalid target ID
 3Ah unimplemented function
 3Bh nexus not established
 3Ch invalid initiator ID
 3Dh received SCSI Command Descriptor Block
 3Eh LUN already enabled
 3Fh SCSI bus busy
Note:	bit 6 set to indicate frozen SIM queue
	bit 7 set to indicate valid autosense

Completion callback function called with:
	interrupts disabled
	ES:BX -> completed CCB

Asynchronous callback function called with:
	AH = opcode
	AL = path ID generating callback
	DH = target ID causing event
	DL = LUN causing event
	CX = data byte count (if applicable)
	ES:BX -> data buffer (if applicable)
Return: all registers preserved
----------4F8200CX8765-----------------------
INT 4F - Common Access Method SCSI interface rev 2.3 - INSTALLATION CHECK
	AX = 8200h
	CX = 8765h
	DX = CBA9h
Return: AH = 00h if installed
	    CX = 9ABCh
	    DX = 5678h
	    ES:DI -> "SCSI_CAM"
SeeAlso: AX=8100h,INT 4B"Common Access Method"
----------50---------------------------------
INT 50 - TIL Xpert AIM (X.25)
	AH = function
----------50---------------------------------
INT 50 - through 57 - IRQ0-IRQ7 relocated by DESQview
Notes:	this is the default location; DV 2.26+ searches for unused ranges of
	  interrupts and uses the lowest available range in its list for
	  relocating these IRQs and the next lowest for relocating IRQ8-IRQ15
	a range of eight interrupts starting at a multiple of 8 is considered
	  available if all vectors are identical and it has not been excluded
	  with an /XB:nn commandline switch
	the list of ranges for v2.26 is 50h,58h,68h,78h,F8h (if < two of these
	  are available, F8h and then 50h are used anyway)
	the list of ranges for v2.31+ is 68h,78h,88h-B8h,F8h (if < two of these
	  are available, F8h and then F0h are used anyway)
SeeAlso: INT 58"DESQview"
----------50---------------------------------
INT 50 - through 57 - IRQ0-IRQ7 relocated by IBM 3278 emulation control program
----------50---------------------------------
INT 50 - through 57 - IRQ0-IRQ7 relocated by OS/2 v1.x
----------58---------------------------------
INT 58 - IRQ8 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 70
----------58---------------------------------
INT 58 - IRQ0 relocated by DoubleDOS
SeeAlso: INT 08
----------59---------------------------------
INT 59 - IRQ9 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 71
----------59---------------------------------
INT 59 - IRQ1 relocated by DoubleDOS
SeeAlso: INT 09
----------59---------------------------------
INT 59 - GSS Computer Graphics Interface (GSS*CGI)
	DS:DX -> block of 5 array pointers
Return:	CF set on error
	    AX = error code
	CF clear if successful
	    AX = return code
Note:	INT 59 is the means by which GSS*CGI language bindings communicate with
	  GSS*CGI device drivers and the GSS*CGI device driver controller.
	also used by the IBM Graphic Development Toolkit
----------5A---------------------------------
INT 5A - IRQ10 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 72
----------5A---------------------------------
INT 5A - IRQ2 relocated by DoubleDOS
SeeAlso: INT 0A
----------5A---------------------------------
INT 5A - Cluster adapter BIOS entry address
	???
----------5B---------------------------------
INT 5B - IRQ11 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT50"DESQview",INT 73
----------5B---------------------------------
INT 5B - IRQ3 relocated by DoubleDOS
SeeAlso: INT 0B
----------5B---------------------------------
INT 5B - Used by cluster adapter
----------5B---------------------------------
INT 5B - AT&T Starlan Extended NetBIOS (variable length names)
	ES:BX -> Network Control Block (see below)
Return: AL = status (see INT 5C)
SeeAlso: INT 5C

Format of Network Control Block
Offset	Size	Description
 00h	BYTE	ncb_command (see below)
 01h	BYTE	ncb_retcode
 02h	BYTE	ncb_lsn
 03h	BYTE	ncb_num
 04h	DWORD	-> ncb_buffer
 08h	WORD	ncb_length
 0Ah 16 BYTEs	ncb_callname
 1Ah 16 BYTEs	ncb_name
 2Ah	BYTE	ncb_rto
 2Bh	BYTE	ncb_sto
 2Ch	DWORD	-> ncb_post	/* int (far *ncb_post)(); */
 30h	BYTE	ncb_lana_num
 31h	BYTE	ncb_cmd_cplt
 32h	DWORD	-> ncb_vname
 36h	BYTE	ncb_vnamelen
 37h  9 BYTEs	ncb_reserve
Note: fields 00h-31h are the same as for a standard NetBIOS NCB (see INT 5C)

Values for ncb_command field same as for INT 5C, except
	70h	send net Break
----------5B---------------------------------
INT 5B - Microsoft Network Transport Layer Interface
Note:	used by MS-NET for executing network commands
SeeAlso: INT 5C"NetBIOS"
----------5B---------------------------------
INT 5B - used by Alloy NTNX
----------5C---------------------------------
INT 5C - IRQ12 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 74
----------5C---------------------------------
INT 5C - IRQ4 relocated by DoubleDOS
SeeAlso: INT 0C
----------5C---------------------------------
INT 5C - NetBIOS INTERFACE
	ES:BX -> network control block (NCB) (see below)
Return: AL = status
	    00h successful
	    01h bad buffer size
	    03h invalid NETBIOS command
	    05h timeout
	    06h receive buffer too small
	    07h No-ACK command failed
	    08h bad session number
	    09h LAN card out of memory
	    0Ah session closed
	    0Bh command has been cancelled
	    0Dh name already exists
	    0Eh local name table full
	    0Fh name still in use, can't delete
	    11h local session table full
	    12h remote PC not listening
	    13h bad NCB_NUM field
	    14h no answer to CALL or no such remote
	    15h name not in local name table
	    16h duplicate name
	    17h bad delete
	    18h abnormal end
	    19h name error, multiple identical names in use
	    1Ah bad packet
	    21h network card busy
	    22h too many commands queued
	    23h bad LAN card number
	    24h command finished while cancelling
	    26h command can't be cancelled
	    30h name defined by another process (OS/2)
	    34h NetBIOS environment not defined, must issue reset (OS/2)
	    35h required operating system resources exhausted (OS/2)
	    36h maximum applications exceeded (OS/2)
	    37h no SAPs available for NetBIOS (OS/2)
	    38h requested resources not available (OS/2)
	    40h Lana System Error
	    41h Lana Remote Hot Carrier
	    42h Lana Local Hot Carrier
	    43h Lana No Carrier Detected
	    44h unusual network condition
	    45h-4Fh hardware error
	    50h adapter malfunction
	    FFh NetBIOS busy (command pending)
Note:	Sytek PCnet card uses DMA 3.
SeeAlso: INT 2A/AH=01h,INT 2A/AH=04h,INT 5B

Format of Network Control Block:
Offset	Size	Description
 00h	BYTE	command code (see below)
 01h	BYTE	return code
 02h	BYTE	local session number (LSN)
 03h	BYTE	"ncb_num" datagram table entry from ADD NAME
 04h	DWORD	-> I/O buffer
 08h	WORD	length of data in buffer
 0Ah 16 BYTEs	remote system to call
 1Ah 16 BYTEs	network name of local machine
 2Ah	BYTE	receive timeout in 1/2 seconds
 2Bh	BYTE	send timeout in 1/2 seconds
 2Ch	DWORD	-> FAR post handler	/* int (far *ncb_post)(); */
 30h	BYTE	network adapter number on which to execute command
		00h-03h IBM NetBIOS specs
		F0h-FFh Eicon NABios interface
 31h	BYTE	command completion code (see returned status above)
 32h 14 BYTEs	reserved for network card

Values for command code field in NCB (or with 80h for non-waiting call):
	10h start session with NCB_NAME name (call)
	11h listen for call
	12h end session with NCB_NAME name (hangup)
	14h send data via NCB_LSN
	15h receive data from a session
	16h receive data from any session
	17h send multiple data buffers
	20h send unACKed message (datagram)
	21h receive datagram
	22h send broadcast datagram
	23h receive broadcast datagram
	30h add name to name table
	31h delete name from name table
	32h reset adapter card and tables
	33h get adapter status (see structure "astatus" below)
	34h status of all sessions for name (see structure "sstatus" below)
	35h cancel
	36h add group name to name table
	70h unlink from IBM remote program (no F0h function)
	71h send data without ACK
	72h send multiple buffers without ACK
	78h find name
	79h token-ring protocol trace

Format of structure "name":
Offset	Size	Description
 00h 16 BYTEs "nm_name" symbolic name
 10h	BYTE  "nm_num" number associated with name
 11h	BYTE  nm_status

Format of structure "astatus":
Offset	Size	Description
 00h  6 BYTEs as_id
 06h	BYTE  as_jumpers
 07h	BYTE  as_post
 08h	BYTE  as_major
 09h	BYTE  as_minor
 0Ah	WORD  as_interval
 0Ch	WORD  as_crcerr
 0Eh	WORD  as_algerr
 10h	WORD  as_colerr
 12h	WORD  as_abterr
 14h	DWORD as_tcount
 18h	DWORD as_rcount
 1Ch	WORD  as_retran
 1Eh	WORD  as_xresrc
 20h  8 BYTEs as_res0
 28h	WORD  as_ncbfree
 2Ah	WORD  as_ncbmax
 2Ch	WORD  as_ncbx
 2Eh  4 BYTEs as_res1
 32h	WORD  as_sespend
 34h	WORD  as_msp
 36h	WORD  as_sesmax
 38h	WORD  as_bufsize
 3Ah	WORD  as_names
 3Ch 16 name structures	 as_name

Format of structure "sstatus":
Offset	Size	Description
 00h	BYTE	number of sessions being reported
 01h	BYTE	number of sessions with this name
 02h	BYTE	number of outstanding receive datagrams
 03h	BYTE	number of outstanding ReceiveAnys
 04h	var	session structures (see below)

Format of structure "session":
Offset	Size	Description
 00h	BYTE	local session number
 01h	BYTE	state
		01h listen pending
		02h call pending
		03h session established
		04h hangup pending
		05h hangup done
		06h session aborted
 02h 16 BYTEs	local name
 12h 16 BYTEs	remote name
 22h	BYTE	number of outstanding receives
 23h	BYTE	number of outstanding sends/chainsends
----------5C---------------------------------
INT 5C - TOPS INTERFACE
	ES:BX -> Network Control Block
Note:	TOPS card uses DMA 1, 3 or none.
----------5C---------------------------------
INT 5C - ATALK.SYS - AppleTalk INTERFACE
	DX:BX -> control block (see below)
Return: none
Notes:	this driver can use any interrupt from 5Ch to 70h
	the signature 'AppleTalk' appears 16 bytes prior to the interrupt
	  handler; this serves as the installation check

Format of AppleTalk control block:
Offset	Size	Description
 00h	WORD	command code
		01h "AT_INIT"	    initialize the driver
		02h "AT_KILL"
		03h "AT_GETNETINFO" get current network info incl init status
		04h "AT_GETCLOCKTICKS"
		05h "AT_STARTTIMER"
		06h "AT_RESETTIMER"
		07h "AT_CANCELTIMER"
		10h "LAP_INSTALL"
		11h "LAP_REMOVE"
		12h "LAP_WRITE"
		13h "LAP_READ"
		14h "LAP_CANCEL"
		20h "DDP_OPENSOCKET"
		21h "DDP_CLOSESOCKET"
		22h "DDP_WRITE"
		23h "DDP_READ"
		24h "DDP_CANCEL"
		30h "NBP_REGISTER"
		31h "NBP_REMOVE"
		32h "NBP_LOOKUP"
		33h "NBP_CONFIRM"
		34h "NBP_CANCEL"
		35h "ZIP_GETZONELIST"
		36h "ZIP_GETMYZONE"
		37h "ZIP_TAKEDOWN"
		38h "ZIP_BRINGUP"
		40h "ATP_OPENSOCKET"
		41h "ATP_CLOSESOCKET"
		42h "ATP_SENDREQUEST"
		43h "ATP_GETREQUEST"
		44h "ATP_SENDRESPONSE"
		45h "ATP_ADDRESPONSE"
		46h "ATP_CANCELTRANS"
		47h "ATP_CANCELRESPONSE"
		48h "ATP_CANCELREQUEST"
		50h "ASP_GETPARMS"
		51h "ASP_CLOSESESSION"
		52h "ASP_CANCEL"
		53h "ASP_INIT"
		54h "ASP_KILL"
		55h "ASP_GETSESSION"
		56h "ASP_GETREQUEST"
		57h "ASP_CMDREPLY"
		58h "ASP_WRTCONTINUE"
		59h "ASP_WRTREPLY"
		5Ah "ASP_CLOSEREPLY"
		5Bh "ASP_NEWSTATUS"
		5Ch "ASP_ATTENTION"
		5Dh "ASP_GETSTATUS"
		5Eh "ASP_OPENSESSION"
		5Fh "ASP_COMMAND"
		60h "ASP_WRITE"
		61h "ASP_GETATTENTION"
		70h "PAP_OPEN"
		71h "PAP_CLOSE"
		72h "PAP_READ"
		73h "PAP_WRITE"
		74h "PAP_STATUS"
		75h "PAP_REGNAME"
		76h "PAP_REMNAME"
		77h "PAP_INIT"
		78h "PAP_NEWSTATUS"
		79h "PAP_GETNEXTJOB"
		7Ah "PAP_KILL"
		7Bh "PAP_CANCEL"
		
		or with the following flags
		8000h start command then return
		4000h wait for interrupt service to complete
 02h	WORD	returned status
		0000h success (already initialized if func 01h)
 04h	DWORD	pointer to completion function
 08h	WORD	network number
 0Ah	BYTE	node ID
---if general func (01h,03h), control block continues:
 0Bh	BYTE	"inf_abridge"
 0Ch	WORD	"inf_config"
 0Eh	DWORD	pointer to buffer
 12h	WORD	buffer size
---if DDP function (20h-24h), control block continues:
 0Bh	BYTE	"ddp_addr_socket"
 0Ch	BYTE	"ddp_socket"
 0Dh	BYTE	"ddp_type"
 0Eh	DWORD	pointer to buffer
 12h	WORD	buffer size
 14h	BYTE	"ddp_chksum"
---if Name Binding Protocol (30h-34h), control block continues:
 0Bh	BYTE	"nbp_addr_socket"
 0Ch	WORD	"nbp_toget"
 0Eh	DWORD	pointer to buffer
 12h	WORD	buffer size
 14h	BYTE	"nbp_interval"
 15h	BYTE	"nbp_retry"
 16h	DWORD	"nbp_entptr"
---if AppleTalk Transaction Protocol (42h), control block continues:
 0Bh	BYTE	"atp_addr_socket"
 0Ch	WORD	"atp_socket"
 0Eh	DWORD	pointer to buffer
 12h	WORD	buffer size
 14h	BYTE	"atp_interval"
 15h	BYTE	"atp_retry"
 16h	BYTE	ATP flags
		bit 5: exactly one transaction
 17h	BYTE	"atp_seqbit"
 18h	BYTE	transaction ID
 19h  4 BYTEs	ATP user bytes
 1Dh	BYTE	number of BDS buffers
 1Eh	BYTE	number of BDS responses
 1Fh	DWORD	pointer to BDS buffers (see below)

Format of Name Binding Protocol Name-to-Address binding entries for NBP_LOOKUP:
Offset	Size	Description
 00h	WORD	"tup_address_network"
 02h	BYTE	"tup_address_notid"
 03h	BYTE	"tup_address_socket"
 04h	BYTE	"tup_enum"
 05h 99 BYTEs	name

Format of BDS entries:
Offset	Size	Description
 00h	DWORD	pointer to buffer
 04h	WORD	size of buffer
 06h	WORD	BDS data size
 08h  4 BYTEs	"bds_userbytes"
----------5C---------------------------------
INT 5C - IBM 802.2 INTERFACE (LLC)
	ES:BX -> CCB
Return: none

Format of CCB:
Offset	Size	Description
 00h	BYTE	adapter
 01h	BYTE	command code
 02h	BYTE	return code
 03h	BYTE	work
 04h	DWORD	pointer to ???
 08h	DWORD	pointer to completion function???
 0Ch	DWORD	pointer to parameters???
----------5C---------------------------------
INT 5C - $25 LAN - INSTALLATION CHECK
Notes:	current versions only check whether the vector is 0000h:0000h or not
	future versions are supposed to have the signature "NET" in the three
	  bytes preceding the INT 5C handler
----------5C04-------------------------------
INT 5C - $25 LAN - CHECK IF CONNECTION ALIVE
	AH = 04h
	AL = COM port (0 = default)
	CX = wait count in character times (should be at least 100)
Return: ZF set if link alive
----------5D---------------------------------
INT 5D - IRQ13 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 75
----------5D---------------------------------
INT 5D - IRQ5 relocated by DoubleDOS
SeeAlso: INT 0D,INT 5C"DoubleDOS"
----------5E---------------------------------
INT 5E - IRQ14 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 76
----------5E---------------------------------
INT 5E - IRQ6 relocated by DoubleDOS
SeeAlso: INT 0E,INT 5D"DoubleDOS"
----------5F---------------------------------
INT 5F - IRQ15 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 77
----------5F---------------------------------
INT 5F - IRQ7 relocated by DoubleDOS
SeeAlso: INT 0F,INT 5E"DoubleDOS"
----------5F00-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - SET VIDEO MODE
	AH = 00h
	AL = video mode
	    07h text, system manager compliant
	    20h 240x128 mono graphics, system manager compliant
	    87h text, not system manager compliant
	    A0h 240x128 mono graphics, not system manager compliant
Note:	the defaults after setting the mode to graphics are (0,0) logical
	  origin, full-screen clip region, (0,0) pen location, pen color 1,
	  pixel replacement FORCE, line type and fill mask all bits set
SeeAlso: INT 10/AH=00h
----------5F01-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - SET FILL MASK
	AH = 01h
	ES:DI -> 8-byte fill mask
Note:	the fill mask represents an 8x8 pixel box and is repeated as necessary
	  when drawing filled rectangles; it is always aligned with the byte
	  boundaries of video memory, regardless of the actual boundaries of
	  the rectangle
SeeAlso: AH=02h
----------5F02-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - GET CURRENT GRAPHICS INFORMATION
	AH = 02h
	ES:DI -> graphics info record (see below)
Return: DX:AX -> filled graphics info record (for return to high-level langs)
Format of graphics info record:
Offset	Size	Description
 00h	BYTE	current video mode
 01h	BYTE	default video mode
 02h	WORD	display width in pixels
 04h	WORD	display height in pixels
 06h	WORD	current pen column
 08h	WORD	current pen row
 0Ah	WORD	current line type
 0Ch	WORD	current replacement rule
 0Eh	WORD	current pen color
 10h	WORD	current leftmost column of clip region
 12h	WORD	current rightmost column of clip region
 14h	WORD	current topmost row of clip region
 16h	WORD	current bottommost row of clip region
 18h	WORD	current column of logical origin
 1Ah	WORD	current row of logical origin
 1Ch  8 BYTEs	current fill mask
----------5F03-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - SET LOGICAL ORIGIN
	AH = 03h
	CX = column
	DX = row
SeeAlso: AH=04h
----------5F04-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - SET CLIP REGION
	AH = 04h
	CX = left-most column
	DX = top-most row
	SI = right-most column
	DI = bottom-most row
SeeAlso: AH=03h
----------5F05-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - DRAW RECTANGLE
	AH = 05h
	AL = fill type
	    00h outline, using current line type and color
	    01h solid, using current color
	    02h pattern, using current fill mask and color
	DX,CX = row,column of other corner of rectangle
Note:	the rectangle is drawn starting at the current pen position
SeeAlso: AH=01h,AH=06h,AH=07h
----------5F06-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - DRAW LINE
	AH = 06h
	DX,CX = row,column of end point
Note:	the line is drawn starting at the current pen position
SeeAlso: AH=05h,AH=07h
----------5F07-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - PLOT POINT
	AH = 07h
	DX,CX = row,column of point
Note:	also sets pen position to the specified point
SeeAlso: AH=06h,AH=08h,AH=0Ch
----------5F08-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - MOVE PEN
	AH = 08h
	DX,CX = row,column of new pen position
SeeAlso: AH=07h,AH=09h
----------5F09-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - SET PEN COLOR
	AH = 09h
	AL = new color (00h = white, 01h = black)
SeeAlso: AH=08h,AH=0Ah,AH=0Bh
----------5F0A-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - SET REPLACEMENT RULE
	AH = 0Ah
	AL = new replacement rule
	    00h force
	    01h AND
	    02h OR
	    03h XOR
SeeAlso: AH=01h,AH=09h,AH=0Bh
----------5F0B-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - SET LINE TYPE
	AH = 0Bh
	CX = new line type
Note:	the line type specifies 16 bits which are repeated over and over while
	  drawing the pixels of a line
SeeAlso: AH=09h,AH=0Ah
----------5F0C-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - GET PIXEL
	AH = 0Ch
	DX,CX = row,column of pixel to read
Return: AX = pixel color
SeeAlso: AH=07h
----------5F0D-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - GET IMAGE
	AH = 0Dh
	DX,CX = row,column of first corner
	BP,SI = row,column of second corner
	ES:DI -> image buffer (see below)
Note:	the specified corners are included in the saved image
SeeAlso: AH=0Eh

Format of image buffer:
Offset	Size	Description
 00h	WORD	number of planes (always 01h on HP 95LX)
 02h	WORD	number of bits/pixel (always 01h on HP 95LX)
 04h	WORD	image width in pixels
 06h	WORD	image height in pixels
 08h  N BYTEs	image data
		requires (WIDTH+7)/8 * HEIGHT bytes
----------5F0E-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - PUT IMAGE
	AH = 0Eh
	AL = replacement rule
	    bit 2: invert image before applying rule
	    bits 1-0:  00 force
		       01 AND
		       10 OR
		       11 XOR
	DX,CX = row,column of top left corner
	ES:DI -> image buffer (see AH=0Dh)
Note:	if the specified image does not fit completely on the screen, this call
	  does nothing
SeeAlso: AH=0Dh
----------5F0F-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - WRITE TEXT
	AH = 0Fh
	AL = rotate flag (if nonzero, rotate 90 degrees counter-clockwise)
	DX,CX = row,column of first character's top left corner
	ES:DI -> ASCIZ text
