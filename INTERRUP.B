INT 28 - DOS 2+ internal - KEYBOARD BUSY LOOP
   This interrupt is called from inside the "get input from keyboard" routine
   in DOS, if and only if it is safe to use INT 21 to access the disk at that
   time.  It is used primarily by the PRINT.COM routines and TSR programs, but
   any number of other routines could be chained to it by saving the original
   vector, and calling it with a FAR call (or just JMPing to it) at the end of
   the new routine.

   The INT 28h handler may invoke any INT 21h function except functions 00h
   through 0Ch (and 50h/51h under DOS 2.xx unless DOS CritErr flag is set).

   Until some program installs its own routine, this interrupt vector simply
   points to an IRET opcode.

Note: supported in OS/2 compatibility box
---------------------------------------------
INT 29 - DOS 2+ internal - FAST PUTCHAR
	AL = character to display
Return: nothing???
Note:	This interrupt is called from the DOS output routines if output is
	going to a device rather than a file, and the device driver's attribute
	word has bit 3 (04h) set to "1".
---------------------------------------------
INT 2A - Microsoft Networks - NETWORK INSTALLATION CHECK
	AH = 00h
Return: AH <> 00h if installed
---------------------------------------------
INT 2A - Microsoft Networks - EXECUTE NETBIOS REQUEST
	AH = 01h
	???
Return: ???
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
INT 2A - Microsoft Networks - EXECUTE NETBIOS
	AH = 04h
	AL = 00h for error retry, 01h for no retry
	ES:BX -> NCB
Return: AX = 0000h for no error
	AH = 01h, AL = error code
---------------------------------------------
INT 2A - Microsoft Networks - GET NETWORK RESOURCE INFORMATION
	AX = 0500h
Return: AX = reserved
	BX = number of network names
	CX = number of commands
	DX = number of sessions
---------------------------------------------
INT 2A - NETBIOS - NETWORK PRINT-STREAM CONTROL
	AH = 06h
	AL = 01h set concatenation mode
	     02h set truncation mode (default)
	     03h truncate print stream now
Return: CF set on error
	    AX = error code
Note: subfunction 03h is equivalent to Ctrl/Alt/keypad-*
---------------------------------------------
INT 2A - MS Networks or NETBIOS - ???
	AX = 2001h
	???
Return: ???
Note: intercepted by DESQview 2.x
---------------------------------------------
INT 2A - Microsoft Networks - BEGIN DOS CRITICAL SECTION
	AH = 80h
	AL = 01h to 06h  critical section number
Note:	SHARE.EXE uses critical section number 01h
---------------------------------------------
INT 2A - Microsoft Networks - END DOS CRITICAL SECTION
	AH = 81h
	AL = 01h to 06h  critical section number
Note:	SHARE.EXE uses critical section number 01h
---------------------------------------------
INT 2A - Microsoft Networks - SERVER HOOK
	AH = 82h
	STACK: AX from call to INT 21
Return: stack unchanged
Note: called by the INT 21h function dispatcher for function 0 and functions
      greater than 0Ch except 59h
---------------------------------------------
INT 2A - Microsoft Networks - KEYBOARD BUSY LOOP
	AH = 84h
Note: similar to DOS's INT 28h
---------------------------------------------
INT 2B - Internal routine for MSDOS (IRET)
---------------------------------------------
INT 2C - Internal routine for MSDOS (IRET)
---------------------------------------------
INT 2D - Internal routine for MSDOS (IRET)
---------------------------------------------
INT 2E - DOS 2+ internal - EXECUTE COMMAND
	DS:SI -> counted CR-terminated command string
Note:	the top-level command.com executes the command
	all registers including SS and SP are destroyed as in INT 21/AH=4Bh
	Since COMMAND.COM processes the string as if typed from the keyboard,
	the transient portion needs to be present, and the calling program
	must ensure that sufficient memory to load the transient portion can
	be allocated by DOS if necessary.
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
Note: eventually calls device driver for spooled device with request 0Ah,
      looping until not busy or timeout
---------------------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - INSTALL CHECK
	AX = 0200h
Return: AL = FFh if installed
---------------------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0201h
Return: nothing???
Note: called by DOS 3.3 PRINT.COM
---------------------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0202h
	???
Return: nothing???
Note: called by DOS 3.3 PRINT.COM
---------------------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0203h
Return: nothing???
Note: called by DOS 3.3 PRINT.COM
---------------------------------------------
INT 2F - Multiplex - PC LAN PROGRAM REDIR/REDIRIFS internal - ???
	AX = 0204h
	???
Return: nothing???
Note: called by DOS 3.3 PRINT.COM
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
Note: this set of functions allows a user program to partially or completely
      override the default critical error handler in COMMAND.COM
SeeAlso: INT 24
---------------------------------------------
INT 2F - Multiplex - DOS 3+ CRITICAL ERROR HANDLER - HANDLE ERROR
	AH = 05h
	AL = extended error code (not zero)
Return: CF clear
	    ES:DI -> ASCIZ error message
	    AL = ???
	CF set: use default error handler
Note:	called at start of COMMAND.COM's default critical error handler if 
	installed by a user program, allowing partial or complete overriding
	of the default error message
SeeAlso: INT 24
---------------------------------------------
INT 2F - Multiplex - ASSIGN - INSTALLATION CHECK
	AX = 0600h
Return: AH <> 00h if installed
---------------------------------------------
INT 2F - Multiplex - ASSIGN - GET MEMORY SEGMENT
	AX = 0601h
Return: ES = segment of ASSIGN work area
---------------------------------------------
INT 2F - Multiplex - DRIVER.SYS support - INSTALLATION CHECK
	AX = 0800h
Return:	AL = 00h not installed, OK to install
	     01h not installed, not OK to install
	     FFh installed
---------------------------------------------
INT 2F - Multiplex - DRIVER.SYS support - ADD NEW BLOCK DEVICE
	AX = 0801h
	DS:DI -> device driver header
Note: moves down list of drivers, copying and modifying word at offset 29h
	device driver appended to driver chain
---------------------------------------------
INT 2F - Multiplex - DRIVER.SYS support - EXECUTE DEVICE DRIVER REQUEST
	AX = 0802h
	ES:BX -> device driver request header (see AX=1510h)
Return: request header updated as per requested operation
---------------------------------------------
INT 2F - Multiplex - SHARE - INSTALLATION CHECK
	AX = 1000h
Return: AL = 00h  not installed, OK to install
	     01h  not installed, not OK to install
	     FFh  installed
Note: values of AL other than 00h appear to put DOS 3.3 SHARE into an infinite
	loop
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
INT 2F - Multiplex - NETWORK REDIRECTOR - ???
	AX = 1105h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - CLOSE REMOTE FILE
	AX = 1106h
	???
Return: ???
SeeAlso: INT 21/AH=3Eh
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - ???
	AX = 1107h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - READ FROM REMOTE FILE
	AX = 1108h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - WRITE TO REMOTE FILE
	AX = 1109h
	???
Return: ???
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
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - GET REMOTE FILE'S ATTRIBUTES
	AX = 110Fh
	???
Return: AX = file attributes
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
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - CREATE REMOTE FILE???
	AX = 1117h
	STACK: WORD ???
Return: ???
Note: one of AX=1117h and AX=1118h probably truncates an existing remote file
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - CREATE REMOTE FILE???
	AX = 1118h
	STACK: WORD ???
Return: ???
Note: one of AX=1117h and AX=1118h probably truncates an existing remote file
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - CHDIR???
	AX = 1119h
	???
Return: ???
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
Return: CF set on error
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - PRINTER SETUP
	AX = 111Fh
	STACK: WORD function
		5E02h  set printer setup
		5E03h  get printer setup
		5E04h  ???
		5E05h  ???
		5E06h  ???
Return: CF set on error
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
	???
Return: CF set on error???
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - ???
	AX = 1124h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - NETWORK REDIRECTOR - ???
	AX = 1125h
	STACK: WORD ???
Return: ???
	CF set on error???
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
Note: can be called only while on DOS internal stack
SeeAlso: INT 21/AH=3Eh
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET INTERRUPT ADDRESS
	AX = 1202h
	STACK: WORD vector number
Return: ES:BX -> interrupt vector
	Stack unchanged
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET DOS DATA SEGMENT
	AX = 1203h
Return: DS = segment of IBMDOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - NORMALIZE PATH SEPARATOR
	AX = 1204h
	STACK: WORD character to normalize
Return: AL = normalized character (forward slash turned to backslash)
	Stack unchanged
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - OUTPUT CHARACTER
	AX = 1205h
	STACK: WORD character to output
Return: Stack unchanged
Note: can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - INVOKE CRITICAL ERROR
	AX = 1206h
Return: AL = 0-3 for Abort, Retry, Ignore, Fail
Note: can be called only from within DOS
SeeAlso: INT 24
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - MAKE DISK BUFFER MOST-RECENTLY USED
	AX = 1207h
	DS:DI -> disk buffer
Return: buffer moved to end of buffer list (least-recently used is first)
Note: can be called only from within DOS
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
Note: can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - ???
	AX = 120Ah
	???
Return: CF set on error???
	AL = ???
Note: can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - ???
	AX = 120Bh
	ES:DI -> system file table entry???
	???
Return: CF set on error
	    AX = error code (20h)
	CF clear if successful
Note: can be called only from within DOS, performs AX=120Ah routine if file
	opened in compatibility mode with inheritance allowed
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - ???
	AX = 120Ch
	???
Return: ???
Note: can be called only from within DOS
      seems to change owner of last-accessed file to calling process
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET DATE AND TIME
	AX = 120Dh
Return: AX = current date in packed format (see INT 21/AX=5700h)
	DX = current time in packed format (see INT 21/AX=5700h)
Note: can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - FREE ALL DISK BUFFERS
	AX = 120Eh
Return: DS:DI -> first disk buffer
Note: can be called only from within DOS
SeeAlso: INT 21/AH=0Dh
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - MAKE BUFFER MOST RECENTLY USED
	AX = 120Fh
	DS:DI -> disk buffer
Return: DS:DI -> next buffer in buffer list
Note: can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - FIND FREE DISK BUFFER
	AX = 1210h
	DS:DI -> first disk buffer to check
Return: DS:DI -> first available disk buffer
	ZF clear if found, set if not found
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - NORMALIZE ASCIZ FILENAME
	AX = 1211h
	DS:SI -> ASCIZ filename to normalize
	ES:DI -> buffer for normalized filename
Return: destination buffer filled with uppercase filename, with slashes turned
	to backslashes
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET LENGTH OF ASCIZ STRING
	AX = 1212h
	ES:DI -> ASCIZ string
Return: CX = length of string
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - UPPERCASE CHARACTER
	AX = 1213h
	STACK: WORD character to convert to uppercase
Return: AL = uppercase character
	Stack unchanged
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
Return: Stack unchanged
Note: can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET ADDRESS OF SYSTEM FCB
	AX = 1216h
	BX = system file table entry number
Return: ES:DI -> system file table entry
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - SET DEFAULT DRIVE ???
	AX = 1217h
	STACK: WORD drive (0 = A:, 1 = B:, etc)
Return: CF set on error
	    (drive > LASTDRIVE)
	CF clear if successful
	    DS:SI -> drive data block for specified drive
	    Stack unchanged
Note: can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET CALLER'S REGISTERS
	AX = 1218h
Return: DS:SI -> saved caller's AX,BX,CX,DX,SI,DI,BP,DS,ES (on stack)
Note: only valid while within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - ???
	AX = 1219h
	STACK: WORD drive (0 = default, 1 = A:, etc)
Return: ???
	Stack unchanged
Note: can be called only from within DOS
	calls function 1217h
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET FILE'S DRIVE
	AX = 121Ah
	DS:SI -> filename
Return: AL = drive (0 = default, 1 = A:, etc, FFh = invalid)
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - SET YEAR/LENGTH OF FEBRUARY
	AX = 121Bh
	CL = year - 1980
Return: AL = number of days in February
Note: requires DS to be set to the DOS code segment
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - CHECKSUM MEMORY
	AX = 121Ch
	DS:SI -> start of memory to checksum
	CX = number of bytes
	DX = initial checksum
Return: DX = checksum
Note: can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - SUM MEMORY
	AX = 121Dh
	DS:SI -> memory to add up
	CX = 0000h
	DX = limit
Return: AL = byte which exceeded limit
	CX = number of bytes before limit exceeded
	DX = remainder after adding first CX bytes
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
	Stack unchanged
Note: can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - GET SYSTEM FILE TABLE NUMBER
	AX = 1220h
	BX = file handle
Return: CF set on error
	    AL = 6 (invalid file handle)
	CF clear if successful
	    BYTE ES:[DI] = system file table entry number for file handle
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - QUALIFY FILE NAME
	AX = 1221h
	DS:SI -> file name to be fully qualified
	ES:DI -> 80-byte buffer for resulting fully-qualified file name
Return: (see INT 21/AH=60h)
Notes:	can be called only from within DOS
	identical to INT 21/AH=60h
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - SET EXTENDED ERROR INFO???
	AX = 1222h
	SS:SI -> 4-byte records
		BYTE	error code, FFh = last record
		BYTE	??? FFh = don't change
		BYTE	??? FFh = don't change
		BYTE	??? FFh = don't change
Return: nothing???
Note:	can be called only from within DOS
---------------------------------------------
INT 2F - Multiplex - DOS 3+ internal - CHECK IF CHARACTER DEVICE???
	AX = 1223h
	???
Return: DS:SI -> device driver with same name as ???
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
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ internal - OPEN FILE
	AX = 1226h
	CL = access mode
	DS:DX -> ASCIZ filename
Return: (see INT 21/AH=3Dh)
Note:	can be called only from within DOS
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
Return: ???
Notes:	can be called only from within DOS
	switches critical error stack, moves BP to AX, and calls INT 21/AH=42h
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
	BX = (DOS 4+) entry point to set (0001h or 0002h)
	DS:SI -> FASTOPEN entry point
Return: CF set if entry point already set
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ internal - IOCTL???
	AX = 122Bh
	DS:SI -> ???
	STACK: WORD ???
Return: ???
	STACK unchanged
Notes:	can be called only from within DOS
	switches critical error stack, moves BP to AX, and calls IOCTL
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ internal - GET DEVICE CHAIN
	AX = 122Ch
Return: BX:AX -> header of second device driver (NUL is first) in driver chain
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
	DS:DX -> ???
	ES:BX -> ???
Return: DS:DX from previous invocation of this function
	ES:BX from previous invocation of this function
---------------------------------------------
INT 2F - Multiplex - NLSFUNC.COM - INSTALLATION CHECK
	AX = 1400h
Return: AL = 00h not installed, OK to install
	     01h not installed, not OK
	     FFh installed
---------------------------------------------
INT 2F - Multiplex - NLSFUNC.COM - ???
	AX = 1401h
	DS:SI -> ???
	BX = ???
	DX = ???
Return: ???
Note: calls INT 2F/AX=1227h under certain circumstances
---------------------------------------------
INT 2F - Multiplex - NLSFUNC.COM - ???
	AX = 1402h
	BP = ???
	DS:SI -> ???
Return: ???
Note: calls INT 2F/AX=1227h under certain circumstances
---------------------------------------------
INT 2F - Multiplex - NLSFUNC.COM - ???
	AX = 1403h
	DS:SI -> ???
	BX = ???
	DX = ???
Return: ???
Note: in DOS 3.3, appears to be identical to subfunction 01h
---------------------------------------------
INT 2F - Multiplex - CDROM - INSTALLATION CHECK
	AX = 1500h
	BX = 0000h
Return: BX = number of CDROM drive letters used
	CX = strating drive letter (0=A:)
Note: this installation check DOES NOT follow the format used by other software
---------------------------------------------
INT 2F - Multiplex - CDROM - GET DRIVE DEVICE LIST
	AX = 1501h
	ES:BX -> bufer to hold drive letter list (5 bytes per drive letter)
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
---------------------------------------------
INT 2F - Multiplex - CDROM - GET ABSTRACT FILE NAME
	AX = 1503h
	ES:BX -> 38-byte buffer for name of abstract file
	CX = drive number (0=A:)
Return: CF set if drive is not a CDROM drive
	    AX = 15 (invalid drive)
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
Note: reserved for development
---------------------------------------------
INT 2F - Multiplex - CDROM - TURN DEBUGGING OFF
	AX = 1507h
	BX = debugging function to disable
Note: reserved for development
---------------------------------------------
INT 2F - Multiplex - CDROM - ABSOLUTE DISK READ
	AX = 1508h
	ES:BX -> buffer
	CX = drive number (0=A:)
	SI:DI = starting sector number
	DX = number of sectors to read
Return: CF set on error
	    AL = error code (15=invalid drive,21=not ready)
---------------------------------------------
INT 2F - Multiplex - CDROM - ABSOLUTE DISK WRITE
	AX = 1509h
	ES:BX -> buffer
	CX = drive number (0=A:)
	SI:DI = starting sector number
	DX = number of sectors to write
Note: corresponds to INT 26h and is currently reserved and nonfunctional
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
---------------------------------------------
INT 2F - Multiplex - CDROM 2.00 - GET MSCDEX.EXE VERSION
	AX = 150Ch
Return: BH = major version
	BL = minor version
Note: MSCDEX.EXE versions prior to 1.02 return BX=0
---------------------------------------------
INT 2F - Multiplex - CDROM 2.00 - GET CDROM DRIVE LETTERS
	AX = 150Dh
	ES:BX -> buffer for drive letter list (1 byte per drive)
Return: buffer filled with drive numbers (0=A:).  Each byte corresponds
	to the drive in the same position for function 1501h
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
	ES:BX -> CD-ROM device driver request header (see below)

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
 0Dh		any additional information starts here

Values for command code:
	00h INIT
	01h MEDIA CHECK (block devices)
	02h BUILD BPB (block devices)
	03h IOCTL INPUT
	04h INPUT
	05h NONDESTRUCTIVE INPUT, NO WAIT
	06h INPUT STATUS
	07h INPUT FLUSH
	08h OUTPUT
	09h OUTPUT WITH VERIFY
	0Ah OUTPUT STATUS
	0Bh OUTPUT FLUSH
	0Ch IOCTL OUTPUT
	0Dh (DOS 3+) DEVICE OPEN
	0Eh (DOS 3+) DEVICE CLOSE
	0Fh (DOS 3+) REMOVABLE MEDIA (block devices)
	10h (DOS 3+) OUTPUT UNTIL BUSY
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
Note: SHELLB.COM and SHELLC.EXE are parts of the DOS 4.x shell
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
	DS:DX -> parm block as for INT 21, AX=440C, CX=037F/035F respectively
Return: CF set on error
	    AX = error code (many non-standard)
	CF clear if successful
	    AX destroyed
Note:	Presumably this is the DOS IOCTL interface to ANSI.SYS
---------------------------------------------
INT 2F - Multiplex - DOS 4+ ANSI.SYS internal - MISC REQUESTS
	AX = 1A02h
	DS:DX -> parameter block
		BYTE  subfunction
		    00h set/reset interlock
			DS:[DX+1] BYTE 00h=reset, 01h=set
			This interlock prevents some of the ANSI.SYS post-
			processing in its hook onto INT 10, AH=00h mode set
		    01h get /L flag
			Result: DS:[DX+2] BYTE = 00h if /L not in effect
					       = 01h if /L in effect
---------------------------------------------
INT 2F - Multiplex - DOS 4+ XMA2EMS.SYS extension internal - INSTALLATION CHECK
	AX = 1B00h
Return: AL = FFh if installed
Note: XMA2EMS.SYS extension is only installed if DOS has page frames to hide.
      This extension hooks onto INT 67 AH=58h and returns from that call data
      which excludes the physical pages being used by DOS.
---------------------------------------------
INT 2F - Multiplex - DOS 4+ XMA2EMS.SYS extens internal - GET HIDDEN FRAME INFO
	AX = 1B01h
	DI = hidden physical page number
Return: AX = FFFFh if failed (no such hidden page)
	AX = 0000h if OK, then
	     ES = segment of page frame
	     DI = physical page number
Note: This corresponds to the data edited out of the INT 67 AH=58h call
---------------------------------------------
INT 2F - Multiplex - XMS - INSTALLATION CHECK
	AX = 4300h
Return: AL = 80h XMS driver installed
	AL <> 80h no driver
Note: XMS gives access to extended memory and noncontiguous/nonEMS memory
      above 640K
---------------------------------------------
INT 2F - Multiplex - XMS - GET DRIVER ADDRESS
	AX = 4310h
Return: ES:BX -> driver entry point

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
Note: HIMEM.SYS requires at least 256 bytes free stack space

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
	    0002h  ???
	    0003h  ???
---------------------------------------------
INT 2F - Multiplex - F-XCHK.EXE
	AX = 4653h
	CX = 0003h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
---------------------------------------------
INT 2F - Multiplex - F-POPUP.EXE
	AX = 4653h
	CX = 0004h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
	    0002h  ???
	    0003h  ???
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
Note: SCRNSAV2.COM is a screen saver for PS/2's with VGA by Alan Ballard
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
Note: EASY-NET is a shareware two-machine serial-port network
---------------------------------------------
INT 2F - Multiplex - WHOA!.COM - INSTALLATION CHECK
	AX = 8900h
Return: AL = 00h not installed
	   = FFh installed
Note: WHOA!.COM is a system slow-down utility by Brad D Crandall
---------------------------------------------
INT 2F - Multiplex - WHOA!.COM - UNINSTALL
	AX = 8901h
Return: AL = FDh successful
	   = FEh error
Note: WHOA!.COM is a system slow-down utility by Brad D Crandall
---------------------------------------------
INT 2F - Multiplex - WHOA!.COM - SET DELAY COUNT
	AX = 8902h
	BX = delay count (larger values slow system down more)
Return: AL = FDh successful
	   = FEh error
Note: WHOA!.COM is a system slow-down utility by Brad D Crandall
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
Note: VIDCLOCK.COM is a memory-resident clock by Thomas G. Hanlin III
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
INT 2F - Multiplex - DISPLAY.SYS DOS 3.3+ internal - ???
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
	DS:BX -> command line:
Return: AL = FFh if this command is a TSR extension to COMMAND.COM
	AL = 00h if the command should be executed as usual
Note:	This apparently provides a mechanism for TSRs to install permanent
	extensions to the command repertoire of COMMAND.COM.  It appears that
	COMMAND.COM makes this call before executing the current command line,
	and does not execute it itself if the return is FFh.

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
Note:	this call requests execution of the command which a previous call to
	AX=AE00h indicated was resident
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ GRAFTABL.COM - INSTALLATION CHECK
	AX = B000h
Return: AL = 00h not installed, OK to install
	   = 01h not installed, not OK to install
	   = FFh installed
---------------------------------------------
INT 2F - Multiplex - DOS 3.3+ GRAFTABL.COM - GET ???
	AX = B001h
	DS:DX -> 4-byte buffer
Return: buffer filled
Note: in DOS 3.30, the buffer was filled with 0130h, 4C3Eh
---------------------------------------------
INT 2F - Multiplex - APPEND - INSTALLATION CHECK
	AX = B700h
Return: AL = 00h not installed
	     FFh if installed
---------------------------------------------
INT 2F - Multiplex - APPEND - ???
	AX = B701h
	???
---------------------------------------------
INT 2F - Multiplex - APPEND - VERSION CHECK
	AX = B702h
Return: AX = FFFFh if DOS 4.0 APPEND
	AL = major version number
	AH = minor version number, otherwise
---------------------------------------------
INT 2F - Multiplex - DOS 4.0 APPEND - GET APPEND PATH
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
---------------------------------------------
INT 2F - Multiplex - Network - SET NEW POST ADDRESS
	AX = B804h
	ES:BX = new post address
---------------------------------------------
INT 2F - Multiplex - Network - ???
	AX = B808h
	???
Return: ???
---------------------------------------------
INT 2F - Multiplex - Network - VERSION CHECK
	AX = B809h
	???
Return: ???
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
Note: direction of search is same as preceding FIND FIRST call
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
Note: diagnostics return values are hardware dependent

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
Note: if return AL = 01h, the IPI supports network redirection
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
INT 2F - Multiplex - SWELL.EXE - TURBO ON "BORLAND SUPPORT"
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

Format of EXEC record:
Offset	Size	Description
 00h	WORD	offset of ASCIZ program name in same segment as EXEC record
 02h	WORD	offset of DOS commandline in same segment as EXEC record
 04h	WORD	segment of environment for child process (see INT 21/AH=26h)
---------------------------------------------
INT 2F - Multiplex - ANARKEY.COM - INSTALLATION CHECK
	AX = E300h
Return: AL = 00h not installed
	     FFh installed
Notes:	ANARKEY.COM is a commandline recall program by Steven Calwas
	E3h is the default function number, but can be set to any value from
	  C0h to FFh.
---------------------------------------------
INT 2F - Multiplex - ANARKEY.COM v2.0 - GET ???
	AX = E301h
Return: DX:BX -> ???
Note:	ANARKEY.COM is a commandline recall program by Steven Calwas

Format of returned data structure:
Offset	Size	Description
 -7   7 BYTEs	signature ('ANARKEY')
 00h	WORD	??? (I see 0001h in v2.0)
 02h	WORD	??? (I see 0001h in v2.0)
 04h	WORD	??? (I see 0 in v2.0)
 06h	WORD	PSP segment of next program loaded
---------------------------------------------
INT 2F - Multiplex - AUTOPARK.COM - INSTALLATION CHECK
	AX = F700h
Return: AL = 00h not installed
	     FFh installed
Note: AUTOPARK.COM is a resident hard disk parker by Alan D. Jones
---------------------------------------------
INT 2F - Multiplex - AUTOPARK.COM - SET PARKING DELAY
	AX = F701h
	BX:CX = 32 bit count of 55ms timer ticks
---------------------------------------------
INT 30 - (NOT A VECTOR!) FAR JMP instruction for CP/M-style calls
	 the CALL 5 entry point does a FAR jump to here
---------------------------------------------
INT 31 - overwritten by CP/M jump instruction in INT 30h
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
Note: multiple calls to hide the cursor will require multiple calls to
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
	size; however, some versions of the Microsoft documentation state that
	the coordinates are rounded
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
Note: when the software cursor is selected, the char/attribute data at the
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
Note: mouse cursor is hidden during updating, and needs to be explicitly turned
	on again
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
Note: when the subroutine is called, it is passed the following values:
	AX = condition mask (same bit assignments as call mask)
	BX = button state
	CX = cursor column
	DX = cursor row
	DI = horizontal mickey count
	SI = vertical mickey count
Note: up to three handlers can be defined by separate calls to this function
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
Note: the cursor will be displayed on the specified page
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
 DCh	Load 8086 Stack with 8087 Registers
 DEh	Load 8087 Registers from 8086 Stack
 E0h	??? (possibly check of form A <= X <= B)
 E2h	???
 E4h	compare TOS/R1 with two POP's
 E6h	compare TOS/R1 with POP
 E8h	FTST (check TOS value)
 EAh	FXAM (check TOS value)
 ECh	Sin
 EEh	Cos
 F0h	ArcTan
 F2h	check TOS value
 F4h	Ln (FLDLN2 to TOS)
 F6h	FLD1 to TOS
 F8h	FLDLG2 to TOS
 FAh	Exp (FLDL2E to TOS)
 FCh	???
 FEh	FLDL2T to TOS
---------------------------------------------
INT 3F - Overlay manager interrupt (Microsoft LINK.EXE)
---------------------------------------------
INT 3F - Microsoft Dynamic Link Library manager
---------------------------------------------
INT 40 - Hard disk - Relocated Floppy Handler (original INT 13h)
SeeAlso: INT 63
---------------------------------------------
INT 40 - Z100 - Master 8259 - Parity error or S100 error
---------------------------------------------
INT 41 - (NOT a vector!) FIXED DISK PARAMS (XT,AT,XT2,XT286,PS except ESDI)
SeeAlso: INT 1E

Format of fixed disk parameters:
Offset	Size	Description
 00h	WORD	cylinders
 02h	BYTE	heads
 03h	WORD	starting reduced write current cylinder (XT only, 0 for others)
 05h	WORD	starting write pre-comp cylinder
 07h	BYTE	maximum ECC burst length
 08h	BYTE	control byte
		   bits 0-2: drive option (XT only, 0 for others)
		   bit 3:    set if more than 8 heads
		   bit 4:    always 0
		   bit 5:    set if manufacturer's defect map on max cylinder+1
		   bit 6:    disable ECC retries
		   bit 7:    disable access retries
 09h	BYTE	standard timeout (XT only, 0 for others)
 0Ah	BYTE	formatting timeout (XT only, 0 for others)
 0Bh	BYTE	timeout for checking drive (XT only, 0 for others)
 0Ch	WORD	landing zone (AT/PS2)
 0Eh	BYTE	sectors/track (AT/PS2)
 0Fh	BYTE	0
---------------------------------------------
INT 41 - Z100 - Master 8259 - Processor Swap
---------------------------------------------
INT 42 - EGA/VGA/PS - Relocated (by EGA) Video Handler (original INT 10h)
---------------------------------------------
INT 42 - Z100 - Master 8259 - Timer
---------------------------------------------
INT 43 - EGA/VGA/PS - User font table
---------------------------------------------
INT 43 - Z100 - Master 8259 - Slave 8259 input
Note: slave runs in special fully nested mode
---------------------------------------------
INT 44 - EGA/VGA/CONV/PS - EGA/PCjr fonts, characters 00h to 7Fh
---------------------------------------------
INT 44 - Novell NetWare - HIGH-LEVEL LANGUAGE API
---------------------------------------------
INT 44 - Z100 - Master 8259 - Serial A
---------------------------------------------
INT 45 - Z100 - Master 8259 - Serial B
---------------------------------------------
INT 46 - Secondary Fixed Disk Params (see INT 41) (AT,XT286,PS except ESDI)
---------------------------------------------
INT 46 - Z100 - Master 8259 - Keyboard, Retrace, and Light Pen
---------------------------------------------
INT 47 - Z100 - Master 8259 - Printer
---------------------------------------------
INT 48 - PCjr - Cordless Keyboard Translation
---------------------------------------------
INT 48 - Z100 - Slave 8259 - S100 vectored line 0
---------------------------------------------
INT 49 - PCjr - Non-keyboard Scan Code Translation Table

Format of translation table:
Offset	Size	Description
 00h	BYTE	number of nonkeyboard scancodes in the table
 01h  N WORDs   high byte 00h (NUL) byte scancode with low order byte
		representing the scancode mapped values relative to their
		input values within the range of 56h through 7Eh
---------------------------------------------
INT 49 - Z100 - Slave 8259 - S100 vectored line 1
---------------------------------------------
INT 4A - AT/CONV/PS - User Alarm
	Invoked by BIOS when real-time clock alarm occurs
---------------------------------------------
INT 4A - Z100 - Slave 8259 - S100 vectored line 2
---------------------------------------------
INT 4B - Z100 - Slave 8259 - S100 vectored line 3
---------------------------------------------
INT 4C - Z100 - Slave 8259 - S100 vectored line 4
---------------------------------------------
INT 4D - Z100 - Slave 8259 - S100 vectored line 5
---------------------------------------------
INT 4E - TI Professional PC - DISK I/O
	used instead of INT 13 on the TI Professional PC
---------------------------------------------
INT 4E - Z100 - Slave 8259 - S100 vectored line 6
---------------------------------------------
INT 4F - Z100 - Slave 8259 - S100 vectored line 7
---------------------------------------------
INT 50 - through 57 - IRQ0-IRQ7 relocated by DESQview
---------------------------------------------
INT 50 - through 57 - IRQ0-IRQ7 relocated by IBM 3278 emulation control program
---------------------------------------------
INT 58 - reserved
---------------------------------------------
INT 59 - GSS Computer Graphics Interface (GSS*CGI)
	DS:DX -> block of 5 array pointers
Return:	CF set on error
	    AX = error code
	CF clear if successful
	    AX = return code
Note: INT 59 is the means by which GSS*CGI language bindings communicate with
      GSS*CGI device drivers and the GSS*CGI device driver controller.	also
      used by the IBM Graphic Development Toolkit
---------------------------------------------
INT 5A - Cluster adapter BIOS entry address
	???
---------------------------------------------
INT 5B - Used by cluster adapter
---------------------------------------------
INT 5C - NETBIOS INTERFACE
	ES:BX -> Network Control Block (see below)
Return: AL = status
	    00h successful
	    01h bad buffer size
	    03h invalid NETBIOS command
	    05h timeout
	    06h receive buffer too small
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
	    FFh NETBIOS busy

Format of Network Control Block:
Offset	Size  Description
 00h	BYTE  ncb_command (see below)
 01h	BYTE  ncb_retcode
 02h	BYTE  ncb_lsn
 03h	BYTE  ncb_num
 04h	DWORD -> ncb_buffer
 08h	WORD  ncb_length
 0Ah 16 BYTEs ncb_callname
 1Ah 16 BYTEs ncb_name
 2Ah	BYTE  ncb_rto
 2Bh	BYTE  ncb_sto
 2Ch	DWORD -> ncb_post  	/* int (far *ncb_post)(); */
 30h	BYTE  ncb_lana_num
 31h	BYTE  ncb_cmd_cplt
 32h 14 BYTEs ncb_reserve

Values for ncb_command field in NCB (or with 80h for non-waiting call):
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
	33h get adapter status
	34h status of all sessions for name
	35h cancel
	36h add group name to name table
	70h unlink from IBM remote program (no F0h function)
	71h send data without ACK
	72h send multiple buffers without ACK
	78h find name
	79h token-ring protocol trace

Format of struc name:
Offset	Size	Description
 00h 16 BYTEs nm_name
 10h	BYTE  nm_num
 11h	BYTE  nm_status

Format of structure astatus:
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
 3Ch 16 name structures  as_name

Note: Sytek PCnet card uses DMA 3.
---------------------------------------------
INT 5C - TOPS INTERFACE
	ES:BX -> Network Control Block
Note: TOPS card uses DMA 1, 3 or none.
---------------------------------------------
INT 5D - reserved
---------------------------------------------
INT 5E - reserved
---------------------------------------------
INT 5F - reserved
---------------------------------------------
INT 60 - FTP Driver - PC/TCP Packet Driver Specification
   The handler for the interrupt will start with a 3-byte jump instruction, 
   followed by the ASCIZ string "PKT DRVR".  To find the interrupt being used
   by the driver, an application should scan through interrupt vectors 60h to
   80h until it finds one with the "PKT DRVR" string.
---------------------------------------------
INT 60 - SYS_PROF.EXE - PROFILER STATUS
	AH = 00h
Return: AX = 0000h    profiling is off
	    otherwise profiling is on
Note: SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
---------------------------------------------
INT 60 - FTP Driver - DRIVER INFO
	AX = 01FFh
	BX = handler returned by function 02h
Return: CF set on error
	    DH = error code (see below)
	CF clear if successful
	    BX = version
	    CH = network interface class (see below)
	    DX = interface type (see below)
	    CL = number
	    DS:SI -> name
	    AL = driver type
		01h basic
		02h extended
		FFh not installed

Values for error code:
	01h invalid handle number
	02h no interfaces of the specified class found
	03h no interfaces of the specified type found
	04h no interfaces of the specified number found
	05h bad packet type
	06h interface does not support multicast messages
	07h this packet driver cannot terminate
	08h invalid receiver mode
	09h insufficient space
	0Ah type accessed but never released
	0Bh bad command
	0Ch packet could not be sent

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
    Class 02h  ProNET-10
	01h Proteon p1300
    Class 03h  IEEE 802.5/ProNet-4
	01h IBM Token-Ring Adapter
	02h Proteon p1340
	03h Proteon p1344
    Class 04h  Omninet
    Class 05h  Appletalk
    Class 06h  Serial Line
    Class 07h  StarLAN
    Class 08h  ARCnet
	01h Datapoint RIM	
---------------------------------------------
INT 60 - SYS_PROF.EXE - TURN PROFILING OFF
	AH = 01h
Note: SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
---------------------------------------------
INT 60 - FTP Driver - ACCESS TYPE
	AH = 02h
	AL = interface class
	BX = interface type
	DL = interface number
	DS:SI -> type
	CX = length of type
	ES:DI -> receiver
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
	    AX = handle	    	

Receiver is called with
	AX = subfunction
	    00h application to return pointer to buffer in ES:DI
		ES:DI = 0000h:0000h means throw away packet
	    01h copy to DS:SI buffer completed
	BX = handle
	CX = buffer length
when a packet is received
---------------------------------------------
INT 60 - SYS_PROF.EXE - TURN PROFILING ON
	AH = 02h
Note: SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
---------------------------------------------
INT 60 - FTP Driver - RELEASE TYPE
	AH = 03h
	BX = handle
Return: CF set on error
	   DH = error code (see AX=01FFh)
	CF clear if successful	
---------------------------------------------
INT 60 - SYS_PROF.EXE - GET ADDRESS OF PROFILING TABLE
	AH = 03h
Return: ES:BX -> profiling table
Note: SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
---------------------------------------------
INT 60 - FTP Driver - SEND PACKET
	AH = 04h
	DS:SI -> buffer
	CX = length
Return: CF set on error
	    DH = error code (see AX=01FFh)
---------------------------------------------
INT 60 - SYS_PROF.EXE - CLEAR PROFILING TABLE
	AH = 04h
Note: SYS_PROF.EXE is the TSR portion of a profiler from Micro Cornucopia #47
---------------------------------------------
INT 60 - FTP Driver - TERMINATE DRIVER FOR HANDLE
	AH = 05h
	BX = handle
Return: CF set on error
	   DH = error code (see AX=01FFh)
---------------------------------------------
INT 60 - FTP Driver - GET ADDRESS
	AH = 06h
	BX = handle
	ES:DI -> buffer
	CX = length
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
	    CX = length	
Note: copies the local net address associated with the handle into the buffer	    
---------------------------------------------
INT 60 - FTP Driver - RESET INTERFACE
	AH = 07h
	BX = handle
Return: CF set on error
	    DH = error code (see AX=01FFh)
---------------------------------------------
INT 60 - 10-NET - LOCK AND WAIT
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
---------------------------------------------
INT 60 - 10-NET - LOCK
	AH = 12h
	AL = drive number or 00h
	ES:SI = Ethernet address or 0000h:0000h
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see also AH=11h)
	    01h semaphore currently logged
Note: unlike function 11h, this function returns immediately
---------------------------------------------
INT 60 - 10-NET - UNLOCK
	AH = 13h
	AL = drive number or 00h
	ES:SI = Ethernet address or 0000h:0000h
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see also AH=11h)
	    1 semaphore not logged
---------------------------------------------
INT 60 - FTP Driver - SET RECEIVE MODE
	AH = 20h
	BX = handle
	CX = mode
	    01h turn off receiver
	    02h receive only packets sent to this interface
	    03h mode 2 plus broadcast packets
	    04h mode 3 plus limited multicast packets
	    05h mode 3 plus all multicast packets
	    06h all packets
Return: CF set on error
	   DH = error code
---------------------------------------------
INT 60 - FTP Driver - GET RECEIVE MODE
	AH = 21h
	BX = handle
Return: CF set on error
	    DH = error code (see AX=01FFh)
	CF clear if successful
	    AX = mode	
---------------------------------------------
INT 60 - FTP Driver - GET STATISTICS
	AH = 24h
	BX = handle
Return: CF set on error
	    DH = error code
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
---------------------------------------------
INT 61 - reserved for user interrupt
---------------------------------------------
INT 62 - reserved for user interrupt
---------------------------------------------
INT 63 - reserved for user interrupt
Note:	some floppy controller BIOSes seem to hook INT 40 and place the old
	value here (more details to come, I hope)
---------------------------------------------
INT 64 - Novell NetWare - LOW-LEVEL API
Note: equivalent to INT 7A
---------------------------------------------
INT 64 - Extended Batch Language v3.14
	AH = function
	    00h to 5Fh chained to previous handler
	    60h to 6Dh reserved, return immediately
	    80h to FFh chained to previous handler
	    6Eh clear ??? counter/flag
	    6Fh return counter/flag that AH=6Eh clears
	    70h ???
		AL = ???
	    71h ???
		AL = ???
	    72h ???
	    73h insert byte at end of keyboard buffer
		AL = byte to insert
	    74h insert byte at front of keyboard buffer
		AL = byte to insert
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
---------------------------------------------
INT 65 - reserved for user interrupt
---------------------------------------------
INT 65 - SD.COM v6.2
   The unregistered version of SD62.COM uses the low byte of this vector to
   count the number of invocations, displaying a registration reminder each
   time after the 20th use.
---------------------------------------------
INT 66 - reserved for user interrupt
---------------------------------------------
INT 66 - THESPLUS - UNINSTALL
	AX = FFFEh
	BX = FFFEh
Return: only if unsuccessful
Note:   installation check is for the interrupt handler to begin with the bytes
	FBh, 9Ch, and the string "THESPLUS" to appear at offset 0005h in the
	interrupt handler segment.
---------------------------------------------
INT 67 - LIM EMS - GET MANAGER STATUS
	AH = 40h
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested by application
Note: this call can be used only after establishing that the EMS driver
      is in fact present
---------------------------------------------
INT 67 - LIM EMS - GET PAGE FRAME SEGMENT
	AH = 41h
Return: AH = 00h function successful
	    BX = segment of page frame
	AH = error code (see AH=40h)
---------------------------------------------
INT 67 - LIM EMS - GET NUMBER OF PAGES
	AH = 42h
Return: AH = 00h function successful
	    BX = number of unallocated pages
	    DX = total number of pages
	AH = error code (see AH=40h)
---------------------------------------------
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
---------------------------------------------
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
---------------------------------------------
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
---------------------------------------------
INT 67 - LIM EMS - GET EMM VERSION
	AH = 46h
Return: AH = status
	    00h successful
		AL = EMM version number
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested
---------------------------------------------
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
---------------------------------------------
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
---------------------------------------------
INT 67 - LIM EMS - reserved - GET I/O PORT ADDRESSES
	AH = 49h
Note: defined in EMS 3.0, but undocumented in EMS 3.2
---------------------------------------------
INT 67 - LIM EMS - reserved - GET TRANSLATION ARRAY
	AH = 4Ah
Note: defined in EMS 3.0, but undocumented in EMS 3.2
---------------------------------------------
INT 67 - LIM EMS - GET NUMBER OF EMM HANDLES
	AH = 4Bh
Return: AH = status
	    00h successful
		BX = number of EMM handles
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h undefined function requested
---------------------------------------------
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
---------------------------------------------
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
---------------------------------------------
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
Note: this function was designed to be used by multitasking operating systems
      and should not ordinarily be used by appplication software.
---------------------------------------------
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
---------------------------------------------
INT 67 - LIM EMS 4.0 - MAP/UNMAP MULTIPLE HANDLE PAGES
	AH = 50h
	AL = subfunction
	    00h
	    01h
	DX = handle
	CX = number of entries in array
	DS:SI -> mapping array
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    83h invalid handle
	    84h undefined function requested
	    8Ah one or more logical pages are invalid
	    8Bh one or more physical pages are invalid
	    8Fh invalid subfunction
---------------------------------------------
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
---------------------------------------------
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
---------------------------------------------
INT 67 - LIM EMS 4.0 - GET/SET HANDLE NAME
	AH = 53h
	AL = subfunction
	    00h get handle name
	       ES:DI -> 8-byte handle name array
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
---------------------------------------------
INT 67 - LIM EMS 4.0 - GET HANDLE DIRECTORY
	AH = 54h
	AL = subfunction
	    00h get handle directory
	       ES:DI -> buffer for handle directory
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
---------------------------------------------
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
---------------------------------------------
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
---------------------------------------------
INT 67 - LIM EMS 4.0 - MOVE/EXCHANGE MEMORY REGION
	AH = 57h
	AL = subfunction
	    00h move memory region
	    01h exchange memory region
	DS:SI -> structure describing source and destination
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
---------------------------------------------
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
---------------------------------------------
INT 67 - LIM EMS 4.0 - GET EXPANDED MEMORY HARDWARE INFORMATION
	AH = 59h
	AL = subfunction
	    00h get hardware configuration array
		ES:DI -> buffer to be filled with array
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
Note: subfunction 00h is for use by operating systems only, and can be
      enabled or disabled at any time by the operating system
---------------------------------------------
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
---------------------------------------------
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
Note: this function is for use by operating systems only, and can be
      enabled or disabled at any time by the operating system
---------------------------------------------
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
Note: this function is for use by operating systems only, and can be
      enabled or disabled at any time by the operating system
---------------------------------------------
INT 67 - LIM EMS 4.0 - PREPARE EXPANDED MEMORY HARDWARE FOR WARM BOOT
	AH = 5Ch
Return: AH = status
	    00h successful
	    80h internal error
	    81h hardware malfunction
	    84h undefined function requested
---------------------------------------------
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
---------------------------------------------
INT 67 - EEMS - GET PHYSICAL WINDOW ARRAY
	AH = 60h
	ES:DI -> buffer
Return: AH = status
	AL = number of entries
	buffer at ES:DI filled
---------------------------------------------
INT 67 - EEMS - GENERIC ACCELERATOR CARD SUPPORT
	AH = 61h
	???
Return: ???
Note: can be used by accelerator card manufacturer to flush RAM cache, ensuring
      that the cache accurately reflects what the processor would see without
      the cache.
---------------------------------------------
INT 67 - EEMS - GET ADDRESSES OF ALL PAGE FRAMES IN SYSTEM
	AH = 68h
	ES:DI -> buffer
Return: AH = status
	AL = number of entries
	buffer at ES:DI filled
Note: equivalent to LIM 4.0 function 58h
---------------------------------------------
INT 67 - EEMS - MAP PAGE INTO FRAME
	AH = 69h
	AL = frame number
	BX = page number
	DX = handle
Return: AH = status
Note: similar to EMS function 44h
---------------------------------------------
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
Note: similar to EMS function 4Eh, except that a subrange of pages can
      be specified
---------------------------------------------
INT 67 - Virtual Control Program Interface - INSTALLATION CHECK
	AX = DE00h
Return: AH = 00h    VCPI is present
	    BH = major version number
	    BL = minor version number
	AH nonzero  VCPI not present
---------------------------------------------
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
---------------------------------------------
INT 67 - Virtual Control Program Interface - GET MAX PHYSICAL MEMORY ADDRESS
	AX = DE02h
Return: AH = 00h  successful
	    EDX = physical address of highest 4K memory page
	AH nonzero: failed
---------------------------------------------
INT 67 - Virtual Control Program Interface - GET NUMBER OF FREE 4K PAGES
	AX = DE03h
Return: AH = 00h  successful
	    EDX = number of free 4K pages
	AH nonzero: failed
Notes:	returns total number of pages available to ALL tasks in system
	also available in protected mode by calling the protected-mode VCPI
	  entry point
---------------------------------------------
INT 67 - Virtual Control Program Interface - ALLOCATE A 4K PAGE
	AX = DE04h
Return: AH = 00h successful
	    EDX = physical address of allocated page
	AH nonzero: failed
Notes:	the client program is responsible for freeing all memory allocated
	  with this call before terminating
	also available in protected mode by calling the protected-mode VCPI
	  entry point
---------------------------------------------
INT 67 - Virtual Control Program Interface - FREE 4K PAGE
	AX = DE05h
	EDX = physical address of 4K page
Return: AH = 00h successful
	AH nonzero: failed
Note:	also available in protected mode by calling the protected-mode VCPI
	entry point
---------------------------------------------
INT 67 - Virtual Control Program Interface - GET PHYS ADDR OF PAGE IN FIRST MB
	AX = DE06h
	CX = page number (linear address shifted right 12 bits)
Return: AH = 00h successful
	    EDX = physical address of page
	AH nonzero: invalid page number (AH = 8Bh recommended)
---------------------------------------------
INT 67 - Virtual Control Program Interface - READ CR0
	AX = DE07h
Return: AH = 00h
	EBX = value of Control Register 0
---------------------------------------------
INT 67 - Virtual Control Program Interface - READ DEBUG REGISTERS
	AX = DE08h
	ES:DI -> array of 8 DWORDs
Return: AH = 00h
	buffer filled with DR0 first, DR7 last, DR4 and DR5 unused
---------------------------------------------
INT 67 - Virtual Control Program Interface - SET DEBUG REGISTERS
	AX = DE09h
	ES:DI -> array of 8 DWORDs holding new values of debug registers
Return: AH = 00h
Note:   values for DR4 and DR5 ignored
---------------------------------------------
INT 67 - Virtual Control Program Interface - GET 8259 INTERRUPT VECTOR MAPPINGS
	AX = DE0Ah
Return: AH = 00h successful
	    BX = first vector used by master 8259 (IRQ0)
	    CX = first vector used by slave 8259 (IRQ8)
	AH nonzero: failed
Note:	CX is undefined in systems without a slave 8259
---------------------------------------------
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
---------------------------------------------
INT 67 - Virtual Control Program Interface - SWITCH TO PROTECTED MODE
	AX = DE0Ch
	ESI = linear address in first megabyte of values for system registers
	interrupts disabled
Return: interrupts disabled
	GDTR, IDTR, LDTR, TR loaded
	SS:ESP must have at least 16 bytes space, and the entry point is
		required to set up a new stack before enabling interrupts
	EAX, ESI, DS, ES, FS, GS destroyed

Note: in protected mode, calling the protected-mode VCPI entry point with 
	AX = DE0Ch
	DS = segment selector from function DE01h
	SS:ESP in first megabyte of linear memory
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
	and interrupts disabled, will switch to virtual86 mode with interrupts
	disabled, all segment registers loaded, and EAX destroyed.

Format of system register values for switch to protected mode:
Offset	Size	Description
 00h	DWORD	value for CR3
 04h	DWORD	linear address in first megabyte of value for GDTR
 08h	DWORD	linear address in first megabyte of value for IDTR
 0Ch	WORD	value for LDTR
 0Eh	WORD	value for TR
 10h	PWORD	CS:EIP of protected mode entry-point
---------------------------------------------
INT 68 - APPC/PC
	AH = 01h
	DS:DX -> control block

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	verb (action)
 0Eh  6 BYTEs	0
 14h	DWORD	(high byte first) return code (see below)
---if verb = 1B00h (DISPLAY)---
 18h	WORD	0
 1Ah  8 BYTEs	(high byte first) logical unit ID
 22h  8 BYTEs	(high byte first) partner logical unit name
 2Ah  8 BYTEs	(high byte first) mode name
 32h	BYTE	logical unit session limit
 33h	BYTE	partner logical unit session limit
 34h	BYTE	mode maximum negotiable session limit
 35h	BYTE	current session limit
 36h	BYTE	minimum negotiated winner limit
 37h	BYTE	maximum negotiated loser limit
 38h	BYTE	active session count
 39h	BYTE	active CONWINNER session count
 3Ah	BYTE	active CONLOSER session count
 3Bh	BYTE	session termination count
 3Ch	BYTE	bit 7: SESSION_TERMINATION_TARGET_DRAIN
		bit 6: SESSION_TERMINATION_SOURCE_DRAIN
---if verb=2000h (Attach Physical Unit)---
 18h	WORD	0
 1Ah	BYTE	version
 1Bh	BYTE	release
 1Ch  8 BYTEs	(high byte first) net name
 24h  8 BYTEs	(high byte first) physical unit name
 2Ch  8 BYTEs	0
 34h	DWORD	pointer to SYSTEM_LOG_EXIT routine, FFFFFFFFh=don't log errors
 38h	DWORD	0
 3Ch	BYTE	00h RETURN_CONTROL: COMPLETE
		01h RETURN_CONTROL: INCOMPLETE
---if verb=2100h (Attach Logical Unit)---
 18h	WORD	70  offset to partner logical unit record
 1Ah  8 BYTEs	(high byte first) logical unit name
 22h  8 BYTEs	(high byte first) logical unit ID
 2Ah	BYTE	logical unit local address
 2Bh	BYTE	logical unit session limit
 2Ch	DWORD	pointer to CREATE_TP_EXIT routine,
		FFFFFFFFh = reject incoming ALLOCATEs
		00000000h = queue ALLOCATEs
 30h	DWORD	0
 34h	DWORD	pointer to SYSTEM_LOG_EXIT routine, FFFFFFFFh=don't log errors
 38h	DWORD	0
 3Ch	BYTE	maximum TPs
 3Dh	BYTE	queue depth
 3Eh	DWORD	pointer to LU_LU_PASSWORD_EXIT routine, FFFFFFFFh=no pswd exit
 42h	DWORD	0
 46h	WORD	total length of partner records
    for each partner logical unit:
	WORD  length of this partner logical unit record
	WORD  42  offset to mode records
      8 BYTEs (high byte first) partner logical unit name
	BYTE  partner logical unit security capabilities
		bit 7: already verified
		bit 6: conversation level security
		bit 5: session level security
	BYTE  partner logical unit session limit
	WORD  partner logical unit maximum MC_SEND_LL
      8 BYTEs (high byte first) partner logical unit DLC name
	BYTE  partner logical unit adapter number
     17 BYTEs (counted string) partner logical unit adapter address
	WORD  total length of mode records
   for each mode:
	WORD  16  length of this mode record
      8 BYTEs (high byte first) mode name
	WORD  RU_SIZE high bound
	WORD  RU_SIZE low bound
	BYTE  mode maximum negotiable session limit
	BYTE  pacing size for receive
---if verb=2200h (Detach Logical Unit)---
 18h  8 BYTEs	(high byte first) logical unit ID
 20h	BYTE	0
---if verb=2700h (Detach Physical Unit)---
 18h	BYTE	00h  type: hard
		01h  type: soft
---if verb=2B00h (Activate DLC)---
 18h  8 BYTEs	(high byte first) DLC name
 20h	BYTE	adapter number

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

Routines defined by LU_LU_PASSWORD_EXIT, CREATE_TP_EXIT, and SYSTEM_LOG_EXIT
pointers are called by pushing the DWORD pointer to the verb on the stack and
then performing a FAR call.

Format of ACCESS_LU_LU_PW verb:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1900h
 0Eh  8 BYTEs	(high byte first) logical unit ID
 16h  8 BYTEs	(high byte first) logical unit name
 1Eh  8 BYTEs	(high byte first) partner logical unit name
 26h 17 BYTEs	(counted string) partner fully qualified logical unit name
 37h	BYTE	password available (0=no, 1=yes)
 38h  8 BYTEs	password

Format of CREATE_TP verb:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2300h
 0Eh  6 BYTEs	0
 14h	DWORD	(high byte first) sense code
		00000000h	Ok
		080F6051h	SECURITY_NOT_VALID
		084B6031h	TP_NOT_AVAIL_RETRY
		084C0000h	TP_NOT_AVAIL_NO_RETRY
		10086021h	TP_NAME_NOT_RECOGNIZED
		10086034h	CONVERSATION_TYPE_MISMATCH
		10086041h	SYNC_LEVEL_NOT_SUPPORTED
 18h  8 BYTEs	(high byte first) TP ID
 20h  8 BYTEs	(high byte first) logical unit ID
 28h	DWORD	(high byte first) conversation ID
 2Ch	BYTE	0 basic conversation, 1 mapped conversation
 2Dh	BYTE	0 no sync level, 1 confirm
 2Eh	BYTE	reserved
 2Fh 65 BYTEs	(counted string) transaction program name
 70h  6 BYTEs	0
 76h	WORD	length of ERROR_LOG_DATA to return
 78h	DWORD	pointer to ERROR_LOG_DATA buffer
 7Ch  8 BYTEs	(high byte first) partner logical unit name
 84h 18 BYTEs	(counted string) partner fully qualified logical unit name
 96h  8 BYTEs	(high byte first) mode name
 9Eh 12 BYTEs	0
 AAh 11 BYTEs	(counted string) password
 B5h 11 BYTEs	(counted string) user ID
 C0h	BYTE	0 verification should be performed
		1 already verified

Format of SYSLOG verb:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2600h
 0Eh 10 BYTEs	0
 18h	WORD	(high byte first) type
 1Ah	DWORD	(high byte first) subtype
 1Eh	DWORD	pointer to ADDITIONAL_INFO
 22h	DWORD	(high byte first) conversation ID
 26h  8 BYTEs	(high byte first) TP ID
 2Eh  8 BYTEs	(high byte first) physical unit or logical unit name
 36h	WORD	length of data
 38h	DWORD	pointer to data
 3Ch	BYTE	0
---------------------------------------------
INT 68 - APPC/PC
	AH = 02h
	DS:DX -> control block

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	verb (action)
 0Eh	BYTE	1 if MC_ (mapped conversation) form of verb
		0 if basic verb
 0Fh  5 BYTEs	reserved (0)
 14h	WORD	(high byte first) primary return code (see below)
 16h	DWORD	(high byte first) error code (see below)
 1Ah  8 BYTEs	(high byte first) TP_ID
 22h	DWORD	(high byte first) conversation ID
---if verb=0100h (Allocate or MC_Allocate)---
 26h	BYTE	(MC_Allocate only) 0 basic conversation
		  		   1 mapped conversation
 27h	BYTE	00h SYNC_LEVEL = none
		01h SYNC_LEVEL = confirm
 28h	WORD	0000h
 2Ah	BYTE	00h RETURN_CONTROL: when session allocated
		01h RETURN_CONTROL: immediate
		02h RETURN_CONTROL: when session free
 2Bh  8 BYTEs	0
 33h  8 BYTEs	(high byte first) partner logical unit name
 3Bh  8 BYTEs	(high byte first) mode name
 43h 65 BYTEs	(counted string) TP name
 84h	BYTE	00h security: none
		01h security: same
		02h security: pgm
 85h 11 BYTEs	0
 90h 11 BYTEs	(counted string) password
 9Bh 11 BYTEs	(counted string) user ID
 A6h	WORD	PIP_DATA length
 A8h	DWORD	pointer to PIP_DATA
---if verb=0300h (Confirm or MC_Confirm)---
 26h	BYTE  request to send received (0=no, 1=yes)
---if verb=0400h (Confirmed or MC_Confirmed), no additional fields---
---if verb=0500h (Deallocate or MC_Deallocate)---
 26h	BYTE	0
 27h	BYTE	type 0 SYNC_LEVEL
		     1 FLUSH
		     2 ABEND_PROC
		     3 ABEND_SVC
		     4 ABEND_TIMER
		     5 ABEND
 28h	WORD	(MC_Deallocate only) length of error log data
 2Ah	DWORD	(MC_Deallocate only) pointer to error log data
---if verb=0600h (Flush or MC_Flush), no additional fields---
---if verb=0700h (Get_Attributes or MC_Get_Attributes)---
 26h  8 BYTEs	(high byte first) logical unit ID
 2Eh	BYTE	0
 2Fh	BYTE	SYNC_LEVEL (0=none, 1=confirm)
 30h  8 BYTEs	(high byte first) mode name
 38h  8 BYTEs	(high byte first) own net name
 40h  8 BYTEs	(high byte first) own logical unit name
 48h  8 BYTEs	(high byte first) partner logical unit name
 50h 18 BYTEs	(counted string) partner's fully qualified logical unit name
 62h	BYTE	0
 63h 11 BYTEs	(counted string) user ID
---if verb=0800h (Get_Type)---
 26h	BYTE	type (0=basic conversation, 1=mapped conversation)
---if verb=0900h (Post_on_Receipt)---
 26h	WORD	maximum length
 28h	BYTE	fill (0=buffer, 1=LL)
---if verb=0A00h (Prepare_to_Receive or MC_Prepare_to_Receive)---
 26h	BYTE	type (0=SYNC_LEVEL, 1=FLUSH)
 27h	BYTE	locks (0=short, 1=long)
---if verb=0B00h (Receive_and_Wait or MC_Receive_and_Wait)---
 26h	BYTE	what received
		00h data
		01h data complete
		02h data incomplete
		03h confirm
		04h confirm send
		05h confirm deallocate
		06h send
 27h	BYTE	(MC_Receive_and_Wait only) fill (0=buffer, 1=LL)
 28h	BYTE	Request_to_Send_Received (0=no, 1=yes)
 29h	WORD	maximum length
 2Bh	WORD	data length
 2Dh	DWORD	pointer to data
---if verb=0C00h (Receive_Immediate or MC_Receive_Immediate)---
 26h	BYTE	what received
		00h data
		01h data complete
		02h data incomplete
		03h confirm
		04h confirm send
		05h confirm deallocate
		06h send
 27h	BYTE	(MC_Receive_Immediate only) fill (0=buffer, 1=LL)
 28h	BYTE	Request_to_Send_Received (0=no, 1=yes)
 29h	WORD	maximum length
 2Bh	WORD	data length
 2Dh	DWORD	pointer to data
---if verb=0E00h (Request_to_Send or MC_Request_to_Send), no other fields---
---if verb=0F00h (Send_Data or MC_Send_Data)---
 26h	BYTE	request to send received (0=no, 1=yes)
 27h	BYTE	0
 28h	WORD	data length
 2Ah	DWORD	pointer to data
---if verb=1000h (Send_Error or MC_Send_Error)---
 26h	BYTE	request to send received (0=no, 1=yes)
 27h	BYTE	type (0=program, 1=SVC)
 28h	DWORD	0
 2Ch	WORD	(MC_Send_Error only) LOG_DATA length
 2Eh	DWORD	(MC_Send_Error only) pointer to LOG_DATA
---if verb=1200h (Test or MC_Test)---
 26h	BYTE	(MC_Test only) test (0=posted, 1=request_to_send received)
		Note: error code has different interpretations for:
			0 posted data
			1 posted not data (primary return code = 0)
			1 bad TP_ID (primary return code = 1)
---if verb=1300h (Wait)---
 26h	BYTE	number of conversations to wait on
		Note: error codes have interpretations as for 1200h above

Values for primary return code:
	0000h  successful
	0001h  parameter check
	0002h  state check
	0003h  allocation error
	0005h  deallocate abended
	0006h  deallocate abended program
	0007h  deallocate abended SVC
	0008h  deallocate abended timer
	0009h  deallocate normal return
	000Ah  data posting blocked
	000Bh  posting not active
	000Ch  PROG_ERROR_NO_TRUNC
	000Dh  PROG_ERROR_TRUNC
	000Eh  PROG_ERROR_PURGING
	000Fh  CONV_FAILURE_RETRY
	0010h  CONV_FAILURE_NO_RETRY
	0011h  SVC_ERROR_NO_TRUNC
	0012h  SVC_ERROR_TRUNC
	0013h  SVC_ERROR_PURGING
	0014h  unsuccessful
	0018h  CNOS partner logical unit reject
	0019h  conversation type mixed
	F001h  APPC disabled
	F002h  APPC busy
	F003h  APPC abended
	F004h  incomplete

Values for error code:
	0001h bad TP ID
	0002h bad conversation ID
	0004h allocation error, no retry
	0005h allocation error, retry
	0006h data area crosses segment boundary
	0010h bad TPN length
	0011h bad CONV length
	0012h bad SYNC level
	0013h bad security selection
	0014h bad return control
	0015h SEC_TOKENS too big
	0016h PIP_LEN incorrect
	0017h no use of SNASVCMG
	0018h unknown partner mode
	0031h confirm: SYNC_NONE
	0032h confirm: bad state
	0033h confirm: NOT_LL_BDY
	0041h confirmed: bad state
	0051h deallocate: bad type
	0052h deallocate: flush bad state
	0053h deallocate: confirm bad state
	0055h deallocate: NOT_LL_BDY
	0057h deallocate: log LL_WRONG
	0061h flush: not send state
	0091h post on receipt: invalid length
	0092h post on receipt: not in receive state
	0093h post on receipt: bad fill
	00A1h prepare to receive:invalid type
	00A2h prepare to receive: unfinished LL
	00A3h prepare to receive: not in send state
	00B1h receive and wait: bad state
	00B2h receive and wait: NOT_LL_BDY
	00B5h receive and wait: bad fill
	00C1h receive immediate: not in receive state
	00C4h receive immediate: bad fill
	00E1h request to send: not in receive state
	00F1h send data: bad LL
	00F2h send data: not in send state
	0102h send error: log LL wrong
	0103h send error: bad type
	0121h test: invalid type
	0122h test: not in receive state
---------------------------------------------
INT 68 - APPC/PC
	AH = 03h
	DS:DX -> control block (see below)

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	verb (action)
 0Eh  6 BYTEs	0
 14h	DWORD	(high byte first) return code (see AH=01h)
 18h	WORD	0
 1Ah  8 BYTEs	(high byte first) logical unit ID
---if verb=2400h (TP Started), control block continues---
 22h  8 BYTEs	(high byte first) TP ID
---if verb=2800h (Get ALLOCATE), control block continues---
 22h	BYTE	type
		00h dequeue
		01h test
 23h	DWORD	pointer to CREATE_TP record
---if verb=2A00h (Change Logical Unit). control block continues---
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
---------------------------------------------
INT 68 - APPC/PC
	AH = 04h
	DS:DX -> control block (see below)

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	verb (action)
		2500h TP_ENDED
		2900h TP_VALID
 0Eh  6 BYTEs	0
 14h	DWORD	(high byte first) return code (see AH=01h)
 18h	WORD	0
 1Ah  8 BYTEs	(high byte first) TP_ID
 22h	DWORD -> CREATE_TP record (only if verb = 2900h)
---------------------------------------------
INT 68 - APPC/PC - TRANSFER MSG DATA
	AH = 05h
	DS:DX -> control block (see below)

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1C00h
 0Eh	BYTE	00h user defined
		01h NMVT
		02h alert subvectors
		03h PDSTATS subvectors
 0Fh  5 BYTEs	0
 14h	DWORD	(high byte first) return code (see AH=01h)
 18h 12 BYTEs	0
 24h	BYTE	if bit 0 clear, add correlation subvector
		if bit 1 clear, add product set ID subvector
		if bit 2 clear, do SYSLOG
		if bit 3 clear, send SSCP_PU_SESSION
 25h	BYTE	0
 26h	WORD	length of data
 28h  N BYTEs	data
---------------------------------------------
INT 68 - APPC/PC - CHANGE NUMBER OF SESSIONS
	AH = 06h
	DS:DX -> control block (see below)

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1500h
 0Eh  6 BYTEs	0
 14h	WORD	(high byte first) primary return code (see AH=02h)
 16h	DWORD	(high byte first) secondary return code (see below, AH=01h)
 1Ah  8 BYTEs	(high byte first) logical unit ID
 22h  8 BYTEs	blanks
 2Ah  8 BYTEs	(high byte first) partner logical unit name
 32h  8 BYTEs	(high byte first) mode name
 3Ah	BYTE	bit 7: use MODE_NAME_SELECT_ALL rather than MODE_NAME
		bit 6: set negotiable values
 3Bh	BYTE	partner logical unit mode session limit
 3Ch	BYTE	minimum CONWINNERS_SOURCE
 3Dh	BYTE	maximum CONWINNERS_TARGET
 3Eh	BYTE	automatic activation
 3Fh	BYTE	0
 40h	BYTE	bit 7: drain target
		bit 6: drain source
		bit 5: target responsible, not source

Values for secondary return code (see also AH=01h):
	  0000h accepted
	  0001h negotiated
	  0003h bad logical unit ID
	  0004h allocation failure, no retry
	  0005h allocation failure, retry
	  0151h can't raise limits
	  0153h all modes must reset
	  0154h bad SNASVCMG limits
	  0155h minimum greater than total
	  0156h mode closed (prim return code = 1)
		CNOS mode closed (prim return code = 18h)
	  0157h bad mode name (prim return code = 1)
		CNOS bad mode name (prim return code = 18h)
	  0159h reset SNA drains
	  015Ah single not SRC response
	  015Bh bad partner logical unit
	  015Ch exceeds maximum allowed
	  015Dh change SRC drains
	  015Eh logical unit detached
	  015Fh CNOS command race reject
---------------------------------------------
INT 68 - APPC/PC - PASSTHROUGH
	AH = 07h
	DS:DX -> control block (format depends on application subsystem)
---------------------------------------------
INT 68 - APPC/PC - ENABLE/DISABLE APPC
	AH = FAh
	AL bit 0 = 0 enable
		   1 disable
---------------------------------------------
INT 68 - APPC/PC - CONVERT
	AH = FBh
	DS:DX -> control block (see below)

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	1A00h
 0Eh  6 BYTEs	0
 14h	DWORD	(high byte first) return code
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
---------------------------------------------
INT 68 - APPC/PC - ENABLE/DISABLE MESSAGE TRACING
	AH = FCh
	AL = 00h disable tracing
	   = 01h enable tracing
		DX = number of bytes to keep (0=all)
---------------------------------------------
INT 68 - APPC/PC - ENABLE/DISABLE API VERB TRACING
	AH = FDh
	AL = 00h disable tracing
	     01h enable tracing
---------------------------------------------
INT 68 - APPC/PC - SET TRACE DESTINATION
	AH = FEh
	AL = trace destinations
	    bit 0  storage (DS:DX -> trace stats record)
	    bit 1  display
	    bit 2  file (trace written to file OUTPUT.PC)
	    bit 3  printer

Format of Trace Statistics Record:
Offset	Size	Description
 00h	DWORD	pointer to storage trace buffer
 04h	WORD	max number of 80-byte records in trace
 06h	WORD	(high-order byte first!) current record number (must init to 0)
 08h	DWORD	(high-order byte first!) number of records written (init to 0)
 0Ch	DWORD	reserved
Note: do not move record while trace is active
---------------------------------------------
INT 68 - APPC/PC - SET PASSTHROUGH
	AH = FFh
	DS:DX -> passthrough exit routine
---------------------------------------------
INT 69 - unused
---------------------------------------------
INT 6A - OPTHELP.COM
Notes:	OPTHELP is an optionally-resident help system for SLR Systems's OPTASM
	  assembler
	may be configured to use any interrupt from 60h to 7Fh
---------------------------------------------
INT 6B - unused
---------------------------------------------
INT 6C - system resume vector (CONVERTIBLE)
---------------------------------------------
INT 6C - DOS 3.2 Realtime Clock update
---------------------------------------------
INT 6D - VGA - internal
Note: used by IBM, Paradise, Video7, and NCR
---------------------------------------------
INT 6E - unused
---------------------------------------------
INT 6F - HP ES-12 EXTENDED BIOS - READ CMOS MEMORY
	BP = 0012h
	AH = 22h
	BL = address of CMOS byte to read
Return: AH = status
	AL = byte read
	BP, DS destroyed
---------------------------------------------
INT 6F - HP ES-12 EXTENDED BIOS - WRITE CMOS MEMORY
	BP = 0012h
	AH = 24h
	BL = address of CMOS byte to write
	AL = new value
Return: AH = status
	BP, DS destroyed
---------------------------------------------
INT 6F - Novell NetWare - PCOX API (3270 PC terminal interface)
---------------------------------------------
INT 6F - 10-NET - LOGIN
	AH = 00h
	DS:DX -> login record
		8 BYTEs user name
		8 BYTEs password
	       12 BYTEs name of SuperStation
Return: CL = security level
	AX = status
	    0000h successful
	    01FFh time out on response
	    02FFh network (hardware) error
	    03FFh invalid password
	    04FFh local rexource not available
	    05FFh server resource not available
	    06FFh already logged in under different name
	    07FFh login security failure (node)
	    08FFh not logged in
	    09FFh position calc error
	    0AFFh receive subfunction not = send subfunction (i.e. read, write)
	    0BFFh request function not in range
	    0CFFh no more server file handle entries left
	    0DFFh no more shared file table entries left
	    0EFFh no more user file handle entries left
	    0FFFh chat permit not on
	    10FFh not a server on request
	    11FFh no transporter board error
	    12FFh time out on send
	    13FFh item not found (spool item not on queue)
	    14FFh dos access incompatible
	    15FFh record already locked
	    16FFh invalid parameter
	    17FFh record lock time out error
	    18FFh currently spooling to named device
	    19FFh dropped receive message (throttle)
	    1AFFh open sharing violation
	    1BFFh no more tuf entries left
	    1CFFh not file owner on open
	    1DFFh read security not passed
	    1EFFh write security not passed
	    1FFFh group security not passed
	    20FFh security file failure
	    21FFh activity file failure
	    22FFh spool cntrl file failure
	    23FFh device not mounted (spooling)
	    24FFh spool file has not been terminated
	    25FFh device not mounted or is not being shared
	    26FFh duplicate node id
	    27FFh file not found error
	    28FFh no more files
	    29FFh unknown internal system error
	    2AFFh print queue is full or corrupted
	    2BFFh invalid function
	    2CFFh invalid handle
	    2DFFh too many files opened
	    2EFFh path not found
	    2FFFh named file is active
/* I've gotten one submission which says FFxxh, and another with xxFFh */
/* I don't know which way around these should be, does somebody else know? */
	    FF01h timeout
	    FF02h network error
	    FF03h invalid password
	    FF04h no local buffer
	    FF05h superstation not available
	    FF06h node already logged in
	    FF07h login not valid from this node
	    FF08h node ID already in use
	    FF16h invalid parameter (bad length, invalid node ID, etc)
	    FF17h record locked by another user
	    FF18h sent message has been dropped
---------------------------------------------
INT 6F - 10-NET - LOGOFF
	AH = 01h
	DS:DX -> superstation ID or nulls (12 bytes)
Return: CX = number of files closed
	AX = status (see AH=00h)
	    FF08h superstation ID not already logged in
---------------------------------------------
INT 6F - 10-NET - STATUS OF NODE
	AH = 02h
	DS:DX -> 512-byte status record (see below)
Return: CF set on error
	    AX = error code (see AH=00h)

Format of node status record:
Offset	Size	Description
 00h  8 BYTEs	user name (0 if none)
 08h	BYTE	station type
		   00h workstation
		   01h superstation
		   02h gateway station
		   03h gateway active
		   04h logged into multiple superstations
		   05h reserved
 09h 24 BYTEs	list of superstations logged into more than one superstation
 21h 12 BYTEs	node ID
 2Dh	WORD	message count for this station (send for user node, receive for
		superstations)
---for superstations only---
 2Fh	WORD	drives allocated (bit 0=A:, bit 1=B:,...)
 31h	BYTE	user service flag
		bit 7: gate
		    6: print permit on
		    4: SUBMIT is on
		    3: mail waiting for node
		    2: calendar waiting for you
		    1: news waiting for you
		    0: mail waiting for you
 32h	BYTE	printers allocated (bit 0=LPT1,...)
 33h	BYTE	number of unprinted spool files
 34h	BYTE	number of opened files
 35h	BYTE	number of logged on nodes
 36h	BYTE	primary drive (1=A:)
 37h	BYTE	reserved
 38h  N BYTEs	list of logged on node IDs (each 12 bytes, max 37 IDs)
1F4h  3 BYTEs	time: sec/min/hrs
1F7h  3 BYTEs	date: day/mon/year-1980
---------------------------------------------
INT 6F - 10-NET - GET ADDRESS OF CONFIGURATION TABLE
	AH = 03h
	DS:DI -> node ID (optional)
Return: ES:BX -> configuration table 

Format of configuration table:
Offset	Size	Description
-41	WORD	local device table address
-39	WORD	extended network error mapping table address
-37	WORD	shared device table address
-35	WORD	mounted device table address
-33	BYTE	receive buffer counter
-32	BYTE	collect buffer counter
-31	WORD	TUF address
-29	BYTE	enable flag
-28	BYTE	FCB keep flag
-27	WORD	reserved
---up to here, 10-Net v3.3---
-25	WORD	count of dropped Send6F
-23	WORD	buffer start address
-21	WORD	comm driver base address
-19	WORD	send/receive retry count
-17	BYTE	number of 550ms loops before timeout
-16	WORD	UFH address
-14	WORD	CDIR address
-12	WORD	LTAB address
-10	WORD	SFH address
-8	WORD	FTAB address
-6	WORD	RLTAB address
-4	WORD	SMI address
-2	WORD	NTAB address
 00h	WORD	address of first CT_DRV
 02h	BYTE	number of DRV entries
 03h  8 BYTEs	login name
 0Bh 12 BYTEs	node ID (blank-padded)
 17h  6 BYTEs	node address
 1Dh	BYTE	flag
 1Eh	BYTE	CT_CFLG (chat permit)
		bit 1: sound bell
		bit 0: CHAT permit
 1Fh	BYTE	CT_PSFLG
		bit 5: PRINT permit
		bit 4: KB initiated
		bit 3: CHAT called FOXPTRM
		bit 2: SUBMIT active
		bit 1: SUBMIT received
		bit 0: SUBMIT permit
 20h	BYTE	in 10Net flag
 21h	WORD	receive message count
 23h	WORD	send message count
 25h	WORD	retry count
 27h	WORD	failed count
 29h	WORD	driver errors
 2Bh	WORD	dropped responses/CHATs
 2Dh  9 BYTEs	LIST ID/NTAB address (3 entries--LPT1-3)
 36h  6 BYTEs	AUX ID/NTAB address (2 entries--COM1-2)
 3Ch	BYTE	active CB channel
 3Dh	BYTE	received 6F messages on queue
 3Eh  9 BYTEs	activity counters for channels 1-9
---beyond here, 10-Net v3.3---
 47h	BYTE	bit 0 = RS232 gate
		    1 = Send6F gate (user set)
 48h	DWORD	pointer into gate (user set)
 4Ch	DWORD	pointer into 10Net send
 50h  N WORDs	addresses of timer blocks
---------------------------------------------
INT 6F - 10-NET - SEND
	AH = 04h
	DS:BX -> record
		12 BYTEs receiving node's ID
			if first byte has high-order bit set, message is
			   directed to the CT_RGATE vector at the receiver
			if second byte is 00h, first byte is taken as a CB
			   channel number and delivered to all nodes on same
			   channel
		   WORD  length of data at DX
	DS:DX -> data (max 1024 bytes)
Return: CF set on error
	    AX = error code (see AH=00h)
---------------------------------------------
INT 6F - 10-NET - RECEIVE
	AH = 05h
	CX = number of seconds before timeout
	DS:DX -> receive buffer (see below)
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
	    AH = FEh if dequeued message is a CB message

Format of receive buffer:
Offset	Size	Description
 00h 12 BYTEs	sending node's ID
 0Ch	WORD	length of message
 0Eh  N BYTEs	message (maximum 1024 bytes)
---------------------------------------------
INT 6F - 10-NET - LOCK HANDLE
	AH = 07h
	BX = file handle
	CX:DX = starting offset in file
	SI = record length
Return: CF set on error
	    AX = error code (see also AH=00h)
		0002h file not found
---------------------------------------------
INT 6F - 10-NET - UNLOCK HANDLE
	AH = 08h
	BX = file handle
	AL = mode
	    00h unlock all
	    01h unlock record at CX:DX
Return: CF set on error
	    AX = error code (see also AH=00h)
		0002h file not found
---------------------------------------------
INT 6F - 10-NET - SUBMIT
	AH = 09h
	DS:BX -> submit record (see below)

Format of submit record:
Offset	Size	Description
 00h 12 BYTEs	destination node ID (must be logged in)
 0Ch	WORD	length+2 of following 'command line' text
 0Eh  N BYTEs	command line text (<=100 bytes), system adds CR
---------------------------------------------
INT 6F - 10-NET - CHAT
	AH = 0Ah
	DS:BX -> control parameters (see below)
	DS:DX -> chat message (see below)

Format of control parameters:
Offset	Size	Description
 00h  8 BYTEs	sender ID, defaults to node's userID if nulls
 08h  8 BYTEs	destination user ID, 'EVERYONE' may be used
 10h 12 BYTEs	destination node ID

Format of chat message:
Offset	Size	Description
 00h	WORD	length+2 of following text
 02h  N BYTEs	text, max 101 bytes
---------------------------------------------
INT 6F - 10-NET - LOCK SEMAPHORE, RETURN IMMEDIATELY
	AH = 0Bh
	AL = drive number or 0
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status
	    00h successful
	    01h semaphore currently locked
	    02h server not responding
	    03h invalid semaphore name
	    04h semaphore list is full
	    05h invalid drive ID
	    06h invalid Ethernet address
	    07h not logged in
	    08h write to network failed
	    09h semaphore already logged in this CPU
Note: same as INT 60/AH=12h
---------------------------------------------
INT 6F - 10-NET - UNLOCK SEMAPHORE
	AH = 0Ch
	AL = drive number or 0
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see also AH=0Bh)
	    01h semaphore not locked
Note: same as INT 60/AH=13h
---------------------------------------------
INT 6F - 10-NET - WHO
	AH = 0Dh
	AL = type code
	    01h return superstations only
	    02h return non-superstations only
	    otherwise return all
	CX = length of data
	DS:DX -> array of records to be filled (see below)
Return: CL = number of records returned (responding stations)

Format of station record:
Offset	Size	Description
 00h 12 BYTEs	node ID
 0Ch	BYTE	flags
		bit 1 = workstation
		    2 = superstation
		    3 = xgate
		    4 = active gate
---if AL = 01h---
 0Dh	BYTE	version number
	WORD	level number of 10Net software in responding node
---if AL = 02h---
 0Dh  8 BYTEs	user ID
 15h	BYTE	version number
 16h	WORD	level number
---------------------------------------------
INT 6F - 10-NET - SPOOL/PRINT
	AH = 0Eh
	DS:DX -> spool/print record (see below)
Return: CF set on error
	    AX = error code (see also AH=00h)
		FF17h device not mounted
		FF18h already spooling to named device

Format of Spool/Print record:
Offset	Size	Description
 00h	WORD	operation code
		   00h initiate spool
		   01h abort print
		   02h close spool
		   03h delete spool
		   04h print
		   05h get report info
		   06h set chat template
		   07h queue
		   08h return queue
		   09h queue non-spooled file for printing
 02h 11 BYTEs	file name in FCB format
---if operation code = 00h or 06h---
 0Dh	BYTE	notification
		bit 7: queue to top
		bit 6: do ID page
		bit 5: no form feed
		bit 4: reserved
		bit 3: explicity queuing only
		bit 2: notify at print completion
		bit 1: notify server operator/reply
		bit 0: notify at print start
 0Eh	BYTE	days to keep (FFh=forever)
 0Fh	BYTE	bits 0,1: device (1=LPT1)
		bits 4-7: remote drive to store spool file (1=A,...)
 10h	WORD	length of following data area
 12h  N BYTEs	up to 64 bytes of description
---if operation code = 03h---
 0Dh  8 BYTEs	user ID to associate with filename
---if operation code = 04h---
 0Dh	WORD	block number
 0Fh  8 BYTEs	user ID to associate with filename
---if operation code = 05h---
 0Dh	BYTE	RRN to start retrieve
 0Eh	BYTE	bits 0,1: local print device (LPTx)
		bit 3: if set, return entries for all users
 0Fh	WORD	length of following area
 11h  N BYTEs	up to 1500 bytes to receive $SCNTL records returned
---if operation code = 07h---
 0Dh	BYTE	queue number
 0Eh	BYTE	bits 0,1: local print device (LPTx)
 0Fh	WORD	number of bytes of test print to be done
 11h	BYTE	code: 01h print device
		      02h test print count
		      03h prn
---if operation code = 08h---
 0Dh	BYTE	queue location or $SCNTL location to start access
			returns next item for access:
				00h-7Fh queued items
				80h-FEh non-queued, non-printed items
				FFh	no more items
 0Eh	WORD	unused
 10h	WORD	length of following area
 12h  N BYTEs	up to 64 bytes to receive $SCNTL records
---if operation code = 09h---
 0Dh  3 BYTEs	unused
 10h  N BYTEs	path to non-spooled file to be queued for printing

Format of $SCNTL record:
Offset	Size	Description
 00h  8 BYTEs	user ID
 08h 11 BYTEs	filename in FCB format
 13h  6 BYTEs	node ID
 19h  3 BYTEs	creation date
 1Ch	BYTE	flags
		bit 7: queue to top
		    6: do ID page
		    5: no form feed at end
		    4: reserved
		    3: explicit queueing only
		    2: notify at completion
		    1: notify server operator/reply
		    0: notify at start
 1Dh	BYTE	retention time in days
 1Eh	BYTE	printing device (LPTx)
 1Fh  3 BYTEs	date last printed (0 = never)
 22h	BYTE	device containing spoolfile
 23h	WORD	bytes to print for test print
 25h	WORD	block number to start print
 27h	BYTE	reserved
---------------------------------------------
INT 6F - 10-NET - ATTACH/DETACH PRINTER
	AH = 10h
	AL = subfunction
	    00h initiate spooling if LPT1 is mounted
	    01h terminate spooling if LPT1 is mounted
---------------------------------------------
INT 6F - 10-NET - LOCK FCB
	AH = 11h
	AL = mode
	    01h sequential
	    02h random
	    03h random block
		CX = number of records
	DS:DX -> FCB
Return: CF set on error
	    AX = error code (see also AH=00h)
		2 file not found
---------------------------------------------
INT 6F - 10-NET - UNLOCK FCB
	AH = 12h
	AL = mode
	    00h sequential
	    01h random
	    02h random block
		CX = number of records
	DS:DX -> FCB
Return: CF set on error
	    AX = error code (see also AH=00h)
		2 file not found
---------------------------------------------
INT 6F - 10-NET v3.3 - GET REMOTE CONFIGURATION TABLE ADDRESS
	AH = 13h
	DS:DX -> node ID, 12 bytes blank-padded
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
	    ES:BX = configuration table address on given machine
---------------------------------------------
INT 6F - 10-NET v3.3 - GET REMOTE MEMORY
	AH = 14h
	BX:SI = address of remote memory
	CX = length (<=1024 bytes)
	DS:DX -> node ID, 12 bytes blank-padded
	DS:DI -> area to receive remote memory image
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
	    CX = amount of memory copied to DS:SI
---------------------------------------------
INT 6F - 10-NET v3.3 - GET SHARED DEVICE ENTRY
	AX = 1501h
	BX = zero-based index
	DS:SI -> node ID, 12 bytes blank-padded
	ES:DI -> 85-byte buffer for shared device table entry (see below)
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
	    ES:DI buffer contains shared device table entry of BXth device:

Format of shared device table entry:
Offset	Size	Description
 00h  8 BYTEs	device
 08h  8 BYTEs	alias
 10h 64 BYTEs	path
 50h  8 BYTEs	password
 58h	BYTE	access
 59h  4 BYTEs	mask
---------------------------------------------
INT 6F - 10-NET v3.3 - SET SHARED DEVICE ENTRY
	AX = 1502h
	DS:SI -> node ID, 12 bytes blank-padded
	ES:DI -> valid shared device table entry
Return: CF set on error
	    AX = error code (see AH=00h)
---------------------------------------------
INT 6F - 10-NET v3.3 - DELETE SHARED DEVICE ENTRY
	AX = 1503h
	BX = zero-based index
	DS:SI -> node ID, 12 bytes blank-padded
Return: CF set on error
	    AX = error code (see AH=00h)
---------------------------------------------
INT 6F - 10-NET v3.3 - MOUNT
	AH = 17h
	AL = local drive number (0=A:)
	BL = remote drive letter or '1'..'3' for LPTn or '4' or '5' for COMx
	DS:DX -> node ID, 12 bytes blank-padded
Return: CF set on error
	    AX = error code (see AH=00h)
---------------------------------------------
INT 6F - 10-NET v3.3 - UNMOUNT
	AH = 18h
	AL = local drive number (0=A:)
	BL = type
	    00h	    disk
	    01h-03h LPTn
	    04h,05h COMx
Return: CF set on error
	    AX = error code (see AH=00h)
---------------------------------------------
INT 70 - IRQ8 - AT/XT286/PS50+ - REAL-TIME CLOCK
---------------------------------------------
INT 71 - IRQ9 - AT/XT286/PS50+ - LAN ADAPTER 1
   rerouted to INT 0A by BIOS
---------------------------------------------
INT 72 - IRQ10 - AT/XT286/PS50+ - RESERVED
---------------------------------------------
INT 73 - IRQ11 - AT/XT286/PS50+ - RESERVED
---------------------------------------------
INT 74 - IRQ12 - PS50+ - MOUSE INTERRUPT
---------------------------------------------
INT 75 - IRQ13 - AT/XT286/PS50+ - 80287 ERROR
   rerouted to INT 02 by BIOS
---------------------------------------------
INT 76 - IRQ14 - AT/XT286/PS50+ - FIXED DISK
---------------------------------------------
INT 77 - IRQ15 - AT/XT286/PS50+ - RESERVED
---------------------------------------------
INT 78 - not used
---------------------------------------------
INT 79 - not used
---------------------------------------------
INT 7A - Novell NetWare - LOW-LEVEL API
	???
---------------------------------------------
INT 7A - AutoCAD Device Interface
	???
---------------------------------------------
INT 7B - Btrieve API
	DS:DX -> 38-byte parameter record (see below)
Return: return code field set
Note:	Btrieve sets low byte of vector to 33h; this serves as the installation
	  check

Format of Btrieve parameter record:
Offset	Size	Description
 00h	DWORD	pointer to data buffer
 04h	WORD	data buffer length
 06h	DWORD	pointer to 90-byte record containing positioning info
		(should be same for all calls for same file)
 0Ah	DWORD	pointer to 38-byte FCB info buffer
		(should be same for all calls for same file)
 0Eh	WORD	function code
		00h open
		01h close
		02h insert
		03h update
		04h delete
		05h get_equal
		06h get_next
		07h get_prev
		08h get_greater
		09h get_gr_eql
		0Ah get_less
		0Bh get_less_eq
		0Ch get_first
		0Dh get_last
		0Eh create
		0Fh stat
		10h extend
		11h set_dir: set directory information
		12h get_dir: get directory information
		13h begin_trans
		14h end_trans
		15h abort_trans
		16h get_pos: get record position number
		17h get_direct: get data by sending record position
		18h step_direct
		19h stop
		1Ah version
		1Bh unlock
		1Ch reset
		1Dh set owner
		1Eh clear owner
		1Fh create supplemental index
		20h drop supplemental index
		21h step first
		22h step last
		23h step next
		31h ???
		37h ???
		38h ???
		39h ???
		3Ah ???
		3Bh ???
		3Ch ???
		3Dh ???
		3Eh ???
		3Fh ???
		adding 100 (64h) or 200 (C8h) appears to result in the same
		  functions with modified behavior
 10h	DWORD	pointer to file name/key buffer
 14h	BYTE	key length
 15h	BYTE	key number
 16h	DWORD	pointer to status code
		status codes:
		00h successful
		01h invalid operation
		02h I/O error
		03h file not open
		04h key value not found
		05h duplicate key value
		06h invalid key number
		07h different key number
		08h invalid positioning
		09h end of file
		0Ah modifiable key value error
		0Bh invalid file name
		0Ch file not found
		0Dh extended file error
		0Eh pre-image open error
		0Fh pre-image I/O error
		10h expansion error
		11h close error
		12h disk full
		13h unrecoverable error
		14h record manager inactive
		15h key buffer too short
		16h data buffer length overrun
		17h position block length
		18h page size error
		19h create I/O error
		1Ah number of keys
		1Bh invalid key position
		1Ch invalid record length
		1Dh invalid key length
		1Eh not a Btrieve file
		1Fh file already extended
		20h extended I/O error
		22h invalid extension name
		23h directory error
		24h transaction error
		25h transaction is active
		26h transaction control file I/O error
		27h end/abort transaction error
		28h transaction max files
		29h operation not allowed
		2Ah incomplete accelerated access
		2Bh invalid record address
		2Ch null key path
		2Dh inconsistent key flags
		2Eh access to file denied
		2Fh maximum open files
		30h invalid alternate sequence definition
		31h key type error
		32h owner already set
		33h invalid owner
		34h error writing cache
		35h invalid interface
		36h variable page error
		37h autoincrement error
		38h incomplete index
		39h expanded memory error
		3Ah compression buffer too short
		3Bh file already exists
		50h conflict
		51h lock error
		52h lost position
		53h read outside transaction
		54h record in use
		55h file in use
		56h file table full
		57h handle table full
		58h incompatible open mode
		5Dh incompatible lock type
		5Eh permission error
 1Ah	WORD	interface code (version specific)
---------------------------------------------
INT 7C - IBM REXX88PC command language
	???
---------------------------------------------
INT 7D - not used
---------------------------------------------
INT 7E - not used
---------------------------------------------
INT 7F - HDILOAD.EXE - 8514/A VIDEO CONTROLLER INTERFACE
	AX = function
	    0105h get entry points
		Return: CX:DX -> array of FAR pointers to entry points
---------------------------------------------
INT 7F - Halo88 - API
	BX = function
		64h arc
		65h bar
		66h box
		67h circle
		68h clr
		69h default hatch style
		6Ah default line style
		6Bh delhcur
		6Ch delln / deltcur
		6Dh ellipse
		6Eh fill
		6Fh flood
		70h flood2
		71h init graphics
		72h init hcur
		73h init marker
		74h init tcur
		75h inqarc
		76h inqbknd
		77h inqclr
		78h inqerr
		79h inqgcur
		7Ah inqhcur
		7Bh inqmarker
		7Dh inqtcur
		7Eh inqtext
		7Fh lnabs
		80h lnrel
		81h markerabs
		82h markerrel
		83h moveabs
		84h movehcurabs
		85h movehcurrel
		86h moverel
		87h movetcurabs
		88h movetcurrel
		89h movefrom
		8Ah moveto
		8Bh pie
		8Ch polylnabs
		8Dh polylnrel
		8Eh ptabs
		8Fh ptrel
		91h setasp
		92h set color
		93h set font
		94h set hatch style
		95h set line style
		97h settext
		98h set text color
		99h btext
		9Ah setseg
		9Bh display
		9Ch setscreen
		9Eh close graphics
		9Fh ftinit
		A0h ftlocate
		A1h ftext
		A5h set viewport
		A6h set window
		A7h set world
		AAh ftcolor
		ACh initlp
		ADh inqasp
		AEh inqdev
		AFh inqdisplay
		B0h inqft
		B1h inqftcolor
		B2h inqinterlace
		B3h inqlpa
		B4h inqlpg
		B5h inqmode
		B6h inqscreen
		B7h inqversion
		B8h roam
		B9h scroll
		BAh setieee
		BBh set interlace
		BCh shift
		BDh start graphics
		BEh vpan
		CBh gwrite
		CCh gread
		CDh setxor
		CEh rbox
		CFh rcir
		D0h rlnabs
		D1h rlnrel
		D2h delbox
		D3h delcir
		D5h setseg2
		DCh worldoff
		DDh mapwtod
		DEh mapdtow
		DFh mapwton
		E0h mapntow
		E1h mapdton
		E2h mapntod
		E3h inqworld
		E4h inqviewport
	        E5h set line width
		E6h lnjoint
		E7h set locator
		E8h read locator
		E9h setdev
		EBh setstext
		ECh setstclr
		EDh setstang
		EEh stext
		EFh inqstext
	        F0h setdegree
		F1h inqstsize
		F2h polyfabs
		F3h polyfrel
		F4h inqdrange
		F5h inqstang
		F6h orglocator
		F7h inqlocator
		F8h inqarea
		F9h setipal
		FAh setborder
		FBh inqcrange
		FEh setclip
		FFh fcir
	       100h setcrange
	       101h setdrange
	       102h setlattr
	       103h polycabs
	       104h polycrel
	       108h memcom
	       109h memexp
	       10Ah memmov
	       10Eh movefx
	       10Fh movetx
	       110h inqrgb
	       111h save image
	       112h restore image
	       113h setapal
	       114h setxpal
	       118h inqtsize
	       12Eh gprint
	       130h setprn
	       131h setpattr
	       133h setbattr
	       135h pexpand
	       136h ptnorm
	       137h pfnorm
	       13Bh inqprn
	       13Ch lopen
	       13Dh lclose
	       13Eh lappend
	       13Fh lrecord
	       140h lswitch
	       142h inqfun
	       15Dh lsetup
	       15Eh lrest
	       15Fh lsave
	additional parameters on stack
Return: ???
Notes:	Halo88 is a suite of graphics routines
	according to Stuart Kemp, the code appears to make no provisions for
	   chaining
---------------------------------------------
INT 7F - HLLAPI (High-Level Language API)
	??? -> parameter control block
Return: ???

Format of parameter control block:
Offset	Size	Description
 00h  3 BYTEs	signature = 'PCB'
 03h	BYTE	function number
 04h	WORD	segment of control string
 06h	WORD	offset of control string
 08h	WORD	length of control string, unless explicit end-of-str char set
 0Ah	BYTE	unused
 0Bh	WORD	return code
 0Dh	WORD	maximum length of control string

Functions:
 00h	Query system (Attachmate implementation only)
 01h	Connect presentation space
 02h	Disconnect presentation space
 03h	Send string of keystrokes as if typed from keyboard
 04h	Wait ~60s, returns status of presentation space
 05h	Copy current presentation space into a user-defined buffer
 06h	Search presentation space for first occurrence of a specified string
 07h	Query cursor location in current presentation space
 08h	Copy part or all of current presentation space into user buffer
 09h	Set session parameters; parameters vary by vendor
 0Ah	Get info on sessions currently connected
 0Bh	Lock current presentation space
 0Ch	Unlock previously locked presentation space
 0Dh	Return copy of operator info area (OIA) of current presentation space
 0Eh	get attribute byte for given position in the current presentation space
 0Fh	copy string of characters to the current presentation space
 10h	workstation control functions
 11h	storage manager functions, intended primarily for BASIC applications
 12h	set delay period in half-second intervals
 14h	get info on level of workstation support used
 15h	reset session parameters to default values
 16h	get detailed info on the current session
 17h	start host notification to application on presentation sp or OIA update
 18h	check host update when host notification enabled
 19h	stop host notification
 1Eh	search field within current presentation space for string
 1Fh	get first positionof a selected field in the current presentation space
 20h	get length of specified field
 21h	copy string into a specified field
 22h	copy specified field into a user-defined buffer
 23h	create alternate presentation space (IBM only), don't use with BASIC
 24h	switch to alternate presentation space (IBM only), not with BASIC
 25h	display cursor in specified area (IBM only), don't use with BASIC
 26h	display alternate presentation space (IBM only), don't use with BASIC
 27h	delete alternate presentation space (IBM only), don't use with BASIC
 32h	start intercepting keystrokes to allow filtering
 33h	get keystrokes after turning on interception
 34h	notify operator when keystroke rejected by filter subroutine
 35h	stop intercepting keystrokes
 5Ah	send file
 5Bh	receive file
 5Ch	run a program
 5Dh	execute DOS command
 63h	change presentation space position to PC display row/col or vice versa
 FFh	Get info on DCA implementation

Session Parameters for function 09h:
 ATTRIB		return attributes in hex
 NOATTRIB	return attributes as blanks
 CONPHYS	make physical connection
 CONLOG		only make logical connection
 EAB		copy extended attribute bytes along with data 
 NOEAB		copy data only
 ESC=n		set escape character to "n" (default '@')
 EOT=n		set end of string character (default 00h)
 FPAUSE		full-duration pause
 IPAUSE		interruptible pause
 STRLEN		use explicit string lengths
 STREOT		use terminated strings
 SRCHALL	search entire presentation space
 SRCHFROM	search from specified offset
 SRCHFRWD	search forward from position 1
 SRCHBKWD	search backward from last position in presentation space
 TWAIT		wait specified time for keyboard ready
 LWAIT		wait until keyboard ready
 NWAIT		no wait
 TRON		enable tracing
 TROFF		disable tracing
 AUTORESET	send reset before sending keys with function 03h
 NORESET	don't send reset
 QUIET		don't display messages sent with INT 21/AH=9
 NOQUIET	allow messages to be displayed
 TIMEOUT=n	set timeout in 30-second intervals, 0 = wait until ^Break
 XLATE		translate extended attribute bytes
 NOXLATE	don't translate
 NEWRET		use HLLAPI v3.0 return code conventions
 OLDRET		use HLLAPI v2.0 return code conventions
---------------------------------------------
INT 80 - Q-PRO4 - ???
---------------------------------------------
INT 80 - reserved for BASIC
---------------------------------------------
INT 81 - reserved for BASIC
---------------------------------------------
INT 82 - reserved for BASIC
---------------------------------------------
INT 83 - reserved for BASIC
---------------------------------------------
INT 84 - reserved for BASIC
---------------------------------------------
INT 85 - reserved for BASIC
---------------------------------------------
INT 86 - Relocated (by NETBIOS) INT 18
---------------------------------------------
INT 86 - used by BASIC while in interpreter
---------------------------------------------
INT 87 - used by BASIC while in interpreter
---------------------------------------------
INT 88 - used by BASIC while in interpreter
---------------------------------------------
INT 89 - used by BASIC while in interpreter
---------------------------------------------
INT 8A - used by BASIC while in interpreter
---------------------------------------------
INT 8B - used by BASIC while in interpreter
---------------------------------------------
INT 8C - used by BASIC while in interpreter
---------------------------------------------
INT 8D - used by BASIC while in interpreter
---------------------------------------------
INT 8E - used by BASIC while in interpreter
---------------------------------------------
INT 8F - used by BASIC while in interpreter
---------------------------------------------
INT 90 - used by BASIC while in interpreter
---------------------------------------------
INT 91 - used by BASIC while in interpreter
---------------------------------------------
INT 92 - used by BASIC while in interpreter
---------------------------------------------
INT 93 - used by BASIC while in interpreter
---------------------------------------------
INT 94 - used by BASIC while in interpreter
---------------------------------------------
INT 95 - used by BASIC while in interpreter
---------------------------------------------
INT 96 - used by BASIC while in interpreter
---------------------------------------------
INT 97 - used by BASIC while in interpreter
---------------------------------------------
INT 98 - used by BASIC while in interpreter
---------------------------------------------
INT 99 - used by BASIC while in interpreter
---------------------------------------------
INT 9A - used by BASIC while in interpreter
---------------------------------------------
INT 9B - used by BASIC while in interpreter
---------------------------------------------
INT 9C - used by BASIC while in interpreter
---------------------------------------------
INT 9D - used by BASIC while in interpreter
---------------------------------------------
INT 9E - used by BASIC while in interpreter
---------------------------------------------
INT 9F - used by BASIC while in interpreter
---------------------------------------------
INT A0 - used by BASIC while in interpreter
---------------------------------------------
INT A1 - used by BASIC while in interpreter
---------------------------------------------
INT A2 - used by BASIC while in interpreter
---------------------------------------------
INT A3 - used by BASIC while in interpreter
---------------------------------------------
INT A4 - used by BASIC while in interpreter
---------------------------------------------
INT A4 - Right Hand Man API
	function number in AH
Note: Right-Hand Man is a TSR desk-top utility, and only hooks this interrupt
	while popped up
---------------------------------------------
INT A5 - used by BASIC while in interpreter
---------------------------------------------
INT A6 - used by BASIC while in interpreter
---------------------------------------------
INT A7 - used by BASIC while in interpreter
---------------------------------------------
INT A8 - used by BASIC while in interpreter
---------------------------------------------
INT A9 - used by BASIC while in interpreter
---------------------------------------------
INT AA - used by BASIC while in interpreter
---------------------------------------------
INT AB - used by BASIC while in interpreter
---------------------------------------------
INT AC - used by BASIC while in interpreter
---------------------------------------------
INT AD - used by BASIC while in interpreter
---------------------------------------------
INT AE - used by BASIC while in interpreter
---------------------------------------------
INT AF - used by BASIC while in interpreter
---------------------------------------------
INT B0 - used by BASIC while in interpreter
---------------------------------------------
INT B1 - used by BASIC while in interpreter
---------------------------------------------
INT B2 - used by BASIC while in interpreter
---------------------------------------------
INT B3 - used by BASIC while in interpreter
---------------------------------------------
INT B4 - used by BASIC while in interpreter
---------------------------------------------
INT B5 - used by BASIC while in interpreter
---------------------------------------------
INT B6 - used by BASIC while in interpreter
---------------------------------------------
INT B7 - used by BASIC while in interpreter
---------------------------------------------
INT B8 - used by BASIC while in interpreter
---------------------------------------------
INT B9 - used by BASIC while in interpreter
---------------------------------------------
INT BA - used by BASIC while in interpreter
---------------------------------------------
INT BB - used by BASIC while in interpreter
---------------------------------------------
INT BC - used by BASIC while in interpreter
---------------------------------------------
INT BD - used by BASIC while in interpreter
---------------------------------------------
INT BE - used by BASIC while in interpreter
---------------------------------------------
INT BF - used by BASIC while in interpreter
---------------------------------------------
INT C0 - used by BASIC while in interpreter
---------------------------------------------
INT C1 - used by BASIC while in interpreter
---------------------------------------------
INT C2 - used by BASIC while in interpreter
---------------------------------------------
INT C3 - used by BASIC while in interpreter
---------------------------------------------
INT C4 - used by BASIC while in interpreter
---------------------------------------------
INT C5 - used by BASIC while in interpreter
---------------------------------------------
INT C6 - used by BASIC while in interpreter
---------------------------------------------
INT C7 - used by BASIC while in interpreter
---------------------------------------------
INT C8 - used by BASIC while in interpreter
---------------------------------------------
INT C9 - used by BASIC while in interpreter
---------------------------------------------
INT CA - used by BASIC while in interpreter
---------------------------------------------
INT CB - used by BASIC while in interpreter
---------------------------------------------
INT CC - used by BASIC while in interpreter
---------------------------------------------
INT CD - used by BASIC while in interpreter
---------------------------------------------
INT CE - used by BASIC while in interpreter
---------------------------------------------
INT CF - used by BASIC while in interpreter
---------------------------------------------
INT D0 - used by BASIC while in interpreter
---------------------------------------------
INT D1 - used by BASIC while in interpreter
---------------------------------------------
INT D2 - used by BASIC while in interpreter
---------------------------------------------
INT D3 - used by BASIC while in interpreter
---------------------------------------------
INT D4 - used by BASIC while in interpreter
---------------------------------------------
INT D5 - used by BASIC while in interpreter
---------------------------------------------
INT D6 - used by BASIC while in interpreter
---------------------------------------------
INT D7 - used by BASIC while in interpreter
---------------------------------------------
INT D8 - used by BASIC while in interpreter
---------------------------------------------
INT D9 - used by BASIC while in interpreter
---------------------------------------------
INT DA - used by BASIC while in interpreter
---------------------------------------------
INT DB - used by BASIC while in interpreter
---------------------------------------------
INT DC - used by BASIC while in interpreter
---------------------------------------------
INT DD - used by BASIC while in interpreter
---------------------------------------------
INT DE - used by BASIC while in interpreter
---------------------------------------------
INT DF - used by BASIC while in interpreter
---------------------------------------------
INT E0 - CP/M-86 function calls
---------------------------------------------
INT E0 - used by BASIC while in interpreter
---------------------------------------------
INT E1 - used by BASIC while in interpreter
---------------------------------------------
INT E2 - used by BASIC while in interpreter
---------------------------------------------
INT E3 - used by BASIC while in interpreter
---------------------------------------------
INT E4 - Logitech Modula v2.0 - MonitorEntry
	AX = 0005h
	BX = priority
---------------------------------------------
INT E4 - Logitech Modula v2.0 - MonitorExit
	AX = 0006h
---------------------------------------------
INT E4 - used by BASIC while in interpreter
---------------------------------------------
INT E5 - used by BASIC while in interpreter
---------------------------------------------
INT E6 - used by BASIC while in interpreter
---------------------------------------------
INT E7 - used by BASIC while in interpreter
---------------------------------------------
INT E8 - used by BASIC while in interpreter
---------------------------------------------
INT E9 - used by BASIC while in interpreter
---------------------------------------------
INT EA - used by BASIC while in interpreter
---------------------------------------------
INT EB - used by BASIC while in interpreter
---------------------------------------------
INT EC - used by BASIC while in interpreter
---------------------------------------------
INT ED - used by BASIC while in interpreter
---------------------------------------------
INT EE - used by BASIC while in interpreter
---------------------------------------------
INT EF - used by BASIC while in interpreter
---------------------------------------------
INT EF - GEM - INTERFACE
	CX = 0473h
	DS:DX -> GEM parameter block
---------------------------------------------
INT F0 - used by BASIC while in interpreter
---------------------------------------------
INT F1 - reserved for user interrupt
---------------------------------------------
INT F2 - reserved for user interrupt
---------------------------------------------
INT F3 - reserved for user interrupt
---------------------------------------------
INT F4 - reserved for user interrupt
---------------------------------------------
INT F5 - reserved for user interrupt
---------------------------------------------
INT F6 - reserved for user interrupt
---------------------------------------------
INT F7 - reserved for user interrupt
---------------------------------------------
INT F8 - 10 ms INTERVAL TIMER (TANDY???)
---------------------------------------------
INT F9 - reserved for user interrupt
---------------------------------------------
INT FA - USART READY (RS-232C) (TANDY???)
---------------------------------------------
INT FB - USART Rx READY (keyboard) (TANDY???)
---------------------------------------------
INT FC - reserved for user interrupt
---------------------------------------------
INT FD - reserved for user interrupt
---------------------------------------------
INT FE - AT/XT286/PS50+ - destroyed by return from protected mode
---------------------------------------------
INT FF - AT/XT286/PS50+ - destroyed by return from protected mode
---------------------------------------------
INT FF - Z100 - WARM BOOT
---------------------------------------------
Please redistribute the following files unmodified as a group, in an archive
named INTER589:
	INTERRUP.1ST	the read-me file, containing credits, availability info
	INTERRUP.A	INT 00 through INT 27
	INTERRUP.B	INT 28 through INT FF
	INTERRUP.PRI	a brief introduction to interrupts
	INTPRINT.COM	a simple formatter that also generates the list summary
	INTPRINT.DOC	instructions for INTPRINT
	INTPRINT.C	source code for INTPRINT
---------------------------------------------
ARPA: ralf@cs.cmu.edu			 \
UUCP: {ucbvax,harvard}!cs.cmu.edu!ralf	  > preferred
BIT:  ralf%cs.cmu.edu@cmuccvb		 /
FIDO: Ralf Brown 1:129/46 (new address!)
	or post a message to the DR_DEBUG echo
CIS:  >INTERNET:ralf@cs.cmu.edu  is supposed to work
