Interrupt List, part 3 of 6
This compilation is Copyright (c) 1989,1990,1991,1992 Ralf Brown
----------20---------------------------------
INT 20 - Minix - SEND/RECEIVE MESSAGE
	AX = process ID of other process
	BX -> message
	CX = 1 send
	     2 receive
	     3 send&receive
Note:	the message contains the system call number (numbered as in V7 
	  Unix(tm)) and the call parameters
----------20---------------------------------
INT 20 - DOS 1+ - TERMINATE PROGRAM
	CS = PSP segment
Return: never
Note:	(see notes for INT 21/AH=00h)
SeeAlso: INT 21/AH=00h,INT 21/AH=4Ch
----------2100-------------------------------
INT 21 - DOS 1+ - TERMINATE PROGRAM
	AH = 00h
	CS = PSP segment
Notes:	Microsoft recomments using INT 21/AH=4Ch for DOS 2+
	execution continues at address stored in INT 22 after DOS performs
	  whatever cleanup it needs to do
	if the PSP is its own parent, the process's memory is not freed; if
	  INT 22 additionally points into the terminating program, the
	  process is effectively NOT terminated
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=26h,AH=31h,AH=4Ch,INT 20,INT 22
----------2101-------------------------------
INT 21 - DOS 1+ - READ CHARACTER FROM STANDARD INPUT, WITH ECHO
	AH = 01h
Return: AL = character read
Notes:	^C/^Break are checked, and INT 23 executed if read
	character is echoed to standard output
	standard input is always the keyboard and standard output the screen
	  under DOS 1.x, but they may be redirected under DOS 2+
SeeAlso: AH=06h,AH=07h,AH=08h,AH=0Ah
----------2102-------------------------------
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
----------2103-------------------------------
INT 21 - DOS 1+ - READ CHARACTER FROM STDAUX
	AH = 03h
Return: AL = character read
Notes:	keyboard checked for ^C/^Break, and INT 23 executed if detected
	STDAUX is usually the first serial port
SeeAlso: AH=04h,INT 14/AH=02h
----------2104-------------------------------
INT 21 - DOS 1+ - WRITE CHARACTER TO STDAUX
	AH = 04h
	DL = character to write
Notes:	keyboard checked for ^C/^Break, and INT 23 executed if detected
	STDAUX is usually the first serial port
	if STDAUX is busy, this function will wait until it becomes free
SeeAlso: AH=03h,INT 14/AH=01h
----------2105-------------------------------
INT 21 - DOS 1+ - WRITE CHARACTER TO PRINTER
	AH = 05h
	DL = character to print
Notes:	keyboard checked for ^C/^Break, and INT 23 executed if detected
	STDPRN is usually the first parallel port, but may be redirected under
	  DOS 2+
	if the printer is busy, this function will wait
SeeAlso: INT 17/AH=00h
----------2106-------------------------------
INT 21 - DOS 1+ - DIRECT CONSOLE OUTPUT
	AH = 06h
	DL = character (except FFh)
Return: AL = character output (despite official docs which state nothing is
		returned) (at least DOS 3.3-5.0)
Notes:	does not check ^C/^Break
	writes to standard output, which is always the screen under DOS 1.x,
	  but may be redirected under DOS 2+
SeeAlso: AH=02h,AH=09h
----------2106--DLFF-------------------------
INT 21 - DOS 1+ - DIRECT CONSOLE INPUT
	AH = 06h
	DL = FFh
Return: ZF set if no character available
	ZF clear if character available
	    AL = character read
Notes:	^C/^Break are NOT checked
	if the returned character is 00h, the user pressed a key with an
	  extended keycode, which will be returned by the next call of this
	  function
	reads from standard input, which is always the keyboard under DOS 1.x,
	  but may be redirected under DOS 2+
SeeAlso: AH=0Bh
----------2107-------------------------------
INT 21 - DOS 1+ - DIRECT CHARACTER INPUT, WITHOUT ECHO
	AH = 07h
Return: AL = character read from standard input
Notes:	does not check ^C/^Break
	standard input is always the keyboard under DOS 1.x, but may be
	  redirected under DOS 2+
	if the interim console flag is set (see AX=6301h), partially-formed
	  double-byte characters may be returned
SeeAlso: AH=01h,AH=06h,AH=08h,AH=0Ah
----------2108-------------------------------
INT 21 - DOS 1+ - CHARACTER INPUT WITHOUT ECHO
	AH = 08h
Return: AL = character read from standard input
Notes:	^C/^Break are checked, and INT 23 executed if detected
	standard input is always the keyboard under DOS 1.x, but may be
	  redirected under DOS 2+
	if the interim console flag is set (see AX=6301h), partially-formed
	  double-byte characters may be returned
SeeAlso: AH=01h,AH=06h,AH=07h,AH=0Ah,AH=64h
----------2109-------------------------------
INT 21 - DOS 1+ - WRITE STRING TO STANDARD OUTPUT
	AH = 09h
	DS:DX -> '$'-terminated string
Return: AL = 24h (the '$' terminating the string, despite official docs which
		state that nothing is returned) (at least DOS 3.3-5.0)
Notes:	^C/^Break checked, and INT 23 called if pressed
	standard output is always the screen under DOS 1.x, but may be
	  redirected under DOS 2+
SeeAlso: AH=02h,AH=06h"OUTPUT"
----------210A-------------------------------
INT 21 - DOS 1+ - BUFFERED INPUT
	AH = 0Ah
	DS:DX -> buffer (see below)
Return: buffer filled with user input
Notes:	^C/^Break checked, and INT 23 called if detected
	reads from standard input, which may be redirected under DOS 2+
	if the maximum buffer size (see below) is set to 00h, this call returns
	  immediately without reading any input
SeeAlso: AH=0Ch,INT 2F/AX=4810h

Format of input buffer:
Offset	Size	Description
 00h	BYTE	maximum characters buffer can hold
 01h	BYTE	(input) number of chars from last input which may be recalled
		(return) number of characters actually read, excluding CR
 02h  N BYTEs	actual characters read, including the final carriage return
----------210A00-----------------------------
INT 21 - WCED v1.6 - INSTALLATION CHECK
	AX = 0A00h
	DS:DX -> 6-byte buffer whose first two bytes must be 00h
Return: buffer offset 02h-05h filled with "Wced" if installed
Note:	WCED is a free command-line editor and history utility by Stuart
	  Russell
SeeAlso: AH=FFh"CED"
----------210B-------------------------------
INT 21 - DOS 1+ - GET STDIN STATUS
	AH = 0Bh
Return: AL = 00h if no character available
	   = FFh if character is available
Notes:	^C/^Break checked, and INT 23 called if pressed
	standard input is always the keyboard under DOS 1.x, but may be
	  redirected under DOS 2+
	if the interim console flag is set (see AX=6301h), this function
	  returns AL=FFh if a partially-formed double-byte character is
	  available
SeeAlso: AH=06h"INPUT",AX=4406h
----------210B56-----------------------------
INT 21 - VIRUS - "Perfume" - INSTALLATION CHECK
	AX = 0B56h
Return: AX = 4952h if resident
SeeAlso: AX=0D20h
----------210C-------------------------------
INT 21 - DOS 1+ - FLUSH BUFFER AND READ STANDARD INPUT
	AH = 0Ch
	AL = STDIN input function to execute after flushing buffer
	other registers as appropriate for the input function
Return: as appropriate for the specified input function
Note:	if AL is not one of 01h,06h,07h,08h, or 0Ah, the buffer is flushed but
	  no input is attempted
SeeAlso: AH=01h,AH=06h"INPUT",AH=07h,AH=08h,AH=0Ah
----------210D-------------------------------
INT 21 - DOS 1+ - DISK RESET
	AH = 0Dh
Notes:	writes all modified disk buffers to disk, but does not update directory
	  information (that is only done when files are closed or a SYNC call
	  is issued)
SeeAlso: AX=5D01h,INT 13/AH=00h,INT 2F/AX=1120h
----------210D20-----------------------------
INT 21 - VIRUS - "Crazy Imp" - INSTALLATION CHECK
	AX = 0D20h
Return: AX = 1971h if resident
SeeAlso: AX=0B56h,AH=30h/DX=ABCDh
----------210E-------------------------------
INT 21 - DOS 1+ - SELECT DEFAULT DRIVE
	AH = 0Eh
	DL = new default drive (00h = A:, 01h = B:, etc)
Return: AL = number of potentially valid drive letters
Notes:	under Novell NetWare, the return value is always 32, the number of
	  drives that NetWare supports
	under DOS 3+, the return value is the greatest of 5, the value of
	  LASTDRIVE= in CONFIG.SYS, and the number of drives actually present
	on a DOS 1.x/2.x single-floppy system, AL returns 2 since the floppy
	  may be accessed as either A: or B:
	otherwise, the return value is the highest drive actually present
	DOS 1.x supports a maximum of 16 drives, 2.x a maximum of 63 drives,
	  and 3+ a maximum of 26 drives
SeeAlso: AH=19h,AH=3Bh,AH=DBh
----------210F-------------------------------
INT 21 - DOS 1+ - OPEN FILE USING FCB
	AH = 0Fh
	DS:DX -> unopened File Control Block (see below)
Return: AL = status
	    00h successful
	    FFh file not found or access denied
Notes:	(DOS 3.1+) file opened for read/write in compatibility mode
	an unopened FCB has the drive, filename, and extension fields filled
	  in and all other bytes cleared
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=10h,AH=16h,AH=3Dh

Format of File Control Block:
Offset	Size	Description
 -7	BYTE	extended FCB if FFh
 -6   5 BYTEs	reserved
 -1	BYTE	file attribute if extended FCB
 00h	BYTE	drive number (0 = default, 1 = A, etc)
 01h  8 BYTEs	blank-padded file name 
 09h  3 BYTEs	blank-padded file extension
 0Ch	WORD	current block number
 0Eh	WORD	logical record size
 10h	DWORD	file size
 14h	WORD	date of last write (see AX=5700h)
 16h	WORD	time of last write (see AX=5700h) (DOS 1.1+)
 18h  8 BYTEs	reserved (see below)
 20h	BYTE	record within current block
 21h	DWORD	random access record number (if record size is > 64 bytes, high
		byte is omitted)
Note:	to use an extended FCB, you must specify the address of the FFh flag at
	  offset -7, rather than the address of the drive number field

Format of reserved field for DOS 1.0:
Offset	Size	Description
 16h	WORD	location in directory (if high byte = FFh, low byte is device
		ID)
 18h	WORD	number of first cluster in file
 1Ah	WORD	last cluster number accessed (absolute)
 1Ch	WORD	relative current cluster number
 1Eh	BYTE	dirty flag (00h = not dirty)
 1Fh	BYTE	unused

Format of reserved field for DOS 1.10-1.25:
Offset	Size	Description
 18h	BYTE	bit 7: set if logical device
		bit 6: not dirty
		bits 5-0: disk number or logical device ID
 19h	WORD	starting cluster number
 1Bh	WORD	absolute current cluster number
 1Dh	WORD	relative current cluster number
 1Fh	BYTE	unused

Format of reserved field for DOS 2.x:
Offset	Size	Description
 18h	BYTE	bit 7: set if logical device
		bit 6: set if open???
		bits 5-0: ???
 19h	WORD	starting cluster number
 1Bh	WORD	???
 1Dh	BYTE	???
 1Eh	BYTE	???
 1Fh	BYTE	???

Format of reserved field for DOS 3.x:
Offset	Size	Description
 18h	BYTE	number of system file table entry for file
 19h	BYTE	attributes
		bits 7,6: 00 = SHARE.EXE not loaded, disk file
			  01 = SHARE.EXE not loaded, character device
			  10 = SHARE.EXE loaded, remote file
			  11 = SHARE.EXE loaded, local file
		bits 5-0: low six bits of device attribute word
---SHARE.EXE loaded, local file---
 1Ah	WORD	starting cluster of file
 1Ch	WORD	offset within SHARE of sharing record (see AH=52h)
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
----------2110-------------------------------
INT 21 - DOS 1+ - CLOSE FILE USING FCB
	AH = 10h
	DS:DX -> File Control Block (see AH=0Fh)
Return: AL = status
	    00h successful
	    FFh failed
Notes:	a successful close forces all disk buffers used by the file to be
	  written and the directory entry to be updated
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=0Fh,AH=16h,AH=3Eh
----------2111-------------------------------
INT 21 - DOS 1+ - FIND FIRST MATCHING FILE USING FCB
	AH = 11h
	DS:DX -> unopened FCB (see AH=0Fh), may contain '?' wildcards
Return: AL = status
	    00h successful
		[DTA] unopened FCB for first matching file
	    FFh no matching filename, or bad FCB
Notes:	the type of the returned FCB depends on whether the input FCB was a
	  normal or an extended FCB
	for extended FCBs with search attribute 08h, the volume label (if any)
	  will be returned even if the current directory is not the root dir.
	DOS 3+ also allows the '*' wildcard
	the search FCB must not be modified if AH=12h will be used to continue
	  searching; DOS 3.3 has set the following parts of the FCB:
		 0Ch	BYTE	???
		 0Dh	WORD	directory entry number of matching file
		 0Fh	WORD	cluster number of current directory
		 11h  4 BYTEs	???
		 15h	BYTE	drive number (1=A:)
	at least for DOS 3.3, the unopened FCB in the DTA is actually the drive
	  number followed by the file's directory entry
SeeAlso: AH=12h,AH=1Ah,AH=4Eh,INT 2F/AX=111Bh
----------2112-------------------------------
INT 21 - DOS 1+ - FIND NEXT MATCHING FILE USING FCB
	AH = 12h
	DS:DX -> unopened FCB (see AH=0Fh)
Return: AL = status
	    00h successful
		[DTA] = unopened FCB
	    FFh no more matching filenames
Note:	(see AH=11h)
	assumes that successful FindFirst executed on search FCB before call
SeeAlso: AH=1Ah,AH=4Fh,INT 2F/AX=111Ch
----------2113-------------------------------
INT 21 - DOS 1+ - DELETE FILE USING FCB
	AH = 13h
	DS:DX -> unopened FCB (see AH=0Fh), filename filled with template for
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
SeeAlso: AH=41h,INT 2F/AX=1113h
----------2114-------------------------------
INT 21 - DOS 1+ - SEQUENTIAL READ FROM FCB FILE
	AH = 14h
	DS:DX -> opened FCB (see AH=0Fh)
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
----------2115-------------------------------
INT 21 - DOS 1+ - SEQUENTIAL WRITE TO FCB FILE
	AH = 15h
	DS:DX -> opened FCB (see AH=0Fh)
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
----------2116-------------------------------
INT 21 - DOS 1+ - CREATE OR TRUNCATE FILE USING FCB
	AH = 16h
	DS:DX -> unopened FCB (see AH=0Fh), wildcards not allowed
Return: AL = status
	    00h successful
	    FFh directory full or file exists and is read-only or locked
Notes:	if file already exists, it is truncated to zero length
	if an extended FCB is used, the file is given the attribute in the
	  FCB
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=0Fh,AH=10h,AH=3Ch
----------2117-------------------------------
INT 21 - DOS 1+ - RENAME FILE USING FCB
	AH = 17h
	DS:DX -> modified FCB (see also AH=0Fh)
		the old filename ('?' wildcards OK) is in the standard location
		while the new filename ('?' wildcards OK) is stored in the 11
		bytes beginning at offset 11h
Return:	AL = status
	    00h successfully renamed
	    FFh no matching files,file is read-only, or new name already exists
Note:	subdirectories may be renamed using an extended FCB with the
	  appropriate attribute
SeeAlso: AH=0Fh,AH=13h,AH=56h,INT 2F/AX=1111h
----------2118-------------------------------
INT 21 - DOS 1+ - NULL FUNCTION FOR CP/M COMPATIBILITY
	AH = 18h
Return: AL = 00h
Note:	corresponds to the CP/M BDOS function "get bit map of logged drives",
	  which is meaningless under MSDOS
SeeAlso: AH=1Dh,AH=1Eh,AH=20h,AX=4459h
----------2119-------------------------------
INT 21 - DOS 1+ - GET CURRENT DEFAULT DRIVE
	AH = 19h
Return: AL = drive (00h = A:, 01h = B:, etc)
SeeAlo: AH=0Eh,AH=47h
----------211A-------------------------------
INT 21 - DOS 1+ - SET DISK TRANSFER AREA ADDRESS
	AH = 1Ah
	DS:DX -> Disk Transfer Area (DTA)
Note:	the DTA is set to PSP:0080h when a program is started
SeeAlso: AH=11h,AH=12h,AH=2Fh,AH=4Eh,AH=4Fh
----------211B-------------------------------
INT 21 - DOS 1+ - GET ALLOCATION INFORMATION FOR DEFAULT DRIVE
	AH = 1Bh
Return: AL = sectors per cluster (allocation unit)
	CX = bytes per sector
	DX = total number of clusters
	DS:BX -> media ID byte (see below)
Note:	under DOS 1.x, DS:BX points at an actual copy of the FAT; later
	  versions return a pointer to a copy of the FAT's ID byte
SeeAlso: AH=1Ch,AH=36h

Values for media ID byte:
 FFh	floppy, double-sided, 8 sectors per track (320K)
 FEh	floppy, single-sided, 8 sectors per track (160K)
 FDh	floppy, double-sided, 9 sectors per track (360K)
 FCh	floppy, single-sided, 9 sectors per track (180K)
 F9h	floppy, double-sided, 15 sectors per track (1.2M)
 F8h	hard disk
 F0h	other
----------211C-------------------------------
INT 21 - DOS 1+ - GET ALLOCATION INFORMATION FOR SPECIFIC DRIVE
	AH = 1Ch
	DL = drive (00h = default, 01h = A:, etc)
Return: AL = sectors per cluster (allocation unit)
	CX = bytes per sector
	DX = total number of clusters
	DS:BX -> media ID byte (see AH=1Bh)
Note:	under DOS 1.x, DS:BX points at an actual copy of the FAT; later
	  versions return a pointer to a copy of the FAT's ID byte
SeeAlso: AH=1Bh,AH=36h
----------211D-------------------------------
INT 21 - DOS 1+ - NULL FUNCTION FOR CP/M COMPATIBILITY
	AH = 1Dh
Return: AL = 00h
Note:	corresponds to the CP/M BDOS function "get bit map of read-only
	  drives", which is meaningless under MSDOS
SeeAlso: AH=18h,AH=1Eh,AH=20h,AX=4459h
----------211E-------------------------------
INT 21 - DOS 1+ - NULL FUNCTION FOR CP/M COMPATIBILITY
	AH = 1Eh
Return: AL = 00h
Note:	corresponds to a CP/M BDOS function which is meaningless under MSDOS
SeeAlso: AH=18h,AH=1Dh,AH=20h
----------211F-------------------------------
INT 21 - DOS 1+ - GET DRIVE PARAMETER BLOCK FOR DEFAULT DRIVE
	AH = 1Fh
Return: AL = status
	    00h successful
		DS:BX -> Drive Parameter Block (DPB) (see below for DOS 1.x,
			AH=32h for DOS 2+)
	    FFh invalid drive
Note:	documented for DOS 5.0, but undocumented in prior versions
SeeAlso: AH=32h

Format of DOS 1.1 and MSDOS 1.25 drive parameter block:
Offset	Size	Description
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
	  are missing
----------2120-------------------------------
INT 21 - DOS 1+ - NULL FUNCTION FOR CP/M COMPATIBILITY
	AH = 20h
Return: AL = 00h
Note:	corresponds to the CP/M BDOS function "get/set default user number",
	  which is meaningless under MSDOS
SeeAlso: AH=18h,AH=1Dh,AH=1Eh,AX=4459h
----------2121-------------------------------
INT 21 - DOS 1+ - READ RANDOM RECORD FROM FCB FILE
	AH = 21h
	DS:DX -> opened FCB (see AH=0Fh)
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
----------2122-------------------------------
INT 21 - DOS 1+ - WRITE RANDOM RECORD TO FCB FILE
	AH = 22h
	DS:DX -> opened FCB (see AH=0Fh)
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
----------2123-------------------------------
INT 21 - DOS 1+ - GET FILE SIZE FOR FCB
	AH = 23h
	DS:DX -> unopened FCB (see AH=0Fh), wildcards not allowed
Return: AL = status
	    00h successful (matching file found)
		FCB random record field filled with size in records, rounded up
		to next full record
	    FFh failed (no matching file found)
Note:	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=42h
----------2124-------------------------------
INT 21 - DOS 1+ - SET RANDOM RECORD NUMBER FOR FCB
	AH = 24h
	DS:DX -> opened FCB (see AH=0Fh)
Notes:	computes the random record number corresponding to the current record
	  number and record size, then stores the result in the FCB
	normally used when switching from sequential to random access
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=21h,AH=27h,AH=42h
----------2125-------------------------------
INT 21 - DOS 1+ - SET INTERRUPT VECTOR
	AH = 25h
	AL = interrupt number
	DS:DX -> new interrupt handler
Note:	this function is preferred over direct modification of the interrupt
	  vector table
SeeAlso: AH=35h
----------212501-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - RESET 386/DOS-EXTENDER DATA STRUCTURES 
	AX = 2501h
Return: CF clear
Note:	Phar Lap uses INT 21/AH=25h as the entry point for all 386/DOS-Extender
	  system calls.	 Only available when directly using 386/DOS-Extender,
	  or when using a product that was created using 386-DOS/Extender
----------212502-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET PROTECTED-MODE INTERRUPT VECTOR
	AX = 2502h
	CL = interrupt number
Return: ES:EBX -> 48-bit address of protected-mode interrupt handler
	CF clear
SeeAlso: AX=2503h,AX=2504h,INT 31/AX=0204h
----------212503-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET REAL-MODE INTERRUPT VECTOR
	AX = 2503h
	CL = interrupt number
Return: EBX = 32-bit address of real-mode interrupt handler
	CF clear
SeeAlso: AX=2502h,AX=2504h,INT 31/AX=0200h
----------212504-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - SET PROTECTED-MODE INTERRUPT VECTOR
	AX = 2504h
	CL = interrupt number
	DS:EDX -> 48-bit address of protected-mode interrupt handler
Return: CF clear
SeeAlso: AX=2502h,AX=2505h,INT 31/AX=0205h
----------212505-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - SET REAL-MODE INTERRUPT VECTOR
	AX = 2505h
	CL = interrupt number
	EBX = 32-bit address of real-mode interrupt handler
Return: CF clear
SeeAlso: AX=2503h,AX=2504h,INT 31/AX=0201h
----------212506-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - SET INT TO ALWAYS GAIN CONTRL IN PROT MODE
	AX = 2506h
	CL = interrupt number
	DS:EDX -> 48-bit address of protected-mode interrupt handler
Return: CF clear
Note:	This function modifies both the real-mode low-memory interrupt
	  vector table and the protected-mode Interrupt Descriptor Table (IDT)
	Interrupts occurring in real mode are resignaled in protected mode.
----------212507-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - SET REAL- & PROTECTED-MODE INT VECTORS
	AX = 2507h
	CL = interrupt number
	DS:EDX -> 48-bit address of protected-mode interrupt handler
	EBX = 32-bit address of real-mode interrupt handler
Return: CF clear
Note:	interrupts are disabled until both vectors have been modified
SeeAlso: AX=2504h,AX=2505h
----------212508-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET SEGMENT LINEAR BASE ADDRESS
	AX = 2508h
	BX = segment selector
Return: CF clear if successful
	    ECX = linear base address of segment
	CF set if invalid segment selector
----------212509-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - CONVERT LINEAR TO PHYSICAL ADDRESS
	AX = 2509h
	EBX = linear address to convert
Return: CF clear if successful
	    ECX = physical address (carry flag clear)
	CF set if linear address not mapped in page tables
----------21250A-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - MAP PHYSICAL MEMORY AT END OF SEGMENT
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
----------21250C-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET HARDWARE INTERRUPT VECTORS
	AX = 250Ch
Return: CF clear
	AL = base interrupt vector for IRQ0-IRQ7
	AH = base interrupt vector for IRQ8-IRQ15
	BL = interrupt vector for BIOS print screen function
SeeAlso: INT 31/AX=0400h
----------21250D-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET REAL-MODE LINK INFORMATION
	AX = 250Dh
Return: CF clear
	EAX = 32-bit address of real-mode 386/DOS-Extender proc that will call
	      through from real mode to a protected-mode routine
	EBX = 32-bit real-mode address of intermode call data buffer
	ECX = size in bytes of intermode call data buffer
	ES:EDX -> protected-mode address of intermode call data buffer
----------21250E-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - CALL REAL-MODE PROCEDURE
	AX = 250Eh
	EBX = 32-bit address of real-mode procedure to call
	ECX = number of two-byte words to copy from protected-mode stack
	      to real-mode stack
Return: CF clear if successful
	    all segment registers unchanged
	    all general registers contain values set by real-mode procedure
	    all other flags set as they were left by real-mode procedure
	CF set on error
	    EAX = error code
		01h not enough real-mode stack space
SeeAlso: AH=E1h"OS/286",INT 31/AX=0301h
----------21250F-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - CONVERT PROTECTED-MODE ADDRESS TO MS-DOS
	AX = 250Fh
	ES:EBX -> 48-bit protected-mode address to convert
	ECX = length of data, in bytes
Return: CF clear if successful
	    ECX = 32-bit MS-DOS address
	CF set on error
	    ECX destroyed
SeeAlso: AX=2510h
----------212510-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - CALL REAL-MODE PROCEDURE, REGISTERS
	AX = 2510h
	EBX = 32-bit address of real-mode procedure to call
	ECX = number of two-byte words to copy to protected-mode stack to
	      real-mode stack
	DS:EDX -> pointer to parameter block (see below)
Return: CF clear if successful
	    all segment registers unchanged,
	    EDX unchanged
	    all other general registers contain values set by real-mode proc
	    all other flags are set as they were left by real-mode procedure
	    real-mode register values are returned in the parameter block
	CF set on error
	    EAX = error code
		01h not enough real-mode stack space
SeeAlso: AX=250Fh

Format of parameter block:
Offset	Size	Description
 00h	WORD	real-mode DS value
 02h	WORD	real-mode ES value
 04h	WORD	real-mode FS value
 06h	WORD	real-mode GS value
 08h	DWORD	real-mode EAX value
 0Ch	DWORD	real-mode EBX value
 10h	DWORD	real-mode ECX value
 14h	DWORD	real-mode EDX value
----------212511-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - ISSUE REAL-MODE INTERRUPT
	AX = 2511h
	DS:EDX -> pointer to parameter block (see below)
Return: all segment registers unchanged
	EDX unchanged
	all other registers contain values set by the real-mode int handler
	the flags are set as they were left by the real-mode interrupt handler
	real-mode register values are returned in the parameter block
SeeAlso: AX=2503h,AX=2505h,AH=E3h"OS/286",INT 31/AX=0300h

Format of parameter block:
Offset	Size	Description
 00h	WORD	interrupt number
 02h	WORD	real-mode DS value
 04h	WORD	real-mode ES value
 06h	WORD	real-mode FS value
 08h	WORD	real-mode GS value
 0Ah	DWORD	real-mode EAX value
 0Eh	DWORD	real-mode EDX value
Note: all other real-mode values set from protected-mode registers
----------212512-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - LOAD PROGRAM FOR DEBUGGING
	AX = 2512h
	DS:EDX -> pointer to ASCIIZ program name
	ES:EBX -> pointer to parameter block (see below)
	ECX = size in bytes of LDT buffer
Return: CF clear if successful
	    EAX = number of segment descriptors in LDT
	CF set on error
	    EAX = error code
		02h file not found or path invalid
		05h access denied
		08h insufficient memory
		0Ah environment invalid
		0Bh invalid file format
		80h LDT too small

Format of parameter block:
Offset	Size	Description
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
----------212513-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - ALIAS SEGMENT DESCRIPTOR
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
----------212514-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - CHANGE SEGMENT ATTRIBUTES
	AX = 2514h
	BX = segment selector of descriptor in GDT or LDT
	CL = new access-rights byte 
	CH = new use-type bit (USE16 or USE32)
Return: CF clear if successful
	CF set on error
	    EAX = error code
		09h invalid selector in BX
SeeAlso: AX=2515h,INT 31/AX=0009h
----------212515-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET SEGMENT ATTRIBUTES
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
----------212516-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - FREE ALL MEMORY OWNED BY LDT
	AX = 2516h
	???
Return: ???
----------212517-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET INFO ON DOS DATA BUFFER
	AX = 2517h
	???
Return: ???
----------212518-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - SPECIFY HANDLER FOR MOVED SEGMENTS
	AX = 2518h
	???
Return: ???
----------212519-----------------------------
INT 21 - Phar Lap 386/DOS-Extender VMM - GET ADDITIONAL MEMORY ERROR INFO
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
----------21251A-----------------------------
INT 21 - Phar Lap 386/DOS-Extender VMM - LOCK PAGES IN MEMORY
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
----------21251B-----------------------------
INT 21 - Phar Lap 386/DOS-Extender VMM - UNLOCK PAGES
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
----------21251D-----------------------------
INT 21 - Phar Lap 386/DOS-Extender VMM - READ PAGE-TABLE ENTRY
	AX = 251Dh
	???
Return: ???
SeeAlso: AX=251Eh,AX=EB00h,INT 31/AX=0506h
----------21251E-----------------------------
INT 21 - Phar Lap 386/DOS-Extender VMM - WRITE PAGE-TABLE ENTRY
	AX = 251Eh
	???
Return: ???
SeeAlso: AX=251Dh,INT 31/AX=0507h
----------21251F-----------------------------
INT 21 - Phar Lap 386/DOS-Extender VMM - EXHANGE TWO PAGE-TABLE ENTRIES
	AX = 251Fh
	???
Return: ???
SeeAlso: AX=251Dh,AX=251Eh
----------212520-----------------------------
INT 21 - Phar Lap 386/DOS-Extender VMM - GET MEMORY STATISTICS
	AX = 2520h
	DS:EDX -> pointer to buffer at least 100 bytes in size (see below)
	BL = 0 (don't reset VM stats), 1 (reset VM stats)
Return: carry flag clear    

Format of VM stats buffer:
Offset	Size	Description
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
 4Ch	DWORD	maximum size in bytes to which swap file can be increased
 50h	DWORD	"vmflags" bit 0 = 1 if page fault in progress
 54h 16 BYTEs	reserved for future expansion (set to zero)
----------212521-----------------------------
INT 21 - Phar Lap 386/DOS-Extender VMM - LIMIT PROGRAM'S EXTENDED MEMORY USAGE
	AX = 2521h
	EBX = max 4k pages of physical extended memory which program may use
Return: CF clear if successful
	   EBX = maximum limit in pages
	   ECX = minimum limit in pages
	CF set on error
	    EAX = error code
		08h insufficient memory or -nopage switch used
SeeAlso: AX=2522h
----------212522-----------------------------
INT 21 - Phar Lap 386/DOS-Extender VMM - SPECIFY ALTERNATE PAGE-FAULT HANDLER
	AX = 2522h
	???
Return: ???
SeeAlso: AX=2523h
----------212523-----------------------------
INT 21 - Phar Lap 386/DOS-Extender VMM - SPECIFY OUT-OF-SWAP-SPACE HANDLER
	AX = 2523h
	???
Return: ???
SeeAlso: AX=2522h
----------212524-----------------------------
INT 21 - Phar Lap 386/DOS-Extender VMM - INSTALL PAGE-REPLACEMENT HANDLERS
	AX = 2524h
	???
Return: ???
----------212525-----------------------------
INT 21 - Phar Lap 386/DOS-Extender VMM - LIMIT PROGRAM'S CONVENTIONAL MEM USAGE
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
----------212526-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET CONFIGURATION INFORMATION
	AX = 2526h
	???
Return: ???
----------2125C0-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - ALLOCATE MS-DOS MEMORY BLOCK
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
----------2125C1-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - RELEASE MS-DOS MEMORY BLOCK
	AX = 25C1h
	CX = real-mode paragraph address of memory block to free
Return: CF clear if successful
	    EAX destroyed
	CF set on error
	    AX = error code
		07h MS-DOS memory control blocks destroyed
		09h invalid memory block address in CX
SeeAlso: AX=25C0h,AX=25C2h
----------2125C2-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - MODIFY MS-DOS MEMORY BLOCK
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
----------2125C3-----------------------------
INT 21 - Phar Lap 386/DOS-Extender - EXECUTE PROGRAM
	AX = 25C3h
	ES:EBX -> pointer to parameter block (see below)
	DS:EDX -> pointer to ASCIIZ program filename
Return: CF clear if successful
	    all registers unchanged
	CF set on error
	    EAX = error code
		01h function code in AL is invalid ???
		02h file not found or path invalid
		05h access denied
		08h insufficient memory to load program
		0Ah environment invalid
		0Bh invalid file format

Format of parameter block:
Offset	Size	Description
 00h	DWORD	32-bit offset of environment string
 04h	WORD	segment selector of environment string
 06h	DWORD	32-bit offset of command-tail string
 0Ah	WORD	segment selector of command-tail string
----------2126-------------------------------
INT 21 - DOS 1+ - CREATE NEW PROGRAM SEGMENT PREFIX
	AH = 26h
	DX = segment at which to create PSP (see below for format)
Notes:	new PSP is updated with memory size information; INTs 22h, 23h, 24h
	  taken from interrupt vector table
	(DOS 2+) DOS assumes that the caller's CS is the segment of the PSP to
	  copy
SeeAlso: AH=4Bh,AH=50h,AH=51h,AH=55h,AH=62h,AH=67h

Format of PSP:
Offset	Size	Description
 00h  2 BYTEs	INT 20 instruction for CP/M CALL 0 program termination
 02h	WORD	segment of first byte beyond memory allocated to program
 04h	BYTE	unused filler
 05h	BYTE	CP/M CALL 5 service request (FAR JMP to 000C0h)
		BUG: (DOS 2+) PSPs created by INT 21/AH=4Bh point at 000BEh
 06h	WORD	CP/M compatibility--size of first segment for .COM files
 08h  2 BYTEs	remainder of FAR JMP at 05h
 0Ah	DWORD	stored INT 22 termination address
 0Eh	DWORD	stored INT 23 control-Break handler address
 12h	DWORD	DOS 1.1+ stored INT 24 critical error handler address
 16h	WORD	segment of parent PSP
 18h 20 BYTEs	DOS 2+ Job File Table, one byte per file handle, FFh = closed
 2Ch	WORD	DOS 2+ segment of environment for process
 2Eh	DWORD	DOS 2+ process's SS:SP on entry to last INT 21 call
 32h	WORD	DOS 3+ number of entries in JFT (default 20)
 34h	DWORD	DOS 3+ pointer to JFT (default PSP:0018h)
 38h	DWORD	DOS 3+ pointer to previous PSP (default FFFFFFFFh in 3.x)
		used by SHARE in DOS 3.3
 3Ch  4 BYTEs	unused by DOS versions <= 5.00
 40h  2 BYTEs	DOS 5.0 version to return on INT 21/AH=30h
 42h 14 BYTEs	unused by DOS versions <= 5.00
 50h  3 BYTEs	DOS 2+ service request (INT 21/RETF instructions)
 53h  9 BYTEs	unused in DOS versions <= 5.00
 5Ch 16 BYTEs	first default FCB, filled in from first commandline argument
		overwrites second FCB if opened
 6Ch 16 BYTEs	second default FCB, filled in from second commandline argument
		overwrites beginning of commandline if opened
 7Ch  4 BYTEs	unused
 80h 128 BYTEs	commandline / default DTA
		command tail is BYTE for length of tail, N BYTEs for the tail,
		followed by a BYTE containing 0Dh
Notes:	in DOS versions 3.0 and up, the limit on simultaneously open files may
	  be increased by allocating memory for a new open file table, filling
	  it with FFh, copying the first 20 bytes from the default table, and
	  adjusting the pointer and count at 34h and 32h.  However, DOS
	  versions through  at least 3.30 will only copy the first 20 file
	  handles into a child PSP (including the one created on EXEC).
	network redirectors based on the original MS-Net implementation use
	  values of 80h-FEh in the open file table to indicate remote files
	MSDOS 5.00 incorrectly fills the FCB fields when loading a program
	  high; the first FCB is empty and the second contains the first
	  parameter

Format of environment block:
Offset	Size	Description
 00h  N BYTEs	first environment variable, ASCIZ string of form "var=value"
      N BYTEs	second environment variable, ASCIZ string
	...
      N BYTEs	last environment variable, ASCIZ string of form "var=value"
	BYTE	00h
---DOS 3+---
	WORD	number of strings following environment (normally 1)
      N BYTEs	ASCIZ full pathname of program owning this environment
		other strings may follow
----------2127-------------------------------
INT 21 - DOS 1+ - RANDOM BLOCK READ FROM FCB FILE
	AH = 27h
	CX = number of records to read
	DS:DX -> opened FCB (see AH=0Fh)
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
----------2128-------------------------------
INT 21 - DOS 1+ - RANDOM BLOCK WRITE TO FCB FILE
	AH = 28h
	CX = number of records to write
	DS:DX -> opened FCB (see AH=0Fh)
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
----------2129-------------------------------
INT 21 - DOS 1+ - PARSE FILENAME INTO FCB
	AH = 29h
	AL = parsing options
	    bit 0: skip leading separators
	    bit 1: use existing drive number in FCB if no drive is specified,
		   instead of setting field to zero
	    bit 2: use existing filename in FCB if no base name is specified,
		   instead of filling field with blanks
	    bit 3: use existing extension in FCB if no extension is specified,
		   instead of filling field with blanks
	    bits 4-7: reserved (0)
	DS:SI -> filename string (both '*' and '?' wildcards OK)
	ES:DI -> buffer for unopened FCB
Return: AL = result code
	    00h successful parse, no wildcards encountered
	    01h successful parse, wildcards present
	    FFh failed (invalid drive specifier)
	DS:SI -> first unparsed character
	ES:DI buffer filled with unopened FCB (see AH=0Fh)
Notes:	asterisks expanded to question marks in the FCB
	all processing stops when a filename terminator is encountered
	cannot be used with filespecs which include a path (DOS 2+)
SeeAlso: AH=0Fh,AH=16h,AH=26h
----------212A-------------------------------
INT 21 - DOS 1+ - GET SYSTEM DATE
	AH = 2Ah
Return: CX = year (1980-2099)
	DH = month
	DL = day
---DOS 1.10+---
	AL = day of week (00h=Sunday)
SeeAlso: AH=2Bh"DOS",AH=2Ch,AH=E7h,INT 1A/AH=04h
----------212B-------------------------------
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
----------212B--CX4358-----------------------
INT 21 - PC Tools v5.x PC-Cache - INSTALLATION CHECK
	AH = 2Bh
	CX = 4358h ('CX')
Return: AL = FFh if PC-Cache not installed
	AL = 00h if installed
	    CX = 6378h ('cx')
	    BX = ???
	    DX = ???
SeeAlso: INT 16/AX=FFA5h/CX=1111h
----------212B--CX4445-----------------------
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
Note:	in DESQview v1.x, there were no subfunctions; this call only identified
	whether or not DESQview was loaded
SeeAlso: INT 10/AH=FEh,INT 10/AH=FFh,INT 15/AX=1024h
----------212B--CX454C-----------------------
INT 21 - ELRES v1.1 - INSTALLATION CHECK
	AH = 2Bh
	CX = 454Ch ('EL')
	DX = 5253h ('RS')
Return: ES:BX -> ELRES history structure (see below)
	DX = DABEh (signature, DAve BEnnett)
Note:	ELRES is an MSDOS return code (errorlevel) recorder by David H. Bennett
	  which stores recent errorlevel values, allows them to be retrieved
	  for use in batch files, and can place them in an environment variable
SeeAlso: AH=4Bh"ELRES",AH=4Dh

Format of ELRES history structure:
Offset	Size	Description
 00h	WORD	number of return codes which can be stored by following buffer
 02h	WORD	current position in buffer (treated as a ring)
 04h  N BYTEs	ELRES buffer
----------212B01CX5441-----------------------
INT 21 - TAME v2.10+ - INSTALLATION CHECK
	AX = 2B01h
	CX = 5441h ('TA')
	DX = 4D45h ('ME')
---v2.60---
	BH = ???
	    00h skip ???, else do
Return: AL = 02h if installed
	ES:DX -> data area in TAME-RES (see below)
Note:	TAME is a shareware program by David G. Thomas which gives up CPU time
	  to other partitions under a multitasker when the current partition's
	  program incessantly polls the keyboard or system time

Format of TAME 2.10-2.20 data area:
Offset	Size	Description
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
 44h	BYTE	flags for interrupts already grabbed by TAME
		bit 0: INT 10h
		    1: INT 14h
		    2: INT 15h
		    3: INT 16h
		    4: INT 17h
		    5: INT 21h
		    6: INT 28h
 45h	BYTE	flags for interrupts which may be acted on (same bits as above)
 46h	BYTE	TAME enabled (01h) or disabled (00h)
 47h	BYTE	/TIMEPOLL (01h) or /NOTIMEPOLL (00h)
 48h	BYTE	/NOTIMER (01h) or /TIMER (00h)
 49h	BYTE	window or task number for this task
 4Ah	BYTE	multitasker type ???
		01h DESQview
		02h DoubleDOS
		03h TopView
		???
 4Bh	BYTE	type of task switching selected
		bit 0: DESQview???
		    1: DoubleDOS???
		    2: TopView???
		    3: KeySwitch
		    4: HLT instruction
 4Ch	BYTE	???
 4Dh	BYTE	flags
		bit 1: /FREQ instead of /MAX
 4Eh	BYTE	/FG: value
 4Fh	BYTE	task switches left until next FGONLY DESQview API call
 50h	BYTE	???

Format of TAME 2.30 data area:
Offset	Size	Description
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
 5Ch	BYTE	flags for interrupts already grabbed by TAME
		bit 0: INT 10h
		    1: INT 14h
		    2: INT 15h
		    3: INT 16h
		    4: INT 17h
		    5: INT 21h
		    6: INT 28h
 5Dh	BYTE	flags for interrupts which may be acted on (same bits as above)
 5Eh	BYTE	window or task number for this task
 5Fh	BYTE	multitasker type
		01h DESQview
		02h DoubleDOS
		03h TopView
		04h OmniView
		05h VM/386
 60h	BYTE	type of task switching selected (bit flags)
		bit 0: DESQview
		    1: DoubleDOS
		    2: TopView
		    3: OmniView
		    4: KeySwitch
		    5: HLT instruction
 61h	BYTE	watch_DOS
 62h	BYTE	bit flags
		bit 0: TAME enabled
		    1: /FREQ instead of /MAX (counts in 3Ch and 3Eh per tick)
		    2: /TIMEPOLL
		    3: /KEYPOLL
		    4: inhibit timer
		    5: enable status monitoring
 63h	BYTE	old status
 64h	WORD	signature DA34h

Format of TAME 2.60 data area:
Offset	Size	Description
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
 62h	WORD	task switches left until next FGONLY DESQview API call
 64h	WORD	multitasker version ???
 66h	WORD	virtual screen segment
 68h	BYTE	flags for interrupts already grabbed by TAME
		bit 0: INT 10h
		    1: INT 14h
		    2: INT 15h
		    3: INT 16h
		    4: INT 17h
		    5: INT 21h
		    6: INT 28h
 69h	BYTE	flags for interrupts which may be acted on (same bits as above)
 6Ah	BYTE	window or task number for this task
 6Bh	BYTE	multitasker type
		01h DESQview
		02h DoubleDOS
		03h TopView
		04h OmniView
		05h VM/386
 6Ch	BYTE	type of task switching selected (bit flags)
		bit 0: DESQview
		    1: DoubleDOS
		    2: TopView
		    3: OmniView
		    4: KeySwitch
		    5: HLT instruction
 6Dh	BYTE	watch_DOS
 6Eh	BYTE	bit flags
		bit 0: TAME enabled
		    1: /FREQ instead of /MAX (counts in 50h and 52h per tick)
		    2: /TIMEPOLL
		    3: /KEYPOLL
		    4: inhibit timer
		    5: enable status monitoring
 6Fh	BYTE	old status
 70h	WORD	signature DA34h
----------212B44BX4D41-----------------------
INT 21 - pcANYWHERE IV/LAN - INSTALLATION CHECK
	AX = 2B44h ('D')
	BX = 4D41h ('MA')
	CX = 7063h ('pc')
	DX = 4157h ('AW')
Return: AX = 4F4Bh ('OK') if large host resident
	   = 6F6Bh ('ok') if small host resident
	CX:DX -> API entry point
SeeAlso: INT 16/AH=79h

Call API entry point with:
	AX = 0000h get pcANYWHERE IV version
	    DS:SI -> BYTE buffer for host type code
	    Return: AH = version number
		    AL = revision number
		    DS:DI buffer byte filled with
			00h full-featured host
			01h limited-feature LAN host
			other API may not be supported
	AX = 0001h initialize operation
	    DS:SI -> initialization request structure (see below)
	    Return: AX = function status (see below)
	AX = 0002h get status
	    Return: AH = current operating mode (see init req structure below)
		    AL = current connection status
			bit 0: a physical connection is active
			bit 1: remove screen updating is active
			bit 2: connection checking is active
			bit 3: hot key detection is active
			bit 4: background file transfer is active
	AX = 0003h suspend remote screen updates
	    Return: AX = function status (see below)
	AX = 0004h resume screen updates
	    Return: AX = function status (see below)
	AX = 0005h end current remote access session
	    DS:SI -> termination request structure (see below)
	    Return: AX = function status (see below)
	AX = 0006h remove pcANYWHERE IV from memory
	    Return: AX = status
			0000h successful
			FFD2h unable to release allocated memory
			FFD1h unable to release interrupt vectors
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

Format of initialization request structure:
Offset	Size	Description
 00h	BYTE	operating mode
		00h wait for a call
		01h hot key activates
		02h incoming call activates
		03h initiate a call
 01h  3 BYTEs	user ID to append to config file names
 04h	WORD	DS-relative pointer to path for config files
 06h	WORD	DS-relative pointer to path for program files

Format of termination request structure:
Offset	Size	Description
 00h	BYTE	operating mode after termination
		00h wait for a call
		01h hot key activates
		02h incoming call activates
		80h use current mode
		FFh remove from memory

Values for function status:
 0000h function completed successfully
 FFF2h unable to establish a connection when operating mode is
	"Initiate a call"
 FFF3h modem configuration is invalid (corrupt config)
 FFF4h modem initialization failed (no modem response)
 FFF5h the communications device could not be initialized
 FFF6h the host operator aborted the function
 FFF7h the communications driver type specified in the configuration file is
	different than the one loaded when pcANYWHERE IV was initially started
 FFF9h the configuration file is invalid
 FFFAh the configuration file could not be found
 FFFBh no session is active
 FFFCh a remote access session is active
 FFFDh the specified operating mode is invalid
----------212C-------------------------------
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
----------212D-------------------------------
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
----------212E--DL00-------------------------
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
----------212F-------------------------------
INT 21 - DOS 2+ - GET DISK TRANSFER AREA ADDRESS
	AH = 2Fh
Return: ES:BX -> current DTA
SeeAlso: AH=1Ah
----------2130-------------------------------
INT 21 - DOS 2+ - GET DOS VERSION
	AH = 30h
---DOS 5.0---
	AL = what to return in BH
	    00h OEM number (as for DOS 2.0-4.0x)
	    01h version flag
Return: AL = major version number (00h if DOS 1.x)
	AH = minor version number
	BL:CX = 24-bit user serial number (most versions do not use this)
---if DOS <5 or AL=00h---
	BH = OEM number
	    00h IBM
	    05h Zenith
	    16h DEC
	    23h Olivetti
	    29h Toshiba
	    4Dh	Hewlett-Packard
	    99h	STARLITE architecture (OEM DOS, NETWORK DOS, SMP DOS)
	    FFh Microsoft, Phoenix
---if DOS 5.0 and AL=01h---
	BH = version flag
	    08h DOS is in ROM
	    10h DOS is in HMA
Notes:	the OS/2 v1.x Compatibility Box returns major version 0Ah
	the OS/2 v2.x Compatibility Box returns major version 14h
	DOS 4.01 and 4.02 identify themselves as version 4.00
	generic MSDOS 3.30, Compaq MSDOS 3.31, and others identify themselves
	  as PC-DOS by returning OEM number 00h
	the version returned under DOS 4.0x may be modified by entries in
	  the special program list (see AH=52h)
	the version returned under DOS 5.0 may be modified by SETVER; use
	  AX=3306h to get the true version number
SeeAlso: AX=3306h,INT 2F/AX=122Fh
----------2130-------------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET VERSION
	AH = 30h
	EBX = 50484152h ("PHAR")
Return: ???
----------2130--DXABCD-----------------------
INT 21 - VIRUS - "Possessed" - INSTALLATION CHECK
	AH = 30h
	DX = ABCDh
Return: DX = DCBAh if installed
SeeAlso: AX=0D20h,AX=30F1h
----------213000BX1234-----------------------
INT 21 - CTask 2.0+ - INSTALLATION CHECK
	AX = 3000h
	BX = 1234h
	DS:DX -> 8-byte version string (DX < FFF0h) "CTask21",00h for v2.1-2.2
Return: AL = DOS major version
	AH = DOS minor version
	CX:BX -> Ctask global data block
Notes:	if first eight bytes of returned data block equal eight bytes passed
	  in, CTask is resident
	CTask is a multitasking kernel for C written by Thomas Wagner
----------2130F1-----------------------------
INT 21 - VIRUS - "Dutch-555"/"Quit 1992" - INSTALLATION CHECK
	AX = 30F1h
Return: AL = 00h if resident
SeeAlso: AH=30h/DX=ABCDh,AX=330Fh
----------2131-------------------------------
INT 21 - DOS 2+ - TERMINATE AND STAY RESIDENT
	AH = 31h
	AL = return code
	DX = number of paragraphs to keep resident
Return: never
Notes:	the value in DX only affects the memory block containing the PSP;
	  additional memory allocated via AH=48h is not affected
	the minimum number of paragraphs which will remain resident is 11h
	  for DOS 2.x and 06h for DOS 3+
	most TSRs can save some memory by releasing their environment block
	  before terminating (see AH=26h,AH=49h)
SeeAlso: AH=00h,AH=4Ch,AH=4Dh,INT 20,INT 22,INT 27
----------2132-------------------------------
INT 21 - DOS 2+ - GET DOS DRIVE PARAMETER BLOCK FOR SPECIFIC DRIVE
	AH = 32h
	DL = drive number (00h = default, 01h = A:, etc)
Return: AL = status
	    00h successful
		DS:BX -> Drive Parameter Block (DPB) for specified drive
	    FFh invalid or network drive
Notes:	the OS/2 compatibility box supports the DOS 3.3 version of this call
	  except for the DWORD at offset 12h
	this call updates the DPB by reading the disk; the DPB may be accessed
	  via the DOS list of lists (see AH=52h) if disk access is not
	  desirable.
	documented for DOS 5.0, but undocumented in prior versions
SeeAlso: AH=1Fh,AH=52h

Format of DOS Drive Parameter Block:
Offset	Size	Description
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
 0Fh	BYTE	number of sectors per FAT
 10h	WORD	sector number of first directory sector
 12h	DWORD	address of device driver header
 16h	BYTE	media ID byte
 17h	BYTE	00h if disk accessed, FFh if not
 18h	DWORD	pointer to next DPB
---DOS 2.x---
 1Ch	WORD	cluster containing start of current directory, 0000h=root,
		FFFFh = unknown
 1Eh 64 BYTEs	ASCIZ pathname of current directory for drive
---DOS 3.x---
 1Ch	WORD	cluster at which to start search for free space when writing
 1Eh	WORD	number of free clusters on drive, FFFFh = unknown
---DOS 4.0-5.0---
 0Fh	WORD	number of sectors per FAT
 11h	WORD	sector number of first directory sector
 13h	DWORD	address of device driver header
 17h	BYTE	media ID byte
 18h	BYTE	00h if disk accessed, FFh if not
 19h	DWORD	pointer to next DPB
 1Dh	WORD	cluster at which to start search for free space when writing
 1Fh	WORD	number of free clusters on drive, FFFFh = unknown
----------2133-------------------------------
INT 21 - DOS 2+ - EXTENDED BREAK CHECKING
	AH = 33h
	AL = subfunction
	    00h get current extended break state
		Return: DL = current state, 00h = off, 01h = on
	    01h set state of extended ^C/^Break checking
		DL = 00h off, check only on character I/O functions
		     01h on, check on all DOS functions
Note:	under DOS 3.1+, this function does not use any of the DOS-internal
	  stacks and is thus fully reentrant
SeeAlso: AX=3302h
----------213302-----------------------------
INT 21 - DOS 3.x+ internal - GET AND SET EXTENDED CONTROL-BREAK CHECKING STATE
	AX = 3302h
	DL = new state
	     00h for OFF or 01h for ON
Return: DL = old state of extended BREAK checking
Note:	this function does not use any of the DOS-internal stacks and is thus
	  fully reentrant
SeeAlso: AH=33h
----------213305-----------------------------
INT 21 - DOS 4+ - GET BOOT DRIVE
	AX = 3305h
Return: DL = boot drive (1=A:,...)
Notes:	fully reentrant
	NEC 9800-series PCs always call the boot drive A: and assign the other
	  drive letters sequentially to the other drives in the system
----------213306-----------------------------
INT 21 - DOS 5.0 - GET TRUE VERSION NUMBER
	AX = 3306h
Return:	BL = major version
	BH = minor version
	DL = revision (bits 2-0, all others 0)
	DH = version flags
	    bit 3: DOS is in ROM
	    bit 4: DOS in in HMA
Note:	this function always returns the true version number, unlike AH=30h,
	  whose return value may be changed with SETVER
	fully reentrant
SeeAlso: AH=30h
----------21330F-----------------------------
INT 21 - VIRUS - "Burghofer" - INSTALLATION CHECK
	AX = 330Fh
Return: AL = 0Fh if resident (DOS returns AL=FFh)
SeeAlso: AX=30F1h,AX=33E0h
----------2133E0-----------------------------
INT 21 - VIRUS - "Oropax" - INSTALLATION CHECK
	AX = 33E0h
Return: AL = E0h if resident (DOS returns AL=FFh)
SeeAlso: AX=330Fh,AX=357Fh
----------2134-------------------------------
INT 21 - DOS 2+ - GET ADDRESS OF INDOS FLAG
	AH = 34h
Return: ES:BX -> one-byte InDOS flag
Notes:	the value of InDOS is incremented whenever an INT 21 function begins
	  and decremented whenever one completes
	during an INT 28 call, it is safe to call some INT 21 functions even
	  though InDOS may be 01h instead of zero
	InDOS alone is not sufficient for determining when it is safe to
	  enter DOS, as the critical error handling decrements InDOS and
	  increments the critical error flag for the duration of the critical
	  error.  Thus, it is possible for InDOS to be zero even if DOS is
	  busy.
	the critical error flag is the byte immediately following InDOS in
	  DOS 2.x, and the byte BEFORE the InDOS flag in DOS 3+ (except COMPAQ
	  DOS 3.0, where the critical error flag is located 1AAh bytes BEFORE
	  the critical section flag)
	For DOS 3.1+, an undocumented call exists to get the address of the
	  critical error flag (see AX=5D06h)
SeeAlso: AX=5D06h,AX=5D0Bh,INT 28
----------2135-------------------------------
INT 21 - DOS 2+ - GET INTERRUPT VECTOR
	AH = 35h
	AL = interrupt number
Return: ES:BX -> current interrupt handler
SeeAlso: AH=25h
----------21357F-----------------------------
INT 21 - VIRUS - "Agiplan"/"Month 4-6" - INSTALLATION CHECK
	AX = 357Fh
Return: DX = FFFFh if installed
SeeAlso: AX=33E0h,AX=3DFFh
----------2136-------------------------------
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
	according to Dave Williams' MSDOS reference, the value in DX is
	  incorrect for non-default drives after ASSIGN is run
SeeAlso: AH=1Bh,AH=1Ch
----------213700-----------------------------
INT 21 - DOS 2+ - "SWITCHAR" - GET SWITCH CHARACTER
	AX = 3700h
Return: AL = status
	    00h successful
		DL = current switch character
	    FFh unsupported subfunction
Notes:	documented in some OEM versions of some releases of DOS
	supported by OS/2 compatibility box
	always returns AL=2Fh for DOS 5.0
SeeAlso: AX=3701h
----------213701-----------------------------
INT 21 - DOS 2+ - "SWITCHAR" - SET SWITCH CHARACTER
	AX = 3701h
	DL = new switch character
Return: AL = status
	    00h successful
	    FFh unsupported subfunction
Notes:	documented in some OEM versions of some releases of DOS
	supported by OS/2 compatibility box
	ignored by DOS 5.0
SeeAlso: AX=3700h
----------2137-------------------------------
INT 21 - DOS 2.x and 3.3+ only - "AVAILDEV" - SPECIFY \DEV\ PREFIX USE
	AH = 37h
	AL = subfunction
	    02h get availdev flag
		Return: DL = 00h \DEV\ must precede character device names
			   = nonzero \DEV\ is optional
	    03h set availdev flag
		DL = 00h	\DEV\ is mandatory
		   = nonzero	\DEV\ is optional
Return: AL = status
	    00h successful
	    FFh unsupported subfunction
Notes:	all versions of DOS from 2.00 allow \DEV\ to be prepended to device
	  names without generating an error even if the directory \DEV does
	  not actually exist (other paths generate an error if they do not
	  exist).
	although DOS 3.3+ accepts these calls, they have no effect, and
	  AL=02h always returns DL=FFh
----------2138-------------------------------
INT 21 - DOS 2+ - GET COUNTRY-SPECIFIC INFORMATION
	AH = 38h
--DOS 2.x--
	AL = 00h get current-country info
	DS:DX -> buffer for returned info (see below)
Return: CF set on error
	    AX = error code (02h)
	CF clear if successful
	    AX = country code (MSDOS 2.11 only)
	    buffer at DS:DX filled
--DOS 3+--
	AL = 00h for current country
	AL = 01h thru 0FEh for specific country with code <255
	AL = 0FFh for specific country with code >= 255
	   BX = 16-bit country code
	DS:DX -> buffer for returned info (see below)
Return:	CF set on error
	    AX = error code (02h)
	CF clear if successful
	    BX = country code
	    DS:DX buffer filled
SeeAlso: AH=65h,INT 10/AX=5001h,INT 2F/AX=110Ch,INT 2F/AX=1404h

Format of PCDOS 2.x country info:
Offset	Size	Description
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

Format of MSDOS 2.x,DOS 3+ country info:
Offset	Size	Description
 00h	WORD	date format (see above)
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
 02Ah	Czechoslovakia (not supported by DR-DOS 5.0)
 02Bh	Austria (DR-DOS 5.0)
 02Ch	United Kingdom
 02Dh	Denmark
 02Eh	Sweden
 02Fh	Norway
 030h	Poland (not supported by DR-DOS 5.0)
 031h	Germany
 037h	Brazil (not supported by DR-DOS 5.0)
 03Dh	International English [Australia in DR-DOS 5.0]
 051h	Japan (DR-DOS 5.0)
 052h	Korea (DR-DOS 5.0)
 15Fh	Portugal
 166h	Finland
 311h	Middle East (DR-DOS 5.0)
 3CCh	Israel (DR-DOS 5.0)
----------2138-------------------------------
INT 21 - DOS 3+ - SET COUNTRY CODE
	AH = 38h
	AL = 01h thru 0FEh for specific country with code <255
	AL = FFh for specific country with code >= 255
	   BX = 16-bit country code
	DX = FFFFh
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Note:	not supported by OS/2
SeeAlso: INT 2F/AX=1403h
----------2139-------------------------------
INT 21 - DOS 2+ - "MKDIR" - CREATE SUBDIRECTORY
	AH = 39h
	DS:DX -> ASCIZ pathname
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (03h,05h) (see AH=59h)
Notes:	all directories in the given path except the last must exist
	fails if the parent directory is the root and is full
	DOS 2.x-3.3 allow the creation of a directory sufficiently deep that
	  it is not possible to make that directory the current directory
	  because the path would exceed 64 characters
SeeAlso: AH=3Ah,AH=3Bh,INT 2F/AX=1103h
----------213A-------------------------------
INT 21 - DOS 2+ - "RMDIR" - REMOVE SUBDIRECTORY
	AH = 3Ah
	DS:DX -> ASCIZ pathname of directory to be removed
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (03h,05h,06h,10h) (see AH=59h)
Note:	directory must be empty (contain only '.' and '..' entries)
SeeAlso: AH=39h,AH=3Bh,INT 2F/AX=1101h
----------213B-------------------------------
INT 21 - DOS 2+ - "CHDIR" - SET CURRENT DIRECTORY
	AH = 3Bh
	DS:DX -> ASCIZ pathname to become current directory (max 64 bytes)
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (03h) (see AH=59h)
Notes:	if new directory name includes a drive letter, the default drive is
	  not changed, only the current directory on that drive
	changing the current directory also changes the directory in which
	  FCB file calls operate
SeeAlso: AH=47h,INT 2F/AX=1105h
----------213C-------------------------------
INT 21 - DOS 2+ - "CREAT" - CREATE OR TRUNCATE FILE
	AH = 3CH
	CX = file attribute
	    bit 0: read-only
		1: hidden
		2: system
		3: volume label (ignored)
		4: reserved, must be zero (directory)
		5: archive bit
		7: if set, file is shareable under Novell NetWare
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    AX = file handle
	CF set on error
	    AX = error code (03h,04h,05h) (see AH=59h)
Note:	if a file with the given name exists, it is truncated to zero length
SeeAlso: AH=16h,AH=3Dh,AH=5Ah,AH=5Bh
----------213D-------------------------------
INT 21 - DOS 2+ - "OPEN" - OPEN EXISTING FILE
	AH = 3Dh
	AL = access and sharing modes
	    bits 2-0: access mode
		000 read only
		001 write only
		010 read/write
	    bit 3: reserved (0)
	    bits 6-4: sharing mode (DOS 3+)
		000 compatibility mode
		001 "DENYALL" prohibit both read and write access by others
		010 "DENYWRITE" prohibit write access by others
		011 "DENYREAD" prohibit read access by others
		100 "DENYNONE" allow full access by others
	    bit 7: inheritance
		if set, file is private to current process and will not be
		  inherited by child processes
	DS:DX -> ASCIZ filename
	CL = attribute mask of files to look for (server call only)
Return: CF clear if successful
	    AX = file handle
	CF set on error
	    AX = error code (01h,02h,03h,04h,05h,0Ch) (see AH=59h)
Notes:	file pointer is set to start of file
	file handles which are inherited from a parent also inherit sharing
	  and access restrictions
	files may be opened even if given the hidden or system attributes
SeeAlso: AH=0Fh,AH=3Ch,AX=4301h,AX=5D00h,INT 2F/AX=1226h

File sharing behavior:
	  |	Second and subsequent Opens
 First	  |Compat  Deny	  Deny	 Deny	Deny
 Open	  |	   All	  Write	 Read	None
	  |R W RW R W RW R W RW R W RW R W RW
 - - - - -| - - - - - - - - - - - - - - - - -
 Compat	R |Y Y Y  N N N	 1 N N	N N N  1 N N
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
----------213DFF-----------------------------
INT 21 - VIRUS - "JD-448" - INSTALLATION CHECK
	AX = 3DFFh
Return: AX = 4A44h if resident
SeeAlso: AX=357Fh,AX=4203h
----------213E-------------------------------
INT 21 - DOS 2+ - "CLOSE" - CLOSE FILE
	AH = 3Eh
	BX = file handle
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (06h) (see AH=59h)
Note:	if the file was written to, any pending disk writes are performed, the
	  time and date stamps are set to the current time, and the directory
	  entry is updated
SeeAlso: AH=10h,AH=3Ch,AH=3Dh,INT 2F/AX=1106h,INT 2F/AX=1227h
----------213F-------------------------------
INT 21 - DOS 2+ - "READ" - READ FROM FILE OR DEVICE
	AH = 3Fh
	BX = file handle
	CX = number of bytes to read
	DS:DX -> buffer for data
Return: CF clear if successful
	    AX = number of bytes actually read (0 if at EOF before call)
	CF set on error
	    AX = error code (05h,06h) (see AH=59h)
Notes:	data is read beginning at current file position, and the file position
	  is updated after a successful read
	the returned AX may be smaller than the request in CX if a partial
	  read occurred
	if reading from CON, read stops at first CR
SeeAlso: AH=27h,AH=40h,INT 2F/AX=1108h,INT 2F/AX=1229h
----------213F-------------------------------
INT 21 - Turbo Debug HARDWARE BREAKPOINTS - READ STATUS BLOCK
	AH = 3Fh
	BX = handle for character device "TDHDEBUG"
	CX = number of bytes to read
	DS:DX -> buffer for status block (see below)
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (05h,06h) (see AH=59h)
SeeAlso: AH=40h"Turbo Debug"

Format of status block:
Offset	Size	Description
 00h	BYTE	status of command
		00h successful
		01h invalid handle
		02h no more breakpoints available
		03h hardware does not support specified breakpoint type
		04h previous command prevents execution
		05h debugger hardware not found
		06h hardware failure
		07h invalid command
		08h driver not initialized yet
		FEh recursive entry (hardware breakpoint inside hw bp handler)
---status for command 01h---
 01h	WORD	device driver interface version number (currently 1)
 03h	WORD	device driver software version
 05h	BYTE	maximum simultaneous hardware breakpoints
 06h	BYTE	configuration bits
		bit 0: CPU and DMA accesses are distinct
		    1: can detect DMA transfers
		    2: supports data mask
		    3: hardware pass counter on breakpoints
		    4: can match on data as well as addresses
 07h	BYTE	supported breakpoint types
		bit 0: memory read
		    1: memory write
		    2: memory read/write
		    3: I/O read
		    4: I/O write
		    5: I/O read/write
		    6: instruction fetch
 08h	WORD	supported addressing match modes
		bit 0: any address
		    1: equal to test value
		    2: not equal
		    3: above test value
		    4: below test value
		    5: below or equal
		    6: above or equal
		    7: within range
		    8: outside range
 0Ah	WORD	supported data matches
		bit 0: any data
		    1: equal to test value
		    2: not equal
		    3: above test value
		    4: below test value
		    5: below or equal
		    6: above or equal
		    7: within range
		    8: outside range
 0Ch	BYTE	maximum data match length (01h, 02h, or 04h)
 0Dh	WORD	size of onboard memory (in K)
 0Fh	WORD	maximum number of trace-back events
 11h	WORD	hardware breakpoint enable byte address segment (0000h if not
		supported)
---status for command 04h---
 01h	BYTE	handle to use when referring to the just-set breakpoint
----------2140-------------------------------
INT 21 - DOS 2+ - "WRITE" - WRITE TO FILE OR DEVICE
	AH = 40h
	BX = file handle
	CX = number of bytes to write
	DS:DX -> data to write
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (05h,06h) (see AH=59h)
Notes:	if CX is zero, no data is written, and the file is truncated or
	  extended to the current position
	data is written beginning at current file position, and the file
	  position is updated after a successful write
	the usual cause for AX < CX on return is a full disk
SeeAlso: AH=28h,AH=3Fh,INT 2F/AX=1109h
----------2140-------------------------------
INT 21 - Turbo Debug HARDWARE BREAKPOINTS - SEND CMD TO HARDWARE BRKPNT DRIVER
	AH = 40h
	BX = handle for character device "TDHDEBUG"
	CX = number of bytes to write
	DS:DX -> hardware breakpoint command (see below)
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (05h,06h) (see AH=59h)
Note:	results are retrieved by reading from the device
SeeAlso: AH=3Fh"Turbo Debug"

Format of hardware breakpoint commands:
Offset	Size	Description
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
 02h	BYTE	address matching mode
		00h any address
		01h equal to test value
		02h different from test value
		03h above test value
		04h below test value
		05h below or equal to test value
		06h above or equal to test value
		07h within inclusive range
		08h outside specified range
 03h	DWORD	32-bit linear low address
 07h	DWORD	32-bit linear high address
 0Bh	WORD	pass count
 0Dh	BYTE	data size (01h, 02h, or 04h)
 0Eh	BYTE	source of matched bus cycle
		01h CPU
		02h DMA
		03h either
 0Fh	BYTE	data-matching mode
		00h match any
		01h equal to test value
		02h different from test value
		03h above test value
		04h below test value
		05h below or equal to test value
		06h above or equal to test value
		07h within specified range
		08h outside specified range
 10h	DWORD	low data value
 14h	DWORD	high data value
 18h	DWORD	data mask specifying which bits of the data are tested
---command code 05h---
 01h	BYTE	handle of breakpoint to clear (breakpoint returned from command
		04h)
---command code 06h---
 01h	WORD	base address of hardware debugger board
----------214000BX0002-----------------------
INT 21 - FARTBELL.EXE - INSTALLATION CHECK
	AX = 4000h
	BX = 0002h
	CX = 0000h
	DS:DX = 0000h:0000h
Return: CF clear if installed
	    AX = CS of resident code
Note:	FARTBELL is a joke program by Guenther Thiele which makes various
	  noises when programs output a bell
SeeAlso: AX=4001h
----------214001BX0002-----------------------
INT 21 - FARTBELL.EXE - FORCE NOISE
	AX = 4001h
	BX = 0002h
	CX = 0000h
	DS:DX = 0000h:0000h
Note:	FARTBELL is a joke program by Guenther Thiele which makes various
	  noises when programs output a bell
SeeAlso: AX=4000h
----------2141-------------------------------
INT 21 - DOS 2+ - "UNLINK" - DELETE FILE
	AH = 41h
	DS:DX -> ASCIZ filename (no wildcards, but see below)
	CL = attribute mask for deletion (server call only, see below)
Return: CF clear if successful
	    AX destroyed (DOS 3.3) AL seems to be drive of deleted file
	CF set on error
	    AX = error code (02h,03h,05h) (see AH=59h)
Notes:	(DOS 3.1+) wildcards are allowed if invoked via AX=5D00h, in which case
	  the filespec must be canonical (as returned by AH=60h), and only
	  files matching the attribute mask in CL are deleted
	DOS does not erase the file's data; it merely becomes inaccessible
	  because the FAT chain for the file is cleared
	deleting a file which is currently open may lead to filesystem
	  corruption.  Unless SHARE is loaded, DOS does not close the handles
	  referencing the deleted file, thus allowing writes to a nonexistant
	  file.
SeeAlso: AH=13h,AX=4301h,AX=5D00h,AH=60h,INT 2F/AX=1113h
----------214101DXFFFE-----------------------
INT 21 - SoftLogic Data Guardian - ???
	AX = 4101h
	DX = FFFEh
Return: AX = 0000h if installed
Note:	resident code sets several internal variables on this call
----------2142-------------------------------
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
SeeAlso: AH=24h,INT 2F/AX=1228h
----------214203-----------------------------
INT 21 - VIRUS - "Shake" - INSTALLATION CHECK
	AX = 4203h
Return: AX = 1234h if resident
SeeAlso: AX=3DFFh,AX=4243h
----------214243-----------------------------
INT 21 - VIRUS - "Invader" - INSTALLATION CHECK
	AX = 4243h
Return: AX = 5678h if resident
SeeAlso: AX=4203h,AX=4B04h
----------214300-----------------------------
INT 21 - DOS 2+ - GET FILE ATTRIBUTES
	AX = 4300h
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    CX = attributes (see AX=4301h)
	    AX = CX (DR-DOS 5.0)
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see AH=59h)
SeeAlso: AX=4301h,AH=B6h,INT 2F/AX=110Fh
----------214301-----------------------------
INT 21 - DOS 2+ - "CHMOD" - SET FILE ATTRIBUTES
	AX = 4301h
	CX = new attributes
	    bit 8: shareable (Novell NetWare)
		7: unused
		6: unused
		5: archive
		4: directory
		3: volume label
		2: system
		1: hidden
		0: read-only
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see AH=59h)
Notes:	will not change volume label or directory attributes
	MSDOS 4.01 reportedly closes the file if it is currently open
SeeAlso: AX=4300h,INT 2F/AX=110Eh
----------214302-----------------------------
INT 21 - DR-DOS 3.41+ internal - GET ACCESS RIGHTS
	AX = 4302h
	DS:DX -> ASCIZ pathname
Return: CF clear if successful
	    CX = access rights
		bit 0 delete requires password
		bit 2 write requires password
		bit 3 read requires password
		bits 4-7=equal to bits 0-3
		bits 8-11=equal to bits 0-3
	    AX = CX (DR-DOS 5.0)
	CF set on error
	    AX = error code
SeeAlso: AX=4303h
----------214303-----------------------------
INT 21 - DR-DOS 3.41+ internal - SET ACCESS RIGHTS AND PASSWORD
	AX = 4303h
	CX = access rights
	     bit 0 delete requires password
	     bit 2 write requires password
	     bit 3 read requires password
	     bits 4-7=equal to bits 0-3
	     bits 8-11=equal to bits 0-3
	     bit 15 new password is to be set
	DS:DX -> ASCIZ pathname
	[DTA] = new password if CX bit 15 is set (blank-padded to 8 characters)
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	if the file is already protected, the old password must be added after
	  the pathname, separated by a ";"
SeeAlso: AX=4302h,AX=4454h
----------214304-----------------------------
INT 21 - DR-DOS 5.0 internal - GET ???
	AX = 4304h
	???
Return: CF clear if successful
	    CX = AX = ???
	CF set on error
	    AX = error code (see AH=59h)
SeeAlso: AX=4305h
----------214305-----------------------------
INT 21 - DR-DOS 5.0 internal - SET ???
	AX = 4305h
	???
Return: CF clear if successful
	CF set on error
	    AX = error code (see AH=59h)
SeeAlso: AX=4304h
----------214400-----------------------------
INT 21 - DOS 2+ - IOCTL - GET DEVICE INFORMATION
	AX = 4400h
	BX = handle
Return: CF clear if successful
	    DX = device information word
		character device
		  14: device driver can process IOCTL requests (see AX=4402h)
		  13: output until busy supported
		  11: driver supports OPEN/CLOSE calls
		   7: set (indicates device)
		   6: EOF on input
		   5: raw (binary) mode
		   4: device is special (uses INT 29)
		   3: clock device
		   2: NUL device
		   1: standard output
		   0: standard input
		disk file
		  15: file is remote (DOS 3+)
		  14: don't set file date/time on closing (DOS 3+)
		  11: media not removable
		   8: (DOS 4+) generate INT 24 if no disk space on write
		   7: clear (indicates file)
		   6: file has not been written
		 5-0: drive number (0 = A:)
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h) (see AH=59h)
Note:	value in DH corresponds to high byte of device driver's attribute word
	  if handle refers to a character device
SeeAlso: AX=4401h,INT 2F/AX=122Bh
----------214401-----------------------------
INT 21 - DOS 2+ - IOCTL - SET DEVICE INFORMATION
	AX = 4401h
	BX = handle (must refer to character device)
	DX = device information word (see AX=4400h)
	    (DH must be zero)
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4400h,INT 2F/AX=122Bh
----------214402-----------------------------
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
----------214402-----------------------------
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

Values of status code:
 0000h success
 0001h wait for release--protocol has retained control of the data buffer
 0002h request queued
 0003h frame not recognized
 0004h frame rejected
 0005h frame should be forwarded
 0006h out of resource
 0007h invalid parameter
 0008h invalid function
 0009h not supported
 000Ah hardware error
 000Bh transmit error
 000Ch unrecognized destination
 000Dh buffer too small
 0020h already started
 0021h binding incomplete
 0022h driver not initialized
 0023h hardware not found
 0024h hardware failure
 0025h configuration failure
 0026h interrupt conflict
 0027h MAC incompatible
 0028h initialization failed
 0029h no binding
 002Ah network may be disconnected
 002Bh incompatible OS version
 002Ch already registered
 002Dh path not found
 002Eh insufficient memory
 002Fh info not found
 00FFh general failure
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
 1Ch	BYTE	upper boundary protocol level
		01h Media Access Control
		02h Data link
		03h network
		04h transport
		05h session
		FFh not specified
 1Dh	BYTE	upper boundary interface type
		for MACs: 1 = MAC
		for data links and transports: to be defined
		for session: 1 = NCB
		any level: 0 = private (ISV-defined)
 1Eh	BYTE	lower boundary protocol level
		00h physical
		01h Media Access Control
		02h Data link
		03h network
		04h transport
		05h session
		FFh not specified
 1Fh	BYTE	lower boundary interface type
		same as offset 1Dh
 20h	WORD	module ID filled in by protocol manager
 22h	WORD	module DS
 24h	DWORD	system request entry point
 28h	DWORD	pointer to service-specific characteristics
		0000h:0000h if none
 2Ch	DWORD	pointer to service-specific status
		0000h:0000h if none
 30h	DWORD	pointer to upper dispatch table (see below)
		0000h:0000h if none
 34h	DWORD	pointer to lower dispatch table (see below)
		0000h:0000h if none
 38h	DWORD	reserved, must be 0
 3Ch	DWORD	reserved, must be 0
Note:	for compatibility with NDIS 1.x.x, a major version of 00h is
	  interpreted as 01h

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
 40h	DWORD	service flags
		bit 0: supports broadcast
		    1: supports multicast
		    2: supports functional/group addressing
		    3: supports promiscuous mode
		    4: station address software settable
		    5: statistics always current
		    6: supports InitiateDiagnostics
		    7: supports loopback
		    8: MAC does primarily ReceiveChain indications instead of
		       ReceiveLookahead indications
		    9: supports IBM source routing
		   10: supports MAC reset
		   11: supports Open/Close adapter
		   12: supports interrupt request
		   13: supports source routing bridge
		   14: supports GDT virtual addresses (OS/2 version)
		   15: multiple TransferDatas allowed durign a single
		       indication
		   16: MAC normally sets FrameSize = 0 in ReceiveLookahead
		   17-31: reserved, must be 0
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
 06h	DWORD	MAC status bits
		bits 0-2: 000 hardware not installed
			  001 hardware failed startup diagnostics
			  010 hardware configuration problem
			  011 hardware fault
			  100 operating marginally due to soft faults
			  101 reserved
			  110 reserved
			  111 hardware fully operational
		bit 3:	  MAC bound
		    4:	  MAC open
		    5:	  diagnostics in progress
		    6-31: reserved
 0Ah	WORD	current packet filter flags
		bit 0: directed/multicast or group/functional
		    1: broadcast
		    2: promiscuous
		    3: all source routing
		    4-15: reserved, must be zero
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
----------214402-----------------------------
INT 21 - IBM SYSTEM 36/38 WORKSTATION EMULATION - VDI.SYS - GET ???
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
----------214402-----------------------------
INT 21 - LASTBYTE.SYS v1.19 - IOCTL - GET ??? TABLE
	AX = 4402h
	BX = handle for device "LA$TBYTE"
	CX = 0004h
	DS:DX -> DWORD to hold address of 39-byte table of ???
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    AX = number of bytes read
Note:	LASTBYTE.SYS is part of "The Last Byte" by Key Software Products
SeeAlso: AX=4402h"HIGHUMM"
----------214402-----------------------------
INT 21 - HIGHUMM.SYS v1.17+ - IOCTL - GET API ADDRESS
	AX = 4402h
	BX = handle for device "KSP$UMM"
	CX = 0004h
	DS:DX -> DWORD to hold entry point
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    AX = number of bytes read
Note:	HIGHUMM.SYS is part of "The Last Byte" by Key Software Products
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
----------214402-----------------------------
INT 21 - SMARTDRV.SYS - IOCTL - GET CACHE STATUS
	AX = 4402h
	BX = file handle for device "SMARTAAR"
	CX = number of bytes to read (min 28h)
	DS:DX -> buffer for status record (see below)
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4403h"SMARTDRV"

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
----------214402-----------------------------
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

Format of control block:
Offset	Size	Description
 00h	BYTE	data being requested
		00h device driver header address
		01h drive head location
		02h reserved
		03h error statistics
		04h audio channel info
		05h raw drive bytes (uninterpreted and device-specific)
		06h device status
		07h sector size
		08h volume size
		09h media change status
		0Ah audio disk info
		0Bh audio track info
		0Ch audio Q-Channel info
		0Dh audio sub-channel info
		0Eh UPC code
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
 01h	DWORD	device parameters
		bit 0: door open
		    1: door unlocked
		    2: supports raw reading in addition to cooked
		    3: writable
		    4: can play audio/video tracks
		    5: supports interleaving
		    6: reserved
		    7: supports prefetch requests
		    8: supports audio channel control
		    9: supports Red Book addressing in addition to HSG
		   10: audio is playing
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
----------214402-----------------------------
INT 21 - QEMM-386 v5+ - IOCTL INPUT - GET API ENTRY POINT
	AX = 4402h
	BX = file handle for device "QEMM386$"
	CX = 0004h
	DS:DX -> DWORD buffer for API entry point
Return: CF clear if successful
	    buffer filled (see INT 67/AH=3Fh for entry point parameters)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4402h"HOOKROM",INT 2F/AX=D201h/BX=5145h,INT 67/AH=3Fh
----------214402-----------------------------
INT 21 - Quarterdeck HOOKROM.SYS - IOCTL INPUT - GET HOOKED VECTOR TABLE
	AX = 4402h
	BX = file handle for device "HOOKROM$"
	CX = 0004h
	DS:DX -> DWORD buffer for address of hooked vector table (see below)
Return: CF clear if successful
	    DS:DX buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
SeeAlso: AX=4402h"QEMM"

Format of hooked vector table entry:
Offset	Size	Description
 00h  5 BYTEs	FAR jump to actual interrupt handler
 		(end of table if first byte is not EAh)
 05h	BYTE	interrupt vector number
----------214402-----------------------------
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
SeeAlso: AX=440Ch"ASPITAPE"

Format of SCSI Request Block (64 bytes):
Offset	Size	Description
 00h	BYTE	request command
		00h "HA_INQ" - host adapter inquiry
		01h "GET_TYPE" - get device type
		02h "EXEC_SIO" - execute SCSI I/O
		03h "ABORT_SRB" - abort SRB
		04h "RESET_DEV" - reset SCSI device
		05h "SET_HAPRMS" - set host adapter parameters
 01h	BYTE	request status
		00h not done yet
		else status
 02h	BYTE	host adapter ID
 03h	BYTE	request flags
 04h	DWORD	reserved
 08h	BYTE	target ID
 09h	BYTE	logical unit number
 0Ah	DWORD	data allocation length
 0Eh	BYTE	sense allocation length
 0Fh	DWORD	data buffer pointer
 13h	DWORD	next request pointer (for linking)
 17h	BYTE	CDB length
 18h	BYTE	host adapter status
 19h	BYTE	target status
 1Ah	DWORD	post routine address
 1Eh	WORD	real mode Post DS
 20h	DWORD	SRB pointer
 24h	WORD	reserved
 26h	DWORD	SRB physical address
 2Ah 22 BYTES	SCSIMGR$ workspace
----------214403-----------------------------
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
----------214403-----------------------------
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
SeeAlso: AX=4402h"SMARTDRV"

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
----------214403-----------------------------
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
----------214403-----------------------------
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
----------214404-----------------------------
INT 21 - DOS 2+ - IOCTL - READ FROM BLOCK DEVICE CONTROL CHANNEL
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = number of bytes to read
	DS:DX -> buffer
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see AH=59h)
Note:	format of data is driver-specific
SeeAlso: AX=4402h,AX=4405h,INT 2F/AX=122Bh
----------214404-----------------------------
INT 21 - Stacker - GET DEVICE DRIVER ADDRESS AND SET VOLUME NUMBER
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = 0004h
	DS:DX -> DWORD buffer to receive device driver address
Note:	In addition to returning the address of the Stacker device driver,
	  this call also sets the volume number at offset 3Eh in the device
	  driver (see INT 25/AX=CDCDh)
SeeAlso: INT 25/AX=CDCDh
----------214404-----------------------------
INT 21 - Stacker - GET STACVOL FILE SECTORS
	AX = 4404h
	BL = drive number (0 is current drive)
	CX = byte count (i.e., 200h = 1 sector)
	DS:DX -> buffer (see below)
Return:	Data Buffer contains the number of sectors requested from the
	  STACVOL physical file for the drive specified.

Format of stacker buffer:
Offset	Size	Description
 00h	WORD	01CDh
 02h	WORD	sector count
 04h	DWORD	number of starting sector
 08h	DWORD	far pointer to Data Buffer
----------214405-----------------------------
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
----------214405-----------------------------
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
----------214406-----------------------------
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
----------214407-----------------------------
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
----------214408-----------------------------
INT 21 - DOS 3.0+ - IOCTL - CHECK IF BLOCK DEVICE REMOVABLE
	AX = 4408h
	BL = drive number (00h = default, 01h = A:, etc)
Return: CF clear if successful
	    AX = 0000h if removable
	       = 0001h if fixed
	CF set on error
	    AX = error code (01h,0Fh) (see AH=59h)
SeeAlso: AX=4400h,AX=4409h,INT 2F/AX=122Bh
----------214409-----------------------------
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
	  bits appear to be undefined
SeeAlso: AX=4400h,AX=4408h,AX=440Ah,INT 2F/AX=122Bh
----------21440A-----------------------------
INT 21 - DOS 3.1+ - IOCTL - CHECK IF HANDLE IS REMOTE
	AX = 440Ah
	BX = handle
Return: CF clear if successful
	    DX = attribute word (as stored in SFT)
		bit 15: set if remote
		bit 14: date/time not set on close
	CF set on error
	    AX = error code (01h,06h) (see AH=59h)
Note:	if file is remote, Novell Advanced NetWare 2.0 returns the number of
	  the file server on which the handle is located in CX
SeeAlso: AX=4400h,AX=4409h,AH=52h,INT 2F/AX=122Bh
----------21440B-----------------------------
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
----------21440C-----------------------------
INT 21 - DOS 3.2+ - IOCTL - GENERIC CHARACTER DEVICE REQUEST
	AX = 440Ch
	BX = device handle
	CH = category code
	    00h unknown (DOS 3.3+)
	    01h COMn: (DOS 3.3+)
	    03h CON (DOS 3.3+)
	    05h LPTn:
	    9Eh Media Access Control driver (STARLITE)
	CL = function
	    00h MAC driver Bind (STARLITE)
	    45h set iteration count
	    4Ah select code page
	    4Ch start code-page preparation
	    4Dh end code-page preparation
	    5Fh set display information (DOS 4.0)
	    65h get iteration count
	    6Ah query selected code page
	    6Bh query prepare list
	    7Fh get display information (DOS 4.0)
	DS:DX -> (DOS) parameter block (see below)
	SI:DI -> (OS/2 comp box) parameter block (see below)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    DS:DX -> iteration count if CL=65h
	DS:DX -> (OS/2 comp box) data block
SeeAlso: AX=440Dh,INT 2F/AX=0802h,INT 2F/AX=122Bh,INT 2F/AX=1A01h

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

Format of parameter block for function 4Dh:
Offset	Size	Description
 00h	WORD	length of data
 02h	WORD	code page ID

Format of parameter block for function 4Ch:
Offset	Size	Description
 00h	WORD	flags
		DISPLAY.SYS = 0000h
		PRINTER.SYS bit 0 clear to prepare downloaded font, set to
			prepare cartridge selection
 02h	WORD	length of remainder of parameter block
 04h	WORD	number of code pages following
 06h  N WORDs	code page 1,...,N

Format of parameter block for functions 5Fh and 7Fh:
Offset	Size	Description
 00h	BYTE	level (0 for DOS 4.x and 5.0)
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
----------21440C-----------------------------
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
 04h	BYTE	current device state
		bit 0: device currently opened in buffered mode
		bit 1: drive currently opened in nonbuffered mode
		bit 2: rewind drive on last close
		bit 3: drive has been written on
		bit 4: drive has been read from
		bit 5: next read will return 0 bytes
		bit 6: EOM will resemble EOF
		bit 7: drive may be busy rewinding
 05h	BYTE	unit number within driver
 06h	WORD	fixed block blocksize
 08h	BYTE	last SCSI status
 09h	BYTE	last SCSI sense key
 0Ah	WORD	last SCSI opcode (packed)
		bits 0-7: SCSI operation (SCSI packet byte 0)
		bits 8-10: SCSI flags (SCSI packet byte 1)
		bits 11-12: ASPI "Direction Bits" (ASPI SRB byte 3)
 0Ch	WORD	residual bytes from SCSI opcode
----------21440D-----------------------------
INT 21 - DOS 3.2+ - IOCTL - GENERIC BLOCK DEVICE REQUEST
	AX = 440Dh
	BL = drive number (00h=default,01h=A:,etc)
	CH = category code
	    08h disk drive
	CL = function
	    40h set device parameters
	    41h write logical device track
	    42h format and verify logical device track
	    46h (DOS 4+) set volume serial number (see also AH=69h)
	    47h (DOS 4+) set access flag
	    60h get device parameters
	    61h read logical device track
	    62h verify logical device track
	    66h (DOS 4+) get volume serial number (see also AH=69h)
	    67h (DOS 4+) get access flag
	    68h (DOS 5+) sense media type
	DS:DX -> (DOS) parameter block (see below)
	SI:DI -> (OS/2 comp box) parameter block (see below)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    DS:DX -> data block if CL=60h or CL=61h
Notes:	DOS 4.01 seems to ignore the high byte of the number of directory
	  entries in the BPB for diskettes.
	functions 46h and 66h undocumented in DOS 4.x, documented for DOS 5.0
SeeAlso: AX=440Ch,AH=69h,INT 2F/AX=0802h,INT 2F/AX=122Bh

Format of parameter block for functions 40h, 60h:
Offset	Size	Description
 00h	BYTE	special functions
		bit 0 set if function to use current BPB, clear if Device
			BIOS Parameter Block field contains new default BPB
		bit 1 set if function to use track layout fields only
			must be clear if CL=60h
		bit 2 set if all sectors in track same size (should be set)
		bits 3-7 reserved
 01h	BYTE	device type
		00h  320K/360K disk
		01h  1.2M disk
		02h  720K disk
		03h  single-density 8-inch disk
		04h  double-density 8-inch disk
		05h  fixed disk
		06h  tape drive
		07h  (DOS 3.3+) 1.44M floppy
		08h  read/write optical disk
		09h  (DOS 5.0) 2.88M floppy
		0Ah  other type of block device
 02h	WORD	device attributes
		bit 0 set if nonremovable medium
		bit 1 set if door lock supported
		bits 2-15 reserved
 04h	WORD	number of cylinders
 06h	BYTE	media type
		for 1.2M drive
		    00h 1.2M disk (default)
		    01h 320K/360K disk
		always 00h for other drive types
 07h 31 BYTEs	device BPB (see AH=53h), bytes after BPB offset 1Eh omitted
 26h	WORD	number of sectors per track (start of track layout field)
		not used by function 60h
 28h  N word pairs: number,size of each sector in track

Format of parameter block for functions 41h, 61h:
Offset	Size	Description
 00h	BYTE	special functions (reserved, must be zero)
 01h	WORD	number of disk head
 03h	WORD	number of disk cylinder
 05h	WORD	number of first sector to read/write
 07h	WORD	number of sectors
 09h	DWORD	transfer address

Format of parameter block for functions 42h, 62h:
Offset	Size	Description
 00h	BYTE	reserved, must be zero (DOS <3.2)
		  bit 0=0: format/verify track
			1: format status call (DOS 3.2+)
		  bits 1-7 reserved, must be zero
		on return (DOS 4.x):
		  bit 0: set if specified tracks, sectors/track supported
		  bit 1: set if function not supported by BIOS
		  bit 2: set if specified tracks, sectors/track not supported
		  bit 3: set if no disk in drive
 01h	WORD	number of disk head
 03h	WORD	number of disk cylinder

Format of parameter block for functions 46h, 66h:
Offset	Size	Description
 00h	WORD	info level (00h)
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
 01h	BYTE	02h for 720K, 07h for 1.44M, 09h for 2.88M
----------21440E-----------------------------
INT 21 - DOS 3.2+ - IOCTL - GET LOGICAL DRIVE MAP
	AX = 440Eh
	BL = drive number (00h=default,01h=A:,etc)
Return: CF set on error
	    AX = error code (01h,0Fh) (see AH=59h)
	CF clear if successful
	    AL = 00h block device has only one logical drive assigned
		 1..26 the last letter used to reference the drive (1=A:,etc)
SeeAlso: AX=440Fh,INT 2F/AX=122Bh
----------21440F-----------------------------
INT 21 - DOS 3.2+ - IOCTL - SET LOGICAL DRIVE MAP
	AX = 440Fh
	BL = physical drive number (00h=default,01h=A:,etc))
Return: CF set on error
	    AX = error code (01h,0Fh) (see AH=59h)
	CF clear if successful
	    drive now responds to next logical drive number
Note:	maps logical drives to physical drives, similar to DOS's treatment of
	  a single physical floppy drive as both A: and B:
SeeAlso: AX=440Eh,INT 2F/AX=122Bh
----------214410-----------------------------
INT 21 - DOS 5.0 - IOCTL - QUERY GENERIC IOCTL CAPABILITY (HANDLE)
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
----------214410BXFFFF-----------------------
INT 21 - NewSpace - ENABLE DRIVER
	AX = 4410h
	BX = FFFFh
Notes:	NewSpace is a TSR by Isogon Corporation which automatically compresses
	  all files as they are written and decompresses them as they are read
	compressed files are not accessible unless the driver is enabled
SeeAlso: AX=4411h/BX=FFFFh
----------214411-----------------------------
INT 21 - DOS 5.0 - IOCTL - QUERY GENERIC IOCTL CAPABILITY (DRIVE)
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
----------214411BXFFFF-----------------------
INT 21 - NewSpace - DISABLE DRIVER
	AX = 4411h
	BX = FFFFh
Notes:	NewSpace is a TSR by Isogon Corporation which automatically compresses
	  all files as they are written and decompresses them as they are read
	compressed files are not accessible unless the driver is enabled
SeeAlso: AX=4410h/BX=FFFFh
----------214412-----------------------------
INT 21 - DR-DOS 5.0 - DETERMINE DOS TYPE
	AX = 4412h
	CF set
Return: CF set if not DR DOS
	    AX = error code (see AH=59h)
	CF clear if DR DOS
	    DX = AX = version code
		1060h = ???
		1063h = DR-DOS 3.41 ???
		1065h = DR-DOS 5.0
		1067h = DR-DOS 6.0
Note:	this call is identical to AX=4452h
SeeAlso: AX=4452h
----------214412BXFFFF-----------------------
INT 21 - NewSpace - INSTALLATION CHECK???
	AX = 4412h
	BX = FFFFh
Return: AX = PSP segment of NewRes (resident driver for NewSpace)
	BX:DX -> ???
	CX = ???
SeeAlso: AX=4411h/BX=FFFFh
----------214413BXFFFF-----------------------
INT 21 - NewSpace - GET ???
	AX = 4413h
	BX = FFFFh
Return: AX = code segment of NewRes (resident driver for NewSpace)
	BX = offset of ???
SeeAlso: AX=4412h/BX=FFFFh
----------214414-----------------------------
INT 21 - DR-DOS 5.0 - SET GLOBAL PASSWORD
	AX = 4414h
	DS:DX -> password string (blank-padded to 8 characters)
Note:	this call is identical to AX=4454h
SeeAlso: AX=4454h
----------214414BXFFFF-----------------------
INT 21 - NewSpace - DEBUGGING DUMP
	AX = 4414h
	BX = FFFFh
Return:	debugging dump written to X:\NEWSPACE.SMP
SeeAlso: AX=4413h/BX=FFFFh,AX=44FFh/BX=FFFFh
---------------------------------------------
INT 21 - DR-DOS 5.0
	AH = 44h
	AL = 16h to 18h
Note:	these subfunctions are identical to AX=4456h to 4458h
SeeAlso: AX=4456h,AX=4457h,AX=4458h
----------214451-----------------------------
INT 21 - Concurrent DOS v3.2+ - INSTALLATION CHECK
	AX = 4451h
Return: CF set if not Concurrent DOS
	    AX = error code (see AH=59h)
	CF clear if successful
	    AH = 14h
	    AL = version (high nybble = major version, low nybble = minor ver)
SeeAlso: AX=4452h,AX=4459h
----------214452-----------------------------
INT 21 - DR DOS 3.41+ - IOCTL - DETERMINE DOS TYPE/GET DR-DOS VERSION
	AX = 4452h
	CF set
Return: CF set if not DR DOS
	    AX = error code (see AH=59h)
	CF clear if DR DOS
	    DX = AX = version code
		1060h = ???
		1063h = DR-DOS 3.41 ???
		1065h = DR-DOS 5.0
		1067h = DR-DOS 6.0
Notes:	the DR-DOS version is stored in the environment variable VER
SeeAlso: AX=4412h,AX=4451h,AX=4459h
----------214454-----------------------------
INT 21 - DR-DOS 3.41+ internal - SET GLOBAL PASSWORD
	AX = 4454h
	DS:DX -> password string (blank-padded to 8 characters)
SeeAlso: AX=4303h,AX=4414h
----------214456-----------------------------
INT 21 - DR-DOS 5.0+ internal - ???
	AX = 4456h
	DL = flag
	    bit 0: ???
Return: AL = ???
Note:	This was seen called by COMMAND.COM of DR-DOS 6.0
----------214457-----------------------------
INT 21 - DR-DOS 5.0+ internal - ???
	AX = 4457h
	DH = 00h
	    DL = 00h ???
	       = 01h ???
	       else Return: AX = ???
	   = 01h
	   	Return: AX = ???
	   = 02h
	   	DL = ???
		Return: AX = ???
	   = other
	   	Return: AX = ???
Note:	This was seen called by COMMAND.COM of DR-DOS 6.0
----------214458-----------------------------
INT 21 - DR DOS 5.0+ internal - GET POINTER TO TABLE OF ???
	AX = 4458h
Return: ES:BX -> internal table (see below)
	AX = ??? (0B50h for DR-DOS 5.0, 0A56h for DR-DOS 6.0)
SeeAlso: AX=4452h

Format of internal table:
Offset	Size	Description
 00h	DWORD	pointer to ???
 04h  7 BYTEs	???
 0Bh	WORD	K of extended memory at startup
 0Dh	BYTE	number of far jump entry points
 0Eh	WORD	segment containing far jumps to DR-DOS entry points (see below)
 10h	WORD	???
 12h	WORD	pointer to segment of environment variables set in CONFIG,
		or 0000h if already used (DR-DOS 6.0 only)
 14h	???	???
Note:	the segment used for the DR-DOS 6.0 CONFIG environment variables
	  (excluding COMSPEC, VER and OS) is only useful for programs/drivers
	  called from CONFIG.SYS. The word is set to zero later and the area
	  lost.

Format of jump table for DR-DOS 5.0-6.0:
Offset	Size	Description
 00h  5 BYTEs	far jump to entry point corresponding to CP/M CALL 5
 05h  5 BYTEs	far jump to entry point corresponding to INT 20
 0Ah  5 BYTEs	far jump to entry point corresponding to INT 21
 0Fh  5 BYTEs	far jump to entry point corresponding to ???
 14h  5 BYTEs	far jump to entry point corresponding to ???
 19h  5 BYTEs	far jump to entry point corresponding to ???
 1Eh  5 BYTEs	far jump to entry point corresponding to ???
 23h  5 BYTEs	far jump to entry point corresponding to ???
 28h  5 BYTEs	far jump to entry point corresponding to ???
 2Dh  5 BYTEs	far jump to entry point corresponding to ???
 32h  5 BYTEs	far jump to entry point corresponding to ??? (IRET)
 37h  5 BYTEs	far jump to entry point corresponding to ??? (IRET)
 3Ch  5 BYTEs	far jump to entry point corresponding to ??? (IRET)
 41h  5 BYTEs	far jump to entry point corresponding to ??? (IRET)
 46h  5 BYTEs	far jump to entry point corresponding to ??? (IRET)
 4Bh  5 BYTEs	far jump to entry point corresponding to ???
----------214459-----------------------------
INT 21 - DR MultiUser DOS 5.0 - API
	AX = 4459h
	CL = function (see below)
	DS,DX = parameters
SeeAlso: AX=4452h
Note:	DR-DOS 5.0 returns CF set and AX=0001h

Values for function number:
 00h	terminate calling process
 02h	write character to default console (see AH=02h)
 03h	read character from default AUX (see AH=03h)
 05h	write character to default list device (see AH=05h)
 06h	perform raw I/O on default console
 07h	return default AUX input status
 08h	return default AUX output status
 09h	write string to default console (see AH=09h)
 0Ah	read string from default console (see AH=0Ah)
 0Bh	return default console input status (see AH=0Bh)
 0Ch	get BDOS release ID
 0Dh	reset all disk drives (see AH=0Dh)
 0Eh	set default drive (see AH=0Eh)
 0Fh	open file via FCB (see AH=0Fh)
 10h	close file via FCB (see AH=10h)
 11h	search for first matching file with FCB (see AH=11h)
 12h	search for next matching file with FCB (see AH=12h)
 13h	delete file via FCB (see AH=13h)
 14h	sequential read via FCB (see AH=14h)
 15h	sequential write via FCB (see AH=15h)
 16h	create file via FCB (see AH=16h)
 17h	rename file via FCB (see AH=17h)
 18h	get bit map of logged drives
 19h	get default drive (see AH=19h)
 1Ah	set DMA address offset
 1Bh	get default disk allocation vector (see AH=1Bh)
 1Ch	set default drive to read-only
 1Dh	get bit map of read-only drives
 1Eh	set file attributes via FCB
 1Fh	get address of disk parameter block (see AH=1Fh)
 20h	get/set default user number
 21h	read random record via FCB (see AH=21h)
 22h	write random record via FCB (see AH=22h)
 23h	compute file size with FCB (see AH=23h)
 24h	get FCB random record number (see AH=24h)
 25h	reset specified drives
 26h	access specified drives
 27h	free specified drives
 28h	write random with FCB, zero fill (see also AH=28h)
 2Ah	lock records in FCB file (see AH=5Ch)
 2Bh	unlock records in FCB file (see AH=5Ch)
 2Ch	set BDOS multisector count
 2Dh	set BDOS error mode
 2Eh	get free space on disk
 2Fh	load, initialize, and jump to process
 30h	flush write-deferred buffers
 32h	call BIOS character routine
 33h	set DMA address segment
 34h	get DMA buffer address
 35h	CP/M-86 allocate maximum memory
 36h	allocate maximum memory segment absoute
 37h	CP/M-86 allocate memory segment
 38h	allocate memory segment absolute
 39h	CP/M-86 free specified memory segment
 3Ah	CP/M-86 free all memory
 3Bh	load .CMD file into memory
 40h	(DR-NET) log on a server
 41h	(DR-NET) log off a server
 42h	(DR-NET) send a message
 43h	(DR-NET) receive a message
 44h	(DR-NET) get network status
 45h	(DR-NET) get requestor configuration table
 46h	(DR-NET) set compatibility attributes
 47h	(DR-NET) get server configuration table
 48h	(DR-NET) set network error mode
 49h	(DR-NET) attach network
 4Ah	(DR-NET) detach network
 4Bh	(DR-NET) set default password
 4Ch	(DR-NET) get-set long timeout
 4Dh	(DR-NET) get parameter table
 50h	(DR-NET) get network information
 53h	get current time
 54h	set current time
 55h	get binary system date
 56h	set system date
 57h	allocate system flag
 58h	deallocate system flag
 59h	reserve memory in global area
 5Ah	lock physical drive
 5Bh	unlock physical drive
 5Ch	search path for executable file
 5Dh	load and execute command (see AH=4Bh)
 5Eh	get/set process exit code
 5Fh	set country information
 60h	get country information
 63h	truncate FCB file (see AH=28h)
 64h	create/update directory label
 65h	get directory label
 66h	get FCB date stamp and password mode
 67h	write extended FCB
 68h	set system date and time
 69h	get system date and time in binary
 6Ah	establish password for file access
 6Bh	get OS serial number
 6Dh	get/set console mode
 6Eh	get/set string delimiter
 6Fh	write block to default console
 70h	write block to default list device
 71h	execute DOS-compatible function
 74h	set FCB time and date stamps
 80h	allocate memory
 82h	deallocate memory
 83h	poll I/O device
 84h	wait on system flag
 85h	set system flag
 86h	create message queue
 87h	open message queue
 88h	delete message queue
 89h	read from message queue
 8Ah	conditionally read from message queue
 8Bh	write to message queue
 8Ch	conditionally write to message queue
 8Dh	delay calling process
 8Eh	call process dispatcher
 8Fh	terminate calling process
 90h	create a process
 91h	set calling process' priority
 92h	attach to default console
 93h	detach from default console
 95h	assign default console to process
 96h	interpret and execute commandline
 97h	resident procedure library
 98h	parse ASCII string into FCB (see AH=29h)
 99h	return default console
 9Ah	get address of system data
 9Bh	get system time and date
 9Ch	return calling process' descriptor
 9Dh	terminate process by name or PD address
 9Eh	attach to default list device
 9Fh	detach from default list device
 A0h	select default list device
 A1h	conditionally attach to default list device
 A2h	conditionally attach to default console
 A3h	get OS version number
 A4h	get default list device
 A5h	attach to default AUX
 A6h	detach from default AUX
 A7h	conditionally attach to default AUX
 A8h	set default AUX
 A9h	return default AUX
 ACh	read block from default AUX
 B0h	configure default AUX
 B1h	get/set device control parameters
 B2h	send Break through default AUX
 B3h	allocate physical memory
 B4h	free physical memory
 B5h	map physical memory
 B6h	nondestructive message queue read
 B7h	timed wait on system flag
 B8h	get/set I/O port mapping
 B9h	set list device timeout
 BAh	set AUX timeout value
 BBh	execute XIOS service
 FFh	return 80386 to native mode
----------2144FFBXFFFF-----------------------
INT 21 - NewSpace - ???
	AX = 44FFh
	BX = FFFFh
	DX = ???
SeeAlso: AX=4414h/BX=FFFFh
----------2145-------------------------------
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
----------2146-------------------------------
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
----------2147-------------------------------
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
SeeAlso: AH=19h,AH=3Bh
----------2148-------------------------------
INT 21 - DOS 2+ - ALLOCATE MEMORY
	AH = 48h
	BX = number of paragraphs to allocate
Return: CF clear if successful
	    AX = segment of allocated block
	CF set on error
	    AX = error code (07h,08h) (see AH=59h)
	    BX = size of largest available block
Notes:	DOS 3.30 coalesces free blocks while scanning for a block to allocate
	.COM programs are initially allocated the largest available memory
	  block, and should free some memory with AH=49h before attempting any
	  allocations
SeeAlso: AH=49h,AH=4Ah,AH=58h
----------2149-------------------------------
INT 21 - DOS 2+ - FREE MEMORY
	AH = 49h
	ES = segment of block to free
Return: CF clear if successful
	CF set on error
	    AX = error code (07h,09h) (see AH=59h)
Notes:	apparently never returns an error 07h, despite official docs; DOS 3.30
	  code contains only an error 09h exit
	DOS 3.30 does not coalesce adjacent free blocks when a block is freed,
	  only when a block is allocated or resized
SeeAlso: AH=48h,AH=4Ah
----------214A-------------------------------
INT 21 - DOS 2+ - RESIZE MEMORY BLOCK
	AH = 4Ah
	BX = new size in paragraphs
	ES = segment of block to resize
Return: CF clear if successful
	CF set on error
	    AX = error code (07h,08h,09h) (see AH=59h)
	    BX = maximum paragraphs available for specified memory block
Notes:	under PCDOS 2.1 and 3.1 and MSDOS 3.2 and 3.3, if there is insufficient
	  memory to expand the block as much as requested, the block will be
	  made as large as possible
	DOS 3.30 coalesces any free blocks immediately following the block to
	  be resized
SeeAlso: AH=48h,AH=49h
----------214B-------------------------------
INT 21 - DOS 2+ - "EXEC" - LOAD AND/OR EXECUTE PROGRAM
	AH = 4Bh
	AL = type of load
	    00h load and execute
	    01h load but do not execute
	    03h load overlay
	    04h load and execute in background (European MSDOS 4.0 only)
		(see also AH=80h)
	DS:DX -> ASCIZ program name (must include extension)
	ES:BX -> parameter block (see below)
Return: CF clear if successful
	    BX,DX destroyed
	    if subfunction 01h, process ID set to new program's PSP; get with
		INT 21/AH=62h
	CF set on error
	    AX = error code (01h,02h,05h,08h,0Ah,0Bh) (see AH=59h)
Notes:	DOS 2.x destroys all registers, including SS:SP
	for functions 00h and 01h, the calling process must ensure that there
	  is enough unallocated memory available; if necessary, by releasing
	  memory with AH=49h or AH=4Ah
	for function 01h, the value to be passed to the child program is put
	  on top of the child's stack
	for function 03h, DOS assumes that the overlay is being loaded into
	  memory allocated by the caller
	function 01h has been documented for DOS 5+, but was undocumented in
	  prior versions
BUG:	DOS 2.00 assumes that DS points at the current program's PSP
SeeAlso: AX=4B05h,AH=4Ch,AH=4Dh,INT 2E

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
 1Ah	WORD	overlay number (normally 0000h = main program)
---Borland TLINK---
 1Ch  2 BYTEs	??? (apparently always 01h 00h)
 1Eh	BYTE	signature FBh
 1Fh	BYTE	TLINK version (major in high nybble, minor in low nybble)
 20h  2 BYTEs	??? (v2.0 apparently always 72h 6Ah, v3.0 seems always 6Ah 72h)
---other linkers---
 1Ch	var	optional information
---
  N   N DWORDs	relocation items
---new executable only---
 3Ch	DWORD	offset of new executable header if offset of relocation table
		is 40h or greater
Notes:	if word at offset 02h is 4, it should be treated as 00h, since pre-1.10
	  versions of the MS linker set it that way
	if both minimum and maximum allocation (offset 0Ah/0Ch) are zero, the
	  program is loaded as high in memory as possible
	the maximum allocation is set to FFFFh by default

Format of new executable header:
Offset	Size	Description
 00h  2 BYTEs	"NE" (4Eh 45h) signature
 02h  2 BYTEs	linker version (major, then minor)
 04h	WORD	offset to entry table
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
		bit 7: DLL or driver rather than application
 0Eh	WORD	auto data segment index
 10h	WORD	initial local heap size
 12h	WORD	initial stack size
 14h	DWORD	program entry point (CS:IP)
 18h	DWORD	initial stack pointer (SS:SP)
 1Ch	WORD	segment count
 1Eh	WORD	module reference count
 20h	WORD	length of nonresident names table
 22h	WORD	offset from start of this header to segment table (see below)
 24h	WORD	offset from start of this header to resource table
 26h	WORD	offset from start of this header to resident names table
 28h	WORD	offset from start of this header to module reference table
 2Ah	WORD	offset from start of this header to imported names table
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
 37h	BYTE	other EXE flags
		bit 0: supports long filenames
		bit 1: 2.X protected mode
		bit 2: 2.X proportional font
		bit 3: gangload area
 38h	WORD	offset to return thunks or start of gangload area
 3Ah	WORD	offset to segment reference thunks or length of gangload area
 3Ch	WORD	minimum code swap area size
 3Eh  2 BYTEs	expected Windows version (minor version first)

Format of segment table record:
 00h	WORD	offset in file (shift left by alignment shift to get byte offs)
 02h	WORD	length of image in file
 04h	WORD	attributes
		bit 0,1,2: DATA segment flags
		bit 3: iterated
		bit 4: movable
		bit 5: sharable
		bit 6: preloaded
		bit 7: execute-only
		bit 8: relocations (directly following code for this segment)
		bit 9: debug info
		bits 10,11: 80286 DPL bits
		bit 12:	    discardable
		bits 13-15: discard priority
 06h	WORD	size to allocate

Enhanced Mode New executable header:
Offset	Size	Description
 00h  2 BYTEs	"LE" (4Ch 45h) signature
 02h	WORD	??? (may be linker version, but EXEHDR doesn't report it)
 04h	DWORD	executable format level
 08h	WORD	CPU type (see also INT 15/AH=C9h)
		01h Intel 80286 or upwardly compatibile
		02h Intel 80386 or upwardly compatibile			
		03h Intel 80486 or upwardly compatibile			
 0Ah	WORD	target operating system
		01h OS/2
		02h Windows
		03h DOS4.x
		04h Windows 386
 0Ch	DWORD	module version
 10h	DWORD	module type
		bit 2: initialization (only for DLLs)
			0 = global
			1 = per-process
		bit 4: no internal fixups in executable image
		bit 5: no external fixups in executable image
		bits 8,9,10:
			1 = incompatible with PM windowing \
			2 = compatible with PM windowing    > (only for
			3 = uses PM windowing API	   /	programs)
		bit 13: module not loadable (only for programs)
		bit 15: module is DLL rather than program
 14h	DWORD	number of memory pages
 18h	Initial CS:EIP
	DWORD	object
	DWORD	offset
 20h	Initial SS:ESP
	DWORD	object
	DWORD	offset
 28h	DWORD	memory page size
 2Ch	DWORD	bytes on last page
 30h	DWORD	fixup section size
 34h	DWORD	fixup section checksum
 38h	DWORD	loader section size
 3Ch	DWORD	loader section checksum
 40h	DWORD	object table offset
 44h	DWORD	object table entries
 48h	DWORD	010Ch ???
 4CH	DWORD	0000h ???
 50h	DWORD	resource table offset
 54h	DWORD	resource table entries
 58h	DWORD	resident names table offset
 5Ch	DWORD	entry table offset
 60h	DWORD	module directives table offset
 64h	DWORD	Module Directives entries
 68h	DWORD	??? apparently unknown table #1 offset
 6Ch	DWORD	??? apparently unknown table #2 offset
 70h	DWORD	imported modules name table offset
 74h	DWORD	imported modules
 78h	DWORD	imported procedures name table offset
 7Ch	DWORD	per-page checksum table offset
 80h	DWORD	preload pages ??? offset
 84h	DWORD	preload pages number
 88h	DWORD	non-resident names table offset
 8Ch	DWORD	non-resident names table length
 90h	DWORD	non-resident names checksum
 94h	DWORD	automatic data object
 98h	DWORD	debug information offset
 9Ch	DWORD	debug information length
 A0h	DWORD	preload instance pages number
 A4h	DWORD	demand instance pages number
 A8h	DWORD	extra heap allocation
 ACh	???
Note:	used by EMM386.EXE, QEMM, and Windows 3.0 Enhanced Mode drivers
----------214B-------------------------------
INT 21 - ELRES v1.0 only - INSTALLATION CHECK
	AH = 4Bh
	DS:DX = 0000h:0000h
Return: ES:BX -> ELRES history structure (see AH=2Bh/CX=454Ch)
	DX = DABEh (signature, DAve BEnnett)
Note:	ELRES is an MSDOS return code (errorlevel) recorder by David H. Bennett
SeeAlso: AH=2Bh/CX=454Ch
----------214B04-----------------------------
INT 21 - VIRUS - "MG", "699"/"Thirteen Minutes" - INSTALLATION CHECK
	AX = 4B04h
Return: CF clear if "MG" resident
	AX = 044Bh if "699"/"Thirteen Minutes" resident
SeeAlso: AX=4243h,AX=4B25h
----------214B05-----------------------------
INT 21 - DOS 5.0 - SET EXECUTION STATE
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
		    1: program is an overlay
 04h	DWORD	pointer to ASCIZ name of program file
 08h	WORD	PSP segment of new program
 0Ah	DWORD	starting CS:IP of new program
 0Eh	DWORD	program size including PSP
----------214B25-----------------------------
INT 21 - VIRUS - "1063"/"Mono" - INSTALLATION CHECK
	AX = 4B25h
Return: DI = 1234h if resident
SeeAlso: AX=4B04h,AX=4B40h
----------214B40-----------------------------
INT 21 - VIRUS - "Plastique"/"AntiCad" - INSTALLATION CHECK
	AX = 4B40h
Return: AX = 5678h if resident
SeeAlso: AX=4B25h,AX=4B41h,AX=4B4Ah
----------214B41-----------------------------
INT 21 - VIRUS - "Plastique"/"AntiCad" - ???
	AX = 4B41h
	???
Return: ???
SeeAlso: AX=4B40h
----------214B4A-----------------------------
INT 21 - VIRUS - "Jabberwocky" - INSTALLATION CHECK
	AX = 4B4Ah
Return: AL = 57h if resident
SeeAlso: AX=4B40h,AX=4B4Bh
----------214B4B-----------------------------
INT 21 - VIRUS - "Horse-2" - INSTALLATION CHECK
	AX = 4B4Bh
Return: CF clear if resident
SeeAlso: AX=4B4Ah,AX=4B4Dh
----------214B4D-----------------------------
INT 21 - VIRUS - "Murphy-2", "Patricia"/"Smack" - INSTALLATION CHECK
	AX = 4B4Dh
Return: CF clear if resident
SeeAlso: AX=4B4Ah,AX=4B50h
----------214B50-----------------------------
INT 21 - VIRUS - "Plastique-2576"/"AntiCad-2576" - INSTALLATION CHECK
	AX = 4B50h
Return: AX = 1234h if resident
SeeAlso: AX=4B4Dh,AX=4B53h,AX=4B60h
----------214B53-----------------------------
INT 21 - VIRUS - "Horse" - INSTALLATION CHECK
	AX = 4B53h
Return: CF clear if resident
SeeAlso: AX=4B50h,AX=4B55h
----------214B55-----------------------------
INT 21 - VIRUS - "Sparse" - INSTALLATION CHECK
	AX = 4B55h
Return: AX = 1231h if resident
SeeAlso: AX=4B53h,AX=4B59h
----------214B59-----------------------------
INT 21 - VIRUS - "Murphy-1", "Murphy-4" - INSTALLATION CHECK
	AX = 4B59h
Return: CF clear if resident
SeeAlso: AX=4B50h,AX=4B5Eh
----------214B5E-----------------------------
INT 21 - VIRUS - "Brothers" - INSTALLATION CHECK
	AX = 4B5Eh
Return: CF clear if resident
SeeAlso: AX=4B59h,AX=4B87h
----------214B60-----------------------------
INT 21 - VIRUS - "Plastique-2576"/"AntiCad-2576" - ???
	AX = 4B60h
	???
Return: ???
SeeAlso: AX=4B50h
----------214B87-----------------------------
INT 21 - VIRUS - "Shirley" - INSTALLATION CHECK
	AX = 4B87h
Return: AX = 6663h if resident
SeeAlso: AX=4B5Eh,AX=4B95h
----------214B95-----------------------------
INT 21 - VIRUS - "Zherkov-1882" - INSTALLATION CHECK
	AX = 4B95h
Return: AX = 1973h if resident
SeeAlso: AX=4B87h,AX=4BA7h
----------214BA7-----------------------------
INT 21 - VIRUS - "1876"/"Dash-em" - INSTALLATION CHECK
	AX = 4BA7h
Return: AX = B459h if resident
SeeAlso: AX=4B95h,AX=4BAAh
----------214BAA-----------------------------
INT 21 - VIRUS - "Nomenklatura" - INSTALLATION CHECK
	AX = 4BAAh
Return: CF clear if resident
SeeAlso: AX=4BA7h,AX=4BAFh
----------214BAF-----------------------------
INT 21 - VIRUS - "948"/"Screenplus1", "Magnitogorsk" - INSTALLATION CHECK
	AX = 4BAFh
Return: AL = AFh if "Magnitogorsk" resident
	AL = FAh if "948"/"Screenplus1" resident
SeeAlso: AX=4BAAh,AX=4BDDh
----------214BDD-----------------------------
INT 21 - VIRUS - "Lozinsky"/"Zherkov" - INSTALLATION CHECK
	AX = 4BDDh
Return: AX = 1234h
SeeAlso: AX=4BAFh,AX=4BFEh
----------214BEE-----------------------------
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
----------214BF0-----------------------------
INT 21 - DIET v1.10+ (Overlay Mode) - INSTALLATION CHECK
	AX = 4BF0h
Return: CF clear if installed
	    AX = 899Dh
Note:	DIET is an executable-compression program
SeeAlso: AX=4BF1h
----------214BF1-----------------------------
INT 21 - DIET v1.10+ (Overlay Mode) - EXPAND PROGRAM???
	AX = 4BF1h
Return: ???
SeeAlso: AX=4BF0h
----------214BFE-----------------------------
INT 21 - VIRUS - "Hitchcock", "Dark Avenger-1028", "1193" - INSTALLATION CHECK
	AX = 4BFEh
Return: AX = 1234h if "Hitchcock" resident
	AX = ABCDh if "1193"/"Copyright" resident
	DI = 55BBh if "Dark Avenger-1028" resident
SeeAlso: AX=4BDDh,AX=4BFFh"Justice"
----------214BFF-----------------------------
INT 21 - VIRUS - "USSR-707", "Justice", "Europe 92" - INSTALLATION CHECK
	AX = 4BFFh
Return: BL = FFh if "USSR-707" resident
	DI = 55AAh if "Justice" resident
	CF clear if "Europe 92" resident
SeeAlso: AX=4BFEh,AX=4BFFh"Cascade",AX=5252h
----------214BFFSI0000-----------------------
INT 21 - VIRUS - "Cascade" - INSTALLATION CHECK
	AX = 4BFFh
	SI = 0000h
	DI = 0000h
Return: DI = 55AAh if installed
SeeAlso: AX=4BFFh"Justice",AX=5252h
----------214C-------------------------------
INT 21 - DOS 2+ - "EXIT" - TERMINATE WITH RETURN CODE
	AH = 4Ch
	AL = return code
Return: never returns
Notes:	unless the process is its own parent (see AH=26h, offset 16h in PSP),
	  all open files are closed and all memory belonging to the process
	  is freed
	all network file locks should be removed before calling this function
SeeAlso: AH=00h,AH=26h,AH=4Bh,AH=4Dh,INT 20,INT 22
----------214D-------------------------------
INT 21 - DOS 2+ - GET RETURN CODE
	AH = 4Dh
Return: AH = termination type
	    00h normal (INT 20,INT 21/AH=00h, or INT 21/AH=4Ch)
	    01h control-C abort
	    02h critical error abort
	    03h terminate and stay resident (INT 21/AH=31h or INT 27)
	AL = return code
Note:	the word in which DOS stores the return code is cleared after being
	  read by this function, so the return code can only be retrieved once
SeeAlso: AH=4Bh,AH=4Ch
----------214E-------------------------------
INT 21 - DOS 2+ - "FINDFIRST" - FIND FIRST MATCHING FILE
	AH = 4Eh
	AL = special flag for use by APPEND (see note below)
	CX = file attribute mask (see AX=4301h) (bits 0 and 5 ignored)
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
BUG:	under DOS 3.x and 4.x, the second and subsequent calls to this function
	  with a character device name (no wildcards) and search attributes
	  which include the volume-label bit (08h) will fail unless there is
	  an intervening DOS call which implicitly or explicity performs a
	  directory search without the volume-label bit.  Such implicit
	  searches are performed by CREATE (AH=3Ch), OPEN (AH=3Dh), UNLINK
	  (AH=41h), and RENAME (AH=56h)
SeeAlso: AH=11h,AH=4Fh,AX=4301h,INT 2F/AX=111Bh,INT 2F/AX=B711h

Format of FindFirst data block:
Offset	Size	Description
---PCDOS 3.10, PCDOS 4.01, MSDOS 3.2/3.3/5.0---
 00h	BYTE	drive letter
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
---PCDOS 4.01, MSDOS 3.2/3.3/5.0---
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
----------214E-------------------------------
INT 21 - WILDUNIX.COM internal - INSTALLATION CHECK
	AH = 4Eh
	DS:DX = 0000h:0000h
Return:	AH = 99h if installed
Note:	WILDUNIX.COM is a resident Unix-style wildcard expander by Steve
	  Hosgood and Terry Barnaby
----------214F-------------------------------
INT 21 - DOS 2+ - "FINDNEXT" - FIND NEXT MATCHING FILE
	AH = 4Fh
	[DTA] = data block from previous FindFirst or FindNext call
Return: CF clear if successful
	CF set on error
	    AX = error code (12h) (see AH=59h)
SeeAlso: AH=12h,AH=4Eh
----------2150-------------------------------
INT 21 - DOS 2+ internal - SET CURRENT PROCESS ID (SET PSP ADDRESS)
	AH = 50h
	BX = segment of PSP for new process
Notes:	DOS uses the current PSP address to determine which processes own files
	  and memory; it corresponds to process identifiers used by other OSs
	under DOS 2.x, this function cannot be invoked inside an INT 28h
	  handler without setting the Critical Error flag
	under DOS 3+, this function does not use any of the DOS-internal stacks
	  and is thus fully reentrant
	supported by OS/2 compatibility box
	not documented for DOS 2.x-4.x, but newly documented for 5.0.
SeeAlso: AH=26h,AH=51h,AH=62h
----------2151-------------------------------
INT 21 - DOS 2+ internal - GET CURRENT PROCESS ID (GET PSP ADDRESS)
	AH = 51h
Return: BX = segment of PSP for current process
Notes:	DOS uses the current PSP address to determine which processes own files
	  and memory; it corresponds to process identifiers used by other OSs
	under DOS 2.x, this function cannot be invoked inside an INT 28h
	  handler without setting the Critical Error flag
	under DOS 3+, this function does not use any of the DOS-internal stacks
	  and is thus fully reentrant
	supported by OS/2 compatibility box
	identical to the documented AH=62h
	undocumented for DOS 2.x-4.x, but newly documented for 5.0.
SeeAlso: AH=26h,AH=50h,AH=62h
----------2152-------------------------------
INT 21 - DOS 2+ internal - "SYSVARS" - GET LIST OF LISTS
	AH = 52h
Return: ES:BX -> DOS list of lists
Note:	partially supported by OS/2 v1.1 compatibility box (however, most
	  pointers are FFFFh:FFFFh, LASTDRIVE is FFh, and the NUL header "next"
	  pointer is FFFFh:FFFFh).

Format of List of Lists:
Offset	Size	Description
 -12	WORD	(DOS 3.1-3.3) sharing retry count (see AX=440Bh)
 -10	WORD	(DOS 3.1-3.3) sharing retry delay (see AX=440Bh)
 -8	DWORD	(DOS 3.x) pointer to current disk buffer
 -4	WORD	(DOS 3.x) pointer in DOS code segment of unread CON input
		when CON is read via a handle, DOS reads an entire line,
		  and returns the requested portion, buffering the rest
		  for the next read.  0000h indicates no unread input
 -2	WORD	segment of first memory control block
 00h	DWORD	pointer to first Drive Parameter Block (see AH=32h)
 04h	DWORD	pointer to first System File Table (see below)
 08h	DWORD	pointer to active CLOCK$ device's header
 0Ch	DWORD	pointer to active CON device's header
---DOS 2.x---
 10h	BYTE	number of logical drives in system
 11h	WORD	maximum bytes/block of any block device
 13h	DWORD	pointer to first disk buffer (see below)
 17h 18 BYTEs	actual NUL device driver header (not a pointer!)
		NUL is always the first device on DOS's linked list of device 
		drivers. (see below for format)
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
		drivers. (see below for format)
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
		drivers. (see below for format)
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
		drivers. (see below for format)
 34h	BYTE	number of JOIN'ed drives???
 35h	WORD	pointer within IBMDOS code segment to list of special program
		names (see below)
		(always 0000h for DOS 5.0)
 37h	DWORD	pointer to FAR routine for resident IFS utility functions
		(see below)
		may be called by any IFS driver which does not wish to
		service functions 20h or 24h-28h itself
 3Bh	DWORD	pointer to chain of IFS (installable file system) drivers
 3Fh	WORD	the x in BUFFERS x,y (rounded up to multiple of 30 if in EMS)
 41h	WORD	the y in BUFFERS x,y
 43h	BYTE	boot drive (1=A:)
 44h	BYTE	01h if 80386+, 00h otherwise???
 45h	WORD	extended memory size in K
---DOS 5.0---
 10h 39 BYTEs	as for DOS 4.x (see above)
 37h	DWORD	pointer to SETVER program list or 0000h:0000h
 3Bh	WORD	??? pointer to function in DOS CS
 3Dh	WORD	??? apparently 0000h if DOS loaded low, PSP of most-recently
		EXECed program if DOS in HMA
 3Fh  8 BYTEs	as for DOS 4.x (see above)

Format of memory control block (see also below):
Offset	Size	Description
 00h	BYTE	block type: 5Ah if last block in chain, otherwise 4Dh
 01h	WORD	PSP segment of owner or
		0000h if free
		0006h if DR-DOS XMS UMB
		0007h if DR-DOS excluded upper memory ("hole")
		0008h if belongs to DOS
 03h	WORD	size of memory block in paragraphs
 05h  3 BYTEs	unused
---DOS 2.x,3.x---
 08h  8 BYTEs	unused
---DOS 4+ ---
 08h  8 BYTEs	ASCII program name if PSP memory block or DR-DOS UMB,
		  else garbage
		null-terminated if less than 8 characters
Notes:	under DOS 3.1+, the first memory block is the DOS data segment,
	  containing installable drivers, buffers, etc.
	under DOS 4.x it is divided into subsegments, each with its own memory
	  control block (see below), the first of which is at offset 0000h
	for DOS 5.0, blocks owned by DOS may have either "SC" or "SD" in bytes
	  08h and 09h.	"SC" is system code or locked-out inter-UMB memory,
	  "SD" is system data, device drivers, etc.
	Some versions of DR-DOS use only seven characters of the program name,
	  placing a NUL in the eighth byte.

Format of MSDOS 5.0 UMB control block:
Offset	Size	Description
 00h	BYTE	type: 5Ah if last block in chain, 4Dh otherwise
 01h	WORD	first available paragraph in UMB if control block at start
		of UMB, 000Ah if control block at end of UMB
 03h	WORD	length in paragraphs of following UMB or locked-out region
 05h  3 BYTEs	unused
 08h  8 BYTEs	block type name: "UMB" if start block, "SM" if end block in UMB

Format of STARLITE memory control block:
Offset	Size	Description
 00h	BYTE	block type: 5Ah if last block in chain, otherwise 4Dh
 01h	WORD	PSP segment of owner, 0000h if free, 0008h if belongs to DOS
 03h	WORD	size of memory block in paragraphs
 05h	BYTE	unused
 06h	WORD	segment address of next memory control block (0000h if last)
 08h	WORD	segment address of previous memory control block or 0000h
 0Ah  6 BYTEs	reserved

Format of DOS 4.x data segment subsegment control blocks:
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
 08h	DWORD	ptr to STACKS data segment
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
    DOS 4.x:	Identified by sub-segment control block type "S" within the DOS
		data segment.

Format of array elements in STACKS data segment:
Offset	Size	Description
 00h	BYTE	status: 00h=free, 01h=in use, 03h=corrupted by overflow of
		higher stack.
 01h	BYTE	not used
 02h	WORD	previous SP
 04h	WORD	previous SS
 06h	WORD	ptr to word at top of stack (new value for SP). The word at the
		top of the stack is preset to point back to this control block.

SHARE.EXE hooks (DOS 3.1-5.00):
(offsets from first system file table--pointed at by ListOfLists+04h)
Offset	Size	Description
-3Ch	DWORD	pointer to FAR routine for ???
		Note: not called by MSDOS 3.3, set to 0000h:0000h by SHARE 3.3
-38h	DWORD	pointer to FAR routine called on opening file
		on call, internal DOS location points at filename(see AX=5D06h)
		Return: CF clear if successful
			CF set on error
			    AX = DOS error code (24h) (see AH=59h)
		Note: SHARE assumes DS=SS=DOS DS, direct-accesses DOS internals
			to get name of file just opened
-34h	DWORD	pointer to FAR routine called on closing file
		ES:DI -> system file table
		Note: SHARE assumes SS=DOS DS, directly accesses DOS internals
			does something to every lock record for file
-30h	DWORD	pointer to FAR routine to close all files for given computer
		(called by AX=5D03h)
		Note: SHARE assumes SS=DOS DS, directly accesses DOS internals
-2Ch	DWORD	pointer to FAR routine to close all files for given process
		(called by AX=5D04h)
		Note: SHARE assumes SS=DOS DS, directly accesses DOS internals
-28h	DWORD	pointer to FAR routine to close file by name
		(called by AX=5D02h)
		DS:SI -> DOS parameter list (see AX=5D00h)
		   DPL's DS:DX -> name of file to close
		Return: CF clear if successful
			CF set on error
			    AX = DOS error code (03h) (see AH=59h)
		Note: SHARE assumes SS=DOS DS, directly accesses DOS internals
-24h	DWORD	pointer to FAR routine to lock region of file
		call with BX = file handle
			  CX:DX = starting offset
			  SI:AX = size
		Return: CF set on error
			    AL = DOS error code (21h) (see AH=59h)
		Note: only called if file is marked as remote
		Note: SHARE assumes SS=DOS DS, directly accesses DOS internals
-20h	DWORD	pointer to FAR routine to unlock region of file
		call with BX = file handle
			  CX:DX = starting offset
			  SI:AX = size
		Return: CF set on error
			    AL = DOS error code (21h) (see AH=59h)
		Note: only called if file is marked as remote
		Note: SHARE assumes SS=DOS DS, directly accesses DOS internals
-1Ch	DWORD	pointer to FAR routine to check if file region is locked
		call with ES:DI -> system file table entry for file
			CX = length of region from current position in file
		Return: CF set if any portion of region locked
			    AX = 0021h
		Note: SHARE assumes SS=DOS DS, directly accesses DOS internals
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
		Note: SHARE assumes SS=DOS DS, directly accesses DOS internals
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
		Note: SHARE assumes SS=DOS DS, directly accesses DOS internals
		Note: if SFT was opened with inheritance enabled and sharing
			mode 111, does something to all other SFTs owned by
			same process which have the same file open mode and
			sharing record
-08h	DWORD	pointer to FAR routine for ???
		Note: SHARE assumes SS=DS=DOS DS, direct-accesses DOS internals
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

Format of sharing record:
Offset	Size	Description
 00h	BYTE	flag
		00h free block
		01h allocated block
		FFh end marker
 01h	WORD	size of block
 03h	BYTE	checksum of pathname (including NUL)
		if sum of ASCII values is N, checksum is (N/256 + N%256)
 04h	WORD	offset in SHARE's DS of lock record (see below)
 06h	DWORD	pointer to start of system file table chain for file
 0Ah	WORD	unique sequence number
 0Ch	var	ASCIZ full pathname

Format of SHARE.EXE lock record:
Offset	Size	Description
 00h	WORD	offset in SHARE's DS of next lock table in list
 02h	DWORD	offset in file of start of locked region
 06h	DWORD	offset in file of end of locked region
 0Ah	DWORD	pointer to System File Table entry for this file
 0Eh	WORD	PSP segment of lock's owner

Format of DOS 2.x system file tables:
Offset	Size	Description
 00h	DWORD	pointer to next file table
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
 00h	DWORD	pointer to next file table
 04h	WORD	number of files in this table
 06h  38h bytes per file
	Offset	Size	Description
	 00h-1Eh as for DOS 3.1+ (see below)
	 1Fh	WORD	byte offset of directory entry within sector
	 21h 11 BYTES	filename in FCB format (no path/period, blank-padded)
	 2Ch	DWORD	(SHARE.EXE) pointer to previous SFT sharing same file
	 30h	WORD	(SHARE.EXE) ??? network machine number
	 32h	WORD	PSP segment of file's owner
	 34h	WORD	(SHARE.EXE) offset in SHARE code seg of share record
	 36h	WORD	??? apparently always 0000h

Format of DOS 3.1-3.3x system file tables and FCB tables:
Offset	Size	Description
 00h	DWORD	pointer to next file table
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
	 07h	DWORD	pointer to device driver header if character device
			else pointer to DOS Drive Parameter Block (see AH=32h)
	 0Bh	WORD	starting cluster of file
	 0Dh	WORD	file time in packed format (see AX=5700h)
	 0Fh	WORD	file date in packed format (see AX=5700h)
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
	 31h	WORD	PSP segment of file's owner (see AH=26h)
	 33h	WORD	offset within SHARE.EXE code segment of 
			sharing record (see above)  0000h = none

Format of DOS 4.0-5.0 system file tables and FCB tables:
Offset	Size	Description
 00h	DWORD	pointer to next file table
 04h	WORD	number of files in this table
 06h  3Bh bytes per file
	Offset	Size	Description
	 00h	WORD	number of file handles referring to this file
	 02h	WORD	file open mode (see AH=3Dh)
			bit 15 set if this file opened via FCB
	 04h	BYTE	file attribute (see AX=4301h)
	 05h	WORD	device info word (see AX=4400h)
			bit 15 set if remote file
			bit 14 set means do not set file date/time on closing
			bit 13 set if named pipe
			bit 12 set if no inherit
			bit 11 set if network spooler
	 07h	DWORD	pointer to device driver header if character device
			else pointer to DOS Drive Parameter Block (see AH=32h)
			or REDIR data
	 0Bh	WORD	starting cluster of file
	 0Dh	WORD	file time in packed format (see AX=5700h)
	 0Fh	WORD	file date in packed format (see AX=5700h)
	 11h	DWORD	file size
	 15h	DWORD	current offset in file
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
	 31h	WORD	PSP segment of file's owner (see AH=26h)
	 33h	WORD	offset within SHARE.EXE code segment of 
			sharing record (see above)  0000h = none
	 35h	WORD	(local) absolute cluster number of last clustr accessed
			(redirector) ???
	 37h	DWORD	pointer to IFS driver for file, 0000000h if native DOS

Format of current directory structure (CDS) (array, LASTDRIVE entries):
Offset	Size	Description
 00h 67 BYTEs	ASCIZ path in form X:\PATH (local) or \\MACH\PATH (network)
 43h	WORD	drive attributes (see also note below and AX=5F07h)
		bit 15: uses network redirector	 \ invalid if 00, installable
		    14: physical drive		 / file system if 11
		    13: JOIN'ed	  \ path above is true path that would be
		    12: SUBST'ed  / needed if not under SUBST or JOIN
 45h	DWORD	pointer to Drive Parameter Block for drive (see AH=32h)
---local drives---
 49h	WORD	starting cluster of current directory
		0000h = root, FFFFh = never accessed
 4Bh	WORD	??? seems to be FFFFh always
 4Dh	WORD	??? seems to be FFFFh always
---network drives---
 49h	DWORD	pointer to redirector or REDIRIFS record, or FFFFh:FFFFh
 4Dh	WORD	stored user data from INT 21/AX=5F03h???
------
 4Fh	WORD	offset in current directory path of backslash corresponding to
		  root directory for drive
		this value specifies how many characters to hide from the
		  "CHDIR" and "GETDIR" calls; normally set to 2 to hide the
		  drive letter and colon, SUBST, JOIN, and networks change it
		  so that only the appropriate portion of the true path is
		  visible to the user
---DOS 4.x---
 51h	BYTE	??? used by network
 52h	DWORD	pointer to IFS driver for this drive, 00000000h if native DOS
 56h	WORD	???
Notes:	the path for invalid drives is normally set to X:\, but may be empty
	  after JOIN x: /D in DR-DOS 5.0 or NET USE x: /D in older LAN versions
	normally, only one of bits 13&12 may be set together with bit 14, but
	  DR-DOS 5.0 uses other combinations for bits 15-12: 0111 JOIN,
	  0001 SUBST, 0101 ASSIGN

Format of DR-DOS 5.0-6.0 current directory structure entry (array):
Offset	Size	Description
 00h 67 BYTEs	ASCIZ pathname of actual root directory for this logical drive
 43h	WORD	drive attributes
		1000h SUBSTed drive
		3000h??? JOINed drive
		4000h physical drive
		5000h ASSIGNed drive
		7000h JOINed drive
 45h	BYTE	physical drive number (0=A:) if this logical drive is valid
 46h	BYTE	??? apparently flags for JOIN and ASSIGN
 47h	WORD	cluster number of start of parent directory (0000h = root)
 49h	WORD	entry number of current directory in parent directory
 4Bh	WORD	cluster number of start of current directory
 4Dh  2 BYTEs	??? apparently always 0001h
 4Fh	WORD	cluster number of SUBST/JOIN "root" directory
		0000h if physical root directory

Format of device driver header:
Offset	Size	Description
 00h	DWORD	pointer to next driver, offset=FFFFh if last driver
 04h	WORD	device attributes
		Character device:
		   bit 15 set
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
		   bit 15 clear
		   bit 14 IOCTL supported
		   bit 13 non-IBM format
		   bit 12 reserved
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
		   bit 1   driver supports 32-bit sector addressing
		   bit 0   reserved
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
 05h	BYTE	flags
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

Format of DOS 4.0-5.0 disk buffer:
Offset	Size	Description
 00h	WORD	forward ptr, offset only, to next least recently used buffer
 02h	WORD	backward ptr, offset only
 04h	BYTE	drive (0=A,1=B, etc), FFh if not in use
 05h	BYTE	flags
		bit 7: remote buffer
		bit 6: buffer dirty
		bit 5: buffer has been referenced
		bit 4: search data buffer (only valid if remote buffer)
		bit 3: sector in data area
		bit 2: sector in a directory, either root or subdirectory
		bit 1: sector in FAT
		bit 0: reserved
 06h	DWORD	logical sector number
 0Ah	BYTE	number of copies to write
		for FAT sectors, same as number of FATs
		for data and directory sectors, usually 1
 0Bh	WORD	offset in sectors between copies to write for FAT sectors
 0Dh	DWORD	pointer to DOS Drive Parameter Block (see AH=32h)
 11h	WORD	buffer use count if remote buffer (see flags above)
 13h	BYTE	reserved
 14h		buffered data
Note:	for DOS 4.x, all buffered sectors which have the same hash value
	  (computed as the sum of high and low words of the logical sector
	  number divided by NDBCH) are on the same doubly-linked circular
	  chain; for DOS 5.0, only a single circular chain exists.
	the links consist of offset addresses only, the segment being the same
	  for all buffers in the chain.

Format of DOS 5.0 disk buffer info:
Offset	Size	Description
 00h	DWORD	pointer to least-recently-used buffer header (may be in HMA)
		(see above)
 04h	WORD	0000h (DOS 5 does not hash disk buffers, so offset 00h points
			directly at the only buffer chain)
 06h	DWORD	pointer to lookahead buffer, zero if not present
 0Ah	WORD	number of lookahead sectors, else zero (the y in BUFFERS=x,y)
 0Ch	BYTE	buffer location
		00h base memory, no workspace buffer
		01h HMA, workspace buffer in base memory
 0Dh	DWORD	pointer to one-segment workspace buffer in base memory
 11h  3 BYTEs	unused???
 14h	WORD	???
 16h	BYTE	??? apparently always 00h
 17h	BYTE	??? apparently always FFh
 18h	BYTE	??? apparently always 00h
 19h	BYTE	??? apparently always 00h
 1Ah	WORD	??? segment within HIMEM.SYS area when buffers are in HMA and
		  UMBs are enabled???, else 0000h
 1Ch	BYTE	bit 0 set iff UMB MCB chain linked to normal MCB chain
 1Dh	WORD	???
 1Fh	WORD	segment of first MCB in upper memory blocks or FFFFh if DOS
		memory chain in base 640K only (first UMB MCB usually at 9FFFh,
		locking out video memory with a DOS-owned memory block)
 21h	WORD	paragraph of start of most recent MCB chain search

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
	 17h  7	BYTEs	???
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
----------215252-----------------------------
INT 21 - VIRUS - "516"/"Leapfrog" - INSTALLATION CHECK
	AX = 5252h
Return: BX = FFEEh if resident
SeeAlso: AX=4BFFh"Cascade",AX=58CCh
----------2153-------------------------------
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
----------2154-------------------------------
INT 21 - DOS 2+ - GET VERIFY FLAG
	AH = 54h
Return: AL = verify flag
	    00h off
	    01h on (all disk writes verified after writing)
SeeAlso: AH=2Eh
----------2155-------------------------------
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
----------2156-------------------------------
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
	  if the destination wildcard is *.* or equivalent.  When invoked via
	  AX=5D00h, only those files matching the attribute mask in CL are
	  renamed.
SeeAlso: AH=17h,AX=4301h,AH=60h,AX=5D00h
----------215700-----------------------------
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
SeeAlso: AX=5701h
----------215701-----------------------------
INT 21 - DOS 2+ - SET FILE'S DATE AND TIME
	AX = 5701h
	BX = file handle
	CX = new time (see AX=5700h)
	DX = new date (see AX=5700h)
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,06h) (see AH=59h)
SeeAlso: AX=5700h
----------215702-----------------------------
INT 21 - DOS 4.x only - GET ???
	AX = 5702h
	BX = ??? (0000h through 0004h)
	DS:SI -> ???
	ES:DI -> result buffer
	CX = size of result buffer
Return: CX = size of returned data
SeeAlso: AX=5703h,AX=5704h
----------215703-----------------------------
INT 21 - DOS 4.x only - GET ???
	AX = 5703h
	BX = file handle (only 0000h through 0004h valid)
	DS:SI -> ??? passed through to INT 2F/AX=112Dh
	ES:DI -> result buffer
	CX = size of result buffer
Return: CX = size of returned data
	ES:DI -> zero word (DOS 4.0) if CX >= 2 on entry
SeeAlso: AX=5702h,AX=5704h,INT 2F/AX=112Dh
----------215704-----------------------------
INT 21 - DOS 4.x only - TRUNCATE OPEN FILE TO ZERO LENGTH
	AX = 5704h
	BX = file handle (only 0000h through 0004h valid)
	DS:SI -> ??? passed through to INT 2F/AX=112Dh
	ES:DI -> result buffer
	CX = size of result buffer
Return: CX = size of returned data
	ES:DI -> zero word (DOS 4.0) if CX >= 2 on entry
SeeAlso: AX=5702h,AX=5703h,INT 2F/AX=112Dh
----------2158-------------------------------
INT 21 - DOS 3+ - GET OR SET MEMORY ALLOCATION STRATEGY
	AH = 58h
	AL = subfunction
	    00h get allocation strategy
		Return: AX = current strategy
			    00h low memory first fit
			    01h low memory best fit
			    02h low memory last fit
			 ---DOS 5.0---
			    40h high memory first fit
			    41h high memory best fit
			    42h high memory last fit
			    80h first fit, try high then low memory
			    81h best fit, try high then low memory
			    82h last fit, try high then low memory
	    01h set allocation strategy
		BL = new allocation strategy (see above)
		BH = 0 (DOS 5.0)
	    02h (DOS 5.0) get UMB link state
		Return: AL = 00h UMBs not part of DOS memory chain
			   = 01h UMBs in DOS memory chain
	    03h (DOS 5.0) set UMB link state
		BX = 0000h remove UMBs from DOS memory chain
		   = 0001h add UMBs to DOS memory chain
Return: CF clear if successful
	CF set on error
	    AX = error code (01h) (see AH=59h)
Notes:	the Set subfunction accepts any value in BL for DOS 3.x and 4.x;
	  2 or greater means last fit
	the Get subfunction returns the last value set
	a program which changes the allocation strategy should restore it
	  before terminating
	DR-DOS 3.41 reportedly reverses subfunctions 00h and 01h
SeeAlso: AH=48h,AH=49h,AH=4Ah,INT 2F/AX=4310h,INT 67/AH=3Fh
----------2158CC-----------------------------
INT 21 - VIRUS - "1067"/"Headcrash" - INSTALLATION CHECK
	AX = 58CCh
Return: CF clear if resident
SeeAlso: AX=5252h,AX=6969h
----------2159--BX0000-----------------------
INT 21 - DOS 3+ - GET EXTENDED ERROR INFORMATION
	AH = 59h
	BX = 0000h
Return: AX = extended error code (see below)
	BH = error class (see below)
	BL = recommended action (see below)
	CH = error locus (see below)
	CL, DX, SI, DI, BP, DS, and ES destroyed
Notes:	functions available under DOS 2.x map the true DOS 3+ error code into
	  one supported under DOS 2.x
	you should call this function to retrieve the true error code when an
	  FCB or DOS 2.x call returns an error
SeeAlso: AX=5D0Ah,INT 2F/AX=122Dh

Values for extended error code:
	00h no error
	01h function number invalid
	02h file not found
	03h path not found
	04h too many open files (no handles available)
	05h access denied
	06h invalid handle
	07h memory control block destroyed
	08h insufficient memory
	09h memory block address invalid
	0Ah environment invalid (usually >32K in length)
	0Bh format invalid
	0Ch access code invalid
	0Dh data invalid
	0Eh reserved
	0Fh invalid drive
	10h attempted to remove current directory
	11h not same device
	12h no more files
---DOS 3+---
	13h disk write-protected
	14h unknown unit
	15h drive not ready
	16h unknown command
	17h data error (CRC)
	18h bad request structure length
	19h seek error
	1Ah unknown media type (non-DOS disk)
	1Bh sector not found
	1Ch printer out of paper
	1Dh write fault
	1Eh read fault
	1Fh general failure
	20h sharing violation
	21h lock violation
	22h disk change invalid
	    ES:DI -> ASCIZ volume label of required disk
	23h FCB unavailable
	24h sharing buffer overflow
	25h (DOS 4+) code page mismatch
	26h (DOS 4+) cannot complete file operation (out of input)
	27h (DOS 4+) insufficient disk space
	28h-31h reserved
	32h network request not supported
	33h remote computer not listening
	34h duplicate name on network
	35h network name not found
	36h network busy
	37h network device no longer exists
	38h network BIOS command limit exceeded
	39h network adapter hardware error
	3Ah incorrect response from network
	3Bh unexpected network error
	3Ch incompatible remote adapter
	3Dh print queue full
	3Eh queue not full
	3Fh not enough space to print file
	40h network name was deleted
	41h network: Access denied
	42h network device type incorrect
	43h network name not found
	44h network name limit exceeded
	45h network BIOS session limit exceeded
	46h temporarily paused
	47h network request not accepted
	48h network print/disk redirection paused
	49h (LANtastic) invalid network version
	4Ah (LANtastic) account expired
	4Bh (LANtastic) password expired
	4Ch (LANtastic) login attempt invalid at this time
	4Dh (LANtastic v3+) disk limit exceeded on network node
	4Eh (LANtastic v3+) not logged in to network node
	4Fh reserved
	50h file exists
	51h reserved
	52h cannot make directory
	53h fail on INT 24h
	54h (DOS 3.3+) too many redirections
	55h (DOS 3.3+) duplicate redirection
	56h (DOS 3.3+) invalid password
	57h (DOS 3.3+) invalid parameter
	58h (DOS 3.3+) network write fault
	59h (DOS 4+) function not supported on network
	5Ah (DOS 4+) required system component not installed

Values for Error Class:
	01h out of resource (storage space or I/O channels)
	02h temporary situation (file or record lock)
	03h authorization (denied access)
	04h internal (system software bug)
	05h hardware failure
	06h system failure (configuration file missing or incorrect)
	07h application program error
	08h not found
	09h bad format
	0Ah locked
	0Bh media error
	0Ch already exists
	0Dh unknown

Values for Suggested Action:
	01h retry
	02h delayed retry
	03h prompt user to reenter input
	04h abort after cleanup
	05h immediate abort
	06h ignore
	07h retry after user intervention

Values for Error Locus:
	01h unknown or not appropriate
	02h block device (disk error)
	03h network related
	04h serial device (timeout)
	05h memory related
----------215A-------------------------------
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
Notes:	creates a file with a unique name which must be explicitly deleted
	COMPAQ DOS 3.31 hangs if the pathname is at XXXXh:0000h; it apparently
	  wraps around to the end of the segment
SeeAlso: AH=3Ch,AH=5Bh
----------215B-------------------------------
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
SeeAlso: AH=3Ch,AH=5Ah
----------215C-------------------------------
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
SeeAlso: AX=440Bh,INT 2F/AX=110Ah,INT 2F/AX=110Bh
----------215D00-----------------------------
INT 21 - DOS 3.1+ internal - SERVER FUNCTION CALL
	AX = 5D00h
	DS:DX -> DOS parameter list (see below)
	DPL contains all register values for a call to INT 21h
Return: as appropriate for function being called
Notes:	does not check AH.  Out of range values will crash the system
	executes using specified computer ID and process ID
	sharing delay loops skipped
	a special sharing mode is enabled
	wildcards are enabled for DELETE (AH=41h) and RENAME (AH=56h)
	an extra file attribute parameter is enabled for OPEN (AH=3Dh),
	  DELETE (AH=41h), and RENAME (AH=56h)
	functions which take filenames require canonical names (as returned
	  by AH=60h); this is apparently to prevent multi-hop file forwarding
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
----------215D01-----------------------------
INT 21 - DOS 3.1+ internal - COMMIT ALL FILES FOR SPECIFIED COMPUTER/PROCESS
	AX = 5D01h
	DS:DX -> DOS parameter list (see AX=5D00h), only computer ID and
		process ID fields used
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Notes:	flushes buffers and updates directory entries for each file which has
	  been written to; if remote file, calls INT 2F/AX=1107h
	the computer ID and process ID are stored but ignored under DOS 3.3
SeeAlso: AH=0Dh,AH=68h,INT 2F/AX=1107h
----------215D02-----------------------------
INT 21 - DOS 3.1+ internal - SHARE.EXE - CLOSE FILE BY NAME
	AX = 5D02h
	DS:DX -> DOS parameter list (see AX=5D00h), only fields DX, DS,
		computer ID, and process ID used
	DPL's DS:DX -> ASCIZ name of file to close
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Notes:	error unless SHARE is loaded (calls [SysFileTable-28h]) (see AH=52h)
	name must be canonical fully-qualified, such as returned by AH=60h
SeeAlso: AX=5D03h,AX=5D04h,AH=3Eh,AH=60h
----------215D03-----------------------------
INT 21 - DOS 3.1+ internal - SHARE.EXE - CLOSE ALL FILES FOR GIVEN COMPUTER
	AX = 5D03h
	DS:DX -> DOS parameter list (see AX=5D00h), only computer ID used
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Note:	error unless SHARE is loaded (calls [SysFileTable-30h]) (see AH=52h)
SeeAlso: AX=5D02h,AX=5D04h
----------215D04-----------------------------
INT 21 - DOS 3.1+ internal - SHARE.EXE - CLOSE ALL FILES FOR GIVEN PROCESS
	AX = 5D04h
	DS:DX -> DOS parameter list (see AX=5D00h), only computer ID and
		process ID fields used
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Note:	error unless SHARE is loaded (calls [SysFileTable-2Ch]) (see AH=52h)
SeeAlso: AX=5D02h,AX=5D03h
----------215D05-----------------------------
INT 21 - DOS 3.1+ internal - SHARE.EXE - GET OPEN FILE LIST ENTRY
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
SeeAlso: AH=5Ch,AH=60h 
----------215D06-----------------------------
INT 21 - DOS 3.0+ internal - GET ADDRESS OF DOS SWAPPABLE DATA AREA
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
SeeAlso: AX=5D0Bh,INT 2A/AH=80h,INT 2A/AH=81h,INT 2A/AH=82h

Format of DOS 3.10-3.30 Swappable Data Area:
Offset	Size	Description
 00h	BYTE	critical error flag
 01h	BYTE	InDOS flag (count of active INT 21 calls)
 02h	BYTE	drive on which current critical error occurred, or FFh
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
 26h	WORD	???
 28h	BYTE	INT 24 returned Fail
 29h	BYTE	bit flags for allowable actions on INT 24
 2Ah	BYTE	??? flag
 2Bh	BYTE	FFh if Ctrl-Break termination, 00h otherwise
 2Ch	BYTE	??? flag of some kind
 2Dh	BYTE	??? (doesn't seem to be referenced)
 2Eh	BYTE	day of month
 2Fh	BYTE	month
 30h	WORD	year - 1980
 32h	WORD	number of days since 1-1-1980
 34h	BYTE	day of week (0 = Sunday)
 35h	BYTE	working SFT pointer at SDA+2AAh is valid ???
 36h	BYTE	safe to call INT 28 if nonzero
 37h	BYTE	flag: if nonzero, INT 24 abort turned into INT 24 fail
		(set only during process termination)
 38h 26 BYTEs	device driver request header
 52h	DWORD	pointer to device driver entry point (used in calling driver)
 56h 22 BYTEs	device driver request header
 6Ch 22 BYTEs	device driver request header
 82h	BYTE	type of PSP copy (00h=simple for INT 21/AH=26h, FFh=make child)
 83h	BYTE	??? apparently not referenced by kernel
 84h  3 BYTEs	24-bit user number (see AH=30h)
 87h	BYTE	OEM number (see AH=30h)
 88h  2 BYTEs	???
 8Ah  6 BYTEs	CLOCK$ transfer record (see AH=52h)
 90h	BYTE	??? buffer for single-byte I/O functions
 91h	BYTE	??? apparently not referenced by kernel
 92h 128 BYTEs	buffer for filename
112h 128 BYTEs	buffer for filename
192h 21 BYTEs	findfirst/findnext search data block (see AH=4Eh)
1A7h 32 BYTEs	directory entry for found file
1C7h 81 BYTEs	copy of current directory structure for drive being accessed
218h 11 BYTEs	FCB-format filename for device name comparison
223h	BYTE	unused???
224h 11 BYTEs	wildcard destination specification for rename (FCB format)
22Fh  2 BYTEs	???
231h	WORD	???
233h  5 BYTEs	???
238h	BYTE	extended FCB file attribute
239h	BYTE	type of FCB (00h regular, FFh extended)
23Ah	BYTE	directory search attributes
23Bh	BYTE	file open mode???
23Ch	BYTE	??? flag bits 0 and 4
23Dh	BYTE	??? flag or counter
23Eh	BYTE	??? flag
23Fh	BYTE	flag indicating how DOS function was invoked
		(00h = direct INT 20/INT 21, FFh = server call AX=5D00h)
240h	BYTE	???
241h	BYTE	??? flag
242h	BYTE	flag: 00h if read, 01h if write
243h	BYTE	drive number for ???
244h	BYTE	???
245h	BYTE	??? flag or counter
246h	BYTE	line edit (AH=0Ah) insert mode flag (nonzero = on)
247h	BYTE	canonicalized filename referred to existing file/dir if FFh
248h	BYTE	??? flag or counter
249h	BYTE	type of process termination (00h-03h) (see AH=4Dh)
24Ah	BYTE	??? flag
24Bh	BYTE	value with which to replace first byte of deleted file's name
		(normally E5h, but 00h as described under INT 21/AH=13h)
24Ch	DWORD	pointer to Drive Parameter Block for critical error invocation
250h	DWORD	pointer to stack frame containing user registers on INT 21
254h	WORD	stores SP across INT 24
256h	DWORD	pointer to DOS Drive Parameter Block for ???
25Ah	WORD	???
25Ch	WORD	??? temp
25Eh	WORD	??? flag (only low byte referenced)
260h	WORD	??? temp
262h	BYTE	Media ID byte returned by AH=1Bh,1Ch
263h	BYTE	??? (doesn't seem to be referenced)
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
282h	WORD	??? offset of transfer address???
284h	WORD	??? relative cluster within file being accessed ???
286h	WORD	??? absolute cluster number being accessed ???
288h	WORD	??? current sector number
28Ah	WORD	??? current cluster number
28Ch	WORD	??? current offset in file DIV bytes per sector
28Eh  2 BYTEs	??? 
290h	WORD	??? current offset in file MOD bytes per sector
292h	DWORD	current offset in file
296h	WORD	???
298h	WORD	???
29Ah	WORD	???
29Ch	WORD	???
29Eh	WORD	???
2A0h	WORD	???
2A2h	DWORD	number of bytes appended to file
2A6h	DWORD	pointer to ??? disk buffer
2AAh	DWORD	pointer to working SFT
2AEh	WORD	used by INT 21 dispatcher to store caller's BX
2B0h	WORD	used by INT 21 dispatcher to store caller's DS
2B2h	WORD	temporary storage while saving/restoring caller's registers
2B4h	DWORD	pointer to prev call frame (offset 250h) if INT 21 reentered
		also switched to for duration of INT 24
2B8h 21 BYTEs	FindFirst search data for source file(s) of a rename operation
		(see AH=4Eh)
2CDh 32 BYTEs	directory entry for file being renamed
2EDh 331 BYTEs	critical error stack
   403h	 35 BYTEs scratch SFT
438h 384 BYTEs	disk stack (functions greater than 0Ch, INT 25,INT 26)
5B8h 384 BYTEs	character I/O stack (functions 01h through 0Ch)
---DOS 3.2,3.3 only---
738h	BYTE	device driver lookahead flag (see AH=64h)
739h	BYTE	??? looks like a drive number
73Ah	BYTE	??? flag of some kind
73Ah	BYTE	???
----------215D07-----------------------------
INT 21 - DOS 3.1+ network - GET REDIRECTED PRINTER MODE
	AX = 5D07h
Return: DL = mode
	    00h redirected output is combined
	    01h redirected output in separate print jobs
SeeAlso: AX=5D08h,AX=5D09h,INT 2F/AX=1125h
----------215D08-----------------------------
INT 21 - DOS 3.1+ network - SET REDIRECTED PRINTER MODE
	AX = 5D08h
	DL = mode
	    00h redirected output is combined
	    01h redirected output placed in separate jobs, start new print job
		now
SeeAlso: AX=5D07h,AX=5D09h,INT 2F/AX=1125h
----------215D09-----------------------------
INT 21 - DOS 3.1+ network - FLUSH REDIRECTED PRINTER OUTPUT
	AX = 5D09h
Note:	forces redirected printer output to be printed, and starts a new print
	  job
SeeAlso: AX=5D07h,AX=5D08h,INT 2F/AX=1125h
----------215D0A-----------------------------
INT 21 - DOS 3.1+ - SET EXTENDED ERROR INFORMATION
	AX = 5D0Ah
	DS:DX -> 11-word DOS parameter list (see AX=5D00h)
Return: nothing.  next call to AH=59h will return values from fields AX,BX,CX,
	  DX,DI, and ES in corresponding registers
Note:	documented for DOS 5+, but undocumented in earlier versions
SeeAlso: AH=59h
----------215D0B-----------------------------
INT 21 - DOS 4.x only internal - GET DOS SWAPPABLE DATA AREAS
	AX = 5D0Bh
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    DS:SI -> swappable data area list (see below)
Note:	copying and restoring the swappable data areas allows DOS to be
	  reentered unless it is in a critical section delimited by calls to
	  INT 2A/AH=80h and INT 2A/AH=81h,82h
SeeAlso: AX=5D06h,INT 2A/AH=80h,INT 2A/AH=81h,INT 2A/AH=82h

Format of DOS 4.x swappable data area list:
Offset	Size	Description
 00h	WORD	count of data areas
 02h  N BYTEs	"count" copies of data area record
		Offset	Size	Description
		 00h	DWORD	address
		 04h	WORD	length and type
				bit 15 set if swap always, clear if swap in DOS
				bits 14-0: length in bytes

Format of DOS 4.0-5.0 swappable data area:
Offset	Size	Description
 00h	BYTE	critical error flag
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
 18h  2 BYTEs	???
---remainder need only be swapped if in DOS---
 1Ah	WORD	value of AX on call to INT 21
 1Ch	WORD	PSP segment for sharing/network
 1Eh	WORD	network machine number for sharing/network (0000h = us)
 20h	WORD	first usable memory block found when allocating memory
 22h	WORD	best usable memory block found when allocating memory
 24h	WORD	last usable memory block found when allocating memory
 26h	WORD	memory size in paragraphs (used only during initialization)
 28h	WORD	???
 2Ah	BYTE	???
 2Bh	BYTE	???
 2Ch	BYTE	???
 2Dh	BYTE	???
 2Eh	BYTE	???
 2Fh	BYTE	??? (doesn't seem to be referenced)
 30h	BYTE	day of month
 31h	BYTE	month
 32h	WORD	year - 1980
 34h	WORD	number of days since 1-1-1980
 36h	BYTE	day of week (0 = Sunday)
 37h	BYTE	???
 38h	BYTE	???
 39h	BYTE	???
 38h 30 BYTEs	device driver request header
 58h	DWORD	pointer to device driver entry point (used in calling driver)
 5Ch 22 BYTEs	device driver request header
 72h 30 BYTEs	device driver request header
 90h  6	BYTEs	???
 96h  6 BYTEs	CLOCK$ transfer record (see AH=52h)
 9Ch  2 BYTEs	???
 9Eh 128 BYTEs	buffer for filename
11Eh 128 BYTEs	buffer for filename
19Eh 21 BYTEs	findfirst/findnext search data block (see AH=4Eh)
1B3h 32 BYTEs	directory entry for found file
1D3h 88 BYTEs	copy of current directory structure for drive being accessed
22Bh 11 BYTEs	FCB-format filename for device name comparison
236h	BYTE	???
237h 11 BYTEs	wildcard destination specification for rename (FCB format)
242h  2 BYTEs	???
244h	WORD	???
246h  5 BYTEs	???
24Bh	BYTE	extended FCB file attributes
24Ch	BYTE	type of FCB (00h regular, FFh extended)
24Dh	BYTE	directory search attributes
24Eh	BYTE	file open mode
24Fh	BYTE	??? flag bits
250h	BYTE	??? flag or counter
251h	BYTE	??? flag
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
28Ah	WORD	number of SFT to which file being opened will refer
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
315h 32 BYTEs	directory entry for file being renamed
335h 331 BYTEs	critical error stack
480h 384 BYTEs	disk stack (functions greater than 0Ch, INT 25,INT 26)
600h 384 BYTEs	character I/O stack (functions 01h through 0Ch)
780h	BYTE	device driver lookahead flag (see AH=64h)
781h	BYTE	??? looks like a drive number
782h	BYTE	??? flag of some kind
783h	BYTE	???
784h	WORD	???
786h	WORD	???
788h	WORD	???
78Ah	WORD	???
----------215E00-----------------------------
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
----------215E01CH00-------------------------
INT 21 - DOS 3.1+ network - SET MACHINE NAME
	AX = 5E01h
	CH = 00h undefine name (make it invalid)
	   <> 0	 define name
	CL = name number
	DS:DX -> 15-character blank-padded ASCIZ name
SeeAlso: AX=5E00h
----------215E02-----------------------------
INT 21 - DOS 3.1+ network - SET NETWORK PRINTER SETUP STRING
	AX = 5E02h
	BX = redirection list index (see AX=5F02h)
	CX = length of setup string
	DS:SI -> setup string
Return: CF clear if successful
	CF set on error
	    AX = error code (01h) (see AH=59h)
SeeAlso: AX=5E03h,INT 2F/AX=111Fh
----------215E03-----------------------------
INT 21 - DOS 3.1+ network - GET NETWORK PRINTER SETUP STRING
	AX = 5E03h
	BX = redirection list index (see AX=5F02h)
	ES:DI -> 64-byte buffer for setup string
Return: CF clear if successful
	    CX = length of setup string
	    ES:DI buffer filled
	CF set on error
	    AX = error code (01h) (see AH=59h)
SeeAlso: AX=5E02h,INT 2F/AX=111Fh
----------215E04-----------------------------
INT 21 - DOS 3.1+ network - SET PRINTER MODE
	AX = 5E04h
	BX = redirection list index (see AX=5F02h)
	DX = mode
	    bit 0: set if binary, clear if text (tabs expanded to blanks)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Note:	calls INT 2F/AX=111Fh with 5E04h on stack
SeeAlso: AX=5E05h,INT 2F/AX=111Fh
----------215E05-----------------------------
INT 21 - DOS 3.1+ network - GET PRINTER MODE
	AX = 5E05h
	BX = redirection list index (see AX=5F02h)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    DX = printer mode (see AX=5E04h)
Note:	calls INT 2F/AX=111Fh with 5E05h on stack
SeeAlso: AX=5E04h,INT 2F/AX=111Fh
----------215F00-----------------------------
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
SeeAlso: AX=5F01h
----------215F01-----------------------------
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
Note:	when redirection is off, the local device (if any) rather than the
	  remote device is used
SeeAlso: AX=5F00h,INT 2F/AX=111Eh
----------215F02-----------------------------
INT 21 - DOS 3.1+ network, Banyan VINES, PC-NFS - GET REDIRECTION LIST ENTRY
	AX = 5F02h
	BX = redirection list index
	DS:SI -> 16-byte buffer for ASCIZ device name
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
Notes:	this function is passed through to INT 2F/AX=111Eh
	error code 12h is returned if BX is greater than the size of the list
SeeAlso: AX=5F03h,INT 2F/AX=111Eh
----------215F03-----------------------------
INT 21 - DOS 3.1+ network, Banyan VINES - REDIRECT DEVICE
	AX = 5F03h
	BL = device type
	    03h printer
	    04h disk drive
	CX = user data to save
	DS:SI -> ASCIZ local device name (16 bytes max)
	ES:DI -> ASCIZ network name + ASCIZ password (128 bytes max total)
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,03h,05h,08h,0Fh,12h) (see AH=59h)
Note:	if device type is disk drive, DS:SI must point at either a null string
	  or a string consisting the drive letter followed by a colon; if a
	  null string, the network attempts to access the destination without
	  redirecting a local drive
SeeAlso: AX=5F02h,AX=5F04h,INT 2F/AX=111Eh
----------215F04-----------------------------
INT 21 - DOS 3.1+ network, Banyan VINES - CANCEL REDIRECTION
	AX = 5F04h
	DS:SI -> ASCIZ device name or path
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,03h,05h,08h,0Fh,12h) (see AH=59h)
Note:	the DS:SI string must be either a local device name, a drive letter
	  followed by a colon, or a network directory beginning with two
	  backslashes
SeeAlso: AX=5F03h,INT 2F/AX=111Eh
----------215F05-----------------------------
INT 21 - DOS 4.x + Microsoft Networks - GET REDIRECTION LIST EXTENDED ENTRY
	AX = 5F05h
	BX = redirection list index
	DS:SI -> buffer for ASCIZ source device name
	ES:DI -> buffer for destination ASCIZ network path
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    BH = device status flag (bit 0 clear if valid)
	    BL = device type (03h if printer, 04h if drive)
	    CX = stored parameter value (user data)
	    BP = NETBIOS local session number
	    DS:SI buffer filled
	    ES:DI buffer filled
Notes:	the local session number allows sharing the redirector's session number
	if an error is caused on the NETBIOS LSN, the redirector may be unable
	  to correctly recover from errors
SeeAlso: AX=5F06h"Network",INT 2F/AX=111Eh
----------215F05-----------------------------
INT 21 - STARLITE architecture - MAP LOCAL DRIVE LETTER TO REMOTE FILE SYSTEM
	AX = 5F05h
	DL = drive number (0=A:)
	DS:SI -> ASCIZ name of the object to map the drive to
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
SeeAlso: AX=5F06h"STARLITE"
----------215F06-----------------------------
INT 21 - Network - GET REDIRECTION LIST???
	AX = 5F06h
	???
Return: ???
Note:	appears to be similar to AX=5F02h and AX=5F05h
SeeAlso: AX=5F05h"DOS",INT 2F/AX=111Eh
----------215F06-----------------------------
INT 21 - STARLITE architecture - UNMAP DRIVE LETTER
	AX = 5F06h
	DL = drive to be unmapped (0=A:)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
SeeAlso: AX=5F05h"STARLITE"
----------215F07-----------------------------
INT 21 - DOS 5.0 - ENABLE DRIVE
	AX = 5F07h
	DL = drive number (0=A:)
Return: CF clear if successful
	CF set on error
	    AX = error code (0Fh) (see AH=59h)
Note:	simply sets the "valid" bit in the drive's CDS
SeeAlso: AH=52h,AX=5F08h"DOS"
----------215F07-----------------------------
INT 21 - STARLITE architecture - MAKE NAMED OBJECT AVAILABLE ON NETWORK
	AX = 5F07h
	DS:SI -> ASCIZ name of object to offer to network
	ES:DI -> ASCIZ name under which object will be known on the network
		MUST begin with three slashes
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
SeeAlso: AX=5F08h"STARLITE"
----------215F08-----------------------------
INT 21 - DOS 5.0 - DISABLE DRIVE
	AX = 5F08h
	DL = drive number (0=A:)
Return: CF clear if successful
	CF set on error
	    AX = error code (0Fh) (see AH=59h)
Note:	simply clears the "valid" bit in the drive's CDS
SeeAlso: AH=52h,AX=5F07h"DOS"
----------215F08-----------------------------
INT 21 - STARLITE architecture - REMOVE GLOBAL NETWORK NAME OF OBJECT
	AX = 5F08h
	DS:SI -> ASCIZ network name (not local name) of object to unshare
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
SeeAlso: AX=5F07h"STARLITE"
----------215F09-----------------------------
INT 21 - STARLITE architecture - BIND TO NETWORK DEVICE
	AX = 5F09h
	DS:DX -> ASCIZ name of the device driver to attach to
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Note:	the STARLITE distributed file system can attach to multiple networks
	  simultaneously
SeeAlso: AX=5F0Ah
----------215F0A-----------------------------
INT 21 - STARLITE architecture - DETACH FROM NETWORK DEVICE
	AX = 5F0Ah
	DS:DX -> ASCIZ name of device driver to detach from
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
SeeAlso: AX=5F09h
----------215F32-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosQNmPipeInfo
	AX = 5F32h
	???
Return: ???
SeeAlso: AX=5F33h,AX=5F34h
----------215F33-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosQNmPHandState
	AX = 5F33h
	???
Return: ???
SeeAlso: AX=5F32h,AX=5F34h
----------215F34-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosSetNmPHandState
	AX = 5F34h
	???
Return: ???
SeeAlso: AX=5F32h,AX=5F33h,AX=5F36h
----------215F35-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosPeekNmPipe
	AX = 5F35h
	???
Return: ???
SeeAlso: AX=5F38h,AX=5F39h,AX=5F51h
----------215F36-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosTransactNmPipe
	AX = 5F36h
	???
Return: ???
SeeAlso: AX=5F34h,AX=5F37h
----------215F37-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosCallNmPipe
	AX = 5F37h
	???
Return: ???
SeeAlso: AX=5F36h,AX=5F38h
----------215F38-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosWaitNmPipe
	AX = 5F38h
	???
Return: ???
SeeAlso: AX=5F37h,AX=5F39h
----------215F39-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosRawReadNmPipe
	AX = 5F39h
	???
Return: ???
SeeAlso: AX=5F35h,AX=5F3Ah,INT 2F/AX=1186h
----------215F3A-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosRawWriteNmPipe
	AX = 5F3Ah
	???
Return: ???
SeeAlso: AX=5F3Bh,INT 2F/AX=118Fh
----------215F3B-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetHandleSetInfo
	AX = 5F3Bh
	???
Return: ???
SeeAlso: AX=5F3Ch
----------215F3C-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetHandleGetInfo
	AX = 5F3Ch
	???
Return: ???
SeeAlso: AX=5F3Bh
----------215F40-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetMessageBufferSend
	AX = 5F40h
	???
Return: ???
----------215F42-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetServiceControl
	AX = 5F42h
	???
Return: ???
----------215F44-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetWkstaGetInfo
	AX = 5F44h
	???
Return: ???
SeeAlso: AX=5F45h,AX=5F49h
----------215F45-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetWkstaSetInfo
	AX = 5F45h
	???
Return: ???
SeeAlso: AX=5F44h
----------215F46-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetUseEnum
	AX = 5F46h
	???
Return: ???
SeeAlso: AX=5F47h,AX=5F48h,AX=5F4Ch
----------215F47-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetUseAdd
	AX = 5F47h
	???
Return: ???
SeeAlso: AX=5F46h,AX=5F48h
----------215F48-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetUseDel
	AX = 5F48h
	???
Return: ???
SeeAlso: AX=5F46h,AX=5F48h,AX=5F49h
----------215F49-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetUseGetInfo
	AX = 5F49h
	???
Return: ???
SeeAlso: AX=5F44h,AX=5F47h
----------215F4A-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetRemoteCopy
	AX = 5F4Ah
	???
Return: ???
SeeAlso: AX=5F4Bh
----------215F4B-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetRemoteMove
	AX = 5F4Bh
	???
Return: ???
SeeAlso: AX=5F4Ah
----------215F4C-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetServerEnum
	AX = 5F4Ch
	???
Return: ???
SeeAlso: AX=5F53h
----------215F4D-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosMakeMailslot
	AX = 5F4Dh
	???
Return: ???
SeeAlso: AX=5F4Eh,AX=5F4Fh,AX=5F50h,AX=5F51h
----------215F4E-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosDeleteMailslot
	AX = 5F4Eh
	???
Return: ???
SeeAlso: AX=5F4Dh,AX=5F4Fh
----------215F4F-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosMailslotInfo
	AX = 5F4Fh
	???
Return: ???
SeeAlso: AX=5F4Dh,AX=5F4Eh,AX=5F50h
----------215F50-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosReadMailslot
	AX = 5F50h
	???
Return: ???
SeeAlso: AX=5F4Dh,AX=5F4Fh,AX=5F51h,AX=5F52h
----------215F51-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosPeekMailslot
	AX = 5F51h
	???
Return: ???
SeeAlso: AX=5F35h,AX=5F4Fh,AX=5F50h,AX=5F52h
----------215F52-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - DosWriteMailslot
	AX = 5F52h
	???
Return: ???
SeeAlso: AX=5F4Fh,AX=5F50h,AX=5F51h
----------215F53-----------------------------
INT 21 - LAN Manager Enhanced DOS API local interface - NetServerEnum2
	AX = 5F53h
	???
Return: ???
SeeAlso: AX=5F4Ch
----------215F80-----------------------------
INT 21 - LANtastic - GET LOGIN ENTRY
	AX = 5F80h
	BX = login entry index (0-based)
	ES:DI -> 16-byte buffer for machine name
Return: CF clear if successful
	    buffer filled with machine name ("\\" prefix removed)
	    DL = adapter number (v3+)
	CF set on error
	    AX = error code
	BX = next login entry index (BX-1 is current index)
----------215F81-----------------------------
INT 21 - LANtastic - LOGIN TO SERVER
	AX = 5F81h
	ES:DI -> ASCIZ login path followed immediately by ASCIZ password
	BL = adapter number
	    FFh try all valid adapters
	    00h-03h try only specified adapter
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	login path is of form "\\machine\username"
SeeAlso: AX=5F82h,AX=5F84h
----------215F82-----------------------------
INT 21 - LANtastic - LOGOUT FROM SERVER
	AX = 5F82h
	ES:DI -> ASCIZ server name (in form "\\machine")
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F81h
----------215F83-----------------------------
INT 21 - LANtastic - GET USERNAME ENTRY
	AX = 5F83h
	BX = login entry index (0-based)
	ES:DI -> 16-byte buffer for username currently logged into
Return: CF clear if successful
	    DL = adapter number (v3+)
	CF set on error
	    AX = error code
	BX = next login entry index (BX-1 is current index)
----------215F84-----------------------------
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
----------215F85-----------------------------
INT 21 - LANtastic - CHANGE PASSWORD
	AX = 5F85h
	ES:DI -> buffer containing "\\machine\oldpassword" 00h "newpassword"00h
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	must be logged into the named machine
----------215F86-----------------------------
INT 21 - LANtastic - DISABLE ACCOUNT
	AX = 5F86h
	ES:DI -> ASCIZ machine name and password in form "\\machine\password"
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	must be logged into the named machine and concurrent logins set to 1
	  by NET_MGR.  Requires system manager to re-enable account.
----------215F87-----------------------------
INT 21 - LANtastic v3+ - GET ACCOUNT
	AX = 5F87h
	DS:SI -> 128-byte buffer for account information (see below)
	ES:DI -> ASCIZ machine name in form "\\machine"
Return:	CF clear if successful
	CF set on error
	    AX = error code
	BX destroyed
Note:	must be logged into the specified machine

Format of user account structure:
Offset	Size	Description
 00h 16 BYTEs	blank-padded username
 10h 16 BYTEs	reserved (00h)
 20h 32 BYTEs	user description
 40h	BYTE	privilege bits
		bit 7: bypass access control lists
		    6: bypass queue protection
		    5: treat as local process
		    4: bypass mail protection
		    3: allow audit entry creation
		    2: system manager
 41h	BYTE	maximum concurrent users
 42h 42 BYTEs	bit map for disallowed half hours, beginning on Sunday
		(bit set if half-hour not an allowed time)
 6Ch	WORD	internal (0002h)
 6Eh  2 WORDs	last login time
 72h  2 WORDs	account expiration date (MSDOS-format year/month:day)
 76h  2 WORDs	password expiration date (0 = none)
 7Ah	BYTE	number of days to extend password after change (1-31)
 7Bh  5 BYTEs	reserved
----------215F97-----------------------------
INT 21 - LANtastic - COPY FILE
	AX = 5F97h
	CX:DX = number of bytes to copy (FFFFFFFFh = entire file)
	SI = source file handle
	DI = destination file handle
Return: CF clear if successful
	    AX:DX = number of bytes copied
	CF set on error
	    AX = error code
Note:	copy is performed by server
----------215F98-----------------------------
INT 21 - LANtastic - SEND UNSOLICITED MESSAGE
	AX = 5F98h
	DS:SI -> message buffer (see below)
Return: CF clear if successful
	CF set on error
	    AX = error code
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
----------215F99-----------------------------
INT 21 - LANtastic - GET LAST RECEIVED UNSOLICITED MESSAGE
	AX = 5F99h
	ES:DI -> messsage buffer (see AX=5F98h for format)
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F98h
----------215F9A-----------------------------
INT 21 - LANtastic - GET MESSAGE PROCESSING FLAGS
	AX = 5F9Ah
Return: CF clear if successful
	    DL = bits describing processing for received unsolicited messages
		bit 0: beep before message is delivered
		    1: deliver message to message service
		    2: pop up message automatically (v3+)
	CF set on error
	    AX = error code
SeeAlso: AX=5F9Bh,AX=5F9Ch
----------215F9B-----------------------------
INT 21 - LANtastic - SET MESSAGE PROCESSING FLAG
	AX = 5F9Bh
	DL = bits describing processing for received unsolicited messages
	     (see AX=5F9Ah)
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F9Ah
----------215F9C-----------------------------
INT 21 - LANtastic v3+ - POP UP LAST RECEIVED MESSAGE
	AX = 5F9Ch
	CX = time to leave on screen in clock ticks
	DH = 0-based screen line on which to place message
Return:	CF clear if successful
	CF set on error
	    AX = error code (0Bh)
Note:	the original screen contents are restored when the message is removed
SeeAlso: AX=5F9Ah
----------215FA0-----------------------------
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

Format of queue entry:
Offset	Size	Description
 00h	BYTE	status of entry
		00h empty
		01h being updated
		02h being held
		03h waiting for despool
		04h being despooled
		05h canceled
		06h spooled file could not be accessed
		07h destination could not be accessed
		08h rush job
 01h	DWORD	size of spooled file
 05h	BYTE	type of entry
		00h printer queue file
		01h message
		02h local file
		03h remote file
		04h to remote modem
		05h batch processor file
 06h	BYTE	output control
		bit 6: don't delete (for mail)
		bit 5: mail file contains voice mail (v3+)
 07h	WORD	number of copies
 09h	DWORD	sequence number of queue entry
 0Dh 48 BYTEs	pathname of spooled file
 3Dh 16 BYTEs	user who spooled file
 4Dh 16 BYTEs	name of machine from which file was spooled
 5Dh	WORD	date file was spooled (see AX=5700h)
 5Fh	WORD	time file was spooled (see AX=5700h)
 61h 17 BYTEs	ASCIZ destination device or user name
 72h 48 BYTEs	comment field
----------215FA1-----------------------------
INT 21 - LANtastic - SET QUEUE ENTRY
	AX = 5FA1h
	BX = handle of opened queue entry
	DS:SI -> queue entry (see AX=5FA0h)
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	the only queue entry fields which may be changed are output control,
	  number of copies, destination device, and comment
SeeAlso: AX=5FA0h,AX=5FA2h
----------215FA2-----------------------------
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
	ES:DI -> ASCIZ computer name
Return: CF clear if successful
	CF set on error
	    AX = error code
----------215FA3-----------------------------
INT 21 - LANtastic v3+ - GET PRINTER STATUS
	AX = 5FA3h
	BX = physical printer number (00h-02h = LPT1-LPT3, 03h-04h = COM1-COM2)
	DS:SI -> buffer for printer status (see below)
	ES:DI -> ASCIZ server name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX = next physical printer number

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
----------215FA4-----------------------------
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
----------215FA5-----------------------------
INT 21 - LANtastic v3+ - SET STREAM INFO
	AX = 5FA5h
	BX = 0-based stream index number
	DS:SI -> buffer containing stream information (see AX=5FA4h)
	ES:DI -> ASCIZ machine name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5FA4h
----------215FA7-----------------------------
INT 21 - LANtastic - CREATE USER AUDIT ENTRY
	AX = 5FA7h
	DS:DX -> ASCIZ reason code (max 8 bytes)
	DS:SI -> ASCIZ variable reason code (max 128 bytes)
	ES:DI -> ASCIZ machine name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
----------215FB0-----------------------------
INT 21 - LANtastic - GET ACTIVE USER INFORMATION
	AX = 5FB0h
	BX = server login entry index
	DS:SI -> buffer for active user entry (see below)
	ES:DI -> ASCIZ machine name in form "\\server"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX = next login index

Format of active user entry:
Offset	Size	Description
 00h	WORD	virtual circuit number
 02h	BYTE	login state
		bit 0: fully logged in
		    1: remote program load login
		    3: user can create audit entries
		    4: bypass mail protection
		    5: treat as local process
		    6: bypass queue protection
		    7: bypass access control lists
 03h	BYTE	last command issued (see below)
 04h  5 BYTEs	number of I/O bytes (40-bit unsigned number)
 09h  3 BYTEs	number of server requests (24-bit unsigned)
 0Ch 16 BYTEs	name of user who is logged in
 1Ch 16 BYTEs	name of remote logged in machine

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
----------215FB1-----------------------------
INT 21 - LANtastic - GET SHARED DIRECTORY INFORMATION
	AX = 5FB1h
	DS:SI -> 64-byte buffer for link description
	ES:DI -> ASCIZ machine and shared directory name in form
		 "\\machine\shared-resource"
Return: CF clear if successful
	    CX = access control list privilege bits for requesting user
		bit 5: allow attribute changing
		    6: allow physical access to device
		    7: allow program execution
		    8: allow file renaming
		    9: allow directory deletion
		   10: allow file deletion
		   11: allow file/directory lookups
		   12: allow directory creation
		   13: allow file creation
		   14: allow open for write and writing
		   15: allow open for read and reading
	CF set on error
	    AX = error code
----------215FB2-----------------------------
INT 21 - LANtastic v3+ - GET USERNAME FROM ACCOUNT FILE
	AX = 5FB2h
	BX = username entry index (0 for first)
	DS:SI -> 16-byte buffer for username
	ES:DI -> ASCIZ server name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX = next queue entry index
----------215FB3-----------------------------
INT 21 - LANtastic v3+ - TRANSLATE PATH
	AX = 5FB3h
	DS:SI -> 128-byte buffer for ASCIZ result
	ES:DI -> full ASCIZ path, including server name
	DX = types of translation to be performed
	    bit 0: expand last component as indirect file
		1: return actual path relative to server's physical disk
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	always expands any indirect files along the path
SeeALso: AX=5FB4h
----------215FB4-----------------------------
INT 21 - LANtastic v3+ - CREATE INDIRECT FILE
	AX = 5FB4h
	DS:SI -> 128-byte buffer containing ASCIZ contents of indirect file
	ES:DI -> full ASCIZ path of indirect file to create, incl machine name
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	the contents of the indirect file may be any valid server-relative path
----------215FB5-----------------------------
INT 21 - LANtastic v3+ - GET INDIRECT FILE CONTENTS
	AX = 5FB5h
	DS:SI -> 128-byte buffer for ASCIZ indirect file contents
	ES:DI -> full ASCIZ path of indirect file
Return: CF clear if successful
	CF set on error
	    AX = error code
----------215FC0-----------------------------
INT 21 - LANtastic - GET TIME FROM SERVER
	AX = 5FC0h
	DS:SI -> time block (see below)
	ES:DI -> ASCIZ server name to get time from
Return: CF clear if successful
	CF set on error
	    AX = error code

Format of time block:
Offset	Size	Description
 00h	WORD	year
 02h	BYTE	day
 03h	BYTE	month
 04h	BYTE	minutes
 05h	BYTE	hour
 06h	BYTE	hundredths of second
 07h	BYTE	second
----------215FD0-----------------------------
INT 21 - LANtastic - GET REDIRECTED PRINTER TIMEOUT
	AX = 5FD0h
Return: CF clear if successful
	    CX = redirected printer timeout in clock ticks of 55ms
		0000h if timeout disabled
	CF set on error
	    AX = error code
SeeAlso: AX=5FD1h
----------215FD1-----------------------------
INT 21 - LANtastic - SET REDIRECTED PRINTER TIMEOUT
	AX = 5FD1h
	CX = printer timeout in clock ticks of 55ms, 0000h to disable timeouts
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5FD0h
----------215FE0-----------------------------
INT 21 - LANtastic - GET DOS SERVICE VECTOR
	AX = 5FE0h
Return: CF clear if successful
	    ES:BX -> current FAR service routine
	CF set on error
	    AX = error code
SeeAlso: AX=5FE1h
----------215FE1-----------------------------
INT 21 - LANtastic - SET DOS SERVICE VECTOR
	AX = 5FE1h
	ES:BX -> FAR routine to call for DOS service
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	new handler must chain to previous handler as its first action
SeeAlso: AX=5FE0h
----------215FE2-----------------------------
INT 21 - LANtastic - GET MESSAGE SERVICE VECTOR
	AX = 5FE2h
Return: CF clear if successful
	    ES:BX -> current FAR message service routine
	CF set on error
	    AX = error code
SeeAlso: AX=5FE3h
----------215FE3-----------------------------
INT 21 - LANtastic - SET MESSAGE SERVICE VECTOR
	AX = 5FE3h
	ES:BX -> FAR routine for processing network messages
Return: CF clear if successful
	CF set on error
	    AX = error code
Notes:	handler must chain to previous handler as its first action
	on invocation, ES:BX -> just-received message
SeeAlso: AX=5FE2h
----------2160-------------------------------
INT 21 - DOS 3.0+ - CANONICALIZE FILENAME OR PATH
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
Notes:	the input path need not actually exist
	letters are uppercased, forward slashes converted to backslashes,
	  asterisks converted to appropriate number of question marks, and
	  file and directory names are truncated to 8.3 if necessary.
	'.' and '..' in the path are resolved
	filespecs on local drives always start with "d:", those on network
	  drives always start with "\\"
	if path string is on a JOINed drive, the returned name is the one that
	  would be needed if the drive were not JOINed; similarly for a
	  SUBSTed, ASSIGNed, or network drive letter.	Because of this, it is
	  possible to get a qualified name that is not legal under the current
	  combination of SUBSTs, ASSIGNs, JOINs, and network redirections
	under DOS 3.3 through 5.00, a device name is translated differently if
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
	for DOS 3.3-5.0, the input and output buffers may be the same, as the
	  canonicalized name is built in an internal buffer and copied to the
	  specified output buffer as the very last step
SeeAlso: INT 2F/AX=1123h,INT 2F/AX=1221h
----------2161-------------------------------
INT 21 - DOS 3+ - UNUSED
	AH = 61h
Return: AL = 00h
Note:	this function does nothing and returns immediately
----------2162-------------------------------
INT 21 - DOS 3+ - GET CURRENT PSP ADDRESS
	AH = 62h
Return: BX = segment of PSP for current process
Notes:	under DOS 3+, this function does not use any of the DOS-internal stacks
	  and is thus fully reentrant
	the current PSP is not necessarily the caller's PSP
	identical to the undocumented AH=51h
SeeAlso: AH=50h,AH=51h
----------216300-----------------------------
INT 21 - DOS 2.25 only - GET LEAD BYTE TABLE ADDRESS
	AX = 6300h
Return: CF clear if successful
	    DS:SI -> lead byte table (see below for format)
	CF set on error
	    AX = error code (01h) (see AH=59h)
Notes:	does not preserve any registers other than SS:SP
	the US version of MSDOS 3.30 treats this as an unused function,
	  setting AL=00h and returning immediately
SeeAlso: AX=6301h,AH=07h,AH=08h,AH=0Bh

Format of lead byte table entry:
Offset	Size	Description
 00h  2 BYTEs	low/high ends of a range of leading byte of double-byte chars
 02h  2 BYTEs	low/high ends of a range of leading byte of double-byte chars
	...
  N   2 BYTEs	00h,00h end flag
----------216300-----------------------------
INT 21 - Asian DOS 3.2+ - GET DOUBLE BYTE CHARACTER SET LEAD TABLE
	AX = 6300h
Return: AL = error code
	    00h successful
		DS:SI -> DBCS table (see below)
		all other registers except CS:IP and SS:SP destroyed
	    FFh not supported
Notes:	probably identical to AH=63h/AL=00h for DOS 2.25
	the US version of MSDOS 3.30 treats this as an unused function,
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
----------216301-----------------------------
INT 21 - DOS 2.25, Asian DOS 3.2+ - SET KOREAN (HONGEUL) INPUT MODE
	AX = 6301h
	DL = new mode
	    00h return only full characters on DOS keyboard input functions
	    01h	return partially-formed characters also
Return: AL = status
	    00h successful
	    FFh invalid mode
SeeAlso: AH=07h,AH=08h,AH=0Bh,AH=63h,AX=6302h
----------216302-----------------------------
INT 21 - DOS 2.25, Asian DOS 3.2+ - GET KOREAN (HONGEUL) INPUT MODE
	AX = 6302h
Return: AL = status
	    00h successful
		DL = current input mode
		    00h return only full characters
		    01h return partial characters
	    FFh not supported
SeeAlso: AH=07h,AH=08h,AH=0Bh,AH=63h,AX=6301h
----------2164-------------------------------
INT 21 - DOS 3.2+ internal - SET DEVICE DRIVER LOOKAHEAD FLAG
	AH = 64h
	AL = flag
		00h (default) call device driver function 5 (non-dest read)
			before INT 21/AH=01h,08h,0Ah
	    nonzero don't call driver function 5
Return: nothing
Notes:	called by DOS 3.3+ PRINT.COM
	does not use any of the DOS-internal stacks and is thus fully
	  reentrant
SeeAlso: AH=01h,AH=08h,AH=0Ah,AX=5D06h
----------2165-------------------------------
INT 21 - DOS 3.3+ - GET EXTENDED COUNTRY INFORMATION
	AH = 65h
	AL = info ID
	    01h get general internationalization info
	    02h get pointer to uppercase table
	    04h get pointer to filename uppercase table
	    05h get pointer to filename terminator table
	    06h get pointer to collating sequence table
	    07h (DOS 4+) get pointer to Double-Byte Character Set table
	BX = code page (-1=global code page)
	DX = country ID (-1=current country)
	ES:DI -> country information buffer (see below)
	CX = size of buffer (>= 5)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if succesful
	    CX = size of country information returned
	    ES:DI -> country information
Notes:	AL=05h appears to return same info for all countries and codepages; it
	  has been documented for DOS 5.0, but was undocumented in ealier
	  versions
	NLSFUNC must be installed to get info for countries other than the
	  default
	subfunctions 02h and 04h are identical under OS/2
SeeAlso: AH=38h,INT 2F/AX=1401h,INT 2F/AX=1402h

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
 02h	BYTE	??? (01h for MSDOS 3.30-5.00)
 03h	BYTE	lowest permissible character value for filename
 04h	BYTE	highest permissible character value for filename
 05h	BYTE	??? (00h for MSDOS 3.30-5.00)
 06h	BYTE	first excluded character in range \ all characters in this
 07h	BYTE	last excluded character in range  / range are illegal
 08h	BYTE	??? (02h for MSDOS 3.30-5.00)
 09h	BYTE	number of illegal (terminator) characters
 0Ah  N BYTES	characters which terminate a filename:	."/\[]:|<>+=;,
Note:	partially documented for DOS 5.0, but undocumented for earlier versions

Format of filename uppercase table:
Offset	Size	Description
 00h	WORD	table size
 02h 128 BYTEs	uppercase equivalents (if any) of chars 80h to FFh

Format of DBCS lead byte table:
Offset	Size	Description
 00h	WORD	length
 02h 2N BYTEs	start/end for N lead byte ranges
	WORD	0000h	(end of table)
----------2165-------------------------------
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
----------216523-----------------------------
INT 21 - DOS 4+ internal - DETERMINE IF CHARACTER REPRESENTS YES/NO RESPONSE
	AX = 6523h
	DL = character
	DH = second character of double-byte character (if applicable)
Return: CF set on error
	CF clear if successful
	    AX = type
		00h no
		01h yes
		02h neither yes nor no
----------2165-------------------------------
INT 21 - DOS 4+ internal - COUNTRY-DEPENDENT FILENAME CAPITALIZATION
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
Note:	nonfunctional in DOS 4.00 through 5.00 due to a bug (the code sets a
	  pointer depending on the high bit of AL, but doesn't clear the
	  bit before branching by function number).
----------216601-----------------------------
INT 21 - DOS 3.3+ - GET GLOBAL CODE PAGE TABLE
	AX = 6601h
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    BX = active code page (see AX=6602h)
	    DX = system code page
SeeAlso: AX=6602h
----------216602-----------------------------
INT 21 - DOS 3.3+ - SET GLOBAL CODE PAGE TABLE
	AX = 6602h
	BX = active code page
	    437 US
	    850 Multilingual
	    852 Slavic/Latin II (DOS 5+)
	    857 Turkish
	    860 Portugal
	    861	Iceland
	    863 Canada (French)
	    865 Norway/Denmark
	DX = system code page (active page at boot time)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
SeeAlso: AX=6601h
----------2167-------------------------------
INT 21 - DOS 3.3+ - SET HANDLE COUNT
	AH = 67h
	BX = size of new file handle table for process
Return: CF clear if successful
	CF set on error
	    AX = error code (see AH=59h)
Notes:	if BX <= 20, no action is taken if the handle limit has not yet been
	  increased, and the table is copied back into the PSP if the limit
	  is currently > 20 handles
	for file handle tables of > 20 handles, DOS 3.30 never reuses the
	  same memory block, even if the limit is being reduced; this can lead
	  to memory fragmentation as a new block is allocated and the existing
	  one freed
	only the first 20 handles are copied to child processes in DOS 3.3
BUG:	the original release of DOS 3.30 allocates a full 64K for the handle
	  table on requests for an even number of handles
SeeAlso: AH=26h
----------2168-------------------------------
INT 21 - DOS 3.3+ - "FFLUSH" - COMMIT FILE
	AH = 68h
	BX = file handle
Return: CF clear if successful
	    all data still in DOS disk buffers is written to disk immediately,
	      and the file's directory entry is updated
	CF set on error
	    AX = error code (see AH=59h)
SeeAlso: AX=5D01h,INT 2F/AX=1107h
----------2169-------------------------------
INT 21 - DOS 4.0 internal - GET/SET DISK SERIAL NUMBER
	AH = 69h
	AL = subfunction
	    00h	get serial number
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
SeeAlso: AX=440Dh

Format of disk info:
Offset	Size	Description
 00h	WORD	info level (zero)
 02h	DWORD	disk serial number (binary)
 06h 11 BYTEs	volume label or "NO NAME    " if none present
 11h  8 BYTEs	(AL=00h only) filesystem type--string "FAT12   " or "FAT16   "
----------2169-------------------------------
INT 21 - DR-DOS 5.0 - NULL FUNCTION
	AH = 69h
Return: AL = 00h
SeeAlso: AH=18h
----------216969-----------------------------
INT 21 - VIRUS - "Rape-747" - INSTALLATION CHECK
	AX = 6969h
Return: AX = 0666h if resident
SeeAlso: AX=58CCh,AH=76h"VIRUS"
----------216A-------------------------------
INT 21 - DOS 4+ internal - ???
	AH = 6Ah
	???
Return: ???
Note:	may be equivalent to INT 21/AH=48h
----------216B-------------------------------
INT 21 - DOS 4.0 internal - ???
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
----------216B-------------------------------
INT 21 - DOS 5.0 - NULL FUNCTION
	AH = 6Bh
Return: AL = 00h
Note:	this function does nothing and returns immediately
SeeAlso: AH=6Bh"DOS 4"
----------216C00-----------------------------
INT 21 - DOS 4+ - EXTENDED OPEN/CREATE
	AX = 6C00h
	BL = open mode as in AL for normal open (INT 21h/AH=3Dh)
	    bit 7: inheritance
	    bits 4-6: sharing mode
	    bit 3 reserved
	    bits 0-2: access mode
	BH = flags
	    bit 6 = auto commit on every write
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
	   CX = 1 file opened
		2 file created
		3 file replaced
Note:	the PC LAN Program only supports DL=01h, DL=10h/sharing=compatibility,
	  and DL=12h
SeeAlso: AH=3Ch,AH=3Dh
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
----------2176-------------------------------
INT 21 - VIRUS - "Klaeren"/"Hate" - INSTALLATION CHECK
	AH = 76h
Return: AL = 48h if resident
SeeAlso: AX=6969h,AX=7700h"VIRUS"
----------217761-----------------------------
INT 21 - WATCH.COM v3.2+ - INSTALLATION CHECK
	AX = 7761h ('wa')
Return: AX = 6177h
Note:	WATCH.COM is part of the "TSR" package by TurboPower Software
SeeAlso: INT 16/AX=7761h
----------217700-----------------------------
INT 21 - VIRUS - "Growing Block" - INSTALLATION CHECK
	AX = 7700h
Return: AX = 0920h if resident
SeeAlso: AH=76h,AH=7Fh
----------217F-------------------------------
INT 21 - VIRUS - "Squeaker" - INSTALLATION CHECK
	AH = 7Fh
Return: AH = 80h if resident
SeeAlso: AX=7700h,AH=83h"VIRUS"
---------------------------------------------
