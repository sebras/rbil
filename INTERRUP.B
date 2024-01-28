Interrupt List, part 2 of 15
Copyright (c) 1989,1990,1991,1992,1993,1994,1995,1996 Ralf Brown
--------B-1310-------------------------------
INT 13 - HARD DISK - CHECK IF DRIVE READY
	AH = 10h
	DL = drive number (80h = first, 81h = second hard disk)
Return: CF set on error
	CF clear if successful
	AH = status (see #0142 at AH=01h)
--------B-1311-------------------------------
INT 13 - HARD DISK - RECALIBRATE DRIVE
	AH = 11h
	DL = drive number (80h = first, 81h = second hard disk)
Return: CF set on error
	CF clear if successful
	AH = status (see #0142 at AH=01h)
Note:	causes hard disk controller to seek the specified drive to cylinder 0
SeeAlso: AH=00h,AH=0Ch,AH=19h"FIXED DISK"
--------B-1312-------------------------------
INT 13 - HARD DISK - CONTROLLER RAM DIAGNOSTIC (XT,PS)
	AH = 12h
	DL = drive number (80h = first, 81h = second hard disk)
Return: CF set on error
	CF clear if successful
	AH = status code (see #0142 at AH=01h)
	AL = 00h
SeeAlso: AH=13h,AH=14h
--------d-1312-------------------------------
INT 13 - Future Domain SCSI CONTROLLER - STOP SCSI DISK
	AH = 12h
	DL = hard drive ID
Return: CF set on error
	CF clear if successful
	AH = status code (see #0142 at AH=01h)
Notes:	available at least on the TMC-870 8-bit SCSI controller BIOS v6.0A
	if the given drive is a SCSI device, the SCSI Stop Unit command is sent
	  and either "Disk prepared for shipping" or "Disk Stop command failed"
	  is displayed
	the TMC-950 does not support any Future Domain BIOS calls; instead,
	  it provides a full CAM implementation (see INT 4F/AX=8100h)
--------d-1312-------------------------------
INT 13 - SyQuest - START/STOP SCSI DISK
	AH = 12h
	AL = subfunction
	    00h start disk
	    01h stop disk
	CX = wait flag
	    00h wait for ready
	    01h don't wait for ready
	DL = hard drive ID (bit 7 for hard disks must be set)
Return: CF set on error
	CF clear if successful
	AH = status
	    00h successful
	    01h invalid function request
	    80h timeout
SeeAlso: AH=12h"Future Domain",AH=13h"SyQuest"
--------B-1313-------------------------------
INT 13 - HARD DISK - DRIVE DIAGNOSTIC (XT,PS)
	AH = 13h
	DL = drive number (80h = first, 81h = second hard disk)
Return: CF set on error
	CF clear if successful
	AH = status code (see #0142 at AH=01h)
	AL = 00h
SeeAlso: AH=12h"HARD DISK",AH=14h"HARD DISK"
--------d-1313-------------------------------
INT 13 - SyQuest - READ DRIVE PARAMATERS (for DOS 5+)
	AH = 13h
	DL = drive ID (bit 7 set for hard disks)
Return: CF set on error
	    AH = status (07h) (see #0142 at AH=01h)
	CF clear if successful
	    AH = 00h
	    BL = drive type (AT/PS2 floppies only) (see #0150)
	    CH = low eight bits of maximum cylinder number
	    CL = maximum sector number (bits 5-0)
		 high two bits of maximum cylinder number (bits 7-6)
	    DH = maximum head number
	    DL = number of drives
	    ES:DI -> drive parameter table (floppies only)
Notes:	the return values are identical to the standard INT 13/AH=08h, but the
	  number of drives is not limited to 2, so
	scanning all possible drive numbers with the Read DASD Type call
	  (AH=15h) should generally be preferred to determine the number of
	  drives attached to the system.
SeeAlso: AH=08h,AH=12h"SyQuest",AH=15h,AH=59h"SyQuest"
--------B-1314-------------------------------
INT 13 - HARD DISK - CONTROLLER INTERNAL DIAGNOSTIC
	AH = 14h
Return: CF set on error
	CF clear if successful
	AH = status code (see #0142 at AH=01h)
	AL = 00h
SeeAlso: AH=12h,AH=13h
--------B-1315-------------------------------
INT 13 - DISK - GET DISK TYPE (XT 1/10/86 or later,XT286,AT,PS)
	AH = 15h
	DL = drive number (bit 7 set for hard disk)
Return: CF clear if successful
	    AH = type code
		00h no such drive
		01h floppy without change-line support
		02h floppy with change-line support
		03h hard disk
		    CX:DX = number of 512-byte sectors
	CF set on error
	    AH = status (see #0142 at AH=01h)
Note:	SyQuest can report type 01h or 02h for 'hard disks', since its media
	  is removable
SeeAlso: AH=08h,AH=16h,AH=17h,AH=19h"SCSI"
--------B-1316-------------------------------
INT 13 - FLOPPY DISK - DETECT DISK CHANGE (XT 1/10/86 or later,XT286,AT,PS)
	AH = 16h
	DL = drive number (00h-7Fh)
Return: CF clear if change line inactive
	    AH = 00h (disk not changed)
	CF set if change line active
	    AH = status
		01h invalid command (SyQuest)
		06h change line active or not supported
		80h drive not ready or not present
Notes:	call AH=15h first to determine whether the drive supports a change
	  line
	this call also clears the media-change status, so that a disk change
	  is only reported once
BUG:	some versions of Award 386 Modular BIOS and AMI BIOS fail to clear
	  the media-change status
SeeAlso: AH=15h,AH=49h
--------B-1317-------------------------------
INT 13 - FLOPPY DISK - SET DISK TYPE FOR FORMAT (AT,PS)
	AH = 17h
	AL = format type
	    01h = 320/360K disk in 360K drive
	    02h = 320/360K disk in 1.2M drive
	    03h = 1.2M disk in 1.2M drive
	    04h = 720K disk in 720K or 1.44M drive
	DL = drive number
Return: CF set on error
	CF clear if successful
	AH = status (see #0142 at AH=01h)
Note:	this function does not handle 1.44M drives; use AH=18h instead
SeeAlso: AH=15h,AH=18h
--------d-131700-----------------------------
INT 13 - Future Domain SCSI CONTROLLER - GET INQUIRY INFO FROM SCSI DEVICE
	AX = 1700h
	CL = length of buffer
	DL = hard drive ID
	ES:BX -> buffer for info (see #0151)
Return: CF clear if successful
	    CH = number of bytes returned in buffer???
	CF set on error
	    AH = status code (see #0142 at AH=01h)
Notes:	this function is not available with 8-bit controller ROM versions < 7.0
	information block bytes 5-n are vendor-specific in older SCSI devices
	the TMC-950 does not support any Future Domain BIOS calls; instead,
	  it provides a full CAM implementation (see INT 4F/AX=8100h)
SeeAlso: AH=18h"SCSI",AH=1Bh"SCSI"

Format of Future Domain SCSI inquiry information block:
Offset	Size	Description	(Table 0151)
 00h	BYTE	device type
		bits 0-4: peripheral device type (see #0152)
		bits 5-7: peripheral qualifier (see #0153)
 01h	BYTE	device type modifier
		bits 0-6: device type modifier
		bit 7: removable medium
 02h	BYTE	SCSI version (see #0154)
 03h	BYTE	data format/capabilities (see #0155)
 04h	BYTE	additional data length (total remaining bytes)
 05h  2 BYTEs	reserved
 07h	BYTE	device capabilities (see #0156)
 08h  8 BYTEs	vendor identification (space-padded ASCII)
 10h  8 BYTEs	product identification (space-padded ASCII)
 20h  4 BYTEs	product revision level (space-padded ASCII)
 24h 20 BYTEs	vendor specific
 38h 40 BYTEs	reserved
 60h	var	vendor specific parameters

(Table 0152)
Values for Future Domain SCSI peripheral device type:
 00h	direct-access device (e.g., magnetic disk)
 01h	sequential-access device (e.g., magnetic tape)
 02h	printer device
 03h	processor device
 04h	write-once device (e.g., some optical disks)
 05h	CD-ROM device
 06h	scanner device
 07h	optical memory device (e.g., some optical disks)
 08h	medium changer device (e.g., jukeboxes)
 09h	communications device
 0Ah	(defined by ASC IT8)
 0Bh	(defined by ASC IT8)
 0Ch-1Eh reserved
 1Fh	unknown or no device type

(Table 0153)
Values for Future Domain SCSI peripheral qualifier:
 000b	device is currently connected to this logical unit and available
 001b	target is capable of supporting the specified peripheral, but the
	  physical device is not currently connected to this logical unit
 010b	reserved
 011b	target can't support a physical device on this logical unit
 1xxb	vendor specific

Bitfields for Future Domain SCSI version:
Bit(s)	Description	(Table 0154)
 0-2	ANSI-approved version
	000 device might or might not comply to ANSI standard
	001 device complies to ANSI SCSI-1
	010 device complies to ANSI SCSI-2
	other reserved
 3-5	ECMA version
 6-7	ISO version

Bitfields for Future Domain SCSI data format/capabilities:
Bit(s)	Description	(Table 0155)
 0-2	response data format
	000 information block is as specified in SCSI-1
	001 information block is as specified in CCS
	010 information block is as specified in SCSI-2
	other reserved
 4-5	reserved
 6	terminate I/O process supported
 7	asynchronous event notification supported

Bitfields for Future Domain SCSI device capabilities:
Bit(s)	Description	(Table 0156)
 0	device responds to RESET with a hard RESET
 1	tagged command queuing supported
 2	reserved
 3	linked commands supported
 4	synchronous data transfer supported
 5	16-transfers supported
 6	32-transfers supported
 7	relative addressing supported
--------B-1318-------------------------------
INT 13 - DISK - SET MEDIA TYPE FOR FORMAT (AT model 3x9,XT2,XT286,PS)
	AH = 18h
	DL = drive number
	CH = lower 8 bits of highest cylinder number (number of cylinders - 1)
	CL = sectors per track (bits 0-5)
	     top 2 bits of highest cylinder number (bits 6,7)
Return: AH = status
	    00h requested combination supported
	    01h function not available
	    0Ch not supported or drive type unknown
	    80h there is no disk in the drive
	ES:DI -> 11-byte parameter table (see #0640 at INT 1E)
SeeAlso: AH=05h,AH=07h,AH=17h
--------d-1318-------------------------------
INT 13 - Future Domain SCSI BIOS - GET SCSI CONTROLLER INFORMATION
	AH = 18h
	DL = hard drive ID
Return: CF set on error
	    AH = status code (see #0142 at AH=01h)
	CF clear if successful
	    AX = 4321h (magic number)
	    CX = controller family code (see #0157)
	    ---if family code=0200h
		DH = number of exclusively ROM-controlled SCSI devices
		DL = canonical SCSI device number for specified drive
	    ---if family code <> 0200h
		BH = number of exclusively ROM-controlled SCSI devices
		BL = canonical SCSI device number for specified drive
Notes:	also sets an internal flag (non-resettable) which prevents some
	  controller messages from being displayed, allows writes to
	  removable devices (use caution!), and enables the INT 13 interface
	  for more than one drive (i.e. DL >= 81h) in at least some ROM
	  versions
	the TMC-950 does not support any Future Domain BIOS calls; instead,
	  it provides a full CAM implementation (see INT 4F/AX=8100h)
SeeAlso: AH=05h"SCSI",AX=1700h"SCSI",AH=1Bh"SCSI",INT 4F/AX=8100h

(Table 0157)
Values for Future Domain SCSI controller family code:
 0200h	TMC-1680/? (ROM 3.0)
 0203h	TMC-1650/1660/1670/1680 (ROM 2.0)
 040Ah	TMC-820/830/840/850/860/870/875/880/885 (ROM <= 6.0A)
 050Dh	TMC-840/841/880/881 (ROM 5.2D)
 0700h	TMC-830/850/860/875/885 (ROM 7.0)
--------d-1318--CXD2C9-----------------------
INT 13 - XDF.COM - API
	AH = 18h
	CX = D2C9h ("R"+80h, "I"+80h = Roger Ivey)
	DX = 0
	BX = function
	    0000h installation check
		  Return: AH =	 0Ch
			  CX = 7269h ("ri" = Roger Ivey)
			  ES = segment of driver
			  CF set
	    2F64h ("/d") disable the driver
		  Return: AH =	 0Ch
			  ES:BX = pointer to activation flag (it is set to 0:
				  set it to 1 to enable the driver again)
			  CX = 7269h
			  CF set
	    2F75h ("/u") unload the driver (restore interrupts & free memory)
		  Return: AH =	 0Ch
			  DL =	 55h ("U") if successful
			     =	  0h	   if fails
			  CX = 7269h
			  ES = segment of driver
			  CF set
			  AL, BX, DH, and DI destroyed
Program: XDF is a TSR provided with PC-DOS 7.0 to support XDF 1.84M disks,
	  developed by Roger D. Ivey
Note:	After disabling or enabling the driver, a disk change must be performed
	  or simulated to reset the driver.
--------B-1319-------------------------------
INT 13 - FIXED DISK - PARK HEADS ON ESDI DRIVE (XT286,PS)
	AH = 19h
	DL = drive
Return: CF set on error
	CF clear if successful
	AH = status (see #0142 at AH=01h)
SeeAlso: AH=11h
--------d-1319-------------------------------
INT 13 - Future Domain SCSI CONTROLLER - REINITIALIZE DRIVE
	AH = 19h
	DL = hard drive ID
Return: CF set on error
	    AH = status code (see #0142 at AH=01h)
	CF clear if successful
	    AH = disk type (03h = fixed disk)
	    CX:DX = number of 512-byte sectors
Notes:	sends SCSI Read Capacity command to get number of logical blocks and
	  adjusts the result for 512-byte sectors
	displays either "Error in Read Capacity Command" or "nnn Bytes per
	  sector" (nnn=256 or 512, the only sizes supported in the translation
	  code)
	should probably be called when a removable device has its media changed
	returns the same values as AH=15h
	the TMC-950 does not support any Future Domain BIOS calls; instead,
	  it provides a full CAM implementation (see INT 4F/AX=8100h)
SeeAlso: AH=15h,AH=1Ah,INT 4F/AX=8100h
--------d-131A-------------------------------
INT 13 - ESDI FIXED DISK - FORMAT UNIT (PS)
	AH = 1Ah
	AL = defect table entry count
	CL = format modifiers (see #0158)
	DL = drive (80h,81h)
	ES:BX -> defect table (see #0159), ignored if AL=00h
Return: CF set on error
	CF clear if successful
	AH = status (see #0142 at AH=01h)
Note:	if periodic interrupt selected, INT 15/AH=0Fh is called after each
	  cylinder is formatted
SeeAlso: AH=07h,INT 15/AH=0Fh

Bitfields for ESDI format modifiers:
Bit(s)	Description	(Table 0158)
 4	generate periodic interrupt
 3	perform surface analysis
 2	update secondary defect map
 1	ignore secondary defect map
 0	ignore primary defect map

Format of defect table entry [array]:
Offset	Size	Description	(Table 0159)
 00h  3 BYTEs	relative sector address (little-endian)
 03h	BYTE	flags and defect count
		bit 7: last logical sector on track
		bit 6: first logical sector on track
		bit 5: last logical sector on cylinder
		bit 4: logical sectors are pushed onto next track
		bits 3-0: number of defects pushed from previous cylinder
--------d-131A-------------------------------
INT 13 - Future Domain SCSI CONTROLLER - GET SCSI PARTIAL MEDIUM CAPACITY
	AH = 1Ah
	CH = track (bits 8,9 in high bits of CL)
	CL = sector (01h to number of sectors/track for drive)
	DH = head
	DL = hard drive ID
Return: CF set on error
	AH = status code (see #0142 at AH=01h)
	CX:DX = logical block number of last quickly-accessible block after
		given block
Notes:	sends SCSI Read Capacity command with the PMI bit set to obtain the
	  logical block address of the last block after which a substantial
	  delay in data transfer will be encountered (usually the last block
	  on the current cylinder).  No translation to 512 byte sectors is
	  performed on the result if data is stored on the disk in other than
	  512 byte sectors.
	the TMC-950 does not support any Future Domain BIOS calls; instead,
	  it provides a full CAM implementation (see INT 4F/AX=8100h)
SeeAlso: AH=15h,AH=19h"SCSI"
--------d-131B-------------------------------
INT 13 - ESDI FIXED DISK - GET MANUFACTURING HEADER
	AH = 1Bh
	AL = number of sectors to read
	DL = drive
	ES:BX -> buffer for manufacturing header (defect list)
Return: CF set on error
	CF clear if successful
	AH = status
Note:	manufacturing header format (Defect Map Record format) can be found
	  in IBM 70MB, 115MB Fixed Disk Drives Technical Reference
	the first sector read contains the manufacturing header with the number
	  of defect entries and the beginning of the defect map; the remaining
	  sectors contain the remainder of the defect map
--------d-131B-------------------------------
INT 13 - Future Domain SCSI CONTROLLER - GET POINTER TO SCSI DISK INFO BLOCK
	AH = 1Bh
	DL = hard drive ID
Return: CF set on error
	    AH = status code (see #0142 at AH=01h)
	CF clear if successful
	    ES:BX -> SCSI disk information block (see #0160)
Notes:	also sets a non-resettable flag which prevents some controller messages
	  from being displayed
	the TMC-950 does not support any Future Domain BIOS calls; instead,
	  it provides a full CAM implementation (see INT 4F/AX=8100h)
SeeAlso: AH=18h"SCSI",AH=1Ch"SCSI"

Format of Future Domain SCSI disk information block:
Offset	Size	Description	(Table 0160)
 00h	BYTE	drive physical information (see #0161)
 01h	WORD	translated number of cylinders
 03h	BYTE	translated number of heads
 04h	BYTE	translated number of sectors per track (17, 34, or 63)
 05h	BYTE	drive address
		bits 0-2: logical unit number
		bits 3-5: device number
 06h	BYTE	01h at initialization
 07h	BYTE	sense code byte 00h, or extended sense code byte 0Ch
 08h	BYTE	00h
 09h	BYTE	00h or extended sense code byte 02h (sense key)
 0Ah	BYTE	00h
 0Bh 10 BYTEs	copy of Command Descriptor Block (CDB)
 15h	DWORD	translated number of sectors on device

Bitfields for Future Domain SCSI device physical information:
Bit(s)	Description	(Table 0161)
 0	???
 1	device uses parity
 2	256 bytes per sector instead of 512
 3	don't have capacity yet???
 4	disk is removable
 5	logical unit number is not present
--------d-131C-------------------------------
INT 13 - Future Domain SCSI CONTROLLER - GET POINTER TO FREE CONTROLLER RAM
	AH = 1Ch
	DL = hard drive ID (any valid SCSI hard disk)
Return: CF set on error
	    AH = status code (see #0142 at AH=01h)
	CF clear if successful
	    ES:BX -> first byte of free RAM on controller
Notes:	the Future Domain TMC-870 contains 1024 bytes of RAM at offsets 1800h
	  to 1BFFh on-board the controller for storing drive information and
	  controller status; ES:BX points to the first byte available for other
	  uses
	ES contains the segment at which the controller resides; the
	  controller's two memory-mapped I/O ports are at offsets 1C00h, 1E00h
SeeAlso: AH=1Bh"SCSI"
--------d-131C-------------------------------
INT 13 U - ESDI FIXED DISK - ???
	AH = 1Ch
	AL = subfunction (01h-06h)
	DL = drive (80h,81h)
	???
Return: ???
Note:	these functions perform a controller command 0612h without DMA
--------d-131C08-----------------------------
INT 13 U - ESDI FIXED DISK - GET COMMAND COMPLETION STATUS
	AX = 1C08h
	DL = drive (80h,81h)
	ES:BX -> buffer for Command Complete Status Block (see #0162)
Return: CF set on error
	CF clear if successful
	AH = status (see #0142 at AH=01h)
SeeAlso: AX=1C09h,AX=1C0Ah

Format of ESDI Command Complete Status Block:
Offset	Size	Description	(Table 0162)
 00h	BYTE	07h
 01h	BYTE	size of block in words (07h)
 02h	BYTE	command error code (see #0163)
 03h	BYTE	command status code (see #0164)
 04h	BYTE	device error code, group 1 (see #0165)
 05h	BYTE	device error flags, group 2 (see #0166)
 06h	WORD	number of unprocessed sectors due to abnormal termination
 08h	DWORD	last Relative Sector Address processed by command
 0Ch	WORD	number of sectors corrected by ECC codes

(Table 0163)
Values for ESDI command error code:
 00h	successful
 01h	parameter invalid
 02h	unknown function
 03h	unsupported command
 04h	command cancelled
 05h	unknown function
 06h	controller diagnostics failed
 07h	formatting failed
 08h	format error in primary map
 09h	format error in secondary map
 0Ah	diagnostic failure during formatting
 0Bh	warning: secondary map too large during formatting
 0Ch	warning: non-zero defect
 0Dh	system checksum error during formatting
 0Eh	warning: incompatible device
 0Fh	warning: push table overflowed
 10h	warning: more than 15 sectors pushed to next cylinder
 11h	internal hardware error
 12h	warning: errors found while verifying sectors
 13h	invalid device
 FFh	device error

(Table 0164)
Values for ESDI command status code:
 01h	successful
 03h	successful after ECC
 05h	successful after retries
 06h	format partially completed
 07h	successful after ECC and retries
 08h	command completed with warning (see #0163)
 09h	abort complete
 0Ah	reset complete
 0Bh	data transfer ready (no status block)
 0Ch	command completed with failure (see #0165,#0166)
 0Dh	DMA error
 0Eh	command block error (see #0163)
 0Fh	bad attention code

(Table 0165)
Values for ESDI device error code, group 1:
 00h	successful
 01h	seek fault detected by device
 02h	interface fault
 03h	sector ID not found
 04h	disk not formatted
 05h	unrecoverable ECC error
 06h	ECC error in sector ID
 07h	invalid relative sector address
 08h	timeout
 09h	sector defective
 0Ah	disk changed (removable media)
 0Bh	selection error
 0Ch	write protected (removable media)
 0Dh	write fault
 0Eh	read fault
 0Fh	no index or sector pulse
 10h	device not ready
 11h	seek error detected by adapter
 12h	bad format
 13h	volume overflow
 14h	data address mark not found
 15h	sector ID not found
 16h	missing device configuration data
 17h	first/last relative sector flags missing
 18h	track empty
 81h	timeout while waiting for stop
 82h	timeout while waiting for end of data transfer
 84h	stopped awaiting data transfer during formatting
 85h	timeout while waiting for head switch
 86h	timeout while awaiting DMA completion

Bitfields for ESDI device error flags, group 2:
Bit(s)	Description	(Table 0166)
 7-5	unused
 4	ready
 3	selected
 2	write fault
 1	on track 0
 0	seek/command complete
--------d-131C09-----------------------------
INT 13 U - ESDI FIXED DISK - GET DEVICE STATUS
	AX = 1C09h
	DL = drive (80h,81h)
	ES:BX -> buffer for Device Status Block (see #0167)
Return: CF set on error
	CF clear if successful
	AH = status (see #0142 at AH=01h)
SeeAlso: AX=1C08h,AX=1C0Ah

Format of ESDI Device Status Block:
Offset	Size	Description	(Table 0167)
 00h	BYTE	08h
 01h	BYTE	number of words in block (09h)
 02h	BYTE	error flags
 03h	BYTE	unused
 04h	BYTE	command error code (see #0163)
 05h	BYTE	command status code (see #0164)
 06h	WORD	ESDI standard status
 08h  5 WORDs	ESDI vendor-specific status codes
--------d-131C0A-----------------------------
INT 13 U - ESDI FIXED DISK - GET DEVICE CONFIGURATION
	AX = 1C0Ah
	DL = drive (80h,81h)
	ES:BX -> buffer for Drive Configuration Status Block (see #0168)
Return: CF set on error
	CF clear if successful
	AH = status (see #0142 at AH=01h)
Note:	device configuration format can be found in IBM ESDI Fixed Disk Drive
	  Adapter/A Technical Reference
SeeAlso: AX=1C08h,AX=1C0Bh,AX=1C0Ch

Format of ESDI Drive Configuration Status Block:
Offset	Size	Description	(Table 0168)
 00h	BYTE	09h
 01h	BYTE	number of words in block (06h)
 02h	BYTE	flags
 03h	BYTE	number of spare sectors per cylinder
 04h	DWORD	total number of usable sectors
 08h	WORD	total number of cylinders
 0Ah	BYTE	tracks per cylinder
 0Bh	BYTE	sectors per track
--------d-131C0B-----------------------------
INT 13 U - ESDI FIXED DISK - GET ADAPTER CONFIGURATION
	AX = 1C0Bh
	ES:BX -> buffer for Controller Configuration Status Block (see #0169)
Return: CF set on error
	CF clear if successful
	AH = status (see #0142 at AH=01h)
SeeAlso: AX=1C0Ch

Format of ESDI Controller Configuration Status Block:
Offset	Size	Description	(Table 0169)
 00h	BYTE	E9h
 01h	BYTE	number of words in block (06h)
 02h	WORD	unused (0000h)
 04h	DWORD	controller microcode revision level
 08h  2 WORDs	unused (0000h)
--------d-131C0C-----------------------------
INT 13 U - ESDI FIXED DISK - GET POS INFORMATION
	AX = 1C0Ch
	ES:BX -> buffer for POS Information Status Block (see #0170)
Return: CF set on error
	CF clear if successful
	AH = status (see #0142 at AH=01h)
SeeAlso: AX=1C0Bh

Format of ESDI POS Information Status Block:
Offset	Size	Description	(Table 0170)
 00h	BYTE	EAh
 01h	BYTE	number of words in block (05h)
 02h	WORD	magic value FFDDh
 04h	BYTE	POS register 3
 05h	BYTE	POS register 2
 06h	BYTE	POS register 5 (unused, FFh)
 07h	BYTE	POS register 4 (unused, FFh)
 08h	BYTE	POS register 7 (unused, FFh)
 09h	BYTE	POS register 6 (unused, FFh)
--------d-131C0D-----------------------------
INT 13 U - ESDI FIXED DISK - ???
	AX = 1C0Dh
	DL = drive (80h,81h)
	???
Return: ???
Note:	invokes controller command 0614h without DMA
SeeAlso: AH=1Ch"ESDI",AX=1C0Fh
--------d-131C0E-----------------------------
INT 13 U - ESDI FIXED DISK - TRANSLATE RBA TO ABA
	AX = 1C0Eh
	CH = low 8 bits of cylinder number
	CL = sector number, high two bits of cylinder number in bits 6 and 7
	DH = head number
	DL = drive number (80h,81h)
	ES:BX -> ABA number
Return: CF set on error
	CF clear if successful
	AH = status (see #0142 at AH=01h)
Note:	ABA (absolute block address) format can be found in IBM ESDI Adapter
	  Technical Reference by using its Device Configuration Status Block
--------d-131C0F-----------------------------
INT 13 U - ESDI FIXED DISK - ???
	AX = 1C0Fh
	DL = drive (80h,81h)
	???
Return: ???
Note:	invokes controller command 0614h without DMA
SeeAlso: AH=1Ch"ESDI",AX=1C0Dh,AX=1C12h
--------d-131C12-----------------------------
INT 13 U - ESDI FIXED DISK - ???
	AX = 1C12h
	DL = drive (80h,81h)
	???
Return: ???
Note:	invokes controller command 0612h without DMA
SeeAlso: AH=1Ch"ESDI",AX=1C0Fh
--------c-131D-------------------------------
INT 13 - IBMCACHE.SYS - CACHE STATUS
	AH = 1Dh
	AL = subfunction
	    01h get status record
		DL = drive???
		Return: ES:BX -> status record (see #0171)
			CF set on error
			    AH = error code
	    02h set cache status
		ES:BX -> status record (see #0171)
		DL = drive???
		Return: CF set on error

Format of IBMCACHE.SYS status record:
Offset	Size	Description	(Table 0171)
 00h	DWORD	total number of read requests
 04h	DWORD	total number of hits
 08h	DWORD	number of physical disk reads
 0Ch	DWORD	total number of sectors requested by physical disk reads
 10h  6 BYTEs	???
 16h	DWORD	pointer to start of error list (see #0172)
 1Ah	DWORD	pointer to end of error list
 1Eh	WORD	???
 20h	BYTE	using extended memory if nonzero
 21h	BYTE	???
 22h  4 BYTEs	ASCII version number
 26h	WORD	cache size in KB
 28h	WORD	sectors per page

Format of IBMCACHE.SYS error list:
Offset	Size	Description	(Table 0172)
 00h	DWORD	relative block address of bad page
 04h	BYTE	drive
 05h	BYTE	sector bit-map
 06h	WORD	next error
--------d-131F-------------------------------
INT 13 - SyQuest - DOOR LATCH/DOOR BUTTON DETECT
	AH = 1Fh
	AL = subfunction
	    00h allow media removal
	    01h prevent media removal (lock door)
	DL = drive ID (bit 7 set for hard disks)
Return:	CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code
		00h successful
		01h invalid function request
		80h timeout
		DDh media change requested
SeeAlso: AH=12h"SyQuest",AH=13h"SyQuest",AH=59h"SyQuest"
--------d-1320-------------------------------
INT 13 - DISK - ??? (Western Digital "Super BIOS")
	AH = 20h
	???
Return: ???
Notes:	returns some kind of status related to whether the drive contains its
	  default media type
	QEMM v6.00 calls INT 13/AX=2000h/DL=81h in some cases
--------b-1320-------------------------------
INT 13 U - Compaq DESKPRO/i - GET CURRENT MEDIA FORMAT
	AH = 20h
	DL = drive number (00h,01h)
Return: CF clear if successful
	    AL = media type (see #0173)
	CF set on error
	    AH = error code
		31h no such drive
		32h incorrect drive type stored in CMOS
Note:	this function is supported by the 3/8/93 ROM BIOS, but only partially
	  (AL is always 00h when successful) by the 8/3/93 version

(Table 0173)
Values for Compaq diskette media type:
 03h	720K
 04h	1.44M
 06h	2.88M
 0Ch	360K
 0Dh	1.2M
 0Eh	???
 0Fh	??? (1024-byte sectors)
--------c-1320-------------------------------
INT 13 u - QUICKCACHE II v4.20 - DISMOUNT
	AH = 20h
	AL = drive (00h = A:, etc. or 7Fh for all removable drives???
				   or FFh for all drives)
Return: AX = status (0000h successful)
Program: QUICKCACHE II is a shareware disk cache by P.R. Glassel and
	  Associates, Inc.
Desc:	flush any dirty buffers for the specified drive(s) and then discard
	  those sector buffers
SeeAlso: AH=21h"QUICKCACHE",AH=22h"QUICKCACHE",AH=28h
--------d-1321-------------------------------
INT 13 - HARD DISK - PS/1 and newer PS/2 - READ MULTIPLE DISK SECTORS
	AH = 21h
	AL = number of sectors to write
	CH = low byte of 12-bit cylinder number
	CL = starting sector (bits 0-5) and bits 8-9 of cylinder (bits 6-7)
	DH = head number (bits 0-5) and bits 10-11 of cylinder (bits 6-7)
	DL = drive number (80h,81h)
	ES:BX -> buffer for data to be read
Return: CF clear if successful
	    ES:BX buffer filled
	CF set on error
	AH = status (see #0142 at AH=01h)
Desc:	read from the disk using the Multiple Block mode available on newer
	  IDE drives and some hard disk controllers, which generates an
	  interrupt only after the end of transferring a group of sectors
	  rather than after each sector
Notes:	must call AH=24h"PS/1" before using this function
	input values in CL and DH are not range-checked
	the byte at address 0040h:0074h is set to the status of the operation
SeeAlso: AH=02h,AH=22h"PS/1",AH=23h"PS/1",AH=24h"PS/1"
--------c-1321-------------------------------
INT 13 u - QUICKCACHE II v4.20 - FLUSH CACHE
	AH = 21h
Return: AX = status (0000h successful)
Desc:	immediately write all dirty sectors back to disk
SeeAlso: AH=25h"QUICKCACHE",AH=2Eh,AH=2Fh
--------d-1322-------------------------------
INT 13 - HARD DISK - PS/1 and newer PS/2 - WRITE MULTIPLE DISK SECTORS
	AH = 22h
	AL = number of sectors to write
	CH = low byte of 12-bit cylinder number
	CL = starting sector (bits 0-5) and bits 8-9 of cylinder (bits 6-7)
	DH = head number (bits 0-5) and bits 10-11 of cylinder (bits 6-7)
	DL = drive number (80h,81h)
	ES:BX -> buffer containing data to be written
Return: CF clear if successful
	CF set on error
	AH = status (see #0142 at AH=01h)
Desc:	write to the disk using the Multiple Block mode available on newer
	  IDE drives and some hard disk controllers, which generates an
	  interrupt only after the end of transferring a group of sectors
	  rather than after each sector
Notes:	must call AH=24h"PS/1" before using this function
	input values in CL and DH are not range-checked
	the byte at address 0040h:0074h is set to the status of the operation
SeeAlso: AH=03h,AH=21h"PS/1",AH=23h"PS/1",AH=24h"PS/1"
--------c-1322-------------------------------
INT 13 u - QUICKCACHE II v4.20 - ENABLE/DISABLE CACHE
	AH = 22h
	AL = new state (00h disabled, 01h enabled)
Return: AX = status (0000h successful)
Note:	enables/disables caching of all drives
SeeAlso: AH=2Ch,AH=2Dh,AH=32h,AH=33h,AH=A3h,AH=A4h
--------d-1323-------------------------------
INT 13 U - HARD DISK - PS/1 and newer PS/2 - SET CONTROLLER FEATURES REGISTER
	AH = 23h
	AL = feature number (see #0174)
	DL = drive number (80h,81h)
	???
Return: CF clear if successful
	CF set on error
	AH = status (see #0142 at AH=01h)
SeeAlso: AH=21h"PS/1",AH=22h"PS/1",AH=24h"PS/1",AH=25h"PS/1"

(Table 0174)
Values for PS/1 hard disk feature number:
 01h	select 8-bit data transfers instead of 16-bit
 02h	enable write cache
 22h	Write Same, user-specified area
 33h	disable retries
 44h	set number of ECC bytes for read long/write long (see AH=0Ah,AH=0Bh)
 54h	set cache segments
 55h	disable lookahead
 66h	disable reverting to power-on defaults
 77h	disable error correctioni
 81h	select 16-bit data transfers (default)
 82h	disable write cache
 88h	enable error correction (default)
 99h	enable retries (default)
 AAh	enable lookahead
 BBh	set ECC length for read long/write long to four bytes
 CCh	enable reverting to power-on defaults
 DDh	Write Same, entire disk
--------c-1323-------------------------------
INT 13 U - QUICKCACHE II v4.20 - GET ??? ADDRESS
	AH = 23h
Return: AX = status (0000h successful)
	ES = segment of ??? data
--------d-1324-------------------------------
INT 13 - HARD DISK - PS/1 and newer PS/2 - SET MULTIPLE MODE
	AH = 24h
	AL = number of sectors per block (2,4,8,16)
	DL = drive number (80h,81h)
Return: CF clear if successful
	CF set onerror
	AH = status (see #0142 at AH=01h)
Desc:	specify how many sectors the controller should transfer as a group
	  between operation-complete interrupts when using the Read Multiple
	  and Write Multiple functions (AH=21h,AH=22h)
Notes:	set the number of sectors to 0 to disable multiple-transfer mode
	the maximum value for the block size depends on the fixed disk
	  drive type.  The value is stored in byte 15h of the fixed disk
	  drive parameter table that is created by POST.
	the byte at address 0040h:0074h is set to status of operation.
SeeAlso: AH=21h"PS/1",AH=22h"PS/1",AH=23h"PS/1",AH=25h"PS/1"
--------c-1324-------------------------------
INT 13 u - QUICKCACHE II v4.20 - SET SECTORS
	AH = 24h
	BX = new number of sector buffers in cache
Return: AX = status
	    0000h successful
	    0001h failed--size adjusted
	    8000h cache cannot be resized while enabled
SeeAlso: AH=36h
--------d-1325-------------------------------
INT 13 - HARD DISK - PS/1 and newer PS/2 - IDENTIFY DRIVE
	AH = 25h
	DL = drive number (80h,81h)
	ES:BX-> 512 byte buffer for reply packet
Return:	CF clear if successful
	CF set on error
	AH = status (see #0142 at AH=01h)
	buffer filled with ATA/IDE-style drive information block (see #0175)
Desc:	retrieves the 256 words of drive data stored on an IDE hard disk
Note:	the byte at address 0040h:0074h is set to the status of the operation
SeeAlso: AH=23h"PS/1"

Format of drive information block:
Offset	Size	Description	(Table 0175)
 00h	WORD	general drive configuration (see #0176)
 02h	WORD	number of cylinders
 04h	WORD	reserved
 06h	WORD	number of heads
 08h	WORD	number of unformatted bytes per track
 0Ah	WORD	number of unformatted bytes per sector
 0Ch	WORD	number of sectors per track
 0Eh  6 BYTEs	vendor unique
 14h 20 BYTEs	serial number in ASCII, 0000h=not specified)
 28h	WORD	buffer type
 2Ah	WORD	buffer size in 512 byte increments (0000h=not specified)
 2Ch	WORD	number of ECC bytes passed on Read/Write Long cmds
		0000h = not specified
 2Eh  8 BYTEs	firmware revision in ASCII, 0000h=not specified
 36h 40 BYTEs	model number in ASCII, 0000h=not specified
 5Eh	WORD	bits 15-8  Vendor Unique
		bits 7-0  00h = Read/Write Multiple commands not implemented
			  xxh = Maximum number of sectors that can be
			  transferred per interrupt on Read and Write
			  Multiple commands
 60h	WORD	0000h = cannot perform doubleword I/O
		0001h = can perform doubleword I/O
 62h	WORD	capabilities
		bit 15-9  0=reserved
		bit 8  1=DMA Supported
		bit 7-0	 Vendor Unique
 64h	WORD	reserved
 66h	WORD	bits 15-8 PIO data transfer cycle timing mode
		bits 7-0  Vendor Unique
 68h	WORD	bits 15-8 DMA data transfer cycle timing mode
		bits 7-0  Vendor Unique
 6Ah	WORD	bits 15-1 reserved
		bit 0	1=the fields reported in tranlation mode are valid
			0=the fields reported in translation mode may be valid
 6Ch	WORD	number of current cylinders
 6Eh	WORD	number of current heads
 70h	WORD	number of current sectors per track
 72h	DWORD	current capacity in sectors
 76h	WORD	reserved
 78h 136 BYTEs	not defined by ATA spec 2.6
100h 64 BYTEs	vendor unique
140h 96 BYTEs	reserved
Note:	the above description is as in the ATA (AT Attachment) Specification.

Bitfields for general drive configuration:
Bit(s)	Description	(Table 0176)
 15	0   reserved for non-magnetic drives
 14	format speed tolerance gap required
 13	track offset option available
 12	data strobe offset option available
 11	rotational speed tolerance is > 0.5%
 10	disk transfer rate > 10 Mbs
 9	disk transfer rate > 5Mbs but <= 10Mbs
 8	disk transfer rate <= 5Mbs
 7	removable cartridge drive
 6	fixed drive
 5	spindle motor control option implemented
 4	head switch time > 15 usec
 3	not MFM encoded
 2	soft sectored
 1	hard sectored
 0	reserved (0)
--------c-1325-------------------------------
INT 13 u - QUICKCACHE II v4.20 - SET FLUSH INTERVAL
	AH = 25h
	BX = interval
Return: AX = status (0000h successful)
Desc:	specify how often the cache should write dirty buffers to disk when
	  buffered writes are enabled
SeeAlso: AH=21h"QUICKCACHE",AH=2Ch,AH=2Eh
--------c-1326-------------------------------
INT 13 U - QUICKCACHE II v4.20 - UNINSTALL
	AH = 26h
Return: AX = status
	    0000h successful
	    0001h-00FFh interrupt vector which was hooked by another TSR
SeeAlso: AH=27h
--------c-1327--BX0000-----------------------
INT 13 u - QUICKCACHE II v4.20 - INSTALLATION CHECK
	AH = 27h
	BX = 0000h
Return: AX = 0000h if installed
	BX nonzero if installed
	    BH = major version
	    BL = binary minor version
Program: QUICKCACHE II is a shareware disk cache by P.R. Glassel and
	  Associates, Inc.
SeeAlso: AH=26h,AH=A0h,INT 16/AX=FFA5h/CX=1111h
--------c-1328-------------------------------
INT 13 U - QUICKCACHE II v4.20 - SET AUTOMATIC DISMOUNT
	AH = 28h
	AL = new state (00h disabled, 01h enabled)
Return: AX = status (0000h successful)
SeeAlso: AH=20h"QUICKCACHE"
--------c-1329-------------------------------
INT 13 U - QUICKCACHE II v4.20 - NOP
	AH = 29h
Return: AX = 0000h
--------c-132A-------------------------------
INT 13 u - QUICKCACHE II v4.20 - SET BUFFER SIZE
	AH = 2Ah
	AL = buffer size (1-30)
Return: AX = status (0000h successful)
Desc:	specify the number of cache sector buffers to dedicate to buffered read
	  and write operations
SeeAlso: AH=2Ch,AH=2Dh,AH=39h,AH=3Ah
--------c-132B-------------------------------
INT 13 U - QUICKCACHE II v4.20 - DRIVE ACCESS SOUNDS
	AH = 2Bh
	AL = new state (00h disabled, 01h enabled)
Return: AX = status (0000h successful)
--------c-132C-------------------------------
INT 13 u - QUICKCACHE II v4.20 - SET BUFFERED WRITES
	AH = 2Ch
	AL = new state (00h disabled, 01h enabled)
Return: AX = status (0000h successful)
Desc:	specify whether the cache should delay disk writes
Note:	this function enables or disables delayed writes for all drives; use
	  AH=38h to change a single drive
SeeAlso: AH=25h"QUICKCACHE",AH=2Dh,AH=2Eh,AH=38h
--------c-132D-------------------------------
INT 13 u - QUICKCACHE II v4.20 - SET BUFFERED READ
	AH = 2Dh
	AL = new state (00h disabled, 01h enabled)
Return: AX = status (0000h successful)
Desc:	specify whether the cache should attempt to read ahead of actual
	  requests
Note:	this function enables or disables read-ahead for all drives; use AH=37h
	  to change a single drive
SeeAlso: AH=2Ch,AH=37h
--------c-132E-------------------------------
INT 13 u - QUICKCACHE II v4.20 - SET FLUSH COUNT
	AH = 2Eh
	BX = flush count
Return: AX = status (0000h successful)
Desc:	specify how many dirty sectors the cache should write after each flush
	  interval (see AH=25h"QUICKCACHE") when buffered writes are enabled
SeeAlso: AH=21h"QUICKCACHE",AH=25h"QUICKCACHE",AH=2Ch
--------c-132F-------------------------------
INT 13 - QUICKCACHE II v4.20 - FORCE IMMEDIATE INCREMENTAL FLUSH
	AH = 2Fh
Return: AX = status (0000h successful)
Desc:	immediately flush up to "flushcount" dirty sectors to disk as if the
	  flush interval had expired
SeeAlso: AH=21h"QUICKCACHE"
--------c-1330-------------------------------
INT 13 u - QUICKCACHE II v4.20 - GET INFO
	AH = 30h
	AL = what to get
	    00h system info (see #0177)
	    01h drive info (see #0178)
	    02h access frequency (array of 30 words)
	    03h drive index
		(array of 32 bytes indicating BIOS drive for DOS drive)
	DS:DX -> buffer for info
Return: AX = status (0000h successful, 8000h invalid info specifier)
Program: QUICKCACHE II is a shareware disk cache by P.R. Glassel and
	  Associates, Inc.

Format of QUICKCACHE II system info:
Offset	Size	Description	(Table 0177)
 00h	BYTE	flag: cache enabled
 01h	BYTE	flag: buffered writes enabled
 02h	BYTE	flag: buffered reads enabled
 03h	BYTE	flag: sounds enabled
 04h	BYTE	flag: autodismount enabled
 05h	BYTE	???
 06h	BYTE	flag: ???
 07h	BYTE	flag: ???
 08h	BYTE	flag: "em_assigned"
 09h	BYTE	flag: emulated EMS
 0Ah	BYTE	single sector bonus
 0Bh	BYTE	"sticky_max"
 0Ch	BYTE	write sector bonus
 0Dh	BYTE	bonus threshold
 0Eh	WORD	flush interval
 10h	WORD	flush count
 12h	WORD	reserve pool size
 14h	WORD	remaining space in reserve pool
 16h	WORD	required free memory
 18h	WORD	total cache sectors
 1Ah	WORD	dirty cache sectors
 1Ch	BYTE	trace buffer size
 1Dh	BYTE	reserved (padding)

Format of QUICKCACHE II drive info [16-element array, one element]:
Offset	Size	Description	(Table 0178)
 00h	BYTE	DOS drive number
 01h	BYTE	BIOS drive number
 02h	BYTE	maximum sector number
 03h	BYTE	maximum head number
 04h	BYTE	read buffer size
 05h	BYTE	write buffer size
 06h	BYTE	last status
 07h	BYTE	flag: enabled
 08h	BYTE	flag: buffered write enabled
 09h	BYTE	flag: buffered read enabled
 0Ah	BYTE	flag: in use (drive info is valid)
 0Bh	BYTE	flag: cylinder flush
 0Ch	BYTE	reserved (padding)
 0Dh	BYTE	sectors per track
 0Eh	WORD	sector size
 10h	WORD	sectors assigned
 12h	WORD	dirty sectors
 14h	WORD	reserved sectors
 16h	WORD	number of read errors
 18h	WORD	number of write errors
 1Ah	DWORD	"rio_count"
 1Eh	DWORD	number of cache misses
 22h	DWORD	"wio_count"
 26h	DWORD	"dio_count"
--------c-1331-------------------------------
INT 13 U - QUICKCACHE II v4.20 - RESERVE MEMORY
	AH = 31h
	BX = number of paragraphs of conventional memory to reserve for apps
Return: AX = status (0000h successful)
--------c-1332-------------------------------
INT 13 U - QUICKCACHE II v4.20 - ENABLE CACHING FOR SPECIFIC DRIVE
	AH = 32h
	AL = drive number (00h=A:)
Return: AX = status (0000h successful)
SeeAlso: AH=22h"QUICKCACHE",AH=33h
--------c-1333-------------------------------
INT 13 U - QUICKCACHE II v4.20 - DISABLE CACHING FOR SPECIFIC DRIVE
	AH = 33h
	AL = drive number (00h=A:)
Return: AX = status (0000h successful)
SeeAlso: AH=22h"QUICKCACHE",AH=32h
--------c-1334-------------------------------
INT 13 U - QUICKCACHE II v4.20 - SECTOR LOCKING
	AH = 34h
	AL = function
	    00h end sector locking/unlocking
	    01h lock all accessed sectors into cache
	    02h unlock all accessed sectors and discard from cache
Return: AX = status (0000h successful)
SeeAlso: AH=20h"QUICKCACHE",AH=35h
--------c-1335-------------------------------
INT 13 U - QUICKCACHE II v4.20 - SET LOCK POOL SIZE
	AH = 35h
	BX = number of sectors in lock pool
Return: AX = status (0000h successful)
Desc:	specify the number of cache sector buffers which may be dedicated to
	  data locked into the cache
SeeAlso: AH=34h
--------c-1336-------------------------------
INT 13 U - QUICKCACHE II v4.20 - SET TRACE BUFFER SIZE
	AH = 36h
	AL = new size of trace buffer
Return: AX = status (0000h successful)
Note:	called with AL=05h during an INT 13/AH=24h"QUICKCACHE" call
SeeAlso: AH=24h"QUICKCACHE"
--------c-1337-------------------------------
INT 13 U - QUICKCACHE II v4.20 - SET BUFFERED READS FOR SPECIFIC DRIVE
	AH = 37h
	AL = new state (00h disabled, else enabled)
	DL = drive number (00h = A:)
Return: AX = status (0000h successful)
SeeAlso: AH=2Dh,AH=38h
--------c-1338-------------------------------
INT 13 U - QUICKCACHE II v4.20 - SET BUFFERED WRITES FOR SPECIFIC DRIVE
	AH = 38h
	AL = new state (00h disabled, else enabled)
	DL = drive number (00h = A:)
Return: AX = status (0000h successful)
SeeAlso: AH=2Ch,AH=37h
--------c-1339-------------------------------
INT 13 U - QUICKCACHE II v4.20 - SET READ BUFFER SIZE FOR SPECIFIC DRIVE
	AH = 39h
	AL = new size of read buffer
	DL = drive number (00h = A:)
Return: AX = status (0000h successful)
Program: QUICKCACHE II is a shareware disk cache by P.R. Glassel and
	  Associates, Inc.
SeeAlso: AH=2Ah,AH=3Ah
--------c-133A-------------------------------
INT 13 U - QUICKCACHE II v4.20 - SET WRITE BUFFER SIZE FOR SPECIFIC DRIVE
	AH = 3Ah
	AL = new size of write buffer
	DL = drive number (00h = A:)
Return: AX = status (0000h successful)
SeeAlso: AH=2Ah,AH=39h
--------c-133B-------------------------------
INT 13 U - QUICKCACHE II v4.20 - ENABLE/DISABLE ???
	AH = 3Bh
	AL = new state of ??? (01h enabled, else disabled)
Return: AX = status (0000h successful)
Note:	is affected by the flag reported at offset 05h of the system info
	  returned by AH=30h, and sets the flag at offset 06h
SeeAlso: AH=3Ch
--------c-133C-------------------------------
INT 13 U - QUICKCACHE II v4.20 - ENABLE/DISABLE ???
	AH = 3Ch
	AL = new state of ??? (01h enabled, else disabled)
Return: AX = status (0000h successful)
Note:	is affected by the flag reported at offset 05h of the system info
	  returned by AH=30h, and sets the flag at offset 07h
SeeAlso: AH=3Bh
--------c-133D-------------------------------
INT 13 U - QUICKCACHE II v4.20 - ENABLE/DISABLE CYLINDER FLUSH FOR DRIVE
	AH = 3Dh
	AL = new state (01h enabled, else disabled)
	DL = drive number (00h = A:)
Return: AX = status (0000h successful)
--------c-133E-------------------------------
INT 13 U - QUICKCACHE II v4.20 - SET SINGLE-SECTOR BONUS
	AH = 3Eh
	AL = new value for bonus
Return: AX = status (0000h successful)
Desc:	specify the bonus score to give to single-sector transfers in order to
	  keep those sectors in the cache longer
--------c-133F-------------------------------
INT 13 U - QUICKCACHE II v4.20 - SET BONUS THRESHOLD
	AH = 3Fh
	AL = new value for bonus threshold
Return: AX = status (0000h successful)
--------c-1340-------------------------------
INT 13 U - QUICKCACHE II v4.20 - SET "sticky_max"
	AH = 40h
	AL = new value for "sticky_max"
Return: AX = status (0000h successful)
SeeAlso: AH=41h"QUICKCACHE"
--------d-1341--BX55AA-----------------------
INT 13 - IBM/MS INT 13 Extensions - INSTALLATION CHECK
	AH = 41h
	BX = 55AAh
	DL = drive (80h-FFh)
Return:	CF set on error (not supported)
	    AH = 01h (invalid function)
	CF clear if successful
	    BX = AA55h if installed
	    AH = major version of extensions
		(01h = 1.x, 20h = 2.0/EDD-1.0, 21h = 2.1/EDD-1.1)
	    AL = internal use
	    CX = API subset support bitmap (see #0179)
	    DH = extension version (v2.0+ ??? -- not present in 1.x)
Note:	the Phoenix Enhanced Disk Drive Specification v1.0 uses version 2.0 of
	  the INT 13 Extensions API
SeeAlso: AH=42h"INT 13 Ext",AH=48h"INT 13 Ext"

Bitfields for IBM/MS INT 13 Extensions API support bitmap:
Bit(s)	Description	(Table 0179)
 0	extended disk access functions (AH=42h-44h,47h,48h) supported
 1	removable drive controller functions (AH=45h,46h,48h,49h,INT 15/AH=52h)
	  supported
 2	enhanced disk drive (EDD) functions (AH=48h,AH=4Eh) supported
	extended drive parameter table is valid (see #0181,#0184)
 3-15	reserved (0)
--------c-1341-------------------------------
INT 13 U - QUICKCACHE II v4.20 - SAVE/RESTORE ???
	AH = 41h
	AL = direction
	    01h save to file
	    else restore from file
	ES:DI -> 1024-byte buffer for ???
Return: AX = status (0000h successful, 8000h failed)
Program: QUICKCACHE II is a shareware disk cache by P.R. Glassel and
	  Associates, Inc.
SeeAlso: AH=40h"QUICKCACHE"
--------d-1342-------------------------------
INT 13 - IBM/MS INT 13 Extensions - EXTENDED READ
	AH = 42h
	DL = drive number
	DS:SI -> disk address packet (see #0180)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (see #0142)
	    disk address packet's block count field set to number of blocks
	      successfully transferred
SeeAlso: AH=02h,AH=41h"INT 13 Ext",AH=43h"INT 13 Ext"

Format of disk address packet:
Offset	Size	Description	(Table 0180)
 00h	BYTE	10h (size of packet)
 01h	BYTE	reserved (0)
 02h	WORD	number of blocks to transfer (max 007Fh for Phoenix EDD)
 04h	DWORD	-> transfer buffer
 08h	QWORD	starting absolute block number
		(for non-LBA devices, compute as
		  (Cylinder*NumHeads + SelectedHead) * SectorPerTrack +
		  SelectedSector - 1
--------N-134257DX1234-----------------------
INT 13 U - Beame&Whiteside BWLPD - INSTALLATION CHECK
	AX = 4257h ("BW")
	DX = 1234h
Return: BX = 414Ch if installed
Program: BWLPD is the printer daemon from the BW-NFS package
SeeAlso: INT 62/AH=00h"ETHDEV"
--------d-1343-------------------------------
INT 13 - IBM/MS INT 13 Extensions - EXTENDED WRITE
	AH = 43h
	AL = write flags
	   ---v1.0,2.0---
	   bit 0: verify write
	   bits 7-1 reserved (0)
	   ---v2.1---
	   00h,01h write without verify
	   02h write with verify
	DL = drive number
	DS:SI -> disk address packet (see #0180)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (see #0142)
	    disk address packet's block count field set to number of blocks
	      successfully transferred
Note:	the BIOS returns CF set/AH=01h (invalid function) if verify is
	  requested but not supported
SeeAlso: AH=03h,AH=41h"INT 13 Ext",AH=42h"INT 13 Ext",AH=44h
--------d-1344-------------------------------
INT 13 - IBM/MS INT 13 Extensions - VERIFY SECTORS
	AH = 44h
	DL = drive number
	DS:SI -> disk address packet (see #0180)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (see #0142)
	    disk address packet's block count field set to number of blocks
	      successfully verified
SeeAlso: AH=04h,AH=41h"INT 13 Ext",AH=42h"INT 13 Ext",AH=47h
--------d-1345-------------------------------
INT 13 - IBM/MS INT 13 Extensions - LOCK/UNLOCK DRIVE
	AH = 45h
	AL = operation
	    00h lock media in drive
	    01h unlock media
	    02h check lock status
	DL = drive number
Return: CF clear if successful
	    AH = 00h
	    AL = lock state (00h = unlocked)
	CF set on error
	    AH = error code (see #0142)
Notes:	this function is required to be supported for any removable drives
	  numbered 80h or higher
	up to 255 locks may be placed on a drive, and the media will not
	  be physically unlocked until all locks have been removed
SeeAlso: AH=41h"INT 13 Ext",AH=46h,AH=49h,INT 15/AH=52h"Phoenix"
--------d-1346-------------------------------
INT 13 - IBM/MS INT 13 Extensions - EJECT MEDIA
	AH = 46h
	AL = 00h (reserved)
	DL = drive number
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (see #0142)
SeeAlso: AH=49h,INT 15/AH=52h"Phoenix"
--------d-1347-------------------------------
INT 13 - IBM/MS INT 13 Extensions - EXTENDED SEEK
	AH = 47h
	DL = drive number
	DS:SI -> disk address packet (see #0180)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (see #0142)
SeeAlso: AH=0Ch,AH=42h"INT 13 Ext"
--------d-1348-------------------------------
INT 13 - IBM/MS INT 13 Extensions - GET DRIVE PARAMETERS
	AH = 48h
	DL = drive (80h-FFh)
	DS:SI -> buffer for drive parameters (see #0181)
Return: CF clear if successful
	    AH = 00h
	    DS:SI buffer filled
	CF set on error
	    AH = error code (see #0142)
SeeAlso: AH=08h,AH=41h,AH=49h

Format of IBM/MS INT 13 Extensions drive parameters:
Offset	Size	Description	(Table 0181)
 00h	WORD	(call) size of buffer (001Ah for v1.x, 001Eh for v2.x)
		(ret) size of returned data
 02h	WORD	information flags (see #0182)
 04h	DWORD	number of cylinders on drive
 08h	DWORD	number of heads on drive
 0Ch	DWORD	number of sectors per track
 10h	QWORD	total number of sectors on drive
 18h	WORD	bytes per sector
---v2.0+ ---
 1Ah	DWORD	-> configuration parameters (see #0184)
		FFFFh:FFFFh if not available
Note:	if the size is less than 30 on call, the final DWORD will not be
	  returned by a v2.x implementation
SeeAlso: #0183,#2385

Bitfields for IBM/MS INT 13 Extensions information flags:
Bit(s)	Description	(Table 0182)
 0	DMA boundary errors handled transparently
 1	cylinder/head/sectors-per-track information is valid
 2	removable drive
 3	write with verify supported
 4	drive has change-line support (required if drive >= 80h is removable)
 5	drive can be locked (required if drive >= 80h is removable)
 6	CHS information set to maximum supported values, not current media
 15-7	reserved (0)

Format of Phoenix Enhanced Disk Drive Spec translated drive parameter table:
Offset	Size	Description	(Table 0183)
 00h	WORD	number of cylinders
 02h	BYTE	number of heads
 03h	BYTE	A0h (signature indicating translated table)
 04h	BYTE	number of physical sectors per track
 05h	WORD	starting write precompensation cylinder number
 07h	BYTE	reserved
 08h	BYTE	control byte (see #2387 at INT 41)
 09h	WORD	number of physical cylinders
 0Bh	BYTE	number of physical heads
 0Ch	WORD	cylinder number of landing zone
 0Eh	BYTE	number of logical sectors per track
 0Fh	BYTE	checksum
Program: the Phoenix Enhanced Disk Drive Specification is an addition to the
	  IBM/MS INT 13 extensions
SeeAlso: #0184,#2385

Format of Phoenix Enhanced Disk Drive Spec Fixed Disk Parameter Table:
Offset	Size	Description	(Table 0184)
 00h	WORD	physical I/O port base address
 02h	WORD	disk-drive control port address
 04h	BYTE	drive flags (see #0185)
 05h	BYTE	proprietary information
		bits 7-4 reserved (0)
		bits 3-0: Phoenix proprietary (used by BIOS)
 06h	BYTE	IRQ (bits 3-0; bits 7-4 reserved and must be 0)
 07h	BYTE	sector count for multi-sector transfers
 08h	BYTE	DMA control
		bits 7-4: DMA type (0-2) as per ATA-2 specification
		bits 3-0: DMA channel
 09h	BYTE	programmed I/O control
		bits 7-4: reserved (0)
		bits 3-0: PIO type (1-4) as per ATA-2 specification
 0Ah	WORD	drive options (see #0186)
 0Ch  2 BYTEs	reserved (0)
 0Eh	BYTE	extension revision level (high nybble=major, low nybble=minor)
		(currently 10h for v1.0 and 11h for v1.1)
 0Fh	BYTE	2's complement checksum of bytes 00h-0Eh
		8-bit sum of all bytes 00h-0Fh should equal 00h
SeeAlso: #0183

Bitfields for Phoenix Enhanced Disk Drive Spec drive flags:
Bit(s)	Description	(Table 0185)
 7	reserved (1)
 6	LBA enabled
 5	reserved (1)
 4	drive is slave
 3-0	reserved (0)
SeeAlso: #0184,#0186

Bitfields for Phoenix Enhanced Disk Drive Spec drive options:
Bit(s)	Description	(Table 0186)
 0	fast PIO enabled
 1	fast DMA access enabled
 2	block PIO (multi-sector transfers) enabled
 3	CHS translation enabled
 4	LBA translation enabled
 5	removable media
 6	ATAPI device (CD-ROM)
 7	32-bit transfer mode
---v1.1---
 8	ATAPI device uses DRQ to signal readiness for packet command
	(must be 0 if bit 6 is 0)
 10-9	translation type (must be 00 if bit 3 is 0)
	00 Phoenix bit-shifting translation
	01 LBA-assisted translation
	10 reserved
	11 proprietary translation
 15-8	reserved
SeeAlso: #0184,#0185
--------d-1349-------------------------------
INT 13 - IBM/MS INT 13 Extensions - EXTENDED MEDIA CHANGE
	AH = 49h
	DL = drive number
Return: CF clear if media has not changed
	    AH = 00h
	CF set if media may have changed
	    AH = 06h (see #0142)
Note:	unlike AH=16h, any drive number may be specified
SeeAlso: AH=16h,AH=41h"INT 13 Ext",AH=46h
--------d-134A-------------------------------
INT 13 - Bootable CD-ROM - INITIATE DISK EMULATION
	AH = 4Ah
	AL = 00h
	DS:SI -> specification packet (see #0187)
Return: CF clear if successful
	CF set on error (drive will not be in emulation mode)
	AX = return codes
SeeAlso: AH=48h,AX=4B00h,AH=4Ch,AH=4Dh

Format of Bootable CD-ROM Specification Packet:
Offset	Size	Description	(Table 0187)
 00h	BYTE	size of packet in bytes (13h)
 01h	BYTE	boot media type (see #0188)
 02h	BYTE	drive number
		(00h floppy image, 80h bootable hard disk, 81h-FFh nonbootable)
 03h	BYTE	CD-ROM controller number
 04h	DWORD	Logical Block Address of disk image to emulate
 08h	WORD	device specification (see also #0188)
		(IDE) bit 0: drive is slave instead of master
		(SCSI)	bits 7-0: LUN and PUN
			bits 15-8: bus number
 0Ah	WORD	segment of 3K buffer for caching CD-ROM reads
 0Ch	WORD	load segment for initial boot image
		if 0000h, load at segment 07C0h
 0Eh	WORD	number of 512-byte virtual sectors to load
		(only valid for AH=4Ch)
 10h	BYTE	low byte of cylinder count (for INT 13/AH=08h)
 11h	BYTE	sector count, high bits of cylinder count (for INT 13/AH=08h)
 12h	BYTE	head count (for INT 13/AH=08h)
SeeAlso: #0189,AH=08h

Bitfields for Bootable CD-ROM boot media type:
Bit(s)	Description	(Table 0188)
 3-0	media type
	0000 no emulation
	0001 1.2M diskette
	0010 1.44M diskette
	0011 2.88M diskette
	0100 hard disk (drive C:)
	other reserved
 5-4	reserved (0)
 6	image contains ATAPI driver
 7	image contains SCSI driver(s)
SeeAlso: #0187
--------d-134B00-----------------------------
INT 13 - Bootable CD-ROM - TERMINATE DISK EMULATION
	AX = 4B00h
	DL = drive number or 7Fh to terminate all emulations
	DS:SI -> empty specification packet (see #0187)
Return: CF clear if successful
	CF set on error (drive will still be in emulation mode)
	AX = return codes
	DS:SI specification packet filled
SeeAlso: AH=48h,AH=4Ah,AX=4B00h,AH=4Ch,AH=4Dh
--------d-134B01-----------------------------
INT 13 - Bootable CD-ROM - GET STATUS
	AX = 4B01h
	DL = drive number or 7Fh to terminate all emulations
	DS:SI -> empty specification packet (see #0187)
Return: CF clear if successful
	CF set on error
	AX = return codes
	DS:SI specification packet filled
Note:	same as AX=4B00h, but does not terminate emulation
SeeAlso: AH=48h,AH=4Ah,AX=4B00h,AH=4Ch,AH=4Dh
--------d-134C-------------------------------
INT 13 - Bootable CD-ROM - INITIATE DISK EMULATION AND BOOT
	AH = 4Ch
	AL = 00h
	DS:SI -> specification packet (see #0187)
Return: never if successful
	CF set (error while attempting to boot)
	AX = error codes
SeeAlso: AH=48h,AH=4Ah,AX=4B00h,AH=4Dh
--------d-134D-------------------------------
INT 13 - Bootable CD-ROM - RETURN BOOT CATALOG
	AH = 4Dh
	AL = 00h
	DS:SI -> command packet (see #0189)
Return: CF clear if successful
	CF set on error
	AX = return codes
SeeAlso: AH=48h,AH=4Ah,AX=4B00h,AH=4Ch

Format of Bootable CD-ROM "get boot catalog" command packet:
Offset	Size	Description	(Table 0189)
 00h	BYTE	size of packet in bytes (08h)
 01h	BYTE	number of sectors of boot catalog to read
 02h	DWORD	-> buffer for boot catalog
 06h	WORD	first sector in boot catalog to transfer
SeeAlso: #0187
--------d-134E-------------------------------
INT 13 - IBM/MS INT 13 Extensions v2.1 - SET HARDWARE CONFIGURATION
	AH = 4Eh
	AL = function
	    00h enable prefetch
	    01h disable prefetch
	    02h set maximum PIO transfer mode
	    03h set PIO mode 0
	    04h set default PIO transfer mode
	    05h enable INT 13 DMA maximum mode
	    06h disable INT 13 DMA
	DL = drive number
Return: CF clear if successful
	    AH = 00h
	    AL = status
		00h command was safe (only affected specified drive)
		01h other devices are affected
	CF set on error
	    AH = error code (see #0142)
Note:	DMA and PIO modes are mutually exclusive, so selecting DMA disables
	  PIO (for either the specified device or all devices on that
	  controller), and selecting PIO disables DMA
SeeAlso: AH=41h"INT 13 Extensions"
--------v-135001------------------------
INT 13 - VIRUS - "Andropinis" - INSTALLATION CHECK
	AX = 5001h
Return: AX = 0150h if resident
SeeAlso: AX=FD50h"VIRUS",INT 21/AX=0B56h
--------v-135342CX0001-----------------------
INT 13 - ScanBoot - INSTALLATION CHECK
	AX = 5342h ("SB")
	CX = 0001h
	DX = 0000h
Return: CF clear if ScanBoot installed
	   AX = 0000h
	   CX = serial number ("SW" if shareware release)
	   DX = version
	   BX,SI,ES destroyed
Program: ScanBoot is a virus-detection TSR by PanSoft
--------d-135501-----------------------------
INT 13 - Seagate ST01/ST02 - Inquiry
	AX = 5501h
	DH = number of bytes to transfer
	DL = drive ID (80h, 81h, ...)
	ES:BX -> buffer for results
Return:	ES:BX buffer filled with the Inquiry results
Notes:	the ST01/ST02 BIOS does not return any success/failure indication,
	  so all commands must be assumed to have been successful
	the ST01/ST02 BIOS always maps its drives after the previous BIOS
	  drives without changing the BIOS drive count at 0040h:0075h
	this command is identical to the SCSI Inquiry command
--------d-135502-----------------------------
INT 13 - Seagate ST01/ST02 - RESERVED
	AX = 5502h
--------d-135503-----------------------------
INT 13 - Seagate ST01/ST01 - Set Device Type Qualifier (DTQ)
	AX = 5503h
	DH = DTQ byte (see #0190)
	DL = drive ID (80h, 81h, ...)
Return:	nothing

Bitfields for DTQ byte:
Bit(s)	Description	(Table 0190)
 7	reserved
 6	SCSI drive attached
 5	reserved
 4	selected drive is ST225N/NP (Paired)
 3	selected drive is ST225N
 2	Host Adapter checks parity on the selected drive
 1	selected drive has been installed
 0	Seagate installation software present
--------d-135504-----------------------------
INT 13 U - Seagate - ??? - RETURN IDENTIFICATION
	AX = 5504h
	DX = drive (bit 7 set for hard disk)
Return: CF clear if successful
	    AX = 4321h if ST01/ST02h
	    AX = 4322h if ??? Seagate controller
	CF set on error
SeeAlso: AX=5505h,AX=5514h
--------d-135504-----------------------------
INT 13 - Seagate ST01/ST02 - RETURN IDENTIFICATION
	AX = 5504h
	DL = drive ID (80h, 81h, ...)
Return:	AX = 4321h
	BL = selected drive number (00h, 01h)
	BH = number of drives attached to Host Adapter (max. 2)
--------d-135505-----------------------------
INT 13 - Seagate - ??? - PARK HEADS
	AX = 5505h
	DX = drive (bit 7 set for hard disk)
Return: CF clear if successful
	CF set on error
SeeAlso: AX=5504h,AX=5515h
--------d-135505-----------------------------
INT 13 - Seagate ST01/ST02 - PARK HEADS
	AX = 5505h
	DL = drive ID (80h, 81h, ...)
	DH = subfunction
	    00h park heads (SCSI Stop command)
	    01h un-park heads (SCSI Start command)
Return:	nothing
--------d-135506-----------------------------
INT 13 - Seagate ST01/ST02 - SCSI Bus Parity
	AX = 5506h
	DL = drive ID (80h, 81h, ...)
	DH = subfunction
	    00h disable parity check
	    01h enable parity check
	    02h return current parity setting
Return:	AL = status
	    00h parity checking disabled
	    01h parity checking enabled
--------d-135507-----------------------------
INT 13 - Seagate ST01/ST02 - RESERVED FUNCTIONS
	AX = 5507h to 550Dh
Note:	officially listed as "reserved"
--------d-135514-----------------------------
INT 13 U - Seagate - ???
	AX = 5514h
	DX = drive (bit 7 set for hard disk)
Return: CF clear if successful
	CF set on error
	AX = return value (FEBEh,FEBFh,FEDAh,FEDBh)
SeeAlso: AX=5504h,AX=5515h
--------d-135515-----------------------------
INT 13 U - Seagate - PARK HEADS???
	AX = 5515h
	DX = drive (bit 7 set for hard disk)
Return: CF clear if successful
	CF set on error
Note:	appears to be identical to AX=5505h
SeeAlso: AX=5504h,AX=5505h
--------d-1359-------------------------------
INT 13 - SyQuest - Generic SCSI pass through
	AH = 59h
	CX = HOST_ID, 0-based
	DX = 80h
	ES:BX pointer to SCSI structure (see #0191)
Return: CF clear
	AH = 95h
SeeAlso: AH=12h"SyQuest",AH=13h"SyQuest",AH=1Fh"SyQuest"

Format of SyQuest SCSI structure:
Offset	Size	Description	(Table 0191)
 00h	WORD	opcode (see #0192)
 02h	BYTE	target's SCSI ID
 03h	BYTE	target's logical unit number
 04h	BYTE	data direction (00h no data xfer, 01h data in, FFh data out)
 05h	BYTE	host status
		00h successful
		01h selection time out
		02h data over-run or under-run
 06h	BYTE	target status at command completion
		00h successful
		02h check status
		08h busy
 07h	BYTE	command data block length
 08h	DWORD	request data length
 0Ch	DWORD	result data length (actual length of data transferred)
 10h	DWORD	-> CDB
 14h	DWORD	-> data buffer
Note:	The handler does not perform a 'Request Sense' command if there was an error

(Table 0192)
Values for SCSI opcode:
 00h	verify interface
	clears carry flag and returns if function is available
 01h	returns the ID of the INT 13h Handler in a NULL terminated string of
	length less than 40 byte including the terminator.
	The string is stored in the buffer pointed by p_buf.
 02h	device mapping info. The caller provides a one byte buffer.
	The handler stores the Int 13h Device ID (80h or above) in the buffer.
	It stores 0 if that target does not exists.
 03h	execute SCSI command
 04h	device reset
 05h	SCSI bus reset
--------d-1370-------------------------------
INT 13 - Priam EDVR.SYS DISK PARTITIONING SOFTWARE???
	AH = 70h
	???
Return: ???
Note:	Priam's EDISK.EXE (FDISK replacement) and EFMT.EXE (low-level
	  formatting program) make this call, presumably to EDVR.SYS (the
	  partitioning driver)
SeeAlso: AH=ADh
----------1375-------------------------------
INT 13 - ???
	AH = 75h
	???
Return: AH = ???
	???
Note:	intercepted by PC-Cache (v5.1 only)
----------1376-------------------------------
INT 13 - ???
	AH = 76h
	???
Return: AH = ???
	???
Note:	intercepted by PC-Cache (v5.1 only)
--------c-137B00-----------------------------
INT 13 - NOW! v3.05 - GET INFORMATION
	AX = 7B00h
	CX:DX -> 1F8h-byte buffer for information record (see #0193)
Return: AX = 0000h
	BX = segment of main resident code
	ES = ???
Program: NOW! is a disk cache by Vertisoft Systems, Inc.
SeeAlso: AX=7B02h,AH=EFh

Format of NOW! information record:
Offset	Size	Description	(Table 0193)
 00h 80 BYTEs	name of directory from which NOW! was started
 50h 424 BYTEs	???
 81h  ? BYTEs	array of bytes for ???
 F7h 250 BYTEs	array of 25 entries, one per drive???
	Offset	Size	Description
	 00h  2 BYTEs	???
	 02h	WORD	???
	 04h	WORD	???
	 06h  4 BYTEs	???
1F1h  7 BYTEs	???
--------c-137B01-----------------------------
INT 13 - NOW! v3.05 - ???
	AX = 7B01h
Return: DX = segment of ???
SeeAlso: AX=7B00h
--------c-137B02-----------------------------
INT 13 - NOW! v3.05 - SET INFORMATION
	AX = 7B02h
	BX = segment of ??? (10h above a PSP)
	CX:DX -> 1F8h-byte information record (see #0193)
Return: ???
Program: NOW! is a disk cache by Vertisoft Systems, Inc.
Note:	NOW! grabs the INT 24h value from the PSP reached via the segment in
	  BX
SeeAlso: AX=7B00h
--------c-137B03-----------------------------
INT 13 - NOW! v3.05 - ???
	AX = 7B03h
	???
Return: ???
SeeAlso: AX=7B00h,AX=7B04h
--------c-137B04-----------------------------
INT 13 - NOW! v3.05 - ???
	AX = 7B04h
	???
Return: ???
SeeAlso: AX=7B03h
--------c-137B05-----------------------------
INT 13 - NOW! v3.05 - GET DISK ACCESSES???
	AX = 7B05h
Return: BX:AX = number of physical accesses???
	DX:CX = total disk accesses???
SeeAlso: AX=7B00h,AX=7B06h
--------c-137B06-----------------------------
INT 13 - NOW! v3.05 - GET ???
	AX = 7B06h
	BX = ???
Return: AX = 0000h
	BX = ???
SeeAlso: AX=7B05h,AX=7B07h
--------c-137B07-----------------------------
INT 13 - NOW! v3.05 - GET ???
	AX = 7B07h
Return: AX = ???
	BX = ???
	CX = ???
	DX = ???
SeeAlso: AX=7B06h
--------c-137B08-----------------------------
INT 13 - NOW! v3.05 - ???
	AX = 7B08h
	CX = ??? (default 00h)
Return: ???
SeeAlso: AX=7B00h
--------c-1380--CX6572-----------------------
INT 13 - FAST! v4.02+ - API
	AH = 80h
	CX = 6572h
	DX = 1970h
	ES:BX -> request packet (see #0195)
	AL = function number (see #0194)
Return: AH = status (except function 06h)
	    00h if successful
	    01h invalid function
	    05h not supported by the installed variant
	CF clear if successful
	CF set on error
	AL may be destroyed
Program: FAST! is a disk cache by Future Computing Systems and marketed by BLOC
	  Publishing Corp.
SeeAlso: AX=8001h,AX=8006h,AX=8007h
Index:	hotkeys;FAST!

(Table 0194)
Values for FAST! function:
 01h	get cache information (see separate entry)
 04h	disable cache
 05h	enable cache and reset statistics
 06h	installation check (see separate entry)
 07h	unhook interrupts (see separate entry)
 09h	flush cache
 0Ah	(v4.02+) enable staged writes
 0Bh	(v4.02+) disable staged writes
 0Ch	(v4.02+) enable beep on flush
 0Dh	(v4.02+) disable beep on flush
 0Eh	???
 0Fh	???
 10h	(v4.12+) enable hotkeys
 11h	(v4.12+) disable hotkeys
 12h	(v4.13+) set idle delay
 13h	(v4.13+) set flush dirty percentage
 14h	(v5.00+) enable mouse checks
 15h	(v5.00+) disable mouse checks
 16h	(v5.00d+) reduce cache size to minimum
 17h	(v5.00d+) increase cache size to maximum

Format of FAST! request packet:
Offset	Size	Description	(Table 0195)
 00h	DWORD	pointer to 19-byte signature string (see #0196)
 04h	DWORD	pointer to buffer for data (if needed by function)

(Table 0196)
Values for FAST! v4.04-v5.03 signature string:
 13h 07h 06h 08h 11h 18h 0Fh 0Eh 02h 18h 13h 08h 0Bh 08h 01h 00h 04h 08h 15h
--------c-138001CX6572-----------------------
INT 13 - FAST! v4.02+ - GET CACHE INFORMATION
	AX = 8001h
	CX = 6572h
	DX = 1970h
	ES:BX -> request packet (see #0197)
Return: AH = 00h if successful
SeeAlso: AH=80h,AX=8006h

Format of FAST! request packet:
Offset	Size	Description	(Table 0197)
 00h	DWORD	-> 19-byte signature string (see #0196)
 04h	DWORD	-> buffer for cache information (see #0198)

Format of FAST! cache information (v5.00-5.03):
Offset	Size	Description	(Table 0198)
 00h	WORD	binary version number of FAST! (v5.00 = 01F4h)
 02h	BYTE	revision letter (61h = X.XXa, 62h = X.XXb, etc.)
 03h	BYTE	FAST! variant
		(01h = FASTE, 02h = FASTX BIOS, 04h = FASTC, 20h = FASTX XMS)
 04h	DWORD	total number of read requests
 08h	DWORD	number of physical disk reads
 0Ch	DWORD	grabbed hash buckets
 10h	DWORD	"st_386mem"
 14h	DWORD	total number of writes (only counted when staging enabled)
 18h	DWORD	number of physical disk writes (only when staging enabled)
 1Ch	DWORD	number of write errors while flushing cache
 20h	WORD	flags1 (see #0199)
 22h	WORD	flags
		bit 0: ???
		bit 1: staged writes enabled
 24h	WORD	???
 26h	WORD	maximum cache size in KB
 28h	WORD	minimum cache size in KB
 2Ah	WORD	segment of first cache buffer (FASTC)
		segment of EMS page frame (FASTE)
		XMS handle (FASTX XMS)
 2Ch	WORD	number of hash buckets containing no entries
 2Eh	WORD	number of hash buckets containing one entry
 30h	WORD	number of hash buckets containing two entries
 32h	WORD	number of hash buckets containing three entries
 34h	WORD	number of hash buckets containing four entries
 36h	WORD	number of hash buckets containing five entries
 38h	WORD	maximum contiguous sectors
 3Ah	WORD	hash factor
 3Ch	WORD	number of paragraphs of memory used below 1M
 3Eh	WORD	entries per hash bucket
 40h	WORD	idle delay in seconds
 42h  2 BYTEs	???
 44h	WORD	staged write threshold percentage
 46h  2 BYTEs	???
 48h	WORD	number of dirty sectors
 4Ah	WORD	number of staged write buffers
 4Ch	WORD	current cache size in KB
 4Eh	WORD	beep frequency in Hz
 50h	WORD	???
 52h	WORD	???

Bitfields for FAST! flags1:
Bit(s)	Description	(Table 0199)
 0	beep on flush
 3	hotkeys enabled
 4	mouse idle check enabled
 8	caching enabled
 13	???
--------c-138006CX6572-----------------------
INT 13 - FAST! v4.02+ - INSTALLATION CHECK
	AX = 8006h
	CX = 6572h
	DX = 1970h
	ES:BX -> request packet (see #0200)
Return: AX = 1965h if installed
SeeAlso: AH=80h,AX=8001h,AX=8007h

Format of FAST! request packet:
Offset	Size	Description	(Table 0200)
 00h	DWORD	-> 19-byte signature string (see #0196)
--------c-138007CX6572-----------------------
INT 13 - FAST! v4.02+ - UNHOOK INTERRUPTS
	AX = 8007h
	CX = 6572h
	DX = 1970h
	ES:BX -> request packet (see #0201)
Return: AX = 1965h if installed
SeeAlso: AH=80h,AX=8006h
Index:	uninstall;FAST!

Format of FAST! request packet:
Offset	Size	Description	(Table 0201)
 00h	DWORD	-> 19-byte signature string (see #0196)
--------c-1381--SI4358-----------------------
INT 13 - Super PC-Kwik v3.20+ - ???
	AH = 81h
	SI = 4358h
	???
Return: ???
Note:	PC Tools PC-Cache 5.x and Qualitas Qcache 4.00 are OEM versions of
	  Super PC-Kwik, and thus support this call (PC-Cache v5.1 corresponds
	  to PC-Kwik v3.20 and PC-Cache v5.5 to PC-Kwik v3.27)
	returns immediately in PC-Cache v5.x
Index:	PC-Cache|Qualitas Qcache
--------c-1382--SI4358-----------------------
INT 13 - Super PC-Kwik v3.20+ - ???
	AH = 82h
	SI = 4358h
	???
Return: AL = ???
Note:	PC Tools PC-Cache 5.x and Qualitas Qcache 4.00 are OEM versions of
	  Super PC-Kwik, and thus support this call
SeeAlso: AH=84h
Index:	PC-Cache|Qualitas Qcache
--------c-1383--SI4358-----------------------
INT 13 - Super PC-Kwik v3.20+ - ???
	AH = 83h
	SI = 4358h
	AL = ???
	ES:BX -> ???
	???
Return: ???
Note:	PC Tools PC-Cache 5.x and Qualitas Qcache 4.00 are OEM versions of
	  Super PC-Kwik, and thus support this call
SeeAlso: AH=85h
Index:	PC-Cache|Qualitas Qcache
--------c-1384--SI4358-----------------------
INT 13 - Super PC-Kwik v3.20+ - ???
	AH = 84h
	SI = 4358h
	AL = ???
	???
Return: AL = ???
Note:	PC Tools PC-Cache 5.x and Qualitas Qcache 4.00 are OEM versions of
	  Super PC-Kwik, and thus support this call
SeeAlso: AH=82h
Index:	PC-Cache|Qualitas Qcache
--------c-1385--SI4358-----------------------
INT 13 - Super PC-Kwik v3.20+ - ???
	AH = 85h
	SI = 4358h
	AL = ???
	DL = ???
	???
Return: ???
Note:	PC Tools PC-Cache 5.x and Qualitas Qcache 4.00 are OEM versions of
	  Super PC-Kwik, and thus support this call (PC-Cache v5.1 corresponds
	  to PC-Kwik v3.20)
SeeAlso: AH=83h
Index:	PC-Cache|Qualitas Qcache
--------c-1386--SI4358-----------------------
INT 13 - Super PC-Kwik v4.00+ - ???
	AH = 86h
	SI = 4358h
	???
Return: ???
Note:	Qualitas Qcache v4.00 is an OEM version of Super PC-Kwik v4.00, and
	  thus supports this call
Index:	Qualitas Qcache
--------c-1387--SI4358-----------------------
INT 13 - Super PC-Kwik v4.00+ - ???
	AH = 87h
	SI = 4358h
	???
Return: AH = status??? (00h)
	CX = ???
	DX = ??? (0000h)
Note:	Qualitas Qcache v4.00 is an OEM version of Super PC-Kwik v4.00, and
	  thus supports this call
Index:	Qualitas Qcache
--------c-1388--SI4358-----------------------
INT 13 - Super PC-Kwik v4.00+ - ???
	AH = 88h
	SI = 4358h
	???
Return: AH = status??? (00h)
	CX = ???
	DX = ??? (0000h)
Note:	Qualitas Qcache v4.00 is an OEM version of Super PC-Kwik v4.00, and
	  thus supports this call
Index:	Qualitas Qcache
--------c-1389--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 89h
	SI = 4358h
	???
Return: ???
--------c-138A--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 8Ah
	SI = 4358h
	???
Return: ???
--------c-138EED-----------------------------
INT 13 - HyperDisk v4.01+ - ???
	AX = 8EEDh
	???
Return: ???
Program: HyperDisk is a shareware disk cache by HyperWare (Roger Cross)
SeeAlso: AX=8EEEh,AX=8EEFh,AH=EEh,INT 2F/AH=DFh
--------c-138EEE-----------------------------
INT 13 - HyperDisk v4.01+ - ???
	AX = 8EEEh
Return: CF set
	AX = CS of HyperDisk resident code
	???
Note:	identical to AX=8EEFh in HYPERDKX v4.21-4.30
SeeAlso: AX=8EEDh,AX=8EEFh,AH=EEh
--------c-138EEF-----------------------------
INT 13 - HyperDisk v4.01+ - ???
	AX = 8EEFh
Return: CF set
	AX = CS of HyperDisk resident code
	???
Note:	identical to AX=8EEEh in HYPERDKX v4.21-4.30
SeeAlso: AX=8EEDh,AX=8EEEh,AH=EEh
--------c-1392--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 92h
	SI = 4358h
	???
Return: AH = status??? (00h)
	DL = ???
SeeAlso: AH=93h
--------c-1393--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 93h
	SI = 4358h
	???
Return: AH = status??? (00h)
	AL = ???
SeeAlso: AH=92h
--------c-1394--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 94h
	SI = 4358h
	???
Return: ???
--------c-1395--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 95h
	SI = 4358h
	???
Return: AH = status??? (00h)
	DX = ???
--------c-1396--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 96h
	SI = 4358h
	AL = ??? (01h)
	BX = ??? (0790h)
	DL = ???
Return: AH = status??? (00h)
	DX = ???
--------c-1397--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 97h
	SI = 4358h
	???
Return: ???
--------c-1398--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 98h
	SI = 4358h
	???
Return: ???
--------c-1399--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 99h
	SI = 4358h
	???
Return: ???
--------c-139A--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 9Ah
	SI = 4358h
	???
Return: ???
--------c-139B--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 9Bh
	SI = 4358h
	???
Return: ???
--------c-139C--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 9Ch
	SI = 4358h
	???
Return: ???
Note:	functions 9Ch and 9Dh are the only ones which are fully reentrant; all
	  other PC-Kwik API calls (INT 13/81h-B0h) return AX=0200h and CF clear
	  if a previous call is still in progress
--------c-139D--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = 9Dh
	SI = 4358h
	???
Return: ???
--------c-13A0--SI4358-----------------------
INT 13 - Super PC-Kwik v3.20+ - GET RESIDENT CODE SEGMENT
	AH = A0h
	SI = 4358h
Return: AX = segment of resident code
Note:	PC Tools PC-Cache 5.x and Qualitas Qcache 4.00 are OEM versions of
	  Super PC-Kwik, and thus support this call (note that PC-Cache v5.5
	  corresponds to PC-Kwik v3.27)
SeeAlso: INT 16/AX=FFA5h/CX=1111h
Index:	PC-Cache|Qualitas Qcache
--------c-13A1--SI4358-----------------------
INT 13 - Super PC-Kwik v3.20+ - FLUSH CACHE
	AH = A1h
	SI = 4358h
Return: CF clear
	AH = 00h (v5.10)
Note:	PC Tools PC-Cache 5.x and Qualitas Qcache 4.00 are OEM versions of
	  Super PC-Kwik, and thus support this call (note that PC-Cache v5.1
	  corresponds to PC-Kwik v3.20)
SeeAlso: INT 16/AX=FFA5h/CX=FFFFh
Index:	PC-Cache|Qualitas Qcache
--------c-13A2--SI4358-----------------------
INT 13 - Super PC-Kwik v3.20+ - ???
	AH = A2h
	SI = 4358h
	???
Return: ???
Note:	PC Tools PC-Cache 5.x and Qualitas Qcache 4.00 are OEM versions of
	  Super PC-Kwik, and thus support this call (note that PC-Cache v5.1
	  corresponds to PC-Kwik v3.20)
Index:	PC-Cache|Qualitas Qcache
--------c-13A3--SI4358-----------------------
INT 13 U - Super PC-Kwik v5.10+ - DISABLE CACHE
	AH = A3h
	SI = 4358h
Return: CF clear
SeeAlso: AH=A4h
--------c-13A4--SI4358-----------------------
INT 13 U - Super PC-Kwik v5.10+ - ENABLE CACHE
	AH = A4h
	SI = 4358h
Return: CF clear
SeeAlso: AH=A3h
--------c-13A5--SI4358-----------------------
INT 13 CU - Super PC-Kwik v5.10+ - PROGRAM TERMINATION NOTIFICATION
	AH = A5h
	SI = 4358h
Return: AX = ???
	SI = ???
Notes:	called and used internally by Super PC-Kwik when a program terminates
	  via INT 21/AH=00h, INT 21/AH=31h, or INT 21/AH=4Ch
	this call is not supported by Qualitas Qcache 4.00
Index:	PC-Cache
SeeAlso: AH=A6h,AH=A9h,INT 21/AH=00h,INT 21/AH=31h,INT 21/AH=4Ch
--------c-13A6--SI4358-----------------------
INT 13 CU - Super PC-Kwik v5.10+ - PROGRAM LOAD NOTIFICATION
	AH = A6h
	SI = 4358h
	DS:DX -> ASCIZ program name
	ES:BX -> EXEC data block (see #0897 at INT 21/AH=4Bh)
Return: ???
Note:	called and used internally by Super PC-Kwik when a program is loaded
	  with INT 21/AX=4B00h
SeeAlso: AH=A5h,AH=A9h,INT 21/AH=4Bh
--------c-13A7--SI4358-----------------------
INT 13 CU - Super PC-Kwik 5.1 - ???
	AH = A7h
	SI = 4358h
Return: ???
Note:	called and used internally by Super PC-Kwik on some INT 21 calls
SeeAlso: AH=A5h,AH=A6h,AH=A8h
--------v-13A759-----------------------------
INT 13 U - Novell DOS 7 - SDRes v27.03 - ???
	AX = A759h
Return: AX = 59A7h if installed
	    DX:BX -> ??? data
Program: SDRes is the resident portion of the Search&Destroy antiviral by
	  Fifth Generation Systems, as bundled with Novell DOS 7
SeeAlso: INT 21/AH=0Eh/DL=ADh
--------c-13A8--SI4358-----------------------
INT 13 CU - Super PC-Kwik 5.1 - ???
	AH = A8h
	SI = 4358h
Return: ???
Note:	called and used internally by Super PC-Kwik on some INT 21 calls
SeeAlso: AH=A5h,AH=A6h,AH=A7h
--------c-13A9--SI4358-----------------------
INT 13 CU - Super PC-Kwik 5.1 - EXITCODE RETRIEVAL NOTIFICATION
	AH = A9h
	SI = 4358h
Return: ???
Note:	called and used internally by Super PC-Kwik when an application issues
	  INT 21/AH=4Dh
SeeAlso: AH=A5h,AH=A6h,INT 21/AH=4Dh
--------c-13AA--SI4358-----------------------
INT 13 - Super PC-Kwik v4+ - ???
	AH = AAh
	SI = 4358h
	???
Return: ???
Note:	Qualitas Qcache is an OEM version of Super PC-Kwik, and thus supports
	  this call
--------c-13AB--SI4358-----------------------
INT 13 - Super PC-Kwik v4+ - ???
	AH = ABh
	SI = 4358h
	???
Return: ???
Note:	Qualitas Qcache is an OEM version of Super PC-Kwik, and thus supports
	  this call
--------c-13AC--SI4358-----------------------
INT 13 - Super PC-Kwik v4+ - ???
	AH = ACh
	SI = 4358h
	???
Return: ???
Note:	Qualitas Qcache is an OEM version of Super PC-Kwik, and thus supports
	  this call
--------d-13AD-------------------------------
INT 13 - Priam HARD DISK CONTROLLER???
	AH = ADh
	???
Return: ???
Note:	this call is made from Priam's EFMT.EXE (low-level formatter), probably
	  to check the ROM type on the controller for their hard disk kits
SeeAlso: AH=70h
--------c-13AD--SI4358-----------------------
INT 13 - Super PC-Kwik v4+ - ???
	AH = ADh
	SI = 4358h
	???
Return: ???
Note:	Qualitas Qcache is an OEM version of Super PC-Kwik, and thus supports
	  this call
--------c-13AE--SI4358-----------------------
INT 13 - Super PC-Kwik v5.10+ - ???
	AH = AEh
	SI = 4358h
	???
Return: ???
--------c-13B0--SI4358-----------------------
INT 13 - Super PC-Kwik v3.20+ - ???
	AH = B0h
	SI = 4358h
	???
Return: ???
Note:	PC Tools PC-Cache 5.x is an OEM version of Super PC-Kwik, and thus
	  supports this call; Qualitas Qcache does not support it
Index:	PC-Cache
--------v-13EC00-----------------------------
INT 13 - VIRUS - "Tiso" - INSTALLATION CHECK
	AX = EC00h
Return: CF clear if installed
SeeAlso: AH=F2h,INT 12/AX=4350h/BX=4920h
--------d-13EE-------------------------------
INT 13 - SWBIOS - SET 1024-CYLINDER FLAG
	AH = EEh
	DL = drive number (80h, 81h)
Return: CF clear
	   AH = 00h
Program: SWBIOS is a TSR by Ontrack Computer Systems
Desc:	the following INT 13 call will add 1024 to the specified cylinder
	  number to get the actual cylinder number desired
Notes:	the flag is cleared by all INT 13 calls except AH=EEh and AH=EFh
	Disk Manager also supports these calls
	this function is also supported by HyperDisk v4.01+ and PC-Cache v5.5+,
	  in order to allow caching of drives using SWBIOS to access more than
	  1024 cylinders
	for software which supports that call, this function is equivalent to
	  calling AH=EFh with CX=0400h
SeeAlso: AH=F9h,AH=FEh,INT 16/AX=FFA5h/CX=1111h,INT 2F/AH=DFh
Index:	PC-Cache;huge disks|Disk Manager
--------c-13EF-------------------------------
INT 13 - Ontrack Drive Rocket - SET CYLINDER OFFSET
	AH = EFh
	CX = cylinder offset for next INT 13 call
	DL = drive number (80h, 81h)
Return: CF clear
	    AH = 00h
Program: Drive Rocket is a drive accelerator by Ontrack Computer Systems for
	  IDE drives supporting the read multiple and write multiple commands
Desc:	the following INT 13 call will add the number given by this call to
	  the specified cylinder to get the actual cylinder number, then reset
	  the offset to zero
Note:	this function is also supported by the NOW! disk cache, and presumably
	  newer versions of SWBIOS and Disk Manager
	for software which supports this call, AH=EEh is equivalent to calling
	  this function with CX=0400h
	the cylinder offset is reset to 0 by all INT 13 called except AH=EEh
	  and AH=EFh
SeeAlso: AX=7B00h
--------v-13F2-------------------------------
INT 13 - VIRUS - "Neuroquila" - INSTALLATION CHECK
	AH = F2h
Return: CF ??? if installed
SeeAlso: AX=EC00h,INT 12/AX=4350h/BX=4920h,INT 21/AX=0B56h
--------d-13F9-------------------------------
INT 13 - SWBIOS - INSTALLATION CHECK
	AH = F9h
	DL = drive number (80h,81h)
Return: CF clear
	    DX = configuration word
		bit 15 set if other SWBIOS extensions available
	CF set on error
Program: SWBIOS is a TSR by Ontrack Computer Systems
Note:	Disk Manager also supports these calls
SeeAlso: AH=EEh
Index:	Disk Manager
--------v-13FA--DX5945-----------------------
INT 13 - PC Tools v8+ VSAFE, VWATCH - API
	AH = FAh
	DX = 5945h
	AL = function (00h-07h)
Return: varies by function
	if not installed:
	    CF set
		AH = 01h
Note:	this API is identical to the ones on INT 16/AH=FAh and INT 21/AH=FAh,
	  so it is listed in its entirety under INT 16/AX=FA00h and following
SeeAlso: INT 16/AX=FA00h
--------v-13FD50------------------------
INT 13 - VIRUS - "Predator" - INSTALLATION CHECK
	AX = FD50h
Return: AX = 50FDh if resident
SeeAlso: AX=5001h"VIRUS",INT 16/AH=DDh"VIRUS"
--------d-13FE-------------------------------
INT 13 - SWBIOS - GET EXTENDED CYLINDER COUNT
	AH = FEh
	DL = drive number (80h, 81h)
Return: CF clear
	DX = number of cylinders beyond 1024 on drive
Program: SWBIOS is a TSR by Ontrack Computer Systems
Notes:	standard INT 13/AH=08h will return a cylinder count truncated to 1024
	BIOS without this extension would return count modulo 1024
	Disk Manager also supports these calls
SeeAlso: AH=EEh
--------U-13FFFFBHAA-------------------------
INT 13 - UNIQUE UX Turbo Utility - SET TURBO MODE
	AX = FFFFh
	BH = AAh
	BL = subfunction
	    00h installation check
		Return: AX = 1234h if installed
	    01h turn on Turbo mode
	    02h turn off Turbo mode
	    03h set Turbo mode according to hardware switch
	    04h set disk access to Turbo mode
	    05h set disk access to Normal mode
SeeAlso: INT 15/AH=DFh
Index:	installation check;UNIQUE UX Turbo Utility
--------S-14---------------------------------
INT 14 - SERIAL - Digiboard DigiCHANNEL PC/X* Extender INT 14 (XAPCM232.SYS)
Note:	the installation check for this driver is to determine whether the
	  "~DOSXAM~" character device exists
Index:	installation check;Digiboard DigiCHANNEL
--------S-1400-------------------------------
INT 14 - SERIAL - INITIALIZE PORT
	AH = 00h
	AL = port parameters (see #0202)
	DX = port number (00h-03h) (04h-43h for Digiboard XAPCM232.SYS)
Return: AH = line status (see #0206)
	    FFh if error on Digiboard XAPCM232.SYS
	AL = modem status (see #0207)
Notes:	default handler is at F000h:E739h in IBM PC and 100% compatible BIOSes
	since the PCjr supports a maximum of 4800 bps, attempting to set 9600
	  bps will result in 4800 bps
	various network and serial-port drivers support the standard BIOS
	  functions with interrupt-driven I/O instead of the BIOS's polled I/O
	the 04/08/93 Compaq system ROM uses only the low two bits of DX
SeeAlso: AH=04h"SERIAL",AH=04h"MultiDOS",AH=05h"SERIAL",AH=57h
SeeAlso: AX=8000h"ARTICOM",AH=81h"COMM-DRV",AH=82h"COURIERS",AH=8Ch

Bitfields for serial port parameters:
Bit(s)	Description	(Table 0202)
 7-5	data rate (110,150,300,600,1200,2400,4800,9600 bps)
 4-3	parity (00 or 10 = none, 01 = odd, 11 = even)
 2	stop bits (set = 2, clear = 1)
 1-0	data bits (00 = 5, 01 = 6, 10 = 7, 11 = 8)
SeeAlso: #0204,#0209,#0210,#0211
--------S-1400-------------------------------
INT 14 - FOSSIL (Fido/Opus/Seadog Standard Interface Level) - INITIALIZE
	AH = 00h
	AL = initializing parameters
	    7 - 6 - 5	   4 - 3     2	  1 - 0
	    -BAUD RATE-	   PARITY   STOP   WORD
				    BITS  LENGTH
	    000 19200 bd   00 none  0: 1  00: 5
	    001 38400 bd   01 odd   1: 2  01: 6
	    010	  300 bd   11 even	  10: 7
	    011	  600 bd		  11: 8
	    100	 1200 bd
	    101	 2400 bd
	    110	 4800 bd
	    111	 9600 bd (4800 on PCjr)
	DX = port number (0-3 or FFh if only performing non-I/O setup)
Return: AH = RS-232 status code bits (see #0203)
	AL = modem status bits
	    bit 3: always 1
	    bit 7: DCD - carrier detect
SeeAlso: #0202,AH=05h"FOSSIL",AH=81h"COMM-DRV",AH=82h"COURIERS"

Bitfields for FOSSIL RS-232 status:
Bit(s)	Description	(Table 0203)
 0	RDA - input data is available in buffer
 1	OVRN - data has been lost
 5	THRE - room is available in output buffer
 6	TSRE - output buffer empty
--------S-1400-------------------------------
INT 14 - Tandy 2000 - SERIAL - RESET COMM PORT
	AH = 00h
	AL = RS-232C parameters (see #0204)
	DL = port number
	DH = protocol
	    bit 0: use XON/XOFF on received data
	    bit 1: use XON/XOFF when transmitting
Return: AH = line status (see #0206)
	AL = modem status (see #0207)
Note:	this interrupt is identical to INT 53 on the Tandy 2000
SeeAlso: AH=04h"Tandy 2000",INT 53"Tandy 2000"
--------S-1400-------------------------------
INT 14 - MBBIOS - INITIALIZE PORT
	AH = 00h
	AL = port parameters (see #0204)
	DX = port number
Return: AH = line status (see #0206)
	AL = modem status (see #0207)
Note:	MBBIOS was written by H. Roy Engehausen
SeeAlso: AH=04h"MBBIOS",AH=05h"MBBIOS",AH=09h"MBBIOS"

Bitfields for MBBIOS port parameters:
Bit(s)	Description	(Table 0204)
 7-5	data rate
	(normally 110,150,300,600,1200,2400,4800,9600 bps;
	9600,14400,19200,28800,38400,57600,115200,330400 bps
	if the high-speed option is set)
 4-3	parity (00 or 10 = none, 01 = odd, 11 = even)
 2	stop bits (set = 2, clear = 1)
 1-0	data bits (00 = 5, 01 = 6, 10 = 7, 11 = 8)
SeeAlso: #0202
--------N-1400--DXFFFF-----------------------
INT 14 - Connection Manager - MODIFY DEFAULT CONNECTION PARAMETERS
	AH = 00h
	DX = FFFFh
	ES:DI -> vector string specifying new parameters
Return: AH = return code (00h,03h) (see #0205)
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
Note:	if DX is 0-3 on entry, Connection Manager emulates the standard BIOS
	  function, but redirects the port over the network; if DX is any other
	  value, the call is chained
SeeAlso: AH=04h/DX=FFFFh,AH=08h/DX=FFFFh,AH=0Ah/DX=FFFFh

(Table 0205)
Values for Connection Manager return code:
 00h	successful
 01h	no such connection
 02h	invalid connection ID
 03h	invalid subvector found
 04h	communication error (check BH)
 06h	insufficient resources, retry later
 FFh	no data available
--------S-1401-------------------------------
INT 14 - SERIAL - WRITE CHARACTER TO PORT
	AH = 01h
	AL = character to write
	DX = port number (00h-03h) (04h-43h for Digiboard XAPCM232.SYS)
Return: AH bit 7 clear if successful
	AH bit 7 set on error
	AH bits 6-0 = port status (see #0206)
Notes:	various network and serial-port drivers support the standard BIOS
	  functions with interrupt-driven I/O instead of the BIOS's polled I/O
	the 04/08/93 Compaq system ROM uses only the low two bits of DX
SeeAlso: AH=02h,AH=0Bh"FOSSIL",AX=8000h"ARTICOM",AH=89h
--------N-1401--DXFFFF-----------------------
INT 14 - Connection Manager - SEND CHARACTER
	AH = 01h
	DX = FFFFh
	BH = character to send
Return: AH = return code (00h-02h,06h) (see #0205)
Notes:	if DX is 0-3 on entry, Connection Manager emulates the standard BIOS
	  function, but redirects the port over the network; if DX is any other
	  value, the call is chained
	this function is provided primarily for compatibility; AH=06h/DX=FFFFh
	  is the preferred function because it provides better performance
SeeAlso: AH=02h/DX=FFFFh,AH=06h/DX=FFFFh,AH=09h/DX=FFFFh
--------S-1402-------------------------------
INT 14 - SERIAL - READ CHARACTER FROM PORT
	AH = 02h
	AL = 00h (ArtiCom)
	DX = port number (00h-03h (04h-43h for Digiboard XAPCM232.SYS))
Return: AH = line status (see #0206)
	AL = received character if AH bit 7 clear
Notes:	will timeout if DSR is not asserted, even if function 03h returns
	  data ready
	various network and serial-port drivers support the standard BIOS
	  functions with interrupt-driven I/O instead of the BIOS's polled I/O
	the 04/08/93 Compaq system ROM uses only the low two bits of DX
SeeAlso: AH=01h,AH=02h"FOSSIL",AH=84h,AH=FCh
--------S-1402-------------------------------
INT 14 - FOSSIL - RECEIVE CHARACTER WITH WAIT
	AH = 02h
	DX = port number (0-3)
Return: AL = character received
	AH = 00h
SeeAlso: AH=01h,AH=02h"SERIAL"
--------N-1402--DXFFFF-----------------------
INT 14 - Connection Manager - RECEIVE CHARACTER
	AH = 02h
	DX = FFFFh
	BH = character to send
Return: AH = return code (00h-02h,04h,FFh) (see #0205)
	BH = line status (see #0206)
	AL = received character (if any)
Notes:	if DX is 0-3 on entry, Connection Manager emulates the standard BIOS
	  function, but redirects the port over the network; if DX is any other
	  value, the call is chained
	this function is provided primarily for compatibility; AH=07h/DX=FFFFh
	  is the preferred function because it provides better performance
SeeAlso: AH=02h/DX=FFFFh,AH=03h/DX=FFFFh,AH=06h/DX=FFFFh
--------S-1403-------------------------------
INT 14 - SERIAL - GET PORT STATUS
	AH = 03h
	AL = 00h (ArtiCom)
	DX = port number (00h-03h) (04h-43h for Digiboard XAPCM232.SYS)
Return: AH = line status (see #0206)
	AL = modem status (see #0207)
	AX = 9E00h if disconnected (ArtiCom)
Note:	the 04/08/93 Compaq system ROM uses only the low two bits of DX
SeeAlso: AH=00h,AH=07h"MultiDOS",AX=8000h"ARTICOM",AH=81h"COURIERS",AX=FD02h

Bitfields for serial line status:
Bit(s)	Description	(Table 0206)
 7	timeout
 6	transmit shift register empty
 5	transmit holding register empty
 4	break detected
 3	framing error
 2	parity error
 1	overrun error
 0	receive data ready
Note:	for COMM-DRV, if bit 7 is set, an error occurred, and may be retrieved
	  through a separate call (see AX=8000h"COMM-DRV")

Bitfields for modem status:
Bit(s)	Description	(Table 0207)
 7	carrier detect
 6	ring indicator
 5	data set ready
 4	clear to send
 3	delta carrier detect
 2	trailing edge of ring indicator
 1	delta data set ready
 0	delta clear to send
--------N-1403--DXFFFF-----------------------
INT 14 - Connection Manager - RETURN COMMUNICATION PORT STATUS
	AH = 03h
	DX = FFFFh
	AL = connection ID
Return: AH = return code (00h-02h) (see #0205)
	BH = line status (see #0208)
	BL = modem status (see #0207) (only bits 4,5,7; all others zero)
Notes:	if DX is 0-3 on entry, Connection Manager emulates the standard BIOS
	  function, but redirects the port over the network; if DX is any other
	  value, the call is chained
SeeAlso: AH=00h/DX=FFFFh,AH=04h/DX=FFFFh,AH=0Ah/DX=FFFFh

Bitfields for Connection Manager line status:
Bit(s)	Description	(Table 0208)
 7	CTS changed
 6	current CTS state
 5	timeout
 4	break
 3	framing error
 2	parity error
 1	overrun
 0	current carrier state (0 active, 1 no carrier)
--------S-1404-------------------------------
INT 14 - SERIAL - EXTENDED INITIALIZE (CONVERTIBLE,PS)
	AH = 04h
	AL = break status
	    00h if break
	    01h if no break
	BH = parity (see #0209)
	BL = number of stop bits
	    00h one stop bit
	    01h two stop bits (1.5 if 5 bit word length)
	CH = word length (see #0210)
	CL = bps rate (see #0211)
	DX = port number
Return: AX = port status code (see #0206,#0207)
SeeAlso: AH=00h,AH=1Eh,AX=8000h"ARTICOM"

(Table 0209)
Values for serial port parity:
 00h	no parity
 01h	odd parity
 02h	even parity
 03h	stick parity odd
 04h	stick parity even
SeeAlso: #0202,#0210,#0211,#0212

(Table 0210)
Values for serial port word length:
 00h	5 bits
 01h	6 bits
 02h	7 bits
 03h	8 bits
SeeAlso: #0202,#0209,#0211,#0247

(Table 0211)
Values for serial port bps rate:
 00h	110 (19200 if ComShare installed)
 01h	150 (38400 if ComShare installed)
 02h	300
 03h	600 (14400 if ComShare installed)
 04h	1200
 05h	2400
 06h	4800 (28800 if ComShare installed)
 07h	9600
 08h	19200
---ComShare---
 09h	38400
 0Ah	57600
 0Bh	115200
SeeAlso: #0202,#0209,#0211,#0248,#0255,AH=36h,#0266,#0499,#2137
--------S-1404-------------------------------
INT 14 - Tandy 2000 - SERIAL - FLUSH COMM BUFFER
	AH = 04h
	DL = port number
	DH = protocol
	    bit 0: use XON/XOFF on received data
	    bit 1: use XON/XOFF when transmitting
Desc:	clears the serial interface buffer
Note:	this interrupt is identical to INT 53 on the Tandy 2000
SeeAlso: AH=00h"Tandy 2000",INT 53"Tandy 2000"
--------S-1404-------------------------------
INT 14 - FOSSIL - INITIALIZE DRIVER
	AH = 04h
	DX = port number
	optionally BX=4F50h
		   ES:CX -> byte to be set upon ^C
Return: AX = 1954h (if successful)
	BL = maximum function number supported (excluding 7Eh and above)
	BH = revision of FOSSIL specification supported
	DTR is raised
Note:	the word at offset 6 in the interrupt handler contains 1954h, and the
	  following byte contains the maximum function number supported; this
	  can serve as an installation check
SeeAlso: AH=05h"FOSSIL",AH=1Ch,INT 11/AH=BCh
Index:	installation check;FOSSIL
--------S-1404-------------------------------
INT 14 - MultiDOS Plus IODRV - INITIALIZE PORT
	AH = 04h
Return: port initialized; if Hayes-compatible modem, a connection has been
	  established
Note:	the port number is stored at offset BEh in the Task Control Block
	  (see #0357 at INT 15/AH=13h"MultiDOS")
SeeAlso: AH=00h,AH=05h"MultiDOS",AH=20h"MultiDOS",INT 15/AH=13h"MultiDOS"
--------S-1404-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - CHANGE BAUD RATE
	AH = 04h
	AL = initializing parameters (see #0212)
	BX = baud rate
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    FFh error
SeeAlso: AH=05h"Digiboard"

Bitfields for Digiboard initializing parameters:
Bit(s)	Description	(Table 0212)
 7-5	unused
 4-3	parity (00 none, 01 odd, 11 even)
 2	stop bits (0 = one, 1 = two)
 1-0	data bits (00 = five, 01 = six, 10 = seven, 11 = eight)
SeeAlso: #0209,#0210
--------S-1404-------------------------------
INT 14 - MBBIOS - INSTALLATION CHECK
	AH = 04h
	DX = port number
Return: AX = AA55h if installed on specified port
SeeAlso: AH=00h"MBBIOS",AH=09h"MBBIOS"
--------N-1404--DXFFFF-----------------------
INT 14 - Connection Manager - OPEN COMMUNICATION
	AH = 04h
	DX = FFFFh
	ES:DI -> Connection Request protocol vector (see #0213)
Return: AH = return code
	    00h successful
		AL = connection ID
		BH = connection type
		    00h direct connection or no dialing
		    01h Connection Server dialed phone
	    01h no response from Connection Server
	    03h invalid request
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
Desc:	initiate a connection to the Connection Server listed in the current
	  Client parameter set
Notes:	if DX is 0-3 on entry, Connection Manager emulates the standard BIOS
	  function, but redirects the port over the network; if DX is any other
	  value, the call is chained
	all subvectors of the Connection Request vector are optional; if
	  missing, default values are provided by the default connection
	  parameter set
SeeAlso: AH=00h/DX=FFFFh,AH=05h/DX=FFFFh,AH=06h/DX=FFFFh,AH=07h/DX=FFFFh
SeeAlso: AH=0Ah/DX=FFFFh,AH=0Ch/DX=FFFFh

Format of Connection Manager protocol command vector:
Offset	Size	Description	(Table 0213)
 00h	WORD	(big-endian) total length of command (including this word)
 02h	WORD	(big-endian) command code
		EF01h Connection Request
		EF06h Modify Connection Parameters
 04h  N BYTEs	list of subvectors (see #0215)
		allowable subvector types are 01h-04h,17h,18h for command code
		  EF01h; 03h,04h for command code EF06h (see #0214)

(Table 0214)
Values for Connection Manager subvector type code:
 01h	Connection ID
 02h	Destination ID
 03h	Asynchronous line parameters
 04h	Data transfer parameters
 09h	Line speed
 0Ah	Serial coding
 0Bh	Packet size
 0Ch	Timers
 0Dh	Special characters
 0Eh	Target ID
 0Fh	Telephone number
 10h	ASCII destination ID
 11h	Parity
 12h	Bits per character
 13h	Number of stop bits
 14h	Packet timer
 15h	Intercharacter timer
 17h	Flags
 18h	Parameter ranges
 19h	Flow control

Format of Connection Manager subvector:
Offset	Size	Description	(Table 0215)
 00h	BYTE	length of subvector
 01h	BYTE	type code (see #0214)
 02h N-2 BYTEs	data, which may include subvectors
SeeAlso: #0216,#0217,#0218,#0219,#0220,#0221,#0222,#0223,#0224,#0225,#0226
SeeAlso: #0227,#0228,#0230,#0231,#0232,#0233,#0234,#0235

Format of Connection ID subvector:
Offset	Size	Description	(Table 0216)
 00h	BYTE	03h (length)
 01h	BYTE	01h (subvector "Connection ID")
 02h	BYTE	connection ID

Format of Destination ID subvector:
Offset	Size	Description	(Table 0217)
 00h	BYTE	length
 01h	BYTE	02h (subvector "Destination ID")
 02h  N BYTEs	subvector(s) of type 0Eh, 0Fh, or 10h

Format of Asynchronous line parameters subvector:
Offset	Size	Description	(Table 0218)
 00h	BYTE	length
 01h	BYTE	03h (subvector "Asynchronous line parameters")
 02h  N BYTEs	subvector(s) of type 09h, 0Ah, or 19h

Format of Data transfer parameters subvector:
Offset	Size	Description	(Table 0219)
 00h	BYTE	length
 01h	BYTE	04h (subvector "Data transfer parameters")
 02h  N BYTEs	subvector(s) of type 0Bh, 0Ch, or 0Dh

Format of Line speed subvector:
Offset	Size	Description	(Table 0220)
 00h	BYTE	04h (length)
 01h	BYTE	09h (subvector "Line speed")
 02h	WORD	bit map, highest set bit selects speed
		bit 0: 2400
		bits 1-7: 1800, 1200, 600, 300, 115200, 150, 110 bps
		bits 8-15: 57600, 38400, 19200, 14400, 9600, 7200, 4800, 3600

Format of Serial coding subvector:
Offset	Size	Description	(Table 0221)
 00h	BYTE	length
 01h	BYTE	0Ah (subvector "Serial coding")
 02h  N BYTEs	subvector(s) of type 11h, 12h, or 13h

Format of Packet size subvector:
Offset	Size	Description	(Table 0222)
 00h	BYTE	04h (length)
 01h	BYTE	0Bh (subvector "Packet size")
 02h	WORD	(big-endian) packet size, 1 to 1024

Format of Timers subvector:
Offset	Size	Description	(Table 0223)
 00h	BYTE	length
 01h	BYTE	0Ch (subvector "Timers")
 02h  8 BYTEs	subvector of type 14h or 15h

Format of Special characters subvector:
Offset	Size	Description	(Table 0224)
 00h	BYTE	length
 01h	BYTE	0Dh (subvector "Special characters")
 02h  N BYTEs	list of ASCII characters to be used as EOM or EOB

Format of Target ID:
Offset	Size	Description	(Table 0225)
 00h	BYTE	length
 01h	BYTE	0Eh (subvector "Target ID")
 02h  N BYTEs	target ID, 1-16 bytes

Format of Telephone number subvector:
Offset	Size	Description	(Table 0226)
 00h	BYTE	length
 01h	BYTE	0Fh (subvector "Telephone number")
 02h  N BYTEs	telephone number

Format of ASCII destination ID subvector:
Offset	Size	Description	(Table 0227)
 00h	BYTE	length
 01h	BYTE	10h (subvector "ASCII destination ID")
 02h  N BYTEs	destination ID

Format of Parity subvector:
Offset	Size	Description	(Table 0228)
 00h	BYTE	03h (length)
 01h	BYTE	11h (subvector "Parity")
 02h	BYTE	parity type (see #0229)

Bitfields for Connection Manager parity type:
Bit(s)	Description	(Table 0229)
 7	odd
 6	even
 5	mark
 4	space
 3	none

Format of Bits per character subvector:
Offset	Size	Description	(Table 0230)
 00h	BYTE	03h (length)
 01h	BYTE	12h (subvector "Bits per character")
 02h	BYTE	bits per character
		bit 7: seven
		bit 6: eight

Format of Number of stop bits subvector:
Offset	Size	Description	(Table 0231)
 00h	BYTE	03h (length)
 01h	BYTE	13h (subvector "Number of stop bits")
 02h	BYTE	stop bits
		bit 7: one
		bit 6: 1.5
		bit 5: two

Format of Packet timer and Intercharacter timer subvectors:
Offset	Size	Description	(Table 0232)
 00h	BYTE	04h (length)
 01h	BYTE	subvector type
		14h Packet timer
		15h Intercharacter timer
 02h	WORD	(big-endian) unit of value representing 20ms

Format of Flags subvector:
Offset	Size	Description	(Table 0233)
 00h	BYTE	03h (length)
 01h	BYTE	17h (subvector "Flags")
 02h	BYTE	flags
		bit 7: queueing requested

Format of Parameter ranges subvector:
Offset	Size	Description	(Table 0234)
 00h	BYTE	length
 01h	BYTE	18h (subvector "Parameter ranges")
 02h  N BYTEs	subvector(s) of type 09h, 11h, 12h, or 13h

Format of Flow control subvector:
Offset	Size	Description	(Table 0235)
 00h	BYTE	length (02h-04h)
 01h	BYTE	19h (subvector "Flow control")
 02h	BYTE	XOFF character
 03h	BYTE	XON character
Note:	if length is 02h, flow control is disabled; if length is 03h, any
	  character will be accepted as XON after an XOFF
--------S-140400-----------------------------
INT 14 - Microsoft Systems Journal TSRCOMM INT14 - INSTALLATION CHECK
	AX = 0400h
Return: AX = 0FF0h
SeeAlso: AX=0401h,AX=0408h
--------S-140401-----------------------------
INT 14 - Microsoft Systems Journal TSRCOMM INT14 - INITIALIZE MODE
	AX = 0401h
	CX = mode
SeeAlso: AX=0400h,AX=0402h
--------S-140402-----------------------------
INT 14 - Microsoft Systems Journal TSRCOMM INT14 - EXTENDED INITIALIZE
	AX = 0402h
	CL = parameters
SeeAlso: AX=0400h,AX=0401h
--------S-140403-----------------------------
INT 14 - Microsoft Systems Journal TSRCOMM INT14 - SET TIMEOUT
	AX = 0403h
	CX = timeout
SeeAlso: AX=0400h
--------S-140404-----------------------------
INT 14 - Microsoft Systems Journal TSRCOMM INT14 - CLEAR THE RECEIVE BUFFER
	AX = 0404h
SeeAlso: AX=0400h,AX=0405h,AX=0406h
--------S-140405-----------------------------
INT 14 - Microsoft Systems Journal TSRCOMM INT14 - GET RECEIVE BUFFER COUNT
	AX = 0405h
Return: AX = number of characters in buffer
SeeAlso: AX=0400h,AX=0404h,AX=0407h
--------S-140406-----------------------------
INT 14 - Microsoft Systems Journal TSRCOMM INT14 - CLEAR THE TRANSMIT BUFFER
	AX = 0406h
SeeAlso: AX=0400h,AX=0404h,AX=0407h
--------S-140407-----------------------------
INT 14 - Microsoft Systems Journal TSRCOMM INT14 - GET TRANSMIT BUFFER COUNT
	AX = 0407h
Return: AX = number of characters in the buffer
SeeAlso: AX=0400h,AX=0405h,AX=0406h
--------S-140408-----------------------------
INT 14 - Microsoft Systems Journal TSRCOMM INT14 - UNINSTALL
	AX = 0408h
SeeAlso: AX=0400h
--------S-1405-------------------------------
INT 14 - SERIAL - EXTENDED COMMUNICATION PORT CONTROL (CONVERTIBLE,PS)
	AH = 05h
	AL = function
	    00h read modem control register
	      Return: BL = modem control register (see #0236)
		      AH = status
	    01h write modem control register
	      BL = modem control register (see #0236)
	      Return: AX = status
	DX = port number
Note:	also supported by ArtiCom
SeeAlso: AH=00h,AH=1Fh,AX=8000h"ARTICOM",AH=FBh

Bitfields for modem control register:
Bit(s)	Description	(Table 0236)
 0	data terminal ready
 1	request to send
 2	OUT1
 3	OUT2
 4	LOOP
 5-7	reserved
--------S-1405-------------------------------
INT 14 - FOSSIL - DEINITIALIZE DRIVER
	AH = 05h
	DX = port number
Return: none
	DTR is not affected
SeeAlso: AH=00h,AH=04h"FOSSIL",AH=1Dh,AH=8Dh
--------S-1405-------------------------------
INT 14 - MultiDOS Plus IODRV - READ CHARACTER FROM PORT
	AH = 05h
	AL = timeout in seconds (00h = never)
Return: AL = status
	    00h successful
		AH = character read
	    01h read error
	    02h timed out
	    other modem status (CTS, DSR) changed
Note:	the port number is stored at offset BEh in the Task Control Block
SeeAlso: AH=02h,AH=04h"MultiDOS",AH=06h"MultiDOS",AH=22h"MultiDOS"
SeeAlso: INT 15/AH=13h"MultiDOS"
--------S-1405-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - CHANGE PROTOCOL
	AH = 05h
	AL = protocol (see #0237)
	BH = new XOFF character (00h = current)
	BL = new XON character (00h = current)
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    FFh error
SeeAlso: AH=04h"Digiboard"

Bitfields for Digiboard protocol:
Bit(s)	Description	(Table 0237)
 7-4	unused
 3	RTS/CTS
 2	DSR
 1,0	XON/XOFF
--------S-1405-------------------------------
INT 14 - MBBIOS - DROP DTR AND RTS
	AH = 05h
	DX = port number
Return: none
SeeAlso: AH=00h"MBBIOS",AH=06h"MBBIOS",AH=06h"FOSSIL"
--------S-1405-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - CHANGE PORT PROTOCOL
	AH = 05h
	AL = new port protocol (see #0238)
	BH = new XOFF character
	BL = new XON character
	DX = port number
Return: AH = FFh if invalid protocol
SeeAlso: AH=00h,AH=04h"SERIAL",AH=06h"PC-MOS"

Bitfields for PC-MOS/386 serial port protocol:
Bit(s)	Description	(Table 0238)
 7	set to enable/disable CD monitoring, clear to set protocol
---bit 7 set---
 4	CD monitoring enabled
 5	automatic restart enabled
---bit 7 clear---
 0	receive XON/XOFF
 1	transmit XON/XOFF
 2	DTR/DSR
 3	RTS/CTS
--------N-1405--DXFFFF-----------------------
INT 14 - Connection Manager - CLOSE COMMUNICATION
	AH = 05h
	DX = FFFFh
	AL = connection ID
Return: AH = return code
	    00h successful
	    01h no such connection
	    02h invalid connection ID
		AL = correct connection ID
Desc:	terminate existing connection to allow another one to be established
Note:	if DX is 0-3 on entry, Connection Manager emulates the standard BIOS
	  function, but redirects the port over the network; if DX is any other
	  value, the call is chained
SeeAlso: AH=04h/DX=FFFFh,AH=0Dh/DX=FFFFh
--------S-1406-------------------------------
INT 14 - FOSSIL - RAISE/LOWER DTR
	AH = 06h
	DX = port
	AL = DTR state to be set
	    00h = lower
	    01h = raise
SeeAlso: AH=05h"MBBIOS",AH=1Ah
--------S-1406-------------------------------
INT 14 - MultiDOS Plus IODRV - WRITE CHARACTER TO PORT
	AH = 06h
	AL = character
Return: AL = status
	    00h successful
Notes:	the port number is stored at offset BEh in the Task Control Block
	if output queue is full, the calling task is blocked until the
	  character can be stored
SeeAlso: AH=01h,AH=04h"MultiDOS",AH=05h"MultiDOS",AH=21h"MultiDOS"
SeeAlso: INT 15/AH=13h"MultiDOS"
--------S-1406-------------------------------
INT 14 - MBBIOS - RAISE DTR AND RTS
	AH = 06h
	DX = port number
Return: none
SeeAlso: AH=05h"MBBIOS",AH=07h"MBBIOS"
--------S-1406-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - DRIVER 'ID' FUNCTION
	AH = 06h
	DX = port number
Return: AH bit 7 set
	AL = number of highest function supported by driver
Program: PC-MOS/386 v5.01 is a multitasking, multiuser MS-DOS 5.0-compatible
	  operating system by The Software Link, Inc.
SeeAlso: AH=18h"PC-MOS"
--------N-1406-------------------------------
INT 14 - TelAPI - WRITE BLOCK
	AH = 06h
	CX = number of characters to write
	DX = port number
	ES:DI -> buffer containing data
Return: AX = number of characters actually sent??? (negative on error)
	CX = ???
SeeAlso: AH=07h"TelAPI",AH=E0h"TelAPI"
--------N-1406--DXFFFF-----------------------
INT 14 - Connection Manager - SEND CHARACTER BLOCK
	AH = 06h
	DX = FFFFh
	AL = connection ID
	CX = number of characters to send
	ES:DI -> buffer containing data to be sent
Return: AH = return code (see #0205)
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
SeeAlso: AH=04h/DX=FFFFh,AH=07h/DX=FFFFh,AH=09h/DX=FFFFh
--------S-1407-------------------------------
INT 14 - FOSSIL - RETURN TIMER TICK PARAMETERS
	AH = 07h
Return: AL = timer tick interrupt number
	AH = ticks per second on interrupt number in AL
	DX = approximate number of milliseconds per tick
SeeAlso: AH=16h
--------S-1407-------------------------------
INT 14 - MultiDOS Plus IODRV - GET PORT STATUS
	AH = 07h
Return: CL = modem status (see #0207)
	CH = character at head of input queue (if any)
	DX = number of characters in input queue
Note:	the port number is stored at offset BEh in the Task Control Block
SeeAlso: AH=03h,AH=05h"MultiDOS",AH=08h"MultiDOS",AH=09h"MultiDOS"
SeeAlso: AH=23h"MultiDOS",INT 15/AH=13h"MultiDOS"
--------S-1407-------------------------------
INT 14 - MBBIOS - SEND BREAK
	AH = 07h
	DX = port number
Return: none
SeeAlso: AH=06h"MBBIOS",AH=FAh"EBIOS"
--------S-1407-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - SEND RS-232 BREAK
	AH = 07h
	BX = duration of break in clock ticks
	DX = port number
Return: nothing
--------N-1407-------------------------------
INT 14 - TelAPI - READ BLOCK
	AH = 07h
	CX = number of characters to read
	DX = port number
	ES:DI -> buffer for data
Return: AX = number of characters actually read??? (negative on error)
	CX = ???
SeeAlso: AH=06h"TelAPI",AH=E0h"TelAPI"
--------N-1407--DXFFFF-----------------------
INT 14 - Connection Manager - RECEIVE CHARACTER BLOCK
	AH = 07h
	DX = FFFFh
	AL = connection ID
	BL = flag
	    00h wait for data
	    nonzero do not wait if no data avaiable
	CX = size of receive buffer
	ES:DI -> buffer for received characters
Return: AH = return code (00h-02h,04h,FFh) (see #0205)
	BH = line status (see #0208)
	CX = number of characters received
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
SeeAlso: AH=01h/DX=FFFFh,AH=04h/DX=FFFFh,AH=06h/DX=FFFFh
--------S-1408-------------------------------
INT 14 - FOSSIL - FLUSH OUTPUT BUFFER WAITING TILL ALL OUTPUT IS DONE
	AH = 08h
	DX = port number
SeeAlso: AH=09h"FOSSIL"
--------S-1408-------------------------------
INT 14 - MultiDOS Plus 4.0 IODRV - GET AND RESET PORT LINE STATUS
	AH = 08h
Return: AL = line status (see #0206)
	AH destroyed
Notes:	the port number is stored at offset BEh in the Task Control Block
	on every line status change, the line status is ORed with the line
	  status accumulator; this function returns the accumulator and clears
	  it
SeeAlso: AH=03h,AH=04h"MultiDOS",AH=07h"MultiDOS",INT 15/AH=13h"MultiDOS"
--------S-1408-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - ALTERNATE STATUS CHECK
	AH = 08h
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = RS232 status bits (see #0206 at AH=03h)
	ZF set if no characters queued
	ZF clear if character available
	    AL = next character
SeeAlso: AH=03h,AH=08h"PC-MOS",AH=09h"Digiboard",AH=14h"Digiboard"
--------S-1408-------------------------------
INT 14 - MBBIOS - NON-DESTRUCTIVE READ
	AH = 08h
	DX = port number
Return: AL = character (if AH bit 0 set)
	AH = status (see #0206)
SeeAlso: AH=0Bh"MBBIOS",AH=0Ch"FOSSIL"
--------S-1408-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - INPUT STATUS CHECK
	AH = 08h
	DX = port number
Return: CF set if carrier loss detected
	ZF set if input buffer empty
	ZF clear if characters available
	    AL = next character dequeued
--------N-1408--DXFFFF-----------------------
INT 14 - Connection Manager - RETURN DEFAULT CONNECTION PARAMETERS
	AH = 08h
	DX = FFFFh
	CX = size of buffer for parameters or 0000h to get length
	ES:DI -> buffer for parameter vector (see #0213)
Return: AH = return code
	    00h successful
		CX = number of bytes required (if CX=0000h on entry)
		CX = number of bytes omitted for lack of space (if CX nonzero)
	    nonzero invalid request
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
SeeAlso: AH=00h/DX=FFFFh,AH=0Fh/DX=FFFFh
--------S-1409-------------------------------
INT 14 - FOSSIL - PURGE OUTPUT BUFFER THROWING AWAY ALL PENDING OUTPUT
	AH = 09h
	DX = port number
SeeAlso: AH=08h"FOSSIL",AH=0Ah"FOSSIL",AH=88h
--------S-1409-------------------------------
INT 14 - MultiDOS Plus IODRV - RESET PORT STATUS
	AH = 09h
Return: modem status byte cleared
Note:	the port number is stored at offset BEh in the Task Control Block
SeeAlso: AH=04h"MultiDOS",AH=07h"MultiDOS",INT 15/AH=13h"MultiDOS"
--------S-1409-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - CLEAR BUFFERS
	AH = 09h
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    FFh error
SeeAlso: AH=08h"Digiboard",AH=0Ah"Digiboard",AH=10h"Digiboard"
--------S-1409-------------------------------
INT 14 - MBBIOS - GET/SET OPTIONS
	AH = 09h
	AL = option byte (see #0239)
	DX = port number???
Return: AL = old option byte
SeeAlso: AH=00h"MBBIOS",AH=04h"MBBIOS",AH=10h"FOSSIL"

Bitfields for MBBIOS option byte:
Bit(s)	Description	(Table 0239)
 0	transmit buffering enabled
 2	hardware handshaking enabled
 5	high-speed option enabled (see AH=00h"MBBIOS",#0204)
 other	reserved
--------S-1409-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - RESET I/O BUFFER POINTERS
	AH = 09h
	DX = port number
Return: nothing
SeeAlso: AH=13h"PC-MOS"
--------N-1409--DXFFFF-----------------------
INT 14 - Connection Manager - SEND BREAK
	AH = 09h
	DX = FFFFh
	AL = connection ID
Return: AH = return code (00h-02h) (see #0205 at AH=00h/DX=FFFFh)
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
SeeAlso: AH=02h/DX=FFFFh,AH=03h/DX=FFFFh
--------S-140A-------------------------------
INT 14 - FOSSIL - PURGE INPUT BUFFER THROWING AWAY ALL PENDING INPUT
	AH = 0Ah
	DX = port number
SeeAlso: AH=09h"FOSSIL",AH=85h
--------S-140A-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - INPUT QUEUE CHECK
	AH = 0Ah
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AX = number of characters available in buffer
Note:	this function is also supported by the PC-MOS/386 v5.01 $serial.sys
SeeAlso: AH=09h"Digiboard",AH=0Dh"Digiboard"
--------S-140A-------------------------------
INT 14 - MBBIOS - WRITE BUFFER
	AH = 0Ah
	CX = count
	ES:DI -> buffer (see #0240)
Return: AX = status (see #0206,#0207)
	CX = unsent character count
	DI updated
Note:	the PACCOM version of MBBIOS does not use CX or ES:DI; instead, ES
	  contains the segment of a buffer containing the packet to be sent,
	  which by default will be freed once the packet has been sent.	 Use
	  AH=0Ch"MBBIOS" to allocate the buffer.
SeeAlso: AH=01h,AH=0Bh"MBBIOS",AH=0Ch"MBBIOS",AH=19h"FOSSIL"

Format of MBBIOS PACCOM buffer:
Offset	Size	Description	(Table 0240)
 00h 504 BYTEs	data area
1F8h	WORD	length of data in data area
1FAh	BYTE	flags/status
		bit 7: don't discard buffer after transmitting data
		bit 6: buffer has been transmitted
1FBh	BYTE	reserved (0) for additional flags/status
1FCh	WORD	user data
1FEh	WORD	MBBIOS-internal pointer to next buffer
--------N-140A--DXFFFF-----------------------
INT 14 - Connection Manager - MODIFY ACTIVE CONNECTION PARAMETERS
	AH = 0Ah
	DX = FFFFh
	ES:DI -> vector string containing new parameters (see #0213)
Return: AH = return code (00h-03h,06h) (see #0205)
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
Note:	any subvectors valid for the Change Parameters command replace the
	  existing values in the current set
SeeAlso: AH=00h/DX=FFFFh,AH=0Fh/DX=FFFFh
--------S-140B-------------------------------
INT 14 - FOSSIL - TRANSMIT NO WAIT
	AH = 0Bh
	AL = character
	DX = port number
Return: AX = result
	    0000h character not accepted
	    0001h character accepted
SeeAlso: AH=01h
--------S-140B-------------------------------
INT 14 - MBBIOS - READ BUFFER
	AH = 0Bh
	CX = size of buffer
	ES:DI -> buffer
Return: AH = composite line status (see #0206) formed by ORing all statuses
		  on receive interrupts; bit 0 set if additional characters
		  available
	AL = composite modem status (see #0207) formed by ORing all statuses
	CX = number of characters actually read
	DI updated
Note:	the PACCOM version of MBBIOS does not use CX or ES:DI on call,
	  instead returning ES set to the segment of the buffer containing a
	  received packet, or 0000h if no packets available; the buffer may
	  be freed with AH=0Ch"MBBIOS"
SeeAlso: AH=02h,AH=08h"MBBIOS",AH=0Ah"MBBIOS",AH=0Ch"MBBIOS",AH=18h"FOSSIL"
--------N-140B--DXFFFF-----------------------
INT 14 - Connection Manager - PREPARE FOR INBOUND CONNECTION
	AH = 0Bh
	DX = FFFFh
	AL = service name
	    00h use parameter file or default
	    01h use specified name
		ES:DI -> 16-byte blank-padded name
	BH = connection notification
	    00h program awaiting connection, don't notify user
	    01h notify user on connecting
	BL = connection type
	    00h connection will use Connection Manager API
Return: AH = return code (00h-02h) (see #0205 at AH=00h/DX=FFFFh)
	AL = connection ID if AH=00h
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
SeeAlso: AH=04h/DX=FFFFh,AH=0Ch/DX=FFFFh,AH=10h/DX=FFFFh
--------S-140C-------------------------------
INT 14 - FOSSIL - NON-DESTRUCTIVE READ AHEAD
	AH = 0Ch
	DX = port number
Return: AX = FFFFh character not available
	AX = 00xxh character xx available
SeeAlso: AH=08h"MBBIOS",AH=20h"FOSSIL"
--------S-140C-------------------------------
INT 14 - MBBIOS PACCOM support - BUFFER MANAGEMENT
	AH = 0Ch
	ES = segment of buffer to free, or 0000h to allocate new buffer
Return: ES = segment of allocated buffer (if ES=0000h on entry)
Note:	the PACCOM version of MBBIOS uses only ES as buffer address for
	  AH=0Ah and AH=0Bh
SeeAlso: AH=0Ah"MBBIOS",AH=0Bh"MBBIOS"
--------N-140C--DXFFFF-----------------------
INT 14 - Connection Manager - TEST FOR INBOUND CONNECTION REQUEST
	AH = 0Ch
	DX = FFFFh
	AL = connection ID from AH=0Bh/DX=FFFFh
Return: AH = return code (00h-03h) (see also #0205 at AH=00h/DX=FFFFh)
	    03h not prepared for inbound connection
	AL = connection ID (if AH=00h) or correct connection ID (if AH=02h)
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
SeeAlso: AH=03h/DX=FFFFh,AH=04h/DX=FFFFh,AH=0Bh/DX=FFFFh
--------S-140D-------------------------------
INT 14 - FOSSIL - KEYBOARD READ WITHOUT WAIT
	AH = 0Dh
Return: AX = result
	    FFFFh character not available
	    xxyyh standard IBM-style scan code
SeeAlso: AH=0Eh
--------S-140D-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - GET POINTER TO CH_KEY_RDY FLAG
	AH = 0Dh
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: ES:BX -> CH_KEY_RDY flag (see #0241)
SeeAlso: AH=0Ah"Digiboard"

(Table 0241)
Values for Digiboard CH_KEY_RDY flag:
 00h	receive buffer empty
 FFh	characters available
--------S-140D-------------------------------
INT 14 - MBBIOS PACCOM support - SET TXD
	AH = 0Dh
	AL = new setting (FFh = 1.0)
Desc:	specify the time from RTS to start or packet
SeeAlso: AX=0D00h,AH=0Eh"MBBIOS",AH=0Fh"MBBIOS"
--------N-140D--DXFFFF-----------------------
INT 14 - Connection Manager - TERMINATE CONNECTION CLIENT ACTIVITY
	AH = 0Dh
	DX = FFFFh
Return: AH = return code
	    00h successful
	    nonzero operation not terminated
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
Desc:	end all Connection Client TSR activity to allow it to be removed from
	  memory
SeeAlso: AH=05h/DX=FFFFh,AH=6Fh/BX=FFFFh
--------S-140D00-----------------------------
INT 14 - MBBIOS - GET AVAILABLE BYTES
	AX = 0D00h
Return: AX = bytes in transmit buffer
	CX = bytes in receive buffer
SeeAlso: AH=0Ah"MBBIOS",AH=0Bh"MBBIOS"
--------S-140D01-----------------------------
INT 14 - MBBIOS - LOWER ALL MODEM CONTROL SIGNALS
	AX = 0D01h
Note:	this function lowers DTR, RTS, etc.
SeeAlso: AX=0D02h
--------S-140D02-----------------------------
INT 14 - MBBIOS - RAISE ALL MODEM CONTROL SIGNALS
	AX = 0D02h
Note:	this function raises DTR, RTS, etc.
SeeAlso: AX=0D01h
--------S-140D03-----------------------------
INT 14 - MBBIOS - SET HANDSHAKE BYTE
	AX = 0D03h
	CL = new handshake byte
Return: CL = previous handshake byte
Note:	this function lowers DTR, RTS, etc.
--------S-140E-------------------------------
INT 14 - FOSSIL - KEYBOARD READ WITH WAIT
	AH = 0Eh
Return: AX = xxyyh standard IBM-style scan code
SeeAlso: AH=0Dh"FOSSIL"
--------S-140E-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - WRITE STRING
	AH = 0Eh
	CX = number of characters to write
	ES:BX -> string
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AX = number of characters actually written
	ZF clear if successful
	ZF set on error
SeeAlso: AH=0Fh"Digiboard"
--------S-140E-------------------------------
INT 14 - MBBIOS PACCOM support - SET PERSISTENCE
	AH = 0Eh
	AL = new setting (FFh = 1.0)
Desc:	specify the time from end of DCD to RTS
SeeAlso: AH=0Dh"MBBIOS",AH=0Fh"MBBIOS"
--------N-140E--DXFFFF-----------------------
INT 14 - Connection Manager - SET HARDWARE FLOW STATE
	AH = 0Eh
	DX = FFFFh
	AL = connection ID from AH=04h/DX=FFFFh
	BL = RTS state (00h off, 01h on)
Return: AH = return code (00h-03h) (see also #0205 at AH=00h/DX=FFFFh)
	    03h invalid request (BL not 00h or 01h)
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
SeeAlso: AH=03h/DX=FFFFh,AH=0Ah/DX=FFFFh
--------S-140F-------------------------------
INT 14 - FOSSIL - ENABLE/DISABLE FLOW CONTROL
	AH = 0Fh
	AL = bit mask describing requested flow control (see #0242)
	DX = port number
SeeAlso: AH=09h"MBBIOS",AH=10h"FOSSIL"

Bitfields for FOSSIL requested flow control:
Bit(s)	Description	(Table 0242)
 0	XON/XOFF on transmit (watch for XOFF while sending)
 1	CTS/RTS (CTS on transmit/RTS on receive)
 2	reserved
 3	XON/XOFF on receive (send XOFF when buffer near full)
 4-7	all 1
--------S-140F-------------------------------
INT 14 - Digiboard DigiCHANNEL PC/X* - READ STRING
	AH = 0Fh
	CX = number of characters to read
	ES:BX -> buffer
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AX = number of characters read
	ZF clear if successful
	ZF set on error (line status or wrong number of characters)
SeeAlso: AH=0Eh"Digiboard"
--------S-140F-------------------------------
INT 14 - MBBIOS PACCOM support - SET SLOT TIME
	AH = 0Fh
	AL = new setting in clock ticks
Desc:	specify the time from end of DCD to RTS
SeeAlso: AH=0Dh"MBBIOS",AH=0Eh"MBBIOS",AH=10h"MBBIOS"
--------N-140F--DXFFFF-----------------------
INT 14 - Connection Manager - RETURN ACTIVE CONNECTION PARAMETERS
	AH = 0Fh
	DX = FFFFh
	AL = connection ID
	CX = size of buffer or 0000h to get length of returned vector
	ES:DI -> buffer for connection parameter vector (see #0213)
Return: AH = return code (00h-02h,06h) (see #0205 at AH=00h/DX=FFFFh)
	CX = number of bytes which could not be returned because the given
	      buffer was too small
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
SeeAlso: AH=08h/DX=FFFFh,AH=0Ah/DX=FFFFh
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
	ES:DI -> pattern buffer (see #0243)
Return: AH = return code (00h,01h,03h,06h) (see also #0205 at AH=00h/DX=FFFFh)
	    01h no (more) matching names
	    03h invalid request
	ES:DI buffer filled with reply buffer (see #0243) containing matched
		  name if AH=00h
Program: Connection Manager by Softwarehouse Corp. permits the sharing of
	  serial ports over an IPX or NetBIOS-based network
Desc:	obtain the names of groups and lines available for connection requests,
	  and the names of active Connection Servers
SeeAlso: AH=04h/DX=FFFFh,AH=0Bh/DX=FFFFh

Format of Connection Manager pattern/reply buffer:
Offset	Size	Description	(Table 0243)
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
	AL = line parameters (see #0206)
	AH = flow control configuration (see #0238 at AH=05h"PC-MOS")
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
SeeAlso: INT 21/AH=2Bh/CX=6269h/DX=742Dh
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
	AL = CCB command number (see #0244) (see also following entries)
	BL = byte 2
	BH = byte 3
	CL = byte 1 (for all channel functions except 4Eh and 4Fh)
	DX = port number (00h-03h) (04h-43h for XAPCM232.SYS)
Return: AH = status
	    00h successful
	    80h error
	    FFh error
SeeAlso: AX=1646h,AH=18h"Digiboard"

(Table 0244)
Values for Digiboard CCB command number:
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
SeeAlso: INT 16/AX=E0FFh,INT 19,INT 60/DI=0606h
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
	ES:DI -> user buffer for driver info (see #0245)
Return: AX = number of characters transferred
	CX = 3058h ("0X") (X00 FOSSIL only)
	DX = 2030h (" 0") (X00 FOSSIL only)

Format of FOSSIL driver info:
Offset	Size	Description	(Table 0245)
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
	BH = parity (see #0246)
	BL = number of stop bits
	    00h one stop bit
	    01h two stop bits (1.5 if 5 bit word length)
	CH = word length (see #0247)
	CL = bps rate (see #0248)
	DX = port number
Return: AX = port status code (see #0206,#0207)
Notes:	this function is intended to exactly emulate the PS/2 BIOS AH=04h call
	if the port was locked at X00 load time, the appropriate parameters are
	  ignored
SeeAlso: AH=00h,AH=04h"SERIAL I/O"

(Table 0246)
Values for X00 FOSSIL parity:
 00h	no parity
 01h	odd parity
 02h	even parity
 03h	stick parity odd
 04h	stick parity even
SeeAlso: #0209,#0247,#0248

(Table 0247)
Values for X00 FOSSIL word length:
 00h	5 bits
 01h	6 bits
 02h	7 bits
 03h	8 bits
SeeAlso: #0210,#0246,#0248

(Table 0248)
Values for X00 FOSSIL bps rate:
 00h	110
 01h	150
 02h	300
 03h	600
 04h	1200
 05h	2400
 06h	4800
 07h	9600
 08h	19200
SeeAlso: #0211,#0246,#0247
--------S-141E------------------------------------
INT 14 - HUNTER 16 - READ COMMS PARAMETERS
	AH = 1Eh
	CX = channel number (00h COM1, 01h COM2, ...)
	DS:BX -> buffer for communications parameters (see #0249)
Return: DS:BX buffer filled
Note:	the Husky Hunter 16 is an 8088-based ruggedized laptop.	 Other family
	  members are the Husky Hunter, Husky Hunter 16/80, and Husky Hawk.
SeeAlso: AH=20h"HUNTER"

Format of HUNTER 16 communications parameters:
Offset	Size	Description	(Table 0249)
 00h	BYTE	communications type (00h IBM, nonzero Husky)
 01h	BYTE	port number (00h COM1, 01h COM2)
 02h	BYTE	baud rate (00h 110 bps, 01h 150, 02h 300, 03h 600, 04h 1200,
		  05h 2400, 06h 4800, 07h 9600, 08h 19200, 09h 38400)
 03h	BYTE	data bits (01h seven, 02h eight)
 04h	BYTE	parity (00h none, 01h odd, 02h even)
 05h	BYTE	stop bits (00h one, 01h two)
 06h	BYTE	handshake (see #0250)
 07h	BYTE	handshake protocol (00h none, 01h Xon/Xoff, 02h HWK3780)
 08h	BYTE	Nulls after CR (0-20)
 09h	BYTE	LF (00h off, 01h on)
 0Ah	BYTE	Serig. 0..7Fh: Ignore this character
		       80h: Serig off
 0Bh	BYTE	echo (00h off, 01h on)
 0Ch	BYTE	transmit timeout in seconds (1-60) or 00h to disable
 0Dh	BYTE	receive timeout in seconds (1-60) or 00h to disable
 0Eh  5 BYTEs	reserved

Bitfields for HUNTER 16 handshake:
Bit(s)	Description	(Table 0250)
 0-1	0: RTS off, 1: RTS hold, 2: RTS true
 2	DTR enabled
 4	CTS enabled
 5	DSR enabled
 6	DCD enabled
--------S-141F-------------------------------
INT 14 - X00 FOSSIL - EXTENDED SERIAL PORT STATUS/CONTROL
	AH = 1Fh
	AL = 00h read modem control register
	      Return: BL = modem control register (see #0251)
		      AH = status
	AL = 01h write modem control register
	      BL = modem control register (see #0251)
	      Return: AX = status
	DX = port number
Notes:	this function is intended to exactly emulate the PS/2 BIOS AH=05h call
	X00 forces BL bit 3 set (interrupts cannot be disabled)
SeeAlso: AH=00h,AH=05h"SERIAL I/O"

Bitfields for X00 FOSSIL modem control register:
Bit(s)	Description	(Table 0251)
 0	data terminal ready
 1	request to send
 2	OUT1
 3	OUT2 (interrupts) enabled
 4	LOOP
 5-7	reserved
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
	AL = port parameters (see #0202 at AH=00h"SERIAL")
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
--------S-1420------------------------------------
INT 14 - HUNTER 16 - SELECT COMMS PARAMETERS
	AH = 20h
	CX = channel number (00h COM1, 01h COM2, ...)
	DS:BX -> buffer with communications parameter (see #0249)
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
Return: AH = status (see #0252)
Note:	monitor mode must have been turned on with AH=24h before calling
SeeAlso: AH=20h"MultiDOS",AH=22h"MultiDOS",AH=24h"MultiDOS"

(Table 0252)
Values for MultiDOS Plus status:
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
--------S-1421------------------------------------
INT 14 - HUNTER 16 - EXTENDED CONTROL
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
Return: AH = port status (see also #0206 at AH=03h)
	     bit 7 = 1 indicates time-out
	AL = character received
Program: PC-MOS/386 v5.01 is a multitasking, multiuser MS-DOS 5.0-compatible
	  operating system by The Software Link, Inc.
SeeAlso: AH=02h,AH=0Fh"PC-MOS",AH=21h"PC-MOS"
--------S-1422------------------------------------
INT 14 - HUNTER 16 - EXTENDED STATUS
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
Return: AL = MW386 port mode (see #0253)
	CX = MW386 port number
	DH = owner's user ID
	DL = owner's task ID
SeeAlso: AH=20h"Alloy",INT 17/AH=8Bh"Alloy"

Bitfields for MW386 port mode:
Bit(s)	Description	(Table 0253)
 0	port is shared (spooler only)
 1	port is spooled instead of direct (spooler only)
 2	port is assigned as logical COM device, not in spooler
 3	port is free
--------S-1423-------------------------------
INT 14 - MultiDOS Plus - GET PORT STATUS
	AH = 23h
	DX = port number
Return: AH = line status (see #0206 at AH=03h)
	AL = modem status (see #0207 at AH=03h)
SeeAlso: AH=03h,AH=07h"MultiDOS",AH=20h"MultiDOS"
--------S-1423-------------------------------
INT 14 - PC-MOS/386 v5.01 $serial.sys v5.04 - DECLARE PORT OWNERSHIP
	AH = 23h
	DX = port number
	BX = TCB segment/selector address of owner task
Return: nothing
SeeAlso: AH=0Dh"PC-MOS"
--------S-1423------------------------------------
INT 14 - HUNTER 16 - CONTROL HANDSHAKE LINES
	AH = 23h
	BH = handshake line to set (00h RTS, 01h DTR)
	BL = new level (00h low, 01h high)
Desc:	sets the handshake lines of COM1 to the desired level
SeeAlso: AH=21h"HUNTER",AH=24h"HUNTER"
--------S-1424-------------------------------
INT 14 - Alloy MW386 v2+ - CHANGE PHYSICAL PORT PARAMETERS
	AH = 24h
	CX = physical I/O port number
	DS:DX -> configuration table (see #0254)
Return: AH = 00h
Note:	invalid port numbers are merely ignored
SeeAlso: INT 17/AH=96h

Format of Alloy MW386 configuration table:
Offset	Size	Description	(Table 0254)
 00h	BYTE	baud rate (see #0255)
 01h	BYTE	data bits (00h=5, 01h=6, 02h=7, 03h=8)
 02h	BYTE	parity (00h none, 01h odd, 02h even)
 03h	BYTE	stop bits (00h=1, 01h=2)
 04h	BYTE	receive flow control
		00h none, 01h XON/XOFF, 02h DTR/DSR, 03h XPC, 04h RTS/CTS
 05h	BYTE	transmit flow control (as for receive)

(Table 0255)
Values for Alloy MW386 baud rate:
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
SeeAlso: #0211
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
--------S-1424------------------------------------
INT 14 - HUNTER 16 - CONTROL CTS HANDSHAKING
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
--------S-1425------------------------------------
INT 14 - HUNTER 16 - CONTROL RS232 DRIVERS
	AH = 25h
	AL = new state of RS232 drivers (00h off, 01h on)
Note:	this function can be used to save power by turning off the RS232
	  drivers.  It can also be used to turn on the RS232 drivers before
	  connecting to a remote system to avoid "garbage" while the drivers
	  turn on.
SeeAlso: AH=23h"HUNTER",AH=24h"HUNTER",AH=26h"HUNTER"
--------S-1426------------------------------------
INT 14 - HUNTER 16 - CONTROL RI POWER UP
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
--------S-1427------------------------------------
INT 14 - HUNTER 16 - GET INSTALLED PROTOCOLS COUNT
	AH = 27h
	AL = number of extended protocols installed (since last call)
Return: AL = total number installed, including new ones
Desc:	Returns the number of extended communication protocols installed
SeeAlso: AH=25h"HUNTER",AH=28h"HUNTER"
--------S-1428------------------------------------
INT 14 - HUNTER 16 - GET PROTOCOL NAME
	AH = 28h
	AL = protocol handle
	DS:BX -> 8 character buffer for protocol name
Return:	AH = status
	    00h successful
		DS:BX buffer filled with the protocol name
	    FFh failed
SeeAlso: AH=27h"HUNTER",AH=29h"HUNTER"
--------S-1429------------------------------------
INT 14 - HUNTER 16 - GET PROTOCOL HANDLE
	AH = 29h
	DS:BX -> buffer containing the protocol name
Return: AH = status
	    00h successful
		AL = handle
	    FFh failed
SeeAlso: AH=28h"HUNTER",AH=2Ah"HUNTER"
--------S-142A------------------------------------
INT 14 - HUNTER 16 - EXTENDED PROTOCOL MENU
	AH = 2Ah
	AL = protocol handle
Return: AH = status
	    00h successful
	    FFh failed
	AL = menu handle
SeeAlso: AH=29h"HUNTER",AH=2Bh"HUNTER"
--------S-142B------------------------------------
INT 14 - HUNTER 16 - GET EXTENDED PROTOCOL PARAMETERS
	AH = 2Bh
	AL = protocol handle
	DS:BX -> buffer for extended protocol parameters
Return: AH = status
	    00h successful
		DS:BX buffer filled with extended parameters
	    FFh failed
SeeAlso: AH=2Ah"HUNTER"
--------S-142C00----------------------------------
INT 14 - HUNTER 16 - GET DTR
	AX = 2C00h
Return: AH = 00h
	BL = current state
	    00h	 normal DTR operation
	    else DTR is forced high
Desc:	Indicates whether the DTR signal on COM1 is forced high
Note:	the Husky Hunter 16 is an 8088-based ruggedized laptop.	 Other family
	  members are the Husky Hunter, Husky Hunter 16/80, and Husky Hawk.
SeeAlso: AH=2Ch"SET DTR"
--------S-142C------------------------------------
INT 14 - HUNTER 16 - SET DTR
	AH = 2Ch
	AL nonzero
	BL = new state
	    00h	 normal operation
	    else force DTR high
Return: AH = 00h
Desc:	determine whether the DTR signal on COM1 should be forced high
SeeAlso: AX=2C00h
--------N-1436-------------------------------
INT 14 - ComShare - INSTALLATION CHECK
	AH = 36h
Return: AX = 4353h ('CS') if installed
	    BX = bitmap of installed ports (bit 0: COM1 is gateway, etc.)
	    CX reserved for future use
	    WORD DX:[0100h] = ComShare version number
Program: The ComShare System is a modem-sharing program for NetBIOS and
	  NetWare-based networks by NashaKala Corporation
Note:	ComShare supports the standard BIOS INT 14h calls with a slight
	  change in the interpretation of speed values (see #0211 at AH=04h)
SeeAlso: AH=00h,AH=04h,AX=F4FFh
--------t-144000-----------------------------
INT 14 - I1541 - INSTALLATION CHECK
	AX = 4000h
Return: AX = 1541h if installed
	    BH = I1541 major version (BCD)
	    BL = I1541 minor version (BCD)
	    CX = 0000h
--------t-144001-----------------------------
INT 14 - I1541 - TEST IF 1541 CABLE CONNECTED
	AX = 4001h
Return: CF clear if connected
	    BL = LPT number where 1541 cable is connected (1..3)
	CF set if cable not connected
Desc:	scan all the LPT ports searching for the adapter cable
SeeAlso: AX=4000h
--------t-144002-----------------------------
INT 14 - I1541 - SELECT LPT PORT FOR OUTPUT
	AX = 4002h
	BL = LPT number (1..3)
Return: CF clear if successful
	CF set otherwise
Desc:	force the input output routines to work on the cable placed on LPT BL
SeeAlso: AX=4001h
--------t-144003-----------------------------
INT 14 - I1541 - RESET ALL DEVICES
	AX = 4003h
Desc:	send a reset pulse of 100ms to all CBM devices
Note:	it is necessary to wait about 2 seconds after reset before executing
	  other	instructions
SeeAlso: AX=4000h,AX=4004h
--------t-144004-----------------------------
INT 14 - I1541 - SEND LISTEN SIGNAL
	AX = 4004h
	BH = device number (0..15)
Return: CF clear if successful
	CF set on error
	    AL = error number (see #0256)
SeeAlso: AX=4005h,AX=4006h

(Table 0256)
Values for I1541 error number:
 00h	device not present
 01h	listener not ready
 02h	missing EOI time-out
 03h	EOI not completed
 04h	data not released
 05h	frame error
--------t-144005-----------------------------
INT 14 - I1541 - SEND SECONDARY ADDRESS FOR LISTEN
	AX = 4005h
	BL = channel number and mode (see #0257)
Return: CF clear if successful
	CF set on error
	    AL = error number (see #0256)
SeeAlso: AX=4004h,AX=4006h

Bitfields for I1541 channel number and mode:
Bit(s)	Description	(Table 0257)
 7-4	mode
	0110 read/write
	1110 close channel
	1111 open channel
 3-0	channel number
--------t-144006-----------------------------
INT 14 - I1541 - SEND UNLISTEN SIGNAL
	AX = 4006h
Return: CF clear if successful
	CF set on error
	    AL = error number (see #0256)
SeeAlso: AX=4004h,AX=4005h
--------t-144007-----------------------------
INT 14 - I1541 - SEND TALK SIGNAL
	AX = 4007h
	BH = device number (0-15)
Return: CF clear if successful
	CF set on error
	    AL = error number (see #0256)
SeeAlso: AX=4008h,AX=4009h
--------t-144008-----------------------------
INT 14 - I1541 - SEND SECONDARY ADDRESS FOR TALK
	AX = 4008h
	BL = channel number and mode (see #0257)
Return: CF clear if successful
	CF set on error
	    AL = error number (see also #0256)
		40h turn around time-out
SeeAlso: AX=4007h,AX=4009h
--------t-144009-----------------------------
INT 14 - I1541 - SEND UNTALK SIGNAL
	AX = 4009h
Return: CF clear if successful
	CF set on error
	   AL = error number (see #0256)
SeeAlso: AX=4007h,AX=4008h
--------t-14400A-----------------------------
INT 14 - I1541 - SEND A BYTE TO A DEVICE
	AX = 400Ah
	BL = byte to send
	CL = last-byte flag
	    00h more bytes follow
	    01h this is the last byte to be sent
Return: CF clear if successful
	CF set on error
	    AL = error number (see #0256)
SeeAlso: AX=4000h,AX=400Bh
--------t-14400B-----------------------------
INT 14 - I1541 - RECEIVE A BYTE FROM A DEVICE
	AX = 400Bh
Return: CF clear if successful
	    AL = byte received
	    CL = last-byte flag
		00h more bytes to follow
		01h received byte is the last
	CF set on error
	    AL = error number
		80h EOI response required
		81h talker not ready
		82h clock not set
		83h clock not released
	    CL = 00h
SeeAlso: AX=4000h,AX=400Ah
--------t-14400C-----------------------------
INT 14 - I1541 - WAIT
	AX = 400Ch
	CX = number of 838ns microticks to wait (0000h means 65536, ~55ms)
SeeAlso: AX=4000h,AX=400Dh
--------t-14400D-----------------------------
INT 14 - I1541 - LONGWAIT
	AX = 400Dh
	DX:CX = number of 838ns microticks to wait
	      (0000h:0000h means 4294967296, about one hour)
Example: To wait 1s you must set DX:CX=(1s/838ns)=1193180
SeeAlso: AX=4000h,AX=400Ch
--------t-14400E-----------------------------
INT 14 - I1541 - GET INFO
	AX = 400Eh
Return: AX = LPT port I/O address in use (0000h if no cable in use)
	BL = LPT number (1..3) in use (00h if no cable in use)
	CF set if the cable is auto-detectable
	CF clear if cable could not be auto-detected or is not present
SeeAlso: AX=4000h
--------S-1456-------------------------------
INT 14 U - BWCOM14 - INSTALLATION CHECK
	AH = 56h
Return: CX = 0001h if installed
Program: BWCOM14 is a network serial port emulator (simulating a Hayes modem
	  connected to the serial port) distributed as part of the
	  Beame&Whiteside BW-NFS package
SeeAlso: AH=57h,AH=58h,INT 2F/AX=DF00h/BX=5445h
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
--------S-146F00-----------------------------
INT 14 - HP Vectra EX-BIOS - "F14_INQUIRE" - INSTALLATION CHECK
	AX = 6F00h
	BX <> 4850h (usually set to 0000h for simplicity)
Return: BX = 4850h ("HP") if HP Extended BIOS serial port extensions available
	AX destroyed
Note:	supported by original HP Vectra AT and by ES/QS/RS series Vectras
SeeAlso: AX=6F01h,AX=6F02h,AX=6F03h,AX=6F04h,INT 10/AX=6F00h,INT 14/AX=6F00h
SeeAlso: INT 17/AX=6F00h,INT 33/AX=6F00h
--------S-146F01-----------------------------
INT 14 - HP Vectra EX-BIOS - "F14_EXINIT" - INITIALIZE SERIAL PORT
	AX = 6F01h
	BX = port attributes (see #0258)
	DX = port number (0-3)
Return: AH = line status (see #0206)
	AL = modem status (see #0207)
Note:	supported by original HP Vectra AT and by ES/QS/RS series Vectras
SeeAlso: AX=6F00h

Bitfields for HP Vectra Extended BIOS serial port attributes:
Bit(s)	Description	(Table 0258)
 8-5	data rate (110, 150, 300, 600, 1200, 2400, 4800, 9600, 19200)
 4-3	parity
	00 none
	01 odd
	10 none
	11 even
 2	stop bits (0 = one, 1 = two)
 1-0	bits per character
	10 seven-bit characters
	11 eight-bit characters
	0x undefined
--------S-146F02-----------------------------
INT 14 - HP Vectra EX-BIOS - "F14_PUT_BUFFER" - TRANSMIT BUFFER
	AX = 6F02h
	CX = number of characters in buffer
	DX = port number (0-3)
	ES:DI -> buffer containing characters
Return: AH = line status (see #0206)
	AL = modem status (see #0207)
	CX = number of bytes actually sent
	ES:DI -> next byte to be transferred (unchanged if all bytes sent)
Desc:	send characters from the specified buffer until all characters have
	  been sent or an error/timeout is encountered
Note:	supported by original HP Vectra AT and by ES/QS/RS series Vectras
SeeAlso: AX=6F00h,AX=6F03h,AX=6F04h,INT 17/AX=6F02h
--------S-146F03-----------------------------
INT 14 - HP Vectra EX-BIOS - "F14_GET_BUFFER" - READ DATA INTO BUFFER
	AX = 6F03h
	CX = size of buffer
	DX = port number (0-3)
	ES:DI -> buffer for received characters
Return: AH = line status (see #0206)
	---on error (AH bit 7 set)---
	   AL = 00h
	   ES:DI -> next byte to be transferred
	---if successful---
	   AL = last byte read
	   ES:DI unchanged
	CX = number of bytes read
Desc:	read characters into the specified buffer until the buffer is filled
	  or a timeout occurs
Notes:	supported by original HP Vectra AT and by ES/QS/RS series Vectras
	polls the Data Set Ready modem status and Data Ready line status bits
	  to determine when characters are available
SeeAlso: AX=6F00h,AX=6F02h,AX=6F04h
--------S-146F04-----------------------------
INT 14 - HP Vectra EX-BIOS - "F14_TRM_BUFFER" - READ UNTIL TERMINATOR
	AX = 6F04h
	BL = lowest termination character
	BH = highest termination character
	CX = size of buffer
	DX = port number (0-3)
	ES:DI -> buffer for received characters
Return: AH = line status (see #0206)
	---on error (AH bit 7 set)---
	   AL = 00h
	   ES:DI -> next byte to be transferred
	---if successful---
	   AL = last byte read
	   ES:DI unchanged
	CX = number of bytes read
Desc:	read characters into the specified buffer until the buffer is filled,
	  a character in the specified range is received, or a timeout occurs
Notes:	supported by original HP Vectra AT and by ES/QS/RS series Vectras
	polls the Data Set Ready modem status and Data Ready line status bits
	  to determine when characters are available
SeeAlso: AX=6F00h,AX=6F02h,AX=6F03h
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
--------S-148000-----------------------------
INT 14 - COMM-DRV v14.0 - READ PORT METRICS - GET ERROR CODE AND BUFFER STATUS
	AX = 8000h
	DX = port number
Return: AX = code for last error (see #0259)
	BX = number of characters in output buffer
	CX = nubmer of characters in input buffer
	DX = state flag (see #0260)
Program: COMM-DRV is a universal serial communications driver by Willies'
	  Computer Software Company, which supports standard INT 14 and
	  FOSSIL calls as well as its own interfaces
SeeAlso: AX=8001h"COMM-DRV",AX=8002h"COMM-DRV",AX=8003h"COMM-DRV"

(Table 0259)
Values for COMM-DRV error code:
 00h	no error
 01h	buffer not set or attempted to change buffer for active port
 02h	port not active
 03h	transmit buffer full
 04h	receive buffer full
 05h	syntax error
 06h	invalid buffer size
 07h	invalid port
 08h	handler changed
 09h	invalid baud rate
 0Ah	invalid parity setting
 0Bh	invalid data length
 0Ch	invalid number of stop bits
 0Dh	invalid protocol number
 0Eh	IRQ changed
 0Fh	port changged
 10h	invalid threshold setting
 11h	invalid IRQ number
 12h	interrupts not enabled
 13h	invalid break syntax
 14h	fatal error
 15h	CTS error
 16h	invalid RS232 I/O port address
 17h	environment variable not set
 18h	error on IOCTL call
 19h	error during atexit cleanup
 1Ah	error mapping for direct calls
 1Bh	error opening device
 1Ch	unable to allocate memory
 1Dh	error on external micro card
 1Eh	card changed error
 1Fh	card type error
 20h	not supported
 21h	parent port error
 22h	card command buffer full
 23h	no subdevice for this port
 24h	unknown error
 25h	external card busy
 26h	no more timers available
 27h	INT 14 vector changed
 28h	INT 08 vector changed
 29h	DPMI error
 2Ah	TSR buffer too small (or nonexistent)
 2Bh	out of asynchronous resources
 2Ch	out of timer resources
 2Dh	out of "other" timer resources
 2Eh	file I/O error
 2Fh	hardware memory > 64K

Bitfields for state flag :
Bit(s)	Description	(Table 0260)
 0	port is active
 1	output throttled (XOFF received, or DSR or CTS reset)
 2	input throttled (XOFF sent, or DTR or RTS reset)
--------S-148001-----------------------------
INT 14 - ARTICOM - UNLOAD ASYNCHRONOUS REDIRECTOR FROM MEMORY
	AX = 8001h
Return: AX = error code, if error (see #0262)
SeeAlso: AX=8000h"ARTICOM",AX=8002h"ARTICOM",AX=8003h"ARTICOM"
Index:	uninstall;ARTICOM
--------S-148001-----------------------------
INT 14 - COMM-DRV v14.0 - READ PORT METRICS - GET PORT PARAMETERS
	AX = 8001h
	DX = port number
Return: BX:DI -> Port Control Block (see #0269)
SeeAlso: AX=8000h"COMM-DRV",AX=8002h"COMM-DRV",AX=8003h"COMM-DRV"
--------S-148002-----------------------------
INT 14 - ARTICOM - GET ASYNCHRONOUS REDIRECTOR STATUS
	AX = 8002h
	ES:DI -> buffer for redirector status structure (see #0261)
Return: AX = error code, if error (see #0262)
SeeAlso: AX=8000h"ARTICOM",AX=8003h"ARTICOM"

Format of ARTICOM redirector status:
Offset	Size	Description	(Table 0261)
 00h	WORD	redirector major and minor version numbers
 02h	WORD	redirectable ports found
 04h	WORD	redirectable ports + local ports found
 06h	WORD	redirector internal buffer size
 08h	WORD	maximum servers maintained
 0Ah	WORD	number of adapters found
--------S-148002-----------------------------
INT 14 - COMM-DRV v14.0 - READ PORT METRICS - GET PORT PARAMETERS
	AX = 8002h
	DX = port number
Return: AH bit 7 set on error
	AH bit 7 clear if successful
	    BX:DI -> Port Control Block (see #0269) (modifyable portion only)
SeeAlso: AX=8000h"COMM-DRV",AX=8001h"COMM-DRV",AX=8003h"COMM-DRV"
--------S-148003-----------------------------
INT 14 - ARTICOM - TRANSLATE ERROR CODE TO ERROR STRING
	AX = 8003h
	CX = error number to translate (see #0262)
Return: ES:DI -> ASCIZ error text or 0000h:0000h if unable to translate
SeeAlso: AX=8000h

(Table 0262)
Values for ARTICOM error codes:
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
--------S-148003-----------------------------
INT 14 - COMM-DRV v14.0 - READ PORT METRICS - GET I/O BUFFER SIZES
	AX = 8003h
	DX = port number
Return: AX = number of characters in input buffer
	BX = input buffer size
	CX = number of characters in output buffer
	DX = output buffer size
SeeAlso: AX=8000h"COMM-DRV",AX=8001h"COMM-DRV",AX=8002h"COMM-DRV"
--------S-148004-----------------------------
INT 14 - ARTICOM - ATTACH ASYNCHRONOUS RESOURCE
	AX = 8004h
	DX = port to redirect (COM1=0, COM2=1, ...)
	CH = attach type
	CL = adapter to use for attach, 0FFh to search all
	ES:DI -> attachment structure (see #0263)
Return: AX = error code, if error (see #0262)
Note:	The wildcard '*' is supported in the server and resource fields.  If
	  wild cards are used then the first matching available server is
	  attached.
SeeAlso: AX=8000h,AX=8003h,AX=8005h

Format of ARTICOM attachment structure:
Offset	Size	Description	(Table 0263)
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
Return: AX = error code, if error (see #0262)
Note:	only a previously attached resource can be detached
SeeAlso: AX=8000h,AX=8003h,AX=8004h
--------S-148006-----------------------------
INT 14 - ARTICOM - GET RESOURCE INFORMATION
	AX = 8006h
	BX = remote port (COM1=0, COM2=1, ...)
	CL = adapter number, FFh to try all adapters
	ES:DI -> resource information structure (see #0264)
	DS:SI -> 16 byte server name. See note.
Return: AX = error code, if error (see #0262)
	BX = next remote port, recall to get next resource info
Note:	Wild cards supported in both the resource field and server name
	  string DS:SI. If wild cards used then first matching available
	  resource information is searched. Set the resource field to FFh to
	  return all resources.
SeeAlso: AX=8000h,AX=8002h,AX=8003h,AX=8007h

Format of ARTICOM resource information structure:
Offset	Size	Description	(Table 0264)
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
	ES:DI -> buffer for port information structure (see #0265)
Return: CF clear if redirection info returned and port is redirected
	CF set if not a redirected port
	AX = error code, if error (see #0262)
SeeAlso: AX=8000h,AX=8003h,AX=8006h,AX=8008h

Format of ARTICOM port information structure:
Offset	Size	Description	(Table 0265)
 00h 16 BYTEs	server name resource is on
 10h	BYTE	adapter number server is on
 11h 16 BYTEs	resource name
 21h	WORD	remote port index, use to get additional information
 23h	WORD	buffer size
 25h	WORD	baud rate (see #0266)
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

(Table 0266)
Values for ARTICOM baud rate:
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
SeeAlso: #0211
--------S-148008-----------------------------
INT 14 - ARTICOM - GET AVAILABLE SERVER NAME
	AX = 8008h
	BX = server index (0,1,...)
	ES:DI -> server name structure (see #0267)
Return: AX = error code, if error (see #0262)
	BX = next remote port, repeat call to get next available server
Note:	the wildcard '*' is supported in the server name field.	 Set the
	  server name to FFh to search for all servers.
SeeAlso: AX=8000h,AX=8003h,AX=8007h

Format of ARTICOM server name structure:
Offset	 Size	  Description	(Table 0267)
  00h 16 BYTEs	  (call) ASCIZ server name
  10h	 BYTE	  (ret) the adapter server is found
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
Return: AX = error code, if error (see #0262)
Note:	for attached ports only!
SeeAlso: AX=8000h,AX=8003h,AX=8009h
--------S-148025-----------------------------
INT 14 - ARTICOM - SET INTERNAL SEND/RECEIVE VECTOR
	AX = 8025h
	DS:DX -> address of trap function (see #0268) to call on read/write
Note:	setting the vector to a user function allows the redirector's activity
	  to be monitored.
SeeAlso: AX=8000h,AX=8035h,INT 21/AH=25h

(Table 0268)
Values ARTICOM trap function is called with:
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
INT 14 - COMM-DRV - EXTENDED INITIALIZATION
	AH = 81h
	BX:DI -> port control block (see #0269)
	DX = port number
Return: AH = line status register (see #0206)
	    error if bit 7 set
	AL = modem status register (see #0207)
Program: COMM-DRV is a universal serial communications driver by Willies'
	  Computer Software Company, which supports standard INT 14 and
	  FOSSIL calls as well as its own interfaces
Note:	AX=8001h should be called first to fill in the port control block
SeeAlso: AH=00h,AX=8001h,AH=82h"COMM-DRV",AH=86h"COMM-DRV"

Format of COMM-DRV port control block:
Offset	Type	Description	(Table 0269)
 00h	WORD	port IO address
 02h	WORD	port IRQ
 04h	WORD	baud rate
 06h	WORD	parity
 08h	WORD	data bits
 0Ah	WORD	stop bits
 0Ch	WORD	break status (0000h off)
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
	ES:DI -> buffer for VFOSSIL information (see #0270)
Return: AX = 1954h if installed
SeeAlso: AH=7Eh,AX=8101h

Format of VFOSSIL information:
Offset	Size	Description	(Table 0270)
 00h	WORD	size of information in bytes, including this field
 02h	WORD	VFOSSIL major version
 04h	WORD	VFOSSIL revision level
 06h	WORD	highest VFOSSIL application function supported
--------V-148101-----------------------------
INT 14 - VIDEO FOSSIL - OPEN VFOSSIL
	AX = 8101h
	ES:DI -> buffer for application function table (see #0271)
	CX = length of buffer in bytes
Return: AX = 1954h if installed
	    BH = highest VFOSSIL application function supported
Note:	the number of initialized pointers in the application function table
	  will never exceed CX/4; if the buffer is large enough, BH+1 pointers
	  will be initialized
SeeAlso: AX=8102h

Format of VFOSSIL application function table:
Offset	Size	Description	(Table 0271)
 00h	DWORD	-> function to query current video mode (VioGetMode)(see #0276)
 04h	DWORD	-> function to set video mode (VioSetMode) (see #0277)
 08h	DWORD	-> function to query hardware config (VioGetConfig) (see #0278)
 0Ch	DWORD	-> function to write data in TTY mode (VioWrtTTY) (see #0279)
 10h	DWORD	-> function to get current ANSI state (VioGetANSI) (see #0280)
 14h	DWORD	-> function to set new ANSI state (VioSetANSI) (see #0281)
 18h	DWORD	-> function to get curr cursor position (VioGetCurPos)
		  (see #0282)
 1Ch	DWORD	-> function to set cursor position (VioSetCurPos) (see #0283)
 20h	DWORD	-> function to get cursor shape (VioGetCurType) (see #0284)
 24h	DWORD	-> function to set cursor shape (VioSetCurType) (see #0285)
 28h	DWORD	-> function to scroll screen up (VioScrollUp) (see #0286)
 2Ch	DWORD	-> function to scroll screen down (VioScrollDn) (see #0287)
 30h	DWORD	-> function to read cell string from screen (VioReadCellStr)
		  (see #0288)
 34h	DWORD	-> function to read char string from screen (VioReadCharStr)
		  (see #0289)
 38h	DWORD	-> function to write a cell string (VioWrtCellStr)
		  (see #0290)
 3Ch	DWORD	-> function to write char string, leaving attr (VioWrtCharStr)
		  (see #0291)
 40h	DWORD	-> function to write char string,const attr (VioWrtCharStrAttr)
		  (see #0292)
 44h	DWORD	-> function to replicate an attribute (VioWrtNAttr)
		  (see #0293)
 48h	DWORD	-> function to replicate a cell (VioWrtNCell)
		  (see #0294)
 4Ch	DWORD	-> function to replicate a character (VioWrtNChar)
		  (see #0295)

Format of VFOSSIL video mode data structure:
Offset	Size	Description	(Table 0272)
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

Format of VFOSSIL video configuration data:
Offset	Size	Description	(Table 0273)
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

Format of VFOSSIL cursor type record:
Offset	Size	Description	(Table 0274)
 00h	WORD	cursor start line
 02h	WORD	cursor end line
 04h	WORD	cursor width (always 01h)
 06h	WORD	cursor attribute (FFFFh = hidden)

(Table 0275)
Values for VFOSSIL error code:
 0000h	successful
 0074h	internal VIO failure
 0163h	unsupported mode
 0166h	invalid row value
 0167h	invalid column value
 017Eh	buffer too small
 01A5h	invalid VIO parameter
 01B4h	invalid VIO handle

(Table 0276)
Call VioGetMode with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to video mode data structure (see #0272)
Return: AX = error code (00h, 74h, 17Eh, 1B4h) (see #0275)
SeeAlso: #0277

(Table 0277)
Call VioSetMode with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to video mode data structure (see #0272)
Return: AX = error code (00h, 74h, 163h, 17Eh, 1A5h, 1B4h) (see #0275)
SeeAlso: #0276

(Table 0278)
Call VioGetConfig with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to video configuration data buffer (see #0273)
Return: AX = error code (00h, 74h, 17Eh, 1B4h) (see #0275)

(Table 0279)
Call VioWrtTTY with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	length of string
		DWORD	pointer to character string to be written to screen
Return: AX = error code (00h, 74h, 1B4h) (see #0275)
Notes:	write wraps at end of line and terminates if it reaches end of screen
	in ANSI mode, ANSI control sequences are interpreted, and this func is
	  not required to be reentrant; in non-ANSI mode, the function is
	  reentrant and may be called from within an MS-DOS function call

(Table 0280)
Call VioGetANSI with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to WORD which will be set to 00h if ANSI is off
			or 01h if ANSI is on
Return: AX = error code (00h, 74h, 1B4h) (see #0275)
SeeAlso: #0281

(Table 0281)
Call VioSetANSI with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to WORD indicating new state of ANSI
			00h off, 01h on
Return: AX = error code (00h, 74h, 1A4h, 1B4h) (see #0275)
SeeAlso: #0280

(Table 0282)
Call VioGetCurPos with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to WORD to hold current cursor column (0-based)
		DWORD	pointer to WORD to hold current cursor row (0-based)
Return: AX = error code (00h, 74h, 1B4h) (see #0275)
SeeAlso: #0283

(Table 0283)
Call VioSetCurPos with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	cursor column
		WORD	cursor row
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see #0275)
Note:	if either coordinate is invalid, the cursor is not moved
SeeAlso: #0282

(Table 0284)
Call VioGetCurType with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to cursor type record (see #0274)
Return: AX = error code (00h, 74h, 1B4h) (see #0275)
SeeAlso: #0285

(Table 0285)
Call VioSetCurType with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to cursor type record (see #0274)
Return: AX = error code (00h, 74h, 1A4h, 1B4h) (see #0275)
SeeAlso: #0286

(Table 0286)
Call VioScrollUp with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to char/attr cell for filling emptied rows
		WORD	number or rows to scroll (FFFFh = clear area)
		WORD	right column of scroll area
		WORD	bottom row of scroll area
		WORD	left column of scroll area
		WORD	top row of scroll area
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see #0275)
SeeAlso: #0287,INT 10/AH=06h

(Table 0287)
Call VioScrollDn with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to char/attr cell for filling emptied rows
		WORD	number or rows to scroll (FFFFh = clear area)
		WORD	right column of scroll area
		WORD	bottom row of scroll area
		WORD	left column of scroll area
		WORD	top row of scroll area
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see #0275)
SeeAlso: #0286,INT 10/AH=07h

(Table 0288)
Call VioReadCellStr with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start reading
		WORD	row at which to start reading
		DWORD	pointer to WORD containing length of buffer in bytes
			on return, WORD contains number of bytes actually read
		DWORD	pointer to buffer for cell string
Return: AX = error code (00h, 74h, 166h ,167h, 1B4h) (see #0275)

(Table 0289)
Call VioReadCharStr with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start reading
		WORD	row at which to start reading
		DWORD	pointer to WORD containing length of buffer in bytes
			on return, WORD contains number of bytes actually read
		DWORD	pointer to buffer for character string
Return: AX = error code (00h, 74h, 166h ,167h, 1B4h) (see #0275)

(Table 0290)
Call VioWrtCellStr with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start writing
		WORD	row at which to start writing
		WORD	length of cell string in bytes
		DWORD	pointer to cell string to write
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see #0275)
Note:	write wraps at end of line and terminates if it reaches end of screen

(Table 0291)
Call VioWrtCharStr with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start writing
		WORD	row at which to start writing
		WORD	length of character string
		DWORD	pointer to character string to write
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see #0275)
Note:	write wraps at end of line and terminates if it reaches end of screen

(Table 0292)
Call VioWrtCharStrAttr with:
	STACK:	WORD	VIO handle (must be 00h)
		DWORD	pointer to attribute to be applied to each character
		WORD	column at which to start writing
		WORD	row at which to start writing
		WORD	length of character string
		DWORD	pointer to character string to write
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see #0275)
Note:	write wraps at end of line and terminates if it reaches end of screen

(Table 0293)
Call VioWrtNAttr with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start writing
		WORD	row at which to start writing
		WORD	number of times to write attribute
		DWORD	pointer to display attribute to replicate
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see #0275)
Note:	write wraps at end of line and terminates if it reaches end of screen

(Table 0294)
Call VioWrtNCell with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start writing
		WORD	row at which to start writing
		WORD	number of times to write cell
		DWORD	pointer to cell to replicate
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see #0275)
Note:	write wraps at end of line and terminates if it reaches end of screen

(Table 0295)
Call VioWrtNChar with:
	STACK:	WORD	VIO handle (must be 00h)
		WORD	column at which to start writing
		WORD	row at which to start writing
		WORD	number of times to write character
		DWORD	pointer to character to replicate
Return: AX = error code (00h, 74h, 166h, 167h, 1B4h) (see #0275)
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
--------S-1482-------------------------------
INT 14 - COMM-DRV v14.0 - PORT CLEANUP
	AH = 82h
	DX = port number
Return: AH bit 7 set on error
	AH bit 7 clear if successful
Desc:	reset the port to its state before the AH=81h initialization and unhook
	  any interrupts used by the port
SeeAlso: AH=81h"COMM-DRV",AH=83h"COMM-DRV"
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
--------S-1483-------------------------------
INT 14 - COMM-DRV v14.0 - FLUSH COMMUNICATION BUFFERS
	AH = 83h
	DX = port number
	AL = subfunction
	    00h flush input buffer
	    01h flush output buffer
	    02h flush both buffers
Return: AH bit 7 set on error
	AH bit 7 clear if successful
SeeAlso: AH=81h"COMM-DRV",AH=84h"COMM-DRV"
--------S-1484-------------------------------
INT 14 - COURIERS.COM - READ CHARACTER
	AH = 84h
Return: ZF set if no characters available
	ZF clear
	   AL = character
	   AH = modem status bits
		bit 7: set on input buffer overflow
SeeAlso: AH=02h,AH=86h,AH=89h
--------S-1484-------------------------------
INT 14 - COMM-DRV v14.0 - SEND PACKET
	AH = 84h
	CX = packet length in bytes
	DX = port number
	ES:DI -> packet to be sent
Return: AH = line status (see #0206)
	    bit 7 set on error
	AL destroyed
SeeAlso: AH=83h"COMM-DRV",AH=85h"COMM-DRV",AH=86h"COMM-DRV"
--------S-1485-------------------------------
INT 14 - COURIERS.COM - FLUSH PENDING INPUT
	AH = 85h
SeeAlso: AH=0Ah,AH=88h"COURIERS"
--------S-1485-------------------------------
INT 14 - COMM-DRV v14.0 - RECEIVE PACKET
	AH = 85h
	CX = length of packet in bytes
	DX = port number
	ES:DI -> buffer for packet
Return: AH = line status (see #0206)
	    bit 7 set on error
	AL destroyed
Note:	this call requires that at least the requested number of bytes are
	  already present in the input buffer, and will fail if there are
	  fewer bytes available
SeeAlso: AH=84h"COMM-DRV",AH=86h"COMM-DRV",AH=8Eh"COMM-DRV"
--------S-1486-------------------------------
INT 14 - COURIERS.COM - START OUTPUT
	AH = 86h
	ES:BX -> output buffer
	CX = length of output buffer
SeeAlso: AH=19h,AH=83h"COURIERS",AH=A4h"BAPI"
--------S-1486-------------------------------
INT 14 - COMM-DRV v14.0 - SET INPUT/OUTPUT TIMEOUTS
	AH = 86h
	BL = maximum clock ticks to wait before signalling error on input func
	BH = maximum clock ticks to wait before signalling error on output
	DX = port number
	SI = input timeout in clock ticks if BL=FFh and BH=FFh
	DI = output timeout in clock ticks if BL=FFh and BH=FFh
Return: AH bit 7 set on error
	AH bit 7 clear if successful
Note:	functions 02h, 85h, and 8Eh will wait for the input timeout before
	  returning an error when no data is available; functions 01h and 84h
	  will wait for the output timeout before returning an error if there
	  is no space to output the data
SeeAlso: AH=01h,AH=02h,AH=84h"COMM-DRV",AH=85h"COMM-DRV",AH=8Eh"COMM-DRV"
--------S-1487-------------------------------
INT 14 - COURIERS.COM - OUTPUT STATUS
	AH = 87h
Return: AX = number of unsent characters
SeeAlso: AX=88h"COURIERS"
--------S-1487-------------------------------
INT 14 - COMM-DRV v14.0 - TURN ON DTR
	AH = 87h
	DX = port number
Return: AH bit 7 set on error
	AH bit 7 clear if successful
SeeAlso: AX=8000h"COMM-DRV",AH=88h"COMM-DRV",AH=89h"COMM-DRV"
--------S-1488-------------------------------
INT 14 - COURIERS.COM - ABORT OUTPUT
	AH = 88h
SeeAlso: AH=09h,AH=85h"COURIERS"
--------S-1488-------------------------------
INT 14 - COMM-DRV v14.0 - TURN OFF DTR
	AH = 88h
	DX = port number
Return: AH bit 7 set on error
	AH bit 7 clear if successful
Program: COMM-DRV is a universal serial communications driver by Willies'
	  Computer Software Company, which supports standard INT 14 and
	  FOSSIL calls as well as its own interfaces
SeeAlso: AX=8000h"COMM-DRV",AH=87h"COMM-DRV",AH=8Ah"COMM-DRV"
--------S-1489-------------------------------
INT 14 - COURIERS.COM - SEND SINGLE CHARACTER
	AH = 89h
	CL = character to send
SeeAlso: AH=01h,AH=84h"COURIERS"
--------S-1489-------------------------------
INT 14 - COMM-DRV v14.0 - TURN ON RTS
	AH = 89h
	DX = port number
Return: AH bit 7 set on error
	AH bit 7 clear if successful
SeeAlso: AX=8000h"COMM-DRV",AH=87h"COMM-DRV",AH=8Ah"COMM-DRV"
--------S-148A-------------------------------
INT 14 - COURIERS.COM - SEND BREAK
	AH = 8Ah
SeeAlso: AH=89h"COURIERS",AH=FAh
--------S-148A-------------------------------
INT 14 - COMM-DRV v14.0 - TURN OFF RTS
	AH = 8Ah
	DX = port number
Return: AH bit 7 set on error
	AH bit 7 clear if successful
SeeAlso: AX=8000h"COMM-DRV",AH=88h"COMM-DRV",AH=89h"COMM-DRV"
--------S-148B-------------------------------
INT 14 - COMM-DRV v14.0 - SET USER INTERRUPT ROUTINE
	AH = 8Bh
	CX = bitmask of interrupt to process
	    00h = deinstall
	BX:DI -> DWORD containing address of function to be called
Return: AH bit 7 clear if successful
	AH bit 7 set on error
--------S-148C-------------------------------
INT 14 - COURIERS.COM - SET SPEED
	AH = 8Ch
	BX = speed in bps
SeeAlso: AH=00h,AH=82h"COURIERS"
--------S-148C-------------------------------
INT 14 - COMM-DRV v14.0 - READ UART REGISTER
	AH = 8Ch
	AL = register offset
	DX = port number
Return: AH bit 7 set on error
	AH bit 7 clear if successful
	    AL = contents of UART register
SeeAlso: AH=8Dh"COMM-DRV"
--------S-148D-------------------------------
INT 14 - COURIERS.COM - DECONFIGURE PORT
	AH = 8Dh
SeeAlso: AH=82h"COURIERS"
--------S-148D-------------------------------
INT 14 - COMM-DRV v14.0 - WRITE UART REGISTER
	AH = 8Dh
	AL = register offset
	BL = new value for UART register
	DX = port number
Return: AH bit 7 set on error
	AH bit 7 clear if successful
SeeAlso: AH=8Ch"COMM-DRV"
--------S-148E-------------------------------
INT 14 - COMM-DRV v14.0 - READ PACKET NONDESTRUCTIVELY
	AH = 8Eh
	CX = length of packet in bytes
	DX = port number
	ES:DI -> buffer for packet
Return: AH = line status (see #0206)
	    bit 7 set on error (see AX=8000h"COMM-DRV")
	AL destroyed
Program: COMM-DRV is a universal serial communications driver by Willies'
	  Computer Software Company, which supports standard INT 14 and
	  FOSSIL calls as well as its own interfaces
Desc:	retrieve a packet from the input buffer without removing it from the
	  buffer
Note:	this call requires that at least the requested number of bytes are
	  already present in the input buffer, and will fail if there are
	  fewer bytes available
SeeAlso: AX=8000h"COMM-DRV",AH=84h"COMM-DRV",AH=85h"COMM-DRV",AH=86h"COMM-DRV"
--------S-14A0-------------------------------
INT 14 - 3com BAPI SERIAL I/O - CONNECT TO PORT
	AH = A0h
	ES:BX -> ASCIZ internet host name
	CX = length of name
Return: AH = return code (00h,04h-06h,08h,0Ah-0Ch) (see #0296)
	CL = session ID
Program: the Bridge Application Program Interface is a set of functions which
	  makes many of the details of LAN communications transparent
Note:	Novell TELAPI.EXE returns AH=09h (not supported) and CL=00h
SeeAlso: AH=A1h"BAPI",AH=A2h"BAPI",AH=A5h"BAPI",AX=AF00h

(Table 0296)
Values for 3com BAPI return code:
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
Return: AH = return code (00h,03h,07h,0Ah,0Bh) (see #0296)
	AL destroyed (Novell TELAPI.EXE)
SeeAlso: AH=A0h"BAPI"
--------S-14A1-------------------------------
INT 14 - Interconnections Inc. TES - GET LIST OF SESSIONS WITH STATUS
	AH = A1h
Return: CX = number of active sessions
	ES:SI -> status array (see #0297)
SeeAlso: AH=A2h"TES",AH=A3h"TES"

Format of Interconnections TES status array entry:
Offset	Size	Description	(Table 0297)
 00h	BYTE	status
 01h	WORD	offset of name
--------S-14A2-------------------------------
INT 14 - 3com BAPI SERIAL I/O - WRITE CHARACTER
	AH = A2h
	AL = character
	DH = session ID (00h for external session managment)
Return: AH = return code (00h,01h,03h,07h,0Ah,0Bh) (see #0296)
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
Return: AH = return code (00h,02h,03h,07h,0Ah,0Bh) (see #0296)
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
Return: AH = return code (00h,01h,03h,07h,0Ah,0Bh) (see #0296)
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
Return: AH = return code (00h,02h,03h,07h,0Ah,0Bh) (see #0296)
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
Return: AH = return code (00h,03h,07h,0Ah,0Bh) (see #0296)
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
Return: AH = return code (00h,03h,07h,0Ah,0Bh) (see #0296)
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
Return: AH = return code (see #0296)
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
Return: AH = return code (see #0296)
	???
SeeAlso: AH=A8h"TelAPI",AH=E4h,INT 6B/AX=0600h
--------V-14AA01-----------------------------
INT 14 - DimVGA v2.0+ - INSTALLATION CHECK
	AX = AA01h
Return: AX = FFFFh if installed, unchanged
	BX = version (v1.5+ only), BH = major, BL = minor (v1.5 = 0105h)
	CX = resident segment (v3.1+)
Program: DimVGA is a public domain screen saver by Menno Pieters
SeeAlso: AX=AA02h,AX=AA03h,AX=AA06h,INT 11/AX=0225h/BX=6900h,INT 12"KEYBUI"
SeeAlso: INT 2D/AL=10h"Burnout Plus",INT 2F/AX=6400h,INT 2F/AH=93h
SeeAlso: INT 2F/AX=C000h"VGAsave",INT 2F/AX=C000h"AD-DOS",INT 2F/AX=C050h
SeeAlso: INT 2F/AX=E300h
Index:	screen saver;DimVGA
--------V-14AA02-----------------------------
INT 14 - DimVGA v2.0+ - SET TIME-OUT (DIMMING/BLANKING) PERIOD
	AX = AA02h
	BX = number of clock ticks
Return: AX = FFFFh
Note:	on screen modes with 256 or less colors DimVGA will dim the screen,
	  when more than 256 colors can be used DimVGA will blank the screen.
SeeAlso: AX=AA01h,AX=AA03h,AX=AA04h,AX=AA06h
Index:	screen saver;DimVGA
--------V-14AA03-----------------------------
INT 14 - DimVGA v2.0+ - SET DIMMING FACTOR
	AX = AA03h
	BX = percentage remaining visible (1-99)
Return: AX = FFFFh
SeeAlso: AX=AA02h,AX=AA05h,AX=AA06h
Index:	screen saver;DimVGA
--------V-14AA04-----------------------------
INT 14 - DimVGA v2.0+ - GET TIME-OUT PERIOD
	AX = AA04h
Return: AX = FFFFh
	BX = current time-out in clock ticks
SeeAlso: AX=AA02h,AX=AA05h,AX=AA0Ah
Index:	screen saver;DimVGA
--------V-14AA05-----------------------------
INT 14 - DimVGA v2.0+ - GET DIMMING FACTOR
	AX = AA05h
Return: AX = FFFFh
	BX = current dimming factor
SeeAlso: AX=AA03h,AX=AA04h,AX=AA0Ah
Index:	screen saver;DimVGA
--------V-14AA06-----------------------------
INT 14 - DimVGA v2.0+ - DISABLE
	AX = AA06h
Return: AX = FFFFh
SeeAlso: AX=AA01h,AX=AA07h,AX=AA0Ah
Index:	screen saver;DimVGA
--------V-14AA07-----------------------------
INT 14 - DimVGA v2.0+ - ENABLE
	AX = AA07h
Return: AX = FFFFh
SeeAlso: AX=AA01h,AX=AA06h,AX=AA0Ah
Index:	screen saver;DimVGA
--------V-14AA08-----------------------------
INT 14 - DimVGA v2.0+ - DIM SCREEN 'MANUALLY'
	AX = AA08h
Return: AX = FFFFh
Note:	this function will dim the screen immediately, even if DimVGA is
	  currently disabled
SeeAlso: AX=AA01h,AX=AA02h,AX=AA09h
Index:	screen saver;DimVGA
--------V-14AA09-----------------------------
INT 14 - DimVGA v2.0+ - UNDIM SCREEN 'MANUALLY'
	AX = AA09h
Return: AX = FFFFh
Note:	this function will undim the screen immediately, even if DimVGA is
	  currently disabled
SeeAlso: AX=AA01h,AX=AA08h
Index:	screen saver;DimVGA
--------V-14AA0A-----------------------------
INT 14 - DimVGA v2.0+ - CHECK WHETHER ENABLED
	AX = AA0Ah
Return: AX = FFFFh
	BX = current state (0000h disabled, 0001h enabled)
SeeAlso: AX=AA01h,AX=AA06h,AX=AA07h
Index:	screen saver;DimVGA
--------V-14AA0B-----------------------------
INT 14 - DimVGA v2.1+ - SET HOTKEY
	AX = AA0Bh
	BH = shift state (see #0298)
	BL = keyboard scancode
Return: AX = FFFFh
SeeAlso: AX=AA01h,AX=AA0Ch
Index:	screen saver;DimVGA

Bitfields for DimVGA hotkey shift state:
Bit(s)	Description	(Table 0298)
 7-4	unused
 3	Alt key pressed
 2	Ctrl key pressed
 1	Left shift key pressed
 0	Right shift key pressed
--------V-14AA0C-----------------------------
INT 14 - DimVGA v2.1+ - GET HOTKEY
	AX = AA0Ch
Return: AX = FFFFh
	BH = shift state (see #0298)
	BL = keyboard scancode
SeeAlso: AX=AA01h,AX=AA0Bh
Index:	screen saver;DimVGA
--------V-14AA0D-----------------------------
INT 14 - DimVGA v3.0+ - SET MOUSE CHECK STATUS
	AX = AA0Dh
	BX = new mouse check status
	    0000h mouse checking off
	    0001h mouse checking on
Return: AX = FFFFh
Note:	before switching mouse checking on, a mouse driver should be
	  found in memory. If no mouse driver is found, mouse checking
	  should be switched off (resident DimVGA does not check by itself).
SeeAlso: AX=AA01h,AX=AA0Eh
Index:	screen saver;DimVGA
--------V-14AA0E-----------------------------
INT 14 - DimVGA v3.0+ - GET MOUSE CHECK STATUS
	AX = AA0Eh
Return: BX = mouse check status (0000h disabled, 0001h enabled)
SeeAlso: AX=AA01h,AX=AA0Dh
Index:	screen saver;DimVGA
--------V-14AA0F-----------------------------
INT 14 - DimVGA v3.4 - SET LOCKING STATUS
	AX = AA0Fh
	BX = locking status
	    0000h disabled
	    0001h enabled
Return: AX = FFFFh
SeeAlso: AX=AA01h,AX=AA0Dh,AX=AA10h
Index:	screen saver;DimVGA
--------V-14AA10-----------------------------
INT 14 - DimVGA v3.4 - GET MOUSE CHECK STATUS
	AX = AA10h
Return: BX = locking status (0000h disabled, 0001h enabled)
SeeAlso: AX=AA01h,AX=AA0Dh,AX=AA0Fh
Index:	screen saver;DimVGA
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
Return: AH = return code (00h,07h,0Ah) (see #0296)
Note:	disabling the ECM character allows applications to send data which
	  includes the ECM character
SeeAlso: AX=AF00h"BAPI",AH=B1h,AH=B2h
--------S-14B1-------------------------------
INT 14 - 3com BAPI SERIAL I/O - ENTER COMMAND MODE
	AH = B1h
Return: AH = return code (00h,07h,0Ah) (see #0296)
Desc:	provide a means for the application or terminal emulator to perform
	  the same action normally caused by the ECM character
SeeAlso: AH=B0h,AH=B2h
--------S-14B2-------------------------------
INT 14 - 3com BAPI SERIAL I/O - GET ECM WATCH STATE
	AH = B2h
Return: AH = return code (00h,07h,0Ah) (see #0296)
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
Return: AH = return code (00h,03h,09h-0Bh) (see #0296)
	---if AL=00h---
	CX = configuration item value (see above)
SeeAlso: AH=B2h
--------N-14E0-------------------------------
INT 14 - TelAPI - "telopen" - CREATE TELNET CONNECTION (BLOCKING)
	AH = E0h
	BX = port number to connect with (default 0017h used if <= 0)
	CX:DX = Internet address of remote host
	DS:DI -> 2-byte remote host (session) identifier
	ES:SI -> 1700-byte buffer for Telnet state record
	    0000h:0000h to use TelAPI internally-allocated space
Return: AX = status (0000h-0009h,FED3h,FF37h,FFBDh,FFC0h,FFCDh) (see #0299)
	ES:SI buffer filled with state record
	ES:SI -> internally-allocated state record in some versions
Note:	the remote host identifier may be used to refer to this connection
SeeAlso: AH=E1h,AH=ECh,AX=FF00h

(Table 0299)
Values for TelAPI status:
 0000h-7FFFh	successful (session number)
 FED3h	(-301)	no session allocated, or out of TelAPI data space
 FF37h	(-201)	all sessions in use
 FFBDh	(-67)	unknown hostname
 FFC0h	(-64)	host not functioning
 FFC3h	(-61)	connection attempt refused
 FFC4h	(-60)	connection attempt timed out
 FFC8h	(-56)	socket already connected
 FFCDh	(-51)	network is unreachable
 FFDDh	(-35)	operation would block
--------S-14E000-----------------------------
INT 14 - MX5 Extended FOSSIL - GET MNP STATUS BLOCK
	AX = E000h
	DX = port number (0-3)
Return: ES:BX -> status block (see #0300)
Program: MX5 is a FOSSIL driver by MagicSoft which emulates MNP Level 5, and
	  ships with the MTEZ terminal program as MTEMNP.DRV (a TSR despite
	  the .DRV extension)
SeeAlso: AX=E006h

Format of MX5 Extended FOSSIL status block:
Offset	Size	Description	(Table 0300)
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
INT 14 - TelAPI - "telclose" - TERMINATE TELNET CONNECTION
	AH = E1h
	BX = connection ID
Return: AX = status (0000h,FFF7h,maybe others) (see #0299)
Note:	flushes and releases all buffers and data space used by the connection
SeeAlso: AH=E0h,AH=E6h,AX=FF00h
--------N-14E2-------------------------------
INT 14 - TelAPI - "telread" - BUFFERED READ
	AH = E2h
	BX = connection ID (see AH=E0h"TelAPI")
	CX = length of buffer in bytes
	ES:SI -> buffer for data
Return: AX > 0000h number of characters actually read
	AX = 0000h host has closed connection
	AX < 0000h error code (see #0299)
Note:	translates CRLF into local EOL if the connection is in ASCII mode,
	  negotiates various Telnet options, and immediately executes several
	  different Telnet action commands
SeeAlso: AH=E3h,AH=E6h,AX=FF00h,INT 6B/AH=01h
--------N-14E3-------------------------------
INT 14 - TelAPI - "telwrite" - BUFFERED WRITE
	AH = E3h
	BX = connection ID
	CX = length of buffer in bytes
	ES:SI -> buffer containing data
Return: AX > 0000h number of characters actually written
	AX < 0000h error code (see #0299)
Note:	translates local EOL into CRLF if the connection is in ASCII mode,
	  sends the appropriate Telnet commands for the characters selected
	  for IP, AYT, AO, EC, EL, and Break
SeeAlso: AH=07h"TelAPI",AH=E2h,AH=E6h,AX=FF00h,INT 6B/AH=00h
--------N-14E4-------------------------------
INT 14 - TelAPI - "telioctl" - CONNECTION CONTROL
	AH = E4h
	BX = connection ID (see AH=E0h"TelAPI")
	CX = Telnet command/option identifier (see #0302)
	ES:SI -> buffer containing command/option argument (see #0301)
Return: AX = status (0000h, etc.) (see #0299)
Desc:	start filter control, initiate Telnet option negotiation, or get filter
	  control status
SeeAlso: AH=A9h,AH=E6h,AX=FF00h,INT 6B/AX=0600h

Format of TelAPI Telnet command/option argument:
Offset	Size	Description	(Table 0301)
 00h  5 WORD	numeric arguments
 0Ah	DWORD	-> ASCIZ string
SeeAlso: #0302

(Table 0302)
Values for TelAPI Telnet command/option identifier:
 01h	ASCII		args: none
 02h	BINARY		args: none
 03h	LOCALECHO	args: none		client echos data
 04h	REMOTEECHO	args: none		server echos data
 05h	SGA		args: none		Suppress Go-Ahead signal
 07h	CHARMODE	args: none		no line-buffering
 08h	LINEMODE	args: -> erase-line ch	perform line-buffering
 09h	RECVEOL		args: EOL type
 0Ah	SENDEOL		args: EOL type
 0Bh	EOR		args: none		enable end-of-record sequence
 0Dh	BREAK		args: -> break char
 0Eh	VERBOSE		args: verbosity		display Telnet negotiations?
 0Fh	AYT		args: -> AYT escape ch
 10h	AO		args: -> AO escape char
 11h	IP		args: -> IP escape char
 12h	EC		args: -> escape char
 13h	EL		args: -> escape char
 14h	STATUS		args: type; returns data in structure
 18h	TERMTYPE	args: -> terminal type
 19h	ATTACHPORT	args: port number ; returns session number
 1Bh	TRANSMIT_EOR	args: EOR enabled	append EOR to every telwrite?
SeeAlso: #0301
--------N-14E5-------------------------------
INT 14 - TelAPI - "telreset" - RESET ALL CONNECTIONS
	AH = E5h
Return: AX = status (0000h,other) (see also #0299)
	    FFFFh unable to reset
Desc:	close all sessions and reset TelAPI to defaults
SeeAlso: AH=E1h,AH=E6h,AX=FF00h
--------N-14E6-------------------------------
INT 14 - TelAPI - "telunload" - UNINSTALL
	AH = E6h
Return: AX = status
	    0000h successful
	    FFFFh unable to uninstall
Notes:	TelAPI also supports the NASI/NACS and NCSI APIs on INT 6B
	this function invokes AH=E5h internally
SeeAlso: AH=E5h,AX=FF00h,INT 6B/AH=00h,INT 6B/AH=10h
--------N-14E7-------------------------------
INT 14 - TelAPI - "tellist" - GET TELNET SESSION LIST
	AH = E7h
	ES:SI -> 10-word buffer for session list
Return: AX = 0000h (successful)
	ES:SI buffer filled
Desc:	determine, for each of the ten allowable sessions, whether the session
	  is currently available
Note:	each word in the buffer is filled with either 0000h to indicate that
	 the corresponding sesion is unavailable, or 0001h if available
SeeAlso: AH=E0h,AH=E5h,AX=FF00h
--------N-14E8-------------------------------
INT 14 - TelAPI - "telattach" - ATTACH COM PORT TO/FROM TELNET SESSION
	AH = E8h
	BX = connection ID (see AH=E0h"TelAPI")
	CX = serial port number (0000h-0003h = COM1-COM4)
	DX = ??? (ignored by Novell TELAPI v4.01)
Return: AX = status
	    0000h successful
	    FFFFh failed
SeeAlso: AH=E0h,AH=E9h,AX=FF00h
--------N-14E9-------------------------------
INT 14 - TelAPI - "telportosn" - GET SESSION NUMBER FOR COM PORT
	AH = E9h
	DX = serial port number (0000h-0003h = COM1-COM4)
Return: AX >= 0000h session number
	AX < 0000h error code (see #0299)
SeeAlso: AH=E0h,AH=E8h,AH=EAh,AX=FF00h
--------N-14EA-------------------------------
INT 14 - TelAPI - "telstatus" - GET TELNET CONNECTION STATUS INFORMATION
	AH = EAh
	BX = connection ID (see AH=E0h"TelAPI")
	ES:SI -> buffer for status info (see #0303)
Return: AX = status (0000h,FFFFh,etc.)
SeeAlso: AH=E9h,AH=EBh,AX=FF00h

Format of TelAPI Telnet connection status information:
Offset	Size	Description	(Table 0303)
 00h  4 BYTEs	remote host IP address
 04h 20 BYTEs	reserved
 18h	WORD	local port number
 1Ah	BYTE	connection mode (00h = ASCII, 01h = Binary)
 1Bh	BYTE	echo flag (00h local, 01h remote)
 1Ch	BYTE	SGA flag (00h will, 01h won't)
 1Dh	BYTE	EOR negotation flag (00h do negotiate, 01h don't)
 1Eh	BYTE	buffering (00h line mode, 01h character mode)
 1Fh	BYTE	reserved
 20h	BYTE	verbose flag (00h no, 01h verbose mode)
 21h	BYTE	received EOL (00h no xlat, 01h CR, 02h LF, 03h CRLF)
 22h	BYTE	sent EOL (00h no translation, 01h CR, 02h LF)
 23h	BYTE	break character
 24h	BYTE	IP escape character
 25h	BYTE	AO escape character
 26h	BYTE	AYT escape character
 27h	BYTE	EC escape character
 28h	BYTE	EL escape character
 29h 41 BYTEs	ASCIZ Telnet-negotiated terminal type
 52h  9 BYTEs	session ID
SeeAlso: #0304
--------N-14EB-------------------------------
INT 14 - TelAPI - "telname" - GET AVAILABLE/INUSE STATUS FOR ALL SESSIONS
	AH = EBh
	ES:SI -> buffer for session statuses (see #0304)
Return: ES:SI buffer filled
SeeAlso: AH=E9h,AH=EAh,AX=FF00h

Format of TelAPI session status information [array]:
Offset	Size	Description	(Table 0304)
 00h	BYTE	session state (00h available, 01h connected)
 01h  9 BYTEs	session ID if connected
 0Ah	WORD	attached COM port if connected, FFFFh if not
SeeAlso: #0303
--------N-14EC-------------------------------
INT 14 - TelAPI - "telnblkopen" - CREATE TELNET CONNECTION (NON-BLOCKING)
	AH = ECh
	BX = port number to connect with (default 0017h used if <= 0)
	CX:DX = Internet address of remote host
	DS:DI -> 2-byte remote host (connection) identifier
	ES:SI -> 1700-byte buffer for Telnet state record
	    0000h:0000h to use TelAPI internally-allocated space
Return: AX = status (0000h-0009h,FED3h,FF37h,FFBDh,FFC0h,FFCDh) (see #0299)
	ES:SI buffer filled with state record
	ES:SI -> internally-allocated state record in some versions
Notes:	the remote host identifier may be used to refer to this connection
	this function returns immediately; use AH=EDh to check whether the
	  connection has been established yet
	this function is not supported by the Microdyne TelAPI v3.7
SeeAlso: AH=E0h"TelAPI",AH=EDh,AX=FF00h
--------N-14ED-------------------------------
INT 14 - TelAPI - "telpoll" - POLL TELNET SESSION FOR CONNECTION COMPLETION
	AH = EDh
	BX = connection ID (see AH=ECh)
Return: AX = status (0000h,0001h,FFFFh,etc.) (see also #0299)
	    0000h session now connected
	    0001h connection still in progress
Note:	this function is not supported by the Microdyne TelAPI v3.7
SeeAlso: AH=EDh,AX=FF00h
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
	    0000h if not installed
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
SeeAlso: AH=36h"ComShare",AH=F9h,AH=FCh
--------S-14F9-------------------------------
INT 14 - IBM/Yale EBIOS SERIAL I/O - REGAIN CONTROL
	AH = F9h
	DX = port (00h-03h)
SeeAlso: AX=F4FFh
--------S-14FA-------------------------------
INT 14 - IBM/Yale EBIOS SERIAL I/O - SEND BREAK
	AH = FAh
	DX = port (00h-03h)
SeeAlso: AH=07h"MBBIOS",AH=1Ah,AH=8Ah
--------S-14FB-------------------------------
INT 14 - IBM/Yale EBIOS SERIAL I/O - SET OUTGOING MODEM SIGNALS
	AH = FBh
	AL = modem control register (see #0236 at AH=05h)
	DX = port (00h-03h)
SeeAlso: AH=05h"SERIAL"
--------S-14FC-------------------------------
INT 14 - IBM/Yale EBIOS SERIAL I/O - READ CHARACTER, NO WAIT
	AH = FCh
	DX = port (00h-03h)
Return: AH = RS232 status bits (see #0206 at AH=03h)
	AL = character
SeeAlso: AH=02h,AH=0Ch,AX=FF02h
--------S-14FD02-----------------------------
INT 14 - IBM/Yale EBIOS SERIAL I/O - READ STATUS
	AX = FD02h
Return: CX = number of characters available
--------N-14FF00-----------------------------
INT 14 - TelAPI - "telcheck" - INSTALLATION CHECK
	AX = FF00h
Return: AX = 00FFh if installed
	    BX = version number * 100 (decimal)
SeeAlso: AH=E6h,AX=F4FFh
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
--------S-14FFF8-----------------------------
INT 14 - COMM-DRV v14.0 - SET BAUD RATE DIVISOR
	AX = FFF8h
	BX = card type (sub-device number)
	CX = new baudrate divisor
	DX = index to baud rate
Return: AH bit 7 set on error
	AH bit 7 clear if successful
Program: COMM-DRV is a universal serial communications driver by Willies'
	  Computer Software Company, which supports standard INT 14 and
	  FOSSIL calls as well as its own interfaces
SeeAlso: AX=8000h"COMM-DRV"
--------S-14FFFB-----------------------------
INT 14 - COMM-DRV v14.0 - GET HIGHEST ALLOWED PORT NUMBER
	AX = FFFBh
	DX = port number
Return: AH bit 7 set on error
	AH bit 7 clear if successful
	    BX = highest port number
--------S-14FFFC-----------------------------
INT 14 - COMM-DRV v14.0 - GET INT 14 FLAGS
	AX = FFFCh
	DX = port number
Return: AH bit 7 set on error
	AH bit 7 clear if successful
	    BX = flags (see #0305)
SeeAlso: AX=FFFDh

Bitfields for INT 14h flags:
Bit(s)	Description	(Table 0305)
 0	port active for INT 14h
 1	interface behaving like a FOSSIL driver
--------S-14FFFD-----------------------------
INT 14 - COMM-DRV v14.0 - SET INT 14 FLAGS
	AX = FFFDh
	BX = flags (see #0305)
	DX = port number
Return: AH bit 7 set on error
	AH bit 7 clear if successful
SeeAlso: AX=FFFCh
--------S-14FFFE-----------------------------
INT 14 - COMM-DRV v14.0 - RESTORE INT 14 VECTOR TO ORIGINAL
	AX = FFFEh
Return: AH bit 7 set on error
	AH bit 7 clear if successful
--------S-14FFFF-----------------------------
INT 14 - COMM-DRV v14.0 - GET INT 14 INFORMATION AREA
	AX = FFFFh
	BX:SI -> DWORD buffer for address of information area (see #0306)
		  (initialized to zeros)
Return: BX:SI buffer filled with nonzero value if installed
Program: COMM-DRV is a universal serial communications driver by Willies'
	  Computer Software Company, which supports standard INT 14 and
	  FOSSIL calls as well as its own interfaces
Index:	installation check;COMM-DRV

Format of COMM-DRV information area:
Offset	Size	Description	(Table 0306)
 00h  8 BYTEs	signature "COMM-DRV"
 08h  2 BYTEs	00h,00h
 0Ah	DWORD	-> direct address mapping table
 0Eh	DWORD	previous INT 14 vector
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
	AL = NVRAM location (00h to 3Fh) (see #0307)
	BL = NVRAM data value
Return: AH = return code
	    00h OK
	    01h address bad
	    02h write error
SeeAlso: AH=02h"Amstrad"

Format of Amstrad NVRAM:
Offset	Size	Description	(Table 0307)
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
 0Ah	BYTE	RTC status register A (see #0308)
 0Bh	BYTE	RTC status register B (see #0309)
 0Ch	BYTE	RTC status register C (read-only) (see #0310)
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

Bitfields for RTC status register A:
Bit(s)	Description	(Table 0308)
 7	set if date/time being updated
 6-4	time base speed, default 010 = 32768 Hz
 3-0	interrupt rate selection, default 0110 = 1024 Hz

Bitfields for RTC status register B:
Bit(s)	Description	(Table 0309)
 7	clear if normal update, set if abort update
 6	periodic interrupt enable
 5	alarm interrupt enable
 4	update end interrupt enable
 3	square wave enable
 2	date mode (clear = BCD, set = binary)
 1	24-hour format
 0	daylight saving time enable

Bitfields for RTC status register C:
Bit(s)	Description	(Table 0310)
 7	IRQF flag
 6	PF flag
 5	AF flag
 4	UF flag
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
	AH = status (see #0311)
SeeAlso: AH=00h"CASSETTE",AH=03h"CASSETTE"

(Table 0311)
Values for Cassette status:
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
	AH = status (see #0311)
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
	ES:DI -> 32-byte results buffer for System Parameter Table (see #0312)
	DS = segment containing ABIOS RAM extensions (zero if none)
Return: CF clear if successful
	    AH = 00h success
	    ES:DI buffer filled
	    AL destroyed
	CF set on failure
	    AX destroyed
	    AH = 80h/86h if not supported
SeeAlso: AH=05h"ABIOS",AH=C1h

Format of ABIOS System Parameter Table:
Offset	Size	Description	(Table 0312)
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
	ES:DI -> results buffer of length 18h * Number_of_Entries (see #0313)
	DS = segment containing ABIOS RAM extensions (zero if none)
Return: CF clear if successful
	    AH = 00h success
	    ES:DI buffer filled
	    AL destroyed
	CF set on failure
	    AX destroyed
	    AH = 80h/86h if not supported
SeeAlso: AH=04h"ABIOS",AH=C1h

Format of one entry of ABIOS Initialization Table:
Offset	Size	Description	(Table 0313)
 00h	WORD	device ID (see #0314)
 02h	WORD	number of Logical IDs
 04h	WORD	Device Block length (zero for ABIOS patch or extension)
 06h	DWORD	-> init routine for Device Block and Function Transfer Table
 0Ah	WORD	request block length
 0Ch	WORD	Function Transfer Table length (zero for a patch)
 0Eh	WORD	Data Pointers length (in Common Data Area)
 10h	BYTE	secondary device ID (hardware level this ABIOS ver supports)
 11h	BYTE	revision (device driver revision level this ABIOS supports)
 12h  6 BYTEs	reserved

(Table 0314)
Values for ABIOS device ID:
 00h	ABIOS internal calls
 01h	floppy disk
 02h	hard disk
 03h	video
 04h	keyboard
 05h	parallel port
 06h	serial port
 07h	system timer
 08h	real-time clock
 09h	system services
 0Ah	NMI
 0Bh	mouse
 0Eh	CMOS RAM
 0Fh	DMA
 10h	Programmable Option Select (POS)
 16h	keyboard password
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
		 WORD	BIOS parameter byte (see #0202 at INT 14/AH=00h),
			except bits 7-5: 000 = 19200, 001 = 38400, 011 = 115200
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
Note:	the "delay" command reportedly disables the keyboard until the delay
	  completes
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
Return: CF clear if formatting should continue
	CF set if formatting should terminate
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
SeeAlso: INT 2F/AX=1680h,INT 60/DI=0106h,INT 62/AH=01h,INT 6F/AH=2Ah"F_YIELD"
SeeAlso: INT 7A/BX=000Ah,INT 7F/AH=02h"MultiLink",INT 7F/AH=E8h
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
Return: BX = status
	    FFFFh if ES:DI is a valid object handle (see #0316)
	    0000h if ES:DI is not
Note:	under DESQview versions prior to 2.50, an object handle is always a
	  pointer to the object; for versions 2.50 and up, only task handles
	  are always pointers--other handles may consist of a unique object
	  number and offset into DESQview's common memory (see #0325)
SeeAlso: AX=DE14h,AX=DE2Bh,AX=DE2Ch

(Table 0315)
Values for DESQview object type:
 00h	window/task
 01h	mailbox
 02h	keyboard
 03h	timer
 04h	pointer
 05h	panel
 06h	objectq

Format of DESQview object:
Offset	Size	Description	(Table 0316)
 00h	WORD	offset in common memory of previous object of same type
 02h	WORD	offset in common memory of next object of same type
 04h	WORD	signature FEDCh (DV 2.42-)
		signature FEDCh or object number (DV 2.50+)
 06h	WORD	object type (see #0315)
 08h	DWORD	object handle to return to caller
 0Ch	DWORD	canonicalized object address (segment = common memory)
 10h	WORD	offset in common memory of owning task
		(0000h for unowned OBJECTQs)
 12h	WORD	mapping context
		offset in common memory of mapping context record (see #0318)
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
 17h	WORD	segment of internal window record (see #0319)
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
		  to full screen
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
		  (see #0317).	No register save record in use if < 01C0h
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
 B6h	BYTE	task status (see #0451 at AX=DE2Ch)
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
10Bh	DWORD	pointer to process record (see #0320,#0321)
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
		(see #0322)
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
		(from INT 15/AX=DE27h) (see #0322)
14Ch	BYTE	???
14Eh 42 BYTEs	task's default keyboard object
179h 32 BYTEs	task's ObjectQ object
199h 41 BYTEs	task's default mailbox object
1C2h 24 BYTEs	first register save record
452h	--	default top of private stack

Format of DESQview Register Save Record:
Offset	Size	Description	(Table 0317)
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

Format of DESQview mapping context record:
Offset	Size	Description	(Table 0318)
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
 4Eh	WORD	segment of script buffer (see #0323)
 50h  6 BYTEs	???

Format of DESQview Internal Window Record (v2.31-2.60):
Offset	Size	Description	(Table 0319)
 00h	BYTE	internal window number???
 01h	BYTE	display page???
 02h	BYTE	video mode
 03h  3 BYTEs	???
 06h	BYTE	logical window height
 07h	BYTE	logical window width
 08h	DWORD	pointer to text video buffer
 0Ch 116 BYTEs	???

Format of DESQview process record (v2.31):
Offset	Size	Description	(Table 0320)
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

Format of DESQview process record (v2.52-v2.60) (probably also 2.5x):
Offset	Size	Description	(Table 0321)
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
		(from INT 15/AX=DE27h) (see #0322)
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

Format of DESQview task or process instance data record (v2.5x???, v2.60):
Offset	Size	Description	(Table 0322)
 00h	DWORD	pointer to next record of same type or 00000000
 04h	DWORD	pointer to previous record of same type or 00000000
 08h	DWORD	pointer to source area of memory during restore state
 0Ch	WORD	number of bytes to save/restore
 0Eh	DWORD	pointer to destination area of memory during restore state
 12h	WORD	??? (0)
 14h  N BYTEs	source memory buffer during restore state

Format of DESQview script buffer (v2.60):
Offset	Size	Description	(Table 0323)
 00h 13 BYTEs	ASCIZ Script filename
 0Dh 80 BYTEs	???
 5Eh  N BYTEs	script records (see #0324)

Format of one DESQview script record (v2.60):
Offset	Size	Description	(Table 0324)
 00h	BYTE	signature 12h
 01h 18 BYTEs	blank-padded script name
 13h	BYTE	ASCII code of key attached to script or 0 if non-ASCII key
 14h	BYTE	scan code of key attached to script if non-ASCII, else 0
 15h	BYTE	???
 16h	WORD	size of script in bytes
 18h  N	BYTEs	script (ASCII code of each keystroke; if 0, next byte is
		  scan code of non-ASCII key)

Format of DESQview Common Memory Header (v2.31-2.60):
Offset	Size	Description	(Table 0325)
 00h	WORD	offset of lowest used block
 02h	WORD	bytes of commom memory, including header
 04h	WORD	offset of first free block
 06h  N BYTEs	size depends of DV version, ??? (DVP buffer???)
Note:	the above is located at the beginning of the commom memory segment
SeeAlso: #0326,#0327,#0335

Format of DESQview Free block header:
Offset	Size	Description	(Table 0326)
 00h	WORD	size of block in bytes including header
 02h	WORD	offset of next free block
 04h  N BYTEs	free block
SeeAlso: #0325,#0327

Format of DESQview Used block header:
Offset	Size	Description	(Table 0327)
 00h	WORD	size of block in bytes including header
 02h  N BYTEs	used block
SeeAlso: #0325,#0326
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
	    0000h if no window
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
	DL = general window position (see #0328)
	CH = number of columns to offset from position specified by DL
	CL = number of rows to offset from position specified by DL
Return: nothing

Bitfields for TopView general window position:
Bit(s)	Description	(Table 0328)
 0,1	horizontal position
	00 = current, 01 = center, 10 = left, 11 = right
 2,3	vertical position
	00 = current, 01 = center, 10 = top, 11 = bottom
 4	don't redraw screen if set
 5-7	not used
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
	ES:DI -> contents of .PIF/.DVP file (see #0329)
	BX = size of .PIF/.DVP info
Return: BX = segment of object handle for new task
	     0000h on error
SeeAlso: AX=DE24h,INT 21/AH=4Bh

Format of .PIF/.DVP file:
Offset	Size	Description	(Table 0329)
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
16Fh	BYTE	program flags 1 (see #0330)
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
17Ch	BYTE	nonzero to automatically close on exit (see also #0332)
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
184h	BYTE	DVP program flags 3 (see #0331)
185h	BYTE	keyboard conflict level (0-4 for DV<2.26, 00h-0Fh for DV2.26+)
		(see #0333)
186h	BYTE	number of graphics pages used
187h	WORD	extra system memory size
189h	BYTE	initial screen mode (FFh = default) (overrides offset E5h)
---information unique to DESQview 2.2+---
18Ah	BYTE	serial port usage
		FFh uses all serial ports
		00h no serial ports
		01h only COM1
		02h only COM2
18Bh	BYTE	DVP program flags 4 (see #0332)
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
1A0h  N BYTEs	list of variable length records (see #0334)

Bitfields for .PIF/.DVP program flags 1:
Bit(s)	Description	(Table 0330)
 7	writes text directly to screen
 6	runs in foreground only (see also offset 184h)
 5	uses math coprocessor
 4	accesses system keyboard buffer directly
 3-1	reserved (0)
 0	swappable
SeeAlso: #0329,#0331,#0332

Bitfields for .DVP program flags 3:
Bit(s)	Description	(Table 0331)
 7	automatically assign window position
 5	maximum memory value has been specified
 4	disallow "Close" command
 3	foreground-only when doing graphics
	set by DV 2.3+ when "Runs in Background" = "D" (undoc)
 2	don't virtualize (see also #0332)
 1	foreground-only during DOS calls
	set by DV 2.3+ when "Runs in Background" = "D" (undoc)
SeeAlso: #0329,#0330,#0332

Bitfields for .DVP program flags 4:
Bit(s)	Description	(Table 0332)
 7	automatically close application on exit if .COM or .EXE	specified
	(see also #0329 offset 17Ch)
 6	swappable if not using serial ports
 5	start program with window hidden (v2.26+)
 4	start program in background (v2.26+)
 3	virtualize text (see also #0331)
 2	virtualize graphics (see also #0331)
 1	share CPU when foreground
 0	share EGA when foreground and zoomed
SeeAlso: #0329,#0330,#0331

Bitfields for DESQview keyboard conflict level:
Bit(s)	Description	(Table 0333)
 3	save/restore entire INT 09 handler state every taskswtch
 2	take special precautions for programs which read the BIOS keyboard
	  buffer directly from memory
 1	never indicate keystroke available during scripts/xfers
 0	only indicate keystroke available every sixth poll
SeeAlso: #0329

Format of DESQview/X variable length record:
Offset	Size	Description	(Table 0334)
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
SeeAlso: #0329
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
		ES:DI -> allocated system memory (see #0335)
	    0001h failed
		ES:DI = 0000h:0000h
Note:	under DV 2.42, this call is identical to AX=1001h
SeeAlso: AX=1001h,AX=1002h,AX=DE0Ch

Format of DESQview system memory block header:
Offset	Size	Description	(Table 0335)
 00h	WORD	segment of next header or 0000h
 02h	WORD	segment of previous header or 0000h
 04h	WORD	size of block in paragraphs, including header
 06h	BYTE	availability flag (00h in use, 01h free)
Note:	this header is located one paragraph before the memory block proper
SeeAlso: #0325
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
Note:	a private entry point (see #0336) may be found by searching the
	  beginning of the returned segment for the signature string
	  "QUARTERDECK EXTENDED MEMORY MANAGER 286"; the word immediately
	  prior to the signature contains the QEXT version number in BCD,
	  and the word prior to that contains the offset within the QEXT
	  code segment of the private entry point
SeeAlso: INT 2F/AX=4310h,INT 67/AH=3Fh

(Table 0336)
Call QEXT.SYS private entry point with:
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
	STACK: DWORD handle of panel object (see #0337)
Return: STACK: DWORD length of directory (always multiple of 14 bytes)
	       DWORD address of directory
Note:	a null string is returned if the object is not open
SeeAlso: AH=12h/BX=0400h"APPLY",AH=12h/BH=83h

Format of TopView panel file:
Offset	Size	Description	(Table 0337)
 00h  2 BYTEs	C0h C3h
 02h	BYTE	number of panels in file
 03h	for each panel in file:
	    8 BYTEs  blank-padded panel name
	      DWORD  panel offset in file
	      WORD   panel length
	data for panels (each consists of one or more window/query/manager
	  streams); first byte of each panel must be 1Bh, fifth byte must be
	  E5h
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
			    DWORD address of pointer message (see #0338)
Notes:	for a keyboard in keystroke mode, the input buffer is a single byte
	  containing the character code as returned by the BIOS; the BIOS scan
	  code is available via the STATUS call if the character is zero
	for a keyboard in field mode, the input buffer format is determined
	  by the field table header for the window the keyboard is attached to
	keyboard input buffers and mailbox message buffers may be invalidated
	  by the next READ, ERASE, CLOSE, or FREE message to the same object
SeeAlso: AH=12h/BH=05h"OBJECT",AH=12h/BH=84h

Format of DESQview pointer message:
Offset	Size	Description	(Table 0338)
 00h	WORD	row
 02h	WORD	column
 04h	BYTE	status (see #0339)
 05h	BYTE	field number or zero (APILEVEL >= 2.00 only)

Bitfields for DESQview pointer status:
Bit(s)	Description	(Table 0339)
 7-2	number of clicks-1 if multiple-click mode active
 7	set when press/release mode active and button pressed
 6	set when press/release mode active and button released
 1-0	button pressed (00=none,01=button1,10=button2)
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
	       DWORD address of string to display (see #0340)
Return: indicated actions performed
	a. non-control characters are displayed (opcodes DEh and DFh control
	   whether the attributes are left or changed to the current attrib)
	b. CR/LF/BS/Tab cause the usual cursor movement
	c. ESC starts a data structure with additional commands if following
	   byte is less than 20h; otherwise, it is written to the window
	STACK:	DWORD handle of new window if window stream opcode E6h
		else nothing
SeeAlso: AH=12h/BH=04h,AH=12h/BH=85h

Format of stream data structure:
Offset	Size	Description	(Table 0340)
 00h	BYTE	1Bh magic value identifying start of stream
 01h	BYTE	stream type (00h, 01h, 10h, 14h-1Fh legal)
		(see #0341,#0347,#0348,#0349)
 02h	WORD	length of remainder of stream in bytes
	var-length fields follow, each an OPCODE followed by
	     zero or more args

(Table 0341)
Values for MODE 00h (set or display values) "WINDOW STREAM" opcodes:
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
 80h-87h display N blanks with default attribute
	BYTE low 8 bits of 11-bit count (high 3 in low 3 bits of OPCODE)
		  [000h means 800h]
 88h-8Fh display N copies of the character
	BYTE low 8 bits of 11-bit count (high 3 in low 3 bits of OPCODE)
		  [000h means 800h]
	BYTE character to repeat
 90h-97h display N blanks with specified attribute
	BYTE low 8 bits of 11-bit length (high 3 in low 3 bits of OPCODE)
		  [000h means 800h]
	BYTE attribute
 98h-9Fh display string at logical cursor pos
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
	BYTE number of rows
 A7h  set width of physical window
	BYTE number of columns
 A8h  set viewport row
	BYTE row
 A9h  set viewport column
	BYTE column
 AAh  set virtual screen height [contents of window unpredictable after]
	BYTE rows
 ABh  set virtual screen width [contents of window unpredictable after]
	BYTE columns
 ACh-AEh unused
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
	BYTE number of rows (signed, negative values move up)
		[if rows=0 and hardware cursor owner, update hardware cursor]
 B1h  move logical cursor right
	BYTE number of columns (signed, negative values move left)
		[if cols=0 and hardware cursor owner, update hardware cursor]
 B2h  shift top edge of scrolling region
	BYTE number of rows (signed)
 B3h  shift left edge of scrolling region
	BYTE number of columns (signed)
 B4h  shift physical window down
	BYTE number of lines (signed)
 B5h  shift physical window right
	BYTE number of columns (signed)
 B6h  expand physical window vertically
	BYTE number of lines (signed)
 B7h  expand physical window horizontally
	BYTE number of columns (signed)
 B8h  adjust viewport row
	BYTE number of rows (signed)
 B9h  adjust viewport column
	BYTE number of columns (signed)
 BAh  adjust virtual screen height [contents of window unpredict after]
	BYTE number of rows to increase (signed)
 BBh  adjust virtual screen width [contents of window unpredictbl after]
	BYTE number of columns to increase (signed)
 BCh-BFh reserved (currently unused)
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
	BYTE number of rows
	BYTE number of columns
 C4h  set upper left corner of viewport (portion of virtual screen displayed
	  in window)
	BYTE row
	BYTE column
 C5h  set size of virtual screen [contents unpredictable afterwards]
	BYTE number of rows
	BYTE number of columns
 C6h  unused
 C7h  unused
 C8h  set logical cursor relative to current position
	BYTE number of rows to move down (signed)
	BYTE number of columns to move right (signed)
		[if rows=cols=0 and hardware cursor owner, update hardw cursor]
 C9h  shift top left corner of scrolling region
	BYTE number of rows (signed)
	BYTE number of columns (signed)
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
	BYTE number of rows to expand (signed)
	BYTE number of columns to expand (signed)
 CEh  scroll text when using E8h-EBh/F8h-FBh opcodes (default)
 CFh  scroll attributes when using  E8h-EBh/F8h-FBh opcodes
 D0h  allow window frame to extend beyond screen
 D1h  always display a complete frame, even if window extends beyond edge of
	  screen
 D2h  allow DV to change logical colors on video mode switch (default)
 D3h  application changes logical attributes
 D4h  window is visible [must redraw to actually make visible]
 D5h  window is hidden [must redraw to actually remove]
 D6h  window has frame (default)
 D7h  window unframed [must redraw to actually remove frame]
 D8h  READ/READN will read characters from window (default)
 D9h  READ/READN will read attributes from window
 DAh  use logical attributes, which may be remapped (see #0342)
 DBh  use physical attributes for characters
 DCh  enable special actions for control characters (default)
 DDh  disable special control char handling, all chars displayable by BIOS TTY
	  call
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
	Note:	the window is created with a physical size of 0x0 at the
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
		bit 7	if set, copy single following byte to indicated attribs
		bits 4-6  number of first attribute to change - 1
		bits 0-3  number of consecutive attributes to change
	N BYTEs new attributes
 EDh  set logical attributes for window frame
	BYTE video modes command applies to (see opcode ECh)
	BYTE which attributes to set
		bit 7	if set, copy single following byte to indicated attrs
		bits 4-6  number of first attribute to change - 1
		bits 0-3  number of consecutive attributes to change
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
		bit 7	if set, copy single following byte to indicated chars
		bits 4-6  number of first character to change - 1
		bits 0-3  number of consecutive characters to change
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
 F7h  "broadcast write"	write data to fields with program output bit set in
	  the field table entry, in field number order
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
	6 BYTEs	field table header (see #0343)
 FDh  reset modified bit for all fields
 FEh  reset selected and modified bits for all fields
 FFh  set up input fields
	6 BYTEs	table header (see #0343)
	7/8N BYTEs the field table entries, one for each field (see #0345)
	Note:	DESQview uses and updates the actual copy of the information
		  which is contained in the stream.  Thus this info must remain
		  intact until after the data entry is complete.

(Table 0342)
Values for TopView logical attributes:
 01h	normal text
 02h	highlighted normal text
 03h	help text
 04h	highlighted help text
 05h	error message
 06h	highlighted error message
 07h	emphasized text
 08h	marked text
 9-16	reverse video versions of 1-8

Format of TopView field table header:
Offset	Size	Description	(Table 0343)
 00h	BYTE	number of fields (must be <= existing number of fields)
 01h	BYTE	screen behavior bits (see #0344)
 02h	BYTE	current input field (updated by DESQview)
 03h	BYTE	current select field (updated by DESQview)
 04h	BYTE	attribute for select fields when they are pointed at
 05h	BYTE	attribute for select fields which have been selected

Bitfields for TopView screen behavior bits:
Bit(s)	Description	(Table 0344)
 7	reserved
 6	menu items may be selected via keyboard
 5	left mouse button in "status" mode (press anywhere in window
	  immediately returns control to application)
 4	right mouse button in "status" mode
 3	select fields return contents or blanks rather than 'Y' or 'N'
 2	modified bits reset on return to application
 1-0	type of data returned
	00 no data returned on read of keyboard
	01 data returned as array of characters containing all fields packed
	      together, with no field numbers
	10 data returned as numbered variable-length records for all fields
	11 data returned as numbered variable-length records for the fields
	      which were modified

Format of TopView field table entry:
Offset	Size	Description	(Table 0345)
 00h	BYTE	start row	  \
 01h	BYTE	start column  \ if menu selection and start is to
 02h	BYTE	end row	   / right or below end, select from kbd only
 03h	BYTE	end column   /
 04h	BYTE	field type (see #0346)
 05h	BYTE	modifier
		if type is fill-in, then bit flags to determine behavior
		  bit 7	 automatically enter CR when field full
		  bit 6	 move to next field when current field is full
		  bit 5	 enter text from right end (for numbers)
		  bit 4	 force input to uppercase
		  bit 3	 clear old contents on first keystroke
		  bit 2	 input returned when cursor moves out of
			  modified field ("validate", API level 2.02+)
		  bit 1	 reserved
		  bit 0	 reserved
		if select field, first key to press to activate
		  00h if have to point-&-click or is an extended-ASCII
		      keystroke (only if two-key menus enabled)
 06h	BYTE	(select field only) normal color of field
 07h	BYTE	second key for select field.  This byte is present iff
		  two-letter menu entries selected with opcode E5h, and in that
		  case is present regardless of field type

Bitfields for TopView field type:
Bit(s)	Description	(Table 0346)
 7,6	field class
	00 inactive (non-entry) field
	01 echos keystrokes input to make menu selection
	10 fill-in field
	11 select field
 5	field can be filled by broadcast write (F7h opcode)
 4	reserved
 3	reserved
 2	reserved
 1	set if field selected
 0	set if field modified

(Table 0347)
Values for MODE 01h "QUERY STREAM" opcodes:
(valid only for those opcodes listed here)
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
		bit 7	unused???
		bits 4-6 first attribute to get - 1
		bits 0-3 number of consecutive attributes
	N BYTEs buffer to hold attributes
 EDh get logical attributes for window frame
	BYTE execute call if currently in video mode (see opcode ECh)
	BYTE which attributes to get
		bit 7	unused???
		bits 4-6 first attribute to get - 1
		bits 0-3 number of consecutive attributes
	N BYTEs buffer to hold attributes
 EEh get characters for window frame
	BYTE execute call if currently in video mode (see opcode ECh)
	BYTE which attributes to get
		bit 7	unused???
		bits 4-6 first char to get - 1
		bits 0-3 number of consecutive chars
	N BYTEs buffer to hold chars
 EFh return first N characters of current window name
	BYTE	max length of returned name
	N BYTEs buffer to hold window name
 F3h return contents of specified field
	BYTE field number
	N BYTEs buffer to hold field contents (size equal to field size)
 F5h get field table entry
	BYTE field number
	7-8 BYTEs buffer to hold field table entry (see #0345)
	Notes:	DV < 2.26 always returns 7 bytes
		DV 2.26+ w/ APILEVEL < 2.26 returns 8 bytes iff field table
		  is using 8-byte entries and eighth byte after	F5h is E7h
		  (NOP); otherwise, 7 bytes are returned
		DV 2.26+ w/ APILEVEL > 2.26 returns 7 or 8 bytes depending
		  on the field table entry size
 F6h get type of a field
	BYTE field number
	BYTE type
 FCh get field table header
	6 BYTEs buffer to store field table header (see #0343)

(Table 0348)
Values for MODE 10h "MANAGER STREAM" opcodes (valid only for those listed):
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
 8Ah set primary asynchronous notification routine (see #0350)
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
 CBh cancel current window manager operation, remove DV menu, give control
	  to topmost application
 CCh orphan window and give it to the system for use as paste data
 CEh reorder windows
	DWORD pointer to null-terminated list of words; each word is segment
		  of object handle for a window
 FFh no operation

(Table 0349)
Values for MODES 14h to 1Fh "USER STREAMS":
	normally NOPs, but may be defined by SETESC message to invoke FAR
	routines, one for each mode number
	  on entry to handler,
		DS:SI -> first byte of actual stream (not header)
		CX = number of bytes in stream
		ES:DI = window's handle

(Table 0350)
Values asynchronous notification routine defined by man.stream 8Ah called with:
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
		pointer: set control flags (see #0352)
		keyboard: set control flags (see #0351)
	    04h set control flags on KEYBOARD object (handle on top of stack)
	    05h set control flags on task's default KEYBOARD object
	STACK: (if timer)   DWORD duration in 1/100 seconds
	       (otherwise)  DWORD bits to set
SeeAlso: AH=12h/BH=0Bh"OBJECT"

Bitfields for DESQview keyboard object bits:
Bit(s)	Description	(Table 0351)
 15	reserved, can't be set
 14	unused
 13	reserved, can't be set
 12-6	unused
 5	(DV 2.2+) exclusive input
 4	filter all keys (used with handler established by SETESC)
	if 0, only keys that would normally be displayed are filtered
 3	program continues executing while input in progress
 2	insert mode active for field mode
 1	hardware cursor displayed when task is hardware cursor owner
	must be set if keyboard in field mode and field table includes input
	  fields
 0	keyboard is in field mode rather than keystroke mode

Bitfields for DESQview pointer object bits:
Bit(s)	Description	(Table 0352)
 15	reserved, can't be set
 14-8	unused
 7	mouse pointer is hidden while in window
 6	get messages even if window not topmost
 5	get messages even if window not foreground
 4	multiple clicks separated by less than 1/3 second are counted and
	  returned in a single message
 3	pointer position is relative to screen origin, not window origin
 2	send message on button release as well as button press
 1	(DV 2.23+) send message with row=FFFFh and col=FFFFh whenever the
	  pointer leaves the window
 0	send message only on button activity, not movement
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
	STACK:	DWORD	which bits to clear (see #0351,#0352)
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
Return: STACK popped
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
	       (if keyboard) DWORD address of FAR filter function (see #0353)
Return: STACK popped

(Table 0353)
Values keyboard filter function is called with when keyboard is in field mode:
	AL = character
	AH = 00h or extended ASCII code if AL = 00h
	BL = field number
	CH = cursor column
	CL = cursor row
	DL = field type modifier (sixth item in field table entry)
	DH = seventh item in field table entry
	ES:SI = window's handle
	DS:DI -> field table entry for field containing the cursor
Return:	AH = action to take
	    00h use keystroke
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
Return: STACK popped if BL=00h
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
	STACK: DWORD flags (see #0354,#0355)
Return: STACK popped
Notes:	only available if the API level has been set to at least 2.20
	equivalent to performing SUBFROM and ADDTO calls on the object
	if a mailbox has bits 4 or 5 set, you must use "READINTO" rather than
	  "READ" (see AH=12h/BX=1300h"READINTO") to retrieve messages
SeeAlso: AH=12h/BH=0Ah,AH=12h/BH=0Bh,AH=12h/BH=16h

Bitfields for DESQview mailbox object flags:
Bit(s)	Description	(Table 0354)
 0	all mail messages in common memory
 1	allow write even if closed
 2	don't erase messages when mailbox closed
 4	(DV/X) append messages with like status and sender (stream-oriented
	  mail)
 5	(DV/X) store mail in expanded memory (pool grows as needed)
 6	(DV/X) make mailbox into non-owned mailbox

Bitfields for DESQview keyboard object flags:
Bit(s)	Description	(Table 0355)
 5	exclusive input when keyboard in use for input
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
Return: STACK: DWORD current control flags (see #0354,#0355)
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
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=00h

(Table 0356)
Values for DESQview error code:
 00h	no error
 01h	invalid values
 02h	alias invalid
 03h	handle valid but wrong type
 04h	invalid handle
--------Q-1512--BH81-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 01h WITH ERROR RECOVERY
	AH = 12h
	BH = 81h
Note:	this function is identical to AH=12h/BH=01h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=01h
--------Q-1512--BH82-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 02h WITH ERROR RECOVERY
	AH = 12h
	BH = 82h
Note:	this function is identical to AH=12h/BH=02h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=02h
--------Q-1512--BH83-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 03h WITH ERROR RECOVERY
	AH = 12h
	BH = 83h
Note:	this function is identical to AH=12h/BH=03h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=03h,AH=12h/BX=0300h
--------Q-1512--BH84-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 04h WITH ERROR RECOVERY
	AH = 12h
	BH = 84h
Note:	this function is identical to AH=12h/BH=04h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=04h,AH=12h/BX=0400h
--------Q-1512--BH85-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 05h WITH ERROR RECOVERY
	AH = 12h
	BH = 85h
Note:	this function is identical to AH=12h/BH=05h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=05h
--------Q-1512--BH86-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 06h WITH ERROR RECOVERY
	AH = 12h
	BH = 86h
Note:	this function is identical to AH=12h/BH=06h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=06h
--------Q-1512--BH87-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 07h WITH ERROR RECOVERY
	AH = 12h
	BH = 87h
Note:	this function is identical to AH=12h/BH=07h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=07h
--------Q-1512--BH88-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 08h WITH ERROR RECOVERY
	AH = 12h
	BH = 88h
Note:	this function is identical to AH=12h/BH=08h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=08h
--------Q-1512--BH89-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 09h WITH ERROR RECOVERY
	AH = 12h
	BH = 89h
Note:	this function is identical to AH=12h/BH=09h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=09h
--------Q-1512--BH8A-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Ah WITH ERROR RECOVERY
	AH = 12h
	BH = 8Ah
Note:	this function is identical to AH=12h/BH=0Ah, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=0Ah
--------Q-1512--BH8B-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Bh WITH ERROR RECOVERY
	AH = 12h
	BH = 8Bh
Note:	this function is identical to AH=12h/BH=0Bh, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=0Bh
--------Q-1512--BH8C-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Ch WITH ERROR RECOVERY
	AH = 12h
	BH = 8Ch
Note:	this function is identical to AH=12h/BH=0Ch, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=0Ch
--------Q-1512--BH8D-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Dh WITH ERROR RECOVERY
	AH = 12h
	BH = 8Dh
Note:	this function is identical to AH=12h/BH=0Dh, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=0Dh
--------Q-1512--BH8E-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Eh WITH ERROR RECOVERY
	AH = 12h
	BH = 8Eh
Note:	this function is identical to AH=12h/BH=0Eh, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=0Eh
--------Q-1512--BH8F-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Fh WITH ERROR RECOVERY
	AH = 12h
	BH = 8Fh
Note:	this function is identical to AH=12h/BH=0Fh, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=0Fh
--------Q-1512--BH90-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 10h WITH ERROR RECOVERY
	AH = 12h
	BH = 90h
Note:	this function is identical to AH=12h/BH=10h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=10h
--------Q-1512--BH91-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 11h WITH ERROR RECOVERY
	AH = 12h
	BH = 91h
Note:	this function is identical to AH=12h/BH=11h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=11h,AH=12h/BX=1100h
--------Q-1512--BH92-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 12h WITH ERROR RECOVERY
	AH = 12h
	BH = 92h
Note:	this function is identical to AH=12h/BH=12h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=12h,AH=12h/BX=1200h
--------Q-1512--BH93-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 13h WITH ERROR RECOVERY
	AH = 12h
	BH = 93h
Note:	this function is identical to AH=12h/BH=13h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=13h
--------Q-1512--BH94-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 14h WITH ERROR RECOVERY
	AH = 12h
	BH = 94h
Note:	this function is identical to AH=12h/BH=14h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=14h
--------Q-1512--BH95-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 15h WITH ERROR RECOVERY
	AH = 12h
	BH = 95h
Note:	this function is identical to AH=12h/BH=15h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=15h
--------Q-1512--BH96-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 16h WITH ERROR RECOVERY
	AH = 12h
	BH = 96h
Note:	this function is identical to AH=12h/BH=16h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #0356)
SeeAlso: AH=12h/BH=16h
--------!---Section--------------------------
