Interrupt List, part 6 of 7
This compilation is Copyright (c) 1989,1990,1991,1992 Ralf Brown
----------40---------------------------------
INT 40 - DISKETTE - ROM BIOS DISKETTE HANDLER RELOCATED BY HARD DISK BIOS
SeeAlso: INT 13,INT 63
----------40---------------------------------
INT 40 - Z100 - Master 8259 - Parity error or S100 error
SeeAlso: INT 41"Z100",INT FF"Z100"
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
SeeAlso: INT 40"Z100",INT 42"Z100"
----------4112-------------------------------
INT 41 P - MS Windows debugging kernel - "OutputDebugString"
	AH = 12h
	???
Return: ???
SeeAlso: AH=50h
----------4150-------------------------------
INT 41 P - MS Windows debugging kernel - "DefineDebugSegment"
	AH = 50h
	???
Return: ???
SeeAlso: AH=12h
----------42---------------------------------
INT 42 - VIDEO - RELOCATED DEFAULT INT 10 VIDEO SERVICES (EGA,VGA)
SeeAlso: INT 10
Note:	not used by PS/2 built-in VGA or XGA
----------42---------------------------------
INT 42 - Z100 - Master 8259 - Timer
SeeAlso: INT 41"Z100",INT 43"Z100"
----------43---------------------------------
INT 43 - VIDEO DATA - CHARACTER TABLE (EGA,MCGA,VGA)
   points at graphics data for characters 00h-7Fh of the current font
SeeAlso: INT 1F,INT 44"VIDEO"
----------43---------------------------------
INT 43 - Z100 - Master 8259 - Slave 8259 input
Note:	slave runs in special fully nested mode
SeeAlso: INT 42"Z100",INT 44"Z100"
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
SeeAlso: INT 43"Z100",INT 45"Z100"
----------45---------------------------------
INT 45 - Z100 - Master 8259 - Serial B
SeeAlso: INT 44"Z100",INT 46"Z100"
----------46---------------------------------
INT 46 - SYSTEM DATA - HARD DISK 1 DRIVE PARAMETER TABLE
SeeAlso: INT 13/AH=09h,INT 41
----------46---------------------------------
INT 46 - Z100 - Master 8259 - Keyboard, Retrace, and Light Pen
SeeAlso: INT 45"Z100",INT 47"Z100"
----------47---------------------------------
INT 47 - Z100 - Master 8259 - Printer
SeeAlso: INT 46"Z100",INT 48"Z100"
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
SeeAlso: INT 47"Z100",INT 49"Z100"
----------48---------------------------------
INT 48 - Watstar PC Network data pointer 1
SeeAlso: INT 49"Watstar"
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
----------49---------------------------------
INT 49 - Watstar PC Network data pointer 2
SeeAlso: INT 49"Watstar"
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
	  "MAGic" or "xMAGic" (for the deluxe version) immediately preceding
	  the interrupt handler (this is also the installation check).	MAGic
	  uses CodeRunneR, which places the signature "RT" at offset 0000h in
	  the interrupt handler's segment, followed by MAGic's TSR ID of
	  "VMAG".
SeeAlso: AX=0001h,AX=0003h,AX=0004h,AX=0008h
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
----------490008-----------------------------
INT 49 - MAGic v1.23+ - SET TEXT MODE MAGNIFICATION SIZE
	AX = 0008h
	BX = scaling factor (01h=1.4 times, 02h, 04h, 06h, 08h, 09h=12 times)
Return: AX = status
	    0000h successful
	    FFFBh scaling factor only available in MAGic Deluxe
	    FFFCh already in magnified state, can't set size
Notes:	this call specifies the amount a subsequent call to AX=0001h should
	  magnify the display
	scaling factors greater than 2 are only available in MAGic Deluxe
SeeAlso: AX=0001h
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
	        0000h for Quadtel's QMAPS and Hewlett-Packard's HPMM.SYS
	        0001h for Microsoft's EMM386.EXE
		4560h ("E`") for Qualitas' 386MAX
	        4D43h ("MC") for V Communication's Memory Commander
		5145h ("QE") for Quarterdeck's QEMM-386
	    CX = product revision number
	        always 0000h for QMAPS and HPMM.SYS
	        always 0001h for Microsoft's EMM386.EXE v4.20-4.41
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
	ES:DI -> DMA descriptor structure (see AX=8102h)
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
INT 50 - IRQ0 relocated by DESQview
Notes:	this is the default location for older versions; DESQview v2.26+
	  searches for unused ranges of interrupts and uses the lowest
	  available range in its list for relocating these IRQs and the next
	  lowest for relocating IRQ8-IRQ15
	a range of eight interrupts starting at a multiple of 8 is considered
	  available if all vectors are identical and it has not been excluded
	  with an /XB:nn commandline switch
	the list of ranges for v2.26 is 50h,58h,68h,78h,F8h (if < two of these
	  are available, F8h and then 50h are used anyway)
	the list of ranges for v2.31+ is 68h,78h,88h-B8h,F8h (if < two of these
	  are available, F8h and then F0h are used anyway)
SeeAlso: INT 08"IRQ0",INT 51"DESQview",INT 54"DESQview",INT 58"DESQview"
----------50---------------------------------
INT 50 - IRQ0 relocated by IBM 3278 emulation control program
SeeAlso: INT 51"IBM 3278"
----------50---------------------------------
INT 50 - IRQ0 relocated by OS/2 v1.x
SeeAlso: INT 51"OS/2"
----------500000-----------------------------
INT 50 - Vanderaart TEXT WINDOWS - OPEN TEXT WINDOW
	AX = 0000h
	ES:BX -> name string or ES:0000h if none
	CH,CL = row,column of upper left corner
	DH,DL = row,column of lower right corner
Return: AX = window handle or
	    0000h if not installed
	    FFFFh on error
SeeAlso: AX=0001h,AX=0002h
----------500001-----------------------------
INT 50 - Vanderaart TEXT WINDOWS - CLOSE TEXT WINDOW
	AX = 0001h
	DI = window handle
SeeAlso: AX=0000h
----------500002-----------------------------
INT 50 - Vanderaart TEXT WINDOWS - PUT CHARACTER IN WINDOW
	AX = 0002h
	BL = character
	BH = attribute
	DL = column
	DH = row
	DI = window handle
Return: AX = status
	    0000h if successful
	    FFFFh if outside window
SeeAlso: AX=0000h
----------500003-----------------------------
INT 50 - Vanderaart TEXT WINDOWS - OUTPUT LINE TO WINDOW
	AX = 0003h
	ES:BX -> text string
	CX = string length (0000h if ASCIZ string)
	DL = position (FFh centered, else flush left)
	DH = starting row
	DI = window handle
Return: AX = status
	    0000h successful
	    FFFFh did not fit in window
----------500004-----------------------------
INT 50 - Vanderaart TEXT WINDOWS - GET KEY
	AX = 0004h
	CH = type
	    00h any key
	    01h 'J' or 'N' (Dutch for yes/no)
Return: AX = key
----------500005-----------------------------
INT 50 - Vanderaart TEXT WINDOWS - CHANGE ATTRIBUTE
	AX = 0005h
	BL = new attribute
	CH,CL = row,column of upper left corner
	DH,DL = row,column of lower right corner
	DI = window handle
----------500006-----------------------------
INT 50 - Vanderaart TEXT WINDOWS - EDIT LINE IN WINDOW
	AX = 0006h
	ES:BX -> text string
	CH = type
	    00h everything
	    01h uppercase only
	    02h positive numbers
	    03h Dutch postal code ("9999 AA")
	    04h 'J' or 'N' (Dutch yes/no)
	    05h telephone or FAX number
	    06h positive or negative number
	    07h date (dd/mm/yy)
	    08h money
	    09h '1' through '8'
	    0Ah '1' through '4'
	    0Bh uppercase filenames
	DH,DL = row,column of upper left corner
	DI = window handle
Return: AX = key which terminated entry
	    0000h Enter
	    0001h Esc
	    0002h Down arrow
	    0003h Up arrow
	    0004h F10
----------51---------------------------------
INT 51 - through 53 - IRQ1-IRQ3 relocated by DESQview
Note:	this is the default location for older versions; see INT 50"DESQview"
	  for details of interrupt relocation
SeeAlso: INT 50"DESQview",INT 54"DESQview",INT 58"DESQview"
----------51---------------------------------
INT 51 - through 53 - IRQ1-IRQ3 relocated by IBM 3278 emulation control program
SeeAlso: INT 50"IBM 3278",INT 54"IBM 3278"
----------51---------------------------------
INT 51 - through 53 - IRQ1-IRQ3 relocated by OS/2 v1.x
SeeAlso: INT 50"OS/2",INT 54"OS/2"
----------53---------------------------------
INT 53 - ??? - API
	BX = function
	    0000h ???
	    	AX = ???
		Return: AX = ???
	    0004h ???
	    0009h ???
	    0015h
	    	AX = ???
		DX = ???
	    0017h
Return: ???
Notes:	the installation check consists of looking for the signature "WEBCO"
	  immediately prior to the interrupt handler
	the above calls are made by Show Partner F/X v3.6 (see INT 10/AH=53h)
----------54---------------------------------
INT 54 - through 57 - IRQ4-IRQ7 relocated by DESQview
Note:	this is the default location for older versions; see INT 50"DESQview"
	  for details of interrupt relocation
SeeAlso: INT 50"DESQview",INT 58"DESQview"
----------54---------------------------------
INT 54 - through 57 - IRQ4-IRQ7 relocated by IBM 3278 emulation control program
SeeAlso: INT 51"IBM 3278"
----------54---------------------------------
INT 54 - through 57 - IRQ4-IRQ7 relocated by OS/2 v1.x
SeeAlso: INT 51"OS/2"
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
----------5B---------------------------------
INT 5B - ISOLAN Multi Protocol Software
	ES:BX -> Transfer Control Block
Return: AL - status
Note:	this software interface allows multiple protocols/software packages
	  to access a BICC 411x network card

Format of Transfer Control Block:
Offset	Type	Description
 00h	BYTE	command code
		B3h Status
		F2h Activate
		F3h Deactivate
		F4h Send Data
 01h	BYTE	command identity
 02h	BYTE	virtual circuit ID
 03h	WORD	buffer length
 05h	DWORD	buffer pointer
 09h	BYTE	expedited data flag
 0Ah	BYTE	cancelable flag
 0Bh 16 BYTEs	local network address
 1Bh 16 BYTEs	remote network address
 2Bh	DWORD	asynchronous notification routine
 30h	DWORD	local network number
 34h	DWORD	remote network number
 38h	BYTE	call timeout
 39h	BYTE	not used
 3Ah  8 BYTEs	reserved
 42h	BYTE	command code extension
 43h	WORD	Blue Book MAC type
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
		F0h-FFh Eicon NABios interface (see also INT 7B"Eicon")
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
	48h send data and receive data (LAN Manager NETBEUI.DOS)
	70h unlink from IBM remote program (no F0h function)
	71h send data without ACK
	72h send multiple buffers without ACK
	72h UngermannBass Register (conflicts with above function)
	73h UngermannBass SendNmc
	74h UngermannBass Callniu
	75h UngermannBass Calladdr
	76h UngermannBass Listenaddr
	77h UngermannBass SendPkt
	78h find name
	78h UngermannBass RcvPkt (conflicts with above function)
	79h token-ring protocol trace
	79h UngermannBass SendAttn (conflicts with above function)
	7Ah UngermannBass RcvAttn
	7Bh UngermannBass Listenniu
	7Ch UngermannBass RcvRaw
	7Dh UngermannBass SendNmc2

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
SeeAlso: INT 0F"HP 95LX",INT 10/AH=00h,INT 15/AX=4DD4h
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
----------60---------------------------------
INT 60 - reserved for user interrupt
----------60---------------------------------
INT 60 - VIRUS - "Zero Bug" - INSTALLATION CHECK
   The "Zero Bug" virus hooks this vector.  It considers itself installed if
   offset 103h of the handler's segment contains the bytes "ZE"
SeeAlso: INT 32,INT 61"SEMTEX"
----------60---------------------------------
INT 60 - Adaptec and OMTI controllers - DRIVE 0 DATA
SeeAlso: INT 61"Adaptec",INT 62"Adaptec",INT 63"Adaptec",INT 64"Adaptec"
Notes:	this vector stores the first four bytes of the parameter table for
	  hard disk 0
	these vectors are used by the following Adaptec controllers:
	    ACB 2370 A/B/C, ACB 2372 A/B/C, ACB 2333 A/B, 2322B-8, 2322B-16
	these vectors are NOT used by the following Adaptec controllers:
	    ACB 2310, ACB 2312, ACB 2320D, ACB 2322D
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
INT 60 U - INTRSPY/CMDSPY API
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
INT 60 U - PC/370 v4.2 - ???
	???
Return: ???
Notes:	PC/370 is an IBM 370 emulator by Donald S. Higgins
	this is the default interrupt, however the documentation includes
	  instructions for patching the system for another interrupt
SeeAlso: INT 2F/AX=7F24h,INT DC"PC/370"
----------60---------------------------------
INT 60 - JPI TopSPEED Modula-2 v1 - PROCEDURE ENTRY TRAP
SeeAlso: INT 61"JPI"
----------60---------------------------------
INT 60 - FTP Packet Driver - PC/TCP Packet Driver Specification
   The handler for the interrupt will start with a 3-byte jump instruction, 
   followed by the ASCIZ string "PKT DRVR".  To find the interrupt being used
   by the driver, an application should scan through interrupt vectors 60h to
   80h (20h through FFh for v1.10+ of the specification) until it finds one
   with the "PKT DRVR" string.	AH values of 80h to FFh have been reserved
   for user-defined additions.
----------60----DI0100-----------------------
INT 60 u - HP 95LX System Manager - WAIT FOR EVENT
	DI = 0100h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to event record (see below)
Return: event record filled
	STACK unchanged
Note:	this call will timeout after about 500ms
SeeAlso: INT 15/AX=4DD4h,INT 60/DI=0101h,INT 61"HP 95LX",INT 62"HP 95LX"

Format of event record:
Offset	Size	Description
 00h	WORD	event type
 		00h no events
		01h keystroke available
		02h Ctrl-Break
		03h reactivation (always follows deactivation event)
		04h about to deactivate (sleep)
			next get-event call will not return until reactivated
		05h forced application termination
		06h 1-2-3 bridge service request (only given to  1-2-3)
		07h request to grow
		08h request to shrink
		09h application's alarm expired
		0Ah daily chance to set an alarm
		0Bh system date or time has been changed
 02h	WORD	ASCII code page 850 translation of keystroke
 		or grow/shrink amount in paragraphs or 0000h if error
 		or alarm expiration data
 04h	BYTE	scan code from BIOS
 05h	BYTE	shift key states at time keystroke is retrieved
 06h	WORD	LICS translation of keystroke
 08h	BYTE	function key number (1-2-3 only)
 09h	DWORD	pointer to 1-2-3 bridge record (see INT 60/DI=0104h)
 		or pointer to time change structure (see below)
Note:	if the System Manager is waiting the conclusion of a bridge service
	  or grow/shrink call and the event type field is set to FFFFh on
	  entry, the SysMgr will resume

Format of time change structure:
Offset	Size	Description
 00h	WORD	old year
 02h	BYTE	old month
 03h	BYTE	old date
 04h	BYTE	old day
 05h	BYTE	old hour
 06h	BYTE	old minute
 07h	BYTE	old second
 08h	BYTE	old hundredth of a second
 09h  9 BYTEs	new time in same format as old time
----------60----DI0101-----------------------
INT 60 u - HP 95LX System Manager - CHECK FOR EVENT
	DI = 0101h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD pointer to event record (INT 60/DI=0100h)
Return: event record filled
	STACK unchanged
Note:	this call returns immediately if no event is available
SeeAlso: INT 60/DI=0100h
----------60----DI0102-----------------------
INT 60 u - HP 95LX System Manager - "SH_STATUS"
	DI = 0102h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
----------60----DI0104-----------------------
INT 60 u - HP 95LX System Manager - LOTUS 1-2-3 BRIDGE SERVICES
	DI = 0104h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD pointer to bridge record (see below)
Return: ???
	STACK unchanged

Format of bridge record:
Offset	Size	Description
 00h	WORD	function code
 		00h test
		01h get range
		02h "GETRANGE_ADDR"
		03h "SETRANGE_ADDR"
		04h "GETRANGE_DATA"
		05h "SETRANGE_DATA"
		06h recalculate
		07h get cursor
		08h set cursor
		09h redisplay
		0Ah cell type
		0Bh "CALCTYPE"
 02h	WORD	return code from 1-2-3
 04h 16 BYTEs	ASCII range name
 14h	WORD	start column of range
 16h	WORD	start row of range
 18h	WORD	end column of range
 1Ah	WORD	end row of range
 1Ch	WORD	order in which data is placed in buffer
 1Eh	WORD	buffer size
 20h	WORD	offset within bridge record's segment of buffer for cell data
----------60----DI0105-----------------------
INT 60 u - HP 95LX System Manager - FLUSH KEYBOARD BUFFER
	DI = 0105h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
----------60----DI0106-----------------------
INT 60 u - HP 95LX System Manager - YIELD CPU
	DI = 0106h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=1000h,INT 2F/AX=1680h
----------60----DI0107-----------------------
INT 60 u - HP 95LX System Manager - "NO_FINI" - REFUSE TERMINATION REQUEST
	DI = 0107h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
----------60----DI0200-----------------------
INT 60 u - HP 95LX System Manager - SETUP MENU
	DI = 0200h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to menu data (see below)
		DWORD	pointer to ???
		WORD	number of items on menu???
		WORD	???
		DWORD	pointer to ???
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 60/DI=0201h,INT 60/DI=0203h,INT 60/DI=0205h

Format of menu data:
Offset	Size	Description
 00h 80 BYTEs	first line of menu text
 50h 80 BYTEs	second line of menu text
 A0h 80 BYTEs	third line of menu text
 F0h	WORD	number of keywords
 F2h	WORD	index of currently highlighted keyword or FFFFh
 F4h	WORD	single prompt on top line if nonzero
 F6h 20 BYTEs	which line each of 20 keywords is located on
10Ah 20 BYTEs	offset of each of 20 keywords within its line
11Eh 20 BYTEs	length of each of 20 keywords
132h 20 BYTEs	first letter of each of 20 keywords
146h 20 WORDs	offsets of long prompts for each of 20 keywords
----------60----DI0201-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY OR REDISPLAY MENU
	DI = 0201h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to menu data (see INT 60/DI=0200h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0200h,INT 60/DI=0202h,INT 60/DI=0206h
----------60----DI0202-----------------------
INT 60 u - HP 95LX System Manager - "MENU_ON" - ENABLE PROCESSING OF MENU
	DI = 0202h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to menu data (see INT 60/DI=0200h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0200h,INT 60/DI=0201h,INT 60/DI=0203h
----------60----DI0203-----------------------
INT 60 u - HP 95LX System Manager - REMOVE MENU
	DI = 0203h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to menu data (see INT 60/DI=0200h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0201h,INT 60/DI=0202h,INT 60/DI=0204h,INT 60/DI=0208h
----------60----DI0204-----------------------
INT 60 u - HP 95LX System Manager - LET SYSTEM MANAGER HANDLE MENU KEYSTROKE
	DI = 0204h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to menu data (see INT 60/DI=0200h)
		WORD	keystroke
		DWORD	pointer to WORD to receive selection number
Return: buffer for selection number filled with index of selected menu item or
	  FFFFh if no final selection yet
	STACK unchanged
SeeAlso: INT 60/DI=0200h,INT 60/DI=0202h,INT 60/DI=0207h
----------60----DI0205-----------------------
INT 60 u - HP 95LX System Manager - INITIALIZE FILE SELECTION MENU
	DI = 0205h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file menu structure (see below)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
		DWORD	pointer to wildcard filespec for initial file list
		WORD	row???
		WORD	column???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0200h,INT 60/DI=0206h,INT 60/DI=0208h

Format of file menu structure:
Offset	Size	Description
 00h	DWORD	pointer to ASCIZ base directory name
 04h	DWORD	pointer to ASCIZ file pattern (wildcard filespec)
 08h	DWORD	pointer to file list workspace, at least 1024 bytes (see below)
 0Ch	WORD	size of file list workspace in bytes
 0Eh	WORD	starting row (-3 is topmost, 0 is first non-"reserved" line)
 10h	WORD	starting column
 12h	WORD	number of lines
 14h	WORD	number of columns
 16h	WORD	number of files displayed on each line
---the remaining fields are initialized by the System Manager---
 18h	WORD	0000h if first edit character, else multiline
 1Ah	WORD	number of files in file list
 1Ch	WORD	max files workspace has room for
 1Eh	WORD	file at top of list
 20h	WORD	index of file to highlight
 22h	WORD	index of file to unhighlight
 24h	WORD	current focus (01h FMENU, 02h EDIT)

Format of file list workspace entry:
Offset	Size	Description
 00h	BYTE	file attributes
 01h	WORD	file time (see INT 21/AX=5700h)
 03h	WORD	file date (see INT 21/AX=5700h)
 05h	DWORD	file size
 09h 13 BYTEs	ASCIZ filename
----------60----DI0206-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY/REDISPLAY FILE SELECTION MENU
	DI = 0206h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file menu structure (see INT 60/DI=0205h)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0205h
----------60----DI0207-----------------------
INT 60 u - HP 95LX System Manager - LET SYSMGR PROCESS FILE SEL MENU KEYSTROKE
	DI = 0207h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file menu structure (see INT 60/DI=0205h)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
		WORD	keystroke
Return: AX = status
	    0000h keystroke processed, call INT 60/DI=0206h to refresh menu
	    0001h redisplay application area before refreshing menu
	    0002h user confirmed selection, filename is in edit record's buffer
	    0003h user aborted menu
	    FFFBh bad filename
	    FFFCh bad directory
	    FFFDh bad drive
	    FFFEh unknown keystroke
	    FFFFh keystroke known but invalid in current context
	STACK unchanged
SeeAlso: INT 60/DI=0205h,INT 60/DI=0208h
----------60----DI0208-----------------------
INT 60 u - HP 95LX System Manager - REMOVE FILE SELECTION MENU
	DI = 0208h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file menu structure (see INT 60/DI=0205h)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 60/DI=0205h,INT 60/DI=0206h
----------60----DI0300-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY STRING
	DI = 0300h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	starting row (-3 is topmost, 0 is first user line)
		WORD	starting column
		DWORD	pointer to string
		WORD	length of string
		WORD	display style: 0000h normal, 0001h reverse video
		WORD	"OSTYLE"
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0F03h,INT 60/DI=1005h
----------60----DI0301-----------------------
INT 60 u - HP 95LX System Manager - CLEAR PORTION OF SCREEN
	DI = 0301h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	starting row (-3 is topmost, 0 is first user line)
		WORD	starting column
		WORD	number of rows
		WORD	number of columns
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0302h,INT 60/DI=1005h
----------60----DI0302-----------------------
INT 60 u - HP 95LX System Manager - SCROLL PORTION OF SCREEN
	DI = 0302h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	starting row???
		WORD	starting column???
		WORD	height of scroll region???
		WORD	width of scroll region???
		WORD	number of lines to scroll region???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0301h
----------60----DI0303-----------------------
INT 60 u - HP 95LX System Manager - SCREEN SERVICE "M_XCHG"
	DI = 0303h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
		WORD	???
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0304-----------------------
INT 60 u - HP 95LX System Manager - SCREEN SERVICE "M_CHRATTR"
	DI = 0304h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0305-----------------------
INT 60 u - HP 95LX System Manager - SCREEN SERVICE "M_CHRRVRT"
	DI = 0305h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0307-----------------------
INT 60 u - HP 95LX System Manager - SCREEN SERVICE "M_CHRINV"
	DI = 0307h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0308-----------------------
INT 60 u - HP 95LX System Manager - SCREEN SERVICE "M_ROWS_COLS"
	DI = 0308h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
----------60----DI0309-----------------------
INT 60 u - HP 95LX System Manager - SET SCREEN (VIDEO???) MODE
	DI = 0309h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	new mode
Return: ???
	STACK unchanged
----------60----DI030A-----------------------
INT 60 u - HP 95LX System Manager - GET SCREEN (VIDEO???) MODE
	DI = 030Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
----------60----DI030B-----------------------
INT 60 u - HP 95LX System Manager - SET CURSOR POSITION
	DI = 030Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	row (-3 is topmost, 0 is first non-reserved line)
		WORD	column
Return: ???
	STACK unchanged
Note:	cursor is hidden if the specified position is not on the physical
	  display
SeeAlso: INT 10/AH=02h,INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
----------60----DI0400-----------------------
INT 60 u - HP 95LX System Manager - "EDIT_INIT"
	DI = 0400h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to edit record (see below)
		DWORD	pointer to string to be edited
		WORD	initial length of string being edited
		WORD	maximum length of edited string
		WORD	row of edit field
		WORD	leftmost column of edit field
Return: ???
	STACK unchanged

Format of edit record:
Offset	Size	Description
 00h	WORD	current length of edit buffer
 02h	BYTE	flag for special processing on first character
 03h	BYTE	flags
 		bit 0: tab handling
 04h	WORD	editing in prompt window?
 06h	DWORD	pointer to top line of prompt window message
 0Ah	WORD	length of top line of prompt
 0Ch	DWORD	pointer to second line of prompt window message
 10h	WORD	length of second line of prompt
 12h 80 BYTEs	workspace for editing
 62h  2 WORDs	line array needed for multi-line editing
 66h 36 BYTEs	multi-line edit record (see below)
 8Ah	WORD	displayable columns

Format of multi-line edit record:
Offset	Size	Description
 00h	DWORD	pointer to user-supplied edit buffer
 04h	WORD	length of edit buffer
 06h	WORD	current cursor position
 08h	WORD	starting row of edit area (-3 is topmost, 0 is first user line)
 0Ah	WORD	starting column of edit area
 0Ch	WORD	height of edit area
 0Eh	WORD	width of edit area
 10h	WORD	current top row (-3 is topmost, 0 is first user line)
 12h	WORD	number of rows displayable
 14h	BYTE	cursor column
 15h	BYTE	01h if buffer has been modified
 16h	BYTE	first displayable column (ticker fields only)
 17h	BYTE	01h if wordwrap enabled, FFh if ticker field
 18h	DWORD	pointer to array of line starts (at least one bigger than edit
 		  area is high)
 1Ch	BYTE	currently marking?
 1Dh	BYTE	flag
 1Eh	WORD	offset of mark start
 20h	WORD	offset of mark end (inclusive)
 22h	WORD	displayable columns
----------60----DI0401-----------------------
INT 60 u - HP 95LX System Manager - EDIT ON TOP LINE
	DI = 0401h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
		DWORD	pointer to string to edit
		WORD	initial length of string being edited
		WORD	maximum length of edited string
		DWORD	pointer to first line of prompt
		WORD	length of first line
		DWORD	pointer to second line of prompt
		WORD	length of second line
Return: ???
	STACK unchanged
----------60----DI0402-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY OR REDISPLAY EDIT FIELD
	DI = 0402h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
Return: ???
	STACK unchanged
----------60----DI0403-----------------------
INT 60 u - HP 95LX System Manager - LET SYSTEM MANAGER PROCESS EDITING KEYSTROK
	DI = 0403h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to edit record (see INT 60/DI=0400h)
		WORD	keystroke
		DWORD	pointer to WORD buffer for result code
Return: result code buffer filled with 0001h if editing complete
	STACK unchanged
----------60----DI0404-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_INI"
	DI = 0404h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
		WORD	???
		WORD	???
		DWORD	pointer to ???
		WORD	???
		WORD	???
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0405-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_DIS"
	DI = 0405h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0406-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_KEY"
	DI = 0406h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0407-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_FIL"
	DI = 0407h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0408-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_MARK"
	DI = 0408h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0409-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_UNMARK"
	DI = 0409h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI040A-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_CUTMARK"
	DI = 040Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI040B-----------------------
INT 60 u - HP 95LX System Manager - "MDIT_INS_STR"
	DI = 040Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
----------60----DI0500-----------------------
INT 60 u - HP 95LX System Manager - OPEN FILE
	DI = 0500h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see below)
		DWORD	pointer to filename
		WORD	length of filename
		WORD	???
		WORD	suppress buffering if nonzero
Return: AX = status
	STACK unchanged
SeeAlso: INT 60/DI=0501h,INT 60/DI=0502h,INT 60/DI=0508h

Format of file state record:
Offset	Size	Description
 00h	WORD	DOS file handle
 02h	WORD	flags
 		bit 0: buffer contents valid
		bit 1: buffer is dirty and must be written
		bit 2: unbuffered I/O
		bit 3: file is a character device
 04h	DWORD	current DOS physical file offset (FFFFFFFFh if unknown)
 08h	DWORD	DOS file offset of start of buffer
 0Ch	DWORD	effective file offset as seen by caller
 10h	WORD	number of bytes in file buffer
---buffered I/O only---
 12h 512 BYTEs	file buffer
----------60----DI0501-----------------------
INT 60 u - HP 95LX System Manager - OPEN FILE IN READ-ONLY MODE
	DI = 0501h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		DWORD	pointer to filename
		WORD	length of filename
		WORD	???
		WORD	suppress buffering if nonzero
Return: AX = status
	STACK unchanged
SeeAlso: INT 60/DI=0500h
----------60----DI0502-----------------------
INT 60 u - HP 95LX System Manager - CREATE NEW FILE
	DI = 0502h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		DWORD	pointer to filename
		WORD	length of filename
		WORD	???
		WORD	suppress buffering if nonzero
Return: AX = status
	STACK unchanged
SeeAlso: INT 60/DI=0500h,INT 60/DI=0503h
----------60----DI0503-----------------------
INT 60 u - HP 95LX System Manager - CREATE OR TRUNCATE FILE
	DI = 0503h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		DWORD	pointer to filename
		WORD	length of filename
		WORD	???
		WORD	suppress buffering if nonzero
Return: AX = status
	STACK unchanged
SeeAlso: INT 60/DI=0502h
----------60----DI0504-----------------------
INT 60 u - HP 95LX System Manager - READ FROM FILE
	DI = 0504h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		DWORD	pointer to data buffer
		WORD	number of bytes to read
		DWORD	pointer to WORD in which to return actual bytes read
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0505h
----------60----DI0505-----------------------
INT 60 - HP 95LX System Manager - WRITE TO FILE
	DI = 0505h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		DWORD	pointer to data
		WORD	length of data
Return: AX = status
	STACK unchanged
SeeAlso: INT 60/DI=0504h
----------60----DI0506-----------------------
INT 60 u - HP 95LX System Manager - SET FILE POSITION
	DI = 0506h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0507h
----------60----DI0507-----------------------
INT 60 u - HP 95LX System Manager - GET FILE POSITION
	DI = 0507h "M_TELL"
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
		DWORD	pointer to DWORD buffer for file position???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0506h
----------60----DI0508-----------------------
INT 60 u - HP 95LX System Manager - CLOSE FILE
	DI = 0508h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to file state record (see INT 60/DI=0500h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0500h
----------60----DI0509-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_SETPAT"
	DI = 0509h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI050A-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_MATCH"
	DI = 050Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged

Format of pattern match control block:
Offset	Size	Description
 00h 43 BYTEs	FindFirst data block (see INT 21/AH=4Eh)
 2Bh 80 BYTEs	full path name
 7Bh	BYTE	offset of last component of filename
 7Ch	BYTE	DOS function number (4Eh or 4Fh)
----------60----DI050B-----------------------
INT 60 u - HP 95LX System Manager - IDENTIFY FILENAME REFERENT
	DI = 050Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged

Values returned:
 0000h nonexistent
 0001h file
 0002h directory
 0003h character device
----------60----DI050C-----------------------
INT 60 u - HP 95LX System Manager - DELETE FILE
	DI = 050Ch "M_DELETE"
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI050D-----------------------
INT 60 u - HP 95LX System Manager - RENAME FILE
	DI = 050Dh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
		DWORD	pointer to ???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI050E-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_GETDIR"
	DI = 050Eh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI050F-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_SETDIR"
	DI = 050Fh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0510-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_VOLUME"
	DI = 0510h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0511-----------------------
INT 60 u - HP 95LX System Manager - MAKE A SUBDIRECTORY
	DI = 0511h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0512-----------------------
INT 60 u - HP 95LX System Manager - REMOVE A SUBDIRECTORY
	DI = 0512h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0513-----------------------
INT 60 u - HP 95LX System Manager - GET DEFAULT DRIVE
	DI = 0513h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ??? buffer for current drive
Return: ???
	STACK unchanged
----------60----DI0514-----------------------
INT 60 u - HP 95LX System Manager - SET DEFAULT DRIVE
	DI = 0514h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	new drive
Return: ???
	STACK unchanged
----------60----DI0515-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_FDATE"
	DI = 0515h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0516-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_GET_SYSDIR"
	DI = 0516h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0517-----------------------
INT 60 u - HP 95LX System Manager - GET FILE ATTRIBUTES
	DI = 0517h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
		DWORD	pointer to ??? buffer for file's attributes???
Return: ???
	STACK unchanged
----------60----DI0518-----------------------
INT 60 u - HP 95LX System Manager - SET FILE ATTRIBUTES
	DI = 0518h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
		WORD	new attributes???
Return: ???
	STACK unchanged
----------60----DI0519-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_COMMON_OPEN"
	DI = 0519h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		WORD	???
		WORD	???
		WORD	???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI051A-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_COPYDT"
	DI = 051Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI051B-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_GETFDT"
	DI = 051Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI051C-----------------------
INT 60 u - HP 95LX System Manager - FILE SERVICE "M_PUTFDT"
	DI = 051Ch
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0600-----------------------
INT 60 u - HP 95LX System Manager - PROCESS INITIALIZING
	DI = 0600h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 60/DI=0601h,INT 61"HP 95LX"
----------60----DI0601-----------------------
INT 60 u - HP 95LX System Manager - PROCESS TERMINATION
	DI = 0601h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: never
	STACK unchanged
SeeAlso: INT 21/AH=4Ch,INT 60/DI=0600h
----------60----DI0602-----------------------
INT 60 u - HP 95LX System Manager - "M_LOCK" - PREVENT TASK SWITCHES
	DI = 0602h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=101Bh,INT 60/DI=0603h
----------60----DI0603-----------------------
INT 60 u - HP 95LX System Manager - "M_UNLOCK" - ALLOW TASK SWITCHES
	DI = 0603h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=101Ch,INT 60/DI=0602h
----------60----DI0604-----------------------
INT 60 u - HP 95LX System Manager - "M_SPAWN"
	DI = 0604h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0605-----------------------
INT 60 u - HP 95LX System Manager - "M_APPCOUNT"
	DI = 0605h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
----------60----DI0606-----------------------
INT 60 u - HP 95LX System Manager - "M_REBOOT"
	DI = 0606h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
----------60----DI0607-----------------------
INT 60 u - HP 95LX System Manager - "M_SPAWNARG"
	DI = 0607h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0608-----------------------
INT 60 u - HP 95LX System Manager - "M_REG_APP_NAME"
	DI = 0608h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0609-----------------------
INT 60 u - HP 95LX System Manager - "M_APP_NAME"
	DI = 0609h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: DX:AX -> ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
----------60----DI0700-----------------------
INT 60 u - HP 95LX System Manager - OPEN CLIPBOARD
	DI = 0700h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0701h,INT 60/DI=0702h

Values for error code:
 0000h	successful
 FFF8h transfer request out of bounds
 FFF9h no such representation
 FFFAh no representation open
 FFFBh a representation is already open
 FFFCh representation already exists
 FFFDh heap allocation failure
 FFFEh clipboard not open
 FFFFh clipboard access denied
----------60----DI0701-----------------------
INT 60 u - HP 95LX System Manager - CLOSE CLIPBOARD
	DI = 0701h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0700h,INT 60/DI=0702h
----------60----DI0702-----------------------
INT 60 u - HP 95LX System Manager - RESET CLIPBOARD
	DI = 0702h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0700h
----------60----DI0704-----------------------
INT 60 u - HP 95LX System Manager - "M_NEW_REP" - START A NEW REPRESENTATION???
	DI = 0704h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0705h,INT 60/DI=0706h,INT 60/DI=0707h
----------60----DI0705-----------------------
INT 60 u - HP 95LX System Manager - CLIPBOARD SERVICE "M_FINI_REP"
	DI = 0705h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0704h
----------60----DI0706-----------------------
INT 60 u - HP 95LX System Manager - CLIPBOARD SERVICE "M_REP_NAME"
	DI = 0706h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0704h,INT 60/DI=0707h
----------60----DI0707-----------------------
INT 60 u - HP 95LX System Manager - CLIPBOARD SERVICE "M_REP_INDEX"
	DI = 0707h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0704h,INT 60/DI=0706h
----------60----DI0708-----------------------
INT 60 u - HP 95LX System Manager - WRITE TO CLIPBOARD
	DI = 0708h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to data to be written???
		WORD	length of data???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0709h
----------60----DI0709-----------------------
INT 60 u - HP 95LX System Manager - READ FROM CLIPBOARD
	DI = 0709h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
		DWORD	pointer to buffer for data???
		WORD	length of buffer???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0708h
----------60----DI0800-----------------------
INT 60 u - HP 95LX System Manager - BEEP
	DI = 0800h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0801h,INT 60/DI=0802h,INT 60/DI=0803h
----------60----DI0801-----------------------
INT 60 u - HP 95LX System Manager - SOUND SERVICE "M_THUD"
	DI = 0801h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0800h,INT 60/DI=0802h,INT 60/DI=0803h
----------60----DI0802-----------------------
INT 60 u - HP 95LX System Manager - MAKE A SOUND PATTERN
	DI = 0802h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	pattern number (00h-06h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0800h,INT 60/DI=0801h,INT 60/DI=0803h
----------60----DI0803-----------------------
INT 60 u - HP 95LX System Manager - TURN OFF SOUND
	DI = 0803h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0800h,INT 60/DI=0801h,INT 60/DI=0802h
----------60----DI0900-----------------------
INT 60 - HP 95LX System Manager - ALLOCATE REGULAR MEMORY BLOCK
	DI = 0900h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	size of block in bytes
Return: AX -> memory block
	STACK unchanged
Note:	System Manager-compliant applications are always small-model (64K code,
	  64K data)
SeeAlso: INT 15/AX=4DD4h,INT 60/DI=0902h,INT 60/DI=0903h
----------60----DI0902-----------------------
INT 60 u - HP 95LX System Manager - FREE REGULAR MEMORY BLOCK
	DI = 0902h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	offset of memory block???
Return: ???
	STACK unchanged
Note:	System Manager-compliant applications are always small-model (64K code,
	  64K data)
SeeAlso: INT 60/DI=0900h,INT 60/DI=0904h
----------60----DI0903-----------------------
INT 60 u - HP 95LX System Manager - ALLOCATE LARGE MEMORY BLOCK
	DI = 0903h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	size of block in bytes???
Return: AX -> memory block???
	STACK unchanged
SeeAlso: INT 60/DI=0900h,INT 60/DI=0904h
----------60----DI0904-----------------------
INT 60 u - HP 95LX System Manager - FREE LARGE MEMORY BLOCK
	DI = 0904h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	segment of memory block???
Return: AX -> ???
	STACK unchanged
SeeAlso: INT 60/DI=0902h,INT 60/DI=0903h
----------60----DI0B00-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_DTINFO"
	DI = 0B00h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0B01-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_GETDTM"
	DI = 0B01h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0B02-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_SETDTM"
	DI = 0B02h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0B03-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_XALARM"
	DI = 0B03h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0B04-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_ALARM"
	DI = 0B04h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to alarm record???
		WORD	???
Return: ???
	STACK unchanged

Format of alarm record:
Offset	Size	Description
 00h	BYTE	hour
 01h	BYTE	minute
 02h	BYTE	second
 03h	BYTE	unused padding
 04h	WORD	rescheduling interval, in seconds
 06h	BYTE	are seconds significant?
 07h	BYTE	alarm sound
 08h 40 BYTEs	message displayed when alarm activates
 30h	BYTE	task ID of owner
 31h	BYTE	application's own use for sub-class
 32h  4 BYTEs	application's own use for private data
----------60----DI0B05-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_START_SW"
	DI = 0B05h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0B06-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_GET_SW"
	DI = 0B06h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0B07-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_STOP_SW"
	DI = 0B07h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0B08-----------------------
INT 60 u - HP 95LX System Manager - "M_TELLTIME" - DISPLAY TIMESTAMP
	DI = 0B08h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	timestamp format
			bits 1-0:
				00 date only
				01 time only
				10 date and time
				11 day and date
			bit 4: supply am/pm
			bit 5: supply seconds
			bit 6: show year
			bit 7: four-digit year
		WORD	row (-3 is topmost, 0 is first non-reserved line)
		WORD	column
Return: ???
	STACK unchanged
----------60----DI0B09-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_GET_SETTINGS"
	DI = 0B09h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B0Ah,INT 60/DI=0B0Fh

Format of system settings:
Offset	Size	Description
 00h	WORD	country code
 02h	WORD	speaker volume (00h-03h or FFh for off)
 04h	WORD	contrast level (00h-0Fh)
 06h	WORD	week start (00h Sunday, 01h Monday)
 08h	WORD	punctuation format
 		code	decimal	arg	thousands
		00h	.	,	,
		01h	,	.	.
		02h	.	;	;
		03h	,	;	.
		04h	.	,	" "
		05h	,	.	" "
		06h	.	;	" "
		07h	,	;	" "
 0Ah	WORD	two-character language code (only 5355h = "US" byte-swapped)
 0Ch	WORD	current date format
 		00h dd-mmm-yy
		01h dd-mmm
		02h mmm-yy
		03h mm/dd/yy
		04h dd/mm/yy
		05h dd.mm.yy
		06h yy-mm-dd
		07h mm/dd
		08h dd/mm
		09h dd.mm
		0Ah mm-dd
 0Eh	WORD	current time format
 		00h HH:MM:SS am/pm
		01h HH:MM am/pm
		02h HH:MM:SS
		03h HH.MM.SS
		04h HH,MM,SS
		05h HHhMMmSSs
		06h HH:MM
		07h HH.MM
		08h HH,MM
		09h HHhMMm
 10h	WORD	collating sequence
 		00h numbers first, 01h letters first, 02h ASCII
 12h 80 BYTEs	name of picture file
 62h 30 BYTEs	name
 80h 30 BYTEs	title
 9Eh 28 BYTEs	company name
 BAh	WORD	number of languages
 BCh  6 BYTEs	available languages
 C2h 66 BYTEs	language menu
104h  2 BYTEs	ASCIZ date separator
106h  2 BYTEs	ASCIZ time separator
108h	BYTE	date order
109h	BYTE	use 24 hour time?
10Ah 16 BYTEs	currency string
11Ah	WORD	currency string position (00h prefix, 01h suffix)
11Ch	WORD	keyboard (see below)
11Eh	WORD	printer baud rate
		00h 300, 01h 1200, 02h 2400, 03h 4800, 04h 9600, 05h 19200
120h	WORD	printer driver code
		00h Epson FX80, 01h HP Laserjet, 02h IBM ProPrinter
122h	WORD	printer interface (00h COM1, 01h COM2, 02h IR, 03h LPT1)
124h	WORD	system manager interrupt (60h by default)
126h	WORD	code page (01h CP850, 02h CP437)
128h	WORD	active exit key
12Ah	WORD	active menu key
12Ch	WORD	active CHAR key toggle
12Eh  6 BYTEs	alarm

Values for keyboard:
	0001h Belgium
	0002h French Canadian
	0004h Denmark
	0008h Finland
	0010h French
	0020h Finland
	0040h Italy
	0080h Netherlands
	0100h Norway
	0200h Portugal
	0400h Spain
	0800h Sweden
	1000h Swiss French
	2000h Swiss German
	4000h United Kingdom
	8000h USA
----------60----DI0B0A-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_SET_SETTINGS"
	DI = 0B0Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B09h
----------60----DI0B0B-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_START_TIMER"
	DI = 0B0Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B0Ch,INT 60/DI=0B0Dh
----------60----DI0B0C-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_STOP_TIMER"
	DI = 0B0Ch
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B0Bh,INT 60/DI=0B0Dh
----------60----DI0B0D-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_GET_TIMER"
	DI = 0B0Dh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B0Bh,INT 60/DI=0B0Ch
----------60----DI0B0E-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_TELL_ANYTIME"
	DI = 0B0Eh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
		WORD	???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: DX:AX -> ???
	STACK unchanged
----------60----DI0B0F-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVCE "M_GET_SETTINGS_ADDR"
	DI = 0B0Fh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: DX:AX -> system settings record (see INT 60/DI=0B09h)
	STACK unchanged
SeeAlso: INT 60/DI=0B09h
----------60----DI0B10-----------------------
INT 60 u - HP 95LX System Manager - PARSE DATE SPECIFICATION
	DI = 0B10h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0B11-----------------------
INT 60 u - HP 95LX System Manager - PARSE TIME SPECIFICATION
	DI = 0B11h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0B12-----------------------
INT 60 u - HP 95LX System Manager - SET DATE PARSING RULE
	DI = 0B12h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	new parsing rule
			01h day-month-year
			02h month-day-year
			03h year-month-day
			04h "DMYO"
			05h "MDYO"
			OR with 08h to get any year
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B13h
----------60----DI0B13-----------------------
INT 60 u - HP 95LX System Manager - SET TIME PARSING RULE
	DI = 0B13h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	new parsing rule
			01h HH:MM:SS (am/pm)
			02h HH:MM:SS (24hr)
			03h HHMM:SS (24hr)
			04h HH:MM:SS.hh (24hr)
			05h HH:MM (am/pm)
			06h HH:MM (24hr)
			07h HHMM (24hr)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0B12h
----------60----DI0B14-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_POST_TIME"
	DI = 0B14h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
----------60----DI0B15-----------------------
INT 60 u - HP 95LX System Manager - CLOCK/CALENDAR SERVICE "M_DAY_TRIGGER"
	DI = 0B15h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
----------60----DI0C00-----------------------
INT 60 u - HP 95LX System Manager - OPEN PRINTER
	DI = 0C00h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0C01h,INT 60/DI=0C02h,INT 60/DI=0C03h
----------60----DI0C01-----------------------
INT 60 u - HP 95LX System Manager - CLOSE PRINTER
	DI = 0C01h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
Note:	relinquishes control of printer
SeeAlso: INT 60/DI=0C00h
----------60----DI0C02-----------------------
INT 60 u - HP 95LX System Manager - WRITE TO PRINTER
	DI = 0C02h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to data to be written
		WORD	length of data
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0C00h
----------60----DI0C03-----------------------
INT 60 u - HP 95LX System Manager - INITIALIZE PRINTER
	DI = 0C03h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0C00h
----------60----DI0C04-----------------------
INT 60 u - HP 95LX System Manager - "M_TRANS_PRINTER"
	DI = 0C04h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0C05-----------------------
INT 60 u - HP 95LX System Manager - "M_FALL_PRINTER"
	DI = 0C05h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
----------60----DI0E00-----------------------
INT 60 u - HP 95LX System Manager - COMMUNICATIONS SERVICE "M_COMM_INIT"
	DI = 0E00h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E01h,INT 60/DI=0E02h

Values for error code:
 0000h	successful
 FFF1h "E_BUSY"
 FFF2h timeout
 FFF3h framing error
 FFF4h parity error
 FFF5h overrun error
 FFF6h "E_EMPTY"
 FFF7h "E_CONECT"
 FFF8h not open
 FFF9h out of memory
 FFFAh buffer overflow
 FFFBh "E_NOFIT"
 FFFCh unsupported
 FFFDh "E_IVOPR"
 FFFEh "E_IVCHN"
 FFFFh "E_REOPEN"
----------60----DI0E01-----------------------
INT 60 u - HP 95LX System Manager - OPEN COMMUNICATIONS CHANNEL
	DI = 0E01h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to WORD buffer for comm channel handle
		WORD	communications line number (01h-04h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E00h,INT 60/DI=0E02h
----------60----DI0E02-----------------------
INT 60 u - HP 95LX System Manager - CLOSE COMMUNICATIONS CHANNEL
	DI = 0E02h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	comm channel handle
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E00h,INT 60/DI=0E01h
----------60----DI0E03-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_GETMDM"
	DI = 0E03h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0E04-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_ANSWER"
	DI = 0E04h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0E05-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_DIAL"
	DI = 0E05h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0E06-----------------------
INT 60 u - HP 95LX System Manager - RESET COMMUNICATIONS CHANNEL
	DI = 0E06h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	comm channel handle
		WORD	reset options
			bit 0: reset line
			bit 1: flush transmit buffer
			bit 2: flush receive buffer
			bit 3: reset modem
			bit 4: reset receiver's ^S state
			bit 5: reset transmitter's ^S state
Return: ???
	STACK unchanged
----------60----DI0E07-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_HANGUP"
	DI = 0E07h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0E08-----------------------
INT 60 u - HP 95LX System Manager - SEND DATA OVER COMM CHANNEL
	DI = 0E08h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	comm channel handle
		DWORD	pointer to data to be sent
		WORD	option flags
			bit 0: send partial buffer
			bit 1: turn on receiver after sending
		DWORD	pointer to WORD containing length of data to be sent
Return: length WORD updated to contain number of bytes actually sent???
	STACK unchanged
SeeAlso: INT 60/DI=0E09h,INT 60/DI=0E0Bh
----------60----DI0E09-----------------------
INT 60 u - HP 95LX System Manager - QUERY COMM CHANNEL TRANSMIT QUEUE
	DI = 0E09h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ??? WORD
		DWORD	pointer to ??? WORD
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E0Ah
----------60----DI0E0A-----------------------
INT 60 u - HP 95LX System Manager - QUERY COMM CHANNEL RECEIVE QUEUE
	DI = 0E0Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	comm channel handle
		DWORD	pointer to WORD to get receive buffer size
		DWORD	pointer to WORD to get free bytes in receive buffer
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E09h,INT 60/DI=0E0Bh
----------60----DI0E0B-----------------------
INT 60 u - HP 95LX System Manager - RECEIVE DATA FROM COMM CHANNEL
	DI = 0E0Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	comm channel handle
		DWORD	pointer to data buffer
		DWORD	pointer to WORD (input) length of data buffer
					(output) number of bytes received
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E08h,INT 60/DI=0E0Ah
----------60----DI0E0C-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_HAZCMD"
	DI = 0E0Ch
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0E0D-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_COMAND"
	DI = 0E0Dh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0E0E-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_BREAK"
	DI = 0E0Eh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0E0F-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_FRCXON"
	DI = 0E0Fh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0E10-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_FRCXOF"
	DI = 0E10h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0E11-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_SETDTR"
	DI = 0E11h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0E12-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_XMITNG"
	DI = 0E12h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0E13-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_STATUS"
	DI = 0E13h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0E14-----------------------
INT 60 u - HP 95LX System Manager - SET COMMUNICATIONS SETTINGS
	DI = 0E14h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	comm channel handle
		DWORD	pointer to comm settings (see below)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E15h

Format of comm settings:
Offset	Size	Description
 00h	BYTE	dial type ('T' tone, 'P' pulse)
 01h	WORD	baud rate divisor (115200/baud_rate)
 03h	BYTE	parity (00h none, 08h odd, 18h even, 28h mark, 38h space)
 04h	BYTE	stop bits (00h one, 04h two)
 05h	BYTE	data bits - 5
 06h	BYTE	software handshake
 		01h none, 02h XOFF/XON, 04h XOFF/any, 08h ENQ/ACK
 07h	BYTE	infrared (01h off, 02h on)
 08h	BYTE	duplex (01h half, 02h full)
 09h	BYTE	echo (01h echo, 02h no echo)
----------60----DI0E15-----------------------
INT 60 u - HP 95LX System Manager - GET COMMUNICATIONS SETTINGS
	DI = 0E15h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to buffer for settings (see INT 60/DI=0E14h)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0E14h
----------60----DI0E16-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_CNFGUR"
	DI = 0E16h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		WORD	???
		WORD	???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI0E17-----------------------
INT 60 u - HP 95LX System Manager - "M_COMM_QRYERR"
	DI = 0E17h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
----------60----DI0F00-----------------------
INT 60 u - HP 95LX System Manager - "M_ERRMSG"
	DI = 0F00h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
		DWORD	pointer to ???
		WORD	???
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0F01-----------------------
INT 60 u - HP 95LX System Manager - DRAW STANDARD TITLE BOX
	DI = 0F01h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ASCIZ title string
Return: ???
	STACK unchanged
----------60----DI0F02-----------------------
INT 60 u - HP 95LX System Manager - "SHOWNAME"
	DI = 0F02h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI0F03-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY TWO-LINE MESSAGE BOX
	DI = 0F03h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to first line of message
		WORD	length of first line
		DWORD	pointer to second line of message
		WORD	length of second line
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0300h,INT 60/DI=0F04h,INT 60/DI=0F09h
----------60----DI0F04-----------------------
INT 60 u - HP 95LX System Manager - REMOVE MESSAGE BOX
	DI = 0F04h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0F03h,INT 60/DI=0F09h
----------60----DI0F05-----------------------
INT 60 u - HP 95LX System Manager - "M_COM_TIMER_ADDR"
	DI = 0F05h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: DX:AX -> ???
	STACK unchanged
----------60----DI0F06-----------------------
INT 60 u - HP 95LX System Manager - "M_COM_TIMER_COUNT_ADDR"
	DI = 0F06h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: DX:AX -> ???
	STACK unchanged
----------60----DI0F07-----------------------
INT 60 u - HP 95LX System Manager - "M_SYS_RSRC_ADDR"
	DI = 0F07h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: DX:AX -> ???
	STACK unchanged
----------60----DI0F08-----------------------
INT 60 u - HP 95LX System Manager - "M_BIOS_OUTSTR"
	DI = 0F08h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI0F09-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY THREE-LINE MESSAGE BOX
	DI = 0F09h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to first line of message
		WORD	length of first line
		DWORD	pointer to second line of message
		WORD	length of second line
		DWORD	pointer to third line of message
		WORD	length of third line
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0F03h,INT 60/DI=0F04h
----------60----DI0F0A-----------------------
INT 60 u - HP 95LX System Manager - DISABLE MACROS
	DI = 0F0Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0F0Bh
----------60----DI0F0B-----------------------
INT 60 u - HP 95LX System Manager - ENABLE MACROS
	DI = 0F0Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 60/DI=0F0Ah
----------60----DI0F0C-----------------------
INT 60 u - HP 95LX System Manager - "M_DATE_TIME_SEPS"
	DI = 0F0Ch
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI0F0D-----------------------
INT 60 u - HP 95LX System Manager - "M_FORM_FT"
	DI = 0F0Dh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: DX:AX -> ???
	STACK unchanged
----------60----DI0F0E-----------------------
INT 60 u - HP 95LX System Manager - "M_RAM_IV_INFO"
	DI = 0F0Eh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: DX:AX -> ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
----------60----DI1005-----------------------
INT 60 u - HP 95LX System Manager - "M_DIRTY_SYNC" - FORCE SCREEN UPDATE
	DI = 1005h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
SeeAlso: INT 10/AH=FFh,INT 60/DI=0300h,INT 60/DI=0301h
----------60----DI1200-----------------------
INT 60 u - HP 95LX System Manager - RESOURCE SERVICE "MAP_RESOURCE_FILE"
	DI = 1200h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI1201-----------------------
INT 60 u - HP 95LX System Manager - "GET_RESOURCE_PTR"
	DI = 1201h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		WORD	???
Return: DX:AX -> ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
----------60----DI1202-----------------------
INT 60 u - HP 95LX System Manager - "GET_RSRC_TAB_PTR"
	DI = 1202h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: DX:AX -> ???
	STACK unchanged
----------60----DI1203-----------------------
INT 60 u - HP 95LX System Manager - "INIT_SYSGMR_RSRCS"
	DI = 1203h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: ???
	STACK unchanged
----------60----DI1300-----------------------
INT 60 u - HP 95LX System Manager - INITIALIZE HELP SYSTEM
	DI = 1300h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI1301-----------------------
INT 60 u - HP 95LX System Manager - DISPLAY HELP
	DI = 1301h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
----------60----DI1302-----------------------
INT 60 u - HP 95LX System Manager - "M_HELP_KEY"
	DI = 1302h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI1303-----------------------
INT 60 u - HP 95LX System Manager - "M_HELP_TERM"
	DI = 1303h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
----------60----DI1400-----------------------
INT 60 u - HP 95LX System Manager - "M_ColInit"
	DI = 1400h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
Return: AX = ???
	STACK unchanged
----------60----DI1401-----------------------
INT 60 u - HP 95LX System Manager - "M_ColCpStr"
	DI = 1401h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI1402-----------------------
INT 60 u - HP 95LX System Manager - "M_ColLicsStr"
	DI = 1402h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI1403-----------------------
INT 60 u - HP 95LX System Manager - "M_ColLicsChar"
	DI = 1403h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI1404-----------------------
INT 60 u - HP 95LX System Manager - "M_ColToLower"
	DI = 1404h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI1405-----------------------
INT 60 u - HP 95LX System Manager - "M_ColCpSearch"
	DI = 1405h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
		DWORD	pointer to ???
		WORD	???
		WORD	???
Return: ???
	STACK unchanged
----------60----DI1406-----------------------
INT 60 u - HP 95LX System Manager - "M_ColToUpper"
	DI = 1406h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		DWORD	pointer to ???
		WORD	???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
----------60----DI1500-----------------------
INT 60 u - HP 95LX System Manager - "GrDispInit"
	DI = 1500h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI1501-----------------------
INT 60 u - HP 95LX System Manager - "GrDispClear"
	DI = 1501h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI1502-----------------------
INT 60 u - HP 95LX System Manager - "GrDispDot"
	DI = 1502h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI1503-----------------------
INT 60 u - HP 95LX System Manager - "GrDispDraw"
	DI = 1503h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI1504-----------------------
INT 60 u - HP 95LX System Manager - "GrDispFill"
	DI = 1504h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI1505-----------------------
INT 60 u - HP 95LX System Manager - "GrDispRead"
	DI = 1505h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI1506-----------------------
INT 60 u - HP 95LX System Manager - "GrDispString"
	DI = 1506h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI1507-----------------------
INT 60 u - HP 95LX System Manager - "GrDispPan"
	DI = 1507h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI1508-----------------------
INT 60 u - HP 95LX System Manager - "GrDispZoom"
	DI = 1508h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI1509-----------------------
INT 60 u - HP 95LX System Manager - "GrDispSave"
	DI = 1509h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI150A-----------------------
INT 60 u - HP 95LX System Manager - "GrDispRestore"
	DI = 150Ah
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
----------60----DI150B-----------------------
INT 60 u - HP 95LX System Manager - "GrDispCorner"
	DI = 150Bh
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
----------60----DI1604-----------------------
INT 60 u - HP 95LX System Manager - "CP_TO_LICS"
	DI = 1604h
	STACK:	2 WORDs unused dummies (for calls from high level languages)
		???
Return: ???
	STACK unchanged
SeeAlso: INT 15/AX=4DD4h,INT 61"HP 95LX",INT 62"HP 95LX"
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
		CL = interpreter color
		BH = monitor start line
		BL = interpreter start line
		AH = makecode of the hotkey
		AL = ASCII code of the hotkey
		DL = status of special keys (only SHIFT, ALT, CTRL) for the
			hotkey (coded as for the keyboard flag at 0040h:0017h)
		DH = basic process number for the communication with drivers
			process number for the display driver, DH+1 = process
			number for the command driver(s)
	DS:SI -> MDEBUG identification table
Notes:	MDEBUG is a shareware memory-resident debugging tool by Bernd Schemmer,
	  including a memory monitor, an interpreter, and a disassembler
	MDEBUG uses INT 60 by default, but may be directed to any of INT 60
	  through INT 67; the interrupt handler is preceded by the signature
	  "USERINT" and is not chained
	if DS:SI points at a null byte, MDEBUG will prompt for a password if
	  passwords are active; enough stack space must be provided for an
	  INT 10h call (which MDEBUG uses while prompting for the password)
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
	       ES:DI-02h  -> R0 (WORD)
	       ES:DI	  -> R1 (WORD)
	       ES:DI+02h  -> R2 (WORD)
	       ES:DI+04h  -> R3 (WORD)
	       ...
	       ES:DI+0Eh  -> R8 (WORD)
----------6001-------------------------------
INT 60 - SYS_PROF.EXE - TURN PROFILING OFF
	AH = 01h
Note:	SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
SeeAlso: AH=00h"SYS_PROF",02h"SYS_PROF"
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
 01h "BAD_HANDLE"	invalid handle number 
 02h "NO_CLASS"		no interfaces of the specified class found
 03h "NO_TYPE"		no interfaces of the specified type found
 04h "NO_NUMBER"	no interfaces of the specified number found
 05h "BAD_TYPE"		bad packet type
 06h "NO_MULTICAST"	interface does not support multicast messages
 07h "CANT_TERMINATE"	this packet driver cannot terminate
 08h "BAD_MODE"		invalid receiver mode
 09h "NO_SPACE"		insufficient space
 0Ah "TYPE_INUSE"	type accessed but never released
 0Bh "BAD_COMMAND"	bad command
 0Ch "CANT_SEND"	packet could not be sent
 0Dh "CANT_SET"		hardware address could not be changed
 0Eh "BAD_ADDRESS"	hardware address has a bad length or format
 0Fh "CANT_RESET"	could not reset interface

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
	33h Xircom Packet Adapter
	34h Aquila Ethernet
	35h Novell NE1000
	36h Novell NE2000
	37h SMC PC-510
	38h AT&T Fiber NAU
	39h NDIS to Packet Driver adapter
	3Ah Racal-InterLan ES3210
	3Bh General Systems ISDN simulated Ethernet
	3Ch Hewlett-Packard
	3Dh IMC EtherNic-8
	3Eh IMC EtherNic-16
	3Fh IMC EtherNic-MCA
	40h NetWorth EtherNext
	41h Dataco Scanet
	42h DEC DEPCA
	43h C-Net
	44h Gandalf LANLine
	45h Apricot built-in
	46h David Systems Ether-T
	47h ODI to Packet Driver adapter
	48h AMD Am21110-16
	49h Intel ICD Network controller family
	4Ah Intel ICD PCL2
	4Bh Intel ICD PCL2A
	4Ch AT&T LANPacer
	4Dh AT&T LANPacer+
	4Eh AT&T EVB
	4Fh AT&T StarStation
	50h SLIP simulated ethernet
	51h Racal-Interlan NIA310
	52h Racal-Interlan NISE
	53h Racal-Interlan NISE30
	54h Racal-Interlan NI6610
	55h Ethernet over IP/UDP
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
	39h NDIS to Packet Driver adapter
	47h ODI to Packet Driver adapter
    Class 04h  Omninet
    Class 05h  Appletalk
	01h ATALK.SYS adapter
    Class 06h  Serial Line
	01h Clarkson 8250-SLIP
	02h Clarkson "Multiplexor"
    Class 07h  StarLAN (subsumed by Ethernet class)
    Class 08h  ARCnet
	01h Datapoint RIM
    Class 09h  AX.25
	01h Ottawa PI card
    Class 0Ah  KISS
    Class 0Bh  IEEE 802.3 with 802.2 headers
	types same as for class 01h
    Class 0Ch  FDDI with 802.2 headers
	01h Western Digital
	02h Frontier Technology
    Class 0Dh  Internet X.25
	01h Western Digital
	02h Frontier Technology
    Class 0Eh  N.T. LANSTAR (encapsulating DIX Ethernet)
	01h NT LANSTAR/8
	02h NT LANSTAR/MC
    Class 0Fh  SLFP (MIT serial specification)
	01h MERIT
    Class 10h  PPP (Point-to-Point Protocol)

Note: class and type numbers are cleared through FTP Software
----------6002-------------------------------
INT 60 - MDEBUG - SET STATUS
	AH = 02h
	DS:SI -> password or a null byte
	ES = new value for the register SE
	DI = new value for the register OF
	CH = new monitor color if nonzero
	CL = new interpreter color if nonzero
	BH = new monitor start line if nonzero
	BL = new interpreter start line if nonzero
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
			1 invalid interpreter start line
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
	CX = length of type (0000h for all packets)
	ES:DI -> receiver
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
	    AX = handle		
SeeAlso: AH=03h"FTP"

Receiver is called with:
	AX = subfunction
	    00h get packet buffer
		DX = lookahead length (v1.10+)
		DS:SI -> lookahead buffer if DX nonzero (v1.10+)
		DI = error flags (class dependent) (v1.10+)
		Return: ES:DI -> packet buffer
				0000h:0000h means throw away packet
			CX = size of buffer (v1.10+), may be smaller than
				incoming data
	    01h copy completed
		DS:SI -> buffer
		CX = bytes actually copied (v1.10+)
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
	DS:SI -> password or a null byte
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
SeeAlso: AH=03h"MDEBUG",AH=07h"MDEBUG"
----------6004-------------------------------
INT 60 - SYS_PROF.EXE - CLEAR PROFILING TABLE
	AH = 04h
Note:	SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
SeeAlso: AH=03h"SYS_PROF"
----------6005-------------------------------
INT 60 - FTP Packet Driver - BASIC FUNC - TERMINATE DRIVER FOR HANDLE
	AH = 05h
	BX = handle (optional for v1.10+)
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
	BX = handle (optional for v1.10+)
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
	BX = handle (optional for v1.10+)
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
----------6007-------------------------------
INT 60 - MDEBUG v1.70+ - GET ACTIVE PART OF MDEBUG
	AH = 07h
Return: AL = active part for the next popup session of MDEBUG:
	    bit 0: the next popup session will start in the interpreter rather
	     		than in the monitor
	    bit 1: the next popup session will sart in the online-help
SeeAlso: AH=03h"MDEBUG",AH=04h"MDEBUG"
----------6008-------------------------------
INT 60 - MDEBUG - UNUSED
	AH = 08h-FFh
Return: AX = FFFCh
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
INT 60 - FTP Packet Driver 1.09 - HIGH-PERF FUNC - ASYNCHRONOUS SEND PACKET
	AH = 0Bh
	DS:SI -> buffer
	CX = length of buffer
	ES:DI -> FAR function to call when buffer becomes available
Return: CF set on error
	    DH = error code (0Bh,0Ch) (see AX=01FFh)
	CF clear if successful
Notes:	unlike function 04h, the buffer is not available for modification as
	  soon as the call returns; the buffer may be queued by the driver and
	  not processed until later
	this function has been dropped from v1.10+ of the specification and
	  replaced by function 0Ch
SeeAlso: AH=04h"Packet Driver",AH=0Ch"Packet Driver"

Completion function called with:
	AX = result
	    00h copy OK
	    nonzero error
	ES:DI -> buffer passed to INT 60/AH=0Bh call
----------600C-------------------------------
INT 60 - FTP Packet Driver 1.10+ - HIGH-PERF FUNC - ASYNCHRONOUS SEND PACKET
	AH = 0Ch
	ES:DI -> pointer to IOCB
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
SeeAlso: AH=04h"Packet Driver",AH=09h"Packet Driver"

Format of IOCB:
Offset	Size	Description
 00h	DWORD	pointer to buffer
 04h	WORD	length of buffer
 06h	BYTE	flags
		bit 0: packet driver is finished with IOCB
		bit 1: application requests upcall when driver completes
 07h	DWORD	function address for upcall
 0Bh  4 BYTEs	future gather write
 0Fh	BYTE	???
 10h  8 BYTEs	private driver workspace

Completion function called with:
	ES:DI -> IOCB passed to INT 60/AH=0Ch
----------600C-------------------------------
INT 60 - Banyan VINES, 3com - GET STATION ADDRESS
	AH = 0Ch
Return: AL = status
	    00h successful
		ES:SI -> 6-byte station address
	    02h semaphore service is unavailable
----------600D-------------------------------
INT 60 - FTP Packet Driver 1.10+ - HIGH-PERF FUNC - DROP PACKET FROM QUEUE
	AH = 0Dh
	ES:DI -> IOCB
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
SeeAlso: AH=0Ch"Packet Driver"
----------6011-------------------------------
INT 60 - 3com, 10-NET, Banyan VINES - LOCK AND WAIT
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
INT 60 - 3com, 10-NET, Banyan VINES - LOCK
	AH = 12h
	AL = drive number or 00h
	ES:SI = Ethernet address or 0000h:0000h
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see also AH=11h)
	    01h semaphore currently locked by another PC
Note:	unlike function 11h, this function returns immediately
SeeAlso: AH=11h,AH=13h
----------6013-------------------------------
INT 60 - 3com, 10-NET, Banyan VINES - UNLOCK
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
	BX = handle (optional for v1.10+)
	CX = mode
	    01h turn off receiver
	    02h receive only packets sent to this interface
	    03h mode 2 plus broadcast packets
	    04h mode 3 plus limited multicast packets
	    05h mode 3 plus all multicast packets
	    06h all packets
	    07h raw mode for serial line only (v1.10+)
Return: CF set on error
	   DH = error code (01h,08h) (see AX=01FFh)
	CF clear if successful
SeeAlso: AH=15h
----------6015-------------------------------
INT 60 - FTP Packet Driver - EXTENDED FUNC - GET RECEIVE MODE
	AH = 15h
	BX = handle (optional for v1.10+)
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
SeeAlso: AH=17h
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
	BX = handle (optional for v1.10+)
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
----------601A-------------------------------
INT 60 - FTP Packet Driver v1.10+ - EXTENDED FUNC - SEND RAW BYTES
	AH = 1Ah
	DS:SI -> buffer
	CX = length of buffer
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
SeeAlso: AH=1Ch
----------601B-------------------------------
INT 60 - FTP Packet Driver v1.10+ - EXTENDED FUNC - FLUSH RAW BYTES RECEIVED
	AH = 1Bh
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
SeeAlso: AH=1Ch
----------601C-------------------------------
INT 60 - FTP Packet Driver v1.10+ - EXTENDED FUNC - FETCH RAW BYTES RECEIVED
	AH = 1Ch
	DS:SI -> buffer
	CX = length of buffer
	DX = timeout in clock ticks
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
	    CX = number of bytes transferred to buffer
SeeAlso: AH=1Ah,AH=1Bh
----------60AD-------------------------------
INT 60 - AccessDOS - API
	AH = ADh
	AL = function
	    E1h ???
		Return: AX = ???
	    E2h get configuration
		Return: BX:AX -> configuration data
Notes:	AccessDOS is a public domain TSR developed at The Trace Research and
	  Development Center which provides extensions for keyboard, mouse,
	  and sound access by the visually, hearing, or motor-control
	  impaired.
	INT 60 is the default vector; AccessDOS will use the first 0000h:0000h
	  vector in the range 60h through 66h.
----------61---------------------------------
INT 61 - reserved for user interrupt
----------61---------------------------------
INT 61 - Atari Portfolio - EXTENDED BIOS
   provides subfunctions such as turning off the machine, accessing internal
   variables, and mapping memory cards
SeeAlso: INT 60"Atari"
----------61---------------------------------
INT 61 - HP 95LX System Manager - LOAD DS
SeeAlso: INT 0F"HP 95LX",INT 60"HP 95LX"
----------61---------------------------------
INT 61 - JPI TopSPEED Modula-2 v1 - PROCEDURE EXIT TRAP
SeeAlso: INT 61"JPI"
----------61---------------------------------
INT 61 - FTP Software PC/TCP - TCP/IP TSR System Call interface
	AH = system call number
Return: AL = basic error
	AH = suberror number
----------61---------------------------------
INT 61 - Adaptec and OMTI controllers - DRIVE 0 DATA
Note:	this vector stores the second four bytes of the parameter table for
	  hard disk 0
SeeAlso: INT 60"Adaptec",INT 62"Adaptec",INT 63"Adaptec"
----------61---------------------------------
INT 61 - Sangoma CCIP (CCPOP 3270 resident module) INTERFACE
	BX:DX -> control block
SeeAlso: INT 67"Sangoma"
----------61---------------------------------
INT 61 - VIRUS - "SEMTEX"/"Screen Trasher" - INT 21h SUBSTITUTE
Note:	the virus copies the original INT 21h vector into INT 61h
SeeAlso: INT 21h,INT 60"VIRUS",INT 6B"VIRUS"
----------610000-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync - ZOOM DISPLAY
	AX = 0000h
	BX = zoom factor (0-7)
Notes:	zooms the display based on the given zoom factor
	INT 61h is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
SeeAlso: INT 16/AH=FFh"OPTIMA",INT 61/AX=0001h"OPTIMA",INT 61/AX=0002h"OPTIMA"
SeeAlso: INT 61/AX=0005h"OPTIMA"
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
----------610001-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync - CENTER ZOOM WINDOW
	AX = 0001h
	BX = X coordinate to center
	CX = Y coordinate to center
Notes:	Positions the zoom window such that the specified window-relative
	  coordinates appear as close as possible to the center of the
	  display.  Useful for scrolling and panning.
	INT 61h is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
SeeAlso: INT 16/AH=FFh"OPTIMA",INT 61/AX=0000h"OPTIMA",INT 61/AX=0002h"OPTIMA"
SeeAlso: INT 61/AX=0005h"OPTIMA"
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
----------610002-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync - END ZOOM
	AX = 0002h
Note:	switches off zoom and returns window to its original state
	INT 61h is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
SeeAlso: INT 16/AH=FFh"OPTIMA",INT 61/AX=0000h"OPTIMA"
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
		000Eh host wants file transferred to/from PC
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
----------610003-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync - REPORT ZOOM FACTOR
	AX = 0003h
Return: AX = zoom factor
Note:	returns the current zoom factor
	INT 61h is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
SeeAlso: INT 16/AH=FFh"OPTIMA",INT 61/AX=0000h"OPTIMA",INT 61/AX=0005h"OPTIMA"
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
----------610004-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync - ENTER SPECIFY MODE
	AX = 0004h
Note:	Specify Mode is enabled by hot key (seeAlso below), and allows
	panning and zooming via the numeric keypad.
	INT 61h is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
	The Zoom interrupt no. can be obtained with function INT 16h,AH=0FFh
SeeAlso: INT 16/AH=FFh"OPTIMA",INT 61/AX=0000h"OPTIMA",INT 61/AX=0007h"OPTIMA"
----------610005-----------------------------
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
----------610005-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync - QUERY ZOOM WINDOW
	AX = 0005h
	BX:CX -> buffer for window parameters (see below)
Note:	INT 61h is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
SeeAlso: INT 16/AH=FFh"OPTIMA",INT 61/AX=0000h"OPTIMA",INT 61/AX=0003h"OPTIMA"
SeeAlso: INT 61/AX=0006h"OPTIMA"

Format of window parameters:
Offset	Size	Description
 00h	WORD	X start of zoom window
 02h	WORD	Y start of zoom window
 04h	WORD	X end of zoom window
 06h	WORD	Y end of zoom window
 08h	WORD	current zoom factor
 0Ah	WORD	zoom offset start X
 0Ch	WORD	zoom offset start Y
----------610006-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync - SET ZOOM WINDOW
	AX = 0006h
	BX:CX -> zoom window description (see below)
Notes:	width of zoom window must be a multiple of the pixel replication
	  factor
	INT 61h is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
SeeAlso: INT 16/AH=FFh"OPTIMA",INT 61/AX=0000h"OPTIMA",INT 61/AX=0001h"OPTIMA"
SeeAlso: INT 61/AX=0005h"OPTIMA",INT 61/AX=0008h"OPTIMA"

Format of zoom window description:
Offset	Size	Description
 00h	WORD	X start of zoom window
 02h	WORD	Y start of zoom window
 04h	WORD	X end of zoom window
 06h	WORD	Y end of zoom window
----------610007-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync - QUERY APPLICATION KEY
	AX = 0007h
Return: AX = 0000h/0001h
Notes:	In specify mode, the END key has been reserved for applications.
	Returns the current toggle state of that key. E.g. in the
	  OPTIMA AutoCAD driver, 0 means, AutoCAD calls subfunction 0001h
	  every time the cross cursor moves.
	INT 61h is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
SeeAlso: INT 16/AH=FFh"OPTIMA",INT 61/AX=0000h"OPTIMA",INT 61/AX=0001h"OPTIMA"
SeeAlso: INT 61/AX=0004h"OPTIMA",INT 7A"AutoCAD"
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
INT 61 - Banyan VINES - SET PORTS FOR A SERVICE
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
----------610008-----------------------------
INT 61 - OPTIMA 1024 VGA-Sync - SET ZOOM OFFSET
	AX = 0008h
	BX = X start of zoom offset
	CX = Y start of zoom offset
Notes:	specifies the first byte of video memory to appear in the zoom window
	INT 61h is the default interrupt; the actual interrupt number can be
	  obtained by calling INT 16/AH=FFh
SeeAlso: INT 16/AH=FFh"OPTIMA",INT 61/AX=0000h"OPTIMA",INT 61/AX=0006h"OPTIMA"
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
	    04h file deflection
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
----------62---------------------------------
INT 62 - reserved for user interrupt
----------62---------------------------------
INT 62 - Adaptec and OMTI controllers - DRIVE 0 DATA
Notes:	this vector stores the third four bytes of the parameter table for
	  hard disk 0
SeeAlso: INT 60"Adaptec",INT 61"Adaptec",INT 63"Adaptec"
----------62---------------------------------
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
SeeAlso: AH=01h,AH=06h,AH=08h"Cswitch"
----------6206-------------------------------
INT 62 - Cswitch - SUSPEND
	AH = 06h
SeeAlso: AH=05h,AH=08h"Cswitch"
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
----------6208--CXFFFE-----------------------
INT 62 - MS SQL Server/Sybase DBLIBRARY interface - UNINSTALL/GET PSP ADDR
	AH = 08h
	CX = FFFEh
	DX = FFFFh
Return: AX = PSP address of resident DBLIBRARY
Note:	this call does not free the memory allocated to the TSR; the calling
	  code must do the deallocation.
SeeAlso: INT 62"DBLIBRARY"
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
----------6247-------------------------------
INT 62 - PC Tools 7 COMMUTE - ???
	AH = 47h
	AL = subfunction (00h-31h)
	???
	CF set
Return: ???
----------6248-------------------------------
INT 62 - PC Tools 7 COMMUTE - ???
	AH = 48h
	AL = ???
	???
	CF set
Return: ???
----------6249-------------------------------
INT 62 - PC Tools 7 COMMUTE - ???
	AH = 49h
	???
	CF set
Return: ???
Note:	may be the same as AH=4Ch
----------624A-------------------------------
INT 62 - PC Tools 7 COMMUTE - ???
	AH = 4Ah
	AL = subfunction (00h-46h)
	???
	CF set
Return: ???
----------624B--BX1234-----------------------
INT 62 - PC Tools 7 COMMUTE - ???
	AH = 4Bh
	BX = 1234h
	CX = 1234h
	ES = ???
	CF set
Return: ???
----------624C-------------------------------
INT 62 - PC Tools 7 COMMUTE - ???
	AH = 4Ch
	BL = subfunction
	    00h ???
	    02h ???
Return: CF clear if successful
	CF set on error
----------626262-----------------------------
INT 62 - PC Tools 7 COMMUTE - INSTALLATION CHECK
	AX = 6262h
	CF set
Return: AX = 0000h
	BX = segment of resident code's PSP
----------63---------------------------------
INT 63 - reserved for user interrupt
----------63---------------------------------
INT 63 - Adaptec and OMTI controllers - DRIVE 0 DATA
Notes:	this vector stores the last four bytes of the parameter table for
	  hard disk 0
SeeAlso: INT 60"Adaptec",INT 61"Adaptec",INT 62"Adaptec",INT 64"Adaptec"
----------63---------------------------------
INT 63 - Oracle SQL Protected Mode Executive - ???
----------63---------------------------------
INT 63 - 4+Power FLOPPY CONTROLLER - ORIGINAL INT 13/40
   the "4+Power" quad floppy controller BIOS hooks INT 13 (or INT 40 if INT 13
   has been moved there) and places the old value here
----------63---------------------------------
INT 63 - Kofax KF9X00 image manipulation card interface
----------64---------------------------------
INT 64 - reserved for user interrupt
----------64---------------------------------
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
----------64---------------------------------
INT 64 - Novell NetWare to v2.0a - LOW-LEVEL API
Note:	equivalent to INT 7A for NetWare versions through 2.0a only; later
	  versions do not use this interrupt for IPX/SPX access, instead
	  getting an entry point from INT 2F/AX=7A00h
SeeAlso: INT 2F/AX=7A00h,INT 7A"Novell"
----------64---------------------------------
INT 64 - Data General DG10 - MicroECLIPSE COPROCESSOR INTERFACE
SeeAlso: INT 65"DG10",INT 66"DG10"
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
----------64---------------------------------
INT 64 - Pdisk by Scott Garfinkle - Overwritten for Hard Drive information
Note:   This vector is overwritten by Pdisk to install custom harddrive types.
          It can either destroy 4 vectors and take no memory or TSR and take
          up some memory.
SeeAlso: INT 65"Pdisk"
----------65---------------------------------
INT 65 - reserved for user interrupt
----------65---------------------------------
INT 65 - Adaptec controllers - DRIVE 1 DATA
Note:	this vector stores the second four bytes of the parameter table for
	  hard disk 1
SeeAlso: INT 64"Adaptec",INT 66"Adaptec",INT 67"Adaptec"
----------65---------------------------------
INT 65 - Data General DG10 - MicroECLIPSE COPROCESSOR INTERFACE
SeeAlso: INT 64"DG10",INT 66"DG10"
----------65---------------------------------
INT 65 - FTP Software NDIS-Packet Driver adapter - POST PROCESSING INTERRUPT
----------65---------------------------------
INT 65 - SD.COM v6.2
   The unregistered version of SD62.COM uses the low byte of this vector to
   count the number of invocations, displaying a registration reminder each
   time after the 20th use.
----------65---------------------------------
INT 65 - Pdisk by Scott Garfinkle - Overwritten for Hard Drive information
SeeAlso: INT 64"Pdisk",INT 66"Pdisk"
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
Note:	this vector stores the third four bytes of the parameter table for
	  hard disk 1
SeeAlso: INT 64"Adaptec",INT 65"Adaptec",INT 67"Adaptec"
----------66---------------------------------
INT 66 - Data General DG10 - MicroECLIPSE COPROCESSOR INTERFACE
SeeAlso: INT 64"DG10"
----------66---------------------------------
INT 66 - Nanosoft, Inc. TurboNET - NETWORK PROCESSING ???
Notes:	hooked but not used (IRET) by both redirector and server; called from
	  server's INT 28 handler
	TurboNET is a NetBIOS-based file redirector and server
SeeAlso: INT 2F/AX=8100h
----------66---------------------------------
INT 66 - Pdisk by Scott Garfinkle - Overwritten for Hard Drive information
SeeAlso: INT 64"Pdisk",INT 67"Pdisk"
----------66---------------------------------
INT 66 - Microsoft Windows VITD.386 Virtual Interval Timer
Note:	This Windows 3.x Virtual Device Driver implements a virtual timer
	  which will expire and call INT 66.  This timer can be used to
	  calculate elapsed execution time etc.
----------66FFFBBXFFFB-----------------------
INT 66 - MicroHelp Stay-Res Plus - ???
	AX = FFFBh
	BX = FFFBh
	???
Return: ???
SeeAlso: AX=FFFEh,INT 2D"AMIS"
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
SeeAlso: AX=FFFBh,AX=FFFFh,INT 2D"AMIS"
----------66FFFFBXFFF0-----------------------
INT 66 - MicroHelp Stay-Res Plus - FIND PROGRAM NAME
	AX = FFFFh
	BX = FFF0h
Return: DI = offset of program name in interrupt handler segment
SeeAlso: AX=FFFBh,AX=FFFEh,INT 2D"AMIS"
----------660688-----------------------------
INT 66 - John W. Ratcliff (The IBM Digitized Sound Package)
	AX = 0688h
	???
Return: ???
SeeAlso: AX=0689h
----------660689-----------------------------
INT 66 - John W. Ratcliff (The IBM Digitized Sound Package)
	AX = 0689h
	???
Return: ???
SeeAlso: AX=0688h
----------663345-----------------------------
INT 66 - BitFax Scheduler - REMOVE TSR FROM MEMORY
	AX = 3345h
Return: AX = FFFFh error removing TSR
Note:	the installation check consists of checking for the signature
	  "BitFax Scheduler" beginning two bytes past the interrupt handler
SeeAlso: INT 2F/AH=2Ah,INT 2F/AX=CB00h
----------67---------------------------------
INT 67 - Adaptec controllers - DRIVE 1 DATA
Note:	this vector stores the last four bytes of the parameter table for
	  hard disk 1
SeeAlso: INT 64"Adaptec",INT 65"Adaptec",INT 66"Adaptec"
----------67---------------------------------
INT 67 - Pdisk by Scott Garfinkle - Overwritten for Hard Drive information
SeeAlso: INT 64"Pdisk",INT 66"Pdisk"
----------67---------------------------------
INT 67 - Sangoma CCPOP 3270 resident module
SeeAlso: INT 61"Sangoma",INT 68"Sangoma"
----------67---------------------------------
INT 67 - CUCKOO.COM - INSTALLATION CHECK
Notes:	this is not a vector; when loaded for the first time, CUCKOO.COM uses
	  the last unused (0000h:0000h) vector in the range 60h-67h to store
	  the signature value 434Ch:4F4Bh ('CLOK')
	CUCKOO is a resident on-screen clock with optional hourly chime or
	  cuckoo by an unknown author with revisions by Thomas A. Lundin
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
SeeAlso: AH=01h,AH=02h"PC-NET",INT 7F/AH=00h
----------6701-------------------------------
INT 67 - PC-NET, Alloy NTNX - LOCK SEMAPHORE
	AH = 01h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see AH=00h)
	AH = semaphore owner if status=02h
SeeAlso: AH=00h,AH=02h"PC-NET",INT 7F/AH=01h"Alloy"
----------6702-------------------------------
INT 67 - PC-NET, Alloy NTNX - UNLOCK SEMAPHORE
	AH = 02h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see AH=00h)
	AH = semaphore owner if status=02h
SeeAlso: AH=00h,AH=01h"PC-NET",INT 7F/AH=02h
----------673F--CX5145-----------------------
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
		  	only supports functions	0Ch, 1004h, 1005h, and 100Ah
	the string check mentioned above is not supported by 386MAX
SeeAlso: AH=DDh,AX=5BF0h,AX=FFA5h,INT 15/AX=11DEh,INT 21/AX=4402h"QEMM"
SeeAlso: INT 21/AX=4402h"386MAX",INT 2F/AX=D201h/BX=5145h

Call QEMM entry point with:
	AH = 00h get QEMM state
		Return: CF clear
			AL = QEMM state
			    bit 0 set if QEMM turned OFF
			    bit 1 set if in "Auto" mode
	AH = 01h set QEMM state
		AL = new state
		    bit 0 set: place QEMM in OFF state
		Return: CF clear if successful
			CF set on error
	AH = 02h get ???
		Return: CF clear
			AX = segment of ??? data structure
			Data Structure
			Offset	Size	Description
			 00h	BYTE	???
			 01h	WORD	???
			 	???
	AH = 03h get QEMM version
		Return: CF clear
			AX = BX = version in BCD
		Notes:	the official docs only state that the version is
			  returned in BX
			MICEMM returns AX=0001h, BX unchanged
	AH = 04h set AUTO/ON mode???
		Return: CF clear if successful
			    DX = page number of a 4K page
			CF set if unable to allocate page
		Note:	QEMM mode unchanged if not AUTO/OFF
	AH = 05h set AUTO/OFF mode???
		DX = page number returned by function 04h
		Return: CF clear
		Note:	QEMM mode unchanged if not AUTO/ON
	AH = 06h set mapping context???
		DX = page table number???
		Return: CF clear
	AH = 07h get mapping context???
		Return: CF clear
			DX = page table number???
	AH = 08h ???
		DX = linear page number
		Return: CF clear
	AH = 09h get linear page number for page table entry
		CX = page table index
		Return: CF clear
			DX = linear page number
	AH = 0Ah set linear page number for page table entry
		CX = page table index
		DX = linear page number
		Return: CF clear
	AH = 0Bh map 4K pages???
		BX = number of pages???
		CX = first page number??? (must be 0100h to allocate HMA)
		DX = EMS handle???
		Return: AH = 00h
	AH = 0Ch get ???
		Return: CF clear
			BX = 0001h
			CX = ???
			DX = number of 4K pages free
	AH = 0Dh ???
		AL = zero/nonzero ???
		Return: CF clear
	AH = 0Eh set ??? callbacks
		DS:BX -> FAR routine for ???
		ES:DX -> FAR routine for ???
		Return: CF clear
		Note:	DS:BX callback should return BX=???; ES:DX is called
			  with BX=???, and should set the ??? from which the
			  other handler read the value of BX.  BH and BL
			  appear to be separate values.
	AH = 0Fh unmap 4K pages???
		CX = first page number (must be 0100h to free HMA)
		DX = number of pages??? (must be 0010h to free HMA)
		Return: AL = 00h/01h if ???
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
			BL = ???
			ES:DI buffer filled
	AX = 1002h set CPU debug registers
		BL = ???
		ES:DI -> buffer containing debug registers (8 DWORDs)
		Return: CF clear
		Note:	identical to INT 67/AX=DE09h if BL=01h
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
		AL = zero/nonzero ???
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
		???
		Return: CF clear
			???
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution; also modifies CRT controller during
			  execution under certain circumstances
	AX = 1303h ??? EMS allocation
		BX = number of pages of EMS to allocate
		???
		Return: CF clear if successful
			CF set on error
			???
	AX = 1304h EMS deallocation
		DX = EMS handle
		Return: CF clear
	AX = 1305h ???
		CX = ???
		Return: CF clear
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution (see AX=130Ch)
	AX = 1306h set critical section counter address???
		ES:BX -> WORD QEMM critical section counter??? or 0000h:0000h
		Return: CF clear
		Note:	also sets pointer in low-memory part of QEMM to current
			  value of INT 15 if ES:BX not 0000h:0000h
	AX = 1307h ???
		???
		Return: CF clear
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution (see AX=130Ch)
	AX = 1308h ???
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
		BL = ???
		Return: CF clear
			???
	AX = 130Ch set interrupts to mask
		BX = interrupts to mask out during AX=1302h,AX=1307h,AX=1308h,
			AX=130Dh,AX=1310h (BL = master PIC, BH = slave PIC)
		Return: CF clear
	AX = 130Dh ???
		???
		Return: CF clear
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution (see AX=130Ch)
	AX = 130Eh ??? (modifies CRT controller setup)
		???
		Return: CF clear
	AX = 130Fh reset ???
		Return: CF clear
	AX = 1310h ???
		???
		Return: CF clear
		Note:	disables certain interrupts at the two 8259 PICs during
			  execution (see AX=130Ch)
	AX = 1311h set ???
		BL = ???
		Return: CF clear
	AX = 1400h ???
		ES:DI -> ??? data structure (at least 24 bytes)
		BL = ???
		Return: AX = ???
		Data structure
		Offset	Size	Description
		 00h  	WORD	???
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
		 0Ch
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
			SI = ???
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
	AH = 1Bh MS Windows 3 support
		AL = subfunction
		    00h get ???
			ES:DI -> buffer for ??? data structure
			Return: CF set on error
				CF clear if successful
			Data structure:
			Offset	Size	Description
			 00h	DWORD	pointer to ???
			 04h	BYTE	??? (v6.00 sets to 01h)
			 05h	BYTE	??? (v6.00 sets to 00h or 0Bh)
			SeeAlso: INT 21/AX=4402h"QEMM"
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
		    07h BUG: QEMM 6.00 will accept this and branch randomly
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
			for AL=04h-2Ah
     ---QEMM v6.00+ ---
	AH = 1Dh Stealth interrupts
		AL = subfunction
		    00h switch to pre-Stealth interrupt vector table
		    	Note:	also switches VGA Save table pointer
				  (0040h:00A8h)	and overwrites the vectors
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
	AH = 1Eh Stealth information
		AL = subfunction
		    00h get Stealth configuration
			Return: BL = flags
				    bit 0: conventional memory sorted
				    bit 1: conventional memory filled
				    bit 2: ???
				    bit 3: ???
				    bit 4: expanded memory is in use
				    bit 5: ???
				BH = ??? (always 00h for v6.00)
				CL = stealth type (00h none,46h Frame,4Dh Map)
				CH = ??? (zero/nonzero important)
				DX = ??? (always 0000h for v6.00)
				SI = ??? (always 0000h for v6.00)
				DI = ??? (always 0000h for v6.00)
		    01h get number of Stealth'ed ROMs
			Return: CF clear
				BX = number of Stealth'ed ROMs
		    02h get Stealth'ed ROM info
		    	ES:DI -> buffer for Stealth ROM info (see below)
			Return: CF clear
				BX = number of Stealth'ed ROMs
				ES:DI buffer filled
		    else
			Return: CF set
	AH = 1Fh page table manipulation
		AL = subfunction
		    00h get page table entry
			CX = page number
			Return: EDX = page table entry
				CF clear
		    01h set page table entry
			CX = page number
			EDX = page table entry
			Return: CF clear
			SeeAlso: function 1008h
		    else
			Return: CF set
	AH = 20h asynchronous disk access support???
		AL = subfunction
		    00h get ???
			Return: CF clear
				BL = flags
				    bit 7: ??? (set if Stealth:F or :M active)
				    bit 0: ???
		    01h set ???
			BL = ??? (bit 0 only)
			Return: CF clear
		    else
			Return: CF set
	AH = 21h Stealth support
		AL = subfunction
		    00h copy data from Stealthed address space
			DS:SI -> start address of hidden memory to copy
			ES:DI -> buffer for copied data
			ECX = number of bytes to copy
			Return: CF clear if successful
				CF set on error (DS:SI < C000h:0000h or
						 DS:SI + ECX > 1M)
		    else
			Return: CF set
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
SeeAlso: AH=3Fh,AX=FFA5h
----------6741-------------------------------
INT 67 - LIM EMS - GET PAGE FRAME SEGMENT
	AH = 41h
Return: AH = 00h function successful
	    BX = segment of page frame
	AH = error code (see AH=40h)
SeeAlso: AH=58h,AH=68h
----------6742-------------------------------
INT 67 - LIM EMS - GET NUMBER OF PAGES
	AH = 42h
Return: AH = 00h function successful
	    BX = number of unallocated pages
	    DX = total number of pages
	AH = error code (see AH=40h)
SeeAlso: INT 2F/AX=2702h
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
SeeAlso: AH=48h
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
	       ES:DI -> 8-byte buffer for handle name
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
	       ES:DI -> buffer for handle directory (see below)
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

Format of handle directory entry:
Offset	Size	Description
 00h	WORD	handle
 02h  8 BYTEs	handle's name
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
----------675BE0-----------------------------
INT 67 - MICEMM v4D - GET LINEAR ADDRESS OF MEMORY
	AX = 5BE0h
	ES:BX -> memory for which to get linear address
Return: AH = 00h
	DX:CX = linear address of physical memory corresponding to ES:BX
SeeAlso: AX=5BF0h,AX=5BF1h
----------675BF0-----------------------------
INT 67 - MICEMM v4D - INSTALLATION CHECK
	AX = 5BF0h
Return: AH = 00h if MICEMM present
	    BX = code segment of driver
Note:	MICEMM is the Micronics Expanded Memory Manager
SeeAlso: AH=3Fh,AX=5BE0h,AX=5BF1h
----------675BF1-----------------------------
INT 67 - MICEMM v4D - GET MEMORY TYPES
	AX = 5BF1h
	ES:BX -> 256-byte buffer for memory types
Return: AH = 00h
	ES:BX buffer filled
Note:	each byte in the buffer specifies the type of a 4K page of memory:
	    00h unused
	    02h DOS extension
	    04h shadowed ROM
	    08h mappable EMS
	    10h page frame
	    20h ROM
	    40h reserved (video memory, etc)
	    80h RAM
SeeAlso: AX=5BE0h,AX=5BF0h
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
----------67DD-------------------------------
INT 67 - Quadtel QMAPS - API
	AH = DDh
	AL = function
	???
Return: ???
Notes:	details are not yet available
	Hewlett-Packard's HPMM.SYS is a licensed version of QMAPS, and thus
	  supports this API
SeeAlso: AH=3Fh,AX=FFA5h
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
SeeAlso: INT 67/AH=3Fh
----------67DE02-----------------------------
INT 67 - Virtual Control Program Interface - GET MAX PHYSICAL MEMORY ADDRESS
	AX = DE02h
Return: AH = 00h  successful
	    EDX = physical address of highest 4K memory page
	AH nonzero: failed
SeeAlso: AH=3Fh
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
SeeAlso: AH=3Fh,AX=DE03h,AX=DE05h
----------67DE05-----------------------------
INT 67 - Virtual Control Program Interface - FREE 4K PAGE
	AX = DE05h
	EDX = physical address of 4K page
Return: AH = 00h successful
	AH nonzero: failed
Note:	also available in protected mode by calling the protected-mode VCPI
	  entry point
SeeAlso: AH=3Fh,AX=DE04h
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
SeeAlso: AH=3Fh,AX=DE07h
----------67DE08-----------------------------
INT 67 - Virtual Control Program Interface - READ DEBUG REGISTERS
	AX = DE08h
	ES:DI -> array of 8 DWORDs
Return: AH = 00h
	buffer filled with DR0 first, DR7 last, DR4 and DR5 unused
SeeAlso: AH=3Fh,AX=DE09h
----------67DE09-----------------------------
INT 67 - Virtual Control Program Interface - SET DEBUG REGISTERS
	AX = DE09h
	ES:DI -> array of 8 DWORDs holding new values of debug registers
Return: AH = 00h
Note:	values for DR4 and DR5 ignored
SeeAlso: AH=3Fh,AX=DE08h
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
SeeAlso: AH=3Fh,INT 15/AH=89h

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
----------67FFA5-----------------------------
INT 67 - Microsoft EMM386.EXE v4.20+ - INSTALLATION CHECK
	AX = FFA5h
Return: AX = 845Ah if loaded
	    BX:CX -> API entry point
Notes:	this call is available even if EMM386 is not providing EMS
	if no other program has hooked INT 67, an alternate installation
	  check is to search for the string
	  "MICROSOFT EXPANDED MEMORY MANAGER 386" early in the INT 67
	  handler's segment, usually at offset 14h
SeeAlso: AH=3Fh

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
---------------------------------------------
