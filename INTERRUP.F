Interrupt List, part 6 of 16
Copyright (c) 1989,1990,1991,1992,1993,1994,1995,1996,1997 Ralf Brown
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
Return: ES:BX -> ELRES history structure (see #1069)
	DX = DABEh (signature, DAve BEnnett)
Program: ELRES is an MS-DOS return code (errorlevel) recorder by David H.
	  Bennett which stores recent errorlevel values, allows them to be
	  retrieved for use in batch files, and can place them in an
	  environment variable
SeeAlso: AH=4Bh"ELRES",AH=4Dh

Format of ELRES history structure:
Offset	Size	Description	(Table 1069)
 00h	WORD	number of return codes which can be stored by following buffer
 02h	WORD	current position in buffer (treated as a ring)
 04h  N BYTEs	ELRES buffer
--------l-212B00CX5643-----------------------
INT 21 - The Volkov Commander - GET POINTER TO LEFT PANEL DATA STRUCTURE
	AX = 2B00h
	CX = 5643h ('VC')
	DX = 4F4Dh ('OM')
Return: AL = 0
	ES:BX -> left panel data structure
Program: Volcov Commander is a shell for MS-DOS by Vsevolod V. Volkov
SeeAlso: AX=2B01h/CX=5643h,AX=2B02h/CX=5643h
--------l-212B01CX5643-----------------------
INT 21 - The Volkov Commander - GET POINTER TO RIGHT PANEL DATA STRUCTURE
	AX = 2B01h
	CX = 5643h ('VC')
	DX = 4F4Dh ('OM')
Return: AL = 0
	ES:BX -> right panel data structure
SeeAlso: AX=2B00h/CX=5643h,AX=2B02h/CX=5643h
--------l-212B02CX5643-----------------------
INT 21 - The Volkov Commander - GET POINTER TO GLOBAL VARIABLES
	AX = 2B02h
	CX = 5643h ('VC')
	DX = 4F4Dh ('OM')
Return: AL = 0
	ES:BX -> global variables
SeeAlso: AX=2B00h/CX=5643h,AX=2B01h/CX=5643h
--------m-212B01CX444D-----------------------
INT 21 - Quarterdeck DOS-UP.SYS v2.00 - INSTALLATION CHECK
	AX = 2B01h
	CX = 444Dh ('DM')
	DX = 4158h ('AX')
Return: AX = 0000h if installed
	    BX = DOS-UP version (BH = minor, BL = major)
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
	ES:DX -> data area in TAME-RES (see #1070,#1074,#1076)
Program: TAME is a shareware program by David G. Thomas which gives up CPU
	  time to other partitions under a multitasker when the current
	  partition's program incessantly polls the keyboard or system time

Format of TAME 2.10-2.20 data area:
Offset	Size	Description	(Table 1070)
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
 44h	BYTE	interrupts already grabbed by TAME (see #1071)
 45h	BYTE	flags for interrupts which may be acted on (same bits as above)
 46h	BYTE	TAME enabled (01h) or disabled (00h)
 47h	BYTE	/TIMEPOLL (01h) or /NOTIMEPOLL (00h)
 48h	BYTE	/NOTIMER (01h) or /TIMER (00h)
 49h	BYTE	window or task number for this task
 4Ah	BYTE	multitasker type (see #1072)
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
Bit(s)	Description	(Table 1071)
 0	INT 10h
 1	INT 14h
 2	INT 15h
 3	INT 16h
 4	INT 17h
 5	INT 21h
 6	INT 28h

(Table 1072)
Values for multitasker type:
 01h	DESQview
 02h	DoubleDOS
 03h	TopView
 04h	OmniView
 05h	VM/386

Bitfields for type of task switching selected:
Bit(s)	Description	(Table 1073)
 0	DESQview
 1	DoubleDOS
 2	TopView
 3	OmniView
 4	KeySwitch
 5	HLT instruction

Format of TAME 2.30 data area:
Offset	Size	Description	(Table 1074)
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
 5Ch	BYTE	interrupts already grabbed by TAME (see #1071)
 5Dh	BYTE	flags for interrupts which may be acted on (same bits as above)
 5Eh	BYTE	window or task number for this task
 5Fh	BYTE	multitasker type (see #1072)
 60h	BYTE	type of task switching selected (bit flags) (see #1073)
 61h	BYTE	watch_DOS
 62h	BYTE	action flags (see #1075)
 63h	BYTE	old status
 64h	WORD	signature DA34h

Bitfields for TAME action flags:
Bit(s)	Description	(Table 1075)
 0	TAME enabled
 1	/FREQ instead of /MAX (X and Y count fields are per tick)
 2	/TIMEPOLL
 3	/KEYPOLL
 4	inhibit timer
 5	enable status monitoring
SeeAlso: #1074,#1076

Format of TAME 2.60 data area:
Offset	Size	Description	(Table 1076)
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
 68h	BYTE	interrupts already grabbed by TAME (see #1071)
 69h	BYTE	flags for interrupts which may be acted on (same bits as above)
 6Ah	BYTE	window or task number for this task
 6Bh	BYTE	multitasker type (see #1072)
 6Ch	BYTE	type of task switching selected (bit flags) (see #1073)
 6Dh	BYTE	watch_DOS
 6Eh	BYTE	action flags (see #1075)
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
	CX:DX -> API entry point (see #1077)
SeeAlso: INT 16/AH=79h

(Table 1077)
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
	    DS:SI -> initialization request structure (see #1078)
	    Return: AX = function status (see #1081)
	AX = 0002h get status
	    Return: AH = current operating mode (see #1078)
		    AL = current connection status (see #1080)
	AX = 0003h suspend remote screen updates
	    Return: AX = function status (see #1081)
	AX = 0004h resume screen updates
	    Return: AX = function status (see #1081)
	AX = 0005h end current remote access session
	    DS:SI -> termination request structure (see #1079)
	    Return: AX = function status (see #1081)
	AX = 0006h remove pcANYWHERE IV from memory
	    Return: AX = status (see #1081)
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
Offset	Size	Description	(Table 1078)
 00h	BYTE	operating mode
		00h wait for a call
		01h hot key activates
		02h incoming call activates
		03h initiate a call
 01h  3 BYTEs	user ID to append to config file names
 04h	WORD	DS-relative pointer to path for config files
 06h	WORD	DS-relative pointer to path for program files

Format of pcANYWHERE termination request structure:
Offset	Size	Description	(Table 1079)
 00h	BYTE	operating mode after termination
		00h wait for a call
		01h hot key activates
		02h incoming call activates
		80h use current mode
		FFh remove from memory

Bitfields for current connection status:
Bit(s)	Description	(Table 1080)
 0	a physical connection is active
 1	remove screen updating is active
 2	connection checking is active
 3	hot key detection is active
 4	background file transfer is active

(Table 1081)
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
--------l-212B--CX5643-----------------------
INT 21 - Volkov Commander - INSTALLATION CHECK
	AH = 2Bh
	CX = 5643h ('VC')
	DX = 4F4Dh ('OM')
	AL = function number
	    00h get left window data address
	    01h get right window data address
	    02h get address of general variables
Return: AL = 00h if Volkov Commander installed
	    AH = version code (27h for v4.00.039)
	    ES:BX -> requested data
Program: Volkov Commander is a Norton Commander-like DOS shell
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
SeeAlso: AH=2Bh/CX=6269h"bitFOSS",INT 11/AH=BCh
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
SeeAlso: AH=2Ah,AH=2Dh,AH=E7h"Novell",INT 1A/AH=00h,INT 1A/AH=02h,INT 1A/AH=FEh
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
	BH = MS-DOS OEM number (see #1082)
---if DOS 5+ and AL=01h---
	BH = version flag
	    bit 3: DOS is in ROM
	    other: reserved (0)
Notes:	the OS/2 v1.x Compatibility Box returns major version 0Ah (10)
	the OS/2 v2.x Compatibility Box returns major version 14h (20)
	OS/2 Warp 3.0 Virtual DOS Machines report v20.30; Warp 4 VDMs report
	  v20.40.
	the WindowsNT DOS box returns version 5.00, subject to SETVER
	DOS 4.01 and 4.02 identify themselves as version 4.00; use
	  INT 21/AH=87h to distinguish between the original European MS-DOS 4.0
	  and the later PC-DOS 4.0x and MS-DOS 4.0x
	IBM DOS 6.1 reports its version as 6.00; use the OEM number to
	  distinguish between MS-DOS 6.00 and IBM DOS 6.1 (there was never an
	  IBM DOS 6.0)
	MS-DOS 6.21 reports its version as 6.20; version 6.22 returns the
	  correct value
	Windows95 returns version 7.00 (the underlying MS-DOS), as did the
	  "Chicago" beta (reported in _Microsoft_Systems_Journal_,August 1994);
	  Windows95 OSR2 returns version 7.10
	DR DOS 5.0 and 6.0 report version 3.31; Novell DOS 7 reports IBM v6.00,
	  which some software displays as IBM DOS v6.10 (because of the version
	  mismatch in true IBM DOS, as mentioned above).  The Novell DOS 7
	  SETVER.EXE has an undocumented option /G x.y which sets the "global"
	  DOS version returned by this function for all executables not given
	  a specific version number in SETVER to major version x and minor
	  version y.
	generic MS-DOS 3.30, Compaq MS-DOS 3.31, and others identify themselves
	  as PC-DOS by returning OEM number 00h
	the version returned under DOS 4.0x may be modified by entries in
	  the special program list (see #1348 at AH=52h); the version returned
	  under DOS 5+ may be modified by SETVER--use AX=3306h to get the true
	  version number
SeeAlso: AX=3000h/BX=3000h,AX=3306h,AX=4452h,AH=87h,INT 15/AX=4900h
SeeAlso: INT 2F/AX=122Fh,INT 2F/AX=4010h,INT 2F/AX=4A33h,INT 2F/AX=E002h

(Table 1082)
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
 EEh	DR DOS
 EFh	Novell DOS
 FDh	FreeDOS
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
SeeAlso: AX=0D20h,AH=30h/SI=1234h,AX=3000h"VIRUS",AX=30F1h
--------v-2130--SI1234---------------------
INT 21 - VIRUS - "ANDROMEDA-758" -INSTALLATION CHECK
	AH = 30h
	SI = 1234h
Return: AX = FFDDh if resident
SeeAlso: AH=30h/DX=ABCDh,AX=3000h"VIRUS"
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
SeeAlso: AH=30h,INT D4/AH=02h,INT D4/AH=10h
--------v-213000BX614A------------------
INT 21 - VIRUS - "Jackal" - INSTALLATION CHECK
	AX = 3000h
	BX = 614Ah ('aJ')
	CX = 6B63h ('kc')
	DX = 6C61h ('la')
Return: BX = ???
SeeAlso: AX=2C2Ch"VIRUS",AX=3030h"VIRUS"
--------G-213022-----------------------------
INT 21 - StopPrg v2.0 - INSTALLATION CHECK
	AX = 3022h
Return: AX = DOS version (see AH=30h)
	CX = 1112h if StopPrg installed
	    BX = segment of resident code
Program: StopPrg is a resident program aborter by MAK-TRAXON's Prophet
Note:	StopPrg may be temporarily disabled by storing 9090h in the word at
	  0000h:04FEh
--------v-213030BX694D-----------------------
INT 21 - VIRUS - "IMTC" -INSTALLATION CHECK
	AX = 3030h
	BX = 694Dh
Return: DX = 7443h if resident
SeeAlso: AX=3000h/BX=614Ah"VIRUS",AX=3032h"VIRUS"
--------v-213032DX1234-----------------------
INT 21 - VIRUS - "Uruguay" - INSTALLATION CHECK
	AX = 3032h
	DX = 1234h
Return: AX = 5678h if resident
SeeAlso: AX=3030h"VIRUS",AX=30F1h"VIRUS"
--------v-2130F1-----------------------------
INT 21 - VIRUS - "Dutch-555"/"Quit 1992" - INSTALLATION CHECK
	AX = 30F1h
Return: AL = 00h if resident
SeeAlso: AH=30h/DX=ABCDh,AX=3032h,AX=330Fh,AX=33DAh
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
	  before terminating (see #1066 at AH=26h,AH=49h)
	any open files remain open, so one should close any files which will
	  not be used before going resident; to access a file which is left
	  open from the TSR, one must switch PSP segments first (see AH=50h)
SeeAlso: AH=00h,AH=4Ch,AH=4Dh,INT 20,INT 22,INT 27
--------D-2132-------------------------------
INT 21 - DOS 2+ - GET DOS DRIVE PARAMETER BLOCK FOR SPECIFIC DRIVE
	AH = 32h
	DL = drive number (00h = default, 01h = A:, etc)
Return: AL = status
	    00h successful
		DS:BX -> Drive Parameter Block (DPB) (see #1083) for specified
			  drive
	    FFh invalid or network drive
Notes:	the OS/2 compatibility box supports the DOS 3.3 version of this call
	  except for the DWORD at offset 12h
	this call updates the DPB by reading the disk; the DPB may be accessed
	  via the DOS list of lists (see #1313 at AH=52h) if disk access is not
	  desirable.
	undocumented prior to the release of DOS 5.0; only the DOS 4.0+
	  version of the DPB has been documented, however
	supported by DR DOS 3.41+; DR DOS 3.41-6.0 return the same data as
	  MS-DOS 3.31
	IBM ROM-DOS v4.0 also reports invalid/network (AL=FFh) on the ROM drive
SeeAlso: AH=1Fh,AH=52h,AX=7302h

Format of DOS Drive Parameter Block:
Offset	Size	Description	(Table 1083)
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
 12h	DWORD	address of device driver header (see #1332)
 16h	BYTE	media ID byte (see #1044)
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
 13h	DWORD	address of device driver header (see #1332)
 17h	BYTE	media ID byte (see #1044)
 18h	BYTE	00h if disk accessed, FFh if not
 19h	DWORD	pointer to next DPB
 1Dh	WORD	cluster at which to start search for free space when writing,
		usually the last cluster allocated
 1Fh	WORD	number of free clusters on drive, FFFFh = unknown
SeeAlso: #1045,#1349,#1475 at AX=7302h,#3766 at INT E0/CL=71h
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
Note:	under DOS 3.1+ and DR DOS, this function does not use any of the
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
	not supported by DR DOS through version 6.0 (error code 01h);
	  newly-supported by Novell DOS 7
SeeAlso: AH=33h
--------D-213303-----------------------------
INT 21 - DOS 4.0+ - UNUSED
	AX = 3303h
Return: nothing
Note:	this function and AX=3304h were intended to support a proposed
	  code-page switching flag (using two of the ten reserved bytes in
	  the DOS directory entry for codepage information); however, this
	  function has always been a NOP in public releases of DOS and OS/2.
	  See _DOS_Internals_ Chapter 2 for more information
SeeAlso: AX=3304h
--------D-213304-----------------------------
INT 21 - DOS 4.0+ - UNUSED
	AX = 3304h
Return: nothing
Note:	this function and AX=3303h were intended to support a proposed
	  code-page switching flag (using two of the ten reserved bytes in
	  the DOS directory entry for codepage information); however, this
	  function has always been a NOP in public releases of DOS and OS/2.
	  See _DOS_Internals_ Chapter 2 for more information
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
	because of the conflict from the CBIS redirector (see next
	  entry), programs should check whether BH is less than 100 (64h)
	  and BL is at least 5 before accepting the returned BX as the true
	  version number; however, even this is not entirely reliable when
	  that redirector is loaded
	fully reentrant
	OS/2 v2.1 will return BX=0A14h (version 20.10)
	the Windows NT DOS box returns BX=3205h (version 5.50)
	Novell DOS 7 returns IBM v6.00, which some software displays as
	  IBM DOS v6.10 (because of the version mismatch in true IBM DOS
	  mentioned for INT 21/AH=30h); versions through Update 15 all
	  return revision code 00h
	Windows95 and Windows95 SP1 return version 7.00; Windows95 OSR2 returns
	  version 7.10
BUG:	DR DOS 5.0 and 6.0 return CF set/AX=0001h for INT 21/AH=33h
	  subfunctions other than 00h-02h and 05h, while MS-DOS returns AL=FFh
	  for invalid subfunctions
SeeAlso: AH=30h,INT 2F/AX=122Fh,INT 2F/AX=E000h"SETDRVER"
--------N-213306-----------------------------
INT 21 - CBIS network - NETWORK REDIRECTOR - ???
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
	  DR DOS 3.41+ (except COMPAQ DOS 3.0, where the critical error flag
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
Note:	under DR DOS 5.0+, this function does not use any of the DOS-internal
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
	this function does not return proper results on CD-ROMs;
	  use AX=4402h"CD-ROM" instead
	(FAT32 drive) the reported total and free space are limited to 2G-32K
	  should they exceed that value
SeeAlso: AH=1Bh,AH=1Ch,AX=4402h"CD-ROM",AX=7303h
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
BUG:	Novell DOS 7's COMMAND.COM (prior to Update 15) fails to honor the
	  SwitChar setting for internal commands even though COMMAND.COM
	  honors it in its own command tail (i.e. COMMAND /?); even in Update
	  15, internal commands fail to honor SwitChar for the /? help option
Notes:	documented in some OEM versions of some releases of DOS
	supported by OS/2 compatibility box
	always returns AL=00h/DL=2Fh for MS-DOS 5+ and DR DOS 3.41-6.0
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
Notes:	documented in some OEM versions of some releases of DOS; DOS 2.x had
	  a SWITCHAR=c setting in CONFIG.SYS
	supported by OS/2 compatibility box and Novell DOS 7
	ignored by MS-DOS 5+ and DR DOS 3.41-6.0; DR DOS 6.0 and Novell DOS 7
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
	  exist); DOS 2.x has an AVAILDEV= option in CONFIG.SYS to make \DEV
	  mandatory
	although MS-DOS 3.3+, DR DOS 3.41+, and Novell DOS 7 accept these
	  calls, they have no effect, and AL=02h always returns DL=FFh (except
	  for Novell DOS 7, which leaves AX unchanged for both subfunctions)
--------k-2137A0BX6A6D-----------------------
INT 21 - XPACK v1.52+ - TSR INSTALLATION CHECK
	AX = 37A0h
	BX = 6A6Dh ('jm')
Return: AL = FFh if not present as TSR (default return value from DOS)
	AX = 0000h if installed as a TSR
	    CX = 6A6Dh ('jm')
	    DX = version ID (0152h)
Program: XPACK is a transparent file compressor/decompressor by JauMing Tseng
SeeAlso: AX=37A1h/BX=6A6Dh,AX=37A3h/BX=6A6Dh
--------k-2137A1BX6A6D-----------------------
INT 21 - XPACK v1.52+ - UNINSTALL
	AX = 37A1h
	BX = 6A6Dh ('jm')
Return: AX = status
	    0000h successful
	    FFFFh failed
Program: XPACK is a transparent file compressor/decompressor by JauMing Tseng
SeeAlso: AX=37A0h/BX=6A6Dh
--------k-2137A2BX6A6D-----------------------
INT 21 - XPACK v1.52+ - GET TSR STATUS
	AX = 37A2h
	BX = 6A6Dh ('jm')
Return: AX = 0000h (successful)
	DL = status (01h active, 00h disabled)
SeeAlso: AX=37A3h/BX=6A6Dh
--------k-2137A3BX6A6D-----------------------
INT 21 - XPACK v1.52+ - SET TSR STATUS
	AX = 37A3h
	BX = 6A6Dh ('jm')
	DL = status (01h active, 00h disabled)
Return: AX = 0000h (successful)
SeeAlso: AX=37A0h/BX=6A6Dh,AX=37A2h/BX=6A6Dh
----------2137A6BX6A6D-----------------------
INT 21 - XPACK v1.65 - GET TEMPORARY DIRECTORY NAME
	AX = 37A6h
	BX = 6A6Dh ('jm')
Return: AX = 0000h
	DS:DX -> name of temporary directory
Program: XPACK is a transparent file compressor/decompressor by JauMing Tseng
SeeAlso: AX=37A0h/BX=6A6Dh,AX=37A7h/BX=6A6Dh
----------2137A7BX6A6D-----------------------
INT 21 - XPACK v1.65 - SET TEMPORARY DIRECTORY NAME
	AX = 37A7h
	BX = 6A6Dh ('jm')
	DS:DX -> ASCIZ name of temporary directory (max 64 chars)
Return: AX = 0000h
Note:	the specified directory name must include a drive letter and end with
	  a backslash (e.g. 'c:\dos\',0)
SeeAlso: AX=37A0h/BX=6A6Dh,AX=37A6h/BX=6A6Dh
--------k-2137D0BX899D-----------------------
INT 21 - DIET v1.43e - TSR INSTALLATION CHECK
	AX = 37D0h
	BX = 899Dh ('DI' + 'ET')
Return: AL = FFh if not present as TSR (default return value from DOS)
	AX = 0000h if installed as a TSR
	    CX = 899Dh
	    DX = version ID
Program: DIET is a transparent file compressor/decompressor by Teddy Matsumoto
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
	DX = TSR options (see #1084)
SeeAlso: AX=37D0h,AX=37D2h,AX=37D5h

Bitfields for DIET TSR options:
Bit(s)	Description	(Table 1084)
 0	automated compression of DIETed file
 1	automated compression of newly-created file
 2	suppress DIET message
 3	display original file size
 4-15	reserved (0)
--------k-2137D5BX899D-----------------------
INT 21 - DIET v1.43e - SET TSR OPTIONS
	AX = 37D5h
	BX = 899Dh ('DI' + 'ET')
	DX = TSR options (see #1084)
Return: AX = 0000h
Program: DIET is a transparent file compressor/decompressor by Teddy Matsumoto
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
	DS:DX -> external procedure (see #1085)
Return: AX = 0000h
Note:	the resident code will call the specified external procedure at the
	  beginning of decompression and when compression is exited on failure
SeeAlso: AX=37DDh

(Table 1085)
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
Program: DIET is a transparent file compressor/decompressor by Teddy Matsumoto
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
INT 21 - DIET v1.43e - UNINSTALL TSR
	AX = 37DFh
	BX = 899Dh ('DI' + 'ET')
Return: AX = status
	    0000h successful
	    00FFh failed
Program: DIET is a transparent file compressor/decompressor by Teddy Matsumoto
SeeAlso: AX=37D0h
Index:	uninstall;DIET
--------D-2138-------------------------------
INT 21 - DOS 2+ - GET COUNTRY-SPECIFIC INFORMATION
	AH = 38h
--DOS 2.x--
	AL = 00h get current-country info
	DS:DX -> buffer for returned info (see #1086,#1087)
Return: CF set on error
	    AX = error code (02h)
	CF clear if successful
	    AX = country code (MS-DOS 2.11 only)
	    buffer at DS:DX filled
--DOS 3.0+--
	AL = 00h for current country
	AL = 01h thru 0FEh for specific country with code <255 (see #1088)
	AL = 0FFh for specific country with code >= 255
	   BX = 16-bit country code (see #1088)
	DS:DX -> buffer for returned info (see #1087)
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
Offset	Size	Description	(Table 1086)
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
Offset	Size	Description	(Table 1087)
 00h	WORD	date format (see #1086)
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

(Table 1088)
Values for country code:
 001h (1)	United States
 002h (2)	Canadian-French
 003h (3)	Latin America
 004h (4)	Canada (English)
 007h (7)	Russia
 014h (20)	Egypt
 01Bh (27)	South Africa
 01Eh (30)	Greece
 01Fh (31)	Netherlands
 020h (32)	Belgium
 021h (33)	France
 022h (34)	Spain
 023h (35)	Bulgaria???
 024h (36)	Hungary (not supported by DR DOS 5.0)
 026h (38)	Yugoslavia (not supported by DR DOS 5.0) -- obsolete
 027h (39)	Italy / San Marino / Vatican City
 028h (40)	Romania
 029h (41)	Switzerland / Liechtenstein
 02Ah (42)	Czechoslovakia / Tjekia / Slovakia (not supported by DR DOS 5.0)
 02Bh (43)	Austria (DR DOS 5.0)
 02Ch (44)	United Kingdom
 02Dh (45)	Denmark
 02Eh (46)	Sweden
 02Fh (47)	Norway
 030h (48)	Poland (not supported by DR DOS 5.0)
 031h (49)	Germany
 033h (51)	Peru
 034h (52)	Mexico
 035h (53)	Cuba
 036h (54)	Argentina
 037h (55)	Brazil (not supported by DR DOS 5.0)
 038h (56)	Chile
 039h (57)	Columbia
 03Ah (58)	Venezuela
 03Ch (60)	Malaysia
 03Dh (61)	International English / Australia
 03Eh (62)	Indonesia / East Timor
 03Fh (63)	Philippines
 040h (64)	New Zealand
 041h (65)	Singapore
 042h (66)	Taiwan???
 051h (81)	Japan (DR DOS 5.0, MS-DOS 5.0+)
 052h (82)	South Korea (DR DOS 5.0)
 054h (84)	Vietnam
 056h (86)	China (MS-DOS 5.0+)
 058h (88)	Taiwan (MS-DOS 5.0+)
 05Ah (90)	Turkey (MS-DOS 5.0+)
 05Bh (91)	India
 05Ch (92)	Pakistan
 05Dh (93)	Afghanistan
 05Eh (94)	Sri Lanka
 062h (98)	Iran
 063h (99)	Asia (English)
 070h (112)	Belarus
 0C8h (200)	Thailand
 0D4h (212)	Morocco
 0D5h (213)	Algeria
 0D8h (216)	Tunisia
 0DAh (218)	Libya
 0DCh (220)	Gambia
 0DDh (221)	Senegal
 0DEh (222)	Maruitania
 0DFh (223)	Mali
 0E0h (224)	African Guinea
 0E1h (225)	Ivory Coast
 0E2h (226)	Burkina Faso
 0E3h (227)	Niger
 0E4h (228)	Togo
 0E5h (229)	Benin
 0E6h (230)	Mauritius
 0E7h (231)	Liberia
 0E8h (232)	Sierra Leone
 0E9h (233)	Ghana
 0EAh (234)	Nigeria
 0EBh (235)	Chad
 0ECh (236)	Centra African Republic
 0EDh (237)	Cameroon
 0EEh (238)	Cape Verde Islands
 0EFh (239)	Sao Tome and Principe
 0F0h (240)	Equatorial Guinea
 0F1h (241)	Gabon
 0F2h (242)	Congo
 0F3h (243)	Zaire
 0F4h (244)	Angola
 0F5h (245)	Guinea-Bissau
 0F6h (246)	Diego Garcia
 0F7h (247)	Ascension Isle
 0F8h (248)	Seychelles
 0F9h (249)	Sudan
 0FAh (250)	Rwhanda
 0FBh (251)	Ethiopia
 0FCh (252)	Somalia
 0FDh (253)	Djibouti
 0FEh (254)	Kenya
 0FFh (255)	Tanzania
 100h (256)	Uganda
 101h (257)	Burundi
 103h (259)	Mozambique
 104h (260)	Zambia
 105h (261)	Madagascar
 106h (262)	Reunion Island
 107h (263)	Zimbabwe
 108h (264)	Namibia
 109h (265)	Malawi
 10Ah (266)	Lesotho
 10Bh (267)	Botswana
 10Ch (268)	Swaziland
 10Dh (269)	Comoros
 10Eh (270)	Mayotte
 122h (290)	St. Helena
 129h (297)	Aruba
 12Ah (298)	Faroe Islands
 12Bh (299)	Greenland
 15Eh (350)	Gibraltar
 15Fh (351)	Portugal
 160h (352)	Luxembourg
 161h (353)	Ireland
 162h (354)	Iceland
 163h (355)	Albania
 164h (356)	Malta
 165h (357)	Cyprus
 166h (358)	Finland
 167h (359)	Bulgaria
 172h (370)	Lithuania
 173h (371)	Latvia
 174h (372)	Estonia
 175h (373)	Moldova
 17Dh (381)	Serbia / Montenegro
 180h (384)	Croatia???
 181h (385)	Croatia
 182h (386)	Slovenia
 183h (387)	Bosnia-Herzegovina (Latin)
 184h (388)	Bosnia-Herzegovina (Cyrillic)
 185h (389)	FYR Macedonia
 1A5h (421)	Czech Republic
 1A6h (422)	Slovakia
 1F4h (500)	Falkland Islands
 1F5h (501)	Belize
 1F6h (502)	Guatemala
 1F7h (503)	El Salvador
 1F8h (504)	Honduras
 1F9h (505)	Nicraragua
 1FAh (506)	Costa Rica
 1FBh (507)	Panama
 1FCh (508)	St. Pierre and Miquelon
 1FDh (509)	Haiti
 24Eh (590)	Guadeloupe
 24Fh (591)	Bolivia
 250h (592)	Guyana
 251h (593)	Ecuador
 252h (594)	rench Guiana
 253h (595)	Paraguay
 254h (596)	Martinique / French Antilles
 255h (597)	Suriname
 256h (598)	Uruguay
 257h (599)	Netherland Antilles
 29Eh (670)	Saipan / N. Mariana Island
 29Fh (671)	Guam
 2A0h (672)	Norfolk Island (Australia) / Christmas Island/Cocos Islands / Antartica
 2A1h (673)	Brunei Darussalam
 2A2h (674)	Nauru
 2A3h (675)	Papua New Guinea
 2A4h (676)	Tonga Islands
 2A5h (677)	Solomon Islands
 2A6h (678)	Vanuatu
 2A7h (679)	Fiji
 2A8h (680)	Palau
 2A9h (681)	Wallis & Futuna
 2AAh (682)	Cook Islands
 2ABh (683)	Niue
 2ACh (684)	American Samoa
 2ADh (685)	Western Samoa
 2AEh (686)	Kiribati
 2AFh (687)	New Caledonia
 2B0h (688)	Tuvalu
 2B1h (689)	French Polynesia
 2B2h (690)	Tokealu
 2B3h (691)	Micronesia
 2B4h (692)	Marshall Islands
 2C7h (711)	??? (currency = EA$)
 311h (785)	Arabic (Middle East/Saudi Arabia/etc.)
 324h (804)	Ukraine
 329h (809)	Antigua and Barbuda / Anguilla / Bahamas / Barbados / Bermuda
		British Virgin Islands / Cayman Islands / Dominica
		Dominican Republic / Grenada / Jamaica / Montserra
		St. Kitts and Nevis / St. Lucia / St. Vincent and Grenadines
		Trinidad and Tobago / Turks and Caicos
 352h (850)	North Korea
 354h (852)	Hong Kong
 355h (853)	Macao
 357h (855)	Cambodia
 358h (856)	Laos
 370h (880)	Bangladesh
 376h (886)	Taiwan (DOS 6.22+)
 3C0h (960)	Maldives
 3C1h (961)	Lebanon
 3C2h (962)	Jordan
 3C3h (963)	Syrian Arab Republic
 3C4h (964)	Ireq
 3C5h (965)	Kuwait
 3C6h (966)	Saudi Arabia
 3C7h (967)	Yemen
 3C8h (968)	Oman
 3CBh (971)	United Arab Emirates
 3CCh (972)	Israel (Hebrew) (DR DOS 5.0,MS-DOS 5.0+)
 3CDh (973)	Bahrain
 3CEh (974)	Qatar
 3CFh (975)	Bhutan
 3D0h (976)	Mongolia
 3D1h (977)	Nepal
 3E3h (995)	Myanmar (Burma)
Note:	not all country codes are supported by all versions of DOS
--------D-2138--DXFFFF-----------------------
INT 21 - DOS 3.0+ - SET COUNTRY CODE
	AH = 38h
	DX = FFFFh
	AL = 01h thru FEh for specific country with code <255
	AL = FFh for specific country with code >= 255
	   BX = 16-bit country code (see #1088)
Return: CF set on error
	    AX = error code (see #1366 at AH=59h/BX=0000h)
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
	    AX = error code (03h,05h) (see #1366 at AH=59h/BX=0000h)
Notes:	all directories in the given path except the last must exist
	fails if the parent directory is the root and is full
	DOS 2.x-3.3 allow the creation of a directory sufficiently deep that
	  it is not possible to make that directory the current directory
	  because the path would exceed 64 characters
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
SeeAlso: AH=3Ah,AH=3Bh,AH=6Dh,AX=7139h,AH=E2h/SF=0Ah,INT 2F/AX=1103h
SeeAlso: INT 60/DI=0511h
--------D-213A-------------------------------
INT 21 - DOS 2+ - "RMDIR" - REMOVE SUBDIRECTORY
	AH = 3Ah
	DS:DX -> ASCIZ pathname of directory to be removed
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (03h,05h,06h,10h) (see #1366 at AH=59h/BX=0000h)
Notes:	directory must be empty (contain only '.' and '..' entries)
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
SeeAlso: AH=39h,AH=3Bh,AX=713Ah,AH=E2h/SF=0Bh,INT 2F/AX=1101h,INT 60/DI=0512h
--------D-213B-------------------------------
INT 21 - DOS 2+ - "CHDIR" - SET CURRENT DIRECTORY
	AH = 3Bh
	DS:DX -> ASCIZ pathname to become current directory (max 64 bytes)
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (03h) (see #1366 at AH=59h/BX=0000h)
Notes:	if new directory name includes a drive letter, the default drive is
	  not changed, only the current directory on that drive
	changing the current directory also changes the directory in which
	  FCB file calls operate
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
SeeAlso: AH=47h,AX=713Bh,INT 2F/AX=1105h
--------D-213C-------------------------------
INT 21 - DOS 2+ - "CREAT" - CREATE OR TRUNCATE FILE
	AH = 3Ch
	CX = file attributes (see #1089)
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    AX = file handle
	CF set on error
	    AX = error code (03h,04h,05h) (see #1366 at AH=59h/BX=0000h)
Notes:	if a file with the given name exists, it is truncated to zero length
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
	DR DOS checks the system password or explicitly supplied password at
	  the end of the filename against the reserved field in the directory
	  entry before allowing access
SeeAlso: AH=16h,AH=3Dh,AH=5Ah,AH=5Bh,AH=93h,INT 2F/AX=1117h

Bitfields for file attributes:
Bit(s)	Description	(Table 1089)
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
	AL = access and sharing modes (see #1090)
	DS:DX -> ASCIZ filename
	CL = attribute mask of files to look for (server call only)
Return: CF clear if successful
	    AX = file handle
	CF set on error
	    AX = error code (01h,02h,03h,04h,05h,0Ch,56h) (see #1366 at AH=59h)
Notes:	file pointer is set to start of file
	if SHARE or a network is loaded, the file open may fail if the file
	  is already open, depending on the combination of sharing modes
	  (see #1091,#3760)
	file handles which are inherited from a parent also inherit sharing
	  and access restrictions
	files may be opened even if given the hidden or system attributes
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
	DR DOS checks the system password or explicitly supplied password at
	  the end of the filename (following a semicolon) against the reserved
	  field in the directory entry before allowing access
	sharing modes are only effective on local drives if SHARE is loaded
BUG:	Novell DOS 7 SHARE v1.00 would refuse file access in the cases in
	  #1091 marked with [1] (read-only open of a read-only file
	  which had previously been opened in compatibility mode); this was
	  fixed in SHARE v1.01 of 09/29/94
SeeAlso: AH=0Fh,AH=3Ch,AX=4301h,AX=5D00h,INT 2F/AX=1116h,INT 2F/AX=1226h

Bitfields for access and sharing modes:
Bit(s)	Description	(Table 1090)
 2-0	access mode
	000 read only
	001 write only
	010 read/write
	011 (DOS 5+ internal) passed to redirector on EXEC to allow
		case-sensitive filenames
 3	reserved (0)
 6-4	sharing mode (DOS 3.0+) (see #1091)
	000 compatibility mode
	001 "DENYALL" prohibit both read and write access by others
	010 "DENYWRITE" prohibit write access by others
	011 "DENYREAD" prohibit read access by others
	100 "DENYNONE" allow full access by others
	111 network FCB (only available during server call)
 7	inheritance
	if set, file is private to current process and will not be inherited
	  by child processes
SeeAlso: #1471,#1091

(Table 1091)
Values of DOS 2-6.22 file sharing behavior:
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
SeeAlso: #1322,#3760

(Table 3760)
Values for DOS 7.x file sharing behavior:
	  |	Second and subsequent Opens
 First	  |Compat    Deny      Deny	 Deny	   Deny
 Open	  |	     All       Write	 Read	   None
	  |R W RW A  R W RW A  R W RW A	 R W RW A  R W RW A
 - - - - -| - - - - - - - - - - - - - - - - - - - - - - - -
 Compat R |Y Y Y Y   N N N N   Y N N Y	 N N N Y   Y N N Y
	W |Y Y Y C   N N N N   N N N N	 N N N Y   Y N N Y  
	RW|Y Y Y C   N N N N   N N N N	 N N N Y   Y N N Y  
	NA|Y C C Y   N N N N   Y N N Y	 N N N Y   Y N N Y
 - - - - -|	
 Deny	R |C C C C   N N N N   N N N N	 N N N N   N N N N
 All	W |C C C C   N N N N   N N N N	 N N N N   N N N N
	RW|C C C C   N N N N   N N N N	 N N N N   N N N N  
	NA|C C C C   N N N N   N N N N	 N N N N   N N N N  
 - - - - -|	
 Deny	R |Y C C Y   N N N N   Y N N Y	 N N N Y   Y N N Y
 Write	W |C C C C   N N N N   N N N N	 Y N N Y   Y N N Y
	RW|C C C C   N N N N   N N N N	 N N N Y   Y N N Y  
	NA|Y C C Y   N N N N   Y N N Y	 N N N Y   Y N N Y  
 - - - - -|	
 Deny	R |C C C C   N N N N   N Y N N	 N N N N   N Y N N
 Read	W |C C C C   N N N N   N N N N	 N Y N N   N Y N N
	RW|C C C C   N N N N   N N N N	 N N N N   N Y N N  
	NA|Y Y Y Y   N N N N   Y Y Y Y	 N N N Y   Y Y Y Y  
 - - - - -|	
 Deny	R |Y Y Y Y   N N N N   Y Y Y Y	 N N N Y   Y Y Y Y
 None	W |C C C C   N N N N   N N N N	 Y Y Y Y   Y Y Y Y
	RW|C C C C   N N N N   N N N N	 N N N Y   Y Y Y Y  
	NA|Y Y Y Y   N N N N   Y Y Y Y	 N N N Y   Y Y Y Y
Legend: R -> reading, W -> writing, RW -> both reading & writing,
	A/NA -> reading without access time update
	Y = open succeeds, N = open fails with error code 05h
	C = open fails, INT 24 generated
SeeAlso: #1091,#1322
--------v-213D76-----------------------------
INT 21 - VIRUS - "GT-SPOOF" -INSTALLATION CHECK
	AX = 3D76h
Return: AX = 763Dh if resident
SeeAlso: AX=357Fh,AX=3DFFh
--------v-213DFF-----------------------------
INT 21 - VIRUS - "JD-448" - INSTALLATION CHECK
	AX = 3DFFh
Return: AX = 4A44h if resident
SeeAlso: AX=3D76h,AX=4203h
--------D-213E-------------------------------
INT 21 - DOS 2+ - "CLOSE" - CLOSE FILE
	AH = 3Eh
	BX = file handle
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (06h) (see #1366 at AH=59h/BX=0000h)
Notes:	if the file was written to, any pending disk writes are performed, the
	  time and date stamps are set to the current time, and the directory
	  entry is updated
	recent versions of DOS preserve AH because some versions of Multiplan
	  had a bug which depended on AH being preserved
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
	    AX = error code (05h,06h) (see #1366 at AH=59h/BX=0000h)
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
	DS:DX -> buffer for status block (see #1093)
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (05h,06h) (see #1366 at AH=59h/BX=0000h)
SeeAlso: AH=40h"Turbo Debug"

(Table 1092)
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
Offset	Size	Description	(Table 1093)
 00h	BYTE	status of command (see #1092)
---status for command 01h---
 01h	WORD	device driver interface version number (currently 1)
 03h	WORD	device driver software version
 05h	BYTE	maximum simultaneous hardware breakpoints
 06h	BYTE	configuration bits (see #1094)
 07h	BYTE	supported breakpoint types (see #1095)
 08h	WORD	supported addressing match modes (see #1096)
 0Ah	WORD	supported data matches (see #1097)
 0Ch	BYTE	maximum data match length (01h, 02h, or 04h)
 0Dh	WORD	size of onboard memory (in KB)
 0Fh	WORD	maximum number of trace-back events
 11h	WORD	hardware breakpoint enable byte address segment (0000h if not
		  supported)
---status for command 04h---
 01h	BYTE	handle to use when referring to the just-set breakpoint

Bitfields for Turbo Debugger configuration bits:
Bit(s)	Description	(Table 1094)
 0	CPU and DMA accesses are distinct
 1	can detect DMA transfers
 2	supports data mask
 3	hardware pass counter on breakpoints
 4	can match on data as well as addresses

Bitfields for Turbo Debugger supported breakpoint types:
Bit(s)	Description	(Table 1095)
 0	memory read
 1	memory write
 2	memory read/write
 3	I/O read
 4	I/O write
 5	I/O read/write
 6	instruction fetch

Bitfields for Turbo Debugger supported addressing match modes:
Bit(s)	Description	(Table 1096)
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
Bit(s)	Description	(Table 1097)
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
	DS:DX -> buffer for configuration data (see #1098)
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (05h,06h) (see #1366 at AH=59h/BX=0000h)
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
Offset	Size	Description	(Table 1098)
 00h 12 BYTEs	IPCUST.SYS device driver header (see #1332)
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
	DS:DX -> buffer for entry point record (see #1172)
Return: CF clear if successful
	    AX = number of bytes actually read (0 if at EOF before call)
	CF set on error
	    AX = error code (05h,06h) (see #1366 at AH=59h/BX=0000h)
Program: WORKGRP.SYS is the portion of Microsoft's Workgroup Connection which
	  permits communication with PCs running Windows for Workgroups or
	  LAN Manager
SeeAlso: AX=4402h"WORKGRP.SYS",INT 2F/AX=9400h
--------N-213F-------------------------------
INT 21 - BW-TCP - GET DRIVER INFO
	AH = 3Fh
	BX = file handle for device "ETHDEV27"
	CX = 002Bh
	DS:DX -> buffer for driver info (see #1099)
Return: CF clear if successful
	    AX = number of bytes actually read (0 if at EOF before call)
	CF set on error
	    AX = error code (05h,06h) (see #1366 at AH=59h/BX=0000h)
Program: BW-TCP is a TCP/IP protocol stack by Beame & Whiteside Software
Notes:	the B&W socket library performs an INT 21/AX=4401h with DX=0060h before
	  making this call to retrieve the driver information; one should also
	  call the private API interrupt with AH=15h
	the installation check for the TCP/IP stack is to test for the
	  existence of the character device UDP-IP10
SeeAlso: INT 14/AH=56h,INT 62/AH=00h"ETHDEV",INT 63/AH=03h,INT 64/AH=01h
Index:	installation check;BW-TCP hardware driver
Index:	installation check;BW-TCP TCPIP.SYS

Format of BW-TCP driver info:
Offset	Size	Description	(Table 1099)
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
 15h	WORD	offset in device driver of log server records (see #1100)
 17h	WORD	offset in device driver of name server records (see #1100)
 19h	WORD	offset in device driver of print server records (see #1100)
 1Bh	WORD	offset in device driver of time server records (see #1100)
 1Dh	WORD	offset in device driver of gateway records (see #1100)
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
Offset	Size	Description	(Table 1100)
 00h	BYTE	number of server records following
 01h  N DWORDs	internet addresses of servers
--------y-213F-------------------------------
INT 21 - Trusted Access - NB.SYS - GET STATE
	AH = 3Fh
	BX = file handle for device "$$NB$$NB"
	CX = 0002h (size of state)
	DS:DX -> buffer for state record (see #1101)
Return: CF clear if successful
	    AX = number of bytes actually read (0 if at EOF before call)
	CF set on error
	    AX = error code (05h,06h) (see #1366 at AH=59h/BX=0000h)
Program: Trusted Access is a security and access-control package by Lassen
	  Software, Inc.; NB.SYS is a device driver to prevent the user from
	  terminating CONFIG.SYS or AUTOEXEC.BAT with Ctrl-Break
SeeAlso: AH=40h"NB.SYS",AX=4101h

Format of Trusted Access state record:
Offset	Size	Description	(Table 1101)
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
	DS:DX -> buffer for entry point record (see #1102)
Return: CF clear if successful
	    AX = number of bytes actually read (0 if at EOF before call)
	CF set on error
	    AX = error code (05h,06h) (see #1366 at AH=59h/BX=0000h)
Program: IFSHLP.SYS is a support driver for Microsoft Windows for Workgroups
SeeAlso: AX=4402h"IFSHLP"

Format of IFSHLP.SYS entry point record:
Offset	Size	Description	(Table 1102)
 00h  4 BYTEs	(call) required signature if called via IOCTL
			70h E9h 34h 37h for Windows 3.11
			70h E9h 35h 37h for Windows 3.11
		(ret) signature 34h 37h 70h EFh (Windows 3.11)
		(ret) signature 35h 37h 70h EFh (Windows95)
 04h	DWORD	(ret) pointer to FAR call entry point (see #1103)

(Table 1103)
Call IFSHLP.SYS entry point with:
	STACK:	WORD	function number (00h-0Ch)
			00h get ??? data
			01h set interrupt intercepts (trap)
			02h remove interrupt intercepts (untrap)
			03h ??? LPT2
			04h ??? LPT1
			05h revector INT 2F to trap and remove trap for others
			06h set ??? flag
			07h clear ??? flag
			08h get ??? flag word
			---Windows 3.11 only---
			09h ???
			0Ah ???
			0Bh ???
			0Ch get ???
---if function 00h---
Return: DX:AX -> ??? data (see #1104)
	BX destroyed
---if function 01h---
	STACK:	DWORD	new intercept (trap) address
Return: AX = status
	    0000h successful
	    0001h failed (already set)
		DX = 0000h
	BX destroyed
Note:	the trap handler is called with a function number in BX, and the
	  original BX on top of the stack; a null handler must perform a
	  POP BX and an IRET
---if function 02h---
Return: AX = status
	    0000h successful
	    0001h failed (not set)
	DX = 0000h
	BX destroyed
---if function 03h,04h---
	STACK:	WORD	???
Return: AX = 0000h
	DX = 0000h
	BX destroyed
---if function 05h---
	???
Return:	BX destroyed
---if function 06h---
Return: AX = 0001h and DX = 0000h if already set
	AX,DX unchanged if successful
	BX destroyed
---if function 07h---
Return: AX = 0001h and DX = 0000h if not set
	AX,DX unchanged if successful
	BX destroyed
---if function 08h---
Return: DX = 0000h
	AX = flags
	    bit 0: set/cleared by functions 06h and 07h
	    bit 1: trap is currently set (refer to functions 01h/02h)
	BX destroyed
---if function 09h---
Return: AX = status
	    0000h successful
	    0001h failed (already called)
	BX destroyed
---if function 0Ah---
	STACK:	WORD	???
	???
Return:	BX destroyed
---if function 0Bh---
Return: AX = status
	    0000h successful
	    0001h failed (not set)
	BX destroyed
---if function 0Ch---
Return: AX = 0000h
	ES:BX -> ??? data
---if function > 0Ch---
Return: AX = 0001h
	DX = 0000h
	BX destroyed

Format of IFSHLP ??? data:
Offset	Size	Description	(Table 1104)
 00h	DWORD	-> DOS Swappable Data Area (see #1373,#1375)
 02h	WORD	??? offset in DOS data segment?
 04h	WORD	offset in DOS data segment of current-PSP WORD
 06h	WORD	???
 08h	WORD	???
 0Ah	WORD	???
 0Ch	DWORD	-> DOS List of Lists (see #1313)
 10h	???
SeeAlso: #1103
--------v-213F--BXFEB0-----------------------
INT 21 - VIRUS - "KYZ/LieWait" - INSTALLATION CHECK
	AH = 3Fh
	BX = FEB0h
Return: BX = 1212h if resident
SeeAlso: AX=3032h"VIRUS",AX=4BF1h"VIRUS"
--------D-2140-------------------------------
INT 21 - DOS 2+ - "WRITE" - WRITE TO FILE OR DEVICE
	AH = 40h
	BX = file handle
	CX = number of bytes to write
	DS:DX -> data to write
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (05h,06h) (see #1366 at AH=59h/BX=0000h)
Notes:	if CX is zero, no data is written, and the file is truncated or
	  extended to the current position
	data is written beginning at the current file position, and the file
	  position is updated after a successful write
	for FAT32 drives, the file must have been opened with AX=6C00h with
	  the "extended size" flag in order to expand the file beyond 2GB;
	  otherwise the write will fail with error code 0005h (access denied)
	the usual cause for AX < CX on return is a full disk
BUG:	a write of zero bytes will appear to succeed when it actually failed
	  if the write is extending the file and there is not enough disk
	  space for the expanded file (DOS 5.0-6.0); one should therefore check
	  whether the file was in fact extended by seeking to 0 bytes from
	  the end of the file (INT 21/AX=4202h/CX=0000h/DX=0000h)
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
SeeAlso: AH=28h,AH=3Fh"DOS",AH=93h,INT 2F/AX=1109h
--------G-2140-------------------------------
INT 21 - Turbo Debug HARDWARE BREAKPOINTS - SEND CMD TO HARDWARE BRKPNT DRIVER
	AH = 40h
	BX = handle for character device "TDHDEBUG"
	CX = number of bytes to write
	DS:DX -> hardware breakpoint command (see #1105)
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (05h,06h) (see #1366 at AH=59h/BX=0000h)
Note:	results are retrieved by reading from the device
SeeAlso: AH=3Fh"Turbo Debug"

Format of Turbo Debugger hardware breakpoint commands:
Offset	Size	Description	(Table 1105)
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
 02h	BYTE	address matching mode (see #1106)
 03h	DWORD	32-bit linear low address
 07h	DWORD	32-bit linear high address
 0Bh	WORD	pass count
 0Dh	BYTE	data size (01h, 02h, or 04h)
 0Eh	BYTE	source of matched bus cycle (01h CPU, 02h DMA, 03h either)
 0Fh	BYTE	data-matching mode (see #1106)
 10h	DWORD	low data value
 14h	DWORD	high data value
 18h	DWORD	data mask specifying which bits of the data are tested
---command code 05h---
 01h	BYTE	handle of breakpoint to clear (breakpoint returned from command
		  04h)
---command code 06h---
 01h	WORD	base address of hardware debugger board

(Table 1106)
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
	    AX = error code (05h,06h) (see #1366 at AH=59h/BX=0000h)
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
	DS:DX -> state record (see #1101)
	CX ignored
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (05h,06h) (see #1366 at AH=59h/BX=0000h)
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
	    AX = error code (02h,03h,05h) (see #1366 at AH=59h/BX=0000h)
Notes:	(DOS 3.1+) wildcards are allowed if invoked via AX=5D00h, in which case
	  the filespec must be canonical (as returned by AH=60h), and only
	  files matching the attribute mask in CL are deleted
	DR DOS 5.0-6.0 returns error code 03h if invoked via AX=5D00h; DR DOS
	  3.41 crashes if called via AX=5D00h with wildcards
	DOS does not erase the file's data; it merely becomes inaccessible
	  because the FAT chain for the file is cleared
	deleting a file which is currently open may lead to filesystem
	  corruption.  Unless SHARE is loaded, DOS does not close the handles
	  referencing the deleted file, thus allowing writes to a nonexistant
	  file.
	under DR DOS and DR Multiuser DOS, this function will fail if the file
	  is currently open
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
BUG:	DR DOS 3.41 crashes if called via AX=5D00h
SeeAlso: AH=13h,AX=4301h,AX=4380h,AX=5D00h,AH=60h,AX=7141h,AX=F244h
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
	CX:DX = (signed) offset from origin of new file position
Return: CF clear if successful
	    DX:AX = new file position in bytes from start of file
	CF set on error
	    AX = error code (01h,06h) (see #1366 at AH=59h/BX=0000h)
Notes:	for origins 01h and 02h, the pointer may be positioned before the
	  start of the file; no error is returned in that case, but subsequent
	  attempts at I/O will produce errors
	if the new position is beyond the current end of file, the file will
	  be extended by the next write (see AH=40h); for FAT32 drives, the
	  file must have been opened with AX=6C00h with the "extended size"
	  flag in order to expand the file beyond 2GB
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
SeeAlso: AX=4203h,AX=44A0h,AX=4B04h
--------D-214300-----------------------------
INT 21 - DOS 2+ - GET FILE ATTRIBUTES
	AX = 4300h
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    CX = file attributes (see #1107)
	    AX = CX (DR DOS 5.0)
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see #1366 at AH=59h)
Notes:	under the FlashTek X-32 DOS extender, the filename pointer is in DS:EDX
	under DR DOS 3.41 and 5.0, attempts to change the subdirectory bit are
	  simply ignored without an error
BUG:	Windows for Workgroups returns error code 05h (access denied) instead
	  of error code 02h (file not found) when attempting to get the
	  attributes of a nonexistent file.  This causes open() with O_CREAT
	  and fopen() with the "w" mode to fail in Borland C++.
SeeAlso: AX=4301h,AX=4310h,AX=7143h,AH=B6h,INT 2F/AX=110Fh,INT 60/DI=0517h
--------D-214301-----------------------------
INT 21 - DOS 2+ - "CHMOD" - SET FILE ATTRIBUTES
	AX = 4301h
	CX = new file attributes (see #1107)
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see #1366 at AH=59h)
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
	DR DOS 3.41/5.0 will silently ignore attempts to change the 'directory'
	  attribute bit
SeeAlso: AX=4300h,AX=4311h,AX=7143h,INT 2F/AX=110Eh

Bitfields for file attributes:
Bit(s)	Description	(Table 1107)
 7	shareable (Novell NetWare)
 7	pending deleted files (Novell DOS, OpenDOS)
 6	unused
 5	archive
 4	directory
 3	volume label
	execute-only (Novell NetWare)
 2	system
 1	hidden
 0	read-only
--------D-214302-----------------------------
INT 21 - MS-DOS 7 - GET COMPRESSED FILE SIZE
	AX = 4302h
	DS:DX -> ASCIZ pathname for file or directory
Return: CF clear if successful
	    ??? = compressed size of file/directory in bytes
	CF set on error
	    AX = error code
Note:	on volumes which do not support compression, the returned size is the
	  actual file size rounded up to the next cluster boundary
SeeAlso: AH=71h,AH=72h
--------O-214302-----------------------------
INT 21 - DR DOS 3.41+ internal - GET ACCESS RIGHTS
	AX = 4302h
	DS:DX -> ASCIZ pathname
Return: CF clear if successful
	    CX = access rights (see #1108)
	    AX = CX (DR DOS 5.0)
	CF set on error
	    AX = error code
Desc:	Determine which operations the calling program may perform on a
	  specified file without being required to provide a password.
Notes:	this protection scheme has been coordinated on all current Digital
	  Research/Novell operating systems (DR DOS 3.41+, DRMDOS 5.x, and
	  FlexOS 2+)
	this function is documented in DR DOS 6.0 and corresponds to the
	  "Get/Set File Attributes" function, subfunction 2, documented in
	  Concurrent DOS.
	only FlexOS actually uses the "execution" bits; DR DOS 3.41+ treats
	  them as "read" bits.
	DR DOS 3.41-5.x only use bits 0-3.  Only DR DOS 6.0 using a
	  DRMDOS 5.x security system allowing for users and groups uses bits
	  4-11.
SeeAlso: AX=4303h,#3763 at INT 21/AH=11h

Bitfields for DR DOS file access rights:
Bit(s)	Description	(Table 1108)
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
INT 21 - DR DOS 3.41+ internal - SET ACCESS RIGHTS AND PASSWORD
	AX = 4303h
	CX = access rights
	     bits 11-0: access rights (see #1108)
	     bit 15: new password is to be set
	DS:DX -> ASCIZ pathname
	[DTA] = new password if CX bit 15 is set (blank-padded to 8 characters)
Return: CF clear if successful
	CF set on error
	    AX = error code
Notes:	if the file is already protected, the old password must be added after
	  the pathname, separated by a ";".  As with all password handling in
	  DR DOS, the old password is processed by the kernel, not any
	  applications or utilities making the call.
	this function is documented in DR DOS 6.0 and corresponds to the
	  "Get/Set File Attributes" function, subfunction 3, documented in
	  Concurrent DOS.
SeeAlso: AH=0Fh,AH=17h,AX=4302h"DR DOS",AX=4305h,AX=4454h
--------O-214304-----------------------------
INT 21 U - DR DOS 5.0-6.0 internal - GET ENCRYPTED PASSWORD
	AX = 4304h
	DS:DX -> ASCIZ filename
	???
Return: CF clear if successful
	    CX = AX = 0000h if no password assigned to file
	CF set on error
	    AX = error code (see #1366 at AH=59h/BX=0000h)
Note:	this function is only supported by DR DOS 5.0 and 6.0 and DRMDOS 5.1
SeeAlso: AX=4303h,AX=4305h
--------O-214305-----------------------------
INT 21 U - DR DOS 5.0-6.0 internal - SET EXTENDED FILE ATTRIBUTES
	AX = 4305h
	DS:DX -> ASCIZ filename
	???
Return: CF clear if successful
	CF set on error
	    AX = error code (see #1366 at AH=59h/BX=0000h)
Desc:	this function allows the extended attributes, and optionally the
	  encrypted password, of a file to be set.
Note:	this function is only supported by DR DOS 5.0 and 6.0 and DRMDOS 5.1
SeeAlso: AX=4304h,AX=4311h
--------O-214306-----------------------------
INT 21 O - DR DOS 6.0 - GET FILE OWNER
	AX = 4306h
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    AX = CX = value set with AX=4307h
	CF set on error
	    AX = error code (see #1366 at AH=59h/BX=0000h)
Note:	no longer supported by Novell DOS 7 / OpenDOS
SeeAlso: AX=4307h
--------O-214307-----------------------------
INT 21 O - DR DOS 6.0 - SET FILE OWNER
	AX = 4307h
	CX = ??? (owner identification number?)
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	CF set on error
	    AX = error code (see #1366 at AH=59h/BX=0000h)
Note:	no longer supported by Novell DOS 7 / OpenDOS
SeeAlso: AX=4306h
--------N-214310-----------------------------
INT 21 - Banyan VINES 2.1+ - GET EXTENDED FILE ATTRIBUTES
	AX = 4310h
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	    CH = attributes (see #1109)
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see #1366 at AH=59h/BX=0000h)
Note:	the filename may be a directory but must be on a VINES file service
SeeAlso: AX=4300h,AX=4311h,AH=B6h,INT 2F/AX=110Fh
--------N-214311-----------------------------
INT 21 - Banyan VINES 2.1+ - SET EXTENDED FILE ATTRIBUTES
	AX = 4311h
	CH = new attributes (see #1109)
	DS:DX -> ASCIZ filename
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,02h,03h,05h) (see #1366 at AH=59h/BX=0000h)
Note:	the filename may be a directory but must be on a VINES file service
SeeAlso: AX=4301h,AX=4305h,AX=4310h,INT 2F/AX=110Eh

Bitfields for VINES extended file attributes:
Bit(s)	Description	(Table 1109)
 7	unused
 6	shareable
 5	execute-only
 4-0	unused
--------u-214321BX0000-----------------------
INT 21 - Q87, Q387 - INSTALLATION CHECK
	AX = 4321h
	BX = 0000h
	EAX = 87654321h (entire EAX value is required, not just AX)
Return: EAX = 12345678h if installed
Program: Q387 (renamed to Q87 as of v3.7) is a math coprocessor emulator from
	  Quickware
Note:	this function is available only in virtual-86 mode in older versions;
	  newer versions also provide it in MS Windows 16- and 32-bit protected
	  mode
SeeAlso: AX=4321h/BX=0001h,AX=4321h/BX=0002h,INT 67/AX=4321h
--------u-214321BX0001-----------------------
INT 21 - Q87, Q387 - ENABLE EMULATOR
	AX = 4321h
	BX = 0001h
	EAX = 87654321h (entire EAX value is required, not just AX)
Desc:	enable the emulator by setting the CPU MSW's EM bit and updating
	  the BIOS equipment list
Note:	this function is available only in virtual-86 mode in older versions;
	  newer versions also provide it in MS Windows 16- and 32-bit protected
	  mode
SeeAlso: AX=4321h/BX=0000h,AX=4321h/BX=0002h
--------u-214321BX0002-----------------------
INT 21 - Q87, Q387 - DISABLE EMULATOR
	AX = 4321h
	BX = 0002h
	EAX = 87654321h (entire EAX value is required, not just AX)
Desc:	disable the emulator by clearing the CPU MSW's EM bit and updating
	  the BIOS equipment list
Note:	this function is available only in virtual-86 mode in older versions;
	  newer versions also provide it in MS Windows 16- and 32-bit protected
	  mode
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
--------D-214400-----------------------------
INT 21 - DOS 2+ - IOCTL - GET DEVICE INFORMATION
	AX = 4400h
	BX = handle
Return: CF clear if successful
	    DX = device information word (see #1110)
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h) (see #1366 at AH=59h/BX=0000h)
Notes:	value in DH corresponds to high byte of device driver's attribute word
	  if handle refers to a character device
	Novell NetWare reportedly does not return a drive number in bits 5-0
	  for a disk file
	this function was not supported by Digital Research's DOS-Plus
SeeAlso: AX=4401h,INT 2F/AX=122Bh

Bitfields for device information word:
Bit(s)	Description	(Table 1110)
 character device
  14	device driver can process IOCTL requests (see AX=4402h"DOS 2+")
  13	output until busy supported
  11	driver supports OPEN/CLOSE calls
   8	??? (set by MS-DOS 6.2x KEYB)
   7	set (indicates device)
   6	EOF on input
   5	raw (binary) mode
   4	device is special (uses INT 29)
   3	clock device
   2	NUL device
   1	standard output
   0	standard input
 disk file
  15	file is remote (DOS 3.0+)
  14	don't set file date/time on closing (DOS 3.0+)
  11	media not removable
   8	(DOS 4 only) generate INT 24 if no disk space on write or read past
	  end of file
   7	clear (indicates file)
   6	file has not been written
  5-0	drive number (0 = A:)
SeeAlso: INT 29
--------D-214401-----------------------------
INT 21 - DOS 2+ - IOCTL - SET DEVICE INFORMATION
	AX = 4401h
	BX = handle (must refer to character device)
	DX = device information word (see #1110)
	    (DH must be zero for DOS version prior to 6.x)
Return: CF clear if successful
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Note:	this function was not supported by Digital Research's DOS-Plus
SeeAlso: AX=4400h,INT 2F/AX=122Bh
--------D-214402-----------------------------
INT 21 - DOS 2+ - IOCTL - READ FROM CHARACTER DEVICE CONTROL CHANNEL
	AX = 4402h
	BX = file handle referencing character device
	CX = number of bytes to read
	DS:DX -> buffer
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	format of data is driver-specific
	  (also see separate entries below for some specific cases)
	this function was not supported by Digital Research's DOS-Plus
SeeAlso: AX=4400h,AX=4403h"DOS",AX=4404h"DOS",INT 2F/AX=122Bh
--------N-214402-----------------------------
INT 21 - Network Driver Interface Specification (NDIS) 2.0.1 - PROTOCOL MANAGER
	AX = 4402h
	BX = file handle for device "PROTMAN$"
	CX = 000Eh (size of request block)
	DS:DX -> request block (see #1111,#1112,#1113,#1114,#1115,#1119,#1120)
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
SeeAlso: AX=4402h"FTPSOFT"

Format of NDIS request block for GetProtocolManagerInfo:
Offset	Size	Description	(Table 1111)
 00h	WORD	01h
 02h	WORD	returned status (see #1121)
 04h	DWORD	returned pointer to structure representing parsed user config
 08h	DWORD	unused
 0Ch	WORD	returned BCD version of NDIS on which Protocol Manager is based
SeeAlso: #1112,#1113,#1114,#1115,#1116,#1117,#1118,#1119,#1120

Format of NDIS request block for RegisterModule:
Offset	Size	Description	(Table 1112)
 00h	WORD	02h
 02h	WORD	returned status (see #1121)
 04h	DWORD	pointer to module's common characteristics table (see #1122)
 08h	DWORD	pointer to list of modules to which the module is to be bound
 0Ch	WORD	unused
SeeAlso: #1111,#1113,#1114,#1115,#1116,#1117,#1118,#1119,#1120

Format of NDIS request block for BindAndStart:
Offset	Size	Description	(Table 1113)
 00h	WORD	03h
 02h	WORD	returned status (see #1121)
 04h	DWORD	caller's virtual address in FailingModules structure
 08h	DWORD	unused
 0Ch	WORD	unused
SeeAlso: #1111,#1112,#1114,#1115,#1116,#1117,#1118,#1119,#1120

Format of NDIS request block for GetProtocolManagerLinkage:
Offset	Size	Description	(Table 1114)
 00h	WORD	04h
 02h	WORD	returned status (see #1121)
 04h	DWORD	returned dispatch point
 08h	DWORD	unused
 0Ch	WORD	returned protocol manager DS
Note:	the dispatch point may be called as follows instead of using this IOCTL
	STACK: WORD  protocol manager DS
	       DWORD pointer to request block
	Return: AX = returned status
		STACK popped
SeeAlso: #1111,#1112,#1113,#1115,#1116,#1117,#1118,#1119,#1120

Format of NDIS request block for GetProtocolIniPath:
Offset	Size	Description	(Table 1115)
 00h	WORD	05h
 02h	WORD	returned status (see #1121)
 04h	DWORD	pointer to a buffer for the ASCIZ pathname of PROTOCOL.INI
 08h	DWORD	unused
 0Ch	WORD	buffer length
SeeAlso: #1111,#1112,#1113,#1114,#1116,#1117,#1118,#1119,#1120

Format of NDIS request block for RegisterProtocolManagerInfo:
Offset	Size	Description	(Table 1116)
 00h	WORD	06h
 02h	WORD	returned status (see #1121)
 04h	DWORD	pointer to structure containing parsed user config file
 08h	DWORD	unused
 0Ch	WORD	length of structure
SeeAlso: #1111,#1112,#1113,#1114,#1115,#1117,#1118,#1119,#1120

Format of NDIS request block for InitAndRegister:
Offset	Size	Description	(Table 1117)
 00h	WORD	07h
 02h	WORD	returned status (see #1121)
 04h	DWORD	unused
 08h	DWORD	poitner to ASCIZ name of the module to be prebind initialized
 0Ch	WORD	unused
SeeAlso: #1111,#1112,#1113,#1114,#1115,#1116,#1118,#1119,#1120

Format of NDIS request block for UnbindAndStop:
Offset	Size	Description	(Table 1118)
 00h	WORD	08h
 02h	WORD	returned status (see #1121)
 04h	DWORD	failing modules as for BindAndStart
 08h	DWORD	if not 0000h:0000h, pointer to ASCIZ name of module to unbind
		if 0000h:0000h, terminate a set of previously dynamically
		  bound protocol modules
 0Ch	WORD	unused
SeeAlso: #1111,#1112,#1113,#1114,#1115,#1116,#1117,#1119,#1120

Format of NDIS request block for BindStatus:
Offset	Size	Description	(Table 1119)
 00h	WORD	09h
 02h	WORD	returned status (see #1121)
 04h	DWORD	must be 0000h:0000h
		on return, points to root tree
 08h	DWORD	0000h:0000h
 0Ch	WORD	unused under DOS
SeeAlso: #1111,#1112,#1113,#1114,#1115,#1116,#1117,#1118,#1120

Format of NDIS request block for RegisterStatus:
Offset	Size	Description	(Table 1120)
 00h	WORD	0Ah
 02h	WORD	returned status (0000h, 0008h, 002Ch) (see #1121)
 04h	DWORD	0000h:0000h
 08h	DWORD	pointer to 16-byte ASCIZ module name
 0Ch	WORD	0000h
Note:	not supported by the 10NET v5.0 PROTMAN$ driver
SeeAlso: #1111,#1112,#1113,#1114,#1115,#1116,#1117,#1118,#1119

(Table 1121)
Values for NDIS status code:
 0000h	success
 0001h	wait for release--protocol has retained control of the data buffer
 0002h	request queued
 0003h	frame not recognized
 0004h	frame rejected
 0005h	frame should be forwarded
 0006h	out of resource
 0007h	invalid parameter
 0008h	invalid function
 0009h	not supported
 000Ah	hardware error
 000Bh	transmit error
 000Ch	unrecognized destination
 000Dh	buffer too small
 0020h	already started
 0021h	binding incomplete
 0022h	driver not initialized
 0023h	hardware not found
 0024h	hardware failure
 0025h	configuration failure
 0026h	interrupt conflict
 0027h	MAC incompatible
 0028h	initialization failed
 0029h	no binding
 002Ah	network may be disconnected
 002Bh	incompatible OS version
 002Ch	already registered
 002Dh	path not found
 002Eh	insufficient memory
 002Fh	info not found
 00FFh	general failure
 F000h-FFFFh reserved for vendor-specific codes, treated as general failure

Format of NDIS common characteristics table:
Offset	Size	Description	(Table 1122)
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
 1Ch	BYTE	upper boundary protocol level (see #1123)
 1Dh	BYTE	upper boundary interface type
		for MACs: 1 = MAC
		for data links and transports: to be defined
		for session: 1 = NCB
		any level: 0 = private (ISV-defined)
 1Eh	BYTE	lower boundary protocol level (see #1123)
 1Fh	BYTE	lower boundary interface type
		same as offset 1Dh
 20h	WORD	module ID filled in by protocol manager
 22h	WORD	module DS
 24h	DWORD	system request entry point
 28h	DWORD	pointer to service-specific characteristics (see #1125,#1127)
		0000h:0000h if none
 2Ch	DWORD	pointer to service-specific status, or 0000h:0000h if none
		  (see #1128)
 30h	DWORD	pointer to upper dispatch table (see #1124)
		0000h:0000h if none
 34h	DWORD	pointer to lower dispatch table (see #1124)
		0000h:0000h if none
 38h  2 DWORDs	reserved, must be 0
Note:	for compatibility with NDIS 1.x.x, a major version of 00h is
	  interpreted as 01h

(Table 1123)
Values for NDIS boundary protocol level:
 00h	physical
 01h	Media Access Control
 02h	Data link
 03h	network
 04h	transport
 05h	session
 FFh	not specified

Format of NDIS dispatch table:
Offset	Size	Description	(Table 1124)
 00h	DWORD	-> common characteristics table (see #1122)
 04h  4 BYTEs	???
 08h	DWORD	-> ??? function (called with 12 bytes of stack arguments)
 0Ch	DWORD	-> ??? function (called with 10 bytes of stack arguments)
 10h	DWORD	-> ??? function (called with 16 bytes of stack arguments)
 14h	DWORD	-> ??? function (called with 4 bytes of stack arguments)
 18h	DWORD	-> ??? function (called with 18 bytes of stack arguments)
 1Ch	DWORD	-> ??? function (called with 12 bytes of stack arguments)

Format of MAC Service-Specific Characteristics Table:
Offset	Size	Description	(Table 1125)
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
 40h	DWORD	service flags (see #1126)
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
SeeAlso: #1127

Bitfields for service flags:
Bit(s)	Description	(Table 1126)
 0	supports broadcast
 1	supports multicast
 2	supports functional/group addressing
 3	supports promiscuous mode
 4	station address software settable
 5	statistics always current
 6	supports InitiateDiagnostics
 7	supports loopback
 8	MAC does primarily ReceiveChain indications instead of ReceiveLookahead
	indications
 9	supports IBM source routing
 10	supports MAC reset
 11	supports Open/Close adapter
 12	supports interrupt request
 13	supports source routing bridge
 14	supports GDT virtual addresses (OS/2 version)
 15	multiple TransferDatas allowed durign a single indication
 16	MAC normally sets FrameSize = 0 in ReceiveLookahead
 17-31	reserved, must be 0

Format of NetBIOS Service-Specific Characteristics Table:
Offset	Size	Description	(Table 1127)
 00h	WORD	length of table in bytes
 02h 16 BYTEs	ASCIZ type name of NetBIOS module
 12h	WORD	NetBIOS module code
 14h  N BYTEs	vendor-specific info
SeeAlso: #1125

Format of MAC Service-Specific Status Table:
Offset	Size	Description	(Table 1128)
 00h	WORD	length of table in bytes
 02h	DWORD	seconds since 0:00 1/1/70 when diagnostics last run
		(FFFFFFFFh = never)
 06h	DWORD	MAC status bits (see #1129)
 0Ah	WORD	current packet filter flags (see #1130)
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

Bitfields for MAC status bits:
Bit(s)	Description	(Table 1129)
 0-2	operational status
	000 hardware not installed
	001 hardware failed startup diagnostics
	010 hardware configuration problem
	011 hardware fault
	100 operating marginally due to soft faults
	101 reserved
	110 reserved
	111 hardware fully operational
 3	MAC bound
 4	MAC open
 5	diagnostics in progress
 6-31	reserved

Bitfields for packet filter flags:
Bit(s)	Description	(Table 1130)
 0	directed/multicast or group/functional
 1	broadcast
 2	promiscuous
 3	all source routing
 4-15	reserved, must be zero
--------D-214402-----------------------------
INT 21 U - MS-DOS 7.0 - CONFIG$ device - GET CONFIGURATION INFORMATION
	AX = 4402h
	BX = file handle for character device "CONFIG$"
	CX = number of bytes to read (at least 5)
	DS:DX -> buffer for ??? data (see #1131)
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
SeeAlso: AX=4403h"CONFIG$"

Format of MS-DOS 7.0 CONFIG$ ??? data:
Offset	Size	Description	(Table 1131)
 00h	WORD	??? (0000h)
 02h	WORD	??? (0000h or value read from IO.SYS segment 70h)
 04h	BYTE	??? (value read from IO.SYS segment 70h)
--------I-214402-----------------------------
INT 21 U - IBM SYSTEM 36/38 WORKSTATION EMULATION - VDI.SYS - GET ???
	AX = 4402h
	BX = handle for character device "GDMS"
	CX = number of bytes to read (>= 4)
	DS:DX -> buffer (see #1132)
Return: CF set on error
	    AX = error code (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
	    AX = number of bytes read

Format of System 36/38 emulator returned data:
Offset	Size	Description	(Table 1132)
 00h  4 BYTEs	???
 04h	DWORD	pointer to ???
 08h  4 BYTEs	???
--------m-214402-----------------------------
INT 21 U - LASTBYTE.SYS v1.19 - IOCTL - GET ??? TABLE
	AX = 4402h
	BX = handle for device "LA$TBYTE"
	CX = 0004h
	DS:DX -> DWORD to hold address of 39-byte table of ???
Return: CF set on error
	    AX = error code (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
	    AX = number of bytes read
Program: LASTBYTE.SYS is part of the shareware "The Last Byte" memory
	  management package by Key Software Products
SeeAlso: AX=4402h"HIGHUMM"
--------m-214402-----------------------------
INT 21 - HIGHUMM.SYS v1.17+ - IOCTL - GET API ADDRESS
	AX = 4402h
	BX = handle for device "KSP$UMM"
	CX = 0004h
	DS:DX -> DWORD to hold entry point (see #1133)
Return: CF set on error
	    AX = error code (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
	    AX = number of bytes read
Program: HIGHUMM.SYS is part of the shareware "The Last Byte" memory
	  management package by Key Software Products
SeeAlso: AX=4402h"LASTBYTE"

(Table 1133)
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
--------c-214402-----------------------------
INT 21 - SMARTDRV.SYS v3.x only - IOCTL - GET CACHE STATUS
	AX = 4402h
	BX = file handle for device "SMARTAAR"
	CX = number of bytes to read (min 28h)
	DS:DX -> buffer for status record (see #1134)
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Note:	NCache2 (from the Norton Utilities v8.0) attempts to support this
	  interface, but does not do so correctly, often hanging the system;
	  one should use the SmartDrive v4.x or NCache private interfaces
	  (see INT 2F/AX=4A10h/BX=0000h,INT 2F/AX=FE00h/DI=4E55h)
SeeAlso: AX=4403h"SMARTDRV",INT 2F/AX=4A10h/BX=0000h

Format of SMARTDRV status record:
Offset	Size	Description	(Table 1134)
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
--------d-214402-----------------------------
INT 21 - CD-ROM device driver - IOCTL INPUT
	AX = 4402h
	BX = file handle referencing character device for CD-ROM driver
	CX = number of bytes to read
	DS:DX -> control block (see #1136)
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	the data returned depends on the first byte of the control block
	  (two bytes for functions 01h/07h/0Bh, see #1136); the remainder of
	  the control block is filled by the driver
	some device drivers support several subunits (that is more than one
	  drive) but it is not possible to distinguish between them with this
	  function; use INT 2F/AX=1510h or INT 2F/AX=0802h instead
	under Windows95, the "mscd$$$$" device cannot be opened so you cannot
	  obtain the handle required by this function: use INT 2F/AX=1510h
	  or INT 2F/AX=0802h instead
SeeAlso: AX=4403h"CD-ROM",INT 2F/AX=0802h,INT 2F/AX=1510h

(Table 1135)
Values for CD-ROM data being requested:
 00h	device driver header address
 01h	drive head location
 02h	reserved
 03h	error statistics
 04h	audio channel info
 05h	raw drive bytes (uninterpreted and device-specific)
 06h	device status
 07h	sector size
 08h	volume size
 09h	media change status
 0Ah	audio disk info
 0Bh	audio track info
 0Ch	audio Q-Channel info
 0Dh	audio sub-channel info
 0Eh	UPC code
 0Fh	audio status info

Format of CD-ROM control block:
Offset	Size	Description	(Table 1136)
 00h	BYTE	data being requested (see #1135)
---function 00h---
 01h	DWORD	device driver header address (see also AH=52h,#1332)
---function 01h---
 01h	BYTE	(call) addressing mode
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
 01h	DWORD	device parameters (see #1137)
---function 07h---
 01h	BYTE	(call) read mode
		00h cooked
		01h raw
 02h	WORD	(return) sector size in bytes
---function 08h---
 01h	DWORD	volume size in sectors
BUGS:	Aztech device driver v1.10 and v1.27 (at least) return the last sector
	  number, i.e. total number of sectors - 1
	Windows95 returns the total number of sectors + 150 (see the Red Book
	  to HSG conversion formula at function 01h to understand why this
	  happens)
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
 01h	BYTE	(call) track number
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
---function 0Fh---
 ??? documentation not yet available
 01h	WORD	pause status (0000h not paused, 0001h paused)
 03h	DWORD	audio play start address
 07h	DWORD	??? audio play length or end address

Bitfields for CD-ROM device parameters:
Bit(s)	Description	(Table 1137)
 0	door open
 1	door unlocked
 2	supports raw reading in addition to cooked
 3	writable
 4	can play audio/video tracks
 5	supports interleaving
 6	reserved
 7	supports prefetch requests
 8	supports audio channel control
 9	supports Red Book addressing in addition to HSG
 10	audio is playing
 11	no disk in drive
 12	supports R-W subchannels
--------m-214402-----------------------------
INT 21 - Quarterdeck - QEMM-386 v5+ - GET API ENTRY POINT
	AX = 4402h
	BX = file handle for device "QEMM386$"
	CX = 0004h
	DS:DX -> DWORD buffer for API entry point
Return: CF clear if successful
	    buffer filled (refer to INT 67/AH=3Fh for entry point parameters)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Note:	Quarterdeck recently (June 1993) documented this function, but the
	  documentation incorrectly states that it is only available for
	  QEMM 6+
SeeAlso: AX=4402h"HOOKROM",INT 2F/AX=D201h/BX=5145h,INT 67/AH=3Fh
--------Q-214402-----------------------------
INT 21 U - Quarterdeck - HOOKROM.SYS - GET HOOKED VECTOR TABLE
	AX = 4402h
	BX = file handle for device "HOOKROM$"
	CX = 0004h
	DS:DX -> DWORD buffer for address of hooked vector table (see #1138)
Return: CF clear if successful
	    DS:DX buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
SeeAlso: AX=4402h/SF=01h

Format of HOOKROM.SYS hooked vector table entry:
Offset	Size	Description	(Table 1138)
 00h  5 BYTEs	FAR jump to actual interrupt handler
		(end of table if first byte is not EAh)
 05h	BYTE	interrupt vector number
--------d-214402-----------------------------
INT 21 - Advanced SCSI Programming Interface (ASPI) - INTERFACE
	AX = 4402h
	BX = file handle for device "SCSIMGR$"
	CX = 0004h or 0005h (refer to notes below)
	DS:DX -> buffer for result (see #1139), set to zeros before call
Return: CF clear if successful
	    AX = 0004h or 0005h (refer to notes below)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	the variant of the call requesting five bytes is an UNDOCUMENTED
	  extension supported by Adaptec's ASPI2DOS.SYS, ASPI4DOS.SYS, and
	  ASPI7DOS.SYS; if made of a host manager which does not support the
	  variant, only four bytes will be returned.  If the variant is
	  supported, Adaptec's WINASPI.DLL assumes that the host manager is
	  an "advanced" one which operates in either real or protected mode
	  (and thus does not require a DPMI INT 31/AX=0301h call to be invoked
	  from protected mode).	 Support of the five-byte variant also appears
	  to imply that an advanced ASPI host manager uses no temporary
	  storage space except the SRB (see #1141) and the stack, and that it
	  is fully reentrant.
	if called with a standard request for four bytes, even Adaptec's
	  advanced drivers return only the requested four bytes containing the
	  ASPI entry point address
	the function address is called with the address of a SCSI Request
	  Block (see #1141) on the stack and the caller must clean up the
	  stack
SeeAlso: AX=440Ch"ASPITAPE",INT 11/AH=FFh"WD7000"

Format of ASPI IOCTL result:
Offset	Size	Description	(Table 1139)
 00h	DWORD	function address
 04h	BYTE	number of SCSI host adapters supported by host manager

(Table 1140)
Values for ASPI request number:
 00h	"HA_INQ"	host adapter inquiry / extended host adapter inquiry
 01h	"GET_TYPE"	get device type
 02h	"EXEC_SIO"	execute SCSI I/O
 03h	"ABORT_SRB"	abort SRB
 04h	"RESET_DEV"	reset SCSI device
 05h	"SET_HAPRMS"	set host adapter parameters
 06h	get disk drive information

Format of SCSI Request Block (64 bytes):
Offset	Size	Description	(Table 1141)
 00h	BYTE	request number (see #1140)
 01h	BYTE	request status (see #1142)
 02h	BYTE	host adapter ID
 03h	BYTE	request flags (see #1143)
 04h	DWORD	reserved (0)
---request 00h---
 08h	BYTE	(ret) number of host adapters
 09h	BYTE	(ret) target adapter ID
 0Ah 16 BYTEs	(ret) SCSI manager ID
 1Ah 16 BYTEs	(ret) host adapter ID
 2Ah 16 BYTEs	(ret) host adapter-unique parameters
---extended request 00h---
 04h  2 BYTEs	(call) extended request signature 55h AAh
		(ret) if extended request supported, reply AAh 55h
 06h	WORD	(call) length of extended buffer at offset 3Ah
		(ret) number of bytes returned in extended buffer
 08h	BYTE	(ret) number of host adapters
 09h	BYTE	(ret) target adapter ID
 0Ah 16 BYTEs	(ret) SCSI manager ID
 1Ah 16 BYTEs	(ret) host adapter ID
 2Ah 16 BYTEs	(ret) host adapter-unique parameters
 3Ah  N BYTEs	extended buffer
		3Ah	WORD	features (see #1144)
		3Ch	WORD	maximum scatter/gather list length
		3Eh	DWORD	maximum SCIS data transfer size (0 = unlimited)
---request 01h---
 08h	BYTE	target ID
 09h	BYTE	logical unit number
 0Ah	BYTE	(ret) device type (see #1147)
---request 02h---
 08h	BYTE	target ID
 09h	BYTE	logical unit number
 0Ah	DWORD	data allocation length
		(ret) residual byte length (if supported and requested)
 0Eh	BYTE	sense allocation length
 0Fh	DWORD	data buffer pointer
 13h	DWORD	next request pointer (for linking)
 17h	BYTE	CDB length
 18h	BYTE	(ret) host adapter status (see #1141)
 19h	BYTE	(ret) target status (see #1146)
 1Ah	DWORD	post routine address (see #1153)
 1Eh	WORD	real mode Post DS
 20h	DWORD	SRB pointer
 24h	WORD	reserved
 26h	DWORD	SRB physical address
 2Ah 22 BYTEs	SCSIMGR$ workspace
 40h  N BYTEs	CCB, including sense data (20-24 bytes)
---request 03h---
 08h	DWORD	address of SRB to abort
---request 04h---
 08h	BYTE	target ID
 09h	BYTE	logical unit number
 0Ah 14 BYTEs	reserved
 18h	BYTE	(ret) host adapter status (see #1145)
 19h	BYTE	(ret) target status (see #1146)
 1Ah	DWORD	post routine address
 1Eh 34 BYTEs	workspace
---request 05h---
 08h 16 BYTEs	host adapter-unique parameters
---request 06h---
 08h	BYTE	target ID
 09h	BYTE	logical unit number
 0Ah	BYTE	disk drive flags (see #1148)
 0Bh	BYTE	INT 13h drive number
 0Ch	BYTE	preferred head number translation
 0Dh	BYTE	preferred sector size translation
 0Eh 10 BYTEs	reserved
SeeAlso: #1149

(Table 1142)
Values for ASPI request status:
 00h	not done yet
 01h	completed successfully
 02h	aborted by host
 04h	SCSI I/O error
 80h	invalid
 81h	no adapter
 82h	no device attached
 else	status
SeeAlso: #1141

Bitfields for ASPI request flags:
Bit(s)	Description	(Table 1143)
 0	posting enabled
 1	linking enabled
 2	residual byte length reported in Data Allocation Length field
 3	transfer from SCSI target to host
 4	transfer from host to SCSI target
 5	scatter/gather
 7-6	reserved
Note:	no data is transferred if both bits 3 and 4 are set; if neither is
	  set, the direction is determined by the SCSI command
SeeAlso: #1141

Bitfields for ASPI extended features:
Bit(s)	Description	(Table 1144)
 0	scatter/gather supported
 1	residual byte length reported
 2	Wide SCSI 16 host adapter
 3	Wide SCSI 32 host adapter
 15-4	reserved
SeeAlso: #1141

(Table 1145)
Values for host adapter status:
 00h	no error detected
 11h	select timeout
 12h	data overrun
 13h	bus error
 14h	bus failure

(Table 1146)
Values for target status:
 00h	no status
 02h	sense data stored in SRB
 08h	target busy
 18h	reservation error

(Table 1147)
Values for device type:
 00h	disk drive
 01h	tape drive (streamer)
 02h	printer
 03h	processor
 04h	WORM drive
 05h	CD-ROM drive
 06h	scanner
 07h	optical drive
 08h	autochanger
 09h	communications device

(Table 1148)
Values for disk drive flags:
 00h	no INT 13 access
 01h	INT 13 with DOS access
 02h	INT 13 without DOS access
 03h	invalid flags

Format of CCB:
Offset	Size	Description	(Table 1149)
 00h	BYTE	command code (see #1150)
 01h	BYTE	flags
		bits 4-0: vary by function
		bits 7-5: logical unit number
 02h	BYTE	"adr_1"
 03h	BYTE	"adr_0"
 04h	BYTE	length
 05h	BYTE	control
	...
 06h/0Ah 14 BYTEs buffer for sense data (see #1151)
SeeAlso: #1141

(Table 1150)
Values for CCB command code:
 00h	test unit ready
 01h	rewind
 03h	request sense data
 05h	get block size limits
 08h	Group 0 read
 0Ah	Group 0 write
 10h	write file marks
 11h	SCSI Space (set position?)
 12h	SCSI Inquire
 15h	set mode information
 16h	reserve SCSI device
 17h	release SCSI device
 19h	erase
 1Ah	request mode information
 1Bh	load/unload media
 1Dh	request target self-check
 24h	set window parameters
 25h	get window parameters
 28h	Group 1 read
 2Ah	Group 1 write
 31h	document feeder control
 34h	get scan data status
---vendor-specific commands---
 D3h	get document feeder status
 D4h	set document feeder mode

Format of sense data:
Offset	Size	Description	(Table 1151)
 00h	BYTE	error code (bit 7 set if valid)
 01h	BYTE	segment number
 02h	BYTE	sense key
		bit 6: EOM
		bit 5: ILI
		bits 0-3: sense key (see #1152)
 03h  4 BYTEs	information bytes
 07h	BYTE	additional sense length (0Ah)
 08h  4 BYTEs	command-specific information
 0Ch	BYTE	additional sense code
 0Dh	BYTE	additional sense code qualifier
 0Eh	BYTE	field replaceable unit code
 0Fh  3 BYTEs	sense key specific bytes

(Table 1152)
Values for sense key:
 00h	no sense data
 02h	SCSI unit not ready
 03h	media error
 04h	unrecoverable hardware error
 05h	illegal parameter in CDB
 06h	target has been reset
 0Bh	target aborted command

(Table 1153)
Values APSI post function is called with:
	STACK:	DWORD -> SRB (see #1141) which completed
	interrupts disabled
Return: EBP, EBX, ESI, EDI must be preserved
	interrupts disabled
Note:	the post function may issue any APSI function except an abort; it
	  should complete as quickly as possible
--------m-214402-----------------------------
INT 21 U - Qualitas 386MAX v6.00+ - IOCTL INPUT - GET STATE
	AX = 4402h
	BX = file handle for device "386MAX$$"
	CX = number of bytes to read
	DS:DX -> BYTE 03h followed by 386MAX state buffer (see #1154)
Return: CF clear if successful
	    buffer at DS:DX+1 filled
	    AX = number of bytes actually copied
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	if the value given in CX is less than the size of the state record
	  (5Ah for v6.01, 66h for v7.00), only a partial state record will be
	  returned
	the state is 40h bytes for 386MAX (actually ASTEMM) v2.20 ("386MAX$$"
	  did not exist yet, use "QMMXXXX0" and then "EMMXXXX0" instead) and
	  56h bytes for v5.11.
	to invoke 386MAX API functions, push DX onto the stack, load DX with
	  the word at offset 25h in the returned state, load all other
	  registers as needed for the desired function, and execute an
	  OUT DX,AL or OUT DX,AX; DX will be set to the pushed value on return
	  if it is not otherwise modified by the API function.	For safety,
	  in case a function is not supported or 386MAX is not present, SP
	  should be saved and restored around the API call.
	Windows 3.1 Standard mode, LAN Manager, and Windows for Workgroups all
	  use the 386MAX API; LAN Manager and Windows for Workgroups reportedly
	  make some calls incorrectly
SeeAlso: AX=4403h/SF=03h"386MAX",INT 67/AH=3Fh

Format of 386MAX v6.01+ state:
Offset	Size	Description	(Table 1154)
 -1	BYTE	(call) 03h
 00h  6 BYTEs	signature "386MAX"
 06h  4 BYTEs	version string "N;NN" or "N.NN" (i.e. "6;01" for v6.01)
		(';' by default; apparently changed to a period when 386MAX
		has linked high RAM into DOS's memory chain)
 0Ah	WORD	segment of low-memory portion of 386MAX.SYS
 0Ch  2 BYTEs	???
 0Eh	WORD	segment of ??? memory block or 0000h
 10h	WORD	bit flags 1 (see #1155)
 12h	WORD	starting address of video memory in KB
 14h  2 BYTEs	???
 16h	WORD	total high DOS memory in KB
 18h  2 BYTEs	???
 1Ah	WORD	available shared memory in KB
 1Ch	WORD	KBytes extended memory used by 386MAX
 1Eh  2 BYTEs	???
 20h	WORD	total extended memory in KB
 22h	WORD	IO port to write (OUT DX,AL) to invoke 386MAX INT 15 functions
 24h	WORD	IO port to write (OUT DX,AL) to invoke 386MAX API functions
		  (see #1168)
 26h	WORD	??? (depends on DOS version)
 28h	WORD	size of ??? in paragraphs
 2Ah	DWORD	machine type (see #1163)
 2Eh	DWORD	-> first DOS memory control block
 32h	WORD	system configuration flags (see #1156)
 34h	WORD	debugging flags 1 (see #1157)
 36h	WORD	debugging flags 2 (see #1158)
 38h  2 BYTEs	???
 3Ah	WORD	segment of first MCB in high memory chain
 3Ch	WORD	feature flags 1 (see #1160)
 3Eh	WORD	feature flags 2 (see #1161)
 40h	WORD	feature flags 3 (see #1162)
 42h	WORD	segment of first 386MAX control block??? (see #1164)
 44h	WORD	amount of memory to report available on INT 15/AH=88h
 46h  4 BYTEs	???
 4Ah	WORD	number of K at start of address space swapped with fast
		  extended memory (SWAP= parameter)
 4Ch  2 BYTEs	???
 4Eh	WORD	segment address of ???
 50h	WORD	debugging flags 3 (see #1159)
 52h	DWORD	old INT 21h
 56h	DWORD	pointer to 386MAX's EMS (INT 67h) handler
---386MAX v7.00---
 5Ah	DWORD	KB of extended memory managed by 386MAX
 5Eh	DWORD	bytes of extended memory (EXT= parameter)
 62h  4 BYTEs	???

Bitfields for 386MAX bit flags 1:
Bit(s)	Description	(Table 1155)
 1	???
 2	allow A20 to be enabled/disabled???
 3	??? (cleared by calling INT 67 functions or starting MSWindows)
 4	high RAM present???
 5	386MAX in AUTO mode
 6	386MAX enabled
 7	386MAX is providing EMS services
 8	??? (affects API function 08h)
 9	A20 gate closed (A20 disabled) (see INT 15/AX=2402h)
 10	Weitek support enabled
 11	???
 12	ROMs not shadowed???
 13	QPMS has been used
 14	???
 15	???

Bitfields for 386MAX system configuration flags:
Bit(s)	Description	(Table 1156)
 1	ROM compressed???
 3	???
 5	386MAX loaded into high memory
 6	Microchannel bus
 7	Weitek math coprocessor detected
 9	??? (also generates INT 01 on ??? and INT 03 on ???)
 11	PC/XT (thus only single 8259 interrupt controller present, DMA only
		in 1st megabyte, etc)
 13	LMLTOP= specified
 14	enable A20 control???
 15	???

Bitfields for 386MAX debugging flags 1:
Bit(s)	Description	(Table 1157)
 0	DEBUG=LED
 1	DEBUG=X67
 2	DEBUG=INV
 3	DEBUG=EMSPTED
 4	DEBUG=JMP
 5	DEBUG=CALL
 6	DEBUG=HLT
 7	DEBUG=PMR
 8	DEBUG=CR3
 9	DEBUG=CAPS or DEBUG=INT
 10	DEBUG=RC
 11	DEBUG=ROM
 12	DEBUG=XM
 13	DEBUG=SOR
 14	DEBUG=XR
 15	DEBUG=EMSERR (generate INT 01 on returning error from EMS call)

Bitfields for 386MAX debugging flags 2:
Bit(s)	Description	(Table 1158)
 0	DEBUG=ROMSWAP
 1	DEBUG=UNSHADOWROM
 2	DEBUG=COMPROM
 3	DEBUG=DPMIPHYS
 4	DEBUG=ALLROM
 5	DEBUG=VMS
 6	DEBUG=XMS (generate INT 01 on XMS calls)
 7	DEBUG=I06
 8	DEBUG=VCPI
 9	DEBUG=XDMA
 10	DEBUG=X09
 13	DEBUG=I67 (generate INT 01 on every INT 67 call)
 14	DEBUG=EVM (generate INT 01 on entering V86 mode)
 15	DEBUG=EMSSAVE or DEBUG=VDS

Bitfields for 386MAX debugging flags 3:
Bit(s)	Description	(Table 1159)
 10	DEBUG=EPM
 12	DEBUG=ABIOS
 13	DEBUG=XMSPTED
 14	DEBUG=TIME
 15	DEBUG=SCRUB

Bitfields for 386MAX feature flags 1:
Bit(s)	Description	(Table 1160)
 1	Weitek present
 2	no DPMI services
 3	NODMA
 4	TERSE
 5	NOROM
 6	NOPARITY
 8	NOFLEX (IGNOREFLEXFRAME)
 11	don't create UMBs
 12	don't backfill below video memory (NOLOW)
 13	FRAME= specified
 14	EXT= specified
 15	NOEMS, allow prior expanded memory manager to provide EMS

Bitfields for 386MAX feature flags 2:
Bit(s)	Description	(Table 1161)
 0	UNSHIFT specified (FORCEA20 disabled)
 1	NOXRAM
 2	NOSCSI specified
 3	SCREEN specified
 4	enabled EISADMA
 5	slow DMA
 6	RESETKEYB specified
 7	???
 9	TOP384
 10	???
 11	NOWARMBOOT
 12	USE= specified
 13	ROM= specified

Bitfields for 386MAX feature flags 3:
Bit(s)	Description	(Table 1162)
 0	Windows3 support enabled
 1	SHADOWROM
 2	don't compress ROM (NOCOMPROM)
 3	??? (related to PRGREG=)
 4	??? (related to PRGREG=)
 5	SHADOWRAM
 6	DOS4 specified
 7	NOLOADHIGH
 8	NOPULSE
 11	FORCEA20
 12	DMA buffer enabled
 13	NOSCRUB
 15	NOFRAME

Bitfields for 386MAX machine type:
Bit(s)	Description	(Table 1163)
 12	Amstrad
 13	Epson
 14	Zenith Data Systems
 15	"ASEM"
 16	NEC
 17	"HPRS" model codes 69h and 6Ah
 18	Dell
 19	"CA"
 20	ITT (Xtra Business Systems/Alcatel)
 21	Toshiba 5100
 22	Olivetti
 23	Quadram Quad386 (BIOS model FEh, submodel A6h)
 24	Tandy???
 25	AST 386
 26	INBOARD, ??? version
 27	INBOARD, ??? version
 28	INBOARD, ??? version
 29	"HPRS"
 30	Compaq 386
 31	JET386

Format of 386MAX control block:
Offset	Size	Description	(Table 1164)
 00h	WORD	segment of next block (FFFFh if last)
 02h	WORD	segment of previous block (FFFFh if first)
 04h 12 BYTEs	filename
 10h	WORD	resident size in paragraphs
 12h	WORD	environment size???
 14h	WORD	real prsent environment size + 1 (0000h if ENVSAVE used)
 16h  2 BYTEs	???
 18h	DWORD	initial size or SIZE=n in 386LOAD commandline
 1Ch	DWORD	SIZE=-1 ???
 20h	DWORD	SIZE= ???
 24h	BYTE	PRGREG= if specified, else FFh
 25h	BYTE	ENVREG= if specified, else FFh
 26h	BYTE	FlexFrame (00h not present, 01h present)
 27h  3 BYTEs	???
 2Ah	BYTE	GROUP= or 00h if not present
 2Bh	BYTE	???
 2Ch	WORD	PSP

Format of 386MAX high memory info record:
Offset	Size	Description	(Table 1165)
 00h	WORD	segment address of memory region
 02h	WORD	size of memory region in paragraphs
 04h	BYTE	type or flags???
		00h if locked out
		02h if EMS page frame
		04h if high RAM
		42h if ROM
 05h	BYTE	???

Format of 386MAX ROM shadowing record:
Offset	Size	Description	(Table 1166)
 00h	WORD	logical start segment of ROM??? (may be used by BlueMAX when it
		  squeezes together the ROMs to make room)
 02h	WORD	physical start segment of ROM
 04h  2 BYTEs	???
 06h	WORD	size of shadowed ROM in paragraphs
 08h  2 BYTEs	???
 0Ah	WORD	flags
		bit 15: shadowing enabled for this ROM???
		bit 14: ???
		bit 13: ???
		bit 12: ???
		bit 10: ???

(Table 1167)
Values for 386MAX memory type:
 00h	unused by EMS
 01h	DOS
 04h	page frame overlapping ROM???
 80h	high memory
 84h	page frame???
 87h	video ROM???
Note:	the type may be 00h (unused) if the 16K page is split among different
	  uses (such as ROM and high RAM)

(Table 1168)
Call 386MAX API (via OUT DX,AL) with:
	STACK: WORD value for DX
	AH = 00h unused
		Return: AH = 84h (unsupported function)
	AH = 01h get high memory information
		ES:DI -> buffer for array of high memory info records
			(see #1165)
		Return: CX = number of records placed in buffer
	AH = 02h get shadowed ROM info
		ES:DI -> buffer for array of ROM shadowing records (see #1166)
		Return: CX = number of records placed in buffer
	AH = 03h get 386MAX state
		ES:DI -> 90-byte buffer for state (see #1154)
		Return: AH = 00h (successful)
			buffer filled
	AH = 04h get memory types???
		ES:DI -> buffer for memory type info (array of bytes, one per
			16K page) (see #1167)
		Return:	CX = number of bytes placed in buffer
	AH = 05h get page table entries
		AL = A20 control (00h enable A20 first, 01h leave unchanged)
		CX = buffer size in bytes (0000h = enough for all memory from
			given start to end of memory managed by 386MAX)
		SI = first K to report (rounded down to 4K page)
		ES:DI -> buffer for returned page table entries
		Return: CX = number of bytes returned (four per 4K page)
			ES:DI buffer filled
	AH = 06h get memory speed info
		ES:DI -> buffer for memory speed records (see #1169)
		Return: AH = 00h (successful)
			CX = number of bytes placed in buffer
		Note:	this function can take over a second to execute
	AH = 07h map/unmap multiple handle pages
		DX = EMS handle (on stack)
		STACK: DWORD -> EMS mapping record
		Return:	AH = status (00h,80h,83h,8Ah,8Bh)
		Format of EMS mapping record:
		Offset	Size	Description
		 00h	WORD	function
				0000h use physical page numbers
				0001h use segment addresses
		 02h	WORD	EMS handle
		 04h	WORD	number of mapping entries following
		 06h 2N WORDs	logical page number and physical page/segment
				logical page FFFFh means unmap physical page
		SeeAlso: INT 67/AH=50h
	AH = 08h "EMM2_GOREAL" check whether possible to disable 386MAX
		AL = ??? (00h or nonzero)
		Return: AH = status (00h OK, A4h not possible at this time)
		Note:	if AL=00h, this function always returns success
	AH = 09h toggle Bit Flags 1 flags
		BX = bitmask of bit flags 1's flags to toggle (see #1155)
		Return: AH = 00h (successful)
		Note:	enables A20 first
	AH = 0Ah toggle Debugging Flags 1 flags
		BX = bitmask of Debugging Flags 1's bits to toggle (see #1157)
		Return: AH = 00h (successful)
		Notes:	enables A20 first
			does ??? if bit 3 on after specified bits are toggled
	AH = 0Bh toggle Debugging Flags 2 flags
		BX = bitmask of Debugging Flags 2's bits to toggle (see #1158)
		Return: AH = 00h (successful)
		Note:	enables A20 first
	AH = 0Ch toggle feature flags 3
		BX = bitmask of feature flags 3's bits to toggle (see #1162)
		Return: AH = 00h (successful)
		Note:	enables A20 first
	AH = 0Dh specify 386MAX high-memory location
		BX = segment address of high-memory real-mode portion of 386MAX
		CX = current segment of real-mode stub???
		Return: AH = status (00h successful)
			???
	AH = 0Eh CRT controller register virtualization
		AL = subfunction
		    00h allow access to CRTC I/O ports 03B4h/03B5h, 03D4h/03D5h
		    01h trap accesses to CRTC I/O ports
	AH = 0Fh reboot system
		Return: never
	AH = 10h unused
		Return: AH = 84h (unsupported function)
	AH = 11h get high memory information
		ES:DI -> 96-byte buffer for high memory info
		Return: AH = 00h (successful)
			ES:DI buffer filled
		Notes:	each byte in buffer contains bit flags for a 4K page in
			  the A000h-FFFFh region
				bit 0: page is writeable
				bit 1: physical address same as linear address
				bit 2: EMS page frame
				bit 6: page is part of the QPMS window
			this function can take over a second to execute,
			  because it does a 128K read for each page in an
			  attempt to flush any RAM cache the system may have
	AH = 12h shadow RAM mapping
		AL = subfunction
		    00h unshadow ROMs (except page FFh if NOWARMBOOT set)
		    01h map shadow RAM into ROM regions???
		Return: AH = 00h (successful) if AL=00h or 01h
			AH = 8Fh otherwise
	AH = 13h shadow RAM page protection
		AL = subfunction
		    00h set all shadowed ROM 4K pages to read-only
		    01h set all shadowed ROM 4K pages to read-write
		Return: AH = 00h (successful) if AL=00h or 01h
			AH = 8Fh otherwise
	AH = 14h get Programmable Option Select info???
		ES:DI -> 54-byte buffer for POS data???
		Return: AH = 00h if successful
			AH = A4h on error
		Note:	the buffer consists of nine 6-byte fields; the first
			  eight for slots 1-8, the last for the system board
	AH = 15h ???
		???
		Return: ???
	AH = 16h get 386MAX memory usage screen
		ES:DI -> buffer for memory info display
		CX = size of buffer in bytes
		Return:	ES:DI buffer filled with '$'-terminated string (if
				large enough to hold entire usage screen)
		Note:	the screen is 0303h bytes in v7.00
	AH = 17h Windows 3 startup/termination
		AL = subfunction
		    00h Windows3 initializing
			DX (on stack) = Windows startup flags
			DI = Windows version number (major in upper byte)
			ES:BX = 0000h:0000h
			DS:SI = 0000h:0000h
			Return: CX = 0000h if OK for Windows to load
				   <> 0 if Windows should not load
				ES:BX -> startup info structure
				DS:SI -> Virtual86 mode enable/disable callback
		    01h Windows3 terminating
			ES:BX -> ???
			DX (on stack) = Windows exit flags
			Return: ???
	AH = 18h QPMS (Qualitas Protected Memory Services)
		AL = subfunction
		    00h get QPMS configuration
			Return: BX = starting segment of QPMS memory window
				CX = number of 4K pages reserved for QPMS???
				DX = number of 4K pages in QPMS window???
		    01h map QPMS memory page???
			BX = 4K page number within memory reserved for QPMS???
			CL = 4K page number within QPMS memory window???
		    02h mark all QPMS memory read-only
		    03h mark all QPMS memory read-write
		Return: AH = status (00h,8Ah,8Bh,8Fh)
	AH = 19h get linear address for physical address
		EDX = physical address (low word on stack)
		Return: AH = status
			    00h successful
				EDX = linear address at which physical address
					may be accessed
			    8Bh physical address currently not addressable
		Note:	enables A20 first
	AH = 1Ah set page table entry
		EDX = new page table entry (low word on stack)
		ESI = linear address of page to map (bits 0-11 clear)
		Return: AH = status (00h,8Bh)
		Note:	enables A20 first
	AH = 1Bh get ???
		Return: AH = status
			BX = ???
			CX = number of ???
			EDX = physical address of ???
	AH = 1Ch get original interrupt vector
		AL = interrupt vector (00h-7Fh)
		Return: AH = 00h (successful)
			EDX = original vector before 386MAX loaded (segment in
				high word, offset in low word)
		Note:	no range checking is performed; requests for INTs 80h-
			  FFh will return random values
	AH = 1Dh display string???
		SI = ???
		Return: AH = 00h (successful)
			???
		Note:	this function appears to be broken in v7.00
	AH = 1Eh get memory info
		ES:DI -> memory info (see #1170)
		Return: ???
	AH = 1Fh get DPMI host information
		Return: AX = 0000h if successful
			BX = DPMI flags (see #2823 at INT 31/AX=0400h)
			CL = CPU type (02h = 80286, 03h = 80386, etc.)
			DX = DPMI ver supported (DH=major, DL=2-digit minor)
			SI = ???
			ES???:DI -> ???
		Note:	NOP if NODPMI switch specified
	AH = 20h (v7.00) get ???
	    AL = index of ???
	    Return: EDX = ??? for specified ???
	AH = 21h (v7.00) STACKS support
	    AL = 00h get STACKS parameters
		Return: BX = ??? (0060h for v7.00)
			CX = number of stacks for hardware interrupts
			DX = size of each stack in bytes
			SI = ??? (low and high bytes are separate values)
			DI = ??? (low and high bytes are separate values)
			    low byte = logical page number set by subfn 02h
			ES = ???
	    AL = 01h set ??? "EMM2_DSTKS"
		EBX = ???
		ECX = ???
	    AL = 02h set ???
		BL = logical page number for ??? (00h-03h)
		Return: AH = status (00h,8Ah)
	AH = 22h (v7.00) call ??? for every load module
	    AL = which function to call
		00h call ???
		else call ????
	    Return: AH = 00h
	    Note: if AL=00h, calls the protected-mode function pointed at by
		the DWORD at offset 22h from the start of each module installed
		by a LOAD= directive; if AL<>00h, it calls the function
		pointed at by the DWORD at offset 28h of the load module
	AH = 23h (v7.00) ???
	    AL = 00h set ???
		BL = ???
		Return:	AH = 00h or unchanged (depending on ???)
	    AL = 01h set ???
		BL = ???
		BH = ???
		CX = ???
		DX = ??? (on top of stack)
		Return: AH = status (00h if successful, 8Fh once table full)
		Note:	this call adds one entry to an internal table on each
			  call, until the table is full
	    AL = 02h get ???
		CX = size of buffer
		ES:DI -> buffer for ??? (60 bytes total data)
		Return: CX = number of bytes actually returned
		Note:	returns the array storing the values set with AX=2301h
		Format of one entry in array:
		Offset	Size	Description
		 00h	BYTE	??? (BL from subfn 01h)
		 01h	WORD	??? (CX from subfn 01h)
		 03h	BYTE	??? (BH from subfn 01h)
		 04h	WORD	??? (DX from subfn 01h)
	    AL = 03h set ??? name/path
		ES:DI -> buffer containing ASCIZ ???
	    AL = 04h get ???
		ES:DI -> buffer for ASCIZ ???
	    Note: the ASCIZ string for subfunctions 03h and 04h does not appear
		to be used by 386MAX, and may serve merely for communication
		between two other Qualitas programs
	AH = 24h (v7.00) high memory control
	    AL = 00h get high memory state
		Return: BX = current state
			    00h high memory removed from DOS memory chain
			    01h high memory included in DOS memory chain
	    AL = 01h set high memory state
		BX = new state
		    00h high memory removed from DOS memory chain
		    01h high memory included in DOS memory chain
		    else
			Return: ??? (error, but return varies according to ???)
	AH = 25h (v7.00) remove high RAM from DOS memory chain
	AH = 26h (v7.00) ???
	    BX = ???
	    CX = ???
	    SI = ???
	    DI = ???
	    Return: AH = status
		    BX = ???
		    CX = ???
	AH = 27h (v7.00) ???
	    AL = 00h get ???
		Return: BX = number of paragraphs for ???
	    AL = 01h ???
		BX = ???
		ES??? = ???
	    AL = 02h ???
		???
	    AL = 03h ???
		CX = ???
		DX = ???
		ES??? = ???
		Return: ???
	AH = 28h (v7.00) get ???
		Return: AH = status (00h,8Fh) (see #3319 at INT 67/AH=40h)
			if AH=00h,
			    CX = ???
			    DX = ???
	AH = 29h (v7.00) get ???
		Return: AX = ???
	AH = 40h-5Dh EMS services (see INT 67/AH=40h, etc.)
	AH = DEh VCPI services (see INT 67/AX=DE00h, etc.)
Return: AH = status (as for EMS INT 67 calls)
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h	undefined function
	    8Ah invalid logical page nuber
	    8Bh illegal physical page number
	    8Fh undefined subfunction
	    A4h access denied
	    etc.
	STACK popped (value placed in DX if no specific return value for DX)

Format of 386MAX memory speed record:
Offset	Size	Description	(Table 1169)
 00h	DWORD	page table entry for 4K page
 04h	WORD	number of microticks (840ns units) required for REP LODSD of
		  entire 4K page

Format of 386MAX memory info [array]:
Offset	Size	Description	(Table 1170)
 00h	DWORD	linear start address
 04h	DWORD	size in bytes
 08h	WORD	XMS handle (if next byte = 04h)
		??? (if next byte = 05h)
		??? (if next byte = 06h)
		??? (if next byte = 13h)
		??? (if next byte = 14h)
		??? (if next byte = 15h)
		??? (if next byte = 23h)
		??? (if next byte = 24h)
		??? (if next byte = 26h)
		else unused
 0Ah	BYTE	type
		00h = ???, 01h = VDISK,
		02h = INT 15h extended memory, 03h = ??? extended,
		04h = XMS handle's memory, 05h = ???, 06h = ???, 07h = ???,
		08h = ???, 09h = ???, 0Ah = ???, 0Bh = ???,
		11h = ???, 12h = ???, 14h = ???, 15h = ???,
		19h = ???, 1Ah = ???, 1Bh = ???,
		1Ch = ???, 1Dh = ???, 1Eh = ???, 1Fh = ???,
		20h = ???, 21h = ???, 23h = ???, 24h = ???,
		26h = ???
 0Bh	BYTE	??? (00h for types 00h-03h, 07h-0Bh, 19h-21h;
		     80h for types 04h/13h-15h/23h-26h;
			??? for type 05h)
--------V-214402-----------------------------
INT 21 - PGS1600.DEV - IOCTL - GET CONFIGURATION INFO
	AX = 4402h
	BX = file handle for device "PGS1600$"
	CX = 0018h (size of buffer)
	DS:DX -> configuration buffer (see #1171)
Return: CF clear if successful
	    buffer filled
	    AX = number of bytes actually copied
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: PGS1600.DEV is a device driver for the Cornerstone Technology PG1600
	  display adapter, which provides a 1600x1200 monochrome display as
	  well as one of two emulations, MDA or CGA.
SeeAlso: AX=4403h"PGS1600"

Format of PGS1600.DEV configuration information:
Offset	Size	Description	(Table 1171)
 00h	WORD	version (high byte = major, low byte = minor)
 02h	WORD	board initialisation mode
 04h	WORD	board I/O address
		03D0h CGA emulation
		03B0h MDA emulation
		0390h no emulation
		0350h no emulation, alternate
 06h	WORD	emulation buffer segment
		B800h	CGA emulation
		B000h	MDA emulation
		0000h	no emulation
 08h	WORD	PG1600 graphics buffer segment
 0Ah	WORD	number of bytes between consecutive graphic rows
 0Ch	WORD	horizontal pixel size
 0Eh	WORD	vertical pixel size
 10h	WORD	horizontal dots per inch
 12h	WORD	vertical dots per inch
 14h	WORD	graphics buffer bits per pixel
 16h	WORD	monitor bits per pixel
--------N-214402-----------------------------
INT 21 - PC/TCP IPCUST.SYS - RESET CONFIGURATION DATA READ POINTER
	AX = 4402h
	BX = file handle referencing device "$IPCUST"
	CX, DS:DX ignored
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	there are a total of 378h bytes of configuration data for IPCUST.SYS
	  version 2.05.	 If less than the entire data is read or written,
	  the next read/write continues where the previous one ended; this
	  call and AX=4403h both reset the location at which the next
	  operation starts to zero
	v2.1+ uses a new configuration method, but allows the installation
	  of IPCUST.SYS for backward compatibility with other software which
	  must read the PC/TCP configuration
SeeAlso: AH=3Fh"IPCUST",AH=40h"IPCUST",AX=4403h"IPCUST"
--------N-214402-----------------------------
INT 21 - WORKGRP.SYS - GET API ENTRY POINT
	AX = 4402h
	BX = file handle for device "NET$HLP$"
	CX = 0008h
	DS:DX -> buffer for entry point record (see #1172)
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code
Program: WORKGRP.SYS is the portion of Microsoft's Workgroup Connection which
	  permits communication with PCs running Windows for Workgroups or
	  LAN Manager
SeeAlso: AH=3Fh"WORKGRP.SYS"

Format of WORKGRP.SYS entry point record:
Offset	Size	Description	(Table 1172)
 00h	WORD	3633h  \ signature???
 02h	WORD	EF6Fh  /
 04h	DWORD	address of entry point (see #1173)
Note:	first four bytes of buffer must be 6Fh E9h 33h 36h on entry when using
	  IOCTL rather than READ to get the entry point record

(Table 1173)
Call WORKGRP entry point with:
	STACK:	WORD	function number (0000h-0009h)
Return: STACK unchanged
SeeAlso: #1174,#1175,#1176,#1177,#1178,#1179,#1180,#1181

(Table 1174)
Call WORKGRP function 00h with:
	STACK:	WORD	0000h (function "get ???")
Return: DX:AX -> data table

(Table 1175)
Call WORKGRP function 01h with:
	STACK:	WORD	0001h (function "hook ???")
Return: STACK:	DWORD	pointer to ???
		WORD	0001h (function number)

(Table 1176)
Call WORKGRP function 02h with:
	STACK:	WORD	0002h (function "unhook ???")
	???
Return: ???

(Table 1177)
Call WORKGRP function 03h with:
	STACK:	WORD	0003h (function "reenable printer port")
		WORD	LPT port number
Return: ???

(Table 1178)
Call WORKGRP function 04h with:
	STACK:	WORD	0004h (function "disable printer port")
		WORD	LPT port number
Return: ???

(Table 1179)
Call WORKGRP function 05h with:
	STACK:	WORD	0005h (function "???")
		???
Return: ???

(Table 1180)
Call WORKGRP function 06h with:
	STACK:	WORD	0006h (function "???")
Return: STACK unchanged
	AX = 0000h
	DX = 0000h

(Table 1181)
Call WORKGRP functions 07h-09h with:
	STACK:	WORD	0007h-0009h (NOP functions)
Return: STACK unchanged
	AX = 0001h
	DX = 0000h
--------N-214402-----------------------------
INT 21 - 10NET v5.0 - 10BEUI.DOS - API
	AX = 4402h
	BX = file handle referencing device "10BEUI$"
	DS:DX -> parameter record (see #1182)
	CX ignored
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
SeeAlso: AX=4402h"10MEMMGR",INT 6F/AH=00h"10NET"

Format of 10NET 10BEUI.DOS parameter record:
Offset	Size	Description	(Table 1182)
 00h	WORD	000Ah (function number???)
 02h	WORD	???
 04h	DWORD	pointer to buffer for ???
 08h  4 BYTEs	???
 0Ch	WORD	transfer size
--------N-214402-----------------------------
INT 21 - 10NET v5.0 - 10MEMMGR.SYS - API
	AX = 4402h
	BX = file handle referencing device "MEMMGR0$"
	DS:DX -> 6-byte buffer for interface info (see #1183)
	CX ignored
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
SeeAlso: AX=4402h"10BEUI",INT 6F/AH=00h"10NET"

Format of 10NET 10MEMMGR.SYS interface info:
Offset	Size	Description	(Table 1183)
 00h	DWORD	address of entry point (see #1184)
 04h	WORD	version (0500h for v5.00)

(Table 1184)
Call 10NET 10MEMMGR.SYS entry point with:
	AL = 01h ???
	    BX = ???
	    Return: CF clear if successful
		    CF set on error
			AX = error code
	AL = 02h ???
	    ???
	AL = 03h ???
	    ???
	AL = 04h set/restore memory allocation strategy
	    BX = subfunction
		0000h set strategy
		0001h restore strategy
	    Return: CF clear if successful
		    CF set on error (if function disabled)
		    various registers destroyed
	AL = other
	    Return: CF set
		    AX = 0000h
		    BL = 01h
--------V-214402-----------------------------
INT 21 - Compaq AG1024.SYS - RGDI - GET DRIVER LOCATION
	AX = 4402h
	BX = file handle for device "$$$$RGDI"
	CX = 0006h (size of returned data)
	DS:DX -> location record (see #1185)
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: AG1024.SYS is a device driver for the Advanced Graphics 1024 adapter
SeeAlso: AX=4403h"RGDI"

Format of Compaq AG1024.SYS location record:
Offset	Size	Description	(Table 1185)
 00h	WORD	signature 55AAh
 02h	WORD	segment of ???
 04h	WORD	segment of device driver's code
--------N-214402-----------------------------
INT 21 - FTPSOFT.DOS v3.1 - GET ???
	AX = 4402h
	BX = file handle for device "FTPSOFT$"
	CX = size of buffer
	DS:DX -> buffer for data (see #1186)
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: FTPSOFT.DOS is a device driver for Protocol Manager support from
	   FTP Software, Inc.
SeeAlso: AH=3Fh"PC/TCP",AX=4402h"NDIS"

Format of FTPSOFT.DOS data:
Offset	Size	Description	(Table 1186)
 00h	WORD	(call) BA98h (if different, no data returned)
 02h	DWORD	-> NDIS common characteristics table
		  (see #1122 at AX=4402h"NDIS")
 06h	DWORD	(call) -> new dispatch table (see #1124 at AX=4402h"NDIS")
 0Ah	DWORD	-> 28-byte buffer for ??? data
 0Eh	DWORD	???
 12h	DWORD	-> FAR function to reset dispatch jump table to defaults
 16h	BYTE	???
Note:	the addresses in the new dispatch table are copied into an internal
	  jump table which may be reset by calling the function pointed at by
	  offset 12h
--------n-214402-----------------------------
INT 21 U - PenDOS PENDEV.SYS - GET ENTRY POINTS
	AX = 4402h
	BX = file handle for device "$$PENDOS" or "$$PD_REG"
	CX = size of buffer (4 for $$PENDOS and a 4,8,12, or 16 for $$PD_REG)
	DS:DX -> buffer for entry point record (see #1187)
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: A limited version of PenDOS by Communication Intelligence Corporation,
	  which provides pen capability to keyboard-based programs, is bundled
	  with IBM DOS 6.1
SeeAlso: AX=4403h"PENDEV.SYS"

Format of PENDEV.SYS entry point record:
Offset	Size	Description	(Table 1187)
 00h	DWORD	-> array of jumps
 04h	WORD	offset of function to retrieve entry point (see #1188)
 06h  2 BYTEs	signature "Pe"
 08h	WORD	offset of function to set entry point (see #1189)
 0Ah  2 BYTEs	signature "nD"
 0Ch	WORD	offset of function to clear entry point (see #1190)
 0Eh	WORD	signature "OS"

(Table 1188)
Call PENDEV.SYS function to retrieve entry point with:
	AX = index of entry point (0-9)
Return: CF clear if successful
	    DX:AX -> desired entry point
	CF set on error (AX out of range)

(Table 1189)
Call PENDEV.SYS function to set entry point with:
	AX = index of entry point (0-9)
	DX:SI -> new handler
Return: CF clear if successful
	CF set on error (AX out of range)

(Table 1190)
Call PENDEV.SYS function to clear entry point with:
	AX = index of entry point (0-9)
Return: CF clear if successful
	CF set on error (AX out of range)
Note:	resets the jump at the specified entry point to its default target,
	  which simply returns
--------N-214402-----------------------------
INT 21 U - LAN Manager - TCPDRV.DOS - API
	AX = 4402h
	BX = file handle referencing device "TCPDRV$"
	CX = 0019h
	DS:DX -> buffer containing request block (see #1191)
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: TCPDRV.DOS is the low-level device driver supporting LAN Manager's
	  TCP/IP protocol stack

Format of TCPDRV.DOS request block:
Offset	Size	Description	(Table 1191)
 00h	BYTE	(call) function number
		00h initialize ???
		06h get ???
		07h get ???
 01h	BYTE	(call) 00h
		(ret) error code if error, unchanged if successful
 02h	WORD	signature 4354h ('CT')
---function 00h---
 04h	DWORD	(call) pointer to ??? FAR function
		function is called with ES:BX -> device driver request used to
		  invoke this function
 08h  4 BYTEs	???
 0Ch	DWORD	(call) pointer to ??? record, WORD at offset 22h is read
 10h	DWORD	(ret) -> ??? buffer if 0000h:0000h on call
---function 06h---
 04h  4 BYTEs	???
 08h	DWORD	(ret) pointer to ???
---function 07h---
 04h	DWORD	(ret) pointer to ??? record
--------y-214402-----------------------------
INT 21 U - PC Tools 9 CPRLOW.EXE - GET CODE AND DATA ADDRESSES
	AX = 4402h
	BX = file handle referencing device "RECLOWLD"
	DS:DX -> buffer for address list (see #1192)
	CX ignored
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)

Format of CPRLOW address list:
Offset	Size	Description	(Table 1192)
 00h	WORD	segment of CPRLOW code
 02h	WORD	offset in code segment of ??? entry point
		(switches into protected mode)
 04h	WORD	offset in code segment of jump array (see #1193)
 06h	WORD	segment of copy of interrupt vector table at CPRLOW load time
Note:	neither the entry point nor the jump array is valid until after a
	  CPR /LOAD, because CPR.EXE installs the code into CPRLOW at runtime.

Format of CPRLOW jump array:
Offset	Size	Description	(Table 1193)
 00h  3 BYTEs	initialize CPRLOW interrupt hooks
 03h  3 BYTEs	reset timers and enable CPR (hotkey enable)
 06h  3 BYTEs	disable CPR (hotkey disable)
 09h  3 BYTEs	clear ??? flag, hotkey disable, and ???
 0Ch  3 BYTEs	initialize delay loop counter (destroys AX,BX,CX,DX)
 0Fh  3 BYTEs	disable CPR completely (commandline /DISABLE)
 12h  3 BYTEs	enable ??? if CPR enabled by both cmdline and hotkey
 15h  3 BYTEs	enable CPR (commandline /ENABLE)
--------s-214402-----------------------------
INT 21 U - Creative Technology CTMMSYS.SYS v1.00.01 - API
	AX = 4402h
	BX = file handle for device "CTMMSYS$"
	CX = 0004h (size of data)
	DS:DX -> buffer for entry point (see #1194)
Return: CF clear if successful
	    buffer updated
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: CTMMSYS.SYS is the Creative DOS Multimedia Architecture Integration
	  driver
SeeAlso: AX=4402h"CTSB2",INT 80/BX=0000h"SBFM"

Format of CTMMSYS.SYS entry point record:
Offset	Size	Description	(Table 1194)
 00h	DWORD	(call) signature 4D6D7443h (ASCII "CtmM")
		(ret) pointer to CTMMSYS entry point (see #1195)
SeeAlso: #1196

(Table 1195)
Call CTMMSYS.SYS entry point with:
	AX = ???
	STACK:	WORD	???
		WORD	???
		WORD	??? (0001h,0002h,0005h,0006h)
		WORD	???
		DWORD	-> ???
		WORD	???
		WORD	???
Return: DX:AX = ??? or error code
		0000h:000Bh invalid value for ???
		0000h:000Fh API call already in progress
SeeAlso: #1194
--------s-214402-----------------------------
INT 21 U - Creative Technology CTSB2.SYS v1.01.01 - API
	AX = 4402h
	BX = file handle for device "CTSOUND0"
	CX = 0004h (size of data)
	DS:DX -> buffer for entry point (see #1196)
Return: CF clear if successful
	    buffer updated
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: CTMMSYS.SYS is the Creative DOS Multimedia Architecture Integration
	  driver
SeeAlso: AX=4402h"CTMMSYS",INT 80/BX=0000h"SBFM"

Format of CTSB2.SYS entry point record:
Offset	Size	Description	(Table 1196)
 00h	DWORD	(call) signature 4D6D7443h (ASCII "CtmM")
		(ret) pointer to CTSB2 entry point (see #1197)
SeeAlso: #1194

(Table 1197)
Call CTSB2.SYS entry point with:
	AX = ???
	STACK:	DWORD	-> ???
		WORD	function number
			(0100h,0200h,0300h,0400h,0500h,0600h,0701h)
		DWORD	-> ???
		WORD	???
		WORD	???
Return: DX:AX = ??? or error code
		0000h:0004h invalid subfunction???
		0000h:000Bh invalid value for ???
		0000h:000Fh API call already in progress
SeeAlso: #1196
--------m-214402-----------------------------
INT 21 U - Novell DOS 7 EMM386.EXE - GET STATE RECORD???
	AX = 4402h
	BX = file handle for device "EMMXXXX0"
	CX = 003Eh (size of state record)
	DS:DX -> buffer for state record (see #1198)
Return: CF clear if successful
	    buffer filled (see #3274 at INT 67/AH=3Fh)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)

Format of Novell DOS 7 EMM386.EXE state record:
Offset	Size	Description	(Table 1198)
 00h	WORD	signature EDC0h
 02h 60 BYTEs	???
--------m-214402SF00-------------------------
INT 21 U - Memory Managers - GET API ENTRY POINT
	AX = 4402h subfn 00h
	BX = file handle for device "EMMXXXX0"
	CX = 0006h (size of buffer in bytes)
	DS:DX -> buffer for API entry point record (see #1199)
		first byte must be 00h on entry
Return: CF clear if successful
	    buffer filled (see #3274 at INT 67/AH=3Fh)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	this function is supported by Microsoft EMM386.EXE v4.45+ and
	  CEMM v5.10+, and is intended for use by MS Windows as it starts up
	if no other program has hooked INT 67, an alternate installation
	  check for CEMM is testing for the string
	  "COMPAQ EXPANDED MEMORY MANAGER 386" at offset 14h in the INT 67
	  handler's segment; if present, the word at offset 12h contains the
	  offset of the API entry point
SeeAlso: AX=4402h/SF=01h,AX=4402h/SF=02h,AX=4402h"EMM386",INT 67/AH=3Fh

Format of memory manager API entry point record:
Offset	Size	Description	(Table 1199)
 00h	WORD	??? (0022h for CEMM 5.11, 0025h for MS EMM386 v4.45)
 02h	DWORD	manager's private API entry point
		(see #1200,#3337 at INT 67/AX=FFA5h)

(Table 1200)
Call CEMM v5.10+ entry point with:
	AH = 00h get memory manager's state
	    Return: AH = state
			bit 0: turned OFF
			bit 1: AUTO mode enabled
	AH = 01h set memory manager's state
	    AL = new state (00h ON, 01h OFF, 02h AUTO)
	    Return: CF clear if successful
		    CF set on error
	AH = 02h Weitek coprocessor support
	    AL = subfunction
		00h get Weitek support state
		    Return: AL = status
				bit 0: Weitek coprocessor is present
				bit 1: Weitek support is enabled
		01h turn on Weitek support
		02h turn off Weitek support
	    Return: CF clear if successful
		    CF set on error
			AH = error code (01h invalid subfunc, 02h no Weitek)
	AH = 05h get statistics
	    ???
	AH > 06h
	    Return: CF set
		    AH = 01h (invalid function)
Notes:	AH=03h,04h,06h are NOPs which return CF clear, presumably for backwards
	  compatibility with earlier versions of CEMM
	in v5.11, AH=05h merely prints an error message (using INT 21/AH=09h)
	  stating that a different version of CEMM is installed and it is
	  therefore not possible to display the statistics
--------m-214402SF01-------------------------
INT 21 U - Memory Managers - GET EMM IMPORT STRUCTURE ADDRESS
	AX = 4402h subfn 01h
	BX = file handle for device "EMMXXXX0"
	CX = 0006h (size of buffer in bytes)
	DS:DX -> buffer for EMM import structure record (see #1201)
		first byte must be 01h on entry
Return: CF clear if successful
	    buffer filled (see also #3274 at INT 67/AH=3Fh)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	this function is supported by Microsoft EMM386.EXE v4.45+,
	  QEMM-386 v6+, and CEMM v5.10+, and is intended for use by MS Windows
	  as it starts up
	for QEMM-386, this call always returns an error if Windows3 support
	  has been disabled with the NW3 switch
SeeAlso: AX=4402h/SF=00h,AX=4402h"EMM386",INT 2F/AX=D201h/BX=5145h
SeeAlso: INT 67/AH=3Fh

Format of EMM import structure record:
Offset	Size	Description	(Table 1201)
 00h	DWORD	physical address of EMM import structure (see #1202)
 04h	BYTE	EMM import structure major version
 05h	BYTE	EMM import structure minor version
Note:	version 1.00 contains only EMS information (Windows 3.0+)
	version 1.10 contains UMB/XMS/HMA/EMS information (Windows 3.1)
	version 1.11 is version 1.10 plus memory manager maker/product name
SeeAlso: #3314

Format of Global EMM Import record:
Offset	Size	Description	(Table 1202)
 00h	BYTE	bit flags
		bit 2: ???
		bit 3: free EMM386 virtual HMA only if hma_page_table_paddr!=0
		bit 4: no UMB???
 01h	BYTE	reserved (0)
 02h	WORD	size of structure in bytes
 04h	WORD	structure version
 06h	DWORD	reserved
 0Ah 384 BYTEs	64 EMS frame status records (see #1203), one per 16K of
		  real-mode 1M address space
18Ah	BYTE	??? (must be at least 3*number_of_EMS_frames+4)
18Bh	BYTE	number of UMB frame descriptors following
18Ch 4N DWORDs	UMB frame descriptors
		each is 4 DWORDs giving physical page numbers for the four
		  4K pages of a 16K EMS frame (00000000h if non-UMB page)
var	BYTE	number of EMS handle info records following
    16N BYTEs	EMS handle info records (see #1205)
---version 1.10+ ---
	DWORD	realmode INT 67 vector (used by Windows to set breakpoints)
	DWORD	physical address of HMA page table values
	BYTE	number of free page entries following
     2N DWORDs	free page entries
		each is:
		    DWORD	physical page number
		    DWORD	number of consecutive physical pages
	BYTE	number of XMS handle info records following
		00h if memory manager does not emulate XMS or has real mode
		  XMS code which can execute in the Windows environment
    12N BYTEs	XMS handle info records (see #1206)
	BYTE	number of free UMB info records following
     2N WORDs	free UMB info records
		each is:
		    WORD	real mode start segment
		    WORD	size in paragraphs
---version 1.11---
     20 BYTEs	blank-padded maker name
     20 BYTEs	blank-padded product name

Format of EMS frame status record:
Offset	Size	Description	(Table 1203)
 00h	BYTE	frame type (see #1204)
 01h	BYTE	owner handle (00h/FFh = none) from frame including UMB
		index to UMB frame descriptors
 02h	WORD	logical page for frame, 7FFFh if none, FFFFh if non-EMS frame
 04h	BYTE	EMS physical page number (FFh for non-EMS = don't care???)
 05h	BYTE	flags for non-EMS frames (00h for EMS frame)
		bits 0,1 for first 4K, bits 2,3 for second 4K, etc:
		  10: direct mapping (linear address = physical address)
		  01: UMB mapping

Bitfields for EMS frame type:
Bit(s)	Description	(Table 1204)
 0	EMS frame
 1	(if EMS frame) in standard 64K page frame
 2	first 4K of frame is UMB
 3	second 4K of frame is UMB
 4	third 4K of frame is UMB
 5	last 4K of frame is UMB

Format of EMS handle info record:
Offset	Size	Description	(Table 1205)
 00h	BYTE	handle number (00h = system handle)
 01h	BYTE	flags
		bit 0: normal handle rather than system handle
		bit 2: ??? (set by some EMS managers)
 02h  8 BYTEs	EMS handle's name
 0Ah	WORD	number of 16K pages for handle
 0Ch	DWORD	physical address of page table entries forming page map
Note:	all values should be zero for the system handle if no large frame
	  support is present

Format of XMS handle info record:
Offset	Size	Description	(Table 1206)
 00h	WORD	handle
 02h	WORD	flags
		bit 0: handle usable by Windows
			(already in use when Windows started if clear)
		bit 1: reserved (0)
 04h	DWORD	size in KB (may be zero, used only if flags bit 0 set)
 08h	DWORD	physical address (only if flags bit 0 set)
--------m-214402SF02-------------------------
INT 21 U - Memory Managers - GET MEMORY MANAGER VERSION
	AX = 4402h subfn 02h
	BX = file handle for device "EMMXXXX0"
	CX = 0002h (size of buffer in bytes)
	DS:DX -> buffer for memory manager version (see #1207)
		first byte must be 02h on entry
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Note:	this function is supported by Microsoft EMM386.EXE v4.45+ and
	  CEMM v5.10+, and is intended for use by MS Windows as it starts up
SeeAlso: AX=4402h/SF=00h,AX=4402h"EMM386",INT 67/AH=3Fh

Format of memory manager version:
Offset	Size	Description	(Table 1207)
 00h	BYTE	major version
 01h	BYTE	minor version (binary)
--------m-214402-----------------------------
INT 21 U - Microsoft EMM386.EXE v4.45 - GET MEMORY MANAGER INFORMATION
	AX = 4402h
	BX = file handle for device "EMMXXXX0"
	CX = size of buffer in bytes (varies, see #1208)
	DS:DX -> buffer for returned data (see #1208)
		first byte must be set on entry to indicate desired data
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	an error is returned if the number of bytes to be read does not match
	  the number of bytes returned for the specified data item
	this function is part of the interface which allows MS Windows to
	  cooperate with memory managers
SeeAlso: AX=4402h/SF=00h,AX=4402h/SF=01h,AX=4402h/SF=02h,INT 67/AX=FFA5h

Format of EMM386.EXE data buffer:
Offset	Size	Description	(Table 1208)
 00h	BYTE	(call) function
		03h get ???
		04h get ???
---function 03h---
 00h	WORD	???
 02h	WORD	???
---function 04h---
 00h	WORD	segment of UMB containing EMM386 code/data
 02h	WORD	number of paragraphs of EMM386 code/data in UMB
 04h	WORD	???
----------214402-----------------------------
INT 21 U - IFSHLP.SYS - GET ENTRY POINT
	AX = 4402h
	BX = file handle for device "IFS$HLP$"
	CX = 0008h (size of buffer in bytes)
	DS:DX -> buffer for entry point record (see #1102 at AH=3Fh"IFSHLP")
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
SeeAlso: AH=3Fh"IFSHLP"
--------D-214403-----------------------------
INT 21 - DOS 2+ - IOCTL - WRITE TO CHARACTER DEVICE CONTROL CHANNEL
	AX = 4403h
	BX = file handle referencing character device
	CX = number of bytes to write
	DS:DX -> data to write
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	format of data is driver-specific
	  (also see separate entries below for some specific cases)
	if the file handle refers to "4DOSSTAK", the 4DOS (v2.x-3.03)
	  KEYSTACK.SYS driver will push the specified characters on the
	  keyboard stack; similarly for "NDOSSTAK", the NDOS KEYSTACK.SYS
	  driver will push the characters onto the keyboard stack
	this function was not supported by Digital Research's DOS-Plus
SeeAlso: AX=4400h,AX=4402h"DOS 2+",AX=4405h"DOS",INT 2F/AX=122Bh
SeeAlso: INT 2F/AX=D44Dh,INT 2F/AX=D44Fh
--------c-214403-----------------------------
INT 21 - SMARTDRV.SYS v3.x only - IOCTL - CACHE CONTROL
	AX = 4403h
	BX = handle for device "SMARTAAR"
	CX = number of bytes to write
	DS:DX -> SMARTDRV control block (see #1210)
Return: CF clear if successful
	    AX = number of bytes actually written
		0000h if control block too small for given command
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Note:	NCache2 (from the Norton Utilities v8.0) attempts to support this
	  interface, but does not do so correctly, often hanging the system;
	  one should use the SmartDrive v4.x or NCache private interfaces
	  (see INT 2F/AX=4A10h/BX=0000h,INT 2F/AX=FE00h/DI=4E55h)
SeeAlso: AX=4402h"SMARTDRV",INT 2F/AX=4A10h/BX=0000h

(Table 1209)
Values for SMARTDRV function code:
 00h	flush cache
 01h	flush and discard cache
 02h	disable caching (flushes and discards cache first)
 03h	enable caching
 04h	control write caching
 05h	set flushing tick count
 06h	lock cache contents
 07h	unlock cache contents
 08h	set flush-on-reboot flag
 09h	unused
 0Ah	control full-track caching
 0Bh	reduce cache size
 0Ch	increase cache size
 0Dh	set INT 13 chain address

Format of SMARTDRV control block:
Offset	Size	Description	(Table 1210)
 00h	BYTE	function code (see #1209)
---functions 00h-03h,06h,07h---
 no additional fields
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
--------d-214403-----------------------------
INT 21 - CD-ROM device driver - IOCTL OUTPUT
	AX = 4403h
	BX = file handle referencing character device for CD-ROM driver
	CX = number of bytes to write
	DS:DX -> control block (see #1211)
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	some device drivers support several subunits (that is more than one
	  drive) but it is not possible to distinguish between them with this
	  function; use INT 2F/AX=1510h or INT 2F/AX=0802h instead
	under Windows95, the "mscd$$$$" device cannot be opened so you cannot
	  obtain the handle required by this function: use INT 2F/AX=1510h
	  or INT 2F/AX=0802h instead
SeeAlso: AX=4402h"CD-ROM",INT 2F/AX=0802h,INT 2F/AX=1510h

Format of CR-ROM control block:
Offset	Size	Description	(Table 1211)
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
--------D-214403-----------------------------
INT 21 U - MS-DOS 7.0 - CONFIG$ device - SET??? CONFIGURATION INFORMATION
	AX = 4403h
	BX = file handle for character device "CONFIG$"
	CX = number of bytes to write
	DS:DX -> buffer containing ???
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Note:	IOCTL Output to CONFIG$ is only available while IO.SYS is booting
	  the system; once CONFIG.SYS has been processed, this call always
	  succeeds, ignoring any input
SeeAlso: AX=4403h"CONFIG$"
--------d-214403-----------------------------
INT 21 - Brian Antoine Seagate ST-01 SCSI.SYS - IOCTL - EXECUTE COMMANDS
	AX = 4403h
	BX = handle for device "SCSITAPE"
	CX = number of bytes to write
	DS:DX -> SCSITAPE control block (see #1212)
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
SeeAlso: AX=4405h"ST-01",INT 78/AH=10h

Format of SCSITAPE control block:
Offset	Size	Description	(Table 1212)
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
--------E-214403-----------------------------
INT 21 U - AI Architects - OS/x86??? - API
	AX = 4403h
	BX = handle for device "AIA_OS"
	CX = number of bytes to write (ignored)
	DS:DX -> 12-byte buffer (see #1213), first byte is command:
		  81h installation check
		  82h get API entry point
		  84h uninstall
Return: CF clear if successful
	    AX = number of bytes actually written
	    DS:DX buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Ch,0Dh) (see #1366 at AH=59h)
Notes:	these functions are only available if the DOS extender was loaded as a
	  device driver in CONFIG.SYS
	called by TKERNEL (a licensed version of AI Architects/Ergo OS/x86)
SeeAlso: INT 2F/AX=FBA1h/BX=0081h,INT 2F/AX=FBA1h/BX=0082h
Index:	installation check;OS/x86|entry point;OS/x86|uninstall;OS/x86

Format of buffer on return:
Offset	Size	Description	(Table 1213)
 00h  4 BYTEs	signature "IABH"
---if function 81h---
 (no additional fields)
---if function 82h---
 04h	DWORD	pointer to API entry point (see INT 2F/AX=FBA1h/BX=0082h)
---if function 84h---
 04h	WORD	success indicator
 06h	WORD	segment of ???
 08h	WORD	segment of ??? memory block to free if nonzero
 0Ah	WORD	segment of ??? memory block to free if nonzero
--------V-214403-----------------------------
INT 21 - PGS1600.DEV - IOCTL - SET CONFIGURATION???
	AX = 4403h
	BX = file handle for device "PGS1600$"
	CX = 0018h (size of buffer)
	DS:DX -> configuration buffer (see #1171 at AX=4402h"PGS1600")
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: PGS1600.DEV is a device driver for the Cornerstone Technology PG1600
	  display adapter, which provides a 1600x1200 monochrome display as
	  well as one of two emulations, MDA or CGA.
SeeAlso: AX=4402h"PGS1600"
--------N-214403-----------------------------
INT 21 - PC/TCP IPCUST.SYS - RESET CONFIGURATION DATA READ POINTER
	AX = 4403h
	BX = file handle referencing device "$IPCUST"
	CX, DS:DX ignored
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	there are a total of 378h bytes of configuration data for IPCUST.SYS
	  version 2.05.	 If less than the entire data is read or written,
	  the next read/write continues where the previous one ended; this
	  call and AX=4402h both reset the location at which the next
	  operation starts to zero
	v2.1+ uses a new configuration method, but allows the installation
	  of IPCUST.SYS for backward compatibility with other software which
	  must read the PC/TCP configuration
SeeAlso: AH=3Fh"IPCUST",AH=40h"IPCUST",AX=4402h"IPCUST"
--------V-214403-----------------------------
INT 21 - Compaq AG1024.SYS - CPQ_MGES - IOCTL OUTPUT
	AX = 4403h
	BX = file handle referencing device "CPQ_MGES"
	DS:DX -> request packet (see #1214)
	CX ignored
Return: CF clear if successful
	    AX destroyed
	    data buffer filled (if applicable)
	    first word of request packet set to number of bytes of data
	      available (amount returned is smaller of this and requested
	      amount)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: AG1024.SYS is a device driver for the Advanced Graphics 1024 adapter
SeeAlso: AX=4403h"RGDI"

Format of Compaq AG1024.SYS request packet:
Offset	Size	Description	(Table 1214)
 00h	WORD	function
		0000h get ??? (26h bytes)
		0001h get ??? (36h bytes)
		0002h set ??? (same as returned by function 0001h)
		0003h get ??? (6 bytes)
		0004h get ???
		0005h get ???
		0006h get ??? (10h bytes)
		0007h set ??? (same as returned by function 0006h)
---functions 00h-03h,06h,07h---
 02h	WORD	size of data buffer
 04h	DWORD	-> buffer for function's data
 ---functions 04h,05h---
 02h	WORD	???
 04h	WORD	size of data buffer
 06h	DWORD	-> buffer to receive data
--------V-214403-----------------------------
INT 21 - Compaq AG1024.SYS - RGDI - IOCTL OUTPUT
	AX = 4403h
	BX = file handle referencing device "$$$$RGDI"
	DS:DX -> request packet (see #1215)
	CX ignored
Return: CF clear if successful
	    AX destroyed
	    data buffer filled (if applicable)
	    first word of request packet set to number of bytes of data
	      available (amount returned is smaller of this and requested
	      amount)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: AG1024.SYS is a device driver for the Advanced Graphics 1024 adapter
SeeAlso: AX=4402h"RGDI",AX=4403h"CPQ_MGES"

Format of Compaq AG1024.SYS request packet:
Offset	Size	Description	(Table 1215)
 00h	WORD	function
		0000h get entry points
		0001h get ???
 02h	DWORD	address of buffer for returned data
--------m-214403SF01-------------------------
INT 21 U - Qualitas 386MAX v6.01+ - TURN 386MAX OFF
	AX = 4403h subfn 01h
	BX = handle for device "386MAX$$"
	DS:DX -> BYTE 01h
	CX ignored
Return: DS:DX -> BYTE status (00h = successful)
	CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Note:	this function will fail if any EMS or UMBs are in use
SeeAlso: AX=4403h/SF=02h,AX=4403h/SF=03h,AX=4403h/SF=05h
--------m-214403SF02-------------------------
INT 21 U - Qualitas 386MAX v6.01+ - TURN 386MAX ON
	AX = 4403h subfn 02h
	BX = handle for device "386MAX$$"
	DS:DX -> BYTE 02h
	CX ignored
Return: DS:DX -> BYTE status (00h = successful)
	CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
SeeAlso: AX=4403h/SF=01h,AX=4403h/SF=03h,AX=4403h/SF=05h
--------m-214403SF03-------------------------
INT 21 U - Qualitas 386MAX v6.01+ - SET STATE
	AX = 4403h subfn 03h
	BX = handle for device "386MAX$$"
	CX = number of bytes to copy (up to size of state buffer)
	DS:DX -> BYTE 03h followed by state buffer
		  (see #1154 at AX=4402h"386MAX")
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Note:	the first byte of the buffer must be either 01h, 02h, or 03h
	  (specifying the version of the state record) and the buffer must
	  contain CX bytes AFTER the initial byte
SeeAlso: AX=4402h"386MAX"
--------m-214403SF05-------------------------
INT 21 U - Qualitas 386MAX v7.00+ - LIMIT AUTOMATIC ACTIVATION TO STD EMS CALLS
	AX = 4403h subfn 05h
	BX = handle for device "386MAX$$"
	DS:DX -> BYTE 05h
	CX ignored
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Desc:	specifies that 386MAX will only shift from AUTO to ON mode on standard
	  EMS calls INT 67/AH=40h-5Dh
SeeAlso: AX=4403h/SF=02h,AX=4403h/SF=03h,AX=4403h/SF=06h
--------m-214403SF06-------------------------
INT 21 U - Qualitas 386MAX v7.00+ - ALLOW AUTOMATIC ACTIVATION ON ANY INT 67
	AX = 4403h subfn 06h
	BX = handle for device "386MAX$$"
	DS:DX -> BYTE 06h
	CX ignored
Return: CF clear if successful
	    AX destroyed
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Desc:	specified that 386MAX should shift from AUTO to ON mode on any INT 67
	  call other than INT 67/AH=3Fh
SeeAlso: AX=4403h/SF=01h,AX=4403h/SF=03h,AX=4403h/SF=05h
--------n-214403-----------------------------
INT 21 U - PenDOS PENDEV.SYS - ???
	AX = 4403h
	BX = file handle for device "$$PENDOS" or "$$PD_REG"
	CX = size of buffer
	DS:DX -> buffer containing ???
Return: CF clear if successful
	    buffer filled
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: A limited version of PenDOS by Communication Intelligence Corporation,
	  which provides pen capability to keyboard-based programs, is bundled
	  with IBM DOS 6.1
Note:	this call sets the WORD at offset 1Ah into the device driver request
	  header used to call the driver to 0000h.
SeeAlso: AX=4402h"PENDEV.SYS"
--------D-214404-----------------------------
INT 21 - DOS 2+ - IOCTL - READ FROM BLOCK DEVICE CONTROL CHANNEL
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc.)
	CX = number of bytes to read
	DS:DX -> buffer
Return: CF clear if successful
	    AX = number of bytes actually read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	format of data is driver-specific
	this function was not supported by Digital Research's DOS-Plus
SeeAlso: AX=4402h"DOS 2+",AX=4405h"DOS",INT 2F/AX=122Bh
--------k-214404-----------------------------
INT 21 - Stacker - GET DEVICE DRIVER ADDRESS AND SET VOLUME NUMBER
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc.)
	CX = 0004h
	DS:DX -> DWORD buffer to receive device driver address
Return: buffer filled with pointer into Stacker device driver (see #2238):
	  driver + 19h if Stacker Anywhere controls this drive
	  driver + 1Ah if Stacker controls this drive
	  unchanged else
Notes:	in addition to returning the address of the Stacker device driver,
	  this call also sets the volume number at offset 58h in the device
	  driver (see #2238 at INT 25/AX=CDCDh)
	Stacker Anywhere does not link its built-in device driver into
	  the standard device driver chain, but it can be found via CDS/DPB
	this call can be used as an installation check for all versions of
	  Stacker and Stacker Anywhere to avoid the INT 25 call
SeeAlso: AX=4408h,AX=440Eh,AH=52h,INT 25/AX=CDCDh
--------k-214404-----------------------------
INT 21 - Stacker - GET STACVOL FILE SECTORS
	AX = 4404h
	BL = drive number (0 is current drive)
	CX = byte count (i.e., 200h = 1 sector)
	DS:DX -> buffer (see #1216)
Return: Data Buffer contains the number of sectors requested from the
	  STACVOL physical file for the drive specified.

Format of Stacker buffer:
Offset	Size	Description	(Table 1216)
 00h	WORD	01CDh
 02h	WORD	sector count
 04h	DWORD	number of starting sector
 08h	DWORD	far pointer to Data Buffer
--------k-214404-----------------------------
INT 21 - DUBLDISK.SYS v2.6 - GET INFO
	AX = 4404h
	BL = drive number of DoubleDisk drive (00h = default, 01h = A:, etc.)
	CX = number of bytes (000Ah-0014h, call ignored otherwise)
	DS:DX -> data record (see #1217)
Return: CF clear if successful
	    AX = number of bytes read
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: DUBLDISK.SYS is the device driver portion of DoubleDisk, a disk
	  expander by Vertisoft Systems, Inc.
Note:	the installation check for v2.6 consists of scanning memory for the
	  signature "FAT 2.6  byte:", which is immediately followed by a data
	  table (see #1218)
BUG:	VOPT (a disk optimizer by Golden Bow Software) assumes that any driver
	  which returns the "correct" number of bytes when the first word of
	  the buffer for the data record contains the signature value 4444h is
	  DoubleDisk; a workaround is for the non-DoubleDisk driver to return
	  no data if the signature is present
SeeAlso: AX=440Dh"DOS 3.2+"
Index:	installation check;DUBLDISK.SYS

Format of DUBLDISK data record:
Offset	Size	Description	(Table 1217)
 00h	WORD	(call) signature 4444h
 02h	BYTE	(call) function
			00h ???
			01h ???
---function 00h---
 02h	BYTE	(ret) ???
 03h	BYTE	(ret) ???
---function 01h---
 02h	WORD	(ret) 4444h
 04h	WORD	allocation unit size???
 06h	WORD	???
 08h	WORD	???
 0Ah	BYTE	???

Format of DUBLDISK signature data table:
Offset	Size	Description	(Table 1218)
 00h  5 BYTEs	???
 05h	BYTE	first drive number
 06h	BYTE	number of drives
 07h	???
--------k-214404-----------------------------
INT 21 - DBLSPACE.BIN - IOCTL - FLUSH OR INVALIDATE INTERNAL CACHES
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = 000Ah (size of DSPACKET structure)
	DS:DX -> DSPACKET structure (see #1219)
Return: CF clear if IOCTL successful -- check DSPACKET for actual status
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
SeeAlso: AX=4405h"DBLSPACE",INT 2F/AX=4A11h/BX=0000h

Format of DoubleSpace DSPACKET structure:
Offset	Size	Description	(Table 1219)
 00h	WORD	signature 444Dh ("DM")
 02h	BYTE	command code
		46h ('F') flush internal caches
		49h ('I') flush and invalidate internal caches
 03h	WORD	result code
		(ret) 4F4Bh ("OK") if successful, else unchanged
 05h  5 BYTEs	padding
--------k-214404-----------------------------
INT 21 - DBLSPACE.BIN v6.2 - IOCTL - GET ??? FOR SPECIFIED DRIVE
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = size of DSPACKET structure (ignored in DOS 6.2)
	DS:DX -> DSPACKET structure (see #1220)
Return: CF clear if IOCTL successful -- check DSPACKET for actual status
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
SeeAlso: AX=4405h"DBLSPACE",INT 2F/AX=4A11h/BX=0000h

Format of DoubleSpace DSPACKET structure:
Offset	Size	Description	(Table 1220)
 00h	WORD	signature 444Dh ("DM")
 02h	BYTE	command code
		53h ('S') get ??? for specified drive
 03h	WORD	result code
		(ret) 4F4Bh ("OK") if successful, else unchanged
 05h	DWORD	(ret) pointer to 96-byte ??? data
 09h	DWORD	(ret) pointer to ??? data
 0Dh  3 BYTEs	reserved
--------k-214404-----------------------------
INT 21 U - DoubleTools v1.0 - GET ???
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = 0006h
	DS:DX -> DoubleTools structure (see #1221)
Return: CF clear if IOCTL successful -- check DSPACKET for actual status
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Note:	the Transporter device driver has the signature 55h 61h 50h 74h
	  ("DaPt") twelve bytes after it beginning

Format of DoubleTools structure:
Offset	Size	Description	(Table 1221)
 00h	WORD	(call) signature 55h AAh
		(ret) signature 78h 70h ("xp")
 02h	WORD	(call) signature 52h 16h
		(ret) ???
 04h	WORD	(ret) segment of driver's DS (same as its PSP)
--------d-214404-----------------------------
INT 21 U - xDISK v3.31 - CONFIGURE
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = 0047h (length of version string)
	DS:DX -> 79-byte buffer for version string and ???
	DS:0081h = commandline containing new switches for driver
Return: CF clear if successful
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: xDISK is a shareware resizeable EMS RAMdisk by FM de Monasterio
SeeAlso: AX=4405h"xDISK",INT 2F/AH=DDh/BX=7844h"xDISK"
--------c-214404-----------------------------
INT 21 - COMBI-disk v1.13 - GET DATA RECORD
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = 0032h (length of data packet)
	DS:DX -> buffer for data packet (see #1222)
Return: CF clear if successful
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: COMBI-disk is a shareware combination cache and RAMdisk sharing a
	  single pool of memory by Vadim V. Vlasov
Note:	the installation check consists of scanning the valid drives for one
	  which returns a correctly-sized data packet with the proper
	  signature in the first field
SeeAlso: AX=4405h"COMBI"
Index:	installation check;COMBI-disk

Format of COMBI-disk data packet:
Offset	Size	Description	(Table 1222)
 00h  6 BYTEs	ASCIZ signature "COMBI"
 06h	WORD	version (high byte = major, low = decimal minor version)
 08h	BYTE	current options
 09h	BYTE	sectors per allocation block
 0Ah	WORD	maximum buffer in KB
 0Ch	WORD	current buffer in KB (less than max if XMS memory being lent)
 0Eh	WORD	total number of allocation blocks
 10h	WORD	current number of allocation blocks
 12h	WORD	number of blocks being used by RAM disk
 14h	WORD	number of blocks being used by cache or unused
 16h	WORD	number of dirty cache blocks
 18h	WORD	number of blocks which could not be written out due to errors
 1Ah	WORD	total number of read requests
 1Ch	WORD	total number of sectors read
 1Eh	WORD	number of BIOS read requests (cache misses)
 20h	WORD	number of sectors read via BIOS (cache misses)
 22h	WORD	total number of write requests
 24h	WORD	total number of sectors written
 26h	WORD	number of BIOS write requests
 28h	WORD	number of sectors written via BIOS
 2Ah	WORD	number of RAM disk read requests
 2Ch	WORD	number of sectors read from RAM disk
 2Eh	WORD	number of RAM disk write requests
 30h	WORD	number of sectors written to RAM disk
--------d-214404-----------------------------
INT 21 - SFS v1.00 - GET CONFIGURATION INFORMATION
	AX = 4404h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = 001Ah (length of data packet)
	DS:DX -> buffer for data packet (see #1223)
Return: CF clear if successful
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: SFS (Secure FileSystem) is a shareware encrypting disk driver by
	  Peter C. Gutmann
SeeAlso: AX=4405h"SFS"

Format of SFS data packet:
Offset	Size	Description	(Table 1223)
 00h  4 BYTEs	signature string "SFS1"
 04h	WORD	SFS unit number (0-based)
 06h	WORD	drive on which the SFS volume is mounted
 08h	DWORD	sector offset of logical volume from start of physical volume
		0 if logical volume = physical volume
 0Ch	WORD	flag: 00h = no disk mounted, 01h = disk mounted
 0Eh	WORD	flag: 00h read/write, 01h read-only
 10h	WORD	quick-unmount hotkey
		(high byte = shift state, low = scan code) (see #0005)
 12h	WORD	auto-unmount time in minutes, or 0000h if already expired, or
		FFFFh if not set
 14h	WORD	time in minutes remaining before auto-unmount
 16h	WORD	internal driver check code
		0000h no error
		0001h driver consistency check failed
		0002h unit consistency check failed
 18h	WORD	disk access mode
		0000h BIOS
		0001h IDE direct access
		0002h SCSI direct access
--------D-214405-----------------------------
INT 21 - DOS 2+ - IOCTL - WRITE TO BLOCK DEVICE CONTROL CHANNEL
	AX = 4405h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = number of bytes to write
	DS:DX -> data to write
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	format of data is driver-specific
	this function was not supported by Digital Research's DOS-Plus
SeeAlso: AX=4403h"DOS",AX=4404h"DOS",INT 2F/AX=122Bh
--------d-214405-----------------------------
INT 21 - Brian Antoine Seagate ST-01 SCSI.SYS - IOCTL - EXECUTE COMMANDS
	AX = 4405h
	BX = drive number (00h = default, 01h = A:, etc)
	CX = number of bytes to write
	DS:DX -> SCSIDISK control block (see also #1212 at AX=4403h"ST-01")
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
SeeAlso: AX=4403h"ST-01"
--------k-214405-----------------------------
INT 21 U - DBLSPACE.BIN - IOCTL - FLUSH OR INVALIDATE INTERNAL CACHES
	AX = 4405h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = 000Ah (size of DSPACKET structure)
	DS:DX -> DSPACKET structure (see #1224)
Return: CF clear if IOCTL successful -- check DSPACKET for actual status
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Note:	this call is identical to the documented AX=4404h
SeeAlso: AX=4404h"DBLSPACE",INT 2F/AX=4A11h/BX=0000h

Format of DoubleSpace DSPACKET structure:
Offset	Size	Description	(Table 1224)
 00h	WORD	signature 444Dh ("DM")
 02h	BYTE	command code
		46h ('F') flush internal caches
		49h ('I') flush and invalidate internal caches
 03h	WORD	result code
		(ret) 4F4Bh ("OK") if successful, else unchanged
 05h  5 BYTEs	padding
--------d-214405-----------------------------
INT 21 U - xDISK v3.31 - ???
	AX = 4405h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = number of bytes to write
	DS:DX -> buffer containing version string
	???
Return: CF clear if successful
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: xDISK is a shareware resizeable EMS RAMdisk by FM de Monasterio
SeeAlso: AX=4404h"xDISK",INT 2F/AH=DDh/BX=7844h"xDISK"
--------d-214405-----------------------------
INT 21 - COMBI-disk v1.13 - CONTROL COMBI-disk
	AX = 4405h
	BL = drive number (00h = default, 01h = A:, etc) for RAM disk
	CX = number of bytes to write
	DS:DX -> buffer containing command packet (see #1226)
Return: CF clear if successful
	    AX = number of bytes actually transferred
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
SeeAlso: AX=4404h"COMBI"

(Table 1225)
Values for COMBI-disk command code:
 80h	flush cache
 81h	change options byte
 82h	shrink memory
 83h	expand memory
 84h	get dirty block information
 85h	reset write errors
 86h	reset counters

Format of COMBI-disk command packet:
Offset	Size	Description	(Table 1226)
 00h	WORD	version
 02h	BYTE	command code (see #1225)
---command code 80h---
 no additional fields
---command code 81h---
 03h	BYTE	new options byte (see #1227)
---command code 82h---
 03h	WORD	number of KB to release
---command code 83h---
 03h	WORD	number of KB to expand
---command code 84h---
 03h	DWORD	-> buffer for block info (see #1228)
---command code 85h---
 03h	DWORD	block ID
---command code 86h---
 03h	BYTE	which counters to reset
		bit 0: hard disk read counts
		bit 1: hard disk write counts
		bit 2: RAM disk read/write counts
Note:	multiple commands may be placed in a single packet by stringing
	  together as many command/argument pairs as desired

Bitfields for COMBI-disk options byte:
Bit(s)	Description	(Table 1227)
 0	cache off
 1	cache frozen
 2	write caching enabled
 3	delayed writing disabled
 5	fix memory allocation (no XMS lending)
 6	no 'sector not found' error

Format of COMBI-disk block info:
Offset	Size	Description	(Table 1228)
 00h	DWORD	block ID
 04h	BYTE	bitmask of valid sectors in block
 05h	BYTE	bitmask of dirty sectors in block
 06h	BYTE	last error returned by BIOS
 07h	BYTE	number of errors
--------D-214405-----------------------------
INT 21 - SFS v1.00 - DRIVER CONTROL
	AX = 4405h
	BL = drive number (00h = default, 01h = A:, etc)
	CX = number of bytes to write
	DS:DX -> data to write (see #1230)
Return: CF clear if successful
	    AX = number of bytes actually written
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Program: SFS (Secure FileSystem) is a shareware encrypting disk driver by
	  Peter C. Gutmann
SeeAlso: AX=4404h"SFS"

(Table 1229)
Values for SFS control function:
 00h	"PACKET_SET_DISKINFO"	 set disk parameters
 01h	"PACKET_SET_KEYINFO"	 set keying information
 02h	"PACKET_SET_READONLY"	 select read/write or read-only
 03h	"PACKET_SET_DRIVENO"	 set drive number to mount
 04h	"PACKET_SET_MOUNTSTATUS" set mount status
 05h	"PACKET_SET_UNMOUNT"	 set/clear quick-unmount hotkey
 06h	"PACKET_SET_TIMEOUT"	 set/clear auto-unmount timeout

Format of SFS control data packet:
Offset	Size	Description	(Table 1230)
 00h	WORD	signature 4330h ('C0')
 02h	WORD	function (see #1229)
---function 00h---
 04h	WORD	sector size in bytes
 06h	BYTE	sectors per cluster
 07h	WORD	number of boot sectors
 09h	BYTE	number of copies of FAT
 0Ah	WORD	size of root directory in entries
 0Ch	WORD	number of sectors on disk, 16-bit
 0Eh	BYTE	media descriptor byte
 0Fh	WORD	sectors per FAT
 11h	WORD	sectors per track
 13h	WORD	number of heads
 15h	DWORD	number of hidden sectors
 19h	DWORD	number of sectors on disk, 32-bit
---function 01h---
 04h 20 BYTEs	master IV for encrypted disk
 18h 64 BYTEs	NDC/SHS keying information
---function 02h---
 04h	WORD	read-only state: 00h read-only, 01h read/write
---function 03h---
 04h	WORD	drive number (see #1231)
 06h	DWORD	sector offset of logical volume from start of physical volume
		0 if logical volume = physical volume
---function 04h---
 04h	WORD	mount status (00h unmounted, 01h mounted)
---function 05h---
 04h	WORD	hotkey (high byte = shift state, low byte = scan code or 00h)
		(see #0005)
		0000h to disable hotkey
---function 06h---
 04h	WORD	timeout in minutes before automatic unmount
		0000h to disable auto-unmount
Notes:	the data for function 00h corresponds to a DOS BPB (see AH=53h)
	functions 00h, 01h, and 03h automatically unmount the encrypted drive
	unmounting a drive with function 04h also destroys the encryption
	  information in the driver and forces all dirty buffers to be flushed

Bitfields for SFS drive number:
Bit(s)	Description	(Table 1231)
 15-12	drive access mode
	0000 BIOS access
	0001 direct IDE access
	0010 direct SCSI access
---if BIOS access---
 11-8	unused (0)
 7-0	BIOS drive number
---if IDE access---
 11-8	unused (0)
 7-0	IDE drive number
---if SCSI access---
 11-8	SCSI host number
 7-4	SCSI target ID
 3-0	SCSI logical unit number
--------D-214406-----------------------------
INT 21 - DOS 2+ - IOCTL - GET INPUT STATUS
	AX = 4406h
	BX = file handle
Return: CF clear if successful
	    AL = input status
		00h not ready (device) or at EOF (file)
		FFh ready
	    AH may be destroyed (refer to note)
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	files may not register as being at EOF if positioned there by AH=42h
	under DOS 5.0, on a successful return, AH contains either the next
	  character which will be read or 1Ah if at EOF; under a Windows95
	  DOS box, AH seems to be either unchanged or 00h
	this function was not supported by Digital Research's DOS-Plus
BUG:	the CLOCK$ device under DR DOS 3.41 always indicates 'Ready'; this was
	  corrected in v5.0
SeeAlso: AX=4407h,INT 2F/AX=122Bh
--------D-214407-----------------------------
INT 21 - DOS 2+ - IOCTL - GET OUTPUT STATUS
	AX = 4407h
	BX = file handle
Return: CF clear if successful
	    AL = input status
		00h not ready
		FFh ready
	CF set on error
	    AX = error code (01h,05h,06h,0Dh) (see #1366 at AH=59h/BX=0000h)
Notes:	for DOS 2+, files are always ready for output, even if the disk is
	  full or no media is in the drive
	this function was not supported by Digital Research's DOS-Plus
SeeAlso: AX=4406h,INT 2F/AX=122Bh
--------D-214408-----------------------------
INT 21 - DOS 3.0+ - IOCTL - CHECK IF BLOCK DEVICE REMOVABLE
	AX = 4408h
	BL = drive number (00h = default, 01h = A:, etc)
Return: CF clear if successful
	    AX = media type (0000h removable, 0001h fixed)
	CF set on error
	    AX = error code (01h,0Fh) (see #1366 at AH=59h/BX=0000h)
Notes:	in addition to the normal operation, if Stacker is installed, this
	  call also sets the volume number at offset 58h in the Stacker
	  device driver (except under DR DOS 3.41-5.0, which do not pass
	  through this call to the driver; use AX=440Eh instead)
	  (see AX=4404h"Stacker",AX=440Eh,INT 25/AX=CDCDh)
	this function was not supported by Digital Research's DOS-Plus
SeeAlso: AX=4400h,AX=4404h"Stacker",AX=4409h,INT 2F/AX=122Bh
--------D-214409-----------------------------
INT 21 - DOS 3.1+ - IOCTL - CHECK IF BLOCK DEVICE REMOTE
	AX = 4409h
	BL = drive number (00h = default, 01h = A:, etc)
Return: CF clear if successful
	    DX = device attribute word
		bit 15: drive is SUBSTituted
		bit 13: (DR DOS 3.41/5.0 local drives only) always set
			media ID needed
		bit 12: drive is remote
		bit  9: direct I/O not allowed
	CF set on error
	    AX = error code (01h,0Fh) (see #1366 at AH=59h/BX=0000h)
Notes:	on local drives, DX bits not listed above are the attribute word from
	  the device driver header (see #1332 at AH=52h); for remote drives,
	  the other bits appear to be undefined for MS-DOS versions prior to
	  5.0 (they are all cleared in DOS 5+)
	checking whether DX=0800h on return appears to be a fairly reliable
	  method for detecting Microsoft's RAMDRIVE, though not for other
	  ramdisks (there appears to be no simple yet foolproof method for
	  detecting ramdisks, although the presence of only a single copy of
	  the FAT and only a single head on non-removable devices is a fairly
	  good indicator); for Windows95, RAMDRIVE returns DX=4800h
	this function was not supported by Digital Research's DOS-Plus
SeeAlso: AX=4400h,AX=4408h,AX=440Ah,INT 2F/AX=122Bh
--------D-21440A-----------------------------
INT 21 - DOS 3.1+ - IOCTL - CHECK IF HANDLE IS REMOTE
	AX = 440Ah
	BX = handle
Return: CF clear if successful
	    DX = attribute word (as stored in SFT)
		bit 15: set if remote
		bit 14: date/time not set on close
	CF set on error
	    AX = error code (01h,06h) (see #1366 at AH=59h/BX=0000h)
Notes:	if file is remote, Novell Advanced NetWare 2.0 returns the number of
	  the file server on which the handle is located in CX
	DR DOS 3.41 and 5.0 clear all bits of DX except bit 15; Novell DOS 7
	  fully supports this function
	this function was not supported by Digital Research's DOS-Plus
SeeAlso: AX=4400h,AX=4409h,AH=52h,INT 2F/AX=122Bh
--------D-21440B-----------------------------
INT 21 - DOS 3.1+ - IOCTL - SET SHARING RETRY COUNT
	AX = 440Bh
	CX = pause between retries (default 1)
	DX = number of retries (default 3)
Return: CF clear if successful
	CF set on error
	    AX = error code (01h) (see #1366 at AH=59h/BX=0000h)
Notes:	delay is dependent on processor speed (value in CX specifies number of
	  64K-iteration empty loops to execute)
	if DX=0000h on entry, the retry count is left unchanged
	this function was not supported by Digital Research's DOS-Plus
SeeAlso: AH=52h,INT 2F/AX=1224h,INT 2F/AX=122Bh
--------D-21440C-----------------------------
INT 21 - DOS 3.2+ - IOCTL - GENERIC CHARACTER DEVICE REQUEST
	AX = 440Ch
	BX = device handle
	CH = category code (see #1232)
	CL = function number (see #1233)
	DS:DX -> parameter block (see #1234,#1235,#1236,#1237,#1238,#1239)
	SI = parameter to pass to driver (European MS-DOS 4.0, OS/2 comp box)
	DI = parameter to pass to driver (European MS-DOS 4.0, OS/2 comp box)
Return: CF set on error
	    AX = error code (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
	    DS:DX -> iteration count if CL=65h
	    SI = returned value (European MS-DOS 4.0, OS/2 comp box)
	    DI = returned value (European MS-DOS 4.0, OS/2 comp box)
Note:	DR DOS 3.41 and 5.0 return error code 16h on CL=45h,65h if the device
	  does not support a retry counter
SeeAlso: AX=440Dh"DOS 3.2+",INT 2F/AX=0802h,INT 2F/AX=122Bh,INT 2F/AX=14FFh
SeeAlso: INT 2F/AX=1A01h

(Table 1232)
Values for IOCTL category code:
 00h	unknown (DOS 3.3+)
 01h	COMn: (DOS 3.3+)
 03h	CON (DOS 3.3+)
 05h	LPTn:
 9Eh	Media Access Control driver (STARLITE)
 00h-7Fh reserved for Microsoft
 80h-FFh reserved for OEM/user-defined

(Table 1233)
Values for generic character IOCTL function:
 00h	MAC driver Bind (STARLITE) (see #1234)
 45h	set iteration (retry) count (see #1235)
 4Ah	select code page (see #1236)
 4Ch	start code-page preparation (see #1237)
 4Dh	end code-page preparation (see #1238)
 5Fh	set display information (DOS 4.0+) (see #1239)
 65h	get iteration (retry) count
 6Ah	query selected code page (see #1236)
 6Bh	query prepare list (see #1240)
 7Fh	get display information (DOS 4.0+) (see #1239)
Note:	bit assignments for function code:
	    bit 7: set to ignore if unsupported, clear to return error
	    bit 6: set if passed to driver, clear if intercepted by DOS
	    bit 5: set if queries data from device, clear if sends command
	    bits 4-0: subfunction

Format of parameter block for function 00h:
Offset	Size	Description	(Table 1234)
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
Offset	Size	Description	(Table 1235)
 00h	WORD	number of times output is attempted before driver assumes
		  device is busy

Format of parameter block for functions 4Ah and 6Ah:
Offset	Size	Description	(Table 1236)
 00h	WORD	length of data
 02h	WORD	code page ID (see #1446 at INT 21/AX=6602h)
 04h 2N BYTEs	DCBS (double byte character set) lead byte range
		  start/end for each of N ranges (DOS 4.0)
	WORD	0000h  end of data (DOS 4.0)

Format of parameter block for function 4Ch:
Offset	Size	Description	(Table 1237)
 00h	WORD	flags
		DISPLAY.SYS = 0000h
		PRINTER.SYS bit 0 clear to prepare downloaded font, set to
			prepare cartridge selection
 02h	WORD	length of remainder of parameter block
 04h	WORD	number of code pages following
 06h  N WORDs	code page 1,...,N

Format of parameter block for function 4Dh:
Offset	Size	Description	(Table 1238)
 00h	WORD	length of data
 02h	WORD	code page ID (see #1446 at INT 21/AX=6602h)

Format of parameter block for functions 5Fh and 7Fh:
Offset	Size	Description	(Table 1239)
 00h	BYTE	level (0 for DOS 4.x-6.0)
 01h	BYTE	reserved (0)
 02h	WORD	length of following data (14)
 04h	WORD	control flags
		bit 0 set for blink, clear for intensity
		bits 1-15 reserved
 06h	BYTE	mode type (1=text, 2=graphics)
 07h	BYTE	reserved (0)
 08h	WORD	colors
		0000h = monochrome
		else N bits per pixel
 0Ah	WORD	pixel columns
 0Ch	WORD	pixel rows
 0Eh	WORD	character columns
 10h	WORD	character rows

Format of parameter block for function 6Bh:
Offset	Size	Description	(Table 1240)
 00h	WORD	length of following data
 02h	WORD	number of hardware code pages
 04h  N WORDs	hardware code pages 1,...,N
	WORD	number of prepared code pages
      N WORDs	prepared code pages 1,...,N
--------d-21440C-----------------------------
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
	DS:DX -> parameter block (see #1241,#1242)
Return: CF set on error
	    AX = error code (see #1366 at AH=59h/BX=0000h)
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

Format of ASPITAPE.SYS mtop parameter block:
Offset	Size	Description	(Table 1241)
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

Format of ASPITAPE.SYS mtget parameter block:
Offset	Size	Description	(Table 1242)
 00h	BYTE	ASPI host ID
 01h	BYTE	SCSI target ID
 02h	BYTE	SCSI logical unit number
 03h	BYTE	device parameters
		bit 0: drive must use fixed-block read and write
		bit 7: drive is an ASPI device
 04h	BYTE	current device state (see #1243)
 05h	BYTE	unit number within driver
 06h	WORD	fixed block blocksize
 08h	BYTE	last SCSI status
 09h	BYTE	last SCSI sense key
 0Ah	WORD	last SCSI opcode (packed) (see #1244)
 0Ch	WORD	residual bytes from SCSI opcode

Bitfields for ASPITAPE.SYS current device state:
Bit(s)	Description	(Table 1243)
 0	device currently opened in buffered mode
 1	drive currently opened in nonbuffered mode
 2	rewind drive on last close
 3	drive has been written on
 4	drive has been read from
 5	next read will return 0 bytes
 6	EOM will resemble EOF
 7	drive may be busy rewinding

Bitfields for SCSI opcode:
Bit(s)	Description	(Table 1244)
 0-7	SCSI operation (SCSI packet byte 0)
 8-10	SCSI flags (SCSI packet byte 1)
 11-12	ASPI "Direction Bits" (ASPI SRB byte 3)
--------D-21440D-----------------------------
INT 21 - DOS 3.2+ - IOCTL - GENERIC BLOCK DEVICE REQUEST
	AX = 440Dh
	BL = drive number (00h=default,01h=A:,etc)
	CH = category code (see #1245)
	CL = minor code (function) (see #1246)
	DS:DX -> (DOS) parameter block (see #1247,#1249,#1250,#1251,#1252)
	SI:DI -> (OS/2 comp box) parameter block (see #1253,#1255,#1256,#1259)
Return: CF set on error
	    AX = error code (01h,02h,etc.) (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
	    DS:DX -> data block if CL=60h or CL=61h
Notes:	DOS 4.01 seems to ignore the high byte of the number of directory
	  entries in the BPB for diskettes.
	functions 46h and 66h undocumented in DOS 4.x, documented for DOS 5+
	the DUBLDISK.SYS v2.6 driver only supports minor codes 60h and 67h
	DR DOS 3.41-6.0 only support minor codes 40h-42h and 60h-62h; all
	  other minor codes return error code 16h
	some PCMCIA calls reportedly appear to be dangerous for MS-DOS versions
	  prior to 5.0
	minor code 60h normally produces no I/O except with AutoMount=1 for
	  DBLSPACE/DRVSPACE
SeeAlso: AX=440Ch,AX=440Dh/CX=084Ah,AX=440Dh/CX=0871h,AH=69h,INT 2F/AX=0802h
SeeAlso: INT 2F/AX=122Bh

(Table 1245)
Values for block device IOCTL category code:
 08h	disk drive
 48h	FAT32 disk drive
 00h-7Fh reserved for Microsoft
 80h-FFh reserved for OEM/user-defined

(Table 1246)
Values for generic block IOCTL minor code:
 00h	(OS/2)	\ used to lock/unlock a drive
 01h	(OS/2)	/
 40h	set device parameters (see #1247)
 41h	write logical device track (see #1249)
 42h	format and verify logical device track (see #1250)
 46h	(DOS 4.0+) set volume serial number (see #1252,AH=69h)
 47h	(DOS 4.0+) set access flag (see #1253)
 48h	(Enh. Disk Drive Spec) set media lock state (see #1254,INT 13/AH=45h)
 49h	(Enh. Disk Drive Spec) eject media in drive (see INT 13/AH=49h)
	no parameter block required
 4Ah	(MS-DOS 7.0) lock logical volume (see AX=440Dh/CX=084Ah)
 4Bh	(MS-DOS 7.0) lock physical volume (see AX=440Dh/CX=084Bh)
 50h	(PCMCIA) attribute memory write
 51h	(PCMCIA) common memory write
 52h	(PCMCIA) force media change (DOS 5+ ???) (see #1255)
 53h	(PCMCIA) erase drive
 54h	(PCMCIA) erase media
 56h	(PCMCIA) set erase status callback
 57h	(PCMCIA) append Card Information Structure (CIS) tuple
 58h	(PCMCIA) erase CIS tuples
 60h	get device parameters (see #1247)
 61h	read logical device track (see #1249)
 62h	verify logical device track (see #1251)
 66h	(DOS 4.0+) get volume serial number (see #1252,AH=69h)
 67h	(DOS 4.0+) get access flag (see #1253)
 68h	(DOS 5.0+) sense media type (see #1256)
 6Ah	(MS-DOS 7.0) unlock logical volume (see AX=440Dh/CX=086Ah)
	no parameter block required
 6Bh	(MS-DOS 7.0) unlock physical volume (see AX=440Dh/CX=086Bh)
	no parameter block required
 6Ch	(MS-DOS 7.0) get lock flag (see AX=440Dh/CX=086Ch)
	no parameter block required
 6Dh	(MS-DOS 7.0) enumerate open files (see AX=440Dh/CX=086Dh)
 6Eh	(MS-DOS 7.0) find swap file (see AX=440Dh/CX=086Eh)
 6Fh	(MS-DOS 7.0) get drive map information (see #1257)
 70h	(PCMCIA) attribute memory read
 70h	(MS-DOS 7.0) get current lock state (see AX=440Dh/CX=0870h)
	no parameter block required
 71h	(MS-DOS 7.0) get first cluster (see AX=440Dh/CX=0871h)
 73h	(PCMCIA) get memory media information (DOS 5+ ???) (see #1259)
 76h	(PCMCIA) get erase status callback
 77h	(PCMCIA) get first Card Information Structure (CIS) tuple
 78h	(PCMCIA) get next CIS tuple
 7Fh	(PCMCIA) get ??? information (see #1260,#1261)

Format of parameter block for functions 40h, 60h:
Offset	Size	Description	(Table 1247)
 00h	BYTE	special functions
		bit 0 set if function to use current BPB, clear if Device
			  BIOS Parameter Block field contains new default BPB
		bit 1 set if function to use track layout fields only
			must be clear if CL=60h
		bit 2 set if all sectors in track same size (should be set)
		bits 3-7 reserved (MS-DOS, Novell DOS 7)
		bit 5: skip head settling time (WinDOS 2.11)
		bit 6: format access flag (WinDOS 2.11)
 01h	BYTE	device type (see #1248)
 02h	WORD	device attributes
		bit 0 set if nonremovable medium
		bit 1 set if door lock ("changeline") supported
		bits 2-15 reserved
 04h	WORD	number of cylinders
 06h	BYTE	media type
		for 1.2M drive
		    00h 1.2M disk (default)
		    01h 320K/360K disk
		F8h for DUBLDISK.SYS v2.6 expanded drives
		always 00h for other drive types
 07h 31 BYTEs	device BPB (see #1349 at AH=53h), bytes after BPB offset 1Eh
		  omitted; final six bytes only transferred on function 40h
		  with BYTE 00h bit 0 set for MS-DOS 5.0
---function 40h only---
 26h	WORD	number of sectors per track (start of track layout field)
		(maximum 63)
 28h  N word pairs: number,size of each sector in track
---category code 48h (FAT32), function 40h---
 07h 53 BYTEs	extended BPB (see #1350)
 3Ch 32 BYTEs	reserved
 5Ch	WORD	number of track table entries
 5Eh 2N WORDs	sector table (word pairs: number/size of each sector in track)
---category code 48h (FAT32), function 60h---
 07h 53 BYTEs	extended BPB (see #1350)
 3Ch 32 BYTEs	reserved

(Table 1248)
Values for device type:
 00h	320K/360K disk
 01h	1.2M disk
 02h	720K disk
 03h	single-density 8-inch disk
 04h	double-density 8-inch disk
 05h	fixed disk
 06h	tape drive
 07h	(DOS 3.3+) other type of block device, normally 1.44M floppy
 08h	read/write optical disk
 09h	(DOS 5+) 2.88M floppy

Format of parameter block for functions 41h, 61h:
Offset	Size	Description	(Table 1249)
 00h	BYTE	special functions (reserved, must be zero)
 01h	WORD	number of disk head
 03h	WORD	number of disk cylinder
 05h	WORD	number of first sector to read/write
 07h	WORD	number of sectors
 09h	DWORD	transfer address
Note:	under Windows95, a volume must be locked (see AX=440Dh/CX=084Bh) in
	  order to perform direct accesses such as track reads and writes
	  with this IOCTL function

Format of parameter block for function 42h:
Offset	Size	Description	(Table 1250)
 00h	BYTE	reserved, must be zero (DOS <3.2)
		  bit 0=0: format/verify track
			1: format status call (DOS 3.2+), don't actually format
		  bit 1: format multiple tracks, require additional WORD
			  (hard disks only)
		  bits 2-7 reserved, must be zero
		value on return (DOS 3.3+):
		  00h	specified tracks, sectors/track supported by BIOS
		  01h	function not supported by BIOS
		  02h	specified tracks, sectors/track not allowed for drive
		  03h	no disk in drive
 01h	WORD	number of disk head
 03h	WORD	number of disk cylinder
---BYTE 00h bit 1 set---
 05h	WORD	number of tracks to format

Format of parameter block for function 62h:
Offset	Size	Description	(Table 1251)
 00h	BYTE	reserved, must be zero (DOS <3.2)
		  bit 0=0: verify single track
			1: verify multiple tracks
		  bits 1-7 reserved, must be zero
		value on return (DOS 3.3+):
		  00h	specified tracks, sectors/track supported by BIOS
		  01h	function not supported by BIOS
		  02h	specified tracks, sectors/track not allowed for drive
		  03h	no disk in drive
 01h	WORD	number of disk head
 03h	WORD	number of disk cylinder
 05h	WORD	number of tracks to verify (equivalent to 255 or fewer sectors)

Format of parameter block for functions 46h, 66h:
Offset	Size	Description	(Table 1252)
 00h	WORD	(call) info level (should be 0000h)
 02h	DWORD	disk serial number (binary)
 06h 11 BYTEs	volume label or "NO NAME    "
 11h  8 BYTEs	filesystem type "FAT12	 " or "FAT16   "
		  (generally CL=66h only, but MS-DOS 5.0 will write the
		  given filesystem type to the disk)
Note:	under MS-DOS 7.0 or a Windows95 DOS box, the volume label field can
	  return as all blanks even when a volume label has been set (the Win95
	  installation seems to blank the volume label field in the partition
	  boot sector; once LABEL has been run, the volume label is reported
	  correctly)
SeeAlso: AH=69h

Format of parameter block for functions 47h, 67h:
Offset	Size	Description	(Table 1253)
 00h	BYTE	special-function field (must be zero)
 01h	BYTE	disk-access flag, nonzero if access allowed by driver

Format of parameter block for function 48h:
Offset	Size	Description	(Table 1254)
 00h	BYTE	(call) locking operation
		00h lock media in drive
		01h unlock media
		02h get locking status
 01h	BYTE	(ret) drive's lock status (number of pending locks on drive)
Note:	also supported by MS-DOS 7.0

Format of parameter block for function 52h:
 00h	BYTE	(call) unused???	(Table 1255)
		(ret) 00h if flash/ATA drive but no card inserted
			unchanged otherwise
Notes:	the absense of a flash card should be tested by checking the DOS error
	  code rather than the returned byte
	the parameter byte is cleared to 00h erroneously by the Award
	  PCDISK.EXE v1.02c PCMCIA/ATA driver if no ATA card is inserted
	  (bug corrected in PCDISK.EXE v1.02h and later)
	not supported by the SystemSoft ATADRV.EXE and the Phoenix PCMATA.SYS
	  PCMCIA/ATA drivers

Format of parameter block for function 68h:
Offset	Size	Description	(Table 1256)
 00h	BYTE	01h for default media type, 00h for any other media type
		(see also INT 13/AH=20h"Compaq")
 01h	BYTE	02h for 720K, 07h for 1.44M, 09h for 2.88M

Format of parameter block for function 6Fh:
Offset	Size	Description	(Table 1257)
 00h	BYTE	(call) length of this buffer (in bytes)
 01h	BYTE	(ret) number of bytes in parameter block actually used
 02h	BYTE	(ret) drive flags (see #1258)
 03h	BYTE	(ret) physical drive number
		00h-7Fh floppy
		80h-FEh hard
		FFh no physical drive
 04h	DWORD	(ret) bitmap of logical drives associated with physical drive
		bit 0 = drive A:, etc.
 08h	QWORD	(ret) relative block address of partition start

Bitfields for Get Drive Map Information drive flags:
Bit(s)	Description	(Table 1258)
 0	protected-mode driver for logical drive
 1	protected-mode driver in use for physical drive corresponding to the
	  logical drive
 2	drive available only in protected mode
 3	protected-mode drive supports media ejection
 4	drive issues media insertion and removal notifications
SeeAlso: #1257

Format of parameter block for function 73h:
Offset	Size	Description	(Table 1259)
 00h	BYTE	???
		00h ATA card inserted ???
		80h ATA card not inserted ???
 01h	BYTE	length of parameter block ???
		apparently always 40h
 02h	BYTE	???
		00h ATA card not inserted ???
		0Dh ATA card inserted ???
 03h  2 BYTEs	??? (apparently always 00h)
 05h	BYTE	drive number (0=first) ???
 06h	BYTE	total number of drives ???
 07h	BYTE	???
		00h ATA card not inserted ???
		01h ATA card inserted ???
 08h 17 BYTEs	???
 19h	BYTE	???
		00h ATA card not inserted ???
		01h ATA card inserted ???
 1Ah	BYTE	??? (apparently always 01h)
 1Bh	BYTE	???
		00h ATA card not inserted ???
		01h ATA card inserted ???
 1Ch  2 BYTEs	??? (apparently always 0015h)
 1Eh  2 BYTEs	???
 20h  2 BYTEs	??? (apparently always 0110h)
 22h 15 BYTEs	???
 31h  2 BYTEs	??? (apparently always 7000h)
 33h 11 BYTEs	driver signature
		"AWARD PDISK" for Award PCDISK.EXE PCMCIA/ATA driver
		"MS-BIOS    " for HP 200LX generic ATA driver
 3Eh  2 BYTEs	???
Notes:	parameter structure possibly depends on driver
	this function is not supported by the SystemSoft ATADRV.EXE and the
	  Phoenix PCMATA.SYS PCMCIA/ATA drivers

Format of parameter block for function 7Fh for SystemSoft ATADRV.EXE:
Offset	Size	Description	(Table 1260)
 00h	DWORD	-> unknown location within driver
Note:	function supported by the SystemSoft ATADRV.EXE PCMCIA/ATA driver
	  but not by the Award PCDISK.EXE PCMCIA/ATA driver
SeeAlso: #1261

Format of parameter block for function 7Fh for Phoenix PCMATA.SYS:
Offset	Size	Description	(Table 1261)
 00h  8 BYTEs	???
Note:	this function supported by the Phoenix PCMATA.SYS PCMCIA/ATA driver
	  but not by the Award PCDISK.EXE PCMCIA/ATA driver
SeeAlso: #1260
--------D-21440DCX084A-----------------------
INT 21 - MS-DOS 7.0 - GENERIC IOCTL - LOCK LOGICAL VOLUME
	AX = 440Dh
	CX = 084Ah (category code 08h, minor code 4Ah)
	BL = drive number (00h=default,01h=A:,etc)
	BH = lock level (00h-04h)
	DX = drive permissions (see #1262) for Level 1 lock or second
	    Level 0 lock when formatting
Return: CF set on error
	    AX = error code (01h,02h,etc.) (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
Notes:	the logical volume must be locked before direct disk accesses are
	  permitted by Windows95
	the commandline LOCK issues a level 4 lock
SeeAlso: AX=440Dh"DOS 3.2+",AX=440Dh/CX=084Bh,AX=440Dh/CX=086Ah
SeeAlso: AX=440Dh/CX=086Ch

Bitfields for drive permissions:
Bit(s)	Description	(Table 1262)
 0	allow writes
 1	disallow new file mappings
 2	volume locked for formatting
--------D-21440DCX084B-----------------------
INT 21 - MS-DOS 7.0 - GENERIC IOCTL - LOCK PHYSICAL VOLUME
	AX = 440Dh
	CX = 084Bh (category code 08h, minor code 4Bh)
	BL = physical drive number (00h-7Fh = floppy, 80h-FFh = hard disk)
	BH = lock level (00h-03h)
	DX = drive permissions (see #1262) for Level 1 lock or second
	    Level 0 lock when formatting
Return: CF set on error
	    AX = error code (01h,02h,etc.) (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
Note:	the physical volume must be locked before direct disk writes via
	  INT 13 are permitted by Windows95
SeeAlso: AX=440Dh"DOS 3.2+",AX=440Dh/CX=084Ah,AX=440Dh/CX=086Bh
SeeAlso: AX=440Dh/CX=086Ch
--------D-21440DCX086A-----------------------
INT 21 - MS-DOS 7.0 - GENERIC IOCTL - UNLOCK LOGICAL VOLUME
	AX = 440Dh
	CX = 086Ah (category code 08h, minor code 6Ah)
	BL = drive number (00h=default,01h=A:,etc)
Return: CF set on error
	    AX = error code (01h,02h,etc.) (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
Note:	the logical volume must be locked before direct disk accesses via
	  INT 13 are permitted by Windows95
SeeAlso: AX=440Dh"DOS 3.2+",AX=440Dh/CX=084Ah,AX=440Dh/CX=086Bh
--------D-21440DCX086B-----------------------
INT 21 - MS-DOS 7.0 - GENERIC IOCTL - UNLOCK PHYSICAL VOLUME
	AX = 440Dh
	CX = 086Bh (category code 08h, minor code 6Bh)
	BL = physical drive number (00h-7Fh = floppy, 80h-FFh = hard disk)
Return: CF set on error
	    AX = error code (01h,02h,etc.) (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
SeeAlso: AX=440Dh"DOS 3.2+",AX=440Dh/CX=084Bh,AX=440Dh/CX=086Ah
--------D-21440DCX086C-----------------------
INT 21 - MS-DOS 7.0 - GENERIC IOCTL - GET LOCK FLAG STATE
	AX = 440Dh
	CX = 086Ch (category code 08h, minor code 6Ch)
	BL = drive number (00h=default,01h=A:,etc)
Return: CF set on error
	    AX = error code (01h,02h,etc.) (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
	    AX = access flag (see #1263)
SeeAlso: AX=440Dh"DOS 3.2+",AX=440Dh/CX=084Ah,AX=440Dh/CX=084Bh
SeeAlso: AX=440Dh/CX=0870h

(Table 1263)
Values for drive access flag:
 0000h	no writes/file mappings since last call
 0001h	write operation has occurred since last call
 0002h	file mapping has occurred since last call
Note:	function 6Ch resets the access flag every time it is called
--------D-21440DCX086D-----------------------
INT 21 - MS-DOS 7.0 - GENERIC IOCTL - ENUMERATE OPEN FILES
	AX = 440Dh
	CX = 086Dh (category code 08h, minor code 6Dh)
	BL = drive number (00h=default,01h=A:,etc)
	DS:DX -> buffer for ASCIZ pathname
	SI = file index (0000h to number of open files-1)
	DI = enumeration type (0000h all files, 0001h unmovable files)
Return: CF set on error
	    AX = error code (01h,02h,12h,etc.) (see #1366 at AH=59h/BX=0000h)
		0012h if file index is out of range
	CF clear if successful
	    AX = file open mode (BX from AX=6C00h or AX=716Ch)
	    CX = file type (see #1264)
SeeAlso: AX=440Dh"DOS 3.2+",AX=440Dh/CX=084Ah,AX=440Dh/CX=086Ch
SeeAlso: AX=440Dh/CX=086Eh,AX=6C00h,AX=716Ch

(Table 1264)
Values for file type:
 0000h	normal file
 0001h	memory-mapped file (unmovable)
 0002h	unmovable file
 0004h	swap file
--------D-21440DCX086E-----------------------
INT 21 - MS-DOS 7.0 - GENERIC IOCTL - FIND SWAP FILE
	AX = 440Dh
	CX = 086Eh (category code 08h, minor code 6Eh)
	BL = drive number (00h=default,01h=A:,etc)
	DS:DX -> buffer for ASCIZ pathname
	SI = file index
	DI = enumeration type
Return: CF set on error
	    AX = error code (01h,02h,etc.) (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
	    AX = pager type
		0001h no pager
		0002h paging through MS-DOS
		0003h protected-mode pager
	    CX:BX = swap file size in 4K pages
SeeAlso: AX=440Dh"DOS 3.2+",AX=440Dh/CX=086Dh
--------D-21440DCX0870-----------------------
INT 21 - MS-DOS 7.0 - GENERIC IOCTL - GET CURRENT LOCK STATE
	AX = 440Dh
	CX = 0870h (category code 08h, minor code 70h)
	BL = drive number (00h=default,01h=A:,etc)
Return: CF set on error
	    AX = error code (01h,02h,etc.) (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
	    AX = current lock level (0-3) or FFFFh if not locked
	    CX = lock permissions if AX<>FFFFh (see #1262)
SeeAlso: AX=440Dh"DOS 3.2+",AX=440Dh/CX=086Ch
--------D-21440DCX0871-----------------------
INT 21 - MS-DOS 7.0 - GENERIC IOCTL - GET FIRST CLUSTER
	AX = 440Dh
	CX = 0871h (category code 08h, minor code 71h)
	BX = filename character set (see #1265)
	DS:DX -> ASCIZ pathname for file or directory
Return: CF set on error
	    AX = error code (01h,02h,etc.) (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
	    DX:AX = first cluster number
Note:	this function finds any file or directory regardless of attributes,
	  except that it will not find volume labels
SeeAlso: AX=440Dh"DOS 3.2+",AX=440Dh/CX=086Ch,#1041

(Table 1265)
Values for character set:
 00h	Windows ANSI
 01h	current OEM character set
 02h	Unicode
--------D-21440E-----------------------------
INT 21 - DOS 3.2+ - IOCTL - GET LOGICAL DRIVE MAP
	AX = 440Eh
	BL = drive number (00h=default,01h=A:,etc)
Return: CF set on error
	    AX = error code (01h,0Fh) (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
	    AL = 00h block device has only one logical drive assigned
		 1..26 the last letter used to reference the drive (1=A:,etc)
Notes:	DR DOS 3.41-5.0 DRIVER.SYS does not support drive mapping and thus
	  always returns AL=00h
	in addition to the normal operation, if Stacker is installed, this
	  call also sets the volume number at offset 58h in the Stacker
	  device driver (DR DOS 3.41-5.0 only; use AX=4408h otherwise)
	  (see AX=4404h"Stacker",INT 25/AX=CDCDh)
SeeAlso: AX=4408h,AX=440Fh,INT 2F/AX=122Bh
--------D-21440F-----------------------------
INT 21 - DOS 3.2+ - IOCTL - SET LOGICAL DRIVE MAP
	AX = 440Fh
	BL = physical drive number (00h=default,01h=A:,etc))
Return: CF set on error
	    AX = error code (01h,0Fh) (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
	    drive now responds to next logical drive number
Notes:	maps logical drives to physical drives, similar to DOS's treatment of
	  a single physical floppy drive as both A: and B:
	DR DOS 3.41-5.0 DRIVER.SYS does not support drive mapping and thus
	  always returns an error on this function
SeeAlso: AX=440Eh,INT 2F/AX=122Bh
--------D-214410-----------------------------
INT 21 - DOS 5+ - IOCTL - QUERY GENERIC IOCTL CAPABILITY (HANDLE)
	AX = 4410h
	BX = handle for device
	CH = category code (see #1232)
	CL = function code (see #1233)
Return: CF clear if successful
	    AX = 0000h	specified IOCTL function is supported
	CF set on error
	    AL = 01h	IOCTL capability not available
Note:	a program which wishes to use Generic IOCTL calls beyond those in the
	  standard DOS 3.2 set may use this call first to see whether a
	  particular call is supported
SeeAlso: AX=440Ch,AX=440Dh"DOS 3.2+",AX=4411h
--------d-214410BXFFFF-----------------------
INT 21 U - NewSpace - ENABLE DRIVER
	AX = 4410h
	BX = FFFFh
Program: NewSpace is a TSR by Isogon Corporation which automatically compresses
	  all files as they are written and decompresses them as they are read
Note:	compressed files are not accessible unless the driver is enabled
SeeAlso: AX=4411h/BX=FFFFh
--------D-214411-----------------------------
INT 21 - DOS 5+ - IOCTL - QUERY GENERIC IOCTL CAPABILITY (DRIVE)
	AX = 4411h
	BL = drive number
	CH = category code (see #1245)
	CL = function code (see #1246)
Return: CF clear if successful
	    AX = 0000h	specified IOCTL function is supported
	CF set on error
	    AL = 01h	IOCTL capability not available
Note:	a program which wishes to use Generic IOCTL calls beyond those in the
	  standard DOS 3.2 set may use this call first to see whether a
	  particular call is supported
SeeAlso: AX=440Ch,AX=440Dh"DOS 3.2+",AX=4410h
--------d-214411BXFFFF-----------------------
INT 21 U - NewSpace - DISABLE DRIVER
	AX = 4411h
	BX = FFFFh
Program: NewSpace is a TSR by Isogon Corporation which automatically compresses
	  all files as they are written and decompresses them as they are read
Note:	compressed files are not accessible unless the driver is enabled
SeeAlso: AX=4410h/BX=FFFFh
--------O-214412-----------------------------
INT 21 O - DR DOS 5.0-6.0 - DETERMINE DOS TYPE
	AX = 4412h
	CF set
Return: CF set if not DR DOS
	    AX = error code (see #1366 at AH=59h/BX=0000h)
	CF clear if DR DOS
	    DX = AX = version code (see #1267)
Note:	this obsolete call, which is no longer supported in Novell DOS 7, is
	  identical to AX=4452h
SeeAlso: AX=4452h
--------d-214412BXFFFF-----------------------
INT 21 U - NewSpace - INSTALLATION CHECK???
	AX = 4412h
	BX = FFFFh
Return: AX = PSP segment of NewRes (resident driver for NewSpace)
	BX:DX -> ???
	CX = ???
SeeAlso: AX=4411h/BX=FFFFh
--------d-214413BXFFFF-----------------------
INT 21 U - NewSpace - GET ???
	AX = 4413h
	BX = FFFFh
Return: AX = code segment of NewRes (resident driver for NewSpace)
	BX = offset of ???
SeeAlso: AX=4412h/BX=FFFFh
--------O-214414-----------------------------
INT 21 OU - DR DOS 5.0-6.0 - SET GLOBAL PASSWORD
	AX = 4414h
	DS:DX -> password string (blank-padded to 8 characters)
Desc:	Specify the master password for accessing files.
Note:	this obsolete call, which is no longer supported in Novell DOS 7, is
	  identical to AX=4454h
SeeAlso: AX=4454h
--------d-214414BXFFFF-----------------------
INT 21 U - NewSpace - DEBUGGING DUMP
	AX = 4414h
	BX = FFFFh
Return: debugging dump written to X:\NEWSPACE.SMP
SeeAlso: AX=4413h/BX=FFFFh,AX=44FFh/BX=FFFFh
--------O-214416-----------------------------
INT 21 OU - DR DOS 5.0-6.0 - HISTORY BUFFER, SHARE, AND HILOAD CONTROL
	AX = 4416h to 4418h
Note:	these obsolete subfunctions (which are no longer supported in Novell
	  DOS 7) are identical to AX=4456h through 4458h
SeeAlso: AX=4456h,AX=4457h,AX=4458h
--------O-214451-----------------------------
INT 21 - Concurrent DOS v3.2+ - INSTALLATION CHECK
	AX = 4451h
Return: CF set if not Concurrent DOS
	    AX = error code (see #1366 at AH=59h/BX=0000h)
	CF clear if successful
	    AH = single-user/multiuser nature (see #3761)
		10h single-user
		    AL = operating system version ID (see #1267)
		14h multiuser
		    AL = operating system version ID (see #1266)
Notes:	as of Concurrent DOS/XM 5.0 (possibly earlier), the version is stored
	  in the environment variable VER
	use this function if you are looking for multiuser capabilities,
	  AX=4452h for single-user
	this function should never return the single-user values
SeeAlso: AX=4452h,AX=4459h

(Table 1266)
Values for Digital Research operating system version ID:
 32h	Concurrent PC DOS 3.2
 41h	Concurrent DOS 4.1
 50h	Concurrent DOS/XM 5.0 or Concurrent DOS/386 1.1
 60h	Concurrent DOS/XM 6.0 or Concurrent DOS/386 2.0
 62h	Concurrent DOS/XM 6.2 or Concurrent DOS/386 3.0
 66h	DR Multiuser DOS 5.1
 67h	Concurrent DOS 5.1
--------O-214452-----------------------------
INT 21 - DR DOS 3.41+ - DETERMINE DOS TYPE/GET DR DOS VERSION
	AX = 4452h ("DR")
	CF set
Return: CF set if not DR DOS
	    AX = error code (see #1366 at AH=59h/BX=0000h)
	CF clear if DR DOS
	    AX = version code
	    AH = single-user/multiuser nature (see #3761)
		10h single-user
		    AL = operating system version ID (see #1267)
		14h multiuser
		    AL = operating system version ID (see #1266)
	    DX modified (refer to note below)
Notes:	the DR DOS version is stored in the environment variable VER
	use this function if looking for single-user capabilities, AX=4451h
	  if looking for multiuser; this call should never return multiuser
	  values
	in DR DOS 3.41-6.0, DX=AX on return; for Novell DOS 7, DH=AH but DL=00h
	  (reportedly, DH=00h when booting NWDOS7 from installation disks)
	Novell DOS 7 returns error code 0001h if SETVER x.255 is in effect for
	  the calling program, or SETVER /G x.255 is in effect
SeeAlso: AX=4412h,AX=4451h,AX=4459h

(Table 1267)
Values for Digital Research operating system version ID:
 41h	DOS Plus 1.2
 60h	DOS Plus 2.0 or 2.1
 63h	DR DOS 3.41
 64h	DR DOS 3.42
 65h	DR DOS 5.0
 67h	DR DOS 6.0
 70h	PalmDOS
 71h	DR DOS 6.0 March 1993 "business update"
 72h	Novell DOS 7.0
 73h	OpenDOS 7.02
SeeAlso: #3761

Bitfields for CP/M type indicator:
Bit(s)	Description	(Table 3761)
 7-4	CPU type
	0000 = 8080
	0001 = 8086
 3-0	OS type
	0000 = CP/M
	0001 = MP/M
	0002 = CP/Net
	0004 = multiuser
SeeAlso: #1267
--------O-214454-----------------------------
INT 21 U - DR DOS 3.41+ - SET GLOBAL PASSWORD
	AX = 4454h
	DS:DX -> password string (blank-padded to 8 characters)
Desc:	Specify the master password for accessing files.
SeeAlso: AX=4303h,AX=4414h
--------O-214456-----------------------------
INT 21 U - DR DOS 5.0+ - HISTORY BUFFER CONTROL
	AX = 4456h
	DL = control flags (see #1268)
Return: AL = previous value of state flags (see #1269)
Note:	DR DOS 6.0 only checks bit 0 and ignores the rest of DL
SeeAlso: #1270

Bitfields for control flags:
Bit(s)	Description	(Table 1268)
 0	whose buffer: 0=application, 1=COMMAND.COM
---Novell DOS 7---
 1	toggle HISTORY usage
 2	toggle INSERT state
Note:	only one bit at a time may be used

Bitfields for state flags:
Bit(s)	Description	(Table 1269)
 0	HISTORY buffer enabled
 1	INSERT enabled
 2-5	unused
 7	whose buffer: 0=application, 1=COMMAND.COM
--------O-214457-----------------------------
INT 21 U - DR DOS 5.0-6.0 - SHARE/HILOAD CONTROL
	AX = 4457h
	DH = subfunction
	    00h enable/disable SHARE
		DL = 00h disable
		   = 01h enable
		   else Return: AX = ???
	    01h get HILOAD status
		Return: AX = status
			    0000h off
			    0001h on
	    02h set HILOAD status
		DL = new state (00h off, 01h on)
		Return: AX = ???
	    other
		Return: AX = ???
Note:	This was seen called by COMMAND.COM of DR DOS 6.0; it does not seem
	  to be supported by Novell DOS 7
SeeAlso: AX=4457h/DX=FFFFh
--------O-214457DXFFFF-----------------------
INT 21 OU - DR DOS 6.0 - GET SHARE STATUS
	AX = 4457h
	DX = FFFFh
Return: AX = SHARE status
Note:	not supported by Novell DOS 7
SeeAlso: INT 2F/AX=1000h
--------O-214458-----------------------------
INT 21 U - DR DOS 5.0+ internal - GET POINTER TO INTERNAL VARIABLE TABLE
	AX = 4458h
Return: ES:BX -> internal variable table (see #1270,#1271)
	AX = ??? (0B50h for DR DOS 5.0, 0A56h for DR DOS 6.0, 0FE4h for
		  Novell DOS 7)
SeeAlso: AX=4452h

Format of DR DOS 5.0-6.0 internal variable table:
Offset	Size	Description	(Table 1270)
 00h	WORD	???
 02h	WORD	segment of ???
 04h	WORD	offset within DOS data segment of history control structure
		  for COMMAND.COM history buffer (see #1272)
 06h	WORD	offset within DOS data segment of history control structure
		  for application history buffer (see #1272)
 08h	BYTE	initial history state flags (see #1269)
 09h  2 BYTEs	???
 0Bh	WORD	KB of extended memory at startup
 0Dh	BYTE	number of far jump entry points
 0Eh	WORD	segment containing far jumps to DR DOS entry points (see #1273)
 10h	WORD	(only if kernel loaded in HMA) offset in HMA of first free HMA
		  memory block (see #1274) or 0000h if none; segment is FFFFh
 12h	WORD	pointer to segment of environment variables set in CONFIG,
		  or 0000h if already used
---DR DOS 6.0---
 14h	WORD	(only if kernel loaded in HMA) offset in HMA of first used HMA
		memory block (see #1274) or 0000h if none; segment is FFFFh
 16h  8 BYTEs	???
 1Eh	WORD	offset in DOS data segment of full COUNTRY.SYS filename
 20h  8 BYTEs	???
 28h	WORD	offset in DOS data segment of SHARE hook table
 2Ah  2 BYTEs	???
 2Ch	WORD	offset in DOS data segment of far pointer to INT 2F/AX=1000h
		  handler
Notes:	the segment used for the DR DOS 6.0 CONFIG environment variables
	  (excluding COMSPEC, VER and OS) is only useful for programs/drivers
	  called from CONFIG.SYS. The word is set to zero later when the area
	  is copied to the COMMAND.COM environment space.  This allows
	  CONFIG.SYS to pass information to AUTOEXEC.BAT.
	the Novell DOS 7 KEYB uses offsets 10h,14h, and 2Ch in the same was
	  as for DR DOS 6.0, so it is likely that the entire table is the same

Format of Novell DOS 7 internal variable table:
Offset	Size	Description	(Table 1271)
 00h	???
 1Eh	WORD	offset of COUNTRY.SYS filename
 42h 16 DWORDs	pointers to ??? entry points
	???

Format of history control structure:
Offset	Size	Description	(Table 1272)
 00h	WORD	segment of buffer
 02h	WORD	size of buffer in bytes
 04h	WORD	???

Format of kernel entry jump table for DR DOS 5.0-6.0:
Offset	Size	Description	(Table 1273)
 00h  5 BYTEs	far jump to kernel entry point for CP/M CALL 5
 05h  5 BYTEs	far jump to kernel entry point for INT 20
 0Ah  5 BYTEs	far jump to kernel entry point for INT 21
 0Fh  5 BYTEs	far jump to kernel entry point for INT 22 (RETF)
 14h  5 BYTEs	far jump to kernel entry point for INT 23 (RETF)
 19h  5 BYTEs	far jump to kernel entry point for INT 24
 1Eh  5 BYTEs	far jump to kernel entry point for INT 25
 23h  5 BYTEs	far jump to kernel entry point for INT 26
 28h  5 BYTEs	far jump to kernel entry point for INT 27
 2Dh  5 BYTEs	far jump to kernel entry point for INT 28
 32h  5 BYTEs	far jump to kernel entry point for INT 2A (IRET)
 37h  5 BYTEs	far jump to kernel entry point for INT 2B (IRET)
 3Ch  5 BYTEs	far jump to kernel entry point for INT 2C (IRET)
 41h  5 BYTEs	far jump to kernel entry point for INT 2D (IRET)
 46h  5 BYTEs	far jump to kernel entry point for INT 2E (IRET)
 4Bh  5 BYTEs	far jump to kernel entry point for INT 2F
Notes:	all of these entry points are indirected through this jump table
	  to allow the kernel to be relocated into high memory while leaving
	  the actual entry addresses in low memory for maximum compatibility
	some of these entry points (22h,23h,24h,2Eh,2Fh) are replaced as soon
	  as COMMAND.COM is loaded, and return immediately to the caller, some
	  returning an error code (the original handler for INT 2F returns
	  AL=03h [fail]).

Format of HMA Memory Block (DR DOS 6.0 kernel loaded in HMA):
Offset	Size	Description	(Table 1274)
 00h	WORD	offset of next HMA Memory Block (0000h if last block)
 02h	WORD	size of this block in bytes (at least 10h)
 04h	BYTE	type of HMA Memory Block (interpreted by MEM)
		00h system
		01h KEYB
		02h NLSFUNC
		03h SHARE
		04h TaskMAX
		05h COMMAND
 05h	var	TSR (or system) code and data. DR DOS TSR's, such as KEYB,
		  hooks interrupts using segment FFFEh instead FFFFh.
--------O-214459-----------------------------
INT 21 - DR Multiuser DOS 5.0 - API
	AX = 4459h
	CL = function (see #3690 at INT E0"CP/M-86")
	DS,DX = parameters
Notes:	DR DOS 5.0 and Novell DOS 7 return CF set and AX=0001h
	this API is also available on INT E0
SeeAlso: AX=4452h,INT E0"CP/M-86"
--------v-2144A0-----------------------------
INT 21 - VIRUS - "Horns" - INSTALLATION CHECK
	AX = 44A0h
Return: AH = FFh if installed
SeeAlso: AX=4243h"VIRUS",AX=4B04h"VIRUS"
--------N-2144E0-----------------------------
INT 21 U - Sun PC-NFS - API???
	AX = 44E0h
	DS:DX -> ???
	SS:BP -> stack frame (see #1275)
Return: ???
Note:	this function is also supported by Beame&Whiteside's BWPCNFS shim; the
	  description presented here was derived from that shim

Format of PC-NFS stack frame:
Offset	Size	Description	(Table 1275)
 00h	WORD	-> previous stack frame
 02h	DWORD	return address
--------d-2144FFBXFFFF-----------------------
INT 21 U - NewSpace - ???
	AX = 44FFh
	BX = FFFFh
	DX = ???
Program: NewSpace is a TSR by Isogon Corporation which automatically compresses
	  all files as they are written and decompresses them as they are read
SeeAlso: AX=4414h/BX=FFFFh
--------D-2145-------------------------------
INT 21 - DOS 2+ - "DUP" - DUPLICATE FILE HANDLE
	AH = 45h
	BX = file handle
Return: CF clear if successful
	    AX = new handle
	CF set on error
	    AX = error code (04h,06h) (see #1366 at AH=59h/BX=0000h)
Notes:	moving file pointer for either handle will also move it for the other,
	  because both will refer to the same system file table
	for DOS versions prior to 3.3, file writes may be forced to disk by
	  duplicating the file handle and closing the duplicate
SeeAlso: AH=3Dh,AH=46h
--------D-2146-------------------------------
INT 21 - DOS 2+ - "DUP2", "FORCEDUP" - FORCE DUPLICATE FILE HANDLE
	AH = 46h
	BX = file handle
	CX = file handle to become duplicate of first handle
Return: CF clear if successful
	CF set on error
	    AX = error code (04h,06h) (see #1366 at AH=59h/BX=0000h)
Notes:	closes file with handle CX if it is still open
	DOS 3.30 hangs if BX=CX on entry
	moving file pointer for either handle will also move it for the other,
	  because both will refer to the same system file table
SeeAlso: AH=3Dh,AH=45h
--------D-2147-------------------------------
INT 21 - DOS 2+ - "CWD" - GET CURRENT DIRECTORY
	AH = 47h
	DL = drive number (00h = default, 01h = A:, etc)
	DS:SI -> 64-byte buffer for ASCIZ pathname
Return: CF clear if successful
	    AX = 0100h (undocumented)
	CF set on error
	    AX = error code (0Fh) (see #1366 at AH=59h/BX=0000h)
Notes:	the returned path does not include a drive or the initial backslash
	many Microsoft products for Windows rely on AX being 0100h on success
	under the FlashTek X-32 DOS extender, the buffer pointer is in DS:ESI
SeeAlso: AH=19h,AH=3Bh,AH=71h,INT 15/AX=DE25h
--------D-2148-------------------------------
INT 21 - DOS 2+ - ALLOCATE MEMORY
	AH = 48h
	BX = number of paragraphs to allocate
Return: CF clear if successful
	    AX = segment of allocated block
	CF set on error
	    AX = error code (07h,08h) (see #1366 at AH=59h/BX=0000h)
	    BX = size of largest available block
Notes:	DOS 2.1-6.0 coalesces free blocks while scanning for a block to
	  allocate
	.COM programs are initially allocated the largest available memory
	  block, and should free some memory with AH=49h before attempting any
	  allocations
	under the FlashTek X-32 DOS extender, EBX contains a protected-mode
	  near pointer to the allocated block on a successful return
SeeAlso: AH=49h,AH=4Ah,AH=58h,AH=83h
--------D-2149-------------------------------
INT 21 - DOS 2+ - FREE MEMORY
	AH = 49h
	ES = segment of block to free
Return: CF clear if successful
	CF set on error
	    AX = error code (07h,09h) (see #1366 at AH=59h/BX=0000h)
Notes:	apparently never returns an error 07h, despite official docs; DOS 2.1+
	  code contains only an error 09h exit
	DOS 2.1-6.0 does not coalesce adjacent free blocks when a block is
	  freed, only when a block is allocated or resized
	the code for this function is identical in DOS 2.1-6.0 except for
	  calls to start/end a critical section in DOS 3.0+
SeeAlso: AH=48h,AH=4Ah
--------D-214A-------------------------------
INT 21 - DOS 2+ - RESIZE MEMORY BLOCK
	AH = 4Ah
	BX = new size in paragraphs
	ES = segment of block to resize
Return: CF clear if successful
	CF set on error
	    AX = error code (07h,08h,09h) (see #1366 at AH=59h/BX=0000h)
	    BX = maximum paragraphs available for specified memory block
Notes:	under DOS 2.1-6.0, if there is insufficient memory to expand the block
	  as much as requested, the block will be made as large as possible
	DOS 2.1-6.0 coalesces any free blocks immediately following the block
	  to be resized
SeeAlso: AH=48h,AH=49h,AH=83h
--------v-214A--BX00B6-----------------------
INT 21 - VIRUS???
	AH = 4Ah
	BX = 00B6h
	ES = CX
Return: ???
Note:	this call is intercepted by the Search&Destroy SDRes v27.03 bundled
	  with Novell DOS 7, and is presumably some virus's installation check
SeeAlso: AH=0Eh/DL=ADh,AH=4Ah/BX=FFFFh,AH=D2h"VIRUS"
--------v-214A--BXFFFF-----------------------
INT 21 - VIRUS???
	AH = 4Ah
	BX = FFFFh
	CX = 0568h
	SI = 0129h
	DI = 0000h
	ES = BP
Return: ???
Note:	this call is intercepted by the Search&Destroy SDRes v27.03 bundled
	  with Novell DOS 7, and is presumably some virus's installation check
SeeAlso: AH=0Eh/DL=ADh,AH=4Ah/BX=00B6h
--------D-214B-------------------------------
INT 21 - DOS 2+ - "EXEC" - LOAD AND/OR EXECUTE PROGRAM
	AH = 4Bh
	AL = type of load
	    00h load and execute
	    01h load but do not execute
	    03h load overlay (see #1277)
	    04h load and execute in background (European MS-DOS 4.0 only)
		"Exec & Go" (see also AH=80h)
	DS:DX -> ASCIZ program name (must include extension)
	ES:BX -> parameter block (see #1276,#1277,#1278)
	CX = mode (subfunction 04h only)
		0000h child placed in zombie mode after termination
		0001h child's return code discarded on termination
Return: CF clear if successful
	    BX,DX destroyed
	    if subfunction 01h, process ID set to new program's PSP; get with
		INT 21/AH=62h
	CF set on error
	    AX = error code (01h,02h,05h,08h,0Ah,0Bh) (see #1366 at AH=59h)
Notes:	DOS 2.x destroys all registers, including SS:SP
	under ROM-based DOS, if no disk path characters (colons or slashes)
	  are included in the program name, the name is searched for in the
	  ROM module headers (see #1281) before searching on disk
	for functions 00h and 01h, the calling process must ensure that there
	  is enough unallocated memory available; if necessary, by releasing
	  memory with AH=49h or AH=4Ah
	for function 01h, the AX value to be passed to the child program is put
	  on top of the child's stack
	for function 03h, DOS assumes that the overlay is being loaded into
	  memory allocated by the caller
	function 01h was undocumented prior to the release of DOS 5.0
	some versions (such as DR DOS 6.0) check the parameters and parameter
	  block and return an error if an invalid value (such as an offset of
	  FFFFh) is found
	background programs under European MS-DOS 4.0 must use the new
	  executable format
	this function ignores the filename extension, instead checking the
	  first two bytes of the file to determine whether there is a valid
	  .EXE header (see #1280); if not, the file is assumed to be in .COM
	  format.  If present, the file may be in any of several formats which
	  are extensions of the original .EXE format (see #1279)
	.COM-format executables begin running with the following register
	  values:
		AL = 00h if first FCB has valid drive letter, FFh if not
		AH = 00h if second FCB has valid drive letter, FFh if not
		CS,DS,ES,SS = PSP segment
		SP = offset of last word available in first 64K segment
		(note: AX is always 0000h under DESQview)
	old-format executables begin running with the following register
	  values:
		AL = 00h if first FCB has valid drive letter, FFh if not
		AH = 00h if second FCB has valid drive letter, FFh if not
		DS,ES = PSP segment
		SS:SP as defined in .EXE header
		(note: AX is always 0000h under DESQview)
	new executables begin running with the following register values
		AX = environment segment
		BX = offset of command tail in environment segment
		CX = size of automatic data segment (0000h = 64K)
		ES,BP = 0000h
		DS = automatic data segment
		SS:SP = initial stack
	  the command tail corresponds to an old executable's PSP:0081h and
	  following, except that the 0Dh is turned into a NUL (00h); new
	  format executables have no PSP
	under the FlashTek X-32 DOS extender, only function 00h is supported
	  and the pointers are passed in DS:EDX and ES:EBX
	DR DOS 6 always loads .EXE-format programs with no fixups and
	  .COM-format programs starting with 9Ch 55h (PUSHF/PUSH BP) above the
	  64K mark to avoid the EXEPACK bug, by extending the memory block
	  containing the program's environment; this code is disabled if the
	  name of the parent program as stored in the MCB is 'WIN'.
	DR DOS 3.41 and 5.0 check for a valid filename before testing the
	  subfunction number, so the otherwise invalid subfunction 02h will
	  only return error code 01h if the given filename actually exists;
	  otherwise, errors 02h, 03h, or 05h are returned
BUGS:	DOS 2.00 assumes that DS points at the current program's PSP
	Load Overlay (subfunction 03h) loads up to 512 bytes too many if the
	  file contains additional data after the actual overlay
	Load but Do Not Execute (subfunction 01h) is reported to corrupt the
	  top word of the caller's stack if the loaded module terminates with
	  INT 21/AH=4Ch in some versions of MS-DOS, including v5.00.
SeeAlso: AX=4B05h,AH=4Ch,AH=4Dh,AH=64h/BX=0025h,AH=8Ah,INT 2E,INT 60/DI=0604h

Format of EXEC parameter block for AL=00h,01h,04h:
Offset	Size	Description	(Table 1276)
 00h	WORD	segment of environment to copy for child process (copy caller's
		  environment if 0000h)
 02h	DWORD	pointer to command tail to be copied into child's PSP
 06h	DWORD	pointer to first FCB to be copied into child's PSP
 0Ah	DWORD	pointer to second FCB to be copied into child's PSP
 0Eh	DWORD	(AL=01h) will hold subprogram's initial SS:SP on return
 12h	DWORD	(AL=01h) will hold entry point (CS:IP) on return
SeeAlso: #1277,#1278

Format of EXEC parameter block for AL=03h:
Offset	Size	Description	(Table 1277)
 00h	WORD	segment at which to load overlay
 02h	WORD	relocation factor to apply to overlay if in .EXE format
SeeAlso: #1276,#1278

Format of EXEC parameter block for FlashTek X-32:
Offset	Size	Description	(Table 1278)
 00h	PWORD	48-bit far pointer to environment string
 06h	PWORD	48-bit far pointer to command tail string
SeeAlso: #1276,#1277

(Table 1279)
Values for the executable types understood by various environments:
 MZ	old-style DOS executable (see #1280)
 NE	Windows or OS/2 1.x segmented ("new") executable (see #1282)
 LE	Windows virtual device driver (VxD) linear executable (see #1295)
 LX	variant of LE used in OS/2 2.x (see #1295)
 W3	Windows WIN386.EXE file; a collection of LE files
 W4	Windows95 VMM32.VXD file
 PE	Win32 (Windows NT and Win32s) portable executable based on Unix COFF
 DL	HP 100LX/200LX system manager compliant executable (.EXM)
 MP	old PharLap .EXP (see #1305)
 P2	PharLap 286 .EXP (see #1306)
 P3	PharLap 386 .EXP (see #1306)

Format of .EXE file header:
Offset	Size	Description	(Table 1280)
 00h  2 BYTEs	.EXE signature, either "MZ" or "ZM" (5A4Dh or 4D5Ah)
		  (see also #1279)
 02h	WORD	number of bytes in last 512-byte page of executable
 04h	WORD	total number of 512-byte pages in executable (includes any
		partial last page)
 06h	WORD	number of relocation entries
 08h	WORD	header size in paragraphs
 0Ah	WORD	minimum paragraphs of memory required to allocate in addition
		  to executable's size
 0Ch	WORD	maximum paragraphs to allocate in addition to executable's size
 0Eh	WORD	initial SS relative to start of executable
 10h	WORD	initial SP
 12h	WORD	checksum (one's complement of sum of all words in executable)
 14h	DWORD	initial CS:IP relative to start of executable
 18h	WORD	offset within header of relocation table
		40h or greater for new-format (NE,LE,LX,W3,PE,etc.) executable
 1Ah	WORD	overlay number (normally 0000h = main program)
---new executable---
 1Ch  4 BYTEs	???
 20h	WORD	behavior bits
 22h 26 BYTEs	reserved for additional behavior info
 3Ch	DWORD	offset of new executable (NE,LE,etc) header within disk file,
		or 00000000h if plain MZ executable
---Borland TLINK---
 1Ch  2 BYTEs	??? (apparently always 01h 00h)
 1Eh	BYTE	signature FBh
 1Fh	BYTE	TLINK version (major in high nybble, minor in low nybble)
 20h  2 BYTEs	??? (v2.0 apparently always 72h 6Ah, v3.0+ seems always 6Ah 72h)
---ARJ self-extracting archive---
 1Ch  4 BYTEs	signature "RJSX" (older versions, new signature is "aRJsfX" in
		the first 1000 bytes of the file)
---LZEXE 0.90 compressed executable---
 1Ch  4 BYTEs	signature "LZ09"
---LZEXE 0.91 compressed executable---
 1Ch  4 BYTEs	signature "LZ91"
---PKLITE compressed executable---
 1Ch	BYTE	minor version number
 1Dh	BYTE	bits 0-3: major version
		bit 4: extra compression
		bit 5: huge (multi-segment) file
 1Eh  6 BYTEs	signature "PKLITE" (followed by copyright message)
---LHarc 1.x self-extracting archive---
 1Ch  4 BYTEs	unused???
 20h  3 BYTEs	jump to start of extraction code
 23h  2 BYTEs	???
 25h 12 BYTEs	signature "LHarc's SFX "
---LHA 2.x self-extracting archive---
 1Ch  8 BYTEs	???
 24h 10 BYTEs	signature "LHa's SFX " (v2.10) or "LHA's SFX " (v2.13)
---TopSpeed C 3.0 CRUNCH compressed file---
 1Ch	DWORD	018A0001h
 20h	WORD	1565h
---PKARCK 3.5 self-extracting archive---
 1Ch	DWORD	00020001h
 20h	WORD	0700h
---BSA (Soviet archiver) self-extracting archive---
 1Ch	WORD	000Fh
 1Eh	BYTE	A7h
---LARC self-extracting archive---
 1Ch  4 BYTEs	???
 20h 11 BYTEs	"SFX by LARC "
---LH self-extracting archive---
 1Ch  8 BYTEs	???
 24h  8 BYTEs	"LH's SFX "
---RAR self-extracting archive---
 1Ch  4 BYTEs	signature "RSFX"
---other linkers---
 1Ch	var	optional information
---
  N   N DWORDs	relocation items
Notes:	if word at offset 02h is 4, it should be treated as 00h, since pre-1.10
	  versions of the MS linker set it that way
	if both minimum and maximum allocation (offset 0Ah/0Ch) are zero, the
	  program is loaded as high in memory as possible (DOS only checks
	  the maximum allocation, however)
	the maximum allocation is set to FFFFh by default
	additional data may be contained in the file beyond the end of the
	  load image described by the .EXE header; this data may be overlays,
	  the actual executable for newer-format executables, or debugging
	  information (see #1286,#1310)
SeeAlso: #1282

Format of ROM Module Header:
Offset	Size	Description	(Table 1281)
 00h  2 BYTEs	ROM signature 55h, AAh
 02h	BYTE	size of ROM in 512-byte blocks
 03h  3 BYTEs	POST initialization entry point (near JMP instruction)
 06h	ROM Program Name List [array]
	Offset	Size	Description
	 00h	BYTE	length of ROM program's name (00h if end of name list)
	 01h  N BYTEs	program name
	 N+1  3 BYTEs	program entry point (near JMP instruction)

Format of new executable header:
Offset	Size	Description	(Table 1282)
 00h  2 BYTEs	"NE" (4Eh 45h) signature
 02h  2 BYTEs	linker version (major, then minor)
 04h	WORD	offset from start of this header to entry table (see #1289)
 06h	WORD	length of entry table in bytes
 08h	DWORD	file load CRC (0 in Borland's TPW)
 0Ch	BYTE	program flags (see #1283)
 0Dh	BYTE	application flags (see #1284)
 0Eh	WORD	auto data segment index
 10h	WORD	initial local heap size
 12h	WORD	initial stack size (added to data seg, 0000h if SS <> DS)
 14h	DWORD	program entry point (CS:IP), "CS" is index into segment table
 18h	DWORD	initial stack pointer (SS:SP), "SS" is segment index
		if SS=automatic data segment and SP=0000h, the stack pointer is
		  set to the top of the automatic data segment, just below the
		  local heap
 1Ch	WORD	segment count
 1Eh	WORD	module reference count
 20h	WORD	length of nonresident names table in bytes
 22h	WORD	offset from start of this header to segment table (see #1287)
 24h	WORD	offset from start of this header to resource table
 26h	WORD	offset from start of this header to resident names table
 28h	WORD	offset from start of this header to module reference table
 2Ah	WORD	offset from start of this header to imported names table
		(array of counted strings, terminated with a string of length
		  00h)
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
		05h BOSS (Borland Operating System Services)
		81h PharLap 286|DOS-Extender, OS/2
		82h PharLap 286|DOS-Extender, Windows
 37h	BYTE	other EXE flags (see #1285)
 38h	WORD	offset to return thunks or start of gangload area
 3Ah	WORD	offset to segment reference thunks or length of gangload area
 3Ch	WORD	minimum code swap area size
 3Eh  2 BYTEs	expected Windows version (minor version first)
Note:	this header is documented in detail in the Windows 3.1 SDK Programmer's
	  Reference, Vol 4.
SeeAlso: #1280

Bitfields for new executable program flags:
Bit(s)	Description	(Table 1283)
 0-1	DGROUP type
	  0 = none
	  1 = single shared
	  2 = multiple (unshared)
	  3 = (null)
 2	global initialization
 3	protected mode only
 4	8086 instructions
 5	80286 instructions
 6	80386 instructions
 7	80x87 instructions

Bitfields for new executable application flags:
Bit(s)	Description	(Table 1284)
 0-2	application type
	001 full screen (not aware of Windows/P.M. API)
	010 compatible with Windows/P.M. API
	011 uses Windows/P.M. API
 3	is a Family Application (OS/2)
 5	0=executable, 1=errors in image
 6	non-conforming program (valid stack is not maintained)
 7	DLL or driver rather than application
	(SS:SP info invalid, CS:IP points at FAR init routine called with
	  AX=module handle which returns AX=0000h on failure, AX nonzero on
	  successful initialization)

Bitfields for other new .EXE flags:
Bit(s)	Description	(Table 1285)
 0	supports long filenames
 1	2.X protected mode
 2	2.X proportional font
 3	gangload area

Format of Codeview trailer (at end of executable):
Offset	Size	Description	(Table 1286)
 00h	WORD	signature 4E42h ('NB')
 02h	WORD	Microsoft debug info version number
 04h	DWORD	Codeview header offset
SeeAlso: #1310

Format of new executable segment table record:
Offset	Size	Description	(Table 1287)
 00h	WORD	offset in file (shift left by alignment shift to get byte offs)
 02h	WORD	length of image in file (0000h = 64K)
 04h	WORD	segment attributes (see #1288)
 06h	WORD	number of bytes to allocate for segment (0000h = 64K)
Note:	the first segment table entry is entry number 1
SeeAlso: #1290

Bitfields for segment attributes:
Bit(s)	Description	(Table 1288)
 0	data segment rather than code segment
 1	unused???
 2	real mode
 3	iterated
 4	movable
 5	sharable
 6	preloaded rather than demand-loaded
 7	execute-only (code) or read-only (data)
 8	relocations (directly following code for this segment)
 9	debug info present
 10,11	80286 DPL bits
 12	discardable
 13-15	discard priority

Format of new executable entry table item (list):
Offset	Size	Description	(Table 1289)
 00h	BYTE	number of entry points (00h if end of entry table list)
 01h	BYTE	segment number (00h if end of entry table list)
 02h 3N BYTEs	entry records
		Offset	Size	Description
		 00h	BYTE	flags
				bit 0: exported
				bit 1: single data
				bits 2-7: unused???
		 01h	WORD	offset within segment

Format of new executable relocation data (immediately follows segment image):
Offset	Size	Description	(Table 1290)
 00h	WORD	number of relocation items
 02h 8N BYTEs	relocation items
		Offset	Size	Description
		 00h	BYTE	relocation type
				00h LOBYTE
				02h BASE
				03h PTR
				05h OFFS
				0Bh PTR48
				0Dh OFFS32
		 01h	BYTE	flags
				bit 2: additive
		 02h	WORD	offset within segment
		 04h	WORD	target address segment
		 06h	WORD	target address offset
SeeAlso: #1287,#1291

Format of new executable resource data:
Offset	Size	Description	(Table 1291)
 00h	WORD	alignment shift count for resource data
 02h  N RECORDs resources
	Format of resource record:
	Offset	Size	Description
	 00h	WORD	type ID
			0000h if end of resource records
			>= 8000h if integer type
			else offset from start of resource table to type string
	 02h	WORD	number of resources of this type
	 04h	DWORD	reserved for runtime use
	 08h  N Resources (see #1292)
Note:	resource type and name strings are stored immediately following the
	  resource table, and are not null-terminated
SeeAlso: #1292

Format of new executable resource entry:
Offset	Size	Description	(Table 1292)
 00h	WORD	offset in alignment units from start of file to contents of
		the resource data
 02h	WORD	length of resource image in bytes
 04h	WORD	flags
		bit 4: moveable
		bit 5: shareable
		bit 6: preloaded
 06h	WORD	resource ID
		>= 8000h if integer resource
		else offset from start of resource table to resource string
 08h	DWORD	reserved for runtime use
Notes:	resource type and name strings are stored immediately following the
	  resource table, and are not null-terminated
	strings are counted strings, with a string of length 0 indicating the
	  end of the resource table
SeeAlso: #1291,#1293

Format of new executable module reference table [one bundle of entries]:
Offset	Size	Description	(Table 1293)
 00h	BYTE	number of records in this bundle (00h if end of table)
 01h	BYTE	segment indicator
		00h unused
		FFh movable segment, segment number is in entry
		else segment number of fixed segment
 02h  N RECORDs
	Format of segment record
	Offset	Size	Description
	 00h	BYTE	flags
			bit 0: entry is exported
			bit 1: entry uses global (shared) data
			bits 7-3: number of parameter words
	---fixed segment---
	 01h	WORD	offset
	---moveable segment---
	 01h  2 BYTEs	INT 3F instruction (CDh 3Fh)
	 03h	BYTE	segment number
	 05h	WORD	offset
Note:	table entries are numbered starting from 1
SeeAlso: #1294

Format of new executable resident/nonresident name table entry:
Offset	Size	Description	(Table 1294)
 00h	BYTE	length of string (00h if end of table)
 01h  N BYTEs	ASCII text of string
 N+1	WORD	ordinal number (index into entry table)
Notes:	the first string in the resident name table is the module name; the
	  first entry in the nonresident name table is the module description
	the strings are case-sensitive; if the executable was linked with
	  /IGNORECASE, all strings are in uppercase
SeeAlso: #1293

Format of Linear Executable (enhanced mode executable) header:
Offset	Size	Description	(Table 1295)
 00h  2 BYTEs	"LE" (4Ch 45h) signature (Windows)
		"LX" (4Ch 58h) signature (OS/2)
 02h	BYTE	byte order (00h = little-endian, nonzero = big-endian)
 03h	BYTE	word order (00h = little-endian, nonzero = big-endian)
 04h	DWORD	executable format level
 08h	WORD	CPU type (see also INT 15/AH=C9h)
		01h Intel 80286 or upwardly compatible
		02h Intel 80386 or upwardly compatible
		03h Intel 80486 or upwardly compatible
		04h Intel Pentium (80586) or upwardly compatible
		20h Intel i860 (N10) or compatible
		21h Intel "N11" or compatible
		40h MIPS Mark I (R2000, R3000) or compatible
		41h MIPS Mark II (R6000) or compatible
		42h MIPS Mark III (R4000) or compatible
 0Ah	WORD	target operating system
		01h OS/2
		02h Windows
		03h European DOS 4.0
		04h Windows 386
 0Ch	DWORD	module version
 10h	DWORD	module type (see #1296)
 14h	DWORD	number of memory pages
 18h	Initial CS:EIP
	DWORD	object number
	DWORD	offset
 20h	Initial SS:ESP
	DWORD	object number
	DWORD	offset
 28h	DWORD	memory page size
 2Ch	DWORD	(Windows LE) bytes on last page
		(OS/2 LX) page offset shift count
 30h	DWORD	fixup section size
 34h	DWORD	fixup section checksum
 38h	DWORD	loader section size
 3Ch	DWORD	loader section checksum
 40h	DWORD	offset of object table (see #1297)
 44h	DWORD	object table entries
 48h	DWORD	object page map table offset (see #1299)
 4Ch	DWORD	object iterate data map offset
 50h	DWORD	resource table offset
 54h	DWORD	resource table entries
 58h	DWORD	resident names table offset (see #1300)
 5Ch	DWORD	entry table offset (see #1301,#1302)
 60h	DWORD	module directives table offset
 64h	DWORD	Module Directives entries
 68h	DWORD	Fixup page table offset
 6Ch	DWORD	Fixup record table offset (see #1304)
 70h	DWORD	imported modules name table offset
 74h	DWORD	imported modules count
 78h	DWORD	imported procedures name table offset
 7Ch	DWORD	per-page checksum table offset
 80h	DWORD	data pages offset
 84h	DWORD	preload page count
 88h	DWORD	non-resident names table offset
 8Ch	DWORD	non-resident names table length
 90h	DWORD	non-resident names checksum
 94h	DWORD	automatic data object
 98h	DWORD	debug information offset
 9Ch	DWORD	debug information length
 A0h	DWORD	preload instance pages number
 A4h	DWORD	demand instance pages number
 A8h	DWORD	extra heap allocation
 ACh 12 BYTEs	reserved
 B8h	DWORD	offset of VERSIONINFO resource (MS-Windows VxD only)
 BCh	DWORD	pointer to ??? (dynamically-loadable VxDs only???)
 C0h	WORD	device ID (MS-Windows VxD only)
 C2h	WORD	DDK version (MS-Windows VxD only)
Note:	used by EMM386.EXE, QEMM, and Windows 3.0 Enhanced Mode drivers

Bitfields for Linear Executable module type:
Bit(s)	Description	(Table 1296)
 2	initialization (only for DLLs) 0 = global, 1 = per-process
 4	no internal fixups in executable image
 5	no external fixups in executable image
 8-10	API compatibility
	0 = unknown
	1 = incompatible with PM windowing \
	2 = compatible with PM windowing    > (only for
	3 = uses PM windowing API	   /	programs)
 13	module not loadable (only for programs)
 15-17	module type
	000 program
	001 library (DLL)
	011 protected memory library module
	100 physical device driver
	110 virtual device driver
 30	per-process library termination
	(requires valid CS:EIP, can't be set for .EXE)

Format of object table entry:
Offset	Size	Description	(Table 1297)
 00h	DWORD	virtual size in bytes
 04h	DWORD	relocation base address
 08h	DWORD	object flags (see #1298)
 0Ch	DWORD	page map index
 10h	DWORD	page map entries (see #1299)
 14h  4 BYTEs	reserved??? (apparently always zeros)

Bitfields for object flags:
Bit(s)	Description	(Table 1298)
 0	readable
 1	writable
 2	executable
 3	resource
 4	discardable
 5	shared
 6	preloaded
 7	invalid
 8-9	type
	00 normal
	01 zero-filled
	10 resident
	11 resident and contiguous
 10	resident and long-lockable
 11	reserved
 12	16:16 alias required
 13	"BIG" (Huge: 32-bit)
 14	conforming
 15	"OBJECT_I/O_PRIVILEGE_LEVEL"
 16-31	reserved

Format of object page map table entry:
Offset	Size	Description	(Table 1299)
 00h	BYTE	??? (usually 00h)
 01h	WORD	(big-endian) index to fixup table
		0000h if no relocation info
 03h	BYTE	type (00h hard copy in file, 03h some relocation needed)

Format of resident names table entry:
Offset	Size	Description	(Table 1300)
 00h	BYTE	length of name
 01h  N BYTEs	name
 N+1  3 BYTEs	???

Format of LE linear executable entry table:
Offset	Size	Description	(Table 1301)
 00h	BYTE	number of entries in table
 01h 10 BYTEs per entry
		Offset	Size	Description
		 00h	BYTE	bit flags
				bit 0: non-empty bundle
				bit 1: 32-bit entry
		 01h	WORD	object number
		 03h	BYTE	entry type flags
				bit 0: exported
				bit 1: uses single data rather than instance
				bit 2: reserved
				bits 3-7: number of stack parameters
		 04h	DWORD	offset of entry point
		 08h  2 BYTEs	???
Note:	empty bundles (bit flags at 00h = 00h) are used to skip unused indices,
	  and do not contain the remaining nine bytes

Format of LX linear executable entry table [array]:
Offset	Size	Description	(Table 1302)
 00h	BYTE	number of bundles following (00h = end of entry table)
 01h	BYTE	bundle type
		00h empty
		01h 16-bit entry
		02h 286 callgate entry
		03h 32-bit entry
		04h forwarder entry
		bit 7 set if additional parameter typing information is present
---bundle type 00h---
 no additional fields
---bundle type 01h---
 02h	WORD	object number
 04h	BYTE	entry flags
		bit 0: exported
		bits 7-3: number of stack parameters
 05h	WORD	offset of entry point in object (shifted by page size shift)
---bundle type 02h---
 02h	WORD	object number
 04h	BYTE	entry flags
		bit 0: exported
		bits 7-3: number of stack parameters
 05h	WORD	offset of entry point in object
 07h	WORD	reserved for callgate selector (used by loader)
---bundle type 03h---
 02h	WORD	object number
 04h	BYTE	entry flags
		bit 0: exported
		bits 7-3: number of stack parameters
 05h	DWORD	offset of entry point in object
---bundle type 04h---
 02h	WORD	reserved
 04h	BYTE	forwarder flags
		bit 0: import by ordinal
		bits 7-1 reserved
 05h	WORD	module ordinal
		(forwarder's index into Import Module Name table)
 07h	DWORD	procedure name offset or import ordinal number
Note:	all fields after the first two bytes are repeated N times

Bitfields for linear executable fixup type:
Bit(s)	Description	(Table 1303)
 7	ordinal is BYTE rather than WORD
 6	16-rather than 8-object number/module ordinal
 5	addition with DWORD rather than WORD
 4	relocation info has size with new two bytes at end
 3	reserved (0)
 2	set if add to destination, clear to replace destination
 1-0	type
	00 internal fixup
	01 external fixup, imported by ordinal
	10 external fixup, imported by name
	11 internal fixup via entry table

Format of linear executable fixup record:
Offset	Size	Description	(Table 1304)
 00h	BYTE	type
		bits 7-4: modifier (0001 single, 0011 multiple)
		bits 3-0: type
			0000 byte offset
			0010 word segment
			0011 16-bit far pointer (DWORD)
			0101 16-bit offset
			0110 32-bit far pointer (PWORD)
			0111 32-bit offset
			1000 near call or jump, WORD/DWORD based on seg attrib
 01h	BYTE	linear executable fixup type (see #1303)
---if single type---
 02h	WORD	offset within page
 04h	relocation information
	---internal fixup---
	BYTE	object number
	---external,ordinal---
	BYTE	one-based module number in Import Module table
	BYTE/WORD ordinal number
	WORD/DWORD value to add (only present if modifier bit 4 set)
	---external,name---
	BYTE	one-based module number in Import Module table
	WORD	offset in Import Procedure names
	WORD/DWORD value to add (only present if modifier bit 4 set)
---if multiple type---
 02h	BYTE	number of items
 03h	var	relocation info as for "single" type (above)
      N WORDs	offsets of items to relocate

Format of old Phar Lap .EXP file header:
Offset	Size	Description	(Table 1305)
 00h  2 BYTEs	"MP" (4Dh 50h) signature
 02h	WORD	remainder of image size / page size (page size = 512h)
 04h	WORD	size of image in pages
 06h	WORD	number of relocation items
 08h	WORD	header size in paragraphs
 0Ah	WORD	minimum number of extra 4K pages to be allocated at the end
		  of program, when it is loaded
 0Ch	WORD	maximum number of extra 4K pages to be allocated at the end
		  of program, when it is loaded
 0Eh	DWORD	initial ESP
 12h	WORD	word checksum of file
 14h	DWORD	initial EIP
 18h	WORD	offset of first relocation item
 1Ah	WORD	overlay number
 1Ch	WORD	??? (wants to be 1)
SeeAlso: #1306

Format of new Phar Lap .EXP file header:
Offset	Size	Description	(Table 1306)
 00h  2 BYTEs	signature ("P2" for 286 .EXP executable, "P3" for 386 .EXP)
 02h	WORD	level (01h flat-model file, 02h multisegmented file)
 04h	WORD	header size
 06h	DWORD	file size in bytes
 0Ah	WORD	checksum
 0Ch	DWORD	offset of run-time parameters within file (see #1308)
 10h	DWORD	size of run-time parameters in bytes
 14h	DWORD	offset of relocation table within file
 18h	DWORD	size of relocation table in bytes
 1Ch	DWORD	offset of segment information table within file (see #1307)
 20h	DWORD	size of segment information table in bytes
 24h	WORD	size of segment information table entry in bytes
 26h	DWORD	offset of load image within file
 2Ah	DWORD	size of load image on disk
 2Eh	DWORD	offset of symbol table within file or 00000000h
 32h	DWORD	size of symbol table in bytes
 36h	DWORD	offset of GDT within load image
 3Ah	DWORD	size of GDT in bytes
 3Eh	DWORD	offset of LDT within load image
 42h	DWORD	size of LDT in bytes
 46h	DWORD	offset of IDT within load image
 4Ah	DWORD	size of IDT in bytes
 4Eh	DWORD	offset of TSS within load image
 52h	DWORD	size of TSS in bytes
 56h	DWORD	minimum number of extra bytes to be allocated at end of program
		(level 1 executables only)
 5Ah	DWORD	maximum number of extra bytes to be allocated at end of program
		(level 1 executables only)
 5Eh	DWORD	base load offset (level 1 executables only)
 62h	DWORD	initial ESP
 66h	WORD	initial SS
 68h	DWORD	initial EIP
 6Ch	WORD	initial CS
 6Eh	WORD	initial LDT
 70h	WORD	initial TSS
 72h	WORD	flags
		bit 0: load image is packed
		bit 1: 32-bit checksum is present
		bits 4-2: type of relocation table
 74h	DWORD	memory requirements for load image
 78h	DWORD	32-bit checksum (optional)
 7Ch	DWORD	size of stack segment in bytes
 80h 256 BYTEs	reserved (0)
SeeAlso: #1305,#1309

Format of Phar Lap segment information table entry:
Offset	Size	Description	(Table 1307)
 00h	WORD	selector number
 02h	WORD	flags
 04h	DWORD	base offset of selector
 08h	DWORD	minimum number of extra bytes to be allocated to the segment

Format of 386|DOS-Extender run-time parameters:
Offset	Size	Description	(Table 1308)
 00h  2 BYTEs	signature "DX" (44h 58h)
 02h	WORD	minimum number of real-mode params to leave free at run time
 04h	WORD	maximum number of real-mode params to leave free at run time
 06h	WORD	minimum interrupt buffer size in KB
 08h	WORD	maximum interrupt buffer size in KB
 0Ah	WORD	number of interrupt stacks
 0Ch	WORD	size in KB of each interrupt stack
 0Eh	DWORD	offset of byte past end of real-mode code and data
 12h	WORD	size in KB of call buffers
 14h	WORD	flags
		bit 0: file is virtual memory manager
		bit 1: file is a debugger
 16h	WORD	unprivileged flag (if nonzero, executes at ring 1, 2, or 3)
 18h 104 BYTEs	reserved (0)

Format of Phar Lap repeat block header:
Offset	Size	Description	(Table 1309)
 00h	WORD	byte count
 02h	BYTE	repeat string length

Format of Borland debugging information header (following load image):
Offset	Size	Description	(Table 1310)
 00h	WORD	signature 52FBh
 02h	WORD	version ID
 04h	DWORD	size of name pool in bytes
 08h	WORD	number of names in name pool
 0Ah	WORD	number of type entries
 0Ch	WORD	number of structure members
 0Eh	WORD	number of symbols
 10h	WORD	number of global symbols
 12h	WORD	number of modules
 14h	WORD	number of locals (optional)
 16h	WORD	number of scopes in table
 18h	WORD	number of line-number entries
 1Ah	WORD	number of include files
 1Ch	WORD	number of segment records
 1Eh	WORD	number of segment/file correlations
 20h	DWORD	size of load image after removing uninitialized data and debug
		  information
 24h	DWORD	debugger hook; pointer into debugged program whose meaning
		  depends on program flags
 28h	BYTE	program flags
		bit 0: case-sensitive link
		bit 1: pascal overlay program
 29h	WORD	no longer used
 2Bh	WORD	size of data pool in bytes
 2Dh	BYTE	padding
 2Eh	WORD	size of following header extension (currently 00h, 10h, or 20h)
 30h	WORD	number of classes
 32h	WORD	number of parents
 34h	WORD	number of global classes (currently unused)
 36h	WORD	number of overloads (currently unused)
 38h	WORD	number of scope classes
 3Ah	WORD	number of module classes
 3Ch	WORD	number of coverage offsets
 3Eh	DWORD	offset relative to symbol base of name pool
 42h	WORD	number of browser information records
 44h	WORD	number of optimized symbol records
 46h	WORD	debugging flags
 48h  8 BYTEs	padding
Note:	additional information on the Borland debugging info may be found in
	  Borland's Open Architecture Handbook
SeeAlso: #1286
--------U-214B-------------------------------
INT 21 - ELRES v1.0 only - INSTALLATION CHECK
	AH = 4Bh
	DS:DX = 0000h:0000h
Return: ES:BX -> ELRES history structure (see #1069 at AH=2Bh/CX=454Ch)
	DX = DABEh (signature, DAve BEnnett)
Program: ELRES is an MS-DOS return code (errorlevel) recorder by David H.
	  Bennett
SeeAlso: AH=2Bh/CX=454Ch
--------v-214B04-----------------------------
INT 21 - VIRUS - "MG", "699"/"Thirteen Minutes" - INSTALLATION CHECK
	AX = 4B04h
Return: CF clear if "MG" resident
	AX = 044Bh if "699"/"Thirteen Minutes" resident
SeeAlso: AX=4243h,AH=4Ah/BX=FFFFh,AX=4B21h
--------D-214B05-----------------------------
INT 21 - DOS 5+ - SET EXECUTION STATE
	AX = 4B05h
	DS:DX -> execution state structure (see #1311)
Return: CF clear if successful
	    AX = 0000h
	CF set on error
	    AX = error code (see #1366 at AH=59h/BX=0000h)
Note:	used by programs which intercept AX=4B00h to prepare new programs for
	  execution (including setting the DOS version number).	 No DOS, BIOS
	  or other software interrupt may be called after return from this call
	  before commencement of the child process.  If DOS is running in the
	  HMA, A20 is turned off on return from this call.
SeeAlso: AH=4Bh

Format of execution state structure:
Offset	Size	Description	(Table 1311)
 00h	WORD	reserved (00h)
 02h	WORD	type flags
		bit 0: program is an .EXE
		bit 1: program is an overlay
 04h	DWORD	pointer to ASCIZ name of program file
 08h	WORD	PSP segment of new program
 0Ah	DWORD	starting CS:IP of new program
 0Eh	DWORD	program size including PSP
----------214B18DX0010-----------------------
INT 21 U - FBOOT v2.13 - PERFORM FAST BOOTSTRAP
	AX = 4B18h
	DX = 0010h
	BX = disk selector
	    0000h boot from floppy
	    0080h boot from hard disk
Return: never if FastBoot installed
Program: CyberWare FastBoot allows fast warm boots by skipping CMOS
	  checking, ROM scan, RAM & peripheral components test
Note:	the only installation check is a search for a character device
	  driver called FBOOT$$$
--------v-214B20-----------------------------
INT 21 - VIRUS - "Holocaust"/"Telefonica" - ???
	AX = 4B20h
SeeAlso: AX=4B04h,AX=4B21h
--------v-214B21-----------------------------
INT 21 C - VIRUS - "Holocaust"/"Telefonica" - ???
	AX = 4B21h
Note:	called at completion of virus installation
SeeAlso: AX=4B04h,AX=4B20h,AX=4B25h
--------v-214B25-----------------------------
INT 21 - VIRUS - "1063"/"Mono" - INSTALLATION CHECK
	AX = 4B25h
Return: DI = 1234h if resident
SeeAlso: AX=4B21h,AX=4B40h
--------v-214B40-----------------------------
INT 21 - VIRUS - "Plastique"/"AntiCad" - INSTALLATION CHECK
	AX = 4B40h
Return: AX = 5678h if resident
SeeAlso: AX=4B25h,AX=4B41h,AX=4B4Ah
--------v-214B41-----------------------------
INT 21 - VIRUS - "Plastique"/"AntiCad" - ???
	AX = 4B41h
	???
Return: ???
SeeAlso: AX=4B40h
--------v-214B4A-----------------------------
INT 21 - VIRUS - "Jabberwocky" - INSTALLATION CHECK
	AX = 4B4Ah
Return: AL = 57h if resident
SeeAlso: AX=4B40h,AX=4B4Bh
--------v-214B4B-----------------------------
INT 21 - VIRUS - "Horse-2" - INSTALLATION CHECK
	AX = 4B4Bh
Return: CF clear if resident
SeeAlso: AX=4B4Ah,AX=4B4Dh
--------v-214B4D-----------------------------
INT 21 - VIRUS - "Murphy-2", "Patricia"/"Smack" - INSTALLATION CHECK
	AX = 4B4Dh
Return: CF clear if resident
SeeAlso: AX=4B4Ah,AX=4B50h
--------v-214B50-----------------------------
INT 21 - VIRUS - "Plastique-2576"/"AntiCad-2576" - INSTALLATION CHECK
	AX = 4B50h
Return: AX = 1234h if resident
SeeAlso: AX=4B4Dh,AX=4B53h,AX=4B60h
--------v-214B53-----------------------------
INT 21 - VIRUS - "Horse" - INSTALLATION CHECK
	AX = 4B53h
Return: CF clear if resident
SeeAlso: AX=4B50h,AX=4B53h/BX=2121h,AX=4B55h
--------v-214B53BX2121-----------------------
INT 21 - VIRUS - "One Half" - INSTALLATION CHECK
	AX = 4B53h
	BX = 2121h
	CX = 1212h
	DX = 0236h
Return: AX = 454Bh if installed
SeeAlso: AX=4B50h,AX=4B53h,AX=4B55h
--------v-214B55-----------------------------
INT 21 - VIRUS - "Sparse" - INSTALLATION CHECK
	AX = 4B55h
Return: AX = 1231h if resident
SeeAlso: AX=4B53h,AX=4B59h
--------v-214B59-----------------------------
INT 21 - VIRUS - "Murphy-1", "Murphy-4" - INSTALLATION CHECK
	AX = 4B59h
Return: CF clear if resident
SeeAlso: AX=4B50h,AX=4B5Eh
--------v-214B5E-----------------------------
INT 21 - VIRUS - "Brothers" - INSTALLATION CHECK
	AX = 4B5Eh
Return: CF clear if resident
SeeAlso: AX=4B59h,AX=4B87h
--------v-214B60-----------------------------
INT 21 - VIRUS - "Plastique-2576"/"AntiCad-2576" - ???
	AX = 4B60h
	???
Return: ???
SeeAlso: AX=4B50h
--------O-214B80-----------------------------
INT 21 - DR DOS v3.41 - RUN ALREADY-LOADED KERNEL FILE
	AX = 4B80h
	DS:DX -> ASCIZ name of program to EXEC
	ES = segment of PSP for kernel file
Return: only if call failed
Note:	DR DOS uses this call after an AX=4B01h to load the kernel file into
	  memory and patching the program's parent-PSP field to point at itself
SeeAlso: AH=4Bh"EXEC"
--------v-214B87-----------------------------
INT 21 - VIRUS - "Shirley" - INSTALLATION CHECK
	AX = 4B87h
Return: AX = 6663h if resident
SeeAlso: AX=4B5Eh,AX=4B95h
--------v-214B95-----------------------------
INT 21 - VIRUS - "Zherkov-1882" - INSTALLATION CHECK
	AX = 4B95h
Return: AX = 1973h if resident
SeeAlso: AX=4B87h,AX=4BA7h
--------v-214BA7-----------------------------
INT 21 - VIRUS - "1876"/"Dash-em" - INSTALLATION CHECK
	AX = 4BA7h
Return: AX = B459h if resident
SeeAlso: AX=4B95h,AX=4BAAh
--------v-214BAA-----------------------------
INT 21 - VIRUS - "Nomenklatura" - INSTALLATION CHECK
	AX = 4BAAh
Return: CF clear if resident
SeeAlso: AX=4BA7h,AX=4BAFh
--------v-214BAF-----------------------------
INT 21 - VIRUS - "948"/"Screenplus1", "Magnitogorsk" - INSTALLATION CHECK
	AX = 4BAFh
Return: AL = AFh if "Magnitogorsk" resident
	AL = FAh if "948"/"Screenplus1" resident
SeeAlso: AX=4BAAh,AX=4BB1h"VIRUS"
--------v-214BB1-----------------------------
INT 21 - VIRUS - "UZZY" -INSTALLATION CHECK
	AX = 4BB1h
Return: CL = 04h if resident
SeeAlso: AX=4BAFh"VIRUS",AX=4BDDh"VIRUS"
--------v-214BDD-----------------------------
INT 21 - VIRUS - "Lozinsky"/"Zherkov" - INSTALLATION CHECK
	AX = 4BDDh
Return: AX = 1234h
SeeAlso: AX=4BB1h"VIRUS",AX=4BFEh
--------v-214BEE-----------------------------
INT 21 - F-DRIVER.SYS v1.14+ - GRAB INT 21
	AX = 4BEEh
Return: AX = status
	    1234h grab was successful
	    2345h failed (INT 21 grabbed previously)
Program: F-DRIVER.SYS is part of the shareware F-PROT virus/trojan protection
	  package by Fridrik Skulason
Note:	when called the first time, this function moves the INT 21 monitoring
	  code from its original location in the INT 21 chain to be the first
	  thing called by INT 21.  This is the mechanism used by F-NET.
SeeAlso: INT 2F/AX=4653h/CX=0002h,INT 2F/AX=4653h/CX=0007h
--------k-214BF0-----------------------------
INT 21 - DIET v1.10+ (Overlay Mode) - INSTALLATION CHECK
	AX = 4BF0h
Return: CF clear if installed
	    AX = 899Dh
Program: DIET is an executable-compression program by Teddy Matsumoto
SeeAlso: AX=37D0h,AX=4BF1h
--------k-214BF1-----------------------------
INT 21 - DIET v1.10+ (Overlay Mode) - EXPAND PROGRAM???
	AX = 4BF1h
Return: ???
SeeAlso: AX=37D0h,AX=4BF0h
--------v-214BF1-----------------------------
INT 21 - VIRUS - "Jerusalem 2" - INSTALLATION CHECK
	AX = 4BF1h
Return: AX = 1FB4h if resident
SeeAlso: AH=3Fh/BX=FEB0h"VIRUS",AX=4BDDh"VIRUS",AX=4BFEh"VIRUS"
--------v-214BFE-----------------------------
INT 21 - VIRUS - "Hitchcock", "Dark Avenger-1028", "1193" - INSTALLATION CHECK
	AX = 4BFEh
Return: AX = 1234h if "Hitchcock" or "Storm" resident
	AX = ABCDh if "1193"/"Copyright" resident
	DI = 55BBh if "Dark Avenger-1028" resident
SeeAlso: AX=4BDDh,AX=4BF1h"VIRUS",AX=4BFFh"Justice"
--------v-214BFF-----------------------------
INT 21 - VIRUS - "USSR-707", "Justice", "Europe 92" - INSTALLATION CHECK
	AX = 4BFFh
Return: BL = FFh if "USSR-707" resident
	DI = 55AAh if "Justice" resident
	AX = 1234h if "Hitchcock.1238" resident
	CF clear if "Europe 92" resident
SeeAlso: AX=4BFEh,AX=4BFFh"Cascade",AX=5252h
--------v-214BFFSI0000-----------------------
INT 21 - VIRUS - "Cascade" - INSTALLATION CHECK
	AX = 4BFFh
	SI = 0000h
	DI = 0000h
Return: DI = 55AAh if installed
SeeAlso: AX=4BFFh"Justice",AX=5252h
--------D-214C-------------------------------
INT 21 - DOS 2+ - "EXIT" - TERMINATE WITH RETURN CODE
	AH = 4Ch
	AL = return code
Return: never returns
Notes:	unless the process is its own parent
	  (see #1066 [offset 16h] at AH=26h), all open files are closed and
	  all memory belonging to the process is freed
	all network file locks should be removed before calling this function
SeeAlso: AH=00h,AH=26h,AH=4Bh,AH=4Dh,INT 15/AH=12h/BH=02h,INT 20,INT 22
SeeAlso: INT 60/DI=0601h
--------m-214C57-----------------------------
INT 21 - Headroom - ???
	AX = 4C57h
	DS:DX -> target address
Note:	jumps to target address instead of terminating program
SeeAlso: AX=5758h
--------D-214D-------------------------------
INT 21 - DOS 2+ - GET RETURN CODE (ERRORLEVEL)
	AH = 4Dh
Return: AH = termination type
	    00h normal (INT 20,INT 21/AH=00h, or INT 21/AH=4Ch)
	    01h control-C abort
	    02h critical error abort
	    03h terminate and stay resident (INT 21/AH=31h or INT 27)
	AL = return code
	CF clear
Notes:	the word in which DOS stores the return code is cleared after being
	  read by this function, so the return code can only be retrieved once
	COMMAND.COM stores the return code of the last external command it
	  executed as ERRORLEVEL
	this call should not be used if the child was started with AX=4B04h;
	  use AH=8Ah instead
	the following sequence will close a Virtual DOS Machine under OS/2 2.0
	  through OS/2 Merlin (but may change in the future):
	    MOV	AH,4Dh
	    INT	21h
	    HLT
	    DB	02h,0FDh
	  This sequence is the only way to close a specific VDM which was
	  booted from floppy or a disk image.
SeeAlso: AH=4Bh,AH=4Ch,AH=8Ah
--------D-214E-------------------------------
INT 21 - DOS 2+ - "FINDFIRST" - FIND FIRST MATCHING FILE
	AH = 4Eh
	AL = special flag for use by APPEND (refer to note below)
	CX = file attribute mask (see #1107 at AX=4301h) (bits 0 and 5 ignored)
	    0088h (Novell DOS 7) find first deleted file
	DS:DX -> ASCIZ file specification (may include path and wildcards)
Return: CF clear if successful
	    Disk Transfer Area filled with FindFirst data block (see #1312)
	CF set on error
	    AX = error code (02h,03h,12h) (see #1366 at AH=59h/BX=0000h)
Notes:	for search attributes other than 08h, all files with at MOST the
	  specified combination of hidden, system, and directory attributes
	  will be returned.  Under DOS 2.x, searching for attribute 08h
	  (volume label) will also return normal files, while under DOS 3.0+
	  only the volume label (if any) will be returned.
	this call also returns successfully if given the name of a character
	  device without wildcards.  DOS 2.x returns attribute 00h, size 0,
	  and the current date and time.  DOS 3.0+ returns attribute 40h and
	  the current date and time.
	immediately after an INT 2F/AX=B711h (APPEND return found name), the
	  name at DS:DX will be overwritten; if AL=00h on entry, the actual
	  found pathname will be stored, otherwise, the actual found path
	  will be prepended to the original filespec without a path.
	under LANtastic, this call may be used to obtain a list of a server's
	  shared resources by searching for "\\SERVER\*.*"; a list of printer
	  resources may be obtained by searching for "\\SERVER\@*.*"
	under the FlashTek X-32 DOS extender, the filespec pointer is in DS:EDX
BUGS:	under DOS 3.x and 4.x, the second and subsequent calls to this function
	  with a character device name (no wildcards) and search attributes
	  which include the volume-label bit (08h) will fail unless there is
	  an intervening DOS call which implicitly or explicity performs a
	  directory search without the volume-label bit.  Such implicit
	  searches are performed by CREATE (AH=3Ch), OPEN (AH=3Dh), UNLINK
	  (AH=41h), and RENAME (AH=56h)
	DR DOS 3.41 and 5.0 return the Directory attribute for the volume label
SeeAlso: AH=11h,AH=4Fh,AX=4301h,AX=714Eh,AX=71A1h,AX=F257h/SF=02h
SeeAlso: INT 2F/AX=111Bh,INT 2F/AX=B711h

Format of FindFirst data block:
Offset	Size	Description	(Table 1312)
---PC-DOS 3.10, PC-DOS 4.01, MS-DOS 3.2/3.3/5.0---
 00h	BYTE	drive letter (bits 0-6), remote if bit 7 set
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
---PC-DOS 4.01, MS-DOS 3.2/3.3/5.0---
 0Dh	WORD	entry count within directory
 0Fh	WORD	cluster number of start of parent directory
 11h  4 BYTEs	reserved
---OS/2 MVDM---
 00h	WORD	"OS2_BMP_handle"
 02h	WORD	"OS2_LastEnt"
 04h	DWORD	"OS2_Checksum"
 08h	BYTE	"OS2_usi_flag"
 09h	DWORD	used by DOS emulator for second pass for volume-label searches
 0Dh	WORD	(ret) "DOS_LastEnt" entry count within directory
 0Fh	BYTE	OS/2 Processed-FindFirst flag
		00h FindFirst processed by DOS
		42h FindFirst processed by OS/2
 10h  5 BYTEs	reserved for future use
---all versions, documented fields---
 15h	BYTE	attribute of file found
 16h	WORD	file time (see #1351 at AX=5700h)
 18h	WORD	file date (see #1352 at AX=5700h)
 1Ah	DWORD	file size
 1Eh 13 BYTEs	ASCIZ filename+extension
--------f-214E-------------------------------
INT 21 - WILDUNIX.COM internal - INSTALLATION CHECK
	AH = 4Eh
	DS:DX = 0000h:0000h
Return: AH = 99h if installed
Program: WILDUNIX.COM is a resident Unix-style wildcard expander by Steve
	  Hosgood and Terry Barnaby
--------D-214F-------------------------------
INT 21 - DOS 2+ - "FINDNEXT" - FIND NEXT MATCHING FILE
	AH = 4Fh
	Disk Transfer Area contains data block from previous FindFirst or
	  FindNext call
Return: CF clear if successful
	    Disk Transfer Area updated
	CF set on error
	    AX = error code (12h) (see #1366 at AH=59h/BX=0000h)
Notes:	under Novell DOS 7, if the FindFirst call (AH=4Eh) had CX=0088h, then
	  the next matching deleted file will be returned
	since the entire state of a FindFirst/FindNext sequence is contained
	  in the data block in the DTA, other disk operations such as renaming,
	  moving, deleting, or creating files can cause inaccurate directory
	  searches, such as finding the same file twice
BUG:	DR DOS 3.41 and 5.0 return the Directory attribute for the volume label
SeeAlso: AH=12h,AH=4Eh,AX=714Fh,AX=71A1h
--------D-2150-------------------------------
INT 21 - DOS 2+ internal - SET CURRENT PROCESS ID (SET PSP ADDRESS)
	AH = 50h
	BX = segment of PSP for new process
Notes:	DOS uses the current PSP address to determine which processes own files
	  and memory; it corresponds to process identifiers used by other OSs
	under DOS 2.x, this function cannot be invoked inside an INT 28h
	  handler without setting the Critical Error flag
	under MS-DOS 3.0+ and DR DOS 3.41+, this function does not use any of
	  the DOS-internal stacks and may thus be called at any time, even
	  during another INT 21h call
	some Microsoft applications such as Quick C 2.51 use segments of 0000h
	  and FFFFh and direct access to the SDA (see #1373 at AX=5D06h) to
	  test whether they are running under MS-DOS rather than a compatible
	  OS; although one should only call this function with valid PSP
	  addresses, any program hooking it should be prepared to handle
	  invalid addresses
	this function is supported by the OS/2 compatibility box
	this call was undocumented prior to the release of DOS 5.0
SeeAlso: AH=26h,AH=51h,AH=62h
--------v-2150FD-----------------------------
INT 21 - VIRUS - "Predator 2" - INSTALLATION CHECK
	AX = 50FDh
Return: AX = FD50h if resident
SeeAlso: AX=4BFFh"VIRUS",AX=5454h"VIRUS"
--------D-2151-------------------------------
INT 21 - DOS 2+ internal - GET CURRENT PROCESS ID (GET PSP ADDRESS)
	AH = 51h
Return: BX = segment of PSP for current process
Notes:	DOS uses the current PSP address to determine which processes own files
	  and memory; it corresponds to process identifiers used by other OSs
	under DOS 2.x, this function cannot be invoked inside an INT 28h
	  handler without setting the Critical Error flag
	under DOS 3.0+, this function does not use any of the DOS-internal
	  stacks and may thus be called at any time, even during another
	  INT 21h call
	supported by OS/2 compatibility box
	identical to the documented AH=62h
	this call was undocumented prior to the release of DOS 5.0
SeeAlso: AH=26h,AH=50h,AH=62h
--------D-2152-------------------------------
INT 21 U - DOS 2+ internal - "SYSVARS" - GET LIST OF LISTS
	AH = 52h
Return: ES:BX -> DOS list of lists (see #1313)
Notes:	partially supported by OS/2 v1.1 compatibility box (however, most
	  pointers are FFFFh:FFFFh, LASTDRIVE is FFh, and the NUL header "next"
	  pointer is FFFFh:FFFFh).
	partially supported by the Windows NT DOS box; contains only a
	  rudimentary Current Directory Structure (see #1331)
	on return, ES points at the DOS data segment (see also INT 2F/AX=1203h)
	Quarterdeck's suggested check for the use of its DOSDATA.SYS or
	  DOS-UP.SYS is to test whether the list-of-lists segment is greater
	  than the segment of the first memory block; a better check for
	  DOS-UP.SYS is INT 21/AX=2B01h/CX=444Dh
	because not all DOS workalikes support all fields in the List of Lists,
	  applications should ensure that pointers are neither 0000h:0000h
	  nor FFFFh:FFFFh before using them
	Windows for Workgroups 3.11 network and Windows95 set the path to
	  the local drive and directory even for network drives; in that
	  case the UNC form \\SERVER\SHARE can be obtained with
	  INT 21/AX=5F02h or INT 21/AX=5F46h. LapLink RemoteAccess does the
	  same even for INT 21/AX=5F02h
	Windows95 GUI no longer returns the true path for a SUBSTed drive,
	  but MS-DOS 7.00 does; use INT 21/AH=60h to obtain the true name
SeeAlso: INT 2F/AX=1203h

Format of List of Lists:
Offset	Size	Description	(Table 1313)
 -24	WORD	(DOS 3.1+) contents of CX from INT 21/AX=5E01h
 -22	WORD	(DOS ???+) LRU counter for FCB caching
 -20	WORD	(DOS ???+) LRU counter for FCB opens
 -18	DWORD	(DOS ???+) address of OEM function handler (see INT 21/AH=F8h)
			FFFFh:FFFFh if not installed or not available
 -14	WORD	(DOS ???+) offset in DOS CS of code to return from INT 21 call
 -12	WORD	(DOS 3.1+) sharing retry count (see AX=440Bh)
 -10	WORD	(DOS 3.1+) sharing retry delay (see AX=440Bh)
 -8	DWORD	(DOS 3.0+) pointer to current disk buffer
 -4	WORD	(DOS 3.0+) pointer in DOS data segment of unread CON input
		when CON is read via a handle, DOS reads an entire line,
		  and returns the requested portion, buffering the rest
		  for the next read.  0000h indicates no unread input
 -2	WORD	segment of first memory control block (see #1314)
 00h	DWORD	pointer to first Drive Parameter Block (see #1083 at AH=32h)
 04h	DWORD	-> first System File Table (see #1325,#1326,#1327,#1328)
 08h	DWORD	pointer to active CLOCK$ device's header (most recently loaded
		  driver with CLOCK bit set)
 0Ch	DWORD	pointer to active CON device's header (most recently loaded
		  driver with STDIN bit set)
---DOS 2.x---
 10h	BYTE	number of logical drives in system
 11h	WORD	maximum bytes/block of any block device
 13h	DWORD	pointer to first disk buffer (see #1335,#1336)
 17h 18 BYTEs	actual NUL device driver header (not a pointer!)
		NUL is always the first device on DOS's linked list of device
		  drivers. (see #1332)
---DOS 3.0---
 10h	BYTE	number of block devices
 11h	WORD	maximum bytes/block of any block device
 13h	DWORD	pointer to first disk buffer (see #1336,#1338)
 17h	DWORD	pointer to array of current directory structures (see #1329)
 1Bh	BYTE	value of LASTDRIVE command in CONFIG.SYS (default 5)
 1Ch	DWORD	pointer to STRING= workspace area
 20h	WORD	size of STRING area (the x in STRING=x from CONFIG.SYS)
 22h	DWORD	pointer to FCB table
 26h	WORD	the y in FCBS=x,y from CONFIG.SYS
 28h 18 BYTEs	actual NUL device driver header (not a pointer!)
		NUL is always the first device on DOS's linked list of device
		  drivers. (see #1332)
---DOS 3.1-3.3---
 10h	WORD	maximum bytes per sector of any block device
 12h	DWORD	pointer to first disk buffer in buffer chain (see #1336)
 16h	DWORD	pointer to array of current directory structures (see #1329)
 1Ah	DWORD	pointer to system FCB tables (see #1326,#1327,#1328)
 1Eh	WORD	number of protected FCBs (the y in the CONFIG.SYS FCBS=x,y)
 20h	BYTE	number of block devices installed
 21h	BYTE	number of available drive letters (largest of 5, installed
		  block devices, and CONFIG.SYS LASTDRIVE=).  Also size of
		  current directory structure array.
 22h 18 BYTEs	actual NUL device driver header (not a pointer!)
		NUL is always the first device on DOS's linked list of device
		  drivers. (see #1332)
 34h	BYTE	number of JOIN'ed drives
---DOS 4.x---
 10h	WORD	maximum bytes per sector of any block device
 12h	DWORD	pointer to disk buffer info record (see #1338,#1339)
		Note: although the initialization code in IO.SYS uses this
		  pointer, MSDOS.SYS does not, instead using the hardcoded
		  address of the info record
 16h	DWORD	pointer to array of current directory structures
		(see #1329,#1330)
 1Ah	DWORD	pointer to system FCB tables (see #1326,#1327,#1328)
 1Eh	WORD	number of protected FCBs (the y in the CONFIG.SYS FCBS=x,y)
		(always 00h for DOS 5.0)
 20h	BYTE	number of block devices installed
 21h	BYTE	number of available drive letters (largest of 5, installed
		  block devices, and CONFIG.SYS LASTDRIVE=).  Also size of
		  current directory structure array.
 22h 18 BYTEs	actual NUL device driver header (not a pointer!)
		NUL is always the first device on DOS's linked list of device
		  drivers. (see #1332)
 34h	BYTE	number of JOIN'ed drives
 35h	WORD	pointer within IBMDOS code segment to list of special program
		  names (see #1348)
		(always 0000h for DOS 5.0)
 37h	DWORD	pointer to FAR routine for resident IFS utility functions
		(see #1344)
		may be called by any IFS driver which does not wish to
		  service functions 20h or 24h-28h itself
 3Bh	DWORD	pointer to chain of IFS (installable file system) drivers
 3Fh	WORD	the x in BUFFERS x,y (rounded up to multiple of 30 if in EMS)
 41h	WORD	number of lookahead buffers (the y in BUFFERS x,y)
 43h	BYTE	boot drive (1=A:)
 44h	BYTE	flag: 01h to use DWORD moves (80386+), 00h otherwise
 45h	WORD	extended memory size in KB
---DOS 5.0-6.0---
 10h 39 BYTEs	as for DOS 4.x (above)
 37h	DWORD	pointer to SETVER program list or 0000h:0000h
 3Bh	WORD	(DOS=HIGH) offset in DOS CS of function to fix A20 control
		  when executing special .COM format
 3Dh	WORD	PSP of most-recently EXECed program if DOS in HMA, 0000h if low
		used for maintaining count of INT 21 calls which disable A20
		  on return
 3Fh  8 BYTEs	as for DOS 4.x (above)
---Windows NT DOS Box---
 10h  6 BYTEs	???
 16h	DWORD	pointer to array of current directory structures (see #1331)
 1Ah  6 BYTEs	???
 20h	BYTE	number of block devices installed
 21h	BYTE	number of local drive letters (= installed block devices)
		Also size of current directory structure array.
 22h 18 BYTEs	actual NUL device driver header (not a pointer!)
		NUL is always the first device on DOS's linked list of device
		  drivers. (see #1332)

Format of DOS memory control block:
Offset	Size	Description	(Table 1314)
 00h	BYTE	block type: 5Ah if last block in chain, otherwise 4Dh
 01h	WORD	PSP segment of owner or special flag value (see #1315)
 03h	WORD	size of memory block in paragraphs
 05h  3 BYTEs	unused by MS-DOS
		(386MAX) if locked-out block, region start/prev region end
---DOS 2.x,3.x---
 08h  8 BYTEs	unused
---DOS 4.0+ ---
 08h  8 BYTEs	ASCII program name if PSP memory block or DR DOS UMB,
		  else garbage
		null-terminated if less than 8 characters
Notes:	the next MCB is at segment (current + size + 1)
	under DOS 3.1+, the first memory block is the DOS data segment,
	  containing installable drivers, buffers, etc.	 Under DOS 4.0+ it is
	  divided into subsegments, each with its own memory control block
	  (see #1319), the first of which is at offset 0000h.
	for DOS 5+, blocks owned by DOS may have either "SC" or "SD" in bytes
	  08h and 09h.	"SC" is system code or locked-out inter-UMB memory,
	  "SD" is system data, device drivers, etc.
	Some versions of DR DOS use only seven characters of the program name,
	  placing a NUL in the eighth byte.
SeeAlso: #1316,#1318,#1319

(Table 1315)
Values for special flag PSP segments:
 0000h	free
 0006h	DR DOS XMS UMB
 0007h	DR DOS excluded upper memory ("hole")
 0008h	belongs to DOS
 FFF7h	386MAX v6.01+ ???
 FFFAh	386MAX UMB control block (see #1164 at AX=4402h"386MAX")
 FFFDh	386MAX locked-out memory
 FFFEh	386MAX UMB (normally immediately follows its control block)
 FFFFh	386MAX v6.01+ device driver

Format of MS-DOS 5+ UMB control block:
Offset	Size	Description	(Table 1316)
 00h	BYTE	type: 5Ah if last block in chain, 4Dh otherwise
 01h	WORD	first available paragraph in UMB if control block at start
		  of UMB, 000Ah if control block at end of UMB
 03h	WORD	length in paragraphs of following UMB or locked-out region
 05h  3 BYTEs	unused
 08h  8 BYTEs	block type name: "UMB" if start block, "SM" if end block in UMB
SeeAlso: #1314,#1317

Format of MS-DOS 7.0 HMA memory control block:
Offset	Size	Description	(Table 1317)
 00h	WORD	signature "MS" (4Dh 53h)
 02h	WORD	usage flag???
		0000h free
		else ???
 04h	WORD	size of memory block in bytes (not counting MCB)
 06h	WORD	offset of next memory block in HMA or 0000h
 08h  8 BYTEs	unused (0)
SeeAlso: #1314,#1316,#1318

Format of STARLITE (General Software's Embedded DOS) memory control block:
Offset	Size	Description	(Table 1318)
 00h	BYTE	block type: 5Ah if last block in chain, otherwise 4Dh
 01h	WORD	PSP segment of owner, 0000h if free, 0008h if belongs to DOS
 03h	WORD	size of memory block in paragraphs
 05h	BYTE	unused
 06h	WORD	segment address of next memory control block (0000h if last)
 08h	WORD	segment address of previous memory control block or 0000h
 0Ah  6 BYTEs	reserved

Format of DOS 4.0+ data segment subsegment control blocks:
Offset	Size	Description	(Table 1319)
 00h	BYTE	subsegment type (blocks typically appear in this order)
		"D"  device driver
		"E"  device driver appendage
		"I"  IFS (Installable File System) driver
		     (MS-DOS 7) high-loaded drive data table array (see #2290)
		"F"  FILES=  control block storage area (for FILES>5)
		"X"  FCBS=   control block storage area, if present
		"C"  BUFFERS EMS workspace area (if BUFFERS /X option used)
		"B"  BUFFERS=  storage area
		"L"  LASTDRIVE=	 current directory structure array storage area
		"S"  STACKS=  code and data area, if present (see #1320,#1321)
		"T"  INSTALL= transient code
 01h	WORD	paragraph of subsegment start (usually the next paragraph)
 03h	WORD	size of subsegment in paragraphs
 05h  3 BYTEs	unused
 08h  8 BYTEs	for types "D" and "I", base name of file from which the driver
		  was loaded (unused for other types)

Format of data at start of STACKS code segment (if present):
Offset	Size	Description	(Table 1320)
 00h	WORD	???
 02h	WORD	number of stacks (the x in STACKS=x,y)
 04h	WORD	size of stack control block array (should be 8*x)
 06h	WORD	size of each stack (the y in STACKS=x,y)
 08h	DWORD	pointer to STACKS data segment
 0Ch	WORD	offset in STACKS data segment of stack control block array
 0Eh	WORD	offset in STACKS data segment of last element of that array
 10h	WORD	offset in STACKS data segment of the entry in that array for
		  the next stack to be allocated (initially same as value in
		  0Eh and works its way down in steps of 8 to the value in
		  0Ch as hardware interrupts pre-empt each other)
Note:	the STACKS code segment data may, if present, be located as follows:
    DOS 3.2:	The code segment data is at a paragraph boundary fairly early
		  in the IBMBIO segment (seen at 0070:0190h)
    DOS 3.3:	The code segment is at a paragraph boundary in the DOS data
		  segment, which may be determined by inspecting the segment
		  pointers of the vectors for those of interrupts 02h, 08h-0Eh,
		  70h, 72-77h which have not been redirected by device drivers
		  or TSRs.
    DOS 4.0+	Identified by sub-segment control block type "S" within the DOS
		  data segment.
SeeAlso: #1322,INT B4"STACKMAN"

Format of array elements in STACKS data segment:
Offset	Size	Description	(Table 1321)
 00h	BYTE	status: 00h=free, 01h=in use, 03h=corrupted by overflow of
		  higher stack.
 01h	BYTE	not used
 02h	WORD	previous SP
 04h	WORD	previous SS
 06h	WORD	ptr to word at top of stack (new value for SP). The word at the
		  top of the stack is preset to point back to this control
		  block.

Format of SHARE.EXE hooks (DOS 3.1-6.00):
Offset	Size	Description	(Table 1322)
(offsets from first system file table--pointed at by ListOfLists+04h)
-3Ch	DWORD	pointer to FAR routine for ???
		Note: not called by MS-DOS 3.3, set to 0000h:0000h by
			SHARE 3.3+
-38h	DWORD	pointer to FAR routine called on opening file
		on call, internal DOS location points at filename
		  (see #1373 at AX=5D06h)
		Return: CF clear if successful
			CF set on error
			    AX = DOS error code (24h)
				  (see #1366 at AH=59h/BX=0000h)
		Note: SHARE directly accesses DOS-internal data to get name of
			file just opened
-34h	DWORD	pointer to FAR routine called on closing file
		ES:DI -> system file table
		Note: does something to every Record Lock Record for file
-30h	DWORD	pointer to FAR routine to close all files for given computer
		(called by AX=5D03h)
-2Ch	DWORD	pointer to FAR routine to close all files for given process
		(called by AX=5D04h)
-28h	DWORD	pointer to FAR routine to close file by name
		(called by AX=5D02h)
		DS:SI -> DOS parameter list (see #1372 at AX=5D00h)
		   DPL's DS:DX -> name of file to close
		Return: CF clear if successful
			CF set on error
			    AX = DOS error code (03h)
				  (see #1366 at AH=59h/BX=0000h)
-24h	DWORD	pointer to FAR routine to lock region of file
		call with BX = file handle
			  ---DOS 3.x---
			  CX:DX = starting offset
			  SI:AX = size
			  ---DOS 4.0+ ---
			  DS:DX -> lock range
					DWORD start offset
					DWORD size in bytes
		Return: CF set on error
			    AL = DOS error code (21h) (see #1366 at AH=59h)
		Note: not called if file is marked as remote
-20h	DWORD	pointer to FAR routine to unlock region of file
		call with BX = file handle
			  ---DOS 3.x---
			  CX:DX = starting offset
			  SI:AX = size
			  ---DOS 4.0+ ---
			  DS:DX -> lock range
					DWORD start offset
					DWORD size in bytes
		Return: CF set on error
			    AL = DOS error code (21h) (see #1366 at AH=59h)
		Note: not called if file is marked as remote
-1Ch	DWORD	pointer to FAR routine to check if file region is locked
		call with ES:DI -> system file table entry for file
			CX = length of region from current position in file
		Return: CF set if any portion of region locked
			    AX = 0021h
-18h	DWORD	pointer to FAR routine to get open file list entry
		(called by AX=5D05h)
		call with DS:SI -> DOS parameter list (see #1372 at AX=5D00h)
			DPL's BX = index of sharing record
			DPL's CX = index of SFT in SFT chain of sharing rec
		Return: CF set on error or not loaded
			    AX = DOS error code (12h) (see #1366 at AH=59h)
			CF clear if successful
			    ES:DI -> filename
			    CX = number of locks owned by specified SFT
			    BX = network machine number
			    DX destroyed
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
		Note: if SFT was opened with inheritance enabled and sharing
			mode 111, does something to all other SFTs owned by
			same process which have the same file open mode and
			sharing record
-08h	DWORD	pointer to FAR routine for closing file
		Note: closes various handles referring to file most-recently
			opened
-04h	DWORD	pointer to FAR routine to update directory info in related SFT
		  entries
		call with ES:DI -> system file table entry for file (see #1327)
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
Notes:	most of the above hooks (except -04h, -14h, -18h, and -3Ch) assume
	  either that SS=DOS DS or SS=DS=DOS DS and directly access
	  DOS-internal data
	sharing hooks are not supported by DR DOS 5-6; they appear to be
	  supported by Novell DOS 7, with a segment of 0000h indicating the
	  DOS data segment
SeeAlso: #1323,#1324

Format of sharing record:
Offset	Size	Description	(Table 1323)
 00h	BYTE	flag
		00h free block
		01h allocated block
		FFh end marker
 01h	WORD	size of block
 03h	BYTE	checksum of pathname (including NUL)
		if sum of ASCII values is N, checksum is (N/256 + N%256)
 04h	WORD	offset in SHARE's DS of first Record Lock Record (see #1324)
 06h	DWORD	pointer to start of system file table chain for file
 0Ah	WORD	unique sequence number
 0Ch	var	ASCIZ full pathname
Note:	not supported by DR DOS SHARE 1.1 and 2.0; will reportedly be
	  supported by Novell DOS 7
SeeAlso: #1322,#1324

Format of SHARE.EXE Record Lock Record:
Offset	Size	Description	(Table 1324)
 00h	WORD	offset in SHARE's DS of next lock table in list or 0000h
 02h	DWORD	offset in file of start of locked region
 06h	DWORD	offset in file of end of locked region
 0Ah	DWORD	pointer to System File Table entry for this file
 0Eh	WORD	PSP segment of lock's owner
---DOS 5+ ---
 10h	WORD	lock type: (00h lock all, 01h lock writes only)
SeeAlso: #1322,#1323,#1325,#1328

Format of DOS 2.x system file tables:
Offset	Size	Description	(Table 1325)
 00h	DWORD	pointer to next file table (offset FFFFh if last)
 04h	WORD	number of files in this table
 06h  28h bytes per file
	Offset	Size	Description
	 00h	BYTE	number of file handles referring to this file
	 01h	BYTE	file open mode (see #1090 at AH=3Dh)
	 02h	BYTE	file attribute
	 03h	BYTE	drive (0 = character device, 1 = A, 2 = B, etc)
	 04h 11 BYTEs	filename in FCB format (no path,no period,blank-padded)
	 0Fh	WORD	???
	 11h	WORD	???
	 13h	DWORD	file size???
	 17h	WORD	file date in packed format (see #1352 at AX=5700h)
	 19h	WORD	file time in packed format (see #1351 at AX=5700h)
	 1Bh	BYTE	device attribute (see #1110 at AX=4400h)
	---character device---
	 1Ch	DWORD	pointer to device driver
	---block device---
	 1Ch	WORD	starting cluster of file
	 1Eh	WORD	relative cluster in file of last cluster accessed
	------
	 20h	WORD	absolute cluster number of current cluster
	 22h	WORD	???
	 24h	DWORD	current file position???
SeeAlso: #1326,#1327,#1328

Format of DOS 3.0 system file tables and FCB tables:
Offset	Size	Description	(Table 1326)
 00h	DWORD	pointer to next file table (offset FFFFh if last)
 04h	WORD	number of files in this table
 06h  38h bytes per file
	Offset	Size	Description
	 00h-1Eh as for DOS 3.1+ (see #1327)
	 1Fh	WORD	byte offset of directory entry within sector
	 21h 11 BYTEs	filename in FCB format (no path/period, blank-padded)
	 2Ch	DWORD	(SHARE.EXE) pointer to previous SFT sharing same file
	 30h	WORD	(SHARE.EXE) network machine number which opened file
			(Windows Enhanced mode DOSMGR uses the virtual machine
			  ID as the machine number; see INT 2F/AX=1683h)
	 32h	WORD	PSP segment of file's owner (first three entries for
			  AUX/CON/PRN contain segment of IO.SYS startup code)
	 34h	WORD	(SHARE.EXE) offset in SHARE code seg of share record
	 36h	WORD	??? apparently always 0000h
SeeAlso: #1325,#1327,#1328

Format of DOS 3.1-3.3x, DR DOS 5.0-6.0 system file tables and FCB tables:
Offset	Size	Description	(Table 1327)
 00h	DWORD	pointer to next file table (offset FFFFh if last)
 04h	WORD	number of files in this table
 06h  35h bytes per file
	Offset	Size	Description
	 00h	WORD	number of file handles referring to this file
	 02h	WORD	file open mode (see AX=6C00h, #1090 at AH=3Dh)
			bit 15 set if this file opened via FCB
	 04h	BYTE	file attribute (see #1107 at AX=4301h)
	 05h	WORD	device info word (see #1110 at AX=4400h)
			bit 15 set if remote file
			bit 14 set means do not set file date/time on closing
			bit 12 set means don't inherit on EXEC
			bits 5-0 drive number for disk files
	 07h	DWORD	pointer to device driver header if character device
			else pointer to DOS Drive Parameter Block
			  (see #1083 at AH=32h)
	 0Bh	WORD	starting cluster of file
	 0Dh	WORD	file time in packed format (see #1351 at AX=5700h)
			not used for character devices in DR DOS
	 0Fh	WORD	file date in packed format (see #1352 at AX=5700h)
			not used for character devices in DR DOS
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
			(see #1041)
	 1Fh	BYTE	number of dir entry within sector (byte offset/32)
	 20h 11 BYTEs	filename in FCB format (no path/period, blank-padded)
	 2Bh	DWORD	(SHARE.EXE) pointer to previous SFT sharing same file
	 2Fh	WORD	(SHARE.EXE) network machine number which opened file
			(Windows Enhanced mode DOSMGR uses the virtual machine
			  ID as the machine number; see INT 2F/AX=1683h)
	 31h	WORD	PSP segment of file's owner (see #1066 at AH=26h)
			  (first three entries for AUX/CON/PRN contain segment
			  of IO.SYS startup code)
	 33h	WORD	offset within SHARE.EXE code segment of
			  sharing record (see #1323) 0000h = none
SeeAlso: #1325,#1326,#1328

Format of DOS 4.0-6.0 system file tables and FCB tables:
Offset	Size	Description	(Table 1328)
 00h	DWORD	pointer to next file table (offset FFFFh if last)
 04h	WORD	number of files in this table
 06h  3Bh bytes per file
	Offset	Size	Description
	 00h	WORD	number of file handles referring to this file
			FFFFh if in use but not referenced
	 02h	WORD	file open mode (see AX=6C00h,#1090 at AH=3Dh)
			bit 15 set if this file opened via FCB
	 04h	BYTE	file attribute (see #1107 at AX=4301h)
	 05h	WORD	device info word (see also #1110 at AX=4400h)
			bit 15 set if remote file
			bit 14 set means do not set file date/time on closing
			bit 13 set if named pipe
			bit 12 set if no inherit
			bit 11 set if network spooler
			bit 7  set if device, clear if file (only if local)
			bits 6-0 as for AX=4400h
	 07h	DWORD	pointer to device driver header if character device
			else pointer to DOS Drive Parameter Block
			  (see #1083 at AH=32h) or REDIR data
	 0Bh	WORD	starting cluster of file (local files only)
	 0Dh	WORD	file time in packed format (see #1351)
	 0Fh	WORD	file date in packed format (see #1352)
	 11h	DWORD	file size
	 15h	DWORD	current offset in file (SFT)
			LRU counters (FCB table, two WORDs)
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
			(Windows Enhanced mode DOSMGR uses the virtual machine
			  ID as the machine number; see INT 2F/AX=1683h)
	 31h	WORD	PSP segment of file's owner (see #1066 at AH=26h)
			  (first three entries for AUX/CON/PRN contain segment
			  of IO.SYS startup code)
	 33h	WORD	offset within SHARE.EXE code segment of
			sharing record (see #1281)  0000h = none
	 35h	WORD	(local) absolute cluster number of last clustr accessed
			(redirector) ???
	 37h	DWORD	pointer to IFS driver for file, 0000000h if native DOS
Note:	the OS/2 2.0 DOS Boot Session does not properly fill in the filename
	  field due to incomplete support for SFTs; the OS/2 2.0 DOS Window
	  does not appear to support SFTs at all
SeeAlso: #1325,#1326,#1327

Format of current directory structure (CDS) (array, LASTDRIVE entries):
Offset	Size	Description	(Table 1329)
 00h 67 BYTEs	ASCIZ path in form X:\PATH (local) or UNC form
		  \\SERVER\PATH (network, see notes below)
 43h	WORD	drive attributes (also see note below) (see also AX=5F07h)
		bit 15: uses network redirector	 \ invalid if 00, installable
		bit 14: physical drive		 / file system if 11
		bit 13: JOIN'ed	  \ path above is true path that would be
		bit 12: SUBST'ed  / needed if not under SUBST or JOIN
		bit  7: remote drive hidden from redirector's assign-list and
			  exempt from network connection make/break commands;
			  set for CD-ROM drives by MSCDEX (not supported by
			  CORELCDX)
 45h	DWORD	pointer to Drive Parameter Block for drive
		  (see #1083 at AH=32h)
---local drives---
 49h	WORD	starting cluster of current directory
		0000h = root, FFFFh = never accessed
 4Bh	WORD	??? seems to be FFFFh always
 4Dh	WORD	??? seems to be FFFFh always
---network drives---
 49h	DWORD	pointer to redirector or REDIRIFS record, or FFFFh:FFFFh
		(DOS 4 only) available for use by IFS driver
 4Dh	WORD	stored user data from INT 21/AX=5F03h
------
 4Fh	WORD	offset in current directory path of backslash corresponding to
		  root directory for drive
		this value specifies how many characters to hide from the
		  "CHDIR" and "GETDIR" calls; normally set to 2 to hide the
		  drive letter and colon, SUBST, JOIN, and networks change it
		  so that only the appropriate portion of the true path is
		  visible to the user
---DOS 4.0+ ---
 51h	BYTE	(DOS 4 only, remote drives) device type
		04h network drive
 52h	DWORD	pointer to IFS driver (DOS 4) or redirector block (DOS 5+) for
		  this drive, 00000000h if native DOS
 56h	WORD	available for use by IFS driver
Notes:	the path for invalid drives is normally set to X:\, but may be empty
	  after JOIN x: /D in DR DOS 5.0 or NET USE x: /D in older LAN versions
	normally, only one of bits 13&12 may be set together with bit 14, but
	  DR DOS 5.0 uses other combinations for bits 15-12: 0111 JOIN,
	  0001 SUBST, 0101 ASSIGN (see #1330)
	Windows for Workgroups 3.11 network sets the path to the local
	  drive and directory even for network drives; in that case the
	  UNC form \\SERVER\SHARE can be obtained with INT 21/AX=5F02h
	  or INT 21/AX=5F46h. LapLink RemoteAccess does the same even for
	  INT 21/AX=5F02h
	SoftWindows on the Macintosh PowerPC sets \\E for the host drive
SeeAlso: #1330,INT 21/AX=71AAh/BL=00h

Format of DR DOS 5.0-6.0 current directory structure entry (array):
Offset	Size	Description	(Table 1330)
 00h 67 BYTEs	ASCIZ pathname of actual root directory for this logical drive
 43h	WORD	drive attributes
		1000h SUBSTed drive
		3000h??? JOINed drive
		4000h physical drive
		5000h ASSIGNed drive
		7000h JOINed drive
		8000h network drive
 45h	BYTE	physical drive number (0=A:) if this logical drive is valid
 46h	BYTE	??? apparently flags for JOIN and ASSIGN
 47h	WORD	cluster number of start of parent directory (0000h = root)
 49h	WORD	entry number of current directory in parent directory
 4Bh	WORD	cluster number of start of current directory
 4Dh	WORD	used for media change detection (details not available)
 4Fh	WORD	cluster number of SUBST/JOIN "root" directory
		0000h if physical root directory
SeeAlso: #1329

Format of Windows NT Current Directory Structure (CDS) (array):
Offset	Size	Description	(Table 1331)
 00h 67 BYTEs	ASCIZ path in form X:\ (does not show either current directory
		  or network path)
 43h  4 BYTEs	???
Note:	the WinNT CDS contains only as many entries as there are local drives,
	  not LASTDRIVE entries.

Format of DOS device driver header:
Offset	Size	Description	(Table 1332)
 00h	DWORD	pointer to next driver, offset=FFFFh if last driver
 04h	WORD	device attributes (see #1333,#1334)
 06h	WORD	device strategy entry point
		call with ES:BX -> request header
		  (see #2284 at INT 2F/AX=0802h)
 08h	WORD	device interrupt entry point
---character device---
 0Ah  8 BYTEs	blank-padded character device name
---block device---
 0Ah	BYTE	number of subunits (drives) supported by driver
 0Bh  7 BYTEs	normally unused; sometimes contains signature to indicate
		  specific drivers:
		"$PCMATA"   PCMCIA driver PCMATA.SYS (see AX=440Dh"DOS 3.2+")
		"AHADDVR"   Adaptec SCSI disk driver ASPIDISK.SYS
		"DBLSPAC"   MS DoubleSpace or DriveSpace
		"DSKREET"   NortonUtils v5+ Diskreet (see INT 2F/AX=FE00h)
		"GFS	"   LapLink III device driver DD.BIN
		"SIDExxx"   PCMCIA driver ATADRV.EXE (see AX=440Dh"DOS 3.2+")
		"STAC-CD"   Stacker/Stacker Anywhere (see AX=4404h"Stacker")
---DoubleSpace/DriveSpace---
 12h  2 BYTEs	signature ",." (2Ch 2Eh)
 14h	var	preloading API entry point
---CD-ROM---
 12h	WORD	reserved, must be 0000h
		appears to be another device chain
 14h	BYTE	drive letter, 01h=A:, etc. (must initially be 00h; this byte
		  is set by MSCDEX when it loads)
 15h	BYTE	number of units
 16h  6 BYTEs	signature 'MSCDnn' where 'nn' is version (currently '00')
		(this field does not exist in most drivers)
SeeAlso: #2238 at INT 25/AX=CDCDh,#2531 at INT 2F/AX=5600h

Bitfields for device attributes (character device):
Bit(s)	Description	(Table 1333)
 15	set (indicates character device)
 14	IOCTL supported (see AH=44h)
 13	(DOS 3.0+) output until busy supported
 12	reserved
 11	(DOS 3.0+) OPEN/CLOSE/RemMedia calls supported
 10-8	reserved
 7	(DOS 5.0+) Generic IOCTL check call supported (driver command 19h)
	(see AX=4410h,AX=4411h)
 6	(DOS 3.2+) Generic IOCTL call supported (driver command 13h)
	(see AX=440Ch,AX=440Dh"DOS 3.2+")
 5	reserved
 4	device is special (use INT 29 "fast console output")
 3	device is CLOCK$ (all reads/writes use transfer record described
	  below)
 2	device is NUL
 1	device is standard output
 0	device is standard input
Note:	for European MS-DOS 4.0, bit 11 also indicates that bits 8-6 contain a
	  version code (000 = DOS 3.0,3.1; 001 = DOS 3.2;
	  010 = European DOS 4.0)
SeeAlso: #1334,#1332

Bitfields for device attributes (block device):
Bit(s)	Description	(Table 1334)
 15	clear (indicates block device)
 14	IOCTL supported
 13	non-IBM format
 12	network device (device is remote)
 11	(DOS 3.0+) OPEN/CLOSE/RemMedia calls supported
 10	reserved
 9	direct I/O not allowed??? (set by DOS 3.3 DRIVER.SYS for "new" drives)
 8	??? set by DOS 3.3 DRIVER.SYS for "new" drives
 7	(DOS 5.0+) Generic IOCTL check call supported (driver command 19h)
	(see AX=4410h,AX=4411h)
 6	(DOS 3.2+) Generic IOCTL call supported (driver command 13h)
	implies support for commands 17h and 18h
	  (see AX=440Ch,AX=440Dh"DOS 3.2+",AX=440Eh,AX=440Fh)
 5-2	reserved
 1	driver supports 32-bit sector addressing (DOS 3.31+)
 0	 reserved
Note:	for European MS-DOS 4.0, bit 11 also indicates that bits 8-6 contain a
	  version code (000 = DOS 3.0,3.1; 001 = DOS 3.2;
	  010 = European DOS 4.0)
SeeAlso: #1333,#1332

Format of DOS 2.x disk buffer:
Offset	Size	Description	(Table 1335)
 00h	DWORD	pointer to next disk buffer, offset = FFFFh if last
		least-recently used buffer is first in chain
 04h	BYTE	drive (0=A, 1=B, etc), FFh if not in use
 05h  3 BYTEs	unused??? (seems always to be 00h 00h 01h)
 08h	WORD	logical sector number
 0Ah	BYTE	number of copies to write (1 for non-FAT sectors)
 0Bh	BYTE	sector offset between copies if multiple copies to be written
 0Ch	DWORD	pointer to DOS Drive Parameter Block (see #1083 at AH=32h)
 10h		buffered data
SeeAlso: #1336,#1338,#1339,#1341

Format of DOS 3.x disk buffer:
Offset	Size	Description	(Table 1336)
 00h	DWORD	pointer to next disk buffer, offset = FFFFh if last
		least-recently used buffer is first in chain
 04h	BYTE	drive (0=A,1=B, etc), FFh if not in use
 05h	BYTE	buffer flags (see #1337)
 06h	WORD	logical sector number
 08h	BYTE	number of copies to write (1 for non-FAT sectors)
 09h	BYTE	sector offset between copies if multiple copies to be written
 0Ah	DWORD	pointer to DOS Drive Parameter Block (see #1083 at AH=32h)
 0Eh	WORD	unused??? (almost always 0)
 10h		buffered data
SeeAlso: #1335,#1338,#1339,#1341

Bitfields for DOS 3.x disk buffer flags:
Bit(s)	Description	(Table 1337)
 7	???
 6	buffer dirty
 5	buffer has been referenced
 4	???
 3	sector in data area
 2	sector in a directory, either root or subdirectory
 1	sector in FAT
 0	boot sector??? (guess)
SeeAlso: #1342

Format of DOS 4.00 (pre UR 25066) disk buffer info:
Offset	Size	Description	(Table 1338)
 00h	DWORD	pointer to array of disk buffer hash chain heads (see #1340)
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
SeeAlso: #1335,#1336,#1339,#1343

Format of DOS 4.01 (from UR 25066 Corrctive Services Disk on) disk buffer info:
Offset	Size	Description	(Table 1339)
 00h	DWORD	pointer to array of disk buffer hash chain heads (see #1340)
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
SeeAlso: #1335,#1336,#1338,#1343

Format of DOS 4.x disk buffer hash chain head (array, one entry per chain):
Offset	Size	Description	(Table 1340)
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

Format of DOS 4.0-6.0 disk buffer:
Offset	Size	Description	(Table 1341)
 00h	WORD	forward ptr, offset only, to next least recently used buffer
 02h	WORD	backward pointer, offset only
 04h	BYTE	drive (0=A,1=B, etc) if bit 7 clear
		SFT index if bit 7 set
		FFh if not in use
 05h	BYTE	buffer flags (see #1342)
 06h	DWORD	logical sector number (local buffers only)
 0Ah	BYTE	number of copies to write
		for FAT sectors, same as number of FATs
		for data and directory sectors, usually 1
 0Bh	WORD	offset in sectors between copies to write for FAT sectors
 0Dh	DWORD	pointer to DOS Drive Parameter Block (see #1083 at AH=32h)
 11h	WORD	size of data in buffer if remote buffer (see also #1342)
 13h	BYTE	reserved (padding)
 14h		buffered data
Note:	for DOS 4.x, all buffered sectors which have the same hash value
	  (computed as the sum of high and low words of the logical sector
	  number divided by the number of disk buffer chains) are on the same
	  doubly-linked circular chain; for DOS 5+, only a single circular
	  chain exists.
	the links consist of offset addresses only, the segment being the same
	  for all buffers in the chain.
SeeAlso: #1335,#1336,#1338

Bitfields for DOS 4.0-6.0 disk buffer flags:
Bit(s)	Description	(Table 1342)
 7	remote buffer
 6	buffer dirty
 5	buffer has been referenced (reserved in DOS 5+)
 4	search data buffer (only valid if remote buffer)
 3	sector in data area
 2	sector in a directory, either root or subdirectory
 1	sector in FAT
 0	reserved
SeeAlso: #1337

Format of DOS 5.0-6.0 disk buffer info:
Offset	Size	Description	(Table 1343)
 00h	DWORD	pointer to least-recently-used buffer header (may be in HMA)
		(see #1341)
 04h	WORD	number of dirty disk buffers
 06h	DWORD	pointer to lookahead buffer, zero if not present
 0Ah	WORD	number of lookahead sectors, else zero (the y in BUFFERS=x,y)
 0Ch	BYTE	buffer location
		00h base memory, no workspace buffer
		01h HMA, workspace buffer in base memory
 0Dh	DWORD	pointer to one-segment workspace buffer in base memory
 11h  3 BYTEs	unused
 14h	WORD	???
 16h	BYTE	flag: INT 24 fail while making an I/O status call
 17h	BYTE	temp storage for user memory allocation strategy during EXEC
 18h	BYTE	counter: number of INT 21 calls for which A20 is off
 19h	BYTE	bit flags
		bit 0: ???
		bit 1: SWITCHES=/W specified in CONFIG.SYS (don't load
			WINA20.SYS when MS Windows 3.0 starts)
		bit 2: in EXEC state (INT 21/AX=4B05h)
 1Ah	WORD	offset of unpack code start (used only during INT 21/AX=4B05h)
 1Ch	BYTE	bit 0 set iff UMB MCB chain linked to normal MCB chain
 1Dh	WORD	minimum paragraphs of memory required by program being EXECed
 1Fh	WORD	segment of first MCB in upper memory blocks or FFFFh if DOS
		  memory chain in base 640K only (first UMB MCB usually at
		  9FFFh, locking out video memory with a DOS-owned memory
		  block)
		the MCB this word points at contains a valid link into high
		  memory even if it is marked with a 'Z' indicating the last
		  memory block
 21h	WORD	paragraph from which to start scanning during memory allocation
SeeAlso: #1338,#1339

(Table 1344)
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
SeeAlso: #1345,#1346

Format of IFS driver list:
Offset	Size	Description	(Table 1345)
 00h	DWORD	pointer to next driver header
 04h  8 BYTEs	IFS driver name (blank padded), as used by FILESYS command
 0Ch  4 BYTEs	???
 10h	DWORD	pointer to IFS utility function entry point (see #1344)
		call with ES:BX -> IFS request (see #1346)
 14h	WORD	offset in header's segment of driver entry point
	???
SeeAlso: #1344,#1346

Format of IFS request block:
Offset	Size	Description	(Table 1346)
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
	 17h  7 BYTEs	???
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
	 22h	DWORD	pointer to IFS open file structure (see #1347)
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
	 22h	DWORD	pointer to IFS open file structure (see #1347)
	 26h	BYTE	seek type (02h = from end)
	 28h	DWORD	offset on call
			returned new absolute position
	---class 05h functions 0Bh,0Ch---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h	DWORD	pointer to IFS open file structure (see #1347)
	 28h	WORD	number of bytes to transfer
			returned bytes actually transferred
	 2Ah	DWORD	transfer address
	---class 05h function 0Dh---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h	DWORD	pointer to IFS open file structure (see #1347)
	 26h	BYTE	file handle???
	 27h	BYTE	unused???
	 28h	WORD	???
	 2Ah	WORD	???
	 2Ch	WORD	???
	 2Eh	WORD	???
	---class 05h function 0Eh---
	 17h  7 BYTEs	???
	 1Eh	DWORD	pointer to ???
	 22h	DWORD	pointer to IFS open file structure (see #1347)
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
	 22h	DWORD	pointer to IFS open file structure (see #1347)
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
	 22h	DWORD	pointer to IFS open file structure (see #1347)
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
 16h	DWORD	pointer to IFS open file structure (see #1347)
 1Ah	BYTE	???
 1Bh	BYTE	unused???
SeeAlso: #1345,#1344,#1347

Format of IFS open file structure:
Offset	Size	Description	(Table 1347)
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

Format of one item in DOS 4.0+ list of special program names:
Offset	Size	Description	(Table 1348)
 00h	BYTE	length of name (00h = end of list)
 01h  N BYTEs	name in format name.ext
 N    2 BYTEs	DOS version to return for program (major,minor)
		(see AH=30h,INT 2F/AX=122Fh)
---DOS 4 only---
 N+2	BYTE	number of times to return fake version number (FFh = always)
Note:	if the name of the executable for the program making the DOS "get
	  version" call matches one of the names in this list, DOS returns the
	  specified version rather than the true version number
--------v-215252-----------------------------
INT 21 - VIRUS - "516"/"Leapfrog" - INSTALLATION CHECK
	AX = 5252h
Return: BX = FFEEh if resident
SeeAlso: AX=4BFFh"Cascade",AX=58CCh
--------D-2153-------------------------------
INT 21 - DOS 2+ internal - TRANSLATE BIOS PARAMETER BLOCK TO DRIVE PARAM BLOCK
	AH = 53h
	DS:SI -> BIOS Parameter Block (see #1349)
	ES:BP -> buffer for Drive Parameter Block (see #1083 at AH=32h)
Return: ES:BP buffer filled
Notes:	for DOS 3.0+, the cluster at which to start searching is set to 0000h
	  and the number of free clusters is set to FFFFh (unknown)
	if the number of sectors per cluster is set to zero, MS-DOS will hang
	  at startup because it computes the internally-used shift count by
	  shifting this value right until the carry flag is set; since this
	  will never happen when the field is zero, MS-DOS hangs
	not supported by Windows NT 3.1

Format of BIOS Parameter Block:
Offset	Size	Description	(Table 1349)
 00h	WORD	number of bytes per sector
 02h	BYTE	number of sectors per cluster
 03h	WORD	number of reserved sectors at start of disk
 05h	BYTE	number of FATs
 06h	WORD	number of entries in root directory
 08h	WORD	total number of sectors
		for DOS 4.0+, set to zero if partition >32M, then set DWORD at
		  15h to actual number of sectors
 0Ah	BYTE	media ID byte (see #1044)
 0Bh	WORD	number of sectors per FAT
---DOS 2.13---
 0Dh	WORD	number of sectors per track
 0Fh	WORD	number of heads
 11h	WORD	number of hidden sectors
---DOS 3.0+ ---
 0Dh	WORD	number of sectors per track
 0Fh	WORD	number of heads
 11h	DWORD	number of hidden sectors
 15h 11 BYTEs	reserved
---DOS 4.0+ ---
 15h	DWORD	total number of sectors if word at 08h contains zero
 19h  6 BYTEs	???
 1Fh	WORD	number of cylinders
 21h	BYTE	device type
 22h	WORD	device attributes (removable or not, etc)
---DR DOS 5+ ---
 15h	DWORD	total number of sectors if word at 08h contains zero
 19h  6 BYTEs	reserved
---European MS-DOS 4.00---
 15h	DWORD	total number of sectors if word at 08h contains zero
		(however, this DOS does not actually implement >32M partitions)
SeeAlso: #1083,#1350

Format of Extended BIOS Parameter Block:
Offset	Size	Description	(Table 1350)
 00h 25 BYTEs	same as standard DOS 4-6 BPB (see #1349)
 19h	DWORD	sectors per FAT if WORD at 0Bh is 0000h
 1Dh	WORD	extended flags
		bits 3-0: the 0-based FAT number of the active FAT
		bits 6-4: reserved (0)
		bit 7: do not mirror active FAT to inactive FATs
 1Fh	WORD	file system version (high byte=major, low byte=minor)
 21h	DWORD	starting cluster number of root directory
 25h	WORD	file system information sector number (see also #1476)
 29h  6 WORDs	reserved
SeeAlso: #1247
--------D-2154-------------------------------
INT 21 - DOS 2+ - GET VERIFY FLAG
	AH = 54h
Return: AL = verify flag
	    00h off
	    01h on (all disk writes verified after writing)
SeeAlso: AH=2Eh
--------v-2154--BX4475-----------------------
INT 21 - VIRUS - "Dual_GtM"/"Ganeu" - INSTALLATION CHECK
	AH = 54h
	BX = 4475h ("Du")
	CX = 616Ch ("al")
Return: BX = 4774h ("Gt") and CX = 4D21h ("M!") if resident
SeeAlso: AX=50FDh"VIRUS",AX=5454h"VIRUS"
--------v-215454-----------------------------
INT 21 - VIRUS - "Dudley" - INSTALLATION CHECK
	AX = 5454h
Return: AX = 0000h if resident
SeeAlso: AX=50FDh"VIRUS",AH=54h/BX=4475h"VIRUS",AX=7BCEh"VIRUS"
--------D-2155-------------------------------
INT 21 - DOS 2+ internal - CREATE CHILD PSP
	AH = 55h
	DX = segment at which to create new PSP
	SI = (DOS 3.0+) value to place in memory size field at DX:[0002h]
Return: AL destroyed
Notes:	creates a "child" PSP rather than making an exact copy of the current
	  PSP; the new PSP's parent pointer is set to the current PSP and the
	  reference count for each inherited file is incremented
	(DOS 2.0+) sets current PSP to DX
	(DOS 3.0+) marks "no inherit" file handles as closed in child PSP
	this function is implemented using the same code as AH=26h, so unlike
	  other DOS 2+ functions, it does not return status in CF, instead
	  returning status in AL as DOS 1.x functions do (but it never puts an
	  explicit return value in AL)
SeeAlso: AH=26h,AH=50h
--------D-2156-------------------------------
INT 21 - DOS 2+ - "RENAME" - RENAME FILE
	AH = 56h
	DS:DX -> ASCIZ filename of existing file (no wildcards, but see below)
	ES:DI -> ASCIZ new filename (no wildcards)
	CL = attribute mask (server call only, see below)
Return: CF clear if successful
	CF set on error
	    AX = error code (02h,03h,05h,11h) (see #1366)
Notes:	allows move between directories on same logical volume
	this function does not set the archive attribute
	  (see #1107 at AX=4301h), which results in incremental backups not
	  backing up the file under its new name
	open files should not be renamed
	(DOS 2.x only) this function renames file by creating a new directory
	  entry with the new name, then marking the old entry deleted
	(DOS 3.0+) allows renaming of directories
	(DOS 3.1+) wildcards are allowed if invoked via AX=5D00h, in which case
	  error 12h (no more files) is returned on success, and both source and
	  destination specs must be canonical (as returned by AH=60h).
	  Wildcards in the destination are replaced by the corresponding char
	  of each source file being renamed.  Under DOS 3.x, the call will fail
	  if the destination wildcard is *.* or equivalent; under DR DOS 5.0,
	  the call will fail with error code 03h if any wildcards are used.
	  When invoked via AX=5D00h, only those files matching the attribute
	  mask in CL are renamed.
	under the FlashTek X-32 DOS extender, the old-name pointer is in DS:EDX
	  and the new-name pointer is in ES:EDI (DS must equal ES)
BUG:	(DR DOS 3.41) when invoked via AX=5D00h, this function will generate
	  a new directory entry with the new name (including any wildcards)
	  which can only be removed with a sector editor
SeeAlso: AH=17h,AX=4301h,AX=5D00h,AH=60h,AH=71h,AX=F257h/SF=04h
--------v-215643------------------------
INT 21 - VIRUS - "PS-MPC.Gold" - INSTALLATION CHECK
	AX = 5643h  ('VC')
Return: AX = 5053h  ('PS') if resident
SeeAlso: AX=33E0h"VIRUS",AX=5741h"VIRUS",AX=6303h"VIRUS"
--------!---Section--------------------------
