Interrupt List, part 2 of 3
This compilation is Copyright (c) 1989,1990 Ralf Brown
---------------------------------------------
INT 20 - Minix - SEND/RECEIVE MESSAGE
	AX = process ID of other process
	BX -> message
	CX = 1 send
	     2 receive
	     3 send&receive
Note:	the message contains the system call number (numbered as in V7 
	  Unix(tm)) and the call parameters
---------------------------------------------
INT 20 - DOS - PROGRAM TERMINATION
returns to DOS--identical to INT 21/AH=00h
Note:	IBM and Microsoft recommend using INT 21/AH=4Ch for DOS 2+
SeeAlso: INT 21/AH=00h
---------------------------------------------
INT 21 - DOS - PROGRAM TERMINATION
	AH = 00h
Return: never
Note:	execution continues at address pointed to by INT 22 after DOS performs
	  whatever cleanup it needs to do
SeeAlso: INT 22
---------------------------------------------
INT 21 - DOS - KEYBOARD INPUT
	AH = 01h
Return: AL = character read
Note:	^C/^Break are checked, and INT 23h executed if read
	character is echoed to standard output
SeeAlso: AH=06h,07h,08h,0Ah
---------------------------------------------
INT 21 - DOS - DISPLAY OUTPUT
	AH = 02h
	DL = character to send to standard output
Note:	^C/^Break are checked, and INT 23h executed if pressed
SeeAlso: AH=06h,09h
---------------------------------------------
INT 21 - DOS - AUX INPUT
	AH = 03h
Return: AL = character read
SeeAlso: INT 14/AH=02h
---------------------------------------------
INT 21 - DOS - AUX OUTPUT
	AH = 04h
	DL = character to send
SeeAlso: INT 14/AH=01h
---------------------------------------------
INT 21 - DOS - PRINTER OUTPUT
	AH = 05h
	DL = character to print
SeeAlso: INT 17/AH=00h
---------------------------------------------
INT 21 - DOS - DIRECT CONSOLE I/O CHARACTER OUTPUT
	AH = 06h
	DL = character <> FFh
SeeAlso: AH=02h,09h
---------------------------------------------
INT 21 - DOS - DIRECT CONSOLE I/O CHARACTER INPUT
	AH = 06h
	DL = FFh
Return: ZF set	 = no character
	ZF clear = character recieved
		  AL = character
Notes:	character is echoed to STDOUT if received.
	^C/^Break are NOT checked
SeeAlso: AH=0Bh
---------------------------------------------
INT 21 - DOS - DIRECT STDIN INPUT, NO ECHO
	AH = 07h
Note:	same as function 06h for input but char not echoed
SeeAlso: AH=01h,06h,08h,0Ah
---------------------------------------------
INT 21 - DOS - KEYBOARD INPUT, NO ECHO
	AH = 08h
Return: AL = character
Note:	same as function 07h, but ^C/^Break are checked
SeeAlso: AH=01h,06h,07h,0Ah,64h
---------------------------------------------
INT 21 - DOS - PRINT STRING
	AH = 09h
	DS:DX -> string terminated by "$"
Note:	^C/^Break checked, and INT 23h called if pressed
SeeAlso: AH=02h,06h
---------------------------------------------
INT 21 - DOS - BUFFERED KEYBOARD INPUT
	AH = 0Ah
	DS:DX -> buffer
Note:	first byte of buffer must contain maximum length
	on entry, second byte contains actual length of previous line which may
	  be recalled with the DOS line-editing commands
	on return the second byte contains actual length, third and
	  subsequent bytes contain the input line
---------------------------------------------
INT 21 - DOS - CHECK STANDARD INPUT STATUS
	AH = 0Bh
Return: AL = FFh if character available
	     00h if no character
Note:	^C/^Break checked, and INT 23h called if pressed
---------------------------------------------
INT 21 - DOS - CLEAR KEYBOARD BUFFER
	AH = 0Ch
	AL must be 1, 6, 7, 8, or 0Ah.
Notes:	flushes all typeahead input, then executes function specified by AL
	  (effectively moving it to AH and repeating the INT 21 call).
	if AL contains a value not in the list above, the keyboard buffer is
	  flushed and no other action is taken.
SeeAlso: AH=01h,06h,07h,08h,0Ah
---------------------------------------------
INT 21 - DOS - DISK RESET
	AH = 0Dh
Note:	flushes all disk buffers
SeeAlso: INT 13/AH=00h
---------------------------------------------
INT 21 - DOS - SELECT DISK
	AH = 0Eh
	DL = new default drive number (0 = A, 1 = B, etc.)
Return: AL = number of logical drives
SeeAlso: AH=19h
---------------------------------------------
INT 21 - DOS - OPEN DISK FILE
	AH = 0Fh
	DS:DX -> FCB (see below)
Return: AL = 00h file found
	     FFh file not found
Note:	(DOS 3+) file opened in compatibility mode
SeeAlso: AH=3Dh

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
 16h	WORD	time of last write (see AX=5700h)
 18h  8 BYTEs	reserved (see below)
 20h	BYTE	record within current block
 21h	DWORD	random access record number (if record size is > 64 bytes, high
		byte is omitted)

Format of reserved field for DOS 1.x:
Offset	Size	Description
 18h	BYTE	bit 7: set if logical device
		bit 6: set if open???
		bits 5-0: disk number or logical device ID
 19h	WORD	absolute current cluster number
 1Bh	WORD	starting cluster number
 1Dh	WORD	relative current cluster number
 1Fh	BYTE	unused???

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
 1Ch	WORD	relative cluster within file of last cluster read
 1Eh	BYTE	absolute cluster number of last cluster read
 1Fh	BYTE	???
---SHARE.EXE not loaded---
 1Ah	BYTE	(low byte of device attribute word AND 0Ch) OR open mode
 1Bh	WORD	starting cluster of file
 1Dh	WORD	number of sector containing directory entry
 1Fh	BYTE	number of directory entry within sector
Note:	if FCB opened on character device, DWORD at 1Ah is set to the address
	  of the device driver header, then the BYTE at 1Ah is overwritten.
---------------------------------------------
INT 21 - DOS - CLOSE DISK FILE
	AH = 10h
	DS:DX -> FCB (see AH=0Fh)
Return: AL = 00h directory update successful
	     FFh file not found in directory
SeeAlso: AH=3Eh
---------------------------------------------
INT 21 - DOS - SEARCH FIRST USING FCB
	AH = 11h
	DS:DX -> FCB (see AH=0Fh)
Return: AL = status
	    00h file found
		[DTA] = unopened FCB for file that was found
	    FFh file not found
SeeAlso: AH=1Ah,4Eh
---------------------------------------------
INT 21 - DOS - SEARCH NEXT USING FCB
	AH = 12h
	DS:DX -> FCB (see AH=0Fh)
Return: AL = status
	    00h file found
		[DTA] = unopened FCB for file that was found
	    FFh file not found
SeeAlso: AH=1Ah,4Fh
---------------------------------------------
INT 21 - DOS - DELETE FILE via FCB
	AH = 13h
	DS:DX -> FCB (see AH=0Fh) with filename field filled with template for
		 deletion ('?' wildcard allowed, but not '*')
Return: AL = status
	    00h file found
	    FFh file not found
SeeAlso: AH=41h
---------------------------------------------
INT 21 - DOS - SEQUENTIAL DISK FILE READ
	AH = 14h
	DS:DX -> FCB (see AH=0Fh)
Return: AL = status
	    00h successful read
	    01h end of file
	    02h data transfer area too small
	    03h partial record, EOF
SeeAlso: AH=3Fh
---------------------------------------------
INT 21 - DOS - SEQUENTIAL DISK RECORD WRITE
	AH = 15h
	DS:DX -> FCB (see AH=0Fh)
Return: AL = status
	    00h successful write
	    01h disk full
	    02h data transfer area too small
SeeAlso: AH=40h
---------------------------------------------
INT 21 - DOS - CREATE A DISK FILE
	AH = 16h
	DS:DX -> FCB (see AH=0Fh)
Return: AL = status
	    00h successful creation
	    FFh directory full
Note:	if file already exists, it is truncated to zero length
SeeAlso: AH=3Ch
---------------------------------------------
INT 21 - DOS - RENAME FILE via FCB
	AH = 17h
	DS:DX -> FCB (see AH=0Fh)
	FCB contains new name starting at byte 17h.
Return: AL = status
	    00h file found
	    FFh file not found
SeeAlso: AH=56h
---------------------------------------------
INT 21 - DOS internal - UNUSED
	AH = 18h
Return: AL = 00h
---------------------------------------------
INT 21 - DOS - GET DEFAULT DISK NUMBER
	AH = 19h
Return: AL = current drive number (letter - 'A')
SeeAlo: AH=0Eh
---------------------------------------------
INT 21 - DOS - SET DISK TRANSFER AREA ADDRESS
	AH = 1Ah
	DS:DX -> disk transfer buffer
SeeAlso: AH=2Fh
---------------------------------------------
INT 21 - DOS - GET ALLOCATION TABLE INFORMATION FOR DEFAULT DRIVE
	AH = 1Bh
Return: DS:BX -> FAT ID byte for default drive
	DX = number of allocation units on disk
	AL = number of sectors per allocation unit (cluster)
	CX = number of bytes per sector
Note:	under DOS 1.x, DS:BX points at an actual copy of the FAT
SeeAlso: AH=36h
---------------------------------------------
INT 21 - DOS - GET ALLOCATION TABLE INFORMATION FOR SPECIFIC DRIVE
	AH = 1Ch
	DL = drive number to check (0=default, 1=A, etc)
Return: DS:BX -> FAT ID byte for specified drive
	DX = number of allocation units on disk
	AL = number of sectors per allocation unit (cluster)
	CX = number of bytes per sector
Note:	under DOS 1.x, DS:BX points at an actual copy of the FAT
SeeAlso: AH=36h
---------------------------------------------
INT 21 - DOS internal - UNUSED
	AH = 1Dh
Return: AL = 00h
---------------------------------------------
INT 21 - DOS internal - UNUSED
	AH = 1Eh
Return: AL = 00h
---------------------------------------------
INT 21 - DOS internal - GET DEFAULT DRIVE PARAMETER BLOCK
	AH = 1Fh
Return: AL = 00h No Error
	     FFh Error
	DS:BX -> drive parameter block
Note:	for DOS 2+, this just invokes function 32h with DL = 00h
SeeAlso: AH=32h
---------------------------------------------
INT 21 - DOS internal - UNUSED
	AH = 20h
Return: AL = 00h
---------------------------------------------
INT 21 - DOS - RANDOM DISK RECORD READ
	AH = 21h
	DS:DX -> FCB (see AH=0Fh)
Return: AL = status
	    00h successful read
	    01h end of file
	    02h data transfer area too small
	    03h partial record, EOF
SeeAlso: AH=3Fh
---------------------------------------------
INT 21 - DOS - RANDOM DISK RECORD WRITE
	AH = 22h
	DS:DX -> FCB (see AH=0Fh)
Return: AL = status
	    00h successful write
	    01h disk full
	    02h data transfer area too small
SeeAlso: AH=40h
---------------------------------------------
INT 21 - DOS - GET FILE SIZE
	AH = 23h
	DS:DX -> unopened FCB (see AH=0Fh) with filename and record size
		 fields initialized
Return: AL = status
	    00h file found
	    FFh file not found
Note:	FCB's random-record field set to number of records (rounded up)
SeeAlso: AH=42h
---------------------------------------------
INT 21 - DOS - SET RANDOM RECORD FIELD
	AH = 24h
	DS:DX -> open FCB (see AH=0Fh)
Return: Random Record Field of FCB is set to be same as Current Block
	and Current Record.
SeeAlso: AH=42h
---------------------------------------------
INT 21 - DOS - SET INTERRUPT VECTOR
	AH = 25h
	AL = interrupt number
	DS:DX = new vector to be used for specified interrupt
SeeAlso: AH=35h
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - RESET 386/DOS-EXTENDER DATA STRUCTURES 
	AX = 2501h
Return: CF clear
Note:	Phar Lap uses INT 21 AH=25h as the entry point for all 386/DOS-Extender
	system calls.  Only available when directly using 386/DOS-Extender, or
	when using a product that was created using 386-DOS/Extender
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET PROTECTED-MODE INTERRUPT VECTOR
	AX = 2502h
	CL = interrupt number
Return: ES:EBX -> 48-bit address of protected-mode interrupt handler
	CF clear
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET REAL-MODE INTERRUPT VECTOR
	AX = 2503h
	CL = interrupt number
Return: EBX = 32-bit address of real-mode interrupt handler
	CF clear
SeeAlso: AX=2502h,2504h
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - SET PROTECTED-MODE INTERRUPT VECTOR
	AX = 2504h
	CL = interrupt number
	DS:EDX -> 48-bit address of protected-mode interrupt handler
Return: CF clear
SeeAlso: AX=2502h,2505h
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - SET REAL-MODE INTERRUPT VECTOR
	AX = 2505h
	CL = interrupt number
	EBX = 32-bit address of real-mode interrupt handler
Return: CF clear
SeeAlso: AX=2503h,2504h
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - SET INT TO ALWAYS GAIN CONTRL IN PROT MODE
	AX = 2506h
	CL = interrupt number
	DS:EDX -> 48-bit address of protected-mode interrupt handler
Return: CF clear
Note:	This function modifies both the real-mode low-memory interrupt
	  vector table and the protected-mode Interrupt Descriptor Table (IDT)
	Interrupts occurring in real mode are resignaled in protected mode.
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - SET REAL- & PROTECTED-MODE INT VECTORS
	AX = 2507h
	CL = interrupt number
	DS:EDX -> 48-bit address of protected-mode interrupt handler
	EBX = 32-bit address of real-mode interrupt handler
Return: CF clear
Note:	interrupts are disabled until both vectors have been modified
SeeAlso: AX=2504h,2505h
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET SEGMENT LINEAR BASE ADDRESS
	AX = 2508h
	BX = segment selector
Return: CF clear if successful
	    ECX = linear base address of segment
	CF set if invalid segment selector
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - CONVERT LINEAR TO PHYSICAL ADDRESS
	AX = 2509h
	EBX = linear address to convert
Return: CF clear if successfule
	    ECX = physical address (carry flag clear)
	CF set if linear address not mapped in page tables
---------------------------------------------
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
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET HARDWARE INTERRUPT VECTORS
	AX = 250Ch
Return: CF clear
	AL = base interrupt vector for IRQ0-IRQ7
	AH = base interrupt vector for IRQ8-IRQ15
	BL = interrupt vector for BIOS print screen function
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET REAL-MODE LINK INFORMATION
	AX = 250Dh
Return: CF clear
	EAX = 32-bit address of real-mode 386/DOS-Extender proc that will call
	      through from real mode to a protected-mode routine
	EBX = 32-bit real-mode address of intermode call data buffer
	ECX = size in bytes of intermode call data buffer
	ES:EDX -> protected-mode address of intermode call data buffer
---------------------------------------------
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
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - CONVERT PROTECTED-MODE ADDRESS TO MS-DOS
	AX = 250Fh
	ES:EBX -> 48-bit protected-mode address to convert
	ECX = length of data, in bytes
Return: CF clear if successful
	    ECX = 32-bit MS-DOS address
	CF set on error
	    ECX destroyed
SeeAlso: AX=2510h
---------------------------------------------
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
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - ISSUE REAL-MODE INTERRUPT
	AX = 2511h
	DS:EDX -> pointer to parameter block (see below)
Return: all segment registers unchanged
	EDX unchanged
	all other registers contain values set by the real-mode int handler
	the flags are set as they were left by the real-mode interrupt handler
	real-mode register values are returned in the parameter block
SeeAlso: AX=2503h,2505h

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
---------------------------------------------
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
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - ALIAS SEGMENT DESCRIPTOR
	AX = 2513h
	BX = segment selector of descriptor in GDT or LDT
	CL = access-rights byte for alias descriptor
	CH = use-type bit (USE16 or USE32) for alias descriptor
Return: CF clear on success
	    AX = segment selector for created alias
	CF set on error
	    EAX = error code
		08h insufficient memory (can't grow LDT)
		09h invalid segment selector in BX
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - CHANGE SEGMENT ATTRIBUTES
	AX = 2514h
	BX = segment selector of descriptor in GDT or LDT
	CL = new access-rights byte 
	CH = new use-type bit (USE16 or USE32)
Return: CF clear if successful
	CF set on error
	    EAX = error code
		09h invalud selector in BX
SeeAlso: AX=2515h
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - GET SEGMENT ATTRIBUTES
	AX = 2515h
	BX = segment selector of descriptor in GDT or LDT
Return: CF clear
	    CL = access-rights byte for segment
	    CH = use-type bit (USE16 or USE32)
	ECX<16-31> destroyed
	CF set on error
	    EAX = error code
		09h invalid segment selector in BX
SeeAlso: AX=2514h
---------------------------------------------
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
---------------------------------------------
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
SeeAlso: AX=251Bh
---------------------------------------------
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
SeeAlso: AX=251Ah
---------------------------------------------
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
---------------------------------------------
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
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender VMM - LIMIT PROGRAMS CONVENTIONAL MEM USAGE
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
---------------------------------------------
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
SeeAlso: AX=25C1h,25C2h
---------------------------------------------
INT 21 - Phar Lap 386/DOS-Extender - RELEASE MS-DOS MEMORY BLOCK
	AX = 25C1h
	CX = real-mode paragraph address of memory block to free
Return: CF clear if successful
	    EAX destroyed
	CF set on error
	    AX = error code
		07h MS-DOS memory control blocks destroyed
		09h invalid memory block address in CX
SeeAlso: AX=25C0h,25C2h
---------------------------------------------
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
SeeAlso: AX=25C0h,25C1h
---------------------------------------------
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
---------------------------------------------
INT 21 - DOS - CREATE PSP
	AH = 26h
	DX = segment number at which to set up PSP
Return: current PSP is copied to specified segment
Note:	new PSP is updated with memory size information; INTs 22h, 23h, 24h
	  taken from interrupt vector table
SeeAlso: AH=50h,51h,55h,62h,67h

Format of PSP:
Offset	Size	Description
 00h  2 BYTEs	program exit point
 02h  	WORD	memory size in paragraphs
 04h	BYTE	unused
 05h  5 BYTEs	CP/M entry point (FAR jump to 000C0h)
 06h	WORD	CP/M compatibility--size of first segment for .COM files
 0Ah	DWORD	terminate address (old INT 22h)
 0Eh	DWORD	break address (old INT 23h)
 12h	DWORD	critical error handler (old INT 24h)
 16h	WORD	parent PSP segment
 18h 20 BYTEs	DOS 2+ open file table, FFh = unused
 2Ch	WORD	DOS 2+ environment segment (see below)
 2Eh	DWORD	DOS 2+ process's SS:SP on entry to last INT 21 call
 32h	WORD	DOS 3+ max open files
 34h	DWORD	DOS 3+ open file table address
 38h	DWORD	DOS 3+ pointer to previous PSP (default FFFFFFFFh in 3.x)
		used by SHARE in DOS 3.3
 3Ch 20 BYTEs	unused by DOS versions <= 3.3
 50h  3 BYTEs	DOS function dispatcher (FAR routine)--CDh 21h CBh
 53h  9 BYTEs	unused
 5Ch 16 BYTEs	FCB #1 (see AH=0Fh), filled in from first commandline argument
		(when opened, overwrites following FCB)
 6Ch 20 BYTEs	FCB #2 (see AH=0Fh), filled in from second commandline argument
		(when opened, overwrites part of command tail)
 80h 128 BYTEs	command tail / default DTA buffer
		command tail is BYTE for length of tail, N BYTEs for the tail,
		followed by a BYTE containing 0Dh

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
---------------------------------------------
INT 21 - DOS - RANDOM BLOCK READ
	AH = 27h
	DS:DX -> FCB (see AH=0Fh)
	CX = number of records to be read
Return: AL = status
	    00h successful read
	    01h end of file
	    02h data transfer area too small
	    03h partial record, EOF
SeeAlso: AH=3Fh
---------------------------------------------
INT 21 - DOS - RANDOM BLOCK WRITE
	AH = 28h
	DS:DX -> FCB (see AH=0Fh)
	CX = number of records to be written
	     if zero, truncate file to current random file position
Return: AL = status
	    00h successful write
	    01h disk full
	    02h data transfer area too small
SeeAlso: AH=40h
---------------------------------------------
INT 21 - DOS - PARSE FILENAME
	AH = 29h
	DS:SI -> string to parse
	ES:DI -> buffer to fill with unopened FCB (see AH=0Fh)
	AL = bit mask to control parsing
	    0 = 0: parsing stops if file separator found
		1: leading separators ignored
	    1 = 0: drive number in FCB set to default drive if not present
		   in string
		1: drive number in FCB not changed
	    2 = 0: filename in FCB set to blanks if no filename in string
		1: filename in FCB not changed if string does not contain
		   a filename
	    3 = 0: extension in FCB set to blanks if no extension in string
		1: extension left unchanged
Return: AL = 00h no wildcards in name or extension
	     01h wildcards appeared
	     FFh drive specifier invalid
	DS:SI -> first byte after parsed string
	ES:DI buffer filled with unopened FCB
Notes:	asterisks expanded to question marks in the FCB
	all processing stops when a filename terminator is encountered
	cannot be used with filespecs which include a path (DOS 2+)
---------------------------------------------
INT 21 - DOS - GET CURRENT DATE
	AH = 2Ah
Return: DL = day
	DH = month
	CX = year
	AL = day of the week (0=Sunday, 1=Monday, etc.)
SeeAlso: INT 1A/AH=04h
---------------------------------------------
INT 21 - DOS - SET CURRENT DATE
	AH = 2Bh
	DL = day
	DH = month
	CX = year
Return: AL = 00h if no error
	   = FFh if bad value sent to routine
Note:	DOS 3.3+ also sets CMOS clock
SeeAlso: INT 1A/AH=05h
---------------------------------------------
INT 21 - DESQview - INSTALLATION CHECK
	AH = 2Bh
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
	CX = 4445h ('DE')
	DX = 5351h ('SQ')
Return: AL = FFh if DESQview not installed
Note:	in DESQview v1.x, there were no subfunctions; this call only identified
	whether or not DESQview was loaded
SeeAlso: INT 10/AH=FEh,FFh
---------------------------------------------
INT 21 - PC Tools v5.1 PC-CACHE - INSTALLATION CHECK
	AH = 2Bh
	CX = 4358h ('CX')
Return: AL = FFh if PC-CACHE not installed
	AL = 00h if installed
	    CX = 6378h ('cx')
	    BX = ???
	    DX = ???
---------------------------------------------
INT 21 - TAME v2.10 - INSTALLATION CHECK
	AX = 2B01h
	CX = 5441h ('TA')
	DX = 4D45h ('ME')
Return: AL = 02h if installed
	ES:DX -> data area in TAME-RES (see below)
Note:	TAME is a shareware program by David G. Thomas which gives up CPU time
	  to other partitions under a multitasker when the current partition's
	  program incessantly polls the keyboard or system time

Format of data area:
Offset	Size	Description
 00h  2 BYTEs	???
 02h	DWORD	number of task switches
 06h	DWORD	number of keyboard polls
 0Ah	DWORD	number of time polls
 0Eh  4 BYTEs	???
 12h	DWORD	original INT 10h
 16h	DWORD	original INT 14h
 1Ah	DWORD	original INT 15h
 1Eh	DWORD	original INT 16h
 22h	DWORD	original INT 17h
 26h	DWORD	original INT 21h
 2Ah	DWORD	original INT 28h
 2Eh 14 BYTEs	???
 3Ch	WORD	X in /max:X,Y
 3Eh	WORD	Y in /max:X,Y
 40h  4 BYTEs	flags ???
	more???
---------------------------------------------
INT 21 - DOS - GET CURRENT TIME
	AH = 2Ch
Return: CH = hours
	CL = minutes
	DH = seconds
	DL = hundredths of seconds
Note:	time is updated approximately every 5/100 second
SeeAlso: INT 1A/AH=00h,02h,FEh
---------------------------------------------
INT 21 - DOS - SET CURRENT TIME
	AH = 2Dh
	CH = hours
	CL = minutes
	DH = seconds
	DL = hundredths of seconds
Return: AL = 00h if no error
	   = FFh if bad value sent to routine
Note:	DOS 3.3+ also sets CMOS clock
SeeAlso: INT 1A/AH=01h,03h,FFh
---------------------------------------------
INT 21 - DOS - SET VERIFY FLAG
	AH = 2Eh
	DL = 00h
	AL = 01h VERIFY on
	     00h VERIFY off
Note:	when ON, all disk writes are verified
SeeAlso: AH=54h
---------------------------------------------
INT 21 - DOS 2+ - GET DISK TRANSFER AREA ADDRESS
	AH = 2Fh
Return: ES:BX -> DTA
SeeAlso: AH=1Ah
---------------------------------------------
INT 21 - DOS 2+ - GET DOS VERSION
	AH = 30h
Return: AL = major version number (0 for DOS 1.x)
	AH = minor version number
	BH = OEM number
	    00h IBM
	    16h DEC
	BL:CX = 24-bit user number
Note:	the OS/2 Compatibility Box returns 0Ah for the major version
---------------------------------------------
INT 21 - CTask 2.0 - INSTALLATION CHECK
	AX = 3000h
	BX = 1234h
	DS:DX -> version string??? (8 bytes)
Return: AL = DOS major version
	AH = DOS minor version
	CX:BX -> ???
Notes:	if first eight bytes of returned data block equal eight bytes passed
	  in, CTask is resident
	CTask is a multitasking kernel for C written by Thomas Wagner
---------------------------------------------
INT 21 - DOS 2+ - TERMINATE BUT STAY RESIDENT
	AH = 31h
	AL = exit code
	DX = program size, in paragraphs
Note:	most TSRs can save some memory by releasing their environment block
	  before terminating (see AH=26h)
SeeAlso: INT 22, INT 27
---------------------------------------------
INT 21 - DOS 2+ internal - GET DRIVE PARAMETER BLOCK
	AH = 32h
	DL = drive number
	    0 = default, 1 = A, etc.
Return: AL = 0FFh if invalid drive number, else
	DS:BX -> drive parameter block
Note:	the OS/2 compatibility box supports the DOS 3.3 version of this call
	  except for the DWORD at offset 12h

Format of DOS Drive Parameter Block:
Offset	Size	Description
 00h	BYTE	drive number (0 = A, etc.)
 01h	BYTE	unit number within device driver
 02h	WORD	number of bytes per sector
 04h	BYTE	largest sector number in cluster (one less than sect/clust)
 05h	BYTE	log base two of the cluster size
 06h	WORD	number of reserved (boot) sectors
 08h	BYTE	number of copies of the FAT
 09h	WORD	number of root directory entries
 0Bh	WORD	first data sector on medium
 0Dh	WORD	largest possible cluster number (one more than # data clust)
---DOS 2.x---
 0Fh	BYTE	number of sectors in one FAT copy
 10h	WORD	first sector of root directory
 12h	DWORD	address of device driver for this drive
 16h	BYTE	media descriptor byte for medium
 17h	BYTE	FFh indicates block must be rebuilt
 18h	DWORD	address of next device block, offset = FFFFh indicates last
 1Ch	WORD	starting cluster of current directory (0 = root directory)
 1Eh 64 BYTEs	ASCIZ current directory path string
---DOS 3.x---
 0Fh	BYTE	number of sectors in one FAT copy
 10h	WORD	first sector of root directory
 12h	DWORD	address of device driver for this drive
 16h	BYTE	media descriptor byte for medium
 17h	BYTE	FFh = block must be rebuilt, 00h indicates block accessed
 18h	DWORD	address of next device block, offset = FFFFh indicates last
 1Ch	WORD	cluster at which to start search for free space when writing
 1Eh	WORD	number of free clusters on drive, FFFFh = unknown
---DOS 4.0---
 0Fh	WORD	number of sectors in one FAT copy
 11h	WORD	first sector of root directory
 13h	DWORD	address of device driver for this drive
 17h	BYTE	media descriptor byte for medium
 18h	BYTE	FFh = block must be rebuilt, 00h indicates block accessed
 19h	DWORD	address of next device block, offset = FFFFh indicates last
 1Dh	WORD	cluster at which to start search for free space when writing
 1Fh	WORD	number of free clusters on drive, FFFFh = unknown
---------------------------------------------
INT 21 - DOS 2+ - EXTENDED CONTROL-BREAK CHECKING
	AH = 33h
	AL = subfunction
	    00h get state
		Return: DL = current BREAK setting
			    00h BREAK=OFF
			    01h BREAK=ON
	    01h set state
		DL = 00h for OFF or 01h for ON
Return:	AL = FFh if error
Note:	under DOS 3+, this function does not use any of the DOS-internal stacks
	  and is thus fully reentrant
---------------------------------------------
INT 21 - DOS 3.x internal - GET AND SET EXTENDED CONTROL-BREAK CHECKING STATE
	AX = 3302h
	DL = new state
	     00h for OFF or 01h for ON
Return: DL = old state of extended BREAK checking
Note:	this function does not use any of the DOS-internal stacks and is thus
	  fully reentrant
---------------------------------------------
INT 21 - DOS 4.0 - GET BOOT DRIVE
	AX = 3305h
Return: DL = boot drive (1=A:,...)
---------------------------------------------
INT 21 - DOS 2+ internal - RETURN CritSectFlag POINTER
	AH = 34h
Return: ES:BX -> 1-byte DOS "Critical Section Flag", also known as InDOS flag
Notes:	when the critical section flag is nonzero, code within DOS is being
	  executed.  It is safe to enter DOS when both the critical section
	  flag and the critical error flag are zero.
	The critical error flag is the byte after the critical section flag in
	  DOS 2.x, and the byte BEFORE the critical section flag in DOS 3.x 
	  (except COMPAQ DOS 3.0, where the critical error flag is located 1AAh
	  bytes BEFORE the critical section flag)
	For DOS 3.1+, an undocumented call exists to get the address of the
	  critical error flag (see AX=5D06h)
---------------------------------------------
INT 21 - DOS 2+ - GET INTERRUPT VECTOR
	AH = 35h
	AL = interrupt number
Return: ES:BX = value of interrupt vector
SeeAlso: AH=25h
---------------------------------------------
INT 21 - DOS 2+ - GET DISK SPACE
	AH = 36h
	DL = drive code (0 = default, 1 = A, 2 = B, etc.)
Return: AX = number of sectors per cluster
	     or 0FFFFh if invalid drive
	BX = number of available clusters
	CX = bytes per sector
	DX = total clusters
Notes:	multiply AX * CX * BX for free space on disk
	multiply AX * CX * DX for total disk space
	according to Dave Williams' MSDOS reference, the value in DX is
	  incorrect for non-default drives after ASSIGN is run
SeeAlso: AH=1Ch
---------------------------------------------
INT 21 - DOS 2+ internal - GET SWITCHAR
	AX = 3700h
Return: AL = FFh unsupported subfunction
	DL = current switch character
Note:	documented in some OEM versions of some releases of DOS
---------------------------------------------
INT 21 - DOS 2+ internal - SET SWITCHAR
	AX = 3701h
	DL = new switch character
Return: AL = FFh unsupported subfunction
Note:	documented in some OEM versions of some releases of DOS
---------------------------------------------
INT 21 - DOS 2.x only internal - AVAILDEV
	AH = 37h
	AL = subfunction
	   02h read device availability (as set by AL=03h)
		Return: DL = device availability
	   03h set device availability, where:
		DL = 00h means \DEV\ must preceed device names
		DL <> 00h means \DEV\ need not preceed device names
Return: AL = FFh if invalid subfunction
---------------------------------------------
INT 21 - DOS 2+ - GET COUNTRY-DEPENDENT INFORMATION
	AH = 38h
--DOS 2.x--
	AL = 00h get current-country info
	DS:DX -> buffer for returned info (see below)
Return: AX = country code (MSDOS 2.11 only)
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
SeeAlso: AH=65h

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

Format of MSDOS 2.x, DOS 3+ country info:
Offset	Size	Description
 00h	WORD	date format (see above)
 02h  5 BYTEs	ASCIZ currency symbol string
 07h	BYTE	thousands separator char
 08h	BYTE	00h
 09h	BYTE	decimal separator char
 0Ah	BYTE	00h
 0Bh	BYTE	date separator char
 0Ch	BYTE	00h
 0Dh	BYTE	time separator char
 0Eh	BYTE	00h
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
		(FAR CALL, AL = char to map to upper case [>= 80h])
 16h	BYTE	data-list separator char
 17h	BYTE	00h
 18h 10 BYTEs	reserved
---------------------------------------------
INT 21 - DOS 3+ - SET COUNTRY CODE
	AH = 38h
	AL = 01h thru 0FEh for specific country with code <255
	AL = FFh for specific country with code >= 255
	   BX = 16-bit country code
	DX = FFFFh
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
---------------------------------------------
INT 21 - DOS 2+ - CREATE A SUBDIRECTORY (MKDIR)
	AH = 39h
	DS:DX -> ASCIZ pathname (may include drive)
Return: CF set on error
	    AX = error code (03h,05h) (see AH=59h)
Note:	all directories in the given path except the last must exist
SeeAlso: AH=3Ah,3Bh
---------------------------------------------
INT 21 - DOS 2+ - REMOVE A DIRECTORY ENTRY (RMDIR)
	AH = 3Ah
	DS:DX -> ASCIZ pathname (may include drive)
Return: CF set on error
	    AX = error code (03h,05h,06h,10h) (see AH=59h)
SeeAlso: AH=39h,3Bh
---------------------------------------------
INT 21 - DOS 2+ - CHANGE THE CURRENT DIRECTORY (CHDIR)
	AH = 3Bh
	DS:DX -> ASCIZ directory name (may include drive)
Return: CF set on error
	    AX = error code (03h) (see AH=59h)
Note:	if new directory name includes a drive letter, the default drive is
	  not changed, only the current directory on that drive
SeeAlso: AH=47h
---------------------------------------------
INT 21 - DOS 2+ - CREATE A FILE WITH HANDLE (CREAT)
	AH = 3Ch
	CX = attributes for file
	    bit 0: read-only
		1: hidden
		2: system
		3: volume label (ignored)
		4: reserved, must be zero (directory)
		5: archive bit
		7: if set, file is shareable under Novell NetWare
	DS:DX -> ASCIZ filename (may include drive and path)
Return: CF set on error
	    AX = error code (03h,04h,05h) (see AH=59h)
	CF clear if successful
	    AX = file handle
Note:	if a file with the given name exists, it is truncated to zero length
SeeAlso: AH=3Dh
---------------------------------------------
INT 21 - DOS 2+ - OPEN DISK FILE WITH HANDLE
	AH = 3Dh
	AL = access mode
	    00h read only
	    01h write only
	    02h read/write
	AL bits 7-3 = file-sharing modes (DOS 3+)
	    bit 7    = inheritance flag, set for no inheritance
	    bits 4-6 = sharing mode
		      000 compatibility mode
		      001 exclusive (deny all)
		      010 write access denied (deny write)
		      011 read access denied (deny read)
		      100 full access permitted (deny none)
		      111 used internally by SHARE
	    bit 3    = reserved, should be zero
	DS:DX -> ASCIZ filename
Return: CF set on error
	    AX = error code (01h,02h,03h,04h,05h,0Ch) (see AH=59h)
	CF clear if successful
	    AX = file handle
Notes:	file pointer is set to start of file
	file handles which are inherited from a parent also inherit sharing
	  and access restrictions
SeeAlso: AH=0Fh,3Ch

File sharing behavior:
	  |	Second and subsequent Opens
 First	  |Compat  Deny	  Deny	 Deny	Deny
 Open	  |	   All	  Write	 Read	None
	  |R W RW R W RW R W RW R W RW R W RW
 - - - - -| - - - - - - - - - - - - - - - - -
 Compat	R |Y Y Y  N N N  1 N N	N N N  1 N N
	W |Y Y Y  N N N  N N N	N N N  N N N
	RW|Y Y Y  N N N  N N N	N N N  N N N
 - - - - -|
 Deny	R |C C C  N N N  N N N	N N N  N N N
 All	W |C C C  N N N  N N N	N N N  N N N
	RW|C C C  N N N  N N N	N N N  N N N
 - - - - -|
 Deny	R |2 C C  N N N  Y N N	N N N  Y N N 
 Write	W |C C C  N N N  N N N	N N N  N N N 
	RW|C C C  N N N  N N N	N N N  N N N
 - - - - -|
 Deny	R |C C C  N N N  N Y N	N N N  N Y N
 Read	W |C C C  N N N  N N N	N N N  N Y N
	RW|C C C  N N N  N N N	N N N  N Y N
 - - - - -|
 Deny	R |2 C C  N N N  Y Y Y	N N N  Y Y Y
 None	W |C C C  N N N  N N N	Y Y Y  Y Y Y
	RW|C C C  N N N  N N N	N N N  Y Y Y
Legend: Y = open succeeds, N = open fails with error code 05h
	C = open fails, INT 24 generated
	1 = open succeeds if file read-only, else fails with error code
	2 = open succeeds if file read-only, else fails with INT 24
---------------------------------------------
INT 21 - DOS 2+ - CLOSE A FILE WITH HANDLE
	AH = 3Eh
	BX = file handle
Return: CF set on error
	    AX = error code (06h) (see AH=59h)
Note:	if the file was written to, the time and date stamps are set to the
	  current time
SeeAlso: AH=10h,3Ch,3Dh
---------------------------------------------
INT 21 - DOS 2+ - READ FROM FILE WITH HANDLE
	AH = 3Fh
	BX = file handle
	CX = number of bytes to read
	DS:DX -> buffer
Return: CF set on error
	    AX = error code (05h,06h) (see AH=59h)
	CF clear if successful
	    AX = number of bytes read (0 if at EOF before call)
Notes:	the returned AX may be smaller than the request in CX if a partial
	  read occurred
	if reading from CON, read stops at first CR
SeeAlso: AH=27h,40h
---------------------------------------------
INT 21 - DOS 2+ - WRITE TO FILE WITH HANDLE
	AH = 40h
	BX = file handle
	CX = number of bytes to write
	DS:DX -> buffer
Return: CF set on error
	    AX = error code (05h,06h) (see AH=59h)
	CF clear if successful
	    AX = number of bytes actually written
Notes:	if CX is zero, no data is written, and the file is truncated or
	  extended to the current position
	the usual cause for AX < CX on return is a full disk
SeeAlso: AH=28h,3Fh
---------------------------------------------
INT 21 - DOS 2+ - DELETE A FILE (UNLINK)
	AH = 41h
	DS:DX -> ASCIZ pathname of file to delete (no wildcards allowed)
Return: CF set on error
	    AX = error code (02h,05h) (see AH=59h)
SeeAlso: AH=13h
---------------------------------------------
INT 21 - DOS 2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
	AH = 42h
	AL = method
	    00h offset from beginning of file
	    01h offset from present location
	    02h offset from end of file
	BX = file handle
	CX:DX = offset in bytes
Return: CF set on error
	    AX = error code (01h,06h) (see AH=59h)
	CF clear if successful
	    DX:AX = new absolute offset from beginning of file
SeeAlso: AH=24h
---------------------------------------------
INT 21 - DOS 2+ - GET FILE ATTRIBUTES
	AX = 4300h
	DS:DX -> ASCIZ file name or directory name without trailing slash
Return: CF set on error
	    AX = error code (01h,02h,03h,05h) (see AH=59h)
	CF clear if successful
	    CX = file attributes (see AX=4301h)
---------------------------------------------
INT 21 - DOS 2+ - PUT FILE ATTRIBUTES (CHMOD)
	AX = 4301h
	CX = file attribute bits
	    bit 0 = read only
		1 = hidden file
		2 = system file
		3 = volume label
		4 = subdirectory
		5 = written since backup ("archive" bit)
		8 = shareable (Novell NetWare)
	DS:DX -> ASCIZ file name
Return: CF set on error
	    AX = error code (01h,02h,03h,05h) (see AH=59h)
Note:	will not change volume label or directory attributes
---------------------------------------------
INT 21 - DOS 2+ - IOCTL - GET DEVICE INFORMATION
	AX = 4400h
	BX = file or device handle
Return: CF set on error
	   AX = error code (see AH=59h)
	CF clear if successful
	   DX = device info
	   If bit 7 set: (character device)
	       bit 0: console input device
		   1: console output device
		   2: NUL device
		   3: CLOCK$ device
		   4: device is special (uses INT 29)
		   5: binary (raw) mode
		   6: Not EOF
		  12: network device (DOS 3+)
		  14: can process IOCTL control strings (see AL = 02h-05h)
	   If bit 7 clear: (file)
	       bits 0-5 are block device number
		   6: file has not been written
		  12: network device (DOS 3+)
		  14: can process IOCTL control strings (DOS 3+)
		  15: file is remote (DOS 3+)
SeeAlso: AX=4401h
---------------------------------------------
INT 21 - DOS 2+ - IOCTL - SET DEVICE INFORMATION
	AX = 4401h
	BX = device handle
	DH = 0
	DL = device information to set (bits 0-7 from function 0)
Return: CF set on error
	    AX = error code (see AH=59h)
SeeAlso: AX=4400h
---------------------------------------------
INT 21 - DOS 2+ - IOCTL - READ CHARACTER DEVICE CONTROL STRING
	AX = 4402h
	BX = device handle
	CX = number of bytes to read
	DS:DX -> buffer
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    AX = number of bytes read
SeeAlso: AX=4403h,4404h
---------------------------------------------
INT 21 - DOS 2+ - IOCTL - WRITE CHARACTER DEVICE CONTROL STRING
	AX = 4403h
	BX = device handle
	CX = number of bytes to write
	DS:DX -> buffer
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    AX = number of bytes written
SeeAlso: AX=4402h,4405h
---------------------------------------------
INT 21 - DOS 2+ - IOCTL - READ BLOCK DEVICE CONTROL STRING
	AX = 4404h
	BL = drive number (0=default)
	CX = number of bytes to read
	DS:DX -> buffer
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    AX = number of bytes read
SeeAlso: AX=4402h,4405h
---------------------------------------------
INT 21 - DOS 2+ - IOCTL - WRITE BLOCK DEVICE CONTROL STRING
	AX = 4405h
	BL = drive number (0=default)
	CX = number of bytes to write
	DS:DX -> buffer
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    AX = number of bytes written
SeeAlso: AX=4403h,4404h
---------------------------------------------
INT 21 - DOS 2+ - IOCTL - GET INPUT STATUS
	AX = 4406h
	BX = file or device handle
Return: AL = FFh device ready
	     00h device not ready (or file at EOF)
SeeAlso: AX=4407h
---------------------------------------------
INT 21 - DOS 2+ - IOCTL - GET OUTPUT STATUS
	AX = 4407h
	BX = file or device handle
Return: AL = FFh device ready
	     00h device not ready
Note:	for DOS 2.x, files are always ready for output
SeeAlso: AX=4406h
---------------------------------------------
INT 21 - DOS 3+ - IOCTL - BLOCK DEVICE CHANGEABLE
	AX = 4408h
	BL = drive number (0=default)
Return:	CF set on error
	    AX = error code (0Fh invalid drive) (see AH=59h)
	CF clear if successful
	    AX = 00h removable
		 01h fixed
SeeAlso: AX=4400h,4409h
---------------------------------------------
INT 21 - DOS 3+ - IOCTL - BLOCK DEVICE LOCAL
	AX = 4409h
	BL = drive number (0=default)
Return: DX = attribute word, bit 12 set if device is remote
SeeAlso: AX=4400h,4408h,440Ah
---------------------------------------------
INT 21 - DOS 3+ - IOCTL - HANDLE LOCAL
	AX = 440Ah
	BX = file handle
Return: DX = attribute word, bit 15 set if file is remote
Note:	if file is remote, Novell Advanced NetWare 2.0 returns the number of
	  the file server on which the handle is located in CX
SeeAlso: AX=4400h,4409h
---------------------------------------------
INT 21 - DOS 3+ - IOCTL - SET SHARING RETRY COUNT
	AX = 440Bh
	CX = delay (default 1)
	DX = retry count (default 3)
Return: CF set on error
	    AX = error code (see AH=59h)
SeeAlso: AH=52h
---------------------------------------------
INT 21 - DOS 3.2+ - IOCTL - GENERIC
	AX = 440Ch
	BX = device handle
	CH = category code
	    00h unknown (DOS 3.3+)
	    01h COMn: (DOS 3.3+)
	    03h CON (DOS 3.3+)
	    05h LPTn:
	CL = function
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
	DS:DX -> (OS/2 comp box) data block
SeeAlso: INT 2F/AX=1A01h

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
 00h	BYTE	level (0 for DOS 4.0)
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
---------------------------------------------
INT 21 - DOS 3.2+ - IOCTL - BLOCK DEVICE REQUEST
	AX = 440Dh
	BL = drive number (0=default)
	CH = category code
	    08h disk drive
	CL = function
 	    40h set device parameters
	    41h write logical device track
	    42h format and verify logical device track
	    46h (DOS 4.0) set ???
	    47h (DOS 4.0) set access flag
	    60h get device parameters
	    61h read logical device track
	    62h verify logical device track
	    67h (DOS 4.0) get access flag
	DS:DX -> (DOS) parameter block (see below)
	SI:DI -> (OS/2 comp box) parameter block (see below)
Return: CF set on error
	   AX = error code (see AH=59h)
	DS:DX -> (OS/2 comp box) data block
Note:	DOS 4.01 seems to ignore the high byte of the number of directory
	  entries in the BPB for diskettes.

Format of parameter block for functions 40h, 60h:
Offset	Size	Description
 00h	BYTE	special functions
		bit 0 set if function to use current BPB, clear if Device BIOS
			Parameter Block field contains new default BPB
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
		07h  1.44M disk
		08h  other type of block device
 02h	WORD	device attributes
		bit 0 set if nonremovable medium
		bit 1 set if door lock supported
		bits 2-15 reserved
 04h	WORD	number of cylinders
 06h	BYTE	media type
		00h 1.2M disk (default)
		01h 320K/360K disk
 07h 31 BYTEs	device BPB (see AH=53h)
 26h	WORD	number of sectors per track (start of track layout field)
 28h  N word pairs: number,size of each sector in track

Format of parameter block for functions 41h, 61h:
Offset	Size	Description
 00h	BYTE	reserved, must be zero
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
		on return (DOS 4.0):
		  bit 0: set if specified tracks, sectors/track supported
		  bit 1: set if function not supported by BIOS
		  bit 2: set if specified tracks, sectors/track not supported
		  bit 3: set if no disk in drive
 01h	WORD	number of disk head
 03h	WORD	number of disk cylinder

Format of parameter block for functions 47h, 67h:
Offset	Size	Description
 00h	BYTE	special-function field (must be zero)
 01h	BYTE	disk-access flag, nonzero if access allowed by driver
---------------------------------------------
INT 21 - DOS 3.2+ - IOCTL - GET LOGICAL DRIVE MAP
	AX = 440Eh
	BL = drive number (0=default)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    AL = 00h block device has only one logical drive assigned
		 1..26 the last letter used to reference the drive (1=A:,etc)
SeeAlso: AX=440Fh
---------------------------------------------
INT 21 - DOS 3.2+ - IOCTL - SET LOGICAL DRIVE MAP
	AX = 440Fh
	BL = physical drive number (0=default)
Return: CF set on error
	    AX = error code (see AH=59h)
Note:	maps logical drives to physical drives, similar to DOS's treatment of
	  a single physical floppy drive as both A: and B:
SeeAlso: AX=440Eh
---------------------------------------------
INT 21 - DOS 2+ - CREATE DUPLICATE HANDLE (DUP)
	AH = 45h
	BX = file handle to duplicate
Return: CF set on error
	    AX = error code (04h,06h) (see AH=59h)
	CF clear if successful
	    AX = new file handle
Note:	moving file pointer for either handle will also move it for the other
SeeAlso: AH=46h
---------------------------------------------
INT 21 - DOS 2+ - FORCE DUPLICATE HANDLE (FORCDUP,DUP2)
	AH = 46h
	BX = existing file handle
	CX = new file handle
Return: CF set on error
	    AX = error code (04h,06h) (see AH=59h)
Notes:	closes file with handle BX if it is still open
	moving file pointer for either handle will also move it for the other
SeeAlso: AH=45h
---------------------------------------------
INT 21 - DOS 2+ - GET CURRENT DIRECTORY
	AH = 47h
	DL = drive (0=default, 1=A, etc.)
	DS:SI points to 64-byte buffer area
Return: CF set on error
	    AX = error code (0Fh) (see AH=59h)
Note:	the returned path does not include a drive or the initial backslash
SeeAlso: AH=3Bh
---------------------------------------------
INT 21 - DOS 2+ - ALLOCATE MEMORY
	AH = 48h
	BX = number of 16-byte paragraphs desired
Return: CF set on error
	    AX = error code (07h,08h) (see AH=59h)
	    BX = size of largest available block
	CF clear if successful
	    AX = segment of allocated memory block
SeeAlso: AH=49h,4Ah,58h
---------------------------------------------
INT 21 - DOS 2+ - FREE MEMORY
	AH = 49h
	ES = segment address of area to be freed
Return: CF set on error
	    AX = error code (07h,09h) (see AH=59h)
SeeAlso: AH=48h,4Ah
---------------------------------------------
INT 21 - DOS 2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
	AH = 4Ah
	ES = segment address of block to change
	BX = new size in paragraphs
Return: CF set on error
	    AX = error code (07h,08h,09h) (see AH=59h)
	    BX = maximum size possible for the block (if AX=08h)
Notes:	under PCDOS 2.1 and 3.1 and MSDOS 3.2 and 3.3, if there is insufficient
	  memory to expand the block as much as requested, the block will be
	  made as large as possible
SeeAlso: AH=48h,49h
---------------------------------------------
INT 21 - DOS 2+ - LOAD OR EXECUTE (EXEC)
	AH = 4Bh
	AL = subfunction
	    00h load and execute program
	    01h load but do not execute (internal)
	    03h load overlay; do not create PSP
	    04h called by MSC spawn(P_NOWAIT,...) when running DOS 4.x.
		returns unsuccessfully under DOS 4.0 (but may be successful
		  in the original European OEM MSDOS 4.0, which has limited
		  multitasking built in)
	DS:DX -> ASCIZ filename
	ES:BX -> parameter block (see below)
Return: CF set on error
	    AX = error code (01h,02h,05h,08h,0Ah,0Bh) (see AH=59h)
	CF clear if successful
	    if subfunction 01h, process ID set to new program's PSP; get with
		INT 21/AH=62h
Notes:	DOS 2.x destroys all registers, including SS:SP
	for functions 00h and 01h, the calling process must ensure that there
	  is enough unallocated memory available; if necessary, by releasing
	  memory with AH=49h or AH=4Ah
SeeAlso: AH=4Ch,4Dh,INT 2E

Format of EXEC parameter block for AL=00h,01h:
Offset	Size	Description
 00h	WORD	segment of environment (0 = use current) (see AH=26h)
 02h	DWORD	pointer to command line
 06h	DWORD	pointer to first FCB (see AH=0Fh)
 0Ah	DWORD	pointer to second FCB (see AH=0Fh)
 0Eh	DWORD	(AL=01h) will hold subprogram's initial SS:SP on return
 12h	DWORD	(AL=01h) will hold entry point (CS:IP) on return

Format of EXEC parameter block for AL=03h:
Offset	Size	Description
 00h	WORD	segment load address
 02h	WORD	segment relocation factor

Format of .EXE file header:
Offset	Size  Description
 00h	WORD  4Dh, 5Ah signature (sometimes 5Ah, 4Dh)
 02h	WORD  image size remainder (program size mod 512, not including header)
 04h	WORD  number of 512-byte pages needed to hold .EXE file (incl header)
 06h	WORD  number of relocation items
 08h	WORD  header size in paragraphs
 0Ah	WORD  minimum extra paragraphs needed
 0Ch	WORD  maximum extra paragraphs needed
 0Eh	WORD  stack segment
 10h	WORD  stack offset
 12h	WORD  word checksum of entire file
 14h	DWORD initial CS:IP
 18h	WORD  offset of relocation table 
 1Ah	WORD  overlay number
Note:	if word at offset 02h is 4, it should be treated as 00h, since pre-1.10
	  versions of the MS linker set it that way
---------------------------------------------
INT 21 - DOS 2+ - QUIT WITH EXIT CODE (EXIT)
	AH = 4Ch
	AL = exit code
Return: never returns
Note:	unless the process is its own parent (see AH=26h, offset 16h in PSP),
	  all open files are closed
SeeAlso: AH=26h,4Bh,4Dh, INT 22
---------------------------------------------
INT 21 - DOS 2+ - GET EXIT CODE OF SUBPROGRAM (WAIT)
	AH = 4Dh
Return: AL = exit code of subprogram (from AH=31h or AH=4Ch)
	AH = circumstance which caused termination
	    00h Terminate/abort
	    01h Control-C/Control-Break
	    02h Hard error
	    03h Terminate and stay resident
SeeAlso: AH=4Bh,4Ch
---------------------------------------------
INT 21 - WILDUNIX.COM internal - INSTALLATION CHECK
	AH = 4Eh
	DS:DX = 0000h:0000h
Return:	AH = 99h if installed
Note:	WILDUNIX.COM is a resident Unix-style wildcard expander by Steve
	  Hosgood and Terry Barnaby
---------------------------------------------
INT 21 - DOS 2+ - FIND FIRST ASCIZ (FINDFIRST)
	AH = 4Eh
	CX = search attributes (see AX=4301h)
	DS:DX -> ASCIZ filespec (drive, path, and wildcards allowed)
Return: CF set on error
	    AX = error code (02h,12h) (see AH=59h)
	CF clear if successful
	    [DTA] = data block (see below)
Note:	for search attributes other than 08h, all files with at MOST the
	  specified attribute bits and the archive (20h) bit set will be
	  returned.  Under DOS 2.x, searching for attribute 08h (volume label)
	  will also return normal files.
SeeAlso: AH=11h,4Fh,AX=4301h

Format of FindFirst data block:
Offset	Size	Description
---PCDOS 3.10, MSDOS 3.2/3.3---
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
---MSDOS 3.2/3.3---
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
---------------------------------------------
INT 21 - DOS 2+ - FIND NEXT ASCIZ (FINDNEXT)
	AH = 4Fh
	[DTA] = data block from last AH = 4Eh/4Fh call
Return: CF set on error
	    AX = error code (12h) (see AH=59h)
	CF clear if successful
	    [DTA] = data block (see AH=4Eh)
SeeAlso: AH=12h,4Eh
---------------------------------------------
INT 21 - DOS 2+ internal - SET PSP SEGMENT
	AH = 50h
	BX = segment address of new PSP (see AH=26h for format)
Notes:	under DOS 2.x, this function cannot be invoked inside an INT 28h
	  handler without setting the Critical Error flag
	under DOS 3+, this function does not use any of the DOS-internal stacks
	  and is thus fully reentrant
SeeAlso: AH=26h,51h,62h
---------------------------------------------
INT 21 - DOS 2+ internal - GET PSP SEGMENT
	AH = 51h
Return: BX = current PSP segment (see AH=26h for format)
Notes:	under DOS 2.x, this function cannot be invoked inside an INT 28h
	  handler without setting the Critical Error flag
	under DOS 3+, this function does not use any of the DOS-internal stacks
	  and is thus fully reentrant
SeeAlso: AH=26h,50h,62h
---------------------------------------------
INT 21 - DOS 2+ internal - GET LIST OF LISTS
	AH = 52h
Return: ES:BX -> DOS list of lists
Note:	not supported in OS/2 compatibility box

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
 00h	DWORD	pointer to first DOS Device Control Block (see AH=32h)
 04h	DWORD	pointer to list of DOS file tables (see below)
 08h	DWORD	pointer to CLOCK$ device driver, resident or installable
 0Ch	DWORD	pointer to actual CON device driver, resident or installable
---DOS 2.x---
 10h	BYTE	number of logical drives in system
 11h	WORD	maximum bytes/block of any block device
 13h	DWORD	pointer to first disk buffer (see below)
 17h 18 BYTEs	actual NUL device driver header (not a pointer!)
		This is the first device on DOS's linked list of device 
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
		This is the first device on DOS's linked list of device 
		drivers. (see below for format)
---DOS 3.1-3.3---
 10h	WORD	maximum bytes/block of any block device
 12h	DWORD	pointer to first disk buffer (see below)
 16h	DWORD	pointer to array of current directory structures (see below)
 1Ah	DWORD	pointer to FCB table (if CONFIG.SYS contains FCBS=)
 1Eh	WORD	number of protected FCBs (the y in FCBS=x,y)
 20h	BYTE	number of block devices
 21h	BYTE	value of LASTDRIVE command in CONFIG.SYS (default 5)
 22h 18 BYTEs	actual NUL device driver header (not a pointer!)
		This is the first device on DOS's linked list of device 
		drivers. (see below for format) (see also INT 2F/AX=122Ch)
 34h	BYTE	number of JOIN'ed drives
---DOS 4.x---
 10h	WORD	maximum bytes/block of any block device
 12h	DWORD	pointer to disk buffer info (see below)
 16h	DWORD	pointer to array of current directory structures (see below)
 1Ah	DWORD	pointer to FCB table (if CONFIG.SYS contains FCBS=)
 1Eh	WORD	number of protected FCBs (the y in FCBS=x,y)
 20h	BYTE	number of block devices
 21h	BYTE	value of LASTDRIVE command in CONFIG.SYS (default 5)
 22h 18 BYTEs	actual NUL device driver header (not a pointer!)
		This is the first device on DOS's linked list of device 
		drivers. (see below for format) (see also INT 2F/AX=122Ch)
 34h	BYTE	number of JOIN'ed drives???
 35h	WORD	pointer within IBMDOS code segment to list of special program
		names
 37h	DWORD	pointer to ???
 3Bh	DWORD	pointer to chain of IFS (installable file system) drivers
 3Fh	WORD	the x in BUFFERS x,y (rounded up to multiple of 30 if in EMS)
 41h	WORD	the y in BUFFERS x,y
 43h	BYTE	boot drive??? (1=A:)
 44h	BYTE	running on a 386 ???
 45h	WORD	extended memory size in K

Format of memory control block:
Offset	Size	Description
 00h	BYTE	block type: 5Ah if last block in chain, otherwise 4Dh
 01h	WORD	PSP segment of owner, 0000h if free, 0008h if belongs to DOS
 03h	WORD	size of memory block in paragraphs
 05h  3 BYTEs	unused
---DOS 2.x,3.x---
 08h  8 BYTEs	unused
---DOS 4.x---
 08h  8 BYTEs	ASCII program name if PSP memory block, else garbage
		null-terminated if less than 8 characters
Notes:	under DOS 3.1+, the first memory block is the DOS data segment,
	  containing installable drivers, buffers, etc.
	under DOS 4.x it is divided into subsegments, each with its own memory
	  control block (see below), the first of which is at offset 0000h

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
		"L"  LASTDRIVE=  current directory structure array storage area
		"S"  STACKS=  code and data area, if present (see below)
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

SHARE.EXE hooks (DOS 3.1-4.01):
(offsets from first system file table--pointed at by ListOfLists+04h)
Offset	Size	Description
-3Ch	DWORD	pointer to FAR routine for ???
		Note: not called by MSDOS 3.3, set to 0000h:0000h by SHARE 3.3
-38h	DWORD	pointer to FAR routine called on opening file
		on call, internal DOS location points at filename(see AX=5D06h)
		Return: CF clear if successful
			CF set on error
			    AX = DOS error code (24h) (see AH=59h)
		Note: SHARE assumes DS=SS=DOS CS, direct-accesses DOS internals
			to get name of file just opened
-34h	DWORD	pointer to FAR routine called on closing file
		ES:DI -> system file table
		Note: SHARE assumes SS=DOS CS, directly accesses DOS internals
			does something to every lock record for file
-30h	DWORD	pointer to FAR routine to close all files for given computer
		(called by AX=5D03h)
		Note: SHARE assumes SS=DOS CS, directly accesses DOS internals
-2Ch	DWORD	pointer to FAR routine to close all files for given process
		(called by AX=5D04h)
		Note: SHARE assumes SS=DOS CS, directly accesses DOS internals
-28h	DWORD	pointer to FAR routine to close file by name
		(called by AX=5D02h)
		DS:SI -> DOS parameter list (see AX=5D00h)
		   request's DS:DX -> name of file to close
		Return: CF clear if successful
			CF set on error
			    AX = DOS error code (03h) (see AH=59h)
		Note: SHARE assumes SS=DOS CS, directly accesses DOS internals
-24h	DWORD	pointer to FAR routine to lock region of file
		call with BX = file handle
			  CX:DX = starting offset
			  SI:AX = size
		Return: CF set on error
			    AL = DOS error code (21h) (see AH=59h)
		Note: only called if file is marked as remote
		Note: SHARE assumes SS=DOS CS, directly accesses DOS internals
-20h	DWORD	pointer to FAR routine to unlock region of file
		call with BX = file handle
			  CX:DX = starting offset
			  SI:AX = size
		Return: CF set on error
			    AL = DOS error code (21h) (see AH=59h)
		Note: only called if file is marked as remote
		Note: SHARE assumes SS=DOS CS, directly accesses DOS internals
-1Ch	DWORD	pointer to FAR routine to check if file region is locked
		call with ES:DI -> system file table entry for file
			CX = length of region from current position in file
		Return: CF set if any portion of region locked
			    AX = 0021h
		Note: SHARE assumes SS=DOS CS, directly accesses DOS internals
-18h	DWORD	pointer to FAR routine to get open file list entry
		(called by AX=5D05h)
		call with DS:SI -> DOS parameter list (see AX=5D00h)
			request's BX = index of sharing record
			request's CX = index of SFT in SFT chain of sharing rec
		Return: CF set on error or not loaded
			    AX = DOS error code (12h) (see AH=59h)
			CF clear if successful
			    ES:DI -> filename
			    CX = number of locks owned by specified SFT
			    BX = network machine number
			    DX destroyed
		Note: SHARE assumes SS=DOS CS, directly accesses DOS internals
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
		Note: SHARE assumes SS=DOS CS, directly accesses DOS internals
		Note: if SFT was opened with inheritance enabled and sharing
			mode 111, does something to all other SFTs owned by
			same process which have the same file open mode and
			sharing record
-08h	DWORD	pointer to FAR routine for ???
		Note: SHARE assumes SS=DS=DOS CS, direct-accesses DOS internals
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
	 1Eh	WORD	relative cluster in file of last cluster read
	------
	 20h	WORD	absolute cluster number of current cluster
	 22h	WORD	???
	 24h	DWORD	current file position???

Format of DOS 3.x system file tables and FCB tables:
Offset	Size	Description
 00h	DWORD	pointer to next file table
 04h	WORD	number of files in this table
 06h  35h bytes per file
	Offset	Size	Description
	 00h	WORD	number of file handles referring to this file
	 02h	WORD	file open mode (see AH=3Dh)
			bit 15 set if this file opened via FCB
	 04h	BYTE	file attribute
	 05h	WORD	device info word (see AX=4400h)
	 07h	DWORD	pointer to device driver header if character device
			else pointer to DOS Device Control Block (see AH=32h)
	 0Bh	WORD	starting cluster of file
	 0Dh	WORD	file time in packed format (see AX=5700h)
	 0Fh	WORD	file date in packed format (see AX=5700h)
	 11h	DWORD	file size
	 15h	DWORD	current offset in file
	 19h	WORD	relative cluster within file of last cluster read
	 1Bh	WORD	absolute cluster number of last cluster read
			0000h if file never read or written???
	 1Dh	WORD	number of sector containing directory entry
	 1Fh	BYTE	number of dir entry within sector (byte offset/32)
	 20h 11 BYTEs	filename in FCB format (no path/period, blank-padded)
	 2Bh	DWORD	(SHARE.EXE) pointer to previous SFT sharing same file
	 2Fh	WORD	(SHARE.EXE) network machine number which opened file???
	 31h	WORD	PSP segment of file's owner (see AH=26h)
	 33h	WORD	offset within SHARE.EXE code segment of 
			sharing record (see below)  0000h = none

Format of DOS 4+ system file tables and FCB tables:
Offset	Size	Description
 00h	DWORD	pointer to next file table
 04h	WORD	number of files in this table
 06h  3Bh bytes per file
	Offset	Size	Description
	 00h	WORD	number of file handles referring to this file
	 02h	WORD	file open mode (see AH=3Dh)
			bit 15 set if this file opened via FCB
	 04h	BYTE	file attribute
	 05h	WORD	device info word (see AX=4400h)
			bit 15 set if remote file
			bit 14 set means do not set file date/time on closing
	 07h	DWORD	pointer to device driver header if character device
			else pointer to DOS Device Control Block (see AH=32h)
			or REDIR data
	 0Bh	WORD	starting cluster of file
	 0Dh	WORD	file time in packed format (see AX=5700h)
	 0Fh	WORD	file date in packed format (see AX=5700h)
	 11h	DWORD	file size
	 15h	DWORD	current offset in file
	---local file---
	 19h	WORD	relative cluster within file of last cluster read
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
			sharing record (see below)  0000h = none
	 35h	WORD	(local) absolute cluster number of last cluster read
			(redirector) ???
	 37h	DWORD	pointer to IFS driver for file, 0000000h if native DOS

Format of current directory structure (array, 51h bytes [58h for DOS 4.x] per
drive):
Offset	Size	Description
 00h 67 BYTEs	current path as ASCIZ, starting with 'x:\'
 43h	WORD	bit flags
		bit 15: network drive	\ installable file system if both set
		bit 14: physical drive	/ invalid drive if neither bit set
		bit 13: JOIN'ed, current path is actual path without JOIN
			drive letter in path may differ from logical drive name
		bit 12: SUBST'ed, current path is actual path without SUBST
			drive letter in path may differ from logical drive name
 45h	DWORD	pointer to DOS Disk Block for this drive
---local drives---
 49h	WORD	starting cluster of current directory
		0000h = root, FFFFh never accessed
 4Bh	WORD	??? seems always to be FFFFh
 4Dh	WORD	??? seems always to be FFFFh
---network drives---
 49h	DWORD	pointer to a redirector/REDIRIFS record, else FFFFFFFFh
 4Dh	WORD	stored parameter from INT 21/AX=5F03h???
------
 4Fh	WORD	Offset of '\' in current path field representing root directory 
		of logical drive (2 if not SUBST'ed or JOIN'ed, otherwise 
		number of bytes in SUBST/JOIN path)
---DOS 4.x---
 51h	BYTE	??? used by network
 52h	DWORD	pointer to IFS driver for this drive, 00000000h if native DOS
 56h	WORD	???

Format of device driver header:
Offset	Size	Description
 00h	DWORD	pointer to next driver, offset=FFFFh if last driver
 04h	WORD	device attributes
		Character device:
		   bit 15  set
		   bit 14  IOCTL supported (see AH=44h)
		   bit 13  (DOS 3+) output until busy supported
		   bit 12  reserved
		   bit 11  (DOS 3+) OPEN/CLOSE/RemMedia calls supported
		   bits 10-7 reserved
		   bit 6  (DOS 3.2+) Generic IOCTL call supported (command 13h)
				(see AX=440Ch,440Dh)
		   bit 5  reserved
		   bit 4  device is special (use INT 29 "fast console output")
		   bit 3  device is CLOCK$ (all reads/writes use transfer
				record described below)
		   bit 2  device is NUL
		   bit 1  device is standard output
		   bit 0  device is standard input
		Block device:
		   bit 15  clear
		   bit 14  IOCTL supported
		   bit 13  non-IBM format
		   bit 12  reserved
		   bit 11  (DOS 3+) OPEN/CLOSE/RemMedia calls supported
		   bit 10  reserved
		   bit 9   ??? set by DOS 3.3 DRIVER.SYS for "new" drives
		   bit 8   ??? set by DOS 3.3 DRIVER.SYS for "new" drives
		   bit 7   reserved
		   bit 6  (DOS 3.2+) Generic IOCTL call supported (command 13h)
				implies support for commands 17h and 18h
				(see AX=440Ch,440Dh,440Eh,440Fh)
		   bits 5-2 reserved
		   bit 1   driver supports 32-bit sector addressing
		   bit 0   reserved
 06h	WORD	device strategy entry point
		call with ES:BX -> request header (see INT 2F/AX=0802h)
 08h	WORD	device interrupt entry point
 0Ah  8 BYTEs	blank-padded character device name
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
 04h	BYTE	drive (0=A, 1=B, etc), FFh if not in use
 05h  3 BYTEs	unused??? (seems always to be 00h 00h 01h)
 08h	WORD	logical sector number
 0Ah	BYTE	number of copies to write (1 for non-FAT sectors)
 0Bh	BYTE	sector offset between copies if multiple copies to be written
 0Ch	DWORD	pointer to DOS Device Control Block (see AH=32h)
 10h		buffered data

Format of DOS 3.x disk buffer:
Offset	Size	Description
 00h	DWORD	pointer to next disk buffer, offset = FFFFh if last
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
 0Ah	DWORD	pointer to DOS Device Control Block (see AH=32h)
 0Eh	WORD	unused??? (almost always 0)
 10h		buffered data

Format of DOS 4.00 disk buffer info:
Offset	Size	Description
 00h	DWORD	pointer to array of disk buffer hash chain heads (see below)
 04h	WORD	number of disk buffer hash chains (referred to as NDBCH below)
 06h	DWORD	pointer to lookahead buffer, zero if not present
 0Ah	WORD	number of lookahead sectors, else zero (the y in BUFFERS=x,y)
 0Ch	BYTE	??? seems always to be zero
 0Dh	WORD	EMS handle for buffers, zero if not in EMS
 0Fh	WORD	EMS physical page number used for buffers (usually 255)
 11h	WORD	??? seems always to be 1
 13h	WORD	segment of EMS physical page frame
 15h	WORD	??? seems always to be zero
 17h  4 WORDs	EMS partial page mapping information???

Format of DOS 4.01 (from UR 25066 on) disk buffer info:
Offset	Size	Description
 00h	DWORD	pointer to array of disk buffer hash chain heads (see below)
 04h	WORD	number of disk buffer hash chains (referred to as NDBCH below)
 06h	DWORD	pointer to lookahead buffer, zero if not present
 0Ah	WORD	number of lookahead sectors, else zero (the y in BUFFERS=x,y)
 0Ch  8 BYTEs	???
 14h	DWORD	pointer to workspace buffer, purpose ???, allocated in main
		memory if BUFFERS/XS or /XD options in effect
 18h	WORD	EMS handle for buffers, zero if not in EMS
 1Ah	WORD	EMS physical page number used for buffers (usually 255)
 1Ch	WORD	??? seems always to be 1
 1Eh	WORD	segment of EMS physical page frame
 20h	WORD	??? seems always to be zero

Format of DOS 4.x disk buffer hash chain head (array, one entry per chain):
Offset	Size	Description
 00h	WORD	EMS logical page number in which chain is resident, -1 if not
		in EMS
 02h	DWORD	pointer to least recently used buffer header.  All buffers on
		this chain are in the same segment.
 06h	BYTE	number of dirty buffers on this chain
 07h	BYTE	reserved (00h)
Note:	buffered disk sectors are assigned to chain N where N is the sector's
	  address modulo NDBCH,  0 <= N <= NDBCH-1
	each chain resides completely within one EMS page
	this structure is in main memory even if buffers are in EMS

Format of DOS 4.x disk buffer:
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
 0Dh	DWORD	pointer to DOS Device Control Block (see AH=32h)
 11h	WORD	buffer use count if remote buffer (see flags above)
 13h	BYTE	reserved
 14h		buffered data
Note:	all buffered sectors which have the same hash value (computed as the
	  sum of high and low words of the logical sector number divided by
	  NDBCH) are on the same doubly-linked circular chain
	the links consist of offset addresses only, the segment being the same
	  for all buffers in the chain.
---------------------------------------------
INT 21 - DOS 2+ internal - TRANSLATE BIOS PARAMETER BLOCK
	AH = 53h
	DS:SI -> BPB (Bios Parameter Block)
	ES:BP -> buffer for DOS Disk Block
Note:	translates BPB (see below) into a DOS Disk Parameter Block (see AH=32h)

Format of BIOS Parameter Block:
Offset	Size	Description
 00h	WORD	bytes/sector. Get from DDB bytes 2-3.
 02h	BYTE	sectors/cluster. Get from (DDB byte 4) + 1
 03h	WORD	reserved sectors. Get from DDB bytes 6-7
 05h	BYTE	number of FATs. Get from DDB byte 8
 06h	WORD	number of root dir entries. Get from DDB bytes 09h-0Ah
 08h	WORD	total number of sectors. Get from:
		  ((DDB bytes 0Dh-0Eh) - 1) * (sectors/cluster (BPB byte 2))
		    + (DDB Bytes 0Bh-0Ch)
		for DOS 4.0, set to zero if partition >32M, then set DWORD at
		  15h to actual number of sectors
 0Ah	BYTE	media descriptor byte. Get from DDB byte 16h
 0Bh	WORD	number of sectors/FAT. Get from DDB byte 0Fh
---DOS 3+---
 0Dh	WORD	number of sectors per track
 0Fh	WORD	number of heads
 11h	DWORD	number of hidden sectors
 15h 11 BYTEs	reserved	
---DOS 4.0---
 15h	DWORD	total number of sectors if word at 08h contains zero
---------------------------------------------
INT 21 - DOS 2+ - GET VERIFY FLAG
	AH = 54h
Return: AL = 00h if flag OFF
	AL = 01h if flag ON
SeeAlso: AH=2Eh
---------------------------------------------
INT 21 - DOS 2+ internal - CREATE PSP
	AH = 55h
	DX = segment number at which to set up PSP (see AH=26h)
	SI = value to place in memory size field at DX:[0002h]
Note:	like AH=26h but creates "child" PSP rather than copying existing one
SeeAlso: AH=26h
---------------------------------------------
INT 21 - DOS 2+ - RENAME A FILE
	AH = 56h
	DS:DX -> ASCIZ old name (drive and path allowed, no wildcards)
	ES:DI -> ASCIZ new name
Return: CF set on error
	    AX = error code (02h,03h,05h,11h) (see AH=59h)
Note:	allows move between directories on same logical volume
	(DOS 3+) allows renaming of directories
SeeAlso: AH=17h
---------------------------------------------
INT 21 - DOS 2+ - GET FILE'S DATE/TIME
	AX = 5700h
	BX = file handle
Return: CF set on error
	    AX = error code (01h,06h) (see AH=59h)
	CF clear if successful
	    CX = time of last write
		bits 11-15: hour
		     5-10:  minute
		     0-4:   seconds/2
	    DX = date of last write
		bits 9-15:   year-1980 (max 119 = 2099)
		     5-8:    month
		     0-4:    day
SeeAlso: AX=5701h
---------------------------------------------
INT 21 - DOS 2+ - SET FILE'S DATE/TIME
	AX = 5701h
	BX = file handle
	CX = time to be set (see AX=5700h)
	DX = date to be set (see AX=5700h)
Return: CF set on error
	    AX = error code (01h,06h) (see AH=59h)
SeeAlso: AX=5700h
---------------------------------------------
INT 21 - DOS 4.0 - ???
	AX = 5702h
	???
Return: ???
---------------------------------------------
INT 21 - DOS 4.0 - ???
	AX = 5704h
	???
Return: ???
---------------------------------------------
INT 21 - DOS 3+ - GET/SET MEMORY ALLOCATION STRATEGY
	AH = 58h
	AL = function code
	    00h get allocation strategy
	    01h set allocation strategy
	       BL = strategy code
		   00h first fit (use first memory block large enough)
		   01h best fit (use smallest memory block large enough)
		   02h last fit (use high part of last usable memory block)
Return: CF set on error
	    AX = error code (01h) (see AH=59h)
	CF clear if successful
	    AX = strategy code
Note: the Set subfunction accepts any value in BL; 2 or greater means last fit.
      the Get subfunction returns the last value set, so programs should check
      whether the value is >= 2, not just equal to 2.
SeeAlso: AH=48h,49h,4Ah
---------------------------------------------
INT 21 - DOS 3+ - GET EXTENDED ERROR CODE
	AH = 59h
	BX = version code (0000h for DOS 3.x)
Return: AX = extended error code (see below)
	BH = class of error (see below)
	BL = suggested action (see below)
	CH = locus (where error occurred) (see below)
	CL, DX, SI, DI, BP, DS, and ES destroyed
Notes:	functions available under DOS 2.x map the true DOS 3+ error code into
	  one supported under DOS 2.x
	you should call this function to retrieve the true error code when an
	  FCB or DOS 2.x call returns an error
SeeAlso: AX=5D0Ah,INT 2F/AX=122Dh

Values for extended error code:
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
	0Fh invalid drive
	10h attempted to remove current directory
	11h not same device
	12h no more files
	13h disk write-protected
	14h unknown unit
	15h drive not ready
	16h unknown command
	17h data error (CRC)
	18h bad request structure length
	19h seek error
	1Ah unknwon media type (non-DOS disk)
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
	25h reserved
	26h (LANtastic) cannot complete file operation
	27h-31h reserved
	32h Network request not supported (DOS 3.1 + MS Networks)
	33h Remote computer not listening
	34h Duplicate name on network
	35h Network name not found
	36h Network busy
	37h Network device no longer exists
	38h Network BIOS command limit exceeded
	39h Network adapter hardware error
	3Ah Incorrect response from network
	3Bh Unexpected network error
	3Ch Incompatible remote adapter
	3Dh Print queue full
	3Eh Queue not full
	3Fh Not enough space to print file
	40h Network name was deleted
	41h Network: Access denied
	42h Network device type incorrect
	43h Network name not found
	44h Network name limit exceeded
	45h Network BIOS session limit exceeded
	46h Temporarily paused
	47h Network request not accepted
	48h (DOS 3.1 + MS Networks) Print/disk redirection paused
	49h (LANtastic) invalid network version
	4Ah (LANtastic) account expired
	4Bh (LANtastic) password expired
	4Ch (LANtastic) login attempt invalid at this time
	4Dh-4Fh reserved
	50h file exists
	51h reserved
	52h cannot make directory
	53h fail on INT 24h
	54h (DOS 3.3+) too many redirections
	55h (DOS 3.3+) duplicate redirection
	56h (DOS 3.3+) invalid password
	57h (DOS 3.3+) invalid parameter
	58h (DOS 3.3+) network write fault
	59h (LANtastic) function not supported on network
	5Ah (LANtastic) required system component not installed
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
---------------------------------------------
INT 21 - DOS 3+ - CREATE UNIQUE FILE
	AH = 5Ah
	DS:DX -> ASCIZ directory path name ending with a '\' + 13 bytes to
		 receive generated filename
	CX = file attributes (only bits 0,1,2,5 may be set)
Return: CF set on error
	    AX = error code (03h,05h) (see AH=59h)
	CF clear if successful
	    AX = file handle
	DS:DX -> path name
Note: The file created is not truly temporary.	It MUST be removed by the user.
SeeAlso: AH=3Ch,5Bh
---------------------------------------------
INT 21 - DOS 3+ - CREATE NEW FILE
	AH = 5Bh
	DS:DX -> ASCIZ directory path name
	CX = file attribute (see AX=4301h)
Return: CF set on error
	    AX = error code (03h,04h,05h,50h) (see AH=59h)
	CF clear if successful
	DS:DX -> path name
Note:	unlike function 3Ch, function 5Bh will fail if the file already exists
SeeAlso: AH=3Ch,5Ah
---------------------------------------------
INT 21 - DOS 3+ - LOCK/UNLOCK FILE ACCESS
	AH = 5Ch
	AL = 00h lock
	     01h unlock
	BX = file handle
	CX:DX = starting offset of region to lock
	SI:DI = size of region to lock
Return: CF set on error
	    AX = error code (01h,06h,21h) (see AH=59h)
Note:	error returned unless SHARE or network installed
SeeAlso: AX=440Bh
---------------------------------------------
INT 21 - DOS 3.1+ internal - SERVER FUNCTION CALL
	AX = 5D00h
	DS:DX -> DOS parameter list (see below)
	DPL contains all register values for a call to INT 21h
Return: as appropriate for function being called
Notes:	does not check AH.  Out of range values will crash the system
	executes using specified computer ID and process ID

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
---------------------------------------------
INT 21 - DOS 3.1+ internal - COMMIT ALL FILES FOR SPECIFIED COMPUTER/PROCESS
	AX = 5D01h
	DS:DX -> DOS parameter list (see AX=5D00h), only computer ID and
		process ID fields used
Return: CF set on error
	    AX = error code (see AH=59h)
Note:	flushes buffers and updates directory entries for each file which has
	  been written to; if remote file, calls INT 2F/AX=1107h
SeeAlso: AH=68h
---------------------------------------------
INT 21 - DOS 3.1+ internal - SHARE.EXE - CLOSE FILE BY NAME
	AX = 5D02h
	DS:DX -> DOS parameter list (see AX=5D00h), only fields DX, DS,
		computer ID, and process ID used
	request's DS:DX -> ASCIZ name of file to close
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Notes:	error unless SHARE is loaded (calls [SysFileTable-28h]) (see AH=52h)
	name must be canonical fully-qualified, such as returned by AH=60h
SeeAlso: AX=5D03h,5D04h,AH=3Eh,60h
---------------------------------------------
INT 21 - DOS 3.1+ internal - SHARE.EXE - CLOSE ALL FILES FOR GIVEN COMPUTER
	AX = 5D03h
	DS:DX -> DOS parameter list (see AX=5D00h), only computer ID used
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Note:	error unless SHARE is loaded (calls [SysFileTable-30h]) (see AH=52h)
SeeAlso: AX=5D02h,5D04h
---------------------------------------------
INT 21 - DOS 3.1+ internal - SHARE.EXE - CLOSE ALL FILES FOR GIVEN PROCESS
	AX = 5D04h
	DS:DX -> DOS parameter list (see AX=5D00h), only computer ID and
		process ID fields used
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
Note:	error unless SHARE is loaded (calls [SysFileTable-2Ch]) (see AH=52h)
SeeAlso: AX=5D02h,5D03h
---------------------------------------------
INT 21 - DOS 3.1+ internal - SHARE.EXE - GET OPEN FILE LIST ENTRY
	AX = 5D05h
	DS:DX -> DOS parameter list (see AX=5D00h)
	DPL's BX = index of sharing record
	DPL's CX = index of SFT in sharing record's SFT list
Return: CF clear if successful
	    ES:DI -> ASCIZ filename
	    BX = network machine number of SFT's owner
	    CX = number of locks held by SFT's owner
	CF set if either index out of range
	    AX = 0012h (no more files)
Notes:	error unless SHARE is loaded (calls [SysFileTable-18h]) (see AH=52h)
	names are always canonical fully-qualified, such as returned by AH=60h
---------------------------------------------
INT 21 - DOS 3.1+ internal - GET ADDRESS OF DOS SWAPPABLE DATA AREA
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
	  critical section delimited by INT 2A/AH=80h and INT 2A/AH=81h
SeeAlso: AX=5D0Bh

Format of DOS 3.10-3.30 Swappable Data Area:
Offset	Size	Description
 00h	BYTE	critical error flag
 01h	BYTE	InDOS flag (count of active INT 21 calls)
 02h	BYTE	??? drive number or FFh
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
---remainder must only be swapped if in DOS---
 18h	WORD	value of AX on call to INT 21
 1Ah	WORD	PSP segment for sharing/network
 1Ch	WORD	network machine number for sharing/network (0000h = us)
 1Eh	WORD	first usable memory block found when allocating memory
 20h	WORD	best usable memory block found when allocating memory
 22h	WORD	last usable memory block found when allocating memory
 24h  2 BYTEs	??? (don't seem to be referenced)
 26h	WORD	???
 28h	BYTE	???
 29h	BYTE	???
 2Ah	BYTE	???
 2Bh	BYTE	??? flag of some kind
 2Ch	BYTE	??? flag of some kind
 2Dh	BYTE	??? (doesn't seem to be referenced)
 2Eh	BYTE	day of month
 2Fh	BYTE	month
 30h	WORD	year - 1980
 32h	WORD	???
 32h	BYTE	???
 35h	BYTE	???
 36h	BYTE	??? flag
 37h	BYTE	??? flag
 38h 26 BYTEs	device driver request header
 52h	DWORD	pointer to device driver entry point (used in calling driver)
 56h 22 BYTEs	device driver request header
 6Ch 26 BYTEs	device driver request header
 82h	BYTE	??? flag
 83h	BYTE	??? (doesn't seem to be referenced)
 84h	WORD	???
 86h	WORD	???
 88h  2 BYTEs	???
 8Ah  6 BYTEs	CLOCK$ transfer record (see AH=52h)
 90h  2 BYTEs	???
 92h 128 BYTEs	buffer for filename
112h 128 BYTEs	buffer for filename
192h 21 BYTEs	findfirst/findnext search data block (see AH=4Eh)
1A7h 32 BYTEs	directory entry for found file
1C7h 81 BYTEs	copy of current directory structure for drive being accessed
218h 11 BYTEs	??? FCB-format filename
223h	BYTE	???
224h 11 BYTEs	wildcard destination specification for rename (FCB format)
22Fh  2 BYTEs	???
231h	WORD	???
233h  5 BYTEs	???
238h	BYTE	???
239h	BYTE	??? flag
23Ah	BYTE	???
23Bh	BYTE	???
23Ch	BYTE	??? flag bits
23Dh	BYTE	??? flag or counter
23Eh	BYTE	??? flag
23Fh	BYTE	???
240h	WORD	???
242h	BYTE	???
243h	BYTE	???
244h	BYTE	???
245h	BYTE	??? flag or counter
246h	BYTE	??? flag
247h	BYTE	??? flag
248h	BYTE	??? flag
249h	BYTE	type of process termination (00h-03h)
24Ah	BYTE	??? flag
24Bh	BYTE	???
24Ch	DWORD	pointer to Disk Parameter Block for ???
250h	DWORD	pointer to stack frame containing user registers on INT 21
254h	WORD	stores SP???
256h	DWORD	pointer to DOS disk parameter block for ???
25Ah	WORD	???
25Ch	WORD	???
25Eh	WORD	??? flag
260h	WORD	???
262h	BYTE	Media ID byte returned by AH=1Bh,1Ch
263h	BYTE	??? (doesn't seem to be referenced)
264h	DWORD	pointer to ???
268h	DWORD	pointer to current SFT
26Ch	DWORD	pointer to current directory structure for drive being accessed
270h	DWORD	pointer to ???
274h	WORD	???
276h	WORD	???
278h	DWORD	pointer to a JFT entry in process handle table (see AH=26h)
27Ch	WORD	offset in DOS CS of filename for most recently opened file
27Eh	WORD	offset in DOS CS of ??? filename
280h	WORD	???
282h	WORD	???
284h	WORD	???
286h	WORD	???
288h	WORD	???
28Ah	WORD	???
28Ch	WORD	???
28Eh  2 BYTEs	???
290h	WORD	???
292h	WORD	???
294h	WORD	???
296h	WORD	???
298h	WORD	???
29Ah	WORD	???
29Ch	WORD	???
29Eh	WORD	???
2A0h	WORD	???
2A2h	DWORD	???
2A6h	DWORD	pointer to ??? disk buffer
2AAh	DWORD	pointer to ??? SFT
2AEh	WORD	used by INT 21 dispatcher to store caller's BX
2B0h	WORD	used by INT 21 dispatcher to store caller's DS
2B2h	WORD	temporary storage while saving/restoring caller's registers
2B4h	DWORD	pointer to prev call frame (offset 250h) if INT 21 reentered
		also switched to for duration of INT 24
2B8h 21 BYTEs	FindFirst search data for source file(s) of a rename operation
		(see AH=4Eh)
2CDh 32 BYTEs	directory entry for file being renamed
2EDh 331 BYTEs	critical error stack
438h 384 BYTEs	disk stack (functions greater than 0Ch)
5B8h 384 BYTEs	character I/O stack (functions 01h through 0Ch)
---DOS 3.3 only---
738h	BYTE	flag affecting AH=08h (see AH=64h)
739h	BYTE	??? looks like a drive number
73Ah	BYTE	??? flag of some kind
73Ah	BYTE	???
---------------------------------------------
INT 21 - DOS 3.1+ network - GET REDIRECTED PRINTER MODE
	AX = 5D07h
Return: DL = mode
	    00h redirected output is combined
	    01h redirected output in separate print jobs
Note:	in DOS 3.10 and 3.30 without a network, AL=07h-09h are identical, and
	  call INT 2F/AX=1125h
SeeAlso: AX=5D08h,5D09h
---------------------------------------------
INT 21 - DOS 3.1+ network - SET REDIRECTED PRINTER MODE
	AX = 5D08h
	DL = mode
	    00h redirected output is combined
	    01h redirected output placed in separate jobs, start new print job
		now
Note:	in DOS 3.10 and 3.30 without a network, AL=07h-09h are identical, and
	  call INT 2F/AX=1125h
SeeAlso: AX=5D07h,5D09h
---------------------------------------------
INT 21 - DOS 3.1+ network - FLUSH REDIRECTED PRINTER OUTPUT
	AH = 5D09h
Note:	in DOS 3.10 and 3.30 without a network, AL=07h-09h are identical, and
	  call INT 2F/AX=1125h
SeeAlso: AX=5D07h,5D08h
---------------------------------------------
INT 21 - DOS 3.1+ internal - SET EXTENDED ERROR INFORMATION
	AX = 5D0Ah
	DS:DX -> 11-word DOS parameter list (see AX=5D00h)
Return: nothing.  next call to AH=59h will return values from fields AX,BX,CX,
	  DX,DI, and ES in corresponding registers
SeeAlso: AH=59h
---------------------------------------------
INT 21 - DOS 4.x internal - GET DOS SWAPPABLE DATA AREAS
	AX = 5D0Bh
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    DS:SI -> swappable data area list (see below)
SeeAlso: AX=5D06h

Format of swappable data area list:
Offset	Size	Description
 00h	WORD	count of data areas
 02h  N BYTEs	"count" copies of data area record
		Offset	Size	Description
		 00h	DWORD	address
		 04h	WORD	length and type
				bit 15 set if swap always, clear if swap in DOS
				bits 14-0: length in bytes
---------------------------------------------
INT 21 - DOS 3.1 + Microsoft Networks - GET MACHINE NAME
	AX = 5E00h
	DS:DX -> buffer for blank-padded ASCIZ name (16 bytes)
Return: CF set on error
	    AX = error code (01h) (see AH=59h)
	CH = 00h if name not defined
	  <> 00h defined
		CL = NETBIOS name number
		DS:DX buffer filled with ASCIZ machine name
SeeAlso: AX=5E01h
---------------------------------------------
INT 21 - DOS 3.1 + Microsoft Networks - SET MACHINE NAME
	AX = 5E01h
	CH = 00h undefine name
	   <> 0  define name
	CL = name number
	DS:DX -> 15-character blank-padded ASCIZ name
SeeAlso: AX=5E00h
---------------------------------------------
INT 21 - DOS 3.1 + Microsoft Networks - SET PRINTER SETUP
	AX = 5E02h
	BX = redirection list index
	CX = length of setup string (<= 64)
	DS:SI -> string buffer
Return: CF set on error
	    AX = error code (01h) (see AH=59h)
SeeAlso: AX=5E03h
---------------------------------------------
INT 21 - DOS 3.1 + Microsoft Networks - GET PRINTER SETUP
	AX = 5E03h
	BX = redirection list index
	ES:DI -> string buffer
Return: CF set on error
	    AX = error code (01h) (see AH=59h)
	CX = length of setup string (<= 64)
SeeAlso: AX=5E02h
---------------------------------------------
INT 21 - DOS 3.1 + Microsoft Networks - SET PRINTER MODE
	AX = 5E04h
	BX = redirection list index
	DX = mode
	    bit 0: set if binary, clear if text (tabs expanded to blanks)
Return: CF set on error
	    AX = error code (see AH=59h)
Note:	calls INT 2F/AX=111Fh with 5E04h on stack
SeeAlso: AX=5E05h
---------------------------------------------
INT 21 - DOS 3.1 + Microsoft Networks - GET PRINTER MODE
	AX = 5E05h
	BX = redirection list index
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    DX = printer mode (see AX=5E04h)
Note:	calls INT 2F/AX=111Fh with 5E05h on stack
SeeAlso: AX=5E04h
---------------------------------------------
INT 21 - DOS 3.1 + Microsoft Networks - something to do with PRINTER SETUP???
	AX = 5E06h
	???
Return: CF set on error
Note:	calls INT 2F/AX=111Fh with 5E06h on stack
---------------------------------------------
INT 21 - DOS 3.1 + network - GET REDIRECTION MODE
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
---------------------------------------------
INT 21 - DOS 3.1 + network - SET REDIRECTION MODE
	AX = 5F01h
	BL = redirection type
	    03h printer
	    04h disk drive
	BH = redirection state
	    00h off
	    01h on
Return: CF set on error
	    AX = error code (see AH=59h)
Note:	when redirection is off, the local device (if any) rather than the
	  remote device is used
SeeAlso: AX=5F00h
---------------------------------------------
INT 21 - DOS 3.1 + Microsoft Networks, VINES - GET REDIRECTION LIST ENTRY
	AX = 5F02h
	BX = redirection list index
	DS:SI -> 16 char local device name buffer
	ES:DI -> 128 char network name buffer
Return: CF set on error
	    AX = error code (01h,12h) (see AH=59h)
	CF clear if successful
	    BH = device status flag (bit 0 = 0 if valid)
	    BL = device type (03h if printer, 04h if drive)
	    CX = stored parameter value (user data)
	    DS:SI and ES:DI buffers filled
Notes:	DX and BP are destroyed by this call!
	error code 12h is returned if BX is greater than the size of the list
SeeAlso: AX=5F03h
---------------------------------------------
INT 21 - DOS 3.1 + Microsoft Networks, Banyan VINES - REDIRECT DEVICE
	AX = 5F03h
	BL = device type
		03h = printer device
		04h = file device
	CX = stored parameter value
	DS:SI -> ASCIZ source device name
	ES:DI -> destination ASCIZ network path + ASCIZ password
Return: CF set on error
	    AX = error code (01h,03h,05h,08h,54h,55h,57h) (see AH=59h)
SeeAlso: AX=5F02h,5F04h
---------------------------------------------
INT 21 - DOS 3.1 + Microsoft Networks, Banyan VINES - CANCEL REDIRECTION
	AX = 5F04h
	DS:SI -> ASCIZ device name or network path
Return: CF set on error
	    AX = error code (01h,0Fh,57h) (see AH=59h)
---------------------------------------------
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
---------------------------------------------
INT 21 - LANtastic - GET LOGIN ENTRY
	AX = 5F80h
	BX = login entry index
	ES:DI -> 16-byte buffer for machine name
Return: CF clear if successful
	    buffer filled with machine name ("\\" prefix removed)
	CF set on error
	    AX = error code
---------------------------------------------
INT 21 - LANtastic - LOGIN TO SERVER
	AX = 5F81h
	ES:DI -> ASCIZ login path followed immediately by ASCIZ password
	BL = adapater number
	    FFh try all valid adapters
	    00h-03h try only specified adapter
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	login path is of form "\\machine\username"
SeeAlso: AX=5F82h
---------------------------------------------
INT 21 - LANtastic - LOGOUT FROM SERVER
	AX = 5F82h
	ES:DI -> ASCIZ server name (in form "\\machine")
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F81h
---------------------------------------------
INT 21 - LANtastic - GET USERNAME ENTRY
	AX = 5F83h
	BX = login entry index
	ES:DI -> 16-byte buffer for username currently logged into
Return: CF clear if successful
	CF set on error
	    AX = error code
---------------------------------------------
INT 21 - LANtastic - GET INACTIVE SERVER ENTRY
	AX = 5F84h
	BX = server index not currently logged into
	ES:DI -> 16-byte buffer for server name which is available for logging
		in to ("\\" prefix omitted)
Return: CF clear if successful
	    DL = adapter number to non-logged in server is on
	CF set on error
	    AX = error code
---------------------------------------------
INT 21 - LANtastic - CHANGE PASSWORD
	AX = 5F85h
	ES:DI -> buffer containing "\\machine\oldpassword" 00h "newpassword"00h
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	must be logged into the named machine
---------------------------------------------
INT 21 - LANtastic - DISABLE ACCOUNT
	AX = 5F86h
	ES:DI -> ASCIZ machine name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	must be logged into the named machine and concurrent logins set to 1
	  by NET_MGR.  Requires system manager to re-enable account.
---------------------------------------------
INT 21 - LANtastic - COPY FILE
	AX = 5F97h
	CX:DX = number of bytes to copy
	SI = source file handle
	DI = destination file handle
Return: CF clear if successful
	    AX:DX = number of bytes copied
	CF set on error
	    AX = error code
---------------------------------------------
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
---------------------------------------------
INT 21 - LANtastic - GET LAST RECEIVED UNSOLICITED MESSAGE
	AX = 5F99h
	ES:DI -> messsage buffer (see AX=5F98h for format)
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F98h
---------------------------------------------
INT 21 - LANtastic - GET MESSAGE PROCESSING FLAG
	AX = 5F9Ah
Return: CF clear if successful
	    DL = bits describing processing for received unsolicited messages
		bit 0: beep before message is delivered
		    1: deliver message to message service
	CF set on error
	    AX = error code
SeeAlso: AX=5F9Bh
---------------------------------------------
INT 21 - LANtastic - SET MESSAGE PROCESSING FLAG
	AX = 5F9Bh
	DL = bits describing processing for received unsolicited messages
	     (see AX=5F9Ah)
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5F9Ah
---------------------------------------------
INT 21 - LANtastic - GET QUEUE ENTRY
	AX = 5FA0h
	BX = queue entry index (0000h is first entry)
	DS:SI -> buffer for queue entry (see below)
	ES:DI -> ASCIZ server name in form "\\name"
Return: CF clear if successful
	CF set on error
	    AX = error code
	BX = entry index for next queue entry
SeeAlso: AX=5FA1h,5FA2h

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
 06h	BYTE	control of despooled file
		bit 6: don't delete (for mail)
 07h	WORD	number of copies
 09h	DWORD	sequence number of queue entry
 0Dh 48 BYTEs	pathname of spooled file
 3Dh 16 BYTEs	user who spooled file
 4Dh 16 BYTEs	name of machine from which file was spooled
 5Dh	WORD	date file was spooled (see AX=5700h)
 5Fh	WORD	time file was spooled (see AX=5700h)
 61h 17 BYTEs	ASCIZ destination device or user name
 72h 48 BYTEs	comment field
---------------------------------------------
INT 21 - LANtastic - SET QUEUE ENTRY
	AX = 5FA1h
	BX = handle of opened queue entry
	DS:SI -> queue entry (see AX=5FA0h)
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5FA0h,5FA2h
---------------------------------------------
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
	CX:DX = sequence number to control
	ES:DI -> ASCIZ computer name
Return: CF clear if successful
	CF set on error
	    AX = error code
---------------------------------------------
INT 21 - LANtastic - CREATE USER AUDIT ENTRY
	AX = 5FA7h
	DS:DX -> ASCIZ reason code (max 8 bytes)
	DS:SI -> ASCIZ variable reason code (max 128 bytes)
	ES:DI -> ASCIZ machine name in form "\\machine"
Return: CF clear if successful
	CF set on error
	    AX = error code
---------------------------------------------
INT 21 - LANtastic - GET ACTIVE USER INFORMATION
	AX = 5FB0h
	BX = server login entry index
	DS:SI -> buffer for active user entry (see below)
	ES:DI -> ASCIZ machine name in form "\\server"
Return: CF clear if successful
	CF set on error
	    AX = error code

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
---------------------------------------------
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
---------------------------------------------
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
---------------------------------------------
INT 21 - LANtastic - GET REDIRECTED PRINTER TIMEOUT
	AX = 5FD0h
Return: CF clear if successful
	    CX = redirected printer timeout in clock ticks of 55ms
		0000h if timeout disabled
	CF set on error
	    AX = error code
SeeAlso: AX=5FD1h
---------------------------------------------
INT 21 - LANtastic - SET REDIRECTED PRINTER TIMEOUT
	AX = 5FD1h
	CX = printer timeout in clock ticks of 55ms, 0000h to disable timeouts
Return: CF clear if successful
	CF set on error
	    AX = error code
SeeAlso: AX=5FD0h
---------------------------------------------
INT 21 - LANtastic - GET DOS SERVICE VECTOR
	AX = 5FE0h
Return: CF clear if successful
	    ES:BX -> current FAR service routine
	CF set on error
	    AX = error code
SeeAlso: AX=5FE1h
---------------------------------------------
INT 21 - LANtastic - SET DOS SERVICE VECTOR
	AX = 5FE1h
	ES:BX -> FAR routine to call for DOS service
Return: CF clear if successful
	CF set on error
	    AX = error code
Note:	new handler must chain to previous handler as its first action
SeeAlso: AX=5FE0h
---------------------------------------------
INT 21 - LANtastic - GET MESSAGE SERVICE VECTOR
	AX = 5FE2h
Return: CF clear if successful
	    ES:BX -> current FAR message service routine
	CF set on error
	    AX = error code
SeeAlso: AX=5FE3h
---------------------------------------------
INT 21 - LANtastic - SET MESSAGE SERVICE VECTOR
	AX = 5FE3h
	ES:BX -> FAR routine for processing network messages
Return: CF clear if successful
	CF set on error
	    AX = error code
Notes:	handler must chain to previous handler as its first action
	on invocation, ES:BX -> Network Control Block
SeeAlso: AX=5FE2h
---------------------------------------------
INT 21 - DOS 3+ internal - RESOLVE PATH STRING TO CANONICAL PATH STRING
	AH = 60h
	DS:SI -> ASCIZ relative path string or directory name
	ES:DI -> 128-byte buffer for ASCIZ canonical fully qualified name
Return: CF set on error
	    AX = error code 
		02h invalid source name
		03h invalid drive or malformed path
		others???
	CF clear if successful
	    AH = 00h
	    AL = '\' if relative path refers to something in root directory
	       = uppercased last letter of relative path if relative path
		    refers to current directory or subdir of current directory
	       = 00h otherwise
	    buffer filled with qualified name of form D:\PATH\FILE.EXT
Notes:	the input path need not actually exist
	letters are uppercased, forward slashes converted to backslashes,
	   asterisks converted to appropriate number of question marks, and
	   file and directory names are truncated to 8.3 if necessary.
	'.' and '..' in the path are resolved
	if path string is on a JOINed drive, the returned name is the one that
	   would be needed if the drive were not JOINed; similarly for a
	   SUBSTed, ASSIGNed, or network drive letter.	Because of this, it is
	   possible to get a qualified name that is not legal with the current
	   combination of SUBSTs, ASSIGNs, and JOINs
SeeAlso: INT 2F/AX=1221h
---------------------------------------------
INT 21 - DOS 3+ internal - UNUSED
	AH = 61h
Return: AL = 00h
---------------------------------------------
INT 21 - DOS 3+ - GET PSP ADDRESS
	AH = 62h
Return: BX = segment address of PSP
Note:	under DOS 3+, this function does not use any of the DOS-internal stacks
	  and is thus fully reentrant
SeeAlso: AH=51h
---------------------------------------------
INT 21 - DOS 2.25 only - GET LEAD BYTE TABLE (2-BYTE CHARACTER SUPPORT)
	AH = 63h
	AL = subfunction
	     00h get system lead byte table
		Return:	DS:SI -> lead byte table
	     01h set/clear interim console flag (determine whether interim
			bytes are returned on some console functions)
		DL = 01h/00h to set/clear interim console flag
	     02h get interim console flag
		Return:	DL = interim console flag
Return: CF set on error
	    AX = error code (01h) (see AH=59h)
Note:	does not preserve any registers other than SS:SP
---------------------------------------------
INT 21 - Asian DOS 3.2+ only - GET DOUBLE BYTE CHARACTER SET LEAD TABLE
	AX = 6300h
Return: AL = error code
	    00h successful
		DS:SI -> DBCS table (see below)
		BX, CX, DX, BP, DI, and ES destroyed
	    FFh not supported
Note:	probably identical to AX=6300h for DOS 2.25

Format of DBCS table:
Offset	Size	Description
 00h  2 BYTEs	low/high ends of a range of leading byte of double-byte chars
 02h  2 BYTEs	low/high ends of a range of leading byte of double-byte chars
	...
  N   2 BYTEs	00h,00h end flag
---------------------------------------------
INT 21 - Asian DOS 3+ only - SET KOREAN (HONGEUL) INPUT MODE
	AX = 6301h
	DL = new mode
	    00h return only full characters on DOS keyboard input functions
	    01h	return partially-formed characters also
Return: AL = status
	    00h successful
	    FFh invalid mode
SeeAlso: AX=6302h
---------------------------------------------
INT 21 - Asian DOS 3+ only - GET KOREAN (HONGEUL) INPUT MODE
	AX = 6302h
Return: AL = status
	    00h successful
		DL = current input mode
		    00h return only full characters
		    01h return partial characters
	    FFh not supported
SeeAlso: AX=6301h
---------------------------------------------
INT 21 - DOS 3.2 internal - ???
	AH = 64h
	AL = subfunction
	    00h get ???
		Return: DL = ???
	    01h set ???
		DL = ???
	    02h get and set ???
		DL = new ???
		Return: DL = old ???
---------------------------------------------
INT 21 - DOS 3.3 internal - ???
	AH = 64h
	AL = flag
		00h  ??? 
	    nonzero  ??? 
Return: nothing
Note:	affects operation of AH=08h
---------------------------------------------
INT 21 - DOS 3.3+ - GET EXTENDED COUNTRY INFORMATION
	AH = 65h
	AL = info ID
	    01h get general internationalization info
	    02h get pointer to uppercase table
	    04h get pointer to filename uppercase table
	    05h (DOS 3.3+ internal) get pointer to filename terminator table
	    06h get pointer to collating sequence table
	    07h (DOS 4.x) get pointer to Double-Byte Character Set table
	BX = code page (-1=global code page)
	DX = country ID (-1=current country)
	ES:DI -> country information buffer (see below)
	CX = size of buffer (>= 5)
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if succesful
	    CX = size of country information returned
	    ES:DI -> country information
Notes:	AL=05h appears to return same info for all countries and codepages
	NLSFUNC must be installed to get info for countries other than the
	  default
SeeAlso: AH=38h

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
 01h	DWORD	pointer to collating table (see below)
---if info ID = 05h---
 01h	DWORD	pointer to filename character table (see below)
---if info ID = 06h---
 01h	DWORD	pointer to filename uppercase table (see below)
---if info ID = 07h (DOS 4.x)---
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
 00h	WORD	table size
 02h  7 BYTEs	???  (01h 00h FFh 00h 00h 20h 02h in MSDOS 3.30)
 09h	BYTE	length of following data
 0Ah  N BYTES	characters which terminate a filename:	."/\[]:|<>+=;,

Format of filename uppercase table:
Offset	Size	Description
 00h	WORD	table size
 02h 128 BYTEs	uppercase equivalents (if any) of chars 80h to FFh

Format of DBCS lead byte table:
Offset	Size	Description
 00h	WORD	length
 02h 2N BYTEs	start/end for N lead byte ranges
	WORD	0000h	(end of table)
---------------------------------------------
INT 21 - DOS 4.x internal - COUNTRY-DEPENDENT CHARACTER CAPITALIZATION
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
---------------------------------------------
INT 21 - DOS 4.x internal - DETERMINE IF CHARACTER REPRESENTS YES/NO RESPONSE
	AX = 6523h
	DL = character
	DH = second character of double-byte character (if applicable)
Reutrn: CF set if neither yes nor no
	CF clear
	    AX = type
		00h no
		01h yes
---------------------------------------------
INT 21 - DOS 4.x internal - COUNTRY-DEPENDENT FILENAME CAPITALIZATION
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
---------------------------------------------
INT 21 - DOS 3.3+ - GET GLOBAL CODE PAGE TABLE
	AX = 6601h
Return: CF set on error
	    AX = error code (see AH=59h)
	CF clear if successful
	    BX = active code page
	    DX = system code page
SeeAlso: AX=6602h
---------------------------------------------
INT 21 - DOS 3.3+ - SET GLOBAL CODE PAGE TABLE
	AX = 6602h
	BX = active code page
	    437  US
	    850  Multilingual
	    860  Portugal
	    863  Canada (French)
	    865  Norway/Denmark
	DX = system code page (active page at boot time)
Return: CF set on error
	    AX = error code (see AH=59h)
SeeAlso: AX=6603h
---------------------------------------------
INT 21 - DOS 3.3+ - SET HANDLE COUNT
	AH = 67h
	BX = desired number of handles (max 255)
Return: CF set if error (and error code in AX)
Notes:	if BX <= 20, no action is taken
	a bug in DOS 3.3 results in requests for an even number of handles
	  allocating a full 64K for the handle table
SeeAlso: AH=26h
---------------------------------------------
INT 21 - DOS 3.3+ - COMMIT FILE, WRITE ALL BUFFERED DATA TO DISK
	AH = 68h
	BX = file handle
Return: CF set on error 
	    AX = error code (see AH=59h)
Note:	if BX <= 20, no action is taken
SeeAlso: AX=5D01h
---------------------------------------------
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

Format of disk info:
Offset	Size	Description
 00h	WORD	info level (zero)
 02h	DWORD	disk serial number (binary)
 06h 11 BYTEs	volume label or "NO NAME    " if none present
 11h  8 BYTEs	(AL=00h only) filesystem type--string "FAT12   " or "FAT16   "
---------------------------------------------
INT 21 - DOS 4.0 internal - ???
	AH = 6Ah
	???
Return: ???
---------------------------------------------
INT 21 - DOS 4.0 internal - ???
	AH = 6Bh
	???
Return: ???
---------------------------------------------
INT 21 - DOS 4.0 - EXTENDED OPEN/CREATE
	AX = 6C00h
	BL = open mode as in AL for normal open (INT 21h/AH=3Dh)
	    bit 7: inheritance
	    bits 4-6: sharing mode
	    bit 3 reserved
	    bits 0-2: access mode
	BH = flags
	    bit 6 = auto commit on write
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
SeeAlso: AH=3Ch,3Dh
---------------------------------------------
INT 21 - ???
	AH = 89h
	???
Note:	reportedly called by Microsoft C 4.0 startup code
---------------------------------------------
INT 21 - Novell NetWare SFT Level II - EXTENDED FILE ATTRIBUTES
	AH = B6h
	AL = subfunction
	    00h get extended file attributes
	    01h set extended file attributes
	CL = attributes
	    bit 4: transaction tracking file
		5: indexing file (to be implemented)
		6: read audit (to be implemented)
		7: write audit (to be implemented)
	DS:DX -> ASCIZ pathname
Return: CF set on error
	    AL = error code
		FFh file not found
		8Ch caller lacks privileges
	CL = current extended file attributes
---------------------------------------------
INT 21 - Novell Advanced NetWare 2.0+ - PRINT JOBS
	AH = B8h
	AL = subfunction
	    00h get default print job flags
	    01h set default capture flags
	    02h get specific capture flags
	    03h set specific print job flags
	    04h get default local printer
	    05h set default local printer
	    06h set capture print queue
	    07h set capture print job
	    08h get banner user name
	    09h set banner user name
	CX = buffer size
	ES:BX -> buffer
Return: none
---------------------------------------------
INT 21 - Novell NetWare 4.0 - SET END OF JOB STATUS
	AH = BBh
	AL = new EOJ flag
	    00h disable EOJs
	    otherwise enable EOJs
Return: AL = old EOJ flag
---------------------------------------------
INT 21 - Novell NetWare 4.6 - LOG PHYSICAL RECORD
	AH = BCh
	AL = flags
	    bit 0: lock as well as log record
		1: non-exclusive lock
	BX = file handle
	CX:DX = offset
	BP = timeout in timer ticks (1/18 sec)
	SI:DI = length
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.6 - RELEASE PHYSICAL RECORD
	AH = BDh
	BX = file handle
	CX:DX = offset
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.6 - CLEAR PHYSICAL RECORD
	AH = BEh
	BX = file handle
	CX:DX = offset
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.6 - LOG RECORD (FCB)
	AH = BFh
	AL = flags
	    bit 0: lock as well as log record
		1: non-exclusive lock
	DS:DX -> FCB
	BX:CX = offset
	BP = timeout in timer ticks (1/18 sec)
	SI:DI = length
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.6 - RELEASE RECORD (FCB)
	AH = C0h
	DS:DX -> FCB
	BX:CX = offset
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.6 - CLEAR RECORD (FCB)
	AH = C1h
	DS:DX -> FCB
	BX:CX = offset
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.6 - LOCK PHYSICAL RECORD SET
	AH = C2h
	AL = flags
	    bit 1: non-exclusive lock
	BP = timeout in timer ticks (1/18 sec)
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.6 - RELEASE PHYSICAL RECORD SET
	AH = C3h
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.6 - CLEAR PHYSICAL RECORD SET
	AH = C4h
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.6 - SEMAPHORES
	AH = C5h
	AL = subfunction
	    00h open semaphore
		DS:DX -> semaphore name
		CL = initial value
	    01h examine semaphore
		Return: CX = semaphore value (sign extended)
			DL = open count
	    02h wait on semaphore
		BP = timeout in timer ticks (1/18 sec)
	    03h signal semaphore
	    04h close semaphore
	CX:DX = semaphore handle (except function 00h)
Return: AL = error code
	if function 00h
	   CX:DX = semaphore handle
	   BL = open count
---------------------------------------------
INT 21 - Novell NetWare 4.6 - GET OR SET LOCK MODE
	AH = C6h
	AL = subfunction
	    00h set old "compatibility" mode
	    01h set new extended locks mode 
	    02h get lock mode
Return: AL = current lock mode
---------------------------------------------
INT 21 - Novell NetWare 4.0 - TTS
	AH = C7h
	AL = subfunction
	    00h begin transaction (NetWare SFT level II)
		Return: AL = error code
	    01h end transaction (NetWare SFT level II)
		Return: AL = error code
			CX:DX = transaction reference number
	    02h TTS available (NetWare SFT level II)
		Return: AL = completion code
			    00h TTS not available
			    01h TTS available
			    FDh TTS available but disabled
	    03h abort transaction (NetWare SFT level II)
		Return: AL = error code
	    04h transaction status
	    05h get application thresholds
	    06h set application thresholds
	    07h get workstation thresholds
	    08h set workstation thresholds
Return: ???
---------------------------------------------
INT 21 - Novell NetWare 4.0 - BEGIN LOGICAL FILE LOCKING
	AH = C8h
	if function C6h lock mode 00h:
	    DL = mode
		00h no wait
		01h wait
	if function C6h lock mode 01h:
	    BP = timeout in timer ticks (1/18 sec)
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.0 - END LOGICAL FILE LOCKING
	AH = C9h
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.0 - LOG PERSONAL FILE (FCB)
	AH = CAh
	DS:DX -> FCB
	if function C6h lock mode 01h:
	    AL = log and lock flag
		00h log file only
		01h lock as well as log file
	    BP = timeout in timer ticks (1/18 sec)
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.0 - LOCK FILE SET
	AH = CBh
	if function C6h lock mode 00h:
	    DL = mode
		00h no wait
		01h wait
	if function C6h lock mode 01h:
	    BP = timeout in timer ticks (1/18 sec)
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.0 - RELEASE FILE (FCB)
	AH = CCh
	DS:DX -> FCB
Return: none
---------------------------------------------
INT 21 - Novell NetWare 4.0 - RELEASE FILE SET
	AH = CDh
Return: none
---------------------------------------------
INT 21 - Novell NetWare 4.0 - CLEAR FILE (FCB)
	AH = CEh
	DS:DX -> FCB
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.0 - CLEAR FILE SET
	AH = CFh
Return: AL = 00h
---------------------------------------------
INT 21 - Novell NetWare 4.6, Banyan VINES - LOG LOGICAL RECORD
	AH = D0h
	DS:DX -> record string
	if function C6h lock mode 01h: (Novell only)
	    AL = flags
		bit 0: lock as well as log the record
		bit 1: non-exclusive lock
	    BP = timeout in timer ticks (1/18 sec)
Return: AL = error code
	    00h successful
	    FFh unsuccessful
---------------------------------------------
INT 21 - Novell NetWare 4.6, Banyan VINES - LOCK LOGICAL RECORD SET
	AH = D1h
	if function C6h lock mode 00h:
	    DL = mode
		00h no wait
		01h wait
	if function C6h lock mode 01h: (Novell only)
	   BP = timeout in timer ticks (1/18 sec)
Return: AL = error code (see AH=D0h)
---------------------------------------------
INT 21 - Novell NetWare 4.0, Banyan VINES - UNLOCK LOGICAL RECORD
	AH = D2h
	DS:DX -> semaphore identifier (counted string up to 100 chars long)
Return: AL = error code (see AH=D0h)
---------------------------------------------
INT 21 - Novell NetWare 4.0, Banyan VINES - UNLOCK LOGICAL RECORD SET
	AH = D3h
Return: AL = error code (see AH=D0h)
Note:	unlocks all semaphores logged in the semaphore set of the requesting PC
---------------------------------------------
INT 21 - Novell NetWare 4.0, Banyan VINES - CLEAR LOGICAL RECORD
	AH = D4h
	DS:DX -> semaphore identifier (counted string up to 100 chars long)
Return: AL = error code
	    00h successful
	    FFh not successful
---------------------------------------------
INT 21 - Novell NetWare 4.0, Banyan VINES - CLEAR LOGICAL RECORD SET
	AH = D5h
Return: AL = error code (see AH=D4h)
Note:	unlocks and clears all semaphores associated with the semaphore set
	  of teh requesting PC
---------------------------------------------
INT 21 - Novell NetWare 4.0 - END OF JOB
	AH = D6h
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.0 - SYSTEM LOGOUT
	AH = D7h
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare, Banyan VINES - ALLOCATE RESOURCE
	AH = D8h
	DL = resource number
Return: AL = status
	    00h successful
	    FFh unsucessful
---------------------------------------------
INT 21 - Novell NetWare, Banyan VINES - DEALLOCATE RESOURCE
	AH = D9h
	DL = resource number
Return:	AL = status (see AH=D8h)
---------------------------------------------
INT 21 - Novell NetWare 4.0 - GET VOLUME STATISTICS
	AH = DAh
	DL = volume number
	ES:DI -> reply buffer (see below)
Return: AL = 00h

Format of reply buffer:
Offset	Size	Description
 00h	WORD	sectors/block
 02h	WORD	total blocks
 04h	WORD	unused blocks
 06h	WORD	total directory entries
 08h	WORD	unused directory entries
 0Ah 16 BYTEs	volume name, null padded
 1Ah	WORD	removable flag, 0000h = not removable
---------------------------------------------
INT 21 - Novell NetWare 4.0 - GET NUMBER OF LOCAL DRIVES
	AH = DBh
Return: AL = number of local disks
---------------------------------------------
INT 21 - Novell NetWare 4.0, Banyan VINES - GET STATION NUMBER
	AH = DCh
Return: AL = station number
	    00h if NetWare not loaded or this machine is a non-dedicated server
	CX = station number in ASCII
Note:	station number only unique for those PCs connected to same semaphore
	  service
---------------------------------------------
INT 21 - PCMag PCMANAGE/DCOMPRES - TURN ON/OFF
	AH = DCh
	DX = state
	    0000h turn on
	    0001h turn off
---------------------------------------------
INT 21 - Novell NetWare 4.0 - SET ERROR MODE
	AH = DDh
	DL = error mode
	    00h display critical I/O errors
	    01h extended errors for all I/O in AL
	    02h extended errors for critical I/O in AL
Return: AL = previous error mode
---------------------------------------------
INT 21 - Novell NetWare 4.0 - SET BROADCAST MODE
	AH = DEh
	AL = broadcast mode
	    00h receive console and workstation broadcasts
	    01h receive console broadcasts only
	    02h receive no broadcasts
	    03h store all broadcasts for retrieval
	    04h get broadcast mode
	    05h disable shell tiemr interrupt checks
	    06h enable shell timer interrupt checks
Return: AL = old broadcast mode
---------------------------------------------
INT 21 - Novell NetWare 4.0 - CAPTURE
	AH = DFh
	AL = subfunction
	    00h start LPT capture
	    01h end LPT capture
	    02h cancel LPT capture
	    03h flush LPT capture
	    04h start specific capture
	    05h end specific capture
	    06h cancel specific capture
	    07h flush specific capture
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.0 - PRINT SPOOLING
	AH = E0h
	DS:SI -> request buffer
	ES:DI -> reply buffer
	subfunction in third byte of request buffer
	    00h spool data to a capture file
	    01h close and queue capture file
	    02h set spool flags
	    03h spool existing file
	    04h get spool queue entry
	    05h remove entry from spool queue
	    06h get printer status
	    09h create a disk capture file
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.0 - BROADCAST MESSAGES
	AH = E1h
	DS:SI -> request buffer
	ES:DI -> reply buffer
	subfunction in third byte of request buffer
	    00h send broadcast message
	    01h get broadcase message
	    02h disable station broadcasts
	    03h enable station broadcasts
	    04h send personal message
	    05h get personal message
	    06h open message pipe
	    07h close message pipe
	    08h check pipe status
	    09h broadcast to console
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.0 - DIRECTORY FUNCTIONS
	AH = E2h
	DS:SI -> request buffer
	ES:DI -> reply buffer
	subfunction in third byte of request buffer
	    00h set directory handle
	    01h get directory path
	    02h scan directory information
	    03h get effective directory rights
	    04h modify maximum rights mask
	    05h get volume number
	    06h get volume name
	    0Ah create directory
	    0Bh delete directory
	    0Ch scan directory for trustees
	    0Dh add trustee to directory
	    0Eh delete trustee from directory
	    0Fh rename directory
	    10h purge erased files
	    11h restore erased file
	    12h allocate permanent directory handle
	    13h allocate temporary directory handle
	    14h deallocate directory handle
	    15h get volume info with handle
	    16h allocate special temporary directory handle
	    17h retrieve a short base handle (Advanced NetWare 2.0)
	    18h restore a short base handle (Advanced NetWare 2.0)
	    19h set directory information
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.0 - CONNECTION CONTROL
	AH = E3h
	DS:SI -> requst buffer
	ES:DI -> reply buffer
	subfunction in third byte of request buffer
	    00h login
	    01h change password
	    02h map user to station set
	    03h map object to number
	    04h map number to object
	    05h get station's logged information
	    06h get station's root mask (obsolete)
	    07h map group name to number
	    08h map number to group name
	    09h get memberset M of group G
	    0Ah enter login area
	    0Bh ???
	    0Ch ???
	    0Dh log network message
	    0Eh get disk utilization (Advanced NetWare 1.0)
	    0Fh scan file information (Advanced NetWare 1.0)
	    10h set file information (Advanced NetWare 1.0)
	    11h get file server information (Advanced NetWare 1.0)
	    12h ???
	    13h get internet address (Advanced NetWare 1.02)
	    14h login to file server (Advanced NetWare 2.0)
	    15h get object connection numbers (Advanced NetWare 2.0)
	    16h get connection information (Advanced NetWare 1.0)
	    32h create object (Advanced NetWare 1.0)
	    33h delete object (Advanced NetWare 1.0)
	    34h rename object (Advanced NetWare 1.0)
	    35h get object ID (Advanced NetWare 1.0)
	    36h get object name (Advanced NetWare 1.0)
	    37h scan object (Advanced NetWare 1.0)
	    38h change object security (Advanced NetWare 1.0)
	    39h create propery (Advanced NetWare 1.0)
	    3Ah delete property (Advanced NetWare 1.0)
	    3Bh change property security (Advanced NetWare 1.0)
	    3Ch scan property (Advanced NetWare 1.0)
	    3Dh read property value (Advanced NetWare 1.0)
	    3Eh write property value (Advanced NetWare 1.0)
	    3Fh verify object password (Advanced NetWare 1.0)
	    40h change object password (Advanced NetWare 1.0)
	    41h add object to set (Advanced NetWare 1.0)
	    42h delete object from set (Advanced NetWare 1.0)
	    43h is object in set? (Advanced NetWare 1.0)
	    44h close bindery (Advanced NetWare 1.0)
	    45h open bindery (Advanced NetWare 1.0)
	    46h get bindery access level (Advanced NetWare 1.0)
	    47h scan object trustee paths (Advanced NetWare 1.0)
	    C8h check console priviledges
	    C9h get file server description strings
	    CAh set file server date and time
	    CBh disable file server login
	    CCh enable file server login
	    CDh get file server login status
	    CEh purge all erased files
	    CFh disable transaction tracking
	    D0h enable transaction tracking
	    D1h send console broadcast
	    D2h clear connection number
	    D3h down file server
	    D4h get file system statistics
	    D5h get transaction tracking statistics
	    D6h read disk cache statistics
	    D7h get drive mapping table
	    D8h read physical disk statistics
	    D9h get disk channel statistics
	    DAh get connection's task information
	    DBh get list of connection's open files
	    DCh get list of connections using a file
	    DDh get physical record locks by connection and file
	    DEh get physical record locks by file
	    DFh get logical records by connection
	    E0h get logical record information
	    E1h get connection's semaphores
	    E2h get semaphore information
	    E3h get LAN driver's configuration information
	    E5h get connection's usage statistics
	    E6h get object's remaining disk space
	    E7h get server LAN I/O statistics
	    E8h get server miscellaneous information
	    E9h get volume information
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.0 - SET FILE ATTRIBUTES (FCB)
	AH = E4h
	CL = file attributes
	    bit 0: read only
		1: hidden
		2: system
		7: shareable
	DX:DX -> FCB
Return: AL = error code
---------------------------------------------
INT 21 - DoubleDos - INSTALLATION CHECK
	AX = E400h
Return: AL <> 00h if DoubleDos is active
	AL = 02h if caller is running in the invisible partition
---------------------------------------------
INT 21 - Novell NetWare 4.0 - UPDATE FILE SIZE (FCB)
	AH = E5h
	DS:DX -> FCB
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.0 - COPY FILE TO FILE (FCB)
	AH = E6h
	CX:DX = number of bytes to copy
	DS:SI -> source FCB
	ES:DI -> destination FCB
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.0, Banyan VINES - GET FILE SERVER DATE AND TIME
	AH = E7h
	DS:DX -> reply buffer
		BYTE  year - 1900
		BYTE  month
		BYTE  day
		BYTE  hours
		BYTE  minutes
		BYTE  seconds
		BYTE  day of week (0 = Sunday) (Novell only)
Return: AL = error code
	    00h successful
	    FFh unsuccessful
---------------------------------------------
INT 21 - Novell NetWare 4.6 - SET FCB RE-OPEN MODE
	AH = E8h
	DL = mode
	    00h no automatic re-open
	    01h auto re-open
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.6 - SHELL'S "GET BASE STATUS"
	AH = E9h
	AL = subfunction
	    00h get directory handle
	DX = drive number to check (0 = A:)
Return: AL = network pathbase
	AH = base flags
	    00h drive not currently mapped to a base
	    01h drive is mapped to a permanent base
	    02h drive is mapped to a temporary base
	    03h drive exists locally
---------------------------------------------
INT 21 - Novell NetWare 4.6 - RETURN SHELL VERSION
	AH = EAh
	AL = subfunction
	    00h return code in AL
		Return: AL = hardware type
			    00h IBM PC
			    01h Victor 9000
	    01h get workstation environment string
		ES:DI -> 40-byte buffer
		Return: buffer filled with three null-terminated entries:
			major operating system
			version
			hardware type
Return: AH = 00h if DOS
---------------------------------------------
INT 21 - DoubleDos - TURN OFF TASK SWITCHING
	AH = EAh
Return: task switching turned off
---------------------------------------------
INT 21 - Novell NetWare 4.6 - LOG FILE
	AH = EBh
	DS:DX -> ASCIZ filename
	if function C6h lock mode 01h:
	    AL = flags
		00h log file only
		01h lock as well as log file
	    BP = timeout in timer ticks (1/18 second)
Return: AL = error code
---------------------------------------------
INT 21 - DoubleDos - TURN ON TASK SWITCHING
	AH = EBh
Return: task switching turned on
---------------------------------------------
INT 21 - Novell NetWare 4.6 - RELEASE FILE
	AH = ECh
	DS:DX -> ASCIZ filename
Return: none
---------------------------------------------
INT 21 - DoubleDos - GET VIRTUAL SCREEN ADDRESS
	AH = ECh
Return: ES = segment of virtual screen
Note:	screen address can change if task-switching is on!!
---------------------------------------------
INT 21 - Novell NetWare - CLEAR FILE
	AH = EDh
	DS:DX -> ASCIZ filename
Return: AL = error code
---------------------------------------------
INT 21 - Novell NetWare 4.6 - GET PHYSICAL STATION NUMBER
	AH = EEh
Return: CX:BX:AX = six-byte address
---------------------------------------------
INT 21 - DoubleDos - GIVE AWAY TIME TO OTHER TASKS
	AH = EEh
	AL = number of 55ms time slices to give away
Return: returns after giving away time slices
---------------------------------------------
INT 21 - Novell Advanced NetWare 1.0+ - GET DRIVE INFO
	AH = EFh
	AL = subfunction
	    00h get drive handle table
	    01h get drive flag table
	    02h get drive connection ID table
	    03h get connection ID table
	    04h get file server name table
Return: ES:DI -> shell status table
---------------------------------------------
INT 21 - Novell Advanced NetWare 1.0+ - CONNECTION ID
	AH = F0h
	AL = subfunction
	    00h set preferred connection ID
	    01h get preferred connection ID
	    02h get default connection ID
	    03h LPT capture active
	    04h set primary connection ID
	    05h get primary connection ID
	DL = preferred file server
Return: AL = selected file server
---------------------------------------------
INT 21 - Novell Advanced NetWare 1.0+ - FILE SERVER CONNECTION
	AH = F1h
	AL = subfunction
	    00h attach to file server
		DL = preferred file server
	    01h detach from file server
	    02h logout from file server
Return: AL = completion code
---------------------------------------------
INT 21 - Novell NetWare - ???
	AH = F2h
	???
Return: ???
---------------------------------------------
INT 21 - Novell Advanced NetWare 2.0+ - FILE SERVER FILE COPY
	AH = F3h
	ES:DI -> request string (see below)
Return: AL = status/error code
	CX:DX = number of bytes copied

Format of request string:
Offset	Size	Description
 00h	WORD	source file handle
 02h	WORD	destination file handle
 04h	DWORD	starting offset in source
 08h	DWORD	starting offset in destination
 0Ch	DWORD	number of bytes to copy
---------------------------------------------
INT 21 - DOS v??? - SET OEM INT 21 HANDLER
	AH = F8h
	DS:DX -> OEM INT 21 handler for functions F9h to FFh
		 FFFFh:FFFFh resets to original handlers

Notes:	calls to AH=F9h through AH=FFH will return CF set and AX=1 (invalid
	  function) if no handler set
	handler is called with all registers exactly as set by caller, and
	  should exit with IRET
---------------------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = F9h
---------------------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = FAh
---------------------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = FBh
---------------------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = FCh
---------------------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = FDh
---------------------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = FEh
---------------------------------------------
INT 21 - PCMag PCMANAGE/DCOMPRES - INSTALLATION CHECK
	AX = FEDCh
Return: AX = CDEFh if installed
---------------------------------------------
INT 21 - DOS v??? - OEM FUNCTION
	AH = FFh
---------------------------------------------
INT 21 - CED - INSTALLABLE COMMANDS
	AH = FFh
	AL = 00h add installable command
	       BL = mode - bit 0 = 1 callable from DOS prompt
			   bit 1 = 1 callable from application
	       DS:SI -> CR-terminated command name
	       ES:DI -> FAR routine entry point
	AL = 01h remove installable command
	       DS:SI -> CR-terminated command name
	AL = 02h reserved, may be used to test for CED installation
Return: CF set on error
	    AX = 01h invalid function
		 02h command not found (subfunction 01h only)
		 08h insufficient memory (subfunction 00h only)
		 0Eh bad data (subfunction 00h only)
	AH = 0FFh if CED not installed
---------------------------------------------
INT 22 - DOS - TERMINATE ADDRESS
   FAR (DWORD) address to jump to when program "returns to DOS".  Normally
   points at the instruction immediately following INT 21/AH=4Bh call which
   loaded the current program.	Should NEVER be called directly.
SeeAlso: INT 20, INT 21/AH=00h,31h,4Ch
---------------------------------------------
INT 23 - DOS - CONTROL "C" EXIT ADDRESS
   Automatically called by DOS when CTRL-C or CTRL-BREAK is detected. Normally
   aborts program and returns to DOS, but may be changed.
SeeAlso: INT 1B
---------------------------------------------
INT 24 - DOS - FATAL ERROR HANDLER ADDRESS
   Automatically called upon detection of unrecoverable I/O error.
   Normally points to routine in resident part of COMMAND.COM that prints
   "Abort, Retry, Ignore?" message and takes the reply, but may be overridden
   if desired.

Provides the following values in registers on entry to interrupt handler:
	AH: bit 7 = 0 disk I/O error
		  = 1 other error -- if block device, bad FAT
				  -- if char device, code in DI
	    bit 6  unused
	    bit 5 = 1 if Ignore allowed, 0 if not (DOS 3+)
	    bit 4 = 1 if Retry allowed, 0 if not (DOS 3+)
	    bit 3 = 1 if Fail allowed, 0 if not (DOS 3+)
	    bit 2 \ disk area of error	00 = DOS area  01 = FAT
	    bit 1 /			10 = root dir  11 = data area
	    bit 0 = 1 if write, 0 if read
	AL = drive number if AH bit 7 = 1, otherwise undefined
	BP:SI -> header of device driver for which error occurred
	    block device if high bit of BP:[SI+4] set
	low byte of DI:
	   00h write-protect error
	   01h unknown unit
	   02h drive not ready
	   03h unknown command
	   04h data error (bad CRC)
	   05h bad request structure length
	   06h seek error
	   07h unknown media type
	   08h sector not found
	   09h printer out of paper
	   0Ah write fault
	   0Bh read fault
	   0Ch general failure
	   0Dh (DOS 3+) sharing violation
	   0Eh (DOS 3+) lock violation
	   0Fh (DOS 3+) invalid disk change
	   10h (DOS 3+) FCB unavailable
	   11h (DOS 3+) sharing buffer overflow
Handler must return
	AL = 00h ignore error
	   = 01h retry operation
	   = 02h terminate program through INT 22h
	   = 03h fail system call in progress (DOS 3+)
Notes:	for DOS 3.1+, IGNORE (AL=00h) is turned into FAIL (AL=03h) on network
	  critical errors
	if IGNORE specified but not allowed, it is turned into FAIL
	if RETRY specified but not allowed, it is turned into FAIL
	if FAIL specified but not allowed, it is turned into ABORT
---------------------------------------------
INT 25 - DOS - ABSOLUTE DISK READ (except DOS 4.0/COMPAQ DOS 3.31 >32M partitn)
	AL = drive number (0=A, 1=B, etc)
	DS:BX = Disk Transfer Address (buffer)
	CX = number of sectors to read
	DX = first relative sector to read
Return: CF set on error
	    AL = error code issued to INT 24h in low half of DI
	    AH = 80h if attachment failed to respond
		 40h if seek operation failed
		 20h if controller failed
		 10h if data error (bad CRC)
		 08h if DMA failure
		 04h if requested sector not found
		 03h if write-protected disk (INT 26 only)
		 02h if bad address mark
		 01h if bad command
Note:	ORIGINAL FLAGS ON STACK!  May destroy all registers except segment regs
BUG:	DOS 3.1 through 3.3 set the word at ES:[BP+1Eh] to FFFFh if AL is an
	invalid drive number
---------------------------------------------
INT 25 - DOS 4.0/COMPAQ DOS 3.31 - ABSOLUTE DISK READ (>32M hard-disk partitn)
	AL = drive number (0=A, 1=B, etc)
	CX = FFFFh
	DS:BX -> disk read packet (see below)
Return: same as above
Notes:	partition is potentially >32M (and requires this form of the call) if
	  bit 1 of device attribute word in device driver is set
	ORIGINAL FLAGS LEFT ON STACK!

Format of disk read packet:
Offset	Size	Description
 00h	DWORD	sector number
 04h	WORD	number of sectors to read
 06h	DWORD	transfer address
---------------------------------------------
INT 26 - DOS - ABSOLUTE DISK WRITE (except DOS 4.0/COMPAQ DOS 3.31 >32M partn)
	AL = drive number (0=A, 1=B, etc)
	DS:BX = Disk Transfer Address (buffer)
	CX = number of sectors to write
	DX = first relative sector to write
Return: CF set on error
	    AL = error code issued to INT 24h in low half of DI
	    AH = same error codes as for INT 25h
Note:	ORIGINAL FLAGS ON STACK!
BUG:	DOS 3.1 through 3.3 set the word at ES:[BP+1Eh] to FFFFh if AL is an
	invalid drive number
---------------------------------------------
INT 26 - DOS 4.0/COMPAQ DOS 3.31 - ABSOLUTE DISK WRITE (>32M hard-disk partitn)
	AL = drive number (0=A, 1=B, etc)
	CX = FFFFh
	DS:BX -> disk write packet (see below)
Return: same as above
Notes:	partition is potentially >32M (and requires this form of the call) if
	  bit 1 of device attribute word in device driver is set
	ORIGINAL FLAGS LEFT ON STACK!

Format of disk write packet:
Offset	Size	Description
 00h	DWORD	sector number
 04h	WORD	number of sectors to read
 06h	DWORD	transfer address
---------------------------------------------
INT 27 - DOS - TERMINATE BUT STAY RESIDENT
	CS = current program segment
	DX = last program byte + 1
Return: never
Note:	this is an obsolete call
SeeAlso: INT 21/AH=31h
---------------------------------------------
INT 28 - DOS 2+ internal - KEYBOARD BUSY LOOP
   This interrupt is called from inside the "get input from keyboard" routine
   in DOS, if and only if it is safe to use INT 21 to access the disk at that
   time.  It is used primarily by the PRINT.COM routines and TSR programs, but
   any number of other routines could be chained to it by saving the original
   vector, and calling it with a FAR call (or just JMPing to it) at the end of
   the new routine.

   The INT 28h handler may invoke any INT 21h function except functions 00h
   through 0Ch (and 50h/51h under DOS 2.xx unless DOS CriticalErr flag is set).
   Calls to functions 3Fh and 40h may not use a handle which refers to CON.

   Until some program installs its own routine, this interrupt vector simply
   points to an IRET opcode.

Note:	supported in OS/2 compatibility box
---------------------------------------------
INT 29 - DOS 2+ internal - FAST PUTCHAR
	AL = character to display
Return: nothing
Notes:	this interrupt is called from the DOS output routines if output is
	  going to a device rather than a file, and the device driver's
	  attribute word has bit 3 (04h) set.
	the default handler under DOS 2.x and 3.x simply calls INT 10/AH=0Eh
	the default handler under DESQview 2.2 understands the <Esc>[2J
	  screen-clearing sequence
---------------------------------------------
INT 2A - Microsoft/LANtastic NETWORK - INSTALLATION CHECK
	AH = 00h
Return: AH <> 00h if installed
---------------------------------------------
INT 2A - Microsoft/LANtastic NETWORK - EXECUTE NETBIOS REQUEST, NO ERROR RETRY
	AH = 01h
	ES:BX -> NCB (see INT 5C)
Return: AL = NetBIOS error code
	AH = 00h if no error
	   = 01h on error
SeeAlso: INT 5C
---------------------------------------------
INT 2A - Microsoft Networks - SET NET PRINTER MODE
	AH = 02h
	???
Return: ???
---------------------------------------------
INT 2A - Microsoft Networks - CHECK DIRECT I/O
	AX = 0300h
	DS:SI -> ASCIZ disk device name
Return: CF clear if allowed
---------------------------------------------
INT 2A - Microsoft/LANtastic NETWORK - EXECUTE NETBIOS REQUEST
	AH = 04h
	AL = 00h for error retry, 01h for no retry
	ES:BX -> NCB (see INT 5C)
Return: AX = 0000h for no error
	AH = 01h, AL = error code
Note:	request automatically retried (if AL=00h) on errors 09h, 12h, and 21h
SeeAlso: INT 5C
---------------------------------------------
INT 2A - Microsoft/LANtastic NETWORK - GET NETWORK RESOURCE INFORMATION
	AX = 0500h
Return: AX = reserved
	BX = number of network names available
	CX = number of commands (NCBs) available
	DX = number of sessions available
---------------------------------------------
INT 2A - NETBIOS - NETWORK PRINT-STREAM CONTROL
	AH = 06h
	AL = 01h set concatenation mode (all printer output put in one job)
	     02h set truncation mode (default)
		 printer open/close starts new print job
	     03h flush printer output and start new print job
Return: CF set on error
	    AX = error code
Note:	subfunction 03h is equivalent to Ctrl/Alt/keypad-*
---------------------------------------------
INT 2A - MS Networks or NETBIOS - ???
	AX = 2001h
	???
Return: ???
Note:	intercepted by DESQview 2.x
---------------------------------------------
INT 2A - Network - ???
	AX = 2002h
	???
Return: ???
Note:	called by MSDOS 3.30 APPEND
---------------------------------------------
INT 2A - Network - ???
	AX = 2003h
	???
Return: ???
Note:	called by MSDOS 3.30 APPEND
---------------------------------------------
INT 2A - Microsoft Networks - BEGIN DOS CRITICAL SECTION
	AH = 80h
	AL = critical section number (00h-0Fh)
	    01h  SHARE.EXE
	    08h  ASSIGN.COM
---------------------------------------------
INT 2A - Microsoft Networks - END DOS CRITICAL SECTION
	AH = 81h
	AL = critical section number (00h-0Fh)
	    01h  SHARE.EXE
	    08h  ASSIGN.COM
---------------------------------------------
INT 2A - Microsoft Networks - SERVER HOOK
	AH = 82h
	STACK: AX from call to INT 21
Return: stack unchanged
Note:	called by the INT 21h function dispatcher for function 0 and functions
	  greater than 0Ch except 59h
---------------------------------------------
INT 2A - Microsoft Networks - KEYBOARD BUSY LOOP
	AH = 84h
Note:	similar to DOS's INT 28h
---------------------------------------------
INT 2A - ??? - CRITICAL SECTION
	AH = 87h
	AL = start/end
	    00h start
	    01h end
Note:	called by PRINT.COM
---------------------------------------------
INT 2A - Network - ???
	AH = 89h
	AL = ???  (ASSIGN uses 08h)
	???
Return: ???
---------------------------------------------
INT 2A - Network - ???
	AH = C2h
	AL = subfunction
	    07h ???
	    08h ???
	BX = 0001h
	???
Return: ???
Note:	called by DOS 3.30 APPEND
---------------------------------------------
INT 2B - Internal routine for MSDOS (IRET)
---------------------------------------------
INT 2C - Internal routine for MSDOS (IRET)
---------------------------------------------
INT 2D - Internal routine for MSDOS (IRET)
---------------------------------------------
INT 2E - DOS 2+ internal - EXECUTE COMMAND
	DS:SI -> counted CR-terminated command string
Notes:	the top-level command.com executes the command
	all registers including SS and SP are destroyed as in INT 21/AH=4Bh
	Since COMMAND.COM processes the string as if typed from the keyboard,
	  the transient portion needs to be present, and the calling program
	  must ensure that sufficient memory to load the transient portion can
	  be allocated by DOS if necessary.
	hooked but ignored by 4DOS v3.0 COMMAND.COM replacement
---------------------------------------------
INT 2F - Multiplex - notes
	AH = identifier of program which is to handle the interrupt
	   00h-7Fh reserved for DOS
	   C0h-FFh reserved for applications
	AL is the function code
This is a general mechanism for verifying the presence of a TSR and 
communicating with it.
---------------------------------------------
INT 2F - Multiplex - BMB Compuscience Canada Utilities Interface
	AH = xx (dynamically assigned based upon a search for a multiplex
		 number which doesn't answer installed)
	AL = 00h install check
	ES:DI = EBEB:BEBE
Return: AL = 00h not installed
	     01h not installed, not OK to install
	     FFh installed and if ES:DI != EBEB:BEBE then ES:DI will point
		 to a string 'BMB xxxx' where xxxx is a product name and
		 version
---------------------------------------------
INT 2F - Multiplex - DOS 2.x PRINT.COM - ???
	AH = 00h
	???
Return: ???
Notes:	DOS 2.x PRINT.COM does not chain to previous INT 2F handler
	values in AH other than 00h or 01h cause PRINT to return the number of
	  files in the queue in AH
---------------------------------------------
INT 2F - Multiplex - DOS 3.1+ PRINT.COM - GIVE PRINT A TIME SLICE
	AX = 0080h
Return: after PRINT executes
---------------------------------------------
INT 2F - Multiplex - DOS 2.x PRINT.COM - ???
	AH = 01h
	???
Return: ???
Notes:	DOS 2.x PRINT.COM does not chain to previous INT 2F handler
	values in AH other than 00h or 01h cause PRINT to return the number of
	  files in the queue in AH
---------------------------------------------
INT 2F - Multiplex - DOS 3+ PRINT.COM - INSTALLATION CHECK
	AX = 0100h
Return: AL =
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
---------------------------------------------
INT 2F - Multiplex - DOS 3+ PRINT.COM - SUBMIT FILE
	AX = 0101h
	DS:DX -> packet (see below)
Return: CF set on error
	    AX = error code
	CF clear if successful
	    AL = 01h added to queue
		 9Eh now printing

Format of submit packet:
Offset	Size	Description
 00h	BYTE	level (must be 0)
 01h	DWORD	pointer to ASCIZ filename (no wildcards)
---------------------------------------------
INT 2F - Multiplex - DOS 3+ PRINT.COM - REMOVE FILE
	AX = 0102h
	DS:DX -> ASCIZ file name (wildcards allowed)
Return: CF set on error
	    AX = error code
---------------------------------------------
INT 2F - Multiplex - DOS 3+ PRINT.COM - REMOVE ALL FILES
	AX = 0103h
Return: CF set on error
	    AX = error code
---------------------------------------------
INT 2F - Multiplex - DOS 3+ PRINT.COM - HOLD QUEUE/GET STATUS
	AX = 0104h
Return: CF set on error
	    AX = error code
		01h function invalid
		02h file not found
		03h path not found
		04h too many open files
		05h access denied
		08h queue full
		09h spooler busy
		0Ch name too long
		0Fh drive invalid
	DX = error count
	DS:SI -> print queue (null-string terminated list of 64-byte ASCIZ 
		 file names)
---------------------------------------------
INT 2F - Multiplex - DOS 3+ PRINT.COM - RESTART QUEUE
	AX = 0105h
Return: CF set on error
	   AX = error code
---------------------------------------------
INT 2F - Multiplex - PRINT (DOS 3.3) - CHECK IF OUTPUT DEVICE READY???
	AX = 0106h
	???
Return: ???
Note:	eventually calls device driver for spooled device with request 0Ah,
	  looping until not busy or timeout
---------------------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - INSTALL CHECK
	AX = 0200h
Return: AL = FFh if installed
---------------------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0201h
Return: nothing???
Note:	called by DOS 3.3 PRINT.COM
---------------------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0202h
	???
Return: nothing???
Note:	called by DOS 3.3 PRINT.COM
---------------------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0203h
Return: nothing???
Note:	called by DOS 3.3 PRINT.COM
---------------------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0204h
	???
Return: nothing???
Note:	called by DOS 3.3 PRINT.COM
---------------------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 02xxh
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - DOS 3+ CRITICAL ERROR HANDLER - INSTALLATION CHECK
	AX = 0500h
Return: AL = 00h not installed, OK to install
	     01h not installed, can't install
	     FFh installed
Note:	this set of functions allows a user program to partially or completely
	  override the default critical error handler in COMMAND.COM
SeeAlso: INT 24
---------------------------------------------
INT 2F - Multiplex - DOS 3+ CRITICAL ERROR HANDLER - EXPAND ERROR INTO STRING
	AH = 05h
---DOS 3.x---
	AL = extended error code (not zero)
---DOS 4.x---
	AL = 01h or 02h
	BX = error code
Return: CF clear if successful
	    ES:DI -> ASCIZ error message (read-only)
	    AL = ???
	CF set if error code can't be converted to string
Note:	called at start of COMMAND.COM's default critical error handler if 
	  installed by a user program, allowing partial or complete overriding
	  of the default error message
SeeAlso: INT 24
---------------------------------------------
INT 2F - Multiplex - ASSIGN - INSTALLATION CHECK
	AX = 0600h
Return: AH <> 00h if installed
Note:	DOS 3.3 ASSIGN does not chain INT 2F/AH=06h calls to previous handler
---------------------------------------------
INT 2F - Multiplex - ASSIGN - GET MEMORY SEGMENT
	AX = 0601h
Return: ES = segment of ASSIGN work area and assignment table
Note:	under DOS 3.3, the 26 bytes starting at ES:0103h specify which drive
	  each of A: to Z: is mapped to.  Initially set to 01h 02h 03h....
	under DOS 4.0, the table is located at ES:0003h ???
---------------------------------------------
INT 2F - Multiplex - DRIVER.SYS support - INSTALLATION CHECK
	AX = 0800h
Return:	AL = 00h not installed, OK to install
	     01h not installed, not OK to install
	     FFh installed
---------------------------------------------
INT 2F - Multiplex - DRIVER.SYS support - ADD NEW BLOCK DEVICE
	AX = 0801h
	DS:DI -> drive data table (see below)
Notes:	moves down internal list of drive data tables, copying and modifying
	  the flags word at offset 29h for tables referencing same phys drive
	device driver appended to driver chain

Format of drive data table:
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
 19h  	BYTE	???
 1Ah	WORD	number of DEVICE OPEN calls without corresponding DEVICE CLOSE
 1Ch 11 BYTEs	volume label or "NO NAME    " if none
 27h	BYTE	???
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
 43h  9 BYTEs	??? name of some kind, default = "NO NAME  "
 4Ch	BYTE	???
 4Dh	DWORD	time of last access in clock ticks (FFFFFFFFh if never)
		removable media only???
---------------------------------------------
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
		bits 14-10: reserved
		bit 9: busy
		bit 8: done
		bits 7-0: error code if bit 15 set (see below)
 05h  8 BYTEs	reserved
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
---command codes 03h,0Ch---
 0Dh	BYTE	media descriptor (block devices only)
 0Eh	DWORD	transfer address
 12h	WORD	byte count (character devices) or sector count (block devices)
 14h	WORD	starting sector number (block devices only)
---command codes 04h,08h,09h---
 0Dh	BYTE	media descriptor (block devices only)
 0Eh	DWORD	transfer address
 12h	WORD	byte count (character devices) or sector count (block devices)
 14h	WORD	starting sector number (block devices only)
 16h	DWORD	(DOS 3+) pointer to volume ID if error 0Fh returned
---command code 05h---
 0Dh	BYTE	byte read from device if BUSY bit clear on return
---command codes 06h,07h,0Ah,0Bh---
 no further fields
---command code 10h---
 0Dh	BYTE	unused
 0Eh	DWORD	transfer address
 12h	WORD	byte count
---command code 13h---
 0Dh	BYTE	category code
		00h unknown
		01h COMn:
		03h CON
		05h LPTn:
		08h disk
 0Eh	BYTE	function code
 0Fh	DWORD	??? (apparently unused in DOS 3.3)
 13h	DWORD	pointer to parameter block from INT 21/AX=440Dh

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
	11h unused???
	12h unused???
	13h (DOS 3.2+) GENERIC IOCTL
	14h unused???
	15h unused???
	16h unused???
	17h (DOS 3.2+) GET LOGICAL DEVICE
	18h (DOS 3.2+) SET LOGICAL DEVICE
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
	0Eh reserved
	0Fh invalid disk change
---------------------------------------------
INT 2F - Multiplex - SHARE - INSTALLATION CHECK
	AX = 1000h
Return: AL = 00h  not installed, OK to install
	     01h  not installed, not OK to install
	     FFh  installed
Note:	values of AL other than 00h put DOS 3.3 SHARE into an infinite loop
	  (08E9: OR  AL,AL
	   08EB: JNZ 08EB) <- the buggy instruction
SeeAlso: INT 21/AH=52h
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - INSTALLATION CHECK
	AX = 1100h
Return: AL = 00h  not installed, OK to install
	     01h  not installed, not OK to install
	     FFh  installed
Note:	In DOS 4+, the 11xx calls are all in IFSFUNC.EXE, not in the PC LAN
	  Program redirector. 
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - RMDIR???
	AX = 1101h
	???
Return: ???
SeeAlso: INT 21/AH=3Ah
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - MKDIR???
	AX = 1103h
	???
Return: CF set on error
	    AX = DOS error code (see INT 21/AH=59h)
SeeAlso: INT 21/AH=39h
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - CHDIR???
	AX = 1105h
	???
Return: ???
SeeAlso: INT 21/AH=3Bh
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - CLOSE REMOTE FILE
	AX = 1106h
	???
Return: ???
SeeAlso: INT 21/AH=3Eh
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - COMMIT REMOTE FILE
	AX = 1107h
	???
Return: ???
SeeAlso: INT 21/AX=5D01h
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - READ FROM REMOTE FILE
	AX = 1108h
	???
Return: ???
SeeAlso: INT 21/AH=3Fh
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - WRITE TO REMOTE FILE
	AX = 1109h
	???
Return: ???
SeeAlso: INT 21/AH=40h
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - LOCK REGION OF FILE
	AX = 110Ah
	BX = file handle
	CX:DX = starting offset
	SI = high word of size
	STACK: WORD low word of size
Return: CF set on error
	   AL = DOS error code (see INT 21/AH=59h)
	STACK unchanged
SeeAlso: INT 21/AH=5Ch
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - UNLOCK REGION OF FILE
	AX = 110Bh
	BX = file handle
	CX:DX = starting offset
	SI = high word of size
	STACK: WORD low word of size
Return: CF set on error
	   AL = DOS error code (see INT 21/AH=59h)
	STACK unchanged
SeeAlso: INT 21/AH=5Ch
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - GET DISK SPACE
	AX = 110Ch
	???
Return: AL = sectors per cluster
	BX = total clusters
	CX = bytes per sector
	DX = number of available clusters
SeeAlso: INT 21/AH=36h
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - SET REMOTE FILE'S ATTRIBUTES
	AX = 110Eh
	???
	STACK: WORD new file attributes
Return: ???
	STACK unchanged
SeeAlso: INT 21/AX=4301h
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - GET REMOTE FILE'S ATTRIBUTES
	AX = 110Fh
	???
Return: AX = file attributes
SeeAlso: INT 21/AX=4300h
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - RENAME REMOTE FILE
	AX = 1111h
	???
Return: ???
SeeAlso: INT 21/AH=56h
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - DELETE REMOTE FILE???
	AX = 1113h
	???
Return: ???
SeeAlso: INT 21/AH=41h
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - OPEN EXISTING REMOTE FILE???
	AX = 1116h
	???
Return: ???
SeeAlso: INT 21/AH=3Dh
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - CREATE REMOTE FILE???
	AX = 1117h
	STACK: WORD ???
Return: ???
	STACK unchanged
Note:	one of AX=1117h and AX=1118h probably truncates an existing remote file
SeeAlso: INT 21/AH=3Ch
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - CREATE REMOTE FILE???
	AX = 1118h
	STACK: WORD ???
Return: ???
	STACK unchanged
Note:	one of AX=1117h and AX=1118h probably truncates an existing remote file
SeeAlso: INT 21/AH=3Ch
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - CHDIR???
	AX = 1119h
	???
Return: ???
SeeAlso: INT 21/AH=3Bh
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - FINDFIRST???
	AX = 111Bh
	???
Return: ???
SeeAlso: INT 21/AH=4Eh
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - FINDNEXT???
	AX = 111Ch
	???
Return: ???
SeeAlso: INT 21/AH=4Fh
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - CLOSE ALL REMOTE FILES FOR PROCESS???
	AX = 111Dh
	DS???
Return: ???
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - DO REDIRECTION
	AX = 111Eh
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
Return: CF set on error
	    AX = error code (see INT 21/AH=59h)
	STACK unchanged
SeeAlso: INT 21/AX=5F00h,5F01h,5F02h,5F03h,5F04h,5F05h
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - PRINTER SETUP
	AX = 111Fh
	STACK: WORD function
		5E02h  set printer setup
		5E03h  get printer setup
		5E04h  set printer mode
		5E05h  get printer mode
		5E06h  ???
Return: CF set on error
	    AX = error code (see INT 21/AH=59h)
	STACK unchanged
SeeAlso: INT 21/AX=5E02h,5E03h,5E04h,5E05h
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - RESET DISKS AND FLUSH BUFFERS???
	AX = 1120h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - SEEK ON REMOTE FILE???
	AX = 1121h
	???
Return: CF set on error
	CF clear if successful
	    DX:AX = new file position???
SeeAlso: INT 21/AH=42h
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - PROCESS TERMINATION HOOK???
	AX = 1122h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - ???
	AX = 1123h
	DS:DX -> ASCIZ filename
	???
Return: CF set on error???
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - ???
	AX = 1124h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - REDIRECTED PRINTER MODE
	AX = 1125h
	STACK: WORD subfunction
		5D07h get print stream state
			Return: DL = state
		5D08h set print stream state
		5D09h finish print job
Return: CF set on error
	    AX = error code (see INT 21/AH=59h)
	STACK unchanged
SeeAlso: INT 21/AX=5D07h,5D08h,5D09h
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - ???
	AX = 1126h
	???
Return: CF set on error???
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - INSTALLATION CHECK
	AX = 1200h
Return: AL = FFh (for compatibility with other INT 2F functions)
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - CLOSE CURRENT FILE???
	AX = 1201h
	STACK: WORD ???
Return: BX???
	CX???
	ES:DI -> ???
Note:	can be called only while on DOS internal stack
SeeAlso: INT 21/AH=3Eh
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET INTERRUPT ADDRESS
	AX = 1202h
	STACK: WORD vector number
Return: ES:BX -> interrupt vector
	STACK unchanged
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET DOS DATA SEGMENT
	AX = 1203h
Return: DS = segment of IBMDOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - NORMALIZE PATH SEPARATOR
	AX = 1204h
	STACK: WORD character to normalize
Return: AL = normalized character (forward slash turned to backslash)
	STACK unchanged
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - OUTPUT CHARACTER
	AX = 1205h
	STACK: WORD character to output
Return: STACK unchanged
Note:	can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - INVOKE CRITICAL ERROR
	AX = 1206h
Return: AL = 0-3 for Abort, Retry, Ignore, Fail
Note:	can be called only from within DOS
SeeAlso: INT 24
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - MAKE DISK BUFFER MOST-RECENTLY USED
	AX = 1207h
	DS:DI -> disk buffer
Return: buffer moved to end of buffer list (least-recently used is first)
Note:	can be called only from within DOS
SeeAlso: AX=120Fh
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - DECREMENT WORD
	AX = 1208h
	ES:DI -> word to decrement
Return: AX = new value of word
	word pointed to by ES:DI decremented, skipping zero
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - FLUSH AND FREE DISK BUFFER
	AX = 1209h
	DS:DI -> disk buffer
Return: disk buffer marked unused, contents written to disk if buffer dirty
Note:	can be called only from within DOS
SeeAlso: AX=120Eh
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - ???
	AX = 120Ah
	???
	STACK: WORD ???
Return: CF set on error
	AL = ???
	STACK unchanged
Note:	can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - ???
	AX = 120Bh
	ES:DI -> system file table entry
	STACK: WORD ???
Return: CF set on error
	    AX = error code (20h) (see AH=59h)
	CF clear if successful
	STACK unchanged
Note:	can be called only from within DOS, performs AX=120Ah routine if file
	  opened via FCB or in compatibility mode with inheritance allowed
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - SET FCB FILE'S OWNER???
	AX = 120Ch
	???
Return: ???
Note:	can be called only from within DOS
	seems to change owner of last-accessed file to calling process
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET DATE AND TIME
	AX = 120Dh
Return: AX = current date in packed format (see INT 21/AX=5700h)
	DX = current time in packed format (see INT 21/AX=5700h)
Note:	can be called only from within DOS
SeeAlso: INT 21/AH=2Ah,2Ch
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - FREE ALL DISK BUFFERS
	AX = 120Eh
Return: DS:DI -> first disk buffer
Note:	can be called only from within DOS
SeeAlso: AX=1209h, INT 21/AH=0Dh
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - MAKE BUFFER MOST RECENTLY USED
	AX = 120Fh
	DS:DI -> disk buffer
Return: DS:DI -> next buffer in buffer list
Note:	can be called only from within DOS
SeeAlso: AX=1207h
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - FIND UNREFERENCED DISK BUFFER
	AX = 1210h
	DS:DI -> first disk buffer to check
Return: DS:DI -> first unreferenced disk buffer
	ZF clear if found, set if not found
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - NORMALIZE ASCIZ FILENAME
	AX = 1211h
	DS:SI -> ASCIZ filename to normalize
	ES:DI -> buffer for normalized filename
Return: destination buffer filled with uppercase filename, with slashes turned
	to backslashes
SeeAlso: AX=121Eh,1221h
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET LENGTH OF ASCIZ STRING
	AX = 1212h
	ES:DI -> ASCIZ string
Return: CX = length of string
SeeAlso: AX=1225h
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - UPPERCASE CHARACTER
	AX = 1213h
	STACK: WORD character to convert to uppercase
Return: AL = uppercase character
	STACK unchanged
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - COMPARE FAR POINTERS
	AX = 1214h
	DS:SI = first pointer
	ES:DI = second pointer
Return: ZF set if pointers are equal, ZF clear if not equal
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - FLUSH BUFFER
	AX = 1215h
	DS:DI -> disk buffer
	STACK: WORD drives for which to skip buffer
		ignore buffer if drive same as high byte, or bytes differ and
		the buffer is for a drive OTHER than that given in low byte
Return: STACK unchanged
Note:	can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET ADDRESS OF SYSTEM FCB
	AX = 1216h
	BX = system file table entry number
Return: CF clear if successful
	    ES:DI -> system file table entry
	CF set if BX greater than FILES=
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - SET WORKING DRIVE
	AX = 1217h
	STACK: WORD drive (0 = A:, 1 = B:, etc)
Return: CF set on error
	    (drive > LASTDRIVE)
	CF clear if successful
	    DS:SI -> current directory structure for specified drive
	STACK unchanged
Note:	can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET CALLER'S REGISTERS
	AX = 1218h
Return: DS:SI -> saved caller's AX,BX,CX,DX,SI,DI,BP,DS,ES (on stack)
Note:	only valid while within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - SET DRIVE???
	AX = 1219h
	STACK: WORD drive (0 = default, 1 = A:, etc)
Return: ???
	STACK unchanged
Note:	can be called only from within DOS
	calls function 1217h
	builds a current directory structure
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET FILE'S DRIVE
	AX = 121Ah
	DS:SI -> filename
Return: AL = drive (0 = default, 1 = A:, etc, FFh = invalid)
SeeAlso: INT 21/AH=19h,60h
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - SET YEAR/LENGTH OF FEBRUARY
	AX = 121Bh
	CL = year - 1980
Return: AL = number of days in February
Note:	requires DS to be set to the DOS code segment
SeeAlso: INT 21/AH=2Bh
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - CHECKSUM MEMORY
	AX = 121Ch
	DS:SI -> start of memory to checksum
	CX = number of bytes
	DX = initial checksum
Return: DX = checksum
Note:	can be called only from within DOS
SeeAlso: AX=121Dh
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - SUM MEMORY
	AX = 121Dh
	DS:SI -> memory to add up
	CX = 0000h
	DX = limit
Return: AL = byte which exceeded limit
	CX = number of bytes before limit exceeded
	DX = remainder after adding first CX bytes
SeeAlso: AX=121Ch
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - COMPARE FILENAMES
	AX = 121Eh
	DS:SI -> first ASCIZ filename
	ES:DI -> second ASCIZ filename
Return: ZF set if filenames equivalent, ZF clear if not
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - BUILD DRIVE INFO BLOCK
	AX = 121Fh
	STACK: WORD drive letter
Return: ES:DI -> drive info block (will be overwritten by next call)
	STACK unchanged
Note:	can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET SYSTEM FILE TABLE NUMBER
	AX = 1220h
	BX = file handle
Return: CF set on error
	    AL = 6 (invalid file handle)
	CF clear if successful
	    BYTE ES:[DI] = system file table entry number for file handle
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - CANONICALIZE FILE NAME
	AX = 1221h
	DS:SI -> file name to be fully qualified
	ES:DI -> 128-byte buffer for resulting canonical file name
Return: (see INT 21/AH=60h)
Notes:	can be called only from within DOS
	identical to INT 21/AH=60h
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - SET EXTENDED ERROR INFO
	AX = 1222h
	SS = DOS data segment
	SS:SI -> 4-byte records
		BYTE	error code, FFh = last record
		BYTE	error class, FFh = don't change
		BYTE	suggested action, FFh = don't change
		BYTE	error locus, FFh = don't change
Return: SI destroyed
Note:	can be called only from within DOS
SeeAlso: INT 21/AH=59h
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - CHECK IF CHARACTER DEVICE???
	AX = 1223h
	???
Return: CF set if not found
	CF clear if found
	    DS:SI -> device driver with same name as filename as SDA+218h ???
Note:	can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - DELAY
	AX = 1224h
Return: after delay of ??? ms
Note:	can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET LENGTH OF ASCIZ STRING
	AX = 1225h
	DS:SI -> ASCIZ string
Return: CX = length of string
SeeAlso: AX=1212h
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ internal - OPEN FILE
	AX = 1226h
	CL = access mode
	DS:DX -> ASCIZ filename
Return: (see INT 21/AH=3Dh)
Note:	can be called only from within DOS
SeeAlso: INT 21/AH=3Dh
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ internal - CLOSE FILE
	AX = 1227h
	BX = file handle
Return: AL = 6 invalid file handle
	???
Notes:	can be called only from within DOS
	same action as INT 21/AH=3Eh
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ internal - MOVE FILE POINTER
	AX = 1228h
	BP = 4200h, 4201h, 4202h (see INT 21/AH=42h)
	BX = file handle
	CX:DX = offset in bytes
Return: as for INT 21/AH=42h
Notes:	can be called only from within DOS
	sets user stack frame pointer to dummy buffer, moves BP to AX, performs
	  LSEEK, and restores frame pointer
SeeAlso: INT 21/AH=42h
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ internal - GET SYSTEM FILE TABLE ENTRY FOR FILE
	AX = 1229h
	BX = file handle
	???
Return: ES:DI -> system file table entry for file (see INT 21/AH=52h)
Notes:	can be called only from within DOS
	according to Wes Cowley, this actually does the same thing as 
	  INT 21/AH=3Fh
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ internal - SET FASTOPEN ENTRY POINT
	AX = 122Ah
	BX = entry point to set (0001h or 0002h)
	DS:SI -> FASTOPEN entry point
Return: CF set if entry point already set
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ internal - IOCTL
	AX = 122Bh
	BP = 44xxh
	additional registers as appropriate for INT 21/AX=44xxh
Return: as for INT 21/AH=44h
Notes:	can be called only from within DOS
	sets user stack frame pointer to dummy buffer, moves BP to AX, performs
	  IOCTL, and restores frame pointer
SeeAlso: INT 21/AH=44h
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ internal - GET DEVICE CHAIN
	AX = 122Ch
Return: BX:AX -> header of second device driver (NUL is first) in driver chain
SeeAlso: INT 21/AH=52h
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ internal - GET EXTENDED ERROR CODE
	AX = 122Dh
Return: AX = current extended error code
SeeAlso: INT 21/AH=59h
---------------------------------------------
INT 2F - Multiplex - DOS 4.00 internal - GET ???
	AX = 122Eh
	DL = subfunction: 00, 02, 04, 06 or 08h
Return: ES:DI set to ???
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ - SET ???
	AH = 13h
	DS:DX -> FAR function to ???
	ES:BX -> ???
Return: DS:DX from previous invocation of this function
	ES:BX from previous invocation of this function
---------------------------------------------
INT 2F - Multiplex - NLSFUNC.COM - INSTALLATION CHECK
	AX = 1400h
Return: AL = 00h not installed, OK to install
	     01h not installed, not OK
	     FFh installed
Note:	called by MSDOS v3.30 kernel
---------------------------------------------
INT 2F - Multiplex - NLSFUNC.COM - ???
	AX = 1401h
	DS:SI -> ???
	BX = ???
	DX = ???
Return: ???
Notes:	calls INT 2F/AX=1227h (close file) under certain circumstances
	called by MSDOS v3.30 kernel
---------------------------------------------
INT 2F - Multiplex - NLSFUNC.COM - ???
	AX = 1402h
	BP = ???
	DS:SI -> ???
Return: ???
Note:	calls INT 2F/AX=1227h (close file) under certain circumstances
---------------------------------------------
INT 2F - Multiplex - NLSFUNC.COM - ???
	AX = 1403h
	DS:SI -> ???
	BX = ???
	DX = ???
Return: ???
Note:	in DOS 3.3, appears to be identical to subfunction 01h
---------------------------------------------
INT 2F - Multiplex - DOS 3.3 NLSFUNC.COM - ???
	AX = 1404h
	???
Return: ???
Note:	called by MSDOS v3.30 kernel
---------------------------------------------
INT 2F - Multiplex - CDROM - INSTALLATION CHECK
	AX = 1500h
	BX = 0000h
Return: BX = number of CDROM drive letters used
	CX = starting drive letter (0=A:)
Note:	this installation check DOES NOT follow the format used by other
	  software
---------------------------------------------
INT 2F - Multiplex - CDROM - GET DRIVE DEVICE LIST
	AX = 1501h
	ES:BX -> buffer to hold drive letter list (5 bytes per drive letter)
Return: buffer filled, for each drive letter
	  BYTE	subunit number in driver
	  DWORD address of device driver header
---------------------------------------------
INT 2F - Multiplex - CDROM - GET COPYRIGHT FILE NAME
	AX = 1502h
	ES:BX -> 38-byte buffer for name of copyright file
	CX = drive number (0=A:)
Return: CF set if drive is not a CDROM drive
	    AX = 15 (invalid drive)
SeeAlso: AX=1503h
---------------------------------------------
INT 2F - Multiplex - CDROM - GET ABSTRACT FILE NAME
	AX = 1503h
	ES:BX -> 38-byte buffer for name of abstract file
	CX = drive number (0=A:)
Return: CF set if drive is not a CDROM drive
	    AX = 15 (invalid drive)
SeeAlso: AX=1502h
---------------------------------------------
INT 2F - Multiplex - CDROM - GET BIBLIOGRAPHIC DOC FILE NAME
	AX = 1504h
	ES:BX -> 38-byte buffer for name of bibliographic documentation file
	CX = drive number (0=A:)
Return: CF set if drive is not a CDROM drive
	    AX = 15 (invalid drive)
---------------------------------------------
INT 2F - Multiplex - CDROM - READ VTOC
	AX = 1505h
	ES:BX -> 2048-byte buffer
	CX = drive number (0=A:)
	DX = sector index (0=first volume descriptor,1=second,...)
Return: CF set on error
	    AX = error code (15=invalid drive,21=not ready)
	CF clear if successful
	    AX = volume descriptor type (1=standard,FFh=terminator,0=other)
---------------------------------------------
INT 2F - Multiplex - CDROM - TURN DEBUGGING ON
	AX = 1506h
	BX = debugging function to enable
Note:	reserved for development
SeeAlso: AX=1507h
---------------------------------------------
INT 2F - Multiplex - CDROM - TURN DEBUGGING OFF
	AX = 1507h
	BX = debugging function to disable
Note:	reserved for development
SeeAlso: AX=1506h
---------------------------------------------
INT 2F - Multiplex - CDROM - ABSOLUTE DISK READ
	AX = 1508h
	ES:BX -> buffer
	CX = drive number (0=A:)
	SI:DI = starting sector number
	DX = number of sectors to read
Return: CF set on error
	    AL = error code (15=invalid drive,21=not ready)
SeeAlso: AX=1509h
---------------------------------------------
INT 2F - Multiplex - CDROM - ABSOLUTE DISK WRITE
	AX = 1509h
	ES:BX -> buffer
	CX = drive number (0=A:)
	SI:DI = starting sector number
	DX = number of sectors to write
Note:	corresponds to INT 26h and is currently reserved and nonfunctional
SeeAlso: AX=1508h
---------------------------------------------
INT 2F - Multiplex - CDROM - RESERVED
	AX = 150Ah
---------------------------------------------
INT 2F - Multiplex - CDROM 2.00 - DRIVE CHECK
	AX = 150Bh
	CX = drive number (0=A:)
Return: BX = ADADh if MSCDEX.EXE installed
	    AX = 0000h if drive not supported
		nonzero if supported
SeeAlso: AX=150Dh
---------------------------------------------
INT 2F - Multiplex - CDROM 2.00 - GET MSCDEX.EXE VERSION
	AX = 150Ch
Return: BH = major version
	BL = minor version
Note:	MSCDEX.EXE versions prior to 1.02 return BX=0
---------------------------------------------
INT 2F - Multiplex - CDROM 2.00 - GET CDROM DRIVE LETTERS
	AX = 150Dh
	ES:BX -> buffer for drive letter list (1 byte per drive)
Return: buffer filled with drive numbers (0=A:).  Each byte corresponds
	to the drive in the same position for function 1501h
SeeAlso: AX=150Bh
---------------------------------------------
INT 2F - Multiplex - CDROM 2.00 - GET/SET VOLUME DESCRIPTOR PREFERENCE
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
---------------------------------------------
INT 2F - Multiplex - CDROM 2.00 - GET DIRECTORY ENTRY
	AX = 150Fh
	CX = drive number (0=A:)
	ES:BX -> ASCIZ path name
	SI:DI -> 255-byte buffer for directory entry
Return: CF set on error
	    AX = error code
	CF clear if succesful
	    AX = disk format (0=High Sierra,1=ISO 9660)

Format of directory entry:
Offset	Size	Description
 00h	BYTE  length of directory entry
 01h	BYTE  length of XAR in LBN's (don't ask me what that means...)
 02h	DWORD LBN of data, Intel (little-endian) format
 06h	DWORD LBN of data, Motorola (big-endian) format
 0Ah	DWORD length of file, Intal format
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
---------------------------------------------
INT 2F - Multiplex - CDROM 2.10 - SEND DEVICE DRIVER REQUEST
	AX = 1510h
	CX = CD-ROM drive letter (0 = A, 1 = B, etc)
	ES:BX -> CD-ROM device driver request header (see AX=0802h)
---------------------------------------------
INT 2F - Multiplex - ???
	AH = 16h
	???
Return: ???
Note:	called by MS Windows
---------------------------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - IDENTIFY WinOldAp VERSION
	AX = 1700h
Return: AX = 1700h if this version of WINOLDAP doesn't support clipboard
	AX <> 1700h
		AL = WINOLDAP major version
		AH = WINOLDAP minor version
Note:	WinOldAp (WINOLDAP.MOD) is a Microsoft Windows extension supporting
	  "old" (character-mode) application access to Dynamic Data Exchange,
	  menus, and the Windows clipboard.
---------------------------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - OPEN CLIPBOARD
	AX = 1701h
Return:	AX <> 0  success
	AX = 0	 clipboard is already open
---------------------------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - EMPTY CLIPBOARD
	AX = 1702h
Return: AX <> 0  clipboard has been emptied
	AX = 0	 failure
---------------------------------------------
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
---------------------------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - GET CLIPBOARD DATA SIZE
	AX = 1704h
	DX = clipboard format supported by WinOldAp (see AX=1703h)
Return:  DX:AX = size of data in bytes, including any headers
Failure: DX:AX = 0  no data in this format in the Clipboard
---------------------------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - GET CLIPBOARD DATA
	AX = 1705h
	DX = clipboard format supported by WinOldAp (see AX=1703h)
	ES:BX -> buffer
Return: AX <> 0  success
	AX = 0	 error, or no data in this format in Clipboard
---------------------------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - CloseClipboard
	AX = 1708h
Return: AX <> 0 success
	AX = 0 failure
---------------------------------------------
INT 2F - Multiplex - MS WINDOWS "WINOLDAP" - COMPACT CLIPBOARD
	AX = 1709h
	SI:CX = desired size in bytes
Return: DX:AX = number of bytes in largest block of free memory
Note:	WinOldAp is responsible for including the size of any headers
---------------------------------------------
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
Return:  AX = integer value of the desired item
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
---------------------------------------------
INT 2F - Multiplex - DOS 4.0 SHELLB.COM - INSTALLATION CHECK
	AX = 1900h
Return: AL = 00h  not installed
	     FFh  installed
---------------------------------------------
INT 2F - Multiplex - DOS 4.0 SHELLB.COM - SHELLC.EXE INTERFACE
	AX = 1901h
	BL = 00h if SHELLC transient
	     01h if SHELLC resident
	DS:DX -> far call entry point for resident SHELLC.EXE
Return: ES:DI -> SHELLC.EXE workspace within SHELLB.COM
Note:	SHELLB.COM and SHELLC.EXE are parts of the DOS 4.x shell
---------------------------------------------
INT 2F - Multiplex - DOS 4.0 SHELLB.COM - COMMAND.COM INTERFACE
	AX = 1902h
	ES:DI -> ASCIZ full filename of current batch file, with at least the
		 final filename element uppercased
	DS:DX -> buffer for results
Return: AL = 00h  failed, either
		  (a) final filename element quoted at ES:DI does not match
		      identity of shell batch file quoted as parameter of most
		      recent call of SHELLB command, or
		  (b) no more Program Start Commands available.
	AL= FFh  success, then:
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
---------------------------------------------
INT 2F - Multiplex - DOS 4.0 SHELLB.COM - COMMAND.COM interface
	AX = 1903h
	ES:DI -> ASCIZ batch file name as for AX=1902h
Return: AL = FFh if quoted batch file name matches last SHELLB parameter
	AL = 00h if it does not
---------------------------------------------
INT 2F - Multiplex - DOS 4.0 SHELLB.COM - SHELLB.COM transient to TSR interface
	AX = 1904h
Return: ES:DI -> name of current shell batch file:
		WORD	number of bytes of name following
		BYTEs	(8 max) uppercase name of shell batch file
---------------------------------------------
INT 2F - Multiplex - DOS 4+ ANSI.SYS internal - INSTALLATION CHECK
	AX = 1A00h
Return: AL = FFh if installed
---------------------------------------------
INT 2F - Multiplex - DOS 4+ ANSI.SYS internal - GET/SET DISPLAY INFORMATION
	AX = 1A01h
	CL = 7Fh for GET
	   = 5Fh for SET
	DS:DX -> parm block as for INT 21,AX=440Ch,CX=037Fh/035Fh respectively
Return: CF set on error
	    AX = error code (many non-standard)
	CF clear if successful
	    AX destroyed
Note:	presumably this is the DOS IOCTL interface to ANSI.SYS
SeeAlso: INT 21/AX=440Ch
---------------------------------------------
INT 2F - Multiplex - DOS 4+ ANSI.SYS internal - MISC REQUESTS
	AX = 1A02h
	DS:DX -> parameter block (see below)


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
---------------------------------------------
INT 2F - Multiplex - DOS 4+ XMA2EMS.SYS extension internal - INSTALLATION CHECK
	AX = 1B00h
Return: AL = FFh if installed
Note:	XMA2EMS.SYS extension is only installed if DOS has page frames to hide.
	This extension hooks onto INT 67 AH=58h and returns from that call data
	  which excludes the physical pages being used by DOS.
SeeAlso: AX=1B01h
---------------------------------------------
INT 2F - Multiplex - DOS 4+ XMA2EMS.SYS extens internal - GET HIDDEN FRAME INFO
	AX = 1B01h
	DI = hidden physical page number
Return: AX = FFFFh if failed (no such hidden page)
	AX = 0000h if OK, then
	     ES = segment of page frame
	     DI = physical page number
Note:	this corresponds to the data edited out of the INT 67 AH=58h call
SeeAlso: AX=1B00h
---------------------------------------------
INT 2F - Multiplex - OS/2 compatibility box - SWITCH DOS TO BACKGROUND
	AX = 4001h
SeeAlso: AX=4002h
---------------------------------------------
INT 2F - Multiplex - OS/2 compatibility box - SWITCH DOS TO FOREGROUND
	AX = 4002h
SeeAlso: AX=4001h
---------------------------------------------
INT 2F - Multiplex - XMS - INSTALLATION CHECK
	AX = 4300h
Return: AL = 80h XMS driver installed
	AL <> 80h no driver
Note:	XMS gives access to extended memory and noncontiguous/nonEMS memory
	  above 640K
SeeAlso: AX=4310h
---------------------------------------------
INT 2F - Multiplex - XMS - GET DRIVER ADDRESS
	AX = 4310h
Return: ES:BX -> driver entry point
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
---------------------------------------------
INT 2F - Multiplex - F-LOCK.EXE 
	AX = 4653h
	CX = 0002h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
	    0002h  ??? (v1.08 and below only)
	    0003h  ??? (v1.08 and below only)
Note:	F-LOCK is part of the F-PROT virus/trojan protection package by Fridrik
	  Skulason
---------------------------------------------
INT 2F - Multiplex - F-XCHK.EXE
	AX = 4653h
	CX = 0003h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
Note:	F-XCHK is part of the F-PROT virus/trojan protection package by Fridrik
	  Skulason
---------------------------------------------
INT 2F - Multiplex - F-POPUP.EXE
	AX = 4653h
	CX = 0004h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
	    0002h  ??? (v1.08 and below only)
	    0003h  ??? (v1.08 and below only)
Note:	F-POPUP is part of the F-PROT virus/trojan protection package by
	  Fridrik Skulason
---------------------------------------------
INT 2F - Multiplex - F-DLOCK.EXE
	AX = 4653h
	CX = 0005h
	BX = subfunction
	    0000h installation check
		Return: AX = FFFFh
	    0001h uninstall
Note:	F-DLOCK is part of the F-PROT virus/trojan protection package by
	  Fridrik Skulason
---------------------------------------------
INT 2F - Multiplex - TesSeRact RAM-RESIDENT PROGRAM INTERFACE
	AX = 5453h
	BX = subfunction
	    00h installation check
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
		    if zeor, buffer contains alternating ASCII and scan codes
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
Note:	Borland's THELP.COM popup help system for Turbo Pascal and Turbo C
	  fully supports the TesSeRact API, as do the SWAP?? programs by 
	  Innovative Data Concepts.

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
11 times:
	DWORD	old interrupt vector
	BYTE	interrupt number
	DWORD	new interrupt vector
---------------------------------------------
INT 2F - Multiplex - SCRNSAV2.COM - INSTALLATION CHECK
	AX = 6400h
Return: AL = 00h not installed
	     FFh installed
Note:	SCRNSAV2.COM is a screen saver for PS/2's with VGA by Alan Ballard
---------------------------------------------
INT 2F - Multiplex - Novell NetWare - LOW-LEVEL API (IPX) INSTALLATION CHECK
	AX = 7A00h
Return: AL = 00h not installed
	   = FFh installed
		ES:DI -> FAR entry point for routines otherwise accessed
			 through INT 7Ah
---------------------------------------------
INT 2F - Multiplex - EASY-NET - INSTALLATION CHECK
	AX = 8000h
Return: AL = 00h not installed
	     FFh installed
Note:	EASY-NET is a shareware two-machine serial-port network
---------------------------------------------
INT 2F - Multiplex - WHOA!.COM - INSTALLATION CHECK
	AX = 8900h
Return: AL = 00h not installed
	   = FFh installed
Note:	WHOA!.COM is a system slow-down utility by Brad D Crandall
---------------------------------------------
INT 2F - Multiplex - WHOA!.COM - UNINSTALL
	AX = 8901h
Return: AL = FDh successful
	   = FEh error
Note:	WHOA!.COM is a system slow-down utility by Brad D Crandall
---------------------------------------------
INT 2F - Multiplex - WHOA!.COM - SET DELAY COUNT
	AX = 8902h
	BX = delay count (larger values slow system down more)
Return: AL = FDh successful
	   = FEh error
Note:	WHOA!.COM is a system slow-down utility by Brad D Crandall
---------------------------------------------
INT 2F - Multiplex - RAID - ???
	AH = 90h
	???
Return: ???
Note:	RAID is a TSR utility program that resides mostly in EMS
---------------------------------------------
INT 2F - Multiplex - VIDCLOCK.COM - INSTALLATION CHECK
	AX = AA00h
Return: AL = 00h not installed
	     FFh installed
Note:	VIDCLOCK.COM is a memory-resident clock by Thomas G. Hanlin III
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ DISPLAY.SYS internal - INSTALLATION CHECK
	AX = AD00h
Return: AL = FFh if installed
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ DISPLAY.SYS internal - ???
	AX = AD01h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ DISPLAY.SYS internal - ???
	AX = AD02h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ DISPLAY.SYSinternal - ???
	AX = AD03h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - DOS 4+ DISPLAY.SYS internal - ???
	AX = AD10h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ KEYB.COM internal - INSTALLATION CHECK
	AX = AD80h
Return: AL = FFh if installed
	ES:DI -> internal data
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ KEYB.COM internal - ???
	AX = AD81h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ KEYB.COM internal - ???
	AX = AD82h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ internal - INSTALLABLE COMMAND - INSTALL CHECK
	AX = AE00h
	DX = FFFFh ???
	DS:BX -> command line
Return: AL = FFh if this command is a TSR extension to COMMAND.COM
	AL = 00h if the command should be executed as usual
Notes:	This apparently provides a mechanism for TSRs to install permanent
	  extensions to the command repertoire of COMMAND.COM.	It appears that
	  COMMAND.COM makes this call before executing the current command
	  line,	and does not execute it itself if the return is FFh.
	APPEND hooks this call

Format of command line:
Offset	Size	Description
 00h	BYTE	??? (max length of command line, as in INT 21/AH=0Ah ???)
 01h	BYTE	count of bytes to follow
      N BYTEs	command line text, terminated by 0Dh
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ internal - INSTALLABLE COMMAND - EXECUTE
	AX = AE01h
	DX = FFFFh ???
	DS:SI -> a word to be written to
Return: the word at DS:SI is set to ???
Notes:	this call requests execution of the command which a previous call to
	  AX=AE00h indicated was resident
	APPEND hooks this call
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ GRAFTABL.COM - INSTALLATION CHECK
	AX = B000h
Return: AL = 00h not installed, OK to install
	   = 01h not installed, not OK to install
	   = FFh installed
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ GRAFTABL.COM - GET ???
	AX = B001h
	DS:DX -> 4-byte buffer (see below)
Return: buffer filled
	AL = FFh

Format of buffer:
Offset	Size	Description
 00h	WORD	??? (PCDOS 3.30 fills in 0130h, MSDOS 3.30 fills in 0030h)
 02h	WORD	CS of resident code
---------------------------------------------
INT 2F - Multiplex - IBM PC3270 EMUL PROG v3 - INSTALLATION CHECK
	AX = B400h
Return: AL = FFh if installed
---------------------------------------------
INT 2F - Multiplex - IBM PC3270 EMUL PROG v3 - GET HOST BUFFER ADDRESS
	AX = B401h
Return: ES -> host screen buffer (PC ASCII format)
	ES unchanged if communications not started
---------------------------------------------
INT 2F - Multiplex - IBM PC3270 EMUL PROG v3 - ???
	AX = B402h
	BX = ???
Return: ???
---------------------------------------------
INT 2F - Multiplex - IBM PC3270 EMUL PROG v3 - ???
	AX = B403h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - IBM PC3270 EMUL PROG v3 - ???
	AX = B404h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - IBM PC3270 EMUL PROG v3 - ???
	AX = B405h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - APPEND - INSTALLATION CHECK
	AX = B700h
Return: AL = 00h not installed
	     FFh if installed
Note:	MSDOS 3.30 APPEND refuses to install itself when run inside TopView or
	  a TopView-compatible environment
---------------------------------------------
INT 2F - Multiplex - APPEND - ???
	AX = B701h
	???
---------------------------------------------
INT 2F - Multiplex - APPEND - VERSION CHECK
	AX = B702h
Return: AX = FFFFh if not DOS 4.0 APPEND
	AL = major version number
	AH = minor version number, otherwise
---------------------------------------------
INT 2F - Multiplex - DOS 3.3 APPEND - ???
	AX = B703h
	ES:DI -> ???
Return: ES:DI -> routine to ???
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ APPEND - GET APPEND PATH
	AX = B704h
Return: ES:DI -> active APPEND path (128 bytes max)
---------------------------------------------
INT 2F - Multiplex - DOS 4.0 APPEND - GET APPEND FUNCTION STATE
	AX = B706h
Return: BX = APPEND state
	    bit 0: set if APPEND enabled
	    bits 1-12 reserved
	    bit 13: set if /PATH flag active
	    bit 14: set if /E flag active (environment var APPEND exists)
	    bit 15: set if /X flag active
---------------------------------------------
INT 2F - Multiplex - DOS 4.0 APPEND - SET APPEND FUNCTION STATE
	AX = B707h
	BX = APPEND state bits (see AX=B706h)
---------------------------------------------
INT 2F - Multiplex - DOS 3.3 APPEND - GET VERSION INFO
	AX = B710h
Return: AX = ???
	BX = ??? (0000h in MSDOS 3.30)
	CX = ??? (0000h in MSDOS 3.30)
	DL = major version
	DH = minor version
---------------------------------------------
INT 2F - Multiplex - DOS 4.0 APPEND - SET RETURN FOUND NAME STATE
	AX = B711h
Note:	if the next INT 21h call (and ONLY the next) is function 3Dh, 43h, or
	6Ch, the fully qualified filename is written over top of the filename
	passed to the INT 21h call.  The application must provide a 
	sufficiently large buffer.  This state is reset after next INT 21h
	call processed by APPEND.
---------------------------------------------
INT 2F - Multiplex - Network - INSTALLATION CHECK
	AX = B800h
Return: AH = 00h not installed
	    nonzero installed
	      BX = installed component flags (test in this order!)
		   bit 6   server
		   bit 2   messenger
		   bit 7   receiver
		   bit 3   redirector
---------------------------------------------
INT 2F - Multiplex - Network - GET CURRENT POST ADDRESS
	AX = B803h
Return: ES:BX = post address
SeeAlso: AX=B804h,B903h
---------------------------------------------
INT 2F - Multiplex - Network - SET NEW POST ADDRESS
	AX = B804h
	ES:BX = new post address
SeeAlso: AX=B803h,B904h
---------------------------------------------
INT 2F - Multiplex - Network - Get NetBIOS NAME NUMBER OF MACHINE NAME
	AX = B807h
Return: CH = NetBIOS name number of the machine name
SeeAlso: INT 21/AX=5E00h
---------------------------------------------
INT 2F - Multiplex - Network - ???
	AX = B808h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - LANtastic Network - VERSION CHECK
	AX = B809h
Return: AH = major version
	AL = minor version
---------------------------------------------
INT 2F - PC Network RECEIVER.COM - INSTALLATION CHECK
	AX = B900h
Return: AL = 00h if not installed
	     FFh if installed
---------------------------------------------
INT 2F - PC Network RECEIVER.COM - GET RECEIVER.COM INT 2F HANDLER ADDRESS
	AX = B901h
Return: AL = ???
	ES:BX -> RECEIVER.COM INT 2F handler
Note:	allows more efficient execution by letting the caller bypass any other
	  INT 2F handlers which have been added since RECEIVER.COM was
	  installed
---------------------------------------------
INT 2F - PC Network RECEIVER.COM - GET RECEIVER.COM POST ADDRESS
	AX = B903h
Return: ES:BX -> POST handler
SeeAlso: AX=B803h,B904h
---------------------------------------------
INT 2F - PC Network RECEIVER.COM - SET RECEIVER.COM POST ADDRESS
	AX = B904h
	ES:BX -> new POST handler
SeeAlso: AX=B804h,B903h
---------------------------------------------
INT 2F - PC Network RECEIVER.COM - GET FILENAME
	AX = B905h
	DS:BX -> 128-byte buffer for filename 1
	DS:DX -> 128-byte buffer for filename 2
Return: buffers filled from RECEIVER.COM internal buffers
Note:	use of filenames is unknown, but one appears to be for storing messages
SeeAlso: AX=B906h
---------------------------------------------
INT 2F - PC Network RECEIVER.COM - SET FILENAME
	AX = B906h
	DS:BX -> 128-byte buffer for filename 1
	DS:DX -> 128-byte buffer for filename 2
Return: RECEIVER.COM internal buffers filled from user buffers
Note:	use of filenames is unknown, but one appears to be for storing messages
SeeAlso: AX=B905h
---------------------------------------------
INT 2F - PC Network RECEIVER.COM - UNLINK KEYBOARD HANDLER
	AX = B908h
	ES:BX -> INT 09 handler RECEIVER should call after it finishes INT 09
Note:	this call replaces the address to which RECEIVER.COM chains on an
	  INT 09 without preserving the original value.  This allows a prior
	  handler to unlink, but does not allow a new handler to be added
	  such that RECEIVER gets the INT 09 first.
---------------------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIRIFS.EXE internal - INSTALLATION CHECK
	AX = BF00h
Return: AL = FFh if installed
---------------------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIRIFS.EXE internal - ???
	AX = BF01h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - PC LAN PROG REDIR.SYS internal - SET REDIRIFS ENTRY POINT
	AX = BF80h
	ES:DI -> FAR entry point to IFS handler in REDIRIFS
Return: AL = FFh if installed
	    ES:DI -> internal workspace
Note:	all future IFS calls to REDIR.SYS are passed to the ES:DI entry point
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - INSTALLATION CHECK
	AX = CB00h
Return: AL = 00h not installed, OK to install
	     01h not installed, not OK to install
	     FFh installed
Note:	AH = CBh is the default identifier, but may be reconfigured
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - SUBMIT A TASK
	AX = CB01h
	DS:DX -> ASCIZ name of task control file
Return: AX >= 0: event handle
	   < 0: error code
Note:	files needed for an event must be kept until task is complete or error

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
	Subcode 03h	other FAX machine incompatible
		5Eh	other FAX machine jammed
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - ABORT CURRENT EVENT
	AX = CB02h
Return: AX >= 0: event handle of aborted event (>= 0)
	   < 0: error code (see AX=CB01h)
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - FIND FIRST QUEUE ENTRY
	AX = CB05h
	CX = status of events to find
	    0000h successful completion
	    0001h waiting to be processed
	    0002h number has been dialed
	    0003h connection established, sending
	    0004h connection established, receiving
	    0005h even aborted
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
---------------------------------------------
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
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - OPEN FILE
	AX = CB07h
	BX = event handle
	CX = receive file number (ignored for task queue and log queue)
	    0000h  open receive control file
	    N	   open Nth received data file
	DL = queue
	    00h task queue
	    01h receive queue control file or received file, as given by CX
	    02h log queue
Return: AX = 0000h successful
	    BX = DOS file handle for requested file
	   < 0	   error code (see AX=CB01h)
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - DELETE FILE
	AX = CB08h
	BX = event handle
	CX = receive file number
	    0000h delete ALL received files and receive control file
	    N	  delete Nth received file
	DL = queue
	    00h delete control file in task queue
	    01h delete file in receive queue, as given by CX
	    02h delete control file in log queue (individual deletions not
		recommended, to maintain integrity of log)
Return: AX = 0000h successful
	   < 0	   error code (see AX=CB01h)
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - DELETE ALL FILES IN Q
	AX = CB09h
	DL = queue
	    00h delete all control files in task queue
	    01h delete all files in receive queue
	    02h delete all control files in log queue
Return: AX = 0000h successful
	   < 0	   error code (see AX=CB01h)
---------------------------------------------
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
---------------------------------------------
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
---------------------------------------------
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
---------------------------------------------
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
---------------------------------------------
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
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - GET/SET AUTORECEIVE
	AX = CB0Fh
	DL = subfunction
	    00h get current autoreceive state
	    01h set autoreceive state
		DH = number of rings before answer, 00h = never
Return: AX = 0000h autoreceive disabled
	   = N	   number of rings before answer
	   < 0	   error code (see AX=CB01h)
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - GET EVENT STATUS
	AX = CB10h
	DS:DX -> 511-byte buffer
Return: AX = 0000h successful
		BX = event handle of current event
		buffer filled
	   < 0	   error code (see AX=CB01h)

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
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - GET QUEUE STATUS
	AX = CB11h
	DL = queue to get status of
	    00h task queue
	    01h receive queue
	    02h log queue
Return: AX >= 0  total number of changes made to queue, modulo 32768
		BX = number of control files currently in queue
		CX = number of received files (zero for task and log queues)
	   < 0	 error code (see AX=CB01h)
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - GET HARDWARE STATUS
	AX = CB12h
	DS:DX -> 128-byte status buffer
Return: AX = 0000h successful
		buffer filled with hardware-dependent status information
	   < 0	   error code (see AX=CB01h)

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
			000 = 300 baud (SDLC mode)
			100 = 2400 baud
			101 = 4800 baud
			110 = 7200 baud
			111 = 9600 baud
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
 0Eh	WORD	error count
 10h	DWORD	size of nonstandard format (NSF) file in bytes
 14h 10 BYTEs	reserved
 1Eh 21 BYTEs	ASCIZ CCITT identification
 33h 77 BYTEs	reserved
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - GET DIAGNOSTICS RESULTS
	AX = CB13h
	DL = 00h
Return: AX = 0040h in progress
	   > 0	   passed
	   < 0	   failure code
Note:	diagnostics return values are hardware dependent

Intel Connection CoProcessor failure codes:
	bit 3: 9600 bps FAX modem module failed
	bit 2: SDLC chip failed
	bit 1: RAM failed
	bit 0: ROM checksum failed
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - START DIAGNOSTICS
	AX = CB13h
	DL = 01h
Return: AX = 0000h successfully started
	   < 0	   error code (see AX=CB01h)
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - MOVE RECEIVED FILE
	AX = CB14h
	BX = event handle
	CX = receive file number
	     0001h first received file
	     N	   Nth received file
	DS:DX -> ASCIZ string specifying new name for file
Return: AX = 0000h successful
	   < 0	   error code (see AX=CB01h)
---------------------------------------------
INT 2F - Multiplex - Communicating Applications Spec - SUBMIT FILE TO SEND
	AX = CB15h
	DS:DX -> variable-length data area
Return: AX >= 0	event handle
	   < 0	error code (see AX=CB01h)

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
---------------------------------------------
INT 2F - Multiplex - Intel Image Processing Interface - INSTALLATION CHECK
	AX = CD00h
Return: AL = 00h not installed, OK to install
	     01h not installed, not OK to install
	     FFh installed
---------------------------------------------
INT 2F - Multiplex - SWELL.EXE - INSTALLATION CHECK
	AX = CD00h
Return: AX = 00FFh installed
	    BH = major version
	    BL = minor version
Note:	SWELL.EXE is a TSR which swaps programs to disk when they EXEC a child
	  process with INT 21/AH=4Bh
---------------------------------------------
INT 2F - Multiplex - Intel Image Processing Interface - SET DEVICE NAME
	AX = CD01h
	CX:BX -> ASCIZ character device name ("LPTn", "COMn", "PRN")
Return: AL = 00h successful
		CX:BX -> internal character device name
	   = 80h error
---------------------------------------------
INT 2F - Multiplex - SWELL.EXE - SUSPEND ONCE
	AX = CD01h
Return: AX = 0000h
---------------------------------------------
INT 2F - Multiplex - Intel Image Processing Interface - GET VERSION NUMBER
	AX = CD02h
Return: AL = 00h/01h successful
		BH = major version number (BCD)
		BL = minor version number (BCD)
	   = 80h error
Note:	if return AL = 01h, the IPI supports network redirection
---------------------------------------------
INT 2F - Multiplex - SWELL.EXE - SUSPEND
	AX = CD02h
Return: AX = 0000h
---------------------------------------------
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
---------------------------------------------
INT 2F - Multiplex - SWELL.EXE - ACTIVATE
	AX = CD03h
Return: AX = 0000h
---------------------------------------------
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
---------------------------------------------
INT 2F - Multiplex - SWELL.EXE - TURN OFF VERBOSE MODE
	AX = CD04h
Return: AX = 0000h
---------------------------------------------
INT 2F - Multiplex - Intel Image Processing Interface - PRINT PAGE
	AX = CD05h
Return: AL = 00h successful
	   = 80h unsuccessful
Note:	page image is retained, so multiple calls will print multiple copies of
	  the page
---------------------------------------------
INT 2F - Multiplex - SWELL.EXE - TURN ON VERBOSE MODE
	AX = CD05h
Return: AX = 0000h
---------------------------------------------
INT 2F - Multiplex - Intel Image Processing Interface - CLEAR PAGE
	AX = CD06h
Return: AL = 00h successful
	   = 80h unsuccessful
Note:	palette is reset to default
---------------------------------------------
INT 2F - Multiplex - SWELL.EXE - UNINSTALL
	AX = CD06h
Return: AX = 0000h uninstalled
	   = 8002h programs still swapped, not uninstalled
---------------------------------------------
INT 2F - Multiplex - Intel Image Processing Interface - reserved
	AX = CD07h
---------------------------------------------
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
---------------------------------------------
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
---------------------------------------------
INT 2F - Multiplex - SWELL.EXE - UNUSED
	AX = CD08h
Return: AX = FFFFh (error)
---------------------------------------------
INT 2F - Multiplex - Intel Image Processing Interface - LOAD SCREEN
	AX = CD09h
	CX:BX -> structure (see below)
Return: AL = 00h successful
	   = 80h unsuccessful

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
---------------------------------------------
INT 2F - Multiplex - SWELL.EXE - TURN OFF "BORLAND SUPPORT"
	AX = CD09h
Return: AX = 0000h
---------------------------------------------
INT 2F - Multiplex - Intel Image Processing Interface - LOAD PALETTE
	AX = CD0Ah
	CX:BX -> palette structure (see below)
Return: AL = 00h successful
	   = 80h unsuccessful

Format of palette structure:
Offset	Size	Description
 00h	BYTE	bits per pixel for which palette is to be used (1,2,4,6, or 8)
 01h	2**N	palette translation values, one per possible pixel value
---------------------------------------------
INT 2F - Multiplex - SWELL.EXE - TURN ON "BORLAND SUPPORT"
	AX = CD0Ah
Return: AX = 0000h
---------------------------------------------
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
	    01h (internal) terminate current copy of 4DOS
	    02h ???
		DX = ???
	    03h EXEC program
		CX:DX -> EXEC record
	    FEh deallocate shell number (passed through to root shell)
		???
	    FFh allocate shell number (passed through to root shell)
Note:	bug in v3.00 will crash system if unrecognized value in BH

Format of EXEC record:
Offset	Size	Description
 00h	WORD	offset of ASCIZ program name in same segment as EXEC record
 02h	WORD	offset of DOS commandline in same segment as EXEC record
 04h	WORD	segment of environment for child process (see INT 21/AH=26h)
---------------------------------------------
INT 2F - Multiplex - 4DOS.COM v3.0 - AWAITING USER INPUT
	AX = D44Eh
Return: handler must preserve SI, DI, BP, SP, DS, ES, and SS
Note:	called by 4DOS immediately after displaying the prompt and before
	  accepting user input
---------------------------------------------
INT 2F - Multiplex - BANYAN VINES v4+ - GET BANV INTERRUPT NUMBER
	AX = D701h
Return: AX = 0000h installed
	    BX = interrupt number (60h to 66h)
	   nonzero not present
---------------------------------------------
INT 2F - Multiplex - DESQview 2.26 - INSTALLATION CHECK
	AX = DE00h
	BX = 4445h ("DE")
	CX = 5844h
	DX = 4931h
Return: AL = FFh if installed
	    BX = 4845h
	    CX = 5245h
	    DX = 4456h ("DV")
---------------------------------------------
INT 2F - Multiplex - DESQview 2.26 - ???
	AX = DE01h
	BX = FFFEh
	CX = 4D47h
	DX = 0052h
Return: AL = FFh
	DX = 584Dh ??? may be variable
---------------------------------------------
INT 2F - Multiplex - DESQview 2.26 - ???
	AX = DE02h
	???
Note:	passed on to previous handler
---------------------------------------------
INT 2F - Multiplex - DESQview 2.26 - ???
	AX = DE03h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - DESQview 2.26 - ???
	AX = DE04h
	???
Return: ???
Note:	calls INT 15/AX=1119h/BX=0016h, if that returns AX=0000h makes a Get
	  Current Map call (INT 15/AX=1117h/BX=0000h) and does some work on
	  a 16-byte structure
SeeAlso: AX=DE05h
---------------------------------------------
INT 2F - Multiplex - DESQview 2.26 - ???
	AX = DE05h
	???
Return: ???
Note:	apparently works on same structure as AX=DE04h, conditionally calls
	INT 15/AX=111Ah
SeeAlso: AX=DE04h
---------------------------------------------
INT 2F - Multiplex - ANARKEY.COM - INSTALLATION CHECK
	AX = E300h
Return: AL = 00h not installed
	     FEh if installed but suspended (v3.0+)
	     FFh installed
Notes:	ANARKEY.COM is a commandline recall program by Steven Calwas
	E3h is the default function number, but can be set to any value from
	  C0h to FFh.
---------------------------------------------
INT 2F - Multiplex - ANARKEY.COM v2+ - GET ???
	AX = E301h
Return: DX:BX -> ???
Note:	ANARKEY.COM is a commandline recall program by Steven Calwas

Format of returned data structure for ANARKEY v2.0:
Offset	Size	Description
 -7   7 BYTEs	signature ('ANARKEY')
 00h	WORD	??? (I see 0001h in v2.0)
 02h	WORD	??? (I see 0001h in v2.0)
 04h	WORD	??? (I see 0 in v2.0)
 06h	WORD	PSP segment of next program loaded

Format of returned data structure for ANARKEY v3.0:
Offset	Size	Description
 -1	BYTE	multiplex number
 00h	WORD	??? (I see 0001h in v3.0)
 02h	WORD	??? (I see 0001h in v3.0)
 04h	BYTE	??? (I see 0 in v3.0)
 05h	WORD	PSP segment of next program loaded
---------------------------------------------
INT 2F - Multiplex - ANARKEY.COM v3.0 - ???
	AX = E302h
	BL = ???
Return: ???
Note:	ANARKEY.COM is a commandline recall program by Steven Calwas
---------------------------------------------
INT 2F - Multiplex - ANARKEY.COM v3.0 - ANARKMD API
	AX = E303h
	BL = function
	    01h  toggle insert mode
	    02h  display contents of history buffer
	    03h  write history buffer to file
		ES:DX -> file name
	    04h  clear history buffer
	    05h  undefine all aliases
	    06h  show aliases
	    07h	 list programs using Unix switchar
	    08h	 jump to bottom of history buffer	
Return: ???
Note:	ANARKEY.COM is a commandline recall program by Steven Calwas
---------------------------------------------
INT 2F - Multiplex - ANARKEY.COM v2.0 - ???
	AX = E304h
	BL = ???
Return: ???
Note:	ANARKEY.COM is a commandline recall program by Steven Calwas
---------------------------------------------
INT 2F - Multiplex - ANARKEY.COM v3.0 - SUSPEND ANARKEY
	AX = E305h
	BL = 01h suspend
	     00h enable
Note:	ANARKEY.COM is a commandline recall program by Steven Calwas
---------------------------------------------
INT 2F - Multiplex - AUTOPARK.COM - INSTALLATION CHECK
	AX = F700h
Return: AL = 00h not installed
	     FFh installed
Note:	AUTOPARK.COM is a resident hard disk parker by Alan D. Jones
---------------------------------------------
INT 2F - Multiplex - AUTOPARK.COM - SET PARKING DELAY
	AX = F701h
	BX:CX = 32 bit count of 55ms timer ticks
---------------------------------------------
INT 30 - (NOT A VECTOR!) FAR JMP instruction for CP/M-style calls
	 the CALL 5 entry point does a FAR jump to here
SeeAlso: INT 21/AH=26h
---------------------------------------------
INT 31 - overwritten by CP/M jump instruction in INT 30
---------------------------------------------
INT 32 - reserved
---------------------------------------------
INT 33 - MS MOUSE - RESET DRIVER AND READ STATUS
	AX = 0000h
Return: AX = status
	    0000h  hardware/driver not installed
	    FFFFh hardware/driver installed
	BX = number of buttons
	    FFFFh two buttons
	    0000h  other than two
	    0003h  Mouse Systems mouse
Note:	to use mouse on a Hercules-compatible monographics card in graphics
	  mode, you must first set 0040h:0049h to 6 for page 0 or 5 for page 1,
	  and then call this function.
---------------------------------------------
INT 33 - MS MOUSE - SHOW MOUSE CURSOR
	AX = 0001h
---------------------------------------------
INT 33 - MS MOUSE - HIDE MOUSE CURSOR
	AX = 0002h
Note:	multiple calls to hide the cursor will require multiple calls to
	  function 01h to unhide it.
---------------------------------------------
INT 33 - MS MOUSE - RETURN POSITION AND BUTTON STATUS
	AX = 0003h
Return: BX = button status
	   bit 0  left button pressed if 1
	   bit 1  right button pressed if 1
	   bit 2  middle button pressed if 1 (Mouse Systems mouse)
	CX = column
	DX = row
---------------------------------------------
INT 33 - MS MOUSE - POSITION MOUSE CURSOR
	AX = 0004h
	CX = column
	DX = row
Note:	the row and column are truncated to the next lower multiple of the cell
	  size; however, some versions of the Microsoft documentation
	  incorrectly state that the coordinates are rounded
---------------------------------------------
INT 33 - MS MOUSE - RETURN BUTTON PRESS DATA
	AX = 0005h
	BX = button
	    0000h left
	    0001h right
	    0002h middle (Mouse Systems mouse)
Return: AX = button states
	    bit 0 left button pressed if 1
	    bit 1 right button pressed if 1
	    bit 2 middle button pressed if 1 (Mouse Systems mouse)
	BX = number of times specified button has been pressed since last call
	CX = column at time specified button was last pressed
	DX = row at time specified button was last pressed
---------------------------------------------
INT 33 - MS MOUSE - RETURN BUTTON RELEASE DATA
	AX = 0006h
	BX = button
	    0000h left
	    0001h right
	    0002h middle (Mouse Systems mouse)
Return: AX = button states
	    bit 0 left button pressed if 1
	    bit 1 right button pressed if 1
	    bit 2 middle button pressed if 1 (Mouse Systems mouse)
	BX = number of times specified button has been released since last call
	CX = column at time specified button was last released
	DX = row at time specified button was last released
---------------------------------------------
INT 33 - MS MOUSE - DEFINE HORIZONTAL CURSOR RANGE
	AX = 0007h
	CX = minimum column
	DX = maximum column
---------------------------------------------
INT 33 - MS MOUSE - DEFINE VERTICAL CURSOR RANGE
	AX = 0008h
	CX = minimum row
	DX = maximum row
---------------------------------------------
INT 33 - MS MOUSE - DEFINE GRAPHICS CURSOR
	AX = 0009h
	BX = column of cursor hot spot in bitmap (-16 to 16)
	CX = row of cursor hot spot (-16 to 16)
	ES:DX -> bitmap
		16 words screen mask
		16 words cursor mask
		    each word defines the sixteen pixels of a row, low bit
		    rightmost
---------------------------------------------
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
---------------------------------------------
INT 33 - MS MOUSE - READ MOTION COUNTERS
	AX = 000Bh
Return: CX = number of mickeys mouse moved horizontally since last call
	DX = number of mickeys mouse moved vertically
Notes:	a mickey is the smallest increment the mouse can sense
	positive values indicate down/right
---------------------------------------------
INT 33 - MS MOUSE - DEFINE INTERRUPT SUBROUTINE PARAMETERS
	AX = 000Ch
	CX = call mask
	     bit 0 call if mouse moves
	     bit 1 call if left button pressed
	     bit 2 call if left button released
	     bit 3 call if right button pressed
	     bit 4 call if right button released
	     bit 5 call if middle button pressed (Mouse Systems mouse)
	     bit 6 call if middle button released (Mouse Systems mouse)
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
---------------------------------------------
INT 33 - MS MOUSE - LIGHT PEN EMULATION ON
	AX = 000Dh
---------------------------------------------
INT 33 - MS MOUSE - LIGHT PEN EMULATION OFF
	AX = 000Eh
---------------------------------------------
INT 33 - MS MOUSE - DEFINE MICKEY/PIXEL RATIO
	AX = 000Fh
	CX = number of mickeys per 8 pixels horizontally (default 8)
	DX = number of mickeys per 8 pixels vertically (default 16)
---------------------------------------------
INT 33 - MS MOUSE - DEFINE SCREEN REGION FOR UPDATING
	AX = 0010h
	CX,DX = X,Y coordinates of upper left corner
	SI,DI = X,Y coordinates of lower right corner
Note:	mouse cursor is hidden during updating, and needs to be explicitly
	  turned on again
---------------------------------------------
INT 33 - PCMOUSE - SET LARGE GRAPHICS CURSOR BLOCK
	AX = 0012h
	BH = cursor width in words
	CH = rows in cursor
	BL = horizontal hot spot (-16 to 16)
	CL = vertical hot spot (-16 to 16)
	ES:DX -> bit map of screen and cursor maps
Return: AX = -1 if successful
---------------------------------------------
INT 33 - MS MOUSE - DEFINE DOUBLE-SPEED THRESHOLD
	AX = 0013h
	DX = threshold speed in mickeys/second, 0000h = default of 64/second
Note:	if speed exceeds threshold, the cursor's on-screen motion is doubled
---------------------------------------------
INT 33 - MS MOUSE - EXCHANGE INTERRUPT SUBROUTINES
	AX = 0014h
	CX = call mask (see AX=000Ch)
	ES:DX -> FAR routine 
Return: CX = call mask of previous interrupt routine
	ES:DX = FAR address of previous interrupt routine
---------------------------------------------
INT 33 - MS MOUSE - RETURN DRIVER STORAGE REQUIREMENTS
	AX = 0015h
Return: BX = size of buffer needed to store driver state
---------------------------------------------
INT 33 - MS MOUSE - SAVE DRIVER STATE
	AX = 0016h
	ES:DX -> buffer for driver state
---------------------------------------------
INT 33 - MS MOUSE - RESTORE DRIVER STATE
	AX = 0017h
	ES:DX -> buffer containing saved state
---------------------------------------------
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
	BX(???):DX = address of FAR routine
Notes:	when the subroutine is called, it is passed the following values:
	  AX = condition mask (same bit assignments as call mask)
	  BX = button state
	  CX = cursor column
	  DX = cursor row
	  DI = horizontal mickey count
	  SI = vertical mickey count
	up to three handlers can be defined by separate calls to this function
---------------------------------------------
INT 33 - MS MOUSE - RETURN USER ALTERNATE INTERRUPT VECTOR
	AX = 0019h
	CX = call mask
Return: BX:DX = user interrupt vector
	CX = call mask (0 if not found)
Note:	attempts to find a user event handler (defined by function 18h)
	  whose call mask matches CX
---------------------------------------------
INT 33 - MS MOUSE - SET MOUSE SENSITIVITY
	AX = 001Ah
	BX = horizontal speed \
	CX = vertical speed   / (see AX=000Fh)
	DX = double speed threshold (see AX=0013h)
---------------------------------------------
INT 33 - MS MOUSE - RETURN MOUSE SENSITIVITY
	AX = 001Bh
Return: BX = horizontal speed
	CX = vertical speed
	DX = double speed threshold
---------------------------------------------
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
---------------------------------------------
INT 33 - MS MOUSE - DEFINE DISPLAY PAGE NUMBER
	AX = 001Dh
	BX = display page number
Note:	the cursor will be displayed on the specified page
---------------------------------------------
INT 33 - MS MOUSE - RETURN DISPLAY PAGE NUMBER
	AX = 001Eh
Return: BX = display page number
---------------------------------------------
INT 33 - MS MOUSE - DISABLE MOUSE DRIVER
	AX = 001Fh
Return: AX = 001Fh successful
	     FFFFh unsuccessful
	ES:BX = vector for Int 33h before mouse driver was first installed
Note:	restores vectors for Int 10h and Int 71h (8086) or Int 74h (286/386)
	if you restore Int 33h to ES:BX, driver will be completely disabled
---------------------------------------------
INT 33 - MS MOUSE - ENABLE MOUSE DRIVER
	AX = 0020h
Note:	restores vectors for Int 10h and Int 71h (8086) or Int 74h (286/386)
	  which were removed by function 1Fh
---------------------------------------------
INT 33 - MS MOUSE - SOFTWARE RESET
	AX = 0021h
Return: AX = FFFFh if mouse driver installed
	     0021h if mouse driver not installed
	BX = 2 if mouse driver is installed
Note:	identical to funtion 00h, but does not reset the mouse
---------------------------------------------
INT 33 - MS MOUSE - SET LANGUAGE FOR MESSAGES
	AX = 0022h
	BX = language
	    0  English
	    1  French
	    2  Dutch
	    3  German
	    4  Swedish
	    5  Finnish
	    6  Spanish
	    7  Portugese
	    8  Italian
Note:	only available on internation version of the driver, US versions ignore
	  this call
---------------------------------------------
INT 33 - MS MOUSE - GET LANGUAGE FOR MESSAGES
	AX = 0023h
Return:	BX = language (see AX=0022h)
Note:	the US version of the driver always returns zero 
---------------------------------------------
INT 33 - MS MOUSE - GET SOFTWARE VERSION AND MOUSE TYPE
	AX = 0024h
Return: AX = FFFFh on error
	otherwise,
	    BH = major version
	    BL = minor version
	    CH = type (1=bus, 2=serial, 3=InPort, 4=PS/2, 5=HP)
	    CL = interrupt (0=PS/2, 2=IRQ2, 3=IRQ3,...,7=IRQ7)
---------------------------------------------
INT 33 - PCMOUSE - GET MSMOUSE STORAGE REQUIREMENTS
	AX = 0042h
Return: AX = FFFFh successful
		BX = buffer size in bytes for functions 50h and 52h
	   = 0000h MSMOUSE not installed
	   = 0042h functions 42h, 50h, and 52h not supported
---------------------------------------------
INT 33 - PCMOUSE - SAVE MSMOUSE STATE
	AX = 0050h
	BX = buffer size
	ES:DX -> buffer
Return: AX = FFFFh if successful
---------------------------------------------
INT 33 - PCMOUSE - RESTORE MSMOUSE STATE
	AX = 0052h
	BX = buffer size
	ES:DX -> buffer
Return: AX = FFFFh if successful
---------------------------------------------
INT 34 - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode D8h
---------------------------------------------
INT 35 - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode D9h
---------------------------------------------
INT 36 - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode DAh
---------------------------------------------
INT 37 - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode DBh
---------------------------------------------
INT 38 - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode DCh
---------------------------------------------
INT 39 - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode DDh
---------------------------------------------
INT 3A - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode DEh
---------------------------------------------
INT 3B - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates opcode DFh
---------------------------------------------
INT 3C - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates instructions with an ES segment override
---------------------------------------------
INT 3D - Borland/Microsoft languages - Floating Point emulation
	This interrupt emulates a standalone FWAIT instruction
---------------------------------------------
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
 F0h	arctangent
 F2h	check TOS value
 F4h	Ln (FLDLN2 to TOS)
 F6h	FLD1 to TOS
 F8h	FLDLG2 to TOS
 FAh	Exp (FLDL2E to TOS)
 FCh	TOS = 2**TOS
 FEh	FLDL2T to TOS
---------------------------------------------
INT 3F - Overlay manager interrupt (Microsoft LINK.EXE)
---------------------------------------------
INT 3F - Microsoft Dynamic Link Library manager
---------------------------------------------
